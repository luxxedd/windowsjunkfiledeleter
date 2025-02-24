@echo off
title Temp File Cleaner
:: Check if script is running as Administrator
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit
)

echo ===================================================
echo       Temp, Windows Temp, Prefetch, and Downloaded Program Files Cleaner
echo ===================================================
echo Opening temporary file locations...
start "" "%temp%"
start "" "C:\Windows\Temp"
start "" "C:\Windows\Prefetch"
start "" "C:\Windows\Downloaded Program Files"

echo ===================================================
echo Do you want to delete all files in these folders? (Y/N)
set /p choice=Enter your choice: 

if /I "%choice%"=="Y" (
    echo Deleting temporary files...
    
    :: Delete Temp Files
    if exist "%temp%" (
        del /s /f /q "%temp%\*.*" 2>nul
        for /d %%p in ("%temp%\*") do rmdir /s /q "%%p" 2>nul
    )

    if exist "C:\Windows\Temp" (
        del /s /f /q "C:\Windows\Temp\*.*" 2>nul
        for /d %%p in ("C:\Windows\Temp\*") do rmdir /s /q "%%p" 2>nul
    )

    if exist "C:\Windows\Prefetch" (
        del /s /f /q "C:\Windows\Prefetch\*.*" 2>nul
        for /d %%p in ("C:\Windows\Prefetch\*") do rmdir /s /q "%%p" 2>nul
    )

    if exist "C:\Windows\Downloaded Program Files" (
        del /s /f /q "C:\Windows\Downloaded Program Files\*.*" 2>nul
        for /d %%p in ("C:\Windows\Downloaded Program Files\*") do rmdir /s /q "%%p" 2>nul
    )

    echo Cleanup completed.
) else (
    echo Cleanup canceled.
)

pause
exit
