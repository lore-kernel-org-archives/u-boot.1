Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5A6C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F6F87F1C;
	Mon, 26 Feb 2024 18:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Qp90OHlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD29287F1E; Mon, 26 Feb 2024 18:43:24 +0100 (CET)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F23787F09
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2HPRFR38xVXuR6P/wVn7yfP2fgo0c91P6H0tqus9kpr2DKTgIct/17mfabei+aunlOqFCal9RS53Yl2OWRwoTDWTnK6wDFeCkeFEGo48QbxEzCCUyo++y5EYsKklkoyxTLdeEfuA7wC8y1+vuj6YgVQsWWt9MnFMQoS3feX0TB+wzK/Jp8HZ1jYSs8gIIJCe6gBdsrn2NAxvewHpLcXYqUTTQZ+v3ZUtssHoLlpNilOrHCR6UyqP/MrVNVqo9ROUkUWJNtDTHqCqfKRjS/x+irH7u8VOIhwUzn4v9R7OAnTU2+Aq5SC6OdlGZI68ZPq64G6lvh2WiDLqjcwZCjGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjHSZ2DivnqUxEHT8aSa9TbD63pkN2HMVOHYKFFZSCg=;
 b=JXtrSU7kTiWjDLAeCWNIhAyexQtrVxi/TPMQQghNuROSr8YvxZdkiG4DM3V4onpSifkgrAsB5FBlw3QgAuwaAu1vlKS51UqzHdXYx6dv7MY7XVGErHfSMAOOQoZ7VN1GJYDNHOzsVAUQQPAUr5XxizV5l4qHWWmIMnC+FCOZb4W1K8TsU1eIL325+g1wF8xf0eRQ8N4CgNxdZiWuOWhP0QisncWispTQwRcbnbZalmh16mh5cSkRQ5KsgKNFNRTM4O+L+z8kbtonRIrcjsIqzInwqh/FciG6QmQCcJVYYHH/fbpfDYwOXJspuVoDIGwxmDOFJjLp7pcXu+X86rgyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjHSZ2DivnqUxEHT8aSa9TbD63pkN2HMVOHYKFFZSCg=;
 b=Qp90OHlJmcOUyyp56jE06dC/4HsQBgcohXyEZcLDq4eIXyuWM06fqOYS5kI2GqxBYyeocPRkVKBjHTxkNH1YvDThcLplJFJ01z/V+0nCyFQbDcFrpLB2UbMUk3ZnsUoREJcwFIFHezXFpCdlIaHGUJ+jAJL8+lT4bIKyubuRen8=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB9328.jpnprd01.prod.outlook.com
 (2603:1096:604:1d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 17:43:13 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 17:43:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
CC: Paul Barker <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 3/7] i2c: rzg2l: Add I2C driver for RZ/G2L family
Thread-Topic: [PATCH v2 3/7] i2c: rzg2l: Add I2C driver for RZ/G2L family
Thread-Index: AQHaaMVlNY46F2BShE6bUldgrwLSdrEc5MPg
Date: Mon, 26 Feb 2024 17:43:13 +0000
Message-ID: <TYCPR01MB11269A743C5C909887C788AF2865A2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-4-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240226150536.1690-4-paul.barker.ct@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB9328:EE_
x-ms-office365-filtering-correlation-id: b100b114-94fa-41b7-8e52-08dc36f267f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqhSnt33f0v1W7jV4d9jovIE9qKMNiNUTZriHNJotxX6D8IzZ9TSoDBw7Ws64/9w027nLyzTGVYZb3d1yqb9+qLMRciiSb39T9HPangPhCq8D5/nHXZLwyIzuHdt4O1m4xcF3MMHMxxa9HJG2qYU+56Lt4ywEPQmu0pypaTn2i7zUSXb2t1nY5lwe22kRm8Z0tGb8Oo/bJJQNueuiv2gopf6T9tgfhwqDzlFoptGZToQXQYDyAxl9GvEgntV/r+rcKU/mdr9pZWl4d7Y5ZJe8TAuAFeU8IkXLoQGhaqdIc1J2oz5+iyzB76W/GqOilC2lYbyzGbvsuUiJOj+vNtPuKj3j6oW4cJRll0sYfFZogOnxf8Fjiiia22AYgal6ykcBqAftOvl7lksK0ZdbViMb7cyJ3yOO1bffD6srseN8HuoMla+PLOUZIlUMxU3G4ZC42YOn1rVkix4ZtI9E3bB/hiE6oYiYA9R1FIFPE8/8MRyoLiO6LTBhFkTuP2UDowagHerBjf9TbtDC67ybN1i2FzAr48WWhjIwT1UC2iPEXz6nD9/fN7ONEvn0/kIgRuxo2BpuAe8oTIgp0t+RCJXwLtVVymJJaSyXJMmdfUVeVNrmjeQ3uXWL2eCKgJMQzq0o3hnj+s9DqN9GF1iZ5g2zeq2Sy+Vj2KnTjOTzMHrtqUjK5Qyqr2AQ5u9XkvaNhXgrcgx7yHjF5T/D1TOo+MUFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11269.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UR96YEat9OXHwnSgbHHl1/Wu/L6IjPHbaIqyhb1W63ouYaEKjGfJi34X2FoZ?=
 =?us-ascii?Q?o+Cam27DviS4bKERxUcCVn8u8w4BqBSuXV17JtnA2jv34wU7bWqsT+FTZ67V?=
 =?us-ascii?Q?cvAu/U3byxBsS1DxWBO+cXdZnaFXu4+vp7jvvZmTacBAFxzsvx10Did1NdqQ?=
 =?us-ascii?Q?aylKpKIIUMgr0mvrFDO+Xsn4hfYDo0r7YXay5ItOmQcNfLSUxL4OgL9gDRH+?=
 =?us-ascii?Q?OLPBMO3yqNu48JWqB6ZiiR86Qwbk/OmSCDayFRKA+0v6IhOhDoLFGx8MQOYr?=
 =?us-ascii?Q?JKjyKwtD5yWjCqK4yAp7ZW09pdQlw1YMn6IQUqHrrX9yOspYkTJicdFAzYqh?=
 =?us-ascii?Q?DOOaWyv6QqIyX6UZCrDPLramyAYBgeEScCCUQ3xbW/LHWMjf+yAAqQjRgWJw?=
 =?us-ascii?Q?6HOmpf5nvx7Y6ByLGymKW2oUtyibyrOY29cHGaYMJoeLyvZvx+GOVhWmaVXT?=
 =?us-ascii?Q?jawpKu3aPVFjMseS8l5+zKDt+tCCkcCJ1D/8vXJoCX0N1BHw+kSPX3k77gPD?=
 =?us-ascii?Q?UA75+dk0IKO98X68D3AecFK4Gb5FO1yQGs7LleWIat67mqhsouuvklhlz7lR?=
 =?us-ascii?Q?SVfItK2Hl5N2dSuCc3a3dXWq3f3mHq96UC1z5qMU54llZOeaRb2pJj3F+/bq?=
 =?us-ascii?Q?qXoz+uMg0V4x52Qx2oTQlJMx/ALrc8OwlmW8NknNc80xFAGXxEv9gAH4MSMB?=
 =?us-ascii?Q?rTUmDzjpjBkCqtm4XIHL3OSEjeQMUgNYkO+ZjdlLca2huyXlPiOaqAgA8eay?=
 =?us-ascii?Q?uZGzxiofNAIOggdOqEIsTeWEvkqWocS+/tugyeuBJpVkMuSddIdp2EkfPtxG?=
 =?us-ascii?Q?mWmulvS+7BNNUGnVwnvpl8ehUJFbTKrvM8Mvr22zMmxFBq9I3YBf7vycEisB?=
 =?us-ascii?Q?qy4MWRbAXQCVVEsxCB0eeHn92VMWzvoW1zm8YXF2rv6BW5kkUFnetCNA5Jus?=
 =?us-ascii?Q?/hIcTV4SfKY7z/oJQbac/tvLKCi2ugjkySQuLi/ognMa7i/yfQCHxNFGiJtC?=
 =?us-ascii?Q?PF1nZuBpd8JY8NPiuh3ZTxRpIsiGNbMeKqtdN9kg0a4MIao4UENoS8xq0I9i?=
 =?us-ascii?Q?OWEzkTFMjFMu8LdDqqA3mwemwWJSrsohNRonaGloSK0JzDxlAFvzWYhhz76T?=
 =?us-ascii?Q?kRnaqFoDdNe1HRn8iySlY+H4zNpRYVDCZe6p2zvfwqMAKo/NOfgzRSxnFQT7?=
 =?us-ascii?Q?aPAv4lSwf7LSkYNWXfvtaThOUk9FDxhjWmXuvIytJ2YGHjPnGp6pQm4eJQd4?=
 =?us-ascii?Q?bWn7rMS2P6NgLdnTMaaYHK3x5BOeMtgr5bidpUFkDdgtbCR/2dkGSVf/BtqL?=
 =?us-ascii?Q?/hhXu9JNN6Rz2Xp8iSW2nVVtJZAJkxaDa/gBjO54nc0Ts4PujSOwnGUsWYno?=
 =?us-ascii?Q?KcC78N/DuNbDbmGSzxBcmZ252q1QB2YM0b7PvxIDAhU5i54BTprMezyBUgwd?=
 =?us-ascii?Q?7ljMyCO2RiMPIds7ff9oNXMRhuMarPGFbCs6I6J3SxaglyLsHkrJsSrcIywE?=
 =?us-ascii?Q?ZYTc2A7QOpF1S3I4sYpWBTH/9GSzBYImYI+sXjfXQptBml5fOiB6VGsCmPij?=
 =?us-ascii?Q?nOuLhpDJIsWEf508yJNAesg9r5BJLWZZRY3tkCbl2CppZ/WVFKfjhWrjr7S0?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b100b114-94fa-41b7-8e52-08dc36f267f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 17:43:13.3507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p01UCKP5BhCK5cpsgP7PV8yo/kKL+Jtq/N5eavNJ+VbZeA4HognjpfwNGVJERxXnfbBH6NKNbTuzJkkI4K4uXhrDDZBsvcAYki1394MrFZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9328
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Paul Barker
> Sent: Monday, February 26, 2024 3:06 PM
> To: Marek Vasut <marek.vasut+renesas@mailbox.org>; Nobuhiro Iwamatsu
> <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>; u-boot@lists.denx.de
> Subject: [PATCH v2 3/7] i2c: rzg2l: Add I2C driver for RZ/G2L family
>=20
> This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044) SoC=
,
> also known as the RIIC module.
>=20
> This patch is based on both the u-boot driver in the Renesas RZ BSP
> 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.7 driver (commi=
t
> 0dd3ee311255).
>=20
> Support for deblocking the I2C bus is included as this may be needed afte=
r
> triggering a reset via the Power Management IC (PMIC) over I2C (the PMIC
> asserts the reset line before the SoC completes the I2C write transaction
> with obvious bus locking effects). If the SDA line is observed to be low
> during initialisation, we automatically attempt to deblock.
>=20
> [1]:
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> eviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Typo. R is missing in the Rb tag.

