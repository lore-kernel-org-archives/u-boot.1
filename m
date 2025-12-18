Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884BFD6E2B8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4605683642;
	Thu, 18 Dec 2025 18:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I8qDO0UU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7863F80077; Thu, 18 Dec 2025 18:18:08 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D4780107
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec47e4c20eso586225fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078285; x=1766683085;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KWYDgBZ+hlXbNlDxyr+8nmh1DrDflR7YJS2abzA3HsE=;
 b=I8qDO0UUBr0sTxgIB0ZKx9I4FK57aLrGuEmtsVUHoPyLnVBQdGmF+uRQ0IIK81RMb1
 G6wpZLxGrpzvppkndGIeVzqma+tTOS6usTGqEhDhfnZ8pAGN1DNJpJV/GBMqXzusKI72
 nqjUUcADWN7T0AQEN9FEdiQ4PZejMQQpzne87cz/TzRphceGkgWFDEpQn7BAeFfyMOS6
 yaQ8aulkkLAtOHxnx9TVnVWsBDtil9DLdbx7YmLmHYLuygxffpu+95Egjg/RCrIzSNGU
 c58c9H5DOg4dRtcf2z9vyabiU+Fh3QGb1tuopX43O1S+fiX4DUn3Ar99/kkH7xX4eItJ
 d9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078285; x=1766683085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KWYDgBZ+hlXbNlDxyr+8nmh1DrDflR7YJS2abzA3HsE=;
 b=iXkOpHcWDRSKrgfDto5qhRy2GnMIcFbjIr4oVyXsO7d7mLUs5F1dtB9QGcW6SsCtMl
 LgFZjLIQtimB+QPSTT7WurAnVU64iMAOt1pN5YSDhX6bPgrbgICR9md9WvZGNS2+6whC
 G+CJ8plN9HBJTKX5QnMjH1VvgdI5BUXc5lggghxeTIMb1X153dW32HIUr6BStAtGP94E
 FMGt1wxmW30DfrOgHcJj9k9XW0IuXuaglYiTSXzaAM6b0v3uZAQylolWq+mgXhZh8uJS
 rVbcu0oauQfTFctOw3Hp4mfEWJWLkgRQiLGkavdwxCj4gFTQTovG5hzB8fUKTw2qLiLr
 DhLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+bmiIU7qDFFyTSkANdKLNQrBr18hErfZ52CvX3Z7f92vaxHIE136ydO/OXSQSthRDXtFS7BE=@lists.denx.de
X-Gm-Message-State: AOJu0YzAIU3NiXQ3trwfE8aOJRhquFl348dd/rD3D4e6uZ1RWXNf+OQS
 humiOQTtNSjL4Jz5nL1mkwGA4Ks+1vNlNE0M5AgACviuVRtvthauGV/2uEQDHxSfix46qZJPpCX
 36HBn
X-Gm-Gg: AY/fxX78ZGrpVlL2aWNzrrDBqzUBtX4fTSS4s1k5pUQxf6JGHlCsofBe4rWcoHgqCFf
 /6f94Ru1k5pas38Iv4DzRVLJlISsOMnpaDarTEOMyC9C27yu8k8+CwSaZWrBc7XYknBin8cUr1Y
 tK/O4yYEfQvq1O3+P+Wnn5gFA9FWURw/oyfKtJf4EbZpLYt6FNN434LbJZK/q2evWJuyGZD05uz
 NRGT1GQmkNHiXdQ3rL74TJ4EthZ2j8jdDAo2fFPyLxqaHGcFlAvd52tO03uqqsCVgMLwy72eAML
 dYg8M5Ej5kDZPRBik00GUdsrUIAvLeO/AGU6a440O3FCYsVb6VxlReGaXmpd3XGzh9WGGwebSPo
 +erbtSc7L3Ri8TbgFfboa+/6dR7Pc7edM/t1M628U6qECRuj/+AqqVolYOD8y61vYigsMjyU7yc
 DzL/W8GOHr101LrLM=
