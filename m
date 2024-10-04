Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B35ECFA758
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 10:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C3887FA7;
	Fri,  4 Oct 2024 12:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EE3SaHkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6776688387; Fri,  4 Oct 2024 12:12:16 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B2180245
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 12:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJwFmsYbF57stsaTnRVRmAAhkXQMQJ2/ubHpoUCLaA7lP154Zhl4OE6cXRGv0MhohKyRfWytT3f8W0YJ9Wz6JbgvqSbCZCD7uCx0pPoMiKqv5YXSMCQEHIRr/tyQm6Co4g+KDTpEf/hD5y0bjhIvo5ogEtJh0isy9oIt2GEfJkVxMOpTmVkAbQPdNN5rr32oGae4lS+cfFoivG67AkOR4lvpbsn37fZAilcJYDL7YnQTf58VL6wEuaBhRhEUpORM4iJSTmFIBdDkGjxdjFboA/BXNWmEfatT2Eyqi62wjjDvTRA4QLD6yq0qnoPEXVpIoH9HWWYua9ab0SXG/4P4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k25V3sk1rCdRBz1Yetx6sI7dmca0qMpD3kiL3WgOniU=;
 b=YpWnTVJL1gAWm6bbgjluCSHUPuKTWToiPreCr9JGtNffPxfW3Wag4llV8WMm2SkKKlVMEEzGf9n7fp7M0CgNIDVl6XyrkwndzSvix9TdCf9p5lHZ31F91EMs0iRQ7NRp6A6Dx/mcYeISTHkLxUmvoyUoB5Zshb4wcywwKypHLl80/Q6Oh9f69E4pqC16uZ2gp6PZ2nqjyVJtfvAulMDRPaabzFnyvZzpddSfTGZF25G8dpmFdH6meiZWHeB/A7aQ9aVunJU0oK+nRbwvkKd2SFWOi6s/n5l4ZGiwvXMGKcI2aTUOWpAUd7eoAJ4arqlGo0WcqHpdz4w0qVZf+n97Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k25V3sk1rCdRBz1Yetx6sI7dmca0qMpD3kiL3WgOniU=;
 b=EE3SaHkKd3fh2gsKlKGCw6W4V1OmtyjzIRYuOLvDVu/DB4eUiA4Svx8C27wdNp/2kUZFeUGmWNs/+7r3RDb3vQuVNx7fYPKKNjm8wzNgHU0wSeKdZ30HPwKEkgCvI3mevjLyVxTlgxCrmJ/iOWMTL8of1xeWEBIyTmVyl4PvslIx+bGKgSGML1qxxpCWGRw9BKZcZPUq2wymjkv7w8iD/7Tye7PjdZ6U+JoKVh5CAs0TdmN/C98zZjZu6vx295JXTROqkgDmsqFIVEW8Ybem1r7jNanfM7ugwIhoSl02n8C+NNEt9g9IkpfaAty9rhEM64LMLEi1DVmSgXzb9iBiCQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 10:12:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 10:12:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Vitor Soares <ivitro@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>
