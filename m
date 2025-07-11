Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F0C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED2B8312E;
	Fri, 11 Jul 2025 17:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r+8vNbis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25330831AC; Fri, 11 Jul 2025 17:20:34 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81E38312E
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40ba3d91c35so1242740b6e.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247230; x=1752852030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sO18mTR6HHy81sgaxXjNpwzQHv1umr5GibD3yWEKe0c=;
 b=r+8vNbislT/Bb/lzNwknfG/wq6l+JwAD/9W0/WiLWguo5gfBR98YdRA5qpT0Xd9g9X
 ncb6xYYWOPvjm2cPyCPdFQhHiLw0XubgSQIWbHJiUMAjSYy9WUYhkkLA0V27NLIqeOV3
 ArrO1V8JJHUT5h0tt9DB26D1Awgh4JD3mkn9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247230; x=1752852030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sO18mTR6HHy81sgaxXjNpwzQHv1umr5GibD3yWEKe0c=;
 b=Epc+MFbhxMB+ZEc6fO6mRa0S+Eg0Liv0CCOpWZj29mzM6FKRUdaJ0B1jMc/MWFouI+
 cvHa1mUKH/WikK3Y5o0t6RtI4JDjTKASbZkcg3JkmUihW54j0GxgzHRdwJ1cxK4WGQr3
 4P6CuJ5RMgt/GjwcZX1JyAO330+i54Fv5/tbwqaUZBy+WvMv73kRZUCNH9P3+JfsRxKT
 e3kRf7oGNBG0IKi01yLWrgWcyyYEEnHEuCGvuUMTcMXUaYd9y3WRS7VtmHdKrp2NYg40
 mfp7H49/futAq7Rew2B3z/+l700PjllVC5mYkl9CnEPKvf7phAxUSscVBJ6sf3xG9yFl
 s5pQ==
X-Gm-Message-State: AOJu0YwB2WVwoKCKphi9yr3ODaZ4kjiSkM6frMmNdQ/KVNeiy3RwB983
 LVjzqRM7OSgy+eKiuctQnJY+SkSlllT9tDtzPUe1bKEqa76UeOPFbqonv49ak2J60l+e6KdQNd7
 RlNXpT2g=
X-Gm-Gg: ASbGnct/hWNWgTNl+iR/7Vjoj/wX5Ce7+DhWSRrME26JqoVCTqlbYq1T9rFfMuF/Q0k
 aOjrJap225XNmqIJGSxRPvEPtHFMsa9lomADZYwcfY/bFKV+lr7Nw6odOziq6Th0vsYjt38QSaY
 JGtgw3TW89pO5BnBSJbVg2WuTKQ/3+rFPw2fcivKG5o06y9Cdp/F2QDci0xw/sHA0a8WcfQsDxZ
 CTcf4d8etpivPdofzlJKNLUDptohTmnuo99ZgcFbvZKzR+ZzVEmvekoOpJMjaoZmrwV/jA5JwSr
 M/E3SpNdWbsSRPmb0MYXwW4bMkOaZphYEyAzAZfQ99JzGGLFBZTWONNIan07GTQzVGQIYnor2V7
 YLQE1T03D7hB1Gxvx8pKm7D1sEr0YmGm/vFvfcA5zqHaubkfc1fzyzcg6Dyc=
X-Google-Smtp-Source: AGHT+IHtNEkKKq1+wIxUZ8yPhbR5+PbHUt3sLuvyqBDQjmKUvxW7njqB45cYLqgQtIJh9jmcjxDLfw==
X-Received: by 2002:a05:6808:6b47:b0:40b:3bdd:ba22 with SMTP id
 5614622812f47-415393d4f5cmr2299875b6e.24.1752247229991; 
 Fri, 11 Jul 2025 08:20:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c1abe25sm563654b6e.33.2025.07.11.08.20.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] misc: Remove DS4510 driver
Date: Fri, 11 Jul 2025 09:20:28 -0600
Message-ID: <20250711152028.2225638-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As no platforms use this driver anymore and it's not been converted from
to DM_I2C for use, remove it.

Fixes: ed7fe2bee12a ("ppc: Remove xpedite boards")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/misc/Kconfig  |   8 -
 drivers/misc/Makefile |   1 -
 drivers/misc/ds4510.c | 379 ------------------------------------------
 drivers/misc/ds4510.h |  52 ------
 4 files changed, 440 deletions(-)
 delete mode 100644 drivers/misc/ds4510.c
 delete mode 100644 drivers/misc/ds4510.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 515d3668395d..c4a4510f9687 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -290,14 +290,6 @@ config CROS_EC_SPI
 	  provides a faster and more robust interface than I2C but the bugs
 	  are less interesting.
 
