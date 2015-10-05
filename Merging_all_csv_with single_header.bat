@echo off
ECHO Set working directory
echo %cd%
pushd %~dp0

REM Adding a folder named "Merged_Folder" in present current Directory	 
mkdir %cd%\new\MERGED_FOLDER

ECHO Deleting existing MERGED file
REM Deleting already existing file if there in the folder
del new\MERGED_FOLDER\MERGED.csv
setlocal ENABLEDELAYEDEXPANSION
REM set count to 1
set cnt=1
REM for each file that matches in Folder named "new"  *.csv extension 
for %%i in (new\*.csv) do (
REM if count is 1 it's the first time running
  if !cnt!==1 (
REM push the entire file complete with header into MERGED.csv - this will also create MERGED.csv
    for /f "delims=" %%j in ('type "%%i"') do echo %%j>>new\MERGED_FOLDER\MERGED.csv
REM otherwise, make sure we're not working with the MERGED file and
  ) else if %%i NEQ MERGED.csv (
REM push the file without the header into MERGED.csv
    for /f "skip=1 delims=" %%j in ('type "%%i"') do echo %%j>>new\MERGED_FOLDER\MERGED.csv
  )
REM increment count by 1
  set /a cnt+=1
)
