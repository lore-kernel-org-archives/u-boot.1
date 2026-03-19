Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8421091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9EA484113;
	Thu, 19 Mar 2026 22:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RDTcB7ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A943838FA; Thu, 19 Mar 2026 22:36:54 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C845840CF
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so1025464a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956209; x=1774561009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWMygFCcaAcGGeCEQBeF/e75DdaB60YdLR6r5LIdjDo=;
 b=RDTcB7ni1+3mpWA2m1smLYgx99PGDGi3MyE6WccTcwPE4x6qtjkX6/xvXuz7ptv+Xp
 JLawAHGy0xozrGrjjHPg9SUi7WeHNBQxzoZnH1Oece/ZbEnrBXHuBKU4M+nUUMw1JYHx
 CLe4uUJwbj491PEga3wT6mFfQDEufrOQDUvM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956209; x=1774561009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWMygFCcaAcGGeCEQBeF/e75DdaB60YdLR6r5LIdjDo=;
 b=grzb1wyzVstrwdneStYXvS7BmJ2mErMkudvBEHsOpwYyYE51Sd9k2skYmwADioepTf
 px8/4hq4a5SZMgZocL2Tpop8RMG50zAGoT1oUA5J6YstqKGrAsgNbkhPhXDjb0R51wqX
 bTPlspW2lVepAnLfZZ63XtIMwZ3Kt6HZpTwI2XF+IiWaWEyDg+6v1/KIdVbBAbM8CzfV
 OXb7ti5BNHfkZnTmnoxSAsXH9znpG1ajSJWKX4brr0O0aBhaVv/sKD+WAAa3JS62nzOH
 ycNrm3yaP59qKx0n4ziRg8pGjmxWQECRV/RCp4iTPDVvRep8RmXlr1P6Qqz9gDq7EFgF
 +0Tw==
X-Gm-Message-State: AOJu0YxGAdOB6gu5zoov8QDXbSlGeMOYUBbOeqivSxsiaCcnA6rVAtcT
 XeZEgwxXni5MyFL1kwb9diFUWveCuJmep+z5TS/CHgKczTJ6Vt0Yx9rSS0x7QTa/ocMNjnRCKbR
 /tlIIKw==
X-Gm-Gg: ATEYQzyZDK5pBMhIZksKnV8hjAoZ+lM4QhkYrAPCuOe9WyejzkN7TfH5NZWMSUoXMPg
 JfOjyzeP008JPWfsV/9xXUWNz+P0j0GPRaZuKA0+mJcoCLi2P18XpidffqzcU9vipq49fjC0OWf
 q5De4QylPLRw19VpPcTmC/+Udux1B1vxUmz0o0rQRD27ruXtGLBTD826McSV8hA4sqgdjwCTLAe
 ruZGKad+Qgt8igcqp6tZD9NgtjXIcTl1AqMSbggWEw9PiyEzpA3v/W5Y8naHZHFCqgTvyq6EYCo
 p4OiTKoa1dhcduJvrTLwaY1sAt6erAxIWdwYqjqh6Cu1jUGLav6S8bGKIEAB00hO8sv79FFM4aC
 K0m8N/eiBuCQ+tkyuhyIxP+WiGNMizjdHH3L5wmwhLNc7dTChaXhcXNz7RiuIJi7aGoUfzAzXg3
 SSR87PzTvAe03I2ljX4IqoX8qOoij3
X-Received: by 2002:a05:6830:7306:b0:7d7:bf57:49b6 with SMTP id
 46e09a7af769-7d7eafd912bmr554102a34.29.1773956209455; 
 Thu, 19 Mar 2026 14:36:49 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 10/15] dm: core: Add uclass-ID-keyed accessors for priv
 and plat
Date: Thu, 19 Mar 2026 15:35:40 -0600
Message-ID: <20260319213551.267031-11-sjg@chromium.org>
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

Add device_get_uclass_priv_by_id() and device_get_uclass_plat_by_id()
which search both primary and adjunct memberships for the matching
uclass ID. This allows subsystem code to retrieve the correct
per-device uclass data regardless of whether the device was found
via its primary uclass or an adjunct.

When DM_UC_ADJUNCT is disabled, these map to dev_get_uclass_priv()
and dev_get_uclass_plat() respectively, with no overhead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/adjunct.c | 23 +++++++++++++++++++++++
 drivers/core/device.c  | 16 ++++------------
 include/dm/device.h    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/core/adjunct.c b/drivers/core/adjunct.c
