Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4240C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45E7817C4;
	Mon, 10 Mar 2025 13:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="elToCR+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62B0817A5; Mon, 10 Mar 2025 13:06:12 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3FA811DF
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so3507155ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608368; x=1742213168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9452snV7c1L6h4cNzqVb0CEi6gIoSkNDq1UfEZlC8bs=;
 b=elToCR+tsdDVaCaABw3rHuXvYACZ2UQpNcICRl4PSJepMBIIc0SiQJ8/iUn6Yb9+LO
 SU84zG+QpToq8D4r2/Jtip6FdYgtTPpnjFw3AmPdDuOLWWAiLQDg8jENGcwDRmQp4Buc
 qH2EAH2KM135wmKxzjOEtFfU76/sRBL6adUVmhq8lVJKg3FXVRAulsqqZJ+lTNTigA6u
 3a6mDStdGRV/POQuLSafsQ/IXR5ddxdQOlliJe8okwgZtnYod3WzYjRGSvDd/+QGJW7x
 VIEggQR45kN0jDMr6aWkIeJ+/8L+Ui4AcK4xTdD7X7CuGW9qY97GrYldL0cBlIUu+NQd
 Xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608368; x=1742213168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9452snV7c1L6h4cNzqVb0CEi6gIoSkNDq1UfEZlC8bs=;
 b=AmK2du7lJA0AFSvjypFgnO7p6632uyPAYQeM3ne7i9AKj2Lu+h1gPxx7LoeuIPELRl
 4vg1AxffySNk9Z/smIF/9+khMQTtsefpRigWpj6PVxFK5rHelZDrVcHjB9/3Eb9+A7P0
 amrniCVijXNi2wW+qxCkcQlKkWcINypX+Z0fuE8andB+Oo2ULLLHdM1b1JMpXTUqNiMe
 Yf8mwnnmpKzZFfmLR81tcF/89OBaDajHK2aDHVZ//jZITiTKImF2aIQ6jMLlSJyzmwqA
 EIjNFsjWB37ORAv4xxjSByKgjB5DrpXqCsZAYpJoiWNdrVllsUOYQd2BbmgkUm54me/F
 0obg==
X-Gm-Message-State: AOJu0YyyXmB7tR2BTxQZ1yKkxaslOmsWO9HJRgxHAWGRVoxTKwq1KYJz
 gEciirShbT9DDH0DgRglmQQa/e3kj4TPaL0qR33OqgobCvEQJb8olES7Hg4jBCs=
X-Gm-Gg: ASbGncvC7CL4p5z4Y0lFUk/iUnTQEZBMaUjgKF+ZODeLPVpkfWJ6v5Y4Gx2zJ3kn6FT
 EOZgbvfJLmjVzx6sjkNvj6Byi/ASrJ1h0z93AG2F7Qg0uoWPe8FHStCW/ibD6R7m31rCXqMQkBP
 pA1cNEGGFoNIQm7gv29KIhYzDQDEx1VRIoK3sg2R3AtE/f58O7+Cit1G2jH+IA9hncnGxlaBByI
 U2AkKFf4/EAJHO+2nsUVafYYh0orLVH5tjaGHEA6Pd3r/HOmlZH1DKusO+5A0E2RnxoGaUrWe/Y
 jx6E/kbJZteyOhu9Vz5oJ1wCaFv+7+xYrvzH6EDK2wOcsAFXEb09W4s=
X-Google-Smtp-Source: AGHT+IFXg0qtfEhZjW4iPT7eq5TNKg+htqnlPuMY9LOUbHhkBbUEnTlr6WAoEEbg6jtckQDM5QZJTQ==
X-Received: by 2002:a05:6a00:2d90:b0:736:4b85:ee05 with SMTP id
 d2e1a72fcca58-736aaa56dc6mr18316046b3a.11.1741608367702; 
 Mon, 10 Mar 2025 05:06:07 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:07 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 4/8] efi_loader: efi_net: Add efi_net_do_start() to
 efi_net.c
Date: Mon, 10 Mar 2025 09:06:03 -0300
Message-ID: <20250310120607.186999-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120607.186999-1-adriano.cordova@canonical.com>
References: <20250310120607.186999-1-adriano.cordova@canonical.com>
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

(no changes since v1)

 include/efi_loader.h       |  1 +
 lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6a17a41dbad..c2fb3e66eb9 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -650,6 +650,7 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(void);
+efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index a48402d49d4..68051852dd8 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -878,6 +878,30 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
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
@@ -1019,13 +1043,6 @@ efi_status_t efi_net_register(void)
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
index 164586742ae..eeed82c0736 100644
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
2.48.1

