Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92272D711CF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BE1839F1;
	Fri, 19 Dec 2025 00:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GjJcHEaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A3883642; Fri, 19 Dec 2025 00:24:49 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D1A83106
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450b2715b6cso689690b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100285; x=1766705085;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FYMNgVIOAr8aG7k6mxqnrjxI4rA2NYq6oiu648NtnMw=;
 b=GjJcHEafDMRcFrmgas5Mwx5NMnvkqL/r/TYfsMc44KrAz1JW/CoHpzjvOtGqg1rPfU
 Iqm2eZMrwgS7lzhZjU8tnoeYlYYZVLG4gVmo0muL5D96JOB6dzEi/BYpWijwz8CMow1k
 ckI6xj933MCTyi0rYF6caFTeGZd1ACCbkLKY9IL0sLYrRuw2i3W1HYI7PAmcqXGsa+sm
 ViJVDeK9ib2WDkhQRkKMGtIKjrazhbo7QEaE0L0OdLfnJ6vQYpzWFqd0UbKIPm60VFrZ
 nTQ5dEKal6AJvrReUc7I4IQyr8tDZOrmZith6ziBYe3dFNKQ9KZ7aOC6SjVfZWyNf80E
 SfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100285; x=1766705085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FYMNgVIOAr8aG7k6mxqnrjxI4rA2NYq6oiu648NtnMw=;
 b=KtLJ46fKjKOzsrFtgj/BjZqmkwh6iChQrCb3q3dHqzttyv9ktGk804EDHX5RmUud6q
 7mciqosQEIrKT60qRZBJidpLA88lG99j2D44/3XCqECOo7XHHlanGlLSXurfz5bVt0fX
 wgNmpj8Jk3BQgEFGoCKFeY3skVfEUApDQI9ikscdzTHDGUgsyPjncEIqLwMUhgQWxF9M
 mG+XEssFc8pfvvYVz8dqf0zyGFHVr4oJfYhywv+g3aZOScSBwYC0cWCVXdq8PV72lQy1
 PAP7thzphRrnOsjftna+8XsVYrCYGdRLGR2FSvfrGKsCkNyCN8F86sUmF9VyOuU6obWN
 alAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jibhKE/4sKF+W46ZC3k+l5KEj5l/wZHey2KPrQuMcFuumDiqsPHctbIKIi2DnKLKcU57epk=@lists.denx.de
X-Gm-Message-State: AOJu0YwW4JKiqroJfZ9xu1xtNii/WwV2HamRet79xyqkxZWI9A9RuyQW
 mPj8rKof7KXLCCsHFouhRlMCbEjCM2qwclP/xu4KCgy9CYBwfXv+09QtupLat//AEvCu7W9Q4sb
 Otcdj
X-Gm-Gg: AY/fxX4Fhq+e1lP1bX0QiOjqpQns7RkwRpljHD8xByDdx/NOGNFGzaJWCYlUDJCyjCS
 8dgO2HCGNnKumv/Eoi2xRhCLB5CcpRaopaL5JEH6e2KfxB7kS80MrWdyu8wD5oT0y7dnS4rzMtv
 4hqQTJzF6OYRC2g6V1UBtvUdVcdaIHHuo+qp+WQHuWveOgbr6G97ESVSaxY+UhzxwjmHlMQXHJo
 dCibXVXrLDpfuM6xtS0iyjejo4CiRKM1HUWUrQXQWY2pOjoEwwjwDdzSf2KoGj9R6XoKfklpig+
 6OQ+7ZUJKK2XtZtfWUPIUbl/pUMWYk+v+Mw22nJ0B7tBnHvIqBKGSjopGfi3Yq4WVdt7a2XVRTX
 0JlNNnLzslgwuWm7z912DwueNjDM6Itf14p08MdY4GFavw1Ecde3jbGktITiXxZqn9xm1+uE9j5
 mPZIQOTBq3Bbqmg2E=
