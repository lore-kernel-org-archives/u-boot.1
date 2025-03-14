Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FBDC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5A181F30;
	Fri, 14 Mar 2025 20:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kCBLlbtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D6881F4E; Fri, 14 Mar 2025 20:00:19 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5F481F32
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39127512371so1573486f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978817; x=1742583617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4OhGuTxm1bRKu0kRC4zn5po3MiSj5HdbJoKMzRr5m9s=;
 b=kCBLlbttZWGaEGwsYdsyOMFR6mF+yQMYGhzwUbynSYccTnJDtBQXUzwtqk/LtY7Kdi
 U5kic0TnXYF3s8hYAtPeGzZkrRXca4Tjmtl2bmAGWlt0hEpHAVjOE2Sw/9YgBrK9KyAE
 6nI55Bq8P4VcoR9qfkwjhf4LhGU35hNciTgbRMVv/lHpsKF4r5Boj8wHKJDqSNwWOFQb
 rzKHAVO8MBc1JNkf5La7JMgh7BkjYVqY0OpTs7cGaTw2SFBWSgEbl0LS3JuKCwRqyPlE
 97pS0dN5k904CRLJ3HUTwn62/MpdPv6NAwd03756uZjoxZSNftz31h4je3rZxYCsBacV
 I6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978817; x=1742583617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OhGuTxm1bRKu0kRC4zn5po3MiSj5HdbJoKMzRr5m9s=;
 b=dAUhMSF0H5y+3JTLpwNKuFNkDo1GWi4adfBq7G9DRLfu+1oGy5G6qOzURHdZjDLB7n
 tQu6drdxUU4skc0xYM/vTIfv+ABEEdxZ0jcKlwrzyoysAhimIzZ5NrUxHBZBjjHwokR3
 MiWuyFKL8dQ0dMcif7cQxSjT9TuKTQxb8PSAVWDtGmHktMRxrPkr+F9li+qT3CK+XW10
 rPBkoBqSqvkZRnElMprErtuzs+o+oUTObkiCOSlY+HLUt8UtBKBSpqMehPJERA1C0pXv
 J/HetQHqOr2dQvCilKvFEqDNmoV1NGOwoeqEuSMbWJQra2gDamhHEuu+b/g/GaTTsyeI
 +eJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuz6LV4YasWJSHpXMy2NtXM2PKDvVEZZ71zlYrdAXvfq0pAjWzBh8XFZkkygkZQYpG0ZR5I6I=@lists.denx.de
X-Gm-Message-State: AOJu0YxXT2UNIgCCwn7MyLH8uRpleTDcOytaU0z62IZBXDG9ifaYtWRh
 SC9NsPnVGlCyJ0VFvRQNp1Mh3GO73MnXYN9wxhM0Rk2kIS2JHyYxBLQMEw==
X-Gm-Gg: ASbGncuExa01E6C/L4nYxyXP4pendi2iTQIk3eGyydQaRNfgm72ZdattlZmQBlHfg9L
 Xtmj1TL7xpro+O0nERgOpj3RDSKs6V58NVxGWLmp1eYJaz4kFy3FfhK0HqtzGjPm/g8kCmsEUkD
 d/L0Xb3X6wfzq2Ox66R8Wtx9YHcvxLqRMf607FbJWaVnAfhpQX7QHBXprroswRrqFXYjoTRpPLe
 1JmYDDVz24tMENzeJoZzfxgahllAr4FBlv3XxYoGulsFElMKEdcKo7MwO5vVz99TA5JitijMW/7
 eZJngR/EEGQMonovofj3o9Kvs+fbcZ8A2im0tyBdCOXq9He8bp07BAaswRpqsLo5CCEsRtTNHXS
 s/dpSAaU+lsfbDw==
X-Google-Smtp-Source: AGHT+IGKwUlltNof/Uv9WBxhmSJroSHH+0UtQbagG2gGyzyy7CUKNaJp4Js2pqEOKhX9FnEPNczung==
X-Received: by 2002:a5d:584a:0:b0:391:2192:ccd6 with SMTP id
 ffacd0b85a97d-3971ee44b62mr5747286f8f.39.1741978816753; 
 Fri, 14 Mar 2025 12:00:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/6] airoha: Add initial support for Airoha AN7581 SoC
Date: Fri, 14 Mar 2025 19:59:21 +0100
Message-ID: <20250314185941.27834-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
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

Add initial support for Airoha AN7581 SoC. This adds the initial Kconfig
and Makefile entry for the SoC, an U-Boot specific DTSI and initial config
for it. Also add the initial code for CPU and RAM initialization.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/Kconfig                     |  9 ++++
 arch/arm/Makefile                    |  1 +
 arch/arm/dts/an7581-u-boot.dtsi      | 18 +++++++
 arch/arm/dts/en7581-evb-u-boot.dtsi  | 11 ++++
 arch/arm/mach-airoha/Kconfig         | 32 ++++++++++++
 arch/arm/mach-airoha/Makefile        |  5 ++
 arch/arm/mach-airoha/an7581/Makefile |  3 ++
 arch/arm/mach-airoha/an7581/init.c   | 47 +++++++++++++++++
 arch/arm/mach-airoha/cpu.c           | 20 +++++++
 board/airoha/an7581/MAINTAINERS      |  5 ++
 board/airoha/an7581/Makefile         |  3 ++
 board/airoha/an7581/an7581_rfb.c     | 16 ++++++
 configs/an7581_evb_defconfig         | 78 ++++++++++++++++++++++++++++
 include/configs/an7581.h             | 19 +++++++
 14 files changed, 267 insertions(+)
 create mode 100644 arch/arm/dts/an7581-u-boot.dtsi
 create mode 100644 arch/arm/dts/en7581-evb-u-boot.dtsi
 create mode 100644 arch/arm/mach-airoha/Kconfig
 create mode 100644 arch/arm/mach-airoha/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/init.c
 create mode 100644 arch/arm/mach-airoha/cpu.c
 create mode 100644 board/airoha/an7581/MAINTAINERS
 create mode 100644 board/airoha/an7581/Makefile
 create mode 100644 board/airoha/an7581/an7581_rfb.c
 create mode 100644 configs/an7581_evb_defconfig
 create mode 100644 include/configs/an7581.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index da6f1174934..4729ac39257 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -600,6 +600,13 @@ choice
 	prompt "Target select"
 	default TARGET_HIKEY
 
