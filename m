Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010BDC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F7681ECA;
	Sun, 23 Mar 2025 12:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 400D681DF6; Sun, 23 Mar 2025 12:36:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C482081219
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F67106F;
 Sun, 23 Mar 2025 04:36:34 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA013F694;
 Sun, 23 Mar 2025 04:36:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 14/34] dt-bindings: add Allwinner A523 CCU bindings
Date: Sun, 23 Mar 2025 11:35:24 +0000
Message-ID: <20250323113544.7933-15-andre.przywara@arm.com>
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

This adds the latest version of the clock DT binding headers for the
Allwinner A523 family of SoCs.
Those headers have already been merged into the maintainer's trees, and
appeared in linux-next, but have not made it just yet into the official
kernel repository.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/dt-bindings/clock/sun55i-a523-ccu.h   | 189 ++++++++++++++++++
 include/dt-bindings/clock/sun55i-a523-r-ccu.h |  37 ++++
 include/dt-bindings/reset/sun55i-a523-ccu.h   |  88 ++++++++
 include/dt-bindings/reset/sun55i-a523-r-ccu.h |  25 +++
 4 files changed, 339 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

diff --git a/include/dt-bindings/clock/sun55i-a523-ccu.h b/include/dt-bindings/clock/sun55i-a523-ccu.h
new file mode 100644
index 00000000000..c8259ac5ada
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-ccu.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_
+#define _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_
+
+#define CLK_PLL_DDR0		0
+#define CLK_PLL_PERIPH0_4X	1
+#define CLK_PLL_PERIPH0_2X	2
+#define CLK_PLL_PERIPH0_800M	3
+#define CLK_PLL_PERIPH0_480M	4
+#define CLK_PLL_PERIPH0_600M	5
+#define CLK_PLL_PERIPH0_400M	6
+#define CLK_PLL_PERIPH0_300M	7
+#define CLK_PLL_PERIPH0_200M	8
+#define CLK_PLL_PERIPH0_160M	9
+#define CLK_PLL_PERIPH0_150M	10
+#define CLK_PLL_PERIPH1_4X	11
+#define CLK_PLL_PERIPH1_2X	12
+#define CLK_PLL_PERIPH1_800M	13
+#define CLK_PLL_PERIPH1_480M	14
+#define CLK_PLL_PERIPH1_600M	15
+#define CLK_PLL_PERIPH1_400M	16
+#define CLK_PLL_PERIPH1_300M	17
+#define CLK_PLL_PERIPH1_200M	18
+#define CLK_PLL_PERIPH1_160M	19
+#define CLK_PLL_PERIPH1_150M	20
+#define CLK_PLL_GPU		21
+#define CLK_PLL_VIDEO0_8X	22
+#define CLK_PLL_VIDEO0_4X	23
+#define CLK_PLL_VIDEO0_3X	24
+#define CLK_PLL_VIDEO1_8X	25
+#define CLK_PLL_VIDEO1_4X	26
+#define CLK_PLL_VIDEO1_3X	27
+#define CLK_PLL_VIDEO2_8X	28
+#define CLK_PLL_VIDEO2_4X	29
+#define CLK_PLL_VIDEO2_3X	30
+#define CLK_PLL_VIDEO3_8X	31
+#define CLK_PLL_VIDEO3_4X	32
+#define CLK_PLL_VIDEO3_3X	33
+#define CLK_PLL_VE		34
+#define CLK_PLL_AUDIO0_4X	35
+#define CLK_PLL_AUDIO0_2X	36
+#define CLK_PLL_AUDIO0		37
+#define CLK_PLL_NPU_4X		38
+#define CLK_PLL_NPU_2X		39
+#define CLK_PLL_NPU		40
+#define CLK_AHB			41
+#define CLK_APB0		42
+#define CLK_APB1		43
+#define CLK_MBUS		44
+#define CLK_DE			45
+#define CLK_BUS_DE		46
+#define CLK_DI			47
+#define CLK_BUS_DI		48
+#define CLK_G2D			49
+#define CLK_BUS_G2D		50
+#define CLK_GPU			51
+#define CLK_BUS_GPU		52
+#define CLK_CE			53
+#define CLK_BUS_CE		54
+#define CLK_BUS_CE_SYS		55
+#define CLK_VE			56
+#define CLK_BUS_VE		57
+#define CLK_BUS_DMA		58
+#define CLK_BUS_MSGBOX		59
+#define CLK_BUS_SPINLOCK	60
+#define CLK_HSTIMER0		61
+#define CLK_HSTIMER1		62
+#define CLK_HSTIMER2		63
+#define CLK_HSTIMER3		64
+#define CLK_HSTIMER4		65
+#define CLK_HSTIMER5		66
+#define CLK_BUS_HSTIMER		67
+#define CLK_BUS_DBG		68
+#define CLK_BUS_PWM0		69
+#define CLK_BUS_PWM1		70
+#define CLK_IOMMU		71
+#define CLK_BUS_IOMMU		72
+#define CLK_DRAM		73
+#define CLK_MBUS_DMA		74
+#define CLK_MBUS_VE		75
+#define CLK_MBUS_CE		76
+#define CLK_MBUS_CSI		77
+#define CLK_MBUS_ISP		78
+#define CLK_MBUS_EMAC1		79
+#define CLK_BUS_DRAM		80
+#define CLK_NAND0		81
+#define CLK_NAND1		82
+#define CLK_BUS_NAND		83
+#define CLK_MMC0		84
+#define CLK_MMC1		85
+#define CLK_MMC2		86
+#define CLK_BUS_SYSDAP		87
+#define CLK_BUS_MMC0		88
+#define CLK_BUS_MMC1		89
+#define CLK_BUS_MMC2		90
+#define CLK_BUS_UART0		91
+#define CLK_BUS_UART1		92
+#define CLK_BUS_UART2		93
+#define CLK_BUS_UART3		94
+#define CLK_BUS_UART4		95
+#define CLK_BUS_UART5		96
+#define CLK_BUS_UART6		97
+#define CLK_BUS_UART7		98
+#define CLK_BUS_I2C0		99
+#define CLK_BUS_I2C1		100
+#define CLK_BUS_I2C2		101
+#define CLK_BUS_I2C3		102
+#define CLK_BUS_I2C4		103
+#define CLK_BUS_I2C5		104
+#define CLK_BUS_CAN		105
+#define CLK_SPI0		106
+#define CLK_SPI1		107
+#define CLK_SPI2		108
+#define CLK_SPIFC		109
+#define CLK_BUS_SPI0		110
+#define CLK_BUS_SPI1		111
+#define CLK_BUS_SPI2		112
+#define CLK_BUS_SPIFC		113
+#define CLK_EMAC0_25M		114
+#define CLK_EMAC1_25M		115
+#define CLK_BUS_EMAC0		116
+#define CLK_BUS_EMAC1		117
+#define CLK_IR_RX		118
+#define CLK_BUS_IR_RX		119
+#define CLK_IR_TX		120
+#define CLK_BUS_IR_TX		121
+#define CLK_GPADC0		122
+#define CLK_GPADC1		123
+#define CLK_BUS_GPADC0		124
+#define CLK_BUS_GPADC1		125
+#define CLK_BUS_THS		126
+#define CLK_USB_OHCI0		127
+#define CLK_USB_OHCI1		128
+#define CLK_BUS_OHCI0		129
+#define CLK_BUS_OHCI1		130
+#define CLK_BUS_EHCI0		131
+#define CLK_BUS_EHCI1		132
+#define CLK_BUS_OTG		133
+#define CLK_BUS_LRADC		134
+#define CLK_PCIE_AUX		135
+#define CLK_BUS_DISPLAY0_TOP	136
+#define CLK_BUS_DISPLAY1_TOP	137
+#define CLK_HDMI_24M		138
+#define CLK_HDMI_CEC_32K	139
+#define CLK_HDMI_CEC		140
+#define CLK_BUS_HDMI		141
+#define CLK_MIPI_DSI0		142
+#define CLK_MIPI_DSI1		143
+#define CLK_BUS_MIPI_DSI0	144
+#define CLK_BUS_MIPI_DSI1	145
+#define CLK_TCON_LCD0		146
+#define CLK_TCON_LCD1		147
+#define CLK_TCON_LCD2		148
+#define CLK_COMBOPHY_DSI0	149
+#define CLK_COMBOPHY_DSI1	150
+#define CLK_BUS_TCON_LCD0	151
+#define CLK_BUS_TCON_LCD1	152
+#define CLK_BUS_TCON_LCD2	153
+#define CLK_TCON_TV0		154
+#define CLK_TCON_TV1		155
+#define CLK_BUS_TCON_TV0	156
+#define CLK_BUS_TCON_TV1	157
+#define CLK_EDP			158
+#define CLK_BUS_EDP		159
+#define CLK_LEDC		160
+#define CLK_BUS_LEDC		161
+#define CLK_CSI_TOP		162
+#define CLK_CSI_MCLK0		163
+#define CLK_CSI_MCLK1		164
+#define CLK_CSI_MCLK2		165
+#define CLK_CSI_MCLK3		166
+#define CLK_BUS_CSI		167
+#define CLK_ISP			168
+#define CLK_DSP			169
+#define CLK_FANOUT_24M		170
+#define CLK_FANOUT_12M		171
+#define CLK_FANOUT_16M		172
+#define CLK_FANOUT_25M		173
+#define CLK_FANOUT_27M		174
+#define CLK_FANOUT_PCLK		175
+#define CLK_FANOUT0		176
+#define CLK_FANOUT1		177
+#define CLK_FANOUT2		178
+
+#endif /* _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun55i-a523-r-ccu.h b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
new file mode 100644
index 00000000000..365647499b9
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_R_APB1		2
+#define CLK_R_TIMER0		3
+#define CLK_R_TIMER1		4
+#define CLK_R_TIMER2		5
+#define CLK_BUS_R_TIMER		6
+#define CLK_BUS_R_TWD		7
+#define CLK_R_PWMCTRL		8
+#define CLK_BUS_R_PWMCTRL	9
+#define CLK_R_SPI		10
+#define CLK_BUS_R_SPI		11
+#define CLK_BUS_R_SPINLOCK	12
+#define CLK_BUS_R_MSGBOX	13
+#define CLK_BUS_R_UART0		14
+#define CLK_BUS_R_UART1		15
+#define CLK_BUS_R_I2C0		16
+#define CLK_BUS_R_I2C1		17
+#define CLK_BUS_R_I2C2		18
+#define CLK_BUS_R_PPU0		19
+#define CLK_BUS_R_PPU1		20
+#define CLK_BUS_R_CPU_BIST	21
+#define CLK_R_IR_RX		22
+#define CLK_BUS_R_IR_RX		23
+#define CLK_BUS_R_DMA		24
+#define CLK_BUS_R_RTC		25
+#define CLK_BUS_R_CPUCFG	26
+
+#endif /* _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun55i-a523-ccu.h b/include/dt-bindings/reset/sun55i-a523-ccu.h
new file mode 100644
index 00000000000..70df503f34f
--- /dev/null
+++ b/include/dt-bindings/reset/sun55i-a523-ccu.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN55I_A523_CCU_H_
+#define _DT_BINDINGS_RST_SUN55I_A523_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_NSI		1
+#define RST_BUS_DE		2
+#define RST_BUS_DI		3
+#define RST_BUS_G2D		4
+#define RST_BUS_SYS		5
+#define RST_BUS_GPU		6
+#define RST_BUS_CE		7
+#define RST_BUS_SYS_CE		8
+#define RST_BUS_VE		9
+#define RST_BUS_DMA		10
+#define RST_BUS_MSGBOX		11
+#define RST_BUS_SPINLOCK	12
+#define RST_BUS_CPUXTIMER	13
+#define RST_BUS_DBG		14
+#define RST_BUS_PWM0		15
+#define RST_BUS_PWM1		16
+#define RST_BUS_DRAM		17
+#define RST_BUS_NAND		18
+#define RST_BUS_MMC0		19
+#define RST_BUS_MMC1		20
+#define RST_BUS_MMC2		21
+#define RST_BUS_SYSDAP		22
+#define RST_BUS_UART0		23
+#define RST_BUS_UART1		24
+#define RST_BUS_UART2		25
+#define RST_BUS_UART3		26
+#define RST_BUS_UART4		27
+#define RST_BUS_UART5		28
+#define RST_BUS_UART6		29
+#define RST_BUS_UART7		30
+#define RST_BUS_I2C0		31
+#define RST_BUS_I2C1		32
+#define RST_BUS_I2C2		33
+#define RST_BUS_I2C3		34
+#define RST_BUS_I2C4		35
+#define RST_BUS_I2C5		36
+#define RST_BUS_CAN		37
+#define RST_BUS_SPI0		38
+#define RST_BUS_SPI1		39
+#define RST_BUS_SPI2		40
+#define RST_BUS_SPIFC		41
+#define RST_BUS_EMAC0		42
+#define RST_BUS_EMAC1		43
+#define RST_BUS_IR_RX		44
+#define RST_BUS_IR_TX		45
+#define RST_BUS_GPADC0		46
+#define RST_BUS_GPADC1		47
+#define RST_BUS_THS		48
+#define RST_USB_PHY0		49
+#define RST_USB_PHY1		50
+#define RST_BUS_OHCI0		51
+#define RST_BUS_OHCI1		52
+#define RST_BUS_EHCI0		53
+#define RST_BUS_EHCI1		54
+#define RST_BUS_OTG		55
+#define RST_BUS_3		56
+#define RST_BUS_LRADC		57
+#define RST_BUS_PCIE_USB3	58
+#define RST_BUS_DISPLAY0_TOP	59
+#define RST_BUS_DISPLAY1_TOP	60
+#define RST_BUS_HDMI_MAIN	61
+#define RST_BUS_HDMI_SUB	62
+#define RST_BUS_MIPI_DSI0	63
+#define RST_BUS_MIPI_DSI1	64
+#define RST_BUS_TCON_LCD0	65
+#define RST_BUS_TCON_LCD1	66
+#define RST_BUS_TCON_LCD2	67
+#define RST_BUS_TCON_TV0	68
+#define RST_BUS_TCON_TV1	69
+#define RST_BUS_LVDS0		70
+#define RST_BUS_LVDS1		71
+#define RST_BUS_EDP		72
+#define RST_BUS_VIDEO_OUT0	73
+#define RST_BUS_VIDEO_OUT1	74
+#define RST_BUS_LEDC		75
+#define RST_BUS_CSI		76
+#define RST_BUS_ISP		77
+
+#endif /* _DT_BINDINGS_RST_SUN55I_A523_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun55i-a523-r-ccu.h b/include/dt-bindings/reset/sun55i-a523-r-ccu.h
new file mode 100644
index 00000000000..dd6fbb372e1
--- /dev/null
+++ b/include/dt-bindings/reset/sun55i-a523-r-ccu.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_TWD		1
+#define RST_BUS_R_PWMCTRL	2
+#define RST_BUS_R_SPI		3
+#define RST_BUS_R_SPINLOCK	4
+#define RST_BUS_R_MSGBOX	5
+#define RST_BUS_R_UART0		6
+#define RST_BUS_R_UART1		7
+#define RST_BUS_R_I2C0		8
+#define RST_BUS_R_I2C1		9
+#define RST_BUS_R_I2C2		10
+#define RST_BUS_R_PPU1		11
+#define RST_BUS_R_IR_RX		12
+#define RST_BUS_R_RTC		13
+#define RST_BUS_R_CPUCFG	14
+
+#endif /* _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_ */
-- 
2.46.3

