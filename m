Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C779C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55EF88811A;
	Tue,  6 Aug 2024 14:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l7nQsioN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C28B88A29; Tue,  6 Aug 2024 14:59:28 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DA988A29
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so17368239f.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949164; x=1723553964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5227moHnIG/HQTOiRb822LPfqQBpeXc3svmB08+Lx0=;
 b=l7nQsioNvoWzl4zGqdIVI0exP31REXIXa4yfRxA8PeEv4LkvdMDW/d1meZSgGdO1iK
 4KoF+D6MZoXpp/cQAZRKlhK3Yxi092y1+kPJNIWyBcsWTtwUJykVqJ7BTHzud0eGSiDj
 PjIHu9khPje7ueQLpDqydoWWBQgGnOS7YrnjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949164; x=1723553964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5227moHnIG/HQTOiRb822LPfqQBpeXc3svmB08+Lx0=;
 b=Qq/E98A86kCmlTP2Fj6PiOjbmaXx0dVZn2NWXoUtFY2v1f41VcPfS0LZSH0+i4GOX/
 8FRVsBIMFnYgINSPmY5j/4sODE/jkVfRf/1Lrftwqgnp1ZFqU0VXXCvN4RTyZHeK25Bz
 k5MhJ6DxuYBnX8lxHH7bW0RwvLklH2NAikx0nFZPoAf+PRi+oqWoT7oN+zHg3voyAT3I
 hXPdlB9Kny5o7h4mZT9r6ssnTpySrWIefXAak+RylhJw4LDh5DX4yeCkXwTgs//m8Ssk
 yX7WnNU12YfI+all4Qq0Ie4KBK1/U8Q9LAIp5eBvhROgghhOX6y4iEXJOYMBp5xeZOBp
 6Clg==
X-Gm-Message-State: AOJu0YzqXlyvyh/hK/Z3pwJDZoUq1HQwVlHpmRiPdBWNjj1q9+57tGzK
 SwZns1XTzIAfQlFOMkqeXIqre0k5Bt2AHMBzA1pDvnZvcpDzbB2UFAGhwoYEOV2I0iKYlM4bt58
 =
X-Google-Smtp-Source: AGHT+IGG8Z6hdIAe6NHebqM66Xt7PXH46X9n1MDcwKoj7XG766NTEMI74pINIWBsmyBA9ITuxViM/A==
X-Received: by 2002:a05:6e02:1a47:b0:375:a205:86a6 with SMTP id
 e9e14a558f8ab-39b1fc1b3e7mr181450335ab.17.1722949163969; 
 Tue, 06 Aug 2024 05:59:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 06/39] bootstd: Create a function to reset USB
Date: Tue,  6 Aug 2024 06:58:17 -0600
Message-Id: <20240806125850.2316956-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootdev.c        | 19 ++++++-------------
 test/boot/bootstd_common.c | 12 ++++++++++++
 test/boot/bootstd_common.h |  8 ++++++++
 3 files changed, 26 insertions(+), 13 deletions(-)

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
index e50539500a0..ff0aff4bbe7 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -20,6 +20,13 @@
 /* tracks whether bootstd_setup_for_tests() has been run yet */
 bool vbe_setup_done;
 
+/* Allow resetting the USB-started flag */
+#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
+extern bool usb_started;
+#else
+#include <usb.h>
+#endif
+
 /* set up MMC for VBE tests */
 int bootstd_setup_for_tests(void)
 {
@@ -88,6 +95,11 @@ int bootstd_test_check_mmc_hunter(struct unit_test_state *uts)
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

