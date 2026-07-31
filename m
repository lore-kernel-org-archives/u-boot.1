Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BEFC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E89680FB8;
	Fri, 31 Jul 2026 08:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBhnoEEcFQUz; Fri, 31 Jul 2026 08:09:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36F1F80FAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785485370;
	bh=sQHUhnXjWMmM19odVLs2uyaabWGJ00BCAPu/736W0IA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adv+MTXwBikhjKlnTOqP0iVRoWed3ykoejXpixurRB+OrwXIp2ejKNGD7SgrPmqBl
	 yyunePf1GhE6bhb8yg1dt6FzhL+7CmHphtP0Xm5X2X8X9BCiy6W8QgH7eq/IucrYlh
	 evIs0/4yPvVmQ8WaKrxwtRkrp2fua8u7EHx+m1G9ganLbdWLoygyH13xs1aLkQmjiG
	 sI9NlClrAGdiDDk5y+S4wvezEwavlYzs96PMKsEMfNf4kSdG/VcRkUddhHqmEDwMRb
	 g4AGIh5/WTONpPWszxLHn7vGCqHt0CWgNND7FtjyLVeh0MRpccjzLvAe+KImaUw/Nk
	 kezaN4HYuJsdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36F1F80FAD;
	Fri, 31 Jul 2026 08:09:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 075E426C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED9E140063
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDagTmeYI7UY for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:09:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D5FFD40164
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5FFD40164
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5FFD40164
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:09:22 +0000 (UTC)
X-UUID: 20ffe6768cb711f1b1788b6acf885367-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:013e7d89-ab26-4904-9b98-2aca790c7cf1, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:7db8b62, CLOUDID:24ba60f1-0685-46a3-9cac-19d8f3a05ae7,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
 15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 20ffe6768cb711f1b1788b6acf885367-20260731
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1773426207; Fri, 31 Jul 2026 16:09:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 16:09:17 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 16:09:16 +0800
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
Subject: [PATCH v10 2/7] mtd: spi-nor-ids: Add support for ESMT/EON
 EN25QX128A/EN25QH256/EN25QX256A
Date: Fri, 31 Jul 2026 16:09:15 +0800
Message-ID: <fd3eade000418e986c36097967de84ea68216a93.1785484578.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785484578.git.weijie.gao@mediatek.com>
References: <cover.1785484578.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=sQHUhnXjWMmM19odVLs2uyaabWGJ00BCAPu/736W0IA=; 
 b=ZzttUOuBF9lFpKx3ItblcYOzqzIV4UvqY0gV8bFYVsVRavQ1Xd6FCgJQm+Z55/qGdde/NkXP/folZPCUpBO/w1VU+/y1QmVg/tD0gjP4/lhTYtqW3bFQ51xbwXRTl7gUejApguzKKTw0UZyRrcDreWKVHApU4O/3NCt4Y9j+L0E=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=ZzttUOuB
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

EN25QX128A/EN25QX256A are 128Mb/256Mb flash devices with Quad interface at
max 104MHz clock rate.
EN25QH256 is 256Mb flash device with Quad interface at max 50MHz clock rate.
Both flashes supports 2.7-3.6V voltage range. However it only supports 1-4-4
quad read which is not supported by U-Boot now.

These flashes are tested on MediaTek's filogic platform.

Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QX128A(2V).pdf
Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH256A(2R).pdf
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v7-v10: not changed
v6: removed SPI_NOR_QUAD_READ from en25qh256
v5: removed locking related flags
v2-v4: updated commit message
---
 drivers/mtd/spi/spi-nor-core.c | 1 +
 drivers/mtd/spi/spi-nor-ids.c  | 3 +++
 include/linux/mtd/spi-nor.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..e4f78e740ba 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -758,6 +758,7 @@ static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
+	case SNOR_MFR_EON:
 		if (need_wren)
 			write_enable(nor);
 
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index cf51f0ffa0b..2e4f63c0c7a 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -95,6 +95,9 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
 	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
 	{ INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25qx128a", 0x1c7118, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("en25qh256",  0x1c7019, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ) },
+	{ INFO("en25qx256a", 0x1c7119, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ) },
 #endif
 #ifdef CONFIG_SPI_FRAM_FUJITSU
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..02fa72fb401 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -33,6 +33,7 @@
 #define SNOR_MFR_SST		CFI_MFR_SST
 #define SNOR_MFR_WINBOND	0xef /* Also used by some Spansion */
 #define SNOR_MFR_CYPRESS	0x34
+#define SNOR_MFR_EON		CFI_MFR_EON
 
 /*
  * Note on opcode nomenclature: some opcodes have a format like
-- 
2.45.2

