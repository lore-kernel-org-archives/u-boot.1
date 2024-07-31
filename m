Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B706EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6DD88A61;
	Wed, 31 Jul 2024 23:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="KyWOQYZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A8E88A54; Wed, 31 Jul 2024 15:43:42 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333C088A39
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428243f928cso15622675e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722433417; x=1723038217;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDzhBGtWajue3sFu4Rpiyi8QXZ3pEKWblKs97bUV23M=;
 b=KyWOQYZyoDumi/qdS249R/mq6KZywQXEewAsAAbop2X7WXHP9wGR5+QfkmcVst5rlB
 5EABPEHxgrdlvuki34AXipNLy9ep/R4IZON0xXDJo8Lt4+aYfqxNGVbXAewdI7LurPJB
 HEGVX2u34oO/dwxFbcvgfDNaSbTEckF8HLa1UBu+XUIH7XvcUtjLzyETvKaJBi9oJHqd
 BDyJ5dB/thmNVhSjK4mwn3H8YiptUpIeOY8Xa8DDR2omEq6EKuW054V4DxC1sSvzCpFc
 CZRXqV92r1W18uSmhlZXnVwzt9j/zIogygdMvMJk75yim/EQjIhYR62GF5ugn/wrnBpH
 jiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722433417; x=1723038217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDzhBGtWajue3sFu4Rpiyi8QXZ3pEKWblKs97bUV23M=;
 b=JE0fYIdNl57HaEv/pWxGObO22Gq1fipbSqjjfLaYSr0ZyFviS+Aa5RvuMLZwkUDUUq
 8/Gev9c86KuG9cpr/0oKT+Ol6o/Tyb+qv9/kQph4XRAuv/U1yrDOnDMcYEdD9JCVR3qw
 9jWfed7C5nFlLs/Zrn5lVTFWLLq6PpsGgpygQBeclKxmEw718OUN1Hl9lkw9bRIfzLVM
 9lBfVIJAfsNalHpgBStbmczkTuxvh9C9HQZwomoPFn5ZJSO9s3gO4MxsyTtVKpxNux1J
 SHmRsr2fqSeOufI1tDWqgbnSqzX7vyMI9cjikrALgvVq5Vs5VL216+Nb+U9+Wj4p4C/f
 OUQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0H4ecE5acfdqmH+FOuaCx55D3FBzqEG1Tqmn/hP7jBgcDnrufKB4OiWcclKy9s9Y6SS9LGzBMaUENvyLy1pFcBd1thg==
X-Gm-Message-State: AOJu0Yzq3UznXk+np2DbQtGrlDpRW+RdBaxGf28huETjjLSwioDAQYeH
 JuMtHmMbmx79DExYf3dPatRf5FN2UiHQ32b5KSUrw19U0In0aeW2ssmfOVmt/og=
X-Google-Smtp-Source: AGHT+IHQpYn36+gZNrvdiphlPf7vboPpN1bnsM34grakPw+5RrVjfDqcV1jZtbz/i7s04O/eO9K6GA==
X-Received: by 2002:adf:dd82:0:b0:368:5858:826e with SMTP id
 ffacd0b85a97d-36b5d383be6mr9605981f8f.59.1722433417563; 
 Wed, 31 Jul 2024 06:43:37 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm17063739f8f.93.2024.07.31.06.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:43:37 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH 1/4] dm: core: Add a way to specify an alt name for alias
 sequence numbering
Date: Wed, 31 Jul 2024 15:42:16 +0200
Message-ID: <20240731134257.686017-2-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731134257.686017-1-admin@hifiphile.com>
References: <20240731134257.686017-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 23:11:08 +0200
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

A new field name_seq_alias is added to uclass_driver structure, which
allows an uclass driver to use an alternate name for alias sequence
numbering.

For example an uclass named "usb_gadget" can share alias with
"usb" uclass :
    UCLASS_DRIVER(usb_gadget_generic) = {
	    .id = UCLASS_USB_GADGET_GENERIC,
	    .name = "usb_gadget",
	    .name_seq_alias = "usb",
    	.flags = DM_UC_FLAG_SEQ_ALIAS,
    };

