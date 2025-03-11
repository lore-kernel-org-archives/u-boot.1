Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEABAC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6C48186D;
	Tue, 11 Mar 2025 17:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L3gnh5iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BAD81875; Tue, 11 Mar 2025 17:48:17 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2577781761
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso35742835ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711693; x=1742316493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2SHSNdurTjknbe4KCVm1yu1j2sgqKcGMnqIfMFtLbo=;
 b=L3gnh5iYI4NyP1akohmVk1aoDxIW5ZSOCBO6cE/+G85xupJE/oZ9z/+ZYLWmI1kHrI
 yVbfkmaLGv5Ae9rRRYtonTVG+4zc3Mm7d9nTXh0yj0tohj18fhfIeThwue7Md15p0NX8
 c//CvvqSuHBxwuec5k0C30RKg1N+YhowzCbKYewMaabMIuJxAl9XhwQfv6c/SnAQ/qDW
 I+dAMow9+T5PLIch7VTBOQW46UdX01g56Cyv3WgJ/j9BBeUdKAK7Vc/Rc2e99n/7oBEv
 VCkG9nAs3AeyhnVuGQdw9MH+5Yreq8esSaVFwRVILPs5b8TTdZ03xYM6vWIpZDLiYHc+
 KMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711693; x=1742316493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2SHSNdurTjknbe4KCVm1yu1j2sgqKcGMnqIfMFtLbo=;
 b=ONO8xrrkvteRVKs+VZOrg4/xm4WMEiXdn5aBLUE+ugtQNORWFB0NTRAH2nVou042FW
 +TY64ztfoM/Md1tsrKcP15QFH0giSiQvaW8Ao0PpLqiJl7lqBgvRU6NzkGOREpV9+kJs
 3L68SAjdpI3qjCs5dvWFGb8/W6OQWsCd6RM7uWWQCkAAKi0rzCiuHtg5V3vsssz7qZ8H
 508GsQ2y+xPvI8yTh0ofrPW+iCdcZeGqTV6G2C4vQZXWO6wMJ6GfG7FBGKhgQaj0xHbn
 HXbDL73RHebdzI7ziY/hyi/mHTUmXZMkHxD2hqul04cWENaAVzPbQ1DMY9wfHcYoaVgd
 1OSA==
X-Gm-Message-State: AOJu0YyAkxHMrQEXF7NFcyIwzStmEtRIGeKa+BeYRER/ukStIrfUYCpr
 /kD6XGHhmsOcF+FHSnwDRGYguCu3AxBFIQ7HHky0fWeZeNLelqkECazgDIq2J5c=
X-Gm-Gg: ASbGnctdfT746389FXrT0zNhDWZ0tfEN3LH57W+Wus8Bjh9CErSaUYQkzxp22v8unD7
 nFlRQJyK8aRy3Mzqr6k9UZ8KiNjhFbggLiweklahOp+oPfvmvJ1jSA2t5khEzejwbvPzjN7Z4ig
 DDB5Y1mo8c3QHdGDOZfu+13QIaPUzmL59uolUckCIqw2vKO+4TSeJdaG4sqeC6ILfPmkkG67g8p
 VXqHRfvCYZIC53OxIGma5jNcIAQswf2nf7fjYVXCGeCfSDPaaD0FXo6WUgmP3en3oGez6HKazO1
 CjZmrvEKlenBKEEEm7dtoCvE1m35QKdFVtDlrXSkhxfYGXrJnz1P0rY=
X-Google-Smtp-Source: AGHT+IG+WgzmLhpVGv49tGJoLv2i3ze37UN85KgLOsplqKCNIGcT7rmFDsTQhBiUzL9FYpPo4X4w8g==
X-Received: by 2002:a05:6a00:21ce:b0:736:53c5:33ba with SMTP id
 d2e1a72fcca58-736aaabeccemr22890121b3a.16.1741711693610; 
 Tue, 11 Mar 2025 09:48:13 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 10/16] efi_driver: efi_net: Add efi_net_unbind_drv method to
 efi_net driver
Date: Tue, 11 Mar 2025 13:47:52 -0300
Message-ID: <20250311164758.421900-11-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_driver/efi_net_device.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index 3838cc47158..bc4edde19b0 100644
--- a/lib/efi_driver/efi_net_device.c
+++ b/lib/efi_driver/efi_net_device.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <net.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/tag.h>
 #include <dm/uclass-internal.h>
@@ -172,6 +173,48 @@ static efi_status_t efi_net_bind_drv(
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_net_unbind_drv() - TODO
+ *
+ * @this:	driver binding protocol
+ * @handle:	handle
+ * Return:	status code
+ */
+static efi_status_t efi_net_unbind_drv(
+			struct efi_driver_binding_extended_protocol *this,
+			efi_handle_t handle)
+{
+	EFI_PRINT("%s: handle %p\n", __func__, handle);
+
+	struct driver *drv;
+	struct udevice *dev;
+	int r;
+
+	if (!handle || !handle->dev)
+		return EFI_DEVICE_ERROR;
+
+	drv = lists_driver_lookup_name("efi_netdev");
+	if (!drv) {
+		log_err("Cannot find driver 'efi_netdev'\n");
+		return EFI_DEVICE_ERROR;
+	}
+
+	if (drv == handle->dev->driver) {
+		dev = handle->dev;
+		r = efi_unlink_dev(handle);
+		if (r)
+			return EFI_DEVICE_ERROR;
+		r = device_remove(dev, DM_REMOVE_NORMAL);
+		if (r)
+			return EFI_DEVICE_ERROR;
+		r = device_unbind(dev);
+		if (r)
+			return EFI_DEVICE_ERROR;
+	}
+
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_net_init_drv() - initialize network device driver
  *
@@ -236,6 +279,7 @@ static const struct efi_driver_ops driver_ops = {
 	.protocol	= &efi_net_guid,
 	.init		= efi_net_init_drv,
 	.bind		= efi_net_bind_drv,
+	.unbind		= efi_net_unbind_drv,
 };
 
 /* Identify as EFI driver */
-- 
2.48.1

