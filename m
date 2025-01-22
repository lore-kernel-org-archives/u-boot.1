Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5829CC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A1780CB0;
	Wed, 22 Jan 2025 18:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gf3yXe83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE0A80C98; Wed, 22 Jan 2025 18:09:59 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B687E80977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216401de828so124791205ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565795; x=1738170595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWTkO66/h/JWdXGA5EpsOoMIvWsmqfHtoojozWlb6XM=;
 b=gf3yXe83tDVp+8XyAo7w8bh5XKrU3h6b73YqOSmJxfQsVSnxNZYvxl7AjR/Sse+XAz
 bL8VA/2eUf7h7ktJhVZDvMOkk9DeGnHaL2sucvBJL0HOe/aoXQC7XmKKxUIqEX9hKG0K
 Sp50c5C/9VPYnCvhAmJkoCKICgikyKjDlSguIr07qfw8BzMcCybYl5i3c9oDYIaaGPkl
 SjB18uxYX91W4VRB1wyOxsXUSoJgMiuqGCAtt/xsUD/h6PrFcmEOqOTDW0wLSIHUGSne
 mbNAgEAsX8KI0howuyqmM/TjM7oIBJi3iyXcEPmAVpzY0dh2BiGBhCN8DQ5LpNFJ03nu
 AoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565795; x=1738170595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWTkO66/h/JWdXGA5EpsOoMIvWsmqfHtoojozWlb6XM=;
 b=Yj8DtNxhUf5lfZ63eYcH9xibX8VJkbOnoSLqObV6EKzszC6aO5Ym5PwclP9YdDwtMg
 gl6iOcHilsnqXRGpW9vJGj4XEaITdlPznilqwCEhzD3+Vf14gY7qk3GMQ3xAauLXB7Cm
 BhQMCnjl3bfA7cjxU6c7LfhZ0yW2ULgwSqVS3zEilFZQFN+Losq3Zh9lTpNZBp0o48mF
 YeQlpttVTZ4bj3QesqTohaMKYeScmoEJld7ZKYQ1QcDlYtGTaOMiogd8TE2SnlJ7ECS3
 zo6XbnIUfGGmfCOWs78aPsBEErh64uImTaxAkm9caxVv7uEKbGkcj+RAiKFQ6CKtpmSz
 ZP/A==
X-Gm-Message-State: AOJu0YzTuV7vE0GaeKy2gO1AoT0aCF97bOCsH6GKBPy4L4kmr83Z+5NG
 vmUk7EiF486WzIK+8EDrRpAatbbO4eXU/ajdGZN/I7AIpKxQBzs0r8Zh6+dj
X-Gm-Gg: ASbGncvFVMiAO9gI/ukm12Tt33QvsrdNZL5SKp98NyCrB+1kCAAqdMpUQyAku0PPCat
 wqV0z5Oy/ESf6rgK9Syh6PGzavn0PWNuAm1Iep7homXQU462tj/3IFFqu3L+XP6ucs7FgjP+yx7
 gDNVkqtGWR7W8kyWusd8ERA7ccArSWscLD/7lVceLPeLaGiAHTmoq8gI89XMhoqp4lF1rRLs5es
 j+4iG+eyppAHN8BKAd9URkd2NNX/PyFzuBXs3OjI+UNvPZlU2tXOv6AYB84QzxfqFg72ANcLtj+
 rw==
X-Google-Smtp-Source: AGHT+IFI5cm9laupTRJdGlArlolSS0xAUwyF0nUSIVotUUkMVECHzdbPAhU/V2iHBla0zMzoKmmPhw==
X-Received: by 2002:a17:902:d542:b0:215:e685:fa25 with SMTP id
 d9443c01a7336-21c3540d130mr301154265ad.20.1737565795239; 
 Wed, 22 Jan 2025 09:09:55 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:54 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 17/21] efi_loader: efi_net: add snp_owner field to efi_net_obj
 struct
Date: Wed, 22 Jan 2025 14:08:54 -0300
Message-ID: <20250122170858.961359-18-adriano.cordova@canonical.com>
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

