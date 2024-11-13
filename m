Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B1DD597C1
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 00:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDADD88F55;
	Wed, 13 Nov 2024 01:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="d/Ni0DvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1C0894B3; Wed, 13 Nov 2024 01:49:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E9888F4B
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 01:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731458971; x=1732063771; i=xypron.glpk@gmx.de;
 bh=ka7q+Us+0ph3naLjGOP0w6uPZcgMtaVSNi6aijBhpjM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=d/Ni0DvY14TsBay6LIULat4LuAe+b1f8J/Ebxlm89Ll5A3C2GzM8moishC/I1fd4
 2ouSMNcKl4jisxS8eLviGLwAR8E4tY0z+KNxk12+w5GNM4IznC2g9IukyyQoKpNW/
 Qk1EmoSsrSbGgM4rcGObN7pBUaUnw7FaJi0lkMG5CNXo345JBmHXhKPr2kz+xmSU/
 vwUKAyL8BG7/0vuItw7dAVOHByxWO/FZr0OaTNAKMXf6CPXB5MHW4het73q0MeiGH
 DbnuXER0hTUjfoL1S/KZG2qlT3HpvwJYp1cIGlAxZE4pBe9I9dUhRi676DmhAuuQz
 uKq0LmYTXJ57Ilm1IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1tq1JJ1xfe-015507; Wed, 13
 Nov 2024 01:49:31 +0100
Date: Wed, 13 Nov 2024 01:49:30 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/18] scripts: Add a script for building and booting QEMU
User-Agent: Thunderbird for Android
In-Reply-To: <20241112135911.630586-2-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
Message-ID: <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ysyzMNFBRbznbq5ot3a8KaK3l3AkYwmE36g7uQfLF5WNVwXI1GP
 wFI/PF02isY83Mmd2Xb1Dktw2WjeZA+MMD4nrG907vEt6G5VnBqc/quj1mGQbaDgL0UgTkJ
 opALxQ1iLOMjVRlT6538AJ+uQcX19NqwDvtEHAltYWXmU6DndBWi7fkEdSDZjmxOJmHCuyc
 b1ateFoLc7+XOw/6ahpQQ==
UI-OutboundReport: notjunk:1;M01:P0:F5FBtN0lweg=;kATYCqPFR6yogdY2drQGjoshUdG
 YaL4eTNZCz4NKET9TYmfjlTiGqdDY9Z/QC4ou7TvgRojDIr2QOcaIllYByw22nVhYMtshXZDy
 2uq0Rc7CVEpaPJBYJ4IAhhgNXFLoenmvyU7VrYNUARa5ewle7lNut8u+u/n47VEJ3UsIrdmKh
 c7Ov57GDCTtxNVcz/5dPgP5hJeKrNG5X5tt2jUaF37PGsujAh7XGNWlPDWHNm+UzQHc3lCjyQ
 yfSBRUQZP6YXRffIRQM4ZVjjoCNEPgnW+qMwAxu7sX940J6bOI8SpaCYUocoUuZNF75jCY6eU
 DzTAES5lJiKNZb/GBdQZF6XR1eNDPIlA9nu4Ll42t1kdNY1Lmn2zEW2ad9ZCdaY0YxqAZID0/
 TgWgMFMDp1irNdGgTgXsKjMzaJ7GYZzoEUitEghIcqfnxsyblA+VkA9Uf4rN5ptGr/Uzu+qzk
 1F+tC/EMZDq8nS5fghv/c+xR1E6Ks1BU4kquRA9e/VBvaGeiA4p/DrAVG0se8SFpwHZqfbvpb
 6d4PSUHoAjJIeqNdMC596lEq7e4yOe4gYK2caRMFOpO8xsPbKECX0rA046772Ex28q2wL95fX
 Ztt395Uls2+ch+zNnbcB0F4avELSU2IrzENruSn2sdZouKaolqHU85ryXtjWrHTZFSg84LbQQ
 tP8NvMUDXXNBY/aCWBkF6liV+5qsUGhCinngazdUWFnzt5pXig12l51A2MwL38J7p3ka5MAo8
 /EPeJ+73haDQSzWduOdYzwdUQsyv5hZkxbFdzJZhHbdpdE6Gv+Tb4UMnL2FvWFcKQkubEIu5Y
 Mnr6aX9DQoc7RfxurbObWfQ22cqdtmckaCjbDhZinObWi03pEFsJIgUIxwJF4zH+HxM5pxMDI
 BKZbZ0eUe/prq0hPPdzBG6x7Roz53EnnUL5ZaPjUgr2SoNdRvmoALHQEw
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

Am 12=2E November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>It is handy to be able to quickly build and boot a QEMU image for a
>particular architecture and distro=2E
>
>Add a script for this purpose=2E It supports only arm and x86 at present=
=2E
>For distros it only supports Ubuntu=2E Both 32- and 64-bit builds are
>supported=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> MAINTAINERS                    |   8 ++
> doc/board/emulation/index=2Erst  |   1 +
> doc/board/emulation/script=2Erst |  61 ++++++++++++
> scripts/build-qemu=2Esh          | 175 +++++++++++++++++++++++++++++++++
> 4 files changed, 245 insertions(+)
> create mode 100644 doc/board/emulation/script=2Erst
> create mode 100755 scripts/build-qemu=2Esh
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 0399ed1dbf6=2E=2Eb45bb96d5a5 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1110,6 +1110,14 @@ F:	tools/efivar=2Epy
> F:	tools/file2include=2Ec
> F:	tools/mkeficapsule=2Ec
>=20
>+EMULATION
>+M:	Simon Glass <sjg@chromium=2Eorg>
>+S:	Maintained
>+W:	https://docs=2Eu-boot=2Eorg/en/latest/board/emulation/script=2Ehtml
>+F:	configs/qemu_x86*
>+F:	doc/board/emulation/script=2Erst
>+F:	scripts/build-qemu=2Esh

Please, avoid misnomers=2E This script does not build QEMU=2E

>+
> ENVIRONMENT
> M:	Joe Hershberger <joe=2Ehershberger@ni=2Ecom>
> S:	Maintained
>diff --git a/doc/board/emulation/index=2Erst b/doc/board/emulation/index=
=2Erst
>index f8908166276=2E=2E5a2a00ae225 100644
>--- a/doc/board/emulation/index=2Erst
>+++ b/doc/board/emulation/index=2Erst
>@@ -8,6 +8,7 @@ Emulation
>=20
>    acpi
>    blkdev
>+   script
>    qemu-arm
>    qemu-mips
>    qemu-ppce500
>diff --git a/doc/board/emulation/script=2Erst b/doc/board/emulation/scrip=
t=2Erst

Just another misnomer=2E This page is not about script=2Esh=2E

>new file mode 100644
>index 00000000000=2E=2E23981e333cb
>--- /dev/null
>+++ b/doc/board/emulation/script=2Erst
>@@ -0,0 +1,61 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+

This is not a valid SPDX identifier=2E

