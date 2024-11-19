Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E5D6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AFF889634;
	Wed, 20 Nov 2024 01:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggTfNvA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659ED895D2; Tue, 19 Nov 2024 23:46:55 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB4588DB2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43159469053so3644895e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056412; x=1732661212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEFYfRYfTxAJOM+Xjr0Dp4zS0D1pIYZO5UEvV+EOBO0=;
 b=ggTfNvA2ed3UlGBEy8WV7CC6maKC+0DHnz7t8fj8HuyKtNGdvOMC4UI4IB2E66289d
 lnY+Tr5a5WgQxdFfKQbKk7Q213gS9tB3+cUEH2Mt8vjsv6hH/PmAVnY6OtRDnhOlhAcV
 C+HWOpTACiCZYhonG2UJ9Sy9olaA3y+JoCFWRHPDbiX4pmplQsAPK2A1S1GP+cKA3YXC
 D+nUUTvNmcp2p15lHWG8BNKtYT9Nj6hMA0ERKHMvQcZ0s6n8Jado748E104dDGllVSzV
 hPjkZvZyqi6APVG1B2+vL738jVpznPYQGci4pMoVjSECpR2XuNOpDlRwSmKoJQfxX4uV
 gnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056412; x=1732661212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEFYfRYfTxAJOM+Xjr0Dp4zS0D1pIYZO5UEvV+EOBO0=;
 b=ImZsztJ7w1vd9jh8v1QWR9Sz/XcYNXFdUbWU26+Uaviin9YhTne8xBpRcmLcNqfCBH
 H8DWBfhckn2GYUy8VytmciLf9DRIqMPt7vDcGqZGDHcIiX7ux8akFHx8atbWIXp62e0h
 qzgJR5KjMoKdTOYEylXGTqZDgitV4bjNtTpWlijmJrIhz18FnAA42vIvCh+bzN+prt7w
 Yx7grLsYvAkAT/QpYRBOU5zPtU62uSXHPUNKYpnpMtkgBf7S9EA3nwJ4I90kUaTVqBza
 qqJIUkULBF5MQ2U4roq6HHz1KoKZfRE64l/qMoeFKaq8NRzNNer43jnflI2a4rc4KOPu
 b9sw==
X-Gm-Message-State: AOJu0YzyGV3icIgTQlZAqxx6olj81xcrpJkKPwbU+9XbxJNCM7L/LfWU
 x3tKFQIOA8I7jWaVO+cTRoaC0VHjqcOY1LsjpWxEAwhplD0hafwHH7zM4vrh
X-Gm-Gg: ASbGncssvjshjma759zitkxiucoYDCH8jD+9wWi71u4cmWzW2RIcci10c5NagSh3x13
 LhqTcK1CNLTaKNXrxNudqefBJuHwy/6P/Zgw1CJsMzDaKTcJjIaTm+Y3jaoJAFD5jWDgrdBGwdd
 mK+hEpBiR7nb/y9JD5Kh+CeDwhXMeD1pyZC11VFMBcYhussdqKs4UxmQGlCJcGWR0gXGZQNcyiQ
 OZGJFfOyLB8NxX3YqIz9kh4SsDw8lOEABS3/CWi2sZC6B1LmOyiIqRqiCCbMOeDazibjAZiaOXB
 9fY2Ju2sdzOqdDKrkKk1gE3svXq2
X-Google-Smtp-Source: AGHT+IExgpauUzLpdLYQYhp4n+cW/3tZpzMnn6WOkBY/tRr11TDRnLOSrQOsL7O0B6cvXQpy7qCqPA==
X-Received: by 2002:a05:600c:4f4f:b0:42c:bb35:b6d0 with SMTP id
 5b1f17b1804b1-433489861cbmr2275905e9.1.1732056412414; 
 Tue, 19 Nov 2024 14:46:52 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:51 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 04/10] ARM: socfpga: add Enclustra storage switch
Date: Tue, 19 Nov 2024 22:46:37 +0000
Message-Id: <20241119224643.27692-5-l.rubusch@gmail.com>
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

Some of Enclustra's Intel SoMs need gpio muxing for setting up
the boot media. This can be done by switching dip switches and also in
software. The image in this case can be loaded from SD card, and flashed
to the eMMC or QSPI. After, the dip switches can set the boot select
accordingly. With altera_set_storage MMC|EMMC|QSPI from off the u-boot
shell, the media is usually switched.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_arria10_enclustra_mercury_aa1.dts |  17 ++
 board/enclustra/mercury_aa1/Makefile          |   8 +
 .../mercury_aa1/aa1_set_storage_cmd.c         | 190 ++++++++++++++++++
 doc/board/enclustra/mercury-aa1.rst           |  25 +++
 4 files changed, 240 insertions(+)
 create mode 100644 board/enclustra/mercury_aa1/Makefile
 create mode 100644 board/enclustra/mercury_aa1/aa1_set_storage_cmd.c

diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
index e8cc51a7b8..c038b2352e 100644
--- a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 /* The arria10 family */
 #include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
 
@@ -17,6 +19,13 @@
 		i2c1 = &i2c0;
 		spi0 = &qspi;
 	};
+
+	altera_set_storage {
+		compatible = "enclustra,altera_set_storage";
+		status = "okay";
+		oe-gpios = <&portb 5 GPIO_ACTIVE_HIGH>;
+		sel-gpios = <&portc 6 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &qspi {
@@ -35,6 +44,14 @@
 	};
 };
 
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
 /* Carrier board support */
 #if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
 # include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
diff --git a/board/enclustra/mercury_aa1/Makefile b/board/enclustra/mercury_aa1/Makefile
new file mode 100644
index 0000000000..53c84d8156
--- /dev/null
+++ b/board/enclustra/mercury_aa1/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2024 Enclustra GmbH
+
+ifeq ($(CONFIG_SPL_BUILD),)
+
+obj-y += aa1_set_storage_cmd.o
+
+endif
diff --git a/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
new file mode 100644
index 0000000000..31c5ddb23b
--- /dev/null
+++ b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <init.h>
+#include <dm.h>
+#include <dm/uclass.h>
+#include <asm-generic/gpio.h>
+#include <asm/io.h>
+
+/* Pin muxing */
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
+static const struct udevice_id altera_set_storage_match[] = {
+	{ .compatible = "enclustra,altera_set_storage" },
+	{ }
+};
+
+U_BOOT_DRIVER(altera_set_storage) = {
+	.name		= "altera_set_storage",
+	.id			= UCLASS_MISC,
+	.of_match	= altera_set_storage_match,
+};
+
+static void enclustra_mercury_aa1_write(const u32 *pinmux_arr, int len)
+{
+	u32 i, offset, value;
+
+	for (i = 0; i < len; i += 2) {
+		offset = pinmux_arr[i];
+		value = pinmux_arr[i + 1];
+		writel(value, ALTERA_PINMUX_OFFS + offset);
+	}
+}
+
+static void enclustra_mercury_aa1_set_mux_mmc(void)
+{
+	static const u32 pinmux_arr[] = {0x0c, 0x8,	// IO4 connected to SDMMC
+					 0x10, 0x8,	// IO5
+					 0x14, 0x8,	// IO6
+					 0x18, 0x8,	// IO7
+					 0x1c, 0x8,	// IO8
+					 0x20, 0x8,	// IO9
+					 0x24, 0xf,	// IO10 connected to GPIO
+					 0x28, 0xf,	// IO11
+					 0x2c, 0xf,	// IO12
+					 0x30, 0xf,	// IO13
+					 0x34, 0xf,	// IO14
+					 0x38, 0xf};	// IO15
+	enclustra_mercury_aa1_write(pinmux_arr, ARRAY_SIZE(pinmux_arr));
+}
+
+static void enclustra_mercury_aa1_set_mux_emmc(void)
+{
+	static const u32 pinmux_arr[] = {0x0c, 0x8,	// IO4
+					 0x10, 0x8,	// IO5
+					 0x14, 0x8,	// IO6
+					 0x18, 0x8,	// IO7
+					 0x1c, 0x8,	// IO8
+					 0x20, 0x8,	// IO9
+					 0x24, 0xf,	// IO10
+					 0x28, 0xf,	// IO11
+					 0x2c, 0x8,	// IO12
+					 0x30, 0x8,	// IO13
+					 0x34, 0x8,	// IO14
+					 0x38, 0x8};	// IO15
+	enclustra_mercury_aa1_write(pinmux_arr, ARRAY_SIZE(pinmux_arr));
+}
+
+static void enclustra_mercury_aa1_set_mux_qspi(void)
+{
+	static const u32 pinmux_arr[] = {0x0c, 0x4,	// IO4 connected to QSPI
+					 0x10, 0x4,	// IO5
+					 0x14, 0x4,	// IO6
+					 0x18, 0x4,	// IO7
+					 0x1c, 0x4,	// IO8
+					 0x20, 0x4,	// IO9
+					 0x24, 0xf,	// IO10
+					 0x28, 0xf,	// IO11
+					 0x2c, 0xf,	// IO12
+					 0x30, 0xf,	// IO13
+					 0x34, 0xf,	// IO14
+					 0x38, 0xf};	// IO15
+	enclustra_mercury_aa1_write(pinmux_arr, ARRAY_SIZE(pinmux_arr));
+}
+
+static int altera_set_storage(struct udevice *dev, int store)
+{
+	struct gpio_desc gpio_flash_sel;
+	struct gpio_desc gpio_flash_oe;
+	int ret;
+
+	if (store == altera_current_storage)
+		return CMD_RET_FAILURE;
+
+	/* oe: portb 5 */
+	ret = gpio_request_by_name(dev, "oe-gpios", 0,
+				   &gpio_flash_oe, GPIOD_IS_OUT);
+
+	if (ret) {
+		printf("ERROR: GPIO oe not found\n");
+		return log_msg_ret("gpio", ret);
+	}
+
+	/* sel: portc 6 */
+	ret = gpio_request_by_name(dev, "sel-gpios", 0,
+				   &gpio_flash_sel, GPIOD_IS_OUT);
+	if (ret) {
+		printf("ERROR: GPIO sel not found\n");
+		ret = CMD_RET_FAILURE;
+		goto err;
+	}
+
+	switch (store) {
+	case ALTERA_MMC:
+		enclustra_mercury_aa1_set_mux_mmc();
+		dm_gpio_set_value(&gpio_flash_sel, 0);
+		dm_gpio_set_value(&gpio_flash_oe, 0);
+		altera_current_storage = ALTERA_MMC;
+		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	case ALTERA_EMMC:
+		enclustra_mercury_aa1_set_mux_emmc();
+		dm_gpio_set_value(&gpio_flash_sel, 1);
+		dm_gpio_set_value(&gpio_flash_oe, 1);
+		altera_current_storage = ALTERA_EMMC;
+		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	case ALTERA_QSPI:
+		enclustra_mercury_aa1_set_mux_qspi();
+		dm_gpio_set_value(&gpio_flash_sel, 1);
+		dm_gpio_set_value(&gpio_flash_oe, 0);
+		altera_current_storage = ALTERA_QSPI;
+		writel(QSPI_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
+		break;
+	default:
+		altera_current_storage = ALTERA_NONE;
+		break;
+	}
+
+	ret = CMD_RET_SUCCESS;
+	dm_gpio_free(dev, &gpio_flash_sel);
+err:
+	dm_gpio_free(dev, &gpio_flash_oe);
+
+	return ret;
+}
+
+static int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
+				  int argc, char * const argv[])
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(altera_set_storage), &dev);
+	if (ret)
+		return ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp(argv[1], "mmc"))
+		return altera_set_storage(dev, ALTERA_MMC);
+	else if (!strcasecmp(argv[1], "qspi"))
+		return altera_set_storage(dev, ALTERA_QSPI);
+	else if (!strcasecmp(argv[1], "emmc"))
+		return altera_set_storage(dev, ALTERA_EMMC);
+	else
+		return CMD_RET_USAGE;
+
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
+	   "Set non volatile memory access",
+	   "<MMC|QSPI|EMMC> - Set access for the selected memory device");
diff --git a/doc/board/enclustra/mercury-aa1.rst b/doc/board/enclustra/mercury-aa1.rst
index dec7cc3bdd..cba36aae2e 100644
--- a/doc/board/enclustra/mercury-aa1.rst
+++ b/doc/board/enclustra/mercury-aa1.rst
@@ -151,6 +151,31 @@ Alternative boot media are possible as officially documented by Enclustra.
 Note: eMMC and QSPI can be flashed from off the u-boot shell. Usually after
 flashing, the correct boot mode needs to be set by a BSEL switch.
 
+In the u-boot shell use the following command to switch between the boot media.
+This can be used to flash e.g. eMMC or QSPI with an image file stored on the SD
+card. Approaches are described in detail in the official Enclustra
+documentation according to their releases mentioned as links.
+
+ .. code-block:: bash
+
+    Hit any key to stop autoboot:  0
+    => altera_set_storage
+    altera_set_storage - Set non volatile memory access
+    Usage:
+    altera_set_storage <MMC|QSPI|EMMC> - Set access for the selected memory device
+    => altera_set_storage QSPI
+    => sf probe
+    SF: Detected s25fl512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
+    => altera_set_storage MMC
+    => mmc rescan
+    => mmc list
+    mmc@ff808000: 0 (SD)
+    => altera_set_storage EMMC
+    => mmc rescan
+    => mmc list
+    mmc@ff808000: 0 (eMMC)
+    =>
+
 Before turning on the setup, make sure to have the correct voltage configured
 at the carrier board, using the jumpers on the voltage pin header. Also make
 sure to have switched to the correct boot media using typically some dip
-- 
2.39.2

