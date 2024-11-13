Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF99D597C2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 00:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96642894B3;
	Wed, 13 Nov 2024 01:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RZfof8bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A522894CD; Wed, 13 Nov 2024 01:54:57 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DD2894B3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 01:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so488661085a.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731459293; x=1732064093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NQb5HBKdAp1zAFOGxXBtVcsebq5DNWL0ChAv1frzH/s=;
 b=RZfof8bYrfYAnXxxwIRbXebF0/8QuI5sT/Rdm4wnbSsfJUpVXFguFYyLcG7xGKVLTP
 qwivCTX7Y/a1EzQkvQce9riS6FaNzRmHiWD4fZHIXpZhTi/LwztgXEIbQopouevIJ/a/
 DuL4ND5kf1ReQeOXFzC2fIp0XeSdggVcG5+ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731459293; x=1732064093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQb5HBKdAp1zAFOGxXBtVcsebq5DNWL0ChAv1frzH/s=;
 b=w+eH5ekBo5obs6prMwXv4lOJR4KhaaXjGQ3Oyx4WX+rlKVXJy6B7LYQ22ojGlMUmov
 GBMYPhFbuc9aw13gvN4D1hfktY1c5BKSEX44pDARzDasfENRbesYgBlZpqh/SUP3/6/Z
 JULpecMgJODh/wEFg+8xIWuT1yVhXjVKhexMqYNHUztvNfpz/DayZDAhxv8lTAgBU0SQ
 MF88f4zrZXaYifq7GwgGBrwZvWdZSYvfLUmZHhEE0D7jK8qVkU7owDuc2FzeN90YfsXh
 gCprRi5Dq+MtO3sekx5eF6yXuIEcfrHaDtIkfZ9pFPK5HrQ/xbzc0rH7j2CRTJeZvY2P
 HPBA==
X-Gm-Message-State: AOJu0YyKqynerf47WjOcYn9ZMF/tg/TARmXc92bSTrAFNdJ99iz2+ZZG
 Mek24D31y/AexhJFSR66pdQa5e/DoJR0jeM9e2x0WnmZFtqqwJCogZL/8RDEuXY=
X-Google-Smtp-Source: AGHT+IEGOaWeL5BjtW9AA7gpIpUneDlL/Dxo5nl5JQ4R/ofHezdwKvikjEfgvENyFuYl8T5FYrL6jw==
X-Received: by 2002:a05:620a:24d0:b0:7a9:a991:f6d7 with SMTP id
 af79cd13be357-7b331f1841dmr2447707585a.48.1731459293332; 
 Tue, 12 Nov 2024 16:54:53 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac88721sm642839085a.65.2024.11.12.16.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 16:54:50 -0800 (PST)
Date: Tue, 12 Nov 2024 18:54:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/18] scripts: Add a script for building and booting QEMU
Message-ID: <20241113005447.GF3600562@bill-the-cat>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oQJ0esxR+mky2YRu"
Content-Disposition: inline
In-Reply-To: <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
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


--oQJ0esxR+mky2YRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >It is handy to be able to quickly build and boot a QEMU image for a
> >particular architecture and distro.
> >
> >Add a script for this purpose. It supports only arm and x86 at present.
> >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> >supported.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > MAINTAINERS                    |   8 ++
> > doc/board/emulation/index.rst  |   1 +
> > doc/board/emulation/script.rst |  61 ++++++++++++
> > scripts/build-qemu.sh          | 175 +++++++++++++++++++++++++++++++++
> > 4 files changed, 245 insertions(+)
> > create mode 100644 doc/board/emulation/script.rst
> > create mode 100755 scripts/build-qemu.sh
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 0399ed1dbf6..b45bb96d5a5 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -1110,6 +1110,14 @@ F:	tools/efivar.py
> > F:	tools/file2include.c
> > F:	tools/mkeficapsule.c
> >=20
> >+EMULATION
> >+M:	Simon Glass <sjg@chromium.org>
> >+S:	Maintained
> >+W:	https://docs.u-boot.org/en/latest/board/emulation/script.html
> >+F:	configs/qemu_x86*
> >+F:	doc/board/emulation/script.rst
> >+F:	scripts/build-qemu.sh
>=20
> Please, avoid misnomers. This script does not build QEMU.
>=20
> >+
> > ENVIRONMENT
> > M:	Joe Hershberger <joe.hershberger@ni.com>
> > S:	Maintained
> >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.r=
st
> >index f8908166276..5a2a00ae225 100644
> >--- a/doc/board/emulation/index.rst
> >+++ b/doc/board/emulation/index.rst
> >@@ -8,6 +8,7 @@ Emulation
> >=20
> >    acpi
> >    blkdev
> >+   script
> >    qemu-arm
> >    qemu-mips
> >    qemu-ppce500
> >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script=
=2Erst
>=20
> Just another misnomer. This page is not about script.sh.
>=20
> >new file mode 100644
> >index 00000000000..23981e333cb
> >--- /dev/null
> >+++ b/doc/board/emulation/script.rst
> >@@ -0,0 +1,61 @@
> >+.. SPDX-License-Identifier: GPL-2.0+
>=20
> This is not a valid SPDX identifier.
>=20
> >+
> >+Script for building and running
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+You may find the script `scripts/build-qemu.sh` helpful for building an=
d testing
> >+U-Boot on QEMU.
> >+
> >+If uses a environment variables to control how it works:
> >+
> >+ubdir
> >+    base directory for building U-Boot, with each board being in its own
> >+    subdirectory
> >+
> >+imagedir
> >+    directory containing OS images, containin a subdirectory for each d=
istro
> >+    type (e.g. ubuntu/
> >+
> >+Once configured, you can build and run QEMU for arm64 like this::
>=20
> This downloads the QEMU source and builds it?
>=20
> >+
> >+    scripts/build-qemu.sh -rsw
> >+
> >+No support is currently included for specifying a root disk, so this sc=
ript can
> >+only be used to start installers.
> >+
> >+Options
> >+~~~~~~~
> >+
> >+Options are available to control the script:
> >+
> >+-a <arch>
> >+    Select architecture (default arm, x86)
> >+
> >+-B
> >+    Don't build; assume a build exists
> >+
> >+-k
> >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
> >+    emulator
> >+
> >+-o <os>
> >+    Run an Operating System. For now this only supports 'ubuntu'. The n=
ame of
> >+    the OS file must remain unchanged from its standard name on the Ubu=
ntu
> >+    website.
>=20
> The U-Boot project should remain open to all operating systems. How will =
this work with OpenBSD?
>=20
> Use the URL of the image as argument.
>=20
> >+
> >+-r
> >+    Run QEMU with the image (by default this is not done)
> >+
> >+-R
> >+    Select OS release (e.g. 24.04).
> >+
> >+-s
> >+    Use serial only (no display)
> >+
> >+-w
> >+    Use word version (32-bit). By default, 64-bit is used
>=20
> "word version" is not helpful as explanation.
>=20
> Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architecture)> wh=
ich says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit system.
>=20
> >+
> >+.. note::
> >+
> >+    Note: For now this is a shell script, but if it expands it might be=
 better
