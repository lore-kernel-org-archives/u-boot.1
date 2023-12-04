Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED57AC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8239D878E7;
	Mon,  4 Dec 2023 01:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aem957XA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95292878E5; Mon,  4 Dec 2023 01:33:00 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7688A878E6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c659db0ce2so1256529a12.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649976; x=1702254776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GO1NMakYUdQa5DASKz57N68P2KnCRDBnV3W988RpUeg=;
 b=aem957XAGsyY9Luaq9kmRaFlYjxwxqZULJFEXfWSAxR+LodU6/d+FNH3SEBGJly44a
 IpvLWqX/s+yS+oODwUTeqN74lgbbFPsY0UKi1ZGuUgmpN12r8k8I774ekZtounkIG9xI
 d9VUnvHoo6Oa35V8lh8tSdkqHfgHCeXJVmkVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649976; x=1702254776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GO1NMakYUdQa5DASKz57N68P2KnCRDBnV3W988RpUeg=;
 b=YeC1klrOh4m6ggeywaovN4Nf3eFm7XVnVlpPtLtTQiSAtBk9ygcc+DrRdQCU3VSHKA
 m+EkYx3nRvrlyGbzm99vvEYm3JgBndLtnpFU2oXny2EkNd/icWaIbd99zGxKmFyelmLs
 rXfP0BicsJCzoBZg46OxGkl5wXjHBodpDCN/a4S9o8Ewoi557xhXh4DMIACcdtDDSbl5
 t0/Blb/KbybEWFUso9VXb9XnSBLhDiO35Ga1hiGw6UTDt9N71IMPgTScUtKII1N/szet
 wznTpix3nHpnGtS6ZUob5zUL6Gw5JHyCljIFsmcKCxftFbKbER9BsyvjB0lPqLDgwY5V
 L0Yg==
X-Gm-Message-State: AOJu0Yws0zCsb/Xls0a2UuSrv8UEhsmXS1fMDu6KaNGa8HNscnTUxMrL
 JRl41HFkn0jqhj4OyNsi3BeodQrJ2pgelvoCcoUl4A==
X-Google-Smtp-Source: AGHT+IEXLz740Tba0HtUOJjj9nyd8nCmZDluup2IoyQF6SYeLHsmjmSCdSFP6RdWwhhvPsHb7rnxuA==
X-Received: by 2002:a05:6a20:734c:b0:186:2389:a73e with SMTP id
 v12-20020a056a20734c00b001862389a73emr4321991pzc.55.1701649976696; 
 Sun, 03 Dec 2023 16:32:56 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 08/14] fastboot: Remove dependencies on CMDLINE
Date: Sun,  3 Dec 2023 17:31:32 -0700
Message-ID: <20231204003144.899097-8-sjg@chromium.org>
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

It is possible to boot a kernel without CMDLINE being enabled. Update
the implementation to handle this, and drop the condition from the
FASTBOOT config.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/fastboot/Kconfig     |  1 -
 drivers/fastboot/fb_common.c | 26 ++++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

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
index 07f5946d9ed1..85935380e79d 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -11,6 +11,7 @@
  */
 
 #include <bcb.h>
+#include <bootm.h>
 #include <common.h>
 #include <command.h>
 #include <env.h>
@@ -144,20 +145,17 @@ void fastboot_boot(void)
 {
 	char *s;
 
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
+	if (IS_ENABLED(CONFIG_CMDLINE)) {
+		s = env_get("fastboot_bootcmd");
+		if (s) {
+			run_command(s, CMD_FLAG_ENV);
+			return;
+		}
+	} else if (IS_ENABLED(CONFIG_BOOTM)) {
+		int ret;
+
+		printf("Booting kernel at %lx...\n\n\n", fastboot_buf_addr);
+		ret = bootm_boot_start(fastboot_buf_addr, NULL);
 
 		/*
 		 * This only happens if image is somehow faulty so we start
-- 
2.43.0.rc2.451.g8631bc7472-goog

