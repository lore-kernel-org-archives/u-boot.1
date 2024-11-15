Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94934D68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF40896F6;
	Sat, 16 Nov 2024 00:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O7OU4z7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414FF891A5; Sat, 16 Nov 2024 00:19:51 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904EC891C4
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so3534639f.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712786; x=1732317586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBYTjdxWCadibcCbIw2uY5w6dzpPH2gyh9V5jrl7U1s=;
 b=O7OU4z7o9q4nvt7oij/lrtaCq08OyMqYD33f4MRytp0S78rf7wDni8EYkE0LIoEbWv
 o0/1d8cbgbIkAfRD/zQXPCLRV8EOgjtvYsbJYSbKkLywovHGtz9hLHvfYYvKGStyRHIQ
 0P0TYgi0HWwaDWqu9HP5ZhT34KTNi0+/g5Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712786; x=1732317586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBYTjdxWCadibcCbIw2uY5w6dzpPH2gyh9V5jrl7U1s=;
 b=GTsAJGnuzoXT+AlpiGOPK/cTn47PvX+ZpTLKiRGFQbc7OM5b6bOFeQGjkyovvn3WTP
 tlrj2gCZomrkJQG/e0/EL6vf9cwLmCFgkgmKuDbhk9WIvqVJJo5da7JssveHemE1Oy9z
 KKrmjLPFlqvCkKIrSN9C5GMYIwxdnOxrQBI9f4c3TSV3ePc0Zucp7kCL8VTQIDM+S4E3
 ixUQT7AQz+/2X0nAvKNZkGFUsJqyeoaUTN7MlDVO9DKwexyuPWq++zPSyMWtzQP379W4
 8/uQQX/4D2YqU76KK5U3gA92Obm9WYcAw4AO47fh4n/KZuMJZAbs/irrcF3wGufJYBXu
 sXpg==
X-Gm-Message-State: AOJu0YwknHFA26hYV4Hv3D+MdvqVE9594N6acUz5p7LIZiiWEdV3Tty6
 H7J73hgg17ks7VJJXpmt9ezfc7ctm9SHiZkrG5YmjRLcXb/wqL7g/BcAK1VBIU+II/uyMqJgcuQ
 =
X-Google-Smtp-Source: AGHT+IH6RiXcZw7ihrm1RgWnHnCmnhz9oyhmAts7vl9yeZs/f9NAnt0ZJe6Leg2i0TIiyBU6Q7OcAg==
X-Received: by 2002:a05:6602:15c5:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-83e6c1801f5mr519870739f.13.1731712786336; 
 Fri, 15 Nov 2024 15:19:46 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 04/19] bootstd: Drop the bootdev-specific list of bootflows
Date: Fri, 15 Nov 2024 16:19:11 -0700
Message-Id: <20241115231926.211999-5-sjg@chromium.org>
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

This list is only used by two functions, which can be updated to iterate
through the global list. Take this approach, which allows the bootdev
list to be dropped.

Overall this makes the code slightly more complicated, but will allow
moving the bootflow list into an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 61 +++++++++++++++++++++++++++----------------
 boot/bootflow.c       |  2 --
 boot/bootstd-uclass.c | 17 +++++-------
 include/bootdev.h     |  2 --
 include/bootflow.h    |  5 +---
 include/bootstd.h     |  2 +-
 6 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 26b003427ec..81adfb4cfb7 100644
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
@@ -911,15 +938,6 @@ void bootdev_list_hunters(struct bootstd_priv *std)
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
@@ -936,6 +954,5 @@ UCLASS_DRIVER(bootdev) = {
 	.name		= "bootdev",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_plat_auto	= sizeof(struct bootdev_uc_plat),
-	.post_bind	= bootdev_post_bind,
 	.pre_unbind	= bootdev_pre_unbind,
 };
diff --git a/boot/bootflow.c b/boot/bootflow.c
index d8807eb109d..804809dc100 100644
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

