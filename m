Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D46AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA2687B8B;
	Fri, 15 Dec 2023 05:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hohR8OSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4F887B6A; Fri, 15 Dec 2023 05:19:38 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9F087AD1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b9dd6886e2so109962b6e.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613974; x=1703218774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0RzbjzOULkTTFF36MFTHhir+s3O/lVyPIfG8L9l6rw=;
 b=hohR8OSmulrvN0Am4os6qqkW9LicTPhJMV4G5YYjyt+1W12OcwEOo7YucEv89Pka6z
 8s1u7qpEKOpRfMHnCkAR0FZ8xrJ5wAbcTzJ9zQzmsKxH0ehOzI/SZpAXDEHzDgxbmKHx
 tKJYo3OaOCKuFKE62SIGBRMeGWm9jPB5C2Hk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613974; x=1703218774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0RzbjzOULkTTFF36MFTHhir+s3O/lVyPIfG8L9l6rw=;
 b=AvniUtI5bzQ84dqB5NjKP2dIHV21z+Y3lVO+X9iAuUcGZYTy7RmprZX2vtIf/32c1o
 qC3e/E14nVnc6CCfLTQSgYMSWShEcfAlSyIeHJt/eUmqBOSxjdJ+xmyGYtgUdgdRuSqj
 i25GGpMVhbdrSBciyZ86Xu3ii2Y50YCqdJpt7kRP/741I/wzQkbCoi22fdqWWm0i+ltl
 HzgUJep1Dnhe5sLTreKdMae2FWzV30pbD1Vu1VyzucSXbuoO16osYUBCu9VekctKSVNY
 Q+2MeGiPG3iYT7KY8QbkSeAclo4X8kb04Gzo+ABHUzIw42Bog4dcmPZ+bklk9RVQVL+7
 AMeA==
X-Gm-Message-State: AOJu0YwwlwUdDaOIZHSj07XVKtDVMLyxGyKKW4JEoJf1ruqkUKWnq1ha
 hOGrrOTN6UVHs7PHKdb9adnLOVh4ueQijJNBRl0iRA==
X-Google-Smtp-Source: AGHT+IGX+nsm6odblELmJYydfIBEBW/GDiI0/+b27bI9G5ITMnB11Cjb9coET38/EYyab0PV7ufdWw==
X-Received: by 2002:a05:6808:398d:b0:3b8:b645:a879 with SMTP id
 gq13-20020a056808398d00b003b8b645a879mr10277819oib.86.1702613974019; 
 Thu, 14 Dec 2023 20:19:34 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alex Kiernan <alex.kiernan@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 08/16] fastboot: Remove dependencies on CMDLINE
Date: Thu, 14 Dec 2023 21:19:06 -0700
Message-ID: <20231215041919.2197788-8-sjg@chromium.org>
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

It is possible to boot a kernel without CMDLINE being enabled. Update
the implementation to handle this, and drop the condition from the
FASTBOOT config.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Avoid changing the logic when a command is not set

 drivers/fastboot/Kconfig     |  1 -
 drivers/fastboot/fb_common.c | 30 ++++++++++++++----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 11fc0fe1c800..837c6f1180da 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,4 @@
 menu "Fastboot support"
-	depends on CMDLINE
 
 config FASTBOOT
 	bool
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

