Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB47C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 09:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3BD83211;
	Fri, 23 May 2025 11:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ektLydWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6774882E26; Fri, 23 May 2025 11:26:07 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4126B83208
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f11fbba237b711f0813e4fe1310efc19-20250523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=uitLw8RStHkSXS8CG90+jLHNwq6V5/gofry8eWb8UTE=; 
 b=ektLydWCGUAjomiKyWPZ5snpdgs6vzfayo07C5tVzjPJE+SW5hGmqPm+/B2b0mR0D9HVCQcoFcDSf2P8zRLAaYnYyadHpMKuxozJTqQEWbUYASKZwtevB/5n44R6XYm26ntQnvtaAd7SrfDme9xzU7fPx8vD9h3DrgTlrpYKpfo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:2e934599-ab42-450c-8538-5564353872af, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:f375a647-ee4f-4716-aedb-66601021a588,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f11fbba237b711f0813e4fe1310efc19-20250523
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 402297936; Fri, 23 May 2025 17:26:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 23 May 2025 17:25:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 23 May 2025 17:25:58 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 1/2] serial: mediatek: fix register names and offsets
Date: Fri, 23 May 2025 17:25:55 +0800
Message-ID: <f25ea8eb796984a6226d482f5529c96c16a5813a.1747991898.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1747991898.git.weijie.gao@mediatek.com>
References: <cover.1747991898.git.weijie.gao@mediatek.com>
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

Fix UART register names and offsets according to the programming
guide to allow implementing some enhanced features.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/serial/serial_mtk.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index becf9317076..9d379f2e899 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -30,16 +30,23 @@ struct mtk_serial_regs {
 	u32 mcr;
 	u32 lsr;
 	u32 msr;
-	u32 spr;
-	u32 mdr1;
+	u32 scr;
+	u32 autobaud_en;
 	u32 highspeed;
 	u32 sample_count;
 	u32 sample_point;
+	u32 autobaud_reg;
+	u32 ratefix_ad;
+	u32 autobaud_sample;
+	u32 guard;
+	u32 escape_dat;
+	u32 escape_en;
+	u32 sleep_en;
+	u32 dma_en;
+	u32 rxtri_ad;
 	u32 fracdiv_l;
 	u32 fracdiv_m;
-	u32 escape_en;
-	u32 guard;
-	u32 rx_sel;
+	u32 fcr_rd;
 };
 
 #define thr rbr
-- 
2.34.1

