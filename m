Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA01606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZvUvnfRH;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=mmWbCXhW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3725681970;
	Sat,  7 Nov 2026 12:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuVCKdf7cjQE; Sat,  7 Nov 2026 12:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBF978194C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055878;
	b=IPuguapUeXRd2vyzVfhrs+97oLaOKf0FUPKZf8uPckg60NXER+nyIUUU0vr6uJS0j6El
	 JuQ8NWTJgfA81bRms9QLkj0kJCwhslEOoEUpLkNOWDRlaZyERsD2IsYdWjymOBd9HSX6j
	 PVTjlruWNPwDtVt+MDiWwOew8NCYfJUHfN8Puo3H2PWjflQNq+ObmqxwHDsSyurIG6N1T
	 kW5IeWfuZ6X5CJVM06zy4aY7z6NFPZkFnrSsb0kIrcRR7oHpNTX0MiCmVUEvD6ywElntN
	 phvbynmuzzKEndK39QqerX8rE8zazZXbSLYc3nfM+yI3KUcgaXhnezPbT9yBEzySlBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pG4ezJVv3wXyVB5G3zTO7drVs9NbkTgtiIhd23UmQhE=;
	b=HC4KbG0nrFyLvWB2kI0MNFoFMYo1vdSr6FdlsbO3T5Eu4TxkoprTQH1uRGf4GIjYEasd
	 HoAvLfvw5zFgJW9EO5/8+4jofikb1M/AQjH0jEeFzIQsvDUrHRAnkJDQW8nKB/HopIa67
	 B2cjebOozj1xIcXrCVzvb9DAplqyLMcOvgM2XCTKFa0zOl09R3IvQLRITrnu41LFkY1ba
	 u3sShze3+EMf1H5L3cOEPLxq5rmtsBsqfYA/DqIP3/LI5/boyNvx5rjqR0KZ32W4c4ijy
	 oTI6wm/JnI0L83aubQmeYxxYwAKrq4olKoOTIGxg9+HcZ0AkFy/4N7ikCkH/950ZIqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055878;
	bh=pG4ezJVv3wXyVB5G3zTO7drVs9NbkTgtiIhd23UmQhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvUvnfRHf5GT9CSrD+JHpXgAZ+F1l9NFwfFn9JxSrWWtK2gWXPJelhET3TrSz5FH1
	 dODJGVA8p046JMePppKMF20VAiNocm4srnJ0QmOmicyeRXw+d91WpXCnWQwLdOrjz3
	 Me0/YYXggye/tZOicBVksd+AaakF0C/eh0nfEBggeT5yBrMnmwGjLxKnFtRsFpDXaT
	 l7igLhv0BePCJlHxybsHALWsHqfYCjhjNch58WVZ9VjnUUEMZi/d9EuQM9o3ppUrMy
	 riTp+BzI7H5mURNakWi8cyylUdFsM6Iiw1VT3xObB4nLqfGBLhFtnEbt0feL4+nUhF
	 pK0mYqLAAyUZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBF978194C;
	Sat,  7 Nov 2026 12:51:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A3FA37D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D7F6400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iS63WUB8lFEU for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 02B264009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=mmWbCXhW
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02B264009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:35 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmw711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:13 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmw711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051914;
 bh=pG4ezJVv3wXyVB5G3zTO7drVs9NbkTgtiIhd23UmQhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mmWbCXhWekvGipU/FbdnAGzslmANyNVICrir1DUk1/p38UnvwQQ4yHsco/8wXmZdr
 1XS4atRGDvjBTVxKg+3arjOIlquXbGYzNuN0U28obHtB5GCmyHaLrXTOCehN2rsGd7
 rGoJ0jjTxKUQYSB9t6KoGD8TfAsYj4b9N9LGIgHY=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 07/10] ARM: dts: stm32: add STM32L4R5 SoC device tree
Date: Sat,  7 Nov 2026 12:44:52 +0100
Message-ID: <20261107114455.304896-8-christian.koever-draxl@student.uibk.ac.at>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Describe the RCC, PWR, GPIO banks A..I, LPUART1 and TIM5 of the
STM32L4R5, and the LPUART1 pins in a separate pinctrl file as done for
the other STM32 MCUs.

There is no STM32L4 device tree in Linux yet, so these files live in
arch/arm/dts.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 arch/arm/dts/stm32l4-u-boot.dtsi    |  13 +++
 arch/arm/dts/stm32l4r5-pinctrl.dtsi |  22 +++++
 arch/arm/dts/stm32l4r5.dtsi         | 135 ++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 arch/arm/dts/stm32l4-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5-pinctrl.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5.dtsi

diff --git a/arch/arm/dts/stm32l4-u-boot.dtsi b/arch/arm/dts/stm32l4-u-boot.dtsi
new file mode 100644
index 00000000..d9596e6f
--- /dev/null
+++ b/arch/arm/dts/stm32l4-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+&pinctrl {
+	bootph-all;
+};
+
+&rcc {
+	bootph-all;
+};
diff --git a/arch/arm/dts/stm32l4r5-pinctrl.dtsi b/arch/arm/dts/stm32l4r5-pinctrl.dtsi
new file mode 100644
index 00000000..26b07a98
--- /dev/null
+++ b/arch/arm/dts/stm32l4r5-pinctrl.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+&pinctrl {
+	lpuart1_pins_a: lpuart1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 7, AF8)>; /* LPUART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 8, AF8)>; /* LPUART1_RX */
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm/dts/stm32l4r5.dtsi b/arch/arm/dts/stm32l4r5.dtsi
new file mode 100644
index 00000000..4e19bb98
--- /dev/null
+++ b/arch/arm/dts/stm32l4r5.dtsi
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+#include "armv7-m.dtsi"
+#include <dt-bindings/clock/stm32l4-clock.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-m4";
+			reg = <0>;
+		};
+	};
+
+	soc {
+		timer5: timer@40000c00 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000c00 0x400>;
+			clocks = <&rcc STM32L4_APB1ENR1(3)>;
+			resets = <&rcc STM32L4_APB1RSTR1(3)>;
+			status = "disabled";
+		};
+
+		pwrcfg: power-config@40007000 {
+			compatible = "st,stm32-power-config", "syscon";
+			reg = <0x40007000 0x400>;
+		};
+
+		lpuart1: serial@40008000 {
+			compatible = "st,stm32l4-lpuart";
+			reg = <0x40008000 0x400>;
+			interrupts = <70>;
+			clocks = <&rcc STM32L4_APB1ENR2(0)>;
+			resets = <&rcc STM32L4_APB1RSTR2(0)>;
+			status = "disabled";
+		};
+
+		rcc: rcc@40021000 {
+			compatible = "st,stm32l4r5-rcc";
+			reg = <0x40021000 0x400>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			st,syscfg = <&pwrcfg>;
+		};
+
+		pinctrl: pinctrl@48000000 {
+			compatible = "st,stm32l4r5-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48000000 0x2400>;
+
+			gpioa: gpio@48000000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(0)>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio@48000400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(1)>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio@48000800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(2)>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio@48000c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(3)>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio@48001000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(4)>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio@48001400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(5)>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio@48001800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(6)>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio@48001c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(7)>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio@48002000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc STM32L4_AHB2ENR(8)>;
+				st,bank-name = "GPIOI";
+			};
+		};
+	};
+};
-- 
2.56.0

