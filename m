Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B9606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tcwGN+sP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=LFoKzgDs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 772EA608A5;
	Thu, 12 Nov 2026 11:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPvvOcbo1dy1; Thu, 12 Nov 2026 11:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EEB660735
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484683;
	b=gqTqay43B8ioDVRF18/qi35jHAdeSga3Skvgxr4RJaLrzlqN54Q2srFASv1WuNF57Qbn
	 OOC7+n8vebCs6nW+6QnX5P143Pkj9c2d7Y/55LlfDiFo4iG2KINu5FdbBvbQBT0xnpJCe
	 ghFPoMPCAZLcPc+YXt6G3NCufFwj9/EGE29VrR+7DRkgJnabrQ8AsUwpmM2+BBnLNJ70M
	 D4BWpDblLk4wLnNW5Vet/MsisVFedbrjFkE7k/U/5JAQNSrBbDWtVd41ei0P3MiiORL1z
	 BlCBpTcbO3dbwc6SlMp+GIgWH+DJqgqyeXKRremI23ZOg9vsvcmrxZ9M6vn7xZsCZAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
	b=AnlHD8V7/7C0dDoTmGKLtSt3O/TapC/lZXMrXFmyIZQfpZDuSJAIeIsvxhltHmlJwjbu
	 uR6FMx3i7Tvnnwj66UEjvj7avNe7zRy1YxJsaCjfvy8rIWf+objDfC/3U8BJuK2AKH+ry
	 vfq6K/kcMNPL2oQnRlBlzcEhAfvCrqfLKinYVTKFIpY8GuFQVniKL6PHZCTlVJrJohp0j
	 7uKBrQlO49gvlp2cCrtTr2ZMs4xip2icuKiHtgIR6LGgrGc4xqBnXFcpQSi9nxwSMfnuD
	 MqyAWiP3XpYT63F/wb7DiJkq0gbpz1WBn3NJbMvx0yUoSV8uEJy5xWbZJ3rza3FUP1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484683;
	bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tcwGN+sPfMBs9Su0XNFEu7xMNJ5UoxjaBTJUYfTQ/aexrDL/fevaoyx/RRWYnwrMq
	 FMgLra+I2q86AhL9/1IqZ1HChXaQBRSRfZ5ngqD3R/0TRa8vGgel4q1/vULLw+Db2o
	 TbIgCTbE+ngoBR7TT5oGA5NkzkiEWDXrf4dytj8o13EpeTtPQUjzdhw2JQxd1H8/w+
	 vlfNPCwhu7axoKh7zJX1g11tIpUT+IOZeVb23Ors2hojQxoBlQOMUZOR6+nVOsn6Td
	 GesvVsneROPY7LlpIFfT5H/0G2reKawphzOdEukScoDoeaDHRKqgXPEZYTNBqyTclT
	 WCujUNf80OOsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EEB660735;
	Thu, 12 Nov 2026 11:58:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9C31A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2D1A400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uk8B1zHc-7l9 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B127840042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=LFoKzgDs
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B127840042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:00 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=LFoKzgDskbUfQMRUrZmmci7nHDSIMp454P2KC6izHgdIcXJTmOjUweY3lhs412kNd5/Ew93PLIUe3apfrU2K/yv8U6TcWacqzoFV8ulYj8j+jHj0IzpT723wKGndLbtnmFJ498z5AqbO0fq7pmcDNLZtSNTlaUBCrS/GNTwb1lc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sSfucrxNDwMIZd+PINRhQfnqGnrErH1idqhHuAs7aC0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484673183363.95078339803854; 
 Thu, 12 Nov 2026 03:57:53 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 15/20] board: emulation: Add qemu-loongarch
Date: Thu, 12 Nov 2026 11:54:33 +0000
Message-ID: <20261112115438.1837663-16-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Yet another generic QEMU VIRT machine.

LoongArch QEMU splits the main RAM into two parts: the first 512M is
placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
U-Boot starts execution.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v4

Changed from v3
- Remove the dummy empty devicetree
- Fix the typo when limiting top usable RAM address top (0x1000_0000 ->
  0x1_0000_0000)

Changed from v2
- Add board-level documentation for qemu-loongarch
- Mention the memory layout and booting process in commit message
- Move TARGET_QEMU_LOONGARCH_VIRT to
  board/emulation/qemu-loongarch/Kconfig
- Drop duplicated selection of BOARD_LATE_INIT in
  TARGET_QEMU_LOONGARCH_VIRT
- Explain why RAM is limited to the lowest 4GiB
- Drop unused board_init()
- Rework comment in board_fdt_blob_setup()
- Define FDT address, 0x100000, as a meaningful constant
- Clarify how CFG_SYS_INIT_RAM_[ADDR,SIZE] are chosen
- Add myself to MAINTAINERS

