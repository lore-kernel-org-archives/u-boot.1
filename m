Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E3C4450E
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D7084BDA;
	Wed, 15 Jul 2026 16:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="nfTNWTCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F160584BC9; Wed, 15 Jul 2026 16:28:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F154784C1D
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so22003175e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125719; x=1784730519; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UhkfGGGbwvUlzkL42J35xDQsU9X6wbwZGhnpsPJ364o=;
 b=nfTNWTCaHCatou0pdAovMmc+3QlTYuLE29zn5QvtNCm+Qd2w8BjnvzF1MJQUpuHCOT
 pMRWPeHwUae6TSp7jVOLEGbn/Rlxg/T35KUDCiaH1JHoIp147mgz9nElyjumYp+QTr0d
 mMELj0fMjwvqONPloG9PXMZ7ZgEx5D0TVBRvgl5L5UoS2zbj1eDBT19vk6NbGiMJdE2m
 7k27g4ibB8khUSZroIFea2YyTJZRqglExTN0gcZhm1pWseE/O45odkpDwz853duV9izX
 WbUSS3QJbEEF7jlGgoFYSFphrX6jHUxysE0AunuJCY3/g1iAFxUy4F5yUxzc/W/TfyN9
 Re2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125719; x=1784730519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UhkfGGGbwvUlzkL42J35xDQsU9X6wbwZGhnpsPJ364o=;
 b=UbR35vo1/AgfyAVTQFiXcuJeFbUBVGNSNOFlx8oe7sywon94q9/mqJJbAuS5/lSNoT
 I0uctJFyQWBlgaAsNDGYJSqaVwAg5eCnJzbI1CQkPxrLCOeBvdK8tcl5mth72FeePMnM
 vFrNV/VUFj/wIRFyFxpmBVaUPds6cQNXfcr/aMKetEjndBQJnBG2HQl/z7ygw0c3auNk
 hJ4Tnw7Cs7vdsoQ2YxNO5FUixz1/cFC+R/jnZ+GbSN82um65Kbkim/pZE2rOxq0+6X90
 RwLRyx78iwJSRC4m6FciIxNkDqYWk/b1NHAHnoJjOPvkb3G/p+0qwlalJu7ImmrTsJ7g
 aTjA==
X-Gm-Message-State: AOJu0YyNXtkAOw8dIYsABgLvoIoKK291zdJcvW9dnkUCDJNq9ubU2x0L
 ZvuCXGbtvGUYQ0HaGcOcMfG0JeJlG/0N27NcKOfmqNV8H7mxS+7RkTyxyIOxzbTvtKw=
X-Gm-Gg: AfdE7cnhys/BW5UuatEYODl+WWkvEFS5UybBZ9sko18rDKAXyiPuJPSnnofc1PGiA4l
 ZoCIDCsYrqQpEqf2iOmt6PzrpaXbtro4aU1y4dJOjKnC6Vo6Z4BB7LDK1P1iWc0TS51eOQlm0eW
 ndmJ0+7Rtr/NE4Am8PNVTnlcrh5F00CwOJCQ8uOED9cG6620AgII7ECDLkYSTx6NyOMsSog2c4l
 WV8ttN18Pg3ADKKtwOD1diio5WzDGplR63w+9aLzLCrGLnnPX8LAifkV1ti/dZ3Ui0yVmdnoEvm
 +ffvrrr6g+y0eGOC4qwzKpwGi5fVW7iNKwVdm/pfLQE/4QvtTAzdEccyhhRJX+s5HxSiepG0TAq
 qeTkAlNYcDV7C02a8eS1lU14ISy3gJbiFAinvRjNK5i8WRRNoZ+6+qhQps9Tu0u7TbpPSKa2RJt
 Vc+4rbbVydc0w59+WmWSnBqSxa9+tFF7HOk7IlMUPhAw4FGFlZ7Tp4/CvPUUQoGjYgE7lOWMVsW
 MVoxYTy/qRGa2VzRNPavkrTwTbJX997Km6mvZB8rtzOZ5fBWgeinKVQVSsTes3b/HcLq5aH
X-Received: by 2002:a05:600c:19cb:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-4953c15d121mr34638535e9.11.1784125719411; 
 Wed, 15 Jul 2026 07:28:39 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:42 +0200
Subject: [PATCH v2 14/32] clk: mediatek: mt7987: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-14-23e907516010@baylibre.com>
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
the generic probe function for the MT7987 clock drivers, instead of a
dedicated probe per controller.

The fixed-pll, topckgen and infracfg controllers keep their own U_BOOT_DRIVER
since they rely on dedicated ops and on the parent bind() callback, but they
now get their tree from the compatible data. The topckgen probe still
performs its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 1a2fd3453a9..3f5709fbe22 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -71,22 +71,23 @@ static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 };
 
 static const struct udevice_id mt7987_fixed_pll_compat[] = {
-	{ .compatible = "mediatek,mt7987-fixed-plls" },
-	{ .compatible = "mediatek,mt7987-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7987-fixed-plls",
+		.data = (ulong)&mt7987_fixed_pll_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7987-apmixedsys",
+		.data = (ulong)&mt7987_fixed_pll_clk_tree
+	},
 	{}
 };
 
-static int mt7987_fixed_pll_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7987_fixed_pll_clk_tree);
-}
-
 U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.name = "mt7987-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7987_fixed_pll_probe,
+	.probe = mt7987_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -470,20 +471,24 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 };
 
 static const struct udevice_id mt7987_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7987-topckgen" },
+	{
+		.compatible = "mediatek,mt7987-topckgen",
+		.data = (ulong)&mt7987_topckgen_clk_tree
+	},
 	{}
 };
 
 static int mt7987_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
 	writel(MT7987_CLK_PDN_EN_WRITE, priv->base + MT7987_CLK_PDN);
-	return mtk_common_clk_init(dev, &mt7987_topckgen_clk_tree);
+	return mtk_common_clk_init(dev, tree);
 }
 
 U_BOOT_DRIVER(mt7987_clk_topckgen) = {
@@ -798,22 +803,23 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 };
 
 static const struct udevice_id mt7987_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7987-infracfg_ao" },
-	{ .compatible = "mediatek,mt7987-infracfg" },
+	{
+		.compatible = "mediatek,mt7987-infracfg_ao",
+		.data = (ulong)&mt7987_infracfg_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7987-infracfg",
+		.data = (ulong)&mt7987_infracfg_clk_tree
+	},
 	{}
 };
 
-static int mt7987_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7987_infracfg_clk_tree);
-}
-
 U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.name = "mt7987-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7987_infracfg_probe,
+	.probe = mt7987_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

