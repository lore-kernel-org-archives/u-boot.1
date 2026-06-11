Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D9ACD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2208488A;
	Thu, 11 Jun 2026 16:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CeFf6eQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD0783FEC; Thu, 11 Jun 2026 16:18:39 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B1A84884
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-517dc520840so23144511cf.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187516; x=1781792316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFLsFgD216dwFEw2PuZ5U0Tsyf2N9FUaMAKJOFGVJ00=;
 b=CeFf6eQsBqnPelS/XMITkQd5w8m4MdU1AszJCBG8kDZLR9/eE/JhP1vYl3hYAk1HaW
 PqKtYfvnZXFips2YEqK2qiPdcEBMyRJNOyWbMEwzEji7frgKxBd7TD5mS6iXBmkkjGEm
 Y2EX09rB0LSJZ2M2JVdDmYUzy/SoEpdTtO99lOQtk1Q/Bt5zmn3dT5o6QAtBub04rsP8
 VYIwaEK6SXFG4OMWYJYws1E9GntAeVZZnnrrVoQigCetfS03fubX9rIeU4uPCvTYexUE
 jzZ/qLA4/Crjtf2FWjSRGcCIkTew1miBJcELMgZ0Cz/xE7SQkgXPn+eouU0EP6PCjx16
 HmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187516; x=1781792316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AFLsFgD216dwFEw2PuZ5U0Tsyf2N9FUaMAKJOFGVJ00=;
 b=We5jBtSXDRK/Hreblp2V2R55rh9r1+2RZzdluJ/x0d8AbRNc8MyvOuDssdtUOJE12l
 0fw7W7VIAFXb4pakkjXuU4cP5jB/nn74fSJjCdRIPofYrBs1VxeHOQSSu8XccPaa+BEr
 Q+zaosQ0w7+ky1mpSu9hE4jM2xWX4euWWP/AENeP0Y6ZSI7gTYNEhwMm2hXOYfy47Jun
 ka+ooLemNwXnf7pI8yCRFAVVqo5AdQtcmgcOwSNFDz6g9svQ3aF5cWa3p0QW/wAtOcmp
 K02UseDdpdyyhRdf/5njRwEmVrjngdYbF1dWr246VlDIQogm98ZrZKY+i66H3lm6K4QV
 0Byg==
X-Gm-Message-State: AOJu0YxNgPlSMlwrYU/zJ6d0n/HFGJx8Sh8d26lXITZLCcO2F30yHR1t
 EouVF/w+4zgZYZBrZfxRyhdxRn5SD39UFPXH6Ra88u4j+5thzxewyQ2rxjNhS5ab
X-Gm-Gg: Acq92OHOdTLMKmc3rLOvBCWUDLIML4VR0BuUGB6sR0w0coXFE/W88VdgBD42zHnK8eQ
 yvlm9BxyNaWdL33ax8r0eIcLUV5lxxhpmlBQUP7gsYIoYDrvUgPg+xXj0o9z7opjyp+NMvnxn9n
 13H5lN1hFyBjfBrtsX+gjP8Oy2DyC5OdCEpfPWM5liUCSbOj/4u0af/+nrO3qGKnyHjan0zpnTg
 qGgxK3Gr3FmFKBf+tV9FtZ6+TB5sWbdNtXk+1QUU64sT3Ao/pHp0R3NnpU62zKKZ0hiVaKuHczx
 15+Rh51Os7kDjQyb6VPCzqxPEhGed0l5S7YLF5o/JuzBz/OD4pruIdeWFGf3+PDS9O4gY8n2TIY
 NAZzmqs79PZPy+4FMC4JpYkfYy8L/0tdYVespFO4V34kAFGfIJfNzBwSKpu0sN4HARQizZAiWa7
 58yyB42FSpWmaL3K5ZenMbZf/dH6Ka0VLv8vvsFsI7enrxRyQy1AlwUJZZm0BFdF684B+QTMoB4
 /Ks3MztoOjQ0TH+b6o=
X-Received: by 2002:a05:622a:511:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-517ee28dbdcmr44545771cf.41.1781187515773; 
 Thu, 11 Jun 2026 07:18:35 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:35 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 4/9] spl: k1: enable SPI NOR flash detection and boot
Date: Thu, 11 Jun 2026 10:18:06 -0400
Message-Id: <20260611141811.68904-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

Add nor_early_init() to probe the QSPI controller and SPI NOR flash
in SPL.  Switch spl_boot_device() to BOOT_DEVICE_SPI so the board
boots from SPI flash.

