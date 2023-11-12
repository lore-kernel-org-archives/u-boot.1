Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8238DC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7EA0871BE;
	Sun, 12 Nov 2023 21:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kEtaHQHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C32870E6; Sun, 12 Nov 2023 21:03:08 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B449886BF7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-357cc880bd8so15501675ab.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819381; x=1700424181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRnluPrqK3qxn3XA/yjym+u/YXlOpSecEW3jDGNdXIQ=;
 b=kEtaHQHCPRKhnKKqMSTayG1JrgYOUrfyKVy7X0UGvQAMlTYQvQ/+Sfkl9bgiUokQ5L
 lRFBvkO3KSeNkgkvWhVUpX1LhyRJxyOSlaUEkp+funqehELJlfOxYfwXlzTdz4mOETXY
 ulS4kKRfoRaNz6Qu5ftp7/26winhR3c3mBd7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819381; x=1700424181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRnluPrqK3qxn3XA/yjym+u/YXlOpSecEW3jDGNdXIQ=;
 b=tqapN9YPCxhFmwJsVtKpYgDv+/809gsa/JoR48eUcxgl1lZYuKmiBXklIgGnP/IqKC
 8AxH8QooyzBFQ6Br4wY44Zx9AS2e0hczz8LGaLfkSAXFyNvUMH2mPPCcBRq/dJaiIboS
 sHe+VhCM+5VMIoRKQiEX+0BWT/RVYnDqL2+K5+RHPGPiNoh7UCH+vW8+9QCun8PHPQmx
 SORI9SAZSlmQuOCTq+pAFEzyHOU117PWTC/xGV/pDLczZxxX5eIk6nq3ivgWZHI4xUOS
 bcotMY0GVxdIQtZhqR15O+iubSKhmG5LtZQ+FxwhDbfObtkQhC39G+0Dvk6T+T75AZo2
 WUow==
X-Gm-Message-State: AOJu0YyjTHDenTKZ38D5vjiQKbixKpGYL966IDmXTdGpxMwpRawdzAvy
 0kMVaGHloXQcQuWkDbWQpQh/ti2PgLu0Ysgp0ZGACQ==
X-Google-Smtp-Source: AGHT+IHslVSEKNdoJfefwJn9OcknDn9X44XI8f7yPUi6JmQfxKhRyekaFQ+Z2JSLL1ZvV4WYhsXEXQ==
X-Received: by 2002:a05:6e02:19cb:b0:359:5389:c0dc with SMTP id
 r11-20020a056e0219cb00b003595389c0dcmr7843163ill.7.1699819381238; 
 Sun, 12 Nov 2023 12:03:01 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/12] bootstd: Refactor mmc prep to allow a different scan
Date: Sun, 12 Nov 2023 13:02:39 -0700
Message-ID: <20231112200255.172351-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