>+
>+Script for building and running
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+
>+You may find the script `scripts/build-qemu=2Esh` helpful for building a=
nd testing
>+U-Boot on QEMU=2E
>+
>+If uses a environment variables to control how it works:
>+
>+ubdir
>+    base directory for building U-Boot, with each board being in its own
>+    subdirectory
>+
>+imagedir
>+    directory containing OS images, containin a subdirectory for each di=
stro
>+    type (e=2Eg=2E ubuntu/
>+
>+Once configured, you can build and run QEMU for arm64 like this::

This downloads the QEMU source and builds it?

>+
>+    scripts/build-qemu=2Esh -rsw
>+
>+No support is currently included for specifying a root disk, so this scr=
ipt can
>+only be used to start installers=2E
>+
>+Options
>+~~~~~~~
>+
>+Options are available to control the script:
>+
>+-a <arch>
>+    Select architecture (default arm, x86)
>+
>+-B
>+    Don't build; assume a build exists
>+
>+-k
>+    Use kvm - kernel-based Virtual Machine=2E By default QEMU uses its o=
wn
>+    emulator
>+
>+-o <os>
>+    Run an Operating System=2E For now this only supports 'ubuntu'=2E Th=
e name of
>+    the OS file must remain unchanged from its standard name on the Ubun=
tu
>+    website=2E

The U-Boot project should remain open to all operating systems=2E How will=
 this work with OpenBSD?

Use the URL of the image as argument=2E

>+
>+-r
>+    Run QEMU with the image (by default this is not done)
>+
>+-R
>+    Select OS release (e=2Eg=2E 24=2E04)=2E
>+
>+-s
>+    Use serial only (no display)
>+
>+-w
>+    Use word version (32-bit)=2E By default, 64-bit is used

"word version" is not helpful as explanation=2E

Look at <https://en=2Em=2Ewikipedia=2Eorg/wiki/Word_(computer_architecture=
)> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit sy=
stem=2E

>+
>+=2E=2E note::
>+
>+    Note: For now this is a shell script, but if it expands it might be =
better
>+    as Python, accepting the slower startup=2E
>diff --git a/scripts/build-qemu=2Esh b/scripts/build-qemu=2Esh
>new file mode 100755
>index 00000000000=2E=2E0ff53593cf9
>--- /dev/null
>+++ b/scripts/build-qemu=2Esh
>@@ -0,0 +1,175 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-2=2E0+

This is not a valid SPDX identifier=2E

>+#
>+# Script to build U-Boot suitable for booting with QEMU, possibly runnin=
g
>+# it, possibly with an OS image
>+
>+# This just an example=2E It assumes that
>+
>+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board=
 config
>+# - your OS images are in ${imagedir}/{distroname}/=2E=2E=2E
>+
>+# So far the script supports only ARM and x86=2E

Why support obsolete i386 but not riscv64?

