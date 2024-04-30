Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD75BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 23:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434ED88A05;
	Wed,  1 May 2024 01:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bRwnb/oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E7B88A1A; Wed,  1 May 2024 01:51:28 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F758883F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 01:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7P4BJxubUu8sGvbrF/r5OD23l0dCjFi4vjFEtAfENA9ON6WF77fS3HKk3njg1vcEQWL/XNST16NxX9rEtlywN72XEk088csyEFYdQt6IUuMGZB/pMoZkDbHQUVfOVnhNnYeyjMeaF33rCmebBPoKWotDzyWFqqZclHAXmjUbKNBg3fh0AQpA3k7um1/F+5HQjyQqZeOMf+I5Ifmjx5FKebFLO1j2TfXHeV6KfyteNQc+IWqHPYRBwPLaWCNDrWJ6oPQR+njNBGrqw9E07CDnsyW/o6fESAXqzvR1pKQYj+PJs98CnUpygR252ZLQxWU+ogvt/siZ6tHQmOTUBI1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm9Za3MwXHMxq6U4/IreYFTc4Vg739z6akuNC3y9yEk=;
 b=CaULcNcrOSO21r4k7W8eWyv/rNuIpsYovSNPCzkx5zSWpGJ9kfpc3+pv7pbEXtGWYMsE0IsoMIhHj8pTJySRsQGmD8DcJekbhaI9PAWMiqSq9SrHWdihZzgX6UDKWyisZHhrjF9mKy+w+77fT+mRGM/71poiHeyQAVL2DKz9v5vChgnNyNeflnzm0Tm3IoG1ybwP111fR5UdgJbz+o/My03vhHhBV9ACIP/n+B/rfa6TeueU9ZXYtA5TKbT48CGEaqWKOo44Yhdbqcz4i3FnpGz2xEwgCtYsszZfQvQh2w7NMU8GMvVzRx/YUJ7xwp9HiCkohvSgxzG9kJKAA3LKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm9Za3MwXHMxq6U4/IreYFTc4Vg739z6akuNC3y9yEk=;
 b=bRwnb/ojNNGNDM9VBgaDXy6nQBt+ERGfUwHDN6a6xO+CGlHI1Zw3hvCykH34EPkjwV6bfoDbzCSybfdxsNXthNPz8E/+yecMiYIKDYvqgEnA63vyCeBOFmdnxdzbe58A4A7tXaqEv5DQyy0TU8XkG3QZXdINqGy8Qo7iuRPVkAI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 23:51:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:51:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 23/33] arm: imx: Remove <common.h> and add needed includes
