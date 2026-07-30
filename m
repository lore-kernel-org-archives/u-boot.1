Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E17C5516E
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 20:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C695140D76;
	Thu, 30 Jul 2026 20:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xx-Q6UJbcztk; Thu, 30 Jul 2026 20:24:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC1D240CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785443092;
	bh=JPey0zZbpx/qazzVrzvoFo4PvlMxT4OSyFvIpRwRMtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b0rGuwEGt/LcDfIX8oondkpV4Z09e0uascaqwuRXNMN+8XKKXldRScydtS/ic2URU
	 YbpkMjgWcMWmlOv5HLkLvLcCp2Sb5Z/5cLiTzghhsCXLyNknY620GkGSf2/LkHPkyl
	 VzmHsXU/SAhSSnWxPhnR8zuNiMj4flV0u4mATVyJC7cFa7ktSqcbztYuZBCSswx5b0
	 ghGHDF7h3vQLSWCJwaWiXeW8/Nl1oZJaNpawugl2UVFft9s8OgQLpO/M0jCXT8Ptoh
	 yXyDdwBmeABz8Trs5ZbIESgWQQ4NiaurJvJdqGap8pqPTW9Ksuph+atZZycFVaZTT0
	 6R3yU9A33K3/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC1D240CD2;
	Thu, 30 Jul 2026 20:24:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6282069
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 494D56089D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkWSRlfBfM2q for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:38:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=elliotjb@elliotjb.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C326560A60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C326560A60
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C326560A60
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5547184A0A; Thu, 30 Jul 2026 21:38:31 +0200 (CEST)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311B9849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 21:38:29 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [77.233.63.4])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 4h9zyS1KS0z3hhTP;
 Thu, 30 Jul 2026 15:38:23 -0400 (EDT)
From: Elliot Berman <elliotjb@elliotjb.com>
Date: Thu, 30 Jul 2026 12:37:46 -0700
Subject: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates to
 pflash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Elliot Berman <elliotjb@elliotjb.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 20:24:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785440307;
 bh=1ebFpbtyFFYyHQNqCO6Eb5Nf7i/yHgVnie8amvIj8Gw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YaBDMp0hHMyhylm+rer90th2KFh83mxHU3J23FMYC0SmBQWlGwhUSd9GZ66BbC/ix
 jb+4E8vah4yYoNuYkCW1nLHpsBCpL5P7yIXjGSH5qlDHIugXJ6TPaE91TFq9vV+Hm1
 uQM9fiSZPMVy3R+MC3qg4j5LC9nd8FUzZwHPd0jZJdE3uX8WdCbY9lX6TnFJn1bS47
 6/KC4iwOAgO/AyKhz/DAIbkZQNfav9nZ03w1qNgi6vzs2bPKDu+iN+ev8iwDz/Q5Ti
 dVnTGzjSTYvkNKPpmMWsuaXLoK5zWotKdADhmf7AL+xWDGQX7aQOYRrOac1BDP9hXQ
 7/ae0xbX/xdmA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=YaBDMp0h
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="YaBDMp0h";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Following the flow used for qemu-arm64, probe the pflash MTD device
and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
capsule updates can target the u-boot pflash partition.

Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
---
 board/emulation/common/Kconfig         |  2 ++
 board/emulation/common/qemu_dfu.c      |  6 ++++--
 board/emulation/common/qemu_mtdparts.c |  6 ++++--
 board/emulation/qemu-x86/Kconfig       |  3 +++
 board/emulation/qemu-x86/Makefile      |  3 +++
 board/emulation/qemu-x86/qemu-x86.c    | 38 ++++++++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kconfig
index 4c15c8bcb89..79e8a5cfb01 100644
--- a/board/emulation/common/Kconfig
+++ b/board/emulation/common/Kconfig
@@ -1,6 +1,8 @@
 config MTDPARTS_NOR0
 	string "mtd boot partition for nor0"
 	default "64m(u-boot)" if TARGET_QEMU_ARM_64BIT && !TFABOOT
