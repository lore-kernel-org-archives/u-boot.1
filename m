Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB95C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7A688C81;
	Sat,  3 Aug 2024 10:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaY7Y81m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B131588C72; Sat,  3 Aug 2024 10:33:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4837588C63
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so79760785e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674011; x=1723278811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MRe4MqLJGrvn1YRNQjzRZjv4dKnLRl1y5YO4Y4IItDQ=;
 b=gaY7Y81mXnlbFwO4ZXVvTqbHFy22LS0AFTG2zSA6RwiQrB5kRf8YYD3R402/wgewnr
 0+d6IOW6DbRIkRR+nwRtpBONXx5vnqEcMnvNb7wjTJKHn5NOA1kY04gmZLxdg0SSqA7x
 XNRqt2XABM5M/8V65lPFJWRW1yq5FU6P77qaRzhMxf/wpLHTaxpU0XAooIcc3rTqDVvr
 PTnp8C1d6/KTRDLYrwr1305zZJP12btYR5Gzumz+kQBTx9HajKG+DHCcL0lmaqmqpLw8
 oMiY7IBGAScp/qb+MUP6pTfaJKpFsqK8XgVPHbUnT+rrmzI96C6grUOJzPdkI+qgnM9H
 QD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674011; x=1723278811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRe4MqLJGrvn1YRNQjzRZjv4dKnLRl1y5YO4Y4IItDQ=;
 b=MgQpCcNQpC6NVTwG2qBFTtlNLYG4xymik8jjKgzN6pmarpRwenbBu6A1wSnvRcrxby
 +v9AXcclXNk+mBdEtS/x9ZouFM9q6+nVRHW5lg8bT8yt7wyhp1Wsdw1+guDKDFZ4u+rO
 j3yeNMzhf3xIImFSfl7aWm/Eqh3h3ySfetm6ddfen8EY4qWYt9xDqP2b9A1caF8/a9yT
 wo9ImrqvR0hzKdqt5J1aDSxyR9IXsDW6LXkI5p55YpoLCg53yF2C1HWdpB1IAX5ocPw5
 ancp9asKxU98cFsYrCtAn9Je4bM4tHKv7AeCjzwX0N53q+v6qWe2JFMHBSPKFkwIh1jK
 BZVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO2MRadFPYRBmMTCZa0rSSOayiuEO2je5a7vqVbq9xQmDzkkXDiA5iW1qYyqWHkoLSSKTybmrLo73vUd98CjwZjpDRPA==
X-Gm-Message-State: AOJu0Yy3cVFi/WkHP2N3v2xkII0OxoXG/QeaG69/q7+MQ+QRTXaE0fUl
 ArYu7cxgjYBH2xIO9pfzURRe9KO499xNOEWlunFLCpCTCyxDW4At
X-Google-Smtp-Source: AGHT+IGhkQXQP++9HFFMo2/GNOErhYAlvTSXjv1HZFMzbe8NeJqIJr9QcctInil3cGFJeb1NzG13pg==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id
 5b1f17b1804b1-428e6b0274emr44182705e9.11.1722674010546; 
 Sat, 03 Aug 2024 01:33:30 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 08/13] clk: mediatek: mt7988: reorder TOPCKGEN factor ID
Date: Sat,  3 Aug 2024 10:32:57 +0200
Message-ID: <20240803083305.30697-9-ansuelsmth@gmail.com>
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

Reorder TOPCKGEN factor ID to put TOP_FACTOR first and then PLL. This is
to match how it's done in upstream kernel linux and in preparation for
OF_UPSTREAM support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      |  80 +++++++--------
 include/dt-bindings/clock/mt7988-clk.h | 130 ++++++++++++-------------
 2 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 6bbc7045169..24dc3299e11 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -52,46 +52,6 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	XTAL_FACTOR(CK_TOP_XTAL, "xtal", CLK_XTAL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_CB_MMPLL_720M, "cb_mmpll_720m", CK_APMIXED_MMPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", CK_APMIXED_MMPLL, 1, 15),
-	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", CK_APMIXED_MMPLL, 1, 12),
-	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
-		   1),
-	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
-	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8, "net1pll_d8", CK_APMIXED_NET1PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", CK_APMIXED_NET1PLL, 1, 64),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", CK_APMIXED_NET1PLL, 1,
-		   128),
-	PLL_FACTOR(CK_TOP_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
-		   1),
-	PLL_FACTOR(CK_TOP_NET2PLL_D2, "net2pll_d2", CK_APMIXED_NET2PLL, 1, 2),
-	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CK_APMIXED_NET2PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CK_APMIXED_NET2PLL, 1, 32),
-	PLL_FACTOR(CK_TOP_NET2PLL_D6, "net2pll_d6", CK_APMIXED_NET2PLL, 1, 6),
-	PLL_FACTOR(CK_TOP_NET2PLL_D8, "net2pll_d8", CK_APMIXED_NET2PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_208M, "cb_wedmcupll_208m",
-		   CK_APMIXED_WEDMCUPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_NETSYSPLL_850M, "cb_netsyspll_850m",
-		   CK_APMIXED_NETSYSPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MSDCPLL_400M, "cb_msdcpll_400m", CK_APMIXED_MSDCPLL, 1,
-		   1),
 	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL, 1, 2),
 	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
