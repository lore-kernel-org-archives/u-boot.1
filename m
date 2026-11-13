Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DF606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uZP1y3r4;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=GMgV1L+8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E66B260E4D;
	Fri, 13 Nov 2026 02:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RNpJ6h3DJh1u; Fri, 13 Nov 2026 02:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B0CA60E4F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537193;
	b=phOL7BwD6jv5B1wLuYTcFb4srMvtu+G1At9SoQ0ty4nM08IV7PvqlIyuEbTIw3zZ2Sdf
	 D3BB/u4YLF0u/KarEX/wJWlheY4RHfisW56ajHuEJ22AXgpL5f2In2n2cAxxij7xyc615
	 EvjsDAbfk5q/G4i74sfylFD8YuRoHeeuIZXMkdku4qGcfjbb7gBd9JwrIhBToeTUVkF8j
	 pN6Qtx/6jgmno8WSiVk/4q6fjbgQE9EOnK5Ao1tpg0ea9NEy4O1mUvCVgm6PAg1mANfWR
	 qZH6nDr8/fxlasQ8mGSbOd2I8SESnicBXDi4Xav458xgb+LJ27QBFgNMPqMZgZ51B7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aHvB6MVfchQmC5Bo0no0ve9qHOGecxlNodE8P8uVMeY=;
	b=QStFWfVg0JhSXss+6ZFNJvtoqO9Nsa9OU0qalHqLz2Wxtoq6724KWtM7lio/1/jfw48S
	 soaM7y1cq+45e+E34Cq8CAMrgoxwhKe0zqnbEjNmkJFCTZaIfdccWZP+uCL8w14zkwJWU
	 8DCdf9QBWytiIL7ozIvsinHIoiicgkU7yDcaampc348js5Mvsuzn8WEPMjm/5TfwSZ0mF
	 4r6+yb+YHM2P0e2enOb2bGeVoP4rtwvRVLuH7oOk2v7DY4MIyOWnQOewsKQWL3YOnbT6G
	 ud0BP4BYQU3YC8BC4yNTKzuREue1PORi5yrhpiY7Gi6ECtC6pUO1uAszPBQRdOEvCeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537193;
	bh=aHvB6MVfchQmC5Bo0no0ve9qHOGecxlNodE8P8uVMeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZP1y3r4oH1nS54Ai26SPZxT7EDVViYd4ZROK06Qz7Ka8l6yb4m0JGFrpLRpq+sdN
	 QCJnK/zV8CZW6COSTEVPSppVlC0z2GUM/uhu/1bJRXf41GHFgMAaFOkXPCXCs1+YKX
	 RPIAGJdInkgrdw4NOcOimWFTqoYwwRK+ESs8XMRM/YuPZrvQSIcmqU3656ByhX35ST
	 tVjIBAplgwX2+Ur4chWgaecLJPzlZayvJnWpZiH4whfTxlM12qWBre8ZTZclLZYjw3
	 WaWNaaaDM1r1LJDBHyvugAb9BdStoe98HVlK4NZ0u9V/UIEoL0QhHUI9/ko4wBHLhv
	 wph0d1YfVpXwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B0CA60E4F;
	Fri, 13 Nov 2026 02:33:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D33312E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9ACC400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0NnNjkGTfSu for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EAB2640082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=GMgV1L+8
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAB2640082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:09 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 648F244DC4;
 Fri, 13 Nov 2026 13:33:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHvB6MVfchQmC5Bo0no0ve9qHOGecxlNodE8P8uVMeY=;
 b=GMgV1L+8AOKZwPvRKgeVkXFnhIIz3KrPfGbH0C5L8mqg/U4m8K9BrZqjhIk5CzGDlmOyTz
 +aV+IOmAytE2obu60jYcC3trgvPfLoB0LaBd5biBP6Vt1Dus704xZFshOeLlAzib4BVBaQ
 i5ABAW+z0PDAiSOEOOkmGvibEfr3NX58E6EdxeXLEx8C68SIxOBnFzbURQEWe2mSx7uDbt
 Ncs16IEfQI5AFEQtSWxvQZuAjSxTrmeevs+uiShZ5m+3/W523Q+AHiW4vEiZHF4D9i8mRx
 dLhZR5Riuf5EqwslD162Jb6omzoSWHZ6mdtLIb1Oxi4TqB8JCNeqJo4/Zbrxww==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 04/26] dt-bindings: clk: sun60i-a733-ccu: Add Allwinner A733
 support
