Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0664D3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6CD895DB;
	Mon, 25 Nov 2024 01:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dP5sB21Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CF5895C5; Mon, 25 Nov 2024 01:58:50 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898F8962A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724e1742d0dso1925790b3a.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496326; x=1733101126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtQVuHCwzL5ocefKcn8ciI3Dlb45fFcMG8CzcHS4gD0=;
 b=dP5sB21Q0MoUkFPmapUBipZb++R6o9ObFPAl/CTUoOd1i33Cz0zgovqH+kO8B+RoHs
 /Qbod9eH22EUWNoibyfbSOl4qf+4evTYx50d966UwmhmwpbrDR2iOKAQTJbXZudZAIk7
 lZpt3tDAMKDdCSKW/UNPmb0sZlmDQ5rMItppKxXJuSE6pZtFTuNIdwBWcGlGeO3tSb6C
 etBd0qMjNZgSveHJFaz5YT4FpblzKcDdFBIk6XpXr3lg11oEFrfYo6m+mg8d+wPifx93
 B4anHKj45EjRYc8YvmcVQWvAVHTJ0X9jSZsVRFtQsdMRKxDb0X5SdZtocLMIYtFO7z/6
 rObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496326; x=1733101126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtQVuHCwzL5ocefKcn8ciI3Dlb45fFcMG8CzcHS4gD0=;
 b=epGOzfs/HBwNBYVIMOLoFGPKu9gnKag/DzincAnaTgRf8EQ3XVcYLndRM0iHGyZ/Mb
 CfTH1sYpU8hf4S5ZIXqbHJXkB+ww+lYbO8VUc2f1P7ZTryUyTAcUb34VFv+IgeojdN1u
 kCqH9dwic1lwgGcKMRP2Mmm+8fjfIWUr9loI+TNOrBOVvLaz0D+K9EU7/sH2KogZtXMV
 WIEOMa/f43FQ/+51TsLUnH0zraPX+0zwcuKlKMzjK8z8oH6LBUsMQqwVhGQ55UtKTBp1
 RAegFahgZAqiW2WsOKaUIGBJLlXfKuG9J8mjAc16YEL32Boy2ob0uVRDUGZ3K+XVeTmi
 8VeQ==
X-Gm-Message-State: AOJu0Yyb1ngps95ndPbfBfwUfWgVAnjSj5tDr9LnlIzE/tQXQevg8oRq
 Yu2cJ+mHIubwhonZJ9nUg1IwHRiX4nnAcaT/ONy2/OL9WLOooFAtZwBkYn44M6s=
X-Gm-Gg: ASbGncs8trCR8iJdG7mWw/INQTjV678eAiVjxXn+yW+y7jYV2huvdvMvRdjwb+HFwgN
 dnPnKSahHw/vIFnqvEBMNzrW69brPvsVHUIjlOg6le3zqq0d3fgheOjsMITwFTTyaor00A9xqkk
 mVvN2+7QXsj4YH90hqZ7ke0XvqmQQYVpk+huhFtCoyOfTQblGQaed6hbt87si5k/S2+6QVw24m9
 6Z9nO1X5wCs2VlIK4m/l4zDWrv7gQL6TflVvVv/dwT/
X-Google-Smtp-Source: AGHT+IHaBNXVfVSpKL/3qplrxB+aOpJpskHUdEG/tmiBVR81vkB8zKYC90gAWqbKcXJP2z4eNNj6uw==
X-Received: by 2002:a05:6a00:1709:b0:71e:98a:b6b4 with SMTP id
 d2e1a72fcca58-724df5ef7f8mr12138826b3a.11.1732496325916; 
 Sun, 24 Nov 2024 16:58:45 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:45 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 08/14] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Sun, 24 Nov 2024 21:58:08 -0300
Message-ID: <20241125005814.236669-9-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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
Changes in v5:
- Add description of net_dp
- Change a void** for an efi_device_path**
(no changes since v2)

 include/efi_loader.h             |  6 +++++
 lib/efi_loader/efi_device_path.c |  2 +-
 lib/efi_loader/efi_net.c         | 44 +++++++++++++++++++++++++++++++-
 net/lwip/wget.c                  |  1 +
 net/wget.c                       |  1 +
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 96b204dfc3..8e7f5becbb 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 #endif
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
+/* Call this to update the current device path of the efi net device */
+void efi_net_set_dp(const char *dev, const char *server);
+/* Call this to get the current device path of the efi net device */
+void efi_net_get_dp(struct efi_device_path **dp);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
@@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
 #else
+static inline void efi_net_set_dp(const char *dev, const char *server) { }
+static inline void efi_net_get_dp(struct efi_device_path **dp) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
 				     struct efi_ipv4_address *gw) { }
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 1e512bf0ea..be0b56d213 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1181,7 +1181,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
-		dp = efi_dp_from_eth();
+		efi_net_get_dp(&dp);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 3491d4c481..b448dcee51 100644
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
@@ -999,6 +1009,38 @@ out_of_resources:
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
+void efi_net_get_dp(struct efi_device_path **dp)
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
index 3347a61e74..7bc7c6a2fe 100644
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
index 4bb1590410..21d3b8050a 100644
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

