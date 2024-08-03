Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F93C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D86F88BF3;
	Sat,  3 Aug 2024 10:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BErqLgTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BEC88C21; Sat,  3 Aug 2024 10:33:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E97888FA
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so18037575e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674008; x=1723278808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8fpKSf/g4mbstorLOK2GC7RWLiad55HhHO6difEzPcY=;
 b=BErqLgTSPZHBISNlUIxUJ4VM95O7HXW3zNWQ9HZtLyLxUh9D85q5YOR7Kg48WDBpl6
 ObUq6W4ap3G22bYnU4ye/rvkk60BuND7ay4+CJcF/YEqhRyIMg9ifQm1iOgXejdfmIUT
 dJMpDXx7ZTG4vqWtEtlM6OV8gvWdw73zzNJo+SbJ7e2eLtdRDzBHIOEdhbRd3Hgjyk56
 YueSo84V4RMHAxRP7bsH5MNVtIpnl0VAM2lhycbfoYSG96eRwYKvBrE8U4uzlraHYH43
 28p3UIJNXWGFH3giJ3RX5RAsHyOGsSrjdQmpac6QTDsxfdg9Z8vmekcUUAxx/4T46sIw
 gUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674008; x=1723278808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fpKSf/g4mbstorLOK2GC7RWLiad55HhHO6difEzPcY=;
 b=NCDpbUMk1zNu06wAGPVKff5lZk3DOr9unj2Lav+3dOBQBLsVK+WmORGR810gaFrg3T
 OISRviZwj4w24mo/KkzDjyS2pHQ3goYJ+uk6edNrsDYCgD0vOtuyGEnVoPouxjsuwqn4
 hfqMAqTediSE6+dG2cyxLIlinNTVSwyoj+F23JK3zgjBLZF9gjZf5u7dkjnI5OVJzema
 WXHPTsJqnj+qIUC3XkRdEQ+un0NAEp3+/TWk6JsYnP3z2nEQx+rDZIOrgk7l8HVHAWrA
 ljE7y02nLJ5FxsWZZdBGQbBabXlRamASwZdgTrUeJKRpJuWtPYBg0W3LkrIISNi7fGI8
 Q47A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxAjgjww5d3wE7th7qu6iP3qcLBrVBIcotr4jakPcUDFOydXFdn4pCjleWzXRNBGBfAtqMzx93v9yfzlnSrz/MmEcxHQ==
X-Gm-Message-State: AOJu0Yzu0UBvTg2ndnQeFMlWrMoulexJCHfq2DN9i8Ykq9bUK1xOrNN5
 gPMcN4Okd6sfLR/7JA4XjHDsqFP1iKEx1qSe0Cp2ZAtftoBGSHD1
X-Google-Smtp-Source: AGHT+IFv9Uri3k/LTvTb4QrFt8Hg/QlB+OCJHeM0NNPQPP+MW11tELqxO53azi9yE98fjv/Pa7Fqpg==
X-Received: by 2002:a05:600c:4447:b0:426:5dca:50a with SMTP id
 5b1f17b1804b1-428e6b31274mr36661725e9.21.1722674007449; 
 Sat, 03 Aug 2024 01:33:27 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 06/13] clk: mediatek: mt7988: drop 1/1 infracfg spurious factor
Date: Sat,  3 Aug 2024 10:32:55 +0200
Message-ID: <20240803083305.30697-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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
ID match the ID in upstream include for mt7988.

Drop the factor entry from mt7988-clk.h and reference to them in
mt7988.dtsi. Muxes and gates are updated to reference the topckgen clk
following how it's done in upstream kernel linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7988.dtsi               |   6 +-
 drivers/clk/mediatek/clk-mt7988.c      | 468 +++++++++++--------------
 include/dt-bindings/clock/mt7988-clk.h |  87 +----
 3 files changed, 227 insertions(+), 334 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 2605e60c993..e8ab5e625da 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -266,7 +266,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
-					 <&infracfg_ao CK_INFRA_UART_O0>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
 	};
 
@@ -278,7 +278,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
-					 <&infracfg_ao CK_INFRA_UART_O1>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
 	};
 
@@ -290,7 +290,7 @@
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
-					 <&infracfg_ao CK_INFRA_UART_O2>;
+					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
 	};
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index a37ad574e11..104f072cd0d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -424,116 +424,42 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
 		netsys_2x_parents, 0x120, 0x124, 0x128, 8, 2, 15, 0x1c8, 11),
 };
 
