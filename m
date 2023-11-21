Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56CEC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38AFC875F9;
	Tue, 21 Nov 2023 18:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qaG5/Yb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FDD875A4; Tue, 21 Nov 2023 18:09:54 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B22875C7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b2979a74eso6641655e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586582; x=1701191382; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n0oDA22VA2xD22Q/11hKkKzXxRs3zY+AXoQ2Uak1SSA=;
 b=qaG5/Yb7j3rAHkHaELgZhAq7Hjxbz+DuXSh7uQxtDXiR2h6m6LJx+KpWCJvlDF/DpY
 4X57TxP945gtHW+KZoDsnIZhLfDEvKVj28Er4h3I/imlWKpMWg8y89r9ic7apXBL4a94
 CUGXL4Ys4Wn+42mgHqy/nD8w4R2yOfI/c/my8ShEAPt1X08m2WQ0n6MCk4RrFKNEJ+3C
 xdr9UyaHBfwUwTKkY5HaegHo/sKic4lRFtorBDqDvWcLZXDkP7Ch3W8iBV2RxmCLm3DZ
 rKhU358cHiCFmOWLIMn/JJV6gfLoRlqLVcBq7Miiv/cKFCh3R4/FuxV1cS3P9nwKqdhG
 wa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586582; x=1701191382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0oDA22VA2xD22Q/11hKkKzXxRs3zY+AXoQ2Uak1SSA=;
 b=PDJ0hJ/gsHcZWNJJGYsFKKH8xqY52i8b3QSNk2X7r+Ck8vrsQKfctJJiQa08HwBF4p
 Fg24Cjr+ZDKMm7mHOlu7uOs+vtIpzsPFIxgX+DTMHuBSBSOK8gzmJpA9w8NdYELW7iKW
 a3f6L1pb16MhGGnHBgfVg2ByeEFKZUO/exF+Mr9KJzHFnofwMNOQS6pG6Quq9/lrjEaO
 hrU9PjmMi+79blIl2Xk3ZvR18PY6utCqOYT8hzJaJyverE5rM2gyZVXW6uIcDQVmxfx4
 ooYH6MhP/VGV0OeIwjx8b1GNu7gY4J8dZJw76Mr1xpa9rwtyy3VEyJ4X4BwIzpl4MofU
 WGPQ==
X-Gm-Message-State: AOJu0YwYDllq8OOhUgWo6EmPbIM+pc385/R1dl8pcD3mWRluyPOsqRsj
 m7xhX1mR5zsr9ueMFVH7h+emFQ==
X-Google-Smtp-Source: AGHT+IEOEbkJyMZYcrSB3r0Ptjm9n/WQK4Or7RAIaMa1LmFRvZP26hWHhjNKy/KJo+2T16VyRq7m+w==
X-Received: by 2002:a05:600c:198b:b0:408:53ac:141f with SMTP id
 t11-20020a05600c198b00b0040853ac141fmr8895270wmq.24.1700586581811; 
 Tue, 21 Nov 2023 09:09:41 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:36 +0000
Subject: [PATCH 13/21] mach-snapdragon: generalise board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-13-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=36990;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=F9yVZ/xLKRj2qS1I+fkGw16cz4IP6TiuehbXk5Sfxd8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ24mu3ac9mD+7G+Z4sLk8rpz1gWv93XHZK+76/Ck6
 M/ekr68o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk/xlGhqXHfddkmGt+DXK7
 ts5sdau1oYXrwk7ZObk94V83Rd+6b8XwPzfz3hK/+lumOmEsIW5lxanTb9zICd559uURduY0j8L
 1PwE=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Historically, Qualcomm boards have relied on heavy hardcoding in U-Boot,
in many cases to the specific SoC but also to the board itself (e.g.
memory map). This has been largely resolved by modernising the Qualcomm
drivers in U-Boot, however the board code still largely follows this
model.

This patch removes the board specific memory maps and duplicated board
init code, replacing it with generic init code.

The memory map is now built at runtime based on data read from DT, this
allows for the memory map to be provided without having to recompile
U-Boot. Support is also added for booting with appended DTBs, so that
the first-stage bootloader can populate the memory map for us.

The sdm845 specific init code is dropped entirely, it set an environment
variable depending on if a button was pressed, but this variable wasn't
used in U-Boot, and could be written to use the button command instead.

The KASLR detection is also dropped as with appended dtb, the kaslr seed
can be read directly from the DTB passed to U-Boot.

A new qcom_defconfig is added, with the aim of providing a generic
U-Boot configuration that will work on as many Qualcomm boards as
possible. It replaces the defconfig files for the Dragonboard 845c,
Galaxy S9, and QCS404 EVB. For now the db410c and 820c are excluded as
they still have some board code left.