CC: Vitor Soares <vitor.soares@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] arm: imx: imx8m: soc: Fix VPU fdt disable fixup
Thread-Topic: [PATCH v1] arm: imx: imx8m: soc: Fix VPU fdt disable fixup
Thread-Index: AQHbFBtGZFJFDz9wlUyADDxuvuz5WrJ2Y0Pg
Date: Fri, 4 Oct 2024 10:12:12 +0000
Message-ID: <PAXPR04MB8459CAF96BF5A9AC4EEFA56288722@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241001160152.336121-1-ivitro@gmail.com>
In-Reply-To: <20241001160152.336121-1-ivitro@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9738:EE_
x-ms-office365-filtering-correlation-id: dd4acbf1-94b1-4236-ccac-08dce45d03a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uuK9FCiRrn2kBzE8LryzXnSD+FbPAD7nIK0QlfFyl8ktXVUeb7TA5Oo1Tsui?=
 =?us-ascii?Q?WuvtkbnNM85pNijDDvlHdQV0K3S3GCR5hgVIsBzeQBpsgDk5ULZ07XOEwVYS?=
 =?us-ascii?Q?oYAwfD/c29kmMDsYnib2M9kpffUQ81Ow0R9BdAPF2r04RvyC0QGyHHjzbA+x?=
 =?us-ascii?Q?N9fcEUQJjTfz4kXsHQCd+bFjg1QVOGfAvaHw/djfuKUFwup7A8LDNY+yh7aA?=
 =?us-ascii?Q?cW1kfeCDTXq6Xv1C+xkHdNWdJ6IFgd1KUelktrymk5Vg/txKUl5H5aEl9q2A?=
 =?us-ascii?Q?+x6xg+rv2dfQboP0E8OUca0C5/aYbbH+otFIVD1+cTIkhGaWxQ2IKdc8Mn1+?=
 =?us-ascii?Q?kSWsNGotj3o1Srtrsc/PuslBZDt/JnZ7rPkSFZelhK6s8rDT4AyGwpOmhkIx?=
 =?us-ascii?Q?z4x8lqunUqYMroAum3ytkAkPyxSXPgTl0jPHwgasJClL+qGCVk+UVMHFB0Dk?=
 =?us-ascii?Q?9Nt08AX284pKbVMi5XFyYS1Pv0WfRTv1/1e9hqdys4U6sOnIfS5W7nZIEmZG?=
 =?us-ascii?Q?spxQ6pak+fxyOD/2THib39qamohcMtJzeFYWOPGZFU6VOyT8uNWbLFDQ8yJk?=
 =?us-ascii?Q?R73WP90e9mOupVDcfPPS+48IV14LIKrA+yj9hbvNXWvEeIwJ4qHYjC0cQrdg?=
 =?us-ascii?Q?wyNk1xSorb/VI2ywCXoB9CtBU7AGCvDra6TVB9KMfcnFDhbge0XU2huuV5Tj?=
 =?us-ascii?Q?orCeN7E/mozF+1fja15N4hn4M/zC+XJcA+zygsGJSvhckdaNrjperC310Fs8?=
 =?us-ascii?Q?DtVK4qQMTas4MJeR3TIGOY6edecT7IoUGgzJzVy7iI0hIs+SAcQcVJ68ZXtV?=
 =?us-ascii?Q?lTZxjE1FzS7R77TrTi0GhZWZuDizT/O99nAeKh60LCl5X2C3kleRwy2R2COX?=
 =?us-ascii?Q?Pkc+qLx6TcAEBpmbdETrQ9QW1or/GMlXIHVjooNCLH4JvcScrH7XPTgGFohC?=
 =?us-ascii?Q?tA4UPQU08lrVYYIVLFnzb7zFFETAlsjckHANjewIMZ0lpaOz2frdywct15f5?=
 =?us-ascii?Q?KyHGrGA+x2/Ctl09ciW5JOqKaANKlDJymjCoBxYnBtjtg02jSDTKnz4bJqyf?=
 =?us-ascii?Q?yU4R6EPpiaqrxd9d2odMdeep4rGWjALnde8sVDjtV+IJm40wYtx+x0MDI/lI?=
 =?us-ascii?Q?v3wkydN6obRl5um1zFsXbYU9d3MIUoceE2+5fMQigPq0oEtKBm97Pgarcn6L?=
 =?us-ascii?Q?mJ+aubRntV+ZBQg3nmoc41XqhWmV0LUgFF79AsQsJXNsIKgIZ+9BjDvJcBf/?=
 =?us-ascii?Q?kSdDmQoYHwTcKCRAnaxJOZ/lzGprFZZjSbU2BR5zkT+hgeTrRwVi6YVnZVw8?=
 =?us-ascii?Q?/V8dN4UZKTxLtTws2aBtczH4Xcnh+pOyl1J2JqI2Mxyj9g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c5dR7DMqHPf7ZnXde9NS03KzMVw/j7RB+w6tUZUFB01rAe0uysxqaTHD/AqY?=
 =?us-ascii?Q?4OtBo+nTA3/Hhlw7Px+QotHBOB/mYGYq6iqNEdKFrhkBny2cp/V+SvDbdFMP?=
 =?us-ascii?Q?7Bll7Fut4kXd7oQX5/WiS0DmJa9rrqyD1QRIno0a4pydOaxGNoi1LlaDk+Mr?=
 =?us-ascii?Q?kAPGpbZKCnOJLeQb8iJoXGiMCXM5Py+MfuZsa4QfydkgBRwQkRv+rldlya25?=
 =?us-ascii?Q?f5KbdmCzdBkTdq45+mnEx3O2LEHQlTIvqx2VnIzzAjWQFxmXurLn/EQ5mwrS?=
 =?us-ascii?Q?+KLGBdH1X0uXhuc445T+zZ0w9/7mkix5JwIyoTQdu9H3K0c0+Q+LnmuQHZXP?=
 =?us-ascii?Q?Dr6Hk1YYZIMLNZ38KAORSK6jYMa/81jw0RA4RPcZS/t3OqR6kFCt70Pg48iN?=
 =?us-ascii?Q?TsywxNsZ6wUAJ3Fhr1Obaa35YjKt81PZk61Qs5SlQydPv1cw6mYZzjWwcrZj?=
 =?us-ascii?Q?JHqEwFR9I7hzHiye+Cogke6RBf35JNtyeyqQQCXE08Gxdb4s4EcYROHiLG9V?=
 =?us-ascii?Q?wzDGGOeLEPOcGIFxV8E5Pkl2wUzRhK0m4lQssUif0KxbxUy7pgaBppfyag3o?=
 =?us-ascii?Q?3aJZ8K45fFJlIe56U6HoAeri142aIfgIbHH7jq9JSqFby1yrm0hwRWcaXo/x?=
 =?us-ascii?Q?vlw6gqoYEYB9ygMxbvbU9PO5PJjAiH9Wn7AF4XwWG2ic9p95/CHomNwbLqQV?=
 =?us-ascii?Q?y3aSQbGj3VJ5OlCMDX4aDDULraG7h3LAXZx7Ub10cNL5BGej6ONrwS+raqi9?=
 =?us-ascii?Q?LfodS1l9RwErkXUuQtorApL3LIoLSreVzi+EbI2O4OpUtZ/PB6PzicKBfQfK?=
 =?us-ascii?Q?stTIaATTBFEoB4ODxsPWIWg560pEz2ZzbG5oyGW3Amplozt/J0UQkTywz8RT?=
 =?us-ascii?Q?6InzOc/1tpI++YwVOMT2P4bc0L64r9QCYuCzn+naCrNnE9BUBg6SrABfuk/U?=
 =?us-ascii?Q?TLRWodA6TBeseWNOTbcDW36wOfUhwj1kyU8sNULM3IIuL5CN6HTcegyyVJh+?=
 =?us-ascii?Q?WzCNaZmc0kG486Hgfb+3MQQhEBoRJyOv897iNS9mH20rq85wuGQRYbOptula?=
 =?us-ascii?Q?YtdSLLTUy/dv3EQMkac3+shw5HC3Jsmade1lMnsz/uA+Y+nS1+A2iHDWk0mc?=
 =?us-ascii?Q?aL9n1mRnoDYWZMYStN0+2hHcIoYjzJYb12PydS/wlcSZChULf6efle8dsnJZ?=
 =?us-ascii?Q?JA23uUac2EbulkTu3SR8Zc/Khl0/JNr23GagDIKfTLncqEiznNw3VWEAYstn?=
 =?us-ascii?Q?haZgGlWbe+7Pl2NQf/NaHn2sox4M0CiiIIxB6pEvL+7b++ehUeKFsvE6tAt0?=
 =?us-ascii?Q?uyCkhevZLsziCvanx5xHVXd0unocFj190ymfU/U1qJsL0e642ZrGph4NtMzS?=
 =?us-ascii?Q?/qa3hknK/OQYrb84dfVm8lUe0Yxg2Ol7je56FkIKNFK65MGzB0Ar6tJXhjyL?=
 =?us-ascii?Q?T4mvcWviiwFom5aUBKwvvG+tccuEvBYgUpzsHe/D4lqiDBB22W0+/PoihbhB?=
 =?us-ascii?Q?TNUwJsO4eU+X9BeE3/I6pSZ9IBmE8WV7thG4d6aE120rSqTPu05surQyOfiH?=
 =?us-ascii?Q?zS2TX4BW3KzXctDVMvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4acbf1-94b1-4236-ccac-08dce45d03a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:12:12.3916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIIbFMC5IseTwPNJVgA+chnxDafuhUeoM2DNXuZxQa/srQBRj+lA0gUB8Mqdeejk9MwvP6PV5MZjhp9pG0SkDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738
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

> Subject: [PATCH v1] arm: imx: imx8m: soc: Fix VPU fdt disable fixup
>=20
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> With the introduction of downstream Linux 6.6, the iMX8MP VPU
> block control node in DTS was renamed "blk-ctl@38330000" and will
> not match the ones found in `node_path_imx8mp` resulting in the
> node not being disabled on the VPU-less variants.
>=20
> Add an extra node_path entry for imx8mp VPU block control that
> match with downstream Linux.
>=20
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

I am thinking to make ocotp as access controller, then we no need
such code in uboot in future.

Thanks,
Peng.
