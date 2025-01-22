Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D48C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D0280C8F;
	Wed, 22 Jan 2025 18:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HaMZmdzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9DB80A4F; Wed, 22 Jan 2025 18:09:57 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C66E80AE5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso122669855ad.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565793; x=1738170593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rFcW07sxhR+DJSviFqIXx21is8t90VtKVMk1ZYMaLo=;
 b=HaMZmdzCNcfjHiqdzD6EsWH2DHtKVUo4DX6PJgDLAf8ZgLkT7VpaHZnapsDt/m4ELu
 wPzDUIsGZ0qg6VQr4VyUnHrSfEJkntAnG/92ekn13vTFDGbNvR60PQrc02nftgLfr+vn
 wzfDxyiMgC0kusptkXxnj4fcTEkFUTwqxSqbNusjXrnodh9y2OrQNONVRpzQof9dU69l
 b74GcGBvNg1aKxmjI5FpBqYMaj1uGs3laiU2gXwgAvF6UDQof8TEGowmOUhNj9843Iw7
 m7uYmOwQkBayPA9ffS5pMd3l5qEF+ZJi5WexfTZWqe1AieH7dM0xsujbnE0tSPv9t1tZ
 EbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565793; x=1738170593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rFcW07sxhR+DJSviFqIXx21is8t90VtKVMk1ZYMaLo=;
 b=JN8WipxKA26dttBh1d06ge6JLdkiS8wPgFoNWgVfzQ37Ngs+c8qCz+FOv8Hb9+YdpQ
 ZcwxsseQddklYfOsAB0uGsY8AjvqauTrqZJkN37Vg1BBdPROd3FyhFMzG7WzOSDkfGQ5
 etL32YD0zabgPauwGbwzPj2WPKWbOfSgKrraB5HgIRq53tpHnl0Z1BedIS2zvZJD8Kz/
 7AQ+5LixbcLf/xuyWKJ5KwqdJIoZveKP/GQcsP1mcT14ssRg6pxEuAS9z2m02aOGsg9A
 IX2aU0bZ9F6pAGr+TxtgyqbdAWx66z/OF/m8r8fSdlRMIjyJ4gsTBWvdIg4fdGp6uAQr
 QWPw==
X-Gm-Message-State: AOJu0Yx0fqq16NWldiqIYiUxTRmoVaxk+8ApAnhLtdiP6mNJUaW55NnH
 fmXnrP7emSn6szjzTkmyQnu5Vv7YIswD81TvvbL/tf6H7rCrRPfuBiKGVUAr
X-Gm-Gg: ASbGnctYPx5tAne7wK9LY3UYzS4g4uj4XL4gZ7e2un++t2wIvYmHwh/xRIJE48SFgcl
 BAJjXK1k9KPGo5P+3NaEe/+Up5hR8ipZLsddK8WdDvE2ewJX86y0SiEqycWXe/kr7YqBtDGKfi7
 o7YNqwIV5Ya9kUN7DgyLwsYaqle6LzAag3bN/3cboWFG7RLnmpzk8cB1J36uIaRQK6/AT9bgRv9
 USUvEfYCybasJeKn2+3MXPsUdt/So6NEw645d2ZxvkSHJE/E+Z1dtF8f/kqJdkAvx8INstSxNUe
 RQ==
X-Google-Smtp-Source: AGHT+IHUIXNDqYt0ek1QTpSw6TkP3Tro9dyRNmQCkMiJFynN6mTQU4KCdu0ygom521EfnQxeNjsHwA==
X-Received: by 2002:a17:903:2282:b0:21c:fb6:7c52 with SMTP id
 d9443c01a7336-21c356080e1mr331074695ad.45.1737565792627; 
 Wed, 22 Jan 2025 09:09:52 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:52 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 16/21] efi_loader: efi_net: Add functions to [un]register http
 and ip4_config2 protocols, and add pxe protocol on demand
Date: Wed, 22 Jan 2025 14:08:53 -0300
Message-ID: <20250122170858.961359-17-adriano.cordova@canonical.com>
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

