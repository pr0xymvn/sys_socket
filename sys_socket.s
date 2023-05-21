BITS 64



global _print_create_socket

struc sockaddr_in
    .sin_family resw 1
    .sin_port resw 1
    .sin_addr resd 1
    .sin_zero resb 8
endstruc

istruc sockaddr_in
	at sockaddr_in.sin_addr, dd 0x100007f
	at sockaddr_in.sin_port, dw 0x9a02
	at sockaddr_in.sin_family, dw 2
	at sockaddr_in.sin_zero, dd 0, 0
iend

section .rodata
	print_sock_creat db "Creation of socket", 10,0
	print_sock_creat_len equ $-print_sock_creat


section .text


_print_create_socket:
	mov rax, 0x1
	mov rdi, 1
	mov rsi, print_sock_creat
	mov rdx, print_sock_creat_len
	syscall
	call _emptyRegister
	jmp _create_sock
 
_create_sock:	
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall
	push rax
	jmp _connect2socket

_connect2socket:
	mov rax, 42
	pop rsi
	mov rdi, rsi
	mov rsi, sockaddr_in
	mov rdx, 1
	syscall
	jmp _exit

_exit:
	mov rax, 0x3C
	mov rdi, 0
	syscall

_emptyRegister:
	xor rax, rax
	xor rdi, rdi
	xor rsi, rsi
	xor rdx, rdx
	ret