-/* INFRA FIXED DIV */
-static const struct mtk_fixed_factor infracfg_mtk_fixed_factor[] = {
-	TOP_FACTOR(CK_INFRA_CK_F26M, "infra_ck_f26m", CK_TOP_INFRA_F26M_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_PWM_O, "infra_pwm_o", CK_TOP_PWM_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PCIE_OCC_P0, "infra_pcie_ck_occ_p0",
-		   CK_TOP_PEXTP_TL_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PCIE_OCC_P1, "infra_pcie_ck_occ_p1",
-		   CK_TOP_PEXTP_TL_P1_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PCIE_OCC_P2, "infra_pcie_ck_occ_p2",
-		   CK_TOP_PEXTP_TL_P2_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_PCIE_OCC_P3, "infra_pcie_ck_occ_p3",
-		   CK_TOP_PEXTP_TL_P3_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_133M_HCK, "infra_133m_hck", CK_TOP_SYSAXI, 1, 1),
-	INFRA_FACTOR(CK_INFRA_133M_PHCK, "infra_133m_phck", CK_INFRA_133M_HCK,
-		     1, 1),
-	INFRA_FACTOR(CK_INFRA_66M_PHCK, "infra_66m_phck", CK_INFRA_133M_HCK, 1,
-		     1),
-	TOP_FACTOR(CK_INFRA_FAUD_L_O, "infra_faud_l_o", CK_TOP_AUD_L, 1, 1),
-	TOP_FACTOR(CK_INFRA_FAUD_AUD_O, "infra_faud_aud_o", CK_TOP_A1SYS, 1, 1),
-	TOP_FACTOR(CK_INFRA_FAUD_EG2_O, "infra_faud_eg2_o", CK_TOP_A_TUNER, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_I2C_O, "infra_i2c_o", CK_TOP_I2C_BCK, 1, 1),
-	TOP_FACTOR(CK_INFRA_UART_O0, "infra_uart_o0", CK_TOP_UART_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_UART_O1, "infra_uart_o1", CK_TOP_UART_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_UART_O2, "infra_uart_o2", CK_TOP_UART_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_NFI_O, "infra_nfi_o", CK_TOP_NFI1X, 1, 1),
-	TOP_FACTOR(CK_INFRA_SPINFI_O, "infra_spinfi_o", CK_TOP_SPINFI_BCK, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_SPI0_O, "infra_spi0_o", CK_TOP_SPI, 1, 1),
-	TOP_FACTOR(CK_INFRA_SPI1_O, "infra_spi1_o", CK_TOP_SPIM_MST, 1, 1),
-	INFRA_FACTOR(CK_INFRA_LB_MUX_FRTC, "infra_lb_mux_frtc", CK_INFRA_FRTC,
-		     1, 1),
-	TOP_FACTOR(CK_INFRA_FRTC, "infra_frtc", CK_TOP_CB_RTC_32K, 1, 1),
-	TOP_FACTOR(CK_INFRA_FMSDC400_O, "infra_fmsdc400_o", CK_TOP_EMMC_400M, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_FMSDC2_HCK_OCC, "infra_fmsdc2_hck_occ",
-		   CK_TOP_EMMC_250M, 1, 1),
-	TOP_FACTOR(CK_INFRA_PERI_133M, "infra_peri_133m", CK_TOP_SYSAXI, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_O, "infra_usb_o", CK_TOP_USB_REF, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_O_P1, "infra_usb_o_p1", CK_TOP_USB_CK_P1, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_FRMCNT_O, "infra_usb_frmcnt_o",
-		   CK_TOP_USB_FRMCNT, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_FRMCNT_O_P1, "infra_usb_frmcnt_o_p1",
-		   CK_TOP_USB_FRMCNT_P1, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_XHCI_O, "infra_usb_xhci_o", CK_TOP_USB_XHCI, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_USB_XHCI_O_P1, "infra_usb_xhci_o_p1",
-		   CK_TOP_USB_XHCI_P1, 1, 1),
-	XTAL_FACTOR(CK_INFRA_USB_PIPE_O, "infra_usb_pipe_o", CLK_XTAL, 1, 1),
-	XTAL_FACTOR(CK_INFRA_USB_PIPE_O_P1, "infra_usb_pipe_o_p1", CLK_XTAL, 1,
-		    1),
-	XTAL_FACTOR(CK_INFRA_USB_UTMI_O, "infra_usb_utmi_o", CLK_XTAL, 1, 1),
-	XTAL_FACTOR(CK_INFRA_USB_UTMI_O_P1, "infra_usb_utmi_o_p1", CLK_XTAL, 1,
-		    1),
-	XTAL_FACTOR(CK_INFRA_PCIE_PIPE_OCC_P0, "infra_pcie_pipe_ck_occ_p0",
-		    CLK_XTAL, 1, 1),
-	XTAL_FACTOR(CK_INFRA_PCIE_PIPE_OCC_P1, "infra_pcie_pipe_ck_occ_p1",
-		    CLK_XTAL, 1, 1),
-	XTAL_FACTOR(CK_INFRA_PCIE_PIPE_OCC_P2, "infra_pcie_pipe_ck_occ_p2",
-		    CLK_XTAL, 1, 1),
-	XTAL_FACTOR(CK_INFRA_PCIE_PIPE_OCC_P3, "infra_pcie_pipe_ck_occ_p3",
-		    CLK_XTAL, 1, 1),
-	TOP_FACTOR(CK_INFRA_F26M_O0, "infra_f26m_o0", CK_TOP_INFRA_F26M, 1, 1),
-	TOP_FACTOR(CK_INFRA_F26M_O1, "infra_f26m_o1", CK_TOP_INFRA_F26M, 1, 1),
-	TOP_FACTOR(CK_INFRA_133M_MCK, "infra_133m_mck", CK_TOP_SYSAXI, 1, 1),
-	TOP_FACTOR(CK_INFRA_66M_MCK, "infra_66m_mck", CK_TOP_SYSAXI, 1, 1),
-	TOP_FACTOR(CK_INFRA_PERI_66M_O, "infra_peri_66m_o", CK_TOP_SYSAXI, 1,
-		   1),
-	TOP_FACTOR(CK_INFRA_USB_SYS_O, "infra_usb_sys_o", CK_TOP_USB_SYS, 1, 1),
-	TOP_FACTOR(CK_INFRA_USB_SYS_O_P1, "infra_usb_sys_o_p1",
-		   CK_TOP_USB_SYS_P1, 1, 1),
-};
-
 /* INFRASYS MUX PARENTS */
