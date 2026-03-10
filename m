Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FA4EB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3C683FED;
	Tue, 10 Mar 2026 16:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3T9bGrSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACABF84171; Tue, 10 Mar 2026 16:34:33 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381FD8410D
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4672076355aso601096b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156870; x=1773761670;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+/enhN0+lEi7937amoc0lcUz/b/5fMsFnLXVlfJzIM=;
 b=3T9bGrSBhWFj+fy09KcIrKXCqfOlfx0lorZ24xFW9Q4+gdWFqxtNPGwnK0i1//Yl2Z
 QECNcBxCrnRnYdl92XYZh2E5pxqDrSnHBIGd0mVGJaOqlPXc+8B6NHO8OhUnXDafjfit
 TaJAoWVDWakItjTp/wdxM7e+qlQlpJwa3obuDpubOqylYJRI2fFnyhaMtjbndal2bGLv
 ohLgNUQPnyL/vgx+szXyPN/jclLaWxAyfjBjqnMHRfCu+wDti70FULmnyJ0sp7Xj0mhE
 1bigFnt5AEUkfZg57nZEohrnKLyOiGk9q9IOyp5QT5ArpuEUCkEBrAzueV/TB5VWvql4
 YI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156870; x=1773761670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+/enhN0+lEi7937amoc0lcUz/b/5fMsFnLXVlfJzIM=;
 b=B4QJptOsyo9B/lAHsZkkMnQ50pFbD1YHdT4KyPa+2XoSTKdgkUfCyb7Y8vw/MdhmH3
 X1uTs1fXp2s5akGYIuS2C+aCwNoSkcw/44S+WRD6YTGMDgCeBCt3PaR+bOV1rtXs54Lu
 5eaFy+BjSDYHtUrBQvI6Eu5tQQy2wEOzqO0R+YDqj6zm4Zgl2DQAzJbRYN/PvRpqTCQh
 u4Bh9jaw7LtzJBE9jGulKypNDG0IOLYZlaU99LrHYM9IMr00KVDWWwzjzAjnJbEKRSO/
 Kddhe6pNymzKmFGUiaOUrPYdrIMM2bKrbvJTixriEOEB4ukK4lwRc4kgYFg/YFLRhvI3
 1FgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqVOVPQ3DWn68lOnonEsfZJk4eFpxnl9RJ5c1DSXhlnOtDgRG+gl6UP9kaD0iSnN1RmRS+3zc=@lists.denx.de
X-Gm-Message-State: AOJu0YwkGG5edkOlETlB+ktC9yZarUOmaA4vQtrd9H6V0RAi9JPeZqk3
 dKWxR5M0GAeqVFUXHGqmNeNXCch5g8ttUCs91pAkdnPrVa/+mMBcgtWEIyQUfqiqoi0=
X-Gm-Gg: ATEYQzyhHRNycJjpzAF62MH+pUObPyLDSeOvWxJpCuvgvR4m9Ny0/9p0GkyR70lTwuY
 v4B1j/u22kSza9AlvlFN4rCciuzIerIETqJSdCcYqx3PoEaOFJ3vNCeHkFEW0wfQj2RZ8S+oHFB
 WX8Je9aaIB14Skg7Z6g5gDgiicMJcVzE6zE4KQoQsm0CGxAbu2xpfEKXvgujx/e+BHi+OY+hph4
 LVwMArK8jfAVVMZ4UMqr/yxHtUnHM8GHU0VK+sPquO6carEiu43SzvY/E4grPMmAbOHzEk9ZJpb
 kaK2APe+ZwAfsR1i1gN+HXj/Y1C7hfuJAMGor20UZxeaCppBdnOPr0LZMdMMXyGA8OMeE7YFRTJ
 hdh73Rc4coESbsau4/10cmMzbS69iwgDpYWMevAx7ph883ZnjTItdIHBthclp8quu1EDROrJvYw
 o+d+gTGqzuuKobuU9c9NRhvNPfWH/+
