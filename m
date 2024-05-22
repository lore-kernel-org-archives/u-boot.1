Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3AC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E824E888A6;
	Wed, 22 May 2024 17:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Nhjb3QHe";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPFZ6L0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F9E88859; Wed, 22 May 2024 17:35:38 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF77A8888C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id EFAE11800116;
 Wed, 22 May 2024 11:35:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 22 May 2024 11:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392133;
 x=1716478533; bh=XoHmMChd3rbnALLWKIivIIIe0iRQJmFakZM3C+iBhWY=; b=
 Nhjb3QHeye5CkfEm6gD/h5CBwHP7m/sCKTiOD069ekD9JZS/WWw7gUjNxJm7pm/E
 hCpZkwitx6VJJonEj2AvOW/wZAuaWWbbWkRlAWQyojdbwZHDWJPuS0AzkuRjeKZu
 edHA5AG8WNX4VuTIjliATkXQ0RICqEkPeod3+UubiwdWpi8AyJIubdJyDV2Hz/+A
 AIZDHV6O6NyEqc5D0p7f9QOrK4a0LbnS9mz4YfA+EWwLEjAPTaqvajOpi1YS9U6v
 bqum/SElFs++dQ774McncigPcXH1XrxfIVVEIrVEmkBDM+QKVJHl7/p8CQYK6o4U
 aNKiLNr47aW7AaSKnXPITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392133; x=
 1716478533; bh=XoHmMChd3rbnALLWKIivIIIe0iRQJmFakZM3C+iBhWY=; b=V
 PFZ6L0xLQGUlt9Uxvwe0wbQ35zBWg/Py0HayAV2YaBszlvXhkbzSei13Ety8mQfq
 j+JBT4xi1+HzUVv52WKhEmGQHIEFih1tusiL80UpWr+mVpbKzLks10csGPegs+m2
 ae7YPJGKZuz6lLqbEZHM2wzPAAKa3uL3Exg7nq59akNWodD5sUPo6A7wuEdSw85q
 HErVnFQiRJQzUnNX2AohK+aFKwPR54qOjp/4ooUUbbj6piE+pbR3X9Tfum7mpTea
 N0duKy2ArFglxgyKjlGp5LsXliC4RAF7gEVqsUwo0z4m+AjVCvMzKIVS9TSnHqs5
 cAR8cm0KxcC/YkbBhQIWw==
X-ME-Sender: <xms:xRBOZif6bjBPWTht4jZzVPCSzghMOqdOCYm8p_eD6mqpk7xTaVF9NA>
 <xme:xRBOZsOo6Qn1XWOV5kPA0Uij4SDtWuwlYvVA6l4AkfM6gMQ7crEoyyfm07jQlGu14
 x9HiGmA8Kwo4Zp5c9I>
X-ME-Received: <xmr:xRBOZjhlQMtRFD1z4ZqWinBQYmA-1bTYOF2bL3CbACWcX7feYVB9coE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xRBOZv_U3onh4izd86Ivio9m3oGz_rjcX0YR-IN07dAUF8JV9yE_kA>
 <xmx:xRBOZuuOlaAKBFUeeHIJGaiws5PHr0eAOStFy4SbvJKEr_3aMeVCCA>
 <xmx:xRBOZmGYn8mY24fl5mOEQqf4jIuASwCR-uYg4BXsZ7E1dLXiFGu0gw>
 <xmx:xRBOZtOY5EUOESToOSByixdzHYOHcz8bQz6RG1S8p9lbpLz1oOst-w>
 <xmx:xRBOZig3O8-sLiqsESbiUL9axepXr1GLmKvsRQLTi6oik18Iz9834CKK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:32 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:57 +0100
Subject: [PATCH 14/16] board: emulation: Add qemu-loongarch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-14-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8449;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=vqfb87WviAEJUyt6GltxUrU/SVMrmmPNx21zjgMRYXk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geUPpt3+GHernsN0veP2zYc3CP2++PeO/A/ztEeLF
 MI/TduT01HKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATufiH4b/7rZ47l/1jndfI
 y79iMvshznj72tswgy+GGu6cGS8uftBhZDgsKlU2cZ4Fu1qJQ7TfbXVzAbEp+15pbj7w2+aUXsk
 zdwYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Yet another generic QEMU VIRT machine.
QEMU placed FDT in memory before launching U-Boot, so we
can just obtian FDT here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/Kconfig                            |  5 ++
 arch/loongarch/dts/qemu-loongarch64.dts           |  9 +++
 board/emulation/qemu-loongarch/Kconfig            | 68 ++++++++++++++++++
 board/emulation/qemu-loongarch/MAINTAINERS        |  7 ++
 board/emulation/qemu-loongarch/Makefile           |  6 ++
 board/emulation/qemu-loongarch/qemu-loongarch.c   | 84 +++++++++++++++++++++++
 board/emulation/qemu-loongarch/qemu-loongarch.env |  6 ++
 configs/qemu-loongarch64_defconfig                | 36 ++++++++++
 include/configs/qemu-loongarch.h                  | 13 ++++
 9 files changed, 234 insertions(+)

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
index 000000000000..5cedd2c7479e
--- /dev/null
+++ b/board/emulation/qemu-loongarch/qemu-loongarch.c
@@ -0,0 +1,84 @@
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
+#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_64K)
+
+int board_late_init(void)
+{
+	struct lmb lmb;
+	u32 status = 0;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+
+	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
+	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, SZ_64M));
+	status |= env_set_hex("kernel_comp_size", SZ_64M);
+	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+
+	if (status)
+		log_warning("late_init: Failed to set run time variables\n");
+
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
+void *board_fdt_blob_setup(int *err)
+{
+	*err = 0;
+	/* Stored the DTB address there during our init */
+	return (void *)(ulong)0x100000;
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
2.43.0

