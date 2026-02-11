Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26116E9E301
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 12:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF8083CB5;
	Wed, 11 Feb 2026 13:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8C080FA1; Wed, 11 Feb 2026 13:43:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 60CC280FA1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 13:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 581F7339;
 Wed, 11 Feb 2026 04:43:11 -0800 (PST)
Received: from debian (MacBookPro.nice.Arm.com [10.34.111.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB3E53F632;
 Wed, 11 Feb 2026 04:43:16 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH] efi_loader: add missing EFI_CALL around tcg2 read_blocks calls
Date: Wed, 11 Feb 2026 13:43:14 +0100
Message-ID: <20260211124314.3406952-1-vincent.stehle@arm.com>
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

The read_blocks() function from the Block IO protocol is a UEFI function;
make sure to call it from within U-Boot using the EFI_CALL() macro.

To demonstrate the issue on an AArch64 machine, define the DEBUG macro in
include/efi_loader.h and build u-boot with sandbox_defconfig, then download
and uncompress the ACS-DT image [1], and finally execute the following
command:

  $ ./u-boot -T -c " \
      host bind 0 systemready-dt_acs_live_image.wic; \
      setenv loadaddr 0x10000; \
      load host 0 \${loadaddr} EFI/BOOT/Shell.efi; \
      bootefi \${loadaddr} \${fdtcontroladdr}"

The following assertion should fail:

  lib/efi_loader/efi_net.c:858: efi_network_timer_notify: Assertion `__efi_entry_check()' failed.

This happens due to the following EFIAPI functions call chain:

  efi_start_image()
    efi_disk_read_blocks()
      (due to the missing EFI_CALL, entry_count == 2)
      efi_network_timer_notify()

Link: https://github.com/ARM-software/arm-systemready/releases/download/v25.12_DT_3.1.1/systemready-dt_acs_live_image.wic.xz [1]
Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 lib/efi_loader/efi_tcg2.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index bdf78897d47..1860dc50238 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1213,8 +1213,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
 		goto out2;
 	}
 
-	ret = block_io->read_blocks(block_io, block_io->media->media_id, 1,
-				    block_io->media->block_size, gpt_h);
+	ret = EFI_CALL(block_io->read_blocks(block_io,
+					     block_io->media->media_id, 1,
+					     block_io->media->block_size,
+					     gpt_h));
 	if (ret != EFI_SUCCESS)
 		goto out2;
 
@@ -1227,9 +1229,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
 		goto out2;
 	}
 
-	ret = block_io->read_blocks(block_io, block_io->media->media_id,
-				    gpt_h->partition_entry_lba,
-				    total_gpt_entry_size, entry);
+	ret = EFI_CALL(block_io->read_blocks(block_io,
+					     block_io->media->media_id,
+					     gpt_h->partition_entry_lba,
+					     total_gpt_entry_size, entry));
 	if (ret != EFI_SUCCESS)
 		goto out2;
 
-- 
2.51.0

