Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62765CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 03:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF25848A9;
	Thu,  4 Jun 2026 05:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UDN4ZIv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1045848D1; Thu,  4 Jun 2026 05:42:18 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EA08467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 05:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox3cfkXecQXLLkWmisVkMqyNqr2/ZIH+Ip3ZrLPGzaB6OLmAIsk0G+Emimivx1icACASrSao9qCiY4mG1lRlYUnqrydGAcigTM76eHnTdvd1vwHLGPEGuBiYhP43FKPoKJKNZTEcWy7V0fNxJ9ZDwrGdQsz0THcQGvG9E+R1W8aEfjpjdocgHZdg8uE/QCbS33G9mRFR9ArWdzzUOafpi9zoq8YW5Y/2NA9kQE98B+XdzmPpvFj2X5OpCGOT37H+86sIdYparKxEcDdTJB9J1mm1SpYoTe4kGqwZQeeDJXNSP3F5zwMSwe6OJwjfeHsCuZ3//gArItQMMkvs/IoEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJq0Brm2/bUPDeIV+RLPeEe9Sz9DzF+ca1XMaxcUtNs=;
 b=bLoqFGISt+WUilSOQsbTriKAXFVOdqMebadBA5pS4JCXn5aon4zDzzCOdlvgEtflh6fxOebeGET+5qGismkPtLqaAJdlYNOuN5bprRgKMXi3Icb6uBRRwAnVyhDwX4PGkJPoX8whZ1o1O39yPARPFymMoKmeiZObRcoM5A4xb78l9SVIS3qaSCRygfMI2sfiYl6hKeIpIOneyRw+CzeiFgIptA/DK67mN3CDl5Hz5O93hgb/hqepeBowyCQajcsyGIssgIn4KQUpehplkOBzlbGRySkEengBVfGvHzDm0LEUkdSSdk6pwxzgsgKxsKutgCdUtO8PyrZhymJ+bOIJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJq0Brm2/bUPDeIV+RLPeEe9Sz9DzF+ca1XMaxcUtNs=;
 b=UDN4ZIv1794Jz+EQOCLV7td2F+TWVpEWXBz14dmYR557tYASIxEW8EPq2/u/GJF8Mb1/ISyOL3U5T9mc0KqHz9OSKnJd+ndIOiRehRQL7MAtGs0LCoIvdTNoD5VoBw1eMoSgqwmE6766AhXF4+EB2fsAPfzj8cbC3OvlBi47dF+6oR5efs/EQ4Kmr8mVC2QernQ8uX6K8XXf8ymBp1Te4ikESoA0LGLSY9dNaIuqLHnmXnHQmZWcKRaT9yK0T8SkvGowAfdsTIdO0OPyPvYv0ICtHEAU3V4SYtoPLb7HaQpCwXyi2Ps1C73HavQnZMrm33ZQRAfEidhK8rZbC3HJTg==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB10352.eurprd04.prod.outlook.com (2603:10a6:150:1c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 03:42:12 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 03:42:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>, "Ross, 
 Fedor" <fedor.ross@ifm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simona Toaca <simona.toaca@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] tools: imx8image: Fix FSPI alignment to 4 kiB
Thread-Topic: [PATCH] tools: imx8image: Fix FSPI alignment to 4 kiB
Thread-Index: AQHc86jrisesGFzHd0eXkzWqVUjINLYtwNFw
Date: Thu, 4 Jun 2026 03:42:11 +0000
Message-ID: <MRWPR04MB12330188FC25AE7399E31EC5E88102@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260603223245.137065-1-marex@nabladev.com>
In-Reply-To: <20260603223245.137065-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|GV1PR04MB10352:EE_
x-ms-office365-filtering-correlation-id: 3cbe03fe-be69-4c47-9614-08dec1eb4313
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|22082099003|18002099003|56012099006|6133799003|11063799006|38070700021;
x-microsoft-antispam-message-info: oZScSm8LAal8Lcbdj6RbiKS4b7JQ9OmIzr2Q7cxdPuKNQOgvj/g/m6vcGGY0lYPW+XVtjGNOMqDs/rqXKlrmhdin5Ddf70QMGntsxLnSJzH9x86xdddHQ2Dl1qqD2rMCa6AZCTV5+X8Y4P2793yeVHgO24VnqB6BLmY4AESrqhZb1nPdLVYXZxk6BW8itX/axqegw1YHIFt9dv+Z0Q7/tvZ7HC/+s7MbT03M/YIPenDQc/5Qjm/lC86lBgA/7ssWSobx2HPKOQCg/aTyUfGWg2lolXJO9GJmFQMyj4TbPtOMTRMijvG1XC84Bo3czR1QAqp87CE8joy5EHCi+YlZ+8NcTfQbKcDuHkv+iNgRA8lKwJKX/Z8XzxaG+Zsz7r/lt+CrWEAeQwW/g1W/wEfHvOEprXRcCCWqBb8aLACUIROWUailRL2GrpvS4qLjZxuNWRIkYgX8aohq6E7paZ4R4F1QxR279QrhYuKvgbr8QeKsIBIkibnQBOUzzY3xGGZdeFMNKI29mth+lUOsSpmY2TyjVoIoJ8tl9cbNZj7/bCOan1afbiEXz1/2NUlfYbMbEb/KLzblcJUJSq8avrcaC+n6XzZvsiIchhwr0TIj9e89fu+XXHjVactigE9/ZVgGpbEIPp4b2QxPQlxp1aZuoY6YnVF13i/abRTbwLIKc5/Ovu5r5jmdX8wwbiwv3YLHlJR5oIDuDOhIkemelPmgQ0vzAMh9h0QjALTb2s/smETE49+gDI8HKHKv76J1WUc7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+VERul43F3xXvo3INdM4uR8K5qEqBxYyjEIR61InGJRVj4DUUOT6FEj1sRq1?=
 =?us-ascii?Q?xdsMtCYoipMxT5HWVQYgym1r47HXjp/8HWM9Hs43L0bANgSDPHoiZvZNF+MB?=
 =?us-ascii?Q?46Ezflexgna62EqsMbcxBLI7AA7MP1HRbNyjQd80oo0K95Fj1vzCE7GhHnrZ?=
 =?us-ascii?Q?SrEDJfFfpCGl12iB8uxNCFvVxkACsxqnywxcQgG9tDVKdY5ViUKfe6+a9JsM?=
 =?us-ascii?Q?n1iMc6AzLcD3k45f0709SzcDs2nKIUK95Gt7EP5WmFZMJZSubOtmzm74vgnw?=
 =?us-ascii?Q?/d0O7WmJkjd2kT7CoRaD29ApDASr+RfdmA/1NYXkYkD9WwH+qLGjF+b9f96Q?=
 =?us-ascii?Q?pjgd7aNvohhQTCsgYLUU2m19bpuDRLk7DASHF7QePsT/0i74ZE4v408x958t?=
 =?us-ascii?Q?+f/QsQIHn4KqPyy3Y9B1Jnpv+3m2b9YZKoN3bKpWPDd6pGftEStIYvgWHWDS?=
 =?us-ascii?Q?SOe1hGArAPwOIYIz9m9Vg7Thlv4itGoaIEWoE/CyusiL66SXrAus6qA88Jaz?=
 =?us-ascii?Q?yPOYrqlXEzoHgVcxfs+gO5FwOkq5hidg312th4RX+XN5pqNFcHk2KHcoCjfv?=
 =?us-ascii?Q?IyfVB/dbq7Dotd7VtSL3EDCkyDeYd+wlqbO+Dx36yXOPMXvybrjkHBC+/URa?=
 =?us-ascii?Q?IPnLf2U1nYT12QqaSTQtoSENOTNxfPsbddwLWvbQuq/MUKCYmZ+sKDFHmGsP?=
 =?us-ascii?Q?b0uKfMadUgDJRy/epCUcCSw9xU5K7ND1ZxepDQd3xg4YZMN8Zbpd5alFzHwN?=
 =?us-ascii?Q?ZmISsJlkt7R6iuVWxHANMIhz8L2NcYhh0CuCl28XI4Lfi40IgkTzlIsjFzfy?=
 =?us-ascii?Q?dBYnuQYcOBwOsO097Z5qNV0cMDFZ+3bp3x4+lmf1JKJvEhoM78g7VSEa6TZj?=
 =?us-ascii?Q?CjxbMpj/dnWYoPr6RGyJX/fVsiiI4TFeXkEoQSf1+jlh9zc9a0khpcS9psbz?=
 =?us-ascii?Q?M/zkALiz+dVj9Pyb4ytn6+YJdL2wVDhQbeIBi3ORILansQqIc5EoameUbWj/?=
 =?us-ascii?Q?RZC3EhUySTNVJQ3mk5GMRYtKBGBp76qM/DlmyknSX5sw9tmGFBurfb2QTtBq?=
 =?us-ascii?Q?ZTI5Tv3jNCm/eVEWUzhYWRmQO8JpC76YOGlwJTalSsAbTy6SwOTT4C7igrfn?=
 =?us-ascii?Q?y4KECluSJ87BbIUtWG5Mjlt2llbHUw54gFWTH0peb1jIaapHHgNAd43Nw4Q+?=
 =?us-ascii?Q?Q9mqS8MFNed056HTaX+VWWjgEEAetMoxgPWb6i/a0Sdw0vr5WDibpfWiKaJ9?=
 =?us-ascii?Q?alhc6DdShj/+8l0uwFKIq8edOSrC+TO8o4TLjMO1P4tIkk+Af4QjRZdNQloh?=
 =?us-ascii?Q?CSejHInR0Ibn2IFh/def1YYylTsK9hHfUsEjgD7xaekvGGWEsb0lHJ7wVjjE?=
 =?us-ascii?Q?gT6FkE+f20xL0mDVGwYQy9bvRVayIt8de4QSe9C47Kdw1IH2R295Yk+tVzXC?=
 =?us-ascii?Q?J3LgZWkwzNFDtbF8yBn+tRKiRzceQkKCoBl0wEffuhJAaURliw2sisQe35TI?=
 =?us-ascii?Q?gaWkbhXY+b+gg++kj1OaFL1MzNEPs1MM2rZfYSy8Lw3qOgSVRYtoN1sja7Qt?=
 =?us-ascii?Q?Pohhi0uyoV+bfzTxOsvth708fZ64XI6Br8sFziNEqMuyjmnjQFLseBrAmaT1?=
 =?us-ascii?Q?nP71cWbXwTiF5RiqXCi5dUJoUdUm1S3X14R202LZYjZv1zKloxmU6H92Kdyk?=
 =?us-ascii?Q?SHEUSfyN7bnqpbDlkFA6K4Jpsjkax7c5iK102f+3M8zXIBlW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbe03fe-be69-4c47-9614-08dec1eb4313
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 03:42:11.9965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /q+M6ax8u50eGVJyTIM+ATLxmVXSb9ggjimy9IROVe+jc69qkn6ElMrymzq63Cc5q7rl+rcQySNTynhGDNOMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10352
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

> Subject: [PATCH] tools: imx8image: Fix FSPI alignment to 4 kiB
>=20
> The SPI NOR minimum subsector size is 4 kiB, update the alignment.
> THis is particularly important in case of embedded DUMMY_DDR,
> which must be at at least 4 kiB aligned offset.
>=20
> Fixes: a2b96ece5be1 ("tools: add i.MX8/8X image support")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
