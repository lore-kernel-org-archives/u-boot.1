Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF3CE7A9B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DA68404D;
	Fri, 14 Nov 2025 10:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SAV3q9G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6F183FF4; Fri, 14 Nov 2025 10:33:06 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4605B83FFC
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4975F3FD0D
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112780;
 bh=liLvzbWehKNojGMWPx2gohI+UFAmkV4r6uAySaE8bsg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SAV3q9G7bwjj3ymmq2dLJ/U/4dzThD2o7rNqY5WVQPdbz1ZfRP5WOgWdqaFtyV4sw
 YrD6EqDowse+amAsvLf+X4fDn/MAsn8U5YbYeEPKEqUMA5Lo1YBtKkHYzSTTgBwXQF
 1hVKttK+EXGGtaq+3uD9hcnz6NkMu3UWc/MUqXX6rwg9bE1/AmmH/xcjnPUcgViUpV
 gJaJqEQzTgunHne86CZZL153W6xVMKNreRyuL7LP4tJIargRd/5pcnm+OaD8n4OZdI
 05WCVsjTn0xCJ89oYfr7rdqfxh0TlBble+nnzROBTXo1Ii3BqZRu2r4HwRwu+XhKcg
 Ps2vLrUheJLQ1lt04qlPmcF7w8Fm0Y80QHiR+SUedxkF9Yfu96slanFaQv+rCte797
 IFMgnRXTilg6S+eqJBZy6woVZt5H2w4sPqHiBpJs3Fi2aj9b4tUKs6cuwiK2NOlbyT
 Xp3/0QHjBOtVU768PJDQlfgu/Wx4ROj9rL5JapDQu1BQxWBulzkdOLdEp9TSro9bUi
 4JB8WzkAox01OJWucuq5lh9MwQPJlvlUqupMjwlJnkzPuCMJb6wIuvX1CXZCdzaQHL
 FUI27qMHMJLSaSDhZ90065oz5yTho/MxKM+YLHO/KhXG3tg+eeRaagsUNx9ODcaR12
 xmmtnPyPE5+uIBLtOnHgJAH8=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477212937eeso10505815e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112777; x=1763717577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=liLvzbWehKNojGMWPx2gohI+UFAmkV4r6uAySaE8bsg=;
 b=gNUDTvPkHVFuSw9noLMoIEvF+4cAA61EvBfGj9JiCIkrysDf3xMU7xMLmKq8U2GRzM
 YCz3gpxyXD5UnWATtegh3CcsLJaRRUUu0B59eYHNk/96Ah4EQSQNwIQNqyVMSv2OOUH1
 pX7/HJalA9IXz5z5arrEENaPCk7skDbUAxbJbXDC3zHynMeaSSe7rl1laA5+fYH/SC8C
 IdlxsIgxMw4a2MJsgI5fiYxZ3OqSAk36zq+19SYDgbGyLnH2Lisdi/emAkZGKEQQauHq
 Zxm/u5kV3btq6aEukl+IRgy9HaldanncDtwojgOmwQEPu4nzsT9SJVeRYKAn1fiRPDfO
 lgPA==
X-Gm-Message-State: AOJu0YyxmgS7AXXhUOm+q7Uwd4Kj990mx2KTak2Non1F8M7QTiKY/7NG
 eYy8bbsM5eDsCCJvNoFZ6ZpzixbWoRsgzBZhkUtFVaO+CXNCYrVI0sRnyA9g+c1YrilWE/W5y9H
 pLHXwXrwSFsodwIZeEq9Tp2wUwWx9IBpIXK7k2M1fBBXex0/QB4rl+FfJ1psK6FrCwixcXH1k3u
 jE757MWg==
X-Gm-Gg: ASbGncu77zZDPVCbvhS+1+jCOFAv/UT6MK969TyBqlXVE9DBaTgnGm+SovbaE2h5V8o
 dsSxxh6afZrDcEwrtiHXOJLYNkkHfMSbjbbaVGQLTQHhNSkTJXDWg7mNPZCH9b2oYP2BobNqifS
 zV3J5BKTUUAn+gzfiy/ePE/Yyw2n8hjZYspHKw0DsswlPfnV8Jj1wUieGWEHvuMipQy0PXCAaUT
 RRGve0+FN83vMPLkXZxVFAbuA4lOEYSjLAXnT5jITvPbck4a2dFlUYxda7Ys/Xz3R6vVlxc5aeI
 8BUycGHVAI/nWbkKPrtVBOfYa71X+bDn+rX686eVDCRnIGOHyeKeOdKe3Oxa7pNlQbQGNQ6N/DK
 4oQvGuUmKlu4D8QPMjuNdNui3HJa9+VFxuPknU64fTC/j+eeWqtmxxqdrAWQfnI579g==
