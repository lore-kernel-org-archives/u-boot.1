Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC7C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B8A84B59;
	Fri, 10 Jul 2026 20:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="o4LvjuKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 019F484B61; Fri, 10 Jul 2026 20:59:24 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDD6849BA
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-43bfe209e45so862521fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709960; x=1784314760; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iqinwLZKYIuEHegUtJ7FJZSt9bl8qfatLAP8QEL2pGs=;
 b=o4LvjuKjnUH67p31zTbhsFHVb+F/saBUdCHBEoDBS/pFAzjIvxPiZcFAJ0ryGJ3XS+
 sbVzLdZWPOSVblkFSGC4DHRWgfkDlnv8VJ4d8EFhhtTXjHmrtdk6/hLTADKbMs2aURlj
 3OBs8LNpLw/1r4hpVG6g/j+PCg8fcShVVPKxSxcZ+dxRM2U20lEDD4op9CP/CVhbhV63
 j0RiZKX2P0EfFc8fR5wSWIStQkVTxjC36Cq5ZQwxfeCR11ua3k8J7KPluOYmhVTZzaeu
 XOeYBpEpKE62nco5fXHMRodoNvH574TaEyXuahTfaATou0N5c9+W8NhATsV5FWDne9pi
 2GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709960; x=1784314760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iqinwLZKYIuEHegUtJ7FJZSt9bl8qfatLAP8QEL2pGs=;
 b=jGijNI5NZAue193jLO+252DfD7ZCY2d5mWX2S2gr8LhDJeUry9sVwLtH78sFqBFvo2
 q5GD8iAMM616whBI2eNKl3y6fILQe7gOt9cnG9sDJGyHY0gyuHFrNvROrIRv0iaJXTud
 SWaYXBisjSjfUlZxwZF4DR30ok15RQpUTST+2IlAPIXkfgqiZYSPMufq4omdpr8ix0xm
 zGJyuJ0lH6SXFfUqk+oU6EBdOKz/sDQ1TJ5c364ilPQjkHkCN0D4MYDowxk2HLwKze82
 JvdUe1M7bRUdz40SlF/xCF0148YI1zw3JUQ943ngh6HBXEHo65fXgJT1dJPB+vveCacb
 rOtg==
X-Gm-Message-State: AOJu0YyqX4jXvCpxCDKfvF+eK81zM6nzgUt55lcE20IqbPPvRx922e03
 cvIO2WVOAOe6xeLOIKK5AGKOP3ykUVAuYgmioPc0mKcbBQ24j+R915xC1TH8NbVCWmGwYqe1zhY
 XS5iy
X-Gm-Gg: AfdE7cmJdCtyRL0wTfpaJBd8ds3WSorY8QZY9keLzYcxbI4BkZxgDYi2Mx4I0Aic0dj
 vH+nGtghS1XCqwK1ePIg9JOkAzNsMq89N0EueYDV2D3V2rui2mPo2Js88tk8kyskbaYxYrQMzjw
 L3XF1mtRTvSJmoua+00Mm9tOojWL3L5QLgVf9ZsslAIb7Me4fzsH2GmBh5gZSVEafuapcvy2wrs
 TWvLkB6CfWQJuXx4iytVlK3LbiFwzQFQ76CN0n7s12GRRuD3O2QJ2pCy4iMZ+Yx6ICUcI1lkmEU
 nufvYxqg0OfiTItjbkdMwQCzbL7A92A6m8DapvLUL+Hi5cUSUPTdoVcMNxKRc0qwRoAc0W0VTwq
 W/Gtv54Jq8ZO9MT7zsL/ZU5u8HmE9JwC4weB6TzoxbQU5umb9+2SPChbCsvZ/S4+mJQqrsuwARl
 YqPAImA5cIUHfgMLkN
X-Received: by 2002:a05:6870:9687:b0:42f:d3f1:6b7b with SMTP id
 586e51a60fabf-451f13dc01fmr81955fac.21.1783709960512; 
 Fri, 10 Jul 2026 11:59:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:22 -0500
Subject: [PATCH v2 06/24] clk: mediaTek: mt7981: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-6-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3399; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DKMUoGzlsRrgYirVJb5/mAuI+btU1Xj7mvjcMGv+Bvs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCAF7RW1XoNstcR834HA9tUJEtE9/UgU4yeH
 2nkHhifZZGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAgBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8OAH/1hOxabUgT17C6lASwsNVAC7IQDklGulubts+qa
 8tISnS15Tnzy2nR9RAg4soEzi8LE26uDMRwB6HP+IpzkcKZ7AAmVv2OMd/Z1dxMVSaogEzSsKfG
 qU94lRm4Yz0n/6Ch9bLfD46sgjsRk9wuEruR/GPiIQbSR0bneFtftacj6gLFPrqpArII+Hz5T6J
 mwHfiZCIXpsNiPUxgQoow9U+tBwTmPOxHngd9SP/Znz0jHupkbRSQcWJl1916WeNfd7FfLDQteH
 +Ojg/gXlHa7QzsYpWtcpC7llZZg9zmKurU/3nCs3DWzkbpcKGfKn4imU2Xyr8dsewpeB0ho4Hap
 0Suc=
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

Add clock tree type flags to the mt7981 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 8c2944b7fb3..23d34a315fb 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -622,6 +622,7 @@ static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
@@ -636,6 +637,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
@@ -651,6 +653,12 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.num_muxes = ARRAY_SIZE(infra_muxes),
 	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7981_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
@@ -683,6 +691,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7981-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7981_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -693,6 +702,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7981-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7981_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -713,6 +723,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt7981-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7981_infracfg_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
@@ -742,7 +753,7 @@ static const struct mtk_gate sgmii0_cgs[] = {
 
 static int mt7981_sgmii0sys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs), 0);
 }
 
@@ -769,7 +780,7 @@ static const struct mtk_gate sgmii1_cgs[] = {
 
 static int mt7981_sgmii1sys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs), 0);
 }
 
@@ -810,7 +821,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7981_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					eth_cgs, ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

