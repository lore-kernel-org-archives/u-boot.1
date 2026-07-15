Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F03AC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FBC84C92;
	Wed, 15 Jul 2026 16:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gXxrZnIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEAC84C5A; Wed, 15 Jul 2026 16:28:57 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 776A684C87
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so4839403f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125735; x=1784730535; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IMn+gKYx7zPc2FZ5nYhY7F2SHWpWoWcRUXVIPwE+Koc=;
 b=gXxrZnIWGJdFJD6BRnQDmlSbqxMK6LK/rejRj2iTh4aAAwy3WkJYRrj9lxqNBIQQCr
 XMdXiqVrLB8i6mXPGQR9GjQpuXf8ne6FV0HSQgxSrwCxgqxSb0mGEVsC/RJ9rc/5cT47
 zPJ0hnotAZMoMEmVqi5UjlIkyXADjz1k+shaqyeqrGUZcR98MPlqs+i3isdKQ822vq/C
 I9hDDbwzLTMLxe4DC9cpH9wnKK+d1nzBklT/WAbpQcvbBMdoUCyAPJDU+pVZZVnmyKwh
 qgEf9Be6njXggUfKLAGpPX5qKAqFhn6tEG/7gJKfi/wiLIVQKcvwJegBTwVPXzLyNP73
 VT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125735; x=1784730535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IMn+gKYx7zPc2FZ5nYhY7F2SHWpWoWcRUXVIPwE+Koc=;
 b=n3rhHnlo0752DPtxt7PcKQAIj8CoqvycFCphRJB6ssK5psRrxMn/RqEb1CSse6+V2h
 KJ6Ly87no9JsB+fZtFnpfR1AtmUSNVqHvEsDkPsSK1DusWTKjf4r+ZPiyFgavNL49RIX
 x7JD+N0ljgZwSOLpL4ZmfLjZ0OGWlCmRWt8WEeXY61YK6yKV77Ta4EddadakwFVGBtfl
 +4DlWLx+7tTR6vaGPegX9UfOh6k3ayG4KPBFriX2QjzDwYMVykaHc18iLbhaORIXhvoI
 vstBv4Y8OcxMARCdGlz8JcMQDj7d/YKEffr95pAt1Ea0tAFzyitO4SaQ2TIFXJlkG8qA
 qRvg==
X-Gm-Message-State: AOJu0Yy8C2U/hHxqIfJ4iv0j3TNFGSA/gdpPjVMwp/YYlVo+QtxBgws1
 Lv7IpRi38O8LH/D7X1IXhfmXqV/pEfHvGv5i1FKPUsLgIP13KZvTFuTzadudx2L37+5xxgF7FKH
 s8eXXubk=
X-Gm-Gg: AfdE7cnVey7Ef2EGDLPBPwnc7/LXZzxKD22eh2+kT8WcUiPEvvXRKSnOhehs0LB/lJc
 1ei28fsGNrI3XWMiScaJVz0MJ74ya6ggBS8wRQvvcojh45QfE7JaDtweKLxXbxx7l+ad1yjfIpE
 ClIK94MzC+P/a+3fZxY7QmkOafS6k2DxxMhxeGofUhnIolzvPJ+QfHsoT0ED3AcMsi90i1bZC08
 /4FVqguOsa5tJtALNY7gHuSC7dqptLgvydqWkjobZ03tC1Z5eEcKA99VuzpeaFmmqKBzsre2Ddk
 snCH2oPDMZmb7/ydsG1QLOmdpy1IP4QQJFVI7mStkH9tsbZsXca7OxjQOTnncHU1QMugFOnm7+T
 jsjVWqfUm89MVdQPPf6t4Zaq1/u2K9AAfxQ0eofGirhXQLcOIpwLOatXUbjs5e5SyjE20kEIR/p
 /YaPkclopvziVbdYiZ/9SDP7bGsHQFdI9RW6ev9nn1rRZIgG1/p5GWHYdWtt5lLptZjtHRLaeEY
 GTo2HXfQx42NkI7qcHHgOvbDji3783VwzuK8uv+Bk6aajHFZL5ds62HEXQ8Mx+riDrxs8nBOHRs
 t6yaZKQ=
X-Received: by 2002:a05:600c:348e:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-4953c157dd9mr35248225e9.11.1784125734794; 
 Wed, 15 Jul 2026 07:28:54 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:53 +0200
Subject: [PATCH v2 25/32] clk: mediatek: mt8365: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-25-23e907516010@baylibre.com>
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

Describe the infracfg gates directly in a struct mtk_clk_tree, reference the
tree from the driver data and use the generic mtk_clk_topckgen_ops instead
of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index bb00d6154e1..748549f393f 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -757,6 +757,8 @@ static const struct mtk_gate ifr_clks[] = {
 static const struct mtk_clk_tree mt8365_infracfg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = ifr_clks,
+	.num_gates = ARRAY_SIZE(ifr_clks),
 };
 
 static int mt8365_apmixedsys_probe(struct udevice *dev)
@@ -769,10 +771,11 @@ static int mt8365_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8365_topckgen_tree);
 }
 
-static int mt8365_infracfg_probe(struct udevice *dev)
+static int mt8365_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8365_infracfg_tree, ifr_clks,
-					ARRAY_SIZE(ifr_clks), 0);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
@@ -786,7 +789,10 @@ static const struct udevice_id mt8365_topckgen_compat[] = {
 };
 
 static const struct udevice_id mt8365_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt8365-infracfg", },
+	{
+		.compatible = "mediatek,mt8365-infracfg",
+		.data = (ulong)&mt8365_infracfg_tree
+	},
 	{ }
 };
 
@@ -816,8 +822,8 @@ U_BOOT_DRIVER(mt8365_clk_infracfg) = {
 	.name = "mt8365-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_infracfg_compat,
-	.probe = mt8365_infracfg_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt8365_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

