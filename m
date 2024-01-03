Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4EAC46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08131879F3;
	Wed,  3 Jan 2024 01:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D396F879E4; Wed,  3 Jan 2024 01:13:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 56B5587927
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC920C15;
 Tue,  2 Jan 2024 16:14:32 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E30E3F5A1;
 Tue,  2 Jan 2024 16:13:45 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 16/19] sunxi: SPL pinmux: rewrite without #ifdefs
Date: Wed,  3 Jan 2024 00:12:36 +0000
Message-Id: <20240103001239.17482-17-andre.przywara@arm.com>
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

At the moment the SPL functions setting up the required pinmux for the
UART, NAND and MMC controllers make heavy use of #ifdefs, which are
sometimes even nested. This makes them hard to read, and more
importantly hard to extend.

Rewrite those functions with the help of IS_ENABLED(), to use proper C
"if" statements. For the I2C case, also split the function up into one
per I2C controller, to further simplify the code layout.

The MMC function gets further simplified, by replacing the repeated direct
calls to the GPIO functions with using variables, that describe a range of
pins to handle, including skipped pins and outliers. The actual pinmux
functions are then called from one place.

One part of the NAND clock setup relies on SoC specific struct members,
so that has to keep using #ifdefs, to avoid breaking compilation for
other SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/spl_pinmux.c | 434 +++++++++++++++----------------
 1 file changed, 210 insertions(+), 224 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_pinmux.c b/arch/arm/mach-sunxi/spl_pinmux.c
index 45cc2cfe2b1..18f8cd93b6a 100644
--- a/arch/arm/mach-sunxi/spl_pinmux.c
+++ b/arch/arm/mach-sunxi/spl_pinmux.c
@@ -17,95 +17,105 @@
 #include <asm/u-boot.h>
 #include <sunxi_gpio.h>
 
+static void i2c0_init_board(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN5I) ||
+	    IS_ENABLED(CONFIG_MACH_SUN7I) || IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN4I_GPB_TWI0);
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN4I_GPB_TWI0);
+		clock_twi_onoff(0, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN6I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(14), SUN6I_GPH_TWI0);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(15), SUN6I_GPH_TWI0);
+		clock_twi_onoff(0, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_V3S)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(6), SUN8I_V3S_GPB_TWI0);
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(7), SUN8I_V3S_GPB_TWI0);
+		clock_twi_onoff(0, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN8I_GPH_TWI0);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN8I_GPH_TWI0);
+		clock_twi_onoff(0, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN50I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_GPH_TWI0);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_GPH_TWI0);
+		clock_twi_onoff(0, 1);
+	}
+}
+
+static void i2c1_init_board(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN7I) ||
+	    IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(18), SUN4I_GPB_TWI1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(19), SUN4I_GPB_TWI1);
+		clock_twi_onoff(1, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN5I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(15), SUN5I_GPB_TWI1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPB(16), SUN5I_GPB_TWI1);
+		clock_twi_onoff(1, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN6I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
+		clock_twi_onoff(1, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
+		clock_twi_onoff(1, 1);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN50I)) {
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(2), SUN50I_GPH_TWI1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPH(3), SUN50I_GPH_TWI1);
+		clock_twi_onoff(1, 1);
+	}
+}
+
+static void i2cr_init_board(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN50I)) {
+		clock_twi_onoff(5, 1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN50I_H616)) {
+		clock_twi_onoff(5, 1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
+	} else {
+		clock_twi_onoff(5, 1);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
+		sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN8I_H3_GPL_R_TWI);
+	}
+}
+
 void i2c_init_board(void)
 {
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
-#endif /* CONFIG_I2C0_ENABLE */
+	if (IS_ENABLED(CONFIG_I2C0_ENABLE))
+		i2c0_init_board();
 
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
-#endif /* CONFIG_I2C1_ENABLE */
+	if (IS_ENABLED(CONFIG_I2C1_ENABLE))
+		i2c1_init_board();
 
-#ifdef CONFIG_R_I2C_ENABLE
-#ifdef CONFIG_MACH_SUN50I
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
-#elif defined(CONFIG_MACH_SUN50I_H616)
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
-#else
-	clock_twi_onoff(5, 1);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
-	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN8I_H3_GPL_R_TWI);
-#endif
-#endif /* CONFIG_R_I2C_ENABLE */
+	if (IS_ENABLED(CONFIG_R_I2C_ENABLE))
+		i2cr_init_board();
 }
 
 #if defined(CONFIG_NAND_SUNXI)
