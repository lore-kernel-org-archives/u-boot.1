Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4390CC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D748069D;
	Fri, 17 Jan 2025 10:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="hC06dp2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B0780312; Fri, 17 Jan 2025 10:19:11 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0CE806FB
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 172f32a8d4b411ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=bR+n4t5k51/zgovnCSqsnJ6cfZzxVpAIL1vUVjABZWA=; 
 b=hC06dp2WDjbVDPfTs9dSoTniVCe+oWEeFXGKvlCHUOTbGzvSjimQi8GqyVsyXZxMqdfDYMekee4hF52Bb32MYr43vyg8akz8Af2Pvhp+L5tnMboCUs+CJwLftZ1jxX+EqNFHrb2QRk4QZwLZgFhf3aObfr2ioHRACqd2kt5PQZg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:d7a1e3d3-f72a-4158-bdf4-051fbe44703f, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:cb410d0f-078a-483b-8929-714244d25c49,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 172f32a8d4b411ef99858b75a2457dd9-20250117
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1276045746; Fri, 17 Jan 2025 17:19:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:19:00 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:19:00 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 15/15] MAINTAINERS: update file list for MediaTek ARM platform
Date: Fri, 17 Jan 2025 17:18:59 +0800
Message-ID: <dbedf80c5e5860e7e821fef2d997a15cfd88f9bd.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
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

Add driver files for MediaTek ARM platform

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6..c8f5a35b003 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -412,9 +412,13 @@ F:	drivers/mmc/mtk-sd.c
 F:	drivers/phy/phy-mtk-*
 F:	drivers/pinctrl/mediatek/
 F:	drivers/power/domain/mtk-power-domain.c
+F:	drivers/pci/pcie_mediatek_gen3.c
+F:	drivers/pci/pcie_mediatek.c
+F:	drivers/pwm/pwm-mtk.c
 F:	drivers/ram/mediatek/
 F:	drivers/spi/mtk_snfi_spi.c
 F:	drivers/spi/mtk_spim.c
+F:	drivers/spi/mtk_snor.c
 F:	drivers/timer/mtk_timer.c
 F:	drivers/usb/host/xhci-mtk.c
 F:	drivers/usb/mtu3/
@@ -422,6 +426,7 @@ F:	drivers/watchdog/mtk_wdt.c
 F:	drivers/net/mtk_eth.c
 F:	drivers/net/mtk_eth.h
 F:	drivers/reset/reset-mediatek.c
+F:	drivers/serial/serial_mtk.c
 F:	include/dt-bindings/clock/mediatek,*
 F:	include/dt-bindings/power/mediatek,*
 F:	tools/mtk_image.c
-- 
2.34.1

