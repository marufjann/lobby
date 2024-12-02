# Используйте минимальный базовый образ для Python
FROM python:3.11-slim

# Устанавливаем переменные окружения для предотвращения буферизации вывода и установки Django в production-режим
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Устанавливаем необходимые системные пакеты, включая Nginx
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nginx \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Создаем директорию для приложения
WORKDIR /app

# Копируем файл requirements.txt и устанавливаем зависимости
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальной код приложения в контейнер
COPY . /app/


# Копируем конфигурацию Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Открываем порты для приложения (например, 8000 для Gunicorn и 80 для Nginx)
EXPOSE 8000 80

# Запуск Gunicorn и Nginx
CMD ["sh", "-c", "nginx && gunicorn --bind 0.0.0.0:8000 app.wsgi:application"]
