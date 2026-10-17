
FROM python:3.9

WORKDIR /app/backend

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/backend/requirements.txt


RUN python -m pip install --no-cache-dir --default-timeout=300 --retries=10 -r /app/backend/requirements.txt \
    && python -m pip show Django \
    && python -m django --version

COPY . /app/backend

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
