Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAEECA1010
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 01:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F00834AD;
	Thu,  4 Sep 2025 03:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CM15kuXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F204834E5; Thu,  4 Sep 2025 03:57:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F304F833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 03:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhwZGfeyBvjdMvxBUugsCd2bcyV4107n2cpwX6QLFZHs22UD314pQEtzHoJSL6MKDzA0cBquybBOd48edEuJNg32C4FfIqjZ0jtczgNoUN7fJdk2uvp8tAPK/y0WDcEi/urHHO+hJi3mEUpbe82c79kB1WjF62FHnBUXRxWjnuJBC2mPU05ktb6zBLqtCSXPJaEHtLwpLxxB+u4B61KC988Q0LJpxRsp3Clrt251f0ixybixXedASASiNCEJikUEgHUdiibeZAufrvg3EbBufnwSDT9HPARMGocPCpO7Ic4z09pxCXLHJU4btITSns6KLL1BnSlWM46VsdsXkWEVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6BpUZpipIUBBPuol5bk2xHD6hbSKDXxOT+QJJzwUTo=;
 b=tN9mePL4+ezqOxjdMdhB8h/bofraazIF2ygAfSo0LZKrdV41au1vGdv27YNBBY8FOzxovOQmX+t7gs7A1F8hNLOMRDPRFGP6N1fN+Q4g/GuiCuwWV6U0z5I4/9ZYbDsSbixdMO0EiXmE+Gl4BUcGWDugKGZidAbg+d0A71As9uslOAztRLHCZ+4/PC0s0/c/CXbHK/pOZWfxvk/fsYc984jvk6aDsYjh4m+7Zfm3crvpS9VP5nt7Puu9WAmZPPpqWAXJLUEee5qHgy75YjDhLXKLcloAKT+eNUSgwCuk0s17SzjW3Cfv1B8V1vUdrHGzXA1LjeYwlsr6klzUKp/hEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6BpUZpipIUBBPuol5bk2xHD6hbSKDXxOT+QJJzwUTo=;
 b=CM15kuXzUnL0yzNdJDFaPh7Umwwgn4pgikHV+JGZNKer06T0A0x5wmf0tnHzggofvgaL6A03Ec6O77BU6oxfISMLSKxmMInmBRwCAA8B83L0aDxfAebwSvwW4diNTeiufWO2qhvEgo6kpdAvvSFrSXvhyULgXCRSiTlI7xygOdlYEGiLhhwTKQdAoydePIiH5IZhWEpjABxPgZzuH7P0kh7qklgVySopGS6buTS+PWPn5Wp0dfnxHt4lvKzqS+WNz7aiz/tAyCbTepT1n6d6kVV8cCAxlaJsB+8B1OznlBcrZCyi1JFJDx3nxzOBTnUgG397C9ZnqGxh6GnQfVbEAQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11381.eurprd04.prod.outlook.com (2603:10a6:102:4f0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 01:57:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 01:57:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Greg Malysa <malysagreg@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "philip.molloy@analog.com" <philip.molloy@analog.com>,
 "adsp-linux@analog.com" <adsp-linux@analog.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Ian Roberts <ian.roberts@timesys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Tom Rini <trini@konsulko.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
Subject: RE: [PATCH 2/2] mmc: adi_sdhci: Update headers
Thread-Topic: [PATCH 2/2] mmc: adi_sdhci: Update headers
Thread-Index: AQHcHSyPLrXk3yoRmkm1JljhZqDt5bSCQ+YQ
Date: Thu, 4 Sep 2025 01:57:05 +0000
Message-ID: <PAXPR04MB84594F71A06B116F194D6E8B8800A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250903234205.26787-1-malysagreg@gmail.com>
 <20250903234205.26787-3-malysagreg@gmail.com>
In-Reply-To: <20250903234205.26787-3-malysagreg@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB11381:EE_
x-ms-office365-filtering-correlation-id: 3acbb03f-2109-4651-42fd-08ddeb565960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YBvmfzITPAREyN/FeTArdqdTPqNFYkAqJMzfzXOH45fUuuICcPIvrgm+tYp1?=
 =?us-ascii?Q?C/zugp0UBXCcXavRTwL3GDPc+Y4jlB6On88n3HkL0lNvlPnvnsKanVXVl+uK?=
 =?us-ascii?Q?r3A8YDiWRM/7Nw2jmWZDhjjlzv6XtHzEELA41KhwEOsZ72uO++MNMXgYZnhe?=
 =?us-ascii?Q?YBGxpmqBojsDHdIvFyesl4TTxerWsTvVy7PIAVvKoGMWM4suB9wKgCb033Ap?=
 =?us-ascii?Q?TskABXjC/WuCd21hX21ogNbm9/i3Jn+nWWRFXp6xBnoH67Ri1R3WMIhWYJQd?=
 =?us-ascii?Q?3l3HijLmUSWQPXgTpXAn5xOswzPBVCctTq8TE6SfJyAiXCEfdOSnHjRPGBng?=
 =?us-ascii?Q?39V+pcbNrmuH0r4u5YSKSMGPEFyW2HoH5kTk0YOx8qGwzuc/t6KnaQpL7rO2?=
 =?us-ascii?Q?QvXxhpZw+Z6Lh6H5+TITbzlDs+YyE/VM84G9mVcefd1FWUDGJTguBS228Ila?=
 =?us-ascii?Q?BVyMI7mBkuJ4VoHQ6lH0HQJtlTWl+3CFhTC2+fwsv9E6txxsUpGYz/w/QJ6a?=
 =?us-ascii?Q?QwqsyCOlrB6sHvOwA6ps5WOjPX+am4HdAMKPJDhOeba02TR481acaozC5GkJ?=
 =?us-ascii?Q?XGhP1Prm48u4icnorEa7FwhdF9Kinj4HZSI22zo/1DFiveqDhN/hrtYJeVkP?=
 =?us-ascii?Q?ZwiFwHuyofPVKci1uFHpQXI1+h5xfTAyykAL4uYS7uuYZUVLsHSo34VZtN4s?=
 =?us-ascii?Q?Mlf/XwBUtgXMR7O7Y5UimQPOJJjq9cUc+P4YWMYhRk+Mt/FGMIGYMGCz7lr9?=
 =?us-ascii?Q?amp0TBfxB4V6/fuD03GskDNYxDFgVk6r+XNJjHVy1Vnx7z4xS3aeGUJd1sA9?=
 =?us-ascii?Q?lC26eejnfT0YBPHCh2u02jabDWAsGG2E7N1/Df2/ZRakcoNwYqBa9nGObDEN?=
 =?us-ascii?Q?jvA368OADW9m/zZxHEp0R/ZJbkFMjcu+aH/CMjwNIjhOeoQ81eloGLBToCDP?=
 =?us-ascii?Q?cjQxH7blCmwnOymuTSKMeHSOQ/BzIEUZgUHGbtPbiIdUntw3vwLDQ0VHOxfK?=
 =?us-ascii?Q?/oWTxWeTfB/RGKuNCYyPQ5rHOFYG2X6z7H3YrPnp7z3KtdT/wxx/yY5ciAF8?=
 =?us-ascii?Q?YZisRg/oMj7en/Z2ZPVIeU+LSo1dx6nRDNMQ07hDPBstMBkxdYLmETKDNZ2F?=
 =?us-ascii?Q?lDavqJ/zPlRf2sj13Bu8chDerUhNOHBka/KVJcbZp83uhHhs4UquRGYqsUpN?=
 =?us-ascii?Q?CN9hFR3MlFIm68jn9WBWSVBoAAuqNZFN19Cu/inEkIiaEUmJUaT+l794ngbI?=
 =?us-ascii?Q?0BDoz1QQlGRLb+Hap4qNLngAgx/9fvUPu5vroYZKcSnr9QcqAXjA3eH3kCgR?=
 =?us-ascii?Q?4fqu/pKk4eoPoUy6B+N76UMajtoUmu1LpK5MyPo4dxc+MMqIImUyDA76SgUh?=
 =?us-ascii?Q?iDGFnJgc11Mu976ju47PPJMGUqy7VA4szLmcRx+sqbLiMQ+xWE+XYY+cDSCz?=
 =?us-ascii?Q?YNkBcQe+RDzz4Ymt4tAcgv+xL+JRl5ok1lFvRr6vzRGnpOqnCrpxnA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gVyw0x7U5rxXDbmfz6x3vUDxHwmMeosz5HWt5+cw8xmFbTk6x9r57ntw0xG4?=
 =?us-ascii?Q?pvjSblgxQKydj5DnDRN3A/1hGu2QX3SS5AgYE6lf8S3F79BIpHjhMkJ+UXv0?=
 =?us-ascii?Q?k/nK6cdC+Q30aj+/o2nOFj4kyPLRBxNKawrliqy6tD8pJhszhGVBiaE/U9kO?=
 =?us-ascii?Q?0StO2Cj1C9iFjh9/MgrySJYjkNSPM+ZUFUulDdMxEt+sQWEmxuICyVY7HJb4?=
 =?us-ascii?Q?n9a+BLq/X1v4ixGrIxYV4vfRAgb390gKLRdug3+BEq5LOzUZvdoqfx5pspqu?=
 =?us-ascii?Q?kP4z6zQJyP1whfNkxkaxlBTxp7UG5NPaUMiDBIcWj6vsAS8Zbgzo9i+g17iQ?=
 =?us-ascii?Q?tDcZ02G69q3hj14AAGxRriWvcbrvjoCtVRzR2L81a/p8C360G0O0fkRydPDO?=
 =?us-ascii?Q?fW9LdDpvQjTqAQVRe+OO7lupUI6L0bPJc2t8boaNkHuLzLCftWMLO9bvCfiS?=
 =?us-ascii?Q?rWw4y77puq3qO9sGz5xZNCL0TM2cr7zmszwm4mgdeHe1K0iCwS1amIkQRg6o?=
 =?us-ascii?Q?FNqEfdx3YhM49cAh+soeDwqd8zTvqnEuFqRUODtPf12NqqyoGNwpAqsiouiO?=
 =?us-ascii?Q?2VSId1Yb3Po8SsUoi6NJOtPg9Pr35hGH+A8fpXAtDmu+UWgJamn8CtAozLEX?=
 =?us-ascii?Q?1SOXnzS1fFlnxC+uaNnxu+Zhljku1EP9Mr+pHB0PLK2MnrI3GNms5u6WbxgW?=
 =?us-ascii?Q?IrsdEG2idHvDhSBI3m5HZO45NhOW8b/YnVi7VdxLauNXWMF5TqCdebm1xDpI?=
 =?us-ascii?Q?UyCjnkukwa0Auz+HyOG/pFYCpFGCr4yHIlRyyYpLTuSgc4H/qMXiAFIcBEWT?=
 =?us-ascii?Q?suuU/Gu9CRcya827p0nNCT3ZgBUNo592aYqvWKTCjNnqYWZi/bSU9BNDujbw?=
 =?us-ascii?Q?hZ20LSLqI/bxmGIdMKQwiu1svUcRYqM1bnj0WFb4z6psLhshw2i517zkVmNP?=
 =?us-ascii?Q?+1d3KxOnExvgfIZjlkH0YLT3ml0S+lqpvM1IA+JV9b/4W66iu7lSHsUixSoO?=
 =?us-ascii?Q?s0VIw2IEKvRZ0nzJipGMjhjvufNklojsGZrAO+y2QdHbqdM5ZGBf0cIWD5kV?=
 =?us-ascii?Q?A+2wFC7BDQa63Ho/0HqUt/hTXV8abdzTeYBwcSCjGSKZqCXlQ2mzFlg/uGNs?=
 =?us-ascii?Q?/nKgeb614PSKTAaMGj5pD3A+iDSiiPINpMOID87DBGb09ZxsYectAQp+FFgh?=
 =?us-ascii?Q?bVjm2My9DjyrdRACstoa5LJqWh9r3krtCoguxY9Um+l3kENadWCI/Ba57C35?=
 =?us-ascii?Q?/Z0c2pb9hb+8ty6IxSsMbph9Casb1rupjBodJ43BZuUh2xi5K1VaIGgH4Kj2?=
 =?us-ascii?Q?kcST1cWJjPF+lfqMf9brfR1o+q6oxjh6g0fiQybMX2ZdGdOPsIt90m16SZJ4?=
 =?us-ascii?Q?4HAxPgZ2s3yo1RobtrO03Xid0oDTZcfw6SQeoQGBZ9Us+yTN5e+qZvLgNvj9?=
 =?us-ascii?Q?5TTy76cllEjC5B5HmJwNrVGKeP8F1aG6IHA7BxQQFJYWp3XM9R+qv6tisI6m?=
 =?us-ascii?Q?CDTUD5VsEZ7kjVPKMfV2Vvo8thJoUO43M1XDsh0FjR/Bhr3n79l+32tMPyzg?=
 =?us-ascii?Q?Ps5cXt8c5GLAYPHRZN4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acbb03f-2109-4651-42fd-08ddeb565960
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 01:57:05.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjJpwNQLoyJbKfm7PUiWl/zN8U9dpSxAIvXR920cf7XxkZoRNZX0GQkKfqrykTR/MWKueS0ENSu9OIeYtZa9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11381
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

> Subject: [PATCH 2/2] mmc: adi_sdhci: Update headers
>=20
> As part of the header dependency cleanup between 2025.07 and
> 2025.10, an implicit route to obtain SZ_128M from linux/sizes.h was
> removed. This adds an explicit reference to linux/sizes.h to fix build
> failures for this driver.
>=20
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> ---
>=20
>  drivers/mmc/adi_sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c index
> 65a22cefb71..f58897b5218 100644
> --- a/drivers/mmc/adi_sdhci.c
> +++ b/drivers/mmc/adi_sdhci.c
> @@ -15,6 +15,7 @@
>  #include <malloc.h>
>  #include <sdhci.h>
>  #include <asm/cache.h>
> +#include <linux/sizes.h>
>=20

Reviewed-by: Peng Fan <peng.fan@nxp.com>
