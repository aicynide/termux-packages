TERMUX_PKG_HOMEPAGE=https://github.com/5rahim/seanime
TERMUX_PKG_DESCRIPTION="Self-hosted anime and manga server for sea rovers."
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.1.0"
TERMUX_PKG_SRCURL=https://github.com/5rahim/seanime/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=983e2678819b92369036660fad5e6876faea92afa652236049b58c3e8ec1d32d
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_HOSTBUILD=true

termux_step_host_build() {
	termux_setup_nodejs

	cp -r $TERMUX_PKG_SRCDIR/seanime-web ./seanime-web
	cd seanime-web
	npm install
	npm run build
}

termux_step_pre_configure() {
	mkdir $TERMUX_PKG_SRCDIR/web
	cp -r $TERMUX_PKG_HOSTBUILD_DIR/seanime-web/out $TERMUX_PKG_SRCDIR/web/

	termux_setup_golang
}

termux_step_make() {
	go build -o seanime main.go
}

termux_step_make_install() {
	install -Dm700 -t "${TERMUX_PREFIX}"/bin "$TERMUX_PKG_SRCDIR"/seanime
}
