Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B810C5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C42982AE1;
	Sun,  1 Jun 2025 19:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597D9829F5; Sun,  1 Jun 2025 17:41:42 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BD182103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 636B11F0004D
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:41:39 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id C50CFAC32ED; Sun,  1 Jun 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id CCD17AC32DD;
 Sun,  1 Jun 2025 15:39:59 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 3/6] sunxi: Split V3/S3 support from V3s
Date: Sun,  1 Jun 2025 17:39:40 +0200
Message-ID: <20250601153943.2690123-4-contact@paulk.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601153943.2690123-1-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Jun 2025 19:14:22 +0200
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

There are significant differences between the V3 and V3s that are relevant
for U-Boot support: a different DRAM driver, AXP209 support and extra UART1
pins.

To avoid overwriting V3s defaults that do not apply to V3 in board configs,
split off V3/S3 support as a separate MACH and pick-up all relevant
V3s-specific choices with it.

Also update the pinecube config to reflect the updated config options.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/dts/Makefile                       |  5 ++--
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h |  1 +
 arch/arm/mach-sunxi/Kconfig                 | 27 ++++++++++++++++-----
 arch/arm/mach-sunxi/board.c                 |  3 ++-
 arch/arm/mach-sunxi/cpu_info.c              |  2 ++
 arch/arm/mach-sunxi/dram_sunxi_dw.c         |  4 +--
 arch/arm/mach-sunxi/spl_spi_sunxi.c         |  1 +
 board/sunxi/board.c                         |  2 +-
 configs/pinecube_defconfig                  |  4 +--
 drivers/clk/sunxi/Kconfig                   |  2 +-
 drivers/phy/allwinner/Kconfig               |  2 +-
 drivers/pinctrl/sunxi/Kconfig               |  2 +-
 drivers/power/Kconfig                       |  4 +--
 13 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index be6867ceae0e..ba57284cda8a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -646,10 +646,11 @@ dtb-$(CONFIG_MACH_SUN8I_R40) += \
 	sun8i-r40-oka40i-c.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
-dtb-$(CONFIG_MACH_SUN8I_V3S) += \
+dtb-$(CONFIG_MACH_SUN8I_V3) += \
 	sun8i-s3-elimo-initium.dtb \
 	sun8i-s3-pinecube.dtb \
-	sun8i-v3-sl631-imx179.dtb \
+	sun8i-v3-sl631-imx179.dtb
+dtb-$(CONFIG_MACH_SUN8I_V3S) += \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb
 dtb-$(CONFIG_MACH_SUN8I_R528) += \
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
index f023a4cfd934..4863220d89bc 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
@@ -13,6 +13,7 @@
 
 #if defined(CONFIG_SUNXI_GEN_SUN6I) && \
     !defined(CONFIG_MACH_SUN8I_R40) && \
+    !defined(CONFIG_MACH_SUN8I_V3) && \
     !defined(CONFIG_MACH_SUN8I_V3S)
 #define SUNXI_SRAM_A2_BASE		0x00040000
 #ifdef CONFIG_MACH_SUN8I_H3
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 8b43fd176dc0..742ec17f9767 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -400,8 +400,20 @@ config MACH_SUN8I_R528
 	select SUPPORT_SPL
 	select DRAM_SUN20I_D1
 
+config MACH_SUN8I_V3
+	bool "sun8i (Allwinner V3/S3)"
+	select CPU_V7A
+	select CPU_V7_HAS_NONSEC
+	select CPU_V7_HAS_VIRT
+	select ARCH_SUPPORT_PSCI
+	select SUNXI_GEN_SUN6I
+	select SUNXI_DRAM_DW
+	select SUNXI_DRAM_DW_16BIT
+	select SUPPORT_SPL
+	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
+
 config MACH_SUN8I_V3S
-	bool "sun8i (Allwinner V3/V3s/S3/S3L)"
+	bool "sun8i (Allwinner V3s)"
 	select CPU_V7A
 	select CPU_V7_HAS_NONSEC
 	select CPU_V7_HAS_VIRT
