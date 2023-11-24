Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA18AC61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 11:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A05387148;
	Fri, 24 Nov 2023 12:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="0fiVFdCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516C687148; Fri, 24 Nov 2023 12:37:09 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2349F870DD
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 12:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b394f13b1so6805735e9.0
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700825826; x=1701430626;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KlwPOAnPR3nIOFvWRSwUNkZt+4+n1NIa8JoBwjsE4g=;
 b=0fiVFdCvn4js48dyptkq1ArBAjrZM6Wjoyhl7UXf4ty2eo0eT6JdSTLSlYefwwmk3n
 dc+jx0MLGCL6OTXW/uEWDoS2KeZMXn7XhCuxWsl8cebXIUmjLBbbHWG3jztz/0driBRe
 tJ/t0ohz3ASabLXu6mfm+mIT7Vhp6ayWuSBv3St9mxa7Msvh889FriGbNwm6PJoaZ2N7
 9V9CZHmDTKWblE7cEyJMoQltqf3vUWSJgAQMPh9v1eA0H/T2GgYGO2+buZq463KvE8XU
 CZGUllNJdG7DPBV8QzWocLZx+G7KJfBR3FtZRxk6gE91/zQvjav1OnzLDwNyjhMgGLxc
 X6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825826; x=1701430626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KlwPOAnPR3nIOFvWRSwUNkZt+4+n1NIa8JoBwjsE4g=;
 b=tOA+24r2P01gNjoh9PHlZDBcdSE60P4Rd3qbGUXBSUrrSEJ0f5DBRZw1n6iLq4hfYZ
 0oszRn3yD6ceGzWpvbON7fnWTLg6fMaspG9wzahM/pomKHxj4DQrfIgy2jWagOymuorv
 VZcftLVlR3LBcJPQ93eurP4ZGy0FDUD68HUrXMpK+LqM2KydM16elVfz+r90EsbYQZTb
 ZdA54xejkQy7BUCiHeHII1ag6sR98Rma5r7Q2PVU8k6YL+xAccWrCaJfWq5H3gnWCD1G
 UiTqKSYhAw5hl4HS2VkVH7xvD8DZDP51Yi4pkiioa/anZAGbbqqh4tQCQp9LA4pMs8xY
 QbaQ==
X-Gm-Message-State: AOJu0YxrS3mz9FrqtJvKZ7/4QdpS+sfUfcKb/55EEHNkUdWk1gD4DQ1B
 B3957zZHkGC23vyP478wMpXpXm8q+c63LZyWXbiBkW9A
X-Google-Smtp-Source: AGHT+IH3YUQDpzVEaS/vj2Sz1hdb7mUGsIUVazU7z4qAmCuoOJKX5+zBVaFqWiYDHkuopsAtMwN5Aw==
X-Received: by 2002:a05:600c:450b:b0:40a:20f3:d127 with SMTP id
 t11-20020a05600c450b00b0040a20f3d127mr1830141wmo.35.1700825826150; 
 Fri, 24 Nov 2023 03:37:06 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 o8-20020a5d6848000000b0031980294e9fsm4052093wrw.116.2023.11.24.03.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:37:05 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/3] efi_var_file: refactor to move buffer functions
Date: Fri, 24 Nov 2023 11:35:50 +0000
Message-Id: <20231124113552.112243-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124113552.112243-1-i@shantur.com>
References: <20231124113552.112243-1-i@shantur.com>
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

