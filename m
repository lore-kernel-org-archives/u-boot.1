Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF527C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4805480C69;
	Wed, 22 Jan 2025 18:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+XX/eBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C645809A5; Wed, 22 Jan 2025 18:09:31 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189D580977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216401de828so124781965ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565766; x=1738170566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKbMtj+YfqHK6TVChSj3kARgRuZL04ETmaANSy42otk=;
 b=l+XX/eBL3rrPHFpkCGC/TkNVkt1cRnyH2cOAOOG5LVep3YwTBceMpc4HPRYq8haeBm
 Fr7JL05vyrx5vMPaVj1BoZ3d+9K/ZQM+EoR7oBNVKrdw9ZgWgQQ7KAgkmoL44CWHS2iX
 qLqsgn5tC7RvXgW5DD/hPLrLBaOaAAEcQMYBT7NdGg61I53lSZDlPwljdrt0wcjizjCp
 0BVM4ywuAtQ7f5ZahHxRPEWi4Zc/gR6aY0M6vc5gk6SaiDDq0NTEdwuFirl/Fj8WoUG7
 +cX7YGEjmqerPpo4seLXF9gbbERhBguOhr2nbXZ67pdSQF0rETyzUUo5SoC4voHz0Fw9
 dWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565766; x=1738170566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKbMtj+YfqHK6TVChSj3kARgRuZL04ETmaANSy42otk=;
 b=gxO96t03Q7zuOQuHVdaBgLY+f/VV+TdKo7lgpo+EUwFqN3a1ki+Zs0rBeuDIj1CMg9
 JqwUTAqxvgVzMoWjK4rYR9hZMMe4Bh3Shr/hdxOSXAmHd9j9si0hsrrXuCbW5TQ2EPCs
 nRYblvWrIG7gO8SXRHI0GNVNi3AC8NGGcD6yNKCyRJ9UfKARBrTOJmteVzHhgVdOqGqq
 3prtIXkeC+znE9bRu6BL5X0TCEnyuBme0CcDzkeMSDlMx0/t+wJfMLBew07Wb+P64lQn
 lcF68LbYbkvMSOx1JWTb1wwRYtkoxaGE/01nf77bZOzHC+P6LO6qsudpXh1yWPDwvfGx
 ryZg==
X-Gm-Message-State: AOJu0Yy94Zm5/Gk7ut3aPzIKIYuGmuBRQ330TN7R3N4ePgChxUF8wjQJ
 IsLoN855LemVDyqpsSq++JENpa4JzXMVcifuTRpteknsR0M8IpOjLnRezJP0
X-Gm-Gg: ASbGncs0Av0DrwTBPclP/pWv/fAYwArR48J3VKpL0cDkJoJOulh6Pkv/4Fc9i9NtPBb
 /oio6cX3PxFjwi8JKfsqBYUf4SzyfdZVket/slFuIuqRL8Go4NYW9LoN79dYyiTm8W+SGb1enTN
 JODNk88UwcxFNe1FCPMukIjNLtvv1N2z57cxMBHR+OQ7wH0vuUeCV0HfKPybHgmq6eqh60pnI9K
 Jr/XzGkjfuWmmUlnaW74Z0GmCA8shpWnXIZHVWmmStEilJcEkNC28n2yMw5JSmmPmXIrltPe0yk
 nA==
X-Google-Smtp-Source: AGHT+IEBc3mXA53C5ocYIHsUGHBvN6o2JG3seWQvA+7J5MXkrdduOO/JDtdCOUgoAW7ou0vl75jOtQ==
X-Received: by 2002:a17:903:2291:b0:208:d856:dbb7 with SMTP id
 d9443c01a7336-21c355b7732mr309963505ad.39.1737565766273; 
 Wed, 22 Jan 2025 09:09:26 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:25 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 06/21] efi_loader: efi_net: Add support for multiple
 efi_net_obj
Date: Wed, 22 Jan 2025 14:08:43 -0300
Message-ID: <20250122170858.961359-7-adriano.cordova@canonical.com>
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

Add support for multiple efi_net_obj structs

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h             |  28 +-
 lib/efi_loader/efi_bootbin.c     |   2 +-
 lib/efi_loader/efi_device_path.c |   4 +-
 lib/efi_loader/efi_http.c        |   6 +-
 lib/efi_loader/efi_ipconfig.c    |   5 +-
 lib/efi_loader/efi_net.c         | 543 +++++++++++++++++++++++++------
 lib/efi_loader/efi_setup.c       |   5 +-
 7 files changed, 467 insertions(+), 126 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 8be52e2766..0d6b01fcfc 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -128,17 +128,22 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 
 #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
 /* Call this to update the current device path of the efi net device */
-efi_status_t efi_net_set_dp(const char *dev, const char *server, struct udevice *udev);
+efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev);
 /* Call this to get the current device path of the efi net device */
