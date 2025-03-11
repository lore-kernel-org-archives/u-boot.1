Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F89C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11586811C1;
	Tue, 11 Mar 2025 17:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkhRNHgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13086807D7; Tue, 11 Mar 2025 17:48:04 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DE88186D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223959039f4so116188015ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711680; x=1742316480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wkp0pzEDurO8to91gY7qnkSZ8E3qh/pS+aVKwFgvdQ=;
 b=jkhRNHgh5RSZbZIIbqV9DMqHP8GJOLxiKCev0bAdncF2wlaOJvmEDYprGCUZGAsl7A
 okEelIJdRa9BIw0SEHDnHFt3bpum2yf3LUQEHv7d6wwd9dIPeMhKPBdRSZ01hpshhDnX
 77tZJFYVxBTh6KuTHv6Cqe9/1nIjeiv7UKBLy0Coe6Pd4bvZPQVlE+rMQKfftYA+MBpV
 rYkSew67uVwH7b8+k2pB95opHgZHL92RM3aPOmqbHA3V2DNItd0HU9n4G5Ix6rvhT+Dv
 3wsxty2MRTzuCuyOd7nGF+KLgJCRCg29nYUzmkxNvvEuGm9u8t75T+7oIkzjQFxv4XNP
 OdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711680; x=1742316480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wkp0pzEDurO8to91gY7qnkSZ8E3qh/pS+aVKwFgvdQ=;
 b=MIjkay4a3TGWN3ym0CTMJUmNjCBT2L1jd2KppRIMAK30b2hnk6rXOHBC8um7s2YySv
 NmwQQg82597Xrx7b4hNOIiHRjI87wSLyvmQ+WrMLf7jYhXSeBdevCb3Hl+rxoakV2CSU
 Bb5D+4/nn0T3NKmI90JFRYPWaodsFvnPkgbjHscvABSo676/kWu36CjFSyIPpGUrNcI4
 ymEo4AUbp2OoloU0ARMG2XB06DZlB5S3rp1f/wJZocVRhOyapeUE22a0PVgD4ZdgCC+j
 jgkxdjRWKj68nfFzEww+zU+5eq59onlknb8XL0JU0Rq9Xe625StgahPlKXFNwL4xbNNM
 wCjg==
X-Gm-Message-State: AOJu0Yy/pQKaRnJwLQcm0yorpQcnLKpJuqQ6FUh7LUnZyFWo0MvrFd7R
 tH+paiSRhIz5MbRCsC2X8mSjdpwFt7vb2C967cfFa5lGxLeZGqUh3Pm7YK9+DLQ=
X-Gm-Gg: ASbGncu9YohP/19u+2lc84W/C2GmdagBVrPv8gZfR03Ss6wLS9VBuRCs6Bmg5d3Ourh
 ixsvATGQtGjOjoJtd1mo4wGHSgkPxJR2hJ9kb3WhVShr70PVIfO5J+2s33yE7rmhu2BCsLRKdt1
 w0DOcrdVYLZu186xKT5NSL6YOU/h5cIXl01snhhAGv8O1jex2WIQzOe/fyLs0uUzl/1t4gH/rS2
 vwVgi6bWkRzZkTD7PHb2kYTG+pL+joiS2PSQTPk3obr+exrunbgItsPjJco4jNnjhabuYKOX5Ou
 XKiALWw52llBmsC/H1JNRdkyVKAH4MqK3hrN769+EARGep09zUo6ADs=
X-Google-Smtp-Source: AGHT+IFsc9YEVT+c0Dc6P/UOSTUtr9TFks+4unp4lFJBlAmWA0yciCFHtWYoUYZhkTpSzk7gjgXS7w==
X-Received: by 2002:a05:6a00:928b:b0:730:75b1:7219 with SMTP id
 d2e1a72fcca58-736aaa22109mr27151746b3a.12.1741711679906; 
 Tue, 11 Mar 2025 09:47:59 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:47:59 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 04/16] efi_loader: efi_net: Let efi_net_obj store pointers to
 efi_simple_network, efi_simple_network_mode, and the efi handle
Date: Tue, 11 Mar 2025 13:47:46 -0300
Message-ID: <20250311164758.421900-5-adriano.cordova@canonical.com>
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

