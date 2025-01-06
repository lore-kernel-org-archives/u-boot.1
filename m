Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D636E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FDD8036B;
	Mon,  6 Jan 2025 15:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Guo43LUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8245C803DC; Mon,  6 Jan 2025 15:55:26 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D413801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso115515246d6.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736175322; x=1736780122; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Iw8dnX3jqdvOIzA3mNQMWVEvNnBpJxPQLabkNdI2hfg=;
 b=Guo43LUzP/C3qHqYulXiMhFe27hveZ4atQp37eO3ziW1Pn3PkpjTVKQt5vGTUpNSr4
 755Il1M92pB+VyE9nkERDW7VjJy0n2H+Kwv/jnXuAOIU8GEXToMzXwBU+T/6ue0Czhrt
 RBup2Y8Lsq6wFkA7awxKAXPYOFy/EQkirbMSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736175322; x=1736780122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iw8dnX3jqdvOIzA3mNQMWVEvNnBpJxPQLabkNdI2hfg=;
 b=t0rgGiPAB+p0bv5O5NW+/Mfb5gFIwOcqVlVsZ8/Im9lXl6TTNXEY0t2YeMDg5n1BBZ
 cTtDKmcsycMkUk4CbkBCkMIe2FDfPbfsBN7oQ2wHwVTaxMclKyEIQZLR81VNXy+wwGfX
 9tz/mCMKr/dD2lCM4t1qk5lN+Y1/dwUjfPGbYP14XPB1hXzk2A4jVp0SoE8rExR6E965
 idL6Od6QojFnhIYBXTtbrNtgX7TAJ2SeYvRBpitFGD0Zb1y/ZfrKBnP7kWQICyAg9jgS
 cKX+eGwZ4bWd/f2QCOyipcGxVwajHwOcs+lVq5mH9XPBin/YwQfGBhq7TQbIORrFat+g
 NN9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqxnRjFjQhyKZeeqa0gwxOOY+O4gK7Ck3z0MRHmjuBgIuDZS0DtEScKzQipf1KFJSSFK6fClc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/B12Br+PJXCm8UDGpQ/zaMeg9OoB8n2n9b9oaGjiDLii8O26H
 mmHHnhWZfC7uHdCxbpkb9XtGfagTBduTwykkhV0UtZ4ZgLt+U6H9E56bvBzea58=
X-Gm-Gg: ASbGnctcA6FcmULFinvdOOIl25cVE0X2t+skuCjxP/Vtliqu60pmZ5/l8t5FXsMP56d
 FhNyeaZwQ/CkD6mPDgYLsPkz0cZVI1cdvYlBAKRS6x5C8iOyqJKZJ6FQcxigNJ4bjA+/u8Mq2nP
 38hboPhEQCm1YLdnm4WT5acWRGEv8btm6ACrP4+HLGeq4rATZdwYLeLGzOWNgV1AlR9qo5YZgB3
 oq12Oygj81HdjZkQWenaoIwGKokyhi+4DVd92glsPHVk6FDNxAerItilA==
X-Google-Smtp-Source: AGHT+IGpbT7mOngT55wlhCHk7U6YFOOZVF/AeG9omOtkMl+HY0dU6uGBO3B3Mr2mws1GbjB0zkyfuQ==
X-Received: by 2002:a05:6214:dac:b0:6d8:9124:8799 with SMTP id
 6a1803df08f44-6dd2331f006mr1134968296d6.5.1736175322181; 
 Mon, 06 Jan 2025 06:55:22 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ebe59sm170788856d6.27.2025.01.06.06.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:55:21 -0800 (PST)
Date: Mon, 6 Jan 2025 08:55:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
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
Message-ID: <20250106145517.GY3476@bill-the-cat>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
 <20241115151403.GW3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e0IeQgBpFi8qhBUk"
Content-Disposition: inline
In-Reply-To: <20241115151403.GW3600562@bill-the-cat>
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