-void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev);
+void efi_net_dp_from_dev(struct efi_device_path **dp, struct udevice *udev, bool cache_only);
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw);
+		      struct efi_ipv4_address *gw,
+			  struct udevice *dev);
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw);
+		      struct efi_ipv4_address *gw,
+			  struct udevice *dev);
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
-				u32 *status_code, ulong *file_size, char *headers_buffer);
+				u32 *status_code, ulong *file_size, char *headers_buffer,
+				struct efi_service_binding_protocol *parent);
+#endif
 #define MAX_HTTP_HEADERS_SIZE SZ_64K
 #define MAX_HTTP_HEADERS 100
 #define MAX_HTTP_HEADER_NAME 128
@@ -150,13 +155,16 @@ struct http_header {
 
 void efi_net_parse_headers(ulong *num_headers, struct http_header *headers);
 #else
-static inline void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev) { }
+static inline void efi_net_dp_from_dev(struct efi_device_path **dp,
+				       struct udevice *udev, bool cache_only) { }
 static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
-				     struct efi_ipv4_address *gw) { }
+				     struct efi_ipv4_address *gw,
+					 struct udevice *dev) { }
 static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
 				     struct efi_ipv4_address *mask,
-				     struct efi_ipv4_address *gw) { }
+				     struct efi_ipv4_address *gw,
+					 struct udevice *dev) { }
 #endif
 
 /* Maximum number of configuration tables */
@@ -627,8 +635,8 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 /* Called by bootefi to make GOP (graphical) interface available */
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
-efi_status_t efi_net_register(void);
-efi_status_t efi_net_do_start(void);
+efi_status_t efi_net_register(struct udevice *dev);
+efi_status_t efi_net_do_start(struct udevice *dev);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b6b40c030f..8a17c48a39 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -96,7 +96,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 
 #if IS_ENABLED(CONFIG_NETDEVICES)
 	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
-		ret = efi_net_set_dp(dev, devnr, eth_get_dev());
+		ret = efi_net_new_dp(dev, devnr, eth_get_dev());
 		if (ret != EFI_SUCCESS)
 			goto error;
 	}
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 4a5d50fdf5..e26f9a1ee0 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1048,7 +1048,7 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
 	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
 		return NULL;
 
-	efi_net_get_addr(&ip, &mask, NULL);
+	efi_net_get_addr(&ip, &mask, NULL, dev);
 
 	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
 	if (!dp1)
@@ -1189,7 +1189,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) &&
 		   (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
-		efi_net_get_dp(&dp, eth_get_dev());
+		efi_net_dp_from_dev(&dp, eth_get_dev(), false);
 	} else if (!strcmp(dev, "Uart")) {
 		dp = efi_dp_from_uart();
 	} else {
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 694e199341..20450604ec 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -34,6 +34,7 @@ static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
 struct efi_http_instance {
 	struct efi_http_protocol http;
 	efi_handle_t handle;
+	struct efi_service_binding_protocol *parent;
 	bool configured;
 	void *http_load_addr;
 	ulong file_size;
@@ -186,7 +187,7 @@ static efi_status_t EFIAPI efi_http_configure(struct efi_http_protocol *this,
 
 	if (!ipv4_node->use_default_address) {
 		efi_net_set_addr((struct efi_ipv4_address *)&ipv4_node->local_address,
-				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL);
+				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL, NULL);
 	}
 
 	http_instance->current_offset = 0;
@@ -241,7 +242,7 @@ static efi_status_t EFIAPI efi_http_request(struct efi_http_protocol *this,
 
 	ret = efi_net_do_request(url_8, current_method, &http_instance->http_load_addr,
 				 &http_instance->status_code, &http_instance->file_size,
-				 http_instance->headers_buffer);
+				 http_instance->headers_buffer, http_instance->parent);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -406,6 +407,7 @@ static efi_status_t EFIAPI efi_http_service_binding_create_child(
 		goto failure_to_add_protocol;
 	}
 
+	new_instance->parent = this;
 	efi_add_handle(new_instance->handle);
 	*child_handle = new_instance->handle;
 
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
index 0b247a4c02..10035e8a7b 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -58,7 +58,7 @@ static efi_status_t EFIAPI efi_ip4_config2_set_data(struct efi_ip4_config2_proto
 			memcpy((void *)&current_http_ip, data,
 			       sizeof(struct efi_ip4_config2_manual_address));
 			efi_net_set_addr(&current_http_ip.address,
-					 &current_http_ip.subnet_mask, NULL);
+					 &current_http_ip.subnet_mask, NULL, NULL);
 			return EFI_EXIT(EFI_SUCCESS);
 		}
 		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
@@ -131,7 +131,8 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
 		}
 
-		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL);
+		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask,
+				 NULL, NULL);
 		memcpy(data, (void *)&current_http_ip,
 		       sizeof(struct efi_ip4_config2_manual_address));
 
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index a399f6f593..da0dabd383 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -22,24 +22,13 @@
 #include <vsprintf.h>
 #include <net.h>
 
