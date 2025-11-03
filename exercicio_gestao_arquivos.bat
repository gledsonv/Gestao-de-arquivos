@echo off
setlocal

set BASE_DIR=%SystemDrive%\GestorArquivos
set DOC_DIR=%BASE_DIR%\Documentos
set LOG_DIR=%BASE_DIR%\Logs
set BAK_DIR=%BASE_DIR%\Backups
set LOG_FILE=%LOG_DIR%\atividade.log

set /a "pastas_criadas=0"
set /a "arquivos_criados=0"

if not exist "%BASE_DIR%" (
    mkdir "%BASE_DIR%"
    set /a "pastas_criadas+=1"
)

if not exist "%LOG_DIR%" (
    mkdir "%LOG_DIR%"
    set /a "pastas_criadas+=1"
    
    set "DT_STAMP=%DATE% %TIME%"
    echo %DT_STAMP% - Criacao Pasta Logs - Sucesso >> "%LOG_FILE%"
    echo %DT_STAMP% - Criacao Pasta Base - Sucesso >> "%LOG_FILE%"
) else (
    set "DT_STAMP=%DATE% %TIME%"
    echo %DT_STAMP% - Criacao Pasta Logs - Ja Existe >> "%LOG_FILE%"
    echo %DT_STAMP% - Criacao Pasta Base - Ja Existe >> "%LOG_FILE%"
)

set "DT_STAMP=%DATE% %TIME%"
if not exist "%DOC_DIR%" (
    mkdir "%DOC_DIR%"
    echo %DT_STAMP% - Criacao Pasta Documentos - Sucesso >> "%LOG_FILE%"
    set /a "pastas_criadas+=1"
) else (
    echo %DT_STAMP% - Criacao Pasta Documentos - Ja Existe >> "%LOG_FILE%"
)

set "DT_STAMP=%DATE% %TIME%"
if not exist "%BAK_DIR%" (
    mkdir "%BAK_DIR%"
    echo %DT_STAMP% - Criacao Pasta Backups - Sucesso >> "%LOG_FILE%"
    set /a "pastas_criadas+=1"
) else (
    echo %DT_STAMP% - Criacao Pasta Backups - Ja Existe >> "%LOG_FILE%"
)

set "DT_STAMP=%DATE% %TIME%"
echo Este e o relatorio principal. > "%DOC_DIR%\relatorio.txt"
echo Contem dados criticos. >> "%DOC_DIR%\relatorio.txt"
echo %DT_STAMP% - Criacao Arquivo relatorio.txt - Sucesso >> "%LOG_FILE%"
set /a "arquivos_criados+=1"

set "DT_STAMP=%DATE% %TIME%"
echo ID,Produto,Quantidade > "%DOC_DIR%\dados.csv"
echo 1,Caneta,50 >> "%DOC_DIR%\dados.csv"
echo 2,Papel,500 >> "%DOC_DIR%\dados.csv"
echo %DT_STAMP% - Criacao Arquivo dados.csv - Sucesso >> "%LOG_FILE%"
set /a "arquivos_criados+=1"

set "DT_STAMP=%DATE% %TIME%"
echo [Geral] > "%DOC_DIR%\config.ini"
echo Ativado=1 >> "%DOC_DIR%\config.ini"
echo Servidor=producao >> "%DOC_DIR%\config.ini"
echo %DT_STAMP% - Criacao Arquivo config.ini - Sucesso >> "%LOG_FILE%"
set /a "arquivos_criados+=1"

set "DT_STAMP=%DATE% %TIME%"
set "BACKUP_TIMESTAMP=%DT_STAMP%"

copy "%DOC_DIR%\*.*" "%BAK_DIR%\"

if %ERRORLEVEL% equ 0 (
    echo %DT_STAMP% - Backup de Documentos - Sucesso >> "%LOG_FILE%"
) else (
    echo %DT_STAMP% - Backup de Documentos - Falha >> "%LOG_FILE%"
)

set "DT_STAMP=%DATE% %TIME%"
echo Backup concluido em: %BACKUP_TIMESTAMP% > "%BAK_DIR%\backup_completo.bak"
echo %DT_STAMP% - Criacao Arquivo backup_completo.bak - Sucesso >> "%LOG_FILE%"
set /a "arquivos_criados+=1"

set "DT_STAMP=%DATE% %TIME%"
echo RELATORIO DE EXECUCAO > "%BASE_DIR%\resumo_execucao.txt"
echo ---------------------- >> "%BASE_DIR%\resumo_execucao.txt"
echo Total de arquivos criados: %arquivos_criados% >> "%BASE_DIR%\resumo_execucao.txt"
echo Total de pastas criadas: %pastas_criadas% >> "%BASE_DIR%\resumo_execucao.txt"
echo Data/Hora do backup: %BACKUP_TIMESTAMP% >> "%BASE_DIR%\resumo_execucao.txt"

echo %DT_STAMP% - Geracao Relatorio Final - Sucesso >> "%LOG_FILE%"
set /a "arquivos_criados+=1"

echo.
echo Script finalizado.
echo Verifique a pasta %BASE_DIR% para ver os resultados.
echo.

endlocal