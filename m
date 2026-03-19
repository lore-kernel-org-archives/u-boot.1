Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45F21091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF5C84114;
	Thu, 19 Mar 2026 22:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gKzLGair";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227BA83FEC; Thu, 19 Mar 2026 22:36:53 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398F6840CC
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d1872504cbso1183719a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956207; x=1774561007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ES2pUClqRLNWJJ+yFZ3Ax+7t/ErUxpLTkqO+7ZIqRVo=;
 b=gKzLGairrjV0i2yqTMD67jzMbbGQzxuW3rBb92q+DP8CHHucZaJpZO7WCFPV9pAQdj
 8DluG2RlTjzFEGmLT9VHOUKjXNsfJIk+iklg9a6XXFNCSWojNrNRGrAu5f7YM56EHh+j
 4UILUooyhN2/SBPvVAdLxvawUb0xbHgiqJbT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956207; x=1774561007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ES2pUClqRLNWJJ+yFZ3Ax+7t/ErUxpLTkqO+7ZIqRVo=;
 b=V75ZSlrT766nP1LMj+MUEhR5fv59/oLyBAszWDGkleC3GzxyuYeOF3PNBu4DdmZxgU
 ZJu+rdDIEY0HEkPWzBJPGvvzs08qBR5tpsVH6WEeehpOanrMU+MxUl8GhLZSI8Cfk1Pt
 GXs2C+nZPUjdwRtVkdSrCZhoDduimn3yx+t4aXG0k6k5OY+fsgo+sBo49sstPj2xqRvd
 d05uVMynTn8GKGKEgo2I1tn+dsp0Yg9S/EpCl3nNggvYmL+n75nQUsQrUXrNg54K9e+Y
 nQUpA0k+m2vvfbIN+1bxTdas24KkwiwwdE+Y9ly7o3TdZAibteaRoRzsgsO/kpRvJo8S
 yrEw==
X-Gm-Message-State: AOJu0Yy6532tLUxrSI1AY4KHCJP108GH2WLBAi3SrCQ1ShnlyWrcoRDO
 h8aDOEDyQ8z3y+ogm9dRnmpfBpPZRh83g5hYfXm3CVQXSKCsAlzy+qbwmyY6e3z4I1zWB+Y0NoY
 BSOi5Gg==
X-Gm-Gg: ATEYQzx7yPO7W8A4cD3ziksG/yAOajvEbN70g0oD6aqm5bQYzL9FjO6Icl6YhUwehaU
 0kjbjaU+cCKc+Bi2XaKo1lRXkAh5xQcngPEBW7vUW19GYSJ2DnVBKuTzdsz+huRC0zr9tjidUfh
 RMPO5QeounS10C9hnbrD9fzOxVn5S2F++GlVj4kcA2tyxSLtT5ISuWV77e/alUVDWpawgm/l7Bu
 EgWpMPNq44jFHIzCXEn2ncTEZdC7UziRfzG1kLr7KE13PP55kl3E3IvqrEOPsr92R88RLHll748
 ro1MB9T6VcsNaxTBo4U8Gi1LD6y/N2efubNPSOhCSAiGySOmNEKr8bot+zu3yX4XC9AVGJiSM5g
 sE5F/HAORj/wH9886ngUa8RJvlnHVmYIrdISY4Ay4fBdh132oaxGYN/4b36FYfUAAosKqZtxIBT
 pOp+uqowTPLPYg5HfBNw==
X-Received: by 2002:a05:6830:6d26:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7d7ea9f0564mr633007a34.6.1773956207143; 
 Thu, 19 Mar 2026 14:36:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Marek Vasut <marex@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 09/15] dm: core: Integrate adjuncts into existing code
 paths
Date: Thu, 19 Mar 2026 15:35:39 -0600
Message-ID: <20260319213551.267031-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

Wire adjunct support into the existing driver-model lifecycle and
uclass iteration.

Use the shared ucm_alloc_plat() and ucm_alloc_priv() helpers in the
primary bind and probe paths. Call device_init_adj() at bind,
device_probe_adjs() at probe, device_free_adjs() at remove and
device_unbind_adjs() at unbind.

