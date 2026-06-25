Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D5CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E74384996;
	Thu, 25 Jun 2026 09:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iIqsEYPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19178493A; Thu, 25 Jun 2026 09:15:35 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F40B84949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 181614E408C9;
 Thu, 25 Jun 2026 07:15:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E1D275FF03;
 Thu, 25 Jun 2026 07:15:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 297A6106C8468; 
 Thu, 25 Jun 2026 09:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782371731; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=EO5+O84gLAXsX9nZsFZbvR9+frCNlrqSWNTmkoSugmA=;
 b=iIqsEYPTYF1A/U7pilSq6fZ77hGuQNLIPf62yNNrHmSYB6gbq/+SBbox61uZB6GfsyxIYb
 lysIxIpviRGNVVhz7TRMMoxUdgccyXHtu5kU+UI0HXpqNbJ6UbAXXin4/aBI/4/QYUlskf
 dI2qHoqZ8fT15VR0msM758JbUTwvNFRTZwDbtmlnebw7omSAH5ArJcgzINJ1Y+lGPOR3+S
 +rcWiF7ooDP0LQHpg9TkXPdTlAc/0UxGGFO+tWy5jpXllSl+3qQ7kphxc6kCUf4t+jF1zI
 ONl0Luo8k/14VOruOLqCI++ih6Sw9euAAxgtrcp9zQSjdJ5IewLuYW1sNUo7cg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v4 07/19] board: evm: Enable de-isolation of IOs at resume for
 j7200 and j784s4
Date: Thu, 25 Jun 2026 09:15:03 +0200
Message-ID: <20260625071515.91243-8-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625071515.91243-1-richard.genoud@bootlin.com>
References: <20260625071515.91243-1-richard.genoud@bootlin.com>
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
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 .../arm/mach-k3/include/mach/j721e_hardware.h | 11 ++++++++
 .../mach-k3/include/mach/j784s4_hardware.h    | 10 ++++++++
 arch/arm/mach-k3/r5/lpm-common.c              | 15 +++++++++++
 board/ti/j721e/evm.c                          | 25 +++++++++++++++++++
 board/ti/j784s4/evm.c                         | 24 ++++++++++++++++++
 5 files changed, 85 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 5bef309af0a4..e6e437af4ec0 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -14,6 +14,17 @@
 #define WKUP_CTRL_MMR0_BASE				0x43000000
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
+#define DMSC_PWRCTRL_BASE				0x44130000
+
+#define PMCTRL_IO_1					(DMSC_PWRCTRL_BASE + 0x88)
+#define PMCTRL_IO_LPM					PMCTRL_IO_1
+#define CANUART_WAKE_CTRL				0x18300
+#define CANUART_WAKE_STAT0				0x18308
+#define CANUART_WAKE_STAT1				0x1830C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
 
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK		BIT(0)
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 29a894baed34..033ae153d674 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -15,6 +15,16 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_0					(WKUP_CTRL_MMR0_BASE + 0x14084)
+#define PMCTRL_IO_LPM					PMCTRL_IO_0
+#define MCU_GEN_WAKE_CTRL				0x18310
+#define MCU_GEN_WAKE_STAT0				0x18318
+#define MCU_GEN_WAKE_STAT1				0x1831C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 7889922a7e24..1e31b86d26c6 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2026 Bootlin
  */
 
+#include <asm/arch/hardware.h>
 #include <asm/global_data.h>
 #include <clk.h>
 #include <dm/device.h>
@@ -28,6 +29,7 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+#define IO_ISO_STATUS BIT(25)
 #define FW_IMAGE_SIZE 0x80000
 
 struct lpm_addr_info {
@@ -38,6 +40,8 @@ struct lpm_addr_info {
 	u32 size;
 };
 
+__weak void clear_isolation(void) { }
+
 /* This is used by J722s */
 __weak void ctrl_mmr_unlock(void) { }
 
@@ -72,11 +76,22 @@ void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
 bool j7xx_board_is_resuming(void)
 {
 	struct udevice *pmic, *i2c;
+	u32 pmctrl_val = 0;
 	int ret, magic;
 
 	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
 		goto end;
 
+#ifdef PMCTRL_IO_LPM
+	pmctrl_val = readl(PMCTRL_IO_LPM);
+#endif
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+		debug("board is resuming from IO_DDR mode\n");
+		goto end;
+	}
+
 	if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
 		/*
 		 * On J722S devices, i2c access fails unless MMR
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963a..2fba16fda323 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,6 +17,7 @@
 #include <spl.h>
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
+#include <wait_bit.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -469,6 +470,30 @@ err_free_gpio:
 	}
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+
+void clear_isolation(void)
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
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 8a4d40a5a959..179a26d570fd 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -11,7 +11,9 @@
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/arch/hardware.h>
 #include <asm/arch/k3-ddr.h>
+#include <wait_bit.h>
 #include "../common/fdt_ops.h"
 
 struct efi_fw_image fw_images[] = {
@@ -59,6 +61,28 @@ int board_late_init(void)
 }
 #endif
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+void clear_isolation(void)
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
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J784s4_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
