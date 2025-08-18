Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AA7CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BA183844;
	Mon, 18 Aug 2025 10:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08D6831BE; Mon, 18 Aug 2025 08:46:01 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A048352B
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi66bBlO7QNt+FtjR/NUcthMloVtYhzs8LMZpsxM9JlhII2U0mztMzKNLN/qWP0kkRgB8mkEWxBiF6P9uGAqhL3R+yXdgeL7tb1dA+Z2H63ok7FRF1dsg2Hn7fGfHtCMPmZ53TYLYUGdOIoqzElVwaFW3urPSMmSMYx2V/76MRTP6VlwUCPeVPxPauTipEDblSih7OzyER6QEjNzbyE7oxyUJVDDJGTx6W+ahKKaZziHV8q1CxKoF6QaPw+MDwMGXSqId9c4vzvCF5sxXHhEIT/XRrT5LdTWfPr2QR6hYiIiioyOlLUyV2iqZR6LZuAXL/nmcA1XBwsnz27pGLtyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpHLsZ8HobDYfWJHw9/asG/WAV4QDQmXwBGYCa+bxlY=;
 b=K8lld1YM8fc1UWfHSFghYb2W7KhqhYM8sYlMxF2ok1urlw9lsxSF6/2kGfJmx51p7TOqPKp9rYCWeFe5mi7ijVwE7URHch97mjqevddfRDnm+zjqUR+HJys3v0j8hWuFYyZmAWe8RsVowqb1ebRwLwheTNfBTu/JcC+XT56fYkdBEaKbgax0u0+oP4ncCQMlZNOy1KyVcaJYEMqPS0ElQrwPW92mYl6yxIggUadRvtyJESjYk71tG4iDiURs7EB1HQ3qsJXYB2Rw+4kVOAD8RrK+atD23AAYjyfZpAeLHkEggmRBg4ECldsr/bOO0J/BMRSDk9nhNd0ovECpH3c3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:45:51 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:45:51 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Thread-Topic: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Thread-Index: AQHcDaLFVxz64PwVM0K3XGZt6+8+hbRn+flg
