Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2442DC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C33780EBA;
	Thu,  6 Feb 2025 18:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VK8fWDrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BAD80EB6; Thu,  6 Feb 2025 18:40:39 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F4780C91
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21670dce0a7so28985105ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863635; x=1739468435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLHLI00NaE0U8yZiINJW4K2nBh4ICrixk0gO1c2R5o4=;
 b=VK8fWDrhEIK8idgB68ruC1ss06QXswsfRFmn1EO5ah7riQXFHHVd+PqdzaltS6Jpyz
 FBOk9B5zHnB7zmyrPYrKDwI0mrmf0ucQxaFJiORHcyxopssvHUM8BN3flR7CnvNLcQfR
 Db3CUKSX6yYWcFUHGAjl9Bk4o44fop9cth0rE2N2omXh/OvjmBTvIb7+3FJ6D7F6DGVQ
 o3+qIyRQJvdq9sT3wJKGpiCxpOi8/JMBnEiSOWx9+2MnyjHGs7PB4iLRvPFzjxVT+9zc
 wXgiGSpqzhUOADeyKRRPCJtvkDU/ILhKggcxZYxRMBEFZKnsAKVlWVwqnV0yXNw9hT+I
 lqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863635; x=1739468435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLHLI00NaE0U8yZiINJW4K2nBh4ICrixk0gO1c2R5o4=;
 b=rLLz/wbycSvCCiX3lRknJ0/i3BwMqwYEvo+BHxM+Zc/JhYEngYkdn8d4bQ3xr8+1tl
 Q2D0S8oPJcxkKOXisl8xdYhkoLxM2vPmeFt/oLTek1EJ0UKpfD3sy0z/lVt4ljmDEtJk
 ezVc3XtkYraWaQoN3yBAsdj6j33mDFAZXQtM01nRZY6ZUujbSkDNry4iS6T+JhS4ZVRp
 wV0VevHKOvbskhoOwWynTNyUmPXrbc14K06hKwoCogxuFLIY/MlJs6qfksI6rriRvLwM
 S/m+OtDby594dblg9w2Jbhkr5owvO+l7rJ+iZGt9mjY/RqVtRv8EIz8loroZFoqDVz1D
 6KSQ==
X-Gm-Message-State: AOJu0Yxit9EaWtFaMl7T4XSKn9/aSB7f+zIGlEN8Un5rsJrpFSMsJedN
 6+1QTjpmQOVgXxuep9YiI8SVbXEPR6+ET0qbqhla6S2g4szQ1Zmg9TVX61KshQ9Gww==
X-Gm-Gg: ASbGncvjZMLb3bq3Rh11/Xok5+fYI9jiqP1bWLCqnfUizecBdldb05kXk001OtilJTj
 9fvr5gUqk/gn9cHYgmmyC3RGV/awMJ12Kd4pEzdBlRWiqy/8TKEhihLOOR/+iwU+zogscFkZPQs
 VRHq+utoIJ4agPMTmThzkw/K2ekyl0K2aOqpk4RJUsWaXMKyGbj02baHkAQKFlkxA2/6pqx+sOn
 L58F6kS8JTLa2kcbxyAgPZnzKq9yas9t4P0sDu3BtTw8l8eclhuEO0bVVTXIFkkwUx5W04CnDPv
 aDS3iOLRyyUIBykbEPCkHrGe
X-Google-Smtp-Source: AGHT+IFYNjxqf/apzI8SD/xtzh7RmSBV0dYaa3BZY5ryD73NOaaTT2ZIz1xR/QGZwtThQu9WIbYXIQ==
X-Received: by 2002:a17:903:990:b0:21f:dc3:8901 with SMTP id
 d9443c01a7336-21f17ec7badmr138822615ad.34.1738863635500; 
 Thu, 06 Feb 2025 09:40:35 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:35 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 3/8] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
Date: Thu,  6 Feb 2025 14:40:13 -0300
Message-ID: <20250206174018.465530-4-adriano.cordova@canonical.com>
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

The coomand bootefi calls efi_init_obj_list to do the efi set up
before launching an .efi payload, but efi_init_obj_list is called
only once. There are some initializations which depend on the
environment and should be done each time a payload gets launched and
not only once. A motivation for this changes is the following order
of events:

1. Launch an EFI application (e.g. bootefi hello)
2. Change the ip address
3. Launch another application which uses the pxe protocol

As the EFI pxe protocol was initialized when the handles
for efi net were created in 1., the ip was hardcoded there.

In this example, another possibility would be to make a callback for ip
address changes to go all the way up to efi_net.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..164586742ae 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <asm-generic/unaligned.h>
 
+#define OBJ_LIST_INITIALIZED 0
 #define OBJ_LIST_NOT_INITIALIZED 1
 
 efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
@@ -208,6 +209,18 @@ out:
 	return -1;
 }
 
+/**
+ * efi_start_obj_list() - Start EFI object list
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_start_obj_list(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	return ret;
+}
+
 /**
  * efi_init_obj_list() - Initialize and populate EFI object list
  *
@@ -217,7 +230,9 @@ efi_status_t efi_init_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
-	/* Initialize once only */
+	/* Initialize only once, but start every time if correctly initialized*/
+	if (efi_obj_list_initialized == OBJ_LIST_INITIALIZED)
+		return efi_start_obj_list();
 	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
 		return efi_obj_list_initialized;
 
@@ -349,6 +364,10 @@ efi_status_t efi_init_obj_list(void)
 	if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
 	    !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
 		ret = efi_launch_capsules();
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = efi_start_obj_list();
 out:
 	efi_obj_list_initialized = ret;
 	return ret;
-- 
2.45.2

