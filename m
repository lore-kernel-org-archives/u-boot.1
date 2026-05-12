Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADD2CD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168118465A;
	Tue, 12 May 2026 19:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jfS0ctZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D765C84659; Tue, 12 May 2026 19:41:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1E087845C8
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 224C51684;
 Tue, 12 May 2026 10:40:52 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.18.174])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242BB3F85F;
 Tue, 12 May 2026 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778607657; bh=XigH/rN82g/pjrIX5hnzOhf0/6SW163yF6oXxuSuypU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jfS0ctZVxSHa3mzdsNRogpApvJV+kgAzrvTgn4CSu3nGGQoEoN6pIQhbiCs8PwNB9
 w5yOds4P5uXE7EwnsN5oHlhjwwmCuE7ty/VjLDzySkAGzXkj6dIfCcuMVxw4+MB8gH
 Js84eHQJkMXLKfFZAklgkoWTPsapt6CIbl2tENtg=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 12 May 2026 19:40:34 +0200
Subject: [PATCH 2/2] efi_selftest: test hii keyboard layouts more
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260512-layout-pointer-v1-2-c0981e907274@arm.com>
References: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
In-Reply-To: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
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

The HII database test for keyboard layouts register two package lists with
two keyboard layouts each, but the test verifies only the GUID of the first
keyboard layout.
This does not catch the bugs happening with the keyboard layouts after the
first one in a package.

Verify all the keyboard layout GUIDs in the unit test to prevent this.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_hii.c      | 67 ++++++++++++++++++--------------
 lib/efi_selftest/efi_selftest_hii_data.c | 12 ++++++
 2 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
index 228dc296950..fdbb08fb417 100644
--- a/lib/efi_selftest/efi_selftest_hii.c
+++ b/lib/efi_selftest/efi_selftest_hii.c
@@ -452,8 +452,7 @@ out:
  * test_hii_database_get_keyboard_layout() - test retrieval of keyboard layout
  *
  * This test adds two package lists, each of which has two keyboard layouts
- * and then tries to get a handle to keyboard layout with a specific guid
- * and the current one.
+ * and then tries to get a handle to every keyboard layout and the current one.
  *
  * @Return:     status code
  */
@@ -463,7 +462,11 @@ static int test_hii_database_get_keyboard_layout(void)
 	struct efi_hii_keyboard_layout *kb_layout;
 	u16 kb_layout_size;
 	efi_status_t ret;
-	int result = EFI_ST_FAILURE;
+	int result = EFI_ST_FAILURE, i;
+	static efi_guid_t *const kb_layout_guids[] = {
+		&kb_layout_guid11, &kb_layout_guid12,
+		&kb_layout_guid21, &kb_layout_guid22
+	};
 
 	PRINT_TESTNAME;
 	ret = hii_database_protocol->new_package_list(hii_database_protocol,
@@ -484,33 +487,37 @@ static int test_hii_database_get_keyboard_layout(void)
 		goto out;
 	}
 
-	/* specific keyboard_layout(guid11) */
-	kb_layout = NULL;
-	kb_layout_size = 0;
-	ret = hii_database_protocol->get_keyboard_layout(hii_database_protocol,
-			&kb_layout_guid11, &kb_layout_size, kb_layout);
-	if (ret != EFI_BUFFER_TOO_SMALL) {
-		efi_st_error("get_keyboard_layout returned %u\n",
-			     (unsigned int)ret);
-		goto out;
-	}
-	ret = boottime->allocate_pool(EFI_LOADER_DATA, kb_layout_size,
-				      (void **)&kb_layout);
-	if (ret != EFI_SUCCESS) {
-		efi_st_error("AllocatePool failed\n");
-		goto out;
-	}
-	ret = hii_database_protocol->get_keyboard_layout(hii_database_protocol,
-			&kb_layout_guid11, &kb_layout_size, kb_layout);
-	if (ret != EFI_SUCCESS) {
-		efi_st_error("get_keyboard_layout returned %u\n",
-			     (unsigned int)ret);
-		goto out;
-	}
-	ret = boottime->free_pool(kb_layout);
-	if (ret != EFI_SUCCESS) {
-		efi_st_error("FreePool failed\n");
-		goto out;
+	/* Verify all keyboard layouts */
+	for (i = 0; i < ARRAY_SIZE(kb_layout_guids); i++) {
+		efi_guid_t *kb_layout_guid = kb_layout_guids[i];
+
+		kb_layout = NULL;
+		kb_layout_size = 0;
+		ret = hii_database_protocol->get_keyboard_layout(hii_database_protocol,
+				kb_layout_guid, &kb_layout_size, kb_layout);
+		if (ret != EFI_BUFFER_TOO_SMALL) {
+			efi_st_error("get_keyboard_layout returned %u\n",
+				     (unsigned int)ret);
+			goto out;
+		}
+		ret = boottime->allocate_pool(EFI_LOADER_DATA, kb_layout_size,
+					      (void **)&kb_layout);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("AllocatePool failed\n");
+			goto out;
+		}
+		ret = hii_database_protocol->get_keyboard_layout(hii_database_protocol,
+				kb_layout_guid, &kb_layout_size, kb_layout);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("get_keyboard_layout returned %u\n",
+				     (unsigned int)ret);
+			goto out;
+		}
+		ret = boottime->free_pool(kb_layout);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool failed\n");
+			goto out;
+		}
 	}
 
 	/* current */
diff --git a/lib/efi_selftest/efi_selftest_hii_data.c b/lib/efi_selftest/efi_selftest_hii_data.c
index 5fc890112b4..2d29bb045d3 100644
--- a/lib/efi_selftest/efi_selftest_hii_data.c
+++ b/lib/efi_selftest/efi_selftest_hii_data.c
@@ -428,6 +428,18 @@ static efi_guid_t kb_layout_guid11 =
 	EFI_GUID(0x8d40e495, 0xe2aa, 0x4c6f,
 		 0x89, 0x70, 0x68, 0x85, 0x09, 0xee, 0xc7, 0xd2);
 
+static efi_guid_t kb_layout_guid12 =
+	EFI_GUID(0x2ae60b3e, 0xb9d6, 0x49d8,
+		 0x9a, 0x16, 0xc2, 0x48, 0xf1, 0xeb, 0xa8, 0xdb);
+
+static efi_guid_t kb_layout_guid21 =
+	EFI_GUID(0xe0f56a1f, 0xdf6b, 0x4a7e,
+		 0xa3, 0x9a, 0xe7, 0xa5, 0x19, 0x15, 0x45, 0xd6);
+
+static efi_guid_t kb_layout_guid22 =
+	EFI_GUID(0x47be6ac9, 0x54cc, 0x46f9,
+		 0xa2, 0x62, 0xd5, 0x3b, 0x25, 0x6a, 0x0c, 0x34);
+
 static efi_guid_t package_guid =
 	EFI_GUID(0x0387c95a, 0xd703, 0x2346,
 		 0xb2, 0xab, 0xd0, 0xc7, 0xdd, 0x90, 0x44, 0xf8);

-- 
2.53.0

