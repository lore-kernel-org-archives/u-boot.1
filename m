Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED69CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9BE87942;
	Mon, 23 Oct 2023 15:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE5F8794D; Mon, 23 Oct 2023 15:25:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 72DAD87942
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0007DFEC;
 Mon, 23 Oct 2023 06:26:09 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9899D3F762;
 Mon, 23 Oct 2023 06:25:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 17/24] sunxi: add Allwinner R528/T113 SoC support
Date: Mon, 23 Oct 2023 14:24:42 +0100
Message-Id: <20231023132449.813863-18-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

This adds the remaining code bits to teach U-Boot about Allwinner's
newest SoC generation. This was introduced with the RISC-V based
Allwinner D1 SoC, which actually shares a die with the ARM cores versions
called R528 (BGA, without DRAM) and T113s (QFP, with embedded DRAM).

This adds the new Kconfig stanza, using the two newly introduced symbols
for the new SoC generation and pincontroller. It also adds the new symbols
to the relavent code places, to set all the hardcoded bits directly.

We need one DT override:
The ARM core version of the DT specifies the CPUX watchdog as
"reserved", which means it won't be recognised by U-Boot. Override this
in our generic sunxi-u-boot.dtsi, to let U-Boot pick up this watchdog,
so that the generic reset driver will work.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/sunxi-u-boot.dtsi                    |  7 +++++++
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  9 +++++++--
 arch/arm/mach-sunxi/Kconfig                       | 11 +++++++++++
 arch/arm/mach-sunxi/board.c                       |  8 ++++++++
 arch/arm/mach-sunxi/clock_sun50i_h6.c             |  2 ++
 arch/arm/mach-sunxi/cpu_info.c                    |  2 ++
 common/spl/Kconfig                                |  1 +
 drivers/clk/sunxi/Kconfig                         |  1 +
 drivers/mmc/sunxi_mmc.c                           |  1 +
 drivers/pinctrl/sunxi/Kconfig                     |  1 +
 10 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index af419c7e590..a0c8abb7033 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -23,6 +23,13 @@
 	};
 };
 
+/* Let U-Boot be the firmware layer that controls the watchdog. */
+#ifdef CONFIG_MACH_SUN8I_R528
+&wdt {
+	status = "okay";
+};
+#endif
+
 &binman {
 	u-boot-sunxi-with-spl {
 		filename = "u-boot-sunxi-with-spl.bin";
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 8471e11aa02..a84a57e5b41 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -266,7 +266,7 @@ struct sunxi_ccm_reg {
 #define CCM_CPU_AXI_AXI_MASK		0x3
 #define CCM_CPU_AXI_DEFAULT_FACTORS	0x301
 
-#ifdef CONFIG_MACH_SUN50I_H6
+#ifdef CONFIG_MACH_SUN50I_H6				/* H6 */
 #define CCM_PLL6_DEFAULT		0xa0006300
 
 /* psi_ahb1_ahb2 bit field */
@@ -277,7 +277,7 @@ struct sunxi_ccm_reg {
 
 /* apb1 bit field */
 #define CCM_APB1_DEFAULT		0x03000102
-#elif CONFIG_MACH_SUN50I_H616
+#elif CONFIG_MACH_SUN50I_H616				/* H616 */
 #define CCM_PLL6_DEFAULT		0xa8003100
 
 /* psi_ahb1_ahb2 bit field */
@@ -288,6 +288,11 @@ struct sunxi_ccm_reg {
 
 /* apb1 bit field */
 #define CCM_APB1_DEFAULT		0x03000102
+#elif CONFIG_MACH_SUN8I_R528				/* R528 */
+#define CCM_PLL6_DEFAULT		0xe8216300
+#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
+//#define CCM_AHB3_DEFAULT		0x03000002
+#define CCM_APB1_DEFAULT		0x03000102
 #endif
 
 /* apb2 bit field */
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 6ba9ed2bb2a..d976203ee7b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -346,6 +346,15 @@ config MACH_SUN8I_R40
 	select SUNXI_DRAM_DW_32BIT
 	imply SPL_SYS_I2C_LEGACY
 
+config MACH_SUN8I_R528
+	bool "sun8i (Allwinner R528)"
+	select CPU_V7A
+	select SUNXI_GEN_NCAT2
+	select SUNXI_NEW_PINCTRL
+	select MMC_SUNXI_HAS_NEW_MODE
+	select SUPPORT_SPL
+	select DRAM_SUN20I_D1
+
 config MACH_SUN8I_V3S
 	bool "sun8i (Allwinner V3/V3s/S3/S3L)"
 	select CPU_V7A
@@ -656,6 +665,7 @@ config SYS_CLK_FREQ
 	default 1008000000 if MACH_SUN9I
 	default 888000000 if MACH_SUN50I_H6
 	default 1008000000 if MACH_SUN50I_H616
+	default 1008000000 if MACH_SUN8I_R528
 
 config SYS_CONFIG_NAME
 	default "suniv" if MACH_SUNIV
@@ -664,6 +674,7 @@ config SYS_CONFIG_NAME
 	default "sun6i" if MACH_SUN6I
 	default "sun7i" if MACH_SUN7I
 	default "sun8i" if MACH_SUN8I
+	default "sun8i" if MACH_SUN8I_R528
 	default "sun9i" if MACH_SUN9I
 	default "sun50i" if MACH_SUN50I
 	default "sun50i" if MACH_SUN50I_H6
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index d572314f0da..c2fadf75367 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -147,6 +147,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(12), SUN9I_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(13), SUN9I_GPH_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPH(13), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(2), 6);
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(3), 6);
+	sunxi_gpio_set_pull(SUNXI_GPE(3), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUNIV)
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPE_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPE_UART0);
@@ -163,6 +167,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_GPB_UART2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_GPB_UART2);
 	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 4 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), 7);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), 7);
