Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE47D5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9688929D;
	Fri,  8 Nov 2024 16:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0icKfl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 855DD88ECB; Fri,  8 Nov 2024 14:40:13 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B6788D47
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21116b187c4so18573205ad.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073210; x=1731678010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dah8NkQoEMullZcAUwqNFDEZntck6VxElXa4/qdW9tI=;
 b=P0icKfl1uaTmm2LINKo0F0Yt2ai4wma2e3FMRFk7m1eSKrrI1mwmNiWWMagjpehA3h
 dO2tNRsWh6uPLwYxqWaFaGQyrDJz7znZ5g8zHBaauRFv+h1fmk1xTvubHTGc8rPfr3G+
 lPfMoIKCi0sC65bwnsn4ALKLpskifW7mS0zT4CTGQXOxWv9hiZxvDYONCblzzJyJiEdZ
 Fzga/f2RDrLmNExPmhaQks8QbwqlYAUpj565d9VxkqBRJ2t46eOngdXWCPxmRB27ThmA
 tii/s+UA6e6qSRADh+001Yr7DkyZBn2CI/NAzTotRbM1WSn9fgRHwRt+00vFR1A5TX5B
 yGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073210; x=1731678010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dah8NkQoEMullZcAUwqNFDEZntck6VxElXa4/qdW9tI=;
 b=Q+I4y844+b+bYJkXFXJ2sjIdtWUHRsngWdnZsf6nuweQc2zEGxms0dnQwG39ajtalL
 K3pxMZnHTFwGuKXyv+4vqolk1a9Pcs/A00l/DzmzFkSlIfWuva1xIE24NEAA3z3yH/7Y
 I4BpPpEhjIhzChEnRE7oJCpeqkDmSKJjcjhL3aFYjj/YxaFS0fbbkLkuciOM7DX8qOls
 frVEN7zKISL0Eb6zkNyopE490WfxblAHh/YgNgKlJNMKJrCdLbRH/WG9Z5vTwuaJ/cbx
 HWWkyc3ndMdelSryz2Lfn3K5NH4bprQg+2z+JHHydU1xYPH3K58mFtYQ2d/4YIUBlop7
 8oxw==
X-Gm-Message-State: AOJu0YwkCE76v5XBEeC0HgjlpaxwHkKYsujVqVUf9BzE/Ehv2ydxHscC
 5nJxQomTedy9Z/QH/FWJBWH5i4XVKpbn+GY3TijrLy1ALomcPvLt1Sfe37yCGck=
X-Google-Smtp-Source: AGHT+IHTbm1auTyrfiZ03kkEMZzXKF4UU0igwLd7/rIxP+s/6jTdxzPELIfX2d47rBQpvApjyk+gnw==
X-Received: by 2002:a17:903:244c:b0:20c:89b1:e76c with SMTP id
 d9443c01a7336-21183da4ddamr31501765ad.30.1731073209708; 
 Fri, 08 Nov 2024 05:40:09 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:40:09 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 09/15] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Fri,  8 Nov 2024 10:38:44 -0300
Message-ID: <20241108133850.431075-10-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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
index 1b6f031b72..6e5a0fe1fc 100644
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

