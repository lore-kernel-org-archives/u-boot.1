Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A2FCA19E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4384E83F93;
	Mon,  9 Mar 2026 23:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qdArvHpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA4583CF3; Mon,  9 Mar 2026 23:51:45 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5683F75
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 23:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-463f00cda04so7394948b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773096701; x=1773701501;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nvhQ1WVSZd0KBrjHe4FSBninfUbh6vzyzb5I1JICaqY=;
 b=qdArvHpl2Daio9ee5r5u0YfGj8b3I5l8OVCP9gh5VYHmm/LKCXt/oNTrDKMaw9gn6c
 o79xJUuBAWH2wWXlp2YTjnL73hv14YIX1/5gv32Pv7wCIHz0C/Uom4zS774RvLW0CJmB
 Wgd39xNGRJlBX+wwNyIXiWadJ+pMI2sAU8FKiAd5VHSdvPSTNFrxhMkMAf9vIYqCVXtL
 hchk8/Usb8rWZQXEP1ffZ3XIVHu1jyPTnxP8kzVmsyqKgnY+ELOfTkilmr6Lop6dSAzs
 xoyhDGUH4CrDTvky71gM0qceZU/O3Oo/71PtxXXNVC8cvSxGIr31p+5Zeo7fpSLKkZpM
 t/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773096701; x=1773701501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nvhQ1WVSZd0KBrjHe4FSBninfUbh6vzyzb5I1JICaqY=;
 b=iRtZ+FqpiNY/WUUIzSrvPpcWQe8nMESaFlazpz9ZjfNexXsLhlHi2KwOz5cs7IkVxz
 K4Nb13tWPt+04jjbCFkl78+mCDOklz51pGC7HuuLuqpIFguT5Vskug3wjsDU1A9nLoMt
 UnjHioZ0CTg8amVM9GZf6uCfDczoDJK/4RjHMz+G4tiODE2PggQ6GKOUGscG3goi8MfB
 8G8/6XO4PQIoBJquBe64kIizbayYTvALJGvCysupoOnMJ7+QGQuf7TTvl0VDXDYB6k77
 befRxJHs+OTmdK/Ddh2PoOZR0CoN3BO2W8Zre47TuaLdw1HAfmAuiyNtopD3e70HbSJY
 8fjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBaaVoVrLiKd+B03QxuUQCbPCP0i/+Y1DJn1rPDDe0lnM8kXlTT0u6Q/k9/U+57TP8FGVy84=@lists.denx.de
X-Gm-Message-State: AOJu0YyqA3VxgG1E3jHs9CdDgS0wsVXen2LQnxmionKtd+GM3T1deEmX
 NT7zyE9KSxR0DJ9Z22XhHOuRoosiZnV+ekfCIZ0Q9SyFnq6M2+Z8mqXevRKYlRypiQ8=
X-Gm-Gg: ATEYQzxPiJRuwYfDpeuJ/D17Gh6IWVqzNbhmPOwuzx546eeS/i8RsvQ3SEIgwjphYdO
 o9pd862xnGYgALuYEDIPzZILFNQk4624dJ1qb1/7gGF370/WwyQsx7zCz8VeY3vDrYDODw4rn4R
 OhXVzHqAzjpnjrwm4jerkWf8WqdWEQIwibeYgNn5BSgR1zK69u71q2L79u1O+9ysho6POLNrKLZ
 UxMSyNvlbW/aDsSmqvfe3aZmgI8nonSuwvU/NHiz4CgqrtsUFxJtUOGBAZV+Xfz8SpOGAywWiOT
 L5ejpxa70tk1OAY/hB+ckWuBAN19EXmpT28XJm3i5z8pgSIqIw7BNhEBvLI5yUprpZN8oOUqQ10
 j+Sd0mGNENIhdVI1aPKVhOCCWaGb+y1dDaxsjW8PjDdjdF5fhKQUUnnDMjEczBPHFg6qN6uFD3e
 WgWRbzFnNDqnBBsM7yKjECcByBTCeg
X-Received: by 2002:a05:6808:1794:b0:467:1212:46eb with SMTP id
 5614622812f47-46712124c96mr1863826b6e.35.1773096700983; 
 Mon, 09 Mar 2026 15:51:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3adcsm6150626b6e.17.2026.03.09.15.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:51:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 17:51:11 -0500
Subject: [PATCH 2/2] clk: mediatek: mt8195: use ext_clock_rates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-2-6ee4743a8465@baylibre.com>
References: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
In-Reply-To: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=51727;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=MPmrDanaUW3Ug+hpwr9cxa79EYcuv6qnJhV7ZbfTs38=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpr07yCgFujI3hcgf8sV/T006sfZ7J0k2l4bMHt
 MRoI1Jc4l2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa9O8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aj30H/0bnAuzB3Bx7P6nOeHFLC0vs0ReABRb9KLX2nq1
 zYpS5MgDpiHV4OfjXwEm2GTozSCdOWRaZnPjIvTZv0eLItw8iU9Aez3nX79fBF0PIHX86HPES+H
 OWRQqtHJmSVspRVq4/XHAAJMe544HkZ7/ydAqunnSUyviweWv5VVdFL7LJbH/Mt0+Yk/Q6xFhtd
 f2KPWD1hDSHyuI5PbnRxnU4V9V6lZYiryCJAzPCMtFOo5UsCXLcctu/wok9/ZGHrjfi0CJWt+d4
 En4lllB3zAhl7L7TirS8ZhGr2C0g60KwB/rlSWDhwKNREo7eGXSg+B1O8ogqpY51oJjimt1pC7o
 3tiU=
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

Convert the mt8195 clock driver to use ext_clock_rates.

Now that we have the ext_clock_rates feature and also mux clock parents
have been converted to struct mtk_parent, we can remove the hack of
adding "missing" topckgen clocks. Instead we can use the proper parents.

The topckgen ID map is still needed though because the upstream
dt-bindings didn't use the conventional number ordering by clock type
for these.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 820 +++++++++++++++++++-------------------
 1 file changed, 412 insertions(+), 408 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index fc7b9ff1d8d..76ece913187 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -12,23 +12,20 @@
 
 #include "clk-mtk.h"
 
-#define CLK_TOP_CLK26M		CLK_TOP_NR_CLK
-#define CLK_TOP_CLK32K		CLK_TOP_NR_CLK + 1
-#define CLK_TOP_TVDPLL1		CLK_TOP_NR_CLK + 2
-#define CLK_TOP_TVDPLL2		CLK_TOP_NR_CLK + 3
-#define CLK_TOP_MSDCPLL		CLK_TOP_NR_CLK + 4
-#define CLK_TOP_DGIPLL		CLK_TOP_NR_CLK + 5
-#define CLK_TOP_ADSPPLL		CLK_TOP_NR_CLK + 6
-#define CLK_TOP_IMGPLL		CLK_TOP_NR_CLK + 7
-#define CLK_TOP_VDECPLL		CLK_TOP_NR_CLK + 8
-#define CLK_TOP_NNAPLL		CLK_TOP_NR_CLK + 9
-#define CLK_TOP_HDMIRX_APLL	CLK_TOP_NR_CLK + 10
-#define CLK_TOP_FULL_NR_CLK	CLK_TOP_NR_CLK + 11
-
 #define MT8195_PLL_FMAX		(3800UL * MHZ)
 #define MT8195_PLL_FMIN		(1500UL * MHZ)
 #define MT8195_INTEGER_BITS	8
 
