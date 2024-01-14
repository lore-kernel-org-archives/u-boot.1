Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B116EC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF51879A5;
	Sun, 14 Jan 2024 19:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R/5UG0T3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF7C87979; Sun, 14 Jan 2024 19:08:11 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8668773F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d98ce84e18so6997098b3a.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705255687; x=1705860487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuNqP9VvUKyrCH/oQVHOfLBHfW7rlIWQPGbwBg6mdWk=;
 b=R/5UG0T34Gzfa7yTx8YO+Dg68mS+1fs+gR10l1uJtlEgtn0GIXEubD3tTne6uEjGnl
 Oi03Pc+UrLVL+dmCtHzWBSRnEuUUJguNfdQ0Ygrb/4qlpBG9mL2kmYcMlcJP9RkbX6XU
 WsuJIcrJP9YxlxjGQ3Z+tK+HbNUQTDlhlUmv/8uqCcdhLC6k1YjsZdigFzjqhKAoZX84
 JZqhfCSFs9LOFoTPK5zRgWNkCm5uaxmJAAAXNPNP9Z6M85aKXADukZkL+ZldvzN7O2jF
 lnGEvTrcOB/LRRJVqNTFcIaopKUqJb2Ye91pXW4kVqyg9NKVy6qpVK3Pl/r2rB+b7ifp
 Qscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705255687; x=1705860487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuNqP9VvUKyrCH/oQVHOfLBHfW7rlIWQPGbwBg6mdWk=;
 b=w7V25vlvAIM4JvMnBOjvxpaIqSnE2AhkQ+i5h/0B14IX7l3BB3cNB0kl8ouaJFB9aY
 AUgI0CDmSNOrfuB/yBTOxz7wWRj5MwdBWkShpBgumFvViB4E2NIWZLHyu9c4yyj5Ar01
 oPe1o6AwIqQaQ4X1qNeuR/h8RqytvgIXFJtAprmZEzRDPUNWRCio0njHsTlGwK7YD4Ay
 Gar+K8RuFTohl/fFDq+Rl6etFmEbWXfXWhNB5uoJXY5HsfBAvP+KzOauw4qvoXM2xpcx
 MZ+72t9uemyF23Jk86RL/Du3n/56puvXHcfosXfvj+6xAW2GlwpN8GmUuCid6p/BcYwN
 5D3g==
X-Gm-Message-State: AOJu0YwfAxletfuTShwZqpWRrpflhKUB/yR3ChTWinCHh82z9vOYs4hJ
 DkFEEJhu3av+tSnVdl9t0TaX+52TzP/eceaA
X-Google-Smtp-Source: AGHT+IErJTwHcwLpoqsgjkPcwtouJe/AsTBWJcLCeIRCqpugLSRtV9Dr0+WHA/DuZnvS8wHQgCHOCw==
X-Received: by 2002:a05:6a21:6706:b0:19a:fad2:50b4 with SMTP id
 wh6-20020a056a21670600b0019afad250b4mr411689pzb.38.1705255687055; 
 Sun, 14 Jan 2024 10:08:07 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b006d998f5b890sm6253657pfj.192.2024.01.14.10.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 10:08:06 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 2/3] riscv: dts: sophgo: Add basic device tree for Milk-V
 Duo board
Date: Mon, 15 Jan 2024 02:07:38 +0800
Message-ID: <20240114180741.2114-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240114180741.2114-1-seashell11234455@gmail.com>
References: <20240114180741.2114-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jan 2024 19:08:45 +0100
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

Import device tree from Linux kernel to add basic support for CPU, PLIC,
UART and Timer. The name cv1800b in the filename represent the chip used
on Milk-V Duo board.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

(no changes since v1)

 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 +++++++++
 arch/riscv/dts/cv1800b.dtsi          | 123 +++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index be6c8a4227..b9e1678676 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,6 +2,7 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
new file mode 100644
index 0000000000..3af9e34b3b
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "cv1800b.dtsi"
+
+/ {
+	model = "Milk-V Duo";
+	compatible = "milkv,duo", "sophgo,cv1800b";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x3f40000>;
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
new file mode 100644
index 0000000000..df40e87ee0
--- /dev/null
+++ b/arch/riscv/dts/cv1800b.dtsi
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "sophgo,cv1800b";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <25000000>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	osc: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_25m";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-noncoherent;
+		ranges;
+
+		uart0: serial@4140000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04140000 0x100>;
+			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@4150000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04150000 0x100>;
+			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@4160000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04160000 0x100>;
+			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@4170000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04170000 0x100>;
+			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart4: serial@41c0000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x041c0000 0x100>;
+			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@70000000 {
+			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
+			reg = <0x70000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <101>;
+		};
+
+		clint: timer@74000000 {
+			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
+			reg = <0x74000000 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};
-- 
2.41.0

