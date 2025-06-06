Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B56C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE92982AFC;
	Sat,  7 Jun 2025 00:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E441782B3D; Sat,  7 Jun 2025 00:47:12 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA6482A9E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B5E20B4C35AF;
 Sat,  7 Jun 2025 00:47:04 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>, Andrew Davis <afd@ti.com>,
 Stefan Roese <sr@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: E Shattow <e@freeshell.de>,
	adsp-linux@analog.com
Subject: [PATCH v1 6/7] arch: use lowercase hex prefix style
Date: Fri,  6 Jun 2025 15:45:01 -0700
Message-ID: <20250606224558.1117422-7-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
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

Use consistent lowercase hex prefix style in arch/*

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/arm/dts/fsl-imx8qxp-ai_ml.dts            | 16 +++++++--------
 arch/arm/dts/hi3660.dtsi                      |  2 +-
 arch/arm/dts/imx7-colibri.dtsi                |  2 +-
 .../asm/arch-fsl-layerscape/immap_lsch3.h     |  2 +-
 arch/arm/include/asm/arch-mx6/mx6sl_pins.h    |  8 ++++----
 arch/arm/include/asm/arch-rockchip/cru_px30.h |  6 +++---
 .../arm/include/asm/arch-rockchip/f_rockusb.h |  2 +-
 .../include/asm/arch-rockchip/sdram_px30.h    |  2 +-
 .../include/asm/arch-rockchip/sdram_rk3328.h  |  2 +-
 .../include/asm/arch-rockchip/sdram_rv1126.h  |  2 +-
 arch/arm/include/asm/iproc-common/sysmap.h    | 20 +++++++++----------
 arch/arm/mach-at91/include/mach/at91_wdt.h    |  2 +-
 arch/arm/mach-exynos/include/mach/dsim.h      |  2 +-
 arch/arm/mach-imx/iomux-v3.c                  |  2 +-
 .../mach-keystone/include/mach/hardware-k2g.h |  4 ++--
 arch/arm/mach-kirkwood/include/mach/mpp.h     |  2 +-
 arch/arm/mach-omap2/lowlevel_init.S           |  2 +-
 arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
 .../include/mach/clock_manager_s10.h          |  6 +++---
 arch/arm/mach-uniphier/bcu/bcu-ld4.c          |  2 +-
 arch/arm/mach-zynqmp/include/mach/hardware.h  |  2 +-
 arch/mips/mach-jz47xx/jz4780/pll.c            |  2 +-
 arch/powerpc/include/asm/immap_85xx.h         |  6 +++---
 arch/powerpc/include/asm/processor.h          |  4 ++--
 24 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/dts/fsl-imx8qxp-ai_ml.dts b/arch/arm/dts/fsl-imx8qxp-ai_ml.dts
index aa85caaff58..be94767fa94 100644
--- a/arch/arm/dts/fsl-imx8qxp-ai_ml.dts
+++ b/arch/arm/dts/fsl-imx8qxp-ai_ml.dts
@@ -130,29 +130,29 @@
 
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
-			SC_P_UART0_RX_ADMA_UART0_RX			0X06000020
-			SC_P_UART0_TX_ADMA_UART0_TX			0X06000020
+			SC_P_UART0_RX_ADMA_UART0_RX			0x06000020
+			SC_P_UART0_TX_ADMA_UART0_TX			0x06000020
 		>;
 	};
 
 	pinctrl_lpuart1: lpuart1grp {
 		fsl,pins = <
-			SC_P_UART1_RX_ADMA_UART1_RX			0X06000020
-			SC_P_UART1_TX_ADMA_UART1_TX			0X06000020
+			SC_P_UART1_RX_ADMA_UART1_RX			0x06000020
+			SC_P_UART1_TX_ADMA_UART1_TX			0x06000020
 		>;
 	};
 
 	pinctrl_lpuart2: lpuart2grp {
 		fsl,pins = <
-			SC_P_UART2_RX_ADMA_UART2_RX			0X06000020
-			SC_P_UART2_TX_ADMA_UART2_TX			0X06000020
+			SC_P_UART2_RX_ADMA_UART2_RX			0x06000020
+			SC_P_UART2_TX_ADMA_UART2_TX			0x06000020
 		>;
 	};
 
 	pinctrl_lpuart3: lpuart3grp {
 		fsl,pins = <
-			SC_P_FLEXCAN2_RX_ADMA_UART3_RX			0X06000020
-			SC_P_FLEXCAN2_TX_ADMA_UART3_TX			0X06000020
+			SC_P_FLEXCAN2_RX_ADMA_UART3_RX			0x06000020
+			SC_P_FLEXCAN2_TX_ADMA_UART3_TX			0x06000020
 		>;
 	};
 
diff --git a/arch/arm/dts/hi3660.dtsi b/arch/arm/dts/hi3660.dtsi
index 028f4db60d2..7cc1e1b6279 100644
--- a/arch/arm/dts/hi3660.dtsi
+++ b/arch/arm/dts/hi3660.dtsi
@@ -580,7 +580,7 @@
 
 		rtc0: rtc@fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
-			reg = <0x0 0Xfff04000 0x0 0x1000>;
+			reg = <0x0 0xfff04000 0x0 0x1000>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_PCLK>;
 			clock-names = "apb_pclk";
diff --git a/arch/arm/dts/imx7-colibri.dtsi b/arch/arm/dts/imx7-colibri.dtsi
index a8c31ee6562..4c0b5ec6c61 100644
--- a/arch/arm/dts/imx7-colibri.dtsi
+++ b/arch/arm/dts/imx7-colibri.dtsi
@@ -669,7 +669,7 @@
 
 	pinctrl_can_int: canintgrp {
 		fsl,pins = <
-			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x14 /* SODIMM 73 */
 		>;
 	};
 
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
index 306f797f7a8..86d295c1a8d 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
@@ -241,7 +241,7 @@
 #define DCFG_RCWSR15			0x138
 #define DCFG_RCWSR15_IFCGRPABASE_QSPI	0x3
 
