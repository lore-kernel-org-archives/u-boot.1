Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE524F327C2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437798439E;
	Tue, 21 Apr 2026 10:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Z5Ze5DuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897BA843D0; Tue, 21 Apr 2026 10:56:42 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFEB84390
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 003d80663d6011f19781c1a04af40193-20260421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=6gjKRHbA6yZVoBqkaPphRqOTvUgRH5+Z9N3SclNwANw=; 
 b=Z5Ze5DuMq2x63iufjoriGJiUhamF2JCjZWniwcGryOGIcmN9GPa9qY9iiiBvQ0ODwfNeaM51aje5zhdhEp1d3TNrn5R9V4C+9PdVt2i7EK7MwncQtVSID5opK6/9A90oyEMYcdXcAdRxD/DWw3EsUh0t2EPf7vT0RiOKU9OwBZ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f9d5c8c1-72f5-4e8f-a31b-05970af10ed9, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:7708ad8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 003d80663d6011f19781c1a04af40193-20260421
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1769067800; Tue, 21 Apr 2026 16:56:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 21 Apr 2026 16:56:34 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 21 Apr 2026 16:56:33 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Julien
 Masson <jmasson@baylibre.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] configs: mt7622: remove empty header file
Date: Tue, 21 Apr 2026 16:56:27 +0800
Message-ID: <20260421085627.78213-1-weijie.gao@mediatek.com>
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

Remove the empty include/configs/mt7622.h header file as it is not needed.
The Kconfig entry that referenced it is also removed.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig |  1 -
 include/configs/mt7622.h       | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100644 include/configs/mt7622.h

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index b5b06f4e5b2..80f7185e929 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -195,7 +195,6 @@ config SYS_BOARD
 	  be used.
 
 config SYS_CONFIG_NAME
-	default "mt7622" if TARGET_MT7622
 	default "mt7623" if TARGET_MT7623
 	default "mt7629" if TARGET_MT7629
 	default "mt7981" if TARGET_MT7981
diff --git a/include/configs/mt7622.h b/include/configs/mt7622.h
deleted file mode 100644
index 4a056954bf8..00000000000
--- a/include/configs/mt7622.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Configuration for MediaTek MT7629 SoC
- *
- * Copyright (C) 2019 MediaTek Inc.
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#ifndef __MT7622_H
-#define __MT7622_H
-
-#endif
-- 
2.45.2

