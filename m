Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF3C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 09:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E43807F1;
	Thu, 13 Feb 2025 10:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="IWE3vw6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A2280A55; Thu, 13 Feb 2025 10:11:29 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39601801DE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7e279c70e9ea11efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=d5lFZjzduFhKUrhkfrqDWjoAdo2Lgs8nXWs4SBapxfU=; 
 b=IWE3vw6h09R3B+kRSir6+xmsMOyXf24H+azXqHjQuVXoZs92K5vtlCAk6dJ4sSnN6ecsV83Zf7umGH8zvJB3OkELewqOwQaHFuMAoEDWKfkurJG1WgvRkM4VwE/AnxnEQrg0C0G3bjk3/B1sNTIpXaUEi/W/7raCgUUlhDenaiM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:7bdad2a3-0c78-4495-add0-19e6e31df6f0, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:753f8327-6332-4494-ac76-ecdca2a41930,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e279c70e9ea11efbd192953cf12861f-20250213
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 143408630; Thu, 13 Feb 2025 17:11:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 17:11:20 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 17:11:20 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] arm: mediatek: remove CONFIG_MT8512
Date: Thu, 13 Feb 2025 17:11:18 +0800
Message-ID: <20250213091118.84284-1-weijie.gao@mediatek.com>
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

Defining CONFIG_MT8512 is unnecessary as now board for mediatek
target can be changed in config.
Use CONFIG_TARGET_MT8512 to replace CONFIG_MT8512.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig  | 6 +-----
 arch/arm/mach-mediatek/Makefile | 2 +-
 drivers/clk/mediatek/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 673ceb1a093..e54c456aec0 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -6,9 +6,6 @@ config SYS_SOC
 config SYS_VENDOR
 	default "mediatek"
 
-config MT8512
-	bool "MediaTek MT8512 SoC"
-
 choice
 	prompt "MediaTek board select"
 
@@ -96,9 +93,8 @@ config TARGET_MT8365
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
 
 config TARGET_MT8512
-        bool "MediaTek MT8512 M1 Board"
+        bool "MediaTek MT8512 SoC"
         select ARM64
-	select MT8512
         help
           The MediaTek MT8512 is a ARM64-based SoC with a dual-core Cortex-A53.
           including UART, SPI, USB2.0 and OTG, SD and MMC cards, NAND, PWM,
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 344434c6029..c11d6ad8aed 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,7 +4,6 @@ obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
-obj-$(CONFIG_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
 obj-$(CONFIG_TARGET_MT7629) += mt7629/
@@ -14,5 +13,6 @@ obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
+obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
 obj-$(CONFIG_TARGET_MT8518) += mt8518/
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e412c92cafc..12893687b68 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -3,7 +3,6 @@
 obj-$(CONFIG_ARCH_MEDIATEK) += clk-mtk.o
 
 # SoC Drivers
-obj-$(CONFIG_MT8512) += clk-mt8512.o
 obj-$(CONFIG_TARGET_MT7623) += clk-mt7623.o
 obj-$(CONFIG_TARGET_MT7622) += clk-mt7622.o
 obj-$(CONFIG_TARGET_MT7629) += clk-mt7629.o
@@ -13,5 +12,6 @@ obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
 obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
 obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
 obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
+obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
 obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
 obj-$(CONFIG_TARGET_MT8518) += clk-mt8518.o
-- 
2.34.1

