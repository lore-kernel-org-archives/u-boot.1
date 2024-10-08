Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2100DCEFC27
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298F388F19;
	Tue,  8 Oct 2024 17:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="f/0PmY+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058AB88F01; Tue,  8 Oct 2024 17:42:57 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4BD88EE2
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deEkeCzrHd1Kz/4TXGjwAHvdz6HHX4Qxa7xjUiVRByT48iHievq5K69NOB29iu4WwlGVhb/ifXwRdhsDTRyc0ctf70dgQaa9cwirTaQRAQfEA9dp5jbFP+IrJHvir6wKdaqNCYdCgvHzfQhGdnL/W/DdC8FYYeL4xv5IwYoRJnECL44lu5IipvKvH7h1AWd2eVhe/zLm342HsYvcq5mihLHahgqHdf7N4/nYuWnXFc9W+zX19D5G1QCsV5NyzXAY+UFkw1aKkYu2nQzgYbtc3QMjrzgxupcS0kWobVu7TjK12yAAdFpeIcuqDuqEzw1gmzy5tZZgJDLIxq0GWyxZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhjEu9WayC8uODt7TI83gnv815L8AUFhx12a/A3ZSYA=;
 b=Td95bEPw0OUGOYKI/IhCVHaZAwYkUEnY0KNpz7KoHZfKw8sQm2dJfuDOWPcguXqCqeFmyfl0Jbd63UUHmQgaAClEuQMVUfrMThULnM3xWebd6Y1JjMFJ0Fw37QaedL/fRm/390F5o3A8DoRvZ2+Hx41zHqs2B2k56UY0s+izbXjiOeA5eucKGcmMdfwA1MRfWUnSnz7GI51MJaZtiiwKlirBVFJ74uVvoxSCZZR/RctZajMA0n+mq3mPD86KVkbw1HbJkiWMUW2WoqLnfRftGa0X0Y2vsRPPGR46FB1Hsi8fq9ZXUHDsLPMHxbcGHyKhZG5AvJYkljOWvR1abkpGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhjEu9WayC8uODt7TI83gnv815L8AUFhx12a/A3ZSYA=;
 b=f/0PmY+SpEqYllN5JF2j+OPQOYSlEe0/yFP5HOg+RN30eZwRmR/YxEdhJNm2GLWKyQ88GTv63kR6KgBd8QJM7RB6MqPYI83fnsYE0P5lviAuV3QBaikz1RXIFC+PYAqZVRrEM7v/bS6b8zD/QWpm9wejQROFtXEXQ04hO3fC235EC0ZZwuTXkmeHoPyYI/gqhmgbYyDYSEEWr/I1INVFdKbHT177SnT/ie89zXFqR0Q7wmJpTJW95ssXfOLrjBUSwRC2LXMGXr+pODkMLCxP/AVG9Scp+SneUWs65S+m3rERQqdrelz6u/5dZZf1R+6slQcoq+zkOP5w3OhdXkySwg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:42:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Joy Zou <joy.zou@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: RE: [PATCH 1/2] power: pmic: Support pmic pf0900