X-Received: by 2002:a05:6808:50a6:b0:467:155f:8c2b with SMTP id
 5614622812f47-467155fbc95mr3156821b6e.50.1773156869903; 
 Tue, 10 Mar 2026 08:34:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:28 -0500
Subject: [PATCH 15/16] clk: mediatek: mt8518: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-15-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RJ1s2IBcn+WeB2l6Y8WTUBjOmirUiM0T+JCcTlCw4cE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnnAYCL0Ow4PE0WP6G3qqfWXkO23SqJ9CJGg
 MM/RmpODGaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA55xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Av7UH+gPifFIaOE/FsrLxDccDMYqB577MdoM4F7rzLJR
 LjUNzDeThiVGSboVQ1TExXrnzEovWw8mVzHaQe5JuLNQa+vRnrXCcIO8Br5IdxrX7tTW/P/MFbj
 bHkV0bfr4yNdTV1nW7/g7AmOrvyG8D+0BXWivvCAb4OieueZlsL3qdQRkAocZ0JkX7RYcTNzE9S
 bOFCvgtWNnDAKnbug6RcoRIQOzmuxm0Coa42HngbEWJ3+HIK6iT4O7nIjqlM5KK/IWcgOtysxKv
 y4ONz5vMx2qy7PqkUViLU4ymi/rYpCB3YoSOsa1AhHN+6J8QwiEHGiYRaEBaoQZUH0zT0e/ajtg
 RvTY=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK26M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 85cbb35446b..2b213e720a0 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -60,7 +60,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)			\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FIXED_CLK1(_id, _rate)			\
 	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
@@ -72,7 +72,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
@@ -82,7 +82,7 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
-	FACTOR2(CLK_TOP_DMPLL, CLK_XTAL, 1, 1),
+	FACTOR2(CLK_TOP_DMPLL, CLK_PAD_CLK26M, 1, 1),
 	FACTOR0(CLK_TOP_MAINPLL_D4, CLK_APMIXED_MAINPLL, 1, 4),
 	FACTOR0(CLK_TOP_MAINPLL_D8, CLK_APMIXED_MAINPLL, 1, 8),
 	FACTOR0(CLK_TOP_MAINPLL_D16, CLK_APMIXED_MAINPLL, 1, 16),
@@ -117,11 +117,11 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_APLL2_D3, CLK_TOP_APLL2, 1, 3),
 	FACTOR1(CLK_TOP_APLL2_D4, CLK_TOP_APLL2, 1, 4),
 	FACTOR1(CLK_TOP_APLL2_D8, CLK_TOP_APLL2, 1, 8),
-	FACTOR2(CLK_TOP_CLK26M, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_CLK26M_D2, CLK_XTAL, 1, 2),
-	FACTOR2(CLK_TOP_CLK26M_D4, CLK_XTAL, 1, 4),
-	FACTOR2(CLK_TOP_CLK26M_D8, CLK_XTAL, 1, 8),
-	FACTOR2(CLK_TOP_CLK26M_D793, CLK_XTAL, 1, 793),
+	FACTOR2(CLK_TOP_CLK26M, CLK_PAD_CLK26M, 1, 1),
+	FACTOR2(CLK_TOP_CLK26M_D2, CLK_PAD_CLK26M, 1, 2),
+	FACTOR2(CLK_TOP_CLK26M_D4, CLK_PAD_CLK26M, 1, 4),
+	FACTOR2(CLK_TOP_CLK26M_D8, CLK_PAD_CLK26M, 1, 8),
+	FACTOR2(CLK_TOP_CLK26M_D793, CLK_PAD_CLK26M, 1, 793),
 	FACTOR0(CLK_TOP_TVDPLL, CLK_APMIXED_TVDPLL, 1, 1),
 	FACTOR1(CLK_TOP_TVDPLL_D2, CLK_TOP_TVDPLL, 1, 2),
 	FACTOR1(CLK_TOP_TVDPLL_D4, CLK_TOP_TVDPLL, 1, 4),
@@ -1501,7 +1501,6 @@ static const struct mtk_gate top_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8518_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),

-- 
2.43.0

