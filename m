Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB09D0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A975288FC7;
	Sat, 26 Oct 2024 18:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghOAkJp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5508901D; Sat, 26 Oct 2024 17:52:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4459788F68
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c93346dfc8so404478a12.3
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957949; x=1730562749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7TQEhl6j4yO+NSRkD7vSErHmqTvRuRWrYF3WrexbDw=;
 b=ghOAkJp0ybd25Qgwd+x8PJDZjVQpz2Yx37gIPfhzgziaxmTAVcJ4SR5Tlp48uNJil3
 jCAN5VePPSsLyNvnZ6amKn1kHhWJiXB8gZzsl8VNHSUAf5mwBxzsMuZNav7XAtPMQjjz
 oCJLMzyXqCSULfVOwobzHiICPijeyXKB+S+rwU+Ff/lc4d6T/C8e1+z8QydpuDqKXWwx
 p7MFhtBcDPOhcsSdPLLADh+wMvpKqBeWak+WapTQyHDaq68wRDvI0n5xdw0Kg3AY+ftJ
 chWjEdVQnaSRSC5HMoFX+/H5/dNzHqXdqZvI9QoJoQH9CowzZDVPK80MgcDffCUM5i4b
 iBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957949; x=1730562749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7TQEhl6j4yO+NSRkD7vSErHmqTvRuRWrYF3WrexbDw=;
 b=trE34lLiTWP/p3KeqSFW51H+2qQisqrKnTFWBPGDVPutV/+TIV69rjmMrKGbPP1c4R
 Ul7At8KHbxa/rnX2dnPu85K4wip/hK81CcnEjfPi2T86auebgJLMa+O02XkHY7D1aU0n
 namP5RH9J0UZUEZuntJJIdTSUbHj6s9USaLS6F+3KomWlwm8+WzNAuh5svUpdioj1hQz
 tL587pBZ60ZwlDLmcsP/MFC41qIVpWIJYw36Vyoq5IupFuhviRHhOyk5jvD3FewGcUf8
 lsnyzDjdWKOJhnrh18EVkBvzy4k1JZ35Sz1dCR35LNDq7yu2Sj2p/ADdPH63s9A+LkJD
 MNNQ==
X-Gm-Message-State: AOJu0Ywh6o29PtJMU1Sos0YTCRJTeC89xAMKGrxY30wMSrQ01D2RNxZ1
 dN13HOfh88J9c0WujfEekGEgKGOK7FN/sCELV1jEC3vFDb9VIEda8A1cPg==
X-Google-Smtp-Source: AGHT+IGi/Ha8DxKItOrJ4FFuxBdv+9ob60gZjwvHqmtfbv8k1oiqps9MMDAP3rTsTVj8iZ2xMp0ngw==
X-Received: by 2002:a05:6402:26d4:b0:5ca:d530:9663 with SMTP id
 4fb4d7f45d1cf-5cbbf91924fmr710868a12.4.1729957948355; 
 Sat, 26 Oct 2024 08:52:28 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:27 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 02/11] ARM: socfpga: add Mercury+ AA1 SoM support
Date: Sat, 26 Oct 2024 15:52:11 +0000
Message-Id: <20241026155220.26300-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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
 include/configs/socfpga_mercury_aa1.h         | 23 +++++
 7 files changed, 178 insertions(+)
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
index 0000000000..13baf949ab
--- /dev/null
+++ b/board/enclustra/mercury_aa1/MAINTAINERS
@@ -0,0 +1,10 @@
+Enclustra Mercury+ AA1
+M:	Lothar Rubusch <l.rubusch@gmail.com>
+S:	Maintained
+N:	board/enclustra/mercury_aa1/
+N:	board/enclustra/common/
+N:	configs/socfpga_enclustra_mercury_aa1_defconfig
+N:	doc/board/enclustra/mercury-aa1.rst
+N:	include/configs/socfpga_mercury_aa1.h
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
diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
new file mode 100644
index 0000000000..d9d169f6dd
--- /dev/null
+++ b/include/configs/socfpga_mercury_aa1.h
@@ -0,0 +1,23 @@
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
+/* The rest of the configuration is shared */
+#include <configs/socfpga_common.h>
+#include <config_distro_bootcmd.h>
+
+#endif	/* __CONFIG_SOCFGPA_MERCURY_AA1_H__ */
-- 
2.25.1

