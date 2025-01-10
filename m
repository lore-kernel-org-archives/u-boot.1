Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27560E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 20:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDD4800D0;
	Fri, 10 Jan 2025 21:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hstyQMiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890D4801F5; Fri, 10 Jan 2025 21:46:36 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D35080050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 21:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8edad9932so16260176d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736541992; x=1737146792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YTfj5V+8aay/R2I+fG31196URc9yYM1kroNXjKaf3yQ=;
 b=hstyQMiFJRVsyts8I9SZ1LC9ezQNOYT9uyfF9Ocd5X+yxCDVWVNqSU9avworQKroRW
 rn2dLGW1ndBJ+os7yyQ2dgEYc8TCR/yeE3VXjgM66+ss7uxuOPOiGB041WuXtSB5wPu+
 GQ7fzfWEAIqt1G+WiL7EXGbFjYdbkxB9+hbDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541992; x=1737146792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTfj5V+8aay/R2I+fG31196URc9yYM1kroNXjKaf3yQ=;
 b=lANknXbO4gPd2Gnz4a7kjc3XcUJ9ZmhAd6n8gPZykvgwu2PdQOXSA+KJl8lFnh758k
 qOiqDxG83dvAatdEHy1ibhcLIwDPMMNOhSFWo8ldEOV4IFEW4zIl1QHYxS8+XlVP8l2Q
 Je9ktS9/qzqVjySPpqG1fQ8HSbJn/6eIIcODGyluAgcJzpGfrek44FOXQ5Z3ESnbhJNR
 EufctpWVjoeuqKCNmlW3LsEXGvqz4V+zLbgywAhT7NmIPTFKRuGhHMBMXJWiOJ6CWPWK
 vaV/zVsoHyqmh6zO0XAk+KUWewxjqlnZlViYz7HWLjJjjc9iynifxs57agptCucx8H1u
 DT6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiO0TdWtI5Ge91siKmdCIm01Oh1hXtXggpaKqoBwqo1ucV4gEn7hOGO3SFWmSo4Y1WYmxprec=@lists.denx.de
X-Gm-Message-State: AOJu0Yys9N0fmhFQ0S7vzeQEKLWVaKzJXUAnvaOcgs8epIhTcjBiPzKu
 EJl8+lZhjulimMipE+jkxMyIWYuCwxJvH7OpzHNIm9TxF0ETWbRyMf2qKAV+Mss=
X-Gm-Gg: ASbGnctA5ay5x8BsrrEgeEpraezmpPp52VLm3GfTbCjELhZazI5w0M3SwXsdaSj7w6X
 wwvjxhuUuNYYoRwBkG2CbjLk+/1EStSVfKzEPNm+foS1x+f3hIxhrDW+bSeYLSZG4/o88P+1f3p
 xNTQZeWYYTqKk+sqre4V2Lm02m3X9YXODv818cIxwBW0WDzE4UfCWiwv9JKJaj8w421YJzGrrL5
 ZOibrE0a5pDdkpoaayaAu5SeGgA+hZaOaAmeQSJ4LYsLtbDz4twhP8=
X-Google-Smtp-Source: AGHT+IGAECrAycbXinvPIPzzUoFOxSofQ2WriBWQed3vmpPDo3DO60ee+HLNcYi3hBe/k6i985Zb5Q==
X-Received: by 2002:a05:6214:501a:b0:6dd:84b7:dd86 with SMTP id
 6a1803df08f44-6df9b282876mr218209166d6.36.1736541992059; 
 Fri, 10 Jan 2025 12:46:32 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad880c97sm12999816d6.36.2025.01.10.12.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 12:46:31 -0800 (PST)
