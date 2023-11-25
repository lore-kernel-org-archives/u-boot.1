Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD8CC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8542E8712E;
	Sat, 25 Nov 2023 17:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dHxi+Ml+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC0487243; Sat, 25 Nov 2023 17:27:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0739187483
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRAoU053086;
 Sat, 25 Nov 2023 10:27:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929630;
 bh=7PvWSMKeIBCkE0LluO/BRWa1IB+qdqwCKWTNxtblvNc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dHxi+Ml+0Kru7/zkNNvV/UIAp/vs2dg1GNJKBwAwdCzexVB6qcElMCRaB5gngC9qA
 SwBkRAmrXxEboVVtxp9/6+Rq4IEcuagGeZYVUDU8J8RqLja6mVlwFjFMHTm9LaKpRt
 xOftZca73jnSdvQ6iRr8Po0/+rQBKb/qAr0Fi9Go=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRAa8031294
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:10 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:10 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGR9Pq008992;
 Sat, 25 Nov 2023 10:27:10 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 3/8] board: ti: am62x: evm: Remove video_setup from
 spl_board_init
Date: Sat, 25 Nov 2023 21:57:00 +0530
Message-ID: <20231125162705.1383401-4-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Remove video_setup from evm_init sequence since video memory is getting
called at an earlier place to make sure video memory is reserved at
the end of RAM.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V2: No change
V3: No change
V4: Add Reviewed-by
---
 board/ti/am62x/evm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index ad93908840..88e02155ee 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -60,27 +60,9 @@ int dram_init_banksize(void)
 }
 
 #if defined(CONFIG_SPL_BUILD)
-static int video_setup(void)
-{
-	if (CONFIG_IS_ENABLED(VIDEO)) {
-		ulong addr;
-		int ret;
-
-		addr = gd->relocaddr;
-		ret = video_reserve(&addr);
-		if (ret)
-			return ret;
-		debug("Reserving %luk for video at: %08lx\n",
-		      ((unsigned long)gd->relocaddr - addr) >> 10, addr);
-		gd->relocaddr = addr;
-	}
-
-	return 0;
-}
 
 void spl_board_init(void)
 {
-	video_setup();
 	enable_caches();
 	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
 		splash_display();
-- 
2.34.1

