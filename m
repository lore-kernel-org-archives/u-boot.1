Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB8C3ABB2
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 01:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA74833F5;
	Thu, 29 May 2025 03:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SZTg4hPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBC0833F9; Thu, 29 May 2025 03:29:37 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CE6833BF
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 03:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt1XA7h25vs4r9p0uXU33wPsthysEGIhcZV0f225ZlPmQM89le+2czVegq7lraO+MmXyWREp1QeU8jD+M2iWVnpbQxXNph6qDsJQ4nj7zcufN0+RfDbdf5L8k6DhleSyVMxibpukXvgHwotN95raLpKuvBBXNMt8+F+X2nrvrErLden3wALmsQU/fCOa/g0AhCbLySGOAJ6KpweVEL/cZMoVA2rGsq8kTB9CiyNSMYd7of8ygQc1O8udB/pc8LSXYcUx6LfcYKV3UjMHLF+6/jc0XSjbHIpQpquG9zbnld84AuEYCm5ZOZ4CBwPSGRAIyl4TTY+3Tg7VC4i/Sas55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc4h88S9TA1+clpWHq/Hi8QXvIXDJZ2Ers+xclqjcII=;
 b=M5dxqKjfGhfYy/sUxzFjA5oMKlFfau2w35CeY3sKx1qghrpwExAaTm9ex5fC6z6dK1T2NxJLvygjxv87Yeg5OVCWvlwyB3uqk37kIaodNRRbjYuFgZsPgwhpf3iF5deM6/5JhGq879MVlqSN8py460GrJa1kBi4bOtLNzGGFRp6eEIbay1bdD4hJIKK6FJH27OVNSasGqXrzzihN1gD4EJ6zacC8F/Hzm6qjEiES0MF6IcOPAx4X0bjwFBr/s1cZiGtA32HWzLdUijAYfvs6Qm5LU690VOEWKLy91q21nHtvb3WLf2h/uZ15BbL313/ChaRu1xMf3226r/EmCfW3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc4h88S9TA1+clpWHq/Hi8QXvIXDJZ2Ers+xclqjcII=;
 b=SZTg4hPXi8oOmNYyU4Mpo3LlK2dF8VVhqMI22YR9mw0vi4yi6p79ILun+7wGjSHiGx0vObtjlJczbJ0PoIe/pE3de/qpRDeg4BSscqOH4E9uC6uZvwU/IiLvPOf5thFBwFj/JFgkb/xqFB4T1xUBq6NXq7HcR0xxhtm6zin1QeoV/zFUE4E7zCqL/PZhWR4F6ssYRlVTjVFkvVeV61gDFkulRY2rWQolN17xIQv3kM/WUU+zxKDx//KIiRIEnl1RXQ0Ab7eBvde87eOQmFzv65xnzSfl1SwqWiVM2OXBfyxtkvnZ+vhO5zTe8xTFm4N6Osbdera8U4yWL9iVNnUB0g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 01:29:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 01:29:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heiko Thiery <heiko.thiery@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 7/7] nxp: Remove local arch/arm/dts/imx8mm-pinfunc.h
Thread-Topic: [PATCH 7/7] nxp: Remove local arch/arm/dts/imx8mm-pinfunc.h
Thread-Index: AQHb0CiX5R9RUEXTVkG8oVEK9Lj2v7Po0c8w
Date: Thu, 29 May 2025 01:29:30 +0000
Message-ID: <PAXPR04MB8459F6AA580702B0A33903138866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250528233050.3820722-1-trini@konsulko.com>
 <20250528233050.3820722-8-trini@konsulko.com>
