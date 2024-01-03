Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E43C47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE33879C5;
	Wed,  3 Jan 2024 01:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EF4879ED; Wed,  3 Jan 2024 01:13:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4B94A879D1
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E132C14BF;
 Tue,  2 Jan 2024 16:14:31 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8953F5A1;
 Tue,  2 Jan 2024 16:13:44 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 15/19] sunxi: move pinmux setup into separate SPL only file
Date: Wed,  3 Jan 2024 00:12:35 +0000
Message-Id: <20240103001239.17482-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

At the moment the board/sunxi/board.c file contains a number of pinmux
setup functions, that are only called by the SPL, to program the
configured pins for the UART, NAND or eMMC devices.

Move those functions into a separate file, to help keeping the board.c
file clean, and allow compiling this new file for the SPL only.

To help review, this file is as much copy&paste as possible. This raises
some checkpatch complaints, but this will be fixed and further cleanup
will be provided in a subsequent patch.
Right now we just add some comments to some #endif's to mark nested
regions. It also removes a now redundant CONFIG_SPL_BUILD guard, and fixes
a whitespace problem for the R528 eMMC setup.

The new file is placed in arch/arm/mach-sunxi, as the plan is to keep
all (legacy) SPL code in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Makefile     |   1 +
 arch/arm/mach-sunxi/spl_pinmux.c | 326 +++++++++++++++++++++++++++++++
 board/sunxi/board.c              | 309 +----------------------------
 3 files changed, 328 insertions(+), 308 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/spl_pinmux.c

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 3f83c0280ef..c15ef01aaad 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -31,6 +31,7 @@ endif
 
 ifdef CONFIG_SPL_BUILD
 obj-y				+= clock.o
+obj-y				+= spl_pinmux.o
 obj-$(CONFIG_MACH_SUNIV)	+= dram_suniv.o
 obj-$(CONFIG_DRAM_SUN4I)	+= dram_sun4i.o
 obj-$(CONFIG_DRAM_SUN6I)	+= dram_sun6i.o
