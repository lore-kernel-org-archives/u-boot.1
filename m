Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 05:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCDC88EEC;
	Thu, 25 Apr 2024 07:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KGFF65XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF73788EBD; Thu, 25 Apr 2024 07:18:31 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892E488EB5
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso7377391fa.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714022308; x=1714627108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuaPUZBqRAr7s509m9cf3KVgbgvPME4rCHMJnN4ptzw=;
 b=KGFF65XJIHviga5ujb93zaDTX7UbvUP08S0JRs2aXu2rNzwczE8UQchqL+vhbsyWmV
 H8eu+V8pZUJ2/fJaCwqY0ETNGcLRpLpaEtpo+SHHkK3KK/Ovtak05FJ2CmkO2bDMW9bi
 SmrfRA4UWCxlH5pk+1vQ9rYX+EAjpyyMNlE1yB0ETACwsZ9IsWZzteoC8Y9FbX60ypdp
 KF0iB+AWfnv25q13Ky8Obc0/bJ6bCgCpi71B5NBUJ9uZwKDGLHL6cj4o5Ltf61T/wn8R
 Ee69ZHbqgiWUpZc8a7Dh+2lY7LNIdRHZG6q6WXxMTPf+wY4vftFbdXh4tOZVvyBhL2JP
 UqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714022308; x=1714627108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IuaPUZBqRAr7s509m9cf3KVgbgvPME4rCHMJnN4ptzw=;
 b=TABITWMXi42nxG8OQtR8CKm3PwHQweeWf+9lSrbt+7uVFVvPbzWF4gv2KKDuIkaDQc
 nAN94hoHruad8ez4FIF9bNC2ZKPOvbqB5wuaOgz/GmIX3wp6RadbHVOY3XuYMfBGoePk
 dK14UYAjt57Ra5MfzxENNtbvY0ZAALlCMOxFpWq74AD1rlQjoEDnhq4O/Ka1WVM3+dJi
 nTM3iIBwektIrRe0w3hcPb/p1l0r7OQgjQaSHvpgqOxkpbqDl7mi4u4lyGJarojf4qBu
 jp9NeinnmoGBuyA15hSIr/A8wltDfWUyRDTZHALxep82/NTHkb/4GXDHNPLUGPpgRkry
 gNQw==
X-Gm-Message-State: AOJu0YwCgJbxv/Dscj04Piu5FnkD9RXgbQJeFocwVmB7N2/SrYyDt3+N
 XQW1iOG/A6IkMQnqAa7ZKpWr7ljE1qMmNRKeTN5OI8tH+AU1uB63dKu698l47tTqhHPpo5uorfq
 WJIE=
X-Google-Smtp-Source: AGHT+IHaFLc9bzbxLUQbLW13QOq60Uik2CLAJFd1mS1VIAo+ZU3h2YMqFl2TC+yQPCiPFhlLFFVU5Q==
X-Received: by 2002:a2e:b947:0:b0:2d8:5af9:90c5 with SMTP id
 7-20020a2eb947000000b002d85af990c5mr3400576ljs.39.1714022307775; 
 Wed, 24 Apr 2024 22:18:27 -0700 (PDT)
Received: from hades.. (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 l6-20020aa7d946000000b005723151e99asm1410826eds.95.2024.04.24.22.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 22:18:27 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 2/3] efi_selftest: add tests for QueryVariableInfo at
 runtime
Date: Thu, 25 Apr 2024 08:18:20 +0300
Message-Id: <20240425051821.338842-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
References: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
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
Changes since v1:
- Pass the attributers as well in efi_st_query_variable_common() and
  check for runtime/boottime
 include/efi_selftest.h                        | 11 +++
 lib/efi_selftest/Makefile                     |  1 +
 .../efi_selftest_variables_common.c           | 99 +++++++++++++++++++
 .../efi_selftest_variables_runtime.c          | 11 ++-
 4 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 lib/efi_selftest/efi_selftest_variables_common.c

diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 5bcebb368287..1b708849bcb9 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -147,6 +147,17 @@ void *efi_st_get_config_table(const efi_guid_t *guid);
  */
 u16 efi_st_get_key(void);

+/**
+ * efi_st_query_variable_common - Common variable tests for boottime/runtime
+ *
+ * @runtime:	Pointer to services table
+ * @attributes: Attributes used
+ *
+ * Return:	EFI_ST_SUCCESS/FAILURE
+ */
+int efi_st_query_variable_common(struct efi_runtime_services *runtime,
+				 u32 attributes);
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
index 000000000000..e29a4be74a57
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_variables_common.c
@@ -0,0 +1,99 @@
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
+int efi_st_query_variable_common(struct efi_runtime_services *runtime,
+				 u32 attributes)
+{
+	efi_status_t ret;
+	u64 max_storage, rem_storage, max_size;
+
+	ret = runtime->query_variable_info(attributes,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(attributes,
+					   NULL, &rem_storage,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(attributes,
+					   &max_storage, NULL,
+					   &max_size);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(attributes,
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
+	ret = runtime->query_variable_info(attributes |
+					   EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
+					   EFI_VARIABLE_NON_VOLATILE,
+					   &max_storage, &rem_storage,
+					   &max_size);
+	if (ret != EFI_UNSUPPORTED) {
+		efi_st_error("QueryVariableInfo failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE,
+					   &max_storage, &rem_storage,
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
+	ret = runtime->query_variable_info(attributes | EFI_INVALID_ATTR |
+					   EFI_VARIABLE_NON_VOLATILE,
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
index 5794a7b2d405..379c4f9c47b7 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -55,18 +55,21 @@ static int execute(void)
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
+		test_ret = efi_st_query_variable_common(runtime, EFI_VARIABLE_BOOTSERVICE_ACCESS |
+								 EFI_VARIABLE_RUNTIME_ACCESS);
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

