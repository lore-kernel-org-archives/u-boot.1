Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8433BC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 08:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3588648F;
	Tue, 29 Aug 2023 10:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693298694;
	bh=SEs2Pv+aPcGBzv05H/uGn9ssLqW5Ovh2rOOwQ1s4nww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCt4Mr94M6TLr3T0PszoK1Fjk+eSzZZhTBTZOi1YD2ghg5UsxXu2CMTMX9yNgJiWg
	 8iGmQVT/8rONlsjKZau9cq8p9nEtnuQGXNmoTae180blYlcbX1c5WJsXJJ2g4210Bu
	 UmSevq49WGRIWVnG1dGJZ9OVcGPftvpM6+jb7BMAhByMLAU2aoymAp9Glv9TX71yfN
	 sKHut8cjknoIFDiFRYIQ+WRUVAzRqKl5VUOcH7tdaPGtWmt9/F0say1KQkAqTiHBDt
	 FDm/a6Ozv73S8CRqZ8sVVprirni+SduJ6gwobLHMxWqb5ToE6+37cku2Xt/WRJN80z
	 UbtSEKYvNCFIQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A52864CE; Tue, 29 Aug 2023 10:44:53 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736298647D
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 10:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4RZgwH5CmGz9sM1;
 Tue, 29 Aug 2023 10:44:47 +0200 (CEST)
Message-ID: <65ab8aa6-c290-0649-0b2e-374c4f84e1df@denx.de>
Date: Tue, 29 Aug 2023 10:44:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Add support for ZyXEL NSA325 board
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20230826033330.7827-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230826033330.7827-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/26/23 05:33, Tony Dinh wrote:
> ZyXEL NSA325 specifications:
> 
> Marvell Kirkwood 88F6282 SoC
> 1.6 GHz CPU
> 1x GBE LAN port (Marvell MV88E1318)
> 512 MB RAM
> 128 MB Eon NAND, SLC
> I2C
> 1x USB 3.0 (on PCIe bus)
> 2x USB 2.0
> 2x SATA (hot swap slots)
> Serial console
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
>   arch/arm/dts/Makefile                    |   1 +
>   arch/arm/dts/kirkwood-6282.dtsi          | 161 ++++++++++++++++
>   arch/arm/dts/kirkwood-nsa325.dts         | 231 +++++++++++++++++++++++
>   arch/arm/dts/kirkwood-nsa3x0-common.dtsi | 157 +++++++++++++++

Just checking: Are the DT files imported from the Linux ones?

Other than this:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan


