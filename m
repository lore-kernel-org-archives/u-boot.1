Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979FBCA0FFC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 14:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FD088C2E;
	Fri, 30 Aug 2024 16:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNyERMl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F26D88C3F; Fri, 30 Aug 2024 16:30:10 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D93F888FD
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-44ff9281e93so9274171cf.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725028206; x=1725633006; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Y5FB0+STsC7EBTf0cCBwir2kBUq+mbqmVryvNKPESc=;
 b=uNyERMl/tOGGJFcWbJ7cjGxFraeG4j2p112KST4e1oilnBePDcMo5/hUrPN0NXswRH
 VcYKQlUCaA765ZteCc6hv/lyTdg+vOxjpq5oIFctCY//UtVIIE8Sq4p5AllT0FjNmnQz
 nHKOTd4WX3325xfCTFhV2OgXEJ+VgMXPYiZiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725028206; x=1725633006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Y5FB0+STsC7EBTf0cCBwir2kBUq+mbqmVryvNKPESc=;
 b=ptVSzBkRGYt+3FRpspBIO8evqBHePY2FBsKhjiF0zWMbL7EDWrkop3JfCm3rrXnmJ/
 7t20Hs8F72qr1hlo3e82tvJF2dyhwWEsrAd62Qo3WqqOi+oMltWaB24pbu6CVNtYIM8S
 04Lbt6RGHXPZcjEAfP9e88fnrdt1i6iUmKXxFiejis3AXzl+MPldINc96XJWlaUeTPvQ
 UeDe+EP/QV127XyKTzmi4q/xFaQ1EJM9+qUwUFZcEfHc0JkIoL/vTae3nX+0RfgZN2Aq
 5GKoRJHb/Azp2cjRM0RkSnw9+FZvHhIHWpqrKBc+rOUsGPSu1puxSA3wYChls3GAcfaT
 Yp0A==
X-Gm-Message-State: AOJu0YxulzGUmJvI/5UHtD5TJY9g2TTpsYP2OeVvqSRXS5BP8ekilasQ
 SrPE070w71ywd6wNFTjtesEBkil3t/4mArJ/vKLdpMYx157mf7ZTElaKt5Ck85E=
X-Google-Smtp-Source: AGHT+IGd+zfgPj9bT6Hk8rTEpKDgQDe+VAQPC7t5C31GQWk5u8kf/WCpD4y8dcoW+IVmjZ1/3xfChA==
X-Received: by 2002:a05:622a:4009:b0:447:f285:926a with SMTP id
 d75a77b69052e-4567f755efdmr61327951cf.62.1725028205614; 
 Fri, 30 Aug 2024 07:30:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c8788asm14451301cf.1.2024.08.30.07.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:30:04 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:30:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: My labgrid setup
Message-ID: <20240830143002.GT2479150@bill-the-cat>
References: <20240829192958.GO2479150@bill-the-cat>
 <CAFLszTh3hgG3dpYSK_w=DZTJcm59Ct-xQRZPy-00Mh7iGwwaYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RB8ZqwOHPt6YbfFI"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3hgG3dpYSK_w=DZTJcm59Ct-xQRZPy-00Mh7iGwwaYw@mail.gmail.com>
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


