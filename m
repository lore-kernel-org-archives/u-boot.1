Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CCDCA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 20:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71968329B;
	Tue,  2 Sep 2025 22:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFFA832AD; Tue,  2 Sep 2025 22:03:15 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDBB83290
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 22:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 04F5FB2204BF;
 Tue,  2 Sep 2025 22:03:10 +0200 (CEST)
Message-ID: <3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de>
Date: Tue, 2 Sep 2025 13:03:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-3-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-3-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Hal,

On 8/28/25 23:09, Hal Feng wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> 
> Board features:
> - JH7110S SoC
> - 2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 

Prefer to see subject line and URL of recent upstream discussion or git
web commit for the new or modified dts changes from upstream of
devicetree-rebasing in this commit and not just in the cover letter.

+ From upstream LKML discussion "[RFC 3/3] riscv: dts: starfive: Add
VisionFive 2 Lite board device tree" [1].
+ 1:
https://lore.kernel.org/all/20250821100930.71404-4-hal.feng@starfivetech.com/

> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> new file mode 100644
> index 00000000000..a0cb9912eb8
> --- /dev/null
> +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts

No, do not directly add or modify upstream dts in dts/upstream/src
subtree. We are not permitted in U-Boot to merge out-of-band devicetree
changes to the devicetree-rebasing subtree as this creates more work for
Tom, if I understand correctly?

Instead add or modify this dts as
arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi filename.

Note: Locally for development purpose I would like to extend U-Boot to
choose a Linux source tree path for location of devicetree. Today
OF_UPSTREAM support in U-Boot build system assumes to use the
devicetree-rebasing subtree and the path is not meant to be changed. The
devicetree-rebasing scripts assume only to merge from regular Linux
release version tags and not arbitrary commit IDs. As a workaround I do
something like git recursive remove the
dts/upstream/src/$(ARCH)/$(VENDOR) and replace with symbolic link to the
Linux source tree arch/$(ARCH)/boot/dts/$(VENDOR) for development. I
would like better if it was simply an environment flag for make system
where Linux or devicetree-rebasing source tree is located, but that is
for a different discussion not in this series.

> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "StarFive VisionFive 2 Lite";
> +	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
> +};
> +
> +&cpu_opp {
> +	opp-312500000 {
> +		opp-hz = /bits/ 64 <312500000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-417000000 {
> +		opp-hz = /bits/ 64 <417000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-625000000 {
> +		opp-hz = /bits/ 64 <625000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1250000000 {
> +		opp-hz = /bits/ 64 <1250000000>;
> +		opp-microvolt = <1000000>;
> +	};
> +};
> +
> +&gmac0 {
> +	starfive,tx-use-rgmii-clk;
> +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +};
> +
> +&mmc1 {
> +	max-frequency = <50000000>;
> +	keep-power-in-suspend;
> +	non-removable;
> +};
> +
> +&pcie1 {
> +	enable-gpios = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&phy0 {
> +	motorcomm,tx-clk-adj-enabled;
> +	motorcomm,tx-clk-100-inverted;
> +	motorcomm,tx-clk-1000-inverted;
> +	motorcomm,rx-clk-drv-microamp = <3970>;
> +	motorcomm,rx-data-drv-microamp = <2910>;
> +	rx-internal-delay-ps = <1500>;
> +	tx-internal-delay-ps = <1500>;
> +};
> +
> +&pwm {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&syscrg {
> +	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
> +};
> +
> +&sysgpio {
> +	uart1_pins: uart1-0 {
> +		tx-pins {
> +			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pinmux = <GPIOMUX(23, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_UART1_RX)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +
> +		cts-pins {
> +			pinmux = <GPIOMUX(24, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_UART1_CTS)>;
> +			input-enable;
> +		};
> +
> +		rts-pins {
> +			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			input-enable;
> +		};
> +	};
> +
> +	usb0_pins: usb0-0 {
> +		power-pins {
> +			pinmux = <GPIOMUX(26, GPOUT_HIGH,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			input-disable;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins>;
> +	status = "okay";
> +};
> +
> +&usb_cdns3 {
> +	phys = <&usbphy0>, <&pciephy0>;
> +	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
> +};

Append the last line of this file an '#include' statement corresponding
with the next automatic dtsi inclusion order [1] as appropriate,
currently when we drop file jh7110-common-u-boot.dtsi from U-Boot:

+ #include "jh7110-u-boot.dtsi"

Or better approach in future for last line of the file would be if when
CONFIG_NAME is added to the search order [2], then this include would
instead be a hyphenated form of $(CONFIG_SYS_CONFIG_NAME)-u-boot.dtsi:

+ #include "starfive-visionfive2-u-boot.dtsi"

And drop all dts/riscv/jh7110*{.dts,.dtsi} not existing in
dts/upstream/src subtree.

Anyways I discover the build system is not working correctly for '$<'
symbol [3] and this breaks our assumption that
arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi would be
automatically included. It is needed to fix the situation separate from
this series.

1: https://docs.u-boot.org/en/latest/develop/devicetree/control.html
2: https://lore.kernel.org/u-boot/20250826214708.309271-1-e@freeshell.de/
3: https://lore.kernel.org/u-boot/20250901094506.647427-1-e@freeshell.de/

-E