Let a simple network protocol interface be shared by more than one efi
net device, but with only one owner. The owner should be the efi net device
whose underlying udevice does not use the snp protocol for its ethernet ops.
See efi_selftest_net_driver for an use.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index c172da4e66..2f981b043a 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -104,6 +104,7 @@ struct efi_net_obj {
 	 */
 	struct efi_event *network_timer_event;
 	int efi_seq_num;
+	bool snp_owner;
 };
 
 static int curr_efi_net_obj;
@@ -128,14 +129,17 @@ static bool efi_netobj_is_active(struct efi_net_obj *netobj)
  *
  *
  * @snp:	pointer to the simple network protocol
+ * @bool:	snp owner
  * Return:	pointer to efi_net_obj, NULL on error
  */
-static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
+static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp,
+					       bool snp_owner)
 {
 	int i;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->net == snp) {
+		if (net_objs[i] && net_objs[i]->net == snp &&
+		    (!snp_owner || net_objs[i]->snp_owner)) {
 			// Do not register duplicate devices
 			return net_objs[i];
 		}
@@ -165,7 +169,7 @@ static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	if (this->mode->state != EFI_NETWORK_STOPPED) {
 		ret = EFI_ALREADY_STARTED;
@@ -201,7 +205,7 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	if (this->mode->state == EFI_NETWORK_STOPPED) {
 		ret = EFI_NOT_STARTED;
@@ -244,7 +248,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		r = EFI_INVALID_PARAMETER;
 		goto out;
 	}
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -341,7 +345,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -547,7 +551,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
@@ -608,7 +612,7 @@ static efi_status_t EFIAPI efi_net_transmit
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	/* We do not support jumbo packets */
 	if (buffer_size > PKTSIZE_ALIGN) {
@@ -706,7 +710,7 @@ static efi_status_t EFIAPI efi_net_receive
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
@@ -864,7 +868,7 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 	if (!this || this->mode->state != EFI_NETWORK_INITIALIZED)
 		goto out;
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 	curr_efi_net_obj = nt->efi_seq_num;
 
 	// The following only happens if the net obj was removed but the event
@@ -1194,7 +1198,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 
 	dev = netobj->dev;
 
-	if (efi_netobj_is_active(netobj))
+	if (efi_netobj_is_active(netobj) || !netobj->snp_owner)
 		goto set_timers;
 
 	if (!netobj->net_mode)
@@ -1408,6 +1412,7 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 			free(netobj->net->mode);
 		free(netobj->net);
 	}
+	netobj->net = NULL;
 
 	if (handle) {
 		netobj->handle = handle;
@@ -1419,6 +1424,8 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 		}
 	}
 
+	netobj->snp_owner = efi_netobj_from_snp(net, true) ? false : true;
+
 	if (net) {
 		netobj->net = net;
 		netobj->net_mode = net->mode;
@@ -1546,14 +1553,9 @@ int efi_net_unregister(void *ctx, struct event *event)
 		return -1;
 	}
 
+	interface = NULL;
 	if (drv != dev->driver) {
 		ret = EFI_CALL(efi_disconnect_controller(netobj->handle, NULL, NULL));
-		if (ret != EFI_SUCCESS)
-			return -1;
-		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
-		if (ret != EFI_SUCCESS)
-			return -1;
-		ret = EFI_CALL(efi_close_event(netobj->network_timer_event));
 		if (ret != EFI_SUCCESS)
 			return -1;
 
@@ -1569,6 +1571,15 @@ int efi_net_unregister(void *ctx, struct event *event)
 		}
 	}
 
+	if (netobj->snp_owner) {
+		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
+		if (ret != EFI_SUCCESS)
+			return -1;
+		ret = EFI_CALL(efi_close_event(netobj->network_timer_event));
+		if (ret != EFI_SUCCESS)
+			return -1;
+	}
+
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
 	if (netobj->ip4_config2) {
 		r = efi_ipconfig_unregister(netobj->handle, netobj->ip4_config2);
@@ -1591,8 +1602,11 @@ int efi_net_unregister(void *ctx, struct event *event)
 		ret = efi_delete_handle(netobj->handle);
 		if (ret != EFI_SUCCESS)
 			return -1;
+	}
+
+	efi_free_pool(interface);
 
-		efi_free_pool(interface);
+	if (netobj->snp_owner) {
 		if (netobj->net)
 			free(netobj->net);
 		if (netobj->net_mode)
-- 
2.43.0

