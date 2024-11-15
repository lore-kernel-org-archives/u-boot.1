Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E34FD68BDD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D8B89706;
	Sat, 16 Nov 2024 00:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N3kkqVnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1416896FC; Sat, 16 Nov 2024 00:19:54 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FB4891C4
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a4d1633df9so4370775ab.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712789; x=1732317589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXckZHN3zS+Mw7jScC7KXZcERZziFPD1Dx38a38kdFI=;
 b=N3kkqVnFMi/e7yPfrdj61vjYS6xtmB1/QOm6G2uA0Q0wOIAC5s2OHLsi3GktlTTvu/
 k+Xw9m6wmGzYwU860CcHVmOWrcjhJw8TPGIwsP47h5UrNBqc7WX3atxMDACBxIcxKNkj
 d945bX9Px3Cje7kO4F6dIJt9WMYgCbMPoZ+xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712789; x=1732317589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXckZHN3zS+Mw7jScC7KXZcERZziFPD1Dx38a38kdFI=;
 b=GUYPwTcE3+xrku0XMuFMWfH+z6dhwdq09MXz1G5dmRiyhBopfZjh/G7CaE018o3Qve
 j2jA0PSfvsELBLGUd6fRhgn/3GLyPrXZocpxFYwPYtR6+//8n+uhQvOcPT2X2sIvpJhO
 Rk/amMyRFy9Htsja6UDFQn3abaS0d4xpfR2I5f6skA0sxt22pBmyFWWXQS4JRYWKjeuI
 0YEA4Ps7p8W4h94KyzICo7Cbku/yH/a5qP7K99jWpcJ3EUEnrmjZHrcTCOlT188a8VWP
 kO6UHocJLbupHyjRjP9BA0Mua+eQDNJBPw9DtfIDlUwKU+okgAwqvo3fH8MqMdLqGUR1
 /jeg==
X-Gm-Message-State: AOJu0YwiErf1h/Wl4qV/3P6vHWaaApV2XLNSsVnIr4Q6omjuJptJ4Ae2
 qMUvLLmOSFz41ybLOR3DP4uRV0fsvn00rCDkxlobk8xoq2wrQv9UMgdbXu3XY5/WD8xWhCAJr+k
 =
X-Google-Smtp-Source: AGHT+IF0MeMaawobnXShV9qol7Zr4a3e8+awCl0ldFWGGXlCqp6vvNpltsaj4nzjp7xJoY3l/yL8LA==
X-Received: by 2002:a05:6e02:3d04:b0:3a6:b8ce:7e2 with SMTP id
 e9e14a558f8ab-3a74800f3d6mr52090465ab.6.1731712789591; 
 Fri, 15 Nov 2024 15:19:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 05/19] bootstd: Move the bootflow list into an alist
Date: Fri, 15 Nov 2024 16:19:12 -0700
Message-Id: <20241115231926.211999-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

Use an alist for this data structure as it is somewhat simpler to
manage. This means that bootstd holds a simple list of bootflow structs
and can drop it at will, without chasing down lists.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Update bootstd_add_bootflow() to return the element number

 boot/bootdev-uclass.c | 47 +++++++++++++------------------------------
 boot/bootflow.c       | 16 ++++-----------
 boot/bootstd-uclass.c | 42 +++++++++++++++++++-------------------
 cmd/bootdev.c         |  2 +-
 cmd/bootflow.c        |  2 +-
 include/bootflow.h    | 11 +++++-----
 include/bootstd.h     |  8 +++++---
 7 files changed, 51 insertions(+), 77 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 81adfb4cfb7..a4e1d79ec9b 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -32,41 +32,17 @@ enum {
 	BOOT_TARGETS_MAX_LEN	= 100,
 };
 
