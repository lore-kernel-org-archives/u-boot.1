Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E6C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4628320C;
	Wed, 16 Jul 2025 11:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GKmLg+Ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579FA831D7; Wed, 16 Jul 2025 11:58:44 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E64831D7
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so23675255e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752659920; x=1753264720; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9lS5JE/IEq09ejFbFsz69t8QCKr9jD6D0wkgvvkAXXs=;
 b=GKmLg+Ns+Hf3SojARQpNIBGjjnHIPDHeGjrpTtvCnocdcVcGmBKFhc6bdkvHrExAC6
 Ios7QG+zTOuUoGW/23oMfV77HAkaOMcFkRfyOGwIs4jo7+KiI72Y+xpIOn53vKEQ3s3V
 g5ajfnhFAM7n21w0OJBherpET5wGIV8FhFiOreKdTXDDJvScJqHoqjMq7+Ia5qCoCX4J
 50A3mNCYR04Cgjrir6y4+rXrPJFR24H5Qm+fmsF5xiN1pZk39gyauH0rPL0raH6sLSPj
 HlanG/zwF/E19gue3v8tkFelY8DZrgvNCumk0lKe0yDsewN05t38piakxKUkgKgYSu0t
 OjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752659920; x=1753264720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lS5JE/IEq09ejFbFsz69t8QCKr9jD6D0wkgvvkAXXs=;
 b=LpDXzALpdBm+W2ZRM6RAgE+fzuWV13R5Ql7/HyGRHpwGnrl3Tn/tnzMsMzG/a0/1sa
 QT8LVuFnKQaE3ms1jBCHl+lwgF8Cx83fRYDpsTSdVjtNM0XqD+83pRRHm4YLVqXDR7MG
 jtNy4Do/b3cYfyaNh/nKDnM3BfuUujA+tUpzpanb3U4XITNUbZjuO9M7OVEo1LbE9ps1
 RyckboEsuQQjanjTwvprVcNTLktmdB2tX+7Xbdumqp9YAy2/hUWXZuRIifNyHw3TcXaD
 NKs1rED0YZiYTUZs2dp6ssWG21GB0+SpCdrCoALWA9gHxPp4bGkkht8bBLdUiHhlHcjX
 QeiA==
X-Gm-Message-State: AOJu0Yx7QXkfVCe8fdjYTj4BVxmxu92lfl/tH7I8JzanOpy9rHb9YjKR
 /OtaKaIfcjfmEiB70hKXqOAIiIaN4Yuzua4yD9L6QI6WpNtjMXumESUreUdPeHLdzTN24chzKYj
 Rtt4/
X-Gm-Gg: ASbGnctDa/qy/i4YcWQe+3SKvxnALge/AubhH/XTI8+3KNye48SmOSZmeP73wNEgYyp
 +t36HxrGfq11DvMzY9897hbo/XJCae7+UDfxCxHrtbNuDcZsCGuNUxydG8wbXvqoE4fYfUX9Avz
 9gKQB4giQ7kU52eVQhsdr2GKnF0SqdjbPOE35l8GVWu313Mby/atq1STWFXU09qZ2L05sBIKbgO
 hvNV0dbt0zoGrvoyozd1/HpVCVHvwMAFnXXfKt+Z5y8CZ8SaGX4+tPS2JleeIeFYhw9/3rQwAkY
 Y+RgQ2AKQwac3h19R/RYVTz9YzlI0rq/Il/KxcyvbZMwEWLTpKwFbIxh/PP9JiGrKWFmBreHjar
 +0A0HnV0xRWfFO0fPlP9bAVX0ZOlpn4yc7Z3LYXCmVPuiT7PttA==
X-Google-Smtp-Source: AGHT+IFT93OUbs/9wdCJSMMAucQPet3BmGrT3RbqhIxMyMp0lQkIU7HD8BVEn51DKmtBdB9vP1H66Q==
X-Received: by 2002:a05:600c:8b27:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-4562e042dc3mr22745035e9.30.1752659920337; 
 Wed, 16 Jul 2025 02:58:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:d584:3606:6325:3ecd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm17395270f8f.36.2025.07.16.02.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 02:58:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 16 Jul 2025 10:58:39 +0100
Subject: [PATCH v3 2/2] uclass: Cleanup uclass_find_next_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-blk-uclass-v3-2-1fc761606df6@linaro.org>
References: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
In-Reply-To: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
To: Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

uclass_find_next_device always returns 0, so instead make it a void and
update calling sites.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 board/emulation/qemu-ppce500/qemu-ppce500.c |   4 +-
 boot/bootdev-uclass.c                       |   8 +-
 cmd/regulator.c                             |   8 +-
 drivers/core/uclass.c                       |  16 +---
 drivers/power/regulator/regulator-uclass.c  |  21 ++--
 drivers/remoteproc/rproc-uclass.c           |   9 +-
 include/dm/uclass-internal.h                |   4 +-
 test/dm/core.c                              | 143 +++++++++++-----------------
 8 files changed, 90 insertions(+), 123 deletions(-)

diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
index 40d295dbf06..58de4a05296 100644
--- a/board/emulation/qemu-ppce500/qemu-ppce500.c
+++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
@@ -170,9 +170,9 @@ int misc_init_r(void)
 	 * Detect the presence of the platform bus node, and
 	 * create a virtual memory mapping for it.
 	 */
-	for (ret = uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
+	for (uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		if (device_is_compatible(dev, "qemu,platform")) {
 			struct simple_bus_plat *plat = dev_get_uclass_plat(dev);
 
diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3791ebfcb42..3f8dc2c3c4e 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -213,10 +213,12 @@ void bootdev_list(bool probe)
 		       device_active(dev) ? '+' : ' ',
 		       ret ? simple_itoa(-ret) : "OK",
 		       dev_get_uclass_name(dev_get_parent(dev)), dev->name);
-		if (probe)
+		if (probe) {
 			ret = uclass_next_device_check(&dev);
-		else
-			ret = uclass_find_next_device(&dev);
+		} else {
+			uclass_find_next_device(&dev);
+			ret = 0;
+		}
 	}
 	printf("---  ------  ------  --------  ------------------\n");
 	printf("(%d bootdev%s)\n", i, i != 1 ? "s" : "");
diff --git a/cmd/regulator.c b/cmd/regulator.c
index da298090bb7..8d743c8d269 100644
--- a/cmd/regulator.c
+++ b/cmd/regulator.c
@@ -96,11 +96,11 @@ static int do_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	       LIMIT_OFNAME, LIMIT_OFNAME, "regulator-name",
 	       "Parent");
 
-	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret)
-			continue;
+	ret = uclass_find_first_device(UCLASS_REGULATOR, &dev);
+	if (ret)
+		return ret;
 
+	for (; dev; uclass_find_next_device(&dev)) {
 		uc_pdata = dev_get_uclass_plat(dev);
 		printf("| %-*.*s| %-*.*s| %s\n",
 		       LIMIT_DEVNAME, LIMIT_DEVNAME, dev->name,
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index ce5e61bbaa6..5365ac68f9e 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -261,17 +261,14 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp)
 	return 0;
 }
 
