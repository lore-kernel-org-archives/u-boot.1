Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AA1E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 19:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70651800D0;
	Fri, 10 Jan 2025 20:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IRrPJL5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3947A801F5; Fri, 10 Jan 2025 20:50:35 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CFF80050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 20:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so491630366b.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736538632; x=1737143432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VfJ+bImTZkn+JGksHirbFskh4uwpIIKOlMHM8FmJp48=;
 b=IRrPJL5nNNdfpQe+8/YrNmU6UNyTimcvXTLVQLQHTO/beTmoUWj1VBm+LTqIJoIHm3
 DPDWOnjFMy3ljYxunpqBRvdPzMSh+lm7cm1CHDJjYlcvtxaqnyps0fu9U1wSmxrN16M5
 YDGeInDPqvQdRwc1pWF+/vHkO44+vVeMJx+ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736538632; x=1737143432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfJ+bImTZkn+JGksHirbFskh4uwpIIKOlMHM8FmJp48=;
 b=iX6bBa1e7nKq5tuPMad0DNyhs7QGg1K5bf/c2Si4O+GWTCV7snBS6AscRRVgkhVNMl
 nkItfHyGAQC1+0NeGtngyHVbUHnGXeV15L4wrIvz6B/0nj1lX7FOzfEMg5Rntq5cPsJE
 s9tThwhHu5ywRdOt8vaKHnEPPDf/I0d1Pf25DeIvrkI6keoKM1A1C+3P8w27Dpxdxpzz
 sVE9KNBmCypNsKoAUBwt6M6q9I+aeA3vEN1mhY6WkHf9cqsnk+rlsLK6hFOS6kJpOEPR
 +Ovve8LuaSOa69kkqngoEBj23CQlXylliLEb8o72qQaPMRRY3A5yYc5q4L0IYR7vahRp
 myWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuE+cNFfa0rCtd3/VQX5KNu8GeuR9cV7cr1/pDspl+Q++I0iFL9wxqTGFhVfalR9Njv6lJuoc=@lists.denx.de
X-Gm-Message-State: AOJu0YwOaKnzmEH53k2lkqiXpOZRv+A3qdYcQEwNEOmLJKQk8uH3r9eC
 zVePFWqwNbZgX9q6dalubMBt2t6kdVwVXcrjPU6swzfVbbegZM7KxKLR6aq/wP6SALhCdnhCdwR
 EUkeGXolAXNO5CzCetx+yxhBKzZyk+OOHh5OK
X-Gm-Gg: ASbGncu2iFbA3oQNxTPKjtPRlA2kM/corWoHJqwd+jg0hPPVthxBAao3oj8RFQRPiud
 SgyCMBtJsbXiJDvs4QVAltxqHez/a+oXYohD4wXk=
X-Google-Smtp-Source: AGHT+IGiG1NDbCZ7GDbolFZ4sHWarSXGWmyN79pRxPZSJVETF8Ty4o4RiWLpXr7mq5GBKQDOe7u4qLFQHA0w3l2Ipw0=
X-Received: by 2002:a17:907:d03:b0:aa6:730c:acb with SMTP id
 a640c23a62f3a-ab2ab16a3bamr1101055766b.8.1736538631669; Fri, 10 Jan 2025
 11:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
 <20241115151403.GW3600562@bill-the-cat> <20250106145517.GY3476@bill-the-cat>
 <CAFLszTjJvA7=QdNTza48O45e85yGO=XGr6EEkVVd=xYrrkH-GA@mail.gmail.com>
 <20250109145620.GS3476@bill-the-cat>
 <CAFLszTiyUyFyp57VuAXV1SS67tSWVmxyrs8Oqs-Jd27UAwDz2w@mail.gmail.com>
 <20250110160109.GH3476@bill-the-cat>
In-Reply-To: <20250110160109.GH3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 12:50:20 -0700
X-Gm-Features: AbW1kvYE0RcfXD0YRlclgF6V_XF5GGMWSMzYZapJh5SUZ3p1tHD6tDkwK4CTLuE
Message-ID: <CAFLszThPDT3WzG169D+KaGKOT0vo4GJc7T4SoCZ6R+VbLed_Xw@mail.gmail.com>
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

