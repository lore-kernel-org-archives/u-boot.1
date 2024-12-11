Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD3E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 00:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B828007F;
	Wed, 11 Dec 2024 01:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cVsVkXNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F147580081; Wed, 11 Dec 2024 01:46:48 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD108007D
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 01:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844bfd40df6so40542939f.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733878005; x=1734482805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JWAMh6Ba62cJAu5Du+Zua/wiX2PZn3x0Q9c2K65iDcE=;
 b=cVsVkXNYGfiXiFZo7rPlaVu40ZfeJ2e+Eljzw9oziY39006UWUYo8X5TXYuSNZsTxl
 isafAA7dj+0zY98s9I5Hn7ECja8Lj2zT2J8yw9y3gCy+eQQzxmJ9kVQVTHItZbeQXlFd
 89hoqKeQFOWa9106pPtlbQI2Ie+IKcA+FFyWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733878005; x=1734482805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWAMh6Ba62cJAu5Du+Zua/wiX2PZn3x0Q9c2K65iDcE=;
 b=DWu5yOdhLJdrwyKTVZrfLVjxQoR5USm4AWcrMFGYpFjK0O4jbzs6olA55h+p90N1KA
 KjYFcVfLkevR9kqdqOVXIQyRfkrsGOFnLm5FWlBC+YGp1xnY+EfNT7dO6qF+Aijs7W3k
 iuCjNUGw4/GzSlCXEog9WEzdFHp12wDcVNgV5snhuromozvbU6L1tR0dLjqup6EVJf+F
 2z1xRJ4lMGDfAouq93TjZe3MQ9513CqzdGBmZ57Z6rL9zH5ildXTtgJwcPria0syEFZ5
 50TbXQO7xosgt7TUlaaIDK8cHj2RQmIXPimDVdUUXBXPTz3v7sTUDePW7UDgff3MyAuK
 Kasg==
X-Gm-Message-State: AOJu0YzMoh59Babv7YiF4Xy8lgW/NG6GVxamxOII7LNLQJeVV/5fB1dZ
 nshK+p7hlQmWicsZuMDNuxkBGjMNikv3BcaE1IWDcBFU8iz80hz9mN/0oEY6yiawMuu+zHPm5RM
 =
X-Gm-Gg: ASbGncsGkTXGm0bBtzr43EHFAegRLUaQNo40UnQpBD0WnK8ovRSqZNCd5nK025FDtCG
 1ifAgxUcEXSeWMC1Hc2V0BBVCqCFrqwQ6O+OKd7Oz0oFgbzAeieiXUmUX6EATAajLieXPHCx+Cl
 6Yz9ttWfvPCCMUsUgH0JGAX/N/qlbYZvzygM0DCeP1SY/nxximj466BU9RA1QNJbpD/eam/bQlG
 eXWpFt7J9FxD+f51QOz6e2Bi02OgUJc5VQhq2Bbbx6do7t/hNA3/lB7MWBUwwOd5hKSkLIHpdKH
 uyItBv6soPIqJkA=
X-Google-Smtp-Source: AGHT+IF+oBlmAWFrerYAM0rVQ0MGbDH2gHOfHNhQpQdE5Fv22p2ZyX6rJVCkG5DyWGkBQqglrc4Wsg==
X-Received: by 2002:a05:6602:15d1:b0:83a:bd82:77f with SMTP id
 ca18e2360f4ac-844cb5d2bc9mr127368739f.8.1733878004892; 
 Tue, 10 Dec 2024 16:46:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844738fab36sm349291839f.26.2024.12.10.16.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 16:46:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] RFC: efi: Attempt to support automatically running SCT
Date: Tue, 10 Dec 2024 17:46:40 -0700
Message-Id: <20241211004640.3778457-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This is a feeble attempt to update the qemu script to run a selection of
UEFI tests. It copies a .seq file into the disk so it can be read by
SCT.

It doesn't seem to work and I am not sure why. I am posting it in case
someone else has ideas or wants to pic it up.

Once Ilias' CI solution is in place, I can perhaps come back to this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-qemu.sh | 56 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index 0ff53593cf9..f9ee0072573 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -21,20 +21,28 @@ usage() {
 	fi
 	echo "Usage: $0 -aBkrsw"
 	echo
-	echo "   -a   - Select architecture (arm, x86)"
-	echo "   -B   - Don't build; assume a build exists"
-	echo "   -k   - Use kvm (kernel-based Virtual Machine)"
-	echo "   -o   - Run Operating System ('ubuntu' only for now)"
-	echo "   -r   - Run QEMU with the image"
-	echo "   -R   - Select OS release (e.g. 24.04)"
-	echo "   -s   - Use serial only (no display)"
-	echo "   -w   - Use word version (32-bit)" ) >&2
+	echo "   -a <arch> - Select architecture (arm, x86)"
+	echo "   -B        - Don't build; assume a build exists"
+	echo "   -e        - Run UEFI Self-Certification Test (SCT)"
+	echo "   -k        - Use kvm (kernel-based Virtual Machine)"
+	echo "   -o <name> - Run Operating System ('ubuntu' only for now)"
+	echo "   -r        - Run QEMU with the image"
+	echo "   -R <os>   - Select OS release (e.g. 24.04)"
+	echo "   -s        - Use serial only (no display)"
+	echo "   -S <seq>  - Select SCT sequence-file"
+	echo "   -w        - Use word version (32-bit)" ) >&2
 	exit 1
 }
 
 # Directory tree for OS images
 imagedir=${imagedir-/vid/software/linux}
 
+# Directory for UEFI Self-Certification Test (SCT)
+sctdir=${sctdir-/vid/software/devel/uefi/sct}
+
+# Mount point for use when writing to disk images
+mnt=${mnt-/mnt}
+
 # architecture (arm or x86)
 arch=arm
 
@@ -65,7 +73,7 @@ kvm=
 # We avoid in-tree build because it gets confusing trying different builds
 ubdir=${ubdir-/tmp/b}
 
-while getopts "a:Bko:rR:sw" opt; do
+while getopts "a:Beko:rR:sS:w" opt; do
 	case "${opt}" in
 	a)
 		arch=$OPTARG
@@ -73,6 +81,17 @@ while getopts "a:Bko:rR:sw" opt; do
 	B)
 		build=
 		;;
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
 	k)
 		kvm="-enable-kvm"
 		;;
@@ -91,6 +110,9 @@ while getopts "a:Bko:rR:sw" opt; do
 	s)
 		serial=1
 		;;
+	S)
+		seq=$OPTARG
+		;;
 	w)
 		bitness=32
 		;;
@@ -105,6 +127,19 @@ build_u_boot() {
 	buildman -w -o $DIR --board $BOARD -I || exit $?
 }
 
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
 # Run QEMU with U-Boot
 run_qemu() {
 	if [[ -n "${os_image}" ]]; then
@@ -129,7 +164,7 @@ arm)
 	BOARD="qemu_arm"
 	BIOS="u-boot.bin"
 	qemu=qemu-system-arm
-	extra+=" -machine virt"
+	extra+=" -machine virt -accel tcg"
 	suffix="arm"
 	if [[ "${bitness}" == "64" ]]; then
 		BOARD="qemu_arm64"
@@ -168,6 +203,7 @@ DIR=${ubdir}/${BOARD}
 
 if [[ -n "${build}" ]]; then
 	build_u_boot
+	update_sct_seq
 fi
 
 if [[ -n "${run}" ]]; then
-- 
2.34.1

