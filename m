Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C1BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFCC8878DD;
	Mon,  4 Dec 2023 01:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ij8o/uTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6679878DD; Mon,  4 Dec 2023 01:32:53 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E608878DF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d8ba6c9b4bso657762a34.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649968; x=1702254768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANEJYD/XgWNSGEnzVwspiFUAkbscCfB9sSrRWOkjCoI=;
 b=Ij8o/uTB9/Q61J+A/xtBOyel/l+gVbNO+sF6nZdiInTeKhuW+9eIIgiaFmJVsUq9kS
 3QgGoztNZBNb0ZQeWny9jLna5yHXgIOMIKUPMZar7gDlj06skBRPaZDDTBBDd8a11W6r
 eb2ob3Zc5cJbDupzQQ+XVB7qtypFQ3sVAVQ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649968; x=1702254768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANEJYD/XgWNSGEnzVwspiFUAkbscCfB9sSrRWOkjCoI=;
 b=ML0/+3s8qf7D5QsBnwXAV23Q/hJ3mVauXsdbHZUJ4Nq+64NIX0QAE/UzgNvARwL3nJ
 P8SZuWBAPT97z2TWK0HLq67ePRpjnC7CKO0l/xaiD5RLzJo8WeL89AtaBdH4rhYoFit7
 BfdAGiqNGu+xRx88Y/RIRvi9MkXFwD+bXIu6iJ9j04nywe8u86Z4RszTHW2kh0tLdo0L
 0d4TnXn8sPJ6EIZoAYBMovy6+ulMrGEKfJLXu/eut+FKYySMVA5DXXETJUXpLwjK4MNz
 Vc/XJKycwZBYO0lyarNK9jYpo7/tPJ9R6l4yr9LKZPOtoN6P3y/M5/6wLMkIK0ZRGidw
 70iA==
X-Gm-Message-State: AOJu0Yz9nutft8Z2HNW/h3Wpj6kryI+/I59UTjUxuOBWFNlyACdvhXf6
 U1l4N27wRw4O5CYznBRsKjKaL5YTlWZEYfpf2zX2IA==
X-Google-Smtp-Source: AGHT+IH1YeIIT2S6s23ndvWdtVRNLB6s6rHDOV9vF94kyKQ82B4DYNdazycLKA7GFdtgsX17egZ0AA==
X-Received: by 2002:a05:6830:929:b0:6c6:4843:2aca with SMTP id
 v41-20020a056830092900b006c648432acamr3638105ott.25.1701649968512; 
 Sun, 03 Dec 2023 16:32:48 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 06/14] fastboot: Change fastboot_buf_addr to an address
Date: Sun,  3 Dec 2023 17:31:30 -0700
Message-ID: <20231204003144.899097-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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
---

 cmd/fastboot.c                |  2 +-
 drivers/fastboot/fb_command.c | 13 ++++++++-----
 drivers/fastboot/fb_common.c  | 15 ++++-----------
 include/fastboot-internal.h   |  2 +-
 include/fastboot.h            |  6 +++---
 5 files changed, 17 insertions(+), 21 deletions(-)

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
index 5fcadcdf503d..ec030886dbb8 100644
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
@@ -252,7 +253,7 @@ void fastboot_data_download(const void *fastboot_data,
 		return;
 	}
 	/* Download data to fastboot_buf_addr */
-	memcpy(fastboot_buf_addr + fastboot_bytes_received,
+	memcpy(map_sysmem(fastboot_buf_addr, 0) + fastboot_bytes_received,
 	       fastboot_data, fastboot_data_len);
 
 	pre_dot_num = fastboot_bytes_received / BYTES_PER_DOT;
@@ -296,13 +297,15 @@ void fastboot_data_complete(char *response)
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
2.43.0.rc2.451.g8631bc7472-goog

