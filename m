Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EC6C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B1D887B4;
	Sat,  3 Aug 2024 13:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GL3cLIEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B52188C97; Sat,  3 Aug 2024 13:10:44 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE04B88BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so22829815e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683441; x=1723288241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8UxV+UskE2RGZweXbEAuHGDEjcn8v6U4NOQGLSQxEhU=;
 b=GL3cLIEP5qhFhoy4zO6K39NbTdLnfGCNSa9M31yhFOAGgHHoWDEAbqxrm4E/nzkZba
 tt8PdmU6aBVHMv3mg5h78L7cElAAKeHyfjpigROIKiU1s72uKPnKvon/FFdFa9k9cnaq
 lblKhYnlVVpXOdtEDlsGK+lPBXtS5HLOYhlDy9or63K9otaZRGLGFjp+6JCTc5SwhLtH
 g6UG3YKRPm+y17StXPK7fG+x0o7WoTALfPEkj7oFyh0MybLgmDET4jWgw3vFuVPv2QZ9
 ThXHkBGtSw1O0AQz/cYsRIHjzpPsY1bkHRPAswMkXw9+d8eVqstmcdqLLytPiYZRwc/F
 Fl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683441; x=1723288241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UxV+UskE2RGZweXbEAuHGDEjcn8v6U4NOQGLSQxEhU=;
 b=SSZadJRfu7MqCy/2wNigNxx2b0wieH7d+hJ8k30RpPo5aPQOMbL3w2NKeRR3D1YH0E
 sFxJCb7z1NAqpyqiBf4f48Lv3U5Nn54HWk8885qi1H9LTUF4vt5h1JViNFi7+HfQBdaD
 3lbCmxG/NZ14nPZ2ucXbns5rwCLegqEVd0nW8TCz1W/gojFVTntQ+rs4lrIUZ8Cn92M/
 u0MgsCVV1ok9cq4uTgIhGd2coXCSDkWxvligfmdzv4IVthMYcAjNFL/5kF4BtrcdejWS
 +lu9cy65DBQcmxAj/FbFhJOMYManbr+di2DydINVtdvt19q1mLxPGivl+jsV87xEw8gn
 qD9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ehc7OUtY28uU4tFw9HxAoGWa9xO6j130zETX31xfzqxKb8OYKVaRJrVjrlFC0i7/KM/RDJet5b40c91NVO4QsCW1Ng==
X-Gm-Message-State: AOJu0YwLRmqV8Doa79BFe1sQ2J4TwuJ42K/FoEVqnX5wppBOFcJmBZBP
 Maf+PERtrquGenB7JQzH0wNNnidSD46YbWYLHftxBL50Iqj3wZwr
X-Google-Smtp-Source: AGHT+IFLwu2pX8D54ZoT9pyTKJ6liHie7tFgfnzJUppx8Ndr52JC/ssLgvz8gaVKPtJPdE72ROAo4g==
X-Received: by 2002:a05:600c:3baa:b0:426:67fa:f7 with SMTP id
 5b1f17b1804b1-428e4728b50mr59722915e9.9.1722683441050; 
 Sat, 03 Aug 2024 04:10:41 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 05/15] clk: mediatek: mt7986: drop 1/1 infracfg spurious factor
Date: Sat,  3 Aug 2024 10:40:38 +0200
Message-ID: <20240803084050.449-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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
ID match the ID in upstream include for mt7986.

Drop the factor entry from mt7986-clk.h and reference to them in
mt7981.dtsi. Muxes and gates are updated to reference the topckgen clk
following how it's done in upstream kernel linux. Add relevant clk type
flag in clk_tree for infracfg and topckgen.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi               |  18 +-
 drivers/clk/mediatek/clk-mt7986.c      | 235 ++++++++++++-------------
 include/dt-bindings/clock/mt7986-clk.h |  40 +----
 3 files changed, 120 insertions(+), 173 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index 276f82f2065..e26b85b8266 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -78,7 +78,7 @@
 		compatible = "mediatek,mt7986-timer";
 		reg = <0x10008000 0x1000>;
 		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_CK_F26M>;
