Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56483D3F098
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEECF84034;
	Wed, 28 Jan 2026 17:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CW621cWC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGoIOKlh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GGBn/2CA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bUUGYD/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376DE84068; Wed, 28 Jan 2026 17:51:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6638401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 55D565BCD1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769619064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=QI8NAFCDyU6ad4WOlRIRd5aF6k5c7Bih0/iaVk4qBUo=;
 b=CW621cWCKxG/G3refUb+PVXG0zC4eUyVFHsnsHSvpEjdVpJnGnI9MyWw7SEJylS++dUatg
 1HZ816nNWxjGmB8ECR4hOibTTJiVuB4P9ZUyplvWNkrkLLV1SzEStKgE6P4hcgh77o5nSR
 3ZHddPfVZtxdmCbj9wDCsRsc4onl0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769619064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=QI8NAFCDyU6ad4WOlRIRd5aF6k5c7Bih0/iaVk4qBUo=;
 b=rGoIOKlh+vlqb1QKK1Rlu5srXI/3KeSYZMu7DUXK5273A8o4n5EXbs1XUD0yu+lOOo8JGV
 YfEWHfKYKpymVvAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="GGBn/2CA";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="bUUGYD/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769619063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=QI8NAFCDyU6ad4WOlRIRd5aF6k5c7Bih0/iaVk4qBUo=;
 b=GGBn/2CAb6pr2tX/IQHlpUHmELzmqwW2hphQ+80/nxAoLhPEhzUbVmYoj2+ka/Xey7Wlcj
 M8Cvk+oqLM1Kcyi13hBS9F8iFUtqpMc1yf8UY0VwePetRiAvwYT2x8cblc6HMj3RWxCgN6
 gE3eG2+QieKETXtNgUOX8AVsvpiOncE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769619063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=QI8NAFCDyU6ad4WOlRIRd5aF6k5c7Bih0/iaVk4qBUo=;
 b=bUUGYD/TBXknbll6mxa0Bcxylh6Nxj8Qq6v8+OdkzG0IwRHxc89FFPuzRc8TXzhdXzaIVo
 LpKp9UOFcS2iWDCA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 0B1874A0560; Wed, 28 Jan 2026 17:51:02 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: [PATCH] sifive: switch to OF_UPSTREAM
