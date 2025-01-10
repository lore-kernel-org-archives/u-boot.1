Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9711E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A72E801F5;
	Fri, 10 Jan 2025 17:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oh6G726f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79388036B; Fri, 10 Jan 2025 17:01:18 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D98180050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so292760385a.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736524874; x=1737129674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VhkxaIKKP3ab5O7UuoG7YqCGLTyEGyoPjUMNye3TRo4=;
 b=Oh6G726fLc4jPjJOIT8Jq0Bu1YpiuBrkhdBKmOTAJBjo1HsxvgEPkHnk8tDQAPVPZj
 2Mpye5kikznOp2Kd1Jy3LX3P22/XXlHVbTNAmKNqf3D9MM7RZU/2Ux4uJB2znYDdELeF
 QDLk+cb8NvYkxHSpAWOeEYCqVxmOQEmf8ZKeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524874; x=1737129674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhkxaIKKP3ab5O7UuoG7YqCGLTyEGyoPjUMNye3TRo4=;
 b=wsXcEK1awoAUhqDAehFipjTy6S/SvawKglMQJklxeCEasnrj0GfuFr314ORa62exPT
 KpXPqa8R8G7nnKZtYHvX2alAD1SMZMsfIv92J/GBsk0l49cCX1NMsJNMcFu9y4A3aZIa
 tLvq/VSsIkNqzz5aOcEM3O4ILmWzoMozuBhhxcl03fD4s13hr/pY1Dg+MUH8FiGD13Bq
 ZBqeGdFPzV302borsk42a6kPDoGf4Z7Qb5vd8djYLPOVCqXdpkNrDhZK9/EAwKsNtD3+
 Rq2HROzac9qu8FsxGYE0nYtRzVDr3hQxrTz+dgYJcEkgXwwFoB36989Yi5wwKmGrsL9b
 46ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbbbjGvLmU/sms/EP0mAZXhSAzyznPPJNinz93+XgHOd9f42pW6NpxSnvk5Fpn1HPMOHUZmNI=@lists.denx.de
X-Gm-Message-State: AOJu0YzYJ1fmclep3fHJ4/YuBkK2gRTNXjEUxSTzxZmpu83sJfIIZH6R
 +xygTKO6AtUJbcjk+b+MSPpp/5y0C0TSQQll0Gg/PkV39weClkCYqG88mK7Sr34=
X-Gm-Gg: ASbGncu3NubxEpHDPmTrAvmIvaYfAGmxY/efejw09LsBe4or/KJ/vQpogUSyNH76Ui4
 fiEUTgnXMAv1xB2K0cvAIoL4m+nH5gpfFvjyxfTgWCVok2YWKYjJ1UbM0fhtRX0Hr3Ctp53khXi
 NXjk5GmCVTaECo3Pdt3AUyZoc+RAOMzpx+FDcW/m7+HjricEfk254LRijU0NKxJhH7myAusfExi
 PdInLzRfWCZqd1Ef480TkkGbY42eLyqy66I1bP7XQ/RB7M8+Ib5wkg=
X-Google-Smtp-Source: AGHT+IGL9CXL/T0oALpoVHevkxT6CKcMzs9zSl8M4IcosoPfe8sv5hJHGXkwzB0FRzKjhOTmrJhRHQ==
X-Received: by 2002:a05:620a:d87:b0:7b6:d632:37cf with SMTP id
 af79cd13be357-7bcd9729affmr1583092985a.3.1736524874115; 
 Fri, 10 Jan 2025 08:01:14 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3248283sm184771585a.37.2025.01.10.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 08:01:12 -0800 (PST)
Date: Fri, 10 Jan 2025 10:01:09 -0600
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
Message-ID: <20250110160109.GH3476@bill-the-cat>
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
 <20241115151403.GW3600562@bill-the-cat>
 <20250106145517.GY3476@bill-the-cat>
 <CAFLszTjJvA7=QdNTza48O45e85yGO=XGr6EEkVVd=xYrrkH-GA@mail.gmail.com>
 <20250109145620.GS3476@bill-the-cat>
 <CAFLszTiyUyFyp57VuAXV1SS67tSWVmxyrs8Oqs-Jd27UAwDz2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eZD6A4sEXHdn6R79"
