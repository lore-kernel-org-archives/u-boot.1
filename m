Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882DBC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 08:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB5B81F45;
	Wed, 16 Apr 2025 10:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bXbAaOAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E3382A27; Wed, 16 Apr 2025 10:56:05 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066F881CAF
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 10:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHGb1nlFY1+HjAbeLqYMFGCWRqNdhR2UNbbMhMvTA4ujc1xpyacHXXlHQIIn+YumNiej/fTxPUIMUAKBWyGEg6yaBJCk7K4TCeeZnt0iDnuHVSnAIYY8cVL5953IQ+wMO462yxhgYQbno7sqDrb6Lqk2mpDqkoFsiSWe+9muXEHtqo7dtJXudxDU0bU904PZlSXPoU0a5vMVIULqri5JnwoXW7dHuWRM5Tnb/mxU+OPWiqay0YR8/IQZX7O0bb5HUs20j98aCdVbSzqB2M6EVLmOn+9zzu3zVljcJ44nqHtTmwe3AANzBLpBMvN0Didws/EG23oTerMk5vJys57nZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCt9Z0aH/Gd4smtf7MVfYV2+vT898dSbDtgT7OtNGDU=;
 b=RohxLKtpwQKO+kdzJUeHIOhznIePXAfko6tKCNFPhVIauhVPoJJXXmvlBY6AuYPnGGE1jgVaiDbDEa3RfGZgjDj7ujG5uY/3nxPj7IDtLU0atZNRGTezyTpAy3fnEUwTjMfpv1EKgVNm1h8sBfcRp8gM9Kf+JwwFAZo8IUetLWxtDFpcfePExbJOq1vlNOx+H/upHTm23xtGw3Q9bXUAUzIWZtw/IAqrQXIJ8zUIw7q9sFHC8QHndvE0IfeHfGruasH6i3I29ghktbbayVD3hHoQcr4lOh2MPXm2TdF12h1SaQIA3WZ/Eb5OtZeDIvLdQCXAZKU9hK0Hp/8OjqR/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCt9Z0aH/Gd4smtf7MVfYV2+vT898dSbDtgT7OtNGDU=;
 b=bXbAaOAzgWKdx8idgrg/X6Rr9aQD786R/5OrPJqPr+WefWGS0xGluZvSClyFDF3/kFPa6SDI14EFQMeAuVUbBi4MthWNbjEZ1UodeOv8JRQ7VUxRhzhWD0nFNOsb0mOPeNk6QcteVNMuoNbGDGW+gdslxrz0cew8dU0UhV9iYDcXFCcdLPIBAIdJVqwK832FVazS4g7Wi+LHflhZt3GIeaYCRmd9YqXSgI76drQ+s27RIlYLWwAeF5z1pPZUG9xyXEpGt0WgLHpu9rvVqUhd/o3kclseUzJYX2aSEdS0Xt5CWb+iZHNw/5ogdOuZLv90dppgriXegDiSQ0T75fYikg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5285.namprd03.prod.outlook.com (2603:10b6:610:9c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 08:55:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 08:55:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>
Subject: RE: [PATCH v1] arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as
 output
Thread-Topic: [PATCH v1] arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as
 output
Thread-Index: AQHbrqt5WqjaC8CdgE6J0/Uwm9bv4bOl/V9w
Date: Wed, 16 Apr 2025 08:55:58 +0000
Message-ID: <LV8PR03MB8137BA66BFCF078A26BFD36FA7BD2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250416084212.14313-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250416084212.14313-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5285:EE_
x-ms-office365-filtering-correlation-id: 7b9d9cd6-635c-40f9-f4c6-08dd7cc481c6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tUwQHrfyTDeon/5TsgTZPOB7ZqIpmN78kiDckog3hTsFH6bpZMbo7aYGp58e?=
 =?us-ascii?Q?q9AGAcnVvqGBOIkDObUMhNhmd96pOh7HpNkeOTuTab8bMdcEvhERyjBuVjUA?=
 =?us-ascii?Q?ZMQA/0wVtuShZJHrk+ZH7JAExlGTBb7dcyOmYTFz6MLXJujMIv3plDvEpKt2?=
 =?us-ascii?Q?lLCV+Jw4AJr+4TCUkYqNCI/UR122wK/IvOOcv32wJzTo79du2NXLspH0mHYe?=
 =?us-ascii?Q?msVeP6h1IZCxWfmiiXRQcwHcnid/ifvplyuoPTLmNlhUenhkVNWVshqStIkH?=
 =?us-ascii?Q?FFJyHezUpBUX4kuXqg72ikfM7+1X//KsSpW47FYOenRvhA1XneeBZVXBie82?=
 =?us-ascii?Q?9EJa0QNh03L78CtWtAVnMMPxQE/QFuEqMPU+cukOUOAa/sA9wgBtNV7JHoLv?=
 =?us-ascii?Q?jmCkfJnStnol5YO2VAdckOETtVyiF1YA1AlXdlbQkTCP5Dx34+nKiccd88HY?=
 =?us-ascii?Q?CJ2eK1/yjcCjx2v6Dw77dxpUkI4on1TnC86hj4CDENQwuuTR5rzkm4Bg6Izj?=
 =?us-ascii?Q?Yr3820lyaHwJc6HDPFtiTq4Y2JgZVSxBAhJGyTf0350RNCdgFcMtRT3weyhu?=
 =?us-ascii?Q?rNcBpjr8sfm4Ka8PTIPJAt+73Qc+a/2iApaHMDLfaorKMokzsFvCC6AvS7cw?=
 =?us-ascii?Q?CfssUfxiXA3ntcEgPBALYJMSiwjZhRspFyOKQ8/4eBQjAFyUEvu61utwPRTA?=
 =?us-ascii?Q?U3qUHn2wmnQr1765e1GED+P2VELviejqR4wZwvDc6aOGVWS8qAjtwOKAEYqw?=
 =?us-ascii?Q?w8e+ovQF555p3AUPrDPJrbSVVJsfmMcC2st035IqCr0SsgMj17y5GXt47bzF?=
 =?us-ascii?Q?0puX6NyjhlnSrTFdU8sGzE1GYeWN9ScrXw3LP3uOR7sZBrc8ix0+lU15JIN/?=
 =?us-ascii?Q?upglPHCX3U3+KsVaW/vPXltjuKj+S7AydV+0ErknIgJfdL5tbJo9C8nyakr3?=
 =?us-ascii?Q?NIFiBYxzbJULryctWPrR8XjMV/6ouHU3jJXpHLChGHA8Iszx+99HHTxjQQIm?=
 =?us-ascii?Q?qp9U1W2/mLOlLzLeEiYR+flNBLriO2cHehweTxp9sCKZaZdWyO4uO229QwVd?=
 =?us-ascii?Q?0epxqbtAoQaMHJKzk6JMtmPDDTC6xT6WArB2dH+qyg/AjgI3am4UCMGslgy+?=
 =?us-ascii?Q?kSq1blRj2NkstgN95QG+EJHu8MXCwNolgFtvo95GUnFk0uLMhPHZU4uFUrf6?=
 =?us-ascii?Q?s71T8DU+zYqiGl1H+N0cJdJFEW/krGMvRGjL1FJ+MhYWObnb8XH0kap9Bs6/?=
 =?us-ascii?Q?0AhK0WomC3k6qTYR6jF/x2jB16EdK09fJF/6xzrz61dOzyOGdYNjzQFskD3C?=
 =?us-ascii?Q?O96a1vhyuJLmGnPRgT0PN9g4d95ldARtNrGMAk4ByiJLEEXOm/ryj/6h8EEw?=
 =?us-ascii?Q?9RoZfAVhPOfvp3PoLtFDcYkh4HDJgheqOJ7fa6lYowKGt0SEaIsmo1EgNgDP?=
 =?us-ascii?Q?2naMCfUsMbl+WlIbTbYWUrPJU7i1t68aDRxDnZdqswnNUX0F5u2e6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgCmQRNSv9QVIiLJUTUW8fJH/yixD6OOPMPmnDicCUNSBuZtUg+d5mhOZPY6?=
 =?us-ascii?Q?4OHv4fmN0pXZZrJAcUgcVQJW7m5CO8PzJM7oGzlcqmpxr6aSM6ys8sgnMWnB?=
 =?us-ascii?Q?PO8jKsICv1P4gIGAa9WkCKZYgfoJunqOOPO5StqFIlx091hsJEEq0kLUv85l?=
 =?us-ascii?Q?ySQ6lwzQAs32FUQ0BokFdaG5xg1k0sq8dnQEHoofzHRkTeFBGGK3Aig6qyaf?=
 =?us-ascii?Q?Ma/VLqnn4upoTJmEmOfTYKDU3hD39g5NGJlAxJ4aOiW/0RG8dpLyjs1NA2UY?=
 =?us-ascii?Q?gJQ/W+lyxrJOlbesezzPiXZ7o4iW1x8MwWpg6mtpVb1aEpPSbD6ZLzudtZun?=
 =?us-ascii?Q?fMwSyGTsi30Nd1G5s1F14EfiymsFUTH9X4FpJd3GOQFmEloxVfN8nhUO92le?=
 =?us-ascii?Q?HsbRTgDoAST9n3EJVQHpLqoAEIRnhiH5J0+CBxZE/HeSbyDJzvJ7cK8DLpfm?=
 =?us-ascii?Q?Na+9NwmaVC5OPQ8O7WW5QBFC+3t0FGRO6ZGjNARYdAGkmbCJADv7Gb001IW1?=
 =?us-ascii?Q?UE3MFM0Db3FyCV25FwGTdsybO4ZwUholyvu1TVeNbPgBcUYuGbkV+NQG24Yz?=
 =?us-ascii?Q?i6eOYflLmmozpLn7p4bDsbpF6dyrPGp83nsaNdO5VQREWVP8Y3TDwtIiE1MH?=
 =?us-ascii?Q?equNxEe2/XEjVmOr2RxTQjhz3YP4pvGER6J/ZaF4CMxC87oz/ZqRowYoHjyN?=
 =?us-ascii?Q?zymEXWWtCnFsdwU1JQKaB4WHXnAATteQ2klfhX6BtwPiDWRntYrhhGhzpDEC?=
 =?us-ascii?Q?6RqdQscRR8AKu+8K8ZXvf66N/YkBK4NlXiMZ2lGdZKIrDQP9ZJngkRP7QUCG?=
 =?us-ascii?Q?NuamBbCPOZ3CyWwi7yBp2ZeRbfg0NlHCYO5E/aiEsMdyz1oA8lJLKIBC8GZa?=
 =?us-ascii?Q?rtC5QELrbWQ3iD1w0RvVktkbrQTHb25zrjpFiDhejkzi/akPptY4aEZAkXJw?=
 =?us-ascii?Q?d1gLVF02nWhNsVKaAHC46qEvWVQYeoacY9XX3TSmQOdzpJb94bRx2nv2MnEE?=
 =?us-ascii?Q?2Efix4mqGinze2O4/lno8R5SAd/KzOg6ngd8Y2SoKEFaG6pDUDUU4nGqxNNE?=
 =?us-ascii?Q?BahvJffJWxv9Wd2zx4f4elesttzKkDILdwkL7pGzaTKMXCUyBSu1FuqxL6yR?=
 =?us-ascii?Q?neAPn8STbBpwJ1AdRGwNe65eacGJXrQvn4guyGMnDKxxZ4Hs4wFQtw7QmoMO?=
 =?us-ascii?Q?6tC1ov331v/PgZ1GgP7z/znHKJgBLiFHUSdvpzFXLmJuUC+4sY+EbOVSvHLb?=
 =?us-ascii?Q?pYw/qkkusyiUHzBu5/jE8s5B3lJcVIOEaAaQ/CjiPd3T+3NBJrndL7nlc9BK?=
 =?us-ascii?Q?NHNOsJHiOUGARMs/UcM8PLVqm1xHttpnEQrMPDYPyjPuXT0Y+f2ldCoJ5aX6?=
 =?us-ascii?Q?LAMehfJ0FR2qb8QLUiG2PfGltvXCa24oKvZHodyu8zoJDYDbeasRlHl884km?=
 =?us-ascii?Q?NcumZv74ORlYH/0LXuFXIdbnF0PADdWD5hgeWsxslhCcGVNCSjT9eTuHi3YL?=
 =?us-ascii?Q?3FwVScJFQM+Setozv8UOg733trIk8m87sps+KrT1CswoHb9vKtzLTw7VFmPx?=
 =?us-ascii?Q?9wgpOhubGQJJl7QH/FnDETELqGVpurW85PlDRmTD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9d9cd6-635c-40f9-f4c6-08dd7cc481c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 08:55:58.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPlkexPc6Q8QyqMjK7jZzto+0hw8mBzTmDqQpMh39IL4Cfdcg8lrwwr5ZVQpYz1VMkN8aQ4RhZ0uX3yB/TcVQ14pbR8plcQ0bXGplZZut1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5285
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Wednesday, April 16, 2025 4:42 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Alif Zakuan Yuslaimi
> <alif.zakuan.yuslaimi@intel.com>
> Subject: [PATCH v1] arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as out=
put
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
>=20
> Use GPIO hogging method in device tree to set SDIO_SEL pin (portb3)
> direction as output with value 0 after power-on reset.
>=20
> This is to ensure stable 0V voltage reading from SDIO_SEL GPIO pin after
> board init.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> ---
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 11 +++++++++++
>  configs/socfpga_agilex5_defconfig        |  3 +++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index 8d6503dd091..b34af85c58d 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -673,6 +673,17 @@
>  	bootph-all;
>  };
>=20
> +&gpio1 {
> +	/* Configure GPIO 1 pin 3 as output pin with value 0 during GPIO
> probe */
> +	portb: gpio-controller@0{
> +		sdio_sel {
> +			gpio-hog;
> +			gpios =3D <3 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	reset-names =3D "i2c";
>  };
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 8f327e5f2ab..cf0d678e1a2 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_SOCFPGA=3Dy
>  CONFIG_TEXT_BASE=3D0x80200000
> +CONFIG_SPL_GPIO=3Dy
>  CONFIG_NR_DRAM_BANKS=3D3
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> @@ -73,6 +74,8 @@ CONFIG_BOOTFILE=3D"kernel.itb"
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_GPIO_HOG=3Dy
> +CONFIG_SPL_GPIO_HOG=3Dy
>  CONFIG_DWAPB_GPIO=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_DW=3Dy
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

