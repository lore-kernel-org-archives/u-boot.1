Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC52DC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E68284C26;
	Wed, 15 Jul 2026 16:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Ow7pjgJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797A784CAF; Wed, 15 Jul 2026 16:29:06 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8B884C23
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so9211065e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125742; x=1784730542; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZsEXuSq2i3m+wwWKcl0lxS0VLnWmZlxjQmp6vwGHwEY=;
 b=Ow7pjgJEshb4OsnXsA+9lpYdX5kksuSi15v5MuTyffBc/BlufWtVqpsPUUx/PSTcAH
 4Hv06/76t+yQwr6pvQ9c54+2WWlUoZ8We3eDBmO6Zc+FaMNHxR6N8IQqZG2NPEKw65Dh
 DxY0rSu4zHeQFKBZIPZ9QctBUrULAI4zPla5jLXHTeM5+0h9Qwsazohr87V3Z/9YSqO4
 BfWEtaX3yzc+kWdXgY5SCSMmP81oC/1u1gLkZK8L5jPQRKXzO4K84BD9VKKYMXZ4no7G
 KlN1I+VFMZvtoCCNrTpc6I6RS39JvhrC1HVRqNdxvNhtYmihJjHOySmIlmlgbyinu/Xu
 FlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125742; x=1784730542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsEXuSq2i3m+wwWKcl0lxS0VLnWmZlxjQmp6vwGHwEY=;
 b=ARRFKvqVmWOmY6GAVNq8ra6b09FiCOHY4HDc1auStdZQhoXe8XtKncLYcuWUNgKCXX
 RXGQscYz9vqXCJ8s9Roz/ogIu+tQINejxVCP13dfavArgi8rqiNbGJK52LZV9iqQ3RNA
 +TuNYarjzuQsc7lwRq/xN7Nng2yGBFxqa7VNfaJAndL1NUKibegt7y/SGKbG1C3q0Cok
 H5Y02mw+fb6BxyFFimX6Vn/mLoFokrsrcxe4IM4g7uhoLsgP0gMLg0Fk1cP3s5aiH07A
 VsXRdG7NPixVZQsOcYQnkqpqDTk5ojodhIDMjcuCNhmuw0BrcjCCio9zZq3+B9s0t3mD
 idng==
X-Gm-Message-State: AOJu0YwzwUEwHI0c9orOY3biNhQbBDty2Si/fi8QLA9kBkBtJQoQXYpC
 Xe1vUzsG2dxEYTanYaS7uEi8trkucTDSGgxU+wQJe8+Mw5AM9d4rgaa58HapuJi0vQI=
X-Gm-Gg: AfdE7cmqB1n5TzochVbSJtSyr3LhFwSrJK5W5VJ/iq8eQnW4TDVQ8k1N4/op6bcEH47
 EBOny/wKsqJcHtGjQGgDbeahwuJAvgFb0b7nn7kozODTIwUMrctLuNybh6wSjeW65qj8gJ2tLql
 BMfOTt2CF/N7IJIedZFlhCXQIzDAbxI1KYH4UJuuqy8bLGBUQYUAaLIlD5j4dQpSRxi3BcYEJqI
 FI0X2/peCc/71NLvXztNyIa7ZiSQOLl0YiyZkkuaPO3MdNk8eXdoGbqHiZW3DGB00g4wfVdLdJc
 ohT6HOAzETXc26uO3jr1qjuuDYp9uv9YgoKjy9TyirUOBa7JTmlYfYQ2QA/VQ+eWrA70isZQ9Xo
 cJIlaZ+86QAYkOVZvqvkX5rtLK0w2Qpc5RfCqhL7NmPvMM7rh6rfE5auvLOnOXiVjB+T2sLGucq
 Rfy9WJkMfGn6rrTfZCi74IAgOKPM26zve91Pbm/K5ykIGET47tYbWrhWvzUQv2MHco+xv1je2iN
 c8CSeuDadnGEj5INcTuOy8eXPLJOqUooiy9KZCePWovPhuzivqTnT87TGEFn2e4UGKWvYCpgsyx
 JznjrZw=
X-Received: by 2002:a05:600c:a010:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-493f8885752mr180359665e9.6.1784125741776; 
 Wed, 15 Jul 2026 07:29:01 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:29:01 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:58 +0200
Subject: [PATCH v2 30/32] clk: mediatek: mt8189: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-30-23e907516010@baylibre.com>
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
the generic probe function for all the MT8189 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys, topckgen and vlpckgen controllers keep their own
U_BOOT_DRIVER since they rely on dedicated ops and on the parent bind()
callback, but they now get their tree from the compatible data, like the
clock gate controllers.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 562e55078a0..5600f9aae8d 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1971,17 +1971,26 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 };
 
 static const struct udevice_id mt8189_apmixed[] = {
-	{ .compatible = "mediatek,mt8189-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8189-apmixedsys",
+		.data = (ulong)&mt8189_apmixedsys_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8189_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8189-topckgen", },
+	{
+		.compatible = "mediatek,mt8189-topckgen",
+		.data = (ulong)&mt8189_topckgen_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8189_vlpckgen[] = {
-	{ .compatible = "mediatek,mt8189-vlpckgen", },
+	{
+		.compatible = "mediatek,mt8189-vlpckgen",
+		.data = (ulong)&mt8189_vlpckgen_clk_tree
+	},
 	{ }
 };
 
@@ -2013,21 +2022,6 @@ static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ }
 };
 
-static int mt8189_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8189_apmixedsys_clk_tree);
-}
-
-static int mt8189_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8189_topckgen_clk_tree);
-}
-
-static int mt8189_infrasys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8189_vlpckgen_clk_tree);
-}
-
 static int mt8189_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -2040,7 +2034,7 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_apmixedsys_probe,
+	.probe = mt8189_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -2051,7 +2045,7 @@ U_BOOT_DRIVER(mt8189_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_topckgen_probe,
+	.probe = mt8189_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -2062,7 +2056,7 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8189_infrasys_probe,
+	.probe = mt8189_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

