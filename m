Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA0CC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F34684C79;
	Wed, 15 Jul 2026 16:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="SduaqGEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C7D84C23; Wed, 15 Jul 2026 16:28:53 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC4584C5A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so4837875e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125730; x=1784730530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2+4ZLJYE9CggtDohaM6BSNKGB2j6zttA2SRkzDzNuqg=;
 b=SduaqGEvX4uVVzOfUma22oxXYrELw3dWKpnULOayqIQs9cbOopzbZX6yHjq9kZqDn8
 TADIf05mS11C5y3Rg+8MgxhchhWixT1To2Pd7RrAkCKh811yHcAiuqldH2amFuVJYHqt
 i92+TOV9mfuKCmQBNPmRixytg9K+JV6KwCYrtMRmqW2F9V1c1FfWiiA9eLxDpl+F2yf9
 wykzdQNY/8ssIAuAs69C34H6Zl6/Zk4C+IYfOrOxJMYq2Yhs8O8Jbc4Er9obhYBhODLQ
 baUy+4gtHbxmAB0RzS9mJvCcu6nUjwVVTbxkKj821NyFC2i5cjCY1YUbmcSX93H5oUVi
 UrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125730; x=1784730530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2+4ZLJYE9CggtDohaM6BSNKGB2j6zttA2SRkzDzNuqg=;
 b=XprmDWG73GqivEILQvkCeEM4z2Y//selFYwDK2zNUo/PgIMou+x+ACUo+6rbfm0B5j
 vqVcrRtiDPOcTgY9zX17pyJAUIehlngnjh4TXcnUrW9T4ihjCJcqL2cgestmDvab7am1
 e6IG9LtL7gtdLNjk5iyM8PAsjC3WUlHUzYETMeWwdWjZBDbnslr6P5Z73FUQW62+POzT
 X6bfT4UgN4UN1BrUS2YS0Sx6xCA1UtQk+NYqDhd943LFiDqjxzHYliXnijojqblR8Hwa
 8DBwKmruCd8SVhEqsr1iPCq9HGxvkA98MW6tVk2+vFoOgBJUGKZTmngwwqLBMKF2a8c3
 6NQg==
X-Gm-Message-State: AOJu0YzMJAUQ9CfcEzwlNJkKbj66D+xqhMQG2kUjcN+MLmcdybM0zG5Q
 5m4ZA+MBNf8oFWODqtacgFefm2EmE+4xsr/ARahi5qSBxziBoWF+VIlpPoBbgrRtckE=
X-Gm-Gg: AfdE7ckbaakhtXAF8MSxVx3oycBimjF+h8sAKJPE/Rb1WctO2JGlagYC86WiONxObNU
 yXVkIPzMytxtslzY0SCEX3QEH2We0ptyLyowbwkosoq91H1PsXlXyODC0IA3Sd1qPXo2F/Rf+Ci
 ohTm1wFFQ0UoxbLIHx8elTG5jjibR9BPMGnEQdd4vRuKctr5qnQc7taMTqtK6sqxRuGMzqPyJya
 78AjiZf7Yxm8MO8UmyLJjd9lWI1233kPT5u5vKmRB4RjOvHzqZNde9mxKRfnOAkUL/Xv8iPodOY
 8DkDlNUQLkzeejtJs4HsPrucVa3yCgdTxxZgFQBXkUw4shJWMDfiRd1KX4VEUJh+u5Y2PQTdqAj
 aAEFPPydHNglZifzXj8M+7JWStH0Joc6TPSAbsMlM68cy+PJ0sELayDgNt1i8BQeW/VS90UFUgw
 hKXyVcMnrpclwv8+vOR8J1GYbA2EE9iO9UoyJ7m6AOCVioyAzJaFJCJWjaLsVTCa7ZotIO7nRzL
 oXw0ScjbN6rZ+37C7JGtAOOm0L755Kj2MUxsXpoQbSmivxlNuGbhjK+sbv806EKo9mRXpuE
X-Received: by 2002:a05:600c:6089:b0:493:b7cb:c5f with SMTP id
 5b1f17b1804b1-493fa8afbb6mr175305075e9.11.1784125730490; 
 Wed, 15 Jul 2026 07:28:50 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:50 +0200
Subject: [PATCH v2 22/32] clk: mediatek: mt8518: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-22-23e907516010@baylibre.com>
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
the generic probe function for all the MT8518 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 1c8a8c70956..f599a1869e6 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1530,16 +1530,6 @@ static const struct mtk_clk_tree mt8518_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_clks),
 };
 
-static int mt8518_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8518_apmixed_clk_tree);
-}
-
-static int mt8518_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8518_topckgen_clk_tree);
-}
-
 static int mt8518_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -1548,12 +1538,18 @@ static int mt8518_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8518-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8518-apmixedsys",
+		.data = (ulong)&mt8518_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8518_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8518-topckgen", },
+	{
+		.compatible = "mediatek,mt8518-topckgen",
+		.data = (ulong)&mt8518_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -1570,7 +1566,7 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8518_apmixedsys_probe,
+	.probe = mt8518_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1581,7 +1577,7 @@ U_BOOT_DRIVER(mt8518_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8518_topckgen_probe,
+	.probe = mt8518_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

