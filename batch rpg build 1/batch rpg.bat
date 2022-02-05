echo off
setlocal enabledelayedexpansion
mode 100,27
set build=1
set space=" "
title batch rpg build !build!
cd "%~dp0"/bin

:menu
cls
echo.
echo  batch rpg build !build! !debug!
echo.
echo  1. Continue
echo  2. New
echo  3. Information
echo  4. Exit
choice /c 12348d /n
if !errorlevel! equ 1 goto load
if !errorlevel! equ 2 goto new
if !errorlevel! equ 3 goto info
if !errorlevel! equ 4 exit
if !errorlevel! equ 5 set debug=true
if !errorlevel! equ 6 if !debug! equ true goto debug
goto menu

:info
cls
echo.
echo  batch rpg build !build! - Information
echo.
echo  Created and programmed by: @ripbarns
echo.
echo  Additional help: u/Shadow_Thief
echo.
echo  Follow me on all major platforms.
echo.
echo  Press any key to continue.
pause > nul
goto menu

:debug
cls
echo.
set /p input=debug: 
!input!
goto debug

:new
cls
set HPM=10
set HPC=10
set ATK=2
set DEF=1
set X=33
set Y=10
goto map

:save
cls
(
	echo !HPM!
	echo !HPC!
	echo !ATK!
	echo !DEF!
	echo !X!
	echo !Y!
) > save.txt

goto screen

:load
cls
< save.txt (
	set /p HPM=
	set /p HPC=
	set /p ATK=
	set /p DEF=
	set /p X=
	set /p Y=
)

goto map

:map
set temp=0

for /f "tokens=*" %%a in (map.txt) do (
	set line!temp!=%%a
	set /a temp=!temp! + 1
	echo [3;2HLoading map...
)

goto refresh

:refresh
set /a W=!X! - 32
set /a Z=!X! + 1

set /a U0=!Y! - 1
set /a U1=!Y! - 2
set /a U2=!Y! - 3
set /a U3=!Y! - 4
set /a U4=!Y! - 5
set /a U5=!Y! - 6
set /a U6=!Y! - 7
set /a U7=!Y! - 8
set /a U8=!Y! - 9
set /a U9=!Y! - 10

set /a D0=!Y! + 1
set /a D1=!Y! + 2
set /a D2=!Y! + 3
set /a D3=!Y! + 4
set /a D4=!Y! + 5
set /a D5=!Y! + 6
set /a D6=!Y! + 7
set /a D7=!Y! + 8
set /a D8=!Y! + 9
set /a D9=!Y! + 10

set lineU0=!line%U0%:~%W%,65!
set lineU1=!line%U1%:~%W%,65!
set lineU2=!line%U2%:~%W%,65!
set lineU3=!line%U3%:~%W%,65!
set lineU4=!line%U4%:~%W%,65!
set lineU5=!line%U5%:~%W%,65!
set lineU6=!line%U6%:~%W%,65!
set lineU7=!line%U7%:~%W%,65!
set lineU8=!line%U8%:~%W%,65!
set lineU9=!line%U9%:~%W%,65!

set lineD0=!line%D0%:~%W%,65!
set lineD1=!line%D1%:~%W%,65!
set lineD2=!line%D2%:~%W%,65!
set lineD3=!line%D3%:~%W%,65!
set lineD4=!line%D4%:~%W%,65!
set lineD5=!line%D5%:~%W%,65!
set lineD6=!line%D6%:~%W%,65!
set lineD7=!line%D7%:~%W%,65!
set lineD8=!line%D8%:~%W%,65!
set lineD9=!line%D9%:~%W%,65!

set linechar=!line%Y%:~%W%,32!@!line%Y%:~%Z%,32!

if !X! lss 1000 set fillerX= 
if !X! lss 100 set fillerX=  
if !X! lss 10 set fillerX=   

if !Y! lss 1000 set fillerY= 
if !Y! lss 100 set fillerY=  
if !Y! lss 10 set fillerY=   

goto screen

:screen
echo [3;2H##################################################################################################
echo  # !lineU9! #                            #
echo  # !lineU8! #                            #
echo  # !lineU7! #                            #
echo  # !lineU6! #                            #
echo  # !lineU5! #                            #
echo  # !lineU4! #                            #
echo  # !lineU3! #                            #
echo  # !lineU2! #                            #
echo  # !lineU1! #                            #
echo  # !lineU0! #                            #
echo  # !linechar! #                            #
echo  # !lineD0! #                            #
echo  # !lineD1! #                            #
echo  # !lineD2! #                            #
echo  # !lineD3! #                            #
echo  # !lineD4! #                            #
echo  # !lineD5! #                            #
echo  # !lineD6! # "!line%Y%:~%X%,1!"                        #
echo  # !lineD7! # [M] Save                   #
echo  # !lineD8! ##############################
echo  # !lineD9! # (!X!,!Y!) !fillerX!!fillerY!               #
echo  ##################################################################################################
choice /t 1 /d x /c wasdmx /n
if !errorlevel! equ 1 goto move
if !errorlevel! equ 2 goto move
if !errorlevel! equ 3 goto move
if !errorlevel! equ 4 goto move
if !errorlevel! equ 5 goto save
if !errorlevel! equ 6 goto refresh
goto screen

:move
if !errorlevel! equ 1 set /a Y=!Y! - 1
if !errorlevel! equ 2 set /a X=!X! - 1
if !errorlevel! equ 3 set /a Y=!Y! + 1
if !errorlevel! equ 4 set /a X=!X! + 1

goto collide

:collide
if "!line%Y%:~%X%,1!" equ "p" call :X!X!Y!Y!

if "!line%Y%:~%X%,1!" neq !space! (
	if !errorlevel! equ 1 set /a Y=!Y! + 1
	if !errorlevel! equ 2 set /a X=!X! + 1
	if !errorlevel! equ 3 set /a Y=!Y! - 1
	if !errorlevel! equ 4 set /a X=!X! - 1
)

goto refresh