Similarly, the config headers for db845c, starqltechn, and qcs404-evb
are replaced by a single qcom header.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                                      |   2 +
 arch/arm/Kconfig                                 |   3 +
 arch/arm/dts/Makefile                            |   9 +-
 arch/arm/mach-snapdragon/Kconfig                 |  96 +++----------
 arch/arm/mach-snapdragon/Makefile                |   6 +-
 arch/arm/mach-snapdragon/board.c                 | 166 +++++++++++++++++++++++
 arch/arm/mach-snapdragon/init_sdm845.c           |  73 ----------
 arch/arm/mach-snapdragon/sysmap-apq8016.c        |  31 -----
 arch/arm/mach-snapdragon/sysmap-apq8096.c        |  31 -----
 arch/arm/mach-snapdragon/sysmap-qcs404.c         |  43 ------
 arch/arm/mach-snapdragon/sysmap-sdm845.c         |  31 -----
 board/qualcomm/dragonboard410c/Kconfig           |  15 --
 board/qualcomm/dragonboard410c/dragonboard410c.c |  25 ----
 board/qualcomm/dragonboard820c/Kconfig           |  15 --
 board/qualcomm/dragonboard820c/dragonboard820c.c |  39 +-----
 board/qualcomm/dragonboard845c/Kconfig           |  12 --
 board/qualcomm/qcs404-evb/Kconfig                |  15 --
 board/qualcomm/qcs404-evb/qcs404-evb.c           |  21 +--
 configs/dragonboard410c_chainloaded_defconfig    |  11 +-
 configs/dragonboard410c_defconfig                |   6 +-
 configs/dragonboard820c_defconfig                |   6 +-
 configs/dragonboard845c_defconfig                |  29 ----
 configs/qcom_defconfig                           |  71 ++++++++++
 configs/qcs404evb_defconfig                      |   5 +-
 configs/starqltechn_defconfig                    |  41 ------
 include/configs/dragonboard845c.h                |  20 ---
 include/configs/qcom.h                           |  21 +++
 include/configs/qcs404-evb.h                     |  20 ---
 28 files changed, 306 insertions(+), 557 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cd102eaa070..40b03d2647d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	arch/arm/mach-snapdragon/
+F:	configs/qcom_defconfig
 F:	drivers/button/button-qcom-pmic.c
 F:	drivers/clk/qcom/
 F:	drivers/gpio/msm_gpio.c
@@ -583,6 +584,7 @@ F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
 F:	drivers/spmi/spmi-msm.c
 F:	drivers/usb/host/ehci-msm.c
+F:	include/configs/qcom.h
 
 ARM STI
 M:	Patrice Chotard <patrice.chotard@foss.st.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1add4282f336..1faa70bb658d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1075,7 +1075,10 @@ config ARCH_SNAPDRAGON
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select OF_BOARD
+	select SAVE_PREV_BL_FDT_ADDR
 	imply CMD_DM
+	imply LINUX_KERNEL_IMAGE_HEADER
 
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family"
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 55aceb51cdb0..ec63749fa912 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -600,10 +600,11 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 
 dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
 
-dtb-$(CONFIG_TARGET_DRAGONBOARD410C) += dragonboard410c.dtb
-dtb-$(CONFIG_TARGET_DRAGONBOARD820C) += dragonboard820c.dtb
-dtb-$(CONFIG_TARGET_STARQLTECHN) += starqltechn.dtb
-dtb-$(CONFIG_TARGET_QCS404EVB) += qcs404-evb.dtb
+dtb-$(CONFIG_ARCH_SNAPDRAGON) += dragonboard410c.dtb \
+	dragonboard820c.dtb \
+	dragonboard845c.dtb \
+	starqltechn.dtb \
+	qcs404-evb.dtb
 
 dtb-$(CONFIG_TARGET_STEMMY) += ste-ux500-samsung-stemmy.dtb
 
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index f897c393464f..96e44e2c5491 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -3,6 +3,9 @@ if ARCH_SNAPDRAGON
 config SYS_SOC
 	default "snapdragon"
 