> >+    as Python, accepting the slower startup.
> >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> >new file mode 100755
> >index 00000000000..0ff53593cf9
> >--- /dev/null
> >+++ b/scripts/build-qemu.sh
> >@@ -0,0 +1,175 @@
> >+#!/bin/bash
> >+# SPDX-License-Identifier: GPL-2.0+
>=20
> This is not a valid SPDX identifier.
>=20
> >+#
> >+# Script to build U-Boot suitable for booting with QEMU, possibly runni=
ng
> >+# it, possibly with an OS image
> >+
> >+# This just an example. It assumes that
> >+
> >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot boar=
d config
> >+# - your OS images are in ${imagedir}/{distroname}/...
> >+
> >+# So far the script supports only ARM and x86.
>=20
> Why support obsolete i386 but not riscv64?
>=20
> >+
> >+set -e
> >+
> >+usage() {
> >+	(
> >+	if [[ -n "$1" ]]; then
> >+		echo "$1"
> >+		echo
> >+	fi
> >+	echo "Usage: $0 -aBkrsw"
> >+	echo
> >+	echo "   -a   - Select architecture (arm, x86)"
> >+	echo "   -B   - Don't build; assume a build exists"
> >+	echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> >+	echo "   -o   - Run Operating System ('ubuntu' only for now)"
> >+	echo "   -r   - Run QEMU with the image"
> >+	echo "   -R   - Select OS release (e.g. 24.04)"
> >+	echo "   -s   - Use serial only (no display)"
> >+	echo "   -w   - Use word version (32-bit)" ) >&2
> >+	exit 1
> >+}
> >+
> >+# Directory tree for OS images
> >+imagedir=3D${imagedir-/vid/software/linux}
> >+
> >+# architecture (arm or x86)
> >+arch=3Darm
> >+
> >+# 32- or 64-bit build
> >+bitness=3D64
> >+
> >+# Build U-Boot
> >+build=3Dyes
> >+
> >+# Extra setings
> >+extra=3D
> >+
> >+# Operating System to boot (ubuntu)
> >+os=3D
> >+
> >+release=3D24.04.1
> >+
> >+# run the image with QEMU
> >+run=3D
> >+
> >+# run QEMU without a display (U-Boot must be set to stdout=3Dserial)
> >+serial=3D
> >+
> >+# Use kvm
> >+kvm=3D
> >+
> >+# Set ubdir to the build directory where you build U-Boot out-of-tree
> >+# We avoid in-tree build because it gets confusing trying different bui=
lds
> >+ubdir=3D${ubdir-/tmp/b}
> >+
> >+while getopts "a:Bko:rR:sw" opt; do
> >+	case "${opt}" in
> >+	a)
> >+		arch=3D$OPTARG
> >+		;;
> >+	B)
> >+		build=3D
> >+		;;
> >+	k)
> >+		kvm=3D"-enable-kvm"
> >+		;;
> >+	o)
> >+		os=3D$OPTARG
> >+
> >+		# Expand memory and CPUs
> >+		extra+=3D" -m 4G -smp 4"
> >+		;;
> >+	r)
> >+		run=3D1
> >+		;;
> >+	R)
> >+		release=3D$OPTARG
> >+		;;
> >+	s)
> >+		serial=3D1
> >+		;;
> >+	w)
> >+		bitness=3D32
> >+		;;
> >+	*)
> >+		usage
> >+		;;
> >+	esac
> >+done
> >+
> >+# Build U-Boot for the selected board
> >+build_u_boot() {
> >+	buildman -w -o $DIR --board $BOARD -I || exit $?
> >+}
> >+
> >+# Run QEMU with U-Boot
> >+run_qemu() {
> >+	if [[ -n "${os_image}" ]]; then
> >+		extra+=3D" -drive if=3Dvirtio,file=3D${os_image},format=3Draw,id=3Dhd=
0"
> >+	fi
> >+	if [[ -n "${serial}" ]]; then
> >+		extra+=3D" -display none -serial mon:stdio"
> >+	else
> >+		extra+=3D" -serial mon:stdio"
> >+	fi
> >+	echo "Running ${qemu} ${extra}"
> >+	"${qemu}" -bios "$DIR/${BIOS}" \
> >+		-m 512 \
>=20
> Ubuntu suggests 4 GiB as minimum for a desktop.
>=20
> >+		-nic none \
>=20
> Who wants to run without network?
> Use the virtio nic.
>=20
> >+		${kvm} \
> >+		${extra}
> >+}
> >+
> >+# Check architecture
> >+case "${arch}" in
> >+arm)
> >+	BOARD=3D"qemu_arm"
> >+	BIOS=3D"u-boot.bin"
> >+	qemu=3Dqemu-system-arm
> >+	extra+=3D" -machine virt"
> >+	suffix=3D"arm"
> >+	if [[ "${bitness}" =3D=3D "64" ]]; then
> >+		BOARD=3D"qemu_arm64"
> >+		qemu=3Dqemu-system-aarch64
> >+		extra+=3D" -cpu cortex-a57"
>=20
> That CPU is 12 years old and not all distros are stuck on ARM v8.0. See <=
https://en.opensuse.org/Arm_architecture_support>.
>=20
> -cpu max works fine with both tcg and kvm.
>=20
> >+		suffix=3D"arm64"
>=20
> >+	fi
> >+	;;
> >+x86)
> >+	BOARD=3D"qemu-x86"
> >+	BIOS=3D"u-boot.rom"
> >+	qemu=3Dqemu-system-i386
> >+	suffix=3D"i386"
> >+	if [[ "${bitness}" =3D=3D "64" ]]; then
> >+		BOARD=3D"qemu-x86_64"
> >+		qemu=3Dqemu-system-x86_64
> >+		suffix=3D"amd64"
> >+	fi
> >+	;;
> >+*)
> >+	usage "Unknown architecture '${arch}'"
> >+esac
> >+
> >+# Check OS
> >+case "${os}" in
> >+ubuntu)
> >+	os_image=3D"${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
>=20
> There is no ARM 32-bit Ubuntu desktop. And for i386 there is no image in =
24.04.1.
>=20
> Running a foreign architecture desktop with tcg is not enjoyable.
>=20
> For testing U-Boot a server image is all it takes.