@@ -472,6 +484,7 @@ config MACH_SUN8I
 	default y if MACH_SUN8I_A83T
 	default y if MACH_SUNXI_H3_H5
 	default y if MACH_SUN8I_R40
+	default y if MACH_SUN8I_V3
 	default y if MACH_SUN8I_V3S
 
 config RESERVE_ALLWINNER_BOOT0_HEADER
@@ -592,7 +605,7 @@ config DRAM_CLK
 	default 792 if MACH_SUN9I
 	default 648 if MACH_SUN8I_R40
 	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
-		       MACH_SUN8I_V3S
+		       MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	default 312 if MACH_SUN6I || MACH_SUN8I
 	default 672 if MACH_SUN50I
 	default 744 if MACH_SUN50I_H6
@@ -617,7 +630,7 @@ config DRAM_ZQ
 	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
 		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
 	default 127 if MACH_SUN7I
-	default 14779 if MACH_SUN8I_V3S
+	default 14779 if MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	default 3881979 if MACH_SUNXI_H3_H5 || MACH_SUN8I_R40 || MACH_SUN50I_H6
 	default 4145117 if MACH_SUN9I
 	default 3881915 if MACH_SUN50I
@@ -743,7 +756,7 @@ config SYS_SOC
 config SUNXI_MINIMUM_DRAM_MB
 	int "minimum DRAM size"
 	default 32 if MACH_SUNIV
-	default 64 if MACH_SUN8I_V3S
+	default 64 if MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	default 256
 	---help---
 	Minimum DRAM size expected on the board. Traditionally we assumed
@@ -784,7 +797,8 @@ config MMC_SUNXI_SLOT_EXTRA
 
 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
-	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
+	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
+		     MACH_SUN8I_R40 || MACH_SUN8I_V3
 	default n if MACH_SUN6I || MACH_SUN8I
 	select CMD_I2C
 	---help---
@@ -829,6 +843,7 @@ config VIDEO_SUNXI
 	depends on !MACH_SUN8I_A83T
 	depends on !MACH_SUNXI_H3_H5
 	depends on !MACH_SUN8I_R40
+	depends on !MACH_SUN8I_V3
 	depends on !MACH_SUN8I_V3S
 	depends on !MACH_SUN9I
 	depends on !MACH_SUN50I
