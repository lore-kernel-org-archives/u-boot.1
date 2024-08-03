Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B83C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE72288C69;
	Sat,  3 Aug 2024 13:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUwRLDy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC53088C3C; Sat,  3 Aug 2024 13:10:39 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28388827D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367963ea053so5786694f8f.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683437; x=1723288237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AFr/3LxC2I7g+Zquo0V3k3bt5epp2tUOL2ahELuXTPs=;
 b=hUwRLDy8mUTm4rWLB5cp3untRlZwUM0iDhJNqBYfj/zNltBfPuAGzRQuHiYm8SHgqx
 CXuzaSiLrlRyn/Z++tUVe412zNMjhTJEOnZWzTBW7INFoxLKZHNEbG2VCLmrXCwyK3TH
 KddrFSvIkfTuYA6O62WIuS8UII78eR1QHS+t8puHm19UVxMbwtxBpZN5Y8HeZJwIsEkQ
 9o+rtd3w8so6wnBsc4OWFW4VqtfK/s7uk3B+bbQVyetK0yu5zSqbbWuYFxCnq2yX5N0R
 TjEG46tQeDgOvYq3W6UpH1uIeIeFa2dU1dIt0u815T5BF7tkah8dkSkbs9Buu9WF3oPO
 Pgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683437; x=1723288237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFr/3LxC2I7g+Zquo0V3k3bt5epp2tUOL2ahELuXTPs=;
 b=iV3ZdIa6mcGHvPQxymrYRJtO2kvsu7LWHPpK9aw5RR9UR36x5qaTY3ftkaMNAvb1jL
 3xOwdSSqN7Xefilah/NWHkNBfTpNcXBOpPN0o/0Z+xErUdvzgL2cOEXYAcxHdbMiAFTy
 HG+SCx91hGduiwV80L0GwDKyw4KnWKJxwcHamvtRkzsLjChIJnKHxmGTjSiFVtMKv9Kp
 2yPPlGojn2LE/zasjhnB1tLC9iP3W4fzcML9VMEw3d/Gkh9gOHSWVSR2y62JtL6FzIgt
 0iUaDqIDwZNzKQPXuzhP7Tg/dPwKdUNbinO3TvjBs9LyfiYBC6HoD4h3xcstOcmayjaR
 Wzuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPWWiVUJabutQFkIcSaxHl352Ya208OKsdsRdKrdQd76ZuTd/GW+8XK+4O1V0bDZFuf5ynDpL8IRZKp2JYUUXin4gKQ==
X-Gm-Message-State: AOJu0YwQOq0lYOG2g+Eo+eJ0zkWlT6XF2pEgr+rzJgXYECQP1a3EHze0
 BKs0aG0L5nws1qoJDB7JoP1C4BhvhpgugffKFwvHTChL2a8N3JJ/
X-Google-Smtp-Source: AGHT+IEtlKxv4y6J6PfckYNKpkh+bopfXfDA3308Ob29DlM1GSVg72SeiILU6hm0sg/gSNwpXKmtLg==
X-Received: by 2002:a05:6000:4029:b0:367:f059:4c55 with SMTP id
 ffacd0b85a97d-36bbc117307mr6791673f8f.26.1722683437090; 
 Sat, 03 Aug 2024 04:10:37 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 02/15] clk: mediatek: mt7986: rename CB_CKSQ_40M to TOP_XTAL
Date: Sat,  3 Aug 2024 10:40:35 +0200
Message-ID: <20240803084050.449-3-ansuelsmth@gmail.com>
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

Upstream kernel linux clock include use TOP_XTAL instead of CB_CKSQ_40M.
Rename this clock to the upstream kernel in preparation for support of
OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi               |  2 +-
 drivers/clk/mediatek/clk-mt7986.c      | 72 +++++++++++++-------------
 include/dt-bindings/clock/mt7986-clk.h |  4 +-
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index 30b5a899701..276f82f2065 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -178,7 +178,7 @@
 		clocks = <&infracfg_ao CK_INFRA_UART0_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_UART0_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
