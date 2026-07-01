Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE9C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B01484BED;
	Wed,  1 Jul 2026 13:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="EPf5R5Ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B4184BC8; Wed,  1 Jul 2026 13:19:09 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D3E84B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904743; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mb9WOhx6aIs6p6Ytcwq3TXGNIXboJ34iyZ0oa2vajIDZCiZM2jcc6YUcIcmTFBd+sQ+J5795l/OR4eDxd98tSGXf0J2rWfWwduYrFy/2SeqGaXNqPLfBKgZyiEbLVkQOPV7+8Z3i3cn6PbB4xlJTenhhZ7RiHyYwOauqLJmKYys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904743;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lSzogFYGAbHSNK/RM/CaemgsDZKr0PThX1F+ov7kLhI=; 
 b=Z1t73nOSwFVteMP5RQ69yJkhxgsGanMGY/fmDn6i6gpWNPZiklVnhrLZNnrf2dIl22yeJ5akISkIIIwQX6n7HSEuzE1onBU7x3IiYPjdh0GvifcJO5RMMXuVBEtm/kTLgztROGCzt9BUGQHeubJaiTuSJizAvADMKqmT6mkfPdY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904743; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lSzogFYGAbHSNK/RM/CaemgsDZKr0PThX1F+ov7kLhI=;
 b=EPf5R5UeKby4AcLaCc4Tv1j1aTFjAxEi9NYnZ5Jw0CzdNFEcyJZVpvL6v+wyVS7G
 aP30QJPjJfO7nOtPAOV+u2gymUnhHe3YTB/NX5xo5nPy2yKzUxMvcoVWis7O+kfnQD6
 YFF1E/rDBRzOAUn45ybnHmEyYgiFU3C2Y9P6OsBw=
Received: by mx.zohomail.com with SMTPS id 1782904741040737.9431606878451;
 Wed, 1 Jul 2026 04:19:01 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 14/16] board: emulation: Add qemu-loongarch
Date: Wed,  1 Jul 2026 11:18:06 +0000
Message-ID: <20260701111808.870705-15-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Yet another generic QEMU VIRT machine.
QEMU placed FDT in memory before launching U-Boot, so we
can just obtian FDT here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1
- Remove dynamic setup for environment variables

 arch/loongarch/Kconfig                        |  5 ++
 arch/loongarch/dts/qemu-loongarch64.dts       |  9 +++
 board/emulation/qemu-loongarch/Kconfig        | 68 +++++++++++++++++++
 board/emulation/qemu-loongarch/MAINTAINERS    |  7 ++
 board/emulation/qemu-loongarch/Makefile       |  6 ++
 .../emulation/qemu-loongarch/qemu-loongarch.c | 67 ++++++++++++++++++
 .../qemu-loongarch/qemu-loongarch.env         |  6 ++
 configs/qemu-loongarch64_defconfig            | 36 ++++++++++
 include/configs/qemu-loongarch.h              | 13 ++++
 9 files changed, 217 insertions(+)
 create mode 100644 arch/loongarch/dts/qemu-loongarch64.dts
 create mode 100644 board/emulation/qemu-loongarch/Kconfig
 create mode 100644 board/emulation/qemu-loongarch/MAINTAINERS
 create mode 100644 board/emulation/qemu-loongarch/Makefile
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.c
 create mode 100644 board/emulation/qemu-loongarch/qemu-loongarch.env
 create mode 100644 configs/qemu-loongarch64_defconfig
 create mode 100644 include/configs/qemu-loongarch.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5254afb2cd05..6cf7ad9b3a4f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,9 +7,14 @@ config SYS_ARCH
 choice
 	prompt "Target select"
 
+config TARGET_QEMU_LOONGARCH_VIRT
+	bool "Support QEMU Virt Board"
+	select BOARD_LATE_INIT
+
 endchoice
 
 # board-specific options below
+source "board/emulation/qemu-loongarch/Kconfig"
 
 # platform-specific options below
 source "arch/loongarch/cpu/generic/Kconfig"
diff --git a/arch/loongarch/dts/qemu-loongarch64.dts b/arch/loongarch/dts/qemu-loongarch64.dts
new file mode 100644
index 000000000000..39d303798fcb
--- /dev/null
+++ b/arch/loongarch/dts/qemu-loongarch64.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+
+/ {
+};
diff --git a/board/emulation/qemu-loongarch/Kconfig b/board/emulation/qemu-loongarch/Kconfig
new file mode 100644
index 000000000000..188cd6967bfd
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
+	imply BOARD_LATE_INIT
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
+
+endif
diff --git a/board/emulation/qemu-loongarch/MAINTAINERS b/board/emulation/qemu-loongarch/MAINTAINERS
new file mode 100644
index 000000000000..0ecd8201fb96
--- /dev/null
+++ b/board/emulation/qemu-loongarch/MAINTAINERS
@@ -0,0 +1,7 @@
+QEMU LOONGARCH 'VIRT' BOARD
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+S:	Maintained
+F:	board/emulation/qemu-loongarch/
+F:	board/emulation/common/
+F:	include/configs/qemu-loongarch.h
+F:	configs/qemu-loongarch64_defconfig
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
index 000000000000..834a36345010
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
+	/* Limit RAM used by U-Boot to the DDR low region */
+	if (gd->ram_top > 0x10000000)
+		return 0x10000000;
+
+	return gd->ram_top;
+}
+
+int board_init(void)
+{
+	return 0;
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
+	/* Stored the DTB address there during our init */
+	*fdtp = (void *)(ulong)0x100000;
+	return 0;
+}
diff --git a/board/emulation/qemu-loongarch/qemu-loongarch.env b/board/emulation/qemu-loongarch/qemu-loongarch.env
new file mode 100644
index 000000000000..2d130510607d
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.env
@@ -0,0 +1,6 @@
+
+stdin=serial,usbkbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+boot_targets=qfw usb scsi virtio nvme dhcp
diff --git a/configs/qemu-loongarch64_defconfig b/configs/qemu-loongarch64_defconfig
new file mode 100644
index 000000000000..d7f9c4338486
--- /dev/null
+++ b/configs/qemu-loongarch64_defconfig
@@ -0,0 +1,36 @@
+CONFIG_LOONGARCH=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-loongarch64"
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
diff --git a/include/configs/qemu-loongarch.h b/include/configs/qemu-loongarch.h
new file mode 100644
index 000000000000..c1af4fee83ff
--- /dev/null
+++ b/include/configs/qemu-loongarch.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+/* Those values are chosen by LoongArchQemuPkg */
+#define CFG_SYS_INIT_RAM_ADDR	0x10000
+#define CFG_SYS_INIT_RAM_SIZE	0x10000
+
+#endif
-- 
2.54.0

