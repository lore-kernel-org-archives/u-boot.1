Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B12C2D0CD
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 01:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129FA82935;
	Fri, 16 May 2025 03:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JS2X2hy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD32B8294C; Fri, 16 May 2025 03:45:23 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3CA806D8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 03:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3mdLRLLTYoM77kprQuZdaiRF6JnMo+kUn/l2XguZ1JsipuqWfpZgdLieaYJs81/c78E4fqiHuL6mGJhGQSZnFpLxPvIOQ11fkl6oAmlAQtTUuwpFsVDal8gY4afpwusjX4ngn+knB0kpfYSwCd7biFGIY3lIiU9kL2Du56mjPhGJIhDvT7Syo4i3ghZpTtBQEV2fgqovLFsrCPL6bskkiEw9GAbksEXV23Q9NKp8rEdl3us0MyMgFCeT/0Q9SevJonExY4E3iT/FwJkKeC0ZT+Ii8Zfpg1md1YAkOcvd2q9dmyRBW/3HS4hwltPBjXCF9ipIRkPItbZyEZMt+wrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGg85323marWIPvwwfBrv4UkIy2JDDCcn0E1R077U9M=;
 b=wT7qEsvvvR8LqUQjVr6/wWvaUqh2ZCSL0fvNHRKds2MfoMWT0kXaobq9BJvnie3OiYX2+bBB/wAskThFaSURbdh8dNTkE7Ujis+2MQ9t+pjCEFUbQXhZ3VyPZujlz3d9AmB6U2kdfT8TOCojirtH1t/POHaaywqFWc5yN5tiwjHavqLKe5gcmBDK1vnBXmOr3JV5PJU+Ey9pexz9SeI+wtQsQxMj+nTVPYvW4B5vACrxLtRQSdvLJLMksQv46vqQ3xWajp0SX5F3GgTRlFK/EJbJw7dgQL3kwYiqy9l2y3aCyzkDIKENYvqv6eRD5iqt7eKf8/hBYXxrSP+AvpJhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGg85323marWIPvwwfBrv4UkIy2JDDCcn0E1R077U9M=;
 b=JS2X2hy4knoGPdBkdbRQSXg4CQolwKmynhxWZ6G2/CT8Fju007tfkm37S0Pd8fZ+bOnQoefDZkOWAFIt/psvVBKJNeiCuUWRKOD0lS+JTbyM91b7tErjYyEIbl+zCdU0dfBU6+W5YmyF1fd5qRRAwUthjA7U1dJT9vTu0Eavk8PEsbYHQoNwOOyY4CCbtHiOyl6I1OZ18OtF8NlTyiefUtzNk5RmNyD4BPTM0OPeHVO4EdqEbbcVImr+IhoyvyMbQ59yrTh6pBfPlMNiVQc1aO2eibA6P3XXFWqjZiKxkxuNxoLnBnMQI0HZAYPIjHP5yonNsoCNA09BLYM5K2akVg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8386.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 01:45:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 01:45:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>, 
 Fabio Estevam <festevam@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 2/2] arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
Thread-Topic: [PATCH v3 2/2] arm: imx: imx8m: soc: replace ifdef by
 IS_ENABLED()
Thread-Index: AQHbxatvl+6NTVDfjE2ONhdTaDYJarPUfN2Q
Date: Fri, 16 May 2025 01:45:19 +0000
Message-ID: <PAXPR04MB8459C962F51710515E4E14848893A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
 <20250515150955.926708-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250515150955.926708-2-dario.binacchi@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8386:EE_
