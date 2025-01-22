Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76CC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7196809D4;
	Wed, 22 Jan 2025 18:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Un/AFYfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5F680C75; Wed, 22 Jan 2025 18:09:48 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5926680977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso127324685ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565785; x=1738170585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk4Tb7YLio9vrlBXjCOT7TgkuMTu5uPsMZ3bfSscZ9c=;
 b=Un/AFYfMdhvZgma1aSOCvW0WQO8QpLF87oCgaUbPEO55SS803EeM7t3dYhOgJphKx9
 +KKPB5rY1TstNyTDGGhl+WPWmUzABWlFzpW+9uHwoYWYHOduVIQz54FTGjTjLbKY7l1a
 AwlhxQEZZid9w14VcbOU8xqKx4BewAmyK3skaFQW8Zwkg8tXId+jVx7dzV2hz3hETihM
 GY3zq3wpXCZnp+ZGatnvxSF5a/MQi5aqPtqaT//RqJZSt1zFRFkd2wEb0VFJS+od+uh8
 qKfxDV6+6UkxVd35Y+4+6ToUeimU5/kEU1rTjdbbaMsm8OYwfyC6qAfvbFCP2S6uXnH2
 642g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565785; x=1738170585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mk4Tb7YLio9vrlBXjCOT7TgkuMTu5uPsMZ3bfSscZ9c=;
 b=wBdC9ZcIkTeMckD/Hws/nW1XAJ+tvffO4Hy2ZVT9gULk2QIUN7isIKQYw36Vr8JF/+
 PwtGPcrkMKwSIfpfRP/vN9MaWZ5DMiX+Nn+Ftu4AoL80k+LTYeXytqYgB95gO/bOszQJ
 +Z5JIUBb7pvZQCfavGOu8DU2m0KLpyNd2VidM2YW6HzteGvthH91KcvG9WPCKn4jLP78
 PbPC/rv/bNDvNQtFk1JLgHNLLE9WGwUKALxydyrEaXNBtTsfMe46CRKD/mC/yTTsUJgr
 +7ccEQPaAX0Slo+9aOXIQficJ0tIwSs4FE5UwWqjWzgsJH/XIj/wpvLykBEoDkslXOSx
 E7cQ==
X-Gm-Message-State: AOJu0Yyfue0iiixUadGtL9lrILzKgwKNGVvCUvho5lTGDSphByGjCn/s
 YxiAqf4dm0fqafRDVCCSmRBMi9akXBqcF05kjXidf4c6iTfBZrcUiCHPQ1Ui
X-Gm-Gg: ASbGncuI8/oGb0QXyLETtQoWFHfvA9g/Aw/2tgPOVsdLN8rQR+7xVbQC0DjtxkBQ+Ci
 W9n2Qc0npjmFGnmJLZ76nZdsEKNklKC91OfqF7FGzx5fvuSEPXkOHPw0IdYs0KM9ltJ7RRYdkWj
 0ma4GuLxVfMZ+Td4YXi2amnZCFbmIjhuC2sYBBBTXHFu6MI78W2zWcHE1v/rUB8IncEkN0mq16E
 IhbBXK0KysS2/KNUhoSAE9JhFqmyFkiRNSrBktSUvJfHtk5bQRusjHIob2P8ql/U6Iawvq0QXY8
 Ug==
X-Google-Smtp-Source: AGHT+IG++yfdGjfGUp7qk4jFToIpVQJQzJGu5D0HcabX4YQ2PtHTt7yNaqRG7zByK1yx173OholSVA==
X-Received: by 2002:a17:902:d511:b0:215:75ca:6a0 with SMTP id
 d9443c01a7336-21c3555b09emr382617315ad.29.1737565784772; 
 Wed, 22 Jan 2025 09:09:44 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:44 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 13/21] efi_driver: efi_net: UCLASS_ETH "efi_netdev" U-Boot
 driver
Date: Wed, 22 Jan 2025 14:08:50 -0300
Message-ID: <20250122170858.961359-14-adriano.cordova@canonical.com>
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

UCLASS_ETH "efi_netdev" U-Boot driver. This driver can control a
handle with a simple_network_protocol installed and working.
See efi_netdev_create.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h            |  13 +++
 lib/efi_driver/efi_net_device.c | 159 ++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 93f223389a..3bb95cfeb9 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -634,6 +634,18 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 			       const char *pdevname);
 /* Called by bootefi to make GOP (graphical) interface available */
 efi_status_t efi_gop_register(void);
+
+/**
+ * struct efi_netdev_plat - attributes of a network device
+ *
+ * @handle:	handle of the controller on which this driver is installed
+ * @snp:		simple network protocol proxied by this driver
+ */
+struct efi_netdev_plat {
+	efi_handle_t handle;
+	struct efi_simple_network *snp;
+	void *buffer;
+};
 /* Called to register an EFI network device */
 int efi_net_register(void *ctx, struct event *event);
 /* Called to unregister an EFI network device */
@@ -647,6 +659,7 @@ efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 /* Called by efi_net_register to make the http protocol available */
 efi_status_t efi_http_register(const efi_handle_t handle,
 			       struct efi_service_binding_protocol *http_service_binding);
+
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
 efi_status_t efi_initrd_register(void);
diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index 298eded265..af51b1f855 100644
--- a/lib/efi_driver/efi_net_device.c
+++ b/lib/efi_driver/efi_net_device.c
@@ -7,11 +7,146 @@
 #include <dm.h>
 #include <efi_driver.h>
 #include <malloc.h>