+config SYS_VENDOR
+	default "qualcomm"
+
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
@@ -12,91 +15,24 @@ config SPL_SYS_MALLOC_F
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
-config SDM845
-	bool "Qualcomm Snapdragon 845 SoC"
-	select LINUX_KERNEL_IMAGE_HEADER
-	imply CLK_QCOM_SDM845
-	imply PINCTRL_QCOM_SDM845
-	imply BUTTON_QCOM_PMIC
-
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
-choice
-	prompt "Snapdragon board select"
-
-config TARGET_DRAGONBOARD410C
-	bool "96Boards Dragonboard 410C"
-	select BOARD_LATE_INIT
-	select ENABLE_ARM_SOC_BOOT0_HOOK
-	imply CLK_QCOM_APQ8016
-	imply PINCTRL_QCOM_APQ8016
-	imply BUTTON_QCOM_PMIC
+config SYS_BOARD
+	string "Qualcomm custom board"
 	help
-	  Support for 96Boards Dragonboard 410C. This board complies with
-	  96Board Open Platform Specifications. Features:
-	  - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
-	  - 1GiB RAM
-	  - 8GiB eMMC, uSD slot
-	  - WiFi, Bluetooth and GPS module
-	  - 2x Host, 1x Device USB port
-	  - HDMI
-	  - 20-pin low speed and 40-pin high speed expanders, 4 LED, 3 buttons
+	  The Dragonboard 410c and 820c have additional board init
+	  code that isn't shared with other Qualcomm boards.
+	  Based on this option board/qualcomm/<CONFIG_SYS_BOARD> will
+	  be used.
 
-config TARGET_DRAGONBOARD820C
-	bool "96Boards Dragonboard 820C"
-	select LINUX_KERNEL_IMAGE_HEADER
-	imply CLK_QCOM_APQ8096
-	imply PINCTRL_QCOM_APQ8096
-	imply BUTTON_QCOM_PMIC
+config SYS_CONFIG_NAME
+	string "Board configuration name"
+	default SYS_BOARD if SYS_BOARD != ""
+	default "qcom"
 	help
