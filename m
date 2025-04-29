Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B567C369D5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 02:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6AE82145;
	Tue, 29 Apr 2025 04:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="aAj2PPdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763B982132; Tue, 29 Apr 2025 04:07:08 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B8B82132
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 04:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a19faf64249e11f09b6713c7f6bde12e-20250429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=HAS87nKj4k2B3TYJ+XXw4aYEO4VyomFinB5Ad17Uj3c=; 
 b=aAj2PPdA2nGi16oS1Wgsz9HAu3pyArttO7klD1oA8TiNB1b9DEOQx8HhojMyI/lJIsFHJ1QXZqxdI/6EiQZ9tDfYibzEo3/UHd2cK+dqhBl38qCBcf4aVqSF13sAAq7N279TQidXywVLwDRNyWna+UlmFE9zJHDSnKu0yHi1Frk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:17f8d723-5358-4bf4-9b71-04c31c986835, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:0ef645f, CLOUDID:649eb9f0-ff26-40e8-a637-f0e9524b171a,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a19faf64249e11f09b6713c7f6bde12e-20250429
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2098790161; Tue, 29 Apr 2025 10:06:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 29 Apr 2025 10:06:57 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 29 Apr 2025 10:06:56 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH] common: board: fix build condition of noncached memory
 initcall
Date: Tue, 29 Apr 2025 10:04:24 +0800
Message-ID: <20250429020424.48795-1-weijie.gao@mediatek.com>
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

CONFIG_SYS_NONCACHED_MEMORY is defined as hex, not bool. It should be
replaced with CONFIG_SYS_HAS_NONCACHED_MEMORY when switched from #ifdef to
CONFIG_IS_ENABLED().

Fixes: 6c171f7a184 (common: board: make initcalls static)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 common/board_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index bc6fd6448c2..b90a4d9ff69 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -639,7 +639,7 @@ static void initcall_run_r(void)
 #if CONFIG_IS_ENABLED(CONSOLE_RECORD)
 	INITCALL(console_record_init);
 #endif
-#if CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY)
+#if CONFIG_IS_ENABLED(SYS_HAS_NONCACHED_MEMORY)
 	INITCALL(noncached_init);
 #endif
 	INITCALL(initr_of_live);
-- 
2.34.1