Content-Disposition: inline
In-Reply-To: <CAFLszTiyUyFyp57VuAXV1SS67tSWVmxyrs8Oqs-Jd27UAwDz2w@mail.gmail.com>
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


--eZD6A4sEXHdn6R79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 06:39:19AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:36:34AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 6 Jan 2025 at 07:55, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Nov 15, 2024 at 09:14:03AM -0600, Tom Rini wrote:
> > > > > On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt=
 wrote:
> > > > > > > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@=
chromium.org>:
> > > > > > > > >It is handy to be able to quickly build and boot a QEMU im=
age for a
> > > > > > > > >particular architecture and distro.
> > > > > > > > >
> > > > > > > > >Add a script for this purpose. It supports only arm and x8=
6 at present.
> > > > > > > > >For distros it only supports Ubuntu. Both 32- and 64-bit b=
uilds are
> > > > > > > > >supported.
> > > > > > > > >
> > > > > > > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >---
> > > > > > > > >
> > > > > > > > > MAINTAINERS                    |   8 ++
> > > > > > > > > doc/board/emulation/index.rst  |   1 +
> > > > > > > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > > > > > > scripts/build-qemu.sh          | 175 ++++++++++++++++++++=
+++++++++++++
> > > > > > > > > 4 files changed, 245 insertions(+)
> > > > > > > > > create mode 100644 doc/board/emulation/script.rst
> > > > > > > > > create mode 100755 scripts/build-qemu.sh
> > > > > > > > >
> > > > > > > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > > > > > > >--- a/MAINTAINERS
> > > > > > > > >+++ b/MAINTAINERS
> > > > > > > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > > > > > > F:  tools/file2include.c
> > > > > > > > > F:  tools/mkeficapsule.c
> > > > > > > > >
> > > > > > > > >+EMULATION
> > > > > > > > >+M:  Simon Glass <sjg@chromium.org>
> > > > > > > > >+S:  Maintained
> > > > > > > > >+W:  https://docs.u-boot.org/en/latest/board/emulation/scr=
ipt.html
> > > > > > > > >+F:  configs/qemu_x86*
> > > > > > > > >+F:  doc/board/emulation/script.rst
> > > > > > > > >+F:  scripts/build-qemu.sh
> > > > > > > >
> > > > > > > > Please, avoid misnomers. This script does not build QEMU.
> > > > > > > >
> > > > > > > > >+
> > > > > > > > > ENVIRONMENT
> > > > > > > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > > > > > > S:  Maintained
> > > > > > > > >diff --git a/doc/board/emulation/index.rst b/doc/board/emu=
lation/index.rst
> > > > > > > > >index f8908166276..5a2a00ae225 100644
> > > > > > > > >--- a/doc/board/emulation/index.rst
> > > > > > > > >+++ b/doc/board/emulation/index.rst
> > > > > > > > >@@ -8,6 +8,7 @@ Emulation
> > > > > > > > >
> > > > > > > > >    acpi
> > > > > > > > >    blkdev
> > > > > > > > >+   script
> > > > > > > > >    qemu-arm
> > > > > > > > >    qemu-mips
> > > > > > > > >    qemu-ppce500
> > > > > > > > >diff --git a/doc/board/emulation/script.rst b/doc/board/em=
ulation/script.rst
> > > > > > > >
> > > > > > > > Just another misnomer. This page is not about script.sh.
> > > > > > > >
> > > > > > > > >new file mode 100644
> > > > > > > > >index 00000000000..23981e333cb
> > > > > > > > >--- /dev/null
> > > > > > > > >+++ b/doc/board/emulation/script.rst
> > > > > > > > >@@ -0,0 +1,61 @@
> > > > > > > > >+.. SPDX-License-Identifier: GPL-2.0+
> > > > > > > >
> > > > > > > > This is not a valid SPDX identifier.
> > > > > > > >
> > > > > > > > >+
> > > > > > > > >+Script for building and running
> > > > > > > > >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > >+
> > > > > > > > >+You may find the script `scripts/build-qemu.sh` helpful f=
or building and testing
> > > > > > > > >+U-Boot on QEMU.
> > > > > > > > >+
> > > > > > > > >+If uses a environment variables to control how it works:
> > > > > > > > >+
> > > > > > > > >+ubdir
> > > > > > > > >+    base directory for building U-Boot, with each board b=
eing in its own
> > > > > > > > >+    subdirectory
> > > > > > > > >+
> > > > > > > > >+imagedir
> > > > > > > > >+    directory containing OS images, containin a subdirect=
ory for each distro
> > > > > > > > >+    type (e.g. ubuntu/
> > > > > > > > >+
> > > > > > > > >+Once configured, you can build and run QEMU for arm64 lik=
e this::
> > > > > > > >
> > > > > > > > This downloads the QEMU source and builds it?
> > > > > > > >
> > > > > > > > >+
> > > > > > > > >+    scripts/build-qemu.sh -rsw
> > > > > > > > >+
> > > > > > > > >+No support is currently included for specifying a root di=
sk, so this script can
> > > > > > > > >+only be used to start installers.
> > > > > > > > >+
> > > > > > > > >+Options
> > > > > > > > >+~~~~~~~
> > > > > > > > >+
> > > > > > > > >+Options are available to control the script:
> > > > > > > > >+
> > > > > > > > >+-a <arch>
> > > > > > > > >+    Select architecture (default arm, x86)
> > > > > > > > >+
> > > > > > > > >+-B
> > > > > > > > >+    Don't build; assume a build exists
> > > > > > > > >+
> > > > > > > > >+-k
> > > > > > > > >+    Use kvm - kernel-based Virtual Machine. By default QE=
MU uses its own
> > > > > > > > >+    emulator
> > > > > > > > >+
> > > > > > > > >+-o <os>
> > > > > > > > >+    Run an Operating System. For now this only supports '=
ubuntu'. The name of
> > > > > > > > >+    the OS file must remain unchanged from its standard n=
ame on the Ubuntu
> > > > > > > > >+    website.
> > > > > > > >
> > > > > > > > The U-Boot project should remain open to all operating syst=
ems. How will this work with OpenBSD?
> > > > > > > >
> > > > > > > > Use the URL of the image as argument.
> > > > > > > >
> > > > > > > > >+
> > > > > > > > >+-r
> > > > > > > > >+    Run QEMU with the image (by default this is not done)
> > > > > > > > >+
> > > > > > > > >+-R
> > > > > > > > >+    Select OS release (e.g. 24.04).
> > > > > > > > >+
> > > > > > > > >+-s
> > > > > > > > >+    Use serial only (no display)
> > > > > > > > >+
> > > > > > > > >+-w
> > > > > > > > >+    Use word version (32-bit). By default, 64-bit is used
> > > > > > > >
> > > > > > > > "word version" is not helpful as explanation.
> > > > > > > >
> > > > > > > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_arc=
hitecture)> which says a word is 64 bit on a 64-bit system and 16 bit on a =
16-bit system.
> > > > > > > >
> > > > > > > > >+
> > > > > > > > >+.. note::
> > > > > > > > >+
> > > > > > > > >+    Note: For now this is a shell script, but if it expan=
ds it might be better
> > > > > > > > >+    as Python, accepting the slower startup.
> > > > > > > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > > > > > > > >new file mode 100755
> > > > > > > > >index 00000000000..0ff53593cf9
> > > > > > > > >--- /dev/null
> > > > > > > > >+++ b/scripts/build-qemu.sh
> > > > > > > > >@@ -0,0 +1,175 @@
> > > > > > > > >+#!/bin/bash
> > > > > > > > >+# SPDX-License-Identifier: GPL-2.0+
> > > > > > > >
> > > > > > > > This is not a valid SPDX identifier.
> > > > > > > >
> > > > > > > > >+#
> > > > > > > > >+# Script to build U-Boot suitable for booting with QEMU, =
possibly running
> > > > > > > > >+# it, possibly with an OS image
> > > > > > > > >+
> > > > > > > > >+# This just an example. It assumes that
> > > > > > > > >+
> > > > > > > > >+# - you build U-Boot in ${ubdir}/<name> where <name> is t=
he U-Boot board config
> > > > > > > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > > > > > > >+
> > > > > > > > >+# So far the script supports only ARM and x86.
> > > > > > > >
> > > > > > > > Why support obsolete i386 but not riscv64?
> > > > > > > >
> > > > > > > > >+
> > > > > > > > >+set -e
> > > > > > > > >+
> > > > > > > > >+usage() {
> > > > > > > > >+    (
> > > > > > > > >+    if [[ -n "$1" ]]; then
> > > > > > > > >+            echo "$1"
> > > > > > > > >+            echo
> > > > > > > > >+    fi
> > > > > > > > >+    echo "Usage: $0 -aBkrsw"
> > > > > > > > >+    echo
> > > > > > > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > > > > > > >+    echo "   -B   - Don't build; assume a build exists"
> > > > > > > > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine=
)"
> > > > > > > > >+    echo "   -o   - Run Operating System ('ubuntu' only f=
or now)"
> > > > > > > > >+    echo "   -r   - Run QEMU with the image"
> > > > > > > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > > > > > > >+    echo "   -s   - Use serial only (no display)"
> > > > > > > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > > > > > > >+    exit 1
> > > > > > > > >+}
> > > > > > > > >+
> > > > > > > > >+# Directory tree for OS images
> > > > > > > > >+imagedir=3D${imagedir-/vid/software/linux}
> > > > > > > > >+
> > > > > > > > >+# architecture (arm or x86)
> > > > > > > > >+arch=3Darm
> > > > > > > > >+
> > > > > > > > >+# 32- or 64-bit build
> > > > > > > > >+bitness=3D64
> > > > > > > > >+
> > > > > > > > >+# Build U-Boot
> > > > > > > > >+build=3Dyes
> > > > > > > > >+
> > > > > > > > >+# Extra setings
> > > > > > > > >+extra=3D
> > > > > > > > >+
> > > > > > > > >+# Operating System to boot (ubuntu)
> > > > > > > > >+os=3D
> > > > > > > > >+
> > > > > > > > >+release=3D24.04.1
> > > > > > > > >+
> > > > > > > > >+# run the image with QEMU
> > > > > > > > >+run=3D
> > > > > > > > >+
> > > > > > > > >+# run QEMU without a display (U-Boot must be set to stdou=
t=3Dserial)
> > > > > > > > >+serial=3D
> > > > > > > > >+
> > > > > > > > >+# Use kvm
> > > > > > > > >+kvm=3D
> > > > > > > > >+
> > > > > > > > >+# Set ubdir to the build directory where you build U-Boot=
 out-of-tree
