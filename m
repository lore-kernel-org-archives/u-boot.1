Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCFC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45C184CB1;
	Wed, 15 Jul 2026 16:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PmlHegOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C873884CAF; Wed, 15 Jul 2026 16:29:01 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A1284C23
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso10824235e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125739; x=1784730539; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fu+3hoVVVBBvsO+gsr57izt9NXhnug0h2Dr87qRG0fs=;
 b=PmlHegOBeIOKPA1F6kvzYSAQSX/5XR7ZytY7twizuYG3QrdU++oajXEhHM5l7l7v62
 S5346EohadisyRLZ37GQ+Pnfb9mioJLhdfk9kLz9Lsy4Xs6kDx1wWV2430gW5ZHSVJQo
 UqAcBJpgMCsX07qGADSeGjaafr9GA5+DJsBXUtyQQTRN/YulQQJjXQSdi/6fvPpIRyW0
 sJ2Pl2Ut4mqugESoWVYH+9A9CKtLxrn+MfXJIxii7ezNZ+6WaDH5XMh4kbTIioQRMdmn
 /KMTWpUIzfMeSQvSERddbJIEjR+IOcA7Cg6ImxAJlGRAp3Vq+77CxSeo+y70u3ZGL+v7
 8X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125739; x=1784730539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fu+3hoVVVBBvsO+gsr57izt9NXhnug0h2Dr87qRG0fs=;
 b=PW4kos9MJ1KZ4JwaNT/5OVKKp14RZX9kusXYZMHt5wNDf1QO/ro2ErAyiYo6t0PqdB
 HuVwy3rvQaQZ83xRrwJ4hxsxm1wTcLTa4wh5TKlsHkhh16oBoQ0qJHOX3kbElF6JW/rR
 GxjI1Klu5Q/fkUCoSxFqJayB19Y2qUIZ0i5TrU/JOmgXuPtHmm9iGySgUIDv1wNMlZIR
 iOf5IK6cdgGndPDj9YRMQf1lzw1l/4NMTvM2lH0jvJJwK3AnHMTG6px1mfRZDNBwqrGq
 gD2hv4lxMJ6VM9BbIfALFaOt/E70+RyiQDuvP5gLkkdTUnHdwA7y/Rx49rCJS/GV/mBo
 1mLQ==
X-Gm-Message-State: AOJu0YzMzndcQ5DMkWb0mvXBN0SUvIliaFVUuXx5lpQWY/hU+FPX7n+T
 vaxhuhXMkbdX8T2JG159JcAK+RZkw++nDyONFiGKOGsXugr/VwMede3k1cCnKjlN3UI=
X-Gm-Gg: AfdE7cngX1u1tiz24hzSIDE0ssuDGeU4jsVBGM6eum+dXQbDOJTDbdkhEiaDDGsxOg2
 +D7mPBppj2XTokeAsQI7qu9jHUP00LYhJWYCiYbosuconT8X0afMvzEZ0rNta2RQm3Zd3HEZlpZ
 PUojmMaZLI1W/tx4/mcapls2hbSWlN4nD/aTSUxahWcKnZnZKPBsxUn11YWGJ+UQMkbb8xKGuLS
 VdxFtBmXnVmQfL+FouevndH6SstmCvf7b3KaVkAsnf6my1BrmzWVGiBvLT7ZT+jL1C792hDagds
 ItU/CgnYIrO+e/6/GYkhcXbYS35XhYOng4bCrIuA2Bq7sGDra7ert/PoqG6UBftKG/HVgIv8o8F
 sY1eMJZXRE7ll1JpsQh7A4KQ0moXolmvcBhNVNbUpZmQksS9K92aUSE1ARoFbIOg28frUKf18Cx
 KjUOn1f4Z7o0MMKbBuz0JNdKCsn5hlLL8AYjUIsbYPzaGdT2C0Pu2BwbsFaQosKxQALwzfDjJnx
 SPUOYTYBcc7cNUnf/VT8B1VJqLvxoH+kq2as6HvrkasCuIMXNGJg2aAflbuAa71i2LMWHsv
X-Received: by 2002:a05:600c:e558:20b0:495:3d50:e671 with SMTP id
 5b1f17b1804b1-4953d50e9dcmr21849185e9.29.1784125739036; 
 Wed, 15 Jul 2026 07:28:59 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:58 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:56 +0200
Subject: [PATCH v2 28/32] clk: mediatek: mt8512: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-28-23e907516010@baylibre.com>
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
the generic probe function for all the MT8512 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 5e61f80d37e..7895448f4e5 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -829,16 +829,6 @@ static const struct mtk_clk_tree mt8512_infracfg_tree = {
 	.num_gates = ARRAY_SIZE(infra_clks),
 };
 
-static int mt8512_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8512_apmixed_clk_tree);
-}
-
-static int mt8512_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8512_topckgen_clk_tree);
-}
-
 static int mt8512_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -847,12 +837,18 @@ static int mt8512_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8512-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8512-apmixedsys",
+		.data = (ulong)&mt8512_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8512_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8512-topckgen", },
+	{
+		.compatible = "mediatek,mt8512-topckgen",
+		.data = (ulong)&mt8512_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -873,7 +869,7 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8512_apmixedsys_probe,
+	.probe = mt8512_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -884,7 +880,7 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8512_topckgen_probe,
+	.probe = mt8512_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