+		clocks = <&topckgen CK_TOP_F26M_SEL>;
 		clock-names = "gpt-clk";
 		bootph-all;
 	};
@@ -154,7 +154,7 @@
 		#clock-cells = <1>;
 		#pwm-cells = <2>;
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_PWM>,
+		clocks = <&topckgen CK_TOP_PWM_SEL>,
 			 <&infracfg_ao CK_INFRA_PWM_BSEL>,
 			 <&infracfg_ao CK_INFRA_PWM1_CK>,
 			 <&infracfg_ao CK_INFRA_PWM2_CK>;
@@ -163,9 +163,9 @@
 				  <&infracfg CK_INFRA_PWM1_SEL>,
 				  <&infracfg CK_INFRA_PWM2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D4>,
-					 <&infracfg CK_INFRA_PWM>,
-					 <&infracfg CK_INFRA_PWM>,
-					 <&infracfg CK_INFRA_PWM>;
+					 <&topckgen CK_TOP_PWM_SEL>,
+					 <&topckgen CK_TOP_PWM_SEL>,
+					 <&topckgen CK_TOP_PWM_SEL>;
 		clock-names = "top", "main", "pwm1", "pwm2";
 		status = "disabled";
 		bootph-all;
@@ -179,7 +179,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
-					 <&infracfg CK_INFRA_UART>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 		bootph-all;
@@ -191,7 +191,7 @@
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&infracfg_ao CK_INFRA_UART1_CK>;
 		assigned-clocks = <&infracfg CK_INFRA_UART1_SEL>;
-		assigned-clock-parents = <&infracfg CK_INFRA_CK_F26M>;
+		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -202,7 +202,7 @@
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&infracfg_ao CK_INFRA_UART2_CK>;
 		assigned-clocks = <&infracfg CK_INFRA_UART2_SEL>;
-		assigned-clock-parents = <&infracfg CK_INFRA_CK_F26M>;
+		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -263,7 +263,7 @@
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
-					 <&topckgen CK_INFRA_ISPI0>;
+					 <&topckgen CK_TOP_SPI_SEL>;
 		clock-names = "sel-clk", "spi-clk";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index cb4d20a204d..f1870ce3d60 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -303,80 +303,50 @@ static const struct mtk_composite top_muxes[] = {
 
 /* INFRA FIXED DIV */
 static const struct mtk_fixed_factor infra_fixed_divs[] = {
-	TOP_FACTOR(CK_INFRA_CK_F26M, "infra_ck_f26m", CK_TOP_F26M_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_UART, "infra_uart", CK_TOP_UART_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_ISPI0, "infra_ispi0", CK_TOP_SPI_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_I2C, "infra_i2c", CK_TOP_I2C_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_ISPI1, "infra_ispi1", CK_TOP_SPINFI_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PWM, "infra_pwm", CK_TOP_PWM_SEL, 1, 1),
 	TOP_FACTOR(CK_INFRA_SYSAXI_D2, "infra_sysaxi_d2", CK_TOP_SYSAXI_SEL, 1, 2),
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
-	TOP_FACTOR(CK_INFRA_EIP_CK, "infra_eip", CK_TOP_EIP_B, 1, 1),
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
-	TOP_FACTOR(CK_INFRA_RTC_32K, "infra_rtc_32k", CK_TOP_CB_RTC_32K, 1, 1),
-	TOP_FACTOR(CK_INFRA_FMSDC_CK, "infra_fmsdc", CK_TOP_EMMC_416M, 1, 1),
-	TOP_FACTOR(CK_INFRA_FMSDC_HCK_CK, "infra_fmsdc_hck", CK_TOP_EMMC_250M,
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
-	TOP_FACTOR(CK_INFRA_HD_133M, "infra_hd_133m", CK_TOP_SYSAXI, 1, 1),
 };
 
 /* INFRASYS MUX PARENTS */
-static const int infra_uart0_parents[] = { CK_INFRA_CK_F26M, CK_INFRA_UART };
+#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
+#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
+#define VOID_PARENT PARENT(-1, 0)
 
-static const int infra_spi0_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI0 };
+static const struct mtk_parent infra_uart0_parents[] = {
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	TOP_PARENT(CK_TOP_UART_SEL)
+};
 
-static const int infra_spi1_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI1 };
+static const struct mtk_parent infra_spi0_parents[] = {
+	TOP_PARENT(CK_TOP_I2C_SEL),
+	TOP_PARENT(CK_TOP_SPI_SEL)
+};
 
