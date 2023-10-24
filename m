Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F027C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BD08720A;
	Wed, 25 Oct 2023 00:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674EB8722B; Wed, 25 Oct 2023 00:27:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1CF32871BB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D644BC15;
 Tue, 24 Oct 2023 15:27:55 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF813F762;
 Tue, 24 Oct 2023 15:27:13 -0700 (PDT)
Date: Tue, 24 Oct 2023 23:26:08 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Cc: hdegoede@redhat.com, jagan@amarulasolutions.com, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v3 1/1] arm: dts: icnova-a20-adb4006: Add board
 support
Message-ID: <20231024232608.6e9b2516@slackpad.lan>
In-Reply-To: <20231009113916.2668425-1-ludwig.kormann@ict42.de>
References: <20231009113916.2668425-1-ludwig.kormann@ict42.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon,  9 Oct 2023 13:39:16 +0200
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi Ludwig,

> Add board support for ICnova A20 SomPi compute module on
> ICnova ADB4006 development board.
>=20
> Specification:
> SoM
> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
> - 512MB DDR3 RAM
> - Fast Ethernet (Phy: Realtek RTL8201CP)
> ADB4006
> - I2C
> - 2x USB 2.0
> - 1x Fast Ethernet port
> - 1x SATA
> - 2x buttons (PWRON, Boot)
> - 2x LEDS
> - serial console
> - HDMI
> - =C2=B5SD-Card slot
> - Audio Line-In / Line-Out
> - GPIO pinheaders
>=20
> https://wiki.in-circuit.de/index.php5?title=3DICnova_ADB4006
> https://wiki.in-circuit.de/index.php5?title=3DICnova_A20_SODIMM
>=20
> devicetree upstreamed with linux 6.5

As you have probably seen, the DT files have been synced into U-Boot's
master branch yesterday.
So if you rebase this on top of master, so just send the defconfig
(with CONFIG_SYS_64BIT_LBA added) and the Makefile change in a new
patch, I am happy to take it still this cycle.

Cheers,
Andre

> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
> ---
> changes in v3:
> - rebase on v2023.10
>=20
> changes in v2:
> - rebase on v2023.07-rc2
> - remove pin defines from defconfig
> - get dts reviewed on the linux mailing list and
>   scheduled for kernel 6.5 [1]
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> commit de2bdfb7f79d5c655eb056d459e02be2c7f13c8b
>=20
> ---
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>  arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++++++++
>  board/sunxi/MAINTAINERS                       |   5 +
>  configs/icnova-a20-adb4006_defconfig          |  20 +++
>  5 files changed, 225 insertions(+)
>  create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
>  create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
>  create mode 100644 configs/icnova-a20-adb4006_defconfig
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157..16d5930b78 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -667,6 +667,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-haoyu-marsboard.dtb \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> +	sun7i-a20-icnova-a20-adb4006.dtb \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-itead-ibox.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
> diff --git a/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/dts=
/sun7i-a20-icnova-a20-adb4006.dts
> new file mode 100644
> index 0000000000..577ead1d02
> --- /dev/null
> +++ b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2023 In-Circuit GmbH
> +
> +/dts-v1/;
> +
> +#include "sun7i-a20-icnova-a20.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model =3D "In-Circuit ICnova A20 ADB4006";
> +	compatible =3D "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
> +		     "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-0 {
> +			function =3D LED_FUNCTION_POWER;
> +			color =3D <LED_COLOR_ID_YELLOW>;
> +			gpios =3D <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
> +			default-state =3D "on";
> +		};
> +
> +		led-1 {
> +			function =3D LED_FUNCTION_HEARTBEAT;
> +			color =3D <LED_COLOR_ID_RED>;
> +			gpios =3D <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +};
> +
> +&ahci {
> +	target-supply =3D <&reg_ahci_5v>;
> +	status =3D "okay";
> +};
> +
> +&codec {
> +	status =3D "okay";
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&hdmi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi_con_in>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&otg_sram {
> +	status =3D "okay";
> +};
> +
> +&reg_ahci_5v {
> +	status =3D "okay";
> +};
> +
> +&ac_power_supply {
> +	status =3D "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pb_pins>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios =3D <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_det-gpios =3D <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	usb2_vbus-supply =3D <&reg_usb2_vbus>;
> +	status =3D "okay";
> +};
> diff --git a/arch/arm/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/dts/sun7i-=
a20-icnova-a20.dtsi
> new file mode 100644
> index 0000000000..46616c6bc8
> --- /dev/null
> +++ b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2023 In-Circuit GmbH
> +
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&gmac {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&gmac_mii_pins>;
> +	phy-handle =3D <&phy1>;
> +	phy-mode =3D "mii";
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&gmac_mdio {
> +	phy1: ethernet-phy@1 {
> +		reg =3D <1>;
> +	};
> +};
> +
> +#include "axp209.dtsi"
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 98bbd2dd25..67cdd01371 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -236,6 +236,11 @@ M:	Stefan Roese <sr@denx.de>
>  S:	Maintained
>  F:	configs/icnova-a20-swac_defconfig
> =20
> +ICnova-A20-ADB4006 BOARD
> +M:	Ludwig Kormann <ludwig.kormann@ict42.de>
> +S:	Maintained
> +F:	configs/icnova-a20-adb4006_defconfig
> +
>  ITEAD IBOX BOARD
>  M:	Marcus Cooper <codekipper@gmail.com>
>  S:	Maintained
> diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-ad=
b4006_defconfig
> new file mode 100644
> index 0000000000..f70ffe45ab
> --- /dev/null
> +++ b/configs/icnova-a20-adb4006_defconfig
> @@ -0,0 +1,20 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_SUNXI=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"sun7i-a20-icnova-a20-adb4006"
> +CONFIG_SPL=3Dy
> +CONFIG_MACH_SUN7I=3Dy
> +CONFIG_DRAM_CLK=3D384
> +CONFIG_AHCI=3Dy
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=3Dy
> +CONFIG_SCSI_AHCI=3Dy
> +CONFIG_SYS_I2C_MVTWSI=3Dy
> +CONFIG_SYS_I2C_SLAVE=3D0x7f
> +CONFIG_SYS_I2C_SPEED=3D400000
> +CONFIG_ETH_DESIGNWARE=3Dy
> +CONFIG_MII=3Dy
> +CONFIG_SUN7I_GMAC=3Dy
> +CONFIG_AXP_ALDO4_VOLT=3D2800
> +CONFIG_SCSI=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy

