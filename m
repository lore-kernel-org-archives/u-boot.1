Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E36C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE8D888C69;
	Sat,  3 Aug 2024 10:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nN23Ahom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EDE888FA; Sat,  3 Aug 2024 10:33:32 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509A888792
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f136e23229so73865341fa.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674009; x=1723278809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3iE/mZRSOvBPWuHYp/KpXhQdQYa9/94phSpdi8BOwFQ=;
 b=nN23AhomztK9kHsi+C2qwF5mlXOw08XMqL22xNy8wEpWZ0+zhg55FmEYdn1Era/oIF
 GvbOYYdOLXhItIL8dneGgiVsPC6kF1R5r4jAPLBxfdrTmJTo4SY56DOcDuaeVfocf2ZI
 hVjjhPnL2qBvZ+ISITkbwGk6qOI/qsU7wry43as1CpTlFdFW3wsPKAiaA6s6H9rYY2Xp
 EdJ/+2GnCpBjAXHTVtiu6aabRgoOzx/r2SQrAEzfWfn2XFh0URYZMwkvoouNmLkWdD7B
 CsAhZjzwZoOQQMrbaNCq/5z1SB4iirSBIPqVEsHtDO5y8R1IaMMB6PjuCKVDtBTaM37V
 vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674009; x=1723278809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iE/mZRSOvBPWuHYp/KpXhQdQYa9/94phSpdi8BOwFQ=;
 b=T1bNRxsDdi7a82xLo3DY4dBD+g6R7DrYdroMO3Gl5it0+LUpH46Ayz7qG7ZggWTxNa
 ZUCU8nEJ79eVpHMQwT3Up1APxdL5XRDUEgvXK11tLg3t1iBhVlo79K3/hKh756Gk6Zew
 Ng1W6iKqTVpvvOoKyAsqVFcZmfz6/uENEWxApGs8Tu4Ps6BaL0JjVwDV6QH/+n6ThAhn
 Pw4MKoudN1TqPmLhsmevboMGYYldzI5HfxYEIfoLO65ARZR9WrxjtH8u28/ocsElHQ5W
 QZ82SrcwOWVT/KfwsaOmd1ign2kaM0duaK6OqoB9+BUhqev8GV6Gdvo+y8PfEmK6EAKp
 TLiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ8CvShVS0rfth6eJ1m7W+8t33h+ze4Ay2dyfgiGKwi+q/ydKJ1tXWH/FCVGFaAdYfHtoJ7WJ4RZ3azHBaPUqCJ+z5Rw==
X-Gm-Message-State: AOJu0YxI2Bmm6pD/6RKU6IwaluoRSmhHFQo0aA+r8G4GmGtLcPGbL3lZ
 SipA+BMHVTXs6zo5PYpYc/U1u1HP+18/cnh+XCpYSIqd1gQ4aLqE
X-Google-Smtp-Source: AGHT+IFWxsHCPN0Ygs6iBxH5LrJqHRVZNonwBP2sGekWW/moFxXAobziliRw+V6T3EzYe7EWKC0vNw==
X-Received: by 2002:a2e:954f:0:b0:2f0:25dc:186d with SMTP id
 38308e7fff4ca-2f15aa835bfmr39790071fa.1.1722674009012; 
 Sat, 03 Aug 2024 01:33:29 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 07/13] clk: mediatek: mt7988: rename TOPCKGEN factor clock to
 upstream naming
Date: Sat,  3 Aug 2024 10:32:56 +0200
Message-ID: <20240803083305.30697-8-ansuelsmth@gmail.com>
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

Rename TOPCKGEN factor clock to upstream neaming.
Upstream kernel linux reference the factor clock for apmixedpll with the
"pll" suffix. Align the naming to the upstream naming format in
preparation for OF_UPSTREAM support.

