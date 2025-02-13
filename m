Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73027C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 09:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1357807F1;
	Thu, 13 Feb 2025 10:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="V99LOLf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACF580A55; Thu, 13 Feb 2025 10:00:54 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24076801DE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ff22f718e9e811efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=CQIfjb2vCwhjkxdgqIECv5ZB3Rcf8kzXxvE3PtctVG4=; 
 b=V99LOLf8gHEqNlpEIYoect+F1FUtg7l+CC5L9za07oGcFc0iYpwLZvRvzMyYPjxd1weIYHCLf1gS86EC3icxzgLs9uS1liIe1oqH8ew00eoOY7DKnc+S4ShCEby6glin6wN2rcgVkwAYyqSXjp1cscoIXlEDxH06BqdghcD4DV4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:943e332f-a662-42eb-95a0-19df54f4b818, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:f4108327-6332-4494-ac76-ecdca2a41930,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff22f718e9e811efb8f9918b5fc74e19-20250213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1518740028; Thu, 13 Feb 2025 17:00:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 17:00:38 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 17:00:37 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] arm: mediatek: build u-boot-mtk.bin only if needed
Date: Thu, 13 Feb 2025 17:00:34 +0800
Message-ID: <20250213090034.83834-1-weijie.gao@mediatek.com>
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

Not all MediaTek platforms needs u-boot-mtk.bin.

This patch will let u-boot generates u-boot-mtk.bin only if
CONFIG_MTK_BROM_HEADER_INFO is not empty.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 Makefile                       | 2 ++
 arch/arm/mach-mediatek/Kconfig | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b32606b69f5..2afc172d42e 100644
--- a/Makefile
+++ b/Makefile
@@ -1019,8 +1019,10 @@ INPUTS-$(CONFIG_EFI_STUB) += u-boot-payload.efi
 
 # Generate this input file for binman
 ifeq ($(CONFIG_SPL),)
+ifneq ($(patsubst "%",%,$(CONFIG_MTK_BROM_HEADER_INFO)),)
 INPUTS-$(CONFIG_ARCH_MEDIATEK) += u-boot-mtk.bin
 endif
+endif
 
 # Add optional build target if defined in board/cpu/soc headers
 ifneq ($(CONFIG_BUILD_TARGET),)
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 39eea055f70..673ceb1a093 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -160,9 +160,8 @@ config SYS_CONFIG_NAME
 
 config MTK_BROM_HEADER_INFO
 	string
-	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629 || TARGET_MT7622
+	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183
-	default "media=snand;nandinfo=2k+64" if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
-- 
2.34.1

