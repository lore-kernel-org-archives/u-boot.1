Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319C106289F
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C76384101;
	Wed, 11 Mar 2026 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="hDr20VZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD6383FEC; Wed, 11 Mar 2026 09:41:47 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157A583F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qq
 xDOtIHsK7xk39/dzNebHN5fiHyYAwl5uDDYDdACRo=; b=hDr20VZxNesL+/zGLu
 75vaENCQkb8FX7UYhoiX1IbZIYiIlD0zOv7uCYfUuYuWSheRA5V//NlkVp3o8wqv
 EQBFCARC/JxxYq26Q0rukWr6EivwtpygQPrcsdoFT/29UcIg1az45cxdQVoM6eq1
 rHZfcJZ1mhPzmuVyjiCCrODsw=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S9; 
 Wed, 11 Mar 2026 16:41:35 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 7/7] mips: loongson: ls1c300 dts and bindings
Date: Wed, 11 Mar 2026 16:41:29 +0800
Message-ID: <20260311084129.12809-8-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S9
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1UZr17urW7Cr45Gr15Arb_yoWxCFyUpw
 1qkFZYqr4IvF129wnY9Fy8JF1fJFW0kFy7J3Zrtry8Cw13KFWjyF1fKaySqFyfXr40v3yx
 XFZrX34jvFsFvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jov38UUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbC5x+A12mxKr+52wAA3A
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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
index 00000000000..ac3937adfb6
--- /dev/null
+++ b/include/dt-bindings/clock/ls1c300-clk.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright (C) 2022-2026 Du Huanpeng <u74147@gmail.com>
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
index 00000000000..0aea03cc181
--- /dev/null
+++ b/include/dt-bindings/reset/ls1c300-reset.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright (C) 2022-2026 Du Huanpeng <u74147@gmail.com>
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

