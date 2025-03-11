Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D94BC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A623A819A2;
	Tue, 11 Mar 2025 17:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EgpB+r1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF658198A; Tue, 11 Mar 2025 17:48:19 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E45D819A2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22359001f1aso136084725ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711696; x=1742316496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3/IdOBsxLL9RCTbU0nlp3+pZwf6MrCimi6zEVzHNtg=;
 b=EgpB+r1N5xq9SY+Pe3M6+GMY3pkM48HISuwIDer6RPrqmxx5+vyQyhLOYZwmaB5gt0
 us4hWeGf20wWEOJWdanR6+Okd9x9FPJrYWssh4OCHhy91XR1WsntIt/k4ChwprcPALSq
 omP1P1GAbQrsY1omQpKNfMWXkoVi0EwBl+uxrwY6+qFEab526ORvBXIf2GCNAAYA3A4t
 ECT0jMYtBh5IzAC5QIimfcr+RD5Yh5TuazEX4QG4KnZdJr7OMJK9GhYozsOm9geFyDam
 7oHaBw/4sl9IGYOSO9QXOlWYVGd6+hf+G36bYwRG9gGiA7lpgh7uSXT8eRRCPrKBXsPe
 roQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711696; x=1742316496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3/IdOBsxLL9RCTbU0nlp3+pZwf6MrCimi6zEVzHNtg=;
 b=OFDT4gJKJdzOHp7h3YN0leApNPP62U/qxVH6/eDuSab3ARzzEUZGMtrILfAk3JWP3T
 aiEBeqJmZnH+Tv4mbv7zksJykutGV0+khC+F83PWYiaSP1qO/aJT+M6SywholbVQotpi
 x/qTHKG/c6GKsarAVAFVz6ApiUZjz9svDjjWs4zCrTutqHFf7vCNu5VDqYxrTcU36n8I
 Mzzo/fthupPAua8TqUydJCKLVhSpYbqO/M5YBdm1tK5R/jSwJWogfT+D/t17Rnu+zNvM
 9FAz65EOUdUpvQ0eIaLZDdxvdlIfK0aYUiGjUgoJbjjKdpkeN2YhoY8YU/mxH8Dpfx/H
 afMA==
X-Gm-Message-State: AOJu0YwKpHLXPKtpF0TUUXDvrKTC68QD0Wg3oqtL5h6RlajXV9cOzZN0
 kzFYkvbRU7ncl97pLF8mB7jXFoSG87E8CqxjTvKFR10bb6o9bjwd6NzbLvCmTAI=
X-Gm-Gg: ASbGncsbAtifh+WzCtmGxeoPhtjW7tAc71nVi3ryAYxmQq77oMlcKneQKNn8kztD48S
 cG+9rg8+7rZ2p1Ac+HBa1D40gB7p6mQquX3qT1sp7q6APSilIi3jhF6JB94yc2Jw6ykYnYl+rZy
 iExRPxUD2Ftybxk8e3PcCa/JUy1VzJSEpc+gup82UieFDFoKf/VJI1gMGahk76gF4+yuH6o/zuT
 esem2bSpOXvIbqogs+PFdyyLL8aN1ojAD7CEVWDymVLoN0FcMhDaPtYTScLgdPE9v1cD66//ksF
 iAdl0665T//iuSNuH8ZhX15hjAhK1PViF/4haQtg4UGT4oigVF4r9zVTph+Qz2f7jA==
X-Google-Smtp-Source: AGHT+IFCs5pQAB78M1ZrgDYCuDHQGx5v2dmaRa7KO0Z9MWXTRoNjUU1u8QGHO4wW2VH4c1VKtwJgAg==
X-Received: by 2002:a05:6a00:194b:b0:736:55ec:ea94 with SMTP id
 d2e1a72fcca58-736aab13baemr29578023b3a.20.1741711695681; 
 Tue, 11 Mar 2025 09:48:15 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:15 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 11/16] efi_loader: efi_net: Add http, ip4_config2,
 and pxe on demand
Date: Tue, 11 Mar 2025 13:47:53 -0300
Message-ID: <20250311164758.421900-12-adriano.cordova@canonical.com>
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

