Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C27F36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 02:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A330A84099;
	Fri, 10 Apr 2026 04:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="HqXbLucI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3D284105; Fri, 10 Apr 2026 04:13:35 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E1C83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mtk15814@mediatek.com
X-UUID: dc2f8e7a348211f19a16598d5ca7f8ec-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oWdJ//yi+YCEyYMQkfXiLBj5aShMwyWib5shaJ4pBMQ=; 
 b=HqXbLucImMjhb1f4aphEfnPVMXulxoQ8fx8JDOGn1jLu6h8/DixJEZIjXuV3Xq+w8sL+bWqJi4gAokoGAsgItY8jmyvSqP2GiDrrjzmz3gu59MFLaZoqgrhHKbOIPXStzAM6DlsSOAor1LOwq/jp2Xiav3mjGYDYvxrvjrtY/ME=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:97451162-eb68-4bf9-b734-6f87121920d8, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:576e408f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc2f8e7a348211f19a16598d5ca7f8ec-20260410
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <mtk15814@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1340675251; Fri, 10 Apr 2026 10:13:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 10:13:25 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 10 Apr 2026 10:13:25 +0800
Received: by mediatek.com (Postfix, from userid 10015814)
 id A0F93200C6; Fri, 10 Apr 2026 10:13:25 +0800 (CST)
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, Sam Shih
 <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 1/2] clk: mediatek: remove redundant forward declarations
Date: Fri, 10 Apr 2026 10:12:57 +0800
Message-ID: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sam Shih <sam.shih@mediatek.com>

The clk_ops structures (mtk_clk_apmixedsys_ops, mtk_clk_topckgen_ops,
mtk_clk_infrasys_ops) are already declared with extern in clk-mtk.h,
which is included by this file. The forward declarations in clk-mtk.c
are therefore redundant and can be removed.

Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup functions")
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

---
 drivers/clk/mediatek/clk-mtk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3557aeac3d5..4adec4457b4 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -204,10 +204,6 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 	return clk_get_rate(&parent);
 }
 
-const struct clk_ops mtk_clk_apmixedsys_ops;
-const struct clk_ops mtk_clk_topckgen_ops;
-const struct clk_ops mtk_clk_infrasys_ops;
-
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 				  const int parent, u16 flags)
 {
-- 
2.45.2

