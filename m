Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BBFC47DAF
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 15:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC827877F4;
	Sun, 21 Jan 2024 16:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1cDB5vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B400687705; Sun, 21 Jan 2024 16:06:55 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE908772A
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 16:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6dac225bf42so1193132b3a.0
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705849611; x=1706454411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV5TgzHzGSjjJQqqSWgKplUIGjVbXkYLlHUsTsIyqE0=;
 b=j1cDB5vsuE8EMKkldlIq0KgAyl4Ki+0QZsrKcoZxlhUTME1E1Z1w3ysNxhD6eeXGzH
 f8h6XTJPDWJlHR+lMYH2YKbjMJNNT70KTaiNuuasAEwoE4o3vnF/gAs59HS+Qhssy3ls
 MripewOcAdCTqYdOaajNGP3gdZcZVflXKX27HB7tlzCD12GtGPSsGbAz+Xx5PTP9+Vxu
 jjXTW6egsI2n6igsLCPnIHTMVorlsVP7hRSDV5ZvoAydtN8n6yVmUBPuAriVAk3IUajC
 SkzfvPfPSqpR/C2i0gysYFzF0Jpm4kvt8PpcNkm2bp2AzctP3AQDNdbladW61ihF3DRD
 7u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705849611; x=1706454411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV5TgzHzGSjjJQqqSWgKplUIGjVbXkYLlHUsTsIyqE0=;
 b=ip6JZLUQewMCDrAVlYKzaFhpiYBee98oZm2Rwyno6c/DTMdXU5yzBA7DOaBVxUNSaL
 3xeMePoQPFyWSDRz28Uadxwetzn2mwg8/EJB+PRRrKIYQNBY3taaz+fGYnLH4fxpwMUV
 QGPGNu7ILYuAk1Bp1du5j3GppXUzQwpAjuUM8UZqfoecualB3QNHfLZ8plwvvKWA/1lc
 5NRqOGKGueOURYsDlxIes1FsjIVO7f3yhB7wUcQc1vb57o/bJXA3uqu5BBLS5bVbHmwG
 WY3EhzizCkwRV/UOD3w22dAlU8/k9SXkKDKZSVBEvg0eli7hMferuLAvbsdypc4Rde9p
 iWIg==
X-Gm-Message-State: AOJu0Ywa2G/TuiMLe4ysTgEnwt5RLQMl0zKW9p96ZRbb3ytyxgDXcyxQ
 SnQoM4QF4DxHUsyWyG02zr0JTL5PrGwNEXGz4NnDXs1g8R0JMsZtVykQoTS5kGhxzQ==
X-Google-Smtp-Source: AGHT+IE3DEfuhqJmWGHUZuzYeX4zL09U+yRC2dVcYOriRRMofsQxiZqMtABAet2XNX7soyiHD3cwyg==
X-Received: by 2002:a17:903:26d4:b0:1d5:4c61:a3f3 with SMTP id
 jg20-20020a17090326d400b001d54c61a3f3mr985422plb.101.1705849610723; 
 Sun, 21 Jan 2024 07:06:50 -0800 (PST)
Received: from localhost.localdomain ([218.73.27.11])
 by smtp.gmail.com with ESMTPSA id
 ke5-20020a170903340500b001d33e6521b9sm5942139plb.14.2024.01.21.07.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 07:06:50 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 1/3] riscv: dts: sophgo: add basic device tree for Milk-V
 Duo board
Date: Sun, 21 Jan 2024 23:05:13 +0800
Message-ID: <20240121150630.30588-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240121150630.30588-1-seashell11234455@gmail.com>
References: <20240121150630.30588-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jan 2024 16:11:19 +0100
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

Changes in v3:
- Swap patch 1 and 2 duo to dependency of defconfig and device tree

 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 +++++++++
 arch/riscv/dts/cv1800b.dtsi          | 123 +++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi

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

