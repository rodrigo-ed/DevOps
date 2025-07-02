FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker: se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da sua aplicação para o diretório de trabalho no contêiner.
COPY . .

# Expõe a porta 8000, que é a porta padrão que o Uvicorn usa.
# Isso informa ao Docker para escutar nesta porta no momento da execução.
EXPOSE 8000

# Define o comando para iniciar a aplicação quando o contêiner for executado.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
