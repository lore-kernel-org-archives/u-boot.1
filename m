Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D91D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69A489454;
	Tue, 12 Nov 2024 14:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eio3Dt/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376BA8944B; Tue, 12 Nov 2024 14:59:34 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC4389447
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83aae6aba1aso203395339f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419969; x=1732024769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX8RtXQ9ZQ8DiIJ/x/2KgriTRLcUU4dCwjAnIPmXDks=;
 b=eio3Dt/NkBxGSMN3BkxFn2ybTV7Mroc/UeYCiUm91qPTubUEIvw4317QdEWIL7mFXo
 1o6kb4wnWMY7l6Wz7J0QlP35+oigZLxe5rTr+3F3wrGq6+0ratsPjU/97DD99ewgf4Jq
 2KS4IfINUD1n2zKCpziTgn5L/t/IJQRhhyDBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419969; x=1732024769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zX8RtXQ9ZQ8DiIJ/x/2KgriTRLcUU4dCwjAnIPmXDks=;
 b=ogvWCEcwaGypbqhMQFiDgnDx9y0bGbLvbxDPAvn2acZzx0+cmsvBxX4rAE421mgC2h
 D0gUVI7chf16v9atVEguVvY8EDfTny05SPoDLux0zruJiHTIocjyQ3iuz3rZaL+CCrdt
 hiwN1JX9Za4YohyLWpn2gaW2hbMC9Ce7R6ABZgzr11YfxUxuT8cEG4so3W/MpBuumKBo
 3Cp5RItMOxgNIP1ujhsIdgGxS53kAw3YyDxmNXOI4KI4Q0tBE13K3OLBvaJIlv1V75f4
 XeBOUPBxrIBs0PRmAU7XDelVAjrtNkrXpgRipywYyheQnFwzXsnNK9fZNoirzbkbgNHm
 c9QA==
X-Gm-Message-State: AOJu0Yy0DfsFML4C+MyajOQN3NShSwxQyMZnYSUH0Stz1QOyaw02FvBv
 VAUswwDUtSrdncmllfFLCiyFGD/Oyep2G6T1SDBtLBnianzUNAWwt0/pdCz1m6A2G0vb7JcLY9o
 =
X-Google-Smtp-Source: AGHT+IGpnr5R4V2Psr8E1wKyvtsievewnZHIBryKVVj1Yuie7sOS0fGzsMmpOPOY/s5ZH/9bBHHPuQ==
X-Received: by 2002:a05:6602:6c10:b0:83a:b8aa:ec0 with SMTP id
 ca18e2360f4ac-83e033706b3mr1716406739f.13.1731419968887; 
 Tue, 12 Nov 2024 05:59:28 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/18] scripts: Add a script for building and booting QEMU
Date: Tue, 12 Nov 2024 06:58:54 -0700
Message-Id: <20241112135911.630586-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It is handy to be able to quickly build and boot a QEMU image for a
particular architecture and distro.

Add a script for this purpose. It supports only arm and x86 at present.
For distros it only supports Ubuntu. Both 32- and 64-bit builds are
supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                    |   8 ++
 doc/board/emulation/index.rst  |   1 +
 doc/board/emulation/script.rst |  61 ++++++++++++
 scripts/build-qemu.sh          | 175 +++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 doc/board/emulation/script.rst
 create mode 100755 scripts/build-qemu.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 0399ed1dbf6..b45bb96d5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1110,6 +1110,14 @@ F:	tools/efivar.py
 F:	tools/file2include.c
 F:	tools/mkeficapsule.c
 
+EMULATION
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+W:	https://docs.u-boot.org/en/latest/board/emulation/script.html
+F:	configs/qemu_x86*
+F:	doc/board/emulation/script.rst
+F:	scripts/build-qemu.sh
+
 ENVIRONMENT
 M:	Joe Hershberger <joe.hershberger@ni.com>
 S:	Maintained
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..5a2a00ae225 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -8,6 +8,7 @@ Emulation
 
    acpi
    blkdev
+   script
    qemu-arm
    qemu-mips
    qemu-ppce500
diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script.rst
new file mode 100644
index 00000000000..23981e333cb
--- /dev/null
+++ b/doc/board/emulation/script.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Script for building and running
+===============================
+
+You may find the script `scripts/build-qemu.sh` helpful for building and testing
+U-Boot on QEMU.
+
+If uses a environment variables to control how it works:
+
+ubdir
+    base directory for building U-Boot, with each board being in its own
+    subdirectory
+
+imagedir
+    directory containing OS images, containin a subdirectory for each distro
+    type (e.g. ubuntu/
+
+Once configured, you can build and run QEMU for arm64 like this::
+
+    scripts/build-qemu.sh -rsw
+
+No support is currently included for specifying a root disk, so this script can
+only be used to start installers.
+
+Options
+~~~~~~~
+
+Options are available to control the script:
+
+-a <arch>
+    Select architecture (default arm, x86)
+
+-B
+    Don't build; assume a build exists
+
+-k
+    Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
+    emulator
+
+-o <os>
+    Run an Operating System. For now this only supports 'ubuntu'. The name of
+    the OS file must remain unchanged from its standard name on the Ubuntu
+    website.
+
+-r
+    Run QEMU with the image (by default this is not done)
+
+-R
+    Select OS release (e.g. 24.04).
+
+-s
+    Use serial only (no display)
+
+-w
+    Use word version (32-bit). By default, 64-bit is used
+
+.. note::
+
+    Note: For now this is a shell script, but if it expands it might be better
+    as Python, accepting the slower startup.
diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
new file mode 100755
index 00000000000..0ff53593cf9
--- /dev/null
+++ b/scripts/build-qemu.sh
@@ -0,0 +1,175 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Script to build U-Boot suitable for booting with QEMU, possibly running
+# it, possibly with an OS image
+
+# This just an example. It assumes that
+
+# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
+# - your OS images are in ${imagedir}/{distroname}/...
+
+# So far the script supports only ARM and x86.
+
+set -e
+
+usage() {
+	(
+	if [[ -n "$1" ]]; then
+		echo "$1"
+		echo
+	fi
+	echo "Usage: $0 -aBkrsw"
+	echo
+	echo "   -a   - Select architecture (arm, x86)"
+	echo "   -B   - Don't build; assume a build exists"
+	echo "   -k   - Use kvm (kernel-based Virtual Machine)"
+	echo "   -o   - Run Operating System ('ubuntu' only for now)"
+	echo "   -r   - Run QEMU with the image"
+	echo "   -R   - Select OS release (e.g. 24.04)"
+	echo "   -s   - Use serial only (no display)"
+	echo "   -w   - Use word version (32-bit)" ) >&2
+	exit 1
+}
+
+# Directory tree for OS images
+imagedir=${imagedir-/vid/software/linux}
+
+# architecture (arm or x86)
+arch=arm
+
+# 32- or 64-bit build
+bitness=64
+
+# Build U-Boot
+build=yes
+
+# Extra setings
+extra=
+
+# Operating System to boot (ubuntu)
+os=
+
+release=24.04.1
+
+# run the image with QEMU
+run=
+
+# run QEMU without a display (U-Boot must be set to stdout=serial)
+serial=
+
+# Use kvm
+kvm=
+
+# Set ubdir to the build directory where you build U-Boot out-of-tree
+# We avoid in-tree build because it gets confusing trying different builds
+ubdir=${ubdir-/tmp/b}
+
+while getopts "a:Bko:rR:sw" opt; do
+	case "${opt}" in
+	a)
+		arch=$OPTARG
+		;;
+	B)
+		build=
+		;;
+	k)
+		kvm="-enable-kvm"
+		;;
+	o)
+		os=$OPTARG
+
+		# Expand memory and CPUs
+		extra+=" -m 4G -smp 4"
+		;;
+	r)
+		run=1
+		;;
+	R)
+		release=$OPTARG
+		;;
+	s)
+		serial=1
+		;;
+	w)
+		bitness=32
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+# Build U-Boot for the selected board
+build_u_boot() {
+	buildman -w -o $DIR --board $BOARD -I || exit $?
+}
+
+# Run QEMU with U-Boot
+run_qemu() {
+	if [[ -n "${os_image}" ]]; then
+		extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
+	fi
+	if [[ -n "${serial}" ]]; then
+		extra+=" -display none -serial mon:stdio"
+	else
+		extra+=" -serial mon:stdio"
+	fi
+	echo "Running ${qemu} ${extra}"
+	"${qemu}" -bios "$DIR/${BIOS}" \
+		-m 512 \
+		-nic none \
+		${kvm} \
+		${extra}
+}
+
+# Check architecture
+case "${arch}" in
+arm)
+	BOARD="qemu_arm"
+	BIOS="u-boot.bin"
+	qemu=qemu-system-arm
+	extra+=" -machine virt"
+	suffix="arm"
+	if [[ "${bitness}" == "64" ]]; then
+		BOARD="qemu_arm64"
+		qemu=qemu-system-aarch64
+		extra+=" -cpu cortex-a57"
+		suffix="arm64"
+	fi
+	;;
+x86)
+	BOARD="qemu-x86"
+	BIOS="u-boot.rom"
+	qemu=qemu-system-i386
+	suffix="i386"
+	if [[ "${bitness}" == "64" ]]; then
+		BOARD="qemu-x86_64"
+		qemu=qemu-system-x86_64
+		suffix="amd64"
+	fi
+	;;
+*)
+	usage "Unknown architecture '${arch}'"
+esac
+
+# Check OS
+case "${os}" in
+ubuntu)
+	os_image="${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
+	;;
+"")
+	;;
+*)
+	usage "Unknown OS '${os}'"
+esac
+
+DIR=${ubdir}/${BOARD}
+
+if [[ -n "${build}" ]]; then
+	build_u_boot
+fi
+
+if [[ -n "${run}" ]]; then
+	run_qemu
+fi
-- 
2.34.1