-static const int infra_pwm_bsel_parents[] = { CK_INFRA_CK_F32K,
-					      CK_INFRA_CK_F26M,
-					      CK_INFRA_SYSAXI_D2, CK_INFRA_PWM };
+static const struct mtk_parent infra_spi1_parents[] = {
+	TOP_PARENT(CK_TOP_I2C_SEL),
+	TOP_PARENT(CK_TOP_SPINFI_SEL)
+};
+
+static const struct mtk_parent infra_pwm_bsel_parents[] = {
+	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	INFRA_PARENT(CK_INFRA_SYSAXI_D2),
+	TOP_PARENT(CK_TOP_PWM_SEL)
+};
 
-static const int infra_pcie_parents[] = { CK_INFRA_CK_F32K, CK_INFRA_CK_F26M,
-					  -1, CK_INFRA_PCIE_CK };
+static const struct mtk_parent infra_pcie_parents[] = {
+	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_F26M_SEL),
+	VOID_PARENT,
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
@@ -422,91 +392,103 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
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
 	/* INFRA0 */
-	GATE_INFRA0(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_SYSAXI_D2, 0),
-	GATE_INFRA0(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_SYSAXI_D2, 1),
-	GATE_INFRA0(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BCK, 2),
-	GATE_INFRA0(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM_CK1, 3),
-	GATE_INFRA0(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM_CK2, 4),
-	GATE_INFRA0(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_INFRA_133M_HCK, 6),
-	GATE_INFRA0(CK_INFRA_EIP97_CK, "infra_eip97", CK_INFRA_EIP_CK, 7),
-	GATE_INFRA0(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_INFRA_66M_PHCK, 8),
-	GATE_INFRA0(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_INFRA_CK_F26M, 9),
-	GATE_INFRA0(CK_INFRA_AUD_L_CK, "infra_aud_l", CK_INFRA_FAUD_L_CK, 10),
-	GATE_INFRA0(CK_INFRA_AUD_AUD_CK, "infra_aud_aud", CK_INFRA_FAUD_AUD_CK,
-		    11),
-	GATE_INFRA0(CK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CK_INFRA_FAUD_EG2_CK,
-		    13),
-	GATE_INFRA0(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_INFRA_CK_F26M,
-		    14),
-	GATE_INFRA0(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_SYSAXI_D2, 15),
-	GATE_INFRA0(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_SYSAXI_D2, 16),
-	GATE_INFRA0(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_SYSAXI_D2, 24),
-	GATE_INFRA0(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_INFRA_CK_F26M, 25),
-	GATE_INFRA0(CK_INFRA_TRNG_CK, "infra_trng", CK_INFRA_HD_133M, 26),
+	GATE_INFRA0_INFRA(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_SYSAXI_D2, 0),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_SYSAXI_D2, 1),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BSEL, 2),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM1_SEL, 3),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM2_SEL, 4),
+	GATE_INFRA0_TOP(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_TOP_SYSAXI_SEL, 6),
+	GATE_INFRA0_TOP(CK_INFRA_EIP97_CK, "infra_eip97", CK_TOP_EIP_B_SEL, 7),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_TOP_SYSAXI_SEL, 8),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_TOP_F26M_SEL, 9),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_L_CK, "infra_aud_l", CK_TOP_AUD_L_SEL, 10),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_AUD_CK, "infra_aud_aud", CK_TOP_A1SYS_SEL,
+			11),
+	GATE_INFRA0_TOP(CK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CK_TOP_A_TUNER_SEL,
+			13),
+	GATE_INFRA0_TOP(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_TOP_F26M_SEL,
+			14),
+	GATE_INFRA0_INFRA(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_SYSAXI_D2, 15),
+	GATE_INFRA0_INFRA(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_SYSAXI_D2, 16),
+	GATE_INFRA0_INFRA(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_SYSAXI_D2, 24),
+	GATE_INFRA0_TOP(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_TOP_F26M_SEL, 25),
+	GATE_INFRA0_TOP(CK_INFRA_TRNG_CK, "infra_trng", CK_TOP_SYSAXI_SEL, 26),
 	/* INFRA1 */
