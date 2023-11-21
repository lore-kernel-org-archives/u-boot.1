Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC0FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC298761B;
	Wed, 22 Nov 2023 00:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="AZ44yG3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464C8842D0; Wed, 22 Nov 2023 00:58:33 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C677F875F9
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-332c46d5988so2031523f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700611110; x=1701215910;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPxhM9KSUbc6x5w040owRWSj0OAM7V4I2RYeFWoUKj8=;
 b=AZ44yG3PPtxY6HeQRvPCGRi4yKDJJIK7EumOgCMFRpc9mvmww0Q2PqDP/PJZQRG3pN
 EqfXh7ijGnVXxFb6GHQHILPQLKQv2dW1W8uy5g9GBUxC9hEjCakPRfcqTwIWNAyzRsy7
 oeyLTjcdTxw8p+tfHzaxEdpv+bmVgq/9XkQGE4w6bzeoAWMqd6oXYo7R02CYHGvbiyYR
 zqX/8lydUW2C1bqpkofICqJ5muUg2eM9qz5eC3KE9O7rX5g5v3u4uhawU1VkD6j/5QhK
 Nt3eGOjpLCQkyVZhpnV62kfKP8iB10SxFAz5VKlGsZUOcemaTaG8+DYDbcphXc4XfIVx
 +yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700611110; x=1701215910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPxhM9KSUbc6x5w040owRWSj0OAM7V4I2RYeFWoUKj8=;
 b=rpGnnRpvQgZwQ773/t4rHTXlGlWwAgCD1ifLdT718cbE9jCftwuBHLVfRtuCOtolJk
 /sZzgTQlZvKKwVvJirIj4gdY9mVVhfWQqJTSa1ApA4HX0Uh5UENSTfcXrHB8llVnc68y
 SQhaM104pLneAYN4EfFRb9KqEH808sGsGWHiawt70f3gH9XnVymqm9OhvPdDp9hUSFAV
 2o4x+MYvMH9LKZDKPZVt8DxROAFz2LLWvKaLjfKNWC3YBExHD9fwWfUQ4aqZLDks+Fgw
 Zipg8eCe+/xFa3UWgz0CTu7XTE1yzbwE5yZv2PaubXWX/yrKWIZlQyz/eZqfAe3vWhCb
 Jz6A==
X-Gm-Message-State: AOJu0Yx2imSaJ0pFtZSIECRhZ3PhNI0+D0HatAzEMCKoBLr7sEVqplo0
 mF40GKr+nvAQ/+aNij5pe07XB6nl5Bk4bV4W3RoRNg==
X-Google-Smtp-Source: AGHT+IEPEfvZS5PkQhX113mipXdsOXVEZxo/3a/qCmHlhBOWMMv4zM/w/6SW/SukpzFnUX8Augj9Xw==
X-Received: by 2002:a5d:588c:0:b0:332:d257:2155 with SMTP id
 n12-20020a5d588c000000b00332d2572155mr161736wrf.22.1700611109386; 
 Tue, 21 Nov 2023 15:58:29 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d5381000000b0032f7f4d008dsm15625566wrv.20.2023.11.21.15.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:58:28 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
Date: Tue, 21 Nov 2023 23:57:12 +0000
Message-Id: <20231121235713.1530289-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121235713.1530289-1-i@shantur.com>
References: <20231121235713.1530289-1-i@shantur.com>
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

Currently U-boot uses ESP as storage for EFI variables.
Devices with SPI Flash are used for storing environment with this
commit we allow EFI variables to be stored on SPI Flash.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 include/efi_variable.h        | 25 ++++++++++
 lib/efi_loader/Kconfig        | 18 +++++++
 lib/efi_loader/Makefile       |  1 +
 lib/efi_loader/efi_var_sf.c   | 91 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c |  4 ++
 5 files changed, 139 insertions(+)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/include/efi_variable.h b/include/efi_variable.h
index ca7e19d514..766dd109f5 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -188,6 +188,31 @@ efi_status_t efi_var_from_file(void);
 
 #endif // CONFIG_EFI_VARIABLE_FILE_STORE
 
+#ifdef CONFIG_EFI_VARIABLE_SF_STORE
+
+/**
+ * efi_var_from_sf() - read variables from SPI Flash
+ *
+ * EFI variable buffer is read from SPI Flash at offset defined with
+ * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE
+ *
+ *
+ * Return:	status code
+ */
+efi_status_t efi_var_from_sf(void);
+
+/**
+ * efi_var_to_sf() - save non-volatile variables to SPI Flash
+ *
+ * EFI variable buffer is saved to SPI Flash at offset defined with
+ * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_var_to_sf(void);
+
+#endif // CONFIG_EFI_VARIABLE_SF_STORE
+
 /**
  * efi_var_mem_init() - set-up variable list
  *
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4ccd26f94a..1fcc6fabb4 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -54,6 +54,17 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_VARIABLE_SF_STORE
+	bool "Store non-volatile UEFI variables in SPI Flash"
+	depends on SPI_FLASH
+	help
+	  Select this option if you want non-volatile UEFI variables to be
+	  stored in SPI Flash.
+	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
+	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
+	  needed.
+
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -108,6 +119,13 @@ config EFI_VARIABLE_NO_STORE
 
 endchoice
 
+config EFI_VARIABLE_SF_OFFSET
+	hex "EFI variables in SPI flash offset"
+	depends on EFI_VARIABLE_SF_STORE
+	default 0x7D0000
+	help
+	  Offset from the start of the SPI Flash where EFI variables will be stored.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !EFI_MM_COMM_TEE
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c6..b9b715b1ff 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
 obj-y += efi_var_common.o
 obj-y += efi_var_mem.o
 obj-y += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
 ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
new file mode 100644
index 0000000000..e604a2225c
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * File interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rtahore
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <spi_flash.h>
+#include <dm.h>
+
+efi_status_t efi_var_to_sf(void)
+{
+	efi_status_t ret;
+	struct efi_var_file *buf;
+	loff_t len;
+	struct udevice *sfdev;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_err("EFI var buffer length more than target SF size");
+		ret = EFI_BAD_BUFFER_SIZE;
+		goto error;
+	}
+
+	debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
+
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
+	debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
+
+	if (ret)
+		goto error;
+
+	ret = EFI_SUCCESS;
+error:
+	if (ret)
+		log_err("Failed to persist EFI variables in SF\n");
+	free(buf);
+	return ret;
+}
+
+efi_status_t efi_var_from_sf(void)
+{
+	struct efi_var_file *buf;
+	efi_status_t ret;
+	struct udevice *sfdev;
+
+	buf = calloc(1, EFI_VAR_BUF_SIZE);
+	if (!buf) {
+		log_err("Out of memory\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+		EFI_VAR_BUF_SIZE, buf);
+
+	debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
+
+	if (ret || buf->length < sizeof(struct efi_var_file)) {
+		log_err("Failed to load EFI variables\n");
+		goto error;
+	}
+
+	ret = efi_var_restore(buf, false);
+	if (ret != EFI_SUCCESS)
+		log_err("Invalid EFI variables file\n");
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 7fa444451d..0f85962f05 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -360,6 +360,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
 #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 		efi_var_to_file();
+#elif CONFIG_EFI_VARIABLE_SF_STORE
+		efi_var_to_sf();
 #endif
 	}
 
@@ -471,6 +473,8 @@ efi_status_t efi_init_variables(void)
 
 #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	ret = efi_var_from_file();
+#elif CONFIG_EFI_VARIABLE_SF_STORE
+	ret = efi_var_from_sf();
 #else
 	ret = EFI_SUCCESS;
 #endif
-- 
2.40.1

