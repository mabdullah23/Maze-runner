[org 0x0100]
jmp start

 
start_msg db 'START', 0
start_len dw 5
exit_msg db 'EXIT', 0
exit_len dw 4
intruction_mess db 'INSTRUCTION',0
intruction_len dw 11
arrow db '>', 0          ; Arrow character
arrow_len dw 1           ; Length of the arrow string
easy_msg db 'EASY LEVEL', 0
easy_len dw 10
medium_msg db 'MEDIUM LEVEL', 0
medium_len dw 12
hard_msg db 'HARD LEVEL', 0
hard_len dw 10
Divider db 186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,186,0
DividerLen db 25
Box  db 195,196,196,196,197,196,196,196,197,196,196,196,179,196,196,196,197,196,196,196,197,196,196,196,179,196,196,196,197,196,196,196,197,196,196,196,180,0
SubBox db 180,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,180,0
row1Data db 179,' 5 | 3 |   ',179,' 6 | 7 |   ',179,' 9 | 1 |   ',179,0
row2Data db 179,' 6 |   |   ',179,' 1 | 9 | 5 ',179,' 3 | 4 | 8 ',179,0
row3Data db 179,' 1 |   | 8 ',179,' 3 | 4 |   ',179,'   |   | 7 ',179,0
row4Data db 179,' 8 | 5 | 9 ',179,'   |   | 1 ',179,' 4 | 2 | 3 ',179,0
row5Data db 179,' 4 | 2 | 6 ',179,'   | 5 | 3 ',179,' 7 |   | 1 ',179,0
row6Data db 179,'   |   |   ',179,' 9 |   |   ',179,'   |   |   ',179,0
row7Data db 179,'   | 6 | 1 ',179,'   |   |   ',179,'   |   | 4 ',179,0
row8Data db 179,' 2 | 8 |   ',179,' 4 | 1 |   ',179,' 6 | 3 | 5 ',179,0
row9Data db 179,' 3 | 4 |   ',179,' 2 | 8 |   ',179,' 1 | 7 | 9 ',179,0

 
row1Data1 db 179,' 5 | 3 |   ',179,'   | 7 |   ',179,'   |   |   ',179,0
row2Data1 db 179,' 6 |   |   ',179,' 1 | 9 | 5 ',179,'   |   |   ',179,0
row3Data1 db 179,'   | 9 | 8 ',179,'   |   |   ',179,'   | 6 |   ',179,0
row4Data1 db 179,' 8 |   |   ',179,'   | 6 |   ',179,'   |   | 3 ',179,0
row5Data1 db 179,' 4 |   |   ',179,' 8 |   | 3 ',179,'   |   | 1 ',179,0
row6Data1 db 179,' 7 |   |   ',179,'   | 2 |   ',179,'   |   | 6 ',179,0
row7Data1 db 179,'   | 6 |   ',179,'   |   |   ',179,' 2 | 8 |   ',179,0
row8Data1 db 179,'   |   |   ',179,' 4 | 1 | 9 ',179,'   |   | 5 ',179,0
row9Data1 db 179,'   |   |   ',179,'   | 8 |   ',179,'   | 7 | 9 ',179,0 

     solution: db 5,3,4,6,7,8,9,1,2,6,7,2,1,9,5,3,4,8,1,9,8,3,4,2,5,6,7,8,5,9,7,6,1,4,2,3,4,2,6,8,5,3,7,9,1,7,1,3,9,2,4,8,5,6,9,6,1,5,3,7,2,8,4,2,8,7,4,1,9,6,3,5,3,4,5,2,8,6,1,7,9
notes_array : times 162 db 0

current_selection db 0
welcome_msg db 'WELCOME To SUDOKU!',0
welcome_lenght dw 18
level_msg db 'Select the Level.(ECS to go back).' , 0
level_lenght  dw 34
timer_msg db 'TIMER: 08:00' ,0
timer_msg1 db 'TIMER: 05:00' ,0
timer_msg2 db 'TIMER: 03:00' ,0
timer_lenght dw 12
saved_tick dw 0            ; Define saved_tick in the data segment
mediumlife db 'Life counter:',0
mediumlifelen dw 13
hardlife db 'Life counter:',0
hardlifelen dw 13
easylife db 'Life counter:',0
counter dw 8
counter_med dw 6
counter_hard dw 5
counter_check_level dw 0
score_count dw 0
score_text db 'SCORE:',0
score_text_len dw 6
game_over db 'Game Over.Press ESC to start again.'
game_over_len dw 35
easylifelen dw 13
notes_mess db '|NOTES| ',0
notes_len dw 8
suduko_mess db 'SUDUKO',0
suduko_len dw 6
instruction1 db '1. No repeats: Each number appears once per row, column, and box.', 0
    instruction2 db '2. Start with the given numbers: Sudoku puzzles have numbers filled in.',0
    instruction3 db '3. Use logic: Find patterns and fill in one square at a time.', 0
    instruction4 db '4. Look for the only place: A number can fit in just one spot sometimes.',0
	instruction5 db  '5. Avoid guessing: Use logical deduction instead of random guesses.',0
	instruction6 db '6. Check your work: Regularly review filled cells for potential mistakes.',0
	escape_instrution db 'Press ESC to go back',0
intruc1_len dw 65
intruc2_len dw 71
intruc3_len dw 62
intruc4_len dw 70
intruc5_len dw 67
intruc6_len dw 71
escape_len dw 20




delay:
    push cx
    mov cx, 2 ; change the values to increase delay time
delay_loop1:
    push cx
    mov cx, 0xFFFF
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret


print_notes_grid:
pusha
mov ax,0xb800
mov es,ax
mov al,196
mov ah,0x70
mov cx,7
mov di,1560+320
cld
rep stosw
mov cx,7
mov di,1880+320
rep stosw
mov al,179
mov di,1560+158+320
stosw
mov di,1560+8+158+320
stosw
mov di,1560+16+158+320
stosw
mov al,218
mov di,1558+320
stosw
mov al,192
mov di,1558+160+160+320
stosw
mov al,217
mov di,1560+14+320+320
stosw
mov al,191
mov di,1560+14+320
stosw
popa
ret
printnum: push bp
 mov bp, sp
 push es
 push ax
 push bx
 push cx
 push dx
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov ax, [bp+4] ; load number in ax
 mov bx, 10 ; use base 10 for division
 mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
 div bx ; divide by 10
 add dl, 0x30 ; convert digit into ascii value
 push dx ; save ascii value on stack
 inc cx ; increment count of values
 cmp ax, 0 ; is the quotient zero
 jnz nextdigit ; if no divide it again
 mov di,1248 ; point di to top left column
nextpos: pop dx ; remove a digit from the stack
 mov dh, 0x70 ; use normal attribute
 mov [es:di], dx ; print char on screen
 add di, 2 ; move to next screen location
 loop nextpos ; repeat for all digits on stack
 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 pop es
 pop bp
 ret 2 


  
 print_card_layout:
      mov ax,7
	  push ax
	  mov ax,21
	  push ax 
	  mov ax,0x70
	  push ax
	  mov ax,Card1
	  push ax
	  push word [Card1Len]
	  call printstr
	  mov ax,6
	  push ax
	  mov ax,22 
	  push ax 
	  mov ax,0x70
	  push ax
	  mov ax,Card2
	  push ax
	  push word [Card2Len]
	  call printstr 
   mov ax,6
	  push ax
	  mov ax,23 
	  push ax 
	  mov ax,0x70
	  push ax
	  mov ax,Card3
	  push ax
	  push word [Card3Len]
	  call printstr 
      mov ax,6
	  push ax
	  mov ax,24
	  push ax 
	  mov ax,0x70
	  push ax
	  mov ax,Card4
	  push ax
	  push word [Card4Len]
	  call printstr 
      ret
	  
	  printscoretext:
	  
	  	 mov ax, 57
    push ax                ; y position = 0
    mov ax, 7
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, score_text
    push ax
    push word [score_text_len]
    call printstr
	
	
	ret
	
	printgameover:
		 mov ax, 40
    push ax                ; y position = 0
    mov ax, 10
    push ax
    mov ax, 0x74         ; highlighted for "Easy"
    push ax
    mov ax, game_over
    push ax
    push word [game_over_len]
    call printstr
	ret
	  
	
     printUndo:
	 mov ax,64
	 push ax
	 mov ax,21 
	 push ax 
	 mov ax,0x70
	 push ax
	 mov ax,undo_msg
	 push ax
	 push word [undoLen]
	 call printstr
	 mov ax, 62
     push ax                ; y position = 4
     mov ax, 20
     push ax
     mov ax, 0x70           ; regular white on black
     push ax
     mov ax, undoBoxTop
     push ax
     push word [undoBoxTopLen]
     call printstr
	 mov ax, 62
     push ax                ; y position = 4
     mov ax, 21
     push ax
     mov ax, 0x70          ; regular white on black
     push ax
     mov ax, vert
     push ax
     push word[vertLen]
	 call printstr
	 mov ax, 76
     push ax                ; y position = 4
     mov ax, 21
     push ax
     mov ax, 0x70           ; regular white on black
     push ax
     mov ax, vert
     push ax
     push word[vertLen]
	 call printstr
	 mov ax, 62
     push ax                ; y position = 4
     mov ax, 22
     push ax
     mov ax, 0x70        ; regular white on black
     push ax
     mov ax, undoBoxBott
     push ax
     push word[undoBoxBottLen]
	 call printstr
     ret
	printstrGrid:
    push es
    push ax
    push cx
    push si
    push di
    mov bx, 0xb800          ; Video memory address
    mov es, bx

next_char:
    lodsb                   ; Load character from string into AL
    stosw                   ; Store AX (character in AL, attribute in AH) to ES:DI
    loop next_char          ; Loop until the string is fully printed

    pop di
    pop si
    pop cx
    pop ax
    pop es
    ret
clrscr1:
    push es
    push ax
    push di
    mov ax, 0xb800          ; Video memory address (for text mode)
    mov es, ax
    mov di, 0               ; Start at top left corner
	next_loc:
    mov word [es:di], 0x7020 ; Clear screen character with gray background (space character)
    add di, 2               ; Move to next word in video memory
    cmp di, 4000            ; 80x25 = 2000 words (each word is 2 bytes)
    jne next_loc
    pop di
    pop ax
    pop es
    ret
	    print_hard:
	 mov ax, 57
    push ax                ; y position = 0
    mov ax, 1
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, hard_msg
    push ax
    push word [hard_len]
    call printstr
	
	ret
	print_easy:
	 mov ax, 57
    push ax                ; y position = 0
    mov ax, 1
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, easy_msg
    push ax
    push word [easy_len]
    call printstr
	
	
	ret
print_medium:
 mov ax, 57
    push ax                ; y position = 0
    mov ax, 1
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, medium_msg
    push ax
    push word [medium_len]
    call printstr

ret
Grid9x9:
    push es
    push ax
    push cx
    push si
    push di
    push bx
    push dx
    mov ax, 0xb800          ; Video memory address
    mov es, ax
    mov di, (80 * 1 + 6) * 2  ; Start at row 3, column 2
   
    mov cx, 9
    mov bx, 1
display_row:
    push cx
    mov si, Box 
    cmp bx, 1
    je useSubBoxx
    cmp bx, 4
    je useSubBoxx
    cmp bx, 7
    je useSubBoxx
    jmp printline
useSubBoxx:
    mov si, SubBox 
    
printline:
    mov cx, 37              ; Length of grid line
    mov ah, 0x70           ; Black text on gray background
printLinee:
    lodsb
    stosw
    dec cx
    cmp cx, 0
    jne printLinee
    
    add di, (80 - 37) * 2   ; Move to next row
    ; Print grid row content
    cmp bx, 1
    je print_row11
    cmp bx, 2
    je print_row22
    cmp bx, 3
    je print_row33
    cmp bx, 4
    je print_row44
    cmp bx, 5
    je print_row55
    cmp bx, 6
    je print_row66
    cmp bx, 7
    je print_row77
    cmp bx, 8
    je print_row88
    cmp bx, 9
    je print_row99
