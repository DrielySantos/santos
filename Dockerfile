# 1. Imagem Base
# Começamos com uma imagem leve do Python baseada no Alpine Linux.
# Isso ajuda a manter o tamanho final da nossa imagem pequeno.
FROM python:3.13.4-alpine3.22

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copiamos primeiro o arquivo de dependências e as instalamos.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 5. Expor a Porta
# Informa ao Docker que o contêiner escuta na porta 8000.
EXPOSE 8000

# 6. Comando de Execução
# Define o comando para iniciar a aplicação com uvicorn.
# Usamos --host 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]