>+
>+set -e
>+
>+usage() {
>+	(
>+	if [[ -n "$1" ]]; then
>+		echo "$1"
>+		echo
>+	fi
>+	echo "Usage: $0 -aBkrsw"
>+	echo
>+	echo "   -a   - Select architecture (arm, x86)"
>+	echo "   -B   - Don't build; assume a build exists"
>+	echo "   -k   - Use kvm (kernel-based Virtual Machine)"
>+	echo "   -o   - Run Operating System ('ubuntu' only for now)"
>+	echo "   -r   - Run QEMU with the image"
>+	echo "   -R   - Select OS release (e=2Eg=2E 24=2E04)"
>+	echo "   -s   - Use serial only (no display)"
>+	echo "   -w   - Use word version (32-bit)" ) >&2
>+	exit 1
>+}
>+
>+# Directory tree for OS images
>+imagedir=3D${imagedir-/vid/software/linux}
>+
>+# architecture (arm or x86)
>+arch=3Darm
>+
>+# 32- or 64-bit build
>+bitness=3D64
>+
>+# Build U-Boot
>+build=3Dyes
>+
>+# Extra setings
>+extra=3D
>+
>+# Operating System to boot (ubuntu)
>+os=3D
>+
>+release=3D24=2E04=2E1
>+
>+# run the image with QEMU
>+run=3D
>+
>+# run QEMU without a display (U-Boot must be set to stdout=3Dserial)
>+serial=3D
>+
>+# Use kvm
>+kvm=3D
>+
>+# Set ubdir to the build directory where you build U-Boot out-of-tree
>+# We avoid in-tree build because it gets confusing trying different buil=
ds
>+ubdir=3D${ubdir-/tmp/b}
>+
>+while getopts "a:Bko:rR:sw" opt; do
>+	case "${opt}" in
>+	a)
>+		arch=3D$OPTARG
>+		;;
>+	B)
>+		build=3D
>+		;;
>+	k)
>+		kvm=3D"-enable-kvm"
>+		;;
>+	o)
>+		os=3D$OPTARG
>+
>+		# Expand memory and CPUs
>+		extra+=3D" -m 4G -smp 4"
>+		;;
>+	r)
>+		run=3D1
>+		;;
>+	R)
>+		release=3D$OPTARG
>+		;;
>+	s)
>+		serial=3D1
>+		;;
>+	w)
>+		bitness=3D32
>+		;;
>+	*)
>+		usage
>+		;;
>+	esac
>+done
>+
>+# Build U-Boot for the selected board
>+build_u_boot() {
>+	buildman -w -o $DIR --board $BOARD -I || exit $?
>+}
>+
>+# Run QEMU with U-Boot
>+run_qemu() {
>+	if [[ -n "${os_image}" ]]; then
>+		extra+=3D" -drive if=3Dvirtio,file=3D${os_image},format=3Draw,id=3Dhd0=
"
>+	fi
>+	if [[ -n "${serial}" ]]; then
>+		extra+=3D" -display none -serial mon:stdio"
>+	else
>+		extra+=3D" -serial mon:stdio"
>+	fi
>+	echo "Running ${qemu} ${extra}"
>+	"${qemu}" -bios "$DIR/${BIOS}" \
>+		-m 512 \

Ubuntu suggests 4 GiB as minimum for a desktop=2E

>+		-nic none \

Who wants to run without network?
Use the virtio nic=2E

>+		${kvm} \
>+		${extra}
>+}
>+
>+# Check architecture
>+case "${arch}" in
>+arm)
>+	BOARD=3D"qemu_arm"
>+	BIOS=3D"u-boot=2Ebin"
>+	qemu=3Dqemu-system-arm
>+	extra+=3D" -machine virt"
>+	suffix=3D"arm"
>+	if [[ "${bitness}" =3D=3D "64" ]]; then
>+		BOARD=3D"qemu_arm64"
>+		qemu=3Dqemu-system-aarch64
>+		extra+=3D" -cpu cortex-a57"

That CPU is 12 years old and not all distros are stuck on ARM v8=2E0=2E Se=
e <https://en=2Eopensuse=2Eorg/Arm_architecture_support>=2E

-cpu max works fine with both tcg and kvm=2E

>+		suffix=3D"arm64"

>+	fi
>+	;;
>+x86)
>+	BOARD=3D"qemu-x86"
>+	BIOS=3D"u-boot=2Erom"
>+	qemu=3Dqemu-system-i386
>+	suffix=3D"i386"
>+	if [[ "${bitness}" =3D=3D "64" ]]; then
>+		BOARD=3D"qemu-x86_64"
>+		qemu=3Dqemu-system-x86_64
>+		suffix=3D"amd64"
>+	fi
>+	;;
>+*)
>+	usage "Unknown architecture '${arch}'"
>+esac
>+
>+# Check OS
>+case "${os}" in
>+ubuntu)
>+	os_image=3D"${imagedir}/${os}/${os}-${release}-desktop-${suffix}=2Eiso"

There is no ARM 32-bit Ubuntu desktop=2E And for i386 there is no image in=
 24=2E04=2E1=2E

Running a foreign architecture desktop with tcg is not enjoyable=2E

For testing U-Boot a server image is all it takes=2E

Best regards

Heinrich


>+	;;
>+"")
>+	;;
>+*)
>+	usage "Unknown OS '${os}'"
>+esac
>+
>+DIR=3D${ubdir}/${BOARD}
>+
>+if [[ -n "${build}" ]]; then
>+	build_u_boot
>+fi
>+
>+if [[ -n "${run}" ]]; then
>+	run_qemu
>+fi

