Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F713C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 16:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D889D84AA4;
	Fri, 10 Jul 2026 18:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="CWNroy7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6448E84AAE; Fri, 10 Jul 2026 18:34:47 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D2184A92
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80e24970f1dso8654357b3.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783701283; x=1784306083; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BH+OZ/O57vkoZcjL+M+qC6PB2wz2tOvTGmeXo60Mkzw=;
 b=CWNroy7nTOPy+xavrFMb1atUqHQHOZa1dHjvF396ORIGOnixDBpJO5OlLJigpN4Uy4
 UUaXJMJdjrDeman2uAp4roj1rCzS4W9jIeEkpv09Ee5DDTQxXNr7BvRFYwJWc2gbVcLX
 Vibc5AXXLiQiavwCOgoZpPRlYfLjZajFIfd5iF3oPbNjQlDXHVCB3qpZmm0SIgxmfnHj
 tlKIikOxJ7F3eIhXBHn6EnZEUiQg7VeDIbpZ2KeMj6nUfQnU2NIGlhY9WSx8GI3Ja6ai
 MfZhpI/fchnzfegu90aaQpQAPG47QMp7bSKWADWiHoaII41uRB46jH9ebLiLxUNQrvpr
 PMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701283; x=1784306083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BH+OZ/O57vkoZcjL+M+qC6PB2wz2tOvTGmeXo60Mkzw=;
 b=fGMnGUmijQnAHiuQU6w1pDAGhxn2agHZMmySdvds/ltN38p7SbBEiBWbHL19EdUmKE
 gD9tvQWBpcwPJctXk4NIU4v+GIUyX3mMat+ZDNsh7ekHmg+WA6lXn+w5oqcBzLIitIsq
 m0ywiwK5YpNuDhbjjpBtTiMv1v4kdLrvxCvuJh+waA5W+CG8Xggmn0Pwjyt47ViQV8eS
 F1RszdKKeP2cnV+MSvk9Ex3zl9lAaoplS4eiJ8yIQ31iVPK/1pyFNJwTjdEaJVCWq1Cn
 Kfi/sdarOAK6seT15maU3OuCxRi6pCfRiL/IFjGfq2/IsvhhdtXMHAZEl6eycJ1O8dvN
 /hlw==
X-Gm-Message-State: AOJu0Yz1b1GaV6+OcQX0VS8X3X8nHzjiybYwwovOUicddHSO+gvDwwtd
 BfPr41dDYrRcluXZAzYuys66A5Vc44eMlsofCdgdX7XuCsq65ki6iba2/NMYbjFvMXI=
X-Gm-Gg: AfdE7ckDb1LK8f7Dc/BcoJVjflhWRL7Xbhk9hkN1+XgA6RMgfPagfCBLLvTrVC0R3ug
 ByusI7Ii2cyVx8Pkpqnra2aiuEeoHjtFrnLV8vVq7VdnrhyUuDIFA/a/CWBmTewYFWcUYo/9BG2
 hkxNorjD932vT7ttka23RAeQldBT+lBeNoRAV/d8F1l/gqaGV6/Xo3tRZ9/1Twfb6T9OxQDllJo
 nMxJoM3WOArmsLZYWeh/PTXhxz8YlGw4gKooc6BfE4Dd5zrmepuS8ZKMVgzO8BCpOxJaNC2wOvb
 nAzELA9m29Hj3SE528TovzxIY3eA/yfairudgUp8pfpz9suKwrNXtxnUNZsVHF5o6VIGR939bpX
 DEUdcm/vRIVLl5EcUvnzH2b1EL+NBnVeJ3KiSY0w2juSGcKSwaUt+C2nWzaNNGfxWjpRNAY5ur7
 xOOa+QEZwB67PnXTP58qzfhslAa5iJmdE2/PD/gwXSFnxFz3kH6FQolgQKiQ==
X-Received: by 2002:a05:690c:6083:b0:81e:6c2e:f114 with SMTP id
 00721157ae682-81e6c2ef51cmr63377457b3.30.1783701283355; 
 Fri, 10 Jul 2026 09:34:43 -0700 (PDT)
