Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D3C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 18:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E1983AEE;
	Mon,  4 Aug 2025 20:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="lc0JkiCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5ECC83F56; Mon,  4 Aug 2025 19:31:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F1583DD8
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 19:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3EWmEi4mRKKeX5+m0lNRbJOE1KjoHiDOTbRuUqtJymBTrPc33j5Lb25oZVedaxx8YEzgd23zq3pX9aTjF7RbhEI87ElmQOMSs2MmwrUyHWZQCMrr2OHqID09UVIigZi/R/lKJiZ7ZnHGvff3VmWxvqDAiqVrL753RJoP6p//ojcVcPhTxxaID117fk3+XC7WaB7DigDjHc+kdsVp+F8l1nynf52X+fo10uEwmI0uCw6gamJFL79bpvA2MBKi4TFQMIfcmcsGJ3imt4NAhOb6DBKYW4Wb4rbS+GD73TlDCggc81gEmVIxf6TAOs6oxVn9y01efrPDGQfhoX1BmVrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur0UEEJbo5o31dwFnsrC1m4vLZlponzhA7hpUFMnSM4=;
 b=FpsNMJaczMOY8n/zKWtsp4MsILBvamfb6Ijcv4lLV0FnJcgDOG7aDddwV71+PhEUDCvshHTBRP0KwId+egCEnRyP+yR0Cylg2FAunSh/qw7+vU1EBo/M/NKe65gbQ/o3U0hMJNhEHhLHmRdGr9T7jSBsoP2cqA9tM/CRs/af7lEsC6Y0Zav6dN4OtkO0HGrokOgX89Rpod6W6QtNH6a0yvZ7Gnk7/tb5VA0f0QC40ylkzKQrmBLYzCXCKjOPcLfAOVyJLjULGMhSU01cNlr7ZTrtfOXkuQy3lzgxEY4DlH80Z9GNzN6X6S2Is1KzCSLRn/Hc/cqkX2PQGv1RgA+u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur0UEEJbo5o31dwFnsrC1m4vLZlponzhA7hpUFMnSM4=;
 b=lc0JkiCfhezlE/AbpSwJHP8ibIlhtt+OowKkCB++rgN8POliR7xWrI72rV16h5vziw+wKK0JFUQ53BkO2y1i3NCtb2/vEW+DgJnwBw5fQ/DpxFsg6w0JSrsz5HAFGCqB5Wf7diLF3Dl+CZpr3riR/agwk/r89uxIczZEljAMM38=
