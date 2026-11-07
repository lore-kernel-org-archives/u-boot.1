Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42F606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G9Ylf6ET;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=Eib3+5dF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3BA081A15;
	Sat,  7 Nov 2026 12:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G81gkHDtFszC; Sat,  7 Nov 2026 12:51:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F90581A34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055887;
	b=cR5SgeCIMTgkyvJMn3NImYl22LWvJidTshgMi7eOIU8KvVzf6trUW1ATGyCoG3v8GvZl
	 AAOfGaa467/48cRHlRjhScSeFtRhXezlN1AdHIjQin5L788L3jv2pW0ACTGvZIn6odwxM
	 w+0HESndx2ZhlUuEex9LE1xRZesnqehZzwKEFdsUIhzLzEulE5bGL4mh+37PIz3rxz19E
	 uy6RPnV7vPYdWWZyJARuwSBjODsYfLDkejFm4e09mkFCeOso3OtXH8WggtocrKDEF/hG1
	 AVDRBz3Ar7B5qWYf7TY8FHXNfwVZNjTB9mhUi67IhsM7uol5vmWvsuU5Co36qZokIpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/OPVChYGQrZrw/yrLtKN6fjgQpTISOCdoD2dNDIPeHk=;
	b=RPTdJHl1CuLeL6gYBd8U1AWBn7p+CXhx9ItjIiqnHrFewW0zHQaxTzsgATGphQ5FtrHU
	 aheLHBMhBGPYnNBIu2pcXw7NCRa+IMELHNsRRBZor3zw8h7HqTAXGfhnaQ8aSGAwA7YpA
	 mrp/5JDt0guuyDBfY4VxMVdlSmVCs6Ez9jBqCaz5P/q6SK3cX+ccRi4uKYP82ynMTAnjR
	 crZZiYErJW2HsSWDmDwtQGblccA7hvCGf8AREKnT7v92NCSpbJU0EM3ff9rs3N8UFZ8m6
	 pcBHeso6hln6y4tyc1nFkl/uppHMrWrX7xTjdnA8AnVY2bsiApnU21Mwqe3Jmhx5dJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055887;
	bh=/OPVChYGQrZrw/yrLtKN6fjgQpTISOCdoD2dNDIPeHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9Ylf6ETSLEI6R112sJBHO/GcHDpN/PZW+04dSqrzN3nOg0AmNocIpturBnNgo18w
	 4QWm3tp0cd1uGMLQQO4g4QgcIvlJnLiJ8JvbAOj29wjrrwUmVwxgowY6rULQzt3Gqk
	 Z8AnYlKGhlqIvYzfEeaJ50LjRSCRZd0TssubFW+FLLr1XoibXky5j0vv6ej4b8LZSU
	 KdiTbYv+M2u/Tw70vfo5KAdjzILmDi0EfpBFWFLlM8P/0Slo37Za61dcMJJrkV1LJD
	 JGIxN+oSNT0fOi6u74hh0jEpz2QBMSY1Zh0xMgmZ+mYUHANC52pUrZIFgmucmLtnDU
	 cpy58Dv+6m9zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F90581A34;
	Sat,  7 Nov 2026 12:51:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4258211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5DDF40111
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KkJvSi8muxp for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 438774009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=Eib3+5dF
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 438774009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:40 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmx711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:15 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmx711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051916;
 bh=/OPVChYGQrZrw/yrLtKN6fjgQpTISOCdoD2dNDIPeHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Eib3+5dFzNGl25ZucU3rA8Lpkcbws1RnBwcIGZhnHjR8QOciVRp/Jxrqaf4ITHoZa
 qUd5dd8jRK+oXEI92UjUCxudwvZRaEGAS+Zk+n94Rve28c9gqbnvB0adie7LDXheSb
 20v8cLP5q7xd3qsi6N5gEOYw/hpl81vlHSSQhNTY=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 08/10] board: st: add NUCLEO-L4R5ZI
