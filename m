Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A27C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 05:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C060F83E9A;
	Fri, 11 Apr 2025 07:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DXGedZBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2001D83E9F; Fri, 11 Apr 2025 07:36:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B94D83E72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-163.46.114.pool.telefonica.de
 [46.114.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2CE6F3F079; 
 Fri, 11 Apr 2025 05:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744349808;
 bh=l72hnwHiKCAnEfI6AH9318hzDBTwA+qdplTK7cJLMlQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DXGedZBMnwSme+qTqHWTGpSj2q/7QxwJIr9CEUQhKbZVhOuImmkpfw7bl5Gnki1qZ
 iSBEfkZgNfH+VNYjZ6wTROi5d8z+PUCPytS9CeDDu8Xx4TTsIaPMu/WBq7xE6k79uT
 N45HxJKP6BY0cB7sZvrcsPbAev4uCR4sBG0IVxxHKbxTZR+OTO+vQB7K0CVfaC+vKO
 BH0pkX4n8dUxFDB1rbIT2VLwavLNK84IHDZ5sYJsYRwLQSqGfLXiWrSGdQ7Jl0yPZy
 1Ej+OozezOhS6BvYYjDvY1N68PNzkFMVGDWutmo7iHgQRYJ131mHQvwxEjQDMc0pMf
 Z8H8LZXrFCNmw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_selftest: use do_bootefi_exec()
Date: Fri, 11 Apr 2025 07:36:45 +0200
Message-ID: <20250411053645.17454-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The EFI selftest should match executing a real EFI binary
as closely as possible.

Use do_bootefi_exec() to enter the EFI selftest.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index c1454ffb948..13479248999 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -38,6 +38,9 @@ static efi_status_t bootefi_run_prepare(const char *load_options_path,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	(*image_objp)->auth_status = EFI_IMAGE_AUTH_PASSED;
+	(*image_objp)->entry = efi_selftest;
+
 	/* Transfer environment variable as load options */
 	return efi_env_set_load_options((efi_handle_t)*image_objp,
 					load_options_path,
@@ -106,8 +109,8 @@ static int do_efi_selftest(void)
 		return CMD_RET_FAILURE;
 
 	/* Execute the test */
-	ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
-	free(loaded_image_info->load_options);
+	ret = do_bootefi_exec(&image_obj->header,
+			      loaded_image_info->load_options);
 	efi_free_pool(test_device_path);
 	efi_free_pool(test_image_path);
 	if (ret != EFI_SUCCESS)
-- 
2.48.1

