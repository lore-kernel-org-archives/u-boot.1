Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA7E743C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B02B86E9E;
	Thu, 28 Sep 2023 23:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4358386EA2; Thu, 28 Sep 2023 23:56:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AA78286E98
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4021EDA7;
 Thu, 28 Sep 2023 14:57:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C2B3F59C;
 Thu, 28 Sep 2023 14:56:20 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 10/22] sunxi: introduce NCAT2 generation model
Date: Thu, 28 Sep 2023 22:54:43 +0100
Message-Id: <20230928215455.28094-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

Allwinner seems to typically stick to a common MMIO memory map for
several SoCs, but from time to time does some breaking changes, which
also introduce new generations of some peripherals. The last time this
happened with the H6, which apart from re-organising the base addresses
also changed the clock controller significantly. We added a
CONFIG_SUN50I_GEN_H6 symbol back then to mark SoCs sharing those traits.

Now the Allwinner D1 changes the memory map again, and also extends the
pincontroller, among other peripherals.
To mark this generation of SoCs, add a CONFIG_SUNXI_GEN_NCAT2 symbol,
this name is reportedly used in the Allwinner BSP code, and prevents us
from inventing our own name.

Add this new symbol to some guards that were already checking for the H6
generation, since many features are shared between the two (like the
renovated clock controller).

This paves the way to introduce a first user of this generation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/clock.h       |  2 +-
 arch/arm/include/asm/arch-sunxi/cpu.h         |  2 +
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  | 43 +++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/mmc.h         |  2 +-
 arch/arm/include/asm/arch-sunxi/prcm.h        |  2 +-
 arch/arm/include/asm/arch-sunxi/timer.h       |  2 +-
 arch/arm/mach-sunxi/Kconfig                   | 12 +++++-
 arch/arm/mach-sunxi/Makefile                  |  1 +
 arch/arm/mach-sunxi/board.c                   | 22 ++++++----
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  7 ++-
 common/spl/Kconfig                            |  2 +-
 drivers/i2c/mvtwsi.c                          |  3 +-
 drivers/mmc/sunxi_mmc.c                       |  7 +--
 include/sunxi_gpio.h                          |  3 ++
 14 files changed, 90 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h

diff --git a/arch/arm/include/asm/arch-sunxi/clock.h b/arch/arm/include/asm/arch-sunxi/clock.h
index 2cfd5407423..3d34261b0e5 100644
--- a/arch/arm/include/asm/arch-sunxi/clock.h
+++ b/arch/arm/include/asm/arch-sunxi/clock.h
@@ -16,7 +16,7 @@
 /* clock control module regs definition */
 #if defined(CONFIG_MACH_SUN8I_A83T)
 #include <asm/arch/clock_sun8i_a83t.h>
-#elif defined(CONFIG_SUN50I_GEN_H6)
+#elif defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #include <asm/arch/clock_sun50i_h6.h>
 #elif defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN8I) || \
       defined(CONFIG_MACH_SUN50I) || defined(CONFIG_MACH_SUNIV)
diff --git a/arch/arm/include/asm/arch-sunxi/cpu.h b/arch/arm/include/asm/arch-sunxi/cpu.h
index b08f2023748..768c6572d6b 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu.h
@@ -10,6 +10,8 @@
 #include <asm/arch/cpu_sun9i.h>
 #elif defined(CONFIG_SUN50I_GEN_H6)
 #include <asm/arch/cpu_sun50i_h6.h>
