Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA2AC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B05F84B7F;
	Fri, 10 Jul 2026 20:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GyJ9cMF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9A684AE7; Fri, 10 Jul 2026 20:59:25 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4F384B51
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4518ad44e83so676293fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709962; x=1784314762; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=duWrKxgXuXhkgik7Y4t+C/iy2PgFSeBVCnOQqfbczU0=;
 b=GyJ9cMF4I/DBT72cH2PSOSaKz0tdyE0tcyWbr+umF6e/xypELdxrxX899ROyXqba8B
 0i/lNqXkrpCgp/qIaM4raAHS3js7jjdQC61+5NzGXxlLSToDJNQcot9HZT+DbcVLxAE1
 tRzq//8M7QAwL2qZXj7LWC7zBXGgaTkT3PxSpBs6dVBJBqly/MhxZ+AAfBgeKoCb+fs7
 i9sFEDwDyDCeumQWQpgkH3WpZVnWZ3Lwl5fAlEWZ5DHZKbXDleM0SU2JMoTU+V4bNyMT
 RAHbuyjCX/PmSwf7dCKhBqPV8B1MoBL3DDQ+S4HvG3Krk+NnkBv9jqsIXT2CHAqAHdmR
 qobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709962; x=1784314762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duWrKxgXuXhkgik7Y4t+C/iy2PgFSeBVCnOQqfbczU0=;
 b=QuhmaqmUOZZ3BecSWPZv5YiXVWY77H11sLUql7tn1aAK1xIoHmwLH2lJOGtu+Y+0NK
 wD28BhMZ/3q/bvLZHRNLoSvdDR08eqq1ufZhwaeZz+9qW9Jy+zto6O2xraEqhXthZ5ZA
 J/qLxZhBrb6vlSym7He9CISyVm0hmmbQAn85JwTlz0ZeZ7DaRdnTdmScSfrfsf1h36j4
 943sbrsVDDOjAU00hZIQHjifnfpM7Rxf6jqNmVyQdY2+g5aSgA5A1owWpa2K+qaXN+Jn
 CrOotyi9MKACw/macmrxtuIdL+KqJR3K8Nfhjj+LYg4879M2YdImf4zqcB0ZsdaXBZp2
 CJeA==
X-Gm-Message-State: AOJu0YwjgiknMSuz7Di4BsS9lEaMxyEnVD1/RzhlUsFFWGA/n54FiuHU
 Zr06SIYGFqEAwAz8WOu55jRYn2lJRix+3n9iM46IscLlJafSUbc+aan6Uv2nkhuQ2c1lpuUr7Bb
 NfOst
X-Gm-Gg: AfdE7clZiZDe5xNFQsLvRpyTQxRjNqVBcUkNb6eqYbMT10fqKV5tPB8a1YR+rss7v3a
 /aS6ThsluIMhEB+WPJrn+PI5aqBmNwM7On8T0U7+FTArz808cecoIGwZYr9HEzhDeQolEFz5IRI
 7T5QJXmvHOG1P0Yw/vtxMDkk2zK0y2nbX1vLtve7sHntrAuax8rrs0E4l4+6Fuw9wRTCLErhR9Q
 sg1DY6I89A9CMVVkfQOTF37vWhbG23HEpYXx8VhQYf3M7x7weqxKt7MPQnCkwMOeLsNBeFqVZo4
 isvoAPuh3APyCGYeivB1A7Gg9FWe9D6SrJtfzlnZcM/U6sVUYN+4ravuxwg+cIuQkRtAP3riUMA
 WAddP5/THxgMk4CsxTPqLMnG1lNk756mBbc7TY6XtYDOdmrccsmzYpfmkDyN/ntooIShIFSN3BE
 0kUnhaI8ZqlMEJ1cCa
X-Received: by 2002:a05:6871:c910:b0:44c:ee40:cb6f with SMTP id
 586e51a60fabf-451f119087fmr95635fac.19.1783709961940; 
 Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:23 -0500
Subject: [PATCH v2 07/24] clk: mediaTek: mt7986: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-7-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5w2s8lpQXatL6nN+V0U4gr8gIG+ISa2Ii3OXR5N0Tp0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCG5UDllNnm4uXOXbvJPtGWuHvbPa97vNuJh
 ohrw2bhlEyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAhhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AIQEH/jPfWVC+phLjGrqa5aT3o/jDwfRCNSkZQKCO/Xc
 T/Cna8v5ZNgptVq3Nt/tpdFd+3ul8JnONA7w2QfiaJEWY60p3o8xWcNRwFqG9mZBi0/D8D4DM5/
 SH+D+6EVG0Gk/WSPEhBySvv9GYqDhtiXVysfiZGyLkdKlsNAs+yxuuzKpSkDvcklDj26i6AWbkH
 8D3diHY3d7P27E4wIMN/3IfFVNLa9bzhjhuQt3nw/1L97vcAvSaFuALSJnHGWD3SFxS48cIjabJ
 HDtdPodWh2hlJ1aOBsQa7lmBdMD4798PTXc2Kc5d85K3t1DyjcA8OY+SVBmONTZBghS8IVhUjxA
 o4us=
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

Add clock tree type flags to the mt7986 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 9c6514120a6..a5301fbe8cf 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -530,6 +530,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
@@ -544,6 +545,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
@@ -559,6 +561,12 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.num_muxes = ARRAY_SIZE(infra_muxes),
 	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7986_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
@@ -591,6 +599,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7986-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7986_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -601,6 +610,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7986-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7986_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -621,6 +631,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt7986-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7986_infracfg_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
@@ -649,7 +660,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7986_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7986_topckgen_clk_tree, eth_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7986_clk_tree, eth_cgs,
 					ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

