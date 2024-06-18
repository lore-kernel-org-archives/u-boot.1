Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C65C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B62882ED;
	Tue, 18 Jun 2024 15:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="SdDb5UxI";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Exkk4UaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5808C883E6; Tue, 18 Jun 2024 15:56:44 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512F08786C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 7FEAF1C00082;
 Tue, 18 Jun 2024 09:56:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 18 Jun 2024 09:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718999;
 x=1718805399; bh=VAUMymMY2x3tylpGEzIWTcmhysdFfKKMXFePXdSftYM=; b=
 SdDb5UxI+C9kosjbXdGBg62yj0SqrobP6cD2cLxy5AJ7TjnUb8Z5zLspNSIVWZEY
 YCFH6qgALUbFMSn7zz/xEMgclO9WDZGK5oALGs/SZlG8srlwH0ZdfQJDFc3aJ9h1
 hreM48/XDG+6X+i0jo5RDSHHnhpS/cqFQxKg8eD1gK4bYdA5GG/dOSMb7tr2qSd/
 en4WAfUO+WQUtRmuJYspvcnruKoKp1uUEUu9vucSiFiKZIyVW6FfMJUXxkc6gatK
 TYFXrUnb6iqa/j0ENDTpUt2Yk3459ai/PcyxN/ATwRrVj1Tm1+PXMVEA0G+5rNFV
 sbbPMrPRUQWtwZdXDENsmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718999; x=
 1718805399; bh=VAUMymMY2x3tylpGEzIWTcmhysdFfKKMXFePXdSftYM=; b=E
 xkk4UaKvOPuAWv+GUpIDUdDdtsbBWS8HZaB7hzibKWl1NoEI7q/j15brYjMVdx0j
 uq7tBpecz9GBAGphiLmBn6YSlDJ/ndqFfPNLdXOw/YMfjtXKNZdvJFkitBtXZCdL
 0Hos5zGPk5MgIdPMkRaEM9EEXzxhoI/Z0hIo+moyky9gAUUu8GwTPUrJ9S2nWeww
 dmWg40Y+bSDKLoT3uaKwBFmAvRoB6+N7XULnlcYP1cata6AKjUNqimU5XeXbE+yR
 bZR/PWWN/YNXc9ui+9+MEPbWhMg6C7APp6QQjfHAhCJ6L2cpP070NUNeYVAAqKha
 Vs6Bc5hJIXEsPl793P3yg==
X-ME-Sender: <xms:FpJxZqj77sYo002SDAcOH7Hv8uWKgsX_z5pWBhWnjkejZiKXpX2Itg>
 <xme:FpJxZrAysGA1BIBvhCUB7ygPPYa_SbkvJ8F4DFv25cRKNz4llm_L49tfPe5msioj4
 Bv3PV2tsk3P15WEQ7w>
X-ME-Received: <xmr:FpJxZiENMMolS2Lr6cSBb8kbXuA7lromgNzw3MqGL9yp2M4Gq8Iz6Yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:FpJxZjSpkD-qU2xhWi79YWoGmUAhC-qBkghQ1e9EI2z2pyIIiWNVqA>
 <xmx:F5JxZnyH0FhYCCPJtDMJbStrfDQ1hlbxVQUHIp_ydQfrWW1Frx6aNw>
 <xmx:F5JxZh60uRnQwoF-rDhilp4gBWG_wgBOV7P5CjSJtS7gMawoX4BNbg>
 <xmx:F5JxZkw2Kk6fKNRzpgcK_VxZRKl7IMjH-uI9Wy00TUvIx4YsNHzNXw>
 <xmx:F5JxZumaMhRD1ZWH9IIHQZNeiQ9chEjdI5pUnXO21IIEzegRggj1mg_9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:38 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:09 +0100
Subject: [PATCH v3 09/12] board: emulation: New board qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-9-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7626;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=iZgPgGCY1hVsEAiTzezufA0QMWeBULfI07KntSNYyt4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYx1n3LF+fcrPbzK+PmRhuzf6knCvgdvd+0Lu8TrH
 dyxKTmno5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbCl8DwP3MS/7nW2fLTCipZ
 QhmWZC01+n7Gqjoy5dVNqe81e5cmXmX4K3BRsv7Vn+N84rMthSZxFpYeidIpWfLp8bXMAxOPdAr
 zcgEA
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

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Fix maintainers entries
	- Refine address mapping for noMMU machine
	- Add a dtsi overlay to describe different memory size for noMMU system
v3:
	- Use dc233c as default CPU
---
 arch/xtensa/Kconfig                       |  5 +++
 arch/xtensa/dts/virt-u-boot.dtsi          | 17 +++++++++
 board/emulation/qemu-xtensa/Kconfig       | 43 ++++++++++++++++++++++
 board/emulation/qemu-xtensa/MAINTAINERS   |  8 +++++
 board/emulation/qemu-xtensa/Makefile      |  5 +++
 board/emulation/qemu-xtensa/qemu-xtensa.c | 60 +++++++++++++++++++++++++++++++
 configs/qemu-xtensa-dc233c_defconfig      | 32 +++++++++++++++++
 include/configs/qemu-xtensa.h             | 36 +++++++++++++++++++
 8 files changed, 206 insertions(+)

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
index 000000000000..8767b6fabbdb
--- /dev/null
+++ b/board/emulation/qemu-xtensa/Kconfig
@@ -0,0 +1,43 @@
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
+	imply CMD_PCI
+
+endif
diff --git a/board/emulation/qemu-xtensa/MAINTAINERS b/board/emulation/qemu-xtensa/MAINTAINERS
new file mode 100644
index 000000000000..6ffdfe85deeb
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
+F:	configs/qemu-xtensa-dc233c_defconfig
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
diff --git a/configs/qemu-xtensa-dc233c_defconfig b/configs/qemu-xtensa-dc233c_defconfig
new file mode 100644
index 000000000000..e6f40b37ed8e
--- /dev/null
+++ b/configs/qemu-xtensa-dc233c_defconfig
@@ -0,0 +1,32 @@
+CONFIG_XTENSA=y
+CONFIG_SYS_CPU="dc233c"
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

