Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF68E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1FA80219;
	Tue, 17 Dec 2024 09:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lQMOm86W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D4880224; Tue, 17 Dec 2024 09:39:30 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A508022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6a4bbadabc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=yXQuUE7Llkt6ZAfPmHi31zMz6rHD24ThdGMQjIIWn7M=; 
 b=lQMOm86W2FgIUmPiX4os7+hEcXdI7VJqAo7xsYHeME4kbXDaW/ih9ujjqiT1LbCzMyZQ35oUraj9pegNtdYWvsBv+ZFGNhITrZ1SwIc/D5blVF2MoDiF4N8FMratv6Jxntq8hUUM5kp8SrF6XSGaA17pUfxSLy9h/dY5VBCliJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:0d542cc2-e2a5-48fa-a178-a8da1f951546, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:6493067, CLOUDID:b9b34313-8f5d-4ac6-9276-7b9691c7b8d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a4bbadabc5211efbd192953cf12861f-20241217
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2147342032; Tue, 17 Dec 2024 16:39:22 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:21 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:21 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 02/10] arm: dts: mt7629: fix sgmii clock selection for ethernet
Date: Tue, 17 Dec 2024 16:39:20 +0800
Message-ID: <0c13bda7a1809c7bc6a6782b4f942670a9ff10d1.1734406968.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1734406967.git.weijie.gao@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
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

Setup correct parent of clock CLK_TOP_SGMII_REF_1_SEL to allow
sgmiisys1 work correctly.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7629.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt7629.dtsi b/arch/arm/dts/mt7629.dtsi
index 7dea7809c70..cd8277deafe 100644
--- a/arch/arm/dts/mt7629.dtsi
+++ b/arch/arm/dts/mt7629.dtsi
@@ -314,8 +314,10 @@
 				"sgmii2_cdr_ref", "sgmii2_cdr_fb",
 				"sgmii_ck", "eth2pll";
 		assigned-clocks = <&topckgen CLK_TOP_ETH_SEL>,
-				  <&topckgen CLK_TOP_F10M_REF_SEL>;
+				  <&topckgen CLK_TOP_F10M_REF_SEL>,
+				  <&topckgen CLK_TOP_SGMII_REF_1_SEL>;
 		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>,
+					 <&topckgen CLK_TOP_SYSPLL4_D16>,
 					 <&topckgen CLK_TOP_SGMIIPLL_D2>;
 		power-domains = <&scpsys MT7629_POWER_DOMAIN_ETHSYS>;
 		resets = <&ethsys ETHSYS_FE_RST>;
-- 
2.34.1

