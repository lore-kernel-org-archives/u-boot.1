Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ED1D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2986189234;
	Fri,  8 Nov 2024 14:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BiN8scqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D616D88B8F; Fri,  8 Nov 2024 04:47:04 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71E288DED
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so1387500b3a.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037620; x=1731642420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aTjH1FghPH37BeOgCjVWLKjLWz/9tZasod0T3dZCiSI=;
 b=BiN8scqmP2MxHbtSuPPdG+DxxRQgSeTEsAYlatHJzQUvPxHySyRzGk/z9/mQGHVYEU
 WNC4oTo4ZXmAccIgJGsk5BoNyr5yFdGEUkaMd9PpTPW+qshGS6uz+N/kg+LbCh9IEAbM
 WGcaJQLGV3VgkQhCJ3Ycpo2F/RzjRw1YgVmD0Gi3ffVjfTumDYSzHPKJoYrJaFlwr+pm
 WvzmhxUCjpKnrIcr+k2roTaSYwIwSjpP5ZenGDZNeUB0Ice0d18Up4Vck/nM83vdJr+r
 QAbKQSPtrzTQskz+d3OZPfbJz7/uqf5M+zJcBVy3Wk1o6lxajXsFdWMHBZMyJX4D0kqv
 0vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037620; x=1731642420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTjH1FghPH37BeOgCjVWLKjLWz/9tZasod0T3dZCiSI=;
 b=RaOqKrUUGj0f60hKkELgqIS7s09PqI1ixxUf2/xLjK8sfVjtmFeIdqYbBkNM6FWCAp
 yphxUNVJXGQwKhfZD00/BDd/v3Dbb+IcHRtoqnvuCoLNetRB8Iz/8aeuIsJ1fVrXN49y
 Pd6Hp63DMxq3RVNehCOaxwg9tjpqX4fbzEt+U6eQYStYdP0ZIrh1WnrelEClLG0rNOng
 nKBWda2/hGnRpgchoAcsp2Blv78Nz7UD/uEEFbo2d2Q6q8KsgHrbKOJedc0h3YkOsF/k
 ItoS/jeCH1XVeCMbPTqBzBC0HmuK5W64B7GC01W5rNyOVY/8hOGU9KkbnMD1OjsNXYqY
 B7jw==
X-Gm-Message-State: AOJu0YyIIW8oWP1Moid8k1zS3jtlIsKTkiEY3kvoXbQlQy8PjSO/0Y/P
 PXqKGmNsGnspX7tnyhDheSQDyNRIaCG+JsaHQIwA6mRXuTsSnj/qvIOnVQHCLEs=
X-Google-Smtp-Source: AGHT+IEbNty3ovmVsFwVz6dMcSDLAXhFTEXrTzsJQh/qjdWydiTO837DI6DRp+z0V1tArx1k4NG5tA==
X-Received: by 2002:a05:6a20:2444:b0:1db:e096:8497 with SMTP id
 adf61e73a8af0-1dc224eb714mr2273242637.0.1731037620126; 
 Thu, 07 Nov 2024 19:47:00 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a134f0sm2551974b3a.131.2024.11.07.19.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:46:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 09/15] efi_loader: net: set EFI bootdevice device path to HTTP
 when loaded from wget
Date: Fri,  8 Nov 2024 00:46:54 -0300
Message-ID: <20241108034654.346401-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_loader.h             |  6 ++++++
 lib/efi_loader/efi_device_path.c |  2 +-
 lib/efi_loader/efi_net.c         | 22 +++++++++++++++++++++-
 net/lwip/wget.c                  |  1 +
 net/wget.c                       |  1 +
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index ab79364857..c37c1a4660 100644
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
index dc79a61196..d7c874fcdf 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1165,7 +1165,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 				     (uintptr_t)image_addr,
 				     (uintptr_t)image_addr + image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
-		dp = efi_dp_from_eth();
+		efi_net_get_dp((void **)&dp);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index dd84b3f18d..d4570d4d7c 100644
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
@@ -999,6 +1003,22 @@ out_of_resources:
 	return EFI_OUT_OF_RESOURCES;
 }
 
+void efi_net_set_dp(const char *dev, const char *server)
+{
+	if (!strcmp(dev, "Net"))
+		net_dp = efi_dp_from_eth();
+	else if (!strcmp(dev, "Http"))
+		net_dp = efi_dp_from_http(server);
+}
+
+void efi_net_get_dp(void **dp)
+{
+	if (!net_dp)
+		efi_net_set_dp("Net", NULL);
+	if (dp && net_dp)
+		*dp = efi_dp_dup(net_dp);
+}
+
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw)
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 88ce906930..64593d135d 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -218,6 +218,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	print_size(rx_content_len / elapsed * 1000, "/s)\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
 	if (wget_info.set_bootdev) {
+		efi_net_set_dp("Http", ctx->server_name);
 		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
 				rx_content_len);
 	}
diff --git a/net/wget.c b/net/wget.c
index 5bb61a2b8d..3cd9a57647 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -443,6 +443,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		net_set_state(wget_loop_state);
 		wget_info.file_size = net_boot_file_size;
 		if (wget_info.method == WGET_HTTP_METHOD_GET && wget_info.set_bootdev) {
+			efi_net_set_dp("Http", NULL);
 			efi_set_bootdev("Net", "", image_url,
 					map_sysmem(image_load_addr, 0),
 					net_boot_file_size);
-- 
2.43.0