Date: Sat,  7 Nov 2026 12:44:53 +0100
Message-ID: <20261107114455.304896-9-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Add the ST NUCLEO-L4R5ZI (MB1312) with an STM32L4R5ZIT6: 2 MiB flash,
640 KiB SRAM. U-Boot executes in place from flash and keeps its stack,
malloc area and device tree in SRAM1 + SRAM2, so SRAM3 (0x20040000)
stays free for applications.

Supported: 120 MHz system clock, console on LPUART1 (ST-Link virtual
COM port), GPIO, the three user LEDs, the user button and TIM5 as
system timer.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 arch/arm/dts/Makefile                         |  2 +
 arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi   | 23 ++++++
 arch/arm/dts/stm32l4r5zi-nucleo.dts           | 71 +++++++++++++++++++
 arch/arm/mach-stm32/Kconfig                   |  1 +
 arch/arm/mach-stm32/stm32l4/Kconfig           | 11 +++
 board/st/stm32l4r5zi-nucleo/Kconfig           | 15 ++++
 board/st/stm32l4r5zi-nucleo/MAINTAINERS       | 11 +++
 board/st/stm32l4r5zi-nucleo/Makefile          |  3 +
 .../stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c   | 65 +++++++++++++++++
 configs/stm32l4r5zi-nucleo_defconfig          | 35 +++++++++
 doc/board/st/stm32_MCU.rst                    | 16 ++++-
 include/configs/stm32l4r5zi-nucleo.h          | 12 ++++
 12 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5zi-nucleo.dts
 create mode 100644 arch/arm/mach-stm32/stm32l4/Kconfig
 create mode 100644 board/st/stm32l4r5zi-nucleo/Kconfig
 create mode 100644 board/st/stm32l4r5zi-nucleo/MAINTAINERS
 create mode 100644 board/st/stm32l4r5zi-nucleo/Makefile
 create mode 100644 board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
 create mode 100644 configs/stm32l4r5zi-nucleo_defconfig
 create mode 100644 include/configs/stm32l4r5zi-nucleo.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 37d3b6fd..01988d96 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1027,6 +1027,8 @@ dtb-$(CONFIG_ASPEED_AST2600) += \
 dtb-$(CONFIG_ASPEED_AST2700) += \
 	ast2700-evb.dtb
 
+dtb-$(CONFIG_STM32L4) += stm32l4r5zi-nucleo.dtb
+
 dtb-$(CONFIG_STM32MP15X) += \
 	stm32mp157c-odyssey.dtb
 