Add efi_ipconfig_[un]register and efi_http_[un]register to [un]register
the ip4_config2 and the http_service_binding protocol. And add the pxe
protocol only if a dhcp_ack was received. The latter makes sense as pxe
is otherwise not currently implemented.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h          |   8 +-
 lib/efi_loader/efi_http.c     |  30 ++++-
 lib/efi_loader/efi_ipconfig.c |  36 +++++-
 lib/efi_loader/efi_net.c      | 212 ++++++++++++++++++++++------------
 4 files changed, 201 insertions(+), 85 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3bb95cfeb9..063c0a05fd 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -655,10 +655,14 @@ efi_status_t efi_net_init(void);
 efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
-				   struct efi_ip4_config2_protocol *ip4config);
+				   struct efi_ip4_config2_protocol **ip4config);
+efi_status_t efi_ipconfig_unregister(const efi_handle_t handle,
+				     struct efi_ip4_config2_protocol *ip4config);
 /* Called by efi_net_register to make the http protocol available */
 efi_status_t efi_http_register(const efi_handle_t handle,
-			       struct efi_service_binding_protocol *http_service_binding);
+			       struct efi_service_binding_protocol **http_service_binding);
+efi_status_t efi_http_unregister(const efi_handle_t handle,
+				 struct efi_service_binding_protocol *http_service_binding);
 
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 20450604ec..8831ad922c 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -484,23 +484,45 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
  *
  */
 efi_status_t efi_http_register(const efi_handle_t handle,
-			       struct efi_service_binding_protocol *http_service_binding)
+			       struct efi_service_binding_protocol **http_service_binding)
 {
 	efi_status_t r = EFI_SUCCESS;
 
+	r = efi_allocate_pool(EFI_LOADER_DATA, sizeof(**http_service_binding),
+			      (void **)http_service_binding);
+	if (r != EFI_SUCCESS)
+		return r;
 	r = efi_add_protocol(handle, &efi_http_service_binding_guid,
-			     http_service_binding);
+			     *http_service_binding);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
-	http_service_binding->create_child = efi_http_service_binding_create_child;
-	http_service_binding->destroy_child = efi_http_service_binding_destroy_child;
+	(*http_service_binding)->create_child = efi_http_service_binding_create_child;
+	(*http_service_binding)->destroy_child = efi_http_service_binding_destroy_child;
 
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	return r;
 }
 
