Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0431EC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938B380C7E;
	Wed, 22 Jan 2025 18:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdiz4Ir/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38F380C75; Wed, 22 Jan 2025 18:09:40 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A1580BA9
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21661be2c2dso131383125ad.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565777; x=1738170577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vhd92hI4YmAHVeRRuUSCU6A0/6v/xnuL7zlDVwmNg/Q=;
 b=cdiz4Ir/RCrezykf4IN9ldnSfXMsPohhDc7j+8tzHt8LVVVpbP6bAqVE06hkvDXYLh
 LCn5Kt+D6oZk5br4DD3e6ggtImNzXc2ieWjBrnBclolN1AZrSJrTpvQ8rF0jeB5Yu5Xt
 sZ0hy6KzhNy3L6bIJLI/oMRGtw1uHGu7uDnO2cULdE59NdTnhj+El7MjXqKV9CoGBUuB
 bKhPJEGUI2xsGdCcWxTTihCEBLg6uPiw10cxeQ+Qr8gus2r4+EEQqTh9O0P/beaCJqAt
 il701oS92Kgbib23YGOqQz+QkiHkxirxYK8Aa3zkF1JKnphhuSS9xYYUK6VKufAqihm8
 22zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565777; x=1738170577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vhd92hI4YmAHVeRRuUSCU6A0/6v/xnuL7zlDVwmNg/Q=;
 b=ZKFzk3ibjVCJyqJd9NhyRKr+vHAJNDRJW3gYrcgokIWXIwABqe2mMuDawh74yRPujg
 PlJuokywNdaY7T7CubSWbxiHqBxGfkCG45XUgxaohYbPbJ1eFOyn490eq8wJ90MrUyMu
 YUYzYKQIQxSrzJj9LNAoHZ3x/UkBS54mma4iJLuArzlt7camzMjVR686huERbeXKswB7
 zlh3UIsQFEHTgE7yn931IeFlSpDLsI4YwYYCXYyEfgcTyerDGUf5FdaGx6f1JVkG9PM6
 mJ7pK5tBw7UDMamaLWxg0zbGdHh3kBX55VZSfZUSB4/Slb6tLqI4A+jgo4va8KRN/Y/D
 w0Kg==
X-Gm-Message-State: AOJu0YwFYB/oyOowKnfUheNgGvSn/Egt3InyO03rq3Hqgfx9THnXz2Je
 pQ28Uaqyc/BaDRlH2/EfP0xVm4DvxcAAJY94Zsvo5atdgiHDYUDgy+KM/tBo
X-Gm-Gg: ASbGncsQ+qatyox/MDqF7xMh/LOT/k2CSE7ysnZWlWzBCqlvlmHhA0n41aimUba5yY2
 rs0HCY0Cm9abgecU92kpXFeXCs6aRq0jku+xR8ICe+PpLNCrd1Wu61M4/i52AsKIhvrfjPYLTl6
 9u8xgnNk+2TcfNfwDCuZsM5WL40DNh0q9cKdTS0be/kr6MTYdsbGr5v91IIjQNejZ9hgfnvSWle
 oBscjmU9e8IPMSWBs76dQOdi4bGBY4HCJQukL0kbmIP8ON22dhawDZpkkBTguUggzf4LqeRMkDJ
 GUMiynk/3aqW
X-Google-Smtp-Source: AGHT+IF7Q0GZut96EsEoZ7nCid+JSO5IHvxcc4oeqc4fsEAxNZNtmCylVeXc1rUHzWtlDEDGxPGKlg==
X-Received: by 2002:a17:903:174c:b0:215:4394:40b5 with SMTP id
 d9443c01a7336-21c355dc59fmr318414405ad.43.1737565777017; 
 Wed, 22 Jan 2025 09:09:37 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:36 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 10/21] efi_net: efi_loader: Add efi_netobj_alloc to allocate
 an efi_net_obj
Date: Wed, 22 Jan 2025 14:08:47 -0300
Message-ID: <20250122170858.961359-11-adriano.cordova@canonical.com>
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

