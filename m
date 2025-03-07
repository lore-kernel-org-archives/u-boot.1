Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E062C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 03:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFF480E94;
	Fri,  7 Mar 2025 04:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="uids8wF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1AA810F5; Fri,  7 Mar 2025 04:22:37 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7A4805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 04:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 60e6c53afb0311efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=dJnP8PIXEDKoGDdoG8Lje/k/9k4B1KXpzyjL/jgQAIE=; 
 b=uids8wF6Hbi0Bz+jEvZBufhEQmkSGE1K4Z2Ylecw17jwXCmmtLG4HvFaM1v7NfqOe5elVeiTyV34NP2vo8r8slX0jyypVJ3ayQc3SnGMS9+86YJC11zZ6Z3fb/D373Dr4Ab2lNjwtnGH7VzzGOXS2iLoA7g4PKCZIXT4xGvdFyE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:31337652-2bd0-4575-800b-c945ebb20ff9, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:0ef645f, CLOUDID:e3bf07c6-16da-468a-87f7-8ca8d6b3b9f7,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 60e6c53afb0311efaae1fd9735fae912-20250307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 780625460; Fri, 07 Mar 2025 11:22:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:22:18 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:22:18 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] arm: mediatek: remove wmcpu-reserved@50000000 node from
 mt7987 dts
Date: Fri, 7 Mar 2025 11:22:13 +0800
Message-ID: <20250307032213.75754-1-weijie.gao@mediatek.com>
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

The reserved-memory node 'wmcpu-reserved@50000000' only applies to
linux kernel and is useless in u-boot.
Remove it in *-u-boot.dtsi to make this memory region usable.

Fixes: 2d6962e0618 (arm: mediatek: add support for MediaTek MT7987 SoC)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7987a-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/mt7987a-u-boot.dtsi b/arch/arm/dts/mt7987a-u-boot.dtsi
index ec0a6389d8b..a1cb42a9675 100644
--- a/arch/arm/dts/mt7987a-u-boot.dtsi
+++ b/arch/arm/dts/mt7987a-u-boot.dtsi
@@ -24,6 +24,10 @@
 			mediatek,hwver = <&hwver>;
 		};
 	};
+
+	reserved-memory {
+		/delete-node/ wmcpu-reserved@50000000;
+	};
 };
 
 &i2c0 {
-- 
2.34.1