> > > > > > > > >+# We avoid in-tree build because it gets confusing trying=
 different builds
> > > > > > > > >+ubdir=3D${ubdir-/tmp/b}
> > > > > > > > >+
> > > > > > > > >+while getopts "a:Bko:rR:sw" opt; do
> > > > > > > > >+    case "${opt}" in
> > > > > > > > >+    a)
> > > > > > > > >+            arch=3D$OPTARG
> > > > > > > > >+            ;;
> > > > > > > > >+    B)
> > > > > > > > >+            build=3D
> > > > > > > > >+            ;;
> > > > > > > > >+    k)
> > > > > > > > >+            kvm=3D"-enable-kvm"
> > > > > > > > >+            ;;
> > > > > > > > >+    o)
> > > > > > > > >+            os=3D$OPTARG
> > > > > > > > >+
> > > > > > > > >+            # Expand memory and CPUs
> > > > > > > > >+            extra+=3D" -m 4G -smp 4"
> > > > > > > > >+            ;;
> > > > > > > > >+    r)
> > > > > > > > >+            run=3D1
> > > > > > > > >+            ;;
> > > > > > > > >+    R)
> > > > > > > > >+            release=3D$OPTARG
> > > > > > > > >+            ;;
> > > > > > > > >+    s)
> > > > > > > > >+            serial=3D1
> > > > > > > > >+            ;;
> > > > > > > > >+    w)
> > > > > > > > >+            bitness=3D32
> > > > > > > > >+            ;;
> > > > > > > > >+    *)
> > > > > > > > >+            usage
> > > > > > > > >+            ;;
> > > > > > > > >+    esac
> > > > > > > > >+done
> > > > > > > > >+
> > > > > > > > >+# Build U-Boot for the selected board
> > > > > > > > >+build_u_boot() {
> > > > > > > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > > > > > > >+}
> > > > > > > > >+
> > > > > > > > >+# Run QEMU with U-Boot
> > > > > > > > >+run_qemu() {
> > > > > > > > >+    if [[ -n "${os_image}" ]]; then
> > > > > > > > >+            extra+=3D" -drive if=3Dvirtio,file=3D${os_ima=
ge},format=3Draw,id=3Dhd0"
> > > > > > > > >+    fi
> > > > > > > > >+    if [[ -n "${serial}" ]]; then
> > > > > > > > >+            extra+=3D" -display none -serial mon:stdio"
> > > > > > > > >+    else
> > > > > > > > >+            extra+=3D" -serial mon:stdio"
> > > > > > > > >+    fi
> > > > > > > > >+    echo "Running ${qemu} ${extra}"
> > > > > > > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > > > > > > >+            -m 512 \
> > > > > > > >
> > > > > > > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > > > > > > >
> > > > > > > > >+            -nic none \
> > > > > > > >
> > > > > > > > Who wants to run without network?
> > > > > > > > Use the virtio nic.
> > > > > > > >
> > > > > > > > >+            ${kvm} \
> > > > > > > > >+            ${extra}
> > > > > > > > >+}
> > > > > > > > >+
> > > > > > > > >+# Check architecture
> > > > > > > > >+case "${arch}" in
> > > > > > > > >+arm)
> > > > > > > > >+    BOARD=3D"qemu_arm"
> > > > > > > > >+    BIOS=3D"u-boot.bin"
> > > > > > > > >+    qemu=3Dqemu-system-arm
> > > > > > > > >+    extra+=3D" -machine virt"
> > > > > > > > >+    suffix=3D"arm"
> > > > > > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > > > > > >+            BOARD=3D"qemu_arm64"
> > > > > > > > >+            qemu=3Dqemu-system-aarch64
> > > > > > > > >+            extra+=3D" -cpu cortex-a57"
> > > > > > > >
> > > > > > > > That CPU is 12 years old and not all distros are stuck on A=
RM v8.0. See <https://en.opensuse.org/Arm_architecture_support>.
> > > > > > > >
> > > > > > > > -cpu max works fine with both tcg and kvm.
> > > > > > > >
> > > > > > > > >+            suffix=3D"arm64"
> > > > > > > >
> > > > > > > > >+    fi
> > > > > > > > >+    ;;
> > > > > > > > >+x86)
> > > > > > > > >+    BOARD=3D"qemu-x86"
> > > > > > > > >+    BIOS=3D"u-boot.rom"
> > > > > > > > >+    qemu=3Dqemu-system-i386
> > > > > > > > >+    suffix=3D"i386"
> > > > > > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > > > > > >+            BOARD=3D"qemu-x86_64"
> > > > > > > > >+            qemu=3Dqemu-system-x86_64
> > > > > > > > >+            suffix=3D"amd64"
> > > > > > > > >+    fi
> > > > > > > > >+    ;;
> > > > > > > > >+*)
> > > > > > > > >+    usage "Unknown architecture '${arch}'"
> > > > > > > > >+esac
> > > > > > > > >+
> > > > > > > > >+# Check OS
> > > > > > > > >+case "${os}" in
> > > > > > > > >+ubuntu)
> > > > > > > > >+    os_image=3D"${imagedir}/${os}/${os}-${release}-deskto=
p-${suffix}.iso"
> > > > > > > >
> > > > > > > > There is no ARM 32-bit Ubuntu desktop. And for i386 there i=
s no image in 24.04.1.
> > > > > > > >
> > > > > > > > Running a foreign architecture desktop with tcg is not enjo=
yable.
> > > > > > > >
> > > > > > > > For testing U-Boot a server image is all it takes.
> > > > > > >
> > > > > > > And _all_ of this is why I don't want to add a useful persona=
l script
> > > > > > > as an additional tool we support. I've seen how much work goe=
s in to the
> > > > > > > OpenEmbedded runqemu script, we don't have the spare cycles f=
or
> > > > > > > something like that. Doubly so when ultimately I believe we w=
ould be
> > > > > > > well served by having a document that says (in much more word=
s) to look
> > > > > > > at u-boot-test-hooks for how to invoke QEMU for a large numbe=
r of
> > > > > > > architectures and platforms and to then further leverage gene=
ral QEMU
> > > > > > > tips and guides on how to run an OS of your choice with that.
> > > > > >
> > > > > > I'm not sure it matters that much. Everyone is going to have th=
eir
> > > > > > preference as to how this script should look, but no one else h=
as
> > > > > > taken the time to write one...
> > > > > >
> > > > > > People are free to send patches to enhance it. But I believe it=
 is
