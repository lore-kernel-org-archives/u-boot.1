Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B7C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545B880AE5;
	Wed, 22 Jan 2025 18:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDCBPdaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEBA80C91; Wed, 22 Jan 2025 18:09:55 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D6580C8F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso127326345ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565790; x=1738170590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0bZs37t2OF0Uh1qi+e2TCQ89nsSvcFe4s6Rw72hrBU=;
 b=XDCBPdaTfkC9XtgFRkLsupbtVeon/E7YoXi6iWrCJJxt7yl1Ycxz6zrwKDC25kVMPk
 63W9hWEJXyOhSGh4ceAc20kE96Tdd3EM1YaN4ZsSTHtl5g6hrjJTBee6d+l5avgidgPZ
 KWKhPp4KkT4DyjHGT6IyfDrMUS+MnbFryYbDUYgAzbnV9+lHh9/7JYK4GbnFuQHRtB5H
 FiCbuJ+MkKi1SyMnRnrpvby7ULhj94O8FhgsVc2XleZ+oRfRkLTGdyjzNNM+gCovQbI0
 BfQW8WjGBdLtKam3A6nXzprraUPpdkUIYRwdMdXpGdwytwy8O1GwO3S0r3a4zSE5BKP+
 RVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565790; x=1738170590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0bZs37t2OF0Uh1qi+e2TCQ89nsSvcFe4s6Rw72hrBU=;
 b=dMyMUgFg8AqsILSTH2t9lE0+cPhp9pXzRAHmN1W+UUtTlt+1Tg74yoK2VP0AEO79nq
 WzQdyr5GW/5/V2p+VRZ5ivo5wn7UtA05Mv2BKBzIlOGrUMI+IsOmIe+1gvRGc8EJW9QN
 5/VROIoy6vJclwgkrsm1NoADC+42aT9SiXpe+IoeFSPrpWedtXbGWciemVM7uChKu5in
 R5jGzAXccjrjr6I3jyPnf07vOfLXwDv1lYweWVt/fLgR5u1Uv831rq23bMVsTCD2knxU
 UPSBUj6QMQ5w+lAEHyIJ2x/Z6Fm4azfjS5eYByVhQJ4fS2ocpBc6kXnYKYv3NI1QeGwH
 dVEA==
X-Gm-Message-State: AOJu0Yw/XXS7jihZnez5U4nHA1KSIzx/qdNexgeMoETKFJG71Twtz77a
 t9Znp21Gg0EqK4lfXNZouCcpectLn0KhpJ/v1nOCkADWj3Oq8O3Pj0KIkCAy
X-Gm-Gg: ASbGncu5p+Oiiib18kvXEq8Rqq/odDRLbsEaq93GB6JGiue0v0ypgCzeW26E4eyan0z
 JA6YTXn9GWfA7N7QNHb042lrD3+SHlrRS6OckvaEjx44Wqf7ycLFi9JyiKc8XFDN5j+khjOPSaY
 NCGfW/Uv4TZqVfsd8nT13b142le/4LzNTTtsApB6QfSk35ezaaPS1PV5FhNvI/XAGE0ahXxaQUn
 WdglzDiLkhN7EgVBri7UnMAvQdy/eNWIk6qmLTDfyZ4+1mdnbNV49nTqU0WOBytM1I1IPsLxwBu
 Fg==
X-Google-Smtp-Source: AGHT+IHj9enPZQlh8/X4g3C47hj2o3VCxiHyqDTycx5BmOBY3dGSrZDGwiBTwZiqJ0UVIySNlNWm0w==
X-Received: by 2002:a17:902:c950:b0:215:7dbf:f3de with SMTP id
 d9443c01a7336-21c35558d37mr364597395ad.28.1737565789606; 
 Wed, 22 Jan 2025 09:09:49 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:49 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 15/21] efi_driver: efi_net: Add efi_net_unbind_drv method to
 efi_net driver
Date: Wed, 22 Jan 2025 14:08:52 -0300
Message-ID: <20250122170858.961359-16-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

In case the handle was controlled by the "efi_netdev" driver, unlink
the handle from the udevice and remove the udevice.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_driver/efi_net_device.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index af51b1f855..7113ca155e 100644
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
@@ -235,6 +278,7 @@ static const struct efi_driver_ops driver_ops = {
 	.protocol	= &efi_net_guid,
 	.init		= efi_net_init_drv,
 	.bind		= efi_net_bind_drv,
+	.unbind		= efi_net_unbind_drv,
 };
 
 /* Identify as EFI driver */
-- 
2.43.0

