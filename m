Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC113C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCA883214;
	Wed, 27 Aug 2025 10:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="e8XX3PQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E4683252; Wed, 27 Aug 2025 10:56:21 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765FC8320C
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ae37b4ea832311f0bd5779446731db89-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=UV/Sqe8Nl5gl3aQALS78PyjmXvA/AvTv57DWjbLmtVw=; 
 b=e8XX3PQr6DOZrd1rHviznl/qblYiDPrXR6Ybv72+RPAg82o0N7QXnh8iwyZYlpc6BEB6EcVwB2Levsk7wvkzmbniXqISdMELFhf8YCHohi9beO1X8UuncRDQivvjC6kzLXGM3oiLh2rF1oDmxlMDPwLKZ+K9ka38CKfv28vywRM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:ab8da710-1e65-4aaa-b158-d4fbaf397ea8, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-30
X-CID-META: VersionHash:f1326cf, CLOUDID:8872eb44-18c5-4075-a135-4c0afe29f9d6,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ae37b4ea832311f0bd5779446731db89-20250827
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 936120592; Wed, 27 Aug 2025 16:56:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 16:56:01 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 16:56:01 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 4/4] MAINTAINERS: update ethernet-related file list for
 MediaTek ARM platform
Date: Wed, 27 Aug 2025 16:55:59 +0800
Message-ID: <bbf2bbe45f417c257ccff9061c4484ad22e304c8.1756283872.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1756283872.git.weijie.gao@mediatek.com>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
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

Update ethernet-related files for MediaTek ARM platform

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v2: none
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb163aa1db..065834246de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -423,6 +423,8 @@ F:	drivers/clk/mediatek/
 F:	drivers/cpu/mtk_cpu.c
 F:	drivers/i2c/mtk_i2c.c
 F:	drivers/mmc/mtk-sd.c
+F:	drivers/net/mtk_eth/
+F:	drivers/net/phy/mediatek/
 F:	drivers/phy/phy-mtk-*
 F:	drivers/pinctrl/mediatek/
 F:	drivers/power/domain/mtk-power-domain.c
@@ -437,8 +439,6 @@ F:	drivers/timer/mtk_timer.c
 F:	drivers/usb/host/xhci-mtk.c
 F:	drivers/usb/mtu3/
 F:	drivers/watchdog/mtk_wdt.c
-F:	drivers/net/mtk_eth.c
-F:	drivers/net/mtk_eth.h
 F:	drivers/reset/reset-mediatek.c
 F:	drivers/serial/serial_mtk.c
 F:	include/dt-bindings/clock/mediatek,*
-- 
2.34.1

