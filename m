Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22174C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C53E8076E;
	Thu, 23 Jan 2025 13:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="poeNatM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95458807E1; Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B7080780
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C31F2148A1E6; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iP4CYGo1A8G+RymVe/oldA3jK+7fpnEmzW4jIx2NCE=;
 b=poeNatM57KuNVUxhxmoGAN9qVmHIvhZSSHi2zcMGzuI93JIIOJV+gFDScYigrkW26Soa6+
 wLIyOAw5WmSw4Vue9DXeNLsM8ie/jPZoDx0tQ1jPkVzbJ3M5iVZCZ2y6UlwwbA9mO1w1/k
 IO7GswyvxMjuIVtLZCieaKaBk3DTHQdMKKPs3qoexFpWHUOZbTYAlCNUT1e4ZzbMaxtdwG
 mtvXJPbWeE5kuTPoQbmdsOyjlIhEObvfp5icj5JzzfjS9Dnf9iO7136NyV+H/NV0dFJXL5
 nje/rznZjUlDn04aVzX8LoyR4f4unsnPlFwMnZmUZnyW7KHwXHzg7QbQcr4Zqg==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: [PATCH 4/7] spi: atmel-quadspi: Remove default mode setting at probe
 time
Date: Thu, 23 Jan 2025 13:12:12 +0100
Message-Id: <20250123121215.21001-5-ada@thorsis.com>
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

The Serial Memory Mode (SMM) is enabled with atmel_qspi_set_cfg() on
each invocation of atmel_qspi_exec_op().  Setting SMM through
atmel_qspi_init() at probe time is redundant.

Removing the SMM setting at probe time should therefore 1) be safe to do
and 2) allows for setting it to a different value in a future
implementation of .xfer() which needs to disable SMM.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 9e596b7448c..467f29c01ca 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1052,11 +1052,6 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	/* Reset the QSPI controller */
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
-	/* Set the QSPI controller by default in Serial Memory Mode */
-	ret = atmel_qspi_set_serial_memory_mode(aq);
-	if (ret < 0)
-		return ret;
-
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
 
-- 
2.39.5