-	  Support for 96Boards Dragonboard 820C. This board complies with
-	  96Board Open Platform Specifications. Features:
-	  - Qualcomm Snapdragon 820C SoC - APQ8096 (4xKyro CPU)
-	  - 3GiB RAM
-	  - 32GiB UFS drive
-
-config TARGET_DRAGONBOARD845C
-	bool "96Boards Dragonboard 845C"
-	help
-	  Support for 96Boards Dragonboard 845C aka Robotics RB3 Development
-	  Platform. This board complies with 96Boards Open Platform
-	  Specifications. Features:
-	  - Qualcomm Snapdragon SDA845 SoC
-	  - 4GiB RAM
-	  - 64GiB UFS drive
-	select MISC_INIT_R
-	select SDM845
-
-config TARGET_STARQLTECHN
-	bool "Samsung S9 SM-G9600(starqltechn)"
-	help
-	  Support for Samsung S9 SM-G9600(starqltechn) board.
-	  Features:
-	  - Qualcomm Snapdragon SDM845 SoC
-	  - 4GiB RAM
-	  - 64GiB UFS drive
-	select MISC_INIT_R
-	select SDM845
-
-config TARGET_QCS404EVB
-	bool "Qualcomm Technologies, Inc. QCS404 EVB"
-	select LINUX_KERNEL_IMAGE_HEADER
-	imply CLK_QCOM_QCS404
-	imply PINCTRL_QCOM_QCS404
-	help
-	  Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
-	  Features:
-	  - Qualcomm Snapdragon QCS404 SoC
-	  - 1GiB RAM
-	  - 8GiB eMMC, uSD slot
-
-endchoice
-
-source "board/qualcomm/dragonboard410c/Kconfig"
-source "board/qualcomm/dragonboard820c/Kconfig"
-source "board/qualcomm/dragonboard845c/Kconfig"
-source "board/samsung/starqltechn/Kconfig"
-source "board/qualcomm/qcs404-evb/Kconfig"
+	  This option contains information about board configuration name.
+	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
+	  will be used for board configuration.
 
 endif
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index d02432df8b04..857171e593da 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,8 +2,4 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SDM845) += sysmap-sdm845.o
-obj-$(CONFIG_SDM845) += init_sdm845.o
-obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
-obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
-obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
+obj-y += board.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
new file mode 100644
index 000000000000..521390ed6eed
--- /dev/null
+++ b/arch/arm/mach-snapdragon/board.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common initialisation for Qualcomm Snapdragon boards.
+ *
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#include <asm/armv8/mmu.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <asm/psci.h>
+#include <asm/system.h>
+#include <dm/device.h>
+#include <env.h>
+#include <init.h>
+#include <linux/arm-smccc.h>
+#include <linux/bug.h>
+#include <linux/psci.h>
+#include <linux/sizes.h>
+#include <malloc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
+
+struct mm_region *mem_map = rbx_mem_map;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	int ret;
+	phys_addr_t start, size;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret < 0)
+		return ret;
+
+	if (WARN(CONFIG_NR_DRAM_BANKS < 2, "CONFIG_NR_DRAM_BANKS must be at least 2"))
+		return 0;
+
+	/* Some bootloaders populate the RAM banks in the wrong order -_- */
+	if (gd->bd->bi_dram[1].start < gd->bd->bi_dram[0].start) {
+		debug("Swapping DRAM banks\n");
+		start = gd->bd->bi_dram[1].start;
+		size = gd->bd->bi_dram[1].size;
+		gd->bd->bi_dram[1].start = gd->bd->bi_dram[0].start;
+		gd->bd->bi_dram[1].size = gd->bd->bi_dram[0].size;
+		gd->bd->bi_dram[0].start = start;
+		gd->bd->bi_dram[0].size = size;
+	}
+
+	return 0;
+}
+
+static void show_psci_version(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	debug("PSCI:  v%ld.%ld\n",
+	      PSCI_VERSION_MAJOR(res.a0),
+	      PSCI_VERSION_MINOR(res.a0));
+}
+
+void *board_fdt_blob_setup(int *err)
+{
+	phys_addr_t fdt;
+	/* Return DTB pointer passed by ABL */
+	*err = 0;
+	fdt = get_prev_bl_fdt_addr();
+
+	/*
+	 * If we bail then the board will simply not boot, instead let's
+	 * try and use the FDT built into U-Boot if there is one...
+	 * This avoids having a hard dependency on the previous stage bootloader
+	 */
+	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K))) {
+		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
+		return (void *)gd->fdt_blob;
+	}
+
+	return (void *)fdt;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+/*
+ * Some boards still need board specific init code, they can implement that by
+ * overriding this function.
+ *
+ * FIXME: get rid of board specific init code
+ */
+void __weak qcom_board_init(void)
+{
+}
+
+int board_init(void)
+{
+	show_psci_version();
+	qcom_board_init();
+	return 0;
+}
+
+static void build_mem_map(void)
+{
+	int i;
+
+	/*
+	 * Ensure the peripheral block is sized to correctly cover the address range
+	 * up to the first memory bank.
+	 * Don't map the first page to ensure that we actually trigger an abort on a
+	 * null pointer access rather than just hanging.
+	 * FIXME: we should probably split this into more precise regions
+	 */
+	mem_map[0].phys = 0x1000;
+	mem_map[0].virt = mem_map[0].phys;
+	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
+	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+
+	debug("Configured memory map:\n");
+	debug("  0x%016llx - 0x%016llx: Peripheral block\n",
+	      mem_map[0].phys, mem_map[0].phys + mem_map[0].size);
+
+	/*
+	 * Now add memory map entries for each DRAM bank, ensuring we don't
+	 * overwrite the list terminator
+	 */
+	for (i = 0; i < ARRAY_SIZE(rbx_mem_map) - 2 && gd->bd->bi_dram[i].size; i++) {
+		if (i == ARRAY_SIZE(rbx_mem_map) - 1) {
+			log_warning("Too many DRAM banks!\n");
+			break;
+		}
+		mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
+		mem_map[i + 1].virt = mem_map[i + 1].phys;
+		mem_map[i + 1].size = gd->bd->bi_dram[i].size;
+		mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				     PTE_BLOCK_INNER_SHARE;
+
+		debug("  0x%016llx - 0x%016llx: DDR bank %d\n",
+		      mem_map[i + 1].phys, mem_map[i + 1].phys + mem_map[i + 1].size, i);
+	}
+}
+
+u64 get_page_table_size(void)
+{
+	return SZ_64K;
+}
+
+void enable_caches(void)
+{
+	build_mem_map();
+
+	icache_enable();
+	dcache_enable();
+}
diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
deleted file mode 100644
index 067acc9a6f44..000000000000
--- a/arch/arm/mach-snapdragon/init_sdm845.c
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Common init part for boards based on SDM845
- *
- * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
- */
-
-#include <button.h>
-#include <init.h>
-#include <env.h>
-#include <common.h>
-#include <asm/system.h>
-#include <asm/gpio.h>
-#include <dm.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-void reset_cpu(void)
-{
-	psci_system_reset();
-}
-
-__weak int board_init(void)
-{
-	return 0;
-}
-
-/* Check for vol- and power buttons */
-__weak int misc_init_r(void)
-{
-	struct udevice *btn;
-	int ret;
-	enum button_state_t state;
-
-	ret = button_get_by_label("pwrkey", &btn);
-	if (ret < 0) {
-		printf("Couldn't find power button!\n");
-		return ret;
-	}
-
-	state = button_get_state(btn);
-	if (state == BUTTON_ON) {
-		env_set("key_power", "1");
-		printf("Power button pressed\n");
-	} else {
-		env_set("key_power", "0");
-	}
-
-	/*
-	 * search for kaslr address, set by primary bootloader by searching first
-	 * 0x100 relocated bytes at u-boot's initial load address range
-	 */
-	uintptr_t start = gd->ram_base;
-	uintptr_t end = start + 0x800000;
-	u8 *addr = (u8 *)start;
-	phys_addr_t *relocaddr = (phys_addr_t *)gd->relocaddr;
-	u32 block_size = 0x1000;
-
-	while (memcmp(addr, relocaddr, 0x100) && (uintptr_t)addr < end)
-		addr += block_size;
-
-	if ((uintptr_t)addr >= end)
-		printf("KASLR not found in range 0x%lx - 0x%lx", start, end);
-	else
-		env_set_addr("KASLR", addr);
-
-	return 0;
-}
diff --git a/arch/arm/mach-snapdragon/sysmap-apq8016.c b/arch/arm/mach-snapdragon/sysmap-apq8016.c
deleted file mode 100644
index ffa3f9aa3532..000000000000
--- a/arch/arm/mach-snapdragon/sysmap-apq8016.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm APQ8016 memory map
- *
- * (C) Copyright 2016 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
- */
-
-#include <common.h>
-#include <asm/armv8/mmu.h>
-
-static struct mm_region apq8016_mem_map[] = {
-	{
-		.virt = 0x0UL, /* Peripheral block */
-		.phys = 0x0UL, /* Peripheral block */
-		.size = 0x8000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL, /* DDR */
-		.phys = 0x80000000UL, /* DDR */
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = apq8016_mem_map;
diff --git a/arch/arm/mach-snapdragon/sysmap-apq8096.c b/arch/arm/mach-snapdragon/sysmap-apq8096.c
deleted file mode 100644
index 0614f8308d02..000000000000
--- a/arch/arm/mach-snapdragon/sysmap-apq8096.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm APQ8096 memory map
- *
- * (C) Copyright 2017 Jorge Ramirez Ortiz <jorge.ramirez-ortiz@linaro.org>
- */
-
-#include <common.h>
-#include <asm/armv8/mmu.h>
-
-static struct mm_region apq8096_mem_map[] = {
-	{
-		.virt = 0x0UL, /* Peripheral block */
-		.phys = 0x0UL, /* Peripheral block */
-		.size = 0x10000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL, /* DDR */
-		.phys = 0x80000000UL, /* DDR */
-		.size = 0xC0000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = apq8096_mem_map;
diff --git a/arch/arm/mach-snapdragon/sysmap-qcs404.c b/arch/arm/mach-snapdragon/sysmap-qcs404.c
deleted file mode 100644
index 64ca4adf1bd1..000000000000
--- a/arch/arm/mach-snapdragon/sysmap-qcs404.c
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm QCS404 memory map
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-#include <common.h>
-#include <asm/armv8/mmu.h>
-
-static struct mm_region qcs404_mem_map[] = {
-	{
-		.virt = 0x0UL, /* Peripheral block */
-		.phys = 0x0UL, /* Peripheral block */
-		.size = 0x8000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL, /* DDR */
-		.phys = 0x80000000UL, /* DDR */
-		.size = 0x05900000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x89600000UL, /* DDR */
-		.phys = 0x89600000UL, /* DDR */
-		.size = 0x162000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL, /* DDR */
-		.phys = 0xa0000000UL, /* DDR */
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = qcs404_mem_map;
diff --git a/arch/arm/mach-snapdragon/sysmap-sdm845.c b/arch/arm/mach-snapdragon/sysmap-sdm845.c
deleted file mode 100644
index 721ac411665c..000000000000
--- a/arch/arm/mach-snapdragon/sysmap-sdm845.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm SDM845 memory map
- *
- * (C) Copyright 2021 Dzmitry Sankouski <dsankousk@gmail.com>
- */
-
-#include <common.h>
-#include <asm/armv8/mmu.h>
-
-static struct mm_region sdm845_mem_map[] = {
-	{
-		.virt = 0x0UL, /* Peripheral block */
-		.phys = 0x0UL, /* Peripheral block */
-		.size = 0x10000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL, /* DDR */
-		.phys = 0x80000000UL, /* DDR */
-		.size = 0x200000000UL, /* 8GiB - maximum allowed memory */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = sdm845_mem_map;
diff --git a/board/qualcomm/dragonboard410c/Kconfig b/board/qualcomm/dragonboard410c/Kconfig
deleted file mode 100644
index 03bd7ae309cd..000000000000
--- a/board/qualcomm/dragonboard410c/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_DRAGONBOARD410C
-
-config SYS_BOARD
-	default "dragonboard410c"
-
-config SYS_VENDOR
-	default "qualcomm"
-
-config SYS_SOC
-	default "apq8016"
-
-config SYS_CONFIG_NAME
-	default "dragonboard410c"
-
-endif
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 3ee7e806918b..bee8034ef92f 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -23,21 +23,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int dram_init(void)
-{
-	gd->ram_size = PHYS_SDRAM_1_SIZE;
-
-	return 0;
-}
-
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-
-	return 0;
-}
-
 int board_usb_init(int index, enum usb_init_type init)
 {
 	static struct udevice *pmic_gpio;
@@ -128,11 +113,6 @@ int misc_init_r(void)
 	return 0;
 }
 
-int board_init(void)
-{
-	return 0;
-}
-
 int board_late_init(void)
 {
 	char serial[16];
@@ -177,8 +157,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 			   "local-bd-address", mac, ARP_HLEN, 1);
 	return 0;
 }
-
-void reset_cpu(void)
-{
-	psci_system_reset();
-}
diff --git a/board/qualcomm/dragonboard820c/Kconfig b/board/qualcomm/dragonboard820c/Kconfig
deleted file mode 100644
index aff9af527128..000000000000
--- a/board/qualcomm/dragonboard820c/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_DRAGONBOARD820C
-
-config SYS_BOARD
-	default "dragonboard820c"
-
-config SYS_VENDOR
-	default "qualcomm"
-
-config SYS_SOC
-	default "apq8096"
-
-config SYS_CONFIG_NAME
-	default "dragonboard820c"
-
-endif
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index 2f0db628368b..ac7de711c588 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -27,24 +27,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int dram_init(void)
-{
-	gd->ram_size = PHYS_SDRAM_SIZE;
-
-	return 0;
-}
-
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size  = PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}
-
 static void sdhci_power_init(void)
 {
 	const u32 TLMM_PULL_MASK = 0x3;
@@ -113,28 +95,9 @@ static void sdhci_power_init(void)
 			rclk[i].val  << rclk[i].bit);
 }
 
-static void show_psci_version(void)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
-
-	printf("PSCI:  v%ld.%ld\n",
-	       PSCI_VERSION_MAJOR(res.a0),
-		PSCI_VERSION_MINOR(res.a0));
-}
-
-int board_init(void)
+void qcom_board_init(void)
 {
 	sdhci_power_init();
-	show_psci_version();
-
-	return 0;
-}
-
-void reset_cpu(void)
-{
-	psci_system_reset();
 }
 
 /* Check for vol- button - if pressed - stop autoboot */
diff --git a/board/qualcomm/dragonboard845c/Kconfig b/board/qualcomm/dragonboard845c/Kconfig
deleted file mode 100644
index 52fdff288d59..000000000000
--- a/board/qualcomm/dragonboard845c/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-if TARGET_DRAGONBOARD845C
-
-config SYS_BOARD
-	default "dragonboard845c"
-
-config SYS_CONFIG_NAME
-	default "dragonboard845c"
-
-config SYS_VENDOR
-	default "qualcomm"
-
-endif
diff --git a/board/qualcomm/qcs404-evb/Kconfig b/board/qualcomm/qcs404-evb/Kconfig
deleted file mode 100644
index 32657c7d5e31..000000000000
--- a/board/qualcomm/qcs404-evb/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_QCS404EVB
-
-config SYS_BOARD
-	default "qcs404-evb"
-
-config SYS_VENDOR
-	default "qualcomm"
-
-config SYS_SOC
-	default "qcs404"
-
-config SYS_CONFIG_NAME
-	default "qcs404-evb"
-
-endif
diff --git a/board/qualcomm/qcs404-evb/qcs404-evb.c b/board/qualcomm/qcs404-evb/qcs404-evb.c
index 249dca7e72f1..1a4b1f97a3ae 100644
--- a/board/qualcomm/qcs404-evb/qcs404-evb.c
+++ b/board/qualcomm/qcs404-evb/qcs404-evb.c
@@ -14,16 +14,10 @@
 #include <asm/gpio.h>
 #include <asm/global_data.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-int board_init(void)
+void qcom_board_init(void)
 {
 	struct udevice *pmic_gpio;
 	struct gpio_desc usb_vbus_boost_pin;
@@ -34,29 +28,22 @@ int board_init(void)
 					&pmic_gpio);
 	if (ret < 0) {
 		printf("Failed to find pms405_gpios@c000 node.\n");
-		return ret;
+		return;
 	}
 
 	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pmic_gpio),
 				  "usb_vbus_boost_pin");
 	if (node < 0) {
 		printf("Failed to find usb_hub_reset_pm dt node.\n");
-		return node;
+		return;
 	}
 	ret = gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
 					 &usb_vbus_boost_pin, 0);
 	if (ret < 0) {
 		printf("Failed to request usb_hub_reset_pm gpio.\n");
-		return ret;
+		return;
 	}
 
 	dm_gpio_set_dir_flags(&usb_vbus_boost_pin,
 			      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-
-	return 0;
-}
-
-void reset_cpu(void)
-{
-	psci_system_reset();
 }
