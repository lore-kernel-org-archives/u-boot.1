Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3184FEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF92D840F1;
	Tue, 10 Mar 2026 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLJRg9Fl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494548410C; Tue, 10 Mar 2026 16:34:23 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE18E840D7
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463a0e14abfso9305535b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156859; x=1773761659;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DAfyRc584ssWtJWvRoIkIHoagBk2iPZCIHeN6RVhON8=;
 b=yLJRg9FluopqVIW/bViIdGIBdwx8RPRvLg0Q1vyzDMmFQ5UshMCO+kANUelm4iA27g
 cUw0BTIFk8Jdu67qaDiyWBFrtv72WFNBjtRRJhHlOjEYHLdbQw6lMHq/TE738nktE377
 x8Rw4kCE6YyEcg/tjWoY/sysdiopytPUXaB2Y6WLrEig60ORiEiYdvxVqfhRMFNVw9Fa
 QUps8/Hru7VinNG7IO1suS0q5QVfcO4G2zy3toSXyxH/TPsZarKw1ngeC5+K0Io6TR8L
 XVh2wmKCAdaHIao10k2MuodvSVGgKTfjopwYQZ2eJSyTomF4xNr9njYjDGJ81jST+7t6
 a5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156859; x=1773761659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DAfyRc584ssWtJWvRoIkIHoagBk2iPZCIHeN6RVhON8=;
 b=U0wgMSKcLGLv2Trot7a2yZQRA0V+RrdOzqKjJJWWkDHL2L1oQuyVr8SvxIOCHnCrQo
 gwmqODQ689QmMuPGTFdTiY1duYCreq/OT3FHABeYRtvRP/PQuPsBOIgHyzD5wfddSBAz
 1s+m96V7uAVK0TJOvrMWoP7DBIJ+aWUymHJyxj7A4/lkMb9vPNIFBi0XvgTk9cH4dgv4
 /dHOI/CKGB4y+88o9oqh16QJxtJ3WqYXC/NQ8etN40YYYNPbZxP4sdwW+DKlJzR5vibL
 DDbkP9NXX30CAeSh6p6qChDzGAEu6xnzJuM4OUhy6Fa2dCyK/Lxb52wOn9RkSQ+pnRMB
 JiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWImM9r/IMPj2cv2NRAIePgknxpHOVwUL11akJpjENeDuXPuxSvpJDImBX0WVwcj6oCCF9w+Yw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu+nMgnT4oU5c7ONouteXAId6tdrmOXbZAUA4CxLyZqYuNk03K
 U8N6/ZMWJfS+SXTkNHL8nGpD8jVjVVD0x1uPs92iiOWcJ4/kv3iCIqpapH0IU22wHqs=
X-Gm-Gg: ATEYQzyASguSkxz+hViq+8VrK+CAa23ceIteMJay59tBLtz5lRnWebh5m/YuSa36KyT
 vUkj2HG6ClUsa7j4YxWjy5xUDqYJ7mhZQcVahajYQ9XSTi/sFSa28oLdjYDQWVQ7jGetxrUamt3
 HIksGNSIF3DLorTN7NmCdtXoHyzoXCvHrzYgWo/6NqRjGBOZPIwZzuxXt8bhP5GhqjBRV1rYbKL
 ZIGLwRVeCXBXwTs7q9tsNQEsmGv07CkTzIJPgsSEl/lfcjNhkY+w5iZtBh6tkZKrjEHGU+Kkzt3
 R4tat8IjbtEiRro/WQRvkpEjUio+mf4GLiCTVdWrGJ8q1l7Dr3VG7XNbAL5ggDfatKhNMJYEakm
 Hv1gldQ0weIEkkGeS4nr+VSc+9FvBRdBEmGkDN6PEp0G9Mv2kKs56RFErr7KNO3u96BHR10siq4
 E3pl3bYYm4A4gY2KABLhlyyLCEIrtg
X-Received: by 2002:a05:6808:4fc7:b0:467:1da9:2ae9 with SMTP id
 5614622812f47-4671da93eb8mr1751298b6e.33.1773156859541; 
 Tue, 10 Mar 2026 08:34:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:17 -0500
Subject: [PATCH 04/16] clk: mediatek: mt7629: convert CLK_XTAL to
 CLK_PAD_CLK40M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-4-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10070;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=u7+fYZVOweFPWK7ularWfxCqBN8kOQOkSKL7Wag6Fc0=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmffyXDcPQnhqzpQf7tJ6lb6dGa3i1inPWoI
 nl8ndMlUo+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5nxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYwcH/3UDWbQ0IMTmButA/jj5K8Cy26FyRgMUxW++R0z
 jMUKuAQgJlEvvYS8DB1w32tNvaVlXSj+25nQtOkruAZmSP5Ebd9T56U0/jsn4iGDNZWeIE/2xu6
 QoVLhGo8FJ6brCtRI9s6GynpPsf9VUhT3ZuMEijTFFXp9GR5TKocZ/nXmpwQP1UHrFGiUcSugvb
 Iu+mb74ZTYZst/BngMpM1RzuIDDi3OKREHsIL4gOmlwmLvr5fZJLIH2Zr1G52K2fhFXYDpqFVtr
 X7DUUOlMW4qSccdXOXver5NXfHR/ItW/gMcAjIMYefyT4BDAAoj4xmLP6MVylVCU1R1Svrrv8ed
 HrjM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK40M.

This will eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 92 +++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index beba7fc4abc..74510ee36a9 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -29,10 +29,12 @@
 #define MCU_BUS_SEL(x)			((x) << 9)
 
 enum {
+	CLK_PAD_CLK40M,
 	CLK_PAD_CLK20M,
 };
 
 static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK40M] = 40 * MHZ,
 	[CLK_PAD_CLK20M] = 20 * MHZ,
 };
 
