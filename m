Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E9CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304F38407F;
	Wed,  7 Jan 2026 17:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S05v6yOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5701884051; Wed,  7 Jan 2026 17:22:34 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941488405C
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45090ef26c6so855665b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802950; x=1768407750;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdYGrz0KUWpoQRlHt10LehAQw7iXAhDcKKI0J+RQ6mA=;
 b=S05v6yOgdXz5nfZ87+jaU1ujhAXK5ohdD9s7YT1FilR7lk8mcA+tUEBwkIu04J/2Hb
 wjDTN2ZAHv0yZ5SUVjbzR598Eyxaah91tlTCIKedfpvPV3iaGimCS9b4lKBhxgR6asp6
 XXy75zZjLbS5djXMQF/bFximBJ4MKXYbgFZIysUvZgA5hjvSbuZ6cSLWjO4m9v98zjuV
 c49kT//zr6qcif5KPCFXU/29707BJYt8JCfi/eQTn/yjikecBgnYtcSIYihfaTJTGmF4
 AdXb/nRJx0De6+qMxsc51/D66a7ZQIZZQKHLZ38OHgKSWrwJavEUjq46Jbc6nAOq17R5
 Hsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802950; x=1768407750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xdYGrz0KUWpoQRlHt10LehAQw7iXAhDcKKI0J+RQ6mA=;
 b=IrixREnzQH7X6RWlEOV2hIyPoDStitnfZySoHwy75KyzyL6GI284jWV+/pYZjMcVQW
 7Mb1lPWcRH72Suc45w4ynKjujNbbQXeNoqlwJMaz8Ugt80dGtMi3fBm9YFUMmey+eiq0
 ooN9+vksfkkRaSnCaiFwnUnCsIklpCbm2bGT9+g2olKKBNEIJJMVFrcxzb2RNTx2Coon
 zWffQnq4kia3RcWBeVe0t9sKlsLpzTvLZifdnPAWBQkGei+dqjZNE7Ndg50KMCc78+mO
 0ZIyqHirHyVRIr58GWRy55N3oEUCC5MH2c2UBQ6bCHRHAhFiZHfWDwGRqmNFr1CBNKSw
 MVsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVVkbUhefbEa/0hpgpvBvjLGV90IEwGcf9Zi1zN0XkseISgCZ77Ig8Ik+v6x6zXnFsFFZ4wSM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbcv1XiUJ2a7asKlkGPd6AjFVLkwM+L8NaD4HbSw3TLmvEGgDx
 U2MV9RyWmLsIfgNrLqltBH8SiClxBzUT0CapjZDclxD7QS8MhvmGwntoLg8qBmEGX6E=
X-Gm-Gg: AY/fxX6f5wdJ8f91tsObeNuhbIDECMRahFqj5ns5lHs4d+Hi/OGKTricvahoMEiA53P
 jd9Vf2v23AQ0gWTOWGd20URAr+fWWNm4WEWo8Gch49aR2o5TD9vKs0mjHkDvq4tMp3oNuc6JH6/
 A20hEPvrv212q1ZHBUbLI6YXJ20kdPy3AzHRiOhPMvaUIDXzmvOnECYOVk1eDEbQzSUV2zOpRul
 Oj74cijCJPkCAsALNNMdi4uKncQT23vzjl2ZLGfNU/te7Y44CDyZBDynQoy3f4MGxIUvKvEEr2I
 xRZfiWJ86Bf/AulrHUzob9cVkQ8WGHmXUcerjebTvxr/FdlxVwzeaBDsNFRtK/Zi4DA8Tqcgbwm
 YUs1xXvHEf4ydvpIN6KwTJdCZZ8G4DoJSZPKGhbZOLwiGyM2mMCyrw1Qp1KH7vaK3iG6oIJAJ79
 wwvBcLlTqjBy0d/Uw=
X-Google-Smtp-Source: AGHT+IG04H9IgwhwEqXnSNlY83ONRk+gVBYpt7H1cfzmMpXRkeGwA+EyU9w0jY/x/x3oXI8tOVfSsQ==
X-Received: by 2002:a05:6808:228a:b0:450:bfba:9f43 with SMTP id
 5614622812f47-45a6bf37725mr1319996b6e.55.1767802950236; 
 Wed, 07 Jan 2026 08:22:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:09 -0600
