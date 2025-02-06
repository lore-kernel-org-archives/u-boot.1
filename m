Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4715C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0DE80D1C;
	Thu,  6 Feb 2025 18:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E9RtezVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7496380D1C; Thu,  6 Feb 2025 18:40:41 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 203F380EAF
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f05693a27so18389075ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863637; x=1739468437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMEpyPiR+Hq9JLyieZai64BIaSfiFn+iORakDn1fyh8=;
 b=E9RtezVhOmgydC0mtX0AZHq3HUnf1n/0JzlSi8ASI5wPDFWKK++LcBjZ68vLi5ysK9
 QZ8eJ8ta5vXrwRXrpmJjxZJ/lG1R97R2N9Yn93AN5QivN4d5J8np+ZxugyGEbgvvuWxM
 lSOzwzymt0dnQRaYKiwYW0SJWk/dH/gDZvyPPTEZxJHyt7NZyTSa3sXcyyjx97IXMOOR
 j1kNail7ThAQLARx+XxJ5C9HoRdfkIn8OLHaLs7AHfLz16EiaDDFgrx6Xml9fRofagJM
 loTQiP4S7Kb/JyFiIKfXPY/J1+xd8uoQh6S8ItzfDHiaxd4fzUEiQQ1/NWMKrTgZYIWM
 LIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863637; x=1739468437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMEpyPiR+Hq9JLyieZai64BIaSfiFn+iORakDn1fyh8=;
 b=wziNZJdMOBv8ElYfPNDiDikJakGbxLnyzljp69wdgq1EqVuvfM0Pdkf66h91crsbNO
 679fBth6mOClXcv/CyzN+qd474PiRkfD6SeupfHi3amemLMQXvrCQVMp24GKTUup9/uV
 fpdiLyidCmlT5jsYUmlXWO3WFittkPVO3Hso4pka7l1mkFvYzKTEaJNi9RWGzywGHWiM
 hL/o/N00XE7uCur92DUuKFX1CFG3xeBzicJJPoqCwd3spRhci0xB0OdORJMYEyyZigeA
 6synm20FJwjMGKK8DBOizwfBB/QZlY/h5w8fjqOPrEd8s95ZKu3vmv/nlMhsS3emITmU
 U+DQ==
X-Gm-Message-State: AOJu0YzfiZPQ5rVBiN14MF8RWIkFbnCxPHumJfe75Pvx0YYLv3shgcZl
 ZMRgsOffP1e4L3TqGEFzHL2yXpqXBhBbYSqdgeYhAspy65Qsy+eGLrFss6Hju8cC0Q==
X-Gm-Gg: ASbGncsOQBR2SXRaQZasPhSlcmSDdMJ1hUpFvU87JoggD5HyVH59ZghBhjuQ3vlWZEP
 29GvbGHhIkNGCrCrY4e+MgWfNpifm99GF/A7Yvjnp4KOaqbR9dN0txhCRWNKxOV9lNCa8ZpZuE6
 GJSWUAeb+j+Ws87LiAP/QHjdasVDZZyhHwsLHWyJzu6ZMZSnccGGvkVzyWZIQ4J7ZLcpI6CFAlP
 gcLh/URqhAbYaqnQ2a0ftaauZPkloi0KbrYcaOe7wqs67o/EfpjgqKMjqocjPnzOJv1ZjuDvEN0
 CgHzM70Eyid+xErS+0oMgEZL
X-Google-Smtp-Source: AGHT+IGC3M0Di9r8BMmYoWnJ8qmS3ChJalLKreaQ0QYKtlnicdxQIB8TizDM2rmgDBLjcCMIIznTwA==
X-Received: by 2002:a17:903:18f:b0:216:3889:6f6f with SMTP id
 d9443c01a7336-21f17df71a1mr119837365ad.17.1738863637573; 
 Thu, 06 Feb 2025 09:40:37 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:37 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 4/8] efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
Date: Thu,  6 Feb 2025 14:40:14 -0300
Message-ID: <20250206174018.465530-5-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
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
index 8b4da7aa1fa..54801cdd260 100644
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
2.45.2