print_row11:
    mov si, row1Data
    jmp printGridDataa
print_row22:
    mov si, row2Data
    jmp printGridDataa
print_row33:
    mov si, row3Data
    jmp printGridDataa
print_row44:
    mov si, row4Data
    jmp printGridDataa
print_row55:
    mov si, row5Data
    jmp printGridDataa
print_row66:
    mov si, row6Data
    jmp printGridDataa
print_row77:
    mov si, row7Data
    jmp printGridDataa
print_row88:
    mov si, row8Data
    jmp printGridDataa
print_row99:
    mov si, row9Data
printGridDataa:
    mov cx, 37              ; Length of grid row
    mov ah, 0x70           ; Black text on gray background
    push di                ; Save current video position
print_grid_row_loopp:
    push cx                ; Save counter
    push si                ; Save source pointer
    
    ; Check existing character at current position
    mov ax, [es:di]        ; Get word at current position (char + attribute)
    cmp al, ' '            ; Check if it's a space
    je print_new_char      ; If space, print new character
    cmp al, '1'            ; Check if it's a number
    jb print_new_char
    cmp al, '9'
    ja print_new_char
    
    ; If we get here, there's a number - preserve it
    pop si                 ; Restore source pointer
    lodsb                  ; Skip the source character
    add di, 2              ; Move to next screen position
    jmp next_char1
    
print_new_char:
    pop si                 ; Restore source pointer
    lodsb                  ; Get new character
    stosw                  ; Print it with attribute
    jmp next_char1
    
next_char1:
    pop cx                 ; Restore counter
    loop print_grid_row_loopp
    
    pop di                 ; Restore original position
    add di, (80 * 2)       ; Move to next row
    inc bx
    
    pop cx
    dec cx
    jnz display_row
    
    ; Print final thick line
    mov si, SubBox
    mov cx, 37
    mov ah, 0x70
Lastt:
    lodsb
    stosw
    loop Lastt
    
    ; Print divider
    mov si, Divider
    mov cx, DividerLen
    mov ah, 0x70
    mov di, (80 * 0 + 50) * 2
print_separation:
    lodsb
    stosw
    add di, 158
    loop print_separation
    
    pop dx
    pop bx
    pop di
    pop si
    pop cx
    pop ax
    pop es
    ret


clrscr:
    push es
    push ax
    push di
    mov ax, 0xb800          ; point to video memory base
    mov es, ax
    mov di, 0               ; start at top-left of screen
    mov ah, 0x00          ; space (0x20) with off-white background (0xF0)
    mov cx, 2000            ; 80x25 = 2000 characters
rep stosw                   ; fill screen with off-white background
    pop di
    pop ax
    pop es
    ret

; Subroutine to print a string at a given position
printstr:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di

    mov ax, 0xb800
    mov es, ax
    mov al, 80
    mul byte [bp+10]
    add ax, [bp+12]
    shl ax, 1
    mov di, ax
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [bp+8]

nextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    add si, 1
    loop nextchar

    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 10
	
	move_pointer:
	 ;169 170 196 179 192 217
	 push bp
	 mov bp,sp
	 pusha
	 mov bx,0x7020

mov ax,0xb800
mov es,ax
mov di,[bp+4]
mov ah,0xf0
mov al,169
mov [es:di], ax
add di,2
mov [es:di], bx
add di,2
mov [es:di], bx
add di,2
mov al,170
mov [es:di], ax
add di,154
mov [es:di], bx
add di,6
mov [es:di], bx
add di,154
mov al,192
mov [es:di], ax
add di,2
mov [es:di], bx
add di,2
mov [es:di], bx
add di,2
mov al,217
mov [es:di], ax



	 popa
	 pop bp
	 ret 2
	 	 move_pointer1:
	 ;169 170 196 179 192 217
	 push bp
	 mov bp,sp
	 pusha
	 mov bx,0x7020

mov ax,0xb800
mov es,ax
mov di,[bp+4]
mov ah,0xf0
mov al,169
mov [es:di], ax
add di,2
mov [es:di], bx
add di,2
mov [es:di], bx
add di,2
mov al,170
mov [es:di], ax
add di,154
mov [es:di], bx
add di,6
mov [es:di], bx
add di,154
mov al,192
mov [es:di], ax
add di,2
mov [es:di], bx
add di,2
mov [es:di], bx
add di,2
mov al,217
mov [es:di], ax



	 popa
	 pop bp
	 ret 2
	 
	 
	 
	 
	 
	 

  diff_menu:
    call clrscr


    mov ax, 20
    push ax                ; y position = 0
    mov ax, 8
    push ax
    mov ax, 0x01        ; highlighted for "Easy"
    push ax
    mov ax, level_msg
    push ax
    push word [level_lenght]
    call printstr


    mov ax, 30
    push ax                ; y position = 0
    mov ax, 10
    push ax
    mov ax, 0x01         ; highlighted for "Easy"
    push ax
    mov ax, easy_msg
    push ax
    push word [easy_len]
    call printstr

    mov ax, 30
    push ax                ; y position = 2
    mov ax, 11
    push ax
    mov ax, 0x01           ; regular white on black
    push ax
    mov ax, medium_msg
    push ax
    push word [medium_len]
    call printstr

    mov ax, 30
    push ax                ; y position = 4
    mov ax, 12
    push ax
    mov ax, 0x01           ; regular white on black
    push ax
    mov ax, hard_msg
    push ax
    push word [hard_len]
    call printstr




        cmp byte [current_selection],1
    jz medium_arrow
        cmp byte [current_selection],2
        jz hard_arrow
    
    mov ax, 28               ; y position = 0
    push ax
    mov ax, 10               ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01            ; black text on off-white background (blinking)
    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr            ; Print the arrow next to "Start
    ret
