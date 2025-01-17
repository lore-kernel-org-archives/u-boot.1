Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF12C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A066880763;
	Fri, 17 Jan 2025 10:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="FFLRApMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288D580771; Fri, 17 Jan 2025 10:18:20 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F6580792
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f8d18ca2d4b311efbd192953cf12861f-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=pPvHi7nBGSrNAK8hWX8FyxvcGAWL3zyylfH+qiRwh0c=; 
 b=FFLRApMm5hv+7dqIoK0N1DGXlzKveBM8vrCuFYG7T/xLrJyXGGtu6FGc0II1aCj0Ng6hs6SA5sF6ribCN76+rypIhBKAnDZrGUft19A2ATuqrMokuUir1HoGZ3c0Rc5jOXI3aFo7jX5WZ1gUhNDrp4x5kEXrXLdF1Kljud/f9Pw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:5f72e92b-98ff-4a5e-a6a2-a52694eafbae, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:ee083285-0f10-4f52-bb41-91703793d3e4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f8d18ca2d4b311efbd192953cf12861f-20250117
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 661105696; Fri, 17 Jan 2025 17:18:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:09 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:09 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH 08/15] pwm: mediatek: add pwm3 support for mt7981
Date: Fri, 17 Jan 2025 17:18:06 +0800
Message-ID: <d81226ed2f9950a89026440e70997c3577f9c7e1.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
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

This patch adds pwm channel 2 (pwm3) support for mt7981

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7981-emmc-rfb.dts |  8 ++++++++
 arch/arm/dts/mt7981-rfb.dts      |  8 ++++++++
 arch/arm/dts/mt7981-sd-rfb.dts   |  8 ++++++++
 arch/arm/dts/mt7981.dtsi         | 10 ++++++++--
 drivers/pwm/pwm-mtk.c            |  2 +-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt7981-emmc-rfb.dts b/arch/arm/dts/mt7981-emmc-rfb.dts
index 303f6707efa..96ecead569b 100644
--- a/arch/arm/dts/mt7981-emmc-rfb.dts
+++ b/arch/arm/dts/mt7981-emmc-rfb.dts
@@ -95,6 +95,14 @@
 		};
 	};
 
+	/* pin13 as pwm0, pin15 as pwm1, pin7 as pwm2 */
+	three_pwm_pins_1: three-pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm0_0", "pwm1_1", "pwm2";
+		};
+	};
+
 	mmc0_pins_default: mmc0default {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7981-rfb.dts b/arch/arm/dts/mt7981-rfb.dts
index 0081d4ed032..d684acf05c3 100644
--- a/arch/arm/dts/mt7981-rfb.dts
+++ b/arch/arm/dts/mt7981-rfb.dts
@@ -123,6 +123,14 @@
 			groups = "pwm0_1", "pwm1_0", "pwm2";
 		};
 	};
+
+	/* pin13 as pwm0, pin15 as pwm1, pin7 as pwm2 */
+	three_pwm_pins_1: three-pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm0_0", "pwm1_1", "pwm2";
+		};
+	};
 };
 
 &spi0 {
diff --git a/arch/arm/dts/mt7981-sd-rfb.dts b/arch/arm/dts/mt7981-sd-rfb.dts
index 565929b6050..41cccf3bbe1 100644
--- a/arch/arm/dts/mt7981-sd-rfb.dts
+++ b/arch/arm/dts/mt7981-sd-rfb.dts
@@ -95,6 +95,14 @@
 		};
 	};
 
+	/* pin13 as pwm0, pin15 as pwm1, pin7 as pwm2 */
+	three_pwm_pins_1: three-pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm0_0", "pwm1_1", "pwm2";
+		};
+	};
+
 	mmc0_pins_default: mmc0default {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index a9991a121f1..43e505826f5 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -137,8 +137,14 @@
 			 <&infracfg CLK_INFRA_PWM1_CK>,
 			 <&infracfg CLK_INFRA_PWM2_CK>,
 			 <&infracfg CLK_INFRA_PWM3_CK>;
-		assigned-clocks = <&topckgen CLK_TOP_PWM_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_CB_CKSQ_40M>;
+		assigned-clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				  <&infracfg CLK_INFRA_PWM1_SEL>,
+				  <&infracfg CLK_INFRA_PWM2_SEL>,
+				  <&infracfg CLK_INFRA_PWM3_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_CB_CKSQ_40M>,
+					 <&topckgen CLK_TOP_PWM_SEL>,
+					 <&topckgen CLK_TOP_PWM_SEL>,
+					 <&topckgen CLK_TOP_PWM_SEL>;
 		clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 		status = "disabled";
 	};
diff --git a/drivers/pwm/pwm-mtk.c b/drivers/pwm/pwm-mtk.c
index 9776a41ff48..5cf2eba2ba0 100644
--- a/drivers/pwm/pwm-mtk.c
+++ b/drivers/pwm/pwm-mtk.c
@@ -192,7 +192,7 @@ static const struct mtk_pwm_soc mt7629_data = {
 };
 
 static const struct mtk_pwm_soc mt7981_data = {
-	.num_pwms = 2,
+	.num_pwms = 3,
 	.pwm45_fixup = false,
 	.reg_ver = PWM_REG_V2,
 };
-- 
2.34.1

