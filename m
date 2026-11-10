Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357F606BFD0
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nyLti+cb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bscYUHru
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FB4881343;
	Tue, 10 Nov 2026 13:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QS3IjOS6izf3; Tue, 10 Nov 2026 13:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2889816D5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316017;
	b=ruJIH23aSpDcd9N3qQJeOPlgOlHhlBuWZ+u4LW5pzZ8n83/jQKFbDCcZPtnIObxB6CLM
	 ifSYfM40EIfoNkNhEcH9KXypw9zVRZozP1SbKWuumUTSZ2B4T1S+R0a9JktWZ5Tce4jQG
	 mqVT1nO4bUFo5EjojXZN5KujAwe9EnkMA5t2TDEKe8vMmDvOyTWs5AFe8v3Ncke/PVG/B
	 MivsXwwbhIyGboU3U/p5aUCH24SLdIQCbD+wzZbiQLhoNP5SFEb5hCU2w5PhrRzRrl/e5
	 +VyPeRENpEwDjZ8x93tZQdAKDt57gOffeWWyVpfdKVCh73Z/BeaGR9Ov4EZP83WTHjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lh64/kC0+Ql+1YDnxknhrOs9678r+yKX4orCJs7R9gw=;
	b=WmDJEwJxxoAIVoimU232CFdkkbam4amNXf1Vy1GaI2kKF3pi9dA5u8CLSt8DmczxGUHN
	 UpQ8Y4ZgDt2B6Iju1aMyVnuaUfDwBUPrcCOQqd9kPma10WRpjeXHyri5ckaiqlk6Uniz+
	 B9mPV/nvNnLubb3qYT4oSBXJLpluq0EXpFiwZR/5M9Lw2DuuOO6BR8xkPI12mhcW+r0tk
	 katXFI4PWsh90p8OA+QsPcL5xkBLs6+sHg6JNwb0llqOsdA7Zf/jOrtTKfHIfgKHaeKIF
	 SwAfciPRejRmujUBTdq9lbBeZ7iggChbkome3yzETyQDmOm3xALQcXx9OCt7pm8BoDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316017;
	bh=lh64/kC0+Ql+1YDnxknhrOs9678r+yKX4orCJs7R9gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nyLti+cb/RgahU2wHtI/GeGHXwttip08BehQnuUWAQ0bzC1kfL2EggCIJG/3tfF8R
	 aoKJdrhGoYtCOW2yFVLgQJFm1FCxD4zOOrDjlqRkqlvOLz7beVfG+Aul9/g6UdAURT
	 6v88myVfZxk0VVfgEe9Ujvony1IttiyU9/H4utdsiQt4coPdOca1dQXTA2QwQDUUqQ
	 n+0mllt6YOwd2BP7Y5S2PwTnajzT9SBHI7rwk9xaDPzSqA3+5UptVl8qSEqRhz9qrJ
	 m2yrhISWO7Um/IhU2NNo0xZCu2Kw75vFY2hz08RcLfho+vHhkROHftEyu8kmltURHl
	 X+gPVXaQucnqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2889816D5;
	Tue, 10 Nov 2026 13:06:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26C1C731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24721407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTWETshujSRj for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BDD1407F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=bscYUHru
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BDD1407F9
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C5BE1EDB;
 Tue, 10 Nov 2026 01:58:37 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EEEC3F632;
 Tue, 10 Nov 2026 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304720; bh=WXuno1AOIGDg6wRq2jBJe8V1s1guTnZUxC7gE5seVCE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bscYUHruhe+WAks5BK1/cSzhxpAYrksKGZoEjTst4AgjFnqlSq4ZocK0xEzW5BHme
 u47E3RVcdKsdVA2PS2CRPLaoVjZEXqwjpCtJ/5GKDjqx3/vjOcZbBPFCv/xOYB0cTy
 j0xZ327MZmCc16+/xNVVkAJ3hFHCN9iH+1AczbxA=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 19/22] efi: selftest: add runtime variable tests with
 non-volatile storage
Date: Tue, 10 Nov 2026 09:58:00 +0000
Message-ID: <9bb8c3148cccec9761a1f69adba7d269883eb088.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

- Fix the expected QueryVariableInfo() return status for the TEE-backed runtime path

v2:

Simon:

- Split the non-volatile flow into setup and verify tests
- Keep the single-run test only for volatile-store builds
- Reuse shared QueryVariableInfo and enumeration helpers
- Make setup and verify logs stage-specific
---
 .../efi_selftest_variables_runtime.c          | 715 ++++++++++++------
 1 file changed, 482 insertions(+), 233 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index fd570d673f0..90ec568ca3a 100644
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
@@ -17,294 +18,542 @@
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
 		ret = st_runtime->query_variable_info(
 			EFI_VARIABLE_BOOTSERVICE_ACCESS, &max_storage,
 			&rem_storage, &max_size);
-		if (ret != EFI_UNSUPPORTED) {
-			efi_st_error("QueryVariableInfo failed\n");
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("%s: QueryVariableInfo returned status=%x\n",
+				     phase, (u32)ret);
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
2.43.0

