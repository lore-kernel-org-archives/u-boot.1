Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1FBC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF7F80EF7;
	Thu,  6 Feb 2025 18:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kkkw/Mf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694BE80ECC; Thu,  6 Feb 2025 18:40:46 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A8480E94
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso9746075ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863642; x=1739468442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS6/ZRSxhnn/YO5dK2VmIE7FNFb9SlVHC3MtXk+7xa4=;
 b=kkkw/Mf69BqhEUaD9uulMUo0AqTba9dZOZqVZ14Q1euUhpCQhkLAoEkNuDPzHTkQEU
 1e89dGG+SACgAFA9YwXWI39YgGS6JkBKRuRPgwf/9k0dF7YzT/aLHZf4KOIjxKd5+hEc
 umbaW2V55dyXVKJhdipByyq7R87S9fY2ibI8cJ3lxgf/aBClhYNAUqiU2Dfa2H+9+Rhf
 j/xnpFs0PfJnEJYM0YLkX3PEEa7+1DTO3YgBPUBvvF+23TOjOYJhB/vdADd1vipG/iKg
 +wy1XRZ+afLlg70Nkkynwj4L4K63JRLYaMSwnHHr0Ldp+iAWX9YbNG7j4ktK6I4eYjC4
 57Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863642; x=1739468442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS6/ZRSxhnn/YO5dK2VmIE7FNFb9SlVHC3MtXk+7xa4=;
 b=oPl70ePlFxeLtWoyI++EyrLzx3IEydyCO2+4bWyEljfWz2/a6HEjpyXAno+1ZQ+fxA
 nYMjb9VyR7/0vP57ohtRr8kC4HzWsUcpyeLlY43oVo39BP99IwL/GZhruxhNEJuKwIn8
 hpIcsn67ikLNaPqFW+cxpcFXwod0ZFlxwIl0LXMICxfnCjmKqEY4sxK9yMcrKXUaxFKY
 BKUv9lQ/OdKMFMTiO67PQZT1w1cSDYJROjUzH0S/Kc780et9GigZce3u7x3H01poimtm
 F3/ia3H7e1wyBMLaa6hgAwtxo3FNZFM/FmqdBIOxHuWdmu4pZoGHbCYJzg+s5kpkOHWV
 rRpg==
X-Gm-Message-State: AOJu0Yy1HkLOhcfU7t+WePdbWmJFPGnZhMDJwBlDnzSA2wGKeC8aMoLZ
 jyVA+PTRmQJe9rd8gPuDN+rEDLv8b2mcHniD6wu5VpfTv0ZKmR+QWiA82TXnjPXNVg==
X-Gm-Gg: ASbGncudhtb+JrgWphHmPk3cJQ5iGHOgOqb5yPGY/Z/MEuivp6wC63LkhMwDSYsZMWU
 xj7b3LE8MeIx6tGoVLc3u7fM4lTbfNQ4WdwGCNVwl7r2K7T2XGfNHyE8LG65Binr+XrwJbIaRME
 k+9RNWso7ilCNKHjTVgXq0olRrAd3ojLzBxf1mteiJ2EU/1Chwr/lwmOYYs4h84FQA5WIDpbjDK
 G6lmdbaL7L8RlYDdvG8lF6YNY8asN8DOFO3AwE5pu9xFU6k2zwP4HWTyno0dCEOeHGDRcM3Kn3t
 /PqXl2eECuridYyZqmJ1DA1B
X-Google-Smtp-Source: AGHT+IH7nO7JfDiKiRfnwDZ1/pOQ7YryXJDuHLemfcigcVgnfac17CZFJm4LfqBiNH+DAHQzGBY/Rg==
X-Received: by 2002:a17:902:c403:b0:21f:35fd:1b6a with SMTP id
 d9443c01a7336-21f35fd2116mr61271175ad.51.1738863641642; 
 Thu, 06 Feb 2025 09:40:41 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:41 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 6/8] efi_loader: efi_net: Add device path cache
Date: Thu,  6 Feb 2025 14:40:16 -0300
Message-ID: <20250206174018.465530-7-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
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

