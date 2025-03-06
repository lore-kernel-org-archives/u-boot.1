Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FCDC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 10:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75A080E94;
	Thu,  6 Mar 2025 11:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kococonnector.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="XTlM5hdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE6A8122F; Thu,  6 Mar 2025 11:22:27 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FDCD80756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=kococonnector.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oliver.graute@kococonnector.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGWwJkCUfcAagtyhCYWYMxvy6cverRy0P09ZZahfBg0Y4009zjDVltOCUhBXM4vSd48y2rtO8DD4eubvadEj8hRvfGBD3XxaeyA6Hx/JNDCw12r5PHyhlgiJlwhen+45Afy3KHB2s7SZRlTIDSV7cnQodtrFIM1p6G1drezrL/yPfww3I3O0MYBJoxFFcFeQVY6dL3OOFY/pG0GwRydxuqovMYxN7/LnC3uAmcNM+8DW0ZqMaE2bMX88bbTtrOvYhm4goecTmpqHM1ZnYsAMS9YDUQusjAr1wLmY/285Q5a4RG151RcdBlf9ObjihrIu26rxM/yPTfivyRJdn6efJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78De/eAK1x/0R45H1bFueCPmHz1ymgUObhAVLW8bN3g=;
 b=crzk/QCkprplg+SDzOu5tYxOXf69qc1JwquMAih+agDLtqDL5HPBJs9Hh/LfEC5QEqQu/d0DJqmRsBICpXEjls0QevPQvR9FMqKOTWRexn2AXKh79Ws0vDrQPff1+Z/hosdZsVLmlm5fRWbtP2Au8OYenSoc4zcRC9DyPBySSrEXsF+DXfpYof5iD92k1lIbA3jyvdUph/BUYavUvj/OMiy6zUdqX20SU/DvKn9If6EBqIYOneUuhPkF+HT36xSfxxBa+ZSqCWXoWog4vAaPMhpi5AWF9Y3Bt8EEwXywx89d8BVPOQ7TYBadrSAvQ88DTkedFuqXI1Q2CEr9UFK4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78De/eAK1x/0R45H1bFueCPmHz1ymgUObhAVLW8bN3g=;
 b=XTlM5hdDF/zOa+lNX6Eb9Z0EatsR/RRKV1wWx6MjlOalvIk5dPsHBAeyPFpBtrhaUdWdpjPDRoyS6Rihadw4hz1Y7e/Jv1TW4R+9qx5+qPfgL5Gs7Czi2+tPzXpNhm1a0/5eNQNZT0FNWIdHAYad5hl6i2pprPZsw9AotaRg+XM=