Date: Mon, 18 Aug 2025 06:45:51 +0000
Message-ID: <ZQ2PR01MB1307043F4B7527EA41FF1754E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250815050315.62956-1-e@freeshell.de>
In-Reply-To: <20250815050315.62956-1-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_
x-ms-office365-filtering-correlation-id: 2a2b76ba-3f04-44d6-6f58-08ddde22df5d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700018; 
x-microsoft-antispam-message-info: xidMGxm/3yf3814TzBSqlJnQmPp15YqQlMS3VNdAsUdvdXUKlrQFH/qj0/jZpRIuy/uRCGsqJooC1tq+/Eo5F1F2narbt6G6xp7h/6hHFa4radsLIGJEFjclH03OANcfLNG9ipT830HmcjUK03I4bYYf+QZUxhIeMlZabnzgkigORGnUIMGyk/KCAJJzYPJDX1ao7epWk0wz4kn5nKLGNfEIBXi/6zyWEgxU/HvysW8GERjjVnJMp88h6IkTNXF67HfAIZPl7R695933p1GIrqPRKH6Kn4AvWXLWsD+E1Y5Id0lHnYlyGDytHcDKfQXMpFgqMBOszFm64M2cBsB3b0EQoTH/tLIw2dYXK5yOBOC+xE9vVYzdyYKnfPTzM/fGZHcgmQRtLXTcxhotPiSwgQKFsroiby/ll44Z3S6XQbAsgNFlDAoWOpNXZIr3IoS5Y+cOxQSZXfvujCj+CoADseDELeLIX2EwQALmZiTrc73+zT/wln+dp3/uedqvaU03/6i9zGLeeElaxCNaoM9M22OZNulvts4cbHsouqbCPoSlOZpVDdOOW++IRLASZspcYE9iIe8aB1TZz2OUL9h3qwSjkM99sGo9Fhw7M4EtCvI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Ivxk9CPXnpZVpnRYigdkdqRiktr0ikzvax+WM8lzcftnoyHStJJ92S1OrgW?=
 =?us-ascii?Q?PRl1jpVRHu9o9rpELQ5LPE2B+DQMff4vQOKWw4stvwHwXSEZw2X8mYvC35Ci?=
 =?us-ascii?Q?fvXT6SW4PZiI9ttVwdeI3F5IzHlajl9MHCMoHiz7I5YcK5C1Mz/a/IBabgsL?=
 =?us-ascii?Q?ZqO4XyFD9bwBpHgk/7IE+l97p4SC1IgqFAub7p4T7oJq6HNq+K76ofBNdYaM?=
 =?us-ascii?Q?YDV6VKgLTpq6yiBrXtY7CR4BrNtQoSjL2v+yM7hNE5xj8dpInRqJ7WzONWvt?=
 =?us-ascii?Q?UfMQkxS+P5wTXi6yEFjbbVi7nTHnVY2uG15k1hV8xobhUmq6l7RCeb88rHca?=
 =?us-ascii?Q?z5EBK8hqjnBZNFXDOqwsSMGENSfMXpjdoO2UqBFvFDmIrY+dULPnAj3TiRPj?=
 =?us-ascii?Q?bjDumCf0f6cLLWtLk6GceMY2Wnq2EiDpmXF2DccX0BZ4m64W3KRqdXxPZR2U?=
 =?us-ascii?Q?0xhGTDSDnUc8OkdraBIX1YXCPVw0qexCgCtrTExDIi0WsNIIus/rKoUBbMIC?=
 =?us-ascii?Q?7odlVP/0gumGY0g5FYktNc2oqWjss17R1Lvr0FRFnbyy42kUDbk/I2Ba+K8w?=
 =?us-ascii?Q?TTvIveqhlFmbkIsPaq4qqII4roPnOFtt7xqdhDX4tDCQmYZodXl7/P+1hWMJ?=
 =?us-ascii?Q?RFN76uDIL1gvcAhqxEXOBPq4yAeey/XmRTUnrfLB9Sgf+pOgVAgntKrWJ5VO?=
 =?us-ascii?Q?7Sw1UXW+ahxIJGqdS9HC748ycs/MyyayMrb81Vmfhhayac8TIVSI+iYYFg6d?=
 =?us-ascii?Q?f9mDyH2x0y3DW/tQzi/Z2a4aUeLdeLSXV7GJJpA1uH/e6gjxdOB24k0L3+Bp?=
 =?us-ascii?Q?mtAQS7hlwlkoIgebMUn7HREUajAkbAMtXs8tU0A7xZTu1JuFN7sygVjVbEhH?=
 =?us-ascii?Q?zHBQHL10vVxuj1ZRXCq6obUpWk09DSOpvtXowfgFLD/VFl4OiurQgOCyj3tZ?=
 =?us-ascii?Q?KBwVvFzNKbBl3ujnmdLGNyOCPd8EUYE9ioxpJ2y4gjH+IivrqXXX7kjlZmB4?=
 =?us-ascii?Q?XBBKEmByARbJdspkDl3pKAs5jVZpV7vHHzQ0GO7STsImR7Q9DlVfghc/R2K7?=
 =?us-ascii?Q?eTPSD669uEnsPCYOEqGasXSPk6FnYIdscxH0mXuU5yFc5vdyG571PtmZzB52?=
 =?us-ascii?Q?cjWjmFm9NW5jTAgjQ5fH67JTrE37fV8co7xB70QJrgdqwQCGWJQwEnpo9lRt?=
 =?us-ascii?Q?9y3HhhZgCHIYRxRtgFECexbz05e3TVk7xALdruyvvheMRWCr5TPZbjQhjzd2?=
 =?us-ascii?Q?KvmnzsjSR09rFuoaI8/BBRa+J1PyMj5caP09OblRyiHTTAodCO63k3/qFOTS?=
 =?us-ascii?Q?ONMMZQQXhYNgBpGIKmU2L96uRGNxn1hHQBkc7Kb2zJBBkAt2tk5qwkzsxNS7?=
 =?us-ascii?Q?coSTTcCQdwJupvxOlmfuGXEVc9DyIJjzlWC2xqBqtVSO6c053khb4xVIkkTO?=
 =?us-ascii?Q?THnj2Nfy3IfeiZMU8lvGwe2peBNKey668Mms+Da+j4b0pz5gRnDuhdqn3teI?=
 =?us-ascii?Q?cRft9B0WRmSw0M83k4boarF5TMf8a5/dfIeR86hgExGcfRCwriiziCZU6U5b?=
 =?us-ascii?Q?HFCtLEVQSBOvDHscHx3ZNE0CB+MctX6lJCMAQLpvjN/gaEpmfflaJNh2P6qD?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2b76ba-3f04-44d6-6f58-08ddde22df5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 06:45:51.3961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C82GR/sk5yHZ72uz9cmvMivClthhRjexYSA1w4Nnqb2y2N+ljetyMTW3D+lNEuqr1yCWfulU6VOqZqCq/E5Knr2Cgn/m5kZCRB7DWrB3miw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305
