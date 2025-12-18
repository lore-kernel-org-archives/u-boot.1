Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6490ED711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58A283966;
	Fri, 19 Dec 2025 00:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d7wHFGLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AA383642; Fri, 19 Dec 2025 00:24:42 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1814B836A3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-455bef556a8so756489b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100279; x=1766705079;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kxyjmoNA+hDeDxXDjMCctO5cwn5c6BxKt7t4ob6PfGE=;
 b=d7wHFGLoWQU4jbFaVJdh7HZxuTekDwzx3WVZLIjNDGfj0HJoVVRF0D/sUjSiA+4jeS
 +G9gqvz9r4WdhkSNEjWM2AM8Xs0m11qVF/PQxNTrSxHnTiZZsgV4d9dt9r5fQJo0bisx
 XYStK1ggmU3xqG45KjtIVI074qieavBEyULij4qoHP/sTiRYA0mRZkrNEhrg+1S8y5gO
 5YdnVCCw/uLNp5BCyWb9Jxb0yhnvHcdcBFyCHmdkEZRzXj7ZNNsKBnNrWSS48crDGmwZ
 U2cUPzRnBE2Gwb7v5P1zfD9mqdMQwpah9cF0IHsCg6DE4asJeOQ2ngsEMNu37EWcLZfg
 ZTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100279; x=1766705079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kxyjmoNA+hDeDxXDjMCctO5cwn5c6BxKt7t4ob6PfGE=;
 b=HV94gz6kYPjWuanNdmB3etfyZ2DZUDNiKi87Nj1tP+o6B6+ISkdqnbPPGP7ANgijy2
 c9u9lSGxGc7eUR+l5Hs1F7w/NOtRO9WFnsr1WKCsJspx2UKQCYOHbjQakip0IYflzifS
 dEFeUP3uhVr1bwJdkaKjSvyaLeCU9D03YrrdtN5ms1ppqh4fTNedj4GZd7zVlofqEjIV
 2Y0I4jC73MD7Of6an0ZeLb9uTHh1xOhHsg+DpP2dEMfeoSkru0FSbx9keLJnf4Ta0h2v
 rqlxHNJgsZ4tc4VpgO7MrFB83hBypPZAtxWebsUTfOUBx802yK0+uOR8YBzNrWvnOaPY
 OVzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo7CLa62C9HfiWkxUQQ6rSM8sTMQLFalYJWqUafSVLz2QUt/mVlMXxlYZDOpC+Lg+8FR4gepY=@lists.denx.de
X-Gm-Message-State: AOJu0YzDqnqcRzr3cgZK0VpyNFoDG0sW0aoIH8BpYijyRwg2Y/ev8TyW
 24SSQf2OUjSsl61pjNASdgzhIjZc2tmy/EeeHV+1/vkn27e50E8eXAjZBEvBq7fh/sw=
X-Gm-Gg: AY/fxX6SRyZ6cl8t6ikFWD4BnMKKloZKVLb8E3YHIO2QR0mlq14VHjb8qUZPmVAWTba
 mSvfcoHQTw44ta4Zv5E+KM5OqKyjMjzHFHi00S5MoAPXhJPGMAIB6XNDPIyqk9rhMXuk2CnfX6X
 Cn4Ti19+HD+FVuv1daip2tLpkjeMuk2T5HwzXfqJ30Jp59lFqptU9RU1ULRRGFR1roOYkOKg/sh
 QjlHUmrsa0JYl7Z/eM+LB4arHKLE6TA2yRJiB+DLwIgIQ3676AX080Mv4WCaJ5G/mmRucFMYcjY
 WxJRG1xJQkakEyQfXy8dx1pNoxU868/qkGKtUtnL4KMCGLnDfhQ9SLq1SfqSEefPJorn5ECciqa
 CcVTncizBpTHK8sC8bIZkzi4tQL9dXWqnzGKfhzrWL0+eYU08p8xLNiN/m+H9IFN4k7Fp6ulJWS
 DOQZeXR5rGjy0TItIFgQ7kapPa6A==
X-Google-Smtp-Source: AGHT+IE/lHnKengOTL0J3dqz0XmgwBwjyxn2oBPM+mmxtAM/kJOKLcE55AABqwpfE6xEsFcgV/Calg==
X-Received: by 2002:a05:6808:c286:b0:450:1433:f13a with SMTP id
 5614622812f47-457b1fc27afmr693318b6e.11.1766100278810; 
 Thu, 18 Dec 2025 15:24:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:23 -0600
