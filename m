Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F0C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF84889D2;
	Wed, 31 Jul 2024 16:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dm6ZQiWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AA5889AE; Wed, 31 Jul 2024 16:59:14 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE81889D5
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VEx00t072941;
 Wed, 31 Jul 2024 09:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722437941;
 bh=TKoPDnaC5FmWT1ZeZ0BOG+F9Awe1rwVPBh0HeLV8Pvo=;
 h=From:To:CC:Subject:Date;
 b=Dm6ZQiWe4vI/eU+wp7izJoyiy7LHt4qIdg8V+G5a8MltuOlVFD5fLB/bwHHHWeo5P
 t8gv9jgcYUWWUE2JGiIF30VyvNd6JfxnuKj+fhG3gyHAm1HqmJHECrMEj2BuBkfwIM
 X4+a4MC4h5t+Sq186JkqdSMY+z2KMTt15lXEW0PU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VEx0gJ006272
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jul 2024 09:59:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 09:59:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 09:59:00 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VEwvnI044345; 
 Wed, 31 Jul 2024 09:58:58 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
CC: Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 William Zhang <william.zhang@broadcom.com>, Sean Anderson
 <seanga2@gmail.com>, <u-boot@lists.denx.de>, <s-k6@ti.com>
Subject: [PATCH] mtd: nand: raw: omap_gpmc: Check return value of
 gpmc_nand_init
Date: Wed, 31 Jul 2024 20:28:55 +0530
Message-ID: <20240731145855.3122166-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.45.2
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

If the function is called with no NAND device attached, then this
function can return error value, proceeding further ignoring the same
can cause system crash. This is seen when "mtd list" is run with no NAND
addon cards connected.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/nand/raw/omap_gpmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 92a92ad63a02..a36e2a148ccc 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -1188,7 +1188,10 @@ static int gpmc_nand_probe(struct udevice *dev)
 		return ret;
 
 	base = devm_ioremap(dev, res.start, resource_size(&res));
-	gpmc_nand_init(nand, base);
+	ret = gpmc_nand_init(nand, base);
+	if (ret)
+		return ret;
+
 	mtd->dev = dev;
 	nand_set_flash_node(nand, dev_ofnode(dev));
 
-- 
2.45.2

