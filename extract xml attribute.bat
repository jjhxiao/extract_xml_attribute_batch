@echo off
setlocal EnableDelayedExpansion

:: Set the input file
set "xmlFile=yourfile.xml"

:: Read the content from the file
set /p xmlContent=<%xmlFile%

:: Find the position of the search string
set "searchString=<credentials token"
set "xmlContent=!xmlContent:*%searchString%=%searchString%!"

:: Extract token value starting with the quote
for /f "tokens=2 delims==" %%a in ("!xmlContent!") do (
    set "tokenLine=%%a"
    goto process_token
)

:process_token
:: Trim leading space if present
set "tokenLine=!tokenLine:~1!"

:: Extract the token value up until the first quote which ends the value
for /f "delims=" %%b in ("!tokenLine!") do (
    set "tokenValue=%%b"
    goto print_token
)

:print_token
:: The token is extracted up to the first space, assuming no spaces are within the token
for /f tokens^=1^ delims^=^" %%c in ("!tokenValue!") do (
    set "finalToken=%%c"
)

echo !finalToken!

:: End of script, pause to view the results
pause
endlocal