X-Google-Smtp-Source: AGHT+IGqaQPCIgn3pLKNgwB/kLU2+ZFmwEjMgPcFFt3a5wJgtiDK94hpZ6Ye/XW6Y0xXBDvoUthWAw==
X-Received: by 2002:a05:6820:1687:b0:659:9a49:8fde with SMTP id
 006d021491bc7-65d0e932cd7mr104472eaf.11.1766078284619; 
 Thu, 18 Dec 2025 09:18:04 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:16:59 -0600
Subject: [PATCH 1/8] clk: mediatek: add array size fields to clk trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-1-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12913;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=cMpTfFIPl9oMTPcJrIRpafETipdLGaqTOcja91qTtu8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDcVE5STkLmNCKSGAMMR4mT+xt2iDrO6WvCNz
 8gr31/99ASJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3FRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsHAH/RbB+aeQMnEzwApgIO/7+Qyx0EhCCjgFWDRvQiK
 dKze+VCf+ONIQMPWrdJDcK2fT0KMKsSjGa2F5OXHBg2jpf8h99AwPm3hWkOEaUUfQ82h7MPyiT9
 1sWNKiyKrQw97pDyRK672If/hJdGsix8pG7MehfvPfMvHtyTULmY6Q86Xj7n2dtsa0eeS3capVO
 KbH60NIx+w8DXkDh5jYxqocfdRCAxk0vNQBfsJ5esSl4yz8zSAU8a/EBD75ZnW0zoxxtI1o3ML5
 I+jnRSqsB5B2yLAQ7aXlat1r+LFDwXVFABT3j76YmFmLjHg8DQXU9+jGuL6N4Vk1r5UfAF4Xdtp
 pnVc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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

Add num_plls, num_fclks, num_fdivs, num_muxes, and num_gates fields to
the mtk_clk_tree struct and populate them in the clk trees for all
existing drivers.

Currently, there is no bounds checking when accessing the arrays in
the clk tree structs. Adding these fields will allow for bounds checking
in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 9 +++++++++
 drivers/clk/mediatek/clk-mt7623.c | 6 ++++++
 drivers/clk/mediatek/clk-mt7629.c | 8 ++++++++
 drivers/clk/mediatek/clk-mt7981.c | 7 +++++++
 drivers/clk/mediatek/clk-mt7986.c | 7 +++++++
 drivers/clk/mediatek/clk-mt7987.c | 5 +++++
 drivers/clk/mediatek/clk-mt7988.c | 6 ++++++
 drivers/clk/mediatek/clk-mt8183.c | 4 ++++
 drivers/clk/mediatek/clk-mt8365.c | 4 ++++
 drivers/clk/mediatek/clk-mt8512.c | 4 ++++
 drivers/clk/mediatek/clk-mt8516.c | 4 ++++
 drivers/clk/mediatek/clk-mt8518.c | 4 ++++
 drivers/clk/mediatek/clk-mtk.h    | 5 +++++
 13 files changed, 73 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 23b9787612a..ccad3820c1b 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -604,6 +604,8 @@ static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
 	.plls = apmixed_plls,
 	.gates_offs = CLK_APMIXED_MAIN_CORE_EN,
 	.gates = apmixed_cgs,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_gates = ARRAY_SIZE(apmixed_cgs),
 };
 
 static const struct mtk_clk_tree mt7622_infra_clk_tree = {
@@ -612,6 +614,8 @@ static const struct mtk_clk_tree mt7622_infra_clk_tree = {
 	.gates_offs = CLK_INFRA_DBGCLK_PD,
 	.muxes = infra_muxes,
 	.gates = infra_cgs,
+	.num_muxes = ARRAY_SIZE(infra_muxes),
+	.num_gates = ARRAY_SIZE(infra_cgs),
 };
 
 static const struct mtk_clk_tree mt7622_peri_clk_tree = {
@@ -620,6 +624,8 @@ static const struct mtk_clk_tree mt7622_peri_clk_tree = {
 	.gates_offs = CLK_PERI_THERM_PD,
 	.muxes = peri_muxes,
 	.gates = peri_cgs,
+	.num_muxes = ARRAY_SIZE(peri_muxes),
+	.num_gates = ARRAY_SIZE(peri_cgs),
 };
 
 static const struct mtk_clk_tree mt7622_clk_tree = {
@@ -629,6 +635,9 @@ static const struct mtk_clk_tree mt7622_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt7622_mcucfg_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index d0b80f48b0a..cfc711ad216 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -997,6 +997,7 @@ static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
 	.id_offs_map = pll_id_offs_map,
 	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
 
 static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
@@ -1007,6 +1008,9 @@ static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt7623_mcucfg_probe(struct udevice *dev)
@@ -1063,6 +1067,8 @@ static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.gates_offs = peri_id_offs_map[CLK_PERI_NFI],
 	.muxes = peri_muxes,
 	.gates = peri_cgs,
+	.num_muxes = ARRAY_SIZE(peri_muxes),
+	.num_gates = ARRAY_SIZE(peri_cgs),
 	.xtal_rate = 26 * MHZ,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 94fc5e51456..e0eff01561c 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -572,6 +572,10 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
@@ -584,6 +588,10 @@ static const struct mtk_clk_tree mt7629_peri_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt7629_mcucfg_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 6130c93d5e6..9cb2aff2bee 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -513,6 +513,7 @@ static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
+	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 };
 
 static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
@@ -521,6 +522,9 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 };
 
@@ -531,6 +535,9 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
+	.num_fdivs = ARRAY_SIZE(infra_fixed_divs),
+	.num_muxes = ARRAY_SIZE(infra_muxes),
+	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_INFRASYS,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index cf298af644c..afff3167284 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -519,6 +519,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
+	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_APMIXED,
 };
 
