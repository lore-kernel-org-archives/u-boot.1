Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE6AC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18874820E2;
	Sun, 23 Mar 2025 12:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53ED281DDF; Sun, 23 Mar 2025 12:36:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E8D4A82045
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23A8E1595;
 Sun, 23 Mar 2025 04:36:58 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5AF3F694;
 Sun, 23 Mar 2025 04:36:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 32/34] sunxi: add basic A523 support
Date: Sun, 23 Mar 2025 11:35:42 +0000
Message-ID: <20250323113544.7933-33-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

Add the basic Kconfig options, addresses and other values for the
existing Kconfig settings for the new Allwinner A523/T527/H728 SoC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv8/fel_utils.S |  4 ++--
 arch/arm/mach-sunxi/Kconfig    | 20 ++++++++++++++++++--
 arch/arm/mach-sunxi/board.c    |  5 +++++
 arch/arm/mach-sunxi/cpu_info.c |  2 ++
 board/sunxi/board.c            |  6 +++++-
 common/spl/Kconfig             |  4 +++-
 include/configs/sun55i.h       | 11 +++++++++++
 7 files changed, 46 insertions(+), 6 deletions(-)
 create mode 100644 include/configs/sun55i.h

diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
index 044a7c16cc5..290f83953ad 100644
--- a/arch/arm/cpu/armv8/fel_utils.S
+++ b/arch/arm/cpu/armv8/fel_utils.S
@@ -41,10 +41,10 @@ ENTRY(return_to_fel)
 	str	w2, [x1]
 
 	ldr	w0, =0xfa50392f		// CPU hotplug magic
-#ifdef CONFIG_MACH_SUN50I_H616
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN55I_A523)
 	ldr	w2, =(SUNXI_R_CPUCFG_BASE + 0x1c0)
 	str	w0, [x2], #0x4
-#elif CONFIG_MACH_SUN50I_H6
+#elif defined(CONFIG_MACH_SUN50I_H6)
 	ldr	w2, =(SUNXI_RTC_BASE + 0x1b8)	// BOOT_CPU_HP_FLAG_REG
 	str	w0, [x2], #0x4
 #else
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 345e685fc4b..69353a04f14 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -160,6 +160,7 @@ config AXP_PMIC_BUS
 config SUNXI_SRAM_ADDRESS
 	hex
 	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
+	default 0x44000 if MACH_SUN55I_A523
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
 	---help---
@@ -171,6 +172,7 @@ config SUNXI_SRAM_ADDRESS
 config SUNXI_RVBAR_ADDRESS
 	hex
 	depends on ARM64
+	default 0x08000040 if MACH_SUN55I_A523
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
 	---help---
@@ -199,6 +201,7 @@ config SUNXI_BL31_BASE
 	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x00104000 if MACH_SUN50I_H6
 	default 0x40000000 if MACH_SUN50I_H616
+	default 0x00054000 if MACH_SUN55I_A523
 	default 0x0
 	help
 	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
@@ -280,7 +283,7 @@ config MACH_SUNXI_H3_H5
 # TODO: try out A80's 8GiB DRAM space
 config SUNXI_DRAM_MAX_SIZE
 	hex
-	default 0x100000000 if MACH_SUN50I_H616
+	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN55I_A523
 	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
 	default 0x80000000
 
@@ -478,6 +481,15 @@ config MACH_SUN50I_H616
 config MACH_SUN50I_A133
 	bool "sun50i (Allwinner A133)"
 
+config MACH_SUN55I_A523
+	bool "sun55i (Allwinner A523/A527/T527/H728)"
+	select ARM64
+	select SUNXI_GEN_NCAT2
+	select SUNXI_NEW_PINCTRL
+	select DRAM_SUN55I_A523
+	select FIT
+	select SPL_LOAD_FIT if SPL
+
 endchoice
 
 # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
@@ -649,6 +661,7 @@ endif
 config DRAM_ZQ
 	int "sunxi dram zq value"
 	depends on !MACH_SUN50I_H616
+	depends on !MACH_SUN55I_A523
 	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
 		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
 	default 127 if MACH_SUN7I
@@ -662,6 +675,7 @@ config DRAM_ZQ
 config DRAM_ODT_EN
 	bool "sunxi dram odt enable"
 	depends on !MACH_SUN50I_H616