@@ -132,6 +92,46 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 		   1, 1),
 	TOP_FACTOR(CK_TOP_USB_REF, "usb_ref", CK_TOP_CKSQ_SRC, 1, 1),
 	TOP_FACTOR(CK_TOP_USB_CK_P1, "usb_ck_p1", CK_TOP_CKSQ_SRC, 1, 1),
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
+	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
+		   1),
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
+		   128),
+	PLL_FACTOR(CK_TOP_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
+		   1),
+	PLL_FACTOR(CK_TOP_NET2PLL_D2, "net2pll_d2", CK_APMIXED_NET2PLL, 1, 2),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CK_APMIXED_NET2PLL, 1, 16),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CK_APMIXED_NET2PLL, 1, 32),
+	PLL_FACTOR(CK_TOP_NET2PLL_D6, "net2pll_d6", CK_APMIXED_NET2PLL, 1, 6),
+	PLL_FACTOR(CK_TOP_NET2PLL_D8, "net2pll_d8", CK_APMIXED_NET2PLL, 1, 8),
+	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_208M, "cb_wedmcupll_208m",
+		   CK_APMIXED_WEDMCUPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_CB_NETSYSPLL_850M, "cb_netsyspll_850m",
+		   CK_APMIXED_NETSYSPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_CB_MSDCPLL_400M, "cb_msdcpll_400m", CK_APMIXED_MSDCPLL, 1,
+		   1),
 };
 
 /* TOPCKGEN MUX PARENTS */
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 36a5f4818b2..47ea13c04b8 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -121,71 +121,71 @@
 
 /* TOPCKGEN */
 /* mtk_fixed_factor */