-config DS4510
-	bool "Enable support for DS4510 CPU supervisor"
-	help
-	  Enable support for the Maxim DS4510 CPU supervisor. It has an
-	  integrated 64-byte EEPROM, four programmable non-volatile I/O pins
-	  and a configurable timer for the supervisor function. The device is
-	  connected over I2C.
-
 config FSL_IIM
 	bool "Enable FSL IC Identification Module (IIM) driver"
 	depends on ARCH_MX5
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 248068d5b436..83a95f683aca 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -32,7 +32,6 @@ endif
 obj-$(CONFIG_ALTERA_SYSID) += altera_sysid.o
 obj-$(CONFIG_ATSHA204A) += atsha204a-i2c.o
 obj-$(CONFIG_CBMEM_CONSOLE) += cbmem_console.o
-obj-$(CONFIG_DS4510)  += ds4510.o
 obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
diff --git a/drivers/misc/ds4510.c b/drivers/misc/ds4510.c
deleted file mode 100644
index 302015e27938..000000000000
--- a/drivers/misc/ds4510.c
+++ /dev/null
@@ -1,379 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2008 Extreme Engineering Solutions, Inc.
- */
-
-/*
- * Driver for DS4510, a CPU supervisor with integrated EEPROM, SRAM,
- * and 4 programmable non-volatile GPIO pins.
- */
-
-#include <i2c.h>
-#include <command.h>
-#include <linux/delay.h>
-#include "ds4510.h"
-
-enum {
-	DS4510_CMD_INFO,
-	DS4510_CMD_DEVICE,
-	DS4510_CMD_NV,
-	DS4510_CMD_RSTDELAY,
-	DS4510_CMD_OUTPUT,
-	DS4510_CMD_INPUT,
-	DS4510_CMD_PULLUP,
-	DS4510_CMD_EEPROM,
-	DS4510_CMD_SEEPROM,
-	DS4510_CMD_SRAM,
-};
-
-/*
- * Write to DS4510, taking page boundaries into account
- */
-static int ds4510_mem_write(uint8_t chip, int offset, uint8_t *buf, int count)
-{
-	int wrlen;
-	int i = 0;
-
-	do {
-		wrlen = DS4510_EEPROM_PAGE_SIZE -
-			DS4510_EEPROM_PAGE_OFFSET(offset);
-		if (count < wrlen)
-			wrlen = count;
-		if (i2c_write(chip, offset, 1, &buf[i], wrlen))
-			return -1;
-
-		/*
-		 * This delay isn't needed for SRAM writes but shouldn't delay
-		 * things too much, so do it unconditionally for simplicity
-		 */
-		udelay(DS4510_EEPROM_PAGE_WRITE_DELAY_MS * 1000);
-		count -= wrlen;
-		offset += wrlen;
-		i += wrlen;
-	} while (count > 0);
-
-	return 0;
-}
-
-/*
- * General read from DS4510
- */
-static int ds4510_mem_read(uint8_t chip, int offset, uint8_t *buf, int count)
-{
-	return i2c_read(chip, offset, 1, buf, count);
-}
-
-/*
- * Write SEE bit in config register.
- * nv = 0 - Writes to SEEPROM registers behave like EEPROM
- * nv = 1 - Writes to SEEPROM registers behave like SRAM
- */
-static int ds4510_see_write(uint8_t chip, uint8_t nv)
-{
-	uint8_t data;
-
-	if (i2c_read(chip, DS4510_CFG, 1, &data, 1))
-		return -1;
-
-	if (nv)	/* Treat SEEPROM bits as EEPROM */
-		data &= ~DS4510_CFG_SEE;
-	else	/* Treat SEEPROM bits as SRAM */
-		data |= DS4510_CFG_SEE;
-
-	return ds4510_mem_write(chip, DS4510_CFG, &data, 1);
-}
-
-/*
- * Write de-assertion of reset signal delay
- */
-static int ds4510_rstdelay_write(uint8_t chip, uint8_t delay)
-{
-	uint8_t data;
-
-	if (i2c_read(chip, DS4510_RSTDELAY, 1, &data, 1))
-		return -1;
-
-	data &= ~DS4510_RSTDELAY_MASK;
-	data |= delay & DS4510_RSTDELAY_MASK;
-
-	return ds4510_mem_write(chip, DS4510_RSTDELAY, &data, 1);
-}
-
-/*
- * Write pullup characteristics of IO pins
- */
-static int ds4510_pullup_write(uint8_t chip, uint8_t val)
-{
-	val &= DS4510_IO_MASK;
-
-	return ds4510_mem_write(chip, DS4510_PULLUP, (uint8_t *)&val, 1);
-}
-
-/*
- * Read pullup characteristics of IO pins
- */
-static int ds4510_pullup_read(uint8_t chip)
-{
-	uint8_t val;
-
-	if (i2c_read(chip, DS4510_PULLUP, 1, &val, 1))
-		return -1;
-
-	return val & DS4510_IO_MASK;
-}
-
-/*
- * Write drive level of IO pins
- */
-static int ds4510_gpio_write(uint8_t chip, uint8_t val)
-{
-	uint8_t data;
-	int i;
-
-	for (i = 0; i < DS4510_NUM_IO; i++) {
-		if (i2c_read(chip, DS4510_IO0 - i, 1, &data, 1))
-			return -1;
-
-		if (val & (0x1 << i))
-			data |= 0x1;
-		else
-			data &= ~0x1;
-
-		if (ds4510_mem_write(chip, DS4510_IO0 - i, &data, 1))
-			return -1;
-	}
-
-	return 0;
-}
-
-/*
- * Read drive level of IO pins
- */
-static int ds4510_gpio_read(uint8_t chip)
-{
-	uint8_t data;
-	int val = 0;
-	int i;
-
-	for (i = 0; i < DS4510_NUM_IO; i++) {
-		if (i2c_read(chip, DS4510_IO0 - i, 1, &data, 1))
-			return -1;
-
-		if (data & 1)
-			val |= (1 << i);
-	}
-
-	return val;
-}
-
-/*
- * Read physical level of IO pins
- */
-static int ds4510_gpio_read_val(uint8_t chip)
-{
-	uint8_t val;
-
-	if (i2c_read(chip, DS4510_IO_STATUS, 1, &val, 1))
-		return -1;
-
-	return val & DS4510_IO_MASK;
-}
-
-/*
- * Display DS4510 information
- */
-static int ds4510_info(uint8_t chip)
-{
-	int i;
-	int tmp;
-	uint8_t data;
-
-	printf("DS4510 @ 0x%x:\n\n", chip);
-
-	if (i2c_read(chip, DS4510_RSTDELAY, 1, &data, 1))
-		return -1;
-	printf("rstdelay = 0x%x\n\n", data & DS4510_RSTDELAY_MASK);
-
-	if (i2c_read(chip, DS4510_CFG, 1, &data, 1))
-		return -1;
-	printf("config   = 0x%x\n", data);
-	printf(" /ready  = %d\n", data & DS4510_CFG_READY ? 1 : 0);
-	printf(" trip pt = %d\n", data & DS4510_CFG_TRIP_POINT ? 1 : 0);
-	printf(" rst sts = %d\n", data & DS4510_CFG_RESET ? 1 : 0);
-	printf(" /see    = %d\n", data & DS4510_CFG_SEE ? 1 : 0);
-	printf(" swrst   = %d\n\n", data & DS4510_CFG_SWRST ? 1 : 0);
-
-	printf("gpio pins: 3210\n");
-	printf("---------------\n");
-	printf("pullup     ");
-
-	tmp = ds4510_pullup_read(chip);
-	if (tmp == -1)
-		return tmp;
-	for (i = DS4510_NUM_IO - 1; i >= 0; i--)
-		printf("%d", (tmp & (1 << i)) ? 1 : 0);
-	printf("\n");
-
-	printf("driven     ");
-	tmp = ds4510_gpio_read(chip);
-	if (tmp == -1)
-		return -1;
-	for (i = DS4510_NUM_IO - 1; i >= 0; i--)
-		printf("%d", (tmp & (1 << i)) ? 1 : 0);
-	printf("\n");
-
-	printf("read       ");
-	tmp = ds4510_gpio_read_val(chip);
-	if (tmp == -1)
-		return -1;
-	for (i = DS4510_NUM_IO - 1; i >= 0; i--)
-		printf("%d", (tmp & (1 << i)) ? 1 : 0);
-	printf("\n");
-
-	return 0;
-}
-
-struct cmd_tbl cmd_ds4510[] = {
-	U_BOOT_CMD_MKENT(device, 3, 0, (void *)DS4510_CMD_DEVICE, "", ""),
-	U_BOOT_CMD_MKENT(nv, 3, 0, (void *)DS4510_CMD_NV, "", ""),
-	U_BOOT_CMD_MKENT(output, 4, 0, (void *)DS4510_CMD_OUTPUT, "", ""),
-	U_BOOT_CMD_MKENT(input, 3, 0, (void *)DS4510_CMD_INPUT, "", ""),
-	U_BOOT_CMD_MKENT(pullup, 4, 0, (void *)DS4510_CMD_PULLUP, "", ""),
-	U_BOOT_CMD_MKENT(info, 2, 0, (void *)DS4510_CMD_INFO, "", ""),
-	U_BOOT_CMD_MKENT(rstdelay, 3, 0, (void *)DS4510_CMD_RSTDELAY, "", ""),
-	U_BOOT_CMD_MKENT(eeprom, 6, 0, (void *)DS4510_CMD_EEPROM, "", ""),
-	U_BOOT_CMD_MKENT(seeprom, 6, 0, (void *)DS4510_CMD_SEEPROM, "", ""),
-	U_BOOT_CMD_MKENT(sram, 6, 0, (void *)DS4510_CMD_SRAM, "", ""),
-};
-
-int do_ds4510(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	static uint8_t chip = 0x51;
-	struct cmd_tbl *c;
-	ulong ul_arg2 = 0;
-	ulong ul_arg3 = 0;
-	int tmp;
-	ulong addr;
-	ulong off;
-	ulong cnt;
-	int end;
-	int (*rw_func)(uint8_t, int, uint8_t *, int);
-
-	c = find_cmd_tbl(argv[1], cmd_ds4510, ARRAY_SIZE(cmd_ds4510));
-
-	/* All commands but "device" require 'maxargs' arguments */
-	if (!c || !((argc == (c->maxargs)) ||
-		(((int)c->cmd == DS4510_CMD_DEVICE) &&
-		 (argc == (c->maxargs - 1))))) {
-		return cmd_usage(cmdtp);
-	}
-
-	/* arg2 used as chip addr and pin number */
-	if (argc > 2)
-		ul_arg2 = hextoul(argv[2], NULL);
-
-	/* arg3 used as output/pullup value */
-	if (argc > 3)
-		ul_arg3 = hextoul(argv[3], NULL);
-
-	switch ((int)c->cmd) {
-	case DS4510_CMD_DEVICE:
-		if (argc == 3)
-			chip = ul_arg2;
-		printf("Current device address: 0x%x\n", chip);
-		return 0;
-	case DS4510_CMD_NV:
-		return ds4510_see_write(chip, ul_arg2);
-	case DS4510_CMD_OUTPUT:
-		tmp = ds4510_gpio_read(chip);
-		if (tmp == -1)
-			return -1;
-		if (ul_arg3)
-			tmp |= (1 << ul_arg2);
-		else
-			tmp &= ~(1 << ul_arg2);
-		return ds4510_gpio_write(chip, tmp);
-	case DS4510_CMD_INPUT:
-		tmp = ds4510_gpio_read_val(chip);
-		if (tmp == -1)
-			return -1;
-		return (tmp & (1 << ul_arg2)) != 0;
-	case DS4510_CMD_PULLUP:
-		tmp = ds4510_pullup_read(chip);
-		if (tmp == -1)
-			return -1;
-		if (ul_arg3)
-			tmp |= (1 << ul_arg2);
-		else
-			tmp &= ~(1 << ul_arg2);
-		return ds4510_pullup_write(chip, tmp);
-	case DS4510_CMD_INFO:
-		return ds4510_info(chip);
-	case DS4510_CMD_RSTDELAY:
-		return ds4510_rstdelay_write(chip, ul_arg2);
-	case DS4510_CMD_EEPROM:
-		end = DS4510_EEPROM + DS4510_EEPROM_SIZE;
-		off = DS4510_EEPROM;
-		break;
-	case DS4510_CMD_SEEPROM:
-		end = DS4510_SEEPROM + DS4510_SEEPROM_SIZE;
-		off = DS4510_SEEPROM;
-		break;
-	case DS4510_CMD_SRAM:
-		end = DS4510_SRAM + DS4510_SRAM_SIZE;
-		off = DS4510_SRAM;
-		break;
-	default:
-		/* We should never get here... */
-		return 1;
-	}
-
-	/* Only eeprom, seeprom, and sram commands should make it here */
-	if (strcmp(argv[2], "read") == 0)
-		rw_func = ds4510_mem_read;
-	else if (strcmp(argv[2], "write") == 0)
-		rw_func = ds4510_mem_write;
-	else
-		return cmd_usage(cmdtp);
-
-	addr = hextoul(argv[3], NULL);
-	off += hextoul(argv[4], NULL);
-	cnt = hextoul(argv[5], NULL);
-
-	if ((off + cnt) > end) {
-		printf("ERROR: invalid len\n");
-		return -1;
-	}
-
-	return rw_func(chip, off, (uint8_t *)addr, cnt);
-}
-
-U_BOOT_CMD(
-	ds4510,	6,	1,	do_ds4510,
-	"ds4510 eeprom/seeprom/sram/gpio access",
-	"device [dev]\n"
-	"	- show or set current device address\n"
-	"ds4510 info\n"
-	"	- display ds4510 info\n"
-	"ds4510 output pin 0|1\n"
-	"	- set pin low or high-Z\n"
-	"ds4510 input pin\n"
-	"	- read value of pin\n"
-	"ds4510 pullup pin 0|1\n"
-	"	- disable/enable pullup on specified pin\n"
-	"ds4510 nv 0|1\n"
-	"	- make gpio and seeprom writes volatile/non-volatile"
-	"\n"
-	"ds4510 rstdelay 0-3\n"
-	"	- set reset output delay"
-	"\n"
-	"ds4510 eeprom read addr off cnt\n"
-	"ds4510 eeprom write addr off cnt\n"
-	"	- read/write 'cnt' bytes at EEPROM offset 'off'\n"
-	"ds4510 seeprom read addr off cnt\n"
-	"ds4510 seeprom write addr off cnt\n"
-	"	- read/write 'cnt' bytes at SRAM-shadowed EEPROM offset 'off'\n"
-	"ds4510 sram read addr off cnt\n"
-	"ds4510 sram write addr off cnt\n"
-	"	- read/write 'cnt' bytes at SRAM offset 'off'"
-);
diff --git a/drivers/misc/ds4510.h b/drivers/misc/ds4510.h
deleted file mode 100644
index 5c7a1a8c737c..000000000000
--- a/drivers/misc/ds4510.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright 2008 Extreme Engineering Solutions, Inc.
- */
-
-#ifndef __DS4510_H_
-#define __DS4510_H_
-
-/* General defines */
-#define DS4510_NUM_IO				0x04
-#define DS4510_IO_MASK				((1 << DS4510_NUM_IO) - 1)
-#define DS4510_EEPROM_PAGE_WRITE_DELAY_MS	20
-
-/* EEPROM from 0x00 - 0x39 */
-#define DS4510_EEPROM				0x00
-#define DS4510_EEPROM_SIZE			0x40
-#define DS4510_EEPROM_PAGE_SIZE			0x08
-#define DS4510_EEPROM_PAGE_OFFSET(x)	((x) & (DS4510_EEPROM_PAGE_SIZE - 1))
-
-/* SEEPROM from 0xf0 - 0xf7 */
-#define DS4510_SEEPROM				0xf0
-#define DS4510_SEEPROM_SIZE			0x08
-
-/* Registers overlapping SEEPROM from 0xf0 - 0xf7 */
-#define DS4510_PULLUP				0xF0
-#define DS4510_PULLUP_DIS			0x00
-#define DS4510_PULLUP_EN			0x01
-#define DS4510_RSTDELAY				0xF1
-#define DS4510_RSTDELAY_MASK			0x03
-#define DS4510_RSTDELAY_125			0x00
-#define DS4510_RSTDELAY_250			0x01
-#define DS4510_RSTDELAY_500			0x02
-#define DS4510_RSTDELAY_1000			0x03
-#define DS4510_IO3				0xF4
-#define DS4510_IO2				0xF5
-#define DS4510_IO1				0xF6
-#define DS4510_IO0				0xF7
-
-/* Status configuration registers from 0xf8 - 0xf9*/
-#define DS4510_IO_STATUS			0xF8
-#define DS4510_CFG				0xF9
-#define DS4510_CFG_READY			0x80
-#define DS4510_CFG_TRIP_POINT			0x40
-#define DS4510_CFG_RESET			0x20
-#define DS4510_CFG_SEE				0x10
-#define DS4510_CFG_SWRST			0x08
-
-/* SRAM from 0xfa - 0xff */
-#define DS4510_SRAM				0xfa
-#define DS4510_SRAM_SIZE			0x06
-
-#endif /* __DS4510_H_ */
-- 
2.43.0

