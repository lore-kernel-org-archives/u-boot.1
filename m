Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5046EC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 05:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B6188204;
	Mon, 24 Jun 2024 07:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="snc/05bI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B9987DC7; Sun, 23 Jun 2024 15:34:24 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8B8878E2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 15:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719149660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5Pab/spNGMzUwvxKHTGelQJLINn1tDcHbEdxIpz9q4=;
 b=snc/05bI/CGcI1F/iOHLiPGBT0i5fDU5xUcfgzjSBXxW2tFso/3gsxtDVs/zms/wiYqjmp
 y8sPvkrAtW0VCMeuuL5+3e0SyALT8xqXvVNc7QjXjyCx+T6evoRZW9No757J9aT6r+vaDQ
 ReN45I85tZ5W9fDUIfmIAXBzsqaysmD8+x+yAB8GC2HRFVUZKdqGWEIwGzhSIftgGZuvUy
 AWHibmcfRNkehokthiZz56sOFpt0NbY8j/xuxEL0uzwxBos/u/9AO9w3+1mwYpOHYdt5XV
 NEOSylA4nco5+LBVtPAi1aEQshQw4YeYGYt6ODhWtwc3hl5xiH7OLhDrmrfQbg==
Date: Sun, 23 Jun 2024 15:34:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, heiko@sntech.de,
 krzk@kernel.org
Subject: Re: [RFC] rockchip: add support for Radxa ROCK Pi E v3.0 which uses
 DDR4 SDRAM
In-Reply-To: <CALeDE9Mc3GUNnEu0EAZnpWFJhJe=k8LwvFGLFE0u2gjZLpkHTg@mail.gmail.com>
References: <20240623041542.50137-1-naoki@radxa.com>
 <6ee01ffc7cf4965e3c7404359d45098f@manjaro.org>
 <CALeDE9Mc3GUNnEu0EAZnpWFJhJe=k8LwvFGLFE0u2gjZLpkHTg@mail.gmail.com>
Message-ID: <aed3df6a7492a4fb2977fdf5110fe268@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Mailman-Approved-At: Mon, 24 Jun 2024 07:15:48 +0200
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

+Cc: heiko@sntech.de
+Cc: krzk@kernel.org

Hello Peter and Fukaumi,

On 2024-06-23 15:08, Peter Robinson wrote:
> On Sun, 23 Jun 2024 at 13:21, Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-06-23 06:15, FUKAUMI Naoki wrote:
>> > rk3328-rock-pi-e-v3.dts is identical to rk3328-rock-pi-e.dts in
>> > upstream. only difference between v3.0 and prior ver. is, using
>> > rk3328-sdram-ddr4-666.dtsi instead of rk3328-sdram-ddr3-666.dtsi.
>> 
>> I think you'll need to get the device tree resolved on the Linux
>> kernel side first, and then imported into U-Boot following the
>> rules of the OF_UPSTREAM approach.
> 
> I think the question was more "given the only difference between the
> two is the memory is there a way we can do a single U-Boot build that
> supports both" and I think the answer to that is unfortunately no,
> even if the DT, config etc are all the same. I would be interested if
> you come up with a solution as I have a couple of devices like this.

Good point.  Maybe we could employ an approach similar to how the
bad CPU cores will be disabled by U-Boot on RK3582.  Though, is it
even possible to detect the board revision on the ROCK Pi E, e.g.
by reading the statuses of some GPIO lines that encode the board
revision?  I went quickly through the v3.0 schematic and haven't
spotted anything like that.

