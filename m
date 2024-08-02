Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF135C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0582088C97;
	Fri,  2 Aug 2024 21:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOKamqy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726DC88C81; Fri,  2 Aug 2024 21:56:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE26831A1
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so75915615e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628605; x=1723233405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h0opCagA/gtAOuSPf76pPrK/M/UbVv1o/MJ6kn15TuY=;
 b=VOKamqy4OSEP/8gGoNXLJ6nxKbGD99Od/pZReILoZWZVb84yikFEvmNtLm9SNcctcW
 EUalPFPUd9qwLLFvrGMxzfK0oBIQJ2t6H3i4N2IP7aTh3NtsSuRhGfNSR7mn1DEak8Sk
 uoXxcTzjsweQCsrmomrUmdqPXZPgrrE8m233wQutop2VS2smn+xcCyBwOm+cn9bxP86J
 RbvZo8PtwGDIFoh8V5H3GQoqftC5u4t0Ob9VEqeNPLwW005SrLCPwoAALV9uM3TCI02c
 AV3O/BYJqeCPmPsn2AXX2p3RCR0kD2w/N1fZ8SXfnPzk/gjFKljzKoJ/p2lzq159bMoH
 TJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628605; x=1723233405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0opCagA/gtAOuSPf76pPrK/M/UbVv1o/MJ6kn15TuY=;
 b=mZg1oi7lrdilkT0OSAj/lOPLbHxhwr1tgiqChojU6HhweFZOiXcfLYL868dTWO1ATz
 dEAPs5TQttssVdJ3LkyAG6SPmQmzJI0jM2V4NzyAN8IZmkEgwNE0iOTjqXlSFmzTXZtW
 4zF7J681SFSQd7wItR6NI0CBsHxqzaVVdsaN+x1ahCHUkdgBHnDi/PTolMJBIIW11fUk
 6S+ydKKF93btA5Hs3ZtLxdUOlWPZ1/yWNRT1LezSNFAukrnrKVwBM8ANcb7F40tWnR+q
 votVS/mXH/BBQC6pJmVvgy5PSqpouXO//iZ3AHZb6kKcx2oyKwPzMiZt82PX745DgVrr
 wshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Y6Na+L2XqXiCOEE5pLCNdank/iHxjeJlyb/0tOhiAJJ+qJPXV+bmSKvz/Rg2g+U4xFWXDWbMlphFh2QfhVl2Pn2Y7w==
X-Gm-Message-State: AOJu0Ywwp66GMLcddWs2+qppr/XGjtRfpB6Mfu4oQupSCSquLGl1pwgh
 jVgcVq7Cu8CrYOYlnlEDcpojhM2W5sF1QlHq+68gUJrGobbbetMh
X-Google-Smtp-Source: AGHT+IERmf0uX8ARTBl9h8h8jqowsghyAFs6hnGPIkpjzUuIT9PnFTxhxdN8iqd0AuxOK9GMioCWcw==
X-Received: by 2002:a05:600c:154c:b0:426:62c5:4731 with SMTP id
 5b1f17b1804b1-428e6b7ea40mr39754675e9.29.1722628604537; 
 Fri, 02 Aug 2024 12:56:44 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 10/14] clk: mediatek: mt7981: drop 1/1 spurious factor
Date: Fri,  2 Aug 2024 15:53:11 +0200
Message-ID: <20240802135326.25303-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Now that we can have advanced parent handling for mux, we can drop
spurious infracfg 1/1 factor. This is in preparation to make the clk
ID match the ID in upstream include for mt7981.

Drop the factor entry from mt7981-clk.h and reference to them in
mt7981.dtsi. Muxes and gates are updated to reference the topckgen clk
following how it's done in upstream kernel linux. Add relevant clk type
flag in clk_tree for infracfg and topckgen.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi               |  14 +-
 drivers/clk/mediatek/clk-mt7981.c      | 250 ++++++++++++-------------
 include/dt-bindings/clock/mt7981-clk.h |  40 +---
 3 files changed, 127 insertions(+), 177 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 1be1b797b3e..fc13b90caf6 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -140,7 +140,7 @@
 		#clock-cells = <1>;
 		#pwm-cells = <2>;
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_PWM>,
+		clocks = <&topckgen CK_TOP_PWM_SEL>,
 			 <&infracfg_ao CK_INFRA_PWM_BSEL>,
 			 <&infracfg_ao CK_INFRA_PWM1_CK>,
 			 <&infracfg_ao CK_INFRA_PWM2_CK>,