+enum {
+	CLK_PAD_CLK26M,
+	CLK_PAD_CLK32K,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+	[CLK_PAD_CLK32K] = 32000,
+};
+
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags,	\
 	    _rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,\
 	    _pcw_reg, _pcw_shift, _pcw_chg_reg) {	\
@@ -101,6 +98,8 @@ static const struct mtk_pll_data apmixed_plls[] = {
 static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
@@ -121,8 +120,6 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_UFS_RX_SYMBOL1, 166000000),
 	FIXED_CLK0(CLK_TOP_FPC, 50000000),
 	FIXED_CLK0(CLK_TOP_HDMIRX_P, 594000000),
-	FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
-	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 
 #define FACTOR0(_id, _parent, _mult, _div)	\
@@ -131,9 +128,12 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 #define FACTOR1(_id, _parent, _mult, _div)	\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
+#define FACTOR2(_id, _parent, _mult, _div)	\
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
+
 static const struct mtk_fixed_factor top_fixed_divs[] = {
-	FACTOR1(CLK_TOP_CLK26M_D2, CLK_TOP_CLK26M, 1, 2),
-	FACTOR1(CLK_TOP_CLK26M_D52, CLK_TOP_CLK26M, 1, 52),
+	FACTOR2(CLK_TOP_CLK26M_D2, CLK_PAD_CLK26M, 1, 2),
+	FACTOR2(CLK_TOP_CLK26M_D52, CLK_PAD_CLK26M, 1, 52),
 	FACTOR1(CLK_TOP_IN_DGI_D2, CLK_TOP_IN_DGI, 1, 2),
 	FACTOR1(CLK_TOP_IN_DGI_D4, CLK_TOP_IN_DGI, 1, 4),
 	FACTOR1(CLK_TOP_IN_DGI_D6, CLK_TOP_IN_DGI, 1, 6),
@@ -197,43 +197,34 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_MMPLL_D6_D2, CLK_TOP_MMPLL_D6, 1, 2),
 	FACTOR0(CLK_TOP_MMPLL_D7, CLK_APMIXED_MMPLL, 1, 7),
 	FACTOR0(CLK_TOP_MMPLL_D9, CLK_APMIXED_MMPLL, 1, 9),
-	FACTOR0(CLK_TOP_TVDPLL1, CLK_APMIXED_TVDPLL1, 1, 1),
-	FACTOR1(CLK_TOP_TVDPLL1_D2, CLK_TOP_TVDPLL1, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL1_D4, CLK_TOP_TVDPLL1, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL1_D8, CLK_TOP_TVDPLL1, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL1_D16, CLK_TOP_TVDPLL1, 1, 16),
-	FACTOR0(CLK_TOP_TVDPLL2, CLK_APMIXED_TVDPLL2, 1, 1),
-	FACTOR1(CLK_TOP_TVDPLL2_D2, CLK_TOP_TVDPLL2, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL2_D4, CLK_TOP_TVDPLL2, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL2_D8, CLK_TOP_TVDPLL2, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL2_D16, CLK_TOP_TVDPLL2, 1, 16),
-	FACTOR0(CLK_TOP_MSDCPLL, CLK_APMIXED_MSDCPLL, 1, 1),
-	FACTOR1(CLK_TOP_MSDCPLL_D2, CLK_TOP_MSDCPLL, 1, 2),
-	FACTOR1(CLK_TOP_MSDCPLL_D4, CLK_TOP_MSDCPLL, 1, 4),
-	FACTOR1(CLK_TOP_MSDCPLL_D16, CLK_TOP_MSDCPLL, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL1_D2, CLK_APMIXED_TVDPLL1, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL1_D4, CLK_APMIXED_TVDPLL1, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL1_D8, CLK_APMIXED_TVDPLL1, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL1_D16, CLK_APMIXED_TVDPLL1, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL2_D2, CLK_APMIXED_TVDPLL2, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL2_D16, CLK_APMIXED_TVDPLL2, 1, 16),
+	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
+	FACTOR0(CLK_TOP_MSDCPLL_D4, CLK_APMIXED_MSDCPLL, 1, 4),
+	FACTOR0(CLK_TOP_MSDCPLL_D16, CLK_APMIXED_MSDCPLL, 1, 16),
 	FACTOR0(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2),
 	FACTOR0(CLK_TOP_ETHPLL_D8, CLK_APMIXED_ETHPLL, 1, 8),
 	FACTOR0(CLK_TOP_ETHPLL_D10, CLK_APMIXED_ETHPLL, 1, 10),
-	FACTOR0(CLK_TOP_DGIPLL, CLK_APMIXED_DGIPLL, 1, 1),
-	FACTOR1(CLK_TOP_DGIPLL_D2, CLK_TOP_DGIPLL, 1, 2),
+	FACTOR0(CLK_TOP_DGIPLL_D2, CLK_APMIXED_DGIPLL, 1, 2),
 	FACTOR1(CLK_TOP_ULPOSC1_D2, CLK_TOP_ULPOSC1, 1, 2),
 	FACTOR1(CLK_TOP_ULPOSC1_D4, CLK_TOP_ULPOSC1, 1, 4),
 	FACTOR1(CLK_TOP_ULPOSC1_D7, CLK_TOP_ULPOSC1, 1, 7),
 	FACTOR1(CLK_TOP_ULPOSC1_D8, CLK_TOP_ULPOSC1, 1, 8),
 	FACTOR1(CLK_TOP_ULPOSC1_D10, CLK_TOP_ULPOSC1, 1, 10),
 	FACTOR1(CLK_TOP_ULPOSC1_D16, CLK_TOP_ULPOSC1, 1, 16),
-	FACTOR0(CLK_TOP_ADSPPLL, CLK_APMIXED_ADSPPLL, 1, 1),
-	FACTOR1(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPLL, 1, 2),
-	FACTOR1(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPLL, 1, 4),
-	FACTOR1(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPLL, 1, 8),
-	FACTOR0(CLK_TOP_IMGPLL, CLK_APMIXED_IMGPLL, 1, 1),
-	FACTOR0(CLK_TOP_VDECPLL, CLK_APMIXED_VDECPLL, 1, 1),
-	FACTOR0(CLK_TOP_NNAPLL, CLK_APMIXED_NNAPLL, 1, 1),
-	FACTOR0(CLK_TOP_HDMIRX_APLL, CLK_APMIXED_HDMIRX_APLL, 1, 1),
+	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
+	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
+	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
 };
 
 static const struct mtk_parent axi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -243,14 +234,14 @@ static const struct mtk_parent axi_parents[] = {
 };
 
 static const struct mtk_parent spm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
-	TOP_PARENT(CLK_TOP_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK32K),
 };
 
 static const struct mtk_parent scp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
@@ -261,7 +252,7 @@ static const struct mtk_parent scp_parents[] = {
 };
 
 static const struct mtk_parent bus_aximem_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -269,7 +260,7 @@ static const struct mtk_parent bus_aximem_parents[] = {
 };
 
 static const struct mtk_parent vpp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
@@ -280,14 +271,14 @@ static const struct mtk_parent vpp_parents[] = {
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D5),
-	TOP_PARENT(CLK_TOP_TVDPLL1),
-	TOP_PARENT(CLK_TOP_TVDPLL2),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D4),
 };
 
 static const struct mtk_parent ethdr_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
@@ -298,15 +289,15 @@ static const struct mtk_parent ethdr_parents[] = {
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D5_D4),
-	TOP_PARENT(CLK_TOP_TVDPLL1),
-	TOP_PARENT(CLK_TOP_TVDPLL2),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D4),
 };
 
 static const struct mtk_parent ipe_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
@@ -319,7 +310,7 @@ static const struct mtk_parent ipe_parents[] = {
 };
 
 static const struct mtk_parent cam_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
@@ -328,11 +319,11 @@ static const struct mtk_parent cam_parents[] = {
 	TOP_PARENT(CLK_TOP_MMPLL_D7),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 };
 
 static const struct mtk_parent ccu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -345,8 +336,8 @@ static const struct mtk_parent ccu_parents[] = {
 };
 
 static const struct mtk_parent img_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -360,14 +351,14 @@ static const struct mtk_parent img_parents[] = {
 };
 
 static const struct mtk_parent camtm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
 static const struct mtk_parent dsp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -378,7 +369,7 @@ static const struct mtk_parent dsp_parents[] = {
 };
 
 static const struct mtk_parent dsp1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -389,7 +380,7 @@ static const struct mtk_parent dsp1_parents[] = {
 };
 
 static const struct mtk_parent dsp2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -400,7 +391,7 @@ static const struct mtk_parent dsp2_parents[] = {
 };
 
 static const struct mtk_parent ipu_if_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -411,14 +402,14 @@ static const struct mtk_parent ipu_if_parents[] = {
 };
 
 static const struct mtk_parent mfg_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
 static const struct mtk_parent camtg_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
@@ -429,12 +420,12 @@ static const struct mtk_parent camtg_parents[] = {
 };
 
 static const struct mtk_parent uart_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent spi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D4),
@@ -445,7 +436,7 @@ static const struct mtk_parent spi_parents[] = {
 };
 
 static const struct mtk_parent spis_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
@@ -456,14 +447,14 @@ static const struct mtk_parent spis_parents[] = {
 };
 
 static const struct mtk_parent msdc50_0_h_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 };
 
 static const struct mtk_parent msdc50_0_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_MSDCPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
