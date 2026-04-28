Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E7FF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769158426C;
	Tue, 28 Apr 2026 05:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cfuHuGJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ACD842FD; Tue, 28 Apr 2026 05:32:08 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4795C841DF
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: cf27e3e242b211f19a16598d5ca7f8ec-20260428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=eo1flyxhoD7e/dZNSZuVUgP3ZxCS9hgI+6lDgKtym8c=; 
 b=cfuHuGJppuhx/msIOjlVjtyBGIoOUVjpx0QWziPglcyC7+g781Js/3wMo3LxyADO8NGqSPY7SPQyCfwx/zblE511A2a1GrvXfltGySGAkzWTM8866JnatZZKptDEo/KVDa8E4V68554veIjtsSanmQAeQcBrR8uqp+4QyiCn0ko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0d0be722-f66d-4cd5-af33-9469b921e2fc, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:0ba69d70-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf27e3e242b211f19a16598d5ca7f8ec-20260428
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 68907427; Tue, 28 Apr 2026 11:31:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 28 Apr 2026 11:31:55 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 28 Apr 2026 11:31:54 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Shiji Yang <yangshiji66@outlook.com>, Bernhard
 Messerklinger <bernhard.messerklinger@at.abb.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH 0/6] Fix and add some spi-nor flash parts
Date: Tue, 28 Apr 2026 11:28:46 +0800
Message-ID: <cover.1777345877.git.weijie.gao@mediatek.com>
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

This patch series correct some existing flash parts and add some new parts.

Weijie Gao (6):
  mtd: spi-nor-ids: Correct flash flags for ESMT/EON flashes
  mtd: spi-nor-ids: Add support for ESMT/EON
    EN25QX128A/EN25QH256/EN25QX256A
  mtd: spi-nor-ids: Add support for GigaDevice GD25Q256
  mtd: spi-nor-ids: Add 4K page support for Macronix MX25L25635E
  mtd: spi-nor-ids: Fix Winbond W25Q256JW and remove W25Q256FW
  mtd: spi-nor-ids: Add support for Winbond W25Q256JV/W25Q512JV

 drivers/mtd/spi/spi-nor-core.c |  1 +
 drivers/mtd/spi/spi-nor-ids.c  | 33 ++++++++++++++++++++++++---------
 include/linux/mtd/spi-nor.h    |  1 +
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.45.2

