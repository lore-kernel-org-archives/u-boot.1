Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179DAC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CB286456;
	Wed, 23 Aug 2023 22:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bybcTnOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F148786458; Wed, 23 Aug 2023 22:01:49 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C768644E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NK1jFA108605;
 Wed, 23 Aug 2023 15:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692820905;
 bh=bh5+L1iVb97C59yFKR98bcLGoRRfnRQT/Vm98BlEFV8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bybcTnOC0pY38Ez3WsJOHmM32EccjHSDUG3MlM2DtOYWwVgFFgINbrchJt3//xfu+
 Vny5XqeSzqzJvzWcRpO50eHp3o3Exj8R4kEI2uLu9qWgT+JM8YGmIZDfKn44XPzPyV
 WlKxrpcf8QnSuEWb6LS/Idx769oIYyd/KH0wteXc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NK1jHJ078495
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 15:01:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 15:01:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 15:01:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NK1iaS031845;
 Wed, 23 Aug 2023 15:01:44 -0500
Date: Wed, 23 Aug 2023 15:01:44 -0500
From: reidt <reidt@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm: dts: j7200: dtb sync with Linux 6.5-rc1
Message-ID: <20230823200144.asgp3cqmlgdt7fmc@reidt-HP-Z2>
References: <20230822185725.6718-1-reidt@ti.com>
 <20230822213616.dntb3hcxxfesachm@napped>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230822213616.dntb3hcxxfesachm@napped>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:36-20230822, Nishanth Menon wrote:
> On 13:57-20230822, Reid Tonking wrote:
> > Sync j7200 device tree files with Linux 6.5-rc1
> 
> I understand this is a major step forward, but a still:
> 
> There is more work to do:
> a) split the dev-data.c fixup as the first patch
> b) See comments in https://lore.kernel.org/u-boot/20230816114445.c4c7rgdp5arhmiaq@polyester/
> 
> [...]
> 
> > diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > index f25c7136c9..a00e85e366 100644
> > --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
> >   */
> >  
> >  #include "k3-j7200-binman.dtsi"
> > @@ -8,7 +8,7 @@
> >  / {
> >  	chosen {
> >  		stdout-path = "serial2:115200n8";
> 
> Drop this
> 
> > -		tick-timer = &timer1;
> > +		tick-timer = &mcu_timer0;
> >  	};
> >  
> >  	aliases {
> 
> You dont need the aliases - these come in from board.dts
> 
> > @@ -28,16 +28,12 @@
> >  	bootph-pre-ram;
> >  };
> >  
> > -&cbass_mcu_wakeup {
> > +&main_esm{
> 
> space before the {
> 
> >  	bootph-pre-ram;
> > +};
> >  
> > -	timer1: timer@40400000 {
> > -		compatible = "ti,omap5430-timer";
> > -		reg = <0x0 0x40400000 0x0 0x80>;
> > -		ti,timer-alwon;
> > -		clock-frequency = <250000000>;
> > -		bootph-pre-ram;
> > -	};
> > +&cbass_mcu_wakeup {
> > +	bootph-pre-ram;
> >  
> >  	chipid@43000014 {
> >  		bootph-pre-ram;
> 
> };
> End it here.
> 

all the above, done

> > @@ -45,8 +41,6 @@
> >  
> >  	mcu_navss: bus@28380000 {
> 
> 	Dont duplicate the entire node.
> &mcu_navss {
> 	bootph-pre-ram;
> };
> 
> &mcu_ringacc {
> 	bootph-pre-ram;
> };
> NOTE: you only need to override reg-names and reg in R5.dtsi not u-boot.dtsi.
> 
> &mcu_udmap {
> 	bootph-pre-ram;
> };

I saw you mentioned at [0] that mcu_ringacc (and I assume mcu_udmap)
need to be retained for now. If moved to r5.dts, something breaks, as dhcp 
fails then [1]. Should the full nodes remain for now until 6.6-rc1 sync? I'll
still take them outside of mcu_navss.

[0] https://lore.kernel.org/all/20230816114445.c4c7rgdp5arhmiaq@polyester/
[1] https://gist.github.com/Glockn/f0cf1ae8f8fd92e70f4e798c6221e81a

> >  		bootph-pre-ram;
> > -		#address-cells = <2>;
> > -		#size-cells = <2>;
> >  
> >  		ringacc@2b800000 {
> >  			reg =	<0x0 0x2b800000 0x0 0x400000>,
> 	And clean this up.
> >  
> >  &wkup_i2c0 {
> >  	bootph-pre-ram;
> > +
> > +	lp876441: lp876441@4c {
> 
> NAK. Why is this new stuff coming in -> should'nt be here.
> 

This was left because &wkup_vtm0 uses &buck1_reg below which isn't apart
of the kernel dt files.

> > +		bootph-pre-ram;
> > +
> > +		regulators: regulators {
> > +			bootph-pre-ram;
> > +
> > +			buck1_reg: buck1 {
> > +				bootph-pre-ram;
> > +			};
> > +		};
> > +	};
> >  };
> >  
> >  &main_i2c0 {
> >  	bootph-pre-ram;
> > +
> > +	exp1: gpio@20 {
> 
> Again - just do it using the reference
> &exp1 {
> 	bootph-pre-ram;
> };
> 
> And this pattern repeats itself..
> 
> > +		bootph-pre-ram;
> > +	};
> > +
> > +	exp2: gpio@22 {
> 
> This as well.
>

will do

> 
> hbmc -> arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi: flash@0,0 weird
> that does'nt throw a dtbs_check warning
> 
> WARNING: u-boot,mux-autoprobe -> this is'nt supported.
> 

change these to bootph-pre-ram?

> Also &main_r5fss0 -> ti,cluster-mode=<0> -> Drop that.
> 
> There is a bit debate about dr_mode = "peripheral";
> https://lore.kernel.org/u-boot/fc205109-fd3d-ea79-abcc-f1638115d0d3@kernel.org/#r
> 
> Depending on where it ends up...
> 

I'll keep an eye on this

> [...]
> 
> > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > index e62f9218e8..bd4be7215f 100644
> > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> 
> [...]
> 
> > +&mcu_timer0 {
> > +	/delete-property/ power-domains;
> > +	ti,timer-alwon;
> > +	clock-frequency = <25000000>;
> > +	bootph-pre-ram;
> 
> you already caught this - just pre-ram and clock-frequency.
> 
> >  };
> >  
> >  &cbass_mcu_wakeup {
> > -	mcu_secproxy: secproxy@2a380000 {
> > +	secure_proxy_mcu: mailbox@2a480000 {
> 
> Move this out.
> 

done

> >  		bootph-pre-ram;
> > -		compatible = "ti,am654-secure-proxy";
> > -		reg = <0x0 0x2a380000 0x0 0x80000>,
> > -		      <0x0 0x2a400000 0x0 0x80000>,
> > -		      <0x0 0x2a480000 0x0 0x80000>;
> > -		reg-names = "rt", "scfg", "target_data";
> > -		#mbox-cells = <1>;
> > +		status = "okay";
> >  	};
> >  
> >  	sysctrler: sysctrler {
> > -		bootph-pre-ram;
> >  		compatible = "ti,am654-system-controller";
> > -		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
> > +		mboxes= <&secure_proxy_mcu 4>,
> > +			<&secure_proxy_mcu 5>;
> >  		mbox-names = "tx", "rx";
> > +		bootph-pre-ram;
> >  	};
> >  
> >  	dm_tifs: dm-tifs {
> 
> Move this to root similar to am625. it is more or less a hanky stuff we do with this.
>

done

> > @@ -86,250 +66,23 @@
> >  		ti,host-id = <3>;
> >  		ti,secure-host;
> >  		mbox-names = "rx", "tx";
> > -		mboxes= <&mcu_secproxy 21>,
> > -			<&mcu_secproxy 23>;
> > +		mboxes= <&secure_proxy_mcu 21>,
> > +			<&secure_proxy_mcu 23>;
> >  		bootph-pre-ram;
> >  	};
> > -
> > -	wkup_vtm0: vtm@42040000 {
> > -		compatible = "ti,am654-vtm", "ti,j721e-avs";
> > -		reg = <0x0 0x42040000 0x0 0x330>;
> > -		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> > -		#thermal-sensor-cells = <1>;
> > -	};
> >  };
> >  
> >  &dmsc {
> > -	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
> > +	mboxes= <&secure_proxy_mcu 8>,
> > +		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> >  	mbox-names = "tx", "rx", "notify";
> >  	ti,host-id = <4>;
> >  	ti,secure-host;
> > -};
> > -
> > -&wkup_pmx0 {
> > -	bootph-pre-ram;
> > -	wkup_uart0_pins_default: wkup_uart0_pins_default {
> > -		bootph-pre-ram;
> > -		pinctrl-single,pins = <
> > -			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
> > -			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
> > -		>;
> > -	};
> > -
> > -	mcu_uart0_pins_default: mcu_uart0_pins_default {
> > -		bootph-pre-ram;
> > -		pinctrl-single,pins = <
> > -			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) WKUP_GPIO0_13.MCU_UART0_RXD */
> > -			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) WKUP_GPIO0_12.MCU_UART0_TXD */
> > -			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) WKUP_GPIO0_14.MCU_UART0_CTSn */
> > -			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) WKUP_GPIO0_15.MCU_UART0_RTSn */
> > -		>;
> > -	};
> > -
> > -	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
> > -		pinctrl-single,pins = <
> > -			J721E_WKUP_IOPAD(0x100, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
> > -			J721E_WKUP_IOPAD(0x104, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
> > -		>;
> > -	};
> > -
> > -	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
> > -		pinctrl-single,pins = <
> > -			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (E20) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
> > -			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C21) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
> > -			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (F19) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
> > -			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* (E22) MCU_OSPI1_CSn1.MCU_HYPERBUS0_CSn1 */
> > -			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (E19) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
> > -			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (D21) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
> > -			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D20) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
> > -			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (G19) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
> > -			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (G20) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
> > -			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (F20) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
> > -			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (F21) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
> > -			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (E21) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
> > -			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (B22) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
> > -			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (G21) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
> > -		>;
> > -	};
> > -
> > -	wkup_gpio_pins_default: wkup-gpio-pins-default {
> > -		pinctrl-single,pins = <
> > -			J721E_WKUP_IOPAD(0xd8, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
> > -		>;
> > -	};
> > -};
> > -
> > -&main_pmx0 {
> > -	bootph-pre-ram;
> > -
> > -	main_uart0_pins_default: main_uart0_pins_default {
> > -		bootph-pre-ram;
> > -		pinctrl-single,pins = <
> > -			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
> > -			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
> > -			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
> > -			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
> > -		>;
> > -	};
> > -
> > -	main_i2c0_pins_default: main-i2c0-pins-default {
> > -		bootph-pre-ram;
> > -		pinctrl-single,pins = <
> > -			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
> > -			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> > -		>;
> > -	};
> > -
> > -	main_mmc1_pins_default: main_mmc1_pins_default {
> > -		pinctrl-single,pins = <
> > -			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
> > -			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
> > -			J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
> > -			J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
> > -			J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
> > -			J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
> > -			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
> > -			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
> > -		>;
> > -	};
> > -
> > -	main_usbss0_pins_default: main_usbss0_pins_default {
> > -		pinctrl-single,pins = <
> > -			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
> > -		>;
> > -	};
> > -};
> > -
> > -&wkup_uart0 {
> >  	bootph-pre-ram;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&wkup_uart0_pins_default>;
> > -	status = "okay";
> > -};
> > -
> > -&mcu_uart0 {
> > -	/delete-property/ power-domains;
> > -	/delete-property/ clocks;
> > -	/delete-property/ clock-names;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&mcu_uart0_pins_default>;
> > -	status = "okay";
> > -	clock-frequency = <96000000>;
> > -};
> > -
> > -&main_uart0 {
> > -	status = "okay";
> > -	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&main_uart0_pins_default>;
> > -	status = "okay";
> > -};
> > -
> > -&main_sdhci0 {
> > -	/delete-property/ power-domains;
> > -	/delete-property/ assigned-clocks;
> > -	/delete-property/ assigned-clock-parents;
> > -	pinctrl-0 = <&main_mmc1_pins_default>;
> > -	pinctrl-names = "default";
> > -	clock-names = "clk_xin";
> > -	clocks = <&clk_200mhz>;
> > -	ti,driver-strength-ohm = <50>;
> > -	non-removable;
> > -	bus-width = <8>;
> > -};
> > -
> > -&main_sdhci1 {
> > -	/delete-property/ power-domains;
> > -	/delete-property/ assigned-clocks;
> > -	/delete-property/ assigned-clock-parents;
> > -	clock-names = "clk_xin";
> > -	clocks = <&clk_200mhz>;
> > -	ti,driver-strength-ohm = <50>;
> > -};
> > -
> > -&wkup_i2c0 {
> > -	bootph-pre-ram;
> > -	lp876441: lp876441@4c {
> > -		compatible = "ti,lp876441";
> 
> There is no such driver in linux kernel compatible space. might need a
> ticket to implement the driver.
> 

Interesting - I'll look into it. Makes me wonder about the buck1_reg for
wkup_vtm0 and what's going on there.

> > -		reg = <0x4c>;
> > -		bootph-pre-ram;
> > -		pinctrl-names = "default";
> > -		pinctrl-0 = <&wkup_i2c0_pins_default>;
> > -		clock-frequency = <400000>;
> > -
> > -		regulators: regulators {
> > -			bootph-pre-ram;
> > -			buck1_reg: buck1 {
> > -				/*VDD_CPU_AVS_REG*/
> > -				regulator-name = "buck1";
> > -				regulator-min-microvolt = <800000>;
> > -				regulator-max-microvolt = <1250000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				bootph-pre-ram;
> > -			};
> > -		};
> > -	};
> > -
> >  };
> >  
> >  &wkup_vtm0 {
> > +	compatible = "ti,am654-vtm", "ti,j721e-avs";
> 
> &wkup_vtm0 -> there is already stuff coming in from kernel. why
> do we need to define our own compatible "ti,am654-vtm", "ti,j721e-avs"?
> there is already compatible = "ti,j7200-vtm";  if we need to fix the
> driver as part of the series, please do as a path in the series.
> 

ti,j7200-vtm doesn't work and throws a "AVS init failed: -19", so i'll
work on that. The compatible I used was taken from our TI u-boot 

> >  	vdd-supply-2 = <&buck1_reg>;
> 
> Should have been handled in kernel please. Please file an internal
> tracking ticket for this to be handled.

will do

> 
> >  	bootph-pre-ram;
> >  };
> > -
> > -&main_i2c0 {
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&main_i2c0_pins_default>;
> > -	clock-frequency = <400000>;
> > -
> > -	exp1: gpio@20 {
> > -		compatible = "ti,tca6416";
> > -		reg = <0x20>;
> > -		gpio-controller;
> > -		#gpio-cells = <2>;
> > -	};
> > -
> > -	exp2: gpio@22 {
> > -		compatible = "ti,tca6424";
> > -		reg = <0x22>;
> > -		gpio-controller;
> > -		#gpio-cells = <2>;
> > -	};
> > -};
> > -
> > -&usbss0 {
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&main_usbss0_pins_default>;
> > -	ti,vbus-divider;
> > -	ti,usb2-only;
> > -};
> > -
> > -&usb0 {
> > -	dr_mode = "otg";
> > -	maximum-speed = "high-speed";
> > -};
> > -
> > -&hbmc {
> > -	status = "okay";
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
> > -	reg = <0x0 0x47040000 0x0 0x100>,
> > -	      <0x0 0x50000000 0x0 0x8000000>;
> > -	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>, /* 64MB Flash on CS0 */
> > -		 <0x1 0x0 0x0 0x54000000 0x800000>; /* 8MB flash on CS1 */
> > -
> > -	flash@0,0 {
> > -		compatible = "cypress,hyperflash", "cfi-flash";
> > -		reg = <0x0 0x0 0x4000000>;
> > -	};
> > -};
> > -
> > -&mcu_ringacc {
> > -	ti,sci = <&dm_tifs>;
> > -};
> > -
> > -&mcu_udmap {
> > -	ti,sci = <&dm_tifs>;
> > -};
> > -#include "k3-j7200-common-proc-board-u-boot.dtsi"
> 
> https://gist.github.com/nmenon/662262b0256eab004485035a02ede963
> is probably the set of changes I commented about above.
> 

Thanks for the feedback!

> > diff --git a/arch/arm/mach-k3/j7200/dev-data.c b/arch/arm/mach-k3/j7200/dev-data.c
> 
> Split this out as a separate patch.
> 

will do

> > index 4ddc34210e..8ce6796fd0 100644
> > --- a/arch/arm/mach-k3/j7200/dev-data.c
> > +++ b/arch/arm/mach-k3/j7200/dev-data.c
> > @@ -46,6 +46,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
> >  
> >  static struct ti_dev soc_dev_list[] = {
> >  	PSC_DEV(30, &soc_lpsc_list[0]),
> > +	PSC_DEV(35, &soc_lpsc_list[0]),
> >  	PSC_DEV(61, &soc_lpsc_list[1]),
> >  	PSC_DEV(90, &soc_lpsc_list[2]),
> >  	PSC_DEV(8, &soc_lpsc_list[3]),
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
