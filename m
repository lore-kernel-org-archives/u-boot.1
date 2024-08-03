Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201FC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488FE88967;
	Sat,  3 Aug 2024 10:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9ZkL62P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B39C88B43; Sat,  3 Aug 2024 10:33:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E1988BD6
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so22214445e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674000; x=1723278800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mpSj42E/OVsBB0B8F9osN+Rz2e1Hz6qah9C3nF2cpQY=;
 b=L9ZkL62PG/AWuj48YlD6NtkPq9twv1QwUvnsSA+vOgTDqFHN69CEEqdWArqa9f3al2
 r+zM66nBQo2wUQOnYq0U9FCOqBJZaPwLCqBS4EGTcaQMLowZ+nZ74XXvIGtdvRV3XrwX
 7x1NkXzWnTEbtmyfx94LO3bV3vWQDOESFUGQx8f284tMfF6a/hd0oR0FDE7c++hMtH4D
 jmD/IVAjxu+yxMdMt83ce9RIvOZSQWF+mocr939SlcGs4hgJ/7zLX+vElfEUYi7p45kL
 73q1JDPVnXFPJMnyZtf2U7TjOYJPqfr7bXUkX011Bx3cKgRcOkhlCPtbBANEeX5UJ9ke
 K4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674000; x=1723278800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpSj42E/OVsBB0B8F9osN+Rz2e1Hz6qah9C3nF2cpQY=;
 b=PWnw6SqqX6QBzmUK9KEco3pHrcaDbByvwJBuP1RZrQOL0NTLNOrMTcTdqGi4sKfDwg
 DBzWxyR/80Rw52oVX8wzhEyqniDLQNS52B8LpGtKYCtmyC6FOXjmKHh3rtxJnezwD6gC
 nVcLikpwh7bsqph5ADOhEgN0WQQ630mEl2oNHiH+4d4+aNWgCw4wO3BdQ9NiCyy++FN0
 gwenyDWFdon67JKrs0ZP4DE/dVQJupiR3V/iFZ1dPxf7xHUVPgQBQiwUznVnBlrZ47hY
 U8im/7bWIdwGrm+u22T/kauqTaDr9NbiPmPYh6BJfep6orQikOrcP/2bNY70kzxrN3DA
 YY3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV3BmLvCK7EXJQpufDYKc9CBxFIN8JbQBXkWBxi3ozaboMp9zK+L4buCnV1lCNqvb82ZK6ioe082uQ3NqiO0egWM65SA==
X-Gm-Message-State: AOJu0YwzLoCbD7kh9Xf2TMYyK0jVjWfydha73CWfd9G7hFNF38m85jX3
 eocmTDZkmxSrM/JpK0dJ9Fzyd8qipEipzcomfFf1/YFz6/ltOIne
X-Google-Smtp-Source: AGHT+IGIDR48fGbCKB/TYZFu0idUfX3pS/N0sXLxMc/KjDfU/Es74eYQYVSHOp8MypZFJ5BsvU4fRA==
X-Received: by 2002:a05:600c:3b21:b0:428:6ac:426e with SMTP id
 5b1f17b1804b1-428e4713fe7mr59217545e9.5.1722674000160; 
 Sat, 03 Aug 2024 01:33:20 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 01/13] clk: mediatek: mt7988: rename CB_CKSQ_40M to TOP_XTAL
Date: Sat,  3 Aug 2024 10:32:50 +0200
Message-ID: <20240803083305.30697-2-ansuelsmth@gmail.com>
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

Upstream kernel linux clock include use TOP_XTAL instead of CB_CKSQ_40M.
Rename this clock to the upstream kernel in preparation for support of
OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7988.dtsi               |   6 +-
 drivers/clk/mediatek/clk-mt7988.c      | 100 ++++++++++++-------------
 include/dt-bindings/clock/mt7988-clk.h |   4 +-
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 5c0c5bcfd6e..2605e60c993 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -265,7 +265,7 @@
 		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART0_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART0_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
+		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&infracfg_ao CK_INFRA_UART_O0>;
 		status = "disabled";
 	};
@@ -277,7 +277,7 @@
 		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART1_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART1_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
+		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&infracfg_ao CK_INFRA_UART_O1>;
 		status = "disabled";
 	};