-#define CK_TOP_XTAL           0 /* Linux CLK ID (74) */
-#define CK_TOP_CB_MPLL_416M   1 /* Linux CLK ID (75) */
-#define CK_TOP_MPLL_D2	      2 /* Linux CLK ID (76) */
-#define CK_TOP_MPLL_D3_D2     3 /* Linux CLK ID (77) */
-#define CK_TOP_MPLL_D4	      4 /* Linux CLK ID (78) */
-#define CK_TOP_MPLL_D8	      5 /* Linux CLK ID (79) */
-#define CK_TOP_MPLL_D8_D2     6 /* Linux CLK ID (80) */
-#define CK_TOP_CB_MMPLL_720M  7 /* Linux CLK ID (81) */
-#define CK_TOP_MMPLL_D2	      8 /* Linux CLK ID (82) */
-#define CK_TOP_MMPLL_D3_D5    9 /* Linux CLK ID (83) */
-#define CK_TOP_MMPLL_D4	      10 /* Linux CLK ID (84) */
-#define CK_TOP_MMPLL_D6_D2    11 /* Linux CLK ID (85) */
-#define CK_TOP_MMPLL_D8	      12 /* Linux CLK ID (86) */
-#define CK_TOP_CB_APLL2_196M  13 /* Linux CLK ID (87) */
-#define CK_TOP_APLL2_D4       14 /* Linux CLK ID (88) */
-#define CK_TOP_NET1PLL_D4     15 /* Linux CLK ID (89) */
-#define CK_TOP_NET1PLL_D5     16 /* Linux CLK ID (90) */
-#define CK_TOP_NET1PLL_D5_D2  17 /* Linux CLK ID (91) */
-#define CK_TOP_NET1PLL_D5_D4  18 /* Linux CLK ID (92) */
-#define CK_TOP_NET1PLL_D8     19 /* Linux CLK ID (93) */
-#define CK_TOP_NET1PLL_D8_D2  20 /* Linux CLK ID (94) */
-#define CK_TOP_NET1PLL_D8_D4  21 /* Linux CLK ID (95) */
-#define CK_TOP_NET1PLL_D8_D8  22 /* Linux CLK ID (96) */
-#define CK_TOP_NET1PLL_D8_D16 23 /* Linux CLK ID (97) */
-#define CK_TOP_CB_NET2PLL_800M 24 /* Linux CLK ID (98) */
-#define CK_TOP_NET2PLL_D2     25 /* Linux CLK ID (99) */
-#define CK_TOP_NET2PLL_D4     26 /* Linux CLK ID (100) */
-#define CK_TOP_NET2PLL_D4_D4  27 /* Linux CLK ID (101) */
-#define CK_TOP_NET2PLL_D4_D8  28 /* Linux CLK ID (102) */
-#define CK_TOP_NET2PLL_D6     29 /* Linux CLK ID (103) */
-#define CK_TOP_NET2PLL_D8     30 /* Linux CLK ID (104) */
-#define CK_TOP_CB_WEDMCUPLL_208M 31 /* Linux CLK ID (105) */
-#define CK_TOP_CB_SGMPLL_325M 32 /* Linux CLK ID (106) */
-#define CK_TOP_CB_NETSYSPLL_850M 33 /* Linux CLK ID (107) */
-#define CK_TOP_CB_MSDCPLL_400M 34 /* Linux CLK ID (108) */
-#define CK_TOP_XTAL_D2        35 /* Linux CLK ID (109) */
-#define CK_TOP_RTC_32K        36 /* Linux CLK ID (110) */
-#define CK_TOP_RTC_32P7K      37 /* Linux CLK ID (111) */
-#define CK_TOP_INFRA_F32K     38 /* Linux CLK ID (112) */
-#define CK_TOP_CKSQ_SRC	      39 /* Linux CLK ID (113) */
-#define CK_TOP_NETSYS_2X      40 /* Linux CLK ID (114) */
-#define CK_TOP_NETSYS_GSW     41 /* Linux CLK ID (115) */
-#define CK_TOP_NETSYS_WED_MCU 42 /* Linux CLK ID (116) */
-#define CK_TOP_EIP197	      43 /* Linux CLK ID (117) */
-#define CK_TOP_EMMC_250M      44 /* Linux CLK ID (118) */
-#define CK_TOP_EMMC_400M      45 /* Linux CLK ID (119) */
-#define CK_TOP_SPI	      46 /* Linux CLK ID (120) */
-#define CK_TOP_SPIM_MST	      47 /* Linux CLK ID (121) */
-#define CK_TOP_NFI1X	      48 /* Linux CLK ID (122) */
-#define CK_TOP_SPINFI_BCK     49 /* Linux CLK ID (123) */
-#define CK_TOP_I2C_BCK	      50 /* Linux CLK ID (124) */
-#define CK_TOP_USB_SYS	      51 /* Linux CLK ID (125) */
-#define CK_TOP_USB_SYS_P1     52 /* Linux CLK ID (126) */
-#define CK_TOP_USB_XHCI	      53 /* Linux CLK ID (127) */
-#define CK_TOP_USB_XHCI_P1    54 /* Linux CLK ID (128) */
-#define CK_TOP_USB_FRMCNT     55 /* Linux CLK ID (129) */
-#define CK_TOP_USB_FRMCNT_P1  56 /* Linux CLK ID (130) */
-#define CK_TOP_AUD	      57 /* Linux CLK ID (131) */
-#define CK_TOP_A1SYS	      58 /* Linux CLK ID (132) */
-#define CK_TOP_AUD_L	      59 /* Linux CLK ID (133) */
-#define CK_TOP_A_TUNER	      60 /* Linux CLK ID (134) */
-#define CK_TOP_SYSAXI	      61 /* Linux CLK ID (135) */
-#define CK_TOP_INFRA_F26M     62 /* Linux CLK ID (136) */
-#define CK_TOP_USB_REF	      63 /* Linux CLK ID (137) */
-#define CK_TOP_USB_CK_P1      64 /* Linux CLK ID (138) */
+#define CK_TOP_XTAL_D2        0 /* Linux CLK ID (109) */
+#define CK_TOP_RTC_32K        1 /* Linux CLK ID (110) */
+#define CK_TOP_RTC_32P7K      2 /* Linux CLK ID (111) */
+#define CK_TOP_INFRA_F32K     3 /* Linux CLK ID (112) */
+#define CK_TOP_CKSQ_SRC	      4 /* Linux CLK ID (113) */
+#define CK_TOP_NETSYS_2X      5 /* Linux CLK ID (114) */
+#define CK_TOP_NETSYS_GSW     6 /* Linux CLK ID (115) */
+#define CK_TOP_NETSYS_WED_MCU 7 /* Linux CLK ID (116) */
+#define CK_TOP_EIP197	      8 /* Linux CLK ID (117) */
+#define CK_TOP_EMMC_250M      9 /* Linux CLK ID (118) */
+#define CK_TOP_EMMC_400M      10 /* Linux CLK ID (119) */
+#define CK_TOP_SPI	      11 /* Linux CLK ID (120) */
+#define CK_TOP_SPIM_MST	      12 /* Linux CLK ID (121) */
+#define CK_TOP_NFI1X	      13 /* Linux CLK ID (122) */
+#define CK_TOP_SPINFI_BCK     14 /* Linux CLK ID (123) */
+#define CK_TOP_I2C_BCK	      15 /* Linux CLK ID (124) */
+#define CK_TOP_USB_SYS	      16 /* Linux CLK ID (125) */
+#define CK_TOP_USB_SYS_P1     17 /* Linux CLK ID (126) */
+#define CK_TOP_USB_XHCI	      18 /* Linux CLK ID (127) */
+#define CK_TOP_USB_XHCI_P1    19 /* Linux CLK ID (128) */
+#define CK_TOP_USB_FRMCNT     20 /* Linux CLK ID (129) */
+#define CK_TOP_USB_FRMCNT_P1  21 /* Linux CLK ID (130) */
+#define CK_TOP_AUD	      22 /* Linux CLK ID (131) */
+#define CK_TOP_A1SYS	      23 /* Linux CLK ID (132) */
+#define CK_TOP_AUD_L	      24 /* Linux CLK ID (133) */
+#define CK_TOP_A_TUNER	      25 /* Linux CLK ID (134) */
+#define CK_TOP_SYSAXI	      26 /* Linux CLK ID (135) */
+#define CK_TOP_INFRA_F26M     27 /* Linux CLK ID (136) */
+#define CK_TOP_USB_REF	      28 /* Linux CLK ID (137) */
+#define CK_TOP_USB_CK_P1      29 /* Linux CLK ID (138) */
+#define CK_TOP_XTAL           30 /* Linux CLK ID (74) */
+#define CK_TOP_CB_MPLL_416M   31 /* Linux CLK ID (75) */
+#define CK_TOP_MPLL_D2	      32 /* Linux CLK ID (76) */
+#define CK_TOP_MPLL_D3_D2     33 /* Linux CLK ID (77) */
+#define CK_TOP_MPLL_D4	      35 /* Linux CLK ID (78) */
+#define CK_TOP_MPLL_D8	      34 /* Linux CLK ID (79) */
+#define CK_TOP_MPLL_D8_D2     36 /* Linux CLK ID (80) */
+#define CK_TOP_CB_MMPLL_720M  37 /* Linux CLK ID (81) */
+#define CK_TOP_MMPLL_D2	      38 /* Linux CLK ID (82) */
+#define CK_TOP_MMPLL_D3_D5    39 /* Linux CLK ID (83) */
+#define CK_TOP_MMPLL_D4	      40 /* Linux CLK ID (84) */
+#define CK_TOP_MMPLL_D6_D2    41 /* Linux CLK ID (85) */
+#define CK_TOP_MMPLL_D8	      42 /* Linux CLK ID (86) */
+#define CK_TOP_CB_APLL2_196M  43 /* Linux CLK ID (87) */
+#define CK_TOP_APLL2_D4       44 /* Linux CLK ID (88) */
+#define CK_TOP_NET1PLL_D4     45 /* Linux CLK ID (89) */
+#define CK_TOP_NET1PLL_D5     46 /* Linux CLK ID (90) */
+#define CK_TOP_NET1PLL_D5_D2  47 /* Linux CLK ID (91) */
+#define CK_TOP_NET1PLL_D5_D4  48 /* Linux CLK ID (92) */
+#define CK_TOP_NET1PLL_D8     49 /* Linux CLK ID (93) */
+#define CK_TOP_NET1PLL_D8_D2  50 /* Linux CLK ID (94) */
+#define CK_TOP_NET1PLL_D8_D4  51 /* Linux CLK ID (95) */
+#define CK_TOP_NET1PLL_D8_D8  52 /* Linux CLK ID (96) */
+#define CK_TOP_NET1PLL_D8_D16 53 /* Linux CLK ID (97) */
+#define CK_TOP_CB_NET2PLL_800M 54 /* Linux CLK ID (98) */
+#define CK_TOP_NET2PLL_D2     55 /* Linux CLK ID (99) */
+#define CK_TOP_NET2PLL_D4     56 /* Linux CLK ID (100) */
+#define CK_TOP_NET2PLL_D4_D4  57 /* Linux CLK ID (101) */
+#define CK_TOP_NET2PLL_D4_D8  58 /* Linux CLK ID (102) */
+#define CK_TOP_NET2PLL_D6     59 /* Linux CLK ID (103) */
+#define CK_TOP_NET2PLL_D8     60 /* Linux CLK ID (104) */
+#define CK_TOP_CB_WEDMCUPLL_208M 61 /* Linux CLK ID (105) */
+#define CK_TOP_CB_SGMPLL_325M 62 /* Linux CLK ID (106) */
+#define CK_TOP_CB_NETSYSPLL_850M 63 /* Linux CLK ID (107) */
+#define CK_TOP_CB_MSDCPLL_400M 64 /* Linux CLK ID (108) */
 /* mtk_mux */
 #define CK_TOP_NETSYS_SEL	      65 /* Linux CLK ID (0) */
 #define CK_TOP_NETSYS_500M_SEL	      66 /* Linux CLK ID (1) */
-- 
2.45.2

