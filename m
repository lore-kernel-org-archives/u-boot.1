Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A7E6FE48
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 21:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9F588D51;
	Fri,  6 Sep 2024 23:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725657006;
	bh=MVAxerUvirdf2SBTYfonj2pNlo4PPGO1VpNWSJGKTBY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uxdIYzBLKdy8t62mZAoXjq2PtMcuaF+kyeek1afUPIUi7wxDeLZeC7yYjgxHe1OUU
	 sUXsi6SDDzltEpkG6mCW75bUOfl3Y54B+K5ecDIZ2dJHwSeGxi9m3jn/vrZekFrznM
	 xrMNE0wGVzSP+si8Muedr4ewUKpQvmdubvMZp57JDUbZKZfmJS4r3jWr7rQnqkpaec
	 qdKzaV2NXXIjfUkp7dJob6Vr//BdN862F1c/u5NyHu67pqfkv3rqWr6hbkWfj8LD4l
	 4p15JzIt1hx/lBQrVUFDFwFFXJFlYMUu3B6z3yiwr5323R7f7ki8op0x5NfzmVqZ4n
	 yuUvolZgeLSoA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7585588D4E;
 Fri,  6 Sep 2024 23:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725657005;
 bh=MVAxerUvirdf2SBTYfonj2pNlo4PPGO1VpNWSJGKTBY=;
 h=From:To:Cc:Subject:Date:From;
 b=r/jBlQ/+tgGlATGa1ju3Mim8xqkW4X8XltxlJG7vDmmOm7Jsr5aClkw7AtG3SNQxa
 qShcYVkBBl8BI1JAzoT+Gy+yfp0xW/htQilBCJ04G12jIpQxuNZCLPXDieKKGx8gIL
 wEr8uHhspE/Q5r1JsEAU7pbVE+3spEBsiwJa9A6T2yCIgvdcp3I9pSLKdlXWcQTrmB
 1wWfyJiemgU9Bf52tLGi9DhfpFM+xZipG6jwDpdG8mWaK299FIitmzmzjAL13W/FXT
 ez0ElWUnIHUQtCRg8hnmPU2p4ID1aS032CgWCEcdzYikcrQ/Pv0d2UcHGrKWz+n8P+
 drVOuB9SvFajg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor-ids: Deduplicate w25q16dw entry
Date: Fri,  6 Sep 2024 23:09:16 +0200
Message-ID: <20240906210951.193142-1-marex@denx.de>
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

The w25q16dw entry exists twice in spi_nor_ids, remove the less
complete variant of the entry and keep only one copy of it.

Fixes: baef13ec9d59 ("mtd: spi-nor-ids: Add support for flashes tested by xilinx")
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
 drivers/mtd/spi/spi-nor-ids.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 88709a52b3a..d1389e681d6 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -430,11 +430,6 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25x05", 0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
 	{ INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
 	{ INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K) },
-	{
-		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
 	{ INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K) },
 	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
 	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
@@ -442,7 +437,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{
 		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
 	{
 		INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64,
-- 
2.45.2