Thread-Topic: [PATCH 23/33] arm: imx: Remove <common.h> and add needed includes
Thread-Index: AQHamwNoNkmD8cKhU0qJnaGKQIxuQ7GBfIRQ
Date: Tue, 30 Apr 2024 23:51:23 +0000
Message-ID: <DU0PR04MB9417E6FD2906B973AD707DA8881A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-23-trini@konsulko.com>
In-Reply-To: <20240430133559.1836389-23-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8829:EE_
x-ms-office365-filtering-correlation-id: 637149da-6424-4e9c-f5a9-08dc697070f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LlCRQPq4P0JCelWSNzNAJhp6ZMqvZEpyOZnj4GdZcZFArG7KqWrJK5ihlBMa?=
 =?us-ascii?Q?OQ/OYifIh9t0W24m1XyQIEWX7/gHBuNTA7hkoczqQ89Rt/2dcpPavCogJCLI?=
 =?us-ascii?Q?lXh6KLmQlNKFn6NIgByaHnWcmUHL1f1GHMC6DrdT+PyNHwTQmznzquxphSfb?=
 =?us-ascii?Q?MHYAaiVHU10IdEV3rODAGQRD1ZEI7WQcCNkX0nhLZ042QfeHVA6pTO5jKR0i?=
 =?us-ascii?Q?6HfnQFaQq7yBcOLZb+T2MtvG+Zix4NnQvLw/fmjW4Vdkv4GnaB1kqClbUTzJ?=
 =?us-ascii?Q?S2QSUtb2E6e98OXa8FigVNYYbb5ZHhshHe6nyacT/nJm9Pwdhfi+++bcjFBT?=
 =?us-ascii?Q?sZSkLZv61zERcvLC95eCPQEPEMJmvwFWFn2+eRC+pFIgKhOlr+hc/jEz1jT5?=
 =?us-ascii?Q?meUZUAR4Ji8bMdkWyQ7QgMvRcpMFcASe36e/Z5MUpiw9jS4fIC/70h2ewjZT?=
 =?us-ascii?Q?5TgycQEEKMTQI01g0lVd6rVvvV4aoUj3lcq1u7vx64AnCgYMnMxGZ9BQ6yTB?=
 =?us-ascii?Q?/QzDGT7PEnj5KgOpJmIW+UnJ4TtQtPXsfbpNfp5LVXKyxf2AG6AncYX6Ze1q?=
 =?us-ascii?Q?Ivuon+d9xsrdDXd+tErKGE1v0Ac4xxAO0pDXIc2dz6yngmhdM6X+bkTa/8uh?=
 =?us-ascii?Q?uBYM93WLfEU8Co/Raf1ykVHbMgbYSdOETM8t7AEVVV8ZZkyhYOxOVeZbbFLY?=
 =?us-ascii?Q?LuWwOPuBOmzrEsrtj0cgYPvgMyXSR+p6tGMrWytUjliAsGDi1ab/piQs1HqA?=
 =?us-ascii?Q?PO35458VHToLgTI9wBARDSKTfbnWnHBfJSjUU4nj9ZEQXiHLm2gFbDkXy5FK?=
 =?us-ascii?Q?UJSGCWAbIBkmbi9XVyh5tcWNw2YNbrMQT/k1nw9QAynr9WjsuHrzHrJq/ESe?=
 =?us-ascii?Q?TxOHJzQXSV+A8u/MnyEI6v/ewwYqQdbfkvpdcflTfiC+O5PgLeGoLL3gekIb?=
 =?us-ascii?Q?XcuE7sxRfSI/o4kRM0LcRXiSsoivjt3sRJC1qVvwZqFCdeDIbe9NgKOmnH+b?=
 =?us-ascii?Q?6uV56Q3XfsnJacXXa4U+58rJ5QUDpDOrbj1OQrhkgZxsBxEhRWA0BPIz+8Oj?=
 =?us-ascii?Q?6hZu3vfUnF9+ZONvsF++bSbdhT9rlEfOpd7w6pzomXqhnz6jmiElWhUYlDf/?=
 =?us-ascii?Q?lREmHr3IIZ4V5S7meyLJFShq3woKgutm6Tytihe/g3EMOcYU5gVHM4RpnwjL?=
 =?us-ascii?Q?WEp82slEKF9wrgg/R4kUWhvjjauj9TjTGBhrozGzSDE713mUjV7wBwd5wcAg?=
 =?us-ascii?Q?AN40HDdf5estzXuYtQ8EyAIZ4SNgXPMDUt3Sdx+52xzEAq+2Z74OWkid9EZB?=
 =?us-ascii?Q?sZ5ecx1EPQ5AbA7NqwWm8plH+0+DzOu53L6Jj4LgaOd9kw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vb5t8NjrVNF9OCalyv9DaDTV386I3IGzJWZJBWkiz876onoNN0AJLDekcw/5?=
 =?us-ascii?Q?b1LpPkb3hr0b3nb7ZzYHAghduMX43gGyT3lh2DFSFtoTkhpimr47tgzFnJ94?=
 =?us-ascii?Q?kHEpmwP43YaZPVFg98w1FtoXYJmegW2eCaq/MyaCWhTVWwsXkozsb2l7j3pJ?=
 =?us-ascii?Q?TbKl48tEfakga3m9raOMTiKMr9oidPx0zJok/pTs/yR1O+GC6hKdxmUfyw5R?=
 =?us-ascii?Q?JYUUkcbVCcPY0UH7U0s+Mn6AhUW34s8nPuqfuaoKkeDgv4n14qYx7gfKM9rz?=
 =?us-ascii?Q?oqmWswfI0FTChklPXsOYXXEyPBObPDY2o8FlKOhPvnYR2HoMtwmUP5KxSRKp?=
 =?us-ascii?Q?zPwqiowiNHgYpLPij/A4oa3BclUP5ssRCB51xTlD9fYbjlRoO0tXxarBbvB9?=
 =?us-ascii?Q?8+31uy6DaJR6lmwL+LYt3ajTAMvN1P0Ko7SyFteWHRY5xz8XVKTlpNt/zsx9?=
 =?us-ascii?Q?ekY8X7dv33dUpYYhur3ScXZLRcpv0EMAZOjQN2Biwpp1iZtc1Jwg+OwLR3/c?=
 =?us-ascii?Q?+5RcJML14Dl8t5+ZdtbY/7U52hBMPbZAhjYpF5Nm1ULJx4NHOlPxbNwkwoTD?=
 =?us-ascii?Q?FuzTPZ4zhZo3JoXNuct3tCKFzMm6VtOX6IkGNW0ex1uk+/1Ekp+7vCr6S/sz?=
 =?us-ascii?Q?Gf71TfZP4RDykAE2QQ0eqGlh7KaXMNZZBGliT77CRrG2aLClRv256kcMlbqc?=
 =?us-ascii?Q?gtRGGiP7ZGaHvDKS6rliZk3OTxvNNN/UHefyd2PWAMX+WiYaIR5jLjOnVKC5?=
 =?us-ascii?Q?m5o/muE4fIAU9uL/JUTZQxrXPJEJFnroPxJtxFyCK0bSFQowqdQ67XQ2y5Cd?=
 =?us-ascii?Q?qENH9BR/JY9l/r2EYkxxcznkYMpVngwMS9bvMU0viD3CT1IBk6unLXKgwdyp?=
 =?us-ascii?Q?1yR1+IRhBBhH8ZHJTR0cJT+J68NS/ETFPqq5Wrm8Ye8Yw5HTdkP/t/7bNKAH?=
 =?us-ascii?Q?tZxDW78ciuAae1VomZIVK90b6LltXMHqy5JtMqqBIP3IIEj6W4zrhhCLcrev?=
 =?us-ascii?Q?vZjS6MQTMeH5Kkhma3sCl+hrPZWJl91rl3q6jAVT9Dv1Iz+t9qEBcF1e9Iru?=
 =?us-ascii?Q?2KKPEd7F3B4DQPUaFC54m6aJpRsB6i7oG00rBJ0DS983biudqNT7T8nGkQmu?=
 =?us-ascii?Q?Vctw/6Qy/v5HrdOY+Wj4aDnIb/C3d8+jtxT94aOLB78hyQ9zWlYVpiN80Cbu?=
 =?us-ascii?Q?ttmGpZh09tJwo13PSHn1oqR+y26P8bbJwFy5fR+2BwPGwPBbeuAK6nnmlEfp?=
 =?us-ascii?Q?4/z3w1IAzAI1Cb3mIXDmegkw1moX4QLBGQ/8t6bQcW+c9MjE0o7zNvFKBcLr?=
 =?us-ascii?Q?44wPpkcr3e+oL0ze3I32bSFCgD79AO5ADm+ZPy2zCZmDR1UXT0b3oeuzbdfj?=
 =?us-ascii?Q?i+M6HqAHZRW9+WXY0X3Au1ixIPKob2z/KvWbrIEJRDrpUluhComMN8MeBRvj?=
 =?us-ascii?Q?sJT6TE0G1l/wOyVOy+7ZBDHaDYSJ+z36UksKYTT7IDwedJlAkHkUlWJzBziL?=
 =?us-ascii?Q?ycMiThSHyxEocNXzE+eJva1e6dVCtFHmCO+s9iS16YDSP4uM1DNnwKVzp/Ga?=
 =?us-ascii?Q?FmkszLAqe9opKzlE++U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637149da-6424-4e9c-f5a9-08dc697070f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 23:51:23.2054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYMQtHO9m198k1vb5QdugMUtohEgBqhntWNjRb5ZULBjIc9yH0qLDlOerBtfKQs4IUZiMwe1MzFSFoE6lXRlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
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

