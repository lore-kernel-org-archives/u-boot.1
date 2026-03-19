Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FB41091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AEDE84132;
	Thu, 19 Mar 2026 22:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bEy5Sy/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C635840AE; Thu, 19 Mar 2026 22:36:55 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F628405B
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7653db148so619855a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956211; x=1774561011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWFuA7SsfTDy17lMTo6TdUjylAXBJJhgqo5rqGW1CRw=;
 b=bEy5Sy/tERp/KOwlXKQvTtoOtwxe9hBsZe+jOPGeBV2Uhzl2WdlI4lqEJ9q7JH/aP1
 VOaB9aV46scS5PxqPxuqDSXgsdUXxk9XcPduAcglM26iknrUm9bFS+sImTh7yJqat/TS
 5asgSstj3LDzoTDHhiX0OSR6th1HN4FkLEyOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956211; x=1774561011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWFuA7SsfTDy17lMTo6TdUjylAXBJJhgqo5rqGW1CRw=;
 b=gWPPsMd9snXm6Uy+7ziYEoq4ijKQ80StalZzZ9vfT6/lO21TOavVyLhvBqn5B8kLYq
 OZlXuOxKyFtEMSrMXPFjDkFu/d11SMIoAgKIPFT+XiNy6tqHpoSbDqD+H+3Etq03O38N
 b5RAt4s1XvDYG4F7kf+XTqasz+2ybkJKN2QXe53dDNxh4NM1Z5+7PH5erVp8zKPY8q47
 j2c7Az7lDMoJGbFMYJ63ltRjY+bYNvhVmbS0sAv51lT6xrkub/iEG+fINNG00Ic0v9J/
 8EG5pSR0MCZmdSNsy6OK9HSC4FL4Rqqp3ycmnX5nyXlDA1T5xUmYnuF0a/KIhkvKpWS8
 jaWA==
X-Gm-Message-State: AOJu0Yx6R8KgdQB4tIeqrsSx8D2jzuKv+bCg2gm/i1HOntICZHMXZPqu
 FQ/Yx5tDtnfpKN2QqIo1BeeRdj8zo92Xbk0KvoFy1Lv9a+iAJpR9PP+ipoDqqbAYQ+SC3wZvtaJ
 dloNtFw==
X-Gm-Gg: ATEYQzyZxMtuvTW8LL9H7ASdCJ3hKgayL+7Cb96V/O7kA9c/cDLLHFPcuSSWHZj62pi
 KEPKOjWJn1aVmgXOjQhYh4qszPn4veOagw3nfQgVGeCEXHvJJzdwQ9qabv0F9n9BKj753Febz5N
 ebVey6PydJjZjO7z3sFr5mxplLgO9mFubEybR2OZmRt354zm2nHoQT3MqBy7CdCOWayVfZP/WOc
 SzCJsTUa5CtB9XTy7G1BYmrwsdDKC+Eh3RX8L5sS3xw9Q1qghIHR6XF9Fu1A+9fWBYY+hu48B9F
 9TE63KDNDtACQQTvroxRtN/eTj626dfEQF5pcIKcX1ql18whxZlpjK4Bi66JEXYTEhP/w7cXqvw
 lS3JCltr0JZ3j/+JNq8tJKt1vAAwxOfFnMULfkR99aZhNvCBrUTGBeNE5rKDRiUv7RMYV04Mryu
 bi1JB7QDKKsfeRPml+w25TPpJvGuPc
X-Received: by 2002:a05:6830:4491:b0:7d7:d332:7af8 with SMTP id
 46e09a7af769-7d7eaecce1amr542115a34.13.1773956211114; 
 Thu, 19 Mar 2026 14:36:51 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 11/15] dm: core: Add static adjunct declarations for
 drivers
Date: Thu, 19 Mar 2026 15:35:41 -0600
Message-ID: <20260319213551.267031-12-sjg@chromium.org>
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

Add struct driver_adjunct and a .adjuncts field to struct driver,
allowing drivers to declare adjunct uclass memberships at compile time.
The core registers these automatically during probe via
device_bind_static_adjs(), before the driver's probe() runs.

This removes the need for custom probe functions that only call
device_add_uclass_adj(). The dynamic API remains available for cases
where adjuncts are conditional.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/adjunct.c       | 17 +++++++++++++++++
 drivers/core/device.c        |  4 ++++
 include/dm/device-internal.h | 16 ++++++++++++++++
 include/dm/device.h          | 21 +++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/drivers/core/adjunct.c b/drivers/core/adjunct.c
