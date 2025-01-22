Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9898AC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E007E80C5A;
	Wed, 22 Jan 2025 18:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msSa+FVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0343809A5; Wed, 22 Jan 2025 18:09:43 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D79D80C75
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21619108a6bso124536985ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565780; x=1738170580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oel+K5y6+ImtN7eEGT8PW9OLrB8SI6VdaJUXHar8dps=;
 b=msSa+FVRylSsiAaIQw6Be0sG0PUlBI/MJYvK+1Quns9JORNgSFhMnirf9AkxtfVofZ
 h36m971Q6DK0Q4EHE1E9vvwTPKaYyH54qqTB9FDLZNxNNuEflp1QdvbQoEQw7f9cxmN+
 vASOYPRWgmsecvp4kJXzVevCnccD2wzsFbhcv4025iSpGoF6gzeOfMhYJo4QHnHn9gyN
 L3jT/OJWG0V9vr3YN7rVPz2clxPrrMsxqXv5wJuJGiPE4rpzYFU09MixdNLGUTZb+w9a
 37C6pERAKfaQrZ4cx7xHRYWwFbuRXDVX/icsUD8CynGIkKRAZQcAM+Tr+PgF966XdrCh
 GDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565780; x=1738170580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oel+K5y6+ImtN7eEGT8PW9OLrB8SI6VdaJUXHar8dps=;
 b=NiG17pHTZFOQVwDKptTdd3kI7na6hNc+y177ZXkrZqR2+7IOyNy6ofAzJL0iV5D1R6
 Ckx5OVAA4iXRe1CiwwtnMmVQqia8Fw+rt3IM10B3/hHwSOUuuuCyFnCqHzAfWYLaFMCi
 tvAS9DQMAazIA3hrCmPZBefLGmKgLW7c8Ru87waW6jPzPpEZrupWIqNqR5dKmcBp8j+4
 GHmcFRR7A7GZwFFss90AqqPI0CTWZeR8GZQhRPDItMnHsfFtCXhWRE4A//xAzyexXeU5
 Kc5HdrTFBlq/GER/qjvR1mjhR3TcU7j87k40c49KNNr+uhwZt9k0+qr6rWbAWLa6k7vI
 bAsw==
X-Gm-Message-State: AOJu0YxKA2VVz+Qup/iUEXsyG+3nLe99SoaTMb4wwu8wHuGOkOpoZ+v0
 sUHtDpJp6Em5tuHwxkWj/XfXRA6WHFdptQjwt4ODQ12jugbAJI0pBzzlZXVd
X-Gm-Gg: ASbGncvX/vyP+KI/ZF1IlTO6v2DrnH6APVghq0GJvScjG7X9CCJse3qdARJLifVtTYl
 M/nLK2m32MhFeVUo560c3uzQUVF/rQw29Rif34w1hpsRtox7zB4FeM3LqQDy9Bp5POqH3eMqrmJ
 cgRhRKGUimgAt5NLu4o3/bKHhFr3W2BIcNGSdn+ZS8Ez4NBi5zOXFoq+IEzJTE7yiW+dEbH11Vr
 Jk1C2ZBZrlNr2nnS1KrxJBFnXG7O0OMU23khilVaNWAjPXGthFF5Y7S9C4j7B84wEXl9JKYqvwb
 Jg==
X-Google-Smtp-Source: AGHT+IFl0+vAsJDJrGDCtZsu9Rlf060hfsXOsvkipquRQkUnLZoPjw4QxwhLZQ2woLuj5MEFGRCQng==
X-Received: by 2002:a17:903:947:b0:216:5b64:90f6 with SMTP id
 d9443c01a7336-21c355fa2eamr310580425ad.45.1737565779672; 
 Wed, 22 Jan 2025 09:09:39 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 11/21] efi_loader: efi_net: Manage EFI net objects with
 efi_[dis]connect_controller
Date: Wed, 22 Jan 2025 14:08:48 -0300
Message-ID: <20250122170858.961359-12-adriano.cordova@canonical.com>
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