Date: Fri, 13 Nov 2026 13:32:14 +1100
Message-ID: <20261113023236.569054-5-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junhui Liu <junhui.liu@pigmoral.tech>

The CCU and R-CCU (PRCM) modules provide clocks and reset functions for
the Allwinner A733 SoC. The clock architecture of the A733 is evolved
from the A523, though the root clocking strategy transitions from a
static oscillator frequency in the Devicetree to the "hosc" clock, which
is determined by choosing from three possible frequencies (19.2MHz,
24MHz, or 26MHz) by the RTC hardware, and finally feeds the CCU and
R-CCU.

Additionally, the MCU_CCU module found in previous designs is removed
from the A733, and the clock tree is expanded with more clock outputs
to support new functional modules.

Import the DT binding headers from v6 of the upstream Linux series.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Link: https://lore.kernel.org/r/20261009-a733-clk-v6-1-ae8178fce7e8@pigmoral.tech
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../clock/allwinner,sun60i-a733-ccu.h         | 291 ++++++++++++++++++
 .../clock/allwinner,sun60i-a733-r-ccu.h       |  38 +++
 .../reset/allwinner,sun60i-a733-ccu.h         | 129 ++++++++
 .../reset/allwinner,sun60i-a733-r-ccu.h       |  23 ++
 4 files changed, 481 insertions(+)
 create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h
 create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h

