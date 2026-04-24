Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B185FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AC5844AF;
	Sat, 25 Apr 2026 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bc4DKhlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F18D840AB; Sat, 25 Apr 2026 19:01:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A749E84399
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6852335A7;
 Fri, 24 Apr 2026 10:32:43 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3089D3F7B4;
 Fri, 24 Apr 2026 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051968; bh=ohciqUgHTHvcL0AYdIA2fuLaaejikD+o8or3qyqI5GE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bc4DKhlpPSmp+lEAbf5eTLwAbk2YoiGhIK2/q7KxBFw44JTAHnlHVhAtCNg1DwpFz
 a8AbM0ckFE00SChI5K56I7H02FQoMidxS2gYMgqqGsj+rxSs7Iz3g5cvpEnISsmyQa
 FlOFXq9HqCOWbn6ZCTav6FUzVMFBkvkp7qFl/zfA=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 07/12] efi: selftest: add runtime variable tests with
 non-volatile storage
Date: Fri, 24 Apr 2026 18:31:46 +0100
Message-Id: <20260424173151.371134-8-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Previously, EFI selftesting of runtime variables was only supported
under CONFIG_EFI_RT_VOLATILE_STORE, which uses VarToFile to simulate
non-volatile variable storage. This commit adds new test cases that
exercise runtime variable operations for persistent storage.

Features tested:
- Creation of runtime-accessible variables (set)
- Retrieval of runtime variables (get)
- Deletion using SetVariable() with size = 0
- Append operation using EFI_VARIABLE_APPEND_WRITE

This improves EFI compliance validation for non-volatile runtime storage
scenarios and ensures proper attribute enforcement and variable
management.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 .../efi_selftest_variables_runtime.c          | 106 +++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index fd570d673f0..9a7ab18bc90 100644
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
@@ -22,7 +23,13 @@ static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
 /**
  * execute() - execute unit test
  *
- * As runtime support is not implmented expect EFI_UNSUPPORTED to be returned.
+ * For EFI variables in non-volatile storage, these tests have to be executed in two phases
+ * 1. During first phase, run these tests and it creates EFI variable in persistent storage.
+ * 2. Then reboot and run the test again to verify if the variable created above is still
+ *    available in non-volatile storage. If available, validate the EFI variable, append
+ *    it, and validate it again. If validation is successful, delete the same variable.
+ *
+ * Return: EFI_ST_SUCCESS on success, EFI_ST_FAILURE on failure
  */
 static int execute(void)
 {
@@ -39,6 +46,80 @@ static int execute(void)
 	u64 max_storage, rem_storage, max_size;
 	int test_ret;
 
+	/* Compare the value of EFI variable if it already exists in non volatile storage */
+	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		len = sizeof(v) / 2;
+		ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+				&attr, &len, data);
+		if (ret == EFI_SUCCESS) {
+			efi_st_printf("EFI Variable efi_st_var0 found. Executing Second Phase\n");
+			if (len != sizeof(v) / 2) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+			if (memcmp(data, v, len)) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			/* Append an existing variable */
+			append_len = sizeof(v) - len;
+			ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+						    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+						    EFI_VARIABLE_RUNTIME_ACCESS |
+						    EFI_VARIABLE_APPEND_WRITE |
+						    EFI_VARIABLE_NON_VOLATILE,
+						    append_len, (v + len));
+			if (ret != EFI_SUCCESS) {
+				efi_st_error("SetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			len = sizeof(v);
+			ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+					&attr, &len, data);
+			if (ret != EFI_SUCCESS) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			if (len != sizeof(v)) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			if (memcmp(data, v, len)) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			/* Delete it by setting the size to 0 */
+			ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+						    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+						    EFI_VARIABLE_RUNTIME_ACCESS |
+						    EFI_VARIABLE_NON_VOLATILE,
+						    0, NULL);
+			if (ret != EFI_SUCCESS) {
+				efi_st_error("SetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0,
+					&attr, &len, data);
+			if (ret != EFI_NOT_FOUND) {
+				efi_st_error("GetVariable failed\n");
+				return EFI_ST_FAILURE;
+			}
+
+			return EFI_ST_SUCCESS;
+		} else {
+			if (ret == EFI_NOT_FOUND) {
+				efi_st_printf("EFI Variable efi_st_var0 not found. "
+					"Executing First Phase\n");
+			}
+		}
+	}
+
 	memset(v2, 0x1, sizeof(v2));
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
@@ -279,7 +360,28 @@ static int execute(void)
 			return EFI_ST_FAILURE;
 		}
 	} else {
-		if (ret != EFI_UNSUPPORTED) {
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Delete it by setting the size to 0 */
+		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS,
+					    0, NULL);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Add an 8byte aligned variable */
+		ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v) / 2, v);
+		if (ret != EFI_SUCCESS) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
-- 
2.34.1