Date: Fri, 10 Jan 2025 14:46:27 -0600
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
Message-ID: <20250110204627.GN3476@bill-the-cat>
References: <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
 <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
 <20241115151403.GW3600562@bill-the-cat>
 <20250106145517.GY3476@bill-the-cat>
 <CAFLszTjJvA7=QdNTza48O45e85yGO=XGr6EEkVVd=xYrrkH-GA@mail.gmail.com>
 <20250109145620.GS3476@bill-the-cat>
 <CAFLszTiyUyFyp57VuAXV1SS67tSWVmxyrs8Oqs-Jd27UAwDz2w@mail.gmail.com>
 <20250110160109.GH3476@bill-the-cat>
 <CAFLszThPDT3WzG169D+KaGKOT0vo4GJc7T4SoCZ6R+VbLed_Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ldRQe37aDuyyiVfM"
Content-Disposition: inline
In-Reply-To: <CAFLszThPDT3WzG169D+KaGKOT0vo4GJc7T4SoCZ6R+VbLed_Xw@mail.gmail.com>
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


--ldRQe37aDuyyiVfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 12:50:20PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Jan 2025 at 09:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 10, 2025 at 06:39:19AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Jan 2025 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 05:36:34AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 6 Jan 2025 at 07:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 15, 2024 at 09:14:03AM -0600, Tom Rini wrote:
> > > > > > > On Fri, Nov 15, 2024 at 07:21:47AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuch=
ardt wrote:
> > > > > > > > > > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <=
sjg@chromium.org>:
> > > > > > > > > > >It is handy to be able to quickly build and boot a QEM=
U image for a
> > > > > > > > > > >particular architecture and distro.
> > > > > > > > > > >
> > > > > > > > > > >Add a script for this purpose. It supports only arm an=
d x86 at present.
> > > > > > > > > > >For distros it only supports Ubuntu. Both 32- and 64-b=
it builds are
> > > > > > > > > > >supported.
> > > > > > > > > > >
> > > > > > > > > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > >---
> > > > > > > > > > >
> > > > > > > > > > > MAINTAINERS                    |   8 ++
> > > > > > > > > > > doc/board/emulation/index.rst  |   1 +
> > > > > > > > > > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > > > > > > > > > scripts/build-qemu.sh          | 175 ++++++++++++++++=
+++++++++++++++++
> > > > > > > > > > > 4 files changed, 245 insertions(+)
> > > > > > > > > > > create mode 100644 doc/board/emulation/script.rst
> > > > > > > > > > > create mode 100755 scripts/build-qemu.sh
> > > > > > > > > > >
> > > > > > > > > > >diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > > > >index 0399ed1dbf6..b45bb96d5a5 100644
> > > > > > > > > > >--- a/MAINTAINERS
> > > > > > > > > > >+++ b/MAINTAINERS
> > > > > > > > > > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > > > > > > > > > F:  tools/file2include.c
> > > > > > > > > > > F:  tools/mkeficapsule.c
> > > > > > > > > > >
> > > > > > > > > > >+EMULATION
> > > > > > > > > > >+M:  Simon Glass <sjg@chromium.org>
> > > > > > > > > > >+S:  Maintained
> > > > > > > > > > >+W:  https://docs.u-boot.org/en/latest/board/emulation=
/script.html
> > > > > > > > > > >+F:  configs/qemu_x86*
> > > > > > > > > > >+F:  doc/board/emulation/script.rst
> > > > > > > > > > >+F:  scripts/build-qemu.sh
> > > > > > > > > >
> > > > > > > > > > Please, avoid misnomers. This script does not build QEM=
U.
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > > ENVIRONMENT
> > > > > > > > > > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > > > > > > > > > S:  Maintained
> > > > > > > > > > >diff --git a/doc/board/emulation/index.rst b/doc/board=
/emulation/index.rst
> > > > > > > > > > >index f8908166276..5a2a00ae225 100644
> > > > > > > > > > >--- a/doc/board/emulation/index.rst
> > > > > > > > > > >+++ b/doc/board/emulation/index.rst
> > > > > > > > > > >@@ -8,6 +8,7 @@ Emulation
> > > > > > > > > > >
> > > > > > > > > > >    acpi
> > > > > > > > > > >    blkdev
> > > > > > > > > > >+   script
> > > > > > > > > > >    qemu-arm
> > > > > > > > > > >    qemu-mips
> > > > > > > > > > >    qemu-ppce500
> > > > > > > > > > >diff --git a/doc/board/emulation/script.rst b/doc/boar=
d/emulation/script.rst
> > > > > > > > > >
> > > > > > > > > > Just another misnomer. This page is not about script.sh.
> > > > > > > > > >
> > > > > > > > > > >new file mode 100644
> > > > > > > > > > >index 00000000000..23981e333cb
> > > > > > > > > > >--- /dev/null
> > > > > > > > > > >+++ b/doc/board/emulation/script.rst
> > > > > > > > > > >@@ -0,0 +1,61 @@
> > > > > > > > > > >+.. SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > >
> > > > > > > > > > This is not a valid SPDX identifier.
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > >+Script for building and running
> > > > > > > > > > >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > >+
> > > > > > > > > > >+You may find the script `scripts/build-qemu.sh` helpf=
ul for building and testing
> > > > > > > > > > >+U-Boot on QEMU.
> > > > > > > > > > >+
> > > > > > > > > > >+If uses a environment variables to control how it wor=
ks:
> > > > > > > > > > >+
> > > > > > > > > > >+ubdir
> > > > > > > > > > >+    base directory for building U-Boot, with each boa=
rd being in its own
> > > > > > > > > > >+    subdirectory
> > > > > > > > > > >+
> > > > > > > > > > >+imagedir
> > > > > > > > > > >+    directory containing OS images, containin a subdi=
rectory for each distro
> > > > > > > > > > >+    type (e.g. ubuntu/
> > > > > > > > > > >+
> > > > > > > > > > >+Once configured, you can build and run QEMU for arm64=
 like this::
> > > > > > > > > >
> > > > > > > > > > This downloads the QEMU source and builds it?
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > >+    scripts/build-qemu.sh -rsw
> > > > > > > > > > >+
> > > > > > > > > > >+No support is currently included for specifying a roo=
t disk, so this script can
> > > > > > > > > > >+only be used to start installers.
> > > > > > > > > > >+
> > > > > > > > > > >+Options
> > > > > > > > > > >+~~~~~~~
> > > > > > > > > > >+
> > > > > > > > > > >+Options are available to control the script:
> > > > > > > > > > >+
> > > > > > > > > > >+-a <arch>
> > > > > > > > > > >+    Select architecture (default arm, x86)
> > > > > > > > > > >+
> > > > > > > > > > >+-B
> > > > > > > > > > >+    Don't build; assume a build exists
> > > > > > > > > > >+
> > > > > > > > > > >+-k
> > > > > > > > > > >+    Use kvm - kernel-based Virtual Machine. By defaul=
t QEMU uses its own
> > > > > > > > > > >+    emulator
> > > > > > > > > > >+
> > > > > > > > > > >+-o <os>
> > > > > > > > > > >+    Run an Operating System. For now this only suppor=
ts 'ubuntu'. The name of
> > > > > > > > > > >+    the OS file must remain unchanged from its standa=
rd name on the Ubuntu
> > > > > > > > > > >+    website.
> > > > > > > > > >
> > > > > > > > > > The U-Boot project should remain open to all operating =
systems. How will this work with OpenBSD?
> > > > > > > > > >
> > > > > > > > > > Use the URL of the image as argument.
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > >+-r
> > > > > > > > > > >+    Run QEMU with the image (by default this is not d=
one)
> > > > > > > > > > >+
> > > > > > > > > > >+-R
> > > > > > > > > > >+    Select OS release (e.g. 24.04).
> > > > > > > > > > >+
> > > > > > > > > > >+-s
> > > > > > > > > > >+    Use serial only (no display)
> > > > > > > > > > >+
> > > > > > > > > > >+-w
> > > > > > > > > > >+    Use word version (32-bit). By default, 64-bit is =
used
> > > > > > > > > >
> > > > > > > > > > "word version" is not helpful as explanation.
> > > > > > > > > >
> > > > > > > > > > Look at <https://en.m.wikipedia.org/wiki/Word_(computer=
_architecture)> which says a word is 64 bit on a 64-bit system and 16 bit o=
n a 16-bit system.
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > >+.. note::
> > > > > > > > > > >+
> > > > > > > > > > >+    Note: For now this is a shell script, but if it e=
xpands it might be better
> > > > > > > > > > >+    as Python, accepting the slower startup.
> > > > > > > > > > >diff --git a/scripts/build-qemu.sh b/scripts/build-qem=
u.sh
> > > > > > > > > > >new file mode 100755
> > > > > > > > > > >index 00000000000..0ff53593cf9
> > > > > > > > > > >--- /dev/null
> > > > > > > > > > >+++ b/scripts/build-qemu.sh
> > > > > > > > > > >@@ -0,0 +1,175 @@
> > > > > > > > > > >+#!/bin/bash
> > > > > > > > > > >+# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > >
> > > > > > > > > > This is not a valid SPDX identifier.
> > > > > > > > > >
> > > > > > > > > > >+#
> > > > > > > > > > >+# Script to build U-Boot suitable for booting with QE=
MU, possibly running
> > > > > > > > > > >+# it, possibly with an OS image
> > > > > > > > > > >+
> > > > > > > > > > >+# This just an example. It assumes that
> > > > > > > > > > >+
> > > > > > > > > > >+# - you build U-Boot in ${ubdir}/<name> where <name> =
is the U-Boot board config
> > > > > > > > > > >+# - your OS images are in ${imagedir}/{distroname}/...
> > > > > > > > > > >+
> > > > > > > > > > >+# So far the script supports only ARM and x86.
> > > > > > > > > >
> > > > > > > > > > Why support obsolete i386 but not riscv64?
> > > > > > > > > >
> > > > > > > > > > >+
> > > > > > > > > > >+set -e
> > > > > > > > > > >+
> > > > > > > > > > >+usage() {
> > > > > > > > > > >+    (
> > > > > > > > > > >+    if [[ -n "$1" ]]; then
> > > > > > > > > > >+            echo "$1"
> > > > > > > > > > >+            echo
> > > > > > > > > > >+    fi
> > > > > > > > > > >+    echo "Usage: $0 -aBkrsw"
> > > > > > > > > > >+    echo
> > > > > > > > > > >+    echo "   -a   - Select architecture (arm, x86)"
> > > > > > > > > > >+    echo "   -B   - Don't build; assume a build exist=
s"
> > > > > > > > > > >+    echo "   -k   - Use kvm (kernel-based Virtual Mac=
hine)"
> > > > > > > > > > >+    echo "   -o   - Run Operating System ('ubuntu' on=
ly for now)"
> > > > > > > > > > >+    echo "   -r   - Run QEMU with the image"
> > > > > > > > > > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > > > > > > > > > >+    echo "   -s   - Use serial only (no display)"
> > > > > > > > > > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > > > > > > > > > >+    exit 1
> > > > > > > > > > >+}
> > > > > > > > > > >+
> > > > > > > > > > >+# Directory tree for OS images
> > > > > > > > > > >+imagedir=3D${imagedir-/vid/software/linux}
> > > > > > > > > > >+
> > > > > > > > > > >+# architecture (arm or x86)
> > > > > > > > > > >+arch=3Darm
> > > > > > > > > > >+
> > > > > > > > > > >+# 32- or 64-bit build
> > > > > > > > > > >+bitness=3D64
> > > > > > > > > > >+
> > > > > > > > > > >+# Build U-Boot
> > > > > > > > > > >+build=3Dyes
> > > > > > > > > > >+
> > > > > > > > > > >+# Extra setings
> > > > > > > > > > >+extra=3D
> > > > > > > > > > >+
> > > > > > > > > > >+# Operating System to boot (ubuntu)
> > > > > > > > > > >+os=3D
> > > > > > > > > > >+
> > > > > > > > > > >+release=3D24.04.1
> > > > > > > > > > >+
> > > > > > > > > > >+# run the image with QEMU
> > > > > > > > > > >+run=3D
> > > > > > > > > > >+
> > > > > > > > > > >+# run QEMU without a display (U-Boot must be set to s=
tdout=3Dserial)
> > > > > > > > > > >+serial=3D
> > > > > > > > > > >+
> > > > > > > > > > >+# Use kvm
> > > > > > > > > > >+kvm=3D
> > > > > > > > > > >+
> > > > > > > > > > >+# Set ubdir to the build directory where you build U-=
Boot out-of-tree
> > > > > > > > > > >+# We avoid in-tree build because it gets confusing tr=
ying different builds
> > > > > > > > > > >+ubdir=3D${ubdir-/tmp/b}
> > > > > > > > > > >+
> > > > > > > > > > >+while getopts "a:Bko:rR:sw" opt; do
> > > > > > > > > > >+    case "${opt}" in
> > > > > > > > > > >+    a)
> > > > > > > > > > >+            arch=3D$OPTARG
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    B)
> > > > > > > > > > >+            build=3D
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    k)
> > > > > > > > > > >+            kvm=3D"-enable-kvm"
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    o)
> > > > > > > > > > >+            os=3D$OPTARG
> > > > > > > > > > >+
> > > > > > > > > > >+            # Expand memory and CPUs
> > > > > > > > > > >+            extra+=3D" -m 4G -smp 4"
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    r)
> > > > > > > > > > >+            run=3D1
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    R)
> > > > > > > > > > >+            release=3D$OPTARG
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    s)
> > > > > > > > > > >+            serial=3D1
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    w)
> > > > > > > > > > >+            bitness=3D32
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    *)
> > > > > > > > > > >+            usage
> > > > > > > > > > >+            ;;
> > > > > > > > > > >+    esac
> > > > > > > > > > >+done
> > > > > > > > > > >+
> > > > > > > > > > >+# Build U-Boot for the selected board
> > > > > > > > > > >+build_u_boot() {
> > > > > > > > > > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > > > > > > > > > >+}
> > > > > > > > > > >+
> > > > > > > > > > >+# Run QEMU with U-Boot
> > > > > > > > > > >+run_qemu() {
> > > > > > > > > > >+    if [[ -n "${os_image}" ]]; then
> > > > > > > > > > >+            extra+=3D" -drive if=3Dvirtio,file=3D${os=
_image},format=3Draw,id=3Dhd0"
> > > > > > > > > > >+    fi
> > > > > > > > > > >+    if [[ -n "${serial}" ]]; then
> > > > > > > > > > >+            extra+=3D" -display none -serial mon:stdi=
o"
> > > > > > > > > > >+    else
> > > > > > > > > > >+            extra+=3D" -serial mon:stdio"
> > > > > > > > > > >+    fi
> > > > > > > > > > >+    echo "Running ${qemu} ${extra}"
> > > > > > > > > > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > > > > > > > > > >+            -m 512 \
> > > > > > > > > >
> > > > > > > > > > Ubuntu suggests 4 GiB as minimum for a desktop.
> > > > > > > > > >
> > > > > > > > > > >+            -nic none \
> > > > > > > > > >
> > > > > > > > > > Who wants to run without network?
> > > > > > > > > > Use the virtio nic.
> > > > > > > > > >
> > > > > > > > > > >+            ${kvm} \
> > > > > > > > > > >+            ${extra}
> > > > > > > > > > >+}
> > > > > > > > > > >+
> > > > > > > > > > >+# Check architecture
> > > > > > > > > > >+case "${arch}" in
> > > > > > > > > > >+arm)
> > > > > > > > > > >+    BOARD=3D"qemu_arm"
> > > > > > > > > > >+    BIOS=3D"u-boot.bin"
> > > > > > > > > > >+    qemu=3Dqemu-system-arm
> > > > > > > > > > >+    extra+=3D" -machine virt"
> > > > > > > > > > >+    suffix=3D"arm"
> > > > > > > > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > > > > > > > >+            BOARD=3D"qemu_arm64"
> > > > > > > > > > >+            qemu=3Dqemu-system-aarch64
> > > > > > > > > > >+            extra+=3D" -cpu cortex-a57"
> > > > > > > > > >
> > > > > > > > > > That CPU is 12 years old and not all distros are stuck =
on ARM v8.0. See <https://en.opensuse.org/Arm_architecture_support>.
> > > > > > > > > >
> > > > > > > > > > -cpu max works fine with both tcg and kvm.
> > > > > > > > > >
> > > > > > > > > > >+            suffix=3D"arm64"
> > > > > > > > > >
> > > > > > > > > > >+    fi
> > > > > > > > > > >+    ;;
> > > > > > > > > > >+x86)
> > > > > > > > > > >+    BOARD=3D"qemu-x86"
> > > > > > > > > > >+    BIOS=3D"u-boot.rom"
> > > > > > > > > > >+    qemu=3Dqemu-system-i386
> > > > > > > > > > >+    suffix=3D"i386"
> > > > > > > > > > >+    if [[ "${bitness}" =3D=3D "64" ]]; then
> > > > > > > > > > >+            BOARD=3D"qemu-x86_64"
> > > > > > > > > > >+            qemu=3Dqemu-system-x86_64
> > > > > > > > > > >+            suffix=3D"amd64"
> > > > > > > > > > >+    fi
> > > > > > > > > > >+    ;;
> > > > > > > > > > >+*)
> > > > > > > > > > >+    usage "Unknown architecture '${arch}'"
> > > > > > > > > > >+esac
> > > > > > > > > > >+
> > > > > > > > > > >+# Check OS
> > > > > > > > > > >+case "${os}" in
> > > > > > > > > > >+ubuntu)
> > > > > > > > > > >+    os_image=3D"${imagedir}/${os}/${os}-${release}-de=
sktop-${suffix}.iso"
> > > > > > > > > >
> > > > > > > > > > There is no ARM 32-bit Ubuntu desktop. And for i386 the=
re is no image in 24.04.1.
> > > > > > > > > >
> > > > > > > > > > Running a foreign architecture desktop with tcg is not =
enjoyable.
> > > > > > > > > >
> > > > > > > > > > For testing U-Boot a server image is all it takes.
> > > > > > > > >
> > > > > > > > > And _all_ of this is why I don't want to add a useful per=
sonal script
> > > > > > > > > as an additional tool we support. I've seen how much work=
 goes in to the