-static const int infra_mux_uart0_parents[] = { CK_INFRA_CK_F26M,
-					       CK_INFRA_UART_O0 };
+static const int infra_mux_uart0_parents[] = { CK_TOP_INFRA_F26M_SEL,
+					       CK_TOP_UART_SEL };
 
-static const int infra_mux_uart1_parents[] = { CK_INFRA_CK_F26M,
-					       CK_INFRA_UART_O1 };
+static const int infra_mux_uart1_parents[] = { CK_TOP_INFRA_F26M_SEL,
+					       CK_TOP_UART_SEL };
 
-static const int infra_mux_uart2_parents[] = { CK_INFRA_CK_F26M,
-					       CK_INFRA_UART_O2 };
+static const int infra_mux_uart2_parents[] = { CK_TOP_INFRA_F26M_SEL,
+					       CK_TOP_UART_SEL };
 
-static const int infra_mux_spi0_parents[] = { CK_INFRA_I2C_O, CK_INFRA_SPI0_O };
+static const int infra_mux_spi0_parents[] = { CK_TOP_I2C_BCK, CK_TOP_SPI };
 
-static const int infra_mux_spi1_parents[] = { CK_INFRA_I2C_O, CK_INFRA_SPI1_O };
+static const int infra_mux_spi1_parents[] = { CK_TOP_I2C_BCK, CK_TOP_SPIM_MST };
 
 static const int infra_pwm_bck_parents[] = { CK_TOP_INFRA_F32K,
-					     CK_INFRA_CK_F26M, CK_INFRA_66M_MCK,
-					     CK_INFRA_PWM_O };
+					     CK_TOP_INFRA_F26M_SEL, CK_TOP_SYSAXI,
+					     CK_TOP_PWM_SEL };
 
 static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
-	CK_TOP_INFRA_F32K, CK_INFRA_CK_F26M, CK_INFRA_CK_F26M,
-	CK_INFRA_PCIE_OCC_P0
+	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_PEXTP_TL_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
-	CK_TOP_INFRA_F32K, CK_INFRA_CK_F26M, CK_INFRA_CK_F26M,
-	CK_INFRA_PCIE_OCC_P1
+	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_PEXTP_TL_P1_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p2_parents[] = {
-	CK_TOP_INFRA_F32K, CK_INFRA_CK_F26M, CK_INFRA_CK_F26M,
-	CK_INFRA_PCIE_OCC_P2
+	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_PEXTP_TL_P2_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
-	CK_TOP_INFRA_F32K, CK_INFRA_CK_F26M, CK_INFRA_CK_F26M,
-	CK_INFRA_PCIE_OCC_P3
+	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_PEXTP_TL_P3_SEL
 };
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
@@ -542,7 +468,7 @@ static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
 		.mux_clr_reg = _reg + 0x4, .mux_shift = _shift,                \
 		.mux_mask = BIT(_width) - 1, .parent = _parents,               \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_INFRASYS,             \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_TOPCKGEN,             \
 	}
 
 /* INFRA MUX */