@@ -471,7 +462,7 @@ static const struct mtk_parent msdc50_0_parents[] = {
 };
 
 static const struct mtk_parent msdc30_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
@@ -479,20 +470,20 @@ static const struct mtk_parent msdc30_parents[] = {
 };
 
 static const struct mtk_parent intdir_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 };
 
 static const struct mtk_parent audio_h_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
@@ -500,7 +491,7 @@ static const struct mtk_parent audio_h_parents[] = {
 
 static const struct mtk_parent pwrap_ulposc_parents[] = {
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
@@ -510,13 +501,13 @@ static const struct mtk_parent pwrap_ulposc_parents[] = {
 };
 
 static const struct mtk_parent atb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
 static const struct mtk_parent pwrmcu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -525,7 +516,7 @@ static const struct mtk_parent pwrmcu_parents[] = {
 };
 
 static const struct mtk_parent dp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
@@ -537,7 +528,7 @@ static const struct mtk_parent dp_parents[] = {
 };
 
 static const struct mtk_parent disp_pwm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
@@ -545,20 +536,20 @@ static const struct mtk_parent disp_pwm_parents[] = {
 };
 
 static const struct mtk_parent usb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent i2c_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 };
 
 static const struct mtk_parent seninf_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
@@ -569,7 +560,7 @@ static const struct mtk_parent seninf_parents[] = {
 };
 
 static const struct mtk_parent gcpu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
@@ -577,14 +568,14 @@ static const struct mtk_parent gcpu_parents[] = {
 };
 
 static const struct mtk_parent dxcc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
 };
 
 static const struct mtk_parent dpmaif_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -592,7 +583,7 @@ static const struct mtk_parent dpmaif_parents[] = {
 };
 
 static const struct mtk_parent aes_fde_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
@@ -601,7 +592,7 @@ static const struct mtk_parent aes_fde_parents[] = {
 };
 
 static const struct mtk_parent ufs_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
@@ -612,16 +603,16 @@ static const struct mtk_parent ufs_parents[] = {
 
 static const struct mtk_parent ufs_tick1us_parents[] = {
 	TOP_PARENT(CLK_TOP_CLK26M_D52),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent ufs_mp_sap_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D16),
 };
 
 static const struct mtk_parent venc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
@@ -640,7 +631,7 @@ static const struct mtk_parent venc_parents[] = {
 };
 
 static const struct mtk_parent vdec_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
@@ -648,7 +639,7 @@ static const struct mtk_parent vdec_parents[] = {
 	TOP_PARENT(CLK_TOP_MAINPLL_D5),
 	TOP_PARENT(CLK_TOP_MMPLL_D6),
 	TOP_PARENT(CLK_TOP_MMPLL_D5),
-	TOP_PARENT(CLK_TOP_VDECPLL),
+	APMIXED_PARENT(CLK_APMIXED_VDECPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
@@ -659,51 +650,51 @@ static const struct mtk_parent vdec_parents[] = {
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 };
 
 static const struct mtk_parent mcupm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 };
 
 static const struct mtk_parent spmi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_CLK26M_D2),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
-	TOP_PARENT(CLK_TOP_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK32K),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
 };
 
 static const struct mtk_parent dvfsrc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D16),
 };
 
 static const struct mtk_parent tl_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 };
 
 static const struct mtk_parent dsi_occ_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 };
 
 static const struct mtk_parent wpe_vpp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
@@ -716,69 +707,69 @@ static const struct mtk_parent wpe_vpp_parents[] = {
 	TOP_PARENT(CLK_TOP_MAINPLL_D5),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
-	TOP_PARENT(CLK_TOP_TVDPLL1),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 };
 
 static const struct mtk_parent hdcp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
 static const struct mtk_parent hdcp_24m_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent hd20_dacr_ref_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 };
 
 static const struct mtk_parent hd20_hdcp_c_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent hdmi_xtal_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_CLK26M_D2),
 };
 
 static const struct mtk_parent hdmi_apb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 };
 
 static const struct mtk_parent snps_eth_250m_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D2),
 };
 
 static const struct mtk_parent snps_eth_62p4m_ptp_parents[] = {
 	TOP_PARENT(CLK_TOP_APLL2_D3),
 	TOP_PARENT(CLK_TOP_APLL1_D3),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D8),
 };
 
 static const struct mtk_parent snps_eth_50m_rmii_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D10),
 };
 
 static const struct mtk_parent dgi_out_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_DGIPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_DGIPLL),
 	TOP_PARENT(CLK_TOP_DGIPLL_D2),
 	TOP_PARENT(CLK_TOP_IN_DGI),
 	TOP_PARENT(CLK_TOP_IN_DGI_D2),
@@ -786,8 +777,8 @@ static const struct mtk_parent dgi_out_parents[] = {
 };
 
 static const struct mtk_parent nna_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_NNAPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_NNAPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -801,7 +792,7 @@ static const struct mtk_parent nna_parents[] = {
 };
 
 static const struct mtk_parent adsp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_CLK26M_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -809,66 +800,66 @@ static const struct mtk_parent adsp_parents[] = {
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_ULPOSC1),
-	TOP_PARENT(CLK_TOP_ADSPPLL),
+	APMIXED_PARENT(CLK_APMIXED_ADSPPLL),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D2),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D4),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D8),
 };
 
 static const struct mtk_parent asm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
 static const struct mtk_parent apll1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
 static const struct mtk_parent apll2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
 static const struct mtk_parent apll3_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL3_D4),
 };
 
 static const struct mtk_parent apll4_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL4_D4),
 };
 
 static const struct mtk_parent apll5_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
 static const struct mtk_parent i2s_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
 	TOP_PARENT(CLK_TOP_APLL4),
 	TOP_PARENT(CLK_TOP_APLL5),
-	TOP_PARENT(CLK_TOP_HDMIRX_APLL),
+	APMIXED_PARENT(CLK_APMIXED_HDMIRX_APLL),
 };
 
 static const struct mtk_parent a1sys_hp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
 static const struct mtk_parent a2sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
 static const struct mtk_parent a3sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL3_D4),
 	TOP_PARENT(CLK_TOP_APLL4_D4),
 	TOP_PARENT(CLK_TOP_APLL5_D4),
@@ -878,7 +869,7 @@ static const struct mtk_parent a3sys_parents[] = {
 };
 
 static const struct mtk_parent spinfi_b_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
@@ -889,7 +880,7 @@ static const struct mtk_parent spinfi_b_parents[] = {
 };
 
 static const struct mtk_parent nfi1x_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
@@ -900,7 +891,7 @@ static const struct mtk_parent nfi1x_parents[] = {
 };
 
 static const struct mtk_parent ecc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -909,7 +900,7 @@ static const struct mtk_parent ecc_parents[] = {
 };
 
 static const struct mtk_parent audio_local_bus_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_CLK26M_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
@@ -924,14 +915,14 @@ static const struct mtk_parent audio_local_bus_parents[] = {
 };
 
 static const struct mtk_parent spinor_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_CLK26M_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent dvio_dgi_ref_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_IN_DGI),
 	TOP_PARENT(CLK_TOP_IN_DGI_D2),
 	TOP_PARENT(CLK_TOP_IN_DGI_D4),
