Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E495D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2301891E2;
	Fri, 18 Oct 2024 01:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LYkJesyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDF589208; Fri, 18 Oct 2024 01:24:56 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1CF8917B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aba655593so7283539f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207492; x=1729812292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI/fkbS0DoeUNoy/u68kywAT04C2CDtxDGFVAJfpoBc=;
 b=LYkJesyxLIrA531QUOC3pZCvoRxXXU7V0KaJrFZ1ddOhw1ml2M7fyQXFvWn/c5EIJT
 B12h5a54Va2+8zx32mVKkN9eCH5Lrd4ri6k7xKE1uUJruckjjs1jDQpDDtyDloyCnCfk
 pN6XKAnYAfn8Ry6FFadb1UgGcurAeVTAFYdbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207492; x=1729812292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZI/fkbS0DoeUNoy/u68kywAT04C2CDtxDGFVAJfpoBc=;
 b=ftoCvbFMdFaijxUc3edfrd70UmMMwvjbczJR/PgxAMv5WP+sxqN8D0UEzOrMClGUJq
 7JjXUjKt3I4vZawd/VWNTh0qWsx+aRB45GpIF41FiJ3LveBE+1qLo1QokNIi7xx/otBM
 Ptd37sRIDMLBZTxx4bJAy7j8VHSVc6rnqgv2KQHIBjTKYu6UGccJf/R7M+DPL6wUG/RI
 G9kLcQZr4OAV4r0Kmm9P3l2ZayQfEHCqyeWnBpQJPerpzVm8tVYclki9Q4GJYFrPpbKI
 nCrzsuIXdvsQoWKZKDf0YdR7WQgk+ecP7XQFhhYNDMrCG9Qk668s53EWsXYqsWKSLQQT
 mBrA==
X-Gm-Message-State: AOJu0Yz37WwNBTZGDx5cdBYSj1/vzvjlcQsueej81MK6iKBM0iZWHsnL
 WzIzLbDFGOmjst2+MzDC34x9HUOvpcyv8jU4UGHU9kVLgUby6rEpbXbNe5yClVMc6vEyzzKcsBE
 =
X-Google-Smtp-Source: AGHT+IHU4sEfbSocZDQ+h5rYG7iu3rkzbbVYNb+5CfwrSTB0pTXIXuTJigEBCoYJurU3/X8Qit0fJw==
X-Received: by 2002:a05:6602:6219:b0:82a:545b:113f with SMTP id
 ca18e2360f4ac-83aba63a2abmr47679539f.12.1729207492513; 
 Thu, 17 Oct 2024 16:24:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 13/34] bootstd: Drop the bootdev-specific list of bootflows
Date: Thu, 17 Oct 2024 17:23:52 -0600
Message-Id: <20241017232413.724808-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This list is only used by two functions, which can be updated to iterate
through the global list. Take this approach, which allows the bootdev
list to be dropped.

Overall this makes the code slightly more complicated, but will allow
moving the bootflow list into an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c | 61 +++++++++++++++++++++++++++----------------
 boot/bootflow.c       |  2 --
 boot/bootstd-uclass.c | 17 +++++-------
 include/bootdev.h     |  2 --
 include/bootflow.h    |  5 +---
 include/bootstd.h     |  2 +-
 6 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index e9dda65417d..8f4a4bec129 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -32,30 +32,57 @@ enum {
 	BOOT_TARGETS_MAX_LEN	= 100,
 };
 
+struct bootflow *bootdev_next_bootflow_(struct bootstd_priv *std,
+					struct udevice *dev,
+					struct bootflow *prev)
+{
+	struct bootflow *bflow = prev;
+
+	if (bflow) {
+		if (list_is_last(&bflow->glob_node, &std->glob_head))
+			return NULL;
+		bflow = list_entry(bflow->glob_node.next, struct bootflow,
+				   glob_node);
+	} else {
+		if (list_empty(&std->glob_head))
+			return NULL;
+
+		bflow = list_first_entry(&std->glob_head, struct bootflow,
+					 glob_node);
+	}
+
+	while (bflow->dev != dev) {
+		if (list_is_last(&bflow->glob_node, &std->glob_head))
+			return NULL;
+		bflow = list_entry(bflow->glob_node.next, struct bootflow,
+				   glob_node);
+	}
+
+	return bflow;
+}
+
 int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
 {
-	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+	struct bootstd_priv *std = bootstd_try_priv();
+	struct bootflow *bflow;
 
-	if (list_empty(&ucp->bootflow_head))
+	bflow = bootdev_next_bootflow_(std, dev, NULL);
+	if (!bflow)
 		return -ENOENT;
-
-	*bflowp = list_first_entry(&ucp->bootflow_head, struct bootflow,
-				   bm_node);
+	*bflowp = bflow;
 
 	return 0;
 }
 
 int bootdev_next_bootflow(struct bootflow **bflowp)
 {
-	struct bootflow *bflow = *bflowp;
-	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
-
-	*bflowp = NULL;
+	struct bootstd_priv *std = bootstd_try_priv();
+	struct bootflow *bflow;
 
-	if (list_is_last(&bflow->bm_node, &ucp->bootflow_head))
+	bflow = bootdev_next_bootflow_(std, (*bflowp)->dev, *bflowp);
+	if (!bflow)
 		return -ENOENT;
-
-	*bflowp = list_entry(bflow->bm_node.next, struct bootflow, bm_node);
+	*bflowp = bflow;
 
 	return 0;
 }
