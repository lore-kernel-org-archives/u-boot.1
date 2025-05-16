Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1262BC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64ED982A8D;
	Fri, 16 May 2025 10:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DmJ0Msp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C3D82998; Fri, 16 May 2025 10:17:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70E780050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso12069505e9.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383469; x=1747988269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPWI24WqzBPK2QK/WTV8VZ3+jT5JkaK8cHbpufxtSk4=;
 b=DmJ0Msp/WHG0M9CC7oRKXvHY+uXiE8hkcHs7TI37m/3gnf+fPIB00EaEo673I15NKU
 X4/MVZuuuOO1hYcwS09jMBYEWEtSC9sH051blKiWnaKv+Vk+fjFT8m/DM0mhjANQxk1y
 jDMmV1dWOuNfNymjTsq7yQOYOsoVozOqT6ErI4rJw52Yi96uMW0xflS9IPMOSMs2ydvU
 ZsmMGXtQUxqh6W8lDxIAtMj1J9Y5DProHqtLZoMEUMVu0Eu7r43+R4cQo+siMXLrTTBx
 xDZZv7BYg+zaTUUlu5gJKsSVGTlNxQA4IJgWA1fH/C4KT7krerPmASIBrqYw23SU4ETY
 g/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383469; x=1747988269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPWI24WqzBPK2QK/WTV8VZ3+jT5JkaK8cHbpufxtSk4=;
 b=HYwcAKdisJmZCdNvtfDajoYxS/Bb9qXeNQkExF54066wbxwChhkygvfKEXAZ45x9KZ
 26Tm7sAMjyisYhocPWkO9FhVe6Js4wcTFIm8vqSCA7xIWyMwpU8JSse+x/iSV7HDcymo
 1xKj/6mL0Di9tOJlsxkfWjQMLn4ZmtbgKaSOGCrHyvnBez/kbRys1/T9qkv5tenKuRUF
 IudtZxE04+iM1OlOBHJPYG15KeogLZ3f3B3k9pbs4oX0+Pw1LUOYTHlchrxW6V0dbolI
 j9olyyx7+Ga6RKsirTRLSTmyNgh7SiSk3DdpK+JFI28PpGHEUx4BfZuP4o6RcWjn8whh
 QAYg==
X-Gm-Message-State: AOJu0YzNdGad0jE4Voz/H35NHBsk3/ITDMowTBJCgUu8jy6EFMIPnFL7
 X8KEdTlKYEv+eygzg9uP95U41Wawh2RcznFMK0sVpz1vB+VycUSuO8BR4EHB2YmqcaU=
X-Gm-Gg: ASbGncsqTKljoju4BHsRPpYspuIbLb/w8Q4OhkYaSfY+Ixb+GGaiY/HVIflfXh+jcRF
 q5dSdqH2WQF6gREr+u4OfIQ8S27CrwIhKCnFw7GeL2P2F/wyJdUfOPFsNZwxo6pbKSqtbX/Sshl
 U76NfmBh5EewY5YdaA7k0e5UQG39z+V1Cx6Wk2BSesk2965zUFz4VRLMKS+xAxC46i5dXPwnUoS
 yzjQIShJcj379NMkC1b4gesGAjRL+BdeHKLnC7A7sISHPk+ab+xqAZsMd7iiwIu0T1xg5qni5Qo
 sH3rKZiKNVYPxuSDFytkK4S3ecb0SLxUUEQ/BMdbVxHjomHm2H+iJMnmn3HSzA==
X-Google-Smtp-Source: AGHT+IGYgzJrwnBWxOXAfO1plC6qDqIaBZi5JUwmh79ZcZIeMzUMGuz5yzx8QMhhRylItgTDJg5ANw==
X-Received: by 2002:a05:600c:628d:b0:441:d438:159d with SMTP id
 5b1f17b1804b1-442fd60cee6mr22667855e9.6.1747383468908; 
 Fri, 16 May 2025 01:17:48 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:48 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/9] efi_loader/net: Remove http and ip4_config2 data from
 efi_net.c
Date: Fri, 16 May 2025 04:18:32 -0400
Message-ID: <20250516081839.28587-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

efi_net.c should only [un]install protocols, leaving the
actual implementation to efi_http.c and efi_ipconfig.c

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h              |  6 ++----
 lib/efi_loader/net/efi_http.c     | 20 +++++++++++++-------
 lib/efi_loader/net/efi_ipconfig.c | 19 ++++++++++++-------
 lib/efi_loader/net/efi_net.c      | 26 ++++++++++++++------------
 4 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 84e8cfe320e..5c1244824f3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -662,11 +662,9 @@ efi_status_t efi_gop_register(void);
 efi_status_t efi_net_register(struct udevice *dev);
 efi_status_t efi_net_do_start(struct udevice *dev);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
-efi_status_t efi_ipconfig_register(const efi_handle_t handle,
-				   struct efi_ip4_config2_protocol *ip4config);
+efi_status_t efi_ip4_config2_install(const efi_handle_t handle);
 /* Called by efi_net_register to make the http protocol available */
-efi_status_t efi_http_register(const efi_handle_t handle,
-			       struct efi_service_binding_protocol *http_service_binding);
+efi_status_t efi_http_install(const efi_handle_t handle);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
 efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
diff --git a/lib/efi_loader/net/efi_http.c b/lib/efi_loader/net/efi_http.c
index 189317fe2d2..536ce1edb97 100644
--- a/lib/efi_loader/net/efi_http.c
+++ b/lib/efi_loader/net/efi_http.c
@@ -24,6 +24,7 @@ static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
  *
  * @http:			EFI_HTTP_PROTOCOL interface
  * @handle:			handle to efi object