+#define MAX_EFI_NET_OBJS 10
+#define MAX_NUM_DHCP_ENTRIES 10
+#define MAX_NUM_DP_ENTRIES 10
+
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
-static struct efi_pxe_packet *dhcp_ack;
-static void *new_tx_packet;
-static void *transmit_buffer;
-static uchar **receive_buffer;
-static size_t *receive_lengths;
-static int rx_packet_idx;
-static int rx_packet_num;
-static struct efi_net_obj *netobj;
-
-/*
- * The current network device path. This device path is updated when a new
- * bootfile is downloaded from the network. If then the bootfile is loaded
- * as an efi image, net_dp is passed as the device path of the loaded image.
- */
-static struct efi_device_path *net_dp;
 
 static struct wget_http_info efi_wget_info = {
 	.set_bootdev = false,
@@ -47,20 +36,35 @@ static struct wget_http_info efi_wget_info = {
 
 };
 
+struct dhcp_entry {
+	struct efi_pxe_packet *dhcp_ack;
+	struct udevice *dev;
+	bool is_valid;
+};
+
+static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
+static int next_dhcp_entry;
+
+struct dp_entry {
+	struct efi_device_path *net_dp;
+	struct udevice *dev;
+	bool is_valid;
+};
+
 /*
- * The notification function of this event is called in every timer cycle
- * to check if a new network packet has been received.
- */
-static struct efi_event *network_timer_event;
-/*
- * This event is signaled when a packet has been received.
+ * The network device path cache. An entry is added when a new bootfile
+ * is downloaded from the network. If the bootfile is then loaded as an
+ * efi image, the most recent entry corresponding to the device is passed
+ * as the device path of the loaded image.
  */
-static struct efi_event *wait_for_packet;
+static struct dp_entry dp_cache[MAX_NUM_DP_ENTRIES];
+static int next_dp_entry;
 
 /**
  * struct efi_net_obj - EFI object representing a network interface
  *
  * @header:			EFI object header
+ * @dev:			net udevice
  * @net:			simple network protocol interface
  * @net_mode:			status of the network interface
  * @pxe:			PXE base code protocol interface
@@ -70,6 +74,7 @@ static struct efi_event *wait_for_packet;
  */
 struct efi_net_obj {
 	struct efi_object header;
+	struct udevice *dev;
 	struct efi_simple_network net;
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
@@ -80,8 +85,61 @@ struct efi_net_obj {
 #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 	struct efi_service_binding_protocol http_service_binding;
 #endif
+	void *new_tx_packet;
+	void *transmit_buffer;
+	uchar **receive_buffer;
+	size_t *receive_lengths;
+	int rx_packet_idx;
+	int rx_packet_num;
+	/*
+	 * This event is signaled when a packet has been received.
+	 */
+	struct efi_event *wait_for_packet;
+	/*
+	 * The notification function of this event is called in every timer cycle
+	 * to check if a new network packet has been received.
+	 */
+	struct efi_event *network_timer_event;
+	int efi_seq_num;
 };
 
+static int curr_efi_net_obj;
+static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
+
+/**
+ * efi_netobj_is_active() - checks if a netobj is active in the efi subsystem
+ *
+ * @netobj:	pointer to efi_net_obj
+ * Return:	true if active
+ */
+static bool efi_netobj_is_active(struct efi_net_obj *netobj)
+{
+	if (!netobj || !efi_search_obj(&netobj->header))
+		return false;
+
+	return true;
+}
+
+/*
+ * efi_netobj_from_snp() - get efi_net_obj from simple network protocol
+ *
+ *
+ * @snp:	pointer to the simple network protocol
+ * Return:	pointer to efi_net_obj, NULL on error
+ */
+static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
+{
+	int i;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && &net_objs[i]->net == snp) {
+			// Do not register duplicate devices
+			return net_objs[i];
+		}
+	}
+	return NULL;
+}
+
 /*
  * efi_net_start() - start the network interface
  *
@@ -95,20 +153,22 @@ struct efi_net_obj {
 static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
-
 	/* Check parameters */
 	if (!this) {
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	if (this->mode->state != EFI_NETWORK_STOPPED) {
 		ret = EFI_ALREADY_STARTED;
 	} else {
 		this->int_status = 0;
-		wait_for_packet->is_signaled = false;
+		nt->wait_for_packet->is_signaled = false;
 		this->mode->state = EFI_NETWORK_STARTED;
 	}
 out:
@@ -128,6 +188,7 @@ out:
 static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
 
@@ -137,13 +198,17 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	if (this->mode->state == EFI_NETWORK_STOPPED) {
 		ret = EFI_NOT_STARTED;
 	} else {
 		/* Disable hardware and put it into the reset state */
+		eth_set_dev(nt->dev);
+		env_set("ethact", eth_get_name());
 		eth_halt();
 		/* Clear cache of packets */
-		rx_packet_num = 0;
+		nt->rx_packet_num = 0;
 		this->mode->state = EFI_NETWORK_STOPPED;
 	}
 out:
@@ -167,6 +232,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 {
 	int ret;
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
 
@@ -175,6 +241,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		r = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	nt = efi_netobj_from_snp(this);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -187,14 +254,13 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 
 	/* Setup packet buffers */
 	net_init();
-	/* Disable hardware and put it into the reset state */
-	eth_halt();
 	/* Clear cache of packets */
-	rx_packet_num = 0;
-	/* Set current device according to environment variables */
-	eth_set_current();
+	nt->rx_packet_num = 0;
+	/* Set the net device corresponding to the efi net object */
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
 	/* Get hardware ready for send and receive operations */
-	ret = eth_init();
+	ret = eth_start_udev(nt->dev);
 	if (ret < 0) {
 		eth_halt();
 		this->mode->state = EFI_NETWORK_STOPPED;
@@ -202,7 +268,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		goto out;
 	} else {
 		this->int_status = 0;
-		wait_for_packet->is_signaled = false;
+		nt->wait_for_packet->is_signaled = false;
 		this->mode->state = EFI_NETWORK_INITIALIZED;
 	}
 out:
@@ -263,6 +329,7 @@ out:
 static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
 
@@ -271,6 +338,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	nt = efi_netobj_from_snp(this);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -283,9 +351,12 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		goto out;
 	}
 
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
 	eth_halt();
+
 	this->int_status = 0;
-	wait_for_packet->is_signaled = false;
+	nt->wait_for_packet->is_signaled = false;
 	this->mode->state = EFI_NETWORK_STARTED;
 
 out:
@@ -461,6 +532,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 					      u32 *int_status, void **txbuf)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
 