X-Google-Smtp-Source: AGHT+IE5LGUkdaMxRhUzAoSlczZYnuNqJTMVF9GIFy5u21QgK0/VxlB0QZHoEHjPSVooUSlva6K2YA==
X-Received: by 2002:a05:6808:d50:b0:450:d056:e0d3 with SMTP id
 5614622812f47-457b2180550mr686882b6e.56.1766100285289; 
 Thu, 18 Dec 2025 15:24:45 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:28 -0600
Subject: [PATCH 8/9] clk: mediatek: mt8365: remove separate topckgen-cg driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-8-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IE6nOUmJFckdMnAVgGL/Y1mwp3YR+wbmpxjJNXsYiZs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0ideImM/OirtRq2HQSjwaL/sF/zcANZQGlE
 u5QkI/66juJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNIhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVRIH/2rwPRI9mBS/fh111VTgZN9RWlPRhzhcZecPWNX
 a77pKmaT2D1qitL4ttG6Pis1qPFFbDSVZ18vpkUbH4N+EAKVME5zpOxUIGZe5MflulFnsVyHs/y
 CSG9Wfik65Z6rIAWTtu1tYwK4XLt2UyQ2aioWcOeoy3zn3M9sILPt+E3KtHtfKoIgamNn3pfHAF
 2O2pc3z2MWO3usVORZxiJ29ThST3X9ts9qBPqDzU2xGyPY7FhcPACoWKJ+HbHpgyySa1T4VkEbL
 qfEoGZpEg9DebL9K6yhkcq4/0cpnpBfyjXcZCIqLQAwC+b1uWgb+WufrAiCchA4OfuRLgWRczGR
 1FUQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Remove the separate topckgen-cg driver for handling clock gates in the
topckgen address space. The devicetree bindings for this were not
acceptable upstream because it was creating a separate clock controller
using the same address space as the main topckgen clock controller. The
gates are moved to the topckgen tree instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 49 ++++++++++++---------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index eaa5c2cf0dc..a28547a0cf8 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -500,18 +500,6 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
 };
 
-static const struct mtk_clk_tree mt8365_topckgen_tree = {
-	.xtal_rate = 26 * MHZ,
-	.fdivs_offs = CLK_TOP_MFGPLL,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.fclks = top_fixed_clks,
-	.fdivs = top_divs,
-	.muxes = top_muxes,
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
-};
-
 /* topckgen cg */
 static const struct mtk_gate_regs top0_cg_regs = {
 	.set_ofs = 0,
@@ -577,6 +565,21 @@ static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
 };
 
+static const struct mtk_clk_tree mt8365_topckgen_tree = {
+	.xtal_rate = 26 * MHZ,
+	.fdivs_offs = CLK_TOP_MFGPLL,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.gates_offs = CLK_TOP_AUD_I2S0_M,
+	.fclks = top_fixed_clks,
+	.fdivs = top_divs,
+	.muxes = top_muxes,
+	.gates = top_clk_gates,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
+	.num_gates = ARRAY_SIZE(top_clk_gates),
+};
+
 /* infracfg */
 static const struct mtk_gate_regs ifr2_cg_regs = {
 	.set_ofs = 0x80,
@@ -725,13 +728,6 @@ static int mt8365_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8365_topckgen_tree);
 }
 
-static int mt8365_topckgen_cg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8365_topckgen_tree, top_clk_gates,
-					ARRAY_SIZE(top_clk_gates),
-					CLK_TOP_AUD_I2S0_M);
-}
-
 static int mt8365_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8365_infracfg_tree, ifr_clks,
@@ -748,11 +744,6 @@ static const struct udevice_id mt8365_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8365_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8365-topckgen-cg", },
-	{ }
-};
-
 static const struct udevice_id mt8365_infracfg_compat[] = {
 	{ .compatible = "mediatek,mt8365-infracfg", },
 	{ }
@@ -778,16 +769,6 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
-	.name = "mt8365-topckgen-cg",
-	.id = UCLASS_CLK,
-	.of_match = mt8365_topckgen_cg_compat,
-	.probe = mt8365_topckgen_cg_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt8365-infracfg",
 	.id = UCLASS_CLK,

-- 
2.43.0