medium_arrow:
     mov ax, 28               ; y position = 0
    push ax
    mov ax, 11               ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01           ; black text on off-white background (blinking)
    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr    
    ret
hard_arrow:
     mov ax, 28               ; y position = 0
    push ax
    mov ax, 12               ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01             ; black text on off-white background (blinking)
    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr     

    ; Implement difficulty level selection logic here...
    ret


; Subroutine to print the menu
print_menu:
    call clrscr

mov ax, 27
push ax                ; y position = 25
mov ax, 8
push ax                ; x position = 8
mov ax, 0x01           ; Red text (0x4) with Light Cyan background (0xB) (no blink)
push ax
mov ax, welcome_msg
push ax                ; "Start" message
push word [welcome_lenght]
call printstr          ; Call the print string function


   
    mov ax, 28
    push ax                ; y position = 0
    mov ax, 10
    push ax                ; x position = 10
   mov ax, 0x01          ; Red text (0x4) with Light Cyan background (0xB) (no blink)

    push ax
    mov ax, start_msg
    push ax                ; "Start" message
    push word [start_len]
    call printstr
	
	
	
	 mov ax, 28
    push ax                ; y position = 2
    mov ax, 11
    push ax                ; x position = 11
   mov ax, 0x01          ; Red text (0x4) with Light Cyan background (0xB) (no blink)

    push ax
    mov ax, intruction_mess
    push ax                ; "Exit" message
    push word [intruction_len]
    call printstr

    mov ax, 28
    push ax                ; y position = 2
    mov ax, 12
    push ax                ; x position = 11
   mov ax, 0x01           ; Red text (0x4) with Light Cyan background (0xB) (no blink)

    push ax
    mov ax, exit_msg
    push ax                ; "Exit" message
    push word [exit_len]
    call printstr
   


    ; Print arrow and "Start"
    cmp byte [current_selection],2
    jz exitarrow
	  cmp byte [current_selection],1
	  jz intruction_arrow
    mov ax, 26              ; y position = 0
    push ax
    mov ax, 10               ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01            ; black text on off-white background (blinking)
    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr            ; Print the arrow next to "Start
    ret
	
	intruction_arrow:
	    mov ax, 26              ; y position = 0
    push ax
    mov ax, 11              ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01             ; black text on off-white background (blinking)
    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr            ; Print the arrow next to "Start
    ret
	
	
    exitarrow:
     mov ax, 26               ; y position = 0
    push ax
    mov ax, 12              ; x position = 8 (left of "Start")
    push ax
    mov ax, 0x01            ; black text on off-white background (blinking)

    push ax
    mov ax, arrow            ; Arrow message
    push ax
    push word [arrow_len]
    call printstr     
 ret

  jump_exit:
   jmp exit_game

    print_timer:
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 3
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, timer_msg
    push ax
    push word [timer_lenght]
    call printstr
    ret
   print_timer1:
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 3
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, timer_msg1
    push ax
    push word [timer_lenght]
    call printstr
    ret
 print_timer2:
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 3
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, timer_msg2
    push ax
    push word [timer_lenght]
    call printstr
    ret
	
	
	
	
	
print_eas_life:

 
     mov ax,0xb800
    mov es,ax
    mov di,942
xor ax,ax
 
  mov word ax,[counter]
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
		xor ax,ax
	mov word ax,[score_count]
	push ax
	call printnum
	


	
	
	

	
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 5
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, easylife
    push ax
    push word [easylifelen]
    call printstr
    ret

    
print_med_life:
     mov ax,0xb800
    mov es,ax
    mov di,942
xor ax,ax
 
  mov word ax,[counter_med]
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
			xor ax,ax
	mov word ax,[score_count]
	push ax
	call printnum
	
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 5
    push ax
    mov ax, 0x70         ; highlighted for "Easy"
    push ax
    mov ax, mediumlife
    push ax
    push word [mediumlifelen]
    call printstr
    ret

print_hard_life:
     mov ax,0xb800
    mov es,ax
    mov di,942
xor ax,ax
 
  mov word ax,[counter_hard]
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
			xor ax,ax
	mov word ax,[score_count]
	push ax
	call printnum
	
	
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 5
    push ax
    mov ax, 0x70         ; highlighted for "hard"
    push ax
    mov ax, hardlife
    push ax
    push word [hardlifelen]
    call printstr
    ret
	
	print_notes:
    mov ax, 57
    push ax                ; y position = 0
    mov ax, 9
    push ax
    mov ax, 0x70         
    push ax
    mov ax, notes_mess
    push ax
    push word [notes_len]
    call printstr
    ret
	
	print_suduko:
    mov ax, 20
    push ax                ; y position = 0
    mov ax, 1
    push ax
    mov ax, 0x70         
    push ax
    mov ax, suduko_mess
    push ax
    push word [suduko_len]
    call printstr
    ret
	
	
    intstruction_print:
	
	;funtion to print instructions
	
	call clrscr
    mov ax, 4              ;x position
    push ax                ; y position 
    mov ax, 3
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction1
    push ax
    push word [intruc1_len]
    call printstr
	
	
	   mov ax, 4
    push ax                
    mov ax, 5
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction2
    push ax
    push word [intruc2_len]
    call printstr
	
	
	   mov ax, 4
    push ax                
    mov ax, 7
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction3
    push ax
    push word [intruc3_len]
    call printstr
	
	
	   mov ax, 4
    push ax                
    mov ax, 9
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction4
    push ax
    push word [intruc4_len]
	
    call printstr
		   mov ax, 4
    push ax                
    mov ax, 11
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction5
    push ax
    push word [intruc5_len]
    call printstr
	
		   mov ax, 4
    push ax                
    mov ax, 13
    push ax
    mov ax, 0x04         
    push ax
    mov ax, instruction4
    push ax
    push word [intruc6_len]
    call printstr
	
			   mov ax, 20
    push ax                
    mov ax, 15
    push ax
    mov ax, 0x04         
    push ax
    mov ax, escape_instrution
    push ax
    push word [escape_len]
    call printstr
	
	 mov ah, 0
    int 0x16           ; wait for keypress
    cmp al, 0x1B          ; ESC key
    je menu_input
	
	ret
    
    





