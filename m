Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE08D6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6315489621;
	Wed, 20 Nov 2024 01:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1v//UyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80AE88D7E; Tue, 19 Nov 2024 23:46:51 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F64788EEA
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43158124a54so4379545e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056409; x=1732661209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/EeGPd018YB4+Oc1qt/IsiIdPYECzj8/mJdz2JsbLE=;
 b=A1v//UyMDkg3oYH78pVKUkNtuQRK4Trj9bQj5iJls7WjpCuuUxsAJOFZagSMlNY1KQ
 kGwqqfdzbxpepU1O+tXoO0zvnuv71o/GevQq3cTSQEdpUsMFkNB1h3pt3pFZXG53g9tl
 xYtVpq2E4KRhHcakYRe4XVbmLU/B3qQRZXOhRf4F4zotVlR4bTx9bUE6O0CXOaVcrhfA
 gEB77/dt8NWKSYzGk57epFS1wvCFj+7SomGHCSwyPPuszKi5FzS+Abtf9+KrT3lzOcep
 1vWuYLiMPklmEz+kqNH8oUXUlCOaCh117AYOqUwZPFHKDkYDc76ejem3XCKRo7tL9Yt7
 U0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056409; x=1732661209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/EeGPd018YB4+Oc1qt/IsiIdPYECzj8/mJdz2JsbLE=;
 b=CjMz7wCUKJtlPm2jHhHRxGz8dbwahrPafsDrSwq20rvLD125vUafTWbT3t+fmBbsWQ
 2aqXamOnKEGVytdiyiOLTkzMPGZsfs+TT+CoCxaIyE/p5ogeRPoKoB6d1lwxwgvFYxbS
 84zUjyMqKl89bm6XTf2YPbsEQB87+/WbhhxdxsAcKUZmop1ICMcfpICxAjFiUgAFT5kY
 JuT0oRGRWUFlXAK9//BWdHT9voV7nxmaxffiWeGUb5aMs5OnQfLynmqD+rvmkbXvKVEO
 Z4xDLDGgLP2RjRbnf/oi2epEyGmoTUI8H3Bla1sKXLWbkrtt7W/weF3fhCQK3s3e89fq
 JZQA==
X-Gm-Message-State: AOJu0YwVMg7v2mV90awrUNSrz2IbBOnkq5cDBmjTQEDzcFDkZcfemw0t
 J5ulNgL4+EEmV1IdkmghbGV4FjP4Z4XhqedmcYu4kIMguDlE4HR7rSe0f4vv
X-Gm-Gg: ASbGncuo/ksmbn5BcsAFFWsm4rnkej3CeUWUcaybFSsjs2QvTjBcLgAtDYkdRLTy6vv
 CYCvc9uRpRbqZb8/2TAhs2rTCgxF4kWg/o8tkKjIhvjNGdSA9Gu3gVg/mZFunxdAbKaJoEoZBQB
 Dgh1EGNYqaQC3B4XRO679n8nnq+hkEXv/XofjYqgXcv7F1S/61xDjmPGqCUpRSG0nPayGgqHD4a
 vqK0sIgYMjf7uzzO4KBBroPy27dDwcIfFHD53FXKfVa5x7/vU7ROw81/cum5i+uI+mMYmbfVnEs
 +h3jKAnauvl3Cq9KAUDgVqd+Pm3M
X-Google-Smtp-Source: AGHT+IEszi42ga0k0ufnbHmPK8HUho2yk/RT2JMEvC70xlbLx6KBqkCLa0Xrc/DBg64Ao8os7HuE/A==
X-Received: by 2002:a05:600c:4fcf:b0:42c:aeee:e604 with SMTP id
 5b1f17b1804b1-4334f030467mr2216655e9.8.1732056408789; 
 Tue, 19 Nov 2024 14:46:48 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:48 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
Date: Tue, 19 Nov 2024 22:46:35 +0000
Message-Id: <20241119224643.27692-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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
2.39.2

