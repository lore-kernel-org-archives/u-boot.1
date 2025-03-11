Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C3FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616DB817D8;
	Tue, 11 Mar 2025 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DcnFr3r9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EC181671; Tue, 11 Mar 2025 17:47:59 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40C781197
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225a28a511eso12119815ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711675; x=1742316475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obsldbPMTv8poqTbdLUw39ZSgdKj8GykwRoHuOhb7jQ=;
 b=DcnFr3r9rLVCQHNvKFf21NxvXWwt08yGmM+8iv0KX8Fd7kjMSXnPURCNfhFJruNVgn
 m5QqnhBOj/zWY7F8/TeQ2O2FG1YIsCvkX4VL382rMOZAebsUd7+EDyIULmptUiCAdCCq
 rM4w+riLL0m/iBqHqoh7vTHWOqsIFniRZWd9enFKcflJwRKoY1jUHgpIFTYyJFsBfGno
 hNVacT89MbHmoJ+ozoikCaHKWqMqWOqKQWoxzytVrRBrzz5jhco4QBQvnJ0kPuTiwGge
 uLJMbx5fzk+H+PIvOQf6lEKvLWs355rYxt7kmqAZgFDAHYZy2veuNs98v2SBD3CkNAOl
 wnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711675; x=1742316475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obsldbPMTv8poqTbdLUw39ZSgdKj8GykwRoHuOhb7jQ=;
 b=SuRC9UQzAC5B2ulseIlbLoysMgZTZcg0Mu5n2YDde8Mk8jxEjKwLJ0RrtFqEn87ref
 Ie+W3wsGHs7ZC/QkaQ41txkgQdS2MAv5Jqt5QkrulualSyy25NbmcaBOUR5td9aIeHQV
 uua3ysZQZu9XqFvnY5hhmuCCUJezDAEs2eaULns1qD9e4tabXmuP6Mn7jNwBB0cM/Egv
 t1j2f3hq5B55QWaoq+VLWdauq7E/w3RG2i+600zJkVtrhSFjRl/2I9WcAH1SSSCXs713
 6xJPRTUzAOLRAJzwfD7X6tKorJTK9+9Jh+FmcA84J5tnHC6vTdIsl8s5i0T914sD0K0Q
 Gz/Q==
X-Gm-Message-State: AOJu0YwEkrC5+iwTBewwGI/KUh1zHEHGJ+QT8hoKVt993KRGSoeRu9ly
 t8qlRfrjiN8PsDX8cVFDroG9kXhVAW/GZH7ZqH+WBpRI0B4R5ZvjlQDWWpalsTc=
X-Gm-Gg: ASbGncvcfxQ9Kx55wDGND3JJ0whGkRzZciMWPRqCCRrfenpQvTj2fXQZrApRoOWh2am
 HWet9iLUl1tWqBlyeyRjlw8ujWh/tAxEfymqQ6mKsvkJTGlYzESgASrOOjm9eE8pYz5Q30RAF8A
 ORb8GulRXEBTnYUbhgwvZhzBgjcARnES9gfRv0OCJ4DNAXqr5XHO4X0u3FDaYFVE+TS/1858lCE
 tnfpio43ogwhniKJCRBaX13zOuqJkkQNQdFsQnxcRYn1eUcoNyhVJGe/YO0H8T/Z6rtPEL6ckyo
 2vlvFODoyxDF2/jnfRD+h3QcQIRF2WIhag2oYmGtj9FkG//9hpU01GvavYWk/EIDRg==
X-Google-Smtp-Source: AGHT+IEBr3oEpadG2ftS9v7RK6SARQM7Fq4ShHWAiAfXbp3ZHuOfxNrqRdMCk579Xs6iRk754jFCqw==
X-Received: by 2002:a05:6a00:2351:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-736aab02cbdmr27699044b3a.20.1741711673482; 
 Tue, 11 Mar 2025 09:47:53 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:47:53 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 01/16] efi_driver: efi_net: Add EFI network device driver
Date: Tue, 11 Mar 2025 13:47:43 -0300
Message-ID: <20250311164758.421900-2-adriano.cordova@canonical.com>
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

Register the U-boot ethernet udevices in the EFI network stack
as efi_net_obj when they get probed, and unregister them when the
udevice gets removed

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h            |  10 +-
 lib/efi_driver/Makefile         |   1 +
 lib/efi_driver/efi_net_device.c |  89 +++++++++++
 lib/efi_driver/efi_uclass.c     |   2 +-
 lib/efi_loader/efi_net.c        | 263 +++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c      |   4 +-
 6 files changed, 305 insertions(+), 64 deletions(-)
 create mode 100644 lib/efi_driver/efi_net_device.c