; Handle menu input and movement
menu_input:
call print_menu 
    mov ah, 0
    int 0x16           ; wait for keypress
    cmp al, 0x1B          ; ESC key
    je jump_exit
    cmp ah, 0x50           ; Down arrow (0x50 is the scan code for down arrow)
    je move_down
    cmp ah, 0x48           ; Up arrow (0x48 is the scan code for up arrow)
    je move_up
    cmp al, 0x0D           ; Enter key
    je select_option
    ret

move_down:
     cmp byte [current_selection], 2   ; If already on Hard, do nothing
    je menu_input
    inc byte [current_selection]      ; Move to next option (Easy -> Medium -> Hard)
    call print_menu                   ; Reprint the menu with updated selection
    jmp menu_input

move_up:
    cmp byte [current_selection], 0   ; If already on Easy, do nothing
    je menu_input
    dec byte [current_selection]      ; Move to previous option (exit -> INSTRUCTION -> strat)
    jmp menu_input                 ; Reprint the menu with updated selection
    jmp menu_input_level


select_option:
   cmp byte [current_selection], 2   ; If "exit" selected
    je jump_exit
    cmp byte [current_selection], 0   ; If "start" selected
    je menu_input_level
    cmp byte [current_selection], 1   ; If "instruction" selected
    jmp intstruction_print
   
   
    

    
    


    ; Handle menu input and movement
menu_input_level:
call diff_menu
    mov ah, 0               ; Wait for keypress
    int 0x16
    cmp ah, 0x01            ; ESC key
    je menu_input
    cmp ah, 0x50            ;  scan code for key for moving down
    je move_down1
    cmp ah, 0x48            ;  key for moving up
    je move_up1
    cmp al, 0x0D            ; Enter key
    je select_option1
    jmp menu_input_level

move_down1:
    cmp byte [current_selection], 2   ; If already on Hard, do nothing
    je menu_input_level
    inc byte [current_selection]      ; Move to next option (Easy -> Medium -> Hard)
    call diff_menu                   ; Reprint the menu with updated selection
    jmp menu_input_level

move_up1:
    cmp byte [current_selection], 0   ; If already on Easy, do nothing
    je menu_input_level
    dec byte [current_selection]      ; Move to previous option (Hard -> Medium -> Easy)
    call diff_menu                   ; Reprint the menu with updated selection
    jmp menu_input_level

select_option1:
    cmp byte [current_selection], 0   ; If "Easy" selected
    je game_easy
    cmp byte [current_selection], 1   ; If "Medium" selected
    je game_medium
    cmp byte [current_selection], 2   ; If "Hard" selected
    je game_hard
    jmp menu_input_level
	
	
	
    find_element_row:
	push ax
    push bx
	
	mov ax,dx
	mov bx,9
	mul bx
	
	
	exitrow:
	add ax,1
	mov dx,ax
	pop bx 
	pop ax
	ret 
	
	
	
	
	 
	
print_ascii:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    push cx
    push dx
    push si

    mov si, bx           ; Save input value in `si` (assumed ASCII character with attributes)
    mov ax, 0xb800
    mov es, ax           ; Set segment to video memory
    mov di, [bp-4]
	add di,164
	mov ax,[es:di]
	cmp al,0x20
	jne end1
	sub di,164
 
	
	cmp di,1772
	je five
	cmp di,2092
	je one
	cmp di,2412
	je two
	cmp di,2732
	je three
	cmp di,812
	je four
	
	

   

    ; Perform division to determine row and column based on `di`
    mov cx, 320          ; Divisor for determining row
    xor bx, bx           ; Reset quotient
    mov dx, di           ; Set remainder for division

divide_loop11:
    cmp dx, cx           ; Compare remainder with divisor
    jb division_done11   ; If remainder < divisor, division is complete
    sub dx, cx           ; Subtract divisor from remainder
    inc bx               ; Increment quotient
    jmp divide_loop11    ; Repeat

division_done11:
    ; `bx` = row number, `dx` = column offset
    mov dx,bx
    call find_element_row ; (Optional: Call external function if required)
    mov cx,dx
  ;  mov dx, bx           ; Restore original quotient (row number)
    mov ax, 320
    mul bx               ; Compute row start in video memory
    
    mov dx,cx
    add ax, 172          ; Adjust to the left boundary
    cmp ax, di           ; Check if it's the desired location
    je print_the_element ; If yes, proceed to print

    xor cx, cx
loop_calculate_location:
    add ax, 8            ; Move to next column
    inc cx
    cmp ax, di           ; Check for match with `di`
    je print_the_element ; If matched, print
    jmp loop_calculate_location

    print_the_element:
    add dx, cx           ; Add column offset to base offset
    mov bx, dx           ; Store final offset in `bx`

    xor dx, dx           ; Clear `dx`

    dec bx
    mov dx, [solution + bx] ; Load solution value at offset `bx`
    add dx, 0x30            ; Convert to ASCII
    mov bx,si

    cmp dl, bl              ; Check if it matches the input value
    jne wrong                ; If not, exit
	
	
print_number_ascci:
add di,164
    mov [es:di], si  
add word [score_count],10
	xor ax,ax
	mov word ax,[score_count]
	push ax
	call printnum
