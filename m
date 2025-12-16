Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456DFD5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 07:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9DC80077;
	Tue, 16 Dec 2025 08:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="abGNaMxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FDF800AB; Tue, 16 Dec 2025 08:47:17 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9FE8003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 08:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso42781255e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 23:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765871235; x=1766476035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LqVOYrgNXhtjysfbD5/bFYwaw7PRa/7Me3nmEJObh5g=;
 b=abGNaMxULVWqymv7V2iWQxPcfImBdUxqSOx07IkZloaihiQD3a/kMHto+gqC6ZPKFP
 OLh4jXN/KZpLqcTsfYdqGK9v7g9PlkCT0NGNFgodveIhoj/XC48cCf7UsyFw6A6Wh3Pk
 7gBXnyE4CtWwiMsn8rlORItULMbmFj5a5fUqjjlB3y5BwKaZ3lwSA5oq4u1dH4RB9SX8
 BvrLnOGJLi5z3T5Ztwpq4TvO0H3sMeqEqXpxII7QB7/vImxpntAIj1jOQof16fWbtaCG
 AS9bjZa9f5A3lP+R43BzQRgrO25MpZytl2DsHMvLY0J9TkR0WFFBx59v5Lo5U5Ev5yca
 jxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765871235; x=1766476035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqVOYrgNXhtjysfbD5/bFYwaw7PRa/7Me3nmEJObh5g=;
 b=MG9bMEi8LtW0qUn2REAjmxo29Ev3PSuQBTTaniMQs0oWCGX0KCPMBToEdxF2bhk67q
 nuDbz1y3eNIv2+MREIBrIvgkI7YjnTgsOc1Cf8UOUK8xp/CL1B60gWeIbSSNge0N7JJG
 rMRgcdETZ6UuUJAh0kSNeVdboNRbyqPf0RaYfeZl7ydj2vSJbOrwkNn4UuxjYwRKNoz+
 pX8yyq38TJPjPfiFmb9RiSvJY/9KZPVxJ/Y5yJJ8OdtA6IZAWyXMBpFVy+NWlk0qs70V
 C3O18xjaAqXZ64l/RRUAfR5fKT04u4tPDmcnVMA7CHTxiUnsn6JJ45hrkspWvsveaXq/
 Q6gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nkQgrMqMhsyrQ9jh0Zcp3ldvAgZD6U0NLwEi8Ep+93Zezbo0zTNDXJhUL80QmC68bRyS+bY=@lists.denx.de
X-Gm-Message-State: AOJu0YyomlRtEPRyctWcnI17KMeTo9XEMGs443W3XtGsu3p1igfKhe/W
 z7AABvRZsKKJamdoXPq0AQuACDYLaeFyLv20yxgYwZ10acGMFa5cXtdi1UDPEyE91Qk=
X-Gm-Gg: AY/fxX5PTvSClCPVbDDkJWKQkYsAUkXkXWS6vVbXL+XtIIE7N5WmGXtU5XZeN5dgPZW
 SoRTOrwFFdg1blWI+Yz4I1cLoDHwwzVNR4Ufl8yAKM+RlFP0ktAGeSuUYmtExDgO5/DI2RTrHKf
 ESPNF9lvi25nB2Fu7X4HhhSasRDQt8GGM06ul9PsfR0B21aL7u65A/NbLO5JRG4UC5tX+N4OUlq
 Ft/TVyTy2LCND6S1VD9jhClkJJYFD+3TM40t7T2fEQW4SQVxKnn0lOH5dk1ZBQ9NCfB/8pwgVkf
 a2rh+Cypm79/GjMgIhO38BPw1kvKcx0BCVXvQ3k57morEIXalZCKu4G9SLhQGVsVLi0jGxPEySw
 4EBxbLW5HBZHH5fmMI1POP+VD1RBUTJqWngsZzY1HYrsHUeGe7+lQ+tEB0WJt+az/SmOgslwrub
 +67tiXuzJtYoYBjgHas7UwWnTj0YqFhU9x2iVli5uCjjga+cJld+B2ojrLXd1gIHz8LmbbwBhq4
 9o5Tovr/sP18006ZenNyk+znA/0IGJ6EiBMal6rnlPFTlnbaILjmz7HRa59ZCBvkJnjYmWBpe43
 836GtRWXud/rB/63dIrEOSNT+Nip951V+dzJqT+d32JmUrHcCLZHZ1DuhUX7//KFiaE7m0dX/Jm
 Cq2UPaJ6p0cHolUDWjJoMcZifNmANPRyEMzAf7EvnV8P3iyEJ0U6oudA7lP7SM3tlkUrCc4fz/l
 jyy2NUBV1fpAcFRvX/S8p4hYvwnlQ/lyX2GCtAHFmMZwyNllyTfLA=
X-Google-Smtp-Source: AGHT+IFPDOgk9yFnOSJUJ4Wk5eV9QLl+zhpu854CAQVYuGxtebhruZklfJoJ6Sh5tvyZiAbqf17Dgg==
X-Received: by 2002:a05:600c:1994:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-47a8f0a444emr144066035e9.6.1765871234704; 
 Mon, 15 Dec 2025 23:47:14 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f768936sm233520825e9.6.2025.12.15.23.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 23:47:14 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com,
	andrew.goodbody@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v3] efi_loader: Trigger capsule updates with automatically
 generated boot options
