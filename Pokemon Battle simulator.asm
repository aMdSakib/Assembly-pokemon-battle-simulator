.MODEL SMALL

.STACK 100H

.DATA
PromptPlayer1 DB "Player1,choose your Pokemon (1.Charizard,2.Pikachu,3.Lucario,4.Blissy,5.Steelix: $"
PromptPlayer2 DB "Player2,choose your Pokemon (1.Charizard,2.Pikachu,3.Lucario,4.Blissy,5.Steelix: $"
InvalidChoice DB "Invalid choice. Try again.$"
Player1Choice DB "Player 1's Pokemon is faster! $"
Player2Choice DB "Player 2's Pokemon is faster! $" 
Prompteve DB "Do you wish to proceed? y to contine, n to exit $"


Player1Attacks DB "Player 1 attacks! $"
Player2Attacks DB "Player 2 attacks! $"
Player1Heals DB "Player 1 heals! $"
Player2Heals DB "Player 2 heals! $" 

Player1Wins DB "Player 1 wins! $"
Player2Wins DB "Player 2 wins! $"
 
Charizard DB "Charizard, Fire, HP: 297, Attack: 254, Defense: 206, Speed: 90$"
Pikachu DB "Pikachu, Electric, HP: 181, Attack: 309, Defense: 136, Speed: 100$"
Lucario DB "Lucario, Fighting, HP: 281, Attack: 266, Defense: 176, Speed: 70$"
Blissy DB "Blissy, Normal, HP: 651, Attack: 56, Defense: 181, Speed: 55$"
Steelix DB "Steelix, Ground, HP: 291, Attack: 146, Defense: 436, Speed: 30$" 

HealFailMessage DB "HP Full,Turn Wasated!$"

Choice1 DB ?
Choice2 DB ? 
 
ChoicePrompt DB "Choose action (a.Attack, b.Heal): $"
InvalidAction DB "Invalid action. Try again.$"

charizard_stat dw 297,254,206,90
piakachu_stat dw 181,309,136,100
lucario_stat dw 281,266,176,70
blissy_stat dw 651,56,181,55
steelix_stat dw 291,146,436,30

p1_HP dw 0
p2_HP dw 0
p1_speed dw 0
p2_speed dw 0

P1_wins DW 0
P2_wins DW 0

.CODE
MAIN PROC
    ; Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX


Player1Loop:  ;p1 chose pkmn 
    LEA DX, Prompteve
    MOV AH, 09H
    INT 21H
    
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    
    MOV AH, 01H
    INT 21H
    CMP AL, 'n'
    JE exitcon
    CMP AL, 'y'
    JE Continue
    LEA DX, InvalidAction
    MOV AH, 09H
    INT 21H 
      ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    JMP Player1Loop
    
Continue:    
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
     

    LEA DX, PromptPlayer1
    MOV AH, 09H
    INT 21H 

    MOV AH, 01H
    INT 21H
    SUB AL, 30h
    MOV Choice1, AL
    mov bl, al

    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    mov al, bl

    CMP AL, 1
    JL InvalidPlayer1
    CMP AL, 5
    JG InvalidPlayer1
    JMP ValidPlayer1

InvalidPlayer1:
    LEA DX, InvalidChoice
    MOV AH, 09H
    INT 21H
    JMP Player1Loop

ValidPlayer1:
    CMP Choice1, 1
    JE DisplayCharizard1
    CMP Choice1, 2
    JE DisplayPikachu1
    CMP Choice1, 3
    JE DisplayLucario1
    CMP Choice1, 4
    JE DisplayBlissy1
    CMP Choice1, 5
    JE DisplaySteelix1

DisplayCharizard1:
    LEA DX, Charizard
    JMP DisplayPokemon1
DisplayPikachu1:
    LEA DX, Pikachu
    JMP DisplayPokemon1
DisplayLucario1:
    LEA DX, Lucario
    JMP DisplayPokemon1
DisplayBlissy1:
    LEA DX, Blissy
    JMP DisplayPokemon1
DisplaySteelix1:
    LEA DX, Steelix

DisplayPokemon1:
    MOV AH, 09H
    INT 21H
    JMP Player2Loop


Player2Loop:  ; Player 2 pkmn
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h 

    LEA DX, PromptPlayer2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30h
    MOV Choice2, AL
    mov bl, al

    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h 

    mov al, bl

    CMP AL, 1
    JL InvalidPlayer2
    CMP AL, 5
    JG InvalidPlayer2
    JMP ValidPlayer2

InvalidPlayer2:
    LEA DX, InvalidChoice
    MOV AH, 09H
    INT 21H
    JMP Player2Loop

