Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C1CDB468
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 16:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD6086CEB;
	Wed, 11 Oct 2023 18:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nWKgDJ5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCBD86CEB; Wed, 11 Oct 2023 18:50:28 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BD286D07
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:50:26 +0200 (CEST)
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
 by madras.collabora.co.uk (Postfix) with ESMTPSA id AD3EF66072FC;
 Wed, 11 Oct 2023 17:50:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697043025;
 bh=B20hh9wvIR6kJOwq90oiXq0ic54ARejaScDQ18/i7uc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nWKgDJ5ZJsYRxYvjBffphVhqWZhxc9ePWqXpxg6ykPINSgE1BRzoWugLKaKneOGEf
 iYwcTUKSX+wpAvHuk9WbQactIOTOBap+eOFKeBs08n0REnwuTshqPlxHAcBd1N087l
 HMSGGKt4LpgMWzM9UX08YdWDZbbkxgy4KzwfPjjunS7t4lf/jDVNCJ/3pbrOyO0/hM
 ULBvLFPeNX9LvnIXMOqbfMrZAB8c/ibzXsHZmpkC2jBfZxHENdtyjMYKDMLl/tSfi3
 qEf00ezVJ0CxPHz+cJST01okEm/slSPQBbzH7gQZnMAXZ7aJMAcA9791qYth83GKht
 ZZc1jpGNri16A==
