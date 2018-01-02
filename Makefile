NAME = ketohub_web_app
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
SHA1 = $(shell git rev-parse HEAD)
TOKEN = sW8jrLD4FxUSVEPdCr2l2IWXNvL4rRyJdX1UvNF+lUqcWrerQPDJaVNXBMVWxtU5fKB9+2b7Gl4jnC4OjEtt8NkJeeBLh6+YZy/JW+mMkiFJVWWzx3DuJNJtBnoDJsyovADahVbZRxZPY4wGPsnmfY56wHmB061wy/h48ws1pE9jelZW0vzgqyabw3SNT+mK40wbJSHL1R3ik6DFON67ubuclOMdIw19q/Dyx1ItjioXYXJgC11F2c6Y2pU3sFBU/6xzLF/xevPS146hGriaDBuERl0OP6RfPMZx2N9ZVyVGIuiNicknEWM0WsHe7Ia53il7YbTnJXu+my4k1XFlN/0DxTlZkLb2dhh2n3dEHmUhcW0KxjOjx3ypcx0CevsJJgJ1EfZglHPr+MUM++SST0PkHStD0kbzv/ReKdbLFJRDeZirtM6txmx7aIrTf8av7jSHfItJ0C/9vK8+Xiea4uucSS8QDmR6qtq6xWkx2D1XT7mqjIZHcP0CIujMMb6H6Ga46FCFVMK7ycImjr3JkpBie8AwBr49upjhBnyaSiZvu9TZCJsOU4X1mmAfWC6BnXhllQcDXX/uJAsz173C0Mgvng+5NaYiG7YuxWX3Tj5aS6mVifqiFRzfZyflAP40js8tjKmuiFvdXw21nTdYktLilwgw3gqO5SAP3e6iQBc=

.PHONY: build coverage

all: build

build:
	docker build --build-arg FIREBASE_TOKEN=$(TOKEN) --build-arg BRANCH=$(BRANCH) -t $(NAME):$(SHA1) -f Dockerfile .

coverage:
	docker run --name builder $(NAME):$(SHA1) echo "Container created"
	docker cp builder:/app/coverage/ ./coverage/
	cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js
