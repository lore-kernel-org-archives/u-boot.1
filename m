Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474FFC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D03F406D2;
	Mon, 27 Jul 2026 08:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RdqcHTG52gZV; Mon, 27 Jul 2026 08:18:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80F014066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140298;
	bh=dlnJOsBvhXu4uwwVZ1E6n4zw4ZCCqsPwmXYozS68Fig=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOyzf4IjdALjSPZADGSjqwzxkf3XxNcY70ZRIHc+BETqhYE7f+K6V0UrQRFn4lmkc
	 Yl9aF8KzDMxx7lZyNATL73C3cTnQMtYcD1Pyxe6btYlhJ8An8L+fiOxCnJP4CaIsZT
	 uhzcQI2+Tm9EMawP7kWqqUWORu7AAhMdqIWIqAAtgPMkz06QCfSD9yrSGSYDLUNicF
	 TXeicJTWbQ/nZK1RlPbuWJh8OIU6CvXwuxKsetnO5mCGg+/yn96fZqpqOogCNoRPcZ
	 crDyN6Bphqb1Zxojcq1iqPoAIL5eRy0XkqxzWiXZUksMhzOq8K3jsnX9nNZZd9hIs4
	 /EDkrmH35IfGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80F014066F;
	Mon, 27 Jul 2026 08:18:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E9914C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49ABA80C94
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QaQp3blSOf74 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:18:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3FD3680C85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FD3680C85
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FD3680C85
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:13 +0000 (UTC)
X-UUID: 9905385c899111f1b1788b6acf885367-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:66546361-5256-4a00-92b9-653cbc0aca16, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:8a735a6, CLOUDID:ac0a1c3f-4441-41ea-be46-5f33182207a4,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
 15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9905385c899111f1b1788b6acf885367-20260727
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1511195869; Mon, 27 Jul 2026 16:03:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Jul 2026 16:03:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Jul 2026 16:03:03 +0800
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
Subject: [PATCH v8 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Date: Mon, 27 Jul 2026 16:03:02 +0800
Message-ID: <bb55b43fe713b6510d5445f656d5565f6f1301c4.1785138294.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1785138294.git.weijie.gao@mediatek.com>
References: <cover.1785138294.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=dlnJOsBvhXu4uwwVZ1E6n4zw4ZCCqsPwmXYozS68Fig=; 
 b=UnYjevWujzLbByoBVuCIeHsh28M6tfUmeVvsHqSMF7sY1mZbd+Rw5kaGjE1hOl72c/IwzZsM7hrhfFbCL2LBdo2fukWl4JUyy4UP3wPvfNSmpn4GY1M+x+kvsslhVposnQuldoh7y30SkRQpP0ryO5tXU42PubKvQVoB59ip9ks=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=UnYjevWu
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
v6-v8: unchanged
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

