Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82261CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 14:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA378352B;
	Mon, 27 Oct 2025 15:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OTHtC2Vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3FC83700; Mon, 27 Oct 2025 15:17:22 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D7B82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 15:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59REHFXK2425083;
 Mon, 27 Oct 2025 09:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761574635;
 bh=DeN/Hk9TraPKzGX96R5shQh3ov0Mw1IcRPrBJc72v9c=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=OTHtC2Vrh5qiH9FQmFQKsKSQ9pVBFziKKHSYA3ArGjzBFzqwGHRpE3IVlAAAN5Qfz
 JaxELC1zrhsrzLwTWMwe9LnC4KgjAkh7gy87M+v1eCRHPtEtvYGUy6ixuTgC9GkHrk
 81sUtHMIjU1oxNp10XaFEINtAatq/AapbSJXfKfQ=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59REHFTE1708212
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 09:17:15 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 09:17:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 09:17:14 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59REHD2d775172;
 Mon, 27 Oct 2025 09:17:14 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 27 Oct 2025 19:47:02 +0530
Subject: [PATCH v10 1/2] spl: remove usage of CMD_BOOTx from image parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251027-fix_cmd_bootx-v10-1-10487e907710@ti.com>
References: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
In-Reply-To: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Vignesh R
 <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761574631; l=6001;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=FN/I9QV8a4H6v6lR/frtsOODjUFiz64X6YwTDECebnQ=;
 b=U/8vL8YhRtnqrf12IDG39Sewqa6Td0uGUMxiP2YPhJ+O6VY1jiaO7JaDuvf3PJJwErZsqtubS
 OSSjR5EkP8nB/3Y+wSdbC39aoE9gKa/hvGeOMO1oRL6ikOMZCXRWVBe
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Using CMD_* configs from spl doesn't make logical sense. Therefore
this patch replaces the checks for CMD_BOOTx with newly added library
symbols LIB_BOOT[IMZ] and SPL_LIB_BOOT[IMZ] which are enabled by their
respective CMD_* or SPL_* counterparts.

On platforms with non-secure falcon mode, SPL_BOOTZ is enabled by
default for 32-bit ARM systems and SPL_BOOTI is enabled by default for
64-bit ARM and RISCV.

The respective C files (image.c/zimage.c) are compiled based on library
symbols $(PHASE_)LIB_BOOTx instead which are in turn selected by both
CMD_BOOTx and SPL_BOOTx as required.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/lib/Makefile   | 10 ++++------
 arch/riscv/lib/Makefile |  4 ++--
 boot/Kconfig            | 18 ++++++++++++++++++
 cmd/Kconfig             |  5 +++++
 common/spl/Kconfig      | 16 ++++++++++++++++
 common/spl/spl.c        |  5 +++--
 6 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ade42d0ca4370b7df3aec59615f12e28a96874cd..05263eadad05179c6aaa7f5d5dca50a57f9d7396 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,6 +7,10 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
 				    lib1funcs.o uldivmod.o div0.o \
 				    div64.o muldi3.o
 
+obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) += zimage.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
+
 ifdef CONFIG_CPU_V7M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
@@ -30,15 +34,9 @@ endif
 
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
-obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
 obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
-ifdef CONFIG_SPL_FRAMEWORK
-obj-$(CONFIG_CMD_BOOTI) += image.o
-obj-$(CONFIG_CMD_BOOTZ) += zimage.o
-endif
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
 ifdef CONFIG_ARM64
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index db8d235c6993a8fd78b09acf50f14776615d5269..f1f50918effb45f8281d0d1b315523e42919f706 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,8 +6,8 @@
 # Copyright (C) 2017 Andes Technology Corporation
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
diff --git a/boot/Kconfig b/boot/Kconfig
index 9adb051400f3659566721fff6531e25990266806..6fd182d1ae4f9e02c2ef02e149d1a17b4f931131 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -33,6 +33,24 @@ config TIMESTAMP
 	  loaded that does not, the message 'Wrong FIT format: no timestamp'
 	  is shown.
 
+config LIB_BOOTI
+	bool
+
+config LIB_BOOTM
+	bool
+
+config LIB_BOOTZ
+	bool
+
+config SPL_LIB_BOOTI
+	bool
+
+config SPL_LIB_BOOTM
+	bool
+
+config SPL_LIB_BOOTZ
+	bool
+
 config BUTTON_CMD
 	bool "Support for running a command if a button is held during boot"
 	depends on CMDLINE
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9929087a8bb8b525ea43a1d9d35dc49d4223e13a..f8d60161152b5a97f5995b6c499d3efb1872acf1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -284,6 +284,7 @@ config CMD_BOOTD
 config CMD_BOOTM
 	bool "bootm"
 	default y
+	select LIB_BOOTM
 	help
 	  Boot an application image from the memory.
 
@@ -360,6 +361,8 @@ config BOOTM_ELF
 
 config CMD_BOOTZ
 	bool "bootz"
+	select LIB_BOOTZ
+	select LIB_BOOTM
 	help
 	  Boot the Linux zImage
 
@@ -367,6 +370,8 @@ config CMD_BOOTI
 	bool "booti"
 	depends on ARM64 || RISCV || SANDBOX
 	default y
+	select LIB_BOOTI
+	select LIB_BOOTM
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 24d6ce5d7399b06799a930911f93665a10531469..6027f24b1fee2dcf9806e5bb07083f9bf9dc01fe 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1216,6 +1216,22 @@ config SPL_OS_BOOT_SECURE
 	  to use falcon mode by disabling certain inherently non-securable options
 	  in the SPL boot flow.
 
+config SPL_BOOTZ
+	bool "Allow booting a zImage style Linux kernel from SPL"
+	depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
+	default y if ARM && !ARM64
+	select SPL_LIB_BOOTZ
+	help
+	  Boot a linux zimage from memory in falcon boot.
+
+config SPL_BOOTI
+	bool "Allow booting an Image style Linux kernel from SPL"
+	depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
+	default y if ARM64 || RISCV
+	select SPL_LIB_BOOTI
+	help
+	  Boot an uncompressed linux kernel image from memory in falcon boot.
+
 config SPL_OS_BOOT_ARGS
 	bool "Allow SPL to load args for kernel in falcon mode"
 	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_OS_BOOT_SECURE
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 64313cb8dfe1a401078882564b69890480c9894d..4dae3d0940d02b59e97f89bea6f803e0ade94332 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -340,7 +340,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		panic("** no mkimage signature but raw image not supported");
 	}
 
-	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_SPL_BOOTI)) {
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -354,7 +354,8 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
+	} else if (IS_ENABLED(CONFIG_SPL_OS_BOOT) &&
+		   IS_ENABLED(CONFIG_SPL_BOOTZ)) {
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {

-- 
2.51.0

