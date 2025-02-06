Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0559BC02192
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 02:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4738033D;
	Thu,  6 Feb 2025 03:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mHkGWsBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9961980104; Thu,  6 Feb 2025 03:19:19 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E06A80104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 03:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: be1b5df4e43011efbd192953cf12861f-20250206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=AGVpwGBJLJqxbsNq6VbgC93oIrDfAIgh9M7b7A+P7Ck=; 
 b=mHkGWsBRQ2c1prefmki2cYaAZuIOzmfrY/Ne+b0fpgF7wN3+vljDentLcihWsjFM1UJv1/cx97oS110YHPItNgiPdSYoxGSJHIkvEFpH9AxXIpoRGN+Plq4d+Dr1CjGJ2D1rqYlN1v0s6HA/jI5rw6EfcQelmvGmFn8gQFPhxWw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:8b67f076-c5f8-4070-9042-1445bfb5db95, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:dc1d37ff-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be1b5df4e43011efbd192953cf12861f-20250206
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1417894362; Thu, 06 Feb 2025 10:19:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Feb 2025 10:19:05 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Feb 2025 10:19:05 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH 1/2] pinctrl: mediatek: mt7988: remove _base from reg-names
Date: Thu, 6 Feb 2025 10:18:57 +0800
Message-ID: <0c4eec2ca1691384863959e70f5451f76cbb963b.1738808158.git.weijie.gao@mediatek.com>
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

The reg-names in mt7988.dtsi have no _base suffix. Remove the suffix
will also make it match upstream linux format.

Fixes: 8c2cb748ef5 (pinctrl: mediatek: mt7988: rename reg-names to upstream linux format)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7988.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7988.c b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
index 1f384e86f4e..639e2415c63 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7988.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
@@ -1233,8 +1233,7 @@ static const struct mtk_function_desc mt7988_functions[] = {
 };
 
 static const char *const mt7988_pinctrl_register_base_names[] = {
-	"gpio_base", "iocfg_tr_base", "iocfg_br_base", "iocfg_rb_base",
-	"iocfg_lb_base", "iocfg_tl_base",
+	"gpio", "iocfg_tr", "iocfg_br", "iocfg_rb", "iocfg_lb", "iocfg_tl",
 };
 
 static const struct mtk_pinctrl_soc mt7988_data = {
-- 
2.34.1