-	GATE_INFRA1(CK_INFRA_THERM_CK, "infra_therm", CK_INFRA_CK_F26M, 0),
-	GATE_INFRA1(CK_INFRA_I2CO_CK, "infra_i2co", CK_INFRA_I2CS_CK, 1),
-	GATE_INFRA1(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_MUX_UART0, 2),
-	GATE_INFRA1(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_MUX_UART1, 3),
-	GATE_INFRA1(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_MUX_UART2, 4),
-	GATE_INFRA1(CK_INFRA_NFI1_CK, "infra_nfi1", CK_INFRA_NFI_CK, 8),
-	GATE_INFRA1(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_INFRA_SPINFI_CK,
-		    9),
-	GATE_INFRA1(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_SYSAXI_D2, 10),
-	GATE_INFRA1(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_MUX_SPI0, 11),
-	GATE_INFRA1(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_MUX_SPI1, 12),
-	GATE_INFRA1(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_SYSAXI_D2,
-		    13),
-	GATE_INFRA1(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_SYSAXI_D2,
-		    14),
-	GATE_INFRA1(CK_INFRA_FRTC_CK, "infra_frtc", CK_INFRA_RTC_32K, 15),
-	GATE_INFRA1(CK_INFRA_MSDC_CK, "infra_msdc", CK_INFRA_FMSDC_CK, 16),
-	GATE_INFRA1(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
-		    CK_INFRA_FMSDC_HCK_CK, 17),
-	GATE_INFRA1(CK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
-		    CK_INFRA_PERI_133M, 18),
-	GATE_INFRA1(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_INFRA_66M_PHCK,
-		    19),
-	GATE_INFRA1(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_ADC_FRC_CK, 20),
-	GATE_INFRA1(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_INFRA_CK_F26M, 21),
-	GATE_INFRA1(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_INFRA_NFI_CK,
-		    23),
+	GATE_INFRA1_TOP(CK_INFRA_THERM_CK, "infra_therm", CK_TOP_F26M_SEL, 0),
+	GATE_INFRA1_TOP(CK_INFRA_I2CO_CK, "infra_i2co", CK_TOP_I2C_SEL, 1),
+	GATE_INFRA1_INFRA(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_UART0_SEL, 2),
+	GATE_INFRA1_INFRA(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_UART1_SEL, 3),
+	GATE_INFRA1_INFRA(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_UART2_SEL, 4),
+	GATE_INFRA1_TOP(CK_INFRA_NFI1_CK, "infra_nfi1", CK_TOP_NFI1X_SEL, 8),
+	GATE_INFRA1_TOP(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_TOP_SPINFI_SEL,
+			9),
+	GATE_INFRA1_INFRA(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_SYSAXI_D2, 10),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_SPI0_SEL, 11),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_SPI1_SEL, 12),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_SYSAXI_D2,
+			  13),
+	GATE_INFRA1_INFRA(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_SYSAXI_D2,
+			  14),
+	GATE_INFRA1_TOP(CK_INFRA_FRTC_CK, "infra_frtc", CK_TOP_CB_RTC_32K, 15),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_CK, "infra_msdc", CK_TOP_EMMC_416M_SEL, 16),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
+			CK_TOP_EMMC_250M_SEL, 17),
+	GATE_INFRA1_TOP(CK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
+			CK_TOP_SYSAXI_SEL, 18),
+	GATE_INFRA1_INFRA(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_INFRA_SYSAXI_D2,
+			  19),
+	GATE_INFRA1_INFRA(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_ADC_FRC_CK, 20),
+	GATE_INFRA1_TOP(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_TOP_F26M_SEL, 21),
+	GATE_INFRA1_TOP(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_TOP_NFI1X_SEL,
+			23),
 	/* INFRA2 */