Date: Tue, 16 Dec 2025 09:47:09 +0200
Message-ID: <20251216074710.270479-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The EFI spec in §8.5.5 says
"The directory \EFI\UpdateCapsule is checked for capsules only within
 the EFI system partition on the device specified in the active boot
 option determine by reference to BootNext variable or BootOrder variable
 processing."

Automatically generated boot options don't point to the ESP, they point to
the disk itself and find_handle() won't match when searching for an ESP
during a capsule update.
This happens because find_handle() only matches device paths that are
shorter or equal to the device path passed as an argument.
Since the EFI spec allows it we want to allow capsule updates, when the
boot option points to a disk, but that disk contains an ESP with a
\EFI\UpdateCapsule directory.

So, let's change device_is_present_and_system_part() and check if the
supplied device path contains an ESP. If it does return the handle of
the device. Otherwise, iterate over child devices and return the handle
of the first child that contains an ESP.

The returned handle can then be reused later. Rather than calling
efi_fs_from_path(), we can simply look up the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
on the discovered handle, avoiding the need to re-parse device paths.

Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reported-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes from v2:
- Changing efi_dp_find_obj() wasn't too intuitive, since we only matched
  the longest device path we found from a prefix and made the code complex.
- Change the implementation and iterate over the device children to locate an
  ESP, if the supplied DP is not one.

 lib/efi_loader/efi_capsule.c | 67 +++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index eafc647f558f..60ce03b4254a 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -8,6 +8,7 @@

 #define LOG_CATEGORY LOGC_EFI

+#include <dm/device.h>
 #include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -878,30 +879,48 @@ static efi_status_t get_dp_device(u16 *boot_var,
 }

 /**
- * device_is_present_and_system_part - check if a device exists
+ * get_esp_handle - check if a device exists and contains an ESP
  *
  * Check if a device pointed to by the device path, @dp, exists and is
- * located in UEFI system partition.
+ * either an ESP or a disk containing an ESP.
  *
  * @dp		device path
- * Return:	true - yes, false - no
+ * Return:	ESP handle or NULL
  */
-static bool device_is_present_and_system_part(struct efi_device_path *dp)
+efi_handle_t get_esp_handle(struct efi_device_path *dp)
 {
-	efi_handle_t handle;
+	efi_handle_t handle, dev_handle;
+	struct udevice *child_dev;
 	struct efi_device_path *rem;
+	efi_status_t ret;

 	/* Check device exists */
-	handle = efi_dp_find_obj(dp, NULL, NULL);
-	if (!handle)
-		return false;
+	dev_handle = efi_dp_find_obj(dp, NULL, NULL);
+	if (!dev_handle)
+		return NULL;

 	/* Check device is on system partition */
 	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
-	if (!handle)
-		return false;
+	if (handle)
+		return handle;
+
+	/* If it's a disk check its children */
+	list_for_each_entry(child_dev, &dev_handle->dev->child_head, sibling_node) {
+		if (device_get_uclass_id(child_dev) != UCLASS_PARTITION)
+			continue;
+		if (dev_tag_get_ptr(child_dev, DM_TAG_EFI, (void **)&handle))
+			continue;
+
+		ret = EFI_CALL(systab.boottime->open_protocol(
+			       handle, &efi_system_partition_guid, NULL, NULL,
+			       NULL, EFI_OPEN_PROTOCOL_TEST_PROTOCOL));
+		if (ret != EFI_SUCCESS)
+			continue;

-	return true;
+		return handle;
+	}
+
+	return NULL;
 }

 /**
@@ -920,6 +939,8 @@ static efi_status_t find_boot_device(void)
 	int i, num;
 	struct efi_simple_file_system_protocol *volume;
 	struct efi_device_path *boot_dev = NULL;
+	struct efi_handler *handler;
+	efi_handle_t esp = NULL;
 	efi_status_t ret;

 	/* find active boot device in BootNext */
@@ -940,7 +961,8 @@ static efi_status_t find_boot_device(void)

 		ret = get_dp_device(boot_var16, &boot_dev);
 		if (ret == EFI_SUCCESS) {
-			if (device_is_present_and_system_part(boot_dev)) {
+			esp = get_esp_handle(boot_dev);
+			if (esp) {
 				goto found;
 			} else {
 				efi_free_pool(boot_dev);
@@ -967,26 +989,29 @@ skip:
 		if (ret != EFI_SUCCESS)
 			continue;

-		if (device_is_present_and_system_part(boot_dev))
+		esp = get_esp_handle(boot_dev);
+		if (esp)
 			break;

 		efi_free_pool(boot_dev);
 		boot_dev = NULL;
 	}
+
 found:
-	if (boot_dev) {
+	ret = EFI_NOT_FOUND;
+	if (esp) {
 		log_debug("Boot device %pD\n", boot_dev);

-		volume = efi_fs_from_path(boot_dev);
-		if (!volume)
-			ret = EFI_DEVICE_ERROR;
-		else
+		efi_free_pool(boot_dev);
+		ret = efi_search_protocol(esp, &efi_simple_file_system_protocol_guid,
+					  &handler);
+		if (ret == EFI_SUCCESS) {
+			volume = handler->protocol_interface;
 			ret = EFI_CALL(volume->open_volume(volume,
 							   &bootdev_root));
-		efi_free_pool(boot_dev);
-	} else {
-		ret = EFI_NOT_FOUND;
+		}
 	}
+
 out:
 	free(boot_order);

--
2.43.0

