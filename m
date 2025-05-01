Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3098BC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234E482132;
	Thu,  1 May 2025 03:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="igJfciDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6749F820EB; Thu,  1 May 2025 03:14:37 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D088E809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso5018665ad.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746062073; x=1746666873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvNS1dzidF5YOI3Mp7579pZQkAFoPA9M6XDJiD0SHa0=;
 b=igJfciDgkp65k0zxIhT580O9BWGxMndsp0KrliXE8glpR8fBhkLfcLF52+/e/DRPwL
 tyWgbk5TT7EKrcRp55dGJtC92Bq/lXqMmlwlxVb6EjBmOXdTCdNxW/vp42JASHqZ60G6
 up8Kr8QCExgCqQrcA4hmRmhf5Bqm/dxS3JraciY3AmCYLclVfpTlx6Z4oQ4WLq8bD/cK
 BON36Zs/t3Lv/UtfWOCBD5TedNUTAW3LMoHlu1IpZo3HchyWYYPeiEpJiZ9XmkBwx33f
 UPYly9G0EklIBN8oT+dWzBzfwVhV77f0cEQTPJoUczDX9Yp+7Clc489y7l2iPLIJK35D
 dIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746062073; x=1746666873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvNS1dzidF5YOI3Mp7579pZQkAFoPA9M6XDJiD0SHa0=;
 b=ZnTRaVEC9xCxabD+2ozmnWmAY2T9sBRb6gNXPmfl0bY6OSpGH4vHVnCqY8upJeCFwg
 l1vrrig5Vsai86m52TKEmfVoAcXeDQk+skP0jOcBwkjPavZGfWIwEJ9jWHfFQNHQZWRC
 zo2VUwpcjXCMXYW+km7Ag9koFTiP0rtdp577f+6ydZ4aNO4Rvtn4poouq/eqPAi3Z0jZ
 aki7Hi/an192ddApb9HNWHmBJnju0HKaY4Ba9UiyJFhZrujk9+M/dkgGV98Ye1oiEixZ
 vydMThVRNmIZQQUvifm3nhUgrAU2qWjsuPCM986xOmPqOSQMfQrVXmiXS12YgNlzw8kF
 Dqkg==
X-Gm-Message-State: AOJu0Yzz0qNCr/E7ZoPAugY8OIQRDh47ThhRAYMR9Jq/poyXwLUC6WtO
 KnhdURmdXby0vfg4ogISVTuAdx6lqhLNL6rJz9TM0y/fnDrBswPJrW0iPwUA
X-Gm-Gg: ASbGncstIns7vwjDhmlQfRwhzyAgVWRH/GYHn6mCcLoYN1/a0CS3eiw9Yuh4z9PzrUc
 8AMCZtvTPpaLfWpIk1DFwsYDe7yCHB/XUdk4fan+vbFZ5crNOPFTvKUoPOC7V7jU6DuPz6W5xQx
 qnEETAtdHcPbZLxMf17Xd+7+cWrQSFaHjkPMh+dpwHCXRtllpBO9j6l+eOq8eG9WA6NGkHrWiOn
 rb2qEu1IM8rqnJQfKUes9ZsIhUYUSXK1ua4vkMjVj3LA7Fbb+g/UBWvvGp0+D5JVMecRUXdDft3
 ApTKofBKKl+OpSQTsp2K7yqQnfaABBSgwr40bT2AVW0jIb4Tjg==
X-Google-Smtp-Source: AGHT+IHiBYX5/zo7+PR8x58qjUFkfNTcFSE9QIfQ+JSK65WnJhh/dB6S312X06GsbkTyDTwaLjC8pg==
X-Received: by 2002:a17:903:1ace:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22e0863ab35mr10696595ad.41.1746062073225; 
 Wed, 30 Apr 2025 18:14:33 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52214fdsm128736615ad.251.2025.04.30.18.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:14:32 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/2] efi_loader: bootbin: split initrd registration and
 installation
Date: Wed, 30 Apr 2025 21:15:13 -0400
Message-ID: <20250501011514.2209452-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250501011514.2209452-1-adriano.cordova@canonical.com>
References: <20250501011514.2209452-1-adriano.cordova@canonical.com>
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

Current support for initrd in EFI booting has two flaws:

