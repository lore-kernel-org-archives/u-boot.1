Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45707C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 16:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D06587E3C;
	Sat, 27 Jan 2024 17:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C0287EA9; Sat, 27 Jan 2024 17:07:54 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82C987E36
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 17:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Sat, 27 Jan 2024 16:07:37 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v3 1/3] riscv: dts: sophgo: add basic device tree for
 Milk-V Duo board
Message-ID: <20240127160737.GA2281748@ofsar>
References: <20240121150630.30588-1-seashell11234455@gmail.com>
 <20240121150630.30588-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121150630.30588-2-seashell11234455@gmail.com>
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

Hi Kongyang:

On 23:05 Sun 21 Jan     , Kongyang Liu wrote:
> Import device tree from Linux kernel to add basic support for CPU, PLIC,
> UART and Timer. The name cv1800b in the filename represent the chip used
> on Milk-V Duo board.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> 
> ---
> 
> Changes in v3:
> - Swap patch 1 and 2 duo to dependency of defconfig and device tree
> 
>  arch/riscv/dts/Makefile              |   1 +
>  arch/riscv/dts/cv1800b-milkv-duo.dts |  38 +++++++++
>  arch/riscv/dts/cv1800b.dtsi          | 123 +++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
>  create mode 100644 arch/riscv/dts/cv1800b.dtsi

since these dts files are took from kernel tree,
it'd be wise to keep them sync.. please take a look at
(should be easy for us to add more SoCs support later)

https://lore.kernel.org/all/IA1PR20MB4953C128FDDE7A2249669213BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/

> 
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index b05bb5607f..17cda483e1 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -2,6 +2,7 @@
>  
>  dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
>  dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
> +dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
>  dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
>  dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
>  dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
> diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
> new file mode 100644
> index 0000000000..3af9e34b3b
> --- /dev/null
> +++ b/arch/riscv/dts/cv1800b-milkv-duo.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "cv1800b.dtsi"
> +
> +/ {
> +	model = "Milk-V Duo";
> +	compatible = "milkv,duo", "sophgo,cv1800b";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x3f40000>;
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
> new file mode 100644
> index 0000000000..df40e87ee0
> --- /dev/null
> +++ b/arch/riscv/dts/cv1800b.dtsi
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "sophgo,cv1800b";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <25000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c906", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <512>;
> +			d-cache-size = <65536>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		clock-output-names = "osc_25m";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@4140000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04140000 0x100>;
> +			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@4150000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04150000 0x100>;
> +			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@4160000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04160000 0x100>;
> +			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@4170000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04170000 0x100>;
> +			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@41c0000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x041c0000 0x100>;
> +			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@70000000 {
> +			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> +			reg = <0x70000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <101>;
> +		};
> +
> +		clint: timer@74000000 {
> +			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> +			reg = <0x74000000 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +	};
> +};
> -- 
> 2.41.0

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