X-Received: by 2002:a05:600c:468a:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-4778fe10651mr19831535e9.0.1763112776984; 
 Fri, 14 Nov 2025 01:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENB7LWP5ygCJbsukJ0R4cfeCHGzWiVr8byeNpK/l+/7u/TzADCc1kxgxzl3aL9IvcBJNbWZw==
X-Received: by 2002:a05:600c:468a:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-4778fe10651mr19831325e9.0.1763112776548; 
 Fri, 14 Nov 2025 01:32:56 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:56 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 7/7] efi_selftest: simplify efi_selftest_variables_runtime
Date: Fri, 14 Nov 2025 10:32:46 +0100
Message-ID: <20251114093246.56422-8-heinrich.schuchardt@canonical.com>
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

Use global st_boottime and st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../efi_selftest_variables_runtime.c          | 183 +++++++++---------
 1 file changed, 88 insertions(+), 95 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 4be37efc1fc..0886b4894b8 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -16,26 +16,9 @@
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 40
 
-static struct efi_boot_services *boottime;
-static struct efi_runtime_services *runtime;
 static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
 static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
-						U_BOOT_EFI_RT_VAR_FILE_GUID;
-
-/*
- * Setup unit test.
- *
- * @handle	handle of the loaded image
- * @systable	system table
- */
-static int setup(const efi_handle_t img_handle,
-		 const struct efi_system_table *systable)
-{
-	boottime = systable->boottime;
-	runtime = systable->runtime;
-
-	return EFI_ST_SUCCESS;
-}
+	U_BOOT_EFI_RT_VAR_FILE_GUID;
 
 /**
  * execute() - execute unit test
@@ -60,26 +43,27 @@ static int execute(void)
 	memset(v2, 0x1, sizeof(v2));
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
-		test_ret = efi_st_query_variable_common(EFI_VARIABLE_BOOTSERVICE_ACCESS |
-							EFI_VARIABLE_RUNTIME_ACCESS);
+		test_ret = efi_st_query_variable_common(
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS);
 		if (test_ret != EFI_ST_SUCCESS) {
 			efi_st_error("QueryVariableInfo failed\n");
 			return EFI_ST_FAILURE;
 		}
 	} else {
-		ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
-					   &max_storage, &rem_storage,
-					   &max_size);
+		ret = st_runtime->query_variable_info(
+			EFI_VARIABLE_BOOTSERVICE_ACCESS, &max_storage,
+			&rem_storage, &max_size);
 		if (ret != EFI_UNSUPPORTED) {
 			efi_st_error("QueryVariableInfo failed\n");
 			return EFI_ST_FAILURE;
 		}
 	}
 
-	ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				    EFI_VARIABLE_RUNTIME_ACCESS,
-				    3, v + 4);
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS,
+				       3, v + 4);
 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
 		efi_uintn_t prev_len, delta;
 		struct efi_var_entry *var;
@@ -91,20 +75,21 @@ static int execute(void)
 			return EFI_ST_FAILURE;
 		}
 
-		/* runtime atttribute must be set */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    3, v + 4);
+		/* runtime attribute must be set */
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			3, v + 4);
 		if (ret != EFI_INVALID_PARAMETER) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		len = sizeof(data);
-		ret = runtime->get_variable(u"RTStorageVolatile",
-					    &efi_rt_var_guid,
-					    &attr, &len, data);
+		ret = st_runtime->get_variable(u"RTStorageVolatile",
+					       &efi_rt_var_guid, &attr, &len,
+					       data);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("GetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -118,8 +103,8 @@ static int execute(void)
 		}
 
 		len = sizeof(data2);
-		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					    &attr, &len, data2);
+		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					       &attr, &len, data2);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("GetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -129,12 +114,12 @@ static int execute(void)
 		 * Store it now, we'll use it later
 		 */
 		prev_len = len;
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    sizeof(v2),
-					    v2);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			sizeof(v2), v2);
 		/*
 		 * This will try to update VarToFile as well and must fail,
 		 * without changing or deleting VarToFile
@@ -144,60 +129,64 @@ static int execute(void)
 			return EFI_ST_FAILURE;
 		}
 		len = sizeof(data2);
-		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					    &attr, &len, data2);
+		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					       &attr, &len, data2);
 		if (ret != EFI_SUCCESS || prev_len != len) {
 			efi_st_error("Get/SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Add an 8byte aligned variable */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    sizeof(v), v);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			sizeof(v), v);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Delete it by setting the attrs to 0 */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    0, sizeof(v), v);