@@ -472,6 +544,8 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
 		ret = EFI_NOT_STARTED;
@@ -488,9 +562,9 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		this->int_status = 0;
 	}
 	if (txbuf)
-		*txbuf = new_tx_packet;
+		*txbuf = nt->new_tx_packet;
 
-	new_tx_packet = NULL;
+	nt->new_tx_packet = NULL;
 out:
 	return EFI_EXIT(ret);
 }
@@ -517,6 +591,7 @@ static efi_status_t EFIAPI efi_net_transmit
 		 struct efi_mac_address *dest_addr, u16 *protocol)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
 		  (unsigned long)header_size, (unsigned long)buffer_size,
@@ -530,6 +605,8 @@ static efi_status_t EFIAPI efi_net_transmit
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	/* We do not support jumbo packets */
 	if (buffer_size > PKTSIZE_ALIGN) {
 		ret = EFI_INVALID_PARAMETER;
@@ -574,11 +651,14 @@ static efi_status_t EFIAPI efi_net_transmit
 		break;
 	}
 
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
+
 	/* Ethernet packets always fit, just bounce */
-	memcpy(transmit_buffer, buffer, buffer_size);
-	net_send_packet(transmit_buffer, buffer_size);
+	memcpy(nt->transmit_buffer, buffer, buffer_size);
+	net_send_packet(nt->transmit_buffer, buffer_size);
 
-	new_tx_packet = buffer;
+	nt->new_tx_packet = buffer;
 	this->int_status |= EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
 out:
 	return EFI_EXIT(ret);
@@ -609,6 +689,7 @@ static efi_status_t EFIAPI efi_net_receive
 	struct ethernet_hdr *eth_hdr;
 	size_t hdr_size = sizeof(struct ethernet_hdr);
 	u16 protlen;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
 		  buffer_size, buffer, src_addr, dest_addr, protocol);
@@ -622,6 +703,8 @@ static efi_status_t EFIAPI efi_net_receive
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
 		ret = EFI_NOT_STARTED;
@@ -633,16 +716,16 @@ static efi_status_t EFIAPI efi_net_receive
 		break;
 	}
 
-	if (!rx_packet_num) {
+	if (!nt->rx_packet_num) {
 		ret = EFI_NOT_READY;
 		goto out;
 	}
 	/* Fill export parameters */
-	eth_hdr = (struct ethernet_hdr *)receive_buffer[rx_packet_idx];
+	eth_hdr = (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_idx];
 	protlen = ntohs(eth_hdr->et_protlen);
 	if (protlen == 0x8100) {
 		hdr_size += 4;
-		protlen = ntohs(*(u16 *)&receive_buffer[rx_packet_idx][hdr_size - 2]);
+		protlen = ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_size - 2]);
 	}
 	if (header_size)
 		*header_size = hdr_size;
@@ -652,20 +735,20 @@ static efi_status_t EFIAPI efi_net_receive
 		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
 	if (protocol)
 		*protocol = protlen;
-	if (*buffer_size < receive_lengths[rx_packet_idx]) {
+	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
 		/* Packet doesn't fit, try again with bigger buffer */
-		*buffer_size = receive_lengths[rx_packet_idx];
+		*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
 		ret = EFI_BUFFER_TOO_SMALL;
 		goto out;
 	}
 	/* Copy packet */
