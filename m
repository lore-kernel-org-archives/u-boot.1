Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8401D2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 497BD89276;
	Fri, 18 Oct 2024 10:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="Gpc7v3zl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ig+J+yB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D528C8912B; Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C05891A6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/s3IS8FhJd8nPif5DQ79O0snecdARRtJb3491wbVYY=;
 b=Gpc7v3zl0eZzkLeEmd305JEABapW4rQiVyRj7WM1+UoF0XanroJkeKU4DcnoToHve8S4ut
 OM/WpdMH+Xlob5uUYv0eX509+ZVysESe7l3AAbV7LXp8Bnjq5GIFAbYbNLeecYnvojfgDo
 wQvGC1eBjwczrqKQaUydk3f+57/3xx4cULXQKgXc9QOxgMkH1tEjUDk+I7qMieaM1nPG0/
 wkEJw43/87Ez2JEnyISLfUlRbXs8Uvnoe6242WvdLSgXVbt8y9wqt32llhMESB5QNpt3Cp
 1N64W3BctzXUtFL36PUSyxLULezNIDrDV5KBsRrvb39B7uWi8DNKJx8J6Yzg0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/s3IS8FhJd8nPif5DQ79O0snecdARRtJb3491wbVYY=;
 b=6Ig+J+yBe8GPYJyAaEysVtArYNGt2mGhwCPJ5MKeL8dPXlEIJGrD8VMiD1LAMkByPGLejj
 71pkoa7MBi8R1lAw==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 4/5] mtd: nand: Update NAND manufacturer Ids
Date: Fri, 18 Oct 2024 10:30:05 +0200
Message-ID: <20241018083006.10349-6-b.spranger@linutronix.de>
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
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

Align manufacturer Ids with the Id list from Linux kernel v6.11.
While at it, sort the entries in alphabetical order.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/raw/nand_ids.c | 22 ++++++++++++----------
 include/linux/mtd/rawnand.h     | 23 +++++++++++++----------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 4f46378ffe1..e40facf774c 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -180,20 +180,22 @@ struct nand_flash_dev nand_flash_ids[] = {
 
 /* Manufacturer IDs */
 struct nand_manufacturer nand_manuf_ids[] = {
-	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
-	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
+	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_EON, "Eon"},
+	{NAND_MFR_EON, "ESMT"},
 	{NAND_MFR_FUJITSU, "Fujitsu"},
-	{NAND_MFR_NATIONAL, "National"},
-	{NAND_MFR_RENESAS, "Renesas"},
-	{NAND_MFR_STMICRO, "ST Micro"},
 	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
-	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
-	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_INTEL, "Intel"},
 	{NAND_MFR_MACRONIX, "Macronix", &macronix_nand_manuf_ops},
-	{NAND_MFR_EON, "Eon"},
+	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
+	{NAND_MFR_NATIONAL, "National"},
+	{NAND_MFR_RENESAS, "Renesas"},
+	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
 	{NAND_MFR_SANDISK, "SanDisk"},
-	{NAND_MFR_INTEL, "Intel"},
-	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_STMICRO, "ST Micro"},
+	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
+	{NAND_MFR_WINBOND, "Winbond"},
 	{0x0, "Unknown"}
 };
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 537c62424a1..eaa6ec84b07 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1030,20 +1030,23 @@ static inline void *nand_get_manufacturer_data(struct nand_chip *chip)
 /*
  * NAND Flash Manufacturer ID Codes
  */
-#define NAND_MFR_TOSHIBA	0x98
-#define NAND_MFR_SAMSUNG	0xec
+#define NAND_MFR_AMD		0x01
+#define NAND_MFR_ATO		0x9b
+#define NAND_MFR_EON		0x92
+#define NAND_MFR_ESMT		0xc8
 #define NAND_MFR_FUJITSU	0x04
-#define NAND_MFR_NATIONAL	0x8f
-#define NAND_MFR_RENESAS	0x07
-#define NAND_MFR_STMICRO	0x20
 #define NAND_MFR_HYNIX		0xad
-#define NAND_MFR_MICRON		0x2c
-#define NAND_MFR_AMD		0x01
+#define NAND_MFR_INTEL		0x89
 #define NAND_MFR_MACRONIX	0xc2
-#define NAND_MFR_EON		0x92
+#define NAND_MFR_MICRON		0x2c
+#define NAND_MFR_NATIONAL	0x8f
+#define NAND_MFR_RENESAS	0x07
+#define NAND_MFR_SAMSUNG	0xec
 #define NAND_MFR_SANDISK	0x45
-#define NAND_MFR_INTEL		0x89
-#define NAND_MFR_ATO		0x9b
+#define NAND_MFR_STMICRO	0x20
+/* Kioxia is new name of Toshiba memory. */
+#define NAND_MFR_TOSHIBA	0x98
+#define NAND_MFR_WINBOND	0xef
 
 /* The maximum expected count of bytes in the NAND ID sequence */
 #define NAND_MAX_ID_LEN 8
-- 
2.45.2

