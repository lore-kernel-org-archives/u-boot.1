Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BBFC4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 22:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20287874CA;
	Sun, 26 Nov 2023 23:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="xX6X2b2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED8A87474; Sun, 26 Nov 2023 23:09:51 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0A2874A3
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-332e3664665so2167038f8f.0
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701036586; x=1701641386;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KlwPOAnPR3nIOFvWRSwUNkZt+4+n1NIa8JoBwjsE4g=;
 b=xX6X2b2lXzmMR2hBaYn4cdSPfIXUpFAQpL3SuT3/Zhjf5B91AFug54aHeGnWsz/ysF
 QjTrvlWDdZPOPUl+L2B9Ltg0tJsAE0sHwEmbQuKHzI0+ZpzUZqpXhWClfs01cxR+UDxF
 S/h2VAMrWpgR1g8sQbL134mS0cOrnY3DH6wpMhF9+FvFuY0ux+Z6clY6xlUvEcE4fxNs
 L0h17Xf1YZ8xZEymuc+njeS1lzWtgcy7yd6wuSSE93O/qu5hwZgpKyG2ayMF7Q+RFAML
 7DVTRFk41h+ZgdWhzGTufo+rb/m/tdCwdsUdlk2p1eF7p5ipFl74F6ESOwxVI0DcVjGs
 qoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701036586; x=1701641386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KlwPOAnPR3nIOFvWRSwUNkZt+4+n1NIa8JoBwjsE4g=;
 b=RlCQa+kv2JKiXhQbVsjvQkQ8+Ck2q0CL/A+ulP3C6KTjy5vmKBevZHklI7iIw5+R05
 O8osho7hQ/RQUm/P90UtkeUNDQVmTpGK1XLT3uc0QImq6gQ4SUweE7dszDUU5NRY/YPM
 8SP+QQGLx5xSUiT1cJCopAr2ozQYSgBtxxTgKuyP8Pmo5JFxmXUwD3JfyfrBc0tNTlzU
 IQ9Sqc1O51jpbkwgDX6n81m5IPgqcDYuze07D0AJtIlvSgbPxeoewZvS+khoUPA9Nt8e
 MlhK/Q8S+u2oJZ7lP0TgTh/PpuZC0/7M679ehHJiYBgSt+6rSpKV1ppPfgI2IoeMydWs
 vc5A==
X-Gm-Message-State: AOJu0YyNI1oZcaP8gdUmFFHiCJJzqw02I3riBya5A2Hury+IKbQIBLkq
 nv+B9m5MnUih1/5unLaLpNs9mes+PQHnu/Q4JB5hNtgL
X-Google-Smtp-Source: AGHT+IF1jFf2o8yrave1LjCZxYcezOPXw4Q5k0pKWou72VkZq916y3FZBLWCtklQ0vzRdm6E4k4CMQ==
X-Received: by 2002:a5d:464f:0:b0:332:d1b3:fa10 with SMTP id
 j15-20020a5d464f000000b00332d1b3fa10mr7357294wrs.37.1701036586214; 
 Sun, 26 Nov 2023 14:09:46 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c1d9000b0040b3e3eaad0sm6471126wms.41.2023.11.26.14.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 14:09:45 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 1/3] efi_var_file: refactor to move buffer functions
Date: Sun, 26 Nov 2023 22:08:34 +0000
Message-Id: <20231126220836.374956-2-i@shantur.com>
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

Currently efi_var_file.c has functions to store/read
EFI variables to/from memory buffer. These functions
can be used with other EFI variable stores so move
them out to efi_var_common.c

Signed-off-by: Shantur Rathore <i@shantur.com>
---

(no changes since v1)

 include/efi_variable.h          |   5 ++
 lib/efi_loader/Makefile         |   2 +-
 lib/efi_loader/efi_var_common.c | 109 ++++++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 121 --------------------------------
 lib/efi_loader/efi_variable.c   |   8 ++-
 5 files changed, 122 insertions(+), 123 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 805e6c5f1e..bd0a31fc3e 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
 efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
 					    u32 check_attr_mask);
 
