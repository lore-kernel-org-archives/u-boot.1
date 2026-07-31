Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E80C55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56958607C0;
	Fri, 31 Jul 2026 02:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nt11BlR5XXBL; Fri, 31 Jul 2026 02:53:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB2A5607DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466385;
	bh=9PE8wsOk+uK1/ajvxOebcjM+xIIP3XApubg3vwGOjeE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cuxR3r5rIRK9gcc+X0cFvFSC7L6Rf3tE0ZXvmtq9aOohbpkoo4/YSO5eTulwcMyfI
	 DGjj45rVAHXNIolNJyPI1ikzBI2mMtkOPCf+sPKoc6R27X8s6z8bTIHsfV698MzeyM
	 tmNB11KrIq/Iqmv4A3fuJ4w53VB9TZoJV4zz/ZfpD5EiNGFed2ihhoUokKnM4iqg9K
	 gu5NUyz9LF4oiY1gKaZuQgJcyxp67CXXUzIgDR3X1UGCk/WITo8WUDgZi7+chskiO6
	 YridSBW5W945m3HjooE0V/894jgrspyeeiTkzQfau6OH3FVqkckq/89TtQVEXHE7wx
	 nN5etFqyN9ABg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB2A5607DE;
	Fri, 31 Jul 2026 02:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D06ED27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B669C605E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VvhLtNOfqeW for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:52:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D5CF60614
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D5CF60614
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D5CF60614
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:56 +0000 (UTC)
X-UUID: ea6a67668c8a11f1b1788b6acf885367-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:37111a54-a6c9-4050-8d6c-0f25c31358bd, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:8a735a6, CLOUDID:35cbc28a-2e92-4dcd-8f3b-8af1b16bdb04,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
 0|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea6a67668c8a11f1b1788b6acf885367-20260731
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 627493264; Fri, 31 Jul 2026 10:52:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:52:47 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:52:46 +0800
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
Subject: [PATCH v9 3/7] mtd: spi-nor-ids: Remove SPI_NOR_HAS_LOCK flag from
 GigaDevice GD25B256
Date: Fri, 31 Jul 2026 10:52:46 +0800
Message-ID: <192f510d4c6a1a645e1ad953f066ec5de49a3796.1785465270.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785465270.git.weijie.gao@mediatek.com>
References: <cover.1785465270.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=9PE8wsOk+uK1/ajvxOebcjM+xIIP3XApubg3vwGOjeE=; 
 b=aR3jds+4PAVHPBCbgUeMko5FCqHam+QZ9ifh6sUcluftad9TfOE3exwt/x5c/rBuiHtFdP4JVv/TweLKn0sMCIwagCVmUzO3QmXQWqvNI8xGplje94wVSc8Ws+n7ZuJNSUHeVYRC0+Zu0ON53Anqdue0CmaZGmJhNg3ADF2ciq0=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=aR3jds+4
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

The protection scheme that GD25B256 and all other chips supported is not
compatible with the spi-nor driver:
This driver supports BP{0,1,2} + TB,
while GD25B256 implements BP{0,1,2,3} + TB

Link: https://download.gigadevice.com/Datasheet/DS-00327-GD25B256D-Rev1.7.pdf
Fixes: e72023c4906 ("mtd: spi-nor-ids: add gigadevice part #")
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v5-v9: not changed
v4: new
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 2e4f63c0c7a..454969826b8 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -147,7 +147,7 @@ const struct flash_info spi_nor_ids[] = {
 	},
 	/* adding these 3V QSPI flash parts */
 	{INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,	SECT_4K |
-	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)	},
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25b512", 0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55b01g", 0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
-- 
2.45.2