Subject: [PATCH v2 3/9] clk: mediatek: add separate gates_offs for cg gates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-3-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20020;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=eoP3HYf0ZT88lM6mFsKZxNdAAzj/nqjvEBbd4GEe/ao=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogViuZOwfJ7sI+jSvLPgILaZvm/l3b7IJCzO
 Pv0Fag61KeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IFRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AE1AH/3aNNJ7wyVqLysPNBFlnarknX+ovnz20XTBmqjT
 +kiwbJcF3yVUi0YQz9LOTKWdYjbXhqJa13dLi63asE4Cx6KR8DyVoeTxJcXV7BNe5lzmsW6GvPf
 yYGlVkNC+N0dlzIaYCs0CbmUWAzkrS9CxkU7MvX+Oi89c4Cgz3+W67JRM/Wy4/G+bBOe4lvU0LE
 yikP5eXrTPePwFWAqTJs+R+fDi1XNG4RsxuFk/caMHMDgwOkWuhRkCxshIpn0FOdobj1v4vM5Be
 jfWxYnFO2A2ZfOLpJYTOUzLzObz4tufSfmvn+U89f0opah9u8sRChq0jbsCVqXI/ftVPFjH7Ph5
 nGpc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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
 drivers/clk/mediatek/clk-mt8188.c | 22 +++++++---------------
 drivers/clk/mediatek/clk-mt8365.c |  5 +++--
 drivers/clk/mediatek/clk-mt8512.c |  4 ++--
 drivers/clk/mediatek/clk-mt8516.c |  2 +-
 drivers/clk/mediatek/clk-mt8518.c |  2 +-
 drivers/clk/mediatek/clk-mtk.c    | 24 +++++++++++++-----------
 drivers/clk/mediatek/clk-mtk.h    |  4 +++-
 15 files changed, 52 insertions(+), 58 deletions(-)

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
index c8090688df0..3f96d25db04 100644
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
index 735e824c874..a8f39a3beb6 100644
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
index 99ff57c5dc5..818f45ef6bb 100644
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
index da1d2e89d61..6da7c62c585 100644
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
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index a4cbb3213e3..d967a915fac 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1535,7 +1535,6 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	.gates_offs = 0, /* CLK_INFRA_AO_PMIC_TMR */
 };
 
 static const struct mtk_gate_regs peri_ao_cg_regs = {
@@ -1570,7 +1569,6 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	.gates_offs = 0, /* CLK_PERI_AO_ETHERNET */
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {
@@ -1629,7 +1627,6 @@ static const struct mtk_gate topckgen_cg_clks[] = {
 static const struct mtk_clk_tree mt8188_topckgen_cg_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	.gates_offs = 185, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
 };
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
@@ -1665,22 +1662,16 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	/* CLK_IMP_IIC_WRAP_C_AP_CLOCK_I2C0 */
-	.gates_offs = 0,
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	/* CLK_IMP_IIC_WRAP_C_AP_CLOCK_I2C1 */
-	.gates_offs = 0,
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	/* imp_iic_wrap_en: CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C5 */
-	.gates_offs = 0,
 };
 
 static int mt8188_apmixedsys_probe(struct udevice *dev)
@@ -1697,42 +1688,43 @@ static int mt8188_topckgen_cg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tree,
 					topckgen_cg_clks,
-					ARRAY_SIZE(topckgen_cg_clks));
+					ARRAY_SIZE(topckgen_cg_clks),
+					CLK_TOP_CFGREG_CLOCK_EN_VPP0);
 }
 
 static int mt8188_infracfg_ao_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree,
 					infracfg_ao_clks,
-					ARRAY_SIZE(infracfg_ao_clks));
+					ARRAY_SIZE(infracfg_ao_clks), 0);
 }
 
 static int mt8188_pericfg_ao_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tree,
 					pericfg_ao_clks,
-					ARRAY_SIZE(pericfg_ao_clks));
+					ARRAY_SIZE(pericfg_ao_clks), 0);
 }
 
 static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_c_clk_tree,
 					imp_iic_wrap_c_clks,
-					ARRAY_SIZE(imp_iic_wrap_c_clks));
+					ARRAY_SIZE(imp_iic_wrap_c_clks), 0);
 }
 
 static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_w_clk_tree,
 					imp_iic_wrap_w_clks,
-					ARRAY_SIZE(imp_iic_wrap_w_clks));
+					ARRAY_SIZE(imp_iic_wrap_w_clks), 0);
 }
 
 static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_en_clk_tree,
 					imp_iic_wrap_en_clks,
-					ARRAY_SIZE(imp_iic_wrap_en_clks));
+					ARRAY_SIZE(imp_iic_wrap_en_clks), 0);
 }
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
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
index bd8899193c9..068240b123e 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -285,6 +285,7 @@ struct mtk_cg_priv {
 	const struct mtk_clk_tree *tree;
 	const struct mtk_gate *gates;
 	int num_gates;
+	int gates_offs;
 };
 
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
@@ -299,6 +300,7 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates, int num_gates);
+			     const struct mtk_gate *gates, int num_gates,
+			     int gates_offs);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.43.0