diff --git a/arch/arm/mach-sunxi/spl_pinmux.c b/arch/arm/mach-sunxi/spl_pinmux.c
new file mode 100644
index 00000000000..45cc2cfe2b1
--- /dev/null
+++ b/arch/arm/mach-sunxi/spl_pinmux.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 Arm Ltd.
+ * (C) Copyright 2012-2013 Henrik Nordstrom <henrik@henriknordstrom.net>
+ * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * (C) Copyright 2007-2011
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ * Tom Cubie <tangliang@allwinnertech.com>
+ *
+ * Code to setup pinmux configuration in the SPL, which lacks the DT to
+ * look this up properly.
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mmc.h>
+#include <asm/io.h>
+#include <asm/u-boot.h>
+#include <sunxi_gpio.h>
+
+void i2c_init_board(void)
+{
+#ifdef CONFIG_I2C0_ENABLE
+#if defined(CONFIG_MACH_SUN4I) || \
+    defined(CONFIG_MACH_SUN5I) || \
+    defined(CONFIG_MACH_SUN7I) || \
+    defined(CONFIG_MACH_SUN8I_R40)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN4I_GPB_TWI0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN4I_GPB_TWI0);
+	clock_twi_onoff(0, 1);
+#elif defined(CONFIG_MACH_SUN6I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(14), SUN6I_GPH_TWI0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(15), SUN6I_GPH_TWI0);
+	clock_twi_onoff(0, 1);
+#elif defined(CONFIG_MACH_SUN8I_V3S)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), SUN8I_V3S_GPB_TWI0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), SUN8I_V3S_GPB_TWI0);
+	clock_twi_onoff(0, 1);
+#elif defined(CONFIG_MACH_SUN8I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN8I_GPH_TWI0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN8I_GPH_TWI0);
+	clock_twi_onoff(0, 1);
+#elif defined(CONFIG_MACH_SUN50I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_GPH_TWI0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_GPH_TWI0);
+	clock_twi_onoff(0, 1);
+#endif
+#endif /* CONFIG_I2C0_ENABLE */
+
+#ifdef CONFIG_I2C1_ENABLE
+#if defined(CONFIG_MACH_SUN4I) || \
+    defined(CONFIG_MACH_SUN7I) || \
+    defined(CONFIG_MACH_SUN8I_R40)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(18), SUN4I_GPB_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(19), SUN4I_GPB_TWI1);
+	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN5I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(15), SUN5I_GPB_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(16), SUN5I_GPB_TWI1);
+	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN6I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
+	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN8I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
+	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN50I)
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN50I_GPH_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN50I_GPH_TWI1);
+	clock_twi_onoff(1, 1);
+#endif
+#endif /* CONFIG_I2C1_ENABLE */
+
+#ifdef CONFIG_R_I2C_ENABLE
+#ifdef CONFIG_MACH_SUN50I
+	clock_twi_onoff(5, 1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
+#elif defined(CONFIG_MACH_SUN50I_H616)
+	clock_twi_onoff(5, 1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
+#else
+	clock_twi_onoff(5, 1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN8I_H3_GPL_R_TWI);
+#endif
+#endif /* CONFIG_R_I2C_ENABLE */
+}
+
+#if defined(CONFIG_NAND_SUNXI)
+static void nand_pinmux_setup(void)
+{
+	unsigned int pin;
+
+	for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(19); pin++)
+		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
+
+#if defined CONFIG_MACH_SUN4I || defined CONFIG_MACH_SUN7I
+	for (pin = SUNXI_GPC(20); pin <= SUNXI_GPC(22); pin++)
+		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
+#endif
+	/* sun4i / sun7i do have a PC23, but it is not used for nand,
+	 * only sun7i has a PC24 */
+#ifdef CONFIG_MACH_SUN7I
+	sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_NAND);
+#endif
+}
+
+static void nand_clock_setup(void)
+{
+	struct sunxi_ccm_reg *const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
+#if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
+    defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
+	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
+#endif
+	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
+}
+
+void board_nand_init(void)
+{
+	nand_pinmux_setup();
+	nand_clock_setup();
+}
+#endif /* CONFIG_NAND_SUNXI */
+
+#ifdef CONFIG_MMC
+static void mmc_pinmux_setup(int sdc)
+{
+	unsigned int pin;
+
+	switch (sdc) {
+	case 0:
+		/* SDC0: PF0-PF5 */
+		for (pin = SUNXI_GPF(0); pin <= SUNXI_GPF(5); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPF_SDC0);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+		break;
+
+	case 1:
+#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
+    defined(CONFIG_MACH_SUN8I_R40)
+		if (IS_ENABLED(CONFIG_MMC1_PINS_PH)) {
+			/* SDC1: PH22-PH-27 */
+			for (pin = SUNXI_GPH(22); pin <= SUNXI_GPH(27); pin++) {
+				sunxi_gpio_set_cfgpin(pin, SUN4I_GPH_SDC1);
+				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+				sunxi_gpio_set_drv(pin, 2);
+			}
+		} else {
+			/* SDC1: PG0-PG5 */
+			for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
+				sunxi_gpio_set_cfgpin(pin, SUN4I_GPG_SDC1);
+				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+				sunxi_gpio_set_drv(pin, 2);
+			}
+		}
+#elif defined(CONFIG_MACH_SUN5I)
+		/* SDC1: PG3-PG8 */
+		for (pin = SUNXI_GPG(3); pin <= SUNXI_GPG(8); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUN5I_GPG_SDC1);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN6I)
+		/* SDC1: PG0-PG5 */
+		for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUN6I_GPG_SDC1);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN8I)
+		/* SDC1: PG0-PG5 */
+		for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUN8I_GPG_SDC1);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#endif
+		break;
+
+	case 2:
+#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I)
+		/* SDC2: PC6-PC11 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(11); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN5I)
+		/* SDC2: PC6-PC15 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN6I)
+		/* SDC2: PC6-PC15, PC24 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+
+		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_SDC2);
+		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
+		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
+#elif defined(CONFIG_MACH_SUN8I_R40)
+		/* SDC2: PC6-PC15, PC24 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+
+		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_SDC2);
+		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
+		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
+#elif defined(CONFIG_MACH_SUN8I) || defined(CONFIG_MACH_SUN50I)
+		/* SDC2: PC5-PC6, PC8-PC16 */
+		for (pin = SUNXI_GPC(5); pin <= SUNXI_GPC(6); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+
+		for (pin = SUNXI_GPC(8); pin <= SUNXI_GPC(16); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN50I_H6)
+		/* SDC2: PC4-PC14 */
+		for (pin = SUNXI_GPC(4); pin <= SUNXI_GPC(14); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN50I_H616)
+		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
+		for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(16); pin++) {
+			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
+				continue;
+			if (pin == SUNXI_GPC(7) || pin == SUNXI_GPC(12))
+				continue;
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 3);
+		}
+#elif defined(CONFIG_MACH_SUN9I)
+		/* SDC2: PC6-PC16 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(16); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN8I_R528)
+		/* SDC2: PC2-PC7 */
+		for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#else
+		puts("ERROR: No pinmux setup defined for MMC2!\n");
+#endif
+		break;
+
+	case 3:
+#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
+    defined(CONFIG_MACH_SUN8I_R40)
+		/* SDC3: PI4-PI9 */
+		for (pin = SUNXI_GPI(4); pin <= SUNXI_GPI(9); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPI_SDC3);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+#elif defined(CONFIG_MACH_SUN6I)
+		/* SDC3: PC6-PC15, PC24 */
+		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
+			sunxi_gpio_set_cfgpin(pin, SUN6I_GPC_SDC3);
+			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+			sunxi_gpio_set_drv(pin, 2);
+		}
+
+		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUN6I_GPC_SDC3);
+		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
+		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
+#endif
+		break;
+
+	default:
+		printf("sunxi: invalid MMC slot %d for pinmux setup\n", sdc);
+		break;
+	}
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	/*
+	 * The BROM always accesses MMC port 0 (typically an SD card), and
+	 * most boards seem to have such a slot. The others haven't reported
+	 * any problem with unconditionally enabling this in the SPL.
+	 */
+	if (!IS_ENABLED(CONFIG_UART0_PORT_F)) {
+		mmc_pinmux_setup(0);
+		if (!sunxi_mmc_init(0))
+			return -1;
+	}
+
+	if (CONFIG_MMC_SUNXI_SLOT_EXTRA != -1) {
+		mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
+		if (!sunxi_mmc_init(CONFIG_MMC_SUNXI_SLOT_EXTRA))
+			return -1;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_MMC */
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 1313b01dcea..5f80c097a15 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -54,78 +54,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-void i2c_init_board(void)
-{
-#ifdef CONFIG_I2C0_ENABLE
-#if defined(CONFIG_MACH_SUN4I) || \
-    defined(CONFIG_MACH_SUN5I) || \
-    defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN4I_GPB_TWI0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN4I_GPB_TWI0);
-	clock_twi_onoff(0, 1);
-#elif defined(CONFIG_MACH_SUN6I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(14), SUN6I_GPH_TWI0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(15), SUN6I_GPH_TWI0);
-	clock_twi_onoff(0, 1);
-#elif defined(CONFIG_MACH_SUN8I_V3S)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), SUN8I_V3S_GPB_TWI0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), SUN8I_V3S_GPB_TWI0);
-	clock_twi_onoff(0, 1);
-#elif defined(CONFIG_MACH_SUN8I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN8I_GPH_TWI0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN8I_GPH_TWI0);
-	clock_twi_onoff(0, 1);
-#elif defined(CONFIG_MACH_SUN50I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_GPH_TWI0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_GPH_TWI0);
-	clock_twi_onoff(0, 1);
-#endif
-#endif
-
-#ifdef CONFIG_I2C1_ENABLE
-#if defined(CONFIG_MACH_SUN4I) || \
-    defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(18), SUN4I_GPB_TWI1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(19), SUN4I_GPB_TWI1);
-	clock_twi_onoff(1, 1);
-#elif defined(CONFIG_MACH_SUN5I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(15), SUN5I_GPB_TWI1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPB(16), SUN5I_GPB_TWI1);
-	clock_twi_onoff(1, 1);
-#elif defined(CONFIG_MACH_SUN6I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
-	clock_twi_onoff(1, 1);
-#elif defined(CONFIG_MACH_SUN8I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
-	clock_twi_onoff(1, 1);
-#elif defined(CONFIG_MACH_SUN50I)
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN50I_GPH_TWI1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN50I_GPH_TWI1);
-	clock_twi_onoff(1, 1);
-#endif
-#endif
-
-#ifdef CONFIG_R_I2C_ENABLE
-#ifdef CONFIG_MACH_SUN50I
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
-#elif CONFIG_MACH_SUN50I_H616
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
-#else
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN8I_H3_GPL_R_TWI);
-#endif
-#endif
-}
-
 /*
  * Try to use the environment from the boot source first.
  * For MMC, this means a FAT partition on the boot device (SD or eMMC).
@@ -282,241 +210,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_NAND_SUNXI) && defined(CONFIG_SPL_BUILD)
-static void nand_pinmux_setup(void)
-{
-	unsigned int pin;
-
-	for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(19); pin++)
-		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
-
-#if defined CONFIG_MACH_SUN4I || defined CONFIG_MACH_SUN7I
-	for (pin = SUNXI_GPC(20); pin <= SUNXI_GPC(22); pin++)
-		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
-#endif
-	/* sun4i / sun7i do have a PC23, but it is not used for nand,
-	 * only sun7i has a PC24 */
-#ifdef CONFIG_MACH_SUN7I
-	sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_NAND);
-#endif
-}
-
-static void nand_clock_setup(void)
-{
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-
-	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
-#if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
-    defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
-	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
-#endif
-	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
-}
-
-void board_nand_init(void)
-{
-	nand_pinmux_setup();
-	nand_clock_setup();
-}
-#endif /* CONFIG_NAND_SUNXI */
-
-#ifdef CONFIG_MMC
-static void mmc_pinmux_setup(int sdc)
-{
-	unsigned int pin;
-
-	switch (sdc) {
-	case 0:
-		/* SDC0: PF0-PF5 */
-		for (pin = SUNXI_GPF(0); pin <= SUNXI_GPF(5); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPF_SDC0);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-		break;
-
-	case 1:
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-		if (IS_ENABLED(CONFIG_MMC1_PINS_PH)) {
-			/* SDC1: PH22-PH-27 */
-			for (pin = SUNXI_GPH(22); pin <= SUNXI_GPH(27); pin++) {
-				sunxi_gpio_set_cfgpin(pin, SUN4I_GPH_SDC1);
-				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-				sunxi_gpio_set_drv(pin, 2);
-			}
-		} else {
-			/* SDC1: PG0-PG5 */
-			for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
-				sunxi_gpio_set_cfgpin(pin, SUN4I_GPG_SDC1);
-				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-				sunxi_gpio_set_drv(pin, 2);
-			}
-		}
-#elif defined(CONFIG_MACH_SUN5I)
-		/* SDC1: PG3-PG8 */
-		for (pin = SUNXI_GPG(3); pin <= SUNXI_GPG(8); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUN5I_GPG_SDC1);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN6I)
-		/* SDC1: PG0-PG5 */
-		for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUN6I_GPG_SDC1);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN8I)
-		/* SDC1: PG0-PG5 */
-		for (pin = SUNXI_GPG(0); pin <= SUNXI_GPG(5); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUN8I_GPG_SDC1);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#endif
-		break;
-
-	case 2:
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I)
-		/* SDC2: PC6-PC11 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(11); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN5I)
-		/* SDC2: PC6-PC15 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN6I)
-		/* SDC2: PC6-PC15, PC24 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_SDC2);
-		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
-		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
-#elif defined(CONFIG_MACH_SUN8I_R40)
-		/* SDC2: PC6-PC15, PC24 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_SDC2);
-		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
-		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
-#elif defined(CONFIG_MACH_SUN8I) || defined(CONFIG_MACH_SUN50I)
-		/* SDC2: PC5-PC6, PC8-PC16 */
-		for (pin = SUNXI_GPC(5); pin <= SUNXI_GPC(6); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-
-		for (pin = SUNXI_GPC(8); pin <= SUNXI_GPC(16); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN50I_H6)
-		/* SDC2: PC4-PC14 */
-		for (pin = SUNXI_GPC(4); pin <= SUNXI_GPC(14); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN50I_H616)
-		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
-		for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(16); pin++) {
-			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
-				continue;
-			if (pin == SUNXI_GPC(7) || pin == SUNXI_GPC(12))
-				continue;
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 3);
-		}
-#elif defined(CONFIG_MACH_SUN9I)
-		/* SDC2: PC6-PC16 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(16); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN8I_R528)
-                /* SDC2: PC2-PC7 */
-                for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
-                        sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-                        sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-                        sunxi_gpio_set_drv(pin, 2);
-                }
-#else
-		puts("ERROR: No pinmux setup defined for MMC2!\n");
-#endif
-		break;
-
-	case 3:
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-		/* SDC3: PI4-PI9 */
-		for (pin = SUNXI_GPI(4); pin <= SUNXI_GPI(9); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPI_SDC3);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-#elif defined(CONFIG_MACH_SUN6I)
-		/* SDC3: PC6-PC15, PC24 */
-		for (pin = SUNXI_GPC(6); pin <= SUNXI_GPC(15); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUN6I_GPC_SDC3);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
-
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUN6I_GPC_SDC3);
-		sunxi_gpio_set_pull(SUNXI_GPC(24), SUNXI_GPIO_PULL_UP);
-		sunxi_gpio_set_drv(SUNXI_GPC(24), 2);
-#endif
-		break;
-
-	default:
-		printf("sunxi: invalid MMC slot %d for pinmux setup\n", sdc);
-		break;
-	}
-}
-
-int board_mmc_init(struct bd_info *bis)
-{
-	/*
-	 * The BROM always accesses MMC port 0 (typically an SD card), and
-	 * most boards seem to have such a slot. The others haven't reported
-	 * any problem with unconditionally enabling this in the SPL.
-	 */
-	if (!IS_ENABLED(CONFIG_UART0_PORT_F)) {
-		mmc_pinmux_setup(0);
-		if (!sunxi_mmc_init(0))
-			return -1;
-	}
-
-	if (CONFIG_MMC_SUNXI_SLOT_EXTRA != -1) {
-		mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
-		if (!sunxi_mmc_init(CONFIG_MMC_SUNXI_SLOT_EXTRA))
-			return -1;
-	}
-
-	return 0;
-}
-
-#if CONFIG_MMC_SUNXI_SLOT_EXTRA != -1
+#if defined(CONFIG_MMC) && CONFIG_MMC_SUNXI_SLOT_EXTRA != -1
 int mmc_get_env_dev(void)
 {
 	switch (sunxi_get_boot_device()) {
@@ -528,7 +222,6 @@ int mmc_get_env_dev(void)
 		return CONFIG_SYS_MMC_ENV_DEV;
 	}
 }
-#endif
 #endif /* CONFIG_MMC */
 
 #ifdef CONFIG_SPL_BUILD
-- 
2.35.8