diff --git a/include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h b/include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h
new file mode 100644
index 00000000000..81924cba58e
--- /dev/null
+++ b/include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ *
+ * The user manual uses PCLK, HCLK, and MCLK suffixes for some bus clocks.
+ * These are represented here as APB, AHB, and MBUS prefixes respectively,
+ * with the bus type moved to the front of the clock name.
+ */
+
+#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_CCU_H_
+
+#define CLK_PLL_REF		0
+#define CLK_SYS_24M		1
+#define CLK_PLL_DDR		2
+#define CLK_PLL_PERIPH0_4X	3
+#define CLK_PLL_PERIPH0_2X	4
+#define CLK_PLL_PERIPH0_800M	5
+#define CLK_PLL_PERIPH0_480M	6
+#define CLK_PLL_PERIPH0_600M	7
+#define CLK_PLL_PERIPH0_400M	8
+#define CLK_PLL_PERIPH0_300M	9
+#define CLK_PLL_PERIPH0_200M	10
+#define CLK_PLL_PERIPH0_160M	11
+#define CLK_PLL_PERIPH0_150M	12
+#define CLK_PLL_PERIPH1_4X	13
+#define CLK_PLL_PERIPH1_2X	14
+#define CLK_PLL_PERIPH1_800M	15
+#define CLK_PLL_PERIPH1_480M	16
+#define CLK_PLL_PERIPH1_600M	17
+#define CLK_PLL_PERIPH1_400M	18
+#define CLK_PLL_PERIPH1_300M	19
+#define CLK_PLL_PERIPH1_200M	20
+#define CLK_PLL_PERIPH1_160M	21
+#define CLK_PLL_PERIPH1_150M	22
+#define CLK_PLL_GPU0		23
+#define CLK_PLL_VIDEO0		24
+#define CLK_PLL_VIDEO0_4X	25
+#define CLK_PLL_VIDEO0_3X	26
+#define CLK_PLL_VIDEO1		27
+#define CLK_PLL_VIDEO1_4X	28
+#define CLK_PLL_VIDEO1_3X	29
+#define CLK_PLL_VIDEO2		30
+#define CLK_PLL_VIDEO2_4X	31
+#define CLK_PLL_VIDEO2_3X	32
+#define CLK_PLL_VE0		33
+#define CLK_PLL_VE1		34
+#define CLK_PLL_AUDIO0_4X	35
+#define CLK_PLL_AUDIO1		36
+#define CLK_PLL_AUDIO1_DIV2	37
+#define CLK_PLL_AUDIO1_DIV5	38
+#define CLK_PLL_NPU		39
+#define CLK_PLL_DE		40
+#define CLK_PLL_DE_4X		41
+#define CLK_PLL_DE_3X		42
+#define CLK_AHB			43
+#define CLK_APB0		44
+#define CLK_APB1		45
+#define CLK_APB_UART		46
+#define CLK_TRACE		47
+#define CLK_GIC			48
+#define CLK_BUS_ITS_PCIE0_ACLK	49
+#define CLK_MBUS		50
+#define CLK_MBUS_IOMMU0_SYS	51
+#define CLK_APB_IOMMU0_SYS	52
+#define CLK_AHB_IOMMU0_SYS	53
+#define CLK_BUS_MSI_LITE0	54
+#define CLK_BUS_MSI_LITE1	55
+#define CLK_BUS_MSI_LITE2	56
+#define CLK_MBUS_IOMMU1_SYS	57
+#define CLK_APB_IOMMU1_SYS	58
+#define CLK_AHB_IOMMU1_SYS	59
+#define CLK_AHB_VE_DEC		60
+#define CLK_AHB_VE_ENC		61
+#define CLK_AHB_VID_IN		62
+#define CLK_AHB_VID_COUT0	63
+#define CLK_AHB_VID_COUT1	64
+#define CLK_AHB_DE		65
+#define CLK_AHB_NPU		66
+#define CLK_AHB_GPU0		67
+#define CLK_AHB_SERDES		68
+#define CLK_AHB_USB_SYS		69
+#define CLK_AHB_MSI_LITE0	70
+#define CLK_AHB_STORE		71
+#define CLK_AHB_CPUS		72
+#define CLK_MBUS_IOMMU0		73
+#define CLK_MBUS_IOMMU1		74
+#define CLK_MBUS_DESYS		75
+#define CLK_MBUS_VE_ENC0_GATE	76
+#define CLK_MBUS_VE_DEC0_GATE	77
+#define CLK_MBUS_GPU0		78
+#define CLK_MBUS_NPU		79
+#define CLK_MBUS_VID_IN		80
+#define CLK_MBUS_SERDES		81
+#define CLK_MBUS_MSI_LITE0	82
+#define CLK_MBUS_STORE		83
+#define CLK_MBUS_MSI_LITE2	84
+#define CLK_MBUS_DMA0		85
+#define CLK_MBUS_VE_ENC0	86
+#define CLK_MBUS_CE		87
+#define CLK_MBUS_DMA1		88
+#define CLK_MBUS_NAND0		89
+#define CLK_MBUS_CSI		90
+#define CLK_MBUS_ISP		91
+#define CLK_MBUS_GMAC0		92
+#define CLK_MBUS_GMAC1		93
+#define CLK_MBUS_VE_DEC0	94
+#define CLK_BUS_DMA0		95
+#define CLK_BUS_DMA1		96
+#define CLK_BUS_SPINLOCK	97
+#define CLK_BUS_MSGBOX0		98
+#define CLK_BUS_PWM0		99
+#define CLK_BUS_PWM1		100
+#define CLK_BUS_DBG		101
+#define CLK_BUS_SYSDAP		102
+#define CLK_TIMER0		103
+#define CLK_TIMER1		104
+#define CLK_TIMER2		105
+#define CLK_TIMER3		106
+#define CLK_TIMER4		107
+#define CLK_TIMER5		108
+#define CLK_TIMER6		109
+#define CLK_TIMER7		110
+#define CLK_TIMER8		111
+#define CLK_TIMER9		112
+#define CLK_BUS_TIMER		113
+#define CLK_AVS			114
+#define CLK_DE0			115
+#define CLK_BUS_DE0		116
+#define CLK_DI			117
+#define CLK_BUS_DI		118
+#define CLK_G2D			119
+#define CLK_BUS_G2D		120
+#define CLK_EINK		121
+#define CLK_EINK_PANEL		122
+#define CLK_BUS_EINK		123
+#define CLK_VE_ENC0		124
+#define CLK_VE_DEC0		125
+#define CLK_BUS_VE_ENC0		126
+#define CLK_BUS_VE_DEC0		127
+#define CLK_CE			128
+#define CLK_BUS_CE		129
+#define CLK_BUS_CE_SYS		130
+#define CLK_NPU			131
+#define CLK_BUS_NPU		132
+#define CLK_GPU0		133
+#define CLK_BUS_GPU0		134
+#define CLK_DRAM0		135
+#define CLK_BUS_DRAM0		136
+#define CLK_NAND0_CLK0		137
+#define CLK_NAND0_CLK1		138
+#define CLK_BUS_NAND0		139
+#define CLK_MMC0		140
+#define CLK_BUS_MMC0		141
+#define CLK_MMC1		142
+#define CLK_BUS_MMC1		143
+#define CLK_MMC2		144
+#define CLK_BUS_MMC2		145
+#define CLK_MMC3		146
+#define CLK_BUS_MMC3		147
+#define CLK_UFS_AXI		148
+#define CLK_UFS_CFG		149
+#define CLK_BUS_UFS		150
+#define CLK_BUS_UART0		151
+#define CLK_BUS_UART1		152
+#define CLK_BUS_UART2		153
+#define CLK_BUS_UART3		154
+#define CLK_BUS_UART4		155
+#define CLK_BUS_UART5		156
+#define CLK_BUS_UART6		157
+#define CLK_BUS_I2C0		158
+#define CLK_BUS_I2C1		159
+#define CLK_BUS_I2C2		160
+#define CLK_BUS_I2C3		161
+#define CLK_BUS_I2C4		162
+#define CLK_BUS_I2C5		163
+#define CLK_BUS_I2C6		164
+#define CLK_BUS_I2C7		165
+#define CLK_BUS_I2C8		166
+#define CLK_BUS_I2C9		167
+#define CLK_BUS_I2C10		168
+#define CLK_BUS_I2C11		169
+#define CLK_BUS_I2C12		170
+#define CLK_SPI0		171
+#define CLK_BUS_SPI0		172
+#define CLK_SPI1		173
+#define CLK_BUS_SPI1		174
+#define CLK_SPI2		175
+#define CLK_BUS_SPI2		176
+#define CLK_SPIF		177
+#define CLK_BUS_SPIF		178
+#define CLK_SPI3		179
+#define CLK_BUS_SPI3		180
+#define CLK_SPI4		181
+#define CLK_BUS_SPI4		182
+#define CLK_GPADC0_24M		183
+#define CLK_BUS_GPADC0		184
+#define CLK_BUS_THS0		185
+#define CLK_IRRX		186
+#define CLK_BUS_IRRX		187
+#define CLK_IRTX		188
+#define CLK_BUS_IRTX		189
+#define CLK_BUS_LRADC		190
+#define CLK_SGPIO		191
+#define CLK_BUS_SGPIO		192
+#define CLK_LPC			193
+#define CLK_BUS_LPC		194
+#define CLK_I2SPCM0		195
+#define CLK_BUS_I2SPCM0		196
+#define CLK_I2SPCM1		197
+#define CLK_BUS_I2SPCM1		198
+#define CLK_I2SPCM2		199
+#define CLK_I2SPCM2_ASRC	200
+#define CLK_BUS_I2SPCM2		201
+#define CLK_I2SPCM3		202
+#define CLK_BUS_I2SPCM3		203
+#define CLK_I2SPCM4		204
+#define CLK_BUS_I2SPCM4		205
+#define CLK_SPDIF_TX		206
+#define CLK_SPDIF_RX		207
+#define CLK_BUS_SPDIF		208
+#define CLK_DMIC		209
+#define CLK_BUS_DMIC		210
+#define CLK_USB_OHCI0		211
+#define CLK_BUS_OHCI0		212
+#define CLK_BUS_EHCI0		213
+#define CLK_BUS_OTG		214
+#define CLK_USB_OHCI1		215
+#define CLK_BUS_OHCI1		216
+#define CLK_BUS_EHCI1		217
+#define CLK_USB01_REF		218
+#define CLK_USB2_U2_REF		219
+#define CLK_USB2_SUSPEND	220
+#define CLK_USB2_MF		221
+#define CLK_USB2_U3_UTMI	222
+#define CLK_USB2_U2_PIPE	223
+#define CLK_PCIE_AUX		224
+#define CLK_PCIE_AXI_SLV	225
+#define CLK_SERDES_PHY		226
+#define CLK_GMAC_PTP		227
+#define CLK_GMAC0_PHY		228
+#define CLK_BUS_GMAC0		229
+#define CLK_GMAC1_PHY		230
+#define CLK_BUS_GMAC1		231
+#define CLK_TCON_LCD0		232
+#define CLK_BUS_TCON_LCD0	233
+#define CLK_TCON_LCD1		234
+#define CLK_BUS_TCON_LCD1	235
+#define CLK_TCON_LCD2		236
+#define CLK_BUS_TCON_LCD2	237
+#define CLK_DSI0		238
+#define CLK_BUS_DSI0		239
+#define CLK_DSI1		240
+#define CLK_BUS_DSI1		241
+#define CLK_COMBPHY0		242
+#define CLK_COMBPHY1		243
+#define CLK_BUS_TCON_TV0	244
+#define CLK_BUS_TCON_TV1	245
+#define CLK_EDP_TV		246
+#define CLK_BUS_EDP_TV		247
+#define CLK_HDMI_CEC_32K	248
+#define CLK_HDMI_CEC		249
+#define CLK_HDMI_TV		250
+#define CLK_BUS_HDMI_TV		251
+#define CLK_HDMI_SFR		252
+#define CLK_HDCP_ESM		253
+#define CLK_BUS_DPSS_TOP0	254
+#define CLK_BUS_DPSS_TOP1	255
+#define CLK_LEDC		256
+#define CLK_BUS_LEDC		257
+#define CLK_BUS_DSC		258
+#define CLK_CSI_MASTER0		259
+#define CLK_CSI_MASTER1		260
+#define CLK_CSI_MASTER2		261
+#define CLK_CSI			262
+#define CLK_BUS_CSI		263
+#define CLK_ISP			264
+#define CLK_RES_DCAP_24M	265
+#define CLK_APB2JTAG		266
+#define CLK_FANOUT_24M		267
+#define CLK_FANOUT_12M		268
+#define CLK_FANOUT_16M		269
+#define CLK_FANOUT_25M		270
+#define CLK_FANOUT_27M		271
+#define CLK_FANOUT_PCLK		272
+#define CLK_FANOUT0		273
+#define CLK_FANOUT1		274
+#define CLK_FANOUT2		275
+#define CLK_FANOUT3		276
+
+#endif /* _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h b/include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h
new file mode 100644
index 00000000000..401a1e66e80
--- /dev/null
+++ b/include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_R_APB1		2
+#define CLK_R_TIMER0		3
+#define CLK_R_TIMER1		4
+#define CLK_R_TIMER2		5
+#define CLK_R_TIMER3		6
+#define CLK_BUS_R_TIMER		7
+#define CLK_R_PWM		8
+#define CLK_BUS_R_PWM		9
+#define CLK_R_SPI		10
+#define CLK_BUS_R_SPI		11
+#define CLK_BUS_R_MSGBOX	12
+#define CLK_BUS_R_UART0		13
+#define CLK_BUS_R_UART1		14
+#define CLK_BUS_R_I2C0		15
+#define CLK_BUS_R_I2C1		16
+#define CLK_BUS_R_I2C2		17
+#define CLK_BUS_R_PPU		18
+#define CLK_BUS_R_TZMA		19
+#define CLK_BUS_R_CPU_BIST	20
+#define CLK_R_IR_RX		21
+#define CLK_BUS_R_IR_RX		22
+#define CLK_BUS_R_RTC		23
+#define CLK_R_RISCV		24
+#define CLK_BUS_R_RISCV		25
+#define CLK_BUS_R_RISCV_CFG	26
+#define CLK_BUS_R_CPUCFG	27
+
+#endif /* _DT_BINDINGS_CLK_ALLWINNER_SUN60I_A733_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h b/include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h
new file mode 100644
index 00000000000..a4db2f673bd
--- /dev/null
+++ b/include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_CCU_H_
+
+#define RST_BUS_ITS_PCIE0	0
+#define RST_BUS_IOMMU0_SYS	1
+#define RST_BUS_MSI_LITE0_AHB	2
+#define RST_BUS_MSI_LITE0_MBUS	3
+#define RST_BUS_MSI_LITE1_AHB	4
+#define RST_BUS_MSI_LITE1_MBUS	5
+#define RST_BUS_MSI_LITE2_AHB	6
+#define RST_BUS_MSI_LITE2_MBUS	7
+#define RST_BUS_IOMMU1_SYS	8
+#define RST_BUS_DMA0		9
+#define RST_BUS_DMA1		10
+#define RST_BUS_SPINLOCK	11
+#define RST_BUS_MSGBOX		12
+#define RST_BUS_PWM0		13
+#define RST_BUS_PWM1		14
+#define RST_BUS_DBG		15
+#define RST_BUS_SYSDAP		16
+#define RST_BUS_TIMER0		17
+#define RST_BUS_DE0		18
+#define RST_BUS_DI		19
+#define RST_BUS_G2D		20
+#define RST_BUS_EINK		21
+#define RST_BUS_DE_SYS		22
+#define RST_BUS_VE_ENC0		23
+#define RST_BUS_VE_DEC0		24
+#define RST_BUS_CE		25
+#define RST_BUS_CE_SYS		26
+#define RST_BUS_NPU_CORE	27
+#define RST_BUS_NPU_AXI		28
+#define RST_BUS_NPU_AHB		29
+#define RST_BUS_NPU_SRAM	30
+#define RST_BUS_GPU0		31
+#define RST_BUS_DRAM0		32
+#define RST_BUS_NAND0		33
+#define RST_BUS_MMC0		34
+#define RST_BUS_MMC1		35
+#define RST_BUS_MMC2		36
+#define RST_BUS_MMC3		37
+#define RST_BUS_UFS_AHB		38
+#define RST_BUS_UFS_AXI		39
+#define RST_BUS_UFS_PHY		40
+#define RST_BUS_UFS_CORE	41
+#define RST_BUS_UART0		42
+#define RST_BUS_UART1		43
+#define RST_BUS_UART2		44
+#define RST_BUS_UART3		45
+#define RST_BUS_UART4		46
+#define RST_BUS_UART5		47
+#define RST_BUS_UART6		48
+#define RST_BUS_I2C0		49
+#define RST_BUS_I2C1		50
+#define RST_BUS_I2C2		51
+#define RST_BUS_I2C3		52
+#define RST_BUS_I2C4		53
+#define RST_BUS_I2C5		54
+#define RST_BUS_I2C6		55
+#define RST_BUS_I2C7		56
+#define RST_BUS_I2C8		57
+#define RST_BUS_I2C9		58
+#define RST_BUS_I2C10		59
+#define RST_BUS_I2C11		60
+#define RST_BUS_I2C12		61
+#define RST_BUS_SPI0		62
+#define RST_BUS_SPI1		63
+#define RST_BUS_SPI2		64
+#define RST_BUS_SPIF		65
+#define RST_BUS_SPI3		66
+#define RST_BUS_SPI4		67
+#define RST_BUS_GPADC0		68
+#define RST_BUS_THS0		69
+#define RST_BUS_IRRX		70
+#define RST_BUS_IRTX		71
+#define RST_BUS_LRADC		72
+#define RST_BUS_SGPIO		73
+#define RST_BUS_LPC		74
+#define RST_BUS_I2SPCM0		75
+#define RST_BUS_I2SPCM1		76
+#define RST_BUS_I2SPCM2		77
+#define RST_BUS_I2SPCM3		78
+#define RST_BUS_I2SPCM4		79
+#define RST_BUS_SPDIF		80
+#define RST_BUS_DMIC		81
+#define RST_USB_PHY0		82
+#define RST_BUS_OHCI0		83
+#define RST_BUS_EHCI0		84
+#define RST_BUS_OTG		85
+#define RST_USB_PHY1		86
+#define RST_BUS_OHCI1		87
+#define RST_BUS_EHCI1		88
+#define RST_BUS_USB2		89
+#define RST_BUS_PCIE_PWRUP	90
+#define RST_BUS_PCIE		91
+#define RST_BUS_SERDES		92
+#define RST_BUS_GMAC0		93
+#define RST_BUS_GMAC0_AXI	94
+#define RST_BUS_GMAC1		95
+#define RST_BUS_GMAC1_AXI	96
+#define RST_BUS_TCON_LCD0	97
+#define RST_BUS_TCON_LCD1	98
+#define RST_BUS_TCON_LCD2	99
+#define RST_BUS_LVDS0		100
+#define RST_BUS_LVDS1		101
+#define RST_BUS_DSI0		102
+#define RST_BUS_DSI1		103
+#define RST_BUS_TCON_TV0	104
+#define RST_BUS_TCON_TV1	105
+#define RST_BUS_EDP		106
+#define RST_BUS_HDMI_MAIN	107
+#define RST_BUS_HDMI_SUB	108
+#define RST_BUS_HDMI_HDCP	109
+#define RST_BUS_DPSS_TOP0	110
+#define RST_BUS_DPSS_TOP1	111
+#define RST_BUS_VIDEO_OUT0	112
+#define RST_BUS_VIDEO_OUT1	113
+#define RST_BUS_LEDC		114
+#define RST_BUS_DSC		115
+#define RST_BUS_CSI		116
+#define RST_BUS_VIDEO_IN	117
+#define RST_BUS_APB2JTAG	118
+
+#endif /* _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h b/include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h
new file mode 100644
index 00000000000..69fc7d405e1
--- /dev/null
+++ b/include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_PWM		1
+#define RST_BUS_R_SPI		2
+#define RST_BUS_R_MSGBOX	3
+#define RST_BUS_R_UART0		4
+#define RST_BUS_R_UART1		5
+#define RST_BUS_R_I2C0		6
+#define RST_BUS_R_I2C1		7
+#define RST_BUS_R_I2C2		8
+#define RST_BUS_R_IR_RX		9
+#define RST_BUS_R_RTC		10
+#define RST_BUS_R_RISCV_CFG	11
+#define RST_BUS_R_CPUCFG	12
+
+#endif /* _DT_BINDINGS_RST_ALLWINNER_SUN60I_A733_R_CCU_H_ */
-- 
2.53.0

