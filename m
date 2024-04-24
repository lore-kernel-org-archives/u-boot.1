Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A791C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 05:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABA688D9B;
	Wed, 24 Apr 2024 07:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IqPGoS/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674D288CD6; Wed, 24 Apr 2024 07:04:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6388688D97
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41b086d6676so846645e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713935042; x=1714539842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbFHZkLIyTsnFbIYjd2AoiBzf3B0mbR9ncwmyQR2oNk=;
 b=IqPGoS/3Hy94pgmpXyZm715H10TsmxVWdjp/D2O1gkE2VKdcC5uu8RMIGXOpcTTLJ2
 w80B/7vCaYu3t1kOJA3kVakKJS0nHIqC676THTumIhPZ6MIwAg4nenPJDXe9BSkgdDip
 HSIyHJP5bPpgvGSY+C4SoAqX90bRYzRZFTFukTXymggtvO8rF9oduuPmuSvWZ9uwQdta
 Z46ADTjPvfiiweVoQpIPXt/6qYUa/n9nvEKuPFSQjBfZL7naHqoxJSF3K0p9wMCembzA
 7ZqO0CzULooucZCa2tCUnSXY6XXc8bb73vlkQh4VotafKbS9k2oYMyQy5eq4mSsln8+Q
 IIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713935042; x=1714539842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbFHZkLIyTsnFbIYjd2AoiBzf3B0mbR9ncwmyQR2oNk=;
 b=U/VgHzVAUa5OsjQ2yq9RnniqLOvk1jlG5sD/cANsmzztH29FMQOYbMbUSDTI9s3LZI
 7CKxZa+cYMrFo1g7My7ARq8iJY0M8rS8rIrj3iBxDzl3NjvWIVYG0ERmtIqiAPiCeneq
 aymWye9lfjKA0m/Smy9TWW7hSn3b2vcuq9fiSx82YWbSSykwx+ILaMMxPlzjUfAtykGu
 lzLfN/0Y+OYl1Ofl6Pwmm4qJaV1pOA3O52gnlE1JocYmzeWkgBsZSsRXf9yzZ+lIcEkn
 IA+qk9e0PKS21zZfN3LG/Vk+4sxL1Y+tkYrvltmv81GdQ1SghjrVwaGadKutWJ8PC1RE
 4s6A==
X-Gm-Message-State: AOJu0YzSvWv3XWv+H0E8cVpTHvUzNZVtRziONFRYS8zlOd6tmqshzleL
 QuoQnruFFGxtIVLELope6xa/JBDU+wg0d8ykcWonzTy7XUwot/ZgKfvPk+jFoOyG64Hb1U6mO1m
 r3/w=
X-Google-Smtp-Source: AGHT+IGSZM6xVLJO41v8sWTIttgRbzhc60Yiedm/9bRjGwGumb8twM1H6/UJn+ZcjdY2W7BphjnlNQ==
X-Received: by 2002:a05:600c:208:b0:41a:aad8:e393 with SMTP id
 8-20020a05600c020800b0041aaad8e393mr902439wmi.30.1713935041889; 
 Tue, 23 Apr 2024 22:04:01 -0700 (PDT)
Received: from hades.. (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 bi8-20020a05600c3d8800b0041afe0f2f17sm861032wmb.16.2024.04.23.22.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 22:04:01 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] efi_selftest: add tests for QueryVariableInfo at runtime
Date: Wed, 24 Apr 2024 08:03:50 +0300
Message-Id: <20240424050351.318724-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
References: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
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

Since we support QueryVariableInfo at runtime now add the relevant
tests. Since we want those to be reusable at bootime, add them
in a separate file

Add tests for
- Test QueryVariableInfo returns EFI_SUCCESS
- Test null pointers for the function arguments
- Test invalid combination of attributes

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_selftest.h                        |   9 ++
 lib/efi_selftest/Makefile                     |   1 +
 .../efi_selftest_variables_common.c           | 102 ++++++++++++++++++
 .../efi_selftest_variables_runtime.c          |  10 +-
 4 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 lib/efi_selftest/efi_selftest_variables_common.c

diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 5bcebb368287..ca7ae948663e 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -147,6 +147,15 @@ void *efi_st_get_config_table(const efi_guid_t *guid);
  */
 u16 efi_st_get_key(void);
 
+/**
+ * efi_st_query_variable_common - Common variable tests for boottime/runtime
+ *
+ * @runtime:	Pointer to services table
+ *
+ * Return:	EFI_ST_SUCCESS/FAILURE
+ */
+int efi_st_query_variable_common(struct efi_runtime_services *runtime);
+
 /**
  * struct efi_unit_test - EFI unit test
  *
diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index e4d75420bff6..414701893f65 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -45,6 +45,7 @@ efi_selftest_textinputex.o \
 efi_selftest_textoutput.o \
 efi_selftest_tpl.o \
 efi_selftest_util.o \
+efi_selftest_variables_common.o \
 efi_selftest_variables.o \
 efi_selftest_variables_runtime.o \
 efi_selftest_watchdog.o
diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
new file mode 100644
index 000000000000..36bdfe6ff9c3
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_variables_common.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * efi_selftest_variables_runtime
+ *
+ * Copyright (c) 2024 Ilias Apalodimas <ilias.apalodimas@linaro.org>
+ *
+ * This unit test checks common service across boottime/runtime
+ */
+
+#include <efi_selftest.h>
+
+#define EFI_INVALID_ATTR BIT(30)
+
+int efi_st_query_variable_common(struct efi_runtime_services *runtime)
+{
+	efi_status_t ret;
+	u64 max_storage, rem_storage, max_size;
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
+					   NULL, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
+					   &max_storage, NULL,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
+					   &max_storage, &rem_storage,
+					   NULL);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(0, &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
+					   EFI_VARIABLE_NON_VOLATILE,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_UNSUPPORTED) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Use an attribute bit not described in the EFI spec */
+	ret = runtime->query_variable_info(EFI_INVALID_ATTR, &max_storage,
+					   &rem_storage, &max_size);
+	if (ret != EFI_UNSUPPORTED) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS, &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE, &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/*
+	 * Use a mix existing/non-existing attribute bits from the
+	 * UEFI spec
+	 */
+	ret = runtime->query_variable_info(EFI_INVALID_ATTR | EFI_VARIABLE_NON_VOLATILE,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 5794a7b2d405..6cb86771fe78 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -55,18 +55,20 @@ static int execute(void)
 	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
 	efi_guid_t guid;
 	u64 max_storage, rem_storage, max_size;
+	int test_ret;
 
 	memset(v2, 0x1, sizeof(v2));
-	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
-					   &max_storage, &rem_storage,
-					   &max_size);
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
-		if (ret != EFI_SUCCESS) {
+		test_ret = efi_st_query_variable_common(runtime);
+		if (test_ret != EFI_ST_SUCCESS) {
 			efi_st_error("QueryVariableInfo failed\n");
 			return EFI_ST_FAILURE;
 		}
 	} else {
+		ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
+					   &max_storage, &rem_storage,
+					   &max_size);
 		if (ret != EFI_UNSUPPORTED) {
 			efi_st_error("QueryVariableInfo failed\n");
 			return EFI_ST_FAILURE;
-- 
2.40.1