@@ -615,196 +541,214 @@ static const struct mtk_gate_regs infra_3_cg_regs = {
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
 
-#define GATE_INFRA3(_id, _name, _parent, _shift)                               \
+#define GATE_INFRA3(_id, _name, _parent, _shift, _flags)                       \
 	{                                                                      \
 		.id = _id, .parent = _parent, .regs = &infra_3_cg_regs,        \
 		.shift = _shift,                                               \
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_INFRASYS,                \
+		.flags = _flags,                                               \
 	}
+#define GATE_INFRA3_INFRA(_id, _name, _parent, _shift) \
+	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
+#define GATE_INFRA3_TOP(_id, _name, _parent, _shift) \
+	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+#define GATE_INFRA3_XTAL(_id, _name, _parent, _shift) \
+	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
 
 /* INFRA GATE */
 static const struct mtk_gate infracfg_mtk_gates[] = {
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P0,
-		    "infra_pcie_peri_ck_26m_ck_p0", CK_INFRA_F26M_O0, 7),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P1,
-		    "infra_pcie_peri_ck_26m_ck_p1", CK_INFRA_F26M_O0, 8),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P2,
-		    "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_PCIE_PERI_26M_CK_P3, 9),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P3,
-		    "infra_pcie_peri_ck_26m_ck_p3", CK_INFRA_F26M_O0, 10),
-	GATE_INFRA1(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
-		    CK_INFRA_66M_MCK, 0),
-	GATE_INFRA1(CK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
-		    CK_INFRA_66M_MCK, 1),
-	GATE_INFRA1(CK_INFRA_66M_PWM_BCK, "infra_hf_66m_pwm_bck",
-		    CK_INFRA_PWM_SEL, 2),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK1, "infra_hf_66m_pwm_ck1",
-		    CK_INFRA_PWM_CK1_SEL, 3),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK2, "infra_hf_66m_pwm_ck2",
-		    CK_INFRA_PWM_CK2_SEL, 4),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK3, "infra_hf_66m_pwm_ck3",
-		    CK_INFRA_PWM_CK3_SEL, 5),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK4, "infra_hf_66m_pwm_ck4",
-		    CK_INFRA_PWM_CK4_SEL, 6),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK5, "infra_hf_66m_pwm_ck5",
-		    CK_INFRA_PWM_CK5_SEL, 7),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK6, "infra_hf_66m_pwm_ck6",
-		    CK_INFRA_PWM_CK6_SEL, 8),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK7, "infra_hf_66m_pwm_ck7",
-		    CK_INFRA_PWM_CK7_SEL, 9),
-	GATE_INFRA1(CK_INFRA_66M_PWM_CK8, "infra_hf_66m_pwm_ck8",
-		    CK_INFRA_PWM_CK8_SEL, 10),
-	GATE_INFRA1(CK_INFRA_133M_CQDMA_BCK, "infra_hf_133m_cqdma_bck",
-		    CK_INFRA_133M_MCK, 12),
-	GATE_INFRA1(CK_INFRA_66M_AUD_SLV_BCK, "infra_66m_aud_slv_bck",
-		    CK_INFRA_66M_PHCK, 13),
-	GATE_INFRA1(CK_INFRA_AUD_26M, "infra_f_faud_26m", CK_INFRA_CK_F26M, 14),
-	GATE_INFRA1(CK_INFRA_AUD_L, "infra_f_faud_l", CK_INFRA_FAUD_L_O, 15),
-	GATE_INFRA1(CK_INFRA_AUD_AUD, "infra_f_aud_aud", CK_INFRA_FAUD_AUD_O,
-		    16),
-	GATE_INFRA1(CK_INFRA_AUD_EG2, "infra_f_faud_eg2", CK_INFRA_FAUD_EG2_O,
-		    18),
-	GATE_INFRA1(CK_INFRA_DRAMC_F26M, "infra_dramc_f26m", CK_INFRA_CK_F26M,
-		    19),
-	GATE_INFRA1(CK_INFRA_133M_DBG_ACKM, "infra_hf_133m_dbg_ackm",
-		    CK_INFRA_133M_MCK, 20),
-	GATE_INFRA1(CK_INFRA_66M_AP_DMA_BCK, "infra_66m_ap_dma_bck",
-		    CK_INFRA_66M_MCK, 21),
-	GATE_INFRA1(CK_INFRA_66M_SEJ_BCK, "infra_hf_66m_sej_bck",
-		    CK_INFRA_66M_MCK, 29),
-	GATE_INFRA1(CK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
-		    CK_INFRA_CK_F26M, 30),
-	GATE_INFRA1(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_INFRA_PERI_66M_O,
-		    31),
-	GATE_INFRA2(CK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system",
-		    CK_INFRA_CK_F26M, 0),
-	GATE_INFRA2(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_INFRA_I2C_O, 1),
-	GATE_INFRA2(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
-		    CK_INFRA_66M_MCK, 3),
-	GATE_INFRA2(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
-		    CK_INFRA_66M_MCK, 4),
-	GATE_INFRA2(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
-		    CK_INFRA_66M_MCK, 5),
-	GATE_INFRA2(CK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
-		    CK_INFRA_MUX_UART0_SEL, 3),
-	GATE_INFRA2(CK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
-		    CK_INFRA_MUX_UART1_SEL, 4),
-	GATE_INFRA2(CK_INFRA_52M_UART2_CK, "infra_f_52m_uart2",
-		    CK_INFRA_MUX_UART2_SEL, 5),
-	GATE_INFRA2(CK_INFRA_NFI, "infra_f_fnfi", CK_INFRA_NFI_O, 9),
-	GATE_INFRA2(CK_INFRA_SPINFI, "infra_f_fspinfi", CK_INFRA_SPINFI_O, 10),
-	GATE_INFRA2(CK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck",
-		    CK_INFRA_66M_MCK, 11),
-	GATE_INFRA2(CK_INFRA_104M_SPI0, "infra_hf_104m_spi0",
-		    CK_INFRA_MUX_SPI0_SEL, 12),
-	GATE_INFRA2(CK_INFRA_104M_SPI1, "infra_hf_104m_spi1",
-		    CK_INFRA_MUX_SPI1_SEL, 13),
-	GATE_INFRA2(CK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck",
-		    CK_INFRA_MUX_SPI2_SEL, 14),
-	GATE_INFRA2(CK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck",
-		    CK_INFRA_66M_MCK, 15),
-	GATE_INFRA2(CK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck",
-		    CK_INFRA_66M_MCK, 16),
-	GATE_INFRA2(CK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck",
-		    CK_INFRA_66M_MCK, 17),
-	GATE_INFRA2(CK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
-		    CK_INFRA_66M_MCK, 18),
-	GATE_INFRA2(CK_INFRA_RTC, "infra_f_frtc", CK_INFRA_LB_MUX_FRTC, 19),
-	GATE_INFRA2(CK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
-		    CK_INFRA_F26M_O1, 20),
-	GATE_INFRA2(CK_INFRA_RC_ADC, "infra_f_frc_adc", CK_INFRA_26M_ADC_BCK,
-		    21),
-	GATE_INFRA2(CK_INFRA_MSDC400, "infra_f_fmsdc400", CK_INFRA_FMSDC400_O,
-		    22),
-	GATE_INFRA2(CK_INFRA_MSDC2_HCK, "infra_f_fmsdc2_hck",
-		    CK_INFRA_FMSDC2_HCK_OCC, 23),
-	GATE_INFRA2(CK_INFRA_133M_MSDC_0_HCK, "infra_hf_133m_msdc_0_hck",
-		    CK_INFRA_PERI_133M, 24),
-	GATE_INFRA2(CK_INFRA_66M_MSDC_0_HCK, "infra_66m_msdc_0_hck",
-		    CK_INFRA_66M_PHCK, 25),
-	GATE_INFRA2(CK_INFRA_133M_CPUM_BCK, "infra_hf_133m_cpum_bck",
-		    CK_INFRA_133M_MCK, 26),
-	GATE_INFRA2(CK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CK_INFRA_NFI_O,
-		    27),
-	GATE_INFRA2(CK_INFRA_I2C_X16W_MCK_CK_P1, "infra_hf_i2c_x16w_mck_ck_p1",
-		    CK_INFRA_133M_MCK, 29),
-	GATE_INFRA2(CK_INFRA_I2C_X16W_PCK_CK_P1, "infra_hf_i2c_x16w_pck_ck_p1",
-		    CK_INFRA_66M_PHCK, 31),
-	GATE_INFRA3(CK_INFRA_133M_USB_HCK, "infra_133m_usb_hck",
-		    CK_INFRA_133M_PHCK, 0),
-	GATE_INFRA3(CK_INFRA_133M_USB_HCK_CK_P1, "infra_133m_usb_hck_ck_p1",
-		    CK_INFRA_133M_PHCK, 1),
-	GATE_INFRA3(CK_INFRA_66M_USB_HCK, "infra_66m_usb_hck",
-		    CK_INFRA_66M_PHCK, 2),
-	GATE_INFRA3(CK_INFRA_66M_USB_HCK_CK_P1, "infra_66m_usb_hck_ck_p1",
-		    CK_INFRA_66M_PHCK, 3),
-	GATE_INFRA3(CK_INFRA_USB_SYS, "infra_usb_sys", CK_INFRA_USB_SYS_O, 4),
-	GATE_INFRA3(CK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
-		    CK_INFRA_USB_SYS_O_P1, 5),
-	GATE_INFRA3(CK_INFRA_USB_REF, "infra_usb_ref", CK_INFRA_USB_O, 6),
-	GATE_INFRA3(CK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CK_INFRA_USB_O_P1,
-		    7),
-	GATE_INFRA3(CK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
-		    CK_INFRA_USB_FRMCNT_O, 8),
-	GATE_INFRA3(CK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
-		    CK_INFRA_USB_FRMCNT_O_P1, 9),
-	GATE_INFRA3(CK_INFRA_USB_PIPE, "infra_usb_pipe", CK_INFRA_USB_PIPE_O,
-		    10),
-	GATE_INFRA3(CK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
-		    CK_INFRA_USB_PIPE_O_P1, 11),
-	GATE_INFRA3(CK_INFRA_USB_UTMI, "infra_usb_utmi", CK_INFRA_USB_UTMI_O,
-		    12),
-	GATE_INFRA3(CK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
-		    CK_INFRA_USB_UTMI_O_P1, 13),
-	GATE_INFRA3(CK_INFRA_USB_XHCI, "infra_usb_xhci", CK_INFRA_USB_XHCI_O,
-		    14),
-	GATE_INFRA3(CK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
-		    CK_INFRA_USB_XHCI_O_P1, 15),
-	GATE_INFRA3(CK_INFRA_PCIE_GFMUX_TL_P0, "infra_pcie_gfmux_tl_ck_p0",
-		    CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
-	GATE_INFRA3(CK_INFRA_PCIE_GFMUX_TL_P1, "infra_pcie_gfmux_tl_ck_p1",
-		    CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL, 21),
-	GATE_INFRA3(CK_INFRA_PCIE_GFMUX_TL_P2, "infra_pcie_gfmux_tl_ck_p2",
-		    CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL, 22),
-	GATE_INFRA3(CK_INFRA_PCIE_GFMUX_TL_P3, "infra_pcie_gfmux_tl_ck_p3",
-		    CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL, 23),
-	GATE_INFRA3(CK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
-		    CK_INFRA_PCIE_PIPE_OCC_P0, 24),
-	GATE_INFRA3(CK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
-		    CK_INFRA_PCIE_PIPE_OCC_P1, 25),
-	GATE_INFRA3(CK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
-		    CK_INFRA_PCIE_PIPE_OCC_P2, 26),
-	GATE_INFRA3(CK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
-		    CK_INFRA_PCIE_PIPE_OCC_P3, 27),
-	GATE_INFRA3(CK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
-		    CK_INFRA_133M_PHCK, 28),
-	GATE_INFRA3(CK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
-		    CK_INFRA_133M_PHCK, 29),
-	GATE_INFRA3(CK_INFRA_133M_PCIE_CK_P2, "infra_133m_pcie_ck_p2",
-		    CK_INFRA_133M_PHCK, 30),
-	GATE_INFRA3(CK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
-		    CK_INFRA_133M_PHCK, 31),
+	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P0,
+			"infra_pcie_peri_ck_26m_ck_p0", CK_TOP_INFRA_F26M, 7),
+	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P1,
+			"infra_pcie_peri_ck_26m_ck_p1", CK_TOP_INFRA_F26M, 8),
+	GATE_INFRA0_INFRA(CK_INFRA_PCIE_PERI_26M_CK_P2,
+			  "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_PCIE_PERI_26M_CK_P3, 9),
+	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P3,
+			"infra_pcie_peri_ck_26m_ck_p3", CK_TOP_INFRA_F26M, 10),
+	GATE_INFRA1_TOP(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
+			CK_TOP_SYSAXI, 0),
+	GATE_INFRA1_TOP(CK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
+			CK_TOP_SYSAXI, 1),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_BCK, "infra_hf_66m_pwm_bck",
+			  CK_INFRA_PWM_SEL, 2),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK1, "infra_hf_66m_pwm_ck1",
+			  CK_INFRA_PWM_CK1_SEL, 3),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK2, "infra_hf_66m_pwm_ck2",
+			  CK_INFRA_PWM_CK2_SEL, 4),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK3, "infra_hf_66m_pwm_ck3",
+			  CK_INFRA_PWM_CK3_SEL, 5),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK4, "infra_hf_66m_pwm_ck4",
+			  CK_INFRA_PWM_CK4_SEL, 6),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK5, "infra_hf_66m_pwm_ck5",
+			  CK_INFRA_PWM_CK5_SEL, 7),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK6, "infra_hf_66m_pwm_ck6",
+			  CK_INFRA_PWM_CK6_SEL, 8),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK7, "infra_hf_66m_pwm_ck7",
+			  CK_INFRA_PWM_CK7_SEL, 9),
+	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK8, "infra_hf_66m_pwm_ck8",
+			  CK_INFRA_PWM_CK8_SEL, 10),
+	GATE_INFRA1_TOP(CK_INFRA_133M_CQDMA_BCK, "infra_hf_133m_cqdma_bck",
+			CK_TOP_SYSAXI, 12),
+	GATE_INFRA1_TOP(CK_INFRA_66M_AUD_SLV_BCK, "infra_66m_aud_slv_bck",
+			CK_TOP_SYSAXI, 13),
+	GATE_INFRA1_TOP(CK_INFRA_AUD_26M, "infra_f_faud_26m", CK_TOP_INFRA_F26M_SEL, 14),
+	GATE_INFRA1_TOP(CK_INFRA_AUD_L, "infra_f_faud_l", CK_TOP_AUD_L, 15),
+	GATE_INFRA1_TOP(CK_INFRA_AUD_AUD, "infra_f_aud_aud", CK_TOP_A1SYS,
+			16),
+	GATE_INFRA1_TOP(CK_INFRA_AUD_EG2, "infra_f_faud_eg2", CK_TOP_A_TUNER,
+			18),
+	GATE_INFRA1_TOP(CK_INFRA_DRAMC_F26M, "infra_dramc_f26m", CK_TOP_INFRA_F26M_SEL,
+			19),
+	GATE_INFRA1_TOP(CK_INFRA_133M_DBG_ACKM, "infra_hf_133m_dbg_ackm",
+			CK_TOP_SYSAXI, 20),
+	GATE_INFRA1_TOP(CK_INFRA_66M_AP_DMA_BCK, "infra_66m_ap_dma_bck",
+			CK_TOP_SYSAXI, 21),
+	GATE_INFRA1_TOP(CK_INFRA_66M_SEJ_BCK, "infra_hf_66m_sej_bck",
+			CK_TOP_SYSAXI, 29),
+	GATE_INFRA1_TOP(CK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
+			CK_TOP_INFRA_F26M_SEL, 30),
+	GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSAXI,
+			31),
+	GATE_INFRA2_TOP(CK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system",
+			CK_TOP_INFRA_F26M_SEL, 0),
+	GATE_INFRA2_TOP(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_TOP_I2C_BCK, 1),
+	GATE_INFRA2_TOP(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
+			CK_TOP_SYSAXI, 3),
+	GATE_INFRA2_TOP(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
+			CK_TOP_SYSAXI, 4),
+	GATE_INFRA2_TOP(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
+			CK_TOP_SYSAXI, 5),
+	GATE_INFRA2_INFRA(CK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
+			  CK_INFRA_MUX_UART0_SEL, 3),
+	GATE_INFRA2_INFRA(CK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
+			  CK_INFRA_MUX_UART1_SEL, 4),
+	GATE_INFRA2_INFRA(CK_INFRA_52M_UART2_CK, "infra_f_52m_uart2",
+			  CK_INFRA_MUX_UART2_SEL, 5),
+	GATE_INFRA2_TOP(CK_INFRA_NFI, "infra_f_fnfi", CK_TOP_NFI1X, 9),
+	GATE_INFRA2_TOP(CK_INFRA_SPINFI, "infra_f_fspinfi", CK_TOP_SPINFI_BCK, 10),
+	GATE_INFRA2_TOP(CK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck",
+			CK_TOP_SYSAXI, 11),
+	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI0, "infra_hf_104m_spi0",
+			  CK_INFRA_MUX_SPI0_SEL, 12),
+	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI1, "infra_hf_104m_spi1",
+			  CK_INFRA_MUX_SPI1_SEL, 13),
+	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck",
+			  CK_INFRA_MUX_SPI2_SEL, 14),
+	GATE_INFRA2_TOP(CK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck",
+			CK_TOP_SYSAXI, 15),
+	GATE_INFRA2_TOP(CK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck",
+			CK_TOP_SYSAXI, 16),
+	GATE_INFRA2_TOP(CK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck",
+			CK_TOP_SYSAXI, 17),
+	GATE_INFRA2_TOP(CK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
+			CK_TOP_SYSAXI, 18),
+	GATE_INFRA2_TOP(CK_INFRA_RTC, "infra_f_frtc", CK_TOP_CB_RTC_32K, 19),
+	GATE_INFRA2_TOP(CK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
+			CK_TOP_INFRA_F26M, 20),
+	GATE_INFRA2_INFRA(CK_INFRA_RC_ADC, "infra_f_frc_adc", CK_INFRA_26M_ADC_BCK,
+			  21),
+	GATE_INFRA2_TOP(CK_INFRA_MSDC400, "infra_f_fmsdc400", CK_TOP_EMMC_400M,
+			22),
+	GATE_INFRA2_TOP(CK_INFRA_MSDC2_HCK, "infra_f_fmsdc2_hck",
+			CK_TOP_EMMC_250M, 23),
+	GATE_INFRA2_TOP(CK_INFRA_133M_MSDC_0_HCK, "infra_hf_133m_msdc_0_hck",
+			CK_TOP_SYSAXI, 24),
+	GATE_INFRA2_TOP(CK_INFRA_66M_MSDC_0_HCK, "infra_66m_msdc_0_hck",
+			CK_TOP_SYSAXI, 25),
+	GATE_INFRA2_TOP(CK_INFRA_133M_CPUM_BCK, "infra_hf_133m_cpum_bck",
+			CK_TOP_SYSAXI, 26),
+	GATE_INFRA2_TOP(CK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CK_TOP_NFI1X,
+			27),
+	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_MCK_CK_P1, "infra_hf_i2c_x16w_mck_ck_p1",
+			CK_TOP_SYSAXI, 29),
+	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_PCK_CK_P1, "infra_hf_i2c_x16w_pck_ck_p1",
+			CK_TOP_SYSAXI, 31),
+	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK, "infra_133m_usb_hck",
+			CK_TOP_SYSAXI, 0),
+	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK_CK_P1, "infra_133m_usb_hck_ck_p1",
+			CK_TOP_SYSAXI, 1),
+	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK, "infra_66m_usb_hck",
+			CK_TOP_SYSAXI, 2),
+	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK_CK_P1, "infra_66m_usb_hck_ck_p1",
+			CK_TOP_SYSAXI, 3),
+	GATE_INFRA3_TOP(CK_INFRA_USB_SYS, "infra_usb_sys", CK_TOP_USB_SYS, 4),
+	GATE_INFRA3_TOP(CK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
+			CK_TOP_USB_SYS_P1, 5),
+	GATE_INFRA3_TOP(CK_INFRA_USB_REF, "infra_usb_ref", CK_TOP_USB_REF, 6),
+	GATE_INFRA3_TOP(CK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CK_TOP_USB_CK_P1,
+			7),
+	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
+			CK_TOP_USB_FRMCNT, 8),
+	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
+			CK_TOP_USB_FRMCNT_P1, 9),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_XTAL,
+			 10),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
+			 CLK_XTAL, 11),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_UTMI, "infra_usb_utmi", CLK_XTAL,
+			 12),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
+			 CLK_XTAL, 13),
+	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI, "infra_usb_xhci", CK_TOP_USB_XHCI,
+			14),
+	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
+			CK_TOP_USB_XHCI_P1, 15),
+	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P0, "infra_pcie_gfmux_tl_ck_p0",
+			  CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
+	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P1, "infra_pcie_gfmux_tl_ck_p1",
+			  CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL, 21),
+	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P2, "infra_pcie_gfmux_tl_ck_p2",
+			  CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL, 22),
+	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P3, "infra_pcie_gfmux_tl_ck_p3",
+			  CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL, 23),
+	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
+			 CLK_XTAL, 24),
+	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
+			 CLK_XTAL, 25),
+	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
+			 CLK_XTAL, 26),
+	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
+			 CLK_XTAL, 27),
+	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
+			CK_TOP_SYSAXI, 28),
+	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
+			CK_TOP_SYSAXI, 29),
+	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P2, "infra_133m_pcie_ck_p2",
+			CK_TOP_SYSAXI, 30),
+	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
+			CK_TOP_SYSAXI, 31),
 };
 
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
@@ -823,9 +767,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
-	.fdivs_offs = CK_INFRA_CK_F26M,
 	.muxes_offs = CK_INFRA_MUX_UART0_SEL,
