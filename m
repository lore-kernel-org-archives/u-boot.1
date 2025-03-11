Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D517C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B07481703;
	Tue, 11 Mar 2025 17:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lC8IiA5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F311581782; Tue, 11 Mar 2025 17:48:05 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9990A81703
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223959039f4so116188875ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711682; x=1742316482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpcxnpq4lqPST+NC1FpyF6K/wzZxhWN8IBhUaqqGmVE=;
 b=lC8IiA5btkLEkzYWwgGs4fJsWSBmjSwU6r37P5u8a4k09D7PFIkErCj3CpS9Hsfv0J
 UWInGbAnzgC8lYHGEebYTfyNTzrVkDqXWxEKXDekqZHw21qD+o4GXhNvq8et1KHIsoW+
 TnsJ/7ywLJyVvpJDL9RJpUNwVrEb3MkHmcT1+YonGYwfl/5/OVx3ahtDLF+RAe9R4xow
 k/ozvf/7sEshYW1zzROR2r7CxEkw7LzsBDAUuVQl9mL0z1ByAF6Ko5dOUH648YejCjtW
 xz0ctMBWzfeuGTkiP8IYg5Xt/WF9DwKTJVZ4kZpybxoS8MymoVcrEI1IaMJXgdniukeg
 gTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711682; x=1742316482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mpcxnpq4lqPST+NC1FpyF6K/wzZxhWN8IBhUaqqGmVE=;
 b=JPOHfGaq0x2ChP9cVR45ZFXUCI8mL4dyuxqBkbTI/g62F2EUiQIxX+LcZTCeCdOXVw
 guv5+fv3N1cV6dP3RtPU9ELnbnKob1XtZvo4qNbcCRjs1laUuDvYa2qcz7KuvkpMWTCo
 U0KPEogbnZYTvzSq/M446wYy5nGiybMzliY5ciEJpGhQ1u99H8JWZ7wabV1UZZQJvJUC
 zzUqCUnnPHo1RF0aRS+0/hDzJbyeqZdPGmqru9vcKEa1q19ZwLXKyd5MDuatT625Lwfe
 Yiy6fFm6P3ZR7oFw+1zGt288iCf8yPOqSDKxtoqjyIDgaR2okYLYAHOXmkO7LJyinIR/
 gwxQ==
X-Gm-Message-State: AOJu0YzsY7KcpCIIw7CX6hHrcuF3ETIXUIYLocv9LrzYUfhDQ6UDDDwG
 LAb52lEp7e5sFIbZveZFIxF6EOExO9y9S0NaMnvlyyzqND+KE161LKSV7Pcz+84=
X-Gm-Gg: ASbGncsbv3gfPpQSaAXlh8wx3iwemsYdWXLuu3ATwekrCFV5nhaC6Er2r7aNMJ6FxNu
 jJx1rUJIA8QVNizlCwiHHg3EtnPPHSk9EO7uW00GPC8u4uAvsavltDTXOTV3fH4o1zS55IbOCjI
 8Imaab0ODw1b7gV+0tNjEimZiVyd5b/Fji8hGrQPSFqaJF7UaQvjqPmIlEcRJ2WO97ExzvJ/KLL
 aqsjQ1iL4i4TX9k1w6MZ8vp7orsCx7HtAOW8VirqXorMAR6H8pUHRkYhneZrdDOC+LlmhaLfqyv
 oeJutMhz9F1+XysOB7e7JmaQATS4f0yX0yRRaD20N65106dIVhf2fid94SkAYzO/DA==
X-Google-Smtp-Source: AGHT+IHk5gL/bssTKTc4o0yeNN9lEDISAdlF2+IS9yFEIS54E28e0/L+x5i8wUTTfr2MCFcmgh7BNQ==
X-Received: by 2002:a05:6a00:2351:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-736aa9d39edmr30447453b3a.3.1741711682144; 
 Tue, 11 Mar 2025 09:48:02 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:01 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 05/16] efi_net: efi_loader: Add efi_netobj_alloc to allocate
 an efi_net_obj