jmp end1; Write the value to the video memory location
	
	  one:
	 
  mov dx,[solution+54]
 add dx,0x30
  cmp bl,dl
  je print_number_ascci
  jmp end1
  	  two:
	 
  mov dx,[solution+63]
 add dx,0x30
  cmp bl,dl
  je print_number_ascci
  jmp end1
  	  three:
	 
  mov dx,[solution+72]
 add dx,0x30
  cmp bl,dl
  je print_number_ascci
  jmp end1
  
  four:
   mov dx,[solution+18]
 add dx,0x30
  cmp bl,dl
  je print_number_ascci
  jmp end1
    five:
   mov dx,[solution+45]
 add dx,0x30
  cmp bl,dl
  je print_number_ascci
  jmp end1
  
  wrong:
  
  
  
 
    mov ax,0xb800
    mov es,ax
    mov di,942
    xor ax,ax
 
 
 cmp word [counter_check_level],1
 je deceasycounter
 cmp word [counter_check_level],0
 je decmedcounter
  cmp word [counter_check_level],2
 je dechardcounter
 jmp end1
 
 
 decmedcounter:
   dec word [counter_med]
  mov word ax,[counter_med]
  cmp ax,0
  je exit_game
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
	jmp end1
	
	 deceasycounter:
  dec word [counter]
  mov word ax,[counter]
   cmp ax,0
  je exit_game
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
	jmp end1
 
	
	 dechardcounter:
   dec word [counter_hard]
  mov word ax,[counter_hard]
   cmp ax,0
  je exit_game
  
	add ax,0x30
    mov ah,0x70
	
    mov [es:di],ax
	jmp end1
 
 

	

  

end1:
    pop si
    pop dx
    pop cx
    pop es
    pop di
    pop ax
    pop bp

    ret 2                   ; Return with 2 bytes popped from the stack

number_print:
    mov bl, al              ; Load ASCII value into `bl`
    mov bh, 0x70            ; Set attribute
    mov di,[bp-2]
    push di
    call print_ascii
;jmp pointer_movment
 cmp word [counter_check_level],1
 je jmpeasy
 cmp word [counter_check_level],0
 je jmpmed
  cmp word [counter_check_level],2
 je jmphard

 jmpeasy:
 jmp pointer_movment
 jmpmed:
 jmp pointer_movment_medium

 jmphard:
 jmp pointer_movment_hard
 



;Functions for each difficulty
  game_easy:
  push bp
  mov bp, sp
  pusha
mov word [counter_check_level],1
  sub sp, 2
  mov di, 172            ;Initial pointer position (top-left corner of the grid)
  mov [bp-2], di

  call clrscr1
  call Grid9x9
  call printUndo
 call print_card_layout
    call print_easy
   call print_timer
   call print_eas_life
   call print_notes
   call print_notes_grid
   call printscoretext

  mov di, [bp-2]
  

  

  

pointer_movment:
  mov di, [bp-2]
  mov ax, 0 
  int 0x16                ; wait for keypress

  cmp ah, 0x4D            ; Right arrow key
  je check_move_right
  cmp ah, 0x4B            ; Left arrow key
  je check_move_left
  cmp ah, 0x50            ; Down arrow key
  je check_move_down
  cmp ah, 0x48            ; Up arrow key
  je check_move_up
  cmp ah, 0x01            ; ESC key to exit
  je jmp_menu_input_level

  ; Check for number keys '1' through '9' and jump to number_print
  cmp al, 0x31            ; ASCII for '1'
  je number_print
  cmp al, 0x32            ; ASCII for '2'
  je number_print
  cmp al, 0x33            ; ASCII for '3'
  je number_print
  cmp al, 0x34            ; ASCII for '4'
  je number_print
  cmp al, 0x35            ; ASCII for '5'
  je number_print
  cmp al, 0x36            ; ASCII for '6'
  je number_print
  cmp al, 0x37            ; ASCII for '7'
  je number_print
  cmp al, 0x38            ; ASCII for '8'
  je number_print
  cmp al, 0x39            ; ASCII for '9'
  je number_print

  jmp pointer_movment     ; Loop back to wait for keypress if no matching key

  

check_move_right:
  mov di, [bp-2]        ; Load current position
  add di, 8             ; Move right by 8

  mov cx, 320            ; Load divisor (320) into cx
  mov bx, 0              ; Initialize quotient (bx) to 0
  mov dx, di             ; Store initial value of di in dx for division

divide_loop:
    cmp dx, cx         ; Compare remainder with divisor
    jb division_done   ; If remainder < divisor, division is complete
    sub dx, cx         ; Subtract divisor from remainder
    inc bx             ; Increment quotient
    jmp divide_loop    ; Repeat until dx < cx

division_done:
    ; At this point:
    ; bx = quotient
    ; dx = remainder
	mov ax,320
	mul bx

add ax,236
  cmp di, ax            ; Compare desired position with boundary
  
  ja skip               ; Skip if di > boundary

  mov [bp-2], di        ; Update position if within bounds
  call update_screen    ; Call update function

  jmp pointer_movment   ; Jump to next movement step

  


check_move_left:
    mov di, [bp-2]         ; Load current position
    sub di, 8              ; Move left by 8

    ; Custom division to calculate row (di / 320)
    mov cx, 320            ; Divisor (320)
    mov bx, 0              ; Initialize quotient to 0
    mov dx, di             ; Remainder initialized with di

divide_loop1:
    cmp dx, cx             ; Compare remainder with divisor
    jb division_done1      ; If remainder < divisor, division is done
    sub dx, cx             ; Subtract divisor from remainder
    inc bx                 ; Increment quotient
    jmp divide_loop1       ; Repeat until dx < cx

division_done1:
    ; At this point:
    ; bx = quotient (row index)
    ; dx = remainder

    ; Calculate left boundary for this row
    mov ax, 320
    mul bx                 ; ax = row number * 320
    add ax, 172            ; Left boundary for this row

    cmp di, ax             ; Check if di is below the left boundary
    jb skip1                ; Skip if di < boundary

    ; Update position and screen if within bounds
    mov [bp-2], di         ; Update position
    call update_screen     ; Update display

    jmp pointer_movment    ; Continue to next movement step

skip1:
    jmp pointer_movment    ; Skip updating position if out of bounds

check_move_down:
  mov di, [bp-2]
  add di, 320             ; Attempt to move down by one row (320 pixels)

  cmp di, 2796            ; 5116 is the last valid position in the 9x9 grid
  ja skip                 ; Skip if moving down goes out of bounds

  mov [bp-2], di          ; Update position if within bounds
  call update_screen
  jmp pointer_movment