In preparation to support mutiple efi net udevices. Add a device path
cache to support device paths from multiple ethernet udevices.
The device paths can be added to the cache before EFI gets initialized and
the protocols get installed.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h             |  23 +--
 lib/efi_loader/efi_bootbin.c     |   3 +-
 lib/efi_loader/efi_device_path.c |   6 +-
 lib/efi_loader/efi_http.c        |   2 +-
 lib/efi_loader/efi_ipconfig.c    |   4 +-
 lib/efi_loader/efi_net.c         | 268 ++++++++++++++++++++++++++-----
 lib/efi_loader/efi_setup.c       |   5 +-
 7 files changed, 252 insertions(+), 59 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 5a256f733ca..a65edae3440 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -129,15 +129,17 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
 /* Call this to update the current device path of the efi net device */
-efi_status_t efi_net_set_dp(const char *dev, const char *server);
+efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev);
 /* Call this to get the current device path of the efi net device */
-void efi_net_get_dp(struct efi_device_path **dp);
+void efi_net_dp_from_dev(struct efi_device_path **dp, struct udevice *udev, bool cache_only);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw);
+		      struct efi_ipv4_address *gw,
+			  struct udevice *dev);
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw);
+		      struct efi_ipv4_address *gw,
+			  struct udevice *dev);
 efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
 				u32 *status_code, ulong *file_size, char *headers_buffer);
 #define MAX_HTTP_HEADERS_SIZE SZ_64K
@@ -151,13 +153,16 @@ struct http_header {
 
 void efi_net_parse_headers(ulong *num_headers, struct http_header *headers);
 #else
-static inline void efi_net_get_dp(struct efi_device_path **dp) { }
+static inline void efi_net_dp_from_dev(struct efi_device_path **dp,
+				  struct udevice *udev, bool cache_only) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
-				     struct efi_ipv4_address *gw) { }
+				     struct efi_ipv4_address *gw,
+					 struct udevice *dev) { }
 static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
-				     struct efi_ipv4_address *gw) { }
+				     struct efi_ipv4_address *gw,
+					 struct udevice *dev) { }
 #endif
 
 /* Maximum number of configuration tables */
@@ -649,8 +654,8 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 /* Called by bootefi to make GOP (graphical) interface available */
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
-efi_status_t efi_net_register(void);
-efi_status_t efi_net_do_start(void);
+efi_status_t efi_net_register(struct udevice *dev);
+efi_status_t efi_net_do_start(struct udevice *dev);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 10ec5e9ada3..deafb2ce1c2 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <net.h>
 
 static struct efi_device_path *bootefi_image_path;
 static struct efi_device_path *bootefi_device_path;
@@ -67,7 +68,7 @@ static efi_status_t calculate_paths(const char *dev, const char *devnr,
 
 #if IS_ENABLED(CONFIG_NETDEVICES)
 	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
-		ret = efi_net_set_dp(dev, devnr);
+		ret = efi_net_new_dp(dev, devnr, eth_get_dev());
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 64183d40340..c9bf2726fe2 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1048,7 +1048,7 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
 	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
 		return NULL;
 
-	efi_net_get_addr(&ip, &mask, NULL);
+	efi_net_get_addr(&ip, &mask, NULL, dev);
 
 	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
 	if (!dp1)
@@ -1189,8 +1189,8 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) &&
-		   (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
-		efi_net_get_dp(&dp);
+	           (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
+		efi_net_dp_from_dev(&dp, eth_get_dev(), false);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 88816256b03..60309ee3112 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -188,7 +188,7 @@ static efi_status_t EFIAPI efi_http_configure(struct efi_http_protocol *this,
 
 	if (!ipv4_node->use_default_address) {
 		efi_net_set_addr((struct efi_ipv4_address *)&ipv4_node->local_address,
-				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL);
+				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL, NULL);
 	}
 
 	http_instance->current_offset = 0;
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
index f1c092daafd..9f51f77fa9a 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -60,7 +60,7 @@ static efi_status_t EFIAPI efi_ip4_config2_set_data(struct efi_ip4_config2_proto
 			memcpy((void *)&current_http_ip, data,
 			       sizeof(struct efi_ip4_config2_manual_address));
 			efi_net_set_addr(&current_http_ip.address,
-					 &current_http_ip.subnet_mask, NULL);
+					 &current_http_ip.subnet_mask, NULL, NULL);
 			return EFI_EXIT(EFI_SUCCESS);
 		}
 		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
@@ -133,7 +133,7 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
 		}
 