-	.fdivs = infracfg_mtk_fixed_factor,
 	.muxes = infracfg_mtk_mux,
 	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 5c643b979b5..61691d58dda 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -8,77 +8,28 @@
 #ifndef _DT_BINDINGS_CLK_MT7988_H
 #define _DT_BINDINGS_CLK_MT7988_H
 
-/* INFRACFG */
-/* mtk_fixed_factor */
-#define CK_INFRA_CK_F26M	  0
-#define CK_INFRA_PWM_O		  1
-#define CK_INFRA_PCIE_OCC_P0	  2
-#define CK_INFRA_PCIE_OCC_P1	  3
-#define CK_INFRA_PCIE_OCC_P2	  4
-#define CK_INFRA_PCIE_OCC_P3	  5
-#define CK_INFRA_133M_HCK	  6
-#define CK_INFRA_133M_PHCK	  7
-#define CK_INFRA_66M_PHCK	  8
-#define CK_INFRA_FAUD_L_O	  9
-#define CK_INFRA_FAUD_AUD_O	  10
-#define CK_INFRA_FAUD_EG2_O	  11
-#define CK_INFRA_I2C_O		  12
-#define CK_INFRA_UART_O0	  13
-#define CK_INFRA_UART_O1	  14
-#define CK_INFRA_UART_O2	  15
-#define CK_INFRA_NFI_O		  16
-#define CK_INFRA_SPINFI_O	  17
-#define CK_INFRA_SPI0_O		  18
-#define CK_INFRA_SPI1_O		  19
-#define CK_INFRA_LB_MUX_FRTC	  20
-#define CK_INFRA_FRTC		  21
-#define CK_INFRA_FMSDC400_O	  22
-#define CK_INFRA_FMSDC2_HCK_OCC	  23
-#define CK_INFRA_PERI_133M	  24
-#define CK_INFRA_USB_O		  25
-#define CK_INFRA_USB_O_P1	  26
-#define CK_INFRA_USB_FRMCNT_O	  27
-#define CK_INFRA_USB_FRMCNT_O_P1  28
-#define CK_INFRA_USB_XHCI_O	  29
-#define CK_INFRA_USB_XHCI_O_P1	  30
-#define CK_INFRA_USB_PIPE_O	  31
-#define CK_INFRA_USB_PIPE_O_P1	  32
-#define CK_INFRA_USB_UTMI_O	  33
-#define CK_INFRA_USB_UTMI_O_P1	  34
-#define CK_INFRA_PCIE_PIPE_OCC_P0 35
-#define CK_INFRA_PCIE_PIPE_OCC_P1 36
-#define CK_INFRA_PCIE_PIPE_OCC_P2 37
-#define CK_INFRA_PCIE_PIPE_OCC_P3 38
-#define CK_INFRA_F26M_O0	  39
-#define CK_INFRA_F26M_O1	  40
-#define CK_INFRA_133M_MCK	  41
-#define CK_INFRA_66M_MCK	  42
-#define CK_INFRA_PERI_66M_O	  43
-#define CK_INFRA_USB_SYS_O	  44
-#define CK_INFRA_USB_SYS_O_P1	  45
-
 /* INFRACFG_AO */
 #define GATE_OFFSET 65
 /* mtk_mux */