In-Reply-To: <20250528233050.3820722-8-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB6959:EE_
x-ms-office365-filtering-correlation-id: 7ba393ce-9eb4-4c8e-4820-08dd9e504270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r5YJXchn0d/OYKw/NEe3KrZvVqdvQgma2Fkel4gKfm9I7NH+DS8OZHZwbdRx?=
 =?us-ascii?Q?I6D8LuN/++Uh1OFb1z6ozv1VwX126QqiZ+qtJXyXuNqoQ8Hn2mU6gthOpfMa?=
 =?us-ascii?Q?CvBh6T8lo4KL8Q9byw5AS+mPI+/+NA+MKcDCtyUMlIdB7/XExgk3ef2meTHc?=
 =?us-ascii?Q?J1oaleP1TJdedSEZlfpJKRxC0qkR/6BTbC4bB2wF0Z9Og2YF1GWmL5FAvtG6?=
 =?us-ascii?Q?ziYc4yfcoBaBrFXpVo5K9pnym59KQCn4qsl5fAySWzWX4ESlRkNdjG6x9Oh9?=
 =?us-ascii?Q?lugIKVhwHpNZ18augbhJKLKIredqSprMb//DJsxJTczu20CEknYsnG7FKpEl?=
 =?us-ascii?Q?5+bg63YjOLWYRDVGeHCpskDCBU6puVMr5G9nWwJ03RBI2hqsGWZCr/kNC6/t?=
 =?us-ascii?Q?5eGmYjlO952sv2rcHncuMNwOxrYxZCoHS4tRHavF1JSV6fm6YlqCf+AmUXA4?=
 =?us-ascii?Q?/kem5/MVmWeJBIvz6Bg/5UdHo7c/PcmoWg2oljBzPSLEmMGDPcfXjfAB3hN8?=
 =?us-ascii?Q?EE/GqoSlJZ/1c2wBFbwvjqgeBuFPsCtB0V/S/g6KD6d9Pzt1Ti/aqjhCcAec?=
 =?us-ascii?Q?99BmuTAZedYsVvIKiNjVVAKc9N1YGwNdNdDz0/LozHOb6rwmTuhU/dgh76Yg?=
 =?us-ascii?Q?ajo7ihRDHCsgkUm3Ll6yDaispYC8bWheH8hR36KydgYcjSKRfiIa3A3EXbHz?=
 =?us-ascii?Q?8xHGU5MZkKEaQRsEr11isgkRrK4RgGFTadN9MaJGxvVAEko5H1lQd5+0Eymv?=
 =?us-ascii?Q?qFII6FPfyWYzYDnJ/ox7ks/hUS133FKTPHKhLhDPKGSHcoZ0RkdoIvf6RE91?=
 =?us-ascii?Q?cW9/jFZGqOQEpjIgGFFYL657MrudZqTcEBHQU6WvTU/S4fCXPtpg2azc/PCV?=
 =?us-ascii?Q?kfePeY+3pwXvQ98qoV+svjKYVMy02slz5CWoxarHGDyfDe3Had8FQABU+O2s?=
 =?us-ascii?Q?sgjbKu9LSWFlw9PbIuV5HUGXeLhJ2Ps8u6FiKZfwVvmK6QS0xT/LWXTDryiE?=
 =?us-ascii?Q?cSxji8cmYkPxW1QhrU3n1obfYVqGKwQXmTLan8EF42OvFPmNIhTc5UEafpd7?=
 =?us-ascii?Q?Jq4F/ja/njBgpZ844joGTbpMMKVYqyWzPjgbWkYkDlvo1/lP0OgNyl3IaID5?=
 =?us-ascii?Q?53EOknuc53XYoTU9BFbRDHm1kD1C3KloV/qRtHuoPgi5w8Td31zddmLeZhRg?=
 =?us-ascii?Q?faPqMxiiOuxN8TXjLlbvbh9D52LxpUaabK+aA929yeOPhIdPveqjW7mEwQDT?=
 =?us-ascii?Q?S+xXGftqpZCmJjqGUnDVQm7jnm4zgaSBG4Uxx65EVOt2PnpgXzdAlmZzVhwW?=
 =?us-ascii?Q?smS7A9IfncFoqI6bOH9inJmqUzzalRVVgY5AdHuGUlGx0WtosAoPyWF6mCte?=
 =?us-ascii?Q?tkbG0UN5StUINxPybyknNXnhCA44eVkvDJN1UcGXCbmLKudp1voAWhVxd4FY?=
 =?us-ascii?Q?ogPna/B2iBa8UstE0gPWCkca7751MacjBErhTrxWqGSWy1KtqRku8K4sNM2E?=
 =?us-ascii?Q?O7mKEcwmG4MDojg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XUTjH4kK0ve1Nxyh6YnVh89dFj8p5eCW38l58kFmG0ZFrAeBD/MTitqk1jR4?=
 =?us-ascii?Q?k3sf5OQTANyiilsJhjh7RANyKA4GxfnKSnZh1JySRUqqqA4DY1gtkSCE9wzC?=
 =?us-ascii?Q?sijYaTmXejSEySplKNx+9c8S4n4TCgNtAC0JzdRup0z/SAIiBkMVd30zbiQL?=
 =?us-ascii?Q?bz6d6rGMA8ZUsS78PJBIupZ9XaK87wtuiFXyAeEzM6gad0/FhfTecob8HdfS?=
 =?us-ascii?Q?vd/0IPz9kmNLKNQSStsl7B21h7gfSrAXpH5odhYMuiLwII64mJA4qHQF6yzF?=
 =?us-ascii?Q?7kEJIiURJVKpmurMsDxFDAvpOTpUbGFUFNUMgfsxqHj2vl4jEAtmrKKjJeun?=
 =?us-ascii?Q?oOZYv4+lv9x4IkUJygsHZjlajbc5F502k45XPNjLdbiAyDdF0KPg6Hemzc6l?=
 =?us-ascii?Q?zzpmwnsfC/bMKl1RhKyuLLKPGLf92Ie8e+OBj+0Qp+cRrBTV1wp7S6MaMnIV?=
 =?us-ascii?Q?WP/W8XSF2tJbE1QNQbaM0zVA55Uh7fhrMVjMfUn6r7O+SrQxkLvLOFRjeUxn?=
 =?us-ascii?Q?3+MHbontkOgXR4FIs72QSv81XyifqLkOtPztiaX0b2eqUoucsfjA10LhSgqG?=
 =?us-ascii?Q?W0oIoBCHljKC3ZCilYgT7FLGNhc7Ne0f8JMFgca+I2c4Xn6Awef/O3INDAUg?=
 =?us-ascii?Q?OwBq0ZR+EK3ykYgrh9wlzlBYliQjqv97mxbN9d2EXH5eEDFE63F5u193bdNe?=
 =?us-ascii?Q?maSvwxZh13qARmQ/T/udoBAabtl2wK3C3GCKkP5/8tSJ7tMtTDNjKVGYmIyV?=
 =?us-ascii?Q?WT1nm5XjpFr6cByliSiwM3zCxQUqHsqMh+G7k2Re/KsCGq/7/MjcVF82vY36?=
 =?us-ascii?Q?YQ5TB89TesLyhShwklb947oUId0iAd12+7FdaDrfYbJgh2xC/8ive4Dw77Or?=
 =?us-ascii?Q?7X5OT5dVDC7XlD1Hh90DmSsfoVV67EoEX+vxBMF5gRU40j8oIcLy/y8Hd3gX?=
 =?us-ascii?Q?cIxDpF8XpSNmkUpH7fdsIPbhRBhsb7cAZo31BCyQN+iUrQ9khXKucFoosem7?=
 =?us-ascii?Q?/zFCuoaFLUZTxdkl9q9MaSMjFLQ3MZus7pdubykRGdNwWbLLYI0VNGhyw/XT?=
 =?us-ascii?Q?RrAasEwPhDjSsCi8sLz3iJsaBQBu0kaekEGPByultebJRklWgeapeMkLXm7g?=
 =?us-ascii?Q?/xejqDVn7I/dcv/0uMSCwCkI0iu1H827/KfVIXL9X1UK/kLsW5fvBfoJcNuJ?=
 =?us-ascii?Q?BPfW3Bm1NDWnt2W50l0rIj2PNue57n0BnMUesC73D0hMck28hUrsljv+/pfS?=
 =?us-ascii?Q?rtBLHivoOxi2lUoKE8pu2xArZD1PsEnz0IwA7uf2zCaU9Sbz/Q364EFhjIXx?=
 =?us-ascii?Q?MyIX/XCJ0TR7P2iuRnk9IsZJTq8p7KpfAuAcupU+biZf6DPFkoTYTUjVXM8/?=
 =?us-ascii?Q?K0cuRn3HD+UgnuLPVQBN1ajqhCrdeyPA9TaCGhimbGxHonOUoBt9H0SImE+N?=
 =?us-ascii?Q?yaF3jS2iXqgEkipZ4qbVD50/ZxlrKESiBp+6/SjGSE+jdIoYr0oCLY+LQDwV?=
 =?us-ascii?Q?2FlQgYegyL4r3RFD3FDoT9Dc8EYgFGu0pP9Yd3i3A9GmrkZATYusIP3JBM3x?=
 =?us-ascii?Q?JUv+Zz81gz/5Xt1oAV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba393ce-9eb4-4c8e-4820-08dd9e504270
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 01:29:30.5395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwdsOw0/g5qc8I0rNh2PkbE5pzIm78t6OELYBmACfvSJJmgJabitWocPrL4coc5NjPVG5ge1Q75MrBilmn/PKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
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

> Subject: [PATCH 7/7] nxp: Remove local arch/arm/dts/imx8mm-
> pinfunc.h
>=20
> We have this file in both arch/arm/dts and
> dts/upstream/src/arm64/freescale. This file is identical save for
> changes which have been made upstream.  Remove our local copy to
> get in
> sync with upstream now.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