diff --git a/configs/dragonboard410c_chainloaded_defconfig b/configs/dragonboard410c_chainloaded_defconfig
index d6860f546e9e..a114d8291bf9 100644
--- a/configs/dragonboard410c_chainloaded_defconfig
+++ b/configs/dragonboard410c_chainloaded_defconfig
@@ -1,17 +1,15 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="dragonboard410c"
 CONFIG_COUNTER_FREQUENCY=19000000
-CONFIG_ARCH_SNAPDRAGON=y
-CONFIG_TARGET_QCOM=y
 CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_SYS_MALLOC_LEN=0x802000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="dragonboard410c"
-CONFIG_SYS_BOARD="dragonboard410c"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_SYS_LOAD_ADDR=0x80080000
-CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -20,7 +18,6 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_LINUX_KERNEL_IMAGE_HEADER=y
 CONFIG_SYS_PROMPT="dragonboard410c => "
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_CBSIZE=512
@@ -38,6 +35,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
@@ -52,13 +50,12 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
 CONFIG_SPMI_MSM=y
-CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index b338326e34c0..4274150eebe9 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -1,9 +1,10 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="dragonboard410c"
 CONFIG_COUNTER_FREQUENCY=19000000
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x8f600000
 CONFIG_SYS_MALLOC_LEN=0x802000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x2000
