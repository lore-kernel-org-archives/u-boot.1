Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E86C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED262809D2;
	Wed, 22 Jan 2025 18:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HBmhbH/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FC680BA8; Wed, 22 Jan 2025 18:09:27 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289D3809A5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso115010535ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565764; x=1738170564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chW+aX1GZZ/0Nf3wCz3wIFDHg3maEHC+Lb7jK85JwIQ=;
 b=HBmhbH/aligk6id99PnApgJ8zzyAmx6HEqBT+szzBApAQ+kOqVMVmyN/vsj38hbvHQ
 xnhKNQLs/avhXieykMl/vZhGJoKoScSaJlcUOfywlQe6RwgtHgTbb5yxVaDagjvJ688Z
 zCyWSrpDBb5O6002uP+3XxspUCNY7rzYzHQrkEfu8gU90ymMCEtsGuoIG7dfw8/Wrhwd
 7QoW4RJrfls7g/hgf41CM6SW2GkwgB2IEf3Yer7gAGLXOd/GM+IorxJAHXezBYBILJQp
 CBmfMZUhhv0IceM97Vnma0i8Wbs3T3YQnwYDV8lC8omAWObRhR3dio+LpRa8mzJdbSdK
 WMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565764; x=1738170564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chW+aX1GZZ/0Nf3wCz3wIFDHg3maEHC+Lb7jK85JwIQ=;
 b=ezuk6qnBH1sNeJOVyIS0X1/ZxV3kva+NYPwIFZ86IRFBrN4mGMxfUnwcn5t9weczPZ
 B36gnQGCGiCpEVkquEYMWYNhK8Q9NHYJPCA1dm2y2EX7AbRbpqY2V5WMi0KbIe05fcy3
 Bzq6HI02Obyz97NrtWknzfJLNfiT31YFsWoRbaMLRfWpHvpSmHT2wGjDPhxMjNMxyAum
 w3otfXPDQzaB7NhJgnfOBF10hZOqbIu9p4BVAiYlKIyT0bg2d6AM7nk2VrkjhwI+JQQ6
 r5cLC+FrIxxY5ASqP4+wF+coSPS/6nj8FLuaiXM4iQweRmbQDUJIDETum0KXBieoMhRC
 rOPw==
X-Gm-Message-State: AOJu0YyfjNQUNNv2wzYQci88SWMLrWA4EuuQyHrpkR9mponqCeXtYRyI
 q+6eFKO6pMLRdeIzSAdUqzIuDsbiuap+gsgCk3OAq3VuLlneTyZpseX556or
X-Gm-Gg: ASbGncvdjGG5o31ls/z8hr/0yI1HwLCZXWsVyahrq4GPmDMWfjn5D20S844+XhCNfr3
 PUdYs/m7k2ieWNvXVim6OnGYEkn4gwQTBCRbZn4BPxLtaVgz6hdoGE9sfjecbsOXbX23vI4W7AU
 RCdRafU6LgQMkP5x2ebPOSTqCQzYOAV43CJOtjfqhj60wjOYGMOqcScOwKMuZWG/g3jOPy1dbav
 3UtMkMjbq9jqeS2znA5t65edVKY9k6tdasNfIoEJ3gDi6agU4/sK5wVoJ6FL9KiTPPuuoA7an0/
 xA==
X-Google-Smtp-Source: AGHT+IHuKParggkUy3nYgV5+nUZz7jugSq1vdtxsMlGN3XcDP3KLUsnqq69MLka63JoXeUFxjeAeIQ==
X-Received: by 2002:a17:902:d50c:b0:21a:8dec:e59f with SMTP id
 d9443c01a7336-21c355c28f0mr273183955ad.39.1737565763633; 
 Wed, 22 Jan 2025 09:09:23 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:23 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 05/21] efi_loader: efi_device_path: Let network device paths
 receive the net udevice as an argument
Date: Wed, 22 Jan 2025 14:08:42 -0300
Message-ID: <20250122170858.961359-6-adriano.cordova@canonical.com>
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

Support setting the device path with efi_dp_from_eth, efi_dp_from_ipv4,
and efi_dp_from_http to an ethernet device other than the current
ethernet udevice. Calling eth_dp_from_eth with eth_get_dev() as the
argument recovers the pevious functionality.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h             | 10 +++++-----
 lib/efi_loader/efi_bootbin.c     |  3 ++-
 lib/efi_loader/efi_device_path.c | 21 ++++++++++++---------
 lib/efi_loader/efi_net.c         | 24 ++++++++++++++----------
 4 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 97152bbb6a..8be52e2766 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -128,9 +128,9 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
 /* Call this to update the current device path of the efi net device */
-efi_status_t efi_net_set_dp(const char *dev, const char *server);
+efi_status_t efi_net_set_dp(const char *dev, const char *server, struct udevice *udev);
 /* Call this to get the current device path of the efi net device */
-void efi_net_get_dp(struct efi_device_path **dp);
+void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
@@ -150,7 +150,7 @@ struct http_header {
 
 void efi_net_parse_headers(ulong *num_headers, struct http_header *headers);
 #else
-static inline void efi_net_get_dp(struct efi_device_path **dp) { }
+static inline void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
 				     struct efi_ipv4_address *gw) { }
