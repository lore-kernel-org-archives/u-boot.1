Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8249CE7A8E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF02E8400F;
	Fri, 14 Nov 2025 10:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jesS2r0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D37983F20; Fri, 14 Nov 2025 10:33:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3FA84013
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3B6ED402D4
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112778;
 bh=MZ/hZ8e1iDEeJb9BSZd/JTva4gbu8rHrb86W+tKNqpA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jesS2r0ZEL9JvPt7Jkzzrom/WRpob21ZsWcz9+45L3XFz0DEyCWaHyfzNLFIdmOG6
 G16bA2Fyc0nUZ2hZgX42+nKe782VjyT1iMFI5lEUQdzOR5QTJNfZJpLnaZ6CeO/jvH
 ipOh3qSXNVrxUIAl0oQsFu+J/VGkKTP/6MEH87Pt/RNodhblNLOfzcaOwxr+0o2OLj
 O5GCs8p+HkbbDC8oc44zhyVk4ay6mApiEV3OXFF1xx65KeA+mypCVEtknd2jxj8yLv
 AGJGi+C8qKfUoJ8ideTrObk39vwSGM21EmbKDM/9ZQDvuvNyl3ah5UqdR0fKnkjNlQ
 Wv/BIADZXtXGlz1miz4zJPKD5Y/qqNDomhwmsPZQb8Cqqfter84TVnWlAZkkjkjdU5
 VjRnCGkLapYwoFWljUPAOSPxp3oz7yX568hnWH7A82+Kt37h0+OUxQmQ5+XPGmT9so
 3xhtiM8xYzYL3UHh72vVrjEWBAeKsWKfi2FF73QMwJzalHvLpRUb27zRMUH9Gr1aI+
 k8Hrqr3aZNalEQ7CsETCxx9m6hTzopjSnd1Wchkz2U5AP7rsH5KU/fF4/SEnhFE3cY
 /J8xkBo4ss1Ywn7V6/kKiNqYuVvYdd9eJy1j0Wu5gcLK5wdtp8I+GZ7jeO1a5MQeDW
 gbXtiIUOCA1QEgaCCAu/j8PY=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47754e6bddbso13344385e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112775; x=1763717575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZ/hZ8e1iDEeJb9BSZd/JTva4gbu8rHrb86W+tKNqpA=;
 b=QUUFNEOMruYNjaAwgXHZAcKWPbC7ykbsdL5EGaVgz1QFKqt9wt2F0HwbXeYwwdMzCi
 rPJ/j3MS6IMX8GzGtF+UIsnQp9XhEpH4hf/eM4IYJqs7dEXaWfkJY9Xr0Dt4HTOt84l4
 Gqs34Q7F2Ag8oU60Y7VRNmm8YcCT0omXdyFJYBSTqNXVnqD/eTT3RczYS4eAvWNDQb7D
 A4Ku6rnXCOvgwGNfWsuBnuDV3RfmEi2WYnBb3n1KjkE5J3cPD50+Iz6H2v9/3aGtkssP
 FBDaROFnHvnQO1cpeutx4JRB0WSuumDcMiyeNH8YElhD0Lb+EhzKHCkBDFjmec3lXoLG
 aT4Q==
X-Gm-Message-State: AOJu0YzaBWCnR3sqG4guPR9mp9CBlWgb6c+JU0+rQ5ef6lEyHeNJw7vl
 gzzZKpsfxUQgMcsWEnmmmuUA8gNfqVYNKPXKtf+R6NaRNNlyQA13N5lWG2BXgB23e4r1JgCOqAQ
 TAyeiCG1HJ0YydIiXLXtNHYYrdPPF0eC9Lvxt4/7ighWHmzvrWp9EIwS6K5TxpoEXkan9pJY=
X-Gm-Gg: ASbGncsOIUI1Oa4/IjK024XRChArEyqnsoNt7a+nOSwtvWMrvR7usKwXGN3IVAZQ3Vx
 NmwYGvFczHdeP+lmhAeR0ElyUG6Inb2cg5BZ1aDEExbQJGyz2i95yONLopkXL1gg/rWEhulYiXz
 /nPv/q1FU6MpdJaI2zarFgiP6OBgTZ5eWJn9BAVxRQKs6JWGiYypB8sT5IuwxmzMgpmN/ConZcr
 hjQ76RHO0HCHkLD3aWdlCGBISJwAJBgmkkrTcHs0J+c4c1j23QHJuEim3++qQGfqhZAwOi34N5i
 G2fhALITKPe4WDTRZymGoQuHMVw01tF1wVAFsr+kLhaVpX8d/e4JRt94ckYmW2VRVeHyJEJzk9H
 p5clzEDOlUt+WzBFBEskkv1Ml6ISPe6+2IObPhoHc0hh6ZBDMQtyBMDgbUB0iD9HUPw==