Also rename rtc clock to drop the CB_ as upstream doesn't have that.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7988.dtsi               |   4 +-
 drivers/clk/mediatek/clk-mt7988.c      | 190 ++++++++++++-------------
 include/dt-bindings/clock/mt7988-clk.h |  72 +++++-----
 3 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index e8ab5e625da..10d5c2a33c3 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -371,8 +371,8 @@
 		clock-names = "pad_clk", "nfi_clk", "nfi_hclk";
 		assigned-clocks = <&topckgen CK_TOP_SPINFI_SEL>,
 				  <&topckgen CK_TOP_NFI1X_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D8>,
-					 <&topckgen CK_TOP_CB_M_D8>;
+		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D8>,
+					 <&topckgen CK_TOP_MPLL_D8>;
 		status = "disabled";
 	};
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 104f072cd0d..6bbc7045169 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -52,52 +52,52 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	XTAL_FACTOR(CK_TOP_XTAL, "xtal", CLK_XTAL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_M_416M, "cb_m_416m", CK_APMIXED_MPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_M_D2, "cb_m_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_M_D3_D2, "m_d3_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_M_D4, "cb_m_d4", CK_APMIXED_MPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_M_D8, "cb_m_d8", CK_APMIXED_MPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_M_D8_D2, "m_d8_d2", CK_APMIXED_MPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_CB_MM_720M, "cb_mm_720m", CK_APMIXED_MMPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MM_D2, "cb_mm_d2", CK_APMIXED_MMPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_MM_D3_D5, "cb_mm_d3_d5", CK_APMIXED_MMPLL, 1, 15),
-	PLL_FACTOR(CK_TOP_CB_MM_D4, "cb_mm_d4", CK_APMIXED_MMPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_MM_D6_D2, "mm_d6_d2", CK_APMIXED_MMPLL, 1, 12),
-	PLL_FACTOR(CK_TOP_CB_MM_D8, "cb_mm_d8", CK_APMIXED_MMPLL, 1, 8),
+	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
+	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
+	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
+	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
+	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
+	PLL_FACTOR(CK_TOP_CB_MMPLL_720M, "cb_mmpll_720m", CK_APMIXED_MMPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
+	PLL_FACTOR(CK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", CK_APMIXED_MMPLL, 1, 15),
+	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
+	PLL_FACTOR(CK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", CK_APMIXED_MMPLL, 1, 12),
+	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
 	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
 		   1),
-	PLL_FACTOR(CK_TOP_CB_APLL2_D4, "cb_apll2_d4", CK_APMIXED_APLL2, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_NET1_D4, "cb_net1_d4", CK_APMIXED_NET1PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_NET1_D5, "cb_net1_d5", CK_APMIXED_NET1PLL, 1, 5),
-	PLL_FACTOR(CK_TOP_NET1_D5_D2, "net1_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
-	PLL_FACTOR(CK_TOP_NET1_D5_D4, "net1_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
-	PLL_FACTOR(CK_TOP_CB_NET1_D8, "cb_net1_d8", CK_APMIXED_NET1PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_NET1_D8_D2, "net1_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET1_D8_D4, "net1_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
-	PLL_FACTOR(CK_TOP_NET1_D8_D8, "net1_d8_d8", CK_APMIXED_NET1PLL, 1, 64),
-	PLL_FACTOR(CK_TOP_NET1_D8_D16, "net1_d8_d16", CK_APMIXED_NET1PLL, 1,
+	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
+	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8, "net1pll_d8", CK_APMIXED_NET1PLL, 1, 8),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", CK_APMIXED_NET1PLL, 1, 64),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", CK_APMIXED_NET1PLL, 1,
 		   128),
-	PLL_FACTOR(CK_TOP_CB_NET2_800M, "cb_net2_800m", CK_APMIXED_NET2PLL, 1,
+	PLL_FACTOR(CK_TOP_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
 		   1),
-	PLL_FACTOR(CK_TOP_CB_NET2_D2, "cb_net2_d2", CK_APMIXED_NET2PLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_NET2_D4, "cb_net2_d4", CK_APMIXED_NET2PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET2_D4_D4, "net2_d4_d4", CK_APMIXED_NET2PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET2_D4_D8, "net2_d4_d8", CK_APMIXED_NET2PLL, 1, 32),
-	PLL_FACTOR(CK_TOP_CB_NET2_D6, "cb_net2_d6", CK_APMIXED_NET2PLL, 1, 6),
-	PLL_FACTOR(CK_TOP_CB_NET2_D8, "cb_net2_d8", CK_APMIXED_NET2PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_WEDMCU_208M, "cb_wedmcu_208m",
+	PLL_FACTOR(CK_TOP_NET2PLL_D2, "net2pll_d2", CK_APMIXED_NET2PLL, 1, 2),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CK_APMIXED_NET2PLL, 1, 16),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CK_APMIXED_NET2PLL, 1, 32),
+	PLL_FACTOR(CK_TOP_NET2PLL_D6, "net2pll_d6", CK_APMIXED_NET2PLL, 1, 6),
+	PLL_FACTOR(CK_TOP_NET2PLL_D8, "net2pll_d8", CK_APMIXED_NET2PLL, 1, 8),
+	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_208M, "cb_wedmcupll_208m",
 		   CK_APMIXED_WEDMCUPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_NETSYS_850M, "cb_netsys_850m",
+	PLL_FACTOR(CK_TOP_CB_NETSYSPLL_850M, "cb_netsyspll_850m",
 		   CK_APMIXED_NETSYSPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MSDC_400M, "cb_msdc_400m", CK_APMIXED_MSDCPLL, 1,
+	PLL_FACTOR(CK_TOP_CB_MSDCPLL_400M, "cb_msdcpll_400m", CK_APMIXED_MSDCPLL, 1,
 		   1),
 	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL, 1, 2),
-	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
-	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
-	TOP_FACTOR(CK_TOP_INFRA_F32K, "csw_infra_f32k", CK_TOP_CB_RTC_32P7K, 1,
+	TOP_FACTOR(CK_TOP_INFRA_F32K, "csw_infra_f32k", CK_TOP_RTC_32P7K, 1,
 		   1),
 	XTAL_FACTOR(CK_TOP_CKSQ_SRC, "cksq_src", CLK_XTAL, 1, 1),
 	TOP_FACTOR(CK_TOP_NETSYS_2X, "netsys_2x", CK_TOP_NETSYS_2X_SEL, 1, 1),
@@ -135,125 +135,125 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2_D2,
-				      CK_TOP_CB_MM_D2 };
+static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_NET2PLL_D2,
+				      CK_TOP_MMPLL_D2 };
 
 static const int netsys_500m_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_CB_NET1_D5,
-					   CK_TOP_NET1_D5_D2 };
+					   CK_TOP_NET1PLL_D5,
+					   CK_TOP_NET1PLL_D5_D2 };
 
 static const int netsys_2x_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_CB_NET2_800M,
-					 CK_TOP_CB_MM_720M };
+					 CK_TOP_NET2PLL_800M,
+					 CK_TOP_CB_MMPLL_720M };
 
