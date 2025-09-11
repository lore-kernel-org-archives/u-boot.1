Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0261CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 06:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C613683236;
	Thu, 11 Sep 2025 08:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Jt/SXaP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF968323A; Thu, 11 Sep 2025 08:22:39 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B218319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZBcTypJEAyZyPc9udfojMfDtAtOeu9owqUkrujLHgtY3CK2tEcRTePzO4/kl4y8c3ca5EwdZ/v/zqPIc/7uxgxSmry5PJGg0rBVBCjKVoxlmwfl88c0I05ILz3UWj38VRZsxmFdrr9XRTlRB9/mT8jqC53JD2NJ0YDJb4V6Iyg6uEwIqTjREdboxGMu8NajFoiRpaJkuJKJ7mtrPTv6OOUMzNoK0pRqQHua6jwRx1+zKvc1wZHlHsy1lqlOvjcEbVjMrCfOE3ayoTXuGLQzLUbljP3KAmoHzT5qwYA2n4N5xlNv/JEjel3qECpPLYUv52caBg3TrbUntj+MMNH7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG1YehlS99TPlHa5aSog3LFZY4MVhOyJYVVWfk+lwKA=;
 b=DzcUwOO/x+ZhPye8tkglWEBwpvaubxcqCI/ZK8nbX0KIRQh/XRVZS13H1ldd9ro606/aPflB8dme4mnBtDBWjJGvPkNk3Cz1fFl5b5JdrPUQMQk/u2Go9/+zvSm/iMOSY8KvJmOD1LTnuweT3U7rd8el/tJNLsVZwyVKVCeWVODHjzt3rR7QxViLOpZStx6pbY6huDLGnT2JsVMOWcebNeoudME5M/YV9K7tWKBM9Ws9NdPRBg9MlYZDkeNoruOBIvYPpNfrSUmIJycsl04n0MHzMA+WWq9mBz9Z+kWPkWPgOev225JpbgD0l/o6dWD33QTwPTavf5yY1eXf0bQc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG1YehlS99TPlHa5aSog3LFZY4MVhOyJYVVWfk+lwKA=;
 b=Jt/SXaP4o/guiBw3MEDtPQOgnNRH0z/bIiOBiwh+0O9SccXX4ZEX7u6Kh1e8sBfIwfGtSgWwwo3Kn+27T7EAIRQDM5LnGJtZBYl1ThEdfIhm3afGPCUyUp97MSeMjUY8b0os6WvoD/t6xjompTel4RdHEvanUvNLRqGR05FQvsFFbAG0anTDFOHirTtXsUdh4hxztpM44RucpVpqlOIfdpB/luFF+P8KayxrJQsHKMR8L0vwXcG5gnlOcxWwBDdl6BWa4c34kNjiR7ZkOLh/36TpObpLvY0V2vzeJEYe2NhoZWRI6J5vVN+m+NEzEkABeXknw971EAIfCr8s+Rc1MQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:22:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 06:22:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "alif.zakuan.yuslaimi@altera.com" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Topic: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Index: AQHcIS9KiDutcZuzoUynLJe7gweWMrSNhe/A