-	memcpy(buffer, receive_buffer[rx_packet_idx],
-	       receive_lengths[rx_packet_idx]);
-	*buffer_size = receive_lengths[rx_packet_idx];
-	rx_packet_idx = (rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
-	rx_packet_num--;
-	if (rx_packet_num)
-		wait_for_packet->is_signaled = true;
+	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
+	       nt->receive_lengths[nt->rx_packet_idx]);
+	*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
+	nt->rx_packet_idx = (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
+	nt->rx_packet_num--;
+	if (nt->rx_packet_num)
+		nt->wait_for_packet->is_signaled = true;
 	else
 		this->int_status &= ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
 out:
@@ -682,18 +765,35 @@ out:
  */
 void efi_net_set_dhcp_ack(void *pkt, int len)
 {
-	int maxsize = sizeof(*dhcp_ack);
+	struct efi_pxe_packet **dhcp_ack;
+	struct udevice *dev;
+	int i;
+
+	dhcp_ack = &dhcp_cache[next_dhcp_entry].dhcp_ack;
+
+	/* For now this function gets called only by the current device */
+	dev = eth_get_dev();
 
-	if (!dhcp_ack) {
-		dhcp_ack = malloc(maxsize);
-		if (!dhcp_ack)
+	int maxsize = sizeof(**dhcp_ack);
+
+	if (!*dhcp_ack) {
+		*dhcp_ack = malloc(maxsize);
+		if (!*dhcp_ack)
 			return;
 	}
-	memset(dhcp_ack, 0, maxsize);
-	memcpy(dhcp_ack, pkt, min(len, maxsize));
+	memset(*dhcp_ack, 0, maxsize);
+	memcpy(*dhcp_ack, pkt, min(len, maxsize));
+
+	dhcp_cache[next_dhcp_entry].is_valid = true;
+	dhcp_cache[next_dhcp_entry].dev = dev;
+	next_dhcp_entry++;
+	next_dhcp_entry %= MAX_NUM_DHCP_ENTRIES;
 
-	if (netobj)
-		netobj->pxe_mode.dhcp_ack = *dhcp_ack;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			net_objs[i]->pxe_mode.dhcp_ack = **dhcp_ack;
+		}
+	}
 }
 
 /**
@@ -707,6 +807,11 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 static void efi_net_push(void *pkt, int len)
 {
 	int rx_packet_next;
+	struct efi_net_obj *nt;
+
+	nt = net_objs[curr_efi_net_obj];
+	if (!nt)
+		return;
 
 	/* Check that we at least received an Ethernet header */
 	if (len < sizeof(struct ethernet_hdr))
@@ -717,15 +822,15 @@ static void efi_net_push(void *pkt, int len)
 		return;
 
 	/* Can't store more than pre-alloced buffer */
-	if (rx_packet_num >= ETH_PACKETS_BATCH_RECV)
+	if (nt->rx_packet_num >= ETH_PACKETS_BATCH_RECV)
 		return;
 
-	rx_packet_next = (rx_packet_idx + rx_packet_num) %
+	rx_packet_next = (nt->rx_packet_idx + nt->rx_packet_num) %
 	    ETH_PACKETS_BATCH_RECV;
-	memcpy(receive_buffer[rx_packet_next], pkt, len);
-	receive_lengths[rx_packet_next] = len;
+	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
+	nt->receive_lengths[rx_packet_next] = len;
 
-	rx_packet_num++;
+	nt->rx_packet_num++;
 }
 
 /**
@@ -740,6 +845,7 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 					    void *context)
 {
 	struct efi_simple_network *this = (struct efi_simple_network *)context;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p", event, context);
 
@@ -750,14 +856,19 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 	if (!this || this->mode->state != EFI_NETWORK_INITIALIZED)
 		goto out;
 
-	if (!rx_packet_num) {
+	nt = efi_netobj_from_snp(this);
+	curr_efi_net_obj = nt->efi_seq_num;
+
+	if (!nt->rx_packet_num) {
+		eth_set_dev(nt->dev);
+		env_set("ethact", eth_get_name());
 		push_packet = efi_net_push;
 		eth_rx();
 		push_packet = NULL;
-		if (rx_packet_num) {
+		if (nt->rx_packet_num) {
 			this->int_status |=
 				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
-			wait_for_packet->is_signaled = true;
+			nt->wait_for_packet->is_signaled = true;
 		}
 	}
 out:
@@ -876,17 +987,115 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
 	return EFI_UNSUPPORTED;
 }
 
+/**
+ * efi_netobj_set_dp() - set device path of a netobj
+ *
+ * @netobj:	pointer to efi_net_obj
+ * @dp:		device path to set, allocated by caller
+ * Return:	status code
+ */
+efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_path *dp)
+{
+	efi_status_t ret;
+	struct efi_handler *phandler;
+	struct efi_device_path *new_net_dp;
+
+	if (!efi_netobj_is_active(netobj))
+		return EFI_SUCCESS;
+
+	// Create a device path for the netobj
+	new_net_dp = dp;
+	if (!new_net_dp)
+		return EFI_OUT_OF_RESOURCES;
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	// If the device path protocol is not yet installed, install it
+	if (!phandler)
+		goto add;
+
+	// If it is already installed, try to update it
+	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+					       phandler->protocol_interface, new_net_dp);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return EFI_SUCCESS;
+add:
+	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+			       new_net_dp);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_netobj_get_dp() - get device path of a netobj
+ *
+ * @netobj:	pointer to efi_net_obj
+ * Return:	device path, NULL on error
+ */
+static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
+{
+	struct efi_handler *phandler;
+
+	if (!efi_netobj_is_active(netobj))
+		return NULL;
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	if (phandler && phandler->protocol_interface)
+		return efi_dp_dup(phandler->protocol_interface);
+
+	return NULL;
+}
+
 /**
  * efi_net_do_start() - start the efi network stack
  *
  * This gets called from do_bootefi_exec() each time a payload gets executed.
  *
+ * @dev:	net udevice
  * Return:	status code
  */
