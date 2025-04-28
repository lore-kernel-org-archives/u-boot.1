Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F95C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF1B82A5E;
	Mon, 28 Apr 2025 16:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3OBkYz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9BD82B34; Mon, 28 Apr 2025 16:53:19 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C22682A5E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso5206113b3a.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745851995; x=1746456795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwMKrKUrz7hVKaJYlAYv8j/UucUD9W99THoogTJ3M90=;
 b=N3OBkYz/A7pd8bzZ9rB0x/MhMUt9EY/a7D6+toO74KsXSsmbCKSNN8Lt5PIB/9hRbg
 9BCU0Q8jvqWlkpesscWiXxLfkMdCBGIGOqO+tYkDJxc3mT3ZN/ZsV2QwoncJoKjYM3Jz
 sknsIj60v8yzbsMqNRBGb50aCXS6Ejhr23ACrOTuANIu+7SB2dY/+cBj+oazLdW4y4Db
 GAXUMvWEZsnn1k0SL34+Z+75RhVttHaNarKQWdNDfnnd3RbErcfT6I9Zx0JjjdLm4q6z
 XFZqab5/4s16nnqomSaPqsmAJX7CuN8l29S7h0MFuISaIZl3heG4sPgvQkDrWOTRrSzw
 unnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851995; x=1746456795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwMKrKUrz7hVKaJYlAYv8j/UucUD9W99THoogTJ3M90=;
 b=H9N2UQxZy8dfdTJgLtmonRAdy9OSyAeH1cIziwPvfpeVy1CE/FpvquHR2pi8IfPHjJ
 i9wTg0r4UI9Nl1L1q7rqj8CqxFRlLeIcJttBpzAyiTlIVRKKhw3XitjM6QUz7NQC9OJq
 gObvJQTXWtGjPJ63+QR0Xtj94OPqbu8QDSOpz70dF3Ojwn+EwqRgtij4HGpQzdvk4fQ/
 NI0WxtqNAeZPJZKGmedoz+B2I893KqB++HZJC8DJkCvhcRSTCH8YVKBk7ts/sXS98/DE
 mp3TTNiePB8Sg0U/VcmiMd7LdjtrzHBoh5BfYAUlyzbFIjHNoZmEdfvNvsJL/3t6zA4W
 zYlg==
X-Gm-Message-State: AOJu0YxDeuA79909dIwxCDt4QUfzL3PRvcO1hV0gt24nhpczj1EKjDng
 volNQNUtoMdMO8UJx7b9NvuIXfGAXZZfNIai7h2KBeQU6Dk7u/ue2oyZFRkU
X-Gm-Gg: ASbGncvxO4I0eMhTLa8o0DDTZu52y9WB8XGzQdxtlKT3I886fiVwwQZvo0uGeDbiZgD
 o8P/k01YSeLy15/VIYOtDyLJBw2+rPaKSBXbkkExqQ6sdqZrBVjD+JlTUdb2xbpLWSUqn1hz+ZV
 uY5bpkZORldUlHAZWpbwxzWrqlyEBN7fdaWc7JRArMqv/rfnQcBoIuZJk81f1bAtESB/TYPqGfp
 G/w1QiaoYNYYE65A5WKx+k5SNYJ17uExj5WHuAFnHoZ6RfWJoamlYqyyVG7RQSIRpUiS8sQHgF3
 3BmQLerNCKlJBEL+YK/raid1s89UkPeV7+kkCXeBRKQJaO7VHeKv
X-Google-Smtp-Source: AGHT+IGpvnOTvNvd3RvTjzuMo7ZFQqmnBfR4a/Ihp1BvLvi5U3eoqoCAvkU9ht3c+n3IvxPF8+MbiA==
X-Received: by 2002:a05:6a21:2d04:b0:1f5:9016:3594 with SMTP id
 adf61e73a8af0-2046a441fc1mr13284698637.18.1745851995419; 
 Mon, 28 Apr 2025 07:53:15 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:1104:675d:ec62:4e96])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a58bsm8317367b3a.143.2025.04.28.07.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 07:53:15 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/2] efi_loader: bootbin: do not load an initrd if none is
 provided
Date: Mon, 28 Apr 2025 10:53:39 -0400
Message-ID: <20250428145341.2091400-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250428145341.2091400-1-adriano.cordova@canonical.com>
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
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
 lib/efi_loader/efi_bootbin.c |  7 +------
 lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 6 deletions(-)

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
index d0f7da309ce..6a189c31ffa 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
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
+	ret = efi_install_initrd(initrd, initd_sz);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 3936139ca41..19fb5d03fec 100644
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
+		efi_free_pool(dp_initrd);
+
+	return ret;
+}
+
 /**
  * do_bootefi_exec() - execute EFI binary
  *
-- 
2.48.1

