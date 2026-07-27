Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E527C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F3E4406AF;
	Mon, 27 Jul 2026 08:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6HXLUmR5tHe; Mon, 27 Jul 2026 08:18:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6DC9406C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140301;
	bh=ZjQr5DPA+CphAqtkD5lGUv54k6iLqcISwr2RLNUFE14=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsEkLCe2VrUZFGmVv1eJxF1J8JRYZeiV/tuJeuNhIlAMlazCgWiBRKgke2AJDS4vD
	 0gX59a8Sjr1wCbf2YcXy28Vs/4vtdwwyPH7OKYngMTiDA0UNyVX+cM79vhARKgJfC0
	 biBUr8zqGcef6WG97zPAeG6przM7a0DkJ7hljV1tpZfaug28/l7pWUcnuueLyMO4aL
	 mK1XmF/8gR/EYNfU1ajsd38BwUXHxDV98mpc5rboEK775cAqR9QpvEGu6odNHthF+h
	 dL4CCb2b9JWAT3ixiZkNX1pOLIbzZpAus2KPxM7AOSiCS8L27ThvR7YTlTLTM4Yau+
	 07owXyK2f9Wmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6DC9406C7;
	Mon, 27 Jul 2026 08:18:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B8F4C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A35E6605D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMRu_8jxBnBK for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:18:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4BAA1605E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BAA1605E9
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BAA1605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:13 +0000 (UTC)
X-UUID: 9520bda6899111f18dc8c9802ae25ab1-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:676b22d2-42b7-40ae-8494-43d960d4bf6c, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:8a735a6, CLOUDID:5876d5e1-71f1-405e-92eb-6802d6af74fd,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
 15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9520bda6899111f18dc8c9802ae25ab1-20260727
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1478770365; Mon, 27 Jul 2026 16:02:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Jul 2026 16:02:57 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Jul 2026 16:02:56 +0800
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
Subject: [PATCH v8 4/7] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
Date: Mon, 27 Jul 2026 16:02:55 +0800
Message-ID: <1a0f09385dbf3c29e284e98f60abcb46d25303fa.1785138294.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785138294.git.weijie.gao@mediatek.com>
References: <cover.1785138294.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=ZjQr5DPA+CphAqtkD5lGUv54k6iLqcISwr2RLNUFE14=; 
 b=icwNxhhE6HN7Ke+56x651BAmPJxMrHCHjPktmD/OzP2mv2VIrzGMtzQZSoOmijCEmPscZT6iXgLMzRiGWP8kcvYfZMUqLCYfFoR77bmW0jrWVug+FeO8Yw36SxJ/QPW85WqNzbYSQClTUlHg88irEph+jjpyC9mpiY9xYjwUniU=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=icwNxhhE
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

MX25L25635E supports 4KB/32KB/64KB uniform erase sector/blocks.

Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635E,%203V,%20256Mb,%20v1.3.pdf
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v8: restore SPI_NOR_QUAD_READ flag
v7: removed SPI_NOR_QUAD_READ flag
v5-v6: not changed
v3-v4: updated commit message
v2: not changed
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 454969826b8..07f34d361e8 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -323,7 +323,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
 	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
-	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.45.2