-int uclass_find_next_device(struct udevice **devp)
+void uclass_find_next_device(struct udevice **devp)
 {
 	struct udevice *dev = *devp;
 
 	*devp = NULL;
-	if (list_is_last(&dev->uclass_node, &dev->uclass->dev_head))
-		return 0;
-
-	*devp = list_entry(dev->uclass_node.next, struct udevice, uclass_node);
-
-	return 0;
+	if (!list_is_last(&dev->uclass_node, &dev->uclass->dev_head))
+		*devp = list_entry(dev->uclass_node.next, struct udevice,
+				   uclass_node);
 }
 
 int uclass_find_device_by_namelen(enum uclass_id id, const char *name, int len,
@@ -675,11 +672,8 @@ int uclass_first_device_check(enum uclass_id id, struct udevice **devp)
 
 int uclass_next_device_check(struct udevice **devp)
 {
-	int ret;
+	uclass_find_next_device(devp);
 
-	ret = uclass_find_next_device(devp);
-	if (ret)
-		return ret;
 	if (!*devp)
 		return 0;
 
diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 09567eb9dbb..2a59a1b79c2 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -260,13 +260,13 @@ int regulator_get_by_platname(const char *plat_name, struct udevice **devp)
 
 	*devp = NULL;
 
-	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret) {
-			dev_dbg(dev, "ret=%d\n", ret);
-			continue;
-		}
+	ret = uclass_find_first_device(UCLASS_REGULATOR, &dev);
+	if (ret) {
+		dev_dbg(dev, "ret=%d\n", ret);
+		return ret;
+	}
 
+	for (; dev; uclass_find_next_device(&dev)) {
 		uc_pdata = dev_get_uclass_plat(dev);
 		if (!uc_pdata || strcmp(plat_name, uc_pdata->name))
 			continue;
@@ -410,9 +410,12 @@ static bool regulator_name_is_unique(struct udevice *check_dev,
 	int ret;
 	int len;
 
-	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret || dev == check_dev)
+	ret = uclass_find_first_device(UCLASS_REGULATOR, &dev);
+	if (ret)
+		return true;
+
+	for (; dev; uclass_find_next_device(&dev)) {
+		if (dev == check_dev)
 			continue;
 
 		uc_pdata = dev_get_uclass_plat(dev);
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 3233ff80419..2dbd3a21cea 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -55,9 +55,12 @@ static int for_each_remoteproc_device(int (*fn) (struct udevice *dev,
 	struct dm_rproc_uclass_pdata *uc_pdata;
 	int ret;
 
-	for (ret = uclass_find_first_device(UCLASS_REMOTEPROC, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret || dev == skip_dev)
+	ret = uclass_find_first_device(UCLASS_REMOTEPROC, &dev);
+	if (ret)
+		return ret;
+
+	for (; dev; uclass_find_next_device(&dev)) {
+		if (dev == skip_dev)
 			continue;
 		uc_pdata = dev_get_uclass_plat(dev);
 		ret = fn(dev, uc_pdata, data);
diff --git a/include/dm/uclass-internal.h b/include/dm/uclass-internal.h
index 3ddcdd21439..9cb3f090271 100644
--- a/include/dm/uclass-internal.h
+++ b/include/dm/uclass-internal.h
@@ -149,10 +149,8 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp);
  *
  * The device is not prepared for use - this is an internal function.
  * The function uclass_get_device_tail() can be used to probe the device.
- *
- * Return: 0 if OK (found or not found), -ve on error
  */
-int uclass_find_next_device(struct udevice **devp);
+void uclass_find_next_device(struct udevice **devp);
 
 /**
  * uclass_find_device_by_namelen() - Find uclass device based on ID and name
diff --git a/test/dm/core.c b/test/dm/core.c
index 959b834576f..53693f4f7ed 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -167,8 +167,6 @@ static int dm_test_autobind_uclass_pdata_alloc(struct unit_test_state *uts)
 	for (uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
 	     uclass_find_next_device(&dev)) {
-		ut_assertnonnull(dev);
-
 		uc_pdata = dev_get_uclass_plat(dev);
 		ut_assert(uc_pdata);
 	}
@@ -223,8 +221,6 @@ static int dm_test_autobind_uclass_pdata_valid(struct unit_test_state *uts)
 	for (uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
 	     uclass_find_next_device(&dev)) {
-		ut_assertnonnull(dev);
-
 		uc_pdata = dev_get_uclass_plat(dev);
 		ut_assert(uc_pdata);
 		ut_assert(uc_pdata->intval1 == TEST_UC_PDATA_INTVAL1);
@@ -734,114 +730,90 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 
 	/* Re-parent top-level children with no grandchildren. */
 	ut_assertok(device_reparent(top[3], top[0]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_reparent(top[4], top[0]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	/* Re-parent top-level children with grandchildren. */
 	ut_assertok(device_reparent(top[2], top[0]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_reparent(top[5], top[2]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	/* Re-parent grandchildren. */
 	ut_assertok(device_reparent(grandchild[0], top[1]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_reparent(grandchild[1], top[1]));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	/* Remove re-pareneted devices. */
 	ut_assertok(device_remove(top[3], DM_REMOVE_NORMAL));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_remove(top[4], DM_REMOVE_NORMAL));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_remove(top[5], DM_REMOVE_NORMAL));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_remove(top[2], DM_REMOVE_NORMAL));
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_remove(grandchild[0], DM_REMOVE_NORMAL));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(device_remove(grandchild[1], DM_REMOVE_NORMAL));
+
 	/* try to get devices */
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	/* Try the same with unbind */
 	ut_assertok(device_unbind(top[3]));
@@ -1090,12 +1062,9 @@ static int dm_test_uclass_devices_find(struct unit_test_state *uts)
 	struct udevice *dev;
 	int ret;
 
-	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
-	     dev;
-	     ret = uclass_find_next_device(&dev)) {
-		ut_assert(!ret);
-		ut_assertnonnull(dev);
-	}
+	ret = uclass_find_first_device(UCLASS_TEST, &dev);
+	ut_assert(!ret);
+	ut_assertnonnull(dev);
 
 	ut_assertok(uclass_find_first_device(UCLASS_TEST_DUMMY, &dev));
 	ut_assertnull(dev);
@@ -1121,18 +1090,16 @@ static int dm_test_uclass_devices_find_by_name(struct unit_test_state *uts)
 	 * this will fail on checking condition: testdev == finddev, since the
 	 * uclass_find_device_by_name(), returns the first device by given name.
 	*/
-	for (ret = uclass_find_first_device(UCLASS_TEST_FDT, &testdev);
-	     testdev;
-	     ret = uclass_find_next_device(&testdev)) {
-		ut_assertok(ret);
-		ut_assertnonnull(testdev);
+	ret = uclass_find_first_device(UCLASS_TEST_FDT, &testdev);
+	ut_assertok(ret);
+	ut_assertnonnull(testdev);
 
+	for (; testdev; uclass_find_next_device(&testdev)) {
 		findret = uclass_find_device_by_name(UCLASS_TEST_FDT,
 						     testdev->name,
 						     &finddev);
 
 		ut_assertok(findret);
-		ut_assert(testdev);
 		ut_asserteq_str(testdev->name, finddev->name);
 		ut_asserteq_ptr(testdev, finddev);
 	}

-- 
2.39.5