ValidPlayer2:
    CMP Choice2, 1
    JE DisplayCharizard2
    CMP Choice2, 2
    JE DisplayPikachu2
    CMP Choice2, 3
    JE DisplayLucario2
    CMP Choice2, 4
    JE DisplayBlissy2
    CMP Choice2, 5
    JE DisplaySteelix2

DisplayCharizard2:
    LEA DX, Charizard
    JMP DisplayPokemon2
DisplayPikachu2:
    LEA DX, Pikachu
    JMP DisplayPokemon2
DisplayLucario2:
    LEA DX, Lucario
    JMP DisplayPokemon2
DisplayBlissy2:
    LEA DX, Blissy
    JMP DisplayPokemon2
DisplaySteelix2:
    LEA DX, Steelix

DisplayPokemon2:
    MOV AH, 09H
    INT 21H


SpeedComparison:
    
    CMP Choice1, 1
    JE GetSpeed1Charizard
    CMP Choice1, 2
    JE GetSpeed1Pikachu
    CMP Choice1, 3
    JE GetSpeed1Lucario
    CMP Choice1, 4
    JE GetSpeed1Blissy
    CMP Choice1, 5
    JE GetSpeed1Steelix

GetSpeed1Charizard:
    MOV AX, [charizard_stat + 6]   
    JMP CompareSpeed

GetSpeed1Pikachu:
    MOV AX, [piakachu_stat + 6]    
    JMP CompareSpeed

GetSpeed1Lucario:
    MOV AX, [lucario_stat + 6]     
    JMP CompareSpeed

GetSpeed1Blissy:
    MOV AX, [blissy_stat + 6]      
    JMP CompareSpeed

GetSpeed1Steelix:
    MOV AX, [steelix_stat + 6]     
    JMP CompareSpeed

CompareSpeed:
 
    MOV BX, AX     ;Player 1's speed
    mov [p1_speed], BX

    ; Player 2's Speed
    CMP Choice2, 1
    JE GetSpeed2Charizard
    CMP Choice2, 2
    JE GetSpeed2Pikachu
    CMP Choice2, 3
    JE GetSpeed2Lucario
    CMP Choice2, 4
    JE GetSpeed2Blissy
    CMP Choice2, 5
    JE GetSpeed2Steelix

GetSpeed2Charizard:
    MOV AX, [charizard_stat + 6]   
    JMP DisplaySpeedComparison

GetSpeed2Pikachu:
    MOV AX, [piakachu_stat + 6]    
    JMP DisplaySpeedComparison

GetSpeed2Lucario:
    MOV AX, [lucario_stat + 6]     
    JMP DisplaySpeedComparison

GetSpeed2Blissy:
    MOV AX, [blissy_stat + 6]      
    JMP DisplaySpeedComparison

GetSpeed2Steelix:
    MOV AX, [steelix_stat + 6]     
    JMP DisplaySpeedComparison

DisplaySpeedComparison:
    
    mov [p2_speed], AX
    CMP BX, AX
    JG Player1Faster
    JL Player2Faster

Player1Faster:
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h    
    
    LEA DX, Player1Choice
    MOV AH, 09H
    INT 21H
    jmp start:
Player2Faster:
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h 
 
    LEA DX, Player2Choice
    MOV AH, 09H
    INT 21H  
    jmp Start:
    
Start:
    ; Load ini HP 
    CMP Choice1, 1
    JE LoadHP1Charizard
    CMP Choice1, 2
    JE LoadHP1Pikachu
    CMP Choice1, 3
    JE LoadHP1Lucario
    CMP Choice1, 4
    JE LoadHP1Blissy
    CMP Choice1, 5
    JE LoadHP1Steelix

LoadHP1Charizard:
    MOV AX, [charizard_stat]
    MOV p1_HP, AX
    JMP LoadHP2
LoadHP1Pikachu:
    MOV AX, [piakachu_stat]
    MOV p1_HP, AX
    JMP LoadHP2
LoadHP1Lucario:
    MOV AX, [lucario_stat]
    MOV p1_HP, AX
    JMP LoadHP2
LoadHP1Blissy:
    MOV AX, [blissy_stat]
    MOV p1_HP, AX
    JMP LoadHP2
LoadHP1Steelix:
    MOV AX, [steelix_stat]
    MOV p1_HP, AX

LoadHP2:
    CMP Choice2, 1
    JE LoadHP2Charizard
    CMP Choice2, 2
    JE LoadHP2Pikachu
    CMP Choice2, 3
    JE LoadHP2Lucario
    CMP Choice2, 4
    JE LoadHP2Blissy
    CMP Choice2, 5
    JE LoadHP2Steelix

