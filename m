Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA00C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 03:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37DE811C1;
	Fri,  7 Mar 2025 04:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="qLCrtOeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F449805D7; Fri,  7 Mar 2025 04:22:37 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19D6808A2
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 04:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 653cf3f2fb0311ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=PwiDAfF2soETlxkUbKVNczr320NekNR9VCsal6tCAK8=; 
 b=qLCrtOeSnoYqqqGAu8FTwIsXaTwTSeDwxR5Py+iPt0llRibpLBPQIM73DPBq7W6IYN2lp6NnIPUOlR9VndCL37qDP8wPdTfJv5+KJZugDx0CP+Z0ljGPyT2zsCvn6eWyT7BX16ThfiVc0GOMhFyglhK6bjkeqwvsQg9WsafsJxk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:22ea1987-64e1-47d5-a8ff-b6456b989493, IP:0,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-25
X-CID-META: VersionHash:0ef645f, CLOUDID:cd05cc49-a527-43d8-8af6-bc8b32d9f5e9,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 653cf3f2fb0311ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 230078388; Fri, 07 Mar 2025 11:22:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:22:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:22:25 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH 1/2] pwm: mediatek: add pwm support for MediaTek MT7987 SoC
Date: Fri, 7 Mar 2025 11:22:23 +0800
Message-ID: <8ca87e744999373b87ea7dab46b7724e1ae35b88.1741317191.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch adds pwm support for MediaTek MT7987 SoC.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7987-pinctrl.dtsi | 14 ++++++++++++++
 arch/arm/dts/mt7987.dtsi         | 16 +++++-----------
 arch/arm/dts/mt7987a.dtsi        |  2 ++
 drivers/pwm/pwm-mtk.c            | 16 ++++++++++++++++
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/mt7987-pinctrl.dtsi b/arch/arm/dts/mt7987-pinctrl.dtsi
index b5e643feffe..dfde21235b1 100644
--- a/arch/arm/dts/mt7987-pinctrl.dtsi
+++ b/arch/arm/dts/mt7987-pinctrl.dtsi
@@ -191,6 +191,20 @@
 		};
 	};
 
+	pwm_pins: pwm-pins {
+		mux {
+			/*
+			 * - pwm0   : PWM0@PIN13
+			 * - pwm1_0 : PWM1@PIN7  (share with JTAG)
+			 *   pwm1_1 : PWM1@PIN43 (share with i2c0)
+			 * - pwm2_0 : PWM2@PIN12 (share with PCM)
+			 *   pwm2_1 : PWM2@PIN44 (share with i2c0)
+			 */
+			function = "pwm";
+			groups = "pwm0";
+		};
+	};
+
 	uart1_pins: uart1-pins {
 		mux {
 			function = "uart";
diff --git a/arch/arm/dts/mt7987.dtsi b/arch/arm/dts/mt7987.dtsi
index fd1585f658d..4c1d597499c 100644
--- a/arch/arm/dts/mt7987.dtsi
+++ b/arch/arm/dts/mt7987.dtsi
@@ -389,21 +389,15 @@
 		};
 
 		pwm: pwm@10048000 {
-			compatible = "mediatek,mt7988-pwm";
+			compatible = "mediatek,mt7987-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
 				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>,
-				 <&clkxtal>;
-			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
-				      "pwm4","pwm5","pwm6","pwm7","pwm8";
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/dts/mt7987a.dtsi b/arch/arm/dts/mt7987a.dtsi
index 028f563fb39..bf53e89eca8 100644
--- a/arch/arm/dts/mt7987a.dtsi
+++ b/arch/arm/dts/mt7987a.dtsi
@@ -59,6 +59,8 @@
 };
 
 &pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
 	status = "okay";
 };
 
diff --git a/drivers/pwm/pwm-mtk.c b/drivers/pwm/pwm-mtk.c
index 5cf2eba2ba0..898e353b370 100644
--- a/drivers/pwm/pwm-mtk.c
+++ b/drivers/pwm/pwm-mtk.c
@@ -30,6 +30,7 @@
 enum mtk_pwm_reg_ver {
 	PWM_REG_V1,
 	PWM_REG_V2,
+	PWM_REG_V3,
 };
 
 static const unsigned int mtk_pwm_reg_offset_v1[] = {
@@ -40,6 +41,10 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
 };
 
+static const unsigned int mtk_pwm_reg_offset_v3[] = {
+	0x0100, 0x0200, 0x0300, 0x0400, 0x0500, 0x600, 0x700, 0x0800
+};
+
 struct mtk_pwm_soc {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
@@ -60,6 +65,10 @@ static void mtk_pwm_w32(struct udevice *dev, uint channel, uint reg, uint val)
 	u32 offset;
 
 	switch (priv->soc->reg_ver) {
+	case PWM_REG_V3:
+		offset = mtk_pwm_reg_offset_v3[channel];
+		break;
+
 	case PWM_REG_V2:
 		offset = mtk_pwm_reg_offset_v2[channel];
 		break;
@@ -203,6 +212,12 @@ static const struct mtk_pwm_soc mt7986_data = {
 	.reg_ver = PWM_REG_V1,
 };
 
+static const struct mtk_pwm_soc mt7987_data = {
+	.num_pwms = 3,
+	.pwm45_fixup = false,
+	.reg_ver = PWM_REG_V3,
+};
+
 static const struct mtk_pwm_soc mt7988_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
@@ -215,6 +230,7 @@ static const struct udevice_id mtk_pwm_ids[] = {
 	{ .compatible = "mediatek,mt7629-pwm", .data = (ulong)&mt7629_data },
 	{ .compatible = "mediatek,mt7981-pwm", .data = (ulong)&mt7981_data },
 	{ .compatible = "mediatek,mt7986-pwm", .data = (ulong)&mt7986_data },
+	{ .compatible = "mediatek,mt7987-pwm", .data = (ulong)&mt7987_data },
 	{ .compatible = "mediatek,mt7988-pwm", .data = (ulong)&mt7988_data },
 	{ }
 };
-- 
2.34.1