check_move_up:
  mov di, [bp-2]
  sub di, 320             ; Attempt to move down by one row (320 pixels)
                    ; 172 is the last valid position in the 9x9 grid
  jb skip                 ; Skip if moving down goes out of bounds
cmp di,320
  mov [bp-2], di          ; Update position if within bounds
  call update_screen
  jmp pointer_movment

update_screen:
  ;call clrscr1
  call Grid9x9
  call print_eas_life
   
  mov di, [bp-2]
  push di
  call move_pointer
  ret


skip:
  jmp pointer_movment 

jmp_menu_input_level:
  popa
  ret


  
	

	 

game_medium:
    ; Implemented logic for Medium difficulty
    
   ;call print_suduko
   push bp
  mov bp, sp
  pusha
mov word [counter_check_level],0

  sub sp, 2
  mov di, 172            ; Initial pointer position (top-left corner of the grid)
  mov [bp-2], di

  call clrscr1
	call Grid9x9
	call printUndo
	call print_card_layout
	call print_medium
   call print_timer1
   call print_med_life
   call print_notes
   call print_notes_grid
      call printscoretext

  mov di, [bp-2]
  push di
  call move_pointer

pointer_movment_medium:
mov word [counter_check_level],0
  mov di, [bp-2]
  mov ah, 0 
  int 0x16                ; wait for keypress

  cmp ah, 0x4D            ; Right arrow key
  je check_move_right_medium
  cmp ah, 0x4B            ; Left arrow key
  je check_move_left_medium
  cmp ah, 0x50            ; Down arrow key
  je check_move_down_medium
  cmp ah, 0x48            ; Up arrow key
  je check_move_up_medium
  cmp ah, 0x01            ; ESC key to exit
  je jmp_menu_input_level


  
    cmp al, 0x31            ; ASCII for '1'
  je number_print
  cmp al, 0x32            ; ASCII for '2'
  je number_print
  cmp al, 0x33            ; ASCII for '3'
  je number_print
  cmp al, 0x34            ; ASCII for '4'
  je number_print
  cmp al, 0x35            ; ASCII for '5'
  je number_print
  cmp al, 0x36            ; ASCII for '6'
  je number_print
  cmp al, 0x37            ; ASCII for '7'
  je number_print
  cmp al, 0x38            ; ASCII for '8'
  je number_print
  cmp al, 0x39            ; ASCII for '9'
  je number_print

    jmp pointer_movment_medium    ; Loop back to wait for keypress if no matching key

  

check_move_right_medium:
  mov di, [bp-2]        ; Load current position
  add di, 8             ; Move right by 8

mov cx, 320            ; Load divisor (320) into cx
mov bx, 0              ; Initialize quotient (bx) to 0
mov dx, di             ; Store initial value of di in dx for division

divide_loop_medium:
    cmp dx, cx         ; Compare remainder with divisor
    jb division_done_medium   ; If remainder < divisor, division is complete
    sub dx, cx         ; Subtract divisor from remainder
    inc bx             ; Increment quotient
    jmp divide_loop_medium    ; Repeat until dx < cx

division_done_medium:
    ; At this point:
    ; bx = quotient
    ; dx = remainder
	mov ax,320
	mul bx

add ax,236
  cmp di, ax            ; Compare desired position with boundary
  
  ja skip_medium               ; Skip if di > boundary

  mov [bp-2], di        ; Update position if within bounds
  call update_screen_medium   ; Call update function

  jmp pointer_movment_medium   ; Jump to next movement step

  


check_move_left_medium:
    mov di, [bp-2]         ; Load current position
    sub di, 8              ; Move left by 8

    ; Custom division to calculate row (di / 320)
    mov cx, 320            ; Divisor (320)
    mov bx, 0              ; Initialize quotient to 0
    mov dx, di             ; Remainder initialized with di

divide_loop1_medium:
    cmp dx, cx             ; Compare remainder with divisor
    jb division_done1_medium      ; If remainder < divisor, division is done
    sub dx, cx             ; Subtract divisor from remainder
    inc bx                 ; Increment quotient
    jmp divide_loop1_medium  ; Repeat until dx < cx

division_done1_medium:
    ; At this point:
    ; bx = quotient (row index)
    ; dx = remainder

    ; Calculate left boundary for this row
    mov ax, 320
    mul bx                 ; ax = row number * 320
    add ax, 172            ; Left boundary for this row

    cmp di, ax             ; Check if di is below the left boundary
    jb skip_medium              ; Skip if di < boundary

    ; Update position and screen if within bounds
    mov [bp-2], di         ; Update position
    call update_screen_medium     ; Update display

    jmp pointer_movment_medium    ; Continue to next movement step



check_move_down_medium:
  mov di, [bp-2]
  add di, 320             ; Attempt to move down by one row (320 pixels)

  cmp di, 2796            ; 5116 is the last valid position in the 9x9 grid
  ja skip_medium                 ; Skip if moving down goes out of bounds

  mov [bp-2], di          ; Update position if within bounds
  call update_screen_medium
  jmp pointer_movment_medium

check_move_up_medium:
  mov di, [bp-2]
  sub di, 320             ; Attempt to move down by one row (320 pixels)
                    ; 172 is the last valid position in the 9x9 grid
  jb skip_medium                 ; Skip if moving down goes out of bounds
cmp di,320
  mov [bp-2], di          ; Update position if within bounds
  call update_screen_medium
  jmp pointer_movment_medium

update_screen_medium:

  call Grid9x9
  call print_med_life
  mov di, [bp-2]
  push di
  call move_pointer
  ret


skip_medium:
  jmp pointer_movment_medium 


game_hard:
    ; Implemented logic for Hard difficulty
 
  
   push bp
  mov bp, sp
  pusha
