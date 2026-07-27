Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CE6C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E213780AD1;
	Mon, 27 Jul 2026 09:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePN4OKiku1zZ; Mon, 27 Jul 2026 09:09:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE60080D13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143386;
	bh=YmkbHzHSIITEtS4vs+ZOhZ0eYcpFpsUhFbIJ+HelZXA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=x/WpzYB2lL3jU3uMidL6HAW0PH5ByG+l/qc3SWPjurjmhbC2quJlr7R9RXPraduGf
	 iI/9V8YpU8gDXk/x7AfuIxdySeop/NoHhSddNrZmT4jyrLooRzEU8OnsY0oDR+ZJ74
	 KE9TGZ2iN4ej1VmHMud60Ea63N1Ec05fQQVzUocEAOLVMl+ly4c3XMZpRfDyXukkEH
	 df7JGJsnt3r3MdEGlCCjNbKc1BJU1UTkv84ZRGUNGEwxbWzPS7k5XU5HZpRW8n8rOm
	 SJbkLz3vyeSa5YbGDNR2S8fR5I5FdLwJqr9+2IcdSONGBfhOcArpSFR1RI/RZ8azNv
	 gmAeyZ9o59Chg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE60080D13;
	Mon, 27 Jul 2026 09:09:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E6CF490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40383405AD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0BaJ54TcMJQ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 011D94061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 011D94061D
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 011D94061D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135215; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=COv1q/I17HM1p0SjSaaIOi+m+sV62RJluHufXwbrmE41X73x8QLNIvo3oyry50+MVygmqiL1hCnWI1fE56T0zQmOPibYOlgMxVpF65tPsNq4KwkXgccQNSpKadlDJWBMkc7/Y1m4NyvRGD+axetImS0zbVQaosGTbSH+/oxVugI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135215;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YmkbHzHSIITEtS4vs+ZOhZ0eYcpFpsUhFbIJ+HelZXA=; 
 b=aLoFMu/H68t0PA+vx/A8Uc66g+tN/WGd2kA4VJ+BicIuS4gC2/752y2nFT3LTbkIwNzyF6Wfk22gxTcujRwYN8I64XcUB3ediPhPKGqtIi/YOViQYFFZOe4D+oVGgthP/nET+R8LkqXWpe2PBJ9l/shtRQ1hFpJ5cf/mhdlFQ7I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135212186118.790062772027;
 Sun, 26 Jul 2026 23:53:32 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:15 +0800
Subject: [PATCH RESEND v2 6/7] riscv: dts: sophgo: Drop local CV18xx
 devicetrees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-6-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227109ac4b6b17cf445b4669baa0000cf2eb1daec658abf882510332f3e72ce733be51dcb2ef416b7:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135215; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=YmkbHzHSIITEtS4vs+ZOhZ0eYcpFpsUhFbIJ+HelZXA=;
 b=N8+wu84WGh8H332f1GAG4q5OzhNY2Zp9HAy0Vn38mEHR1JtwotbKZCIfCxKXQoLp
 2cpun4bMfaSREqihLiOxt7u6U1GVJtuvkEb7HeHXLyo1xejQsPDBvT3BXYZnLY7DjFp
 En8MQmM5DaZzvSY/ocQAGcEk9STbyxNOFf8n0TZ8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=N8+wu84W
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Milk-V Duo and LicheeRV Nano now use the upstream CV1800B and SG2002
devicetrees.

Remove the unused local devicetree files and their Makefile entries.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/Makefile                   |   2 -
 arch/riscv/dts/cv1800b-milkv-duo.dts      |  64 ---------
 arch/riscv/dts/cv1800b.dtsi               |  22 ---
 arch/riscv/dts/cv18xx.dtsi                | 232 ------------------------------
 arch/riscv/dts/sg2002-licheerv-nano-b.dts |  45 ------
 arch/riscv/dts/sg2002.dtsi                |  34 -----
 6 files changed, 399 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 71c5c13d221..c588ce546bf 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -4,8 +4,6 @@ dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
-dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
-dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
deleted file mode 100644
index e7cc0e8bd14..00000000000
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-/dts-v1/;
-
-#include "cv1800b.dtsi"
-
-/ {
-	model = "Milk-V Duo";
-	compatible = "milkv,duo", "sophgo,cv1800b";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x3f40000>;
-	};
-};
-
-&ethernet0 {
-	status = "okay";
-	phy-mode = "rmii";
-};
-
-&osc {
-	clock-frequency = <25000000>;
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <4>;
-	no-1-8-v;
-	no-mmc;
-	no-sdio;
-};
-
-&spif {
-	status = "okay";
-
-	spiflash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <75000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		m25p,fast-read;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
deleted file mode 100644
index baf641829e7..00000000000
--- a/arch/riscv/dts/cv1800b.dtsi
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include "cv18xx.dtsi"
-
-/ {
-	compatible = "sophgo,cv1800b";
-};
-
-&plic {
-	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
-};
-
-&clint {
-	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
-};
-
-&clk {
-	compatible = "sophgo,cv1800-clk";
-};
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
deleted file mode 100644
index 6fac247e7ac..00000000000
--- a/arch/riscv/dts/cv18xx.dtsi
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/sophgo,cv1800.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus: cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		timebase-frequency = <25000000>;
-
-		cpu0: cpu@0 {
-			compatible = "thead,c906", "riscv";
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <512>;
-			d-cache-size = <65536>;
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			mmu-type = "riscv,sv39";
-			riscv,isa = "rv64imafdc";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc_25m";
-		#clock-cells = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		dma-noncoherent;
-		ranges;
-
-		clk: clock-controller@3002000 {
-			reg = <0x03002000 0x1000>;
-			clocks = <&osc>;
-			#clock-cells = <1>;
-		};
-
-		gpio0: gpio@3020000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3020000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			porta: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio1: gpio@3021000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3021000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portb: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio2: gpio@3022000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3022000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portc: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio3: gpio@3023000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3023000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portd: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		ethernet0: ethernet@4070000 {
-			compatible = "sophgo,cv1800b-dwmac";
-			reg = <0x04070000 0x10000>;
-			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_ETH0_500M>, <&clk CLK_AXI4_ETH0>;
-			clock-names = "stmmaceth", "pclk";
-			status = "disabled";
-		};
-
-		uart0: serial@4140000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04140000 0x100>;
-			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart1: serial@4150000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04150000 0x100>;
-			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart2: serial@4160000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04160000 0x100>;
-			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@4170000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04170000 0x100>;
-			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart4: serial@41c0000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x041c0000 0x100>;
-			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		sdhci0: mmc@4310000 {
-			compatible = "sophgo,cv1800b-dwcmshc";
-			reg = <0x4310000 0x1000>;
-			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_AXI4_SD0>, <&clk CLK_SD0>;
-			clock-names = "core", "bus";
-			status = "disabled";
-		};
-
-		spif: spi-nor@10000000 {
-			compatible = "sophgo,cv1800b-spif";
-			reg = <0x10000000 0x10000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clk CLK_AHB_SF>;
-			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		plic: interrupt-controller@70000000 {
-			reg = <0x70000000 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			riscv,ndev = <101>;
-		};
-
-		clint: timer@74000000 {
-			reg = <0x74000000 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/sg2002-licheerv-nano-b.dts b/arch/riscv/dts/sg2002-licheerv-nano-b.dts
deleted file mode 100644
index 9871a75836c..00000000000
--- a/arch/riscv/dts/sg2002-licheerv-nano-b.dts
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
- */
-
-/dts-v1/;
-
-#include "sg2002.dtsi"
-
-/ {
-	model = "LicheeRV Nano B";
-	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
-
-	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&osc {
-	clock-frequency = <25000000>;
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <4>;
-	no-1-8-v;
-	no-mmc;
-	no-sdio;
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/sg2002.dtsi b/arch/riscv/dts/sg2002.dtsi
deleted file mode 100644
index 0f97000fa8b..00000000000
--- a/arch/riscv/dts/sg2002.dtsi
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include "cv18xx.dtsi"
-
-/ {
-	compatible = "sophgo,sg2002";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>;
-	};
-};
-
-&plic {
-	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-plic", "thead,c900-plic";
-};
-
-&clint {
-	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-clint", "thead,c900-clint";
-};
-
-&clk {
-	compatible = "sophgo,sg2002-clk", "sophgo,cv1800-clk";
-};
-
-&sdhci0 {
-	compatible = "sophgo,sg2002-dwcmshc", "sophgo,cv1800b-dwcmshc";
-};

-- 
2.55.0