+		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&infracfg CK_INFRA_UART>;
 		mediatek,force-highspeed;
 		status = "disabled";
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 1e8c3278346..67ed1768046 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -41,7 +41,7 @@ static const struct mtk_fixed_clk fixed_pll_clks[] = {
 
 /* TOPCKGEN FIXED CLK */
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CK_TOP_CB_CKSQ_40M, CLK_XTAL, 40000000),
+	FIXED_CLK(CK_TOP_XTAL, CLK_XTAL, 40000000),
 };
 
 /* TOPCKGEN FIXED DIV */
@@ -77,18 +77,18 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	PLL_FACTOR(CK_TOP_WEDMCU_D5_D2, "wedmcu_d5_d2", CK_APMIXED_WEDMCUPLL, 1,
 		   10),
 	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
-	TOP_FACTOR(CK_TOP_CB_CKSQ_40M_D2, "cb_cksq_40m_d2", CK_TOP_CB_CKSQ_40M,
+	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL,
 		   1, 2),
-	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_CB_CKSQ_40M, 1,
+	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
-	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_CB_CKSQ_40M, 1,
+	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
 	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_CB_CKSQ_40M, 1,
+	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_XTAL, 1,
 		   1),
-	TOP_FACTOR(CK_TOP_USB_TX250M, "usb_tx250m", CK_TOP_CB_CKSQ_40M, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_LN0_CK, "usb_ln0", CK_TOP_CB_CKSQ_40M, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_CDR_CK, "usb_cdr", CK_TOP_CB_CKSQ_40M, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_TX250M, "usb_tx250m", CK_TOP_XTAL, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_LN0_CK, "usb_ln0", CK_TOP_XTAL, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_CDR_CK, "usb_cdr", CK_TOP_XTAL, 1, 1),
 	TOP_FACTOR(CK_TOP_SPINFI_BCK, "spinfi_bck", CK_TOP_SPINFI_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_I2C_BCK, "i2c_bck", CK_TOP_I2C_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_PEXTP_TL, "pextp_tl", CK_TOP_PEXTP_TL_SEL, 1, 1),
@@ -114,91 +114,91 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int nfi1x_parents[] = { CK_TOP_CB_CKSQ_40M,  CK_TOP_CB_MM_D8,
+static const int nfi1x_parents[] = { CK_TOP_XTAL,  CK_TOP_CB_MM_D8,
 				     CK_TOP_NET1_D8_D2,   CK_TOP_NET2_D3_D2,
 				     CK_TOP_CB_M_D4,      CK_TOP_MM_D8_D2,
 				     CK_TOP_WEDMCU_D5_D2, CK_TOP_CB_M_D8 };
 
 static const int spinfi_parents[] = {
-	CK_TOP_CB_CKSQ_40M_D2, CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D4,
+	CK_TOP_XTAL_D2, CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
 	CK_TOP_CB_M_D4,	CK_TOP_MM_D8_D2,    CK_TOP_WEDMCU_D5_D2,
 	CK_TOP_MM_D3_D8,       CK_TOP_CB_M_D8
 };
 
-static const int spi_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D2,
+static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
 				   CK_TOP_CB_MM_D8,    CK_TOP_NET1_D8_D2,
 				   CK_TOP_NET2_D3_D2,  CK_TOP_NET1_D5_D4,
 				   CK_TOP_CB_M_D4,     CK_TOP_WEDMCU_D5_D2 };
 
-static const int uart_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D8,
+static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D8,
 				    CK_TOP_M_D8_D2 };
 
-static const int pwm_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D8_D2,
+static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
 				   CK_TOP_NET1_D5_D4, CK_TOP_CB_M_D4 };
 
-static const int i2c_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D4,
+static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
 				   CK_TOP_CB_M_D4, CK_TOP_NET1_D8_D4 };
 
