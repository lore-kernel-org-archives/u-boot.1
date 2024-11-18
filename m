Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61239D591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9684388D9E;
	Mon, 18 Nov 2024 22:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z4M1HLRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF9488C10; Mon, 18 Nov 2024 22:09:41 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA020894BD
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2967c76318fso202683fac.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964177; x=1732568977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iW4PSUSeW/hJJBDgoeF27c/wsWE25nUTwpmfgc5brhM=;
 b=Z4M1HLRolgteGPSJMSFM2ThbVWwmw48eV9ZN2SkxU8Y1zyhWiz02eA80GHxtkr6xdv
 mARHbEX428zwNq463PLLkJIQ8qOF6tP/UNww6ZmJ8G7q//x5fhFvzD8uAja5HTJF72MN
 JKcn8FQfzfaBtnKqlq11lBCyDzLiXeKVne4X5ukUrnuclMwSf0TMBsTcsPlZBcq8XvT2
 oOojTiXSlAeN2qoIz9rroagOAv8N8Gk8sbxa3hW3y5ElfHVjgiI+LiolDlwdDqqcukvt
 evo/G5t+PnshnulQDknJGbVNAbBVIxaAKB7SE0Bo9OmvFJISxqHVttA2WeZ7yn3+G4mJ
 IYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964177; x=1732568977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iW4PSUSeW/hJJBDgoeF27c/wsWE25nUTwpmfgc5brhM=;
 b=c2sH2KYYMWlXX2ei/RSwFvj7FYAh9bDf4r/n+vqJQBiwF4cg0k4ktIevyvPt5t+TA4
 zrnFdU1pZ1TqIcE5MHuuD4qyGbYVUptxo0COaIzgP2Uu+/GC/d+SkVoPF5RXa9hT7Yxa
 9u8KPfoXe/1yzPQLIBpLDK3xuiZaMS6U2+5OtaH0P/3e4nnRlPFbG6rGgMh5Zj7UCpQP
 JF8zb7HRIgE2k8GqGNAR+Qfy6RqEwjW2IWXC92WsNZtkaRpjGl8e/g9IcCpQ3u58zcf2
 3d0tEWpiXRpF2rsteUQfh2d1pJkKg1n0dEU7puiGysJZLn000sTvMWcUrVU+QlcMhNiW
 TROg==
X-Gm-Message-State: AOJu0Yzosw8t3OCmgt/mAtLt7tAu8MtpBjFO4hsn82nJXrO2CbvamKOJ
 YBwFRpHo2BlQGgAS/d/VWO95s9db5DvB8V/n3vc3p9xi5Y4Qdfm+pLDCQITN
X-Google-Smtp-Source: AGHT+IG4WVbcuQIHmaXExR7UvDROwOQ2m38P34TbIi1Q7O2WvFh3HRIUwlEJz+fMKCaWl5aO21W4Sg==
X-Received: by 2002:a05:6870:7904:b0:277:ce5e:1e94 with SMTP id
 586e51a60fabf-2962e208e9amr13829280fac.30.1731964177629; 
 Mon, 18 Nov 2024 13:09:37 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:36 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 08/14] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Mon, 18 Nov 2024 18:09:02 -0300
Message-ID: <20241118210908.51196-9-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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

(no changes since v2)

 include/efi_loader.h             |  6 +++++
 lib/efi_loader/efi_device_path.c |  2 +-
 lib/efi_loader/efi_net.c         | 38 +++++++++++++++++++++++++++++++-
 net/lwip/wget.c                  |  1 +
 net/wget.c                       |  1 +
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 96b204dfc3..f49f8e6be0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 #endif
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
+/* Call this to update the current device path of the efi net device */
+void efi_net_set_dp(const char *dev, const char *server);
+/* Call this to get the current device path of the efi net device */
+void efi_net_get_dp(void **dp);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
@@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
 #else
+static inline void efi_net_set_dp(const char *dev, const char *server) { }
+static inline void efi_net_get_dp(void **dp) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
 				     struct efi_ipv4_address *gw) { }
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 9ee03062ac..5fae3fbb5a 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1165,7 +1165,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
-		dp = efi_dp_from_eth();
+		efi_net_get_dp((void **)&dp);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 3f0b571cc6..2207caf6fe 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -16,6 +16,7 @@
  */
 
 #include <efi_loader.h>
+#include <dm.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <net.h>
@@ -31,6 +32,7 @@ static size_t *receive_lengths;
 static int rx_packet_idx;
 static int rx_packet_num;
 static struct efi_net_obj *netobj;
+static struct efi_device_path *net_dp;
 
 /*
  * The notification function of this event is called in every timer cycle
@@ -902,8 +904,10 @@ efi_status_t efi_net_register(void)
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
@@ -999,6 +1003,38 @@ out_of_resources:
 	return EFI_OUT_OF_RESOURCES;
 }
 
+/**
+ * efi_net_set_dp() - set device path of efi net device
+ *
+ * This gets called to update the device path when a new boot
+ * file is dowloaded
+ *
+ * @dev:	dev to set the device path from
+ * @server:	remote server address
+ */
+void efi_net_set_dp(const char *dev, const char *server)
+{
+	if (!strcmp(dev, "Net"))
+		net_dp = efi_dp_from_eth();
+	else if (!strcmp(dev, "Http"))
+		net_dp = efi_dp_from_http(server);
+}
+
+/**
+ * efi_net_get_dp() - get device path of efi net device
+ *
+ * Produce a copy of the current device path
+ *
+ * @dp:		copy of the current device path
+ */
+void efi_net_get_dp(void **dp)
+{
+	if (!net_dp)
+		efi_net_set_dp("Net", NULL);
+	if (dp && net_dp)
+		*dp = efi_dp_dup(net_dp);
+}
+
 /**
  * efi_net_get_addr() - get IP address information
  *
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 53c3b169e0..5c44e324be 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -217,6 +217,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	print_size(rx_content_len / elapsed * 1000, "/s)\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
 	if (wget_info->set_bootdev) {
+		efi_net_set_dp("Http", ctx->server_name);
 		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
 				rx_content_len);
 	}
diff --git a/net/wget.c b/net/wget.c
index 1166aa5aa6..a1328990d2 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -442,6 +442,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		net_set_state(wget_loop_state);
 		wget_info->file_size = net_boot_file_size;
 		if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
+			efi_net_set_dp("Http", NULL);
 			efi_set_bootdev("Net", "", image_url,
 					map_sysmem(image_load_addr, 0),
 					net_boot_file_size);
-- 
2.43.0

