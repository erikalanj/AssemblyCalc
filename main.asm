data
menu: 
.asciiz "\n\n********************** Main Menu **********************\n (1) Option 1 (miles to kilometer calculator)\n 
(2) Option 2 (fahrenheit to celsius calculator)\n (3) Option 3 (current from voltage calculator)\n (0) 
Exit\n*********************************************************\n 
Please enter an option: "
goodbye: 
.asciiz "\n************************ Goodbye!! *************************\n" 
miles_prompt: 
.asciiz "Enter distance in miles: "
miles_result: 
.asciiz "Distance in kilometers: "
temperature_prompt: 
.asciiz "Enter temperature in Fahrenheit: "
temperature_result: 
.asciiz "Temperature in Celsius: "
prompt_voltage: .asciiz "Enter voltage: "
prompt_resistor1: .asciiz "Enter resistor R1: "
prompt_resistor2: .asciiz "Enter resistor R2: "
prompt_resistor3: .asciiz "Enter resistor R3: "
result_current: .asciiz "Total current: "
case_2: 
.asciiz "\nYou selected option 2"
case_3: 
.asciiz "\nYou selected option 3"
clear: 
.asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
 
.text
main:
jal clear_screen
main_menu:
 
li $v0, 4 
# Print String
 
la $a0, menu 
# Choose menu
 
syscall 
 
# Input an integer
 
li 
$v0,5 
 
syscall 
 
 
move $t0, $v0
 
beq 
$t0,0, exit 
 
beq 
$t0,1, case1
 
beq 
$t0,2, case2
 
beq 
$t0,3, case3 
case1: 
 
# Print the prompt to ask the user for input
 
li $v0, 4 
# System call code for print string
 
la $a0, miles_prompt 
# Load the address of the prompt string
 
syscall
 
# Read user input 
 
li $v0, 5 
# System call code for read integer
 
syscall
 
move $t0, $v0 
# Store the input in $t0
 
# Perform the conversion
 
li $t1, 160934 
# conversion: 1 mile = 160934 mm
 
mul $t0, $t0, $t1 # convert miles to mm
 
# Divide mm by 1000 to get kilometers
 
li $t2, 1000
 
div $t0, $t2 
# Divide the result in $t0 by 1000
 
mflo $t0 
# Store the quotient in $t0 (kilometers)
 
# Print the result
 
li $v0, 4 
# System call code for print string
 
la $a0, miles_result 
# Load the address of the result string
 
syscall
 
li $v0, 1 
# System call code for print integer
 
move $a0, $t0 
# Load the converted value to be printed
 
syscall
 
b 
main_menu
case2: 
 
# Print the prompt to ask the user for input
 
li $v0, 4
 
la $a0, temperature_prompt
 
syscall
 
# Read fahrenheit input
 
li $v0, 5
 
syscall
 
move $t0, $v0
 
# convert fahrenheit to celsius
 
li $t1, 32
 
sub $t0, $t0, $t1
 
li $t2, 5
 
mul $t0, $t0, $t2
 
li $t2, 9
 
div $t0, $t2
 
mflo $t0

 
# Print the result
 
li $v0, 4
 
la $a0, temperature_result
 
syscall
 
li $v0, 1
 
move $a0, $t0
 
syscall
 
b 
main_menu
case3: 
 
# Print prompts to ask for input
 
li $v0, 4
 
la $a0, prompt_voltage
 
syscall
 
# Read voltage input
 
li $v0, 5
 
syscall
 
move $t0, $v0
 
li $v0, 4
 
la $a0, prompt_resistor1
 
syscall
 
# Read R1 input
 
li $v0, 5
 
syscall
 
move $t1, $v0
 
li $v0, 4
 
la $a0, prompt_resistor2
 
syscall
 
# Read R2 input
 
li $v0, 5
 
syscall
 
move $t2, $v0
 
li $v0, 4
 
la $a0, prompt_resistor3
 
syscall
 
# Read R3 input
 
li $v0, 5
 
syscall
 
move $t3, $v0
 
# Calculate total resistance
 
add $t4, $t1, $t2 # R1 + R2
 
add $t4, $t4, $t3 # Rt = R1 + R2 + R3
 
# Calculate total current (I) by dividing total voltage by total resistance
 
div $t0, $t4
 
mflo $t5 # Store quotient in $t5 (I)
 
 
 
 
# Print results
 
li $v0, 4
 
la $a0, result_current
 
syscall
 
 
li $v0, 1
 
move $a0, $t5
 
syscall
 
 
b 
main_menu
END_SWITCH:
exit: 
 
li $v0, 4 
# syscall 4 (print_str)
 
la $a0, goodbye # argument: string
 
syscall 
 
li $v0,10 
#Exit
 
syscall 
clear_screen:
 
li $v0, 4 
# syscall 4 (print_str)
 
la $a0, clear # argument: string
 
syscall 
 
 
 
lw $t0, 0($sp) 
# Load previous value
 
addi $sp,$sp,4 
# Moving Stack pointer
 
jr $ra # return
