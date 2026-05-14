Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D9DCD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F49C846C7;
	Thu, 14 May 2026 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iHNDi/ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913BF84683; Thu, 14 May 2026 14:50:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1013684688
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD1DA244C;
 Thu, 14 May 2026 05:50:01 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A293F7B4;
 Thu, 14 May 2026 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778763006; bh=cp9+7y9OuqvadS77lYrj0Jt1HhxmncIZlLcaswmpLzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iHNDi/ZVi/gPuI6tMhupN2Wsi2Fg4aWFhKKE0lz7yUsacRvxrr2UOQPE+vSbj4V77
 UVaOcEux5lvly4C5xLFrBCiBORcAYaajC0qV5whVNjycu53eL6vUigOOl56xo5ft/B
 RAyLiGDP7wkoPbFREjVELGwqmlSZ3vH4maMFqEf0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 08/11] efi: selftest: add runtime variable tests with
 non-volatile storage
Date: Thu, 14 May 2026 13:49:21 +0100
Message-Id: <20260514124924.1804332-9-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Extend runtime variable tests for persistent storage

Runtime variable selftests already cover the volatile-store path in a
single run, but non-volatile storage needs state to survive a reboot.
Make that flow explicit by keeping the existing "variables at runtime"
test for CONFIG_EFI_RT_VOLATILE_STORE=y and adding on-request
"variables at runtime setup" and "variables at runtime verify" tests
for the non-volatile case.

The setup phase runs QueryVariableInfo(), exercises create/delete of a
runtime variable, prepares the persistent test state, and prompts the
user to reboot and run the verify test. If an old test variable is
already present, reuse it only when it matches the expected
half-payload; otherwise delete it and recreate clean state. The setup
path also performs a best-effort cleanup if a later check fails.

The verify phase checks the prepared value, appends the remaining
payload, validates the full contents, deletes the test variable, and
confirms that it is gone.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Simon:

- Split the non-volatile flow into setup and verify tests
- Keep the single-run test only for volatile-store builds
- Reuse shared QueryVariableInfo and enumeration helpers
- Make setup and verify logs stage-specific

 .../efi_selftest_variables_runtime.c          | 713 ++++++++++++------
 1 file changed, 481 insertions(+), 232 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index fd570d673f0..510e3f4c302 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -3,6 +3,7 @@
  * efi_selftest_variables_runtime
  *
  * Copyright (c) 2019 Heinrich Schuchardt <xypron.glpk@gmx.de>
+ * Copyright (c) 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * This unit test checks the runtime services for variables after
  * ExitBootServices():
@@ -17,36 +18,28 @@
 #define EFI_ST_MAX_VARNAME_SIZE 40
 
 static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
 
 /**
- * execute() - execute unit test
+ * check_runtime_query_variable_info() - Run QueryVariableInfo() checks
+ * @phase: test phase string used in failure logs
+ *
+ * Run the runtime QueryVariableInfo() checks for the current test phase.
  *
- * As runtime support is not implmented expect EFI_UNSUPPORTED to be returned.
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
  */