Received: from PA4PR02MB8169.eurprd02.prod.outlook.com (2603:10a6:102:272::8)
 by AS8PR02MB8416.eurprd02.prod.outlook.com (2603:10a6:20b:52e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 17:30:58 +0000
Received: from PA4PR02MB8169.eurprd02.prod.outlook.com
 ([fe80::f600:6ace:3615:4b7b]) by PA4PR02MB8169.eurprd02.prod.outlook.com
 ([fe80::f600:6ace:3615:4b7b%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:30:58 +0000
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: Primoz Fiser <primoz.fiser@norik.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: RE: [PATCH] power: pmic: pca9450: Add support for system reset
Thread-Topic: [PATCH] power: pmic: pca9450: Add support for system reset
Thread-Index: AQHb9kcw/8D8LA4JzUuj56Hj/Lq9ArRS1uZQ
Date: Mon, 4 Aug 2025 17:30:58 +0000
Message-ID: <PA4PR02MB816934F407E2AE5037235FF8BD23A@PA4PR02MB8169.eurprd02.prod.outlook.com>
References: <20250716114547.1343797-1-primoz.fiser@norik.com>
In-Reply-To: <20250716114547.1343797-1-primoz.fiser@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR02MB8169:EE_|AS8PR02MB8416:EE_
x-ms-office365-filtering-correlation-id: d0c2b6af-de45-40f6-c15a-08ddd37cacf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GzCleIKs6nS9QDPtYPjamNwMI1DkU/Xwz5tcREYL+VWjBp/glJt1ekWhsAbZ?=
 =?us-ascii?Q?QK/sffBMS2o4BE2M8D2+Ga6g1FFwMvduq9/kxZQjRuxV2lBjh0NqGCcpo3cE?=
 =?us-ascii?Q?flnVTIqQYw6QkbhidxrPh5WyQ3+4LN9toJGXHc+WtBSziIbgRL7AHT3Oemk7?=
 =?us-ascii?Q?XM2seifl6hB51s/TqZgvO5OY7T4UWZHMYytgJMP44XTRBD4JI26DGdXI7kXw?=
 =?us-ascii?Q?bNvDgEsDPKiVIsYB05AgSkP/6a6XaqOquhBEYacfNONR21gQxiRG5+Xq+tJe?=
 =?us-ascii?Q?3HY/l3+agzOrTsG8E2x9Det4+nG6MHZk7JfnlytsJNXvyPA/mPyKFkjrXgiI?=
 =?us-ascii?Q?V8HXyW2ItjV4VWZE4WkFJfRWXNyePoWhZJB32kIkCJyVvtVQc86LBP60q+/7?=
 =?us-ascii?Q?CuTGJz4IrpR+uYAHy7knrSyYQ8Y0aiiLW5l3pTdcLld0Nct0NicSjRo5wI9g?=
 =?us-ascii?Q?ORTp5TXiArTfuIn6j5YNIRdMpSBOg6QYct6zev3MV+wkqWZ5YVPCYGSgEl48?=
 =?us-ascii?Q?UvgoCDlIWAlZcsvoFJ/Hq09yTQvxC3gDR9DbuytnNTUBDbGY3n7CchUAZOCN?=
 =?us-ascii?Q?TzHKbEprRjGhmqGQqOISGnQSCT4y0uIAViCPbB5uh6OCAA9OnYIKo5lKeAe5?=
 =?us-ascii?Q?5CVeMQDVLsNQzJbdt4m0SEenAABnbcs62q02cmrxQz0rAGmK/0WopmpkHJI4?=
 =?us-ascii?Q?132yajqoHtN5o2joIkjcin/7+bJlZI1USgXWLYr9bpz0OLBo6AvSsJ02FFG+?=
 =?us-ascii?Q?yuxiRKhEjiBomD6RpHF29Gzk9pB3/QmlRmXPWPinkdGNlsKWT5RyOpyBiuNU?=
 =?us-ascii?Q?U0HecawyTGhT/B5LHahGK2U+uWeoqOMT6jQzHrAuyVowz+sby0bvUxxRsv2/?=
 =?us-ascii?Q?SP/rHOZYx9VQVcGYRpYkiD36YLIRGT1qYwuHihmEAE+5ktFik+nmM/rAEpWD?=
 =?us-ascii?Q?+9V6mrizIfm9gt0bAKoNUh8dvszSUa2X6uMuDx7Tebb4Y6gtObrflEHU6mzf?=
 =?us-ascii?Q?yrmnjIlyL+Id5koBx2+JdifSjykJqwDGk21vjUGbmLDSis27YTl4wWnfnsYx?=
 =?us-ascii?Q?4fAikAlTRKqyG+XbJvEUcyPsznPCMyPQqKkMhoxFT3aWDUnh0JxeKwn+xWfV?=
 =?us-ascii?Q?6gHMru4NxeNkIfO2Fn3jcyQa+aXmF+yt9ys/QZGomp62YgJLNmm3Ch/5RMGd?=
 =?us-ascii?Q?UN3HRBBARYUFHc2CTn+nLYtmg9EKRKGg260GiTQr/PaURw+2gd0eT1WmzMtm?=
 =?us-ascii?Q?nnJI46BNknCorZj9txuwP1A3lysK30UxGNuSV0WAfUrhAxcaVOmxm2r+ze97?=
 =?us-ascii?Q?7EfLFKgQUBYZkoOZ7Dg5/iCHij0UUq9NcRdjOr09kCyOSxiV11Sl3nh49ZwN?=
 =?us-ascii?Q?PUbJ5cUIuC+um/KxRMvhZe/5nEs3aLRREZxiNRil267FlPL2rIMfogBeLQUn?=
 =?us-ascii?Q?KQ3NPF/el6fo5UtaihNa+smaWptIr5/gKM3IPlJUXiFWfQ4T5rQcUg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR02MB8169.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jCU3vM+uhEYyiPSw813p0iMHGnGDAJbCI6Fr1gJaSQKlZV7mpfTKPnDyyayB?=
 =?us-ascii?Q?4iFyd4ksRVZLoXI943MCAw+wwx5+2W0ioFLqEt38q4nODtehuuq7v8ZOrQxt?=
 =?us-ascii?Q?OoDuFlgnZmiOkk52XZN+ySMkQ7YvPZmp5jKFLwqpYG6AAOUltT7s/j0ydEep?=
 =?us-ascii?Q?LqZjMF3tJmS83cg3JCL1yA37wOzYlvuuJkFYdfPfRhtBFFtYlIFkxCrV4QWx?=
 =?us-ascii?Q?3EK/SmSq02mgTlaWy/RhU3CHD9Lc2M/4bjHbeoSMo+y1wpsI9LDXVCLOY7rr?=
 =?us-ascii?Q?IA/Wn1gnNoWiSX/grCslLQIipEzue0CJZN9C3ylzzhH3KRWxSLvAKk4auipp?=
 =?us-ascii?Q?OWEMQk8mW73glFGEeNRoP1mlxRxnkJ2bLLm3OEqxnnOgu/SGrKeIDHJHjYlu?=
 =?us-ascii?Q?iN+3SXYsZSyjBCfHsiWtgH5rTGqtZSAKm7E2MVQ+D/Ize8LppRuX5Sd56tUY?=
 =?us-ascii?Q?5sf0HH3km0ctKi2p+QPMTTrSauvBs/SZF5WSQ1lMExIDt2c5QhqjbzgraAul?=
 =?us-ascii?Q?Eac2qco/ZSNj8+ALRfIMEr/pN9hs1Jv1a/5ul9V6p339Ud1JOmVyVOLvOwGv?=
 =?us-ascii?Q?r7cFGXIcvvbsKkHc8V445bSPU1HJedTeJrd8X+28rYTX7h3Lzh80gAV6iCTQ?=
 =?us-ascii?Q?gMxJlH3aoy2dpO0mOmZk1nmSpD5XuHH88kd4fMYi7iC46Q69/Nud/zpoaDrH?=
 =?us-ascii?Q?4HD+MppGSCHpcQHJNA+iuddAcod8osyQm5amkTO24++ydGLcGA362zYiHA+N?=
 =?us-ascii?Q?gkyH+q0TD8g3gNBf5l7g/NDSVRFZ6xEyXkFtTFpODeF0PpZTJ/P3ZRdkYyOJ?=
 =?us-ascii?Q?vho2PT6QSPPUExuCCj5QReHxYRxQk5qjhgqLcaJUlWU7Hl3oj7GdJbwbIPpd?=
 =?us-ascii?Q?AmfQyCrIVlbVA21vjQHDiaLqBrK5gKxda5AiqMAY32As72/pDFEwI5wzCTN6?=
 =?us-ascii?Q?Q8OL94uXMuSdt9n8y0cg3OAzQjqPhOr+wa9oMnRyk08MRg58K0WSCScvdZDK?=
 =?us-ascii?Q?WqO6ccLw/7BA29hh2LvMwigGahog3654Y5YprmDXBzjA9mxIIgQKv7l9TCEd?=
 =?us-ascii?Q?LXAx1bVUFyVy0YwWHhsemrc60zaQNlegFM2J/milJXCi2UxJOjx4rXoTjJMF?=
 =?us-ascii?Q?FMm6Vw2voOn6wvHzOY9V+PyJfShEVBioVOXGkMmyo1JNrQ35BSBAcEV10JE1?=
 =?us-ascii?Q?JCSJSvnJoSI2KI5uhQ7xNwKwu1P/hs4wSnuObNNxN1Wpj9u88yTWn6/jqB3+?=
 =?us-ascii?Q?mwl55yuYyNCDLqCUKck4tfyPVW2shWitDvNy+HC7j/JOpoT01S3N//nuq+v9?=
 =?us-ascii?Q?i18xZiDZYR0R36ilg5Qre6W91/MauLaaNDmnwqekistxcA/SJvhs3NWaS0NU?=
 =?us-ascii?Q?3hpUGI32FqnSTb1RbE4AjDk1rD0PXcVTlcANhhQOvuBXiFLzYgx6HGtaYRDq?=
 =?us-ascii?Q?1394cO7shkSdDugZMKlr4ZjOyeQXx+0inbdkJ/yxbWEt9yvW/tsjreidXMNP?=
 =?us-ascii?Q?6WFiYNOlXiDGihE2SR2voF4um9KAGEyXBQUllQaJhQvqZ0srtFcVMZNOoetG?=
 =?us-ascii?Q?joB2Va8nvKIEpElsyRH+7top1erVokk6jKNvhLnY6TTj8ZIi0SnStdGqGNPR?=
 =?us-ascii?Q?ffEjgVhyNoYy0UEvPTXNmSk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR02MB8169.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c2b6af-de45-40f6-c15a-08ddd37cacf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 17:30:58.7764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFUnFgdh8N2qz83h2beCOUpJh2jiQkMwAM8RQ5ZTsXv3GfgWToVXttnpRmfXGLLOGAUGazgpczpZ4HmbNkaNeb5l6fZIluHvjEeRnkPVXib5yTAfypfPRMgPZkupFqpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8416
X-Mailman-Approved-At: Mon, 04 Aug 2025 20:46:54 +0200
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

> The family of PCA9450 PMICs have the ability to perform system resets.
> Restarting via PMIC is preferred method of restarting the system as all
> the peripherals are brought to a know state after a power-cycle. The
> PCA9450 features a cold restart procedure which is initiated by an I2C
> command 0x14 to the SW_RST register.
>=20
> Support in Linux for restarting via PCA9450 PMIC has been added by
> Linux commit 6157e62b07d9 ("regulator: pca9450: Add restart handler").
>=20
> Now add support for it also in the U-Boot via sysreset framework.
>=20
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/power/pmic/pca9450.c | 42 ++++++++++++++++++++++++++++++++++++
>  include/power/pca9450.h      |  2 ++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
> index 9d875f8bdbe8..abc39d0a1946 100644
> --- a/drivers/power/pmic/pca9450.c
> +++ b/drivers/power/pmic/pca9450.c
> @@ -7,15 +7,18 @@
>  #include <errno.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> +#include <dm/lists.h>
>  #include <i2c.h>
>  #include <linux/err.h>
>  #include <log.h>
>  #include <asm/global_data.h>
>  #include <asm-generic/gpio.h>
> +#include <linux/delay.h>
>  #include <linux/printk.h>
>  #include <power/pmic.h>
>  #include <power/regulator.h>
>  #include <power/pca9450.h>
> +#include <sysreset.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -101,6 +104,14 @@ static int pca9450_probe(struct udevice *dev)
>  		}
>  	}
> =20
> +	if (CONFIG_IS_ENABLED(SYSRESET)) {
> +		ret =3D device_bind_driver_to_node(dev, "pca9450_sysreset",
> +						 "pca9450_sysreset",
> +						 dev_ofnode(dev), NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
>  		reset_ctrl =3D PCA9450_PMIC_RESET_WDOG_B_CFG_WARM;
>  	else
> @@ -134,3 +145,34 @@ U_BOOT_DRIVER(pmic_pca9450) =3D {
>  	.ops =3D &pca9450_ops,
>  	.priv_auto =3D sizeof(struct pca9450_priv),
>  };
> +
> +#ifdef CONFIG_SYSRESET
> +static int pca9450_sysreset_request(struct udevice *dev, enum sysreset_t=
 type)
> +{
> +	u8 cmd =3D PCA9450_SW_RST_COLD_RST;
> +
> +	if (type !=3D SYSRESET_COLD)

The PCA9450 calls it "cold reset", but it is technically SYSRESET_POWER.
There is no option for it in the sysreset do_reset, but maybe there should =
be.

> +		return -EPROTONOSUPPORT;
> +
> +	if (pmic_write(dev->parent, PCA9450_SW_RST, &cmd, 1)) {
> +		dev_err(dev, "reset command failed\n");
> +	} else {
> +		/* tRESTART is 250ms, delay 300ms just to be sure */
> +		mdelay(300);
> +		/* Should not get here, warn if we do */
> +		dev_warn(dev, "didn't respond to reset command\n");
> +	}
> +
> +	return -EINPROGRESS;
> +}
> +
> +static struct sysreset_ops pca9450_sysreset_ops =3D {
> +	.request	=3D pca9450_sysreset_request,

When using the PCA9450 to perform a cold reset, the CPU boot status shall
_always_ be POR, as that is what the CPU detects. This means the boot statu=
s
should also come from the PCA9450 when enabling CONFIG_SYSRESET option.

I think implementing pca9450_sysreset_ops.get_status() to read the
PWRON_STAT register should do the trick, but I am not that familiar with th=
e
sysreset in U-Boot.

> +};
> +
> +U_BOOT_DRIVER(pca9450_sysreset) =3D {
> +	.name		=3D "pca9450_sysreset",
> +	.id		=3D UCLASS_SYSRESET,
> +	.ops		=3D &pca9450_sysreset_ops,
> +};
> +#endif /* CONFIG_SYSRESET */
> diff --git a/include/power/pca9450.h b/include/power/pca9450.h
> index e5ab09fb8c83..9119ef793b1f 100644
> --- a/include/power/pca9450.h
> +++ b/include/power/pca9450.h
> @@ -75,4 +75,6 @@ enum {
>  #define PCA9450_PMIC_RESET_WDOG_B_CFG_WARM		0x40
>  #define PCA9450_PMIC_RESET_WDOG_B_CFG_COLD_LDO12	0x80
> =20
> +#define PCA9450_SW_RST_COLD_RST		0x14
> +
>  #endif
>=20

Thanks for porting it to U-Boot :-)

br,
Paul
