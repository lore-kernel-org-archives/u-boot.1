Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3460C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB43831C5;
	Wed, 27 Aug 2025 10:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ltW4gHkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B37583145; Wed, 27 Aug 2025 10:56:06 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B343831C2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a6f625fe832311f0b33aeb1e7f16c2b6-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Dxn8Q005BxlIpKi4vnZ5BZ1vUz8xgZKPrVBhf2IO4ik=; 
 b=ltW4gHkhR0rKJcwzOyOKFKVa12cS845IPzfdFYg8BgDs4+e4Kk7YLKvG7wqiqIUTMOR4ajL4/7rZoIbd/qmdXcVbeMu/0yU6NePyHDYsDp5+KOuyHP46mplOGxs2zn21ZTlq4zTaILEbZdoCx4DiH+u5lQ8wxXk4Umea63b37QA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:1e8d1e11-d3c0-4861-8255-c2df006dff9c, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-30
X-CID-META: VersionHash:f1326cf, CLOUDID:fb71eb44-18c5-4075-a135-4c0afe29f9d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a6f625fe832311f0b33aeb1e7f16c2b6-20250827
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 863771584; Wed, 27 Aug 2025 16:55:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 16:55:58 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 16:55:57 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>
Subject: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Date: Wed, 27 Aug 2025 16:55:54 +0800
Message-ID: <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1756283872.git.weijie.gao@mediatek.com>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
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

The MediaTek MT7987 and MT7988 platforms supports one built-in 2.5Gb
ethernet PHY through eth1 interface.

This patch add documentation for configuring these PHYs.

Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v2:
1. rename "pd-disable" property to "half-en"
2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-en"
3. rename "auto-downshift-disable" property to "auto-downshift-dis"
4. add note for "retrain-dis" property
---
 .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt

diff --git a/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt b/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
new file mode 100644
index 00000000000..900b9f664a3
--- /dev/null
+++ b/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
@@ -0,0 +1,68 @@
+MediaTek MT7987/MT7988 built-in 2.5Gb Ethernet PHY
+
+This document describes the device tree bindings for MediaTek MT7987/MT7988
+built-in 2.5Gb Ethernet PHY.
+
+Required properties:
+- reg: The phy address
+
+Optional properties:
+- half-en: Boolean. The uplink XGMAC of this PHY doesn't support half duplex.
+  As parallel detection is enabled in this PHY, we disabled the PHY's
+  half-duplex capability by default. If you really want to connect to those
+  devices supporting only 10M/half or 100M/half and don't care about duplex
+  mismatch, use this option to force link up. Note that this PHY will still
+  link up at full duplex.
+
+- gbe-min-ipg-11-bytes-en: Boolean. If present, enables 11-byte minimum
+  inter-packet gap for 1000Mbps link speed. When not present (by default),
+  the PHY uses optimized IPG settings for better performance. This option is
+  basically for those legacy 1G link partners which only accept higher IPG
+  transfer.
+
+- retrain-dis: Boolean. If present, this will block fast retrain and normal
+  retrain at the same time. Not recommend to use this option unless you know
+  what you're doing.
+
+- auto-downshift-dis: Boolean. If present, disables the hardware
+  auto-downshift feature. When not present (by default), the PHY will
+  automatically downshift link speed when link quality is poor.
+
+- pinctrl-names: Accepts "i2p5gbe-led" pinctrl for PHY status indicator
+
+Notes:
+- Firmware loading is required for proper operation. The driver expects
+  firmware files to be available through weak symbol functions provided by
+  boards.
+
+Examples:
+/* without option */
+&eth1 {
+	status = "okay";
+	phy-mode = "xgmii";
+	phy-handle = <&phy15>;
+
+	phy15: ethernet-phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <15>;
+		phy-mode = "xgmii";
+	};
+};
+
+/* with options/pinctrl */
+&eth1 {
+	status = "okay";
+	pinctrl-names = "i2p5gbe-led";
+	pinctrl-0 = <&i2p5gbe_led0_pins>;
+	phy-mode = "xgmii";
+	phy-handle = <&phy15>;
+
+	phy15: ethernet-phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <15>;
+		half-en;
+		gbe-min-ipg-11-bytes-en;
+		auto-downshift-dis;
+		phy-mode = "xgmii";
+	};
+};
-- 
2.34.1

