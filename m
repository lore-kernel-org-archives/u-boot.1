Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04D4C28B2F
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 14:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965D08104B;
	Sun,  9 Mar 2025 15:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lm5SwA5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9011281101; Sun,  9 Mar 2025 15:07:26 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2810B809A4
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so2974397f8f.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741529243; x=1742134043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pD2/LXPRxaQ4KBIHxSBdQeANvP4TR8cYl0F0gkvV/m4=;
 b=lm5SwA5mmggZWeU3uNxK7JRZbcgBGby9mryiW9aM8YDpeM7+5elF+ABUiV/ApDI4Ff
 RiR604OKYvBN1kWLx3jz/rc/lkNmAalcNWh1/Nfx/OWGCOox+LrNP3SBSQ1xGfGgYz0a
 ZJJcaq5eoTS5N+JpZSmSB+5iHXcHBs5GBoebVAin1P3u5JM4P5HIaU51zpHgv9Kt2yhB
 uzLzPmDf8/uNiUY/uWn6smEWhjB5zs0/iMsKj5LajqSJzREAZGc+L2NCHNDxIFoEtc1H
 shB6t57KaWcCTAmAZofZBvReWycIAYpxXlp08cjz4SauxPMGIE4OM1NZIJ9E+PlRFTAI
 S3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741529243; x=1742134043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pD2/LXPRxaQ4KBIHxSBdQeANvP4TR8cYl0F0gkvV/m4=;
 b=Y+vSO0SslE8EUVvQ1mkZUd4Ae5Ih+LYSdWZ59n42IW9My2ax6RU0nSGvWAVHV86zD8
 iwsHhekWkjMYq5Jgmk04MDp9FBvvgHkBYb3S/dIgHXasE6Ev9pOPJ8vJglgrM1cLvsK+
 RACxOXfV3zpyRSpLdtGnhpr2jaXUhhxzl+BOuQGlLA8pwbytlUqrVXGDcodiJyW/2/9j
 hS/OZWn9WDb5WE8AeK4DXm5GK54+EeGQh2GmedjKf/CoMkadQECWenIvj7mIq67MmZ2T
 BNzVh5Nm6OPCvNR3ZggQ8Xc+QK28vi/VmpKoteEt1kcUlkFC912JxzaHKFklhk+c6dxG
 Y5vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPvS1BHXb0GMqbgDiTkbAot3YnHH9TGf7QbZ2q3eLqzTWv2s0EV2/tetmVKammUulS/Nq9xTs=@lists.denx.de
X-Gm-Message-State: AOJu0YyWgTcFqfsZJxauEGKSKKdXVhbYX9vXiB6ZfZAZeP/stkH/zPlj
 5kOgjbqkE81Ou3OQkSnfLA6DnQVYrwTuCxqdC7hn+TzLl936Hmr5
X-Gm-Gg: ASbGncuj0QJuOvx9ZcGa+dLRHB4TpXFqLvmV1Hn1/SsPnp2MmtLQH0+FK/h5QFyVGP5
 Fvw6VSVy4SyO3UB11jrl9caV8+MIq+snsbE2w0feoIhxHODRWPEOQrORfh+IfimT6w/foNvjrg6
 kEWgQ51IvhIPycSkHOk8EsH3ncpuGNMD/0jRCxsra8X97J9cFgVYlRrro1Fp9SWY7HVTQrjXXkJ
 C1gZlPnOr2qvLd6fUYpZDf91riw//LT3J3ijP64Pea4kHUf/In9O4e6R3l4WJLHE2+ybly9JDf1
 5Pheop+yW19dtHo1bIuKJWt3mJcGv2gGpxWWUUUQ7GCOeJo1yhV7IOBJm3Ovqvgu19ZKL3ZS4SI
 MmAOYUrzR8hmP5w==
X-Google-Smtp-Source: AGHT+IEA3pLpTnhog0foPCpFHSLktFX4HEM6mGmShCw854hnGXCvYSWj3YgRb4bPvMYdpreELDM/Pw==
X-Received: by 2002:a5d:584b:0:b0:391:3aaf:1d3c with SMTP id
 ffacd0b85a97d-3913aaf1e44mr3663445f8f.45.1741529243431; 
 Sun, 09 Mar 2025 07:07:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm11946816f8f.0.2025.03.09.07.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 07:07:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 1/4] airoha: Add initial support for Airoha AN7581 SoC
