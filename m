Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59E4C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136D482BA1;
	Thu, 17 Apr 2025 20:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F8lVB96+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432CB82E20; Thu, 17 Apr 2025 20:16:44 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33E881E14
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-855bd88ee2cso29311839f.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913799; x=1745518599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrAP+FmJNbcDvrJDAta/XAMk/Ppk3fyF1yM7Y6IfZaI=;
 b=F8lVB96+O4Ex/MJT4x35V2J9/oNqqhTcXVU5QxWNyB1RBj6IwI80UUWQQkf28ofkbx
 OSGf2SakizNshg/nQI47zT+GDS+E1XLetXDusql5pZ81HMr2B0Psuka/6/UjsomEw3IP
 W88jFhHiq4GTVQVmwELbhKaAdlsHEktwmRs6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913799; x=1745518599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrAP+FmJNbcDvrJDAta/XAMk/Ppk3fyF1yM7Y6IfZaI=;
 b=Z9HD2tIMqcXZVYwupATElmJP44MmAnRILUWyYySN6/ZMqNgDTTHThQRujGTwtkRul+
 bXIdYFaaluNgM+5a/MNpz4fYJg2d6c0RV39qnBP3WotyMdVuW/I75I0ThfZMRX1mn18t
 w5rEFfiS42ntfMe8OLe6Eh16EoZQyuKZv+N/eihHbWFAOTKk6CO5MRaAqWiDcSxA0lG3
 cigVFXGtaa2IvLLAOgBrknIM4XgYwru7lmtbvF0c1axE1rPu6BMF5XLO4yngAppEXnQY
 eDSSmrhBSQJexNb7DzduXt1wyMh+ZK/oY0ztXEJCvldBQ5sIrNH9wxyms9jVEBE19fo+
 KkPQ==
X-Gm-Message-State: AOJu0Yw7vVeWMpppbySBOQ6T/g37wfSYPdN0SpjVx/b0h8jx6DadP1Nd
 V15ed3b8bMNpcfos+Fm5tFBL4I5YEhWyir0lraJIZezZL5yvt+1yhmHyiw3ogWEeEd0LwzazDho
 =
X-Gm-Gg: ASbGncvAduf2JHtT/pKArdQi8m0FwHn4XAxAhiRZIqJMB61gU/rzl9uA+Q8+2q90XL5
 WzOhY73p9pu3hbmHmvY8Pvv1JWWialNNa+/eVdx04Mnw2XVmtabzHFV4ugHtWyNzbGl4oGw0vXP
 9eD1IZS5rr/67jlgaWgItPnimLnPsdM5DgHCuC/5B2/lidiRt+besZTJlon5gLYa4Hu0KGMZ+E5
 Tt6mOXarem4KgrmBHzOqIAb+ZSUGU8n4BGWt2kYeNaTBJHXLMHoiLJJWOudTEg+IqKkvQ5SNBFv
 aZrdSTCzrRLhnQOtgYENaIYR1XjXodMlJwaSDotSXApQ5/qSMWPo4N7LQKgr2Z2vn9Qclk0D4wJ
 gAQ==
X-Google-Smtp-Source: AGHT+IFSTJq7spVRDl+aF4hDkeOtOcbwsIWD3TxoInb3jYRIl5Csp0XftPX2BcVEPVm3iDH3hfxO5g==
X-Received: by 2002:a05:6e02:216e:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d88ee75e56mr755025ab.15.1744913799214; 
 Thu, 17 Apr 2025 11:16:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/22] RFC: scripts: Add a script for running QEMU
Date: Thu, 17 Apr 2025 12:15:43 -0600
Message-ID: <20250417181613.1355024-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

This is present in my tree. Provide it as a patch to simplify testing
this series with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/build-qemu.sh | 222 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100755 scripts/build-qemu.sh

diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
new file mode 100755
index 00000000000..678116d1cc7
--- /dev/null
+++ b/scripts/build-qemu.sh
@@ -0,0 +1,222 @@
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
+	echo "   -a <arch> - Select architecture (arm, x86)"
+	echo "   -B        - Don't build; assume a build exists"
+	echo "   -e        - Run UEFI Self-Certification Test (SCT)"
+	echo "   -k        - Use kvm (kernel-based Virtual Machine)"
+	echo "   -o <name> - Run Operating System ('ubuntu' only for now)"
+	echo "   -r        - Run QEMU with the image"
+	echo "   -R <os>   - Select OS release (e.g. 24.04)"
+	echo "   -s        - Use serial only (no display)"
+	echo "   -S <seq>  - Select SCT sequence-file"
+	echo "   -x        - Run SPL (xPL) image"
+	echo "   -w        - Use word version (32-bit)" ) >&2
+	exit 1
+}
+
+# Directory tree for OS images
+imagedir=${imagedir-/vid/software/linux}
+
+# Directory for UEFI Self-Certification Test (SCT)
+sctdir=${sctdir-/vid/software/devel/uefi/sct}
+
+# Mount point for use when writing to disk images
+mnt=${mnt-/mnt}
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
+xpl=
+
+# Set ubdir to the build directory where you build U-Boot out-of-tree
+# We avoid in-tree build because it gets confusing trying different builds
+ubdir=${ubdir-/tmp/b}
+
+while getopts "a:Beko:rR:sS:wx" opt; do
+	case "${opt}" in
+	a)
+		arch=$OPTARG
+		;;
+	B)
+		build=
+		;;
+	e)
+		extra+=" -m 4G -smp 4"
+		extra+=" -display none"
+		extra+=" -device virtio-gpu-pci"
+		extra+=" -device qemu-xhci"
+		extra+=" -device usb-kbd"
+		extra+=" -drive file=${sctdir}/sct.img,format=raw,if=none,id=vda"
+		extra+=" -device virtio-blk-device,drive=vda,bootindex=1"
+		extra+=" -device virtio-net-device,netdev=net0"
+		extra+=" -netdev user,id=net0"
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
+	S)
+		seq=$OPTARG
+		;;
+	w)
+		bitness=32
+		;;
+	x)
+		xpl=1
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
+# Write the SCT test-sequence file into the SCT image
+update_sct_seq() {
+	if [[ -z "${seq}" ]]; then
+		return
+	fi
+	LOOP=$(sudo losetup --show -f -P "${sctdir}/sct.img")
+	PART="${LOOP}p1"
+	sudo mount -o loop ${PART} ${mnt} -o uid=$(id -u),gid=$(id -g)
+	cp "${seq}" "${mnt}/."
+	sudo umount ${mnt}
+	sudo losetup -d ${LOOP}
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
+	if [ -n "${xpl}" ]; then
+		BIOS="image.bin"
+		BOARD="qemu_arm_spl"
+	else
+		BOARD="qemu_arm"
+		BIOS="u-boot.bin"
+	fi
+	qemu=qemu-system-arm
+	extra+=" -machine virt -accel tcg"
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
+	update_sct_seq
+fi
+
+if [[ -n "${run}" ]]; then
+	run_qemu
+fi
-- 
2.43.0