> > > > > > helpful, e.g. for repeating problems caused by recent lmb patch=
es.
> > > > > >
> > > > > > Re the test hooks, I just get tired of looking them up and tryi=
ng to
> > > > > > figure out what to do. Every board name and arch is slightly
> > > > > > different. Just a hassle that I don't need.
> > > > > >
> > > > > > We can put it in scripts/contrib if you like.
> > > > >
> > > > > It's handy to point people to scripts, yes. I frequently point pe=
ople at
> > > > > my wrappers around buildman for example for "how do I find code b=
loat?"
> > > > > and similar. But no, I don't think this rises to the level of
> > > > > "scripts/contrib".
> > > >
> > > > Coming back to this question again. I'd be willing to make a new
> > > > top-level repository for "contributor tooling" and also make that m=
ore
> > > > widely writable. But I also think you're underestimating the level =
of
> > > > work required to have a "generic" script here that works on arbitra=
ry
> > > > developer machines.
> > >
> > > Having it in a separate repo seems like too much of a pain, to me.
> > > When things change in U-Boot I would want to update the script (e.g.
> > > to add UPL support, booting Ubuntu and the like).
> >
> > Being external means it's easier to use for bisect'ing problems and you
> > still have to handle UPL / no UPL and so on.
>=20
> There are trade-offs, for sure. Sometimes I use buildman from a
> separate tree when trying to debug something which changes buildman.
> But I don't think that warrants creating an entirely new tree for
> scripts.