-		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL);
+		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL, NULL);
 		memcpy(data, (void *)&current_http_ip,
 		       sizeof(struct efi_ip4_config2_manual_address));
 
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index ebb7f4afd3c..f65287ad6ab 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -24,6 +24,8 @@
 #include <vsprintf.h>
 #include <net.h>
 
+#define MAX_NUM_DP_ENTRIES 10
+
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
@@ -36,18 +38,28 @@ static int rx_packet_idx;
 static int rx_packet_num;
 static struct efi_net_obj *netobj;
 
+struct dp_entry {
+	struct efi_device_path *net_dp;
+	struct udevice *dev;
+	bool is_valid;
+};
+
 /*
- * The current network device path. This device path is updated when a new
- * bootfile is downloaded from the network. If then the bootfile is loaded
- * as an efi image, net_dp is passed as the device path of the loaded image.
+ * The network device path cache. An entry is added when a new bootfile
+ * is downloaded from the network. If the bootfile is then loaded as an
+ * efi image, the most recent entry corresponding to the device is passed
+ * as the device path of the loaded image.
  */
-static struct efi_device_path *net_dp;
+static struct dp_entry dp_cache[MAX_NUM_DP_ENTRIES];
+static int next_dp_entry;
 
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 static struct wget_http_info efi_wget_info = {
 	.set_bootdev = false,
 	.check_buffer_size = true,
 
 };
+#endif
 
 /*
  * The notification function of this event is called in every timer cycle
@@ -63,6 +75,7 @@ static struct efi_event *wait_for_packet;
  * struct efi_net_obj - EFI object representing a network interface
  *
  * @header:			EFI object header
+ * @dev:			net udevice
  * @net:			simple network protocol interface
  * @net_mode:			status of the network interface
  * @pxe:			PXE base code protocol interface
@@ -72,6 +85,7 @@ static struct efi_event *wait_for_packet;
  */
 struct efi_net_obj {
 	struct efi_object header;
+	struct udevice *dev;
 	struct efi_simple_network net;
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
@@ -84,6 +98,21 @@ struct efi_net_obj {
 #endif
 };
 
+/*
+ * efi_netobj_is_active() - checks if a netobj is active in the efi subsystem
+ *
+ * @netobj:    pointer to efi_net_obj
+ * Return:     true if active
+ */
+static bool efi_netobj_is_active(struct efi_net_obj *netobj)
+{
+	if (!netobj || !efi_search_obj(&netobj->header))
+		return false;
+
+	return true;
+}
+
+
 /*
  * efi_net_start() - start the network interface
  *
@@ -99,7 +128,6 @@ static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 	efi_status_t ret = EFI_SUCCESS;
 
 	EFI_ENTRY("%p", this);
-
 	/* Check parameters */
 	if (!this) {
 		ret = EFI_INVALID_PARAMETER;
@@ -143,6 +171,8 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 		ret = EFI_NOT_STARTED;
 	} else {
 		/* Disable hardware and put it into the reset state */
+		eth_set_dev(netobj->dev);
+		env_set("ethact", eth_get_name());
 		eth_halt();
 		/* Clear cache of packets */
 		rx_packet_num = 0;
@@ -189,14 +219,13 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 
 	/* Setup packet buffers */
 	net_init();
-	/* Disable hardware and put it into the reset state */
-	eth_halt();
 	/* Clear cache of packets */
 	rx_packet_num = 0;
-	/* Set current device according to environment variables */
-	eth_set_current();
+	/* Set the net device corresponding to the efi net object */
+	eth_set_dev(netobj->dev);
+	env_set("ethact", eth_get_name());
 	/* Get hardware ready for send and receive operations */
-	ret = eth_init();
+	ret = eth_start_udev(netobj->dev);
 	if (ret < 0) {
 		eth_halt();
 		this->mode->state = EFI_NETWORK_STOPPED;
@@ -285,6 +314,8 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		goto out;
 	}
 
+	eth_set_dev(netobj->dev);
+	env_set("ethact", eth_get_name());
 	eth_halt();
 	this->int_status = 0;
 	wait_for_packet->is_signaled = false;
@@ -576,6 +607,9 @@ static efi_status_t EFIAPI efi_net_transmit
 		break;
 	}
 
+	eth_set_dev(netobj->dev);
+	env_set("ethact", eth_get_name());
+
 	/* Ethernet packets always fit, just bounce */
 	memcpy(transmit_buffer, buffer, buffer_size);
 	net_send_packet(transmit_buffer, buffer_size);
@@ -753,6 +787,8 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 		goto out;
 
 	if (!rx_packet_num) {
+		eth_set_dev(netobj->dev);
+		env_set("ethact", eth_get_name());
 		push_packet = efi_net_push;
 		eth_rx();
 		push_packet = NULL;
@@ -878,17 +914,106 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
 	return EFI_UNSUPPORTED;
 }
 
+/**
+ * efi_netobj_set_dp() - set device path of a netobj
+ *
+ * @netobj:	pointer to efi_net_obj
+ * @dp:		device path to set, allocated by caller
+ * Return:	status code
+ */
+efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_path *dp)
+{
+	efi_status_t ret;
+	struct efi_handler *phandler;
+	struct efi_device_path *new_net_dp;
+
+	if (!efi_netobj_is_active(netobj))
+		return EFI_SUCCESS;
+
+	// Create a device path for the netobj
+	new_net_dp = dp;
+	if (!new_net_dp)
+		return EFI_OUT_OF_RESOURCES;
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	// If the device path protocol is not yet installed, install it
+	if (!phandler)
+		goto add;
+
+	// If it is already installed, try to update it
+	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+					       phandler->protocol_interface, new_net_dp);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return EFI_SUCCESS;
+add:
+	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+			       new_net_dp);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_netobj_get_dp() - get device path of a netobj
+ *
+ * @netobj:	pointer to efi_net_obj
+ * Return:	device path, NULL on error
+ */
+static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
+{
+	struct efi_handler *phandler;
+
+	if (!efi_netobj_is_active(netobj))
+		return NULL;
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	if (phandler && phandler->protocol_interface)
+		return efi_dp_dup(phandler->protocol_interface);
+
+	return NULL;
+}
+
 /**
  * efi_net_do_start() - start the efi network stack
  *
  * This gets called from do_bootefi_exec() each time a payload gets executed.
  *
+ * @dev:	net udevice
  * Return:	status code
  */
