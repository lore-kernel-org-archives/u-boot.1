Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ECFCDB468
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 16:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F7386E16;
	Wed, 11 Oct 2023 18:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HfHj4UrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0926786C33; Wed, 11 Oct 2023 18:52:36 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197B886D15
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
Received: from [IPv6:2a00:23c8:b70a:ae01:9fa:2310:80c6:3ab0] (unknown
 [IPv6:2a00:23c8:b70a:ae01:9fa:2310:80c6:3ab0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D8FF66072FC;
 Wed, 11 Oct 2023 17:52:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697043143;
 bh=l18uQP9l/o3y6Gbds6m3vZf7//6JyeOBjO8jYAGWc0s=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=HfHj4UrE7nT9RL8q16qPqA0hL/Rm/rJqZRIHGPalC69NW22jL1+STdxW5k3XbYxim
 TROYQ9mLPHsXpzA6nNtANc+LUtmwg4vzgCzBZjgzzKX87udPYq84wrZix3DKyywVRa
 n0n6CKlv4uZiBnsd3VKi/lCgPNF6pHomEHyIjmyvS14Dkf0eD2NKEIKVv1hGg7JGct
 ltKG+FsBHHy+aLX/t7dp/vnSRO0Db81xJ8jTp+/VMywZLzjzZ/KrYr5JqadYnVemaz
 MiLmAdZ0MDVKh979Hf+oaIRRiQx9bjh6o6L0ZJzv2Ztx/yL03jUDz/LYDV8mVm9Ikc
 cSoIByJJndiIA==
Message-ID: <5f8632de8eb8d1f3a31656e1c65ea30c70beb01a.camel@collabora.com>
Subject: Re: [PATCH 3/4] rockchip: rk3588-rock-5b: Sync USB3 nodes from
 mainline linux patches
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 11 Oct 2023 17:52:21 +0100
In-Reply-To: <20231010222344.3436526-4-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-4-jonas@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
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

Hi Jonas,

On Tue, 2023-10-10 at 22:23 +0000, Jonas Karlman wrote:
> The device tree for rk3588 and rock-5b contain usb3 nodes that have
> deviated too much from current state of submitted mainline linux usb3
> patches, see [1].
>=20
> Sync usb3 related nodes from latest patches and collaboras rk3588 tree
> so that dwc3-generic driver can be updated to include support for the
> rockchip,rk3588-dwc3 compatible.
>=20
> [1] https://lore.kernel.org/lkml/20231009172129.43568-1-sebastian.reichel=
@collabora.com/
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

These will be upstream shortly. Maybe we can wait until they appear in Heik=
o's tree?

> ---
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> =C2=A0arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 148 +++++++--------------=
---
> =C2=A0arch/arm/dts/rk3588-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 39 +++----
> =C2=A0arch/arm/dts/rk3588s-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 68 ++++++-----
> =C2=A0configs/rock5b-rk3588_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A04 files changed, 99 insertions(+), 157 deletions(-)
>=20
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
> index 3f390ef26a3f..b595ddef7028 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -19,38 +19,10 @@
> =C2=A0		regulator-min-microvolt =3D <12000000>;
> =C2=A0		regulator-max-microvolt =3D <12000000>;
> =C2=A0	};
> +};
> =C2=A0
> -	vcc5v0_usbdcin: vcc5v0-usbdcin {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc5v0_usbdcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&vcc5v0_usbdcin>;
> -	};
> -
> -	vbus5v0_typec: vbus5v0-typec {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vbus5v0_typec";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		enable-active-high;
> -		gpio =3D <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
> -		vin-supply =3D <&vcc5v0_usb>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&typec5v_pwren>;
> -	};
> +&combphy2_psu {
> +	status =3D "okay";
> =C2=A0};
> =C2=A0
> =C2=A0&fspim2_pins {
> @@ -58,13 +30,9 @@
> =C2=A0};
> =C2=A0
> =C2=A0&pinctrl {
> -	usb-typec {
> +	usb {
> =C2=A0		usbc0_int: usbc0-int {
> -			rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		typec5v_pwren: typec5v-pwren {
> -			rockchip,pins =3D <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +			rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> =C2=A0		};
> =C2=A0	};
> =C2=A0};
> @@ -97,7 +65,6 @@
> =C2=A0};
> =C2=A0
> =C2=A0&u2phy0_otg {
> -	rockchip,typec-vbus-det;
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> @@ -109,25 +76,17 @@
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> -&usb2phy2_grf {
> +&usbdp_phy1 {
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> -&usb2phy3_grf {
> +&usbdp_phy1_u3 {
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> -&usb_host0_ehci {
> -	companion =3D <&usb_host0_ohci>;
> -};
> -
> -&usb_host1_ehci {
> -	companion =3D <&usb_host1_ohci>;
> -};
> -
> =C2=A0&usbdp_phy0 {
> =C2=A0	orientation-switch;
> -	svid =3D <0xff01>;
> +	mode-switch;
> =C2=A0	sbu1-dc-gpios =3D <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> =C2=A0	sbu2-dc-gpios =3D <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
> =C2=A0	status =3D "okay";
> @@ -135,14 +94,15 @@
> =C2=A0	port {
> =C2=A0		#address-cells =3D <1>;
> =C2=A0		#size-cells =3D <0>;
> -		usbdp_phy0_orientation_switch: endpoint@0 {
> +
> +		usbdp_phy0_typec_ss: endpoint@0 {
> =C2=A0			reg =3D <0>;
> -			remote-endpoint =3D <&usbc0_orien_sw>;
> +			remote-endpoint =3D <&usbc0_ss>;
> =C2=A0		};
> =C2=A0
> -		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> +		usbdp_phy0_typec_sbu: endpoint@1 {
> =C2=A0			reg =3D <1>;
> -			remote-endpoint =3D <&dp_altmode_mux>;
> +			remote-endpoint =3D <&usbc0_sbu>;
> =C2=A0		};
> =C2=A0	};
> =C2=A0};
> @@ -151,84 +111,53 @@
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> -&usbdp_phy1 {
> -	rockchip,dp-lane-mux =3D <2 3>;
> +&usb_host0_xhci {
> +	usb-role-switch;
> =C2=A0	status =3D "okay";
> -};
> =C2=A0
> -&usbdp_phy1_u3 {
> -	status =3D "okay";
> -};
> +	port {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> =C2=A0
> -&usbdrd3_0 {
> -	status =3D "okay";
> +		usb_host0_xhci_drd_sw: endpoint {
> +			remote-endpoint =3D <&usbc0_hs>;
> +		};
> +	};
> =C2=A0};
> =C2=A0
> -&usbdrd3_1 {
> +&usb_host1_xhci {
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> -&usbdrd_dwc3_0 {
> -	usb-role-switch;
> -
> -	port {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		dwc3_0_role_switch: endpoint@0 {
> -			reg =3D <0>;
> -			remote-endpoint =3D <&usbc0_role_sw>;
> -		};
> -	};
> +&usb_host2_xhci {
> +	status =3D "okay";
> =C2=A0};
> =C2=A0
> =C2=A0&i2c4 {
> +	pinctrl-names =3D "default";
> =C2=A0	pinctrl-0 =3D <&i2c4m1_xfer>;
> =C2=A0	status =3D "okay";
> =C2=A0
> -	usbc0: fusb302@22 {
> +	usbc0: usb-typec@22 {
> =C2=A0		compatible =3D "fcs,fusb302";
> =C2=A0		reg =3D <0x22>;
> =C2=A0		interrupt-parent =3D <&gpio3>;
> =C2=A0		interrupts =3D <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> =C2=A0		pinctrl-names =3D "default";
> =C2=A0		pinctrl-0 =3D <&usbc0_int>;
> -		vbus-supply =3D <&vbus5v0_typec>;
> +		vbus-supply =3D <&vcc12v_dcin>;
> =C2=A0		status =3D "okay";
> =C2=A0
> -		ports {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			port@0 {
> -				reg =3D <0>;
> -				usbc0_role_sw: endpoint@0 {
> -					remote-endpoint =3D <&dwc3_0_role_switch>;
> -				};
> -			};
> -		};
> -
> =C2=A0		usb_con: connector {
> =C2=A0			compatible =3D "usb-c-connector";
> =C2=A0			label =3D "USB-C";
> =C2=A0			data-role =3D "dual";
> -			power-role =3D "dual";
> +			power-role =3D "sink";
> =C2=A0			try-power-role =3D "sink";
> =C2=A0			op-sink-microwatt =3D <1000000>;
> =C2=A0			sink-pdos =3D
> -				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> -			source-pdos =3D
> -				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> -
> -			altmodes {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -
> -				altmode@0 {
> -					reg =3D <0>;
> -					svid =3D <0xff01>;
> -					vdo =3D <0xffffffff>;
> -				};
> -			};
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> +				<PDO_VAR(5000, 20000, 5000)>;
> =C2=A0
> =C2=A0			ports {
> =C2=A0				#address-cells =3D <1>;
> @@ -236,15 +165,22 @@
> =C2=A0
> =C2=A0				port@0 {
> =C2=A0					reg =3D <0>;
> -					usbc0_orien_sw: endpoint {
> -						remote-endpoint =3D <&usbdp_phy0_orientation_switch>;
> +					usbc0_hs: endpoint {
> +						remote-endpoint =3D <&usb_host0_xhci_drd_sw>;
> =C2=A0					};
> =C2=A0				};
> =C2=A0
> =C2=A0				port@1 {
> =C2=A0					reg =3D <1>;
> -					dp_altmode_mux: endpoint {
> -						remote-endpoint =3D <&usbdp_phy0_dp_altmode_mux>;
> +					usbc0_ss: endpoint {
> +						remote-endpoint =3D <&usbdp_phy0_typec_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg =3D <2>;
> +					usbc0_sbu: endpoint {
> +						remote-endpoint =3D <&usbdp_phy0_typec_sbu>;
> =C2=A0					};
> =C2=A0				};
> =C2=A0			};
> diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot=
.dtsi
> index 15de4706254e..992f7b5d6637 100644
> --- a/arch/arm/dts/rk3588-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-u-boot.dtsi
> @@ -6,32 +6,24 @@
> =C2=A0#include "rk3588s-u-boot.dtsi"
> =C2=A0
> =C2=A0/ {
> -	usbdrd3_1: usbdrd3_1 {
> -		compatible =3D "rockchip,rk3588-dwc3", "rockchip,rk3399-dwc3";
> +	usb_host1_xhci: usb@fc400000 {
> +		compatible =3D "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg =3D <0x0 0xfc400000 0x0 0x400000>;
> +		interrupts =3D <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
> =C2=A0		clocks =3D <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
> =C2=A0			 <&cru ACLK_USB3OTG1>;
> -		clock-names =3D "ref", "suspend", "bus";
> -		#address-cells =3D <2>;
> -		#size-cells =3D <2>;
> -		ranges;
> +		clock-names =3D "ref_clk", "suspend_clk", "bus_clk";
> +		dr_mode =3D "host";
> +		phys =3D <&u2phy1_otg>, <&usbdp_phy1_u3>;
> +		phy-names =3D "usb2-phy", "usb3-phy";
> +		phy_type =3D "utmi_wide";
> +		power-domains =3D <&power RK3588_PD_USB>;
> +		resets =3D <&cru SRST_A_USB3OTG1>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> =C2=A0		status =3D "disabled";
> -
> -		usbdrd_dwc3_1: usb@fc400000 {
> -			compatible =3D "snps,dwc3";
> -			reg =3D <0x0 0xfc400000 0x0 0x400000>;
> -			interrupts =3D <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
> -			power-domains =3D <&power RK3588_PD_USB>;
> -			resets =3D <&cru SRST_A_USB3OTG1>;
> -			reset-names =3D "usb3-otg";
> -			dr_mode =3D "host";
> -			phys =3D <&u2phy1_otg>, <&usbdp_phy1_u3>;
> -			phy-names =3D "usb2-phy", "usb3-phy";
> -			phy_type =3D "utmi_wide";
> -			snps,dis_enblslpm_quirk;
> -			snps,dis-u2-freeclk-exists-quirk;
> -			snps,dis-del-phy-power-chg-quirk;
> -			snps,dis-tx-ipgap-linecheck-quirk;
> -		};
> =C2=A0	};
> =C2=A0
> =C2=A0	usbdpphy1_grf: syscon@fd5cc000 {
> @@ -56,7 +48,6 @@
> =C2=A0			clock-names =3D "phyclk";
> =C2=A0			clock-output-names =3D "usb480m_phy1";
> =C2=A0			#clock-cells =3D <0>;
> -			rockchip,usbctrl-grf =3D <&usb_grf>;
> =C2=A0			status =3D "disabled";
> =C2=A0
> =C2=A0			u2phy1_otg: otg-port {
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-bo=
ot.dtsi
> index 878936fa07d6..bdba4eb1df32 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -21,35 +21,47 @@
> =C2=A0		status =3D "okay";
> =C2=A0	};
> =C2=A0
> -	usbdrd3_0: usbdrd3_0 {
> -		compatible =3D "rockchip,rk3588-dwc3", "rockchip,rk3399-dwc3";
> +	usb_host0_xhci: usb@fc000000 {
> +		compatible =3D "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg =3D <0x0 0xfc000000 0x0 0x400000>;
> +		interrupts =3D <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> =C2=A0		clocks =3D <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
> =C2=A0			 <&cru ACLK_USB3OTG0>;
> -		clock-names =3D "ref", "suspend", "bus";
> -		#address-cells =3D <2>;
> -		#size-cells =3D <2>;
> -		ranges;
> +		clock-names =3D "ref_clk", "suspend_clk", "bus_clk";
> +		dr_mode =3D "otg";
> +		phys =3D <&u2phy0_otg>, <&usbdp_phy0_u3>;
> +		phy-names =3D "usb2-phy", "usb3-phy";
> +		phy_type =3D "utmi_wide";
> +		power-domains =3D <&power RK3588_PD_USB>;
> +		resets =3D <&cru SRST_A_USB3OTG0>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u1-entry-quirk;
> +		snps,dis-u2-entry-quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> =C2=A0		status =3D "disabled";
> +	};
> =C2=A0
> -		usbdrd_dwc3_0: usb@fc000000 {
> -			compatible =3D "snps,dwc3";
> -			reg =3D <0x0 0xfc000000 0x0 0x400000>;
> -			interrupts =3D <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> -			power-domains =3D <&power RK3588_PD_USB>;
> -			resets =3D <&cru SRST_A_USB3OTG0>;
> -			reset-names =3D "usb3-otg";
> -			dr_mode =3D "otg";
> -			phys =3D <&u2phy0_otg>, <&usbdp_phy0_u3>;
> -			phy-names =3D "usb2-phy", "usb3-phy";
> -			phy_type =3D "utmi_wide";
> -			snps,dis_enblslpm_quirk;
> -			snps,dis-u1-entry-quirk;
> -			snps,dis-u2-entry-quirk;
> -			snps,dis-u2-freeclk-exists-quirk;
> -			snps,dis-del-phy-power-chg-quirk;
> -			snps,dis-tx-ipgap-linecheck-quirk;
> -			quirk-skip-phy-init;
> -		};
> +	usb_host2_xhci: usb@fcd00000 {
> +		compatible =3D "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg =3D <0x0 0xfcd00000 0x0 0x400000>;
> +		interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
> +			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
> +			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> +		clock-names =3D "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
> +		dr_mode =3D "host";
> +		phys =3D <&combphy2_psu PHY_TYPE_USB3>;
> +		phy-names =3D "usb3-phy";
> +		phy_type =3D "utmi_wide";
> +		resets =3D <&cru SRST_A_USB3OTG2>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> +		snps,dis_rxdet_inp3_quirk;
> +		status =3D "disabled";
> =C2=A0	};
> =C2=A0
> =C2=A0	pmu1_grf: syscon@fd58a000 {
> @@ -58,6 +70,11 @@
> =C2=A0		reg =3D <0x0 0xfd58a000 0x0 0x2000>;
> =C2=A0	};
> =C2=A0
> +	usbdpphy0_grf: syscon@fd5c8000 {
> +		compatible =3D "rockchip,rk3588-usbdpphy-grf", "syscon";
> +		reg =3D <0x0 0xfd5c8000 0x0 0x4000>;
> +	};
> +
> =C2=A0	usb2phy0_grf: syscon@fd5d0000 {
> =C2=A0		compatible =3D "rockchip,rk3588-usb2phy-grf", "syscon",
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 "simple-mfd";
> @@ -75,7 +92,6 @@
> =C2=A0			clock-names =3D "phyclk";
> =C2=A0			clock-output-names =3D "usb480m_phy0";
> =C2=A0			#clock-cells =3D <0>;
> -			rockchip,usbctrl-grf =3D <&usb_grf>;
> =C2=A0			status =3D "disabled";
> =C2=A0
> =C2=A0			u2phy0_otg: otg-port {
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defc=
onfig
> index ec22e70033a0..0595325e8107 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -101,7 +101,6 @@ CONFIG_SYSRESET=3Dy
> =C2=A0CONFIG_USB=3Dy
> =C2=A0CONFIG_DM_USB_GADGET=3Dy
> =C2=A0CONFIG_USB_XHCI_HCD=3Dy
> -# CONFIG_USB_XHCI_DWC3_OF_SIMPLE is not set
> =C2=A0CONFIG_USB_EHCI_HCD=3Dy
> =C2=A0CONFIG_USB_EHCI_GENERIC=3Dy
> =C2=A0CONFIG_USB_OHCI_HCD=3Dy