It would also encourage others. I for example might put the scripts I
use for having buildman do various tasks there as well.

--=20
Tom

--eZD6A4sEXHdn6R79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBRDoACgkQFHw5/5Y0
tyyHuAwAmn9Z20ToToLMjLIc5fd7Z6ADr88b4ZOTubF7egidXEoV5ILQWkwqYxIp
1IUZhcJC7iDxukPAMLnoWgjdZdtsnzOj1tgK+vF+2v5v1+MKRZTuAQKEnX6ufCCS
UQz7satDt9mTM+3UmL6AiyOlurEDw25/SPT++OSHkNHH+MatcyKQxV5tx2k36fnD
TjAkMthz1UUEnRefgfLB0/h+76SsSO+D89Ho2grFUzEv/mmBMcFvsoFRdiSAB+R8
M6pzHBG36RCOYvHhflD32MInmnSI1iW2idtRrb23N0dUpUkOWLt5V3lZLBf3c+OE
BOiGC/N/RjO+A09NElnnoGBCvguPhozOO9hn0t2z7KLiTo0dQqzsFtNQKTZTG6gp
a2TTL7UV0ht6DATqwBGfn+v3lwk8JkdTkkAFMT8OohclNm1xg6egQp0BkgHewipx
L6ghjU11tUV70axuq0tPWziTCXnorBYlacy5TjMp7/1POeeZfBkfVTRiC/Ce16F9
un2BeY75
=BngV
-----END PGP SIGNATURE-----

--eZD6A4sEXHdn6R79--
