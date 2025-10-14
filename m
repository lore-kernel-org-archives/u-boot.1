Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F2CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 08:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA718807C0;
	Tue, 14 Oct 2025 10:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N7C2FAPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E8882B20; Tue, 14 Oct 2025 10:55:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F3980422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cm7N71by7z9smr;
 Tue, 14 Oct 2025 10:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760432135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JhUmJDkOAn3TrR7lq5cXmxevGLhcQx/f5NLlxSpfac=;
 b=N7C2FAPNFdSLC+0jBuAR+y92AP89qmdxySDsFv516E15bZB92P8uRmNUe5GRg3tbSIwG93
 5p3YQfHTWNkWwJncWE3QBxCk3k0CS6eVJJ6Z2xbzoQC8VOtkwx6yu1lNpJCGAY0ue2Q9XO
 E/54Q84G1+kAO58UxxxCXz/IZo+MUMFJ1vZ4B/rQlqMtSsHejvmekpu/Gl7OEELSO6Y6iw
 F9sZJJXPSt3ORylQ5ioCMvIqdm8K3jNe2seTVT3l0lbjALr6PqO9f9LIitgs3WH+kMCXYf
 ypf/jxhS4OlqiXd3mt/QpBCZh8G+3/wYO8gsGqXcZSDZgEmyihhh4flsEiqfBA==
Message-ID: <59bb4ca5-04f4-4fb5-9430-ed0ef22c5c31@mailbox.org>
Date: Tue, 14 Oct 2025 10:55:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: dts: pxa1908: convert to OF_UPSTREAM
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 David Wronek <david@mainlining.org>, u-boot@lists.denx.de
References: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jgusqhzhdwjrq8w7c1c9dgfhke54xz8h
X-MBO-RS-ID: 87f53396d0d5eae1098
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

On 8/16/25 21:35, Duje Mihanović wrote:
> Convert the PXA1908 platform and its coreprimevelte board to OF_UPSTREAM
> and enable the few drivers found in the upstream DTS.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> Important note: The PXA1908 DTs were merged into Linux during the v6.17
> merge window. Thus, it depends on the v6.17-rc1-dts subtree tag being
> merged. I'm sending this now just so that any eventual feedback can be
> addressed in time for the v6.17 release.
> ---
>   arch/arm/Kconfig                                   |   1 +
>   .../dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi |  20 ++++
>   arch/arm/dts/pxa1908-samsung-coreprimevelte.dts    |  74 --------------
>   arch/arm/dts/pxa1908.dtsi                          | 106 ---------------------
>   configs/coreprimevelte_defconfig                   |   7 +-
>   5 files changed, 27 insertions(+), 181 deletions(-)

Applied to u-boot-marvell/master

Thanks,
Stefan

> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 40368abc297ec4748b3b3731e485dca3b53b8897..2a3ff2108c1d2255c47604d21783e6548773e68f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -882,6 +882,7 @@ config ARCH_MMP
>   	select OF_CONTROL
>   	select SAVE_PREV_BL_FDT_ADDR
>   	select SAVE_PREV_BL_INITRAMFS_START_ADDR
> +	imply OF_UPSTREAM
>   
>   config ARCH_LPC32XX
>   	bool "NXP LPC32xx platform"
> diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi b/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..2e5ec5c597d426e6394a0203eeda68939ca726f5
> --- /dev/null
> +++ b/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
> + */
> +
> +/ {
> +	pxa,rev-id = <3928 0>, <3928 1>, <3928 2>;
> +
> +	memory@0 {
> +		reg = <0 0x1000000 0 0x3f000000>;
> +	};
> +};
> +
> +&uart0 {
> +	clock-frequency = <14745600>;
> +};
> +
> +&pmx {
> +	compatible = "marvell,pxa1908-padconf", "pinctrl-single";
> +};
> diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
> deleted file mode 100644
> index 588e39e92650f9217e02bb332dcdcd5f74cc7fce..0000000000000000000000000000000000000000
> --- a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -#include "pxa1908.dtsi"
> -
> -/ {
> -	pxa,rev-id = <3928 2>;
> -	model = "Samsung Galaxy Core Prime VE LTE";
> -	compatible = "samsung,coreprimevelte", "marvell,pxa1908";
> -
> -	aliases {
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		stdout-path = "serial0:115200n8";
> -
> -		/* S-Boot places the initramfs here */
> -		linux,initrd-start = <0x4d70000>;
> -		linux,initrd-end = <0x5000000>;
> -
> -		fb0: framebuffer@17177000 {
> -			compatible = "simple-framebuffer";
> -			reg = <0 0x17177000 0 (480 * 800 * 4)>;
> -			width = <480>;
> -			height = <800>;
> -			stride = <(480 * 4)>;
> -			format = "a8r8g8b8";
> -		};
> -	};
> -
> -	memory {
> -		device_type = "memory";
> -		reg = <0 0x1000000 0 0x3f000000>;
> -	};
> -
> -	reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		framebuffer@17000000 {
> -			reg = <0 0x17000000 0 0x1800000>;
> -			no-map;
> -		};
> -
> -		gpu@9000000 {
> -			reg = <0 0x9000000 0 0x1000000>;
> -		};
> -
> -		/* Communications processor, aka modem */
> -		cp@5000000 {
> -			reg = <0 0x5000000 0 0x3000000>;
> -		};
> -
> -		cm3@a000000 {
> -			reg = <0 0xa000000 0 0x80000>;
> -		};
> -
> -		seclog@8000000 {
> -			reg = <0 0x8000000 0 0x100000>;
> -		};
> -
> -		ramoops@8100000 {
> -			compatible = "ramoops";
> -			reg = <0 0x8100000 0 0x40000>;
> -			record-size = <0x8000>;
> -			console-size = <0x20000>;
> -			max-reason = <5>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/pxa1908.dtsi b/arch/arm/dts/pxa1908.dtsi
> deleted file mode 100644
> index e8ec2606c2515ee2031004ab3102fec37b7d4b87..0000000000000000000000000000000000000000
> --- a/arch/arm/dts/pxa1908.dtsi
> +++ /dev/null
> @@ -1,106 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/dts-v1/;
> -
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -
> -/ {
> -	model = "Marvell Armada PXA1908";
> -	compatible = "marvell,pxa1908";
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -	interrupt-parent = <&gic>;
> -
> -	cpus {
> -		#address-cells = <2>;
> -		#size-cells = <0>;
> -
> -		cpu0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0 0>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu1: cpu@1 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0 1>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu2: cpu@2 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0 2>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu3: cpu@3 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0 3>;
> -			enable-method = "psci";
> -		};
> -	};
> -
> -	psci {
> -		compatible = "arm,psci-0.2";
> -		method = "smc";
> -	};
> -
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> -	};
> -
> -	soc {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		gic: interrupt-controller@d1df9000 {
> -			compatible = "arm,gic-400";
> -			reg = <0 0xd1df9000 0 0x1000>,
> -				<0 0xd1dfa000 0 0x2000>,
> -				/* The subsequent registers are guesses. */
> -				<0 0xd1dfc000 0 0x2000>,
> -				<0 0xd1dfe000 0 0x2000>;
> -			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> -			interrupt-controller;
> -			#interrupt-cells = <3>;
> -		};
> -
> -		apb@d4000000 {
> -			compatible = "simple-bus";
> -			reg = <0 0xd4000000 0 0x200000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0 0xd4000000 0x200000>;
> -
> -			uart0: serial@17000 {
> -				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
> -				reg = <0x17000 0x1000>;
> -				clock-frequency = <14745600>;
> -				reg-shift = <2>;
> -			};
> -
> -			uart1: serial@18000 {
> -				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
> -				reg = <0x18000 0x1000>;
> -				clock-frequency = <14745600>;
> -				reg-shift = <2>;
> -			};
> -
> -			uart2: serial@36000 {
> -				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
> -				reg = <0x36000 0x1000>;
> -				clock-frequency = <117000000>;
> -				reg-shift = <2>;
> -			};
> -		};
> -	};
> -};
> diff --git a/configs/coreprimevelte_defconfig b/configs/coreprimevelte_defconfig
> index 05116669200b3f1393518c8f9d1d0d5b9f90db6f..c4cd9d2dc01e49d4f02c3e8f6ccfdcfe18909915 100644
> --- a/configs/coreprimevelte_defconfig
> +++ b/configs/coreprimevelte_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_CPU_INIT=y
>   CONFIG_ARCH_MMP=y
>   CONFIG_TEXT_BASE=0x1000000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_DEFAULT_DEVICE_TREE="pxa1908-samsung-coreprimevelte"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/mmp/pxa1908-samsung-coreprimevelte"
>   CONFIG_TARGET_COREPRIMEVELTE=y
>   CONFIG_SYS_LOAD_ADDR=0x1000000
>   CONFIG_ARMV8_PSCI=y
> @@ -14,5 +14,10 @@ CONFIG_FIT=y
>   CONFIG_HUSH_PARSER=y
>   CONFIG_CMD_DM=y
>   CONFIG_OF_BOARD=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_SINGLE=y
>   CONFIG_SYS_NS16550=y
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_SIMPLE=y
> 
> ---
> base-commit: a80bfe1a849a5f2b63c55057fd4f77db89a19fe6
> change-id: 20250816-pxa1908-upstream-5963cfe7cb15
> 
> Best regards,

