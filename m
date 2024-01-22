Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA729C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 02:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2E3877B1;
	Mon, 22 Jan 2024 03:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="dFbSGsCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88178877FB; Mon, 22 Jan 2024 03:08:12 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326E187447
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0fe7b660b8cb11eea2298b7352fd921d-20240122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=a3qUThU+y1Pqn9D72NrXsva4ZGiSLEsYbxbc/AJGv9U=; 
 b=dFbSGsCcNCv6i47GRkdRql3+hMoI3Ts4YdgamDvACMVeHaA4s0E8Len7jz98lf8CRqclxRgfus0DvwqkEEw7Oqt++pMYsxa4MhIwgI5mmZ+WPjRQbv3CcCTX6lYRE/yjnez+LF8I+si91Qg5rtJEjsMb62p5t99BV/m54foX91o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36, REQID:8849685b-0274-49bb-90fe-f2246dffc0f3, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:6e16cf4, CLOUDID:c09b1883-8d4f-477b-89d2-1e3bdbef96d1,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0fe7b660b8cb11eea2298b7352fd921d-20240122
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 839997667; Mon, 22 Jan 2024 10:07:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jan 2024 10:07:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jan 2024 10:07:56 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Daniel Golle
 <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>, Weijie Gao
 <weijie.gao@mediatek.com>, Dong Huang <dong.huang@mediatek.com>
Subject: [PATCH 01/60] arm: dts: mt7988-sd-rfb: add SD pin driving settings
Date: Mon, 22 Jan 2024 10:07:54 +0800
Message-ID: <20240122020754.143309-1-weijie.gao@mediatek.com>
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

Set SD pin driving to 4mA

Signed-off-by: Dong Huang <dong.huang@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7988-sd-rfb.dts | 2 ++
 arch/arm/dts/mt7988.dtsi       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index a3df37d252..9aa198b84a 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -87,10 +87,12 @@
 			pins = "SPI2_CSB", "SPI2_MISO", "SPI2_MOSI",
 			       "SPI2_CLK", "SPI2_HOLD";
 			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
 		};
 
 		conf-clk {
 			pins = "SPI2_WP";
+			drive-strength = <MTK_DRIVE_4mA>;
 		};
 	};
 };
diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index ac476d5cdd..5c0c5bcfd6 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/mt7988-clk.h>
 #include <dt-bindings/reset/mt7988-reset.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
-- 
2.34.1

