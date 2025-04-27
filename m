Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65568C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 23:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F16B80FDA;
	Mon, 28 Apr 2025 01:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrsRHyJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA94C81E0F; Mon, 28 Apr 2025 01:45:04 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D0F80F9C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so3485732b3a.2
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745797501; x=1746402301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n006d3fOhf1FAurPSeKFVJBHXsTkx2gTwvmmKr2JWcs=;
 b=YrsRHyJHFpVR4vnU0wnX3+scpNuNcrt9RYUJck/VwgH2JqaLQVpiRAEZzVzbzZDR7m
 AnznszoXRdYR3PKwF3KSBVOlrQW5awwGcezVA3IhxU0s37FCgG+3jOSrIGwxA2TKih41
 H3qspRGHnZeOuGBPO7zj2xFHmAD6fdoEnmHjDkBYupdGg3Ih0jBXClETcmsJkz3M3vDt
 amR2veohvMVIMG4T190ZnH7FNjU3OKC3Mw5oH9eGnnl6frkLe2dDM4cDSeJO4K1d3ytu
 z2W95Xwmr5C/MPmh51QJIHFk6gpB9p23XF4/+GMnXa0ORMeYLvGqh6v5l+P7BNzK7lSD
 waLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745797501; x=1746402301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n006d3fOhf1FAurPSeKFVJBHXsTkx2gTwvmmKr2JWcs=;
 b=JPvCZKxK5Lw5MXXQoyQqb15i9KTG/kOruTOCkR+G8aIWGMF3RskBrMNUFQjyNjqiuO
 D20OVPYRqAjaq1G5bnbxOG85UW4s/NaUJeVWxk/qkvD3LLJwkcDIG1Xeb6J1MX/93k4e
 LOvfptsUrUeAC6AMT2IxnZd0lOQbsJLmagzwPu3WPgaac/uN/2Y16FJa5tHxMTFXdurl
 oF9BW74slIMyuXvoTn8q0Ln70RAjut6w6MkbRb9VfVb5wBjOuKKOk0aICFiX7jlV75Lq
 JTMtK50Xj3vLmPzflzFXOL4I12bFSPqc+KzPBN0trrpivRO70weyzUQ33vSxwsrZzcZP
 GqnQ==
X-Gm-Message-State: AOJu0YyAeNntB1MVwfceVftYeQwTmdNySfS+iVQRHEij6eWg5WNBDPsL
 3yWyHJdwBKq6Zlxokq1yr6uqUYPXtafeixMEj+cYBqoRK+fgpi5nDNJ4YgJiRUI=
X-Gm-Gg: ASbGnctpzbZTCCrPvkREEQEY0sdvNBmbo1WJeNzffsyryOvNIpUbDaVHKglSSBOnhaF
 tBEJ8I45U8fM5uS7LSOKfqjKtpTwAlK7PvRrnX/jmTCPvso02PBArfYp1UVPZvRQ+WN8fnZscS/
 kRQWCkVmsdgzVku8Ss8a/CyU3G4LXrfRoxqub3VdMe2n5S5bV3xBjpdjwJS1PgG4dB8OAyppTX/
 bUzVnq3GbHRvPxjEs4Fm8iRE+sJZDqBAI+cQYQt+WzLM/lYBqmMvM+7nRJ1eNtcwzUqswt7u2hx
 he1bJ+Vhknlpp5k4nK+ZV+y1UnAbzKl9e5REUz341Fg82fiLBA==
X-Google-Smtp-Source: AGHT+IGASfGby2PGHQdpNsKIeiZ2MZ9kY6VZdNYDM8WEr//Za98QfY96df4azAdr7zetiBHMoAeHZg==
X-Received: by 2002:a05:6a00:39a1:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-73fd876d8d9mr13605202b3a.16.1745797499924; 
 Sun, 27 Apr 2025 16:44:59 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a874sm6945831b3a.97.2025.04.27.16.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 16:44:59 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH] efi_loader: bootbin: do not load an initrd if none is provided
Date: Sun, 27 Apr 2025 19:45:26 -0400
Message-ID: <20250427234527.2076444-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Do not try to create an initrd device path nor try to register
an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.

Handle initrd installation in efi_binary_run_dp with
efi_install_initrd, imitating what is done for the fdt.

Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
Reported-by: Weizhao Ouyang <o451686892@gmail.com>
Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 boot/bootm.c                 |  3 +++
 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootbin.c |  9 ++-------
 lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f5cbb10f0d1..9693e0d336d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1008,6 +1008,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 			ret = 0;
 	}
 
+	/* Clear the initrd from a previous boot */
+	images->initrd_start = 0;
+
 	/* Relocate the ramdisk */
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
 	if (!ret && (states & BOOTM_STATE_RAMDISK)) {
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 144b749278a..84e8cfe320e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 void *efi_get_configuration_table(const efi_guid_t *guid);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
+/* Install initrd */
+efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
 /* Execute loaded UEFI image */
 efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image with given fdt */
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index d0f7da309ce..94ba7c5589b 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -215,12 +215,11 @@ out:
  * Return:	status code
  */
 static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
-				      void *initrd, size_t initd_sz,
+				      void *initrd, size_t initrd_sz,
 				      struct efi_device_path *dp_dev,
 				      struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
-	struct efi_device_path *dp_initrd;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
-	if (!dp_initrd)
-		return EFI_OUT_OF_RESOURCES;
-
-	ret = efi_initrd_register(dp_initrd);
+	ret = efi_install_initrd(initrd, initrd_sz);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 3936139ca41..6a863c3556c 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_install_initrd() - install initrd
+ *
+ * Install the initrd located at @initrd using the EFI_LOAD_FILE2
+ * protocol.
+ *
+ * @initrd:	address of initrd or NULL if none is provided
+ * @initrd_sz:	size of initrd
+ * Return:	status code
+ */
+efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
+{
+	efi_status_t ret;
+	struct efi_device_path *dp_initrd;
+
+	if (!initrd)
+		return EFI_SUCCESS;
+
+	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
+	if (!dp_initrd)
+		return EFI_OUT_OF_RESOURCES;
+
+	ret = efi_initrd_register(dp_initrd);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return EFI_SUCCESS;
+}
+
 /**
  * do_bootefi_exec() - execute EFI binary
  *
-- 
2.48.1

