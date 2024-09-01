Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF2C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5913088AAC;
	Mon,  2 Sep 2024 00:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eom+0nd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4C088B63; Mon,  2 Sep 2024 00:26:56 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48D988AC2
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82a274dd17eso111695039f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229611; x=1725834411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BurNBGCa98gJV67c4R8po8E5fi+F9IQNLPVEwsoM5V0=;
 b=Eom+0nd8dFmKoq/2YgugQHJT/1D4fap0IyeH0+cee405zKD8I7SvCk9tdnXWE3LRWg
 Lm65HOrdYNlxlPbBZEzaFytpxa9R5H+HVs3Y/RsGbLcl+ulY817MSCBVrNK+sTB0/NVF
 qzwCcGAyxF3vEVVa0Y8fS34ekGnHXm5Lq7ZkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229611; x=1725834411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BurNBGCa98gJV67c4R8po8E5fi+F9IQNLPVEwsoM5V0=;
 b=wtYfsUyXCjEjJWE3H5f/JhUvVrqasReyC5iwXMqQ0HDS0Of/MlmZUV8I/Lf4lLRk5S
 vpjKyM7dAdgir46yNl0CNJ9NUyo4Lf8h2HvdCyfYpiEelpYoV2qoUDFx6ShbPAg3Lj1+
 gaVf0aowVfEZ6pBXfW9H/423oYQlUPUlz//6FK8i+jhRyjZSyJK104b+hOwOaYt5zg0X
 RlEMl6VYK/DOoUtCE9qcOMlWbuXZ3juV61p7g9bdtb+VzB/WgsJ+naCihKrcBxDdIdL5
 E5WR1ReBICX64uW6g7aD7dhKhivFC0RaySfZXlvgtJrAmrv7CXQZn09JmHivTUDSojQC
 XDbg==
X-Gm-Message-State: AOJu0YxQgkINVYzxw3nVAs6FWKZih2Cpsd5/AVpn57eNuI7wwRiOAV/N
 tZJjLAGORpWmvRQ86q1QJ4P7dDl7BKBY5Ng0KPAf6Naep+9ofXuXRN/1Gui+NtdI3gz3+E4JloQ
 =
X-Google-Smtp-Source: AGHT+IETYEvtDZQR1xJ7NbtVKnfv2Gs246AuAocg5FBWCOz6mFgpCiLLDGHfKBnL6fQ9qb38fxZKsA==
X-Received: by 2002:a05:6602:6b0c:b0:82a:48fa:b8d7 with SMTP id
 ca18e2360f4ac-82a48faba70mr277740439f.17.1725229611320; 
 Sun, 01 Sep 2024 15:26:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/23] bootstd: Create a function to reset USB
Date: Sun,  1 Sep 2024 16:26:16 -0600
Message-Id: <20240901222634.460873-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Include the usb.h header file in all cases

 test/boot/bootdev.c        | 19 ++++++-------------
 test/boot/bootstd_common.c |  6 ++++++
 test/boot/bootstd_common.h |  8 ++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 23ebc61ff52..c635d06ec25 100644
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
@@ -197,7 +190,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	test_set_skip_delays(true);
 
 	/* Start up USB which gives us three additional bootdevs */
-	usb_started = false;
+	bootstd_reset_usb();
 	ut_assertok(run_command("usb start", 0));
 
 	/*
@@ -313,7 +306,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	test_set_eth_enable(false);
 
 	/* Start up USB which gives us three additional bootdevs */
-	usb_started = false;
+	bootstd_reset_usb();
 	ut_assertok(run_command("usb start", 0));
 
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
@@ -352,7 +345,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 {
 	struct bootstd_priv *std;
 
-	usb_started = false;
+	bootstd_reset_usb();
 	test_set_skip_delays(true);
 
 	/* get access to the used hunters */
@@ -392,7 +385,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	struct bootstd_priv *std;
 
 	test_set_skip_delays(true);
-	usb_started = false;
+	bootstd_reset_usb();
 
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
@@ -520,7 +513,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UTF_DM | UTF_SCAN_FDT);
 /* Check hunting for bootdev of a particular priority */
 static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 {
-	usb_started = false;
+	bootstd_reset_usb();
 	test_set_skip_delays(true);
 
 	ut_assertok(bootdev_hunt_prio(BOOTDEVP_4_SCAN_FAST, false));
@@ -548,7 +541,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
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

