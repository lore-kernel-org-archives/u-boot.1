Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD7C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 12:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E44D885F5;
	Tue, 23 Jul 2024 14:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QqRqnjyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CB58865D; Tue, 23 Jul 2024 14:40:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348A088496
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i87piagwYL8QmheeepeGzzC6GY1521W7RBVF3RfsOxIcFXS9+iD8z4DbJPCohBQNJMsQ7FFeAYeFdD5PA7AEGtdwpgKrydyyuyNuxNqEqMJt4oEVAJkpgw+VEVvAtCCwDIgpIc8z5LLnF4xB/UuRAQKnUTsNcNxKT25XR239qA337dNpklmFyY7d+oGDMaW2DlJn7QYnFshM8pI4r2fJUiTodTIQpn5mVmMMOMzbIl9KYE3sjr+Uoqao0W28BfL4JxLesVSzKgvL7DGonIPXRBF8OZyhExNw8czxecmnv/D/64fs+Fo888BojpTDOX9CctsYpDkRfBHUFa85rYRdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEJ5BvQme00OOB2mAMUBvoVKn10/5vPtcdixhbvpr90=;
 b=ufXU1u8P/aK3lEThxXZHslEPhZ0JN9NLpEzxGDa7jhUbd8Tw+VHcBQ4sKu6b7B7k1V8OgyFR1BCukmDgVbXcm3otx705U0bMUaz2fRqbn6hxYfzKNWM8wALfylVF5Ax/I2NMFgW/NFr9yl0G/kMrAF4+E4CJ8/EGiyLsl+WzhKIFoTMzHcjo1Z7RxtNf3TokC5bt6v6HACjf/cMpTP59gAUjvg7IXMB9M7VXPMP4vch9aRTlCnt9uoIRESeD8AKIQ46i2KgTQsh32eUdKwXy9Zut+KLVkL24SFUcSNjcfwnofGR1kC53anawpzG7eYZgxHe1DRlumPbDgZzktfju2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEJ5BvQme00OOB2mAMUBvoVKn10/5vPtcdixhbvpr90=;
 b=QqRqnjyBVNuwhfsVzAfhHDbW1SEn9VipG1h4T/HwLDZcnvzF9fqujvwHC8tEb2DWCnAqozzwUyPFAWZSNIVWytKWdHVIGl8sjv7u/Gp9ZrVMTj3YyymD+DdboJqKLzvdyc1PahN0aml6MZXeaxqow3aWbuQL936vS1kaiVa5v1U=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 12:40:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Tue, 23 Jul 2024
 12:40:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>
