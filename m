Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FD0C79FBD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141268367F;
	Fri, 16 Jan 2026 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="bAx3zk2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE428309A; Fri, 16 Jan 2026 15:04:21 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C64E80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 15:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4693da37b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1768572259; x=1800108259;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+IRkrdB3olBrCchSwGNFvBLnk2ZadVzwIL4z9OyDoSs=;
 b=bAx3zk2JqwiigCkGXsyLHOx2QBKXdoW9Z5S5LRcIqOSk0u71bEOUxYwB
 lZlauzpXHGYmrq8bJm+2hoJQl/lpDYJYUPzT5mCj/3JUGbjdaByiVH9cS
 KIvZZQicSQBnvYLMWWuwufUVe69QbWXEFn+AmRx6CgAsPyQkfj5vSKak6
 da2TI3e3UPZI7pmAUSDfU7OlDwxFRkzr4Imvygdt3xs6oPqpumxsIqsFS
 u48xsq1G/+ulfY0rGx2MMNq5cnMBNrsoCtAikzMan+SUm8fvsVUjX9889
 hehzvoKzN5a2d9OVcVR3Oy++wnZuFiILJ0YwZA6hFGG/Hydg+suKlrYB8 Q==;
X-CSE-ConnectionGUID: CRBGPlPGRy6gBOtQl30rpg==
X-CSE-MsgGUID: Fupb2zzWRK2XkpJlUVJuJQ==
X-IronPort-AV: E=Sophos;i="6.21,231,1763449200"; d="scan'208";a="51987742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Jan 2026 07:04:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Jan 2026 07:03:43 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Jan 2026 07:03:41 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>, Cyril Jean
 <cyril.jean@microchip.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2] riscv: Add support for BeagleV-Fire
Date: Fri, 16 Jan 2026 14:08:30 +0000
Message-ID: <20260116140830.1422571-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 16 Jan 2026 15:56:25 +0100
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

Bring U-Boot support for the BeagleV-Fire by adding a device tree and
supporting board files etc.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
v1 -> v2:
- add missing configs to defconfig
- reorder defconfig from `make savedefconfig`
- add missing implied configs to kconfig for target
---
 arch/riscv/Kconfig                       |   4 +
 board/beagle/beaglev_fire/Kconfig        |  43 +++++++++
 board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
 board/beagle/beaglev_fire/Makefile       |   6 ++
 board/beagle/beaglev_fire/beaglev_fire.c | 117 +++++++++++++++++++++++
 configs/beaglev_fire_defconfig           |  29 ++++++
 include/configs/beaglev_fire.h           |  57 +++++++++++
 7 files changed, 263 insertions(+)
 create mode 100644 board/beagle/beaglev_fire/Kconfig
 create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
 create mode 100644 board/beagle/beaglev_fire/Makefile
 create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
 create mode 100644 configs/beaglev_fire_defconfig
 create mode 100644 include/configs/beaglev_fire.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 79867656b15..ad7589123c6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -17,6 +17,9 @@ config TARGET_ANDES_VOYAGER
 config TARGET_BANANAPI_F3
 	bool "Support BananaPi F3 Board"
 
+config TARGET_BEAGLEBOARD_BEAGLEVFIRE
+	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
+
 config TARGET_K230_CANMV
 	bool "Support K230 CanMV Board"
 
@@ -106,6 +109,7 @@ config SPL_ZERO_MEM_BEFORE_USE
 source "board/andestech/ae350/Kconfig"
 source "board/andestech/voyager/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