-static const int netsys_gsw_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET1_D4,
-					  CK_TOP_CB_NET1_D5 };
+static const int netsys_gsw_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D4,
+					  CK_TOP_NET1PLL_D5 };
 
-static const int eth_gmii_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4 };
+static const int eth_gmii_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4 };
 
 static const int netsys_mcu_parents[] = {
-	CK_TOP_XTAL, CK_TOP_CB_NET2_800M, CK_TOP_CB_MM_720M,
-	CK_TOP_CB_NET1_D4,  CK_TOP_CB_NET1_D5,   CK_TOP_CB_M_416M
+	CK_TOP_XTAL, CK_TOP_NET2PLL_800M, CK_TOP_CB_MMPLL_720M,
+	CK_TOP_NET1PLL_D4,  CK_TOP_NET1PLL_D5,   CK_TOP_CB_MPLL_416M
 };
 
 static const int eip197_parents[] = {
-	CK_TOP_XTAL, CK_TOP_CB_NETSYS_850M, CK_TOP_CB_NET2_800M,
-	CK_TOP_CB_MM_720M,  CK_TOP_CB_NET1_D4,     CK_TOP_CB_NET1_D5
+	CK_TOP_XTAL, CK_TOP_CB_NETSYSPLL_850M, CK_TOP_NET2PLL_800M,
+	CK_TOP_CB_MMPLL_720M,  CK_TOP_NET1PLL_D4,     CK_TOP_NET1PLL_D5
 };
 
 static const int axi_infra_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_NET1_D8_D2 };