@@ -174,7 +174,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
-					 <&infracfg CK_INFRA_UART>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 		bootph-all;
@@ -188,7 +188,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_UART1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
-					 <&infracfg CK_INFRA_UART>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -201,7 +201,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_UART2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
-					 <&infracfg CK_INFRA_UART>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -270,7 +270,7 @@
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
-					 <&topckgen CK_INFRA_ISPI0>;
+					 <&topckgen CK_TOP_SPI_SEL>;
 		clock-names = "spi-clk", "sel-clk";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -285,7 +285,7 @@
 		assigned-clocks = <&topckgen CK_TOP_SPIM_MST_SEL>,
 				  <&infracfg CK_INFRA_SPI1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
-					 <&topckgen CK_INFRA_ISPI1>;
+					 <&topckgen CK_TOP_SPIM_MST_SEL>;
 		clock-names = "spi-clk", "sel-clk";
 		status = "disabled";
 	};
@@ -298,7 +298,7 @@
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
-					 <&topckgen CK_INFRA_ISPI0>;
+					 <&topckgen CK_TOP_SPI_SEL>;
 		clock-names = "spi-clk", "sel-clk";
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index ac1d93e162f..aaaebd46791 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -312,81 +312,55 @@ static const struct mtk_composite top_muxes[] = {
 
 /* INFRA FIXED DIV */
 static const struct mtk_fixed_factor infra_fixed_divs[] = {
-	TOP_FACTOR(CK_INFRA_CK_F26M, "infra_ck_f26m", CK_TOP_F26M_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_UART, "infra_uart", CK_TOP_UART_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_ISPI0, "infra_ispi0", CK_TOP_SPI_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_I2C, "infra_i2c", CK_TOP_I2C_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_ISPI1, "infra_ispi1", CK_TOP_SPIM_MST_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PWM, "infra_pwm", CK_TOP_PWM_SEL, 1, 1),
 	TOP_FACTOR(CK_INFRA_66M_MCK, "infra_66m_mck", CK_TOP_SYSAXI_SEL, 1, 2),
-	TOP_FACTOR(CK_INFRA_CK_F32K, "infra_ck_f32k", CK_TOP_CB_RTC_32P7K, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_PCIE_CK, "infra_pcie", CK_TOP_PEXTP_TL_SEL, 1, 1),
-	INFRA_FACTOR(CK_INFRA_PWM_BCK, "infra_pwm_bck", CK_INFRA_PWM_BSEL, 1,
-		     1),
-	INFRA_FACTOR(CK_INFRA_PWM_CK1, "infra_pwm_ck1", CK_INFRA_PWM1_SEL, 1,
-		     1),
-	INFRA_FACTOR(CK_INFRA_PWM_CK2, "infra_pwm_ck2", CK_INFRA_PWM2_SEL, 1,
-		     1),
-	TOP_FACTOR(CK_INFRA_133M_HCK, "infra_133m_hck", CK_TOP_SYSAXI, 1, 1),
-	INFRA_FACTOR(CK_INFRA_66M_PHCK, "infra_66m_phck", CK_INFRA_133M_HCK, 1,
-		     1),
-	TOP_FACTOR(CK_INFRA_FAUD_L_CK, "infra_faud_l", CK_TOP_AUD_L, 1, 1),
-	TOP_FACTOR(CK_INFRA_FAUD_AUD_CK, "infra_faud_aud", CK_TOP_A1SYS, 1, 1),
-	TOP_FACTOR(CK_INFRA_FAUD_EG2_CK, "infra_faud_eg2", CK_TOP_A_TUNER, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_I2CS_CK, "infra_i2cs", CK_TOP_I2C_BCK, 1, 1),
-	INFRA_FACTOR(CK_INFRA_MUX_UART0, "infra_mux_uart0", CK_INFRA_UART0_SEL,
-		     1, 1),
-	INFRA_FACTOR(CK_INFRA_MUX_UART1, "infra_mux_uart1", CK_INFRA_UART1_SEL,
-		     1, 1),
-	INFRA_FACTOR(CK_INFRA_MUX_UART2, "infra_mux_uart2", CK_INFRA_UART2_SEL,
-		     1, 1),
-	TOP_FACTOR(CK_INFRA_NFI_CK, "infra_nfi", CK_TOP_NFI1X, 1, 1),
-	TOP_FACTOR(CK_INFRA_SPINFI_CK, "infra_spinfi", CK_TOP_SPINFI_BCK, 1, 1),
-	INFRA_FACTOR(CK_INFRA_MUX_SPI0, "infra_mux_spi0", CK_INFRA_SPI0_SEL, 1,
-		     1),
-	INFRA_FACTOR(CK_INFRA_MUX_SPI1, "infra_mux_spi1", CK_INFRA_SPI1_SEL, 1,
-		     1),
-	INFRA_FACTOR(CK_INFRA_MUX_SPI2, "infra_mux_spi2", CK_INFRA_SPI2_SEL, 1,
-		     1),
-	TOP_FACTOR(CK_INFRA_RTC_32K, "infra_rtc_32k", CK_TOP_CB_RTC_32K, 1, 1),
-	TOP_FACTOR(CK_INFRA_FMSDC_CK, "infra_fmsdc", CK_TOP_EMMC_400M, 1, 1),
-	TOP_FACTOR(CK_INFRA_FMSDC_HCK_CK, "infra_fmsdc_hck", CK_TOP_EMMC_208M,
-		   1, 1),
-	TOP_FACTOR(CK_INFRA_PERI_133M, "infra_peri_133m", CK_TOP_SYSAXI, 1, 1),
-	TOP_FACTOR(CK_INFRA_133M_PHCK, "infra_133m_phck", CK_TOP_SYSAXI, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_SYS_CK, "infra_usb_sys", CK_TOP_U2U3_SYS, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_CK, "infra_usb", CK_TOP_U2U3_REF, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_XHCI_CK, "infra_usb_xhci", CK_TOP_U2U3_XHCI, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_PCIE_GFMUX_TL_O_PRE, "infra_pcie_mux",
-		   CK_TOP_PEXTP_TL, 1, 1),
-	TOP_FACTOR(CK_INFRA_F26M_CK0, "infra_f26m_ck0", CK_TOP_F26M, 1, 1),
-	TOP_FACTOR(CK_INFRA_133M_MCK, "infra_133m_mck", CK_TOP_SYSAXI, 1, 1),
 };
 
 /* INFRASYS MUX PARENTS */
-static const int infra_uart0_parents[] = { CK_INFRA_CK_F26M, CK_INFRA_UART };
+#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
+#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
+#define VOID_PARENT PARENT(-1, 0)
+
+static const struct mtk_parent infra_uart0_parents[] = {
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	TOP_PARENT(CK_TOP_UART_SEL)
+};
 
-static const int infra_spi0_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI0 };
+static const struct mtk_parent infra_spi0_parents[] = {
+	TOP_PARENT(CK_TOP_I2C_SEL),
+	TOP_PARENT(CK_TOP_SPI_SEL)
+};
 
