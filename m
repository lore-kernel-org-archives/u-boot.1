Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E04C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73CA83045;
	Mon, 28 Jul 2025 10:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nzhnb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nzhnb-com.20200927.dkim.feishu.cn header.i=@nzhnb-com.20200927.dkim.feishu.cn header.b="tCdrXuwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B5F82F8E; Mon, 28 Jul 2025 10:26:15 +0200 (CEST)
Received: from lf-1-35.ptr.blmpb.com (lf-1-35.ptr.blmpb.com [103.149.242.35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A8082EB8
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 10:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nzhnb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhihong@nzhnb.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=nzhnb-com.20200927.dkim.feishu.cn; t=1753691155;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sUjAg43GQ7jrwKV81VWa0Zsx5wWuGy3A/uNQAkE/Vwk=;
 b=tCdrXuwP48bF3BXi8iY3nU7dZg0ahrACD1fEgAAxbd3Amtq9xXmXfadbd8pmINWj1a9S60
 dTowJEG9AjNWc7BvdOoUiXcoz6RLCOPVGvgAk5LxblSZdDITBgNKr3yKQRTvHX9NIygERm
 Iv3vRAD26y6UkTN6tEn9QIUA4uKisYKBBnEs0GvGWs8b/6C9K1W2HwC10t7K+0Xldya+oi
 Re+8O0SrOrgsGGiwG805rZS8ilkIpSSd9pB1G7uk6IfopT0dK9mJgwP5hW9URT93726EcN
 xq1KCyUQTNFjnC0k/A1t6Pb1Udhq+GDfoSL5fc0NCyx8B/J5t2VjT8iITtgi8w==
Content-Type: text/plain; charset=UTF-8
Message-Id: <20250728082547.454505-1-zhihong@nzhnb.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Received: from ubuntu.. ([101.52.204.106]) by smtp.feishu.cn with ESMTPS;
 Mon, 28 Jul 2025 16:25:52 +0800
To: <u-boot@lists.denx.de>
Subject: [PATCH] board: spacemit: Add SpacemiT MUSE Pi Pro
X-Mailer: git-send-email 2.45.2
X-Original-From: Niu Zhihong <zhihong@nzhnb.com>
From: "Niu Zhihong" <zhihong@nzhnb.com>
Date: Mon, 28 Jul 2025 16:25:47 +0800
X-Lms-Return-Path: <lba+268873411+5bf1a4+lists.denx.de+zhihong@nzhnb.com>
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

MUSE Pi Pro uses spacemit K1,
a new generation of octa-core 64-bit RISC-V processor,
which includes octa-core X60.

Features tested on a MUSE Pi Pro 16GB:
- SD-card boot
- eMMC boot

Signed-off-by: Niu Zhihong <zhihong@nzhnb.com>
---
 arch/riscv/Kconfig                     |  4 ++
 arch/riscv/dts/Makefile                |  1 +
 arch/riscv/dts/k1-muse-pi-pro.dts      | 27 ++++++++
 board/spacemit/muse-pi-pro/Kconfig     | 37 +++++++++++
 board/spacemit/muse-pi-pro/MAINTAINERS |  6 ++
 board/spacemit/muse-pi-pro/Makefile    |  3 +
 board/spacemit/muse-pi-pro/board.c     |  8 +++
 configs/muse-pi-pro_defconfig          |  6 ++
 doc/board/spacemit/index.rst           |  1 +
 doc/board/spacemit/muse-pi-pro.rst     | 85 ++++++++++++++++++++++++++
 include/configs/muse-pi-pro.h          | 11 ++++
 11 files changed, 189 insertions(+)
 create mode 100644 arch/riscv/dts/k1-muse-pi-pro.dts
 create mode 100644 board/spacemit/muse-pi-pro/Kconfig
 create mode 100644 board/spacemit/muse-pi-pro/MAINTAINERS
 create mode 100644 board/spacemit/muse-pi-pro/Makefile
 create mode 100644 board/spacemit/muse-pi-pro/board.c
 create mode 100644 configs/muse-pi-pro_defconfig
 create mode 100644 doc/board/spacemit/muse-pi-pro.rst
 create mode 100644 include/configs/muse-pi-pro.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c6feae5735..29430fe4d1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
 config TARGET_BANANAPI_F3
 	bool "Support BananaPi F3 Board"
 
+config TARGET_MUSE_PI_PRO
+	bool "Support MUSE Pi Pro Board"
+
 config TARGET_K230_CANMV
 	bool "Support K230 CanMV Board"
 
@@ -112,6 +115,7 @@ source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/bananapi-f3/Kconfig"
+source "board/spacemit/muse-pi-pro/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 2b10c2d6c01..f959f174f21 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,6 +2,7 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
+dtb-$(CONFIG_TARGET_MUSE_PI_PRO) += k1-muse-pi-pro.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
diff --git a/arch/riscv/dts/k1-muse-pi-pro.dts b/arch/riscv/dts/k1-muse-pi-pro.dts
new file mode 100644
index 00000000000..5e32d696b63
--- /dev/null
+++ b/arch/riscv/dts/k1-muse-pi-pro.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright The U-Boot Contributors
+ */
+
+#include "k1.dtsi"
+#include "binman.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "MUSE Pi Pro";
+	compatible = "muse-pi-pro", "spacemit,k1";
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x4 0x0>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
+	status = "okay";
+};
diff --git a/board/spacemit/muse-pi-pro/Kconfig b/board/spacemit/muse-pi-pro/Kconfig
new file mode 100644
index 00000000000..49a27154c22
--- /dev/null
+++ b/board/spacemit/muse-pi-pro/Kconfig
@@ -0,0 +1,37 @@
+if TARGET_MUSE_PI_PRO
+
+config SYS_BOARD
+	default "muse-pi-pro"
+
+config SYS_VENDOR
+	default "spacemit"
+
+config SYS_CPU
+	default "k1"
+
+config SYS_CONFIG_NAME
+	default "muse-pi-pro"
+
+config TEXT_BASE
+	default 0x200000
+
+config SYS_LOAD_ADDR
+	default 0x200000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x00000000
+
+config SYS_NS16550
+	def_bool y
+
+config HAS_CUSTOM_SYS_INIT_SP_ADDR
+	def_bool y
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x1000000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SPACEMIT_K1
+
+endif
diff --git a/board/spacemit/muse-pi-pro/MAINTAINERS b/board/spacemit/muse-pi-pro/MAINTAINERS
new file mode 100644
index 00000000000..671a231c88c
--- /dev/null
+++ b/board/spacemit/muse-pi-pro/MAINTAINERS
@@ -0,0 +1,6 @@
+MUSE Pi Pro
+M:	Niu Zhihong <zhihong@nzhnb.com>
+S:	Maintained
+F:	board/spacemit/muse-pi-pro/
+F:	configs/muse-pi-pro_defconfig
+F:	doc/board/spacemit/muse-pi-pro.rst
diff --git a/board/spacemit/muse-pi-pro/Makefile b/board/spacemit/muse-pi-pro/Makefile
new file mode 100644
index 00000000000..d4ee1504bbd
--- /dev/null
+++ b/board/spacemit/muse-pi-pro/Makefile
@@ -0,0 +1,3 @@
+# Copyright The U-Boot Contributors
+
+obj-y := board.o
diff --git a/board/spacemit/muse-pi-pro/board.c b/board/spacemit/muse-pi-pro/board.c
new file mode 100644
index 00000000000..599e20117e3
--- /dev/null
+++ b/board/spacemit/muse-pi-pro/board.c
@@ -0,0 +1,8 @@
+/*
+ * Copyright The U-Boot Contributors
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/muse-pi-pro_defconfig b/configs/muse-pi-pro_defconfig
new file mode 100644
index 00000000000..d35ddfa18be
--- /dev/null
+++ b/configs/muse-pi-pro_defconfig
@@ -0,0 +1,6 @@
+CONFIG_RISCV=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_TARGET_MUSE_PI_PRO=y
+CONFIG_DEFAULT_DEVICE_TREE="k1-muse-pi-pro"
+CONFIG_FIT=y
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index e7d3d94e459..fa24aaa84b4 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,4 +6,5 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   muse-pi-pro
 
diff --git a/doc/board/spacemit/muse-pi-pro.rst b/doc/board/spacemit/muse-pi-pro.rst
new file mode 100644
index 00000000000..4aa2eab5917
--- /dev/null
+++ b/doc/board/spacemit/muse-pi-pro.rst
@@ -0,0 +1,85 @@
+.. Copyright The U-Boot Contributors
+
+MUSE Pi Pro
+================
+
+Building
+~~~~~~~~
+
+1. Build OpenSBI
+
+   First, you need to build OpenSBI, which is required by U-Boot.
+   You can clone the OpenSBI repository and build it as follows:
+.. code-block:: console
+
+   export CROSS_COMPILE=riscv64-linux-gnu-
+   git clone https://gitee.com/bianbu-linux/opensbi.git
+   cd opensbi
+   make PLATFORM=generic
+
+
+2. Then build U-Boot as following:
+
+.. code-block:: console
+
+   cd u-boot
+   make muse-pi-pro_defconfig
+   make OPENSBI=opensbi/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate u-boot.itb
+
+Burning
+~~~~~~~
+To burn the U-Boot image to the MUSE Pi Pro board,
+you need to write the `u-boot.itb` file to the
+fourth partition of the SD card.
+
+You can use the `dd` command as follows:
+
+.. code-block:: console
+
+   dd if=u-boot.itb of=/dev/mmcblk0p4
+
+Booting
+~~~~~~~
+Sample boot log from Banana Pi BPI-F3 board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   sys: 0x200
+   try sd...
+   bm:3
+   j...
+
+   U-Boot SPL 2022.10spacemit-dirty (Apr 30 2025 - 05:48:50 +0000)
+   [   0.331] DDR type LPDDR4X
+   [   0.331] set ddr tx odt to 80ohm!
+   [   0.353] lpddr4_silicon_init consume 22ms
+   [   0.354] Change DDR data rate to 2400MT/s
+   [   0.503] ## Checking hash(es) for config conf-1 ... OK
+   [   0.505] ## Checking hash(es) for Image opensbi ... OK
+   [   0.511] ## Checking hash(es) for Image uboot ... OK
+   [   0.516] ## Checking hash(es) for Image fdt-1 ... OK
+   [   0.562] ## Checking hash(es) for config config_1 ... OK
+   [   0.564] ## Checking hash(es) for Image opensbi ... crc32+ OK
+
+
+   U-Boot 2025.07-00902-gf2f451d9d6d3-dirty (Jul 28 2025 - 14:38:51 +0800)
+
+   DRAM:  16 GiB
+   Core:  21 devices, 9 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@d4017000
+   Out:   serial@d4017000
+   Err:   serial@d4017000
+   Net:   No ethernet found.
+   => cpu list
+   0: cpu@0      spacemit,x60
+   1: cpu@1      spacemit,x60
+   2: cpu@2      spacemit,x60
+   3: cpu@3      spacemit,x60
+   4: cpu@4      spacemit,x60
+   5: cpu@5      spacemit,x60
+   6: cpu@6      spacemit,x60
+   7: cpu@7      spacemit,x60
+   => 
\ No newline at end of file
diff --git a/include/configs/muse-pi-pro.h b/include/configs/muse-pi-pro.h
new file mode 100644
index 00000000000..706dcc7f486
--- /dev/null
+++ b/include/configs/muse-pi-pro.h
@@ -0,0 +1,11 @@
+/*
+ * Copyright The U-Boot Contributors
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE         0x0
+#define CFG_SYS_NS16550_IER        0x40
+
+#endif /* __CONFIG_H */
-- 
2.45.2