@@ -528,6 +529,9 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 };
 
@@ -538,6 +542,9 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
+	.num_fdivs = ARRAY_SIZE(infra_fixed_divs),
+	.num_muxes = ARRAY_SIZE(infra_muxes),
+	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_INFRASYS,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index b662d680b15..8e37803e97b 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -46,6 +46,7 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
+	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
@@ -442,6 +443,8 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.muxes_offs = CLK_TOP_NETSYS_SEL,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
+	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
+	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
@@ -765,6 +768,8 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates_offs = CLK_INFRA_66M_GPT_BCK,
 	.muxes = infracfg_mtk_mux,
 	.gates = infracfg_mtk_gates,
+	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
+	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
 	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index c6da42f970b..d594fc6df39 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -773,6 +773,7 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
+	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
@@ -783,6 +784,9 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.fclks = topckgen_mtk_fixed_clks,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
+	.num_fclks = ARRAY_SIZE(topckgen_mtk_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
+	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
@@ -792,6 +796,8 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.gates_offs = CLK_INFRA_PCIE_PERI_26M_CK_P0,
 	.muxes = infracfg_mtk_mux,
 	.gates = infracfg_mtk_gates,
+	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
+	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
 	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
 };
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9612a62e56a..7a1953ef6fd 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -599,6 +599,10 @@ static const struct mtk_clk_tree mt8183_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static const struct mtk_gate_regs infra0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 53eca73b98d..7897044e1ad 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -490,6 +490,10 @@ static const struct mtk_clk_tree mt8365_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 /* topckgen cg */
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index ab270673442..6d98403bc45 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -790,6 +790,10 @@ static const struct mtk_clk_tree mt8512_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt8512_apmixedsys_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 623f88499f1..c21b9894ad6 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -739,6 +739,10 @@ static const struct mtk_clk_tree mt8516_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt8516_apmixedsys_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index ba8cc584d46..48ef209ebbd 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1495,6 +1495,10 @@ static const struct mtk_clk_tree mt8518_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt8518_apmixedsys_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 89479001ba8..05c22fce10d 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -265,6 +265,11 @@ struct mtk_clk_tree {
 	const struct mtk_fixed_factor *fdivs;
 	const struct mtk_composite *muxes;
 	const struct mtk_gate *gates;
+	const int num_plls;
+	const int num_fclks;
+	const int num_fdivs;
+	const int num_muxes;
+	const int num_gates;
 	u32 flags;
 };
 

-- 
2.43.0

