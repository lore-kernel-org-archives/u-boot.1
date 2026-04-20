Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F90F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6FF84476;
	Mon, 20 Apr 2026 22:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qItyg6Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F9F844C1; Mon, 20 Apr 2026 22:42:51 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B2D8442E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1846E3F7D3; 
 Mon, 20 Apr 2026 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776717769;
 bh=XOzBofOYcj1iNTQUUb4OWFfj1zDVS0B/8WwwxxyLLyU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qItyg6NhWarHbBaeSWldBM1FOUdr1Bof9uAf8Nv0ZIYSx6QnFC21B4V4KHKrxWroc
 KsSH3vSneUjoY0vklPX0IuxznZNqHCw/sZQgFeXL0A/uBsT+2HIpO0R2+YG1Fllyc5
 getxXSwMQ7NhixmRNOS0TMxMMqSe+Dnvqwhbbh5H3Y/ZSCDJ2aMhfmMG9deQjeic5w
 rqFYBP4xCCDtQ2LKExeug2AuW84l85rhef+vRelVDlgujlrxjldajhtMH7zIV4Tv4Y
 1NL5PWzXN4ahqVWQq4/gcrEUUMHyUE7w11xwP8u72Z4tgBufigtkctSO+Df7VHJueN
 ozqZrDJNH4eajKP8jCdeRV8F5ehzbFT/dddRNE832jL2+MVsvuRWRWLB4vgt/59vJ7
 3aEdbFPx/J0NC0eVQlC8IgeY7cUmSJj2ca6WUmox9lClhR8AusLSEXmVG7SkKYpLFn
 4nsKuYli3tlZ6rRSI6631h4u5yo26QPt0PoSiXTrsWWUaLgklmeD0wDLYRC63YxIdF
 N5a4JxVsItsvMlrE+wwAIVqcCS9+Kkr+K9fx9aj1KMk1Hv3Tue2P7MYLDw9MwJ+s9F
 lz/Aq0f5ooUA5KctrW6rPf+1gYzIfqRA9tytotp+b1KQpo73sH29FrdGaX4ArHT1jY
 +mOiU36pTLxPWH3iNZq9+ZSs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Johannes Krottmayer <krotti83@proton.me>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH RESEND v2 1/1] doc: emulation: qemu-arm: add secure state steps
Date: Mon, 20 Apr 2026 22:42:47 +0200
Message-ID: <20260420204247.6596-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

From: Johannes Krottmayer <krotti83@proton.me>

Add build steps for building U-Boot in secure state with
TF-A and OP-TEE. It includes the full steps for building
OP-TEE and TF-A to use with U-Boot. Also a short description
how to invoke QEMU with enabled EL3 and EL2. EL3 (machine
option secure=on) is required to run TF-A.

Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 doc/board/emulation/qemu-arm.rst | 88 ++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac6..9e993ca9783 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -24,8 +24,78 @@ Additionally, a number of optional peripherals can be added to the PCI bus.
 See :doc:`../../develop/devicetree/dt_qemu` for information on how to see
 the devicetree actually generated by QEMU.
 
-Building U-Boot
----------------
+Building (secure)
+-----------------
+
+U-Boot
+^^^^^^
+
+- For AArch64::
+
+    make qemu_arm64_defconfig
+    make
+
+On successful build 'u-boot.bin' should be created. It's necessary in the following
+steps (building TF-A).
+
+OP-TEE
+^^^^^^
+
+- For AArch64::
+
+    git clone https://github.com/OP-TEE/optee_os.git
+    cd optee_os
+    git checkout 4.9.0
+    export CROSS_COMPILE64=aarch64-none-elf-
+    export CROSS_COMPILE32=arm-none-eabi-
+    make PLATFORM=vexpress-qemu_armv8a CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y
+
+At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-Bit edition) for
+a successful build. On a successful build following files should be created under the
+directory 'out/arm-plat-vexpress/core' from OP-TEE::
+
+    optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin
+    optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin
+    optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin
+
+TF-A
+^^^^
+
+- For AArch64::
+
+    git clone https://github.com/ARM-software/arm-trusted-firmware.git
+    cd arm-trusted-firmware
+    git submodule update --init
+    git checkout v2.14.0
+    export CROSS_COMPILE=aarch64-none-elf-
+    export BL32=path/to/tee-header_v2.bin
+    export BL32_EXTRA1=path/to/tee-pager_v2.bin
+    export BL32_EXTRA2=path/to/tee-pageable_v2.bin
+    export BL33=path/to/u-boot.bin
+    make PLAT=qemu BL32_RAM_LOCATION=tdram SPD=opteed TRANSFER_LIST=1 all fip
+
+On successful build the following files should be created under the directory
+'build/qemu/release' from TF-A::
+
+    arm-trusted-firmware/build/qemu/release/bl1.bin
+    arm-trusted-firmware/build/qemu/release/fip.bin
+
+The following file is at least created with TF-A v2.14.0 and can be directly passed
+with the '-bios' option to QEMU::
+
+    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
+
+If the single file ('qemu_fw.bios') doesn't exist, 'bl1.bin' and 'fip.bin' can be
+concatenated with the command 'dd' alternatively::
+
+    dd if=bl1.bin of=qemu_fw.bios bs=4096 conv=notrunc
+    dd if=fip.bin of=qemu_fw.bios seek=64 bs=4096 conv=notrunc
+
+Building (non-secure)
+---------------------
+
+U-Boot
+^^^^^^
 Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
@@ -38,8 +108,18 @@ Set the CROSS_COMPILE environment variable as usual, and run:
     make qemu_arm64_defconfig
     make
 
-Running U-Boot
---------------
+Running U-Boot (secure)
+-----------------------
+
+- For AArch64::
+
+    qemu-system-aarch64 -machine virt,secure=on,virtualization=on \
+    -nographic -cpu cortex-a57 -bios qemu_fw.bios
+
+For additional QEMU command description see running U-Boot in non-secure state.
+
+Running U-Boot (non-secure)
+---------------------------
 The minimal QEMU command line to get U-Boot up and running is:
 
 - For ARM::
-- 
2.53.0

