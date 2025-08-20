Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A582CA0EE6
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 02:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1365082B07;
	Wed, 20 Aug 2025 04:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="c14JBOKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34181801DD; Wed, 20 Aug 2025 04:20:56 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E3480107
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 04:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4434ff6a7d6c11f0b33aeb1e7f16c2b6-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=+LCwyGQ7rM59P/GnyyQWuFyk80uB9QnBlSdRqWQ5D9s=; 
 b=c14JBOKc9WrolyutRbz7ZHzLcRVZAP/Vonl0OhK5ukBJQ9mCAI9s4VCanmun/St8suUqYNZ2agTQytlOKExgveEirRMbX6bFb4r+JSSiVT6hBzAdJBV6t+t9Ne6YW81QqkYRb5lxB25pM9THAex2KioLIWl95I+0prSYpJzicPY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:47e12c40-df82-4fdc-9f6d-6b95d1afbad3, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:f1326cf, CLOUDID:310f666d-c2f4-47a6-876f-59a53e9ecc6e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
 nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
 ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4434ff6a7d6c11f0b33aeb1e7f16c2b6-20250820
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1813937469; Wed, 20 Aug 2025 10:20:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 10:20:37 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 10:20:37 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 0/4] Add support for MediaTek MT7987/MT7988 built-in 2.5Gb
 ethernet PHY
Date: Wed, 20 Aug 2025 10:20:36 +0800
Message-ID: <cover.1755655935.git.weijie.gao@mediatek.com>
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

This patch adds PHY driver for MediaTek MT7987/MT7988 built-in 2.5Gb
ethernet PHY.

Weijie Gao (4):
  net: mediatek: associate PHY device with dts node specified by
    phy-handle
  net: phy: Add MediaTek built-in 2.5Gb ethernet PHY driver
  dt-bindings: mediatek: add doc for MediaTek MT7987/MT7988 2.5Gb
    ethernrt PHY
  MAINTAINERS: update ethernet-related file list for MediaTek ARM
    platform

 MAINTAINERS                                   |   4 +-
 .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    |  60 ++
 drivers/net/mtk_eth/mtk_eth.c                 |   4 +
 drivers/net/phy/Kconfig                       |   2 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/mediatek/Kconfig              |  15 +
 drivers/net/phy/mediatek/Makefile             |   4 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 586 ++++++++++++++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 106 ++++
 drivers/net/phy/mediatek/mtk.h                | 103 +++
 10 files changed, 883 insertions(+), 2 deletions(-)
 create mode 100644 doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.34.1