+source "board/beagle/beaglev_fire/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_generic/Kconfig"
diff --git a/board/beagle/beaglev_fire/Kconfig b/board/beagle/beaglev_fire/Kconfig
new file mode 100644
index 00000000000..7a8ecac8703
--- /dev/null
+++ b/board/beagle/beaglev_fire/Kconfig
@@ -0,0 +1,43 @@
+if TARGET_BEAGLEBOARD_BEAGLEVFIRE
+
+config SYS_BOARD
+	default "beaglev_fire"
+
+config SYS_VENDOR
+	default "beagle"
+
+config SYS_CPU
+	default "mpfs"
+
+config SYS_CONFIG_NAME
+	default "beaglev_fire"
+
+config TEXT_BASE
+	default 0x80000000 if !RISCV_SMODE
+	default 0x80200000 if RISCV_SMODE
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select MICROCHIP_MPFS
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+	imply SMP
+	imply CMD_DHCP
+	imply CMD_EXT2
+	imply CMD_EXT4
+	imply CMD_FAT
+	imply CMD_FS_GENERIC
+	imply CMD_NET
+	imply CMD_PING
+	imply CMD_MMC
+	imply DOS_PARTITION
+	imply EFI_PARTITION
+	imply IP_DYN
+	imply ISO_PARTITION
+	imply PHY_LIB
+	imply PHY_VITESSE
+	imply DM_MAILBOX
+	imply MPFS_MBOX
+	imply MISC
+	imply MPFS_SYSCONTROLLER
+endif
diff --git a/board/beagle/beaglev_fire/MAINTAINERS b/board/beagle/beaglev_fire/MAINTAINERS
new file mode 100644
index 00000000000..a5dad93ee99
--- /dev/null
+++ b/board/beagle/beaglev_fire/MAINTAINERS
@@ -0,0 +1,7 @@
+BeagleBoard MPFS BeagleV-Fire
+M:	Cyril Jean <cyril.jean@microchip.com>
+M:	Jamie Gibbons <jamie.gibbons@microchip.com>
+S:	Maintained
+F:	board/beagle/beaglev_fire/
+F:	include/configs/beaglev_fire.h
+F:	configs/beaglev_fire_defconfig
\ No newline at end of file
diff --git a/board/beagle/beaglev_fire/Makefile b/board/beagle/beaglev_fire/Makefile
new file mode 100644
index 00000000000..a4109a8aad4
--- /dev/null
+++ b/board/beagle/beaglev_fire/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Microchip Technology Inc.
+#
+
+obj-y	+= beaglev_fire.o
\ No newline at end of file
diff --git a/board/beagle/beaglev_fire/beaglev_fire.c b/board/beagle/beaglev_fire/beaglev_fire.c
new file mode 100644
index 00000000000..b2f18c455b7
--- /dev/null
+++ b/board/beagle/beaglev_fire/beaglev_fire.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019-2023 Microchip Technology Inc.
+ */
+
+#include <dm.h>
+#include <dm/devres.h>
+#include <env.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/compat.h>
+#include <mpfs-mailbox.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define MPFS_SYSREG_SOFT_RESET	((unsigned int *)0x20002088)
+#define PERIPH_RESET_VALUE		0x800001e8u
+
+#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
+static unsigned char mac_addr[6];
+#endif
+
+int board_init(void)
+{
+	/* For now nothing to do here. */
+
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	unsigned int val;
+
+	/* Reset uart, mmc peripheral */
+	val = readl(MPFS_SYSREG_SOFT_RESET);
+	val = (val & ~(PERIPH_RESET_VALUE));
+	writel(val, MPFS_SYSREG_SOFT_RESET);
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
+	u32 ret;
+	int node;
+	u8 device_serial_number[16] = {0};
+	void *blob = (void *)gd->fdt_blob;
+	struct udevice *dev;
+	struct mpfs_sys_serv *sys_serv_priv;
+
+	ret = uclass_get_device_by_name(UCLASS_MISC, "syscontroller", &dev);
+	if (ret) {
+		debug("%s: system controller setup failed\n", __func__);
+		return ret;
+	}
+
+	sys_serv_priv = devm_kzalloc(dev, sizeof(*sys_serv_priv), GFP_KERNEL);
+	if (!sys_serv_priv)
+		return -ENOMEM;
+
+	sys_serv_priv->dev = dev;
+
+	sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
+	ret = IS_ERR(sys_serv_priv->sys_controller);
+	if (ret) {
+		debug("%s:  Failed to register system controller sub device ret=%d\n", __func__, ret);
+		return -ENODEV;
+	}
+
+	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
+	if (ret) {
+		printf("Cannot read device serial number\n");
+		return -EINVAL;
+	}
+
+	/* Update MAC address with device serial number */
+	mac_addr[0] = 0x00;
+	mac_addr[1] = 0x04;
+	mac_addr[2] = 0xA3;
+	mac_addr[3] = device_serial_number[2];
+	mac_addr[4] = device_serial_number[1];
+	mac_addr[5] = device_serial_number[0];
+
+	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
+	if (node >= 0) {
+		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
+		if (ret) {
+			printf("Error setting local-mac-address property for ethernet@20110000\n");
+			return -ENODEV;
+		}
+	}
+
+	mpfs_syscontroller_process_dtbo(sys_serv_priv);
+#endif
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
+	u32 ret;
+	int node;
+
+	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
+	if (node >= 0) {
+		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
+		if (ret) {
+			printf("Error setting local-mac-address property for ethernet@20110000\n");
+			return -ENODEV;
+		}
+	}
+#endif
+
+	return 0;
+}
\ No newline at end of file
diff --git a/configs/beaglev_fire_defconfig b/configs/beaglev_fire_defconfig
new file mode 100644
index 00000000000..9ebb08abbfe
--- /dev/null
+++ b/configs/beaglev_fire_defconfig
@@ -0,0 +1,29 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_F_LEN=0x2800
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-beaglev-fire"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_TARGET_BEAGLEBOARD_BEAGLEVFIRE=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="microchip/mpfs-beaglev-fire.dtb"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=282
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+CONFIG_SYS_PROMPT="RISC-V # "
+CONFIG_CMD_GPIO=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_BOOTP_SEND_HOSTNAME=y
+CONFIG_MPFS_GPIO=y
+CONFIG_MMC_SPI=y
+CONFIG_SYSRESET=y
diff --git a/include/configs/beaglev_fire.h b/include/configs/beaglev_fire.h
new file mode 100644
index 00000000000..e3ee0f02f2d
--- /dev/null
+++ b/include/configs/beaglev_fire.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Microchip Technology Inc.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_SDRAM_BASE       0x80000000
+
+/* Environment options */
+
+#if defined(CONFIG_CMD_DHCP)
+#define BOOT_TARGET_DEVICES_DHCP(func)	func(DHCP, dhcp, na)
+#else
+#define BOOT_TARGET_DEVICES_DHCP(func)
+#endif
+
+#if defined(CONFIG_CMD_MMC)
+#define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0)
+#else
+#define BOOT_TARGET_DEVICES_MMC(func)
+#endif
+
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_DEVICES_MMC(func)\
+	BOOT_TARGET_DEVICES_DHCP(func)
+
+#define BOOTENV_DESIGN_OVERLAYS \
+	"design_overlays=" \
+	"if test -n ${no_of_overlays}; then " \
+		"setenv inc 1; " \
+		"setenv idx 0; " \
+		"fdt resize ${dtbo_size}; " \
+		"while test $idx -ne ${no_of_overlays}; do " \
+			"setenv dtbo_name dtbo_image${idx}; " \
+			"setenv fdt_cmd \"fdt apply $\"$dtbo_name; " \
+			"run fdt_cmd; " \
+			"setexpr idx $inc + $idx; " \
+		"done; " \
+	"fi;\0 " \
+
+#include <config_distro_bootcmd.h>
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"bootm_size=0x10000000\0" \
+	"kernel_addr_r=0x80200000\0" \
+	"fdt_addr_r=0x8a000000\0" \
+	"fdtoverlay_addr_r=0x8a080000\0" \
+	"ramdisk_addr_r=0x8aa00000\0" \
+	"scriptaddr=0x8e000000\0" \
+	BOOTENV_DESIGN_OVERLAYS \
+	BOOTENV \
+
+#endif /* __CONFIG_H */
-- 
2.43.0

