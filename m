Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4633DC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538C180A09;
	Wed, 22 Jan 2025 18:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMr1qncb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD5980C68; Wed, 22 Jan 2025 18:09:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97A680977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21680814d42so117745605ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565782; x=1738170582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFbeeLnsq+ldk1iAM8no+jJb/uuqXRXiqt2rNhjDhQ0=;
 b=ZMr1qncbG4i/wJz/3rLRVLne13cBOZXG0C5u3GxuxooUJCCtQaGx+/8JsHxFO/EGHu
 xG4tt6zCrFybBKT0YsYIq5A35hsFq4tXtd7Tfl/dDndZWIytnC7O8i+Bie2wYFIDwFUz
 cN7ysUG+Y9g4ASItJoAfRd8cnASL2oEFHt+yVjUbM2p5X0KVf19nOjNIYL7w+qHnrbVD
 2BETP9fPOIKeQzYp3tqOiMS9uey6xbP1D0SFIsYWNN0FX+irELIPvRgdrmDggYGbcwQq
 BFyGGbM0uol0x9wxFnc/yZlz10y9CeILJb//ExbwbvS1882nJQsnGWT5InyUaF5QxfzN
 Z/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565782; x=1738170582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFbeeLnsq+ldk1iAM8no+jJb/uuqXRXiqt2rNhjDhQ0=;
 b=KtksAE9iuiZJprW49u+WdxabnnC7S9WjelKEEHG3KLgJbx3ayecn/5dZMTzuku68eR
 KNXU7bny2Q1d6tqGyCKLlG5PaZw9sQLp78nb1RwBwHtzQqFJ5L6Ab2ac16nO+hntH0T0
 gAoCmsEYDID/uPLqmUhVv9gFiio/T5FzS/0RX/Pt4FUIiYCucKED2Q9rWT+AM7V4JXMI
 bk2I18lvMoyG4sC+4Aamy6dPlV+4K5U/Y4/TxAyOsoN17ZliOZc7t1AREKSArFbX6+1u
 2hYRomJ2DjGtd6u6Uo8j9k6KHZp/78z8uN+A6mf/zXMTHN6I/aAwtm5kDwINHMF6w2za
 0HOg==
X-Gm-Message-State: AOJu0YyiPPiS+OoC4mgsZUWUCrugySGtOgoGIMSYzLCr7kHZHKopJOSb
 u5+o8Zc2qOcXrk2bGHkb8b/HFMZGxZHIk/NVquOmJctpAU9Vet3mUBW9yNe4
X-Gm-Gg: ASbGncta2fIgv5YSTkXN5XMOIRgaYURU7Ib+pGlMLP8qyw1nltuwLK0hV22lUnyMiJr
 mCH499r3vr0c7k56w8lvkiJPuz49TolMjwWhZTmXkNJLPhRrKQtg0uUEhw0kUAh8qMWqebmH1J6
 Yr3vmyfqZnNXsC7N4sQp3qiDtD+opeEfo1OF2mqbljdUJ7111dZEkOtnbxbfX80TDOSBzL9zRsg
 YQ73+tyJBRlsXXmsLHJCs/HGkd5Ph6tnrf1xH077XaDwYY/6R9j9mZmOgRfG2PARjwQsboEiavB
 Nw==
X-Google-Smtp-Source: AGHT+IHP5Ie61vteQWOGgmiZYy/3mlbE3olC0Ep8NMKb9h5KqzOeQKW1hWK3ErPaGESyv1elZqTwHA==
X-Received: by 2002:a17:903:32c1:b0:21b:d126:6d30 with SMTP id
 d9443c01a7336-21c355c433amr304479555ad.33.1737565782213; 
 Wed, 22 Jan 2025 09:09:42 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:41 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 12/21] eth_uclass: Add eth_create_device to create a net
 udevice
Date: Wed, 22 Jan 2025 14:08:49 -0300
Message-ID: <20250122170858.961359-13-adriano.cordova@canonical.com>
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

Create an ETH_UCLASS udevice and bind it to a driver

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/net-common.h |  2 ++
 net/eth-uclass.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index 1d507b13b0..ba343af4c6 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -203,6 +203,8 @@ int eth_receive(void *packet, int length); /* Receive a packet*/
 extern void (*push_packet)(void *packet, int length);
 #endif
 int eth_rx(void);			/* Check for received packets */
+int eth_create_device(struct udevice *parent, const char *drv_name,
+		      const char *name, struct udevice **devp);
 
 /**
  * reset_phy() - Reset the Ethernet PHY
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5555f82f23..952df419b7 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -12,10 +12,12 @@
 #include <dm.h>
 #include <env.h>
 #include <log.h>
+#include <malloc.h>
 #include <net.h>
 #include <nvmem.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/uclass-internal.h>
 #include <net/pcap.h>
 #include "eth_internal.h"
@@ -528,6 +530,36 @@ int eth_initialize(void)
 	return num_devices;
 }
 
+int eth_create_device(struct udevice *parent, const char *drv_name,
+		      const char *name, struct udevice **devp)
+{
+	char temp[40], *str;
+	int devnum;
+	struct uclass *uc;
+	int ret;
+
+	ret = uclass_get(UCLASS_ETH, &uc);
+	if (ret)
+		return -1;
+
+	devnum = uclass_find_next_free_seq(uc);
+	if (devnum < 0)
+		return -1;
+
+	snprintf(temp, sizeof(temp), "%s_eth%d", name, devnum);
+	temp[sizeof(temp) - 1] = '\0';
+	str = strdup(temp);
+
+	ret = device_bind_driver(parent, drv_name, str, devp);
+	if (ret) {
+		free(str);
+		return ret;
+	}
+	device_set_name_alloced(*devp);
+
+	return 0;
+}
+
 static int eth_post_bind(struct udevice *dev)
 {
 	struct eth_uclass_priv *priv = uclass_get_priv(dev->uclass);
-- 
2.43.0