> > > > > > > > > OpenEmbedded runqemu script, we don't have the spare cycl=
es for
> > > > > > > > > something like that. Doubly so when ultimately I believe =
we would be
> > > > > > > > > well served by having a document that says (in much more =
words) to look
> > > > > > > > > at u-boot-test-hooks for how to invoke QEMU for a large n=
umber of
> > > > > > > > > architectures and platforms and to then further leverage =
general QEMU
> > > > > > > > > tips and guides on how to run an OS of your choice with t=
hat.
> > > > > > > >
> > > > > > > > I'm not sure it matters that much. Everyone is going to hav=
e their
> > > > > > > > preference as to how this script should look, but no one el=
se has
> > > > > > > > taken the time to write one...
> > > > > > > >
> > > > > > > > People are free to send patches to enhance it. But I believ=
e it is
> > > > > > > > helpful, e.g. for repeating problems caused by recent lmb p=
atches.
> > > > > > > >
> > > > > > > > Re the test hooks, I just get tired of looking them up and =
trying to
> > > > > > > > figure out what to do. Every board name and arch is slightly
> > > > > > > > different. Just a hassle that I don't need.
> > > > > > > >
> > > > > > > > We can put it in scripts/contrib if you like.
> > > > > > >
> > > > > > > It's handy to point people to scripts, yes. I frequently poin=
t people at
> > > > > > > my wrappers around buildman for example for "how do I find co=
de bloat?"
> > > > > > > and similar. But no, I don't think this rises to the level of
> > > > > > > "scripts/contrib".
> > > > > >
> > > > > > Coming back to this question again. I'd be willing to make a new
> > > > > > top-level repository for "contributor tooling" and also make th=
at more
> > > > > > widely writable. But I also think you're underestimating the le=
vel of
> > > > > > work required to have a "generic" script here that works on arb=
itrary
> > > > > > developer machines.
> > > > >
> > > > > Having it in a separate repo seems like too much of a pain, to me.
> > > > > When things change in U-Boot I would want to update the script (e=
=2Eg.
> > > > > to add UPL support, booting Ubuntu and the like).
> > > >
> > > > Being external means it's easier to use for bisect'ing problems and=
 you
