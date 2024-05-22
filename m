Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C2C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B79888D2;
	Wed, 22 May 2024 19:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="jn6W7P2m";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEhVbyXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9568887C; Wed, 22 May 2024 19:08:23 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7438788856
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id A785A1C00150;
 Wed, 22 May 2024 13:08:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 22 May 2024 13:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397699;
 x=1716484099; bh=06PKCgSewSo5CFfqEKh9W6V6UFzRinZZgTCwdFXNNhc=; b=
 jn6W7P2mLFJmZSF7TEKVTVDfn4q7wYNJvyDBkNK+8FTeErI7Dggdr2KEM7LGgC0a
 uxWrjJXNecPRa6yYDIZ3SQpnOIsTy7LSWRdutiw7K+V6H0TMtOXMuP6Yu/nsDUTX
 kpl+HXkxFu3dnkAnsbI2HLiYltdponCPvA+wgnZvRrlbeDWzpEplqrAMvrINce3W
 emhr/JG5WLyTLztM74g2kvg7MnztVlXYy6FhocWKprOCaAJdu7SG0JLqWNL8KPsj
 KS3dFvu7plfkDwSEmIHp+d3xCn+/aQtn8Kzj7t3BHyCUBi8pFNGkCO3AXedaUCUQ
 HLeYqJ90uPhTcTg+hACgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397699; x=
 1716484099; bh=06PKCgSewSo5CFfqEKh9W6V6UFzRinZZgTCwdFXNNhc=; b=I
 EhVbyXDvHR3eql2kwss588+z7MAz2hgP/2k625/4XFzJus7yuetNJ1dz2rVPREv2
 /P31CJIvrnYW4fRYPzWb2VQRMF/0CkNTA+IB3xN5bMsN/m67seecjm09h+sr1QMz
 Blfj1i3N4Sg5HF5OrFQM48zbav9o+Qt+N5iWBmYJCLQM1e8UmZniI1yccRJVPNMt
 3hjcr29NTx/EZnjgnP6qjnc8XZS00DSDLD05xH36dVP3pnwcLMX4fWYAZkzOeQJO
 LUu2HrttvRUtNiJM3SY3bRqfaSKx9j6jA4ghTztUBNtoMuDPnsEq32VlYvtkNRdB
 6Dw5WhqLT75E3dqOgIzyg==
X-ME-Sender: <xms:gyZOZnrD-8plnn5dP2yoBdZfzfHuU6de7zXCoXZBmjILA4vBx6_GYA>
 <xme:gyZOZhrzP-diBcvBfbe1cV3cIBEz-t_abNAJpRZTmiqEuArk2j5aRmcqUC5kyMCc6
 x2-tsxIolkR8eTIaXQ>
X-ME-Received: <xmr:gyZOZkM2_IljTKgy361R2qm1OAxVqHMIL6iNH9ZaLObKQUhQqqRK05U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:gyZOZq64yr1e8G3ZUnjIRct_OsTHJ7MN994thzl5dRFlHbBojish4g>
 <xmx:gyZOZm666FHsGjATieFahl5V6xH8i8E3E5mnWxfm9x6_hQ8OIxZbYA>
 <xmx:gyZOZijR5Ln49g_OXRfZS16Nx6xDe4fPdlsS0ng0GCtOQBNDsuOCxQ>
 <xmx:gyZOZo6P1K0X42A0074oHCV7VOGrzEFIHOW3Fj7WanMoljtjVlAp0A>
 <xmx:gyZOZjv7KIAR1MJtkyuhqPCTqHl4DnG3KoHrH61JQdxkqKefr8gq1LFm>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:05 +0100
Subject: [PATCH v2 09/10] board: emulation: New board qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-9-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7528;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=jC27FyUbAEjOkym7C7vF65x3YEYxGZj7OBkelH5waSk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tfxzs8TYThW7exuzzdQr43DicvE5WR6uyHFnruxi2
 VNvVr3uKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlsusbwV5hj/+Pk5q87HQI2
 Lquy9CvL2Rnxi7Xrql3Zk08VPP8KJRkZurX8l/wOepba0cuTckTx/awXaU92x+3wXCGbEBvV5v6
 PFwA=
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

