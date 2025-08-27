Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2597DC8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E4F831D3;
	Wed, 27 Aug 2025 10:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="jK7rzKBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C7C83189; Wed, 27 Aug 2025 10:56:01 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA6883145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 9df86692832311f0bd5779446731db89-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=MVLOw0NuobwPd4t5cXQvDw4/ncJJlY3KjV1e4I9JI4c=; 
 b=jK7rzKBRjpAFU0VR1VQutbA0hLgosmlEzoCJXt++zrq7QFzmpkMK9bAWeywSld+Oz7ZYJ4Re7ogfNwPewc2vzuWCjWMnFQEg+7sakZ1zrJ3TSY9wO1f247qJU2+xsqR4oKWuUYi5Yy4pIv4XiJuED3fqFm+q8VS9YNpvkIW+Dz0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:1934736c-7785-47aa-b1ce-1cd3efa6f173, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:f1326cf, CLOUDID:e8eba96d-c2f4-47a6-876f-59a53e9ecc6e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
 nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
 ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9df86692832311f0bd5779446731db89-20250827
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 73399469; Wed, 27 Aug 2025 16:55:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 16:55:43 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 16:55:42 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 0/4] Add support for MediaTek MT7987/MT7988 built-in 2.5Gb
 ethernet PHY (v2)
Date: Wed, 27 Aug 2025 16:55:39 +0800
Message-ID: <cover.1756283872.git.weijie.gao@mediatek.com>
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

Changes in v2:
1. rename "pd-disable" property to "half-en"
2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-en"
3. rename "auto-downshift-disable" property to "auto-downshift-dis"
4. add default settings for "auto-downshift-dis"
5. add default settings for "half-en"
6. add "retrain-dis" property

Weijie Gao (4):
  net: mediatek: associate PHY device with dts node specified by
    phy-handle
  net: phy: Add MediaTek built-in 2.5Gb ethernet PHY driver
  dt-bindings: mediatek: add doc for MediaTek MT7987/MT7988 2.5Gb
    ethernrt PHY
  MAINTAINERS: update ethernet-related file list for MediaTek ARM
    platform

 MAINTAINERS                                   |   4 +-
 .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    |  68 ++
 drivers/net/mtk_eth/mtk_eth.c                 |   4 +
 drivers/net/phy/Kconfig                       |   2 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/mediatek/Kconfig              |  15 +
 drivers/net/phy/mediatek/Makefile             |   4 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 638 ++++++++++++++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 106 +++
 drivers/net/phy/mediatek/mtk.h                | 103 +++
 10 files changed, 943 insertions(+), 2 deletions(-)
 create mode 100644 doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.34.1

