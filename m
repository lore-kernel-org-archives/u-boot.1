Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B09D41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E7F893F0;
	Tue, 12 Nov 2024 03:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ivpLaiO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEE089393; Mon, 11 Nov 2024 22:10:27 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7E689308
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cb47387ceso50925455ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359423; x=1731964223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8oCQPlR7IZ2H4OxgGCrWLdLPTWFoK4/m7dblkApzJI=;
 b=ivpLaiO+gAeaXlPf1Elfm54mxTAOUwrTwqWMvWl8+vSp5YYbLt2WVMRoInrtjl1ol5
 oTQm80/mhw74+mi1HznoQV0VVCvr4trbpeIZDoOiqEzjyWp0IgqsqR+aQbOtOOX0CVVx
 GZVClTmg1QTAcc0i8EwcWFqP/G+fglVRDjGIOnFNgCKi+JW3D0oRyHv6Ry1/KXtyyAul
 QhcGEv5w7HxrGNUUs40bsfHSOMnsW2UWpuRy+ucCeKaDbhKUXtAq4m9FkHP94bcbhC5o
 axWsxtGRfcNS0MBTOmgsxaVHtM4HTaAO8asgnw21c/n8oqNNM6Vo/hutfPcKI5EfKPQn
 N/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359423; x=1731964223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8oCQPlR7IZ2H4OxgGCrWLdLPTWFoK4/m7dblkApzJI=;
 b=nvWmdH2ijAfaksHxRhuWt9SfxzkgOu+YHJG7Q41FDQxgR8VZ9RgLq1Trr2crvCc65H
 BqEt1x/cXie0rxJk0oAd2tK1TRO7MY+n9OG8b8IYTfolIgX9rlkr8ow2rK3jIU0oqASK
 dQw3fGXBc3VC25W59IJSRWZfsNvnC2gjXn8IjZWbBp+rTY2UcvAuBUrxWAx8q7v/U0x6
 bWfSNr8Wey5OVHkgIsEg5enp2dUqseYDQ+AzLpd2o09Mf2q5Uoev2fCa0ZI9Ekm6I9s5
 jKmd9xdH3yfFsg/sFQJ1Hzs71muNAYpLci3zO/ziwueFynul/GaN3KveqxrN2yYGF5E0
 6c1A==
X-Gm-Message-State: AOJu0YxfADRm5IARoIUlVNPZgL6yvAcbDm/zmq+ttbdBtUQC8oe9wEfh
 2kd0JNvcc3IvOwyKcoKuUmtFjf/uid2vgXsapGI0VVm1yCMx5Ar2iFhDhlJS
X-Google-Smtp-Source: AGHT+IH9ZX/e7Imz01KcMl9IragSPr0EdNPv9HWU3S8+FgM6JNqGQo2PpjzZ1T3IiYKnzPU+neJPYQ==
X-Received: by 2002:a17:903:2b08:b0:20c:f292:3a21 with SMTP id
 d9443c01a7336-21183507b88mr189589315ad.15.1731359423580; 
 Mon, 11 Nov 2024 13:10:23 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:23 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 09/15] efi_loader: net: set EFI bootdevice device path to
 HTTP when loaded from wget
Date: Mon, 11 Nov 2024 18:09:53 -0300
Message-ID: <20241111210959.560738-10-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

(no changes since v2)

 include/efi_loader.h             |  6 ++++++
 lib/efi_loader/efi_device_path.c |  2 +-
 lib/efi_loader/efi_net.c         | 22 +++++++++++++++++++++-
 net/lwip/wget.c                  |  1 +
 net/wget.c                       |  1 +
 5 files changed, 30 insertions(+), 2 deletions(-)

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
index 158f08b9e5..afb4abc3ff 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1168,7 +1168,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 				     (uintptr_t)image_addr, image_size);
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
index 36158e0a9c..676d4db759 100644
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

