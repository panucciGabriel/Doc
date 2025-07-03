# 1. Use an official Python runtime as a parent image
# Usar a variante 'slim' é uma boa prática para imagens menores
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho no contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências para o diretório de trabalho
# Isso é feito primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# 4. Instalar os pacotes especificados no requirements.txt
# --no-cache-dir reduz o tamanho da imagem, --upgrade pip é uma boa prática
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o contêiner
COPY . .

# 6. Expor a porta em que o aplicativo é executado
EXPOSE 8000

# 7. Definir o comando para executar o aplicativo
# Use 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]