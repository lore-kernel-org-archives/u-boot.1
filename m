Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB35EC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 06:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E05587103;
	Wed, 13 Dec 2023 07:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="GdIAIxZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E62871F0; Wed, 13 Dec 2023 07:57:30 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 669BA87101
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 07:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: aa9c3ce8998211eea5db2bebc7c28f94-20231213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oW1MZdaV0ZSDys0vDljG+9+XQAxfEqNT9y6pEa/bMVI=; 
 b=GdIAIxZRvx1xHP4etiZsQvmCi3+FcUfzuiJHSpBMB8jIVKvpXMfeh24ARHl6AMGPxUyO5r5eNG5GJdA6M5ehI8VJdTJgIBslETsIQusmJmZl962LE433aYR2IMsiLtrnHV0P2TecBYwEGjJzjAQ5+v9Le2CA6YWkGt0YGASVR/8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35, REQID:d2e105b5-8c4b-488d-bfde-3cde561836ed, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:5d391d7, CLOUDID:41fb9cfd-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
 NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: aa9c3ce8998211eea5db2bebc7c28f94-20231213
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <chunfeng.yun@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 41788124; Wed, 13 Dec 2023 14:41:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Dec 2023 14:41:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Dec 2023 14:41:35 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
CC: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>
Subject: [PATCH RESEND 1/2] dt-bindings: phy-mtk-tphy: add properties for phy
 tuning
Date: Wed, 13 Dec 2023 14:41:33 +0800
Message-ID: <20231213064134.12727-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.959500-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sGx8/x3sgTgqTPDkSOzeDWWUZ7HC5zQAuxl3M0JaJAkWYpb
 wG9fIuIT66A3juasWbGycPdNAYfPgnidXeNxTCqU8hUvf4pI2DC/zKpacmFSwYsV3GTNaSF4o8W
 MkQWv6iXBcIE78YqRWo6HM5rqDwqtGnmZS2OrH4BAF4ySYmzCrIGCJHED8AUrMYZ6R8L9f8h+Sj
 2lkC+rUepBD18u7t55dD+VTD5rAJ0qzfpD0LrA4xD0SbkydTZj4sOrsb4iT/K/bbEolHIgZUOc7
 GjOamnWv5a9cmIodEspRnLV2kwrLg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.959500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4C7F0CC8BB68F6B5D0EC0DADDDEC575CEFFEC71DD3952232C6C525D1A3A9F5472000:8
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

