Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3842C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 08:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023D684B04;
	Wed, 15 Jul 2026 10:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="kGfmKXRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C320484B06; Wed, 15 Jul 2026 10:30:28 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33FA80087
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6b9ecb9e802711f1b1788b6acf885367-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=JDUX9ZErfQaLWembXEXQSdq/hKZNnSyfksZUNmn3Xss=; 
 b=kGfmKXRnYzgeWbqFwUTBghDA0Itu0XYFCW9VbAEozN7He7uf/d5zfpulPorEcsKMFLxR2HSgxgD2DQNVRfQSlAxNwbHSMIGAqAsegyuRfvfQHLWh7uhKRb9u0XSTFcA3Zh5Fke+KreJl/deCFypRKeSWFuvtG0eRQpLzEYdJEx8=;
X-CID-CACHE: Type:Local,Time:202607151629+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:dd978376-1c06-45d0-bb46-d2288f2899de, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:d497b38, CLOUDID:4b46b837-7759-43a9-ae06-f4df9d53bea1,
 B
 ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
 DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b9ecb9e802711f1b1788b6acf885367-20260715
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1032433445; Wed, 15 Jul 2026 16:30:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Jul 2026 16:30:20 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Jul 2026 16:30:19 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v7 0/7] Fix and add some spi-nor flash parts (v7)
Date: Wed, 15 Jul 2026 16:30:16 +0800
Message-ID: <cover.1784100103.git.weijie.gao@mediatek.com>
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
Message-ID: <20260715083016.0IAzM0vfsW9AsA4zA_DAN8KSJao9tiMEAiEv4BcLqdU@z>

This patch series correct some existing flash parts and add some new parts.

Changes in v7:
  Remove remaining quad read flag from EN25Q80B.
  Remove quad read flag from MX25L25635E.

Changes in v6:
  Remove quad read flags from some EON flashes

Changes in v5:
  Remove flags for locking from newly added flashes

Changes in v4:
  Remove GD25Q256 and correct flags for GD25B256 (locking is not supported)
  Adjust commit message format

Changes in v3:
  Correct flags for GD25Q256 (locking is not supported)
  Add brief flash description in commit message

Changes in v2:
  Reorder and renaming winbond flash parts

Weijie Gao (7):
  mtd: spi-nor-ids: Correct flash flags for ESMT/EON flashes
  mtd: spi-nor-ids: Add support for ESMT/EON
    EN25QX128A/EN25QH256/EN25QX256A
  mtd: spi-nor-ids: Remove SPI_NOR_HAS_LOCK flag from GigaDevice
    GD25B256
  mtd: spi-nor-ids: Correct flash flags for Macronix MX25L25635E
  mtd: spi-nor-ids: Fix Winbond W25Q256JW and remove W25Q256FW
  mtd: spi-nor-ids: Reorder winbond parts with part families
  mtd: spi-nor-ids: Add support for Winbond W25Q256JV-M/W25Q512JV-M

 drivers/mtd/spi/spi-nor-core.c |   1 +
 drivers/mtd/spi/spi-nor-ids.c  | 183 ++++++++++++---------------------
 include/linux/mtd/spi-nor.h    |   1 +
 3 files changed, 65 insertions(+), 120 deletions(-)

-- 
2.45.2