-	GATE_INFRA2(CK_INFRA_IUSB_133_CK, "infra_iusb_133", CK_INFRA_133M_PHCK,
-		    0),
-	GATE_INFRA2(CK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CK_INFRA_66M_PHCK,
-		    1),
-	GATE_INFRA2(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_INFRA_USB_SYS_CK,
-		    2),
-	GATE_INFRA2(CK_INFRA_IUSB_CK, "infra_iusb", CK_INFRA_USB_CK, 3),
-	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_INFRA_PCIE_CK, 12),
-	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 14),
-	GATE_INFRA2(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_INFRA_133M_PHCK, 15),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_133_CK, "infra_iusb_133", CK_TOP_SYSAXI_SEL,
+			0),
+	GATE_INFRA2_INFRA(CK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CK_INFRA_SYSAXI_D2,
+			  1),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_TOP_U2U3_SYS_SEL,
+			2),
+	GATE_INFRA2_TOP(CK_INFRA_IUSB_CK, "infra_iusb", CK_TOP_U2U3_SEL, 3),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_TOP_PEXTP_TL_SEL, 12),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_TOP_F26M_SEL, 14),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_TOP_SYSAXI_SEL, 15),
 };
 
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
@@ -521,14 +503,15 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.flags = CLK_BYPASS_XTAL,
+	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
-	.fdivs_offs = CK_INFRA_CK_F26M,
+	.fdivs_offs = CK_INFRA_SYSAXI_D2,
 	.muxes_offs = CK_INFRA_UART0_SEL,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
+	.flags = CLK_INFRASYS,
 };
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index f45ef7afcc6..dbae389858a 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -10,44 +10,8 @@
 
 /* INFRACFG */
 
-#define CK_INFRA_CK_F26M		0
-#define CK_INFRA_UART			1
-#define CK_INFRA_ISPI0			2
-#define CK_INFRA_I2C			3
-#define CK_INFRA_ISPI1			4
-#define CK_INFRA_PWM			5
-#define CK_INFRA_SYSAXI_D2		6
-#define CK_INFRA_CK_F32K		7
-#define CK_INFRA_PCIE_CK		8
-#define CK_INFRA_PWM_BCK		9
-#define CK_INFRA_PWM_CK1		10
-#define CK_INFRA_PWM_CK2		11
-#define CK_INFRA_133M_HCK		12
-#define CK_INFRA_EIP_CK			13
-#define CK_INFRA_66M_PHCK		14
-#define CK_INFRA_FAUD_L_CK		15
-#define CK_INFRA_FAUD_AUD_CK		17
-#define CK_INFRA_FAUD_EG2_CK		17
-#define CK_INFRA_I2CS_CK		18
-#define CK_INFRA_MUX_UART0		19
-#define CK_INFRA_MUX_UART1		20
-#define CK_INFRA_MUX_UART2		21
-#define CK_INFRA_NFI_CK			22
-#define CK_INFRA_SPINFI_CK		23
-#define CK_INFRA_MUX_SPI0		24
-#define CK_INFRA_MUX_SPI1		25
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
-#define CK_INFRA_HD_133M		36
-#define CLK_INFRA_NR_CLK		37
+#define CK_INFRA_SYSAXI_D2		0
+#define CLK_INFRA_NR_CLK		1
 
 /* TOPCKGEN */
 
-- 
2.45.2