-static const int infra_spi1_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI1 };
+static const struct mtk_parent infra_spi1_parents[] = {
+	TOP_PARENT(CK_TOP_I2C_SEL),
+	TOP_PARENT(CK_TOP_SPIM_MST_SEL)
+};
 
-static const int infra_pwm1_parents[] = {-1, CK_INFRA_PWM };
+static const struct mtk_parent infra_pwm1_parents[] = {
+	VOID_PARENT,
+	TOP_PARENT(CK_TOP_PWM_SEL)
+};
 
-static const int infra_pwm_bsel_parents[] = { -1, -1, -1, CK_INFRA_PWM };
+static const struct mtk_parent infra_pwm_bsel_parents[] = {
+	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	INFRA_PARENT(CK_INFRA_66M_MCK),
+	TOP_PARENT(CK_TOP_PWM_SEL)
+};
 
-static const int infra_pcie_parents[] = { CK_INFRA_CK_F32K, CK_INFRA_CK_F26M,
-					  CK_TOP_CB_CKSQ_40M, CK_INFRA_PCIE_CK};
+static const struct mtk_parent infra_pcie_parents[] = {
+	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	TOP_PARENT(CK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CK_TOP_PEXTP_TL_SEL)
+};
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
 	{                                                                      \
 		.id = _id, .mux_reg = (_reg) + 0x8,                            \
 		.mux_set_reg = (_reg) + 0x0, .mux_clr_reg = (_reg) + 0x4,      \
 		.mux_shift = _shift, .mux_mask = BIT(_width) - 1,              \
-		.parent = _parents, .num_parents = ARRAY_SIZE(_parents),       \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_INFRASYS,             \
+		.parent_flags = _parents, .num_parents = ARRAY_SIZE(_parents), \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
 	}
 
 /* INFRA MUX */
