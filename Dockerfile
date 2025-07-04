FROM alpine
WORKDIR /srv/streamlink-service
ENV PORT=8080 WORKERS=2 TMPDIR=/dev/shm
EXPOSE $PORT
ADD main.py gunicorn.conf.py ./
RUN apk update &&                                                       \
    apk add --no-cache python3 py-pip py-flask py3-gunicorn git tzdata; \
    pip --no-cache-dir install --break-system-packages                  \
        git+https://github.com/vstavrinov/streamlink.git;               \
    apk del git
CMD gunicorn --workers $WORKERS --bind 0.0.0.0:$PORT main:app
