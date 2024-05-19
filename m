Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A396C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551A08869D;
	Sun, 19 May 2024 22:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="5b7v8q9p";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlrvwUa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D91888659; Sun, 19 May 2024 22:54:05 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA8E8818C
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 48F7913803B4;
 Sun, 19 May 2024 16:54:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 16:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152042;
 x=1716238442; bh=hX76wrhA45QBjzvZrkBfpablhEMo2q6ebCHjoIX/wws=; b=
 5b7v8q9pUmln0hR7wB6MLppFXYS5v5kkcNtXSYa1AZt0yikLoyOTBtbaHKqHi918
 p6toFAvVmrLieY0TEpCxFBsALi21JZwNt1Ek1kRVjPRYUKQseI9zuStFkTrwIPe2
 zEvFBdre+1sXV/NNOkIMhYxKAZ7xESS4H0vZD79V3veWeNdUApU0ugOhzzCZrp2R
 o1faZYmX35BJ1zA3/d3kIOb+T97MuGkzXUhQPSpPimYEiiTZ4UIQH5ThP3vafVpa
 ymDGLhl/YuUrZSBHND7IJbA3sS91Y6PKsH7yJND575M/VxDqt0ES+YXnxk7Jkmzk
 kxqbn+FAUeoqpVpE/7eQyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152042; x=
 1716238442; bh=hX76wrhA45QBjzvZrkBfpablhEMo2q6ebCHjoIX/wws=; b=H
 lrvwUa9JXVVssGpY6QFkW0+jAsxoCyOXLK1oegTIB5+6nayXOlNKPv4ZWPS7vdm0
 7Ix6K1DBFFeC+0Kp2OCwZrGe7jasWPYvMNI4ObPcVz2lUmmbxMDHPFAv5Ik2wbDY
 59GA0timPlIVDi/8OrgpcWbOGJhiefH0GEOijRaKpKsy1lKIVss4kHU/NEyNHPiX
 Qr+8LLLMONfrTnNeWtSAlqV11oqpiITjBQbO++TkKL8XOJvF5rtiITFvLvPw0jbY
 tmUfEbMZdEbNgnPIcGbV5aMkR8GwD4DQaUkgPTICR6aGsSz/GCvcpxz4yqmDTLZK
 teC8FyxfIzyqRLYFet2PA==
X-ME-Sender: <xms:6mZKZgbBihCv3yY13Ix1RFkgo693t9BfH67fQqRRr3jh7HUfZDwDXw>
 <xme:6mZKZrav_SHNi2F9-XZa6_xpUvO-eZxTFwHv9AFzW-MQXnp87Grt6MUFlbbzgZWi9
 N1HgLVTG-Dv9XJr1M0>
X-ME-Received: <xmr:6mZKZq-sCSxZoZCpcWpXn2ZHrCeZJdWdCSjjWp-K0_uE4rxopHoCY0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6mZKZqose6mqH86hRTQ7YAhj5Buf1LVdR_VUnFXNuO1qmzn7HYB-YQ>
 <xmx:6mZKZrqEjqilGn_VuHBH8PfB2MubR5-hHrAV26t8qj-LXDQv_iNBhQ>
 <xmx:6mZKZoQ7TPgUEDx3l65ABjc0R8c738WiiQA-nLhqK1PZh823RB5VRg>
 <xmx:6mZKZrqAO_733q4I3cuqFNQh5Rbi3MLZcuhVd5f4DK54bLlfcXRyqQ>
 <xmx:6mZKZsdz4qoeEAoqKvFhwc39eQtOmUY-CjHwKihcPnRVdhl1gtGDZ82y>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:54:01 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:56 +0100
Subject: [PATCH 09/10] board: emulation: New board qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-9-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6574;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=cI83RdYMgWaR2icvHaiom8xvTdL1zkEZSs57+7WVLBI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHu3g1d9n5GWbTL3ZMu/GdWLZ/5b8XCueOaKCkP7S
 xkCP/7qdZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEOhcx/K/+9GRXzvXpNUv2
 69ucMi+yZMg843dt3bG9S2oT8+vfR7gxMsz+9dqTxaBmU1qRRsrbucG2TtvubPcO5fn3+UWm1ob
 KAC4A
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
 arch/xtensa/Kconfig                       |  5 +++
 board/emulation/qemu-xtensa/Kconfig       | 41 +++++++++++++++++++++
 board/emulation/qemu-xtensa/MAINTAINERS   |  7 ++++
 board/emulation/qemu-xtensa/Makefile      |  5 +++
 board/emulation/qemu-xtensa/qemu-xtensa.c | 60 +++++++++++++++++++++++++++++++
 configs/qemu-xtensa-dc232b_defconfig      | 32 +++++++++++++++++
 include/configs/qemu-xtensa.h             | 34 ++++++++++++++++++
 7 files changed, 184 insertions(+)

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
diff --git a/board/emulation/qemu-xtensa/Kconfig b/board/emulation/qemu-xtensa/Kconfig
new file mode 100644
index 000000000000..df9142af0875
--- /dev/null
+++ b/board/emulation/qemu-xtensa/Kconfig
@@ -0,0 +1,41 @@
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
index 000000000000..851ef596f611
--- /dev/null
+++ b/board/emulation/qemu-xtensa/MAINTAINERS
@@ -0,0 +1,7 @@
+QEMU XTENSA 'VIRT' BOARD
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+S:	Maintained
+F:	board/emulation/qemu-xtensa/
+F:	board/emulation/common/
+F:	include/configs/qemu-riscv.h
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
index 000000000000..56e1cd40e1a6
--- /dev/null
+++ b/include/configs/qemu-xtensa.h
@@ -0,0 +1,34 @@
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
+#define CFG_SYS_IO_BASE		0xf0000000
+#else
+#define CFG_SYS_MEMORY_BASE		0x60000000
+#define CFG_SYS_IO_BASE		0x90000000
+#define CFG_MAX_MEM_MAPPED		0x10000000
+#endif
+
+#define CFG_SYS_SDRAM_SIZE		0x80000000
+#define CFG_SYS_SDRAM_BASE		MEMADDR(0x00000000)
+
+#if defined(CFG_MAX_MEM_MAPPED) && \
+	CFG_MAX_MEM_MAPPED < CFG_SYS_SDRAM_SIZE
+#define XTENSA_SYS_TEXT_ADDR		\
+	(MEMADDR(CFG_MAX_MEM_MAPPED) - CONFIG_SYS_MONITOR_LEN)
+#endif
+
+#endif /* __CONFIG_H */

-- 
2.43.0