--RB8ZqwOHPt6YbfFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 07:06:53PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 13:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > So now that I've posted my u-boot-test-hooks for labgrid:
> > https://patchwork.ozlabs.org/project/uboot/patch/20240829185620.3179866=
-1-trini@konsulko.com/
> > the next relevant parts would be how I use that. There's three scripts,
> > first of which is "uboot-hw-testcycle.sh" :
> > ------------------------ >8 ------------------------
> > #!/bin/bash
> > set -e
> >
> > # Save output
> > LOG=3D$HOME/logs/`git describe --abbrev=3D0`/`date +"%Y-%m-%d-%H%M"`-hw=
=2Etxt
> >
> > # Make a base directory
> > B=3D`mktemp -d`
> > chmod a+rwX ${B}
> >
> > cleanup() {
> >         # Clean up random outputs
> >         [ -d test/py/.pytest_cache ] && find -type d -name __pycache__ =
| xargs rm -r
> >         sudo rm -rf ${B}
> >         rm -rf test/py/.pytest_cache
> > }
> >
> > # Cleanups
> > trap cleanup INT
> > trap cleanup ERR
> > trap cleanup EXIT
> >
> > # Find our arguments
> > while test $# -ne 0; do
> >         if [ "$1" =3D=3D "--no-32bit" ]; then
> >                 NO32BIT=3D"$1"
> >                 shift
> >         elif [ "$1" =3D=3D "--no-64bit" ]; then
> >                 NO64BIT=3D"$1"
> >                 shift
> >         else
> >                 echo "Unknown argument $1"
> >                 exit 1
> >         fi
> > done
> >
> > # Run the build
> > if [ -f .gitlab-ci.yml ]; then
> >         IMG=3D`grep ci_runner_image: .azure-pipelines.yml | cut -d ' ' =
-f 4`
> > else
> >         IMG=3D`git grep ci_runner_image: origin/master -- .azure-pipeli=
nes.yml | cut -d ' ' -f 4`
> > fi
> >
> > # Build all platforms
> > touch $LOG && chmod a+rw $LOG
> > sudo docker run  --rm -it --privileged \
> >         -v /home/trini/bin:/home/uboot/bin \
> >         -v /home/trini/u-boot:/home/uboot/u-boot \
> >         -v /home/trini/logs:/home/uboot/logs \
> >         -v ${B}:${B} \
> >         -w /home/uboot/u-boot/u-boot \
> >         -e PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sb=
in:/bin:/home/uboot/u-boot/u-boot-test-hooks/bin \
> >         $IMG \
> >         /home/uboot/bin/uboot-local-ci-in-docker.sh ${B} $NO32BIT $NO64=
BIT --log $LOG
> >
> > # Test all targets
> > /home/trini/bin/uboot-local-ci-outside-docker.sh $B $NO32BIT $NO64BIT -=
-log $LOG
> >
> > less $LOG
> > ------------------------ >8 ------------------------
> >
> > Which is still a little debug-y, but is basically just build everything
> > I want in the same container as CI, and then run pytest outside of that
> > container. Could I do it inside the container? Maybe. This has grown
> > from when I used to build everything on the host and used "flashair" SD
> > cards to update my hardware. With labgrid everything might be abstracted
> > enough that yes, really, I can stop doing that. I'll likely look in to
> > that next just to clean things up more.
> >
> > Second is "uboot-local-ci-in-docker.sh" as invoked above:
> > ------------------------ >8 ------------------------
> > #!/bin/bash
> > # Build everything we are going to test.
> > set -e
> >
> > # Let git stop being mad about permissions.
> > git config --global --add safe.directory /home/uboot/u-boot/u-boot
> >
> > buildaboard() {
> >         # Board is first, all fragments follow.
> >         BRD=3D$1
> >         shift 1
> >
> >         # Second would be to use clang
> >         if [ "$1" =3D=3D "--clang" ]; then
> >                 echo "Building $BRD with clang" | tee -a $LOG
> >                 OBJ=3D${B}/${BRD}_clang
> >                 export HOSTCC=3Dclang-16
> >                 export CC=3Dclang-16
> >                 shift 1
> >         else
> >                 echo "Building $BRD" | tee -a $LOG
> >                 OBJ=3D${B}/${BRD}
> >         fi
> >         # All that remains are fragments.
> >         FRAGS=3D$@
> >
> >         make O=3D${OBJ} ${BRD}_defconfig -s 2>&1 | tee -a $LOG
> >         pushd ${OBJ} >/dev/null
> >         [ ! -z "${FRAGS}" ] && ${S}/scripts/kconfig/merge_config.sh ${S=
}/configs/${BRD}_defconfig ${FRAGS} 2>&1 | tee -a $LOG
> >         make -sj$(nproc) 2>&1 | tee -a $LOG
> >         popd >/dev/null
> > }
> >
> > # Prepare virtualenv
> > if [ -f test/py/requirements.txt ]; then
> >         virtualenv -p /usr/bin/python3 /tmp/venv
> >         . /tmp/venv/bin/activate
> >         pip install --quiet -r test/py/requirements.txt
> >         pip install --quiet -r doc/sphinx/requirements.txt
> >         [ -f tools/buildman/requirements.txt ] && pip install --quiet -=
r tools/buildman/requirements.txt
> > fi
> >
> > # Find our arguments
> > while test $# -ne 0; do
> >         if [ "$1" =3D=3D "--no-32bit" ]; then
> >                 NO32BIT=3D"true"
> >                 shift
> >         elif [ "$1" =3D=3D "--no-64bit" ]; then
> >                 NO64BIT=3D"true"
> >                 shift
> >         elif [ "$1" =3D=3D "--log" ]; then
> >                 LOG=3D${2/trini/uboot}
> >                 shift 2
> >         else
> >                 B=3D$1
> >                 shift
> >         fi
> > done
> >
> > if [ -z "$LOG" ]; then
> >         echo "Must pass --log /path/to/log/file"
> >         exit 1
> > fi
> >
> > S=3D`pwd`
> >
> > # Common to all newer TI platforms
> > export BINMAN_INDIRS=3D/home/uboot/u-boot/ti-linux-firmware
> >
> > # Prepare defconfigs with addons
> > echo 'CONFIG_UNIT_TEST=3Dy' > ${B}/unittest.config
> > echo 'CONFIG_CMD_BOOTMENU=3Dy' > ${B}/general.config
> > echo 'CONFIG_CMD_LOG=3Dy' >> ${B}/general.config
> > echo '# CONFIG_CMD_BOOTEFI_SELFTEST is not set' > ${B}/noefist.config
> > echo 'CONFIG_CMD_BOOTEFI_HELLO=3Dy' > ${B}/bootefi.config
> > echo 'CONFIG_CMD_BOOTEFI_SELFTEST=3Dy' >> ${B}/bootefi.config
> > echo 'CONFIG_IPV6=3Dy' > ${B}/net.config
> > echo 'CONFIG_IPV6_ROUTER_DISCOVERY=3Dy' >> ${B}/net.config
> > echo 'CONFIG_CMD_TFTPPUT=3Dy' >> ${B}/net.config
> > echo 'CONFIG_FIT=3Dy' >> ${B}/net.config
> > echo 'CONFIG_FIT_SIGNATURE=3Dy' >> ${B}/net.config
> > echo '# CONFIG_AUTOBOOT_KEYED is not set' > ${B}/noautobootkeyed.config
> > echo 'CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000' > ${B}/bootstage-pi.con=
fig
> > echo 'CONFIG_BOOTSTAGE=3Dy' >> ${B}/bootstage-pi.config
> > echo 'CONFIG_BOOTSTAGE_STASH=3Dy' >> ${B}/bootstage-pi.config
> > echo 'CONFIG_CMD_BOOTSTAGE=3Dy' >> ${B}/bootstage-pi.config
> >
> > ## ARM
> > if [ -d /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi ]; then
> >         export CROSS_COMPILE=3D/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi=
/bin/arm-linux-gnueabi-
> > else
> >         echo "Toolchain missing for ARM"
> >         exit 1
> > fi
> >
> > if [ -z "$NO32BIT" ]; then
> >         # Raspberry Pi boards
> >         buildaboard rpi_4_32b ${B}/bootefi.config ${B}/net.config ${B}/=
general.config ${B}/bootstage-pi.config
> >         buildaboard rpi_4_32b --clang ${B}/bootefi.config ${B}/net.conf=
ig ${B}/general.config ${B}/bootstage-pi.config
> > fi
> >
> > if [ -z "$NO64BIT" ]; then
> >         ## Build r5 cores for the TI platforms that need both
> >         ## Need to backport the kernel fix for cpp with clang and passi=
ng the right
> >         ## flags.  Then need to figure out pip / venv.
> >         buildaboard am64x_evm_r5
> >         buildaboard am62x_evm_r5
> >         buildaboard am62x_beagleplay_r5
> > fi
> >
> > ## AARCH64
> > if [ -d /opt/gcc-13.2.0-nolibc/aarch64-linux ]; then
> >         export CROSS_COMPILE=3D/opt/gcc-13.2.0-nolibc/aarch64-linux/bin=
/aarch64-linux-
> > else
> >         echo "Toolchain missing for ARM64"
> >         exit 1
> > fi
> >
> > if [ -z "$NO64BIT" ]; then
> >         # Raspberry Pi platforms
> >         buildaboard rpi_4 ${B}/bootefi.config ${B}/net.config ${B}/gene=
ral.config ${B}/bootstage-pi.config
> >         buildaboard rpi_4 --clang ${B}/bootefi.config ${B}/net.config $=
{B}/general.config ${B}/bootstage-pi.config
> >         buildaboard rpi_arm64 ${B}/bootefi.config ${B}/net.config ${B}/=
general.config ${B}/bootstage-pi.config
> >         buildaboard rpi_arm64 --clang ${B}/bootefi.config ${B}/net.conf=
ig ${B}/general.config ${B}/bootstage-pi.config
> >
> >         ## These TI platforms require an R5 core and then Axx core
> >         ## Need to backport the kernel fix for cpp with clang and passi=
ng the right
> >         ## flags.
> >         export BL31=3D/home/uboot/u-boot/external-binaries/am64x-u-boot=
-binaries/bl31.bin
> >         export TEE=3D/home/uboot/u-boot/external-binaries/am64x-u-boot-=
binaries/tee-raw.bin
> >         buildaboard am64x_evm_a53 ${B}/noefist.config ${B}/net.config $=
{B}/general.config
> >
> >         # The AM62x platforms share BL31/TEE.
> >         export BL31=3D/home/uboot/u-boot/external-binaries/am62x-u-boot=
-binaries/bl31.bin
> >         export TEE=3D/home/uboot/u-boot/external-binaries/am62x-u-boot-=
binaries/tee-raw.bin
> >         buildaboard am62x_evm_a53 ${B}/noefist.config ${B}/net.config $=
{B}/general.config
> >         buildaboard am62x_beagleplay_a53 ${B}/noautobootkeyed.config ${=
B}/noefist.config ${B}/net.config
> > fi
> >
> > echo "Building complete on `git rev-parse --short HEAD`"
> > ------------------------ >8 ------------------------
> > Which is a little debug-y but more so comments to self. I setup the
> > additional changes to a platform that I want to test with, and then
> > build them. For required additional binaries I point them at known good
> > copies so I don't have to worry if a failure is because of U-Boot or
> > some other project.
> >
> > Finally we have "uboot-local-ci-outside-docker.sh" which is where pytest
> > is actually run.
> > ------------------------ >8 ------------------------
> > #!/bin/bash
> > set -e
> >
> > # Find our arguments
> > while test $# -ne 0; do
> >         if [ "$1" =3D=3D "--no-32bit" ]; then
> >                 NO32BIT=3D"true"
> >                 shift
> >         elif [ "$1" =3D=3D "--no-64bit" ]; then
> >                 NO64BIT=3D"true"
> >                 shift
> >         elif [ "$1" =3D=3D "--log" ]; then
> >                 LOG=3D$2
> >                 shift 2
> >         else
> >                 B=3D$1
> >                 shift
> >         fi
> > done
> >
> > if [ -z "$LOG" ]; then
> >         echo "Must pass --log /path/to/log/file"
> >         exit 1
> > fi
> >
> > # Env
> > export PATH=3D${PATH}:/home/trini/u-boot/u-boot-test-hooks/bin:/sbin
> > export PYTHONPATH=3D/home/trini/u-boot/u-boot-test-hooks/py/lootbox:${P=
YTHONPATH}
> >
> > # Setup Labgrid variables and use the special virtualenv for now
> > export LG_ENV=3D/home/trini/u-boot/lg_env.yaml
> > export LG_CROSSBAR=3Dws://lootbox.k.g:20408/ws
> > export PATH=3D$PATH:/home/trini/u-boot-test-hooks/bin
> > source /home/trini/labgrid-venv/bin/activate
> >
> > runtestpy() {
> >         BT=3D$1
> >         shift 1
> >
> >         if [ "$1" =3D=3D "--clang" ]; then
> >                 echo "Testing $BT built with clang"
> >                 shift 1
> >                 BD=3D${B}/${BT}
> >                 RD=3D${B}/${BT}_clang_results
> >                 PD=3D${B}/${BT}_clang_persistent_data
> >         else
> >                 echo "Testing $BT"
> >                 BD=3D${B}/${BT}
> >                 RD=3D${B}/${BT}_results
> >                 PD=3D${B}/${BT}_persistent_data
> >         fi
> >
> >         # If we need special pytest arguments do that here.
> >         while getopts "sk:" options; do
> >                 case $options in
> >                         k)
> >                                 PA=3D"-k $2"
> >                                 shift 2
> >                                 ;;
> >                 esac
> >         done
> >
> >         labgrid-client -c $LG_ENV -p $LG_PLACE release >/dev/null 2>&1 =
|| true
> >         labgrid-client -c $LG_ENV -p $LG_PLACE acquire
> >         ./test/py/test.py -ra --bd $BT --build-dir $BD --result-dir $RD=
 \
