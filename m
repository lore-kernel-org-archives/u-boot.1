Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81583C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37704874A5;
	Sun, 19 Nov 2023 20:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="akQKen/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F65871B2; Sun, 19 Nov 2023 20:12:26 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C938749F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35930447ae9so11541515ab.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421133; x=1701025933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRWk81JcMvP7cgeud20z4e5gp032PBZXA4Jarr//M+E=;
 b=akQKen/FIRPaSDqsuwivArtBduppWdMDYYtujaDLsSu3IEFnR88/rloDsP8as16JpE
 Xdzw4uwuEHXNcDhlhg+VfHudKnXd+6Fa/7TwhBDj8pgebjnrpDIqwqDnlLFMG7KKHwx+
 IT1R9qOkEHkiIwbDcjMp8R4PHwHJo3fBoDlY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421133; x=1701025933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRWk81JcMvP7cgeud20z4e5gp032PBZXA4Jarr//M+E=;
 b=q4sY3paG++FTJpuS5yA0yDFeqsgPz8WoFhefNwknTz/UPT4jDHx2kPMQZcOrE90FEG
 pQ5ihpeyIzKLzEXbZUYBAzfb8T7ERgHyPqYVk/brkR9eYxOY1a+s/x0uvwaNFVmv76Rk
 ENuM1ZNTGHGvjOE2AeIM9h7Pi205Jmh7H6928mH9SmV1CLWxVPoHsnG4ujDP1OEXucod
 2Ngddlr6uU/rN+CXKWk34LL5fxPIQvNvlbANoB0CTj+WFdDmimwVCb0A7yC1uPRaa/wW
 LjR0BNZDgvH6SYT9KuKFzrnpmB5u83KuqpQFvwYmQyN0PgL8vE00fMN6aOzm9q20hHQw
 XP3w==
X-Gm-Message-State: AOJu0YxwqEb4nSqlpdmQ1b6+x0V5ZOsIprDbDzSRQeTmz0wEjjxPveTM
 zJMImFACaaIDnHMQ5BOu2B6Z4y73e6AVCXOWHfPp1g==
X-Google-Smtp-Source: AGHT+IHfNUzcHDk8BpoTc2ui4E2lwfG6PplHz+r8YKCkpKQTtRHp0FNh5LdVJfFRd/1A4r/LND/7RA==
X-Received: by 2002:a92:c6c1:0:b0:359:554:790f with SMTP id
 v1-20020a92c6c1000000b003590554790fmr6676819ilm.2.1700421132731; 
 Sun, 19 Nov 2023 11:12:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/12] bootstd: Refactor mmc prep to allow a different scan
Date: Sun, 19 Nov 2023 12:11:37 -0700
Message-ID: <20231119191202.667180-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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

Adjust scan_mmc4_bootdev() and related function so that the caller can
do its own 'bootflow scan' command. This allows it to change the flags
if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to refactor mmc prep to allow a different scan

 test/boot/bootflow.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f640db8a2418..102b2b561356 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -511,19 +511,27 @@ BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
  *
+ * After calling this function, set std->bootdev_order to *@old_orderp to
+ * restore normal operation of bootstd (i.e. with the original bootdev order)
+ *
  * @uts: Unit test state
- * @mmc_dev: MMC device to use, e.g. "mmc4"
+ * @mmc_dev: MMC device to use, e.g. "mmc4". Note that this must remain valid
+ *	in the caller until
+ * @bind_cros: true to bind the ChromiumOS bootmeth
+ * @old_orderp: Returns the original bootdev order, which must be restored
  * Returns 0 on success, -ve on failure
  */
 static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
-			    bool bind_cros)
+			    bool bind_cros, const char ***old_orderp)
 {
-	const char *order[] = {"mmc2", "mmc1", mmc_dev, NULL};
+	static const char *order[] = {"mmc2", "mmc1", NULL, NULL};
 	struct udevice *dev, *bootstd;
 	struct bootstd_priv *std;
 	const char **old_order;
 	ofnode root, node;
 
+	order[2] = mmc_dev;
+
 	/* Enable the mmc4 node since we need a second bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
@@ -546,26 +554,49 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
 	std->bootdev_order = order;
+	*old_orderp = old_order;
+
+	return 0;
+}
+
+/**
+ * scan_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
+ *
+ * @uts: Unit test state
+ * @mmc_dev: MMC device to use, e.g. "mmc4"
+ * @bind_cros: true to bind the ChromiumOS bootmeth
+ * Returns 0 on success, -ve on failure
+ */
+static int scan_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
+			    bool bind_cros)
+{
+	struct bootstd_priv *std;
+	struct udevice *bootstd;
+	const char **old_order;
+
+	ut_assertok(prep_mmc_bootdev(uts, mmc_dev, bind_cros, &old_order));
 
 	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_console_end();
 
 	/* Restore the order used by the device tree */
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	std = dev_get_priv(bootstd);
 	std->bootdev_order = old_order;
 
 	return 0;
 }
 
 /**
- * prep_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
+ * scan_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
  *
  * @uts: Unit test state
  * Returns 0 on success, -ve on failure
  */
-static int prep_mmc4_bootdev(struct unit_test_state *uts)
+static int scan_mmc4_bootdev(struct unit_test_state *uts)
 {
-	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false));
+	ut_assertok(scan_mmc_bootdev(uts, "mmc4", false));
 
 	return 0;
 }
@@ -575,7 +606,7 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 {
 	char prev[3];
 
-	ut_assertok(prep_mmc4_bootdev(uts));
+	ut_assertok(scan_mmc4_bootdev(uts));
 
 	/* Add keypresses to move to and select the second one in the list */
 	prev[0] = CTL_CH('n');
@@ -681,7 +712,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	ofnode node;
 	int i;
 
-	ut_assertok(prep_mmc4_bootdev(uts));
+	ut_assertok(scan_mmc4_bootdev(uts));
 
 	ut_assertok(bootflow_menu_new(&exp));
 	node = ofnode_path("/bootstd/theme");
@@ -996,7 +1027,7 @@ BOOTSTD_TEST(bootflow_cmdline_special, 0);
 /* Test ChromiumOS bootmeth */
 static int bootflow_cros(struct unit_test_state *uts)
 {
-	ut_assertok(prep_mmc_bootdev(uts, "mmc5", true));
+	ut_assertok(scan_mmc_bootdev(uts, "mmc5", true));
 	ut_assertok(run_command("bootflow list", 0));
 
 	ut_assert_nextlinen("Showing all");
-- 
2.43.0.rc0.421.g78406f8d94-goog

