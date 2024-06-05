Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80994C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E1B884D2;
	Wed,  5 Jun 2024 21:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OxyzgfbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13AC98836E; Wed,  5 Jun 2024 21:22:09 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A53488300
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35dce6102f4so100927f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615326; x=1718220126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N/Gdt7/+lZ0binabe9ZcG2ArhZluimuOacqq/Lpqfk4=;
 b=OxyzgfbYRpxJ+QqP+DlWn1/N/EsBao3U5kw6uoRmAml7bLYryOM/Sa0T5q6jp+D+i1
 9nhND9HfiYXbZv9AdhB4jp2w4PUm3P+guXrsbtK/cKJ9aSvtmhf46LZc2kzCKaTcn0Cs
 vXhlcgQr1KDrG5glVRVQT6+eFnmDX46WNMFxwsz4C/F2redy6Fgz8xOleevPoTVBdEMK
 xViBxVwlIZPA5sMFjYbkwNOS1wL1DT06ryYtUd3ylYc77fPYS4xywRFjvwNtRdZbTYnd
 9yPt5WlrGu6DVOUNz1cbNJzLrTwqpUsQ2OEPEWofOIMGo4EUqM2Lz0A/QUMxJSyQjTLz
 uXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615326; x=1718220126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/Gdt7/+lZ0binabe9ZcG2ArhZluimuOacqq/Lpqfk4=;
 b=ws9rsBDCVGMkfX8MrOY8bZOeAHM08iRimBMCW2H/2B5bvF5O1lmuvTziR0AeAsLclC
 G4pKKWlXbVyZQq99Y0xQ2lle/fVJNz36y2N/3a4xPyhCLlDz8T/69X6Bn5NdFux0lp07
 Gp5gibblHEfmmFPL05g7GL5MWlDXeT18zLrfq/KZWEhkQUoKd7R609hriVTc18gE5S84
 9dCMqeVqzwt9dOsajqD8RYHZcgEq6F7UILipmYWginCQBT4XNLqVLCIOzI+pCcgoT4MB
 K4hjXkAbDR4R8VaDYN837dbygb955sM7dpFFrQOJODQEnElihP4PweAweLzMbMC8kZGW
 2JyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQhuEPHetNAVBTx56IwQRgNcFLDZm3zD3kIXUfrFOmnLh0W/oGtA6O27gg/Pyhad0WY8OHSjrXEEnKc+ML0PVgMc75w==
X-Gm-Message-State: AOJu0YxrGa1fqNP9RQcEF6OoQ81aIJkpoGUiBEUybawnJss8hLquYqUg
 2zuIkZxierJjcQo69pm0DSSw338EaVRv147fqoL+cwu3zR8Ady8K
X-Google-Smtp-Source: AGHT+IFRONZK8RGRC5x6pa76z50dfB1U6LM+8CSQvvATEkVm7j8/Po7g1HUZxhWHUHcDvCBzMjEpUg==
X-Received: by 2002:a5d:4e91:0:b0:35d:bf15:dac2 with SMTP id
 ffacd0b85a97d-35e8ef0aad3mr2652191f8f.39.1717615326216; 
 Wed, 05 Jun 2024 12:22:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:22:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 6/7] mtd: implement support for LED status activity
Date: Wed,  5 Jun 2024 21:21:38 +0200
Message-ID: <20240605192146.19052-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

Implement support for LED status activity. If the feature is enabled,
make the defined ACTIVITY LED to signal mtd write or erase operations.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/mtd.c                      | 23 +++++++++++++++++++++++
 drivers/mtd/nand/core.c        |  4 ++++
 drivers/mtd/nand/spi/core.c    |  5 +++++
 drivers/mtd/spi/spi-nor-core.c |  9 +++++++++
 4 files changed, 41 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 9189f45cabd..aa0a41ac3bb 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <common.h>
 #include <console.h>
+#include <status_led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
 #endif
@@ -559,6 +560,12 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (mtd_block_isbad(mtd, off))
 		off += mtd->erasesize;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	if (!read)
+		status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+			       CONFIG_LED_STATUS_BLINKING);
+#endif
+
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
 		/* Skip the block if it is bad */
@@ -586,6 +593,12 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		io_op.oobbuf += io_op.oobretlen;
 	}
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	if (!read)
+		status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+			       CONFIG_LED_STATUS_OFF);
+#endif
+
 	if (!ret && dump)
 		mtd_dump_device_buf(mtd, start_off, buf, len, woob);
 
@@ -653,6 +666,11 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	erase_op.addr = off;
 	erase_op.len = mtd->erasesize;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_ON);
+#endif
+
 	while (len) {
 		if (!scrub) {
 			ret = mtd_block_isbad(mtd, erase_op.addr);
@@ -681,6 +699,11 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 		erase_op.addr += mtd->erasesize;
 	}
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_OFF);
+#endif
+
 	if (ret && ret != -EIO)
 		ret = CMD_RET_FAILURE;
 	else
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index f6d9c584f78..631a4c83e04 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/nand.h>
 #include <linux/printk.h>
+#include <status_led.h>
 
 /**
  * nanddev_isbad() - Check if a block is bad
@@ -182,6 +183,9 @@ int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
 		}
 
 		nanddev_pos_next_eraseblock(nand, &pos);
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+		status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62c28aa422d..86d7ed9e9d0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <status_led.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
@@ -657,6 +658,10 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+		status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 	}
 
 #ifndef __UBOOT__
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c0..1e7436079e9 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -32,6 +32,8 @@
 #include <spi-mem.h>
 #include <spi.h>
 
+#include <status_led.h>
+
 #include "sf_internal.h"
 
 /* Define max times to check status register before we give up. */
@@ -1039,6 +1041,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto erase_err;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+		status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 	}
 
 	addr_known = false;
@@ -1816,6 +1822,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+		status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 	}
 
 write_err:
-- 
2.43.0

