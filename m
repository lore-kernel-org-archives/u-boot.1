Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD8EC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1448880F24;
	Fri, 28 Aug 2026 13:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2oHlQlTW5CT; Fri, 28 Aug 2026 13:58:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925506;
	bh=+ljLyk4LZ2pT8BLSBwtlpfDT+1cGc+oI4/QgIbEaH4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wu+c/NA7qd1GbwvshGwYOuymDeI69quF6tST19ooMAZ2xI/zA568hRkIN5TWOm7CC
	 LFZI+jLPvOv3QxbBhkq1vgcqc1uWl3kQ9WvE4VJmkKN7PUXJO1gDuKMkVBqrDEPkBm
	 ia+V+Rn2iYbh3vI0LHsqJgSKTE5XNzSbrsA9b1hHJiCr5HvlYXoMUnwlAiQi2ku7zu
	 qgzDk7HF3L+KvtiFDJKmUgD1RCq9Gkm4+lKDoYdAuEy0q13B4hZw9J9OOMONgXG+g6
	 pVfYATLU07AsoDJTatImiLXLvm7jXVB9Wj7QkLqMbxjGN1ku9DhP9n3gjsWGLKVKuK
	 gPgMOihYguing==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34E3A80F28;
	Fri, 28 Aug 2026 13:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDE8B127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E02DB80F28
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVHiOE5pHVVr for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=NW15JOGu
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A83A280F68
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DC1A74E41401;
 Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AB7ED60537;
 Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E027911C782C2; 
 Fri, 28 Aug 2026 15:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925498; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=+ljLyk4LZ2pT8BLSBwtlpfDT+1cGc+oI4/QgIbEaH4o=;
 b=NW15JOGuKmiAuWsSS1xDidh3pX+mXjaIA+vMtcTZTGUJibZ7ikRDjgaQVz/ljft34TYEhH
 uaCFVt5PClqy0P1rwT6Zgb/TaTg8Y8gYqhjbBMxZRKCVwg/vu/cotMQyPR9XC+lXTqKD+/
 Pb1CO4O3ECAfsCa+FvZg5o2P6zUhJQm4hpbjTqD2JLTmumoql+ZaeVS2rSYo44s8nJr1Ol
 HzFYu+Ucn5yjW7XdDZOP9iPQxVSp4D1lfYXMhYUXGWSWU4KgynaLaF2ZlVOYAQfr5xZn+n
 Sg+CzEUkE7PMIcVtLVFKm70gWV7yp8nGQeXAJjQsqgszCNqMt0r1CClBtRQdsg==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 09/21] board: evm: Enable de-isolation of IOs at resume for
 j7200 and j784s4
Date: Fri, 28 Aug 2026 15:57:18 +0200
Message-ID: <20260828135730.1565643-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
index 4f515b51fd40..559e1b5f681a 100644
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