Add http and ip4_config2 only if they are not already provided
in the handle. The current use of pxe is only to store an ip
address if a dhcp ack is received, this address is used by grub.
Add pxe only if a dhcp ack is actually received.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h          |   8 +-
 lib/efi_loader/efi_http.c     |  30 ++++-
 lib/efi_loader/efi_ipconfig.c |  36 +++++-
 lib/efi_loader/efi_net.c      | 203 +++++++++++++++++++++++-----------
 4 files changed, 199 insertions(+), 78 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 35f500fd97d..ad234dbe6b3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -677,10 +677,14 @@ efi_status_t efi_net_init(void);
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
 efi_status_t efi_initrd_register(void);
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 189317fe2d2..dcef875f5b5 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -486,23 +486,45 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
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
+	r = efi_uninstall_protocol(handle, &efi_http_service_binding_guid,
+				   http_service_binding, true);
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
index 9f51f77fa9a..18f659f4ed1 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -194,12 +194,18 @@ static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_conf
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
@@ -207,10 +213,28 @@ efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 
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
+	r = efi_uninstall_protocol(handle, &efi_ip4_config2_guid,
+				   ip4config, true);
+	if (r != EFI_SUCCESS)
+		return r;
+	efi_free_pool(ip4config);
 
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index fd43eec4c03..5a00e7a570c 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -19,6 +19,7 @@
 
 #include <efi_loader.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <linux/sizes.h>
 #include <malloc.h>
 #include <vsprintf.h>
@@ -31,6 +32,8 @@
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
 
 struct dp_entry {
 	struct efi_device_path *net_dp;
@@ -93,10 +96,10 @@ struct efi_net_obj {
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
@@ -761,6 +764,8 @@ out:
 	return EFI_EXIT(ret);
 }
 
+efi_status_t efi_net_add_pxe(struct efi_net_obj *netobj);
+
 /**
  * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
  *
@@ -795,9 +800,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
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
@@ -1069,6 +1077,52 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
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
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_netobj_start() - start an efi net device
  *
@@ -1102,15 +1156,8 @@ efi_status_t efi_netobj_start(struct efi_net_obj *netobj)
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
 			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, netobj->dev);
-#endif
 
 	return 0;
 }
@@ -1147,16 +1194,20 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 {
 	efi_status_t r;
 	struct udevice *dev;
+	struct efi_handler *phandler;
 	void *transmit_buffer = NULL;
 	uchar **receive_buffer = NULL;
 	size_t *receive_lengths = NULL;
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
@@ -1203,11 +1254,6 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
@@ -1233,38 +1279,15 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
+	r = efi_net_add_pxe(netobj);
+	if (r != EFI_SUCCESS)
+		return -1;
 
 	r = EFI_CALL(efi_connect_controller(netobj->handle, NULL, NULL, 0));
 	if (r != EFI_SUCCESS)
 		return -1;
 
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
-
+set_timers:
 	/*
 	 * Create WaitForPacket event.
 	 */
@@ -1299,16 +1322,26 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
@@ -1428,6 +1461,10 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 int efi_net_register(void *ctx, struct event *event)
 {
 	struct udevice *dev;
+	struct driver *drv;
+	struct efi_netdev_plat *plat;
+	efi_handle_t handle;
+	struct efi_simple_network *net;
 	enum uclass_id id;
 	struct efi_net_obj *netobj;
 	int i, r;
@@ -1449,17 +1486,24 @@ int efi_net_register(void *ctx, struct event *event)
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
@@ -1476,7 +1520,9 @@ int efi_net_register(void *ctx, struct event *event)
 int efi_net_unregister(void *ctx, struct event *event)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	int r;
 	struct udevice *dev;
+	struct driver *drv;
 	enum uclass_id id;
 	struct efi_net_obj *netobj;
 	struct efi_handler *phandler;
@@ -1501,18 +1547,22 @@ int efi_net_unregister(void *ctx, struct event *event)
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
@@ -1524,22 +1574,43 @@ int efi_net_unregister(void *ctx, struct event *event)
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
@@ -1891,7 +1962,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 	// Set corresponding udevice
 	dev = NULL;
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && &net_objs[i]->http_service_binding == parent)
+		if (net_objs[i] && net_objs[i]->http_service_binding == parent)
 			dev = net_objs[i]->dev;
 	}
 	if (!dev)
-- 
2.48.1