Subject: [PATCH 3/9] clk: mediatek: add separate gates_offs for cg gates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-3-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16479;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=b5n2v+60YKlzy9YHoj2mRbQWnuczzsKlXqCherlRlu8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0Ckv0aZNa/cNrbaKCsWF5xqWmx+9gi3UM85
 lNIetbOXCWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNAhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWtIIAKFVymzleScEwvk+LUeh6I5Ta0u2S9WX2ej16AG
 RaJNLf8L4sZXvFBZmFuMgK2Y8QPVIE0QckB2+p97uDzT3bV/GufeFVpb7UeT6mnZyZd5dzq0lhk
 ymnqz9yks/t8k79JK5jCVXLKESgrgwYzzMHoXhXV6AwyK1FuQ4jk4+RPX5y+PHL+Uxk5LqqF5C6
 eZHC+WfpI0cfrfOPu10PCF+7d/Zu+vWAhhbGI5cUZ6Ar7QAABpUAydsJQ+93o32GyZW/I7Bh7yg
 cSLwya91jXiI7EC/b1VgYC//pn30PJ1/FU9FQA6GKjiOKRHPxAwXYYAt7BcCTpmOwuYgkxlcq8o
 4mTU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Add a gates_offs field to struct mtk_cg_priv and use that instead of
struct mtk_clk_tree.gates_offs.

Prior to this change, struct mtk_clk_tree.gates_offs could be the offset
of struct mtk_clk_tree.gates or struct mtk_cg_priv.gates depending on
the context. This was confusing and error-prone. For example, in mt8365
there is one set of gates that needs an offset and one that does not
that share the same struct mtk_clk_tree. This is fixed in this patch by
giving the correct offset for each gate separately.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c |  8 ++++----
 drivers/clk/mediatek/clk-mt7623.c |  8 +++-----
 drivers/clk/mediatek/clk-mt7629.c | 11 +++++------
 drivers/clk/mediatek/clk-mt7981.c |  6 +++---
 drivers/clk/mediatek/clk-mt7986.c |  2 +-
 drivers/clk/mediatek/clk-mt7987.c |  2 +-
 drivers/clk/mediatek/clk-mt7988.c |  8 ++++----
 drivers/clk/mediatek/clk-mt8183.c |  2 +-
 drivers/clk/mediatek/clk-mt8365.c |  5 +++--
 drivers/clk/mediatek/clk-mt8512.c |  4 ++--
 drivers/clk/mediatek/clk-mt8516.c |  2 +-
 drivers/clk/mediatek/clk-mt8518.c |  2 +-
 drivers/clk/mediatek/clk-mtk.c    | 24 +++++++++++++-----------
 drivers/clk/mediatek/clk-mtk.h    |  4 +++-
 14 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 16c6f024e72..9621d5efe11 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -693,7 +693,7 @@ static int mt7622_pericfg_probe(struct udevice *dev)
 static int mt7622_pciesys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, pcie_cgs,
-					ARRAY_SIZE(pcie_cgs));
+					ARRAY_SIZE(pcie_cgs), 0);
 }
 
 static int mt7622_pciesys_bind(struct udevice *dev)
@@ -712,7 +712,7 @@ static int mt7622_pciesys_bind(struct udevice *dev)
 static int mt7622_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs));
+					ARRAY_SIZE(eth_cgs), 0);
 }
 
 static int mt7622_ethsys_bind(struct udevice *dev)
@@ -731,13 +731,13 @@ static int mt7622_ethsys_bind(struct udevice *dev)
 static int mt7622_sgmiisys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, sgmii_cgs,
-					ARRAY_SIZE(sgmii_cgs));
+					ARRAY_SIZE(sgmii_cgs), 0);
 }
 
 static int mt7622_ssusbsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, ssusb_cgs,
-					ARRAY_SIZE(ssusb_cgs));
+					ARRAY_SIZE(ssusb_cgs), 0);
 }
 
 static const struct udevice_id mt7622_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 6ce1d729736..3509ea67e7d 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1055,15 +1055,13 @@ static int mt7623_topckgen_probe(struct udevice *dev)
 }
 
 static const struct mtk_clk_tree mt7623_clk_gate_tree = {
-	/* Each CLK ID for gates clock starts at index 1 */
-	.gates_offs = 1,
 	.xtal_rate = 26 * MHZ,
 };
 
 static int mt7623_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs));
