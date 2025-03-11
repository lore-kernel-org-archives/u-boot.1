Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D1C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38F5819FF;
	Tue, 11 Mar 2025 17:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0dxbSza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8606D819FC; Tue, 11 Mar 2025 17:48:12 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3DE81761
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22355618fd9so109421685ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711689; x=1742316489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pfo3Zt7yhQ2gmc3/RimMY85+cck+IAlII/xeEXObl/I=;
 b=S0dxbSzafGCCwtIUKiG3HrlRsKwce5ZGrnPzCFOQ5fAxb9+5DRhfQ7UVhLm0jbM/Ea
 6A93ZykN5xe/jX2DTR2sA4unjBIG+gdRvMVmIwvMzB8ihwYvV/T/8Ec56H/k7nRcsY7p
 srLONkVEgyOQCRlGcnggAOoi0TyHseB3hc6t1/F9btGNinClblADjHGJymm31gqlYCsB
 UhjeaxyeFAoc1qvfdc0SVXUk6Ce4CNy5+LTYZ917ZMvO8CSVanxEnZNEX0CjFhKy9m0K
 tl9NA2s5H3tskpOoz/3oHC03ikwZH4OnFVNR2l7haKZGo5e/uyzyUUdbmTN8RDEHrVY9
 VuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711689; x=1742316489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pfo3Zt7yhQ2gmc3/RimMY85+cck+IAlII/xeEXObl/I=;
 b=u/vlJLX6Bu+6LzZiIEwKC7QawLiVtyJQ4JqeK4zUU8SWYkxkRh9nn1dh8opnSHPBmH
 wSYzB8+uthaqp2E3LfgFlo3RO9waqmRCt9V+OpqTPvhdgUYPlI3IWSMWa93381M8HiZA
 4P8gH9y3j7JfKfJ7yp2a5WBJ1dvMA7MuHKWlMGVtdyCwpPCT01ANeKZWx3nvr/fhMHEt
 +KQmY1i2OMXPVIOWRJtdssCRyUrxgUf3awDXA5dy4rMVIvuHqCimZFbgOsUwFzGL9PIw
 snjhsYe6LbzVVnjqPUAgs2mxg9drSHOd0ssR7yxWUcRWHNxg6rTyNca0Sr4bF97dTHIF
 gWFA==
X-Gm-Message-State: AOJu0Yz8RU/jeJomU8zdl3WMtw6hL/yzXbeQlyVWmu4x+hq700R5xRYl
 dlepphOHxUdRntYemUcneTI23Xw2EPkUh5xerZeX1443BtPb9xp88Nyn+uQJcz8=
X-Gm-Gg: ASbGncsPQlI//BHuHXfYckSkA6iVYjkhyXDXe3gNOIY8HP+duzmpow5h8CDOo+4jiCG
 GhDSCctMIZ+JQJl+LErEeJXe9VR5imzpPIWC8OIpVzwm9vdnDnn9urjsiF1rTyNSuP6juoavde+
 YH96n53jAaj/z9G2riAN6MjK56CleehRi8Tot0b7sx1RR2FW8nqxowk89oGhGX/xLfBcqSvpbkA
 lW8XdRfVaNOPhjsinBZHr3h+0QGDHFfzBmzZUGtp54ig/iaRJaFnHCb/MbcylPb5SbI3VKnKvVA
 OvgnVWTAo8gYx0acgvR94d9orwNJku30EtXV6ZwZeoSK2WCIesUgfTM=
X-Google-Smtp-Source: AGHT+IG73d76P2kNh3fwFhMQ1L24oBxXCklQu6NX+g9kBWip4VEIGv9URE55LzIN8sByMD/K0rahew==
X-Received: by 2002:a05:6a00:1ad2:b0:730:4c55:4fdf with SMTP id
 d2e1a72fcca58-736eb7ca1f6mr5960267b3a.7.1741711688575; 
 Tue, 11 Mar 2025 09:48:08 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:08 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 08/16] efi_driver: efi_net: UCLASS_ETH driver for EFI net
 devices
Date: Tue, 11 Mar 2025 13:47:50 -0300
Message-ID: <20250311164758.421900-9-adriano.cordova@canonical.com>
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

Ethernet driver that uses an underlying efi_simple_network_protocol
to send packages.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h            |  12 +++
 lib/efi_driver/efi_net_device.c | 159 ++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 38ea0c5c672..35f500fd97d 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -656,6 +656,18 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
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
diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index 90d695da2b1..3838cc47158 100644
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
 
@@ -72,6 +215,22 @@ efi_net_init_drv(struct efi_driver_binding_extended_protocol *this)
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
2.48.1