Date: Wed, 28 Jan 2026 17:51:02 +0100
Message-ID: <mvmwm11hea1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [14.99 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_SPAM_SHORT(3.00)[0.999];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:92b1:1cff:fe69:ddc:from];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_NONE(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 55D565BCD1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: ++++++++++++++
X-Spam: Yes
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

Tested on HiFive Unleashed and HiFive Unmatched, both SPIFlash and MMC boot.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/cpu/fu540/Kconfig                  |   1 +
 arch/riscv/cpu/fu740/Kconfig                  |   1 +
 arch/riscv/dts/Makefile                       |   2 -
 arch/riscv/dts/fu540-c000-u-boot.dtsi         |  16 +-
 arch/riscv/dts/fu540-c000.dtsi                | 286 ---------------
 arch/riscv/dts/fu740-c000.dtsi                | 326 ------------------
 arch/riscv/dts/hifive-unleashed-a00.dts       | 105 ------
 arch/riscv/dts/hifive-unmatched-a00.dts       | 246 -------------
 configs/sifive_unleashed_defconfig            |   2 +-
 configs/sifive_unmatched_defconfig            |   2 +-
 drivers/clk/sifive/fu540-prci.c               |   8 +-
 include/dt-bindings/clock/sifive-fu540-prci.h |  18 -
 12 files changed, 16 insertions(+), 997 deletions(-)
 delete mode 100644 arch/riscv/dts/fu540-c000.dtsi
 delete mode 100644 arch/riscv/dts/fu740-c000.dtsi
 delete mode 100644 arch/riscv/dts/hifive-unleashed-a00.dts
 delete mode 100644 arch/riscv/dts/hifive-unmatched-a00.dts
 delete mode 100644 include/dt-bindings/clock/sifive-fu540-prci.h

diff --git a/arch/riscv/cpu/fu540/Kconfig b/arch/riscv/cpu/fu540/Kconfig
index c68209d8fb2..f2934cb33e7 100644
--- a/arch/riscv/cpu/fu540/Kconfig
+++ b/arch/riscv/cpu/fu540/Kconfig
@@ -39,6 +39,7 @@ config SIFIVE_FU540
 	imply PWM_SIFIVE
 	imply DM_I2C
 	imply SYS_I2C_OCORES
+	imply OF_UPSTREAM
 
 if ENV_IS_IN_SPI_FLASH
 
diff --git a/arch/riscv/cpu/fu740/Kconfig b/arch/riscv/cpu/fu740/Kconfig
index d7ca9687171..66f9a8d5fa5 100644
--- a/arch/riscv/cpu/fu740/Kconfig
+++ b/arch/riscv/cpu/fu740/Kconfig
@@ -40,6 +40,7 @@ config SIFIVE_FU740
 	imply DM_I2C
 	imply SYS_I2C_OCORES
 	imply SPL_I2C
+	imply OF_UPSTREAM
 
 if ENV_IS_IN_SPI_FLASH
 
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 9b347fc3b50..8e591cb7aa9 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -9,8 +9,6 @@ dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
-dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
-dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
diff --git a/arch/riscv/dts/fu540-c000-u-boot.dtsi b/arch/riscv/dts/fu540-c000-u-boot.dtsi
index 360679a1781..19c7d6ccaca 100644
--- a/arch/riscv/dts/fu540-c000-u-boot.dtsi
+++ b/arch/riscv/dts/fu540-c000-u-boot.dtsi
@@ -7,11 +7,11 @@
 
 / {
 	cpus {
-		assigned-clocks = <&prci PRCI_CLK_COREPLL>;
+		assigned-clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 		assigned-clock-rates = <1000000000>;
 		bootph-pre-ram;
 		cpu0: cpu@0 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			status = "okay";
 			cpu0_intc: interrupt-controller {
@@ -19,28 +19,28 @@
 			};
 		};
 		cpu1: cpu@1 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu1_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu2: cpu@2 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu2_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu3: cpu@3 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu3_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu4: cpu@4 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu4_intc: interrupt-controller {
 				bootph-pre-ram;
@@ -80,7 +80,7 @@
 			reg = <0x0 0x100b0000 0x0 0x0800
 			       0x0 0x100b2000 0x0 0x2000
 			       0x0 0x100b8000 0x0 0x1000>;
-			clocks = <&prci PRCI_CLK_DDRPLL>;
+			clocks = <&prci FU540_PRCI_CLK_DDRPLL>;
 			clock-frequency = <933333324>;
 			bootph-pre-ram;
 		};
@@ -100,7 +100,7 @@
 };
 
 &eth0 {
-	assigned-clocks = <&prci PRCI_CLK_GEMGXLPLL>;
+	assigned-clocks = <&prci FU540_PRCI_CLK_GEMGXLPLL>;
 	assigned-clock-rates = <125000000>;
 };
 
diff --git a/arch/riscv/dts/fu540-c000.dtsi b/arch/riscv/dts/fu540-c000.dtsi
deleted file mode 100644
index 7db86105348..00000000000
--- a/arch/riscv/dts/fu540-c000.dtsi
+++ /dev/null
@@ -1,286 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2018-2019 SiFive, Inc */
-
-/dts-v1/;
-
-#include <dt-bindings/clock/sifive-fu540-prci.h>
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	compatible = "sifive,fu540-c000", "sifive,fu540";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		ethernet0 = &eth0;
-	};
-
-	chosen {
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu0: cpu@0 {
-			compatible = "sifive,e51", "sifive,rocket0", "riscv";
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <16384>;
-			reg = <0>;
-			riscv,isa = "rv64imac";
-			status = "disabled";
-			cpu0_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu1: cpu@1 {
-			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <32>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <32>;
-			mmu-type = "riscv,sv39";
-			reg = <1>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			next-level-cache = <&l2cache>;
-			cpu1_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu2: cpu@2 {
-			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <32>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <32>;
-			mmu-type = "riscv,sv39";
-			reg = <2>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			next-level-cache = <&l2cache>;
-			cpu2_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu3: cpu@3 {
-			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <32>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <32>;
-			mmu-type = "riscv,sv39";
-			reg = <3>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			next-level-cache = <&l2cache>;
-			cpu3_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu4: cpu@4 {
-			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <32>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <32>;
-			mmu-type = "riscv,sv39";
-			reg = <4>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			next-level-cache = <&l2cache>;
-			cpu4_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-	};
-	soc {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "sifive,fu540-c000", "sifive,fu540", "simple-bus";
-		ranges;
-		plic0: interrupt-controller@c000000 {
-			#interrupt-cells = <1>;
-			compatible = "sifive,plic-1.0.0";
-			reg = <0x0 0xc000000 0x0 0x4000000>;
-			riscv,ndev = <53>;
-			interrupt-controller;
-			interrupts-extended = <
-				&cpu0_intc 0xffffffff
-				&cpu1_intc 0xffffffff &cpu1_intc 9
-				&cpu2_intc 0xffffffff &cpu2_intc 9
-				&cpu3_intc 0xffffffff &cpu3_intc 9
-				&cpu4_intc 0xffffffff &cpu4_intc 9>;
-		};
-		prci: clock-controller@10000000 {
-			compatible = "sifive,fu540-c000-prci";
-			reg = <0x0 0x10000000 0x0 0x1000>;
-			clocks = <&hfclk>, <&rtcclk>;
-			#clock-cells = <1>;
-		};
-		uart0: serial@10010000 {
-			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-			reg = <0x0 0x10010000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <4>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			status = "disabled";
-		};
-		dma: dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
-			reg = <0x0 0x3000000 0x0 0x8000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <23 24 25 26 27 28 29 30>;
-			#dma-cells = <1>;
-		};
-		uart1: serial@10011000 {
-			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-			reg = <0x0 0x10011000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <5>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			status = "disabled";
-		};
-		i2c0: i2c@10030000 {
-			compatible = "sifive,fu540-c000-i2c", "sifive,i2c0";
-			reg = <0x0 0x10030000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <50>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		qspi0: spi@10040000 {
-			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10040000 0x0 0x1000
-			       0x0 0x20000000 0x0 0x10000000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <51>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		qspi1: spi@10041000 {
-			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10041000 0x0 0x1000
-			       0x0 0x30000000 0x0 0x10000000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <52>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		qspi2: spi@10050000 {
-			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10050000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <6>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		eth0: ethernet@10090000 {
-			compatible = "sifive,fu540-c000-gem";
-			interrupt-parent = <&plic0>;
-			interrupts = <53>;
-			reg = <0x0 0x10090000 0x0 0x2000
-			       0x0 0x100a0000 0x0 0x1000>;
-			local-mac-address = [00 00 00 00 00 00];
-			clock-names = "pclk", "hclk";
-			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
-				 <&prci PRCI_CLK_GEMGXLPLL>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		pwm0: pwm@10020000 {
-			compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
-			reg = <0x0 0x10020000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <42 43 44 45>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-		pwm1: pwm@10021000 {
-			compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
-			reg = <0x0 0x10021000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <46 47 48 49>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-		l2cache: cache-controller@2010000 {
-			compatible = "sifive,fu540-c000-ccache", "cache";
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-sets = <1024>;
-			cache-size = <2097152>;
-			cache-unified;
-			interrupt-parent = <&plic0>;
-			interrupts = <1 2 3>;
-			reg = <0x0 0x2010000 0x0 0x1000>;
-		};
-		gpio: gpio@10060000 {
-			compatible = "sifive,fu540-c000-gpio", "sifive,gpio0";
-			interrupt-parent = <&plic0>;
-			interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>,
-				     <14>, <15>, <16>, <17>, <18>, <19>, <20>,
-				     <21>, <22>;
-			reg = <0x0 0x10060000 0x0 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/riscv/dts/fu740-c000.dtsi b/arch/riscv/dts/fu740-c000.dtsi
deleted file mode 100644
index 7b77c13496d..00000000000
--- a/arch/riscv/dts/fu740-c000.dtsi
+++ /dev/null
@@ -1,326 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2020 SiFive, Inc */
-
-/dts-v1/;
-
-#include <dt-bindings/clock/sifive-fu740-prci.h>
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	compatible = "sifive,fu740-c000", "sifive,fu740";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		ethernet0 = &eth0;
-	};
-
-	chosen {
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu0: cpu@0 {
-			compatible = "sifive,bullet0", "riscv";
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <16384>;
-			next-level-cache = <&ccache>;
-			reg = <0x0>;
-			riscv,isa = "rv64imac";
-			status = "disabled";
-			cpu0_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu1: cpu@1 {
-			compatible = "sifive,bullet0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			reg = <0x1>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			cpu1_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu2: cpu@2 {
-			compatible = "sifive,bullet0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			reg = <0x2>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			cpu2_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu3: cpu@3 {
-			compatible = "sifive,bullet0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			reg = <0x3>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			cpu3_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-		cpu4: cpu@4 {
-			compatible = "sifive,bullet0", "riscv";
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			reg = <0x4>;
-			riscv,isa = "rv64imafdc";
-			tlb-split;
-			cpu4_intc: interrupt-controller {
-				#interrupt-cells = <1>;
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-			};
-		};
-	};
-	soc {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "simple-bus";
-		ranges;
-		plic0: interrupt-controller@c000000 {
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
-			reg = <0x0 0xc000000 0x0 0x4000000>;
-			riscv,ndev = <69>;
-			interrupt-controller;
-			interrupts-extended =
-				<&cpu0_intc 0xffffffff>,
-				<&cpu1_intc 0xffffffff>, <&cpu1_intc 9>,
-				<&cpu2_intc 0xffffffff>, <&cpu2_intc 9>,
-				<&cpu3_intc 0xffffffff>, <&cpu3_intc 9>,
-				<&cpu4_intc 0xffffffff>, <&cpu4_intc 9>;
-		};
-		prci: clock-controller@10000000 {
-			compatible = "sifive,fu740-c000-prci";
-			reg = <0x0 0x10000000 0x0 0x1000>;
-			clocks = <&hfclk>, <&rtcclk>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-		uart0: serial@10010000 {
-			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
-			reg = <0x0 0x10010000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <39>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			status = "disabled";
-		};
-		uart1: serial@10011000 {
-			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
-			reg = <0x0 0x10011000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <40>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			status = "disabled";
-		};
-		i2c0: i2c@10030000 {
-			compatible = "sifive,fu740-c000-i2c", "sifive,i2c0";
-			reg = <0x0 0x10030000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <52>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		i2c1: i2c@10031000 {
-			compatible = "sifive,fu740-c000-i2c", "sifive,i2c0";
-			reg = <0x0 0x10031000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <53>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		qspi0: spi@10040000 {
-			compatible = "sifive,fu740-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10040000 0x0 0x1000>,
-			      <0x0 0x20000000 0x0 0x10000000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <41>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		qspi1: spi@10041000 {
-			compatible = "sifive,fu740-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10041000 0x0 0x1000>,
-			      <0x0 0x30000000 0x0 0x10000000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <42>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		spi0: spi@10050000 {
-			compatible = "sifive,fu740-c000-spi", "sifive,spi0";
-			reg = <0x0 0x10050000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <43>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		eth0: ethernet@10090000 {
-			compatible = "sifive,fu540-c000-gem";
-			interrupt-parent = <&plic0>;
-			interrupts = <55>;
-			reg = <0x0 0x10090000 0x0 0x2000>,
-			      <0x0 0x100a0000 0x0 0x1000>;
-			local-mac-address = [00 00 00 00 00 00];
-			clock-names = "pclk", "hclk";
-			clocks = <&prci FU740_PRCI_CLK_GEMGXLPLL>,
-				 <&prci FU740_PRCI_CLK_GEMGXLPLL>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		pwm0: pwm@10020000 {
-			compatible = "sifive,fu740-c000-pwm", "sifive,pwm0";
-			reg = <0x0 0x10020000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <44>, <45>, <46>, <47>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-		pwm1: pwm@10021000 {
-			compatible = "sifive,fu740-c000-pwm", "sifive,pwm0";
-			reg = <0x0 0x10021000 0x0 0x1000>;
-			interrupt-parent = <&plic0>;
-			interrupts = <48>, <49>, <50>, <51>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-		ccache: cache-controller@2010000 {
-			compatible = "sifive,fu740-c000-ccache", "cache";
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-sets = <2048>;
-			cache-size = <2097152>;
-			cache-unified;
-			interrupt-parent = <&plic0>;
-			interrupts = <19>, <21>, <22>, <20>;
-			reg = <0x0 0x2010000 0x0 0x1000>;
-		};
-		gpio: gpio@10060000 {
-			compatible = "sifive,fu740-c000-gpio", "sifive,gpio0";
-			interrupt-parent = <&plic0>;
-			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
-				     <30>, <31>, <32>, <33>, <34>, <35>, <36>,
-				     <37>, <38>;
-			reg = <0x0 0x10060000 0x0 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&prci FU740_PRCI_CLK_PCLK>;
-			status = "disabled";
-		};
-		pcie@e00000000 {
-			compatible = "sifive,fu740-pcie";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			reg = <0xe 0x00000000 0x0 0x80000000>,
-			      <0xd 0xf0000000 0x0 0x10000000>,
-			      <0x0 0x100d0000 0x0 0x1000>;
-			reg-names = "dbi", "config", "mgmt";
-			device_type = "pci";
-			dma-coherent;
-			bus-range = <0x0 0xff>;
-			ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
-				 <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
-				 <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
-				 <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
-			num-lanes = <0x8>;
-			interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
-			interrupt-names = "msi", "inta", "intb", "intc", "intd";
-			interrupt-parent = <&plic0>;
-			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-			interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
-					<0x0 0x0 0x0 0x2 &plic0 58>,
-					<0x0 0x0 0x0 0x3 &plic0 59>,
-					<0x0 0x0 0x0 0x4 &plic0 60>;
-			clock-names = "pcie_aux";
-			clocks = <&prci FU740_PRCI_CLK_PCIE_AUX>;
-			pwren-gpios = <&gpio 5 0>;
-			reset-gpios = <&gpio 8 0>;
-			resets = <&prci 4>;
-			status = "okay";
-		};
-	};
-};
diff --git a/arch/riscv/dts/hifive-unleashed-a00.dts b/arch/riscv/dts/hifive-unleashed-a00.dts
deleted file mode 100644
index 4a2729f5ca3..00000000000
--- a/arch/riscv/dts/hifive-unleashed-a00.dts
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2018-2019 SiFive, Inc */
-
-#include "fu540-c000.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
-#define RTCCLK_FREQ		1000000
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	model = "SiFive HiFive Unleashed A00";
-	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	cpus {
-		timebase-frequency = <RTCCLK_FREQ>;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x2 0x00000000>;
-	};
-
-	soc {
-	};
-
-	hfclk: hfclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <33333333>;
-		clock-output-names = "hfclk";
-	};
-
-	rtcclk: rtcclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <RTCCLK_FREQ>;
-		clock-output-names = "rtcclk";
-	};
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&qspi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "issi,is25wp256", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <50000000>;
-		m25p,fast-read;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&qspi2 {
-	status = "okay";
-	mmc@0 {
-		compatible = "mmc-spi-slot";
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-		voltage-ranges = <3300 3300>;
-		disable-wp;
-	};
-};
-
-&eth0 {
-	status = "okay";
-	phy-mode = "gmii";
-	phy-handle = <&phy0>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-	};
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&gpio {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/hifive-unmatched-a00.dts b/arch/riscv/dts/hifive-unmatched-a00.dts
deleted file mode 100644
index c4ed9efdff0..00000000000
--- a/arch/riscv/dts/hifive-unmatched-a00.dts
+++ /dev/null
@@ -1,246 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2020 SiFive, Inc */
-
-#include "fu740-c000.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
-#define RTCCLK_FREQ		1000000
-
-/ {
-	model = "SiFive HiFive Unmatched A00";
-	compatible = "sifive,hifive-unmatched-a00", "sifive,fu740-c000",
-		     "sifive,fu740";
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	cpus {
-		timebase-frequency = <RTCCLK_FREQ>;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x4 0x00000000>;
-	};
-
-	hfclk: hfclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
-		clock-output-names = "hfclk";
-	};
-
-	rtcclk: rtcclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <RTCCLK_FREQ>;
-		clock-output-names = "rtcclk";
-	};
-
-	gpio-poweroff {
-		compatible = "gpio-poweroff";
-		gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	temperature-sensor@4c {
-		compatible = "ti,tmp451";
-		reg = <0x4c>;
-		vcc-supply = <&vdd_bpro>;
-		interrupt-parent = <&gpio>;
-		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	eeprom@54 {
-		compatible = "microchip,24c02", "atmel,24c02";
-		reg = <0x54>;
-		vcc-supply = <&vdd_bpro>;
-		label = "board-id";
-		pagesize = <16>;
-		read-only;
-		size = <256>;
-	};
-
-	pmic@58 {
-		compatible = "dlg,da9063";
-		reg = <0x58>;
-		interrupt-parent = <&gpio>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-
-		onkey {
-			compatible = "dlg,da9063-onkey";
-		};
-
-		rtc {
-			compatible = "dlg,da9063-rtc";
-		};
-
-		wdt {
-			compatible = "dlg,da9063-watchdog";
-		};
-
-		regulators {
-			vdd_bcore: bcores-merged {
-				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1050000>;
-				regulator-min-microamp = <4800000>;
-				regulator-max-microamp = <4800000>;
-				regulator-always-on;
-			};
-
-			vdd_bpro: bpro {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp = <2400000>;
-				regulator-max-microamp = <2400000>;
-				regulator-always-on;
-			};
-
-			vdd_bperi: bperi {
-				regulator-min-microvolt = <1060000>;
-				regulator-max-microvolt = <1060000>;
-				regulator-min-microamp = <1500000>;
-				regulator-max-microamp = <1500000>;
-				regulator-always-on;
-			};
-
-			vdd_bmem_bio: bmem-bio-merged {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-min-microamp = <3000000>;
-				regulator-max-microamp = <3000000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo1: ldo1 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo2: ldo2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo3: ldo3 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo4: ldo4 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo5: ldo5 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo6: ldo6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo7: ldo7 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo8: ldo8 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_ld09: ldo9 {
-				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1050000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo10: ldo10 {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vdd_ldo11: ldo11 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&qspi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <50000000>;
-		m25p,fast-read;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&spi0 {
-	status = "okay";
-	mmc@0 {
-		compatible = "mmc-spi-slot";
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-		voltage-ranges = <3300 3300>;
-		disable-wp;
-		gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&eth0 {
-	status = "okay";
-	phy-mode = "gmii";
-	phy-handle = <&phy0>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-	};
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&gpio {
-	status = "okay";
-	gpio-line-names = "J29.1", "PMICNTB", "PMICSHDN", "J8.1", "J8.3",
-		"PCIe_PWREN", "THERM", "UBRDG_RSTN", "PCIe_PERSTN",
-		"ULPI_RSTN", "J8.2", "UHUB_RSTN", "GEMGXL_RST", "J8.4",
-		"EN_VDD_SD", "SD_CD";
-};
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index f341e3e0735..80c6b02b7af 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="hifive-unleashed-a00"
+CONFIG_DEFAULT_DEVICE_TREE="sifive/hifive-unleashed-a00"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_STACK=0x81cfe70
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 0a736f2ba95..55b9e368ef3 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="hifive-unmatched-a00"
+CONFIG_DEFAULT_DEVICE_TREE="sifive/hifive-unmatched-a00"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_STACK=0x81cfe60
diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index e55a26ab8fd..5d0b08d3755 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -59,25 +59,25 @@ static const struct __prci_clock_ops sifive_fu540_prci_tlclksel_clk_ops = {
 
 /* List of clock controls provided by the PRCI */
 static struct __prci_clock __prci_init_clocks_fu540[] = {
-	[PRCI_CLK_COREPLL] = {
+	[FU540_PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_corepll_data,
 	},
-	[PRCI_CLK_DDRPLL] = {
+	[FU540_PRCI_CLK_DDRPLL] = {
 		.name = "ddrpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_ddrpll_data,
 	},
-	[PRCI_CLK_GEMGXLPLL] = {
+	[FU540_PRCI_CLK_GEMGXLPLL] = {
 		.name = "gemgxlpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_gemgxlpll_data,
 	},
-	[PRCI_CLK_TLCLK] = {
+	[FU540_PRCI_CLK_TLCLK] = {
 		.name = "tlclk",
 		.parent_name = "corepll",
 		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
diff --git a/include/dt-bindings/clock/sifive-fu540-prci.h b/include/dt-bindings/clock/sifive-fu540-prci.h
deleted file mode 100644
index 6a0b70a37d7..00000000000
--- a/include/dt-bindings/clock/sifive-fu540-prci.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018-2019 SiFive, Inc.
- * Wesley Terpstra
- * Paul Walmsley
- */
-
-#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
-#define __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
-
-/* Clock indexes for use by Device Tree data and the PRCI driver */
-
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_TLCLK		       3
-
-#endif
-- 
2.52.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