Subject: RE: [PATCH v2] warp7: Convert to OF_UPSTREAM
Thread-Topic: [PATCH v2] warp7: Convert to OF_UPSTREAM
Thread-Index: AQHa3GD17EMFnA0CdkmQeV8bzMvXLrIEQhcA
Date: Tue, 23 Jul 2024 12:40:24 +0000
Message-ID: <PAXPR04MB845916D465FB022048698FFA88A92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240722175935.2165598-1-festevam@gmail.com>
In-Reply-To: <20240722175935.2165598-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
x-ms-office365-filtering-correlation-id: c0554fec-97dd-4e7a-8b7c-08dcab149f71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZoYNWZrENhl0BzDJ8zzkEHlJ3ozx+XYwbXBUJSLKrrkQZPqEJbWAsFvs3+nq?=
 =?us-ascii?Q?pWXmYSkQ3YUOsOcG/Ug8pYhsV18M2DvlS2bgNCvi4DdOiyIL+Wu53vmqhCz5?=
 =?us-ascii?Q?1GcGeSdMhunLGJNQBFyWg3Z4Td+OcPomPYtqx5zm57yaWdSYmue0Z52ZWA9I?=
 =?us-ascii?Q?+IwQ9QTOvJcHgYHdnfqn5tZTE1V/+vKx6t4Jg3Y+HumhuNSyHIwclRb8vPtH?=
 =?us-ascii?Q?E1vzGGVpECWvN2FVRuQCGNkO6sNR0diBAXOOUiBejHC4r3Tuhd4011Q4xQLy?=
 =?us-ascii?Q?phYWpF5+E/rh1b3EZzq/TZOhVMpsqjiJz7kJJVKJloI2Z8cUjEeBAtDNLrfj?=
 =?us-ascii?Q?T1IxUcXHg+nVwh6EtcfSbHrelSolDehmrjNSyxDytzMZW5RgCLN0HFcPXl/8?=
 =?us-ascii?Q?wgpdIVqMyaMK7zj7gBiWRZMHJHssb5Mio+PbSdQ02AhyPwnGoVeX7XwrbbPk?=
 =?us-ascii?Q?Buyi++5eWbDZID0rJf10ogsSoE2bWvMB5paqogsj+R0XsYUomu+MKC8/luu0?=
 =?us-ascii?Q?QtSr6/5/zHbpARCxELlTQ0NUWhuiZjqq54iwhEcucA8RSoJBT+dVOuuxuy8w?=
 =?us-ascii?Q?WYQnkmuj8i6fiebF1QO2C00M5FZken9G5HQHCCDYBqRf/gzJQzQGWU1DoLTk?=
 =?us-ascii?Q?YI51V3KQ4rP9vo0/KxfL0Iu/p83AeX7NlKZyUtJddM3TZTqGoH1SQVIcfk0a?=
 =?us-ascii?Q?UkBNbZB3mCu0TB01GpU6ZENVmopY8GD/ScZvz/ZQ/sSueQUbir0WwuGzUa2N?=
 =?us-ascii?Q?Qm7aZ6JGI6E9yRdw4yamytuHAAjkSaDFXH/jpccEOfrVywO4Zr3H67htHvzp?=
 =?us-ascii?Q?7lTbq6G6EYXcCuKMbgF2FBeQUyYgVjwPPpj/MlXWM8WLq2R1srtp0Z2cf8Cr?=
 =?us-ascii?Q?/vrbdpUleyboPifQXb6sGGHL4C9dTdo0uB4vpY5slpNK2Ef8MSN3F5JaMm3L?=
 =?us-ascii?Q?EpBY8EKTaoOd6PjvQrtYoYe5b3FtFkSsFGnYgGBw4tNyMQpoxs7h1WWFyTol?=
 =?us-ascii?Q?SMQUgDbxAg02W0aVjDjqMAkoltlTWc1S56ayBDPVxs+enTt9oSofPcskYZLT?=
 =?us-ascii?Q?wtPnSgbn8hNQInkaBFnKJpWSauGQT1JLDbKMRQyp74JtRVpsw/XwU02csU0W?=
 =?us-ascii?Q?v7l6/irW0aFHPODdkFZsT6Wz0q5T3KDUUvwUsySh4WIMnqPnXyH7b5bwZr2e?=
 =?us-ascii?Q?vQRZueYJbczU15tbaMDAA8k+L+IggrjGpMi6cFTi5UHDuyc/W1kLF2XR3OiQ?=
 =?us-ascii?Q?U70vwm34IhtWajDS0PdaWV1fvUXIE+4E47RgjIRpXW1SFk0Yn1h5Y8XIH7IA?=
 =?us-ascii?Q?NFi10r1rbT3DnXEJ9zc8kE9zTGahvn6xSSVygtNSdutZjeJMLNsnnPb5uul8?=
 =?us-ascii?Q?f5RGrjbc6qNdLySoPPgwwpGVSyngYYwpy6geEcgHip7G4o4qwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxBvZzB2Ds0DBD7oKg7c5vImwn7dGKbewFmPKxw1stbrQ37zMzlapt5bFDPJ?=
 =?us-ascii?Q?zKV8/bfuz162LrbQ6tBI95vY99XRyPsgDd/H5gE52XCVWWqkqoxSADy4oOVp?=
 =?us-ascii?Q?uSGhUldlUaGZ3H744xMunoP4OWMWDPN4XYolc7bWMyh2n7ata472f9efOSE7?=
 =?us-ascii?Q?vbqyLJAYco7FeXFSVpyXP7edz9QddgwjVHBEJHkX8p3cUw6UR7zE1vGRovPu?=
 =?us-ascii?Q?mmGAKnBdyEjgJ58PmV+IlDrnWkEToLq66SqG8cI7coGybq8bR/8txJpZ150S?=
 =?us-ascii?Q?uvK4weMd0cKHpOi6jLoDjB6KuOWZl5tieFyYlIKDvgbnLoQS5BJq+2qOUio6?=
 =?us-ascii?Q?N1Hudr3/PXIIkNWmkyboOe2SyCnwPp/jW27jy/ndQXEHIZVayE/4CK20sGZE?=
 =?us-ascii?Q?LQKtto9EUSUA+R9DnAxoqHTeYtN+SMfOkfxFoWmOI7mN9l5cpUA+JAIQTN3S?=
 =?us-ascii?Q?36K/a/BrLWsdDFvOVfcrgv8ZdtHfbh5aiVUpIR4+EQL/CLr7GsVDA8G2wT58?=
 =?us-ascii?Q?vHf4vW2UOxPJO+eIFzMn/CBfSjE/+tuEo1TxkGladxYpc8/bObI8R29a7oYn?=
 =?us-ascii?Q?bhDqD8w+A6DUHOp/YKEWkvgSPqU/15cZTSAXpmLlMhIF2awaBitk1q7a39Sp?=
 =?us-ascii?Q?CvFfHIbIpo0mbIVfKPvTvKH/OkHE4wBZgKlL0/3FT2Dh+VmUd6RGk11so/th?=
 =?us-ascii?Q?1BA+c9ytWL46AKqzcDAo5KQDt1ev9+VgmYlrjPhFyGJ/cqVIb0WJJC6YO263?=
 =?us-ascii?Q?0GEVcWJ3itzfG92tFuTBRgI46nwBf14nCEp9N0Z6rfw4HVIkPJ8dl2iiMGvv?=
 =?us-ascii?Q?E9Gvp2wiT92GJVo9UMreFOD73Y2ORVRKQ59Xrr1UpPM5S5AraRRr2PKYftm2?=
 =?us-ascii?Q?9h9yRt2ofD0mZ+XUcdrR6u9OgARahdivlPkW/gAK5lqMruzQLFSrF7sAdFTC?=
 =?us-ascii?Q?/EzD/3NRM/lUQS3HCUzDt2p6Sh5wrwQacJ/nnjxqsoH42AgNcjrVWLPDvT35?=
 =?us-ascii?Q?ke1epr5wl0rtaLJv/gaF/ofzBgKuXZL9/cFeJwlnG4XLHTdC9DSNZ8ko9dCo?=
 =?us-ascii?Q?VAp5FPdPPQK4vw7Mj7NwbcJFhvLxouqtolRL8t187ou3JymT5ELBs3Fx0Duc?=
 =?us-ascii?Q?dobl9HjOiSumt8Wa8h9ZDqua97yJELilvb7ug56swLNOj+C+XAZYKtkVgfCZ?=
 =?us-ascii?Q?wGBZ6NjjzuwKuc2KQJPgsKPDyjBDocZLhkQ6hhic3NSHL8S8GN3Ng2o3IMxJ?=
 =?us-ascii?Q?weVWzG/zoc1xtGuzMWXDxWKAZgu27ohm0BrTZgGs/bjSUoDYx5CkXYn78kFj?=
 =?us-ascii?Q?WtrcuUDrWPvXYC61XEzHOnhW6d3SKmgpKYuCH4PYaK/4nJ+Ff10+A0Xlc/Pr?=
 =?us-ascii?Q?+Y+2UqjbHhbJh3nDPHRFWm/G+wusBY7TX7FjDs6bZgdFNTEMK7cXSvrrPpTQ?=
 =?us-ascii?Q?HtdyEVX+ln3wMb/3Q6l6+Fs0Hn4PfwbLXamOz9Ze04mvNAdIqya/vkzcCZmO?=
 =?us-ascii?Q?KrLPP2+AWg1zCu4GXZFiKXgSHl9mfFuShvnsl2J0Hk4UfCpwYHVk50en/NIY?=
 =?us-ascii?Q?ZUSb/IFoLdcuGA/M8jk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0554fec-97dd-4e7a-8b7c-08dcab149f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 12:40:24.1846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abQ9GBT7RPrtvCHaenRCJV2xq5c1lu226ZZbmHdsMV6O5dxDvBFg4CoPfgcS0q6nkPo5vRpy0Mp1DOXI7u0MnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

> Subject: [PATCH v2] warp7: Convert to OF_UPSTREAM
>=20
> Instead of using the local imx7s-warp devicetree copies from U-Boot,
> convert the imx7s-warp board to OF_UPSTREAM so that the upstream
> kernel devicetree can be used instead.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