For clarity, put the allocation of an efi_net_obj in efi_netobj_alloc

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 122 ++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 39 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 3e39cdf212..98b9c8b82e 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1335,44 +1335,26 @@ efi_status_t efi_net_init(void)
 }
 
 /**
- * efi_net_register() - register a net device
- *
- * This function is called when the device is probed
+ * efi_netobj_alloc() - allocate an efi_net_obj from either a simple
+ *			network protocol interface or a net udevice
  *
- * @ctx:	context set at registration time
- * @event:	event
- * Return:	0 on success, negative on error
+ * @handle:	EFI handle
+ * @net:	pointer to simple network protocol
+ * @dev:	pointer to net udevice
+ * Return:	pointer to EFI net object, NULL on error
  */
-int efi_net_register(void *ctx, struct event *event)
+struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
+				     struct efi_simple_network *net,
+				     struct udevice *dev)
 {
-	struct udevice *dev;
-	int seq_num;
-	enum uclass_id id;
+	int i, seq_num;
 	struct efi_net_obj *netobj;
-	int i;
-
-	dev = event->data.dm.dev;
-	if (!dev) {
-		/* No network device active, don't expose any */
-		return 0;
-	}
-
-	id = device_get_uclass_id(dev);
-	if (id != UCLASS_ETH)
-		return 0;
-
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->dev == dev) {
-			// Do not register duplicate devices
-			return 0;
-		}
-	}
 
 	// Find a slot for this efi_net_obj
 	seq_num = -1;
 	// Try to recycle
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && !net_objs[i]->dev) {
+		if (net_objs[i] && !net_objs[i]->net && !net_objs[i]->dev && !net_objs[i]->handle) {
 			seq_num = i;
 			break;
 		}
@@ -1386,7 +1368,7 @@ int efi_net_register(void *ctx, struct event *event)
 		}
 	}
 	if (seq_num < 0)
-		return -1;
+		return NULL;
 
 	if (!net_objs[seq_num]) {
 		netobj = calloc(1, sizeof(*netobj));
@@ -1395,21 +1377,83 @@ int efi_net_register(void *ctx, struct event *event)
 		netobj = net_objs[seq_num];
 	}
 	if (!netobj)
-		goto out_of_resources;
+		return NULL;
 
-	netobj->handle = calloc(1, sizeof(*netobj->handle));
-	if (!netobj->handle) {
-		free(netobj);
-		goto out_of_resources;
+	if (netobj->net) {
+		if (netobj->net->mode)
+			free(netobj->net->mode);
+		free(netobj->net);
+	}
+
+	if (handle) {
+		netobj->handle = handle;
+	} else {
+		netobj->handle = calloc(1, sizeof(*netobj->handle));
+		if (!netobj->handle) {
+			free(netobj);
+			return NULL;
+		}
+	}
+
+	if (net) {
+		netobj->net = net;
+		netobj->net_mode = net->mode;
+	} else {
+		netobj->net = calloc(1, sizeof(*netobj->net));
+		if (!netobj->net) {
+			free(netobj->handle);
+			free(netobj);
+			return NULL;
+		}
 	}
 
 	netobj->dev = dev;
 	netobj->efi_seq_num = seq_num;
-	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
+
+	printf("efi_net: allocated EFI net device %d\n", netobj->efi_seq_num);
+
+	return netobj;
+}
+
+/**
+ * efi_net_register() - register a net device
+ *
+ * This function is called when the device is probed
+ *
+ * @ctx:	context set at registration time
+ * @event:	event
+ * Return:	0 on success, negative on error
+ */
+int efi_net_register(void *ctx, struct event *event)
+{
+	struct udevice *dev;
+	enum uclass_id id;
+	struct efi_net_obj *netobj;
+	int i;
+
+	dev = event->data.dm.dev;
+	if (!dev) {
+		/* No network device active, don't expose any */
+		return 0;
+	}
+
+	id = device_get_uclass_id(dev);
+	if (id != UCLASS_ETH)
+		return 0;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			// Do not register duplicate devices
+			return 0;
+		}
+	}
+
+	netobj = efi_netobj_alloc(NULL, NULL, dev);
+
+	if (!netobj)
+		return -1;
+
 	return 0;
-out_of_resources:
-	printf("ERROR: Out of memory\n");
-	return -1;
 }
 
 /**
-- 
2.43.0

