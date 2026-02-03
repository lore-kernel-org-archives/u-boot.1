Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D099E87824
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 12:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D580483FFA;
	Tue,  3 Feb 2026 13:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB15840EE; Tue,  3 Feb 2026 13:59:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3582283FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 13:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3D9339;
 Tue,  3 Feb 2026 04:59:46 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.124.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D64C3F632;
 Tue,  3 Feb 2026 04:59:52 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH] efi_loader: fix efi_debug_image_info_normal allocation
Date: Tue,  3 Feb 2026 13:59:41 +0100
Message-ID: <20260203125941.1876658-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When adding a new EFI Debug Image Info entry, we allocate memory for a new
EFI Debug Image Info Normal structure and we add a new entry into the EFI
Debug Image Info Table, which is in fact just a pointer to the allocated
structure.

However, when allocating memory for the new structure we allocate memory
for the wrong type, leading to allocating memory for just a pointer instead
of the desired structure.

Fix the type used during allocation.

Fixes: 146546138af5 ("efi: add EFI_DEBUG_IMAGE_INFO for debug")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 lib/efi_loader/efi_debug_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index 490b0bb7088..8d0c133871e 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -111,7 +111,7 @@ efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
 
 	/* Allocate data for new entry. */
 	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
-				sizeof(union efi_debug_image_info),
+				sizeof(struct efi_debug_image_info_normal),
 				(void **)(&(*table)[index].normal_image));
 	if (ret == EFI_SUCCESS && (*table)[index].normal_image) {
 		/* Update the entry. */
-- 
2.51.0