@@ -956,7 +947,7 @@ static const struct mtk_parent ulposc_core_parents[] = {
 
 static const struct mtk_parent srck_parents[] = {
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_composite top_muxes[] = {
@@ -1133,9 +1124,13 @@ static const struct mtk_gate_regs top1_cg_regs = {
 	GATE_FLAGS(_id, _parent, &top0_cg_regs, _shift,	\
 		CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN)
 
+#define GATE_TOP0E(_id, _parent, _shift)		\
+	GATE_FLAGS(_id, _parent, &top0_cg_regs, _shift,	\
+		CLK_GATE_NO_SETCLR_INV | CLK_PARENT_EXT)
+
 #define GATE_TOP1(_id, _parent, _shift)			\
 	GATE_FLAGS(_id, _parent, &top1_cg_regs, _shift, \
-		CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN)
+		CLK_GATE_NO_SETCLR_INV | CLK_PARENT_EXT)
 
 static const struct mtk_gate top_cg_clks[] = {
 	/* TOP0 */
@@ -1144,9 +1139,9 @@ static const struct mtk_gate top_cg_clks[] = {
 	GATE_TOP0(CLK_TOP_CFG_VDO0, CLK_TOP_VPP, 2),
 	GATE_TOP0(CLK_TOP_CFG_VDO1, CLK_TOP_VPP, 3),
 	GATE_TOP0(CLK_TOP_CFG_UNIPLL_SES, CLK_TOP_UNIVPLL_D2, 4),
-	GATE_TOP0(CLK_TOP_CFG_26M_VPP0, CLK_TOP_CLK26M, 5),
-	GATE_TOP0(CLK_TOP_CFG_26M_VPP1, CLK_TOP_CLK26M, 6),
-	GATE_TOP0(CLK_TOP_CFG_26M_AUD, CLK_TOP_CLK26M, 9),
+	GATE_TOP0E(CLK_TOP_CFG_26M_VPP0, CLK_PAD_CLK26M, 5),
+	GATE_TOP0E(CLK_TOP_CFG_26M_VPP1, CLK_PAD_CLK26M, 6),
+	GATE_TOP0E(CLK_TOP_CFG_26M_AUD, CLK_PAD_CLK26M, 9),
 	/*
 	 * cfg_axi_east, cfg_axi_east_north, cfg_axi_north and cfg_axi_south
 	 * are peripheral bus clock branches.
@@ -1157,275 +1152,266 @@ static const struct mtk_gate top_cg_clks[] = {
 	GATE_TOP0(CLK_TOP_CFG_AXI_SOUTH, CLK_TOP_AXI, 13),
 	GATE_TOP0(CLK_TOP_CFG_EXT_TEST, CLK_TOP_MSDCPLL_D2, 15),
 	/* TOP1 */
-	GATE_TOP1(CLK_TOP_SSUSB_REF, CLK_TOP_CLK26M, 0),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_TOP_CLK26M, 1),
-	GATE_TOP1(CLK_TOP_SSUSB_P1_REF, CLK_TOP_CLK26M, 2),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_TOP_CLK26M, 3),
-	GATE_TOP1(CLK_TOP_SSUSB_P2_REF, CLK_TOP_CLK26M, 4),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_TOP_CLK26M, 5),
-	GATE_TOP1(CLK_TOP_SSUSB_P3_REF, CLK_TOP_CLK26M, 6),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_TOP_CLK26M, 7),
+	GATE_TOP1(CLK_TOP_SSUSB_REF, CLK_PAD_CLK26M, 0),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_PAD_CLK26M, 1),
+	GATE_TOP1(CLK_TOP_SSUSB_P1_REF, CLK_PAD_CLK26M, 2),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_PAD_CLK26M, 3),
+	GATE_TOP1(CLK_TOP_SSUSB_P2_REF, CLK_PAD_CLK26M, 4),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_PAD_CLK26M, 5),
+	GATE_TOP1(CLK_TOP_SSUSB_P3_REF, CLK_PAD_CLK26M, 6),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_PAD_CLK26M, 7),
 };
 
 static const int mt8195_id_top_offs_map[] = {
-	[0 ... CLK_TOP_FULL_NR_CLK] = -1,
+	[0 ... CLK_TOP_NR_CLK - 1] = -1,
 	/* FIXED */
-	[CLK_TOP_IN_DGI]  = 0,
-	[CLK_TOP_ULPOSC1]  = 1,
-	[CLK_TOP_ULPOSC2]  = 2,
-	[CLK_TOP_MEM_466M]  = 3,
-	[CLK_TOP_MPHONE_SLAVE_B]  = 4,
-	[CLK_TOP_PEXTP_PIPE]  = 5,
-	[CLK_TOP_UFS_RX_SYMBOL]  = 6,
-	[CLK_TOP_UFS_TX_SYMBOL]  = 7,
-	[CLK_TOP_SSUSB_U3PHY_P1_P_P0]  = 8,
-	[CLK_TOP_UFS_RX_SYMBOL1]  = 9,
-	[CLK_TOP_FPC]  = 10,
-	[CLK_TOP_HDMIRX_P]  = 11,
-	[CLK_TOP_CLK26M]  = 12,
-	[CLK_TOP_CLK32K]   = 13,
+	[CLK_TOP_IN_DGI] = 0,
+	[CLK_TOP_ULPOSC1] = 1,
+	[CLK_TOP_ULPOSC2] = 2,
+	[CLK_TOP_MEM_466M] = 3,
+	[CLK_TOP_MPHONE_SLAVE_B] = 4,
+	[CLK_TOP_PEXTP_PIPE] = 5,
+	[CLK_TOP_UFS_RX_SYMBOL] = 6,
+	[CLK_TOP_UFS_TX_SYMBOL] = 7,
+	[CLK_TOP_SSUSB_U3PHY_P1_P_P0] = 8,
+	[CLK_TOP_UFS_RX_SYMBOL1] = 9,
+	[CLK_TOP_FPC] = 10,
+	[CLK_TOP_HDMIRX_P] = 11,
 	/* FACTOR */
-	[CLK_TOP_CLK26M_D2]   = 14,
-	[CLK_TOP_CLK26M_D52]  = 15,
-	[CLK_TOP_IN_DGI_D2]  = 16,
-	[CLK_TOP_IN_DGI_D4]  = 17,
-	[CLK_TOP_IN_DGI_D6]  = 18,
-	[CLK_TOP_IN_DGI_D8]  = 19,
-	[CLK_TOP_MAINPLL_D3]  = 20,
-	[CLK_TOP_MAINPLL_D4]  = 21,
-	[CLK_TOP_MAINPLL_D4_D2]  = 22,
-	[CLK_TOP_MAINPLL_D4_D4]  = 23,
-	[CLK_TOP_MAINPLL_D4_D8]  = 24,
-	[CLK_TOP_MAINPLL_D5]  = 25,
-	[CLK_TOP_MAINPLL_D5_D2]  = 26,
-	[CLK_TOP_MAINPLL_D5_D4]  = 27,
-	[CLK_TOP_MAINPLL_D5_D8]  = 28,
-	[CLK_TOP_MAINPLL_D6]  = 29,
-	[CLK_TOP_MAINPLL_D6_D2]  = 30,
-	[CLK_TOP_MAINPLL_D6_D4]  = 31,
-	[CLK_TOP_MAINPLL_D6_D8]  = 32,
-	[CLK_TOP_MAINPLL_D7]  = 33,
-	[CLK_TOP_MAINPLL_D7_D2]  = 34,
-	[CLK_TOP_MAINPLL_D7_D4]  = 35,
-	[CLK_TOP_MAINPLL_D7_D8]  = 36,
-	[CLK_TOP_MAINPLL_D9]  = 37,
-	[CLK_TOP_UNIVPLL_D2]  = 38,
-	[CLK_TOP_UNIVPLL_D3]  = 39,
-	[CLK_TOP_UNIVPLL_D4]  = 40,
-	[CLK_TOP_UNIVPLL_D4_D2]  = 41,
-	[CLK_TOP_UNIVPLL_D4_D4]  = 42,
-	[CLK_TOP_UNIVPLL_D4_D8]  = 43,
-	[CLK_TOP_UNIVPLL_D5]  = 44,
-	[CLK_TOP_UNIVPLL_D5_D2]  = 45,
-	[CLK_TOP_UNIVPLL_D5_D4]  = 46,
-	[CLK_TOP_UNIVPLL_D5_D8]  = 47,
-	[CLK_TOP_UNIVPLL_D6]  = 48,
-	[CLK_TOP_UNIVPLL_D6_D2]  = 49,
-	[CLK_TOP_UNIVPLL_D6_D4]  = 50,
-	[CLK_TOP_UNIVPLL_D6_D8]  = 51,
-	[CLK_TOP_UNIVPLL_D6_D16]  = 52,
-	[CLK_TOP_UNIVPLL_D7]  = 53,
-	[CLK_TOP_UNIVPLL_192M]  = 54,
-	[CLK_TOP_UNIVPLL_192M_D4]  = 55,
-	[CLK_TOP_UNIVPLL_192M_D8]  = 56,
-	[CLK_TOP_UNIVPLL_192M_D16]  = 57,
-	[CLK_TOP_UNIVPLL_192M_D32]  = 58,
-	[CLK_TOP_APLL1_D3]  = 59,
-	[CLK_TOP_APLL1_D4]  = 60,
-	[CLK_TOP_APLL2_D3]  = 61,
-	[CLK_TOP_APLL2_D4]  = 62,
-	[CLK_TOP_APLL3_D4]  = 63,
-	[CLK_TOP_APLL4_D4]  = 64,
-	[CLK_TOP_APLL5_D4]  = 65,
-	[CLK_TOP_HDMIRX_APLL_D3]  = 66,
-	[CLK_TOP_HDMIRX_APLL_D4]  = 67,
-	[CLK_TOP_HDMIRX_APLL_D6]  = 68,
-	[CLK_TOP_MMPLL_D4]  = 69,
-	[CLK_TOP_MMPLL_D4_D2]  = 70,
-	[CLK_TOP_MMPLL_D4_D4]  = 71,
-	[CLK_TOP_MMPLL_D5]  = 72,
-	[CLK_TOP_MMPLL_D5_D2]  = 73,
-	[CLK_TOP_MMPLL_D5_D4]  = 74,
-	[CLK_TOP_MMPLL_D6]  = 75,
-	[CLK_TOP_MMPLL_D6_D2]  = 76,
-	[CLK_TOP_MMPLL_D7]  = 77,
-	[CLK_TOP_MMPLL_D9]  = 78,
-	[CLK_TOP_TVDPLL1]  = 79,
-	[CLK_TOP_TVDPLL1_D2]  = 80,
-	[CLK_TOP_TVDPLL1_D4]  = 81,
-	[CLK_TOP_TVDPLL1_D8]  = 82,
-	[CLK_TOP_TVDPLL1_D16]  = 83,
-	[CLK_TOP_TVDPLL2]  = 84,
-	[CLK_TOP_TVDPLL2_D2]  = 85,
-	[CLK_TOP_TVDPLL2_D4]  = 86,
-	[CLK_TOP_TVDPLL2_D8]  = 87,
-	[CLK_TOP_TVDPLL2_D16]  = 88,
-	[CLK_TOP_MSDCPLL]  = 89,
-	[CLK_TOP_MSDCPLL_D2]  = 90,
-	[CLK_TOP_MSDCPLL_D4]  = 91,
-	[CLK_TOP_MSDCPLL_D16]  = 92,
-	[CLK_TOP_ETHPLL_D2]  = 93,
-	[CLK_TOP_ETHPLL_D8]  = 94,
-	[CLK_TOP_ETHPLL_D10]  = 95,
-	[CLK_TOP_DGIPLL]  = 96,
-	[CLK_TOP_DGIPLL_D2]  = 97,
-	[CLK_TOP_ULPOSC1_D2]  = 98,
-	[CLK_TOP_ULPOSC1_D4]  = 99,
-	[CLK_TOP_ULPOSC1_D7]  = 100,
-	[CLK_TOP_ULPOSC1_D8]  = 101,
-	[CLK_TOP_ULPOSC1_D10]  = 102,
-	[CLK_TOP_ULPOSC1_D16]  = 103,
-	[CLK_TOP_ADSPPLL]  = 104,
-	[CLK_TOP_ADSPPLL_D2]  = 105,
-	[CLK_TOP_ADSPPLL_D4]  = 106,
-	[CLK_TOP_ADSPPLL_D8]  = 107,
-	[CLK_TOP_IMGPLL]  = 108,
-	[CLK_TOP_VDECPLL]  = 109,
-	[CLK_TOP_NNAPLL]  = 110,
-	[CLK_TOP_HDMIRX_APLL]  = 111,
+	[CLK_TOP_CLK26M_D2] = 12,
+	[CLK_TOP_CLK26M_D52] = 13,
+	[CLK_TOP_IN_DGI_D2] = 14,
+	[CLK_TOP_IN_DGI_D4] = 15,
+	[CLK_TOP_IN_DGI_D6] = 16,
+	[CLK_TOP_IN_DGI_D8] = 17,
+	[CLK_TOP_MAINPLL_D3] = 18,
+	[CLK_TOP_MAINPLL_D4] = 19,
+	[CLK_TOP_MAINPLL_D4_D2] = 20,
+	[CLK_TOP_MAINPLL_D4_D4] = 21,
+	[CLK_TOP_MAINPLL_D4_D8] = 22,
+	[CLK_TOP_MAINPLL_D5] = 23,
+	[CLK_TOP_MAINPLL_D5_D2] = 24,
+	[CLK_TOP_MAINPLL_D5_D4] = 25,
+	[CLK_TOP_MAINPLL_D5_D8] = 26,
+	[CLK_TOP_MAINPLL_D6] = 27,
+	[CLK_TOP_MAINPLL_D6_D2] = 28,
+	[CLK_TOP_MAINPLL_D6_D4] = 29,
+	[CLK_TOP_MAINPLL_D6_D8] = 30,
+	[CLK_TOP_MAINPLL_D7] = 31,
+	[CLK_TOP_MAINPLL_D7_D2] = 32,
+	[CLK_TOP_MAINPLL_D7_D4] = 33,
+	[CLK_TOP_MAINPLL_D7_D8] = 34,
+	[CLK_TOP_MAINPLL_D9] = 35,
+	[CLK_TOP_UNIVPLL_D2] = 36,
+	[CLK_TOP_UNIVPLL_D3] = 37,
+	[CLK_TOP_UNIVPLL_D4] = 38,
+	[CLK_TOP_UNIVPLL_D4_D2] = 39,
+	[CLK_TOP_UNIVPLL_D4_D4] = 40,
+	[CLK_TOP_UNIVPLL_D4_D8] = 41,
+	[CLK_TOP_UNIVPLL_D5] = 42,
+	[CLK_TOP_UNIVPLL_D5_D2] = 43,
+	[CLK_TOP_UNIVPLL_D5_D4] = 44,
+	[CLK_TOP_UNIVPLL_D5_D8] = 45,
+	[CLK_TOP_UNIVPLL_D6] = 46,
+	[CLK_TOP_UNIVPLL_D6_D2] = 47,
+	[CLK_TOP_UNIVPLL_D6_D4] = 48,
+	[CLK_TOP_UNIVPLL_D6_D8] = 49,
+	[CLK_TOP_UNIVPLL_D6_D16] = 50,
+	[CLK_TOP_UNIVPLL_D7] = 51,
+	[CLK_TOP_UNIVPLL_192M] = 52,
+	[CLK_TOP_UNIVPLL_192M_D4] = 53,
+	[CLK_TOP_UNIVPLL_192M_D8] = 54,
+	[CLK_TOP_UNIVPLL_192M_D16] = 55,
+	[CLK_TOP_UNIVPLL_192M_D32] = 56,
+	[CLK_TOP_APLL1_D3] = 57,
+	[CLK_TOP_APLL1_D4] = 58,
+	[CLK_TOP_APLL2_D3] = 59,
+	[CLK_TOP_APLL2_D4] = 60,
+	[CLK_TOP_APLL3_D4] = 61,
+	[CLK_TOP_APLL4_D4] = 62,
+	[CLK_TOP_APLL5_D4] = 63,
+	[CLK_TOP_HDMIRX_APLL_D3] = 64,
+	[CLK_TOP_HDMIRX_APLL_D4] = 65,
+	[CLK_TOP_HDMIRX_APLL_D6] = 66,
+	[CLK_TOP_MMPLL_D4] = 67,
+	[CLK_TOP_MMPLL_D4_D2] = 68,
+	[CLK_TOP_MMPLL_D4_D4] = 69,
+	[CLK_TOP_MMPLL_D5] = 70,
+	[CLK_TOP_MMPLL_D5_D2] = 71,
+	[CLK_TOP_MMPLL_D5_D4] = 72,
+	[CLK_TOP_MMPLL_D6] = 73,
+	[CLK_TOP_MMPLL_D6_D2] = 74,
+	[CLK_TOP_MMPLL_D7] = 75,
+	[CLK_TOP_MMPLL_D9] = 76,
+	[CLK_TOP_TVDPLL1_D2] = 77,
+	[CLK_TOP_TVDPLL1_D4] = 78,
+	[CLK_TOP_TVDPLL1_D8] = 79,
+	[CLK_TOP_TVDPLL1_D16] = 80,
+	[CLK_TOP_TVDPLL2_D2] = 81,
+	[CLK_TOP_TVDPLL2_D4] = 82,
+	[CLK_TOP_TVDPLL2_D8] = 83,
+	[CLK_TOP_TVDPLL2_D16] = 84,
+	[CLK_TOP_MSDCPLL_D2] = 85,
+	[CLK_TOP_MSDCPLL_D4] = 86,
+	[CLK_TOP_MSDCPLL_D16] = 87,
+	[CLK_TOP_ETHPLL_D2] = 88,
+	[CLK_TOP_ETHPLL_D8] = 89,
+	[CLK_TOP_ETHPLL_D10] = 90,
+	[CLK_TOP_DGIPLL_D2] = 91,
+	[CLK_TOP_ULPOSC1_D2] = 92,
+	[CLK_TOP_ULPOSC1_D4] = 93,
+	[CLK_TOP_ULPOSC1_D7] = 94,
+	[CLK_TOP_ULPOSC1_D8] = 95,
+	[CLK_TOP_ULPOSC1_D10] = 96,
+	[CLK_TOP_ULPOSC1_D16] = 97,
+	[CLK_TOP_ADSPPLL_D2] = 98,
+	[CLK_TOP_ADSPPLL_D4] = 99,
+	[CLK_TOP_ADSPPLL_D8] = 100,
 	/* MUX */
-	[CLK_TOP_AXI] = 112,
-	[CLK_TOP_SPM] = 113,
-	[CLK_TOP_SCP] = 114,
-	[CLK_TOP_BUS_AXIMEM] = 115,
-	[CLK_TOP_VPP] = 116,
-	[CLK_TOP_ETHDR] = 117,
-	[CLK_TOP_IPE] = 118,
-	[CLK_TOP_CAM] = 119,
-	[CLK_TOP_CCU] = 120,
-	[CLK_TOP_IMG] = 121,
-	[CLK_TOP_CAMTM] = 122,
-	[CLK_TOP_DSP] = 123,
-	[CLK_TOP_DSP1] = 124,
-	[CLK_TOP_DSP2] = 125,
-	[CLK_TOP_DSP3] = 126,
-	[CLK_TOP_DSP4] = 127,
-	[CLK_TOP_DSP5] = 128,
-	[CLK_TOP_DSP6] = 129,
-	[CLK_TOP_DSP7] = 130,
-	[CLK_TOP_IPU_IF] = 131,
-	[CLK_TOP_MFG_CORE_TMP] = 132,
-	[CLK_TOP_CAMTG] = 133,
-	[CLK_TOP_CAMTG2] = 134,
-	[CLK_TOP_CAMTG3] = 135,
-	[CLK_TOP_CAMTG4] = 136,
-	[CLK_TOP_CAMTG5] = 137,
-	[CLK_TOP_UART] = 138,
-	[CLK_TOP_SPI] = 139,
-	[CLK_TOP_SPIS] = 140,
-	[CLK_TOP_MSDC50_0_HCLK] = 141,
-	[CLK_TOP_MSDC50_0] = 142,
-	[CLK_TOP_MSDC30_1] = 143,
-	[CLK_TOP_MSDC30_2] = 144,
-	[CLK_TOP_INTDIR] = 145,
-	[CLK_TOP_AUD_INTBUS] = 146,
-	[CLK_TOP_AUDIO_H] = 147,
-	[CLK_TOP_PWRAP_ULPOSC] = 148,
-	[CLK_TOP_ATB] = 149,
-	[CLK_TOP_PWRMCU] = 150,
-	[CLK_TOP_DP] = 151,
-	[CLK_TOP_EDP] = 152,
-	[CLK_TOP_DPI] = 153,
-	[CLK_TOP_DISP_PWM0] = 154,
-	[CLK_TOP_DISP_PWM1] = 155,
-	[CLK_TOP_USB_TOP] = 156,
-	[CLK_TOP_SSUSB_XHCI] = 157,
-	[CLK_TOP_USB_TOP_1P] = 158,
-	[CLK_TOP_SSUSB_XHCI_1P] = 159,
-	[CLK_TOP_USB_TOP_2P] = 160,
-	[CLK_TOP_SSUSB_XHCI_2P] = 161,
-	[CLK_TOP_USB_TOP_3P] = 162,
-	[CLK_TOP_SSUSB_XHCI_3P] = 163,
-	[CLK_TOP_I2C] = 164,
-	[CLK_TOP_SENINF] = 165,
-	[CLK_TOP_SENINF1] = 166,
-	[CLK_TOP_SENINF2] = 167,
-	[CLK_TOP_SENINF3] = 168,
-	[CLK_TOP_GCPU] = 169,
-	[CLK_TOP_DXCC] = 170,
-	[CLK_TOP_DPMAIF_MAIN] = 171,
-	[CLK_TOP_AES_UFSFDE] = 172,
-	[CLK_TOP_UFS] = 173,
-	[CLK_TOP_UFS_TICK1US] = 174,
-	[CLK_TOP_UFS_MP_SAP_CFG] = 175,
-	[CLK_TOP_VENC] = 176,
-	[CLK_TOP_VDEC] = 177,
-	[CLK_TOP_PWM] = 178,
-	[CLK_TOP_MCUPM] = 179,
-	[CLK_TOP_SPMI_P_MST] = 180,
-	[CLK_TOP_SPMI_M_MST] = 181,
-	[CLK_TOP_DVFSRC] = 182,
-	[CLK_TOP_TL] = 183,
-	[CLK_TOP_TL_P1] = 184,
-	[CLK_TOP_AES_MSDCFDE] = 185,
-	[CLK_TOP_DSI_OCC] = 186,
-	[CLK_TOP_WPE_VPP] = 187,
-	[CLK_TOP_HDCP] = 188,
-	[CLK_TOP_HDCP_24M] = 189,
-	[CLK_TOP_HD20_DACR_REF_CLK] = 190,
-	[CLK_TOP_HD20_HDCP_CCLK] = 191,
-	[CLK_TOP_HDMI_XTAL] = 192,
-	[CLK_TOP_HDMI_APB] = 193,
-	[CLK_TOP_SNPS_ETH_250M] = 194,
-	[CLK_TOP_SNPS_ETH_62P4M_PTP] = 195,
-	[CLK_TOP_SNPS_ETH_50M_RMII] = 196,
-	[CLK_TOP_DGI_OUT] = 197,
-	[CLK_TOP_NNA0] = 198,
-	[CLK_TOP_NNA1] = 199,
-	[CLK_TOP_ADSP] = 200,
-	[CLK_TOP_ASM_H] = 201,
-	[CLK_TOP_ASM_M] = 202,
-	[CLK_TOP_ASM_L] = 203,
-	[CLK_TOP_APLL1] = 204,
-	[CLK_TOP_APLL2] = 205,
-	[CLK_TOP_APLL3] = 206,
-	[CLK_TOP_APLL4] = 207,
-	[CLK_TOP_APLL5] = 208,
-	[CLK_TOP_I2SO1_MCK] = 209,
-	[CLK_TOP_I2SO2_MCK] = 210,
-	[CLK_TOP_I2SI1_MCK] = 211,
-	[CLK_TOP_I2SI2_MCK] = 212,
-	[CLK_TOP_DPTX_MCK] = 213,
-	[CLK_TOP_AUD_IEC_CLK] = 214,
-	[CLK_TOP_A1SYS_HP] = 215,
-	[CLK_TOP_A2SYS_HF] = 216,
-	[CLK_TOP_A3SYS_HF] = 217,
-	[CLK_TOP_A4SYS_HF] = 218,
-	[CLK_TOP_SPINFI_BCLK] = 219,
-	[CLK_TOP_NFI1X] = 220,
-	[CLK_TOP_ECC] = 221,
-	[CLK_TOP_AUDIO_LOCAL_BUS] = 222,
-	[CLK_TOP_SPINOR] = 223,
-	[CLK_TOP_DVIO_DGI_REF] = 224,
-	[CLK_TOP_ULPOSC] = 225,
-	[CLK_TOP_ULPOSC_CORE] = 226,
-	[CLK_TOP_SRCK] = 227,
+	[CLK_TOP_AXI] = 101,
+	[CLK_TOP_SPM] = 102,
+	[CLK_TOP_SCP] = 103,
+	[CLK_TOP_BUS_AXIMEM] = 104,
+	[CLK_TOP_VPP] = 105,
+	[CLK_TOP_ETHDR] = 106,
+	[CLK_TOP_IPE] = 107,
+	[CLK_TOP_CAM] = 108,
+	[CLK_TOP_CCU] = 109,
+	[CLK_TOP_IMG] = 110,
+	[CLK_TOP_CAMTM] = 111,
+	[CLK_TOP_DSP] = 112,
+	[CLK_TOP_DSP1] = 113,
+	[CLK_TOP_DSP2] = 114,
+	[CLK_TOP_DSP3] = 115,
+	[CLK_TOP_DSP4] = 116,
+	[CLK_TOP_DSP5] = 117,
+	[CLK_TOP_DSP6] = 118,
+	[CLK_TOP_DSP7] = 119,
+	[CLK_TOP_IPU_IF] = 120,
+	[CLK_TOP_MFG_CORE_TMP] = 121,
+	[CLK_TOP_CAMTG] = 122,
+	[CLK_TOP_CAMTG2] = 123,
+	[CLK_TOP_CAMTG3] = 124,
+	[CLK_TOP_CAMTG4] = 125,
+	[CLK_TOP_CAMTG5] = 126,
+	[CLK_TOP_UART] = 127,
+	[CLK_TOP_SPI] = 128,
+	[CLK_TOP_SPIS] = 129,
+	[CLK_TOP_MSDC50_0_HCLK] = 130,
+	[CLK_TOP_MSDC50_0] = 131,
+	[CLK_TOP_MSDC30_1] = 132,
+	[CLK_TOP_MSDC30_2] = 133,
+	[CLK_TOP_INTDIR] = 134,
+	[CLK_TOP_AUD_INTBUS] = 135,
+	[CLK_TOP_AUDIO_H] = 136,
+	[CLK_TOP_PWRAP_ULPOSC] = 137,
+	[CLK_TOP_ATB] = 138,
+	[CLK_TOP_PWRMCU] = 139,
+	[CLK_TOP_DP] = 140,
+	[CLK_TOP_EDP] = 141,
+	[CLK_TOP_DPI] = 142,
+	[CLK_TOP_DISP_PWM0] = 143,
+	[CLK_TOP_DISP_PWM1] = 144,
+	[CLK_TOP_USB_TOP] = 145,
+	[CLK_TOP_SSUSB_XHCI] = 146,
+	[CLK_TOP_USB_TOP_1P] = 147,
+	[CLK_TOP_SSUSB_XHCI_1P] = 148,
+	[CLK_TOP_USB_TOP_2P] = 149,
+	[CLK_TOP_SSUSB_XHCI_2P] = 150,
+	[CLK_TOP_USB_TOP_3P] = 151,
+	[CLK_TOP_SSUSB_XHCI_3P] = 152,
+	[CLK_TOP_I2C] = 153,
+	[CLK_TOP_SENINF] = 154,
+	[CLK_TOP_SENINF1] = 155,
+	[CLK_TOP_SENINF2] = 156,
+	[CLK_TOP_SENINF3] = 157,
+	[CLK_TOP_GCPU] = 158,
+	[CLK_TOP_DXCC] = 159,
+	[CLK_TOP_DPMAIF_MAIN] = 160,
+	[CLK_TOP_AES_UFSFDE] = 161,
+	[CLK_TOP_UFS] = 162,
+	[CLK_TOP_UFS_TICK1US] = 163,
+	[CLK_TOP_UFS_MP_SAP_CFG] = 164,
+	[CLK_TOP_VENC] = 165,
+	[CLK_TOP_VDEC] = 166,
+	[CLK_TOP_PWM] = 167,
+	[CLK_TOP_MCUPM] = 168,
+	[CLK_TOP_SPMI_P_MST] = 169,
+	[CLK_TOP_SPMI_M_MST] = 170,
+	[CLK_TOP_DVFSRC] = 171,
+	[CLK_TOP_TL] = 172,
+	[CLK_TOP_TL_P1] = 173,
+	[CLK_TOP_AES_MSDCFDE] = 174,
+	[CLK_TOP_DSI_OCC] = 175,
+	[CLK_TOP_WPE_VPP] = 176,
+	[CLK_TOP_HDCP] = 177,
+	[CLK_TOP_HDCP_24M] = 178,
+	[CLK_TOP_HD20_DACR_REF_CLK] = 179,
+	[CLK_TOP_HD20_HDCP_CCLK] = 180,
+	[CLK_TOP_HDMI_XTAL] = 181,
+	[CLK_TOP_HDMI_APB] = 182,
+	[CLK_TOP_SNPS_ETH_250M] = 183,
+	[CLK_TOP_SNPS_ETH_62P4M_PTP] = 184,
+	[CLK_TOP_SNPS_ETH_50M_RMII] = 185,
+	[CLK_TOP_DGI_OUT] = 186,
+	[CLK_TOP_NNA0] = 187,
+	[CLK_TOP_NNA1] = 188,
+	[CLK_TOP_ADSP] = 189,
+	[CLK_TOP_ASM_H] = 190,
+	[CLK_TOP_ASM_M] = 191,
+	[CLK_TOP_ASM_L] = 192,
+	[CLK_TOP_APLL1] = 193,
+	[CLK_TOP_APLL2] = 194,
+	[CLK_TOP_APLL3] = 195,
+	[CLK_TOP_APLL4] = 196,
+	[CLK_TOP_APLL5] = 197,
+	[CLK_TOP_I2SO1_MCK] = 198,
+	[CLK_TOP_I2SO2_MCK] = 199,
+	[CLK_TOP_I2SI1_MCK] = 200,
+	[CLK_TOP_I2SI2_MCK] = 201,
+	[CLK_TOP_DPTX_MCK] = 202,
+	[CLK_TOP_AUD_IEC_CLK] = 203,
+	[CLK_TOP_A1SYS_HP] = 204,
+	[CLK_TOP_A2SYS_HF] = 205,
+	[CLK_TOP_A3SYS_HF] = 206,
+	[CLK_TOP_A4SYS_HF] = 207,
+	[CLK_TOP_SPINFI_BCLK] = 208,
+	[CLK_TOP_NFI1X] = 209,
+	[CLK_TOP_ECC] = 210,
+	[CLK_TOP_AUDIO_LOCAL_BUS] = 211,
+	[CLK_TOP_SPINOR] = 212,
+	[CLK_TOP_DVIO_DGI_REF] = 213,
+	[CLK_TOP_ULPOSC] = 214,
+	[CLK_TOP_ULPOSC_CORE] = 215,
+	[CLK_TOP_SRCK] = 216,
 	/* GATE */
-	[CLK_TOP_CFG_VPP0] = 228,
-	[CLK_TOP_CFG_VPP1] = 229,
-	[CLK_TOP_CFG_VDO0] = 230,
-	[CLK_TOP_CFG_VDO1] = 231,
-	[CLK_TOP_CFG_UNIPLL_SES] = 232,
-	[CLK_TOP_CFG_26M_VPP0] = 233,
-	[CLK_TOP_CFG_26M_VPP1] = 234,
-	[CLK_TOP_CFG_26M_AUD] = 235,
-	[CLK_TOP_CFG_AXI_EAST] = 236,
-	[CLK_TOP_CFG_AXI_EAST_NORTH] = 237,
-	[CLK_TOP_CFG_AXI_NORTH] = 238,
-	[CLK_TOP_CFG_AXI_SOUTH] = 239,
-	[CLK_TOP_CFG_EXT_TEST] = 240,
-	[CLK_TOP_SSUSB_REF] = 241,
-	[CLK_TOP_SSUSB_PHY_REF] = 242,
-	[CLK_TOP_SSUSB_P1_REF] = 243,
-	[CLK_TOP_SSUSB_PHY_P1_REF] = 244,
-	[CLK_TOP_SSUSB_P2_REF] = 245,
-	[CLK_TOP_SSUSB_PHY_P2_REF] = 246,
-	[CLK_TOP_SSUSB_P3_REF] = 247,
-	[CLK_TOP_SSUSB_PHY_P3_REF] = 248,
+	[CLK_TOP_CFG_VPP0] = 217,
+	[CLK_TOP_CFG_VPP1] = 218,
+	[CLK_TOP_CFG_VDO0] = 219,
+	[CLK_TOP_CFG_VDO1] = 220,
+	[CLK_TOP_CFG_UNIPLL_SES] = 221,
+	[CLK_TOP_CFG_26M_VPP0] = 222,
+	[CLK_TOP_CFG_26M_VPP1] = 223,
+	[CLK_TOP_CFG_26M_AUD] = 224,
+	[CLK_TOP_CFG_AXI_EAST] = 225,
+	[CLK_TOP_CFG_AXI_EAST_NORTH] = 226,
+	[CLK_TOP_CFG_AXI_NORTH] = 227,
+	[CLK_TOP_CFG_AXI_SOUTH] = 228,
+	[CLK_TOP_CFG_EXT_TEST] = 229,
+	[CLK_TOP_SSUSB_REF] = 230,
+	[CLK_TOP_SSUSB_PHY_REF] = 231,
+	[CLK_TOP_SSUSB_P1_REF] = 232,
+	[CLK_TOP_SSUSB_PHY_P1_REF] = 233,
+	[CLK_TOP_SSUSB_P2_REF] = 234,
+	[CLK_TOP_SSUSB_PHY_P2_REF] = 235,
+	[CLK_TOP_SSUSB_P3_REF] = 236,
+	[CLK_TOP_SSUSB_PHY_P3_REF] = 237,
 };
 
 static const struct mtk_clk_tree mt8195_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = mt8195_id_top_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(mt8195_id_top_offs_map),
 	.fdivs_offs = mt8195_id_top_offs_map[CLK_TOP_CLK26M_D2],