-#define CK_INFRA_MUX_UART0_SEL		46 /* Linux CLK ID (0) */
-#define CK_INFRA_MUX_UART1_SEL		47 /* Linux CLK ID (1) */
-#define CK_INFRA_MUX_UART2_SEL		48 /* Linux CLK ID (2) */
-#define CK_INFRA_MUX_SPI0_SEL		49 /* Linux CLK ID (3) */
-#define CK_INFRA_MUX_SPI1_SEL		50 /* Linux CLK ID (4) */
-#define CK_INFRA_MUX_SPI2_SEL		51 /* Linux CLK ID (5) */
-#define CK_INFRA_PWM_SEL		52 /* Linux CLK ID (6) */
-#define CK_INFRA_PWM_CK1_SEL		53 /* Linux CLK ID (7) */
-#define CK_INFRA_PWM_CK2_SEL		54 /* Linux CLK ID (8) */
-#define CK_INFRA_PWM_CK3_SEL		55 /* Linux CLK ID (9) */
-#define CK_INFRA_PWM_CK4_SEL		56 /* Linux CLK ID (10) */
-#define CK_INFRA_PWM_CK5_SEL		57 /* Linux CLK ID (11) */
-#define CK_INFRA_PWM_CK6_SEL		58 /* Linux CLK ID (12) */
-#define CK_INFRA_PWM_CK7_SEL		59 /* Linux CLK ID (13) */
-#define CK_INFRA_PWM_CK8_SEL		60 /* Linux CLK ID (14) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL 61 /* Linux CLK ID (15) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL 62 /* Linux CLK ID (16) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL 63 /* Linux CLK ID (17) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL 64 /* Linux CLK ID (18) */
+#define CK_INFRA_MUX_UART0_SEL		0 /* Linux CLK ID (0) */
+#define CK_INFRA_MUX_UART1_SEL		1 /* Linux CLK ID (1) */
+#define CK_INFRA_MUX_UART2_SEL		2 /* Linux CLK ID (2) */
+#define CK_INFRA_MUX_SPI0_SEL		3 /* Linux CLK ID (3) */
+#define CK_INFRA_MUX_SPI1_SEL		4 /* Linux CLK ID (4) */
+#define CK_INFRA_MUX_SPI2_SEL		5 /* Linux CLK ID (5) */
+#define CK_INFRA_PWM_SEL		6 /* Linux CLK ID (6) */
+#define CK_INFRA_PWM_CK1_SEL		7 /* Linux CLK ID (7) */
+#define CK_INFRA_PWM_CK2_SEL		8 /* Linux CLK ID (8) */
+#define CK_INFRA_PWM_CK3_SEL		9 /* Linux CLK ID (9) */
+#define CK_INFRA_PWM_CK4_SEL		10 /* Linux CLK ID (10) */
+#define CK_INFRA_PWM_CK5_SEL		11 /* Linux CLK ID (11) */
+#define CK_INFRA_PWM_CK6_SEL		12 /* Linux CLK ID (12) */
+#define CK_INFRA_PWM_CK7_SEL		13 /* Linux CLK ID (13) */
+#define CK_INFRA_PWM_CK8_SEL		14 /* Linux CLK ID (14) */
+#define CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL 15 /* Linux CLK ID (15) */
+#define CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL 16 /* Linux CLK ID (16) */
+#define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL 17 /* Linux CLK ID (17) */
+#define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL 18 /* Linux CLK ID (18) */
 /* mtk_gate */
 #define CK_INFRA_PCIE_PERI_26M_CK_P0 (65 - GATE_OFFSET) /* Linux CLK ID (99) */
 #define CK_INFRA_PCIE_PERI_26M_CK_P1                                           \
-- 
2.45.2