@@ -431,93 +405,104 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
 	.sta_ofs = 0x68,
 };
 
-#define GATE_INFRA0(_id, _name, _parent, _shift)                               \
+#define GATE_INFRA0(_id, _name, _parent, _shift, _flags)                       \
 	{                                                                      \
 		.id = _id, .parent = _parent, .regs = &infra_0_cg_regs,        \
 		.shift = _shift,                                               \
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_INFRASYS,                \
+		.flags = _flags,                                               \
 	}
+#define GATE_INFRA0_INFRA(_id, _name, _parent, _shift) \
+	GATE_INFRA0(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
+#define GATE_INFRA0_TOP(_id, _name, _parent, _shift) \
+	GATE_INFRA0(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
-#define GATE_INFRA1(_id, _name, _parent, _shift)                               \
+#define GATE_INFRA1(_id, _name, _parent, _shift, _flags)                       \
 	{                                                                      \
 		.id = _id, .parent = _parent, .regs = &infra_1_cg_regs,        \
 		.shift = _shift,                                               \
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_INFRASYS,                \
+		.flags = _flags,                                               \
 	}
+#define GATE_INFRA1_INFRA(_id, _name, _parent, _shift) \
+	GATE_INFRA1(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
+#define GATE_INFRA1_TOP(_id, _name, _parent, _shift) \
+	GATE_INFRA1(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
-#define GATE_INFRA2(_id, _name, _parent, _shift)                               \
+#define GATE_INFRA2(_id, _name, _parent, _shift, _flags)                       \
 	{                                                                      \
 		.id = _id, .parent = _parent, .regs = &infra_2_cg_regs,        \
 		.shift = _shift,                                               \
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_INFRASYS,                \
+		.flags = _flags,                                               \
 	}
+#define GATE_INFRA2_INFRA(_id, _name, _parent, _shift) \
+	GATE_INFRA2(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
+#define GATE_INFRA2_TOP(_id, _name, _parent, _shift) \
+	GATE_INFRA2(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
 /* INFRA GATE */
 static const struct mtk_gate infracfg_ao_gates[] = {
-	GATE_INFRA0(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_66M_MCK, 0),
-	GATE_INFRA0(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_66M_MCK, 1),
-	GATE_INFRA0(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BCK, 2),
-	GATE_INFRA0(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM_CK1, 3),
-	GATE_INFRA0(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM_CK2, 4),
-	GATE_INFRA0(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_INFRA_133M_HCK, 6),
-	GATE_INFRA0(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_INFRA_66M_PHCK, 8),
-	GATE_INFRA0(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_INFRA_CK_F26M, 9),
-	GATE_INFRA0(CK_INFRA_AUD_L_CK, "infra_aud_l", CK_INFRA_FAUD_L_CK, 10),
-	GATE_INFRA0(CK_INFRA_AUD_AUD_CK, "infra_aud_aud", CK_INFRA_FAUD_AUD_CK,
-		    11),
-	GATE_INFRA0(CK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CK_INFRA_FAUD_EG2_CK,
-		    13),
-	GATE_INFRA0(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_INFRA_CK_F26M,
-		    14),
-	GATE_INFRA0(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_66M_MCK, 15),
-	GATE_INFRA0(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_66M_MCK, 16),
-	GATE_INFRA0(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_66M_MCK, 24),
-	GATE_INFRA0(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_INFRA_CK_F26M, 25),
-	GATE_INFRA1(CK_INFRA_THERM_CK, "infra_therm", CK_INFRA_CK_F26M, 0),
-	GATE_INFRA1(CK_INFRA_I2C0_CK, "infra_i2c0", CK_INFRA_I2CS_CK, 1),
-	GATE_INFRA1(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_MUX_UART0, 2),
-	GATE_INFRA1(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_MUX_UART1, 3),
-	GATE_INFRA1(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_MUX_UART2, 4),
-	GATE_INFRA1(CK_INFRA_SPI2_CK, "infra_spi2", CK_INFRA_MUX_SPI2, 6),
-	GATE_INFRA1(CK_INFRA_SPI2_HCK_CK, "infra_spi2_hck", CK_INFRA_66M_MCK,
-		    7),
-	GATE_INFRA1(CK_INFRA_NFI1_CK, "infra_nfi1", CK_INFRA_NFI_CK, 8),
-	GATE_INFRA1(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_INFRA_SPINFI_CK,
-		    9),
-	GATE_INFRA1(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_66M_MCK, 10),
-	GATE_INFRA1(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_MUX_SPI0, 11),
-	GATE_INFRA1(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_MUX_SPI1, 12),
-	GATE_INFRA1(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_66M_MCK,
-		    13),
-	GATE_INFRA1(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_66M_MCK,
-		    14),
-	GATE_INFRA1(CK_INFRA_FRTC_CK, "infra_frtc", CK_INFRA_RTC_32K, 15),
-	GATE_INFRA1(CK_INFRA_MSDC_CK, "infra_msdc", CK_INFRA_FMSDC_CK, 16),
-	GATE_INFRA1(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
-		    CK_INFRA_FMSDC_HCK_CK, 17),
-	GATE_INFRA1(CK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
-		    CK_INFRA_PERI_133M, 18),
-	GATE_INFRA1(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_INFRA_66M_PHCK,
-		    19),
-	GATE_INFRA1(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_TOP_F26M, 20),
-	GATE_INFRA1(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_TOP_F26M, 21),
-	GATE_INFRA1(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_INFRA_NFI_CK,
-		    23),
-	GATE_INFRA1(CK_INFRA_I2C_MCK_CK, "infra_i2c_mck", CK_INFRA_133M_MCK,
-		    25),
-	GATE_INFRA1(CK_INFRA_I2C_PCK_CK, "infra_i2c_pck", CK_INFRA_66M_MCK, 26),
-	GATE_INFRA2(CK_INFRA_IUSB_133_CK, "infra_iusb_133", CK_INFRA_133M_PHCK,
-		    0),
-	GATE_INFRA2(CK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CK_INFRA_66M_PHCK,
-		    1),
-	GATE_INFRA2(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_INFRA_USB_SYS_CK,
-		    2),
-	GATE_INFRA2(CK_INFRA_IUSB_CK, "infra_iusb", CK_INFRA_USB_CK, 3),
-	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie",
-		    CK_INFRA_PCIE_GFMUX_TL_O_PRE, 12),
-	GATE_INFRA2(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_CB_CKSQ_40M, 13),
-	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 14),
-	GATE_INFRA2(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_INFRA_133M_PHCK, 15),
+	GATE_INFRA0_INFRA(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_66M_MCK, 0),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_66M_MCK, 1),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BSEL, 2),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM1_SEL, 3),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM2_SEL, 4),
+	GATE_INFRA0_TOP(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_TOP_SYSAXI, 6),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_TOP_SYSAXI, 8),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_TOP_F26M_SEL, 9),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_L_CK, "infra_aud_l", CK_TOP_AUD_L, 10),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_AUD_CK, "infra_aud_aud", CK_TOP_A1SYS,
+			11),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CK_TOP_A_TUNER,
+			13),
+	GATE_INFRA0_TOP(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_TOP_F26M_SEL,
+			14),
+	GATE_INFRA0_INFRA(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_66M_MCK, 15),
+	GATE_INFRA0_INFRA(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_66M_MCK, 16),
+	GATE_INFRA0_INFRA(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_66M_MCK, 24),
+	GATE_INFRA0_TOP(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_TOP_F26M_SEL, 25),
+	GATE_INFRA1_TOP(CK_INFRA_THERM_CK, "infra_therm", CK_TOP_F26M_SEL, 0),
+	GATE_INFRA1_TOP(CK_INFRA_I2C0_CK, "infra_i2c0", CK_TOP_I2C_BCK, 1),
+	GATE_INFRA1_INFRA(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_UART0_SEL, 2),
+	GATE_INFRA1_INFRA(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_UART1_SEL, 3),
+	GATE_INFRA1_INFRA(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_UART2_SEL, 4),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI2_CK, "infra_spi2", CK_INFRA_SPI2_SEL, 6),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI2_HCK_CK, "infra_spi2_hck", CK_INFRA_66M_MCK,
+			  7),
+	GATE_INFRA1_TOP(CK_INFRA_NFI1_CK, "infra_nfi1", CK_TOP_NFI1X, 8),
+	GATE_INFRA1_TOP(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_TOP_SPINFI_BCK,
+			9),
+	GATE_INFRA1_INFRA(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_66M_MCK, 10),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_SPI0_SEL, 11),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_SPI1_SEL, 12),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_66M_MCK,
+			  13),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_66M_MCK,
+			  14),
+	GATE_INFRA1_TOP(CK_INFRA_FRTC_CK, "infra_frtc", CK_TOP_CB_RTC_32K, 15),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_CK, "infra_msdc", CK_TOP_EMMC_400M, 16),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
+			CK_TOP_EMMC_208M, 17),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
+			CK_TOP_SYSAXI, 18),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_TOP_SYSAXI,
+			19),
+	GATE_INFRA1_INFRA(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_ADC_FRC_CK, 20),
+	GATE_INFRA1_TOP(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_TOP_F26M, 21),
+	GATE_INFRA1_TOP(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_TOP_NFI1X,
+			23),
+	GATE_INFRA1_TOP(CK_INFRA_I2C_MCK_CK, "infra_i2c_mck", CK_TOP_SYSAXI,
+			25),
+	GATE_INFRA1_INFRA(CK_INFRA_I2C_PCK_CK, "infra_i2c_pck", CK_INFRA_66M_MCK, 26),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_133_CK, "infra_iusb_133", CK_TOP_SYSAXI,
+			0),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CK_TOP_SYSAXI,
+			1),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_TOP_U2U3_SYS,
+			2),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_CK, "infra_iusb", CK_TOP_U2U3_REF, 3),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_TOP_PEXTP_TL, 12),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_CB_CKSQ_40M, 13),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_TOP_F26M, 14),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_TOP_SYSAXI, 15),
 };
 
 static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