mov word [counter_check_level],2

  sub sp, 2
  mov di, 172            ; Initial pointer position (top-left corner of the grid)
  mov [bp-2], di

  call clrscr1
	call Grid9x9
	call printUndo
	call print_card_layout
	call print_hard
   call print_timer2
   call print_hard_life
   call print_notes
  call  print_notes_grid
     call printscoretext
  

  mov di, [bp-2]
  push di
  call move_pointer

pointer_movment_hard:
  mov di, [bp-2]
  mov ah, 0 
  int 0x16                ; wait for keypress

  cmp ah, 0x4D            ; Right arrow key
  je check_move_right_hard
  cmp ah, 0x4B            ; Left arrow key
  je check_move_left_hard
  cmp ah, 0x50            ; Down arrow key
  je check_move_down_hard
  cmp ah, 0x48            ; Up arrow key
  je check_move_up_hard
  cmp ah, 0x01            ; ESC key to exit
  je jmp_menu_input_level

    cmp al, 0x31            ; ASCII for '1'
  je number_print
  cmp al, 0x32            ; ASCII for '2'
  je number_print
  cmp al, 0x33            ; ASCII for '3'
  je number_print
  cmp al, 0x34            ; ASCII for '4'
  je number_print
  cmp al, 0x35            ; ASCII for '5'
  je number_print
  cmp al, 0x36            ; ASCII for '6'
  je number_print
  cmp al, 0x37            ; ASCII for '7'
  je number_print
  cmp al, 0x38            ; ASCII for '8'
  je number_print
  cmp al, 0x39            ; ASCII for '9'
  je number_print

  
  jmp pointer_movment_hard
  

check_move_right_hard:
  mov di, [bp-2]        ; Load current position
  add di, 8             ; Move right by 8

mov cx, 320            ; Load divisor (320) into cx
mov bx, 0              ; Initialize quotient (bx) to 0
mov dx, di             ; Store initial value of di in dx for division

divide_loop_hard:
    cmp dx, cx         ; Compare remainder with divisor
    jb division_done_hard   ; If remainder < divisor, division is complete
    sub dx, cx         ; Subtract divisor from remainder
    inc bx             ; Increment quotient
    jmp divide_loop_hard    ; Repeat until dx < cx

division_done_hard:
    ; At this point:
    ; bx = quotient
    ; dx = remainder
	mov ax,320
	mul bx

add ax,236
  cmp di, ax            ; Compare desired position with boundary
  
  ja skip_hard               ; Skip if di > boundary

  mov [bp-2], di        ; Update position if within bounds
  call update_screen_hard    ; Call update function

  jmp pointer_movment_hard   ; Jump to next movement step

  
   

   check_move_left_hard:
    mov di, [bp-2]         ; Load current position
    sub di, 8              ; Move left by 8

    ; Custom division to calculate row (di / 320)
    mov cx, 320            ; Divisor (320)
    mov bx, 0              ; Initialize quotient to 0
    mov dx, di             ; Remainder initialized with di
   divide_loop1_hard:
    cmp dx, cx             ; Compare remainder with divisor
    jb division_done1_hard      ; If remainder < divisor, division is done
    sub dx, cx             ; Subtract divisor from remainder
    inc bx                 ; Increment quotient
    jmp divide_loop1_hard       ; Repeat until dx < cx

   division_done1_hard:
    ; At this point:
    ; bx = quotient (row index)
    ; dx = remainder

    ; Calculate left boundary for this row
    mov ax, 320
    mul bx                 ; ax = row number * 320
    add ax, 172            ; Left boundary for this row

    cmp di, ax             ; Check if di is below the left boundary
    jb skip_hard              ; Skip if di < boundary

    ; Update position and screen if within bounds
    mov [bp-2], di         ; Update position
    call update_screen_hard     ; Update display

    jmp pointer_movment_hard    ; Continue to next movement step



    check_move_down_hard:
  mov di, [bp-2]
  add di, 320             ; Attempt to move down by one row (320 pixels)

  cmp di, 2796            ; 5116 is the last valid position in the 9x9 grid
  ja skip_hard                 ; Skip if moving down goes out of bounds

  mov [bp-2], di          ; Update position if within bounds
  call update_screen_hard
  jmp pointer_movment_hard

   check_move_up_hard:
  mov di, [bp-2]
  sub di, 320             ; Attempt to move up by one row (320 pixels)
                    ; 172 is the last valid position in the 9x9 grid
  jb skip                 ; Skip if moving down goes out of bounds
   cmp di,320
  mov [bp-2], di          ; Update position if within bounds
  call update_screen_hard
  jmp pointer_movment_hard

  update_screen_hard:
 
	call Grid9x9
 call print_hard_life
  mov di, [bp-2]
  push di
  call move_pointer
  ret


skip_hard:
  jmp pointer_movment



exit_game:
 call clrscr1
 call printgameover
 call printscoretext
 mov word ax,[score_count]
 push ax
 call printnum
   mov ax, 0 
  int 0x16  
cmp ah, 0x01            ; ESC key to exit
  je menu_input
  jmp exit_game
  
 
    mov ax, 0x4c00
    int 0x21               ;terminate program

start:
   
	
    
   ; call facee
	call clrscr
    call print_menu        ; display the main menu
    call menu_input        ; wait for input

    mov ax, 0x4c00         ; terminate program
    int 0x21


undoBoxTop: 
 db 218,196,196,196,196,196,196,196,196,196,196,196,196,196,191,0
 undoBoxTopLen:
 dw 15,0
 vert:
 db 179,0
 vertLen: dw 1 ,0
 undoBoxBott:
 db 192,196,196,196,196,196,196,196,196,196,196,196,196,196,217,0
 undoBoxBottLen:
 dw 15,0

 undo_msg:db 'UNDO BUTTON',0
 db 0
 undoLen dw 11,0
 Card1:db '               cards                 ',0
  Card2:
        db '+---+---+---+---+---+---+---+---+---+',0
  Card3:db '| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |',0
  Card4:db '+---+---+---+---+---+---+---+---+---+',0
  Card1Len : dw 37
  Card2Len : dw 37
  Card3Len : dw 37
  Card4Len : dw 37
  ascii : dw 0