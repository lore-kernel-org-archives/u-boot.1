Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A3C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36E080A45;
	Wed, 22 Jan 2025 18:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQ96T5YX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE3C80977; Wed, 22 Jan 2025 18:09:25 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC42F809A5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21654fdd5daso125779235ad.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565761; x=1738170561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCRQQbtE5iRfUCbv0SCX5K2jatYSAppFz+9Ndfb79Ro=;
 b=LQ96T5YXLOvoHPnddDHirkB1NqsrgATbwHqtE8Jr4N3pHtgwFtOTjZaLy6Iv2/iLWs
 X+6x3k4MNbYIVRa7mMkC9qiAxrK49/zVkaWjI6xGlpayzvpWsHxm86r0v4O+9MuOX5q6
 5weukmlUNvs0jhXfbb92UGF/yiYSb40CCgTWzKZuJq8HihVT6Ny4CELPi8MGooTXkEO8
 OnCv/zQaFrhhq4U+H0NmDpchWujzms6VyFqYT6gr5YphjgL4b6rSVmVaFDc8LOsa2iTP
 f9D1TzgWFLrLqiQaU2XIYWFa5I5d9RhnGRgSpWp9vhTlRTt5nhvQ6mkzTN1UOUqQZz9o
 ZzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565761; x=1738170561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCRQQbtE5iRfUCbv0SCX5K2jatYSAppFz+9Ndfb79Ro=;
 b=tP1XLGGJbeoQY+gCHol73MLu/rMswGlIrO4at6IW904/uy2M+gJwNkY2MXes5xNEXy
 czmLCu7+1gJ749O+G8seAvcsPWVCJ5QUPBnVuaIevgyFWvlHVnkua44YGe7NAmWnWGYO
 HMorTDVy9d7IY5g79U4XWltAMVdMGhUvzcFv8SJoOr2vTLWK2AIrlA0C3xBODYOHOsXS
 6eVjrxehMWuK4BCYsK+NObTDAtH8DTJRu0JW0I1+mDLu8XcNJ4ATtwBEEBgofz59C9pR
 6xABKtNgEl0pdFbEraxKZ34kuuFARbOQ8fqMeL3K4E2OL4aTTG6zMjeCR3jSfKKGrTrW
 rcKQ==
X-Gm-Message-State: AOJu0Yy4Xw7OvsbmSARnCum6d0OxMw+AmKBJKvgmp+5bldJY+eZrIRyN
 lro1AA7AwG3PHyXHk5P+ZClk/ma1Z9aZXz780N8X7nOPC36WbRkkTJvnWcFD
X-Gm-Gg: ASbGncuIHhBtIlDTKbgRiLskxqz2wVJEI+3n8G0dRAsdSq70mOBBhiPW8GAkQDWxqNq
 MGNiQDX/fqYogdOLN8mjjuqBNNJNdJRlDFzli8qJDA9l7afs8R3qBf9GRtRqiazaGKfT5cj95Wd
 rAxKXZYWN90VZK3ivHp/ENTNxc0SnRH+VDIt2apM+I9jasljt/jzcJWDUjxsGrJdpVtMENtJcY7
 XdSvukgHvoCAQcYQwccGpO2m98Jf/W0AzV/6g9ppj27ZsRXRarRImcIs6X4itMmrHIbjplYS4RL
 iw==
X-Google-Smtp-Source: AGHT+IF87m4m/pOhw6/br9iFerKDO793Im96Y9T8e0vAVjk4V680CJntQ8GrJFwKRvwFA13RfPNGBA==
X-Received: by 2002:a17:903:244d:b0:216:386e:dbc with SMTP id
 d9443c01a7336-21c353ed9cemr328356405ad.13.1737565761225; 
 Wed, 22 Jan 2025 09:09:21 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:20 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 04/21] efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
Date: Wed, 22 Jan 2025 14:08:41 -0300
Message-ID: <20250122170858.961359-5-adriano.cordova@canonical.com>
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

This gets called each time a payload is to get executed by bootefi.
For now this only updates the PXE IP address.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h       |  1 +
 lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 626d2bbb1a..97152bbb6a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -628,6 +628,7 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(void);
+efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 918d43c70f..f0cf317d4f 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -876,6 +876,30 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
 	return EFI_UNSUPPORTED;
 }
 
+/**
+ * efi_net_do_start() - start the efi network stack
+ *
+ * This gets called from do_bootefi_exec() each time a payload gets executed.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_net_do_start(void)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	/*
+	 * No harm on doing the following. If the PXE handle is present, the client could
+	 * find it and try to get its IP address from it. In here the PXE handle is present
+	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
+	 */
+	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+#endif
+
+	return r;
+}
+
 /**
  * efi_net_register() - register the simple network protocol
  *
@@ -1017,13 +1041,6 @@ efi_status_t efi_net_register(void)
 	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-	/*
-	 * No harm on doing the following. If the PXE handle is present, the client could
-	 * find it and try to get its IP address from it. In here the PXE handle is present
-	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
-	 */
-	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
 #endif
 
 	return EFI_SUCCESS;
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 164586742a..eeed82c073 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -218,6 +218,9 @@ static efi_status_t efi_start_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
+	if (IS_ENABLED(CONFIG_NETDEVICES))
+		ret = efi_net_do_start();
+
 	return ret;
 }
 
-- 
2.43.0