@@ -532,14 +517,15 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.flags = CLK_BYPASS_XTAL,
+	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
-	.fdivs_offs = CK_INFRA_CK_F26M,
+	.fdivs_offs = CK_INFRA_66M_MCK,
 	.muxes_offs = CK_INFRA_UART0_SEL,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
+	.flags = CLK_INFRASYS,
 };
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
diff --git a/include/dt-bindings/clock/mt7981-clk.h b/include/dt-bindings/clock/mt7981-clk.h
index 2dae6766ac3..8a6f5cb319e 100644
--- a/include/dt-bindings/clock/mt7981-clk.h
+++ b/include/dt-bindings/clock/mt7981-clk.h
@@ -10,44 +10,8 @@
 
 /* INFRACFG */
 
-#define CK_INFRA_CK_F26M		0
-#define CK_INFRA_UART			1
-#define CK_INFRA_ISPI0			2
-#define CK_INFRA_I2C			3
-#define CK_INFRA_ISPI1			4
-#define CK_INFRA_PWM			5
-#define CK_INFRA_66M_MCK		6
-#define CK_INFRA_CK_F32K		7
-#define CK_INFRA_PCIE_CK		8
-#define CK_INFRA_PWM_BCK		9
-#define CK_INFRA_PWM_CK1		10
-#define CK_INFRA_PWM_CK2		11
-#define CK_INFRA_133M_HCK		12
-#define CK_INFRA_66M_PHCK		13
-#define CK_INFRA_FAUD_L_CK		14
-#define CK_INFRA_FAUD_AUD_CK		15
-#define CK_INFRA_FAUD_EG2_CK		16
-#define CK_INFRA_I2CS_CK		17
-#define CK_INFRA_MUX_UART0		18
-#define CK_INFRA_MUX_UART1		19
-#define CK_INFRA_MUX_UART2		20
-#define CK_INFRA_NFI_CK			21
-#define CK_INFRA_SPINFI_CK		22
-#define CK_INFRA_MUX_SPI0		23
-#define CK_INFRA_MUX_SPI1		24
-#define CK_INFRA_MUX_SPI2		25
-#define CK_INFRA_RTC_32K		26
-#define CK_INFRA_FMSDC_CK		27
-#define CK_INFRA_FMSDC_HCK_CK		28
-#define CK_INFRA_PERI_133M		29
-#define CK_INFRA_133M_PHCK		30
-#define CK_INFRA_USB_SYS_CK		31
-#define CK_INFRA_USB_CK			32
-#define CK_INFRA_USB_XHCI_CK		33
-#define CK_INFRA_PCIE_GFMUX_TL_O_PRE	34
-#define CK_INFRA_F26M_CK0		35
-#define CK_INFRA_133M_MCK		36
-#define CLK_INFRA_NR_CLK		37
+#define CK_INFRA_66M_MCK		0
+#define CLK_INFRA_NR_CLK		1
 
 /* TOPCKGEN */
 
-- 
2.45.2