+					 CK_TOP_NET1PLL_D8_D2 };
 
-static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D8,
-				    CK_TOP_M_D8_D2 };
+static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8,
+				    CK_TOP_MPLL_D8_D2 };
 
-static const int emmc_250m_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D2,
-					 CK_TOP_CB_MM_D4 };
+static const int emmc_250m_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D2,
+					 CK_TOP_MMPLL_D4 };
 
 static const int emmc_400m_parents[] = {
-	CK_TOP_XTAL, CK_TOP_CB_MSDC_400M, CK_TOP_CB_MM_D2,
-	CK_TOP_CB_M_D2,     CK_TOP_CB_MM_D4,     CK_TOP_NET1_D8_D2
+	CK_TOP_XTAL, CK_TOP_CB_MSDCPLL_400M, CK_TOP_MMPLL_D2,
+	CK_TOP_MPLL_D2,     CK_TOP_MMPLL_D4,     CK_TOP_NET1PLL_D8_D2
 };
 
-static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
-				   CK_TOP_CB_MM_D4,    CK_TOP_NET1_D8_D2,
-				   CK_TOP_CB_NET2_D6,  CK_TOP_NET1_D5_D4,
-				   CK_TOP_CB_M_D4,     CK_TOP_NET1_D8_D4 };
+static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
+				   CK_TOP_MMPLL_D4,    CK_TOP_NET1PLL_D8_D2,
+				   CK_TOP_NET2PLL_D6,  CK_TOP_NET1PLL_D5_D4,
+				   CK_TOP_MPLL_D4,     CK_TOP_NET1PLL_D8_D4 };
 
-static const int nfi1x_parents[] = { CK_TOP_XTAL, CK_TOP_CB_MM_D4,
-				     CK_TOP_NET1_D8_D2,  CK_TOP_CB_NET2_D6,
-				     CK_TOP_CB_M_D4,     CK_TOP_CB_MM_D8,
-				     CK_TOP_NET1_D8_D4,  CK_TOP_CB_M_D8 };
+static const int nfi1x_parents[] = { CK_TOP_XTAL, CK_TOP_MMPLL_D4,
+				     CK_TOP_NET1PLL_D8_D2,  CK_TOP_NET2PLL_D6,
+				     CK_TOP_MPLL_D4,     CK_TOP_MMPLL_D8,
+				     CK_TOP_NET1PLL_D8_D4,  CK_TOP_MPLL_D8 };
 
 static const int spinfi_parents[] = { CK_TOP_XTAL_D2, CK_TOP_XTAL,
-				      CK_TOP_NET1_D5_D4,  CK_TOP_CB_M_D4,
-				      CK_TOP_CB_MM_D8,    CK_TOP_NET1_D8_D4,
-				      CK_TOP_MM_D6_D2,    CK_TOP_CB_M_D8 };
+				      CK_TOP_NET1PLL_D5_D4,  CK_TOP_MPLL_D4,
+				      CK_TOP_MMPLL_D8,    CK_TOP_NET1PLL_D8_D4,
+				      CK_TOP_MMPLL_D6_D2,    CK_TOP_MPLL_D8 };
 
-static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
-				   CK_TOP_NET1_D5_D4,  CK_TOP_CB_M_D4,
-				   CK_TOP_M_D8_D2,     CK_TOP_CB_RTC_32K };
+static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
+				   CK_TOP_NET1PLL_D5_D4,  CK_TOP_MPLL_D4,
+				   CK_TOP_MPLL_D8_D2,     CK_TOP_RTC_32K };
 