-static const int pextp_tl_ck_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_NET1_D5_D4, CK_TOP_NET2_D4_D2,
 					   CK_TOP_CB_RTC_32K };
 
-static const int emmc_250m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int emmc_250m_parents[] = { CK_TOP_XTAL,
 					 CK_TOP_NET1_D5_D2 };
 
-static const int emmc_416m_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_416M };
+static const int emmc_416m_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_416M };
 
-static const int f_26m_adc_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_M_D8_D2 };
+static const int f_26m_adc_parents[] = { CK_TOP_XTAL, CK_TOP_M_D8_D2 };
 
-static const int dramc_md32_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D2 };
+static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2 };
 
-static const int sysaxi_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D8_D2,
+static const int sysaxi_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
 				      CK_TOP_CB_NET2_D4 };
 
-static const int sysapb_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_M_D3_D2,
+static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_M_D3_D2,
 				      CK_TOP_NET2_D4_D2 };
 
-static const int arm_db_main_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int arm_db_main_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_NET2_D3_D2 };
 
-static const int arm_db_jtsel_parents[] = { -1, CK_TOP_CB_CKSQ_40M };
+static const int arm_db_jtsel_parents[] = { -1, CK_TOP_XTAL };
 
-static const int netsys_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_MM_D4 };
+static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_MM_D4 };
 
-static const int netsys_500m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_500m_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_CB_NET1_D5 };
 
-static const int netsys_mcu_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_mcu_parents[] = { CK_TOP_XTAL,
 					  CK_TOP_CB_WEDMCU_760M,
 					  CK_TOP_CB_MM_D2, CK_TOP_CB_NET1_D4,
 					  CK_TOP_CB_NET1_D5 };
 
-static const int netsys_2x_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_2x_parents[] = { CK_TOP_XTAL,
 					 CK_TOP_CB_NET2_800M,
 					 CK_TOP_CB_WEDMCU_760M,
 					 CK_TOP_CB_MM_D2 };
 
-static const int sgm_325m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int sgm_325m_parents[] = { CK_TOP_XTAL,
 					CK_TOP_CB_SGM_325M };
 
-static const int sgm_reg_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D8_D4 };
+static const int sgm_reg_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D4 };
 
-static const int a1sys_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_APLL2_D4 };
+static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4 };
 
-static const int conn_mcusys_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int conn_mcusys_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_CB_MM_D2 };
 
-static const int eip_b_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NET2_800M };
+static const int eip_b_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2_800M };
 
-static const int aud_l_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_APLL2_196M,
+static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
 				     CK_TOP_M_D8_D2 };
 
-static const int a_tuner_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_APLL2_D4,
+static const int a_tuner_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4,
 				       CK_TOP_M_D8_D2 };
 
-static const int u2u3_sys_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D4 };
+static const int u2u3_sys_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4 };
 
-static const int da_u2_refsel_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int da_u2_refsel_parents[] = { CK_TOP_XTAL,
 					    CK_TOP_CB_U2_PHYD_CK };
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 820f8631831..30720f9fb42 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -51,7 +51,7 @@
 
 /* TOPCKGEN */
 
-#define CK_TOP_CB_CKSQ_40M		0
+#define CK_TOP_XTAL			0
 #define CK_TOP_CB_M_416M		1
 #define CK_TOP_CB_M_D2			2
 #define CK_TOP_CB_M_D4			3
@@ -79,7 +79,7 @@
 #define CK_TOP_CB_WEDMCU_760M		25
 #define CK_TOP_WEDMCU_D5_D2		26
 #define CK_TOP_CB_SGM_325M		27
-#define CK_TOP_CB_CKSQ_40M_D2		28
+#define CK_TOP_XTAL_D2			28
 #define CK_TOP_CB_RTC_32K		29
 #define CK_TOP_CB_RTC_32P7K		30
 #define CK_TOP_NFI1X			31
-- 
2.45.2