@@ -38,7 +39,9 @@ CONFIG_CMD_TIMER=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
+CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
 CONFIG_FASTBOOT_FLASH=y
@@ -52,6 +55,7 @@ CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index 15d12bb0831d..5a8cfb7d7a25 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -1,14 +1,13 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="dragonboard820c"
 CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x80080000
 CONFIG_SYS_MALLOC_LEN=0x804000
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="dragonboard820c"
-CONFIG_TARGET_DRAGONBOARD820C=y
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 820C"
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_DISTRO_DEFAULTS=y
@@ -35,12 +34,15 @@ CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="mmc"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
+CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
deleted file mode 100644
index a69d82761a8d..000000000000
--- a/configs/dragonboard845c_defconfig
+++ /dev/null
@@ -1,29 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=19000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_SNAPDRAGON=y
-CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
-CONFIG_TARGET_DRAGONBOARD845C=y
-CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 845C"
-CONFIG_SYS_LOAD_ADDR=0x80000000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=5
-CONFIG_SAVE_PREV_BL_FDT_ADDR=y
-CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=64
-CONFIG_SYS_CBSIZE=512
-CONFIG_CMD_GPIO=y
-# CONFIG_NET is not set
-CONFIG_CLK=y
-CONFIG_MSM_GPIO=y
-CONFIG_QCOM_PMIC_GPIO=y
-CONFIG_PINCTRL=y
-CONFIG_DM_PMIC=y
-CONFIG_PMIC_QCOM=y
-CONFIG_MSM_GENI_SERIAL=y
-CONFIG_SPMI_MSM=y
-CONFIG_LMB_MAX_REGIONS=64
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
new file mode 100644
index 000000000000..0b1dd1dbccfc
--- /dev/null
+++ b/configs/qcom_defconfig
@@ -0,0 +1,71 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
+CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_VBE is not set
+# CONFIG_BOOTMETH_SCRIPT is not set
+CONFIG_BOOTDELAY=1
+CONFIG_USE_PREBOOT=y
+CONFIG_LOG_MAX_LEVEL=9
+CONFIG_LOG_DEFAULT_LEVEL=4
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_LOG=y
+CONFIG_EFI_PARTITION=y
+# CONFIG_NET is not set
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_SDM845=y
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_DM_KEYBOARD=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM_QCS404=y
+CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SPMI_MSM=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_STORAGE=y
+CONFIG_UFS=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_FONT_8X16 is not set
+CONFIG_VIDEO_FONT_16X32=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_NO_FB_CLEAR=y
+CONFIG_VIDEO_SIMPLE=y
+CONFIG_HEXDUMP=y
+# CONFIG_GENERATE_SMBIOS_TABLE is not set
+CONFIG_LMB_MAX_REGIONS=64
diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
index 9e72f64f7849..7daaa449ffbd 100644
--- a/configs/qcs404evb_defconfig
+++ b/configs/qcs404evb_defconfig
@@ -1,11 +1,10 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="qcs404-evb"
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_DEFAULT_DEVICE_TREE="qcs404-evb"
-CONFIG_DM_RESET=y
-CONFIG_TARGET_QCS404EVB=y
 CONFIG_IDENT_STRING="\nQualcomm QCS404-EVB"
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_FIT=y
@@ -31,6 +30,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_NET is not set
 CONFIG_CLK=y