> > > > still have to handle UPL / no UPL and so on.
> > >
> > > There are trade-offs, for sure. Sometimes I use buildman from a
> > > separate tree when trying to debug something which changes buildman.
> > > But I don't think that warrants creating an entirely new tree for
> > > scripts.
> >
> > It would also encourage others. I for example might put the scripts I
> > use for having buildman do various tasks there as well.
>=20
> OK well I think we've reached a dead end here. If you'd like to create
> a repo for it, please do. I can then try it out and see how useful it
> is for me. I wonder if it should share the u-boot-test-hooks thing to
> reduce the number of repos? Rename to u-boot-extra ?

I've created a "u-boot-extras" repository at the top level, added you
as well to the maintainers (aside, any other custodians that want to
contribute scripts/etc here are welcome to DM me for write access), and
added "u-boot-size-test.sh" to "contrib/trini". Please feel free to
start populating "contrib/sjg" with any/all scripts you feel are ready
for public viewing / use.

> For u-boot-test-hooks at some point you said you don't want to take
> patches specific to my setup, so it has become a complete mess on my
> side, with different versions for upstream Labgrid, etc. Just some
> feedback...

FWIW, your labgrid is in u-boot-test-hooks as well and has been for a
while. I had to rebase my local branches on top of that, but it was
mostly progmatic sed'ing. I'm still less clear on the value of putting
all of the lab details in a public repository instead of just example
levels, but I'm open to changing my mind there if that will really help.

