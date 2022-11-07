		.include "marco_file.asm"
		.data

pin:		.word 1234
current: 	.word 20
orange: 	.word 5
apple: 		.word 7
egg:		.word 10

		.text
		.globl main
main:
 		lw $a0, pin
 		move $t1,$a0
 
 		print_str("Enter valid pin: ")
		li $v0, 5
		syscall
		beq $v0, $t1, mainA
		j main
mainA:
		print_str("----------------------------------------------------")
		print_str("\nTHIS IS SMART REFRIGERATOR. WHAT CAN I HELP YOU, SIR? \n ")
		print_str("---------------------------------------------------")
		print_str("\n1 -Set temperature\n2 -List items(Add or Remove items here)\n3- Exit\nSelect the number : ")
	
		li $v0, 5
		syscall
		beq $v0, 1, set_temp
		beq $v0, 2, list
		beq $v0, 3, exit
		j mainA
#######################	
set_temp:
		print_str("\n----------------------------------------------------")
		print_str("\nCurrent temperature (Celcius) : ")
		li $v0, 1 
		lw $a0, current #Current temp
		syscall
		
		print_str("\n----------------------------------------------------")
		print_str("\nSet new temperature (Celcius) : ")
		li $v0, 5 #get value
		syscall
		move $t1, $v0

		#modify the value of temperature
		lw $a0,current #access
		la $a0,current #load address
		sw $t1 0($a0) #save value from t1 to a0
	
		print_str("\nNew temperature (Celcius) : ")
		li $v0,1
		lw $a0, current #Current temp
		syscall
	
		#comparison
		lw $a0,current #access
		slti $t0,$a0,20
		print_str("\nTemperature success change\n")
		bne $t0,$zero,temp_exit

		slti $t0,$a0,25
		print_str("\nWARNING High Temperature, please change to other temperature : ")
		beq $t0,$zero,set_temp	
		j mainA
#######################	
list:
		print_str("\n----------------------------------------------------")
		print_str("\nList of food :\n")
		print_str("1. Orange :  ")
		li $v0, 1
		lw $a0, orange
 		syscall
 		print_str("\n2. Apple :  ")
 		li $v0, 1
 		lw $a0, apple
 		syscall
 		print_str("\n3. Eggs :  ")
 		li $v0, 1
 		lw $a0, egg
 		syscall
action:	
		print_str("\n----------------------------------------------------")
		print_str("\nChoose any action\n")
		print_str("1- Add an items          2- Remove an items\nSelect a number : ")
		li $v0, 5	
		syscall
		beq $v0, 1, additems
		beq $v0, 2, food_take
		j action
	
		li $v0,10
   		syscall
#######################		
additems:
  	  	print_str("\n----------------------------------------------------")
  	  	print_str("\nSELECT WHICH FOOD YOU WANT TO ADD (One by one)? ")
 	  	print_str("\n1.Orange        2.Apple        3.Egg        4. Back Main Menu\nSelect a number : ")
    	    	li $v0, 5
    	    	syscall
    	    	beq $v0, 1, orange_add
    	    	beq $v0, 2, apple_add
    	    	beq $v0, 3, egg_add
    	    	beq $v0, 4, mainA
    	    	j additems

orange_add:
      	 	print_str("\nExisting orange : ")

        	li $v0, 1
        	lw $a0, orange #Current orange 
        	syscall #ok

        	lw $t1,orange #access
        	la $a0,orange #load address
        	addi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new orange : ")
   	 	li $v0,1
   	 	lw $a0, orange #Current temp
   	 	syscall
   	 	
   	 	j additems
apple_add:
      	 	print_str("\nExisting apple :  ")

        	li $v0, 1
        	lw $a0, apple #Current apple
        	syscall #ok

        	lw $t1,apple #access
        	la $a0,apple #load address 
        	addi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new apple : ")
   	 	li $v0,1
   	 	lw $a0, apple #Current temp
   	 	syscall
		
		j additems
egg_add:
      	 	print_str("\nExisting egg :  ")

        	li $v0, 1
        	lw $a0, egg #Current egg
        	syscall #ok

        	lw $t1,egg #access
        	la $a0,egg #load address
        	addi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new egg : ")
   	 	li $v0,1
   	 	lw $a0, egg #Current temp
   	 	syscall
   	 	
   	 	j additems
#######################		
food_take:
  	  	print_str("\n----------------------------------------------------")
  	  	print_str("\nSELECT WHICH FOOD YOU WANT TO TAKE ? ")
 	  	print_str("\n1.Orange        2.Apple        3.Egg        4.Back Main Menu\nSelect a number : ")
    	    	li $v0, 5
    	    	syscall
    	    	beq $v0, 1, orange_minus
    	    	beq $v0, 2, apple_minus
    	    	beq $v0, 3, egg_minus
    	    	beq $v0, 4, mainA
    	    	j food_take

orange_minus:
      	 	print_str("\nExisting orange ")

        	li $v0, 1
        	lw $a0, orange #Current orange
        	syscall #ok

        	lw $t1,orange #access
        	la $a0,orange #load address
        	subi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new orange : ")
   	 	li $v0,1
   	 	lw $a0, orange #Current temp
   	 	syscall
   	 	
   	 	lw $a0,orange #access
		slti $t0,$a0,5
		bgt $a0, 5, food_take
		print_str("\nWARNING Orange quantity are low \n")
		bne $t0,$zero,food_take
		
		j food_take

   	 	li $v0,10
       	 	syscall

apple_minus:
      	 	print_str("\nExisting apple :  ")

        	lw $t0, apple #Current apple
        	li $v0, 1
        	move $a0, $t0 
        	syscall #ok

        	lw $t1,apple #access
        	la $a0,apple #load addres
        	subi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new apple : ")
   	 	lw $t0, apple #Current temp
   	 	li $v0,1
   	 	move $a0, $t0 
   	 	syscall
		
   	 	lw $a0,apple #access
		slti $t0,$a0,7
		bgt $a0, 7, food_take
		print_str("\nWARNING Apple quantity are low \n")
		bne $t0,$zero,food_take
		
		j food_take
		
   	 	li $v0,10
       	 	syscall
       	 
egg_minus:
      	 	print_str("\nExisting egg :  ")

        	lw $t0, egg #Current egg
        	li $v0, 1
        	move $a0, $t0 
        	syscall #ok

        	lw $t1,egg #access
        	la $a0,egg #load address
        	subi $t1,$t1,1
        	sw $t1 0($a0) #save value from t1 to a0

  	 	print_str("\nThe new egg : ")
   	 	lw $t0, egg #Current temp
   	 	li $v0,1
   	 	move $a0, $t0 
   	 	syscall

		lw $a0,egg #access
		slti $t0,$a0,10
		bgt $a0, 10, food_take
		print_str("\nWARNING Egg quantity are low \n")
		bne $t0,$zero,food_take
		
		j food_take

   	 	li $v0,10
       	 	syscall
#######################		   	
#For exit
temp_exit:
		print_str("\n----------------------------------------------------")
		print_str("\nReturn to Main Menu YES= 1 | NO = 2")
		print_str("\n----------------------------------------------------\n")
		li $v0, 5
		syscall
		beq $v0, 1, mainA
		beq $v0, 2, exit
		j temp_exit
exit:
	  	li $v0,10
   		syscall
 
