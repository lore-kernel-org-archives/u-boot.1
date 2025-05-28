Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF11C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F32183A45;
	Wed, 28 May 2025 10:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cd4EBSk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5207B83A4B; Wed, 28 May 2025 10:37:24 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D65283A2D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so2714429f8f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421441; x=1749026241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmwUqPZ2kGkQoAtjYLi52CIXMZNvAuvXOIrGhkMRkGU=;
 b=cd4EBSk2N+3uyB54vg642Qbd7TlXMPAmFC+Hf4kqYgXuaq9nOcx2Hq2+Sbw26O/pqP
 LFajM8sfNAa0s8GErrT+SyOL+peoCdYhCrBWqZ0trt6mKx1J4y+pBtToDiaaBJWf/+A+
 HPnwKmryMhPSoTxK8VEXc4uSgk5RW+NpN/izUOYohrZT1fYY9b9VKtieedEx5R5cahYE
 gigNSy7p9TumYvNqU1KjJodXztnkjC4RBfy3tn6gcnX6GPdSqChqtjEZm3K49b6PyuDw
 1aoU4CHfUJQGWQG2j8BoWYzfWw5vbjzY1ZvOtgzXoddIrqUUPo9g9DwmOakUHHwnT+/m
 YlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421441; x=1749026241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmwUqPZ2kGkQoAtjYLi52CIXMZNvAuvXOIrGhkMRkGU=;
 b=SOZiA/nQfL9t4s5lJBlGU5xOV88CxYsMlngeJRXlnYrEwJMakZmGiAYpnWhWS2XzUn
 85GcJ/Ub73i3gZmpcAq+deTjzszbluejw51NR8fPMLlb0naXpFQkwAiGec6K+EoFn515
 L6eQ7GWwABq9PIc1zNOdoA+ImsrVzwknRIUr4YBkNASKV9Zd60/auk9C2uBnlbTOw6j/
 LkvoqcJQFMKsIaXPpyWpdXzC8p56iR2MvtZwu7r2Bfe3ya2PWabgpd7iUEAWd/55ZKCq
 Ji3KxWvwegxZ5fAUS0nVDrfPWA9ujlb8i4oYvLZLvJiVkz1rv0LN9qkca8exSUbQZxZM
 Bfbg==
X-Gm-Message-State: AOJu0Yx63Dx0IA9+Ztu2KfLfCw43T3sP6xgt1Iltc7A9WkMPz37kgTL+
 OziPieDGhzPtq54g9hQq2ut9x/6g/waI4mr4LPgyHQr+7uLXnpt7mGUIOFgkUpEQQsk=
X-Gm-Gg: ASbGncv/+sayg+e9wXxi4JWGvBteJ03CX6Fg41lLnPM7SwKvoY4EFbV6/W/LJgnReEg
 adWaHBD/cgoiu2VdYBX0Qfx2NXXlCGFbPdvU7Sq9AZAlO/8lfiNs0xQcvFKvrV7uO9dOOSWvsqQ
 x2Tbblgpio1drXGaoS1Qk/8EiMFynicaSqe8U/sgQlsPKmdNBp4RmFvL/7+gNYdJaMCS2lCiUFM
 o6AL8gFG8uDJIR6kd8c45F4k3oxHGq77GHtJawpIESM9cKqJcOj3brgqxpIjWJOGYMfK03AcYMv
 UV1i68MB9mynEFxs0KPbnsWfNRxZDtqi9dahoRfbEKcMBhEID1PGDEGvsluaulesK0fwvm8MGMa
 svF/UoL19bCBp1JSJb0LQkHIckec=
X-Google-Smtp-Source: AGHT+IFW8KJlWjMsUCQgmeFMT7YPnM/lLhU+KORg0FqV8x+bg/2my0LH8PuA2YyY+UAB4zSkXadq0g==
X-Received: by 2002:a05:6000:2509:b0:3a3:5a99:7e0c with SMTP id
 ffacd0b85a97d-3a4cb463896mr13414181f8f.25.1748421441336; 
 Wed, 28 May 2025 01:37:21 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:20 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 5/9] efi_loader/net: Remove efi_net_obj struct
Date: Wed, 28 May 2025 04:38:17 -0400
Message-ID: <20250528083821.567514-6-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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

As all the protocols moved out of efi_net.c, and EFI
net object is just an efi_object struct with network
protocols installed on it, so efi_net_obj is not
needed anymore.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h                    |  2 +-
 lib/efi_loader/net/efi_net.c            | 76 +++++++++----------------
 lib/efi_loader/net/efi_simple_network.c | 10 ++--
 3 files changed, 32 insertions(+), 56 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 394650f1f32..e78e82b4126 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -680,7 +680,7 @@ efi_status_t efi_gop_register(void);
 efi_status_t efi_net_register(struct udevice *dev);
 efi_status_t efi_net_do_start(struct udevice *dev);
 /* Called by efi_net_register to install EFI_SIMPLE_NETWORK_PROTOCOL */
-efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevice *dev);
+efi_status_t efi_simple_network_install(const efi_handle_t handle);
 /* Called by efi_net_register to install EFI_PXE_BASE_CODE_PROTOCOL */
 efi_status_t efi_pxe_install(const efi_handle_t handle, struct efi_pxe_packet *dhcp_ack);
 /* Called by efi_net_register to install EFI_IP4_CONFIG2_PROTOCOL */
diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
index 5ea9cdd0204..130d290ba7f 100644
--- a/lib/efi_loader/net/efi_net.c
+++ b/lib/efi_loader/net/efi_net.c
@@ -58,32 +58,7 @@ struct dhcp_entry {
 static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
 static int next_dhcp_entry;
 
-/**
- * struct efi_net_obj - EFI object representing a network interface
- *
- * @header:			EFI object header
- * @dev:			net udevice
- */
-struct efi_net_obj {
-	struct efi_object header;
-	struct udevice *dev;
-};
-
-static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
-
-/**
- * efi_netobj_is_active() - checks if a netobj is active in the efi subsystem
- *
- * @netobj:	pointer to efi_net_obj
- * Return:	true if active
- */
-static bool efi_netobj_is_active(struct efi_net_obj *netobj)
-{
-	if (!netobj || !efi_search_obj(&netobj->header))
-		return false;
-
-	return true;
-}
+static efi_handle_t net_objs[MAX_EFI_NET_OBJS];
 
 /**
  * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
@@ -125,7 +100,7 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
 		if (net_objs[i] && net_objs[i]->dev == dev) {
 			phandler = NULL;
-			r = efi_search_protocol(&net_objs[i]->header,
+			r = efi_search_protocol(net_objs[i],
 						&efi_pxe_base_code_protocol_guid,
 						&phandler);
 			if (r == EFI_SUCCESS && phandler) {
@@ -140,17 +115,17 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 /**
  * efi_netobj_set_dp() - set device path of a netobj
  *
- * @netobj:	pointer to efi_net_obj
+ * @netobj:	handle of an EFI net device
  * @dp:		device path to set, allocated by caller
  * Return:	status code
  */
-efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_path *dp)
+efi_status_t efi_netobj_set_dp(efi_handle_t netobj, struct efi_device_path *dp)
 {
 	efi_status_t ret;
 	struct efi_handler *phandler;
 	struct efi_device_path *new_net_dp;
 
-	if (!efi_netobj_is_active(netobj))
+	if (!efi_search_obj(netobj))
 		return EFI_SUCCESS;
 
 	// Create a device path for the netobj
@@ -159,21 +134,21 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		return EFI_OUT_OF_RESOURCES;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	efi_search_protocol(netobj, &efi_guid_device_path, &phandler);
 
 	// If the device path protocol is not yet installed, install it
 	if (!phandler)
 		goto add;
 
 	// If it is already installed, try to update it
-	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+	ret = efi_reinstall_protocol_interface(netobj, &efi_guid_device_path,
 					       phandler->protocol_interface, new_net_dp);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
 	return EFI_SUCCESS;
 add:
-	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+	ret = efi_add_protocol(netobj, &efi_guid_device_path,
 			       new_net_dp);
 	if (ret != EFI_SUCCESS)
 		return ret;
@@ -184,18 +159,18 @@ add:
 /**
  * efi_netobj_get_dp() - get device path of a netobj
  *
- * @netobj:	pointer to efi_net_obj
+ * @netobj:	handle to EFI net object
  * Return:	device path, NULL on error
  */
-static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
+static struct efi_device_path *efi_netobj_get_dp(efi_handle_t netobj)
 {
 	struct efi_handler *phandler;
 
-	if (!efi_netobj_is_active(netobj))
+	if (!efi_search_obj(netobj))
 		return NULL;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	efi_search_protocol(netobj, &efi_guid_device_path, &phandler);
 
 	if (phandler && phandler->protocol_interface)
 		return efi_dp_dup(phandler->protocol_interface);
@@ -214,7 +189,7 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 efi_status_t efi_net_do_start(struct udevice *dev)
 {
 	efi_status_t r = EFI_SUCCESS;
-	struct efi_net_obj *netobj;
+	efi_handle_t netobj;
 	struct efi_device_path *net_dp;
 #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 	struct efi_handler *phandler;
@@ -230,7 +205,7 @@ efi_status_t efi_net_do_start(struct udevice *dev)
 		}
 	}
 
-	if (!efi_netobj_is_active(netobj))
+	if (!efi_search_obj(netobj))
 		return r;
 
 	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
@@ -258,7 +233,7 @@ set_addr:
 	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
 	 */
 	pxe = NULL;
-	r = efi_search_protocol(&netobj->header,
+	r = efi_search_protocol(netobj,
 				&efi_pxe_base_code_protocol_guid,
 				&phandler);
 	if (r == EFI_SUCCESS && phandler) {
@@ -281,7 +256,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 {
 	efi_status_t r;
 	int seq_num;
-	struct efi_net_obj *netobj;
+	efi_handle_t netobj;
 	struct efi_pxe_packet *dhcp_ack;
 	int i, j;
 
@@ -314,13 +289,14 @@ efi_status_t efi_net_register(struct udevice *dev)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
-	netobj->dev = dev;
-
 	/* Hook net up to the device list */
-	efi_add_handle(&netobj->header);
+	efi_add_handle(netobj);
+
+	if (efi_link_dev(netobj, dev) < 0)
+		return EFI_DEVICE_ERROR;
 
 	/* Install EFI_SIMPLE_NETWORK_PROTOCOL */
-	r = efi_simple_network_install(&netobj->header, dev);
+	r = efi_simple_network_install(netobj);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
@@ -339,19 +315,19 @@ efi_status_t efi_net_register(struct udevice *dev)
 	}
 
 	/* Install EFI_PXE_BASE_CODE_PROTOCOL */
-	r = efi_pxe_install(&netobj->header, dhcp_ack);
+	r = efi_pxe_install(netobj, dhcp_ack);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
 	/* Install EFI_IP4_CONFIG2_PROTOCOL */
-	r = efi_ip4_config2_install(&netobj->header);
+	r = efi_ip4_config2_install(netobj);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
 	/* Install EFI_HTTP_PROTOCOL */
-	r = efi_http_install(&netobj->header);
+	r = efi_http_install(netobj);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
@@ -377,7 +353,7 @@ failure_to_add_protocol:
 efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev)
 {
 	efi_status_t ret;
-	struct efi_net_obj *netobj;
+	efi_handle_t netobj;
 	struct efi_device_path *old_net_dp, *new_net_dp;
 	struct efi_device_path **dp;
 	int i;
@@ -709,7 +685,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		if (!net_objs[i])
 			continue;
 
-		ret = efi_search_protocol(&net_objs[i]->header,
+		ret = efi_search_protocol(net_objs[i],
 					  &efi_http_service_binding_guid,
 					  &phandler);
 		if (ret == EFI_SUCCESS && phandler &&
diff --git a/lib/efi_loader/net/efi_simple_network.c b/lib/efi_loader/net/efi_simple_network.c
index 085b974b928..1a272b1abca 100644
--- a/lib/efi_loader/net/efi_simple_network.c
+++ b/lib/efi_loader/net/efi_simple_network.c
@@ -758,7 +758,7 @@ out:
  * @handle:	handle to install the protocol
  * @dev:	net udevice
  */
-efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevice *dev)
+efi_status_t efi_simple_network_install(const efi_handle_t handle)
 {
 	efi_status_t r;
 	struct efi_simple_network_extended_protocol *simple_network;
@@ -767,7 +767,7 @@ efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevic
 	size_t *receive_lengths;
 	int i;
 
-	if (!dev) {
+	if (!handle || !handle->dev) {
 		/* No network device active, don't expose any */
 		return EFI_SUCCESS;
 	}
@@ -777,7 +777,7 @@ efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevic
 	if (!simple_network)
 		goto out_of_resources;
 
-	simple_network->dev = dev;
+	simple_network->dev = handle->dev;
 
 	/* Allocate an aligned transmit buffer */
 	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
@@ -820,9 +820,9 @@ efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevic
 	simple_network->net.receive = efi_net_receive;
 	simple_network->net.mode = &simple_network->net_mode;
 	simple_network->net_mode.state = EFI_NETWORK_STOPPED;
-	if (dev_get_plat(dev))
+	if (dev_get_plat(handle->dev))
 		memcpy(simple_network->net_mode.current_address.mac_addr,
-		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
+		       ((struct eth_pdata *)dev_get_plat(handle->dev))->enetaddr, 6);
 	simple_network->net_mode.hwaddr_size = ARP_HLEN;
 	simple_network->net_mode.media_header_size = ETHER_HDR_SIZE;
 	simple_network->net_mode.max_packet_size = PKTSIZE;
-- 
2.48.1