Change the default device tree to k1-musepi-pro, whose u-boot
overlay already defines the QSPI controller and flash node with
bootph-pre-ram markers.  Enable the required SPI driver model and
flash config options.

Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- Renamed and reworked from v1 11/16 "board: k1: enable SPI NOR
  flash in SPL".
- New k1-musepi-pro-u-boot.dtsi overlay; default DT switched to it.
- SPL probes SPI NOR in early init and loads next stage from it.
Changes in v3:
- None.

 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 273 +++++++++++++++++++++++
 board/spacemit/k1/spl.c                  |  24 +-
 configs/spacemit_k1_defconfig            |  25 ++-
 3 files changed, 319 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi

diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
new file mode 100644
index 00000000000..8a9a2a09de9
--- /dev/null
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include "binman.dtsi"
+
+/ {
+	aliases {
+		console = &uart0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
+
+&syscon_mpmu {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4";
+};
+
+&syscon_apbc {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>,
+		 <&syscon_mpmu CLK_PLL1_31P5>,
+		 <&syscon_apmu CLK_PMUA_ACLK>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&osc_32k {
+	bootph-pre-ram;
+};
+
+&vctcxo_1m {
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	bootph-pre-ram;
+};
+
+&syscon_mpmu {
+	bootph-pre-ram;
+};
+
+&pll {
+	bootph-pre-ram;
+};
+
+&syscon_apmu {
+	bootph-pre-ram;
+};
+
+&syscon_apbc {
+	bootph-pre-ram;
+};
+
+&i2c2 {
+	bootph-pre-ram;
+	status = "okay";
+	pinctrl-0 = <&i2c2_0_cfg>;
+	pinctrl-names = "default";
+	resets = <&syscon_apbc RESET_TWSI2>;
+
+	eeprom@50 {
+		bootph-pre-ram;
+		status = "okay";
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
+		pagesize = <16>;
+		read-only;
+		size = <256>;
+
+		nvmem-layout {
+			compatible = "onie,tlv-layout";
+
+			mac-address {
+				#nvmem-cell-cells = <1>;
+			};
+
+			num-macs {
+			};
+
+			serial-number {
+			};
+		};
+	};
+};
+
+&i2c8 {
+	bootph-pre-ram;
+	pinctrl-0 = <&i2c8_cfg>;
+	pinctrl-names = "default";
+	resets = <&syscon_apbc RESET_TWSI8>;
+	status = "okay";
+
+	pmic@41 {
+		bootph-pre-ram;
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		status = "okay";
+
+		regulators {
+			buck1 {
+				bootph-pre-ram;
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3_1v8: buck3 {
+				bootph-pre-ram;
+				regulator-name = "vdd_1v8";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				bootph-pre-ram;
+				regulator-name = "vdd_1v8_mmc";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
+};
+
+&qspi {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+
+	flash@0 {
+		bootph-pre-ram;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		m25p,fast-read;
+		broken-flash-reset;
+		status = "okay";
+	};
+};
+
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 2afabc72a3f..da4169fbc8c 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
+#include <spi_flash.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
@@ -306,6 +307,26 @@ void ddr_early_init(void)
 		log_info("DDR is not ready\n");
 }
 
+void nor_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SPI, 0, &dev);
+	if (ret)
+		panic("Fail to detect spi controller.\n");
+	udelay(10);
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &dev);
+	if (ret)
+		log_info("Fail to detect spi nor flash.\n");
+	udelay(10);
+}
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+}
+
 void board_init_f(ulong dummy)
 {
 	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
@@ -331,11 +352,12 @@ void board_init_f(ulong dummy)
 	pmic_init();
 
 	ddr_early_init();
+	nor_early_init();
 }
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_NOR;
+	return BOOT_DEVICE_SPI;
 }
 
 void spl_board_init(void)
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index e71c079bef2..64c724c62a5 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -1,15 +1,19 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SYS_MALLOC_F_LEN=0x5000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_STACK=0xc083fb00
 CONFIG_SPL_TEXT_BASE=0xc0801000
 CONFIG_SPL_BSS_START_ADDR=0xc083fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_ADDR=0xc00000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x100000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x31000
@@ -23,6 +27,8 @@ CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
@@ -64,3 +70,18 @@ CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_FSL_QSPI=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_MEM=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
+CONFIG_CMD_SPI=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_SPI_FLASH_TINY=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
-- 
2.25.1

