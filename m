Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5B8C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B8684C5C;
	Wed, 15 Jul 2026 16:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Xbo6mXqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F30B84C39; Wed, 15 Jul 2026 16:28:50 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9B884BB8
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493ba701891so17934235e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125727; x=1784730527; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2rnvZn8n9+FPD6Ve93miKw94Uwa+1SxTt2PqlBPAluY=;
 b=Xbo6mXqbZmpK61sRq6VOWFXanOECllwT/K/YXlSTtynFGbk6uy6jX0lmUxILySu4mR
 iXQlyq3TjESKBbdj5KmQvKWWtRc4rQm8cKsJzJXGG13iGPOBelbLdP7AGvE0GVxSrcAt
 pKHPUAvg29QhUWoF+nzQfXFQXyrfWCj6TbHHI9YVXySAUUh+2UqMUFwGJ3QQCKBXMqJa
 0Q5aMuUKNdpKpI+6NhTwA+RmKtpkpSPb+AB9d/xclbO4tyPXMxuMdXd9isDsLpK28+L3
 +DPGKt7bNU2GEGXMiB7HyLMLpRsvdU6NnmHgMJ1CDWw99EeW1b4PVTA3wgnhFTh+ekNK
 XFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125728; x=1784730528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2rnvZn8n9+FPD6Ve93miKw94Uwa+1SxTt2PqlBPAluY=;
 b=BNWRXm/BbrWSDCh1MLStCJDbu4Ov7oohL5eMcMsehFo8k10pSfu3YkTjA149YQUBCc
 77/YEZh2bVD6Opo99/GEZ+L4wLhVOYoFpJjzZK1ebm1QfvYXJ38IT7WK4d7iyeadSTyN
 ftW5Eac3ggSMbLcKKLEJClpGiAJ5O3x0VFzxA57bbpQevzewT3/0RsGJNL48T3hRuFUw
 RM8IFsCCakGpGFaNc/pltBxHhv+6HRh0cweIRRIJ7uZQbZ0Frh79vFtXU39ddxTrcDch
 48Q04M26v2jBVzaRvRNcft8Fi531x2ny+XLkcwLgHRw/YJkxIXmoslzNSvUPC9zD6iKh
 +xpQ==
X-Gm-Message-State: AOJu0YyRnbwU8u4CRrcSkpJdshYw0yvPrZDF8TY8bJlicov02D4Qr8RX
 +9keKPIBQyi4vysWsSw5VTx0nC5JWAfQ5j6VmBMg5f86B12GUbuA1Yddm4p8YZTE39c=
X-Gm-Gg: AfdE7cnXbNBqfWeKlxvQUq0DOLf80yL8lnh2d1OHqx7SgomVj3STNSNMAlP+KU2T3RA
 g4Vc2LUmagI6vzBmuvhUzc8TrulDfCVz1HWprTxDAhUjPYbv9DVNR0R/mrrC6g6J1mUM4VNWN+g
 kq0qkxYSGdjIMxblZGLxz3u9wnoZnUltpxEazgh/5HsvJhyJPTOneIvBvYOyT2EWo2rpGKtJGBV
 GhEORR8nymvRY+rGEJdlZRDbOpWu8oZf3qzWoitg+Y9qyO08ounwQptZOdSgmUAghanYa8lYLpE
 Gj0IMWiZp07zbK8vqtorq3bJl4+NRHtg/qqFa24ku1qm4lp3zewG5xwqhLZz3nvtCUylpuvPUCN
 nghi9t93D7+VdqTBDnmNT0UUqNk3nBXXrkT8RCacmQ7E3B2YqFu2TMEDKs1h8XNAfc9aG/1KvH4
 ozLltpFN13Kfosi6/Cp/4r4mza3hUnzhxXLcmfGzRoyT9/rq2+tRKUygQhb3qYd5HPcYtizmJhK
 w5JgV8ydJf9OCzeDLaULveVTGHJioL1maKaRoIgFcLlq/7wPLPanYqBwYxzJgOCIn7PqKya
X-Received: by 2002:a05:600c:3f06:b0:495:3c8c:c16a with SMTP id
 5b1f17b1804b1-4953c8cc25bmr34887405e9.0.1784125727523; 
 Wed, 15 Jul 2026 07:28:47 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:48 +0200
Subject: [PATCH v2 20/32] clk: mediatek: mt8516: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-20-23e907516010@baylibre.com>
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
the generic probe function for all the MT8516 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 53e32d12445..35b04ed5429 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -774,16 +774,6 @@ static const struct mtk_clk_tree mt8516_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_clks),
 };
 
-static int mt8516_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8516_apmixed_clk_tree);
-}
-
-static int mt8516_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8516_topckgen_clk_tree);
-}
-
 static int mt8516_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -792,12 +782,18 @@ static int mt8516_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8516-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8516-apmixedsys",
+		.data = (ulong)&mt8516_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8516_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8516-topckgen", },
+	{
+		.compatible = "mediatek,mt8516-topckgen",
+		.data = (ulong)&mt8516_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -814,7 +810,7 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8516_apmixedsys_probe,
+	.probe = mt8516_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -825,7 +821,7 @@ U_BOOT_DRIVER(mt8516_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8516_topckgen_probe,
+	.probe = mt8516_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

