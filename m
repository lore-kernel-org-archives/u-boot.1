Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1740E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637A38006F;
	Sat, 14 Dec 2024 23:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uisCdImn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RvZ2Va24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EEEC8007A; Sat, 14 Dec 2024 23:45:48 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D948006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y9hBL2DSxz9slY;
 Sat, 14 Dec 2024 23:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eF2YoM8EBEvAcXIL5YYvdWoUsPBQPlvGuTyWdsby8Nk=;
 b=uisCdImn/vOO/jXThU+M7LUpuNJuHoQ2tbpELLQIkQHVCbF2hZlXi/CQpXM7SGKCjppLq2
 vkXtzbmaI5riPQPTfezpLsVpxfeELt6H7nnwMerHg7Z248vsygu4OIJX5R/SQnNu/mJQuU
 Zlj8JAnDbtt1S1jL07KFw3YuBxOlBeuVbBotJtOEdpKKdiSLwdDuwleMWxiITg0U6c4rkA
 gXgWIlOqP/33psqDeF6CFQMJJGplOpi+tWbBTCGafiXpT091j3+XqWRllXoag+eILbGQgG
 DoLkT5ThdPBxh/6dnm/kkuMHGlfRXml6KI0/wvX9OEuQ6oX7Xvd7j2OF/8Tifg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eF2YoM8EBEvAcXIL5YYvdWoUsPBQPlvGuTyWdsby8Nk=;
 b=RvZ2Va24hRv1wAIMCDoc3WvuvJI2LXy1hcV92/CwFZObVZoIKZQs5T5hpgbs8HksmiRwIP
 7hqDWWfLvhDnnVnFekC/nRrkkWsUBcENSuZ9rWlg0NQYqFKNis6t/ak855pG9UIkkslbd2
 pfcxg+dXQT+GDigE1Rv8+sgvkvouJbSnPMlNZzWRsbwPKAZIFhQN8a1sDRPEsxmhgQrrgV
 +ZydPpUs7rZjOdxpgLBVMIZBCZ5QrP6oJGbY2MCtXIA9pV+z2ZXUWZ7KnyJJQOyjXK2goW
 KKRjnoeb1JYqCczRVIZ9tcPfbmOV9pWEetfASA7YbcaZrhnzrQwwqVX3jolrKg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Align configuration headers
Date: Sat, 14 Dec 2024 23:45:11 +0100
Message-ID: <20241214224529.303866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tikknjtxad5w8ai87h3fdzfa7thft1cm
X-MBO-RS-ID: b6b16e8f71d3f190a2d
X-Rspamd-Queue-Id: 4Y9hBL2DSxz9slY
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

Align R-Car Gen2/Gen3/Gen4 configuration header file to look
basically the same way across these three SoC generations.
There are subtle difference between the remaining bits in
those files across SoC generations, but the common bits are
now aligned. There is not much left in those headers either,
most of the configuration is now converted to Kconfig.

Specifically for R-Car Gen3, GIC registers have been moved
to architecture specific header file rcar-gen3-base.h , the
rest of the changes here are comment changes and indentation
changes.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 .../include/mach/rcar-gen3-base.h             |  5 +++++
 include/configs/rcar-gen2-common.h            | 10 ++++++----
 include/configs/rcar-gen3-common.h            | 19 ++++++-------------
 include/configs/rcar-gen4-common.h            |  8 +++-----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
index 5e2e9eca452..7b4f5f0c651 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
@@ -67,6 +67,11 @@
 #define SMSTPCR10		0xE6150998
 #define SMSTPCR11		0xE615099C
 
+/* GICv3 */
+/* Distributor Registers */
+#define GICD_BASE		0xF1010000
+#define GICC_BASE		0xF1020000
+
 /* PFC */
 #define PFC_PUEN5	0xE6060414
 #define PUEN_SSI_SDATA4	BIT(17)
diff --git a/include/configs/rcar-gen2-common.h b/include/configs/rcar-gen2-common.h
index 67c9faeca57..020e79ca2a8 100644
--- a/include/configs/rcar-gen2-common.h
+++ b/include/configs/rcar-gen2-common.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * include/configs/rcar-gen2-common.h
+ *	This file is R-Car Gen2 common configuration file.
  *