@@ -289,7 +289,7 @@
 		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART2_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
 				  <&infracfg_ao CK_INFRA_MUX_UART2_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
+		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&infracfg_ao CK_INFRA_UART_O2>;
 		status = "disabled";
 	};
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 32b04511781..e7ef58c4fb9 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -51,7 +51,7 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
-	XTAL_FACTOR(CK_TOP_CB_CKSQ_40M, "cb_cksq_40m", CLK_XTAL, 1, 1),
+	XTAL_FACTOR(CK_TOP_XTAL, "xtal", CLK_XTAL, 1, 1),
 	PLL_FACTOR(CK_TOP_CB_M_416M, "cb_m_416m", CK_APMIXED_MPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_CB_M_D2, "cb_m_d2", CK_APMIXED_MPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_M_D3_D2, "m_d3_d2", CK_APMIXED_MPLL, 1, 2),
@@ -92,10 +92,10 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 		   CK_APMIXED_NETSYSPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_CB_MSDC_400M, "cb_msdc_400m", CK_APMIXED_MSDCPLL, 1,
 		   1),
-	TOP_FACTOR(CK_TOP_CKSQ_40M_D2, "cksq_40m_d2", CK_TOP_CB_CKSQ_40M, 1, 2),
-	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_CB_CKSQ_40M, 1,
+	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL, 1, 2),
+	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
-	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_CB_CKSQ_40M, 1,
+	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
 	TOP_FACTOR(CK_TOP_INFRA_F32K, "csw_infra_f32k", CK_TOP_CB_RTC_32P7K, 1,
 		   1),
@@ -135,125 +135,125 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int netsys_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NET2_D2,
+static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2_D2,
 				      CK_TOP_CB_MM_D2 };
 
-static const int netsys_500m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_500m_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_CB_NET1_D5,
 					   CK_TOP_NET1_D5_D2 };
 
-static const int netsys_2x_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_2x_parents[] = { CK_TOP_XTAL,
 					 CK_TOP_CB_NET2_800M,
 					 CK_TOP_CB_MM_720M };
 
-static const int netsys_gsw_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NET1_D4,
+static const int netsys_gsw_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET1_D4,
 					  CK_TOP_CB_NET1_D5 };
 
-static const int eth_gmii_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D4 };
+static const int eth_gmii_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4 };
 
 static const int netsys_mcu_parents[] = {
-	CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NET2_800M, CK_TOP_CB_MM_720M,
+	CK_TOP_XTAL, CK_TOP_CB_NET2_800M, CK_TOP_CB_MM_720M,
 	CK_TOP_CB_NET1_D4,  CK_TOP_CB_NET1_D5,   CK_TOP_CB_M_416M
 };
 
 static const int eip197_parents[] = {
-	CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NETSYS_850M, CK_TOP_CB_NET2_800M,
+	CK_TOP_XTAL, CK_TOP_CB_NETSYS_850M, CK_TOP_CB_NET2_800M,
 	CK_TOP_CB_MM_720M,  CK_TOP_CB_NET1_D4,     CK_TOP_CB_NET1_D5
 };
 
-static const int axi_infra_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int axi_infra_parents[] = { CK_TOP_XTAL,
 					 CK_TOP_NET1_D8_D2 };
 
-static const int uart_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D8,
+static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D8,
 				    CK_TOP_M_D8_D2 };
 
-static const int emmc_250m_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D2,
+static const int emmc_250m_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D2,
 					 CK_TOP_CB_MM_D4 };
 
 static const int emmc_400m_parents[] = {
-	CK_TOP_CB_CKSQ_40M, CK_TOP_CB_MSDC_400M, CK_TOP_CB_MM_D2,
+	CK_TOP_XTAL, CK_TOP_CB_MSDC_400M, CK_TOP_CB_MM_D2,
 	CK_TOP_CB_M_D2,     CK_TOP_CB_MM_D4,     CK_TOP_NET1_D8_D2
 };
 
-static const int spi_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D2,
+static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
 				   CK_TOP_CB_MM_D4,    CK_TOP_NET1_D8_D2,
 				   CK_TOP_CB_NET2_D6,  CK_TOP_NET1_D5_D4,
 				   CK_TOP_CB_M_D4,     CK_TOP_NET1_D8_D4 };
 
