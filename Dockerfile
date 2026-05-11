# Imagen para Railway/CI cuando el contexto es la RAÍZ del repo (no SkyAnalytics/backend).
# Si en Railway pones Root directory = SkyAnalytics/backend, usa el Dockerfile de esa carpeta.
FROM python:3.12-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY SkyAnalytics/backend/requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY SkyAnalytics/backend/ .

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
