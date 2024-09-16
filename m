Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4557C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 13:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C5088C45;
	Mon, 16 Sep 2024 15:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="0b0IzAYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAE788C78; Mon, 16 Sep 2024 15:03:49 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A3B889FC
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 15:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pool3002.local (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 500231FB85;
 Mon, 16 Sep 2024 15:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1726491826;
 bh=FIqWFLF9kTuUqNDSotOBdh9UwZtltcIjFen6xlvftOE=; h=From:To:Subject;
 b=0b0IzAYJdF4Gmdv2U5WAYXgICzV8ZcDW8TAh2FhL4C6wiY/iJqswigjI5oYLEJK9J
 xil0PjmsAu/4PMlKZWLj5H+nsht7Sqwuw3XSTULlA7/dl2kFAEs0+fYZ/F2nTPbo8M
 tPKOOay3gR5cogFCtquSJ910dLAC9jItZDCe2xKfiWK8gCSmP2IhAlbwgn5dWEX/Vz
 FivGlAjCKsqhpdAXzpMPeMitOmMNCUKdm9AHgq/P4WbrKOsXFG3vr4LHHyy8FzY35H
 +qkW++k9wkZ9WajBzy3WcMqBs1LDgKckB06Z7SpBM2Epf7KG+Jujnr8j7jpyKspE1T
 NgmDwgNi/U9GA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Hiago De Franco <hiago.franco@toradex.com>, Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Date: Mon, 16 Sep 2024 15:03:36 +0200
Message-Id: <20240916130336.12472-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
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

From: Hiago De Franco <hiago.franco@toradex.com>

When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
fails with the following errors:

  AR      spl/boot/built-in.o
  LD      spl/u-boot-spl
arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
`fw_get_filesystem_firmware':
/u-boot/drivers/misc/fs_loader.c:162: undefined reference to
`fs_set_blk_dev'
arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
fs_loader.c:185: undefined reference to `fs_read'
arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
`select_fs_dev':
/u-boot/drivers/misc/fs_loader.c:89: undefined reference to
`fs_set_blk_dev_with_part'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make: *** [Makefile:2055: spl/u-boot-spl] Error 2

Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile, so
the fs.c with the necessary function definitions are compiled.

Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compilation at SPL Level")
Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: fix sandbox_noinst_defconfig and config SPL_BLK_FS
---
 configs/sandbox_noinst_defconfig | 1 +
 drivers/block/Kconfig            | 2 +-
 fs/Makefile                      | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index f37230151a05..9ddb606f8f9b 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -186,6 +186,7 @@ CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
 CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_CONCAT=y
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 48529a6982f5..5283d8981e09 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -109,7 +109,7 @@ config EFI_MEDIA
 
 config SPL_BLK_FS
 	bool "Load images from filesystems on block devices"
-	depends on SPL_BLK
+	depends on SPL_BLK && SPL_FS_LOADER
 	help
 	  Use generic support to load images from fat/ext filesystems on
 	  different types of block devices such as NVMe.
diff --git a/fs/Makefile b/fs/Makefile
index 7b05c79e0ccf..a3ee0a361d3d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -5,7 +5,7 @@
 # Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
 
 ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_FS_LOADER) += fs.o
+obj-$(CONFIG_SPL_FS_LOADER) += fs.o
 obj-$(CONFIG_SPL_FS_FAT) += fat/
 obj-$(CONFIG_SPL_FS_EXT4) += ext4/
 obj-$(CONFIG_SPL_FS_CBFS) += cbfs/
-- 
2.39.5