@@ -1052,7 +1067,7 @@ config SPL_STACK_R_ADDR
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3 || MACH_SUN8I_V3S || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
 	help
 	  Enable support for SPI Flash. This option allows SPL to read from
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index b1bf51f40c5c..1b721791635e 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -141,7 +141,8 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_V3S)
+#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN8I_V3) || \
+				 defined(CONFIG_MACH_SUN8I_V3S))
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index 310dca06e57e..1c6ef4b402fa 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -90,6 +90,8 @@ int print_cpuinfo(void)
 	printf("CPU:   Allwinner H3 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_R40
 	printf("CPU:   Allwinner R40 (SUN8I %04x)\n", sunxi_get_sram_id());
+#elif defined CONFIG_MACH_SUN8I_V3
+	printf("CPU:   Allwinner V3/S3 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_V3S
 	printf("CPU:   Allwinner V3s (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_R528
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 4ed295909ceb..bf89509107b2 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -851,7 +851,7 @@ unsigned long sunxi_dram_init(void)
 		.dx_read_delays  = SUN8I_H3_DX_READ_DELAYS,
 		.dx_write_delays = SUN8I_H3_DX_WRITE_DELAYS,
 		.ac_delays	 = SUN8I_H3_AC_DELAYS,
-#elif defined(CONFIG_MACH_SUN8I_V3S)
+#elif defined(CONFIG_MACH_SUN8I_V3) || defined(CONFIG_MACH_SUN8I_V3S)
 		.dx_read_delays  = SUN8I_V3S_DX_READ_DELAYS,
 		.dx_write_delays = SUN8I_V3S_DX_WRITE_DELAYS,
 		.ac_delays	 = SUN8I_V3S_AC_DELAYS,
@@ -878,7 +878,7 @@ unsigned long sunxi_dram_init(void)
 	uint16_t socid = SOCID_H3;
 #elif defined(CONFIG_MACH_SUN8I_R40)
 	uint16_t socid = SOCID_R40;
-#elif defined(CONFIG_MACH_SUN8I_V3S)
+#elif defined(CONFIG_MACH_SUN8I_V3) || defined(CONFIG_MACH_SUN8I_V3S)
 	uint16_t socid = SOCID_V3S;
 #elif defined(CONFIG_MACH_SUN50I)
 	uint16_t socid = SOCID_A64;
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 5f72e809952b..0e23bacdcaf0 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -141,6 +141,7 @@ static bool is_sun6i_gen_spi(void)
 	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
 	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
 	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
+	       IS_ENABLED(CONFIG_MACH_SUN8I_V3) ||
 	       IS_ENABLED(CONFIG_MACH_SUN8I_V3S);
 }
 
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ac9cefc6eac9..4f0ceb319f32 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -68,7 +68,7 @@ void i2c_init_board(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(14), SUN6I_GPH_TWI0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(15), SUN6I_GPH_TWI0);
 	clock_twi_onoff(0, 1);
-#elif defined(CONFIG_MACH_SUN8I_V3S)
+#elif defined(CONFIG_MACH_SUN8I_V3) || defined(CONFIG_MACH_SUN8I_V3S)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), SUN8I_V3S_GPB_TWI0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), SUN8I_V3S_GPB_TWI0);
 	clock_twi_onoff(0, 1);
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 7567a6aa7394..ea40d227bd53 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -2,11 +2,9 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun8i-s3-pinecube"
 CONFIG_SPL=y
-CONFIG_MACH_SUN8I_V3S=y
-CONFIG_SUNXI_DRAM_DDR3_1333=y
+CONFIG_MACH_SUN8I_V3=y
 CONFIG_DRAM_CLK=504
 CONFIG_DRAM_ODT_EN=y
-CONFIG_I2C0_ENABLE=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
 CONFIG_NO_NET=y
diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index f44db76c1823..620f330ea169 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -68,7 +68,7 @@ config CLK_SUN8I_R40
 
 config CLK_SUN8I_V3S
 	bool "Clock driver for Allwinner V3S"
-	default MACH_SUN8I_V3S
+	default MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	help
 	  This enables common clock driver support for platforms based
 	  on Allwinner V3S SoC.
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index bb0bd8d5f812..8b995bde041d 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -5,7 +5,7 @@ config PHY_SUN4I_USB
 	bool "Allwinner Sun4I USB PHY driver"
 	depends on ARCH_SUNXI
 	depends on !MACH_SUN9I
-	default n if MACH_SUN8I_V3S
+	default n if MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	default y
 	select DM_REGULATOR
 	select PHY
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 65e8192a99a1..1106102a5eae 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -76,7 +76,7 @@ config PINCTRL_SUN8I_H3_R
 
 config PINCTRL_SUN8I_V3S
 	bool "Support for the Allwinner V3s PIO"
-	default MACH_SUN8I_V3S
+	default MACH_SUN8I_V3 || MACH_SUN8I_V3S
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN9I_A80
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index eed65058e667..08369bf833e4 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -54,7 +54,7 @@ source "drivers/power/regulator/Kconfig"
 choice
 	prompt "Select Sunxi PMIC Variant"
 	depends on ARCH_SUNXI
-	default AXP209_POWER if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
+	default AXP209_POWER if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3
 	default AXP221_POWER if MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
 	default AXP818_POWER if MACH_SUN8I_A83T
 	default SUNXI_NO_PMIC if MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_V3S
@@ -75,7 +75,7 @@ config AXP152_POWER
 
 config AXP209_POWER
 	bool "axp209 pmic support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3S
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
 	---help---
-- 
2.49.0