x-ms-office365-filtering-correlation-id: fc1b3121-bec4-4e84-a2ce-08dd941b50d4
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0HXE4777iB7ZHGAYNY1++Rm6Ew4Q6nC/hNvbJycMI1dVUy/Uhygp54SOTm1D?=
 =?us-ascii?Q?9tTzUMys7XQIu5aatGSlH97ez9FSgGyRpSYa/1h72h6nMZYdj7VSPOYM9DS0?=
 =?us-ascii?Q?KbQaoOp8PEMG4Avh0uUvAP0SUMJK4HHF68E1Gt+vMHWT7m6iTNQUv83nB7Lp?=
 =?us-ascii?Q?7Sf/LNC3wvjItUyZ2PSxEaqdQj4xG8+SV7aQu+xgFJN8CzVAGxJ84oipPWku?=
 =?us-ascii?Q?kOBy4DV1QUSI/wK31tPQGGeEieUvKivntGWsK4p17cLw5kXh/RxouayXp6HM?=
 =?us-ascii?Q?5BkNniBJOFEwoGypyF1PpHRQ3Mb5KSyzWmNQmejqXCMuyHqyN1nyKspwO2GT?=
 =?us-ascii?Q?LpNidbc8N63Q1UhQhE3Hy0Lcaf/f4xlO1qYTsG006WoyT6jJFU7Vuy7Skkd2?=
 =?us-ascii?Q?r6ytzBqQ8335rkRhySSCrt2t+9CPcFWkTlDyu/xTzHjjIeSB9wkIzyyGDQWY?=
 =?us-ascii?Q?liZFnq1FBFg+XZLQOTnEkWxuycle/lDRvYXjwnCUJul6OKkYC1gN+Gd+Jh6K?=
 =?us-ascii?Q?ThuKIhqLJb+n3HOBjhKxTQMEhqWq27mROnqx8Hi8H+4LkESy+v6Tgj78f7B4?=
 =?us-ascii?Q?7891u+QeM1hJUSlbvf2cXp2djVxOd6xcvI8p+L9GQQorzAgtnY/4QTy5NgDC?=
 =?us-ascii?Q?Fz+YclUrz4CBPoXLQIYpJTTZWKFVkWw+bKMLRXAKsXxGmwrzEcPzIgvTBNtt?=
 =?us-ascii?Q?YYnW68xLQQJ99ARqxCOKImtzqBUe+ylZeSWEIJyJn2kn2YOAHXbWGQ4+5BKv?=
 =?us-ascii?Q?2S+ZFm9eF6HJ3+UKUO71pnAd8+GG+QsxditpJQV7qeaQDiCvcP606ciJVhQv?=
 =?us-ascii?Q?WUsdAx4zMNTD1WEGbUePon4E8gSOGx8qWh5lJeHj417g6cW5qJSPL/gkFV5L?=
 =?us-ascii?Q?skcVt10CWT0uX7PkwFYvnxiLWO+Q/+oYafqw329KNVjUUsABm6qDE6j2NxCd?=
 =?us-ascii?Q?2UaT/iGhnv7f8odTjQoZLtXZHPyFWcjBs9N+ziPJSdZDPEdvV6y9ywhID3IJ?=
 =?us-ascii?Q?Eah9OH7yq5YGeXBJcC4m/uZ9jyuloqY+4IYpY7jmQoqvlAAtXfckTWvlb9Nv?=
 =?us-ascii?Q?88eLExifeks7T6KlTPpx94vCBM5dizxtdz52euZI5xO/Cq4Qe1kVyeGDP379?=
 =?us-ascii?Q?KznLxn9gmH7ajN01CzHE5V839V5CzrnTC9BayWidEx5rdAwP9aTj3tCk0mI/?=
 =?us-ascii?Q?2ugLXxgEFk2FVZKAVlWWEgC+b6bcqdNtUOXEYfiZGEQZKF/l0Kcn2wAmktu/?=
 =?us-ascii?Q?B9cUKWcPC5Bffm6kT+kiE/OoAxpynIYa6UYplfvFQIWHLl4JCET0bxiE+MMO?=
 =?us-ascii?Q?/dHuhNUIt+UGg+m1OE10XpsdVBL7ucedbmbHA1HH2c3bPrYhXi9lcK86QRQN?=
 =?us-ascii?Q?iMq1bxK2AQlsG+SUq9OKyTIMVZ2QCEX2OSfhBiCv++QiU6OCcO+sj66/L8Xg?=
 =?us-ascii?Q?c+NG37ZE+/wOtKFLcSZHQRBa2yi45LTo7YZxswbc5oA9HB6rHoc1+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iCZRhIJ42Hrux2uNNwyNM681mGJIv8TvSQPohRRhN5sN/DSmeZlHt218XKzW?=
 =?us-ascii?Q?CEJOKY2JlzRyGGDgBMG9ZSI5VR/eKLw9qAE4/SL1mZ0PnzVMZym0zWABHxCt?=
 =?us-ascii?Q?kLKFVTs8qWOjEhCFO8vJmX98wCqC7sWELf1fYN9iDIx3X2O+YWb0nMf9uFL9?=
 =?us-ascii?Q?R2cWR0n9Y9WhDV7Em9pUyxitgJJiOzBX/AdZHwhC/vGcrPGUHH/CB175FOsN?=
 =?us-ascii?Q?F1vjDDSQq9PBsovE0POTQ30XiHbtNjMKZL2/zNgD+zwh5oNyj/12+LdD3Ni+?=
 =?us-ascii?Q?Ic9J8yzQ+3OrzNNeaYTijIHm1uXBp0+VS9jiy4sbd4wewRnmNCZ9REF5ZrL1?=
 =?us-ascii?Q?5EtnsDLZFofvSTs43L1AeAWKPsvfy/GI1MTWi17i2E33fXY05Gzk+BMpykzz?=
 =?us-ascii?Q?kMvvPQNqP8xzxAOrWFCK9cVtxKsqKh1qgUXWn8UyKJ6HOBWOp4qqqBE9WQvh?=
 =?us-ascii?Q?vjVlNDI4+xu/PwrZ5ZQpMC8qthhYnFP4OfRPP5opFy8VMJmqwFmPNexJaEF1?=
 =?us-ascii?Q?E/ZMiwQmCu6dPMgG9O6JvUsu+jnXYEh3KaGpfs8b93MuJhT7usa2cMWZfVKZ?=
 =?us-ascii?Q?zQPe33q6/qwW3qbsAeCSCCkSO4eurev/LsP9I3bPwxPEDSjhWfdklvQc/Ach?=
 =?us-ascii?Q?Ha4Ly/1LbPrxvEhQlgDUntDLSQePhb3dslBQJiC+LjsOEnCB3Ay04RsTcOzA?=
 =?us-ascii?Q?/v8GJgesErEH+MlwuzbX7+IufBhLWn2JYaH2bWfzvbBXDm/jKkHc5SHtjMep?=
 =?us-ascii?Q?jJgBwAMX0u3eY1fgpIIhNU3wtKzMgDO7OgSWZSkb0ea+067RAtm/3bW48Vpg?=
 =?us-ascii?Q?BZITqbzC3aK54lYO7p7TsVZFS0u2UZuh4Sp3xzWYnq0KvHjN+jxWYxShOSiQ?=
 =?us-ascii?Q?D/i7Rv4HFTSNqBHur+N27w+Wb32iU7iMaK7XbmFCpBbWomTE8MurQt3D0ceV?=
 =?us-ascii?Q?VR2E37UHHfjBfXZakxy5EDg98Cs/i8aITBxRFvIdFCen3p8eu0UZEceW0iNS?=
 =?us-ascii?Q?BkaDaKIG/DyBKgGrK5At5TNe4cj5fwBhIbUdjTQV3fwEDdq9l9EPLj3seNRR?=
 =?us-ascii?Q?kE5tcMYeE6v2xFd/tipYQKxTFp6Ks7qmZIyXM+O9qBYepa5dLmtWFI1oE4vi?=
 =?us-ascii?Q?e0ylLdTZVBuWFCAkTzcP7JCpo+x3gQbhenJHFtm5YGVVAuWIZBmN737vK+qJ?=
 =?us-ascii?Q?Oh33io0PMlvlXTD8+f0QJc1lVc1rKoAyZ0yCZLPm0UIgEC57Ft6nA7F5v1NF?=
 =?us-ascii?Q?btsGEmQglYna2sNOC28mseDKVOP+lf9gg9rWhUKoEMOaq4zTWjltDtTQc5zR?=
 =?us-ascii?Q?0CPmnqPVA31WT8IPif39iGmnLoWp5PJebWuwUAxsR2VPAJZY/APNxuDJFnfx?=
 =?us-ascii?Q?SdqR8F1Th5OTVdXDpKyTTq4cjHEXLvF5faVf6xibqf8T+W2wvj3ie+NHrtw2?=
 =?us-ascii?Q?Bp9z8W6+5itb3Vspc1Xd6r/P6ph1XuGj7rm/LhnJVE2bu383TcqJ2q+mruxE?=
 =?us-ascii?Q?I5I86HZboQ29vROVugyzIgmXcXuh+FAu8EtA/sbb4IZIC39x6bD8vwS5suf9?=
 =?us-ascii?Q?1hsRh8umnMct19uyp9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1b3121-bec4-4e84-a2ce-08dd941b50d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 01:45:19.7292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K82Dqzt4g0LYLR6PMnDA0Mcw9XHVpOaMMGrtXSajmdqg4CozTe5WfPIRM6NvRUbUhY5Q2P+9WcLm7v1RG61Z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8386
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

> Subject: [PATCH v3 2/2] arm: imx: imx8m: soc: replace ifdef by
> IS_ENABLED()
>=20
> Standardize on using the IS_ENABLED macro.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20

Reviewed-by: Peng Fan <peng.fan@nxp.com>
