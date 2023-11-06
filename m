Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770CFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 01:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11ABB86D7E;
	Mon,  6 Nov 2023 02:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Mu1vaqBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C6E86E9E; Mon,  6 Nov 2023 02:45:26 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3533986D33
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 02:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 1e86f99a7c4611eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oW1MZdaV0ZSDys0vDljG+9+XQAxfEqNT9y6pEa/bMVI=; 
 b=Mu1vaqBMMwZLUPsDqZr0AMIJm7BiUS5J6vAwXF5qSRdL86kYx5bJjnIVgIwx63JRwZXH8dVcmlRjRPWqOYmUNPt516CtFLNrN5cHcCbqm5s/Nd5XcZ6ecobMYvpd66iGWJsC+g0xq4AJo89uARdxdyS9PpRgMsG8BJduUS/W4nw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:be1d51a1-59fb-46cb-9475-0e17c9eeeb20, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:364b77b, CLOUDID:1f3b2efc-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
 NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1e86f99a7c4611eea33bb35ae8d461a2-20231106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <chunfeng.yun@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1830950802; Mon, 06 Nov 2023 09:45:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 09:45:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 09:45:08 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Marek Vasut <marex@denx.de>
CC: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] dt-bindings: phy-mtk-tphy: add properties for phy tuning
Date: Mon, 6 Nov 2023 09:45:05 +0800
Message-ID: <20231106014506.15461-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

Add properties to improve eye diagram which sometimes need adjust
some parameters of u2phy;
Add a property to tune disconnect threshold;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 doc/device-tree-bindings/phy/phy-mtk-tphy.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/device-tree-bindings/phy/phy-mtk-tphy.txt b/doc/device-tree-bindings/phy/phy-mtk-tphy.txt
index 3042c39d09..300e236b5b 100644
--- a/doc/device-tree-bindings/phy/phy-mtk-tphy.txt
+++ b/doc/device-tree-bindings/phy/phy-mtk-tphy.txt
@@ -52,6 +52,15 @@ Optional properties (port (child) node):
 		  "da_ref": the reference clock of analog phy, used if the clocks
 			of analog and digital phys are separated, otherwise uses
 			"ref" clock only if needed.
+- mediatek,eye-vrt	: The selection of VRT reference voltage (U2 phy),
+		  the value is [1, 7]
+- mediatek,eye-term	: The selection of HS_TX TERM reference voltage (U2 phy),
+		  the value is [1, 7]
+- mediatek,discth	: The selection of disconnect threshold (U2 phy),
+		  the value is [1, 15]
+- mediatek,pre-emphasis	: The level of pre-emphasis which used to widen
+		  the eye opening and boost eye swing,
+		  the value is [1, 3]
 
 Example:
 
-- 
2.25.1