+					ARRAY_SIZE(infra_cgs), 1);
 }
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
@@ -1086,13 +1084,13 @@ static int mt7623_pericfg_probe(struct udevice *dev)
 static int mt7623_hifsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, hif_cgs,
-					ARRAY_SIZE(hif_cgs));
+					ARRAY_SIZE(hif_cgs), 1);
 }
 
 static int mt7623_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs));
+					ARRAY_SIZE(eth_cgs), 1);
 }
 
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index e4132f6195f..5bbac309e9d 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -581,7 +581,6 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
 	.xtal_rate = 40 * MHZ,
 	.xtal2_rate = 20 * MHZ,
-	.gates_offs = CLK_PERI_PWM1_PD,
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.plls = apmixed_plls,
@@ -635,19 +634,19 @@ static int mt7629_topckgen_probe(struct udevice *dev)
 static int mt7629_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs));
+					ARRAY_SIZE(infra_cgs), 0);
 }
 
 static int mt7629_pericfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs,
-					ARRAY_SIZE(peri_cgs));
+					ARRAY_SIZE(peri_cgs), CLK_PERI_PWM1_PD);
 }
 
 static int mt7629_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs));
+					ARRAY_SIZE(eth_cgs), 0);
 }
 
 static int mt7629_ethsys_bind(struct udevice *dev)
@@ -666,13 +665,13 @@ static int mt7629_ethsys_bind(struct udevice *dev)
 static int mt7629_sgmiisys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, sgmii_cgs,
-					ARRAY_SIZE(sgmii_cgs));
+					ARRAY_SIZE(sgmii_cgs), 0);
 }
 
 static int mt7629_ssusbsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, ssusb_cgs,
-					ARRAY_SIZE(ssusb_cgs));
+					ARRAY_SIZE(ssusb_cgs), 0);
 }
 
 static const struct udevice_id mt7629_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index c8adbe538d9..73dc5cfe19d 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -631,7 +631,7 @@ static const struct mtk_gate sgmii0_cgs[] = {
 static int mt7981_sgmii0sys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs));
+					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs), 0);
 }
 
 static const struct udevice_id mt7981_sgmii0sys_compat[] = {
@@ -658,7 +658,7 @@ static const struct mtk_gate sgmii1_cgs[] = {
 static int mt7981_sgmii1sys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs));
+					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs), 0);
 }
 
 static const struct udevice_id mt7981_sgmii1sys_compat[] = {
@@ -699,7 +699,7 @@ static const struct mtk_gate eth_cgs[] = {
 static int mt7981_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					eth_cgs, ARRAY_SIZE(eth_cgs));
+					eth_cgs, ARRAY_SIZE(eth_cgs), 0);
 }
 
 static int mt7981_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index d2ac5ad1bb1..04040f5ff63 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -637,7 +637,7 @@ static const struct mtk_gate eth_cgs[] = {
 static int mt7986_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7986_topckgen_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs));
+					ARRAY_SIZE(eth_cgs), 0);
 }
 
 static int mt7986_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index e0ca82de01e..3a30d16a158 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -819,7 +819,7 @@ static const struct mtk_gate eth_cgs[] = {
 static int mt7987_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7987_topckgen_clk_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs));
+					ARRAY_SIZE(eth_cgs), 0);
 }
 
 static int mt7987_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 43820557ba7..71a16b9f19f 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -893,7 +893,7 @@ static int mt7988_ethdma_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
 					ethdma_mtk_gate,
-					ARRAY_SIZE(ethdma_mtk_gate));
+					ARRAY_SIZE(ethdma_mtk_gate), 0);
 }
 
 static int mt7988_ethdma_bind(struct udevice *dev)
@@ -952,7 +952,7 @@ static int mt7988_sgmiisys_0_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
 					sgmiisys_0_mtk_gate,
-					ARRAY_SIZE(sgmiisys_0_mtk_gate));
+					ARRAY_SIZE(sgmiisys_0_mtk_gate), 0);
 }
 
 static const struct udevice_id mt7988_sgmiisys_0_compat[] = {
@@ -997,7 +997,7 @@ static int mt7988_sgmiisys_1_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
 					sgmiisys_1_mtk_gate,
-					ARRAY_SIZE(sgmiisys_1_mtk_gate));
+					ARRAY_SIZE(sgmiisys_1_mtk_gate), 0);
 }
 
 static const struct udevice_id mt7988_sgmiisys_1_compat[] = {
@@ -1044,7 +1044,7 @@ static int mt7988_ethwarp_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
 					ethwarp_mtk_gate,
-					ARRAY_SIZE(ethwarp_mtk_gate));
+					ARRAY_SIZE(ethwarp_mtk_gate), 0);
 }
 
 static int mt7988_ethwarp_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5b41cf4b88c..5a353e82f3f 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -778,7 +778,7 @@ static int mt8183_topckgen_probe(struct udevice *dev)
 static int mt8183_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8183_clk_tree, infra_clks,
