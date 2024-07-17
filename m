Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE98C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 06:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6613B8841D;
	Wed, 17 Jul 2024 08:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dquZnRRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387D08841D; Wed, 17 Jul 2024 08:48:08 +0200 (CEST)
Received: from mail-m127172.xmail.ntesmail.com
 (mail-m127172.xmail.ntesmail.com [115.236.127.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFEC882EF
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dquZnRRE+qaHOaSSDZHigadphDHA3g/hu0kJXdWJCxfej7glsprbqcSSs33wXfiogaoDUo4pODsSuOhuEhQ+SxZy9oFBYYW/HrpxOkrVrHyNHXREpu1Bx9zP7+ssR36QutTrwj11N0eGZZk4sL6F7iycpad58M1Tb6DU7TgGemE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=PBKRj37i5ZGyv+aJQHHB4Wm+HmhoLcNSCJ3TqXPdq9A=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 74B5A9005EA;
 Wed, 17 Jul 2024 14:47:40 +0800 (CST)
Message-ID: <31e4b960-40e2-4bf6-bab0-503c9b3f2b52@rock-chips.com>
Date: Wed, 17 Jul 2024 14:47:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
From: Kever Yang <kever.yang@rock-chips.com>
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
 <2b4c1c3c-6047-496b-83a0-c968ae8a69ea@rock-chips.com>
Content-Language: en-US
In-Reply-To: <2b4c1c3c-6047-496b-83a0-c968ae8a69ea@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lJSVZMQhlLQxpOThlCHk9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bf725a4d03a9kunm74b5a9005ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6HQw5MTI2OhJNEjgwPBAU
 KysaCktVSlVKTElKSkJDQ01KTkhJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0tJTzcG
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

Hi Quentin,

On 2024/7/16 10:17, Kever Yang wrote:
>
> On 2024/6/20 18:24, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> No meaningful changes were made to this SoM since February 2021. Nobody
>> from Theobroma has booted anything recent on that product since July
>> 2021 at the latest. The product isn't available to buy anymore and
>> disappeared from our website.
>>
>> This product is therefore unmaintained and it would be disingenuous to
>> say the opposite, so drop support for RK3368 Lion.
>>
>> If you're a user of Lion, feel free to revert this patch or contact our
>> sales/support department.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>
> Thanks,
> - Kever
>> ---
>>   arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi     | 119 ---------
>>   arch/arm/dts/rk3368-lion-haikou.dts             | 144 -----------
>>   arch/arm/dts/rk3368-lion.dtsi                   | 318 
>> ------------------------

I think you forgot to remove rk3368-lion-haikou.dtb in Makefile.


Thanks,
- Kever
>> arch/arm/mach-rockchip/rk3368/Kconfig           |  22 --
>>   board/theobroma-systems/lion_rk3368/Kconfig     |  18 --
>>   board/theobroma-systems/lion_rk3368/MAINTAINERS |  10 -
>>   board/theobroma-systems/lion_rk3368/README      |  78 ------
>>   configs/lion-rk3368_defconfig                   | 110 --------
>>   doc/board/rockchip/rockchip.rst                 |   1 -
>>   include/configs/lion_rk3368.h                   |  16 --
>>   10 files changed, 836 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi 
>> b/arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi
>> deleted file mode 100644
>> index a3c2b707e9a..00000000000
>> --- a/arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi
>> +++ /dev/null
>> @@ -1,119 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+ OR X11
>> -/*
>> - * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
>> - */
>> -
>> -#include "rk3368-u-boot.dtsi"
>> -
>> -/ {
>> -    config {
>> -        u-boot,spl-payload-offset = <0x40000>; /* @ 256KB */
>> -        u-boot,mmc-env-offset = <0x4000>;      /* @  16KB */
>> -    };
>> -
>> -    chosen {
>> -        stdout-path = "serial0:115200n8";
>> -        u-boot,spl-boot-order = &emmc, &sdmmc;
>> -    };
>> -
>> -    smbios {
>> -        compatible = "u-boot,sysinfo-smbios";
>> -
>> -        smbios {
>> -            system {
>> -                manufacturer = "rockchip";
>> -                product = "sheep_rk3368";
>> -            };
>> -
>> -            baseboard {
>> -                manufacturer = "rockchip";
>> -                product = "sheep_rk3368";
>> -            };
>> -
>> -            chassis {
>> -                manufacturer = "rockchip";
>> -                product = "sheep_rk3368";
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&gpio2 {
>> -    bootph-all;
>> -};
>> -
>> -&pinctrl {
>> -    bootph-all;
>> -};
>> -
>> -&service_msch {
>> -    bootph-all;
>> -};
>> -
>> -&dmc {
>> -    bootph-all;
>> -
>> -    /*
>> -     * Validation of throughput using SPEC2000 shows the following
>> -     * relative performance for the different memory schedules:
>> -     *  - CBDR: 30.1
>> -     *  - CBRD: 29.8
>> -     *  - CRBD: 29.9
>> -     * Note that the best performance for any given application 
>> workload
>> -     * may vary from the default configured here (e.g. 164.gzip is 
>> fastest
>> -     * with CBRD, whereas 252.eon and 186.crafty are fastest with 
>> CRBD).
>> -     *
>> -     * See doc/device-tree-bindings/clock/rockchip,rk3368-dmc.txt for
>> -     * details on the 'rockchip,memory-schedule' property and how it
>> -     * affects the physical-address to device-address mapping.
>> -     */
>> -    rockchip,memory-schedule = <DMC_MSCH_CBDR>;
>> -    rockchip,ddr-frequency = <800000000>;
>> -    rockchip,ddr-speed-bin = <DDR3_1600K>;
>> -
>> -    status = "okay";
>> -};
>> -
>> -&pmugrf {
>> -    bootph-all;
>> -};
>> -
>> -&sgrf {
>> -    bootph-all;
>> -};
>> -
>> -&cru {
>> -    bootph-all;
>> -};
>> -
>> -&grf {
>> -    bootph-all;
>> -};
>> -
>> -&uart0 {
>> -    bootph-all;
>> -};
>> -
>> -&emmc {
>> -    bootph-pre-ram;
>> -};
>> -
>> -&sdmmc {
>> -    bootph-pre-ram;
>> -};
>> -
>> -&spi1 {
>> -    bootph-pre-ram;
>> -
>> -    spiflash: w25q32dw@0 {
>> -        bootph-pre-ram;
>> -    };
>> -};
>> -
>> -&timer0 {
>> -    bootph-all;
>> -    clock-frequency = <24000000>;
>> -    status = "okay";
>> -};
>> -
>> -
>> diff --git a/arch/arm/dts/rk3368-lion-haikou.dts 
>> b/arch/arm/dts/rk3368-lion-haikou.dts
>> deleted file mode 100644
>> index cae01d35b93..00000000000
>> --- a/arch/arm/dts/rk3368-lion-haikou.dts
>> +++ /dev/null
>> @@ -1,144 +0,0 @@
>> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> -/*
>> - * Copyright (c) 2018 Theobroma Systems Design und Consulting GmbH
>> - */
>> -
>> -/dts-v1/;
>> -#include "rk3368-lion.dtsi"
>> -
>> -/ {
>> -    model = "Theobroma Systems RK3368-uQ7 Baseboard";
>> -    compatible = "tsd,rk3368-lion-haikou", "rockchip,rk3368";
>> -
>> -    aliases {
>> -        mmc1 = &sdmmc;
>> -    };
>> -
>> -    chosen {
>> -        stdout-path = "serial0:115200n8";
>> -    };
>> -
>> -    i2cmux2 {
>> -        i2c@0 {
>> -            eeprom: eeprom@50 {
>> -                compatible = "atmel,24c01";
>> -                pagesize = <8>;
>> -                reg = <0x50>;
>> -            };
>> -        };
>> -    };
>> -
>> -    leds {
>> -        pinctrl-0 = <&module_led_pins>, <&sd_card_led_pin>;
>> -
>> -        sd_card_led: led-3 {
>> -            label = "sd_card_led";
>> -            gpios = <&gpio0 RK_PD2 GPIO_ACTIVE_HIGH>;
>> -            linux,default-trigger = "mmc0";
>> -        };
>> -    };
>> -
>> -    dc_12v: dc-12v {
>> -        compatible = "regulator-fixed";
>> -        regulator-name = "dc_12v";
>> -        regulator-always-on;
>> -        regulator-boot-on;
>> -        regulator-min-microvolt = <12000000>;
>> -        regulator-max-microvolt = <12000000>;
>> -    };
>> -
>> -    vcc3v3_baseboard: vcc3v3-baseboard {
>> -        compatible = "regulator-fixed";
>> -        regulator-name = "vcc3v3_baseboard";
>> -        regulator-always-on;
>> -        regulator-boot-on;
>> -        regulator-min-microvolt = <3300000>;
>> -        regulator-max-microvolt = <3300000>;
>> -        vin-supply = <&dc_12v>;
>> -    };
>> -
>> -    vcc5v0_otg: vcc5v0-otg-regulator {
>> -        compatible = "regulator-fixed";
>> -        enable-active-high;
>> -        gpio = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
>> -        pinctrl-names = "default";
>> -        pinctrl-0 = <&otg_vbus_drv>;
>> -        regulator-name = "vcc5v0_otg";
>> -        regulator-always-on;
>> -    };
>> -};
>> -
>> -&sdmmc {
>> -    bus-width = <4>;
>> -    cap-mmc-highspeed;
>> -    cap-sd-highspeed;
>> -    cd-gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_LOW>;
>> -    disable-wp;
>> -    max-frequency = <25000000>;
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>> -    rockchip,default-sample-phase = <90>;
>> -    vmmc-supply = <&vcc3v3_baseboard>;
>> -    status = "okay";
>> -};
>> -
>> -&spi2 {
>> -    cs-gpios = <0>, <&gpio2 RK_PC3 GPIO_ACTIVE_LOW>;
>> -    status = "okay";
>> -};
>> -
>> -&usb_otg {
>> -    dr_mode = "otg";
>> -    status = "okay";
>> -};
>> -
>> -&uart0 {
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>> -    status = "okay";
>> -};
>> -
>> -&uart1 {
>> -    /* alternate function of GPIO5/6 */
>> -    status = "disabled";
>> -};
>> -
>> -&pinctrl {
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&haikou_pin_hog>;
>> -
>> -    hog {
>> -        haikou_pin_hog: haikou-pin-hog {
>> -            rockchip,pins =
>> -                /* LID_BTN */
>> -                <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
>> -                /* BATLOW# */
>> -                <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>,
>> -                /* SLP_BTN# */
>> -                <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
>> -                /* BIOS_DISABLE# */
>> -                <3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
>> -        };
>> -    };
>> -
>> -    leds {
>> -        sd_card_led_pin: sd-card-led-pin {
>> -            rockchip,pins =
>> -                <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>> -        };
>> -    };
>> -
>> -    sdmmc {
>> -        sdmmc_cd_pin: sdmmc-cd-pin {
>> -            rockchip,pins =
>> -                <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>> -        };
>> -    };
>> -
>> -    usb_otg {
>> -        otg_vbus_drv: otg-vbus-drv {
>> -            rockchip,pins =
>> -                <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>> -        };
>> -    };
>> -};
>> diff --git a/arch/arm/dts/rk3368-lion.dtsi 
>> b/arch/arm/dts/rk3368-lion.dtsi
>> deleted file mode 100644
>> index bcd7977fb0f..00000000000
>> --- a/arch/arm/dts/rk3368-lion.dtsi
>> +++ /dev/null
>> @@ -1,318 +0,0 @@
>> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> -/*
>> - * Copyright (c) 2018 Theobroma Systems Design und Consulting GmbH
>> - */
>> -
>> -/dts-v1/;
>> -#include "rk3368.dtsi"
>> -
>> -/ {
>> -    aliases {
>> -        mmc0 = &emmc;
>> -    };
>> -
>> -    chosen {
>> -        stdout-path = "serial0:115200n8";
>> -    };
>> -
>> -    ext_gmac: gmac-clk {
>> -        compatible = "fixed-clock";
>> -        clock-frequency = <125000000>;
>> -        clock-output-names = "ext_gmac";
>> -        #clock-cells = <0>;
>> -    };
>> -
>> -    i2cmux1 {
>> -        compatible = "i2c-mux-gpio";
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -        i2c-parent = <&i2c1>;
>> -        mux-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>> -
>> -        /* Q7_GPO_I2C */
>> -        i2c@0 {
>> -            reg = <0>;
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>> -        };
>> -
>> -        /* Q7_SMB */
>> -        i2c@1 {
>> -            reg = <1>;
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>> -        };
>> -    };
>> -
>> -    i2cmux2 {
>> -        compatible = "i2c-mux-gpio";
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -        i2c-parent = <&i2c2>;
>> -        mux-gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
>> -
>> -        /* Q7_LVDS_BLC_I2C */
>> -        i2c@0 {
>> -            reg = <0>;
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>> -
>> -            fan: fan@18 {
>> -                compatible = "ti,amc6821";
>> -                reg = <0x18>;
>> -                #cooling-cells = <2>;
>> -            };
>> -
>> -            rtc_twi: rtc@6f {
>> -                compatible = "isil,isl1208";
>> -                reg = <0x6f>;
>> -            };
>> -        };
>> -
>> -        /* Q7_GP2_I2C */
>> -        i2c@1 {
>> -            reg = <1>;
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>> -        };
>> -    };
>> -
>> -    leds {
>> -        compatible = "gpio-leds";
>> -        pinctrl-names = "default";
>> -        pinctrl-0 = <&module_led_pins>;
>> -
>> -        module_led1: led-1 {
>> -            label = "module_led1";
>> -            gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
>> -            linux,default-trigger = "heartbeat";
>> -            panic-indicator;
>> -        };
>> -
>> -        module_led2: led-2 {
>> -            label = "module_led2";
>> -            gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
>> -            default-state = "off";
>> -        };
>> -    };
>> -
>> -    vcc_sys: vcc-sys-regulator {
>> -        compatible = "regulator-fixed";
>> -        regulator-name = "vcc_sys";
>> -        regulator-min-microvolt = <5000000>;
>> -        regulator-max-microvolt = <5000000>;
>> -        regulator-always-on;
>> -        regulator-boot-on;
>> -    };
>> -};
>> -
>> -&cpu_l0 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_l1 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_l2 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_l3 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_b0 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_b1 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_b2 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&cpu_b3 {
>> -    cpu-supply = <&vdd_cpu>;
>> -};
>> -
>> -&emmc {
>> -    bus-width = <8>;
>> -    clock-frequency = <150000000>;
>> -    mmc-hs200-1_8v;
>> -    non-removable;
>> -    vmmc-supply = <&vcc33_io>;
>> -    vqmmc-supply = <&vcc18_io>;
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
>> -    status = "okay";
>> -};
>> -
>> -&gmac {
>> -    assigned-clocks = <&cru SCLK_MAC>;
>> -    assigned-clock-parents = <&ext_gmac>;
>> -    clock_in_out = "input";
>> -    phy-supply = <&vcc33_io>;
>> -    phy-mode = "rgmii";
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&rgmii_pins>;
>> -    snps,reset-active-low;
>> -    snps,reset-delays-us = <0 10000 50000>;
>> -    snps,reset-gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
>> -    tx_delay = <0x10>;
>> -    rx_delay = <0x10>;
>> -    status = "okay";
>> -};
>> -
>> -&i2c0 {
>> -    status = "okay";
>> -
>> -    rk808: pmic@1b {
>> -        compatible = "rockchip,rk808";
>> -        reg = <0x1b>;
>> -        interrupt-parent = <&gpio0>;
>> -        interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
>> -        clock-output-names = "xin32k", "rk808-clkout2";
>> -        #clock-cells = <1>;
>> -        pinctrl-names = "default";
>> -        pinctrl-0 = <&pmic_int_l>, <&pmic_sleep>;
>> -        rockchip,system-power-controller;
>> -        vcc1-supply = <&vcc_sys>;
>> -        vcc2-supply = <&vcc_sys>;
>> -        vcc3-supply = <&vcc_sys>;
>> -        vcc4-supply = <&vcc_sys>;
>> -        vcc6-supply = <&vcc_sys>;
>> -        vcc7-supply = <&vcc_sys>;
>> -        vcc8-supply = <&vcc_sys>;
>> -        vcc9-supply = <&vcc_sys>;
>> -        vcc10-supply = <&vcc_sys>;
>> -        vcc11-supply = <&vcc_sys>;
>> -        vcc12-supply = <&vcc_sys>;
>> -
>> -        regulators {
>> -            vdd_cpu: DCDC_REG1 {
>> -                regulator-name = "vdd_cpu";
>> -                regulator-min-microvolt = <700000>;
>> -                regulator-max-microvolt = <1500000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vdd_log: DCDC_REG2 {
>> -                regulator-name = "vdd_log";
>> -                regulator-min-microvolt = <700000>;
>> -                regulator-max-microvolt = <1500000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vcc_ddr: DCDC_REG3 {
>> -                regulator-name = "vcc_ddr";
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vcc33_io: DCDC_REG4 {
>> -                regulator-name = "vcc33_io";
>> -                regulator-min-microvolt = <3300000>;
>> -                regulator-max-microvolt = <3300000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vcc33_video: LDO_REG2 {
>> -                regulator-name = "vcc33_video";
>> -                regulator-min-microvolt = <3300000>;
>> -                regulator-max-microvolt = <3300000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vdd10_pll: LDO_REG3 {
>> -                regulator-name = "vdd10_pll";
>> -                regulator-min-microvolt = <1000000>;
>> -                regulator-max-microvolt = <1000000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vcc18_io: LDO_REG4 {
>> -                regulator-name = "vcc18_io";
>> -                regulator-min-microvolt = <1800000>;
>> -                regulator-max-microvolt = <1800000>;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vdd10_video: LDO_REG6 {
>> -                regulator-name = "vdd10_video";
>> -                regulator-min-microvolt = <1000000>;
>> -                regulator-max-microvolt = <1000000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -
>> -            vcc18_video: LDO_REG8 {
>> -                regulator-name = "vcc18_video";
>> -                regulator-min-microvolt = <1800000>;
>> -                regulator-max-microvolt = <1800000>;
>> -                regulator-always-on;
>> -                regulator-boot-on;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&i2c1 {
>> -    status = "okay";
>> -};
>> -
>> -&i2c2 {
>> -    status = "okay";
>> -};
>> -
>> -&pinctrl {
>> -    leds {
>> -        module_led_pins: module-led-pins {
>> -            rockchip,pins =
>> -                <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>,
>> -                <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>> -        };
>> -    };
>> -    pmic {
>> -        pmic_int_l: pmic-int-l {
>> -            rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
>> -        };
>> -
>> -        pmic_sleep: pmic-sleep {
>> -            rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
>> -        };
>> -    };
>> -};
>> -
>> -&spi1 {
>> -    status = "okay";
>> -
>> -    norflash: flash@0 {
>> -        compatible = "jedec,spi-nor";
>> -        reg = <0>;
>> -        spi-max-frequency = <50000000>;
>> -    };
>> -};
>> -
>> -&uart1 {
>> -    status = "okay";
>> -};
>> -
>> -&uart3 {
>> -    status = "okay";
>> -};
>> -
>> -&usb_host0_ehci {
>> -    status = "okay";
>> -};
>> -
>> -&wdt {
>> -    status = "okay";
>> -};
>> diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig 
>> b/arch/arm/mach-rockchip/rk3368/Kconfig
>> index 3de695186ed..a7be30bbd89 100644
>> --- a/arch/arm/mach-rockchip/rk3368/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3368/Kconfig
>> @@ -3,27 +3,6 @@ if ROCKCHIP_RK3368
>>   choice
>>       prompt "RK3368 board"
>>   -config TARGET_LION_RK3368
>> -        bool "Theobroma Systems RK3368-uQ7 (Lion) module"
>> -    select ARCH_EARLY_INIT_R
>> -    help
>> -      The RK3368-uQ7 is a micro-Qseven form-factor (40mm x 70mm,
>> -      MXM-230 connector) system-on-module designed by Theobroma
>> -      Systems for industrial applications.
>> -
>> -      It provides the following features:
>> -       - 8x Cortex-A53 (in 2 clusters of 4 cores each)
>> -       - (on-module) up to 4GB of DDR3 memory
>> -       - (on-module) SPI-NOR flash
>> -       - (on-module) eMMC
>> -       - Gigabit Ethernet (with an on-module KSZ9031 PHY)
>> -       - USB
>> -       - HDMI
>> -       - MIPI-DSI/single-channel LVDS (muxed on the 'LVDS-A' pin-group)
>> -       - various 'slow' interfaces (e.g. UART, SPI, I2C, I2S, ...)
>> -       - on-module STM32 providing CAN, RTC and fan-control
>> -       - (optional on-module) EAL4+-certified security module
>> -
>>   config TARGET_SHEEP
>>       bool "Sheep board"
>>       help
>> @@ -62,7 +41,6 @@ config SPL_LIBCOMMON_SUPPORT
>>   config SPL_LIBGENERIC_SUPPORT
>>       default y
>>   -source "board/theobroma-systems/lion_rk3368/Kconfig"
>>   source "board/rockchip/sheep_rk3368/Kconfig"
>>   source "board/geekbuying/geekbox/Kconfig"
>>   source "board/rockchip/evb_px5/Kconfig"
>> diff --git a/board/theobroma-systems/lion_rk3368/Kconfig 
>> b/board/theobroma-systems/lion_rk3368/Kconfig
>> deleted file mode 100644
>> index 537a2e7d9af..00000000000
>> --- a/board/theobroma-systems/lion_rk3368/Kconfig
>> +++ /dev/null
>> @@ -1,18 +0,0 @@
>> -if TARGET_LION_RK3368
>> -
>> -config SYS_BOARD
>> -    default "lion_rk3368"
>> -
>> -config SYS_VENDOR
>> -    default "theobroma-systems"
>> -
>> -config SYS_CONFIG_NAME
>> -    default "lion_rk3368"
>> -
>> -config ENV_SIZE
>> -    default 0x2000
>> -
>> -config ENV_OFFSET
>> -    default 0x3c000 if ENV_IS_IN_SPI_FLASH
>> -
>> -endif
>> diff --git a/board/theobroma-systems/lion_rk3368/MAINTAINERS 
>> b/board/theobroma-systems/lion_rk3368/MAINTAINERS
>> deleted file mode 100644
>> index ed35fee6468..00000000000
>> --- a/board/theobroma-systems/lion_rk3368/MAINTAINERS
>> +++ /dev/null
>> @@ -1,10 +0,0 @@
>> -LION-RK3368 (RK3368-uQ7 system-on-module)
>> -M:    Quentin Schulz <quentin.schulz@cherry.de>
>> -M:    Klaus Goger <klaus.goger@cherry.de>
>> -S:    Maintained
>> -F:    board/theobroma-systems/lion_rk3368
>> -F:    include/configs/lion_rk3368.h
>> -F:    arch/arm/dts/rk3368-lion.dts
>> -F:    configs/lion-rk3368_defconfig
>> -W:    https://www.theobroma-systems.com/rk3368-uq7/tech-specs
>> -T:    git git://git.theobroma-systems.com/lion-u-boot.git
>> diff --git a/board/theobroma-systems/lion_rk3368/README 
>> b/board/theobroma-systems/lion_rk3368/README
>> deleted file mode 100644
>> index 7488b18326b..00000000000
>> --- a/board/theobroma-systems/lion_rk3368/README
>> +++ /dev/null
>> @@ -1,78 +0,0 @@
>> -Here is the step-by-step to boot to U-Boot on RK3368-uQ7
>> -
>> -Get the Source and build ATF
>> -============================
>> -
>> -  > git clone git://git.theobroma-systems.com/arm-trusted-firmware.git
>> -  > cd arm-trusted-firmware
>> -  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3368 bl31
>> -  > cp build/rk3368/release/bl31.bin ../u-boot/bl31-rk3368.bin
>> -
>> -Configure U-Boot
>> -================
>> -
>> -  > cd ../u-boot
>> -  > make lion-rk3368_defconfig
>> -
>> -Build the TPL/SPL stage
>> -=======================
>> -
>> -  > make CROSS_COMPILE=aarch64-unknown-elf-
>> -
>> -Build the full U-Boot and a FIT image including the ATF
>> -=======================================================
>> -
>> -  > make CROSS_COMPILE=aarch64-unknown-elf- u-boot.itb
>> -
>> -Flash the image
>> -===============
>> -
>> -Copy the SPL to offset 32k and the FIT image containing the payloads
>> -(U-Boot proper, ATF, devicetree) to offset 256k card.
>> -
>> -SD-Card
>> --------
>> -
>> -  > dd if=idbloader.img of=/dev/sdb seek=64
>> -  > dd if=u-boot.itb of=/dev/sdb seek=512
>> -
>> -eMMC
>> -----
>> -
>> -rkdeveloptool allows to flash the on-board eMMC via the USB OTG 
>> interface with
>> -help of the Rockchip loader binary.
>> -
>> -  > git clone https://github.com/rockchip-linux/rkdeveloptool
>> -  > cd rkdeveloptool
>> -  > autoreconf -i && && ./configure && make
>> -  > git clone https://github.com/rockchip-linux/rkbin.git
>> -  > ./rkdeveloptool db rkbin/rk33/rk3368_loader_v2.00.256.bin
>> -  > ./rkdeveloptool wl 64 ../spl.img
>> -  > ./rkdeveloptool wl 512 ../u-boot.itb
>> -
>> -
>> -If everything went according to plan, you should see the following
>> -output on UART0:
>> -
>> -<debug_uart> U-Boot TPL board init
>> -Trying to boot from BOOTROM
>> -Returning to boot ROM...
>> -Trying to boot from MMC1
>> -NOTICE:  BL31: v1.3(release):v1.2-1320-gbf43a443
>> -NOTICE:  BL31: Built : 18:04:47, Jul  5 2017
>> -
>> -
>> -U-Boot 2017.07-00158-g2395e99858 (Jul 18 2017 - 21:03:31 +0200)
>> -
>> -Model: Theobroma Systems RK3368-uQ7 SoM
>> -DRAM:  2 GiB
>> -MMC:   dwmmc@ff0c0000: 1, dwmmc@ff0f0000: 0
>> -Using default environment
>> -
>> -In:    serial@ff180000
>> -Out:   serial@ff180000
>> -Err:   serial@ff180000
>> -Net:
>> -Warning: ethernet@ff290000 (eth0) using random MAC address - 
>> d2:69:35:7e:d0:1e
>> -eth0: ethernet@ff290000
>> -Hit any key to stop autoboot:  2
>> diff --git a/configs/lion-rk3368_defconfig 
>> b/configs/lion-rk3368_defconfig
>> deleted file mode 100644
>> index 868eeaf6c8e..00000000000
>> --- a/configs/lion-rk3368_defconfig
>> +++ /dev/null
>> @@ -1,110 +0,0 @@
>> -CONFIG_ARM=y
>> -CONFIG_SKIP_LOWLEVEL_INIT=y
>> -CONFIG_COUNTER_FREQUENCY=24000000
>> -CONFIG_ARCH_ROCKCHIP=y
>> -CONFIG_TEXT_BASE=0x00200000
>> -CONFIG_NR_DRAM_BANKS=1
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>> -CONFIG_ENV_OFFSET=0x3F8000
>> -CONFIG_DEFAULT_DEVICE_TREE="rk3368-lion-haikou"
>> -CONFIG_SPL_TEXT_BASE=0x00000000
>> -CONFIG_ROCKCHIP_RK3368=y
>> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
>> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
>> -CONFIG_SPL_DRIVERS_MISC=y
>> -CONFIG_SPL_STACK=0x188000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0x400000
>> -CONFIG_SPL_BSS_MAX_SIZE=0x20000
>> -CONFIG_SPL_STACK_R=y
>> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>> -CONFIG_SPL=y
>> -CONFIG_DEBUG_UART_BASE=0xFF180000
>> -CONFIG_DEBUG_UART_CLOCK=24000000
>> -CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> -CONFIG_SPL_SPI=y
>> -CONFIG_SYS_LOAD_ADDR=0x800800
>> -CONFIG_DEBUG_UART=y
>> -CONFIG_FIT=y
>> -CONFIG_FIT_VERBOSE=y
>> -CONFIG_SPL_LOAD_FIT=y
>> -CONFIG_BOOTSTAGE=y
>> -CONFIG_SPL_BOOTSTAGE=y
>> -CONFIG_BOOTSTAGE_REPORT=y
>> -CONFIG_BOOTSTAGE_FDT=y
>> -CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-lion-haikou.dtb"
>> -# CONFIG_DISPLAY_CPUINFO is not set
>> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_SPL_MAX_SIZE=0x40000
>> -CONFIG_SPL_PAD_TO=0x7f8000
>> -CONFIG_SPL_BOOTROM_SUPPORT=y
>> -# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>> -CONFIG_SPL_ATF=y
>> -CONFIG_TPL=y
>> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>> -CONFIG_TPL_DRIVERS_MISC=y
>> -CONFIG_CMD_GPIO=y
>> -CONFIG_CMD_MMC=y
>> -CONFIG_CMD_SPI=y
>> -CONFIG_CMD_USB=y
>> -CONFIG_CMD_BOOTSTAGE=y
>> -CONFIG_CMD_REGULATOR=y
>> -CONFIG_CMD_MTDPARTS=y
>> -CONFIG_SPL_OF_CONTROL=y
>> -CONFIG_TPL_OF_CONTROL=y
>> -CONFIG_OF_LIVE=y
>> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"
>> -CONFIG_TPL_OF_PLATDATA=y
>> -CONFIG_ENV_IS_IN_MMC=y
>> -CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NET_RANDOM_ETHADDR=y
>> -CONFIG_TPL_DM=y
>> -CONFIG_REGMAP=y
>> -CONFIG_SPL_REGMAP=y
>> -CONFIG_TPL_REGMAP=y
>> -CONFIG_SYSCON=y
>> -CONFIG_SPL_SYSCON=y
>> -CONFIG_TPL_SYSCON=y
>> -CONFIG_CLK=y
>> -CONFIG_SPL_CLK=y
>> -CONFIG_TPL_CLK=y
>> -CONFIG_ROCKCHIP_GPIO=y
>> -CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MMC_DW=y
>> -CONFIG_MMC_DW_ROCKCHIP=y
>> -CONFIG_SPI_FLASH_MACRONIX=y
>> -CONFIG_SPI_FLASH_WINBOND=y
>> -CONFIG_PHY_ANEG_TIMEOUT=8000
>> -CONFIG_PHY_MSCC=y
>> -CONFIG_DM_ETH_PHY=y
>> -CONFIG_ETH_DESIGNWARE=y
>> -CONFIG_RGMII=y
>> -CONFIG_GMAC_ROCKCHIP=y
>> -CONFIG_PINCTRL=y
>> -CONFIG_SPL_PINCTRL=y
>> -CONFIG_DM_PMIC=y
>> -CONFIG_PMIC_RK8XX=y
>> -CONFIG_DM_REGULATOR_FIXED=y
>> -CONFIG_REGULATOR_RK8XX=y
>> -CONFIG_RAM=y
>> -CONFIG_SPL_RAM=y
>> -CONFIG_TPL_RAM=y
>> -CONFIG_DEBUG_UART_SHIFT=2
>> -CONFIG_DEBUG_UART_ANNOUNCE=y
>> -CONFIG_SYS_NS16550_MEM32=y
>> -CONFIG_ROCKCHIP_SPI=y
>> -CONFIG_SYSINFO=y
>> -CONFIG_SYSINFO_SMBIOS=y
>> -CONFIG_SYSRESET=y
>> -CONFIG_USB=y
>> -CONFIG_USB_EHCI_HCD=y
>> -CONFIG_USB_EHCI_GENERIC=y
>> -CONFIG_USB_DWC2=y
>> -CONFIG_USB_GADGET=y
>> -CONFIG_USB_GADGET_DWC2_OTG=y
>> -CONFIG_SPL_TINY_MEMSET=y
>> -CONFIG_LZO=y
>> -CONFIG_ERRNO_STR=y
>> diff --git a/doc/board/rockchip/rockchip.rst 
>> b/doc/board/rockchip/rockchip.rst
>> index eaf71673b7f..bac12f055bc 100644
>> --- a/doc/board/rockchip/rockchip.rst
>> +++ b/doc/board/rockchip/rockchip.rst
>> @@ -72,7 +72,6 @@ List of mainline supported Rockchip boards:
>>        - GeekBox (geekbox)
>>        - PX5 EVB (evb-px5)
>>        - Rockchip Sheep (sheep-rk3368)
>> -     - Theobroma Systems RK3368-uQ7 SoM - Lion (lion-rk3368)
>>   * rk3399
>>        - 96boards RK3399 Ficus (ficus-rk3399)
>>        - 96boards Rock960 (rock960-rk3399)
>> diff --git a/include/configs/lion_rk3368.h 
>> b/include/configs/lion_rk3368.h
>> deleted file mode 100644
>> index 0d29e1ddc73..00000000000
>> --- a/include/configs/lion_rk3368.h
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0+ */
>> -/*
>> - * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
>> - */
>> -
>> -#ifndef __CONFIGS_LION_RK3368_H
>> -#define __CONFIGS_LION_RK3368_H
>> -
>> -#include <configs/rk3368_common.h>
>> -
>> -#define KERNEL_LOAD_ADDR        0x280000
>> -#define DTB_LOAD_ADDR            0x5600000
>> -#define INITRD_LOAD_ADDR        0x5bf0000
>> -/* PHY needs longer aneg time at 1G */
>> -
>> -#endif
>>