Update uclass0iteration to handle the combined dev_head list, which now
contains both primary and adjunct entries. Function-based iterators use
ucm->dev

Some iterators use container_of() so cannot handle adjuncts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/device-remove.c |   9 +-
 drivers/core/device.c        |   9 +-
 drivers/core/uclass.c        | 286 ++++++++++++++++++++++++++++++++---
 include/dm/uclass-internal.h |   8 +
 include/dm/uclass.h          | 210 ++++++++++++++++++++++---
 5 files changed, 483 insertions(+), 39 deletions(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 2a3253b34a5..7d07317f344 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -109,6 +109,10 @@ int device_unbind(struct udevice *dev)
 		free(dev_get_parent_plat(dev));
 		dev_set_parent_plat(dev, NULL);
 	}
+	ret = device_unbind_adjs(dev);
+	if (ret)
+		return log_msg_ret("adj", ret);
+
 	ret = uclass_unbind_device(dev);
 	if (ret)
 		return log_msg_ret("uc", ret);
@@ -131,12 +135,15 @@ int device_unbind(struct udevice *dev)
  */
 void device_free(struct udevice *dev)
 {
-	int size;
+	int size, ret;
 
 	if (dev->driver->priv_auto) {
 		free(dev_get_priv(dev));
 		dev_set_priv(dev, NULL);
 	}
+	ret = device_remove_adjs(dev);
+	if (ret)
+		log_debug("Failed to remove adjuncts: %d\n", ret);
 	size = dev->ucm.uc->uc_drv->per_device_auto;
 	if (size) {
 		free(dev_get_uclass_priv(dev));
diff --git a/drivers/core/device.c b/drivers/core/device.c
index 1de392238f8..ba3c5b9a28e 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -80,7 +80,9 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	dev_set_ofnode(dev, node);
 	dev->parent = parent;
 	dev->driver = drv;
+	device_init_adj(dev);
 	ucm->uc = uc;
+	ucm->dev = dev;
 
 	ucm->seq = -1;
 	if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
@@ -351,6 +353,7 @@ static int device_alloc_priv(struct udevice *dev)
 	const struct driver *drv;
 	void *ptr;
 	int size;
+	int ret;
 
 	drv = dev->driver;
 	assert(drv);
@@ -363,7 +366,7 @@ static int device_alloc_priv(struct udevice *dev)
 		dev_set_priv(dev, ptr);
 	}
 
-	/* Allocate private data if requested and not reentered */
+	/* Allocate uclass-private data if requested and not reentered */
 	size = dev->ucm.uc->uc_drv->per_device_auto;
 	if (size && !dev_get_uclass_priv(dev)) {
 		ptr = alloc_priv(size, dev->ucm.uc->uc_drv->flags);
@@ -372,6 +375,10 @@ static int device_alloc_priv(struct udevice *dev)
 		dev_set_uclass_priv(dev, ptr);
 	}
 
+	ret = device_probe_adjs_(dev);
+	if (ret)
+		return ret;
+
 	/* Allocate parent data for this child */
 	if (dev->parent) {
 		size = dev->parent->driver->per_child_auto;
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 276aec855a0..9abca7a530f 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -114,6 +114,9 @@ int uclass_destroy(struct uclass *uc)
 	struct udevice *dev;
 	int ret;
 
+	/* Remove adjunct entries first, leaving only primary devices */
+	uclass_destroy_adjs(uc);
+
 	/*
 	 * We cannot use list_for_each_entry_safe() here. If a device in this
 	 * uclass has a child device also in this uclass, it will be also be
@@ -253,10 +256,23 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp)
 	ret = uclass_get(id, &uc);
 	if (ret)
 		return ret;
-	if (list_empty(&uc->dev_head))
-		return 0;
 
-	*devp = list_first_entry(&uc->dev_head, struct udevice, ucm.uc_node);
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
+		struct uclass_member *ucm;
+
+		/* Skip adjunct entries - only return primary devices */
+		list_for_each_entry(ucm, &uc->dev_head, uc_node) {
+			if (ucm_is_primary(ucm)) {
+				*devp = ucm->dev;
+				return 0;
+			}
+		}
+	} else {
+		if (!list_empty(&uc->dev_head))
+			*devp = list_first_entry(&uc->dev_head,
+						 struct udevice,
+						 ucm.uc_node);
+	}
 
 	return 0;
 }