-static const int nfi1x_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_MM_D4,
+static const int nfi1x_parents[] = { CK_TOP_XTAL, CK_TOP_CB_MM_D4,
 				     CK_TOP_NET1_D8_D2,  CK_TOP_CB_NET2_D6,
 				     CK_TOP_CB_M_D4,     CK_TOP_CB_MM_D8,
 				     CK_TOP_NET1_D8_D4,  CK_TOP_CB_M_D8 };
 
-static const int spinfi_parents[] = { CK_TOP_CKSQ_40M_D2, CK_TOP_CB_CKSQ_40M,
+static const int spinfi_parents[] = { CK_TOP_XTAL_D2, CK_TOP_XTAL,
 				      CK_TOP_NET1_D5_D4,  CK_TOP_CB_M_D4,
 				      CK_TOP_CB_MM_D8,    CK_TOP_NET1_D8_D4,
 				      CK_TOP_MM_D6_D2,    CK_TOP_CB_M_D8 };
 
-static const int pwm_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D8_D2,
+static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
 				   CK_TOP_NET1_D5_D4,  CK_TOP_CB_M_D4,
 				   CK_TOP_M_D8_D2,     CK_TOP_CB_RTC_32K };
 
-static const int i2c_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_NET1_D5_D4,
+static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
 				   CK_TOP_CB_M_D4, CK_TOP_NET1_D8_D4 };
 
-static const int pcie_mbist_250m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int pcie_mbist_250m_parents[] = { CK_TOP_XTAL,
 					       CK_TOP_NET1_D5_D2 };
 
-static const int pextp_tl_ck_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
 					   CK_TOP_CB_NET2_D6, CK_TOP_CB_MM_D8,
 					   CK_TOP_M_D8_D2, CK_TOP_CB_RTC_32K };
 
-static const int usb_frmcnt_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int usb_frmcnt_parents[] = { CK_TOP_XTAL,
 					  CK_TOP_CB_MM_D3_D5 };
 
-static const int aud_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_APLL2_196M };
+static const int aud_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M };
 
-static const int a1sys_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_APLL2_D4 };
+static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_D4 };
 
-static const int aud_l_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_APLL2_196M,
+static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
 				     CK_TOP_M_D8_D2 };
 
-static const int sspxtp_parents[] = { CK_TOP_CKSQ_40M_D2, CK_TOP_M_D8_D2 };
+static const int sspxtp_parents[] = { CK_TOP_XTAL_D2, CK_TOP_M_D8_D2 };
 
-static const int usxgmii_sbus_0_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int usxgmii_sbus_0_parents[] = { CK_TOP_XTAL,
 					      CK_TOP_NET1_D8_D4 };
 
-static const int sgm_0_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_SGM_325M };
+static const int sgm_0_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M };
 
-static const int sysapb_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_M_D3_D2 };
+static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_M_D3_D2 };
 
-static const int eth_refck_50m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int eth_refck_50m_parents[] = { CK_TOP_XTAL,
 					     CK_TOP_NET2_D4_D4 };
 
-static const int eth_sys_200m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int eth_sys_200m_parents[] = { CK_TOP_XTAL,
 					    CK_TOP_CB_NET2_D4 };
 
-static const int eth_xgmii_parents[] = { CK_TOP_CKSQ_40M_D2, CK_TOP_NET1_D8_D8,
+static const int eth_xgmii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET1_D8_D8,
 					 CK_TOP_NET1_D8_D16 };
 
-static const int bus_tops_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_NET1_D5,
+static const int bus_tops_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET1_D5,
 					CK_TOP_CB_NET2_D2 };
 
-static const int npu_tops_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int npu_tops_parents[] = { CK_TOP_XTAL,
 					CK_TOP_CB_NET2_800M };
 
-static const int dramc_md32_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_M_D2,
+static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
 					  CK_TOP_CB_WEDMCU_208M };
 
-static const int da_xtp_glb_p0_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int da_xtp_glb_p0_parents[] = { CK_TOP_XTAL,
 					     CK_TOP_CB_NET2_D8 };
 
-static const int mcusys_backup_625m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int mcusys_backup_625m_parents[] = { CK_TOP_XTAL,
 						  CK_TOP_CB_NET1_D4 };
 
