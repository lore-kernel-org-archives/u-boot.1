Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306BC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556DE88223;
	Sun, 19 May 2024 20:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nkIV1cXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8628817B; Sun, 19 May 2024 20:20:56 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16C688124
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 20:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59e4136010so682964266b.3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716142854; x=1716747654; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KbidWiRn7NmTELf5Br7/pZrjD700XfRLVEB4ZsIjp0s=;
 b=nkIV1cXo6VGem3uo0wMnT4VdjgT5nqQckMNjcteja7cmi0qr200BgbWylf9h5mvtk+
 fx6OtYrA0xYtO1xNcpbss8YgadEq+MuTVNLaMX4kFYR3bPfpK0vc+1PUHH1SYTiImC8A
 s8lqS/QAH+Sc3F+9/0pBEby8fA9JP9DUhyooUKqbxV5/4kdovGIkBtvgifYpGNpAxX9Y
 oqclli5MXBBoRufN4ytjDGy3LNBN0iHb4L4MW+8I20eQSOUZ5IBxXTMq+Den+wyHYlud
 ka5iVB6t5YvweZySxF+rnpPp2qzINCWwMGUvfUCxhGPV9ClMTL6FRSWP6EfxxWrZRDq9
 FaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716142854; x=1716747654;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbidWiRn7NmTELf5Br7/pZrjD700XfRLVEB4ZsIjp0s=;
 b=sg/2Arrm3+oEbUfmbk96FVcPeMngVysF0OTPeJ6xKIoTnB8//+9vxNxQe1IuOud/iS
 WozndgJ9pmViNIKxziCbqVSb/sMwLo2VoztuR5APxL7Y88uRpEEunRR1ojbcVSw1zFxx
 +3n5WKNkV9BSwIML5mjE3EQoO/tPBqw4fcWyWcpDy5sk5SedksZJIUlB5IilN9wUJIug
 sYzlsB9hTPj2HbK8FZQu5cTRvnMZcm7NT2bo0Hjo4n0WdI3ksVbHOFRhO/4V38RS8bHL
 lz5d331UugsuzEhAGRBt4TdHqf+7kKQi7Ccex99azaSiiFr1sWDX+lXPCDj1DPtl35gm
 v6aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRxfVYY7+pDhh2nETpmeN3aaEw3ob6BwkvS5wjpqNevNsMd9uoRaa2xLU8eAvZbRf7iSQeSGs7RfSxpN/NCsMRbzrE9Q==
X-Gm-Message-State: AOJu0YycZ7vWA0vXG7oc818yDCzc2fBAiqzanTXIfMBaTGc6kgMzHnbN
 U/z1uvLrKST7ElJxxqLTAmx/h5YHeAMay2pdXBeIcIAwgc/Xb/Qp
X-Google-Smtp-Source: AGHT+IFeIwZEPtYMa5sH5O9ij3hbl4IDZVoU/YegPcaF6MWmqtoI0JXrvsWf5Acs1bN7i1sR6r7hEA==
X-Received: by 2002:a17:907:b001:b0:a5c:e9e4:99b8 with SMTP id
 a640c23a62f3a-a5ce9e49be7mr562145266b.74.1716142853919; 
 Sun, 19 May 2024 11:20:53 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d87sm1372536566b.104.2024.05.19.11.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 11:20:53 -0700 (PDT)
Message-ID: <05c8e427-0bb3-489f-915c-d6a7e743f63c@gmail.com>
Date: Sun, 19 May 2024 20:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] MIPS: boston: Migrate to OF_UPSTREAM
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-11-1ea7d23f4a1d@flygoat.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20240517-boston-v3-11-1ea7d23f4a1d@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> We can now boot with upstream devicetree.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/Kconfig                |   1 +
>   arch/mips/dts/Makefile           |   1 -
>   arch/mips/dts/boston-u-boot.dtsi |  10 ++
>   arch/mips/dts/img,boston.dts     | 222 ---------------------------------------
>   board/imgtec/boston/MAINTAINERS  |   1 +
>   configs/boston32r2_defconfig     |   2 +-
>   configs/boston32r2el_defconfig   |   2 +-
>   configs/boston32r6_defconfig     |   2 +-
>   configs/boston32r6el_defconfig   |   2 +-
>   configs/boston64r2_defconfig     |   2 +-
>   configs/boston64r2el_defconfig   |   2 +-
>   configs/boston64r6_defconfig     |   2 +-
>   configs/boston64r6el_defconfig   |   2 +-
>   13 files changed, 20 insertions(+), 231 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 748b5175b2eb..733a8de4fb83 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -146,6 +146,7 @@ config TARGET_BOSTON
>   	select SUPPORTS_CPU_MIPS64_R2
>   	select SUPPORTS_CPU_MIPS64_R6
>   	select SUPPORTS_LITTLE_ENDIAN
> +	imply OF_UPSTREAM

