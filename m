Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66987C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 19:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB0B88D08;
	Thu, 29 Aug 2024 21:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y37eM66C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9856388D06; Thu, 29 Aug 2024 21:30:05 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA14188D07
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 21:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a4df9dc885so90149585a.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724959801; x=1725564601; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eoOl23WcNO1mfZF/G+/faQK2BorghJftO1uUCz3cBkk=;
 b=Y37eM66CntPq65Q5BYna8OqRM4cKx/zXPKTChe6fWRi49x+sxrvrhtVRHZEWI06CTU
 Yp2c0tadx8h+Tr+n2LKbMzmEFZudlh0479dnFwQAoyLq4xbaZoz6Bb0Va1Wbda91aV7A
 LdLRcUsIvRaaRT/IK6NCjkoq/iEMGb5IC9NLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724959801; x=1725564601;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eoOl23WcNO1mfZF/G+/faQK2BorghJftO1uUCz3cBkk=;
 b=tjjJcFIwJWHzePsC4yfapr1ghK9XeOOdnhT2OtMZbP4Lt7H6VtqZS6iEuVnMDlLkxp
 8krHHZfAwzb8ORJq+3GD+KrReNvIsrgulSEcPZhaYKhKfrYPQIc+kSYBBcvQ9FbFZ/lv
 zbJmTfO7c5LYqF2QtHzU/qa9SjzZlAKVyKHBvSje9c0OZaGUELcoxRvZemHcPTmtgoXc
 xDTtgwa8IbuF08DCJtpJjHF7CXstyT7aliHL/VFc4fA5xYvLIQRKUw8D2tdWx0b8LAXE
 BiPMPDCaewnoRBW1PLKzjd9sSdcifSSuNvPPGB85afvwYPQvjyeeBTTj0wKh3QH0ztTp
 RKDg==
X-Gm-Message-State: AOJu0YzyZhmOpxsWhNJmSpWzM7BDYa1B4gJPjGM8rIs4pnShVraSzwaM
 chcahDPEYQ09irVOo+uLuidZgFfV4pN9cpaZ9oZIj+OBok36cyhqApHAOVPXXyfyTJRTbJUBB7z
 M
X-Google-Smtp-Source: AGHT+IHzzVFPYTQmoVmEGHCZ1cffaz09LrSrOicvMXB3R4Uf7eWujyOp3G4G+/1Nm2sL+RwDP6iVgA==
X-Received: by 2002:a05:620a:63c4:b0:79f:741:5d4f with SMTP id
 af79cd13be357-7a8084a7cc6mr670731285a.3.1724959801205; 
 Thu, 29 Aug 2024 12:30:01 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d61de2sm78721785a.114.2024.08.29.12.30.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 12:30:00 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:29:58 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: My labgrid setup
Message-ID: <20240829192958.GO2479150@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4vYfD0iVJZ+c2TXk"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--4vYfD0iVJZ+c2TXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So now that I've posted my u-boot-test-hooks for labgrid:
https://patchwork.ozlabs.org/project/uboot/patch/20240829185620.3179866-1-t=
rini@konsulko.com/
the next relevant parts would be how I use that. There's three scripts,
first of which is "uboot-hw-testcycle.sh" :
------------------------ >8 ------------------------
#!/bin/bash
set -e

# Save output
LOG=3D$HOME/logs/`git describe --abbrev=3D0`/`date +"%Y-%m-%d-%H%M"`-hw.txt

# Make a base directory
B=3D`mktemp -d`
chmod a+rwX ${B}

cleanup() {
	# Clean up random outputs
	[ -d test/py/.pytest_cache ] && find -type d -name __pycache__ | xargs rm =
-r
	sudo rm -rf ${B}
	rm -rf test/py/.pytest_cache
}

# Cleanups
trap cleanup INT
trap cleanup ERR
trap cleanup EXIT

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--no-32bit" ]; then
		NO32BIT=3D"$1"
		shift
	elif [ "$1" =3D=3D "--no-64bit" ]; then
		NO64BIT=3D"$1"
		shift
	else
		echo "Unknown argument $1"
		exit 1
	fi
done

# Run the build
if [ -f .gitlab-ci.yml ]; then
	IMG=3D`grep ci_runner_image: .azure-pipelines.yml | cut -d ' ' -f 4`
else
	IMG=3D`git grep ci_runner_image: origin/master -- .azure-pipelines.yml | c=
ut -d ' ' -f 4`
fi