-static const int macsec_parents[] = { CK_TOP_CB_CKSQ_40M, CK_TOP_CB_SGM_325M,
+static const int macsec_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M,
 				      CK_TOP_CB_NET1_D8 };
 
-static const int netsys_tops_400m_parents[] = { CK_TOP_CB_CKSQ_40M,
+static const int netsys_tops_400m_parents[] = { CK_TOP_XTAL,
 						CK_TOP_CB_NET2_D2 };
 
-static const int eth_mii_parents[] = { CK_TOP_CKSQ_40M_D2, CK_TOP_NET2_D4_D8 };
+static const int eth_mii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET2_D4_D8 };
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -814,7 +814,7 @@ static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
-	.fdivs_offs = CK_TOP_CB_CKSQ_40M,
+	.fdivs_offs = CK_TOP_XTAL,
 	.muxes_offs = CK_TOP_NETSYS_SEL,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
@@ -991,10 +991,10 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
 	}
 
 static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
-	/* connect to fake clock, so use CK_TOP_CB_CKSQ_40M as the clock parent */
-	GATE_SGMII0(CK_SGM0_TX_EN, "sgm0_tx_en", CK_TOP_CB_CKSQ_40M, 2),
-	/* connect to fake clock, so use CK_TOP_CB_CKSQ_40M as the clock parent */
-	GATE_SGMII0(CK_SGM0_RX_EN, "sgm0_rx_en", CK_TOP_CB_CKSQ_40M, 3),
+	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
+	GATE_SGMII0(CK_SGM0_TX_EN, "sgm0_tx_en", CK_TOP_XTAL, 2),
+	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
+	GATE_SGMII0(CK_SGM0_RX_EN, "sgm0_rx_en", CK_TOP_XTAL, 3),
 };
 
 static int mt7988_sgmiisys_0_probe(struct udevice *dev)
@@ -1035,10 +1035,10 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
 	}
 
 static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
-	/* connect to fake clock, so use CK_TOP_CB_CKSQ_40M as the clock parent */
-	GATE_SGMII1(CK_SGM1_TX_EN, "sgm1_tx_en", CK_TOP_CB_CKSQ_40M, 2),
-	/* connect to fake clock, so use CK_TOP_CB_CKSQ_40M as the clock parent */
-	GATE_SGMII1(CK_SGM1_RX_EN, "sgm1_rx_en", CK_TOP_CB_CKSQ_40M, 3),
+	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
+	GATE_SGMII1(CK_SGM1_TX_EN, "sgm1_tx_en", CK_TOP_XTAL, 2),
+	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
+	GATE_SGMII1(CK_SGM1_RX_EN, "sgm1_rx_en", CK_TOP_XTAL, 3),
 };
 
 static int mt7988_sgmiisys_1_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 5c21bf63119..88a5cf45ccb 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -170,7 +170,7 @@
 
 /* TOPCKGEN */
 /* mtk_fixed_factor */
-#define CK_TOP_CB_CKSQ_40M    0 /* Linux CLK ID (74) */
+#define CK_TOP_XTAL           0 /* Linux CLK ID (74) */
 #define CK_TOP_CB_M_416M      1 /* Linux CLK ID (75) */
 #define CK_TOP_CB_M_D2	      2 /* Linux CLK ID (76) */
 #define CK_TOP_M_D3_D2	      3 /* Linux CLK ID (77) */
@@ -205,7 +205,7 @@
 #define CK_TOP_CB_SGM_325M    32 /* Linux CLK ID (106) */
 #define CK_TOP_CB_NETSYS_850M 33 /* Linux CLK ID (107) */
 #define CK_TOP_CB_MSDC_400M   34 /* Linux CLK ID (108) */
-#define CK_TOP_CKSQ_40M_D2    35 /* Linux CLK ID (109) */
+#define CK_TOP_XTAL_D2    35 /* Linux CLK ID (109) */
 #define CK_TOP_CB_RTC_32K     36 /* Linux CLK ID (110) */
 #define CK_TOP_CB_RTC_32P7K   37 /* Linux CLK ID (111) */
 #define CK_TOP_INFRA_F32K     38 /* Linux CLK ID (112) */
-- 
2.45.2

