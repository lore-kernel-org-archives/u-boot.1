Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54575CFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C07383A2D;
	Wed,  7 Jan 2026 17:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A1amuA58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BADF8405C; Wed,  7 Jan 2026 16:51:26 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F3883A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450be85b7d9so1421041b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801080; x=1768405880;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bn0y9cgRrtvWdFabYVnfk8bOIHpLNg5NQ6l6rJI9Txc=;
 b=A1amuA58UA7E4yb35kiXyYr4QzFtGknYiOHmGlmFTZnIQ9GHE8fwjI2qxy3dX3hXuM
 e2+L2r6LFd53Y7w7yJ8WvUQ1SPEPOgkva19hU5uff2KNVz/zJEjm0Br57C4rnlqhxsrU
 HrMB5p93pGdfzAv8uwuaqsieV5qN2it7VJ7pwsgc3iDZB65cjC7HS3ANde6LodroskHa
 /O4YeKNe2USg3yX6TG8A2o9937IwmZ0wXb0ygBQ3iMHs+X6/p7RIl95NDjDZK5Xoo5JB
 iq1ZL1DHn1ayg4Tu19E6iC8hhspXCJrIhAxF0HhqZFzQXvZwZbKiof6RV6Hn4maDEjt8
 SOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801080; x=1768405880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bn0y9cgRrtvWdFabYVnfk8bOIHpLNg5NQ6l6rJI9Txc=;
 b=FXoOgwjsmLAIh6daYJYtUuYzMUu/P9VRnezIR1KJxcyo80TPLEao8lBGmDoVQV6Ooj
 EQB7yAOsr/ZDk7H4Ie6Xykrp5aePpF0e7v6s/Cm3kWfNvIhafOERcdX/1VoO6NYKgH4V
 JBJpAd9ZshjBjVQF2A/GZX5nBz8Zg4uwkGW5O27cFtsqmWQ27968leiD9aqLgCjRKV4r
 h2lT8m573LrCdTLhY+4vHzSczuu4+IepdUz3qO+00ZUQjuFtAZMcz8FuFqqMuaYN4P7n
 0QnpwBdQtERBCuqr+69IIn+cdW/k62OV6IJ/dzuc6hXEMN7Y99oVn6lnf0ToYWntOJpG
 +j8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV63sva+3svS3NGUVNuwKpnmFiB/68xFcQAKXxG7NrXvfyopYO04FrUKPDZMLpHGhw3Ah5KRVw=@lists.denx.de
X-Gm-Message-State: AOJu0YyNdBNSKd/Y+XNMnzDrFpdQbuM+AsLjpQDI7ozBNkHzkXUSbeq6
 R0acgMQyor21k58JK9dmWsqpY5PrFvovoqwjDjXyHgeIBJWv3zGRNEFer7Ao2nhZmXM=
X-Gm-Gg: AY/fxX5YGlo+JvDP+4iStv1BrharPwsYl9Sb4VQV6e5Xkz78NAQFTkVGfVS42+kvAgw
 N6tGJmfL35cD2XQBm5rq6+cDLElSbODJX+gyY4VN9cm2ahqnBFtMWiLP+mDhwyxmMusafzW4vLj
 DqIEVR+98tEqpXf0ZemuVOSiSRaqyKD5pl20h+bpVWpFcxHDlhQ8rTe+RC/b2LVDD3AxY+GHRsr
 k2ut+C2SPRci+xv3jhWZhz5ImQSrh5b+jjI4AunYvM+cJ2yg4gf+d+HYz//U8yfcbsy8DN/vWqV
 GOit1ylZiqwpo6cWanMSAgV9OIlS+Ck0sStT/tfX2qy4fe8MTEj3anHRQD2/x0Tu3Kd9Sftf4Rh
 wbXrOdy/q1Nsy4gV1hphX2UvZM8KG2YwZnCSAanJgoqAm/Hs0/0+dm32tMx1o8V7G3pSUC1jsZP
 smPn5avQapdKD6Ygs=
X-Google-Smtp-Source: AGHT+IHD57ytaEs6cS2XND5onigm0s6q4HJJ1KEpZoa/tRhqUNnzm3sNtV1EwmFIU3VIi3ORp6iBCA==
X-Received: by 2002:a05:6808:660f:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-45a6bd39567mr1437761b6e.4.1767801079864; 
 Wed, 07 Jan 2026 07:51:19 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:11 -0600
Subject: [PATCH v2 1/8] clk: mediatek: add array size fields to clk trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-1-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13850;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=/V+pm0hhiHBvQ4cxtQVkCL4lgI+A4demcP1SasbX60M=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoC/ZGAGxKUe1GNihzGE7FNUAFc4kSsHSmqjj
 S3j4s4Je5WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6AvxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyHMH/391wnyGgDihqXEZdEICV5RB64BIPzDTsW/zuKg
 sChW/bgO0gJaHifL976qwjPWufesIFMVwSVZOOufM98kJ9k/pSVqAxWQHWqMzeEeh7duAEA3t5d
 VXjKhiraTiPXVxzZmkzdVE42WTUNUAQq9bgvRU0TmqhFJtMNDRTb8WBEVWbJNEk/iE+yasOUQ4R
 Uq7gpnpOul3OsNMBMDIc0BFbf+G7PmBdqH4oq3mBef7vrWhVAbUS9EYy/k5PWZxcLPUSMpqrIf/
 nApMBEHoTKkoA7rqURzQc8aHAyW5iev+C6JsuBxhqgPGwiRyhmoOamTifJV6309svAXkRAztCJf
 j1gA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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
 drivers/clk/mediatek/clk-mt8188.c | 4 ++++
 drivers/clk/mediatek/clk-mt8365.c | 4 ++++
 drivers/clk/mediatek/clk-mt8512.c | 4 ++++
 drivers/clk/mediatek/clk-mt8516.c | 4 ++++
 drivers/clk/mediatek/clk-mt8518.c | 4 ++++
 drivers/clk/mediatek/clk-mtk.h    | 5 +++++
 14 files changed, 77 insertions(+)

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
index 2fdb1845e9f..f854f079c67 100644
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
 	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 };
 
@@ -531,6 +535,9 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
+	.num_fdivs = ARRAY_SIZE(infra_fixed_divs),
+	.num_muxes = ARRAY_SIZE(infra_muxes),
+	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 16db5877056..257f89b7daa 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -519,6 +519,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
+	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
 };
 
@@ -528,6 +529,9 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 };
 
@@ -538,6 +542,9 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
+	.num_fdivs = ARRAY_SIZE(infra_fixed_divs),
+	.num_muxes = ARRAY_SIZE(infra_muxes),
+	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index caee8bf43e4..b559152c045 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -46,6 +46,7 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
+	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
@@ -442,6 +443,8 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.muxes_offs = CLK_TOP_NETSYS_SEL,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
+	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
+	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
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
index bfbf401eb12..56f3e5ebdff 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -773,6 +773,7 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
+	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
@@ -783,6 +784,9 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.fclks = topckgen_mtk_fixed_clks,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
+	.num_fclks = ARRAY_SIZE(topckgen_mtk_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
+	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
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
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 55dfadddfe3..186638fcb66 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -85,6 +85,7 @@ static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
 	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
@@ -1364,6 +1365,9 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {
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
index 8ce7e52fd60..a4a3307e576 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -260,6 +260,11 @@ struct mtk_clk_tree {
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