LoadHP2Charizard:
    MOV AX, [charizard_stat]
    MOV p2_HP, AX
    JMP Battle
LoadHP2Pikachu:
    MOV AX, [piakachu_stat]
    MOV p2_HP, AX
    JMP Battle
LoadHP2Lucario:
    MOV AX, [lucario_stat]
    MOV p2_HP, AX
    JMP Battle
LoadHP2Blissy:
    MOV AX, [blissy_stat]
    MOV p2_HP, AX
    JMP Battle
LoadHP2Steelix:
    MOV AX, [steelix_stat]
    MOV p2_HP, AX

Battle:
    
    MOV AX, [P1_speed]
    CMP AX, [p2_speed] ;faster one moves
    JG Player1Turn
    JL Player2Turn

Player1Turn:
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    LEA DX, ChoicePrompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    CMP AL, 'a'
    JE Player1Attack
    CMP AL, 'b'
    JE Player1Heal
    LEA DX, InvalidAction
    MOV AH, 09H
    INT 21H
    JMP Player1Turn

Player1Attack:
    LEA DX, Player1Attacks
    MOV AH, 09H
    INT 21H

    ; Calculate damage: p2_HP -= ((player1[attack] / player2[defense]) * 60)
    CMP Choice1, 1
    JE AttackCharizard
    CMP Choice1, 2
    JE AttackPikachu
    CMP Choice1, 3
    JE AttackLucario
    CMP Choice1, 4
    JE AttackBlissy
    CMP Choice1, 5
    JE AttackSteelix

AttackCharizard:
    MOV AX, [charizard_stat + 2]
    JMP DefenseCalc
AttackPikachu:
    MOV AX, [piakachu_stat + 2]
    JMP DefenseCalc
AttackLucario:
    MOV AX, [lucario_stat + 2]
    JMP DefenseCalc
AttackBlissy:
    MOV AX, [blissy_stat + 2]
    JMP DefenseCalc
AttackSteelix:
    MOV AX, [steelix_stat + 2]

DefenseCalc:
    MOV CX, AX
    CMP Choice2, 1
    JE DefenseCharizard
    CMP Choice2, 2
    JE DefensePikachu
    CMP Choice2, 3
    JE DefenseLucario
    CMP Choice2, 4
    JE DefenseBlissy
    CMP Choice2, 5
    JE DefenseSteelix

DefenseCharizard:
    MOV AX, [charizard_stat + 4]
    JMP DamageCalc
DefensePikachu:
    MOV AX, [piakachu_stat + 4]
    JMP DamageCalc
DefenseLucario:
    MOV AX, [lucario_stat + 4]
    JMP DamageCalc
DefenseBlissy:
    MOV AX, [blissy_stat + 4]
    JMP DamageCalc
DefenseSteelix:
    MOV AX, [steelix_stat + 4]

DamageCalc:
    MOV DX, 0                
    CMP AX, 1                
    JG SafeToDivide          
    MOV AX, 1                

SafeToDivide:
    DIV AX                   
    MOV CX, 60               
    MUL CX                   
    SUB p2_HP, AX            
    JMP CheckWin


Player1Heal:
    LEA DX, Player1Heals
    MOV AH, 09H
    INT 21H
; Heal  P1
:
    
    CMP Choice1, 1
    JE HealCharizard1
    CMP Choice1, 2
    JE HealPikachu1
    CMP Choice1, 3
    JE HealLucario1
    CMP Choice1, 4
    JE HealBlissy1
    CMP Choice1, 5
    JE HealSteelix1

HealCharizard1:
    MOV AX, [charizard_stat+0] 
    JMP HealProcess1

HealPikachu1:
    MOV AX, [piakachu_stat+0] 
    JMP HealProcess1

HealLucario1:
    MOV AX, [lucario_stat+0] 
    JMP HealProcess1

HealBlissy1:
    MOV AX, [blissy_stat+0] 
    JMP HealProcess1

HealSteelix1:
    MOV AX, [steelix_stat+0] 

HealProcess1:
    ; AX  holds base HP of pkmn , bx current hp
    MOV BX, p1_HP             
    CMP BX, AX                
    JGE HealFail1             


    MOV CX, AX                
    SHR CX, 2                 
    ADD BX, CX                
    CMP BX, AX                
    JLE HealDone1
    MOV BX, AX; error handling                

HealDone1:
    MOV p1_HP, BX             
    JMP Player2turn               

HealFail1:
    
    LEA DX, HealFailMessage
    MOV AH, 09H
    INT 21H
    JMP Player2turn; move wasted



HealSuccess:
    MOV AX, [charizard_stat+0] 
    ADD p1_HP, AX
    JMP Player2Turn

