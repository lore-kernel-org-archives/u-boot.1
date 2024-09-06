Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F023E6FE49
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 21:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE1A88D5A;
	Fri,  6 Sep 2024 23:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725657077;
	bh=liUhaq4bvKy89VT9CsBASqvxijhJLuenpmS5b1tG8U0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MH9G8xYPM0pA8XQmqgd7mD8iX7eqsjFkmKXAhmu73J1+pArwYIaq4/AirNGtdVk5p
	 u2TxvVpI/aW0Ay3jjtTHY9htZn3/qG+Glb/Bedr2xS3Z9GQdOp7Ms9DmLa8kb5Jin1
	 PgeSHP51PFHGxpEFOzGpA3Kl7BcfQXXWAqE1PYCKLnwRYUFnzEQHqN1kHyiwRoHwoy
	 YrfVzbcMu86L/pWlWYjHx6OukDK/ZCCeWN20b51Sy/IXe5OCP/MnKW6zYDeyBJiq3r
	 OdQ9dVmiQlBwHnZB33uOBTvSU9qmvxbJb2oHdQiXapMMZM7nOUQvU/ae45L9OYwxQ8
	 qOCJBWgV3lI0Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F32EB88D4E;
 Fri,  6 Sep 2024 23:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725657077;
 bh=liUhaq4bvKy89VT9CsBASqvxijhJLuenpmS5b1tG8U0=;
 h=From:To:Cc:Subject:Date:From;
 b=CDgY+a4rDtyN7pYi11pvyytF2R8hWZwkna+1sDIbjhZDA9+nV2TrP/ujvUy83TDBN
 dQs6+cG5ROWwpIuFHHdiaGEuRmDGZpHnrQ/BsaXmYtC4sx3GpeRYeWaysogZhUnDfR
 JY1Txyyb2POAEnf0FZ8KnUYpB+PoCzxTGdNkQXQNmg56aviGCsXdKCeDGpDsWSeAIE
 9hExAo0zeW9tS8XlMVJnNLkig8JJhu60bUhTAZ84qB6FwLr2h00iWi5cLHFzcVYjdm
 Nnt/MAWZTKAOYyfqwonrEcTCFeN2/mBX3GJUkiyOE39tFHps7bZee7jUUEeXnbJ3+K
 Tt6sYKt0egpYA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor-ids: Extend w25q16cl entry with locking support
Date: Fri,  6 Sep 2024 23:10:42 +0200
Message-ID: <20240906211105.193254-1-marex@denx.de>
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

The w25q16cl does support locking the same way w25q16dw does,
fill in the missing flags.

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
 drivers/mtd/spi/spi-nor-ids.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 5582a978ab5..30cff8afdbd 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -536,7 +536,11 @@ const struct flash_info spi_nor_ids[] = {
 	},
 	{ INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w25q16cl", 0xef4015, 0, 64 * 1024,  32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{
+		INFO("w25q16cl", 0xef4015, 0, 64 * 1024,  32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{ INFO("w25q32bv", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q64cv", 0xef4017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q128", 0xef4018, 0, 64 * 1024, 256,
-- 
2.45.2

