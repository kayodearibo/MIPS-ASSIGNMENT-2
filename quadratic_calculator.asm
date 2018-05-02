.data
     msg1:  .asciiz "THIS PROGRAM COMPUTE THE ROOT OF X1 AND X2 IN A QUADRATIC EQUATION\nSO DO WELL TO ENTER THE VALUE FOR A,B,C. THANKS!\n"
     msg2:  .asciiz "ENTER VALUE FOR A:\n"
     msg3:  .asciiz "ENTER VALUE FOR B:\n"
     msg4:  .asciiz "ENTER VALUE FOR C:\n"
     msg5:  .asciiz "COMPLEX ROOT\n"
     msg6:  .asciiz "THE VALUE FOR X1 IS:\n"
     msg7:  .asciiz "THE VALUE FOR X2 IS:\n"
     msg8:  .asciiz "\n"
     numb1: .float  4.0
     numb2: .float  2.0
     numb3: .float -1.0
     numb4: .float  0.0
.text 
    main:
        lwc1 $f10,numb1
        lwc1 $f11,numb2
        lwc1 $f2,numb3
    	lwc1 $f3,numb4
    	
    	li $v0,4
    	la $a0,msg1
    	syscall
    	
    	li $v0,4
    	la $a0,msg2
    	syscall
    	
    	li $v0,6
    	syscall
    	mov.s $f13,$f0
    	
    	li $v0,4
    	la $a0,msg3
    	syscall
    	
    	li $v0,6
    	syscall
    	mov.s $f14,$f0
    	
    	li $v0,4
    	la $a0,msg4
    	syscall
    	
    	li $v0,6
    	syscall
    	mov.s $f15,$f0
    	
    	mul.s $f22,$f14,$f14      # $f22 = b*b
    	mul.s $f16,$f13,$f15      # $f16 = a*c
    	mul.s $f16,$f10,$f16      # $f16 = 4*a*c
    	mul.s $f18,$f11,$f13      # $f18 = 2*a
    	mul.s $f19,$f2,$f14       # $f19 = -b
    	sub.s $f17,$f22,$f16      # $f17 = (b*b - 4*a*c)
    	
    	sqrt.s $f4,$f17           # $f4  = sqr(b2 - 4ac)
    	
    	c.lt.s  $f17,$f3
    	bc1t complexroot
    	
    	#computing the value for X1
    	add.s $f26,$f19,$f4       # $f26 = -b + sqrtb2 - 4ac
    	div.s $f12,$f26,$f18      # $f12 = -b + sqrt(b2 - 4ac)/2a
        
        li $v0,4
        la $a0,msg6
        syscall
        
        li $v0,2
        syscall
        
        li $v0,4 
        la $a0,msg8
        syscall
        
        #computing the value for X2
        sub.s $f28,$f19,$f4     # $f28 = -b -sqrt(b2 - 4ac)
        div.s $f12,$f28,$f18    # $f12 = -b -sqrt(b2 - 4ac)/2a
        
        li $v0,4
        la $a0,msg7
        syscall
        
        li $v0,2
        syscall
    	
    	#End of program
exit:
    	li $v0,10
    	syscall
    	
complexroot:
        li $v0,4
        la $a0,msg5
        syscall 
        
        b exit