+	sunxi_gpio_set_pull(SUNXI_GPB(7), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 5 && defined(CONFIG_MACH_SUN8I)
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(2), SUN8I_GPL_R_UART);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(3), SUN8I_GPL_R_UART);
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index daae994787e..bea91c78bc5 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -41,7 +41,9 @@ void clock_init_safe(void)
 			CCM_CPU_AXI_DEFAULT_FACTORS);
 
 	writel(CCM_PSI_AHB1_AHB2_DEFAULT, &ccm->psi_ahb1_ahb2_cfg);
+#ifdef CCM_AHB3_DEFAULT
 	writel(CCM_AHB3_DEFAULT, &ccm->ahb3_cfg);
+#endif
 	writel(CCM_APB1_DEFAULT, &ccm->apb1_cfg);
 
 	/*
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index 7eef178859b..7fecc3b88dd 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -93,6 +93,8 @@ int print_cpuinfo(void)
 	printf("CPU:   Allwinner R40 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_V3S
 	printf("CPU:   Allwinner V3s (SUN8I %04x)\n", sunxi_get_sram_id());
+#elif defined CONFIG_MACH_SUN8I_R528
+	puts("CPU:   Allwinner R528 (SUN8I)\n");
 #elif defined CONFIG_MACH_SUN9I
 	puts("CPU:   Allwinner A80 (SUN9I)\n");
 #elif defined CONFIG_MACH_SUN50I
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f7c8ba511b3..25cd18afda7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -371,6 +371,7 @@ config SPL_STACK
 	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x118000 if MACH_SUN50I_H6
 	default 0x58000 if MACH_SUN50I_H616
+	default 0x40000 if MACH_SUN8I_R528
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index f65e482ba4c..8bdc0944896 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -89,6 +89,7 @@ config CLK_SUN8I_H3
 
 config CLK_SUN20I_D1
 	bool "Clock driver for Allwinner D1"
+	default MACH_SUN8I_R528
 	help
 	  This enables common clock driver support for platforms based
 	  on Allwinner D1 SoC.
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 519ef602145..4d6351bf275 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -707,6 +707,7 @@ static const struct udevice_id sunxi_mmc_ids[] = {
 	{ .compatible = "allwinner,sun50i-h6-emmc" },
 	{ .compatible = "allwinner,sun50i-a100-mmc" },
 	{ .compatible = "allwinner,sun50i-a100-emmc" },
+	{ .compatible = "allwinner,sun20i-d1-mmc" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index c8f937d91e9..cbd61795986 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -126,6 +126,7 @@ config PINCTRL_SUN50I_H616_R
 
 config PINCTRL_SUN20I_D1
 	bool "Support for the Allwinner D1/R528 PIO"
+	default MACH_SUN8I_R528
 	select PINCTRL_SUNXI
 
 endif
-- 
2.25.1

