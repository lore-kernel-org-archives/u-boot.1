Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED9BC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CA2888C2;
	Sun, 11 Aug 2024 16:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mxc5RS4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCA6887E8; Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903B88885E
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39b3e12754eso11984715ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387956; x=1723992756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak8OpDqo0cB5My6CyHNGgaMHsy/FXCNcxcdaBj6scSk=;
 b=Mxc5RS4twBeHvGULF92Tq7laiNGRYRPETBSJrcjq4VWUiZMrNhxdSoBlEL1CkAOqah
 tZKGbnU0jus+Fll+WCtgibtKRQDBkTvC8qqQI58dbMF01cXQ8F/DuI32vClR02gMtABD
 BC+7Uw+iFARet9MuSyhRL9+iPWx7ZOyorYFN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387956; x=1723992756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak8OpDqo0cB5My6CyHNGgaMHsy/FXCNcxcdaBj6scSk=;
 b=FySbU4RlWXuQfpfOfcsS0OxCJtOimqVJSJG9JjWEnlr5Db5YgBxJD+jZBtYa+lM4P4
 iiNR+8kGJjd7pJ12F8ESTV83j5UqiwFVkCT1DVVruwZdBXIupRp/587zT6Rfx2ZjO98B
 GXDyrjm27HVcxwfqjN6ye6S9674Ntmz5sCUxFAtv7bqUqoTNxozKqDwXAButE6YKN/E1
 +70YQLI0zQBoq1L9Q37Ls/R8cKPlrLlhkQCVf1+iwDSF1CcvbvlWsvKB5eOFKLI1vDIX
 g4rSBxq7L3WLtT5uN3YzmdKh/f01Y0p0WTEACdwU39czy85xl950MdP/7yAMXYwJwKeY
 XKvg==
X-Gm-Message-State: AOJu0Yz6XnJRyDBNui39rXAmMtU7rsOuiF9KdpeMo8xEZ6DA8DAnFmvP
 3oZTVwyyiLxDFNAqoZ3eNVKUE5Nob1lCWSTHoqf+CVwiuBM9aunYhgA4NFcDViGY1TKYhbJX0Fo
 =
X-Google-Smtp-Source: AGHT+IFpyKwAQ5dYYbdFwTaKrHT+aLKBIp1gY+RBPcn2HOgwJwJqZ0XrwEOHLMSpxBVFoXXBtm0DuA==
X-Received: by 2002:a05:6e02:1e0a:b0:39b:211f:7bb6 with SMTP id
 e9e14a558f8ab-39b81331bf7mr75390585ab.7.1723387956149; 
 Sun, 11 Aug 2024 07:52:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/40] bootstd: Create a function to reset USB
Date: Sun, 11 Aug 2024 08:51:35 -0600
Message-Id: <20240811145209.4191404-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Set up a function for this, since it needs to be used from multiple test
files.

This test file is only used on sandbox, where USB is enabled, so drop
the local declaration of usb_started

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Include the usb.h header file in all cases

 test/boot/bootdev.c        | 19 ++++++-------------
 test/boot/bootstd_common.c |  6 ++++++
 test/boot/bootstd_common.h |  8 ++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 1bf5929c396..de16a51956d 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -16,13 +16,6 @@
 #include <test/ut.h>
 #include "bootstd_common.h"
 
-/* Allow reseting the USB-started flag */
-#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
-extern bool usb_started;
-#else
-#include <usb.h>
-#endif
-
 /* Check 'bootdev list' command */
 static int bootdev_test_cmd_list(struct unit_test_state *uts)
 {
@@ -201,7 +194,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	test_set_skip_delays(true);
 
 	/* Start up USB which gives us three additional bootdevs */
-	usb_started = false;
+	bootstd_reset_usb();
 	ut_assertok(run_command("usb start", 0));
 
 	/*
@@ -317,7 +310,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	test_set_eth_enable(false);
 
 	/* Start up USB which gives us three additional bootdevs */
-	usb_started = false;
+	bootstd_reset_usb();
 	ut_assertok(run_command("usb start", 0));
 
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
@@ -357,7 +350,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 {
 	struct bootstd_priv *std;
 
-	usb_started = false;
+	bootstd_reset_usb();
 	test_set_skip_delays(true);
 
 	/* get access to the used hunters */
@@ -398,7 +391,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	struct bootstd_priv *std;
 
 	test_set_skip_delays(true);
-	usb_started = false;
+	bootstd_reset_usb();
 
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
@@ -527,7 +520,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 /* Check hunting for bootdev of a particular priority */
 static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 {
-	usb_started = false;
+	bootstd_reset_usb();
 	test_set_skip_delays(true);
 
 	console_record_reset_enable();
@@ -556,7 +549,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	struct bootstd_priv *std;
 	int mflags;
 
-	usb_started = false;
+	bootstd_reset_usb();
 
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index e50539500a0..ff8ed2303b3 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <memalign.h>
 #include <mmc.h>
+#include <usb.h>
 #include <linux/log2.h>
 #include <test/suites.h>
 #include <test/ut.h>
@@ -88,6 +89,11 @@ int bootstd_test_check_mmc_hunter(struct unit_test_state *uts)
 	return 0;
 }
 
+void bootstd_reset_usb(void)
+{
+	usb_started = false;
+}
+
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd_test);
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index 4a126e43ff4..e29036c897c 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -53,4 +53,12 @@ int bootstd_setup_for_tests(void);
  */
 int bootstd_test_check_mmc_hunter(struct unit_test_state *uts);
 
+/**
+ * bootstd_reset_usb() - Reset the USB subsystem
+ *
+ * Resets USB so that it can be started (and scanning) again. This is useful in
+ * tests which need to use USB.
+ */
+void bootstd_reset_usb(void);
+
 #endif
-- 
2.34.1

