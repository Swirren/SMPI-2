@echo off

::Information gathering
:root

set MPIVersion=0.1.0
set GitVersion=0.1.0
set IntendedGameVersion=1.19.2

set JavaFolder=%ProgramFiles%\Java\jre1.8.0_291
set JavaFile=\bin\javaw.exe
set JavaVersion=Java 1.8.0 r291

set ForgeFolder=%AppData%\.minecraft\versions\1.19.2-forge-43.1.1
set ForgeFile=1.19.2-forge-43.1.1.json
set ForgeVersion=Forge-1.19.2-43.1.1

set ModFolder=%AppData%\.minecraft\mods
set Mod1=[1]
set Mod2=[2]
set Mod3=[3]
set Mod4=[4]
set Mod5=[5]
::and so on

echo BEGIN LOG... %date% %time% > %~dp0\log.srmp
echo Current user: %userprofile% %time % %time% >> %~dp0\log.srmp
net session
if %errorlevel% equ 0 (echo Admin rights detected. %time % %time% >> %~dp0\log.srmp) else (echo Admin rights denied. %time% >> %~dp0\log.srmp)

echo Running local version %MPIversion%, and Github version %GitVersion%... %time% >> %~dp0\log.srmp

::Welcome screen
:welcomescreen
cls & color F0
mode con cols=82 lines=25
echo Showing welcome screen... %time% >> %~dp0\log.srmp
echo.
echo.
echo.
echo                                  Version %MPIVersion%
echo               Thanks for downloading Swirren's modpack installer for:
echo                                  Forge %IntendedGameVersion%
echo.
echo                             All code was handwritten.
echo           If the console reports any errors that re-running the program
echo                  does not fix, create an issue report on Github
echo                          and attach the "log.srmp" file.
echo.
echo.
echo.

%SystemRoot%\System32\choice.exe /C YME1 /N /M " [Press Y to continue, or press M to display the mod list.]                                                                                                          [Press E to exit.]"

if %errorlevel% equ 1 echo Choice returned a value of 1 (Y=Continue) %time% >> %~dp0\log.srmp & (goto Y_continue_WS)
if %errorlevel% equ 2 echo Choice returned a value of 2 (M=Modlist) %time% >> %~dp0\log.srmp & (goto L_modlist_WS)
if %errorlevel% equ 3 echo Choice returned a value of 3 (E=Exit) %time% >> %~dp0\log.srmp & (goto e_exit_WS)
if %errorlevel% equ 4 echo Choice returned a value of 4 (1=Devmenu) %time% >> %~dp0\log.srmp & (goto 1_devmenu_WS)

::Mod List
:L_modlist_WS
cls
echo.
echo  Mod List:
echo.
echo 1. %Mod1%
echo 2. %Mod2%
echo 3. %Mod3%
echo 4. %Mod4%
echo 5. %Mod5%
echo.
%SystemRoot%\System32\choice.exe /C B /N /M " [Press B to return to the menu.]
if %errorlevel% equ 1 echo Choice returned a value of 1 (B=Mainmenu) %time% >> %~dp0\log.srmp & (goto welcomescreen)

::Main Installation String
:Y_continue_WS
cls & color 04
echo Attempting to kill the Minecraft.exe task...
echo Attempting to kill the Minecraft.exe task... %time% >> %~dp0\log.srmp
taskkill /f /im Minecraft.exe
timeout /t 3 /nobreak > NUL
cls & color 0F

::Java check
cls
echo    Please wait a moment... Searching for a pre-existing installation 
echo     of %JavaVersion%...
echo Checking for a pre-existing installation of Java via %JavaFolder%... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL
if exist "%JavaFolder%\%JavaFile%" (color 0A & echo %JavaVersion% has already been installed on this computer! & echo Found a pre-existing installation of Java, continuing... %time% >> %~dp0\log.srmp & timeout /t 3 /nobreak > NUL & goto javacheck_exist) else (goto javacheck_nojava)

::No java
:javacheck_nojava
cls
echo No pre-existing %JavaVersion% installation found.
echo No pre-existing %JavaVersion% installation found. %time% >> %~dp0\log.srmp
echo Please click YES when asked to in the upcoming popup. Installing Java is required!
timeout /t 3 /nobreak > NUL
echo Installing Java... %time% >> %~dp0\log.srmp
goto installjava

::Install Java
:installjava
echo Installing Java (required...)
echo Installing Java... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL
cd %~dp0/
jre64.exe
goto javarecheck

