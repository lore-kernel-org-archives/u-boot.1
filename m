Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96013C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B48688B3B;
	Thu, 18 Jul 2024 19:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hc4japT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A74288B2D; Thu, 18 Jul 2024 19:36:41 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE93388AD2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ea34ffcdaso701169e87.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324196; x=1721928996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Y6OCJJ31inXQ4d5zLAq4sw2D62if2+fI5JlaVjxzrY=;
 b=Hc4japT8ZOSwv+W9BYQihF7k75n8w7vxBlhE5Diy74Gh478mt23C8p0RER0tP1isJt
 YA0hiAQTtWYbfW9qOslejIKpNBhaAUFV8Wd2ZLK70rDsBCP1JkBJSxcmraI8wY2o5xby
 pyW0sBRA+HO7DKf6O/79pb5rBfskRoNVx0iU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324196; x=1721928996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Y6OCJJ31inXQ4d5zLAq4sw2D62if2+fI5JlaVjxzrY=;
 b=vl7sPlwQg48VMotQwRz1WS8Es+x4GOX54jiFwvydPmzd8vd1wzhPu+9btLCg9+ZjDy
 gkZe8i2sIgFReWsgGQ7UDGd9TuPyv5vAJ4VHUqDQuhnbWkQGQM9GFF30to3kNhHaKCW/
 zGDEScAArWbJSRzS6zsRkXQlgMji1yCEWyKK1TyHgQIpMPFRqNZrI7kP7qzunHA3I1LT
 IqeUq1BkGFrKus5BO+wIOkw68Ca5D4M90tkSkClf9JrP4FsmDvTtnZTc03y8A6XPMvHp
 9gauuZr+tmhOOIhpdshha/nWjrPB7mayq+zgQcNNRy4WXN3y8eC08gJk3/fTrhY7t7W+
 aasA==
X-Gm-Message-State: AOJu0YzcHcD4K5rdb6CX66GjzL68ZvOwsCPKDenkOE385wQwM4zo9eJx
 WD3D59SDnyt21yeXNTMTLASRFwGB5S5/05JHQusuXa+/FfxIzoF7whkilJ344FWNcOv/c56n9l8
 =
X-Google-Smtp-Source: AGHT+IFptEqkkf1VxFfE+6MfjGrh2MisV4tpjvgR9ghkh2AnPXzEAZ9aKwhln2PfrrbbbaElNqdyGA==
X-Received: by 2002:a05:6512:2211:b0:52c:e030:144e with SMTP id
 2adb3069b0e04-52ee54466a8mr4041613e87.47.1721324195565; 
 Thu, 18 Jul 2024 10:36:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitacienergy.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 01/20] arm: Remove pg_wcom boards
Date: Thu, 18 Jul 2024 18:35:52 +0100
Message-Id: <20240718173611.4014274-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These board has not been converted to CONFIG_DM_I2C by the deadline:

   pg_wcom_expu1
   pg_wcom_expu1_update
   pg_wcom_seli8
   pg_wcom_seli8_update

Remove them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/ls1021a-pg-wcom-expu1.dts        | 141 -----------
 arch/arm/dts/ls1021a-pg-wcom-seli8.dts        | 124 ----------
 board/keymile/Kconfig                         |   1 -
 board/keymile/pg-wcom-ls102xa/Kconfig         |  39 ----
 board/keymile/pg-wcom-ls102xa/MAINTAINERS     |  16 --
 board/keymile/pg-wcom-ls102xa/Makefile        |  11 -
 board/keymile/pg-wcom-ls102xa/ddr.c           |  91 --------
 .../keymile/pg-wcom-ls102xa/pg-wcom-expu1.env |   3 -
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 218 ------------------
 .../keymile/pg-wcom-ls102xa/pg-wcom-seli8.env |   3 -
 configs/pg_wcom_expu1_defconfig               | 109 ---------
 configs/pg_wcom_expu1_update_defconfig        | 107 ---------
 configs/pg_wcom_seli8_defconfig               | 109 ---------
 configs/pg_wcom_seli8_update_defconfig        | 107 ---------
 include/configs/km/pg-wcom-ls102xa.h          | 167 --------------
 include/configs/pg-wcom-expu1.h               |  49 ----
 include/configs/pg-wcom-seli8.h               |  40 ----
 17 files changed, 1335 deletions(-)
 delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-expu1.dts
 delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-seli8.dts
 delete mode 100644 board/keymile/pg-wcom-ls102xa/Kconfig
 delete mode 100644 board/keymile/pg-wcom-ls102xa/MAINTAINERS
 delete mode 100644 board/keymile/pg-wcom-ls102xa/Makefile
 delete mode 100644 board/keymile/pg-wcom-ls102xa/ddr.c
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
 delete mode 100644 configs/pg_wcom_expu1_defconfig
 delete mode 100644 configs/pg_wcom_expu1_update_defconfig
 delete mode 100644 configs/pg_wcom_seli8_defconfig
 delete mode 100644 configs/pg_wcom_seli8_update_defconfig
 delete mode 100644 include/configs/km/pg-wcom-ls102xa.h
 delete mode 100644 include/configs/pg-wcom-expu1.h
 delete mode 100644 include/configs/pg-wcom-seli8.h

