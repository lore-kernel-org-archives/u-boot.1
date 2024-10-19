Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E11D3C902
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 09:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699A288DD0;
	Sat, 19 Oct 2024 11:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dRgr+yXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7FE88E81; Sat, 19 Oct 2024 11:04:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB0488B23
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 11:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-156.46.114.pool.telefonica.de
 [46.114.105.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8FFBD3F0AB; 
 Sat, 19 Oct 2024 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729328641;
 bh=FDd3UxAXjcJNec0PfANkS81WIn1U3Z9KnQPJ/CbWcBE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dRgr+yXex+FtIDRWU3ujnSToHtWPOCrR/JpOTv3dkvwLGTAMXoQ5r8rW++6iAKN2B
 YTWHqLe+OOhnxSd/nSFzIIX4vPbEuPcDeTA0HnOok2DdIgBrrG7lVyOKYD9q/ykD6X
 76FZD65HjHQIsW9udL2ZGShyGXoN7xwwpt4NiuGwSq3ZzAMwUelIjS4H6fWzf6LVEa
 dqXEWjBhNRYpKuq/9XiSxs0HP+CN6nWcEE4FEe1B4ViFAH1sB49Jk9n0sPz62ou64T
 BJMkkDZA1B8DMqoa8GUKOwika1DYwno5EhKgc0tJjT/wkOZD+F5qCLKdOk5/+k9TJ8
 2GUlU91mXhgrg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: make HII test data static
Date: Sat, 19 Oct 2024 11:03:56 +0200
Message-ID: <20241019090356.25288-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Variables that are only used locally in a module should not be exported.

* Make the HII test data variables static.
* Remove unused GUIDs.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_hii_data.c | 28 ++++--------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_hii_data.c b/lib/efi_selftest/efi_selftest_hii_data.c
index d19f0682afd..5fc890112b4 100644
--- a/lib/efi_selftest/efi_selftest_hii_data.c
+++ b/lib/efi_selftest/efi_selftest_hii_data.c
@@ -39,7 +39,7 @@
 /* HII keyboard layout */
 #define EFI_NULL_MODIFIER		0x0000
 
-u8 packagelist1[] = {
+static u8 packagelist1[] = {
 	// EFI_HII_PACKAGE_LIST_HEADER, length = 20
 	// SimpleFont, Font, GUID, Form, String, Image, DevicePath,
 	// (74)        (110) 20    (8)   78      (67)   (8)
@@ -262,7 +262,7 @@ u8 packagelist1[] = {
 	EFI_HII_PACKAGE_END
 };
 
-u8 packagelist2[] = {
+static u8 packagelist2[] = {
 	// EFI_HII_PACKAGE_LIST_HEADER, length = 20
 	// SimpleFont, Font, GUID, KeyboardLayout, Form, End
 	// (74)        (122) 20    192             (8)   4
@@ -424,30 +424,10 @@ u8 packagelist2[] = {
 	EFI_HII_PACKAGE_END			// 1
 };
 
-efi_guid_t packagelist_guid1 =
-	EFI_GUID(0x03abcd89, 0x03f4, 0x7044,
-		 0x81, 0xde, 0x99, 0xb1, 0x81, 0x20, 0xf7, 0x68);
-
-efi_guid_t packagelist_guid2 =
-	EFI_GUID(0x8685ded3, 0x1bce, 0x43f3,
-		 0xa2, 0x0c, 0xa3, 0x06, 0xec, 0x69, 0x72, 0xdd);
-
-efi_guid_t kb_layout_guid11 =
+static efi_guid_t kb_layout_guid11 =
 	EFI_GUID(0x8d40e495, 0xe2aa, 0x4c6f,
 		 0x89, 0x70, 0x68, 0x85, 0x09, 0xee, 0xc7, 0xd2);
 
-efi_guid_t kb_layout_guid12 =
-	EFI_GUID(0x2ae60b3e, 0xb9d6, 0x49d8,
-		 0x9a, 0x16, 0xc2, 0x48, 0xf1, 0xeb, 0xa8, 0xdb);
-
-efi_guid_t kb_layout_guid21 =
-	EFI_GUID(0xe0f56a1f, 0xdf6b, 0x4a7e,
-		 0xa3, 0x9a, 0xe7, 0xa5, 0x19, 0x15, 0x45, 0xd6);
-
-efi_guid_t kb_layout_guid22 =
-	EFI_GUID(0x47be6ac9, 0x54cc, 0x46f9,
-		 0xa2, 0x62, 0xd5, 0x3b, 0x25, 0x6a, 0x0c, 0x34);
-
-efi_guid_t package_guid =
+static efi_guid_t package_guid =
 	EFI_GUID(0x0387c95a, 0xd703, 0x2346,
 		 0xb2, 0xab, 0xd0, 0xc7, 0xdd, 0x90, 0x44, 0xf8);
-- 
2.45.2

