Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE03D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E29D89045;
	Mon, 14 Oct 2024 15:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LVpLvhzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD2488FB9; Mon, 14 Oct 2024 09:06:28 +0200 (CEST)
Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [216.200.240.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3570388F24
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=skylake.huang@mediatek.com
X-UUID: d118c92c89fa11efba0aef63c0775dbf-20241014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=Pqm90LdZty8nNtON5VvQaDo+YPjA+4aHiqyHzoU8dZ8=; 
 b=LVpLvhzS7Ce02rWoebNL/ymrxvZxzsSAO/enyvbkebBVGgIaiBigCSAPyODnHUSeYhnXAJMuy7TY3Po1pxh6eFxAPspIoHZq1oRtWio9kq8Hy/zf8jhNgNc8tq8gWsEHGgxEGYZyqcoYs9bXmNmDtM0BhNjbZOaPGqRfKeuJ9fI=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41, REQID:8e59c9f9-cf07-42d5-a637-8c186989054c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:100
X-CID-INFO: VERSION:1.1.41, REQID:8e59c9f9-cf07-42d5-a637-8c186989054c, IP:0,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
 N:quarantine,TS:100
X-CID-META: VersionHash:6dc6a47, CLOUDID:4a143641-8751-41b2-98dd-475503d45150,
 B
 ulkID:241014150622Z3C4RJOV,BulkQuantity:0,Recheck:0,SF:66|38|29|28|16|19|4
 8,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
 :nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-UUID: d118c92c89fa11efba0aef63c0775dbf-20241014
Received: from mailgw01.mediatek.com [(172.21.84.68)] by mailgw02.mediatek.com
 (envelope-from <skylake.huang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1999869535; Mon, 14 Oct 2024 00:06:21 -0700
X-UUID: ccc9fb6689fa11ef88ecadb115cee93b-20241014
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41, REQID:e6e8fda0-cabe-49b5-80da-64add27eb5e0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6dc6a47, CLOUDID:b2c43365-444a-4b47-a99a-591ade3b04b2,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ccc9fb6689fa11ef88ecadb115cee93b-20241014
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <skylake.huang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1385590977; Mon, 14 Oct 2024 15:06:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 14 Oct 2024 15:06:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 14 Oct 2024 15:06:12 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jacky Chou
 <jacky_chou@aspeedtech.com>
CC: <u-boot@lists.denx.de>, <gss_mtk_uboot_upstream@mediatek.com>,
 SkyLake.Huang <skylake.huang@mediatek.com>
Subject: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet phy
 driver probe
Date: Mon, 14 Oct 2024 15:06:11 +0800
Message-ID: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.363000-8.000000
X-TMASE-MatchedRID: NJitR9TboxzhtVvI3rIgychI95kTx6VeaN2KuTwsCwINAzuXf98XU9n7
 b/+Y15IvprhPLBzR/tEIrfMdFvsao1v6Cm/U+wb8ngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
 uXd3MZDWuikCL8VXXTNy/9AHauzrzF+mNG7cQQNtoOV0XNceIBMgWyFhyFCThl5lPxc0kjNU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.363000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C99186F7672618583D7F6F7D91DBFC777723B2C32B3386FBE7489DEBE3781CFE2000:8
X-MTK: N
X-Mailman-Approved-At: Mon, 14 Oct 2024 15:03:22 +0200
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

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Remove unnecessary CL22 phy reset before ethernet phy driver
probe. Lots of ethernet phys requires driver to load firmware.
Before that, CL22 phy reset may lead to malfunction.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/phy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 716a1d46111..e6fed8c41d7 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mii_dev *bus, uint phy_mask)
 static void phy_connect_dev(struct phy_device *phydev, struct udevice *dev,
 			    phy_interface_t interface)
 {
-	/* Soft Reset the PHY */
-	phy_reset(phydev);
 	if (phydev->dev && phydev->dev != dev) {
 		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
 		       phydev->bus->name, phydev->addr,
-- 
2.45.2

