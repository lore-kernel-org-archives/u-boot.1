Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90485C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D08381DD6;
	Fri, 16 May 2025 10:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M/5eHNcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5662C82B32; Fri, 16 May 2025 10:18:00 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA45380050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a1c85e77d7so1163468f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383477; x=1747988277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZpG/4Nw301c3orH4VsqmC/NPRdCdL2m9D6Bak7O9+0=;
 b=M/5eHNcOgFYXy83baT/v8HN4eJ4Eo3aB9fbxvssZ29TRx3GoJ1voQkGDhJF5Wqivvl
 SgBaPM/c46b88tRWXJZ5J8LmjyrlB6FdPujFLPDMbrdoKnZ2wn9nZgKvllQ0K2g4hfh3
 jWFk0pmXxmkuatHUVA1a2vZGPbaCOVQw3JZd93OvJNG5dFjprwY9Wf2mGBVLSV8HR9ly
 /N7l+uVn4l8Aq26to598LK+z7qfG1KeqgRuy0eCq/f8PIHbgVwBP1afz60jwN71LqUKl
 JwA40B7wunkBkwKWmtMt7VSGg86EsYqR0lfnQD99XofacKGbWQ9V2GSoGWm/HCyF86MS
 CCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383477; x=1747988277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZpG/4Nw301c3orH4VsqmC/NPRdCdL2m9D6Bak7O9+0=;
 b=XMOYR08h6+M9vsDPUkyaHkeEE0wE1OdGcLuiTYaGRDN719UUg169WZfV/MiSsb9q84
 57uzvZ3RXlrdhNiDd49xAt7XR2Cf3w1R+CVSAJPoJz9NkNivu2mPBJcW40RKkJfUfe/C
 Lhbr7LJPchEzgujXvUHSrSyJUcZ+fsZeNum9/K2m3jPWgFXsj0dOv+bWFO3Gbgps7Mpn
 ollB5t1BCafop8E4E/aDGAdjHnCQPnT0s0nMCwUmEotU49XZyTbsfSLJfP5FvVL68tJp
 ATMWs91spepU9sYuCHL/gJGnbcdrO8d/9ikrpe/Zy6P7imL6dHzODS0vjtPoy1OZyPWI
 9ibQ==
X-Gm-Message-State: AOJu0Ywi0lQHyFz0XYWAVjzEr3ZNsPrifzlQdZee4eBBbdX3VP02SWss
 afOW9He3sxvITVv7C3fQZ1pNSpJMTLFKtrusiiRNffPp2KK8P4iOhkPPHehT7SkbZ98=
X-Gm-Gg: ASbGncutqE93u10TTP0gpT0tkbLVE9NHjN/w+YNNIiyyIcqvKNaAfZyBxpEfxEBjX3r
 AeCyv6dyt1m/xtVxsRCGoKLIH71w8iwvt5HBegl6bkem2U3tn6+9LGe/vRnzMu4qdzD2LTYsLQ4
 wMtbKktAwSq9KaLfau3amnlCdk3735qATP90gic19YZOUgeyd29dkwfVsj4Q9PvZS/NuKeilHEM
 vxycbU6j5m6v6czBErk0ayo9WHtOUbKA1ZpX4tT1Gj202afNmbDA/wHzRH8dhVY0bRpKIU6p/Az
 O+7CQyMdBO44QuIt8+3/HIFFWbAz74Xqo4Pq6imyjKxBGfirr8KXPvY8kldShT89OwOtGtDU
X-Google-Smtp-Source: AGHT+IFS2cd7HktdaMP+kd323ic3o26gbTKBKqoSq8tgagSd1aZJT33A/cyYs1XTgsbDp8VoRpDlnQ==
X-Received: by 2002:a05:6000:4283:b0:3a3:49dd:ada1 with SMTP id
 ffacd0b85a97d-3a35fe7cf93mr1166828f8f.24.1747383477248; 
 Fri, 16 May 2025 01:17:57 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:56 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 7/9] efi_loader/net/ip4_config2: Add support for multiple
 instances
Date: Fri, 16 May 2025 04:18:37 -0400
Message-ID: <20250516081839.28587-8-adriano.cordova@canonical.com>
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

Fix support multiple instances of EFI_IP4_CONFIG2_PROTOCOL in
efi_ip4_config2.c. Station addresses and policies should be per
protocol instance and not global.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/net/efi_ip4_config2.c | 73 +++++++++++++++++++---------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/lib/efi_loader/net/efi_ip4_config2.c b/lib/efi_loader/net/efi_ip4_config2.c
index a46cba09f01..a924a10716f 100644
--- a/lib/efi_loader/net/efi_ip4_config2.c
+++ b/lib/efi_loader/net/efi_ip4_config2.c
@@ -14,12 +14,25 @@
 
 static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
 
-struct efi_ip4_config2_manual_address current_http_ip;
-static enum efi_ip4_config2_policy current_policy;
-static char current_mac_addr[32];
-
 /* EFI_IP4_CONFIG2_PROTOCOL */
 
