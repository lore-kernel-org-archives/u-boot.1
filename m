Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7DBC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1962486989;
	Thu, 24 Aug 2023 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WNcmnIdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F7F869BB; Thu, 24 Aug 2023 21:56:18 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB87D868D0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so7682439f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906973; x=1693511773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4E+k4syGTl6LA2bpddi29NsumVV2dDxe3kUka0h370=;
 b=WNcmnIdXVoSZw0tE2nKkn+mfCN+h0WI1FH8XppHKVopO8CVoxJ4V+7bYYRp25YgIr2
 QGUVlA+3nZhyRQEfzNYFuNfyPfnoPsa0C6ONUPO8GKtZzKicE5cnenIX8oBYyPEmlhj0
 p9Jig0RuvOtIFGK6UvJ40rYV9S6L/R2d367PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906973; x=1693511773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4E+k4syGTl6LA2bpddi29NsumVV2dDxe3kUka0h370=;
 b=elVTgdGwUFR9d1XpMaQkx1PtT+jLix1VvBOpQobKZ5BN7W7ysgLCC4CLD5J3AQ7CD4
 T7g95bzPcMo5ozF9fq0qjAeuSE5s8mh6f7KcV3TKM9rZoZn2FTTggOq1/kO6M3572ees
 SU4VeSCey0lqWY1Lxe7IAu7P9cWLOcjsCXwnLiC0eLJ1y8wJ/hHGeEb2LKhOhi84qis7
 SL+/VywrfSv/6o9DnHAn9ldDUvOjhMTtZHwIrYkCRygVTnhqnEQmexWG0p+MWV8QCVk9
 PiRvu6ElDglF/KITNPyUMhHU2HnhVqU9nweJofvDqkjaW+dze72D0VijDudrQVizPdJo
 BcZg==
X-Gm-Message-State: AOJu0Yx+yiNYccKbeI1QmIFWL2ymtEsXwyI2RZFePQGVBSgczLHR7NtE
 3L0s7523zVWVEFPkAhc9Du6peAx1HLzP7zb4slE=
X-Google-Smtp-Source: AGHT+IH7zjbircfQ44yOMW0nqMeZkPWw/baWBi+m13E0QmNrunMTeuiSJUeN5Gi0uV0tfaB+6FgPSQ==
X-Received: by 2002:a5e:dd06:0:b0:790:e92d:400b with SMTP id
 t6-20020a5edd06000000b00790e92d400bmr7328348iop.4.1692906973322; 
 Thu, 24 Aug 2023 12:56:13 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/23] bootstd: test: Allow binding and using any mmc device
Date: Thu, 24 Aug 2023 13:55:40 -0600
Message-ID: <20230824195553.1685996-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

We currently use mmc4 for tests. Update the function which sets this up
so that it can handle any device.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 649237a9e229..54a878c4bd5d 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -508,21 +508,24 @@ static int bootflow_cmd_boot(struct unit_test_state *uts)
 BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 
 /**
- * prep_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
+ * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
  *
  * @uts: Unit test state
+ * @mmc_dev: MMC device to use, e.g. "mmc4"
  * Returns 0 on success, -ve on failure
  */
-static int prep_mmc4_bootdev(struct unit_test_state *uts)
+static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev)
 {
-	static const char *order[] = {"mmc2", "mmc1", "mmc4", NULL};
+	const char *order[] = {"mmc2", "mmc1", mmc_dev, NULL};
 	struct udevice *dev, *bootstd;
 	struct bootstd_priv *std;
 	const char **old_order;
-	ofnode node;
+	ofnode root, node;
 
 	/* Enable the mmc4 node since we need a second bootflow */
-	node = ofnode_path("/mmc4");
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc_dev);
+	ut_assert(ofnode_valid(node));
 	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
 
 	/* Enable the script bootmeth too */
@@ -530,7 +533,7 @@ static int prep_mmc4_bootdev(struct unit_test_state *uts)
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_script),
 				"bootmeth_script", 0, ofnode_null(), &dev));
 
-	/* Change the order to include mmc4 */
+	/* Change the order to include the device */
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
 	std->bootdev_order = order;
@@ -545,6 +548,19 @@ static int prep_mmc4_bootdev(struct unit_test_state *uts)
 	return 0;
 }
 
+/**
+ * prep_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
+ *
+ * @uts: Unit test state
+ * Returns 0 on success, -ve on failure
+ */
+static int prep_mmc4_bootdev(struct unit_test_state *uts)
+{
+	ut_assertok(prep_mmc_bootdev(uts, "mmc4"));
+
+	return 0;
+}
+
 /* Check 'bootflow menu' to select a bootflow */
 static int bootflow_cmd_menu(struct unit_test_state *uts)
 {
-- 
2.42.0.rc1.204.g551eb34607-goog