Date: Sun,  9 Mar 2025 15:06:43 +0100
Message-ID: <20250309140652.23543-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309140652.23543-1-ansuelsmth@gmail.com>
References: <20250309140652.23543-1-ansuelsmth@gmail.com>
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
and Makefile entry for the SoC, an initial RFB DTS and initial config
for it. Also add the initial code for cpu and RAM initialization.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/Kconfig                     |   9 ++
 arch/arm/Makefile                    |   1 +
 arch/arm/dts/an7581-evb.dts          | 144 +++++++++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig         |  44 ++++++++
 arch/arm/mach-airoha/Makefile        |   5 +
 arch/arm/mach-airoha/an7581/Makefile |   3 +
 arch/arm/mach-airoha/an7581/init.c   |  47 +++++++++
 arch/arm/mach-airoha/cpu.c           |  20 ++++
 board/airoha/an7581/MAINTAINERS      |   6 ++
 board/airoha/an7581/Makefile         |   3 +
 board/airoha/an7581/an7581_rfb.c     |  16 +++
 configs/an7581_evb_defconfig         | 137 +++++++++++++++++++++++++
 include/configs/an7581.h             |  19 ++++
 13 files changed, 454 insertions(+)
 create mode 100644 arch/arm/dts/an7581-evb.dts
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
diff --git a/arch/arm/dts/an7581-evb.dts b/arch/arm/dts/an7581-evb.dts
new file mode 100644
index 00000000000..be600ad0664
--- /dev/null
+++ b/arch/arm/dts/an7581-evb.dts
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+/dts-v1/;
+
+/ {
+	compatible = "airoha,an7581";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
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
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@09000000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x09000000 0x0 0x20000>,
+			  <0x0 0x09080000 0x0 0x80000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+
+		its: gic-its@09020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cell = <1>;
+			reg = <0x0 0x090200000 0x0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <25000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	uart1: serial@1fbf0000 {
+		compatible = "ns16550";
+		reg = <0x0 0x1fbf0000 0x0 0x30>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <1843200>;
+		bootph-all;
+	};
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
new file mode 100644
index 00000000000..0470a01034f
--- /dev/null
+++ b/arch/arm/mach-airoha/Kconfig
@@ -0,0 +1,44 @@
+if ARCH_AIROHA
+
+config SYS_SOC
+	default "airoha"
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
+config SYS_BOARD
+	string "Board name"
+	default "an7581" if TARGET_AN7581
+	default ""
+	help
+	  This option contains information about board name.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
+	  be used.
+
+config SYS_CONFIG_NAME
+	string "Board configuration name"
+	default "an7581" if TARGET_AN7581
+	default ""
+	help
+	  This option contains information about board configuration name.
+	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
+	  will be used for board configuration.
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
index 00000000000..480b89a73aa
--- /dev/null
+++ b/board/airoha/an7581/MAINTAINERS
@@ -0,0 +1,6 @@
+AN7581
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+F:	board/airoha/an7581
+F:	include/configs/an7581.h
+F:	configs/an7581_rfb_defconfig
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
index 00000000000..d38f7342949
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
+	gd->bd->bi_boot_params = CONFIG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
new file mode 100644
index 00000000000..b37511c026e
--- /dev/null
+++ b/configs/an7581_evb_defconfig
@@ -0,0 +1,137 @@
+CONFIG_ARM=y
+# CONFIG_SYS_HAS_NONCACHED_MEMORY is not set
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_SYS_THUMB_BUILD=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_UBOOT_ARHT=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="an7581-evb"
+CONFIG_SPL_TEXT_BASE=0x201000
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_TARGET_AN7581=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x40800000
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_SPL_PAYLOAD="u-boot-lzma.img"
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+# CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xdeadbeef
+CONFIG_SPL_IMAGE="spl/u-boot-spl-mtk.bin"
+CONFIG_FIT=y
+CONFIG_SHA1=y
+CONFIG_SHA256=y
+CONFIG_SHA512=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="an7581-evb"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SPL_MAX_SIZE=0x10000
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x10000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0x106000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=8
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_NFS is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_LOG=y
+CONFIG_CMD_SAVEENV=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-parents"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_AIROHA=y
+CONFIG_MMC_WRITE=y
+CONFIG_BLOCK_CACHE=y
+# CONFIG_MEDIATEK_ETH is not set
+CONFIG_PHY=y
+#CONFIG_PHY_MTK_TPHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT7629=y
+CONFIG_POWER_DOMAIN=y
+#CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+# CONFIG_MTK_SNOR=y
+#CONFIG_SYSRESET=y
+#CONFIG_SPL_SYSRESET=y
+#CONFIG_SYSRESET_WATCHDOG=y
+#CONFIG_USB=y
+#CONFIG_USB_XHCI_HCD=y
+#CONFIG_USB_XHCI_MTK=y
+#CONFIG_USB_STORAGE=y
+#CONFIG_USB_KEYBOARD=y
+#CONFIG_WDT_MTK=y
+CONFIG_LZMA=y
+CONFIG_SPL_LZMA=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_CMD_SPI=y
+CONFIG_ENV_IS_IN_SNAND_FLASH=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_SYS_SNAND_ENV_DEV="bootloader"
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_DMA=y
+CONFIG_AIROHA_ETH=y
+CONFIG_ARHT_SPI=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_EXT4=y
+CONFIG_OF_LIBFDT=y
+CONFIG_DM_LED=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ARHT_GPIO=y
+CONFIG_DM_GPIO=y
diff --git a/include/configs/an7581.h b/include/configs/an7581.h
new file mode 100644
index 00000000000..901d99b3456
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
+#define CONFIG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CONFIG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.48.1