@@ -70,7 +72,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)					\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK40M, CLK_PARENT_EXT, _rate)
 
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -79,7 +81,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
@@ -101,11 +103,11 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_P0_1MHZ, CLK_APMIXED_ETH1PLL, 1, 500),
 	FACTOR0(CLK_TOP_ETH_500M, CLK_APMIXED_ETH1PLL, 1, 1),
 	FACTOR1(CLK_TOP_TXCLK_SRC_PRE, CLK_TOP_SGMIIPLL_D2, 1, 1),
-	FACTOR2(CLK_TOP_RTC, CLK_XTAL, 1, 1024),
-	FACTOR2(CLK_TOP_PWM_QTR_26M, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_CPUM_TCK_IN, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_TO_USB3_DA_TOP, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_MEMPLL, CLK_XTAL, 32, 1),
+	FACTOR2(CLK_TOP_RTC, CLK_PAD_CLK40M, 1, 1024),
+	FACTOR2(CLK_TOP_PWM_QTR_26M, CLK_PAD_CLK40M, 1, 1),
+	FACTOR2(CLK_TOP_CPUM_TCK_IN, CLK_PAD_CLK40M, 1, 1),
+	FACTOR2(CLK_TOP_TO_USB3_DA_TOP, CLK_PAD_CLK40M, 1, 1),
+	FACTOR2(CLK_TOP_MEMPLL, CLK_PAD_CLK40M, 32, 1),
 	FACTOR1(CLK_TOP_DMPLL, CLK_TOP_MEMPLL, 1, 1),
 	FACTOR1(CLK_TOP_DMPLL_D4, CLK_TOP_MEMPLL, 1, 4),
 	FACTOR1(CLK_TOP_DMPLL_D8, CLK_TOP_MEMPLL, 1, 8),
@@ -141,7 +143,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_UNIVPLL_D80_D4, CLK_TOP_UNIVPLL, 1, 320),
 	FACTOR1(CLK_TOP_UNIV48M, CLK_TOP_UNIVPLL, 1, 25),
 	FACTOR0(CLK_TOP_SGMIIPLL_D2, CLK_APMIXED_SGMIPLL, 1, 2),
-	FACTOR2(CLK_TOP_CLKXTAL_D4, CLK_XTAL, 1, 4),
+	FACTOR2(CLK_TOP_CLKXTAL_D4, CLK_PAD_CLK40M, 1, 4),
 	FACTOR1(CLK_TOP_HD_FAXI, CLK_TOP_AXI_SEL, 1, 1),
 	FACTOR1(CLK_TOP_FAXI, CLK_TOP_AXI_SEL, 1, 1),
 	FACTOR1(CLK_TOP_F_FAUD_INTBUS, CLK_TOP_AUD_INTBUS_SEL, 1, 1),
@@ -161,7 +163,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 static const struct mtk_parent axi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -172,17 +174,17 @@ static const struct mtk_parent axi_parents[] = {
 };
 
 static const struct mtk_parent mem_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_DMPLL),
 };
 
 static const struct mtk_parent ddrphycfg_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent eth_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -193,22 +195,22 @@ static const struct mtk_parent eth_parents[] = {
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
 static const struct mtk_parent sgmii_ref_1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SGMIIPLL_D2),
 };
 
 static const struct mtk_parent nfi_infra_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
+	EXT_PARENT(CLK_PAD_CLK40M),
+	EXT_PARENT(CLK_PAD_CLK40M),
+	EXT_PARENT(CLK_PAD_CLK40M),
+	EXT_PARENT(CLK_PAD_CLK40M),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
@@ -222,7 +224,7 @@ static const struct mtk_parent nfi_infra_parents[] = {
 };
 
 static const struct mtk_parent flash_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
@@ -233,40 +235,40 @@ static const struct mtk_parent flash_parents[] = {
 };
 
 static const struct mtk_parent uart_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_parent spi0_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 };
 
 static const struct mtk_parent spi1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 };
 
 static const struct mtk_parent msdc30_0_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 	TOP_PARENT(CLK_TOP_UNIV48M),
 };
 
 static const struct mtk_parent msdc30_1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 	TOP_PARENT(CLK_TOP_UNIV48M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
@@ -277,7 +279,7 @@ static const struct mtk_parent msdc30_1_parents[] = {
 };
 
 static const struct mtk_parent ap2wbmcu_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIV48M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
@@ -288,45 +290,45 @@ static const struct mtk_parent ap2wbmcu_parents[] = {
 };
 
 static const struct mtk_parent audio_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_DMPLL_D4),
 };
 
 static const struct mtk_parent pmicspi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_DMPLL_D8),
 };
 
 static const struct mtk_parent scp_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
 static const struct mtk_parent atb_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
 static const struct mtk_parent hif_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -336,27 +338,27 @@ static const struct mtk_parent hif_parents[] = {
 };
 
 static const struct mtk_parent sata_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
 static const struct mtk_parent usb20_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent aud1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 };
 
 static const struct mtk_parent irrx_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
 static const struct mtk_parent crypto_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
@@ -367,7 +369,7 @@ static const struct mtk_parent crypto_parents[] = {
 };
 
 static const struct mtk_parent gpt10m_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK40M),
 	TOP_PARENT(CLK_TOP_CLKXTAL_D4),
 };
 
@@ -574,7 +576,6 @@ static const struct mtk_gate ssusb_cgs[] = {
 };
 
 static const struct mtk_clk_tree mt7629_clk_tree = {
-	.xtal_rate = 40 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -591,7 +592,6 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
-	.xtal_rate = 40 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),

-- 
2.43.0