+	depends on !MACH_SUN55I_A523
 	default y if MACH_SUN8I_A23
 	default y if MACH_SUNXI_H3_H5
 	default y if MACH_SUN8I_R40
@@ -751,6 +765,7 @@ endif
 
 config SYS_CLK_FREQ
 	default 408000000 if MACH_SUNIV
+	default 792000000 if MACH_SUN55I_A523
 	default 816000000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 888000000 if MACH_SUN50I_H6
 	default 912000000 if MACH_SUN7I
@@ -768,6 +783,7 @@ config SYS_CONFIG_NAME
 	default "sun50i" if MACH_SUN50I
 	default "sun50i" if MACH_SUN50I_H6
 	default "sun50i" if MACH_SUN50I_H616
+	default "sun55i" if MACH_SUN55I_A523
 
 config SYS_BOARD
 	default "sunxi"
@@ -877,7 +893,7 @@ config I2C1_ENABLE
 	---help---
 	See I2C0_ENABLE help text.
 
-if SUNXI_GEN_SUN6I || SUN50I_GEN_H6
+if SUNXI_GEN_SUN6I || SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 config R_I2C_ENABLE
 	bool "Enable the PRCM I2C/TWI controller"
 	# This is used for the pmic on H3
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 06a4a79146f..a75159cf2af 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -137,6 +137,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN55I_A523)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), 2);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), 2);
+	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A83T)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
@@ -193,6 +197,7 @@ static int gpio_init(void)
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
 	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
 		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
+		/* TODO: A523: keep only the lower two bits? */
 		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
 	}
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index 310dca06e57..a52adf9ce7f 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -104,6 +104,8 @@ int print_cpuinfo(void)
 	puts("CPU:   Allwinner H6 (SUN50I)\n");
 #elif defined CONFIG_MACH_SUN50I_H616
 	puts("CPU:   Allwinner H616 (SUN50I)\n");
+#elif defined CONFIG_MACH_SUN55I_A523
+	puts("CPU:   Allwinner A523 (SUN55I)\n");
 #else
 #warning Please update cpu_info.c with correct CPU information
 	puts("CPU:   SUNXI Family\n");
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ac9cefc6eac..bf4f2088714 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -118,6 +118,10 @@ void i2c_init_board(void)
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
+#elif CONFIG_MACH_SUN55I_A523
+	clock_twi_onoff(5, 1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_GPL_R_TWI);
+	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_GPL_R_TWI);
 #else
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
@@ -435,7 +439,7 @@ static void mmc_pinmux_setup(int sdc)
 			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
 			sunxi_gpio_set_drv(pin, 2);
 		}
-#elif defined(CONFIG_MACH_SUN50I_H616)
+#elif defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN55I_A523)
 		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
 		for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(16); pin++) {
 			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 29d30f5040d..51cb6d85580 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -80,7 +80,7 @@ config SPL_MAX_SIZE
 	default 0x1b000 if AM33XX && !TI_SECURE_DEVICE
 	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
-	default 0xbfa0 if MACH_SUN50I_H616
+	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN55I_A523
 	default 0x7000 if RCAR_GEN3
 	default 0x5fa0 if SUNXI_SRAM_ADDRESS = 0x0
 	default 0x7fa0 if ARCH_SUNXI
@@ -274,6 +274,7 @@ config SPL_TEXT_BASE
 	default 0x00912000 if ARCH_MX7
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
+	default 0x44060 if MACH_SUN55I_A523
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x00060 if ARCH_SUNXI
 	default 0xfffc0000 if ARCH_ZYNQMP
@@ -396,6 +397,7 @@ config SPL_STACK
 	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x118000 if MACH_SUN50I_H6
 	default 0x52a00 if MACH_SUN50I_H616
+	default 0x44000 if MACH_SUN55I_A523
 	default 0x40000 if MACH_SUN8I_R528
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
diff --git a/include/configs/sun55i.h b/include/configs/sun55i.h
new file mode 100644
index 00000000000..70649366c1c
--- /dev/null
+++ b/include/configs/sun55i.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Placeholder wrapper to allow addressing Allwinner devices with Cortex-A55
+ * cores separately. Please do not add anything in here.
+ */
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/sunxi-common.h>
+
+#endif /* __CONFIG_H */
-- 
2.46.3

