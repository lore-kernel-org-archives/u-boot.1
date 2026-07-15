Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F926C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8661884BB8;
	Wed, 15 Jul 2026 16:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gyvzNIwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6682884BB8; Wed, 15 Jul 2026 16:28:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C0D84C26
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493e497643fso10635745e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125725; x=1784730525; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0dYJZi/g1rLseGwT3khbaJOo8e9qdZena+pMYFXZHBo=;
 b=gyvzNIwcpyk+sDumN/4ki5R1ZFiTNUqyoNwfwpew8XSthkgAlnMg6x69bUGAAQKnyU
 gmVbzJ+uO9wQzAeYKruURLJbLo9pYm08mKaP4pDyQNSQcPsmlrejfIB6FnJVp+yWeQgV
 HqLsn0FX9aWRBJZA5micFklKGWPp3JjcFG3PkHcM46fM19PjHnRSP1O+wZvrAO2tK6H7
 E8pycj2OxQp/uy5MDVrm1u0NazGa21+TdMUsPAvsdFyhGx2T4IGtyt9dsBgd2Y+zG/Wv
 guU+YXpJOM9qkTu/QpOgM5/8OkCWimWNOPs8RerMYRqjkKNEPpry3kDRk0yZE5SwIjtY
 ehLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125725; x=1784730525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0dYJZi/g1rLseGwT3khbaJOo8e9qdZena+pMYFXZHBo=;
 b=Ynzk8a3mWnDmOVC7zHUJwOjobV7yxc3uieONLWsjKc6riePoFxMQRYWblpJ3j9TsZz
 Y5q6OTwbXlPLQ/RtWSk/v/z5dLWClsJUQAXckw/Cy7V5mROHNfjXLB41tXENritlTsRd
 NLi7AjTzXD8boJK+2s0VOixuJdARfKGjuzhAtvwVRc0G3SBkDnFu0aZRq80DL45A467g
 s7gG6CQpNSzAQYTeTlJWGqucn877nCOLW6G65eAyr/LWANLbHvuxvAPgl/Q56Augzkrv
 hGmP14RIWZh7J4+wAzNDzXErdeb+W+SN0Xwo1i4rRUNPZq+dkNH4kAxKjdxxse5JxhSy
 kEHQ==
X-Gm-Message-State: AOJu0YwnPYTRg+m1cU28W7bEQdoJvaXVutZHWe7WVVv2/BhvemPfWQ4b
 BpykMz3xkk/pEKK5qdmBHeory+Hh+cup5QoQvVX5uslkaLVgnmzc7mNzmXb1CZqcjgc=
X-Gm-Gg: AfdE7ck98Qb/+xxNN2cxEujpv0ajiuyBfcJJHHteNx4IqWJX5J3sqRfrJCFj2AbYfGe
 Mh06oX0aJbRQouKzotAAoHWzMrwYkBRU58E7RGYwNYmgrJBiz2k8dH7xLC8/ghZBFyt+ssvakvV
 gmwQ6KU+xlLHXDOsDzZ8kjD+KfX/1Ege6/ujnWX1/+5m4KfcJKIoPBOXDx14fTfX1xqS4p9qSh+
 YR7hOPL3mCO9PNVb+GeRklCBFRbYvXRAYMt7D2sTq7i/9x/uGZdjRzOlaEqWGP6otTYMUq+HPb1
 Edjm84x/wCRFlisgrpd99LYYmBVpKMdSYI/jV23TuiLklYc1gsrjHGUhUzvicdMp0CSH9tBsojx
 0J0qIZTdIb9qA3lQufmGYugHTeUIfpEuyIdFUcsXQC26Ij3qeW54N7BEfxOO8w7y3ueyTSdJolk
 wIrOfyU7x0B85dDZwVD8OTQvat/CWXgFKcuwSriiw5rC8Jmqleol0EjfBliYe/2c5OxT2fxDfMr
 nLyE6jlPL88zfrDqV516XvX2wjCYKijo1WwdUjoJ9vKvGBQa4cMrYoMcY/KZg1ceIVPPVD6
X-Received: by 2002:a05:600c:8486:b0:495:3db1:d052 with SMTP id
 5b1f17b1804b1-4953db1d08fmr36980845e9.9.1784125724841; 
 Wed, 15 Jul 2026 07:28:44 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:46 +0200
Subject: [PATCH v2 18/32] clk: mediatek: mt8183: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-18-23e907516010@baylibre.com>
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
the generic probe function for all the MT8183 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index a168a2eb9d5..5a7817ba77c 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -794,16 +794,6 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_FBIST2FPC, CLK_TOP_MUX_MSDC50_0, 24),
 };
 
-static int mt8183_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8183_apmixed_clk_tree);
-}
-
-static int mt8183_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8183_topckgen_clk_tree);
-}
-
 static const struct mtk_clk_tree mt8183_infracfg_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -812,12 +802,18 @@ static const struct mtk_clk_tree mt8183_infracfg_tree = {
 };
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8183-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8183-apmixedsys",
+		.data = (ulong)&mt8183_apmixed_clk_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8183_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8183-topckgen", },
+	{
+		.compatible = "mediatek,mt8183-topckgen",
+		.data = (ulong)&mt8183_topckgen_clk_tree
+	},
 	{ }
 };
 
@@ -834,7 +830,7 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8183_apmixedsys_probe,
+	.probe = mt8183_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -845,7 +841,7 @@ U_BOOT_DRIVER(mt8183_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8183_topckgen_probe,
+	.probe = mt8183_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

