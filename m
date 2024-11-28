Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC7D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0217B89D39;
	Thu, 28 Nov 2024 15:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8swXF95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345B389D19; Thu, 28 Nov 2024 15:44:44 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A487F89D42
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ea4d429e43so640648a91.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805080; x=1733409880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqFtmJQ97w6q0s+J1XVKfSR/BlHir9l6iPZWoLEv19g=;
 b=J8swXF95q3EmULNjx6m+9Yp7DTLbSytmpFnQw2dZYrgth7EMIbifQU4HgWTi8RcYAW
 uGLR6F/aZWnG/i2u5jbHcLk4ORnJQL/nBj62ZdMLK7kGMqFECg0tueCLRhcZmYkddejB
 dYnns48PtOwY0N/V8kP++AMA7xMdDxpJsskU1YRnzI4a0NeJT7PZyms9wVBGD5BMkVfZ
 GYxJNndzMMoowgARgZKF7b7RrWrkkBI152cCzwPcQ2HaEGC+dPVa0UdHIuMBIzRfBWHN
 5Q2AWKCXFuDney/FgphVi/qhBB4N4mms6vmnQESq0RlPrLqoRUKSFlq7pK6t9XbIeLbs
 S0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805080; x=1733409880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqFtmJQ97w6q0s+J1XVKfSR/BlHir9l6iPZWoLEv19g=;
 b=AAgqVEW/AZIRA09niflIoX0jZZ4JWeIRcF6LEeHeK2FMoBmz6hcjcknf7D/fXaXy7B
 RqVV43IN5vzYMDfBIIWQ0vJ5SNEZLyA7kwDWn4uNqwjsvBAGR5vALdIvbIQXWtGbiHeM
 lA1EKH4hnpmKdlqp8o7mNH0iFc/PrqvYAJvdTP9T6aytPjVTtE2vdMseDsudc7okVWQ1
 zV6K4Hqjjrow3CUgs3MmA/2cK9tq67EeHGHqBV6dGqufCv9FVzyJfqfySj8SCs0ZkwQn
 NOL6tLBnVJLQjrlxZiOLAS/pRWJVzUAKitrnlmcY7ejkPFgZchTcdq0V0w1TTCqogpdU
 oTbw==
X-Gm-Message-State: AOJu0YwvNj578CqGqqEoWo07xs/Cud0rIqVujAtSBx724Za4kNc1wnNb
 bf7iKRhD2+W9toGSQljJnyrkCoXQrEoKRUTHGt7U6+XvinUfXFaEp6EBtfzJe5M=
X-Gm-Gg: ASbGnctkUHwctvW+E8nXU4+JTESSnVxSoyGHGaWp74tdi71ICsCRIec6wY32GwaBS+z
 s2FwP3fTVfhrYMJw2F56JcltnLuatycYfVZTaz+nMrUFpd+HSq2sWIRWdaEeW1GPqRiT4LcpHw4
 9D/qp0oL6sKPW9Cf4sFtYerdJISXHSciN075ok8VH+c4UyZ/oHrIix+6jifcbpKZ+zpjFlPwCTY
 +ZJJti7ezWocAOr3MJsSaXiVukBKRYrY51LgZI+YzM=
X-Google-Smtp-Source: AGHT+IG3gb8w5tN2uzDubpVzePPwSVUrFCD0T1ee+umNLsJCcgRRkqfwpsKNkoATYrS35t+MMY2juA==
X-Received: by 2002:a17:90b:388a:b0:2ea:adaa:1a42 with SMTP id
 98e67ed59e1d1-2ee08ecc3f2mr11691057a91.16.1732805080148; 
 Thu, 28 Nov 2024 06:44:40 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 08/14] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Thu, 28 Nov 2024 11:44:10 -0300
Message-ID: <20241128144416.604126-9-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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
---
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
 lib/efi_loader/efi_bootbin.c     | 40 +++++++++++++----------
 lib/efi_loader/efi_device_path.c |  5 +--
 lib/efi_loader/efi_net.c         | 55 +++++++++++++++++++++++++++++++-
 net/lwip/wget.c                  |  5 ++-
 net/wget.c                       |  2 +-
 6 files changed, 89 insertions(+), 23 deletions(-)

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
index a87006b3c0..f8d3ee0bcf 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -93,24 +93,32 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 	image_addr = buffer;
 	image_size = buffer_size;
 
+#if IS_ENABLED(CONFIG_NETDEVICES)
+	ret = efi_net_set_dp(dev, devnr);
+	if (ret != EFI_SUCCESS)
+		goto error;
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
index 2becb02f7b..fcc0e62512 100644
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

