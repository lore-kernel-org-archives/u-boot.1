Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F90AC4450B
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2F584B51;
	Wed, 15 Jul 2026 16:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="EIP1VJn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475F384B51; Wed, 15 Jul 2026 16:28:28 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4837A84B51
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so49326335e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125706; x=1784730506; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BU/YiDHaSNAFNJV1g/hLUqyRcmZwjdhXACFZDgTvhOo=;
 b=EIP1VJn0uwe3uI1uzEDTTeO0gQq/JSEN3udDKw4MTjz3KTmTAAWhBv4aWZE5PT950q
 ppzGHq22hSIEuqYniQTXQn2X0DBHJL+oaETbu883Q4zNiZOQe/8/DeOb+VcekaOsU62y
 Kmc7Jrk5U+APkuBoMiox8NKtYImhUZwP3ZntmiJL6udNbfR94ap4SBXdCLenqcljGTAY
 1jmAGqDGjw+KuyH0aQ+Sl9GI0pYjXcQOxfwL3e7AGhHCptuS2fumwtyjK+2RqlKdvL6B
 9Sw4vKCeFboSVPBcWZC7LAjPyOOUaAMY4j6kMJHe+u8/OMdOKwUHLLYF6rZ9hONPlQsz
 LrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125706; x=1784730506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BU/YiDHaSNAFNJV1g/hLUqyRcmZwjdhXACFZDgTvhOo=;
 b=kI2L14JPmwgOEjdiG2Jayg5eHEAP6PRRINsOg4llQxPb0eEXyWAZ3a5Onb68GXmLq4
 j8CuiS9aseQm65D+FFpLyFyH6hbxjS6kSU2SCqVcbWEs5rJYT/+cPicJfJWKHovbSoub
 0rm6BaP2d05+U2v6CATikklPeyKpeFZmT1twzqkmp9PvPEXJySh4n00JacRTLui1qqH4
 R0mN3RyEKrHbsRlxVOxmcEnszBb89fSktb0px/WZNOrPxzUhSQWxU3JJ50PlYWGYUNcx
 1Tdg8c+ZbdIm8QhkKqOHS4pWSagtMoU7pK+EYATq9AshFgsat00BNSV7L7EVVFY5YWt0
 Fnrg==
X-Gm-Message-State: AOJu0YwNRwT+JVTNOxzZskYQRxJQba+CCDKOG2rXe8RgBLaxBE7S+npm
 Ta72ZwzMcnIUGic2oQpdBknbdZ2LkA7c45gggIi7tB533BkZwNLZrvlaRNnzLaKH4dw=
X-Gm-Gg: AfdE7cnMQBg6WsUUb0krtuT7mkZk7D0sxtt1Lc7W1wjQDxLeJW0H7EVDamk44nl09Wz
 PwR6RFjHeaupftT5IuRIzcSy5nvxEY2KPlDjz0vnhsqgSda9+CDkzed1MSZGVTw+bIB71asCffE
 wa0kGCElfXR9vatiTAj4f6suCz2sbr9arlrrE34ny+eYrNktRd6CungOarugP88KCAT5QPY0izw
 amQopPgrjMfWW5sUgKmhrVPHwE9GMfAAMf3Irv2IWNpGbbL/ykNLF8l2XOVePiJWIIuPtnVCpw5
 HG5TiozPJj+jgfOrqoIqWF68lwzzISdO0Gxd2R5Epmd6VzqYjIf/sTb0T/7Ckp0x+9TFzI2f6xF
 2Yi5z4Oi0Wup+m77bwd4t4PrcECMo3aMGZDptwjCvamf69cX4xVyF3Pd/gJBE07FmKP8eT8gmdl
 8xokAxIPAyvr5RQmMis7hpn0ZX1WH5Jot8X+uFPPbU1OjXqVXp+iGHgOJJquUH59z4zwsjJBSIg
 rL8IQ7o22wsRMo/GUbz2fFqPHV15opCU6fUDAuwxBpopODld52oW+mpLKC+s1BypbLr7dWinYXL
 EKhbj9g=
X-Received: by 2002:a05:600c:6298:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4953c16458emr37449475e9.13.1784125705550; 
 Wed, 15 Jul 2026 07:28:25 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:25 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:32 +0200
Subject: [PATCH v2 04/32] clk: mediatek: mt7622: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-4-23e907516010@baylibre.com>
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
the generic probe function for all the MT7622 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data. The apmixedsys probe still performs
its SoC specific register tweaks. The infracfg and pericfg controllers share
the same ops, flags and (absent) bind() callback and are merged into a
single driver.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 60 ++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index ec81e5f84e5..67c4c7d7618 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -699,9 +699,10 @@ static int mt7622_mcucfg_probe(struct udevice *dev)
 static int mt7622_apmixedsys_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7622_apmixed_clk_tree);
+	ret = mtk_common_clk_init(dev, tree);
 	if (ret)
 		return ret;
 
@@ -715,21 +716,6 @@ static int mt7622_apmixedsys_probe(struct udevice *dev)
 	return 0;
 }
 
-static int mt7622_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7622_topckgen_clk_tree);
-}
-
-static int mt7622_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7622_infra_clk_tree);
-}
-
-static int mt7622_pericfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7622_peri_clk_tree);
-}
-
 static int mt7622_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -751,22 +737,30 @@ static int mt7622_reset_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mt7622_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt7622-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7622-apmixedsys",
+		.data = (ulong)&mt7622_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt7622_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7622-topckgen" },
-	{ }
-};
-
-static const struct udevice_id mt7622_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7622-infracfg", },
+	{
+		.compatible = "mediatek,mt7622-topckgen",
+		.data = (ulong)&mt7622_topckgen_clk_tree
+	},
 	{ }
 };
 
-static const struct udevice_id mt7622_pericfg_compat[] = {
-	{ .compatible = "mediatek,mt7622-pericfg", },
+static const struct udevice_id of_match_mt7622_infracfg[] = {
+	{
+		.compatible = "mediatek,mt7622-infracfg",
+		.data = (ulong)&mt7622_infra_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7622-pericfg",
+		.data = (ulong)&mt7622_peri_clk_tree
+	},
 	{ }
 };
 
@@ -823,7 +817,7 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7622_topckgen_probe,
+	.probe = mt7622_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -832,23 +826,13 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 U_BOOT_DRIVER(mt7622_clk_infracfg) = {
 	.name = "mt7622-clock-infracfg",
 	.id = UCLASS_CLK,
-	.of_match = mt7622_infracfg_compat,
-	.probe = mt7622_infracfg_probe,
+	.of_match = of_match_mt7622_infracfg,
+	.probe = mt7622_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt7622_clk_pericfg) = {
-	.name = "mt7622-clock-pericfg",
-	.id = UCLASS_CLK,
-	.of_match = mt7622_pericfg_compat,
-	.probe = mt7622_pericfg_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt7622_clk_eth) = {
 	.name = "mt7622-clk-eth",
 	.id = UCLASS_CLK,

-- 
2.54.0

