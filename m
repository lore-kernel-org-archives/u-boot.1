Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35496D34097
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E8D8410D;
	Tue, 27 Jan 2026 17:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C907E84119; Tue, 27 Jan 2026 17:18:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EACF784101
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B136E1596;
 Tue, 27 Jan 2026 08:18:42 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.128.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A1E53F73F;
 Tue, 27 Jan 2026 08:18:47 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2] efi_loader: fix use after free in efi_exit() with tcg2
Date: Tue, 27 Jan 2026 17:18:43 +0100
Message-ID: <20260127161843.2676862-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123105814.1083834-1-vincent.stehle@arm.com>
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
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

The efi_exit() function frees the loaded image memory by calling
efi_delete_image(). However, when CONFIG_EFI_TCG2_PROTOCOL is enabled, the
image_obj->image_type structure member is accessed after the memory has
been freed.

Fix this by performing the tcg2 measurement before the image deletion.

Fixes: 8fc4e0b4273a ("efi_loader: add boot variable measurement")
Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
---

Hi,

Here is a respin after feedbacks. [1]

Changes for v2:
- Move the event measurement before image deletion instead of keeping a
  copy of image_type (thanks Ilias!)

This can be verified with sandbox_defconfig + CONFIG_VALGRIND=y and the
following command:

  valgrind --suppressions=scripts/u-boot.supp \
    ./u-boot -T -c "setenv efi_selftest start image return; \
                    bootefi selftest"

This was lightly tested for regression with sandbox_defconfig and the
following commands:

  ./u-boot -T -c "ut measurement"

  ./test/py/test.py --build-dir="$PWD" -s -k "test_efi_bootmgr \
	or test_efi_loader or test_efi_selftest or test_efi_secboot"

Adding some instrumentation in efi_exit() and tcg2_log_append() shows no
change in the event measurements sequence.

[1] https://lore.kernel.org/u-boot/20260123105814.1083834-1-vincent.stehle@arm.com/

 lib/efi_loader/efi_boottime.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ddc935d2240..b424d924896 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3494,12 +3494,6 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 		if (ret != EFI_SUCCESS)
 			EFI_PRINT("%s: out of memory\n", __func__);
 	}
-	/* efi_delete_image() frees image_obj. Copy before the call. */
-	exit_jmp = image_obj->exit_jmp;
-	*image_obj->exit_status = exit_status;
-	if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
-	    exit_status != EFI_SUCCESS)
-		efi_delete_image(image_obj, loaded_image_protocol);
 
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
@@ -3510,6 +3504,13 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 		}
 	}
 
+	/* efi_delete_image() frees image_obj. Copy before the call. */
+	exit_jmp = image_obj->exit_jmp;
+	*image_obj->exit_status = exit_status;
+	if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
+	    exit_status != EFI_SUCCESS)
+		efi_delete_image(image_obj, loaded_image_protocol);
+
 	/* Make sure entry/exit counts for EFI world cross-overs match */
 	EFI_EXIT(exit_status);
 
-- 
2.51.0