--e0IeQgBpFi8qhBUk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 09:14:03AM -0600, Tom Rini wrote:
> On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> > > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
> > > > >It is handy to be able to quickly build and boot a QEMU image for a
> > > > >particular architecture and distro.
> > > > >
> > > > >Add a script for this purpose. It supports only arm and x86 at pre=
sent.
> > > > >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> > > > >supported.
> > > > >
> > > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >---
> > > > >
> > > > > MAINTAINERS                    |   8 ++
> > > > > doc/board/emulation/index.rst  |   1 +
> > > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > > scripts/build-qemu.sh          | 175 ++++++++++++++++++++++++++++=
+++++
> > > > > 4 files changed, 245 insertions(+)
> > > > > create mode 100644 doc/board/emulation/script.rst
> > > > > create mode 100755 scripts/build-qemu.sh
> > > > >
> > > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > > >--- a/MAINTAINERS
> > > > >+++ b/MAINTAINERS
> > > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > > F:  tools/file2include.c
> > > > > F:  tools/mkeficapsule.c
> > > > >
> > > > >+EMULATION
> > > > >+M:  Simon Glass <sjg@chromium.org>
> > > > >+S:  Maintained
> > > > >+W:  https://docs.u-boot.org/en/latest/board/emulation/script.html
> > > > >+F:  configs/qemu_x86*
> > > > >+F:  doc/board/emulation/script.rst
> > > > >+F:  scripts/build-qemu.sh
> > > >
> > > > Please, avoid misnomers. This script does not build QEMU.
> > > >
> > > > >+
> > > > > ENVIRONMENT
> > > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > > S:  Maintained
> > > > >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/i=
ndex.rst
> > > > >index f8908166276..5a2a00ae225 100644
> > > > >--- a/doc/board/emulation/index.rst
> > > > >+++ b/doc/board/emulation/index.rst
> > > > >@@ -8,6 +8,7 @@ Emulation
> > > > >
> > > > >    acpi
> > > > >    blkdev
> > > > >+   script
> > > > >    qemu-arm
> > > > >    qemu-mips
> > > > >    qemu-ppce500
> > > > >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/=
script.rst
> > > >
> > > > Just another misnomer. This page is not about script.sh.
> > > >
> > > > >new file mode 100644
> > > > >index 00000000000..23981e333cb
> > > > >--- /dev/null
> > > > >+++ b/doc/board/emulation/script.rst
> > > > >@@ -0,0 +1,61 @@
> > > > >+.. SPDX-License-Identifier: GPL-2.0+
> > > >
> > > > This is not a valid SPDX identifier.
> > > >
> > > > >+
> > > > >+Script for building and running
> > > > >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >+
> > > > >+You may find the script `scripts/build-qemu.sh` helpful for build=
ing and testing
> > > > >+U-Boot on QEMU.
> > > > >+
> > > > >+If uses a environment variables to control how it works:
> > > > >+
> > > > >+ubdir
> > > > >+    base directory for building U-Boot, with each board being in =
its own
> > > > >+    subdirectory
> > > > >+
> > > > >+imagedir
> > > > >+    directory containing OS images, containin a subdirectory for =
each distro
> > > > >+    type (e.g. ubuntu/
> > > > >+
> > > > >+Once configured, you can build and run QEMU for arm64 like this::
> > > >
> > > > This downloads the QEMU source and builds it?
> > > >
> > > > >+
> > > > >+    scripts/build-qemu.sh -rsw
> > > > >+
> > > > >+No support is currently included for specifying a root disk, so t=
his script can
> > > > >+only be used to start installers.
> > > > >+
> > > > >+Options
> > > > >+~~~~~~~
> > > > >+
> > > > >+Options are available to control the script:
> > > > >+
> > > > >+-a <arch>
> > > > >+    Select architecture (default arm, x86)
> > > > >+
> > > > >+-B
> > > > >+    Don't build; assume a build exists
> > > > >+
> > > > >+-k
> > > > >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses =
its own
> > > > >+    emulator
> > > > >+
> > > > >+-o <os>
> > > > >+    Run an Operating System. For now this only supports 'ubuntu'.=
 The name of
> > > > >+    the OS file must remain unchanged from its standard name on t=
he Ubuntu
> > > > >+    website.
> > > >
> > > > The U-Boot project should remain open to all operating systems. How=
 will this work with OpenBSD?
> > > >
> > > > Use the URL of the image as argument.
> > > >
> > > > >+
> > > > >+-r
> > > > >+    Run QEMU with the image (by default this is not done)
> > > > >+
> > > > >+-R
> > > > >+    Select OS release (e.g. 24.04).
> > > > >+
> > > > >+-s
> > > > >+    Use serial only (no display)
> > > > >+
> > > > >+-w
> > > > >+    Use word version (32-bit). By default, 64-bit is used
> > > >
> > > > "word version" is not helpful as explanation.
> > > >
> > > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architectur=
e)> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit s=
ystem.
> > > >
> > > > >+
> > > > >+.. note::
> > > > >+
> > > > >+    Note: For now this is a shell script, but if it expands it mi=
ght be better
> > > > >+    as Python, accepting the slower startup.
> > > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > > > >new file mode 100755
> > > > >index 00000000000..0ff53593cf9
> > > > >--- /dev/null
> > > > >+++ b/scripts/build-qemu.sh
> > > > >@@ -0,0 +1,175 @@
> > > > >+#!/bin/bash
> > > > >+# SPDX-License-Identifier: GPL-2.0+
> > > >
> > > > This is not a valid SPDX identifier.
> > > >
> > > > >+#
> > > > >+# Script to build U-Boot suitable for booting with QEMU, possibly=
 running
