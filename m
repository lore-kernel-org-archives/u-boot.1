Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A70C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE7184B8D;
	Fri, 10 Jul 2026 20:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="B9u0x6Vf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243E284A78; Fri, 10 Jul 2026 20:59:29 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D5484A78
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44856d185bcso680980fac.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709966; x=1784314766; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=boSlCEwbj6V2NSPC+A6GqUCYRlu4i7FVcP41BB7YVcY=;
 b=B9u0x6Vfm0JWAD9sbzaVoaQ5NeRhIiN8T5iBkb9B0OZpnZf/SWQLqtX16NbDBRv2hd
 8COZzRJDVr714Q6ZaJB6YiYymAs3wzTmsf74xfQg0m5x1zQpzILkubs69+vtVf3zqRMy
 puQNdWMxMs6+h+OfyodogZGNVqi9bniZjHpX5fqGDkJ6Sg5nMokNLhAF/wo6OEr/PMNO
 IdUk60a//dPyvV5/RQZFpAwlP7jlEzi+GVXJK4ZhN5j6botQl/nSCexLGfyaMp3yxfKp
 edIlEb0j2FAr//kFyOf1sCHO4QDtk8CH3PW9qWAoVltfERiePrYvRSdywsPzmClA7LpX
 3Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709966; x=1784314766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=boSlCEwbj6V2NSPC+A6GqUCYRlu4i7FVcP41BB7YVcY=;
 b=YirOgghrshL8Esp3uZZvZCrgBjJhgH+0atY0GKkZXAMuWGDjJVdS5f9/jusW1U6StW
 jdDgkVX2QYsLeEA/0WHznScH2RtLj6pAQwI0Z6Bk5bKWkJMAsnVSkqhbtyqQPhwsfZaG
 68oEFGRNqXu/5y9ORmqJPxKCq36hgKTrtqEVPIfAMQ6OtRz1zBP73Lp8LIuXbI97HuFT
 3DukSzf242deNv8lKA6J5gTPHP/viGOpDrQZmIqmBN6o1AgRqRltWFW98jsbldISK+Gt
 iNTvDwb5GCrFV02I1DBQd/rm5xYztOrJAVyKIkhZeaZw7g4rR4x4XmS0fYswx4/LvYhO
 +WTQ==
X-Gm-Message-State: AOJu0YzSw6bw5554jaV3SXwBtjSHkFtYfBKGnUp8GOsixAIMaZSp0FD5
 CsekXq4aHVbTnCzcxm0rt730SU1l2vzHl5V/rYTUJgOw9R1f1Mpgn8untsWPvVdNZ3miG/bUMnU
 own6R
X-Gm-Gg: AfdE7cl7TiijGY5J/y2i9sca2iSwCqSpI1fNyQMkIo3olCrBNIub5D9/6RaBJ4t5HcB
 IG1TE1vG9c7PT3g9A0QPw9fmdbU5svWcn8jCPRv/ILTAtYWDgLqEmtBqT9x/d3/MRJWLz5NI+DP
 DK1JG9s8O3MTwMQcYo/4kQJwk3TO7BqZdTZbwHcGjD+P1zGJg/fBxTACVUA2XqW8t9duGhZnnfD
 7Xb3EvUnu5PZlKtTPFefINWbhrf1gPEjPTj8Nve7wZ0FkSh9mCoehVkQ+1WanZGNUqSLek1Bt/+
 UmRFjDqBq5UHFnZUyM7+W+/0Cy9axhX/GpzT0vwM8X7efmPQE74dS2k9yB4c6Lph1FrUEystj/a
 TCaKxnoJVBkkZSyK62mF2wPMB2QrxmheDCRQZ9eevS52RWUga+LbfmMFRnlw2yPTHYD5eobZSgi
 li+7gh9YPCCxlZk6QV
X-Received: by 2002:a05:6870:8449:b0:448:5591:15db with SMTP id
 586e51a60fabf-451f153e29cmr79934fac.39.1783709965688; 
 Fri, 10 Jul 2026 11:59:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:25 -0500
Subject: [PATCH v2 09/24] clk: mediaTek: mt7988: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-9-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UNjbkyz/fMRSpzmuQt2rNA2yqVEEHwze/dY3aoNVAA4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCTkdT3dk8YUW6t5695zIGe+2Y7tH89muvnY
 KIqGDfnGRWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAkxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjwkH/0JhQH03REuZokQJIjKzwG2mPQOuf44WojLZYW2
 WNaWZ++Uz2035TKg4SQ4OaaoeO81/MUX5zXjcc48ZYFt6wg3mBEO72thM/8a13KADvpixfCq98k
 TAMe+SR/it/HOlwhwR9N+kgRhQL5l9pGbVX5iulmNX7PmOL9Df3YMHhYM3oRPFS+H1Yyb8Psory
 dfAvBxooWze2huefTAQriBjiOzM7YZ62lWE1gGjYFV8oA+Ncz7IxQS9p3TwpUt5qTBjPDO4uk9i
 kaM4UaVZN8/WXPGGeMVYjIyIqZBcpK6SGU4MYMabel1OB/0zG0AvTXD3UEQqSydXQ7no0IAHH75
 aYGw=
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

Add clock tree type flags to the mt7988 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 4e19f285da0..309b6e03ceb 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -808,6 +808,7 @@ static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
@@ -822,6 +823,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
@@ -833,6 +835,12 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7988_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
@@ -867,6 +875,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7988-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7988_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -877,6 +886,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7988-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7988_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -897,6 +907,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt7988-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7988_infracfg_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
@@ -924,8 +935,7 @@ static const struct mtk_gate ethdma_mtk_gate[] = {
 
 static int mt7988_ethdma_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					ethdma_mtk_gate,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree, ethdma_mtk_gate,
 					ARRAY_SIZE(ethdma_mtk_gate), 0);
 }
 
@@ -983,7 +993,7 @@ static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
 
 static int mt7988_sgmiisys_0_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					sgmiisys_0_mtk_gate,
 					ARRAY_SIZE(sgmiisys_0_mtk_gate), 0);
 }
@@ -1028,7 +1038,7 @@ static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
 
 static int mt7988_sgmiisys_1_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					sgmiisys_1_mtk_gate,
 					ARRAY_SIZE(sgmiisys_1_mtk_gate), 0);
 }
@@ -1075,7 +1085,7 @@ static const struct mtk_gate ethwarp_mtk_gate[] = {
 
 static int mt7988_ethwarp_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					ethwarp_mtk_gate,
 					ARRAY_SIZE(ethwarp_mtk_gate), 0);
 }

-- 
2.43.0

