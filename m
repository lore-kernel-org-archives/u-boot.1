Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D923D19512
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 02:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B879783F53;
	Tue, 27 Jan 2026 03:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="JCYfs5TD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D7483F54; Tue, 27 Jan 2026 03:09:01 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C7B83F2E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1f1d9c1efb2511f0b7fc4fdb8733b2bc-20260127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=ELOCCe9D86B1x/yXyGtYR+cCnD/s6ixs0FtFkjXI19I=; 
 b=JCYfs5TDhjWBTDFTvS9hMx3uGZT2t6sjjKCIKqQw0uQkBaBS/4EhTvGzjhQi4v1ZSadY+oTVgGlm5fK1gIgvWdt69wI/Sm118sKMcMwcjKg4GLPj43+ouhCTHJ4vym4nTrwpMxW0XoNmwf0T+KRyLMSzUoH1DAHAsp0ZQOysS+8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:ba146cad-294b-4e3d-8718-c3b5aa306e49, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:89c9d04, CLOUDID:bb93407a-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f1d9c1efb2511f0b7fc4fdb8733b2bc-20260127
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 857706460; Tue, 27 Jan 2026 10:08:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 27 Jan 2026 10:08:47 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 27 Jan 2026 10:08:46 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, Beiyan Yun
 <root@infi.wang>, Siddharth Vadapalli <s-vadapalli@ti.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: [PATCH] net: phy: aquantia: add support for Marvell CUX3410 10Gb PHY
Date: Tue, 27 Jan 2026 10:08:45 +0800
Message-ID: <20260127020845.170855-1-weijie.gao@mediatek.com>
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

The CUX3410 is similar to AQR113C. The main difference is CUX3410 does not
support MACSEC.

Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
---
 drivers/net/phy/aquantia.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index e0deef58f52..10b87dfb8ab 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -714,3 +714,17 @@ U_BOOT_PHY_DRIVER(aqr412) = {
 	.shutdown = &gen10g_shutdown,
 	.data = AQUANTIA_GEN3,
 };
+
+U_BOOT_PHY_DRIVER(cux3410) = {
+	.name = "Marvell CUX3410",
+	.uid = 0x31c31dd3,
+	.mask = 0xfffffff0,
+	.features = PHY_10G_FEATURES,
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS |
+		 MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
+	.config = &aquantia_config,
+	.startup = &aquantia_startup,
+	.shutdown = &gen10g_shutdown,
+	.data = AQUANTIA_GEN3,
+};
-- 
2.17.0

