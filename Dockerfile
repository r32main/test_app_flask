# Вказуємо базовий образ
FROM python:3.8-slim

# Встановлюємо залежності
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Виставляємо порти і змінюємо власника файлів
EXPOSE 80
RUN mkdir -p /home/myuser/app && useradd -r myuser && chown myuser:myuser /home/myuser/app
USER myuser

# Копіюємо файли проекту та виконуємо додаток
WORKDIR /home/myuser/app
COPY . .

# Команда для запуску додатку
ENTRYPOINT [ "python" ]
CMD ["app.py"]
