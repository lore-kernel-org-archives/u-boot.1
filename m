Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0178C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E8484C3C;
	Wed, 15 Jul 2026 16:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="kl0S5SQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D04184BB8; Wed, 15 Jul 2026 16:28:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9879784C05
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so38687705e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125722; x=1784730522; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qChxgm0s79b+6Ypauhe1+bimyxLf1WuiBBzsQjLu7Ok=;
 b=kl0S5SQvXfZ8h7E/Bf+V1bMTurjpPp1qY34XzZtMbGJXMYXP1b6PW3iPWvGUe/+KOJ
 yZiz22svYJl1BkezUpkOdEsSkZeF57r6DBNYU6jbmS/zmcKm40Wiz1aGGTYPui+wIg+y
 bLQ72/rqFkgWVWSnJrjp+xgtjAPVubzUMYPnm4Tx80LAWpkoRJGdKg5QiDzTVXflYizt
 PXImd1Lv5FAs3ERjdTBelvVn+ehKfuqxIPHHbOi8SD9/jXtf51C1lWnAuequW9KL7oTa
 kXHOi/A/9QYf1/0p8fy6bFBwviDKL4AEqSPd/1K96GfIs54kPWy73cxVRY930C/wsYcs
 QSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125722; x=1784730522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qChxgm0s79b+6Ypauhe1+bimyxLf1WuiBBzsQjLu7Ok=;
 b=LzWiRRo3c3uvmfgYBA1xfVwDaf6Mgd6ar9aMFZNv8R+onpjvwgQm1QH1fXXnM6eFgn
 0ffE04zFudX5c8okptuqIsxRaqkwrTPy3Tea0fNRuR2EqsO0+bdKE0QZ3mWnJRONyItK
 Cg8j4R5zucMg7sLNsLRC70xQEfQ4vWfSQF0fY+my2trImmUspLCpnCgrlD4dXylFqkaz
 ltiQQ+XILVx9VNFx+niiKsKs2vqU9WBNQ3C3GWW+8SHOVSHRMJAj0JFYONxtPF5h7Ltm
 F2DfLDDxgbL7PX6BNYMpdhfGj1dw9s9CNFPCRjgRczXu/jyFjB6Q0jZeMFIwF+fNq1A4
 IYuw==
X-Gm-Message-State: AOJu0YzkrwJYKVBdnZTXKJAq8pCZDlr9pX4p3ji4V5dFMZOUhZkyuZBo
 SnffhF/XjVmZs5zwKKszkUYjoa4wSqfNnsbXPWLUEl6xE8wyge9EYz4C2rosFL52FIM=
X-Gm-Gg: AfdE7cmKbS8IEEqF2Ir71vLPdNWZlGjWX0NXeBoPTkamdf79/IJqcRl7txmqx4I2qEL
 GRjoPdbT5ltN9snGik1ZcicoQJJwLooPWVz4KgeM5cgLb+8RNhSqf09bGK/nCRGKAgzAS7Bq2SF
 n6jvQ4f6CSdWoNVDpQNu/qUzYMLWPFYTn+yw2oNmSYciwOGSUqHCwSVGSSE+3Beb36dKimdeMUH
 kxY2EL82Qk2LWg/7NUKSHeFtepeM+Cu94Wie7focU8LaC2DIc2sEwAMrxBBzwZI67HTRcxC5lFP
 F+aRcg+h8n+eArSl/kZW30geBsZb49shpdyR/ywQckELkFu17Tf5hrjCttus2onMc0zG0lrPcIg
 w+bIbZgbFSJ1LnUKtIAcjeYRieCeRSCX6dxvnBvt32RGRfD1VlUa/w7TcxJb0IothFYe5PaLvwl
 /AYxmaI3Ec/xwlvDMI6OMmwNhI8N23uys7TWp9I1NQDuSVwgvHdJEu1djavZhfchXBXrCXy59KM
 1kbJe+h2VGFm2MXYXtXynoqGZnnYH6gpNQNC+I1iuKEYuy5tN+BnaKp0ijrPkr71fVdKGCZ
X-Received: by 2002:a05:600c:a20a:b0:493:f528:58ac with SMTP id
 5b1f17b1804b1-4953c27b34emr25871465e9.21.1784125722071; 
 Wed, 15 Jul 2026 07:28:42 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:44 +0200
Subject: [PATCH v2 16/32] clk: mediatek: mt7988: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-16-23e907516010@baylibre.com>
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
the generic probe function for the MT7988 clock drivers, instead of a
dedicated probe per controller.

The fixed-pll, topckgen and infracfg controllers keep their own U_BOOT_DRIVER
since they rely on dedicated ops and on the parent bind() callback, but they
now get their tree from the compatible data. The topckgen probe still
performs its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 2a848032c8a..31aa47e8bb8 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -846,31 +846,36 @@ static int mt7988_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
-	{ .compatible = "mediatek,mt7988-fixed-plls" },
-	{ .compatible = "mediatek,mt7988-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7988-fixed-plls",
+		.data = (ulong)&mt7988_fixed_pll_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7988-apmixedsys",
+		.data = (ulong)&mt7988_fixed_pll_clk_tree
+	},
 	{}
 };
 
 static const struct udevice_id mt7988_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7988-topckgen" },
+	{
+		.compatible = "mediatek,mt7988-topckgen",
+		.data = (ulong)&mt7988_topckgen_clk_tree
+	},
 	{}
 };
 
-static int mt7988_fixed_pll_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7988_fixed_pll_clk_tree);
-}
-
 static int mt7988_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
 	writel(MT7988_CLK_PDN_EN_WRITE, priv->base + MT7988_CLK_PDN);
-	return mtk_common_clk_init(dev, &mt7988_topckgen_clk_tree);
+	return mtk_common_clk_init(dev, tree);
 }
 
 U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
@@ -878,7 +883,7 @@ U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7988_fixed_pll_probe,
+	.probe = mt7988_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -896,21 +901,19 @@ U_BOOT_DRIVER(mt7988_clk_topckgen) = {
 };
 
 static const struct udevice_id mt7988_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7988-infracfg" },
+	{
+		.compatible = "mediatek,mt7988-infracfg",
+		.data = (ulong)&mt7988_infracfg_clk_tree
+	},
 	{}
 };
 
-static int mt7988_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7988_infracfg_clk_tree);
-}
-
 U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.name = "mt7988-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7988_infracfg_probe,
+	.probe = mt7988_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

