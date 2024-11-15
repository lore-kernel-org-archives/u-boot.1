Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E912D68BC8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 15:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92C189326;
	Fri, 15 Nov 2024 16:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TiiHPR04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C690C8908A; Fri, 15 Nov 2024 16:14:14 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2829189326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b14df8f821so140245985a.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731683649; x=1732288449; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6FJLAEjOBIcg8vEC1JQVZfwUicI/ldZoCXX5C0PmpFg=;
 b=TiiHPR040Ih11CMAv4Htgm4AWc3HEnbyMSy+vBCFXpJMml8x6GxjEi9HWEKfuhHJsw
 y5mxPFxjcG7XfbzSGCXZQBf/8UGjV/FBfUMYcwrlLXoP133SnidLPkPMM8YrxFZUWOHT
 jQYT7h4oSsr1sv0A1jROXiOWmhlhRtArcts7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731683649; x=1732288449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FJLAEjOBIcg8vEC1JQVZfwUicI/ldZoCXX5C0PmpFg=;
 b=wIlqVlVLCcG8NmI3WBvrT4JXDE74X4njUie4YkN9HyKCxyzH4rQhkUmw0MSJUKywuc
 8dp9WNOszQQEBrNV+AbGV4otI8ARfzjHVAPBCf3CgQX8YROk8RLmFgHj+xwG/FSQa9UZ
 SOPjrw7WyUlVcu7ecFVXZ08A+eyH6pVVv07WrMXnWJvr38Js4lsr4JHmuCIjCXIHvYnu
 QkM6vzAcrza06Yxo9xoPdld04KP4RPw4tt846t/261Px5FAsjGb3xpDaZmTllD4hXcv7
 MYBQcJuHBSb5089AQlyVpSW2F0EkHuszWYcVTK1YBreDoFZwTw47UVVOS/BlTQJXjVe6
 h1qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqiyCZkfIMbFmw1jntSs6O14v+DuYd+4x85Z4/c55medCKVMhiYoRT9csGnSle1tp+omN0pJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvbv6GcrcTVFvDRhg55B6PuhMhpa9t/DBkE+Z0yyd66dhsakfL
 5jwmOUa6hL+MsZSccs4vXjjUU8diMDWDmaXskxtaFpaxJeqp5JSU27rEj44u0T0=
X-Google-Smtp-Source: AGHT+IF2Ugo0RNqD2n9W5/w653aal84sV+CW3574R1vdfsFxa7oEiDK/87l9FJ3PhmN+F35FH2jvZQ==
X-Received: by 2002:a05:620a:46a4:b0:7ae:5c67:e1b8 with SMTP id
 af79cd13be357-7b3622d3c5fmr363082485a.20.1731683648265; 
 Fri, 15 Nov 2024 07:14:08 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca309d6sm166573685a.94.2024.11.15.07.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 07:14:07 -0800 (PST)
Date: Fri, 15 Nov 2024 09:14:03 -0600
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
Message-ID: <20241115151403.GW3600562@bill-the-cat>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZYcRx/VHdXeX6mWx"
Content-Disposition: inline
In-Reply-To: <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
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