+#elif defined(CONFIG_SUNXI_GEN_NCAT2)
+#include <asm/arch/cpu_sunxi_ncat2.h>
 #else
 #include <asm/arch/cpu_sun4i.h>
 #endif
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
new file mode 100644
index 00000000000..ca92c39927d
--- /dev/null
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -0,0 +1,43 @@
+/*
+ * (C) Copyright 2022 Arm Limited
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#ifndef _SUNXI_CPU_SUNXI_NCAT2_H
+#define _SUNXI_CPU_SUNXI_NCAT2_H
+
+#define SUNXI_CCM_BASE			0x02001000
+#define SUNXI_TIMER_BASE		0x02050000
+
+#define SUNXI_UART0_BASE		0x02500000
+#define SUNXI_UART1_BASE		0x02500400
+#define SUNXI_UART2_BASE		0x02500800
+#define SUNXI_UART3_BASE		0x02500C00
+#define SUNXI_TWI0_BASE			0x02502000
+#define SUNXI_TWI1_BASE			0x02502400
+#define SUNXI_TWI2_BASE			0x02502800
+#define SUNXI_TWI3_BASE			0x02502C00
+
+#define SUNXI_SRAMC_BASE		0x03000000
+/* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
+#define SUNXI_SIDC_BASE			0x03006000
+#define SUNXI_SID_BASE			0x03006200
+#define SUNXI_GIC400_BASE		0x03020000
+
+#define SUNXI_MMC0_BASE			0x04020000
+#define SUNXI_MMC1_BASE			0x04021000
+#define SUNXI_MMC2_BASE			0x04022000
+
+#define SUNXI_R_CPUCFG_BASE		0x07000400
+#define SUNXI_PRCM_BASE			0x07010000
+
+#define SUNXI_CPUCFG_BASE		0x09010000
+
+#ifndef __ASSEMBLY__
+void sunxi_board_init(void);
+void sunxi_reset(void);
+int sunxi_get_sid(unsigned int *sid);
+#endif
+
+#endif /* _SUNXI_CPU_SUNXI_NCAT2_H */
diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/asm/arch-sunxi/mmc.h
index 5daacf10eb1..8ed3e0459c9 100644
--- a/arch/arm/include/asm/arch-sunxi/mmc.h
+++ b/arch/arm/include/asm/arch-sunxi/mmc.h
@@ -45,7 +45,7 @@ struct sunxi_mmc {
 	u32 chda;		/* 0x90 */
 	u32 cbda;		/* 0x94 */
 	u32 res2[26];
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 	u32 res3[17];
 	u32 samp_dl;
 	u32 res4[46];
diff --git a/arch/arm/include/asm/arch-sunxi/prcm.h b/arch/arm/include/asm/arch-sunxi/prcm.h
index 5106076f5e9..c5418cfd28d 100644
--- a/arch/arm/include/asm/arch-sunxi/prcm.h
+++ b/arch/arm/include/asm/arch-sunxi/prcm.h
@@ -9,7 +9,7 @@
 #define _SUNXI_PRCM_H
 
 /* prcm regs definition */
-#if defined(CONFIG_SUN50I_GEN_H6)
+#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #include <asm/arch/prcm_sun50i.h>
 #else
 #include <asm/arch/prcm_sun6i.h>
diff --git a/arch/arm/include/asm/arch-sunxi/timer.h b/arch/arm/include/asm/arch-sunxi/timer.h
index bb5626d893b..e17db8588e2 100644
--- a/arch/arm/include/asm/arch-sunxi/timer.h
+++ b/arch/arm/include/asm/arch-sunxi/timer.h
@@ -76,7 +76,7 @@ struct sunxi_timer_reg {
 	struct sunxi_tgp tgp[4];
 	u8 res5[8];
 	u32 cpu_cfg;
-#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
+#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 	u8 res3[16];
 	struct sunxi_wdog wdog[5];	/* We have 5 watchdogs */
 #endif
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d73c5e67050..12eb51b2ea4 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -121,7 +121,7 @@ config AXP_PMIC_BUS
 config SUNXI_SRAM_ADDRESS
 	hex
 	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
-	default 0x20000 if SUN50I_GEN_H6
+	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
 	---help---
 	Older Allwinner SoCs have their mask boot ROM mapped just below 4GB,
@@ -189,6 +189,14 @@ config SUN50I_GEN_H6
 	Select this for sunxi SoCs which have H6 like peripherals, clocks
 	and memory map.
 
+config SUNXI_GEN_NCAT2
+	bool
+	select MMC_SUNXI_HAS_NEW_MODE
+	select SUPPORT_SPL
+	---help---
+	Select this for sunxi SoCs which have D1 like peripherals, clocks
+	and memory map.
+
 config SUNXI_DRAM_DW
 	bool
 	---help---
@@ -810,6 +818,7 @@ config VIDEO_SUNXI
 	depends on !MACH_SUN9I
 	depends on !MACH_SUN50I
 	depends on !SUN50I_GEN_H6
+	depends on !SUNXI_GEN_NCAT2
 	select VIDEO
 	select DISPLAY
 	imply VIDEO_DT_SIMPLEFB
@@ -1023,6 +1032,7 @@ config SPL_STACK_R_ADDR
 	default 0x2fe00000 if MACH_SUN9I
 	default 0x4fe00000 if MACH_SUN50I
 	default 0x4fe00000 if SUN50I_GEN_H6
+	default 0x4fe00000 if SUNXI_GEN_NCAT2
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 671211e9322..1d4c70ec352 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MACH_SUN8I)	+= clock_sun6i.o
 endif
 obj-$(CONFIG_MACH_SUN9I)	+= clock_sun9i.o gtbus_sun9i.o
 obj-$(CONFIG_SUN50I_GEN_H6)	+= clock_sun50i_h6.o
+obj-$(CONFIG_SUNXI_GEN_NCAT2)	+= clock_sun50i_h6.o
 ifndef CONFIG_ARM64
 obj-y	+= timer.o
 endif
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 4a1a0eacdba..d572314f0da 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -176,13 +176,19 @@ static int gpio_init(void)
 #error Unsupported console port number. Please fix pin mux settings in board.c
 #endif
 
-#ifdef CONFIG_SUN50I_GEN_H6
-	/* Update PIO power bias configuration by copy hardware detected value */
-	val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
-	writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
-	val = readl(SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
-	writel(val, SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
-#endif
+	/*
+	 * Update PIO power bias configuration by copying the hardware
+	 * detected value.
+	 */
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
+		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
+		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
+	}
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {
+		val = readl(SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
+		writel(val, SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
+	}
 
 	return 0;
 }
@@ -481,7 +487,7 @@ void reset_cpu(void)
 		/* sun5i sometimes gets stuck without this */
 		writel(WDT_MODE_RESET_EN | WDT_MODE_EN, &wdog->mode);
 	}
-#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
+#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #if defined(CONFIG_MACH_SUN50I_H6)
 	/* WDOG is broken for some H6 rev. use the R_WDOG instead */
 	static const struct sunxi_wdog *wdog =
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 7926394cf76..767a39fa2ab 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -18,8 +18,11 @@ void clock_init_safe(void)
 		setbits_le32(&prcm->res_cal_ctrl, 2);
 	}
 
-	clrbits_le32(&prcm->res_cal_ctrl, 1);
-	setbits_le32(&prcm->res_cal_ctrl, 1);
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
+	    IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
+		clrbits_le32(&prcm->res_cal_ctrl, 1);
+		setbits_le32(&prcm->res_cal_ctrl, 1);
+	}
 
 	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
 		/* set key field for ldo enable */
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 1c2fe78e3e0..cd59b9240c2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -265,7 +265,7 @@ config SPL_TEXT_BASE
 	default 0x402F0400 if AM33XX
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
-	default 0x20060 if SUN50I_GEN_H6
+	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x00060 if ARCH_SUNXI
 	default 0xfffc0000 if ARCH_ZYNQMP
 	default 0x0
