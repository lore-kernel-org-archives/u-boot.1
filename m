Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E13C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57EA3607DD;
	Fri, 31 Jul 2026 02:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WO1G5JIWyt7G; Fri, 31 Jul 2026 02:53:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C4C7607BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466384;
	bh=Fja6EHXJl7nhTM43mlaOFxkNd45TajWx0aErc19guUI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PP7xYwwAEG59RALAw4AspyZRe4Dhg7yPMl2NjAdUYFFFilnkVBxRHPNyHBA+kYqUa
	 EbGIgN4qd3Vh8z/GImM8QvM2rvUmKDJ6Y8VOwT5Ag9Eq6Ey31HEtqM9F0SvGVgkbg2
	 PuStFtkKfskd7M5Tkz+Wpn1K2J6Q2g2infvmB1eciz81yqo3D4vUoeSFRi4yvFpikA
	 GRyL8WIkZRdzxRbzOWawq7W7/+w3QZRqP3g9jxHMNH3YZ6+B5zp+y5x7ceLA2sqw+d
	 2pBmEMGFKjoNqCPdkQdyb/KyvBKwR2A5idVpiR+z9952laJEx4gBOcDD5KzNmXM+gv
	 NONzInbkmetcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C4C7607BE;
	Fri, 31 Jul 2026 02:53:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9060527C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81E7E80ECD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-zi0nD3NUSp for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:52:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3927480EC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3927480EC9
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3927480EC9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:52:55 +0000 (UTC)
X-UUID: e7eadd0e8c8a11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:73328fa5-33f7-44e2-ae65-eb0ed4710c7b, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:8a735a6, CLOUDID:341f5a8b-892b-4c95-a653-2e7ac6b085d2,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
 0|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7eadd0e8c8a11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2074449602; Fri, 31 Jul 2026 10:52:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:52:43 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:52:42 +0800
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
Subject: [PATCH v9 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Date: Fri, 31 Jul 2026 10:52:41 +0800
Message-ID: <cda540e8f7258c43be27007c5c37e15e316d9305.1785465270.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785465270.git.weijie.gao@mediatek.com>
References: <cover.1785465270.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Fja6EHXJl7nhTM43mlaOFxkNd45TajWx0aErc19guUI=; 
 b=p/NEH0PkQC/SMNjIISjbUJgj3o96+3EExEs/W3mxz9YL9b8PadAAeWt+TU2uVV5PegFReL/qZkujM7jn/+HZxF1VRYcfDORHrd9sjv7yeev0Qpko2LU6xsYutGJGHI5u4iHL657nVjKTkN/wIyLQu8mGGA9LE+HDXEE1LeclFAo=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=p/NEH0Pk
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

All currently supported ESMT/EON flashes supports 4KB sector and dual read.

Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A%20(2TC).pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pdf
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v9: remove "EN25Q80B 1-1-4 read" from commit message
v8: not changed
v7: removed SPI_NOR_QUAD_READ from en25q80b
v6: removed SPI_NOR_QUAD_READ from incompatible flashes
v5: not changed
v3-v4: updated commit message
v2: not changed
---
 drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..cf51f0ffa0b 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -90,12 +90,12 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
-	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
-	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
-	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
-	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
-	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0) },
-	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
+	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
 #endif
 #ifdef CONFIG_SPI_FRAM_FUJITSU
 	/* Fujitsu MB85RS256TY */
-- 
2.45.2

