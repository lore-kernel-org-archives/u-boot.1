Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BBD65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECD889348;
	Fri, 15 Nov 2024 15:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C5ZsK+Er";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD46789354; Fri, 15 Nov 2024 15:22:02 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F8788D29
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so2845494a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680520; x=1732285320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+G1nMbpVOqm51f2b/+AKGO9zE/4M9Ad4zR5Zh8EanE=;
 b=C5ZsK+Er/keElmvueo77n1oZ0WYbXP4j/2Rl0bsChVw1aoCi7QTMVIKaFCGjVFEZSz
 pkF05CvipqpByrCSWaFZJuIuwDGNCBtsLiYAJGG4WT11gmacocSrH5gXjMN856nevoCL
 cEDy+gtCcQq8QE7GYEBNVMfpWfGH5TyLO7Gq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680520; x=1732285320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+G1nMbpVOqm51f2b/+AKGO9zE/4M9Ad4zR5Zh8EanE=;
 b=S8pZHhtO7b+IFDfcIFA9AdDQ8qvr2ZcJA2zkBwrLVEVXdKhln27a6oeFZ1fkMdRmfn
 /5cjVdKN+hxq8Ctc7XlFGdioKUODhwHNEAR4qb070FNXohWt78p4cf0j5eAvszqGNV25
 hNTivJ0Y3TfNqzCQtU519CGnX/Hpq48hS6ZKKSet4jfBNtm5hLE+N9nQLyo+JOlDnjBp
 SBQEfdbb25oSboq5BJ/eqdiLZDHvUyiuMINJjsTkoj1OZMCt6ikbKiGLnTc6LZzMkIFk
 84s11YkTvtSsBfcynaumCRpxy3sRDM6tYZMbtfcFGj4IqIobsJCp8lGf42Sm9qLYNa5m
 7Vuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtLzkAsjPcpE2peixK2p7AMTH/O5UGEliSP7ZBIYiiUg8wAK3lHlMctmlrZwr1fqHCLeRYsc=@lists.denx.de
X-Gm-Message-State: AOJu0YyE6kHsUvCRlAjDeYb4X/q1ENwdt1zpe4jRjYeuWNXYrIak1pMg
 U05esn9CgImuSbhqn3/bMzBH90SWwlW1fyzkQ+7wdmqybrEDK57kuGLzoiEi4691+9hED9OBnNO
 YvkU3Zcsz3sdxcICy3YD+I/vvhZs7ZTGPmedZ
X-Google-Smtp-Source: AGHT+IHcxZj4/ufFhSFt6LitUu60DlbA9s2g53BGHRYwBoemYEVkb/UqsXAIeRicc7xF5L9o2SvE2WwjKEs43U8JbMs=
X-Received: by 2002:a17:907:7e82:b0:aa3:1ee3:2ac8 with SMTP id
 a640c23a62f3a-aa48347e79cmr250537966b.25.1731680519812; Fri, 15 Nov 2024
 06:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20241112135911.630586-1-sjg@chromium.org>
 <20241112135911.630586-2-sjg@chromium.org>
 <1529CE41-E674-400F-BB4E-00C27711F523@gmx.de>
 <20241113005447.GF3600562@bill-the-cat>
In-Reply-To: <20241113005447.GF3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:21:47 -0700
Message-ID: <CAFLszTjk6w0zUGOh+Q_gZGETN8Vu2hqvrdYexeSAkPmMOp5uvQ@mail.gmail.com>
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

On Tue, 12 Nov 2024 at 17:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 01:49:30AM +0100, Heinrich Schuchardt wrote:
> > Am 12. November 2024 14:58:54 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >It is handy to be able to quickly build and boot a QEMU image for a
> > >particular architecture and distro.
> > >
> > >Add a script for this purpose. It supports only arm and x86 at present.
> > >For distros it only supports Ubuntu. Both 32- and 64-bit builds are
> > >supported.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > > MAINTAINERS                    |   8 ++
> > > doc/board/emulation/index.rst  |   1 +
> > > doc/board/emulation/script.rst |  61 ++++++++++++
> > > scripts/build-qemu.sh          | 175 +++++++++++++++++++++++++++++++++
> > > 4 files changed, 245 insertions(+)
> > > create mode 100644 doc/board/emulation/script.rst
> > > create mode 100755 scripts/build-qemu.sh
> > >
> > >diff --git a/MAINTAINERS b/MAINTAINERS
> > >index 0399ed1dbf6..b45bb96d5a5 100644
> > >--- a/MAINTAINERS
> > >+++ b/MAINTAINERS
> > >@@ -1110,6 +1110,14 @@ F:    tools/efivar.py
> > > F:  tools/file2include.c
> > > F:  tools/mkeficapsule.c
> > >
> > >+EMULATION
> > >+M:  Simon Glass <sjg@chromium.org>
> > >+S:  Maintained
> > >+W:  https://docs.u-boot.org/en/latest/board/emulation/script.html
> > >+F:  configs/qemu_x86*
> > >+F:  doc/board/emulation/script.rst
> > >+F:  scripts/build-qemu.sh
> >
> > Please, avoid misnomers. This script does not build QEMU.
> >
> > >+
> > > ENVIRONMENT
> > > M:  Joe Hershberger <joe.hershberger@ni.com>
> > > S:  Maintained
> > >diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> > >index f8908166276..5a2a00ae225 100644
> > >--- a/doc/board/emulation/index.rst
> > >+++ b/doc/board/emulation/index.rst
> > >@@ -8,6 +8,7 @@ Emulation
> > >
> > >    acpi
> > >    blkdev
> > >+   script
> > >    qemu-arm
> > >    qemu-mips
> > >    qemu-ppce500
> > >diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script.rst
> >
> > Just another misnomer. This page is not about script.sh.
> >
> > >new file mode 100644
> > >index 00000000000..23981e333cb
> > >--- /dev/null
> > >+++ b/doc/board/emulation/script.rst
> > >@@ -0,0 +1,61 @@
> > >+.. SPDX-License-Identifier: GPL-2.0+
> >
> > This is not a valid SPDX identifier.
> >
> > >+
> > >+Script for building and running
> > >+===============================
> > >+
> > >+You may find the script `scripts/build-qemu.sh` helpful for building and testing
> > >+U-Boot on QEMU.
> > >+
> > >+If uses a environment variables to control how it works:
> > >+
> > >+ubdir
> > >+    base directory for building U-Boot, with each board being in its own
> > >+    subdirectory
> > >+
> > >+imagedir
> > >+    directory containing OS images, containin a subdirectory for each distro
> > >+    type (e.g. ubuntu/
> > >+
> > >+Once configured, you can build and run QEMU for arm64 like this::
> >
> > This downloads the QEMU source and builds it?
> >
> > >+
> > >+    scripts/build-qemu.sh -rsw
> > >+
> > >+No support is currently included for specifying a root disk, so this script can
> > >+only be used to start installers.
> > >+
> > >+Options
> > >+~~~~~~~
> > >+
> > >+Options are available to control the script:
> > >+
> > >+-a <arch>
> > >+    Select architecture (default arm, x86)
> > >+
> > >+-B
> > >+    Don't build; assume a build exists
> > >+
> > >+-k
> > >+    Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
> > >+    emulator
> > >+
> > >+-o <os>
> > >+    Run an Operating System. For now this only supports 'ubuntu'. The name of
> > >+    the OS file must remain unchanged from its standard name on the Ubuntu
> > >+    website.
> >
> > The U-Boot project should remain open to all operating systems. How will this work with OpenBSD?
> >
> > Use the URL of the image as argument.
> >
> > >+
> > >+-r
> > >+    Run QEMU with the image (by default this is not done)
> > >+
> > >+-R
> > >+    Select OS release (e.g. 24.04).
> > >+
> > >+-s
> > >+    Use serial only (no display)
> > >+
> > >+-w
> > >+    Use word version (32-bit). By default, 64-bit is used
> >
> > "word version" is not helpful as explanation.
> >
> > Look at <https://en.m.wikipedia.org/wiki/Word_(computer_architecture)> which says a word is 64 bit on a 64-bit system and 16 bit on a 16-bit system.
> >
> > >+
> > >+.. note::
> > >+
> > >+    Note: For now this is a shell script, but if it expands it might be better
> > >+    as Python, accepting the slower startup.
> > >diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > >new file mode 100755
> > >index 00000000000..0ff53593cf9
> > >--- /dev/null
> > >+++ b/scripts/build-qemu.sh
> > >@@ -0,0 +1,175 @@
> > >+#!/bin/bash
> > >+# SPDX-License-Identifier: GPL-2.0+
> >
> > This is not a valid SPDX identifier.
> >
> > >+#
> > >+# Script to build U-Boot suitable for booting with QEMU, possibly running
> > >+# it, possibly with an OS image
> > >+
> > >+# This just an example. It assumes that
> > >+
> > >+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
> > >+# - your OS images are in ${imagedir}/{distroname}/...
> > >+
> > >+# So far the script supports only ARM and x86.
> >
> > Why support obsolete i386 but not riscv64?
> >
> > >+
> > >+set -e
> > >+
> > >+usage() {
> > >+    (
> > >+    if [[ -n "$1" ]]; then
> > >+            echo "$1"
> > >+            echo
> > >+    fi
> > >+    echo "Usage: $0 -aBkrsw"
> > >+    echo
> > >+    echo "   -a   - Select architecture (arm, x86)"
> > >+    echo "   -B   - Don't build; assume a build exists"
> > >+    echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > >+    echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > >+    echo "   -r   - Run QEMU with the image"
> > >+    echo "   -R   - Select OS release (e.g. 24.04)"
> > >+    echo "   -s   - Use serial only (no display)"
> > >+    echo "   -w   - Use word version (32-bit)" ) >&2
> > >+    exit 1
> > >+}
> > >+
> > >+# Directory tree for OS images
> > >+imagedir=${imagedir-/vid/software/linux}
> > >+
> > >+# architecture (arm or x86)
> > >+arch=arm
> > >+
> > >+# 32- or 64-bit build
> > >+bitness=64
> > >+
> > >+# Build U-Boot
> > >+build=yes
> > >+
> > >+# Extra setings
> > >+extra=
> > >+
> > >+# Operating System to boot (ubuntu)
> > >+os=
> > >+
> > >+release=24.04.1
> > >+
> > >+# run the image with QEMU
> > >+run=
> > >+
> > >+# run QEMU without a display (U-Boot must be set to stdout=serial)
> > >+serial=
> > >+
> > >+# Use kvm
> > >+kvm=
> > >+
> > >+# Set ubdir to the build directory where you build U-Boot out-of-tree
> > >+# We avoid in-tree build because it gets confusing trying different builds
> > >+ubdir=${ubdir-/tmp/b}
> > >+
> > >+while getopts "a:Bko:rR:sw" opt; do
> > >+    case "${opt}" in
> > >+    a)
> > >+            arch=$OPTARG
> > >+            ;;
> > >+    B)
> > >+            build=
> > >+            ;;
> > >+    k)
> > >+            kvm="-enable-kvm"
> > >+            ;;
> > >+    o)
> > >+            os=$OPTARG
> > >+
> > >+            # Expand memory and CPUs
> > >+            extra+=" -m 4G -smp 4"
> > >+            ;;
> > >+    r)
> > >+            run=1
> > >+            ;;
> > >+    R)
> > >+            release=$OPTARG
> > >+            ;;
> > >+    s)
> > >+            serial=1
> > >+            ;;
> > >+    w)
> > >+            bitness=32
> > >+            ;;
> > >+    *)
> > >+            usage
> > >+            ;;
> > >+    esac
> > >+done
> > >+
> > >+# Build U-Boot for the selected board
> > >+build_u_boot() {
> > >+    buildman -w -o $DIR --board $BOARD -I || exit $?
> > >+}
> > >+
> > >+# Run QEMU with U-Boot
> > >+run_qemu() {
> > >+    if [[ -n "${os_image}" ]]; then
> > >+            extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
> > >+    fi
> > >+    if [[ -n "${serial}" ]]; then
> > >+            extra+=" -display none -serial mon:stdio"
> > >+    else
> > >+            extra+=" -serial mon:stdio"
> > >+    fi
> > >+    echo "Running ${qemu} ${extra}"
> > >+    "${qemu}" -bios "$DIR/${BIOS}" \
> > >+            -m 512 \
> >
> > Ubuntu suggests 4 GiB as minimum for a desktop.
> >
> > >+            -nic none \
> >
> > Who wants to run without network?
> > Use the virtio nic.
> >
> > >+            ${kvm} \
> > >+            ${extra}
> > >+}
> > >+
> > >+# Check architecture
> > >+case "${arch}" in
> > >+arm)
> > >+    BOARD="qemu_arm"
> > >+    BIOS="u-boot.bin"
> > >+    qemu=qemu-system-arm
> > >+    extra+=" -machine virt"
> > >+    suffix="arm"
> > >+    if [[ "${bitness}" == "64" ]]; then
> > >+            BOARD="qemu_arm64"
> > >+            qemu=qemu-system-aarch64
> > >+            extra+=" -cpu cortex-a57"
> >
> > That CPU is 12 years old and not all distros are stuck on ARM v8.0. See <https://en.opensuse.org/Arm_architecture_support>.
> >
> > -cpu max works fine with both tcg and kvm.
> >
> > >+            suffix="arm64"
> >
> > >+    fi
> > >+    ;;
> > >+x86)
> > >+    BOARD="qemu-x86"
> > >+    BIOS="u-boot.rom"
> > >+    qemu=qemu-system-i386
> > >+    suffix="i386"
> > >+    if [[ "${bitness}" == "64" ]]; then
> > >+            BOARD="qemu-x86_64"
> > >+            qemu=qemu-system-x86_64
> > >+            suffix="amd64"
> > >+    fi
> > >+    ;;
> > >+*)
> > >+    usage "Unknown architecture '${arch}'"
> > >+esac
> > >+
> > >+# Check OS
> > >+case "${os}" in
> > >+ubuntu)
> > >+    os_image="${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
> >
> > There is no ARM 32-bit Ubuntu desktop. And for i386 there is no image in 24.04.1.
> >
> > Running a foreign architecture desktop with tcg is not enjoyable.
> >
> > For testing U-Boot a server image is all it takes.
>
> And _all_ of this is why I don't want to add a useful personal script
> as an additional tool we support. I've seen how much work goes in to the
> OpenEmbedded runqemu script, we don't have the spare cycles for
> something like that. Doubly so when ultimately I believe we would be
> well served by having a document that says (in much more words) to look
> at u-boot-test-hooks for how to invoke QEMU for a large number of
> architectures and platforms and to then further leverage general QEMU
> tips and guides on how to run an OS of your choice with that.

I'm not sure it matters that much. Everyone is going to have their
preference as to how this script should look, but no one else has
taken the time to write one...

People are free to send patches to enhance it. But I believe it is
helpful, e.g. for repeating problems caused by recent lmb patches.

Re the test hooks, I just get tired of looking them up and trying to
figure out what to do. Every board name and arch is slightly
different. Just a hassle that I don't need.

We can put it in scripts/contrib if you like.

Regards,
Simon
