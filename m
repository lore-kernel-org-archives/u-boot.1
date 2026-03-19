Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1F1091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2F483FF5;
	Thu, 19 Mar 2026 22:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8/DZ9Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086C98409B; Thu, 19 Mar 2026 22:36:52 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BFD83FEC
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7653db148so619825a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956206; x=1774561006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C3QJ9qasIh+TfKLmtsKFdTAoHOe3YJCNedu0MBCPPo=;
 b=e8/DZ9LohaBfYHslkgs+cAqacwyxm9QpUPV4YhK3GpHbzBccYNLH7JqL3r7o4RSiAd
 z5i5k0uHaX+afd02gh7KjU2Js0HRsnNLt0WWk56qBt0qwlYEXZ/EirNPNSEW5kNkOHto
 rOqIXxCbe0J3lP+e6Tc1tubuuoGHkJfJ5aiV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956206; x=1774561006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/C3QJ9qasIh+TfKLmtsKFdTAoHOe3YJCNedu0MBCPPo=;
 b=YUcvqswGswbSTvguKKj96T7jzQsZ3hrgoj10GR6DNYBkPqo7DS7UNon8bPKGjQHbFZ
 DKV4LOOYE2+3LHQu3VNNRJ0ozg3ZPcsyA1ZQQ4zB0Xn516DpUfTiFTz1QjtZ6wTYN8qd
 Cxk74kZWCyW3R1+eAZ1R0tnaoTNwd0eZ7GLhGj0+/osupxoTidnYUeNUoesXdtjAf8Qm
 ZHO8+kdxozl9yzIORP6ZY5Qg5NRQ5+tFMm0uebr9WE43VYoM5Xh+zxsTmHrxsD2/jk4/
 1sZu/5qJ56/pRiXwbHahQ9q+z9ucwVCpv63llMiw7Ui1lt+3oX6o2W/jDJQS1JTAV1iC
 Jzig==
X-Gm-Message-State: AOJu0YwIFUx33R6AgPPd94cnE/YBuNvoNbP/4nPw8XHhDg37nudRtXBv
 fnbcffENXdpX90BOIpPfP2deduUCr3Y73LItB5kcJepwVBH4WWZN6A45lFDF3uBxSXm5G5wtjHb
 8Pz08Yw==
X-Gm-Gg: ATEYQzznh+v7ip60GfvsCaud1VlfPB+emI1GST//WziIf5oNe6k89dZMVaHZQt/7G0F
 UKW9xmV+5cwFfnOVVcblcojrMzaFcM+VFEwdJRXg6eIehRSzMsx0nSPdZ3AA6IrO3DVY5hW/7mz
 GEWqqDBJoGqAOh7ShwlI5eAhdTIAg2kpDn7lgFfLz7gYrQAXSYzcP6hFvTQlwqZRp0z9lBalV5Y
 RFnscV8zJLqFlfDFKiY9tmXaO2k1iRNOtkqVV+razM+dpXkCsT7pKZl+G8R4wh3XXEX9s7IZFXu
 PgJxR/Gxjl88NCJgHLaTrbW8th0MfPv+XsBusYDRY8hJStUpVeptIsiJ3X23JqrzwNuQutPXzv9
 g0LqiPF6VK+H+tk9avYbHIwNBNpuH9fKLIX0Ghur9y7ZakvpPJ8EFv3T9iXE4QDzGwxmBr80rmo
 Hl5PtWrGuZDeE64pcGow==
X-Received: by 2002:a05:6830:668f:b0:7d7:e7f9:6b35 with SMTP id
 46e09a7af769-7d7eafb18c4mr518667a34.25.1773956205555; 
 Thu, 19 Mar 2026 14:36:45 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 08/15] dm: core: Add a uclass-adjunct API
Date: Thu, 19 Mar 2026 15:35:38 -0600
Message-ID: <20260319213551.267031-9-sjg@chromium.org>
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