index 07fd0917050..802d2761e6b 100644
--- a/drivers/core/adjunct.c
+++ b/drivers/core/adjunct.c
@@ -76,6 +76,19 @@ int device_add_uclass_adj(struct udevice *dev, enum uclass_id id,
 	return ret;
 }
 
+const void *device_get_uclass_ops(struct udevice *dev, enum uclass_id id)
+{
+	struct uclass_member *ucm;
+
+	/* Walk primary + adjunct memberships for matching uclass */
+	list_for_each_entry(ucm, &dev->adj_head, adj_node) {
+		if (ucm->uc->uc_drv->id == id)
+			return ucm->ops;
+	}
+
+	return NULL;
+}
+
 void *device_get_adj_uclass_priv(struct udevice *dev, enum uclass_id id)
 {
 	struct uclass_member *ucm;
@@ -127,6 +140,16 @@ int ucm_alloc_priv(struct uclass_member *ucm)
 	return 0;
 }
 
+void *device_get_uclass_priv(struct udevice *dev, enum uclass_id id)
+{
+	return device_get_adj_uclass_priv(dev, id);
+}
+
+void *device_get_uclass_plat(struct udevice *dev, enum uclass_id id)
+{
+	return device_get_adj_uclass_plat(dev, id);
+}
+
 int device_probe_adjs_(struct udevice *dev)
 {
 	struct uclass_driver *uc_drv;
diff --git a/drivers/core/device.c b/drivers/core/device.c
index ba3c5b9a28e..2b7b3528e4c 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -1193,23 +1193,15 @@ void dev_int_set_seq(struct udevice *dev, int seq)
 	dev->ucm.seq = seq;
 }
 
+#if !CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
 const void *device_get_uclass_ops(struct udevice *dev, enum uclass_id id)
 {
-	if (CONFIG_IS_ENABLED(DM_UC_ADJUNCT)) {
-		struct uclass_member *ucm;
-
-		/* Walk primary + adjunct memberships for matching uclass */
-		list_for_each_entry(ucm, &dev->adj_head, adj_node) {
-			if (ucm->uc->uc_drv->id == id)
-				return ucm->ops;
-		}
-	} else {
-		if (dev->ucm.uc->uc_drv->id == id)
-			return dev->driver->ops;
-	}
+	if (dev->ucm.uc->uc_drv->id == id)
+		return dev->driver->ops;
 
 	return NULL;
 }
+#endif
 
 #if CONFIG_IS_ENABLED(OF_REAL)
 bool device_is_compatible(const struct udevice *dev, const char *compat)
diff --git a/include/dm/device.h b/include/dm/device.h
index 2a78911b942..d93690d7a8b 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -462,6 +462,40 @@ static inline int device_add_uclass_adj(struct udevice *dev,
 }
 #endif
 
+/**
+ * device_get_uclass_priv() - Get uclass private data by uclass ID
+ *
+ * Return the per-device uclass private data for the given uclass ID,
+ * searching both primary and adjunct memberships. When DM_UC_ADJUNCT is
+ * not enabled, this simply returns the primary uclass private data.
+ *
+ * @dev: Device to query
+ * @id: Uclass ID to look up private data for
+ * Return: private data pointer, or NULL if not found
+ */
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+void *device_get_uclass_priv(struct udevice *dev, enum uclass_id id);
+#else
+#define device_get_uclass_priv(dev, id)	dev_get_uclass_priv(dev)
+#endif
+
+/**
+ * device_get_uclass_plat() - Get uclass platform data by uclass ID
+ *
+ * Return the per-device uclass platform data for the given uclass ID,
+ * searching both primary and adjunct memberships. When DM_UC_ADJUNCT is
+ * not enabled, this simply returns the primary uclass platform data.
+ *
+ * @dev: Device to query
+ * @id: Uclass ID to look up platform data for
+ * Return: platform data pointer, or NULL if not found
+ */
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+void *device_get_uclass_plat(struct udevice *dev, enum uclass_id id);
+#else
+#define device_get_uclass_plat(dev, id)	dev_get_uclass_plat(dev)
+#endif
+
 /**
  * U_BOOT_DRIVER() - Declare a new U-Boot driver
  * @__name: name of the driver
-- 
2.43.0

