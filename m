Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF5AC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756DE84C06;
	Wed, 15 Jul 2026 16:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="IO/yvV0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC1C84BBD; Wed, 15 Jul 2026 16:28:37 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A13884B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso32848025e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125715; x=1784730515; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=whGQrAwgKDwh1zuVylmsK59ugaCDPAPbInPpKU0tGDk=;
 b=IO/yvV0f6WEXLbUEQZvfDKmwVzrSmUsqmbXK1DD5gYv3BJiZI3iVle495fO1g8Rvec
 wMblqeTN8PfWW7aPRaIGTORh7PoOQmdYy/a9VjGiiNzphy411KFAQ5r9YdMOsb5avVF2
 VUotkQQUBEZwC0TKBD1e2SfWerQS3juwV2SKRdRfRM1RdB6VX1pcGj9DFz75vkSzZ202
 gpn+0Rm1sk+s3PLimoQ+2+1NzROYBb3ZFmttFhpBAY00XAL4UQVOow3K6pFoUyZSkEmp
 Kl8V6uUPIJXXFecPA8BaNvcIWoRrzpnGrTfPYdmC/bTv+dqqlP6T/jU+IjZr8TJKwwQr
 4gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125715; x=1784730515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whGQrAwgKDwh1zuVylmsK59ugaCDPAPbInPpKU0tGDk=;
 b=blWAaGlT+9tVu9WoPrHP7+Ooy8DMVv59U7PC41pVvrbmpo+x1PGcfBirn4HaO+9UQJ
 jEixARgd0Sg0mWyHsS9FrTBB7YwMg3cUsi6AqqsKKcm+NQplc9UKWRAfP/pj9QUfVCxm
 nTPXh5/9vCGTcMn5WcDmpZLKkiNtuOUZjRd7kRWDNCwjjvlJxhAjU0XW83D2eK1JSZpw
 ZTjzafvbRJIUatNOmNvNijr442NrMixGUvdbZXj6Quqd0dhybSyUFpEogypF7BAxf19B
 ytLe28Y9WCcRtR5WempQ4lP1R9/xJOSWfygBo2yVNBWmDpjIh9fzLwoCXP5ta3lRNCls
 eKPA==
X-Gm-Message-State: AOJu0Yz5VpoqacEVHbkNAASLsjVltiGnu33vQxyAMdZCWV8GRGEdbCus
 bLNszoVsw/etlNH5OX6WaGUj3DNhjmlTQA3zVqqx/V2yZqo1leNtrwB9Ls8VbCPBRz0=
X-Gm-Gg: AfdE7ck6FlMuIENBYSzAowFXONaV/xuRL/IfrI9qeZ6lQNdtzcizVGLnIQwjz2FygHV
 cgGZ85k44wwDzZytJEPNrXukh+FhWbbIgeJ/m8hRnSB+Dz8zN8LazAce9xZ5+u+9IUBbD4Ol5XH
 3BSz9zkOndp3ffIWpheOg4/ib/65kY9Fol5lmWut3M9hCAT/4rx9rS8BJ0q0HO+U8ae3nDhRSAD
 LphNMC2g1OvBHx0fwIGXJ7pwoxQN5lYf3a+fCI3hsOXSpahf21WBi0nknTjgfkbqBiZO381iYlL
 HSTXFgZNRG7zq/LSrv+9oRVvSWgc2CrVn+oDafDISk/ZMwXeIQt40z0iSvUB6+vzlFHVmDD0zO/
 5bvxhYkFhYnBCIctfRtXYuGemWwV/ILpWpCKB1OZspuSVVXNdwj0dv0iwg464xQWelXOtI4W27T
 cr4LozavTlRWxnTxy089LjXFpehJGY4++4DWtHqCttDzfHWXUpLov7lZfrYTilxJvzjjM2myjnr
 eiPhQFNxtio0vcH/q2Z8r9J3NZuHzcr0wpyM/d4hbqxQRuTXekqr6+MR/n9rRFWU3Bx0way
X-Received: by 2002:a05:600c:4754:b0:494:ca0e:880a with SMTP id
 5b1f17b1804b1-495389d2ba4mr73855285e9.12.1784125714669; 
 Wed, 15 Jul 2026 07:28:34 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:39 +0200
Subject: [PATCH v2 11/32] clk: mediatek: mt7986: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-11-23e907516010@baylibre.com>
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

Describe the ethsys gates directly in a struct mtk_clk_tree, reference the
tree from the driver data and use the generic mtk_clk_topckgen_ops instead
of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 56e18d403c8..cadb944d551 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -564,10 +564,12 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.type = MTK_CLK_TREE_INFRASYS,
 };
 
-static const struct mtk_clk_tree mt7986_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
+static int mt7986_clk_probe(struct udevice *dev)
+{
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
+}
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7986-fixed-plls" },
@@ -658,11 +660,12 @@ static const struct mtk_gate eth_cgs[] = {
 	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", CLK_TOP_NETSYS_MCU_SEL, 15),
 };
 
-static int mt7986_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7986_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 0);
-}
+static const struct mtk_clk_tree mt7986_eth_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = eth_cgs,
+	.num_gates = ARRAY_SIZE(eth_cgs),
+};
 
 static int mt7986_ethsys_bind(struct udevice *dev)
 {
@@ -678,7 +681,10 @@ static int mt7986_ethsys_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mt7986_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7986-ethsys" },
+	{
+		.compatible = "mediatek,mt7986-ethsys",
+		.data = (ulong)&mt7986_eth_clk_tree
+	},
 	{ }
 };
 
@@ -686,8 +692,8 @@ U_BOOT_DRIVER(mt7986_clk_ethsys) = {
 	.name = "mt7986-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_ethsys_compat,
-	.probe = mt7986_ethsys_probe,
+	.probe = mt7986_clk_probe,
 	.bind = mt7986_ethsys_bind,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 };

-- 
2.54.0

