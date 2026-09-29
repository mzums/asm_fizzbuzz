section .data
    filename db "/dev/urandom", 0

section .bss                ; not initialized variables
    random_num resb 1       ; resb — reserve byte - reserves 1 byte of memory

section .text
    global _start

_start:
    ; open("/dev/urandom", O_RDONLY)
    mov rax, 2              ; sys_open
    ; mov rdi, filename     returns a warning   (use absolute address)
    ; lea = Load Effective Address
    lea rdi, [rel filename] ; path              (use relative address)
    xor rsi, rsi            ; O_RDONLY
    xor rdx, rdx
    syscall

    ; read(fd, random_num, 1)
    mov rdi, rax            ; fd
    mov rax, 0              ; sys_read
    mov rsi, random_num
    mov rdx, 1
    syscall

    ; random_num = 0..255
    movzx eax, byte [random_num]

    ; 0..99
    xor edx, edx
    mov ecx, 100
    div ecx

    ; EDX = 0..99
    inc edx

    ; exit(0)
    xor edi, edx
    mov eax, 60
    syscall


; rax:
;   0 - read
;   1 - write
;   2 - open
;   3 - close
;  60 - exit