+/**
+ * efi_http_unregister() - unregister the http protocol
+ *
+ */
+efi_status_t efi_http_unregister(const efi_handle_t handle,
+				 struct efi_service_binding_protocol *http_service_binding)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+	r = EFI_CALL(efi_uninstall_protocol(handle, &efi_http_service_binding_guid,
+					    http_service_binding, true));
+	if (r != EFI_SUCCESS)
+		return r;
+	efi_free_pool(http_service_binding);
+
+	return EFI_SUCCESS;
+}
+
 enum efi_http_status_code efi_u32_to_httpstatus(u32 status)
 {
 	switch (status) {
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
index 10035e8a7b..ead2e147bd 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -193,12 +193,18 @@ static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_conf
  *
  */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
-				   struct efi_ip4_config2_protocol *ip4config)
+				   struct efi_ip4_config2_protocol **ip4config)
 {
 	efi_status_t r = EFI_SUCCESS;
 
+	if (!ip4config)
+		return EFI_INVALID_PARAMETER;
+
+	r = efi_allocate_pool(EFI_LOADER_DATA, sizeof(**ip4config), (void **)ip4config);
+	if (r != EFI_SUCCESS)
+		return r;
 	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
-			     ip4config);
+			     *ip4config);
 	if (r != EFI_SUCCESS) {
 		log_err("ERROR: Failure to add protocol\n");
 		return r;
@@ -206,10 +212,28 @@ efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 
 	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
 
-	ip4config->set_data = efi_ip4_config2_set_data;
-	ip4config->get_data = efi_ip4_config2_get_data;
-	ip4config->register_data_notify = efi_ip4_config2_register_notify;
-	ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
+	(*ip4config)->set_data = efi_ip4_config2_set_data;
+	(*ip4config)->get_data = efi_ip4_config2_get_data;
+	(*ip4config)->register_data_notify = efi_ip4_config2_register_notify;
+	(*ip4config)->unregister_data_notify = efi_ip4_config2_unregister_notify;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_ipconfig_unregister() - unregister the ip4_config2 protocol
+ *
+ */
+efi_status_t efi_ipconfig_unregister(const efi_handle_t handle,
+				     struct efi_ip4_config2_protocol *ip4config)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+	r = EFI_CALL(efi_uninstall_protocol(handle, &efi_ip4_config2_guid,
+					    ip4config, true));
+	if (r != EFI_SUCCESS)
+		return r;
+	efi_free_pool(ip4config);
 
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b5284ffe34..c172da4e66 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <linux/sizes.h>
 #include <malloc.h>
 #include <vsprintf.h>
@@ -29,6 +30,8 @@
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
 
 static struct wget_http_info efi_wget_info = {
 	.set_bootdev = false,
@@ -80,10 +83,10 @@ struct efi_net_obj {
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
-	struct efi_ip4_config2_protocol ip4_config2;
+	struct efi_ip4_config2_protocol *ip4_config2;
 #endif
 #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
-	struct efi_service_binding_protocol http_service_binding;
+	struct efi_service_binding_protocol *http_service_binding;
 #endif
 	void *new_tx_packet;
 	void *transmit_buffer;
@@ -755,6 +758,8 @@ out:
 	return EFI_EXIT(ret);
 }
 
+efi_status_t efi_net_add_pxe(struct efi_net_obj *netobj);
+
 /**
  * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
  *
@@ -789,9 +794,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 	next_dhcp_entry++;
 	next_dhcp_entry %= MAX_NUM_DHCP_ENTRIES;
 
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->dev == dev) {
-			net_objs[i]->pxe_mode.dhcp_ack = **dhcp_ack;
+	if (efi_obj_list_initialized == EFI_SUCCESS) {
+		for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+			if (net_objs[i] && net_objs[i]->dev == dev) {
+				efi_net_add_pxe(net_objs[i]);
+				break;
+			}
 		}
 	}
 }
@@ -1058,6 +1066,52 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 	return NULL;
 }
 
+/**
+ * efi_net_add_pxe() - install the pxe protocol to a netobj
+ *
+ * @netobj:	pointer to efi_net_obj
+ * Return:	status code
+ */
+efi_status_t efi_net_add_pxe(struct efi_net_obj *netobj)
+{
+	efi_status_t r = EFI_SUCCESS;
+	struct efi_handler *phandler;
+	int i, j;
+
+	r = efi_search_protocol(netobj->handle, &efi_pxe_base_code_protocol_guid, &phandler);
+	if (r == EFI_SUCCESS)
+		return r;
+
+	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
+	for (j = 0; netobj->dev && dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
+	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
+		if (netobj->dev == dhcp_cache[i].dev) {
+			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
+			r = efi_add_protocol(netobj->handle, &efi_pxe_base_code_protocol_guid,
+					     &netobj->pxe);
+			if (r != EFI_SUCCESS)
+				return r;
+			netobj->pxe.revision = EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
+			netobj->pxe.start = efi_pxe_base_code_start;
+			netobj->pxe.stop = efi_pxe_base_code_stop;
+			netobj->pxe.dhcp = efi_pxe_base_code_dhcp;
+			netobj->pxe.discover = efi_pxe_base_code_discover;
+			netobj->pxe.mtftp = efi_pxe_base_code_mtftp;
+			netobj->pxe.udp_write = efi_pxe_base_code_udp_write;
+			netobj->pxe.udp_read = efi_pxe_base_code_udp_read;
+			netobj->pxe.set_ip_filter = efi_pxe_base_code_set_ip_filter;
+			netobj->pxe.arp = efi_pxe_base_code_arp;
+			netobj->pxe.set_parameters = efi_pxe_base_code_set_parameters;
+			netobj->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
+			netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
+			netobj->pxe.mode = &netobj->pxe_mode;
+			break;
+		}
+	}
+
+	return r;
+}
+
 /**
  * efi_netobj_start() - start an efi net device
  *
@@ -1069,7 +1123,7 @@ efi_status_t efi_netobj_start(struct efi_net_obj *netobj)
 {
 	efi_status_t r = EFI_SUCCESS;
 	struct efi_device_path *net_dp;
-	int i;
+
 
 	if (!efi_netobj_is_active(netobj))
 		return r;
@@ -1091,16 +1145,8 @@ efi_status_t efi_netobj_start(struct efi_net_obj *netobj)
 	if (r != EFI_SUCCESS)
 		return r;
 set_addr:
-#ifdef CONFIG_EFI_HTTP_PROTOCOL
-	/*
-	 * No harm on doing the following. If the PXE handle is present, the client could
-	 * find it and try to get its IP address from it. In here the PXE handle is present
-	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
-	 */
 	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask,
-			  NULL, netobj->dev);
-#endif
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, netobj->dev);
 
 	return 0;
 }