1. Installs a NULL initrd via LoadFile2 protocol if `efi_binary_run_dp` does
   not provide an initrd. In this case, a LoadFile2 should not be installed
   at all.
2. Initrd is not properly uninstalled if booting fails at some point between
   initrd installation and the call to `do_bootefi_exec`. This affects both
   booting via `efi_bootbin` and via `efi_bootmgr`.

This commit splits the process of setting an initrd into two steps:

First, `efi_initrd_set_from_mem` creates a memory-backed device path for the
initrd. (This step is not necessary when using `efi_bootmgr`, and for now is
only used when booting FIT images, but the `bootefi` command could now be
expanded to receive an initrd argument.)

Second, `efi_initrd_install` creates an initrd handle and installs the
LoadFile2 protocol exposing the initrd. This is needed both when booting with
`efi_bootbin` and with `efi_bootmgr`, so it is called in `do_bootefi_exec`,
which is the first common point between the two bootflows.

Also, as `do_bootefi_exec` is the only place where `efi_initrd_install` is
called, the cleanup function `efi_initrd_uninstall` can be called before
exiting `do_bootefi_exec` instead of using the event
`efi_guid_event_group_return_to_efibootmgr`. (This also makes more sense as
now initrd is also used by `efi_bootbin`.)

Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
Reported-by: Weizhao Ouyang <o451686892@gmail.com>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h             |  8 ++-
 lib/efi_loader/efi_bootbin.c     | 14 +++---
 lib/efi_loader/efi_bootmgr.c     |  7 ---
 lib/efi_loader/efi_helper.c      | 11 +++++
 lib/efi_loader/efi_load_initrd.c | 84 +++++++++++++++++---------------
 5 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 144b749278a..0a3ca799287 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -597,6 +597,12 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 void *efi_get_configuration_table(const efi_guid_t *guid);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
+/* Install initrd LoadFile2 protocol */
+efi_status_t efi_initrd_install(void);
+/* Uninstall initrd LoadFile2 protocol */
+efi_status_t efi_initrd_uninstall(void);
+/* Set an initrd */
+efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz);
 /* Execute loaded UEFI image */
 efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image with given fdt */
@@ -667,8 +673,6 @@ efi_status_t efi_http_register(const efi_handle_t handle,
 			       struct efi_service_binding_protocol *http_service_binding);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
-efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
-efi_status_t efi_initrd_deregister(void);
 /* Called by bootefi to make SMBIOS tables available */
 /**
  * efi_acpi_register() - write out ACPI tables
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index d0f7da309ce..637f2c0d195 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 				      struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
-	struct efi_device_path *dp_initrd;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -234,13 +233,12 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
-	if (!dp_initrd)
-		return EFI_OUT_OF_RESOURCES;
-
-	ret = efi_initrd_register(dp_initrd);
-	if (ret != EFI_SUCCESS)
-		return ret;
+	/* Set initrd if provided */
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
+		ret = efi_initrd_set_from_mem(initrd, initd_sz);
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
 
 	return efi_run_image(image, size, dp_dev, dp_img);
 }
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c0df5cb9acd..19c7e16a25b 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -683,13 +683,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	if (ret != EFI_SUCCESS)
 		goto error;
 
-	/* try to register load file2 for initrd's */
-	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		ret = efi_initrd_register(NULL);
-		if (ret != EFI_SUCCESS)
-			goto error;
-	}
-
 	log_info("Booting: Label: %ls Device path: %pD\n", lo.label, lo.file_path);
 
 	/* Ignore the optional data in auto-generated boot options */
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 3936139ca41..b4c207ea33f 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -658,6 +658,13 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 		goto out;
 	}
 
+	/* Create initrd handle and install LoadFile2 protocol */
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
+		ret = efi_initrd_install();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	/* Call our payload! */
 	ret = EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data));
 	if (ret != EFI_SUCCESS) {
@@ -683,6 +690,10 @@ out:
 		}
 	}
 
