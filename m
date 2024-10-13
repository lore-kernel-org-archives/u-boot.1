Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A3ECFC5E7
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B578288CB9;
	Mon, 14 Oct 2024 04:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYCZ9yIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936AA88F0C; Sun, 13 Oct 2024 16:32:47 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEC488F03
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c93109d09aso732620a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829958; x=1729434758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PP3uBKrwB6LeLWEVtJqwo0QoAbSZGB5qRarVT8R5TSY=;
 b=eYCZ9yIw5V2NaxHEuoVG97K+16/DmT9gu10qNKdetsch9qr3NQz5GMyCoc83smPKTp
 hqG8quw64cOj2kMVbIV2Yb5GAmB1Mtq8iKpwvf5nAkZfy6V6EjF/TngsuRo+WR+EPqn3
 Dcf+Q/ZX1PjfplsZJvCHirnZ9m+ARgpN0F7c/70dbgVFB0Re5pXL+9KgTdenpTh2dPPz
 8BTkhTOdkzVXfep/rh04TmsU3cDQykz+pVmnnGiYjas6IwwxTP+Hdsj3hgW0G/6LtYlS
 2WTvcNyiDAMunt2mUOiHGniJTyQU41fb9fSnAlBkqbJ+W5Zpt8EkBrSunidalFx0Eq5K
 i48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829958; x=1729434758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PP3uBKrwB6LeLWEVtJqwo0QoAbSZGB5qRarVT8R5TSY=;
 b=kYprSzGQx0B5LDXKIjq+iL/R8H6RQipxoMtWoDMGMpV0gNvQOOBNIz7v2CJ0vCWs7g
 WIs8sjWT0RL1Q74253tFNQ4aixa+/w0++Yi3aJ+L6CGErkHnOJ7gR/Uwu4R/29wgrngt
 9I0GzrK56I0J9hyfEUkfS3X+YHrh+ck9aDdpL0nnG1FbOjrWhz9z2UEhowxlsbAwOXhU
 PoGD0W4XAtEnZ76T9iUqHHZWwElJbWJg3i/kFlTKq1H+HiIrtpFe5ACLNH03w4ewcxjE
 qUGuGjLAe5coflH4BbGyZ1VFd9imgqfMHC50oZtiNza1AmKJAo7tMVevulwmJ/krLZZM
 3gvg==
X-Gm-Message-State: AOJu0YzucDXCtVXMhB597pBOTkXsL/ZjGLNgDobqNd2g5G3qObfOwST5
 dxk8P0tw9oUWRfiLz1gJBxmQjyLdoeOxaRcNO5uzJVMxDTLJDys9g3c0Yg==
X-Google-Smtp-Source: AGHT+IHrWRXkrZqlZTG6O6ghvjOaZUijgF5dUpDsc6T19mY3yS58UtoDICoPFFczEFgAZM0hHiLmqQ==
X-Received: by 2002:a17:906:f5a8:b0:a99:f76b:3d3 with SMTP id
 a640c23a62f3a-a99f76b05camr143450566b.12.1728829957393; 
 Sun, 13 Oct 2024 07:32:37 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:36 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
Date: Sun, 13 Oct 2024 14:32:24 +0000
Message-Id: <20241013143232.2090645-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

Introduce support for the Enclustra SoMs: Mercury+ AA1 (Intel/Arria10)

Cover general board files for SD/MMC and QSPI boot modes. Integrate the
boards to kconfig. All build variants will depend on Quartus handoff
files, thus they depend on the particular Quartus design. The approach is
covered in the according documentation part.

Additionally add configuration for SD/MMC boot and QSPI bootmodes. Register
additional targets in kconfig.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig                 |  9 ++
 board/enclustra/common/Makefile               |  4 +
 board/enclustra/mercury_aa1/Kconfig           | 15 ++++
 board/enclustra/mercury_aa1/MAINTAINERS       | 10 +++
 board/enclustra/mercury_aa1/fpga.its          | 32 +++++++
 .../socfpga_enclustra_mercury_aa1_defconfig   | 85 +++++++++++++++++++
 doc/board/enclustra/mercury-aa1.rst           |  8 +-
 include/configs/socfpga_mercury_aa1.h         | 33 +++++++
 8 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 board/enclustra/common/Makefile
 create mode 100644 board/enclustra/mercury_aa1/Kconfig
 create mode 100644 board/enclustra/mercury_aa1/MAINTAINERS
 create mode 100644 board/enclustra/mercury_aa1/fpga.its
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 include/configs/socfpga_mercury_aa1.h

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 6b6a162f56..b7de86e934 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -184,6 +184,10 @@ config TARGET_SOCFPGA_EBV_SOCRATES
 	bool "EBV SoCrates (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
 
