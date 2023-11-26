Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA20C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 22:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879E2874BA;
	Sun, 26 Nov 2023 23:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="lhFfSlCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E5E874D5; Sun, 26 Nov 2023 23:09:51 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C8287243
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so47576461fa.2
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701036587; x=1701641387;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2jUuv5RFUY02mVrU7ntk13B+CcfZeC+0kmjNkToqCY=;
 b=lhFfSlCqga6ig24HOos1k9glY6kuSP8DMOa0Zmw1tcew+nlyExkwx2wGgsqvervccr
 5PuJ2bOLim9JD/JyF5e3TxeLBl9jHqxJIpXBYiJMVaJEDKZT5w7Eq3VZLfmowaCLw4Ui
 5CCtPYEMg5guMhixEohMc2V7zjBpJ76vX3mQ49uF4QI+SGBjh3UVadHO5tx/1xH71bD6
 LtwlHnt+4nOOyaYNy9lt6ZReRGzIo9MSZe13SYTnWhGWsQMuoj42G3QrSaiHyFy8QL3w
 hFM/rWSdpR3gFBtHfHOIEWae0rdEZxPRtQNktW3INVqsqwmwteOUGz13uAOpkY4sPlt4
 FPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701036587; x=1701641387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2jUuv5RFUY02mVrU7ntk13B+CcfZeC+0kmjNkToqCY=;
 b=fKR+JvTFVkdpRgbRvy3p6kfoc0kjPTHuKz2Bb+0ekNKfkzqeT2wz+ufQOI1ruJIqa1
 6ljaDCNJzaqDJY+5MvnNXJY07QCiHX2nekHMDHfebacckxWgkY46K6WsUK6Qrl6vvAfZ
 DuEPpMtM1N2i/PH17KqLkQVwo5kR11szVBckJVgjf+1P5B1823rzVmLzfu+0rpcxo3Li
 gl6i42+SHCIvEYsismumitRFSvPs/EnVpmH+GdWuThSOnUcQJuXLc+EgeVHGTPO4LFou
 wHmernqnsWGbAYHfdGFLuLz3W+TowZvt1dqMSdpUJICJkOdBDB+gSZsiIjrFM3ALh3sX
 6BJg==
X-Gm-Message-State: AOJu0YwHWWmgg/nfxX6EoILmesu9sFLIASbFv+L/hutG9uxKRLumdAfS
 L6YuH9Qx0W3RLYa9epo5p475VBdFauTSboMW/GxO1G0b
X-Google-Smtp-Source: AGHT+IH1kqcUMTrP4LVvjV8ivoKcI487UhBv3IMAqZCWuqVE4ggt0P5nd2bFQwiui3RzTq38nHh9ig==
X-Received: by 2002:a2e:740b:0:b0:2c8:5b9b:397c with SMTP id
 p11-20020a2e740b000000b002c85b9b397cmr6595404ljc.32.1701036587645; 
 Sun, 26 Nov 2023 14:09:47 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c1d9000b0040b3e3eaad0sm6471126wms.41.2023.11.26.14.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 14:09:46 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 2/3] efi_vars: Implement SPI Flash store
Date: Sun, 26 Nov 2023 22:08:35 +0000
Message-Id: <20231126220836.374956-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126220836.374956-1-i@shantur.com>
References: <20231126220836.374956-1-i@shantur.com>
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

(no changes since v1)

 include/efi_variable.h        | 21 ++++++++
 lib/efi_loader/Kconfig        | 25 ++++++++++
 lib/efi_loader/Makefile       |  1 +
 lib/efi_loader/efi_var_sf.c   | 91 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c | 15 ++++--
 5 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/include/efi_variable.h b/include/efi_variable.h
index bd0a31fc3e..f90bbb0548 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -190,6 +190,27 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
  */
 efi_status_t efi_var_from_file(void);
 
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
 /**
  * efi_var_mem_init() - set-up variable list
  *
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 2e3935467c..d3200cb3e3 100644
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
@@ -108,6 +119,20 @@ config EFI_VARIABLE_NO_STORE
 
 endchoice
 
+config EFI_VARIABLE_SF_OFFSET
+	hex "EFI variables in SPI flash offset"
+	depends on EFI_VARIABLE_SF_STORE
+	help
+	  Offset from the start of the SPI Flash where EFI variables will be stored.
+	  This should be aligned to the sector size of SPI Flash.
+
+config EFI_VARIABLE_SF_DEVICE_INDEX
+	int "Device Index for target SPI Flash"
+	default 0
+	help
+	  The index of SPI Flash device used for storing EFI variables. This would be
+	  needed if there are more than 1 SPI Flash devices available to use.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !EFI_MM_COMM_TEE
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 33b1910249..823e0a759f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
 obj-y += efi_var_common.o
 obj-y += efi_var_mem.o
 obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
 ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
new file mode 100644
index 0000000000..79ab99640c
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPI Flash interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rathore
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
+		log_err("EFI var buffer length more than target SPI Flash size");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto error;
+	}
+
+	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
+
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
+	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
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
+		log_err("%s - Unable to allocate buffer\n", __func__);
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
+	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
+
+	if (ret || buf->length < sizeof(struct efi_var_file)) {
+		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
+		goto error;
+	}
+
+	ret = efi_var_restore(buf, false);
+	if (ret != EFI_SUCCESS)
+		log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index adc5ac6a80..f73fb40061 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -354,14 +354,16 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = EFI_SUCCESS;
 
 	/*
-	 * Write non-volatile EFI variables to file
+	 * Write non-volatile EFI variables to file or SPI Flash
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 		efi_var_to_file();
-	}
+#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
+		efi_var_to_sf();
 #endif
+	}
 
 	return EFI_SUCCESS;
 }
@@ -471,9 +473,14 @@ efi_status_t efi_init_variables(void)
 
 #if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 	ret = efi_var_from_file();
+#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
+	ret = efi_var_from_sf();
+#else
+	ret = EFI_SUCCESS;
+#endif
+
 	if (ret != EFI_SUCCESS)
 		return ret;
-#endif
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
 		ret = efi_var_restore((struct efi_var_file *)
-- 
2.40.1

