Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A10CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 21:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A72838BB;
	Thu, 11 Jun 2026 23:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="SshWLHLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4CD8407D; Thu, 11 Jun 2026 23:58:18 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA788056B
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 23:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76D00117AF9; Thu, 11 Jun 2026 23:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781215093; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=sJddFEAMVHjovplT98tUUdIWsHS8bSVpvAMdB307r8U=;
 b=SshWLHLvU2gZkZTS76S8AUeRqvfyWj2aPp0qYuwnEdat4e3qCojto3LmHp4ZPSkPS3yZ2v
 e8BdGCjpt15dbpUhr/cPR2oDfHUDzNId9HOYXzb1D1qoiBzjP5fW+6+RnF9jCQa5RLoQ3b
 09s6I8hDCqvYiAxXzi0KZmmZux1XAlwXxzgajcmZiAYPjni211vG9uafcbUwXGEfrohvFL
 VvLEg+/6G25rt7bo9MI/+9nxAt6CLJkh4+zqUZE1uzmDson69+CpggPou7R/9dFBInvXE7
 clsIMIGPIncuc92/xGBE26YTGa/fRjM9Z2cFgdaijovfJayZ6rvjUaHkAAMJmg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
Date: Thu, 11 Jun 2026 23:57:47 +0200
Message-ID: <20260611215808.177934-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Alexander Koch <akoch@initse.com>

Add IDs for GigaDevice GD25LQ16 SPI NOR.

Signed-off-by: Alexander Koch <akoch@initse.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Koch <akoch@initse.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/spi/spi-nor-ids.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..d3a24b51daf 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -117,6 +117,11 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("gd25lq16", 0xc86015, 0, 64 * 1024, 32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{
 		INFO("gd25q32", 0xc84016, 0, 64 * 1024,  64,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-- 
2.53.0

