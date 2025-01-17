Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1A7C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0DF80793;
	Fri, 17 Jan 2025 10:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="tTHWGKEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7DC80793; Fri, 17 Jan 2025 10:18:26 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C3F8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: fc415b38d4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=W4e8ueLs8ahntZE5GOgbWOBSplXBcR3Akbbmk3rNmg8=; 
 b=tTHWGKEyJXvAHYwBDObcUANbQ1Ikboq68Rrgh3XIJ0VD2I8sy7UIRt0PmeBmJGinbNyXLTi/o8PaCorJd3XI4ic4NikGKAAa2SU2F0DxHtK08g8Q1xNJXxc+bVEexLe2lL6a2knVoQh+6bCcVAAx9rsE7e5hjY5c76F2kEOVYL8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:ee0972d1-f92f-46ee-b838-8f72e61e8a22, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:5b093285-0f10-4f52-bb41-91703793d3e4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fc415b38d4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1753420154; Fri, 17 Jan 2025 17:18:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:15 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:15 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH 09/15] pci: mediatek: add support for multiple ports in
 mediatek pcie gen3 driver
Date: Fri, 17 Jan 2025 17:18:11 +0800
Message-ID: <cac4e51c7cf9789b8d89a316d9c1c4b5c686e757.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
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

One MediaTek PCIe Gen3 controller has only one port, where PCI bus 0
on this port represents the controller itself and bus 1 represents
the external PCIe device.

If multiple PCIe controllers are probed in U-Boot, U-Boot will use
bus numbers greater than 2 as input parameters. Therefore, we should
convert the BDF bus number to either 0 or 1 by subtracting the
offset by controller->seq_.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/pci/pcie_mediatek_gen3.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pcie_mediatek_gen3.c b/drivers/pci/pcie_mediatek_gen3.c
index 0149edae0bf..1818d4c1e30 100644
--- a/drivers/pci/pcie_mediatek_gen3.c
+++ b/drivers/pci/pcie_mediatek_gen3.c
@@ -83,6 +83,28 @@ struct mtk_pcie {
 	struct phy phy;
 };
 
+static pci_dev_t convert_bdf(const struct udevice *controller, pci_dev_t bdf)
+{
+	int bdfs[3];
+
+	bdfs[0] = PCI_BUS(bdf);
+	bdfs[1] = PCI_DEV(bdf);
+	bdfs[2] = PCI_FUNC(bdf);
+
+	/*
+	 * One MediaTek PCIe Gen3 controller has only one port, where PCI bus 0 on
+	 * this port represents the controller itself and bus 1 represents the
+	 * external PCIe device. If multiple PCIe controllers are probed in U-Boot,
+	 * U-Boot will use bus numbers greater than 2 as input parameters. Therefore,
+	 * we should convert the BDF bus number to either 0 or 1 by subtracting the
+	 * offset by controller->seq_
+	 */
+
+	bdfs[0] = bdfs[0] - controller->seq_;
+
+	return PCI_BDF(bdfs[0], bdfs[1], bdfs[2]);
+}
+
 static void mtk_pcie_config_tlp_header(const struct udevice *bus,
 				       pci_dev_t devfn,
 				       int where, int size)
@@ -91,6 +113,8 @@ static void mtk_pcie_config_tlp_header(const struct udevice *bus,
 	int bytes;
 	u32 val;
 
+	devfn = convert_bdf(bus, devfn);
+
 	size = 1 << size;
 	bytes = (GENMASK(size - 1, 0) & 0xf) << (where & 0x3);
 
-- 
2.34.1