+	default "2m(u-boot)" if TARGET_QEMU_X86_64
+	default "1m(u-boot)" if TARGET_QEMU_X86
 	depends on SYS_MTDPARTS_RUNTIME
 	help
 	  This define the partition of nor0 used to build mtparts dynamically
diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/qemu_dfu.c
index 8a59f5ade13..db7d8cbbb4e 100644
--- a/board/emulation/common/qemu_dfu.c
+++ b/board/emulation/common/qemu_dfu.c
@@ -51,11 +51,13 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	memset(buf, 0, DFU_ALT_BUF_LEN);
 
 	/*
-	 * Currently dfu_alt_info is needed on Qemu ARM64 for
+	 * Currently dfu_alt_info is needed on Qemu ARM64/X86/X86_64 for
 	 * capsule updates
 	*/
 	if (IS_ENABLED(CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT) &&
-	    IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT)) {
+	    (IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT) ||
+	     IS_ENABLED(CONFIG_TARGET_QEMU_X86) ||
+	     IS_ENABLED(CONFIG_TARGET_QEMU_X86_64))) {
 		/* probe all MTD devices */
 		mtd_probe_devices();
 
diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
index c1501276789..3b9319ea986 100644
--- a/board/emulation/common/qemu_mtdparts.c
+++ b/board/emulation/common/qemu_mtdparts.c
@@ -50,9 +50,11 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
 	memset(parts, 0, sizeof(parts));
 	memset(ids, 0, sizeof(ids));
 
-	/* Currently mtdparts is needed on Qemu ARM64 for capsule updates */
+	/* Currently mtdparts is needed on Qemu ARM64/x86/x86_64 for capsule updates */
 	if (IS_ENABLED(CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT) &&
-	    IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT)) {
+	    (IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT) ||
+	     IS_ENABLED(CONFIG_TARGET_QEMU_X86) ||
+	     IS_ENABLED(CONFIG_TARGET_QEMU_X86_64))) {
 		/* probe all MTD devices */
 		for (uclass_first_device(UCLASS_MTD, &dev); dev;
 		     uclass_next_device(&dev)) {
diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index c1564fba7cd..0c2ded1515c 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -24,5 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
 	imply CMD_SMBIOS
+	imply SET_DFU_ALT_INFO
+	imply SYS_MTDPARTS_RUNTIME
 
+source "board/emulation/common/Kconfig"
 endif
diff --git a/board/emulation/qemu-x86/Makefile b/board/emulation/qemu-x86/Makefile
new file mode 100644
index 00000000000..7859f91d0ee
--- /dev/null
+++ b/board/emulation/qemu-x86/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= qemu-x86.o
diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x86/qemu-x86.c
new file mode 100644
index 00000000000..f4ea6c24913
--- /dev/null
+++ b/board/emulation/qemu-x86/qemu-x86.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <config.h>
+#include <efi.h>
+#include <efi_loader.h>
+
+/* GUIDs for capsule updatable firmware images */
+#define QEMU_X86_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x8dfcd6f5, 0x42fe, 0x44c6, 0xa8, 0xae, \
+		 0x63, 0x7d, 0xa6, 0x1b, 0x6b, 0x95)
+
+#define QEMU_X86_64_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x5bb9ce0d, 0xa389, 0x456f, 0x83, 0xa8, \
+		 0x2b, 0xdf, 0xb8, 0xad, 0x01, 0xa1)
+
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+struct efi_fw_image fw_images[] = {
+#if defined(CONFIG_TARGET_QEMU_X86)
+	{
+		.image_type_id = QEMU_X86_UBOOT_IMAGE_GUID,
+		.fw_name = u"Qemu-X86-UBOOT",
+		.image_index = 1,
+	},
+#elif defined(CONFIG_TARGET_QEMU_X86_64)
+	{
+		.image_type_id = QEMU_X86_64_UBOOT_IMAGE_GUID,
+		.fw_name = u"Qemu-X86_64-UBOOT",
+		.image_index = 1,
+	},
+#endif
+};
+
+struct efi_capsule_update_info update_info = {
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */

-- 
2.54.0