# Build all platforms
touch $LOG && chmod a+rw $LOG
sudo docker run  --rm -it --privileged \
	-v /home/trini/bin:/home/uboot/bin \
	-v /home/trini/u-boot:/home/uboot/u-boot \
	-v /home/trini/logs:/home/uboot/logs \
	-v ${B}:${B} \
	-w /home/uboot/u-boot/u-boot \
	-e PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/ho=
me/uboot/u-boot/u-boot-test-hooks/bin \
	$IMG \
	/home/uboot/bin/uboot-local-ci-in-docker.sh ${B} $NO32BIT $NO64BIT --log $=
LOG

# Test all targets
/home/trini/bin/uboot-local-ci-outside-docker.sh $B $NO32BIT $NO64BIT --log=
 $LOG

less $LOG
------------------------ >8 ------------------------

Which is still a little debug-y, but is basically just build everything
I want in the same container as CI, and then run pytest outside of that
container. Could I do it inside the container? Maybe. This has grown
=66rom when I used to build everything on the host and used "flashair" SD
cards to update my hardware. With labgrid everything might be abstracted
enough that yes, really, I can stop doing that. I'll likely look in to
that next just to clean things up more.

Second is "uboot-local-ci-in-docker.sh" as invoked above:
------------------------ >8 ------------------------
#!/bin/bash
# Build everything we are going to test.
set -e

# Let git stop being mad about permissions.
git config --global --add safe.directory /home/uboot/u-boot/u-boot

buildaboard() {
	# Board is first, all fragments follow.
	BRD=3D$1
	shift 1

	# Second would be to use clang
	if [ "$1" =3D=3D "--clang" ]; then
		echo "Building $BRD with clang" | tee -a $LOG
		OBJ=3D${B}/${BRD}_clang
		export HOSTCC=3Dclang-16
		export CC=3Dclang-16
		shift 1
	else
		echo "Building $BRD" | tee -a $LOG
		OBJ=3D${B}/${BRD}
	fi
	# All that remains are fragments.
	FRAGS=3D$@

	make O=3D${OBJ} ${BRD}_defconfig -s 2>&1 | tee -a $LOG
	pushd ${OBJ} >/dev/null
	[ ! -z "${FRAGS}" ] && ${S}/scripts/kconfig/merge_config.sh ${S}/configs/$=
{BRD}_defconfig ${FRAGS} 2>&1 | tee -a $LOG
	make -sj$(nproc) 2>&1 | tee -a $LOG
	popd >/dev/null
}

# Prepare virtualenv
if [ -f test/py/requirements.txt ]; then
	virtualenv -p /usr/bin/python3 /tmp/venv
	. /tmp/venv/bin/activate
	pip install --quiet -r test/py/requirements.txt
	pip install --quiet -r doc/sphinx/requirements.txt
	[ -f tools/buildman/requirements.txt ] && pip install --quiet -r tools/bui=
ldman/requirements.txt
fi

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--no-32bit" ]; then
		NO32BIT=3D"true"
		shift
	elif [ "$1" =3D=3D "--no-64bit" ]; then
		NO64BIT=3D"true"
		shift
	elif [ "$1" =3D=3D "--log" ]; then
		LOG=3D${2/trini/uboot}
		shift 2
	else
		B=3D$1
		shift
	fi
done

if [ -z "$LOG" ]; then
	echo "Must pass --log /path/to/log/file"
	exit 1
fi

S=3D`pwd`

# Common to all newer TI platforms
export BINMAN_INDIRS=3D/home/uboot/u-boot/ti-linux-firmware

# Prepare defconfigs with addons
echo 'CONFIG_UNIT_TEST=3Dy' > ${B}/unittest.config
echo 'CONFIG_CMD_BOOTMENU=3Dy' > ${B}/general.config
echo 'CONFIG_CMD_LOG=3Dy' >> ${B}/general.config
echo '# CONFIG_CMD_BOOTEFI_SELFTEST is not set' > ${B}/noefist.config
echo 'CONFIG_CMD_BOOTEFI_HELLO=3Dy' > ${B}/bootefi.config
echo 'CONFIG_CMD_BOOTEFI_SELFTEST=3Dy' >> ${B}/bootefi.config
echo 'CONFIG_IPV6=3Dy' > ${B}/net.config
echo 'CONFIG_IPV6_ROUTER_DISCOVERY=3Dy' >> ${B}/net.config
echo 'CONFIG_CMD_TFTPPUT=3Dy' >> ${B}/net.config
echo 'CONFIG_FIT=3Dy' >> ${B}/net.config
echo 'CONFIG_FIT_SIGNATURE=3Dy' >> ${B}/net.config
echo '# CONFIG_AUTOBOOT_KEYED is not set' > ${B}/noautobootkeyed.config
echo 'CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000' > ${B}/bootstage-pi.config
echo 'CONFIG_BOOTSTAGE=3Dy' >> ${B}/bootstage-pi.config
echo 'CONFIG_BOOTSTAGE_STASH=3Dy' >> ${B}/bootstage-pi.config
echo 'CONFIG_CMD_BOOTSTAGE=3Dy' >> ${B}/bootstage-pi.config