+ * @parent:			service binding that created this child
  * @configured:			configuration status
  * @http_load_addr:		data buffer
  * @file_size:			size of data
@@ -391,7 +392,7 @@ static efi_status_t EFIAPI efi_http_service_binding_create_child(
 	if (!child_handle)
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
-	new_instance = calloc(1, sizeof(struct efi_http_instance));
+	new_instance = calloc(1, sizeof(*new_instance));
 	if (!new_instance) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto failure_to_add_protocol;
@@ -482,25 +483,30 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 }
 
 /**
- * efi_http_register() - register the http protocol
+ * efi_http_install() - install the EFI_HTTP_SERVICE_BINDING_PROTOCOL
  *
+ * @handle:	handle to install the protocol
  */
-efi_status_t efi_http_register(const efi_handle_t handle,
-			       struct efi_service_binding_protocol *http_service_binding)
+efi_status_t efi_http_install(const efi_handle_t handle)
 {
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_service_binding_protocol *http_service_binding;
+
+	r = efi_allocate_pool(EFI_LOADER_DATA,
+			      sizeof(*http_service_binding),
+			      (void **)&http_service_binding);
+	if (r != EFI_SUCCESS)
+		return r;
 
 	r = efi_add_protocol(handle, &efi_http_service_binding_guid,
 			     http_service_binding);
 	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
+		return r;
 
 	http_service_binding->create_child = efi_http_service_binding_create_child;
 	http_service_binding->destroy_child = efi_http_service_binding_destroy_child;
 
 	return EFI_SUCCESS;
-failure_to_add_protocol:
-	return r;
 }
 
 enum efi_http_status_code efi_u32_to_httpstatus(u32 status)
diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_ipconfig.c
index 9f51f77fa9a..a46cba09f01 100644
--- a/lib/efi_loader/net/efi_ipconfig.c
+++ b/lib/efi_loader/net/efi_ipconfig.c
@@ -190,20 +190,25 @@ static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_conf
 }
 
 /**
- * efi_ipconfig_register() - register the ip4_config2 protocol
+ * efi_ip4_config2_install() - install the EFI_IP4_CONFIG2_PROTOCOL
  *
+ * @handle	handle to install the protocol
  */
-efi_status_t efi_ipconfig_register(const efi_handle_t handle,
-				   struct efi_ip4_config2_protocol *ip4config)
+efi_status_t efi_ip4_config2_install(const efi_handle_t handle)
 {
-	efi_status_t r = EFI_SUCCESS;
+	efi_status_t r;
+	struct efi_ip4_config2_protocol *ip4config;
+
+	r = efi_allocate_pool(EFI_LOADER_DATA,
+			      sizeof(*ip4config),
+			      (void **)&ip4config);
+	if (r != EFI_SUCCESS)
+		return r;
 
 	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
 			     ip4config);
-	if (r != EFI_SUCCESS) {
-		log_err("ERROR: Failure to add protocol\n");
+	if (r != EFI_SUCCESS)
 		return r;
-	}
 
 	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
 
diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
index b3291b4f1d5..40db80f4726 100644
--- a/lib/efi_loader/net/efi_net.c
+++ b/lib/efi_loader/net/efi_net.c
@@ -31,6 +31,8 @@
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid =
+					EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
 
 struct dp_entry {
 	struct efi_device_path *net_dp;
@@ -73,8 +75,6 @@ static int next_dhcp_entry;
  * @net_mode:			status of the network interface
  * @pxe:			PXE base code protocol interface
  * @pxe_mode:			status of the PXE base code protocol
- * @ip4_config2:		IP4 Config2 protocol interface
- * @http_service_binding:	Http service binding protocol interface
  * @new_tx_packet:		new transmit packet
  * @transmit_buffer:	transmit buffer
  * @receive_buffer:		array of receive buffers
@@ -92,12 +92,6 @@ struct efi_net_obj {
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
-#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
-	struct efi_ip4_config2_protocol ip4_config2;
-#endif
-#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
-	struct efi_service_binding_protocol http_service_binding;
-#endif
 	void *new_tx_packet;
 	void *transmit_buffer;
 	uchar **receive_buffer;
@@ -1285,13 +1279,12 @@ efi_status_t efi_net_register(struct udevice *dev)
 	}
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
-	r = efi_ipconfig_register(&netobj->header, &netobj->ip4_config2);
+	r = efi_ip4_config2_install(&netobj->header);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
-	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
+	r = efi_http_install(&netobj->header);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
@@ -1645,6 +1638,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 	int wget_ret;
 	static bool last_head;
 	struct udevice *dev;
+	struct efi_handler *phandler;
 	int i;
 
 	if (!buffer || !file_size || !parent)
@@ -1656,8 +1650,16 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 	// Set corresponding udevice
 	dev = NULL;
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && &net_objs[i]->http_service_binding == parent)
+		if (!net_objs[i])
+			continue;
+
+		ret = efi_search_protocol(&net_objs[i]->header,
+					  &efi_http_service_binding_guid,
+					  &phandler);
+		if (ret == EFI_SUCCESS && phandler == (void *)parent) {
 			dev = net_objs[i]->dev;
+			break;
+		}
 	}
 	if (!dev)
 		return EFI_ABORTED;
-- 
2.48.1

