Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42EBC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFAF819B1;
	Wed, 19 Mar 2025 15:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KBFYlg8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1692A81F30; Wed, 19 Mar 2025 15:44:59 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40D2819B1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2255003f4c6so126261375ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742395495; x=1743000295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bqB2r8FLToeAB4/0x8SkxHfel7OqBDCc0W//GLwSfM=;
 b=KBFYlg8piz5mhg2XFDAv41vgKAk2KijogZqYrLVr9dcNeILDPntmoIwKVc7Drop/sj
 +haF9MCP7lrr5TjNO1AoyByZlIY4Xp0Jr4KHz49Ch3ZCRGVLG5FFXaUrL0cpZLASQcF6
 0ruHhsJde1BtETPUnFqbZV0YycY1hK2XshS98c+sovlPeqASmObfb3NY/GB6ScVmRT8d
 dz0jNi9f5J0yVK6bQQ+yrwvWdLtckOAuwT2nkbV93m4xKDu/Xe7+GTUUfE3Hfv/Ndx/t
 No/iGHgJI9sHwlkCR5Rib6iQl26AX8ULvThIfQcMT3OLwbI6Uf/956qDv0uUsdqO1hdg
 pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395495; x=1743000295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bqB2r8FLToeAB4/0x8SkxHfel7OqBDCc0W//GLwSfM=;
 b=KABfO5t1iPhb1pBOfyNSpZljp92eW5s4jYfiEITgB6cDPLG2M1UIHy46LMCDELJu6B
 hgweAfghnX6f0wEL5p/5N+jcquRw3sevPrGDMnOjzkQs9s6FqPBnmDFOWqTRnN1GXyoa
 JNgNPlbgdn6VhCUHq3kJMuWLcOQb9PEg8hDsMUp7386fiNMpltKEPF9W9TUGTCSYMkVt
 1jH7YXr2c2+eGXwKBUL7IaJrGHfm2maJmdeCGNBT1yAHlj5hhxReKOsYYvpWX1bvOB1L
 seq/qNxAeeP6zMCRbxgQaH20ZAVRnDW9ixDtUW4d0mH0QMqnBC3PfquQ5Bx5E1BCKkFN
 EN4A==
X-Gm-Message-State: AOJu0YyuhYCljW1weeiZJ5mEs912z9NoGWBeNyi87TtmdBiZmAjZq4bp
 HrM3DSfqxCaY5/n5SRa9yuw4W3U4qfJafmG4q71YBPxdIpUdH84diLpO5GKd00EnWA==
X-Gm-Gg: ASbGnctWfZPh2QY0QBlNZvlbOXDZqHI49eWVfi6VS+l05xAo4MqAk4l/8FIbv0GOPoC
 fcZ0D1FSSm1ZfYyacsVEki/w7t3o1pS+G4VfDeXHbcZuItU13FodUEIYfhdiODVWH+UVYGDyHDe
 IMMpHPa7wcHRdQdSlvXVoJxWHjTJ/NeM+s5Ps49SxU8YuWzPXy6gYSR6Vcq/OrYdlo/rZ+ATU+e
 iqz0ODgk0DSzGN+LYlAeliM8gtNNe/0Q8z6crbwbA7VzpEdQXk/CMxY3wigKiiDkJExqVB9S2oy
 wOvxPNCLjhFuye8B4iEndECj3hbKf/AGIsU+QjMTSfNIcO8ryyAIWh0=
X-Google-Smtp-Source: AGHT+IG+6KNrbf8f3eIcvifHfiGmKX6FuwxZdeZ7zAVzl1HltXtHUvwN3qSk2WzTU5mJ3UsUlM3MGQ==
X-Received: by 2002:a17:902:e950:b0:224:1af1:87f4 with SMTP id
 d9443c01a7336-22649938840mr52312595ad.22.1742395495020; 
 Wed, 19 Mar 2025 07:44:55 -0700 (PDT)