> > > > >+# it, possibly with an OS image
> > > > >+
> > > > >+# This just an example. It assumes that
> > > > >+
> > > > >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boo=
t board config
> > > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > > >+
> > > > >+# So far the script supports only ARM and x86.
> > > >
> > > > Why support obsolete i386 but not riscv64?
> > > >
> > > > >+
> > > > >+set -e
> > > > >+
> > > > >+usage() {
> > > > >+    (
> > > > >+    if [[ -n "$1" ]]; then
> > > > >+            echo "$1"
> > > > >+            echo
> > > > >+    fi
> > > > >+    echo "Usage: $0 -aBkrsw"
> > > > >+    echo
> > > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > > >+    echo "   -B   - Don't build; assume a build exists"
> > > > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > > > >+    echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > > > >+    echo "   -r   - Run QEMU with the image"
> > > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > > >+    echo "   -s   - Use serial only (no display)"
> > > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > > >+    exit 1
> > > > >+}
> > > > >+
> > > > >+# Directory tree for OS images
> > > > >+imagedir=3D${imagedir-/vid/software/linux}
> > > > >+
> > > > >+# architecture (arm or x86)
> > > > >+arch=3Darm
> > > > >+
> > > > >+# 32- or 64-bit build
> > > > >+bitness=3D64
> > > > >+
> > > > >+# Build U-Boot
> > > > >+build=3Dyes
> > > > >+
> > > > >+# Extra setings
> > > > >+extra=3D
> > > > >+
> > > > >+# Operating System to boot (ubuntu)
> > > > >+os=3D
> > > > >+
> > > > >+release=3D24.04.1
> > > > >+
> > > > >+# run the image with QEMU
> > > > >+run=3D
> > > > >+
> > > > >+# run QEMU without a display (U-Boot must be set to stdout=3Dseri=
al)
> > > > >+serial=3D
> > > > >+
> > > > >+# Use kvm
> > > > >+kvm=3D
> > > > >+
> > > > >+# Set ubdir to the build directory where you build U-Boot out-of-=
tree
> > > > >+# We avoid in-tree build because it gets confusing trying differe=
nt builds
> > > > >+ubdir=3D${ubdir-/tmp/b}
> > > > >+
> > > > >+while getopts "a:Bko:rR:sw" opt; do
> > > > >+    case "${opt}" in
> > > > >+    a)
> > > > >+            arch=3D$OPTARG
> > > > >+            ;;
> > > > >+    B)
> > > > >+            build=3D
> > > > >+            ;;
> > > > >+    k)
> > > > >+            kvm=3D"-enable-kvm"
> > > > >+            ;;
> > > > >+    o)
> > > > >+            os=3D$OPTARG
> > > > >+
> > > > >+            # Expand memory and CPUs
> > > > >+            extra+=3D" -m 4G -smp 4"
> > > > >+            ;;
> > > > >+    r)
> > > > >+            run=3D1
> > > > >+            ;;
> > > > >+    R)
> > > > >+            release=3D$OPTARG
> > > > >+            ;;
> > > > >+    s)
> > > > >+            serial=3D1
> > > > >+            ;;
> > > > >+    w)
> > > > >+            bitness=3D32
> > > > >+            ;;
> > > > >+    *)
> > > > >+            usage
> > > > >+            ;;
> > > > >+    esac
> > > > >+done
> > > > >+
> > > > >+# Build U-Boot for the selected board
> > > > >+build_u_boot() {
> > > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > > >+}
> > > > >+
> > > > >+# Run QEMU with U-Boot
> > > > >+run_qemu() {
> > > > >+    if [[ -n "${os_image}" ]]; then
> > > > >+            extra+=3D" -drive if=3Dvirtio,file=3D${os_image},form=
at=3Draw,id=3Dhd0"
> > > > >+    fi
> > > > >+    if [[ -n "${serial}" ]]; then
> > > > >+            extra+=3D" -display none -serial mon:stdio"
> > > > >+    else
> > > > >+            extra+=3D" -serial mon:stdio"
> > > > >+    fi
> > > > >+    echo "Running ${qemu} ${extra}"
> > > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > > >+            -m 512 \
> > > >
> > > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > > >
> > > > >+            -nic none \
> > > >
> > > > Who wants to run without network?
> > > > Use the virtio nic.
> > > >
> > > > >+            ${kvm} \
> > > > >+            ${extra}
> > > > >+}
> > > > >+
> > > > >+# Check architecture
> > > > >+case "${arch}" in
> > > > >+arm)
> > > > >+    BOARD=3D"qemu_arm"
> > > > >+    BIOS=3D"u-boot.bin"
> > > > >+    qemu=3Dqemu-system-arm
> > > > >+    extra+=3D" -machine virt"
> > > > >+    suffix=3D"arm"
> > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > >+            BOARD=3D"qemu_arm64"
> > > > >+            qemu=3Dqemu-system-aarch64
> > > > >+            extra+=3D" -cpu cortex-a57"
> > > >
> > > > That CPU is 12 years old and not all distros are stuck on ARM v8.0.=
 See <https://en.opensuse.org/Arm_architecture_support>.