-efi_status_t efi_net_do_start(void)
+efi_status_t efi_net_do_start(struct udevice *dev)
 {
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_device_path *net_dp;
+
+	if (dev != netobj->dev )
+		return r;
+
+	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
+	// If no dp cache entry applies and there already
+	// is a device path installed, continue
+	if (!net_dp) {
+		if (efi_netobj_get_dp(netobj))
+			goto set_addr;
+		else
+			net_dp = efi_dp_from_eth(netobj->dev);
+
+	}
+
+	if (!net_dp)
+		return EFI_OUT_OF_RESOURCES;
 
+	r = efi_netobj_set_dp(netobj, net_dp);
+	if (r != EFI_SUCCESS)
+		return r;
+set_addr:
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
 	/*
 	 * No harm on doing the following. If the PXE handle is present, the client could
@@ -896,7 +1021,7 @@ efi_status_t efi_net_do_start(void)
 	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
 	 */
 	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, dev);
 #endif
 
 	return r;
@@ -906,13 +1031,14 @@ efi_status_t efi_net_do_start(void)
  * efi_net_register() - register the simple network protocol
  *
  * This gets called from do_bootefi_exec().
+ * @dev:	net udevice
  */
-efi_status_t efi_net_register(void)
+efi_status_t efi_net_register(struct udevice *dev)
 {
 	efi_status_t r;
 	int i;
 
-	if (!eth_get_dev()) {
+	if (!dev) {
 		/* No network device active, don't expose any */
 		return EFI_SUCCESS;
 	}
@@ -922,6 +1048,8 @@ efi_status_t efi_net_register(void)
 	if (!netobj)
 		goto out_of_resources;
 
+	netobj->dev = dev;
+
 	/* Allocate an aligned transmit buffer */
 	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
 	if (!transmit_buffer)
@@ -938,6 +1066,7 @@ efi_status_t efi_net_register(void)
 		if (!receive_buffer[i])
 			goto out_of_resources;
 	}
+
 	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
 				 sizeof(*receive_lengths));
 	if (!receive_lengths)
