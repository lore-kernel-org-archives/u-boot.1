Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A53CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2DA83164;
	Mon,  8 Sep 2025 10:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="DfPjA3xE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE2D800B6; Mon,  8 Sep 2025 10:34:33 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B812E8313F
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a13d508c8c8e11f0bd5779446731db89-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=a8WZ0aCOpqUNc1BuwElj28kc6JKw2EyY4YdKhGMSuVE=; 
 b=DfPjA3xEA8kz9hgD1WFC5pc2Xibo8FIMUlILO2RrGKYRXAlOlEXVyt4qHk4Uw8TNwmHgU/5nGMGrWQlaCMdeeoO8Ah1YnUbOMwcwaJeTCnuAq1F5Y3XUcaamu30CK0DM51gKeLnU51zQGpH7Jqd9A/kYoX2+G8t+VeTeCo3mi6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:ff9f5f94-86ca-40a1-9e0e-3fac26d1b681, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:a1b40ff8-ebfe-43c9-88c9-80cb93f22ca4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a13d508c8c8e11f0bd5779446731db89-20250908
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 253053138; Mon, 08 Sep 2025 16:34:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 16:34:24 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 16:34:24 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 5/5] MAINTAINERS: update ethernet-related file list for
 MediaTek ARM platform
Date: Mon, 8 Sep 2025 16:34:23 +0800
Message-ID: <30e11274cc7cdd5e45a924a4b9880c17c817e87b.1757315849.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1757315849.git.weijie.gao@mediatek.com>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
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
Changes in v4: none
Changes in v3: none
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

