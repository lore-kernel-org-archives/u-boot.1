Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E372C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A8B84BB3;
	Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Y9wGYn/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0158D84BB2; Fri, 10 Jul 2026 20:59:33 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04D184B9B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-44ce4d7883bso802994fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709969; x=1784314769; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/jJjCp8InVF+QP5ss4yS20NZ0/5YvaA8txDn/UIjIY=;
 b=Y9wGYn/uAxSc2Pad2VhXsT+HkIdQPCEBFSdS/yEnIryBZqDrx+5A4XzbnCsXF061RY
 eL2EFuHLGwAGMdtrOc4uNQ1oBnFXYUhH6TJQvbPuwwas0dBE0LvPMMFYW0F/hym9dMvR
 FBSdacT4o8R2sKnyG3RJtXp4+MzsTF23W7H0YMzU+Q0jU4zIIAxK6IGpkbxk5vJcN9xj
 fA4n2290t0EaHKUjt1Erw4iIIyX/s0zUM3rZpvpdlN/5ComCWqeX3M7Sg7THPk1ADV7z
 mEOuzX4V0jKc2VeQcSbUnUz8LroQ03pqr8pn3lnWldrwWgO+OjBmfKjEwgBh/e6klWUv
 1tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709969; x=1784314769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R/jJjCp8InVF+QP5ss4yS20NZ0/5YvaA8txDn/UIjIY=;
 b=oRDeClY0nMgBIApKPEwyqN4snAATxtxLAox7IXi5XDA49Azju015NEIT4fdPXChXK0
 Hpjwe/WazazKnWen1AQPK3lmm9Dks4lkcvjQagBoQ97M1b/rSAiHJdDgHc2j4ka70FzQ
 UbmbWfiqIOEcd+5K2OKLoFWdRu5PwTnZlqrDezL4xKM6EwheEJVId37VZj7xC3qlNWrY
 zYdPwRTOLkeMYBemCOQ1Rj5X91LGn6t1m+k2ht6TZg0cwcfHJGDft3AXh6pw0Oulvz1h
 G4z4uqGLdyh1IGzAG+c7yGF6TEPIa1sUn6EaA3RwnwcXYFEjC00P+Czgl77WSRuIc4lO
 Ndhw==
X-Gm-Message-State: AOJu0YzDm8ToGGQiskn1uvXQQwVa9HuiEiIxfnhRH+LCV3Gwwz1Y2Ty1
 cSyOt3y9Zj41OCd0ICakPp3G0AHMGicca2xFLwRAKq18X9TQztPHyTlJZksPn9UamdvzN1LjNJi
 sJ7iv
X-Gm-Gg: AfdE7ckkS3qtFVGBnUixODCJfWSf+VRVGcytcRK/jdsr3wO1Ty8GrJNfyxXZSs2EE+O
 aaz994HLqm1axbJQJyMGIBZu9o4uGwZIp/1PWRgp0Wh+RiWab22vu7suPOzuitVOxX3UMyC3Ico
 tDFgeM5iSHuf1OZrniTKu6IwSo4iS5QGIZY3cJEdgjvmsk8QlcwchyhwwsgjQyEOBw8MQTR5jmu
 hcOSED3niTSPHDEsbldK6NoTHCG4HiT61VK6f0fC0HI09FA9a8xtzCMoMgMM+sW2jkf0S8sQ/2u
 v2fDS0HYmN+YXUS4ifuVtNdLLeLtEpYrriJOnWSO0wu7uXRi9AaVRI7PhYRnSvyDVxvmGGZnaCz
 j475eQdAzUkJtOstTOd0yK5f3vRhGtd+e2Brrbv0B+1V6jK+0Ypwhd6JvziZvNR1KhGxV4sZNbV
 JX4mOBGC2XE5O3+I1g
X-Received: by 2002:a05:6871:68d:b0:448:558c:d838 with SMTP id
 586e51a60fabf-451f174c9c3mr82222fac.39.1783709969541; 
 Fri, 10 Jul 2026 11:59:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:28 -0500
Subject: [PATCH v2 12/24] clk: mediaTek: mt8189: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-12-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3120; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ambeXEvB4wY2o9ijPg+JRNwFa3NIYlJeHqGEh+OTdB8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCnc/bwENlZ/PWcnDSCqXgjiWMsfQK3WAHt1
 SvRFthZl1uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFApxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADqwH/jnT3Qir2Dz3Wusc5hoga6H+E+WKSVNS5d6Kh75
 eqJnwxgZBAaeWVsdhBS7LEBhGZ0nQKLglrtD8gn38s1KmY9NlhCrWNnRNaGjbT2ca7OH9BrtPdD
 Y+pCjDE9UjE7ItEm0m3VDp6vYPw0ETith7jSlK0YxpvZLyep3HmImkUOvOeRbfbnCYIHAZVRfKd
 BPA42gYTLUuZbyJS7DleURnZg0Xs5lNQqyesekYnzcd23UcUclZYd4nJQOyUwJGCA9rhGPxwW8c
 9A53bggrRkGKnh2uj6BIDwNVnLNeWFAAJp21wPsDIDIA8tHNlq8hdZCddtm/17QTPcbg7PT+h9b
 0rUk=
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

Add clock tree type flags to the mt8189 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index b174e259f28..25b88198fd8 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1898,6 +1898,7 @@ static const struct mtk_gate_regs vlpcfg_ao_regs = {
  * arbitrary parent trees.
  */
 #define CLK_PARENT_VLP_CK CLK_PARENT_INFRASYS
+#define MTK_CLK_TREE_VLP_CK MTK_CLK_TREE_INFRASYS
 
 #define GATE_VLPCFG_AO(id, parent, shift, flags) \
 	GATE_FLAGS(id, parent, &vlpcfg_ao_regs, shift, flags | CLK_GATE_NO_SETCLR_INV)
@@ -1939,6 +1940,7 @@ static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
@@ -1953,6 +1955,7 @@ static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_gates),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
@@ -1964,6 +1967,12 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 	.gates = vlp_ck_gates,
 	.num_muxes = ARRAY_SIZE(vlp_ck_muxes),
 	.num_gates = ARRAY_SIZE(vlp_ck_gates),
+	.type = MTK_CLK_TREE_VLP_CK,
+};
+
+static const struct mtk_clk_tree mt8189_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt8189_apmixed[] = {
@@ -2031,7 +2040,7 @@ static int mt8189_clk_gate_probe(struct udevice *dev)
 
 	data = (void *)dev_get_driver_data(dev);
 
-	return mtk_common_clk_gate_init(dev, &mt8189_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt8189_clk_tree,
 					data->gates, data->num_gates,
 					data->gates[0].id);
 }
@@ -2040,6 +2049,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8189_apmixedsys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -2050,6 +2060,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8189-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8189_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -2060,6 +2071,7 @@ U_BOOT_DRIVER(mtk_clk_vlpckgen) = {
 	.name = "mt8189-vlpckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8189_infrasys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,

-- 
2.43.0