And _all_ of this is why I don't want to add a useful personal script
as an additional tool we support. I've seen how much work goes in to the
OpenEmbedded runqemu script, we don't have the spare cycles for
something like that. Doubly so when ultimately I believe we would be
well served by having a document that says (in much more words) to look
at u-boot-test-hooks for how to invoke QEMU for a large number of
architectures and platforms and to then further leverage general QEMU
tips and guides on how to run an OS of your choice with that.

--=20
Tom

--oQJ0esxR+mky2YRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz+NMACgkQFHw5/5Y0
tyz9AQv+PD4L2hUmQRnZgYldrINIkHXkdGfZMIZAGCVDoaTkIyq1ZAa6DlGzyeTC
XAjqQrCxZSxvdqkcmp9GlwwndC+FCgHczfsr3eCA1z6p9iuJy17DnBY+A8Fm/e+X
l8r3i6Oqicj0d72I/5snd4sx+wzslsiFC6k1vB1IsYHg4fWb0uI7W+oO5wEMb7oS
kEdaHgkPZr4za8xsmKWrXxNXwvDqXc86/0di2kSLRz3XQRnB6J7VKl/Nt9oAfCFJ
lgBO5K1eJG2xIK97rn7jSbQ/A4cgSxkMOJfPFYTN0oN+97pv//G2A0aIsAxiiA28
02sRlJmk1XxYZBZ8cX2NHMasjnBbJMg/O2INnNBlnVr+2ScrUZyyRChi5VZir+SM
hyawFKCDqOY7qNSD9npOvHa6og75z1fIpbmSFjE6mnFFiAPXGmPYRp3XiUoOjwIh
7btw1bTEOs8JUMqEPlal014bR1SNMao2ZZ8Y73mmybiJBDM4aoOddGeg+92ZP8ei
qpcyNzch
=GtpL
-----END PGP SIGNATURE-----

--oQJ0esxR+mky2YRu--