## ARM
if [ -d /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi ]; then
	export CROSS_COMPILE=3D/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-li=
nux-gnueabi-
else
	echo "Toolchain missing for ARM"
	exit 1
fi

if [ -z "$NO32BIT" ]; then
	# Raspberry Pi boards
	buildaboard rpi_4_32b ${B}/bootefi.config ${B}/net.config ${B}/general.con=
fig ${B}/bootstage-pi.config
	buildaboard rpi_4_32b --clang ${B}/bootefi.config ${B}/net.config ${B}/gen=
eral.config ${B}/bootstage-pi.config
fi

if [ -z "$NO64BIT" ]; then
	## Build r5 cores for the TI platforms that need both
	## Need to backport the kernel fix for cpp with clang and passing the right
	## flags.  Then need to figure out pip / venv.
	buildaboard am64x_evm_r5
	buildaboard am62x_evm_r5
	buildaboard am62x_beagleplay_r5
fi

## AARCH64
if [ -d /opt/gcc-13.2.0-nolibc/aarch64-linux ]; then
	export CROSS_COMPILE=3D/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-li=
nux-
else
	echo "Toolchain missing for ARM64"
	exit 1
fi

if [ -z "$NO64BIT" ]; then
	# Raspberry Pi platforms
	buildaboard rpi_4 ${B}/bootefi.config ${B}/net.config ${B}/general.config =
${B}/bootstage-pi.config
	buildaboard rpi_4 --clang ${B}/bootefi.config ${B}/net.config ${B}/general=
=2Econfig ${B}/bootstage-pi.config
	buildaboard rpi_arm64 ${B}/bootefi.config ${B}/net.config ${B}/general.con=
fig ${B}/bootstage-pi.config
	buildaboard rpi_arm64 --clang ${B}/bootefi.config ${B}/net.config ${B}/gen=
eral.config ${B}/bootstage-pi.config

	## These TI platforms require an R5 core and then Axx core
	## Need to backport the kernel fix for cpp with clang and passing the right
	## flags.
	export BL31=3D/home/uboot/u-boot/external-binaries/am64x-u-boot-binaries/b=
l31.bin
	export TEE=3D/home/uboot/u-boot/external-binaries/am64x-u-boot-binaries/te=
e-raw.bin
	buildaboard am64x_evm_a53 ${B}/noefist.config ${B}/net.config ${B}/general=
=2Econfig

	# The AM62x platforms share BL31/TEE.
	export BL31=3D/home/uboot/u-boot/external-binaries/am62x-u-boot-binaries/b=
l31.bin
	export TEE=3D/home/uboot/u-boot/external-binaries/am62x-u-boot-binaries/te=
e-raw.bin
	buildaboard am62x_evm_a53 ${B}/noefist.config ${B}/net.config ${B}/general=
=2Econfig
	buildaboard am62x_beagleplay_a53 ${B}/noautobootkeyed.config ${B}/noefist.=
config ${B}/net.config
fi

echo "Building complete on `git rev-parse --short HEAD`"
------------------------ >8 ------------------------
Which is a little debug-y but more so comments to self. I setup the
additional changes to a platform that I want to test with, and then
build them. For required additional binaries I point them at known good
copies so I don't have to worry if a failure is because of U-Boot or
some other project.

Finally we have "uboot-local-ci-outside-docker.sh" which is where pytest
is actually run.
------------------------ >8 ------------------------
#!/bin/bash
set -e

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--no-32bit" ]; then
		NO32BIT=3D"true"
		shift
	elif [ "$1" =3D=3D "--no-64bit" ]; then
		NO64BIT=3D"true"
		shift
	elif [ "$1" =3D=3D "--log" ]; then
		LOG=3D$2
		shift 2
	else
		B=3D$1
		shift
	fi