Message-ID: <32a7756af1243ddf0caa61156d28d7a98701a4de.camel@collabora.com>
Subject: Re: [PATCH 1/4] rockchip: rk3588: Sync device tree from linux
 maintainer tree
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Date: Wed, 11 Oct 2023 17:50:23 +0100
In-Reply-To: <20231010222344.3436526-2-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-2-jonas@kwiboo.se>
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
> Sync rk3588 device tree from linux maintainer tree (v6.7-armsoc/dts64).
> Adds PCIe nodes to rk3588-evb1-v10 and rk3588-rock-5b boards. Also
> remove includes from u-boot.dtsi-files that is no longer needed.
>=20
> Linux commits:
> 42145b7a8235 ("arm64: dts: rockchip: add PCIe network controller to rock-=
5b")
> 199cbd5f195a ("arm64: dts: rockchip: add PCIe for M.2 M-key to rock-5b")
> da447ec38780 ("arm64: dts: rockchip: add PCIe for M.2 E-Key to rock-5b")
> 86a2024d95e2 ("arm64: dts: rockchip: add PCIe2 network controller to rk35=
88-evb1")
> 46bb398ea1d8 ("arm64: dts: rockchip: add PCIe3 bus to rk3588-evb1")
> 1c9a53ff7ece ("arm64: dts: rockchip: Add sdio node to rock-5b")
> 3eaf2abd11aa ("arm64: dts: rockchip: Add sfc node to rk3588s")
> bf012368bb0a ("arm64: dts: rockchip: Add I2S2 M0 pin definitions to rk358=
8s")
> 3d77a3e51b0f ("arm64: dts: rockchip: Add UART9 M0 pin definitions to rk35=
88s")
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> =C2=A0arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi |=C2=A0 11 +-
> =C2=A0arch/arm/dts/rk3588-evb1-v10.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 98 ++++++++++++++++
> =C2=A0arch/arm/dts/rk3588-rock-5b-u-boot.dtsi=C2=A0 |=C2=A0 60 ----------
> =C2=A0arch/arm/dts/rk3588-rock-5b.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 140 +++++++++++++++++++++++
> =C2=A0arch/arm/dts/rk3588-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0arch/arm/dts/rk3588s-pinctrl.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 44 +++++++
> =C2=A0arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi |=C2=A0=C2=A0 4 -
> =C2=A0arch/arm/dts/rk3588s-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 10 --
> =C2=A0arch/arm/dts/rk3588s.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
> =C2=A09 files changed, 294 insertions(+), 85 deletions(-)
>=20
> diff --git a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi b/arch/arm/dts/rk35=
88-evb1-v10-u-boot.dtsi
> index bd2e25948633..e8566785e965 100644
> --- a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> @@ -6,16 +6,7 @@
> =C2=A0#include "rk3588-u-boot.dtsi"
> =C2=A0
> =C2=A0/ {
> -	aliases {
> -		mmc0 =3D &sdmmc;
> -		mmc1 =3D &sdhci;
> -	};
> -
> =C2=A0	chosen {
> -		u-boot,spl-boot-order =3D &sdhci;
> +		u-boot,spl-boot-order =3D "same-as-spl", &sdhci;
> =C2=A0	};
> =C2=A0};
> -
> -&sdhci {
> -	bootph-all;
> -};
> diff --git a/arch/arm/dts/rk3588-evb1-v10.dts b/arch/arm/dts/rk3588-evb1-=
v10.dts
> index 229a9111f5eb..c3fe58e39e99 100644
> --- a/arch/arm/dts/rk3588-evb1-v10.dts
> +++ b/arch/arm/dts/rk3588-evb1-v10.dts
> @@ -29,6 +29,46 @@
> =C2=A0		pwms =3D <&pwm2 0 25000 0>;
> =C2=A0	};
> =C2=A0
> +	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie20_avdd0v85";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <850000>;
> +		regulator-max-microvolt =3D <850000>;
> +		vin-supply =3D <&avdd_0v85_s0>;
> +	};
> +
> +	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie20_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&avcc_1v8_s0>;
> +	};
> +
> +	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie30_avdd0v75";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <750000>;
> +		regulator-max-microvolt =3D <750000>;
> +		vin-supply =3D <&avdd_0v75_s0>;
> +	};
> +
> +	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&avcc_1v8_s0>;
> +	};
> +
> =C2=A0	vcc12v_dcin: vcc12v-dcin-regulator {
> =C2=A0		compatible =3D "regulator-fixed";
> =C2=A0		regulator-name =3D "vcc12v_dcin";
> @@ -38,6 +78,19 @@
> =C2=A0		regulator-max-microvolt =3D <12000000>;
> =C2=A0	};
> =C2=A0
> +	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_pcie30";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		enable-active-high;
> +		gpios =3D <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us =3D <5000>;
> +		vin-supply =3D <&vcc12v_dcin>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&vcc3v3_pcie30_en>;
> +	};
> +
> =C2=A0	vcc5v0_host: vcc5v0-host-regulator {
> =C2=A0		compatible =3D "regulator-fixed";
> =C2=A0		regulator-name =3D "vcc5v0_host";
> @@ -87,6 +140,10 @@
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> +&combphy2_psu {
> +	status =3D "okay";
> +};
> +
> =C2=A0&cpu_b0 {
> =C2=A0	cpu-supply =3D <&vdd_cpu_big0_s0>;
> =C2=A0};
> @@ -163,7 +220,32 @@
> =C2=A0	};
> =C2=A0};
> =C2=A0
> +&pcie2x1l1 {
> +	reset-gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie2_1_rst>, <&rtl8111_isolate>;
> +	status =3D "okay";
> +};
> +
> +&pcie30phy {
> +	status =3D "okay";
> +};
> +
> +&pcie3x4 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie3_reset>;
> +	reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> +	status =3D "okay";
> +};
> +
> =C2=A0&pinctrl {
> +	rtl8111 {
> +		rtl8111_isolate: rtl8111-isolate {
> +			rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> =C2=A0	rtl8211f {
> =C2=A0		rtl8211f_rst: rtl8211f-rst {
> =C2=A0			rockchip,pins =3D <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -177,6 +259,22 @@
> =C2=A0		};
> =C2=A0	};
> =C2=A0
> +	pcie2 {
> +		pcie2_1_rst: pcie2-1-rst {
> +			rockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie3 {
> +		pcie3_reset: pcie3-reset {
> +			rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc3v3_pcie30_en: vcc3v3-pcie30-en {
> +			rockchip,pins =3D <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> =C2=A0	usb {
> =C2=A0		vcc5v0_host_en: vcc5v0-host-en {
> =C2=A0			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
> index 96cc84e5aac9..3f390ef26a3f 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -4,9 +4,6 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "rk3588-u-boot.dtsi"
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/gpio/gpio.h>
> =C2=A0#include <dt-bindings/usb/pd.h>
> =C2=A0
> =C2=A0/ {
> @@ -23,19 +20,6 @@
> =C2=A0		regulator-max-microvolt =3D <12000000>;
> =C2=A0	};
> =C2=A0
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc3v3_pcie30";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -		enable-active-high;
> -		gpios =3D <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		startup-delay-us =3D <5000>;
> -		vin-supply =3D <&vcc5v0_sys>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pcie3_vcc3v3_en>;
> -	};
> -
> =C2=A0	vcc5v0_usbdcin: vcc5v0-usbdcin {
> =C2=A0		compatible =3D "regulator-fixed";
> =C2=A0		regulator-name =3D "vcc5v0_usbdcin";
> @@ -69,53 +53,11 @@
> =C2=A0	};
> =C2=A0};
> =C2=A0
> -&combphy0_ps {
> -	status =3D "okay";
> -};
> -
> =C2=A0&fspim2_pins {
> =C2=A0	bootph-all;
> =C2=A0};
> =C2=A0
> -&pcie2x1l2 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&pcie2x1l2_pins &pcie_reset_h>;
> -	reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> -	status =3D "okay";
> -};
> -
> -&pcie30phy {
> -	status =3D "okay";
> -};
> -
> -&pcie3x4 {
> -	reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&pcie3_rst>;
> -	status =3D "okay";
> -};
> -
> =C2=A0&pinctrl {
> -	pcie {
> -		pcie_reset_h: pcie-reset-h {
> -			rockchip,pins =3D <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie2x1l2_pins: pcie2x1l2-pins {
> -			rockchip,pins =3D <3 RK_PC7 4 &pcfg_pull_none>,
> -					<3 RK_PD0 4 &pcfg_pull_none>;
> -		};
> -
> -		pcie3_rst: pcie3-rst {
> -			rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> -			rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> =C2=A0	usb-typec {
> =C2=A0		usbc0_int: usbc0-int {
> =C2=A0			rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> @@ -138,8 +80,6 @@
> =C2=A0	u-boot,spl-sfc-no-dma;
> =C2=A0	pinctrl-names =3D "default";
> =C2=A0	pinctrl-0 =3D <&fspim2_pins>;
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> =C2=A0	status =3D "okay";
> =C2=A0
> =C2=A0	flash@0 {
> diff --git a/arch/arm/dts/rk3588-rock-5b.dts b/arch/arm/dts/rk3588-rock-5=
b.dts
> index 8ab60968f275..8618887899d9 100644
> --- a/arch/arm/dts/rk3588-rock-5b.dts
> +++ b/arch/arm/dts/rk3588-rock-5b.dts
> @@ -12,6 +12,7 @@
> =C2=A0	aliases {
> =C2=A0		mmc0 =3D &sdhci;
> =C2=A0		mmc1 =3D &sdmmc;
> +		mmc2 =3D &sdio;
> =C2=A0		serial2 =3D &uart2;
> =C2=A0	};
> =C2=A0
> @@ -44,6 +45,43 @@
> =C2=A0		#cooling-cells =3D <2>;
> =C2=A0	};
> =C2=A0
> +	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpios =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pcie2_0_vcc3v3_en>;
> +		regulator-name =3D "vcc3v3_pcie2x1l0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <50000>;
> +		vin-supply =3D <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_pcie2x1l2";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <5000>;
> +		vin-supply =3D <&vcc_3v3_s3>;
> +	};
> +
> +	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpios =3D <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pcie3_vcc3v3_en>;
> +		regulator-name =3D "vcc3v3_pcie30";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <5000>;
> +		vin-supply =3D <&vcc5v0_sys>;
> +	};
> +
> =C2=A0	vcc5v0_host: vcc5v0-host-regulator {
> =C2=A0		compatible =3D "regulator-fixed";
> =C2=A0		regulator-name =3D "vcc5v0_host";
> @@ -76,6 +114,29 @@
> =C2=A0		regulator-max-microvolt =3D <1100000>;
> =C2=A0		vin-supply =3D <&vcc5v0_sys>;
> =C2=A0	};
> +
> +	vcc3v3_wf: vcc3v3-wf-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_wf";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		enable-active-high;
> +		gpios =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&vcc3v3_wf_en>;
> +		startup-delay-us =3D <50000>;
> +		vin-supply =3D <&vcc5v0_sys>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status =3D "okay";
> +};
> +
> +&combphy1_ps {
> +	status =3D "okay";
> =C2=A0};
> =C2=A0
> =C2=A0&cpu_b0 {
> @@ -204,6 +265,34 @@
> =C2=A0	};
> =C2=A0};
> =C2=A0
> +&pcie2x1l0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie2_0_rst>;
> +	reset-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc3v3_pcie2x1l0>;
> +	status =3D "okay";
> +};
> +
> +&pcie2x1l2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie2_2_rst>;
> +	reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc3v3_pcie2x1l2>;
> +	status =3D "okay";
> +};
> +
> +&pcie30phy {
> +	status =3D "okay";
> +};
> +
> +&pcie3x4 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie3_rst>;
> +	reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> +	status =3D "okay";
> +};
> +
> =C2=A0&pinctrl {
> =C2=A0	hym8563 {
> =C2=A0		hym8563_int: hym8563-int {
> @@ -217,11 +306,41 @@
> =C2=A0		};
> =C2=A0	};
> =C2=A0
> +	pcie2 {
> +		pcie2_0_rst: pcie2-0-rst {
> +			rockchip,pins =3D <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
> +			rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie2_2_rst: pcie2-2-rst {
> +			rockchip,pins =3D <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie3 {
> +		pcie3_rst: pcie3-rst {
> +			rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> +			rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> =C2=A0	usb {
> =C2=A0		vcc5v0_host_en: vcc5v0-host-en {
> =C2=A0			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> =C2=A0		};
> =C2=A0	};
> +
> +	m2e {
> +		vcc3v3_wf_en: vcc3v3-wf-en {
> +			rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0&pwm1 {
> @@ -258,6 +377,27 @@
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> +&sdio {
> +	max-frequency =3D <200000000>;
> +	no-sd;
> +	no-mmc;
> +	non-removable;
> +	bus-width =3D <4>;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D <&vcc3v3_wf>;
> +	vqmmc-supply =3D <&vcc_1v8_s3>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&sdiom0_pins>;
> +	status =3D "okay";
> +};
> +
> =C2=A0&spi2 {
> =C2=A0	status =3D "okay";
> =C2=A0	assigned-clocks =3D <&cru CLK_SPI2>;
> diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot=
.dtsi
> index 68b419f3abd5..15de4706254e 100644
> --- a/arch/arm/dts/rk3588-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-u-boot.dtsi
> @@ -3,7 +3,6 @@
> =C2=A0 * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
> =C2=A0 */
> =C2=A0
> -#include "rockchip-u-boot.dtsi"
> =C2=A0#include "rk3588s-u-boot.dtsi"
> =C2=A0
> =C2=A0/ {
> diff --git a/arch/arm/dts/rk3588s-pinctrl.dtsi b/arch/arm/dts/rk3588s-pin=
ctrl.dtsi
> index 48181671eacb..63151d9d2377 100644
> --- a/arch/arm/dts/rk3588s-pinctrl.dtsi
> +++ b/arch/arm/dts/rk3588s-pinctrl.dtsi
> @@ -1349,6 +1349,41 @@
> =C2=A0	};
> =C2=A0
> =C2=A0	i2s2 {
> +		/omit-if-no-ref/
> +		i2s2m0_lrck: i2s2m0-lrck {
> +			rockchip,pins =3D
> +				/* i2s2m0_lrck */
> +				<2 RK_PC0 2 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		i2s2m0_mclk: i2s2m0-mclk {
> +			rockchip,pins =3D
> +				/* i2s2m0_mclk */
> +				<2 RK_PB6 2 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		i2s2m0_sclk: i2s2m0-sclk {
> +			rockchip,pins =3D
> +				/* i2s2m0_sclk */
> +				<2 RK_PB7 2 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		i2s2m0_sdi: i2s2m0-sdi {
> +			rockchip,pins =3D
> +				/* i2s2m0_sdi */
> +				<2 RK_PC3 2 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		i2s2m0_sdo: i2s2m0-sdo {
> +			rockchip,pins =3D
> +				/* i2s2m0_sdo */
> +				<4 RK_PC3 2 &pcfg_pull_none>;
> +		};
> +
> =C2=A0		/omit-if-no-ref/
> =C2=A0		i2s2m1_lrck: i2s2m1-lrck {
> =C2=A0			rockchip,pins =3D
> @@ -3307,6 +3342,15 @@
> =C2=A0	};
> =C2=A0
> =C2=A0	uart9 {
> +		/omit-if-no-ref/
> +		uart9m0_xfer: uart9m0-xfer {
> +			rockchip,pins =3D
> +				/* uart9_rx_m0 */
> +				<2 RK_PC4 10 &pcfg_pull_up>,
> +				/* uart9_tx_m0 */
> +				<2 RK_PC2 10 &pcfg_pull_up>;
> +		};
> +
> =C2=A0		/omit-if-no-ref/
> =C2=A0		uart9m1_xfer: uart9m1-xfer {
> =C2=A0			rockchip,pins =3D
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk35=
88s-rock-5a-u-boot.dtsi
> index c47b0a7112c8..584476f77b13 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -4,10 +4,6 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "rk3588s-u-boot.dtsi"
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/usb/pd.h>
> =C2=A0
> =C2=A0/ {
> =C2=A0	chosen {
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-bo=
ot.dtsi
> index 27b2d7eff87b..878936fa07d6 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -4,7 +4,6 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "rockchip-u-boot.dtsi"
> -#include <dt-bindings/phy/phy.h>
> =C2=A0
> =C2=A0/ {
> =C2=A0	aliases {
> @@ -102,15 +101,6 @@
> =C2=A0		reg =3D <0x0 0xfd5c8000 0x0 0x4000>;
> =C2=A0	};
> =C2=A0
> -	sfc: spi@fe2b0000 {
> -		compatible =3D "rockchip,sfc";
> -		reg =3D <0x0 0xfe2b0000 0x0 0x4000>;
> -		interrupts =3D <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks =3D <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> -		clock-names =3D "clk_sfc", "hclk_sfc";
> -		status =3D "disabled";
> -	};
> -
> =C2=A0	rng: rng@fe378000 {
> =C2=A0		compatible =3D "rockchip,trngv1";
> =C2=A0		reg =3D <0x0 0xfe378000 0x0 0x200>;
> diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
> index 5544f66c6ff4..1a820a5a51eb 100644
> --- a/arch/arm/dts/rk3588s.dtsi
> +++ b/arch/arm/dts/rk3588s.dtsi
> @@ -1424,6 +1424,17 @@
> =C2=A0		};
> =C2=A0	};
> =C2=A0
> +	sfc: spi@fe2b0000 {
> +		compatible =3D "rockchip,sfc";
> +		reg =3D <0x0 0xfe2b0000 0x0 0x4000>;
> +		interrupts =3D <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +		clock-names =3D "clk_sfc", "hclk_sfc";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		status =3D "disabled";
> +	};
> +
> =C2=A0	sdmmc: mmc@fe2c0000 {
> =C2=A0		compatible =3D "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-msh=
c";
> =C2=A0		reg =3D <0x0 0xfe2c0000 0x0 0x4000>;