+	/* Destroy initrd handle with LoadFile2 protocol */
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD))
+		ret = efi_initrd_uninstall();
+
 	/* Control is returned to U-Boot, disable EFI watchdog */
 	efi_set_watchdog(0);
 
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index b5d58943a80..7210bf16d09 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -74,7 +74,40 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
 }
 
 /**
- * efi_initrd_from_mem() - load initial RAM disk from memory
+ * efi_initrd_set_from_mem() - set initial RAM disk from memory
+ *
+ * Set efi_initrd_dp to a memory mapped device path pointing
+ * to @initrd. If @initrd is NULL then efi_initrd_dp gets cleared.
+ *
+ *
+ * @initrd:    address of initrd or NULL if none is provided
+ * @initrd_sz: size of initrd
+ * Return:     status code
+ */
+efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz)
+{
+	struct efi_device_path *old_initrd_dp;
+
+	old_initrd_dp = efi_initrd_dp;
+
+	if (!initrd) {
+		efi_initrd_dp = NULL;
+		goto out;
+	}
+
+	efi_initrd_dp = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
+	if (!efi_initrd_dp) {
+		efi_initrd_dp = old_initrd_dp;
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+out:
+	efi_free_pool(old_initrd_dp);
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_initrd_get_from_mem() - get initial RAM disk from memory
  *
  * This function copies the initrd from the memory mapped device
  * path pointed to by efi_initrd_dp
@@ -84,7 +117,7 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
  *
  * Return:			status code
  */
-static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void *buffer)
+static efi_status_t efi_initrd_get_from_mem(efi_uintn_t *buffer_size, void *buffer)
 {
 	efi_status_t ret = EFI_NOT_FOUND;
 	efi_uintn_t bs;
@@ -155,7 +188,7 @@ efi_load_file2_initrd(struct efi_load_file_protocol *this,
 	}
 
 	if (efi_initrd_dp)
-		return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer));
+		return EFI_EXIT(efi_initrd_get_from_mem(buffer_size, buffer));
 
 	ret = get_initrd_fp(&initrd_fp);
 	if (ret != EFI_SUCCESS)
@@ -224,14 +257,14 @@ out:
 }
 
 /**
- * efi_initrd_deregister() - delete the handle for loading initial RAM disk
+ * efi_initrd_uninstall() - delete the handle for loading initial RAM disk
  *
  * This will delete the handle containing the Linux specific vendor device
- * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
+ * path and the installed EFI_LOAD_FILE2_PROTOCOL for loading an initrd
  *
  * Return:	status code
  */
-efi_status_t efi_initrd_deregister(void)
+efi_status_t efi_initrd_uninstall(void)
 {
 	efi_status_t ret;
 
@@ -255,42 +288,22 @@ efi_status_t efi_initrd_deregister(void)
 }
 
 /**
- * efi_initrd_return_notify() - return to efibootmgr callback
- *
- * @event:	the event for which this notification function is registered
- * @context:	event context
- */
-static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
-						  void *context)
-{
-	efi_status_t ret;
-
-	EFI_ENTRY("%p, %p", event, context);
-	ret = efi_initrd_deregister();
-	EFI_EXIT(ret);
-}
-
-/**
- * efi_initrd_register() - create handle for loading initial RAM disk
+ * efi_initrd_install() - create handle for loading initial RAM disk
  *
  * This function creates a new handle and installs a Linux specific vendor
  * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device path
  * to identify the handle and then calls the LoadFile service of the
- * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd is
- * not provided, the initrd will be taken from the BootCurrent variable
- *
- * @dp_initrd:	optional device path containing an initrd
+ * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If efi_initrd_dp
+ * is not set the initrd will be taken from the BootCurrent variable. If
+ * an initrd is not found the handle is not created.
  *
  * Return:	status code
  */
-efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
+efi_status_t efi_initrd_install(void)
 {
 	efi_status_t ret;
-	struct efi_event *event;
 
-	if (dp_initrd) {
-		efi_initrd_dp = dp_initrd;
-	} else {
+	if (!efi_initrd_dp) {
 		/*
 		* Allow the user to continue if Boot#### file path is not set for
 		* an initrd
@@ -314,12 +327,5 @@ efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
 		return ret;
 	}
 
-	ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
-			       efi_initrd_return_notify, NULL,
-			       &efi_guid_event_group_return_to_efibootmgr,
-			       &event);
-	if (ret != EFI_SUCCESS)
-		log_err("Creating event failed\n");
-
 	return ret;
 }
-- 
2.48.1