-struct bootflow *bootdev_next_bootflow_(struct bootstd_priv *std,
-					struct udevice *dev,
-					struct bootflow *prev)
-{
-	struct bootflow *bflow = prev;
-
-	if (bflow) {
-		if (list_is_last(&bflow->glob_node, &std->glob_head))
-			return NULL;
-		bflow = list_entry(bflow->glob_node.next, struct bootflow,
-				   glob_node);
-	} else {
-		if (list_empty(&std->glob_head))
-			return NULL;
-
-		bflow = list_first_entry(&std->glob_head, struct bootflow,
-					 glob_node);
-	}
-
-	while (bflow->dev != dev) {
-		if (list_is_last(&bflow->glob_node, &std->glob_head))
-			return NULL;
-		bflow = list_entry(bflow->glob_node.next, struct bootflow,
-				   glob_node);
-	}
-
-	return bflow;
-}
-
 int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
 {
-	struct bootstd_priv *std = bootstd_try_priv();
+	struct bootstd_priv *std;
 	struct bootflow *bflow;
+	int ret;
+
+	ret = bootstd_get_priv(&std);
+	if (ret)
+		return log_msg_ret("bff", ret);
 
-	bflow = bootdev_next_bootflow_(std, dev, NULL);
+	bflow = alist_getw(&std->bootflows, 0, struct bootflow);
 	if (!bflow)
 		return -ENOENT;
 	*bflowp = bflow;
@@ -76,10 +52,15 @@ int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
 
 int bootdev_next_bootflow(struct bootflow **bflowp)
 {
-	struct bootstd_priv *std = bootstd_try_priv();
+	struct bootstd_priv *std;
 	struct bootflow *bflow;
+	int ret;
+
+	ret = bootstd_get_priv(&std);
+	if (ret)
+		return log_msg_ret("bff", ret);
 
-	bflow = bootdev_next_bootflow_(std, (*bflowp)->dev, *bflowp);
+	bflow = alist_nextw(&std->bootflows, *bflowp);
 	if (!bflow)
 		return -ENOENT;
 	*bflowp = bflow;
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 804809dc100..7ce04fd92cd 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -55,11 +55,10 @@ int bootflow_first_glob(struct bootflow **bflowp)
 	if (ret)
 		return ret;
 
-	if (list_empty(&std->glob_head))
+	if (!std->bootflows.count)
 		return -ENOENT;
 
-	*bflowp = list_first_entry(&std->glob_head, struct bootflow,
-				   glob_node);
+	*bflowp = alist_getw(&std->bootflows, 0, struct bootflow);
 
 	return 0;
 }
@@ -67,20 +66,16 @@ int bootflow_first_glob(struct bootflow **bflowp)
 int bootflow_next_glob(struct bootflow **bflowp)
 {
 	struct bootstd_priv *std;
-	struct bootflow *bflow = *bflowp;
 	int ret;
 
 	ret = bootstd_get_priv(&std);
 	if (ret)
 		return ret;
 
-	*bflowp = NULL;
-
-	if (list_is_last(&bflow->glob_node, &std->glob_head))
+	*bflowp = alist_nextw(&std->bootflows, *bflowp);
+	if (!*bflowp)
 		return -ENOENT;
 
-	*bflowp = list_entry(bflow->glob_node.next, struct bootflow, glob_node);
-
 	return 0;
 }
 
@@ -476,10 +471,7 @@ void bootflow_free(struct bootflow *bflow)
 
 void bootflow_remove(struct bootflow *bflow)
 {
-	list_del(&bflow->glob_node);
-
 	bootflow_free(bflow);
-	free(bflow);
 }
 
 #if CONFIG_IS_ENABLED(BOOTSTD_FULL)
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 91e90bdf43c..8c0fd4e63c3 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -6,6 +6,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <alist.h>
 #include <bootflow.h>
 #include <bootstd.h>
 #include <dm.h>
@@ -42,13 +43,11 @@ static int bootstd_of_to_plat(struct udevice *dev)
 
 static void bootstd_clear_glob_(struct bootstd_priv *priv)
 {
-	while (!list_empty(&priv->glob_head)) {
-		struct bootflow *bflow;
+	struct bootflow *bflow;
 
-		bflow = list_first_entry(&priv->glob_head, struct bootflow,
-					 glob_node);
+	alist_for_each(bflow, &priv->bootflows)
 		bootflow_remove(bflow);
-	}
+	alist_empty(&priv->bootflows);
 }
 
 void bootstd_clear_glob(void)
@@ -64,36 +63,37 @@ void bootstd_clear_glob(void)
 int bootstd_add_bootflow(struct bootflow *bflow)
 {
 	struct bootstd_priv *std;
-	struct bootflow *new;
 	int ret;
 
 	ret = bootstd_get_priv(&std);
 	if (ret)
 		return ret;
 
-	new = malloc(sizeof(*bflow));
-	if (!new)
-		return log_msg_ret("bflow", -ENOMEM);
-	memcpy(new, bflow, sizeof(*bflow));
-
-	list_add_tail(&new->glob_node, &std->glob_head);
+	ret = std->bootflows.count;
+	bflow = alist_add(&std->bootflows, *bflow);
+	if (!bflow)
+		return log_msg_ret("bf2", -ENOMEM);
 
-	return 0;
+	return ret;
 }
 
 int bootstd_clear_bootflows_for_bootdev(struct udevice *dev)
 {
 	struct bootstd_priv *std = bootstd_try_priv();
+	struct bootflow *from, *to;
 
-	if (std) {
-		struct bootflow *bflow;
-		struct list_head *pos;
+	/* if bootstd does not exist we cannot have any bootflows */
+	if (!std)
+		return 0;
 
-		list_for_each(pos, &std->glob_head) {
-			bflow = list_entry(pos, struct bootflow, glob_node);
-			bootflow_remove(bflow);
-		}
+	/* Drop any bootflows that mention this dev */
+	alist_for_each_filter(from, to, &std->bootflows) {
+		if (from->dev == dev)
+			bootflow_remove(from);
+		else
+			*to++ = *from;
 	}
+	alist_update_end(&std->bootflows, to);
 
 	return 0;
 }
@@ -165,7 +165,7 @@ static int bootstd_probe(struct udevice *dev)
 {
 	struct bootstd_priv *std = dev_get_priv(dev);
 
-	INIT_LIST_HEAD(&std->glob_head);
+	alist_init_struct(&std->bootflows, struct bootflow);
 
 	return 0;
 }
diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index fa7285ba25e..4bc229e809a 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -81,7 +81,7 @@ static int do_bootdev_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	dev = priv->cur_bootdev;
 
-	/* Count the number of bootflows, including how many are valid*/
+	/* Count the number of bootflows, including how many are valid */
 	num_valid = 0;
 	for (ret = bootdev_first_bootflow(dev, &bflow), i = 0;
 	     !ret;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 1c1146ce11e..f88995a478f 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -208,7 +208,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (!ret)
 			num_valid++;
 		ret = bootstd_add_bootflow(&bflow);
-		if (ret) {
+		if (ret < 0) {
 			printf("Out of memory\n");
 			return CMD_RET_FAILURE;
 		}
diff --git a/include/bootflow.h b/include/bootflow.h
index 64d1d6c3786..9b24fb5c3eb 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -56,11 +56,8 @@ enum bootflow_flags_t {
 /**
  * struct bootflow - information about a bootflow
  *
- * This is connected into a linked list:
+ * All bootflows are listed in bootstd's bootflow alist in struct bootstd_priv
  *
- *   glob_sibling - links all bootflows in all bootdevs
- *
- * @glob_node: Points to siblings in the global list (all bootdev)
  * @dev: Bootdev device which produced this bootflow, NULL for flows created by
  *      BOOTMETHF_GLOBAL bootmeths
  * @blk: Block device which contains this bootflow, NULL if this is a network
@@ -90,7 +87,6 @@ enum bootflow_flags_t {
  * @bootmeth_priv: Private data for the bootmeth
  */
 struct bootflow {
-	struct list_head glob_node;
 	struct udevice *dev;
 	struct udevice *blk;
 	int part;
@@ -390,7 +386,10 @@ const char *bootflow_state_get_name(enum bootflow_state_t state);
 /**
  * bootflow_remove() - Remove a bootflow and free its memory
  *
- * This updates the linked lists containing the bootflow then frees it.
+ * This updates the 'global' linked list containing the bootflow, then frees it.
+ * It does not remove it from bootflows alist in struct bootstd_priv
+ *
+ * This does not free bflow itself, since this is assumed to be in an alist
  *
  * @bflow: Bootflow to remove
  */
diff --git a/include/bootstd.h b/include/bootstd.h
index 8aff536e3cb..3398e48e88b 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -9,6 +9,7 @@
 #ifndef __bootstd_h
 #define __bootstd_h
 
+#include <alist.h>
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -30,7 +31,8 @@ struct udevice;
  *	terminated)
  * @cur_bootdev: Currently selected bootdev (for commands)
  * @cur_bootflow: Currently selected bootflow (for commands)
- * @glob_head: Head for the global list of all bootflows across all bootdevs
+ * @bootflows: (struct bootflow) Global list of all bootflows across all
+ *	bootdevs
  * @bootmeth_count: Number of bootmeth devices in @bootmeth_order
  * @bootmeth_order: List of bootmeth devices to use, in order, NULL-terminated
  * @vbe_bootmeth: Currently selected VBE bootmeth, NULL if none
@@ -44,7 +46,7 @@ struct bootstd_priv {
 	const char **env_order;
 	struct udevice *cur_bootdev;
 	struct bootflow *cur_bootflow;
-	struct list_head glob_head;
+	struct alist bootflows;
 	int bootmeth_count;
 	struct udevice **bootmeth_order;
 	struct udevice *vbe_bootmeth;
@@ -135,7 +137,7 @@ int bootstd_prog_boot(void);
  *	since this function takes over ownership of these. This functions makes
  *	a copy of @bflow itself (without allocating its fields again), so the
  *	caller must dispose of the memory used by the @bflow pointer itself
- * Return: 0 if OK, -ENOMEM if out of memory
+ * Return: element number in the list, if OK, -ENOMEM if out of memory
  */
 int bootstd_add_bootflow(struct bootflow *bflow);
 
-- 
2.34.1