--=20
Tom

--ldRQe37aDuyyiVfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBhxsACgkQFHw5/5Y0
tywEhgwAqhP77iwyNTUFnpxnRt15jtPDyZvkaV4EiMPRHGgWVvwBJgjQu9UY4kk1
/GYNgtqA51Ru94BnI7tL0X1rhi3fDinDT2SRxzXyP+CtCoYfefDLlqrEGEeMPhJF
sLqXOHVxfIIn4qrqcEL6uKvraWygbfc9s4TdGHOentpwL860I/6s7HnYZdPKixwb
x11hJEM0GLzAOywPPEhaePtZyNX9oKxKppqg9LuzBUEoFxEtytKAmQzkeyrLKdjX
3nEqHxWYD0fbR0hG9vrHTAy2VbTRDh+4U5LfSisaKTHgTy05I2/j0qfpX0jM0TFb
0IDY4q2qSix11vUhwWopVIOBOR3AnNseS1a0txZ0Rm1bQt98N5Fz+F3cQm+2UGf2
09qhVU7Ps4JY3PlvJh6hc37UKqSCOymMM3eNTmfMPSutNDcyXsb7T6ttpx18o4N2
tDtNJ0RrrDU4Axa/DsPyNmB/LFtqAFOrNWNJTgS5J7bIMuJ//LAyUpD1jUp+GcTZ
3rRlukn2
=o3aU
-----END PGP SIGNATURE-----

--ldRQe37aDuyyiVfM--