diff --git a/arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi b/arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi
new file mode 100644
index 00000000..4d44dba3
--- /dev/null
+++ b/arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+#include "stm32l4-u-boot.dtsi"
+
+&gpiog {
+	bootph-all;
+};
+
+&lpuart1 {
+	bootph-all;
+};
+
+&lpuart1_pins_a {
+	bootph-all;
+};
+
+&timer5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/stm32l4r5zi-nucleo.dts b/arch/arm/dts/stm32l4r5zi-nucleo.dts
new file mode 100644
index 00000000..b96a64f1
--- /dev/null
+++ b/arch/arm/dts/stm32l4r5zi-nucleo.dts
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+/dts-v1/;
+#include "stm32l4r5.dtsi"
+#include "stm32l4r5-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "STMicroelectronics NUCLEO-L4R5ZI board";
+	compatible = "st,stm32l4r5zi-nucleo", "st,stm32l4r5";
+
+	aliases {
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-green {
+			label = "green:user";
+			gpios = <&gpioc 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-blue {
+			label = "blue:user";
+			gpios = <&gpiob 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-red {
+			label = "red:user";
+			gpios = <&gpiob 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-user {
+			label = "user";
+			linux,code = <BTN_0>;
+			gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0xa0000>;
+	};
+};
+
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lpuart1_pins_a>;
+	status = "okay";
+};
+
+&timer5 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 1fe4285d..b3e18f69 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -72,5 +72,6 @@ config STM32L4
 source "arch/arm/mach-stm32/stm32f4/Kconfig"
 source "arch/arm/mach-stm32/stm32f7/Kconfig"
 source "arch/arm/mach-stm32/stm32h7/Kconfig"
+source "arch/arm/mach-stm32/stm32l4/Kconfig"
 
 endif
diff --git a/arch/arm/mach-stm32/stm32l4/Kconfig b/arch/arm/mach-stm32/stm32l4/Kconfig
new file mode 100644
index 00000000..8309db91
--- /dev/null
+++ b/arch/arm/mach-stm32/stm32l4/Kconfig
@@ -0,0 +1,11 @@
+if STM32L4
+
+config TARGET_STM32L4R5ZI_NUCLEO
+	bool "STM32L4R5ZI Nucleo-144 board"
+	help
+	  ST NUCLEO-L4R5ZI (MB1312) board, populated with an STM32L4R5ZIT6
+	  (Cortex-M4, 2 MiB flash, 640 KiB SRAM).
+
+source "board/st/stm32l4r5zi-nucleo/Kconfig"
+
+endif
diff --git a/board/st/stm32l4r5zi-nucleo/Kconfig b/board/st/stm32l4r5zi-nucleo/Kconfig
new file mode 100644
index 00000000..26e14b41
--- /dev/null
+++ b/board/st/stm32l4r5zi-nucleo/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_STM32L4R5ZI_NUCLEO
+
+config SYS_BOARD
+	default "stm32l4r5zi-nucleo"
+
+config SYS_VENDOR
+	default "st"
+
+config SYS_SOC
+	default "stm32l4"
+
+config SYS_CONFIG_NAME
+	default "stm32l4r5zi-nucleo"
+
+endif
diff --git a/board/st/stm32l4r5zi-nucleo/MAINTAINERS b/board/st/stm32l4r5zi-nucleo/MAINTAINERS
new file mode 100644
index 00000000..143828ba
--- /dev/null
+++ b/board/st/stm32l4r5zi-nucleo/MAINTAINERS
@@ -0,0 +1,11 @@
+STM32L4R5ZI-NUCLEO BOARD
+M:	Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+S:	Maintained
+F:	arch/arm/dts/stm32l4*
+F:	arch/arm/include/asm/arch-stm32l4/
+F:	arch/arm/mach-stm32/stm32l4/
+F:	board/st/stm32l4r5zi-nucleo
+F:	configs/stm32l4r5zi-nucleo_defconfig
+F:	drivers/clk/stm32/clk-stm32l4.c
+F:	include/configs/stm32l4r5zi-nucleo.h
+F:	include/dt-bindings/clock/stm32l4-clock.h
diff --git a/board/st/stm32l4r5zi-nucleo/Makefile b/board/st/stm32l4r5zi-nucleo/Makefile
new file mode 100644
index 00000000..f3d25cb6
--- /dev/null
+++ b/board/st/stm32l4r5zi-nucleo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += stm32l4r5zi-nucleo.o
diff --git a/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c b/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
new file mode 100644
index 00000000..5854e757
--- /dev/null
+++ b/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * Board support for the ST NUCLEO-L4R5ZI
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <fdtdec.h>
+#include <init.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+#include <asm/arch/stm32.h>
+
+/*
+ * U-Boot keeps its stack, malloc area and device tree in SRAM1 + SRAM2;
+ * SRAM3 (0x20040000-0x2009ffff) stays free for loading applications.
+ */
+#define STM32L4R5_SRAM3_BASE	0x20040000
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
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return STM32L4R5_SRAM3_BASE;
+}
+
+int board_early_init_f(void)
+{
+	struct udevice *dev;
+
+	/* Bring the system clock up to speed before anything else runs */
+	return uclass_get_device_by_driver(UCLASS_CLK,
+					   DM_DRIVER_GET(stm32l4_clk), &dev);
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int misc_init_r(void)
+{
+	char serialno[25];
+
+	if (!env_get("serial#")) {
+		snprintf(serialno, sizeof(serialno), "%08x%08x%08x",
+			 readl(&STM32_U_ID->u_id_high),
+			 readl(&STM32_U_ID->u_id_mid),
+			 readl(&STM32_U_ID->u_id_low));
+		env_set("serial#", serialno);
+	}
+
+	return 0;
+}
diff --git a/configs/stm32l4r5zi-nucleo_defconfig b/configs/stm32l4r5zi-nucleo_defconfig
new file mode 100644
index 00000000..c57cdb3a
--- /dev/null
+++ b/configs/stm32l4r5zi-nucleo_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_SYS_ICACHE_OFF=y
+CONFIG_SYS_DCACHE_OFF=y
+CONFIG_ARMV7M_XIP=y
+CONFIG_ARCH_STM32=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x10000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20040000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="stm32l4r5zi-nucleo"
+CONFIG_SYS_LOAD_ADDR=0x20040000
+CONFIG_STM32L4=y
+CONFIG_TARGET_STM32L4R5ZI_NUCLEO=y
+CONFIG_SYS_CUSTOM_LDSCRIPT=y
+CONFIG_SYS_LDSCRIPT="arch/arm/cpu/armv7m/u-boot-xip.lds"
+CONFIG_BOOTDELAY=3
+CONFIG_SYS_PBSIZE=1050
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot > "
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIMER=y
+CONFIG_OF_CONTROL=y
+CONFIG_NO_NET=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+# CONFIG_MMC is not set
diff --git a/doc/board/st/stm32_MCU.rst b/doc/board/st/stm32_MCU.rst
index 61650bc8..25965674 100644
--- a/doc/board/st/stm32_MCU.rst
+++ b/doc/board/st/stm32_MCU.rst
@@ -17,15 +17,17 @@ U-Boot supports the following STMP32 MCU SoCs:
  - STM32F769
  - STM32H743
  - STM32H750
+ - STM32L4R5
 
 SoCs information:
 -----------------
-STM32F4 series are Cortex-M4 MCU.
+STM32F4 and STM32L4 series are Cortex-M4 MCU.
 STM32F7 and STM32H7 series are Cortex-M7 MCU.
 
  + STM32F4 series: https://www.st.com/en/microcontrollers-microprocessors/stm32f4-series.html
  + STM32F7 series: https://www.st.com/en/microcontrollers-microprocessors/stm32f7-series.html
  + STM32H7 series: https://www.st.com/en/microcontrollers-microprocessors/stm32h7-series.html
+ + STM32L4+ series: https://www.st.com/en/microcontrollers-microprocessors/stm32l4-plus-series.html
 
 Currently the following boards are supported:
 
@@ -37,6 +39,7 @@ Currently the following boards are supported:
  + stm32h743i-discovery
  + stm32h743i-evaluation
  + stm32h750i-art-pi
+ + stm32l4r5zi-nucleo
 
 Boot Sequences
 --------------
@@ -78,6 +81,7 @@ defconfig_file :
    + **stm32h743-disco_defconfig**
    + **stm32h743-eval_defconfig**
    + **stm32h750-art-pi_defconfig**
+   + **stm32l4r5zi-nucleo_defconfig**
 
 +-----------+-------+
 | FSBL      | OS    |
@@ -184,3 +188,13 @@ the flash process. When done the board will reboot automatically.
 
 In case of boot with SPL, by default SPL will try to load either a Linux
 kernel (falcon mode) or, if the key "c" is maintained pressed, the main U-Boot.
+
+STM32L4R5ZI Nucleo
+------------------
+
+The STM32L4R5 has 2 MiB of flash and 640 KiB of SRAM but no external memory
+controller, so U-Boot executes in place from flash (CONFIG_ARMV7M_XIP) and is
+not relocated. Its stack, malloc area and device tree stay in SRAM1 + SRAM2;
+SRAM3 (0x20040000 - 0x2009ffff) is left free for applications.
+
+The console is LPUART1, connected to the ST-Link virtual COM port.
diff --git a/include/configs/stm32l4r5zi-nucleo.h b/include/configs/stm32l4r5zi-nucleo.h
new file mode 100644
index 00000000..3c67b7c2
--- /dev/null
+++ b/include/configs/stm32l4r5zi-nucleo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_HZ_CLOCK		1000000	/* Timer is clocked at 1MHz */
+
+#endif /* __CONFIG_H */
-- 
2.56.0

