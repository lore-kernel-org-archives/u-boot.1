Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA6C02184
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D612480690;
	Tue, 14 Jan 2025 11:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UkWl4aZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2968069A; Tue, 14 Jan 2025 11:43:00 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C58D80658
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4e2b5644d26411efbd192953cf12861f-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=55zz68k1pcTaEMFFzB9dAbTyKu8+lF+1oZ0spy9bjsc=; 
 b=UkWl4aZigF2d5iERjYaMoeJDoNqSvMehlmMXa2D0InQILX0qxLu9D9LT2LrZ+yGOIp3A152qQv+CpNBaWJ/6/1ar1UYwHVOIgxHH5pWiFg/XI9bqc/90HLxnUvcGCp0N7t83F5XiPVk8etI0ZCCvuCh0DXVXDj1PXmC+yjE6+bs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:9b473e3f-7ff2-48eb-a69b-9b3069603fb8, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:6929df0e-078a-483b-8929-714244d25c49,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4e2b5644d26411efbd192953cf12861f-20250114
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1149606864; Tue, 14 Jan 2025 18:42:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 Jan 2025 18:42:50 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 14 Jan 2025 18:42:50 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 0/2] MediaTek MT7629 OF_UPSTREAM migration (v2)
Date: Tue, 14 Jan 2025 18:42:47 +0800
Message-ID: <cover.1736851116.git.weijie.gao@mediatek.com>
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

This patch series migrates MediaTek MT7629 to OF_UPSTREAM

Changes in v2:
* Remove mt7629-rfb.dtb from arch/arm/dts/Makefile
* Add wdt-reboot node to make reset command work

Sam Shih (2):
  clk: mediatek: mt7629: fix gate offset of peri clock tree
  board: mediatek: mt7629: Migrate to OF_UPSTREAM

 arch/arm/dts/Makefile                  |   1 -
 arch/arm/dts/mt7629-rfb-u-boot.dtsi    | 119 +++++++-
 arch/arm/dts/mt7629-rfb.dts            | 123 ---------
 arch/arm/dts/mt7629.dtsi               | 360 -------------------------
 configs/mt7629_rfb_defconfig           |   3 +-
 drivers/clk/mediatek/clk-mt7629.c      |  14 +-
 include/dt-bindings/clock/mt7629-clk.h | 206 --------------
 7 files changed, 133 insertions(+), 693 deletions(-)
 delete mode 100644 arch/arm/dts/mt7629-rfb.dts
 delete mode 100644 arch/arm/dts/mt7629.dtsi
 delete mode 100644 include/dt-bindings/clock/mt7629-clk.h

-- 
2.34.1

