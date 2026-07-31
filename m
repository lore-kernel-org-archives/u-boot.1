Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC7BC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EED4606E5;
	Fri, 31 Jul 2026 02:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kpqZ5xwEcLI; Fri, 31 Jul 2026 02:52:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C840160614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466378;
	bh=JMyiGVxpB9YlM6TxxHmr5QzmGKHuXMRQSgVa86ynHak=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JZWKhJ2FoOZNpBEH43IHJqBypPstTEMDrTFGCsDjBgi8ZZeH2KwyYghvJARGQWGDh
	 G6crsVr3u52M8HN08ND962CL9mEvE4mcKCN/pY5EVxxurioTDFhOHudQFlSfvBW0Yy
	 pJCPSQKNB7YVXIM3CuZqRs5/Qh3Az1leRjqpdT9ZuJG5g1fpGkqdZ8L5cDCAOfSo+z
	 ZwlNxRPD7kaVBdpOPc/QhC1wrKq/ES8lm+lsdOPp9l2RLcU1orVJmRuEb9Iz12qPK4
	 X8HxrGJh4Gwd5L6608ytv0D2ZGZZL+FV/FnfmDv1lvhv6u6vUQ3As8Uac3fTwnff4f
	 JZ4sxwIiCywKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C840160614;
	Fri, 31 Jul 2026 02:52:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DE3A218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBEF3606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkchwAK663TY for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:52:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 93FA860614
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93FA860614
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93FA860614
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:48 +0000 (UTC)
X-UUID: e6b262b88c8a11f1b1788b6acf885367-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:eee8baa5-4079-471f-b226-2f84f7c1a06a, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:8a735a6, CLOUDID:67b565f2-937e-4000-89cb-245892a7adad,
 B
 ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
 DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e6b262b88c8a11f1b1788b6acf885367-20260731
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1030842253; Fri, 31 Jul 2026 10:52:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:52:41 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:52:40 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v9 0/7] Fix and add some spi-nor flash parts (v9)
Date: Fri, 31 Jul 2026 10:52:36 +0800
Message-ID: <cover.1785465270.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=JMyiGVxpB9YlM6TxxHmr5QzmGKHuXMRQSgVa86ynHak=; 
 b=lFdKrFEScHQBuY9nhHobx/orcNnx2nrjpgBQmVCV4UvbQX1DnobkbExDyynao6uTkcbAALpxjkwd+5XhvPhnOdhE/C8fwXIJQPXNtLP2ulwJiuUCznMfpbXpxjR6cghNXJW8W5MoZaslzYlX4imQ9itdr9a9o3dHmkEbPEFqHSQ=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=lFdKrFES
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This patch series correct some existing flash parts and add some new parts.

Changes in v9:
  Correct commit message of "Correct flash flags for ESMT/EON flashes".

Changes in v8:
  Restore quad read flag for MX25L25635E.

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
  mtd: spi-nor-ids: Add 4K page support for Macronix MX25L25635E
  mtd: spi-nor-ids: Fix Winbond W25Q256JW and remove W25Q256FW
  mtd: spi-nor-ids: Reorder winbond parts with part families
  mtd: spi-nor-ids: Add support for Winbond W25Q256JV-M/W25Q512JV-M

 drivers/mtd/spi/spi-nor-core.c |   1 +
 drivers/mtd/spi/spi-nor-ids.c  | 183 ++++++++++++---------------------
 include/linux/mtd/spi-nor.h    |   1 +
 3 files changed, 65 insertions(+), 120 deletions(-)

-- 
2.45.2