Changed from v1
- Remove dynamic setup for environment variables
---
 arch/loongarch/Kconfig                        |  4 ++
 board/emulation/qemu-loongarch/Kconfig        | 68 +++++++++++++++++++
 board/emulation/qemu-loongarch/MAINTAINERS    |  9 +++
 board/emulation/qemu-loongarch/Makefile       |  6 ++
 .../emulation/qemu-loongarch/qemu-loongarch.c | 67 ++++++++++++++++++
 .../qemu-loongarch/qemu-loongarch.env         |  5 ++
 configs/qemu-loongarch64_defconfig            | 35 ++++++++++
 doc/board/emulation/index.rst                 |  1 +
 doc/board/emulation/qemu-loongarch.rst        | 39 +++++++++++
 include/configs/qemu-loongarch.h              | 17 +++++
 10 files changed, 251 insertions(+)
 create mode 100644 board/emulation/qemu-loongarch/Kconfig
 create mode 100644 board/emulation/qemu-loongarch/MAINTAINERS
 create mode 100644 board/emulation/qemu-loongarch/Makefile
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.c
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.env
 create mode 100644 configs/qemu-loongarch64_defconfig
 create mode 100644 doc/board/emulation/qemu-loongarch.rst
 create mode 100644 include/configs/qemu-loongarch.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1f376ca291c1..a53d26a59497 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,9 +7,13 @@ config SYS_ARCH
 choice
 	prompt "Target select"
 
+config TARGET_QEMU_LOONGARCH_VIRT
+	bool "Support QEMU Virt Board"
+
 endchoice
 
 # board-specific options below
+source "board/emulation/qemu-loongarch/Kconfig"
 
 # platform-specific options below
 source "arch/loongarch/cpu/generic/Kconfig"
diff --git a/board/emulation/qemu-loongarch/Kconfig b/board/emulation/qemu-loongarch/Kconfig
new file mode 100644
index 000000000000..94f42091e0be
--- /dev/null
+++ b/board/emulation/qemu-loongarch/Kconfig
@@ -0,0 +1,68 @@
+if TARGET_QEMU_LOONGARCH_VIRT
+
+config SYS_BOARD
+	default "qemu-loongarch"
+
+config SYS_VENDOR
+	default "emulation"
+
+config SYS_CPU
+	default "generic"
+
+config SYS_CONFIG_NAME
+	default "qemu-loongarch"
+
+config TEXT_BASE
+	default 0x1c000000
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select GENERIC_LOONGARCH
+	imply AHCI
+	imply PCI_INIT_R
+	imply CMD_PCI
+	imply CMD_POWEROFF
+	imply CMD_SCSI
+	imply CMD_PING
+	imply CMD_EXT2
+	imply CMD_EXT4
+	imply CMD_FAT
+	imply CMD_FS_GENERIC
+	imply DOS_PARTITION
+	imply ISO_PARTITION
+	imply EFI_PARTITION
+	imply SCSI_AHCI
+	imply AHCI_PCI
+	imply E1000
+	imply PCI
+	imply NVME_PCI
+	imply PCIE_ECAM_GENERIC
+	imply DM_RNG
+	imply DM_RTC
+	imply QFW
+	imply QFW_MMIO
+	imply SCSI
+	imply SYS_NS16550
+	imply SYSRESET
+	imply SYSRESET_CMD_POWEROFF
+	imply SYSRESET_SYSCON
+	imply VIRTIO_MMIO
+	imply VIRTIO_PCI
+	imply VIRTIO_NET
+	imply VIRTIO_BLK
+	imply MTD_NOR_FLASH
+	imply CFI_FLASH
+	imply OF_HAS_PRIOR_STAGE
+	imply VIDEO
+	imply VIDEO_BOCHS
+	imply SYS_WHITE_ON_BLACK
+	imply USB
+	imply USB_XHCI_HCD
+	imply USB_XHCI_PCI
+	imply USB_KEYBOARD
+	imply CMD_USB
+	imply UFS
+	imply UFS_PCI
+	imply BOARD_LATE_INIT
+
+endif
diff --git a/board/emulation/qemu-loongarch/MAINTAINERS b/board/emulation/qemu-loongarch/MAINTAINERS
new file mode 100644
index 000000000000..cd9636d6dc9b
--- /dev/null
+++ b/board/emulation/qemu-loongarch/MAINTAINERS
@@ -0,0 +1,9 @@
+QEMU LOONGARCH 'VIRT' BOARD
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+F:	board/emulation/qemu-loongarch/
+F:	board/emulation/common/
+F:	include/configs/qemu-loongarch.h
+F:	configs/qemu-loongarch64_defconfig
+F:	doc/board/emulation/qemu-loongarch.rst
diff --git a/board/emulation/qemu-loongarch/Makefile b/board/emulation/qemu-loongarch/Makefile
new file mode 100644
index 000000000000..a928b90780e9
--- /dev/null
+++ b/board/emulation/qemu-loongarch/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+obj-y	+= qemu-loongarch.o
diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.c b/board/emulation/qemu-loongarch/qemu-loongarch.c
new file mode 100644
index 000000000000..9370e81bc276
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <env.h>
+#include <fdtdec.h>
+#include <image.h>
+#include <linux/sizes.h>
+#include <lmb.h>
+#include <log.h>
+#include <spl.h>
+#include <init.h>
+#include <usb.h>
+#include <virtio_types.h>
+#include <virtio.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define VIRT_FDT_BASE 0x100000
+
+#if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
+int is_flash_available(void)
+{
+	if (!ofnode_equal(ofnode_by_compatible(ofnode_null(), "cfi-flash"),
+			  ofnode_null()))
+		return 1;
+
+	return 0;
+}
+#endif
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit RAM used by U-Boot to 4GiB to keep compatible with 32-bit-only
+	 * DMA peripherals, for example, emulated PCI cards.
+	 */
+	if (gd->ram_top > 0x100000000ULL)
+		return 0x100000000ULL;
+
+	return gd->ram_top;
+}
+
+int board_late_init(void)
+{
+	/* start usb so that usb keyboard can be used as input device */
+	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
+		usb_init();
+
+	/*
+	 * Make sure virtio bus is enumerated so that peripherals
+	 * on the virtio bus can be discovered by their drivers
+	 */
+	virtio_init();
+
+	return 0;
+}
+
+int board_fdt_blob_setup(void **fdtp)
+{
+	/* QEMU stores the DTB to 0x100000 */
+	*fdtp = (void *)VIRT_FDT_BASE;
+	return 0;
+}
diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.env b/board/emulation/qemu-loongarch/qemu-loongarch.env
new file mode 100644
index 000000000000..7655f26d8d6b
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.env
@@ -0,0 +1,5 @@
+stdin=serial,usbkbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+boot_targets=qfw usb scsi virtio nvme dhcp
diff --git a/configs/qemu-loongarch64_defconfig b/configs/qemu-loongarch64_defconfig
new file mode 100644
index 000000000000..5d5ae44f8e56
--- /dev/null
+++ b/configs/qemu-loongarch64_defconfig
@@ -0,0 +1,35 @@
+CONFIG_LOONGARCH=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x02000000
+CONFIG_SHOW_REGS=y
+# CONFIG_OF_BOARD_FIXUP is not set
+CONFIG_SYS_PCI_64BIT=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS_SUBST=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_2048=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_QFW=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_BLKMAP=y
+CONFIG_EFI_MEDIA=y
+CONFIG_DM_MMC=y
+CONFIG_DM_MTD=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_PCI_REGION_MULTI_ENTRY=y
+CONFIG_DM_REBOOT_MODE=y
+CONFIG_RESET_SYSCON=y
+CONFIG_HEXDUMP=y
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index 5d0dd83d8aca..a142cd3360ac 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -11,6 +11,7 @@ Emulation
    network
    video
    qemu-arm
