Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04BEE743C9
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB9C86EB1;
	Thu, 28 Sep 2023 23:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D07886E22; Thu, 28 Sep 2023 23:56:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DEA9D86E98
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2FCE1FB;
 Thu, 28 Sep 2023 14:57:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC56F3F59C;
 Thu, 28 Sep 2023 14:56:23 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 12/22] clk: sunxi: Add support for the D1 CCU
Date: Thu, 28 Sep 2023 22:54:45 +0100
Message-Id: <20230928215455.28094-13-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

Since the D1 CCU binding is defined, we can add support for its
gates/resets, following the pattern of the existing drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/Kconfig                 |   6 +
 drivers/clk/sunxi/Makefile                |   1 +
 drivers/clk/sunxi/clk_d1.c                |  84 ++++++++++++
 drivers/clk/sunxi/clk_sunxi.c             |   5 +
 include/dt-bindings/clock/sun20i-d1-ccu.h | 158 ++++++++++++++++++++++
 include/dt-bindings/reset/sun20i-d1-ccu.h |  79 +++++++++++
 6 files changed, 333 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_d1.c
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index bf11fad6eef..f65e482ba4c 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -87,6 +87,12 @@ config CLK_SUN8I_H3
 	  This enables common clock driver support for platforms based
 	  on Allwinner H3/H5 SoC.
 
+config CLK_SUN20I_D1
+	bool "Clock driver for Allwinner D1"
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner D1 SoC.
+
 config CLK_SUN50I_H6
 	bool "Clock driver for Allwinner H6"
 	default MACH_SUN50I_H6
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 895da02ebea..90a277489dc 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CLK_SUN8I_R40) += clk_r40.o
 obj-$(CONFIG_CLK_SUN8I_V3S) += clk_v3s.o
 obj-$(CONFIG_CLK_SUN9I_A80) += clk_a80.o
 obj-$(CONFIG_CLK_SUN8I_H3) += clk_h3.o
+obj-$(CONFIG_CLK_SUN20I_D1) += clk_d1.o
 obj-$(CONFIG_CLK_SUN50I_H6) += clk_h6.o
 obj-$(CONFIG_CLK_SUN50I_H6_R) += clk_h6_r.o
 obj-$(CONFIG_CLK_SUN50I_H616) += clk_h616.o
