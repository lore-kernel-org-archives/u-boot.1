Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C6CC83F1D
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 03:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCDD8211F;
	Mon, 14 Jul 2025 05:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lnAdERTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CAE829E7; Mon, 14 Jul 2025 05:03:48 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD67481FEE
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 05:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 20094df0605f11f0b33aeb1e7f16c2b6-20250714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=aI4PHYf8O8LmgsQq+T33dtkUUAhWIo3a/zvg7JAyRoY=; 
 b=lnAdERTbL2T1yyJ5ZLrdjLHfgl1nvaNDvzlBrSvkVoDhXnuYsy+cztzvLe/p2xDxnuWQpoCI593WUBpp1ANuftIjAeAvTg1Og8scSgJP8cDcFAOrAcU5mv8kX94izb5L7LK/Va9TViknSwUS2+nWnjrBqV0saaDETHPPBcbcicY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2, REQID:ee1d4329-9715-47b6-b71f-7e7566bea2aa, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:9eb4ff7, CLOUDID:c14f2ad8-b768-4ffb-8a44-cd8427608ba6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 20094df0605f11f0b33aeb1e7f16c2b6-20250714
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1872745738; Mon, 14 Jul 2025 11:03:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Jul 2025 11:03:30 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Jul 2025 11:03:29 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] binman: include <CONFIG_SYS_BOARD>-u-boot.dtsi if exists
Date: Mon, 14 Jul 2025 11:03:27 +0800
Message-ID: <20250714030327.132114-1-weijie.gao@mediatek.com>
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

This patch makes it possible to automatically include board-specific
additions to the device tree.

Change-Id: If8cacca58696969fbdd3ede6457d8526b05ebe4f
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 doc/develop/devicetree/control.rst | 1 +
 scripts/Makefile.lib               | 2 ++
 tools/binman/binman.rst            | 1 +
 3 files changed, 4 insertions(+)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..ffe6860fe6c 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -210,6 +210,7 @@ order::
    <CONFIG_SYS_SOC>-u-boot.dtsi
    <CONFIG_SYS_CPU>-u-boot.dtsi
    <CONFIG_SYS_VENDOR>-u-boot.dtsi
+   <CONFIG_SYS_BOARD>-u-boot.dtsi
    u-boot.dtsi
 
 Only one of these is selected but of course you can #include another one within
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..c8fe43e528d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -201,6 +201,7 @@ u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_BOARD))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
@@ -208,6 +209,7 @@ u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_BOARD))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)u-boot.dtsi ... \
 	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
 
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 392e507d449..36e7af80aa2 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1207,6 +1207,7 @@ Binman will search for the following files in arch/<arch>/dts::
    <CONFIG_SYS_SOC>-u-boot.dtsi
    <CONFIG_SYS_CPU>-u-boot.dtsi
    <CONFIG_SYS_VENDOR>-u-boot.dtsi
+   <CONFIG_SYS_BOARD>-u-boot.dtsi
    u-boot.dtsi
 
 U-Boot will only use the first one that it finds. If you need to include a
-- 
2.34.1