index 802d2761e6b..0e247bd4cb9 100644
--- a/drivers/core/adjunct.c
+++ b/drivers/core/adjunct.c
@@ -150,6 +150,23 @@ void *device_get_uclass_plat(struct udevice *dev, enum uclass_id id)
 	return device_get_adj_uclass_plat(dev, id);
 }
 
+int device_bind_static_adjs(struct udevice *dev)
+{
+	const struct driver_adjunct *adj = dev->driver->adjuncts;
+	int ret;
+
+	if (!adj)
+		return 0;
+
+	for (; adj->id; adj++) {
+		ret = device_bind_adj_(dev, adj->id, adj->ops);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int device_probe_adjs_(struct udevice *dev)
 {
 	struct uclass_driver *uc_drv;
diff --git a/drivers/core/device.c b/drivers/core/device.c
index 2b7b3528e4c..fb35488e70c 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -168,6 +168,10 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	if (ret)
 		goto fail_uclass_bind;
 
+	ret = device_bind_static_adjs(dev);
+	if (ret)
+		goto fail_uclass_bind;
+
 	/* if we fail to bind we remove device from successors and free it */
 	if (drv->bind) {
 		ret = drv->bind(dev);
diff --git a/include/dm/device-internal.h b/include/dm/device-internal.h
index a129ddecf87..fdba288d55c 100644
--- a/include/dm/device-internal.h
+++ b/include/dm/device-internal.h
@@ -519,6 +519,17 @@ void *device_get_adj_uclass_priv(struct udevice *dev, enum uclass_id id);
  */
 void *device_get_adj_uclass_plat(struct udevice *dev, enum uclass_id id);
 
+/**
+ * device_bind_static_adjs() - Register statically declared adjuncts
+ *
+ * Called during bind to register any adjuncts declared in the driver's
+ * adjuncts array.
+ *
+ * @dev: Device to register static adjuncts for
+ * Return: 0 if OK, -ve on error
+ */
+int device_bind_static_adjs(struct udevice *dev);
+
 /**
  * device_probe_adjs_() - Allocate private data for adjunct uclasses
  *
@@ -581,6 +592,11 @@ static inline void *device_get_adj_uclass_plat(struct udevice *dev,
 	return NULL;
 }
 
+static inline int device_bind_static_adjs(struct udevice *dev)
+{
+	return 0;
+}
+
 static inline int device_probe_adjs_(struct udevice *dev)
 {
 	return 0;
diff --git a/include/dm/device.h b/include/dm/device.h
index d93690d7a8b..4832a1ff634 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -354,6 +354,20 @@ struct udevice_id {
 #define of_match_ptr(_ptr)	NULL
 #endif /* CONFIG_IS_ENABLED(OF_CONTROL) */
 
+/**
+ * struct driver_adjunct - Static adjunct declaration for a driver
+ *
+ * Allows a driver to declare membership in additional uclasses at compile
+ * time, rather than calling device_add_uclass_adj() dynamically.
+ *
+ * @id: Uclass ID for this adjunct membership
+ * @ops: Operations provided by this driver for the adjunct uclass
+ */
+struct driver_adjunct {
+	enum uclass_id id;
+	const void *ops;
+};
+
 /**
  * struct driver - A driver for a feature or peripheral
  *
@@ -399,6 +413,10 @@ struct udevice_id {
  * pointers defined by the driver, to implement driver functions required by
  * the uclass.
  * @flags: driver flags - see `DM_FLAG_...`
+ * @adjuncts: Sentinel-terminated array of static adjunct declarations, or
+ * NULL if the driver does not statically declare any adjuncts. Each entry
+ * specifies a uclass ID and ops pointer. The core registers these during
+ * probe, before calling the driver's probe function.
  * @acpi_ops: Advanced Configuration and Power Interface (ACPI) operations,
  * allowing the device to add things to the ACPI tables passed to Linux
  */
@@ -420,6 +438,9 @@ struct driver {
 	int per_child_plat_auto;
 	const void *ops;	/* driver-specific operations */
 	uint32_t flags;
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+	const struct driver_adjunct *adjuncts;
+#endif
 #if CONFIG_IS_ENABLED(ACPIGEN)
 	struct acpi_ops *acpi_ops;
 #endif
-- 
2.43.0