@@ -1475,18 +1461,34 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 	GATE_FLAGS(_id, _parent, &infra_ao0_cg_regs, _shift,\
 		CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
 
+#define GATE_INFRA_AO0E(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &infra_ao0_cg_regs, _shift,\
+		CLK_PARENT_EXT | CLK_GATE_SETCLR)
+
 #define GATE_INFRA_AO1(_id, _parent, _shift)			\
 	GATE_FLAGS(_id, _parent, &infra_ao1_cg_regs, _shift,\
 		CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
 
+#define GATE_INFRA_AO1E(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &infra_ao1_cg_regs, _shift,\
+		CLK_PARENT_EXT | CLK_GATE_SETCLR)
+
 #define GATE_INFRA_AO2(_id, _parent, _shift)			\
 	GATE_FLAGS(_id, _parent, &infra_ao2_cg_regs, _shift,\
 		CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
 
+#define GATE_INFRA_AO2E(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &infra_ao2_cg_regs, _shift,\
+		CLK_PARENT_EXT | CLK_GATE_SETCLR)
+
 #define GATE_INFRA_AO3(_id, _parent, _shift)			\
 	GATE_FLAGS(_id, _parent, &infra_ao3_cg_regs, _shift,\
 		CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
 
+#define GATE_INFRA_AO3E(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &infra_ao3_cg_regs, _shift,\
+		CLK_PARENT_EXT | CLK_GATE_SETCLR)
+
 #define GATE_INFRA_AO4(_id, _parent, _shift)			\
 	GATE_FLAGS(_id, _parent, &infra_ao4_cg_regs, _shift,\
 		CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
@@ -1513,23 +1515,23 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART2, CLK_TOP_UART, 24),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART3, CLK_TOP_UART, 25),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART4, CLK_TOP_UART, 26),
-	GATE_INFRA_AO0(CLK_INFRA_AO_GCE_26M, CLK_TOP_CLK26M, 27),
+	GATE_INFRA_AO0E(CLK_INFRA_AO_GCE_26M, CLK_PAD_CLK26M, 27),
 	GATE_INFRA_AO0(CLK_INFRA_AO_CQ_DMA_FPC, CLK_TOP_FPC, 28),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART5, CLK_TOP_UART, 29),
 	/* INFRA_AO1 */
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, CLK_TOP_CLK26M, 0),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_HDMI_26M, CLK_PAD_CLK26M, 0),
 	GATE_INFRA_AO1(CLK_INFRA_AO_SPI0, CLK_TOP_SPI, 1),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0, CLK_TOP_MSDC50_0_HCLK, 2),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1, CLK_TOP_AXI, 4),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CG1_MSDC2, CLK_TOP_AXI, 5),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0_SRC, CLK_TOP_MSDC50_0, 6),
 	GATE_INFRA_AO1(CLK_INFRA_AO_TRNG, CLK_TOP_AXI, 9),