@@ -1137,16 +1183,20 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 {
 	efi_status_t r;
 	struct udevice *dev;
+	struct efi_handler *phandler;
 	void *transmit_buffer;
 	uchar **receive_buffer;
 	size_t *receive_lengths;
-	int i, j;
+	int i;
 
-	if (!netobj || !netobj->net || efi_netobj_is_active(netobj))
+	if (!netobj || !netobj->net)
 		return 0;
 
 	dev = netobj->dev;
 
+	if (efi_netobj_is_active(netobj))
+		goto set_timers;
+
 	if (!netobj->net_mode)
 		netobj->net_mode = calloc(1, sizeof(*netobj->net_mode));
 	if (!netobj->net_mode)
@@ -1193,11 +1243,6 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 			netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-
-	r = efi_add_protocol(netobj->handle, &efi_pxe_base_code_protocol_guid,
-			     &netobj->pxe);
-	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
 	netobj->net->revision = EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
 	netobj->net->start = efi_net_start;
 	netobj->net->stop = efi_net_stop;
@@ -1223,38 +1268,13 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	netobj->net_mode->max_packet_size = PKTSIZE;
 	netobj->net_mode->if_type = ARP_ETHER;
 
-	netobj->pxe.revision = EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
-	netobj->pxe.start = efi_pxe_base_code_start;
-	netobj->pxe.stop = efi_pxe_base_code_stop;
-	netobj->pxe.dhcp = efi_pxe_base_code_dhcp;
-	netobj->pxe.discover = efi_pxe_base_code_discover;
-	netobj->pxe.mtftp = efi_pxe_base_code_mtftp;
-	netobj->pxe.udp_write = efi_pxe_base_code_udp_write;
-	netobj->pxe.udp_read = efi_pxe_base_code_udp_read;
-	netobj->pxe.set_ip_filter = efi_pxe_base_code_set_ip_filter;
-	netobj->pxe.arp = efi_pxe_base_code_arp;
-	netobj->pxe.set_parameters = efi_pxe_base_code_set_parameters;
-	netobj->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
-	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
-	netobj->pxe.mode = &netobj->pxe_mode;
-
-	ret = EFI_CALL(efi_connect_controller(net_objs[i]->handle, NULL, NULL, 0));
-	if (ret != EFI_SUCCESS)
-		return -1;
+	efi_net_add_pxe(netobj);
 
-	/*
-	 * Scan dhcp entries for one corresponding
-	 * to this udevice, from newest to oldest
-	 */
-	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
-	for (j = 0; dev && dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
-	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
-		if (dev == dhcp_cache[i].dev) {
-			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
-			break;
-		}
-	}
+	r = EFI_CALL(efi_connect_controller(netobj->handle, NULL, NULL, 0));
+	if (r != EFI_SUCCESS)
+		return -1;
 
+set_timers:
 	/*
 	 * Create WaitForPacket event.
 	 */
@@ -1289,16 +1309,26 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	}
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
+	netobj->ip4_config2 = NULL;
+	r = efi_search_protocol(netobj->handle, &efi_ip4_config2_guid, &phandler);
+	if (r == EFI_SUCCESS)
+		goto http;
 	r = efi_ipconfig_register(netobj->handle, &netobj->ip4_config2);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
 
+http:
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
+	netobj->http_service_binding = NULL;
+	r = efi_search_protocol(netobj->handle, &efi_http_service_binding_guid, &phandler);
+	if (r == EFI_SUCCESS)
+		goto out;
 	r = efi_http_register(netobj->handle, &netobj->http_service_binding);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
