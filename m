Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0B2F4198B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128C4841F2;
	Wed, 15 Apr 2026 14:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="k13fzUPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F83841B9; Wed, 15 Apr 2026 14:05:06 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F6F83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=of
 5OShH0/01X2M4+qgw1fbWooJ6uzl9sPzdbS4gX1rU=; b=k13fzUPeytBAX69L/6
 gEjYY//hpMlUbck8gKbAQMMTpPOw1RwxWi9CfBOU2+HHMWUIam2jb8cmmFw7pGak
 +L/AJOkMpAS/NKcoABiyPbQMqXHdJ/mrG31WWRSfor9IxB8sawCl2SLrS0gehg4S
 XlbpOS5u+nVt8Q7yYv2gR0MOI=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3RcLJft9p2XkzFA--.19463S9; 
 Wed, 15 Apr 2026 20:04:52 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com
Cc: Du Huanpeng <u74147@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de (open list)
Subject: [PATCH v7 7/7] mips: loongson: ls1c300 dts and bindings
Date: Wed, 15 Apr 2026 20:04:13 +0800
Message-ID: <20260415120425.5792-8-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415120425.5792-1-sgdfkk@163.com>
References: <20260415120425.5792-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3RcLJft9p2XkzFA--.19463S9
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1UZr17urW7Cr45Gr15Arb_yoWxCF1Upw
 1qkFZ5tr40vF129w1F9a48JF1fJFW0kFy7J3ZFqFy8Cw13KFWjyF1fKaySqFy3Xr48Z3yx
 XFZrX34jvFsFvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaHqcUUUUU=
X-Originating-IP: [240e:3b0:4805:31e::3001]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbC5wUrgmnffuWKjAAA3g
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

From: Du Huanpeng <u74147@gmail.com>

- ls1c300 dtsi
- ls1c300-eval board dts
- clk binding header
- reset binding header

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 arch/mips/dts/loongson32-ls1c300b.dtsi    | 151 ++++++++++++++++++++++
 arch/mips/dts/ls1c300-eval.dts            |  30 +++++
 include/dt-bindings/clock/ls1c300-clk.h   |  18 +++
 include/dt-bindings/reset/ls1c300-reset.h |  36 ++++++
 4 files changed, 235 insertions(+)
 create mode 100644 arch/mips/dts/loongson32-ls1c300b.dtsi
 create mode 100644 arch/mips/dts/ls1c300-eval.dts
 create mode 100644 include/dt-bindings/clock/ls1c300-clk.h
 create mode 100644 include/dt-bindings/reset/ls1c300-reset.h

