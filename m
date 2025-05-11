Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74731C3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 01:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 008F4829A0;
	Sun, 11 May 2025 03:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9CD380F54; Sun, 11 May 2025 03:10:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6BC0B826AA
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 03:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AC62682;
 Sat, 10 May 2025 18:10:03 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48143F58B;
 Sat, 10 May 2025 18:10:13 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/6] sunxi: add support for the Allwinner A100/A133 SoC
Date: Sun, 11 May 2025 02:09:59 +0100
Message-ID: <20250511011003.15654-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250511011003.15654-1-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
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

The Allwinner A100 SoC has been around for a while, mostly on cheap
tablets, but didn't generate much interest in the community so far.
There were some efforts by two Allwinner employees in 2020, which led
to basic upstream Linux support for that SoC, although this momentum
dried up pretty quickly, leaving a lot of peripherals unsupported.

The A100 was silently replaced with the seemingly identical Allwinner
A133, which is reportedly a better bin of the A100. So far we assume
that both are compatible from a software perspective. There are some
more devices with the A133 out there now, so people are working on
filling the gaps, and adding U-Boot (and TF-A) support.

Based on the just added pinctrl, clock and DRAM support, this adds the
missing bits, mostly addresses and values for the SPL.

The A133 seems to be an predecessor to the H6, so we can share a lot of
code with that (and the H616 code), and just need to adjust some details.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv8/fel_utils.S                    |  2 +-
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  7 +++++++
 arch/arm/mach-sunxi/Kconfig                       | 10 ++++++++--
 arch/arm/mach-sunxi/board.c                       |  4 ++++
 arch/arm/mach-sunxi/clock_sun50i_h6.c             |  3 ++-
 arch/arm/mach-sunxi/cpu_info.c                    |  2 ++
 board/sunxi/board.c                               |  4 ++--
 common/spl/Kconfig                                |  4 ++--
 8 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
index 044a7c16cc5..6a7ec9a7ec1 100644
--- a/arch/arm/cpu/armv8/fel_utils.S
+++ b/arch/arm/cpu/armv8/fel_utils.S
@@ -41,7 +41,7 @@ ENTRY(return_to_fel)
 	str	w2, [x1]
 
 	ldr	w0, =0xfa50392f		// CPU hotplug magic
-#ifdef CONFIG_MACH_SUN50I_H616
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133)
 	ldr	w2, =(SUNXI_R_CPUCFG_BASE + 0x1c0)
 	str	w0, [x2], #0x4
 #elif CONFIG_MACH_SUN50I_H6
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index ccacc99d018..575dff68804 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -90,6 +90,13 @@
 #define CCM_PLL6_DEFAULT		0xe8216300
 #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
 #define CCM_APB1_DEFAULT		0x03000102
+
+#elif CONFIG_MACH_SUN50I_A133				/* A133 */
+
+#define CCM_PLL6_DEFAULT		0xb8003100
+#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
+#define CCM_AHB3_DEFAULT		0x03000002
+#define CCM_APB1_DEFAULT		0x03000102
 #endif
 
 /* apb2 bit field */
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 98b947f6e33..fc9253fff28 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -220,6 +220,7 @@ config SUNXI_SRAM_ADDRESS
 config SUNXI_RVBAR_ADDRESS
 	hex
 	depends on ARM64
+	default 0x08100040 if MACH_SUN50I_A133
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
 	---help---
@@ -246,8 +247,8 @@ config SUNXI_RVBAR_ALTERNATIVE
 config SUNXI_BL31_BASE
 	hex
 	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
-	default 0x00104000 if MACH_SUN50I_H6
 	default 0x40000000 if MACH_SUN50I_H616
+	default 0x00104000 if SUN50I_GEN_H6
 	default 0x0
 	help
 	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
@@ -329,7 +330,7 @@ config MACH_SUNXI_H3_H5
 # TODO: try out A80's 8GiB DRAM space
 config SUNXI_DRAM_MAX_SIZE
 	hex
-	default 0x100000000 if MACH_SUN50I_H616
+	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
 	default 0x80000000
 
@@ -529,6 +530,10 @@ config MACH_SUN50I_H616
 
 config MACH_SUN50I_A133
 	bool "sun50i (Allwinner A133)"
+	select ARM64
+	select DRAM_SUN50I_A133
+	select SUN50I_GEN_H6
+	imply OF_UPSTREAM
 
 endchoice
 
@@ -824,6 +829,7 @@ config SYS_CONFIG_NAME
 	default "sun50i" if MACH_SUN50I
 	default "sun50i" if MACH_SUN50I_H6
 	default "sun50i" if MACH_SUN50I_H616
+	default "sun50i" if MACH_SUN50I_A133
 
 config SYS_BOARD
 	default "sunxi"
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index b1bf51f40c5..08d55b3a0e3 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -137,6 +137,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN50I_A133)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_H616_GPH_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN50I_H616_GPH_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_A83T)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 4c522f60810..3f375a51965 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -87,7 +87,8 @@ void clock_set_pll1(unsigned int clk)
 	/* clk = 24*n/p, p is ignored if clock is >288MHz */
 	val = CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
 	val |= CCM_PLL1_CTRL_N(clk / 24000000);
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
+	    IS_ENABLED(CONFIG_MACH_SUN50I_A133))
 	       val |= CCM_PLL1_OUT_EN;
 	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 	       val |= CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index 310dca06e57..3f4735d4717 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -104,6 +104,8 @@ int print_cpuinfo(void)
 	puts("CPU:   Allwinner H6 (SUN50I)\n");
 #elif defined CONFIG_MACH_SUN50I_H616
 	puts("CPU:   Allwinner H616 (SUN50I)\n");
+#elif defined CONFIG_MACH_SUN50I_A133
+	puts("CPU:   Allwinner A133 (SUN50I)\n");
 #else
 #warning Please update cpu_info.c with correct CPU information
 	puts("CPU:   SUNXI Family\n");
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ac9cefc6eac..d5568ea519e 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -114,7 +114,7 @@ void i2c_init_board(void)
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
-#elif CONFIG_MACH_SUN50I_H616
+#elif defined(CONFIG_MACH_SUN50I_H616)
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
@@ -435,7 +435,7 @@ static void mmc_pinmux_setup(int sdc)
 			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
 			sunxi_gpio_set_drv(pin, 2);
 		}
-#elif defined(CONFIG_MACH_SUN50I_H616)
+#elif defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133)
 		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
 		for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(16); pin++) {
 			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index b076f49ac00..590bdc3e8e4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -80,7 +80,7 @@ config SPL_MAX_SIZE
 	default 0x1b000 if AM33XX && !TI_SECURE_DEVICE
 	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
-	default 0xbfa0 if MACH_SUN50I_H616
+	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 0x7000 if RCAR_GEN3
 	default 0x5fa0 if SUNXI_SRAM_ADDRESS = 0x0
 	default 0x7fa0 if ARCH_SUNXI
@@ -416,7 +416,7 @@ config SPL_STACK
 	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x118000 if MACH_SUN50I_H6
 	default 0x52a00 if MACH_SUN50I_H616
-	default 0x40000 if MACH_SUN8I_R528
+	default 0x40000 if MACH_SUN8I_R528 || MACH_SUN50I_A133
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
-- 
2.46.3