+config ARCH_AIROHA
+	bool "Airoha SoCs"
+	select DM
+	select OF_CONTROL
+	help
+	  Support for the Airoha soc.
+
 config ARCH_AT91
 	bool "Atmel AT91"
 	select GPIO_EXTRA_HEADER
@@ -2251,6 +2258,8 @@ config SYS_KWD_CONFIG
 	  Path within the source directory to the kwbimage.cfg file to use
 	  when packaging the U-Boot image for use.
 
+source "arch/arm/mach-airoha/Kconfig"
+
 source "arch/arm/mach-apple/Kconfig"
 
 source "arch/arm/mach-aspeed/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7334e79965f..5ecadb2ef1b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -51,6 +51,7 @@ PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
+machine-$(CONFIG_ARCH_AIROHA)		+= airoha
 machine-$(CONFIG_ARCH_APPLE)		+= apple
 machine-$(CONFIG_ARCH_ASPEED)		+= aspeed
 machine-$(CONFIG_ARCH_AT91)		+= at91
diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
new file mode 100644
index 00000000000..0316b73f3a5
--- /dev/null
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x40000>;
+		};
+	};
+};
+
+&uart1 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/en7581-evb-u-boot.dtsi b/arch/arm/dts/en7581-evb-u-boot.dtsi
new file mode 100644
index 00000000000..ebd3b8b4958
--- /dev/null
+++ b/arch/arm/dts/en7581-evb-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
+
+#include "an7581-u-boot.dtsi"
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
new file mode 100644
index 00000000000..be3562ae3ff
--- /dev/null
+++ b/arch/arm/mach-airoha/Kconfig
@@ -0,0 +1,32 @@
+if ARCH_AIROHA
+
+config SYS_VENDOR
+	default "airoha"
+
+choice
+	prompt "Airoha board select"
+
+config TARGET_AN7581
+	bool "Airoha AN7581 SoC"
+	select ARM64
+	help
+	  The Airoha EN7581 is a ARM-based SoC with a quad-core Cortex-A7
+	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
+	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
+	  video interfaces supporting HDMI and MIPI, and video codec support.
+	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
+	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
+
+endchoice
+
+config SYS_SOC
+	default "an7581" if TARGET_AN7581
+
+config SYS_BOARD
+	default "an7581" if TARGET_AN7581
+
+config SYS_CONFIG_NAME
+	default "an7581" if TARGET_AN7581
+
+endif
+
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
new file mode 100644
index 00000000000..215a300373b
--- /dev/null
+++ b/arch/arm/mach-airoha/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= cpu.o
+
+obj-$(CONFIG_TARGET_AN7581) += an7581/
diff --git a/arch/arm/mach-airoha/an7581/Makefile b/arch/arm/mach-airoha/an7581/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-airoha/an7581/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
new file mode 100644
index 00000000000..cefe9c6db9e
--- /dev/null
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/system.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha AN7581\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+void reset_cpu(ulong addr)
+{
+	psci_system_reset();
+}
+
+static struct mm_region an7581_mem_map[] = {
+	{
+		/* DDR */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x20000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		0,
+	}
+};
+struct mm_region *mem_map = an7581_mem_map;
diff --git a/arch/arm/mach-airoha/cpu.c b/arch/arm/mach-airoha/cpu.c
new file mode 100644
index 00000000000..a578e964664
--- /dev/null
+++ b/arch/arm/mach-airoha/cpu.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <init.h>
+#include <wdt.h>
+#include <dm/uclass-internal.h>
+
+int arch_cpu_init(void)
+{
+	icache_enable();
+
+	return 0;
+}
+
+void enable_caches(void)
+{
+	/* Enable D-cache. I-cache is already enabled in start.S */
+	dcache_enable();
+}
diff --git a/board/airoha/an7581/MAINTAINERS b/board/airoha/an7581/MAINTAINERS
new file mode 100644
index 00000000000..28ec2fbf2ea
--- /dev/null
+++ b/board/airoha/an7581/MAINTAINERS
@@ -0,0 +1,5 @@
+AN7581
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+N:      airoha
+N:      an7581
diff --git a/board/airoha/an7581/Makefile b/board/airoha/an7581/Makefile
new file mode 100644
index 00000000000..70f8db7bce9
--- /dev/null
+++ b/board/airoha/an7581/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= an7581_rfb.o
diff --git a/board/airoha/an7581/an7581_rfb.c b/board/airoha/an7581/an7581_rfb.c
new file mode 100644
index 00000000000..aa73679d929
--- /dev/null
+++ b/board/airoha/an7581/an7581_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
new file mode 100644
index 00000000000..f09b5b603a2
--- /dev/null
+++ b/configs/an7581_evb_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="airoha/en7581-evb"
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="en7581-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/an7581.h b/include/configs/an7581.h
new file mode 100644
index 00000000000..64f04c9d9a5
--- /dev/null
+++ b/include/configs/an7581.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha AN7581
+ */
+
+#ifndef __AN7581_H
+#define __AN7581_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.48.1

