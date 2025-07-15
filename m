Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF1C83F21
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D17D830A0;
	Tue, 15 Jul 2025 11:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hpt83vKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3483483096; Tue, 15 Jul 2025 11:23:19 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B3E8305C
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso60228925e9.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752571396; x=1753176196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NHVoPneVH3dFkbDNwBV562Io8bs5ZkE4rodokDu8Ywg=;
 b=hpt83vKFRR7Ci24xy+eFTILHrv3rKX7UkjvhkYLjEmDEKFEtPc+nRcuwWOl+zzb0Vn
 TrzfRiHfJmIh4nK5j73Ap080n7Um/JXFfzvaZTocvnLUTCHjBFJxIt0fkm9o2Er0FKMP
 1y0q8FZGAQF9UZx46cNzdGitagiv5mDFXjd7OOXkIH8nsZzZLlFN9QsKMBClmwi2Nque
 vdb+v2M74rVfYLb3WRFt8XVkx+EQMRvU9PcyKy/3thxEzT75oU9EETyZyQPg+bZygtLM
 Ne7+25Vg20LqwRITeVAOqsbN5doE1FaKjoo49+pUFrGDyxkjkZ+ESgvMLZE9PVto8SF4
 PF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571396; x=1753176196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHVoPneVH3dFkbDNwBV562Io8bs5ZkE4rodokDu8Ywg=;
 b=q6LhfKohIBSBz+qeyoFIK3Uw9xcYwd4xclwpBwSmmy6qHyg9ap75Qp4eYDD5InVGPZ
 QEDea1rK3141xzKSNOaIL0UlVyPv1f7KzXVp8nF89mxh0c++8C2JunheKsIxQhibTidB
 51L7Aj4o9MJlV3toCjZama3B1q1jQnon1oPApPf9lJ4T6wZadO66zuQqkj7Jf1kwjzXw
 O1LernmEeH4e1yNRUGdhiej+uc6CR7oq+b4j0MCTHA6KP/Rg+tF/eM3DF3b1/0+CdB/p
 PUC3GAvFdlXMgx/tOspVZwojcY4nOTSePYDxbhGqcZBNTv/PgPR3eT1fKpxmNz6fovXE
 nmMQ==
X-Gm-Message-State: AOJu0Yx/sgfMyNFJZqHIVKERAfvpUzKvYKDFltkR+alE19OCMYVtxn8v
 S+oXkKV/vmxwwa/UF5gPynaX1TdxO6YvOduDnPVtQp4HiAfG8D7jaxH6Le10rZkGjWw=
X-Gm-Gg: ASbGnctonjlWZUK50Vq4UfQHwkeXTjQJ+r/ds5vknXqTkcG9pfCiP0Ow9aOirkqxjzu
 fq9sAmXGfJ6IWzgkScGYXW1lFozKVLlgRYrnKCX1prr/x7XeRJzOM0yGZoxLoin3laI+yMbjtZe
 fAWVXgngL9zuRCqsVf/RGih+H7FAeMtYjoOC231KBsEgK34q0n62Sg3T1d9febUlGB1OBkCBcGt
 BHeZBFvi9E1mBXyoiaO9WPBvenmz/fycJ8gvB5qadz6dGF09B8NVxGFFwyoV+bNcVl7OwAMCCFs
 UppXgpqEsrKb2NDheNGIEhEdWbNtd+TmOJcimBphQoN5rxQZNSS32xVcEjCPphaLlhFQ7ky5KjG
 3Rei0hnd7wXk7lbDXEncEHWtA8PmGdaw7Lkof6mBvSSSaA/cWCA==
X-Google-Smtp-Source: AGHT+IEm4eMcdzt0FHTx/OGmp58VgL+5az9R+6z9h+skBfmnmVCPDEHqnYBfsOYxnJxqxj5rtj+Kdw==
X-Received: by 2002:a05:600c:4fc9:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-455e7b6538cmr119624235e9.28.1752571395611; 
 Tue, 15 Jul 2025 02:23:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm14379588f8f.46.2025.07.15.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 02:23:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 15 Jul 2025 10:23:14 +0100