X-Mailman-Approved-At: Mon, 18 Aug 2025 10:02:44 +0200
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

> On 15.08.25 13:03, E Shattow wrote:=20
> Prune jh7110-common-u-boot.dtsi (clocks, qspi flash, eeprom, and bootph-
> pre-ram hints now upstream since devicetree-rebasing v6.16) and replace b=
y
> remaining dependency jh7110-u-boot.dtsi (not yet upstream).
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 99 -------------------
>  .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |  2 +-
> arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  2 +-
>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |  2 +-
>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |  2 +-  ...10-starfive-vi=
sionfive-
> 2-v1.3b-u-boot.dtsi |  2 +-
>  6 files changed, 5 insertions(+), 104 deletions(-)  delete mode 100644
> arch/riscv/dts/jh7110-common-u-boot.dtsi
>=20
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> deleted file mode 100644
> index 049b0a7ce28..00000000000
> --- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> -/*
> - * Copyright (C) 2023 StarFive Technology Co., Ltd.
> - */
> -
> -#include "jh7110-u-boot.dtsi"
> -/ {
> -	aliases {
> -		spi0 =3D &qspi;
> -	};
> -
> -	chosen {
> -		bootph-pre-ram;
> -	};
> -
> -	firmware {
> -		spi0 =3D &qspi;
> -		bootph-pre-ram;
> -	};
> -
> -	memory@40000000 {
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&uart0 {
> -	bootph-pre-ram;
> -	reg-offset =3D <0>;
> -	current-speed =3D <115200>;
> -};
> -
> -&mmc0 {
> -	bootph-pre-ram;
> -};
> -
> -&mmc1 {
> -	bootph-pre-ram;
> -};
> -
> -&qspi {
> -	bootph-pre-ram;
> -
> -	flash@0 {
> -		bootph-pre-ram;
> -		cdns,read-delay =3D <2>;
> -		spi-max-frequency =3D <100000000>;
> -	};
> -};
> -
> -&syscrg {
> -	assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -	assigned-clock-parents =3D <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> -	assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> -};
> -
> -&sysgpio {
> -	bootph-pre-ram;
> -};
> -
> -&mmc0_pins {
> -	bootph-pre-ram;
> -	rst-pins {
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&mmc1_pins {
> -	bootph-pre-ram;
> -	clk-pins {
> -		bootph-pre-ram;
> -	};
> -
> -	mmc-pins {
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&i2c5_pins {
> -	bootph-pre-ram;
> -	i2c-pins {
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&i2c5 {
> -	bootph-pre-ram;
> -	eeprom@50 {
> -		bootph-pre-ram;
> -		compatible =3D "atmel,24c04";
> -		reg =3D <0x50>;
> -		pagesize =3D <16>;
> -	};
> -};
> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> index ab882d07f6f..b9202f2acce 100644
> --- a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> @@ -3,5 +3,5 @@
>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>   */
>=20
> -#include "jh7110-common-u-boot.dtsi"
> +#include "jh7110-u-boot.dtsi"
>  #include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> index ab882d07f6f..b9202f2acce 100644
> --- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> @@ -3,5 +3,5 @@
>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>   */
>=20
> -#include "jh7110-common-u-boot.dtsi"
> +#include "jh7110-u-boot.dtsi"
>  #include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> index ab882d07f6f..b9202f2acce 100644
> --- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> @@ -3,5 +3,5 @@
>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>   */
>=20
> -#include "jh7110-common-u-boot.dtsi"
> +#include "jh7110-u-boot.dtsi"
>  #include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dts=
i
> b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> index ab882d07f6f..b9202f2acce 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> @@ -3,5 +3,5 @@
>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>   */
>=20
> -#include "jh7110-common-u-boot.dtsi"
> +#include "jh7110-u-boot.dtsi"
>  #include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dts=
i
> b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index 874074174ff..848ed8225ac 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -3,5 +3,5 @@
>   * Copyright (C) 2023 StarFive Technology Co., Ltd.
>   */
>=20
> -#include "jh7110-common-u-boot.dtsi"
> +#include "jh7110-u-boot.dtsi"
>  #include "starfive-visionfive2-binman.dtsi"
>=20
> base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac

I find that there are no ''bootph-pre-ram'' in mmc0_pins and mmc1_pins in
dts/upstream/src/riscv/starfive/jh7110-common.dtsi.

Is it ready now to drop jh7110-common-u-boot.dtsi?

Best regards,
Hal