Date: Thu, 11 Sep 2025 06:22:33 +0000
Message-ID: <PAXPR04MB84591699BEC41960D222BB6D8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10134:EE_
x-ms-office365-filtering-correlation-id: cb0ae83f-3f05-47e1-0035-08ddf0fb9845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?s/q7yKlwhir5XzjXbFyy22WeHm1O2FCXWl4O9ywmqij7qkLrHlTqq5nbHDsw?=
 =?us-ascii?Q?xqt8G+A2m9oBVrHo6c6jbNNiFcRoscs0CiZW1gLZmI/DFQzMktjMr2GphL0J?=
 =?us-ascii?Q?9t1QERjAy79230cdNrVxOtEOt42A1V2i4QeSFIfVvp0mXfmeK4vTbfSTAMMq?=
 =?us-ascii?Q?ABbqjRz5cXA/jphbKsk9Zw59FRFSnJm99Nx5L7Z2PXYeOvZa9yldBR3h0Sry?=
 =?us-ascii?Q?VxG/YsIi8gvZFBnS1FRdkciOfMQYhHwOzQ9zYfAoL3eVHbOdD8MLeP9Rak5p?=
 =?us-ascii?Q?gpzaVJ6vkTZwVDYqiq/7dnDym8BKf7aZIUQzNRYt5hMqAa3p3n7X1v7oIfBP?=
 =?us-ascii?Q?gY0kwiGErY8A9HglfjtAaPpAUDI9mYrke+im9CFRyAm72HHiFj+ktZ4m8/nV?=
 =?us-ascii?Q?P0auiQhW6dM1/3CoT8pUsE3unzDUHN0VvSyRQX73RgRJbv28xhpWGGglBBhc?=
 =?us-ascii?Q?+CXJ9gpsgS/+jrlx/14zu2SSx4O/LRhSEfy/1O+cqN0ZqrrEFdjDnpn3CcbA?=
 =?us-ascii?Q?7qckLRbJXjxEIpYixm5uJ0OIII2pzXh8v5/OUu10wwcTGr8OlJ3pMR+jL6l9?=
 =?us-ascii?Q?WQ2fMYke1OtulEKvpRvZJQQFyLHZTDWmJlRxGDaopAtf/sZY+qZ07Z6ZKPP/?=
 =?us-ascii?Q?x+pW1EyGmCh5HoD1oJ9WVq0OZP8FHQSjEborMnyF/fM0qlWbjNk41d0Hfsfg?=
 =?us-ascii?Q?Ppd0nd6i30pFdnyiXdMA1th0tvy3FqL/Lbo4/DXoMORd63DroH9+dgj2WG9F?=
 =?us-ascii?Q?5p3Qtkwlc9nTmuSjzu5cJ0m0vzl/UJxIVH4P9k89hpbnKxY3G6ahdNRHuAyo?=
 =?us-ascii?Q?OGQBAkbQLQgQHqa+ae6ZW9BGVutQywdE/4lrkhqI62XCjBlNXMovBi+nF+3k?=
 =?us-ascii?Q?7R3vohv9u/+UOT/709Z8vLcfKlcRPvbOjDE48bAhsrmtLUKosNR179kxnRiB?=
 =?us-ascii?Q?ELEC6zINW9SR+iwzn+oUzKI1EYhmwsojBtWS3XQ05mlEGdzKmFxnJ+9uXylw?=
 =?us-ascii?Q?b3ZnAPq8Hco4G9o3oXS9fmPYh+MfLAf65G3meTihejthSGtMzxCnDIPvVXla?=
 =?us-ascii?Q?QLz3+5iSjIR18JO4+Brwv+mvr27XMFEl8GCfPiPw0DjqllttJSNorEJScaP4?=
 =?us-ascii?Q?Jh+sYxCkh7ZhEHI4QiSbiTpyKRcDx4ezza6oLzx6W+FErbQT5vc1hVSHZuNm?=
 =?us-ascii?Q?M2WIcMFEWlvTXSYlSbfNBXAbzoapms+DNTm6EC00vhQlrJv/6OOp68ODUEye?=
 =?us-ascii?Q?524UUf4viXidv+R78VulN77890Vf09708Azh3EcpGdbxVR2p5YuJuao9Qhki?=
 =?us-ascii?Q?0dy2YWh0zvpurAtnDNQTG2AX+bgxugZAzCkUM+12JSyv5xAP/fG8f0eB1vX6?=
 =?us-ascii?Q?oRjLtioVPDBc4y6PJVOXIC1YCMTR4NS/NDGKPpawVvkJaizIu41BGQcHqHni?=
 =?us-ascii?Q?6achp1TINTWCtAxjt3R8mwqdhCBosYYjgXRIoZUkFs9km2SZ3KTo7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4nElxwGYgju12kl5uf8qAlfTJXTHtlaegycQioKKRmv9UBZi2Sgp+0iry2uV?=
 =?us-ascii?Q?ghZpaTY9boQjojY3TWGZkwKSgP3cYR6HtsMxgShxbM4gbuAdWS1qjlVqcLYU?=
 =?us-ascii?Q?wUxKohuS6g8stTAycouaptodaLhE3VwcD2wBdbSHv2SHEtl+KZ7l2D3gJKrb?=
 =?us-ascii?Q?b41HIzM9HUGdvypaOHQsUUNwXOUdue96tyHJV53A07AdYK1qTuY9HiMmcIHO?=
 =?us-ascii?Q?i+EvW0toXkA1tUQMxaz9IrkDk+NeDGxYxjcQqcUIvWculpxTcMpaMAzWzTcO?=
 =?us-ascii?Q?OY0YeAuFnyUMoihwlcixgQEL/Bij2EoHOqQYT5BPATlooaRbvRri6ZKsx6JS?=
 =?us-ascii?Q?nErf7kLofMG0yHZT3wjp7tS2vlZo0h6pcA13cD+pH+964b8chlM4f0rBhjIJ?=
 =?us-ascii?Q?EmJ5kBbMg0U84BK+5ONKn7/uFMZQxV2eaGyHsBnB2+yi4xKXajrnaxAVoAbF?=
 =?us-ascii?Q?4NQlLEefDa36jePdcDDn9Bh8qYkPq7Jajq8SyPCLDmdNf1eMTN9HSJP4ugKl?=
 =?us-ascii?Q?h6DdwyZjk5U102YiU+LDjf+HxaIxp2QIbpIfK7WT282f71/AG5gPR4zhkDxP?=
 =?us-ascii?Q?acxqZ8NKThgLCGnor8SawL5ohMHHPMpb+dxFo+ahaFukNOw6xuHKY+fBqw4W?=
 =?us-ascii?Q?n7rkkCdcSFW4pclUajY9brrT1bMuc38FUWAmtdF2eFwHnmRUUiA8q7OhGdfv?=
 =?us-ascii?Q?GcysH0csz3GctPVAKooUN7rWPcpRsMDgAME4UdJcs/TvW5yQWdrraMJWO9M4?=
 =?us-ascii?Q?fJTDaRNs3qs6VtwL20tpYeRxrF/jQrCFKutf9pbOAswODgL2h7eyCnVHNiuq?=
 =?us-ascii?Q?1PcltSVVnLVX3kZ+RULORT+5Bv3KVhoEfrZiOdp16flJ4+1rOp1CjzcKEbp7?=
 =?us-ascii?Q?Zp+I0d5Ml9PPL2rCjnB74IK3W70PUr3+ZDUpgO7jUkxEUStbOXZUVtrgcdMS?=
 =?us-ascii?Q?y77iPLXt9nP/qAN59b7Hi27ewVNd+fuEO8g1nJSyvpg6QQfEhxW2lrat4XuX?=
 =?us-ascii?Q?/yEhVBdvGWQCss3+wPWO7TaCOgUDC8TH1dbdk23GFNk2ZGCtB70SLgPOyPtD?=
 =?us-ascii?Q?y52xtZvOC1S2ZWQrY8XGAwAbbSjleUjEpxVEAHLsmdn0Rhy97/OY5Kt0eV25?=
 =?us-ascii?Q?h3+JdsYilIWyfGeXTpJVUdY7wByajYYJu1Li1qZFDbkBMK0HCORUi5UTw9+/?=
 =?us-ascii?Q?vsHz1BCyGzO8UxV/m8osZekrlSyZFNXrm2btW0QsaJW3sseNS2IUwRC1guJq?=
 =?us-ascii?Q?8gc1kMQDEamqg5aX1gVNRR37c9+ubPMcSrFLxMMyP6qQh7UKHijM+dMiui3F?=
 =?us-ascii?Q?67WDyDMBPlhk/cA1Suc6Lco6+E3udh85iyoc9CkhxqD5/lMDilUjRx9Bn4r9?=
 =?us-ascii?Q?y8fN8D1pFLO8fRHNE42mXBLP9t/1qVS3nApYcYYKgf+AiZa5gjR5T76yTsRk?=
 =?us-ascii?Q?kqncyyyyTl8LxCLk8XphLG+m/peM4dyWE0yqZlfUxygRnftXIKKxm4/Y5HtD?=
 =?us-ascii?Q?ZF1UMNgbsCE1LUhm66A1u7LTtM04Oea3oLQLMIl55afp/fmF4aBu81BN29cf?=
 =?us-ascii?Q?rJVGywwUBr3h6xOipIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ae83f-3f05-47e1-0035-08ddf0fb9845
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:22:33.7964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euClwGvTzvTuF8f7t0WOgf383q205wAwCcZ2A8RCIttHybjBsNeGqrF6dR/zcjLrWzTbn4MqvC1LzeDDxqdnxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134
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

> Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
> clock definitions header file
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Introduce header file to define the clock indexes for the Agilex platform=
.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  include/dt-bindings/clock/agilex-clock.h | 71

This not landed into linux kernel?

Regards
Peng
