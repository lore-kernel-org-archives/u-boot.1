Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD3C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AD584B14;
	Fri, 10 Jul 2026 20:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZbJqgQN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D6E849BA; Fri, 10 Jul 2026 20:59:18 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E7884AE2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-448df16ab34so548321fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709955; x=1784314755; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GWgEcCFpR4hnOMSg5g603c/pwrjYqWxB1Uo4pHBbw88=;
 b=ZbJqgQN9pS52BtoU4hqzMg3GPVtH2/d0EtBF0qFKWjg/akprYM3z8vHhwpNhrsKoFj
 2Ke+GTP1EQj1L87pajWndWusr6WUAWTkwNA7ea/qr3GvlG/UhindGXaW0H97drfVvq7i
 OiwY0bnwzHyDSzhZJtYm3Z5Z04BCyqjxnMaP4JbHqeWWu8mvaptjYXq6gzLcp2GJVUYq
 0CTSGebzIhjNIon1EGnk8jRJol8afHxXB7xRCGG3ArsEb3NHHsYM8L/M9ldd5cwWqnuQ
 85f8yRL4e/6SFoPsGQR7e0Jznw3/UjcuLAFoV7LJ24/vDYUvEkQe7wPXkzVfmSdFJGk9
 Y9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709955; x=1784314755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GWgEcCFpR4hnOMSg5g603c/pwrjYqWxB1Uo4pHBbw88=;
 b=Wjm64jL8btpkvW0ee/0vodatO0bSl2kfyldpAJjCzuTyuQU+zjX5Nj9Ju5pOXXN0lx
 yrdAnfRQlyNPpF6X3ouRIQnEzWFDGdH8rqMyeZ8P83rsxRp+IkqHLVOiZ3jAicO9g4Op
 XVPLN85W65whKO7fSsv95nz7lPQ5zXy1040HQSOCmsnkW3kSyjoECwTM/1cdZkIfIlhA
 gzKt34X08qk2sm4jqwIHUwo4IQDkHD/7fCF3DV1lDE9SZbkC8TQhJyq18n2KVQAwk+Js
 tmrJqRGTO3S0igdx87UUJZd9Nvw4Z8CWheTFLbNeLubgtFBsTep/Z9WBcVz7BhOdrkGl
 pQ3A==
X-Gm-Message-State: AOJu0YzbWfCFKrb99wGDTU917Yptf9fZbbIPEZQ2VHZS5Q/2yiAbRjh2
 OWZD9dPgoeYOt3qgLKgzpTdq9At6PAh0PR8oyKpowFmiGHVBaO2jsYqhQXxvoFVII9pzou7KnNS
 l2a1n
X-Gm-Gg: AfdE7clvJMpYO+HKqDkZkw1cXpeY7EcF6c3vsMs7X5ZMHricukCcT7F3uA0IyQcT43c
 RlnJxmue1hBcV7XKTGTc6CvmsIAObLZHFJhwDblzifWkFtWlbwSlIG1JUih3rGO4Su5rjkBh9Y5
 5a1HzsnhEIluA6wOw6hklrMiRKJjHDnj9HwpVHdb70xktI4p8tYiX9VLFsxnHqU/hsmTfGgWn78
 x48c+eENq2G/yu4cgv3OG5jGgsdMUPerXQOHxIVnI18rgXNZX8HTFvyCSJ9O6tVaZu3368qi/bS
 MU08hzt56KsfKXkZpBG0ViPDKLGvRxvTCpqvrazCFo1Y7PUE18M9A5sdPn0DyyVBbPaZsI4E+4Z
 x5X4bPrfudwazBUrD6sBppldjriFL5S76QD0a3Utv/8BNOwVzwv3TY6peXZhvjUIzidnJ0BICKB
 EVNWnpEJdajb4gO+XJ
X-Received: by 2002:a05:6870:d6a2:b0:428:27a4:ada with SMTP id
 586e51a60fabf-451f0fee65bmr121849fac.10.1783709955314; 
 Fri, 10 Jul 2026 11:59:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:19 -0500
Subject: [PATCH v2 03/24] clk: mediaTek: mt7622: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-3-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2770; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hkNYnQ2oN/sDYxyDb0w6/eXVV4EHo/gtHpWz6a0Nf+c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUBsy3dZBU8AmIM01pC5glD7vxQ+mosjQd7Ab
 hETbcVAnzyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAbBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACFkH/3WsGziirsR2s0CGV/oofeN9xiyH2u4T9H809jZ
 CBf8jr81Va20ZwUJSEg4vzIC99w32gs3mkEuKRBQW4oOgYAESCh8o11f4xWcdjeE1TQM3rk2T8N
 VMQsBCIfImHtCIvs/No/qGsWYngvEXvKxHSxr3LiBGbOVheJ3R+sgygCNyqB0WrZ4FMhr+EbQLX
 scBlLpA9aLTvpyPfaxKSf5YaA1/VNDsLUJE/bURpUQKxnPnd92S1mHv6ktXloIyw74++BmV0Jx1
 YNgDB6vHx444enR8NEwLjWm1njppc8TTkhCHA0mZLxLNibV72zUvZFLNJjmXrtSOJYx4O+xbrcC
 qfz8=
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

Add clock tree type flags to the mt7622 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 60f4a872a66..aba870bf0f3 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -613,6 +613,21 @@ static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
 	.gates = apmixed_cgs,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_gates = ARRAY_SIZE(apmixed_cgs),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt7622_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.fclks = top_fixed_clks,
+	.fdivs = top_fixed_divs,
+	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7622_infra_clk_tree = {
@@ -640,14 +655,6 @@ static const struct mtk_clk_tree mt7622_peri_clk_tree = {
 static const struct mtk_clk_tree mt7622_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.fclks = top_fixed_clks,
-	.fdivs = top_fixed_divs,
-	.muxes = top_muxes,
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt7622_mcucfg_probe(struct udevice *dev)
@@ -687,7 +694,7 @@ static int mt7622_apmixedsys_probe(struct udevice *dev)
 
 static int mt7622_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7622_clk_tree);
+	return mtk_common_clk_init(dev, &mt7622_topckgen_clk_tree);
 }
 
 static int mt7622_infracfg_probe(struct udevice *dev)
@@ -807,6 +814,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7622-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7622_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -817,6 +825,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7622-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7622_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

