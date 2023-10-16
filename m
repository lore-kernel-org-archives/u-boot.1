Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C74CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379B186823;
	Mon, 16 Oct 2023 18:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c4/DQXKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C915E86940; Mon, 16 Oct 2023 18:06:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2044186D4A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6GoR098625;
 Mon, 16 Oct 2023 11:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697472376;
 bh=ilyBtfB0v8HuE5YspirV96XbI2s3VuiTUJs0PzvHBe0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=c4/DQXKRkCxEI7l7Uk5B8f0MNQzWfBnyNviU1IAik1KZ4zxPtdM2UimrWAmonDjEW
 7MlJf/J52HepY1t/+/RGR4331fqDof6tUKkJ3JLPVrQSxjjHrvFH5Uf1A1B+Snizaw
 3aPwEp5y1lywlYp8/1NkvoWHqK91SxJOEBufVMck=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GG6Ful079278
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:06:15 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:06:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:06:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6EYZ014897;
 Mon, 16 Oct 2023 11:06:15 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
Subject: [RFC PATCH 2/5] board: ti: am62x: evm: Remove video_setup from
 spl_board_init
Date: Mon, 16 Oct 2023 21:36:08 +0530
Message-ID: <20231016160611.1353458-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160611.1353458-1-devarsht@ti.com>
References: <20231016160611.1353458-1-devarsht@ti.com>
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

Remove video_setup from evm_init sequence since it is now
getting called at an earlier place now to make sure
video memory is reserved at the end of RAM.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
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