> >                 --persistent-data-dir $PD --exitfirst $PA >> $LOG 2>&1
> >         labgrid-client -c $LG_ENV -p $LG_PLACE release
> >
> > }
> >
> > if [ -z "$NO64BIT" ]; then
> >         export LG_PLACE=3Drpi4
> >         runtestpy rpi_4
> >         runtestpy rpi_arm64
> >         runtestpy rpi_4 --clang
> >         runtestpy rpi_arm64 --clang
> >
> >         export LG_PLACE=3Dam64-sk
> >         runtestpy am64x_evm_a53
> >
> >         export LG_PLACE=3Dam62-sk
> >         runtestpy am62x_evm_a53
> >
> >         export LG_PLACE=3Dbeagleplay
> >         runtestpy am62x_beagleplay_a53
> >
> > fi
> >
> > if [ -z "$NO32BIT" ]; then
> >         export LG_PLACE=3Drpi4
> >         runtestpy rpi_4_32b
> >         runtestpy rpi_4_32b --clang
> > fi
> >
> > echo "Tests complete on `git rev-parse --short HEAD`"
> > ------------------------ >8 ------------------------
> >
> > I will say, if there's one thing I don't quite like with how my
> > integrations with labgrid work right now it's that acquire/release is
> > done the way it is. This is where I think Simon's adding another hook is
> > the right direction, if there's not some other hook that can be used and
> > I'm just missing.
>=20
> Thanks for posting this. I know you had described it but this makes a
> lot of things clearer.
>=20
> So basically you have set up builds for the different boards and use
> the hook scripts to write them and do the actual power/reset/console
> munging.

