Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC04C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09B4F40ECE;
	Fri, 31 Jul 2026 02:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gryXV8aD9CEq; Fri, 31 Jul 2026 02:53:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1947740EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466389;
	bh=gjhjahjalAnHE7dDyAUGHjH5GTHvpNmszxGydrRD7C0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmM3KYtk9UsLUGf7iXItTwL6jFxu/tee5jkS/eJEMGwXn+xhxuUXeJiKzadrqbWMF
	 OfIEE3zsMFft3rTRXIMMxiBU1jNfHGXoDyo0WhK/S1/170FgYGRON5HjwjCJ6c4YHH
	 jGRhzbJbeMJnCzboIMWwjl/C0C6D76M05kdhsIuOLr12CnSIHzVBZxQTto0NSyockw
	 FyfzXf987VVQf4iCn6/2vM/ouo/Ig2tIfRNjU2bn+OkA+fPaMW4F90X46pdWqySaJ3
	 p558TDj2T+vwI+Wu6tkNMJF4W0uDlbcGloGz15ErzT4FvOYoaKm+YqSsqTO+4HnyJA
	 Dio336cNBkmIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1947740EC9;
	Fri, 31 Jul 2026 02:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53FE869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45B7880ECD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e0pS3JQ_sY5P for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:53:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 175BD80EC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 175BD80EC9
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 175BD80EC9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:53:01 +0000 (UTC)
X-UUID: ecf6cbf08c8a11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:d31e314a-3012-4f1b-ad52-0c928fae4299, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:8a735a6, CLOUDID:63cbc28a-2e92-4dcd-8f3b-8af1b16bdb04,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
 0|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ecf6cbf08c8a11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2090526468; Fri, 31 Jul 2026 10:52:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:52:52 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:52:51 +0800
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
Subject: [PATCH v9 5/7] mtd: spi-nor-ids: Fix Winbond W25Q256JW and remove
 W25Q256FW
Date: Fri, 31 Jul 2026 10:52:50 +0800
Message-ID: <640a85d5adde2df573ea8b5def96684af7b4c629.1785465270.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785465270.git.weijie.gao@mediatek.com>
References: <cover.1785465270.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=gjhjahjalAnHE7dDyAUGHjH5GTHvpNmszxGydrRD7C0=; 
 b=PU46rMB5Y78+h6sz9RBJLj5KRjdpeLnIHO886DUkDtMIVh6taMhJhH1qH5ubjbL3VWRpVvaGY2/N8L2H6puql75PgszXgAgHfq44+GKdzPtrL3CwLzazTZJHUK5thtHJ74z9shtDFSf1CdLtNI0teGCHe0l7pOjp27OFINXqtvY=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=PU46rMB5
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

There's no part named W25Q256FW, only W25Q256JW-M (Non-DTR version) exists
with ID ef6019.

Link: https://www.winbond.com/resource-files/W25Q256JW%20SPI%20RevJ%2003102021%20Plus.pdf
Fixes: d8c16849a90 (sf: Add Winbond W25Q256 ID)
Fixes: 760b75564fd (spi_flash: add a bunch of winbond flashes to id-table)
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v5-v9: not changed
v3-v4: updated commit message
v2: not changed
---
 drivers/mtd/spi/spi-nor-ids.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 07f34d361e8..3e5a6dc37b6 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -603,12 +603,7 @@ const struct flash_info spi_nor_ids[] = {
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
 	{
-		INFO("w25q256fw", 0xef6019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q256jw", 0xef7019, 0, 64 * 1024, 512,
+		INFO("w25q256jw", 0xef6019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
-- 
2.45.2