-	GATE_INFRA_AO1(CLK_INFRA_AO_AUXADC, CLK_TOP_CLK26M, 10),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_AUXADC, CLK_PAD_CLK26M, 10),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CPUM, CLK_TOP_AXI, 11),
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_32K, CLK_TOP_CLK32K, 12),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_HDMI_32K, CLK_PAD_CLK32K, 12),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_H, CLK_TOP_AXI, 13),
 	GATE_INFRA_AO1(CLK_INFRA_AO_IRRX, CLK_TOP_AXI, 14),
-	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_26M, CLK_TOP_CLK26M, 15),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_PCIE_TL_26M, CLK_PAD_CLK26M, 15),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1_SRC, CLK_TOP_MSDC30_1, 16),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_B, CLK_TOP_AXI, 17),
 	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_96M, CLK_TOP_TL, 18),
@@ -1537,15 +1539,15 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO1(CLK_INFRA_AO_ECC_66M_H, CLK_TOP_AXI, 23),
 	GATE_INFRA_AO1(CLK_INFRA_AO_DEBUGSYS, CLK_TOP_AXI, 24),
 	GATE_INFRA_AO1(CLK_INFRA_AO_AUDIO, CLK_TOP_AXI, 25),
-	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_32K, CLK_TOP_CLK32K, 26),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_PCIE_TL_32K, CLK_PAD_CLK32K, 26),
 	GATE_INFRA_AO1(CLK_INFRA_AO_DBG_TRACE, CLK_TOP_AXI, 29),
