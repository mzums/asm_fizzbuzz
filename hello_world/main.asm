section .data       ; initializing data
    msg db "Hello, world!", 10      ; 10 at the end is a \n

    ; equ defines a constant value
    ; $ is the current address
    ; - is subtraction
    ; msg is the address of the beginning of the string
    len equ $ - msg

section .text       ; executable code starts here
    global _start   ; start should be visible outside of this file

_start:
    ; syscall number 1 (write)
    mov rax, 1      ; 1 in rax is syscall write
    ; first argument = stdout
    mov rdi, 1      ; 1 in rdi is stdout 
    ; second argument = text address
    mov rsi, msg
    ; third argument = text len
    mov rdx, len
    ; run
    syscall         ; executes rax(rdi, rsi, rdx)

    mov rax, 60     ; syscall exit
    xor rdi, rdi    ; exit status = 0
    ; exit with status 0
    syscall         ; executes rax(rdi)


; syscalls:
;   0 - read
;   1 - write
;  60 - exit
; 231 - exit_group