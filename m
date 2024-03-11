Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB05C54791
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 00:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA2687C2D;
	Mon, 11 Mar 2024 01:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="sSYojfRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5311D81EEF; Mon, 11 Mar 2024 01:32:21 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDE987E3F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 01:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIzGLDNWnlIjh1WcZGe36e3g4+srQd/4mTl/5ngpXSqBlSeCpxIPV+mIrh1babzg3owknvKS4W0R+iicfxFcJqPTxUy8Sj0Y7+k+apepwcQ33BONloMcPEqthELumzrTyKve7czXPFKlr2sVJOWPuDp5BNkPp5NmZiBAc/E9iUViNPKMeHYL0xnnJwUXjDWM6kgPUqnn4VarwHfN1ZpSI0ckIkoqmp+19gEKmtBuqS4SXqkvLA4gOoKa1npsKJrgAU/fZ+oEoj1vzHIotGdlPNKKpxhPSIIrPnNFggHEJJHSXePxm142fmAzxtqLInFWOtlnhvVTInlYPNk4IcuR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNLoSZylZFI0qdRI4vkZLZDUkn9bTuNZz4N6QLqcINA=;
 b=FWLyoXXwdtJfzkppABKEBniHSc+TQMt+7aiTqPI/eWGSw5IKdOcx3olcAIveCpgcphx5Zj4B4tYIpD67BoS+KYO+0HO8exuwSO+PavAyamc/N2Wj3s+UzWMun0GBmShNz7SvtLOQoA+x+uJIOyMDOFvMjA2kqAe+bnvNoU/B1ZM9g+iJhGqQi8HzclHBYOjTJ5KUlB1s+smv7cogQZ7FiiKn7ImaIDWzBpR2PgWiMoR8aJAc6TXvITuevVtFrOgTI8aZup+dqnPKp84k6SdRTV4Me5B7TbPqe2ubdSj0icN+jyshL52a9lKLHASVpYsTM0ZvdFBmSz3I7yWtK63h/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNLoSZylZFI0qdRI4vkZLZDUkn9bTuNZz4N6QLqcINA=;
 b=sSYojfRFN/3YObdAPke47IB8iUJ4c3eMhZZtXzAqTARGmY24hko3qJtQs40WpVkgqvz5yhmhV7srJqzUoY+Gwr/8HyqbIF7mSDCNYoJnMfSAPv0UwdXrwBNkbufMUmNh7/ZAHzw0BLRayeS0/KQ3Z1uUKULUmrapnxwT8GDyGRE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9663.eurprd04.prod.outlook.com (2603:10a6:102:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 00:32:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 00:32:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "aford@beaconembedded.com" <aford@beaconembedded.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: RE: [PATCH] arm: dts: imx8mp-beacon-kit:  Resync DTS with Linux 6.8
Thread-Topic: [PATCH] arm: dts: imx8mp-beacon-kit:  Resync DTS with Linux 6.8
Thread-Index: AQHacwxIKWtrTbbF0Em9J+KFDUnkULExsOog
Date: Mon, 11 Mar 2024 00:32:16 +0000
Message-ID: <DU0PR04MB9417F03D3BB99B2F2FE5B09E88242@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240310165903.69275-1-aford173@gmail.com>
In-Reply-To: <20240310165903.69275-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9663:EE_
x-ms-office365-filtering-correlation-id: d257f6ae-b292-4ccc-e162-08dc4162b466
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcPETLuF3sb6TxmgusTEYw7s0Y61Wad7FeOD+0TUYzD8GMC9+qH6GjNKZ5tr1XCMJ0leBylGGh0Mnms7bA7yahizK/2MoXyJXHL7zHNEgKetmPak2UOA/AtwzrVQvzATErY+GhAZpeZLzmvYGCFKSkdLQUGGSPARbFDh6y4u18+QMk00IC+zLrzCDItnRch2CZn+4zWlQKjRSAkM+nkHpa75Yc1nI+jJz4VnJHwxvsSpSGwMg5am9VDnjYrpv0RgvhgIoMKMb6fnL7dW3o7ASBnT9C1N/oSM7AgA8iiThmcqQoqp+u/+FpIit/1UIvAjyNh8Sesr1JzBQDCvCNYki6xUmb/uiIB/0GHYNJNs6U5XHETlqRkF52g4TQat4/3CpHB1rsjGt7c7Lst5e0CJuGP/kWTBw7uOKYX/JXboegIwLXRA6GSo8VqbXygqLCOIkiJySVweiAQvOM/fwpto0C8RbntSKNyT+eloVf79N63n3lLUP/PkkpWbH4vjIHC14YDWdSaXwp0D/VSuqInsoYa5iHDa8fwXRXFfCecwThqrbOGMcCRnJsd9lDSC6PjftIjlQLpLzkw2zN75ouoLZCoGmKoNXqdKfpdHq2HriMrhtArhNj7JC5QGtLa1PLKvi3eQUZXW+yLUBzs7kuCNNhMilDJCNJlA7Qeju4ZScE34DBzso8H6Z0RL3+owxNtETq5q+Oau9AU1EjR9wV6uDiKjXSGmUCSq4HRqaEqUeqk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKmKMdaWtIVQfyIEDhYXpP/zx8h9MhVzJ38abQ6Em/rln4NFU9uOmRaE8stn?=
 =?us-ascii?Q?K5lyASepwa8pj5h/5Qv2fWSF6oAsPi2eqISJYzkKD/FcCq7e1zNJzBQdbP3B?=
 =?us-ascii?Q?MkjfWDmf45F9K/WvVtVdzsipErejFctXMZ7BqF+R7Jyxk+pY8Jl4OmKFp0Ch?=
 =?us-ascii?Q?UBLo4QN4xNRjNcxxF+cNB0+Hwxu1OW7DakSOINUZtzoChwUySDwJ6xGivKun?=
 =?us-ascii?Q?hHnSKx4FYRrsrN03wcWm8co+NGIegicJLxHkMtfJiV8HgEJRnhBhBOQivV23?=
 =?us-ascii?Q?4IQKUnwZzAU7eYf2SfOxGa85v+LH1krZltRChVYMRsJv+Q9zPuTYvtg2Tkzl?=
 =?us-ascii?Q?A3OvtQ1DHkwFJF8iEqC6DpQxF3l7N+D1NpyiEoueJNfNUP+FdRbdCtVr2rZ1?=
 =?us-ascii?Q?e01JNE3aLhCyYLFmCsYwwu5sQtCtYC2rzs2lV4BFe0rLU7/B87ClxPIXbn7A?=
 =?us-ascii?Q?fqQgX6UQhGo5ieR3OoS0TDJOh9kHQh8XlwE52t35Ek2Z+Kp5oRIfEhvOPdV5?=
 =?us-ascii?Q?N3+zkbksKyx0YG2jg9ElI05MHtpWIicJfyey/U4oiuNHgqUV8PfpqxOXUVPp?=
 =?us-ascii?Q?aAXChPLHAJ/h+Hksu9y3g/m613ZMgnxxksDl+oGtPGbb1bhJqJUznGEvMJaN?=
 =?us-ascii?Q?Oegg8hLoZYec+aHBjVhLfuXooogKlR8ZnJZYC3MXWfq1SKFd5JBeqPO4vtIO?=
 =?us-ascii?Q?hpP/QYLFcLhKp+lKtR0IJRVT8x0h4Dc0U2IjpEDwgiMH4ssfu2/wWdD882Dz?=
 =?us-ascii?Q?2DiIGGllV3ReHgn0LGWglbImzohETOBdS/ndMbDdhYY9Kfsq1GX30mT2cp/o?=
 =?us-ascii?Q?WeguEYGV7gKCgbgLU7gTchqn2lnHqjdhboNjVOOe8e5/FkHz2FjcUyHvP4ya?=
 =?us-ascii?Q?sZL+90jNUyDEUxdgOdaAyykiZk8E2IiC8MryVNaD/KD9KbxlPUErW4hgyybw?=
 =?us-ascii?Q?sL5sVd3OqarTGcSTs+zXC28DwXtr3Tc/FgUoEoUhD7ZP15iyZG+gxAOd5Au1?=
 =?us-ascii?Q?z3fSqCZ3RPQ+J0Srrf7lzJS57eTTF4meUAUUwVjakLhqX0p4tibyq2JzGBEZ?=
 =?us-ascii?Q?ffsZt3XdOYf95VMmJDjB+o6GJitHq4+gkDgqViProQpLgvMrTwUtZpbDzTLg?=
 =?us-ascii?Q?iJfkqSBOqHh7h2MjtIWRJ2/mSzlkJOaV4s+Ca18uP1OIOLJVAE5BF5X43pOc?=
 =?us-ascii?Q?1Q3D1StcyzKFTl5zMb3jA1AfTpDAQtKrpnIkKZknILo9n6IbMrksjvqtW5Ro?=
 =?us-ascii?Q?WtIVtBA+n0wl5sqNpNNDkLBavlT2ooYwTzjDMIP9TjrVEoWLDJMfJiHqV+H+?=
 =?us-ascii?Q?SZG1aSuZ9vyb/p6zN8GQVAeKNRlHzj8iyDByeSG50QM8QqH34vu+Bq7H9kH3?=
 =?us-ascii?Q?kq7wGhaAiFsjuzSgJjPg/fGSfQBA7jeD85wPEoSpNDfkooQ5po+lEHSQu9zV?=
 =?us-ascii?Q?LB0mi1zas+WxWCLLVCkK3ObvyljL30IS37sW+Vxh4ERuOQbCs5jIbyK72ivo?=
 =?us-ascii?Q?v0AJJG1M8M4FAkDvZyCbe8Uj2ZMg34W8ug624t00MOt9rrUIe1uwbn1ITi8o?=
 =?us-ascii?Q?mh7t2NKftQ9EloC0Y88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d257f6ae-b292-4ccc-e162-08dc4162b466
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 00:32:16.8445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZIVhqRwLifTgWQ8A8CK9sHwDX1MyfSqwadSNFfkRq6OKO0bk92ECGLLIr20tZSqnPY4+V65dosB6aaLrbpcHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663
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

> Subject: [PATCH] arm: dts: imx8mp-beacon-kit: Resync DTS with Linux 6.8
>=20
> The device tree has evolved over time, so re-sync.  This also partial rev=
erts
> one change on the PCIe, because U-Boot doesn't have a proper driver.
> However, since the clock is configured to generate a 100MHz reference clo=
ck
> by default, a proper driver isn't really necessary.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
>=20
> diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
> b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
> index 393fd8ec2e..ed183f83a7 100644
> --- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
> @@ -6,6 +6,13 @@
>  #include "imx8mp-u-boot.dtsi"
>=20
>  / {
> +	/* U-Boot does not yet have a proper PCIe clk driver */
> +	pcie0_refclk: clock-pcie {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <100000000>;
> +	};
> +
>  	wdt-reboot {
>  		compatible =3D "wdt-reboot";
>  		wdt =3D <&wdog1>;
> @@ -13,6 +20,10 @@
>  	};
>  };
>=20
> +&pcie_phy {
> +	clocks =3D <&pcie0_refclk>;
> +};
> +
>  &{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
>  	bootph-pre-ram;
>  };
> diff --git a/arch/arm/dts/imx8mp-beacon-kit.dts b/arch/arm/dts/imx8mp-
> beacon-kit.dts
> index cdae45a48c..a08057410b 100644
> --- a/arch/arm/dts/imx8mp-beacon-kit.dts
> +++ b/arch/arm/dts/imx8mp-beacon-kit.dts
> @@ -23,6 +23,12 @@
>  		stdout-path =3D &uart2;
>  	};
>=20
> +	clk_xtal25: clock-xtal25 {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <25000000>;
> +	};
> +
>  	connector {
>  		compatible =3D "usb-c-connector";
>  		label =3D "USB-C";
> @@ -49,6 +55,12 @@
>  		};
>  	};
>=20
> +	dmic_codec: dmic-codec {
> +		compatible =3D "dmic-codec";
> +		num-channels =3D <1>;
> +		#sound-dai-cells =3D <0>;
> +	};
> +
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
>  		autorepeat;
> @@ -82,6 +94,17 @@
>  		};
>  	};
>=20
> +	bridge-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint =3D <&adv7535_out>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible =3D "gpio-leds";
>  		pinctrl-names =3D "default";
> @@ -112,10 +135,13 @@
>  		};
>  	};
>=20
> -	pcie0_refclk: clock-pcie {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <100000000>;
> +	reg_audio: regulator-wm8962 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "3v3_aud";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
>  	};
>=20
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
> @@ -137,6 +163,68 @@
>  		gpio =3D <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	sound-adv7535 {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "sound-adv7535";
> +		simple-audio-card,format =3D "i2s";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&sai5>;
> +			system-clock-direction-out;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&adv_bridge>;
> +		};
> +	};
> +
> +	sound-dmic {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "sound-pdm";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,bitclock-master =3D <&dailink_master>;
> +		simple-audio-card,frame-master =3D <&dailink_master>;
> +
> +		dailink_master: simple-audio-card,cpu {
> +			sound-dai =3D <&micfil>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&dmic_codec>;
> +		};
> +	};
> +
> +	sound-wm8962 {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "wm8962";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,widgets =3D "Headphone", "Headphones",
> +					    "Microphone", "Headset Mic",
> +					    "Speaker", "Speaker";
> +		simple-audio-card,routing =3D "Headphones", "HPOUTL",
> +					    "Headphones", "HPOUTR",
> +					    "Speaker", "SPKOUTL",
> +					    "Speaker", "SPKOUTR",
> +					    "Headset Mic", "MICBIAS",
> +					    "IN3R", "Headset Mic";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&sai3>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&wm8962>;
> +			clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
> +};
> +
> +&audio_blk_ctrl {
> +	assigned-clocks =3D <&clk IMX8MP_AUDIO_PLL1>, <&clk
> IMX8MP_AUDIO_PLL2>;
> +	assigned-clock-rates =3D <393216000>, <135475200>;
>  };
>=20
>  &ecspi2 {
> @@ -146,7 +234,7 @@
>  	status =3D "okay";
>=20
>  	tpm: tpm@0 {
> -		compatible =3D "infineon,slb9670";
> +		compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
>  		reg =3D <0>;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&pinctrl_tpm>;
> @@ -211,6 +299,42 @@
>  		interrupt-controller;
>  		#interrupt-cells =3D <2>;
>  	};
> +
> +	adv_bridge: hdmi@3d {
> +		compatible =3D "adi,adv7535";
> +		reg =3D <0x3d>, <0x3c>, <0x3e>, <0x3f>;
> +		reg-names =3D "main", "cec", "edid", "packet";
> +		adi,dsi-lanes =3D <4>;
> +		#sound-dai-cells =3D <0>;
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				reg =3D <0>;
> +
> +				adv7535_in: endpoint {
> +					remote-endpoint =3D <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg =3D <1>;
> +
> +				adv7535_out: endpoint {
> +					remote-endpoint =3D <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
> +
> +	pcieclk: clock-generator@68 {
> +		compatible =3D "renesas,9fgv0241";
> +		reg =3D <0x68>;
> +		clocks =3D <&clk_xtal25>;
> +		#clock-cells =3D <1>;
> +	};
>  };
>=20
>  &i2c3 {
> @@ -239,6 +363,34 @@
>  	clock-frequency =3D <384000>;
>  	status =3D "okay";
>=20
> +	wm8962: audio-codec@1a {
> +		compatible =3D "wlf,wm8962";
> +		reg =3D <0x1a>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_wm8962>;
> +		clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +		assigned-clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +		assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +		assigned-clock-rates =3D <22576000>;
> +		DCVDD-supply =3D <&reg_audio>;
> +		DBVDD-supply =3D <&reg_audio>;
> +		AVDD-supply =3D <&reg_audio>;
> +		CPVDD-supply =3D <&reg_audio>;
> +		MICVDD-supply =3D <&reg_audio>;
> +		PLLVDD-supply =3D <&reg_audio>;
> +		SPKVDD1-supply =3D <&reg_audio>;
> +		SPKVDD2-supply =3D <&reg_audio>;
> +		gpio-cfg =3D <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +		#sound-dai-cells =3D <0>;
> +	};
> +
>  	pca6416: gpio@20 {
>  		compatible =3D "nxp,pcal6416";
>  		reg =3D <0x20>;
> @@ -301,6 +453,34 @@
>  	};
>  };
>=20
> +&lcdif1 {
> +	status =3D "okay";
> +};
> +
> +&micfil {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pdm>;
> +	assigned-clocks =3D <&clk IMX8MP_CLK_PDM>;
> +	assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates =3D <49152000>;
> +	status =3D "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,esc-clock-frequency =3D <10000000>;
> +	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			reg =3D <1>;
> +
> +			dsi_out: endpoint {
> +				remote-endpoint =3D <&adv7535_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &pcie {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_pcie>;
> @@ -309,12 +489,34 @@
>  };
>=20
>  &pcie_phy {
> +	fsl,clkreq-unsupported;
>  	fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> -	clocks =3D <&pcie0_refclk>;
> +	clocks =3D <&pcieclk 1>;
>  	clock-names =3D "ref";
>  	status =3D "okay";
>  };
>=20
> +&sai3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_sai3>;
> +	assigned-clocks =3D <&clk IMX8MP_CLK_SAI3>,
> +			  <&clk IMX8MP_AUDIO_PLL2> ;
> +	assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	assigned-clock-rates =3D <12288000>, <361267200>;
> +	fsl,sai-mclk-direction-output;
> +	status =3D "okay";
> +};
> +
> +&sai5 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_sai5>;
> +	assigned-clocks =3D <&clk IMX8MP_CLK_SAI5>;
> +	assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates =3D <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status =3D "okay";
> +};
> +
>  &snvs_pwrkey {
>  	status =3D "okay";
>  };
> @@ -471,12 +673,37 @@
>  		>;
>  	};
>=20
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK
> 		0xd6
> +
> 	MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00
> 	0xd6
> +		>;
> +	};
> +
>  	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19
> 	0x40
>  		>;
>  	};
>=20
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins =3D <
> +
> 	MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
> +
> 	MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
> +
> 	MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00
> 	0xd6
> +
> 	MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00
> 	0xd6
> +
> 	MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
> +		>;
> +	};
> +
> +	pinctrl_sai5: sai5grp {
> +		fsl,pins =3D <
> +
> 	MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI5_TX_DATA00
> 	0xd6
> +
> 	MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK	0xd6
> +
> 	MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC	0xd6
> +		>;
> +	};
> +
>  	pinctrl_tpm: tpmgrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00
> 	0x19 /* Reset */
> @@ -547,4 +774,10 @@
>  			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12
> 	0x1c4
>  		>;
>  	};
> +
> +	pinctrl_wm8962: wm8962grp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1
> 	0x59
> +		>;
> +	};
>  };
> diff --git a/arch/arm/dts/imx8mp-beacon-som.dtsi b/arch/arm/dts/imx8mp-
> beacon-som.dtsi
> index e5da908047..8be251b693 100644
> --- a/arch/arm/dts/imx8mp-beacon-som.dtsi
> +++ b/arch/arm/dts/imx8mp-beacon-som.dtsi
> @@ -50,6 +50,8 @@
>  	phy-mode =3D "rgmii-id";
>  	phy-handle =3D <&ethphy0>;
>  	snps,force_thresh_dma_mode;
> +	snps,mtl-rx-config =3D <&mtl_rx_setup>;
> +	snps,mtl-tx-config =3D <&mtl_tx_setup>;
>  	status =3D "okay";
>=20
>  	mdio {
> @@ -66,6 +68,71 @@
>  			interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
>  		};
>  	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use =3D <5>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x1>;
> +			snps,map-to-dma-channel =3D <0>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x2>;
> +			snps,map-to-dma-channel =3D <1>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x4>;
> +			snps,map-to-dma-channel =3D <2>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x8>;
> +			snps,map-to-dma-channel =3D <3>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0xf0>;
> +			snps,map-to-dma-channel =3D <4>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use =3D <5>;
> +		snps,tx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x2>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x4>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0x8>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority =3D <0xf0>;
> +		};
> +	};
>  };
>=20
>  &flexspi {
> @@ -206,6 +273,10 @@
>  	assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_80M>;
>  	uart-has-rtscts;
>  	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "nxp,88w8997-bt";
> +	};
>  };
>=20
>  &usdhc1 {
> --
> 2.43.0