Subject: [PATCH v2 2/2] uclass: Cleanup uclass_find_next_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-blk-uclass-v2-2-1bb1d2eee896@linaro.org>
References: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
In-Reply-To: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
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
 board/emulation/qemu-ppce500/qemu-ppce500.c |  4 ++--
 boot/bootdev-uclass.c                       |  2 +-
 cmd/regulator.c                             |  4 ++--
 drivers/core/uclass.c                       | 16 +++++-----------
 drivers/power/regulator/regulator-uclass.c  | 10 ++++++----
 drivers/remoteproc/rproc-uclass.c           |  6 ++++--
 include/dm/uclass-internal.h                |  4 +---
 test/dm/core.c                              | 28 ++++++++++++++--------------
 8 files changed, 35 insertions(+), 39 deletions(-)

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
index 3791ebfcb42..6718c482e52 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -216,7 +216,7 @@ void bootdev_list(bool probe)
 		if (probe)
 			ret = uclass_next_device_check(&dev);
 		else
-			ret = uclass_find_next_device(&dev);
+			uclass_find_next_device(&dev);
 	}
 	printf("---  ------  ------  --------  ------------------\n");
 	printf("(%d bootdev%s)\n", i, i != 1 ? "s" : "");
diff --git a/cmd/regulator.c b/cmd/regulator.c
index da298090bb7..db843283662 100644
--- a/cmd/regulator.c
+++ b/cmd/regulator.c
@@ -97,9 +97,9 @@ static int do_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	       "Parent");
 
 	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		if (ret)
-			continue;
+			break;
 
 		uc_pdata = dev_get_uclass_plat(dev);
 		printf("| %-*.*s| %-*.*s| %s\n",
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
index 09567eb9dbb..eac025c9c02 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -261,10 +261,10 @@ int regulator_get_by_platname(const char *plat_name, struct udevice **devp)
 	*devp = NULL;
 
 	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		if (ret) {
 			dev_dbg(dev, "ret=%d\n", ret);
-			continue;
+			break;
 		}
 
 		uc_pdata = dev_get_uclass_plat(dev);
@@ -411,8 +411,10 @@ static bool regulator_name_is_unique(struct udevice *check_dev,
 	int len;
 
 	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret || dev == check_dev)
+	     uclass_find_next_device(&dev)) {
+		if (ret)
+			break;
+		if (dev == check_dev)
 			continue;
 
 		uc_pdata = dev_get_uclass_plat(dev);
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 3233ff80419..7916cb27e3d 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -56,8 +56,10 @@ static int for_each_remoteproc_device(int (*fn) (struct udevice *dev,
 	int ret;
 
 	for (ret = uclass_find_first_device(UCLASS_REMOTEPROC, &dev); dev;
-	     ret = uclass_find_next_device(&dev)) {
-		if (ret || dev == skip_dev)
+	     uclass_find_next_device(&dev)) {
+		if (ret)
+			return ret;
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
index 959b834576f..201daee6836 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -737,7 +737,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -746,7 +746,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -756,7 +756,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -765,7 +765,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -775,7 +775,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -784,7 +784,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -794,7 +794,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -803,7 +803,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -812,7 +812,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -820,7 +820,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	ut_assertok(device_remove(top[2], DM_REMOVE_NORMAL));
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -829,7 +829,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -838,7 +838,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
 	/* try to get devices */
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -1092,7 +1092,7 @@ static int dm_test_uclass_devices_find(struct unit_test_state *uts)
 
 	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
 	     dev;
-	     ret = uclass_find_next_device(&dev)) {
+	     uclass_find_next_device(&dev)) {
 		ut_assert(!ret);
 		ut_assertnonnull(dev);
 	}
@@ -1123,7 +1123,7 @@ static int dm_test_uclass_devices_find_by_name(struct unit_test_state *uts)
 	*/
 	for (ret = uclass_find_first_device(UCLASS_TEST_FDT, &testdev);
 	     testdev;
-	     ret = uclass_find_next_device(&testdev)) {
+	     uclass_find_next_device(&testdev)) {
 		ut_assertok(ret);
 		ut_assertnonnull(testdev);
 

-- 
2.39.5