done

if [ -z "$LOG" ]; then
	echo "Must pass --log /path/to/log/file"
	exit 1
fi

# Env
export PATH=3D${PATH}:/home/trini/u-boot/u-boot-test-hooks/bin:/sbin
export PYTHONPATH=3D/home/trini/u-boot/u-boot-test-hooks/py/lootbox:${PYTHO=
NPATH}

# Setup Labgrid variables and use the special virtualenv for now
export LG_ENV=3D/home/trini/u-boot/lg_env.yaml
export LG_CROSSBAR=3Dws://lootbox.k.g:20408/ws
export PATH=3D$PATH:/home/trini/u-boot-test-hooks/bin
source /home/trini/labgrid-venv/bin/activate

runtestpy() {
	BT=3D$1
	shift 1

	if [ "$1" =3D=3D "--clang" ]; then
		echo "Testing $BT built with clang"
		shift 1
		BD=3D${B}/${BT}
		RD=3D${B}/${BT}_clang_results
		PD=3D${B}/${BT}_clang_persistent_data
	else
		echo "Testing $BT"
		BD=3D${B}/${BT}
		RD=3D${B}/${BT}_results
		PD=3D${B}/${BT}_persistent_data
	fi

	# If we need special pytest arguments do that here.
	while getopts "sk:" options; do
		case $options in
			k)
				PA=3D"-k $2"
				shift 2
				;;
		esac
	done

	labgrid-client -c $LG_ENV -p $LG_PLACE release >/dev/null 2>&1 || true
	labgrid-client -c $LG_ENV -p $LG_PLACE acquire
	./test/py/test.py -ra --bd $BT --build-dir $BD --result-dir $RD \
		--persistent-data-dir $PD --exitfirst $PA >> $LOG 2>&1
	labgrid-client -c $LG_ENV -p $LG_PLACE release

}

if [ -z "$NO64BIT" ]; then
	export LG_PLACE=3Drpi4
	runtestpy rpi_4
	runtestpy rpi_arm64
	runtestpy rpi_4 --clang
	runtestpy rpi_arm64 --clang

	export LG_PLACE=3Dam64-sk
	runtestpy am64x_evm_a53

	export LG_PLACE=3Dam62-sk
	runtestpy am62x_evm_a53

	export LG_PLACE=3Dbeagleplay
	runtestpy am62x_beagleplay_a53

fi

if [ -z "$NO32BIT" ]; then
	export LG_PLACE=3Drpi4
	runtestpy rpi_4_32b
	runtestpy rpi_4_32b --clang
fi

echo "Tests complete on `git rev-parse --short HEAD`"
------------------------ >8 ------------------------

I will say, if there's one thing I don't quite like with how my
integrations with labgrid work right now it's that acquire/release is
done the way it is. This is where I think Simon's adding another hook is
the right direction, if there's not some other hook that can be used and
I'm just missing.

--=20
Tom

--4vYfD0iVJZ+c2TXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQzDIACgkQFHw5/5Y0
tywqOAv/XzW/fGP8B0rYVEjD/veTJr9mYDeEqQVrmUMR7Mw81LTyWyIy0iTpvKMn
qGU1v46QHQvmL/D/H7LwlGYWZ3cZGh07bUPDEpXezdyOHPKH/Bd6LgD8bQngd/cd
1i2irj4x7q8r0VpWn8ANr31XQ5rEub+CpQgS/KMDAjZf1Xj4KNj9slS9QLYMFuWb
uXTwntxUFl4zIwpm4Rq1+qIjhZ9ERlUZaIngN877ZpynMVrUOBoPZIHGGotZaldD
0YVq4AKw0BpPpjg75JLy7gP6ThA6Z9gQ0DVHNSa0ybjW324Gsd8ZUA1VHm4dQcWr
+t6k/1D5eQzR9wpbtJslQ0Jz47J9pyMLffTsdJKab+4y0DgNj+ntb1tj/PmtwlOd
oNn8EvxWFRlJPDrc0RhG1i21ZRq7j93m3xTgJbOPDIT+Q7VTiIYDW/wDHjDOSfUS
DjzI5fT9USZxnHlkL/JnYKQxL1u1Olsgco93CB91vCwQqDvnofyZ0fGGLPV9OreM
mfbIHSF/
=sXFF
-----END PGP SIGNATURE-----

--4vYfD0iVJZ+c2TXk--