-static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
-				   CK_TOP_CB_M_D4, CK_TOP_NET1_D8_D4 };
+static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
+				   CK_TOP_MPLL_D4, CK_TOP_NET1PLL_D8_D4 };
 
 static const int pcie_mbist_250m_parents[] = { CK_TOP_XTAL,
-					       CK_TOP_NET1_D5_D2 };
+					       CK_TOP_NET1PLL_D5_D2 };
 
 static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_CB_NET2_D6, CK_TOP_CB_MM_D8,
-					   CK_TOP_M_D8_D2, CK_TOP_CB_RTC_32K };
+					   CK_TOP_NET2PLL_D6, CK_TOP_MMPLL_D8,
+					   CK_TOP_MPLL_D8_D2, CK_TOP_RTC_32K };
 
 static const int usb_frmcnt_parents[] = { CK_TOP_XTAL,
-					  CK_TOP_CB_MM_D3_D5 };
+					  CK_TOP_MMPLL_D3_D5 };
 
 static const int aud_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M };
 
-static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_D4 };
+static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4 };
 
 static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
-				     CK_TOP_M_D8_D2 };
+				     CK_TOP_MPLL_D8_D2 };
 
-static const int sspxtp_parents[] = { CK_TOP_XTAL_D2, CK_TOP_M_D8_D2 };
+static const int sspxtp_parents[] = { CK_TOP_XTAL_D2, CK_TOP_MPLL_D8_D2 };
 
 static const int usxgmii_sbus_0_parents[] = { CK_TOP_XTAL,
-					      CK_TOP_NET1_D8_D4 };
+					      CK_TOP_NET1PLL_D8_D4 };
 
 static const int sgm_0_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M };
 
-static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_M_D3_D2 };
+static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D3_D2 };
 
 static const int eth_refck_50m_parents[] = { CK_TOP_XTAL,
-					     CK_TOP_NET2_D4_D4 };
+					     CK_TOP_NET2PLL_D4_D4 };
 
 static const int eth_sys_200m_parents[] = { CK_TOP_XTAL,
-					    CK_TOP_CB_NET2_D4 };
+					    CK_TOP_NET2PLL_D4 };
 
-static const int eth_xgmii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET1_D8_D8,
-					 CK_TOP_NET1_D8_D16 };
+static const int eth_xgmii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET1PLL_D8_D8,
+					 CK_TOP_NET1PLL_D8_D16 };
 
-static const int bus_tops_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET1_D5,
-					CK_TOP_CB_NET2_D2 };
+static const int bus_tops_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5,
+					CK_TOP_NET2PLL_D2 };
 
 static const int npu_tops_parents[] = { CK_TOP_XTAL,
-					CK_TOP_CB_NET2_800M };
+					CK_TOP_NET2PLL_800M };
 
-static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
-					  CK_TOP_CB_WEDMCU_208M };
+static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
+					  CK_TOP_CB_WEDMCUPLL_208M };
 
 static const int da_xtp_glb_p0_parents[] = { CK_TOP_XTAL,
-					     CK_TOP_CB_NET2_D8 };
+					     CK_TOP_NET2PLL_D8 };
 
 static const int mcusys_backup_625m_parents[] = { CK_TOP_XTAL,
-						  CK_TOP_CB_NET1_D4 };
+						  CK_TOP_NET1PLL_D4 };
 
 static const int macsec_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M,
-				      CK_TOP_CB_NET1_D8 };
+				      CK_TOP_NET1PLL_D8 };
 
 static const int netsys_tops_400m_parents[] = { CK_TOP_XTAL,
-						CK_TOP_CB_NET2_D2 };
+						CK_TOP_NET2PLL_D2 };
 
-static const int eth_mii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET2_D4_D8 };
+static const int eth_mii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET2PLL_D4_D8 };
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -674,7 +674,7 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 			CK_TOP_SYSAXI, 17),
 	GATE_INFRA2_TOP(CK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
 			CK_TOP_SYSAXI, 18),