>> > here is console output from ROCK Pi E v3.0:
>> >
>> > ```
>> > U-Boot TPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09)
>> > DDR4, 333MHz
>> > BW=32 Col=10 Bk=4 BG=2 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>> > Trying to boot from BOOTROM
>> > Returning to boot ROM...
>> >
>> > U-Boot SPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09 +0900)
>> > Trying to boot from MMC2
>> > ```
>> >
>> > there is an another way which can share same u-boot-rockchip.bin
>> > between v3 and prior, using ddr blob from Rockchip instead of TPL in
>> > U-Boot. is it acceptable?
>> >
>> > Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> > ---
>> >  arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi |   43 +
>> >  arch/arm/dts/rk3328-rock-pi-e-v3.dts         |  445 ++++
>> >  arch/arm/dts/rk3328.dtsi                     | 1943 ++++++++++++++++++
>> >  configs/rock-pi-e-v3-rk3328_defconfig        |   97 +
>> >  4 files changed, 2528 insertions(+)
>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
>> >  create mode 100644 arch/arm/dts/rk3328.dtsi
>> >  create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig
>> >
>> > diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>> > b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>> > new file mode 100644
>> > index 0000000000..d7b22b01d7
>> > --- /dev/null
>> > +++ b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>> > @@ -0,0 +1,43 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * (C) Copyright 2020 Radxa
>> > + */
>> > +
>> > +#include "rk3328-u-boot.dtsi"
>> > +#include "rk3328-sdram-ddr4-666.dtsi"
>> > +
>> > +/ {
>> > +     smbios {
>> > +             compatible = "u-boot,sysinfo-smbios";
>> > +
>> > +             smbios {
>> > +                     system {
>> > +                             manufacturer = "radxa";
>> > +                             product = "rock-pi-e_rk3328";
>> > +                     };
>> > +
>> > +                     baseboard {
>> > +                             manufacturer = "radxa";
>> > +                             product = "rock-pi-e_rk3328";
>> > +                     };
>> > +
>> > +                     chassis {
>> > +                             manufacturer = "radxa";
>> > +                             product = "rock-pi-e_rk3328";
>> > +                     };
>> > +             };
>> > +     };
>> > +};
>> > +
>> > +&u2phy_host {
>> > +     phy-supply = <&vcc_host_5v>;
>> > +};
>> > +
>> > +&vcc_host_5v {
>> > +     /delete-property/ regulator-always-on;
>> > +     /delete-property/ regulator-boot-on;
>> > +};
>> > +
>> > +&vcc_sd {
>> > +     bootph-pre-ram;
>> > +};
>> > diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3.dts
>> > b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
>> > new file mode 100644
>> > index 0000000000..3cda6c627b
>> > --- /dev/null
>> > +++ b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
>> > @@ -0,0 +1,445 @@
>> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > +/*
>> > + * (C) Copyright 2020 Chen-Yu Tsai <wens@csie.org>
>> > + *
>> > + * Based on ./rk3328-rock64.dts, which is
>> > + *
>> > + * Copyright (c) 2017 PINE64
>> > + */
>> > +
>> > +/dts-v1/;
>> > +
>> > +#include <dt-bindings/gpio/gpio.h>
>> > +#include <dt-bindings/input/input.h>
>> > +#include <dt-bindings/leds/common.h>
>> > +#include <dt-bindings/pinctrl/rockchip.h>
>> > +
>> > +#include "rk3328.dtsi"
>> > +
>> > +/ {
>> > +     model = "Radxa ROCK Pi E";
>> > +     compatible = "radxa,rockpi-e", "rockchip,rk3328";
>> > +
>> > +     aliases {
>> > +             ethernet0 = &gmac2io;
>> > +             ethernet1 = &gmac2phy;
>> > +             mmc0 = &sdmmc;
>> > +             mmc1 = &emmc;
>> > +     };
>> > +
>> > +     chosen {
>> > +             stdout-path = "serial2:1500000n8";
>> > +     };
>> > +
>> > +     adc-keys {
>> > +             compatible = "adc-keys";
>> > +             io-channels = <&saradc 0>;
>> > +             io-channel-names = "buttons";
>> > +             keyup-threshold-microvolt = <1750000>;
>> > +
>> > +             /* This button is unpopulated out of the factory. */
>> > +             button-recovery {
>> > +                     label = "Recovery";
>> > +                     linux,code = <KEY_VENDOR>;
>> > +                     press-threshold-microvolt = <10000>;
>> > +             };
>> > +     };
>> > +
>> > +     gmac_clkin: external-gmac-clock {
>> > +             compatible = "fixed-clock";
>> > +             clock-frequency = <125000000>;
>> > +             clock-output-names = "gmac_clkin";
>> > +             #clock-cells = <0>;
>> > +     };
>> > +
>> > +     leds {
>> > +             compatible = "gpio-leds";
>> > +             pinctrl-0 = <&led_pin>;
>> > +             pinctrl-names = "default";
>> > +
>> > +             led-0 {
>> > +                     color = <LED_COLOR_ID_BLUE>;
>> > +                     gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_LOW>;
>> > +                     linux,default-trigger = "heartbeat";
>> > +             };
>> > +     };
>> > +
>> > +     vcc_sd: sdmmc-regulator {
>> > +             compatible = "regulator-fixed";
>> > +             gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&sdmmc0m1_pin>;
>> > +             regulator-name = "vcc_sd";
>> > +             regulator-boot-on;
>> > +             vin-supply = <&vcc_io>;
>> > +     };
>> > +
>> > +     vcc_host_5v: vcc-host-5v-regulator {
>> > +             compatible = "regulator-fixed";
>> > +             gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&usb30_host_drv>;
>> > +             enable-active-high;
>> > +             regulator-name = "vcc_host_5v";
>> > +             regulator-always-on;
>> > +             regulator-boot-on;
>> > +             vin-supply = <&vcc_sys>;
>> > +     };
>> > +
>> > +     vcc_sys: vcc-sys {
>> > +             compatible = "regulator-fixed";
>> > +             regulator-name = "vcc_sys";
>> > +             regulator-always-on;
>> > +             regulator-boot-on;
>> > +             regulator-min-microvolt = <5000000>;
>> > +             regulator-max-microvolt = <5000000>;
>> > +     };
>> > +
>> > +     vcc_wifi: vcc-wifi-regulator {
>> > +             compatible = "regulator-fixed";
>> > +             gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&wifi_en>;
>> > +             regulator-name = "vcc_wifi";
>> > +             regulator-always-on;
>> > +             regulator-boot-on;
>> > +             vin-supply = <&vcc_io>;
>> > +     };
>> > +};
>> > +
>> > +&analog_sound {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&codec {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&cpu0 {
>> > +     cpu-supply = <&vdd_arm>;
>> > +};
>> > +
>> > +&cpu1 {
>> > +     cpu-supply = <&vdd_arm>;
>> > +};
>> > +
>> > +&cpu2 {
>> > +     cpu-supply = <&vdd_arm>;
>> > +};
>> > +
>> > +&cpu3 {
>> > +     cpu-supply = <&vdd_arm>;
>> > +};
>> > +
>> > +&emmc {
>> > +     bus-width = <8>;
>> > +     cap-mmc-highspeed;
>> > +     mmc-ddr-1_8v;
>> > +     mmc-hs200-1_8v;
>> > +     non-removable;
>> > +     pinctrl-names = "default";
>> > +     pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
>> > +     vmmc-supply = <&vcc_io>;
>> > +     vqmmc-supply = <&vcc18_emmc>;
>> > +     status = "okay";
>> > +};
>> > +
>> > +&gmac2io {
>> > +     assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>> > +     assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
>> > +     clock_in_out = "input";
>> > +     phy-handle = <&rtl8211e>;
>> > +     phy-mode = "rgmii";
>> > +     phy-supply = <&vcc_io>;
>> > +     pinctrl-names = "default";
>> > +     pinctrl-0 = <&rgmiim1_pins>;
>> > +     snps,aal;
>> > +     snps,rxpbl = <0x4>;
>> > +     snps,txpbl = <0x4>;
>> > +     tx_delay = <0x26>;
>> > +     rx_delay = <0x11>;
>> > +     status = "okay";
>> > +
>> > +     mdio {
>> > +             compatible = "snps,dwmac-mdio";
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +
>> > +             rtl8211e: ethernet-phy@1 {
>> > +                     reg = <1>;
>> > +                     pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
>> > +                     pinctrl-names = "default";
>> > +                     interrupt-parent = <&gpio1>;
>> > +                     interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
>> > +                     reset-assert-us = <10000>;
>> > +                     reset-deassert-us = <50000>;
>> > +                     reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>> > +             };
>> > +     };
>> > +};
>> > +
>> > +&gmac2phy {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&gpio0 {
>> > +     gpio-line-names =
>> > +             /* GPIO0_A0 - A7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO0_B0 - B7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO0_C0 - C7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO0_D0 - D7 */
>> > +             "", "", "", "pin-15 [GPIO0_D3]", "", "", "", "";
>> > +};
>> > +
>> > +&gpio1 {
>> > +     gpio-line-names =
>> > +             /* GPIO1_A0 - A7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO1_B0 - B7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO1_C0 - C7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO1_D0 - D7 */
>> > +             "", "", "", "", "pin-07 [GPIO1_D4]", "", "", "";
>> > +};
>> > +
>> > +&gpio2 {
>> > +     gpio-line-names =
>> > +             /* GPIO2_A0 - A7 */
>> > +             "pin-08 [GPIO2_A0]", "pin-10 [GPIO2_A1]", "pin-11 [GPIO2_A2]",
>> > +             "pin-13 [GPIO2-A3]", "pin-27 [GPIO2_A4]", "pin-28 [GPIO2_A5]",
>> > +             "pin-33 [GPIO2_A6]", "",
>> > +             /* GPIO2_B0 - B7 */
>> > +             "", "", "", "", "pin-26 [GPIO2_B4]", "", "", "pin-36 [GPIO2_B7]",
>> > +             /* GPIO2_C0 - C7 */
>> > +             "pin-32 [GPIO2_C0]", "pin-35 [GPIO2_C1]", "pin-12 [GPIO2_C2]",
>> > +             "pin-38 [GPIO2_C3]", "pin-29 [GPIO2_C4]", "pin-31 [GPIO2_C5]",
>> > +             "pin-37 [GPIO2_C6]", "pin-40 [GPIO2_C7]",
>> > +             /* GPIO2_D0 - D7 */
>> > +             "", "", "", "", "", "", "", "";
>> > +};
>> > +
>> > +&gpio3 {
>> > +     gpio-line-names =
>> > +             /* GPIO3_A0 - A7 */
>> > +             "pin-23 [GPIO3_A0]", "pin-19 [GPIO3_A1]", "pin-21 [GPIO3_A2]",
>> > +             "", "pin-03 [GPIO3_A4]", "", "pin-05 [GPIO3_A6]", "",
>> > +             /* GPIO3_B0 - B7 */
>> > +             "pin-24 [GPIO3_B0]", "", "", "", "", "", "", "",
>> > +             /* GPIO3_C0 - C7 */
>> > +             "", "", "", "", "", "", "", "",
>> > +             /* GPIO3_D0 - D7 */
>> > +             "", "", "", "", "", "", "", "";
>> > +};
>> > +
>> > +&i2c1 {
>> > +     status = "okay";
>> > +
>> > +     rk805: pmic@18 {
>> > +             compatible = "rockchip,rk805";
>> > +             reg = <0x18>;
>> > +             interrupt-parent = <&gpio2>;
>> > +             interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>> > +             #clock-cells = <1>;
>> > +             clock-output-names = "xin32k", "rk805-clkout2";
>> > +             gpio-controller;
>> > +             #gpio-cells = <2>;
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&pmic_int_l>;
>> > +             rockchip,system-power-controller;
>> > +             wakeup-source;
>> > +
>> > +             vcc1-supply = <&vcc_sys>;
>> > +             vcc2-supply = <&vcc_sys>;
>> > +             vcc3-supply = <&vcc_sys>;
>> > +             vcc4-supply = <&vcc_sys>;
>> > +             vcc5-supply = <&vcc_io>;
>> > +             vcc6-supply = <&vcc_sys>;
>> > +
>> > +             regulators {
>> > +                     vdd_log: DCDC_REG1 {
>> > +                             regulator-name = "vdd_log";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <712500>;
>> > +                             regulator-max-microvolt = <1450000>;
>> > +                             regulator-ramp-delay = <12500>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <1000000>;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vdd_arm: DCDC_REG2 {
>> > +                             regulator-name = "vdd_arm";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <712500>;
>> > +                             regulator-max-microvolt = <1450000>;
>> > +                             regulator-ramp-delay = <12500>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <950000>;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vcc_ddr: DCDC_REG3 {
>> > +                             regulator-name = "vcc_ddr";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vcc_io: DCDC_REG4 {
>> > +                             regulator-name = "vcc_io";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <3300000>;
>> > +                             regulator-max-microvolt = <3300000>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <3300000>;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vcc_18: LDO_REG1 {
>> > +                             regulator-name = "vcc_18";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <1800000>;
>> > +                             regulator-max-microvolt = <1800000>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <1800000>;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vcc18_emmc: LDO_REG2 {
>> > +                             regulator-name = "vcc18_emmc";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <1800000>;
>> > +                             regulator-max-microvolt = <1800000>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <1800000>;
>> > +                             };
>> > +                     };
>> > +
>> > +                     vdd_10: LDO_REG3 {
>> > +                             regulator-name = "vdd_10";
>> > +                             regulator-always-on;
>> > +                             regulator-boot-on;
>> > +                             regulator-min-microvolt = <1000000>;
>> > +                             regulator-max-microvolt = <1000000>;
>> > +
>> > +                             regulator-state-mem {
>> > +                                     regulator-on-in-suspend;
>> > +                                     regulator-suspend-microvolt = <1000000>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +     };
>> > +};
>> > +
>> > +&i2s1 {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&io_domains {
>> > +     pmuio-supply = <&vcc_io>;
>> > +     vccio1-supply = <&vcc_io>;
>> > +     vccio2-supply = <&vcc18_emmc>;
>> > +     vccio3-supply = <&vcc_io>;
>> > +     vccio4-supply = <&vcc_io>;
>> > +     vccio5-supply = <&vcc_io>;
>> > +     vccio6-supply = <&vcc_io>;
>> > +     status = "okay";
>> > +};
>> > +
>> > +&pinctrl {
>> > +     ephy {
>> > +             eth_phy_int_pin: eth-phy-int-pin {
>> > +                     rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
>> > +             };
>> > +
>> > +             eth_phy_reset_pin: eth-phy-reset-pin {
>> > +                     rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
>> > +             };
>> > +     };
>> > +
>> > +     leds {
>> > +             led_pin: led-pin {
>> > +                     rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +             };
>> > +     };
>> > +
>> > +     pmic {
>> > +             pmic_int_l: pmic-int-l {
>> > +                     rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
>> > +             };
>> > +     };
>> > +
>> > +     usb3 {
>> > +             usb30_host_drv: usb30-host-drv {
>> > +                     rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +             };
>> > +     };
>> > +
>> > +     wifi {
>> > +             wifi_en: wifi-en {
>> > +                     rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +             };
>> > +     };
>> > +};
>> > +
>> > +&sdmmc {
>> > +     bus-width = <4>;
>> > +     cap-sd-highspeed;
>> > +     disable-wp;
>> > +     pinctrl-names = "default";
>> > +     pinctrl-0 = <&sdmmc0_clk>, <&sdmmc0_cmd>, <&sdmmc0_dectn>,
>> > <&sdmmc0_bus4>;
>> > +     vmmc-supply = <&vcc_sd>;
>> > +     status = "okay";
>> > +};
>> > +
>> > +&saradc {
>> > +     vref-supply = <&vcc_18>;
>> > +     status = "okay";
>> > +};
>> > +
>> > +&tsadc {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&u2phy {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&u2phy_host {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&uart2 {
>> > +     status = "okay";
>> > +};
>> > +
>> > +&usbdrd3 {
>> > +     dr_mode = "host";
>> > +     status = "okay";
>> > +};
>> > +
>> > +&usb_host0_ehci {
>> > +     status = "okay";
>> > +};
>> > diff --git a/arch/arm/dts/rk3328.dtsi b/arch/arm/dts/rk3328.dtsi
>> > new file mode 100644
>> > index 0000000000..7b4c15c4a9
>> > --- /dev/null
>> > +++ b/arch/arm/dts/rk3328.dtsi
>> > @@ -0,0 +1,1943 @@
>> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > +/*
>> > + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
>> > + */
>> > +
>> > +#include <dt-bindings/clock/rk3328-cru.h>
>> > +#include <dt-bindings/gpio/gpio.h>
>> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>> > +#include <dt-bindings/pinctrl/rockchip.h>
>> > +#include <dt-bindings/power/rk3328-power.h>
>> > +#include <dt-bindings/soc/rockchip,boot-mode.h>
>> > +#include <dt-bindings/thermal/thermal.h>
>> > +
>> > +/ {
>> > +     compatible = "rockchip,rk3328";
>> > +
>> > +     interrupt-parent = <&gic>;
>> > +     #address-cells = <2>;
>> > +     #size-cells = <2>;
>> > +
>> > +     aliases {
>> > +             gpio0 = &gpio0;
>> > +             gpio1 = &gpio1;
>> > +             gpio2 = &gpio2;
>> > +             gpio3 = &gpio3;
>> > +             serial0 = &uart0;
>> > +             serial1 = &uart1;
>> > +             serial2 = &uart2;
>> > +             i2c0 = &i2c0;
>> > +             i2c1 = &i2c1;
>> > +             i2c2 = &i2c2;
>> > +             i2c3 = &i2c3;
>> > +     };
>> > +
>> > +     cpus {
>> > +             #address-cells = <2>;
>> > +             #size-cells = <0>;
>> > +
>> > +             cpu0: cpu@0 {
>> > +                     device_type = "cpu";
>> > +                     compatible = "arm,cortex-a53";
>> > +                     reg = <0x0 0x0>;
>> > +                     clocks = <&cru ARMCLK>;
>> > +                     #cooling-cells = <2>;
>> > +                     cpu-idle-states = <&CPU_SLEEP>;
>> > +                     dynamic-power-coefficient = <120>;
>> > +                     enable-method = "psci";
>> > +                     next-level-cache = <&l2>;
>> > +                     operating-points-v2 = <&cpu0_opp_table>;
>> > +             };
>> > +
>> > +             cpu1: cpu@1 {
>> > +                     device_type = "cpu";
>> > +                     compatible = "arm,cortex-a53";
>> > +                     reg = <0x0 0x1>;
>> > +                     clocks = <&cru ARMCLK>;
>> > +                     #cooling-cells = <2>;
>> > +                     cpu-idle-states = <&CPU_SLEEP>;
>> > +                     dynamic-power-coefficient = <120>;
>> > +                     enable-method = "psci";
>> > +                     next-level-cache = <&l2>;
>> > +                     operating-points-v2 = <&cpu0_opp_table>;
>> > +             };
>> > +
>> > +             cpu2: cpu@2 {
>> > +                     device_type = "cpu";
>> > +                     compatible = "arm,cortex-a53";
>> > +                     reg = <0x0 0x2>;
>> > +                     clocks = <&cru ARMCLK>;
>> > +                     #cooling-cells = <2>;
>> > +                     cpu-idle-states = <&CPU_SLEEP>;
>> > +                     dynamic-power-coefficient = <120>;
>> > +                     enable-method = "psci";
>> > +                     next-level-cache = <&l2>;
>> > +                     operating-points-v2 = <&cpu0_opp_table>;
>> > +             };
>> > +
>> > +             cpu3: cpu@3 {
>> > +                     device_type = "cpu";
>> > +                     compatible = "arm,cortex-a53";
>> > +                     reg = <0x0 0x3>;
>> > +                     clocks = <&cru ARMCLK>;
>> > +                     #cooling-cells = <2>;
>> > +                     cpu-idle-states = <&CPU_SLEEP>;
>> > +                     dynamic-power-coefficient = <120>;
>> > +                     enable-method = "psci";
>> > +                     next-level-cache = <&l2>;
>> > +                     operating-points-v2 = <&cpu0_opp_table>;
>> > +             };
>> > +
>> > +             idle-states {
>> > +                     entry-method = "psci";
>> > +
>> > +                     CPU_SLEEP: cpu-sleep {
>> > +                             compatible = "arm,idle-state";
>> > +                             local-timer-stop;
>> > +                             arm,psci-suspend-param = <0x0010000>;
>> > +                             entry-latency-us = <120>;
>> > +                             exit-latency-us = <250>;
>> > +                             min-residency-us = <900>;
>> > +                     };
>> > +             };
>> > +
>> > +             l2: l2-cache0 {
>> > +                     compatible = "cache";
>> > +                     cache-level = <2>;
>> > +                     cache-unified;
>> > +             };
>> > +     };
>> > +
>> > +     cpu0_opp_table: opp-table-0 {
>> > +             compatible = "operating-points-v2";
>> > +             opp-shared;
>> > +
>> > +             opp-408000000 {
>> > +                     opp-hz = /bits/ 64 <408000000>;
>> > +                     opp-microvolt = <950000>;
>> > +                     clock-latency-ns = <40000>;
>> > +                     opp-suspend;
>> > +             };
>> > +             opp-600000000 {
>> > +                     opp-hz = /bits/ 64 <600000000>;
>> > +                     opp-microvolt = <950000>;
>> > +                     clock-latency-ns = <40000>;
>> > +             };
>> > +             opp-816000000 {
>> > +                     opp-hz = /bits/ 64 <816000000>;
>> > +                     opp-microvolt = <1000000>;
>> > +                     clock-latency-ns = <40000>;
>> > +             };
>> > +             opp-1008000000 {
>> > +                     opp-hz = /bits/ 64 <1008000000>;
>> > +                     opp-microvolt = <1100000>;
>> > +                     clock-latency-ns = <40000>;
>> > +             };
>> > +             opp-1200000000 {
>> > +                     opp-hz = /bits/ 64 <1200000000>;
>> > +                     opp-microvolt = <1225000>;
>> > +                     clock-latency-ns = <40000>;
>> > +             };
>> > +             opp-1296000000 {
>> > +                     opp-hz = /bits/ 64 <1296000000>;
>> > +                     opp-microvolt = <1300000>;
>> > +                     clock-latency-ns = <40000>;
>> > +             };
>> > +     };
>> > +
>> > +     analog_sound: analog-sound {
>> > +             compatible = "simple-audio-card";
>> > +             simple-audio-card,format = "i2s";
>> > +             simple-audio-card,mclk-fs = <256>;
>> > +             simple-audio-card,name = "Analog";
>> > +             status = "disabled";
>> > +
>> > +             simple-audio-card,cpu {
>> > +                     sound-dai = <&i2s1>;
>> > +             };
>> > +
>> > +             simple-audio-card,codec {
>> > +                     sound-dai = <&codec>;
>> > +             };
>> > +     };
>> > +
>> > +     arm-pmu {
>> > +             compatible = "arm,cortex-a53-pmu";
>> > +             interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> > +             interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> > +     };
>> > +
>> > +     display_subsystem: display-subsystem {
>> > +             compatible = "rockchip,display-subsystem";
>> > +             ports = <&vop_out>;
>> > +     };
>> > +
>> > +     hdmi_sound: hdmi-sound {
>> > +             compatible = "simple-audio-card";
>> > +             simple-audio-card,format = "i2s";
>> > +             simple-audio-card,mclk-fs = <128>;
>> > +             simple-audio-card,name = "HDMI";
>> > +             status = "disabled";
>> > +
>> > +             simple-audio-card,cpu {
>> > +                     sound-dai = <&i2s0>;
>> > +             };
>> > +
>> > +             simple-audio-card,codec {
>> > +                     sound-dai = <&hdmi>;
>> > +             };
>> > +     };
>> > +
>> > +     psci {
>> > +             compatible = "arm,psci-1.0", "arm,psci-0.2";
>> > +             method = "smc";
>> > +     };
>> > +
>> > +     timer {
>> > +             compatible = "arm,armv8-timer";
>> > +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>> > IRQ_TYPE_LEVEL_LOW)>,
>> > +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> > +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> > +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> > +     };
>> > +
>> > +     xin24m: xin24m {
>> > +             compatible = "fixed-clock";
>> > +             #clock-cells = <0>;
>> > +             clock-frequency = <24000000>;
>> > +             clock-output-names = "xin24m";
>> > +     };
>> > +
>> > +     i2s0: i2s@ff000000 {
>> > +             compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
>> > +             reg = <0x0 0xff000000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
>> > +             clock-names = "i2s_clk", "i2s_hclk";
>> > +             dmas = <&dmac 11>, <&dmac 12>;
>> > +             dma-names = "tx", "rx";
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2s1: i2s@ff010000 {
>> > +             compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
>> > +             reg = <0x0 0xff010000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
>> > +             clock-names = "i2s_clk", "i2s_hclk";
>> > +             dmas = <&dmac 14>, <&dmac 15>;
>> > +             dma-names = "tx", "rx";
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2s2: i2s@ff020000 {
>> > +             compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
>> > +             reg = <0x0 0xff020000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
>> > +             clock-names = "i2s_clk", "i2s_hclk";
>> > +             dmas = <&dmac 0>, <&dmac 1>;
>> > +             dma-names = "tx", "rx";
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     spdif: spdif@ff030000 {
>> > +             compatible = "rockchip,rk3328-spdif";
>> > +             reg = <0x0 0xff030000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF_8CH>;
>> > +             clock-names = "mclk", "hclk";
>> > +             dmas = <&dmac 10>;
>> > +             dma-names = "tx";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&spdifm2_tx>;
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     pdm: pdm@ff040000 {
>> > +             compatible = "rockchip,pdm";
>> > +             reg = <0x0 0xff040000 0x0 0x1000>;
>> > +             clocks = <&cru SCLK_PDM>, <&cru HCLK_PDM>;
>> > +             clock-names = "pdm_clk", "pdm_hclk";
>> > +             dmas = <&dmac 16>;
>> > +             dma-names = "rx";
>> > +             pinctrl-names = "default", "sleep";
>> > +             pinctrl-0 = <&pdmm0_clk
>> > +                          &pdmm0_sdi0
>> > +                          &pdmm0_sdi1
>> > +                          &pdmm0_sdi2
>> > +                          &pdmm0_sdi3>;
>> > +             pinctrl-1 = <&pdmm0_clk_sleep
>> > +                          &pdmm0_sdi0_sleep
>> > +                          &pdmm0_sdi1_sleep
>> > +                          &pdmm0_sdi2_sleep
>> > +                          &pdmm0_sdi3_sleep>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     grf: syscon@ff100000 {
>> > +             compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>> > +             reg = <0x0 0xff100000 0x0 0x1000>;
>> > +
>> > +             io_domains: io-domains {
>> > +                     compatible = "rockchip,rk3328-io-voltage-domain";
>> > +                     status = "disabled";
>> > +             };
>> > +
>> > +             grf_gpio: gpio {
>> > +                     compatible = "rockchip,rk3328-grf-gpio";
>> > +                     gpio-controller;
>> > +                     #gpio-cells = <2>;
>> > +             };
>> > +
>> > +             power: power-controller {
>> > +                     compatible = "rockchip,rk3328-power-controller";
>> > +                     #power-domain-cells = <1>;
>> > +                     #address-cells = <1>;
>> > +                     #size-cells = <0>;
>> > +
>> > +                     power-domain@RK3328_PD_HEVC {
>> > +                             reg = <RK3328_PD_HEVC>;
>> > +                             #power-domain-cells = <0>;
>> > +                     };
>> > +                     power-domain@RK3328_PD_VIDEO {
>> > +                             reg = <RK3328_PD_VIDEO>;
>> > +                             clocks = <&cru ACLK_RKVDEC>,
>> > +                                      <&cru HCLK_RKVDEC>,
>> > +                                      <&cru SCLK_VDEC_CABAC>,
>> > +                                      <&cru SCLK_VDEC_CORE>;
>> > +                             #power-domain-cells = <0>;
>> > +                     };
>> > +                     power-domain@RK3328_PD_VPU {
>> > +                             reg = <RK3328_PD_VPU>;
>> > +                             clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
>> > +                             #power-domain-cells = <0>;
>> > +                     };
>> > +             };
>> > +
>> > +             reboot-mode {
>> > +                     compatible = "syscon-reboot-mode";
>> > +                     offset = <0x5c8>;
>> > +                     mode-normal = <BOOT_NORMAL>;
>> > +                     mode-recovery = <BOOT_RECOVERY>;
>> > +                     mode-bootloader = <BOOT_FASTBOOT>;
>> > +                     mode-loader = <BOOT_BL_DOWNLOAD>;
>> > +             };
>> > +     };
>> > +
>> > +     uart0: serial@ff110000 {
>> > +             compatible = "rockchip,rk3328-uart", "snps,dw-apb-uart";
>> > +             reg = <0x0 0xff110000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
>> > +             clock-names = "baudclk", "apb_pclk";
>> > +             dmas = <&dmac 2>, <&dmac 3>;
>> > +             dma-names = "tx", "rx";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>> > +             reg-io-width = <4>;
>> > +             reg-shift = <2>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     uart1: serial@ff120000 {
>> > +             compatible = "rockchip,rk3328-uart", "snps,dw-apb-uart";
>> > +             reg = <0x0 0xff120000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
>> > +             clock-names = "baudclk", "apb_pclk";
>> > +             dmas = <&dmac 4>, <&dmac 5>;
>> > +             dma-names = "tx", "rx";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&uart1_xfer &uart1_cts &uart1_rts>;
>> > +             reg-io-width = <4>;
>> > +             reg-shift = <2>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     uart2: serial@ff130000 {
>> > +             compatible = "rockchip,rk3328-uart", "snps,dw-apb-uart";
>> > +             reg = <0x0 0xff130000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
>> > +             clock-names = "baudclk", "apb_pclk";
>> > +             dmas = <&dmac 6>, <&dmac 7>;
>> > +             dma-names = "tx", "rx";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&uart2m1_xfer>;
>> > +             reg-io-width = <4>;
>> > +             reg-shift = <2>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2c0: i2c@ff150000 {
>> > +             compatible = "rockchip,rk3328-i2c", "rockchip,rk3399-i2c";
>> > +             reg = <0x0 0xff150000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +             clocks = <&cru SCLK_I2C0>, <&cru PCLK_I2C0>;
>> > +             clock-names = "i2c", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&i2c0_xfer>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2c1: i2c@ff160000 {
>> > +             compatible = "rockchip,rk3328-i2c", "rockchip,rk3399-i2c";
>> > +             reg = <0x0 0xff160000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +             clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
>> > +             clock-names = "i2c", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&i2c1_xfer>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2c2: i2c@ff170000 {
>> > +             compatible = "rockchip,rk3328-i2c", "rockchip,rk3399-i2c";
>> > +             reg = <0x0 0xff170000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +             clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
>> > +             clock-names = "i2c", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&i2c2_xfer>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     i2c3: i2c@ff180000 {
>> > +             compatible = "rockchip,rk3328-i2c", "rockchip,rk3399-i2c";
>> > +             reg = <0x0 0xff180000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +             clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
>> > +             clock-names = "i2c", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&i2c3_xfer>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     spi0: spi@ff190000 {
>> > +             compatible = "rockchip,rk3328-spi", "rockchip,rk3066-spi";
>> > +             reg = <0x0 0xff190000 0x0 0x1000>;
>> > +             interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <0>;
>> > +             clocks = <&cru SCLK_SPI>, <&cru PCLK_SPI>;
>> > +             clock-names = "spiclk", "apb_pclk";
>> > +             dmas = <&dmac 8>, <&dmac 9>;
>> > +             dma-names = "tx", "rx";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&spi0m2_clk &spi0m2_tx &spi0m2_rx &spi0m2_cs0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     wdt: watchdog@ff1a0000 {
>> > +             compatible = "rockchip,rk3328-wdt", "snps,dw-wdt";
>> > +             reg = <0x0 0xff1a0000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru PCLK_WDT>;
>> > +     };
>> > +
>> > +     pwm0: pwm@ff1b0000 {
>> > +             compatible = "rockchip,rk3328-pwm";
>> > +             reg = <0x0 0xff1b0000 0x0 0x10>;
>> > +             clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
>> > +             clock-names = "pwm", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&pwm0_pin>;
>> > +             #pwm-cells = <3>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     pwm1: pwm@ff1b0010 {
>> > +             compatible = "rockchip,rk3328-pwm";
>> > +             reg = <0x0 0xff1b0010 0x0 0x10>;
>> > +             clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
>> > +             clock-names = "pwm", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&pwm1_pin>;
>> > +             #pwm-cells = <3>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     pwm2: pwm@ff1b0020 {
>> > +             compatible = "rockchip,rk3328-pwm";
>> > +             reg = <0x0 0xff1b0020 0x0 0x10>;
>> > +             clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
>> > +             clock-names = "pwm", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&pwm2_pin>;
>> > +             #pwm-cells = <3>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     pwm3: pwm@ff1b0030 {
>> > +             compatible = "rockchip,rk3328-pwm";
>> > +             reg = <0x0 0xff1b0030 0x0 0x10>;
>> > +             clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
>> > +             clock-names = "pwm", "pclk";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&pwmir_pin>;
>> > +             #pwm-cells = <3>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     dmac: dma-controller@ff1f0000 {
>> > +             compatible = "arm,pl330", "arm,primecell";
>> > +             reg = <0x0 0xff1f0000 0x0 0x4000>;
>> > +             interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> > +             arm,pl330-periph-burst;
>> > +             clocks = <&cru ACLK_DMAC>;
>> > +             clock-names = "apb_pclk";
>> > +             #dma-cells = <1>;
>> > +     };
>> > +
>> > +     thermal-zones {
>> > +             soc_thermal: soc-thermal {
>> > +                     polling-delay-passive = <20>;
>> > +                     polling-delay = <1000>;
>> > +                     sustainable-power = <1000>;
>> > +
>> > +                     thermal-sensors = <&tsadc 0>;
>> > +
>> > +                     trips {
>> > +                             threshold: trip-point0 {
>> > +                                     temperature = <70000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             target: trip-point1 {
>> > +                                     temperature = <85000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "passive";
>> > +                             };
>> > +                             soc_crit: soc-crit {
>> > +                                     temperature = <95000>;
>> > +                                     hysteresis = <2000>;
>> > +                                     type = "critical";
>> > +                             };
>> > +                     };
>> > +
>> > +                     cooling-maps {
>> > +                             map0 {
>> > +                                     trip = <&target>;
>> > +                                     cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                                      <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                                      <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> > +                                                      <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > +                                     contribution = <4096>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +
>> > +     };
>> > +
>> > +     tsadc: tsadc@ff250000 {
>> > +             compatible = "rockchip,rk3328-tsadc";
>> > +             reg = <0x0 0xff250000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
>> > +             assigned-clocks = <&cru SCLK_TSADC>;
>> > +             assigned-clock-rates = <50000>;
>> > +             clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> > +             clock-names = "tsadc", "apb_pclk";
>> > +             pinctrl-names = "init", "default", "sleep";
>> > +             pinctrl-0 = <&otp_pin>;
>> > +             pinctrl-1 = <&otp_out>;
>> > +             pinctrl-2 = <&otp_pin>;
>> > +             resets = <&cru SRST_TSADC>;
>> > +             reset-names = "tsadc-apb";
>> > +             rockchip,grf = <&grf>;
>> > +             rockchip,hw-tshut-temp = <100000>;
>> > +             #thermal-sensor-cells = <1>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     efuse: efuse@ff260000 {
>> > +             compatible = "rockchip,rk3328-efuse";
>> > +             reg = <0x0 0xff260000 0x0 0x50>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <1>;
>> > +             clocks = <&cru SCLK_EFUSE>;
>> > +             clock-names = "pclk_efuse";
>> > +             rockchip,efuse-size = <0x20>;
>> > +
>> > +             /* Data cells */
>> > +             efuse_id: id@7 {
>> > +                     reg = <0x07 0x10>;
>> > +             };
>> > +             cpu_leakage: cpu-leakage@17 {
>> > +                     reg = <0x17 0x1>;
>> > +             };
>> > +             logic_leakage: logic-leakage@19 {
>> > +                     reg = <0x19 0x1>;
>> > +             };
>> > +             efuse_cpu_version: cpu-version@1a {
>> > +                     reg = <0x1a 0x1>;
>> > +                     bits = <3 3>;
>> > +             };
>> > +     };
>> > +
>> > +     saradc: adc@ff280000 {
>> > +             compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
>> > +             reg = <0x0 0xff280000 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>> > +             #io-channel-cells = <1>;
>> > +             clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>> > +             clock-names = "saradc", "apb_pclk";
>> > +             resets = <&cru SRST_SARADC_P>;
>> > +             reset-names = "saradc-apb";
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     gpu: gpu@ff300000 {
>> > +             compatible = "rockchip,rk3328-mali", "arm,mali-450";
>> > +             reg = <0x0 0xff300000 0x0 0x30000>;
>> > +             interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>> > +             interrupt-names = "gp",
>> > +                               "gpmmu",
>> > +                               "pp",
>> > +                               "pp0",
>> > +                               "ppmmu0",
>> > +                               "pp1",
>> > +                               "ppmmu1";
>> > +             clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
>> > +             clock-names = "bus", "core";
>> > +             resets = <&cru SRST_GPU_A>;
>> > +     };
>> > +
>> > +     h265e_mmu: iommu@ff330200 {
>> > +             compatible = "rockchip,iommu";
>> > +             reg = <0x0 0xff330200 0 0x100>;
>> > +             interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_H265>, <&cru PCLK_H265>;
>> > +             clock-names = "aclk", "iface";
>> > +             #iommu-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     vepu_mmu: iommu@ff340800 {
>> > +             compatible = "rockchip,iommu";
>> > +             reg = <0x0 0xff340800 0x0 0x40>;
>> > +             interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
>> > +             clock-names = "aclk", "iface";
>> > +             #iommu-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     vpu: video-codec@ff350000 {
>> > +             compatible = "rockchip,rk3328-vpu";
>> > +             reg = <0x0 0xff350000 0x0 0x800>;
>> > +             interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> > +             interrupt-names = "vdpu";
>> > +             clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
>> > +             clock-names = "aclk", "hclk";
>> > +             iommus = <&vpu_mmu>;
>> > +             power-domains = <&power RK3328_PD_VPU>;
>> > +     };
>> > +
>> > +     vpu_mmu: iommu@ff350800 {
>> > +             compatible = "rockchip,iommu";
>> > +             reg = <0x0 0xff350800 0x0 0x40>;
>> > +             interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
>> > +             clock-names = "aclk", "iface";
>> > +             #iommu-cells = <0>;
>> > +             power-domains = <&power RK3328_PD_VPU>;
>> > +     };
>> > +
>> > +     vdec: video-codec@ff360000 {
>> > +             compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
>> > +             reg = <0x0 0xff360000 0x0 0x480>;
>> > +             interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
>> > +                      <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
>> > +             clock-names = "axi", "ahb", "cabac", "core";
>> > +             assigned-clocks = <&cru ACLK_RKVDEC>, <&cru SCLK_VDEC_CABAC>,
>> > +                               <&cru SCLK_VDEC_CORE>;
>> > +             assigned-clock-rates = <400000000>, <400000000>, <300000000>;
>> > +             iommus = <&vdec_mmu>;
>> > +             power-domains = <&power RK3328_PD_VIDEO>;
>> > +     };
>> > +
>> > +     vdec_mmu: iommu@ff360480 {
>> > +             compatible = "rockchip,iommu";
>> > +             reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
>> > +             interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
>> > +             clock-names = "aclk", "iface";
>> > +             #iommu-cells = <0>;
>> > +             power-domains = <&power RK3328_PD_VIDEO>;
>> > +     };
>> > +
>> > +     vop: vop@ff370000 {
>> > +             compatible = "rockchip,rk3328-vop";
>> > +             reg = <0x0 0xff370000 0x0 0x3efc>;
>> > +             interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_VOP>, <&cru DCLK_LCDC>, <&cru HCLK_VOP>;
>> > +             clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
>> > +             resets = <&cru SRST_VOP_A>, <&cru SRST_VOP_H>, <&cru SRST_VOP_D>;
>> > +             reset-names = "axi", "ahb", "dclk";
>> > +             iommus = <&vop_mmu>;
>> > +             status = "disabled";
>> > +
>> > +             vop_out: port {
>> > +                     #address-cells = <1>;
>> > +                     #size-cells = <0>;
>> > +
>> > +                     vop_out_hdmi: endpoint@0 {
>> > +                             reg = <0>;
>> > +                             remote-endpoint = <&hdmi_in_vop>;
>> > +                     };
>> > +             };
>> > +     };
>> > +
>> > +     vop_mmu: iommu@ff373f00 {
>> > +             compatible = "rockchip,iommu";
>> > +             reg = <0x0 0xff373f00 0x0 0x100>;
>> > +             interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
>> > +             clock-names = "aclk", "iface";
>> > +             #iommu-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     hdmi: hdmi@ff3c0000 {
>> > +             compatible = "rockchip,rk3328-dw-hdmi";
>> > +             reg = <0x0 0xff3c0000 0x0 0x20000>;
>> > +             reg-io-width = <4>;
>> > +             interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
>> > +                          <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru PCLK_HDMI>,
>> > +                      <&cru SCLK_HDMI_SFC>,
>> > +                      <&cru SCLK_RTC32K>;
>> > +             clock-names = "iahb",
>> > +                           "isfr",
>> > +                           "cec";
>> > +             phys = <&hdmiphy>;
>> > +             phy-names = "hdmi";
>> > +             pinctrl-names = "default";
>> > +             pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
>> > +             rockchip,grf = <&grf>;
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +
>> > +             ports {
>> > +                     hdmi_in: port {
>> > +                             hdmi_in_vop: endpoint {
>> > +                                     remote-endpoint = <&vop_out_hdmi>;
>> > +                             };
>> > +                     };
>> > +             };
>> > +     };
>> > +
>> > +     codec: codec@ff410000 {
>> > +             compatible = "rockchip,rk3328-codec";
>> > +             reg = <0x0 0xff410000 0x0 0x1000>;
>> > +             clocks = <&cru PCLK_ACODECPHY>, <&cru SCLK_I2S1>;
>> > +             clock-names = "pclk", "mclk";
>> > +             rockchip,grf = <&grf>;
>> > +             #sound-dai-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     hdmiphy: phy@ff430000 {
>> > +             compatible = "rockchip,rk3328-hdmi-phy";
>> > +             reg = <0x0 0xff430000 0x0 0x10000>;
>> > +             interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru PCLK_HDMIPHY>, <&xin24m>, <&cru DCLK_HDMIPHY>;
>> > +             clock-names = "sysclk", "refoclk", "refpclk";
>> > +             clock-output-names = "hdmi_phy";
>> > +             #clock-cells = <0>;
>> > +             nvmem-cells = <&efuse_cpu_version>;
>> > +             nvmem-cell-names = "cpu-version";
>> > +             #phy-cells = <0>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     cru: clock-controller@ff440000 {
>> > +             compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
>> > +             reg = <0x0 0xff440000 0x0 0x1000>;
>> > +             rockchip,grf = <&grf>;
>> > +             #clock-cells = <1>;
>> > +             #reset-cells = <1>;
>> > +             assigned-clocks =
>> > +                     /*
>> > +                      * CPLL should run at 1200, but that is to high for
>> > +                      * the initial dividers of most of its children.
>> > +                      * We need set cpll child clk div first,
>> > +                      * and then set the cpll frequency.
>> > +                      */
>> > +                     <&cru DCLK_LCDC>, <&cru SCLK_PDM>,
>> > +                     <&cru SCLK_RTC32K>, <&cru SCLK_UART0>,
>> > +                     <&cru SCLK_UART1>, <&cru SCLK_UART2>,
>> > +                     <&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
>> > +                     <&cru ACLK_VIO_PRE>, <&cru ACLK_RGA_PRE>,
>> > +                     <&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
>> > +                     <&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
>> > +                     <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
>> > +                     <&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
>> > +                     <&cru SCLK_SDIO>, <&cru SCLK_TSP>,
>> > +                     <&cru SCLK_WIFI>, <&cru ARMCLK>,
>> > +                     <&cru PLL_GPLL>, <&cru PLL_CPLL>,
>> > +                     <&cru ACLK_BUS_PRE>, <&cru HCLK_BUS_PRE>,
>> > +                     <&cru PCLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
>> > +                     <&cru HCLK_PERI>, <&cru PCLK_PERI>,
>> > +                     <&cru SCLK_RTC32K>;
>> > +             assigned-clock-parents =
>> > +                     <&cru HDMIPHY>, <&cru PLL_APLL>,
>> > +                     <&cru PLL_GPLL>, <&xin24m>,
>> > +                     <&xin24m>, <&xin24m>;
>> > +             assigned-clock-rates =
>> > +                     <0>, <61440000>,
>> > +                     <0>, <24000000>,
>> > +                     <24000000>, <24000000>,
>> > +                     <15000000>, <15000000>,
>> > +                     <100000000>, <100000000>,
>> > +                     <100000000>, <100000000>,
>> > +                     <50000000>, <100000000>,
>> > +                     <100000000>, <100000000>,
>> > +                     <50000000>, <50000000>,
>> > +                     <50000000>, <50000000>,
>> > +                     <24000000>, <600000000>,
>> > +                     <491520000>, <1200000000>,
>> > +                     <150000000>, <75000000>,
>> > +                     <75000000>, <150000000>,
>> > +                     <75000000>, <75000000>,
>> > +                     <32768>;
>> > +     };
>> > +
>> > +     usb2phy_grf: syscon@ff450000 {
>> > +             compatible = "rockchip,rk3328-usb2phy-grf", "syscon",
>> > +                          "simple-mfd";
>> > +             reg = <0x0 0xff450000 0x0 0x10000>;
>> > +             #address-cells = <1>;
>> > +             #size-cells = <1>;
>> > +
>> > +             u2phy: usb2phy@100 {
>> > +                     compatible = "rockchip,rk3328-usb2phy";
>> > +                     reg = <0x100 0x10>;
>> > +                     clocks = <&xin24m>;
>> > +                     clock-names = "phyclk";
>> > +                     clock-output-names = "usb480m_phy";
>> > +                     #clock-cells = <0>;
>> > +                     assigned-clocks = <&cru USB480M>;
>> > +                     assigned-clock-parents = <&u2phy>;
>> > +                     status = "disabled";
>> > +
>> > +                     u2phy_otg: otg-port {
>> > +                             #phy-cells = <0>;
>> > +                             interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>> > +                                          <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>> > +                                          <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>> > +                             interrupt-names = "otg-bvalid", "otg-id",
>> > +                                               "linestate";
>> > +                             status = "disabled";
>> > +                     };
>> > +
>> > +                     u2phy_host: host-port {
>> > +                             #phy-cells = <0>;
>> > +                             interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> > +                             interrupt-names = "linestate";
>> > +                             status = "disabled";
>> > +                     };
>> > +             };
>> > +     };
>> > +
>> > +     sdmmc: mmc@ff500000 {
>> > +             compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
>> > +             reg = <0x0 0xff500000 0x0 0x4000>;
>> > +             interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>> > +                      <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>> > +             clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> > +             fifo-depth = <0x100>;
>> > +             max-frequency = <150000000>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     sdio: mmc@ff510000 {
>> > +             compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
>> > +             reg = <0x0 0xff510000 0x0 0x4000>;
>> > +             interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>> > +                      <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>> > +             clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> > +             fifo-depth = <0x100>;
>> > +             max-frequency = <150000000>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     emmc: mmc@ff520000 {
>> > +             compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
>> > +             reg = <0x0 0xff520000 0x0 0x4000>;
>> > +             interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>> > +                      <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>> > +             clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> > +             fifo-depth = <0x100>;
>> > +             max-frequency = <150000000>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     gmac2io: ethernet@ff540000 {
>> > +             compatible = "rockchip,rk3328-gmac";
>> > +             reg = <0x0 0xff540000 0x0 0x10000>;
>> > +             interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> > +             interrupt-names = "macirq";
>> > +             clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_RX>,
>> > +                      <&cru SCLK_MAC2IO_TX>, <&cru SCLK_MAC2IO_REF>,
>> > +                      <&cru SCLK_MAC2IO_REFOUT>, <&cru ACLK_MAC2IO>,
>> > +                      <&cru PCLK_MAC2IO>;
>> > +             clock-names = "stmmaceth", "mac_clk_rx",
>> > +                           "mac_clk_tx", "clk_mac_ref",
>> > +                           "clk_mac_refout", "aclk_mac",
>> > +                           "pclk_mac";
>> > +             resets = <&cru SRST_GMAC2IO_A>;
>> > +             reset-names = "stmmaceth";
>> > +             rockchip,grf = <&grf>;
>> > +             tx-fifo-depth = <2048>;
>> > +             rx-fifo-depth = <4096>;
>> > +             snps,txpbl = <0x4>;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     gmac2phy: ethernet@ff550000 {
>> > +             compatible = "rockchip,rk3328-gmac";
>> > +             reg = <0x0 0xff550000 0x0 0x10000>;
>> > +             rockchip,grf = <&grf>;
>> > +             interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> > +             interrupt-names = "macirq";
>> > +             clocks = <&cru SCLK_MAC2PHY_SRC>, <&cru SCLK_MAC2PHY_RXTX>,
>> > +                      <&cru SCLK_MAC2PHY_RXTX>, <&cru SCLK_MAC2PHY_REF>,
>> > +                      <&cru ACLK_MAC2PHY>, <&cru PCLK_MAC2PHY>,
>> > +                      <&cru SCLK_MAC2PHY_OUT>;
>> > +             clock-names = "stmmaceth", "mac_clk_rx",
>> > +                           "mac_clk_tx", "clk_mac_ref",
>> > +                           "aclk_mac", "pclk_mac",
>> > +                           "clk_macphy";
>> > +             resets = <&cru SRST_GMAC2PHY_A>;
>> > +             reset-names = "stmmaceth";
>> > +             phy-mode = "rmii";
>> > +             phy-handle = <&phy>;
>> > +             tx-fifo-depth = <2048>;
>> > +             rx-fifo-depth = <4096>;
>> > +             snps,txpbl = <0x4>;
>> > +             clock_in_out = "output";
>> > +             status = "disabled";
>> > +
>> > +             mdio {
>> > +                     compatible = "snps,dwmac-mdio";
>> > +                     #address-cells = <1>;
>> > +                     #size-cells = <0>;
>> > +
>> > +                     phy: ethernet-phy@0 {
>> > +                             compatible = "ethernet-phy-id1234.d400",
>> > "ethernet-phy-ieee802.3-c22";
>> > +                             reg = <0>;
>> > +                             clocks = <&cru SCLK_MAC2PHY_OUT>;
>> > +                             resets = <&cru SRST_MACPHY>;
>> > +                             pinctrl-names = "default";
>> > +                             pinctrl-0 = <&fephyled_rxm1 &fephyled_linkm1>;
>> > +                             phy-is-integrated;
>> > +                     };
>> > +             };
>> > +     };
>> > +
>> > +     usb20_otg: usb@ff580000 {
>> > +             compatible = "rockchip,rk3328-usb", "rockchip,rk3066-usb",
>> > +                          "snps,dwc2";
>> > +             reg = <0x0 0xff580000 0x0 0x40000>;
>> > +             interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_OTG>;
>> > +             clock-names = "otg";
>> > +             dr_mode = "otg";
>> > +             g-np-tx-fifo-size = <16>;
>> > +             g-rx-fifo-size = <280>;
>> > +             g-tx-fifo-size = <256 128 128 64 32 16>;
>> > +             phys = <&u2phy_otg>;
>> > +             phy-names = "usb2-phy";
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     usb_host0_ehci: usb@ff5c0000 {
>> > +             compatible = "generic-ehci";
>> > +             reg = <0x0 0xff5c0000 0x0 0x10000>;
>> > +             interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_HOST0>, <&u2phy>;
>> > +             phys = <&u2phy_host>;
>> > +             phy-names = "usb";
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     usb_host0_ohci: usb@ff5d0000 {
>> > +             compatible = "generic-ohci";
>> > +             reg = <0x0 0xff5d0000 0x0 0x10000>;
>> > +             interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_HOST0>, <&u2phy>;
>> > +             phys = <&u2phy_host>;
>> > +             phy-names = "usb";
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     usbdrd3: usb@ff600000 {
>> > +             compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
>> > +             reg = <0x0 0xff600000 0x0 0x100000>;
>> > +             interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
>> > +                      <&cru ACLK_USB3OTG>;
>> > +             clock-names = "ref_clk", "suspend_clk",
>> > +                           "bus_clk";
>> > +             dr_mode = "otg";
>> > +             phy_type = "utmi_wide";
>> > +             snps,dis-del-phy-power-chg-quirk;
>> > +             snps,dis_enblslpm_quirk;
>> > +             snps,dis-tx-ipgap-linecheck-quirk;
>> > +             snps,dis-u2-freeclk-exists-quirk;
>> > +             snps,dis_u2_susphy_quirk;
>> > +             snps,dis_u3_susphy_quirk;
>> > +             status = "disabled";
>> > +     };
>> > +
>> > +     gic: interrupt-controller@ff811000 {
>> > +             compatible = "arm,gic-400";
>> > +             #interrupt-cells = <3>;
>> > +             #address-cells = <0>;
>> > +             interrupt-controller;
>> > +             reg = <0x0 0xff811000 0 0x1000>,
>> > +                   <0x0 0xff812000 0 0x2000>,
>> > +                   <0x0 0xff814000 0 0x2000>,
>> > +                   <0x0 0xff816000 0 0x2000>;
>> > +             interrupts = <GIC_PPI 9
>> > +                   (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> > +     };
>> > +
>> > +     crypto: crypto@ff060000 {
>> > +             compatible = "rockchip,rk3328-crypto";
>> > +             reg = <0x0 0xff060000 0x0 0x4000>;
>> > +             interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> > +             clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
>> > +                      <&cru SCLK_CRYPTO>;
>> > +             clock-names = "hclk_master", "hclk_slave", "sclk";
>> > +             resets = <&cru SRST_CRYPTO>;
>> > +             reset-names = "crypto-rst";
>> > +     };
>> > +
>> > +     pinctrl: pinctrl {
>> > +             compatible = "rockchip,rk3328-pinctrl";
>> > +             rockchip,grf = <&grf>;
>> > +             #address-cells = <2>;
>> > +             #size-cells = <2>;
>> > +             ranges;
>> > +
>> > +             gpio0: gpio@ff210000 {
>> > +                     compatible = "rockchip,gpio-bank";
>> > +                     reg = <0x0 0xff210000 0x0 0x100>;
>> > +                     interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> > +                     clocks = <&cru PCLK_GPIO0>;
>> > +
>> > +                     gpio-controller;
>> > +                     #gpio-cells = <2>;
>> > +
>> > +                     interrupt-controller;
>> > +                     #interrupt-cells = <2>;
>> > +             };
>> > +
>> > +             gpio1: gpio@ff220000 {
>> > +                     compatible = "rockchip,gpio-bank";
>> > +                     reg = <0x0 0xff220000 0x0 0x100>;
>> > +                     interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> > +                     clocks = <&cru PCLK_GPIO1>;
>> > +
>> > +                     gpio-controller;
>> > +                     #gpio-cells = <2>;
>> > +
>> > +                     interrupt-controller;
>> > +                     #interrupt-cells = <2>;
>> > +             };
>> > +
>> > +             gpio2: gpio@ff230000 {
>> > +                     compatible = "rockchip,gpio-bank";
>> > +                     reg = <0x0 0xff230000 0x0 0x100>;
>> > +                     interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>> > +                     clocks = <&cru PCLK_GPIO2>;
>> > +
>> > +                     gpio-controller;
>> > +                     #gpio-cells = <2>;
>> > +
>> > +                     interrupt-controller;
>> > +                     #interrupt-cells = <2>;
>> > +             };
>> > +
>> > +             gpio3: gpio@ff240000 {
>> > +                     compatible = "rockchip,gpio-bank";
>> > +                     reg = <0x0 0xff240000 0x0 0x100>;
>> > +                     interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>> > +                     clocks = <&cru PCLK_GPIO3>;
>> > +
>> > +                     gpio-controller;
>> > +                     #gpio-cells = <2>;
>> > +
>> > +                     interrupt-controller;
>> > +                     #interrupt-cells = <2>;
>> > +             };
>> > +
>> > +             pcfg_pull_up: pcfg-pull-up {
>> > +                     bias-pull-up;
>> > +             };
>> > +
>> > +             pcfg_pull_down: pcfg-pull-down {
>> > +                     bias-pull-down;
>> > +             };
>> > +
>> > +             pcfg_pull_none: pcfg-pull-none {
>> > +                     bias-disable;
>> > +             };
>> > +
>> > +             pcfg_pull_none_2ma: pcfg-pull-none-2ma {
>> > +                     bias-disable;
>> > +                     drive-strength = <2>;
>> > +             };
>> > +
>> > +             pcfg_pull_up_2ma: pcfg-pull-up-2ma {
>> > +                     bias-pull-up;
>> > +                     drive-strength = <2>;
>> > +             };
>> > +
>> > +             pcfg_pull_up_4ma: pcfg-pull-up-4ma {
>> > +                     bias-pull-up;
>> > +                     drive-strength = <4>;
>> > +             };
>> > +
>> > +             pcfg_pull_none_4ma: pcfg-pull-none-4ma {
>> > +                     bias-disable;
>> > +                     drive-strength = <4>;
>> > +             };
>> > +
>> > +             pcfg_pull_down_4ma: pcfg-pull-down-4ma {
>> > +                     bias-pull-down;
>> > +                     drive-strength = <4>;
>> > +             };
>> > +
>> > +             pcfg_pull_none_8ma: pcfg-pull-none-8ma {
>> > +                     bias-disable;
>> > +                     drive-strength = <8>;
>> > +             };
>> > +
>> > +             pcfg_pull_up_8ma: pcfg-pull-up-8ma {
>> > +                     bias-pull-up;
>> > +                     drive-strength = <8>;
>> > +             };
>> > +
>> > +             pcfg_pull_none_12ma: pcfg-pull-none-12ma {
>> > +                     bias-disable;
>> > +                     drive-strength = <12>;
>> > +             };
>> > +
>> > +             pcfg_pull_up_12ma: pcfg-pull-up-12ma {
>> > +                     bias-pull-up;
>> > +                     drive-strength = <12>;
>> > +             };
>> > +
>> > +             pcfg_output_high: pcfg-output-high {
>> > +                     output-high;
>> > +             };
>> > +
>> > +             pcfg_output_low: pcfg-output-low {
>> > +                     output-low;
>> > +             };
>> > +
>> > +             pcfg_input_high: pcfg-input-high {
>> > +                     bias-pull-up;
>> > +                     input-enable;
>> > +             };
>> > +
>> > +             pcfg_input: pcfg-input {
>> > +                     input-enable;
>> > +             };
>> > +
>> > +             i2c0 {
>> > +                     i2c0_xfer: i2c0-xfer {
>> > +                             rockchip,pins = <2 RK_PD0 1 &pcfg_pull_none>,
>> > +                                             <2 RK_PD1 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2c1 {
>> > +                     i2c1_xfer: i2c1-xfer {
>> > +                             rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>,
>> > +                                             <2 RK_PA5 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2c2 {
>> > +                     i2c2_xfer: i2c2-xfer {
>> > +                             rockchip,pins = <2 RK_PB5 1 &pcfg_pull_none>,
>> > +                                             <2 RK_PB6 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2c3 {
>> > +                     i2c3_xfer: i2c3-xfer {
>> > +                             rockchip,pins = <0 RK_PA5 2 &pcfg_pull_none>,
>> > +                                             <0 RK_PA6 2 &pcfg_pull_none>;
>> > +                     };
>> > +                     i2c3_pins: i2c3-pins {
>> > +                             rockchip,pins =
>> > +                                     <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>,
>> > +                                     <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             hdmi_i2c {
>> > +                     hdmii2c_xfer: hdmii2c-xfer {
>> > +                             rockchip,pins = <0 RK_PA5 1 &pcfg_pull_none>,
>> > +                                             <0 RK_PA6 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             pdm-0 {
>> > +                     pdmm0_clk: pdmm0-clk {
>> > +                             rockchip,pins = <2 RK_PC2 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_fsync: pdmm0-fsync {
>> > +                             rockchip,pins = <2 RK_PC7 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi0: pdmm0-sdi0 {
>> > +                             rockchip,pins = <2 RK_PC3 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi1: pdmm0-sdi1 {
>> > +                             rockchip,pins = <2 RK_PC4 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi2: pdmm0-sdi2 {
>> > +                             rockchip,pins = <2 RK_PC5 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi3: pdmm0-sdi3 {
>> > +                             rockchip,pins = <2 RK_PC6 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     pdmm0_clk_sleep: pdmm0-clk-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC2 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi0_sleep: pdmm0-sdi0-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC3 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi1_sleep: pdmm0-sdi1-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC4 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi2_sleep: pdmm0-sdi2-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +
>> > +                     pdmm0_sdi3_sleep: pdmm0-sdi3-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC6 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +
>> > +                     pdmm0_fsync_sleep: pdmm0-fsync-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PC7 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +             };
>> > +
>> > +             tsadc {
>> > +                     otp_pin: otp-pin {
>> > +                             rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     otp_out: otp-out {
>> > +                             rockchip,pins = <2 RK_PB5 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             uart0 {
>> > +                     uart0_xfer: uart0-xfer {
>> > +                             rockchip,pins = <1 RK_PB1 1 &pcfg_pull_none>,
>> > +                                             <1 RK_PB0 1 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     uart0_cts: uart0-cts {
>> > +                             rockchip,pins = <1 RK_PB3 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     uart0_rts: uart0-rts {
>> > +                             rockchip,pins = <1 RK_PB2 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     uart0_rts_pin: uart0-rts-pin {
>> > +                             rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             uart1 {
>> > +                     uart1_xfer: uart1-xfer {
>> > +                             rockchip,pins = <3 RK_PA4 4 &pcfg_pull_none>,
>> > +                                             <3 RK_PA6 4 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     uart1_cts: uart1-cts {
>> > +                             rockchip,pins = <3 RK_PA7 4 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     uart1_rts: uart1-rts {
>> > +                             rockchip,pins = <3 RK_PA5 4 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     uart1_rts_pin: uart1-rts-pin {
>> > +                             rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             uart2-0 {
>> > +                     uart2m0_xfer: uart2m0-xfer {
>> > +                             rockchip,pins = <1 RK_PA0 2 &pcfg_pull_none>,
>> > +                                             <1 RK_PA1 2 &pcfg_pull_up>;
>> > +                     };
>> > +             };
>> > +
>> > +             uart2-1 {
>> > +                     uart2m1_xfer: uart2m1-xfer {
>> > +                             rockchip,pins = <2 RK_PA0 1 &pcfg_pull_none>,
>> > +                                             <2 RK_PA1 1 &pcfg_pull_up>;
>> > +                     };
>> > +             };
>> > +
>> > +             spi0-0 {
>> > +                     spi0m0_clk: spi0m0-clk {
>> > +                             rockchip,pins = <2 RK_PB0 1 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m0_cs0: spi0m0-cs0 {
>> > +                             rockchip,pins = <2 RK_PB3 1 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m0_tx: spi0m0-tx {
>> > +                             rockchip,pins = <2 RK_PB1 1 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m0_rx: spi0m0-rx {
>> > +                             rockchip,pins = <2 RK_PB2 1 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m0_cs1: spi0m0-cs1 {
>> > +                             rockchip,pins = <2 RK_PB4 1 &pcfg_pull_up>;
>> > +                     };
>> > +             };
>> > +
>> > +             spi0-1 {
>> > +                     spi0m1_clk: spi0m1-clk {
>> > +                             rockchip,pins = <3 RK_PC7 2 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m1_cs0: spi0m1-cs0 {
>> > +                             rockchip,pins = <3 RK_PD2 2 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m1_tx: spi0m1-tx {
>> > +                             rockchip,pins = <3 RK_PD1 2 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m1_rx: spi0m1-rx {
>> > +                             rockchip,pins = <3 RK_PD0 2 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m1_cs1: spi0m1-cs1 {
>> > +                             rockchip,pins = <3 RK_PD3 2 &pcfg_pull_up>;
>> > +                     };
>> > +             };
>> > +
>> > +             spi0-2 {
>> > +                     spi0m2_clk: spi0m2-clk {
>> > +                             rockchip,pins = <3 RK_PA0 4 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m2_cs0: spi0m2-cs0 {
>> > +                             rockchip,pins = <3 RK_PB0 3 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m2_tx: spi0m2-tx {
>> > +                             rockchip,pins = <3 RK_PA1 4 &pcfg_pull_up>;
>> > +                     };
>> > +
>> > +                     spi0m2_rx: spi0m2-rx {
>> > +                             rockchip,pins = <3 RK_PA2 4 &pcfg_pull_up>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2s1 {
>> > +                     i2s1_mclk: i2s1-mclk {
>> > +                             rockchip,pins = <2 RK_PB7 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sclk: i2s1-sclk {
>> > +                             rockchip,pins = <2 RK_PC2 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_lrckrx: i2s1-lrckrx {
>> > +                             rockchip,pins = <2 RK_PC0 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_lrcktx: i2s1-lrcktx {
>> > +                             rockchip,pins = <2 RK_PC1 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sdi: i2s1-sdi {
>> > +                             rockchip,pins = <2 RK_PC3 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sdo: i2s1-sdo {
>> > +                             rockchip,pins = <2 RK_PC7 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sdio1: i2s1-sdio1 {
>> > +                             rockchip,pins = <2 RK_PC4 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sdio2: i2s1-sdio2 {
>> > +                             rockchip,pins = <2 RK_PC5 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sdio3: i2s1-sdio3 {
>> > +                             rockchip,pins = <2 RK_PC6 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s1_sleep: i2s1-sleep {
>> > +                             rockchip,pins =
>> > +                                     <2 RK_PB7 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC0 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC1 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC2 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC3 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC4 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC6 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <2 RK_PC7 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2s2-0 {
>> > +                     i2s2m0_mclk: i2s2m0-mclk {
>> > +                             rockchip,pins = <1 RK_PC5 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_sclk: i2s2m0-sclk {
>> > +                             rockchip,pins = <1 RK_PC6 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_lrckrx: i2s2m0-lrckrx {
>> > +                             rockchip,pins = <1 RK_PD2 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_lrcktx: i2s2m0-lrcktx {
>> > +                             rockchip,pins = <1 RK_PC7 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_sdi: i2s2m0-sdi {
>> > +                             rockchip,pins = <1 RK_PD0 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_sdo: i2s2m0-sdo {
>> > +                             rockchip,pins = <1 RK_PD1 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m0_sleep: i2s2m0-sleep {
>> > +                             rockchip,pins =
>> > +                                     <1 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <1 RK_PC6 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <1 RK_PD2 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <1 RK_PC7 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <1 RK_PD0 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <1 RK_PD1 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +             };
>> > +
>> > +             i2s2-1 {
>> > +                     i2s2m1_mclk: i2s2m1-mclk {
>> > +                             rockchip,pins = <1 RK_PC5 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_sclk: i2s2m1-sclk {
>> > +                             rockchip,pins = <3 RK_PA0 6 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_lrckrx: i2sm1-lrckrx {
>> > +                             rockchip,pins = <3 RK_PB0 6 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_lrcktx: i2s2m1-lrcktx {
>> > +                             rockchip,pins = <3 RK_PB0 4 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_sdi: i2s2m1-sdi {
>> > +                             rockchip,pins = <3 RK_PA2 6 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_sdo: i2s2m1-sdo {
>> > +                             rockchip,pins = <3 RK_PA1 6 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     i2s2m1_sleep: i2s2m1-sleep {
>> > +                             rockchip,pins =
>> > +                                     <1 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <3 RK_PA0 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <3 RK_PB0 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <3 RK_PA2 RK_FUNC_GPIO &pcfg_input_high>,
>> > +                                     <3 RK_PA1 RK_FUNC_GPIO &pcfg_input_high>;
>> > +                     };
>> > +             };
>> > +
>> > +             spdif-0 {
>> > +                     spdifm0_tx: spdifm0-tx {
>> > +                             rockchip,pins = <0 RK_PD3 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             spdif-1 {
>> > +                     spdifm1_tx: spdifm1-tx {
>> > +                             rockchip,pins = <2 RK_PC1 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             spdif-2 {
>> > +                     spdifm2_tx: spdifm2-tx {
>> > +                             rockchip,pins = <0 RK_PA2 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             sdmmc0-0 {
>> > +                     sdmmc0m0_pwren: sdmmc0m0-pwren {
>> > +                             rockchip,pins = <2 RK_PA7 1 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0m0_pin: sdmmc0m0-pin {
>> > +                             rockchip,pins = <2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             sdmmc0-1 {
>> > +                     sdmmc0m1_pwren: sdmmc0m1-pwren {
>> > +                             rockchip,pins = <0 RK_PD6 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0m1_pin: sdmmc0m1-pin {
>> > +                             rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             sdmmc0 {
>> > +                     sdmmc0_clk: sdmmc0-clk {
>> > +                             rockchip,pins = <1 RK_PA6 1 &pcfg_pull_none_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_cmd: sdmmc0-cmd {
>> > +                             rockchip,pins = <1 RK_PA4 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_dectn: sdmmc0-dectn {
>> > +                             rockchip,pins = <1 RK_PA5 1 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_wrprt: sdmmc0-wrprt {
>> > +                             rockchip,pins = <1 RK_PA7 1 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_bus1: sdmmc0-bus1 {
>> > +                             rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_bus4: sdmmc0-bus4 {
>> > +                             rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PA1 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PA2 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PA3 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0_pins: sdmmc0-pins {
>> > +                             rockchip,pins =
>> > +                                     <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             sdmmc0ext {
>> > +                     sdmmc0ext_clk: sdmmc0ext-clk {
>> > +                             rockchip,pins = <3 RK_PA2 3 &pcfg_pull_none_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_cmd: sdmmc0ext-cmd {
>> > +                             rockchip,pins = <3 RK_PA0 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_wrprt: sdmmc0ext-wrprt {
>> > +                             rockchip,pins = <3 RK_PA3 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_dectn: sdmmc0ext-dectn {
>> > +                             rockchip,pins = <3 RK_PA1 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_bus1: sdmmc0ext-bus1 {
>> > +                             rockchip,pins = <3 RK_PA4 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_bus4: sdmmc0ext-bus4 {
>> > +                             rockchip,pins =
>> > +                                     <3 RK_PA4 3 &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA5 3 &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA6 3 &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA7 3 &pcfg_pull_up_4ma>;
>> > +                     };
>> > +
>> > +                     sdmmc0ext_pins: sdmmc0ext-pins {
>> > +                             rockchip,pins =
>> > +                                     <3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             sdmmc1 {
>> > +                     sdmmc1_clk: sdmmc1-clk {
>> > +                             rockchip,pins = <1 RK_PB4 1 &pcfg_pull_none_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_cmd: sdmmc1-cmd {
>> > +                             rockchip,pins = <1 RK_PB5 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_pwren: sdmmc1-pwren {
>> > +                             rockchip,pins = <1 RK_PC2 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_wrprt: sdmmc1-wrprt {
>> > +                             rockchip,pins = <1 RK_PC4 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_dectn: sdmmc1-dectn {
>> > +                             rockchip,pins = <1 RK_PC3 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_bus1: sdmmc1-bus1 {
>> > +                             rockchip,pins = <1 RK_PB6 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_bus4: sdmmc1-bus4 {
>> > +                             rockchip,pins = <1 RK_PB6 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PB7 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PC0 1 &pcfg_pull_up_8ma>,
>> > +                                             <1 RK_PC1 1 &pcfg_pull_up_8ma>;
>> > +                     };
>> > +
>> > +                     sdmmc1_pins: sdmmc1-pins {
>> > +                             rockchip,pins =
>> > +                                     <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
>> > +                                     <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             emmc {
>> > +                     emmc_clk: emmc-clk {
>> > +                             rockchip,pins = <3 RK_PC5 2 &pcfg_pull_none_12ma>;
>> > +                     };
>> > +
>> > +                     emmc_cmd: emmc-cmd {
>> > +                             rockchip,pins = <3 RK_PC3 2 &pcfg_pull_up_12ma>;
>> > +                     };
>> > +
>> > +                     emmc_pwren: emmc-pwren {
>> > +                             rockchip,pins = <3 RK_PC6 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     emmc_rstnout: emmc-rstnout {
>> > +                             rockchip,pins = <3 RK_PC4 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     emmc_bus1: emmc-bus1 {
>> > +                             rockchip,pins = <0 RK_PA7 2 &pcfg_pull_up_12ma>;
>> > +                     };
>> > +
>> > +                     emmc_bus4: emmc-bus4 {
>> > +                             rockchip,pins =
>> > +                                     <0 RK_PA7 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD4 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD5 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD6 2 &pcfg_pull_up_12ma>;
>> > +                     };
>> > +
>> > +                     emmc_bus8: emmc-bus8 {
>> > +                             rockchip,pins =
>> > +                                     <0 RK_PA7 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD4 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD5 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD6 2 &pcfg_pull_up_12ma>,
>> > +                                     <2 RK_PD7 2 &pcfg_pull_up_12ma>,
>> > +                                     <3 RK_PC0 2 &pcfg_pull_up_12ma>,
>> > +                                     <3 RK_PC1 2 &pcfg_pull_up_12ma>,
>> > +                                     <3 RK_PC2 2 &pcfg_pull_up_12ma>;
>> > +                     };
>> > +             };
>> > +
>> > +             pwm0 {
>> > +                     pwm0_pin: pwm0-pin {
>> > +                             rockchip,pins = <2 RK_PA4 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             pwm1 {
>> > +                     pwm1_pin: pwm1-pin {
>> > +                             rockchip,pins = <2 RK_PA5 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             pwm2 {
>> > +                     pwm2_pin: pwm2-pin {
>> > +                             rockchip,pins = <2 RK_PA6 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             pwmir {
>> > +                     pwmir_pin: pwmir-pin {
>> > +                             rockchip,pins = <2 RK_PA2 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             gmac-1 {
>> > +                     rgmiim1_pins: rgmiim1-pins {
>> > +                             rockchip,pins =
>> > +                                     /* mac_txclk */
>> > +                                     <1 RK_PB4 2 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_rxclk */
>> > +                                     <1 RK_PB5 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_mdio */
>> > +                                     <1 RK_PC3 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_txen */
>> > +                                     <1 RK_PD1 2 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_clk */
>> > +                                     <1 RK_PC5 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_rxdv */
>> > +                                     <1 RK_PC6 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_mdc */
>> > +                                     <1 RK_PC7 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_rxd1 */
>> > +                                     <1 RK_PB2 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_rxd0 */
>> > +                                     <1 RK_PB3 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_txd1 */
>> > +                                     <1 RK_PB0 2 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txd0 */
>> > +                                     <1 RK_PB1 2 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_rxd3 */
>> > +                                     <1 RK_PB6 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_rxd2 */
>> > +                                     <1 RK_PB7 2 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_txd3 */
>> > +                                     <1 RK_PC0 2 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txd2 */
>> > +                                     <1 RK_PC1 2 &pcfg_pull_none_8ma>,
>> > +
>> > +                                     /* mac_txclk */
>> > +                                     <0 RK_PB0 1 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txen */
>> > +                                     <0 RK_PB4 1 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_clk */
>> > +                                     <0 RK_PD0 1 &pcfg_pull_none_4ma>,
>> > +                                     /* mac_txd1 */
>> > +                                     <0 RK_PC0 1 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txd0 */
>> > +                                     <0 RK_PC1 1 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txd3 */
>> > +                                     <0 RK_PC7 1 &pcfg_pull_none_8ma>,
>> > +                                     /* mac_txd2 */
>> > +                                     <0 RK_PC6 1 &pcfg_pull_none_8ma>;
>> > +                     };
>> > +
>> > +                     rmiim1_pins: rmiim1-pins {
>> > +                             rockchip,pins =
>> > +                                     /* mac_mdio */
>> > +                                     <1 RK_PC3 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_txen */
>> > +                                     <1 RK_PD1 2 &pcfg_pull_none_12ma>,
>> > +                                     /* mac_clk */
>> > +                                     <1 RK_PC5 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_rxer */
>> > +                                     <1 RK_PD0 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_rxdv */
>> > +                                     <1 RK_PC6 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_mdc */
>> > +                                     <1 RK_PC7 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_rxd1 */
>> > +                                     <1 RK_PB2 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_rxd0 */
>> > +                                     <1 RK_PB3 2 &pcfg_pull_none_2ma>,
>> > +                                     /* mac_txd1 */
>> > +                                     <1 RK_PB0 2 &pcfg_pull_none_12ma>,
>> > +                                     /* mac_txd0 */
>> > +                                     <1 RK_PB1 2 &pcfg_pull_none_12ma>,
>> > +
>> > +                                     /* mac_mdio */
>> > +                                     <0 RK_PB3 1 &pcfg_pull_none>,
>> > +                                     /* mac_txen */
>> > +                                     <0 RK_PB4 1 &pcfg_pull_none>,
>> > +                                     /* mac_clk */
>> > +                                     <0 RK_PD0 1 &pcfg_pull_none>,
>> > +                                     /* mac_mdc */
>> > +                                     <0 RK_PC3 1 &pcfg_pull_none>,
>> > +                                     /* mac_txd1 */
>> > +                                     <0 RK_PC0 1 &pcfg_pull_none>,
>> > +                                     /* mac_txd0 */
>> > +                                     <0 RK_PC1 1 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             gmac2phy {
>> > +                     fephyled_speed10: fephyled-speed10 {
>> > +                             rockchip,pins = <0 RK_PD6 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     fephyled_duplex: fephyled-duplex {
>> > +                             rockchip,pins = <0 RK_PD6 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     fephyled_rxm1: fephyled-rxm1 {
>> > +                             rockchip,pins = <2 RK_PD1 2 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     fephyled_txm1: fephyled-txm1 {
>> > +                             rockchip,pins = <2 RK_PD1 3 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     fephyled_linkm1: fephyled-linkm1 {
>> > +                             rockchip,pins = <2 RK_PD0 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             tsadc_pin {
>> > +                     tsadc_int: tsadc-int {
>> > +                             rockchip,pins = <2 RK_PB5 2 &pcfg_pull_none>;
>> > +                     };
>> > +                     tsadc_pin: tsadc-pin {
>> > +                             rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             hdmi_pin {
>> > +                     hdmi_cec: hdmi-cec {
>> > +                             rockchip,pins = <0 RK_PA3 1 &pcfg_pull_none>;
>> > +                     };
>> > +
>> > +                     hdmi_hpd: hdmi-hpd {
>> > +                             rockchip,pins = <0 RK_PA4 1 &pcfg_pull_down>;
>> > +                     };
>> > +             };
>> > +
>> > +             cif-0 {
>> > +                     dvp_d2d9_m0:dvp-d2d9-m0 {
>> > +                             rockchip,pins =
>> > +                                     /* cif_d0 */
>> > +                                     <3 RK_PA4 2 &pcfg_pull_none>,
>> > +                                     /* cif_d1 */
>> > +                                     <3 RK_PA5 2 &pcfg_pull_none>,
>> > +                                     /* cif_d2 */
>> > +                                     <3 RK_PA6 2 &pcfg_pull_none>,
>> > +                                     /* cif_d3 */
>> > +                                     <3 RK_PA7 2 &pcfg_pull_none>,
>> > +                                     /* cif_d4 */
>> > +                                     <3 RK_PB0 2 &pcfg_pull_none>,
>> > +                                     /* cif_d5m0 */
>> > +                                     <3 RK_PB1 2 &pcfg_pull_none>,
>> > +                                     /* cif_d6m0 */
>> > +                                     <3 RK_PB2 2 &pcfg_pull_none>,
>> > +                                     /* cif_d7m0 */
>> > +                                     <3 RK_PB3 2 &pcfg_pull_none>,
>> > +                                     /* cif_href */
>> > +                                     <3 RK_PA1 2 &pcfg_pull_none>,
>> > +                                     /* cif_vsync */
>> > +                                     <3 RK_PA0 2 &pcfg_pull_none>,
>> > +                                     /* cif_clkoutm0 */
>> > +                                     <3 RK_PA3 2 &pcfg_pull_none>,
>> > +                                     /* cif_clkin */
>> > +                                     <3 RK_PA2 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +
>> > +             cif-1 {
>> > +                     dvp_d2d9_m1:dvp-d2d9-m1 {
>> > +                             rockchip,pins =
>> > +                                     /* cif_d0 */
>> > +                                     <3 RK_PA4 2 &pcfg_pull_none>,
>> > +                                     /* cif_d1 */
>> > +                                     <3 RK_PA5 2 &pcfg_pull_none>,
>> > +                                     /* cif_d2 */
>> > +                                     <3 RK_PA6 2 &pcfg_pull_none>,
>> > +                                     /* cif_d3 */
>> > +                                     <3 RK_PA7 2 &pcfg_pull_none>,
>> > +                                     /* cif_d4 */
>> > +                                     <3 RK_PB0 2 &pcfg_pull_none>,
>> > +                                     /* cif_d5m1 */
>> > +                                     <2 RK_PC0 4 &pcfg_pull_none>,
>> > +                                     /* cif_d6m1 */
>> > +                                     <2 RK_PC1 4 &pcfg_pull_none>,
>> > +                                     /* cif_d7m1 */
>> > +                                     <2 RK_PC2 4 &pcfg_pull_none>,
>> > +                                     /* cif_href */
>> > +                                     <3 RK_PA1 2 &pcfg_pull_none>,
>> > +                                     /* cif_vsync */
>> > +                                     <3 RK_PA0 2 &pcfg_pull_none>,
>> > +                                     /* cif_clkoutm1 */
>> > +                                     <2 RK_PB7 4 &pcfg_pull_none>,
>> > +                                     /* cif_clkin */
>> > +                                     <3 RK_PA2 2 &pcfg_pull_none>;
>> > +                     };
>> > +             };
>> > +     };
>> > +};
>> > diff --git a/configs/rock-pi-e-v3-rk3328_defconfig
>> > b/configs/rock-pi-e-v3-rk3328_defconfig
>> > new file mode 100644
>> > index 0000000000..4c6cc634bd
>> > --- /dev/null
>> > +++ b/configs/rock-pi-e-v3-rk3328_defconfig
>> > @@ -0,0 +1,97 @@
>> > +CONFIG_ARM=y
>> > +CONFIG_SKIP_LOWLEVEL_INIT=y
>> > +CONFIG_COUNTER_FREQUENCY=24000000
>> > +CONFIG_ARCH_ROCKCHIP=y
>> > +CONFIG_SPL_GPIO=y
>> > +CONFIG_NR_DRAM_BANKS=1
>> > +CONFIG_SF_DEFAULT_SPEED=20000000
>> > +CONFIG_ENV_OFFSET=0x3F8000
>> > +CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
>> > +CONFIG_DM_RESET=y
>> > +CONFIG_ROCKCHIP_RK3328=y
>> > +CONFIG_DEBUG_UART_BASE=0xFF130000
>> > +CONFIG_DEBUG_UART_CLOCK=24000000
>> > +CONFIG_SYS_LOAD_ADDR=0x800800
>> > +CONFIG_DEBUG_UART=y
>> > +CONFIG_FIT=y
>> > +CONFIG_FIT_VERBOSE=y
>> > +CONFIG_SPL_FIT_SIGNATURE=y
>> > +CONFIG_SPL_LOAD_FIT=y
>> > +CONFIG_LEGACY_IMAGE_FORMAT=y
>> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
>> > +# CONFIG_DISPLAY_CPUINFO is not set
>> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> > +CONFIG_SPL_MAX_SIZE=0x40000
>> > +CONFIG_SPL_PAD_TO=0x7f8000
>> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> > +CONFIG_SPL_POWER=y
>> > +CONFIG_SPL_ATF=y
>> > +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>> > +CONFIG_CMD_BOOTZ=y
>> > +CONFIG_CMD_GPIO=y
>> > +CONFIG_CMD_GPT=y
>> > +CONFIG_CMD_MMC=y
>> > +CONFIG_CMD_USB=y
>> > +CONFIG_CMD_TIME=y
>> > +CONFIG_CMD_REGULATOR=y
>> > +CONFIG_SPL_OF_CONTROL=y
>> > +CONFIG_TPL_OF_CONTROL=y
>> > +# CONFIG_OF_UPSTREAM is not set
>> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent
>> > assigned-clocks assigned-clock-rates assigned-clock-parents"
>> > +CONFIG_TPL_OF_PLATDATA=y
>> > +CONFIG_ENV_IS_IN_MMC=y
>> > +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> > +CONFIG_SYS_MMC_ENV_DEV=1
>> > +CONFIG_TPL_DM=y
>> > +CONFIG_SPL_DM_SEQ_ALIAS=y
>> > +CONFIG_REGMAP=y
>> > +CONFIG_SPL_REGMAP=y
>> > +CONFIG_TPL_REGMAP=y
>> > +CONFIG_SYSCON=y
>> > +CONFIG_SPL_SYSCON=y
>> > +CONFIG_TPL_SYSCON=y
>> > +CONFIG_CLK=y
>> > +CONFIG_SPL_CLK=y
>> > +CONFIG_ROCKCHIP_GPIO=y
>> > +CONFIG_SYS_I2C_ROCKCHIP=y
>> > +CONFIG_MMC_DW=y
>> > +CONFIG_MMC_DW_ROCKCHIP=y
>> > +CONFIG_PHY_REALTEK=y
>> > +CONFIG_DM_MDIO=y
>> > +CONFIG_DM_ETH_PHY=y
>> > +CONFIG_PHY_GIGE=y
>> > +CONFIG_ETH_DESIGNWARE=y
>> > +CONFIG_GMAC_ROCKCHIP=y
>> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> > +CONFIG_PINCTRL=y
>> > +CONFIG_SPL_PINCTRL=y
>> > +CONFIG_DM_PMIC=y
>> > +CONFIG_PMIC_RK8XX=y
>> > +CONFIG_SPL_DM_REGULATOR=y
>> > +CONFIG_DM_REGULATOR_FIXED=y
>> > +CONFIG_SPL_DM_REGULATOR_FIXED=y
>> > +CONFIG_REGULATOR_RK8XX=y
>> > +CONFIG_PWM_ROCKCHIP=y
>> > +CONFIG_RAM=y
>> > +CONFIG_SPL_RAM=y
>> > +CONFIG_TPL_RAM=y
>> > +CONFIG_DM_RNG=y
>> > +CONFIG_RNG_ROCKCHIP=y
>> > +CONFIG_BAUDRATE=1500000
>> > +CONFIG_DEBUG_UART_SHIFT=2
>> > +CONFIG_SYS_NS16550_MEM32=y
>> > +CONFIG_SYSINFO=y
>> > +CONFIG_SYSINFO_SMBIOS=y
>> > +CONFIG_SYSRESET=y
>> > +# CONFIG_TPL_SYSRESET is not set
>> > +CONFIG_USB=y
>> > +CONFIG_USB_XHCI_HCD=y
>> > +CONFIG_USB_EHCI_HCD=y
>> > +CONFIG_USB_EHCI_GENERIC=y
>> > +CONFIG_USB_OHCI_HCD=y
>> > +CONFIG_USB_OHCI_GENERIC=y
>> > +CONFIG_USB_DWC3=y
>> > +CONFIG_USB_DWC3_GENERIC=y
>> > +CONFIG_SPL_TINY_MEMSET=y
>> > +CONFIG_TPL_TINY_MEMSET=y
>> > +CONFIG_ERRNO_STR=y
