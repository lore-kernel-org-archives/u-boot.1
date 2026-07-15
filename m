Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA84C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F2784B55;
	Wed, 15 Jul 2026 16:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="W1ryKcTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0EB84B48; Wed, 15 Jul 2026 16:28:25 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4AB84A6B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b1710405so30211095e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125703; x=1784730503; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPwnugKsXz37W1eLtJUYd2QesB49tcljgpiOx6nnzhk=;
 b=W1ryKcTi418448JqDjbxDAXsaD4Nm2dIkqwrlo0KRJVAEtQIhuOAJfCFsse3A//GGi
 3u0UyejMVIl0TsHqjsBhLYOuT9HAsXg44wrwYFg+p73p0vvnqA+nWwhu0R2JCiMdR90u
 zY2nh756IKq/fGBlr2NF/HzTiKLSd/3jB/7mjqD4xaeyxs5IHsqAEC7nAETQbXoFp4mM
 r6yaxQfVZnl4aii6zLiUiqklPOAbYHNvCV8SHqTjpQrWY9ko5rZu1qpVfGKfoPwvL+nj
 1gA3Z/JXKefd8zA+tZyPoP3eUsBNsQRTVp50lJSCWSsc7XUdnA1swHufdHnsunPok2tb
 Dl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125703; x=1784730503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YPwnugKsXz37W1eLtJUYd2QesB49tcljgpiOx6nnzhk=;
 b=AD4jfwjy11Kyd46rHBRqsPEnGTSDMAhzsKwHZcsSXjmistawFJRCDRepK7jXvxAum3
 fTZjo8v38DDF5FLY387hVV8U3wq3ao6isHmyJvV1e2IffQVluf032AWTx+13nZjD6dTg
 TiGCNllihqUoqNTIt4LD6RUv9LpCdK8zn3Xp7MsRTvbH8WQ6Li44F8wpPTT1+kAH5OTz
 2lFm7Dmk8J9w5RLocDArtJT47n5+GcZkKDbCn/fneNNwsPMeMe0sLsVApM/gZhgHkTut
 QAkYu0U0NirDgfeq3HQTUchddEba2Biz843IgkPFzKchdZ4quNGv10aBev3V2/aEvteN
 JlJQ==
X-Gm-Message-State: AOJu0YxBb/LF6eCOMtdVY+sjH0n+7gP3X0p24v7YJNZ1az0kyAe6nc0T
 v47u9s6BJ7rLcuWhSJpG/t929X3VIhI00pQLS+hOIGcPy13BYiUWsHixI5mEwXXmrJE=
X-Gm-Gg: AfdE7clUGesGuisqy/4mNlOD8apXgpJMURGh7DDq2fckRyB5YXRcqd8tl1sjZrxRViQ
 xbXlCWq72lb5pW/scSKMB3PCBzPVh6Xwu9ftv6WLLDhn7PD+5IIXIsvc8rJOTn3Xqpxrw+JhNMc
 Voo+2Iwsh1ESxjMcVBRKRpTLeSd4tBOVtrcfqIGNjy5zsat4wd4QZzzwJF4KzFAKkAmuLP1rPDs
 pynSAXj/spqFCS3mjqn2M3vOH8SK9nu524BkQtpP8tKMCmZYM0rMK2w99gl2hyvcqjCKmUwZROC
 dD5fXJE28WcL99diLSI7gPBick9UX4zjxRQhUcmaAOwaR2+WUmvOQ7V2sr18R0McRO9wtEzLnVi
 IgpR1cN6mticp3vUU3okfF3dbNB16/R9d/nONmYEnBf0YzCS2tIVCwNHmsr/yp+98Xro+k6Yiad
 +mlnQEGfmW3zZPPV8T+rmUHb2tCcGELjdd+FVwSwC8oDkZd/tNKcvr/vvSEQg84wlZYwIX3gCku
 eND3v7RoRFTIFaCveyJTAMNPk1lwBp/gyBc5sSHcVmUDi+dhDO8SjpuqB6vOb9hjyYPjE+Y
X-Received: by 2002:a05:600c:6216:b0:495:4047:7ed2 with SMTP id
 5b1f17b1804b1-495404780d3mr6959995e9.32.1784125703047; 
 Wed, 15 Jul 2026 07:28:23 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:30 +0200
Subject: [PATCH v2 02/32] clk: mediatek: mt8188: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-2-23e907516010@baylibre.com>
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
a single shared probe function for all the MT8188 clock drivers, instead of
a dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
share the generic probe and get their tree from the compatible data, just
like the clock gate controllers.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 9f7373cfe87..3b4952db204 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1722,16 +1722,6 @@ const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
 };
 
-static int mt8188_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tree);
-}
-
-static int mt8188_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
-}
-
 static int mt8188_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -1740,12 +1730,18 @@ static int mt8188_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8188-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8188-apmixedsys",
+		.data = (ulong)&mt8188_apmixedsys_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8188_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8188-topckgen", },
+	{
+		.compatible = "mediatek,mt8188-topckgen",
+		.data = (ulong)&mt8188_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -1779,7 +1775,7 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8188_apmixedsys_probe,
+	.probe = mt8188_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1790,7 +1786,7 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8188_topckgen_probe,
+	.probe = mt8188_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

