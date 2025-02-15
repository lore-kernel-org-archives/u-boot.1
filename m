Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A13DC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF0780C6F;
	Sat, 15 Feb 2025 16:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SVIhzvTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8145780C77; Sat, 15 Feb 2025 16:55:19 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A69880756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2414025BDA;
 Sat, 15 Feb 2025 16:55:17 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fhosjEtU0ON; Sat, 15 Feb 2025 16:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1739634915; bh=HzYBPKYUdIkpjheHK3Z8UYeTXAnXJiU8/hT6DRrgUWQ=;
 h=From:To:Cc:Subject:Date;
 b=SVIhzvTc06QCrSYtbvoFX9Xd2bAnrDVy+M7YEgioXQVsZs6MjLupmpq4u9pk5DXeQ
 MruD6ITGblmDttUS3l8Tmpa6Sj8H9iCrc+2ma5H/HjF6Yh7B142x0spamrD6aTiZbE
 h4ni78tLbtYoNuHD/b34xD8rEjpazwE7ygSrCEl/AMC0uzCcrUrkAL1lh40Ht++rb7
 LYl5MFJLKv3xgTYJPwqjMshrlWtiecXBTo9d8Yo0KBBXf5K5dH66xfdaVIdgZIHBzq
 ACW0In9Hwbq8BtejHy307t29z18Z47xZtK1U4Or9iLSbHYSqkL3KhqNCvKjEuZk1uw
 YiuudwzyckQuw==
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] efi_loader: Clean up usage of structure jmp_buf_data
Date: Sat, 15 Feb 2025 15:54:35 +0000
Message-ID: <20250215155434.42749-2-ziyao@disroot.org>
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

Structure jmp_buf_data provides the underlying format of jmp_buf, which
we actually don't care about. Clean up existing code to use the standard
jmp_buf type. This introduces no functional change.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 include/efi_loader.h          | 4 ++--
 lib/efi_loader/efi_boottime.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index dcae6a731a0..4afe8b9c859 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -15,13 +15,13 @@
 #include <efi_api.h>
 #include <image.h>
 #include <pe.h>
+#include <asm/setjmp.h>
 #include <linux/list.h>
 #include <linux/sizes.h>
 #include <linux/oid_registry.h>
 
 struct blk_desc;
 struct bootflow;
-struct jmp_buf_data;
 
 #if CONFIG_IS_ENABLED(EFI_LOADER)
 
@@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
 	efi_status_t *exit_status;
 	efi_uintn_t *exit_data_size;
 	u16 **exit_data;
-	struct jmp_buf_data *exit_jmp;
+	jmp_buf *exit_jmp;
 	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
 				     struct efi_system_table *st);
 	u16 image_type;
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 5164cb15986..80c56b1ee46 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3199,7 +3199,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 	void *info;
 	efi_handle_t parent_image = current_image;
 	efi_status_t exit_status;
-	struct jmp_buf_data exit_jmp;
+	jmp_buf exit_jmp;
 
 	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
 
@@ -3238,7 +3238,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 	}
 
 	/* call the image! */
-	if (setjmp(&exit_jmp)) {
+	if (setjmp(exit_jmp)) {
 		/*
 		 * We called the entry point of the child image with EFI_CALL
 		 * in the lines below. The child image called the Exit() boot
@@ -3444,7 +3444,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 	struct efi_loaded_image *loaded_image_protocol;
 	struct efi_loaded_image_obj *image_obj =
 		(struct efi_loaded_image_obj *)image_handle;
-	struct jmp_buf_data *exit_jmp;
+	jmp_buf *exit_jmp;
 
 	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
 		  exit_data_size, exit_data);
@@ -3511,7 +3511,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 	 */
 	efi_restore_gd();
 
-	longjmp(exit_jmp, 1);
+	longjmp(*exit_jmp, 1);
 
 	panic("EFI application exited");
 out:
-- 
2.48.1

