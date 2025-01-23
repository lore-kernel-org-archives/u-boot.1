Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D48C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93626807A8;
	Thu, 23 Jan 2025 13:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="sz7u8h5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC70980423; Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272D280763
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 751F6148A1E4; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xvg0OwH9yKewU0VNeELxsxKhGtuzmi3pBwwkV1sEX9I=;
 b=sz7u8h5TkSOq0iH4mGb75xKu6ot8CkdWwT56BedD1+vj5fah54wY9Z/UW+cGecm3oB8dYN
 u60tMoe42pjFKet9pcYzlV5tBpKd/a9pupZZdzP5Ik3fc+38oqExQsYt9fZL6B/mSFTDv1
 uLLXPvTI44LwI3SCsoBPGSZgsN1pSEQZT1rDgK6gkON4X19fBm+MN4BctWShlfR2044pJy
 DtYzbCiwaa3LWDcMsVIHxWykVUtJnwKI1JAl+braCApnaO69jgekYn4KHvLOG+ASPoN66l
 Tw9Yks9vqwW3jlFuRdcrY5hsPtiTW7Nr+Sxmptzb7hxsbAeBMIYcr9k3+7paTg==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: [PATCH 3/7] spi: atmel-quadspi: Avoid overwriting MR register settings
Date: Thu, 23 Jan 2025 13:12:11 +0100
Message-Id: <20250123121215.21001-4-ada@thorsis.com>
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

Port these commits:

- v6.11-rc5-90-g329ca3eed4a9a ("spi: atmel-quadspi: Avoid overwriting delay register settings")
- v6.12-rc1-1-g162d9b5d2308c ("spi: atmel-quadspi: Fix wrong register value written to MR").
- v6.13-rc2-27-gf663898d047a7 ("spi: atmel-quadspi: Factor out switching to Serial Memory Mode to function")

Cc: Csókás Bence <csokas.bence@prolan.hu>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 96 ++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ea045acab65..9e596b7448c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -395,6 +395,26 @@ static void atmel_qspi_write(u32 value, struct atmel_qspi *aq, u32 offset)
 	writel(value, aq->regs + offset);
 }
 
+static int atmel_qspi_reg_sync(struct atmel_qspi *aq)
+{
+	u32 val;
+
+	return readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				  !(val & QSPI_SR2_SYNCBSY),
+				  ATMEL_QSPI_SYNC_TIMEOUT);
+}
+
+static int atmel_qspi_update_config(struct atmel_qspi *aq)
+{
+	int ret;
+
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+	atmel_qspi_write(QSPI_CR_UPDCFG, aq, QSPI_CR);
+	return atmel_qspi_reg_sync(aq);
+}
+
 static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
 					    const struct atmel_qspi_mode *mode)
 {
@@ -458,6 +478,25 @@ static bool atmel_qspi_supports_op(struct spi_slave *slave,
 	return true;
 }
 
+/*
+ * If the QSPI controller is set in regular SPI mode, set it in
+ * Serial Memory Mode (SMM).
+ */
+static int atmel_qspi_set_serial_memory_mode(struct atmel_qspi *aq)
+{
+	int ret = 0;
+
+	if (!(aq->mr & QSPI_MR_SMM)) {
+		aq->mr |= QSPI_MR_SMM;
+		atmel_qspi_write(aq->mr, aq, QSPI_MR);
+
+		if (aq->caps->has_gclk)
+			ret = atmel_qspi_update_config(aq);
+	}
+
+	return ret;
+}
+
 static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			      const struct spi_mem_op *op, u32 *offset)
 {
@@ -537,14 +576,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
-	}
+	mode = atmel_qspi_set_serial_memory_mode(aq);
+	if (mode < 0)
+		return mode;
 
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
@@ -598,26 +632,6 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
 				  ATMEL_QSPI_TIMEOUT);
 }
 
-static int atmel_qspi_reg_sync(struct atmel_qspi *aq)
-{
-	u32 val;
-
-	return readl_poll_timeout(aq->regs + QSPI_SR2, val,
-				  !(val & QSPI_SR2_SYNCBSY),
-				  ATMEL_QSPI_SYNC_TIMEOUT);
-}
-
-static int atmel_qspi_update_config(struct atmel_qspi *aq)
-{
-	int ret;
-
-	ret = atmel_qspi_reg_sync(aq);
-	if (ret)
-		return ret;
-	atmel_qspi_write(QSPI_CR_UPDCFG, aq, QSPI_CR);
-	return atmel_qspi_reg_sync(aq);
-}
-
 static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 				      const struct spi_mem_op *op, u32 *offset)
 {
@@ -669,17 +683,9 @@ static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
-		ret = atmel_qspi_update_config(aq);
-		if (ret)
-			return ret;
-		aq->mr = QSPI_MR_SMM;
-	}
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
+		return ret;
 
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
@@ -903,11 +909,10 @@ static int atmel_qspi_sama7g5_set_speed(struct udevice *bus, uint hz)
 	}
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
-	ret = atmel_qspi_update_config(aq);
-	if (ret)
+	aq->mr |= QSPI_MR_DQSDLYEN;
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
 		return ret;
-	aq->mr = QSPI_MR_SMM;
 
 	/* Enable the QSPI controller. */
 	ret = atmel_qspi_reg_sync(aq);
@@ -1048,8 +1053,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-	aq->mr = QSPI_MR_SMM;
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
+		return ret;
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
-- 
2.39.5

