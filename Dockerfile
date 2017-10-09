FROM powerbr/redkong2
MAINTAINER Alexandre Vasconcellos, alexv@cpqd.com.br

RUN luarocks install json4lua && \
    echo "export LUA_PATH='./?.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/usr/lib64/lua/5.1/?.lua;/usr/lib64/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua'" >> ~/.bashrc

RUN mkdir -p /home/pepkong/src

COPY pepkong-*.rockspec /home/pepkong/
COPY src/ /home/pepkong/src

RUN cd /home/pepkong && luarocks make

RUN mkdir /etc/kong && echo "custom_plugins = pepkong" >> /etc/kong/kong.conf

ENV PATH="/usr/local/nginx/sbin:$PATH:/usr/local/kong/bin"