Add the adjunct API and its implementation, allowing a device to
register in additional uclasses beyond its primary one.

Most of the code lives in a new adjunct.c file, with its functions
called from elsewhere in driver model.

Add shared ucm_alloc_plat() and ucm_alloc_priv() helpers used by both
the primary bind/probe path and adjuncts, to avoid duplicating the
allocation logic.

Add a new device_get_uclass_ops() function to look up ops by uclass ID;
this maps to device_get_ops() when DM_UC_ADJUNCT is disabled to avoid
adding to code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/Makefile        |   1 +
 drivers/core/adjunct.c       | 209 +++++++++++++++++++++++++++++++++++
 drivers/core/device.c        |  20 +++-
 include/dm/device-internal.h | 165 +++++++++++++++++++++++++++
 include/dm/device.h          |  40 +++++++
 5 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/adjunct.c

diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b..4733e05e3d3 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -6,6 +6,7 @@ obj-y	+= device.o fdtaddr.o lists.o root.o uclass.o util.o tag.o
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
+obj-$(CONFIG_$(PHASE_)DM_UC_ADJUNCT)	+= adjunct.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)	+= simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
diff --git a/drivers/core/adjunct.c b/drivers/core/adjunct.c
new file mode 100644
index 00000000000..07fd0917050
--- /dev/null
+++ b/drivers/core/adjunct.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Uclass adjunct support
+ *
+ * Copyright 2026 Canonical Ltd.
+ * Simon Glass <simon.glass@canonical.com>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
+
+void device_init_adj(struct udevice *dev)
+{
+	INIT_LIST_HEAD(&dev->adj_head);
+	dev->ucm.ops = dev->driver->ops;
+	list_add(&dev->ucm.adj_node, &dev->adj_head);
+}
+
+int device_bind_adj_(struct udevice *dev, enum uclass_id id, const void *ops)
+{
+	struct uclass_member *ucm;
+	struct uclass *uc;
+	int ret;
+
+	ret = uclass_get(id, &uc);
+	if (ret)
+		return ret;
+
+	ucm = calloc(1, sizeof(*ucm));
+	if (!ucm)
+		return -ENOMEM;
+
+	ucm->dev = dev;
+	ucm->uc = uc;
+	ucm->ops = ops;
+	ucm->seq = uclass_find_next_free_seq(uc);
+
+	ret = ucm_alloc_plat(ucm);
+	if (ret)
+		goto err_ucm;
+
+	list_add_tail(&ucm->adj_node, &dev->adj_head);
+	list_add_tail(&ucm->uc_node, &uc->dev_head);
+
+	if (uc->uc_drv->post_bind) {
+		ret = uc->uc_drv->post_bind(dev);
+		if (ret)
+			goto err_list;
+	}
+
+	return 0;
+
+err_list:
+	list_del(&ucm->uc_node);
+	list_del(&ucm->adj_node);
+	free(ucm->uc_plat);
+err_ucm:
+	free(ucm);
+	return ret;
+}
+
+int device_add_uclass_adj(struct udevice *dev, enum uclass_id id,
+			  const void *ops)
+{
+	int ret;
+
+	ret = device_bind_adj_(dev, id, ops);
+	if (ret)
+		return ret;
+
+	if (device_active(dev))
+		ret = device_probe_adjs_(dev);
+
+	return ret;
+}
+
+void *device_get_adj_uclass_priv(struct udevice *dev, enum uclass_id id)
+{
+	struct uclass_member *ucm;
+
+	list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+		if (ucm->uc->uc_drv->id == id)
+			return ucm->uc_priv;
+	}
+
+	return NULL;
+}
+
+void *device_get_adj_uclass_plat(struct udevice *dev, enum uclass_id id)
+{
+	struct uclass_member *ucm;
+
+	list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+		if (ucm->uc->uc_drv->id == id)
+			return ucm->uc_plat;
+	}
+
+	return NULL;
+}
+
+int ucm_alloc_plat(struct uclass_member *ucm)
+{
+	int size = ucm->uc->uc_drv->per_device_plat_auto;
+
+	if (size) {
+		ucm->uc_plat = calloc(1, size);
+		if (!ucm->uc_plat)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int ucm_alloc_priv(struct uclass_member *ucm)
+{
+	struct uclass_driver *uc_drv = ucm->uc->uc_drv;
+
+	if (uc_drv->per_device_auto && !ucm->uc_priv) {
+		ucm->uc_priv = alloc_priv(uc_drv->per_device_auto,
+					  uc_drv->flags);
+		if (!ucm->uc_priv)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int device_probe_adjs_(struct udevice *dev)
+{
+	struct uclass_driver *uc_drv;
+	struct uclass_member *ucm;
+	int ret;
+
+	list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+		if (ucm_is_primary(ucm))
+			continue;
+		if (ucm_alloc_priv(ucm))
+			return -ENOMEM;
+
+		uc_drv = ucm->uc->uc_drv;
+		if (uc_drv->post_probe) {
+			ret = uc_drv->post_probe(dev);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ucm_free(struct uclass_member *ucm)
+{
+	list_del(&ucm->uc_node);
+	list_del(&ucm->adj_node);
+	free(ucm->uc_priv);
+	free(ucm->uc_plat);
+	free(ucm);
+}
+
+int device_remove_adjs(struct udevice *dev)
+{
+	struct uclass_member *ucm;
+	int ret;
+
+	list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+		if (!ucm_is_primary(ucm)) {
+			if (ucm->uc->uc_drv->pre_remove) {
+				ret = ucm->uc->uc_drv->pre_remove(dev);
+				if (ret)
+					return ret;
+			}
+			free(ucm->uc_priv);
+			ucm->uc_priv = NULL;
+		}
+	}
+
+	return 0;
+}
+
+int device_unbind_adjs(struct udevice *dev)
+{
+	struct uclass_member *ucm, *tmp;
+	int ret;
+
+	list_for_each_entry_safe(ucm, tmp, &dev->adj_head, adj_node) {
+		if (!ucm_is_primary(ucm)) {
+			if (ucm->uc->uc_drv->pre_unbind) {
+				ret = ucm->uc->uc_drv->pre_unbind(dev);
+				if (ret)
+					return ret;
+			}
+			ucm_free(ucm);
+		}
+	}
+
+	return 0;
+}
+
+void uclass_destroy_adjs(struct uclass *uc)
+{
+	struct uclass_member *ucm, *tmp;
+
+	list_for_each_entry_safe(ucm, tmp, &uc->dev_head, uc_node) {
+		if (!ucm_is_primary(ucm))
+			ucm_free(ucm);
+	}
+}
diff --git a/drivers/core/device.c b/drivers/core/device.c
index f90c436e0a9..1de392238f8 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -301,7 +301,7 @@ int device_reparent(struct udevice *dev, struct udevice *new_parent)
 	return 0;
 }
 
-static void *alloc_priv(int size, uint flags)
+void *alloc_priv(int size, uint flags)
 {
 	void *priv;
 
@@ -1186,6 +1186,24 @@ void dev_int_set_seq(struct udevice *dev, int seq)
 	dev->ucm.seq = seq;
 }
 
+const void *device_get_uclass_ops(struct udevice *dev, enum uclass_id id)
+{
+	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
+		struct uclass_member *ucm;
+
+		/* Walk primary + adjunct memberships for matching uclass */
+		list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+			if (ucm->uc->uc_drv->id == id)
+				return ucm->ops;
+		}
+	} else {
+		if (dev->ucm.uc->uc_drv->id == id)
+			return dev->driver->ops;
+	}
+
+	return NULL;
+}
+
 #if CONFIG_IS_ENABLED(OF_REAL)
 bool device_is_compatible(const struct udevice *dev, const char *compat)
 {
diff --git a/include/dm/device-internal.h b/include/dm/device-internal.h
index 9382c6c23de..a129ddecf87 100644
--- a/include/dm/device-internal.h
+++ b/include/dm/device-internal.h
@@ -16,6 +16,8 @@
 
 struct device_node;
 struct driver_info;
+struct uclass;
+struct uclass_member;
 struct udevice;
 
 /*
@@ -440,4 +442,167 @@ static inline int device_notify(const struct udevice *dev, enum event_t type)
 
 void dev_int_set_seq(struct udevice *dev, int seq);
 
+/**
+ * alloc_priv() - Allocate private data with optional DMA alignment
+ *
+ * @size: Size of the allocation
+ * @flags: Driver flags (DM_FLAG_ALLOC_PRIV_DMA for DMA-aligned allocation)
+ * Return: pointer to allocated memory, or NULL on failure
+ */
+void *alloc_priv(int size, uint flags);
+
+/**
+ * ucm_alloc_plat() - Allocate uclass platform data for a uclass member
+ *
+ * Uses per_device_plat_auto from the uclass driver to allocate uc_plat.
+ * Called at bind time for both primary and adjunct memberships.
+ *
+ * @ucm: uclass member to allocate for
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int ucm_alloc_plat(struct uclass_member *ucm);
+
+/**
+ * ucm_alloc_priv() - Allocate uclass private data for a uclass member
+ *
+ * Uses per_device_auto from the uclass driver to allocate uc_priv.
+ * Called at probe time for both primary and adjunct memberships.
+ *
+ * @ucm: uclass member to allocate for
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int ucm_alloc_priv(struct uclass_member *ucm);
+
+/**
+ * ucm_is_primary() - Check if a uclass member is the primary membership
+ *
+ * Each device has an embedded uclass_member for its primary uclass.
+ * Adjunct memberships are separately allocated. This macro distinguishes
+ * between the two.
+ *
+ * @ucm: uclass member to check
+ * Return: true if @ucm is the device's primary uclass membership
+ */
+#define ucm_is_primary(_ucm)	((_ucm) == &(_ucm)->dev->ucm)
+
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+/**
+ * device_bind_adj_() - Bind an adjunct uclass for a device
+ *
+ * Allocates a uclass_member, assigns ops, allocates uclass platform data
+ * and adds the device to the adjunct uclass's member list. Uclass private
+ * data is allocated later by device_probe_adjs_() at probe time.
+ *
+ * @dev: Device to add the adjunct to
+ * @id: Uclass ID for the adjunct uclass
+ * @ops: Operations pointer for the adjunct uclass
+ * Return: 0 if OK, -ve on error
+ */
+int device_bind_adj_(struct udevice *dev, enum uclass_id id,
+		     const void *ops);
+
+/**
+ * device_get_adj_uclass_priv() - Get uclass private data for an adjunct
+ *
+ * @dev: Device to query
+ * @id: Uclass ID of the adjunct uclass
+ * Return: private data pointer, or NULL if not found
+ */
+void *device_get_adj_uclass_priv(struct udevice *dev, enum uclass_id id);
+
+/**
+ * device_get_adj_uclass_plat() - Get uclass platform data for an adjunct
+ *
+ * @dev: Device to query
+ * @id: Uclass ID of the adjunct uclass
+ * Return: platform data pointer, or NULL if not found
+ */
+void *device_get_adj_uclass_plat(struct udevice *dev, enum uclass_id id);
+
+/**
+ * device_probe_adjs_() - Allocate private data for adjunct uclasses
+ *
+ * Called during probe to allocate per_device_auto data for each adjunct.
+ *
+ * @dev: Device to probe adjuncts for
+ * Return: 0 if OK, -ve on error
+ */
+int device_probe_adjs_(struct udevice *dev);
+
+/**
+ * device_remove_adjs() - Remove adjunct uclasses from a device
+ *
+ * Called during remove to free per_device_auto data for each adjunct.
+ * The adjuncts remain bound.
+ *
+ * @dev: Device to remove adjunct private data for
+ * Return: 0 if OK, -ve on error
+ */
+int device_remove_adjs(struct udevice *dev);
+
+/**
+ * device_unbind_adjs() - Unbind all adjuncts from a device
+ *
+ * @dev: Device to unbind adjuncts from
+ * Return: 0 if OK, -ve on error
+ */
+int device_unbind_adjs(struct udevice *dev);
+
+/**
+ * device_init_adj() - Initialise the adjunct list for a device
+ *
+ * @dev: Device to initialise
+ */
+void device_init_adj(struct udevice *dev);
+
+/**
+ * uclass_destroy_adjs() - Destroy all adjuncts in a uclass
+ *
+ * @uc: Uclass to clean up
+ */
+void uclass_destroy_adjs(struct uclass *uc);
+#else
+static inline int device_bind_adj_(struct udevice *dev,
+				   enum uclass_id id,
+				   const void *ops)
+{
+	return -ENOSYS;
+}
+
+static inline void *device_get_adj_uclass_priv(struct udevice *dev,
+					       enum uclass_id id)
+{
+	return NULL;
+}
+
+static inline void *device_get_adj_uclass_plat(struct udevice *dev,
+					       enum uclass_id id)
+{
+	return NULL;
+}
+
+static inline int device_probe_adjs_(struct udevice *dev)
+{
+	return 0;
+}
+
+static inline int device_remove_adjs(struct udevice *dev)
+{
+	return 0;
+}
+
+static inline int device_unbind_adjs(struct udevice *dev)
+{
+	return 0;
+}
+
+static inline void device_init_adj(struct udevice *dev)
+{
+}
+
+static inline void uclass_destroy_adjs(struct uclass *uc)
+{
+}
+#endif /* DM_UC_ADJUNCT */
+
 #endif
diff --git a/include/dm/device.h b/include/dm/device.h
index ebc253397a4..2a78911b942 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -203,6 +203,9 @@ struct udevice {
 	struct udevice *parent;
 	void *priv_;
 	struct uclass_member ucm;
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+	struct list_head adj_head;
+#endif
 	void *parent_priv_;
 	struct list_head child_head;
 	struct list_head sibling_node;
@@ -422,6 +425,43 @@ struct driver {
 #endif
 };
 
+/**
+ * device_get_uclass_ops() - Get the ops for a device in a given uclass
+ *
+ * If the device's driver provides ops for the given uclass (either as its
+ * primary uclass or via an adjunct registration), return them.
+ *
+ * @dev: Device to query
+ * @id: Uclass ID to look up ops for
+ * Return: ops pointer, or NULL if not found
+ */
+const void *device_get_uclass_ops(struct udevice *dev, enum uclass_id id);
+
+/**
+ * device_add_uclass_adj() - Add an adjunct uclass for a device
+ *
+ * Binds the adjunct and, if the device is already probed, also allocates
+ * uclass private data. This is the main entry point for drivers that need
+ * to register an adjunct dynamically: it does the right thing regardless of
+ * whether it is called from bind() or probe()
+ *
+ * @dev: Device to add the adjunct to
+ * @id: Uclass ID for the adjunct uclass
+ * @ops: Operations pointer for the adjunct uclass
+ * Return: 0 if OK, -ve on error
+ */
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+int device_add_uclass_adj(struct udevice *dev, enum uclass_id id,
+			  const void *ops);
+#else
+static inline int device_add_uclass_adj(struct udevice *dev,
+					enum uclass_id id,
+					const void *ops)
+{
+	return -ENOSYS;
+}
+#endif
+
 /**
  * U_BOOT_DRIVER() - Declare a new U-Boot driver
  * @__name: name of the driver
-- 
2.43.0

