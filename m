Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE6C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA0C88B68;
	Thu, 15 Aug 2024 22:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RWa5YNs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC15E88B52; Thu, 15 Aug 2024 22:25:51 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503C2889F8
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81fd9251d99so50934939f.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753547; x=1724358347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak8OpDqo0cB5My6CyHNGgaMHsy/FXCNcxcdaBj6scSk=;
 b=RWa5YNs43vyJyJeAyioaaMPpiDl4+Sa4QWhFNMIEe+m9N7C5vaa5TvmYdqtVBZWFg6
 vzSfluaXkJ57aYdiC6uhz8sEOqBSiYVTlxjZWN6CUGtltySzPl8VQn2TsMVjfZ6oWfUm
 P/TkT4M3fbkjBGwDvTcl7+mpOqSW34e9SkqFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753547; x=1724358347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak8OpDqo0cB5My6CyHNGgaMHsy/FXCNcxcdaBj6scSk=;
 b=L8EohwnNPxhU1tQX/+pwU9wMLpPi6+MM8fjI6H8PRVBBIbdO7NJbFp7NMnfuU3K3Kc
 dcnCByMsuV1xLrGJGgva9llaCk1LXB0tv1dUnijPwqEnxF4gqVUzGjnUdH3eKDSKJGQx
 FWa1em0oUI7cxSHq6Z13S6PaYmNOoAhC+dCWfeISBICg4cE+045OyRxlRiaZlhVko8aB
 je8b4Ml01OroQT7ePqF2ixE7YanzqlsDK7DapKSNsBjdHyHNbSeklp3zHdd39EOmSflX
 AHMvhJ58hqjQDZYAlSP9NiYJJeWAeHi4ZtLWzrTN0AkumUgl+YJ1FzXcIceFg03zZCzV
 jR5A==
X-Gm-Message-State: AOJu0YwM4ADgQrft0TQgwb9S6HGMRzYbL2rq71ff/gA1YyUGh3DTGjDg
 p720nRHHOD39roBYv5a1DCPjJff3yNYv+qiU7Jl1uDsYHZeA+aSQAWzyH6YtFBieKdby1Th9it6
 bYA==
X-Google-Smtp-Source: AGHT+IGAQtqxB+xiMjiA2760Usqeh5S8EG1unq7fVb2PQhZ12inSLB7r2WHFNmlbSEIieg2mot8b4g==
X-Received: by 2002:a05:6e02:1ca3:b0:375:e04f:55ac with SMTP id
 e9e14a558f8ab-39d26d0c7fdmr13904725ab.16.1723753546866; 
 Thu, 15 Aug 2024 13:25:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/24] bootstd: Create a function to reset USB
Date: Thu, 15 Aug 2024 14:25:17 -0600
Message-Id: <20240815202535.767869-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

