Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE1C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 13:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB5281026;
	Tue, 18 Mar 2025 14:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWEpH5Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D458193A; Tue, 18 Mar 2025 14:23:42 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270CC81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 14:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2235189adaeso95526285ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742304219; x=1742909019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+S8FVLNOlvQWWY5zH+L6ZjlmoIyFMg67sIXIjPKj9QM=;
 b=QWEpH5FsQpwZdeHrG9B2lvtUSlNZ9oMtDqOsg3fz+FNTTgXEXgiKGX1EsDTtig8Iky
 bbde1q8z5cIPh8iRuAIMbBm6AL0knAAxuQwh9gjUZ7r4im1E88MyX/Hc1YxzAjV+SHi0
 eMIHwN3LZXtot+Ldn8rgKtUVZKEinQDU6wp2Usrf5BPzSWRskfYp7+Wb58Pfslwk/rLt
 insT/aLlNgrIzLlMkM6NzuNZuLPYrCr1cFef99sXdlUwnZHYDGPNrghVTQHaobgmZqpy
 jW6fODV+tA0YTyfhGMrQsCW6CS1IoJ8rJO7JZEii4Rv/diDCAt5uStgPuk9y5udPCIed
 /EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742304219; x=1742909019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+S8FVLNOlvQWWY5zH+L6ZjlmoIyFMg67sIXIjPKj9QM=;
 b=Ieil0cjTTyj8HKH/pSzwUxICbMh01Uj6v5HGMVpN6R5Q0YIPaIMw4+s34nZaCeTHad
 muCz005ivquZqeIVxcLCjj9WKw2jYhXzrut6SXUWAav1LjBJaHfP8l0yarcC808N4v6t
 FZ5H9LdDpySCdg22pUeJDXb0UWBGZoq+O4PZYgGwXR0Ay40j2xixhl2vLDuAEIJch6yA
 Jmshod8egvy6Yoe7suNByGf0ADZZhEVkdwhbntmjQ20vg6bhxotH00dWUNPmVQuOaC0V
 n3wHRN8Vdd5gQjgeMMN7eQASvPkX8waJGZ4J6DTg2C/ufxnrzAsxPHzW5lbPJc9asa9Z
 jTdQ==
X-Gm-Message-State: AOJu0Yxt0Pgdnhp8cPJvYWke9dZMT8Rw6ae0DRCVqZp27POLw9coVQpz
 lOxQ0zBfRWpFe5Jg0siKSgz3ItAVfwTZcZD9ZmBx8DsA2a90aYUG7k8zrfQTIsw=
X-Gm-Gg: ASbGncuko49TcqTwx63veW12U8V6v7XQ7Q+GsCKoD6tlBY26DxWqWPCiboVCkxZjyFI
 AW6QZooCVXIZl0jBq0S0jChxfhfFSxoQfMOUIMEm5GPDCfAeGHna8bQnJZkWtBVYSHZFjbRqy1T
 rDCe6CV4wZox/zibXPpgCS2c3SY5MYT66Uc3Ed6gZFitoAD68YmII+uMgCxLzG5jkcHi0JG3W3j
 VEE/blhIFwSarwAonsy3LgSMgkaMJdpAnNozmCsKEE5nmyRDunoztt5BD24FqGINO54Wj5BDu6C
 4IeGnkw0vXah7xWJuexiPyaAq+5bF7U/sMj4vJPSjKdOXOZeyWcIRhWaOdT79BHUn/w=
X-Google-Smtp-Source: AGHT+IFzCWRkJaygSTJXBUFecSXHWAcYu9ZaZ5XPtniGPfa1l04u5exkI8mZEG5oEjOvWMN/yvomfQ==
X-Received: by 2002:a17:903:174c:b0:21f:40de:ae4e with SMTP id
 d9443c01a7336-2262c9aefe4mr43424105ad.9.1742304218599; 
 Tue, 18 Mar 2025 06:23:38 -0700 (PDT)
Received: from adriano.. ([2800:300:6f53:4a50:2bbd:7872:4328:2b1c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba70f3sm93685945ad.157.2025.03.18.06.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:23:38 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/3] efi_loader: efi_load_initrd: provide a memory mapped
 initrd
Date: Tue, 18 Mar 2025 10:23:45 -0300
Message-ID: <20250318132347.646703-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318132347.646703-1-adriano.cordova@canonical.com>
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
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

