Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A1C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70EDE87B7D;
	Fri, 15 Dec 2023 05:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ia8V8IN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5422287B58; Fri, 15 Dec 2023 05:19:37 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BCA87B0D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ba10647a19so239331b6e.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613972; x=1703218772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0S67x28uEH8/8j2Tr70Vx8q3QU0i9wWuS58cHk3FaAE=;
 b=Ia8V8IN2rKjSorON598uOAuUmIUMpUee76XmBxkg0zGfRGGSOOq8I/BBXrLNUjV4jG
 /2nqsV/oxwlTp29flep748iBJeIsLlWw45s1OJMbCn34ZQelWhCVc4bKKtiGj1M130wH
 4tD1h/PRN2W2TTmX9OPFeFT74DcLeG5vQ0yqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613972; x=1703218772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0S67x28uEH8/8j2Tr70Vx8q3QU0i9wWuS58cHk3FaAE=;
 b=H7HArahL14TFn3Z1Mbk0sMIB87fRlTFb9Zpe2cIp8EXf8zYaQOLa2d++n0wJP6DFZd
 hPwnGleeWY+euP7WTOj9HYyndZCCpTcYa3cYw88nbezw63mh07O4jByBRCyxmFHGlyQU
 f8h3A8qFWuQ7jiv5TECTxnjs/EntfivtaaMVkygkUCs+P3WMLtgFmAfAfQmdSLjig3B1
 eUUB0PN//UlcgAcNTrShkpTMmo7mpkNdUhsXLoGwMd2f0ySwbTx8pNISWPhh14PiomB5
 Vh8miiHKkd/MKOcVGmqhmpkZrE0rNcGnKQuh62QtoVKiCYRggobh0+1UWtuSq92ojvjd
 wGDw==
X-Gm-Message-State: AOJu0YwNhVBoQ6DPT3rXcNtA1GB70KQ/awWxvXm+cf3kMJ/ZPCx6wpoH
 hEFi78GVJLnb7QHGgpRVmblzpGlpJu1ELh7Vy7bnjw==
X-Google-Smtp-Source: AGHT+IELbcKVv+7+ZtEjvpJShylrVhHwvu9rW1YPMZS+JJmxMw3UJcceZKF6Hx8lR+kTqFiuyoQAUQ==
X-Received: by 2002:a05:6808:1309:b0:3b9:d68d:d513 with SMTP id
 y9-20020a056808130900b003b9d68dd513mr12730825oiv.81.1702613972485; 
 Thu, 14 Dec 2023 20:19:32 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 06/16] fastboot: Change fastboot_buf_addr to an address
Date: Thu, 14 Dec 2023 21:19:04 -0700
Message-ID: <20231215041919.2197788-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Given the name of this variable, it should be an address, not a
pointer. Update this, to make it easier to use with sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
---

Changes in v2:
- Use unmap_sysmem() too

 cmd/fastboot.c                |  2 +-
 drivers/fastboot/fb_command.c | 17 ++++++++++++-----
 drivers/fastboot/fb_common.c  | 15 ++++-----------
 include/fastboot-internal.h   |  2 +-
 include/fastboot.h            |  6 +++---
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index c3c19231c988..792e83d372c3 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -159,7 +159,7 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
+	fastboot_init(buf_addr, buf_size);
 
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 5fcadcdf503d..55ac1e96979f 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -10,6 +10,7 @@
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
+#include <mapmem.h>
 #include <part.h>
 #include <stdlib.h>
 #include <linux/printk.h>
@@ -243,6 +244,7 @@ void fastboot_data_download(const void *fastboot_data,
 {
 #define BYTES_PER_DOT	0x20000
 	u32 pre_dot_num, now_dot_num;
+	void *buf;
 
 	if (fastboot_data_len == 0 ||
 	    (fastboot_bytes_received + fastboot_data_len) >
@@ -252,8 +254,10 @@ void fastboot_data_download(const void *fastboot_data,
 		return;
 	}
 	/* Download data to fastboot_buf_addr */
-	memcpy(fastboot_buf_addr + fastboot_bytes_received,
+	buf = map_sysmem(fastboot_buf_addr, 0);
+	memcpy(buf + fastboot_bytes_received,
 	       fastboot_data, fastboot_data_len);
+	unmap_sysmem(buf);
 
 	pre_dot_num = fastboot_bytes_received / BYTES_PER_DOT;
 	fastboot_bytes_received += fastboot_data_len;
@@ -296,13 +300,16 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	void *buf = map_sysmem(fastboot_buf_addr, 0);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
-		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
-					 image_size, response);
+		fastboot_mmc_flash_write(cmd_parameter, buf, image_size,
+					 response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
-		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
-					  image_size, response);
+		fastboot_nand_flash_write(cmd_parameter, buf, image_size,
+					  response);
+	unmap_sysmem(buf);
 }
 
 /**
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 3576b0677299..07f5946d9ed1 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -20,7 +20,7 @@
 /**
  * fastboot_buf_addr - base address of the fastboot download buffer
  */
-void *fastboot_buf_addr;
+ulong fastboot_buf_addr;
 
 /**
  * fastboot_buf_size - size of the fastboot download buffer
@@ -154,7 +154,7 @@ void fastboot_boot(void)
 		};
 
 		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
-			 "0x%p", fastboot_buf_addr);
+			 "%lx", fastboot_buf_addr);
 		printf("Booting kernel at %s...\n\n\n", boot_addr_start);
 
 		do_bootm(NULL, 0, 2, bootm_args);
@@ -214,16 +214,9 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
 	fastboot_progress_callback = progress;
 }
 
-/*
- * fastboot_init() - initialise new fastboot protocol session
- *
- * @buf_addr: Pointer to download buffer, or NULL for default
- * @buf_size: Size of download buffer, or zero for default
- */
-void fastboot_init(void *buf_addr, u32 buf_size)
+void fastboot_init(ulong buf_addr, u32 buf_size)
 {
-	fastboot_buf_addr = buf_addr ? buf_addr :
-				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
+	fastboot_buf_addr = buf_addr ? buf_addr : CONFIG_FASTBOOT_BUF_ADDR;
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
 }
diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
index bf2f2b3c8914..d3e1c106e23f 100644
--- a/include/fastboot-internal.h
+++ b/include/fastboot-internal.h
@@ -6,7 +6,7 @@
 /**
  * fastboot_buf_addr - base address of the fastboot download buffer
  */
-extern void *fastboot_buf_addr;
+extern ulong fastboot_buf_addr;
 
 /**
  * fastboot_buf_size - size of the fastboot download buffer
diff --git a/include/fastboot.h b/include/fastboot.h
index 296451f89d44..744ab61cc18a 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -103,13 +103,13 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason);
  */
 void fastboot_set_progress_callback(void (*progress)(const char *msg));
 
-/*
+/**
  * fastboot_init() - initialise new fastboot protocol session
  *
- * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_addr: Address of download buffer, or 0 for default
  * @buf_size: Size of download buffer, or zero for default
  */
-void fastboot_init(void *buf_addr, u32 buf_size);
+void fastboot_init(ulong buf_addr, u32 buf_size);
 
 /**
  * fastboot_boot() - Execute fastboot boot command
-- 
2.43.0.472.g3155946c3a-goog

