Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333BAC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA52480AE1;
	Wed, 22 Jan 2025 18:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mmtJFfga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE5C80BA0; Wed, 22 Jan 2025 18:09:22 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA13F80ADE
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so166369455ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565758; x=1738170558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=506qeAbTtqcDJlxptqSzMluP5+LyeVkB9VIcGFmOh/Q=;
 b=mmtJFfga0ZXaiXF+xvrVG3ChJ41jH1ffIK/JcUVhIfiFgf/1hK2SbdQkpszHUJOQk7
 qFZu13/8sbIqX+VGUw5uwIsXjZfh97qO5zTnXKjSSk8q92x7huNOuqjkeYd09rYeJgiQ
 GeAY+02eZqHTPibDfml0Ck48mc6twmJhHDnRU1sTdy4BmmbY3Q7kc+OL/ac9tC5hmy+b
 yojHvZ5rKiovGpNfPouhEt8259dvY1zG9FNDgeQaTGbo1awlbw2Jqi+VkxtizKHl4BZ6
 I5aM28hkE9cZ3DdCA8p5+y6CrmBI4EOISUBOeiBHNmU37Eo2Z0PKpLeX3gRAfn1GdNgq
 fVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565758; x=1738170558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=506qeAbTtqcDJlxptqSzMluP5+LyeVkB9VIcGFmOh/Q=;
 b=asU1nZ1hnYhBAGgJqBxlk+lVmOX+BqnQwYOt9I4uSSM/B0GFz2wlDgirBKFm61Vo9j
 /l3ug1Qq/+NDNTy5LkHkg8IUdVuwd7pb3xu0SsKpfUa5LLMpla/ue8ssxsyiYZmUMIHB
 2lVVkBeHqqsSj4G8y9WjP6oU33p62WJhNLAf2s6AIOesh9Ev95zgbnI2LVbZf5/yUcIi
 NVZ49wCZt6brJQcGVT0ZPfRBU8cx9T50I3bs6MQnu/+fWYmbBgmTEICKrLrnRGhkY3Xl
 61F/WCseeR2lHIqO+ivbhIo5GL8mnpH4gfXcX2J7bXlAziDCgUXmE6Tqs8LXPF98iARy
 B8Tg==
X-Gm-Message-State: AOJu0YzyEM/ZgNkoCzh/CswCmsLprc74IH+mIsBo5qt1/RqazZk+ZU0q
 pr7TCelptyjNh+brleQ6QBqtxCKkDi46FheMcEBNNsNN2y5jSvVepF8OnM7i
X-Gm-Gg: ASbGncsS8v7wB91lIlWK3tMsatJPROIryLLdcJY2zaXElQy8LmlYDO8eWPRje4bWwmF
 WS0KJfTyPuLApm7q6VboNopRgpqVaY0XJVOwfNksTMtuOeRTuwoCjfQSYhgXbD56606gfQ5yiAR
 spdhjbrHDbGA/8guXS06LAK64AYoEIXETpdLiXLuYe9caBFDGauqk+lNdGQomQGcMW7x306MEJ2
 gdHcR4HboEzy1EGMwMY5U5CzY9R64H2rUO2CRJazUDrcKv4G1lRLD/oWCTNzhv2IO/trRf8QdE2
 Bg==
X-Google-Smtp-Source: AGHT+IE8gWes8SyamhO44dIPfZVwmv/yPSiQ5R3ivqY2sS1y0Cy979pvCFKf1SXgKbJjiv678logPw==
X-Received: by 2002:a17:902:da88:b0:212:5786:7bb6 with SMTP id
 d9443c01a7336-21c353ef3abmr310111585ad.3.1737565758392; 
 Wed, 22 Jan 2025 09:09:18 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:18 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 03/21] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
Date: Wed, 22 Jan 2025 14:08:40 -0300
Message-ID: <20250122170858.961359-4-adriano.cordova@canonical.com>
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
index aa59bc7779..164586742a 100644
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
2.43.0