diff --git a/drivers/clk/sunxi/clk_d1.c b/drivers/clk/sunxi/clk_d1.c
new file mode 100644
index 00000000000..9dae761de83
--- /dev/null
+++ b/drivers/clk/sunxi/clk_d1.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#include <common.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <clk/sunxi.h>
+#include <dt-bindings/clock/sun20i-d1-ccu.h>
+#include <dt-bindings/reset/sun20i-d1-ccu.h>
+#include <linux/bitops.h>
+
+static struct ccu_clk_gate d1_gates[] = {
+	[CLK_APB0]		= GATE_DUMMY,
+
+	[CLK_BUS_MMC0]		= GATE(0x84c, BIT(0)),
+	[CLK_BUS_MMC1]		= GATE(0x84c, BIT(1)),
+	[CLK_BUS_MMC2]		= GATE(0x84c, BIT(2)),
+	[CLK_BUS_UART0]		= GATE(0x90c, BIT(0)),
+	[CLK_BUS_UART1]		= GATE(0x90c, BIT(1)),
+	[CLK_BUS_UART2]		= GATE(0x90c, BIT(2)),
+	[CLK_BUS_UART3]		= GATE(0x90c, BIT(3)),
+	[CLK_BUS_UART4]		= GATE(0x90c, BIT(4)),
+	[CLK_BUS_UART5]		= GATE(0x90c, BIT(5)),
+	[CLK_BUS_I2C0]		= GATE(0x91c, BIT(0)),
+	[CLK_BUS_I2C1]		= GATE(0x91c, BIT(1)),
+	[CLK_BUS_I2C2]		= GATE(0x91c, BIT(2)),
+	[CLK_BUS_I2C3]		= GATE(0x91c, BIT(3)),
+	[CLK_SPI0]		= GATE(0x940, BIT(31)),
+	[CLK_SPI1]		= GATE(0x944, BIT(31)),
+	[CLK_BUS_SPI0]		= GATE(0x96c, BIT(0)),
+	[CLK_BUS_SPI1]		= GATE(0x96c, BIT(1)),
+
+	[CLK_BUS_EMAC]		= GATE(0x97c, BIT(0)),
+
+	[CLK_USB_OHCI0]		= GATE(0xa70, BIT(31)),
+	[CLK_USB_OHCI1]		= GATE(0xa74, BIT(31)),
+	[CLK_BUS_OHCI0]		= GATE(0xa8c, BIT(0)),
+	[CLK_BUS_OHCI1]		= GATE(0xa8c, BIT(1)),
+	[CLK_BUS_EHCI0]		= GATE(0xa8c, BIT(4)),
+	[CLK_BUS_EHCI1]		= GATE(0xa8c, BIT(5)),
+	[CLK_BUS_OTG]		= GATE(0xa8c, BIT(8)),
+	[CLK_BUS_LRADC]		= GATE(0xa9c, BIT(0)),
+
+	[CLK_RISCV]		= GATE(0xd04, BIT(31)),
+};
+
+static struct ccu_reset d1_resets[] = {
+	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
+	[RST_BUS_MMC1]		= RESET(0x84c, BIT(17)),
+	[RST_BUS_MMC2]		= RESET(0x84c, BIT(18)),
+	[RST_BUS_UART0]		= RESET(0x90c, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x90c, BIT(17)),
+	[RST_BUS_UART2]		= RESET(0x90c, BIT(18)),
+	[RST_BUS_UART3]		= RESET(0x90c, BIT(19)),
+	[RST_BUS_UART4]		= RESET(0x90c, BIT(20)),
+	[RST_BUS_UART5]		= RESET(0x90c, BIT(21)),
+	[RST_BUS_I2C0]		= RESET(0x91c, BIT(16)),
+	[RST_BUS_I2C1]		= RESET(0x91c, BIT(17)),
+	[RST_BUS_I2C2]		= RESET(0x91c, BIT(18)),
+	[RST_BUS_I2C3]		= RESET(0x91c, BIT(19)),
+	[RST_BUS_SPI0]		= RESET(0x96c, BIT(16)),
+	[RST_BUS_SPI1]		= RESET(0x96c, BIT(17)),
+
+	[RST_BUS_EMAC]		= RESET(0x97c, BIT(16)),
+
+	[RST_USB_PHY0]		= RESET(0xa70, BIT(30)),
+	[RST_USB_PHY1]		= RESET(0xa74, BIT(30)),
+	[RST_BUS_OHCI0]		= RESET(0xa8c, BIT(16)),
+	[RST_BUS_OHCI1]		= RESET(0xa8c, BIT(17)),
+	[RST_BUS_EHCI0]		= RESET(0xa8c, BIT(20)),
+	[RST_BUS_EHCI1]		= RESET(0xa8c, BIT(21)),
+	[RST_BUS_OTG]		= RESET(0xa8c, BIT(24)),
+	[RST_BUS_LRADC]		= RESET(0xa9c, BIT(16)),
+};
+
+const struct ccu_desc d1_ccu_desc = {
+	.gates	= d1_gates,
+	.resets	= d1_resets,
+	.num_gates = ARRAY_SIZE(d1_gates),
+	.num_resets = ARRAY_SIZE(d1_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index ec02a2d0370..a0011a35d91 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -118,6 +118,7 @@ extern const struct ccu_desc a64_ccu_desc;
 extern const struct ccu_desc a80_ccu_desc;
 extern const struct ccu_desc a80_mmc_clk_desc;
 extern const struct ccu_desc a83t_ccu_desc;
+extern const struct ccu_desc d1_ccu_desc;
 extern const struct ccu_desc f1c100s_ccu_desc;
 extern const struct ccu_desc h3_ccu_desc;
 extern const struct ccu_desc h6_ccu_desc;
@@ -214,6 +215,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
 #ifdef CONFIG_CLK_SUNIV_F1C100S
 	{ .compatible = "allwinner,suniv-f1c100s-ccu",
 	  .data = (ulong)&f1c100s_ccu_desc },
+#endif
+#ifdef CONFIG_CLK_SUN20I_D1
+	{ .compatible = "allwinner,sun20i-d1-ccu",
+	  .data = (ulong)&d1_ccu_desc },
 #endif
 	{ }
 };
diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
new file mode 100644
index 00000000000..e143b992976
--- /dev/null
+++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_
+#define _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_
+
+#define CLK_PLL_CPUX		0
+#define CLK_PLL_DDR0		1
+#define CLK_PLL_PERIPH0_4X	2
+#define CLK_PLL_PERIPH0_2X	3
+#define CLK_PLL_PERIPH0_800M	4
+#define CLK_PLL_PERIPH0		5
+#define CLK_PLL_PERIPH0_DIV3	6
+#define CLK_PLL_VIDEO0_4X	7
+#define CLK_PLL_VIDEO0_2X	8
+#define CLK_PLL_VIDEO0		9
+#define CLK_PLL_VIDEO1_4X	10
+#define CLK_PLL_VIDEO1_2X	11
+#define CLK_PLL_VIDEO1		12
+#define CLK_PLL_VE		13
+#define CLK_PLL_AUDIO0_4X	14
+#define CLK_PLL_AUDIO0_2X	15
+#define CLK_PLL_AUDIO0		16
+#define CLK_PLL_AUDIO1		17
+#define CLK_PLL_AUDIO1_DIV2	18
+#define CLK_PLL_AUDIO1_DIV5	19
+#define CLK_CPUX		20
+#define CLK_CPUX_AXI		21
+#define CLK_CPUX_APB		22
+#define CLK_PSI_AHB		23
+#define CLK_APB0		24
+#define CLK_APB1		25
+#define CLK_MBUS		26
+#define CLK_DE			27
+#define CLK_BUS_DE		28
+#define CLK_DI			29
+#define CLK_BUS_DI		30
+#define CLK_G2D			31
+#define CLK_BUS_G2D		32
+#define CLK_CE			33
+#define CLK_BUS_CE		34
+#define CLK_VE			35
+#define CLK_BUS_VE		36
+#define CLK_BUS_DMA		37
+#define CLK_BUS_MSGBOX0		38
+#define CLK_BUS_MSGBOX1		39
+#define CLK_BUS_MSGBOX2		40
+#define CLK_BUS_SPINLOCK	41
+#define CLK_BUS_HSTIMER		42
+#define CLK_AVS			43
+#define CLK_BUS_DBG		44
+#define CLK_BUS_PWM		45
+#define CLK_BUS_IOMMU		46
+#define CLK_DRAM		47
+#define CLK_MBUS_DMA		48
+#define CLK_MBUS_VE		49
+#define CLK_MBUS_CE		50
+#define CLK_MBUS_TVIN		51
+#define CLK_MBUS_CSI		52
+#define CLK_MBUS_G2D		53
+#define CLK_MBUS_RISCV		54
+#define CLK_BUS_DRAM		55
+#define CLK_MMC0		56
+#define CLK_MMC1		57
+#define CLK_MMC2		58
+#define CLK_BUS_MMC0		59
+#define CLK_BUS_MMC1		60
+#define CLK_BUS_MMC2		61
+#define CLK_BUS_UART0		62
+#define CLK_BUS_UART1		63
+#define CLK_BUS_UART2		64
+#define CLK_BUS_UART3		65
+#define CLK_BUS_UART4		66
+#define CLK_BUS_UART5		67
+#define CLK_BUS_I2C0		68
+#define CLK_BUS_I2C1		69
+#define CLK_BUS_I2C2		70
+#define CLK_BUS_I2C3		71
+#define CLK_SPI0		72
+#define CLK_SPI1		73
+#define CLK_BUS_SPI0		74
+#define CLK_BUS_SPI1		75
+#define CLK_EMAC_25M		76
+#define CLK_BUS_EMAC		77
+#define CLK_IR_TX		78
+#define CLK_BUS_IR_TX		79
+#define CLK_BUS_GPADC		80
+#define CLK_BUS_THS		81
+#define CLK_I2S0		82
+#define CLK_I2S1		83
+#define CLK_I2S2		84
+#define CLK_I2S2_ASRC		85
+#define CLK_BUS_I2S0		86
+#define CLK_BUS_I2S1		87
+#define CLK_BUS_I2S2		88
+#define CLK_SPDIF_TX		89
+#define CLK_SPDIF_RX		90
+#define CLK_BUS_SPDIF		91
+#define CLK_DMIC		92
+#define CLK_BUS_DMIC		93
+#define CLK_AUDIO_DAC		94
+#define CLK_AUDIO_ADC		95
+#define CLK_BUS_AUDIO		96
+#define CLK_USB_OHCI0		97
+#define CLK_USB_OHCI1		98
+#define CLK_BUS_OHCI0		99
+#define CLK_BUS_OHCI1		100
+#define CLK_BUS_EHCI0		101
+#define CLK_BUS_EHCI1		102
+#define CLK_BUS_OTG		103
+#define CLK_BUS_LRADC		104
+#define CLK_BUS_DPSS_TOP	105
+#define CLK_HDMI_24M		106
+#define CLK_HDMI_CEC_32K	107
+#define CLK_HDMI_CEC		108
+#define CLK_BUS_HDMI		109
+#define CLK_MIPI_DSI		110
+#define CLK_BUS_MIPI_DSI	111
+#define CLK_TCON_LCD0		112
+#define CLK_BUS_TCON_LCD0	113
+#define CLK_TCON_TV		114
+#define CLK_BUS_TCON_TV		115
+#define CLK_TVE			116
+#define CLK_BUS_TVE_TOP		117
+#define CLK_BUS_TVE		118
+#define CLK_TVD			119
+#define CLK_BUS_TVD_TOP		120
+#define CLK_BUS_TVD		121
+#define CLK_LEDC		122
+#define CLK_BUS_LEDC		123
+#define CLK_CSI_TOP		124
+#define CLK_CSI_MCLK		125
+#define CLK_BUS_CSI		126
+#define CLK_TPADC		127
+#define CLK_BUS_TPADC		128
+#define CLK_BUS_TZMA		129
+#define CLK_DSP			130
+#define CLK_BUS_DSP_CFG		131
+#define CLK_RISCV		132
+#define CLK_RISCV_AXI		133
+#define CLK_BUS_RISCV_CFG	134
+#define CLK_FANOUT_24M		135
+#define CLK_FANOUT_12M		136
+#define CLK_FANOUT_16M		137
+#define CLK_FANOUT_25M		138
+#define CLK_FANOUT_32K		139
+#define CLK_FANOUT_27M		140
+#define CLK_FANOUT_PCLK		141
+#define CLK_FANOUT0		142
+#define CLK_FANOUT1		143
+#define CLK_FANOUT2		144
+#define CLK_BUS_CAN0		145
+#define CLK_BUS_CAN1		146
+
+#endif /* _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
new file mode 100644
index 00000000000..f8001cf50bf
--- /dev/null
+++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN20I_D1_CCU_H_
+#define _DT_BINDINGS_RST_SUN20I_D1_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_DE		1
+#define RST_BUS_DI		2
+#define RST_BUS_G2D		3
+#define RST_BUS_CE		4
+#define RST_BUS_VE		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MSGBOX0		7
+#define RST_BUS_MSGBOX1		8
+#define RST_BUS_MSGBOX2		9
+#define RST_BUS_SPINLOCK	10
+#define RST_BUS_HSTIMER		11
+#define RST_BUS_DBG		12
+#define RST_BUS_PWM		13
+#define RST_BUS_DRAM		14
+#define RST_BUS_MMC0		15
+#define RST_BUS_MMC1		16
+#define RST_BUS_MMC2		17
+#define RST_BUS_UART0		18
+#define RST_BUS_UART1		19
+#define RST_BUS_UART2		20
+#define RST_BUS_UART3		21
+#define RST_BUS_UART4		22
+#define RST_BUS_UART5		23
+#define RST_BUS_I2C0		24
+#define RST_BUS_I2C1		25
+#define RST_BUS_I2C2		26
+#define RST_BUS_I2C3		27
+#define RST_BUS_SPI0		28
+#define RST_BUS_SPI1		29
+#define RST_BUS_EMAC		30
+#define RST_BUS_IR_TX		31
+#define RST_BUS_GPADC		32
+#define RST_BUS_THS		33
+#define RST_BUS_I2S0		34
+#define RST_BUS_I2S1		35
+#define RST_BUS_I2S2		36
+#define RST_BUS_SPDIF		37
+#define RST_BUS_DMIC		38
+#define RST_BUS_AUDIO		39
+#define RST_USB_PHY0		40
+#define RST_USB_PHY1		41
+#define RST_BUS_OHCI0		42
+#define RST_BUS_OHCI1		43
+#define RST_BUS_EHCI0		44
+#define RST_BUS_EHCI1		45
+#define RST_BUS_OTG		46
+#define RST_BUS_LRADC		47
+#define RST_BUS_DPSS_TOP	48
+#define RST_BUS_HDMI_SUB	49
+#define RST_BUS_HDMI_MAIN	50
+#define RST_BUS_MIPI_DSI	51
+#define RST_BUS_TCON_LCD0	52
+#define RST_BUS_TCON_TV		53
+#define RST_BUS_LVDS0		54
+#define RST_BUS_TVE		55
+#define RST_BUS_TVE_TOP		56
+#define RST_BUS_TVD		57
+#define RST_BUS_TVD_TOP		58
+#define RST_BUS_LEDC		59
+#define RST_BUS_CSI		60
+#define RST_BUS_TPADC		61
+#define RST_DSP			62
+#define RST_BUS_DSP_CFG		63
+#define RST_BUS_DSP_DBG		64
+#define RST_BUS_RISCV_CFG	65
+#define RST_BUS_CAN0		66
+#define RST_BUS_CAN1		67
+
+#endif /* _DT_BINDINGS_RST_SUN20I_D1_CCU_H_ */
-- 
2.35.8