+/**
+ * struct efi_ip4_config2_extended_protocol - EFI object extending the
+ *					      EFI_IP4_CONFIG2_PROTOCOL
+ *					      interface
+ *
+ * @ip4_config2:		EFI_IP4_CONFIG2_PROTOCOL interface
+ * @dev:			net udevice
+ * @current_address		current address
+ * @current_policy		current policy
+ */
+struct efi_ip4_config2_extended_protocol {
+	struct efi_ip4_config2_protocol ip4_config2;
+	struct udevice *dev;
+	struct efi_ip4_config2_manual_address current_address;
+	enum efi_ip4_config2_policy current_policy;
+};
+
 /*
  * efi_ip4_config2_set_data() -  Set the configuration for the EFI IPv4 network
  * stack running on the communication device
@@ -41,32 +54,38 @@ static efi_status_t EFIAPI efi_ip4_config2_set_data(struct efi_ip4_config2_proto
 {
 	EFI_ENTRY("%p, %d, %zu, %p", this, data_type, data_size, data);
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_ip4_config2_extended_protocol *ipconfig;
 
 	if (!this || (data && !data_size) || (!data && data_size))
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
+	ipconfig = (struct efi_ip4_config2_extended_protocol *)this;
+	if (!ipconfig->dev)
+		return EFI_EXIT(EFI_NOT_FOUND);
+
 	switch (data_type) {
 	case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
 		return EFI_EXIT(EFI_WRITE_PROTECTED);
 	case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
-		if (current_policy != EFI_IP4_CONFIG2_POLICY_STATIC)
+		if (ipconfig->current_policy != EFI_IP4_CONFIG2_POLICY_STATIC)
 			return EFI_EXIT(EFI_WRITE_PROTECTED);
 		if (!data_size && !data) {
-			memset((void *)&current_http_ip, 0,
-			       sizeof(current_http_ip));
+			memset((void *)&ipconfig->current_address, 0,
+			       sizeof(ipconfig->current_address));
 			return EFI_EXIT(EFI_SUCCESS);
 		}
 		if (data && data_size == sizeof(struct efi_ip4_config2_manual_address)) {
-			memcpy((void *)&current_http_ip, data,
+			memcpy((void *)&ipconfig->current_address, data,
 			       sizeof(struct efi_ip4_config2_manual_address));
-			efi_net_set_addr(&current_http_ip.address,
-					 &current_http_ip.subnet_mask, NULL, NULL);
+			efi_net_set_addr(&ipconfig->current_address.address,
+					 &ipconfig->current_address.subnet_mask,
+					 NULL, ipconfig->dev);
 			return EFI_EXIT(EFI_SUCCESS);
 		}
 		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
 	case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
 		if (data && data_size == sizeof(enum efi_ip4_config2_policy)) {
-			current_policy = *(enum efi_ip4_config2_policy *)data;
+			ipconfig->current_policy = *(enum efi_ip4_config2_policy *)data;
 			return EFI_EXIT(EFI_SUCCESS);
 		}
 		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
@@ -101,6 +120,7 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 
 	efi_status_t ret = EFI_SUCCESS;
 	struct efi_ip4_config2_interface_info *info;
+	struct efi_ip4_config2_extended_protocol *ipconfig;
 	int tmp;
 
 	if (!this || !data_size)
@@ -109,6 +129,10 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 	if (*data_size && !data)
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
+	ipconfig = (struct efi_ip4_config2_extended_protocol *)this;
+	if (!ipconfig->dev)
+		return EFI_EXIT(EFI_NOT_FOUND);
+
 	tmp = sizeof(struct efi_ip4_config2_interface_info) + sizeof(struct efi_ip4_route_table);
 
 	switch (data_type) {
@@ -122,7 +146,7 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 		memset(info, 0, sizeof(*info));
 
 		info->hw_address_size = 6;
-		memcpy(info->hw_address.mac_addr, current_mac_addr, 6);
+		memcpy(info->hw_address.mac_addr, eth_get_ethaddr_from_dev(ipconfig->dev), 6);
 		// Set the route table size
 
 		info->route_table_size = 0;
@@ -133,8 +157,9 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_proto
 			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
 		}
 
-		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL, NULL);
-		memcpy(data, (void *)&current_http_ip,
+		efi_net_get_addr(&ipconfig->current_address.address,
+				 &ipconfig->current_address.subnet_mask, NULL, ipconfig->dev);
+		memcpy(data, (void *)&ipconfig->current_address,
 		       sizeof(struct efi_ip4_config2_manual_address));
 
 		break;
@@ -197,25 +222,25 @@ static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_conf
 efi_status_t efi_ip4_config2_install(const efi_handle_t handle)
 {
 	efi_status_t r;
-	struct efi_ip4_config2_protocol *ip4config;
+	struct efi_ip4_config2_extended_protocol *ipconfig;
 
 	r = efi_allocate_pool(EFI_LOADER_DATA,
-			      sizeof(*ip4config),
-			      (void **)&ip4config);
+			      sizeof(*ipconfig),
+			      (void **)&ipconfig);
 	if (r != EFI_SUCCESS)
 		return r;
 
 	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
-			     ip4config);
+			     &ipconfig->ip4_config2);
 	if (r != EFI_SUCCESS)
 		return r;
 
-	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
-
-	ip4config->set_data = efi_ip4_config2_set_data;
-	ip4config->get_data = efi_ip4_config2_get_data;
-	ip4config->register_data_notify = efi_ip4_config2_register_notify;
-	ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
+	ipconfig->dev = handle->dev;
+	ipconfig->ip4_config2.set_data = efi_ip4_config2_set_data;
+	ipconfig->ip4_config2.get_data = efi_ip4_config2_get_data;
+	ipconfig->ip4_config2.register_data_notify = efi_ip4_config2_register_notify;
+	ipconfig->ip4_config2.unregister_data_notify = efi_ip4_config2_unregister_notify;
+	ipconfig->current_policy = EFI_IP4_CONFIG2_POLICY_MAX;
 
 	return EFI_SUCCESS;
 }
-- 
2.48.1