@@ -952,12 +1081,6 @@ efi_status_t efi_net_register(void)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
-	if (!net_dp)
-		efi_net_set_dp("Net", NULL);
-	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
-			     net_dp);
-	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
 	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
 			     &netobj->pxe);
 	if (r != EFI_SUCCESS)
@@ -978,7 +1101,9 @@ efi_status_t efi_net_register(void)
 	netobj->net.receive = efi_net_receive;
 	netobj->net.mode = &netobj->net_mode;
 	netobj->net_mode.state = EFI_NETWORK_STOPPED;
-	memcpy(netobj->net_mode.current_address.mac_addr, eth_get_ethaddr(), 6);
+	if (dev_get_plat(dev))
+		memcpy(netobj->net_mode.current_address.mac_addr,
+		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
 	netobj->net_mode.hwaddr_size = ARP_HLEN;
 	netobj->net_mode.media_header_size = ETHER_HDR_SIZE;
 	netobj->net_mode.max_packet_size = PKTSIZE;
@@ -1012,6 +1137,7 @@ efi_status_t efi_net_register(void)
 		return r;
 	}
 	netobj->net.wait_for_packet = wait_for_packet;
+
 	/*
 	 * Create a timer event.
 	 *
@@ -1045,7 +1171,6 @@ efi_status_t efi_net_register(void)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1064,46 +1189,91 @@ out_of_resources:
 }
 
 /**
- * efi_net_set_dp() - set device path of efi net device
+ * efi_net_new_dp() - update device path associated to a net udevice
  *
  * This gets called to update the device path when a new boot
  * file is downloaded
  *
  * @dev:	dev to set the device path from
  * @server:	remote server address
+ * @udev:	net udevice
  * Return:	status code
  */
-efi_status_t efi_net_set_dp(const char *dev, const char *server)
+efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev)
 {
-	efi_free_pool(net_dp);
+	efi_status_t ret;
+	struct efi_device_path *old_net_dp, *new_net_dp;
+	struct efi_device_path **dp;
 
-	net_dp = NULL;
+	dp = &dp_cache[next_dp_entry].net_dp;
+
+	dp_cache[next_dp_entry].dev = udev;
+	dp_cache[next_dp_entry].is_valid = true;
+	next_dp_entry++;
+	next_dp_entry %= MAX_NUM_DP_ENTRIES;
+
+	old_net_dp = *dp;
+	new_net_dp = NULL;
 	if (!strcmp(dev, "Net"))
-		net_dp = efi_dp_from_eth(eth_get_dev());
+		new_net_dp = efi_dp_from_eth(udev);
 	else if (!strcmp(dev, "Http"))
-		net_dp = efi_dp_from_http(server, eth_get_dev());
+		new_net_dp = efi_dp_from_http(server, udev);
+	if (!new_net_dp)
+		return EFI_OUT_OF_RESOURCES;
 
-	if (!net_dp)
+	*dp = new_net_dp;
+	// Free the old cache entry
+	efi_free_pool(old_net_dp);
+
+	if (!netobj || netobj->dev != udev)
+		return EFI_SUCCESS;
+
+	new_net_dp = efi_dp_dup(*dp);
+	if (!new_net_dp)
 		return EFI_OUT_OF_RESOURCES;
+	ret = efi_netobj_set_dp(netobj, new_net_dp);
+	if (ret != EFI_SUCCESS)
+		efi_free_pool(new_net_dp);
 
-	return EFI_SUCCESS;
+	return ret;
 }
 
 /**
- * efi_net_get_dp() - get device path of efi net device
+ * efi_net_dp_from_dev() - get device path associated to a net udevice
  *
  * Produce a copy of the current device path
  *
- * @dp:		copy of the current device path, or NULL on error
+ * @dp:		copy of the current device path
+ * @udev:	net udevice
+ * @cache_only:	get device path from cache only
  */