- * Copyright (C) 2013,2014 Renesas Electronics Corporation
+ * Copyright (C) 2013-2024 Renesas Electronics Corporation
  */
 
 #ifndef __RCAR_GEN2_COMMON_H
@@ -10,14 +11,15 @@
 
 #include <asm/arch/renesas.h>
 
-/* console */
-#define CFG_SYS_BAUDRATE_TABLE	{ 38400, 115200 }
+/* Console */
+#define CFG_SYS_BAUDRATE_TABLE		{ 38400, 115200 }
 
+/* Memory */
 #define CFG_SYS_SDRAM_BASE		(RCAR_GEN2_SDRAM_BASE)
 #define CFG_SYS_SDRAM_SIZE		(RCAR_GEN2_UBOOT_SDRAM_SIZE)
 
 /* Timer */
-#define CFG_SYS_TIMER_COUNTER	(TMU_BASE + 0xc)	/* TCNT0 */
+#define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
 #define CFG_SYS_TIMER_RATE		(get_board_sys_clk() / 8)
 
 #endif	/* __RCAR_GEN2_COMMON_H */
diff --git a/include/configs/rcar-gen3-common.h b/include/configs/rcar-gen3-common.h
index 3f0831a901c..bedb1c0843e 100644
--- a/include/configs/rcar-gen3-common.h
+++ b/include/configs/rcar-gen3-common.h
@@ -3,7 +3,7 @@
  * include/configs/rcar-gen3-common.h
  *	This file is R-Car Gen3 common configuration file.
  *
- * Copyright (C) 2015-2017 Renesas Electronics Corporation
+ * Copyright (C) 2015-2024 Renesas Electronics Corporation
  */
 
 #ifndef __RCAR_GEN3_COMMON_H
@@ -11,24 +11,17 @@
 
 #include <asm/arch/renesas.h>
 
-/* boot option */
+/* Console */
+#define CFG_SYS_BAUDRATE_TABLE		{ 115200, 38400 }
 
-/* Generic Interrupt Controller Definitions */
-#define GICD_BASE	0xF1010000
-#define GICC_BASE	0xF1020000
-
-/* console */
-#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 38400 }
-
-/* MEMORY */
+/* Memory */
 #define DRAM_RSV_SIZE			0x08000000
 #define CFG_SYS_SDRAM_BASE		(0x40000000 + DRAM_RSV_SIZE)
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
 
-/* ENV setting */
-
-#define CFG_EXTRA_ENV_SETTINGS	\
+/* Environment setting */
+#define CFG_EXTRA_ENV_SETTINGS		\
 	"bootm_size=0x10000000\0"
 
 #endif	/* __RCAR_GEN3_COMMON_H */
diff --git a/include/configs/rcar-gen4-common.h b/include/configs/rcar-gen4-common.h
index 37a37c013df..1a00adb79d1 100644
--- a/include/configs/rcar-gen4-common.h
+++ b/include/configs/rcar-gen4-common.h
@@ -3,7 +3,7 @@
  * include/configs/rcar-gen4-common.h
  *	This file is R-Car Gen4 common configuration file.
  *
- * Copyright (C) 2021 Renesas Electronics Corporation
+ * Copyright (C) 2021-2024 Renesas Electronics Corporation
  */
 
 #ifndef __RCAR_GEN4_COMMON_H
@@ -12,7 +12,7 @@
 #include <asm/arch/renesas.h>
 
 /* Console */
-#define CFG_SYS_BAUDRATE_TABLE	{ 38400, 115200, 921600, 1843200 }
+#define CFG_SYS_BAUDRATE_TABLE		{ 38400, 115200, 921600, 1843200 }
 
 /* Memory */
 #define DRAM_RSV_SIZE			0x08000000
@@ -20,10 +20,8 @@
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
 
-/* PHY needs a longer autoneg timeout */
-
 /* Environment setting */
-#define CFG_EXTRA_ENV_SETTINGS					\
+#define CFG_EXTRA_ENV_SETTINGS		\
 	"bootm_size=0x10000000\0"
 
 #endif	/* __RCAR_GEN4_COMMON_H */
-- 
2.45.2