> Subject: [PATCH 23/33] arm: imx: Remove <common.h> and add needed
> includes
>=20
> Remove <common.h> from all mach-imx, CPU specific sub-directories and
> include/asm/arch-mx* files and when needed add missing include files
> directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> ---
>  arch/arm/cpu/arm1136/mx31/devices.c         | 1 -
>  arch/arm/cpu/arm1136/mx31/generic.c         | 1 -
>  arch/arm/cpu/arm1136/mx31/timer.c           | 1 -
>  arch/arm/cpu/arm926ejs/mxs/clock.c          | 1 -
>  arch/arm/cpu/arm926ejs/mxs/iomux.c          | 1 -
>  arch/arm/cpu/arm926ejs/mxs/mxs.c            | 1 -
>  arch/arm/cpu/arm926ejs/mxs/spl_boot.c       | 1 -
>  arch/arm/cpu/arm926ejs/mxs/spl_lradc_init.c | 1 -
>  arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c   | 1 -
>  arch/arm/cpu/arm926ejs/mxs/spl_power_init.c | 1 -
>  arch/arm/cpu/arm926ejs/mxs/start.S          | 1 -
>  arch/arm/cpu/arm926ejs/mxs/timer.c          | 1 -
>  arch/arm/include/asm/arch-mx5/clock.h       | 2 ++
>  arch/arm/include/asm/arch-mx7/sys_proto.h   | 2 ++
>  arch/arm/mach-imx/cache.c                   | 2 +-
>  arch/arm/mach-imx/cmd_bmode.c               | 1 -
>  arch/arm/mach-imx/cmd_dek.c                 | 3 ++-
>  arch/arm/mach-imx/cmd_hdmidet.c             | 1 -
>  arch/arm/mach-imx/cmd_mfgprot.c             | 2 +-
>  arch/arm/mach-imx/cmd_nandbcb.c             | 1 -
>  arch/arm/mach-imx/cpu.c                     | 1 -
>  arch/arm/mach-imx/ddrmc-vf610-calibration.c | 1 -
>  arch/arm/mach-imx/ddrmc-vf610.c             | 1 -
>  arch/arm/mach-imx/ele_ahab.c                | 2 +-
>  arch/arm/mach-imx/hab.c                     | 1 -
>  arch/arm/mach-imx/i2c-mxv7.c                | 2 +-
>  arch/arm/mach-imx/image-container.c         | 2 +-
>  arch/arm/mach-imx/imx8/ahab.c               | 1 -
>  arch/arm/mach-imx/imx8/clock.c              | 1 -
>  arch/arm/mach-imx/imx8/cpu.c                | 1 -
>  arch/arm/mach-imx/imx8/fdt.c                | 1 -
>  arch/arm/mach-imx/imx8/iomux.c              | 1 -
>  arch/arm/mach-imx/imx8/misc.c               | 1 -
>  arch/arm/mach-imx/imx8/snvs_security_sc.c   | 1 -
>  arch/arm/mach-imx/imx8m/clock_imx8mm.c      | 1 -
>  arch/arm/mach-imx/imx8m/clock_imx8mq.c      | 1 -
>  arch/arm/mach-imx/imx8m/clock_slice.c       | 1 -
>  arch/arm/mach-imx/imx8m/psci.c              | 1 -
>  arch/arm/mach-imx/imx8m/soc.c               | 2 +-
>  arch/arm/mach-imx/imx8ulp/cgc.c             | 1 -
>  arch/arm/mach-imx/imx8ulp/clock.c           | 1 -
>  arch/arm/mach-imx/imx8ulp/iomux.c           | 1 -
>  arch/arm/mach-imx/imx8ulp/pcc.c             | 1 -
>  arch/arm/mach-imx/imx8ulp/rdc.c             | 3 ++-
>  arch/arm/mach-imx/imx9/clock.c              | 1 -
>  arch/arm/mach-imx/imx9/clock_root.c         | 2 +-
>  arch/arm/mach-imx/imx9/imx_bootaux.c        | 3 ++-
>  arch/arm/mach-imx/imx9/soc.c                | 2 +-
>  arch/arm/mach-imx/imx9/trdc.c               | 2 +-
>  arch/arm/mach-imx/imx_bootaux.c             | 5 ++++-
>  arch/arm/mach-imx/imxrt/soc.c               | 1 -
>  arch/arm/mach-imx/iomux-v3.c                | 1 -
>  arch/arm/mach-imx/mac.c                     | 1 -
>  arch/arm/mach-imx/misc.c                    | 1 -
>  arch/arm/mach-imx/mmc_env.c                 | 1 -
>  arch/arm/mach-imx/mmdc_size.c               | 2 +-
>  arch/arm/mach-imx/mx5/clock.c               | 1 -
>  arch/arm/mach-imx/mx5/mx53_dram.c           | 2 +-
>  arch/arm/mach-imx/mx5/soc.c                 | 1 -
>  arch/arm/mach-imx/mx6/clock.c               | 2 +-
>  arch/arm/mach-imx/mx6/ddr.c                 | 1 -
>  arch/arm/mach-imx/mx6/litesom.c             | 2 +-
>  arch/arm/mach-imx/mx6/module_fuse.c         | 1 -
>  arch/arm/mach-imx/mx6/mp.c                  | 1 -
>  arch/arm/mach-imx/mx6/opos6ul.c             | 2 +-
>  arch/arm/mach-imx/mx6/soc.c                 | 1 -
>  arch/arm/mach-imx/mx7/clock.c               | 3 ++-
>  arch/arm/mach-imx/mx7/clock_slice.c         | 1 -
>  arch/arm/mach-imx/mx7/ddr.c                 | 1 -
>  arch/arm/mach-imx/mx7/psci-mx7.c            | 1 -
>  arch/arm/mach-imx/mx7/soc.c                 | 1 -
>  arch/arm/mach-imx/mx7ulp/clock.c            | 2 +-
>  arch/arm/mach-imx/mx7ulp/iomux.c            | 1 -
>  arch/arm/mach-imx/mx7ulp/pcc.c              | 1 -
>  arch/arm/mach-imx/mx7ulp/scg.c              | 2 +-
>  arch/arm/mach-imx/mx7ulp/soc.c              | 2 +-
>  arch/arm/mach-imx/priblob.c                 | 1 -
>  arch/arm/mach-imx/rdc-sema.c                | 1 -
>  arch/arm/mach-imx/speed.c                   | 2 +-
>  arch/arm/mach-imx/spl.c                     | 2 +-
>  arch/arm/mach-imx/spl_imx_romapi.c          | 1 -
>  arch/arm/mach-imx/syscounter.c              | 2 +-
>  arch/arm/mach-imx/timer.c                   | 1 -
>  arch/arm/mach-imx/video.c                   | 3 ++-
>  84 files changed, 38 insertions(+), 82 deletions(-)
>=20
> diff --git a/arch/arm/cpu/arm1136/mx31/devices.c
> b/arch/arm/cpu/arm1136/mx31/devices.c
> index 9997e8fc3396..87ca303e31ba 100644
> --- a/arch/arm/cpu/arm1136/mx31/devices.c
> +++ b/arch/arm/cpu/arm1136/mx31/devices.c
> @@ -6,7 +6,6 @@
>   * (c) 2007 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
>   */
>=20
> -#include <common.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/clock.h>
>=20
> diff --git a/arch/arm/cpu/arm1136/mx31/generic.c
> b/arch/arm/cpu/arm1136/mx31/generic.c
> index a3d4f1479623..fc56baccfcd6 100644
> --- a/arch/arm/cpu/arm1136/mx31/generic.c
> +++ b/arch/arm/cpu/arm1136/mx31/generic.c
> @@ -4,7 +4,6 @@
>   * Sascha Hauer, Pengutronix
>   */
>=20
> -#include <common.h>
>  #include <div64.h>
>  #include <init.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/cpu/arm1136/mx31/timer.c
> b/arch/arm/cpu/arm1136/mx31/timer.c
> index a913860491cb..b41ca68ae552 100644
> --- a/arch/arm/cpu/arm1136/mx31/timer.c
> +++ b/arch/arm/cpu/arm1136/mx31/timer.c
> @@ -4,7 +4,6 @@
>   * Sascha Hauer, Pengutronix
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/clock.c
> b/arch/arm/cpu/arm926ejs/mxs/clock.c
> index 4e1cf3a1e32b..58f6cf80cae0 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/clock.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/clock.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2010 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <log.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/iomux.c
> b/arch/arm/cpu/arm926ejs/mxs/iomux.c
> index 381264b8a18d..851b4deb080b 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/iomux.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/iomux.c
> @@ -6,7 +6,6 @@
>   *                       <armlinux@phytec.de>
>   */
>=20
> -#include <common.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
>  #include <asm/arch/clock.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/mxs.c
> b/arch/arm/cpu/arm926ejs/mxs/mxs.c
> index 4f3cb63c56df..7b2bb09551b5 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/mxs.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/mxs.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2010 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <hang.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> index 249f8de8fbe1..76a69d7f9586 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_lradc_init.c
> b/arch/arm/cpu/arm926ejs/mxs/spl_lradc_init.c
> index 2cfbd780953d..b2d3b2b13efd 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/spl_lradc_init.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/spl_lradc_init.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
> b/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
> index a94803ee93d9..c3136dd8976a 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_power_init.c
> b/arch/arm/cpu/arm926ejs/mxs/spl_power_init.c
> index 77bca7e331a0..8b65c094a8ad 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/spl_power_init.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/spl_power_init.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <hang.h>
>  #include <log.h>
> diff --git a/arch/arm/cpu/arm926ejs/mxs/start.S
> b/arch/arm/cpu/arm926ejs/mxs/start.S
> index 61982e38a1d4..a6eb053cadb0 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/start.S
> +++ b/arch/arm/cpu/arm926ejs/mxs/start.S
> @@ -20,7 +20,6 @@
>=20
>  #include <asm-offsets.h>
>  #include <config.h>
> -#include <common.h>
>  #include <system-constants.h>
>=20
>  /*
> diff --git a/arch/arm/cpu/arm926ejs/mxs/timer.c
> b/arch/arm/cpu/arm926ejs/mxs/timer.c
> index 3dff3d768d1c..cbd3b5d9958a 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/timer.c
> +++ b/arch/arm/cpu/arm926ejs/mxs/timer.c
> @@ -9,7 +9,6 @@
>   * (C) Copyright 2009-2010 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <time.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/include/asm/arch-mx5/clock.h
> b/arch/arm/include/asm/arch-mx5/clock.h
> index d585b5cf4b22..58013a85951a 100644
> --- a/arch/arm/include/asm/arch-mx5/clock.h
> +++ b/arch/arm/include/asm/arch-mx5/clock.h
> @@ -7,6 +7,8 @@
>  #ifndef __ASM_ARCH_CLOCK_H
>  #define __ASM_ARCH_CLOCK_H
>=20
> +#include <stdbool.h>
> +
>  #ifdef CONFIG_SYS_MX5_HCLK
>  #define MXC_HCLK	CONFIG_SYS_MX5_HCLK
>  #else
> diff --git a/arch/arm/include/asm/arch-mx7/sys_proto.h
> b/arch/arm/include/asm/arch-mx7/sys_proto.h
> index 634736cc09cd..5da0037b2c6b 100644
> --- a/arch/arm/include/asm/arch-mx7/sys_proto.h
> +++ b/arch/arm/include/asm/arch-mx7/sys_proto.h
> @@ -7,6 +7,8 @@
>=20
>  #include <asm/mach-imx/sys_proto.h>
>=20
> +struct wdog_regs;
> +
>  void set_wdog_reset(struct wdog_regs *wdog);
>=20
>  #endif /* __SYS_PROTO_IMX7_ */
> diff --git a/arch/arm/mach-imx/cache.c b/arch/arm/mach-imx/cache.c index
> ab9b621a2a62..b368db49fce5 100644
> --- a/arch/arm/mach-imx/cache.c
> +++ b/arch/arm/mach-imx/cache.c
> @@ -3,7 +3,7 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <asm/armv7.h>
>  #include <asm/cache.h>
> diff --git a/arch/arm/mach-imx/cmd_bmode.c b/arch/arm/mach-
> imx/cmd_bmode.c index 5b2f4686230c..c20e80725f8b 100644
> --- a/arch/arm/mach-imx/cmd_bmode.c
> +++ b/arch/arm/mach-imx/cmd_bmode.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2012 Boundary Devices Inc.
>   */
> -#include <common.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
>  #include <asm/mach-imx/boot_mode.h>
> diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> index 2f389dbe8df0..c7962ead2d54 100644
> --- a/arch/arm/mach-imx/cmd_dek.c
> +++ b/arch/arm/mach-imx/cmd_dek.c
> @@ -6,7 +6,7 @@
>   * Command for encapsulating DEK blob
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <log.h>
>  #include <malloc.h>
> @@ -17,6 +17,7 @@
>  #include <asm/arch/clock.h>
>  #include <mapmem.h>
>  #include <tee.h>
> +#include <vsprintf.h>
>  #ifdef CONFIG_IMX_SECO_DEK_ENCAP
>  #include <imx_container.h>
>  #include <firmware/imx/sci/sci.h>
> diff --git a/arch/arm/mach-imx/cmd_hdmidet.c b/arch/arm/mach-
> imx/cmd_hdmidet.c index e2571adfb006..8104ab26b08f 100644
> --- a/arch/arm/mach-imx/cmd_hdmidet.c
> +++ b/arch/arm/mach-imx/cmd_hdmidet.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2012 Boundary Devices Inc.
>   */
> -#include <common.h>
>  #include <command.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/mxc_hdmi.h>
> diff --git a/arch/arm/mach-imx/cmd_mfgprot.c b/arch/arm/mach-
> imx/cmd_mfgprot.c index 9576b48dde30..9925c9922687 100644
> --- a/arch/arm/mach-imx/cmd_mfgprot.c
> +++ b/arch/arm/mach-imx/cmd_mfgprot.c
> @@ -11,7 +11,7 @@
>  #include <asm/arch/clock.h>
>  #include <linux/compiler.h>
>  #include <command.h>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <fsl_sec.h>
>  #include <mapmem.h>
> diff --git a/arch/arm/mach-imx/cmd_nandbcb.c b/arch/arm/mach-
> imx/cmd_nandbcb.c index 70a213a49dd0..c2e452b69270 100644
> --- a/arch/arm/mach-imx/cmd_nandbcb.c
> +++ b/arch/arm/mach-imx/cmd_nandbcb.c
> @@ -11,7 +11,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c index
> 488638c90585..ceee31eecd79 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -7,7 +7,6 @@
>   */
>=20
>  #include <bootm.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/mach-imx/ddrmc-vf610-calibration.c b/arch/arm/mach-
> imx/ddrmc-vf610-calibration.c
> index 7d787d045980..2cf684322ea3 100644
> --- a/arch/arm/mach-imx/ddrmc-vf610-calibration.c
> +++ b/arch/arm/mach-imx/ddrmc-vf610-calibration.c
> @@ -7,7 +7,6 @@
>   *
>   */
>  /* #define DEBUG */
> -#include <common.h>
>  #include <log.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/ddrmc-vf610.c b/arch/arm/mach-imx/ddrmc-
> vf610.c index 7895ee66f8a8..e449fa6f552d 100644
> --- a/arch/arm/mach-imx/ddrmc-vf610.c
> +++ b/arch/arm/mach-imx/ddrmc-vf610.c
> @@ -6,7 +6,6 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/iomux-vf610.h>
> diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
> index d02316ed6cb1..eaeecf600423 100644
> --- a/arch/arm/mach-imx/ele_ahab.c
> +++ b/arch/arm/mach-imx/ele_ahab.c
> @@ -3,7 +3,6 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <errno.h>
>  #include <imx_container.h>
> @@ -15,6 +14,7 @@
>  #include <console.h>
>  #include <cpu_func.h>
>  #include <asm/global_data.h>
> +#include <asm/u-boot.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c index
> 27e053ef701c..85d90686f680 100644
> --- a/arch/arm/mach-imx/hab.c
> +++ b/arch/arm/mach-imx/hab.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2010-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <config.h>
>  #include <display_options.h>
> diff --git a/arch/arm/mach-imx/i2c-mxv7.c b/arch/arm/mach-imx/i2c-mxv7.c
> index a5866cf9f703..256db150818a 100644
> --- a/arch/arm/mach-imx/i2c-mxv7.c
> +++ b/arch/arm/mach-imx/i2c-mxv7.c
> @@ -2,8 +2,8 @@
>  /*
>   * Copyright (C) 2012 Boundary Devices Inc.
>   */
> -#include <common.h>
>  #include <malloc.h>
> +#include <time.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
>  #include <linux/delay.h>
> diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-
> imx/image-container.c
> index 35da0ae04258..e2388e3fef86 100644
> --- a/arch/arm/mach-imx/image-container.c
> +++ b/arch/arm/mach-imx/image-container.c
> @@ -3,7 +3,7 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <errno.h>
>  #include <imx_container.h>
>  #include <log.h>
> diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-
> imx/imx8/ahab.c index 1c072f6af11d..ed44df394b15 100644
> --- a/arch/arm/mach-imx/imx8/ahab.c
> +++ b/arch/arm/mach-imx/imx8/ahab.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018-2019, 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <errno.h>
>  #include <imx_container.h>
> diff --git a/arch/arm/mach-imx/imx8/clock.c b/arch/arm/mach-
> imx/imx8/clock.c index 9941b57b4be5..4e49b5bf3755 100644
> --- a/arch/arm/mach-imx/imx8/clock.c
> +++ b/arch/arm/mach-imx/imx8/clock.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <asm/global_data.h>
>  #include <linux/errno.h>
>  #include <asm/arch/clock.h>
> diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
> index 6e643188f402..627baa1d83fd 100644
> --- a/arch/arm/mach-imx/imx8/cpu.c
> +++ b/arch/arm/mach-imx/imx8/cpu.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018, 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <clk.h>
>  #include <cpu.h>
>  #include <cpu_func.h>
> diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
> index c2bed3e0c1fb..6d0585f5cc67 100644
> --- a/arch/arm/mach-imx/imx8/fdt.c
> +++ b/arch/arm/mach-imx/imx8/fdt.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <log.h>
>  #include <firmware/imx/sci/sci.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/imx8/iomux.c b/arch/arm/mach-
> imx/imx8/iomux.c index e4f7651bd1d4..3e27d75827a5 100644
> --- a/arch/arm/mach-imx/imx8/iomux.c
> +++ b/arch/arm/mach-imx/imx8/iomux.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <log.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/imx8/misc.c b/arch/arm/mach-
> imx/imx8/misc.c index 0ce3036818b6..c77104d0338f 100644
> --- a/arch/arm/mach-imx/imx8/misc.c
> +++ b/arch/arm/mach-imx/imx8/misc.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -#include <common.h>
>  #include <log.h>
>  #include <firmware/imx/sci/sci.h>
>  #include <asm/mach-imx/sys_proto.h>
> diff --git a/arch/arm/mach-imx/imx8/snvs_security_sc.c b/arch/arm/mach-
> imx/imx8/snvs_security_sc.c
> index 1eaa68f8d5ff..f13dfc155165 100644
> --- a/arch/arm/mach-imx/imx8/snvs_security_sc.c
> +++ b/arch/arm/mach-imx/imx8/snvs_security_sc.c
> @@ -14,7 +14,6 @@
>  #include <command.h>
>  #include <log.h>
>  #include <stddef.h>
> -#include <common.h>
>  #include <firmware/imx/sci/sci.h>
>  #include <asm/arch-imx8/imx8-pins.h>
>  #include <asm/arch-imx8/snvs_security_sc.h>
> diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-
> imx/imx8m/clock_imx8mm.c
> index 47219957b58c..de630e940c90 100644
> --- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
> +++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
> @@ -5,7 +5,6 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mq.c b/arch/arm/mach-
> imx/imx8m/clock_imx8mq.c
> index 9db62b944e4c..7e6c37487163 100644
> --- a/arch/arm/mach-imx/imx8m/clock_imx8mq.c
> +++ b/arch/arm/mach-imx/imx8m/clock_imx8mq.c
> @@ -5,7 +5,6 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/imx8m/clock_slice.c b/arch/arm/mach-
> imx/imx8m/clock_slice.c
> index b5ed27a923e0..7cfdc46d349e 100644
> --- a/arch/arm/mach-imx/imx8m/clock_slice.c
> +++ b/arch/arm/mach-imx/imx8m/clock_slice.c
> @@ -5,7 +5,6 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/imx8m/psci.c b/arch/arm/mach-
> imx/imx8m/psci.c index 62f0b768cfa4..f5644c642bd6 100644
> --- a/arch/arm/mach-imx/imx8m/psci.c
> +++ b/arch/arm/mach-imx/imx8m/psci.c
> @@ -10,7 +10,6 @@
>  #include <asm/io.h>
>  #include <asm/psci.h>
>  #include <asm/secure.h>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <debug_uart.h>
>  #include <fsl_wdog.h>
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-
> imx/imx8m/soc.c index 0c49fb9cd488..be38ca528850 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -5,7 +5,7 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <event.h>
>  #include <init.h>
> diff --git a/arch/arm/mach-imx/imx8ulp/cgc.c b/arch/arm/mach-
> imx/imx8ulp/cgc.c index d2fadb4877c9..f9d8ed5b048b 100644
> --- a/arch/arm/mach-imx/imx8ulp/cgc.c
> +++ b/arch/arm/mach-imx/imx8ulp/cgc.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <div64.h>
>  #include <asm/io.h>
>  #include <errno.h>
> diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-
> imx/imx8ulp/clock.c
> index 36d12943a059..fadf165ece27 100644
> --- a/arch/arm/mach-imx/imx8ulp/clock.c
> +++ b/arch/arm/mach-imx/imx8ulp/clock.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <div64.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/imx8ulp/iomux.c b/arch/arm/mach-
> imx/imx8ulp/iomux.c
> index c6d20f546809..43f856bf7324 100644
> --- a/arch/arm/mach-imx/imx8ulp/iomux.c
> +++ b/arch/arm/mach-imx/imx8ulp/iomux.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020-2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/iomux.h>
> diff --git a/arch/arm/mach-imx/imx8ulp/pcc.c b/arch/arm/mach-
> imx/imx8ulp/pcc.c index e3c6d6760be2..449e496521f1 100644
> --- a/arch/arm/mach-imx/imx8ulp/pcc.c
> +++ b/arch/arm/mach-imx/imx8ulp/pcc.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <div64.h>
>  #include <asm/io.h>
>  #include <errno.h>
> diff --git a/arch/arm/mach-imx/imx8ulp/rdc.c b/arch/arm/mach-
> imx/imx8ulp/rdc.c index cfc09e79cbd5..ca657748ed9a 100644
> --- a/arch/arm/mach-imx/imx8ulp/rdc.c
> +++ b/arch/arm/mach-imx/imx8ulp/rdc.c
> @@ -3,7 +3,8 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
> +#include <linux/errno.h>
>  #include <asm/io.h>
>  #include <asm/types.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-
> imx/imx9/clock.c index 75d92af036a1..0abf4579a1e0 100644
> --- a/arch/arm/mach-imx/imx9/clock.c
> +++ b/arch/arm/mach-imx/imx9/clock.c
> @@ -5,7 +5,6 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/imx9/clock_root.c b/arch/arm/mach-
> imx/imx9/clock_root.c
> index 7d7ae865946f..47106fffefba 100644
> --- a/arch/arm/mach-imx/imx9/clock_root.c
> +++ b/arch/arm/mach-imx/imx9/clock_root.c
> @@ -5,7 +5,7 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/imx9/imx_bootaux.c b/arch/arm/mach-
> imx/imx9/imx_bootaux.c
> index 6afb59e05159..73f2e72263d6 100644
> --- a/arch/arm/mach-imx/imx9/imx_bootaux.c
> +++ b/arch/arm/mach-imx/imx9/imx_bootaux.c
> @@ -3,11 +3,12 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <log.h>
>  #include <imx_sip.h>
> +#include <vsprintf.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/errno.h>
>=20
>  int arch_auxiliary_core_check_up(u32 core_id)  { diff --git a/arch/arm/m=
ach-
> imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c index
> 2117489f2320..32208220b207 100644
> --- a/arch/arm/mach-imx/imx9/soc.c
> +++ b/arch/arm/mach-imx/imx9/soc.c
> @@ -5,7 +5,7 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-
> imx/imx9/trdc.c index d0f855bb1bc1..8cdb28459a36 100644
> --- a/arch/arm/mach-imx/imx9/trdc.c
> +++ b/arch/arm/mach-imx/imx9/trdc.c
> @@ -3,8 +3,8 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <log.h>
> +#include <linux/errno.h>
>  #include <asm/io.h>
>  #include <asm/types.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/imx_bootaux.c b/arch/arm/mach-
> imx/imx_bootaux.c index f7b14ca38d94..26374fdc33ec 100644
> --- a/arch/arm/mach-imx/imx_bootaux.c
> +++ b/arch/arm/mach-imx/imx_bootaux.c
> @@ -3,15 +3,18 @@
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <log.h>
> +#include <asm/arch/imx-regs.h>
>  #include <asm/io.h>
>  #include <asm/mach-imx/sys_proto.h>
>  #include <command.h>
>  #include <elf.h>
>  #include <imx_sip.h>
> +#include <vsprintf.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/compiler.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
>  #include <cpu_func.h>
>=20
>  #ifndef CONFIG_IMX8
> diff --git a/arch/arm/mach-imx/imxrt/soc.c b/arch/arm/mach-imx/imxrt/soc.=
c
> index 34162a3976fb..3028957953bd 100644
> --- a/arch/arm/mach-imx/imxrt/soc.c
> +++ b/arch/arm/mach-imx/imxrt/soc.c
> @@ -4,7 +4,6 @@
>   * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/io.h>
>  #include <asm/armv7_mpu.h>
> diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
> index 18131a20f438..c134e95ed780 100644
> --- a/arch/arm/mach-imx/iomux-v3.c
> +++ b/arch/arm/mach-imx/iomux-v3.c
> @@ -7,7 +7,6 @@
>   *
>   * Copyright (C) 2004-2011 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/mach-imx/iomux-v3.h>
> diff --git a/arch/arm/mach-imx/mac.c b/arch/arm/mach-imx/mac.c index
> 9bb63d25b488..e739fd14c898 100644
> --- a/arch/arm/mach-imx/mac.c
> +++ b/arch/arm/mach-imx/mac.c
> @@ -5,7 +5,6 @@
>   * Peng Fan <peng.fan@nxp.com>
>   */
>=20
> -#include <common.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/io.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/misc.c b/arch/arm/mach-imx/misc.c index
> 09a758ff6e89..7452b82f1105 100644
> --- a/arch/arm/mach-imx/misc.c
> +++ b/arch/arm/mach-imx/misc.c
> @@ -3,7 +3,6 @@
>   * Copyright 2013 Stefan Roese <sr@denx.de>
>   */
>=20
> -#include <common.h>
>  #include <lmb.h>
>  #include <log.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/mmc_env.c b/arch/arm/mach-
> imx/mmc_env.c index 9c822f721c60..34a7d1706f3d 100644
> --- a/arch/arm/mach-imx/mmc_env.c
> +++ b/arch/arm/mach-imx/mmc_env.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2017 NXP
>   */
>=20
> -#include <common.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/mmdc_size.c b/arch/arm/mach-
> imx/mmdc_size.c index 41a5af6bd307..2b1d203f8635 100644
> --- a/arch/arm/mach-imx/mmdc_size.c
> +++ b/arch/arm/mach-imx/mmdc_size.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/io.h>
>=20
>  #if defined(CONFIG_MX53)
> diff --git a/arch/arm/mach-imx/mx5/clock.c b/arch/arm/mach-
> imx/mx5/clock.c index bbaddd5a33fa..0b8a10fd7294 100644
> --- a/arch/arm/mach-imx/mx5/clock.c
> +++ b/arch/arm/mach-imx/mx5/clock.c
> @@ -6,7 +6,6 @@
>   * (C) Copyright 2009 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/mx5/mx53_dram.c b/arch/arm/mach-
> imx/mx5/mx53_dram.c
> index f74414419470..6459b4a82d25 100644
> --- a/arch/arm/mach-imx/mx5/mx53_dram.c
> +++ b/arch/arm/mach-imx/mx5/mx53_dram.c
> @@ -4,9 +4,9 @@
>   * Patrick Bruenn <p.bruenn@beckhoff.com>
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> +#include <asm/u-boot.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> diff --git a/arch/arm/mach-imx/mx5/soc.c b/arch/arm/mach-imx/mx5/soc.c
> index 47f531dc856c..4df5f9c16416 100644
> --- a/arch/arm/mach-imx/mx5/soc.c
> +++ b/arch/arm/mach-imx/mx5/soc.c
> @@ -6,7 +6,6 @@
>   * (C) Copyright 2009 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/clock.h>
> diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-
> imx/mx6/clock.c index e0da9c239584..fb9f56d2e63c 100644
> --- a/arch/arm/mach-imx/mx6/clock.c
> +++ b/arch/arm/mach-imx/mx6/clock.c
> @@ -3,10 +3,10 @@
>   * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <div64.h>
>  #include <log.h>
> +#include <time.h>
>  #include <asm/io.h>
>  #include <linux/errno.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/mx6/ddr.c b/arch/arm/mach-imx/mx6/ddr.c
> index 3c87c577737b..5a1258e002d2 100644
> --- a/arch/arm/mach-imx/mx6/ddr.c
> +++ b/arch/arm/mach-imx/mx6/ddr.c
> @@ -4,7 +4,6 @@
>   * Author: Tim Harvey <tharvey@gateworks.com>
>   */
>=20
> -#include <common.h>
>  #include <hang.h>
>  #include <log.h>
>  #include <linux/delay.h>
> diff --git a/arch/arm/mach-imx/mx6/litesom.c b/arch/arm/mach-
> imx/mx6/litesom.c index 2ba3245e226c..ab5de2665778 100644
> --- a/arch/arm/mach-imx/mx6/litesom.c
> +++ b/arch/arm/mach-imx/mx6/litesom.c
> @@ -17,7 +17,7 @@
>  #include <asm/mach-imx/iomux-v3.h>
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/io.h>
> -#include <common.h>
> +#include <config.h>
>  #include <fsl_esdhc_imx.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> diff --git a/arch/arm/mach-imx/mx6/module_fuse.c b/arch/arm/mach-
> imx/mx6/module_fuse.c
> index b58f11c1e562..8b23d48a854c 100644
> --- a/arch/arm/mach-imx/mx6/module_fuse.c
> +++ b/arch/arm/mach-imx/mx6/module_fuse.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <fdt_support.h>
>  #include <asm/io.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/arch/arm/mach-imx/mx6/mp.c b/arch/arm/mach-imx/mx6/mp.c
> index de9ace083ce8..091a37238316 100644
> --- a/arch/arm/mach-imx/mx6/mp.c
> +++ b/arch/arm/mach-imx/mx6/mp.c
> @@ -6,7 +6,6 @@
>   * (C) Copyright 2009 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <asm/io.h>
>  #include <linux/errno.h>
> diff --git a/arch/arm/mach-imx/mx6/opos6ul.c b/arch/arm/mach-
> imx/mx6/opos6ul.c index 38ead8ace20c..340e6147b638 100644
> --- a/arch/arm/mach-imx/mx6/opos6ul.c
> +++ b/arch/arm/mach-imx/mx6/opos6ul.c
> @@ -10,7 +10,7 @@
>  #include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
> diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
> index c2875e727c94..3a3e01f3d0aa 100644
> --- a/arch/arm/mach-imx/mx6/soc.c
> +++ b/arch/arm/mach-imx/mx6/soc.c
> @@ -7,7 +7,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <linux/delay.h>
> diff --git a/arch/arm/mach-imx/mx7/clock.c b/arch/arm/mach-
> imx/mx7/clock.c index 4e232385afc3..a8606fa9b24b 100644
> --- a/arch/arm/mach-imx/mx7/clock.c
> +++ b/arch/arm/mach-imx/mx7/clock.c
> @@ -6,11 +6,12 @@
>   *	Peng Fan <Peng.Fan@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <command.h>
>  #include <div64.h>
>  #include <log.h>
> +#include <time.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/errno.h>
> diff --git a/arch/arm/mach-imx/mx7/clock_slice.c b/arch/arm/mach-
> imx/mx7/clock_slice.c
> index dd731d949621..2a1304fc1128 100644
> --- a/arch/arm/mach-imx/mx7/clock_slice.c
> +++ b/arch/arm/mach-imx/mx7/clock_slice.c
> @@ -6,7 +6,6 @@
>   *	Peng Fan <Peng.Fan@freescale.com>
>   */
>=20
> -#include <common.h>
>  #include <div64.h>
>  #include <asm/io.h>
>  #include <linux/errno.h>
> diff --git a/arch/arm/mach-imx/mx7/ddr.c b/arch/arm/mach-imx/mx7/ddr.c
> index cf25569765ea..c4a90be3945b 100644
> --- a/arch/arm/mach-imx/mx7/ddr.c
> +++ b/arch/arm/mach-imx/mx7/ddr.c
> @@ -12,7 +12,6 @@
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/crm_regs.h>
>  #include <asm/arch/mx7-ddr.h>
> -#include <common.h>
>  #include <linux/delay.h>
>=20
>  /*
> diff --git a/arch/arm/mach-imx/mx7/psci-mx7.c b/arch/arm/mach-
> imx/mx7/psci-mx7.c
> index 0b71fa403446..12d6a63b9255 100644
> --- a/arch/arm/mach-imx/mx7/psci-mx7.c
> +++ b/arch/arm/mach-imx/mx7/psci-mx7.c
> @@ -13,7 +13,6 @@
>  #include <asm/armv7.h>
>  #include <asm/gic.h>
>  #include <linux/bitops.h>
> -#include <common.h>
>  #include <fsl_wdog.h>
>=20
>  #define GPC_LPCR_A7_BSC	0x0
> diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
> index 689dbefe8ee0..16c77cbf7bee 100644
> --- a/arch/arm/mach-imx/mx7/soc.c
> +++ b/arch/arm/mach-imx/mx7/soc.c
> @@ -4,7 +4,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/mx7ulp/clock.c b/arch/arm/mach-
> imx/mx7ulp/clock.c
> index 37d8565c20fc..fb19c62a5200 100644
> --- a/arch/arm/mach-imx/mx7ulp/clock.c
> +++ b/arch/arm/mach-imx/mx7ulp/clock.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <command.h>
>  #include <div64.h>
> diff --git a/arch/arm/mach-imx/mx7ulp/iomux.c b/arch/arm/mach-
> imx/mx7ulp/iomux.c
> index 05ddeed2a64b..2c87a8c18b96 100644
> --- a/arch/arm/mach-imx/mx7ulp/iomux.c
> +++ b/arch/arm/mach-imx/mx7ulp/iomux.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
>  #include <log.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
> diff --git a/arch/arm/mach-imx/mx7ulp/pcc.c b/arch/arm/mach-
> imx/mx7ulp/pcc.c index aa7ea86a443e..0bfd8f71815a 100644
> --- a/arch/arm/mach-imx/mx7ulp/pcc.c
> +++ b/arch/arm/mach-imx/mx7ulp/pcc.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <div64.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/mx7ulp/scg.c b/arch/arm/mach-
> imx/mx7ulp/scg.c index 4c066557c1ca..d4fb5389cacb 100644
> --- a/arch/arm/mach-imx/mx7ulp/scg.c
> +++ b/arch/arm/mach-imx/mx7ulp/scg.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <div64.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-
> imx/mx7ulp/soc.c index 217b7c45867d..198ae2d919c9 100644
> --- a/arch/arm/mach-imx/mx7ulp/soc.c
> +++ b/arch/arm/mach-imx/mx7ulp/soc.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/mach-imx/priblob.c b/arch/arm/mach-imx/priblob.c
> index 5b022d5c8201..65924483bc89 100644
> --- a/arch/arm/mach-imx/priblob.c
> +++ b/arch/arm/mach-imx/priblob.c
> @@ -11,7 +11,6 @@
>   */
>=20
>  #include <asm/io.h>
> -#include <common.h>
>  #include <command.h>
>  #include <fsl_sec.h>
>=20
> diff --git a/arch/arm/mach-imx/rdc-sema.c b/arch/arm/mach-imx/rdc-sema.c
> index e683673753e1..56725cc109f0 100644
> --- a/arch/arm/mach-imx/rdc-sema.c
> +++ b/arch/arm/mach-imx/rdc-sema.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/mach-imx/rdc-sema.h>
> diff --git a/arch/arm/mach-imx/speed.c b/arch/arm/mach-imx/speed.c index
> 0e81cc880a1a..98a42b22f9cc 100644
> --- a/arch/arm/mach-imx/speed.c
> +++ b/arch/arm/mach-imx/speed.c
> @@ -7,7 +7,7 @@
>   * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <asm/arch/imx-regs.h>
>  #include <asm/arch/clock.h>
> diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c index
> b30cd9625538..bc291dcd1296 100644
> --- a/arch/arm/mach-imx/spl.c
> +++ b/arch/arm/mach-imx/spl.c
> @@ -6,7 +6,7 @@
>   * Author: Tim Harvey <tharvey@gateworks.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <hang.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-
> imx/spl_imx_romapi.c
> index b9ff9bb83b3c..9a86f5c133f7 100644
> --- a/arch/arm/mach-imx/spl_imx_romapi.c
> +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <errno.h>
>  #include <image.h>
>  #include <imx_container.h>
> diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-
> imx/syscounter.c index 16df1186759e..922f851c56b7 100644
> --- a/arch/arm/mach-imx/syscounter.c
> +++ b/arch/arm/mach-imx/syscounter.c
> @@ -5,7 +5,7 @@
>   * The file use ls102xa/timer.c as a reference.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <time.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/mach-imx/timer.c b/arch/arm/mach-imx/timer.c index
> fcd45f09f181..5ac8f28e670d 100644
> --- a/arch/arm/mach-imx/timer.c
> +++ b/arch/arm/mach-imx/timer.c
> @@ -6,7 +6,6 @@
>   * (C) Copyright 2009 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <time.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/mach-imx/video.c b/arch/arm/mach-imx/video.c index
> 1bc9b7cc7e15..6cbb49da53cc 100644
> --- a/arch/arm/mach-imx/video.c
> +++ b/arch/arm/mach-imx/video.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>=20
> -#include <common.h>
> +#include <stdio.h>
>  #include <env.h>
>  #include <linux/errno.h>
> +#include <asm/arch/imx-regs.h>
>  #include <asm/mach-imx/video.h>
>=20
>  #ifdef CONFIG_IMX_HDMI
> --
> 2.34.1

