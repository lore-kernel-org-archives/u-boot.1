Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C18CA0EE6
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 02:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2E782F8F;
	Wed, 20 Aug 2025 04:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="iNFIrGQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D683B80107; Wed, 20 Aug 2025 04:21:10 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845B582E67
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 04:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4bcec2107d6c11f08729452bf625a8b4-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=dnvfXK+63/iUekpJmtU9/VYqT3U/yh/bQNqybIbPIlo=; 
 b=iNFIrGQNmjV8SdquhkH/OV5QuuRoQu1dfUzxtP7PAgErYVGpDOc8uvplGPUO/9oPpHhC+TTzZ8sIaljGxrZ53kDy+lr7RZDmn9SVuOtLJat+Go+LNkKq14HEmIiNnCL9jhn2SkfaScpRjaB5dJjyx04ugrd5fwwGDEhf7rfN+IA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:8b44a68c-7efc-45b4-8f02-d451ee0ffe0a, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:68aca744-18c5-4075-a135-4c0afe29f9d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4bcec2107d6c11f08729452bf625a8b4-20250820
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1574056819; Wed, 20 Aug 2025 10:20:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 10:20:50 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 10:20:50 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>
Subject: [PATCH 3/4] dt-bindings: mediatek: add doc for MediaTek MT7987/MT7988
 2.5Gb ethernrt PHY
Date: Wed, 20 Aug 2025 10:20:50 +0800
Message-ID: <60e0de8d66ed3d540605d3e1d69db3d831b32044.1755655935.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1755655935.git.weijie.gao@mediatek.com>
References: <cover.1755655935.git.weijie.gao@mediatek.com>
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
 .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt

diff --git a/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt b/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
new file mode 100644
index 00000000000..ebac28d2d9a
--- /dev/null
+++ b/doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
@@ -0,0 +1,60 @@
+MediaTek MT7987/MT7988 built-in 2.5Gb Ethernet PHY
+
+This document describes the device tree bindings for MediaTek MT7987/MT7988
+built-in 2.5Gb Ethernet PHY.
+
+Required properties:
+- reg: The phy address
+
+Optional properties:
+- pd-disable: Boolean. PD (Parallel detction) is enabled in this PHY, even
+  though this may cause duplex mismatch for devices supporting only 10M/half
+  or 100M/half. If you are concerned with duplex mismatch, use this option to
+  prevent this built-in PHY to link up with those devices.
+
+- gbe-min-ipg-11-bytes: Boolean. If present, enables 11-byte minimum
+  inter-packet gap for 1000Mbps link speed. When not present (by default),
+  the PHY uses optimized IPG settings for better performance. This option is
+  basically for those legacy 1G link partners which only accept higher IPG
+  transfer.
+
+- auto-downshift-disable: Boolean. If present, disables the hardware
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
+		pd-disable;
+		gbe-min-ipg-11-bytes;
+		auto-downshift-disable;
+		phy-mode = "xgmii";
+	};
+};
-- 
2.34.1

