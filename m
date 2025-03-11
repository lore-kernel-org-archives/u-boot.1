Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB60DC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36BB68193A;
	Tue, 11 Mar 2025 17:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9LK0hq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B908192A; Tue, 11 Mar 2025 17:48:08 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C185E81761
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224171d6826so14280715ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711684; x=1742316484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBL2MIaVc3c9AjzDbmwM78KVe49rmjmiYb1Vk5/hdhY=;
 b=H9LK0hq/jRyw9xVQULOIvIqxcS0njmlX0i5x9aAT2qa3gx8N+bL7fPxS428/fO4Pw+
 Sg01ik7eZsmAHpg4bX+J/a8gOGVlCOzqg4NRKRTMj8r5mH3DpITNz4+RBU+/UB1C4vhw
 R45xO6CBHF0a2E71QoTy6lSUjCspsFJYOqBQkOVREQlCKBQTA1VdWf8QlevtEshORlR9
 IX9XMRGhSmoQst7GOkk8+HPAhYzxDcxfY0azU+0NsfS/V9qKrv6kD5hWtYHIBT8lBMFi
 47HmY+75PewmnbNbbtJqy3CK7X8QpRWoRDGAz7wbxcLkCWt3iTDenP72ekRFjaoB34c1
 DlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711684; x=1742316484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBL2MIaVc3c9AjzDbmwM78KVe49rmjmiYb1Vk5/hdhY=;
 b=EhVOucaH6zfKeHSU/jVycVYQy5V0d/mhDAjFXGqkAnseetOK6EHZlWdFIoUZUx3vhJ
 JU1WwT/v1qgYd13HHJlw9W4DKzTPK65jUQjcKjCn15ZHLLjFuQJ+lNSbZTTL8INOWwld
 TETXimC0TFnPjq8+GW8WlB6Z8j1v7aL5HjJXRMQnEijlcdXLklmIP91KvefAwq3le8QG
 bzj7acdq6984vmu6XaOlS/yDmNVxx6twUXbCtVm5HuiR7Qfg85r480RWYQc9jzJQ4RL0
 MJyL+uP3OuQc7nr7ivFNZDFqhijaGTAmznIb/BbSN+7byTgDJarb9qtYRtZTHuByiw4i
 VKJw==
X-Gm-Message-State: AOJu0Yw0Sp9AEXnQAoP5CtgVXROZ9xYthtSVpFtQ7AKAEwh2d0ukRdr7
 xDNhSItKYAHcjE1OOpacS8IfjAXd/wRUDR4piRwJKJGfvw2WuENYAw2NP2cszcw=
X-Gm-Gg: ASbGncs67srSkIoeMg4W6b/5/r116gAcSQzcUute3sOB8k8MQ+eK7lTsmjWv4EXkkNi
 79X6o3BEh/SCBMSy6aoha/HJFCtAqT50BTqgRhlcq3rmX55dvrwKO9t1gJx4WDgTh9Xeh5x0hV1
 y1N/j7Yn8GCnCLGDg+LkMBWiCK7+VlSWLUIRnfNmUYcJry043LKpDobJCxmqRUFa2JU2hFoeeSN
 9aak66wtekkPUdK78vnVGgJ79jJIOK4KuY1EFp/kJZCczi+OGh7s1tzYrqeFjc6qiBGW6ldL2Bb
 PkewsI9lmAmbKmBjyfDo6Artwxjysn5jznK0n9WrntBKja2+6GJnCPg=
X-Google-Smtp-Source: AGHT+IGPAWu3pXhJ1+Ixjy1RLsdpQewkOQNLLbXDPGqYeD1PrSgSHyl1zfytT5fmFCMqHp4oiDCnAg==
X-Received: by 2002:a05:6a21:3947:b0:1f5:5b2a:f629 with SMTP id
 adf61e73a8af0-1f55b2b00e8mr22308187637.30.1741711684300; 
 Tue, 11 Mar 2025 09:48:04 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:04 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 06/16] efi_loader: efi_net: Manage EFI net objects with
 efi_[dis]connect_controller
Date: Tue, 11 Mar 2025 13:47:48 -0300
Message-ID: <20250311164758.421900-7-adriano.cordova@canonical.com>
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

For U-Boot devices connect_controller gets called in efi_netobj_init

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h            |  2 +-
 lib/efi_driver/efi_net_device.c |  4 +---
 lib/efi_loader/efi_net.c        | 30 ++++++++++++++++++++++++------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9c5ddc12cea..38ea0c5c672 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -660,7 +660,7 @@ efi_status_t efi_gop_register(void);
 int efi_net_register(void *ctx, struct event *event);
 /* Called to unregister an EFI network device */
 int efi_net_unregister(void *ctx, struct event *event);
-/* Called to initialized registered network devices */
+/* Called to initialized registered EFI network devices */
 efi_status_t efi_net_init(void);
 efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_device.c
index f2167485ab9..90d695da2b1 100644
--- a/lib/efi_driver/efi_net_device.c
+++ b/lib/efi_driver/efi_net_device.c
@@ -24,11 +24,9 @@ static efi_status_t efi_net_bind_drv(
 			struct efi_driver_binding_extended_protocol *this,
 			efi_handle_t handle, void *interface)
 {
-
 	EFI_PRINT("%s: handle %p, interface %p\n", __func__, handle, interface);
 
-
-	return EFI_UNSUPPORTED;
+	return EFI_SUCCESS;
 }
 
 /**
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index a14ecf3d182..fd43eec4c03 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1127,7 +1127,7 @@ efi_status_t efi_net_do_start(void)
 	int i, r;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i]) {
+		if (net_objs[i] && net_objs[i]->dev) {
 			r = efi_netobj_start(net_objs[i]);
 			if (r)
 				return EFI_DEVICE_ERROR;
@@ -1200,7 +1200,7 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 
 	/* Fill in object data */
 	r = efi_add_protocol(netobj->handle, &efi_net_guid,
-			     netobj->net);
+			netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
@@ -1248,12 +1248,16 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
 	netobj->pxe.mode = &netobj->pxe_mode;
 
+	r = EFI_CALL(efi_connect_controller(netobj->handle, NULL, NULL, 0));
+	if (r != EFI_SUCCESS)
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
@@ -1305,7 +1309,6 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-	printf("efi_net init device number %d\n", netobj->efi_seq_num);
 	return 0;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1426,7 +1429,8 @@ int efi_net_register(void *ctx, struct event *event)
 {
 	struct udevice *dev;
 	enum uclass_id id;
-	int i;
+	struct efi_net_obj *netobj;
+	int i, r;
 
 	dev = event->data.dm.dev;
 	if (!dev) {
@@ -1445,9 +1449,19 @@ int efi_net_register(void *ctx, struct event *event)
 		}
 	}
 
-	if (!efi_netobj_alloc(NULL, NULL, dev))
+	netobj = efi_netobj_alloc(NULL, NULL, dev);
+
+	if (!netobj)
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
 
@@ -1491,6 +1505,10 @@ int efi_net_unregister(void *ctx, struct event *event)
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
2.48.1

