Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97A0EB1072
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250C484166;
	Tue, 10 Mar 2026 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Aw4E7Jfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD1583FBC; Tue, 10 Mar 2026 16:34:31 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C7A8413A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-466ebbf7ff7so954207b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156868; x=1773761668;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5V02GXHCyuCOGNUP0yCeu17yOjSYyzy4efTeYvOnP4=;
 b=Aw4E7JfxpdaY5SpyrjjgOwBhZ1IcPY/dt0KXyZhqlgLdJ0UhHMh8yic2EHdER5i1j8
 Xm7sk+NBDx7mxcjDao2e9k9M7tPpZzfl9Za2VP3t1AkoyQGahaLJ+DiytcAXrjNC0i0o
 MZ7i/MbmWNl1t2NKGd0kpId6BwIxEFJYBiaffizpRy5LpkpxIX41HboLiSl9GIl4Yn/z
 c60AI+roGnZSVhdDTUnOkbR7vbyWhMrWJZyqWuWlQdEoGt3ynbLLxQPfgWZLs4tDWLZg
 kjGDbTwH9w2QC7FRR42HlLH9vA8Q7AytSOQnHdgoQ3AN28gNvk1X9EYZlY0l+0tPnF3x
 YWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156868; x=1773761668;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G5V02GXHCyuCOGNUP0yCeu17yOjSYyzy4efTeYvOnP4=;
 b=etPnn2awGD8KxLplZJkwbm56VWs0PwTq1NnuDIh1W0KYEkg1tG4cLvqeg5C8FRpEWt
 f5kQHB6JACpy0hUjynY5uTrZSEa5A/Fkdr7Qrii263LSYr3YH6yutQirBXjRSgOPyvWy
 cciXx6iHCMD8g6QiSFLRWG6uUwpKD6q9bhIjzljfAHD2fmsE2ZQCnIQ/gsVDnp07Bd2C
 FBgJvj4v4PPNqKHaowzGfhFboVGjn6s0jhZ+t97v4HzFeTgCt+0M+Fnym0zWT/yaslqi
 8QJx3D0lWF6HutQirhATHZ6t9/bI2KLx/QkVVuxjs+gL176xF0zUzuoXADmIPqxJSUE3
 O5gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuTkTV0gJeNVmB1HpxAWZauXbAHNPtj9GKdzBEA6ILEXUcmVvKefnikK+dAecKjoJJdlSnXx0=@lists.denx.de
X-Gm-Message-State: AOJu0YyA6GeUdgyaPKpadNChbL8m5j+ygIfrM90zLqScLusJyOGayZuR
 n8FeM0+gc3Sd/MprsLSUYqE3wyS1s/qMq0EQrc7w4fjnBIo/jCXBSffnH+kE116pR0U=
X-Gm-Gg: ATEYQzytX6K74KarvAf61yHVTpjgNizvwt7jtXuQUmQcf4eVFnaUh8kZwS3q9JVXe83
 1vmGeePdV6+NgOgWWv2mrVk8QOCsZuNp71jw93IIl7Qn9qelDDIY2XKRRQ5D0va5KD8yGM9J/Fd
 kcwnwiJkMp0s5CqyzAPKu8ILMqf3Pxn989lR1arbXB0Z5PvmZbsgDY9a/6QVDGCsk7guLWK9exN
 sR8OZ5+PK8pusNp0+DYxRMBHNCkaOvbdhTIx2sj4PS6CPidtIOajlxoylYwcQoulZiGxPp10IQR
 9rFpawRgKkif6SeiWzwjQS6Oek6MrA1MRsYUPUz7XNbK+d4VCYPy8yIAbAVeSi8G+9rAHhJfVEo
 iCAd4xJOXYthnkOWGDTDBuXvOTQzysdwf4h6ONNXO/QDiZ8ntlPlEji/hkLSqedgc2Vk9PWxlya
 SAUHI3xDJYNVgzD7BGmrgVGTT0jSc/FRLnZoONy40=
X-Received: by 2002:a05:6808:64cd:b0:466:f054:c3b6 with SMTP id
 5614622812f47-466f054ca37mr4709245b6e.59.1773156868159; 
 Tue, 10 Mar 2026 08:34:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:26 -0500
Subject: [PATCH 13/16] clk: mediatek: mt8512: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-13-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/ixD497FenoCkASGRUOU7p5J0Fv1BHUBloA7xZHh3/g=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDna5cdB8LMSAAvyfZq3CbBsFohmt1UAH2c63
 Eq1f6gBUnKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA52hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMNIH/2KNR8N0SU8ZKbI65NqVeWR3UMMZBr72oHO66c5
 xQYuNWfAoVVzxEqBB1nnVKar0c1AKDFYLBUnMj9eTn1/P+t6KBVjQEBqXYfELVgT2tMvvZkJmjU
 XPCT9Uyp1DeJgzlo1zc+Tw70BSlcT/n4pkhjBNxDAvkAide7YdM9tw7CN305CCjlDGMdkMc/7Cz
 lDao1ikvOxr5wIase244KpRYqxilm5jmynLl8XDR+dmyMqPj81SJOWUYXCa1HWCB4iV+9Rd5JqL
 vAoZ5oSLliTduFM8glOpoUgf8etzmln3CA2dy7MocJRnQcs17J3kT1RQJrpzT7sHj/40vHqrFPj
 jGrg=
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
 drivers/clk/mediatek/clk-mt8512.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index f7d41f4cfdb..d6e58be8e22 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -68,7 +68,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)			\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FACTOR0(_id, _parent, _mult, _div)	\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -77,7 +77,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
@@ -130,8 +130,8 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_APLL2_D4, CLK_APMIXED_APLL2, 1, 4),
 	FACTOR0(CLK_TOP_APLL2_D8, CLK_APMIXED_APLL2, 1, 8),
 	FACTOR0(CLK_TOP_APLL2_D16, CLK_APMIXED_APLL2, 1, 16),
-	FACTOR2(CLK_TOP_CLK26M, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_SYS_26M_D2, CLK_XTAL, 1, 2),
+	FACTOR2(CLK_TOP_CLK26M, CLK_PAD_CLK26M, 1, 1),
+	FACTOR2(CLK_TOP_SYS_26M_D2, CLK_PAD_CLK26M, 1, 2),
 	FACTOR0(CLK_TOP_MSDCPLL, CLK_APMIXED_MSDCPLL, 1, 1),
 	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
 	FACTOR0(CLK_TOP_DSPPLL, CLK_APMIXED_DSPPLL, 1, 1),
@@ -793,7 +793,6 @@ static const struct mtk_gate infra_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8512_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),

-- 
2.43.0