@@ -918,8 +918,8 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
-struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_http(const char *server);
+struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
+struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					size_t size);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b677bbc312..b6b40c030f 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -13,6 +13,7 @@
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
+#include <net.h>
 
 static struct efi_device_path *bootefi_image_path;
 static struct efi_device_path *bootefi_device_path;
@@ -95,7 +96,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 
 #if IS_ENABLED(CONFIG_NETDEVICES)
 	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
-		ret = efi_net_set_dp(dev, devnr);
+		ret = efi_net_set_dp(dev, devnr, eth_get_dev());
 		if (ret != EFI_SUCCESS)
 			goto error;
 	}
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index c0633a736b..4a5d50fdf5 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -954,20 +954,20 @@ struct efi_device_path *efi_dp_from_uart(void)
 	return buf;
 }
 
-struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
+struct efi_device_path __maybe_unused *efi_dp_from_eth(struct udevice *dev)
 {
 	void *buf, *start;
 	unsigned dpsize = 0;
 
-	assert(eth_get_dev());
+	assert(dev);
 
-	dpsize += dp_size(eth_get_dev());
+	dpsize += dp_size(dev);
 
 	start = buf = efi_alloc(dpsize + sizeof(END));
 	if (!buf)
 		return NULL;
 
-	buf = dp_fill(buf, eth_get_dev());
+	buf = dp_fill(buf, dev);
 
 	*((struct efi_device_path *)buf) = END;
 
@@ -984,11 +984,13 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
  * @ip:		IPv4 local address
  * @mask:	network mask
  * @srv:	IPv4 remote/server address
+ * @dev:	net udevice
  * Return:	pointer to device path, NULL on error
  */
 static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 					 struct efi_ipv4_address *mask,
-					 struct efi_ipv4_address *srv)
+					 struct efi_ipv4_address *srv,
+					 struct udevice *dev)
 {
 	struct efi_device_path *dp1, *dp2, *pos;
 	struct {
@@ -1010,7 +1012,7 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	pos = &dp.end;
 	memcpy(pos, &END, sizeof(END));
 
-	dp1 = efi_dp_from_eth();
+	dp1 = efi_dp_from_eth(dev);
 	if (!dp1)
 		return NULL;
 
@@ -1029,9 +1031,10 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
  * and an END node.
  *
  * @server:	URI of remote server
+ * @dev:	net udevice
  * Return:	pointer to HTTP device path, NULL on error
  */
-struct efi_device_path *efi_dp_from_http(const char *server)
+struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev)
 {
 	struct efi_device_path *dp1, *dp2;
 	struct efi_device_path_uri *uridp;
@@ -1047,7 +1050,7 @@ struct efi_device_path *efi_dp_from_http(const char *server)
 
 	efi_net_get_addr(&ip, &mask, NULL);
 
-	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
 	if (!dp1)
 		return NULL;
 
@@ -1186,7 +1189,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) &&
 		   (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
-		efi_net_get_dp(&dp);
+		efi_net_get_dp(&dp, eth_get_dev());
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index f0cf317d4f..a399f6f593 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -949,10 +949,12 @@ efi_status_t efi_net_register(void)
 			     &netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-	if (!net_dp)
-		efi_net_set_dp("Net", NULL);
-	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
-			     net_dp);
+
+	if (net_dp)
+		r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+				     net_dp);
+	else
+		r = efi_net_set_dp("Net", NULL, eth_get_dev());
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
@@ -1068,17 +1070,18 @@ out_of_resources:
  *
  * @dev:	dev to set the device path from
  * @server:	remote server address
+ * @udev:	net udevice
  * Return:	status code
  */
-efi_status_t efi_net_set_dp(const char *dev, const char *server)
+efi_status_t efi_net_set_dp(const char *dev, const char *server, struct udevice *udev)
 {
 	efi_free_pool(net_dp);
 
 	net_dp = NULL;
 	if (!strcmp(dev, "Net"))
-		net_dp = efi_dp_from_eth();
+		net_dp = efi_dp_from_eth(udev);
 	else if (!strcmp(dev, "Http"))
-		net_dp = efi_dp_from_http(server);
+		net_dp = efi_dp_from_http(server, udev);
 
 	if (!net_dp)
 		return EFI_OUT_OF_RESOURCES;
@@ -1091,14 +1094,15 @@ efi_status_t efi_net_set_dp(const char *dev, const char *server)
  *
  * Produce a copy of the current device path
  *
- * @dp:		copy of the current device path, or NULL on error
+ * @dp:		copy of the current device path
+ * @udev:	net udevice
  */
-void efi_net_get_dp(struct efi_device_path **dp)
+void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev)
 {
 	if (!dp)
 		return;
 	if (!net_dp)
-		efi_net_set_dp("Net", NULL);
+		efi_net_set_dp("Net", NULL, udev);
 	if (net_dp)
 		*dp = efi_dp_dup(net_dp);
 }
-- 
2.43.0

