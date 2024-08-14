REM =========================
REM          SETUP
REM =========================

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE HWID RETRIEVER - BY XHEADED
mode con cols=65 lines=20
chcp 65001 >nul
cls


REM ======================
REM     COLOR CONSOLE
REM ======================

set "RESET=[0m"
set "Black=[30m"
set "DarkBlue=[34m"
set "Green=[32m"
set "Aqua=[36m"
set "Red=[31m"
set "Purple=[35m"
set "DarkPurple=[38;5;57m"
set "Orange=[33m"
set "White=[37m"
set "Grey=[90m"
set "LightBlue=[94m"
set "LightGreen=[92m"
set "LightAqua=[96m"
set "LightRed=[91m"
set "LightPurple=[95m"
set "LightYellow=[93m"
set "BrightWhite=[97m"

REM ======================
REM    CHECK ELEVATION
REM ======================


CALL :LOGO
ping localhost -n 2 >nul
echo   %BrightWhite%[%Orange%~%BrightWhite%] %BrightWhite%Checking Process %Orange%Elevation
ping localhost -n 2 >nul

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorLevel%" == "0" (
echo   %BrightWhite%[%LightGreen%+%BrightWhite%] %BrightWhite%Running as %LightGreen%Admin
ping localhost -n 2 >nul
GOTO HWID
) else (
echo   %BrightWhite%[%LightRed%~%BrightWhite%] %BrightWhite%Requesting administrative privileges...
timeout /t 2 /nobreak >nul
powershell -command "Start-Process -FilePath '%0' -Verb RunAs"
exit /b
)


REM =====================
REM         HWID
REM =====================

:HWID
cls
SET count=1
SET count1=1
SET count2=1
SET count3=1
SET count4=1
SET count5=1
SET count6=1
SET count7=1
SET count8=1

for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer"') do (set "Brand=%%a")

for /f "tokens=* delims=" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct"') do (set "model=%%a")

for /f "tokens=* delims=" %%f in ('wmic diskdrive get SerialNumber') do (set "serial=%%f")

FOR /F "tokens=* USEBACKQ" %%F IN (`wmic diskdrive get SerialNumber`) DO (
  SET serial!count!=%%F
  SET /a count=!count!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic cpu get name`) DO (
  SET cpuser!count1!=%%F
  SET /a count1=!count1!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic cpu get serialnumber`) DO (
  SET cpuserr!count2!=%%F
  SET /a count2=!count2!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic path Win32_ComputerSystemProduct get UUID`) DO (
  SET uuid!count3!=%%F
  SET /a count3=!count3!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic diskdrive get model`) DO (
  SET model!count4!=%%F
  SET /a count4=!count4!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`getmac`) DO (
  SET macadd!count5!=%%F
  SET /a count5=!count5!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic nic get netconnectionid`) DO (
  SET nic!count6!=%%F
  SET /a count6=!count6!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic nic get macaddress`) DO (
  SET nicadd!count7!=%%F
  SET /a count7=!count7!+1
)


FOR /F "tokens=* USEBACKQ" %%F IN (`wmic memorychip get SerialNumber`) DO (
  SET memser!count8!=%%F
  SET /a count8=!count8!+1
)
GOTO Print


:Print
cls
mode con cols=65 lines=45
call :LOGO
echo]
echo]
call :c 0f " Motherboard" /n
call :c 0d " Brand: " &call :c 0f "%Brand:~36%" /n
call :c 0d " Model: " &call :c 0f "%model:~34%" /n
call :c 0d " UUID:  " &call :c 8f "  %uuid2%" /n
echo]
call :c 0f " RAM" /n
call :c 0d " DIM1: " &call :c 8f " %memser2% " /n
call :c 0d " DIM2: " &call :c 8f " %memser3% " /n
call :c 0d " DIM3: " &call :c 8f " %memser4% " /n
call :c 0d " DIM4: " &call :c 8f " %memser5% " /n
echo]
call :c 0f " Processor" /n
call :c 0d " Name: " &call :c 0f "%cpuser2%" /n
call :c 0d " CPUID: " &call :c 0f "%cpuserr2%" /n
echo]
call :c 0f " Drives" /n
call :c 0d " Drive 1: " &call :c 0f "%model2%" /n
call :c 0f "           -"
call :c 8f "%serial2%" /n
echo]
call :c 0d " Drive 2: " &call :c 0f "%model3%" /n
call :c 0f "           -"
call :c 8f "%serial3%" /n
echo]
call :c 0d " Drive 3: " &call :c 0f "%model4%" /n
call :c 0f "           -"
call :c 8f "%serial4%" /n
echo]
call :c 0d " Drive 4: " &call :c 0f "%model5%" /n
call :c 0f "           -"
call :c 8f "%serial5%" /n
echo]
call :c 0d " Drive 5: " &call :c 0f "%model6%" /n
call :c 0f "           -"
call :c 8f "%serial6%" /n
echo]
echo]
call :c d0 " PRESS ANY KEY TO REPRINT HWID " /n
pause >nul
GOTO HWID



REM ======================
REM     LOGO FUNCTION
REM ======================

:LOGO
echo]
echo 	%LightPurple%██%BrightWhite%╗  %LightPurple%██%BrightWhite%╗%LightPurple%██%BrightWhite%╗    %LightPurple%██%BrightWhite%╗%LightPurple%██%BrightWhite%╗%LightPurple%██%LightPurple%██%LightPurple%██%BrightWhite%╗     %LightPurple%██%LightPurple%██%LightPurple%██%BrightWhite%╗%LightPurple%██%BrightWhite%╗  %LightPurple%██%BrightWhite%╗
echo 	%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║    %LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%╔══%LightPurple%██%BrightWhite%╗   %LightPurple%██%BrightWhite%╔════╝%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║
echo 	%LightPurple%██%LightPurple%██%LightPurple%███%BrightWhite%║%LightPurple%██%BrightWhite%║ %LightPurple%█%BrightWhite%╗ %LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║   %LightPurple%██%BrightWhite%║     %LightPurple%██%LightPurple%██%LightPurple%███%BrightWhite%║
echo 	%LightPurple%██%BrightWhite%╔══%LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║%LightPurple%███%BrightWhite%╗%LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║   %LightPurple%██%BrightWhite%║     %LightPurple%██%BrightWhite%╔══%LightPurple%██%BrightWhite%║
echo 	%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║╚%LightPurple%███%BrightWhite%╔%LightPurple%███%BrightWhite%╔╝%LightPurple%██%BrightWhite%║%LightPurple%██%LightPurple%██%LightPurple%██%BrightWhite%╔╝%LightPurple%██%BrightWhite%╗╚%LightPurple%██%LightPurple%██%LightPurple%██%BrightWhite%╗%LightPurple%██%BrightWhite%║  %LightPurple%██%BrightWhite%║
echo 	╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝
echo]
echo]
goto :eof


REM =======================
REM     COLOR FUNCTION
REM =======================

:c
setlocal enableDelayedExpansion
:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b

:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b

:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b