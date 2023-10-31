Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CBC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D691E87AB4;
	Tue, 31 Oct 2023 08:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738071;
	bh=pAxu0zx0Y765aKBkTU3DoS17fT+mLQEj8gZH5vi1IWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwFEKtJsGVAeCetY8LMCHkJq1QhGH9SjpWiioMbzbRCcrjsMtW6bCQ1jVg6/U6ZH9
	 f0Vw4vNUNZJP0yaMOSiMO4SnYdlVqkXBfMBtksPJmun47tfLFL1J4sCnuCQwx4IIJQ
	 vM/eeBXMI5xEH21PAuIky2Vaqiyn1Fv6I7cyLXWEULDFvh3OaI9oLshPm2QV2B2JC5
	 V1msk1wC/Fx9b4FCR5qmKDzsiMCDyDQCkyvq6/JjDqXyABwsgGdXk9B2Lv/I7maVIM
	 ruTEkALAVmuqUkzl0LjM9ADPntEkWyXvimPcc/4aJSRu8MJHOBNMmi3bG9915BOPLg
	 /Zl/zIBf2BjBQ==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 10BB087256;
 Tue, 31 Oct 2023 08:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738070;
 bh=pAxu0zx0Y765aKBkTU3DoS17fT+mLQEj8gZH5vi1IWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=idf8ibf0Sg73X4zg1JmJNjvgsm2kSN0ptU0321CbvRtIVrPV0KA4fz2Ks45XKuWTt
 7MNu4s5N+OMw5cdpQKaLxQogBinXd9oR/OwtmUE9jWOLN1WEFkqaWCf2s3UhEfeP6+
 RsFgQOCk4uHYznYC/2qk1an2axy3uH8BQYYU926RCmG2xKtCeF4NbMyg293xwVrcFz
 7EatiW04rSpTYl89xLzKz5+4Qor6fqcIYVxQWw7/yZeS0LNUDjBnlWt14OmmDnWwiy
 rtAxsbrkPYvnctciAmbLSndT1Rm66OmakmyqHuqa4M9JxcPtOtzGgXzF2Q66UF/+Dc
 MOje952zamVDw==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v3 1/3] bootcount: Remove legacy I2C driver
Date: Tue, 31 Oct 2023 08:38:44 +0100
Message-ID: <20231031073844.15683-4-pro@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031073844.15683-2-pro@denx.de>
References: <20231031073844.15683-2-pro@denx.de>
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

The legacy I2C bootcounter will hereby be removed and eventually
be replaced by a driver model implementation in the follow-up commit.

The legacy driver has the following drawbacks:
	- It's not adhering to the driver model
	- Settings are grabbed from Kconfig rather than device tree
	- i2c_{read,write} are being used instead of dm_i2c_{read,write}

Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v3: none
    Changes in v2: none

 drivers/bootcount/Kconfig         | 24 +++--------------
 drivers/bootcount/Makefile        |  1 -
 drivers/bootcount/bootcount_i2c.c | 43 -------------------------------
 3 files changed, 3 insertions(+), 65 deletions(-)
 delete mode 100644 drivers/bootcount/bootcount_i2c.c

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 570252d186..7a2548ace2 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -79,14 +79,6 @@ config BOOTCOUNT_RAM
 	  Store the bootcount in DRAM protected against bit errors
 	  due to short power loss or holding a system in RESET.
 
-config BOOTCOUNT_I2C
-	bool "Boot counter on I2C device"
-	help
-	  Enable support for the bootcounter on an i2c (like RTC) device.
-	  CFG_SYS_I2C_RTC_ADDR = i2c chip address
-	  CONFIG_SYS_BOOTCOUNT_ADDR = i2c addr which is used for
-	                              the bootcounter.
-
 config BOOTCOUNT_AT91
 	bool "Boot counter for Atmel AT91SAM9XE"
 	depends on AT91SAM9XE
@@ -175,14 +167,6 @@ config BOOTCOUNT_BOOTLIMIT
 	  counter being cleared.
 	  If set to 0, do not set a boot limit in the environment.
 
-config BOOTCOUNT_ALEN
-	int "I2C address length"
-	default 1
-	depends on BOOTCOUNT_I2C
-	help
-	  Length of the the I2C address at SYS_BOOTCOUNT_ADDR for storing
-	  the boot counter.
-
 config SYS_BOOTCOUNT_SINGLEWORD
 	bool "Use single word to pack boot count and magic value"
 	depends on BOOTCOUNT_GENERIC
@@ -218,7 +202,7 @@ config SYS_BOOTCOUNT_ADDR
 	default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
 	default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
 	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
-		   BOOTCOUNT_I2C || BOOTCOUNT_AM33XX_NVMEM
+		   BOOTCOUNT_AM33XX_NVMEM
 	help
 	  Set the address used for reading and writing the boot counter.
 
@@ -226,13 +210,11 @@ config SYS_BOOTCOUNT_MAGIC
 	hex "Magic value for the boot counter"
 	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
 			      BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
-			      BOOTCOUNT_RAM || BOOTCOUNT_I2C || \
-			      BOOTCOUNT_AT91 || DM_BOOTCOUNT
+			      BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
 	default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
 	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
 		   BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
-		   BOOTCOUNT_RAM || BOOTCOUNT_I2C || \
-		   BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
+		   BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
 		   BOOTCOUNT_AM33XX_NVMEM
 	help
 	  Set the magic value used for the boot counter.
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index b65959a384..d6d2389c16 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
 obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
 obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
-obj-$(CONFIG_BOOTCOUNT_I2C)	+= bootcount_i2c.o
 obj-$(CONFIG_BOOTCOUNT_EXT)	+= bootcount_ext.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)	+= bootcount_nvmem.o
 
diff --git a/drivers/bootcount/bootcount_i2c.c b/drivers/bootcount/bootcount_i2c.c
deleted file mode 100644
index b3ac67ea35..0000000000
--- a/drivers/bootcount/bootcount_i2c.c
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2013
- * Heiko Schocher, DENX Software Engineering, hs@denx.de.
- */
-
-#include <bootcount.h>
-#include <linux/compiler.h>
-#include <i2c.h>
-
-#define BC_MAGIC	0xbc
-
-void bootcount_store(ulong a)
-{
-	unsigned char buf[3];
-	int ret;
-
-	buf[0] = BC_MAGIC;
-	buf[1] = (a & 0xff);
-	ret = i2c_write(CFG_SYS_I2C_RTC_ADDR, CONFIG_SYS_BOOTCOUNT_ADDR,
-		  CONFIG_BOOTCOUNT_ALEN, buf, 2);
-	if (ret != 0)
-		puts("Error writing bootcount\n");
-}
-
-ulong bootcount_load(void)
-{
-	unsigned char buf[3];
-	int ret;
-
-	ret = i2c_read(CFG_SYS_I2C_RTC_ADDR, CONFIG_SYS_BOOTCOUNT_ADDR,
-		       CONFIG_BOOTCOUNT_ALEN, buf, 2);
-	if (ret != 0) {
-		puts("Error loading bootcount\n");
-		return 0;
-	}
-	if (buf[0] == BC_MAGIC)
-		return buf[1];
-
-	bootcount_store(0);
-
-	return 0;
-}
-- 
2.42.0