Introduce the new board, define every bits.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Fix maintainers entries
	- Refine address mapping for noMMU machine
	- Add a dtsi overlay to describe different memory size for noMMU system
---
 arch/xtensa/Kconfig                       |  5 +++
 arch/xtensa/dts/virt-u-boot.dtsi          | 17 +++++++++
 board/emulation/qemu-xtensa/Kconfig       | 42 ++++++++++++++++++++++
 board/emulation/qemu-xtensa/MAINTAINERS   |  8 +++++
 board/emulation/qemu-xtensa/Makefile      |  5 +++
 board/emulation/qemu-xtensa/qemu-xtensa.c | 60 +++++++++++++++++++++++++++++++
 configs/qemu-xtensa-dc232b_defconfig      | 32 +++++++++++++++++
 include/configs/qemu-xtensa.h             | 36 +++++++++++++++++++
 8 files changed, 205 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 4afd56bca095..70eebb4bd22f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -15,6 +15,10 @@ config TARGET_XTFPGA
 	bool "Support XTFPGA"
 	select BOARD_POSTCLK_INIT
 
+config TARGET_QEMU_XTENSA
+	bool "Support QEMU Xtensa Virt Board"
+	select BOARD_LATE_INIT
+
 endchoice
 
 config SYS_ICACHE_OFF
@@ -69,5 +73,6 @@ config XTENSA_SIMCALL_GDBIO
 endchoice
 
 source "board/cadence/xtfpga/Kconfig"
+source "board/emulation/qemu-xtensa/Kconfig"
 
 endmenu
