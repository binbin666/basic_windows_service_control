@REM @Author: rancho
@REM @Date:   2015-05-20 10:36:30
@REM @Last Modified by:   rancho
@REM Modified time: 2017-09-19 08:14:50

::::::::::::::::::::::     gotAdmin begin
@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
::::::::::::::::::::::     gotAdmin end


::::::::::::::::::::::     Basic service manage begin
@echo off
echo ========================================================
echo ========== press "1" to start Basic service ============
echo ========== press "2" to stop Basic service  ============
echo ========== press "4" to list Basic service =============
echo ================  press "3" to exit    =================
echo ========================================================
echo.
echo.
goto tmp

:tmp
Choice /c 1234 /n /m "please enter your choice ( 1, 2, 3 or 4 ): "
@echo off
set serviceList="Bonjour Service" "HuaweiHiSuiteService64.exe" "XLServicePlatform" "TeamViewer" "TxQBService" "VPNService" "wwbizsrv" "Apple Mobile Device Service" "OpenVPNServiceInteractive" "OpenVPNService" "SangforSP" "AdobeARMservice"
if '%errorlevel%' EQU '1' goto batStart
if '%errorlevel%' EQU '2' goto batStop
if '%errorlevel%' EQU '3' goto batExit
if '%errorlevel%' EQU '4' goto batList
echo "non-choice"
echo.
goto tmp

:batStart
for %%I in (%serviceList%) do net start %%I

echo =========== Basic service has been running now, enjoy it! ==========
goto tmp

:batStop
for %%I in (%serviceList%) do net stop %%I

echo =========== Basic service has benn stoped now, enjoy it! ===========
goto tmp

:batList
for %%I in (%serviceList%) do echo %%I

echo =========== Basic service has benn listed above, enjoy it! ===========
goto tmp

:batExit
echo =========== you are going to exit this windows! ===========
pause
exit
::::::::::::::::::::::     Basic service manage end