-efi_status_t efi_net_do_start(void)
+efi_status_t efi_net_do_start(struct udevice *dev)
 {
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_net_obj *netobj;
+	struct efi_device_path *net_dp;
+	int i;
+
+	netobj = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			netobj = net_objs[i];
+			break;
+		}
+	}
+
+	if (!efi_netobj_is_active(netobj))
+		return r;
+
+	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
+	// If no dp cache entry applies and there already
+	// is a device path installed, continue
+	if (!net_dp) {
+		if (efi_netobj_get_dp(netobj))
+			goto set_addr;
+		else
+			net_dp = efi_dp_from_eth(netobj->dev);
+	}
+
+	if (!net_dp)
+		return EFI_OUT_OF_RESOURCES;
 
+	r = efi_netobj_set_dp(netobj, net_dp);
+	if (r != EFI_SUCCESS)
+		return r;
+set_addr:
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
 	/*
 	 * No harm on doing the following. If the PXE handle is present, the client could
@@ -894,7 +1103,7 @@ efi_status_t efi_net_do_start(void)
 	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
 	 */
 	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, dev);
 #endif
 
 	return r;
@@ -904,27 +1113,53 @@ efi_status_t efi_net_do_start(void)
  * efi_net_register() - register the simple network protocol
  *
  * This gets called from do_bootefi_exec().
+ * @dev:	net udevice
  */
-efi_status_t efi_net_register(void)
+efi_status_t efi_net_register(struct udevice *dev)
 {
 	efi_status_t r;
-	int i;
-
-	if (!eth_get_dev()) {
+	int seq_num;
+	struct efi_net_obj *netobj;
+	void *transmit_buffer;
+	uchar **receive_buffer;
+	size_t *receive_lengths;
+	int i, j;
+
+	if (!dev) {
 		/* No network device active, don't expose any */
 		return EFI_SUCCESS;
 	}
 
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			// Do not register duplicate devices
+			return EFI_SUCCESS;
+		}
+	}
+
+	seq_num = -1;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (!net_objs[i]) {
+			seq_num = i;
+			break;
+		}
+	}
+	if (seq_num < 0)
+		return EFI_OUT_OF_RESOURCES;
+
 	/* We only expose the "active" network device, so one is enough */
 	netobj = calloc(1, sizeof(*netobj));
 	if (!netobj)
 		goto out_of_resources;
 
+	netobj->dev = dev;
+
 	/* Allocate an aligned transmit buffer */
 	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
 	if (!transmit_buffer)
 		goto out_of_resources;
 	transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
+	netobj->transmit_buffer = transmit_buffer;
 
 	/* Allocate a number of receive buffers */
 	receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
@@ -936,10 +1171,13 @@ efi_status_t efi_net_register(void)
 		if (!receive_buffer[i])
 			goto out_of_resources;
 	}
+	netobj->receive_buffer = receive_buffer;
+
 	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
 				 sizeof(*receive_lengths));
 	if (!receive_lengths)
 		goto out_of_resources;
+	netobj->receive_lengths = receive_lengths;
 
 	/* Hook net up to the device list */
 	efi_add_handle(&netobj->header);
@@ -950,13 +1188,6 @@ efi_status_t efi_net_register(void)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
-	if (net_dp)
-		r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
-				     net_dp);
-	else
-		r = efi_net_set_dp("Net", NULL, eth_get_dev());
-	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
 	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
 			     &netobj->pxe);
 	if (r != EFI_SUCCESS)
@@ -977,7 +1208,9 @@ efi_status_t efi_net_register(void)
 	netobj->net.receive = efi_net_receive;
 	netobj->net.mode = &netobj->net_mode;
 	netobj->net_mode.state = EFI_NETWORK_STOPPED;