-	GATE_INFRA_AO1(CLK_INFRA_AO_DRAMC_F26M, CLK_TOP_CLK26M, 31),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_DRAMC_F26M, CLK_PAD_CLK26M, 31),
 	/* INFRA_AO2 */
 	GATE_INFRA_AO2(CLK_INFRA_AO_IRTX, CLK_TOP_AXI, 0),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB, CLK_TOP_USB_TOP, 1),
 	GATE_INFRA_AO2(CLK_INFRA_AO_DISP_PWM, CLK_TOP_DISP_PWM0, 2),
 	GATE_INFRA_AO2(CLK_INFRA_AO_CLDMA_B, CLK_TOP_AXI, 3),
-	GATE_INFRA_AO2(CLK_INFRA_AO_AUDIO_26M_B, CLK_TOP_CLK26M, 4),
+	GATE_INFRA_AO2E(CLK_INFRA_AO_AUDIO_26M_B, CLK_PAD_CLK26M, 4),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI1, CLK_TOP_SPI, 6),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI2, CLK_TOP_SPI, 9),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI3, CLK_TOP_SPI, 10),
@@ -1571,13 +1573,13 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO3(CLK_INFRA_AO_MD_MSDC0, CLK_TOP_MSDC50_0, 8),
 	GATE_INFRA_AO3(CLK_INFRA_AO_CG3_MSDC2, CLK_TOP_MSDC30_2, 9),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU, CLK_TOP_GCPU, 10),
