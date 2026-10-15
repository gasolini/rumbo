FROM python:3.11-slim

WORKDIR /rumbo

# Instalar dependencias necesarias para compilar o descargar datos
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código del proyecto
COPY . .

# Variables de entorno para que Flask no intente abrir navegador y escuche en 0.0.0.0
ENV PYTHONUNBUFFERED=1
ENV PATRIMONIO_HOST=0.0.0.0
ENV PATRIMONIO_NO_ABRIR=1
ENV PATRIMONIO_PUERTO=8765

# Exponer el puerto por defecto de Rumbo
EXPOSE 8765

# Arrancar la aplicación
CMD ["python", "-c", "from app.servidor import main; main()"]