This way the protocol and the handle can be externally provided. This comes
in preparation to support ConnectController.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 119 ++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index d84fa6c2bc6..a40d319a27f 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -67,7 +67,7 @@ static int next_dhcp_entry;
 /**
  * struct efi_net_obj - EFI object representing a network interface
  *
- * @header:			EFI object header
+ * @handle:			EFI object handle
  * @dev:			net udevice
  * @net:			simple network protocol interface
  * @net_mode:			status of the network interface
@@ -86,10 +86,10 @@ static int next_dhcp_entry;
  * @efi_seq_num:		sequence number of the EFI net object.
  */
 struct efi_net_obj {
-	struct efi_object header;
+	efi_handle_t handle;
 	struct udevice *dev;
-	struct efi_simple_network net;
-	struct efi_simple_network_mode net_mode;
+	struct efi_simple_network *net;
+	struct efi_simple_network_mode *net_mode;
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
@@ -120,7 +120,7 @@ static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
  */
 static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 {
-	if (!netobj || !efi_search_obj(&netobj->header))
+	if (!netobj || !efi_search_obj(netobj->handle))
 		return false;
 
 	return true;
@@ -138,7 +138,7 @@ static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
 	int i;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && &net_objs[i]->net == snp) {
+		if (net_objs[i] && net_objs[i]->net == snp) {
 			// Do not register duplicate devices
 			return net_objs[i];
 		}
@@ -1020,7 +1020,7 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		return EFI_OUT_OF_RESOURCES;
 
 	phandler = NULL;
-	ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	ret = efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
 	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 		return ret;
 
@@ -1029,14 +1029,14 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		goto add;
 
 	// If it is already installed, try to update it
-	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+	ret = efi_reinstall_protocol_interface(netobj->handle, &efi_guid_device_path,
 					       phandler->protocol_interface, new_net_dp);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
 	return EFI_SUCCESS;
 add:
-	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+	ret = efi_add_protocol(netobj->handle, &efi_guid_device_path,
 			       new_net_dp);
 	if (ret != EFI_SUCCESS)
 		return ret;
@@ -1059,7 +1059,7 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 		return NULL;
 
 	phandler = NULL;
-	r = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	r = efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
 	if (r != EFI_SUCCESS && r != EFI_NOT_FOUND)
 		return NULL;
 
@@ -1161,6 +1161,16 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 		return 0;
 	}
 
+	if (!netobj->net)
+		netobj->net = calloc(1, sizeof(*netobj->net));
+	if (!netobj->net)
+		goto out_of_resources;
+
+	if (!netobj->net_mode)
+		netobj->net_mode = calloc(1, sizeof(*netobj->net_mode));
+	if (!netobj->net_mode)
+		goto out_of_resources;
+
 	/* Allocate an aligned transmit buffer */
 	if (!netobj->transmit_buffer) {
 		transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
@@ -1193,41 +1203,44 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	}
 
 	/* Hook net up to the device list */
-	efi_add_handle(&netobj->header);
+	efi_add_handle(netobj->handle);
+	if (efi_link_dev(netobj->handle, dev))
+		goto out_of_resources;
 
 	/* Fill in object data */
-	r = efi_add_protocol(&netobj->header, &efi_net_guid,
-			     &netobj->net);
+	r = efi_add_protocol(netobj->handle, &efi_net_guid,
+			     netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
-	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
+	r = efi_add_protocol(netobj->handle, &efi_pxe_base_code_protocol_guid,
 			     &netobj->pxe);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-	netobj->net.revision = EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
-	netobj->net.start = efi_net_start;
-	netobj->net.stop = efi_net_stop;
-	netobj->net.initialize = efi_net_initialize;
-	netobj->net.reset = efi_net_reset;
-	netobj->net.shutdown = efi_net_shutdown;
-	netobj->net.receive_filters = efi_net_receive_filters;
-	netobj->net.station_address = efi_net_station_address;
-	netobj->net.statistics = efi_net_statistics;
-	netobj->net.mcastiptomac = efi_net_mcastiptomac;
-	netobj->net.nvdata = efi_net_nvdata;
-	netobj->net.get_status = efi_net_get_status;
-	netobj->net.transmit = efi_net_transmit;
-	netobj->net.receive = efi_net_receive;
-	netobj->net.mode = &netobj->net_mode;
-	netobj->net_mode.state = EFI_NETWORK_STOPPED;
+	netobj->net->revision = EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
+	netobj->net->start = efi_net_start;
+	netobj->net->stop = efi_net_stop;
+	netobj->net->initialize = efi_net_initialize;
+	netobj->net->reset = efi_net_reset;
+	netobj->net->shutdown = efi_net_shutdown;
+	netobj->net->receive_filters = efi_net_receive_filters;
+	netobj->net->station_address = efi_net_station_address;
+	netobj->net->statistics = efi_net_statistics;
+	netobj->net->mcastiptomac = efi_net_mcastiptomac;
+	netobj->net->nvdata = efi_net_nvdata;
+	netobj->net->get_status = efi_net_get_status;
+	netobj->net->transmit = efi_net_transmit;
+	netobj->net->receive = efi_net_receive;
+
+	netobj->net->mode = netobj->net_mode;
+	netobj->net_mode->state = EFI_NETWORK_STOPPED;
 	if (dev_get_plat(dev))
-		memcpy(netobj->net_mode.current_address.mac_addr,
+		memcpy(netobj->net_mode->current_address.mac_addr,
 		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
-	netobj->net_mode.hwaddr_size = ARP_HLEN;
-	netobj->net_mode.media_header_size = ETHER_HDR_SIZE;
-	netobj->net_mode.max_packet_size = PKTSIZE;
-	netobj->net_mode.if_type = ARP_ETHER;
+	netobj->net_mode->hwaddr_size = ARP_HLEN;
+	netobj->net_mode->media_header_size = ETHER_HDR_SIZE;
+	netobj->net_mode->max_packet_size = PKTSIZE;
+	netobj->net_mode->if_type = ARP_ETHER;
 
 	netobj->pxe.revision = EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
 	netobj->pxe.start = efi_pxe_base_code_start;
@@ -1267,7 +1280,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 		printf("ERROR: Failed to register network event\n");
 		return -1;
 	}
-	netobj->net.wait_for_packet = netobj->wait_for_packet;
+	netobj->net->wait_for_packet = netobj->wait_for_packet;
 	/*
 	 * Create a timer event.
 	 *
@@ -1277,7 +1290,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
 	 */
 	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
-			     efi_network_timer_notify, &netobj->net, NULL,
+			     efi_network_timer_notify, netobj->net, NULL,
 			     &netobj->network_timer_event);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
@@ -1291,13 +1304,13 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	}
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
-	r = efi_ipconfig_register(&netobj->header, &netobj->ip4_config2);
+	r = efi_ipconfig_register(netobj->handle, &netobj->ip4_config2);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
 
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
-	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
+	r = efi_http_register(netobj->handle, &netobj->http_service_binding);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
@@ -1394,6 +1407,12 @@ int efi_net_register(void *ctx, struct event *event)
 	if (!netobj)
 		goto out_of_resources;
 
+	netobj->handle = calloc(1, sizeof(*netobj->handle));
+	if (!netobj->handle) {
+		free(netobj);
+		goto out_of_resources;
+	}
+
 	netobj->dev = dev;
 	netobj->efi_seq_num = seq_num;
 	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
@@ -1442,9 +1461,6 @@ int efi_net_unregister(void *ctx, struct event *event)
 	if (!netobj)
 		return 0;
 
-	// Mark as free in the list
-	netobj->dev = NULL;
-
 	if (efi_netobj_is_active(netobj)) {
 		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
 		if (ret != EFI_SUCCESS)
@@ -1455,19 +1471,34 @@ int efi_net_unregister(void *ctx, struct event *event)
 			return -1;
 
 		phandler = NULL;
-		ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+		ret = efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
 		if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 			return -1;
 		if (phandler && phandler->protocol_interface)
 			interface = phandler->protocol_interface;
 
-		ret = efi_delete_handle(&netobj->header);
+		ret = efi_delete_handle(netobj->handle);
 		if (ret != EFI_SUCCESS)
 			return -1;
 
 		efi_free_pool(interface);
 	}
 
+	if (netobj->net) {
+		if (netobj->net->mode)
+			free(netobj->net->mode);
+		free(netobj->net);
+	}
+
+	if (netobj->net_mode)
+		free(netobj->net_mode);
+
+	// Mark as free in the list
+	netobj->handle = NULL;
+	netobj->dev = NULL;
+	netobj->net = NULL;
+	netobj->net_mode = NULL;
+
 	return 0;
 }
 
-- 
2.48.1

