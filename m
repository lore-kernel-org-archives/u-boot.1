Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B918C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 13:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E04D876AC;
	Sat, 16 Dec 2023 14:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j663YGmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE590876B4; Sat, 16 Dec 2023 14:17:03 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE1687692
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 14:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b783ee485eso86621439f.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702732619; x=1703337419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9XtPSTr5C5xJD6byipLkCjP/vNpjcM33RXSCtyH9djM=;
 b=j663YGmAcDszmdcmPbSDRhP6sZHrU9LoLhmzz4BUfmwhFAjy2XahJVjiHmDHuwj975
 WiZcExb6oC5BSOyjqFlxl+iY1kMqD5p7GYvywB+roUPtZyNUCY6Yd2A50noadog8s33p
 PLO38zTksn9juH+GcdnI/a6tJMfxPXozsDx3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702732619; x=1703337419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XtPSTr5C5xJD6byipLkCjP/vNpjcM33RXSCtyH9djM=;
 b=ThxvGbTxr1pDkSRffYMu+LOTCPbfy9OWSCsBDw16gfKeQ1QHtO2gqx+Lrg0mh5Qvjx
 W77/YarbXdWBhdcGpxN40Xs3hQQXiQ8Up1tLOfZhWo6/o8ANqCGejSzQ1L0QFv2fIa4X
 S28q62TXUWRqg6sPftQzV15GBD//F8WdHBBwzhh7AxGs/HOHUWTCSfgBw686cv8Ak5Gi
 vNIYunbaUtbSMQ5rZ9jlrenlVpYYSeU1PCy6LdmVimzBrvjNbva9LYF9CIG/5r+q6fQ+
 TyBQfr/hxcRRfVX3UcXEOUoDdiZxH4cCBW2/D/XhlNCclfbdGPNThhYax/S6eG4zNYza
 do7A==
X-Gm-Message-State: AOJu0YzRwEvLG5R0BY+9OfQm+o/T7/g/t1SkvE5hluummbRqAN1IClpz
 yQJSEdknVogo01T9XQsd2MGsBTwvc3z5az2EUMehVA==
X-Google-Smtp-Source: AGHT+IGHJbebyEDHYusmbeUTXWZF5E/SsAYK+qwnRIT2c1djaiyJDPqWA5o1hr3f4zDHqhNrh0BpwQ==
X-Received: by 2002:a05:6e02:1a46:b0:35d:5995:903b with SMTP id
 u6-20020a056e021a4600b0035d5995903bmr13578364ilv.46.1702732619250; 
 Sat, 16 Dec 2023 05:16:59 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a0566380e8800b0046926dafa32sm4424818jas.135.2023.12.16.05.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 05:16:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alex Kiernan <alex.kiernan@gmail.com>
Subject: [PATCH v3 08/16] fastboot: Remove dependencies on CMDLINE
Date: Sat, 16 Dec 2023 06:16:38 -0700
Message-ID: <20231216131650.2242749-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

It is possible to boot a kernel without CMDLINE being enabled. Update
the implementation to handle this, and drop the condition from the
FASTBOOT config.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Expand the fastboot help

Changes in v2:
- Avoid changing the logic when a command is not set

 drivers/fastboot/Kconfig     |  5 ++++-
 drivers/fastboot/fb_common.c | 30 ++++++++++++++----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 11fc0fe1c800..449244ab6a8e 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,4 @@
 menu "Fastboot support"
-	depends on CMDLINE
 
 config FASTBOOT
 	bool
@@ -13,6 +12,10 @@ config FASTBOOT
 	  More information about the protocol and usecases:
 	  https://android.googlesource.com/platform/system/core/+/refs/heads/master/fastboot/
 
+	  Note that enabling CMDLINE is recommended since fastboot allows U-Boot
+	  commands to be executed on request. The CMDLINE option is required
+	  for anything other than simply booting the OS.
+
 config USB_FUNCTION_FASTBOOT
 	bool "Enable USB fastboot gadget"
 	depends on USB_GADGET
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 07f5946d9ed1..595954542a6e 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -11,6 +11,7 @@
  */
 
 #include <bcb.h>
+#include <bootm.h>
 #include <common.h>
 #include <command.h>
 #include <env.h>
@@ -142,22 +143,19 @@ void (*fastboot_get_progress_callback(void))(const char *)
  */
 void fastboot_boot(void)
 {
-	char *s;
-
-	s = env_get("fastboot_bootcmd");
-	if (s) {
-		run_command(s, CMD_FLAG_ENV);
-	} else if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
-		static char boot_addr_start[20];
-		static char *const bootm_args[] = {
-			"bootm", boot_addr_start, NULL
-		};
-
-		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
-			 "%lx", fastboot_buf_addr);
-		printf("Booting kernel at %s...\n\n\n", boot_addr_start);
-
-		do_bootm(NULL, 0, 2, bootm_args);
+	char *s = NULL;
+
+	if (IS_ENABLED(CONFIG_CMDLINE)) {
+		s = env_get("fastboot_bootcmd");
+		if (s)
+			run_command(s, CMD_FLAG_ENV);
+	}
+
+	if (!s && IS_ENABLED(CONFIG_BOOTM)) {
+		int ret;
+
+		printf("Booting kernel at %lx...\n\n\n", fastboot_buf_addr);
+		ret = bootm_boot_start(fastboot_buf_addr, NULL);
 
 		/*
 		 * This only happens if image is somehow faulty so we start
-- 
2.43.0.472.g3155946c3a-goog

