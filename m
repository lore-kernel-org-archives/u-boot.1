Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B9E7716C
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2D7894F0;
	Wed,  4 Dec 2024 04:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jxJ2NrC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D325689251; Wed,  4 Dec 2024 04:05:59 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611FE8911D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21572ca3cccso31568135ad.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281556; x=1733886356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Q80mwegphjOCRuPmkRmpkMePfzX2duLIkmgUMN42/Q=;
 b=jxJ2NrC+8Xly7/5xbwgDG1wfozyREiHKUu16wjEsKyqllp2woe9nB6yHejHZ2J5SGN
 /mgNVt13jKrw6b2+pFmDRl2Xqxj9IvRHZmCcimN+P8Ve1XptOwbZuYgYtUNB7d6+b2IR
 i6EvMLqR5BazbKhp5NC830oKFl4AoV+BdbIE6//tu6BRjZ6Gn0jKbOvEVDKYSVOWv40H
 2vj4m4swFsbfGn+WamvA6Wvk76UUaaqSLuFuDsXyLUvLuRvWldH/SvIkR92bTxr9x62F
 IqtkHEf4tpooY9am1+BQEzfnsK7VAsfRi8ZQWJnlioSLtt271vPj8slzOp4V7igY+Qdj
 reKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281556; x=1733886356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Q80mwegphjOCRuPmkRmpkMePfzX2duLIkmgUMN42/Q=;
 b=oQLlgiOTTAutkpRf3+9mV68wXN4uwyFQxSGtDUW1WfgexXdFBd0EURaIgIxchm4b60
 sanwXigMTZJ7r9eWpyNAsw7ESRw5gmPKMkI1+aHAdhQKfsOug6f7Q1UjS8lU2ttzkSt1
 ESmUYIMkjmw0Adgo93Joh29WPP+dQX4zd31/ekPvRbwZ9VAG7kaxec5RdiPO2wZfLd6z
 /d29rdgDXPob1TQwxcae+PfFIWldkzB2HTL711ONLxUnY3chtxS01Mj9s7gmx4jp9yqT
 n1i/ak2xxeFFQk3CVHW0RbqiRaiK6SNmqJEJRSueFBFgxBPMGtXwyJ5J1LYM00U2iwXf
 mf1g==
X-Gm-Message-State: AOJu0YyiCceWuFDl9UpCo+S/Q5+Khy2RPwp7a2A3d/KChQlH33U8vh40
 q8fOS7WuQgg+WqsnVCAZ6qAoay4I5Os75oKRN3eehCKrFg/+YzqXzmzwYDwJYoM=
X-Gm-Gg: ASbGncvQbk+HHC5D0JqppFgpnUCLeVT8HU42NAdeabqVMUu0tBs8u4kGgHmxNxKRg5g
 4kchBT6az0hDHaQ7NvYjQUxG2Az6zbfsJSO2+QVo5s9vqtjLxgPToZOublbeWC8zRPotzds85Fv
 nwqWgCf0ReYchWb2VGNM8Sg8adu38GRIDkk9nOyE35sbCXf6I21D4vYpXykxHqRlI7JaolUPbSO
 c9uzuMexFfOZJ8+QjQv5Yqu1OhEEioTXoPzqhGlgeg=
X-Google-Smtp-Source: AGHT+IGVE8Xnoq+mvSFqFdDasP49PUNv15JnumG4U/M9mNNjradV3ZHHIZ5SCs0WHmT9o4Uyn8VqyQ==
X-Received: by 2002:a17:902:ccc2:b0:215:7f94:2b8 with SMTP id
 d9443c01a7336-215bd1fda4amr91540645ad.24.1733281555834; 
 Tue, 03 Dec 2024 19:05:55 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:55 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Wed,  4 Dec 2024 00:05:23 -0300
Message-ID: <20241204030530.2099776-8-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

Set the device path of the efi boot device to an HTTP device path
(as formed by efi_dp_from_http) when the next boot stage is loaded
using wget (i.e., when wget is used with wget_info.set_bootdev=1).

When loaded from HTTP, the device path should account for it so that
the next boot stage is aware (e.g. grub only loads its http stack if
it itself was loaded from http, and it checks this from its device path).

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes in v7:
- Add a check before calling efi_net_set_dp in efi_set_bootdev
Changes in v6:
- Add error handling to efi_net_set_dp and put it inside efi_set_bootdev,
  reducing the number of calls to efi functions outside efi code.
- Free net_dp before an update
- Complete documentation for efi_net_get_dp. Error handling: returns NULL on error
Changes in v5:
- Add description of net_dp
- Change a void** for an efi_device_path**
(no changes since v2)
 include/efi_loader.h             |  5 +++
 lib/efi_loader/efi_bootbin.c     | 42 ++++++++++++++----------
 lib/efi_loader/efi_device_path.c |  5 +--
 lib/efi_loader/efi_net.c         | 55 +++++++++++++++++++++++++++++++-
 net/lwip/wget.c                  |  5 ++-
 net/wget.c                       |  2 +-
 6 files changed, 91 insertions(+), 23 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 96b204dfc3..0da0248db4 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 #endif
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
+/* Call this to update the current device path of the efi net device */
+efi_status_t efi_net_set_dp(const char *dev, const char *server);
+/* Call this to get the current device path of the efi net device */
+void efi_net_get_dp(struct efi_device_path **dp);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
@@ -133,6 +137,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
 #else
