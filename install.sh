#!/bin/bash

function install_ccls() {
	local -r prefix="$1"
	local -r tag="$2"

	# Get the source:
	if [[ ! -d "${prefix}/src/ccls" ]]; then
		mkdir -p "${prefix}/src"
		cd "${prefix}/src" \
		&& git clone --depth=1 --recursive https://github.com/MaskRay/ccls
	fi

	cd "${prefix}/src/ccls"
	git reset --hard
	git fetch origin
	git checkout "${tag}"
	git pull

	cmake                                    \
		-DCMAKE_BUILD_TYPE=Release            \
		-DCMAKE_INSTALL_PREFIX="${prefix}"    \
	&& cmake --build .                       \
	&& cmake --build . --target install      \
	&& echo "ccls succesfully installed"
}

# install_neovim_latest 6f073cc
install_ccls "${INSTALL_PREFIX}" "${CCLS_TAG}"

# vim: ts=3 sw=3 sts=0 noet :