X-Received: by 2002:a05:600c:3512:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-4778fe5ecf9mr27241335e9.6.1763112775255; 
 Fri, 14 Nov 2025 01:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAVvMdNnE/YqvjJC1h1wVWinuO+FQZ8xQAKplNWMoZqCgia+BzkGfj5kQdEhJS+fjXIsDVuA==
X-Received: by 2002:a05:600c:3512:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-4778fe5ecf9mr27240975e9.6.1763112774811; 
 Fri, 14 Nov 2025 01:32:54 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:54 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/7] efi_selftest: simplify efi_st_query_variable_common
Date: Fri, 14 Nov 2025 10:32:44 +0100
Message-ID: <20251114093246.56422-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Use global st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_selftest.h                        |  4 +-
 lib/efi_selftest/efi_selftest_variables.c     |  3 +-
 .../efi_selftest_variables_common.c           | 55 ++++++++-----------
 .../efi_selftest_variables_runtime.c          |  4 +-
 4 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 4ee46cbbb66..874f8b5efe7 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -151,13 +151,11 @@ u16 efi_st_get_key(void);
 /**
  * efi_st_query_variable_common - Common variable tests for boottime/runtime
  *
- * @runtime:	Pointer to services table
  * @attributes: Attributes used
  *
  * Return:	EFI_ST_SUCCESS/FAILURE
  */
-int efi_st_query_variable_common(struct efi_runtime_services *runtime,
-				 u32 attributes);
+int efi_st_query_variable_common(u32 attributes);
 
 /**
  * struct efi_unit_test - EFI unit test
diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index 3d5f38c6897..b92c3276b61 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -53,8 +53,7 @@ static int execute(void)
 	efi_guid_t guid;
 	int test_ret;
 
-	test_ret = efi_st_query_variable_common(runtime,
-						EFI_VARIABLE_BOOTSERVICE_ACCESS);
+	test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS);
 	if (test_ret != EFI_ST_SUCCESS) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
index 453bc8709a6..704da016c6d 100644
--- a/lib/efi_selftest/efi_selftest_variables_common.c
+++ b/lib/efi_selftest/efi_selftest_variables_common.c
@@ -11,15 +11,13 @@
 
 #define EFI_INVALID_ATTR BIT(30)
 
-int efi_st_query_variable_common(struct efi_runtime_services *runtime,
-				 u32 attributes)
+int efi_st_query_variable_common(u32 attributes)
 {
 	efi_status_t ret;
 	u64 max_storage, rem_storage, max_size;
 
-	ret = runtime->query_variable_info(attributes,
-					   &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(attributes, &max_storage,
+					      &rem_storage, &max_size);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
@@ -28,58 +26,54 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime,
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
-					   &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
+					      &max_storage, &rem_storage,
+					      &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(attributes,
-					   NULL, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(attributes, NULL, &rem_storage,
+					      &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(attributes,
-					   &max_storage, NULL,
-					   &max_size);
+	ret = st_runtime->query_variable_info(attributes, &max_storage, NULL,
+					      &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(attributes,
-					   &max_storage, &rem_storage,
-					   NULL);
+	ret = st_runtime->query_variable_info(attributes, &max_storage,
+					      &rem_storage, NULL);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(0, &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(0, &max_storage, &rem_storage,
+					      &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(attributes |
-					   EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
-					   EFI_VARIABLE_NON_VOLATILE,
-					   &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(
+		attributes | EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		&max_storage, &rem_storage, &max_size);
 	if (ret != EFI_UNSUPPORTED) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE,
-					   &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE,
+					      &max_storage, &rem_storage,
+					      &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
@@ -89,10 +83,9 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime,
 	 * Use a mix existing/non-existing attribute bits from the
 	 * UEFI spec
 	 */
-	ret = runtime->query_variable_info(attributes | EFI_INVALID_ATTR |
-					   EFI_VARIABLE_NON_VOLATILE,
-					   &max_storage, &rem_storage,
-					   &max_size);
+	ret = st_runtime->query_variable_info(
+		attributes | EFI_INVALID_ATTR | EFI_VARIABLE_NON_VOLATILE,
+		&max_storage, &rem_storage, &max_size);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 379c4f9c47b..4be37efc1fc 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -60,8 +60,8 @@ static int execute(void)
 	memset(v2, 0x1, sizeof(v2));
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
-		test_ret = efi_st_query_variable_common(runtime, EFI_VARIABLE_BOOTSERVICE_ACCESS |
-								 EFI_VARIABLE_RUNTIME_ACCESS);
+		test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS |
+							EFI_VARIABLE_RUNTIME_ACCESS);
 		if (test_ret != EFI_ST_SUCCESS) {
 			efi_st_error("QueryVariableInfo failed\n");
 			return EFI_ST_FAILURE;
-- 
2.51.0