+config TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+	bool "Enclustra Mercury+ AA1"
+	select TARGET_SOCFPGA_ARRIA10
+
 config TARGET_SOCFPGA_IS1
 	bool "IS1 (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
@@ -237,6 +241,7 @@ config SYS_BOARD
 	default "de10-standard" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "is1" if TARGET_SOCFPGA_IS1
 	default "mcvevk" if TARGET_SOCFPGA_ARIES_MCVEVK
+	default "mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 	default "n5x-socdk" if TARGET_SOCFPGA_N5X_SOCDK
 	default "secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "sockit" if TARGET_SOCFPGA_TERASIC_SOCKIT
@@ -256,6 +261,7 @@ config SYS_VENDOR
 	default "aries" if TARGET_SOCFPGA_ARIES_MCVEVK
 	default "devboards" if TARGET_SOCFPGA_DEVBOARDS_DBM_SOC1
 	default "ebv" if TARGET_SOCFPGA_EBV_SOCRATES
+	default "enclustra" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 	default "google" if TARGET_SOCFPGA_CHAMELEONV3
 	default "keymile" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "softing" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
@@ -283,6 +289,7 @@ config SYS_CONFIG_NAME
 	default "socfpga_de10_standard" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "socfpga_is1" if TARGET_SOCFPGA_IS1
 	default "socfpga_mcvevk" if TARGET_SOCFPGA_ARIES_MCVEVK
+	default "socfpga_mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 	default "socfpga_n5x_socdk" if TARGET_SOCFPGA_N5X_SOCDK
 	default "socfpga_sockit" if TARGET_SOCFPGA_TERASIC_SOCKIT
 	default "socfpga_socrates" if TARGET_SOCFPGA_EBV_SOCRATES
@@ -290,4 +297,6 @@ config SYS_CONFIG_NAME
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
+source "board/enclustra/mercury_aa1/Kconfig"
+
 endif
diff --git a/board/enclustra/common/Makefile b/board/enclustra/common/Makefile
new file mode 100644
index 0000000000..16c8531d74
--- /dev/null
+++ b/board/enclustra/common/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2024 Enclustra GmbH
+
+# Common for several Enclustra modules
diff --git a/board/enclustra/mercury_aa1/Kconfig b/board/enclustra/mercury_aa1/Kconfig
new file mode 100644
index 0000000000..40c7cb2687
--- /dev/null
+++ b/board/enclustra/mercury_aa1/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+
+config SYS_CPU
+	default "armv7"
+
+config SYS_BOARD
+	default "mercury_aa1"
+
+config SYS_VENDOR
+	default "enclustra"
+
+config SYS_CONFIG_NAME
+	default "socfpga_mercury_aa1"
+
+endif
diff --git a/board/enclustra/mercury_aa1/MAINTAINERS b/board/enclustra/mercury_aa1/MAINTAINERS
new file mode 100644
index 0000000000..80fcda639a
--- /dev/null
+++ b/board/enclustra/mercury_aa1/MAINTAINERS
@@ -0,0 +1,10 @@
+Enclustra Mercury+ AA1
+M:	Lothar Rubusch <l.rubusch@gmail.com>
+S:	Maintained
+F:	board/enclustra/mercury_aa1/
+F:	board/enclustra/common/
+F:	configs/socfpga_enclustra_mercury_aa1_defconfig
+F:	doc/board/enclustra/mercury-aa1.rst
+F:	include/configs/socfpga_mercury_aa1.h
+N:	enclustra
+N:	mercury_aa1
diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/mercury_aa1/fpga.its
new file mode 100644
index 0000000000..cb42d61fbd
--- /dev/null
+++ b/board/enclustra/mercury_aa1/fpga.its
@@ -0,0 +1,32 @@
+/dts-v1/;
+
+/ {
+	description = "FIT image with FPGA bistream";
+	#address-cells = <1>;
+
+	images {
+		fpga-periph-1 {
+			description = "FPGA peripheral bitstream";
+			data = /incbin/("../../../bitstream.periph.rbf");
+			type = "fpga";
+			arch = "arm";
+			compression = "none";
+		};
+
+		fpga-core-1 {
+			description = "FPGA core bitstream";
+			data = /incbin/("../../../bitstream.core.rbf");
+			type = "fpga";
+			arch = "arm";
+			compression = "none";
+		};
+	};
+
+	configurations {
+		default = "config-1";
+		config-1 {
+			description = "Boot with FPGA early IO release config";
+			fpga = "fpga-periph-1", "fpga-core-1";
+		};
+	};
+};
diff --git a/configs/socfpga_enclustra_mercury_aa1_defconfig b/configs/socfpga_enclustra_mercury_aa1_defconfig
new file mode 100644
index 0000000000..6a2434fe5a
--- /dev/null
+++ b/configs/socfpga_enclustra_mercury_aa1_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
+CONFIG_SF_DEFAULT_SPEED=10000000
+CONFIG_SF_DEFAULT_MODE=0x2003
+CONFIG_ENV_SIZE=0x80000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_enclustra_mercury_aa1"
+CONFIG_SPL_TEXT_BASE=0xFFE00000
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0xffe2b000
+CONFIG_TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1=y
+CONFIG_IDENT_STRING="socfpga_arria10"
+CONFIG_SPL_FS_FAT=y
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 rw rootwait root=/dev/mmcblk0p3"
+CONFIG_BOOTCOMMAND="run distro_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="system.dtb"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CLOCKS=y
+CONFIG_SPL_PAD_TO=0x40000
+CONFIG_SPL_NO_BSS_LIMIT=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xffe2b000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_FPGA=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
+# CONFIG_CMD_BOOTDEV is not set
+# CONFIG_CMD_BOOTMETH is not set
+# CONFIG_CMD_VBE is not set
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="boot.scr"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
+CONFIG_MMC_DW=y
+CONFIG_BOOTDEV_SPI_FLASH=y
+# CONFIG_SPI_FLASH_LOCK is not set
+# CONFIG_SPI_FLASH_UNLOCK_ALL is not set
+CONFIG_SPI_FLASH_SPANSION=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_USB=y
diff --git a/doc/board/enclustra/mercury-aa1.rst b/doc/board/enclustra/mercury-aa1.rst
index c4b3359220..6a96bf70e3 100644
--- a/doc/board/enclustra/mercury-aa1.rst
+++ b/doc/board/enclustra/mercury-aa1.rst
@@ -165,7 +165,7 @@ The demo shows booting a AA1 + ST1 setup and stopping at the u-boot shell.
 
 Here is the console output::
 
