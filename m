Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64DACD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22973881E6;
	Thu,  4 Apr 2024 09:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="COh1ZKL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9168827F; Thu,  4 Apr 2024 09:48:38 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48691880BE
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a4a3a5e47baso88071066b.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712216916; x=1712821716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Werfi7/+IS32ruyIg6vPW/180DaksboXEb/vUAP/jk=;
 b=COh1ZKL5VQVYWCVK2SwpqKBt2NgKe17DCMFxnAiEAPZoqpagYPvAyYkjOMN63eOuwD
 6kUvvCUS1nM9HOjlrrwoEAEQpsFH6Td8bYMwYgDZfkM+Vp113/Loq6rcpXy9VCxf4f4U
 DWfp2k0ihzVTNd8JQ9R7LjW5GFWW8CGqdOsve0nC0+qPGvyP/Dm56hXAbBCLjn2R32X2
 uw0879s2BEr4XiyxNYkON0+oj8JrRrEA4YhmSsSVSyBxbaKi/9AEqlV2SPDohaMh/0HA
 FJonAG4R32+FgyRpf2ezP0L1Iam6cLv+0IebtHx/YrTtljXooywzl8yqt1h7s5Ug3LJJ
 aFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712216916; x=1712821716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Werfi7/+IS32ruyIg6vPW/180DaksboXEb/vUAP/jk=;
 b=Go0jFBQdmPdVy8Nz/jrllBId9gZu/7tSeaR6vNREbyfnG4pMzApl9p+KvuG6sODUXR
 W5tcB3t/sL8M2y1QVHm92WKTW0iM9A6Vm9OrDWETO8qo5wCcoXg2O30Q78JUwl8cdh44
 VD3uMF9Jk79OSUDadKzWIl+lXkdg7+McPIMKgR6LmLdBucaBwhX4a1wto0KfjhI/np9x
 rekO6lWurRM2DAb/wyWLbJH5JuemzXxzFugvH5E0tmnZP8oBk966JnHhhI9DTV7kV3zP
 AJrxDZquP4AOgdEHNsjnpfCRzfPpc32qUarZGI+duT6t+bK+as+VhmJBgm5aUTvSJU7R
 h9aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE67NM+IldKldB5pOjI6CoggbjBGZOJvk21yJL2762bNJjksNz8TNrwF4YfJqiduMHqKRf45u6AWIfZtQxiLtOn65uNA==
X-Gm-Message-State: AOJu0Yyn8l1HyexwC44BMmOVG9r3hK0n6R4HInZjzjmLMb0cUMjsy+j9
 7D60MqUfyrCIQy79FVdKbkBci4gmw7axHvmSOAejAMHUZDq5nv4PX24Tte2zO3c=
X-Google-Smtp-Source: AGHT+IExynLUibqhJE5KB8yCy4ONIWthwqLQh4BDnj4eYUE8mtgHblzqZ4ulPbAXogwsuwZJy8IwEQ==
X-Received: by 2002:a17:906:1b4a:b0:a51:8d19:3b07 with SMTP id
 p10-20020a1709061b4a00b00a518d193b07mr403903ejg.4.1712216915724; 
 Thu, 04 Apr 2024 00:48:35 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00a4e299dea48sm8144093ejo.199.2024.04.04.00.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 00:48:35 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <apalos@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: move efi_var_collect to common functions
Date: Thu,  4 Apr 2024 10:48:18 +0300
Message-Id: <20240404074819.52156-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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
 lib/efi_loader/efi_var_common.c | 76 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 64 ---------------------------
 2 files changed, 76 insertions(+), 64 deletions(-)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 16b2c3d48828..07b9603d49f3 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -9,6 +9,7 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <stdlib.h>
+#include <u-boot/crc.h>
 
 enum efi_secure_mode {
 	EFI_MODE_SETUP,
@@ -416,3 +417,78 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
 
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
+
+
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
2.37.2

