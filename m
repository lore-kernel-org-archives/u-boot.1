Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6943FC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0325F87724;
	Fri,  3 Nov 2023 01:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JO1SPgMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9A9876D2; Fri,  3 Nov 2023 01:38:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B622686FCD
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c9Ss003495;
 Thu, 2 Nov 2023 19:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971889;
 bh=llbbJ6V5KeCcvwBxTspfPcN7Hh6WIzG5DFo2TRTX2XI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JO1SPgMighigjBRq3sXiyg+e/g4jUZxvwjcwZWHzLeE2fgLMQXIH9dQGDiagPj/Fn
 6USRHLzn8cH7YJ+O5H+fQieK6qo/cc49ZXu4LWv3hRdzkBQCvxDspZu1Z8MolakjGj
 DJ/ubJxBECCnCDdbxvsSMvO/PNYbsvsyaA6OoKAM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30c9aA124940
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c83O030049;
 Thu, 2 Nov 2023 19:38:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 07/15] board: ti: j721e: evm: Use IS_ENABLED with
 CONFIG_PHYS_64BIT
Date: Thu, 2 Nov 2023 19:37:57 -0500
Message-ID: <20231103003805.2420005-8-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
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

Use IS_ENABLED to replace the #ifdeffery.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/evm.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index d49993fffe39..0fc141776818 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -39,22 +39,19 @@ int board_init(void)
 
 int dram_init(void)
 {
-#ifdef CONFIG_PHYS_64BIT
-	gd->ram_size = 0x100000000;
-#else
-	gd->ram_size = 0x80000000;
-#endif
+	if (IS_ENABLED(CONFIG_PHYS_64BIT))
+		gd->ram_size = 0x100000000;
+	else
+		gd->ram_size = 0x80000000;
 
 	return 0;
 }
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-#ifdef CONFIG_PHYS_64BIT
 	/* Limit RAM used by U-Boot to the DDR low region */
-	if (gd->ram_top > 0x100000000)
+	if (IS_ENABLED(CONFIG_PHYS_64BIT) && gd->ram_top > 0x100000000)
 		return 0x100000000;
-#endif
 
 	return gd->ram_top;
 }
@@ -66,12 +63,12 @@ int dram_init_banksize(void)
 	gd->bd->bi_dram[0].size = 0x80000000;
 	gd->ram_size = 0x80000000;
 
-#ifdef CONFIG_PHYS_64BIT
-	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
-	gd->bd->bi_dram[1].size = 0x80000000;
-	gd->ram_size = 0x100000000;
-#endif
+	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
+		/* Bank 1 declares the memory available in the DDR high region */
+		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+		gd->bd->bi_dram[1].size = 0x80000000;
+		gd->ram_size = 0x100000000;
+	}
 
 	return 0;
 }
-- 
2.40.0

