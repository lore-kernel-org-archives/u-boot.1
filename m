Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D3C47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0DC87E2C;
	Sun, 28 Jan 2024 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGRhTayF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87067880B6; Sun, 28 Jan 2024 08:06:39 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E8088071
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 08:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so818946a12.1
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706425594; x=1707030394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQH8O3zAmWSobQvBEjb2Zzx6qnRR+HfrQcW6byd7HyQ=;
 b=eGRhTayFyITkaOdcs/e8e1Vy9RqYq9XYedGTddItP+2G4J3vwHuZ3EI3fAOL1M+0aF
 VuwYJOLHRceQnU/Bm5VSskUAx9yXfsQP/mfyXH1Tp3E4ugsZ15SzyfdfElmvqUyJ5TTT
 ewd+xleNVOPoRyMNXy0ZSvK4xSTZVzv14AHQK4e0J7JgZdh2jt1um0bnHhRljBc60RjF
 ZUInbhfvX05YcfUBcC4n+xdU4i2vy8CRoP7CgUCCmZmtLjcn91g5HImDIhq5/ySzW6OJ
 tGYgccdOgQUpeszzNIC9oH0eLKw8raiU+AgkLeENioXwGg5FGnzB6aDNS62JfUmTnawc
 T80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706425594; x=1707030394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQH8O3zAmWSobQvBEjb2Zzx6qnRR+HfrQcW6byd7HyQ=;
 b=ljjMl5CkoJ8biHouTcZJ8D+nlQyqYAzfnN0jy9LYVQJ25L2wHHHScoYlCbEskVnmVO
 SexQ5c1gd68Mq2UX5oNpcKPSO/USlZCz1T1jY8BEfN3Lr34fhsJ38UQ7LSZiIXdws5Tx
 AP2IBTDB5sSfnJj5v+ze/Rp8fIfwboPyK50YBsIg815LF3HPiB5GFhUOj0KVG4o2GwF1
 /487SHIlOj6WmzphiRh2w0wBjsi4HmJSuxPeI/3H+QgqZaaPNYlr5IVNaHGwfhVMJRng
 c3zZkaLAw+LB6DBzCjzPVI8L2OAoUEdx4FFaQsWbD44GL4yw85LU8umdsflpAqmdkr5S
 83zQ==
X-Gm-Message-State: AOJu0YxSsu4sir/DZ1kolHUxv96NCg+sXcWBRONpfTEgkzkYJKBFoiNz
 nGDHVtmDrU1Qzni4zquioEoVqeIIvYpMqqXH7fJmkXtZ2ijLntOQPSUvq/CbiOotWsPa
X-Google-Smtp-Source: AGHT+IEjySiF6LQs7U05pF8PUUlEuiGH245bmllDm1lWmFQhfgGtLX0so5BI/nt54zQ2dEhZ+DODIA==
X-Received: by 2002:a17:902:e807:b0:1d5:f440:bbc8 with SMTP id
 u7-20020a170902e80700b001d5f440bbc8mr1796521plg.91.1706425594123; 
 Sat, 27 Jan 2024 23:06:34 -0800 (PST)
Received: from localhost.localdomain ([115.216.236.184])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001d88b4b87f9sm3287297plb.192.2024.01.27.23.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 23:06:33 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v4 1/3] riscv: dts: sophgo: add basic device tree for Milk-V
 Duo board
Date: Sun, 28 Jan 2024 15:05:24 +0800
Message-ID: <20240128070614.7702-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240128070614.7702-1-seashell11234455@gmail.com>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 15:10:42 +0100
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

Changes in v4:
- Sync dts files with Linux kernel

Changes in v3:
- Swap patch 1 and 2 duo to dependency of defconfig and device tree

 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 ++++++
 arch/riscv/dts/cv1800b.dtsi          |  18 +++
 arch/riscv/dts/cv18xx.dtsi           | 192 +++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi
 create mode 100644 arch/riscv/dts/cv18xx.dtsi

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index b05bb5607f..17cda483e1 100644
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
index 0000000000..165e9e320a
--- /dev/null
+++ b/arch/riscv/dts/cv1800b.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include "cv18xx.dtsi"
+
+/ {
+	compatible = "sophgo,cv1800b";
+};
+
+&plic {
+	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
+};
+
+&clint {
+	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
+};
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
new file mode 100644
index 0000000000..2d6f4a4b1e
--- /dev/null
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
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
+		gpio0: gpio@3020000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3020000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@3021000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3021000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@3022000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3022000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio3: gpio@3023000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3023000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
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
+			reg = <0x70000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <101>;
+		};
+
+		clint: timer@74000000 {
+			reg = <0x74000000 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};
-- 
2.41.0