Call [dis]connect_controller for the efi_net_objs corresponding to U-Boot udevices

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h            |  2 +-
 lib/efi_driver/efi_net_device.c |  2 +-
 lib/efi_loader/efi_net.c        | 38 ++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 09a9f75e19..93f223389a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -638,7 +638,7 @@ efi_status_t efi_gop_register(void);
 int efi_net_register(void *ctx, struct event *event);
 /* Called to unregister an EFI network device */
 int efi_net_unregister(void *ctx, struct event *event);
-/* Called to initialized registered network devices */
+/* Called to initialized registered EFI network devices */
 efi_status_t efi_net_init(void);
 efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index 64a443d074..298eded265 100644
--- a/lib/efi_driver/efi_net_device.c
+++ b/lib/efi_driver/efi_net_device.c
@@ -26,7 +26,7 @@ static efi_status_t efi_net_bind_drv(
 {
 	EFI_PRINT("%s: handle %p, interface %p\n", __func__, handle, interface);
 
-	return EFI_UNSUPPORTED;
+	return EFI_SUCCESS;
 }
 
 /**
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 98b9c8b82e..b5284ffe34 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1117,7 +1117,7 @@ efi_status_t efi_net_do_start(void)
 	int i, r;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i]) {
+		if (net_objs[i] && net_objs[i]->dev) {
 			r = efi_netobj_start(net_objs[i]);
 			if (r)
 				return EFI_DEVICE_ERROR;
@@ -1142,19 +1142,10 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	size_t *receive_lengths;
 	int i, j;
 
-	if (!netobj || efi_netobj_is_active(netobj))
+	if (!netobj || !netobj->net || efi_netobj_is_active(netobj))
 		return 0;
 
 	dev = netobj->dev;
-	if (!dev) {
-		/* No network device active, don't expose any */
-		return 0;
-	}
-
-	if (!netobj->net)
-		netobj->net = calloc(1, sizeof(*netobj->net));
-	if (!netobj->net)
-		goto out_of_resources;
 
 	if (!netobj->net_mode)
 		netobj->net_mode = calloc(1, sizeof(*netobj->net_mode));
@@ -1199,7 +1190,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 
 	/* Fill in object data */
 	r = efi_add_protocol(netobj->handle, &efi_net_guid,
-			     netobj->net);
+			netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
@@ -1247,12 +1238,16 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
 	netobj->pxe.mode = &netobj->pxe_mode;
 
+	ret = EFI_CALL(efi_connect_controller(net_objs[i]->handle, NULL, NULL, 0));
+	if (ret != EFI_SUCCESS)
+		return -1;
+
 	/*
 	 * Scan dhcp entries for one corresponding
 	 * to this udevice, from newest to oldest
 	 */
 	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
-	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
+	for (j = 0; dev && dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
 	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
 		if (dev == dhcp_cache[i].dev) {
 			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
@@ -1304,7 +1299,6 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-	printf("efi_net init device number %d\n", netobj->efi_seq_num);
 	return 0;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1322,6 +1316,7 @@ out_of_resources:
 efi_status_t efi_net_init(void)
 {
 	int i, r;
+	efi_status_t ret;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
 		if (net_objs[i]) {
@@ -1429,7 +1424,8 @@ int efi_net_register(void *ctx, struct event *event)
 	struct udevice *dev;
 	enum uclass_id id;
 	struct efi_net_obj *netobj;
-	int i;
+	efi_status_t ret;
+	int i, r;
 
 	dev = event->data.dm.dev;
 	if (!dev) {
@@ -1453,6 +1449,14 @@ int efi_net_register(void *ctx, struct event *event)
 	if (!netobj)
 		return -1;
 
+	if (efi_obj_list_initialized == EFI_SUCCESS) {
+		if (!efi_netobj_is_active(netobj)) {
+			r = efi_netobj_init(netobj);
+			if (r)
+				return -1;
+		}
+	}
+
 	return 0;
 }
 
@@ -1496,6 +1500,10 @@ int efi_net_unregister(void *ctx, struct event *event)
 		return 0;
 
 	if (efi_netobj_is_active(netobj)) {
+		ret = EFI_CALL(efi_disconnect_controller(netobj->handle, NULL, NULL));
+		if (ret != EFI_SUCCESS)
+			return -1;
+
 		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
 		if (ret != EFI_SUCCESS)
 			return -1;
-- 
2.43.0

