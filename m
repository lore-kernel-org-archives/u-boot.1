Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F30C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 13:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F70881BA;
	Fri, 12 Jul 2024 15:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEDF87D07; Fri, 12 Jul 2024 15:17:43 +0200 (CEST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72B6881BA
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 15:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=geert@linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9b6b:6da0:997b:7165])
 by andre.telenet-ops.be with bizsmtp
 id mdHg2C00C46XLxg01dHgti; Fri, 12 Jul 2024 15:17:40 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtp (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1sSG9N-001q18-DX;
 Fri, 12 Jul 2024 15:17:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1sSG9c-000V4I-1Z;
 Fri, 12 Jul 2024 15:17:40 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Tom Rini <trini@konsulko.com>,
	Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH uboot] dt-bindings: clock: rcar-gen2: Remove obsolete header
 files
Date: Fri, 12 Jul 2024 15:17:38 +0200
Message-Id: <6355fbaa5e3c40d6790cb5aa6ffc1c573c1f08ed.1720790104.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
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

The clock definitions in <dt-bindings/clock/r8a779?-clock.h> were
superseded by those in <dt-bindings/clock/r8a779?-cpg-mssr.h> a long
time ago.

In fact U-Boot never used <dt-bindings/clock/r8a779?-clock.h>.
The unused headers, their replacements, and the corresponding
r8a779?.dtsi files were introduced together in U-Boot v2018.03.

Fixes: 16b6e4aa3732cee1 ("ARM: dts: rmobile: Import R8A7790 DTS from Linux 4.15-rc8")
Fixes: edd15fcffba31452 ("ARM: dts: rmobile: Import R8A7791 DTS from Linux 4.15-rc8")
Fixes: a3fb9ff3b33fae05 ("ARM: dts: rmobile: Import R8A7792 DTS from Linux 4.15-rc8")
Fixes: 92aa09959271d08f ("ARM: dts: rmobile: Import R8A7793 DTS from Linux 4.15-rc8")
Fixes: 9a26fc5a73fe2369 ("ARM: dts: rmobile: Import R8A7794 DTS from Linux 4.15-rc8")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cfr. https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=d6c5fc9add9eb7a0d5bd179ab07cbf43e32b28d8

I assume the corresponding header files under
dts/upstream/include/dt-bindings/clock/ will be removed automatically
in a future "Subtree merge tag 'v6.11-dts' of devicetree-rebasing repo
[1] into dts/upstream" commit?
---
 include/dt-bindings/clock/r8a7790-clock.h | 158 ---------------------
 include/dt-bindings/clock/r8a7791-clock.h | 161 ----------------------
 include/dt-bindings/clock/r8a7792-clock.h |  98 -------------
 include/dt-bindings/clock/r8a7793-clock.h | 159 ---------------------
 include/dt-bindings/clock/r8a7794-clock.h | 137 ------------------
 5 files changed, 713 deletions(-)
 delete mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7791-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7792-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7793-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7794-clock.h

diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
deleted file mode 100644
index c92ff1e6022369e5..0000000000000000
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ /dev/null
@@ -1,158 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright 2013 Ideas On Board SPRL
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7790_H__
-#define __DT_BINDINGS_CLOCK_R8A7790_H__
-
-/* CPG */
-#define R8A7790_CLK_MAIN		0
-#define R8A7790_CLK_PLL0		1
-#define R8A7790_CLK_PLL1		2
-#define R8A7790_CLK_PLL3		3
-#define R8A7790_CLK_LB			4
-#define R8A7790_CLK_QSPI		5
-#define R8A7790_CLK_SDH			6
-#define R8A7790_CLK_SD0			7
-#define R8A7790_CLK_SD1			8
-#define R8A7790_CLK_Z			9
-#define R8A7790_CLK_RCAN		10
-#define R8A7790_CLK_ADSP		11
-
-/* MSTP0 */
-#define R8A7790_CLK_MSIOF0		0
-
-/* MSTP1 */
-#define R8A7790_CLK_VCP1		0
-#define R8A7790_CLK_VCP0		1
-#define R8A7790_CLK_VPC1		2
-#define R8A7790_CLK_VPC0		3
-#define R8A7790_CLK_JPU			6
-#define R8A7790_CLK_SSP1		9
-#define R8A7790_CLK_TMU1		11
-#define R8A7790_CLK_3DG			12
-#define R8A7790_CLK_2DDMAC		15
-#define R8A7790_CLK_FDP1_2		17
-#define R8A7790_CLK_FDP1_1		18
-#define R8A7790_CLK_FDP1_0		19
-#define R8A7790_CLK_TMU3		21
-#define R8A7790_CLK_TMU2		22
-#define R8A7790_CLK_CMT0		24
-#define R8A7790_CLK_TMU0		25
-#define R8A7790_CLK_VSP1_DU1		27
-#define R8A7790_CLK_VSP1_DU0		28
-#define R8A7790_CLK_VSP1_R		30
-#define R8A7790_CLK_VSP1_S		31
-
-/* MSTP2 */
-#define R8A7790_CLK_SCIFA2		2
-#define R8A7790_CLK_SCIFA1		3
-#define R8A7790_CLK_SCIFA0		4
-#define R8A7790_CLK_MSIOF2		5
-#define R8A7790_CLK_SCIFB0		6
-#define R8A7790_CLK_SCIFB1		7
-#define R8A7790_CLK_MSIOF1		8
-#define R8A7790_CLK_MSIOF3		15
-#define R8A7790_CLK_SCIFB2		16
-#define R8A7790_CLK_SYS_DMAC1		18
-#define R8A7790_CLK_SYS_DMAC0		19
-
-/* MSTP3 */
-#define R8A7790_CLK_IIC2		0
-#define R8A7790_CLK_TPU0		4
-#define R8A7790_CLK_MMCIF1		5
-#define R8A7790_CLK_SCIF2		10
-#define R8A7790_CLK_SDHI3		11
-#define R8A7790_CLK_SDHI2		12
-#define R8A7790_CLK_SDHI1		13
-#define R8A7790_CLK_SDHI0		14
-#define R8A7790_CLK_MMCIF0		15
-#define R8A7790_CLK_IIC0		18
-#define R8A7790_CLK_PCIEC		19
-#define R8A7790_CLK_IIC1		23
-#define R8A7790_CLK_SSUSB		28
-#define R8A7790_CLK_CMT1		29
-#define R8A7790_CLK_USBDMAC0		30
-#define R8A7790_CLK_USBDMAC1		31
-
-/* MSTP4 */
-#define R8A7790_CLK_IRQC		7
-#define R8A7790_CLK_INTC_SYS		8
-
-/* MSTP5 */
-#define R8A7790_CLK_AUDIO_DMAC1		1
-#define R8A7790_CLK_AUDIO_DMAC0		2
-#define R8A7790_CLK_ADSP_MOD		6
-#define R8A7790_CLK_THERMAL		22
-#define R8A7790_CLK_PWM			23
-
-/* MSTP7 */
-#define R8A7790_CLK_EHCI		3
-#define R8A7790_CLK_HSUSB		4
-#define R8A7790_CLK_HSCIF1		16
-#define R8A7790_CLK_HSCIF0		17
-#define R8A7790_CLK_SCIF1		20
-#define R8A7790_CLK_SCIF0		21
-#define R8A7790_CLK_DU2			22
-#define R8A7790_CLK_DU1			23
-#define R8A7790_CLK_DU0			24
-#define R8A7790_CLK_LVDS1		25
-#define R8A7790_CLK_LVDS0		26
-
-/* MSTP8 */
-#define R8A7790_CLK_MLB			2
-#define R8A7790_CLK_VIN3		8
-#define R8A7790_CLK_VIN2		9
-#define R8A7790_CLK_VIN1		10
-#define R8A7790_CLK_VIN0		11
-#define R8A7790_CLK_ETHERAVB		12
-#define R8A7790_CLK_ETHER		13
-#define R8A7790_CLK_SATA1		14
-#define R8A7790_CLK_SATA0		15
-
-/* MSTP9 */
-#define R8A7790_CLK_GPIO5		7
-#define R8A7790_CLK_GPIO4		8
-#define R8A7790_CLK_GPIO3		9
-#define R8A7790_CLK_GPIO2		10
-#define R8A7790_CLK_GPIO1		11
-#define R8A7790_CLK_GPIO0		12
-#define R8A7790_CLK_RCAN1		15
-#define R8A7790_CLK_RCAN0		16
-#define R8A7790_CLK_QSPI_MOD		17
-#define R8A7790_CLK_IICDVFS		26
-#define R8A7790_CLK_I2C3		28
-#define R8A7790_CLK_I2C2		29
-#define R8A7790_CLK_I2C1		30
-#define R8A7790_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7790_CLK_SSI_ALL		5
-#define R8A7790_CLK_SSI9		6
-#define R8A7790_CLK_SSI8		7
-#define R8A7790_CLK_SSI7		8
-#define R8A7790_CLK_SSI6		9
-#define R8A7790_CLK_SSI5		10
-#define R8A7790_CLK_SSI4		11
-#define R8A7790_CLK_SSI3		12
-#define R8A7790_CLK_SSI2		13
-#define R8A7790_CLK_SSI1		14
-#define R8A7790_CLK_SSI0		15
-#define R8A7790_CLK_SCU_ALL		17
-#define R8A7790_CLK_SCU_DVC1		18
-#define R8A7790_CLK_SCU_DVC0		19
-#define R8A7790_CLK_SCU_CTU1_MIX1	20
-#define R8A7790_CLK_SCU_CTU0_MIX0	21
-#define R8A7790_CLK_SCU_SRC9		22
-#define R8A7790_CLK_SCU_SRC8		23
-#define R8A7790_CLK_SCU_SRC7		24
-#define R8A7790_CLK_SCU_SRC6		25
-#define R8A7790_CLK_SCU_SRC5		26
-#define R8A7790_CLK_SCU_SRC4		27
-#define R8A7790_CLK_SCU_SRC3		28
-#define R8A7790_CLK_SCU_SRC2		29
-#define R8A7790_CLK_SCU_SRC1		30
-#define R8A7790_CLK_SCU_SRC0		31
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
deleted file mode 100644
index bb4f18b1b3d585cd..0000000000000000
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ /dev/null
@@ -1,161 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright 2013 Ideas On Board SPRL
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7791_H__
-#define __DT_BINDINGS_CLOCK_R8A7791_H__
-
-/* CPG */
-#define R8A7791_CLK_MAIN		0
-#define R8A7791_CLK_PLL0		1
-#define R8A7791_CLK_PLL1		2
-#define R8A7791_CLK_PLL3		3
-#define R8A7791_CLK_LB			4
-#define R8A7791_CLK_QSPI		5
-#define R8A7791_CLK_SDH			6
-#define R8A7791_CLK_SD0			7
-#define R8A7791_CLK_Z			8
-#define R8A7791_CLK_RCAN		9
-#define R8A7791_CLK_ADSP		10
-
-/* MSTP0 */
-#define R8A7791_CLK_MSIOF0		0
-
-/* MSTP1 */
-#define R8A7791_CLK_VCP0		1
-#define R8A7791_CLK_VPC0		3
-#define R8A7791_CLK_JPU			6
-#define R8A7791_CLK_SSP1		9
-#define R8A7791_CLK_TMU1		11
-#define R8A7791_CLK_3DG			12
-#define R8A7791_CLK_2DDMAC		15
-#define R8A7791_CLK_FDP1_1		18
-#define R8A7791_CLK_FDP1_0		19
-#define R8A7791_CLK_TMU3		21
-#define R8A7791_CLK_TMU2		22
-#define R8A7791_CLK_CMT0		24
-#define R8A7791_CLK_TMU0		25
-#define R8A7791_CLK_VSP1_DU1		27
-#define R8A7791_CLK_VSP1_DU0		28
-#define R8A7791_CLK_VSP1_S		31
-
-/* MSTP2 */
-#define R8A7791_CLK_SCIFA2		2
-#define R8A7791_CLK_SCIFA1		3
-#define R8A7791_CLK_SCIFA0		4
-#define R8A7791_CLK_MSIOF2		5
-#define R8A7791_CLK_SCIFB0		6
-#define R8A7791_CLK_SCIFB1		7
-#define R8A7791_CLK_MSIOF1		8
-#define R8A7791_CLK_SCIFB2		16
-#define R8A7791_CLK_SYS_DMAC1		18
-#define R8A7791_CLK_SYS_DMAC0		19
-
-/* MSTP3 */
-#define R8A7791_CLK_TPU0		4
-#define R8A7791_CLK_SDHI2		11
-#define R8A7791_CLK_SDHI1		12
-#define R8A7791_CLK_SDHI0		14
-#define R8A7791_CLK_MMCIF0		15
-#define R8A7791_CLK_IIC0		18
-#define R8A7791_CLK_PCIEC		19
-#define R8A7791_CLK_IIC1		23
-#define R8A7791_CLK_SSUSB		28
-#define R8A7791_CLK_CMT1		29
-#define R8A7791_CLK_USBDMAC0		30
-#define R8A7791_CLK_USBDMAC1		31
-
-/* MSTP4 */
-#define R8A7791_CLK_IRQC		7
-#define R8A7791_CLK_INTC_SYS		8
-
-/* MSTP5 */
-#define R8A7791_CLK_AUDIO_DMAC1		1
-#define R8A7791_CLK_AUDIO_DMAC0		2
-#define R8A7791_CLK_ADSP_MOD		6
-#define R8A7791_CLK_THERMAL		22
-#define R8A7791_CLK_PWM			23
-
-/* MSTP7 */
-#define R8A7791_CLK_EHCI		3
-#define R8A7791_CLK_HSUSB		4
-#define R8A7791_CLK_HSCIF2		13
-#define R8A7791_CLK_SCIF5		14
-#define R8A7791_CLK_SCIF4		15
-#define R8A7791_CLK_HSCIF1		16
-#define R8A7791_CLK_HSCIF0		17
-#define R8A7791_CLK_SCIF3		18
-#define R8A7791_CLK_SCIF2		19
-#define R8A7791_CLK_SCIF1		20
-#define R8A7791_CLK_SCIF0		21
-#define R8A7791_CLK_DU1			23
-#define R8A7791_CLK_DU0			24
-#define R8A7791_CLK_LVDS0		26
-
-/* MSTP8 */
-#define R8A7791_CLK_IPMMU_SGX		0
-#define R8A7791_CLK_MLB			2
-#define R8A7791_CLK_VIN2		9
-#define R8A7791_CLK_VIN1		10
-#define R8A7791_CLK_VIN0		11
-#define R8A7791_CLK_ETHERAVB		12
-#define R8A7791_CLK_ETHER		13
-#define R8A7791_CLK_SATA1		14
-#define R8A7791_CLK_SATA0		15
-
-/* MSTP9 */
-#define R8A7791_CLK_GYROADC		1
-#define R8A7791_CLK_GPIO7		4
-#define R8A7791_CLK_GPIO6		5
-#define R8A7791_CLK_GPIO5		7
-#define R8A7791_CLK_GPIO4		8
-#define R8A7791_CLK_GPIO3		9
-#define R8A7791_CLK_GPIO2		10
-#define R8A7791_CLK_GPIO1		11
-#define R8A7791_CLK_GPIO0		12
-#define R8A7791_CLK_RCAN1		15
-#define R8A7791_CLK_RCAN0		16
-#define R8A7791_CLK_QSPI_MOD		17
-#define R8A7791_CLK_I2C5		25
-#define R8A7791_CLK_IICDVFS		26
-#define R8A7791_CLK_I2C4		27
-#define R8A7791_CLK_I2C3		28
-#define R8A7791_CLK_I2C2		29
-#define R8A7791_CLK_I2C1		30
-#define R8A7791_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7791_CLK_SSI_ALL		5
-#define R8A7791_CLK_SSI9		6
-#define R8A7791_CLK_SSI8		7
-#define R8A7791_CLK_SSI7		8
-#define R8A7791_CLK_SSI6		9
-#define R8A7791_CLK_SSI5		10
-#define R8A7791_CLK_SSI4		11
-#define R8A7791_CLK_SSI3		12
-#define R8A7791_CLK_SSI2		13
-#define R8A7791_CLK_SSI1		14
-#define R8A7791_CLK_SSI0		15
-#define R8A7791_CLK_SCU_ALL		17
-#define R8A7791_CLK_SCU_DVC1		18
-#define R8A7791_CLK_SCU_DVC0		19
-#define R8A7791_CLK_SCU_CTU1_MIX1	20
-#define R8A7791_CLK_SCU_CTU0_MIX0	21
-#define R8A7791_CLK_SCU_SRC9		22
-#define R8A7791_CLK_SCU_SRC8		23
-#define R8A7791_CLK_SCU_SRC7		24
-#define R8A7791_CLK_SCU_SRC6		25
-#define R8A7791_CLK_SCU_SRC5		26
-#define R8A7791_CLK_SCU_SRC4		27
-#define R8A7791_CLK_SCU_SRC3		28
-#define R8A7791_CLK_SCU_SRC2		29
-#define R8A7791_CLK_SCU_SRC1		30
-#define R8A7791_CLK_SCU_SRC0		31
-
-/* MSTP11 */
-#define R8A7791_CLK_SCIFA3		6
-#define R8A7791_CLK_SCIFA4		7
-#define R8A7791_CLK_SCIFA5		8
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7791_H__ */
diff --git a/include/dt-bindings/clock/r8a7792-clock.h b/include/dt-bindings/clock/r8a7792-clock.h
deleted file mode 100644
index 2948d9ce3a14bb1e..0000000000000000
--- a/include/dt-bindings/clock/r8a7792-clock.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2016 Cogent Embedded, Inc.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7792_H__
-#define __DT_BINDINGS_CLOCK_R8A7792_H__
-
-/* CPG */
-#define R8A7792_CLK_MAIN		0
-#define R8A7792_CLK_PLL0		1
-#define R8A7792_CLK_PLL1		2
-#define R8A7792_CLK_PLL3		3
-#define R8A7792_CLK_LB			4
-#define R8A7792_CLK_QSPI		5
-
-/* MSTP0 */
-#define R8A7792_CLK_MSIOF0		0
-
-/* MSTP1 */
-#define R8A7792_CLK_JPU			6
-#define R8A7792_CLK_TMU1		11
-#define R8A7792_CLK_TMU3		21
-#define R8A7792_CLK_TMU2		22
-#define R8A7792_CLK_CMT0		24
-#define R8A7792_CLK_TMU0		25
-#define R8A7792_CLK_VSP1DU1		27
-#define R8A7792_CLK_VSP1DU0		28
-#define R8A7792_CLK_VSP1_SY		31
-
-/* MSTP2 */
-#define R8A7792_CLK_MSIOF1		8
-#define R8A7792_CLK_SYS_DMAC1		18
-#define R8A7792_CLK_SYS_DMAC0		19
-
-/* MSTP3 */
-#define R8A7792_CLK_TPU0		4
-#define R8A7792_CLK_SDHI0		14
-#define R8A7792_CLK_CMT1		29
-
-/* MSTP4 */
-#define R8A7792_CLK_IRQC		7
-#define R8A7792_CLK_INTC_SYS		8
-
-/* MSTP5 */
-#define R8A7792_CLK_AUDIO_DMAC0		2
-#define R8A7792_CLK_THERMAL		22
-#define R8A7792_CLK_PWM			23
-
-/* MSTP7 */
-#define R8A7792_CLK_HSCIF1		16
-#define R8A7792_CLK_HSCIF0		17
-#define R8A7792_CLK_SCIF3		18
-#define R8A7792_CLK_SCIF2		19
-#define R8A7792_CLK_SCIF1		20
-#define R8A7792_CLK_SCIF0		21
-#define R8A7792_CLK_DU1			23
-#define R8A7792_CLK_DU0			24
-
-/* MSTP8 */
-#define R8A7792_CLK_VIN5		4
-#define R8A7792_CLK_VIN4		5
-#define R8A7792_CLK_VIN3		8
-#define R8A7792_CLK_VIN2		9
-#define R8A7792_CLK_VIN1		10
-#define R8A7792_CLK_VIN0		11
-#define R8A7792_CLK_ETHERAVB		12
-
-/* MSTP9 */
-#define R8A7792_CLK_GPIO7		4
-#define R8A7792_CLK_GPIO6		5
-#define R8A7792_CLK_GPIO5		7
-#define R8A7792_CLK_GPIO4		8
-#define R8A7792_CLK_GPIO3		9
-#define R8A7792_CLK_GPIO2		10
-#define R8A7792_CLK_GPIO1		11
-#define R8A7792_CLK_GPIO0		12
-#define R8A7792_CLK_GPIO11		13
-#define R8A7792_CLK_GPIO10		14
-#define R8A7792_CLK_CAN1		15
-#define R8A7792_CLK_CAN0		16
-#define R8A7792_CLK_QSPI_MOD		17
-#define R8A7792_CLK_GPIO9		19
-#define R8A7792_CLK_GPIO8		21
-#define R8A7792_CLK_I2C5		25
-#define R8A7792_CLK_IICDVFS		26
-#define R8A7792_CLK_I2C4		27
-#define R8A7792_CLK_I2C3		28
-#define R8A7792_CLK_I2C2		29
-#define R8A7792_CLK_I2C1		30
-#define R8A7792_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7792_CLK_SSI_ALL		5
-#define R8A7792_CLK_SSI4		11
-#define R8A7792_CLK_SSI3		12
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7792_H__ */
diff --git a/include/dt-bindings/clock/r8a7793-clock.h b/include/dt-bindings/clock/r8a7793-clock.h
deleted file mode 100644
index 49c66d8ed1782fc0..0000000000000000
--- a/include/dt-bindings/clock/r8a7793-clock.h
+++ /dev/null
@@ -1,159 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * r8a7793 clock definition
- *
- * Copyright (C) 2014  Renesas Electronics Corporation
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7793_H__
-#define __DT_BINDINGS_CLOCK_R8A7793_H__
-
-/* CPG */
-#define R8A7793_CLK_MAIN		0
-#define R8A7793_CLK_PLL0		1
-#define R8A7793_CLK_PLL1		2
-#define R8A7793_CLK_PLL3		3
-#define R8A7793_CLK_LB			4
-#define R8A7793_CLK_QSPI		5
-#define R8A7793_CLK_SDH			6
-#define R8A7793_CLK_SD0			7
-#define R8A7793_CLK_Z			8
-#define R8A7793_CLK_RCAN		9
-#define R8A7793_CLK_ADSP		10
-
-/* MSTP0 */
-#define R8A7793_CLK_MSIOF0		0
-
-/* MSTP1 */
-#define R8A7793_CLK_VCP0		1
-#define R8A7793_CLK_VPC0		3
-#define R8A7793_CLK_SSP1		9
-#define R8A7793_CLK_TMU1		11
-#define R8A7793_CLK_3DG			12
-#define R8A7793_CLK_2DDMAC		15
-#define R8A7793_CLK_FDP1_1		18
-#define R8A7793_CLK_FDP1_0		19
-#define R8A7793_CLK_TMU3		21
-#define R8A7793_CLK_TMU2		22
-#define R8A7793_CLK_CMT0		24
-#define R8A7793_CLK_TMU0		25
-#define R8A7793_CLK_VSP1_DU1		27
-#define R8A7793_CLK_VSP1_DU0		28
-#define R8A7793_CLK_VSP1_S		31
-
-/* MSTP2 */
-#define R8A7793_CLK_SCIFA2		2
-#define R8A7793_CLK_SCIFA1		3
-#define R8A7793_CLK_SCIFA0		4
-#define R8A7793_CLK_MSIOF2		5
-#define R8A7793_CLK_SCIFB0		6
-#define R8A7793_CLK_SCIFB1		7
-#define R8A7793_CLK_MSIOF1		8
-#define R8A7793_CLK_SCIFB2		16
-#define R8A7793_CLK_SYS_DMAC1		18
-#define R8A7793_CLK_SYS_DMAC0		19
-
-/* MSTP3 */
-#define R8A7793_CLK_TPU0		4
-#define R8A7793_CLK_SDHI2		11
-#define R8A7793_CLK_SDHI1		12
-#define R8A7793_CLK_SDHI0		14
-#define R8A7793_CLK_MMCIF0		15
-#define R8A7793_CLK_IIC0		18
-#define R8A7793_CLK_PCIEC		19
-#define R8A7793_CLK_IIC1		23
-#define R8A7793_CLK_SSUSB		28
-#define R8A7793_CLK_CMT1		29
-#define R8A7793_CLK_USBDMAC0		30
-#define R8A7793_CLK_USBDMAC1		31
-
-/* MSTP4 */
-#define R8A7793_CLK_IRQC		7
-#define R8A7793_CLK_INTC_SYS		8
-
-/* MSTP5 */
-#define R8A7793_CLK_AUDIO_DMAC1		1
-#define R8A7793_CLK_AUDIO_DMAC0		2
-#define R8A7793_CLK_ADSP_MOD		6
-#define R8A7793_CLK_THERMAL		22
-#define R8A7793_CLK_PWM			23
-
-/* MSTP7 */
-#define R8A7793_CLK_EHCI		3
-#define R8A7793_CLK_HSUSB		4
-#define R8A7793_CLK_HSCIF2		13
-#define R8A7793_CLK_SCIF5		14
-#define R8A7793_CLK_SCIF4		15
-#define R8A7793_CLK_HSCIF1		16
-#define R8A7793_CLK_HSCIF0		17
-#define R8A7793_CLK_SCIF3		18
-#define R8A7793_CLK_SCIF2		19
-#define R8A7793_CLK_SCIF1		20
-#define R8A7793_CLK_SCIF0		21
-#define R8A7793_CLK_DU1			23
-#define R8A7793_CLK_DU0			24
-#define R8A7793_CLK_LVDS0		26
-
-/* MSTP8 */
-#define R8A7793_CLK_IPMMU_SGX		0
-#define R8A7793_CLK_VIN2		9
-#define R8A7793_CLK_VIN1		10
-#define R8A7793_CLK_VIN0		11
-#define R8A7793_CLK_ETHER		13
-#define R8A7793_CLK_SATA1		14
-#define R8A7793_CLK_SATA0		15
-
-/* MSTP9 */
-#define R8A7793_CLK_GPIO7		4
-#define R8A7793_CLK_GPIO6		5
-#define R8A7793_CLK_GPIO5		7
-#define R8A7793_CLK_GPIO4		8
-#define R8A7793_CLK_GPIO3		9
-#define R8A7793_CLK_GPIO2		10
-#define R8A7793_CLK_GPIO1		11
-#define R8A7793_CLK_GPIO0		12
-#define R8A7793_CLK_RCAN1		15
-#define R8A7793_CLK_RCAN0		16
-#define R8A7793_CLK_QSPI_MOD		17
-#define R8A7793_CLK_I2C5		25
-#define R8A7793_CLK_IICDVFS		26
-#define R8A7793_CLK_I2C4		27
-#define R8A7793_CLK_I2C3		28
-#define R8A7793_CLK_I2C2		29
-#define R8A7793_CLK_I2C1		30
-#define R8A7793_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7793_CLK_SSI_ALL		5
-#define R8A7793_CLK_SSI9		6
-#define R8A7793_CLK_SSI8		7
-#define R8A7793_CLK_SSI7		8
-#define R8A7793_CLK_SSI6		9
-#define R8A7793_CLK_SSI5		10
-#define R8A7793_CLK_SSI4		11
-#define R8A7793_CLK_SSI3		12
-#define R8A7793_CLK_SSI2		13
-#define R8A7793_CLK_SSI1		14
-#define R8A7793_CLK_SSI0		15
-#define R8A7793_CLK_SCU_ALL		17
-#define R8A7793_CLK_SCU_DVC1		18
-#define R8A7793_CLK_SCU_DVC0		19
-#define R8A7793_CLK_SCU_CTU1_MIX1	20
-#define R8A7793_CLK_SCU_CTU0_MIX0	21
-#define R8A7793_CLK_SCU_SRC9		22
-#define R8A7793_CLK_SCU_SRC8		23
-#define R8A7793_CLK_SCU_SRC7		24
-#define R8A7793_CLK_SCU_SRC6		25
-#define R8A7793_CLK_SCU_SRC5		26
-#define R8A7793_CLK_SCU_SRC4		27
-#define R8A7793_CLK_SCU_SRC3		28
-#define R8A7793_CLK_SCU_SRC2		29
-#define R8A7793_CLK_SCU_SRC1		30
-#define R8A7793_CLK_SCU_SRC0		31
-
-/* MSTP11 */
-#define R8A7793_CLK_SCIFA3		6
-#define R8A7793_CLK_SCIFA4		7
-#define R8A7793_CLK_SCIFA5		8
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7793_H__ */
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
deleted file mode 100644
index 649f005782d05213..0000000000000000
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ /dev/null
@@ -1,137 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- * Copyright 2013 Ideas On Board SPRL
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7794_H__
-#define __DT_BINDINGS_CLOCK_R8A7794_H__
-
-/* CPG */
-#define R8A7794_CLK_MAIN		0
-#define R8A7794_CLK_PLL0		1
-#define R8A7794_CLK_PLL1		2
-#define R8A7794_CLK_PLL3		3
-#define R8A7794_CLK_LB			4
-#define R8A7794_CLK_QSPI		5
-#define R8A7794_CLK_SDH			6
-#define R8A7794_CLK_SD0			7
-#define R8A7794_CLK_RCAN		8
-
-/* MSTP0 */
-#define R8A7794_CLK_MSIOF0		0
-
-/* MSTP1 */
-#define R8A7794_CLK_VCP0		1
-#define R8A7794_CLK_VPC0		3
-#define R8A7794_CLK_TMU1		11
-#define R8A7794_CLK_3DG			12
-#define R8A7794_CLK_2DDMAC		15
-#define R8A7794_CLK_FDP1_0		19
-#define R8A7794_CLK_TMU3		21
-#define R8A7794_CLK_TMU2		22
-#define R8A7794_CLK_CMT0		24
-#define R8A7794_CLK_TMU0		25
-#define R8A7794_CLK_VSP1_DU0		28
-#define R8A7794_CLK_VSP1_S		31
-
-/* MSTP2 */
-#define R8A7794_CLK_SCIFA2		2
-#define R8A7794_CLK_SCIFA1		3
-#define R8A7794_CLK_SCIFA0		4
-#define R8A7794_CLK_MSIOF2		5
-#define R8A7794_CLK_SCIFB0		6
-#define R8A7794_CLK_SCIFB1		7
-#define R8A7794_CLK_MSIOF1		8
-#define R8A7794_CLK_SCIFB2		16
-#define R8A7794_CLK_SYS_DMAC1		18
-#define R8A7794_CLK_SYS_DMAC0		19
-
-/* MSTP3 */
-#define R8A7794_CLK_SDHI2		11
-#define R8A7794_CLK_SDHI1		12
-#define R8A7794_CLK_SDHI0		14
-#define R8A7794_CLK_MMCIF0		15
-#define R8A7794_CLK_IIC0		18
-#define R8A7794_CLK_IIC1		23
-#define R8A7794_CLK_CMT1		29
-#define R8A7794_CLK_USBDMAC0		30
-#define R8A7794_CLK_USBDMAC1		31
-
-/* MSTP4 */
-#define R8A7794_CLK_IRQC		7
-#define R8A7794_CLK_INTC_SYS		8
-
-/* MSTP5 */
-#define R8A7794_CLK_AUDIO_DMAC0		2
-#define R8A7794_CLK_PWM			23
-
-/* MSTP7 */
-#define R8A7794_CLK_EHCI		3
-#define R8A7794_CLK_HSUSB		4
-#define R8A7794_CLK_HSCIF2		13
-#define R8A7794_CLK_SCIF5		14
-#define R8A7794_CLK_SCIF4		15
-#define R8A7794_CLK_HSCIF1		16
-#define R8A7794_CLK_HSCIF0		17
-#define R8A7794_CLK_SCIF3		18
-#define R8A7794_CLK_SCIF2		19
-#define R8A7794_CLK_SCIF1		20
-#define R8A7794_CLK_SCIF0		21
-#define R8A7794_CLK_DU1			23
-#define R8A7794_CLK_DU0			24
-
-/* MSTP8 */
-#define R8A7794_CLK_VIN1		10
-#define R8A7794_CLK_VIN0		11
-#define R8A7794_CLK_ETHERAVB		12
-#define R8A7794_CLK_ETHER		13
-
-/* MSTP9 */
-#define R8A7794_CLK_GPIO6		5
-#define R8A7794_CLK_GPIO5		7
-#define R8A7794_CLK_GPIO4		8
-#define R8A7794_CLK_GPIO3		9
-#define R8A7794_CLK_GPIO2		10
-#define R8A7794_CLK_GPIO1		11
-#define R8A7794_CLK_GPIO0		12
-#define R8A7794_CLK_RCAN1		15
-#define R8A7794_CLK_RCAN0		16
-#define R8A7794_CLK_QSPI_MOD		17
-#define R8A7794_CLK_I2C5		25
-#define R8A7794_CLK_I2C4		27
-#define R8A7794_CLK_I2C3		28
-#define R8A7794_CLK_I2C2		29
-#define R8A7794_CLK_I2C1		30
-#define R8A7794_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7794_CLK_SSI_ALL		5
-#define R8A7794_CLK_SSI9		6
-#define R8A7794_CLK_SSI8		7
-#define R8A7794_CLK_SSI7		8
-#define R8A7794_CLK_SSI6		9
-#define R8A7794_CLK_SSI5		10
-#define R8A7794_CLK_SSI4		11
-#define R8A7794_CLK_SSI3		12
-#define R8A7794_CLK_SSI2		13
-#define R8A7794_CLK_SSI1		14
-#define R8A7794_CLK_SSI0		15
-#define R8A7794_CLK_SCU_ALL		17
-#define R8A7794_CLK_SCU_DVC1		18
-#define R8A7794_CLK_SCU_DVC0		19
-#define R8A7794_CLK_SCU_CTU1_MIX1	20
-#define R8A7794_CLK_SCU_CTU0_MIX0	21
-#define R8A7794_CLK_SCU_SRC6		25
-#define R8A7794_CLK_SCU_SRC5		26
-#define R8A7794_CLK_SCU_SRC4		27
-#define R8A7794_CLK_SCU_SRC3		28
-#define R8A7794_CLK_SCU_SRC2		29
-#define R8A7794_CLK_SCU_SRC1		30
-
-/* MSTP11 */
-#define R8A7794_CLK_SCIFA3		6
-#define R8A7794_CLK_SCIFA4		7
-#define R8A7794_CLK_SCIFA5		8
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7794_H__ */
-- 
2.34.1