-	memcpy(netobj->net_mode.current_address.mac_addr, eth_get_ethaddr(), 6);
+	if (dev_get_plat(dev))
+		memcpy(netobj->net_mode.current_address.mac_addr,
+		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
 	netobj->net_mode.hwaddr_size = ARP_HLEN;
 	netobj->net_mode.media_header_size = ETHER_HDR_SIZE;
 	netobj->net_mode.max_packet_size = PKTSIZE;
@@ -997,20 +1230,31 @@ efi_status_t efi_net_register(void)
 	netobj->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
 	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
 	netobj->pxe.mode = &netobj->pxe_mode;
-	if (dhcp_ack)
-		netobj->pxe_mode.dhcp_ack = *dhcp_ack;
+
+	/*
+	 * Scan dhcp entries for one corresponding
+	 * to this udevice, from newest to oldest
+	 */
+	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
+	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
+	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
+		if (dev == dhcp_cache[i].dev) {
+			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
+			break;
+		}
+	}
 
 	/*
 	 * Create WaitForPacket event.
 	 */
 	r = efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
 			     efi_network_timer_notify, NULL, NULL,
-			     &wait_for_packet);
+			     &netobj->wait_for_packet);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
 		return r;
 	}
-	netobj->net.wait_for_packet = wait_for_packet;
+
 	/*
 	 * Create a timer event.
 	 *
@@ -1021,13 +1265,13 @@ efi_status_t efi_net_register(void)
 	 */
 	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
 			     efi_network_timer_notify, &netobj->net, NULL,
-			     &network_timer_event);
+			     &netobj->network_timer_event);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
 		return r;
 	}
 	/* Network is time critical, create event in every timer cycle */
-	r = efi_set_timer(network_timer_event, EFI_TIMER_PERIODIC, 0);
+	r = efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to set network timer\n");
 		return r;
@@ -1044,7 +1288,8 @@ efi_status_t efi_net_register(void)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-
+	netobj->efi_seq_num = seq_num;
+	net_objs[seq_num] = netobj;
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1063,7 +1308,7 @@ out_of_resources:
 }
 
 /**
- * efi_net_set_dp() - set device path of efi net device
+ * efi_net_new_dp() - update device path associated to a net udevice
  *
  * This gets called to update the device path when a new boot
  * file is downloaded
@@ -1073,38 +1318,93 @@ out_of_resources:
  * @udev:	net udevice
  * Return:	status code
  */
-efi_status_t efi_net_set_dp(const char *dev, const char *server, struct udevice *udev)
+efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev)
 {
-	efi_free_pool(net_dp);
+	efi_status_t ret;
+	struct efi_net_obj *netobj;
+	struct efi_device_path *old_net_dp, *new_net_dp;
+	struct efi_device_path **dp;
+	int i;
+
+	dp = &dp_cache[next_dp_entry].net_dp;
+
+	dp_cache[next_dp_entry].dev = udev;
+	dp_cache[next_dp_entry].is_valid = true;
+	next_dp_entry++;
+	next_dp_entry %= MAX_NUM_DP_ENTRIES;
 
-	net_dp = NULL;
+	old_net_dp = *dp;
+	new_net_dp = NULL;
 	if (!strcmp(dev, "Net"))
-		net_dp = efi_dp_from_eth(udev);
+		new_net_dp = efi_dp_from_eth(udev);
 	else if (!strcmp(dev, "Http"))
-		net_dp = efi_dp_from_http(server, udev);
+		new_net_dp = efi_dp_from_http(server, udev);
+	if (!new_net_dp)
+		return EFI_OUT_OF_RESOURCES;
 
-	if (!net_dp)
+	*dp = new_net_dp;
+	// Free the old cache entry
+	efi_free_pool(old_net_dp);
+
+	netobj = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == udev) {
+			netobj = net_objs[i];
+			break;
+		}
+	}
+	if (!netobj)
+		return EFI_SUCCESS;
+
+	new_net_dp = efi_dp_dup(*dp);
+	if (!new_net_dp)
 		return EFI_OUT_OF_RESOURCES;
+	ret = efi_netobj_set_dp(netobj, new_net_dp);
+	if (ret != EFI_SUCCESS)
+		efi_free_pool(new_net_dp);
 
-	return EFI_SUCCESS;
+	return ret;
 }
 
 /**
- * efi_net_get_dp() - get device path of efi net device
+ * efi_net_dp_from_dev() - get device path associated to a net udevice
  *
  * Produce a copy of the current device path
  *
  * @dp:		copy of the current device path
  * @udev:	net udevice
+ * @cache_only:	get device path from cache only
  */