--ZYcRx/VHdXeX6mWx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium.o=
rg>:
> > > >It is handy to be able to quickly build and boot a QEMU image for a
> > > >particular architecture and distro.
> > > >
> > > >Add a script for this purpose. It supports only arm and x86 at prese=
nt.
> > > >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> > > >supported.
> > > >
> > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >---
> > > >
> > > > MAINTAINERS                    |   8 ++
> > > > doc/board/emulation/index.rst  |   1 +
> > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > scripts/build-qemu.sh          | 175 ++++++++++++++++++++++++++++++=
+++
> > > > 4 files changed, 245 insertions(+)
> > > > create mode 100644 doc/board/emulation/script.rst
> > > > create mode 100755 scripts/build-qemu.sh
> > > >
> > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > >--- a/MAINTAINERS
> > > >+++ b/MAINTAINERS
> > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > F:  tools/file2include.c
> > > > F:  tools/mkeficapsule.c
> > > >
> > > >+EMULATION
> > > >+M:  Simon Glass <sjg@chromium.org>
> > > >+S:  Maintained
> > > >+W:  https://docs.u-boot.org/en/latest/board/emulation/script.html
> > > >+F:  configs/qemu_x86*
> > > >+F:  doc/board/emulation/script.rst
> > > >+F:  scripts/build-qemu.sh
> > >
> > > Please, avoid misnomers. This script does not build QEMU.
> > >
> > > >+
> > > > ENVIRONMENT
> > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > S:  Maintained
> > > >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/ind=
ex.rst
> > > >index f8908166276..5a2a00ae225 100644
> > > >--- a/doc/board/emulation/index.rst
> > > >+++ b/doc/board/emulation/index.rst
> > > >@@ -8,6 +8,7 @@ Emulation
> > > >
> > > >    acpi
> > > >    blkdev
> > > >+   script
> > > >    qemu-arm
> > > >    qemu-mips
> > > >    qemu-ppce500
> > > >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/sc=
ript.rst
> > >
> > > Just another misnomer. This page is not about script.sh.
> > >
> > > >new file mode 100644
> > > >index 00000000000..23981e333cb
> > > >--- /dev/null
> > > >+++ b/doc/board/emulation/script.rst
> > > >@@ -0,0 +1,61 @@
> > > >+.. SPDX-License-Identifier: GPL-2.0+
> > >
> > > This is not a valid SPDX identifier.
> > >
> > > >+
> > > >+Script for building and running
> > > >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >+
> > > >+You may find the script `scripts/build-qemu.sh` helpful for buildin=
g and testing
> > > >+U-Boot on QEMU.
> > > >+
> > > >+If uses a environment variables to control how it works:
> > > >+
> > > >+ubdir
> > > >+    base directory for building U-Boot, with each board being in it=
s own
> > > >+    subdirectory
> > > >+
> > > >+imagedir
> > > >+    directory containing OS images, containin a subdirectory for ea=
ch distro
> > > >+    type (e.g. ubuntu/
> > > >+
> > > >+Once configured, you can build and run QEMU for arm64 like this::
> > >
> > > This downloads the QEMU source and builds it?
> > >
> > > >+
> > > >+    scripts/build-qemu.sh -rsw
> > > >+
> > > >+No support is currently included for specifying a root disk, so thi=
s script can
> > > >+only be used to start installers.
> > > >+
> > > >+Options
> > > >+~~~~~~~
> > > >+
> > > >+Options are available to control the script:
> > > >+
> > > >+-a <arch>
> > > >+    Select architecture (default arm, x86)
> > > >+
> > > >+-B
> > > >+    Don't build; assume a build exists
> > > >+
> > > >+-k
> > > >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses it=
s own
> > > >+    emulator
> > > >+
> > > >+-o <os>
> > > >+    Run an Operating System. For now this only supports 'ubuntu'. T=
he name of
> > > >+    the OS file must remain unchanged from its standard name on the=
 Ubuntu
> > > >+    website.
> > >
> > > The U-Boot project should remain open to all operating systems. How w=
ill this work with OpenBSD?
> > >
> > > Use the URL of the image as argument.
> > >
> > > >+
> > > >+-r
> > > >+    Run QEMU with the image (by default this is not done)
> > > >+
> > > >+-R
> > > >+    Select OS release (e.g. 24.04).
> > > >+
> > > >+-s
> > > >+    Use serial only (no display)
> > > >+
> > > >+-w
> > > >+    Use word version (32-bit). By default, 64-bit is used
> > >
> > > "word version" is not helpful as explanation.
> > >
> > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architecture)=
> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit sys=
tem.
> > >
> > > >+
> > > >+.. note::
> > > >+
> > > >+    Note: For now this is a shell script, but if it expands it migh=
t be better
> > > >+    as Python, accepting the slower startup.
> > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > > >new file mode 100755
> > > >index 00000000000..0ff53593cf9
> > > >--- /dev/null
> > > >+++ b/scripts/build-qemu.sh
> > > >@@ -0,0 +1,175 @@
> > > >+#!/bin/bash
> > > >+# SPDX-License-Identifier: GPL-2.0+
> > >
> > > This is not a valid SPDX identifier.
> > >
> > > >+#
> > > >+# Script to build U-Boot suitable for booting with QEMU, possibly r=
unning
> > > >+# it, possibly with an OS image
> > > >+
> > > >+# This just an example. It assumes that
> > > >+
> > > >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot =
board config
> > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > >+
> > > >+# So far the script supports only ARM and x86.
> > >
> > > Why support obsolete i386 but not riscv64?
> > >
> > > >+
> > > >+set -e
> > > >+
> > > >+usage() {
> > > >+    (
> > > >+    if [[ -n "$1" ]]; then
> > > >+            echo "$1"
> > > >+            echo
> > > >+    fi
> > > >+    echo "Usage: $0 -aBkrsw"
> > > >+    echo
> > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > >+    echo "   -B   - Don't build; assume a build exists"
> > > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > > >+    echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > > >+    echo "   -r   - Run QEMU with the image"
> > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > >+    echo "   -s   - Use serial only (no display)"
> > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > >+    exit 1
> > > >+}
> > > >+
> > > >+# Directory tree for OS images
> > > >+imagedir=3D${imagedir-/vid/software/linux}
> > > >+
> > > >+# architecture (arm or x86)
> > > >+arch=3Darm
> > > >+
> > > >+# 32- or 64-bit build
> > > >+bitness=3D64
> > > >+
> > > >+# Build U-Boot
> > > >+build=3Dyes
> > > >+
> > > >+# Extra setings
> > > >+extra=3D
> > > >+
> > > >+# Operating System to boot (ubuntu)
> > > >+os=3D
> > > >+
> > > >+release=3D24.04.1
> > > >+
> > > >+# run the image with QEMU
> > > >+run=3D
> > > >+
> > > >+# run QEMU without a display (U-Boot must be set to stdout=3Dserial)
> > > >+serial=3D
> > > >+
> > > >+# Use kvm
> > > >+kvm=3D
> > > >+
> > > >+# Set ubdir to the build directory where you build U-Boot out-of-tr=
ee
> > > >+# We avoid in-tree build because it gets confusing trying different=
 builds
> > > >+ubdir=3D${ubdir-/tmp/b}
> > > >+
> > > >+while getopts "a:Bko:rR:sw" opt; do
> > > >+    case "${opt}" in
> > > >+    a)
> > > >+            arch=3D$OPTARG
> > > >+            ;;
> > > >+    B)
> > > >+            build=3D
> > > >+            ;;
> > > >+    k)
> > > >+            kvm=3D"-enable-kvm"
> > > >+            ;;
> > > >+    o)
> > > >+            os=3D$OPTARG
> > > >+
> > > >+            # Expand memory and CPUs
> > > >+            extra+=3D" -m 4G -smp 4"
> > > >+            ;;
> > > >+    r)
> > > >+            run=3D1
> > > >+            ;;
> > > >+    R)
> > > >+            release=3D$OPTARG
> > > >+            ;;
> > > >+    s)
> > > >+            serial=3D1
> > > >+            ;;
> > > >+    w)
> > > >+            bitness=3D32
> > > >+            ;;
> > > >+    *)
> > > >+            usage
> > > >+            ;;
> > > >+    esac
> > > >+done
> > > >+
> > > >+# Build U-Boot for the selected board
> > > >+build_u_boot() {
> > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > >+}
> > > >+
> > > >+# Run QEMU with U-Boot
> > > >+run_qemu() {
> > > >+    if [[ -n "${os_image}" ]]; then
> > > >+            extra+=3D" -drive if=3Dvirtio,file=3D${os_image},format=
=3Draw,id=3Dhd0"
> > > >+    fi
> > > >+    if [[ -n "${serial}" ]]; then
> > > >+            extra+=3D" -display none -serial mon:stdio"
> > > >+    else
> > > >+            extra+=3D" -serial mon:stdio"
> > > >+    fi
> > > >+    echo "Running ${qemu} ${extra}"
> > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > >+            -m 512 \
> > >
> > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > >
> > > >+            -nic none \
> > >
> > > Who wants to run without network?
> > > Use the virtio nic.
> > >
> > > >+            ${kvm} \
> > > >+            ${extra}
> > > >+}
> > > >+
> > > >+# Check architecture
> > > >+case "${arch}" in
> > > >+arm)
> > > >+    BOARD=3D"qemu_arm"
> > > >+    BIOS=3D"u-boot.bin"
> > > >+    qemu=3Dqemu-system-arm
> > > >+    extra+=3D" -machine virt"
> > > >+    suffix=3D"arm"
> > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > >+            BOARD=3D"qemu_arm64"
> > > >+            qemu=3Dqemu-system-aarch64
> > > >+            extra+=3D" -cpu cortex-a57"
> > >
> > > That CPU is 12 years old and not all distros are stuck on ARM v8.0. S=
ee <https://en.opensuse.org/Arm_architecture_support>.
> > >
> > > -cpu max works fine with both tcg and kvm.
> > >
> > > >+            suffix=3D"arm64"
> > >
> > > >+    fi
> > > >+    ;;
> > > >+x86)
> > > >+    BOARD=3D"qemu-x86"
> > > >+    BIOS=3D"u-boot.rom"
> > > >+    qemu=3Dqemu-system-i386
> > > >+    suffix=3D"i386"
> > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > >+            BOARD=3D"qemu-x86_64"
> > > >+            qemu=3Dqemu-system-x86_64
> > > >+            suffix=3D"amd64"
> > > >+    fi
> > > >+    ;;
> > > >+*)
> > > >+    usage "Unknown architecture '${arch}'"
> > > >+esac
> > > >+
> > > >+# Check OS
> > > >+case "${os}" in
> > > >+ubuntu)
> > > >+    os_image=3D"${imagedir}/${os}/${os}-${release}-desktop-${suffix=
}.iso"
> > >
> > > There is no ARM 32-bit Ubuntu desktop. And for i386 there is no image=
 in 24.04.1.