On Fri, 10 Jan 2025 at 09:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 10, 2025 at 06:39:19AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Jan 2025 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 05:36:34AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 6 Jan 2025 at 07:55, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Nov 15, 2024 at 09:14:03AM -0600, Tom Rini wrote:
> > > > > > On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> > > > > > > > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > > > >It is handy to be able to quickly build and boot a QEMU image for a
> > > > > > > > > >particular architecture and distro.
> > > > > > > > > >
> > > > > > > > > >Add a script for this purpose. It supports only arm and x86 at present.
> > > > > > > > > >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> > > > > > > > > >supported.
> > > > > > > > > >
> > > > > > > > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > >---
> > > > > > > > > >
> > > > > > > > > > MAINTAINERS                    |   8 ++
> > > > > > > > > > doc/board/emulation/index.rst  |   1 +
> > > > > > > > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > > > > > > > scripts/build-qemu.sh          | 175 +++++++++++++++++++++++++++++++++
> > > > > > > > > > 4 files changed, 245 insertions(+)
> > > > > > > > > > create mode 100644 doc/board/emulation/script.rst
> > > > > > > > > > create mode 100755 scripts/build-qemu.sh
> > > > > > > > > >
> > > > > > > > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > > > > > > > >--- a/MAINTAINERS
> > > > > > > > > >+++ b/MAINTAINERS
> > > > > > > > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > > > > > > > F:  tools/file2include.c
> > > > > > > > > > F:  tools/mkeficapsule.c
> > > > > > > > > >
> > > > > > > > > >+EMULATION
> > > > > > > > > >+M:  Simon Glass <sjg@chromium.org>
> > > > > > > > > >+S:  Maintained
> > > > > > > > > >+W:  https://docs.u-boot.org/en/latest/board/emulation/script.html
> > > > > > > > > >+F:  configs/qemu_x86*
> > > > > > > > > >+F:  doc/board/emulation/script.rst
> > > > > > > > > >+F:  scripts/build-qemu.sh
> > > > > > > > >
> > > > > > > > > Please, avoid misnomers. This script does not build QEMU.
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > > ENVIRONMENT
> > > > > > > > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > > > > > > > S:  Maintained
> > > > > > > > > >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> > > > > > > > > >index f8908166276..5a2a00ae225 100644
> > > > > > > > > >--- a/doc/board/emulation/index.rst
> > > > > > > > > >+++ b/doc/board/emulation/index.rst
> > > > > > > > > >@@ -8,6 +8,7 @@ Emulation
> > > > > > > > > >
> > > > > > > > > >    acpi
> > > > > > > > > >    blkdev
> > > > > > > > > >+   script
> > > > > > > > > >    qemu-arm
> > > > > > > > > >    qemu-mips
> > > > > > > > > >    qemu-ppce500
> > > > > > > > > >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script.rst
> > > > > > > > >
> > > > > > > > > Just another misnomer. This page is not about script.sh.
> > > > > > > > >
> > > > > > > > > >new file mode 100644
> > > > > > > > > >index 00000000000..23981e333cb
> > > > > > > > > >--- /dev/null
> > > > > > > > > >+++ b/doc/board/emulation/script.rst
> > > > > > > > > >@@ -0,0 +1,61 @@
> > > > > > > > > >+.. SPDX-License-Identifier: GPL-2.0+
> > > > > > > > >
> > > > > > > > > This is not a valid SPDX identifier.
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > >+Script for building and running
> > > > > > > > > >+===============================
> > > > > > > > > >+
> > > > > > > > > >+You may find the script `scripts/build-qemu.sh` helpful for building and testing
> > > > > > > > > >+U-Boot on QEMU.
> > > > > > > > > >+
> > > > > > > > > >+If uses a environment variables to control how it works:
> > > > > > > > > >+
> > > > > > > > > >+ubdir
> > > > > > > > > >+    base directory for building U-Boot, with each board being in its own
> > > > > > > > > >+    subdirectory
> > > > > > > > > >+
> > > > > > > > > >+imagedir
> > > > > > > > > >+    directory containing OS images, containin a subdirectory for each distro
> > > > > > > > > >+    type (e.g. ubuntu/
> > > > > > > > > >+
> > > > > > > > > >+Once configured, you can build and run QEMU for arm64 like this::
> > > > > > > > >
> > > > > > > > > This downloads the QEMU source and builds it?
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > >+    scripts/build-qemu.sh -rsw
> > > > > > > > > >+
> > > > > > > > > >+No support is currently included for specifying a root disk, so this script can
> > > > > > > > > >+only be used to start installers.
> > > > > > > > > >+
> > > > > > > > > >+Options
> > > > > > > > > >+~~~~~~~
> > > > > > > > > >+
> > > > > > > > > >+Options are available to control the script:
> > > > > > > > > >+
> > > > > > > > > >+-a <arch>
> > > > > > > > > >+    Select architecture (default arm, x86)
> > > > > > > > > >+
> > > > > > > > > >+-B
> > > > > > > > > >+    Don't build; assume a build exists
> > > > > > > > > >+
> > > > > > > > > >+-k
> > > > > > > > > >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
> > > > > > > > > >+    emulator
> > > > > > > > > >+
> > > > > > > > > >+-o <os>
> > > > > > > > > >+    Run an Operating System. For now this only supports 'ubuntu'. The name of
> > > > > > > > > >+    the OS file must remain unchanged from its standard name on the Ubuntu
> > > > > > > > > >+    website.
> > > > > > > > >
> > > > > > > > > The U-Boot project should remain open to all operating systems. How will this work with OpenBSD?
> > > > > > > > >
> > > > > > > > > Use the URL of the image as argument.
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > >+-r
> > > > > > > > > >+    Run QEMU with the image (by default this is not done)
> > > > > > > > > >+
> > > > > > > > > >+-R
> > > > > > > > > >+    Select OS release (e.g. 24.04).
> > > > > > > > > >+
> > > > > > > > > >+-s
> > > > > > > > > >+    Use serial only (no display)
> > > > > > > > > >+
> > > > > > > > > >+-w
> > > > > > > > > >+    Use word version (32-bit). By default, 64-bit is used
> > > > > > > > >
> > > > > > > > > "word version" is not helpful as explanation.
> > > > > > > > >
> > > > > > > > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architecture)> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit system.
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > >+.. note::
> > > > > > > > > >+
> > > > > > > > > >+    Note: For now this is a shell script, but if it expands it might be better
> > > > > > > > > >+    as Python, accepting the slower startup.
> > > > > > > > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > > > > > > > > >new file mode 100755
> > > > > > > > > >index 00000000000..0ff53593cf9
> > > > > > > > > >--- /dev/null
> > > > > > > > > >+++ b/scripts/build-qemu.sh
> > > > > > > > > >@@ -0,0 +1,175 @@
> > > > > > > > > >+#!/bin/bash
> > > > > > > > > >+# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > >
> > > > > > > > > This is not a valid SPDX identifier.
> > > > > > > > >
> > > > > > > > > >+#
> > > > > > > > > >+# Script to build U-Boot suitable for booting with QEMU, possibly running
> > > > > > > > > >+# it, possibly with an OS image
> > > > > > > > > >+
> > > > > > > > > >+# This just an example. It assumes that
> > > > > > > > > >+
> > > > > > > > > >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
> > > > > > > > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > > > > > > > >+
> > > > > > > > > >+# So far the script supports only ARM and x86.
> > > > > > > > >
> > > > > > > > > Why support obsolete i386 but not riscv64?
> > > > > > > > >
> > > > > > > > > >+
> > > > > > > > > >+set -e
> > > > > > > > > >+
> > > > > > > > > >+usage() {
> > > > > > > > > >+    (
> > > > > > > > > >+    if [[ -n "$1" ]]; then
> > > > > > > > > >+            echo "$1"
> > > > > > > > > >+            echo
> > > > > > > > > >+    fi
> > > > > > > > > >+    echo "Usage: $0 -aBkrsw"
> > > > > > > > > >+    echo
> > > > > > > > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > > > > > > > >+    echo "   -B   - Don't build; assume a build exists"
> > > > > > > > > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > > > > > > > > >+    echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > > > > > > > > >+    echo "   -r   - Run QEMU with the image"
> > > > > > > > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > > > > > > > >+    echo "   -s   - Use serial only (no display)"
> > > > > > > > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > > > > > > > >+    exit 1
> > > > > > > > > >+}
> > > > > > > > > >+
> > > > > > > > > >+# Directory tree for OS images
> > > > > > > > > >+imagedir=${imagedir-/vid/software/linux}
> > > > > > > > > >+
> > > > > > > > > >+# architecture (arm or x86)
> > > > > > > > > >+arch=arm
> > > > > > > > > >+
> > > > > > > > > >+# 32- or 64-bit build
> > > > > > > > > >+bitness=64
> > > > > > > > > >+
> > > > > > > > > >+# Build U-Boot
> > > > > > > > > >+build=yes
> > > > > > > > > >+
> > > > > > > > > >+# Extra setings
> > > > > > > > > >+extra=
> > > > > > > > > >+
> > > > > > > > > >+# Operating System to boot (ubuntu)
> > > > > > > > > >+os=
> > > > > > > > > >+
> > > > > > > > > >+release=24.04.1
> > > > > > > > > >+
> > > > > > > > > >+# run the image with QEMU
> > > > > > > > > >+run=
> > > > > > > > > >+
> > > > > > > > > >+# run QEMU without a display (U-Boot must be set to stdout=serial)
> > > > > > > > > >+serial=
> > > > > > > > > >+
> > > > > > > > > >+# Use kvm
> > > > > > > > > >+kvm=
> > > > > > > > > >+
> > > > > > > > > >+# Set ubdir to the build directory where you build U-Boot out-of-tree
> > > > > > > > > >+# We avoid in-tree build because it gets confusing trying different builds
> > > > > > > > > >+ubdir=${ubdir-/tmp/b}
> > > > > > > > > >+
> > > > > > > > > >+while getopts "a:Bko:rR:sw" opt; do
> > > > > > > > > >+    case "${opt}" in
> > > > > > > > > >+    a)
> > > > > > > > > >+            arch=$OPTARG
> > > > > > > > > >+            ;;
> > > > > > > > > >+    B)
> > > > > > > > > >+            build=
> > > > > > > > > >+            ;;
> > > > > > > > > >+    k)
> > > > > > > > > >+            kvm="-enable-kvm"
> > > > > > > > > >+            ;;
> > > > > > > > > >+    o)
> > > > > > > > > >+            os=$OPTARG
> > > > > > > > > >+
> > > > > > > > > >+            # Expand memory and CPUs
> > > > > > > > > >+            extra+=" -m 4G -smp 4"
> > > > > > > > > >+            ;;
> > > > > > > > > >+    r)
> > > > > > > > > >+            run=1
> > > > > > > > > >+            ;;
> > > > > > > > > >+    R)
> > > > > > > > > >+            release=$OPTARG
> > > > > > > > > >+            ;;
> > > > > > > > > >+    s)
> > > > > > > > > >+            serial=1
> > > > > > > > > >+            ;;
> > > > > > > > > >+    w)
> > > > > > > > > >+            bitness=32
> > > > > > > > > >+            ;;
> > > > > > > > > >+    *)
> > > > > > > > > >+            usage
> > > > > > > > > >+            ;;
> > > > > > > > > >+    esac
> > > > > > > > > >+done
> > > > > > > > > >+
> > > > > > > > > >+# Build U-Boot for the selected board
> > > > > > > > > >+build_u_boot() {
> > > > > > > > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > > > > > > > >+}
> > > > > > > > > >+
> > > > > > > > > >+# Run QEMU with U-Boot
> > > > > > > > > >+run_qemu() {
> > > > > > > > > >+    if [[ -n "${os_image}" ]]; then
> > > > > > > > > >+            extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
> > > > > > > > > >+    fi
> > > > > > > > > >+    if [[ -n "${serial}" ]]; then
> > > > > > > > > >+            extra+=" -display none -serial mon:stdio"
> > > > > > > > > >+    else
> > > > > > > > > >+            extra+=" -serial mon:stdio"
> > > > > > > > > >+    fi
> > > > > > > > > >+    echo "Running ${qemu} ${extra}"
> > > > > > > > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > > > > > > > >+            -m 512 \
> > > > > > > > >
> > > > > > > > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > > > > > > > >
> > > > > > > > > >+            -nic none \
> > > > > > > > >
> > > > > > > > > Who wants to run without network?
> > > > > > > > > Use the virtio nic.
> > > > > > > > >
> > > > > > > > > >+            ${kvm} \
> > > > > > > > > >+            ${extra}
> > > > > > > > > >+}
> > > > > > > > > >+
> > > > > > > > > >+# Check architecture
> > > > > > > > > >+case "${arch}" in
> > > > > > > > > >+arm)
> > > > > > > > > >+    BOARD="qemu_arm"
> > > > > > > > > >+    BIOS="u-boot.bin"
> > > > > > > > > >+    qemu=qemu-system-arm
> > > > > > > > > >+    extra+=" -machine virt"
> > > > > > > > > >+    suffix="arm"
> > > > > > > > > >+    if [[ "${bitness}" == "64" ]]; then
> > > > > > > > > >+            BOARD="qemu_arm64"
> > > > > > > > > >+            qemu=qemu-system-aarch64
> > > > > > > > > >+            extra+=" -cpu cortex-a57"
> > > > > > > > >
> > > > > > > > > That CPU is 12 years old and not all distros are stuck on ARM v8.0. See <https://en.opensuse.org/Arm_architecture_support>.
> > > > > > > > >
> > > > > > > > > -cpu max works fine with both tcg and kvm.
> > > > > > > > >
> > > > > > > > > >+            suffix="arm64"
> > > > > > > > >
> > > > > > > > > >+    fi
> > > > > > > > > >+    ;;
> > > > > > > > > >+x86)
> > > > > > > > > >+    BOARD="qemu-x86"
> > > > > > > > > >+    BIOS="u-boot.rom"
> > > > > > > > > >+    qemu=qemu-system-i386
> > > > > > > > > >+    suffix="i386"
> > > > > > > > > >+    if [[ "${bitness}" == "64" ]]; then
> > > > > > > > > >+            BOARD="qemu-x86_64"
> > > > > > > > > >+            qemu=qemu-system-x86_64
> > > > > > > > > >+            suffix="amd64"
> > > > > > > > > >+    fi
> > > > > > > > > >+    ;;
> > > > > > > > > >+*)
> > > > > > > > > >+    usage "Unknown architecture '${arch}'"
> > > > > > > > > >+esac
> > > > > > > > > >+
> > > > > > > > > >+# Check OS
> > > > > > > > > >+case "${os}" in
> > > > > > > > > >+ubuntu)
> > > > > > > > > >+    os_image="${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
> > > > > > > > >
> > > > > > > > > There is no ARM 32-bit Ubuntu desktop. And for i386 there is no image in 24.04.1.
> > > > > > > > >
> > > > > > > > > Running a foreign architecture desktop with tcg is not enjoyable.
> > > > > > > > >
> > > > > > > > > For testing U-Boot a server image is all it takes.
> > > > > > > >
> > > > > > > > And _all_ of this is why I don't want to add a useful personal script
> > > > > > > > as an additional tool we support. I've seen how much work goes in to the
> > > > > > > > OpenEmbedded runqemu script, we don't have the spare cycles for
> > > > > > > > something like that. Doubly so when ultimately I believe we would be
> > > > > > > > well served by having a document that says (in much more words) to look
> > > > > > > > at u-boot-test-hooks for how to invoke QEMU for a large number of
> > > > > > > > architectures and platforms and to then further leverage general QEMU
> > > > > > > > tips and guides on how to run an OS of your choice with that.
> > > > > > >
> > > > > > > I'm not sure it matters that much. Everyone is going to have their
> > > > > > > preference as to how this script should look, but no one else has
> > > > > > > taken the time to write one...
> > > > > > >
> > > > > > > People are free to send patches to enhance it. But I believe it is
> > > > > > > helpful, e.g. for repeating problems caused by recent lmb patches.
> > > > > > >
> > > > > > > Re the test hooks, I just get tired of looking them up and trying to
> > > > > > > figure out what to do. Every board name and arch is slightly
> > > > > > > different. Just a hassle that I don't need.
> > > > > > >
> > > > > > > We can put it in scripts/contrib if you like.
> > > > > >
> > > > > > It's handy to point people to scripts, yes. I frequently point people at
> > > > > > my wrappers around buildman for example for "how do I find code bloat?"
> > > > > > and similar. But no, I don't think this rises to the level of
> > > > > > "scripts/contrib".
> > > > >
> > > > > Coming back to this question again. I'd be willing to make a new
> > > > > top-level repository for "contributor tooling" and also make that more
> > > > > widely writable. But I also think you're underestimating the level of
> > > > > work required to have a "generic" script here that works on arbitrary
> > > > > developer machines.
> > > >
> > > > Having it in a separate repo seems like too much of a pain, to me.
> > > > When things change in U-Boot I would want to update the script (e.g.
> > > > to add UPL support, booting Ubuntu and the like).
> > >
> > > Being external means it's easier to use for bisect'ing problems and you
> > > still have to handle UPL / no UPL and so on.
> >
> > There are trade-offs, for sure. Sometimes I use buildman from a
> > separate tree when trying to debug something which changes buildman.
> > But I don't think that warrants creating an entirely new tree for
> > scripts.
>
> It would also encourage others. I for example might put the scripts I
> use for having buildman do various tasks there as well.

OK well I think we've reached a dead end here. If you'd like to create
a repo for it, please do. I can then try it out and see how useful it
is for me. I wonder if it should share the u-boot-test-hooks thing to
reduce the number of repos? Rename to u-boot-extra ?

For u-boot-test-hooks at some point you said you don't want to take
patches specific to my setup, so it has become a complete mess on my
side, with different versions for upstream Labgrid, etc. Just some
feedback...

Regards,
Simon