-static void nand_pinmux_setup(void)
+void nand_pinmux_setup(void)
 {
 	unsigned int pin;
 
 	for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(19); pin++)
 		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
 
-#if defined CONFIG_MACH_SUN4I || defined CONFIG_MACH_SUN7I
-	for (pin = SUNXI_GPC(20); pin <= SUNXI_GPC(22); pin++)
-		sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
-#endif
-	/* sun4i / sun7i do have a PC23, but it is not used for nand,
-	 * only sun7i has a PC24 */
-#ifdef CONFIG_MACH_SUN7I
-	sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_NAND);
-#endif
+	if (IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN7I)) {
+		for (pin = SUNXI_GPC(20); pin <= SUNXI_GPC(22); pin++)
+			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_NAND);
+	}
+	/*
+	 * sun4i / sun7i do have a PC23, but it is not used for NAND.
+	 * Only sun7i has a PC24.
+	 */
+	if (IS_ENABLED(CONFIG_MACH_SUN7I))
+		sunxi_gpio_set_cfgpin(SUNXI_GPC(24), SUNXI_GPC_NAND);
 }
 
 static void nand_clock_setup(void)
@@ -114,10 +124,12 @@ static void nand_clock_setup(void)
 		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
 
 	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
+
 #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
-    defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
+	defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
 	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
 #endif
+
 	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
 }
 
@@ -131,174 +143,149 @@ void board_nand_init(void)
 #ifdef CONFIG_MMC
 static void mmc_pinmux_setup(int sdc)
 {
-	unsigned int pin;
+	unsigned int pin, first_pin, last_pin, pin_mux;
+	unsigned int skip_pin = ~0, extra_pin = ~0;
 
 	switch (sdc) {
 	case 0:
 		/* SDC0: PF0-PF5 */
-		for (pin = SUNXI_GPF(0); pin <= SUNXI_GPF(5); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPF_SDC0);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
-		}
+		first_pin = SUNXI_GPF(0);
+		last_pin = SUNXI_GPF(5);
+		pin_mux = SUNXI_GPF_SDC0;
 		break;
-
 	case 1:
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-		if (IS_ENABLED(CONFIG_MMC1_PINS_PH)) {
-			/* SDC1: PH22-PH-27 */
-			for (pin = SUNXI_GPH(22); pin <= SUNXI_GPH(27); pin++) {
-				sunxi_gpio_set_cfgpin(pin, SUN4I_GPH_SDC1);
-				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-				sunxi_gpio_set_drv(pin, 2);
+		if (IS_ENABLED(CONFIG_MACH_SUN4I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN7I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+			if (IS_ENABLED(CONFIG_MMC1_PINS_PH)) {
+				/* SDC1: PH22-PH-27 */
+				first_pin = SUNXI_GPH(22);
+				last_pin = SUNXI_GPH(27);
+				pin_mux = SUN4I_GPH_SDC1;
+			} else {
+				/* SDC1: PG0-PG5 */
+				first_pin = SUNXI_GPG(0);
+				last_pin = SUNXI_GPG(5);
+				pin_mux = SUN4I_GPG_SDC1;
 			}
-		} else {
+		} else if (IS_ENABLED(CONFIG_MACH_SUN5I)) {
+			/* SDC1: PG3-PG8 */
+			first_pin = SUNXI_GPG(3);
+			last_pin = SUNXI_GPG(8);
+			pin_mux = SUN4I_GPG_SDC1;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN6I)) {
 			/* SDC1: PG0-PG5 */
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
+			first_pin = SUNXI_GPG(0);
+			last_pin = SUNXI_GPG(5);
+			pin_mux = SUN6I_GPG_SDC1;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN8I)) {
+			/* SDC1: PG0-PG5 */
+			first_pin = SUNXI_GPG(0);
+			last_pin = SUNXI_GPG(5);
+			pin_mux = SUN8I_GPG_SDC1;
 		}
-#endif
 		break;
-
 	case 2:
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
+		if (IS_ENABLED(CONFIG_MACH_SUN4I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN7I)) {
+			/* SDC2: PC6-PC11 */
+			first_pin = SUNXI_GPG(6);
+			last_pin = SUNXI_GPG(11);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN5I)) {
+			/* SDC2: PC6-PC15 */
+			first_pin = SUNXI_GPG(6);
+			last_pin = SUNXI_GPG(15);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN6I)) {
+			/* SDC2: PC6-PC15, PC24 */
+			first_pin = SUNXI_GPG(6);
+			last_pin = SUNXI_GPG(15);
+			extra_pin = SUNXI_GPC(24);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+			/* SDC2: PC6-PC15, PC24 */
+			first_pin = SUNXI_GPC(6);
+			last_pin = SUNXI_GPC(15);
+			extra_pin = SUNXI_GPC(24);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN8I) ||
+			   IS_ENABLED(CONFIG_MACH_SUN50I)) {
+			/* SDC2: PC5-PC6, PC8-PC16 */
+			first_pin = SUNXI_GPC(5);
+			last_pin = SUNXI_GPC(16);
+			skip_pin = SUNXI_GPC(7);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
+			/* SDC2: PC4-PC14 */
+			first_pin = SUNXI_GPC(4);
+			last_pin = SUNXI_GPC(14);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN50I_H616)) {
+			/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
+			first_pin = SUNXI_GPC(5);
+			last_pin = SUNXI_GPC(11);
+			skip_pin = SUNXI_GPC(7);
+			pin_mux = SUNXI_GPC_SDC2;
 
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
-		/* SDC2: PC2-PC7 */
-		for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
+			for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(1); pin++) {
+				sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+				sunxi_gpio_set_drv(pin, 3);
+			}
+			for (pin = SUNXI_GPC(13); pin <= SUNXI_GPC(16); pin++) {
+				sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
+				sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+				sunxi_gpio_set_drv(pin, 3);
+			}
+		} else if (IS_ENABLED(CONFIG_MACH_SUN9I)) {
+			/* SDC2: PC6-PC16 */
+			first_pin = SUNXI_GPC(6);
+			last_pin = SUNXI_GPC(16);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+			/* SDC2: PC2-PC7 */
+			first_pin = SUNXI_GPC(2);
+			last_pin = SUNXI_GPC(7);
+			pin_mux = SUNXI_GPC_SDC2;
+		} else {
+			puts("ERROR: No pinmux setup defined for MMC2!\n");
 		}