-					ARRAY_SIZE(infra_clks));
+					ARRAY_SIZE(infra_clks), 0);
 }
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index b6332b14aea..02d30ab12d8 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -708,13 +708,14 @@ static int mt8365_topckgen_probe(struct udevice *dev)
 static int mt8365_topckgen_cg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, top_clk_gates,
-					ARRAY_SIZE(top_clk_gates));
+					ARRAY_SIZE(top_clk_gates),
+					CLK_TOP_AUD_I2S0_M);
 }
 
 static int mt8365_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, ifr_clks,
-					ARRAY_SIZE(ifr_clks));
+					ARRAY_SIZE(ifr_clks), 0);
 }
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index d4f6604c160..bad8c62601d 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -809,13 +809,13 @@ static int mt8512_topckgen_probe(struct udevice *dev)
 static int mt8512_topckgen_cg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks));
+					ARRAY_SIZE(top_clks), 0);
 }
 
 static int mt8512_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, infra_clks,
-					ARRAY_SIZE(infra_clks));
+					ARRAY_SIZE(infra_clks), 0);
 }
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index d5f922886a3..a84a5f360f5 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -758,7 +758,7 @@ static int mt8516_topckgen_probe(struct udevice *dev)
 static int mt8516_topckgen_cg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8516_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks));
+					ARRAY_SIZE(top_clks), 0);
 }
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 92730f3f06c..43a06217d33 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1514,7 +1514,7 @@ static int mt8518_topckgen_probe(struct udevice *dev)
 static int mt8518_topckgen_cg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8518_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks));
+					ARRAY_SIZE(top_clks), 0);
 }
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index a3dd18363f6..6ba2fabfd08 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1018,8 +1018,8 @@ static const int mtk_clk_gate_of_xlate(struct clk *clk,
 	if (ret)
 		return ret;
 
-	if (clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + priv->num_gates)
+	if (clk->id >= priv->gates_offs &&
+	    clk->id < priv->gates_offs + priv->num_gates)
 		return 0;
 
 	return -ENOENT;
@@ -1030,10 +1030,10 @@ static int mtk_clk_gate_enable(struct clk *clk)
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (clk->id < priv->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
@@ -1042,10 +1042,10 @@ static int mtk_clk_gate_disable(struct clk *clk)
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (clk->id < priv->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
@@ -1055,10 +1055,10 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	struct udevice *parent = priv->parent;
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (clk->id < priv->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->gates_offs];
 	/*
 	 * With requesting a TOPCKGEN parent, make sure the dev parent
 	 * is actually topckgen. This might not be the case for an
@@ -1094,8 +1094,8 @@ static void mtk_clk_gate_dump(struct udevice *dev)
 		const struct mtk_gate *gate = &priv->gates[i];
 
 		printf("[GATE%u] DT: %u", i, gate->id);
-		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
-		mtk_clk_print_rate(dev, i + tree->gates_offs);
+		mtk_clk_print_mapped_id(gate->id, i + priv->gates_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + priv->gates_offs);
 		mtk_clk_print_single_parent(gate->parent, gate->flags);
 		printf("\n");
 	}
@@ -1196,7 +1196,8 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates, int num_gates)
+			     const struct mtk_gate *gates, int num_gates,
+			     int gates_offs)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(dev);
 	struct udevice *parent;
@@ -1218,6 +1219,7 @@ int mtk_common_clk_gate_init(struct udevice *dev,
 	priv->tree = tree;
 	priv->gates = gates;
 	priv->num_gates = num_gates;
+	priv->gates_offs = gates_offs;
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 915b872ec36..25fd156ac30 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -290,6 +290,7 @@ struct mtk_cg_priv {
 	const struct mtk_clk_tree *tree;
 	const struct mtk_gate *gates;
 	int num_gates;
+	int gates_offs;
 };
 
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
@@ -304,6 +305,7 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates, int num_gates);
+			     const struct mtk_gate *gates, int num_gates,
+			     int gates_offs);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.43.0