-	GATE_INFRA2_TOP(CK_INFRA_RTC, "infra_f_frtc", CK_TOP_CB_RTC_32K, 19),
+	GATE_INFRA2_TOP(CK_INFRA_RTC, "infra_f_frtc", CK_TOP_RTC_32K, 19),
 	GATE_INFRA2_TOP(CK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
 			CK_TOP_INFRA_F26M, 20),
 	GATE_INFRA2_INFRA(CK_INFRA_RC_ADC, "infra_f_frc_adc", CK_INFRA_26M_ADC_BCK,
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 61691d58dda..36a5f4818b2 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -122,43 +122,43 @@
 /* TOPCKGEN */
 /* mtk_fixed_factor */
 #define CK_TOP_XTAL           0 /* Linux CLK ID (74) */
-#define CK_TOP_CB_M_416M      1 /* Linux CLK ID (75) */
-#define CK_TOP_CB_M_D2	      2 /* Linux CLK ID (76) */
-#define CK_TOP_M_D3_D2	      3 /* Linux CLK ID (77) */
-#define CK_TOP_CB_M_D4	      4 /* Linux CLK ID (78) */
-#define CK_TOP_CB_M_D8	      5 /* Linux CLK ID (79) */
-#define CK_TOP_M_D8_D2	      6 /* Linux CLK ID (80) */
-#define CK_TOP_CB_MM_720M     7 /* Linux CLK ID (81) */
-#define CK_TOP_CB_MM_D2	      8 /* Linux CLK ID (82) */
-#define CK_TOP_CB_MM_D3_D5    9 /* Linux CLK ID (83) */
-#define CK_TOP_CB_MM_D4	      10 /* Linux CLK ID (84) */
-#define CK_TOP_MM_D6_D2	      11 /* Linux CLK ID (85) */
-#define CK_TOP_CB_MM_D8	      12 /* Linux CLK ID (86) */
+#define CK_TOP_CB_MPLL_416M   1 /* Linux CLK ID (75) */
+#define CK_TOP_MPLL_D2	      2 /* Linux CLK ID (76) */
+#define CK_TOP_MPLL_D3_D2     3 /* Linux CLK ID (77) */
+#define CK_TOP_MPLL_D4	      4 /* Linux CLK ID (78) */
+#define CK_TOP_MPLL_D8	      5 /* Linux CLK ID (79) */
+#define CK_TOP_MPLL_D8_D2     6 /* Linux CLK ID (80) */
+#define CK_TOP_CB_MMPLL_720M  7 /* Linux CLK ID (81) */
+#define CK_TOP_MMPLL_D2	      8 /* Linux CLK ID (82) */
+#define CK_TOP_MMPLL_D3_D5    9 /* Linux CLK ID (83) */
+#define CK_TOP_MMPLL_D4	      10 /* Linux CLK ID (84) */
+#define CK_TOP_MMPLL_D6_D2    11 /* Linux CLK ID (85) */
+#define CK_TOP_MMPLL_D8	      12 /* Linux CLK ID (86) */
 #define CK_TOP_CB_APLL2_196M  13 /* Linux CLK ID (87) */
-#define CK_TOP_CB_APLL2_D4    14 /* Linux CLK ID (88) */
-#define CK_TOP_CB_NET1_D4     15 /* Linux CLK ID (89) */
-#define CK_TOP_CB_NET1_D5     16 /* Linux CLK ID (90) */
-#define CK_TOP_NET1_D5_D2     17 /* Linux CLK ID (91) */
-#define CK_TOP_NET1_D5_D4     18 /* Linux CLK ID (92) */
-#define CK_TOP_CB_NET1_D8     19 /* Linux CLK ID (93) */
-#define CK_TOP_NET1_D8_D2     20 /* Linux CLK ID (94) */
-#define CK_TOP_NET1_D8_D4     21 /* Linux CLK ID (95) */
-#define CK_TOP_NET1_D8_D8     22 /* Linux CLK ID (96) */
-#define CK_TOP_NET1_D8_D16    23 /* Linux CLK ID (97) */
-#define CK_TOP_CB_NET2_800M   24 /* Linux CLK ID (98) */
-#define CK_TOP_CB_NET2_D2     25 /* Linux CLK ID (99) */
-#define CK_TOP_CB_NET2_D4     26 /* Linux CLK ID (100) */
-#define CK_TOP_NET2_D4_D4     27 /* Linux CLK ID (101) */
-#define CK_TOP_NET2_D4_D8     28 /* Linux CLK ID (102) */
-#define CK_TOP_CB_NET2_D6     29 /* Linux CLK ID (103) */
-#define CK_TOP_CB_NET2_D8     30 /* Linux CLK ID (104) */
-#define CK_TOP_CB_WEDMCU_208M 31 /* Linux CLK ID (105) */
-#define CK_TOP_CB_SGM_325M    32 /* Linux CLK ID (106) */
-#define CK_TOP_CB_NETSYS_850M 33 /* Linux CLK ID (107) */
-#define CK_TOP_CB_MSDC_400M   34 /* Linux CLK ID (108) */
-#define CK_TOP_XTAL_D2    35 /* Linux CLK ID (109) */
-#define CK_TOP_CB_RTC_32K     36 /* Linux CLK ID (110) */
-#define CK_TOP_CB_RTC_32P7K   37 /* Linux CLK ID (111) */
+#define CK_TOP_APLL2_D4       14 /* Linux CLK ID (88) */
+#define CK_TOP_NET1PLL_D4     15 /* Linux CLK ID (89) */
+#define CK_TOP_NET1PLL_D5     16 /* Linux CLK ID (90) */
+#define CK_TOP_NET1PLL_D5_D2  17 /* Linux CLK ID (91) */
+#define CK_TOP_NET1PLL_D5_D4  18 /* Linux CLK ID (92) */
+#define CK_TOP_NET1PLL_D8     19 /* Linux CLK ID (93) */
+#define CK_TOP_NET1PLL_D8_D2  20 /* Linux CLK ID (94) */
+#define CK_TOP_NET1PLL_D8_D4  21 /* Linux CLK ID (95) */
+#define CK_TOP_NET1PLL_D8_D8  22 /* Linux CLK ID (96) */
+#define CK_TOP_NET1PLL_D8_D16 23 /* Linux CLK ID (97) */
+#define CK_TOP_CB_NET2PLL_800M 24 /* Linux CLK ID (98) */
+#define CK_TOP_NET2PLL_D2     25 /* Linux CLK ID (99) */
+#define CK_TOP_NET2PLL_D4     26 /* Linux CLK ID (100) */
+#define CK_TOP_NET2PLL_D4_D4  27 /* Linux CLK ID (101) */
+#define CK_TOP_NET2PLL_D4_D8  28 /* Linux CLK ID (102) */
+#define CK_TOP_NET2PLL_D6     29 /* Linux CLK ID (103) */
+#define CK_TOP_NET2PLL_D8     30 /* Linux CLK ID (104) */
+#define CK_TOP_CB_WEDMCUPLL_208M 31 /* Linux CLK ID (105) */
+#define CK_TOP_CB_SGMPLL_325M 32 /* Linux CLK ID (106) */
+#define CK_TOP_CB_NETSYSPLL_850M 33 /* Linux CLK ID (107) */
+#define CK_TOP_CB_MSDCPLL_400M 34 /* Linux CLK ID (108) */
+#define CK_TOP_XTAL_D2        35 /* Linux CLK ID (109) */
+#define CK_TOP_RTC_32K        36 /* Linux CLK ID (110) */
+#define CK_TOP_RTC_32P7K      37 /* Linux CLK ID (111) */
 #define CK_TOP_INFRA_F32K     38 /* Linux CLK ID (112) */
 #define CK_TOP_CKSQ_SRC	      39 /* Linux CLK ID (113) */
 #define CK_TOP_NETSYS_2X      40 /* Linux CLK ID (114) */
-- 
2.45.2

