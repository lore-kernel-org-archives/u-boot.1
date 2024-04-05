Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D48CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D141D88211;
	Fri,  5 Apr 2024 08:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EI7Sf23M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0777A88236; Fri,  5 Apr 2024 08:51:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F378587D8D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41551639550so13030755e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 23:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712299873; x=1712904673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1ljMsiCYI+0YlJp9Vw+4qY0KpUw5XcV+RLwCsKMFLpk=;
 b=EI7Sf23Mq6iBAhyVViRZMWa7S9oMNCOlk2J835DGe+ZQFGsB1mNweuHY2qrJ/jBYnQ
 MWn9bXeWcrjsP+612X7+hO5Hm0vT9FhBu31VZoMAEhUfrSldXMaeZ0LBAO7KnY+V9kZe
 HTzWtKxl5bJlKxGKGlO6QNwIWfvB0fEQ+64iRzBMQfSGyQTrg9fLqiJ83eYAuL0pRoR1
 T3nyeYIoS+npbQtS0LemYP33sI0QYULgWsL5piqZGprQ8DAfJHXQ5m1DwUrxtOEgniuF
 TrMCMJ/xGqvYdJkVYEdAYSCfWmmNHDbYG1dHCY1DHwx4jiQgRA74VsBbLWIP2LPO26E0
 2Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712299873; x=1712904673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ljMsiCYI+0YlJp9Vw+4qY0KpUw5XcV+RLwCsKMFLpk=;
 b=Zut+mK+zBQsHC1ZIoB4K04w89Rc7bWRw9Z9le2lAM2wPazkZ+VlA5kyDynVMma6C64
 s82HOWYIAIM3NUv7Y5icES0YDMh33CzQi+37c31cWj9QwGLLqIQVNEs7AmAo5jSJv8Lr
 lFhMekREQ3bL2JFXfoOxZTevzMIIwwtZi0g3B8S77kvFvWplcs+cFF77HY5+lXp6fkR0
 rdYiFpmEuKkXRv50Ur2UIQGiSlueIZaGLD5QdSC2cwQ33ezW1cFIzx9tcAM2aaCiCwkN
 S4BiSr+G59hedZn7awUxs5EenU01HougpE5ohrQp9mxuAtDIfHx3G0MRap51XgV5dk9h
 eRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsfPwROgJaxmoQ2OJR1/TJQNI9zyxBhNU4mc0JoslMlS3zawADudEqjStMRWjhuKyVyW0sFTjNnT+bvcexKhYABvS98g==
X-Gm-Message-State: AOJu0YyExzi2GdWga4kyPwFDrSHk9euyHpFC2L4uWfIrPlEeM3qaXI8r
 oF0dAv9edYKxaplkDx0en6iS6Y1//KJFlM0O72v5ORCWQNAc2SiTbE0E4NiLIWI=
X-Google-Smtp-Source: AGHT+IH6QVDBIXrirY8QnZn3L+jRfM+VWKHyfGOsRDCGrW9A/wpPO/RB24QO+rU3IEL85aUNnMVYkg==
X-Received: by 2002:a05:600c:470d:b0:415:544b:3128 with SMTP id
 v13-20020a05600c470d00b00415544b3128mr532986wmo.27.1712299873414; 
 Thu, 04 Apr 2024 23:51:13 -0700 (PDT)
Received: from localhost.localdomain (ppp089210071137.access.hol.gr.
 [89.210.71.137]) by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b004162d5233d5sm1773889wmb.42.2024.04.04.23.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 23:51:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <apalos@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: move efi_var_collect to common functions
Date: Fri,  5 Apr 2024 09:50:58 +0300
Message-ID: <20240405065058.591452-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

From: Ilias Apalodimas <apalos@gmail.com>

efi_var_collect() was initially placed in efi_var_file.c, since back
then we only supported efi variables stored in a file. Since then we
support variables stored in an RPMB as well and use that function to
collect variables that should be present at runtime.

So let's move it around in efi_var_common.c which makes more sense

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <apalos@gmail.com>
---
Changes since v1:
- Clean up the makefile as well
- fix checkpatch error

 lib/efi_loader/Makefile         |  2 +-
 lib/efi_loader/efi_var_common.c | 74 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 64 ----------------------------
 3 files changed, 75 insertions(+), 65 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index fcb0af7e7d6d..6a0ce6c32c88 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -72,11 +72,11 @@ obj-y += efi_string.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
 obj-y += efi_var_common.o
 obj-y += efi_var_mem.o
-obj-y += efi_var_file.o
 ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
+obj-y += efi_var_file.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index d528747f3fb4..4268850990f5 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -9,6 +9,7 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <stdlib.h>
+#include <u-boot/crc.h>

 enum efi_secure_mode {
 	EFI_MODE_SETUP,
@@ -416,3 +417,76 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)

 	return buf;
 }
+
+/**
+ * efi_var_collect() - Copy EFI variables mstching attributes mask
+ *
+ * @bufp:	buffer containing variable collection
+ * @lenp:	buffer length
+ * @attr_mask:	mask of matched attributes
+ *
+ * Return:	Status code
+ */
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
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 532b6b40eefe..413e1794e88c 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -52,70 +52,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
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
--
2.43.0