Yes.

> How do you handle interactive build/run, e.g. to run U-Boot on a
> particular board quickly?

Well, this is the CI lab, so that's not the primary point. But control-O
in a shell? Some platforms I have a wrapper for, some I don't.

> Also how would gitlab work?

Similar to how it works in your series, but with more "make the
container build/include firmware blobs for use", most likely.

> Re acquire/release, I added a -a option to auto-acquire the place and
> release it afterwards. But if the console dies then so does Labgrid so
> it doesn't release reliably...something to worry about when more
> progress is made.

Well, that's what pre/post steps are for, IMHO.

--=20
Tom

--RB8ZqwOHPt6YbfFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbR12oACgkQFHw5/5Y0
tywNbAwAs2pDl7SNW0gCAhBCug906akAAZd2L+1oSH+G652QT+6CQ97l7ARrB5od
IAPRbpfGv7EwyiNpzocxA6y5VbpXMlkX4uxP8OdA6etNkRLHOGapv1JtXca7w2ih
cxLHbZF1a2jS9DZtwuvDQI4kQq3gnnJ5TCz2dC5qhLc9mL0lPMZuLcl4VLShGntK
Bhj1NW+ZHQyJ0FNR+ZWos9O0ZESVLdI0nhVcng2hyAIlJ7/mesOH3bfFGGh6JXTW
rZv+BTO4BWK5rXHRz7TC6ZhpYSZAxgzt23J2ELnwbtfZQWNR5Xpgcho6N0jCcdIR
QHdbRCPIwkhjmugJ9bQuuCYn2i58gdrHPpoVGP/qwinHi5yFuh6wJxMi99IAn0Of
6RA0Jt1huA0xaOlhoMUafpTyrGgd0wznr+g9cESfPNw8Ljren4U1Ioz0s2NoYnAf
vLb6+gpu4mRTrz0fnocT6j6YsJRo5bJl1dDnEd2RPfA8Y3E+4YKVZulEU4fI/+s9
KKknJ4K7
=1z3f
-----END PGP SIGNATURE-----

--RB8ZqwOHPt6YbfFI--
