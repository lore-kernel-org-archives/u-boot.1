Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EE7C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1024360658;
	Fri, 31 Jul 2026 02:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JKp5yACxLRF1; Fri, 31 Jul 2026 02:53:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF27A608B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466393;
	bh=XxXZDpl6VmAaN0aO5nvppAHHuvJSkNvUye3aMqpw/T8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTHBCqE20nh1ITrxLDxw19uF72SpyqVNMOrYktJhxywVlWYJPx4XQLvXtXNWX6TQs
	 slxIMnDVwwbR1a/y3wm7KIxrgiIAVEtOGIwTio3gjTXW7z9M0KZp0RMTsvmVrjZOrL
	 m7wlDmMy6zV3lfxxfR0/pMXlt0ofuGx4eo/mN/+xUA6fdqsro2gk5EjxOW4Xtbbh49
	 k4NJxo1v/hDuYDP6Srx3thkq9kOd+d9zM2fu9VTfwMcB+KME7idknBQp++2kqSiP+Z
	 XtYRNetDl6zI8Cs2RUVAB8WMlpaTe3IzR984vEacjyAxPm4cist1SBvEWvl6zMFHxv
	 j0YBjvGBdJstg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF27A608B7;
	Fri, 31 Jul 2026 02:53:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 69B11218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40CAD6081D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xHa1LUAZNhUa for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 917AA60811
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 917AA60811
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 917AA60811
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:06 +0000 (UTC)
X-UUID: efb336948c8a11f1b1788b6acf885367-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:cc80221d-e781-4907-98d8-58d35bef0863, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:8a735a6, CLOUDID:d31f5a8b-892b-4c95-a653-2e7ac6b085d2,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
 15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efb336948c8a11f1b1788b6acf885367-20260731
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2013252301; Fri, 31 Jul 2026 10:52:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:52:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:52:55 +0800
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
Subject: [PATCH v9 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Date: Fri, 31 Jul 2026 10:52:54 +0800
Message-ID: <382fd445beaa18f370817629756e919976d7969e.1785465270.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785465270.git.weijie.gao@mediatek.com>
References: <cover.1785465270.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=XxXZDpl6VmAaN0aO5nvppAHHuvJSkNvUye3aMqpw/T8=; 
 b=CbUgwcwH7xPYgMzeorct45UMwVZK66a7bQl+ywkfVPv76K9yvKEYZ9nN6bnprq8qXux+Y+8s3d9xxUd6fipPE6OEpaJfmEHiW4AUawRM59JY8oOCLyeD266HdKn9pntAEjd9HzyCiWetcpElh4atUgWXnjasHXEWA/+m3CuZ+5A=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=CbUgwcwH
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

W25Q256JV-M/W25Q512JV-M are 256Mb/512Mb flash devices with Quad interface at
max 104MHz clock rate. DTR is not supported.
These flashes supports 2.7-3.6V voltage range.

Both tested on MediaTek's filogic platform.

Link: https://www.winbond.com/resource-files/W25Q256JV%20DTR%20RevK%2010202025%20Plus.pdf
Link: https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%2006292020%20133.pdf
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v6-v9: unchanged
v5: removed locking related flags
v3-v4: updated commit message
v2: refactored with previous patch. updated commit message
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 387dc2b6f76..e5199312fd5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -583,6 +583,8 @@ const struct flash_info spi_nor_ids[] = {
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ INFO("w25q128jv-m", 0xef7018, 0, 64 * 1024, 256,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q256jv-m", 0xef7019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
+	{ INFO("w25q512jv-m", 0xef7020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
 	{ INFO("w25q01jv-m", 0xef7021, 0, 64 * 1024, 2048,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ INFO("w25q02jv-m", 0xef7022, 0, 64 * 1024, 4096,
-- 
2.45.2