Thread-Topic: [PATCH 1/2] power: pmic: Support pmic pf0900
Thread-Index: AQHbEt8llFO0cjhJvESzXJAJK6ESdLJ9CpBg
Date: Tue, 8 Oct 2024 15:42:52 +0000
Message-ID: <PAXPR04MB84597FAE909539FAA580A19E887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240930032244.20286-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM0PR04MB6833:EE_
x-ms-office365-filtering-correlation-id: e910a614-749e-43dc-8ceb-08dce7afdefa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?b9w+T4F7juDVX8qtADbZ/dECTdpio3J4ftJsvgh8EYUb24/d4ogr/VD/nuxi?=
 =?us-ascii?Q?KmTRVs3sNfcOmR6lt/5WgUc5ggyWFhBNlRsvn1nEKaobjJSO4OYLZ4Cjsr/Z?=
 =?us-ascii?Q?g1Os6WglGAER34pr6LTVzCCcm/6cRw3Pq1+x/v9UyLGNruAuYroj8KKl2Fed?=
 =?us-ascii?Q?3HRKqtFTa6xkhsP7kgGCLiY0Ao4av77g/mRxD0NGHg0en0ocwTctLqEGV/pl?=
 =?us-ascii?Q?Yb6z57x0uNDjB0TWSGXEbD7gfXwmx7Ys3baBl02Eq3L5dvx8SqDA9Y4DPS6g?=
 =?us-ascii?Q?T55J6xEJVd+zutC1NcQAPKmEG0toQZxlLCGz3YuMLUKvduP+RsP8G2/R5dV3?=
 =?us-ascii?Q?qBNburVdlEQVmOgQzpNEcOpo8DZohvzsbKdZTU5Sr5Rwvrcy/gSuMZIKyjsa?=
 =?us-ascii?Q?uscXuSg8PTMmXQ4ilWTKNv05xr4yUkSkTncuGrt8fb5cq8Sdqg9ueXtyNrod?=
 =?us-ascii?Q?spqzz6q/5fR+s5NkiYJCzYhnx47qX4ISJpjl+8YOzaiSAscD9/j0p+azRoUW?=
 =?us-ascii?Q?rRmoeXxFXAYmbd5XQIOcYHoWbXgioPSGeCjcDRVdcmCYRFvuDHb6bFzomIpD?=
 =?us-ascii?Q?75yPPQkN8X2oKkVnXUfoS3/Xy+7ZV5FuxdJhf2OYFTHlwCPJapbTPBbtnihX?=
 =?us-ascii?Q?ZTtUqUiCltT+2PONd1Gysd/eHu9T7q0vkvSp0vG+Wp0Q3lt7lp52vYbmLnlJ?=
 =?us-ascii?Q?DrtncCa6ijGso+qOLqp/rUAi6tDFdGqh/W3rjiJF/X5OptEGNDt1a4Kr7JE0?=
 =?us-ascii?Q?Ov+bv/TJRxA8HS2tncXO7kOpjEBjd6URneiHgRMTlmR6PN1SIA3iUkPrGvWU?=
 =?us-ascii?Q?87yfPokPSmuQVohj6jcD8jWXUkYpa/H5mayp/KUzR5qC+CsjLXTdHnaGqnwP?=
 =?us-ascii?Q?6K+ugTRGBVQyH2X3WutgGz2nWHxZt7uk/cz9cAgvGq2FkHdq+hgtGtU6gJqg?=
 =?us-ascii?Q?WnC4fJLNAtJTNc5T+D7QBdjo+NQXBukOzp4VTFDk0bKYnb+9gxoTo3yppUYP?=
 =?us-ascii?Q?nurQ+erLrtUJ5Bg8csCylg9lYLr5dkvBxO3ONM7q/5Q8DG+s4zzsomm9oQLd?=
 =?us-ascii?Q?lyFFdURc3wwQQfLJ1nJR0abXXPr9atxg3OcVwcukdMBzqSp3kfM1SVbRvT2Z?=
 =?us-ascii?Q?KueJYTMl0rKpRKeS2hL4YU9uS7jIsgZK2CRjTtww02c8YnUlIG33fVl3gxt+?=
 =?us-ascii?Q?Vjzgg1Imd0Hdp5LJydpI1ZXVJnil9oHMT6PZex2EXvRkROnhZPmaZFJf4Qrg?=
 =?us-ascii?Q?jGrelQyGl/jOOoOiEdjwQnLEVfOZ3EUtwajnJWbNhyKSpFYZWHz0SdJHo/Gc?=
 =?us-ascii?Q?gufdzVtH7P0PCHV914NlArXjd+HXk5x9YWnjjFrIkCvP/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S6rWxgf5/9cnXWjsijL4DI+Y02JSdKmqFItt5MTllwQ7Lgu3qUbdV+uZKVo0?=
 =?us-ascii?Q?GZKH8FvpxMmMtw2ENfffvN9bZdnmooinStkO8jRao09D9GMHRTj+4BmHko+T?=
 =?us-ascii?Q?8k8Nf6Dy0EGUw2YoWewOdDH8lU0CZc0d1OBco/MTcRK6WDjBvM8eYW9k14+D?=
 =?us-ascii?Q?PbcFwMxjfQ/2D1ICce8MHjupg48sw13MD7dbop/Fb/fcjNPeDFV797FOcikF?=
 =?us-ascii?Q?mGZduGNWkhU9QIWTEhS0vNMrSfgyEQKQKECsfjaDh0qtiRwm9AgvSdH88TjN?=
 =?us-ascii?Q?1h6WMQpiiUxT8ySgMEuXcXbWyoonTXKJKOVIK0+u2US/OH/982d8g6RTWRf5?=
 =?us-ascii?Q?ZFTsMyRWQYIpbN7CS3SWoP7BCot7agTRgLMNE96low2bOYb1IZR7gDxPqpkm?=
 =?us-ascii?Q?p2ga5cjcdf4EmC+WNq+cKzOgbWKP1gZdI4h7so99UPz0P4yEfyxteptiGzZj?=
 =?us-ascii?Q?RDPn/KPN8iG3qdyJjB4nDD5OB0aGFRVwSMIHlD5zoMsLkDdCShZlQViiQ3Tl?=
 =?us-ascii?Q?7l9uQ9V6PkCP94znaCBMZ3+xhtkhyHVlJ0i69MNnpudk34+DvhYsPymUBN6d?=
 =?us-ascii?Q?GT+G6HnzmKY09nQMljBdLhwTmjCg7SJb2BNqkeG2PEDP5v6eb91FO4zxZXGE?=
 =?us-ascii?Q?0HG5sSCtmMWQ2SQhnwQBaIYwSmm+SYrbooA6mmOFlNzk3yBJP0bN65SepZS6?=
 =?us-ascii?Q?NUM8zCWVc7TIV8ZjjFdBx7zK2WzulllLbSkaOf0sXrAb7Q8kM6MWyAWzEDP9?=
 =?us-ascii?Q?7XxDDxOw8pz2uha2h/sK6odNYVr1Z3LndvSZ5+Q8P5/z+THT0mg3J06GeshQ?=
 =?us-ascii?Q?r27M/91gBNtaNsNiAtQZJxFA8Qu0fsVHlWskFBM34EVqHBkkwTMBXW3bUHCb?=
 =?us-ascii?Q?ioVD6ibYJM3pWmadVVEzEgLIfq5ZlinlzKQfSNYqxK8Sjk8t/Vur56texyRj?=
 =?us-ascii?Q?ChLH+gxXa0IK3f4tAZNBsmXse6GYTymlLGCoBOTx+/jnChgt+xLqxa8JJ6DD?=
 =?us-ascii?Q?enaFb16v0kz5IknMmzB6h9PhEwAKxgPWBDPBnOlvuQ6m2G32UwX7hT3dqyvk?=
 =?us-ascii?Q?OHGIe56oPUzrgyYp6jqFdQfike/Xm2pZ6CTBodGpe6j8V5n/W0eGlfX3Wnqh?=
 =?us-ascii?Q?80nlKaTh50aJIyLOkQsSYrrSQ+RDe6DSMju3hr2O8+5Xq8fCLkeCIPSmNXNc?=
 =?us-ascii?Q?XvuHLZFV+qybmlmmlxSQKt06QpQL1HCenytc6i3TeegbPSN9AFOvtJKof9P2?=
 =?us-ascii?Q?xO0yZV9F8lygMODUZc0NZXjrFVP8sdNFARJgRR48jRxTdG7cm8HyfhSUxlRG?=
 =?us-ascii?Q?PXa+RdKwXXyc6ArHCAWXeA5dFbnTdUUxWBHprhokvqAJVs0pHdeoinuX3hAU?=
 =?us-ascii?Q?WOMZaIrNHw0Oc5yZ8lqMlRTzEUg7Ijj68oMNkeLk0b7Ct2IrVVmBN9gb6AK3?=
 =?us-ascii?Q?oZzdM/KelM3lBHyclGMTWW5oVKWPyzEBJvFs4ldsR/yPsEnnd/DtsmVzUxsV?=
 =?us-ascii?Q?C4JxXSzu2yt/MdmCNZ9kz1xFIiLwMUBL851zZTIqrlad+8GqLaajfPyVUfaE?=
 =?us-ascii?Q?LlbDLKeT+9bCgBkGVd4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e910a614-749e-43dc-8ceb-08dce7afdefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 15:42:52.5852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTEGVV0aoUDIyAasyy4ECDn0U3DhR3NOGDp6c29rJpV13NjXo9OqD8zapQd3+bE7IsskMwXYZlUGaZ3FpZ9b4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833
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

