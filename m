Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC57FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D48A846D8;
	Thu, 30 Apr 2026 10:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UL5oAra2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C21846D2; Thu, 30 Apr 2026 10:45:15 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF98846A1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A34711A3490;
 Thu, 30 Apr 2026 08:45:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 786EE60495;
 Thu, 30 Apr 2026 08:45:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 922831072B7B7; 
 Thu, 30 Apr 2026 10:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538711; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=4gHhbwbWyaY5AAPlO2PDTM3Rc79WvTr6O2lZ09lykFI=;
 b=UL5oAra2d2iO7u++r2bOFD8Wt+1IhQa7aC6rZhubfNGZMcDDOqv2SNyXoCFOSts7uo2Ypl
 47UeCisS4rqHhSB78fv/qJEmfPuPQv66BItB38FKRqACKRX7bi31dhYcuK28M4qRKSjvff
 Xy3afhILFkSwJGJEqzCxgQlBh+wfcjRXPaHIQHQ+9qsl9BsR9PWcLFeSLZRJbaQRSyUx37
 qhn5LJaaSJ/DFTu49mSLUTol0f+K8B3v6uw4eNb3r7AbkLSpkz3Uc5QJZmS7z8jNqrfXOk
 lY1aRXX4bxTSEcHJST/9DFMLSSOiOi55PaYzV0LxmWVBILmjFUI8KA5fytyglA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 17/20] board: evm: Enable de-isolation of IOs at resume for
 j7200 and j784s4
Date: Thu, 30 Apr 2026 10:44:10 +0200
Message-ID: <20260430084414.1354490-18-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

When resuming from IO_ONLY_PLUS_DDR low power mode, the IOs are
isolated. Remove that isolation in resume sequence.

On j7200, The canuart IOs are isolated whereas on j784s4, the
mcu_general IOs are isolated.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---
 .../arm/mach-k3/include/mach/j721e_hardware.h | 11 +++++++
 .../mach-k3/include/mach/j784s4_hardware.h    | 10 +++++++
 board/ti/j721e/evm.c                          | 29 ++++++++++++++++++
 board/ti/j784s4/evm.c                         | 30 +++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 5bef309af0a4..587dd10eb1ea 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -15,6 +15,17 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_1						(DMSC_PWRCTRL_BASE + 0x88)
+#define DMSC_PWRCTRL_BASE				0x44130000
+#define CANUART_WAKE_CTRL				0x18300
+#define CANUART_WAKE_STAT0				0x18308
+#define CANUART_WAKE_STAT1				0x1830C
+
+#define IO_ISO_MAGIC_VAL			0x55555554
+#define IO_ISO_STATUS				BIT(25)
+#define CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+#define DEISOLATION_TIMEOUT_MS			10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK		BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT		0
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 29a894baed34..dd51473419dd 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -15,6 +15,16 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_0					0x14084
+#define MCU_GEN_WAKE_CTRL				0x18310
+#define MCU_GEN_WAKE_STAT0				0x18318
+#define MCU_GEN_WAKE_STAT1				0x1831C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define IO_ISO_STATUS					BIT(25)
+#define MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 67ff13828514..41eea1bdea95 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -18,6 +18,7 @@
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
 #include <power/pmic.h>
+#include <wait_bit.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -473,14 +474,42 @@ err_free_gpio:
 
 #if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
 
+static void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + CANUART_WAKE_STAT1);
+
+	/* un-set the magic word for canuart IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+
+	/* wait for CANUART_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		pr_err("Deisolation timeout");
+}
+
 bool j7xx_board_is_resuming(void)
 {
 	struct udevice *pmica;
+	u32 pmctrl_val = readl(PMCTRL_IO_1);
 	int ret;
 
 	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
 		goto end;
 
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+		debug("Resuming from IO_DDR mode\n");
+		goto end;
+	}
+
 	ret = uclass_get_device_by_name(UCLASS_PMIC,
 					"pmic@48", &pmica);
 	if (ret) {
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 57c2f7018323..eef56556a33c 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -13,8 +13,10 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include <power/pmic.h>
+#include <wait_bit.h>
 #include "../common/fdt_ops.h"
 #include "../common/k3-lpm.h"
+#include "../common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -66,15 +68,43 @@ int board_late_init(void)
 #if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
 				      IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
 
+static void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_STAT1);
+
+	/* un-set the magic word for MCU_GENERAL IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+
+	/* wait for MCU_GEN_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		pr_err("Deisolation timeout");
+}
+
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 bool j7xx_board_is_resuming(void)
 {
 	struct udevice *pmic;
+	u32 pmctrl_val = readl(WKUP_CTRL_MMR0_BASE + PMCTRL_IO_0);
 	int err;
 
 	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
 		goto end;
 
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+		debug("board is resuming from IO_DDR mode\n");
+		goto end;
+	}
+
 	err = uclass_get_device_by_name(UCLASS_PMIC,
 					"pmic@48", &pmic);
 	if (err) {
