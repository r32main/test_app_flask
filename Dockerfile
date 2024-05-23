# Вказуємо базовий образ
FROM python:3.8-slim AS builder

# Встановлюємо залежності
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Використовуємо багатоступеневу збірку для зменшення розміру фінального образу
FROM builder

# Додаємо користувача і створюємо відповідні директорії
RUN useradd -m myuser
WORKDIR /home/myuser/app
COPY . .

# Виставляємо порти і змінюємо власника файлів
EXPOSE 5000
RUN chown -R myuser:myuser /home/myuser/app
USER myuser

# Команда для запуску додатку
ENTRYPOINT [ "python" ]
CMD ["app.py"]