+#include <net.h>
 #include <dm/device-internal.h>
 #include <dm/root.h>
 #include <dm/tag.h>
 #include <dm/uclass-internal.h>
 
+#define DEFAULT_EFI_NET_BUFFER_SIZE 1024
+
+int efi_net_start(struct udevice *dev)
+{
+	struct efi_netdev_plat *plat;
+	efi_status_t ret;
+
+	plat = dev_get_plat(dev);
+	if (!plat || !plat->snp)
+		return -1;
+
+	ret = plat->snp->start(plat->snp);
+	if (ret != EFI_SUCCESS)
+		return -1;
+	ret = plat->snp->initialize(plat->snp, 0, 0);
+	if (ret != EFI_SUCCESS)
+		return -1;
+
+	return 0;
+}
+
+int efi_net_send(struct udevice *dev, void *packet, int length)
+{
+	struct efi_netdev_plat *plat;
+	efi_status_t ret;
+
+	plat = dev_get_plat(dev);
+	if (!plat || !plat->snp)
+		return -1;
+
+	ret = plat->snp->transmit(plat->snp, 0, length, packet, NULL, NULL, NULL);
+	if (ret != EFI_SUCCESS)
+		return -1;
+
+	return 0;
+}
+
+int efi_net_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct efi_netdev_plat *plat;
+	efi_status_t ret;
+	size_t buffer_size;
+
+	plat = dev_get_plat(dev);
+	if (!plat || !plat->snp)
+		return -1;
+
+	if (plat->buffer)
+		free(plat->buffer);
+
+	buffer_size = DEFAULT_EFI_NET_BUFFER_SIZE;
+	plat->buffer = calloc(1, buffer_size);
+	ret = plat->snp->receive(plat->snp, NULL, &buffer_size, plat->buffer,
+				 NULL, NULL, NULL);
+
+	if (ret == EFI_BUFFER_TOO_SMALL) {
+		free(plat->buffer);
+		plat->buffer = calloc(1, buffer_size);
+		ret = plat->snp->receive(plat->snp, NULL, &buffer_size, plat->buffer,
+					 NULL, NULL, NULL);
+	}
+
+	if (ret != EFI_SUCCESS || ret != EFI_NOT_READY)
+		return -1;
+
+	*packetp = plat->buffer;
+	return buffer_size;
+}
+
+void efi_net_stop(struct udevice *dev)
+{
+	struct efi_netdev_plat *plat;
+
+	plat = dev_get_plat(dev);
+	if (!plat || !plat->snp)
+		return;
+
+	plat->snp->stop(plat->snp);
+}
+
+/**
+ * efi_netdev_create() - create a net udevice for a handle
+ *
+ * @handle:	handle
+ * @interface:	simple network protocol
+ * Return:	status code
+ */
+static efi_status_t
+efi_netdev_create(efi_handle_t handle, void *interface)
+{
+	struct udevice *dev = NULL, *parent = dm_root();
+	efi_status_t ret;
+	char *name;
+	struct efi_netdev_plat *plat;
+	static int devnum;
+
+	name = calloc(1, 18); /* strlen("efinet#2147483648") + 1 */
+	if (!name)
+		return EFI_OUT_OF_RESOURCES;
+	sprintf(name, "efinet#%d", devnum);
+	devnum++;
+
+	/* Create driver model udevice for the EFI block io device */
+	if (eth_create_device(parent, "efi_netdev", name, &dev)) {
+		ret = EFI_OUT_OF_RESOURCES;
+		free(name);
+		goto err;
+	}
+
+	plat = dev_get_plat(dev);
+	plat->handle = handle;
+	plat->snp = interface;
+
+	if (efi_link_dev(handle, dev)) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto err;
+	}
+
+	if (device_probe(dev)) {
+		ret = EFI_DEVICE_ERROR;
+		goto err;
+	}
+	EFI_PRINT("%s: net udevice '%s' created\n", __func__, dev->name);
+
+	return EFI_SUCCESS;
+
+err:
+	efi_unlink_dev(handle);
+	if (dev)
+		device_unbind(dev);
+
+	return ret;
+}
+
 /**
  * efi_net_bind_drv() - TODO
  *
@@ -26,6 +161,14 @@ static efi_status_t efi_net_bind_drv(
 {
 	EFI_PRINT("%s: handle %p, interface %p\n", __func__, handle, interface);
 
+	efi_status_t ret;
+
+	if (!handle->dev) {
+		ret = efi_netdev_create(handle, interface);
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
+
 	return EFI_SUCCESS;
 }
 
@@ -71,6 +214,22 @@ efi_net_init_drv(struct efi_driver_binding_extended_protocol *this)
 	return EFI_SUCCESS;
 }
 
+/* Net device driver operators */
+static const struct eth_ops efi_eth_ops = {
+	.start	= efi_net_start,
+	.send	= efi_net_send,
+	.recv	= efi_net_recv,
+	.stop	= efi_net_stop,
+};
+
+/* Identify as net device driver */
+U_BOOT_DRIVER(efi_netdev) = {
+	.name		= "efi_netdev",
+	.id		= UCLASS_ETH,
+	.ops		= &efi_eth_ops,
+	.plat_auto	= sizeof(struct efi_netdev_plat),
+};
+
 /* EFI driver operators */
 static const struct efi_driver_ops driver_ops = {
 	.protocol	= &efi_net_guid,
-- 
2.43.0