Also change log is missing.

> ---
>  arch/arm/mach-rmobile/Kconfig         |   1 +
>  configs/renesas_rzg2l_smarc_defconfig |   2 +
>  drivers/i2c/Kconfig                   |   7 +
>  drivers/i2c/Makefile                  |   1 +
>  drivers/i2c/rz_riic.c                 | 624 ++++++++++++++++++++++++++
>  5 files changed, 635 insertions(+)
>  create mode 100644 drivers/i2c/rz_riic.c
>=20
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfi=
g
> index 2bb96749fc0d..38ede6e0b5b5 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -78,6 +78,7 @@ config RZG2L
>  	imply RENESAS_SDHI
>  	imply RZG2L_GPIO
>  	imply SCIF_CONSOLE
> +	imply SYS_I2C_RZ_RIIC
>  	imply SYS_MALLOC_F
>  	help
>  	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
> diff --git a/configs/renesas_rzg2l_smarc_defconfig
> b/configs/renesas_rzg2l_smarc_defconfig
> index e45579ae6b98..ad46297c6619 100644
> --- a/configs/renesas_rzg2l_smarc_defconfig
> +++ b/configs/renesas_rzg2l_smarc_defconfig
> @@ -24,6 +24,7 @@ CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_CMD_CLK=3Dy
>  CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_PART=3Dy
>  CONFIG_CMD_EXT2=3Dy
> @@ -44,6 +45,7 @@ CONFIG_CLK=3Dy
>  CONFIG_CLK_RENESAS=3Dy
>  # CONFIG_CLK_RCAR_GEN3 is not set
>  CONFIG_GPIO_HOG=3Dy
> +CONFIG_DM_I2C=3Dy
>  CONFIG_MMC_IO_VOLTAGE=3Dy
>  CONFIG_MMC_UHS_SUPPORT=3Dy
>  CONFIG_MMC_HS400_SUPPORT=3Dy
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig index
> 4f42200f3923..d2a3a13493aa 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -524,6 +524,13 @@ config SYS_I2C_ROCKCHIP
>  	  have several I2C ports and all are provided, controlled by the
>  	  device tree.
>=20
> +config SYS_I2C_RZ_RIIC
> +	bool "Renesas RZ/G2L RIIC driver"
> +	depends on RZG2L && DM_I2C
> +	help
> +	  Support for the I2C controller (RIIC) on the Renesas RZ/G2L SoC
> +	  family.
> +
>  config SYS_I2C_SANDBOX
>  	bool "Sandbox I2C driver"
>  	depends on SANDBOX && DM_I2C
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile index
> a96a8c7e955e..692f63bafd02 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SYS_I2C_QUP) +=3D qup_i2c.o
>  obj-$(CONFIG_SYS_I2C_RCAR_I2C) +=3D rcar_i2c.o
>  obj-$(CONFIG_SYS_I2C_RCAR_IIC) +=3D rcar_iic.o
>  obj-$(CONFIG_SYS_I2C_ROCKCHIP) +=3D rk_i2c.o
> +obj-$(CONFIG_SYS_I2C_RZ_RIIC) +=3D rz_riic.o
>  obj-$(CONFIG_SYS_I2C_S3C24X0) +=3D s3c24x0_i2c.o exynos_hs_i2c.o
>  obj-$(CONFIG_SYS_I2C_SANDBOX) +=3D sandbox_i2c.o i2c-emul-uclass.o
>  obj-$(CONFIG_SYS_I2C_SH) +=3D sh_i2c.o
> diff --git a/drivers/i2c/rz_riic.c b/drivers/i2c/rz_riic.c new file mode
> 100644 index 000000000000..5f3f8d1b24b7
> --- /dev/null
> +++ b/drivers/i2c/rz_riic.c
> @@ -0,0 +1,624 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RZ/G2L I2C (RIIC) driver
> + *
> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <i2c.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <reset.h>
> +#include <wait_bit.h>
> +
> +#define RIIC_ICCR1	0x00
> +#define RIIC_ICCR2	0x04
> +#define RIIC_ICMR1	0x08
> +#define RIIC_ICMR2	0x0c
> +#define RIIC_ICMR3	0x10
> +#define RIIC_ICFER	0x14
> +#define RIIC_ICSER	0x18
> +#define RIIC_ICIER	0x1c
> +#define RIIC_ICSR1	0x20
> +#define RIIC_ICSR2	0x24
> +#define RIIC_ICSAR0	0x28
> +#define RIIC_ICBRL	0x34
> +#define RIIC_ICBRH	0x38
> +#define RIIC_ICDRT	0x3c
> +#define RIIC_ICDRR	0x40
> +
> +/* ICCR1 */
> +#define ICCR1_ICE	BIT(7)
> +#define ICCR1_IICRST	BIT(6)
> +#define ICCR1_CLO	BIT(5)
> +#define ICCR1_SOWP	BIT(4)
> +#define ICCR1_SCLO	BIT(3)
> +#define ICCR1_SDAO	BIT(2)
> +#define ICCR1_SCLI	BIT(1)
> +#define ICCR1_SDAI	BIT(0)
> +
> +/* ICCR2 */
> +#define ICCR2_BBSY	BIT(7)
> +#define ICCR2_MST	BIT(6)
> +#define ICCR2_TRS	BIT(5)
> +#define ICCR2_SP	BIT(3)
> +#define ICCR2_RS	BIT(2)
> +#define ICCR2_ST	BIT(1)
> +
> +/* ICMR1 */
> +#define ICMR1_MTWP	BIT(7)
> +#define ICMR1_CKS_MASK	GENMASK(6, 4)
> +#define ICMR1_BCWP	BIT(3)
> +#define ICMR1_BC_MASK	GENMASK(2, 0)
> +
> +#define ICMR1_CKS(x)	(((x) << 4) & ICMR1_CKS_MASK)
> +#define ICMR1_BC(x)	((x) & ICMR1_BC_MASK)
> +
> +/* ICMR2 */
> +#define ICMR2_DLCS	BIT(7)
> +#define ICMR2_SDDL_MASK	GENMASK(6, 4)
> +#define ICMR2_TMOH	BIT(2)
> +#define ICMR2_TMOL	BIT(1)
> +#define ICMR2_TMOS	BIT(0)
> +
> +/* ICMR3 */
> +#define ICMR3_SMBS	BIT(7)
> +#define ICMR3_WAIT	BIT(6)
> +#define ICMR3_RDRFS	BIT(5)
> +#define ICMR3_ACKWP	BIT(4)
> +#define ICMR3_ACKBT	BIT(3)
> +#define ICMR3_ACKBR	BIT(2)
> +#define ICMR3_NF_MASK	GENMASK(1, 0)
> +
> +/* ICFER */
> +#define ICFER_FMPE	BIT(7)
> +#define ICFER_SCLE	BIT(6)
> +#define ICFER_NFE	BIT(5)
> +#define ICFER_NACKE	BIT(4)
> +#define ICFER_SALE	BIT(3)
> +#define ICFER_NALE	BIT(2)
> +#define ICFER_MALE	BIT(1)
> +#define ICFER_TMOE	BIT(0)
> +
> +/* ICSER */
> +#define ICSER_HOAE	BIT(7)
> +#define ICSER_DIDE	BIT(5)
> +#define ICSER_GCAE	BIT(3)
> +#define ICSER_SAR2E	BIT(2)
> +#define ICSER_SAR1E	BIT(1)
> +#define ICSER_SAR0E	BIT(0)
> +
> +/* ICIER */
> +#define ICIER_TIE	BIT(7)
> +#define ICIER_TEIE	BIT(6)
> +#define ICIER_RIE	BIT(5)
> +#define ICIER_NAKIE	BIT(4)
> +#define ICIER_SPIE	BIT(3)
> +#define ICIER_STIE	BIT(2)
> +#define ICIER_ALIE	BIT(1)
> +#define ICIER_TMOIE	BIT(0)
> +
> +/* ICSR1 */
> +#define ICSR1_HOA	BIT(7)
> +#define ICSR1_DID	BIT(5)
> +#define ICSR1_GCA	BIT(3)
> +#define ICSR1_AAS2	BIT(2)
> +#define ICSR1_AAS1	BIT(1)
> +#define ICSR1_AAS0	BIT(0)
> +
> +/* ICSR2 */
> +#define ICSR2_TDRE	BIT(7)
> +#define ICSR2_TEND	BIT(6)
> +#define ICSR2_RDRF	BIT(5)
> +#define ICSR2_NACKF	BIT(4)
> +#define ICSR2_STOP	BIT(3)
> +#define ICSR2_START	BIT(2)
> +#define ICSR2_AL	BIT(1)
> +#define ICSR2_TMOF	BIT(0)
> +
> +/* ICBRH */
> +#define ICBRH_RESERVED	GENMASK(7, 5)	/* The write value should always
> be 1 */
> +#define ICBRH_BRH_MASK	GENMASK(4, 0)
> +
> +/* ICBRL */
> +#define ICBRL_RESERVED	GENMASK(7, 5)	/* The write value should always
> be 1 */
> +#define ICBRL_BRL_MASK	GENMASK(4, 0)
> +
> +#define RIIC_TIMEOUT_MSEC	100
> +
> +#define RIIC_FLAG_DEFAULT_SCL_RISE_TIME		BIT(0)
> +#define RIIC_FLAG_DEFAULT_SCL_FALL_TIME		BIT(1)
> +
> +/*
> + * If SDA is stuck in a low state, the I2C spec says up to 9 clock
> +cycles on SCL
> + * may be needed to unblock whichever other device on the bus is holding
> SDA low.
> + */
> +#define I2C_DEBLOCK_MAX_CYCLES 9
> +
> +struct riic_priv {
> +	void __iomem *base;
> +	struct clk clk;
> +	uint bus_speed;
> +	u32 scl_rise_ns;
> +	u32 scl_fall_ns;
> +	u32 flags;
> +};
> +
> +static int riic_check_busy(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	ret =3D wait_for_bit_8(priv->base + RIIC_ICCR2, ICCR2_BBSY, 0,
> +			     RIIC_TIMEOUT_MSEC, 0);
> +	if (ret =3D=3D -ETIMEDOUT) {
> +		dev_dbg(dev, "bus is busy!\n");
> +		return -EBUSY;
> +	}
> +
> +	return ret;
> +}
> +
> +static int riic_wait_for_icsr2(struct udevice *dev, u8 bit) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	ulong start =3D get_timer(0);
> +	u8 icsr2;
> +
> +	/* We can't use wait_for_bit_8() here as we need to check for NACK.
> */
> +	while (!((icsr2 =3D readb(priv->base + RIIC_ICSR2)) & bit)) {
> +		if (icsr2 & ICSR2_NACKF)
> +			return -EIO;
> +		if (get_timer(start) > RIIC_TIMEOUT_MSEC) {
> +			dev_dbg(dev, "timeout! (bit=3D%x, icsr2=3D%x, iccr2=3D%x)\n",
> +				bit, icsr2, readb(priv->base + RIIC_ICCR2));
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +		schedule();
> +	}
> +
> +	return 0;
> +}
> +
> +static int riic_check_nack_receive(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +
> +	if (readb(priv->base + RIIC_ICSR2) & ICSR2_NACKF) {
> +		dev_dbg(dev, "received nack!\n");
> +		/* received NACK */
> +		clrbits_8(priv->base + RIIC_ICSR2, ICSR2_NACKF);
> +		setbits_8(priv->base + RIIC_ICCR2, ICCR2_SP);
> +		readb(priv->base + RIIC_ICDRR);	/* dummy read */
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int riic_i2c_raw_write(struct udevice *dev, u8 *buf, size_t len)
> +{
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	size_t i;
> +	int ret;
> +
> +	for (i =3D 0; i < len; i++) {
> +		ret =3D riic_check_nack_receive(dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D riic_wait_for_icsr2(dev, ICSR2_TDRE);
> +		if (ret < 0)
> +			return ret;
> +
> +		writeb(buf[i], priv->base + RIIC_ICDRT);
> +	}
> +
> +	return riic_check_nack_receive(dev);
> +}
> +
> +static int riic_send_start_cond(struct udevice *dev, int restart) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	if (restart)
> +		setbits_8(priv->base + RIIC_ICCR2, ICCR2_RS);
> +	else
> +		setbits_8(priv->base + RIIC_ICCR2, ICCR2_ST);
> +
> +	ret =3D riic_wait_for_icsr2(dev, ICSR2_START);
> +	if (ret < 0)
> +		return ret;
> +	clrbits_8(priv->base + RIIC_ICSR2, ICSR2_START);
> +
> +	return ret;
> +}
> +
> +static int riic_receive_data(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int ret, stop_ret, i;
> +
> +	ret =3D riic_wait_for_icsr2(dev, ICSR2_RDRF);
> +	if (ret < 0)
> +		goto send_stop;
> +
> +	ret =3D riic_check_nack_receive(dev);
> +	if (ret < 0)
> +		goto send_stop;
> +
> +	setbits_8(priv->base + RIIC_ICMR3, ICMR3_WAIT | ICMR3_ACKWP |
> +ICMR3_RDRFS);
> +
> +	/* A dummy read must be performed to trigger data reception */
> +	readb(priv->base + RIIC_ICDRR);
> +
> +	for (i =3D 0; i < msg->len; i++) {
> +		ret =3D riic_wait_for_icsr2(dev, ICSR2_RDRF);
> +		if (ret < 0)
> +			goto send_stop;
> +
> +		if (i =3D=3D (msg->len - 1)) {
> +			clrbits_8(priv->base + RIIC_ICSR2, ICSR2_STOP);
> +			setbits_8(priv->base + RIIC_ICCR2, ICCR2_SP);
> +			setbits_8(priv->base + RIIC_ICMR3, ICMR3_ACKBT);
> +		} else {
> +			clrbits_8(priv->base + RIIC_ICMR3, ICMR3_ACKBT);
> +		}
> +
> +		msg->buf[i] =3D readb(priv->base + RIIC_ICDRR);
> +	};
> +
> +send_stop:
> +	if (ret) {
> +		/*
> +		 * We got here due to an error condition, so we need to
> perform
> +		 * a dummy read to issue the stop bit.
> +		 */
> +		clrbits_8(priv->base + RIIC_ICSR2, ICSR2_STOP);
> +		setbits_8(priv->base + RIIC_ICCR2, ICCR2_SP);
> +		readb(priv->base + RIIC_ICDRR);
> +	}
> +	stop_ret =3D riic_wait_for_icsr2(dev, ICSR2_STOP);
> +	clrbits_8(priv->base + RIIC_ICSR2, ICSR2_STOP | ICSR2_NACKF);
> +	clrbits_8(priv->base + RIIC_ICMR3, ICMR3_WAIT | ICMR3_ACKWP |
> ICMR3_RDRFS);
> +	return ret ? ret : stop_ret;
> +}
> +
> +static int riic_transmit_stop(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	clrbits_8(priv->base + RIIC_ICSR2, ICSR2_STOP);
> +	setbits_8(priv->base + RIIC_ICCR2, ICCR2_SP);
> +
> +	ret =3D riic_wait_for_icsr2(dev, ICSR2_STOP);
> +	clrbits_8(priv->base + RIIC_ICSR2, ICSR2_STOP | ICSR2_NACKF);
> +	return ret;
> +}
> +
> +static int riic_transmit_data(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	int ret, stop_ret;
> +
> +	ret =3D riic_i2c_raw_write(dev, msg->buf, msg->len);
> +	if (ret < 0)
> +		goto send_stop;
> +
> +	ret =3D riic_wait_for_icsr2(dev, ICSR2_TEND);
> +	if (ret < 0)
> +		goto send_stop;
> +
> +	if (!ret && !(msg->flags & I2C_M_STOP))
> +		return 0;
> +
> +send_stop:
> +	stop_ret =3D riic_transmit_stop(dev);
> +	return ret ? ret : stop_ret;
> +}
> +
> +static int riic_xfer_one(struct udevice *dev, struct i2c_msg *msg, int
> +first_msg) {
> +	u8 addr_byte =3D ((msg->addr << 1) | (msg->flags & I2C_M_RD));
> +	int ret;
> +
> +	if (!(msg->flags & I2C_M_NOSTART)) {
> +		/*
> +		 * Send a start for the first message and a restart for
> +		 * subsequent messages.
> +		 */
> +		ret =3D riic_send_start_cond(dev, !first_msg);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D riic_i2c_raw_write(dev, &addr_byte, 1);
> +	if (ret < 0) {
> +		/*
> +		 * We're aborting the transfer while still in master transmit
> +		 * mode.
> +		 */
> +		riic_transmit_stop(dev);
> +		return ret;
> +	}
> +
> +	if (msg->flags & I2C_M_RD)
> +		return riic_receive_data(dev, msg);
> +
> +	return riic_transmit_data(dev, msg);
> +}
> +
> +static int riic_xfer(struct udevice *dev, struct i2c_msg *msg, int
> +nmsgs) {
> +	int ret, i;
> +
> +	ret =3D riic_check_busy(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Ensure that the last message is terminated with a stop bit. */
> +	msg[nmsgs - 1].flags |=3D I2C_M_STOP;
> +
> +	for (i =3D 0; i < nmsgs; i++) {
> +		ret =3D riic_xfer_one(dev, &msg[i], !i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int riic_deblock(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int i =3D 0;
> +
> +	/*
> +	 * Issue clock cycles on SCL to hopefully unblock whatever is
> holding
> +	 * SDA low. These clock cycles may trigger error conditions such as
> +	 * Arbitration Lost, so we clear the status bits in ICSR2 after each
> +	 * cycle.
> +	 */
> +	while (!(readb(priv->base + RIIC_ICCR1) & ICCR1_SDAI)) {
> +		if (i++ =3D=3D I2C_DEBLOCK_MAX_CYCLES)
> +			return -EIO;
> +
> +		setbits_8(priv->base + RIIC_ICCR1, ICCR1_CLO);
> +		if (wait_for_bit_8(priv->base + RIIC_ICCR1, ICCR1_CLO, 0,
> +				   RIIC_TIMEOUT_MSEC, false))
> +			return -ETIMEDOUT;
> +		writeb(0, priv->base + RIIC_ICSR2);
> +	}
> +
> +	/*
> +	 * We have released SDA, but the I2C module is now out of sync
> +	 * with the bus state, so we need to reset its state machine.
> +	 */
> +	setbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +	clrbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +
> +	return 0;
> +}
> +
> +static int riic_set_bus_speed(struct udevice *dev, uint bus_speed) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	ulong refclk;
> +	uint total_ticks, cks, brl, brh;
> +
> +	if (bus_speed > I2C_SPEED_FAST_PLUS_RATE) {
> +		dev_err(dev, "unsupported bus speed (%dHz). %d max\n",
> bus_speed,
> +			I2C_SPEED_FAST_PLUS_RATE);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Assume the default register settings:
> +	 *  FER.SCLE =3D 1 (SCL sync circuit enabled, adds 2 or 3 cycles)
> +	 *  FER.NFE =3D 1 (noise circuit enabled)
> +	 *  MR3.NF =3D 0 (1 cycle of noise filtered out)
> +	 *
> +	 * Freq (CKS=3D000) =3D (I2CCLK + tr + tf)/ (BRH + 3 + 1) + (BRL + 3 +
> 1)
> +	 * Freq (CKS!=3D000) =3D (I2CCLK + tr + tf)/ (BRH + 2 + 1) + (BRL + 2 +
> 1)
> +	 */
> +
> +	/*
> +	 * Determine reference clock rate. We must be able to get the
> desired
> +	 * frequency with only 62 clock ticks max (31 high, 31 low).
> +	 * Aim for a duty of 60% LOW, 40% HIGH.
> +	 */
> +	refclk =3D clk_get_rate(&priv->clk);
> +	total_ticks =3D DIV_ROUND_UP(refclk, bus_speed ?: 1);
> +
> +	for (cks =3D 0; cks < 7; cks++) {
> +		/*
> +		 * 60% low time must be less than BRL + 2 + 1
> +		 * BRL max register value is 0x1F.
> +		 */
> +		brl =3D ((total_ticks * 6) / 10);
> +		if (brl <=3D (0x1f + 3))
> +			break;
> +
> +		total_ticks /=3D 2;
> +		refclk /=3D 2;
> +	}
> +
> +	if (brl > (0x1f + 3)) {
> +		dev_err(dev, "invalid speed (%u). Too slow.\n", bus_speed);
> +		return -EINVAL;
> +	}
> +
> +	brh =3D total_ticks - brl;
> +
> +	/* Remove automatic clock ticks for sync circuit and NF */
> +	if (cks =3D=3D 0) {
> +		brl -=3D 4;
> +		brh -=3D 4;
> +	} else {
> +		brl -=3D 3;
> +		brh -=3D 3;
> +	}
> +
> +	/*
> +	 * If SCL rise and fall times weren't set in the device tree, set
> them
> +	 * based on the desired bus speed and the maximum timings given in
> the
> +	 * I2C specification.
> +	 */
> +	if (priv->flags & RIIC_FLAG_DEFAULT_SCL_RISE_TIME)
> +		priv->scl_rise_ns =3D bus_speed <=3D I2C_SPEED_STANDARD_RATE ?
> 1000 :
> +				    bus_speed <=3D I2C_SPEED_FAST_RATE ? 300 : 120;
> +	if (priv->flags & RIIC_FLAG_DEFAULT_SCL_FALL_TIME)
> +		priv->scl_fall_ns =3D bus_speed <=3D I2C_SPEED_FAST_RATE ? 300 :
> 120;
> +
> +	/*
> +	 * Remove clock ticks for rise and fall times. Convert ns to clock
> +	 * ticks.
> +	 */
> +	brl -=3D priv->scl_fall_ns / (1000000000 / refclk);
> +	brh -=3D priv->scl_rise_ns / (1000000000 / refclk);
> +
> +	/* Adjust for min register values for when SCLE=3D1 and NFE=3D1 */
> +	if (brl < 1)
> +		brl =3D 1;
> +	if (brh < 1)
> +		brh =3D 1;
> +
> +	priv->bus_speed =3D refclk / total_ticks;
> +	dev_dbg(dev, "freq=3D%u, duty=3D%d, fall=3D%lu, rise=3D%lu, cks=3D%d, b=
rl=3D%d,
> brh=3D%d\n",
> +		priv->bus_speed, ((brl + 3) * 100) / (brl + brh + 6),
> +		priv->scl_fall_ns / (1000000000 / refclk),
> +		priv->scl_rise_ns / (1000000000 / refclk), cks, brl, brh);
> +
> +	setbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +	writeb(ICMR1_CKS(cks), priv->base + RIIC_ICMR1);
> +	writeb(brh | ICBRH_RESERVED, priv->base + RIIC_ICBRH);
> +	writeb(brl | ICBRL_RESERVED, priv->base + RIIC_ICBRL);
> +	clrbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +
> +	return 0;
> +}
> +
> +static int riic_get_bus_speed(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +
> +	return priv->bus_speed;
> +}
> +
> +static const struct dm_i2c_ops riic_ops =3D {
> +	.xfer           =3D riic_xfer,
> +	.deblock        =3D riic_deblock,
> +	.set_bus_speed	=3D riic_set_bus_speed,
> +	.get_bus_speed	=3D riic_get_bus_speed,
> +};
> +
> +static int riic_init_setting(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	clrbits_8(priv->base + RIIC_ICCR1, ICCR1_ICE);
> +	setbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +	setbits_8(priv->base + RIIC_ICCR1, ICCR1_ICE);
> +
> +	/*
> +	 * Set a default bitrate. The rate may be overridden based on the
> device
> +	 * tree as part of i2c_post_probe().
> +	 */
> +	ret =3D riic_set_bus_speed(dev, I2C_SPEED_STANDARD_RATE);
> +	if (ret < 0)
> +		goto err;
> +
> +	clrbits_8(priv->base + RIIC_ICCR1, ICCR1_IICRST);
> +
> +	/* Make sure the bus is not stuck. */
> +	if (!(readb(priv->base + RIIC_ICCR1) & ICCR1_SDAI)) {
> +		dev_dbg(dev, "clearing SDA low state\n");
> +		ret =3D riic_deblock(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to clear SDA low state!\n");
> +			goto err;
> +		}
> +	}
> +	return 0;
> +
> +err:
> +	clrbits_8(priv->base + RIIC_ICCR1, ICCR1_ICE | ICCR1_IICRST);
> +	return ret;
> +}
> +
> +static int riic_probe(struct udevice *dev) {
> +	struct riic_priv *priv =3D dev_get_priv(dev);
> +	struct reset_ctl rst;
> +	int ret;
> +
> +	priv->base =3D dev_read_addr_ptr(dev);
> +
> +	ret =3D dev_read_u32(dev, "i2c-scl-rising-time-ns", &priv-
> >scl_rise_ns);
> +	if (ret)
> +		priv->flags |=3D RIIC_FLAG_DEFAULT_SCL_RISE_TIME;
> +	ret =3D dev_read_u32(dev, "i2c-scl-falling-time-ns", &priv-
> >scl_fall_ns);
> +	if (ret)
> +		priv->flags |=3D RIIC_FLAG_DEFAULT_SCL_FALL_TIME;
> +
> +	ret =3D clk_get_by_index(dev, 0, &priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_enable(&priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret =3D reset_get_by_index(dev, 0, &rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get reset line\n");
> +		goto err_get_reset;
> +	}
> +
> +	ret =3D reset_deassert(&rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to de-assert reset line\n");
> +		goto err_reset;
> +	}
> +
> +	ret =3D riic_init_setting(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init i2c bus interface\n");
> +		goto err_init;
> +	}
> +
> +	return 0;
> +
> +err_init:
> +	reset_assert(&rst);
> +err_reset:
> +	reset_free(&rst);
> +err_get_reset:
> +	clk_disable(&priv->clk);
> +	return ret;
> +}
> +
> +static const struct udevice_id riic_ids[] =3D {
> +	{ .compatible =3D "renesas,riic-rz", },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(riic_i2c) =3D {
> +	.name           =3D "riic-i2c",
> +	.id             =3D UCLASS_I2C,
> +	.of_match       =3D riic_ids,
> +	.probe          =3D riic_probe,
> +	.priv_auto	=3D sizeof(struct riic_priv),
> +	.ops            =3D &riic_ops,
> +};
> --
> 2.43.2