+		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0,
+					       sizeof(v), v);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Add it back */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    sizeof(v), v);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			sizeof(v), v);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Delete it again by setting the size to 0 */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    0, NULL);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			0, NULL);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Delete it again and make sure it's not there */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    0, NULL);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			0, NULL);
 		if (ret != EFI_NOT_FOUND) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -207,11 +196,12 @@ static int execute(void)
 		 * Add a non-aligned variable
 		 * VarToFile updates must include efi_st_var0
 		 */
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    9, v + 4);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			9, v + 4);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -223,8 +213,8 @@ static int execute(void)
 		}
 		delta = efi_var_entry_len(var);
 		len = sizeof(data2);
-		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					    &attr, &len, data2);
+		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					       &attr, &len, data2);
 		if (ret != EFI_SUCCESS || prev_len + delta != len) {
 			efi_st_error("Get/SetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -237,25 +227,27 @@ static int execute(void)
 		 */
 		prev_len = len;
 		avail = efi_var_entry_len(var) -
-			(sizeof(u16) * (u16_strlen(var->name) + 1) + sizeof(*var)) -
+			(sizeof(u16) * (u16_strlen(var->name) + 1) +
+			 sizeof(*var)) -
 			var->length;
 		if (avail >= append_len)
 			delta = 0;
 		else
 			delta = ALIGN(append_len - avail, 8);
-		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_APPEND_WRITE |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    append_len, v2);
+		ret = st_runtime->set_variable(
+			u"efi_st_var0", &guid_vendor0,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_APPEND_WRITE |
+				EFI_VARIABLE_NON_VOLATILE,
+			append_len, v2);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
 		len = sizeof(data2);
-		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					    &attr, &len, data2);
+		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					       &attr, &len, data2);
 		if (ret != EFI_SUCCESS) {
 			efi_st_error("GetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -267,20 +259,22 @@ static int execute(void)
 
 		/* Make sure that variable contains a valid file */
 		hdr = (struct efi_var_file *)data2;
-		if (hdr->magic != EFI_VAR_FILE_MAGIC ||
-		    len != hdr->length ||
-		    hdr->crc32 != crc32(0, (u8 *)((uintptr_t)data2 + sizeof(struct efi_var_file)),
+		if (hdr->magic != EFI_VAR_FILE_MAGIC || len != hdr->length ||
+		    hdr->crc32 != crc32(0,
+					(u8 *)((uintptr_t)data2 +
+					       sizeof(struct efi_var_file)),
 					len - sizeof(struct efi_var_file))) {
 			efi_st_error("VarToFile invalid header\n");
 			return EFI_ST_FAILURE;
 		}
 
 		/* Variables that are BS, RT and volatile are RO after EBS */
-		ret = runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
-					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-					    EFI_VARIABLE_RUNTIME_ACCESS |
-					    EFI_VARIABLE_NON_VOLATILE,
-					    sizeof(v), v);
+		ret = st_runtime->set_variable(
+			u"VarToFile", &efi_rt_var_guid,
+			EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS |
+				EFI_VARIABLE_NON_VOLATILE,
+			sizeof(v), v);
 		if (ret != EFI_WRITE_PROTECTED) {
 			efi_st_error("Get/SetVariable failed\n");
 			return EFI_ST_FAILURE;
@@ -292,8 +286,8 @@ static int execute(void)
 		}
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
+				       &attr, &len, data);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetVariable failed\n");
 		return EFI_ST_FAILURE;
@@ -301,7 +295,7 @@ static int execute(void)
 	memset(&guid, 0, 16);
 	*varname = 0;
 	len = 2 * EFI_ST_MAX_VARNAME_SIZE;
-	ret = runtime->get_next_variable_name(&len, varname, &guid);
+	ret = st_runtime->get_next_variable_name(&len, varname, &guid);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetNextVariableName failed\n");
 		return EFI_ST_FAILURE;
@@ -313,6 +307,5 @@ static int execute(void)
 EFI_UNIT_TEST(variables_run) = {
 	.name = "variables at runtime",
 	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
-	.setup = setup,
 	.execute = execute,
 };
-- 
2.51.0

