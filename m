Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C241CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9367982A9E;
	Mon,  8 Sep 2025 10:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="IC4dgR2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47DA82A9E; Mon,  8 Sep 2025 10:34:12 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A0A800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 9237c2668c8e11f0b33aeb1e7f16c2b6-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=HBDu1tpSnN524nBQC8xmIPL3HX5BX7S0EOxWrDQ3P1c=; 
 b=IC4dgR2G6AmaSNg/B0VFVBb3mbc4MNDVk+fSQpLTHLWZdP9qbPmWAN4uXCoe02REAVrH73en8mIDHqup1UFa+gc+yj22jx65+YnPjJEpWE+P+bcFFS4oOTrYurIwXe3v8155Lyclm/B5dX3qCPY6fKD0NYpATSa4QSwDwr6OmEE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:bec6de6e-8928-4504-a35d-257aba244e96, IP:0,
 UR
 L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-55
X-CID-META: VersionHash:f1326cf, CLOUDID:52f314a9-24df-464e-9c88-e53ab7cf7153,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:2,IP:n
 il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
 S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9237c2668c8e11f0b33aeb1e7f16c2b6-20250908
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1396463896; Mon, 08 Sep 2025 16:34:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 16:33:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 16:33:58 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 0/5] Add support for MediaTek MT7987/MT7988 built-in 2.5Gb
 ethernet PHY (v4)
Date: Mon, 8 Sep 2025 16:33:57 +0800
Message-ID: <cover.1757315849.git.weijie.gao@mediatek.com>
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

Changes in v4:
Remove unneeded const from argv[0] used for cmd_process()

Changes in v3:
1. Removed all optional code configured by dt properties
2. Make use of request_firmware_into_buf_via_script() for firmware loading

Changes in v2:
1. rename "pd-disable" property to "half-en"
2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-en"
3. rename "auto-downshift-disable" property to "auto-downshift-dis"
4. add default settings for "auto-downshift-dis"
5. add default settings for "half-en"
6. add "retrain-dis" property

Weijie Gao (5):
  misc: fs_loader: allow returning actual firmware data size in
    request_firmware_into_buf_via_script()
  misc: fs_loader: allow using long script name in
    request_firmware_into_buf_via_script()
  net: mediatek: associate PHY device with dts node specified by
    phy-handle
  net: phy: Add MediaTek built-in 2.5Gb ethernet PHY driver
  MAINTAINERS: update ethernet-related file list for MediaTek ARM
    platform

 MAINTAINERS                            |   4 +-
 drivers/misc/fs_loader.c               |  15 +-
 drivers/net/mtk_eth/mtk_eth.c          |   4 +
 drivers/net/phy/Kconfig                |   2 +
 drivers/net/phy/Makefile               |   1 +
 drivers/net/phy/mediatek/Kconfig       |  16 +
 drivers/net/phy/mediatek/Makefile      |   4 +
 drivers/net/phy/mediatek/mtk-2p5ge.c   | 627 +++++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c | 106 +++++
 drivers/net/phy/mediatek/mtk.h         | 103 ++++
 include/fs_loader.h                    |   4 +-
 11 files changed, 876 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.34.1

