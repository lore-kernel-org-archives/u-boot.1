Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D58C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 457E4807F3;
	Thu, 23 Jan 2025 13:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="HMxjJeK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C2680711; Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7FF580790
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 024E2148A1EC; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0rqUR/qOEalP/nNtdirHzzstpZtXI+Anjpyet0t43Y=;
 b=HMxjJeK/5MuFMiaEvWqsr2FmbeIdsu0C56n626AdPOwaDKrY82tFfPoeBTC0m2Q8G3kGXm
 lSMXvwzs86b4E96GrCxbIIqqOjFvucxkkXKiSuXmMC8K7382U6j6YLnhqrnXVDl3AQOhnT
 KZaUC0Bnl3PiT9j118ovN2/+3l2MzjSncy0AxE8bHUbnW9Q+4bexxKtGqBmy7CoqSnzCs8
 Cdu+zbUOlHGRsiFAKapjBfK04kf2BKyQY4UTM/hMBlEaZFn6j11K8YOIRQWYHLBq4E8K4e
 yhLDJ0hwNbMt0JmPv3yooQx5Qc4ZQC/L1Od+l0dXZ3WRS7V8LrNikNrqSr8fDQ==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: [PATCH 5/7] spi: atmel-quadspi: Allow setting SMM to classic SPI mode
Date: Thu, 23 Jan 2025 13:12:13 +0100
Message-Id: <20250123121215.21001-6-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123121215.21001-1-ada@thorsis.com>
References: <20250123121215.21001-1-ada@thorsis.com>
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

Switching between Serial Memory Mode (SMM) and (classic) SPI mode is a
preparation for implementing .xfer() in the future.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 467f29c01ca..d29b5ab96e9 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -479,15 +479,19 @@ static bool atmel_qspi_supports_op(struct spi_slave *slave,
 }
 
 /*
- * If the QSPI controller is set in regular SPI mode, set it in
- * Serial Memory Mode (SMM).
+ * Switch QSPI controller between regular SPI mode or Serial Memory Mode (SMM).
  */
-static int atmel_qspi_set_serial_memory_mode(struct atmel_qspi *aq)
+static int atmel_qspi_set_serial_memory_mode(struct atmel_qspi *aq,
+					     bool enable)
 {
 	int ret = 0;
 
-	if (!(aq->mr & QSPI_MR_SMM)) {
-		aq->mr |= QSPI_MR_SMM;
+	/* only write if designated state differs from current state */
+	if (!!(aq->mr & QSPI_MR_SMM) != enable) {
+		if (enable)
+			aq->mr |= QSPI_MR_SMM;
+		else
+			aq->mr &= ~QSPI_MR_SMM;
 		atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
 		if (aq->caps->has_gclk)
@@ -576,7 +580,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	mode = atmel_qspi_set_serial_memory_mode(aq);
+	mode = atmel_qspi_set_serial_memory_mode(aq, true);
 	if (mode < 0)
 		return mode;
 
@@ -683,7 +687,7 @@ static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	ret = atmel_qspi_set_serial_memory_mode(aq);
+	ret = atmel_qspi_set_serial_memory_mode(aq, true);
 	if (ret < 0)
 		return ret;
 
@@ -910,7 +914,7 @@ static int atmel_qspi_sama7g5_set_speed(struct udevice *bus, uint hz)
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
 	aq->mr |= QSPI_MR_DQSDLYEN;
-	ret = atmel_qspi_set_serial_memory_mode(aq);
+	ret = atmel_qspi_set_serial_memory_mode(aq, true);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5