diff --git a/arch/mips/dts/loongson32-ls1c300b.dtsi b/arch/mips/dts/loongson32-ls1c300b.dtsi
new file mode 100644
index 00000000000..26b0c707459
--- /dev/null
+++ b/arch/mips/dts/loongson32-ls1c300b.dtsi
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/ls1c300-clk.h>
+#include <dt-bindings/reset/ls1c300-reset.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "loongson,ls1c300-soc";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			compatible = "loongson,gs232", "mips,mips4Kc";
+			clocks = <&acc CLK_CPU_THROT>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bootph-all;
+
+
+		xtal: oscillator {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		acc: clock-controller@1fe78030 {
+			compatible = "loongson,ls1c300-clk";
+			clocks = <&xtal>;
+			#clock-cells = <1>;
+			reg = <0x1fe78030 0x8>, <0x1fe7c010 0x4>;
+			bootph-all;
+		};
+
+		uart0: serial@1fe40000 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe40000 0x100>;
+			status = "disabled";
+		};
+
+		uart1: serial@1fe44000 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe44000 0x100>;
+			status = "disabled";
+		};
+
+		uart2: serial@1fe48000 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe48000 0x100>;
+			resets = <&shut_ctrl UART2_SHUT>;
+			reset-names = "uart2";
+			status = "disabled";
+		};
+
+		uart3: serial@1fe4c000 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c000 0x100>;
+			status = "disabled";
+		};
+
+		uart4:  serial@1fe4c400 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c400 0x100>;
+			status = "disabled";
+		};
+
+		uart5:  serial@1fe4c500 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c500 0x100>;
+			status = "disabled";
+		};
+
+		uart6:  serial@1fe4c600 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c600 0x100>;
+			status = "disabled";
+		};
+
+		uart7:  serial@1fe4c700 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c700 0x100>;
+			status = "disabled";
+		};
+
+		uart8:  serial@1fe4c800 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c800 0x100>;
+			status = "disabled";
+		};
+
+		uart9:  serial@1fe4c900 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4c900 0x100>;
+			status = "disabled";
+		};
+
+		uart10: serial@1fe4ca00 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4ca00 0x100>;
+			status = "disabled";
+		};
+
+		uart11: serial@1fe4cb00 {
+			compatible = "loongson,ls1c300-uart", "ns16550a";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe4cb00 0x100>;
+			status = "disabled";
+		};
+
+		wdt: watchdog@1fe5c060 {
+			compatible = "loongson,ls1c300-wdt";
+			clocks = <&acc CLK_APB>;
+			reg = <0x1fe5c060 0x10>;
+		};
+
+		reset-controller {
+			compatible = "wdt-reboot";
+			wdt = <&wdt>;
+		};
+
+		shut_ctrl: reset-controller@1fd00420 {
+			compatible = "loongson,shut_ctrl";
+			reg = <0x1fd00420 0x4>;
+			#reset-cells = <1>;
+		};
+	};
+};
diff --git a/arch/mips/dts/ls1c300-eval.dts b/arch/mips/dts/ls1c300-eval.dts
new file mode 100644
index 00000000000..cc3c267a5bf
--- /dev/null
+++ b/arch/mips/dts/ls1c300-eval.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Du Huanpeng <u74147@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "loongson32-ls1c300b.dtsi"
+
+/ {
+	compatible = "lsmips,ls1c300-soc";
+	model = "ls1c300-eval";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x4000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/include/dt-bindings/clock/ls1c300-clk.h b/include/dt-bindings/clock/ls1c300-clk.h
new file mode 100644
index 00000000000..170728693be
--- /dev/null
+++ b/include/dt-bindings/clock/ls1c300-clk.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Du Huanpeng <u74147@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_LS1C300_CLK_H__
+#define __DT_BINDINGS_LS1C300_CLK_H__
+
+#define CLK_XTAL	0
+#define CLK_PLL		1
+#define CLK_CPU		2
+#define CLK_APB		3
+#define CLK_CAMERA	4
+#define CLK_PIX		5
+#define CLK_AXIMUX	6
+#define CLK_CPU_THROT	7
+
+#endif /* __DT_BINDINGS_LS1C300_CLK_H__ */
diff --git a/include/dt-bindings/reset/ls1c300-reset.h b/include/dt-bindings/reset/ls1c300-reset.h
new file mode 100644
index 00000000000..44734ee50a9
--- /dev/null
+++ b/include/dt-bindings/reset/ls1c300-reset.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Du Huanpeng <u74147@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_LS1C300_RESET_H_
+#define _DT_BINDINGS_LS1C300_RESET_H_
+
+#define ADC_SHUT        25
+#define SDIO_SHUT       24
+#define DMA2_SHUT       23
+#define DMA1_SHUT       22
+#define DMA0_SHUT       21
+#define SPI1_SHUT       20
+#define SPI0_SHUT       19
+#define I2C2_SHUT       18
+#define I2C1_SHUT       17
+#define I2C0_SHUT       16
+#define AC97_SHUT       15
+#define I2S_SHUT        14
+#define UART3_SHUT      13
+#define UART2_SHUT      12
+#define UART1_SHUT      11
+#define UART0_SHUT      10
+#define CAN1_SHUT       9
+#define CAN0_SHUT       8
+#define ECC_SHUT        7
+#define MAC_SHUT        6
+#define USBHOST_SHUT    5
+#define USBOTG_SHUT     4
+#define SDRAM_SHUT      3
+#define SRAM_SHUT       2
+#define CAM_SHUT        1
+#define LCD_SHUT        0
+
+#endif  /* _DT_BINDINGS_LS1C300_RESET_H_*/
-- 
2.43.0

