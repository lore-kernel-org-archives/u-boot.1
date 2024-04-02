Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9A7CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD1B88365;
	Tue,  2 Apr 2024 11:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA2A88368; Tue,  2 Apr 2024 11:09:40 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id BF7A087FDA
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 02 Apr 2024 18:09:33 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E2FE520584CE;
 Tue,  2 Apr 2024 18:09:33 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Tue, 2 Apr 2024 18:09:33 +0900
Received: from ubuntu-FMVS04001.e01.socionext.com (unknown [10.213.110.223])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 89039B62AB;
 Tue,  2 Apr 2024 18:09:33 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2] efi_loader: fix append write behavior to non-existent
 variable
Date: Tue,  2 Apr 2024 18:09:50 +0900
Message-Id: <20240402090950.3819705-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.34.1
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

Current "variables" efi_selftest result is inconsistent
between the U-Boot file storage and the tee-based StandaloneMM
RPMB secure storage.

U-Boot file storage implementation does not accept SetVariale
call to non-existent variable with EFI_VARIABLE_APPEND_WRITE,
it return EFI_NOT_FOUND.
However it is accepted and new variable is created in EDK II
StandaloneMM implementation if valid data and size are specified.
If data size is 0, EFI_SUCCESS is returned.

Since UEFI specification does not clearly describe the behavior
of the append write to non-existent variable, let's update
the U-Boot file storage implementation to get aligned with
the EDK II reference implementation.

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
v1 -> v2
- return EFI_SUCCESS for append write with data size 0
- add comment that we follow the EDK II implementation

 lib/efi_loader/efi_variable.c             | 26 +++++++++---
 lib/efi_selftest/efi_selftest_variables.c | 48 ++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 40f7a0fb10..d1db7ade0a 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -282,11 +282,21 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		}
 		time = var->time;
 	} else {
-		if (delete || append)
-			/*
-			 * Trying to delete or to update a non-existent
-			 * variable.
-			 */
+		/*
+		 * UEFI specification does not clearly describe the expected
+		 * behavior of append write with data size 0, we follow
+		 * the EDK II reference implementation.
+		 */
+		if (append && !data_size)
+			return EFI_SUCCESS;
+
+		/*
+		 * EFI_VARIABLE_APPEND_WRITE to non-existent variable is accepted
+		 * and new variable is created in EDK II reference implementation.
+		 * We follow it and only check the deletion here.
+		 */
+		if (delete)
+			/* Trying to delete a non-existent variable. */
 			return EFI_NOT_FOUND;
 	}
 
@@ -329,7 +339,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		/* EFI_NOT_FOUND has been handled before */
 		attributes = var->attr;
 		ret = EFI_SUCCESS;
-	} else if (append) {
+	} else if (append && var) {
+		/*
+		 * data is appended if EFI_VARIABLE_APPEND_WRITE is set and
+		 * variable exists.
+		 */
 		u16 *old_data = var->name;
 
 		for (; *old_data; ++old_data)
diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index c7a3fdbaa6..39ad03a090 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -131,13 +131,57 @@ static int execute(void)
 			    (unsigned int)len);
 	if (memcmp(data, v, len))
 		efi_st_todo("GetVariable returned wrong value\n");
-	/* Append variable 2 */
+
+	/* Append variable 2, write to non-existent variable with datasize=0 */
+	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
+				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				    EFI_VARIABLE_APPEND_WRITE,
+				    0, v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error(
+			"SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
+		return EFI_ST_FAILURE;
+	}
+	len = EFI_ST_MAX_DATA_SIZE;
+	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
+				    &attr, &len, data);
+	if (ret != EFI_NOT_FOUND) {
+		efi_st_error("Variable must not be created\n");
+		return EFI_ST_FAILURE;
+	}
+	/* Append variable 2, write to non-existent variable with valid data size*/
 	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
 				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
 				    EFI_VARIABLE_APPEND_WRITE,
 				    15, v);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
+		return EFI_ST_FAILURE;
+	}
+	len = EFI_ST_MAX_DATA_SIZE;
+	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
+				    &attr, &len, data);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	if (len != 15)
+		efi_st_todo("GetVariable returned wrong length %u\n",
+			    (unsigned int)len);
+	if (memcmp(data, v, len))
+		efi_st_todo("GetVariable returned wrong value\n");
+	/* Delete variable efi_none */
+	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
+				    0, 0, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("SetVariable failed\n");
+		return EFI_ST_FAILURE;
+	}
+	len = EFI_ST_MAX_DATA_SIZE;
+	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
+				    &attr, &len, data);
 	if (ret != EFI_NOT_FOUND) {
-		efi_st_error("SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
+		efi_st_error("Variable was not deleted\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Enumerate variables */
-- 
2.34.1

