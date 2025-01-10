Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6DCE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E28801F5;
	Fri, 10 Jan 2025 09:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QXCxXxDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C14805EA; Fri, 10 Jan 2025 09:41:26 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B95800C2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a59f23bccf2e11efbd192953cf12861f-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=6TmUm9Whlhk0KZAC21TTuim79skXpajXckYdyLk+gzc=; 
 b=QXCxXxDUIacqFrhd7O5Slb8/HNxpNiulrlOLGMDIKxFAaeFoSvfpZ+D1N9aWLez8YkyTTFgV+cVAiVZyWwSX/x4KQjPlrwcc2uTSgiHm6cF6Hl32OFFZcRiTGAm1l+zCgDvkSJsEnGqdHD8dzAoxrRi+91VM/vX31wamdErSn/E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:17ef9851-dab5-41a1-8909-dbe1e9890adb, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:4293af0e-078a-483b-8929-714244d25c49,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a59f23bccf2e11efbd192953cf12861f-20250110
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1787275967; Fri, 10 Jan 2025 16:41:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 16:41:11 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 16:41:10 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 0/3] MediaTek ethernet driver refactor and updates
Date: Fri, 10 Jan 2025 16:41:05 +0800
Message-ID: <cover.1736498083.git.weijie.gao@mediatek.com>
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

This patch series will split the switch initialization code from mtk_eth
driver into their own files and then add new SoC and switch support.

Weijie Gao (3):
  net: mediatek: split ethernet switch code from mtk_eth.c
  net: mediatek: add support for MediaTek MT7987 SoC
  net: mediatek: add support for Airoha AN8855 ethernet switch

 drivers/net/Kconfig                 |   21 +-
 drivers/net/Makefile                |    2 +-
 drivers/net/mtk_eth/Kconfig         |   39 +
 drivers/net/mtk_eth/Makefile        |   10 +
 drivers/net/mtk_eth/an8855.c        | 1096 +++++++++++++++++++++++++++
 drivers/net/mtk_eth/mt7530.c        |  281 +++++++
 drivers/net/mtk_eth/mt7531.c        |  293 +++++++
 drivers/net/mtk_eth/mt753x.c        |  262 +++++++
 drivers/net/mtk_eth/mt753x.h        |  286 +++++++
 drivers/net/mtk_eth/mt7988.c        |  160 ++++
 drivers/net/{ => mtk_eth}/mtk_eth.c |  981 ++++--------------------
 drivers/net/{ => mtk_eth}/mtk_eth.h |  301 ++------
 12 files changed, 2631 insertions(+), 1101 deletions(-)
 create mode 100644 drivers/net/mtk_eth/Kconfig
 create mode 100644 drivers/net/mtk_eth/Makefile
 create mode 100644 drivers/net/mtk_eth/an8855.c
 create mode 100644 drivers/net/mtk_eth/mt7530.c
 create mode 100644 drivers/net/mtk_eth/mt7531.c
 create mode 100644 drivers/net/mtk_eth/mt753x.c
 create mode 100644 drivers/net/mtk_eth/mt753x.h
 create mode 100644 drivers/net/mtk_eth/mt7988.c
 rename drivers/net/{ => mtk_eth}/mtk_eth.c (62%)
 rename drivers/net/{ => mtk_eth}/mtk_eth.h (59%)

-- 
2.34.1

