Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE88C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F066881B5C;
	Tue, 11 Mar 2025 17:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XdPBj1xH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0668B81A10; Tue, 11 Mar 2025 17:48:22 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5824817D3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22435603572so66345885ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711698; x=1742316498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEgSG/qaMqtDTo3lcKlSnZJCLiavug+Wq7hmbpylfbg=;
 b=XdPBj1xHFRZB1T6Xjwgigezv4X2Eqcf+c139WxFU2WJVSEh4JlN3gdK4yocELP1B/F
 +oyg+bZoJhb9KfAaB4yzjuaXXc/Ix0nMyRGIFXv9DFjAhcVGfOlIoGOrF1gse5/SXpCw
 BUF/xym/xYbDjtAbjqNwri/OtbQQUh/+/EPfnHcx12s5gscyr4CHGzC/61vSD8t8iJ+M
 iTDz5K28gvt4LymrREFNDRJziOOM8p2NYHQo5mSSqiDL4ZoyQsjHnmCxgKuO0TMzkDzB
 G0g49OfyMYtl4I5pvWjZtQtQwCzAWG2ZhgpBOnhI7nrEu5vhrndR+t7DjE8mDv17lyr1
 sL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711698; x=1742316498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEgSG/qaMqtDTo3lcKlSnZJCLiavug+Wq7hmbpylfbg=;
 b=J+GH+1rvhw0Nx5Xy1tL5f5MBAzfxevDWkJsSJsFmAZZ+e8S1uFJ07qmtbEVgAwWER6
 rtBCI5MQjvf3ZfpCJE7dRuU56mA2oJPLz3VxxGXaRnUBUv5iEaYFknvTiaf/rCpf2vew
 wi1H0O9XPI25c975GjsgTH89mnUPvSUI9bBrzNjr5ggYVLDf0685D8hpHVAjXikOohGT
 s3wIOK/jTPx/go5AdfGh5P/b+PJkusYlFYjwC06AKybvP+WdtgGI38fndzD24t/IbWX+
 wq1HvJdz1EIc610VXzQL+nNOTEv0vEWUQqxWdaLLCTYdFJK9ML6VJ4HZPAnX60ng6iTu
 kAMg==
X-Gm-Message-State: AOJu0YxmZuLjRvsPg6QN8d9We8nwEsCRSig6myAUrab71H6lSdpdEJhy
 AIIKDWAbr9TPY7s59xgACoIuh57YuxQ5djstBKMLzD845rX56wNFyE56ANeAfI8=
X-Gm-Gg: ASbGncsQ4ooR6YcxFhVh6+kNxtPgZGusjebJQliq5vkYrSyuF1aIp47smKHIxLW91jW
 1GzCirPKCRGb/u2eZhjkOCvIys1PxukUviRgqCKKjDZ5iDCg6RAZMaS1BRpdU+JCxpqjynH5E1F
 g5h3lsXS0lw3wJseWXLbSrFOIRAjw6syUvdh04qwPcJEdrx44IfGwTf512cI6pxycW9tUqcVC7V
 S0NrnxcNqqk9AaGSJBrYYq3YgDRsZgl2tA8wKD0zxlD/F0P6f8GU24JbnXEo4fGJ9dc74ajETir
 SUjGGWBXs6QHmfDC0PQKU3p1FinpYMOBXQdhgC3itLlPK8BIxfNvatw=
X-Google-Smtp-Source: AGHT+IHI+4jgtds+A+Eap/jLY6PmkJxVRj+h9ZhkFdo+sotS78vmRusTzsYehqJBiCWqfF5B6xjJUw==
X-Received: by 2002:a17:903:22c1:b0:223:5525:6239 with SMTP id
 d9443c01a7336-22428c075d8mr311809805ad.38.1741711698141; 
 Tue, 11 Mar 2025 09:48:18 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:17 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 12/16] efi_loader: efi_net: add snp_owner field to efi_net_obj
 struct
Date: Tue, 11 Mar 2025 13:47:54 -0300
Message-ID: <20250311164758.421900-13-adriano.cordova@canonical.com>
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

Two efi_net_obj's could share the same efi_simple_network_protocol interface.
For example, say a working U-Boot net device is registered in the EFI
subsystem, this will create an instance of an efi simple network protocol.
Then another handle, say handle A, could be created using this same efi simple
network protocol interface, and connect controller could be called. A U-Boot
udevice would be created for handle A and it would be registered in the EFI
subsystem as an efi_net_obj with the same simple network protocol interface as
the efi_net_obj we started with.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 51 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 5a00e7a570c..3ad51d343da 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -110,6 +110,7 @@ struct efi_net_obj {
 	struct efi_event *wait_for_packet;
 	struct efi_event *network_timer_event;
 	int efi_seq_num;
+	bool snp_owner;
 };
 
 static int curr_efi_net_obj;
@@ -134,15 +135,17 @@ static bool efi_netobj_is_active(struct efi_net_obj *netobj)
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
-			// Do not register duplicate devices
+		if (net_objs[i] && net_objs[i]->net == snp &&
+		    (!snp_owner || net_objs[i]->snp_owner)) {
 			return net_objs[i];
 		}
 	}
@@ -171,7 +174,7 @@ static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	if (this->mode->state != EFI_NETWORK_STOPPED) {
 		ret = EFI_ALREADY_STARTED;
@@ -207,7 +210,7 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	if (this->mode->state == EFI_NETWORK_STOPPED) {
 		ret = EFI_NOT_STARTED;
@@ -250,7 +253,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		r = EFI_INVALID_PARAMETER;
 		goto out;
 	}
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -347,7 +350,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -553,7 +556,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
@@ -614,7 +617,7 @@ static efi_status_t EFIAPI efi_net_transmit
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	/* We do not support jumbo packets */
 	if (buffer_size > PKTSIZE_ALIGN) {
@@ -712,7 +715,7 @@ static efi_status_t EFIAPI efi_net_receive
 		goto out;
 	}
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
@@ -870,7 +873,7 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 	if (!this || this->mode->state != EFI_NETWORK_INITIALIZED)
 		goto out;
 
-	nt = efi_netobj_from_snp(this);
+	nt = efi_netobj_from_snp(this, true);
 	curr_efi_net_obj = nt->efi_seq_num;
 
 	// The following only happens if the net obj was removed but the event
@@ -1205,7 +1208,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 
 	dev = netobj->dev;
 
-	if (efi_netobj_is_active(netobj))
+	if (efi_netobj_is_active(netobj) || !netobj->snp_owner)
 		goto set_timers;
 
 	if (!netobj->net_mode)
@@ -1417,6 +1420,7 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 			free(netobj->net->mode);
 		free(netobj->net);
 	}
+	netobj->net = NULL;
 
 	if (handle) {
 		netobj->handle = handle;
@@ -1429,6 +1433,8 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
 		}
 	}
 
+	netobj->snp_owner = efi_netobj_from_snp(net, true) ? false : true;
+
 	if (net) {
 		netobj->net = net;
 		netobj->net_mode = net->mode;
@@ -1556,14 +1562,9 @@ int efi_net_unregister(void *ctx, struct event *event)
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
 
@@ -1581,6 +1582,15 @@ int efi_net_unregister(void *ctx, struct event *event)
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
@@ -1603,8 +1613,11 @@ int efi_net_unregister(void *ctx, struct event *event)
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
2.48.1