-void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev)
+void efi_net_dp_from_dev(struct efi_device_path **dp, struct udevice *udev, bool cache_only)
 {
+	int i, j;
+
 	if (!dp)
 		return;
-	if (!net_dp)
-		efi_net_set_dp("Net", NULL, udev);
-	if (net_dp)
-		*dp = efi_dp_dup(net_dp);
+
+	*dp = NULL;
+
+	if (cache_only)
+		goto cache;
+
+	// If a netobj matches:
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == udev) {
+			*dp = efi_netobj_get_dp(net_objs[i]);
+			if (*dp)
+				return;
+		}
+	}
+cache:
+	// Search in the cache
+	i = (next_dp_entry + MAX_NUM_DP_ENTRIES - 1) % MAX_NUM_DP_ENTRIES;
+	for (j = 0; dp_cache[i].is_valid && j < MAX_NUM_DP_ENTRIES;
+		i = (i + MAX_NUM_DP_ENTRIES - 1) % MAX_NUM_DP_ENTRIES, j++) {
+		if (dp_cache[i].dev == udev) {
+			*dp = efi_dp_dup(dp_cache[i].net_dp);
+			return;
+		}
+	}
 }
 
 /**
@@ -1120,11 +1420,15 @@ void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev)
  *		be filled with the current network mask
  * @gw:		pointer to an efi_ipv4_address struct to be
  *		filled with the current network gateway
+ * @dev:	udevice
  */
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw)
+		      struct efi_ipv4_address *gw,
+		      struct udevice *dev)
 {
+	if (!dev)
+		dev = eth_get_dev();
 #ifdef CONFIG_NET_LWIP
 	char ipstr[] = "ipaddr\0\0";
 	char maskstr[] = "netmask\0\0";
@@ -1133,7 +1437,7 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
 	struct in_addr tmp;
 	char *env;
 
-	idx = dev_seq(eth_get_dev());
+	idx = dev_seq(dev);
 
 	if (idx < 0 || idx > 99) {
 		log_err("unexpected idx %d\n", idx);
@@ -1180,11 +1484,15 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
  * @ip:		pointer to new IP address
  * @mask:	pointer to new network mask to set
  * @gw:		pointer to new network gateway
+ * @dev:	udevice
  */
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
-		      struct efi_ipv4_address *gw)
+		      struct efi_ipv4_address *gw,
+		      struct udevice *dev)
 {
+	if (!dev)
+		dev = eth_get_dev();
 #ifdef CONFIG_NET_LWIP
 	char ipstr[] = "ipaddr\0\0";
 	char maskstr[] = "netmask\0\0";
@@ -1193,7 +1501,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 	struct in_addr *addr;
 	char tmp[46];
 
-	idx = dev_seq(eth_get_dev());
+	idx = dev_seq(dev);
 
 	if (idx < 0 || idx > 99) {
 		log_err("unexpected idx %d\n", idx);
@@ -1231,6 +1539,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 #endif
 }
 
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 /**
  * efi_net_set_buffer() - allocate a buffer of min 64K
  *
@@ -1318,26 +1627,41 @@ void efi_net_parse_headers(ulong *num_headers, struct http_header *headers)
  * @status_code:	HTTP status code
  * @file_size:		file size in bytes
  * @headers_buffer:	headers buffer
+ * @parent:		service binding protocol
  * Return:		status code
  */
 efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
-				u32 *status_code, ulong *file_size, char *headers_buffer)
+				u32 *status_code, ulong *file_size, char *headers_buffer,
+				struct efi_service_binding_protocol *parent)
 {
 	efi_status_t ret = EFI_SUCCESS;
 	int wget_ret;
 	static bool last_head;
+	struct udevice *dev;
+	int i;
 
-	if (!buffer || !file_size)
+	if (!buffer || !file_size || !parent)
 		return EFI_ABORTED;
 
 	efi_wget_info.method = (enum wget_http_method)method;
 	efi_wget_info.headers = headers_buffer;
 
+	// Set corresponding udevice
+	dev = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->http_service_binding == parent)
+			dev = net_objs[i]->dev;
+	}
+	if (!dev)
+		return EFI_ABORTED;
+
 	switch (method) {
 	case HTTP_METHOD_GET:
 		ret = efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info.hdr_cont_len : 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
+		eth_set_dev(dev);
+		env_set("ethact", eth_get_name());
 		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
 		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
 			// Try again with updated buffer size
@@ -1345,6 +1669,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
 			if (ret != EFI_SUCCESS)
 				goto out;
+			eth_set_dev(dev);
+			env_set("ethact", eth_get_name());
 			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
 				efi_free_pool(*buffer);
 				ret = EFI_DEVICE_ERROR;
@@ -1364,6 +1690,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		ret = efi_net_set_buffer(buffer, 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
+		eth_set_dev(dev);
+		env_set("ethact", eth_get_name());
 		wget_request((ulong)*buffer, url, &efi_wget_info);
 		*file_size = 0;
 		*status_code = efi_wget_info.status_code;
@@ -1377,3 +1705,4 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 out:
 	return ret;
 }
+#endif
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index eeed82c073..48f91da5df 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -11,6 +11,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
+#include <net.h>
 
 #define OBJ_LIST_INITIALIZED 0
 #define OBJ_LIST_NOT_INITIALIZED 1
@@ -219,7 +220,7 @@ static efi_status_t efi_start_obj_list(void)
 	efi_status_t ret = EFI_SUCCESS;
 
 	if (IS_ENABLED(CONFIG_NETDEVICES))
-		ret = efi_net_do_start();
+		ret = efi_net_do_start(eth_get_dev());
 
 	return ret;
 }
@@ -336,7 +337,7 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 	if (IS_ENABLED(CONFIG_NETDEVICES)) {
-		ret = efi_net_register();
+		ret = efi_net_register(eth_get_dev());
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-- 
2.43.0