should be 'select' because the switch to upstream DTS is permanent and 
it does not make sense for the user to be able to deselect this option

>   	imply BOOTSTD_FULL
>   	imply CLK
>   	imply CLK_BOSTON
> diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
> index 14fbce597b9e..5478dcd8d025 100644
> --- a/arch/mips/dts/Makefile
> +++ b/arch/mips/dts/Makefile
> @@ -3,7 +3,6 @@
>   dtb-$(CONFIG_TARGET_AP121) += ap121.dtb
>   dtb-$(CONFIG_TARGET_AP143) += ap143.dtb
>   dtb-$(CONFIG_TARGET_AP152) += ap152.dtb
> -dtb-$(CONFIG_TARGET_BOSTON) += img,boston.dtb
>   dtb-$(CONFIG_TARGET_MALTA) += mti,malta.dtb
>   dtb-$(CONFIG_TARGET_PIC32MZDASK) += pic32mzda_sk.dtb
>   dtb-$(CONFIG_TARGET_XILFPGA) += nexys4ddr.dtb
> diff --git a/arch/mips/dts/boston-u-boot.dtsi b/arch/mips/dts/boston-u-boot.dtsi
> new file mode 100644
> index 000000000000..1b0c0a289613
> --- /dev/null
> +++ b/arch/mips/dts/boston-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&plat_regs {
> +	compatible = "img,boston-platform-regs", "syscon", "simple-mfd";
> +	bootph-all;
> +};
> +
> +&clk_boston {
> +	bootph-all;
> +};
> diff --git a/arch/mips/dts/img,boston.dts b/arch/mips/dts/img,boston.dts
> deleted file mode 100644
> index c1a73963037d..000000000000
> --- a/arch/mips/dts/img,boston.dts
> +++ /dev/null
> @@ -1,222 +0,0 @@
> -/dts-v1/;
> -
> -#include <dt-bindings/clock/boston-clock.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/mips-gic.h>
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	compatible = "img,boston";
> -
> -	chosen {
> -		stdout-path = &uart0;
> -	};
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpu@0 {
> -			device_type = "cpu";
> -			compatible = "img,mips";
> -			reg = <0>;
> -			clocks = <&clk_boston BOSTON_CLK_CPU>;
> -		};
> -	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x00000000 0x10000000>;
> -	};
> -
> -	gic: interrupt-controller {
> -		compatible = "mti,gic";
> -
> -		interrupt-controller;
> -		#interrupt-cells = <3>;
> -
> -		timer {
> -			compatible = "mti,gic-timer";
> -			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> -			clocks = <&clk_boston BOSTON_CLK_CPU>;
> -		};
> -	};
> -
> -	pci0: pci@10000000 {
> -		status = "disabled";
> -		compatible = "xlnx,axi-pcie-host-1.00.a";
> -		device_type = "pci";
> -		reg = <0x10000000 0x2000000>;
> -
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -
> -		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		ranges = <0x02000000 0 0x40000000
> -			  0x40000000 0 0x40000000>;
> -
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pci0_intc 0>,
> -				<0 0 0 2 &pci0_intc 1>,
> -				<0 0 0 3 &pci0_intc 2>,
> -				<0 0 0 4 &pci0_intc 3>;
> -
> -		pci0_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -	pci1: pci@12000000 {
> -		status = "disabled";
> -		compatible = "xlnx,axi-pcie-host-1.00.a";
> -		device_type = "pci";
> -		reg = <0x12000000 0x2000000>;
> -
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -
> -		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		ranges = <0x02000000 0 0x20000000
> -			  0x20000000 0 0x20000000>;
> -
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pci1_intc 0>,
> -				<0 0 0 2 &pci1_intc 1>,
> -				<0 0 0 3 &pci1_intc 2>,
> -				<0 0 0 4 &pci1_intc 3>;
> -
> -		pci1_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -	pci2: pci@14000000 {
> -		compatible = "xlnx,axi-pcie-host-1.00.a";
> -		device_type = "pci";
> -		reg = <0x14000000 0x2000000>;
> -
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -
> -		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		ranges = <0x02000000 0 0x16000000
> -			  0x16000000 0 0x100000>;
> -
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pci2_intc 0>,
> -				<0 0 0 2 &pci2_intc 1>,
> -				<0 0 0 3 &pci2_intc 2>,
> -				<0 0 0 4 &pci2_intc 3>;
> -
> -		pci2_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -
> -		pci2_root@0,0,0 {
> -			compatible = "pci10ee,7021";
> -			reg = <0x00000000 0 0 0 0>;
> -
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -
> -			eg20t_bridge@1,0,0 {
> -				compatible = "pci8086,8800";
> -				reg = <0x00010000 0 0 0 0>;
> -
> -				#address-cells = <3>;
> -				#size-cells = <2>;
> -				#interrupt-cells = <1>;
> -
> -				eg20t_mac@2,0,1 {
> -					compatible = "pci8086,8802";
> -					reg = <0x00020100 0 0 0 0>;
> -					phy-reset-gpios = <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
> -				};
> -
> -				eg20t_gpio: eg20t_gpio@2,0,2 {
> -					compatible = "pci8086,8803";
> -					reg = <0x00020200 0 0 0 0>;
> -
> -					gpio-controller;
> -					#gpio-cells = <2>;
> -				};
> -
> -				eg20t_i2c@2,12,2 {
> -					compatible = "pci8086,8817";
> -					reg = <0x00026200 0 0 0 0>;
> -
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					rtc@0x68 {
> -						compatible = "st,m41t81s";
> -						reg = <0x68>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
> -	plat_regs: system-controller@17ffd000 {
> -		compatible = "img,boston-platform-regs", "syscon";
> -		reg = <0x17ffd000 0x1000>;
> -		bootph-all;
> -	};
> -
> -	clk_boston: clock {
> -		compatible = "img,boston-clock";
> -		#clock-cells = <1>;
> -		regmap = <&plat_regs>;
> -		bootph-all;
> -	};
> -
> -	reboot: syscon-reboot {
> -		compatible = "syscon-reboot";
> -		regmap = <&plat_regs>;
> -		offset = <0x10>;
> -		mask = <0x10>;
> -	};
> -
> -	uart0: uart@17ffe000 {
> -		compatible = "ns16550a";
> -		reg = <0x17ffe000 0x1000>;
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -
> -		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		clocks = <&clk_boston BOSTON_CLK_SYS>;
> -
> -		bootph-all;
> -	};
> -
> -	lcd: lcd@17fff000 {
> -		compatible = "img,boston-lcd";
> -		reg = <0x17fff000 0x8>;
> -	};
> -
> -	flash@18000000 {
> -		compatible = "cfi-flash";
> -		reg = <0x18000000 0x8000000>;
> -		bank-width = <2>;
> -	};
> -};
> diff --git a/board/imgtec/boston/MAINTAINERS b/board/imgtec/boston/MAINTAINERS
> index 07f6156ffcbe..12e1652858bb 100644
> --- a/board/imgtec/boston/MAINTAINERS
> +++ b/board/imgtec/boston/MAINTAINERS
> @@ -1,6 +1,7 @@
>   BOSTON BOARD
>   M:	Paul Burton <paul.burton@mips.com>
>   S:	Maintained
> +F:  arch/mips/dts/boston-u-boot.dtsi
>   F:	board/imgtec/boston/
>   F:	include/configs/boston.h
>   F:	configs/boston32r2_defconfig
> diff --git a/configs/boston32r2_defconfig b/configs/boston32r2_defconfig
> index 6f0024a6663d..cb5898c3cafa 100644
> --- a/configs/boston32r2_defconfig
> +++ b/configs/boston32r2_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0x88000000
>   CONFIG_ENV_ADDR=0xBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r2el_defconfig b/configs/boston32r2el_defconfig
> index 71926429b051..4c603b69df7b 100644
> --- a/configs/boston32r2el_defconfig
> +++ b/configs/boston32r2el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0x88000000
>   CONFIG_ENV_ADDR=0xBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r6_defconfig b/configs/boston32r6_defconfig
> index 4335d04b39eb..17f7c4364a03 100644
> --- a/configs/boston32r6_defconfig
> +++ b/configs/boston32r6_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0x88000000
>   CONFIG_ENV_ADDR=0xBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r6el_defconfig b/configs/boston32r6el_defconfig
> index b859a4f198ba..e662d167fe3d 100644
> --- a/configs/boston32r6el_defconfig
> +++ b/configs/boston32r6el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0x88000000
>   CONFIG_ENV_ADDR=0xBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r2_defconfig b/configs/boston64r2_defconfig
> index 70354f117169..bf5a3ead3646 100644
> --- a/configs/boston64r2_defconfig
> +++ b/configs/boston64r2_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>   CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r2el_defconfig b/configs/boston64r2el_defconfig
> index eafb8c67ba7a..de22344b5bb6 100644
> --- a/configs/boston64r2el_defconfig
> +++ b/configs/boston64r2el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>   CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r6_defconfig b/configs/boston64r6_defconfig
> index a6c89278512a..bb339cfd5dbe 100644
> --- a/configs/boston64r6_defconfig
> +++ b/configs/boston64r6_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>   CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>   CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r6el_defconfig b/configs/boston64r6el_defconfig
> index 6cc227600df1..260f6dfb3583 100644
> --- a/configs/boston64r6el_defconfig
> +++ b/configs/boston64r6el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>   CONFIG_SYS_MALLOC_F_LEN=0x400
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>   CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>   CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>   CONFIG_TARGET_BOSTON=y
> 

-- 
- Daniel
