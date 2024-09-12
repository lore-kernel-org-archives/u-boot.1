Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CA5EE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3930988DF3;
	Thu, 12 Sep 2024 08:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QNFPykGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6643888D78; Thu, 12 Sep 2024 08:06:58 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD33388DBC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c3fa6a5415so100509a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121214; x=1726726014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YIWh4wn8O/oIZMzoqP64fR6MB1oKI85m8JDIeF0XUs=;
 b=QNFPykGv6ruh9z9AmzWdW72ozzQz0W3r9nP0Or9BJzKkHXD1YLVOX21Q6lz3dYXLr2
 IuRAvUi4zXS/usKdn7JRUCGDS8zEJzRWZjxBWPlAb029RLx0XWp42dEnCCzjHKfnI+Am
 Y6rE5LfulR3XRYZAekxatJU4mJDmsDRQ+XtClyUPHCdgYzLbt/7aOW4P05/DCOLz+Qvu
 0qN7x4Fsm/vryI4ZFbAW+3iGdBuEaI0cbWpmk2MUrvMc15Ky6HmhnvAhv+lSn5FGY9AA
 YfvVCJZftiGQpLFEts5WU//3diQqP0TxqcW7pu0fOq/V+tqpC9qzdgQMGTVzdj4t+I6J
 1yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121214; x=1726726014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YIWh4wn8O/oIZMzoqP64fR6MB1oKI85m8JDIeF0XUs=;
 b=JbEuRwMwqtDh4paCM4Nckil2zAnJoJlGLlSLCVnypoPMBfcpWH2Rx++NfG9PUm1+13
 Fhe+bRCj5rd/g2/Fh506KxtBjuURfNt78YvEDr+f0un3NxX4gIeiczDJuYJ0q08WNJWn
 69eA4DjIl8rjUMOB9X5KhKUIAJylRIUXO/fOC91KPSzH2JFM0JXQYTzIw6mCu22kMnLz
 EsqUkWyzNUF3oFnJhQOUe0SIWXQdEc8uRoElXWPtSP28aU8Jdb2A0LN+sF7OqPogMpFz
 VV+DEgbropD4EJa2+0+2yEzwtR9TVPvVxqDWuFUWpdv9PpREs0ispO/I4qEwc+K/Q0io
 B2Ww==
X-Gm-Message-State: AOJu0YwCdgM/lUgHP7iHAEJF9Q6/xDlxealAdpXS/XcOLbn5+lI6y9cf
 Be2sIN3hBx63z3pj2vS0wzDsC9tXHmweFBWD3r+A4dbzTcmmgisHu5eSLw==
X-Google-Smtp-Source: AGHT+IEWSYfhj8oQFF73MbDV0oiFEUy90YI3C0WRUXsgpOEFuLNS0rlVjaaG311Q26Y0xc/XDT/b6A==
X-Received: by 2002:a17:906:f857:b0:a90:3497:e138 with SMTP id
 a640c23a62f3a-a903497eb0amr17245066b.13.1726121214023; 
 Wed, 11 Sep 2024 23:06:54 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:53 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 3/9] ARM: socfpga: add Enclustra AA1 SoM support
Date: Thu, 12 Sep 2024 06:06:43 +0000
Message-Id: <20240912060649.190-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Introduce initial support for the Enclustra SoMs:

- Mercury AA1

Cover general board files for SD/MMC and QSPI boot modes. Integrate the
boards to kconfig. All build variants will depend on Quartus handoff
files, thus they depend on the particular Quartus design. The approach is
covered in the according documentation part.

Additionally add configuration for SD/MMC boot and QSPI bootmodes. Register
additional targets in kconfig.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig                 |   9 +
 board/enclustra/common/Kconfig                |   1 +
 board/enclustra/common/Makefile               |   4 +
 board/enclustra/mercury_aa1/Kconfig           |  15 ++
 board/enclustra/mercury_aa1/MAINTAINERS       |  10 +
 board/enclustra/mercury_aa1/Makefile          |   4 +
 board/enclustra/mercury_aa1/bitstream.its     |  32 +++
 board/enclustra/mercury_aa1/mercury_aa1.c     | 185 ++++++++++++++++++
 .../socfpga_enclustra_mercury_aa1_defconfig   |  78 ++++++++
 include/configs/socfpga_mercury_aa1.h         |  33 ++++
 10 files changed, 371 insertions(+)
 create mode 100644 board/enclustra/common/Kconfig
 create mode 100644 board/enclustra/common/Makefile
 create mode 100644 board/enclustra/mercury_aa1/Kconfig
 create mode 100644 board/enclustra/mercury_aa1/MAINTAINERS
 create mode 100644 board/enclustra/mercury_aa1/Makefile
 create mode 100644 board/enclustra/mercury_aa1/bitstream.its
 create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.c
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 include/configs/socfpga_mercury_aa1.h

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 6b6a162f56..d42e7817be 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -221,6 +221,10 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 	bool "Terasic SoCkit (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
 
