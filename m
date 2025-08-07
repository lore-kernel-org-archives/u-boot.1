Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A85C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB708456D;
	Thu,  7 Aug 2025 13:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F70E84547; Thu,  7 Aug 2025 13:38:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393EC84540
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577BcRom077453
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:38:27 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:38:27 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 2/6] riscv: dts: andes: Add Voyager device tree
Date: Thu, 7 Aug 2025 19:38:17 +0800
Message-ID: <20250807113817.362062-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577BcRom077453
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

Introduce the initial device tree support for Andes Voyager board.
We will convert to OF_UPSTREAM once the patch series for kernel is merged.

Signed-off-by: Randolph Sheng-Kai Lin <randolph@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/dts/Makefile            |   1 +
 arch/riscv/dts/qilai-voyager.dts   | 227 +++++++++++++++++++++++++++++
 arch/riscv/dts/voyager-u-boot.dtsi |  52 +++++++
 3 files changed, 280 insertions(+)
 create mode 100644 arch/riscv/dts/qilai-voyager.dts
 create mode 100644 arch/riscv/dts/voyager-u-boot.dtsi

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 2b10c2d6c01..86d08115db4 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
+dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
diff --git a/arch/riscv/dts/qilai-voyager.dts b/arch/riscv/dts/qilai-voyager.dts
new file mode 100644
index 00000000000..cebfede51a3
--- /dev/null
+++ b/arch/riscv/dts/qilai-voyager.dts
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "binman.dtsi"
+#include "voyager-u-boot.dtsi"
+
+/ {
+	#address-cells = <0x2>;
+	#size-cells = <0x2>;
+	compatible = "andestech,ax45";
+	model = "andestech,ax45";
+
+	aliases {
+		uart0 = &serial0;
+		spi0 = &spi;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlycon=sbi debug loglevel=7";
+		stdout-path = "uart0:115200n8";
+	};
+
+	cpus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		timebase-frequency = <0x3938700>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,isa = "rv64imafdc";
+			riscv,priv-major = <0x1>;
+			riscv,priv-minor = <0xa>;
+			mmu-type = "riscv,sv39";
+			clock-frequency = <0x3938700>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+			next-level-cache = <&L2>;
+
+			CPU0_intc: interrupt-controller {
+				#interrupt-cells = <0x1>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,isa = "rv64imafdc";
+			riscv,priv-major = <0x1>;
+			riscv,priv-minor = <0xa>;
+			mmu-type = "riscv,sv39";
+			clock-frequency = <0x3938700>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+			next-level-cache = <&L2>;
+
+			CPU1_intc: interrupt-controller {
+				#interrupt-cells = <0x1>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+			};
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			reg = <0x2>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,isa = "rv64imafdc";
+			riscv,priv-major = <0x1>;
+			riscv,priv-minor = <0xa>;
+			mmu-type = "riscv,sv39";
+			clock-frequency = <0x3938700>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+			next-level-cache = <&L2>;
+
+			CPU2_intc: interrupt-controller {
+				#interrupt-cells = <0x1>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+			};
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			reg = <0x3>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,isa = "rv64imafdc";
+			riscv,priv-major = <0x1>;
+			riscv,priv-minor = <0xa>;
+			mmu-type = "riscv,sv39";
+			clock-frequency = <0x3938700>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+			next-level-cache = <&L2>;
+
+			CPU3_intc: interrupt-controller {
+				#interrupt-cells = <0x1>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+			};
+		};
+	};
+
+	L2: l2-cache@200000 {
+		compatible = "cache";
+		cache-level = <0x2>;
+		cache-size = <0x40000>;
+		reg = <0x0 0x00200000 0x0 0x100000>;
+		andes,inst-prefetch = <0x3>;
+		andes,data-prefetch = <0x3>;
+		andes,tag-ram-ctl = <0x0 0x0>;
+		andes,data-ram-ctl = <0x0 0x0>;
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x04 0x00000000 0x0 0x40000000>;
+	};
+
+	soc {
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		compatible = "andestech,riscv-ae350-soc", "simple-bus";
+		ranges;
+
+		plic0: interrupt-controller@2000000 {
+			compatible = "riscv,plic0";
+			#address-cells = <0x2>;
+			#interrupt-cells = <0x2>;
+			interrupt-controller;
+			reg = <0x0 0x02000000 0x0 0x2000000>;
+			riscv,ndev = <0x47>;
+			interrupts-extended = <&CPU0_intc 11 &CPU0_intc 9
+				&CPU1_intc 11 &CPU1_intc 9
+				&CPU2_intc 11 &CPU2_intc 9
+				&CPU3_intc 11 &CPU3_intc 9>;
+		};
+
+		plic1: interrupt-controller@400000 {
+			compatible = "andestech,plicsw";
+			#address-cells = <0x2>;
+			#interrupt-cells = <0x2>;
+			interrupt-controller;
+			reg = <0x0 0x00400000 0x0 0x400000>;
+			riscv,ndev = <0x1>;
+			interrupts-extended = <&CPU0_intc 3
+				&CPU1_intc 3
+				&CPU2_intc 3
+				&CPU3_intc 3>;
+		};
+
+		plmt0@100000 {
+			compatible = "andestech,plmt0";
+			reg = <0x0 0x00100000 0x0 0x100000>;
+			interrupts-extended = <&CPU0_intc 7
+				&CPU1_intc 7
+				&CPU2_intc 7
+				&CPU3_intc 7>;
+		};
+	};
+
+	spiclk: virt_100mhz {
+		#clock-cells = <0x0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0x5f5e100>;
+	};
+
+	serial0: serial@30300000 {
+		compatible = "andestech,uart16550", "ns16550a";
+		reg = <0x0 0x30300000 0x0 0x1000>;
+		interrupts = <0x9 0x4>;
+		clock-frequency = <0x12c0000>;
+		reg-shift = <0x2>;
+		reg-offset = <0x20>;
+		no-loopback-test = <0x1>;
+		interrupt-parent = <&plic0>;
+	};
+
+	mmc0: mmc@30c00000 {
+		compatible = "andestech,atfsdc010";
+		max-frequency = <0x5f5e100>;
+		clock-freq-min-max = <0x61a80 0x5f5e100>;
+		fifo-depth = <0x10>;
+		reg = <0x0 0x30c00000 0x0 0x1000>;
+		interrupts = <0x12 0x4>;
+		cap-sd-highspeed;
+		interrupt-parent = <&plic0>;
+		dma-coherent;
+	};
+
+	spi: spi@30900000 {
+		compatible = "andestech,atcspi200";
+		reg = <0x0 0x30900000 0x0 0x100000>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		num-cs = <0x1>;
+		clocks = <&spiclk>;
+		interrupts = <0x4 0x4>;
+		interrupt-parent = <&plic0>;
+
+		flash@0 {
+			compatible = "mx25u1635e", "jedec,spi-nor";
+			spi-max-frequency = <0x2faf080>;
+			reg = <0x0>;
+			spi-cpol;
+			spi-cpha;
+		};
+	};
+};
diff --git a/arch/riscv/dts/voyager-u-boot.dtsi b/arch/riscv/dts/voyager-u-boot.dtsi
new file mode 100644
index 00000000000..cef0aa08b37
--- /dev/null
+++ b/arch/riscv/dts/voyager-u-boot.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/ {
+	cpus {
+		bootph-pre-ram;
+		CPU0: cpu@0 {
+			bootph-pre-ram;
+			CPU0_intc: interrupt-controller {
+				bootph-pre-ram;
+			};
+		};
+		CPU1: cpu@1 {
+			bootph-pre-ram;
+			CPU1_intc: interrupt-controller {
+				bootph-pre-ram;
+			};
+		};
+		CPU2: cpu@2 {
+			bootph-pre-ram;
+			CPU2_intc: interrupt-controller {
+				bootph-pre-ram;
+			};
+		};
+		CPU3: cpu@3 {
+			bootph-pre-ram;
+			CPU3_intc: interrupt-controller {
+				bootph-pre-ram;
+			};
+		};
+	};
+
+	memory@0 {
+		bootph-pre-ram;
+	};
+
+	soc {
+		bootph-pre-ram;
+
+		plic1: interrupt-controller@400000 {
+			bootph-pre-ram;
+		};
+
+		plmt0@100000 {
+			bootph-pre-ram;
+		};
+	};
+
+	serial0: serial@30300000 {
+		bootph-pre-ram;
+	};
+
+};
-- 
2.34.1

