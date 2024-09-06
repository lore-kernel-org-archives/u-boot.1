Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02126E6FE48
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 21:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAD988D4F;
	Fri,  6 Sep 2024 23:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725657039;
	bh=UG0Z67STPmJ/pfNVqZ5sO7bt3gkZ9PoNve3T5LxZKlk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PUgjgARm+LSaEkidxxxjjL6ZcKq7+UGniytOYShkJZ1SSefj2tPjXSdUiE8wJAa4A
	 D3LxlbbQ3y3zGeBh4/hErstixcg9pHjP7Qlor/OKypbd/2jW4ccomd6qDR3SElD9BY
	 bCZH5FFggMJl1MweqLqSerBAgedItteWL2o8WDmetKuXyxCPiGzg+QEUpVftrLBC9m
	 8Jo8VH47HnCPc6Fszekul01e+Rpn/Msa5kT94LwRw0KzlS3AJKDIa04ESWtaTpvN5p
	 Ad4O5LyWx/OzJBvKxTziAnwcavDG7Gh7GG7pzP+n/LnlCOOZcaE30LOsSpUWaobnJe
	 2XYSdtQxIlplQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E211D88CD8;
 Fri,  6 Sep 2024 23:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725657038;
 bh=UG0Z67STPmJ/pfNVqZ5sO7bt3gkZ9PoNve3T5LxZKlk=;
 h=From:To:Cc:Subject:Date:From;
 b=XTV6Qv+a8M0FYTnTjsrhq2R361jnAB33Pz0fjDu7gWETlppV9fi34yO2oMMK3QiaP
 EfU5XOLDpqGWHTd0lA4KNHoEgSk5PTwLUtwyUKfMAx0aKTMPzKLHeHQIgYkLIMGyI3
 l5e5oTW+f4iBOCCcSCYYOChiOECTdScWZ9DGTDsO+QON1hZQrCfEsT2tl0sQGZUAOK
 QMlkFDzevm97VQeJwWXWcWJ4xekpoz+64sCChljuJsbsuUwB5E8gU1w7khqJzW5LMr
 SJE+KzFCazbDVXnl4DaUnxQUw7NRv3FZHxwAGiunzccjV2CjCkwCRBuPzIBXQO1M5Q
 1Qw1GZIWbrE8A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor-ids: Deduplicate mx25u25635f entry
Date: Fri,  6 Sep 2024 23:10:10 +0200
Message-ID: <20240906211022.193224-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The mx25u25635f entry exists twice in spi_nor_ids, remove the less
complete variant of the entry and keep only one copy of it.

Fixes: f0084f1dfdbc ("drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f support")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jim Liu <jim.t90615@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neal Frager <neal.frager@amd.com>
Cc: Prasad Kummari <prasad.kummari@amd.com>
Cc: Teik Heng Chong <teik.heng.chong@intel.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/spi/spi-nor-ids.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index d1389e681d6..5582a978ab5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -258,7 +258,6 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
 	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
 	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
-	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K) },
 	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
 	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
-- 
2.45.2

