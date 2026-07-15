Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56029C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB6884C87;
	Wed, 15 Jul 2026 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PTVhgd1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082A084C88; Wed, 15 Jul 2026 16:28:56 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5684C23
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso4406635e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125733; x=1784730533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZDQwbhlyAZi+dZ1nlxQRStT/59llrNi4vVgPi+uN6Vo=;
 b=PTVhgd1GspN26I72Si55hg5vSQjs9u38sE0qZWm1idqnWbSfwhh6MPKVy4822D7GiY
 fByWA6E/faXsjfePu7SlV+gQLW9H897NWGKvVB/tJ2hGY4F5sQuChfc+KAfnz9QgdMMq
 NjTcax6neVD7nWpUnLTIbAICd3IGFXoIxb1vBxE5qH0DKkxie2+fhRekVbN+VzVMapVP
 MCVNyGDtlQpBp+3iPwNipExyrERrqLtLb7rZK1lPtBbXTvtnePZrM7UgGruBm1Vz40UN
 cxYfK1M2FYrJ2/wh7OPGQPtMkhIJvvLfE2nWtZC4yRnI/K+bL/XYNcgOd72LqqaXe1vN
 agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125733; x=1784730533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDQwbhlyAZi+dZ1nlxQRStT/59llrNi4vVgPi+uN6Vo=;
 b=TFzcFyAevP4j+oTiNXQXjDC+NB5HAuC2ZpS8bVLRK55ih3bFpjl4y5Eu7JgBiysgKQ
 ukUrFjzYv+Aok76Z/aS9C1ifrMuywptvHcQ0mNtg1lkDhNPx2qi3/88DjV3MGvYif+1u
 Gitub5Vwb13/zANUiqwaPTnEJWoOfC9xngc+UiBKww+b27g7bkolyFIlXUbCfDrwtN9k
 AqK5NvUqflBTlDlLvLKllb21gPlCuxs557a7czTJsO8Q/5j9PYdDuIbSdqLDY+XSyA23
 STQD+s4EkQx9PRH+ECvKIgqwWo3+I2P5WkGd9emdyWJpyvtTMmorjvVB2yE4c8I3Cxyp
 nJsQ==
X-Gm-Message-State: AOJu0YwXk5urPsf3npmPmMIdyw0CkFUUDuA78z541U+Pq4EF8TCRK4Xg
 p4SyoI0q7VqtYU7ghzNhe7hzKO4IpQt+AbGmA4DcVbXXSLTfu/JsBY2mqX/iVHSvcQQ=
X-Gm-Gg: AfdE7cnr3JX3c+E88cx39YTN4oysqGkci5aZNI3AqSeZAorUPaiCCSkK0CB05Wj2X3N
 eqy7c3kAjtRRShjfyNnj7RQ3yziYIfD6mYym4mullpFOTDPzKjoCfhQ2wic1pRwMKWKivDtsa/M
 fbuaFAey5eo/Hfeu8FwxCZ4xLYCebPnHUZhNa3KFsQQ+HCv9fSfWuZelJnwKvUnzTbzsnsuNqfa
 H5CrCJYDKJCFnfrxL/pfWujKNFibwt0nHHFXK2tpbIwqlvwSk7RmsJDTk6Lcs/J/31NrszYE8Vl
 7bZw32pdO2VwWn9zqvRW+Pu30CBsSlivHHjZgaXnYOyGrpGwCCj1l7chOfcOY4J8V2XJWqKxTTd
 WsJHpZhPoUzFUbelqY1sL3pkJ3xqoVgKFV4Hp5jyxdHsIgUcGofGN4lN8/JfPGo8ifOBHBZdEF/
 3d2hP9gSr0Hf3XocEAkmf6vbRXhIYeZTKPp1F15sDVwer4pa9x8gnMAznztg9LYft9UdLUsX8rg
 X7wF3KC2vU9DlY8NK4k5xdmzHkG5hxzDY+lNGYaXZK5u+zPA1RhipH26dHEVUB/8UeKQiMFI+Db
 xSpn7Yg=
X-Received: by 2002:a05:600c:198f:b0:492:3237:ddf with SMTP id
 5b1f17b1804b1-493f882994bmr182933315e9.28.1784125733470; 
 Wed, 15 Jul 2026 07:28:53 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:52 +0200
Subject: [PATCH v2 24/32] clk: mediatek: mt8195: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-24-23e907516010@baylibre.com>
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
the generic probe function for all the MT8195 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 1431fe0c768..4a74c0d0b5b 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1603,16 +1603,6 @@ static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
 	.num_gates = ARRAY_SIZE(infra_ao_clks),
 };
 
-static int mt8195_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8195_apmixedsys_clk_tree);
-}
-
-static int mt8195_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8195_topckgen_clk_tree);
-}
-
 static int mt8195_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -1621,12 +1611,18 @@ static int mt8195_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8195_apmixed[] = {
-	{ .compatible = "mediatek,mt8195-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8195-apmixedsys",
+		.data = (ulong)&mt8195_apmixedsys_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8195_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8195-topckgen", },
+	{
+		.compatible = "mediatek,mt8195-topckgen",
+		.data = (ulong)&mt8195_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -1643,7 +1639,7 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8195_apmixedsys_probe,
+	.probe = mt8195_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1654,7 +1650,7 @@ U_BOOT_DRIVER(mt8195_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8195_topckgen_probe,
+	.probe = mt8195_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

