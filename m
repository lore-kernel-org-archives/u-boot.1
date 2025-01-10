Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AC6E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AAD805E9;
	Fri, 10 Jan 2025 14:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kn3G9hKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D001E8061B; Fri, 10 Jan 2025 14:39:45 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E4A0806CB
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso2727329a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516381; x=1737121181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RG3kh9M4wpCqhbCKCCUr+MKVbHJiIRRSwzInZ5qerWw=;
 b=kn3G9hKfUVV0nMsQb4/r+Q1myy5F69cCJNIiU9vpxOKWEbfhjJ0/1wXDP/7JYe+Uo7
 tbA7fg8+Ecd5TAB5UoB2BR20ecxL/32JVvpO+IUTThzmtXYC1E+Vl02jsoFhqkC1pWqE
 sxtRgDqLQTXP5fw72spubdzV7QDI83xVvf6wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516381; x=1737121181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RG3kh9M4wpCqhbCKCCUr+MKVbHJiIRRSwzInZ5qerWw=;
 b=mR2P4AaLpcb37etLYPtS+9G3b0DsYjrMMH+rreCye8aZgG+bPF4jibqFGskuIqCjCo
 z/CvtW9tacvpMikPfABxs5byW8ztya7gsBvHpCWD4QROmnwAdrvmXTiC4Ukno1Ox703/
 zU0+qYvmMOlmHlRU4CvyssKhi+wSPNHRYYIkf83KxsoJPlCun2njLPg/A64ISa7uInX+
 MnX7UPpS5P44FuKmYUB18vKjW9kOpI+yH3nSaIE3faOJz8a30W3Ug8wJl017T0tB90XG
 /hsRRw7lih0DoNV6C1m1t1NeWc8y4lraqG6Q4nP5By0//9x5AeLSg7R6l8moM7J2p0xX
 +Kew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIp8IRv+Xp7NzXXWbUzMBpjjfqj6AqWfdUmYBo6SzAZRJQG7EivpNum6DZUpwPaNn64mCcwAw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtu+qFLvx/7PY7RS8pxppRvMAtkbGL0xdqD0254O7kHQeQa7ne
 3eAU8KmRa5obSM494X2PO9DKjKUkCztR4A3o6x5spJraIPrVdrVKdlR/THcYqP+VNWipof7GWNg
 YMf+7YPXUQy6HeQK4YmbebkcNWMMFqY1P9qM0WifnM7jrVe8=
X-Gm-Gg: ASbGncvNY6lzycDYqbRxbaVwrCCv/UCqNrpL7+0m+1Ess1c0eHog5YA8ttvPEjDks9j
 l6sav+XWOaN8F7qeT6s7mvCUU+UIDLaUxpaeWqgE=
X-Google-Smtp-Source: AGHT+IGecMVsgZj31jWJZaFrFaR2QDvBtdftxTMszla5bleqNlhph9EQJgJXEPA0GsS0cxkPWu+e+9reDdbQWcIXMfs=
X-Received: by 2002:a17:90a:fc48:b0:2ee:b2fe:eeeb with SMTP id
 98e67ed59e1d1-2f548eca9dfmr13773044a91.22.1736516380822; Fri, 10 Jan 2025
 05:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
 <20241115151403.GW3600562@bill-the-cat> <20250106145517.GY3476@bill-the-cat>
 <CAFLszTjJvA7=QdNTza48O45e85yGO=XGr6EEkVVd=xYrrkH-GA@mail.gmail.com>
 <20250109145620.GS3476@bill-the-cat>
