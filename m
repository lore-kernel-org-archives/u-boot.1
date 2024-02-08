Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D139C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 16:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F5387BE0;
	Thu,  8 Feb 2024 17:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="tAhcYTqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06ED87CFC; Thu,  8 Feb 2024 17:59:15 +0100 (CET)
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E89E87252
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 17:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D5E85BFB2E; Thu,  8 Feb 2024 17:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1707411552; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=pTXysrcFhesTgotRCo/QE70ff3B5CnfS6ob6VfiEzzo=;
 b=tAhcYTqLhUmh7ZEWsdtHOlM2q2/v17/vPcAaRdrNTvhrhMaf4+v3wB6L1eheGipzKkhJux
 2wMFQr4wLjU4ed6gNAd6yWIOHI7V0UNY9ii9fRtC6+YYVcEILF9PJRJiHuwTZ67k0kE+cw
 zCsPwU5DsJBKQLkoyv6kf5HX9JuiMXsLRVAy3i7bAo9CXhmh27uODNta0rPNasMp938nE5
 DnV7DQ61XZ6JZgAwivj4QWFYWT4yGnFzhGGZ4EHNUlalvo3xf+tXdta7W3eJNmC4VRVZZu
 45HlTHe0a2jTzo+yrF7MQx687u5Rf/IcrsA594sHkw8TnGpuzXljN82b8hqCDA==
From: Frieder Schrempf <frieder@fris.de>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Andre Przywara <andre.przywara@arm.com>, Bruce Suen <bruce_suen@163.com>,
 Jim Liu <jim.t90615@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
Date: Thu,  8 Feb 2024 17:58:41 +0100
Message-ID: <20240208165849.104787-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The datasheet can be found here:
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 38a287487ed..4e83b8c94c9 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -80,6 +80,7 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
+	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
 	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
 	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
 	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
-- 
2.43.0

