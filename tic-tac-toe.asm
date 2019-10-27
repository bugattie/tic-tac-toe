.data

######################################################################################## Variables

myFile: 		.asciiz 	"/home/pro/Desktop/teste.dat"      # filename for input
buffer: 		.space 		100000
error1:			.asciiz		"\n\t\t\t     ********Character File Not Found********"
spc:			.asciiz		"\n\t\t\t\t      "
spc2:			.asciiz		"    :    "
spc3:			.asciiz		"\t\t\t\t (Symbols) : (Values)"
choice:			.asciiz		"\n\n\t\t(     ) Enter Your Playing Symbol From Table By Thier Left Handed Values : "
strName1:		.space 		1024
strName2:		.space 		1024
name1:			.asciiz		"\n\t\t\t Program Created By : Muhammad Qasim, Muhammad Kashif and Muhammad Mohsin"
line1:			.asciiz 	"\n\t\t\t ------------------------------------------------" 
name2:			.asciiz		"\n\t\t\t          WELCOME TO TIC TAC TOE GAME"
line2:			.asciiz		"\n\t\t\t         *****************************"
line4:			.asciiz 	"\n\n\t\t\t(1st Turn)Player Enter Your(5 character) NickName: "
line5:			.asciiz 	"\n\n\t\t\t(2nd Turn)Player Enter Your(5 character) NickName: "
line3:			.asciiz 	"\n\n"
board: 			.asciiz 	"\n\n\t\t\t\t        1   2   3\n\n\t\t\t\t    1     |   |   \n\t\t\t\t       ---+---+---\n\t\t\t\t    2     |   |   \n\t\t\t\t       ---+---+---\n\t\t\t\t    3     |   |   \n"
wrongMove1:		.asciiz		"\n\t\t\t\t########Invalid Move########"
wrongMove2:		.asciiz 	"\n\n\t\t\t       ########Already Occupied Space########"
PressMove:		.asciiz		"\n\n\t\t       (     ) Enter Your Choice By Index Number (Col|Row): "
invalidChoice:	.asciiz		"\n\n\t\t\t\t      Invalid Choice :"
printX:			.asciiz		"X"
printO:			.asciiz		"O"
won:			.asciiz		"\n\n\n\t\t\t\t    (     ) Won!!! \n"
tie:			.asciiz		"\n\n\n\t\t\t\t       The Game Tie!!! \n\n"
replayMenu1:	.asciiz		"\n\n\t\t\t\t  Press(n/q) Your Choice: "
replayMenu2:	.asciiz		"\n\n\t\t\t\t[n] New Game"
replayMenu3:	.asciiz		"      [q] Quit"
option:			.asciiz		"\n\n\t\t\t\t     Option: "
space:			.byte		' '	
exit:			.asciiz		"\n\n\n\n\t\t\t\t    Program Exited :3"
temp1:			.word		0
temp2:			.word		0
	
############################################################################################ End Of Declaring Variables

.text

####################### Main Started

.globl main
main:

	li 		$t0, 0
	li 		$t1, 0
	li 		$t2, 0
	li 		$t3, 0
	li 		$t4, 0
	li 		$t5, 0
	li 		$t6, 0
	li 		$t7, 0
	li 		$t8, 0
	li 		$t9, 0
	li 		$s0, 0
	li 		$s1, 0
	li 		$s3, 5
	li 		$s4, 0
	li 		$s7, 0

	jal   filing
	jal   Title
	jal   getName

	li $v0, 4
	la $a0, line3
	syscall

	jal	  Symbols
	jal   Title
	jal   PrintBoard
	jal   replayMenu

	b     Exit

######################## End Of Main


######################## Filing For User Characters
.globl filing 
filing:
		# Open file for reading

		li   $v0, 13          # system call for open file
		la   $a0, myFile      # input file name
		li   $a1, 0           # flag for reading
		li   $a2, 0           # mode is ignored
		syscall               # open a file 
		move $s0, $v0         # save the file descriptor

		ble $s0, 0, printerror

		# reading from file just opened

		li   $v0, 14        # system call for reading from file
		move $a0, $s0       # file descriptor 
		la   $a1, buffer    # address of buffer from which to read
		li   $a2,  100      # hardcoded buffer length
		syscall             # read from file

		b Return

printerror:
		li $t1, 0

		li $v0, 4
		la $a0, error1
		syscall

		li $a1, 'X'
		li $a2, 'O'

		sb $a1, buffer($t1)
		add $t1, $t1, 1
		sb $a2, buffer($t1)

		li $t1, 0

		b Return

######################## End Of Filing	



##################### Title Printing Started

.globl Title
	Title:

		li 		$v0, 4
		la 		$a0, line3
		syscall

		li 		$v0, 4
		la 		$a0, line1
		syscall
		
		li		$v0, 4
		la 		$a0, name1
		syscall
		
		li 		$v0, 4
		la		$a0, line1
		syscall
		
		li 		$v0, 4
		la 		$a0, line3
		syscall
		
		li 		$v0, 4
		la 		$a0, line2
		syscall
		
		li 		$v0, 4
		la		$a0, name2
		syscall
		
		li 		$v0, 4
		la 		$a0, line2
		syscall
		
		li 		$v0, 4
		la 		$a0, line3
		syscall

		b 		Return