> > >
> > > Running a foreign architecture desktop with tcg is not enjoyable.
> > >
> > > For testing U-Boot a server image is all it takes.
> >
> > And _all_ of this is why I don't want to add a useful personal script
> > as an additional tool we support. I've seen how much work goes in to the
> > OpenEmbedded runqemu script, we don't have the spare cycles for
> > something like that. Doubly so when ultimately I believe we would be
> > well served by having a document that says (in much more words) to look
> > at u-boot-test-hooks for how to invoke QEMU for a large number of
> > architectures and platforms and to then further leverage general QEMU
> > tips and guides on how to run an OS of your choice with that.
>=20
> I'm not sure it matters that much. Everyone is going to have their
> preference as to how this script should look, but no one else has
> taken the time to write one...
>=20
> People are free to send patches to enhance it. But I believe it is
> helpful, e.g. for repeating problems caused by recent lmb patches.
>=20
> Re the test hooks, I just get tired of looking them up and trying to
> figure out what to do. Every board name and arch is slightly
> different. Just a hassle that I don't need.
>=20
> We can put it in scripts/contrib if you like.

It's handy to point people to scripts, yes. I frequently point people at
my wrappers around buildman for example for "how do I find code bloat?"
and similar. But no, I don't think this rises to the level of
"scripts/contrib".

