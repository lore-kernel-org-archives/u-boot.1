Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84074CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E256184869;
	Wed, 20 May 2026 00:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Hl9AX9FK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99E184876; Wed, 20 May 2026 00:48:31 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E88E846A5
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3697421c2a8so2171576a91.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230908; x=1779835708;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Db/VGc9IUBpS7LIjAl99nwiI1J9Tf62emGYHpWES4o4=;
 b=Hl9AX9FKwC2E39bnqMkXtwmR/CES1HWayYwXdCb1wc1D1PoYzwwnyddeFOYv/hicXT
 gXxjru6rIEH+En/SqL6lCKVlkPExNVMjCyWzTTZr0gxwhzTvEaG/3R6IvA36BZ+0sdQV
 6FxjviqDJtX6z1Ycl9StgoK2t7vRkM7A9e0sirDDW6X2scZ4prRHfguMzqEUwuaYE8Dj
 T/T6NinHBKj7D6mE7/KvkzAd5cEP4P1D9TRSWTobgAKVun2u42CFsOaohTJCiNkkvc3V
 Fz0MVxdXG/iphxmCx5JsMgIyEhbUhkDaVYGWzXt2dxXI12yyAg2/DswHAKjq9J/mWyvg
 u6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230908; x=1779835708;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Db/VGc9IUBpS7LIjAl99nwiI1J9Tf62emGYHpWES4o4=;
 b=sr1B2b4a7k+cffPXngEeyoewgwlv+k9jTxgXCajqychq83pX1VvReG9QNsiRlDR6Kq
 XGlkm4vRZaemZatQAQfsw5U59PcAjYTqBaVGOfaYM9U7Jhu8vB9MgUKr/H6nSIzlnElp
 5qOXXnIHF+JzxKJu5YD5BSTXt13OEs/kJACt1gR8hUFJGWeySHITQTCUqQ5jyLZwoQ99
 4eb0PN2OQn/9BuvvILbQTEVr+9Xi0Xrp4qwztffRcxd0571tsKPsst+Wx3xOvUKGuOZ7
 JL+NTiCxlwcee3/bk/Y0iiG7c1/fyK3CdyohIyuOH+PmOXaxnXp+FiqBB2ROG3CE/Ihf
 gxYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WIgy84vOCbekLv1sOa02RWR1pCWoclYzRjuBw6ScNWN7+54NjZhi5MSwDqVbfoWt5Mo/LEvs=@lists.denx.de
X-Gm-Message-State: AOJu0YzYlZzjexj50Dfxqso5r95sDc077PTSyiaEfMCkuz0VJB9B3VCQ
 Xd5cTComYvjSAxi8iOy9M4ipXkRudjJfJE8l9F+e63XswhI7kZp+O2AKGh2GNDe9SEg=
X-Gm-Gg: Acq92OEGzJGTSyzVMvlJBXV9uIynmSZbF7DR4pUpMPaDYmXnLbOmhLv7QomWkS7RAq8
 zWH6Hy/LfS0LNbhSlGWPcUv7eKxLrK9XTvSlvSdf6LKMNV0YaIJEtYcYEokcRQCUo9l85vE2kwh
 5R/SgqC9kF5ICAMRwRkbIgZKEGLVytzOD0iGa437FrW+Fy4Wxy2A5ZsT27ulec/3c9OkrwrEgaU
 vRIS2osTfkW6UL07CrGLim6QWg5dz6fmpXvMlrgxKR5M2M4hB+2rI4n6G3bt235gcLX9rJCEVWj
 iDDJ1ujGJJrutQ5g6ja5FFYULRoxr9th+wgA+9tz/JS+5QNmCbEAIK1U9d1ithe52eFlZOt5sWZ
 sj7RIsXkz0NKRrQcfctFOoOd3tQky/4fqrjhl09dBGN/Uj2/ohUizu8aO6UfvRq2SZEhW95aWU9
 0oN7gfs6wUicsc4V0EIdQvWZcR4CZ6DA5JKXK7pDZJgVs=
X-Received: by 2002:a17:90a:d08:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-3697421c71fmr9290436a91.16.1779230907353; 
 Tue, 19 May 2026 15:48:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:48:27 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:48 -0400
Subject: [PATCH v2 4/9] spl: k1: enable SPI NOR flash detection and boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-4-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

Add nor_early_init() to probe the QSPI controller and SPI NOR flash
in SPL.  Switch spl_boot_device() to BOOT_DEVICE_SPI so the board
boots from SPI flash.

Change the default device tree to k1-musepi-pro, whose u-boot
overlay already defines the QSPI controller and flash node with
bootph-pre-ram markers.  Enable the required SPI driver model and
flash config options.

Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- Renamed and reworked from v1 11/16 "board: k1: enable SPI NOR
  flash in SPL".
- New k1-musepi-pro-u-boot.dtsi overlay; default DT switched to it.
- SPL probes SPI NOR in early init and loads next stage from it.
---
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 273 +++++++++++++++++++++++++++++++
 board/spacemit/k1/spl.c                  |  24 ++-
 configs/spacemit_k1_defconfig            |  25 ++-
 3 files changed, 319 insertions(+), 3 deletions(-)

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
2.43.0