-void efi_net_get_dp(struct efi_device_path **dp)
+void efi_net_dp_from_dev(struct efi_device_path **dp, struct udevice *udev, bool cache_only)
 {
+	int i, j;
+
 	if (!dp)
 		return;
-	if (!net_dp)
-		efi_net_set_dp("Net", NULL);
-	if (net_dp)
-		*dp = efi_dp_dup(net_dp);
+
+	*dp = NULL;
+
+	if (cache_only)
+		goto cache;
+
+	if (netobj && netobj->dev == udev) {
+		*dp = efi_netobj_get_dp(netobj);
+		if (*dp)
+			return;
+	}
+cache:
+	// Search in the cache
+	i = (next_dp_entry + MAX_NUM_DP_ENTRIES - 1) % MAX_NUM_DP_ENTRIES;
+	for (j = 0; dp_cache[i].is_valid && j < MAX_NUM_DP_ENTRIES;
+		i = (i + MAX_NUM_DP_ENTRIES - 1) % MAX_NUM_DP_ENTRIES, j++) {
+		if (dp_cache[i].dev == udev) {
+			*dp = efi_dp_dup(dp_cache[i].net_dp);
+			return;
+		}
+	}
 }
 
 /**
@@ -1119,11 +1289,15 @@ void efi_net_get_dp(struct efi_device_path **dp)
  *		be filled with the current network mask
  * @gw:		pointer to an efi_ipv4_address struct to be
  *		filled with the current network gateway
+ * @dev:	udevice
  */
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw)
+		      struct efi_ipv4_address *gw,
+		      struct udevice *dev)
 {
+	if (!dev)
+		dev = eth_get_dev();
 #ifdef CONFIG_NET_LWIP
 	char ipstr[] = "ipaddr\0\0";
 	char maskstr[] = "netmask\0\0";
@@ -1132,7 +1306,7 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
 	struct in_addr tmp;
 	char *env;
 
-	idx = dev_seq(eth_get_dev());
+	idx = dev_seq(dev);
 
 	if (idx < 0 || idx > 99) {
 		log_err("unexpected idx %d\n", idx);
@@ -1179,11 +1353,15 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
  * @ip:		pointer to new IP address
  * @mask:	pointer to new network mask to set
  * @gw:		pointer to new network gateway
+ * @dev:	udevice
  */
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw)
+		      struct efi_ipv4_address *gw,
+		      struct udevice *dev)
 {
+	if (!dev)
+		dev = eth_get_dev();
 #ifdef CONFIG_NET_LWIP
 	char ipstr[] = "ipaddr\0\0";
 	char maskstr[] = "netmask\0\0";
@@ -1192,7 +1370,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 	struct in_addr *addr;
 	char tmp[46];
 
-	idx = dev_seq(eth_get_dev());
+	idx = dev_seq(dev);
 
 	if (idx < 0 || idx > 99) {
 		log_err("unexpected idx %d\n", idx);
@@ -1230,6 +1408,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 #endif
 }
 
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 /**
  * efi_net_set_buffer() - allocate a buffer of min 64K
  *
@@ -1337,6 +1516,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		ret = efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info.hdr_cont_len : 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
+		eth_set_dev(netobj->dev);
+		env_set("ethact", eth_get_name());
 		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
 		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
 			// Try again with updated buffer size
@@ -1344,6 +1525,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
 			if (ret != EFI_SUCCESS)
 				goto out;
+			eth_set_dev(netobj->dev);
+			env_set("ethact", eth_get_name());
 			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
 				efi_free_pool(*buffer);
 				ret = EFI_DEVICE_ERROR;
@@ -1363,6 +1546,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		ret = efi_net_set_buffer(buffer, 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
+		eth_set_dev(netobj->dev);
+		env_set("ethact", eth_get_name());
 		wget_request((ulong)*buffer, url, &efi_wget_info);
 		*file_size = 0;
 		*status_code = efi_wget_info.status_code;
@@ -1376,3 +1561,4 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 out:
 	return ret;
 }
+#endif
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index eeed82c0736..48f91da5df7 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -11,6 +11,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
+#include <net.h>
 
 #define OBJ_LIST_INITIALIZED 0
 #define OBJ_LIST_NOT_INITIALIZED 1
@@ -219,7 +220,7 @@ static efi_status_t efi_start_obj_list(void)
 	efi_status_t ret = EFI_SUCCESS;
 
 	if (IS_ENABLED(CONFIG_NETDEVICES))
-		ret = efi_net_do_start();
+		ret = efi_net_do_start(eth_get_dev());
 
 	return ret;
 }
@@ -336,7 +337,7 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 	if (IS_ENABLED(CONFIG_NETDEVICES)) {
-		ret = efi_net_register();
+		ret = efi_net_register(eth_get_dev());
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-- 
2.45.2