-static int execute(void)
+static int check_runtime_query_variable_info(const char *phase)
 {
 	efi_status_t ret;
-	efi_uintn_t len, avail, append_len = 17;
-	u32 attr;
-	u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
-		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
-	u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
-	u8 data[EFI_ST_MAX_DATA_SIZE];
-	u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
-	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
-	efi_guid_t guid;
 	u64 max_storage, rem_storage, max_size;
 	int test_ret;
 
-	memset(v2, 0x1, sizeof(v2));
-
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
 		test_ret = efi_st_query_variable_common(
 			EFI_VARIABLE_BOOTSERVICE_ACCESS |
 			EFI_VARIABLE_RUNTIME_ACCESS);
 		if (test_ret != EFI_ST_SUCCESS) {
-			efi_st_error("QueryVariableInfo failed\n");
+			efi_st_error("%s: QueryVariableInfo checks failed\n",
+				     phase);
 			return EFI_ST_FAILURE;
 		}
 	} else {
@@ -54,257 +47,513 @@ static int execute(void)
 			EFI_VARIABLE_BOOTSERVICE_ACCESS, &max_storage,
 			&rem_storage, &max_size);
 		if (ret != EFI_UNSUPPORTED) {
-			efi_st_error("QueryVariableInfo failed\n");
+			efi_st_error("%s: QueryVariableInfo returned status=%lx\n",
+				     phase, (ulong)ret);
 			return EFI_ST_FAILURE;
 		}
 	}
 
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * check_runtime_variable_enumeration() - Check runtime variable enumeration
+ * @phase: test phase string used in failure logs
+ *
+ * Confirm that runtime variable reads and GetNextVariableName() still work
+ * while the current test state is present.
+ *
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
+ */
+static int check_runtime_variable_enumeration(const char *phase)
+{
+	efi_status_t ret;
+	efi_uintn_t len;
+	u32 attr = 0;
+	u8 data[EFI_ST_MAX_DATA_SIZE];
+	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
+	efi_guid_t guid;
+
+	len = sizeof(data);
+	ret = st_runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
+				       &attr, &len, data);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("%s: failed to read PlatformLangCodes, status=%lx\n",
+			     phase, (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	memset(&guid, 0, sizeof(guid));
+	*varname = 0;
+	len = sizeof(varname);
+	ret = st_runtime->get_next_variable_name(&len, varname, &guid);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("%s: GetNextVariableName failed, status=%lx\n",
+			     phase, (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+#ifdef CONFIG_EFI_RT_VOLATILE_STORE
+static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
+
+/**
+ * execute() - Execute the single-run volatile-store runtime test
+ *
+ * Run the runtime variable checks that complete in a single invocation when
+ * the runtime store is volatile.
+ *
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
+ */
+static int execute(void)
+{
+	efi_status_t ret;
+	efi_uintn_t len, avail, append_len = 17;
+	u32 attr = 0;
+	u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
+		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
+	u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
+	u8 data[EFI_ST_MAX_DATA_SIZE];
+	u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
+	efi_uintn_t prev_len, delta;
+	struct efi_var_entry *var;
+	struct efi_var_file *hdr;
+
+	memset(v2, 0x1, sizeof(v2));
+
+	if (check_runtime_query_variable_info("runtime") != EFI_ST_SUCCESS)
+		return EFI_ST_FAILURE;
+
 	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
 				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
 					       EFI_VARIABLE_RUNTIME_ACCESS,
 				       3, v + 4);
-	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
-		efi_uintn_t prev_len, delta;
-		struct efi_var_entry *var;
-		struct efi_var_file *hdr;
-
-		/* At runtime only non-volatile variables may be set. */
-		if (ret != EFI_INVALID_PARAMETER) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
 
-		/* runtime attribute must be set */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			3, v + 4);
-		if (ret != EFI_INVALID_PARAMETER) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* At runtime only non-volatile variables may be set. */
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		len = sizeof(data);
-		ret = st_runtime->get_variable(u"RTStorageVolatile",
-					       &efi_rt_var_guid, &attr, &len,
-					       data);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("GetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* runtime attribute must be set */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		3, v + 4);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		if (len != sizeof(EFI_VAR_FILE_NAME) ||
-		    memcmp(data, EFI_VAR_FILE_NAME, sizeof(EFI_VAR_FILE_NAME))) {
-			data[len - 1] = 0;
-			efi_st_error("RTStorageVolatile = %s\n", data);
-			return EFI_ST_FAILURE;
-		}
+	len = sizeof(data);
+	ret = st_runtime->get_variable(u"RTStorageVolatile", &efi_rt_var_guid,
+				       &attr, &len, data);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		len = sizeof(data2);
-		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					       &attr, &len, data2);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("GetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		/*
-		 * VarToFile size must change once a variable is inserted
-		 * Store it now, we'll use it later
-		 */
-		prev_len = len;
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			sizeof(v2), v2);
-		/*
-		 * This will try to update VarToFile as well and must fail,
-		 * without changing or deleting VarToFile
-		 */
-		if (ret != EFI_OUT_OF_RESOURCES) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		len = sizeof(data2);
-		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					       &attr, &len, data2);
-		if (ret != EFI_SUCCESS || prev_len != len) {
-			efi_st_error("Get/SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	if (len != sizeof(EFI_VAR_FILE_NAME) ||
+	    memcmp(data, EFI_VAR_FILE_NAME, sizeof(EFI_VAR_FILE_NAME))) {
+		data[len - 1] = 0;
+		efi_st_error("RTStorageVolatile = %s\n", data);
+		return EFI_ST_FAILURE;
+	}
 
-		/* Add an 8byte aligned variable */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			sizeof(v), v);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	len = sizeof(data2);
+	ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+				       &attr, &len, data2);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	/*
+	 * VarToFile size must change once a variable is inserted
+	 * Store it now, we'll use it later
+	 */
+	prev_len = len;
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		sizeof(v2), v2);
+	/*
+	 * This will try to update VarToFile as well and must fail,
+	 * without changing or deleting VarToFile
+	 */
+	if (ret != EFI_OUT_OF_RESOURCES) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	len = sizeof(data2);
+	ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+				       &attr, &len, data2);
+	if (ret != EFI_SUCCESS || prev_len != len) {
+		efi_st_error("Get/SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/* Delete it by setting the attrs to 0 */
-		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0,
-					       sizeof(v), v);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Add an 8byte aligned variable */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		sizeof(v), v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/* Add it back */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			sizeof(v), v);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Delete it by setting the attrs to 0 */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0,
+				       sizeof(v), v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/* Delete it again by setting the size to 0 */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			0, NULL);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Add it back */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		sizeof(v), v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/* Delete it again and make sure it's not there */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			0, NULL);
-		if (ret != EFI_NOT_FOUND) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Delete it again by setting the size to 0 */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		0, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/*
-		 * Add a non-aligned variable
-		 * VarToFile updates must include efi_st_var0
-		 */
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			9, v + 4);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		var = efi_var_mem_find(&guid_vendor0, u"efi_st_var0", NULL);
-		if (!var) {
-			efi_st_error("GetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		delta = efi_var_entry_len(var);
-		len = sizeof(data2);
-		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					       &attr, &len, data2);
-		if (ret != EFI_SUCCESS || prev_len + delta != len) {
-			efi_st_error("Get/SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Delete it again and make sure it's not there */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		0, NULL);
+	if (ret != EFI_NOT_FOUND) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
 
-		/*
-		 * Append on an existing variable must update VarToFile
-		 * Our variable entries are 8-byte aligned.
-		 * Adding a single byte will fit on the existing space
-		 */
-		prev_len = len;
-		avail = efi_var_entry_len(var) -
-			(sizeof(u16) * (u16_strlen(var->name) + 1) +
-			 sizeof(*var)) -
-			var->length;
-		if (avail >= append_len)
-			delta = 0;
-		else
-			delta = ALIGN(append_len - avail, 8);
-		ret = st_runtime->set_variable(
-			u"efi_st_var0", &guid_vendor0,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_APPEND_WRITE |
-				EFI_VARIABLE_NON_VOLATILE,
-			append_len, v2);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		len = sizeof(data2);
-		ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
-					       &attr, &len, data2);
+	/*
+	 * Add a non-aligned variable
+	 * VarToFile updates must include efi_st_var0
+	 */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		9, v + 4);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	var = efi_var_mem_find(&guid_vendor0, u"efi_st_var0", NULL);
+	if (!var) {
+		efi_st_error("GetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	delta = efi_var_entry_len(var);
+	len = sizeof(data2);
+	ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+				       &attr, &len, data2);
+	if (ret != EFI_SUCCESS || prev_len + delta != len) {
+		efi_st_error("Get/SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/*
+	 * Append on an existing variable must update VarToFile
+	 * Our variable entries are 8-byte aligned.
+	 * Adding a single byte will fit on the existing space
+	 */
+	prev_len = len;
+	avail = efi_var_entry_len(var) -
+		(sizeof(u16) * (u16_strlen(var->name) + 1) +
+		 sizeof(*var)) -
+		var->length;
+	if (avail >= append_len)
+		delta = 0;
+	else
+		delta = ALIGN(append_len - avail, 8);
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_APPEND_WRITE |
+			EFI_VARIABLE_NON_VOLATILE,
+		append_len, v2);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	len = sizeof(data2);
+	ret = st_runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+				       &attr, &len, data2);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	if (prev_len + delta != len) {
+		efi_st_error("Unexpected VarToFile size");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Make sure that variable contains a valid file */
+	hdr = (struct efi_var_file *)data2;
+	if (hdr->magic != EFI_VAR_FILE_MAGIC || len != hdr->length ||
+	    hdr->crc32 != crc32(0,
+				(u8 *)((uintptr_t)data2 +
+				       sizeof(struct efi_var_file)),
+				len - sizeof(struct efi_var_file))) {
+		efi_st_error("VarToFile invalid header\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Variables that are BS, RT and volatile are RO after EBS */
+	ret = st_runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
+		EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			EFI_VARIABLE_RUNTIME_ACCESS |
+			EFI_VARIABLE_NON_VOLATILE,
+		sizeof(v), v);
+	if (ret != EFI_WRITE_PROTECTED) {
+		efi_st_error("Get/SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return check_runtime_variable_enumeration("runtime");
+}
+
+EFI_UNIT_TEST(variables_run) = {
+	.name = "variables at runtime",
+	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
+	.execute = execute,
+};
+#else
+/**
+ * execute_setup() - Prepare the non-volatile runtime-variable test state
+ *
+ * Create the persistent variable state consumed by execute_verify() after a
+ * reboot and make the reboot boundary explicit to the caller.
+ *
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
+ */
+static int execute_setup(void)
+{
+	efi_status_t ret;
+	efi_uintn_t len;
+	u32 attr = 0;
+	u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
+		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
+	u8 data[EFI_ST_MAX_DATA_SIZE];
+
+	/* Check if the setup variable already exists in non-volatile storage. */
+	len = sizeof(data);
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+				       &attr, &len, data);
+	if (ret == EFI_SUCCESS && len == sizeof(v) / 2 && !memcmp(data, v, len)) {
+		efi_st_printf("setup: efi_st_var0 ready, run verify\n");
+		return EFI_ST_SUCCESS;
+	}
+	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
+		/* Delete a stale variable before recreating the setup state. */
+		if (!attr)
+			attr = EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			       EFI_VARIABLE_RUNTIME_ACCESS |
+			       EFI_VARIABLE_NON_VOLATILE;
+		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					       attr, 0, NULL);
 		if (ret != EFI_SUCCESS) {
-			efi_st_error("GetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-		if (prev_len + delta != len) {
-			efi_st_error("Unexpected VarToFile size");
+			efi_st_error("setup: failed to delete stale efi_st_var0, status=%lx\n",
+				     (ulong)ret);
 			return EFI_ST_FAILURE;
 		}
+	} else if (ret != EFI_NOT_FOUND) {
+		efi_st_error("setup: failed to inspect existing efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
 
-		/* Make sure that variable contains a valid file */
-		hdr = (struct efi_var_file *)data2;
-		if (hdr->magic != EFI_VAR_FILE_MAGIC || len != hdr->length ||
-		    hdr->crc32 != crc32(0,
-					(u8 *)((uintptr_t)data2 +
-					       sizeof(struct efi_var_file)),
-					len - sizeof(struct efi_var_file))) {
-			efi_st_error("VarToFile invalid header\n");
-			return EFI_ST_FAILURE;
-		}
+	/* QueryVariableInfo */
+	if (check_runtime_query_variable_info("setup") != EFI_ST_SUCCESS)
+		return EFI_ST_FAILURE;
 
-		/* Variables that are BS, RT and volatile are RO after EBS */
-		ret = st_runtime->set_variable(
-			u"VarToFile", &efi_rt_var_guid,
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				EFI_VARIABLE_RUNTIME_ACCESS |
-				EFI_VARIABLE_NON_VOLATILE,
-			sizeof(v), v);
-		if (ret != EFI_WRITE_PROTECTED) {
-			efi_st_error("Get/SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
-	} else {
-		if (ret != EFI_UNSUPPORTED) {
-			efi_st_error("SetVariable failed\n");
-			return EFI_ST_FAILURE;
-		}
+	/* Create and delete a volatile runtime variable. */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS,
+				       3, v + 4);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("setup: failed to create volatile efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
 	}
-	len = EFI_ST_MAX_DATA_SIZE;
-	ret = st_runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
+
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS,
+				       0, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("setup: failed to delete volatile efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Create the non-volatile variable that verify expects after reboot. */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS |
+					       EFI_VARIABLE_NON_VOLATILE,
+				       sizeof(v) / 2, v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("setup: failed to create non-volatile efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Check variable enumeration while the setup variable is present. */
+	if (check_runtime_variable_enumeration("setup") != EFI_ST_SUCCESS) {
+		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+						       EFI_VARIABLE_RUNTIME_ACCESS |
+						       EFI_VARIABLE_NON_VOLATILE,
+					       0, NULL);
+		if (ret != EFI_SUCCESS)
+			efi_st_error("setup: enumeration failed and cleanup returned status=%lx\n",
+				     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	efi_st_printf("Reboot and run 'variables at runtime verify'\n");
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * execute_verify() - Verify the non-volatile runtime-variable test state
+ *
+ * Validate the state created by execute_setup(), append the remaining
+ * payload, confirm the full value, and remove the test variable.
+ *
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
+ */
+static int execute_verify(void)
+{
+	efi_status_t ret;
+	efi_uintn_t len, append_len;
+	u32 attr = 0;
+	u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
+		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
+	u8 data[EFI_ST_MAX_DATA_SIZE];
+
+	/* Validate the non-volatile variable created by setup. */
+	len = sizeof(v) / 2;
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
 				       &attr, &len, data);
+	if (ret == EFI_NOT_FOUND) {
+		efi_st_error("verify: efi_st_var0 missing, run setup first\n");
+		return EFI_ST_FAILURE;
+	}
 	if (ret != EFI_SUCCESS) {
-		efi_st_error("GetVariable failed\n");
+		efi_st_error("verify: failed to read prepared efi_st_var0, status=%lx\n",
+			     (ulong)ret);
 		return EFI_ST_FAILURE;
 	}
-	memset(&guid, 0, 16);
-	*varname = 0;
-	len = 2 * EFI_ST_MAX_VARNAME_SIZE;
-	ret = st_runtime->get_next_variable_name(&len, varname, &guid);
+	if (len != sizeof(v) / 2) {
+		efi_st_error("verify: unexpected prepared variable size=%lu\n",
+			     (ulong)len);
+		return EFI_ST_FAILURE;
+	}
+	if (memcmp(data, v, len)) {
+		efi_st_error("verify: prepared variable contents do not match setup payload\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Append the remaining payload. */
+	append_len = sizeof(v) - len;
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS |
+					       EFI_VARIABLE_APPEND_WRITE |
+					       EFI_VARIABLE_NON_VOLATILE,
+				       append_len, v + len);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("verify: failed to append remaining payload, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Validate the full variable contents after append. */
+	len = sizeof(v);
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+				       &attr, &len, data);
 	if (ret != EFI_SUCCESS) {
-		efi_st_error("GetNextVariableName failed\n");
+		efi_st_error("verify: failed to read appended efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+	if (len != sizeof(v)) {
+		efi_st_error("verify: unexpected appended variable size=%lu\n",
+			     (ulong)len);
+		return EFI_ST_FAILURE;
+	}
+	if (memcmp(data, v, len)) {
+		efi_st_error("verify: appended variable contents do not match expected payload\n");
 		return EFI_ST_FAILURE;
 	}
 
+	/* Delete the test variable. */
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_RUNTIME_ACCESS |
+					       EFI_VARIABLE_NON_VOLATILE,
+				       0, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("verify: failed to delete efi_st_var0, status=%lx\n",
+			     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Make sure the variable is no longer present. */
+	len = sizeof(data);
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+				       &attr, &len, data);
+	if (ret != EFI_NOT_FOUND) {
+		if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL)
+			efi_st_error("verify: efi_st_var0 still exists after delete\n");
+		else
+			efi_st_error("verify: failed to confirm deletion, status=%lx\n",
+				     (ulong)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	efi_st_printf("verify: runtime variable test passed\n");
+
 	return EFI_ST_SUCCESS;
 }
 
-EFI_UNIT_TEST(variables_run) = {
-	.name = "variables at runtime",
+EFI_UNIT_TEST(variables_run_setup) = {
+	.name = "variables at runtime setup",
 	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
-	.execute = execute,
+	.execute = execute_setup,
+	.on_request = true,
+};
+
+EFI_UNIT_TEST(variables_run_verify) = {
+	.name = "variables at runtime verify",
+	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
+	.execute = execute_verify,
+	.on_request = true,
 };
+#endif
-- 
2.34.1