Received: from adriano.. ([186.175.132.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba734esm114812915ad.141.2025.03.19.07.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:44:54 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/3] efi_loader: efi_load_initrd: provide a memory mapped
 initrd
Date: Wed, 19 Mar 2025 11:44:59 -0300
Message-ID: <20250319144501.32277-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319144501.32277-1-adriano.cordova@canonical.com>
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
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

U-Boot can pass an initrd to subsequent boot stages via the
EFI_LOAD_FILE2_PROTOCOL. The current implementation only supports
this functionality via the efi boot manager: the initrd is taken
from the load options of the BootCurrent variable. This commit adds
support for registering a memory mapped initrd, e.g. loaded from a
FIT image. For now this new method takes precedence over loading the
initrd from the BootCurrent variable (if both are present) because
the BootCurrent variable is not cleared on exiting the boot manager.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 include/efi_loader.h             |  2 +-
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index e9c10819ba2..cc732dc4807 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -667,7 +667,7 @@ efi_status_t efi_http_register(const efi_handle_t handle,
 			       struct efi_service_binding_protocol *http_service_binding);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
-efi_status_t efi_initrd_register(void);
+efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
 efi_status_t efi_initrd_deregister(void);
 /* Called by bootefi to make SMBIOS tables available */
 /**
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c6124c590d9..6e66cf3793c 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -670,7 +670,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 
 	/* try to register load file2 for initrd's */
 	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		ret = efi_initrd_register();
+		ret = efi_initrd_register(NULL);
 		if (ret != EFI_SUCCESS)
 			goto error;
 	}
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index fb8cc7bcbe3..74b92f8bd66 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -42,6 +42,7 @@ static const struct efi_lo_dp_prefix dp_lf2_handle = {
 };
 
 static efi_handle_t efi_initrd_handle;
+static struct efi_device_path *efi_initrd_dp;
 
 /**
  * get_initrd_fp() - Get initrd device path from a FilePathList device path
@@ -72,6 +73,41 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_initrd_from_mem() - load initial RAM disk from memory
+ *
+ * This function copies the initrd from the memory mapped device
+ * path pointed to by efi_initrd_dp
+ *
+ * @buffer_size:		size of allocated buffer
+ * @buffer:			buffer to load the file
+ *
+ * Return:			status code
+ */
+static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void *buffer)
+{
+	efi_status_t ret = EFI_NOT_FOUND;
+	efi_uintn_t bs;
+	struct efi_device_path_memory *mdp;
+
+	mdp = (struct efi_device_path_memory *)efi_initrd_dp;
+	if (!mdp)
+		return ret;
+
+	bs = mdp->end_address - mdp->start_address;
+
+	if (!buffer || *buffer_size < bs) {
+		ret = EFI_BUFFER_TOO_SMALL;
+		*buffer_size = bs;
+	} else {
+		memcpy(buffer, (void *)mdp->start_address, bs);
+		*buffer_size = bs;
+		ret = EFI_SUCCESS;
+	}
+
+	return ret;
+}
+
 /**
  * efi_load_file2_initrd() - load initial RAM disk
  *
@@ -118,6 +154,9 @@ efi_load_file2_initrd(struct efi_load_file_protocol *this,
 		goto out;
 	}
 
+	if (efi_initrd_dp)
+		return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer));
+
 	ret = get_initrd_fp(&initrd_fp);
 	if (ret != EFI_SUCCESS)
 		goto out;
@@ -209,6 +248,9 @@ efi_status_t efi_initrd_deregister(void)
 							 NULL);
 	efi_initrd_handle = NULL;
 
+	efi_free_pool(efi_initrd_dp);
+	efi_initrd_dp = NULL;
+
 	return ret;
 }
 
@@ -234,24 +276,31 @@ static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
  * This function creates a new handle and installs a Linux specific vendor
  * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device path
  * to identify the handle and then calls the LoadFile service of the
- * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk.
+ * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd is
+ * not provided, the initrd will be taken from the BootCurrent variable
+ *
+ * @dp_initrd:	optional device path containing an initrd
  *
  * Return:	status code
  */
-efi_status_t efi_initrd_register(void)
+efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
 {
 	efi_status_t ret;
 	struct efi_event *event;
 
-	/*
-	 * Allow the user to continue if Boot#### file path is not set for
-	 * an initrd
-	 */
-	ret = check_initrd();
-	if (ret == EFI_INVALID_PARAMETER)
-		return EFI_SUCCESS;
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (dp_initrd) {
+		efi_initrd_dp = dp_initrd;
+	} else {
+		/*
+		* Allow the user to continue if Boot#### file path is not set for
+		* an initrd
+		*/
+		ret = check_initrd();
+		if (ret == EFI_INVALID_PARAMETER)
+			return EFI_SUCCESS;
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
 
 	ret = efi_install_multiple_protocol_interfaces(&efi_initrd_handle,
 						       /* initramfs */
-- 
2.48.1

