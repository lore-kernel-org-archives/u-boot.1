Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA034C02192
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 00:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1AF80104;
	Thu,  6 Feb 2025 01:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="u4ZppxJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA46E8033D; Thu,  6 Feb 2025 01:41:46 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB65D800CF
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 01:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1cb0842ee42311efb8f9918b5fc74e19-20250206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=ouVYNjxVtqeY+2xmYPjcsBPnz/QSMbLvmJQgU3gf5tY=; 
 b=u4ZppxJgzLY7vxVD9UUsOTb7XVtA8CBibhZWKbs/iEzNziMdYa9M+ij0wAeOQXMAxz3SCYA6HayPPIhjnNVGqYMDfGnM2FAxGoTectJO4n06xmVaorUlj5jj6ZJa6uEMpJIeKOAZx/Qa/lGhBgSSn62VOeoScZ6NSknhndQp5Io=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:bebfd62b-4cd2-4085-821d-16ca7f102f74, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:5e8b35ff-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1cb0842ee42311efb8f9918b5fc74e19-20250206
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 915330943; Thu, 06 Feb 2025 08:41:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Feb 2025 08:41:31 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Feb 2025 08:41:31 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH,
 RESEND] mediatek: mt7986: rename pinctrl to pio in mt7986-u-boot.dtsi
Date: Thu, 6 Feb 2025 08:41:28 +0800
Message-ID: <20250206004128.153430-1-weijie.gao@mediatek.com>
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

The change from pinctrl to pio was missing in mt7986-u-boot.dtsi and will
cause build failure. Now fix it.

Fixes: f1775996ba9 (mediatek: mt7986: move gpio-controller up and rename pinctrl to pio)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7986-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt7986-u-boot.dtsi b/arch/arm/dts/mt7986-u-boot.dtsi
index 096b97371b8..71e83304c74 100644
--- a/arch/arm/dts/mt7986-u-boot.dtsi
+++ b/arch/arm/dts/mt7986-u-boot.dtsi
@@ -28,6 +28,6 @@
 	bootph-all;
 };
 
-&pinctrl {
+&pio {
 	bootph-all;
 };
-- 
2.34.1

