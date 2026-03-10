Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F828EB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA81E84154;
	Tue, 10 Mar 2026 16:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FmVI7Sn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2B684109; Tue, 10 Mar 2026 16:34:30 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BEA84131
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-464bc03efd8so7651533b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156867; x=1773761667;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fb2ZRekyE0q1hkghTo8ICJnaLoKrCSiCqeKt6yLxNxc=;
 b=FmVI7Sn4ZGWuM702wcyiBYia53gipkMFDXc66qMfrYNzoIPZcmcW2eiyRwZ/LgsdIl
 W6NMRAGJu/NvvczWXc45kenlYwPSE7VFulEMhtQI5sl8kT8kKgjObDeeC6kwqtpJwF6e
 KPWfgwtPxv/4y8NrIURu3y3LG41mI3g+BFgBYsW3W5g2ctKr0PQZc9DB8S4H2TtB++Ts
 1eCwU9YtRwASUZOtYvR/myVfyzDimrEW85sBI+Kgr6GVHTlgLdxd2ZXfAaR7IOmu1Ncd
 L8TC4sZJvVtt3ZOI2IaM1zeySJHNHEtTEdwhM0vz30/ceEqJlUaC3Pxr6hgtqm1q2rBb
 FNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156867; x=1773761667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fb2ZRekyE0q1hkghTo8ICJnaLoKrCSiCqeKt6yLxNxc=;
 b=W50RuydiSLgUn1eVrlN4DgA0kO8zV9NNrBgh2K3Zk+F4PU+Q2+1udIm7tzGc4CVxY7
 mFzuS219RtIhSQZXU5x7gvgq1sG7RC2+TcYyW3LcpuyVWR/gQAOzNBS4HOjfsVwAMHI/
 XX51cBFiV0RfY8OMLSDQJznnjZywvDybblq9KhT1+kLc/E2NAWUZT+leGX8aDmGpdn/Y
 xyj64W0mOd8O30wEu6q3W3chivMvySJsuV2nIIs9Bm+KksGIy1zGHh9MLOmPMkqWgArj
 V0NmabVwzYaIvcNjtwPPbN4GqsbA/ChhTJLBm72l+4cNrXyfAjsXN4DcPkMhSm37AEw2
 LBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH+NAYprkZy4oVlT6MUjfiT0KjsOpdkA3paWboxQPcEm5iR+PXdX2SSEUoNT3KMIzyd+UbJvo=@lists.denx.de
X-Gm-Message-State: AOJu0YypfnLOWPfyhhHz8opUtevm2kvq+Y8dbSUKT+2by0itks3FlDXe
 AhlQ3kA7bau1nMML1ZP+H6wHzAyB4iwtSH9xP09+lV16jHWiy8LJHp4lmcgH5A5bLus=
X-Gm-Gg: ATEYQzxGsgPi6FCdCUPPsWiNbgxf3KUP7d2ai+z/K5j65jmI73GKwgicGKhetpa0T2e
 TI/ZypZb8gZXkqvpOkSyQncUniz9iIC7QofQ2xK/FO1RIhy7WMO/gIwYhnLV+o6gqdCfg3tUrA4
 j02nnIGfowPhhFK4+tYm0sP9WNFM6D0iVTwS7LKrHG7h+IFRZ2Je8Q0Ot0nyeRu7xgetnqnT/Lr
 A8uM+y67Vli3ZfyByj3at599zR6oDphuosqes6EUZ/aCqmhxjXbe+pA4xLSxX+dsiaXR7IPm5F9
 DK2DsvWRHFDCdAQCwZ5XKD1/L8icoxAunnjEOFuFs3SwDit9df4N0PYhFBUXU8jHo5FVjThEQUw
 KAbGjYx0U0W2iGSCCSYCj14dLe/Xxc9K7PWOi+4AhRdadzx5fEStELrziDufUbmZ7VhqR/xHpFM
 xD8e8CfKL3FKzFtdjzf6i3wc8B01O+
X-Received: by 2002:a05:6808:23c8:b0:467:2375:58c9 with SMTP id
 5614622812f47-46723755dd4mr1148659b6e.45.1773156867325; 
 Tue, 10 Mar 2026 08:34:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:25 -0500
Subject: [PATCH 12/16] clk: mediatek: mt8365: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-12-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WkmGRjeBro/VtF1E9Gc29HgVpuM38fSDFL6f3tSuQQQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnTaBOHENWf7PzRZwIxXuVdNrsuNSo9D4eoj
 bFuh/9uzHeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA50xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApAUH/1fBY61e1J/kxpTEiow63qP0FPjR19fKrMZfjXZ
 YBxkgfxYUqjQLJTU19EjHWsgiaDF/iRLMQ0fTsU27vQh33W/htvXgCgXkMNRy6AGhZAfnFdz5mm
 HC3ROSqzOQbAg7zva+6h+8m7O5yS//VW0DK5IEYLSWM1VHXZNeBRACi7wVCSXZ7I6/Oe6BbfyVZ
 WeOADq5Yd9dJAEFDE/5YRlLImStDsj/ylj6JhNBMM+RYJuJnu7kPMf7qt6DePfI574vTn1qnDVk
 65TOPme4fv9uZMJC0FutygV3e9KprT7FiMziITRGM0W0cJMEYNtZEti3q73vYOFVgQ4v6NRqvgO
 ggjM=
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
 drivers/clk/mediatek/clk-mt8365.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 15df6422661..be70fda5ff8 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -74,7 +74,6 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 static const struct mtk_clk_tree mt8365_apmixed_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clk_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
@@ -85,7 +84,7 @@ static const struct mtk_clk_tree mt8365_apmixed_tree = {
 /* topckgen */
 
 #define FIXED_CLK0(_id, _rate)						\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FIXED_CLK1(_id, _rate)						\
 	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
@@ -105,7 +104,7 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define PLL_FACTOR2(_id, _name, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL, 1, 1),
@@ -155,7 +154,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR1(CLK_TOP_APLL2_D2, "apll2_d2", CLK_TOP_APLL2, 1, 2),
 	PLL_FACTOR1(CLK_TOP_APLL2_D4, "apll2_d4", CLK_TOP_APLL2, 1, 4),
 	PLL_FACTOR1(CLK_TOP_APLL2_D8, "apll2_d8", CLK_TOP_APLL2, 1, 8),
-	PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
+	PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_PAD_CLK26M, 1, 2),
 	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_DSPPLL, "dsppll_ck", CLK_APMIXED_DSPPLL, 1, 1),
@@ -163,7 +162,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_DSPPLL_D4, "dsppll_d4", CLK_APMIXED_DSPPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_DSPPLL_D8, "dsppll_d8", CLK_APMIXED_DSPPLL, 1, 8),
 	PLL_FACTOR(CLK_TOP_APUPLL, "apupll_ck", CLK_APMIXED_APUPLL, 1, 1),
-	PLL_FACTOR2(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_XTAL, 1, 52),
+	PLL_FACTOR2(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_PAD_CLK26M, 1, 52),
 };
 
 static const struct mtk_parent axi_parents[] = {
@@ -583,7 +582,6 @@ static const struct mtk_gate top_clk_gates[] = {
 };
 
 static const struct mtk_clk_tree mt8365_topckgen_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clk_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
 	.fdivs_offs = CLK_TOP_MFGPLL,
@@ -755,7 +753,6 @@ static const struct mtk_gate ifr_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8365_infracfg_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clk_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
 };

-- 
2.43.0