@@ -266,11 +282,215 @@ void uclass_find_next_device(struct udevice **devp)
 	struct udevice *dev = *devp;
 
 	*devp = NULL;
-	if (!list_is_last(&dev->ucm.uc_node, &dev->ucm.uc->dev_head))
-		*devp = list_entry(dev->ucm.uc_node.next, struct udevice,
-				   ucm.uc_node);
+
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
+		struct uclass_member *ucm;
+
+		/* Skip adjunct entries - only return primary devices */
+		ucm = &dev->ucm;
+		while (ucm->uc_node.next != &ucm->uc->dev_head) {
+			ucm = list_next_entry(ucm, uc_node);
+			if (ucm_is_primary(ucm)) {
+				*devp = ucm->dev;
+				return;
+			}
+		}
+	} else {
+		if (!list_is_last(&dev->ucm.uc_node,
+				  &dev->ucm.uc->dev_head))
+			*devp = list_entry(dev->ucm.uc_node.next,
+					   struct udevice, ucm.uc_node);
+	}
+}
+
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+int ucm_find_first(enum uclass_id id, struct uclass_member **ucmp)
+{
+	struct uclass *uc;
+	int ret;
+
+	*ucmp = NULL;
+	ret = uclass_get(id, &uc);
+	if (ret)
+		return ret;
+
+	if (!list_empty(&uc->dev_head))
+		*ucmp = list_first_entry(&uc->dev_head,
+					 struct uclass_member, uc_node);
+
+	return 0;
+}
+
+void ucm_find_next(struct uclass_member **ucmp)
+{
+	struct uclass_member *ucm = *ucmp;
+
+	if (ucm->uc_node.next == &ucm->uc->dev_head)
+		*ucmp = NULL;
+	else
+		*ucmp = list_next_entry(ucm, uc_node);
+}
+
+struct uclass_member *_ucm_first_primary(struct uclass *uc)
+{
+	struct uclass_member *ucm;
+
+	list_for_each_entry(ucm, &uc->dev_head, uc_node) {
+		if (ucm_is_primary(ucm))
+			return ucm;
+	}
+
+	return NULL;
+}
+
+void _ucm_next_primary(struct uclass_member **ucmp)
+{
+	struct uclass_member *ucm = *ucmp;
+
+	while (ucm->uc_node.next != &ucm->uc->dev_head) {
+		ucm = list_next_entry(ucm, uc_node);
+		if (ucm_is_primary(ucm)) {
+			*ucmp = ucm;
+			return;
+		}
+	}
+	*ucmp = NULL;
+}
+
+/*
+ * Starting from the given member @ucm, return the first member whose device
+ * probes successfully.
+ */
+static struct uclass_member *_ucm_next(struct uclass_member *ucm)
+{
+	for (; ucm; ucm_find_next(&ucm)) {
+		if (!device_probe(ucm->dev))
+			break;
+	}
+
+	return ucm;
+}
+
+struct uclass_member *ucm_first(enum uclass_id id)
+{
+	struct uclass_member *ucm;
+
+	ucm_find_first(id, &ucm);
+
+	return _ucm_next(ucm);
+}
+
+struct uclass_member *ucm_next(struct uclass_member *ucm)
+{
+	ucm_find_next(&ucm);
+
+	return _ucm_next(ucm);
+}
+
+int ucm_first_check(enum uclass_id id, struct uclass_member **ucmp)
+{
+	int ret;
+
+	*ucmp = NULL;
+	ret = ucm_find_first(id, ucmp);
+	if (ret)
+		return ret;
+	if (!*ucmp)
+		return 0;
+
+	return device_probe((*ucmp)->dev);
+}
+
+int ucm_next_check(struct uclass_member **ucmp)
+{
+	ucm_find_next(ucmp);
+
+	if (!*ucmp)
+		return 0;
+
+	return device_probe((*ucmp)->dev);
+}
+
+int ucm_first_drvdata(enum uclass_id id, ulong driver_data,
+		      struct uclass_member **ucmp)
+{
+	struct uclass_member *ucm;
+	int ret;
+
+	ret = ucm_find_first(id, &ucm);
+	if (ret)
+		return ret;
+
+	for (; ucm; ucm_find_next(&ucm)) {
+		if (dev_get_driver_data(ucm->dev) == driver_data) {
+			*ucmp = ucm;
+
+			return device_probe(ucm->dev);
+		}
+	}
+
+	return -ENODEV;
 }
 