diff --git a/drivers/i2c/mvtwsi.c b/drivers/i2c/mvtwsi.c
index 14cdb0f6635..c38330f758a 100644
--- a/drivers/i2c/mvtwsi.c
+++ b/drivers/i2c/mvtwsi.c
@@ -124,7 +124,8 @@ enum mvtwsi_ctrl_register_fields {
  * on other platforms, it is a normal r/w bit, which is cleared by writing 0.
  */
 
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || \
+    defined(CONFIG_SUNXI_GEN_NCAT2)
 #define	MVTWSI_CONTROL_CLEAR_IFLG	0x00000008
 #else
 #define	MVTWSI_CONTROL_CLEAR_IFLG	0x00000000
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 03e33753fcf..519ef602145 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -57,6 +57,7 @@ static bool sunxi_mmc_can_calibrate(void)
 	return IS_ENABLED(CONFIG_MACH_SUN50I) ||
 	       IS_ENABLED(CONFIG_MACH_SUN50I_H5) ||
 	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
 	       IS_ENABLED(CONFIG_MACH_SUN8I_R40);
 }
 
@@ -191,7 +192,7 @@ static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 	rval &= ~SUNXI_MMC_CLK_DIVIDER_MASK;
 	writel(rval, &priv->reg->clkcr);
 
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 	/* A64 supports calibration of delays on MMC controller and we
 	 * have to set delay of zero before starting calibration.
 	 * Allwinner BSP driver sets a delay only in the case of
@@ -544,7 +545,7 @@ struct mmc *sunxi_mmc_init(int sdc_no)
 
 	/* config ahb clock */
 	debug("init mmc %d clock and io\n", sdc_no);
-#if !defined(CONFIG_SUN50I_GEN_H6)
+#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
 	setbits_le32(&ccm->ahb_gate0, 1 << AHB_GATE_OFFSET_MMC(sdc_no));
 
 #ifdef CONFIG_SUNXI_GEN_SUN6I
@@ -619,7 +620,7 @@ static unsigned get_mclk_offset(void)
 	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
 		return 0x410;
 
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		return 0x830;
 
 	return 0x88;
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 30d8879dbd3..db3742c0397 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -19,6 +19,9 @@
 #elif defined(CONFIG_SUN50I_GEN_H6)
 #define SUNXI_PIO_BASE		0x0300b000
 #define SUNXI_R_PIO_BASE	0x07022000
+#elif defined(CONFIG_SUNXI_GEN_NCAT2)
+#define SUNXI_PIO_BASE		0x02000000
+#define SUNXI_R_PIO_BASE	0x07022000
 #else
 #define SUNXI_PIO_BASE		0x01c20800
 #define SUNXI_R_PIO_BASE	0x01f02c00
-- 
2.35.8