>   arch/arm/mach-kirkwood/Kconfig           |   7 +
>   board/zyxel/nsa325/Kconfig               |  12 ++
>   board/zyxel/nsa325/MAINTAINERS           |   9 +
>   board/zyxel/nsa325/Makefile              |  11 ++
>   board/zyxel/nsa325/kwbimage.cfg          |  55 ++++++
>   board/zyxel/nsa325/nsa325.c              | 196 +++++++++++++++++++
>   configs/nsa325_defconfig                 |  81 ++++++++
>   include/configs/nsa325.h                 |  37 ++++
>   12 files changed, 958 insertions(+)
>   create mode 100644 arch/arm/dts/kirkwood-6282.dtsi
>   create mode 100644 arch/arm/dts/kirkwood-nsa325.dts
>   create mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
>   create mode 100644 board/zyxel/nsa325/Kconfig
>   create mode 100644 board/zyxel/nsa325/MAINTAINERS
>   create mode 100644 board/zyxel/nsa325/Makefile
>   create mode 100644 board/zyxel/nsa325/kwbimage.cfg
>   create mode 100644 board/zyxel/nsa325/nsa325.c
>   create mode 100644 configs/nsa325_defconfig
>   create mode 100644 include/configs/nsa325.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157..b9fc46544f 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += \
>   	kirkwood-ns2max.dtb \
>   	kirkwood-ns2mini.dtb \
>   	kirkwood-nsa310s.dtb \
> +	kirkwood-nsa325.dtb \
>   	kirkwood-openrd-base.dtb \
>   	kirkwood-openrd-client.dtb \
>   	kirkwood-openrd-ultimate.dtb \
> diff --git a/arch/arm/dts/kirkwood-6282.dtsi b/arch/arm/dts/kirkwood-6282.dtsi
> new file mode 100644
> index 0000000000..e732c501ea
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-6282.dtsi
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/ {
> +	mbus@f1000000 {
> +		pciec: pcie@82000000 {
> +			compatible = "marvell,kirkwood-pcie";
> +			status = "disabled";
> +			device_type = "pci";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			bus-range = <0x00 0xff>;
> +
> +			ranges =
> +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> +				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000
> +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
> +				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> +				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */
> +				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0       1 0 /* Port 1.0 MEM */
> +				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0       1 0 /* Port 1.0 IO  */>;
> +
> +			pcie0: pcie@1,0 {
> +				device_type = "pci";
> +				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> +				reg = <0x0800 0 0 0 0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				#interrupt-cells = <1>;
> +				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> +					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				bus-range = <0x00 0xff>;
> +				interrupt-names = "intx", "error";
> +				interrupts = <9>, <44>;
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
> +						<0 0 0 2 &pcie0_intc 1>,
> +						<0 0 0 3 &pcie0_intc 2>,
> +						<0 0 0 4 &pcie0_intc 3>;
> +				marvell,pcie-port = <0>;
> +				marvell,pcie-lane = <0>;
> +				clocks = <&gate_clk 2>;
> +				status = "disabled";
> +
> +				pcie0_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells = <1>;
> +				};
> +			};
> +
> +			pcie1: pcie@2,0 {
> +				device_type = "pci";
> +				assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
> +				reg = <0x1000 0 0 0 0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				#interrupt-cells = <1>;
> +				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> +					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
> +				bus-range = <0x00 0xff>;
> +				interrupt-names = "intx", "error";
> +				interrupts = <10>, <45>;
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
> +						<0 0 0 2 &pcie1_intc 1>,
> +						<0 0 0 3 &pcie1_intc 2>,
> +						<0 0 0 4 &pcie1_intc 3>;
> +				marvell,pcie-port = <1>;
> +				marvell,pcie-lane = <0>;
> +				clocks = <&gate_clk 18>;
> +				status = "disabled";
> +
> +				pcie1_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells = <1>;
> +				};
> +			};
> +		};
> +	};
> +	ocp@f1000000 {
> +
> +		pinctrl: pin-controller@10000 {
> +			compatible = "marvell,88f6282-pinctrl";
> +
> +			pmx_sata0: pmx-sata0 {
> +				marvell,pins = "mpp5", "mpp21", "mpp23";
> +				marvell,function = "sata0";
> +			};
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins = "mpp4", "mpp20", "mpp22";
> +				marvell,function = "sata1";
> +			};
> +
> +			/*
> +			 * Default I2C1 pinctrl setting on mpp36/mpp37,
> +			 * overwrite marvell,pins on board level if required.
> +			 */
> +			pmx_twsi1: pmx-twsi1 {
> +				marvell,pins = "mpp36", "mpp37";
> +				marvell,function = "twsi1";
> +			};
> +
> +			pmx_sdio: pmx-sdio {
> +				marvell,pins = "mpp12", "mpp13", "mpp14",
> +					       "mpp15", "mpp16", "mpp17";
> +				marvell,function = "sdio";
> +			};
> +		};
> +
> +		thermal: thermal@10078 {
> +			compatible = "marvell,kirkwood-thermal";
> +			reg = <0x10078 0x4>;
> +			status = "okay";
> +		};
> +
> +		rtc: rtc@10300 {
> +			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
> +			reg = <0x10300 0x20>;
> +			interrupts = <53>;
> +			clocks = <&gate_clk 7>;
> +		};
> +
> +		i2c1: i2c@11100 {
> +			compatible = "marvell,mv64xxx-i2c";
> +			reg = <0x11100 0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <32>;
> +			clock-frequency = <100000>;
> +			clocks = <&gate_clk 7>;
> +			pinctrl-0 = <&pmx_twsi1>;
> +			pinctrl-names = "default";
> +			status = "disabled";
> +		};
> +
> +		sata: sata@80000 {
> +			compatible = "marvell,orion-sata";
> +			reg = <0x80000 0x5000>;
> +			interrupts = <21>;
> +			clocks = <&gate_clk 14>, <&gate_clk 15>;
> +			clock-names = "0", "1";
> +			phys = <&sata_phy0>, <&sata_phy1>;
> +			phy-names = "port0", "port1";
> +			status = "disabled";
> +		};
> +
> +		sdio: mvsdio@90000 {
> +			compatible = "marvell,orion-sdio";
> +			reg = <0x90000 0x200>;
> +			interrupts = <28>;
> +			clocks = <&gate_clk 4>;
> +			pinctrl-0 = <&pmx_sdio>;
> +			pinctrl-names = "default";
> +			bus-width = <4>;
> +			cap-sdio-irq;
> +			cap-sd-highspeed;
> +			cap-mmc-highspeed;
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/kirkwood-nsa325.dts b/arch/arm/dts/kirkwood-nsa325.dts
> new file mode 100644
> index 0000000000..efc57cfa41
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa325.dts
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Device tree file for the Zyxel NSA 325 NAS box.
> + *
> + * Copyright (c) 2015, Hans Ulli Kroll <ulli.kroll@googlemail.com>
> + *
> + *
> + * Based upon the board setup file created by Peter Schildmann
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood-nsa3x0-common.dtsi"
> +
> +/ {
> +	model = "ZyXEL NSA325";
> +	compatible = "zyxel,nsa325", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +		stdout-path = &uart0;
> +	};
> +
> +	ocp@f1000000 {
> +		pinctrl: pin-controller@10000 {
> +			pinctrl-names = "default";
> +
> +			pmx_led_hdd2_green: pmx-led-hdd2-green {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd2_red: pmx-led-hdd2-red {
> +				marvell,pins = "mpp13";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_data: pmx-mcu-data {
> +				marvell,pins = "mpp14";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_usb_green: pmx-led-usb-green {
> +				marvell,pins = "mpp15";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_clk: pmx-mcu-clk {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_act: pmx-mcu-act {
> +				marvell,pins = "mpp17";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_green: pmx-led-sys-green {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_orange: pmx-led-sys-orange {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd1_green: pmx-led-hdd1-green {
> +				marvell,pins = "mpp41";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd1_red: pmx-led-hdd1-red {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_htp: pmx-htp {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +
> +			/*
> +			 * Buzzer needs to be switched at around 1kHz so is
> +			 * not compatible with the gpio-beeper driver.
> +			 */
> +			pmx_buzzer: pmx-buzzer {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_vid_b1: pmx-vid-b1 {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_resume_data: pmx-power-resume-data {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_resume_clk: pmx-power-resume-clk {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_pwr_sata1: pmx-pwr-sata1 {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		/* This board uses the pcf8563 RTC instead of the SoC RTC */
> +		rtc@10300 {
> +			status = "disabled";
> +		};
> +
> +		i2c@11000 {
> +			status = "okay";
> +
> +			pcf8563: pcf8563@51 {
> +				compatible = "nxp,pcf8563";
> +				reg = <0x51>;
> +			};
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_pwr_sata1>;
> +		pinctrl-names = "default";
> +
> +		usb0_power: regulator@1 {
> +			enable-active-high;
> +		};
> +
> +		sata1_power: regulator@2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "SATA1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			enable-active-high;
> +			gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
> +			     &pmx_led_usb_green
> +			     &pmx_led_sys_green &pmx_led_sys_orange
> +			     &pmx_led_copy_green &pmx_led_copy_red
> +			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> +		pinctrl-names = "default";
> +
> +		green-sys {
> +			label = "nsa325:green:sys";
> +			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> +		};
> +		orange-sys {
> +			label = "nsa325:orange:sys";
> +			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-hdd1 {
> +			label = "nsa325:green:hdd1";
> +			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-hdd1 {
> +			label = "nsa325:red:hdd1";
> +			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-hdd2 {
> +			label = "nsa325:green:hdd2";
> +			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-hdd2 {
> +			label = "nsa325:red:hdd2";
> +			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-usb {
> +			label = "nsa325:green:usb";
> +			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-copy {
> +			label = "nsa325:green:copy";
> +			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-copy {
> +			label = "nsa325:red:copy";
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +	/* The following pins are currently not assigned to a driver,
> +	   some of them should be configured as inputs.
> +	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
> +		     &pmx_htp &pmx_vid_b1
> +		     &pmx_power_resume_data &pmx_power_resume_clk>; */
> +	};
> +
> +};
> +
> +&mdio {
> +	status = "okay";
> +	ethphy0: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port@0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> +&pciec {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> new file mode 100644
> index 0000000000..a21c50d44a
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "ZyXEL NSA310";
> +
> +	ocp@f1000000 {
> +		pinctrl: pin-controller@10000 {
> +
> +			pmx_usb_power: pmx-usb-power {
> +				marvell,pins = "mpp21";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_pwr_off: pmx-pwr-off {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_reset: pmx-btn-reset {
> +				marvell,pins = "mpp36";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_copy: pmx-btn-copy {
> +				marvell,pins = "mpp37";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_power: pmx-btn-power {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_copy_green: pmx-led-copy-green {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_copy_red: pmx-led-copy-red {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		serial@12000 {
> +			status = "okay";
> +		};
> +
> +		sata@80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_pwr_off>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
> +		pinctrl-names = "default";
> +
> +		power {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		};
> +		copy {
> +			label = "Copy Button";
> +			linux,code = <KEY_COPY>;
> +			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +		};
> +		reset {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_usb_power>;
> +		pinctrl-names = "default";
> +
> +		usb0_power: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	chip-delay = <35>;
> +
> +	partition@0 {
> +		label = "uboot";
> +		reg = <0x0000000 0x0100000>;
> +	};
> +	partition@100000 {
> +		label = "uboot_env";
> +		reg = <0x0100000 0x0080000>;
> +	};
> +	partition@180000 {
> +		label = "key_store";
> +		reg = <0x0180000 0x0080000>;
> +	};
> +	partition@200000 {
> +		label = "info";
> +		reg = <0x0200000 0x0080000>;
> +	};
> +	partition@280000 {
> +		label = "etc";
> +		reg = <0x0280000 0x0a00000>;
> +	};
> +	partition@c80000 {
> +		label = "kernel_1";
> +		reg = <0x0c80000 0x0a00000>;
> +	};
> +	partition@1680000 {
> +		label = "rootfs1";
> +		reg = <0x1680000 0x2fc0000>;
> +	};
> +	partition@4640000 {
> +		label = "kernel_2";
> +		reg = <0x4640000 0x0a00000>;
> +	};
> +	partition@5040000 {
> +		label = "rootfs2";
> +		reg = <0x5040000 0x2fc0000>;
> +	};
> +};
> +
> +&pciec {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 54027ccb0e..c2fff84a68 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -133,6 +133,12 @@ config TARGET_NSA310S
>   	select KW88F6192
>   	select KIRKWOOD_COMMON
>   
> +config TARGET_NSA325
> +	bool "ZyXEL NSA325"
> +	select FEROCEON_88FR131
> +	select KW88F6281
> +	select KIRKWOOD_COMMON
> +
>   config TARGET_SBx81LIFKW
>   	bool "Allied Telesis SBx81GS24/SBx81GT40/SBx81XS6/SBx81XS16"
>   	select FEROCEON_88FR131
> @@ -177,6 +183,7 @@ source "board/Seagate/dockstar/Kconfig"
>   source "board/Seagate/goflexhome/Kconfig"
>   source "board/Seagate/nas220/Kconfig"
>   source "board/zyxel/nsa310s/Kconfig"
> +source "board/zyxel/nsa325/Kconfig"
>   source "board/alliedtelesis/SBx81LIFKW/Kconfig"
>   source "board/alliedtelesis/SBx81LIFXCAT/Kconfig"
>   
> diff --git a/board/zyxel/nsa325/Kconfig b/board/zyxel/nsa325/Kconfig
> new file mode 100644
> index 0000000000..1fe5ead76e
> --- /dev/null
> +++ b/board/zyxel/nsa325/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_NSA325
> +
> +config SYS_BOARD
> +	default "nsa325"
> +
> +config SYS_VENDOR
> +	default "zyxel"
> +
> +config SYS_CONFIG_NAME
> +	default "nsa325"
> +
> +endif
> diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAINERS
> new file mode 100644
> index 0000000000..013cb84b99
> --- /dev/null
> +++ b/board/zyxel/nsa325/MAINTAINERS
> @@ -0,0 +1,9 @@
> +NSA325 BOARD
> +M:	Tony Dinh <mibodhi@gmail.com>
> +S:	Maintained
> +F:	arch/arm/dts/kirkwood-6282.dtsi
> +F:	arch/arm/dts/kirkwood-nsa325.dts
> +F:	arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> +F:	board/zyxel/nsa325/
> +F:	include/configs/nsa325.h
> +F:	configs/nsa325_defconfig
> diff --git a/board/zyxel/nsa325/Makefile b/board/zyxel/nsa325/Makefile
> new file mode 100644
> index 0000000000..2887ba2d13
> --- /dev/null
> +++ b/board/zyxel/nsa325/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2015-2023 Tony Dinh <mibodhi@gmail.com>
> +#
> +# Based on
> +# (C) Copyright 2009
> +# Marvell Semiconductor <www.marvell.com>
> +# Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> +#
> +
> +obj-y	:= nsa325.o
> diff --git a/board/zyxel/nsa325/kwbimage.cfg b/board/zyxel/nsa325/kwbimage.cfg
> new file mode 100644
> index 0000000000..a497300873
> --- /dev/null
> +++ b/board/zyxel/nsa325/kwbimage.cfg
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2015-2023 Tony Dinh <mibodhi@gmail.com>
> +#
> +# Extracted from Zyxel GPL source for u-boot-1.1.4_NSA325v2
> +#
> +# Boot Media configurations
> +BOOT_FROM       nand
> +NAND_ECC_MODE   default
> +NAND_PAGE_SIZE  0x0800
> +
> +# SOC registers configuration using bootrom header extension
> +# Maximum KWBIMAGE_MAX_CONFIG configurations allowed
> +
> +# Configure RGMII-0 interface pad voltage to 1.8V
> +DATA 0xFFD100e0 0x1b1b1b9b
> +
> +#Dram initalization
> +DATA 0xFFD01400 0x4301503E      # DDR Configuration register
> +DATA 0xFFD01404 0xB9843000      # DDR Controller Control Low
> +DATA 0xFFD01408 0x33137777      # DDR Timing (Low)
> +DATA 0xFFD0140C 0x16000C55      # DDR Timing (High)
> +DATA 0xFFD01410 0x04000000      # DDR Address Control
> +DATA 0xFFD01414 0x00000000	#  DDR Open Pages Control
> +DATA 0xFFD01418 0x00000000	#  DDR Operation
> +DATA 0xFFD0141C 0x00000672	#  DDR Mode
> +DATA 0xFFD01420 0x00000004	#  DDR Extended Mode
> +DATA 0xFFD01424 0x0000F14F	#  DDR Controller Control High
> +DATA 0xFFD01428 0x000D6720	# DDR3 ODT Read Timing
> +DATA 0xFFD0147C 0x0000B571	# DDR2 ODT Write Timing
> +DATA 0xFFD01504 0x1FFFFFF1      # CS[0]n Size
> +DATA 0xFFD01508 0x20000000      # CS[1]n Base address to 512Mb
> +DATA 0xFFD0150C 0x1FFFFFF4      # CS[1]n Size 512Mb Window enabled for CS1
> +DATA 0xFFD01514 0x00000000      # CS[2]n Size, window disabled
> +DATA 0xFFD0151C 0x00000000      # CS[3]n Size, window disabled
> +DATA 0xFFD01494 0x00120000      #  DDR ODT Control (Low)
> +DATA 0xFFD01498 0x00000000      #  DDR ODT Control (High)
> +DATA 0xFFD0149C 0x0000E803      # CPU ODT Control
> +
> +DATA 0xFFD015D0 0x00000630
> +DATA 0xFFD015D4 0x00000046
> +DATA 0xFFD015D8 0x00000008
> +DATA 0xFFD015DC 0x00000000
> +DATA 0xFFD015E0 0x00000023
> +DATA 0xFFD015E4 0x00203C18
> +DATA 0xFFD01620 0x00384800
> +DATA 0xFFD01480 0x00000001
> +DATA 0xFFD20134 0x66666666
> +DATA 0xFFD20138 0x00066666
> +
> +DATA 0xFFD10100 0x00004000	# stop the watchdog
> +DATA 0xFFD10104 0xFFFFBFFF
> +
> +# End of Header extension
> +DATA 0x0 0x0
> diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
> new file mode 100644
> index 0000000000..f5f63ee5d3
> --- /dev/null
> +++ b/board/zyxel/nsa325/nsa325.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
> + *
> + * Based on
> + * Copyright (C) 2014  Jason Plum <jplum@archlinuxarm.org>
> + *
> + * Based on nsa320.c originall written by
> + * Copyright (C) 2012  Peter Schildmann <linux@schildmann.info>
> + *
> + * Based on guruplug.c originally written by
> + * Siddarth Gore <gores@marvell.com>
> + * (C) Copyright 2009
> + * Marvell Semiconductor <www.marvell.com>
> + */
> +
> +#include <common.h>
> +#include <asm/arch/soc.h>
> +#include <asm/arch/mpp.h>
> +#include <netdev.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <asm/arch/gpio.h>
> +#include <asm/mach-types.h>
> +#include <bootstage.h>
> +#include <command.h>
> +#include <init.h>
> +#include <linux/bitops.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* low GPIO's */
> +#define HDD2_GREEN_LED		BIT(12)
> +#define HDD2_RED_LED		BIT(13)
> +#define USB_GREEN_LED		BIT(15)
> +#define USB_POWER		BIT(21)
> +#define SYS_GREEN_LED		BIT(28)
> +#define SYS_ORANGE_LED		BIT(29)
> +
> +#define PIN_USB_GREEN_LED	15
> +#define PIN_USB_POWER		21
> +
> +#define NSA325_OE_LOW		(~(HDD2_GREEN_LED | HDD2_RED_LED |	\
> +				   USB_GREEN_LED | USB_POWER |		\
> +				   SYS_GREEN_LED | SYS_ORANGE_LED))
> +#define NSA325_VAL_LOW		(SYS_GREEN_LED | USB_POWER)
> +
> +/* high GPIO's */
> +#define COPY_GREEN_LED		BIT(7)
> +#define COPY_RED_LED		BIT(8)
> +#define HDD1_GREEN_LED		BIT(9)
> +#define HDD1_RED_LED		BIT(10)
> +#define HDD2_POWER		BIT(15)
> +#define WATCHDOG_SIGNAL		BIT(14)
> +
> +#define NSA325_OE_HIGH		(~(COPY_GREEN_LED | COPY_RED_LED | \
> +				   HDD1_GREEN_LED | HDD1_RED_LED | HDD2_POWER | WATCHDOG_SIGNAL))
> +#define NSA325_VAL_HIGH		(WATCHDOG_SIGNAL | HDD2_POWER)
> +
> +#define BTN_POWER				46
> +#define BTN_RESET				36
> +#define BTN_COPY				37
> +
> +int board_early_init_f(void)
> +{
> +	/*
> +	 * default gpio configuration
> +	 * There are maximum 64 gpios controlled through 2 sets of registers
> +	 * the below configuration configures mainly initial LED status
> +	 */
> +	mvebu_config_gpio(NSA325_VAL_LOW, NSA325_VAL_HIGH,
> +			  NSA325_OE_LOW, NSA325_OE_HIGH);
> +
> +	/* Multi-Purpose Pins Functionality configuration */
> +	/* (all LEDs & power off active high) */
> +	u32 kwmpp_config[] = {
> +		MPP0_NF_IO2,
> +		MPP1_NF_IO3,
> +		MPP2_NF_IO4,
> +		MPP3_NF_IO5,
> +		MPP4_NF_IO6,
> +		MPP5_NF_IO7,
> +		MPP6_SYSRST_OUTn,
> +		MPP7_GPO,
> +		MPP8_TW_SDA,		/* PCF8563 RTC chip   */
> +		MPP9_TW_SCK,		/* connected to TWSI  */
> +		MPP10_UART0_TXD,
> +		MPP11_UART0_RXD,
> +		MPP12_GPO,		/* HDD2 LED (green)   */
> +		MPP13_GPIO,		/* HDD2 LED (red)     */
> +		MPP14_GPIO,		/* MCU DATA pin (in)  */
> +		MPP15_GPIO,		/* USB LED (green)    */
> +		MPP16_GPIO,		/* MCU CLK pin (out)  */
> +		MPP17_GPIO,		/* MCU ACT pin (out)  */
> +		MPP18_NF_IO0,
> +		MPP19_NF_IO1,
> +		MPP20_GPIO,
> +		MPP21_GPIO,		/* USB power          */
> +		MPP22_GPIO,
> +		MPP23_GPIO,
> +		MPP24_GPIO,
> +		MPP25_GPIO,
> +		MPP26_GPIO,
> +		MPP27_GPIO,
> +		MPP28_GPIO,		/* SYS LED (green)    */
> +		MPP29_GPIO,		/* SYS LED (orange)   */
> +		MPP30_GPIO,
> +		MPP31_GPIO,
> +		MPP32_GPIO,
> +		MPP33_GPIO,
> +		MPP34_GPIO,
> +		MPP35_GPIO,
> +		MPP36_GPIO,		/* reset button       */
> +		MPP37_GPIO,		/* copy button        */
> +		MPP38_GPIO,		/* VID B0             */
> +		MPP39_GPIO,		/* COPY LED (green)   */
> +		MPP40_GPIO,		/* COPY LED (red)     */
> +		MPP41_GPIO,		/* HDD1 LED (green)   */
> +		MPP42_GPIO,		/* HDD1 LED (red)     */
> +		MPP43_GPIO,		/* HTP pin            */
> +		MPP44_GPIO,		/* buzzer             */
> +		MPP45_GPIO,		/* VID B1             */
> +		MPP46_GPIO,		/* power button       */
> +		MPP47_GPIO,		/* HDD2 power         */
> +		MPP48_GPIO,		/* power off          */
> +		0
> +	};
> +	kirkwood_mpp_conf(kwmpp_config, NULL);
> +	return 0;
> +}
> +
> +int board_eth_init(struct bd_info *bis)
> +{
> +	return cpu_eth_init(bis);
> +}
> +
> +int board_init(void)
> +{
> +	/* address of boot parameters */
> +	gd->bd->bi_boot_params = mvebu_sdram_bar(0) + 0x100;
> +
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	/* Do late init to ensure successful enumeration of XHCI devices */
> +	pci_init();
> +	return 0;
> +}
> +
> +#if defined(CONFIG_SHOW_BOOT_PROGRESS)
> +void show_boot_progress(int val)
> +{
> +	struct kwgpio_registers *gpio0 = (struct kwgpio_registers *)MVEBU_GPIO0_BASE;
> +	u32 dout0 = readl(&gpio0->dout);
> +	u32 blen0 = readl(&gpio0->blink_en);
> +
> +	struct kwgpio_registers *gpio1 = (struct kwgpio_registers *)MVEBU_GPIO1_BASE;
> +	u32 dout1 = readl(&gpio1->dout);
> +	u32 blen1 = readl(&gpio1->blink_en);
> +
> +	switch (val) {
> +	case BOOTSTAGE_ID_DECOMP_IMAGE:
> +		writel(blen0 & ~(SYS_GREEN_LED | SYS_ORANGE_LED), &gpio0->blink_en);
> +		writel((dout0 & ~SYS_GREEN_LED) | SYS_ORANGE_LED, &gpio0->dout);
> +		break;
> +	case BOOTSTAGE_ID_RUN_OS:
> +		writel(dout0 & ~SYS_ORANGE_LED, &gpio0->dout);
> +		writel(blen0 | SYS_GREEN_LED, &gpio0->blink_en);
> +		break;
> +	case BOOTSTAGE_ID_NET_START:
> +		writel(dout1 & ~COPY_RED_LED, &gpio1->dout);
> +		writel((blen1 & ~COPY_RED_LED) | COPY_GREEN_LED, &gpio1->blink_en);
> +		break;
> +	case BOOTSTAGE_ID_NET_LOADED:
> +		writel(blen1 & ~(COPY_RED_LED | COPY_GREEN_LED), &gpio1->blink_en);
> +		writel((dout1 & ~COPY_RED_LED) | COPY_GREEN_LED, &gpio1->dout);
> +		break;
> +	case -BOOTSTAGE_ID_NET_NETLOOP_OK:
> +	case -BOOTSTAGE_ID_NET_LOADED:
> +		writel(dout1 & ~COPY_GREEN_LED, &gpio1->dout);
> +		writel((blen1 & ~COPY_GREEN_LED) | COPY_RED_LED, &gpio1->blink_en);
> +		break;
> +	default:
> +		if (val < 0) {
> +			/* error */
> +			printf("Error occurred, error code = %d\n", -val);
> +			writel(dout0 & ~SYS_GREEN_LED, &gpio0->dout);
> +			writel(blen0 | SYS_ORANGE_LED, &gpio0->blink_en);
> +		}
> +		break;
> +	}
> +}
> +#endif /* CONFIG_SHOW_BOOT_PROGRESS */
> diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
> new file mode 100644
> index 0000000000..d5fe9ca099
> --- /dev/null
> +++ b/configs/nsa325_defconfig
> @@ -0,0 +1,81 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_DCACHE_OFF=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
> +CONFIG_ARCH_KIRKWOOD=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_CMDLINE_TAG=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_SYS_KWD_CONFIG="board/zyxel/nsa325/kwbimage.cfg"
> +CONFIG_TEXT_BASE=0x600000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_TARGET_NSA325=y
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_ENV_OFFSET=0xC0000
> +CONFIG_DEFAULT_DEVICE_TREE="kirkwood-nsa325"
> +CONFIG_SYS_PROMPT="NSA325> "
> +CONFIG_IDENT_STRING="\nZyXEL NSA325 2-Bay Power Media Server"
> +CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_PCI=y
> +CONFIG_LTO=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTSTAGE=y
> +CONFIG_SHOW_BOOT_PROGRESS=y
> +CONFIG_BOOTDELAY=10
> +CONFIG_USE_PREBOOT=y
> +CONFIG_BOARD_LATE_INIT=y
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_IMI is not set
> +# CONFIG_CMD_XIMG is not set
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_NAND=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SATA=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_DNS=y
> +# CONFIG_CMD_BLOCK_CACHE is not set
> +CONFIG_CMD_JFFS2=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0x100000(uboot),0x80000(stock_uboot_env),0x80000(key_store),0x80000(info),0xA00000(etc),0xA00000(kernel_1),0x2FC0000(rootfs1),0xA00000(kernel_2),0x2FC0000(rootfs2)"
> +CONFIG_CMD_UBI=y
> +CONFIG_PARTITION_TYPE_GUID=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_NAND=y
> +CONFIG_VERSION_VARIABLE=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_NETCONSOLE=y
> +# CONFIG_DM_WARN is not set
> +CONFIG_SATA_MV=y
> +CONFIG_SYS_SATA_MAX_DEVICE=2
> +CONFIG_LBA48=y
> +CONFIG_SYS_64BIT_LBA=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +# CONFIG_MMC is not set
> +CONFIG_MTD=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_MVGBE=y
> +CONFIG_MII=y
> +CONFIG_PCI_MVEBU=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_PCF8563=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PCI=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_JFFS2_LZO=y
> +CONFIG_JFFS2_NAND=y
> +CONFIG_UBIFS_SILENCE_MSG=y
> diff --git a/include/configs/nsa325.h b/include/configs/nsa325.h
> new file mode 100644
> index 0000000000..00a148c6ae
> --- /dev/null
> +++ b/include/configs/nsa325.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2016-2023 Tony Dinh <mibodhi@gmail.com>
> + * (C) Copyright 2014 Jason Plum <jplum@archlinuxarm.org>
> + *
> + * Based on
> + * Copyright (C) 2012  Peter Schildmann <linux@schildmann.info>
> + *
> + * Based on guruplug.h originally written by
> + * Siddarth Gore <gores@marvell.com>
> + * (C) Copyright 2009
> + * Marvell Semiconductor <www.marvell.com>
> + */
> +
> +#ifndef _CONFIG_NSA325_H
> +#define _CONFIG_NSA325_H
> +
> +#include "mv-common.h"
> +
> +#define KERNEL_ADDR_R	__stringify(0x800000)
> +#define FDT_ADDR_R	__stringify(0x2c00000)
> +#define RAMDISK_ADDR_R	__stringify(0x01100000)
> +#define SCRIPT_ADDR_R	__stringify(0x200000)
> +
> +#define LOAD_ADDRESS_ENV_SETTINGS \
> +	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
> +	"fdt_addr_r=" FDT_ADDR_R "\0" \
> +	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
> +	"scriptaddr=" SCRIPT_ADDR_R "\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	LOAD_ADDRESS_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
> +	"console=ttyS0,115200\0"
> +
> +#endif /* _CONFIG_NSA325_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