Currently there are some uclasses with duplicate name which break uclass
functions like uclass_get_by_name(), with this patch it's now possible
to rename these classes without break the existing alias function.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/core/device.c |  3 ++-
 drivers/core/read.c   |  7 ++++++-
 drivers/core/uclass.c | 11 +++++++++--
 include/dm/read.h     |  9 ++++++++-
 include/dm/uclass.h   |  2 ++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d..a98e75b0b8 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -89,7 +89,8 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 		 */
 		if (CONFIG_IS_ENABLED(OF_CONTROL) &&
 		    !CONFIG_IS_ENABLED(OF_PLATDATA)) {
-			if (uc->uc_drv->name && ofnode_valid(node)) {
+			if ((uc->uc_drv->name || uc->uc_drv->name_seq_alias) &&
+			    ofnode_valid(node)) {
 				if (!dev_read_alias_seq(dev, &dev->seq_)) {
 					auto_seq = false;
 					log_debug("   - seq=%d\n", dev->seq_);
diff --git a/drivers/core/read.c b/drivers/core/read.c
index 55c19f335a..97b12fb7a9 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -347,9 +347,14 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
 	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass->uc_drv->name;
+	const char *uc_name;
 	int ret = -ENOTSUPP;
 
+	if (dev->uclass->uc_drv->name_seq_alias)
+		uc_name = dev->uclass->uc_drv->name_seq_alias;
+	else
+		uc_name = dev->uclass->uc_drv->name;
+
 	if (ofnode_is_np(node)) {
 		ret = of_alias_get_id(ofnode_to_np(node), uc_name);
 		if (ret >= 0) {
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 7ae0884a75..6dfbee2e78 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -308,11 +308,18 @@ int uclass_find_next_free_seq(struct uclass *uc)
 {
 	struct udevice *dev;
 	int max = -1;
+	const char *uc_name;
 
 	/* If using aliases, start with the highest alias value */
 	if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
-	    (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS))
-		max = dev_read_alias_highest_id(uc->uc_drv->name);
+	    (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS)) {
+		if (uc->uc_drv->name_seq_alias)
+			uc_name = uc->uc_drv->name_seq_alias;
+		else
+			uc_name = uc->uc_drv->name;
+
+		max = dev_read_alias_highest_id(uc_name);
+	}
 
 	/* Avoid conflict with existing devices */
 	list_for_each_entry(dev, &uc->dev_head, uclass_node) {
diff --git a/include/dm/read.h b/include/dm/read.h
index 894bc698bb..5a86e43d86 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1169,7 +1169,14 @@ static inline const void *dev_read_prop_by_prop(struct ofprop *prop,
 static inline int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
 #if CONFIG_IS_ENABLED(OF_CONTROL)
-	return fdtdec_get_alias_seq(gd->fdt_blob, dev->uclass->uc_drv->name,
+	const char *uc_name;
+
+	if (dev->uclass->uc_drv->name_seq_alias)
+		uc_name = dev->uclass->uc_drv->name_seq_alias;
+	else
+		uc_name = dev->uclass->uc_drv->name;
+
+	return fdtdec_get_alias_seq(gd->fdt_blob, uc_name,
 				    dev_of_offset(dev), devnump);
 #else
 	return -ENOTSUPP;
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index 456eef7f2f..8339e0d88b 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -57,6 +57,7 @@ struct udevice;
  * drivers.
  *
  * @name: Name of uclass driver
+ * @name_seq_alias: Name used for alias sequence numbering
  * @id: ID number of this uclass
  * @post_bind: Called after a new device is bound to this uclass
  * @pre_unbind: Called before a device is unbound from this uclass
@@ -88,6 +89,7 @@ struct udevice;
  */
 struct uclass_driver {
 	const char *name;
+	const char *name_seq_alias;
 	enum uclass_id id;
 	int (*post_bind)(struct udevice *dev);
 	int (*pre_unbind)(struct udevice *dev);
-- 
2.45.2