+struct uclass_member *ucm_try_first(enum uclass_id id)
+{
+	struct uclass *uc;
+
+	uc = uclass_find(id);
+	if (!uc || list_empty(&uc->dev_head))
+		return NULL;
+
+	return list_first_entry(&uc->dev_head, struct uclass_member, uc_node);
+}
+
+int ucm_find_by_ofnode(enum uclass_id id, ofnode node,
+		       struct uclass_member **ucmp)
+{
+	struct uclass_member *ucm;
+	int ret;
+
+	*ucmp = NULL;
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = ucm_find_first(id, &ucm);
+	if (ret)
+		return ret;
+
+	for (; ucm; ucm_find_next(&ucm)) {
+		if (ofnode_equal(dev_ofnode(ucm->dev), node)) {
+			*ucmp = ucm;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+int ucm_find_seq(enum uclass_id id, int seq, struct uclass_member **ucmp)
+{
+	struct uclass_member *ucm;
+	int ret;
+
+	*ucmp = NULL;
+	if (seq == -1)
+		return -ENODEV;
+
+	ret = ucm_find_first(id, &ucm);
+	if (ret)
+		return ret;
+
+	for (; ucm; ucm_find_next(&ucm)) {
+		if (ucm->seq == seq) {
+			*ucmp = ucm;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+#endif /* DM_UC_ADJUNCT */
+
 int uclass_find_device_by_namelen(enum uclass_id id, const char *name, int len,
 				  struct udevice **devp)
 {
@@ -310,12 +530,15 @@ struct udevice *uclass_try_first_device(enum uclass_id id)
 	if (!uc || list_empty(&uc->dev_head))
 		return NULL;
 
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT))
+		return list_first_entry(&uc->dev_head,
+					struct uclass_member, uc_node)->dev;
+
 	return list_first_entry(&uc->dev_head, struct udevice, ucm.uc_node);
 }
 
 int uclass_find_next_free_seq(struct uclass *uc)
 {
-	struct udevice *dev;
 	int max = -1;
 
 	/* If using aliases, start with the highest alias value */
@@ -323,11 +546,23 @@ int uclass_find_next_free_seq(struct uclass *uc)
 	    (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS))
 		max = dev_read_alias_highest_id(uc->uc_drv->name);
 
-	/* Avoid conflict with existing devices */
-	list_for_each_entry(dev, &uc->dev_head, ucm.uc_node) {
-		if (dev->ucm.seq > max)
-			max = dev->ucm.seq;
+	/* Avoid conflict with existing devices and adjuncts */
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
+		struct uclass_member *ucm;
+
+		list_for_each_entry(ucm, &uc->dev_head, uc_node) {
+			if (ucm->seq > max)
+				max = ucm->seq;
+		}
+	} else {
+		struct udevice *dev;
+
+		list_for_each_entry(dev, &uc->dev_head, ucm.uc_node) {
+			if (dev->ucm.seq > max)
+				max = dev->ucm.seq;
+		}
 	}
+
 	/*
 	 * At this point, max will be -1 if there are no existing aliases or
 	 * devices
@@ -339,7 +574,6 @@ int uclass_find_next_free_seq(struct uclass *uc)
 int uclass_find_device_by_seq(enum uclass_id id, int seq, struct udevice **devp)
 {
 	struct uclass *uc;
-	struct udevice *dev;
 	int ret;
 
 	*devp = NULL;
@@ -350,12 +584,27 @@ int uclass_find_device_by_seq(enum uclass_id id, int seq, struct udevice **devp)
 	if (ret)
 		return ret;
 
-	uclass_foreach_dev(dev, uc) {
-		log_debug("   - %d '%s'\n", dev->ucm.seq, dev->name);
-		if (dev->ucm.seq == seq) {
-			*devp = dev;
-			log_debug("   - found\n");
-			return 0;
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
+		struct uclass_member *ucm;
+
+		list_for_each_entry(ucm, &uc->dev_head, uc_node) {
+			log_debug("   - %d '%s'\n", ucm->seq, ucm->dev->name);
+			if (ucm->seq == seq) {
+				*devp = ucm->dev;
+				log_debug("   - found\n");
+				return 0;
+			}
+		}
+	} else {
+		struct udevice *dev;
+
+		uclass_foreach_dev(dev, uc) {
+			log_debug("   - %d '%s'\n", dev->ucm.seq, dev->name);
+			if (dev->ucm.seq == seq) {
+				*devp = dev;
+				log_debug("   - found\n");
+				return 0;
+			}
 		}
 	}
 	log_debug("   - not found\n");
@@ -410,6 +659,7 @@ int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
 			goto done;
 		}
 	}
+
 	ret = -ENODEV;
 
 done:
diff --git a/include/dm/uclass-internal.h b/include/dm/uclass-internal.h
index 9cb3f090271..4328419f6e6 100644
--- a/include/dm/uclass-internal.h
+++ b/include/dm/uclass-internal.h
@@ -138,6 +138,10 @@ int uclass_find_device(enum uclass_id id, int index, struct udevice **devp);
  * The device is not prepared for use - this is an internal function.
  * The function uclass_get_device_tail() can be used to probe the device.
  *
+ * Note: this skips adjunct members because it uses struct udevice * as
+ * the cursor. Use uclass_foreach_dev() or ucm_find_first() to include
+ * adjuncts.
+ *
  * Return: 0 if OK (found or not found), -ve on error
  */
 int uclass_find_first_device(enum uclass_id id, struct udevice **devp);
@@ -149,6 +153,10 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp);
  *
  * The device is not prepared for use - this is an internal function.
  * The function uclass_get_device_tail() can be used to probe the device.
+ *
+ * Note: this skips adjunct members because it uses struct udevice * as
+ * the cursor. Use uclass_foreach_dev() or ucm_find_next() to include
+ * adjuncts.
  */
 void uclass_find_next_device(struct udevice **devp);
 
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index ad49d675570..d99b76c9404 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -362,12 +362,15 @@ int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
 /**
  * uclass_first_device() - Get the first device in a uclass
  *
- * The device returned is probed if necessary, and ready for use
- * Devices that fail to probe are skipped
+ * The device returned is probed if necessary, and ready for use.
+ * Devices that fail to probe are skipped.
  *
  * This function is useful to start iterating through a list of devices which
  * are functioning correctly and can be probed.
  *
+ * Note: this skips adjunct members. Use uclass_foreach_dev_probe() or
+ * ucm_first() to include adjuncts.
+ *
  * @id: Uclass ID to look up
  * @devp: Returns pointer to the first device in that uclass if no error
  * occurred, or NULL if there is no usable device
@@ -377,12 +380,15 @@ void uclass_first_device(enum uclass_id id, struct udevice **devp);
 /**
  * uclass_next_device() - Get the next device in a uclass
  *
- * The device returned is probed if necessary, and ready for use
- * Devices that fail to probe are skipped
+ * The device returned is probed if necessary, and ready for use.
+ * Devices that fail to probe are skipped.
  *
  * This function is useful to iterate through a list of devices which
  * are functioning correctly and can be probed.
  *
+ * Note: this skips adjunct members. Use uclass_foreach_dev_probe() or
+ * ucm_next() to include adjuncts.
+ *
  * @devp: On entry, pointer to device to lookup. On exit, returns pointer
  * to the next device in the uclass if no error occurred, or NULL if there is
  * no next device
@@ -393,7 +399,10 @@ void uclass_next_device(struct udevice **devp);
  * uclass_first_device_err() - Get the first device in a uclass
  *
  * The device returned is probed if necessary, and ready for use if no error is
- * returned
+ * returned.
+ *
+ * Note: this skips adjunct members. Use ucm_first_check() to include
+ * adjuncts.
  *
  * @id: Uclass ID to look up
  * @devp: Returns pointer to the first device in that uclass, or NULL if none
@@ -405,7 +414,10 @@ int uclass_first_device_err(enum uclass_id id, struct udevice **devp);
  * uclass_next_device_err() - Get the next device in a uclass
  *
  * The device returned is probed if necessary, and ready for use if no error is
- * returned
+ * returned.
+ *
+ * Note: this skips adjunct members. Use ucm_next_check() to include
+ * adjuncts.
  *
  * @devp: On entry, pointer to device to lookup. On exit, returns pointer
  * to the next device in the uclass if no error occurred, or NULL if
@@ -418,11 +430,14 @@ int uclass_next_device_err(struct udevice **devp);
  * uclass_first_device_check() - Get the first device in a uclass
  *
  * The device returned is probed if necessary, and ready for use if no error is
- * returned
+ * returned.
  *
  * This function is useful to start iterating through a list of devices which
  * are functioning correctly and can be probed.
  *
+ * Note: this skips adjunct members. Use ucm_first_check() to include
+ * adjuncts.
+ *
  * @id: Uclass ID to look up
  * @devp: Returns pointer to the first device in that uclass, or NULL if there
  * is no first device
@@ -435,11 +450,14 @@ int uclass_first_device_check(enum uclass_id id, struct udevice **devp);
  * uclass_next_device_check() - Get the next device in a uclass
  *
  * The device returned is probed if necessary, and ready for use if no error is
- * returned
+ * returned.
  *
  * This function is useful to start iterating through a list of devices which
  * are functioning correctly and can be probed.
  *
+ * Note: this skips adjunct members. Use ucm_next_check() to include
+ * adjuncts.
+ *
  * @devp: On entry, pointer to device to lookup. On exit, returns pointer
  * to the next device in the uclass if any
  * Return: 0 if OK (found or not found), other -ve on error. If an error occurs
@@ -461,6 +479,120 @@ int uclass_next_device_check(struct udevice **devp);
 int uclass_first_device_drvdata(enum uclass_id id, ulong driver_data,
 				struct udevice **devp);
 
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+/**
+ * ucm_find_first() - Find the first uclass member in a uclass
+ *
+ * This returns the first entry in the uclass's member list, including
+ * adjunct registrations. Use ucm->dev to get the device. Unlike
+ * uclass_find_first_device(), this sees adjuncts and provides a cursor
+ * that ucm_find_next() can advance correctly.
+ *
+ * @id: Uclass ID to look up
+ * @ucmp: Returns pointer to the first uclass member, or NULL if none
+ * Return: 0 if OK, -ve on error
+ */
+int ucm_find_first(enum uclass_id id, struct uclass_member **ucmp);
+
+/**
+ * ucm_find_next() - Advance to the next uclass member
+ *
+ * @ucmp: On entry, pointer to current member. On exit, pointer to next
+ * member, or NULL if at end
+ */
+void ucm_find_next(struct uclass_member **ucmp);
+
+/**
+ * ucm_first() - Get the first probed member of a uclass
+ *
+ * Members that fail to probe are skipped.
+ *
+ * @id: Uclass ID to look up
+ * Return: Pointer to the first usable member, or NULL if none
+ */
+struct uclass_member *ucm_first(enum uclass_id id);
+
+/**
+ * ucm_next() - Get the next probed member of a uclass
+ *
+ * Members that fail to probe are skipped.
+ *
+ * @ucm: Current member
+ * Return: Pointer to the next usable member, or NULL if at end
+ */
+struct uclass_member *ucm_next(struct uclass_member *ucm);
+
+/**
+ * ucm_first_check() - Get the first probed member of a uclass
+ *
+ * The device is probed if necessary. On probe error the caller can still
+ * advance to the next member with ucm_next_check().
+ *
+ * @id: Uclass ID to look up
+ * @ucmp: Returns pointer to the first member, or NULL if none
+ * Return: 0 if OK (found or not found), other -ve on error
+ */
+int ucm_first_check(enum uclass_id id, struct uclass_member **ucmp);
+
+/**
+ * ucm_next_check() - Get the next probed member of a uclass
+ *
+ * @ucmp: On entry, pointer to current member. On exit, pointer to next
+ * member, or NULL if at end
+ * Return: 0 if OK (found or not found), other -ve on error
+ */
+int ucm_next_check(struct uclass_member **ucmp);
+
+/**
+ * ucm_first_drvdata() - Find the first member with given driver data
+ *
+ * @id: Uclass ID to look up
+ * @driver_data: Driver data to search for
+ * @ucmp: Returns pointer to the first matching member, if found
+ * Return: 0 if found, -ENODEV if not found, other -ve on error
+ */
+int ucm_first_drvdata(enum uclass_id id, ulong driver_data,
+		      struct uclass_member **ucmp);
+
+/**
+ * ucm_try_first() - See if there is a member for a uclass
+ *
+ * Returns the first member without probing. If the uclass does not exist,
+ * returns NULL.
+ *
+ * @id: Uclass ID to check
+ * Return: Pointer to first member, or NULL if none
+ */
+struct uclass_member *ucm_try_first(enum uclass_id id);
+
+/**
+ * ucm_find_seq() - Find a uclass member by sequence number
+ *
+ * Searches through all members of the given uclass (including adjuncts)
+ * for one with the specified sequence number.
+ *
+ * @id: Uclass ID to look up
+ * @seq: Sequence number to find
+ * @ucmp: Returns pointer to the matching member, or NULL if not found
+ * Return: 0 if found, -ENODEV if not found, other -ve on error
+ */
+int ucm_find_seq(enum uclass_id id, int seq, struct uclass_member **ucmp);
+
+/**
+ * ucm_find_by_ofnode() - Find a uclass member by device-tree node
+ *
+ * Searches through all members of the given uclass (including adjuncts)
+ * for one whose device matches the specified ofnode.
+ *
+ * @id: Uclass ID to look up
+ * @node: Device-tree node to find
+ * @ucmp: Returns pointer to the matching member, or NULL if not found
+ * Return: 0 if found, -ENODEV if not found, other -ve on error
+ */
+int ucm_find_by_ofnode(enum uclass_id id, ofnode node,
+		       struct uclass_member **ucmp);
+#endif /* DM_UC_ADJUNCT */
+
 /**
  * uclass_try_first_device()- See if there is a device for a uclass
  *
@@ -478,6 +610,9 @@ struct udevice *uclass_try_first_device(enum uclass_id id);
  * This function probes all devices associated with a uclass by
  * looking for its ID.
  *
+ * Note: this skips adjunct members. Use uclass_foreach_dev_probe() to
+ * include adjuncts.
+ *
  * @id: uclass ID to look up
  * Return: 0 if OK, other -ve on error
  */
@@ -506,49 +641,86 @@ int uclass_id_count(enum uclass_id id);
  */
 #define uclass_id_foreach_dev(id, pos, uc) \
 	if (!uclass_get(id, &uc)) \
-		list_for_each_entry(pos, &uc->dev_head, ucm.uc_node)
+		uclass_foreach_dev(pos, uc)
+
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+/* Get the first uclass_member from a uclass, or NULL if empty */
+#define _ucm_first(uc)							\
+	(list_empty(&(uc)->dev_head) ? NULL :				\
+	 list_first_entry(&(uc)->dev_head, struct uclass_member, uc_node))
+
+/* Get the device from a uclass_member pointer, or NULL */
+#define _ucm_to_dev(_ucm)	((_ucm) ? (_ucm)->dev : NULL)
+
+/* Get the first primary uclass_member, skipping adjuncts */
+struct uclass_member *_ucm_first_primary(struct uclass *uc);
+
+/* Advance to the next primary uclass_member, skipping adjuncts */
+void _ucm_next_primary(struct uclass_member **ucmp);
 
 /**
  * uclass_foreach_dev() - iterate through devices of a given uclass
  *
  * This creates a for() loop which works through the available devices in
- * a uclass in order from start to end.
+ * a uclass in order from start to end, including adjunct memberships.
  *
  * @pos: struct udevice * to hold the current device. Set to NULL when there
  * are no more devices.
  * @uc: uclass to scan (`struct uclass *`)
  */
-#define uclass_foreach_dev(pos, uc)	\
-	list_for_each_entry(pos, &uc->dev_head, ucm.uc_node)
+#define uclass_foreach_dev(pos, uc)					\
+	for (struct uclass_member *_ucm = _ucm_first(uc);		\
+	     (pos) = _ucm_to_dev(_ucm), pos;				\
+	     ucm_find_next(&_ucm))
 
 /**
  * uclass_foreach_dev_safe() - safely iterate through devices of a given uclass
  *
  * This creates a for() loop which works through the available devices in
- * a uclass in order from start to end. Inside the loop, it is safe to remove
- * @pos if required.
+ * a uclass in order from start to end, including adjunct memberships.
+ * Inside the loop, it is safe to remove @pos if required.
  *
  * @pos: struct udevice * to hold the current device. Set to NULL when there
  * are no more devices.
- * @next: struct udevice * to hold the next next
+ * @next: struct udevice * to hold the next device
  * @uc: uclass to scan (`struct uclass *`)
  */
-#define uclass_foreach_dev_safe(pos, next, uc)	\
-	list_for_each_entry_safe(pos, next, &uc->dev_head, ucm.uc_node)
+#define uclass_foreach_dev_safe(pos, next, uc)				\
+	for (struct uclass_member *_ucm = _ucm_first(uc), *_ucm_n;	\
+	     (pos) = _ucm_to_dev(_ucm),				\
+	     (next) = pos ? (_ucm_n = _ucm, ucm_find_next(&_ucm_n),	\
+			     _ucm_to_dev(_ucm_n)) : NULL,		\
+	     pos;							\
+	     _ucm = _ucm_n)
 
 /**
  * uclass_foreach_dev_probe() - iterate through devices of a given uclass ID
  *
  * This creates a for() loop which works through the available devices in
- * a uclass in order from start to end. Devices are probed if necessary,
- * and ready for use.
+ * a uclass in order from start to end, including adjunct memberships.
+ * Devices are probed if necessary, and ready for use.
  *
  * @id: Uclass ID
  * @dev: struct udevice * to hold the current device. Set to NULL when there
  * are no more devices.
  */
+#define uclass_foreach_dev_probe(id, dev)				\
+	for (struct uclass_member *_ucm = ucm_first(id);		\
+	     (dev) = _ucm_to_dev(_ucm), dev;				\
+	     _ucm = ucm_next(_ucm))
+
+#else /* !DM_UC_ADJUNCT */
+
+#define uclass_foreach_dev(pos, uc)	\
+	list_for_each_entry(pos, &(uc)->dev_head, ucm.uc_node)
+
+#define uclass_foreach_dev_safe(pos, next, uc)	\
+	list_for_each_entry_safe(pos, next, &(uc)->dev_head, ucm.uc_node)
+
 #define uclass_foreach_dev_probe(id, dev)	\
 	for (uclass_first_device(id, &dev); dev; \
 	     uclass_next_device(&dev))
 
+#endif /* DM_UC_ADJUNCT */
+
 #endif
-- 
2.43.0