##################### End Of Title Printing 



##################### Getting Name Started

.globl getName

	getName:

		li 		$v0, 4
		la 		$a0, line4
		syscall

		
		#taking string as input
    	la 		$a0 , strName1
    	li 		$a1 , 1024
    	li 		$v0 , 8
    	syscall
    	

		li 		$v0, 4
		la 		$a0, line5
		syscall


		#taking string as input
    	la 		$a0 , strName2
    	li 		$a1 , 1024
    	li 		$v0 , 8
    	syscall    	

		li 		$v0, 4
		la 		$a0, line3
		syscall

		b 		Return

##################### End Of Getting Name

##################### User Threr Symbols 
.globl Symbols
Symbols:
		li $v0, 4
		la $a0, spc3
		syscall

		b loopChar

loopChar:
		li $v0, 4
		la $a0, spc
		syscall

		lb $t5, buffer($t1)
		beqz $t5 loopNumber

		li $v0,11
		move $a0,$t5
		syscall

		li $v0, 4
		la $a0, spc2
		syscall

		addi $t1, $t1, 1

		b loopNumber

loopNumber:
		beq $t2, $t1, Choice1

		li $v0, 1
		move $a0, $t2
		syscall

		addi $t2, $t2, 1

		b loopChar

Choice1:
		lb 		$s7, strName1($s4)
		beq 	$s4, 5, Enter1
		sb 		$s7, choice($s3)
		add 	$s4, $s4, 1
		add 	$s3, $s3, 1
		b 		Choice1

Choice2:
		lb 		$s7, strName2($s4)
		beq 	$s4, 5, Enter2
		sb 		$s7, choice($s3)
		add 	$s4, $s4, 1
		add 	$s3, $s3, 1
		b 		Choice2

Enter1:
		li $s3, 5
		li $s4, 0

		li $v0, 4
		la $a0, line3
		syscall

		li $v0, 4
		la $a0, choice
		syscall

		li $v0, 5
		syscall
		move $t5, $v0

		bgt $t5, 25, Enter1
		blt $t5, 0 , Enter1

		sw $t5, temp1

		b Choice2

Enter2:
		li $v0, 4
		la $a0, choice
		syscall

		li $v0, 5
		syscall
		move $t5, $v0

		lw $t9, temp1

		beq $t5, $t9, Enter2
		bgt $t5, 25, Enter2
		blt $t5, 0 , Enter2

		sw $t5, temp2

		li $t1, 0
		li $t2, 0
		li $t5, 0
		li $t9, 0
		li $s3, 12
		li $s4, 0
		li $s7, 0

		b Return

##################### End Of Choosing

##################### Board Printing

.globl PrintBoard
	PrintBoard:

		li 		$v0, 4
		la 		$a0, board
		syscall

		beq 	$s1, 9, GameTie

		add 	$s1, $s1, 1

		rem 	$t0, $s0, 2
		add 	$s0, $s0, 1
		bnez 	$t0, Player2

		b 		Player1


	Player1:
	
		lb 		$s7, strName1($s4)
		beq 	$s4, 5, play
		sb 		$s7, PressMove($s3)
		sb 		$s7, won($s3)
		add 	$s4, $s4, 1
		add 	$s3, $s3, 1
		b 		Player1


	Player2:

		lb 		$s7, strName2($s4)
		beq 	$s4, 5, play
		sb 		$s7, PressMove($s3)
		sb 		$s7, won($s3)
		add 	$s4, $s4, 1
		add 	$s3, $s3, 1
		b 		Player2

##################### End of Board Printing

##################### Play
.globl play
play:
	li 		$s3, 12
	li 		$s4, 0

	li 		$v0, 4
	la 		$a0, PressMove
	syscall

	li 		$v0, 5
	syscall
	move	$s2, $v0

	b 		conditions

conditions:
	
	beq 	$s2, 11, mark11
	beq 	$s2, 12, mark12
	beq 	$s2, 13, mark13
	beq 	$s2, 21, mark21
	beq 	$s2, 22, mark22
	beq 	$s2, 23, mark23
	beq 	$s2, 31, mark31
	beq 	$s2, 32, mark32
	beq 	$s2, 33, mark33

	li 		$v0, 4
	la 		$a0, wrongMove1
	syscall

	b 		play

mark11:
	bnez 	$t1, SpaceOccupied
	bnez 	$t0, mark0on11
	b 		markXon11

markXon11:
	li 		$t1, 1
	li 		$s5, 37
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on11:
	li 		$t1, 10
	li 		$s5, 37
	li 		$a1, 'O'
	sb		$a1, board($s5)
	b 		VictoryCheckingX

mark12:
	bnez 	$t2, SpaceOccupied
	bnez 	$t0, mark0on12
	b 		markXon12