-	GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_PERI_26M, CLK_TOP_CLK26M, 15),
+	GATE_INFRA_AO3E(CLK_INFRA_AO_PCIE_PERI_26M, CLK_PAD_CLK26M, 15),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_66M_B, CLK_TOP_AXI, 16),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_133M_B, CLK_TOP_AXI, 17),
 	GATE_INFRA_AO3(CLK_INFRA_AO_DISP_PWM1, CLK_TOP_DISP_PWM1, 20),
 	GATE_INFRA_AO3(CLK_INFRA_AO_FBIST2FPC, CLK_TOP_MSDC50_0, 24),
 	GATE_INFRA_AO3(CLK_INFRA_AO_DEVICE_APC_SYNC, CLK_TOP_AXI, 25),
-	GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_P1_PERI_26M, CLK_TOP_CLK26M, 26),
+	GATE_INFRA_AO3E(CLK_INFRA_AO_PCIE_P1_PERI_26M, CLK_PAD_CLK26M, 26),
 	GATE_INFRA_AO3(CLK_INFRA_AO_SPIS0, CLK_TOP_SPIS, 28),
 	GATE_INFRA_AO3(CLK_INFRA_AO_SPIS1, CLK_TOP_SPIS, 29),
 	/* INFRA_AO4 */
@@ -1596,6 +1598,8 @@ static const struct mtk_gate infra_ao_clks[] = {
 
 static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8195_apmixedsys_probe(struct udevice *dev)

-- 
2.43.0

