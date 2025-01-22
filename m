Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A226BC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ED980BA8;
	Wed, 22 Jan 2025 18:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WrRXjGcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E5080BA8; Wed, 22 Jan 2025 18:09:38 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC6F80977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso118215725ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565774; x=1738170574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMOOuOs+vsqJux3Vd6zqwpV6R+LkU9Bgd6Brs7owSbY=;
 b=WrRXjGcPpwgXezLI5bh5nsP/eWvrYDbUMDUeDsm9vg9KxBPI2/MOJY0gc+omeLCSam
 PVZjPsBuwZn5RM62hN6WWzusUGC4UBu3HKdg2El4X9cgbPpO8mJehsCWiO2fAWCr+j6z
 Bp3dMJQgoza6jgr/5T3LO9r8qTRmgJEnfUAU/EwLrA0zka0ru4x6FtAUJNqIWKfnjMvE
 qLPC4KklMoxT0489y0Yv2BtTJRN72dp1/G2BM4ylx13Qg4BiTi1t38xAs8OZE4/0xrFe
 OtZuzhYwj6p4IoZun5W2raaWJHjWLmPdfte3k49Nc9wS4S8pJU3u0yKoLztYxN4t3XwU
 DGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565774; x=1738170574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMOOuOs+vsqJux3Vd6zqwpV6R+LkU9Bgd6Brs7owSbY=;
 b=n0P1bIct2/yz3mUweabzIgL/5STP0bjgJsK09uc8ojae/0hFIFcf9EOwSOv07H+Kg7
 UJ+xVCCrC21O08Erg2iG9tAO9TpXJOInbaVLeKxJ9KT6Q+1GoWcT85AjIAopcwkZ53nZ
 6a75rxpjOthMMtyTuyNSsnJ3/NSZjcrTSA+zyfuBAVcr13AH7lBuuqSxgCQ4R1W2sB/Y
 v1jC0FtuUGBwHEm9mFZVG7hvP23rBucrX7UsaaH+zXtQgRt0OwtHioKohgIgEmZ22YzX
 yPREiCIYCPu9tX0pNnGHmVuomFdspzZxEEA6d/UKXRJWG1dLtnc1E6bxcd0wU2kw/wmR
 iSUQ==
X-Gm-Message-State: AOJu0YwnFDvVb/bng11SeS+XsC1QI3KGWo/HH9zzjyWw4Uoao/ukX294
 KuYAGB9DtHNFfUtboARkySAE3AVOHYQPmvWn/13bG31qqiJfYRNdWjUx11tA
X-Gm-Gg: ASbGncvN3x8LIB0SlqL2MzixKgqXWdzLnl85KTMA6/RbAW0qd0sQUmuTdR62xtt8fWY
 fLHvOtX5BbWv8oLWdycncfVrOpW0rryq1hwB9kFmLYwDdz7lrgrw59YliWk7PKxZ8xML384AKG9
 IVcnwUgnc7dNoSvs8J6sDNRDqKvVnb+irBdSKRb0YvFx4ptWyNK1bSaOx822i5qxcDLDEJCLx9D
 24f5IHT1NK6JQj2QX/nVNZmFVZGCKw0Q4+Jky44KwdOraRAg7iXW+EXcP1HprayOYWA0xoLlWrn
 hw==
X-Google-Smtp-Source: AGHT+IG6QBPy0+0Y7rI9ekC3G9lBUeRfvN20O6iy8muXbW8dDh6+DedDozkkupv4z+aDVf3KzQATvQ==
X-Received: by 2002:a17:902:c94a:b0:216:2abc:195c with SMTP id
 d9443c01a7336-21c352dd6ffmr305650115ad.7.1737565774566; 
 Wed, 22 Jan 2025 09:09:34 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:34 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 09/21] efi_loader: efi_net: Let efi_net_obj store pointers to
 efi_simple_network, efi_simple_network_mode, and the efi handle
Date: Wed, 22 Jan 2025 14:08:46 -0300
Message-ID: <20250122170858.961359-10-adriano.cordova@canonical.com>
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

This way the protocol and the handle can be externally provided. This comes
in preparation to support ConnectController.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 117 +++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 43 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 6bae5a5cd7..3e39cdf212 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -63,7 +63,7 @@ static int next_dp_entry;
 /**
  * struct efi_net_obj - EFI object representing a network interface
  *
- * @header:			EFI object header
+ * @handle:			EFI object handle
  * @dev:			net udevice
  * @net:			simple network protocol interface
  * @net_mode:			status of the network interface
@@ -73,10 +73,10 @@ static int next_dp_entry;
  * @http_service_binding:	Http service binding protocol interface
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
@@ -114,7 +114,7 @@ static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
  */
 static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 {
-	if (!netobj || !efi_search_obj(&netobj->header))
+	if (!netobj || !efi_search_obj(netobj->handle))
 		return false;
 
 	return true;
@@ -132,7 +132,7 @@ static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
 	int i;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && &net_objs[i]->net == snp) {
+		if (net_objs[i] && net_objs[i]->net == snp) {
 			// Do not register duplicate devices
 			return net_objs[i];
 		}
@@ -1014,21 +1014,21 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		return EFI_OUT_OF_RESOURCES;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
 
 	// If the device path protocol is not yet installed, install it
 	if (!phandler)
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
@@ -1050,7 +1050,7 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 		return NULL;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
 
 	if (phandler && phandler->protocol_interface)
 		return efi_dp_dup(phandler->protocol_interface);
@@ -1151,6 +1151,16 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
@@ -1183,41 +1193,44 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
 	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
 	 */
 	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
-			     efi_network_timer_notify, &netobj->net, NULL,
+			     efi_network_timer_notify, netobj->net, NULL,
 			     &netobj->network_timer_event);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
@@ -1281,13 +1294,13 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
@@ -1384,6 +1397,12 @@ int efi_net_register(void *ctx, struct event *event)
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
@@ -1432,9 +1451,6 @@ int efi_net_unregister(void *ctx, struct event *event)
 	if (!netobj)
 		return 0;
 
-	// Mark as free in the list
-	netobj->dev = NULL;
-
 	if (efi_netobj_is_active(netobj)) {
 		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
 		if (ret != EFI_SUCCESS)
@@ -1445,17 +1461,32 @@ int efi_net_unregister(void *ctx, struct event *event)
 			return -1;
 
 		phandler = NULL;
-		efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+		efi_search_protocol(netobj->handle, &efi_guid_device_path, &phandler);
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
2.43.0

