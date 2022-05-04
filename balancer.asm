; Verifies the balance of string delimiters.
; CSC 225, Assignment 4
; Given code, Spring '22

            .ORIG x3000

MAIN        LEA R1, STACK   ; Initialize R1, the stack pointer.
            LEA R0, PROMPT  ; Print the prompt.
            PUTS

            ; TODO: Complete this program:
            ;       If an opening delimiter is typed, push it onto the stack.
            ;       If a closing delimiter is typed, pop an opening delimiter
            ;        off of the stack and ensure that they match.
            ;       When the expression ends, ensure that the stack is empty.
            
            AND R2, R2, #0
            ADD R2, R2, #5
            JSR PUSH
            
LOOP1       GETC                ; While the user types characters...
            OUT                 ; ...echo the character...
            LD  R5, NEW_OFFSET  ; Load a "negative newline" into R5
            ADD R4, R0, R5      ; ...add the character plus negative newline into R4
            BRz DONE            ; ...is not the newline...
            ADD R4, R4, #10
            
            LD R2, O1 ; check for '(' -- OPEN
            ADD, R2, R2, R0
            BRnp #2
            ADD, R2, R2, R0
            JSR PUSH
            
            LD R2, O2 ; check for '[' -- OPEN
            ADD, R2, R2, R0
            BRnp #2
            ADD, R2, R2, R0
            JSR PUSH
            
            LD R2, O3 ; check for '{' -- OPEN
            ADD, R2, R2, R0
            BRnp #2
            ADD, R2, R2, R0
            JSR PUSH
            
            LD R2, C1 ; check for ')' -- CLOSED
            ADD, R2, R2, R0
            BRz CHECK1
            BRnzp #1
            
BCK1        JSR POP
            LD R2, C2 ; check for ']' -- CLOSED
            ADD, R2, R2, R0
            BRz CHECK2
            BRnzp #1
            
BCK2        JSR POP
            LD R2, C3 ; check for '}' -- CLOSED
            ADD, R2, R2, R0
            BRz CHECK3
            BRnzp #1
            
BCK3        JSR POP
            BRnzp LOOP1
            
;       When the expression ends, ensure that the stack is empty.
DONE        JSR PEEK
            LD R0, O1
            ADD R0, R0, R2
            BRnp FOO
            LEA R0, ERR2
            BRnzp PRINT
            
FOO         LD R0, O2
            ADD R0, R0, R2
            BRnp HAROLD
            LEA R0, ERR1
            Brnzp PRINT
            
HAROLD      LD R0, O3
            ADD R0, R0, R2
            BRnp KUMAR
            LEA R0, ERR3
            Brnzp PRINT            
            
KUMAR            LEA R0, YAY  ; Print the prompt.
PRINT       PUTS
            HALT

; Space for a stack with capacity 16:
            .BLKW #16
STACK       .FILL x00

YAY         .STRINGZ "Delimeters are balanced."

; TODO: Add any additional required constants or subroutines below this point.
PROMPT      .STRINGZ "Enter a string: "

NEW_OFFSET  .FILL x-0A

CHECK1      JSR PEEK
            ADD R2, R2, #-5 ; check if end of stack --> Expected: "("
            BRnp #3
            LEA R0, ERR5
            PUTS
            HALT
            ADD R2, R2, #5
            LD R0, O1
            ADD R0, R0, R2
            BRz BCK1
            BRp #4
            BRn #2
            JSR POP
            LEA R0, ERR1
            BRnzp #1
            LEA R0, ERR3
            PUTS
            HALT
            
            
CHECK2      JSR PEEK
            ADD R2, R2, #-5 ; check if end of stack --> Expected: "["
            BRnp #3
            LEA R0, ERR4
            PUTS
            HALT
            ADD R2, R2, #5
            LD R0, O2 ; check 
            ADD R0, R0, R2
            BRp #4
            BRn #1
            BRnzp BCK2
            LEA R0, ERR2
            BRnzp #1
            LEA R0, ERR3
            PUTS
            HALT
            
CHECK3      JSR PEEK ; check if end of stack --> Expected: "{"
            ADD R2, R2, #-5
            BRnp #3
            LEA R0, ERR6
            PUTS
            HALT
            ADD R2, R2, #5
            LD R0, O3
            ADD R0, R0, R2
            BRz BCK3
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #5
            BRp #4
            BRn #2
            JSR POP
            LEA R0, ERR2
            BRnzp #1
            LEA R0, ERR1
            PUTS
            HALT
            BRnzp LOOP1 

O1          .FILL xFFD8 ; -(
C1          .FILL xFFD7 ; -)

O2          .FILL xFFA5 ; -[
C2          .FILL xFFA3 ; -]

O3          .FILL xFF85 ; -{  
C3          .FILL xFF83 ; -}

ERR1        .STRINGZ "\nDelimeters are not balanced. Expected ']'."
ERR2        .STRINGZ "\nDelimeters are not balanced. Expected ')'."
ERR3        .STRINGZ "\nDelimeters are not balanced. Expected '}'."
ERR4        .STRINGZ "\nDelimeters are not balanced. Expected '['."
ERR5        .STRINGZ "\nDelimeters are not balanced. Expected '('."
ERR6        .STRINGZ "\nDelimeters are not balanced. Expected '{'."

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH        ST  R6, PUSHR6
            ST  R7, PUSHR7
            LDI R6, PUSHADDR
            JSRR R6
            LD  R7, PUSHR7
            LD  R6, PUSHR6
            RET

PUSHR6      .FILL x0000
PUSHR7      .FILL x0000
PUSHADDR    .FILL x4000

POP         ST  R6, POPR6
            ST  R7, POPR7
            LDI R6, POPADDR
            JSRR R6
            LD  R7, POPR7
            LD  R6, POPR6
            RET

POPR6       .FILL x0000
POPR7       .FILL x0000
POPADDR     .FILL x4001

PEEK        ST  R6, PEEKR6
            ST  R7, PEEKR7
            LDI R6, PEEKADDR
            JSRR R6
            LD  R7, PEEKR7
            LD  R6, PEEKR6
            RET

PEEKR6      .FILL x0000
PEEKR7      .FILL x0000
PEEKADDR    .FILL x4002

            .END
