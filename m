Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B3CE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACA3806E8;
	Tue, 14 Jan 2025 18:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="UNR6l25H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB668022E; Tue, 14 Jan 2025 17:47:19 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EDC8007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873234; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YBSedV5mT300S2aFuQ68yywofminu2f5d0FCtAiyzihE13nDb9wPHciVWf+DRrmXFZgE8e3+oCJK2h1CcNI0RlPPEgRL1beabvn+BYzleeGovHzgJD2TveikQkiXtkysNf7bNVSIWY/ZVyjSt4/TNepxAeK9IfUKEKCskh97crg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mJj28uziXgEFaFlzPAPHiP+6A0/2Delb4kF/huRa2uI=; 
 b=Bjq7b85qxWQk1It/ZKXD9M59Ur2x1XDTuBp2f35tAAa0eyzstD5El7G2jC8xL2/p1emss6RyPHPIufMgbwjVBPWHDcA0lWPmu1WwecaOXY+6rVTEG0Kj0c3A08lhhKNrhuxPwkAH6xkfDxUNByRH3mlYbhe9hPQjhCDYuwVF4SE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873234; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=mJj28uziXgEFaFlzPAPHiP+6A0/2Delb4kF/huRa2uI=;
 b=UNR6l25HqBI4/Rp3B4L7qPdXHuIeOlvSOu71iq7u3iTOY8JHYuixW1kla98eQzy+
 aPqEq4KED6iBexp26XvwVEdCyo2tdaZKGlBnpJlN5E954mAR3cBKjE7scX6dETzUfF4
 frkMygC2+Zh0fwcqwhiocCQLdjJEGofC0VPO1T5k=
Received: by mx.zohomail.com with SMTPS id 1736873231520531.1253013619033;
 Tue, 14 Jan 2025 08:47:11 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 15 Jan 2025 00:46:38 +0800
Subject: [PATCH 2/5] riscv: dts: canaan: Add basic device tree for K230
 CanMV board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-k230-dev-1-v1-2-f4b77259e34a@pigmoral.tech>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
In-Reply-To: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=8619;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=HMi7Hrm1PT5YqifY6Qhj9Mssqnqe6Ov/oEvaO6OphAY=;
 b=QioZI8qXpnwJxzkJTtAqXTPxcWpyYjeyV3BLIH7h4jeQcRM0grGKjNGD9Xm73h1eSw/MvTu9E
 n0uzZVw/q8CAdrxdByYmVwVlRsmJ8Mt+GyP9kC+Tlz6IBgIXJGbySjY
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

Add initial dts for K230-CanMV powered by Canaan Kendryte K230 SoC,
which has two RISC-V C908 cores, a big core with vector 1.0 extension
and a small core without vector extension.

This patch is basically comes from Linux Kernel [1] and it assumes
u-boot is running on the big core. Additionally, bootctl and reboot nodes
are added to support sysreset [2] and an clk_dummy node is added to
satisfy dependencies for usb [3].

Currently, u-boot is booted by the vendor's u-boot-spl. To meet the
requirements [4][5] of vendor's u-boot-spl for u-boot, a binman node with
mkimage child node is added here, which will compress u-boot.bin with
gzip and generate an image named "uboot" in the file u-boot-gz.img.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=k230-basic
[2] https://github.com/kendryte/k230_sdk/blob/v1.8/src/big/rt-smart/kernel/bsp/maix3/board/interdrv/sysctl/sysctl_boot/sysctl_boot.c#L67
[3] https://lore.kernel.org/linux-riscv/tencent_AD84B436C2F31108B66B4739D6E306C5E80A@qq.com/
[4] https://github.com/kendryte/k230_sdk/blob/v1.8/src/little/uboot/board/canaan/common/k230_img.c#L306
[5] https://github.com/kendryte/k230_sdk/blob/v1.8/src/little/uboot/board/canaan/common/k230_img.c#L125

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/dts/Makefile         |   1 +
 arch/riscv/dts/k230-canmv.dts   |  31 +++++++
 arch/riscv/dts/k230-u-boot.dtsi |  25 ++++++
 arch/riscv/dts/k230.dtsi        | 175 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index b64fc0daf3cb8223737561c3c2221aeff687b45f..cf1872f3fdc397e6c1ccf533ebfea8421dd967d1 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,6 +2,7 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
+dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
diff --git a/arch/riscv/dts/k230-canmv.dts b/arch/riscv/dts/k230-canmv.dts
new file mode 100644
index 0000000000000000000000000000000000000000..ced9c457cc24b35343c1d51569bc7d947840b5fa
--- /dev/null
+++ b/arch/riscv/dts/k230-canmv.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+/dts-v1/;
+#include "k230.dtsi"
+
+/ {
+	model = "Canaan CanMV-K230";
+	compatible = "canaan,canmv-k230", "canaan,kendryte-k230";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* onboard RTL8152 */
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/k230-u-boot.dtsi b/arch/riscv/dts/k230-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..bb66ad3c153df8655b4540760d95b4bc708c0036
--- /dev/null
+++ b/arch/riscv/dts/k230-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <linux/stringify.h>
+
+/ {
+	binman: binman {
+	};
+};
+
+&binman {
+	mkimage {
+		filename = "u-boot-gz.img";
+		args = "-A", "riscv", "-T", "firmware", "-O", "u-boot",
+			"-C", "gzip", "-n", "uboot",
+			"-a", __stringify(CONFIG_TEXT_BASE),
+			"-e", __stringify(CONFIG_TEXT_BASE);
+		blob {
+			filename = "u-boot.bin";
+			compress = "gzip";
+		};
+	};
+};
diff --git a/arch/riscv/dts/k230.dtsi b/arch/riscv/dts/k230.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..cf596677de18a4d984d5f5f973dca61a86fe66cb
--- /dev/null
+++ b/arch/riscv/dts/k230.dtsi
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "canaan,kendryte-k230";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <27000000>;
+
+		cpu@0 {
+			compatible = "thead,c908", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zfh_zba_zbb_zbc_zbs_zvfh_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicsr", "zifencei",
+					       "zihpm", "zfh", "zba", "zbb", "zbc", "zbs", "zvfh",
+					       "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	apb_clk: apb-clk-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+		clock-output-names = "apb_clk";
+		#clock-cells = <0>;
+	};
+
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+		#clock-cells = <0>;
+	};
+
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&bootctl>;
+		offset = <0x60>;
+		mask = <0x10001>;
+		value = <0x10001>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+		ranges;
+
+		bootctl: syscon@0x91102000 {
+			compatible = "syscon";
+			reg = <0x0 0x91102000 0x0 0x1000>;
+		};
+
+		plic: interrupt-controller@f00000000 {
+			compatible = "canaan,k230-plic" ,"thead,c900-plic";
+			reg = <0xf 0x00000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <208>;
+		};
+
+		clint: timer@f04000000 {
+			compatible = "canaan,k230-clint", "thead,c900-clint";
+			reg = <0xf 0x04000000 0x0 0x00010000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		uart0: serial@91400000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91400000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@91401000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91401000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart2: serial@91402000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91402000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart3: serial@91403000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91403000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart4: serial@91404000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91404000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		usb0: usb@91500000 {
+			compatible = "canaan,k230-otg", "snps,dwc2";
+			reg = <0x0 0x91500000 0x0 0x40000>;
+			interrupts = <173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_dummy>;
+			clock-names = "otg";
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <64>;
+			g-tx-fifo-size = <512 1024 64 64 64 64>;
+			status = "disabled";
+		};
+
+		usb1: usb@91540000 {
+			compatible = "canaan,k230-otg", "snps,dwc2";
+			reg = <0x0 0x91540000 0x0 0x40000>;
+			interrupts = <174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_dummy>;
+			clock-names = "otg";
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <64>;
+			g-tx-fifo-size = <512 1024 64 64 64 64>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.47.1