Received: from AS8PR09MB6459.eurprd09.prod.outlook.com (2603:10a6:20b:5a6::14)
 by GV1PR09MB5956.eurprd09.prod.outlook.com (2603:10a6:150:8a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 10:22:10 +0000
Received: from AS8PR09MB6459.eurprd09.prod.outlook.com
 ([fe80::b21d:696c:59b2:f0fe]) by AS8PR09MB6459.eurprd09.prod.outlook.com
 ([fe80::b21d:696c:59b2:f0fe%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:22:10 +0000
From: Oliver Graute <oliver.graute@kococonnector.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
CC: Hendrik Donner <hd@os-cillation.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>, Michal
 Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Prasad Kummari
 <prasad.kummari@amd.com>
Subject: Re: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
Thread-Topic: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
Thread-Index: AQHbjf2fHmSGkZb1/UKJmRJ3CX0DFbNl5iMAgAAA8QA=
Date: Thu, 6 Mar 2025 10:22:10 +0000
Message-ID: <Z8l3LCYQLsZFoRt2@graute-macos>
References: <20250305183544.40525-1-hd@os-cillation.de>
 <20250305183544.40525-3-hd@os-cillation.de>
 <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
In-Reply-To: <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR09MB6459:EE_|GV1PR09MB5956:EE_
x-ms-office365-filtering-correlation-id: 77609442-8e8f-43d3-b9d3-08dd5c98c140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?djEOtOHXegbJO/PzvFwfd1I9TUm32+X0so7904S7w+7ritIFbQQnTyTq6/ja?=
 =?us-ascii?Q?65TKBFFzy6yNFuNjhbfGI4555ZjVCMeBp9/2Ha383GKmu9BdOXSPdshEUph7?=
 =?us-ascii?Q?/TQOAiggXBKqys1xeE9xFe5dP11NyZczrQnmA0OTGwZ+IFEQWrURVt30v83d?=
 =?us-ascii?Q?Yzh3VCtKqiRmEc/ZVdDAeKFBFUqzdTL1psFmk4y9RhPRce+8q1w75sCbWdRx?=
 =?us-ascii?Q?AKUL23dP+TMhggZDUaZJaScJoh/PuhkOxM6bpDs8gn4n5sEKdwtLWIWdkhKj?=
 =?us-ascii?Q?xqmHYxVrhD3I2aW/Uvc+PL65SVfQOqjqfNLpuTQ878Mf4vGMfVQcs86WwaeD?=
 =?us-ascii?Q?gP0eEqVnG0JKgDCCIXIV+XB+kR1Nf72J8e2XRYOuiPqv6Ytma/rpj7bDLgyd?=
 =?us-ascii?Q?/HgJO+aM+rX8PmQLLIdiZiKBDyHkDWJcGIZHYGw1LD9ZJwPV6GauwE4SHux6?=
 =?us-ascii?Q?kHA3oNMA2nJ9TbyHDRB6RodZpEODy7/rIy0WOAnlOshSAq51ObDsTqU36sbA?=
 =?us-ascii?Q?oBUUWJwHwCBeM0RAJtVWNnNF5fNItFffc7kC6LB6mqFwPhBdHQ5zrWKkVHa+?=
 =?us-ascii?Q?Ds9A8zJOdADBfyuDkepKm/GnD1nE/W89iyrpd04zwDnYeYpWo8qnPZU84z+F?=
 =?us-ascii?Q?XcJO5tHBuh/UZ0CaOldAJ/tNnTN3dBVMOid5c9MtdPKVCVLWwJkZts9c4pvj?=
 =?us-ascii?Q?CsveZ0sizU6vzz2UXmjoxjyhauOxwQOQbUWHU/ULRRKO9ykfBBf2yfDD7ht4?=
 =?us-ascii?Q?r7V/+kiXN7kWOOVmBiNAgcQiHj/pPFYipvqMaT94LBafObby56iGRpEnD/0M?=
 =?us-ascii?Q?WaGafPdyGdvlger97F+7LO9CoWqmKf4JqeqnLf2HB5qV/HmTgdVrafwlHvww?=
 =?us-ascii?Q?MRQJfcOcRpoOu+TacFPg35hSyqD9BMVdfDzCQVfUykGXijeCXS6vxOEirAVG?=
 =?us-ascii?Q?ILYVvIzmCFNjP+JvHdZAZQ/2xcGYVF6zEt0moAx+FenHVuZxJ2vRny6QSiHr?=
 =?us-ascii?Q?6Rplt46KKm6UgctCJmn9g4H0e702Qp8Zdu/f0Py5zGYL7gCtBKddpgrKjt4H?=
 =?us-ascii?Q?Y4XGzNJtK6SG3SMFVZ89lVzTHoVPqr8zMI9o0asIqTGmj9w3dKSDy8BLn11X?=
 =?us-ascii?Q?Iexeza0UtbJ7WNnO7G5+1CtKRfE5048ZjtGaGDm0zjl+h1Cx7bmScEDj8aqt?=
 =?us-ascii?Q?YPmRUKIlrVYex1OogS5+nhQQvzr015oB399kMpe2EgVjZI2B2qn2flr3EUil?=
 =?us-ascii?Q?PesjTLKR7zDakk4wWNhJbauKJzKoMV4O91qzWyX9mDttUaLxTy+EZtws5V6W?=
 =?us-ascii?Q?Qk0VgcIZiDo5Zt3z5m1B74cqcKkMoSx8b+p6tmeJSpWxLI/xp+lQYksD/R+A?=
 =?us-ascii?Q?7m71Z9VjWTtpSoskOLlRDtUboKF3X69KYUTgNpXW7FwI3zpisu5XFygPbgOq?=
 =?us-ascii?Q?LRMqOufyt1b2t1YAhXYvbNlIekQAR2GX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR09MB6459.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iw0jWo+lmksePzh5aQ4UxUHkZJZxQJA0gHQaDA5rC+kQGPRHrdwo6VvRiZM3?=
 =?us-ascii?Q?cc+cCtZ9RZkOPKh9mcS+DYRdUc3YeIxfWbMlrsKAaNFlle6aLba6VetfShM0?=
 =?us-ascii?Q?TqzHbRrJqbUFYYvHf92XFrm6TnrKwuZXfzbgS/zl5LpOCfi2ICKcaEJ6Xi9K?=
 =?us-ascii?Q?UPnbc002gqwE5IubBrcMtyB5DrgQ3K0aCgwRUFbgemXJmBLHDC9P0J/PiHwc?=
 =?us-ascii?Q?4/jACf7metI0byb1eMd/pQ4uSaXtw4tY0D/9WEjUJx5yhnPDJ+Qyo6mtoM4D?=
 =?us-ascii?Q?G2YJupJkaBMzJtFSAlZsYaKn9IkLWR5DkLeVthC1cUSEv+kViTq5K0BHn+ey?=
 =?us-ascii?Q?08b+gSrCRefnTRlTUekfTvkdQmiD0qqznBFaDHOSjkTAZMzlS+hfzwRjrxEG?=
 =?us-ascii?Q?sJfMBoheTC/LjM94TyDHNF0LAFD4HjQiAFPqYdv3NKJRNlxepoRWp5B9fpMv?=
 =?us-ascii?Q?sNYCRcs9s87HPKkeoaN4qcN/5TExM+smX98aEEg25gbaaps/GlSOBUn7iib0?=
 =?us-ascii?Q?cjL38WCQNniW3jQdnv7TmltMofCRWFv1TrLnAsBNPNftIG8hBAHgVbAsK4m+?=
 =?us-ascii?Q?THxLJp2wdzhRfMkAQ1yyihn1OltqqAHC5WPiAZsq4NqfFc8/WQM+i+mnIP15?=
 =?us-ascii?Q?6abi84IzwSeu6QDZMTz7+rccZAY/juAYPbDLHDC0yZjatF6OglUlnfdz5KYx?=
 =?us-ascii?Q?YgLm9GEZsM+HBw4c37qobaxzCPDIHS0NWxJRoGrqGHnjSZwzAPtU1ean+lZK?=
 =?us-ascii?Q?T8NLKH+qYu6Uyd6LxOgYRzRwRAIjYxfrEs9x3PM3rmByYBOADQhwZWXJMiPh?=
 =?us-ascii?Q?+cpV6dp2xfIyaAkthVUCs0cchD7FIV5JMgjg57kZbqSdTkIkXTHFTnRxyVBy?=
 =?us-ascii?Q?KvbxY3YDqxJ0Lbh7JqGHab3PdQ/u9LXG5TwsrO52vHAKShz93HnNLs0MK2oW?=
 =?us-ascii?Q?LvM7b/tk5XmJXE9DoFJMKMtiAqlpgVZKcFp4HOZQ3TTUWyCeWa18m7yZjKU4?=
 =?us-ascii?Q?zHQEa7a2rU0mkZHLrEqOmKEe3Ym8bINT7UQxHb5KnnHs20R+6kXGswWiisVn?=
 =?us-ascii?Q?bZIrz+vMNNaCHNQNs8eROv4kHDKGQXUitndrAQUCm0OhDi5W/oFV4b6kRXnF?=
 =?us-ascii?Q?FFPkKHRhXWsJEySTLBRc6xBlVztmxbdb8XDEbOIPEvRoMCC26JKd7Jaffcm0?=
 =?us-ascii?Q?/G60lqKHZy9uTznuHLAzQc32pI8clLv/p4ru+yvRBJBTrJKjeZn2fpwHp6hU?=
 =?us-ascii?Q?enkc0pKO8fXSJUByCbZll0u1ubBl/sR3iVDgBhUey2yhFSOkhZmVHgR0229i?=
 =?us-ascii?Q?jZh9AsE5AKRRO91Jt8wIPuk/7d8X7mm7QJ7OYDxLNrAG++T/eY8XauhV/BgR?=
 =?us-ascii?Q?vpeUT2XzhPV219SMtMKVeebgeB62GpgR3Q/k1Rv0YYmMTBqUv04Hx2fLYCD6?=
 =?us-ascii?Q?5zJdxXxiIMSXblzNPND0uhI9hPqvTFH9KswKijDX/WjXi2AyHdrwVQD95KSn?=
 =?us-ascii?Q?eh5KYiZqs03Zmk0VCHAVzMmQTjDWpqQgtXtyYYrumyC0Qo/Sk1SWFJNOHRnY?=
 =?us-ascii?Q?/QFLoAYc0Qv9xjOPWqmohkJSz7LB9iRqo31KURICtQnWW/7iDiFVCn3h3GNp?=
 =?us-ascii?Q?gPk4nxfy+1Y+PHm89tVHTcs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8F271A6EE08A84286D126564B784D1A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB6459.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77609442-8e8f-43d3-b9d3-08dd5c98c140
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:22:10.3346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2laDN2Lww9FlJNbrwBptpYTEhGT0UsFkvlHPWM7Ns97dtcVd8ZqQhUQxtwRN/07y+dEff/FJbts4pTDDLlcDLYZeOc5az+MucWzdmF+8WTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB5956
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

On 06/03/25, Quentin Schulz wrote:
> Hi Hendrik,
>=20
> On 3/5/25 7:35 PM, Hendrik Donner wrote:
> > [You don't often get email from hd@os-cillation.de. Learn why this is i=
mportant at https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > The CONFIG_*PL_BUILD defines are currently not defined when
> > preprocessing the dts files, leading to build problems with binman. Set
> > the defines based on the related CONFIG_*PL values.
> >=20
> > Tested-by: Oliver Graute <oliver.graute@kococonnector.com>

This is fine for me

Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
>=20
> Please have this person publicly answer they tested it instead of having =
it
> already in the v1 of the patch, too easy to impersonate someone and give =
a
> false sense of trust into a patch that may not actually have been tested.=