@@ -908,15 +935,6 @@ void bootdev_list_hunters(struct bootstd_priv *std)
 	printf("(total hunters: %d)\n", n_ent);
 }
 
-static int bootdev_post_bind(struct udevice *dev)
-{
-	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
-
-	INIT_LIST_HEAD(&ucp->bootflow_head);
-
-	return 0;
-}
-
 static int bootdev_pre_unbind(struct udevice *dev)
 {
 	int ret;
@@ -933,6 +951,5 @@ UCLASS_DRIVER(bootdev) = {
 	.name		= "bootdev",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_plat_auto	= sizeof(struct bootdev_uc_plat),
-	.post_bind	= bootdev_post_bind,
 	.pre_unbind	= bootdev_pre_unbind,
 };
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 59d77d2385f..ae59d1a4092 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -476,8 +476,6 @@ void bootflow_free(struct bootflow *bflow)
 
 void bootflow_remove(struct bootflow *bflow)
 {
-	if (bflow->dev)
-		list_del(&bflow->bm_node);
 	list_del(&bflow->glob_node);
 
 	bootflow_free(bflow);
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index b2f80808c85..91e90bdf43c 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -77,25 +77,22 @@ int bootstd_add_bootflow(struct bootflow *bflow)
 	memcpy(new, bflow, sizeof(*bflow));
 
 	list_add_tail(&new->glob_node, &std->glob_head);
-	if (bflow->dev) {
-		struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
-
-		list_add_tail(&new->bm_node, &ucp->bootflow_head);
-	}
 
 	return 0;
 }
 
 int bootstd_clear_bootflows_for_bootdev(struct udevice *dev)
 {
-	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+	struct bootstd_priv *std = bootstd_try_priv();
 
-	while (!list_empty(&ucp->bootflow_head)) {
+	if (std) {
 		struct bootflow *bflow;
+		struct list_head *pos;
 
-		bflow = list_first_entry(&ucp->bootflow_head, struct bootflow,
-					 bm_node);
-		bootflow_remove(bflow);
+		list_for_each(pos, &std->glob_head) {
+			bflow = list_entry(pos, struct bootflow, glob_node);
+			bootflow_remove(bflow);
+		}
 	}
 
 	return 0;
diff --git a/include/bootdev.h b/include/bootdev.h
index f9cae2fd1fd..991b6229c1c 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -109,11 +109,9 @@ struct bootdev_hunter {
  * This is attached to each device in the bootdev uclass and accessible via
  * dev_get_uclass_plat(dev)
  *
- * @bootflows: List of available bootflows for this bootdev
  * @piro: Priority of this bootdev
  */
 struct bootdev_uc_plat {
-	struct list_head bootflow_head;
 	enum bootdev_prio_t prio;
 };
 
diff --git a/include/bootflow.h b/include/bootflow.h
index 4d2fc7b69b5..64d1d6c3786 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -56,12 +56,10 @@ enum bootflow_flags_t {
 /**
  * struct bootflow - information about a bootflow
  *
- * This is connected into two separate linked lists:
+ * This is connected into a linked list:
  *
- *   bm_sibling - links all bootflows in the same bootdev
  *   glob_sibling - links all bootflows in all bootdevs
  *
- * @bm_node: Points to siblings in the same bootdev
  * @glob_node: Points to siblings in the global list (all bootdev)
  * @dev: Bootdev device which produced this bootflow, NULL for flows created by
  *      BOOTMETHF_GLOBAL bootmeths
@@ -92,7 +90,6 @@ enum bootflow_flags_t {
  * @bootmeth_priv: Private data for the bootmeth
  */
 struct bootflow {
-	struct list_head bm_node;
 	struct list_head glob_node;
 	struct udevice *dev;
 	struct udevice *blk;
diff --git a/include/bootstd.h b/include/bootstd.h
index 4535d91e2ad..8aff536e3cb 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -123,7 +123,7 @@ void bootstd_clear_glob(void);
 int bootstd_prog_boot(void);
 
 /**
- * bootstd_add_bootflow() - Add a bootflow to the bootdev's and global list
+ * bootstd_add_bootflow() - Add a bootflow to the global list
  *
  * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
  * bootflow to that device.
-- 
2.34.1

