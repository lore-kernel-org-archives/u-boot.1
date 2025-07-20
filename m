Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A8C83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 19:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89DB82F14;
	Sun, 20 Jul 2025 21:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="woCEUQAw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XHZ22O5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7226882F14; Sun, 20 Jul 2025 21:59:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BEDD82DA1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 21:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4blZ9f4FXvz9tL1;
 Sun, 20 Jul 2025 21:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAjy+p9b9C6aoPO7vnfGYyqkJQ5c886pQJM0NAHNKcY=;
 b=woCEUQAwcUztXThRRuygeMEhvDM7c5e2D2jDCnx0zQ65FhFDtFgYmX2UMlq4fnJ0f1kxGu
 NlWfLIuYU4oITZUYY45HrxTSPvYDiv5Ep0XdxB/lRurBdZ1EGMWC5oqPSqtpA1bj2Hi81z
 3S5PG/znasEySC0aHa9iIP79qqIYqD/GBU3NyVKPMI5zkCkPCC36yFInzxb8PQzMf5shFu
 HHCadu/0hc6Uniz3GG4gw+cFItaczuVIV+lb6sHCkfQroNj6bznU5hwJEymWfJm+QDbF6/
 RmtUfMIsQUJUCG977H5I5gzq95wpflEGMY24Hke4A4Wnldr3psd4cPzk8R5e6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAjy+p9b9C6aoPO7vnfGYyqkJQ5c886pQJM0NAHNKcY=;
 b=XHZ22O5+uDBldOceImYlxlPieyqnE4akYQYys2TaKyC/9Xt2c/zYDV9VKtJZmfzbGl5K11
 xbw9wgg6LwI+RtTZ/UBLyShZQ3vSDAHAUVQ2m2as5djxjDAmn6NMQcSQVeTPW+QmWmN3ZN
 rExgEpqPWHu5OpgyaV7107uTSocjBX+tuEqa3lHiDfFwkv+nb/pFTtbi73P62qScW1+CAB
 JoM7Qobmv91Z82uvnVhat8we7LOz2jcU1VDNSQ5iDdtmkDV3iSmPERReRv9e4aUyq3De24
 rX0YfsrPWRNyr+wdunO3fL85kWXXPOQH8HOf0ssq7uBwA9WPrw0wt6rrm0E0NA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
Date: Sun, 20 Jul 2025 21:58:47 +0200
Message-ID: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db20c38ca103b34bff1
X-MBO-RS-META: 1qi9cbdsktgggj8qj5gyzunfrpf35uyh
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

Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
flash part is similar to W25Q512NWM .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7e97780d7c..0383175beb5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-- 
2.47.2