+static inline void efi_net_get_dp(struct efi_device_path **dp) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
 				     struct efi_ipv4_address *gw) { }
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0..b677bbc312 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -93,24 +93,34 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 	image_addr = buffer;
 	image_size = buffer_size;
 
+#if IS_ENABLED(CONFIG_NETDEVICES)
+	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
+		ret = efi_net_set_dp(dev, devnr);
+		if (ret != EFI_SUCCESS)
+			goto error;
+	}
+#endif
+
 	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
-	if (ret == EFI_SUCCESS) {
-		bootefi_device_path = device;
-		if (image) {
-			/* FIXME: image should not contain device */
-			struct efi_device_path *image_tmp = image;
-
-			efi_dp_split_file_path(image, &device, &image);
-			efi_free_pool(image_tmp);
-		}
-		bootefi_image_path = image;
-		log_debug("- boot device %pD\n", device);
-		if (image)
-			log_debug("- image %pD\n", image);
-	} else {
-		log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
-		efi_clear_bootdev();
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	bootefi_device_path = device;
+	if (image) {
+		/* FIXME: image should not contain device */
+		struct efi_device_path *image_tmp = image;
+
+		efi_dp_split_file_path(image, &device, &image);
+		efi_free_pool(image_tmp);
 	}
+	bootefi_image_path = image;
+	log_debug("- boot device %pD\n", device);
+	if (image)
+		log_debug("- image %pD\n", image);
+	return;
+error:
+	log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
+	efi_clear_bootdev();
 }
 
 /**
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index a6d4300686..5eae6fd39c 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1185,8 +1185,9 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 				     (uintptr_t)image_addr, image_size);
-	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
-		dp = efi_dp_from_eth();
+	} else if (IS_ENABLED(CONFIG_NETDEVICES) &&
+		   (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
+		efi_net_get_dp(&dp);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 3491d4c481..e8af2e3d95 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -16,6 +16,7 @@
  */
 
 #include <efi_loader.h>
+#include <dm.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <net.h>
@@ -32,6 +33,13 @@ static int rx_packet_idx;
 static int rx_packet_num;
 static struct efi_net_obj *netobj;
 
+/*
+ * The current network device path. This device path is updated when a new
+ * bootfile is downloaded from the network. If then the bootfile is loaded
+ * as an efi image, net_dp is passed as the device path of the loaded image.
+ */
+static struct efi_device_path *net_dp;
+
 /*
  * The notification function of this event is called in every timer cycle
  * to check if a new network packet has been received.
@@ -902,8 +910,10 @@ efi_status_t efi_net_register(void)
 			     &netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
+	if (!net_dp)
+		efi_net_set_dp("Net", NULL);
 	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
-			     efi_dp_from_eth());
+			     net_dp);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
@@ -999,6 +1009,49 @@ out_of_resources:
 	return EFI_OUT_OF_RESOURCES;
 }
 
+/**
+ * efi_net_set_dp() - set device path of efi net device
+ *
+ * This gets called to update the device path when a new boot
+ * file is downloaded
+ *
+ * @dev:	dev to set the device path from
+ * @server:	remote server address
+ * Return:	status code
+ */
+efi_status_t efi_net_set_dp(const char *dev, const char *server)
+{
+	efi_free_pool(net_dp);
+
+	net_dp = NULL;
+	if (!strcmp(dev, "Net"))
+		net_dp = efi_dp_from_eth();
+	else if (!strcmp(dev, "Http"))
+		net_dp = efi_dp_from_http(server);
+
+	if (!net_dp)
+		return EFI_OUT_OF_RESOURCES;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_net_get_dp() - get device path of efi net device
+ *
+ * Produce a copy of the current device path
+ *
+ * @dp:		copy of the current device path, or NULL on error
+ */
+void efi_net_get_dp(struct efi_device_path **dp)
+{
+	if (!dp)
+		return;
+	if (!net_dp)
+		efi_net_set_dp("Net", NULL);
+	if (net_dp)
+		*dp = efi_dp_dup(net_dp);
+}
+
 /**
  * efi_net_get_addr() - get IP address information
  *
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index af87e1acd3..b76f6c0f1d 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -260,10 +260,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
 	print_size(rx_content_len / elapsed * 1000, "/s)\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
-	if (wget_info->set_bootdev) {
-		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
+	if (wget_info->set_bootdev)
+		efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->saved_daddr, 0),
 				rx_content_len);
-	}
 	wget_lwip_set_file_size(rx_content_len);
 	if (env_set_hex("filesize", rx_content_len) ||
 	    env_set_hex("fileaddr", ctx->saved_daddr)) {
diff --git a/net/wget.c b/net/wget.c
index f3b43b06b8..d338eaf4ef 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -447,7 +447,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		net_set_state(wget_loop_state);
 		wget_info->file_size = net_boot_file_size;
 		if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
-			efi_set_bootdev("Net", "", image_url,
+			efi_set_bootdev("Http", NULL, image_url,
 					map_sysmem(image_load_addr, 0),
 					net_boot_file_size);
 			env_set_hex("filesize", net_boot_file_size);
-- 
2.43.0