+config TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+	bool "Enclustra Mercury+ AA1"
+	select TARGET_SOCFPGA_ARRIA10
+
 endchoice
 
 config SYS_BOARD
@@ -244,6 +248,7 @@ config SYS_BOARD
 	default "sr1500" if TARGET_SOCFPGA_SR1500
 	default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 
 config SYS_VENDOR
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
@@ -264,6 +269,7 @@ config SYS_VENDOR
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
+	default "enclustra" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 
 config SYS_SOC
 	default "socfpga"
@@ -289,5 +295,8 @@ config SYS_CONFIG_NAME
 	default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "socfpga_mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+
+source "board/enclustra/common/Kconfig"
 
 endif
diff --git a/board/enclustra/common/Kconfig b/board/enclustra/common/Kconfig
new file mode 100644
index 0000000000..51169bada3
--- /dev/null
+++ b/board/enclustra/common/Kconfig
@@ -0,0 +1 @@
+source "board/enclustra/mercury_aa1/Kconfig"
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
index 0000000000..11b7058d61
--- /dev/null
+++ b/board/enclustra/mercury_aa1/MAINTAINERS
@@ -0,0 +1,10 @@
+Enclustra Mercury+ AA1
+M:	Lothar Rubusch <l.rubusch@gmail.com>
+S:	Maintained
+F:	board/enclustra/mercury_aa1/
+F:	board/enclustra/common/
+F:	include/configs/socfpga_mercury_aa1.h
+F:	configs/socfpga_enclustra_mercury_aa1_defconfig
+F:	arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
+F:	arch/arm/dts/socfpga_enclustra_mercury_aa1_emmc_boot.dtsi
+F:	arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi
diff --git a/board/enclustra/mercury_aa1/Makefile b/board/enclustra/mercury_aa1/Makefile
new file mode 100644
index 0000000000..d830170dea
--- /dev/null
+++ b/board/enclustra/mercury_aa1/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2024 Enclustra GmbH
+
+obj-y += mercury_aa1.o
diff --git a/board/enclustra/mercury_aa1/bitstream.its b/board/enclustra/mercury_aa1/bitstream.its
new file mode 100644
index 0000000000..d16e4598de
--- /dev/null
+++ b/board/enclustra/mercury_aa1/bitstream.its
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
+			data = /incbin/("bitstream.periph.rbf");
+			type = "fpga";
+			arch = "arm";
+			compression = "none";
+		};
+
+		fpga-core-1 {
+			description = "FPGA core bitstream";
+			data = /incbin/("bitstream.core.rbf");
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
diff --git a/board/enclustra/mercury_aa1/mercury_aa1.c b/board/enclustra/mercury_aa1/mercury_aa1.c
new file mode 100644
index 0000000000..7de9b287d9
--- /dev/null
+++ b/board/enclustra/mercury_aa1/mercury_aa1.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <init.h>
+#include <dm/uclass.h>
+#include <asm-generic/gpio.h>
+#include <asm/io.h>
+
+/* Pin muxing */
+#if !defined(CONFIG_SPL_BUILD)
+
+#define ALTERA_NONE 0
+#define ALTERA_MMC 1
+#define ALTERA_QSPI 2
+#define ALTERA_EMMC 3
+#define MMC_CLK_DIV 0x9
+#define QSPI_CLK_DIV 0x384
+#define ALTERA_PINMUX_OFFS 0xffd07200
+#define ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE 0xFFD04078
+
+static int altera_current_storage = ALTERA_NONE;
+
+#endif
+
+#if !defined(CONFIG_SPL_BUILD)
+
+static void set_mux_mmc(void)
+{
+	u32 pinmux_arr[] = {0x0c, 0x8,  // IO4 connected to SDMMC
+			0x10, 0x8,	// IO5
+			0x14, 0x8,	// IO6
+			0x18, 0x8,	// IO7
+			0x1c, 0x8,	// IO8
+			0x20, 0x8,	// IO9
+			0x24, 0xf,	// IO10 connected to GPIO
+			0x28, 0xf,	// IO11
+			0x2c, 0xf,	// IO12
+			0x30, 0xf,	// IO13
+			0x34, 0xf,	// IO14
+			0x38, 0xf};	// IO15
+	u32 len, i, offset, value;
+
+	len = sizeof(pinmux_arr) / sizeof(u32);
+	for (i = 0; i < len; i += 2) {
+		offset = pinmux_arr[i];
+		value = pinmux_arr[i + 1];
+		writel(value, ALTERA_PINMUX_OFFS + offset);
+	}
+}
+
+static void set_mux_emmc(void)
+{
+	u32 pinmux_arr[] = {0x0c, 0x8,  // IO4
+		0x10, 0x8,	// IO5
+		0x14, 0x8,	// IO6
+		0x18, 0x8,	// IO7
+		0x1c, 0x8,	// IO8
+		0x20, 0x8,	// IO9
+		0x24, 0xf,	// IO10
+		0x28, 0xf,	// IO11
+		0x2c, 0x8,	// IO12
+		0x30, 0x8,	// IO13
+		0x34, 0x8,	// IO14
+		0x38, 0x8};	// IO15
+	u32 len, i, offset, value;
+
+	len = sizeof(pinmux_arr) / sizeof(u32);
+	for (i = 0; i < len; i += 2) {
+		offset = pinmux_arr[i];
+		value = pinmux_arr[i + 1];
+		writel(value, ALTERA_PINMUX_OFFS + offset);
+	}
+}
+
+static void set_mux_qspi(void)
+{
+	u32 pinmux_arr[] = {0x0c, 0x4,  // IO4 connected to QSPI
+		0x10, 0x4,	// IO5
+		0x14, 0x4,	// IO6
+		0x18, 0x4,	// IO7
+		0x1c, 0x4,	// IO8
+		0x20, 0x4,	// IO9
+		0x24, 0xf,	// IO10
+		0x28, 0xf,	// IO11
+		0x2c, 0xf,	// IO12
+		0x30, 0xf,	// IO13
+		0x34, 0xf,	// IO14
+		0x38, 0xf};	// IO15
+	u32 len, i, offset, value;
+
+	len = sizeof(pinmux_arr) / sizeof(u32);
+	for (i = 0; i < len; i += 2) {
+		offset = pinmux_arr[i];
+		value = pinmux_arr[i + 1];
+		writel(value, ALTERA_PINMUX_OFFS + offset);
+	}
+}
+
+void altera_set_storage(int store)
+{
+	unsigned int gpio_flash_sel;
+	unsigned int gpio_flash_oe;
+
+	if (store == altera_current_storage)
+		return;
+
+	if (gpio_lookup_name("portb5", NULL, NULL, &gpio_flash_oe)) {
+		printf("ERROR: GPIO not found\n");
+		return;
+	}
+
+	if (gpio_request(gpio_flash_oe, "flash_oe")) {
+		printf("ERROR: GPIO request failed\n");
+		return;
+	}
+
+	if (gpio_lookup_name("portc6", NULL, NULL, &gpio_flash_sel)) {
+		printf("ERROR: GPIO not found\n");
+		return;
+	}
+
+	if (gpio_request(gpio_flash_sel, "flash_sel")) {
+		printf("ERROR: GPIO request failed\n");
+		return;
+	}
+
+	switch (store) {
+	case ALTERA_MMC:
+		set_mux_mmc();
+		gpio_direction_output(gpio_flash_sel, 0);
+		gpio_direction_output(gpio_flash_oe, 0);
+		altera_current_storage = ALTERA_MMC;
+		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	case ALTERA_EMMC:
+		set_mux_emmc();
+		gpio_direction_output(gpio_flash_sel, 1);
+		gpio_direction_output(gpio_flash_oe, 1);
+		altera_current_storage = ALTERA_EMMC;
+		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	case ALTERA_QSPI:
+		set_mux_qspi();
+		gpio_direction_output(gpio_flash_sel, 1);
+		gpio_direction_output(gpio_flash_oe, 0);
+		altera_current_storage = ALTERA_QSPI;
+		writel(QSPI_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	default:
+		altera_current_storage = ALTERA_NONE;
+		break;
+	}
+
+	gpio_free(gpio_flash_sel);
+	gpio_free(gpio_flash_oe);
+}
+
+int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
+			   int argc, char * const argv[])
+{
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (!strcmp(argv[1], "MMC"))
+		altera_set_storage(ALTERA_MMC);
+	else if (!strcmp(argv[1], "QSPI"))
+		altera_set_storage(ALTERA_QSPI);
+	else if (!strcmp(argv[1], "EMMC"))
+		altera_set_storage(ALTERA_EMMC);
+	else
+		return CMD_RET_USAGE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
+	   "Set non volatile memory access",
+	   "<MMC|QSPI|EMMC> - Set access for the selected memory device");
+
+#endif
diff --git a/configs/socfpga_enclustra_mercury_aa1_defconfig b/configs/socfpga_enclustra_mercury_aa1_defconfig
new file mode 100644
index 0000000000..b475bd916d
--- /dev/null
+++ b/configs/socfpga_enclustra_mercury_aa1_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
+CONFIG_SF_DEFAULT_SPEED=10000000
+CONFIG_ENV_SIZE=0x80000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="enclustra-aa1"
+CONFIG_SPL_TEXT_BASE=0xFFE00000
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0xffe2b000
+CONFIG_TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1=y
+CONFIG_IDENT_STRING="socfpga_arria10"
+CONFIG_SPL_FS_FAT=y
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200"
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
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
+CONFIG_MMC_DW=y
+CONFIG_SPI_FLASH_SPANSION=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
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