--=20
Tom

--ZYcRx/VHdXeX6mWx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3ZTcACgkQFHw5/5Y0
tyy4twv9G+tYJbpqeKrdSjrBf4eCJkIg4UqQ7Re6bQCM48C268P/cq2FhgsL13lO
8idCR7cBZk8zfeP6I71sV3gKCaMHXvuy1es27jGp6Ma3kMQ94bQM6SiqHjhPBbgn
Ow9MqUxt0AQuUmsxI0LcUbPmbpTIGQ6rvDsyuVMnRrPvgaMhiO3ypyRolcKcHITr
AslIg6fzAIyKzA66JmZjVsTfFipF6pRkXZGvZrfXX923MslDL4ZtkZn/m2vGnNV1
usHlvD9Xdap25LT/CIE7xdvJaTA2hNiQS1QnrSuQseNgHpv0uk9uJtXOZfPx//j0
YtCHOXDHodeBBSMKvlYkgpehQADTeNH8SucDsPte0YWT13cmyv5MbtAsCXX8X2RN
SAynOxXSTTwmpQYZbOi3yL3Z8HbJRxzmNNHH7AqAejwXiQBZ/1I+2T7zk08Q+8r2
pRBpHk9RChR9bNK3sgjTWUgjNDt8rla/xGoKIaS/WMhX9rR5OLTgY/y00FSBZnCF
zrwtzzSA
=CXn/
-----END PGP SIGNATURE-----

--ZYcRx/VHdXeX6mWx--