::Re-check Java
:javarecheck
cls
echo Checking for Java again...
echo Checking for Java again... %time% >> %~dp0\log.srmp
if exist "%JavaFolder%\%JavaFile%" (color 0A & echo Java has successfully been installed! & echo Java was successfully installed... %time% >> %~dp0\log.srmp & timeout /t 3 /nobreak > NUL & goto javacheck_exist) else (echo Java was not installed correctly, trying again. & goto installjava)

::Forge check
:javacheck_exist
cls
color 0F
echo    Please wait a moment... Searching for a pre-existing installation
echo     of %ForgeVersion%...
echo Checking for a pre-existing installation of Forge via %ForgeVersion%... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL
if exist "%ForgeFolder%\%ForgeFile%" (color 0A & echo %ForgeVersion% has already been installed on this computer! & echo Found a pre-existing installation of Forge, continuing... %time% >> %~dp0\log.srmp & timeout /t 3 /nobreak > NUL & goto modinstall) else (goto forgecheck_noforge)

::No forge
:forgecheck_noforge
cls
echo No pre-existing %ForgeVersion% installation found.
echo No pre-existing %ForgeVersion% installation found. %time% >> %~dp0\log.srmp
echo Please click OK when asked to in the upcoming popup. Installing Forge is required!
timeout /t 3 /nobreak > NUL
echo Installing Forge... %time% >> %~dp0\log.srmp
goto installforge

::Install Forge
:installforge
echo Installing Forge (required...)
echo Installing Forge... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL
cd %~dp0/
forge-1.19.2-43.1.1-installer.jar
goto forgerecheck

::Re-check Forge
:forgerecheck
cls
echo Checking for Forge again...
echo Checking for Forge again... %time% >> %~dp0\log.srmp
if exist "%ForgeFolder%\%ForgeFile%" (color 0A & echo Forge has successfully been installed! & echo Forge was successfully installed... %time% >> %~dp0\log.srmp & timeout /t 3 /nobreak > NUL & goto modinstall) else (echo Forge was not installed correctly, trying again. & goto installforge)

::Forge exists, mod install
:modinstall
cls
color 0F
echo Installing mods...
echo Installing mods... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL

copy /v /y %Mod1% %ModFolder%
copy /v /y %Mod2% %ModFolder%
copy /v /y %Mod3% %ModFolder%
copy /v /y %Mod4% %ModFolder%
copy /v /y %Mod5% %ModFolder%

if exist "%ModFolder%\%Mod1%" (color 0A & echo Assuming all mods are installed... %time% >> %~dp0\log.srmp) else (echo Mods are not installed... %time% >> %~dp0\log.srmp)
echo Mods installed, wrapping up!
timeout /t 3 /nobreak > NUL
goto endscreen

::Completion screen
:endscreen
cls & color A0
echo.
echo.
echo.
echo                              Installation complete!
echo.
echo           This installer will now attempt to open the Minecraft launcher.
echo                      Select the Forge 1.19.2 profile there.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
cd "C:\XboxGames\Minecraft Launcher\Content"
Minecraft.exe
goto end

::Dev Menu
:1_devmenu_WS
cls & color 40
echo.
echo                          Welcome to the developer menu.
echo.
echo If you're here by accident, don't worry. Press B to return to the main menu.
echo Or, view a list of possible actions.
echo.
echo Press F for a sped-up version of the normal process.
echo    - Normally, there are programmed delays to allow the
echo       reader to view what's going on.
echo.
echo Press D to delete all files relating to this installer.
echo    - THIS INCLUDES PRE-EXISTING FILES!
echo.
echo Press S to navigate to the end screen. This does
echo    - not modify/copy any files.
echo.
echo Press K to kill the Minecraft launcher task, then reopen it.
echo.
%SystemRoot%\System32\choice.exe /C BFDSK /N /M " [Press B to return to the menu.]
if %errorlevel% equ 1 echo Choice returned a value of 1 (B=Mainmenu) %time% >> %~dp0\log.srmp & (goto welcomescreen)
if %errorlevel% equ 2 echo Choice returned a value of 2 (F=Fastversion) %time% >> %~dp0\log.srmp & (goto fastversion)
if %errorlevel% equ 3 echo Choice returned a value of 3 (D=Deleteall) %time% >> %~dp0\log.srmp & (goto deleteall)
if %errorlevel% equ 4 echo Choice returned a value of 4 (S=Endscreen) %time% >> %~dp0\log.srmp & (goto endscreen)
if %errorlevel% equ 5 echo Choice returned a value of 5 (K=Killtask) %time% >> %~dp0\log.srmp & (cls & color 04 & taskkill /f /im Minecraft.exe & timeout /t 3 /nobreak > NUL & echo Restarting the launcher... & cd "C:\XboxGames\Minecraft Launcher\Content"& Minecraft.exe & timeout /t 3 /nobreak > NUL & goto 1_devmenu_WS)