+out:
 	return 0;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1316,7 +1346,6 @@ out_of_resources:
 efi_status_t efi_net_init(void)
 {
 	int i, r;
-	efi_status_t ret;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
 		if (net_objs[i]) {
@@ -1422,9 +1451,12 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 int efi_net_register(void *ctx, struct event *event)
 {
 	struct udevice *dev;
+	struct driver *drv;
+	struct efi_netdev_plat *plat;
+	efi_handle_t handle;
+	struct efi_simple_network *net;
 	enum uclass_id id;
 	struct efi_net_obj *netobj;
-	efi_status_t ret;
 	int i, r;
 
 	dev = event->data.dm.dev;
@@ -1444,17 +1476,24 @@ int efi_net_register(void *ctx, struct event *event)
 		}
 	}
 
-	netobj = efi_netobj_alloc(NULL, NULL, dev);
+	handle = NULL;
+	net = NULL;
+	drv = lists_driver_lookup_name("efi_netdev");
+	if (drv && dev->driver == drv) {
+		plat = dev_get_plat(dev);
+		handle = plat->handle;
+		net = plat->snp;
+	}
+
+	netobj = efi_netobj_alloc(handle, net, dev);
 
 	if (!netobj)
 		return -1;
 
 	if (efi_obj_list_initialized == EFI_SUCCESS) {
-		if (!efi_netobj_is_active(netobj)) {
-			r = efi_netobj_init(netobj);
-			if (r)
-				return -1;
-		}
+		r = efi_netobj_init(netobj);
+		if (r)
+			return -1;
 	}
 
 	return 0;
@@ -1471,7 +1510,9 @@ int efi_net_register(void *ctx, struct event *event)
 int efi_net_unregister(void *ctx, struct event *event)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	int r;
 	struct udevice *dev;
+	struct driver *drv;
 	enum uclass_id id;
 	struct efi_net_obj *netobj;
 	struct efi_handler *phandler;
@@ -1496,18 +1537,22 @@ int efi_net_unregister(void *ctx, struct event *event)
 		}
 	}
 
-	if (!netobj)
+	if (!netobj || !efi_netobj_is_active(netobj))
 		return 0;
 
-	if (efi_netobj_is_active(netobj)) {
+	drv = lists_driver_lookup_name("efi_netdev");
+	if (!drv) {
+		log_err("Cannot find driver 'efi_netdev'\n");
+		return -1;
+	}
+
+	if (drv != dev->driver) {
 		ret = EFI_CALL(efi_disconnect_controller(netobj->handle, NULL, NULL));
 		if (ret != EFI_SUCCESS)
 			return -1;
-
 		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
 		if (ret != EFI_SUCCESS)
 			return -1;
-
 		ret = EFI_CALL(efi_close_event(netobj->network_timer_event));
 		if (ret != EFI_SUCCESS)
 			return -1;
@@ -1517,22 +1562,43 @@ int efi_net_unregister(void *ctx, struct event *event)
 		if (phandler && phandler->protocol_interface)
 			interface = phandler->protocol_interface;
 
+		if (netobj->handle->dev) {
+			r = efi_unlink_dev(netobj->handle);
+			if (r)
+				return -1;
+		}
+	}
+
+#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
+	if (netobj->ip4_config2) {
+		r = efi_ipconfig_unregister(netobj->handle, netobj->ip4_config2);
+		if (r != EFI_SUCCESS)
+			return -1;
+		netobj->ip4_config2 = NULL;
+	}
+#endif
+
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	if (netobj->http_service_binding) {
+		r = efi_http_unregister(netobj->handle, netobj->http_service_binding);
+		if (r != EFI_SUCCESS)
+			return -1;
+		netobj->http_service_binding = NULL;
+	}
+#endif
+
+	if (drv != dev->driver) {
 		ret = efi_delete_handle(netobj->handle);
 		if (ret != EFI_SUCCESS)
 			return -1;
 
 		efi_free_pool(interface);
+		if (netobj->net)
+			free(netobj->net);
+		if (netobj->net_mode)
+			free(netobj->net_mode);
 	}
 
-	if (netobj->net) {
-		if (netobj->net->mode)
-			free(netobj->net->mode);
-		free(netobj->net);
-	}
-
-	if (netobj->net_mode)
-		free(netobj->net_mode);
-
 	// Mark as free in the list
 	netobj->handle = NULL;
 	netobj->dev = NULL;
-- 
2.43.0

