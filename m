Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C055EC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 817B540BFA;
	Fri, 11 Sep 2026 10:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNynWUEu9Id1; Fri, 11 Sep 2026 10:48:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B7B040BF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123700;
	b=m+YVaWJ9fqsn9ipbTUOulYakAunGuDmUpBv+vgovyXWGu9ozFwlHyyYnX4jTCDo3F3nE
	 tBErogtLyLezW2h+myRGVoSCEZlef1utIhbwFD5OSLeCmIbV8rh5wghy+w+BqV3pxBNxZ
	 qbIlfz0lc/VkZKzKGmc3i6AlazS1VKGqIuOCcO9OisGAFyVx1zhpVmSUeeEcqj578mNRN
	 aNOLx6wZqcWVJlbV+FCcPOe3ErE3MhVXRJbkpi61NPm4Ent6puo8i16w0B3H5MWHKfdvx
	 Fauiky1ybsKr/6tdQI3tWInetoVLvQAq7/6/f1bVzhDmzNt48ju5oN/14+B8NSjKk2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a56w498iy0ReEtdxY6/sXgKHJGd+X7GoTx0Z7LuFtXk=;
	b=gNmCTS2fbs9lr3FrNKDqkbm3DCPfhLAnlzQ8hMAEm+3CpNL6r0kzVxXkViSH8hOrnuEm
	 2HlE+bplIpiVFvuxWnlkPJRSKFEukOw7W2ME9yB0Ht7eNFw5om44g2dBCJNEeges91+B3
	 qlUDD0pUVdNEhN8JvtnAJEfQhBcQNVV1We6GP3VaNum1t8XPf17XbdnD+rp42IH1m6WZu
	 6pkHGq8VnLRAjCdPtVy4A/CtCiCzBYTYwZ2QGA4EWKcJJZSIoKEKF/UKO67+WhXAlf17d
	 MvZQ2xtjUyh5R56v/6td1vQLBiDU4szxXZ/OHqdwrW+jVAKzywV6dLv90434pzsQhgQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ZFA4AAS1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123700;
	bh=a56w498iy0ReEtdxY6/sXgKHJGd+X7GoTx0Z7LuFtXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JqvY0pZfOAiWsZKPgTeBGxS+2hxQOiAHy/RoHYgnCUePXN+U8vrw7CMCjoiLf+Qf7
	 9Wqn0BKh0tSS/3/sjTsWxToGe/sbnifpuBmY2YcmRfH2VP2kHVsQ8P81uscw+6wKyF
	 QOm0jecJ97w9B/focq2EMJtcFTzcx3+RSkFPCPbrouTM9/b0/3NSmFHWce0EohwJpz
	 DxsRed+Irp/sYaJUCD7AkFKLijZ+jhMia/bbJ0C5b/lAD4Ej5WQeg8LEbtW5n9290Q
	 6PoIYYkpTayE7JwkKgpSS/teCVzTvogUJYsYJtVRZlHLJlarj6Y0PtaxI9dxm/+k3W
	 yXM0UfcTt4NOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B7B040BF8;
	Fri, 11 Sep 2026 10:48:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2BC81EA0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFDFB40B0B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICf1ahM7gf5Q for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A75E740BEC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123696;
 b=O+SO10V6BP+iBHtSe2U2ztIU2NoKRrm6pYto1kZRrHvE2JMVHLnd+cuHsV/uQX2LCHcy
 lgc3AWaXif2W/rSKIox9tUyL/b3YE5pBK9vMXNY/LV3VqSlUGFbbEvrKwRCbfq+E1DXfL
 Pr7M6xS3KlZeuIeGbHYSesm/8sH7GCl+hoCCWBaEFtUqsP9aVNY3Gw2FEd8AyPtcOvcEf
 Jba8kI2rDOfY7srfQaZKKnl+mkHLdNjQXjp6ueV1Tiq+jk/PlwsSjhkRXjnYdUBT2UG6S
 GOrB5r/LeUA/OIQp3YyZj38N9emIqR1hRoUp6jhUMvGFx/+GRjGQaCPrUR8IRuS6VpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123696;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=a56w498iy0ReEtdxY6/sXgKHJGd+X7GoTx0Z7LuFtXk=;
 b=BGvux7uxPE7MOM3UZr0yQ3cXXFepzNvqn+Q2JwMoJ8Ik+tCSZZzmz7u+XuiOXAZmyajc
 7FeoP6UzfvURo8GQyRKYWKHXb0fs+PX6tU55s2cCcKedjQX+V2KuY6xPfsjUqY68Hv3ti
 dvmEDH0vQ6L4iCDqBI2fBsMlhpPNJEWpP8HpbNMz1iUfH+YMsPRzZi/e00yuRgwJcQFX7
 O2lkk5oEtnKL/hO2esRsuO44LqPpbLyBBaiFLtEndeOaSTS7GDcf7Z5/Lqlm5hhcniS8n
 bvQ9PdLxwKomTSAa4dxocavVtqyv5bVv9y5A/uNDRVdzFLT0hN0PVSkXJIAGUT71ZLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ZFA4AAS1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=ZFA4AAS1
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A75E740BEC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123690; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GoR6kvdLGvMKxI7D2HwYN+meXLs5TJPZyNcH8ekghdad4/pPgkcPfqPRC54tLcn/EampvGqjdcxysCZqm5z3ezYm2CemAi1u+ci232qcMcbYewBn3cRfO8HtZBetTy857q/wjnosVV1bQbNqCqw7QZXBVQ3xJfQRsEsnZ4AOUCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123690;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a56w498iy0ReEtdxY6/sXgKHJGd+X7GoTx0Z7LuFtXk=; 
 b=kKEcjzuiRCOqeV0mEfU4gLW5BV/r/3elTozkjeutBNLVa7AB3Re7FtEd79ZgF0AdCtgs5aIVeSI7R2vr6IMEWWb5nfIytdMDE3WHO8TrNInWQdoja69TS8zmh4GSP0VC31pBa/+4aCkqALlWO2NedWjpHS4EkOh3u8g6Y/paA7Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123690; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=a56w498iy0ReEtdxY6/sXgKHJGd+X7GoTx0Z7LuFtXk=;
 b=ZFA4AAS13dsXBb82WqonopYY1ev2DXddWGd7DshQV8wshaYuTsozIUU7ck0PvYF3
 rfHFibGuRTgg5F6KUhHEtU1R5dRk/GEU7tBCBE68GpC249o/bj12BR3mGMnkdlODThF
 xESHCnP6a/VYC+5dyKaNUuNLmuaCwdFWkXk5mydQ=
Received: by mx.zohomail.com with SMTPS id 1789123688150446.04203165666627;
 Fri, 11 Sep 2026 03:48:08 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 14/19] board: emulation: Add qemu-loongarch
Date: Fri, 11 Sep 2026 10:45:59 +0000
Message-ID: <20260911104604.2910944-15-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