+CONFIG_CLK_QCOM_QCS404=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_MISC=y
@@ -42,6 +42,7 @@ CONFIG_PHY=y
 CONFIG_PHY_QCOM_USB_HS_28NM=y
 CONFIG_PHY_QCOM_USB_SS=y
 CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
diff --git a/configs/starqltechn_defconfig b/configs/starqltechn_defconfig
deleted file mode 100644
index 5b85ce5fe96f..000000000000
--- a/configs/starqltechn_defconfig
+++ /dev/null
@@ -1,41 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=19000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_SNAPDRAGON=y
-CONFIG_DEFAULT_DEVICE_TREE="starqltechn"
-CONFIG_TARGET_STARQLTECHN=y
-CONFIG_IDENT_STRING="\nSamsung S9 SM-G9600"
-CONFIG_SYS_LOAD_ADDR=0x80000000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=0
-CONFIG_SAVE_PREV_BL_FDT_ADDR=y
-CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=64
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
-CONFIG_CMD_BOOTMENU=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_BMP=y
-# CONFIG_NET is not set
-CONFIG_BUTTON=y
-CONFIG_CLK=y
-CONFIG_MSM_GPIO=y
-CONFIG_QCOM_PMIC_GPIO=y
-CONFIG_DM_KEYBOARD=y
-CONFIG_BUTTON_KEYBOARD=y
-CONFIG_PINCTRL=y
-CONFIG_DM_PMIC=y
-CONFIG_PMIC_QCOM=y
-CONFIG_MSM_GENI_SERIAL=y
-CONFIG_SPMI_MSM=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_FONT_8X16 is not set
-CONFIG_VIDEO_FONT_16X32=y
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_VIDEO_SIMPLE=y
-CONFIG_VIDEO_DT_SIMPLEFB=y
-CONFIG_LMB_MAX_REGIONS=64
diff --git a/include/configs/dragonboard845c.h b/include/configs/dragonboard845c.h
deleted file mode 100644
index 14a8a2ca049e..000000000000
--- a/include/configs/dragonboard845c.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration file for Dragonboard 845c, based on Qualcomm SDA845 chip
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-#ifndef __CONFIGS_SDM845_H
-#define __CONFIGS_SDM845_H
-
-#include <linux/sizes.h>
-
-#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"bootm_size=0x5000000\0"	\
-	"bootm_low=0x80000000\0"	\
-	"bootcmd=bootm $prevbl_initrd_start_addr\0"
-
-#endif
diff --git a/include/configs/qcom.h b/include/configs/qcom.h
new file mode 100644
index 000000000000..e50b3bce5cdd
--- /dev/null
+++ b/include/configs/qcom.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration file for Qualcomm Snapdragon boards
+ *
+ * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
+ * (C) Copyright 2023 Linaro Ltd.
+ */
+
+#ifndef __CONFIGS_SNAPDRAGON_H
+#define __CONFIGS_SNAPDRAGON_H
+
+#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
+
+/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
+#define CFG_EXTRA_ENV_SETTINGS \
+	"stdin=serial,button-kbd\0"	\
+	"stdout=serial,vidconsole\0"	\
+	"stderr=serial,vidconsole\0" \
+	"bootcmd=bootm $prevbl_initrd_start_addr\0"
+
+#endif
diff --git a/include/configs/qcs404-evb.h b/include/configs/qcs404-evb.h
deleted file mode 100644
index 9501d43665e9..000000000000
--- a/include/configs/qcs404-evb.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration file for QCS404 evaluation board
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-#ifndef __CONFIGS_QCS404EVB_H
-#define __CONFIGS_QCS404EVB_H
-
-#include <linux/sizes.h>
-
-#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"bootm_size=0x5000000\0"	\
-	"bootm_low=0x80000000\0"	\
-	"bootcmd=bootm $prevbl_initrd_start_addr\0"
-
-#endif

-- 
2.42.1

