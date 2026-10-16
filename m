Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC3CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60D9440994;
	Fri, 16 Oct 2026 06:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTUHqzYNH2eI; Fri, 16 Oct 2026 06:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58A474097A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133918;
	b=shmP/JH+nEWhsMmBpSyS3V+rB8m1O12qL70jLwTK+3J1YKAyuSduhZoDMPtsWOk2SMoK
	 3WiN//z81fwDVufj7q4qwJdc7/rTypLiA5aOzBy1N+2Fvv+M6tt9ZU2/l58AJ3nNmVdq6
	 yelsZxE6b+hAQhT3ECn+qLy/GK8QnIxF2hAVO2FrWl4EKmIm8rojSClHVLd3JgDlDyrk0
	 AcLKVPyiPgDC+qTv66DTHUcGc3CMKYfd52VtRfaBhKi68oHEgB0dW0EVWenIkeWUPwS+F
	 Q0ebTMZtW5eS7cYRpiGyexdWyCzh5dcP+kq61GgD2DGAFyn6jCEv59oyUVC6oYJ8X6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=s5NkNzyilgBOeCXI8Zh3eZOLjtQPp57GBN7vIEhp4Pk=;
	b=pCPIThai5HBHFJZajY6zFgfTxGLBaLoxFgEMaDxJMvq+4hZENMaWjgX6adB4Y2pTEyg/
	 DCWQ+ciNHa59KB+GJgIXlRGE8zMCF957sAaaJWP9+a0qv+JMS8yWlvK7Bp8hvC9jmhwZY
	 psP4MPGJSKxnm0Z0LuLXw4AnGcK+aoPuKnlGArunO/FI3yLGC4DP7qsH7bbAwNGoAoAwk
	 MUox0USACbZ7vUrZ6ftsQZMr/q50RcFbd/SGwJ4/8lIhtVEc86JzwqneoWkvhM5xEZAUw
	 brMsOxA/NdQyBIrlgm2Jrgygx1BwPkzgBwyzeZbOb9Jk4ZRlAY3IJjjQBSJMgwtoUFA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133918;
	bh=s5NkNzyilgBOeCXI8Zh3eZOLjtQPp57GBN7vIEhp4Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drULu04iDRPDHq/LlcaOTgJB/afZ8OZ+ZUSzhK/L4dXOe4yhhYCBi2ebrv4J1UOBQ
	 zHOmWWaoOJyQwD56S6jCrUrDGVBRHdakKhwu4KA4nDTLNblWNF4CLZ/8EaSadtaKFZ
	 gmBlmWIFjr0LI9qFoMZouGY3y4xdhX3Gb1aq8V7nuYg88YCRPa59MGPEoYhj/W8CLW
	 oc2FaQocCmVMqtsZR86iGZG1fPQmoleo2hAx7H4nA0CRA9ZjqiWmDDDGdHLilHielU
	 Mhs1KDLsrA2+8k5av5/6YAo/JPEFHuAE/HRGi3bWbyr4PbT0qScVJSd8RVWcqVWUIF
	 snbMmbyR8Oo9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58A474097A;
	Fri, 16 Oct 2026 06:58:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7642F362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C027812E4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChUlPCM3wGb9 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A84B812AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133915;
 b=oelHy+oFcY9HOFIakLVXAJL+PHQ0PbdVaNzHGYMTCFx9MxDFfw/wSFvAo3ek7GyFH/OW
 LbIvkakspPnNKOqxDwrWhI/lfiNV/vto6vF2tOhoAAjithHu2Vyir5vSDbGJZRrBzbTtr
 d2Yz0Gk/v7ZraPUSIBPdSjCqHu8PTTCq1o9ytFpSP3PmwK6PUPfdxDGPK5YDTlrcQBmk8
 QSUv1UwlY/VxbFrU8LrFJtreptqWJ4xmHc9UPQsK/a4Fl3EkNoU4yvn4gEWSXSVY7F8la
 D9m+dBedOhr+ge5FFWVOZmS4IXOe+tzktt6sxdm8rXS0KOWXYr20qswS3yChbpER0nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133915;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=s5NkNzyilgBOeCXI8Zh3eZOLjtQPp57GBN7vIEhp4Pk=;
 b=sAF7uhrtoIsDuEQVEfuo+6eBn4fS3mJ8w67L68LgAIDx1rSrX6qTSb4zE8UMAa2TTy/7
 3mHMmm7jNSIfTdEgS+E0GH6e+e4UhLK+o1QCcJt6NYbhFaPiY147qLLnm4MmU78847CmN
 vJ8WwyU+AGNpVKePy3Srwn0fNzu4xsBJm8wjT/fV4pqilnI+aDMOfqdnK2ta+4CC664+5
 z1Ei+FMtbm/C9bp5DuGJUUr2W7I4vXOd7QHZ+UxLo/0CYGbDVY1hvKiqXqQ5CvwX7ARse
 DqieuuFNDBUGQUDcSe8y+YICrSvpWpd5E51f2914Dw7mEniBRtFs0Z4/myParENeXoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=mT9bKMCg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=mT9bKMCg
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A84B812AB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133907; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kVxYQ+HeMu/Gbn+jmELdjTT2EMBAIcZd4oWg+K93s0b4F2yQBKYjcet5eseVmOd5b8zyeEAGEgskLuUVM06NPJqafIzDvYC4e4TS7Rtc5ULjBQxf/32FJYLIby3vEMfpQOgovoeGRn0nKUde5gauvNbq79dyJ/QhDyS7tCZf2To=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133907;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=s5NkNzyilgBOeCXI8Zh3eZOLjtQPp57GBN7vIEhp4Pk=; 
 b=IcLQ+cgOVCHHskpFLunXYXMAoGKYdCCCUUQytxml6OsmFflHRmNtRBi6Rz0rmqbek5aLOR+Wz/R8RREnDq/VOYUpxT0vN5IPYUwfq4yMfQopk6fRr1Q7S4wkoqWNImD6BqUKqoQKSnYZmXy5SfgXvnbjuHEVN1OWmNTVJsZE/84=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133907; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=s5NkNzyilgBOeCXI8Zh3eZOLjtQPp57GBN7vIEhp4Pk=;
 b=mT9bKMCgQpBsgt2LQKr9f324Fu1Nsb0u9PcT3pFnVy6mlg2tg/psg6qoGfW2AAZj
 Yv4NOESZe5iAY/5LalbmPZxXrKW7zc94Gjar6mBPaIn+zGUfZ/61z2kq+sG1gg8ifc3
 e9sZ1TDohVxDQJPuWXwOvyUv1wc5tY3zTAhaWUrk=
Received: by smtp.zohomail.com with SMTPS id 1792133905528266.7936228286661;
 Thu, 15 Oct 2026 23:58:25 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 15/20] board: emulation: Add qemu-loongarch
Date: Fri, 16 Oct 2026 06:54:55 +0000
Message-ID: <20261016065500.137544-16-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Yet another generic QEMU VIRT machine.

LoongArch QEMU splits the main RAM into two parts: the first 512M is
placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
U-Boot starts execution.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
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
2.55.0

