Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C3FE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7E0871E2;
	Mon,  2 Oct 2023 03:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJVj1pyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3DD87190; Mon,  2 Oct 2023 03:15:41 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8723B8713B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fe6da0095so275329239f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209296; x=1696814096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwdWE0+TkNH6FF7p8cH6h6RceXqiqf2hfh/c6jTIxI0=;
 b=CJVj1pyM+83OA2hRQd/5AdCYDMjeC9Voy95r8x4adDHC0anMUQZr4AJKoWPRCXWXL4
 kop814F2UZKV2QGyqEDGSpEvHL5sTYYU7zDGOnUdmOwj/ID0o7YU1pNaEjhR/UmJi084
 L8m0e4NCj/0NGI9B3CEjQ3W0apZsyjsD4btAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209296; x=1696814096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwdWE0+TkNH6FF7p8cH6h6RceXqiqf2hfh/c6jTIxI0=;
 b=VlB3PcQ7tib7GgCrZsEVfV7/Vk5Pwc3RSHYqyTu6YxfoTePPRGn8Psj8vk4DnJi+Sk
 ZQc+95aDiAPiCzLAsLaejVcgeBrAdhVFj2RlHXrSkrLiP6A3ReYOgPfIxp7V/sdYJ/pP
 82KQfvmkoxpdWkmSKHLOIiDNa9ujyesJ0lhfx5ylZfEquWOVkEDPkmxFdeb6ci4x86zW
 bWJ//TMLVlHm0yw0SgIgxnaY9IFjwPSBzZPoEL/99Sq5WuLgsjS51rw3cjdJfJCipj+i
 JcrWm72hGqVGJc0WFrkdeZqCUmGuVgohUmTAJnqwKwhADvETJ901NiBT+zxEZLC3gFEd
 24YQ==
X-Gm-Message-State: AOJu0YzMqEXNySySQl22Jrk0nEU63RxWRVZmzp41PPdREbr5vZyWBRts
 q7qTrvpepxYilIZUVrAqPHFybr9b7WZEVt5aivQ=
X-Google-Smtp-Source: AGHT+IGiyWo9EwNkIf64BfAbqY6WoioLFfwIQP0tgalNTq410BGpAI1m89XlUsGUHOa/42p7gLRYoQ==
X-Received: by 2002:a6b:7314:0:b0:79f:d04d:ce59 with SMTP id
 e20-20020a6b7314000000b0079fd04dce59mr11273328ioh.6.1696209296340; 
 Sun, 01 Oct 2023 18:14:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/12] bootstd: Refactor mmc prep to allow a different scan
Date: Sun,  1 Oct 2023 19:14:37 -0600
Message-ID: <20231002011450.462468-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Changes in v3:
- Add new patch to refactor mmc prep to allow a different scan

 test/boot/bootflow.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f5b2059140ac..0a992e2bcc14 100644
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
@@ -976,7 +1007,7 @@ BOOTSTD_TEST(bootflow_cmdline, 0);
 /* Test ChromiumOS bootmeth */
 static int bootflow_cros(struct unit_test_state *uts)
 {
-	ut_assertok(prep_mmc_bootdev(uts, "mmc5", true));
+	ut_assertok(scan_mmc_bootdev(uts, "mmc5", true));
 	ut_assertok(run_command("bootflow list", 0));
 
 	ut_assert_nextlinen("Showing all");
-- 
2.42.0.582.g8ccd20d70d-goog

