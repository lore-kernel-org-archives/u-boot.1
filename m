Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E99C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 321E5810AF;
	Wed, 14 Oct 2026 20:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cGyIDLFYMkBe; Wed, 14 Oct 2026 20:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BEB58114B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008237;
	b=Fx+I1s+6Mu1QOXNU4ypodY8Q6hEniNP2ToyJ/rjk5hZOW0QEJyGNmVTCE4yV/5d+LLPd
	 uUptKk97pdIxTxR+xSsCNTIwGonE5/myfzdjCXFBYbA3TqplmaZq6+5tN97+lr4wtgS9R
	 pErPs4j7HHmA0aTf257Sw5JIFdIFmWqVIgc+QkiKW+QhqPly5D5O0vh2odOGzO+ROCTyX
	 YKn/mnK3/U5DHuw98JLgJGtHHAPGXsiCDXhVxFI0cB+M7+zFpTx2CL3sw7lPopOuPAqq5
	 YsZsKaNVRJ3sClLksRPItfuRYDrBRi+lOAekN4DO3JV0t95AtkLZtskRXGufwVQE8Bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lh64/kC0+Ql+1YDnxknhrOs9678r+yKX4orCJs7R9gw=;
	b=W9hVnJ1Ju6nxZxahEUjog1UobRFzqnJLkVlYeqKtsWEZiYv8qnKicejkIeUFT5dSu3lN
	 7NW1OOJulB58DeErN4F9DV6IkoHsFrFgLPY8wjdyLyDoddLDOBu5AI4oCAbkV0fVh1iSX
	 qmO2OJ74q3motU/FmQKUqU9bTAZrKERnx2s+PqAeaAp5BLFm0ECNeMc01GpP4jb/SdF97
	 HIdJWWg23XBp0dvwM/HOtchDgez2lNI8jqeCsZGHAsvV5jcdwZtjQfkmcOE7l2h9haYVk
	 6V0hGbe8Q6KQs9xdJiQsAn0yPkptu8DHJeCMKt6ca/v223K3enuT9/EWRTn5XZEf0fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008237;
	bh=lh64/kC0+Ql+1YDnxknhrOs9678r+yKX4orCJs7R9gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsR11manhOQ4+bQLQwPL+7Iwg8+12XlS8k0ADFAjS/Zk6/WRFkVjNonZ5H4GiGaFO
	 oUP343kX60dfOPJvvepXK+ijEYZkTSkV7kY12N+ULwvMblyTxwvmu5/2unDGzpI7h+
	 H4a5ToSEIDynapb/u/ksGzohO28Cvo3tZ4FVX5zILsFIESCcn2gl34RvFdcq2UAzCn
	 pLGdB214uGCE9caNBSHBDXdwHMmPAtDw14CBAneWJ/G5fNhg8DRBYTZOutdzSyWFvI
	 OspQaKGejXRjjlMvUGuT/jprXlp4NDBJzJzwAcoj+BjYLDZlN04lX7C+RJI8VPWfGd
	 ww3+aYqFp8Y3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BEB58114B;
	Wed, 14 Oct 2026 20:03:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9449E2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8594760849
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZuEgk9ltJTw for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E5579607CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002223;
 b=iQzQp/xWtMF2nnVihSOlxpos5I7HPD7uB9NDU5AgoZrL40LcQdRdlWQYWsdOvDjqu+xa
 4RsdFKnIEZCgeccYRlX6xKBYakaHEW8it7zmqgIMQ8HgiVA1yxirDUfu/qKGzTg0VX88G
 E5/nvwQT2ws7hIRdATbmi6i2z0PNen0+nKQjC9l5TIoQDBkRrA2JegkbZ/cpAjGYR/PNz
 TOXDgoPuTTEEVdOZqLURNSkQTEpRiy9DapSeH8b2LGanbJ2o/j4gwiW0HFY+SaWFKdZ5F
 iahHSExWowUsCFSGbYnDZriSm2zygAE69dfocV2QI1YuUFaFwUqrgPHx38SjCjU4IsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002223;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lh64/kC0+Ql+1YDnxknhrOs9678r+yKX4orCJs7R9gw=;
 b=cOjoxGfb/NbNbps72XmLLGdPRjFDls2OIfhyv8KjMK1QCBWXA/K7rLeJGLtrEyeus6zQ
 EVZvUPRoMurLR0l43mljlOCb6ncvlcyCo2ipKxwKGfnbPAjpvvMrqK2ILEuByGA5Rodjo
 SgBwbj62z0XTNFsUWmnuYkDGyVJdF+eC5ODPKDgX+wqTb9d2J3bvc+3LJCJYyI/LXYzK5
 kqfS+c8R440zp+uFWD6DTereGw4ZTm793v3PJt647mTXVQfNdLqL+rwkIyGJhEn2ntvbz
 JfTSSJraRdZW8akz/vieArfDC0aw6uI1OB54eOsMCMt9O62x+qArtp6nfvdcBAoYF+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=nO69Hwex; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=nO69Hwex
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5579607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210ED152B;
 Wed, 14 Oct 2026 11:23:39 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB0E3F871;
 Wed, 14 Oct 2026 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002222; bh=WXuno1AOIGDg6wRq2jBJe8V1s1guTnZUxC7gE5seVCE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nO69HwexsosW2vnAGuchiLwe/k4gCXo775WEa4ncOfA9t6gmHEPx9kATTwmk57XeR
 y7OxShNzOyam+bZbvhYfB/OZJ57ka0719iHTeycNpoc/LEtLcr2+jsDPUHoR6TtvME
 5ZnrrPuSITgjT+61mmD6HglSD4pCErITji0xKqvs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 19/22] efi: selftest: add runtime variable tests with
 non-volatile storage
Date: Wed, 14 Oct 2026 19:22:59 +0100
Message-ID: <a13cf79e54e2ee82303a1e4821d0f3e0189d245e.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