::Fast Version
:fastversion

echo Attempting to kill the Minecraft.exe task... %time% >> %~dp0\log.srmp
taskkill /f /im Minecraft.exe
echo Checking for a pre-existing installation of Java via %JavaFolder%... %time% >> %~dp0\log.srmp
if exist "%JavaFolder%\%JavaFile%" (echo Found a pre-existing installation of Java, continuing... %time% >> %~dp0\log.srmp & goto javacheck_exist_fast) else (goto javacheck_nojava_fast)
:javacheck_nojava_fast
echo No pre-existing %JavaVersion% installation found. %time% >> %~dp0\log.srmp
echo Installing Java... %time% >> %~dp0\log.srmp
goto installjava_fast
:installjava_fast
echo Installing Java... %time% >> %~dp0\log.srmp
cd %~dp0/
jre64.exe
goto javarecheck_fast
:javarecheck_fast
echo Checking for Java again... %time% >> %~dp0\log.srmp
if exist "%JavaFolder%\%JavaFile%" (echo Java was successfully installed... %time% >> %~dp0\log.srmp & goto javacheck_exist_fast) else (goto installjava_fast)
:javacheck_exist_fast
echo Checking for a pre-existing installation of Forge via %ForgeVersion%... %time% >> %~dp0\log.srmp
if exist "%ForgeFolder%\%ForgeFile%" (echo Found a pre-existing installation of Forge, continuing... %time% >> %~dp0\log.srmp & goto modinstall_fast) else (goto forgecheck_noforge_fast)
:forgecheck_noforge_fast
echo No pre-existing %ForgeVersion% installation found. %time% >> %~dp0\log.srmp
echo Installing Forge... %time% >> %~dp0\log.srmp
goto installforge
:installforge_fast
echo Installing Forge... %time% >> %~dp0\log.srmp
cd %~dp0/
forge-1.19.2-43.1.1-installer.jar
goto forgerecheck_fast
:forgerecheck_fast
echo Checking for Forge again... %time% >> %~dp0\log.srmp
if exist "%ForgeFolder%\%ForgeFile%" (echo Forge was successfully installed... %time% >> %~dp0\log.srmp & goto modinstall_fast) else (goto installforge_fast)
:modinstall_fast
echo Installing mods... %time% >> %~dp0\log.srmp
copy /v /y %Mod1% %ModFolder%
copy /v /y %Mod2% %ModFolder%
copy /v /y %Mod3% %ModFolder%
copy /v /y %Mod4% %ModFolder%
copy /v /y %Mod5% %ModFolder%
if exist "%ModFolder%\%Mod1%" (echo Assuming all mods are installed... %time% >> %~dp0\log.srmp) else (echo Mods are not installed... %time% >> %~dp0\log.srmp)
goto Endscreen

:deleteall
cls & color 04
rd /s /q "%JavaFolder%"
echo Deleted %JavaVersion% installation...
echo Deleted %JavaVersion% installation... %time% >> %~dp0\log.srmp
rd /s /q "%ForgeFolder%"
echo Deleted %ForgeVersion% installation...
echo Deleted %ForgeVersion% installation... %time% >> %~dp0\log.srmp
cd "%ModFolder%"
del /q %Mod1%
del /q %Mod2%
del /q %Mod3%
del /q %Mod4%
del /q %Mod5%
echo Deleted specific mods from %ModFolder%...
echo Deleted specific mods from %ModFolder%... %time% >> %~dp0\log.srmp
timeout /t 3 /nobreak > NUL
pause
goto 1_devmenu_WS


:E_exit_WS
echo Closing from welcome screen... %time% >> %~dp0\log.srmp
echo END LOG... %date% %time% > %~dp0\log.srmp
exit

:end
echo Closing from endscreen... %time% >> %~dp0\log.srmp
echo END LOG... %date% %time% > %~dp0\log.srmp
exit