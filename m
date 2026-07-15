Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE67C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE66884BBE;
	Wed, 15 Jul 2026 16:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bykcaF5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4868C84BC3; Wed, 15 Jul 2026 16:28:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C1F84BB4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so49326945e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125711; x=1784730511; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=enGkhhSIod1a+YRJRvPwE+LWjCOzuw1ua8GzHOStvrs=;
 b=bykcaF5uSIs3+PuPtm5FVjPH8ByYh9VyCdaZ+RbHfd55BxN1RLmOT713puFh8Ezj7u
 fxijV9YRsZ1pqHFMp1OGJW5wETWmD0gTBNQSqfXDK61L6LzaNJAeLACLtwYPOE95HjDO
 H384zgyWoiKtqzBQJMblNwg/Cp/RleB6Eqjr5F2NqrSD6xGSthFYINxh62BJHHFjagEI
 sfCFGIfkDj14ijoPf/WFrX3tnGzxPSjaMC+1pLCePESq92qDnYAB+enwYhFlKSeicdOF
 R+GmTdVdAsUxFcWLcA0qzKKU+ryTJjbv7Nyi48UZE7hiJpcELctr/Cj1zV0g6mWGzaOh
 M+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125711; x=1784730511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enGkhhSIod1a+YRJRvPwE+LWjCOzuw1ua8GzHOStvrs=;
 b=PEs4KkyMkL00qfR7I97P1R7FHCA+T1p5foh7j5o+8dyQQUF8/AadDHkjc30c4Qu5Di
 XlqFk0gNifTZ9WZ39QAFHvJZ0Pq9Gm+iOuVcI74bQ3U7C5znpc+vWRLfCiaoglEln1wC
 yaytjlEVaab6PBPtxztl935sCIOsKuGx0ygdLM6n5ooyKf/BvdFTYbvdpoKKydog7pda
 29CZDqAuNAl7UJ61+KoGn9Pup7wtRSJE4V+whO9oZt2MEkQgY3oF8AlyuM2DI4zcoDdt
 uVckQYgKX0lseZRSblPyHhC5WpMOOD5VxDnxQs65Vc8/gHCJxD2RMDejA1afe9kwAncw
 +5KA==
X-Gm-Message-State: AOJu0Ywa+4m45kaAN8LKSzOO25taSW2X/GEE/QUMcfK2AsNCQBdyyZrD
 AsbgOuAE4rF2uZnsRpuuLCTh7t3oRw4GJfUm0/mqSnHdhr6z1IOEyaUJav29gi3U2RU=
X-Gm-Gg: AfdE7cnFafC88ihTFAKUMIHJyDe8G148SNw1EXbdsqS8WuYpte718fnzA/hxUpmBDTD
 QM1r6GfSPKc7VlxY4OwzoGZD1Jp+aa9d5fEq5lOEauPC+qG1i8qwe0gL6lwSRqqGg4VzLfEjClb
 AgCBMxpB/y0v3P6/4Bo0NBRymp6L4I2d6JBBQy629D4zT+3hRs7M8AKDra49Q+J1Qm/4hQaj605
 QHkcj7VdIhN9he5Ag/oS/4/8rDV3wzXLKcIWhIAcN/FCuRjJjOtuZ3pISPegOtDPbQGzAvJDSdu
 ozWJsWdLwq3Gyx6Yv2NHJPUEPbmMSiY3Jc6EdYnMLTi4af+voVQld+VgSi6ay/nBQY/ex9BIdJD
 jj2oSTNBAOF0j4O90xBQCCZRuQdQH8cq/Mi8uJtfrZwAFT/jJeCGkdJurdJ3yeyrpa4R3otX/Vw
 boeNd4BL+R1KiEFiASdJufMb1ZymaZbLWGWBAoXq5rpxch+21sX5YFrHbjDcY2pfm3GQ5tk9pLA
 lWoWkyjmNjuDFHdXYtqPQvMgLhsN9FtzNTRqPIKwzC7wMbqOmMve4k2YSliSPmpE+AKjIR9
X-Received: by 2002:a05:600c:c83:b0:493:c84c:2b57 with SMTP id
 5b1f17b1804b1-4953c28b1a6mr31882875e9.29.1784125710538; 
 Wed, 15 Jul 2026 07:28:30 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:36 +0200
Subject: [PATCH v2 08/32] clk: mediatek: mt7629: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-8-23e907516010@baylibre.com>
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
the generic probe function for all the MT7629 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data. The apmixedsys probe still performs
its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 2edf085970f..4bacabc8556 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -654,9 +654,10 @@ static int mt7629_mcucfg_probe(struct udevice *dev)
 static int mt7629_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7629_apmixed_clk_tree);
+	ret = mtk_common_clk_init(dev, tree);
 	if (ret)
 		return ret;
 
@@ -668,11 +669,6 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 	return 0;
 }
 
-static int mt7629_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7629_topckgen_clk_tree);
-}
-
 static int mt7629_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -694,12 +690,18 @@ static int mt7629_ethsys_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mt7629_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt7629-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7629-apmixedsys",
+		.data = (ulong)&mt7629_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt7629_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7629-topckgen" },
+	{
+		.compatible = "mediatek,mt7629-topckgen",
+		.data = (ulong)&mt7629_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -764,7 +766,7 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7629_topckgen_probe,
+	.probe = mt7629_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