Date: Tue, 11 Mar 2025 13:47:47 -0300
Message-ID: <20250311164758.421900-6-adriano.cordova@canonical.com>
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

Rework the logic to allocate an efi_net_obj and its members. An
efi_net_obj now gets allocated only in efi_netobj_alloc.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 131 ++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 51 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index a40d319a27f..a14ecf3d182 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1152,19 +1152,10 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	size_t *receive_lengths = NULL;
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
@@ -1344,6 +1335,84 @@ efi_status_t efi_net_init(void)
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_netobj_alloc() - allocate an efi_net_obj from either a simple
+ *			network protocol interface or a net udevice
+ *
+ * @handle:	EFI handle
+ * @net:	pointer to simple network protocol
+ * @dev:	pointer to net udevice
+ * Return:	pointer to EFI net object, NULL on error
+ */
+struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
+					struct efi_simple_network *net,
+					struct udevice *dev)
+{
+	int i;
+	struct efi_net_obj *netobj;
+
+	// Find a slot for this efi_net_obj
+
+	// Try to recycle
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && !net_objs[i]->net && !net_objs[i]->dev && !net_objs[i]->handle)
+			break;
+	}
+	if (i == MAX_EFI_NET_OBJS) {
+		for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+			if (!net_objs[i])
+				break;
+		}
+	}
+	if (i == MAX_EFI_NET_OBJS)
+		return NULL;
+
+	if (!net_objs[i]) {
+		netobj = calloc(1, sizeof(*netobj));
+		net_objs[i] = netobj;
+	} else {
+		netobj = net_objs[i];
+	}
+	if (!netobj)
+		return NULL;
+
+	if (netobj->net) {
+		if (netobj->net->mode)
+			free(netobj->net->mode);
+		free(netobj->net);
+	}
+
+	if (handle) {
+		netobj->handle = handle;
+	}
+	else {
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
+	}
+
+	netobj->dev = dev;
+	netobj->efi_seq_num = i;
+
+	printf("\nefi_net: allocated EFI net device %d\n", netobj->efi_seq_num);
+
+	return netobj;
+}
+
 /**
  * efi_net_register() - register a net device
  *
@@ -1356,9 +1425,7 @@ efi_status_t efi_net_init(void)
 int efi_net_register(void *ctx, struct event *event)
 {
 	struct udevice *dev;
-	int seq_num;
 	enum uclass_id id;
-	struct efi_net_obj *netobj;
 	int i;
 
 	dev = event->data.dm.dev;
@@ -1378,48 +1445,10 @@ int efi_net_register(void *ctx, struct event *event)
 		}
 	}
 
-	// Find a slot for this efi_net_obj
-	seq_num = -1;
-	// Try to recycle
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && !net_objs[i]->dev) {
-			seq_num = i;
-			break;
-		}
-	}
-	if (seq_num < 0) {
-		for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-			if (!net_objs[i]) {
-				seq_num = i;
-				break;
-			}
-		}
-	}
-	if (seq_num < 0)
+	if (!efi_netobj_alloc(NULL, NULL, dev))
 		return -1;
 
-	if (!net_objs[seq_num]) {
-		netobj = calloc(1, sizeof(*netobj));
-		net_objs[seq_num] = netobj;
-	} else {
-		netobj = net_objs[seq_num];
-	}
-	if (!netobj)
-		goto out_of_resources;
-
-	netobj->handle = calloc(1, sizeof(*netobj->handle));
-	if (!netobj->handle) {
-		free(netobj);
-		goto out_of_resources;
-	}
-
-	netobj->dev = dev;
-	netobj->efi_seq_num = seq_num;
-	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
 	return 0;
-out_of_resources:
-	printf("ERROR: Out of memory\n");
-	return -1;
 }
 
 /**
-- 
2.48.1