+/* GUID used by Shim to store the MOK database */
+#define SHIM_LOCK_GUID \
+	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
+		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
+
 /**
  * efi_var_restore() - restore EFI variables from buffer
  *
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c6..33b1910249 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -66,7 +66,7 @@ obj-y += efi_string.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
 obj-y += efi_var_common.o
 obj-y += efi_var_mem.o
-obj-y += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
 ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index ad50bffd2b..7509c30b5a 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -10,6 +10,7 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <stdlib.h>
+#include <u-boot/crc.h>
 
 enum efi_secure_mode {
 	EFI_MODE_SETUP,
@@ -40,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
 
 static bool efi_secure_boot;
 static enum efi_secure_mode efi_secure_mode;
+static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
 
 /**
  * efi_efi_get_variable() - retrieve value of a UEFI variable
@@ -417,3 +419,110 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
 
 	return buf;
 }
+
+efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
+					    u32 check_attr_mask)
+{
+	size_t len = EFI_VAR_BUF_SIZE;
+	struct efi_var_file *buf;
+	struct efi_var_entry *var, *old_var;
+	size_t old_var_name_length = 2;
+
+	*bufp = NULL; /* Avoid double free() */
+	buf = calloc(1, len);
+	if (!buf)
+		return EFI_OUT_OF_RESOURCES;
+	var = buf->var;
+	old_var = var;
+	for (;;) {
+		efi_uintn_t data_length, var_name_length;
+		u8 *data;
+		efi_status_t ret;
+
+		if ((uintptr_t)buf + len <=
+		    (uintptr_t)var->name + old_var_name_length)
+			return EFI_BUFFER_TOO_SMALL;
+
+		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
+		memcpy(var->name, old_var->name, old_var_name_length);
+		guidcpy(&var->guid, &old_var->guid);
+		ret = efi_get_next_variable_name_int(
+				&var_name_length, var->name, &var->guid);
+		if (ret == EFI_NOT_FOUND)
+			break;
+		if (ret != EFI_SUCCESS) {
+			free(buf);
+			return ret;
+		}
+		old_var_name_length = var_name_length;
+		old_var = var;
+
+		data = (u8 *)var->name + old_var_name_length;
+		data_length = (uintptr_t)buf + len - (uintptr_t)data;
+		ret = efi_get_variable_int(var->name, &var->guid,
+					   &var->attr, &data_length, data,
+					   &var->time);
+		if (ret != EFI_SUCCESS) {
+			free(buf);
+			return ret;
+		}
+		if ((var->attr & check_attr_mask) == check_attr_mask) {
+			var->length = data_length;
+			var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
+		}
+	}
+
+	buf->reserved = 0;
+	buf->magic = EFI_VAR_FILE_MAGIC;
+	len = (uintptr_t)var - (uintptr_t)buf;
+	buf->crc32 = crc32(0, (u8 *)buf->var,
+			   len - sizeof(struct efi_var_file));
+	buf->length = len;
+	*bufp = buf;
+	*lenp = len;
+
+	return EFI_SUCCESS;
+}
+
+efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
+{
+	struct efi_var_entry *var, *last_var;
+	u16 *data;
+	efi_status_t ret;
+
+	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
+	    buf->crc32 != crc32(0, (u8 *)buf->var,
+				buf->length - sizeof(struct efi_var_file))) {
+		log_err("Invalid EFI variables file\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
+	for (var = buf->var; var < last_var;
+	     var = (struct efi_var_entry *)
+		   ALIGN((uintptr_t)data + var->length, 8)) {
+
+		data = var->name + u16_strlen(var->name) + 1;
+
+		/*
+		 * Secure boot related and volatile variables shall only be
+		 * restored from U-Boot's preseed.
+		 */
+		if (!safe &&
+		    (efi_auth_var_get_type(var->name, &var->guid) !=
+		     EFI_AUTH_VAR_NONE ||
+		     !guidcmp(&var->guid, &shim_lock_guid) ||
+		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
+			continue;
+		if (!var->length)
+			continue;
+		if (efi_var_mem_find(&var->guid, var->name, NULL))
+			continue;
+		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
+				      var->length, data, 0, NULL,
+				      var->time);
+		if (ret != EFI_SUCCESS)
+			log_err("Failed to set EFI variable %ls\n", var->name);
+	}
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index d7dba05071..166501a355 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -15,17 +15,9 @@
 #include <mapmem.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
-#include <u-boot/crc.h>
 
 #define PART_STR_LEN 10
 
-/* GUID used by Shim to store the MOK database */
-#define SHIM_LOCK_GUID \
-	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
-		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-
-static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
-
 /**
  * efi_set_blk_dev_to_system_partition() - select EFI system partition
  *
@@ -53,70 +45,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
 	return EFI_SUCCESS;
 }
 
-efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
-					    u32 check_attr_mask)
-{
-	size_t len = EFI_VAR_BUF_SIZE;
-	struct efi_var_file *buf;
-	struct efi_var_entry *var, *old_var;
-	size_t old_var_name_length = 2;
-
-	*bufp = NULL; /* Avoid double free() */
-	buf = calloc(1, len);
-	if (!buf)
-		return EFI_OUT_OF_RESOURCES;
-	var = buf->var;
-	old_var = var;
-	for (;;) {
-		efi_uintn_t data_length, var_name_length;
-		u8 *data;
-		efi_status_t ret;
-
-		if ((uintptr_t)buf + len <=
-		    (uintptr_t)var->name + old_var_name_length)
-			return EFI_BUFFER_TOO_SMALL;
-
-		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
-		memcpy(var->name, old_var->name, old_var_name_length);
-		guidcpy(&var->guid, &old_var->guid);
-		ret = efi_get_next_variable_name_int(
-				&var_name_length, var->name, &var->guid);
-		if (ret == EFI_NOT_FOUND)
-			break;
-		if (ret != EFI_SUCCESS) {
-			free(buf);
-			return ret;
-		}
-		old_var_name_length = var_name_length;
-		old_var = var;
-
-		data = (u8 *)var->name + old_var_name_length;
-		data_length = (uintptr_t)buf + len - (uintptr_t)data;
-		ret = efi_get_variable_int(var->name, &var->guid,
-					   &var->attr, &data_length, data,
-					   &var->time);
-		if (ret != EFI_SUCCESS) {
-			free(buf);
-			return ret;
-		}
-		if ((var->attr & check_attr_mask) == check_attr_mask) {
-			var->length = data_length;
-			var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
-		}
-	}
-
-	buf->reserved = 0;
-	buf->magic = EFI_VAR_FILE_MAGIC;
-	len = (uintptr_t)var - (uintptr_t)buf;
-	buf->crc32 = crc32(0, (u8 *)buf->var,
-			   len - sizeof(struct efi_var_file));
-	buf->length = len;
-	*bufp = buf;
-	*lenp = len;
-
-	return EFI_SUCCESS;
-}
-
 /**
  * efi_var_to_file() - save non-volatile variables as file
  *
@@ -126,7 +54,6 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
  */
 efi_status_t efi_var_to_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	efi_status_t ret;
 	struct efi_var_file *buf;
 	loff_t len;
@@ -150,52 +77,6 @@ error:
 		log_err("Failed to persist EFI variables\n");
 	free(buf);
 	return ret;
-#else
-	return EFI_SUCCESS;
-#endif
-}
-
-efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
-{
-	struct efi_var_entry *var, *last_var;
-	u16 *data;
-	efi_status_t ret;
-
-	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
-	    buf->crc32 != crc32(0, (u8 *)buf->var,
-				buf->length - sizeof(struct efi_var_file))) {
-		log_err("Invalid EFI variables file\n");
-		return EFI_INVALID_PARAMETER;
-	}
-
-	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
-	for (var = buf->var; var < last_var;
-	     var = (struct efi_var_entry *)
-		   ALIGN((uintptr_t)data + var->length, 8)) {
-
-		data = var->name + u16_strlen(var->name) + 1;
-
-		/*
-		 * Secure boot related and volatile variables shall only be
-		 * restored from U-Boot's preseed.
-		 */
-		if (!safe &&
-		    (efi_auth_var_get_type(var->name, &var->guid) !=
-		     EFI_AUTH_VAR_NONE ||
-		     !guidcmp(&var->guid, &shim_lock_guid) ||
-		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
-			continue;
-		if (!var->length)
-			continue;
-		if (efi_var_mem_find(&var->guid, var->name, NULL))
-			continue;
-		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
-				      var->length, data, 0, NULL,
-				      var->time);
-		if (ret != EFI_SUCCESS)
-			log_err("Failed to set EFI variable %ls\n", var->name);
-	}
-	return EFI_SUCCESS;
 }
 
 /**
@@ -214,7 +95,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
  */
 efi_status_t efi_var_from_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	struct efi_var_file *buf;
 	loff_t len;
 	efi_status_t ret;
@@ -239,6 +119,5 @@ efi_status_t efi_var_from_file(void)
 		log_err("Invalid EFI variables file\n");
 error:
 	free(buf);
-#endif
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6..adc5ac6a80 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -357,8 +357,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	 * Write non-volatile EFI variables to file
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-	if (attributes & EFI_VARIABLE_NON_VOLATILE)
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
 		efi_var_to_file();
+	}
+#endif
 
 	return EFI_SUCCESS;
 }
@@ -466,9 +469,12 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 	ret = efi_var_from_file();
 	if (ret != EFI_SUCCESS)
 		return ret;
+#endif
+
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
 		ret = efi_var_restore((struct efi_var_file *)
 				      __efi_var_file_begin, true);
-- 
2.40.1