markXon12:
	li 		$t2, 1
	li 		$s5, 41
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on12:
	li 		$t2, 10
	li 		$s5, 41
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark13:
	bnez 	$t3, SpaceOccupied
	bnez 	$t0, mark0on13
	b 		markXon13

markXon13:
	li 		$t3, 1
	li 		$s5, 45
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on13:
	li 		$t3, 10
	li 		$s5, 45
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark21:
	bnez 	$t4, SpaceOccupied
	bnez 	$t0, mark0on21
	b 		markXon21

markXon21:
	li 		$t4, 1
	li 		$s5, 83
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on21:
	li 		$t4, 10
	li 		$s5, 83
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark22:
	bnez 	$t5, SpaceOccupied
	bnez 	$t0, mark0on22
	b 		markXon22

markXon22:
	li 		$t5, 1
	li 		$s5, 87
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on22:
	li 		$t5, 10
	li 		$s5, 87
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark23:
	bnez 	$t6, SpaceOccupied
	bnez 	$t0, mark0on23 
	b 		markXon23

markXon23:
	li 		$t6, 1
	li 		$s5, 91
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on23:
	li 		$t6, 10
	li 		$s5, 91
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark31:
	bnez 	$t7, SpaceOccupied
	bnez 	$t0, mark0on31
	b 		markXon31

markXon31:
	li 		$t7, 1
	li 		$s5, 129
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on31:
	li 		$t7, 10
	li 		$s5, 129
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark32:
	bnez 	$t8, SpaceOccupied
	bnez 	$t0, mark0on32
	b 		markXon32

markXon32:
	li 		$t8, 1
	li 		$s5, 133
	li 		$a1, 'X'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

mark0on32:
	li		$t8, 10
	li 		$s5, 133
	li 		$a1, 'O'
	sb		$a1, board($s5)
	b 		VictoryCheckingX

mark33:
	bnez 	$t9, SpaceOccupied
	bnez 	$t0, mark0on33
	b 		markXon33

markXon33:
	li 		$t9, 1
	li 		$s5, 137
	li 		$a1, 'X'
	sb	 	$a1, board($s5)
	b 		VictoryCheckingX

mark0on33:
	li 		$t9, 10
	li 		$s5, 137
	li 		$a1, 'O'
	sb 		$a1, board($s5)
	b 		VictoryCheckingX

SpaceOccupied:
	li 		$v0, 4
	la 		$a0, wrongMove2
	syscall

	b 		play

##################### End of Play

############### By String Manipulation Checking Victory And Conditions Printing 

VictoryCheckingX:
	add 	$s6, $t1, $t2
	add 	$s6, $s6, $t3
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t1, $t5
	add 	$s6, $s6, $t9
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t3, $t5
	add 	$s6, $s6, $t7
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t3, $t6
	add 	$s6, $s6, $t9
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t1, $t4
	add 	$s6, $s6, $t7
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t7, $t8
	add 	$s6, $s6, $t9
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	add 	$s6, $t3, $t4
	add 	$s6, $s6, $t5
	beq 	$s6,  30, Victory
	beq 	$s6,   3, Victory

	add 	$s6, $t8, $t5
	add 	$s6, $s6, $t2
	beq 	$s6, 30, Victory
	beq 	$s6,  3, Victory

	b 		PrintBoard

GameTie:
	li 		$v0, 4
	la 		$a0, tie
	syscall

	b 		Return

Victory:
	li 		$v0, 4
	la 		$a0, board
	syscall

	li 		$v0, 4
	la		$a0, won
	syscall
	
	b		replayMenu

######################## End Of Checking Victory And Conditions Printing

##################### Replaying Menu After Match
.globl replayMenu
replayMenu:
	li 		$v0,4
	la 		$a0, replayMenu1
	syscall

	li 		$v0,4
	la 		$a0, replayMenu2
	syscall

	li 		$v0,4
	la 		$a0, replayMenu3
	syscall

	li 		$v0,4
	la 		$a0, option
	syscall

	li 		$v0, 12
	syscall

	beq 	$v0, 'q', Exit
	beq 	$v0, 'n', restoreNewBoard

	li 		$v0,4
	la	 	$a0, invalidChoice
	syscall

	b 		replayMenu

restoreNewBoard:
	lb 		$s3, space

	li 		$t0, 37
	sb 		$s3, board($t0)

	li 		$t0, 41
	sb 		$s3, board($t0)

	li 		$t0, 45
	sb 		$s3, board($t0)

	li 		$t0, 83
	sb 		$s3, board($t0)

	li 		$t0, 87
	sb 		$s3, board($t0)

	li 		$t0, 91
	sb 		$s3, board($t0)

	li 		$t0, 129
	sb 		$s3, board($t0)

	li 		$t0, 133
	sb 		$s3, board($t0)

	li 		$t0, 137
	sb 		$s3, board($t0)

	b 		main

##################### End Of Replaying Menu

################### Return Label

Return:
	jr 		$ra

#################### End Of Return Label

Exit:
	li 		$v0, 4
	la 		$a0, exit
	syscall

	li 		$v0, 10
	syscall