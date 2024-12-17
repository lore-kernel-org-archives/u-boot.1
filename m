Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81BDE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB25801CE;
	Tue, 17 Dec 2024 09:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YmLyjxR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA57B801CE; Tue, 17 Dec 2024 09:39:20 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DA7801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 61875076bc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=thGrp9UwTaHn2huPxjK1LCaK7mTVzF2dt3PKfBHF3Xc=; 
 b=YmLyjxR7eL6FM+ucvL+kAJ0OOsO4j0t2pCCbPmKBFthUTkeSLhjXAB8RyboGRwLd3iaMr2LvUHYOiYBdxWvIcu7tw6qvmsimSCHqZFyKD4dQfYAjReQ54omh9nwoc90x+pwMEeE/1wlmGHMshwVKlj0MJCTJF+uValFC5qDTcl4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:d908e47d-bd4c-4d06-84d0-4a0f641c003f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:f2b24313-8f5d-4ac6-9276-7b9691c7b8d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 61875076bc5211efbd192953cf12861f-20241217
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 710402670; Tue, 17 Dec 2024 16:39:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:06 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:06 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 00/10] Cumulative fixes and updates for MediaTek ethernet
 driver
Date: Tue, 17 Dec 2024 16:38:53 +0800
Message-ID: <cover.1734406967.git.weijie.gao@mediatek.com>
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

This patch series contains fixes and updates for mtk_eth driver.

Weijie Gao (10):
  clk: mediatek: mt7629: fix parent clock of some top clock muxes
  arm: dts: mt7629: fix sgmii clock selection for ethernet
  net: mediatek: use correct register field for SGMII speed selection
  net: mediatek: correct register name of ethsys syscfg1
  net: mediatek: fix sgmii selection for mt7622
  net: mediatek: fix gmac2 usability for mt7629
  net: mediatek: add support for 10GBASE-R
  net: mediatek: make sgmii/usxgmii optional
  net: mediatek: don't enable GDMA cpu bridge unconditionally for
    NETSYSv3
  net: mediatek: fix usability with wget command

 arch/arm/dts/mt7629.dtsi          |   4 +-
 drivers/clk/mediatek/clk-mt7629.c |   6 +-
 drivers/net/Kconfig               |  12 ++
 drivers/net/mtk_eth.c             | 175 +++++++++++++++++++++++++-----
 drivers/net/mtk_eth.h             |  26 +++--
 5 files changed, 184 insertions(+), 39 deletions(-)

-- 
2.34.1

