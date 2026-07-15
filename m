Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1477C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A8584B9B;
	Wed, 15 Jul 2026 16:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PWdoQ46Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5D484B44; Wed, 15 Jul 2026 16:28:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1F584B77
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so34998645e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125708; x=1784730508; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p6eXtqVuEcIY0anBDegRu3QvNZa6/SpqiCybBN2TJ8o=;
 b=PWdoQ46Q38ntviCOfOWfIwwr1vowpysI5wrXL8WY0ybH3qN6SW31bOZjlbOmJzX/SJ
 AkyHb1gBw6G8ZvwOn/tmHBt0CobNASflgmuHdzSd/dfAz363keU+7djwfFx+zB2MTCQL
 7s7tsY+Py/wQ4l7/XYnlrLIiBryIJS3BrUvy2bIBJGw/estuE1F/AfRUoizoOjoiOXIE
 O0fAKhWOD3L02e3L5frpmxDjQUKWW1fp3rslc1UD6KDYuQ8vomlPZlOhSqW3cmMMz+fk
 NjWk47dIXghwUbWHWkahlLbLl1Hr7Bzxwl5bC4FoTKInJbS4ET3tEm6umoj+POE+noRe
 jLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125708; x=1784730508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p6eXtqVuEcIY0anBDegRu3QvNZa6/SpqiCybBN2TJ8o=;
 b=mwDGgA54f0CJ5j2/00HSqLHoGfKi/h4z+9CBotNyelfFlyd9uXo2MTaficcmQP1NCI
 XYOH4VvCfkE8LeK4oojN23AzLjcugvk1R3br7WgoT9nO5R23H68v3zJoAzHuqwURP3o9
 5iPSXPxXycayZAlGcafs3Aj44/oXfAkiHIxCsT5v755FcUAR8DKHTka9H8zqd1QNS0Y9
 EFUHzaASSvHF639h4n8GVd/G5Px6KM3DCjCmT+Te8pCwud7yTPqhxU/T28TfWGyFak65
 63Ld5cDe6AJ8mmaPUE2nw4u5eaYM6O6meegjFJKj5YzeE2P4pmP4xN37obKYOaATPDbK
 0+Uw==
X-Gm-Message-State: AOJu0YwMf6ee4BMAanJmvnCsHKSlNmJH7E7yfVO0rwW4MmHppkxbw7fD
 qiw2tF17BfX4GfBXnG2qv4CFXav9Aiy3M1GiZGuVOj66042Bo6q3a9zkWvdF1hq0HlM=
X-Gm-Gg: AfdE7cnJbvJRsvG8PMmPAJcuvT6xLBFRX48lmGtYisRnP4wKNqAsBUBWw0M1+gnlNJN
 6HRBWKWkdGmSrtlWL2XBDdnGOUKk+1j9Tt1oeu7pTDy8Fnp7uqpkXwh5Z+w2NAvShLaraqwzonC
 ZD5IxZ0lLQ/XsYluQxJkcWT3IXlM7wEAKZEh27aWWv1801xBhdvUx3/kWoNZt+DKNheDpRVYOQm
 ID+8ACzou7PMtfBZvyokhKYLF0zFD2eyfaI5Tdr3LauqUaA2t9LpLrifxzJjBi1EYRFZ+9WI/sj
 qGO5tzod+4jZZjHGdmPyFoyx5paF/In1b0L0qplgcIBCuH/jtaEBA2rQ9ZS760QQva75hkFqStr
 zdYIixCwlzj3+lI7RHoFjmr8hsdBQxcVFc1TYdhONY3009wTJjdBsyjMqA6Srd8uYPOhoFDRV8c
 sZxj41klyW9s4UrDILsej51jje+uT9Zby2vjncV2F4+owzAm8oN100WLaBUFbzB5f39iWz+jikQ
 eKlrUJVKhLezN1iVkFBeRVCGMwDfcFXTRLKySGSpfES+3naNYjMa3yZ2bwGXTDmBfLACxIxS96f
 tws9wN8=
X-Received: by 2002:a05:600c:3e0f:b0:493:e583:7053 with SMTP id
 5b1f17b1804b1-495389dcf47mr67619055e9.35.1784125708033; 
 Wed, 15 Jul 2026 07:28:28 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:34 +0200
Subject: [PATCH v2 06/32] clk: mediatek: mt7623: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-6-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

Pass each controller's struct mtk_clk_tree through the driver data and use
the generic probe function for all the MT7623 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data. The apmixedsys probe still performs
its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 0a648bb4a06..80bb4d8f16c 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1045,9 +1045,10 @@ static int mt7623_mcucfg_probe(struct udevice *dev)
 static int mt7623_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7623_apmixedsys_clk_tree);
+	ret = mtk_common_clk_init(dev, tree);
 	if (ret)
 		return ret;
 
@@ -1059,11 +1060,6 @@ static int mt7623_apmixedsys_probe(struct udevice *dev)
 	return 0;
 }
 
-static int mt7623_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7623_topckgen_clk_tree);
-}
-
 static const struct mtk_clk_tree mt7623_infracfg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -1108,11 +1104,6 @@ static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.num_gates = ARRAY_SIZE(peri_cgs),
 };
 
-static int mt7623_pericfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7623_clk_peri_tree);
-}
-
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -1127,12 +1118,18 @@ static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mt7623_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt7623-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7623-apmixedsys",
+		.data = (ulong)&mt7623_apmixedsys_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt7623_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7623-topckgen" },
+	{
+		.compatible = "mediatek,mt7623-topckgen",
+		.data = (ulong)&mt7623_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -1145,7 +1142,10 @@ static const struct udevice_id mt7623_infracfg_compat[] = {
 };
 
 static const struct udevice_id mt7623_pericfg_compat[] = {
-	{ .compatible = "mediatek,mt7623-pericfg", },
+	{
+		.compatible = "mediatek,mt7623-pericfg",
+		.data = (ulong)&mt7623_clk_peri_tree
+	},
 	{ }
 };
 
@@ -1190,7 +1190,7 @@ U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7623_topckgen_probe,
+	.probe = mt7623_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1210,7 +1210,7 @@ U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.name = "mt7623-pericfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_pericfg_compat,
-	.probe = mt7623_pericfg_probe,
+	.probe = mt7623_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