-  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)
+  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 27 2024 - 14:03:59 +0000)
   FPGA: Checking FPGA configuration setting ...
   FPGA: Start to program peripheral/full bitstream ...
   FPGA: Early Release Succeeded.
@@ -173,7 +173,7 @@ Here is the console output::
   FPGA: Start to program peripheral/full bitstream ...
   FPGA: Early Release Succeeded.
 
-  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)
+  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 27 2024 - 14:03:59 +0000)
   DDRCAL: Success
   DDRCAL: Scrubbing ECC RAM (2048 MiB).
   DDRCAL: Scrubbing ECC RAM done.
@@ -184,7 +184,7 @@ Here is the console output::
   Trying to boot from MMC1
 
 
-  U-Boot 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)socfpga_arria10
+  U-Boot 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 27 2024 - 14:03:59 +0000)socfpga_arria10
 
   CPU:   Altera SoCFPGA Arria 10
   BOOT:  SD/MMC External Transceiver (1.8V)
@@ -197,8 +197,6 @@ Here is the console output::
   Out:   serial
   Err:   serial
   Model: Enclustra Mercury+ AA1
-  ethaddr set to 20:B0:F7:06:0D:BE
-  eth1addr set to 20:B0:F7:06:0D:BF
   Net:   eth0: ethernet@ff800000
   =>
 
diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
new file mode 100644
index 0000000000..a5b63336e8
--- /dev/null
+++ b/include/configs/socfpga_mercury_aa1.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#ifndef __CONFIG_SOCFGPA_MERCURY_AA1_H__
+#define __CONFIG_SOCFGPA_MERCURY_AA1_H__
+
+#include <asm/arch/base_addr_a10.h>
+
+/*
+ * U-Boot general configurations
+ */
+
+/* Memory configurations  */
+#define PHYS_SDRAM_1_SIZE		0x80000000
+
+/*
+ * Serial / UART configurations
+ */
+#define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}
+
+/*
+ * L4 OSC1 Timer 0
+ */
+/* reload value when timer count to zero */
+#define TIMER_LOAD_VAL			0xFFFFFFFF
+
+/* The rest of the configuration is shared */
+#include <configs/socfpga_common.h>
+
+#endif	/* __CONFIG_SOCFGPA_MERCURY_AA1_H__ */
-- 
2.25.1