-#else
-		puts("ERROR: No pinmux setup defined for MMC2!\n");
-#endif
 		break;
-
 	case 3:
-#if defined(CONFIG_MACH_SUN4I) || defined(CONFIG_MACH_SUN7I) || \
-    defined(CONFIG_MACH_SUN8I_R40)
-		/* SDC3: PI4-PI9 */
-		for (pin = SUNXI_GPI(4); pin <= SUNXI_GPI(9); pin++) {
-			sunxi_gpio_set_cfgpin(pin, SUNXI_GPI_SDC3);
-			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
-			sunxi_gpio_set_drv(pin, 2);
+		if (IS_ENABLED(CONFIG_MACH_SUN4I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN7I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+			/* SDC3: PI4-PI9 */
+			first_pin = SUNXI_GPI(4);
+			last_pin = SUNXI_GPI(9);
+			pin_mux = SUNXI_GPI_SDC3;
+		} else if (IS_ENABLED(CONFIG_MACH_SUN6I)) {
+			/* SDC3: PC6-PC15, PC24 */
+			first_pin = SUNXI_GPC(6);
+			last_pin = SUNXI_GPC(15);
+			extra_pin = SUNXI_GPC(24);
+			pin_mux = SUN6I_GPC_SDC3;
 		}
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
 		break;
 
 	default:
 		printf("sunxi: invalid MMC slot %d for pinmux setup\n", sdc);
 		break;
 	}
+
+	for (pin = first_pin; pin <= last_pin; pin++) {
+		if (pin == skip_pin)
+			continue;
+		sunxi_gpio_set_cfgpin(pin, pin_mux);
+		sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+		sunxi_gpio_set_drv(pin, 2);
+	}
+	if (extra_pin != ~0) {
+		sunxi_gpio_set_cfgpin(extra_pin, pin_mux);
+		sunxi_gpio_set_pull(extra_pin, SUNXI_GPIO_PULL_UP);
+		sunxi_gpio_set_drv(extra_pin, 2);
+	}
 }
 
 int board_mmc_init(struct bd_info *bis)
@@ -322,5 +309,4 @@ int board_mmc_init(struct bd_info *bis)
 
 	return 0;
 }
-
 #endif /* CONFIG_MMC */
-- 
2.35.8