In-Reply-To: <20250109145620.GS3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:39:19 -0700
X-Gm-Features: AbW1kvapLbgA4BArDUwehVSRzPgwV7BlOAMYDb4RevuxkOPjk32hFFnfZK8X9Wo
Message-ID: <CAFLszTiyUyFyp57VuAXV1SS67tSWVmxyrs8Oqs-Jd27UAwDz2w@mail.gmail.com>
Subject: Re: [PATCH 01/18] scripts: Add a script for building and booting QEMU
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 9 Jan 2025 at 07:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 05:36:34AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 6 Jan 2025 at 07:55, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 15, 2024 at 09:14:03AM -0600, Tom Rini wrote:
> > > > On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> > > > > > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > >It is handy to be able to quickly build and boot a QEMU image for a
> > > > > > > >particular architecture and distro.
> > > > > > > >
> > > > > > > >Add a script for this purpose. It supports only arm and x86 at present.
> > > > > > > >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> > > > > > > >supported.
> > > > > > > >
> > > > > > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >---
> > > > > > > >
> > > > > > > > MAINTAINERS                    |   8 ++
> > > > > > > > doc/board/emulation/index.rst  |   1 +
> > > > > > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > > > > > scripts/build-qemu.sh          | 175 +++++++++++++++++++++++++++++++++
> > > > > > > > 4 files changed, 245 insertions(+)
> > > > > > > > create mode 100644 doc/board/emulation/script.rst
> > > > > > > > create mode 100755 scripts/build-qemu.sh
> > > > > > > >
> > > > > > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > > > > > >--- a/MAINTAINERS
> > > > > > > >+++ b/MAINTAINERS
> > > > > > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > > > > > F:  tools/file2include.c
> > > > > > > > F:  tools/mkeficapsule.c
> > > > > > > >
> > > > > > > >+EMULATION
> > > > > > > >+M:  Simon Glass <sjg@chromium.org>
> > > > > > > >+S:  Maintained
> > > > > > > >+W:  https://docs.u-boot.org/en/latest/board/emulation/script.html
> > > > > > > >+F:  configs/qemu_x86*
> > > > > > > >+F:  doc/board/emulation/script.rst
> > > > > > > >+F:  scripts/build-qemu.sh
> > > > > > >
> > > > > > > Please, avoid misnomers. This script does not build QEMU.
> > > > > > >
> > > > > > > >+
> > > > > > > > ENVIRONMENT
> > > > > > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > > > > > S:  Maintained
> > > > > > > >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> > > > > > > >index f8908166276..5a2a00ae225 100644
> > > > > > > >--- a/doc/board/emulation/index.rst
> > > > > > > >+++ b/doc/board/emulation/index.rst
> > > > > > > >@@ -8,6 +8,7 @@ Emulation
> > > > > > > >
> > > > > > > >    acpi
> > > > > > > >    blkdev
> > > > > > > >+   script
> > > > > > > >    qemu-arm
> > > > > > > >    qemu-mips
> > > > > > > >    qemu-ppce500
> > > > > > > >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script.rst
> > > > > > >
> > > > > > > Just another misnomer. This page is not about script.sh.
> > > > > > >
> > > > > > > >new file mode 100644
> > > > > > > >index 00000000000..23981e333cb
> > > > > > > >--- /dev/null
> > > > > > > >+++ b/doc/board/emulation/script.rst
> > > > > > > >@@ -0,0 +1,61 @@
> > > > > > > >+.. SPDX-License-Identifier: GPL-2.0+
> > > > > > >
> > > > > > > This is not a valid SPDX identifier.
> > > > > > >
> > > > > > > >+
> > > > > > > >+Script for building and running
> > > > > > > >+===============================
> > > > > > > >+
> > > > > > > >+You may find the script `scripts/build-qemu.sh` helpful for building and testing
> > > > > > > >+U-Boot on QEMU.
> > > > > > > >+
> > > > > > > >+If uses a environment variables to control how it works:
> > > > > > > >+
> > > > > > > >+ubdir
> > > > > > > >+    base directory for building U-Boot, with each board being in its own
> > > > > > > >+    subdirectory
> > > > > > > >+
> > > > > > > >+imagedir
> > > > > > > >+    directory containing OS images, containin a subdirectory for each distro
> > > > > > > >+    type (e.g. ubuntu/
> > > > > > > >+
> > > > > > > >+Once configured, you can build and run QEMU for arm64 like this::
> > > > > > >
> > > > > > > This downloads the QEMU source and builds it?
> > > > > > >
> > > > > > > >+
> > > > > > > >+    scripts/build-qemu.sh -rsw
> > > > > > > >+
> > > > > > > >+No support is currently included for specifying a root disk, so this script can
> > > > > > > >+only be used to start installers.
> > > > > > > >+
> > > > > > > >+Options
> > > > > > > >+~~~~~~~
> > > > > > > >+
> > > > > > > >+Options are available to control the script:
> > > > > > > >+
> > > > > > > >+-a <arch>
> > > > > > > >+    Select architecture (default arm, x86)
> > > > > > > >+
> > > > > > > >+-B
> > > > > > > >+    Don't build; assume a build exists
> > > > > > > >+
> > > > > > > >+-k
> > > > > > > >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
> > > > > > > >+    emulator
> > > > > > > >+
> > > > > > > >+-o <os>
> > > > > > > >+    Run an Operating System. For now this only supports 'ubuntu'. The name of
> > > > > > > >+    the OS file must remain unchanged from its standard name on the Ubuntu
> > > > > > > >+    website.
> > > > > > >
> > > > > > > The U-Boot project should remain open to all operating systems. How will this work with OpenBSD?
> > > > > > >
> > > > > > > Use the URL of the image as argument.
> > > > > > >
> > > > > > > >+
> > > > > > > >+-r
> > > > > > > >+    Run QEMU with the image (by default this is not done)
> > > > > > > >+
> > > > > > > >+-R
> > > > > > > >+    Select OS release (e.g. 24.04).
> > > > > > > >+
> > > > > > > >+-s
> > > > > > > >+    Use serial only (no display)
> > > > > > > >+
> > > > > > > >+-w
> > > > > > > >+    Use word version (32-bit). By default, 64-bit is used
> > > > > > >
> > > > > > > "word version" is not helpful as explanation.
> > > > > > >
> > > > > > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architecture)> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit system.
> > > > > > >
> > > > > > > >+
> > > > > > > >+.. note::
> > > > > > > >+
> > > > > > > >+    Note: For now this is a shell script, but if it expands it might be better
> > > > > > > >+    as Python, accepting the slower startup.
> > > > > > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > > > > > > >new file mode 100755
> > > > > > > >index 00000000000..0ff53593cf9
> > > > > > > >--- /dev/null
> > > > > > > >+++ b/scripts/build-qemu.sh
> > > > > > > >@@ -0,0 +1,175 @@
> > > > > > > >+#!/bin/bash
> > > > > > > >+# SPDX-License-Identifier: GPL-2.0+
> > > > > > >
> > > > > > > This is not a valid SPDX identifier.
> > > > > > >
> > > > > > > >+#
> > > > > > > >+# Script to build U-Boot suitable for booting with QEMU, possibly running
> > > > > > > >+# it, possibly with an OS image
> > > > > > > >+
> > > > > > > >+# This just an example. It assumes that
> > > > > > > >+
> > > > > > > >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
> > > > > > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > > > > > >+
> > > > > > > >+# So far the script supports only ARM and x86.
> > > > > > >
> > > > > > > Why support obsolete i386 but not riscv64?
> > > > > > >
> > > > > > > >+
> > > > > > > >+set -e
> > > > > > > >+
> > > > > > > >+usage() {
> > > > > > > >+    (
> > > > > > > >+    if [[ -n "$1" ]]; then
> > > > > > > >+            echo "$1"
> > > > > > > >+            echo
> > > > > > > >+    fi
> > > > > > > >+    echo "Usage: $0 -aBkrsw"
> > > > > > > >+    echo
> > > > > > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > > > > > >+    echo "   -B   - Don't build; assume a build exists"
> > > > > > > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > > > > > > >+    echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > > > > > > >+    echo "   -r   - Run QEMU with the image"
> > > > > > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > > > > > >+    echo "   -s   - Use serial only (no display)"
> > > > > > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > > > > > >+    exit 1
> > > > > > > >+}
> > > > > > > >+
> > > > > > > >+# Directory tree for OS images
> > > > > > > >+imagedir=${imagedir-/vid/software/linux}
> > > > > > > >+
> > > > > > > >+# architecture (arm or x86)
> > > > > > > >+arch=arm
> > > > > > > >+
> > > > > > > >+# 32- or 64-bit build
> > > > > > > >+bitness=64
> > > > > > > >+
> > > > > > > >+# Build U-Boot
> > > > > > > >+build=yes
> > > > > > > >+
> > > > > > > >+# Extra setings
> > > > > > > >+extra=
> > > > > > > >+
> > > > > > > >+# Operating System to boot (ubuntu)
> > > > > > > >+os=
> > > > > > > >+
> > > > > > > >+release=24.04.1
> > > > > > > >+
> > > > > > > >+# run the image with QEMU
> > > > > > > >+run=
> > > > > > > >+
> > > > > > > >+# run QEMU without a display (U-Boot must be set to stdout=serial)
> > > > > > > >+serial=
> > > > > > > >+
> > > > > > > >+# Use kvm
> > > > > > > >+kvm=
> > > > > > > >+
> > > > > > > >+# Set ubdir to the build directory where you build U-Boot out-of-tree
> > > > > > > >+# We avoid in-tree build because it gets confusing trying different builds
> > > > > > > >+ubdir=${ubdir-/tmp/b}
> > > > > > > >+
> > > > > > > >+while getopts "a:Bko:rR:sw" opt; do
> > > > > > > >+    case "${opt}" in
> > > > > > > >+    a)
> > > > > > > >+            arch=$OPTARG
> > > > > > > >+            ;;
> > > > > > > >+    B)
> > > > > > > >+            build=
> > > > > > > >+            ;;
> > > > > > > >+    k)
> > > > > > > >+            kvm="-enable-kvm"
> > > > > > > >+            ;;
> > > > > > > >+    o)
> > > > > > > >+            os=$OPTARG
> > > > > > > >+
> > > > > > > >+            # Expand memory and CPUs
> > > > > > > >+            extra+=" -m 4G -smp 4"
> > > > > > > >+            ;;
> > > > > > > >+    r)
> > > > > > > >+            run=1
> > > > > > > >+            ;;
> > > > > > > >+    R)
> > > > > > > >+            release=$OPTARG
> > > > > > > >+            ;;
> > > > > > > >+    s)
> > > > > > > >+            serial=1
> > > > > > > >+            ;;
> > > > > > > >+    w)
> > > > > > > >+            bitness=32
> > > > > > > >+            ;;
> > > > > > > >+    *)
> > > > > > > >+            usage
> > > > > > > >+            ;;
> > > > > > > >+    esac
> > > > > > > >+done
> > > > > > > >+
> > > > > > > >+# Build U-Boot for the selected board
> > > > > > > >+build_u_boot() {
> > > > > > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > > > > > >+}
> > > > > > > >+
> > > > > > > >+# Run QEMU with U-Boot
> > > > > > > >+run_qemu() {
> > > > > > > >+    if [[ -n "${os_image}" ]]; then
> > > > > > > >+            extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
> > > > > > > >+    fi
> > > > > > > >+    if [[ -n "${serial}" ]]; then
> > > > > > > >+            extra+=" -display none -serial mon:stdio"
> > > > > > > >+    else
> > > > > > > >+            extra+=" -serial mon:stdio"
> > > > > > > >+    fi
> > > > > > > >+    echo "Running ${qemu} ${extra}"
> > > > > > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > > > > > >+            -m 512 \
> > > > > > >
> > > > > > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > > > > > >
> > > > > > > >+            -nic none \
> > > > > > >
> > > > > > > Who wants to run without network?
> > > > > > > Use the virtio nic.
> > > > > > >
> > > > > > > >+            ${kvm} \
> > > > > > > >+            ${extra}
> > > > > > > >+}
> > > > > > > >+
> > > > > > > >+# Check architecture
> > > > > > > >+case "${arch}" in
> > > > > > > >+arm)
> > > > > > > >+    BOARD="qemu_arm"
> > > > > > > >+    BIOS="u-boot.bin"
> > > > > > > >+    qemu=qemu-system-arm
> > > > > > > >+    extra+=" -machine virt"
> > > > > > > >+    suffix="arm"
> > > > > > > >+    if [[ "${bitness}" == "64" ]]; then
> > > > > > > >+            BOARD="qemu_arm64"
> > > > > > > >+            qemu=qemu-system-aarch64
> > > > > > > >+            extra+=" -cpu cortex-a57"
> > > > > > >
> > > > > > > That CPU is 12 years old and not all distros are stuck on ARM v8.0. See <https://en.opensuse.org/Arm_architecture_support>.
> > > > > > >
> > > > > > > -cpu max works fine with both tcg and kvm.
> > > > > > >
> > > > > > > >+            suffix="arm64"
> > > > > > >
> > > > > > > >+    fi
> > > > > > > >+    ;;
> > > > > > > >+x86)
> > > > > > > >+    BOARD="qemu-x86"
> > > > > > > >+    BIOS="u-boot.rom"
> > > > > > > >+    qemu=qemu-system-i386
> > > > > > > >+    suffix="i386"
> > > > > > > >+    if [[ "${bitness}" == "64" ]]; then
> > > > > > > >+            BOARD="qemu-x86_64"
> > > > > > > >+            qemu=qemu-system-x86_64
> > > > > > > >+            suffix="amd64"
> > > > > > > >+    fi
> > > > > > > >+    ;;
> > > > > > > >+*)
> > > > > > > >+    usage "Unknown architecture '${arch}'"
> > > > > > > >+esac
> > > > > > > >+
> > > > > > > >+# Check OS
> > > > > > > >+case "${os}" in
> > > > > > > >+ubuntu)
> > > > > > > >+    os_image="${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
> > > > > > >
> > > > > > > There is no ARM 32-bit Ubuntu desktop. And for i386 there is no image in 24.04.1.
> > > > > > >
> > > > > > > Running a foreign architecture desktop with tcg is not enjoyable.
> > > > > > >
> > > > > > > For testing U-Boot a server image is all it takes.
> > > > > >
> > > > > > And _all_ of this is why I don't want to add a useful personal script
> > > > > > as an additional tool we support. I've seen how much work goes in to the
> > > > > > OpenEmbedded runqemu script, we don't have the spare cycles for
> > > > > > something like that. Doubly so when ultimately I believe we would be
> > > > > > well served by having a document that says (in much more words) to look
> > > > > > at u-boot-test-hooks for how to invoke QEMU for a large number of
> > > > > > architectures and platforms and to then further leverage general QEMU
> > > > > > tips and guides on how to run an OS of your choice with that.
> > > > >
> > > > > I'm not sure it matters that much. Everyone is going to have their
> > > > > preference as to how this script should look, but no one else has
> > > > > taken the time to write one...
> > > > >
> > > > > People are free to send patches to enhance it. But I believe it is
> > > > > helpful, e.g. for repeating problems caused by recent lmb patches.
> > > > >
> > > > > Re the test hooks, I just get tired of looking them up and trying to
> > > > > figure out what to do. Every board name and arch is slightly
> > > > > different. Just a hassle that I don't need.
> > > > >
> > > > > We can put it in scripts/contrib if you like.
> > > >
> > > > It's handy to point people to scripts, yes. I frequently point people at
> > > > my wrappers around buildman for example for "how do I find code bloat?"
> > > > and similar. But no, I don't think this rises to the level of
> > > > "scripts/contrib".
> > >
> > > Coming back to this question again. I'd be willing to make a new
> > > top-level repository for "contributor tooling" and also make that more
> > > widely writable. But I also think you're underestimating the level of
> > > work required to have a "generic" script here that works on arbitrary
> > > developer machines.
> >
> > Having it in a separate repo seems like too much of a pain, to me.
> > When things change in U-Boot I would want to update the script (e.g.
> > to add UPL support, booting Ubuntu and the like).
>
> Being external means it's easier to use for bisect'ing problems and you
> still have to handle UPL / no UPL and so on.

There are trade-offs, for sure. Sometimes I use buildman from a
separate tree when trying to debug something which changes buildman.
But I don't think that warrants creating an entirely new tree for
scripts.

Regards,
Simon