diff --git a/arch/arm/dts/ls1021a-pg-wcom-expu1.dts b/arch/arm/dts/ls1021a-pg-wcom-expu1.dts
deleted file mode 100644
index ec8e7dee271..00000000000
--- a/arch/arm/dts/ls1021a-pg-wcom-expu1.dts
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Hitachi ABB Power Grids EXPU1 board device tree source
- *
- * Copyright 2020 Hitachi ABB Power Grids
- *
- * Copyright 2013-2015 Freescale Semiconductor, Inc.
- */
-
-/dts-v1/;
-#include "ls1021a.dtsi"
-
-/ {
-	model = "EXPU1 Service Unit for XMC and FOX";
-
-	aliases {
-		enet2-rgmii-debug-phy = &debug_phy;
-	};
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&enet0 {
-	status = "okay";
-	tbi-handle = <&tbi0>;
-	phy-connection-type = "sgmii";
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
-};
-
-&enet1 {
-	status = "okay";
-	tbi-handle = <&tbi1>;
-	phy-connection-type = "sgmii";
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
-};
-
-&enet2 {
-	phy-handle = <&debug_phy>;
-	phy-connection-type = "rgmii-id";
-	max-speed = <100>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&dspi1 {
-	bus-num = <0>;
-	status = "okay";
-	zl30343@0 {
-		compatible = "gen,spidev", "zarlink,zl30343";
-		reg = <0>;
-		spi-max-frequency = <8000000>;
-	};
-};
-
-&ifc {
-	#address-cells = <2>;
-	#size-cells = <1>;
-	/* NOR Flash on board */
-	ranges = <0x0 0x0 0x60000000 0x04000000>;
-	status = "okay";
-
-	nor@0,0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "cfi-flash";
-		reg = <0x0 0x0 0x4000000>;
-		bank-width = <2>;
-		device-width = <1>;
-
-		partition@0 {
-			label = "rcw";
-			reg = <0x0 0x20000>;
-			read-only;
-		};
-		partition@20000 {
-			label = "qe";
-			reg = <0x20000 0x20000>;
-		};
-		partition@40000 {
-			label = "envred";
-			reg = <0x40000 0x20000>;
-		};
-		partition@60000 {
-			label = "env";
-			reg = <0x60000 0x20000>;
-		};
-		partition@100000 {
-			label = "u-boot";
-			reg = <0x100000 0x100000>;
-		};
-		partition@200000 {
-			label = "redenvred";
-			reg = <0x200000 0x20000>;
-		};
-		partition@220000 {
-			label = "redenv";
-			reg = <0x220000 0x20000>;
-		};
-		partition@240000 {
-			label = "redu-boot";
-			reg = <0x240000 0x100000>;
-		};
-		partition@340000 {
-			label = "ubi0";
-			reg = <0x340000 0x03C00000>;
-		};
-	};
-};
-
-&mdio0 {
-	debug_phy: ethernet-phy@11 {
-		reg = <0x11>;
-	};
-
-	tbi0: tbi-phy@0xb {
-		reg = <0xb>;
-		device_type = "tbi-phy";
-	};
-};
-
-&mdio1 {
-	tbi1: tbi-phy@0xd {
-		reg = <0xd>;
-		device_type = "tbi-phy";
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/ls1021a-pg-wcom-seli8.dts b/arch/arm/dts/ls1021a-pg-wcom-seli8.dts
deleted file mode 100644
index 03ce3ab4e47..00000000000
--- a/arch/arm/dts/ls1021a-pg-wcom-seli8.dts
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013-2015 Freescale Semiconductor, Inc.
- * Copyright 2020 Hitachi Power Grids. All rights reserved.
- */
-
-/dts-v1/;
-#include "ls1021a.dtsi"
-
-/ {
-	model = "Hitachi-Powergrids SELI8 Service Unit for XMC and FOX";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&enet0 {
-	status = "okay";
-	tbi-handle = <&tbi0>;
-	phy-connection-type = "sgmii";
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
-};
-
-&enet1 {
-	status = "okay";
-	tbi-handle = <&tbi1>;
-	phy-connection-type = "sgmii";
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
-};
-
-&enet2 {
-	phy-handle = <&debug_phy>;
-	phy-connection-type = "rgmii-id";
-	max-speed = <100>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&ifc {
-	#address-cells = <2>;
-	#size-cells = <1>;
-	/* NOR Flash on board */
-	ranges = <0x0 0x0 0x60000000 0x04000000>;
-	status = "okay";
-
-	nor@0,0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "cfi-flash";
-		reg = <0x0 0x0 0x4000000>;
-		bank-width = <2>;
-		device-width = <1>;
-
-		partition@0 {
-			label = "rcw";
-			reg = <0x0 0x20000>;
-			read-only;
-		};
-		partition@20000 {
-			label = "qe";
-			reg = <0x20000 0x20000>;
-		};
-		partition@40000 {
-			label = "envred";
-			reg = <0x40000 0x20000>;
-		};
-		partition@60000 {
-			label = "env";
-			reg = <0x60000 0x20000>;
-		};
-		partition@100000 {
-			label = "u-boot";
-			reg = <0x100000 0x100000>;
-		};
-		partition@200000 {
-			label = "redenvred";
-			reg = <0x200000 0x20000>;
-		};
-		partition@220000 {
-			label = "redenv";
-			reg = <0x220000 0x20000>;
-		};
-		partition@240000 {
-			label = "redu-boot";
-			reg = <0x240000 0x100000>;
-		};
-		partition@340000 {
-			label = "ubi0";
-			reg = <0x340000 0x03C00000>;
-		};
-	};
-};
-
-&mdio0 {
-	debug_phy: ethernet-phy@11 {
-		reg = <0x11>;
-	};
-
-	tbi0: tbi-phy@0xb {
-		reg = <0xb>;
-		device_type = "tbi-phy";
-	};
-};
-
-&mdio1 {
-	tbi1: tbi-phy@0xd {
-		reg = <0xd>;
-		device_type = "tbi-phy";
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index f7e9b74f578..18ef689b334 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -154,7 +154,6 @@ config PG_WCOM_UBOOT_UPDATE
 
 source "board/keymile/km83xx/Kconfig"
 source "board/keymile/kmcent2/Kconfig"
-source "board/keymile/pg-wcom-ls102xa/Kconfig"
 
 endmenu
 
diff --git a/board/keymile/pg-wcom-ls102xa/Kconfig b/board/keymile/pg-wcom-ls102xa/Kconfig
deleted file mode 100644
index f0b5ceabb69..00000000000
--- a/board/keymile/pg-wcom-ls102xa/Kconfig
+++ /dev/null
@@ -1,39 +0,0 @@
-if TARGET_PG_WCOM_SELI8
-
-config SYS_BOARD
-	default "pg-wcom-ls102xa"
-
-config SYS_VENDOR
-	default "keymile"
-
-config SYS_SOC
-	default "ls102xa"
-
-config SYS_CONFIG_NAME
-	default "pg-wcom-seli8"
-
-config BOARD_SPECIFIC_OPTIONS
-	def_bool y
-	imply FS_CRAMFS
-
-endif
-
-if TARGET_PG_WCOM_EXPU1
-
-config SYS_BOARD
-	default "pg-wcom-ls102xa"
-
-config SYS_VENDOR
-	default "keymile"
-
-config SYS_SOC
-	default "ls102xa"
-
-config SYS_CONFIG_NAME
-	default "pg-wcom-expu1"
-
-config BOARD_SPECIFIC_OPTIONS
-	def_bool y
-	imply FS_CRAMFS
-
-endif
diff --git a/board/keymile/pg-wcom-ls102xa/MAINTAINERS b/board/keymile/pg-wcom-ls102xa/MAINTAINERS
deleted file mode 100644
index ed5baf269a7..00000000000
--- a/board/keymile/pg-wcom-ls102xa/MAINTAINERS
+++ /dev/null
@@ -1,16 +0,0 @@
-Hitachi Power Grids LS102XA BOARD
-M:	Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
-M:	Rainer Boschung <rainer.boschung@hitachienergy.com>
-S:	Maintained
-F:	board/keymile/pg-wcom-ls102xa/
-F:	board/keymile/common/
-F:	board/keymile/scripts/
-F:	include/configs/km/pg-wcom-ls102xa.h
-F:	include/configs/pg-wcom-seli8.h
-F:	include/configs/pg-wcom-expu1.h
-F:	configs/pg_wcom_seli8_defconfig
-F:	configs/pg_wcom_seli8_update_defconfig
-F:	configs/pg_wcom_expu1_defconfig
-F:	configs/pg_wcom_expu1_update_defconfig
-F:	arch/arm/dts/ls1021a-pg-wcom-seli8.dts
-F:	arch/arm/dts/ls1021a-pg-wcom-expu1.dts
diff --git a/board/keymile/pg-wcom-ls102xa/Makefile b/board/keymile/pg-wcom-ls102xa/Makefile
deleted file mode 100644
index 229b0c28278..00000000000
--- a/board/keymile/pg-wcom-ls102xa/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-#
-# SPDX-License-Identifier:      GPL-2.0+
-#
-# Copyright 2021 Hitachi Power Grids. All rights reserved.
-#
-
-obj-y += pg-wcom-ls102xa.o ddr.o
-obj-y += ../common/common.o ../common/ivm.o ../common/qrio.o
-obj-$(CONFIG_LAYERSCAPE_NS_ACCESS) += ../../freescale/common/ns_access.o
-obj-$(CONFIG_LS102XA_STREAM_ID) += ../../freescale/common/ls102xa_stream_id.o
-obj-$(CONFIG_ID_EEPROM) += ../../freescale/common/sys_eeprom.o
diff --git a/board/keymile/pg-wcom-ls102xa/ddr.c b/board/keymile/pg-wcom-ls102xa/ddr.c
deleted file mode 100644
index 51938a1b4d8..00000000000
--- a/board/keymile/pg-wcom-ls102xa/ddr.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Freescale Semiconductor, Inc.
- * Copyright 2020 Hitachi Power Grids. All rights reserved.
- */
-
-#include <config.h>
-#include <fsl_ddr_sdram.h>
-#include <fsl_ddr_dimm_params.h>
-#include <asm/io.h>
-#include <asm/arch/clock.h>
-#include <asm/global_data.h>
-#include <asm/arch/ls102xa_soc.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-void fsl_ddr_board_options(memctl_options_t *popts,
-			   dimm_params_t *pdimm,
-			   unsigned int ctrl_num)
-{
-	if (ctrl_num > 1) {
-		printf("Not supported controller number %d\n", ctrl_num);
-		return;
-	}
-
-	// 1/2 DRAM cycle (should be increased in case of ADDR/CMD heavily loaded than the clock)
-	popts->clk_adjust = 0x4;
-	popts->write_data_delay = 0x4;
-	// wr leveling start value for lane 0
-	popts->wrlvl_start = 0x5;
-	// wr leveling start values for lanes 1-3 (lane 4 not there)
-	popts->wrlvl_ctl_2 = 0x05050500;
-	// 32-bit DRAM, no need to set start values for lanes we do not have (5-8)
-	popts->wrlvl_ctl_3 = 0x0;
-	popts->cpo_override = 0x1f;
-
-	/* force DDR bus width to 32 bits */
-	popts->data_bus_width = 1;
-	popts->otf_burst_chop_en = 0;
-	popts->burst_length = DDR_BL8;
-
-	/*
-	 * Factors to consider for half-strength driver enable:
-	 *	- number of DIMMs installed
-	 */
-	popts->half_strength_driver_enable = 1;
-	/*
-	 * Write leveling override
-	 */
-	popts->wrlvl_override = 1;
-	popts->wrlvl_sample = 0xf;
-
-	/*
-	 * Rtt and Rtt_WR override
-	 */
-	popts->rtt_override = 0;
-
-	/* Enable ZQ calibration */
-	popts->zq_en = 1;
-
-	popts->cswl_override = DDR_CSWL_CS0;
-
-	/* optimize cpo for erratum A-009942 */
-	popts->cpo_sample = 0x58;
-
-	/* DHC_EN =1, ODT = 75 Ohm */
-	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_75ohm);
-	popts->ddr_cdr2 = DDR_CDR2_ODT(DDR_CDR_ODT_75ohm);
-}
-
-int fsl_initdram(void)
-{
-	phys_size_t dram_size;
-
-	puts("Initializing DDR....using SPD\n");
-	dram_size = fsl_ddr_sdram();
-
-	erratum_a008850_post();
-
-	gd->ram_size = dram_size;
-
-	return 0;
-}
-
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env b/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
deleted file mode 100644
index 1054dbf9f54..00000000000
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <env/pg-wcom/ls102xa.env>
-
-hostname=EXPU1
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
deleted file mode 100644
index cc3611e2dec..00000000000
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ /dev/null
@@ -1,218 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2020 Hitachi Power Grids. All rights reserved.
- */
-
-#include <config.h>
-#include <event.h>
-#include <i2c.h>
-#include <asm/io.h>
-#include <asm/arch/immap_ls102xa.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/fsl_serdes.h>
-#include <asm/arch/ls102xa_devdis.h>
-#include <asm/arch/ls102xa_soc.h>
-#include <hwconfig.h>
-#include <mmc.h>
-#include <fsl_csu.h>
-#include <fsl_esdhc.h>
-#include <fsl_ifc.h>
-#include <fsl_immap.h>
-#include <netdev.h>
-#include <fsl_mdio.h>
-#include <tsec.h>
-#include <fsl_sec.h>
-#include <fsl_devdis.h>
-#include <fsl_ddr.h>
-#include <spl.h>
-#include <fdt_support.h>
-#include <fsl_qe.h>
-#include <fsl_validate.h>
-
-#include "../common/common.h"
-#include "../common/qrio.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static uchar ivm_content[CONFIG_SYS_IVM_EEPROM_MAX_LEN];
-
-int checkboard(void)
-{
-	show_qrio();
-
-	return 0;
-}
-
-int dram_init(void)
-{
-	return fsl_initdram();
-}
-
-int board_early_init_f(void)
-{
-	struct ccsr_scfg *scfg = (struct ccsr_scfg *)CFG_SYS_FSL_SCFG_ADDR;
-	struct ccsr_gur __iomem *gur = (void *)CFG_SYS_FSL_GUTS_ADDR;
-	struct fsl_ifc ifc = {(void *)CFG_SYS_IFC_ADDR, (void *)NULL};
-
-	/* Disable unused MCK1 */
-	setbits_be32(&gur->ddrclkdr, 2);
-
-	/* IFC Global Configuration */
-	setbits_be32(&ifc.gregs->ifc_gcr, 12 << IFC_GCR_TBCTL_TRN_TIME_SHIFT);
-	setbits_be32(&ifc.gregs->ifc_ccr, IFC_CCR_CLK_DIV(3) |
-					  IFC_CCR_INV_CLK_EN);
-
-	/* clear BD & FR bits for BE BD's and frame data */
-	clrbits_be32(&scfg->etsecdmamcr, SCFG_ETSECDMAMCR_LE_BD_FR);
-	out_be32(&scfg->etsecmcr, SCFG_ETSECCMCR_GE2_CLK125);
-
-	init_early_memctl_regs();
-
-	/* QRIO Configuration */
-	qrio_uprstreq(UPREQ_CORE_RST);
-
-#if IS_ENABLED(CONFIG_TARGET_PG_WCOM_SELI8)
-	qrio_prstcfg(KM_LIU_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_wdmask(KM_LIU_RST, true);
-
-	qrio_prstcfg(KM_PAXK_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_wdmask(KM_PAXK_RST, true);
-#endif
-
-#if IS_ENABLED(CONFIG_TARGET_PG_WCOM_EXPU1)
-	qrio_prstcfg(WCOM_TMG_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_wdmask(WCOM_TMG_RST, true);
-
-	qrio_prstcfg(WCOM_PHY_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_prst(WCOM_PHY_RST, false, false);
-
-	qrio_prstcfg(WCOM_QSFP_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_wdmask(WCOM_QSFP_RST, true);
-
-	qrio_prstcfg(WCOM_CLIPS_RST, PRSTCFG_POWUP_UNIT_RST);
-	qrio_prst(WCOM_CLIPS_RST, false, false);
-#endif
-
-	/* deasset debug phy reset only if piggy is present */
-	qrio_prstcfg(KM_DBG_ETH_RST, PRSTCFG_POWUP_UNIT_CORE_RST);
-	qrio_prst(KM_DBG_ETH_RST, !qrio_get_pgy_pres_pin(), false);
-
-	i2c_deblock_gpio_cfg();
-
-	/* enable the Unit LED (red) & Boot LED (on) */
-	qrio_set_leds();
-
-	/* enable Application Buffer */
-	qrio_enable_app_buffer();
-
-	arch_soc_init();
-
-	return 0;
-}
-
-static int pg_wcom_misc_init_f(void)
-{
-	if (IS_ENABLED(CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED))
-		check_for_uboot_update();
-
-	return 0;
-}
-EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, pg_wcom_misc_init_f);
-
-int board_init(void)
-{
-	if (IS_ENABLED(CONFIG_SYS_FSL_ERRATUM_A010315))
-		erratum_a010315();
-
-	fsl_serdes_init();
-
-	ls102xa_smmu_stream_id_init();
-
-	u_qe_init();
-
-	return 0;
-}
-
-int board_late_init(void)
-{
-	return 0;
-}
-
-int misc_init_r(void)
-{
-	device_disable(devdis_tbl, ARRAY_SIZE(devdis_tbl));
-
-	ivm_read_eeprom(ivm_content, CONFIG_SYS_IVM_EEPROM_MAX_LEN,
-			CONFIG_PIGGY_MAC_ADDRESS_OFFSET);
-
-	return 0;
-}
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	ft_cpu_setup(blob, bd);
-
-	if (IS_ENABLED(CONFIG_PCI))
-		ft_pci_setup(blob, bd);
-
-	return 0;
-}
-
-#if defined(CONFIG_POST)
-int post_hotkeys_pressed(void)
-{
-	/* DIC26_SELFTEST: QRIO, SLFTEST */
-	return qrio_get_selftest_pin();
-}
-
-/* POST word is located in the unused SCRATCHRW4 register */
-#define CCSR_SCRATCHRW4_ADDR		0x1ee020c
-
-ulong post_word_load(void)
-{
-	void *addr = (void *)CCSR_SCRATCHRW4_ADDR;
-	return in_le32(addr);
-}
-
-void post_word_store(ulong value)
-{
-	void *addr = (void *)CCSR_SCRATCHRW4_ADDR;
-	out_le32(addr, value);
-}
-
-int arch_memory_test_prepare(u32 *vstart, u32 *size, phys_addr_t *phys_offset)
-{
-	/* Define only 1MiB range for mem_regions at the middle of the RAM */
-	/* For 1GiB range mem_regions takes approx. 4min */
-	*vstart = CFG_SYS_SDRAM_BASE + (gd->ram_size >> 1);
-	*size = 1 << 20;
-	return 0;
-}
-#endif
-
-u8 flash_read8(void *addr)
-{
-	return __raw_readb(addr + 1);
-}
-
-void flash_write16(u16 val, void *addr)
-{
-	u16 shftval = (((val >> 8) & 0xff) | ((val << 8) & 0xff00));
-
-	__raw_writew(shftval, addr);
-}
-
-u16 flash_read16(void *addr)
-{
-	u16 val = __raw_readw(addr);
-
-	return (((val) >> 8) & 0x00ff) | (((val) << 8) & 0xff00);
-}
-
-int hush_init_var(void)
-{
-	ivm_analyze_eeprom(ivm_content, CONFIG_SYS_IVM_EEPROM_MAX_LEN);
-	return 0;
-}
-
-EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, set_km_env);
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env b/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
deleted file mode 100644
index 1232fe9da8b..00000000000
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <env/pg-wcom/ls102xa.env>
-
-hostname=SELI8
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
deleted file mode 100644
index 61513c9e2ec..00000000000
--- a/configs/pg_wcom_expu1_defconfig
+++ /dev/null
@@ -1,109 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=8333333
-CONFIG_TARGET_PG_WCOM_EXPU1=y
-CONFIG_TEXT_BASE=0x60100000
-CONFIG_SYS_MALLOC_LEN=0x1004000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SOURCE_FILE="pg-wcom-expu1"
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-expu1"
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SYS_BOOTCOUNT_ADDR=0x70000020
-CONFIG_SYS_CLK_FREQ=66666666
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
-CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_ENV_ADDR=0x60060000
-# CONFIG_DEEP_SLEEP is not set
-CONFIG_LAYERSCAPE_NS_ACCESS=y
-CONFIG_KM_COMMON_ETH_INIT=y
-CONFIG_PIGGY_MAC_ADDRESS_OFFSET=3
-CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED=y
-CONFIG_PG_WCOM_UBOOT_BOOTPACKAGE=y
-CONFIG_PG_WCOM_UBOOT_UPDATE_TEXT_BASE=0x60240000
-CONFIG_SYS_MEMTEST_START=0x80000000
-CONFIG_SYS_MEMTEST_END=0x9fffffff
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
-CONFIG_SILENT_CONSOLE=y
-CONFIG_LAST_STAGE_INIT=y
-CONFIG_MISC_INIT_R=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_MEMINFO=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_CRAMFS=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=60000000.nor,nand0=68000000.flash"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:128k(rcw),128k(qe),128k(envred),128k(env),512k(res),1m(u-boot),128k(redenvred),128k(redenv),1m(redu-boot),-(ubi0);68000000.flash:-(ubi1)"
-CONFIG_CMD_UBI=y
-# CONFIG_CMD_UBIFS is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_ENV_ADDR_REDUND=0x60040000
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="ethernet@2d90000"
-CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="EXPU1"
-CONFIG_VERSION_VARIABLE=y
-# CONFIG_SCSI_AHCI is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_DDR_CLK_FREQ=50000000
-CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_IFC=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_FIXED=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_SYS_QE_FW_ADDR=0x60020000
-# CONFIG_SCSI is not set
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_LZO=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
deleted file mode 100644
index ec0f975ae36..00000000000
--- a/configs/pg_wcom_expu1_update_defconfig
+++ /dev/null
@@ -1,107 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=8333333
-CONFIG_TARGET_PG_WCOM_EXPU1=y
-CONFIG_TEXT_BASE=0x60240000
-CONFIG_SYS_MALLOC_LEN=0x1004000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SOURCE_FILE="pg-wcom-expu1"
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-expu1"
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SYS_BOOTCOUNT_ADDR=0x70000020
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
-CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_ENV_ADDR=0x60220000
-# CONFIG_DEEP_SLEEP is not set
-CONFIG_LAYERSCAPE_NS_ACCESS=y
-CONFIG_KM_COMMON_ETH_INIT=y
-CONFIG_PIGGY_MAC_ADDRESS_OFFSET=3
-CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED=y
-CONFIG_PG_WCOM_UBOOT_UPDATE=y
-CONFIG_SYS_MEMTEST_START=0x80000000
-CONFIG_SYS_MEMTEST_END=0x9fffffff
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
-CONFIG_SILENT_CONSOLE=y
-CONFIG_LAST_STAGE_INIT=y
-CONFIG_MISC_INIT_R=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_MEMINFO=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_CRAMFS=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=60000000.nor,nand0=68000000.flash"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:128k(rcw),128k(qe),128k(envred),128k(env),512k(res),1m(u-boot),128k(redenvred),128k(redenv),1m(redu-boot),-(ubi0);68000000.flash:-(ubi1)"
-CONFIG_CMD_UBI=y
-# CONFIG_CMD_UBIFS is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_ENV_ADDR_REDUND=0x60200000
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="ethernet@2d90000"
-CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="EXPU1"
-CONFIG_VERSION_VARIABLE=y
-# CONFIG_SCSI_AHCI is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_DDR_CLK_FREQ=50000000
-CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_IFC=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_FIXED=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_SYS_QE_FW_ADDR=0x60020000
-# CONFIG_SCSI is not set
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_LZO=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
deleted file mode 100644
index 82923d32ca6..00000000000
--- a/configs/pg_wcom_seli8_defconfig
+++ /dev/null
@@ -1,109 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=8333333
-CONFIG_TARGET_PG_WCOM_SELI8=y
-CONFIG_TEXT_BASE=0x60100000
-CONFIG_SYS_MALLOC_LEN=0x1004000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SOURCE_FILE="pg-wcom-seli8"
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-seli8"
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SYS_BOOTCOUNT_ADDR=0x70000020
-CONFIG_SYS_CLK_FREQ=66666666
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
-CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_ENV_ADDR=0x60060000
-# CONFIG_DEEP_SLEEP is not set
-CONFIG_LAYERSCAPE_NS_ACCESS=y
-CONFIG_KM_COMMON_ETH_INIT=y
-CONFIG_PIGGY_MAC_ADDRESS_OFFSET=3
-CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED=y
-CONFIG_PG_WCOM_UBOOT_BOOTPACKAGE=y
-CONFIG_PG_WCOM_UBOOT_UPDATE_TEXT_BASE=0x60240000
-CONFIG_SYS_MEMTEST_START=0x80000000
-CONFIG_SYS_MEMTEST_END=0x9fffffff
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
-CONFIG_SILENT_CONSOLE=y
-CONFIG_LAST_STAGE_INIT=y
-CONFIG_MISC_INIT_R=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_MEMINFO=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_CRAMFS=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=60000000.nor,nand0=68000000.flash"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:128k(rcw),128k(qe),128k(envred),128k(env),512k(res),1m(u-boot),128k(redenvred),128k(redenv),1m(redu-boot),-(ubi0);68000000.flash:-(ubi1)"
-CONFIG_CMD_UBI=y
-# CONFIG_CMD_UBIFS is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_ENV_ADDR_REDUND=0x60040000
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="ethernet@2d90000"
-CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="SELI8"
-CONFIG_VERSION_VARIABLE=y
-# CONFIG_SCSI_AHCI is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_DDR_CLK_FREQ=50000000
-CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_IFC=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_FIXED=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_SYS_QE_FW_ADDR=0x60020000
-# CONFIG_SCSI is not set
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_LZO=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
deleted file mode 100644
index 41931e24768..00000000000
--- a/configs/pg_wcom_seli8_update_defconfig
+++ /dev/null
@@ -1,107 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=8333333
-CONFIG_TARGET_PG_WCOM_SELI8=y
-CONFIG_TEXT_BASE=0x60240000
-CONFIG_SYS_MALLOC_LEN=0x1004000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SOURCE_FILE="pg-wcom-seli8"
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-seli8"
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SYS_BOOTCOUNT_ADDR=0x70000020
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
-CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_ENV_ADDR=0x60220000
-# CONFIG_DEEP_SLEEP is not set
-CONFIG_LAYERSCAPE_NS_ACCESS=y
-CONFIG_KM_COMMON_ETH_INIT=y
-CONFIG_PIGGY_MAC_ADDRESS_OFFSET=3
-CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED=y
-CONFIG_PG_WCOM_UBOOT_UPDATE=y
-CONFIG_SYS_MEMTEST_START=0x80000000
-CONFIG_SYS_MEMTEST_END=0x9fffffff
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
-CONFIG_SILENT_CONSOLE=y
-CONFIG_LAST_STAGE_INIT=y
-CONFIG_MISC_INIT_R=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_MEMINFO=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_CRAMFS=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=60000000.nor,nand0=68000000.flash"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:128k(rcw),128k(qe),128k(envred),128k(env),512k(res),1m(u-boot),128k(redenvred),128k(redenv),1m(redu-boot),-(ubi0);68000000.flash:-(ubi1)"
-CONFIG_CMD_UBI=y
-# CONFIG_CMD_UBIFS is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_ENV_ADDR_REDUND=0x60200000
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="ethernet@2d90000"
-CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="SELI8"
-CONFIG_VERSION_VARIABLE=y
-# CONFIG_SCSI_AHCI is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_DDR_CLK_FREQ=50000000
-CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_IFC=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_FIXED=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_SYS_QE_FW_ADDR=0x60020000
-# CONFIG_SCSI is not set
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_LZO=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/include/configs/km/pg-wcom-ls102xa.h b/include/configs/km/pg-wcom-ls102xa.h
deleted file mode 100644
index 15ef68a0507..00000000000
--- a/include/configs/km/pg-wcom-ls102xa.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2020 Hitachi Power Grids. All rights reserved.
- */
-
-#ifndef __CONFIG_PG_WCOM_LS102XA_H
-#define __CONFIG_PG_WCOM_LS102XA_H
-
-#define CFG_SYS_INIT_RAM_ADDR	OCRAM_BASE_ADDR
-#define CFG_SYS_INIT_RAM_SIZE	OCRAM_SIZE
-
-#define CFG_PRAM			((CONFIG_KM_PNVRAM + \
-					  CONFIG_KM_PHRAM + \
-					  CONFIG_KM_RESERVED_PRAM) >> 10)
-
-#define PHYS_SDRAM			0x80000000
-#define PHYS_SDRAM_SIZE			(1u * 1024 * 1024 * 1024)
-
-#define CFG_SYS_DDR_SDRAM_BASE	0x80000000UL
-#define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
-
-#define SPD_EEPROM_ADDRESS		0x54
-
-/* POST memory regions test */
-#define CFG_POST			(CFG_SYS_POST_MEM_REGIONS)
-#define CFG_POST_EXTERNAL_WORD_FUNCS
-
-/*
- * IFC Definitions
- */
-/* NOR Flash Definitions */
-#define CFG_SYS_FLASH_BASE		0x60000000
-#define CFG_SYS_FLASH_BASE_PHYS	CFG_SYS_FLASH_BASE
-
-#define CFG_SYS_NOR0_CSPR_EXT	(0x0)
-#define CFG_SYS_NOR0_CSPR	(CSPR_PHYS_ADDR(CFG_SYS_FLASH_BASE_PHYS) | \
-				CSPR_PORT_SIZE_16 | \
-				CSPR_TE | \
-				CSPR_MSEL_NOR | \
-				CSPR_V)
-#define CFG_SYS_NOR_AMASK		IFC_AMASK(64 * 1024 * 1024)
-
-#define CFG_SYS_NOR_CSOR		(CSOR_NOR_AVD_TGL_PGM_EN | \
-					CSOR_NOR_ADM_SHIFT(0x4) | \
-					CSOR_NOR_NOR_MODE_ASYNC_NOR | \
-					CSOR_NOR_TRHZ_20 | \
-					CSOR_NOR_BCTLD)
-#define CFG_SYS_NOR_FTIM0		(FTIM0_NOR_TACSE(0x1) | \
-					FTIM0_NOR_TEADC(0x7) | \
-					FTIM0_NOR_TAVDS(0x0) | \
-					FTIM0_NOR_TEAHC(0x1))
-#define CFG_SYS_NOR_FTIM1		(FTIM1_NOR_TACO(0x1) | \
-					FTIM1_NOR_TRAD_NOR(0x21) | \
-					FTIM1_NOR_TSEQRAD_NOR(0x21))
-#define CFG_SYS_NOR_FTIM2		(FTIM2_NOR_TCS(0x1) | \
-					FTIM2_NOR_TCH(0x1) | \
-					FTIM2_NOR_TWPH(0x6) | \
-					FTIM2_NOR_TWP(0xb))
-#define CFG_SYS_NOR_FTIM3		0
-
-#define CFG_SYS_FLASH_BANKS_LIST	{ CFG_SYS_FLASH_BASE_PHYS }
-
-#define CFG_SYS_WRITE_SWAPPED_DATA
-
-#define CFG_SYS_CSPR0_EXT		CFG_SYS_NOR0_CSPR_EXT
-#define CFG_SYS_CSPR0		CFG_SYS_NOR0_CSPR
-#define CFG_SYS_AMASK0		CFG_SYS_NOR_AMASK
-#define CFG_SYS_CSOR0		CFG_SYS_NOR_CSOR
-#define CFG_SYS_CS0_FTIM0		CFG_SYS_NOR_FTIM0
-#define CFG_SYS_CS0_FTIM1		CFG_SYS_NOR_FTIM1
-#define CFG_SYS_CS0_FTIM2		CFG_SYS_NOR_FTIM2
-#define CFG_SYS_CS0_FTIM3		CFG_SYS_NOR_FTIM3
-
-/* NAND Flash Definitions */
-#define CFG_SYS_NAND_BASE		0x68000000
-#define CFG_SYS_NAND_BASE_PHYS	CFG_SYS_NAND_BASE
-
-#define CFG_SYS_NAND_CSPR_EXT	(0x0)
-#define CFG_SYS_NAND_CSPR	(CSPR_PHYS_ADDR(CFG_SYS_NAND_BASE) | \
-				CSPR_PORT_SIZE_8 | \
-				CSPR_TE | \
-				CSPR_MSEL_NAND | \
-				CSPR_V)
-#define CFG_SYS_NAND_AMASK		IFC_AMASK(64 * 1024)
-#define CFG_SYS_NAND_CSOR		(CSOR_NAND_ECC_ENC_EN \
-					| CSOR_NAND_ECC_DEC_EN \
-					| CSOR_NAND_ECC_MODE_4 \
-					| CSOR_NAND_RAL_3 \
-					| CSOR_NAND_PGS_2K \
-					| CSOR_NAND_SPRZ_64 \
-					| CSOR_NAND_PB(64) \
-					| CSOR_NAND_TRHZ_40 \
-					| CSOR_NAND_BCTLD)
-
-#define CFG_SYS_NAND_FTIM0		(FTIM0_NAND_TCCST(0x3) | \
-					FTIM0_NAND_TWP(0x8) | \
-					FTIM0_NAND_TWCHT(0x3) | \
-					FTIM0_NAND_TWH(0x5))
-#define CFG_SYS_NAND_FTIM1		(FTIM1_NAND_TADLE(0x1e) | \
-					FTIM1_NAND_TWBE(0x1e) | \
-					FTIM1_NAND_TRR(0x6) | \
-					FTIM1_NAND_TRP(0x8))
-#define CFG_SYS_NAND_FTIM2		(FTIM2_NAND_TRAD(0x9) | \
-					FTIM2_NAND_TREH(0x5) | \
-					FTIM2_NAND_TWHRE(0x3c))
-#define CFG_SYS_NAND_FTIM3		(FTIM3_NAND_TWW(0x1e))
-
-#define CFG_SYS_CSPR1_EXT		CFG_SYS_NAND_CSPR_EXT
-#define CFG_SYS_CSPR1		CFG_SYS_NAND_CSPR
-#define CFG_SYS_AMASK1		CFG_SYS_NAND_AMASK
-#define CFG_SYS_CSOR1		CFG_SYS_NAND_CSOR
-#define CFG_SYS_CS1_FTIM0		CFG_SYS_NAND_FTIM0
-#define CFG_SYS_CS1_FTIM1		CFG_SYS_NAND_FTIM1
-#define CFG_SYS_CS1_FTIM2		CFG_SYS_NAND_FTIM2
-#define CFG_SYS_CS1_FTIM3		CFG_SYS_NAND_FTIM3
-
-#define CFG_SYS_NAND_BASE_LIST	{ CFG_SYS_NAND_BASE }
-
-/* QRIO FPGA Definitions */
-#define CFG_SYS_QRIO_BASE		0x70000000
-#define CFG_SYS_QRIO_BASE_PHYS	CFG_SYS_QRIO_BASE
-
-#define CFG_SYS_CSPR2_EXT		(0x00)
-#define CFG_SYS_CSPR2	(CSPR_PHYS_ADDR(CFG_SYS_QRIO_BASE) | \
-					CSPR_PORT_SIZE_8 | \
-					CSPR_TE | \
-					CSPR_MSEL_GPCM | \
-					CSPR_V)
-#define CFG_SYS_AMASK2		IFC_AMASK(64 * 1024)
-#define CFG_SYS_CSOR2		(CSOR_GPCM_ADM_SHIFT(0x4) | \
-					CSOR_GPCM_TRHZ_20 | \
-					CSOR_GPCM_BCTLD)
-#define CFG_SYS_CS2_FTIM0		(FTIM0_GPCM_TACSE(0x2) | \
-					FTIM0_GPCM_TEADC(0x8) | \
-					FTIM0_GPCM_TEAHC(0x2))
-#define CFG_SYS_CS2_FTIM1		(FTIM1_GPCM_TACO(0x2) | \
-					FTIM1_GPCM_TRAD(0x6))
-#define CFG_SYS_CS2_FTIM2		(FTIM2_GPCM_TCS(0x1) | \
-					FTIM2_GPCM_TCH(0x1) | \
-					FTIM2_GPCM_TWP(0x7))
-#define CFG_SYS_CS2_FTIM3		0x04000000
-
-/*
- * Serial Port
- */
-#define CFG_SYS_NS16550_CLK		get_serial_clock()
-
-/*
- * I2C
- */
-
-#define CFG_SYS_I2C_MAX_HOPS		1
-#define CFG_SYS_NUM_I2C_BUSES	3
-#define I2C_MUX_PCA_ADDR		0x70
-#define I2C_MUX_CH_DEFAULT		0x0
-#define CFG_SYS_I2C_BUSES	{	{0, {I2C_NULL_HOP} }, \
-					{0, {{I2C_MUX_PCA9547, 0x70, 1 } } }, \
-					{1, {I2C_NULL_HOP}                 }, \
-				}
-
-#define CFG_SMP_PEN_ADDR		0x01ee0200
-
-#define HWCONFIG_BUFFER_SIZE		256
-
-#define CFG_SYS_BOOTMAPSZ	(256 << 20) /* Increase map for Linux */
-
-#endif
diff --git a/include/configs/pg-wcom-expu1.h b/include/configs/pg-wcom-expu1.h
deleted file mode 100644
index 2c38cffa8a0..00000000000
--- a/include/configs/pg-wcom-expu1.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2020 Hitachi ABB Power Grids
- */
-
-#ifndef __CONFIG_PG_WCOM_EXPU1_H
-#define __CONFIG_PG_WCOM_EXPU1_H
-
-#define WCOM_EXPU1
-
-/* CLIPS FPGA Definitions */
-#define CFG_SYS_CSPR3_EXT	(0x00)
-#define CFG_SYS_CSPR3	(CSPR_PHYS_ADDR(CONFIG_SYS_CLIPS_BASE) | \
-				CSPR_PORT_SIZE_8 | \
-				CSPR_MSEL_GPCM | \
-				CSPR_V)
-#define CFG_SYS_AMASK3	IFC_AMASK(64 * 1024)
-#define CFG_SYS_CSOR3	(CSOR_GPCM_ADM_SHIFT(0x4) | \
-				CSOR_GPCM_TRHZ_40)
-#define CFG_SYS_CS3_FTIM0	(FTIM0_GPCM_TACSE(0x6) | \
-				FTIM0_GPCM_TEADC(0x7) | \
-				FTIM0_GPCM_TEAHC(0x2))
-#define CFG_SYS_CS3_FTIM1	(FTIM1_GPCM_TACO(0x2) | \
-				FTIM1_GPCM_TRAD(0x12))
-#define CFG_SYS_CS3_FTIM2	(FTIM2_GPCM_TCS(0x3) | \
-				FTIM2_GPCM_TCH(0x1) | \
-				FTIM2_GPCM_TWP(0x12))
-#define CFG_SYS_CS3_FTIM3	0x04000000
-
-/* PRST */
-#define WCOM_CLIPS_RST		0
-#define WCOM_QSFP_RST		1
-#define WCOM_PHY_RST		2
-#define WCOM_TMG_RST		3
-#define KM_DBG_ETH_RST		15
-
-/* QRIO GPIOs used for deblocking */
-#define KM_I2C_DEBLOCK_PORT	QRIO_GPIO_A
-#define KM_I2C_DEBLOCK_SCL	20
-#define KM_I2C_DEBLOCK_SDA	21
-
-/* ZL30343 on SPI */
-#define WCOM_ZL30343_CFG_ADDR	0xe8070000
-#define WCOM_ZL30343_SPI_BUS	0
-#define WCOM_ZL30343_CS	0
-
-#include "km/pg-wcom-ls102xa.h"
-
-#endif /* __CONFIG_PG_WCOM_EXPU1_H */
diff --git a/include/configs/pg-wcom-seli8.h b/include/configs/pg-wcom-seli8.h
deleted file mode 100644
index 9474d3bd7bd..00000000000
--- a/include/configs/pg-wcom-seli8.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2020 Hitachi Power Grids. All rights reserved.
- */
-
-#ifndef __CONFIG_PG_WCOM_SELI8_H
-#define __CONFIG_PG_WCOM_SELI8_H
-
-/* PAXK FPGA Definitions */
-#define CFG_SYS_CSPR3_EXT	(0x00)
-#define CFG_SYS_CSPR3	(CSPR_PHYS_ADDR(CONFIG_SYS_PAX_BASE) | \
-				CSPR_PORT_SIZE_8 | \
-				CSPR_MSEL_GPCM | \
-				CSPR_V)
-#define CFG_SYS_AMASK3	IFC_AMASK(64 * 1024)
-#define CFG_SYS_CSOR3	(CSOR_GPCM_ADM_SHIFT(0x4) | \
-				CSOR_GPCM_TRHZ_40)
-#define CFG_SYS_CS3_FTIM0	(FTIM0_GPCM_TACSE(0x6) | \
-				FTIM0_GPCM_TEADC(0x7) | \
-				FTIM0_GPCM_TEAHC(0x2))
-#define CFG_SYS_CS3_FTIM1	(FTIM1_GPCM_TACO(0x2) | \
-				FTIM1_GPCM_TRAD(0x12))
-#define CFG_SYS_CS3_FTIM2	(FTIM2_GPCM_TCS(0x3) | \
-				FTIM2_GPCM_TCH(0x1) | \
-				FTIM2_GPCM_TWP(0x12))
-#define CFG_SYS_CS3_FTIM3	0x04000000
-
-/* PRST */
-#define KM_LIU_RST		0
-#define KM_PAXK_RST		1
-#define KM_DBG_ETH_RST		15
-
-/* QRIO GPIOs used for deblocking */
-#define KM_I2C_DEBLOCK_PORT	QRIO_GPIO_A
-#define KM_I2C_DEBLOCK_SCL	20
-#define KM_I2C_DEBLOCK_SDA	21
-
-#include "km/pg-wcom-ls102xa.h"
-
-#endif /* __CONFIG_PG_WCOM_SELI8_H */
-- 
2.34.1