diff --git a/arch/xtensa/dts/virt-u-boot.dtsi b/arch/xtensa/dts/virt-u-boot.dtsi
new file mode 100644
index 000000000000..22b4683e7617
--- /dev/null
+++ b/arch/xtensa/dts/virt-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <config.h>
+
+/ {
+	memory@0 {
+		device_type = "memory";
+#if XCHAL_HAVE_PTP_MMU
+		reg = <0x00000000 CFG_SYS_SDRAM_SIZE>;
+#else
+		reg = <CFG_SYS_MEMORY_BASE CFG_SYS_SDRAM_SIZE>;
+#endif
+	};
+};
diff --git a/board/emulation/qemu-xtensa/Kconfig b/board/emulation/qemu-xtensa/Kconfig
new file mode 100644
index 000000000000..7e2575461be3
--- /dev/null
+++ b/board/emulation/qemu-xtensa/Kconfig
@@ -0,0 +1,42 @@
+if TARGET_QEMU_XTENSA
+
+config SYS_BOARD
+	default "qemu-xtensa"
+
+config SYS_VENDOR
+	default "emulation"
+
+config SYS_CONFIG_NAME
+	default "qemu-xtensa"
+
+config TEXT_BASE
+	default 0x50000000 if (SYS_CPU = de212)
+	default 0xfe000000
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select BOARD_EARLY_INIT_F
+	select DM
+	select CPU
+	select CPU_XTENSA
+	select CLK
+	select DM_SERIAL
+	select XTENSA_SEMIHOSTING
+	select XTENSA_SEMIHOSTING_SERIAL
+	imply BLK
+	imply VIRTIO
+	imply VIRTIO_PCI
+	imply VIRTIO_NET
+	imply VIRTIO_BLK
+	imply E1000
+	imply PCI
+	imply PCI_INIT_R
+	imply NVME_PCI
+	imply PCIE_ECAM_GENERIC
+	imply SCSI
+	imply REMAKE_ELF
+	select OF_CONTROL
+	select OF_UPSTREAM
+	imply CMD_DM
+
+endif
diff --git a/board/emulation/qemu-xtensa/MAINTAINERS b/board/emulation/qemu-xtensa/MAINTAINERS
new file mode 100644
index 000000000000..829c27f86369
--- /dev/null
+++ b/board/emulation/qemu-xtensa/MAINTAINERS
@@ -0,0 +1,8 @@
+QEMU XTENSA 'VIRT' BOARD
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Max Filippov <jcmvbkbc@gmail.com>
+S:	Maintained
+F:	board/emulation/qemu-xtensa/
+F:	board/emulation/common/
+F:	include/configs/qemu-xtensa.h
+F:	configs/qemu-xtensa-dc232b_defconfig
diff --git a/board/emulation/qemu-xtensa/Makefile b/board/emulation/qemu-xtensa/Makefile
new file mode 100644
index 000000000000..0f33a65f6c6b
--- /dev/null
+++ b/board/emulation/qemu-xtensa/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+obj-y	+= qemu-xtensa.o
diff --git a/board/emulation/qemu-xtensa/qemu-xtensa.c b/board/emulation/qemu-xtensa/qemu-xtensa.c
new file mode 100644
index 000000000000..0ca83341c25c
--- /dev/null
+++ b/board/emulation/qemu-xtensa/qemu-xtensa.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <dm.h>
+#include <cpu.h>
+#include <log.h>
+#include <init.h>
+#include <usb.h>
+#include <virtio_types.h>
+#include <virtio.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	return 0;
+}
+
+unsigned long get_board_sys_clk(void)
+{
+	return gd->cpu_clk ? gd->cpu_clk : 40000000;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int board_early_init_f(void)
+{
+	struct cpu_plat *cpu_plat;
+	struct udevice *cpu = cpu_get_current_dev();
+
+	if (!cpu)
+		return -ENODEV;
+
+	cpu_plat = dev_get_parent_plat(cpu);
+	if (!cpu_plat)
+		return -ENODEV;
+
+	gd->cpu_clk = cpu_plat->timebase_freq;
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
diff --git a/configs/qemu-xtensa-dc232b_defconfig b/configs/qemu-xtensa-dc232b_defconfig
new file mode 100644
index 000000000000..12d5ca9399ae
--- /dev/null
+++ b/configs/qemu-xtensa-dc232b_defconfig
@@ -0,0 +1,32 @@
+CONFIG_XTENSA=y
+CONFIG_SYS_CPU="dc232b"
+CONFIG_SYS_MALLOC_LEN=0x40000
+CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="virt"
+CONFIG_SYS_MONITOR_LEN=262144
+CONFIG_SYS_LOAD_ADDR=0x02000000
+CONFIG_TARGET_QEMU_XTENSA=y
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_BASE=0xF6000000
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_SHOW_BOOT_PROGRESS=y
+CONFIG_BOOTDELAY=10
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press <SPACE> to stop\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_ASKENV=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MX_CYCLIC=y
+CONFIG_CMD_SAVES=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_DIAG=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="uImage"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_SYSRESET=y
diff --git a/include/configs/qemu-xtensa.h b/include/configs/qemu-xtensa.h
new file mode 100644
index 000000000000..505aa0646bc9
--- /dev/null
+++ b/include/configs/qemu-xtensa.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2007-2013 Tensilica, Inc.
+ * Copyright (C) 2014 - 2016 Cadence Design Systems Inc.
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <asm/arch/core.h>
+#include <asm/addrspace.h>
+#include <asm/config.h>
+
+#if XCHAL_HAVE_PTP_MMU
+#define CFG_SYS_MEMORY_BASE		\
+	(XCHAL_VECBASE_RESET_VADDR - XCHAL_VECBASE_RESET_PADDR)
+#define CFG_SYS_IO_BASE			0xf0000000
+#define CFG_SYS_SDRAM_SIZE		0x80000000 /* xtensa.sysram0 */
+#else
+#define CFG_SYS_MEMORY_BASE		0x60000000
+#define CFG_SYS_SDRAM_SIZE		0x08000000 /* xtensa.sysram0 */
+#endif
+
+#define CFG_SYS_SDRAM_BASE		MEMADDR(0x00000000)
+
+#if defined(CFG_MAX_MEM_MAPPED) && \
+	CFG_MAX_MEM_MAPPED < CFG_SYS_SDRAM_SIZE
+#define XTENSA_SYS_TEXT_ADDR		\
+	(MEMADDR(CFG_MAX_MEM_MAPPED) - CONFIG_SYS_MONITOR_LEN)
+#else
+#define XTENSA_SYS_TEXT_ADDR		\
+	(MEMADDR(CFG_SYS_SDRAM_SIZE) - CONFIG_SYS_MONITOR_LEN)
+#endif
+
+#endif /* __CONFIG_H */

-- 
2.43.0

