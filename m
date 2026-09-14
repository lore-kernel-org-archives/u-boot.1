Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CAEC88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B15281000;
	Mon, 14 Sep 2026 14:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sibKbuX-TZK; Mon, 14 Sep 2026 14:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C37AA80C8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395483;
	b=oktQgLybcceSCjaUpV5mi9aG6bqrAc/HJdcxzEzVFsLEEIDZqg4Xgw59dtGcuWLUIkN6
	 72ydXmL9Dl7jsvvd1mjjUYtom4cn2gWG0o1TQCqQ3SYlDEcyKfSN8Z/SHYTWEbxWh275K
	 OjbHdL0FPndqSLyp+fqkL+w0peoF9qxfFGRCbKCkdMcwZ2d3MfHMhbnN/AjHUfDqwjgJR
	 H6jQIxr7cJtyUx8xmbtkeFyUV98mshm0fqEuQjiA0+OgPtSi5PHOZC2X1hZsSjhMvugDW
	 9Yms1ympzIYqLbiK+tAEYcstYfc+zkdAMsqEXY547B7f8YLBbGg9yc5eV8K3cehEiaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sOKXBOO9rkyBnMV/DC2d6lq6qXhg1dpaNFufC32WspM=;
	b=T+wwkQq/zimIgaaVcy+Fen1AE7kUoHPjDEgEPIdF9a8odxBZpWcIeFqNN46YQRVtoN+a
	 oh08NtaJK1DbUNKtUZifRHwt8ez3BlplfZfTljYOxW5s6dq/d/wfNzPiz2NC36TYBkmVr
	 g8jG/ZGkWWkUM0YcFS46fcw/8PA+5MAxrIiMMq7sfovMot/Y/sStfk4BB376+jE0Mt/3H
	 Tim71pD704vN2bbWbmKyyfZwWnsk+lSDtpb4PGRmulWCyK+hS6j0IjuseV/6nOkPw2j1x
	 QdZd+nCgsZIna+A5F3XB5sJX+HF+zemQdCyLbQyngdJBxtrtTUP9EYHY4vmc02ln+nQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395483;
	bh=sOKXBOO9rkyBnMV/DC2d6lq6qXhg1dpaNFufC32WspM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vogNrwkBZ/pCzw6inqQq7anNdAL+dXxCT5IeGgGo+qWDVNwWuhPfJVqCkjWHFaj/7
	 3c4vicdyuz7McDG9C3MCazGIV3OzcltXRvoB0uPAVuCDe2HA9Z8cNh1nTqzcVk7lUP
	 1IP7qWTWja9iVaQu3OI3vQ20i2PuJ4d0PXcxJ58wnXeVyMRkJg9SpvzpEA0KpeBGmF
	 ktAJu5x+JgfA/IMSewO98u0+UlMQfkEOu/NNovZhBa+Y4GkR7cazgoqs3qWznMza1X
	 +H0CgUdcCUcX1Do6BjfqS3J2WefIY1cHEa9fgqVkb7AoQMRuuGTOjjTCPiiwHgf2/Y
	 XxFVC/QIy68yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C37AA80C8B;
	Mon, 14 Sep 2026 14:18:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 081FD493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE118605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGDe6PQU1e38 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C5A060689
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=XcEVtvcwU/yW1SomlCa0RF1gWmJFGyCRwijBJBo4z58fsut6wvefNnuc/mCP+iL/4IE9
 CWbR/GiLcDWPsciy2JTCQHEDerTdBVfIVxi34bF6tXrMz8Yzcgh9igJAzrW680hwaqXtQ
 WaNzrRA7+vfDLPddOGIuSxvxV9ltXPgWXcUgguwFtEux45E1Eaau29JrELKDYCNzNd+1R
 0G+ho22tenhnO2wccipf3aPEW7u6YXBx0cPrk8UlTAu6u+3sWg7YoTLg5BSAFxM+CO9Dk
 ugLkloEXSBlwonceSjXajR9AGA6SplQciZ/FRX+U+I4000C5dP7BOuSztlvaDBMXbvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sOKXBOO9rkyBnMV/DC2d6lq6qXhg1dpaNFufC32WspM=;
 b=R2o8ad9VBp16vm54KVrDNF9Wf+buPsdemFUAZoCM0f3v7PT5pC6wfLJibbl5IPIM9JWr
 4MhLoIatKDpfscDtOnmyufoGhArugGdvs0tocVRvE/cQDeLLfVl6Qz9H13oqliJTifsUx
 x1Q7FowPJ732gxFK/aiuUnb+mlUH7MG3h7+2IK+t0dqkiUV94HHkPKToPddIlaKeF/sQE
 FM1C8e9FEIbiVkEiUfX6bVn7xMyNbgsDGnQZfFPfTvsT7Otm4WCCaObY8O0nprmys5vPM
 KQSlXTUBbM1dAma+1N0npg61Oabc53dJB1FOsJb66jRb2aRGZvaHdhx51sRhgTYPKUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=syfJ4n0S; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=syfJ4n0S
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C5A060689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B6B52880;
 Mon, 14 Sep 2026 04:01:58 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BBBB3F86F;
 Mon, 14 Sep 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383722; bh=2U+j//UuO76VRkUzXSdfTy4v8khUQoEFwevzjOJM0Hw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=syfJ4n0SyT3/u7Or8M6/HbkdHvVAF3YTkYf5XmHAuKZYY5Jp/KLD1TBBm6rR85Wr8
 NpU4onCuGtAoLOYJqq5BFvsAY2+A54pkDt0j8v9hvri7ghOUZz1jXJEoHbo2q4wm4t
 Miqd5fVjWNov20mpJ9Bs0U/xdDh9GouYv33xnG0o=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 19/22] efi: selftest: add runtime variable tests with
 non-volatile storage
Date: Mon, 14 Sep 2026 12:01:03 +0100
Message-Id: <20260914110106.1974894-20-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
2.34.1

