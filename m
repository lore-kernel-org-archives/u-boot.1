Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23369F36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 01:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6022283DC9;
	Fri, 10 Apr 2026 03:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="pdyY8doH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C777B84099; Fri, 10 Apr 2026 03:53:47 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C25A83CF5
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 03:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mtk15814@mediatek.com
X-UUID: 17b77dde348011f19a16598d5ca7f8ec-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=iS/nBzKRXC3ts0eBzvjh+Y/OI9yopmssCO5S1Ap1SwY=; 
 b=pdyY8doHEIIIyBDOgCSGf4Afsw2yO2vnqd8nXi0jInFChMGKbsFCRAOY5EXUdAIeOpHg7BM/5D0zqiGWu6LkXq8e5rNaMeZ6iIZOvVIEFBLCJ6bdTO2gy3sQhCdVM6MaKBnoF3BZI1voRAjPLEAtIBR52dfV2NFQB9tdytilDVs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:71c3a324-031e-4d00-942d-796f032fff6a, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:6a00b124-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17b77dde348011f19a16598d5ca7f8ec-20260410
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <mtk15814@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1164628387; Fri, 10 Apr 2026 09:53:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 09:53:37 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 10 Apr 2026 09:53:37 +0800
Received: by mediatek.com (Postfix, from userid 10015814)
 id 1FB9E200C6; Fri, 10 Apr 2026 09:53:37 +0800 (CST)
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] arm: mediatek: enable fw loader support
Date: Fri, 10 Apr 2026 09:53:11 +0800
Message-ID: <20260410015311.4066075-1-weijie.gao@mediatek.com>
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

Enable SUPPORTS_FW_LOADER to allow the mediatek platform to use ethernet PHY
drivers with fw loading.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03416c55265..aee8e74dace 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -868,6 +868,7 @@ config ARCH_MEDIATEK
 	select SPL_LIBGENERIC_SUPPORT if SPL
 	select SPL_OF_CONTROL if SPL
 	select SUPPORT_SPL
+	select SUPPORTS_FW_LOADER
 	help
 	  Support for the MediaTek SoCs family developed by MediaTek Inc.
 	  Please refer to doc/README.mediatek for more information.
-- 
2.45.2

