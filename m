Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556DAC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE8183A3A;
	Wed, 28 May 2025 10:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKL2Z4qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0E083A32; Wed, 28 May 2025 10:37:20 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9E383A24
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4bdee0bf7so2836651f8f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421438; x=1749026238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiUKMWwX2zt+03Rh7J0bGF9AeLym14O1lSpw9+zBUTk=;
 b=EKL2Z4qoNoomoXaN7KyOJKT6jUV8jb5u8+nhr4+EmFG3DNv0EniN51Imdp9YSwHYYB
 I71yCPaCJw5mANST2kfuhzWlIkttJMQCM/OHVc0m48HO8fLRZJdxO8SqctNMIMHz4bVW
 WYlGEcFee8mIEgkAL3D7KfRoCVDAuIGyBXaxHMLzLSor4aviiO5DWM8AZaYVoiqDm3Tq
 n84+EFDzhriEgGEpPeo3eT0+ywMXSgEwFLc5dQDDiY6VZFI+4IcK/27oSsd2pIUv7FWx
 HubgA6t1U0rEy/kzZdMvhBa+UIswPsg5jwuadIdo+OSgYpS/S5IkZnKjMODueJfrTQww
 sNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421438; x=1749026238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiUKMWwX2zt+03Rh7J0bGF9AeLym14O1lSpw9+zBUTk=;
 b=wSf+rueQETb5JN/Rdxuy9SAhY0XlTVgVTqHVVUZrcTaznXsgYg6VON9koStzh6cbeh
 CL0aRJp8lmcWWs0ycLukHP9UndJM/pNuerVt11msMkNj4+yNBmGpYOu48rRwOBOghJfZ
 7y05mZ7GOf1gyxr/XAn0GbSXzR1cBgTdKZ3S05pL1PWjRxJiMIk2n/14PCdNEXgjtqyx
 WECmygQ2n3q27wdqINwHmgPWo7HcEsdolz8pQsLNLhcnQK88lDi3eL9UMbqR035jJ/yM
 Jc+B+CIKwhrq0aeUKuHdUzZtyY5uDqiEiAa7kmCjwspiXGuPNA1NuGeqUZGU8pUwchUi
 Axyw==
X-Gm-Message-State: AOJu0YxF7uQpwJrtliZe6WJ1GImAHhLti9fmcNV7oiT5S2i4uuXv2GyL
 +Byap5DLO1LQrKB7WPM0BF5LQ2X4ZJ9NXE15QEz9b1BP4ZbRmLkg8eVvdCNPCSZSFvM=
X-Gm-Gg: ASbGncuefAh34hKANih98i+BuluJTtUnKOKYrEtWLMM7qbGlvRPEHar5RTvK7bacTD9
 zxQGR9BzVbhXhv7OLopinowXFCYnPSWFlEMKRoC/saBCDHpYpJknd+EL7t1JLu6WW9rhhE+ZOuY
 9yl79Mq4tPS04+9E8ScSusVMwRz1YiNkvNBDInIAZPau8qfllslosA0i/4oRVjGeWC70GjmXftO
 m6dsR4PowqDwl0WMrzD6Au769h9odz2iBaxA/Jh51s1DHKK5YhZMpZMmGwuFMHpOAUNF1vV16C+
 3UNrwzIdVICJoFhxGTPeRDolKH9Y5ZFI3u6OfMkw1ifzNSV9cuYrgwd4Z2h6VEs4I09kNgFcYea
 DKykvsji5md36kdqZqPpuke9yOf0=
X-Google-Smtp-Source: AGHT+IGV37eUadqAM/6ehAUWGpr87E7AE/KIvDvG6CirJuMkZ28ws2sYL++2+lM34aDPvPtOfMbGtA==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:e5ea:1ac0 with SMTP id
 ffacd0b85a97d-3a4e5ea1d05mr3521997f8f.5.1748421437513; 
 Wed, 28 May 2025 01:37:17 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:17 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 2/9] efi_loader/net: Remove http and ip4_config2 data from
 efi_net.c
Date: Wed, 28 May 2025 04:38:14 -0400
Message-ID: <20250528083821.567514-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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

Changes in v2:
	- free protocol interfaces if protocol installation fails

 include/efi_loader.h              |  6 ++----
 lib/efi_loader/net/efi_http.c     | 24 +++++++++++++++---------
 lib/efi_loader/net/efi_ipconfig.c | 25 +++++++++++++++----------
 lib/efi_loader/net/efi_net.c      | 26 ++++++++++++++------------
 4 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index b3beda5de7b..fd8ae599ced 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -682,11 +682,9 @@ efi_status_t efi_gop_register(void);
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
index 189317fe2d2..709167a2a25 100644
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
@@ -482,24 +483,29 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
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
 
-	r = efi_add_protocol(handle, &efi_http_service_binding_guid,
-			     http_service_binding);
+	r = efi_allocate_pool(EFI_LOADER_DATA,
+			      sizeof(*http_service_binding),
+			      (void **)&http_service_binding);
 	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
+		return r;
 
 	http_service_binding->create_child = efi_http_service_binding_create_child;
 	http_service_binding->destroy_child = efi_http_service_binding_destroy_child;
 
-	return EFI_SUCCESS;
-failure_to_add_protocol:
+	r = efi_add_protocol(handle, &efi_http_service_binding_guid,
+			     http_service_binding);
+	if (r != EFI_SUCCESS)
+		efi_free_pool(http_service_binding);
+
 	return r;
 }
 
diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_ipconfig.c
index 9f51f77fa9a..7e18026cfea 100644
--- a/lib/efi_loader/net/efi_ipconfig.c
+++ b/lib/efi_loader/net/efi_ipconfig.c
@@ -190,20 +190,20 @@ static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_conf
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
 
-	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
-			     ip4config);
-	if (r != EFI_SUCCESS) {
-		log_err("ERROR: Failure to add protocol\n");
+	r = efi_allocate_pool(EFI_LOADER_DATA,
+			      sizeof(*ip4config),
+			      (void **)&ip4config);
+	if (r != EFI_SUCCESS)
 		return r;
-	}
 
 	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
 
@@ -212,5 +212,10 @@ efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 	ip4config->register_data_notify = efi_ip4_config2_register_notify;
 	ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
 
-	return EFI_SUCCESS;
+	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
+			     ip4config);
+	if (r != EFI_SUCCESS)
+		efi_free_pool(ip4config);
+
+	return r;
 }
diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
index 8e708d8d350..387bfec7cb2 100644
--- a/lib/efi_loader/net/efi_net.c
+++ b/lib/efi_loader/net/efi_net.c
@@ -32,6 +32,8 @@
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid =
+					EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
 
 struct dp_entry {
 	struct efi_device_path *net_dp;
@@ -74,8 +76,6 @@ static int next_dhcp_entry;
  * @net_mode:			status of the network interface
  * @pxe:			PXE base code protocol interface
  * @pxe_mode:			status of the PXE base code protocol
- * @ip4_config2:		IP4 Config2 protocol interface
- * @http_service_binding:	Http service binding protocol interface
  * @new_tx_packet:		new transmit packet
  * @transmit_buffer:	transmit buffer
  * @receive_buffer:		array of receive buffers
@@ -93,12 +93,6 @@ struct efi_net_obj {
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
@@ -1286,13 +1280,12 @@ efi_status_t efi_net_register(struct udevice *dev)
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
@@ -1646,6 +1639,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 	int wget_ret;
 	static bool last_head;
 	struct udevice *dev;
+	struct efi_handler *phandler;
 	int i;
 
 	if (!buffer || !file_size || !parent)
@@ -1657,8 +1651,16 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
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