> > > >
> > > > -cpu max works fine with both tcg and kvm.
> > > >
> > > > >+            suffix=3D"arm64"
> > > >
> > > > >+    fi
> > > > >+    ;;
> > > > >+x86)
> > > > >+    BOARD=3D"qemu-x86"
> > > > >+    BIOS=3D"u-boot.rom"
> > > > >+    qemu=3Dqemu-system-i386
> > > > >+    suffix=3D"i386"
> > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > >+            BOARD=3D"qemu-x86_64"
> > > > >+            qemu=3Dqemu-system-x86_64
> > > > >+            suffix=3D"amd64"
> > > > >+    fi
> > > > >+    ;;
> > > > >+*)
> > > > >+    usage "Unknown architecture '${arch}'"
> > > > >+esac
> > > > >+
> > > > >+# Check OS
> > > > >+case "${os}" in
> > > > >+ubuntu)
> > > > >+    os_image=3D"${imagedir}/${os}/${os}-${release}-desktop-${suff=
ix}.iso"
> > > >
> > > > There is no ARM 32-bit Ubuntu desktop. And for i386 there is no ima=
ge in 24.04.1.
> > > >
> > > > Running a foreign architecture desktop with tcg is not enjoyable.
> > > >
> > > > For testing U-Boot a server image is all it takes.
> > >
> > > And _all_ of this is why I don't want to add a useful personal script
> > > as an additional tool we support. I've seen how much work goes in to =
the
> > > OpenEmbedded runqemu script, we don't have the spare cycles for
> > > something like that. Doubly so when ultimately I believe we would be
> > > well served by having a document that says (in much more words) to lo=
ok
> > > at u-boot-test-hooks for how to invoke QEMU for a large number of
> > > architectures and platforms and to then further leverage general QEMU
> > > tips and guides on how to run an OS of your choice with that.
> >=20
> > I'm not sure it matters that much. Everyone is going to have their
> > preference as to how this script should look, but no one else has
> > taken the time to write one...
> >=20
> > People are free to send patches to enhance it. But I believe it is
> > helpful, e.g. for repeating problems caused by recent lmb patches.
> >=20
> > Re the test hooks, I just get tired of looking them up and trying to
> > figure out what to do. Every board name and arch is slightly
> > different. Just a hassle that I don't need.
> >=20
> > We can put it in scripts/contrib if you like.
>=20
> It's handy to point people to scripts, yes. I frequently point people at
> my wrappers around buildman for example for "how do I find code bloat?"
> and similar. But no, I don't think this rises to the level of
> "scripts/contrib".

Coming back to this question again. I'd be willing to make a new
top-level repository for "contributor tooling" and also make that more
widely writable. But I also think you're underestimating the level of
work required to have a "generic" script here that works on arbitrary
developer machines.

--=20
Tom

--e0IeQgBpFi8qhBUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd77tIACgkQFHw5/5Y0
tyy3TQv9EnPG6RmTDvybMAGVvkunnHnkUSAJQwqLpaLKY9uJ0oxtBQf4rT5xOjJZ
e8buPspIi5ccDPYUi421DRJA5pdzyXuJztE9hMyGAnvfbmcfY3oHFeDLNjX46OX2
qZSNtGVV6vWZw94NlfEvkPbsjz2DifEAf39GLmerrtaXWKYhSAVNzfIL0kgUPNHE
27rJQClonmKVTMYFN//Ipt0XmG9lzdvXP6n9ZUQay+d2a1fwylQJN5M+iHctrsLl
wSKtWKUbR8hqT87Tfomp1PleyRYI3k0733k6JNDSt9ZU0Dk3Aq5IQTR/WnW+WrLJ
gVurGoCYZ+RsXjwWgx+PRBbkoC7K1M8xXEMn3Cmw5dY8HNXxHMpRyhVhlV3qLyDd
8M7K7UV8JK1Ch1Cq39VRQViFiH/bvY+hfDAFfgdQXzbw39K0rJ80sA7FE3agiuF7
bDLkr21i3iS7T5HRkwldDtKpMaXgFJTQ4SdLdcaHU00ogaWk6qO7SrAQSiGaayma
lDCxFl0/
=DVEF
-----END PGP SIGNATURE-----

--e0IeQgBpFi8qhBUk--
