Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B666C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 05:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F4888EB1;
	Thu, 25 Apr 2024 07:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tBg4HhbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C874F88EC1; Thu, 25 Apr 2024 07:18:29 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7FF88E72
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so590997a12.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 22:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714022307; x=1714627107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sZU5v0XKzUA+H+HmJwzMhgvN+Sc3gtgzBc0ugAZWcqY=;
 b=tBg4HhbDWCGgl6a3P8Bs+jDJO61bUgc9Q4jiuonlAy93H5qF+5VMMx3iuyn8VtPTSn
 bO6QEzlh96OBsNyatiENmDzLS9WjWMHzk8pkKJL1PTe4TJshZ7/0//LB07F3dv5xI2Cf
 YxW/PaC1UTL6YePuRgEioX1fGJ8dIJVKMazddbVW0IRk+qQM9+MmZYtZAR0eOZrg4ueV
 LlXp/DGPjl9BNGz9xB+sIKszucACjY6aY66vhkPzv+fGgnvE+Xvcks1QI8BbEApvdlpW
 QNpfGyRVQLVx/e3MZJK99ADxcoQpSeYbMOtTRESAAyXngd0t+0fv7rSR6NELi78sgcY/
 iitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714022307; x=1714627107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZU5v0XKzUA+H+HmJwzMhgvN+Sc3gtgzBc0ugAZWcqY=;
 b=eiKgD4uV8Mvtb5vl20MHmo15xvnk9B2KjHSbFOWWReuIiyC9EBQnvzjA6bbdbrS4xh
 VuCmKBSz4fIZqjMG+K7y5MxwfDHoiacD4SWYQmMzuW3df+vP/JCzBL1dGVKqQNrp+HOV
 1NEpmfcqe+w6lBeTPgFIMRjB6uKUScoYBEWJ8bch2YQEf/+7hGkEC+6f9aWz3ixUhEfm
 rOffY9oibMjia3favxBkw3J5GUmuUEzT9cAOuSd45LtvPNf/hDzft7lf4XwBiixbbvmH
 mmMTWamyM7zbkGX2U0e59afmBkH1HKMjn3AuG8evrU0rhdbkKQYv1n4bRDcLk9QQD5Dc
 YzXQ==
X-Gm-Message-State: AOJu0Yx1L6uIU19ax/+LXLBFi6DtmNXIRpJw1LO2QTUVgfWV3nUTvycH
 TWxCF6wFOnP9GFMsmreWSjQ81iuwWBOyAw4ZuaJHO04kBuB0g2lBcYtboO+FTKH9gNOs0lpmB4w
 N280=
X-Google-Smtp-Source: AGHT+IGvjiIoyMAbY25W3vsQE/5TSyMetKV9dGg9GmLbiIajJmsJo5TApS4t5ONMWIKyhmONlgnpQg==
X-Received: by 2002:a50:d607:0:b0:56e:32fb:bc7 with SMTP id
 x7-20020a50d607000000b0056e32fb0bc7mr2798318edi.36.1714022306906; 
 Wed, 24 Apr 2024 22:18:26 -0700 (PDT)
Received: from hades.. (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 l6-20020aa7d946000000b005723151e99asm1410826eds.95.2024.04.24.22.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 22:18:26 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/3] efi_loader: enable QueryVariableInfo at runtime for
 file backed variables
Date: Thu, 25 Apr 2024 08:18:19 +0300
Message-Id: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Since commit c28d32f946f0 ("efi_loader: conditionally enable SetvariableRT")
we are enabling the last bits of missing runtime services.
Add support for QueryVariableInfo which we already support at boottime
and we just need to mark some fucntions available at runtime and move
some checks around.