Received: from [192.168.0.219] ([2804:14c:4c5:9534::40b5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6c1ee792sm50007747b3.38.2026.07.10.09.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:34:42 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 10 Jul 2026 13:33:56 -0300
Subject: [PATCH 2/2] board: sophgo: add support for Milk-V Duo 256M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-add-milkv-duo256m-v1-2-0f761100361d@baylibre.com>
References: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
In-Reply-To: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
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

Add U-Boot support for Milk-V Duo 256M.

This board has a different SoC compared to the Milk-V Duo 64M, it uses
the Sophgo SG2002 instead of the Sophgo CV1800B. Both SoCs share many
common IP blocks, so this board reuses the existing cv1800b CPU support.

Link: https://milkv.io/docs/duo/getting-started/duo256m
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/Kconfig                             |  4 ++
 arch/riscv/dts/Makefile                        |  1 +
 arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 +++++++++++++++
 board/sophgo/milkv_duo_256m/Kconfig            | 30 ++++++++++
 board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
 board/sophgo/milkv_duo_256m/Makefile           |  6 ++
 board/sophgo/milkv_duo_256m/board.c            | 19 ++++++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
 configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
 doc/board/sophgo/index.rst                     |  1 +
 doc/board/sophgo/milkv_duo_256m.rst            | 82 ++++++++++++++++++++++++++
 include/configs/milkv_duo_256m.h               | 12 ++++
 12 files changed, 256 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6..8a285c32072 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MICROCHIP_GENERIC
 config TARGET_MILKV_DUO
 	bool "Support Milk-v Duo Board"
 
+config TARGET_MILKV_DUO_256M
+	bool "Support Milk-V Duo 256M Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -118,6 +121,7 @@ source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
+source "board/sophgo/milkv_duo_256m/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..c20b980b3af 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
+dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/sg2002-milkv-duo256m.dts b/arch/riscv/dts/sg2002-milkv-duo256m.dts
new file mode 100644
index 00000000000..4ad86ce39ec
--- /dev/null
+++ b/arch/riscv/dts/sg2002-milkv-duo256m.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Hiago De Franco <hfranco@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "sg2002.dtsi"
+
+/ {
+	model = "Milk-V Duo 256M";
+	compatible = "milkv,duo256m", "sophgo,sg2002";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	phy-mode = "rmii";
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/board/sophgo/milkv_duo_256m/Kconfig b/board/sophgo/milkv_duo_256m/Kconfig
new file mode 100644
index 00000000000..a443207f65e
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/Kconfig
@@ -0,0 +1,30 @@
+if TARGET_MILKV_DUO_256M
+
+config SYS_BOARD
+	default "milkv_duo_256m"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo_256m"
+
+# The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and loads
+# the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
+config TEXT_BASE
+	default 0x80200020
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/milkv_duo_256m/MAINTAINERS b/board/sophgo/milkv_duo_256m/MAINTAINERS
new file mode 100644
index 00000000000..929960e7251
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/MAINTAINERS
@@ -0,0 +1,5 @@
+Milk-V Duo 256M
+M:	Hiago De Franco <hfranco@baylibre.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo_256m/
+F:	configs/milkv_duo_256m_defconfig
diff --git a/board/sophgo/milkv_duo_256m/Makefile b/board/sophgo/milkv_duo_256m/Makefile
new file mode 100644
index 00000000000..2b3c84fe594
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+
+obj-y += board.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo_256m/board.c b/board/sophgo/milkv_duo_256m/board.c
new file mode 100644
index 00000000000..b8454e0a1e9
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/board.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ */
+
+#include <dm/lists.h>
+
+#include "../common/ethernet.h"
+
+int board_init(void)
+{
+	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
+		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
+
+	if (IS_ENABLED(CONFIG_NET_LEGACY))
+		cv1800b_ephy_init();
+
+	return 0;
+}
diff --git a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
new file mode 100644
index 00000000000..4c1e17b53ca
--- /dev/null
+++ b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x84000000
+fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+pxefile_addr_r=0x84300000
+ramdisk_addr_r=0x84400000
+scriptaddr=0x84200000
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
new file mode 100644
index 00000000000..9d92eec6394
--- /dev/null
+++ b/configs/milkv_duo_256m_defconfig
@@ -0,0 +1,42 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sg2002-milkv-duo256m"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING="milkv_duo_256m"
+CONFIG_TARGET_MILKV_DUO_256M=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_SD_BOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="milkv_duo_256m# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index 26dba4a4851..19c9a19b1d4 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -6,4 +6,5 @@ Sophgo
    :maxdepth: 1
 
    milkv_duo
+   milkv_duo_256m
    licheerv_nano
diff --git a/doc/board/sophgo/milkv_duo_256m.rst b/doc/board/sophgo/milkv_duo_256m.rst
new file mode 100644
index 00000000000..671f3a0b964
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo_256m.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo 256M
+===============
+
+SG2002 RISC-V SoC
+------------------
+The SG2002 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+The support for following drivers are already enabled:
+1. ns16550 UART Driver.
+2. Synopsys Designware MSHC Driver
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_256m_defconfig
+   make
+
+This will generate u-boot.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
+clock and load OpenSBI and the u-boot image, then bootup from it.
+
+To run u-boot.bin on top of FSBL, follow these steps:
+
+1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo 256M
+   default configuration.
+
+2. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
+   Use FDT_FW_PATH to point to sg2002-milkv-duo256m.dtb device tree file while
+   compiling fw_dynamic. Example:
+
+.. code-block:: console
+
+   cd open-sbi
+   PLATFORM=generic FW_FDT_PATH=../u-boot/arch/riscv/dts/sg2002-milkv-duo256m.dtb make
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
+   FSBL, OpenSBI, and U-Boot.
+   Note that you will have to use the file cv181x.bin as the FSBL.
+
+4. Place the generated fip.bin file into the FAT partition of the SD card.
+
+5. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fiptool
+
+Sample boot log from Milk-V 256M Duo board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+  U-Boot 2026.07-00002-g0b690770386f-dirty (Jul 07 2026 - 13:33:36 -0300)milkv_duo_256m
+
+  DRAM:  256 MiB
+  Core:  20 devices, 13 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - 0a:f3:23:40:7e:55
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo_256m#
diff --git a/include/configs/milkv_duo_256m.h b/include/configs/milkv_duo_256m.h
new file mode 100644
index 00000000000..4d6678b9c84
--- /dev/null
+++ b/include/configs/milkv_duo_256m.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif /* __CONFIG_H */

-- 
2.54.0