-#define DCFG_DCSR_BASE		0X700100000ULL
+#define DCFG_DCSR_BASE		0x700100000ULL
 #define DCFG_DCSR_PORCR1		0x000
 
 /* Interrupt Sampling Control */
diff --git a/arch/arm/include/asm/arch-mx6/mx6sl_pins.h b/arch/arm/include/asm/arch-mx6/mx6sl_pins.h
index 01b14d73dc9..699c951b1b9 100644
--- a/arch/arm/include/asm/arch-mx6/mx6sl_pins.h
+++ b/arch/arm/include/asm/arch-mx6/mx6sl_pins.h
@@ -31,10 +31,10 @@ enum {
 	MX6_PAD_SD2_DAT1__USDHC2_DAT1				= IOMUX_PAD(0x0568, 0x0260, 0, 0x0000, 0, 0),
 	MX6_PAD_SD2_DAT2__USDHC2_DAT2				= IOMUX_PAD(0x056C, 0x0264, 0, 0x0000, 0, 0),
 	MX6_PAD_SD2_DAT3__USDHC2_DAT3				= IOMUX_PAD(0x0570, 0x0268, 0, 0x0000, 0, 0),
-	MX6_PAD_SD2_DAT4__USDHC2_DAT4				= IOMUX_PAD(0X0574, 0X026C, 0, 0X0000, 0, 0),
-	MX6_PAD_SD2_DAT5__USDHC2_DAT5				= IOMUX_PAD(0X0578, 0X0270, 0, 0X0000, 0, 0),
-	MX6_PAD_SD2_DAT6__USDHC2_DAT6				= IOMUX_PAD(0X057C, 0X0274, 0, 0X0000, 0, 0),
-	MX6_PAD_SD2_DAT7__USDHC2_DAT7				= IOMUX_PAD(0X0580, 0X0278, 0, 0X0000, 0, 0),
+	MX6_PAD_SD2_DAT4__USDHC2_DAT4				= IOMUX_PAD(0x0574, 0x026C, 0, 0x0000, 0, 0),
+	MX6_PAD_SD2_DAT5__USDHC2_DAT5				= IOMUX_PAD(0x0578, 0x0270, 0, 0x0000, 0, 0),
+	MX6_PAD_SD2_DAT6__USDHC2_DAT6				= IOMUX_PAD(0x057C, 0x0274, 0, 0x0000, 0, 0),
+	MX6_PAD_SD2_DAT7__USDHC2_DAT7				= IOMUX_PAD(0x0580, 0x0278, 0, 0x0000, 0, 0),
 	MX6_PAD_SD2_DAT7__GPIO_5_0					= IOMUX_PAD(0x0580, 0x0278, 5, 0x0000, 0, 0),
 	MX6_PAD_SD2_RST__USDHC2_RST				= IOMUX_PAD(0x0584, 0x027C, 0, 0x0000, 0, 0),
 	MX6_PAD_SD3_CLK__USDHC3_CLK					= IOMUX_PAD(0x0588, 0x0280, 0, 0x0000, 0, 0),
diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h b/arch/arm/include/asm/arch-rockchip/cru_px30.h
index 504459bd93d..408fdd66635 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
@@ -299,9 +299,9 @@ enum {
 
 	/* CRU_CLK_SEL30_CON */
 	CLK_I2S1_DIV_CON_MASK	= 0x7f,
-	CLK_I2S1_PLL_SEL_MASK	= 0X1 << 8,
-	CLK_I2S1_PLL_SEL_GPLL	= 0X0 << 8,
-	CLK_I2S1_PLL_SEL_NPLL	= 0X1 << 8,
+	CLK_I2S1_PLL_SEL_MASK	= 0x1 << 8,
+	CLK_I2S1_PLL_SEL_GPLL	= 0x0 << 8,
+	CLK_I2S1_PLL_SEL_NPLL	= 0x1 << 8,
 	CLK_I2S1_SEL_MASK	= 0x3 << 10,
 	CLK_I2S1_SEL_I2S1	= 0x0 << 10,
 	CLK_I2S1_SEL_FRAC	= 0x1 << 10,
diff --git a/arch/arm/include/asm/arch-rockchip/f_rockusb.h b/arch/arm/include/asm/arch-rockchip/f_rockusb.h
index e9c7f793391..9abb3b16c42 100644
--- a/arch/arm/include/asm/arch-rockchip/f_rockusb.h
+++ b/arch/arm/include/asm/arch-rockchip/f_rockusb.h
@@ -65,7 +65,7 @@ K_FW_SPI_READ_10 = 0x21,
 K_FW_SPI_WRITE_10 = 0x22,
 K_FW_LBA_ERASE_10 = 0x25,
 
-K_FW_SESSION = 0X30,
+K_FW_SESSION = 0x30,
 K_FW_RESET = 0xff,
 };
 
diff --git a/arch/arm/include/asm/arch-rockchip/sdram_px30.h b/arch/arm/include/asm/arch-rockchip/sdram_px30.h
index 2ab8e97ae1d..bf0cd01e7cc 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram_px30.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram_px30.h
@@ -20,7 +20,7 @@
 
 /* DDR GRF */
 #define DDR_GRF_CON(n)			(0 + (n) * 4)
-#define DDR_GRF_STATUS_BASE		(0X100)
+#define DDR_GRF_STATUS_BASE		(0x100)
 #define DDR_GRF_STATUS(n)		(DDR_GRF_STATUS_BASE + (n) * 4)
 #define DDR_GRF_LP_CON			(0x20)
 
diff --git a/arch/arm/include/asm/arch-rockchip/sdram_rk3328.h b/arch/arm/include/asm/arch-rockchip/sdram_rk3328.h
index 10923505d6e..454f9ca8878 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram_rk3328.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram_rk3328.h
@@ -32,7 +32,7 @@
 
 /* DDR GRF */
 #define DDR_GRF_CON(n)		(0 + (n) * 4)
-#define DDR_GRF_STATUS_BASE	(0X100)
+#define DDR_GRF_STATUS_BASE	(0x100)
 #define DDR_GRF_STATUS(n)	(DDR_GRF_STATUS_BASE + (n) * 4)
 
 /* CRU_SOFTRESET_CON5 */
diff --git a/arch/arm/include/asm/arch-rockchip/sdram_rv1126.h b/arch/arm/include/asm/arch-rockchip/sdram_rv1126.h
index 6a07436059c..9b65bad2581 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram_rv1126.h
@@ -185,7 +185,7 @@
 
 /* DDR GRF */
 #define DDR_GRF_CON(n)			(0 + (n) * 4)
-#define DDR_GRF_STATUS_BASE		(0X100)
+#define DDR_GRF_STATUS_BASE		(0x100)
 #define DDR_GRF_STATUS(n)		(DDR_GRF_STATUS_BASE + (n) * 4)
 #define DDR_GRF_LP_CON			(0x20)
 
diff --git a/arch/arm/include/asm/iproc-common/sysmap.h b/arch/arm/include/asm/iproc-common/sysmap.h
index efd2f35f212..c071e9ea53f 100644
--- a/arch/arm/include/asm/iproc-common/sysmap.h
+++ b/arch/arm/include/asm/iproc-common/sysmap.h
@@ -6,17 +6,17 @@
 #ifndef __SYSMAP_H
 #define __SYSMAP_H
 
-#define IHOST_PROC_CLK_PLLARMA					0X19000C00
-#define IHOST_PROC_CLK_PLLARMB					0X19000C04
+#define IHOST_PROC_CLK_PLLARMA					0x19000C00
+#define IHOST_PROC_CLK_PLLARMB					0x19000C04
 #define IHOST_PROC_CLK_PLLARMA__PLLARM_PDIV_R				24
 
-#define IHOST_PROC_CLK_WR_ACCESS				0X19000000
-#define IHOST_PROC_CLK_POLICY_FREQ				0X19000008
+#define IHOST_PROC_CLK_WR_ACCESS				0x19000000
+#define IHOST_PROC_CLK_POLICY_FREQ				0x19000008
 #define IHOST_PROC_CLK_POLICY_FREQ__PRIV_ACCESS_MODE			31
 #define IHOST_PROC_CLK_POLICY_FREQ__POLICY3_FREQ_R			24
 #define IHOST_PROC_CLK_POLICY_FREQ__POLICY2_FREQ_R			16
 #define IHOST_PROC_CLK_POLICY_FREQ__POLICY1_FREQ_R			 8
-#define IHOST_PROC_CLK_POLICY_CTL				0X1900000C
+#define IHOST_PROC_CLK_POLICY_CTL				0x1900000C
 #define IHOST_PROC_CLK_POLICY_CTL__GO					 0
 #define IHOST_PROC_CLK_POLICY_CTL__GO_AC				 1
 #define IHOST_PROC_CLK_PLLARMB__PLLARM_NDIV_FRAC_R			 0
@@ -26,11 +26,11 @@
 #define IHOST_PROC_CLK_PLLARMA__PLLARM_NDIV_INT_R			 8
 #define IHOST_PROC_CLK_PLLARMA__PLLARM_SOFT_POST_RESETB			 1
 #define IHOST_PROC_CLK_PLLARMA__PLLARM_SOFT_RESETB			 0
-#define IHOST_PROC_CLK_CORE0_CLKGATE				0X19000200
-#define IHOST_PROC_CLK_CORE1_CLKGATE				0X19000204
-#define IHOST_PROC_CLK_ARM_SWITCH_CLKGATE			0X19000210
-#define IHOST_PROC_CLK_ARM_PERIPH_CLKGATE			0X19000300
-#define IHOST_PROC_CLK_APB0_CLKGATE				0X19000400
+#define IHOST_PROC_CLK_CORE0_CLKGATE				0x19000200
+#define IHOST_PROC_CLK_CORE1_CLKGATE				0x19000204
+#define IHOST_PROC_CLK_ARM_SWITCH_CLKGATE			0x19000210
+#define IHOST_PROC_CLK_ARM_PERIPH_CLKGATE			0x19000300
+#define IHOST_PROC_CLK_APB0_CLKGATE				0x19000400
 #define IPROC_CLKCT_HDELAY_SW_EN				0x00000303
 
 #define IPROC_REG_WRITE_ACCESS					0x00a5a501
diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 8ef8e007d77..25d95fab1f8 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -38,7 +38,7 @@ struct at91_wdt_priv {
 #define AT91_WDT_CR_KEY			0xa5000000	/* KEY Password */
 
 /* Watchdog Mode Register*/
-#define AT91_WDT_MR			0X04
+#define AT91_WDT_MR			0x04
 #define AT91_WDT_MR_WDV(x)		(x & 0xfff)
 #define AT91_WDT_MR_WDFIEN		0x00001000
 #define AT91_WDT_MR_WDRSTEN		0x00002000
diff --git a/arch/arm/mach-exynos/include/mach/dsim.h b/arch/arm/mach-exynos/include/mach/dsim.h
index 15671b603c3..de6c2d29871 100644
--- a/arch/arm/mach-exynos/include/mach/dsim.h
+++ b/arch/arm/mach-exynos/include/mach/dsim.h
@@ -101,7 +101,7 @@ struct exynos_mipi_dsim {
 /* EXYNOS_DSIM_MDRESOL */
 #define DSIM_MAIN_STAND_BY		(1 << 31)
 #define DSIM_MAIN_VRESOL(x)		(((x) & 0x7ff) << 16)
-#define DSIM_MAIN_HRESOL(x)		(((x) & 0X7ff) << 0)
+#define DSIM_MAIN_HRESOL(x)		(((x) & 0x7ff) << 0)
 
 /* EXYNOS_DSIM_MVPORCH */
 #define DSIM_CMD_ALLOW_SHIFT		(28)
diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index c134e95ed78..22ffbcaffd9 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -142,6 +142,6 @@ void imx_iomux_gpio_set_direction(unsigned int gpio,
 void imx_iomux_gpio_get_function(unsigned int gpio, u32 *gpio_state)
 {
 	*gpio_state = readl(base + (gpio << 2)) &
-		((0X07 << PAD_MUX_MODE_SHIFT) | PAD_CTL_OBE_IBE_ENABLE);
+		((0x07 << PAD_MUX_MODE_SHIFT) | PAD_CTL_OBE_IBE_ENABLE);
 }
 #endif
diff --git a/arch/arm/mach-keystone/include/mach/hardware-k2g.h b/arch/arm/mach-keystone/include/mach/hardware-k2g.h
index 971c081bb3c..482995fc8ba 100644
--- a/arch/arm/mach-keystone/include/mach/hardware-k2g.h
+++ b/arch/arm/mach-keystone/include/mach/hardware-k2g.h
@@ -67,8 +67,8 @@
 /* NETCP */
 #define KS2_NETCP_BASE			0x04000000
 
-#define K2G_GPIO0_BASE			0X02603000
-#define K2G_GPIO1_BASE			0X0260a000
+#define K2G_GPIO0_BASE			0x02603000
+#define K2G_GPIO1_BASE			0x0260a000
 #define K2G_GPIO0_BANK0_BASE		K2G_GPIO0_BASE + 0x10
 #define K2G_GPIO1_BANK2_BASE		K2G_GPIO1_BASE + 0x38
 #define K2G_GPIO_DIR_OFFSET		0x0
diff --git a/arch/arm/mach-kirkwood/include/mach/mpp.h b/arch/arm/mach-kirkwood/include/mach/mpp.h
index e2757942590..f50156b3357 100644
--- a/arch/arm/mach-kirkwood/include/mach/mpp.h
+++ b/arch/arm/mach-kirkwood/include/mach/mpp.h
@@ -89,7 +89,7 @@
 
 #define MPP10_GPO		MPP( 10, 0x0, 0, 1, 1,   1,   1,   1    )
 #define MPP10_SPI_SCK		MPP( 10, 0x2, 0, 1, 1,   1,   1,   1    )
-#define MPP10_UART0_TXD		MPP( 10, 0X3, 0, 1, 1,   1,   1,   1    )
+#define MPP10_UART0_TXD		MPP( 10, 0x3, 0, 1, 1,   1,   1,   1    )
 #define MPP10_SATA1_ACTn	MPP( 10, 0x5, 0, 1, 0,   0,   1,   1    )
 #define MPP10_PTP_TRIG_GEN	MPP( 10, 0xc, 0, 1, 1,   1,   1,   1    )
 
diff --git a/arch/arm/mach-omap2/lowlevel_init.S b/arch/arm/mach-omap2/lowlevel_init.S
index 1a55295f9de..e977805bd03 100644
--- a/arch/arm/mach-omap2/lowlevel_init.S
+++ b/arch/arm/mach-omap2/lowlevel_init.S
@@ -39,7 +39,7 @@ restore_from_hyp:
 	adr	r0, save_sp
 	ldr	sp, [r0]
 	MRC p15, 4, R0, c1, c0, 0
-	ldr     r1, =0X1004	@Set cache enable bits for hypervisor mode
+	ldr     r1, =0x1004	@Set cache enable bits for hypervisor mode
 	orr     r0, r0, r1
 	MCR p15, 4, R0, c1, c0, 0
 	b	switch_to_hypervisor_ret
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/dmcinit.c
index e375b5c9dfa..30b77aee459 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.c
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -367,7 +367,7 @@ static inline void calibration_legacy(void)
 	 */
 	if (dmc.ddr_mode == DDR3_MODE ||
 	    dmc.ddr_mode == DDR2_MODE) {
-		writel(0XFC000000, dmc.reg + REG_DMC_PHY_CTL2);
+		writel(0xFC000000, dmc.reg + REG_DMC_PHY_CTL2);
 		writel(0x0000000f, dmc.reg + REG_DMC_PHY_CTL0);
 	}
 
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
index 18921169a6d..5dcbda9473e 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
@@ -120,12 +120,12 @@ void cm_basic_init(const struct cm_config * const cfg);
 
 #define CLKMGR_PLLGLOB_PD_MASK				0x00000001
 #define CLKMGR_PLLGLOB_RST_MASK				0x00000002
-#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			0X3
+#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			0x3
 #define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET			16
 #define CLKMGR_VCO_PSRC_EOSC1				0
 #define CLKMGR_VCO_PSRC_INTOSC				1
 #define CLKMGR_VCO_PSRC_F2S				2
-#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			0X3f
+#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			0x3f
 #define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET			8
 
 #define CLKMGR_CLKSRC_MASK				0x7
@@ -152,7 +152,7 @@ void cm_basic_init(const struct cm_config * const cfg);
 #define CLKMGR_NOCDIV_CSTRACECLK_OFFSET			26
 #define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET			28
 
-#define CLKMGR_NOCDIV_L4SPCLK_MASK			0X3
+#define CLKMGR_NOCDIV_L4SPCLK_MASK			0x3
 #define CLKMGR_NOCDIV_DIV1				0
 #define CLKMGR_NOCDIV_DIV2				1
 #define CLKMGR_NOCDIV_DIV4				2
diff --git a/arch/arm/mach-uniphier/bcu/bcu-ld4.c b/arch/arm/mach-uniphier/bcu/bcu-ld4.c
index ea6088ba1cb..08c41fa6d4d 100644
--- a/arch/arm/mach-uniphier/bcu/bcu-ld4.c
+++ b/arch/arm/mach-uniphier/bcu/bcu-ld4.c
@@ -20,7 +20,7 @@ void uniphier_ld4_bcu_init(const struct uniphier_board_data *bd)
 	writel(0x11111111, BCSCR2); /* 0x80000000-0x9fffffff: IPPC/IPPD-bus */
 	writel(0x11111111, BCSCR3); /* 0xa0000000-0xbfffffff: IPPC/IPPD-bus */
 	writel(0x11111111, BCSCR4); /* 0xc0000000-0xdfffffff: IPPC/IPPD-bus */
-	writel(0x11111111, BCSCR5); /* 0xe0000000-0Xffffffff: IPPC/IPPD-bus */
+	writel(0x11111111, BCSCR5); /* 0xe0000000-0xffffffff: IPPC/IPPD-bus */
 
 	/* Specify DDR channel */
 	shift = bd->dram_ch[0].size / 0x04000000 * 4;
diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index 3c372bd6dcf..02bbc54ff0f 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -19,7 +19,7 @@
 #define ZYNQMP_CRL_APB_BOOT_PIN_CTRL_OUT_EN_SHIFT	0
 #define ZYNQMP_CRL_APB_BOOT_PIN_CTRL_OUT_VAL_SHIFT	8
 
-#define ZYNQMP_AMS_PS_SYSMON_BASEADDR      0XFFA50800
+#define ZYNQMP_AMS_PS_SYSMON_BASEADDR      0xFFA50800
 #define ZYNQMP_AMS_PS_SYSMON_ANALOG_BUS ((ZYNQMP_AMS_PS_SYSMON_BASEADDR) \
 							    + 0x00000114)
 #define ZYNQMP_PS_SYSMON_ANALOG_BUS_VAL 0x00003210
diff --git a/arch/mips/mach-jz47xx/jz4780/pll.c b/arch/mips/mach-jz47xx/jz4780/pll.c
index 8ef00f99a10..0ff717b4595 100644
--- a/arch/mips/mach-jz47xx/jz4780/pll.c
+++ b/arch/mips/mach-jz47xx/jz4780/pll.c
@@ -327,7 +327,7 @@
 /* BCH clock divider register */
 #define CPM_BCHCDR_BPCS_BIT		30
 #define CPM_BCHCDR_BPCS_MASK		(0x3 << CPM_BCHCDR_BPCS_BIT)
-#define CPM_BCHCDR_BPCS_STOP		(0X0 << CPM_BCHCDR_BPCS_BIT)
+#define CPM_BCHCDR_BPCS_STOP		(0x0 << CPM_BCHCDR_BPCS_BIT)
 #define CPM_BCHCDR_BPCS_SRC_CLK		(0x1 << CPM_BCHCDR_BPCS_BIT)
 #define CPM_BCHCDR_BPCS_MPLL		(0x2 << CPM_BCHCDR_BPCS_BIT)
 #define CPM_BCHCDR_BPCS_EPLL		(0x3 << CPM_BCHCDR_BPCS_BIT)
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 7293720fb3c..3565a287154 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -2027,8 +2027,8 @@ typedef struct ccsr_gur {
 #endif
 #if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
 #if defined(CONFIG_ARCH_BSC9131)
-#define MPC85xx_PMUXCR2_UART_CTS_B0_SIM_PD		0X40000000
-#define MPC85xx_PMUXCR2_UART_CTS_B0_DSP_TMS		0X80000000
+#define MPC85xx_PMUXCR2_UART_CTS_B0_SIM_PD		0x40000000
+#define MPC85xx_PMUXCR2_UART_CTS_B0_DSP_TMS		0x80000000
 #define MPC85xx_PMUXCR2_UART_CTS_B0_GPIO42		0xC0000000
 #define MPC85xx_PMUXCR2_UART_RTS_B0_PWM2		0x10000000
 #define MPC85xx_PMUXCR2_UART_RTS_B0_DSP_TCK		0x20000000
@@ -2727,7 +2727,7 @@ struct ccsr_cluster_l2 {
 	(CONFIG_SYS_IMMR + CFG_SYS_FSL_CLUSTER_1_L2_OFFSET)
 #endif /* CONFIG_SYS_FSL_QORIQ_CHASSIS2 */
 
-#define	CFG_SYS_DCSR_DCFG_OFFSET	0X20000
+#define	CFG_SYS_DCSR_DCFG_OFFSET	0x20000
 struct dcsr_dcfg_regs {
 	u8  res_0[0x520];
 	u32 ecccr1;
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index f7e1a807746..2357734a5be 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1053,7 +1053,7 @@
 #define SVR_P4080	0x820000
 #define SVR_P5010	0x822100
 #define SVR_P5020	0x822000
-#define SVR_P5021	0X820500
+#define SVR_P5021	0x820500
 #define SVR_P5040	0x820400
 #define SVR_T4240	0x824000
 #define SVR_T4120	0x824001
@@ -1062,7 +1062,7 @@
 #define SVR_C291	0x850000
 #define SVR_C292	0x850020
 #define SVR_C293	0x850030
-#define SVR_B4860	0X868000
+#define SVR_B4860	0x868000
 #define SVR_G4860	0x868001
 #define SVR_B4460	0x868003
 #define SVR_B4440	0x868100
-- 
2.49.0

