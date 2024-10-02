@echo off
setlocal enabledelayedexpansion

REM 设置要删除的文件夹和文件
set FOLDER1=Build
set FOLDER2=TemplateData
set FILE=index.html

REM 设置要复制的源文件夹路径
set SOURCE_DIR=..\

REM 循环执行
:loop
    REM 删除文件夹和文件
    if exist %FOLDER1% (
        rmdir /s /q %FOLDER1%
    )
    if exist %FOLDER2% (
        rmdir /s /q %FOLDER2%
    )
    if exist %FILE% (
        del /f /q %FILE%
    )

    REM 复制文件夹和文件
    xcopy /E /I /Y "%SOURCE_DIR%\%FOLDER1%" "%FOLDER1%"
    xcopy /E /I /Y "%SOURCE_DIR%\%FOLDER2%" "%FOLDER2%"
    copy /Y "%SOURCE_DIR%\%FILE%" "%FILE%"

    REM Git 操作
    git add .
    git commit -m "Auto commit"
    git push

    REM 等待1分钟
    timeout /t 60

    REM 回到循环
    goto loop