Hi Fabio, Tom

Seems Jaehoon is inactive. Will you help manage the
the power related patchset or I could use fsl-qoirq tree
to manage these drivers for i.MX?

Thanks,
Peng.

> Subject: [PATCH 1/2] power: pmic: Support pmic pf0900
>=20
> From: Joy Zou <joy.zou@nxp.com>
>=20
> Support NXP pmic pf0900
>=20
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/pmic/Kconfig  |  15 ++
>  drivers/power/pmic/Makefile |   1 +
>  drivers/power/pmic/pf0900.c | 174 +++++++++++++++++++++++
>  include/power/pf0900.h      | 269
> ++++++++++++++++++++++++++++++++++++
>  4 files changed, 459 insertions(+)
>  create mode 100644 drivers/power/pmic/pf0900.c  create mode
> 100644 include/power/pf0900.h
>=20
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 562c1a3b122..1a5ef279ed6 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -171,6 +171,21 @@ config SPL_DM_PMIC_PCA9450
>  	  This config enables implementation of driver-model pmic
> uclass features
>  	  for PMIC PCA9450 in SPL. The driver implements read/write
> operations.
>=20
> +config DM_PMIC_PF0900
> +	bool "Enable Driver Model for PMIC PF0900"
> +	depends on DM_I2C
> +	help
> +	  This config enables implementation of driver-model pmic
> uclass features
> +	  for PMIC PF0900. The driver implements read/write
> operations.
> +
> +config SPL_DM_PMIC_PF0900
> +	bool "Enable Driver Model for PMIC PF0900 in SPL"
> +	depends on SPL_DM_PMIC
> +	depends on SPL_DM_I2C
> +	help
> +	  This config enables implementation of driver-model pmic
> uclass features
> +	  for PMIC PF0900 in SPL. The driver implements read/write
> operations.
> +
>  config DM_PMIC_PFUZE100
>  	bool "Enable Driver Model for PMIC PFUZE100"
>  	---help---
> diff --git a/drivers/power/pmic/Makefile
> b/drivers/power/pmic/Makefile index a2d59deeed8..0041ab59406
> 100644
> --- a/drivers/power/pmic/Makefile
> +++ b/drivers/power/pmic/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_$(SPL_)DM_PMIC_BD71837) +=3D
> bd71837.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_MP5416) +=3D mp5416.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) +=3D pfuze100.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_PCA9450) +=3D pca9450.o
> +obj-$(CONFIG_$(SPL_)DM_PMIC_PF0900) +=3D pf0900.o
>  obj-$(CONFIG_PMIC_S2MPS11) +=3D s2mps11.o
>  obj-$(CONFIG_DM_PMIC_SANDBOX) +=3D sandbox.o i2c_pmic_emul.o
>  obj-$(CONFIG_PMIC_AB8500) +=3D ab8500.o
> diff --git a/drivers/power/pmic/pf0900.c
> b/drivers/power/pmic/pf0900.c new file mode 100644 index
> 00000000000..f38933ad94a
> --- /dev/null
> +++ b/drivers/power/pmic/pf0900.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#include <fdtdec.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <i2c.h>
> +#include <linux/err.h>
> +#include <log.h>
> +#include <asm/global_data.h>
> +#include <asm-generic/gpio.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +#include <power/pf0900.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static const struct pmic_child_info pmic_children_info[] =3D {
> +	/* VAON */
> +	{ .prefix =3D "V", .driver =3D PF0900_REGULATOR_DRIVER},
> +	/* sw */
> +	{ .prefix =3D "S", .driver =3D PF0900_REGULATOR_DRIVER},
> +	/* ldo */
> +	{ .prefix =3D "L", .driver =3D PF0900_REGULATOR_DRIVER},
> +	{ },
> +};
> +
> +static int pf0900_reg_count(struct udevice *dev) {
> +	return PF0900_MAX_REGISTER;
> +}
> +
> +static u8 crc8_j1850(u8 *data, u8 length) {
> +	u8 t_crc;
> +	u8 i, j;
> +
> +	t_crc =3D 0xFF;
> +	for (i =3D 0; i < length; i++) {
> +		t_crc ^=3D data[i];
> +		for (j =3D 0; j < 8; j++) {
> +			if ((t_crc & 0x80) !=3D 0) {
> +				t_crc <<=3D 1;
> +				t_crc ^=3D 0x1D;
> +			} else {
> +				t_crc <<=3D 1;
> +			}
> +		}
> +	}
> +	return t_crc;
> +}
> +
> +static int pf0900_read(struct udevice *dev, uint reg, u8 *buff,
> +		       int len)
> +{
> +	u8 crcBuf[3];
> +	u8 data[2], crc;
> +	int ret;
> +	struct pf0900_priv *priv =3D dev_get_priv(dev);
> +
> +	if (reg < PF0900_MAX_REGISTER) {
> +		ret =3D dm_i2c_read(dev, reg, data,
> +				  priv->crc_en ? 2U : 1U);
> +		if (ret)
> +			return ret;
> +		buff[0] =3D data[0];
> +		if (priv->crc_en) {
> +			/* Get CRC */
> +			crcBuf[0] =3D priv->addr << 1U | 0x1U;
> +			crcBuf[1] =3D reg;
> +			crcBuf[2] =3D data[0];
> +			crc =3D crc8_j1850(crcBuf, 3U);
> +			if (crc !=3D data[1])
> +				return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int pf0900_write(struct udevice *dev, uint reg, const u8 *buff,
> +			int len)
> +{
> +	u8 crcBuf[3];
> +	u8 data[2];
> +	int ret;
> +	struct pf0900_priv *priv =3D dev_get_priv(dev);
> +
> +	if (reg < PF0900_MAX_REGISTER) {
> +		data[0] =3D buff[0];
> +		if (priv->crc_en) {
> +			/* Get CRC */
> +			crcBuf[0] =3D priv->addr << 1U;
> +			crcBuf[1] =3D reg;
> +			crcBuf[2] =3D data[0];
> +			data[1] =3D crc8_j1850(crcBuf, 3U);
> +		}
> +		/* Write data */
> +		ret =3D dm_i2c_write(dev, reg, data,
> +				   priv->crc_en ? 2U : 1U);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static int pf0900_bind(struct udevice *dev) {
> +	int children;
> +	ofnode regulators_node;
> +
> +	regulators_node =3D dev_read_subnode(dev, "regulators");
> +	if (!ofnode_valid(regulators_node)) {
> +		debug("%s: %s regulators subnode not found!",
> __func__,
> +		      dev->name);
> +		return -ENXIO;
> +	}
> +
> +	children =3D pmic_bind_children(dev, regulators_node,
> +				      pmic_children_info);
> +	if (!children)
> +		debug("%s: %s - no child found\n", __func__, dev-
> >name);
> +
> +	/* Always return success for this device */
> +	return 0;
> +}
> +
> +static int pf0900_probe(struct udevice *dev) {
> +	struct pf0900_priv *priv =3D dev_get_priv(dev);
> +	unsigned int reg;
> +	u8 dev_id;
> +	int ret =3D 0;
> +
> +	ret =3D ofnode_read_u32(dev_ofnode(dev), "reg", &reg);
> +	if (ret)
> +		return ret;
> +	priv->addr =3D reg;
> +
> +	if (ofnode_read_bool(dev_ofnode(dev), "i2c-crc-enable"))
> +		priv->crc_en =3D true;
> +	ret =3D pf0900_read(dev, PF0900_REG_DEV_ID, &dev_id, 1);
> +	if (ret)
> +		return ret;
> +	if ((dev_id & 0x1F) =3D=3D 0)
> +		return ret;
> +	else
> +		return -EINVAL;
> +}
> +
> +static struct dm_pmic_ops pf0900_ops =3D {
> +	.reg_count =3D pf0900_reg_count,
> +	.read =3D pf0900_read,
> +	.write =3D pf0900_write,
> +};
> +
> +static const struct udevice_id pf0900_ids[] =3D {
> +	{ .compatible =3D "nxp,pf0900", .data =3D PF0900_TYPE_PF0900, },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pmic_pf0900) =3D {
> +	.name =3D "pf0900 pmic",
> +	.id =3D UCLASS_PMIC,
> +	.of_match =3D pf0900_ids,
> +	.bind =3D pf0900_bind,
> +	.probe =3D pf0900_probe,
> +	.ops =3D &pf0900_ops,
> +	.priv_auto =3D sizeof(struct pf0900_priv), };
> diff --git a/include/power/pf0900.h b/include/power/pf0900.h new file
> mode 100644 index 00000000000..f0d93f1c795
> --- /dev/null
> +++ b/include/power/pf0900.h
> @@ -0,0 +1,269 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#ifndef PF0900_H_
> +#define PF0900_H_
> +
> +#define PF0900_REGULATOR_DRIVER "pf0900_regulator"
> +
> +struct pf0900_priv {
> +	u8 addr;
> +	bool crc_en;
> +};
> +
> +enum pf0900_chip_type {
> +	PF0900_TYPE_PF0900 =3D 0,
> +	PF0900_TYPE_AMOUNT,
> +};
> +
> +enum {
> +	PF0900_SW1 =3D 0,
> +	PF0900_SW2,
> +	PF0900_SW3,
> +	PF0900_SW4,
> +	PF0900_SW5,
> +	PF0900_LDO1,
> +	PF0900_LDO2,
> +	PF0900_LDO3,
> +	PF0900_VAON,
> +	PF0900_REGULATOR_CNT,
> +};
> +
> +enum {
> +	PF0900_DVS_LEVEL_RUN =3D 0,
> +	PF0900_DVS_LEVEL_STANDBY,
> +	PF0900_DVS_LEVEL_MAX,
> +};
> +
> +#define PF0900_VAON_VOLTAGE_NUM 0x03
> +
> +#define PF0900_SW1_VOLTAGE_NUM	0x100
> +#define PF0900_SW2_VOLTAGE_NUM	0x100
> +#define PF0900_SW3_VOLTAGE_NUM	0x100
> +#define PF0900_SW4_VOLTAGE_NUM	0x100
> +#define PF0900_SW5_VOLTAGE_NUM	0x100
> +
> +#define PF0900_LDO1_VOLTAGE_NUM	0x20
> +#define PF0900_LDO2_VOLTAGE_NUM	0x20
> +#define PF0900_LDO3_VOLTAGE_NUM	0x20
> +
> +enum {
> +	PF0900_REG_DEV_ID	    =3D 0x00,
> +	PF0900_REG_DEV_FAM	    =3D 0x01,
> +	PF0900_REG_REV_ID	    =3D 0x02,
> +	PF0900_REG_PROG_ID1	    =3D 0x03,
> +	PF0900_REG_PROG_ID2	    =3D 0x04,
> +	PF0900_REG_SYSTEM_INT	    =3D 0x05,
> +	PF0900_REG_STATUS1_INT	    =3D 0x06,
> +	PF0900_REG_STATUS1_MSK      =3D 0x07,
> +	PF0900_REG_STATUS1_SNS	    =3D 0x08,
> +	PF0900_REG_STATUS2_INT      =3D 0x09,
> +	PF0900_REG_STATUS2_MSK      =3D 0x0A,
> +	PF0900_REG_STATUS2_SNS	    =3D 0x0B,
> +	PF0900_REG_STATUS3_INT      =3D 0x0C,
> +	PF0900_REG_STATUS3_MSK      =3D 0x0D,
> +	PF0900_REG_SW_MODE_INT      =3D 0x0E,
> +	PF0900_REG_SW_MODE_MSK      =3D 0x0F,
> +	PF0900_REG_SW_ILIM_INT      =3D 0x10,
> +	PF0900_REG_SW_ILIM_MSK      =3D 0x11,
> +	PF0900_REG_SW_ILIM_SNS      =3D 0x12,
> +	PF0900_REG_LDO_ILIM_INT     =3D 0x13,
> +	PF0900_REG_LDO_ILIM_MSK     =3D 0x14,
> +	PF0900_REG_LDO_ILIM_SNS     =3D 0x15,
> +	PF0900_REG_SW_UV_INT        =3D 0x16,
> +	PF0900_REG_SW_UV_MSK        =3D 0x17,
> +	PF0900_REG_SW_UV_SNS        =3D 0x18,
> +	PF0900_REG_SW_OV_INT        =3D 0x19,
> +	PF0900_REG_SW_OV_MSK        =3D 0x1A,
> +	PF0900_REG_SW_OV_SNS        =3D 0x1B,
> +	PF0900_REG_LDO_UV_INT       =3D 0x1C,
> +	PF0900_REG_LDO_UV_MSK       =3D 0x1D,
> +	PF0900_REG_LDO_UV_SNS       =3D 0x1E,
> +	PF0900_REG_LDO_OV_INT       =3D 0x1F,
> +	PF0900_REG_LDO_OV_MSK       =3D 0x20,
> +	PF0900_REG_LDO_OV_SNS       =3D 0x21,
> +	PF0900_REG_PWRON_INT        =3D 0x22,
> +	PF0900_REG_IO_INT           =3D 0x24,
> +	PF0900_REG_IO_MSK           =3D 0x25,
> +	PF0900_REG_IO_SNS           =3D 0x26,
> +	PF0900_REG_IOSHORT_SNS      =3D 0x27,
> +	PF0900_REG_ABIST_OV1        =3D 0x28,
> +	PF0900_REG_ABIST_OV2        =3D 0x29,
> +	PF0900_REG_ABIST_UV1        =3D 0x2A,
> +	PF0900_REG_ABIST_UV2        =3D 0x2B,
> +	PF0900_REG_ABIST_IO         =3D 0x2C,
> +	PF0900_REG_TEST_FLAGS       =3D 0x2D,
> +	PF0900_REG_HFAULT_FLAGS     =3D 0x2E,
> +	PF0900_REG_FAULT_FLAGS      =3D 0x2F,
> +	PF0900_REG_FS0B_CFG         =3D 0x30,
> +	PF0900_REG_FCCU_CFG         =3D 0x31,
> +	PF0900_REG_RSTB_CFG1        =3D 0x32,
> +	PF0900_REG_SYSTEM_CMD       =3D 0x33,
> +	PF0900_REG_FS0B_CMD         =3D 0x34,
> +	PF0900_REG_SECURE_WR1       =3D 0x35,
> +	PF0900_REG_SECURE_WR2       =3D 0x36,
> +	PF0900_REG_VMON_CFG1        =3D 0x37,
> +	PF0900_REG_SYS_CFG1         =3D 0x38,
> +	PF0900_REG_GPO_CFG          =3D 0x39,
> +	PF0900_REG_GPO_CTRL         =3D 0x3A,
> +	PF0900_REG_PWRUP_CFG        =3D 0x3B,
> +	PF0900_REG_RSTB_PWRUP       =3D 0x3C,
> +	PF0900_REG_GPIO1_PWRUP      =3D 0x3D,
> +	PF0900_REG_GPIO2_PWRUP      =3D 0x3E,
> +	PF0900_REG_GPIO3_PWRUP      =3D 0x3F,
> +	PF0900_REG_GPIO4_PWRUP      =3D 0x40,
> +	PF0900_REG_VMON1_PWRUP      =3D 0x41,
> +	PF0900_REG_VMON2_PWRUP      =3D 0x42,
> +	PF0900_REG_SW1_PWRUP        =3D 0x43,
> +	PF0900_REG_SW2_PWRUP        =3D 0x44,
> +	PF0900_REG_SW3_PWRUP        =3D 0x45,
> +	PF0900_REG_SW4_PWRUP        =3D 0x46,
> +	PF0900_REG_SW5_PWRUP        =3D 0x47,
> +	PF0900_REG_LDO1_PWRUP       =3D 0x48,
> +	PF0900_REG_LDO2_PWRUP       =3D 0x49,
> +	PF0900_REG_LDO3_PWRUP       =3D 0x4A,
> +	PF0900_REG_VAON_PWRUP       =3D 0x4B,
> +	PF0900_REG_FREQ_CTRL        =3D 0x4C,
> +	PF0900_REG_PWRON_CFG        =3D 0x4D,
> +	PF0900_REG_WD_CTRL1         =3D 0x4E,
> +	PF0900_REG_WD_CTRL2         =3D 0x4F,
> +	PF0900_REG_WD_CFG1          =3D 0x50,
> +	PF0900_REG_WD_CFG2          =3D 0x51,
> +	PF0900_REG_WD_CNT1          =3D 0x52,
> +	PF0900_REG_WD_CNT2          =3D 0x53,
> +	PF0900_REG_FAULT_CFG        =3D 0x54,
> +	PF0900_REG_FAULT_CNT        =3D 0x55,
> +	PF0900_REG_DFS_CNT          =3D 0x56,
> +	PF0900_REG_AMUX_CFG         =3D 0x57,
> +	PF0900_REG_VMON1_RUN_CFG    =3D 0x58,
> +	PF0900_REG_VMON1_STBY_CFG   =3D 0x59,
> +	PF0900_REG_VMON1_CTRL       =3D 0x5A,
> +	PF0900_REG_VMON2_RUN_CFG    =3D 0x5B,
> +	PF0900_REG_VMON2_STBY_CFG   =3D 0x5C,
> +	PF0900_REG_VMON2_CTRL       =3D 0x5D,
> +	PF0900_REG_SW1_VRUN         =3D 0x5E,
> +	PF0900_REG_SW1_VSTBY        =3D 0x5F,
> +	PF0900_REG_SW1_MODE         =3D 0x60,
> +	PF0900_REG_SW1_CFG1         =3D 0x61,
> +	PF0900_REG_SW1_CFG2         =3D 0x62,
> +	PF0900_REG_SW2_VRUN         =3D 0x63,
> +	PF0900_REG_SW2_VSTBY        =3D 0x64,
> +	PF0900_REG_SW2_MODE         =3D 0x65,
> +	PF0900_REG_SW2_CFG1         =3D 0x66,
> +	PF0900_REG_SW2_CFG2         =3D 0x67,
> +	PF0900_REG_SW3_VRUN         =3D 0x68,
> +	PF0900_REG_SW3_VSTBY        =3D 0x69,
> +	PF0900_REG_SW3_MODE         =3D 0x6A,
> +	PF0900_REG_SW3_CFG1         =3D 0x6B,
> +	PF0900_REG_SW3_CFG2         =3D 0x6C,
> +	PF0900_REG_SW4_VRUN         =3D 0x6D,
> +	PF0900_REG_SW4_VSTBY        =3D 0x6E,
> +	PF0900_REG_SW4_MODE         =3D 0x6F,
> +	PF0900_REG_SW4_CFG1         =3D 0x70,
> +	PF0900_REG_SW4_CFG2         =3D 0x71,
> +	PF0900_REG_SW5_VRUN         =3D 0x72,
> +	PF0900_REG_SW5_VSTBY        =3D 0x73,
> +	PF0900_REG_SW5_MODE         =3D 0x74,
> +	PF0900_REG_SW5_CFG1         =3D 0x75,
> +	PF0900_REG_SW5_CFG2         =3D 0x76,
> +	PF0900_REG_LDO1_RUN         =3D 0x77,
> +	PF0900_REG_LDO1_STBY        =3D 0x78,
> +	PF0900_REG_LDO1_CFG2        =3D 0x79,
> +	PF0900_REG_LDO2_RUN         =3D 0x7A,
> +	PF0900_REG_LDO2_STBY        =3D 0x7B,
> +	PF0900_REG_LDO2_CFG2        =3D 0x7C,
> +	PF0900_REG_LDO3_RUN         =3D 0x7D,
> +	PF0900_REG_LDO3_STBY        =3D 0x7E,
> +	PF0900_REG_LDO3_CFG2        =3D 0x7F,
> +	PF0900_REG_VAON_CFG1        =3D 0x80,
> +	PF0900_REG_VAON_CFG2        =3D 0x81,
> +	PF0900_REG_SYS_DIAG         =3D 0x82,
> +	PF0900_MAX_REGISTER,
> +};
> +
> +/* PF0900 SW MODE */
> +#define SW_RUN_MODE_OFF			0x00
> +#define SW_RUN_MODE_PWM			0x01
> +#define SW_RUN_MODE_PFM			0x02
> +#define SW_STBY_MODE_OFF		0x00
> +#define SW_STBY_MODE_PWM		0x04
> +#define SW_STBY_MODE_PFM		0x08
> +
> +/* PF0900 SW MODE MASK */
> +#define SW_RUN_MODE_MASK		0x03
> +#define SW_STBY_MODE_MASK		0x0c
> +
> +/* PF0900 SW VRUN MASK */
> +#define SW_VRUN_MASK			0xFF
> +#define SW_STBY_MASK			0xFF
> +
> +/* PF0900_REG_VAON_CFG1 bits */
> +#define VAON_MASK			0x03
> +#define VAON_1P8V			0x01
> +
> +/* PF0900_REG_SWX_CFG1 MASK */
> +#define SW_RAMP_MASK			0x18
> +
> +/* PF0900_REG_LDO1_RUN MASK */
> +#define VLDO1_RUN_MASK			0x1F
> +#define LDO1_RUN_EN_MASK		0x20
> +#define LDO1_STBY_EN_MASK		0x20
> +
> +/* PF0900_REG_LDO2_RUN MASK */
> +#define VLDO2_RUN_MASK			0x1F
> +#define LDO2_RUN_EN_MASK		0x20
> +#define LDO2_STBY_EN_MASK		0x20
> +
> +/* PF0900_REG_LDO3_RUN MASK */
> +#define VLDO3_RUN_MASK			0x1F
> +#define LDO3_RUN_EN_MASK		0x20
> +#define LDO3_STBY_EN_MASK		0x20
> +
> +/* PF0900_REG_GPO_CTRL MASK */
> +#define GPO1_RUN_MASK			0x1
> +#define GPO2_RUN_MASK			0x2
> +#define GPO3_RUN_MASK			0x4
> +#define GPO4_RUN_MASK			0x8
> +#define GPO1_STBY_MASK			0x10
> +#define GPO2_STBY_MASK			0x20
> +#define GPO3_STBY_MASK			0x40
> +#define GPO4_STBY_MASK			0x80
> +
> +/* PF0900_REG_STSTEM_INT bits */
> +#define IRQ_EWARN			0x80
> +#define IRQ_GPIO			0x40
> +#define IRQ_OV				0x20
> +#define IRQ_UV				0x10
> +#define IRQ_ILIM			0x08
> +#define IRQ_MODE			0x04
> +#define IRQ_STATUS2			0x02
> +#define IRQ_STATUS1			0x01
> +
> +/* PF0900_REG_STATUS1_INT bits */
> +#define IRQ_SDWN			0x80
> +#define IRQ_FREQ_RDY			0x40
> +#define IRQ_DCRC			0x20
> +#define IRQ_I2C_CRC			0x10
> +#define IRQ_PWRUP			0x08
> +#define IRQ_PWRDN			0x04
> +#define IRQ_FSYNC_FLT			0x02
> +#define IRQ_VIN_OV			0x01
> +
> +/* PF0900_REG_STATUS2_INT bits */
> +#define IRQ_VANA_OV			0x80
> +#define IRQ_VDIG_OV			0x40
> +#define IRQ_BGMON			0x20
> +#define IRQ_CLKMON			0x10
> +#define IRQ_THERM_155			0x08
> +#define IRQ_THERM_140			0x04
> +#define IRQ_THERM_125			0x02
> +#define IRQ_THERM_110			0x01
> +
> +/* PF0900_REG_STATUS3_INT bits */
> +#define IRQ_BAD_CMD			0x04
> +#define IRQ_LBIST_DONE			0x02
> +#define IRQ_SHS				0x01
> +
> +#endif
> --
> 2.35.3