CheckWin:
    MOV AX, p2_HP
    CMP AX, 0
    JLE Player1WinsMsg

    MOV AX, p1_HP
    CMP AX, 0
    JLE Player2WinsMsg

    JMP Player2Turn

Player1WinsMsg:
    LEA DX, Player1Wins
    MOV AH, 09H
    INT 21H
    Add P1_wins, 1
    
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    JMP Player1Loop

Player2WinsMsg:
    LEA DX, Player2Wins
    MOV AH, 09H
    INT 21H
    Add P2_wins, 1
    
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    JMP Player1Loop

Player2Turn:
    ; Next Line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    LEA DX, ChoicePrompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    CMP AL, 'a'
    JE Player2Attack
    CMP AL, 'b'
    JE Player2Heal
    LEA DX, InvalidAction
    MOV AH, 09H
    INT 21H
    JMP Player2Turn

Player2Attack:
    LEA DX, Player2Attacks
    MOV AH, 09H
    INT 21H

    ; Calculate damage: p1_HP -= ((player2[attack] / player1[defense]) * 60)
    CMP Choice2, 1
    JE AttackCharizard2
    CMP Choice2, 2
    JE AttackPikachu2
    CMP Choice2, 3
    JE AttackLucario2
    CMP Choice2, 4
    JE AttackBlissy2
    CMP Choice2, 5
    JE AttackSteelix2

AttackCharizard2:
    MOV AX, [charizard_stat + 2]
    JMP DefenseCalc2
AttackPikachu2:
    MOV AX, [piakachu_stat + 2]
    JMP DefenseCalc2
AttackLucario2:
    MOV AX, [lucario_stat + 2]
    JMP DefenseCalc2
AttackBlissy2:
    MOV AX, [blissy_stat + 2]
    JMP DefenseCalc2
AttackSteelix2:
    MOV AX, [steelix_stat + 2]

DefenseCalc2:
    MOV CX, AX
    CMP Choice1, 1
    JE DefenseCharizard2
    CMP Choice1, 2
    JE DefensePikachu2
    CMP Choice1, 3
    JE DefenseLucario2
    CMP Choice1, 4
    JE DefenseBlissy2
    CMP Choice1, 5
    JE DefenseSteelix2

DefenseCharizard2:
    MOV AX, [charizard_stat + 4]
    JMP DamageCalc2
DefensePikachu2:
    MOV AX, [piakachu_stat + 4]
    JMP DamageCalc2
DefenseLucario2:
    MOV AX, [lucario_stat + 4]
    JMP DamageCalc2
DefenseBlissy2:
    MOV AX, [blissy_stat + 4]
    JMP DamageCalc2
DefenseSteelix2:
    MOV AX, [steelix_stat + 4]

DamageCalc2:
    MOV DX, 0                
    CMP AX, 1                
    JG SafeToDivide2         
    MOV AX, 1                

SafeToDivide2:
    DIV AX                   
    MOV CX, 60              
    MUL CX                  
    SUB p1_HP, AX            
    JMP CheckWin2


Player2Heal:
    LEA DX, Player2Heals
    MOV AH, 09H
    INT 21H

    ; Heal logic for Player 2
    CMP Choice2, 1
    JE HealCharizard2
    CMP Choice2, 2
    JE HealPikachu2
    CMP Choice2, 3
    JE HealLucario2
    CMP Choice2, 4
    JE HealBlissy2
    CMP Choice2, 5
    JE HealSteelix2

HealCharizard2:
    MOV AX, [charizard_stat+0] ;
    JMP HealProcess2
HealPikachu2:
    MOV AX, [piakachu_stat+0] ;
    JMP HealProcess2
HealLucario2:
    MOV AX, [lucario_stat+0] ; 
    JMP HealProcess2
HealBlissy2:
    MOV AX, [blissy_stat+0] ;
    JMP HealProcess2
HealSteelix2:
    MOV AX, [steelix_stat+0] ;

HealProcess2:
    MOV BX, p2_HP             
    CMP BX, AX                
    JGE HealFail2             

    
    MOV CX, AX               
    SHR CX, 2                
    ADD BX, CX                
    CMP BX, AX                
    JLE HealDone2
    MOV BX, AX                

HealDone2:
    MOV p2_HP, BX            
    JMP Player1Turn           

HealFail2:
    LEA DX, HealFailMessage
    MOV AH, 09H
    INT 21H
    JMP Player1Turn         

CheckWin2:
    MOV AX, p1_HP
    CMP AX, 0
    JLE Player2WinsMsg

    MOV AX, p2_HP
    CMP AX, 0
    JLE Player1WinsMsg

    JMP Player1Turn

exitcon:

EndProgram:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN