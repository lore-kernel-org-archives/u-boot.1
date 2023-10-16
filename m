Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEA0CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9611286F34;
	Mon, 16 Oct 2023 11:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F2386B1D; Mon, 16 Oct 2023 11:26:10 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 6C74286EE0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418303"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:02 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7123341F934A;
 Mon, 16 Oct 2023 18:25:59 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 02/21] dt-bindings: Add RZ/G2L CPG bindings
Date: Mon, 16 Oct 2023 10:25:24 +0100
Message-Id: <20231016092543.3833-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
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

Import bindings for the Clock Pulse Generator (CPG) module in the
Renesas RZ/G2L SoC family.

This patch is based on the dt-bindings in Linux v6.5
(commit 52e12027d50affbf60c6c9c64db8017391b0c22e).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3: No changes.
v1->v2:
  * Added the exact Linux commit we imported from.
  * Add Marek's Reivewed-by.

 include/dt-bindings/clock/r9a07g044-cpg.h | 220 ++++++++++++++++++++++
 1 file changed, 220 insertions(+)
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h

diff --git a/include/dt-bindings/clock/r9a07g044-cpg.h b/include/dt-bindings/clock/r9a07g044-cpg.h
new file mode 100644
index 000000000000..0bb17ff1a01a
--- /dev/null
+++ b/include/dt-bindings/clock/r9a07g044-cpg.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__
+#define __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R9A07G044 CPG Core Clocks */
+#define R9A07G044_CLK_I			0
+#define R9A07G044_CLK_I2		1
+#define R9A07G044_CLK_G			2
+#define R9A07G044_CLK_S0		3
+#define R9A07G044_CLK_S1		4
+#define R9A07G044_CLK_SPI0		5
+#define R9A07G044_CLK_SPI1		6
+#define R9A07G044_CLK_SD0		7
+#define R9A07G044_CLK_SD1		8
+#define R9A07G044_CLK_M0		9
+#define R9A07G044_CLK_M1		10
+#define R9A07G044_CLK_M2		11
+#define R9A07G044_CLK_M3		12
+#define R9A07G044_CLK_M4		13
+#define R9A07G044_CLK_HP		14
+#define R9A07G044_CLK_TSU		15
+#define R9A07G044_CLK_ZT		16
+#define R9A07G044_CLK_P0		17
+#define R9A07G044_CLK_P1		18
+#define R9A07G044_CLK_P2		19
+#define R9A07G044_CLK_AT		20
+#define R9A07G044_OSCCLK		21
+#define R9A07G044_CLK_P0_DIV2		22
+
+/* R9A07G044 Module Clocks */
+#define R9A07G044_CA55_SCLK		0
+#define R9A07G044_CA55_PCLK		1
+#define R9A07G044_CA55_ATCLK		2
+#define R9A07G044_CA55_GICCLK		3
+#define R9A07G044_CA55_PERICLK		4
+#define R9A07G044_CA55_ACLK		5
+#define R9A07G044_CA55_TSCLK		6
+#define R9A07G044_GIC600_GICCLK		7
+#define R9A07G044_IA55_CLK		8
+#define R9A07G044_IA55_PCLK		9
+#define R9A07G044_MHU_PCLK		10
+#define R9A07G044_SYC_CNT_CLK		11
+#define R9A07G044_DMAC_ACLK		12
+#define R9A07G044_DMAC_PCLK		13
+#define R9A07G044_OSTM0_PCLK		14
+#define R9A07G044_OSTM1_PCLK		15
+#define R9A07G044_OSTM2_PCLK		16
+#define R9A07G044_MTU_X_MCK_MTU3	17
+#define R9A07G044_POE3_CLKM_POE		18
+#define R9A07G044_GPT_PCLK		19
+#define R9A07G044_POEG_A_CLKP		20
+#define R9A07G044_POEG_B_CLKP		21
+#define R9A07G044_POEG_C_CLKP		22
+#define R9A07G044_POEG_D_CLKP		23
+#define R9A07G044_WDT0_PCLK		24
+#define R9A07G044_WDT0_CLK		25
+#define R9A07G044_WDT1_PCLK		26
+#define R9A07G044_WDT1_CLK		27
+#define R9A07G044_WDT2_PCLK		28
+#define R9A07G044_WDT2_CLK		29
+#define R9A07G044_SPI_CLK2		30
+#define R9A07G044_SPI_CLK		31
+#define R9A07G044_SDHI0_IMCLK		32
+#define R9A07G044_SDHI0_IMCLK2		33
+#define R9A07G044_SDHI0_CLK_HS		34
+#define R9A07G044_SDHI0_ACLK		35
+#define R9A07G044_SDHI1_IMCLK		36
+#define R9A07G044_SDHI1_IMCLK2		37
+#define R9A07G044_SDHI1_CLK_HS		38
+#define R9A07G044_SDHI1_ACLK		39
+#define R9A07G044_GPU_CLK		40
+#define R9A07G044_GPU_AXI_CLK		41
+#define R9A07G044_GPU_ACE_CLK		42
+#define R9A07G044_ISU_ACLK		43
+#define R9A07G044_ISU_PCLK		44
+#define R9A07G044_H264_CLK_A		45
+#define R9A07G044_H264_CLK_P		46
+#define R9A07G044_CRU_SYSCLK		47
+#define R9A07G044_CRU_VCLK		48
+#define R9A07G044_CRU_PCLK		49
+#define R9A07G044_CRU_ACLK		50
+#define R9A07G044_MIPI_DSI_PLLCLK	51
+#define R9A07G044_MIPI_DSI_SYSCLK	52
+#define R9A07G044_MIPI_DSI_ACLK		53
+#define R9A07G044_MIPI_DSI_PCLK		54
+#define R9A07G044_MIPI_DSI_VCLK		55
+#define R9A07G044_MIPI_DSI_LPCLK	56
+#define R9A07G044_LCDC_CLK_A		57
+#define R9A07G044_LCDC_CLK_P		58
+#define R9A07G044_LCDC_CLK_D		59
+#define R9A07G044_SSI0_PCLK2		60
+#define R9A07G044_SSI0_PCLK_SFR		61
+#define R9A07G044_SSI1_PCLK2		62
+#define R9A07G044_SSI1_PCLK_SFR		63
+#define R9A07G044_SSI2_PCLK2		64
+#define R9A07G044_SSI2_PCLK_SFR		65
+#define R9A07G044_SSI3_PCLK2		66
+#define R9A07G044_SSI3_PCLK_SFR		67
+#define R9A07G044_SRC_CLKP		68
+#define R9A07G044_USB_U2H0_HCLK		69
+#define R9A07G044_USB_U2H1_HCLK		70
+#define R9A07G044_USB_U2P_EXR_CPUCLK	71
+#define R9A07G044_USB_PCLK		72
+#define R9A07G044_ETH0_CLK_AXI		73
+#define R9A07G044_ETH0_CLK_CHI		74
+#define R9A07G044_ETH1_CLK_AXI		75
+#define R9A07G044_ETH1_CLK_CHI		76
+#define R9A07G044_I2C0_PCLK		77
+#define R9A07G044_I2C1_PCLK		78
+#define R9A07G044_I2C2_PCLK		79
+#define R9A07G044_I2C3_PCLK		80
+#define R9A07G044_SCIF0_CLK_PCK		81
+#define R9A07G044_SCIF1_CLK_PCK		82
+#define R9A07G044_SCIF2_CLK_PCK		83
+#define R9A07G044_SCIF3_CLK_PCK		84
+#define R9A07G044_SCIF4_CLK_PCK		85
+#define R9A07G044_SCI0_CLKP		86
+#define R9A07G044_SCI1_CLKP		87
+#define R9A07G044_IRDA_CLKP		88
+#define R9A07G044_RSPI0_CLKB		89
+#define R9A07G044_RSPI1_CLKB		90
+#define R9A07G044_RSPI2_CLKB		91
+#define R9A07G044_CANFD_PCLK		92
+#define R9A07G044_GPIO_HCLK		93
+#define R9A07G044_ADC_ADCLK		94
+#define R9A07G044_ADC_PCLK		95
+#define R9A07G044_TSU_PCLK		96
+
+/* R9A07G044 Resets */
+#define R9A07G044_CA55_RST_1_0		0
+#define R9A07G044_CA55_RST_1_1		1
+#define R9A07G044_CA55_RST_3_0		2
+#define R9A07G044_CA55_RST_3_1		3
+#define R9A07G044_CA55_RST_4		4
+#define R9A07G044_CA55_RST_5		5
+#define R9A07G044_CA55_RST_6		6
+#define R9A07G044_CA55_RST_7		7
+#define R9A07G044_CA55_RST_8		8
+#define R9A07G044_CA55_RST_9		9
+#define R9A07G044_CA55_RST_10		10
+#define R9A07G044_CA55_RST_11		11
+#define R9A07G044_CA55_RST_12		12
+#define R9A07G044_GIC600_GICRESET_N	13
+#define R9A07G044_GIC600_DBG_GICRESET_N	14
+#define R9A07G044_IA55_RESETN		15
+#define R9A07G044_MHU_RESETN		16
+#define R9A07G044_DMAC_ARESETN		17
+#define R9A07G044_DMAC_RST_ASYNC	18
+#define R9A07G044_SYC_RESETN		19
+#define R9A07G044_OSTM0_PRESETZ		20
+#define R9A07G044_OSTM1_PRESETZ		21
+#define R9A07G044_OSTM2_PRESETZ		22
+#define R9A07G044_MTU_X_PRESET_MTU3	23
+#define R9A07G044_POE3_RST_M_REG	24
+#define R9A07G044_GPT_RST_C		25
+#define R9A07G044_POEG_A_RST		26
+#define R9A07G044_POEG_B_RST		27
+#define R9A07G044_POEG_C_RST		28
+#define R9A07G044_POEG_D_RST		29
+#define R9A07G044_WDT0_PRESETN		30
+#define R9A07G044_WDT1_PRESETN		31
+#define R9A07G044_WDT2_PRESETN		32
+#define R9A07G044_SPI_RST		33
+#define R9A07G044_SDHI0_IXRST		34
+#define R9A07G044_SDHI1_IXRST		35
+#define R9A07G044_GPU_RESETN		36
+#define R9A07G044_GPU_AXI_RESETN	37
+#define R9A07G044_GPU_ACE_RESETN	38
+#define R9A07G044_ISU_ARESETN		39
+#define R9A07G044_ISU_PRESETN		40
+#define R9A07G044_H264_X_RESET_VCP	41
+#define R9A07G044_H264_CP_PRESET_P	42
+#define R9A07G044_CRU_CMN_RSTB		43
+#define R9A07G044_CRU_PRESETN		44
+#define R9A07G044_CRU_ARESETN		45
+#define R9A07G044_MIPI_DSI_CMN_RSTB	46
+#define R9A07G044_MIPI_DSI_ARESET_N	47
+#define R9A07G044_MIPI_DSI_PRESET_N	48
+#define R9A07G044_LCDC_RESET_N		49
+#define R9A07G044_SSI0_RST_M2_REG	50
+#define R9A07G044_SSI1_RST_M2_REG	51
+#define R9A07G044_SSI2_RST_M2_REG	52
+#define R9A07G044_SSI3_RST_M2_REG	53
+#define R9A07G044_SRC_RST		54
+#define R9A07G044_USB_U2H0_HRESETN	55
+#define R9A07G044_USB_U2H1_HRESETN	56
+#define R9A07G044_USB_U2P_EXL_SYSRST	57
+#define R9A07G044_USB_PRESETN		58
+#define R9A07G044_ETH0_RST_HW_N		59
+#define R9A07G044_ETH1_RST_HW_N		60
+#define R9A07G044_I2C0_MRST		61
+#define R9A07G044_I2C1_MRST		62
+#define R9A07G044_I2C2_MRST		63
+#define R9A07G044_I2C3_MRST		64
+#define R9A07G044_SCIF0_RST_SYSTEM_N	65
+#define R9A07G044_SCIF1_RST_SYSTEM_N	66
+#define R9A07G044_SCIF2_RST_SYSTEM_N	67
+#define R9A07G044_SCIF3_RST_SYSTEM_N	68
+#define R9A07G044_SCIF4_RST_SYSTEM_N	69
+#define R9A07G044_SCI0_RST		70
+#define R9A07G044_SCI1_RST		71
+#define R9A07G044_IRDA_RST		72
+#define R9A07G044_RSPI0_RST		73
+#define R9A07G044_RSPI1_RST		74
+#define R9A07G044_RSPI2_RST		75
+#define R9A07G044_CANFD_RSTP_N		76
+#define R9A07G044_CANFD_RSTC_N		77
+#define R9A07G044_GPIO_RSTN		78
+#define R9A07G044_GPIO_PORT_RESETN	79
+#define R9A07G044_GPIO_SPARE_RESETN	80
+#define R9A07G044_ADC_PRESETN		81
+#define R9A07G044_ADC_ADRST_N		82
+#define R9A07G044_TSU_PRESETN		83
+
+#endif /* __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__ */
-- 
2.39.2