diff --git a/include/efi_loader.h b/include/efi_loader.h
index e9c10819ba2..9c5ddc12cea 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -656,9 +656,13 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 			       const char *pdevname);
 /* Called by bootefi to make GOP (graphical) interface available */
 efi_status_t efi_gop_register(void);
-/* Called by bootefi to make the network interface available */
-efi_status_t efi_net_register(struct udevice *dev);
-efi_status_t efi_net_do_start(struct udevice *dev);
+/* Called to register an EFI network device */
+int efi_net_register(void *ctx, struct event *event);
+/* Called to unregister an EFI network device */
+int efi_net_unregister(void *ctx, struct event *event);
+/* Called to initialized registered network devices */
+efi_status_t efi_net_init(void);
+efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_driver/Makefile b/lib/efi_driver/Makefile
index 0da20fe91d3..08489064c7a 100644
--- a/lib/efi_driver/Makefile
+++ b/lib/efi_driver/Makefile
@@ -9,4 +9,5 @@ obj-y += efi_uclass.o
 ifeq ($(CONFIG_PARTITIONS),y)
 obj-y += efi_block_device.o
 endif
+obj-$(CONFIG_NETDEVICES) += efi_net_device.o
 obj-$(CONFIG_SYSRESET_SBI) += efi_reset_riscv.o
diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
new file mode 100644
index 00000000000..f2167485ab9
--- /dev/null
+++ b/lib/efi_driver/efi_net_device.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  EFI network driver
+ *
+ */
+
+#include <dm.h>
+#include <efi_driver.h>
+#include <malloc.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <dm/tag.h>
+#include <dm/uclass-internal.h>
+
+/**
+ * efi_net_bind_drv() - TODO
+ *
+ * @this:	driver binding protocol
+ * @handle:	handle
+ * @interface:	block io protocol
+ * Return:	status code
+ */
+static efi_status_t efi_net_bind_drv(
+			struct efi_driver_binding_extended_protocol *this,
+			efi_handle_t handle, void *interface)
+{
+
+	EFI_PRINT("%s: handle %p, interface %p\n", __func__, handle, interface);
+
+
+	return EFI_UNSUPPORTED;
+}
+
+/**
+ * efi_net_init_drv() - initialize network device driver
+ *
+ * @this:	extended driver binding protocol
+ * Return:	status code
+ */
+static efi_status_t
+efi_net_init_drv(struct efi_driver_binding_extended_protocol *this)
+{
+	int ret;
+	struct udevice *dev;
+	struct event event;
+
+	for (uclass_find_first_device(UCLASS_ETH, &dev); dev;
+	     uclass_find_next_device(&dev)) {
+		if (dev_get_flags(dev) & DM_FLAG_ACTIVATED) {
+			memcpy(&event.data, &dev, sizeof(dev));
+			ret = efi_net_register(NULL, &event);
+			if (ret) {
+				log_err("Failed registering %s in EFI net\n", dev->name);
+				return EFI_OUT_OF_RESOURCES;
+			}
+		}
+
+	}
+
+	ret = event_register("efi_net register", EVT_DM_POST_PROBE,
+			     efi_net_register, this);
+	if (ret) {
+		log_err("Event registration for efi_net register failed\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = event_register("efi_net unregister", EVT_DM_PRE_REMOVE,
+			     efi_net_unregister, this);
+	if (ret) {
+		log_err("Event registration for efi_net unregister failed\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	return EFI_SUCCESS;
+}
+
+/* EFI driver operators */
+static const struct efi_driver_ops driver_ops = {
+	.protocol	= &efi_net_guid,
+	.init		= efi_net_init_drv,
+	.bind		= efi_net_bind_drv,
+};
+
+/* Identify as EFI driver */
+U_BOOT_DRIVER(efi_net) = {
+	.name		= "efi_net",
+	.id		= UCLASS_EFI_LOADER,
+	.ops		= &driver_ops,
+};
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index 495be53cb77..fc8808374a1 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -76,7 +76,7 @@ static efi_status_t EFIAPI efi_uc_supported(
 	 * U-Boot internal devices install protocols interfaces without calling
 	 * ConnectController(). Hence we should not bind an extra driver.
 	 */
-	if (controller_handle->dev) {
+	if (controller_handle->dev && bp->ops->protocol != &efi_net_guid) {
 		ret = EFI_UNSUPPORTED;
 		goto out;
 	}
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b3291b4f1d5..0334eedaf5c 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -865,6 +865,11 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 	nt = efi_netobj_from_snp(this);
 	curr_efi_net_obj = nt->efi_seq_num;
 
+	// The following only happens if the net obj was removed but the event
+	// was not successfully removed.
+	if (!net_objs[curr_efi_net_obj] || !efi_netobj_is_active(nt))
+		goto out;
+
 	if (!nt->rx_packet_num) {
 		eth_set_dev(nt->dev);
 		env_set("ethact", eth_get_name());
@@ -1060,27 +1065,16 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 }
 
 /**
- * efi_net_do_start() - start the efi network stack
+ * efi_netobj_start() - start an efi net device
  *
- * This gets called from do_bootefi_exec() each time a payload gets executed.
  *
- * @dev:	net udevice
+ * @netobj:	efi_net_obj
  * Return:	status code
  */
-efi_status_t efi_net_do_start(struct udevice *dev)
+efi_status_t efi_netobj_start(struct efi_net_obj *netobj)
 {
 	efi_status_t r = EFI_SUCCESS;
-	struct efi_net_obj *netobj;
 	struct efi_device_path *net_dp;
-	int i;
-
-	netobj = NULL;
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->dev == dev) {
-			netobj = net_objs[i];
-			break;
-		}
-	}
 
 	if (!efi_netobj_is_active(netobj))
 		return r;
@@ -1110,57 +1104,58 @@ set_addr:
 	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
 	 */
 	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, dev);
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, netobj->dev);
 #endif
 
-	return r;
+	return 0;
 }
 
 /**
- * efi_net_register() - register the simple network protocol
+ * efi_net_do_start() - start the efi network stack
+ *
+ * This gets called from do_bootefi_exec() each time a payload gets executed.
  *
- * This gets called from do_bootefi_exec().
- * @dev:	net udevice
+ * Return:	status code
  */
-efi_status_t efi_net_register(struct udevice *dev)
+efi_status_t efi_net_do_start(void)
+{
+	int i, r;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i]) {
+			r = efi_netobj_start(net_objs[i]);
+			if (r)
+				return EFI_DEVICE_ERROR;
+		}
+	}
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_netobj_init() - initialize an efi_net_obj
+ *
+ * @netobj:	efi net object
+ * Return:	0 on success, negative on error
+ */
+static int efi_netobj_init(struct efi_net_obj *netobj)
 {
 	efi_status_t r;
-	int seq_num;
-	struct efi_net_obj *netobj;
+	struct udevice *dev;
 	void *transmit_buffer = NULL;
 	uchar **receive_buffer = NULL;
-	size_t *receive_lengths;
+	size_t *receive_lengths = NULL;
 	int i, j;
 
+	if (!netobj || efi_netobj_is_active(netobj))
+		return 0;
+
+	dev = netobj->dev;
 	if (!dev) {
 		/* No network device active, don't expose any */
-		return EFI_SUCCESS;
+		return 0;
 	}
 
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->dev == dev) {
-			// Do not register duplicate devices
-			return EFI_SUCCESS;
-		}
-	}
-
-	seq_num = -1;
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (!net_objs[i]) {
-			seq_num = i;
-			break;
-		}
-	}
-	if (seq_num < 0)
-		return EFI_OUT_OF_RESOURCES;
-
-	/* We only expose the "active" network device, so one is enough */
-	netobj = calloc(1, sizeof(*netobj));
-	if (!netobj)
-		goto out_of_resources;
-
-	netobj->dev = dev;
-
 	/* Allocate an aligned transmit buffer */
 	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
 	if (!transmit_buffer)
@@ -1259,7 +1254,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 			     &netobj->wait_for_packet);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
-		return r;
+		return -1;
 	}
 	netobj->net.wait_for_packet = netobj->wait_for_packet;
 	/*
@@ -1275,13 +1270,13 @@ efi_status_t efi_net_register(struct udevice *dev)
 			     &netobj->network_timer_event);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
-		return r;
+		return -1;
 	}
 	/* Network is time critical, create event in every timer cycle */
 	r = efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to set network timer\n");
-		return r;
+		return -1;
 	}
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
@@ -1295,15 +1290,12 @@ efi_status_t efi_net_register(struct udevice *dev)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-	netobj->efi_seq_num = seq_num;
-	net_objs[seq_num] = netobj;
-	return EFI_SUCCESS;
+	printf("efi_net init device number %d\n", netobj->efi_seq_num);
+	return 0;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
-	return r;
+	return -1;
 out_of_resources:
-	free(netobj);
-	netobj = NULL;
 	free(transmit_buffer);
 	if (receive_buffer)
 		for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
@@ -1311,7 +1303,162 @@ out_of_resources:
 	free(receive_buffer);
 	free(receive_lengths);
 	printf("ERROR: Out of memory\n");
-	return EFI_OUT_OF_RESOURCES;
+	return -1;
+}
+
+/**
+ * efi_net_init() - initialize registered efi objects
+ *
+ * Return:	status code
+ */
+efi_status_t efi_net_init(void)
+{
+	int i, r;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i]) {
+			r = efi_netobj_init(net_objs[i]);
+			if (r)
+				return EFI_DEVICE_ERROR;
+		}
+	}
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_net_register() - register a net device
+ *
+ * This function is called when the device is probed
+ *
+ * @ctx:	context set at registration time
+ * @event:	event
+ * Return:	0 on success, negative on error
+ */
+int efi_net_register(void *ctx, struct event *event)
+{
+	struct udevice *dev;
+	int seq_num;
+	enum uclass_id id;
+	struct efi_net_obj *netobj;
+	int i;
+
+	dev = event->data.dm.dev;
+	if (!dev) {
+		/* No network device active, don't expose any */
+		return 0;
+	}
+
+	id = device_get_uclass_id(dev);
+	if (id != UCLASS_ETH)
+		return 0;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			// Do not register duplicate devices
+			return 0;
+		}
+	}
+
+	// Find a slot for this efi_net_obj
+	seq_num = -1;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (!net_objs[i]) {
+			seq_num = i;
+			break;
+		}
+	}
+	if (seq_num < 0)
+		return -1;
+
+	netobj = calloc(1, sizeof(*netobj));
+	if (!netobj)
+		goto out_of_resources;
+
+	netobj->dev = dev;
+	netobj->efi_seq_num = seq_num;
+	net_objs[seq_num] = netobj;
+	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
+	return 0;
+out_of_resources:
+	printf("ERROR: Out of memory\n");
+	return -1;
+}
+
+/**
+ * efi_net_unregister() - unregister a net device
+ *
+ *
+ * @ctx:	context set at registration time
+ * @event:	event
+ * Return:	0 on success, negative on error
+ */
+int efi_net_unregister(void *ctx, struct event *event)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct udevice *dev;
+	enum uclass_id id;
+	struct efi_net_obj *netobj;
+	struct efi_handler *phandler;
+	void *interface;
+	int i;
+
+	dev = event->data.dm.dev;
+	if (!dev) {
+		/* No network device active, don't expose any */
+		return 0;
+	}
+
+	id = device_get_uclass_id(dev);
+	if (id != UCLASS_ETH)
+		return 0;
+
+	netobj = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			netobj = net_objs[i];
+			break;
+		}
+	}
+
+	if (!netobj)
+		return 0;
+
+	// Remove from the list
+	net_objs[i] = NULL;
+
+	if (efi_netobj_is_active(netobj)) {
+		free(netobj->transmit_buffer);
+		if (netobj->receive_buffer)
+			for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
+				free(netobj->receive_buffer[i]);
+		free(netobj->receive_buffer);
+		free(netobj->receive_lengths);
+
+		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
+		if (ret != EFI_SUCCESS)
+			return -1;
+
+		ret = EFI_CALL(efi_close_event(netobj->network_timer_event));
+		if (ret != EFI_SUCCESS)
+			return -1;
+
+		phandler = NULL;
+		efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+		if (phandler && phandler->protocol_interface)
+			interface = phandler->protocol_interface;
+
+		ret = efi_delete_handle(&netobj->header);
+		if (ret != EFI_SUCCESS)
+			return -1;
+
+		efi_free_pool(interface);
+	}
+
+	// Free the efi_net_obj
+	free(netobj);
+
+	return 0;
 }
 
 /**
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 48f91da5df7..e6ef76bcca6 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -220,7 +220,7 @@ static efi_status_t efi_start_obj_list(void)
 	efi_status_t ret = EFI_SUCCESS;
 
 	if (IS_ENABLED(CONFIG_NETDEVICES))
-		ret = efi_net_do_start(eth_get_dev());
+		ret = efi_net_do_start();
 
 	return ret;
 }
@@ -337,7 +337,7 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 	if (IS_ENABLED(CONFIG_NETDEVICES)) {
-		ret = efi_net_register(eth_get_dev());
+		ret = efi_net_init();
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-- 
2.48.1