It's worth noting that pointer checks for maxmimum and remaining
variable storage aren't when we store variables on the RPMB, since the
Secure World backend is already performing them.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- require EFI_VARIABLE_RUNTIME_ACCESS to be set at runtime
- return EFI_UNSUPPORTED for auth variables
 lib/efi_loader/efi_runtime.c                  |  4 +++
 lib/efi_loader/efi_var_common.c               |  6 -----
 lib/efi_loader/efi_variable.c                 | 25 ++++++++++++++-----
 lib/efi_loader/efi_variable_tee.c             |  5 ++++
 .../efi_selftest_variables_runtime.c          | 14 ++++++++---
 5 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73831c527e00..011bcd04836d 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -129,6 +129,10 @@ efi_status_t efi_init_runtime_supported(void)
 				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
 				EFI_RT_SUPPORTED_CONVERT_POINTER;

+	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE))
+		rt_table->runtime_services_supported |=
+			EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO;
+
 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
 		u8 s = 0;

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 961139f005af..ea8d2a4cf98c 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0+
 /*
  * UEFI runtime variable services
  *
@@ -163,11 +162,6 @@ efi_status_t EFIAPI efi_query_variable_info(
 	EFI_ENTRY("%x %p %p %p", attributes, maximum_variable_storage_size,
 		  remaining_variable_storage_size, maximum_variable_size);

-	if (!maximum_variable_storage_size ||
-	    !remaining_variable_storage_size ||
-	    !maximum_variable_size)
-		return EFI_EXIT(EFI_INVALID_PARAMETER);
-
 	ret = efi_query_variable_info_int(attributes,
 					  maximum_variable_storage_size,
 					  remaining_variable_storage_size,
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 0cbed53d1dbf..1cc02acb3b26 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -406,12 +406,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	return EFI_SUCCESS;
 }

-efi_status_t efi_query_variable_info_int(u32 attributes,
-					 u64 *maximum_variable_storage_size,
-					 u64 *remaining_variable_storage_size,
-					 u64 *maximum_variable_size)
+efi_status_t __efi_runtime
+efi_query_variable_info_int(u32 attributes,
+			    u64 *maximum_variable_storage_size,
+			    u64 *remaining_variable_storage_size,
+			    u64 *maximum_variable_size)
 {
-	if (attributes == 0)
+	if (!maximum_variable_storage_size ||
+	    !remaining_variable_storage_size ||
+	    !maximum_variable_size || !attributes)
 		return EFI_INVALID_PARAMETER;

 	/* EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated */
@@ -460,7 +463,17 @@ static efi_status_t __efi_runtime EFIAPI efi_query_variable_info_runtime(
 			u64 *remaining_variable_storage_size,
 			u64 *maximum_variable_size)
 {
-	return EFI_UNSUPPORTED;
+	if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
+		return EFI_INVALID_PARAMETER;
+	if ((attributes & (EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
+			   EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |
+			   EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)))
+		return EFI_UNSUPPORTED;
+
+	return efi_query_variable_info_int(attributes,
+					   maximum_variable_storage_size,
+					   remaining_variable_storage_size,
+					   maximum_variable_size);
 }

 /**
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 4f1aa298da13..8b6b0a390869 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -873,6 +873,11 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
 	efi_status_t ret;
 	u8 *comm_buf;

+	if (!max_variable_storage_size ||
+	    !remain_variable_storage_size ||
+	    !max_variable_size || !attributes)
+		return EFI_INVALID_PARAMETER;
+
 	payload_size = sizeof(*mm_query_info);
 	comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
 				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index afa91be62c85..5794a7b2d405 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -60,9 +60,17 @@ static int execute(void)
 	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
 					   &max_storage, &rem_storage,
 					   &max_size);
-	if (ret != EFI_UNSUPPORTED) {
-		efi_st_error("QueryVariableInfo failed\n");
-		return EFI_ST_FAILURE;
+
+	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("QueryVariableInfo failed\n");
+			return EFI_ST_FAILURE;
+		}
+	} else {
+		if (ret != EFI_UNSUPPORTED) {
+			efi_st_error("QueryVariableInfo failed\n");
+			return EFI_ST_FAILURE;
+		}
 	}

 	ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
--
2.40.1

