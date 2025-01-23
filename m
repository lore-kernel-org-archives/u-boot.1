Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155CEC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5D3807E9;
	Thu, 23 Jan 2025 13:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FSARefmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1AE80780; Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20A280711
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39A72148A1E2; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h29FSw4cLBsZrbmONKPmNdhxgXS41fN9jDWB2hALiSU=;
 b=FSARefmBskSz1+38MBmYe2MaugssiPjekZK/GhF1Fjtjcea+gr24eXOtzUqF6KMMuPwqT+
 bCzUFZOSV0WZL3n03nAMTQXy134tddt7CMvX1nDhg8Xng2IYIFul/5zQf8oj5JJjBKVyCD
 vyxjtwCPrBFzIh0gdc2U4kivNdNs6jdMFzHALkHmp47BjOzjftSWsBXDSxnbu8XSUjj3GD
 g+RjU8O4vT9dLJy1OS6LZkNszVCTb2ncAn0MGubTxic63NxnRouImjQ4QH0dNGgGUTOBym
 TtE9+avVFZ6e1WnXmx1GlsHzcTHRL2c1tXKD4Xkz/JASbyk4DU3kBsnFv/TXvw==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de, Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: [PATCH 2/7] spi: atmel-quadspi: Port collected fixes from Linux v5.10
 and v5.15
Date: Thu, 23 Jan 2025 13:12:10 +0100
Message-Id: <20250123121215.21001-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123121215.21001-1-ada@thorsis.com>
References: <20250123121215.21001-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Port changes from a 4 piece patch series from Linux kernel v5.10, merged
with v5.10-rc1-83-gc732b7567d869 ("Merge series "spi: atmel-quadspi: Fix
AHB memory accesses" from Tudor Ambarus …").

Port the single fix v5.15-rc1-14-g09134c5322df9 ("spi: Fixed division by
zero warning").

Reduces differences between linux and u-boot driver.

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3efb661803b..ea045acab65 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -474,7 +474,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 		return mode;
 	ifr |= atmel_qspi_modes[mode].config;
 
-	if (op->dummy.buswidth && op->dummy.nbytes)
+	if (op->dummy.nbytes)
 		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
 
 	/*
@@ -529,10 +529,14 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	if (dummy_cycles)
 		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
 
-	/* Set data enable */
-	if (op->data.nbytes)
+	/* Set data enable and data transfer type. */
+	if (op->data.nbytes) {
 		ifr |= QSPI_IFR_DATAEN;
 
+		if (op->addr.nbytes)
+			ifr |= QSPI_IFR_TFRTYP_MEM;
+	}
+
 	/*
 	 * If the QSPI controller is set in regular SPI mode, set it in
 	 * Serial Memory Mode (SMM).
@@ -545,27 +549,24 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
 
-	if (aq->caps->has_ricr) {
-		if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
-			ifr |= QSPI_IFR_APBTFRTYP_READ;
-
-		/* Set QSPI Instruction Frame registers */
+	/* Set QSPI Instruction Frame registers. */
+	if (op->addr.nbytes && !op->data.nbytes)
 		atmel_qspi_write(iar, aq, QSPI_IAR);
+
+	if (aq->caps->has_ricr) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			atmel_qspi_write(icr, aq, QSPI_RICR);
 		else
 			atmel_qspi_write(icr, aq, QSPI_WICR);
-		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	} else {
-		if (op->data.dir == SPI_MEM_DATA_OUT)
+		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
-		/* Set QSPI Instruction Frame registers */
-		atmel_qspi_write(iar, aq, QSPI_IAR);
 		atmel_qspi_write(icr, aq, QSPI_ICR);
-		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	}
 
+	atmel_qspi_write(ifr, aq, QSPI_IFR);
+
 	return 0;
 }
 
-- 
2.39.5

