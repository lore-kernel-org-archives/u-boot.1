Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0903D65522
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 09:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5D3839FA;
	Wed, 17 Dec 2025 10:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o6ROgvwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9FA83AA0; Wed, 17 Dec 2025 10:40:12 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA12183979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso59238485e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 01:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765964410; x=1766569210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zWxExy4iQWukShUQ5TcV/jh98srGWatiFE48A7obtkE=;
 b=o6ROgvwmJA7NWaJT3+XqmlxrqIcEFbDNarHKBOq+xzaWWK3sr+h1goZWUX6vt9F46x
 DvB5hYzywhl84kNep1wI2MM266+zwYvC26HQZnIMEdAw9uVEUs5Lpekz8UxWlRdymnE9
 2hvDgJvUbhhhmIThli1NT3piaOX+8JEx5Jo2DJ8EyebCGDwT3lQIoxOLMeHZck6Nv3Ym
 7vcHwTBPTGZEG4hQjttwODzmqcWttqHdsOrt/1viiPOU/owT/NURIZnOBpG+mCBRCq3v
 uraIpHdSuRtL6gvIYCqSRqqN3XYA5ymO8W5imQ7sH2JoFhQ25TfurJ27ob/9209k4qj6
 U9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765964410; x=1766569210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWxExy4iQWukShUQ5TcV/jh98srGWatiFE48A7obtkE=;
 b=PuxyW+CtTF5D7W7PMxqNhOA7jJx08XD0McaNPVMkMUuN5mf0MXjnQX3TB6hVCO6lUm
 ILtvUHbq6tKhQZw3KbKKU9GqqDbWDmkJmHrP59s8/+MoVisUoLrwAw/ZOA3C+wOJw5Fn
 0b03udFYRT0MZJzeSTOwXV5+rwxUgvihcj5ZKNDZ2xovrGC/AAPeQKbUSRABW44NHuzN
 KfEoy2uT6pTYzeKJPMZD1UY2g+Vs6nTmmyqhzjC/bzMjaq1n56GjjPLm33/sQ9UpOfmJ
 lX2gaw5m8oYTRmcODEiTzUCyVBta8qBMoOY3yyWfHnVmsvZDLGaDqdZAz2r6GfcDvA7t
 U4zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX42utPDB3L6qoItQBUWh2zrZnK67BHrPdq/PuO5mW3eVlVotObj/efztewuPXxwpMzNksprb8=@lists.denx.de
X-Gm-Message-State: AOJu0YzrWWR2UQBQMAqYG6js5QiutmcT0Vr3wEagptKqtuJhsISzB7Ua
 oW8CNZZPqM1FemsaPkiaOiQwEv8ZtVPB2v6tJOrUWDNZ5mJqHXvG3MiuCdbgyALdJbU=
X-Gm-Gg: AY/fxX6yoR/YXPbQC9CfMKgbxmgw+AzvDACL7KaBsCm395vi+1kJMZuGIsO9xvAC37r
 OeHvYP7GxiEl2qCjg3zVuQPQDt5xPGBtQc+vGKbSFnm0EkfdQaWEyatmons/fHZr3KeBJm2NBh0
 lpUR1GViwicwQQ+U9HzXCEkU4Ma63ZdrMha05FgHfa9vGWpOCaUc2joQLj2s960jx5cxxs8ZESY
 tMihuRC0bcs9ZKDYAr8iW09JRDTe4WutNQy7XpPP1JQ8EDf5FO7Fr6Vx8u7QEVdKtvoZcSpujEi
 LWlPL5ZYkGPqW6b+5PfktsFrQRPq9G1t2peLx25kMxBP64KOwkLNYmE8NYdso3ujg3sKKONIL85
 KgTR0zO8IilgmPvUNz7kdiPlJ8AJ35o+6rQwpKnqJLu7J0glATwddyY/zbjEUh4Miu9+Lh48C/N
 4tbpo/ilDOFa1MZmjyAsYxN9vErrEpCpwkpuOeyAwR4Id/qd18L26zzZ9K4baAnHx5BGPysTrJ2
 k/U3D67q/ZeyQfD63Gt0PL7jGcVeHukia7tRIvXbyXHhQiAbxz+Kj90wVtdj9nvW7JkOxVMahAy
 T1HNf4Tq6Qb0oyLs0vGG8/k04dAcZ7m9fcrqTc37r8ZfEMVeUGD8lZ1/kYQY5dT4hNvGcWhft/Z
 YYK6nZx/CKSgtTiI8HTp8Z/702Hb3j75Yt2gqGaIDu6FEuFmTYNbM8r/F8YK2LPVp+6w1i4/iRN
 wgEK8y18eJgiEgbTNg6qqllOS2j7/xoXE0qDDKsuxMbUIYwtwQdnHxqPRiKLNl+A==
X-Google-Smtp-Source: AGHT+IEzlajLtRnXHerYgQjshY5sGCrdm+9ZN6TOt8/IDVOJeBc+3GE1+VEYdfSYL+Nf4/nbqiiiLg==
X-Received: by 2002:a05:600c:4e91:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-47a8f904609mr181269525e9.21.1765964410173; 
 Wed, 17 Dec 2025 01:40:10 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310adacfafsm3841840f8f.10.2025.12.17.01.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 01:40:09 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com,
	andrew.goodbody@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v4] efi_loader: Trigger capsule updates with automatically
 generated boot options
Date: Wed, 17 Dec 2025 11:40:04 +0200
Message-ID: <20251217094006.306237-1-ilias.apalodimas@linaro.org>
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

Changes from v3:
- Update comments to better match the function functionality

Changes from v2:
- Changing efi_dp_find_obj() wasn't too intuitive, since we only matched
  the longest device path we found from a prefix and made the code complex.
- Change the implementation and iterate over the device children to locate an
  ESP, if the supplied DP is not one.

 lib/efi_loader/efi_capsule.c | 68 ++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index eafc647f558f..89e63ed8dd5c 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <dm/device.h>
 #include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -878,30 +879,47 @@ static efi_status_t get_dp_device(u16 *boot_var,
 }
 
 /**
- * device_is_present_and_system_part - check if a device exists
+ * get_esp_handle - Check if any direct child of the dp handle is an ESP
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
 
-	/* Check device is on system partition */
+	/* Check if the device path points to an EFI system partition */
 	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
-	if (!handle)
-		return false;
+	if (handle)
+		return handle;
+
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
@@ -920,6 +938,8 @@ static efi_status_t find_boot_device(void)
 	int i, num;
 	struct efi_simple_file_system_protocol *volume;
 	struct efi_device_path *boot_dev = NULL;
+	struct efi_handler *handler;
+	efi_handle_t esp = NULL;
 	efi_status_t ret;
 
 	/* find active boot device in BootNext */
@@ -940,7 +960,8 @@ static efi_status_t find_boot_device(void)
 
 		ret = get_dp_device(boot_var16, &boot_dev);
 		if (ret == EFI_SUCCESS) {
-			if (device_is_present_and_system_part(boot_dev)) {
+			esp = get_esp_handle(boot_dev);
+			if (esp) {
 				goto found;
 			} else {
 				efi_free_pool(boot_dev);
@@ -967,26 +988,29 @@ skip:
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