+   qemu-loongarch
    qemu-mips
    qemu-ppce500
    qemu-riscv
diff --git a/doc/board/emulation/qemu-loongarch.rst b/doc/board/emulation/qemu-loongarch.rst
new file mode 100644
index 000000000000..0d97dc7df797
--- /dev/null
+++ b/doc/board/emulation/qemu-loongarch.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+
+QEMU LoongArch
+==============
+
+QEMU for LoongArch supports a special 'virt' machine designed for emulation
+and virtualization purpose. This document describes how to run U-Boot under it.
+Only 64-bit LoongArch is supported at this time.
+
+The 'virt' platform provides the following as the basic functionality:
+
+    - A freely configurable amount of CPU cores
+    - U-Boot loaded and executing in the emulated flash, mapped to 0x1c000000.
+    - A generated device tree blob placed at 0x100000.
+    - A freely configurable amount of RAM, described by the DTB, starting at
+      0x0. RAM above 512MiB is placed at 0x80000000.
+    - A NS16550A serial port, discoverable via the DTB.
+    - An in-core constant frequency timer.
+    - syscon-reboot and syscon-poweroff for powering off and rebooting the
+      system.
+    - A generic ECAM-based PCI host controller, discoverable via the DTB.
+
+Additionally, a number of optional peripherals can be added to the PCI bus.
+
+See :doc:`../../develop/devicetree/dt_qemu` for information on how to see the
+devicetree actually generated by QEMU.
+
+Building and Running
+--------------------
+
+Set the CROSS_COMPILE environment variable as usual, and run::
+
+    make qemu-loongarch64_defconfig
+    make
+
+The minimal QEMU command line to get U-Boot up and running is::
+
+    qemu-system-loongarch64 -M virt -nographic -bios u-boot.bin
diff --git a/include/configs/qemu-loongarch.h b/include/configs/qemu-loongarch.h
new file mode 100644
index 000000000000..7103dc1b02ef
--- /dev/null
+++ b/include/configs/qemu-loongarch.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+/*
+ * LoongArch QEMU always places a part of the RAM at 0x0. These options are only
+ * intended to specify the initial stack pointer address, and can be replaced
+ * with CUSTOM_SYS_INIT_SP_ADDR when it's supported in the future.
+ */
+#define CFG_SYS_INIT_RAM_ADDR	0x0
+#define CFG_SYS_INIT_RAM_SIZE	0x80000
+
+#endif
-- 
2.56.0

