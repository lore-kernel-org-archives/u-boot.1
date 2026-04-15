Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBEEF4199A
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594EB83B99;
	Wed, 15 Apr 2026 14:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QEwXiZZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C0F83C2B; Wed, 15 Apr 2026 14:17:18 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0ECD83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqJeYzl0aMiMQNJH04YdP4W2tBf5f8mPgPnKvMWHVMJfdDcnPZwRNDv+7PtRRJ5pa3+9vTM3nOu7QLiJv2QhOLB9N+bCZMXHgl8h/mf6r7FfPAMKFygxUYiqEzRWGkTxyHhODlN+c1Svt0Xfu9oO3zUmsv+qo6vsx8mkf/C/73PgXSb/CIiPNUq6roFkqiOf8VRFqNhzctHO66L9Y+/PUO+t073HDXLXKZJ++ZeJIP3OH+POyMW5Ebv2i0hQwOo6U6Sp/L2Bfi4oFPGLwRGC4keDv2RJrPjjp6V7I8AiHRKa/OEvaqPHlSFn/hK2XkQ3qN7GJHj+ZEUq1xzTdbN2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dskDuMFZ+NQBjTthN/2sngX0nfKqVwxk9sID8zNqxs=;
 b=yOSyQfgkF+y6wO8piwX9xPqddOq5LBnnouWqIHuw2fMn9XYRa7SD0Pge1RFTTdvRfpxcdecpsbjRtibX1eByiRpJHKopA1azOLOPAbZ4zasWRGIo8OQj3XwgDMIORusLRf/qlvrcMragEFGVkba8SE93o5rmRb2BiMsJ+9M/FJCHfGYqFOAQIhoBp0ufDjC7x/I+2WrQg2DsO/+ZHQVdyd+Omtxbfre6sMtiD82WpZGkRwYRwZ8nQhUI8vE+groX7ArjF/z0ySenAZbVCyiQzt0vT3bXE6TcCi8bYjU0NhpM2l6yIXL9kzUmF4HCSIhAujEHvmWvZb6noEqPx1wCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dskDuMFZ+NQBjTthN/2sngX0nfKqVwxk9sID8zNqxs=;
 b=QEwXiZZBciR5ZQDKU5lKeYg453gMjlL4zs3aNoTna7Rr2AMiK2AYE1jbC/09Rmo4PddoxcOPQ47b8B1/Kgf2nHFgOd/3zj7vS8LbekEQ04koBYPgzB2sFCEkJEm03iFNW1UG4RfZa2ruRt//jONLvCmFQPMthSwEtnEg1sloHag1ACRBf6dADTzJf/usbzJ7C4Hq/tlZhhHY5Y3owJZKMVko55HGf4civDSqVEjOYFmx6+tra4L2bAVDACbM6SguY4tLHoIZdY7vcRXF95crbcEV76uNRfTFr9IAY6pkWYxFlBgy2XUix7469CDorq1Rs3ribPw4ZS5dDhQiQY9Llg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA6PR04MB11808.eurprd04.prod.outlook.com (2603:10a6:102:523::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 12:17:09 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 12:17:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: RE: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
Thread-Topic: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
Thread-Index: AQHczM2S0cXvAU1Vl0Ga7ckAnHMIg7XgCVpQ
Date: Wed, 15 Apr 2026 12:17:09 +0000
Message-ID: <DB9PR04MB8461701ACC88F0AE7F5B89CE88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20260415114658.3321643-1-primoz.fiser@norik.com>
In-Reply-To: <20260415114658.3321643-1-primoz.fiser@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA6PR04MB11808:EE_
x-ms-office365-filtering-correlation-id: 4c114b59-5cbb-45c9-4fb6-08de9ae8ea82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: eFMI/ChKTtFGY7oTY5W6YKkUvy4Mhzk0eGpB/SDrIVgH/GQGnBy8KJKK6jjSTKdrfMNn8sL2AqEPXVMnRTljumKGqx2qW2tdE3HkzhSF1jqgX/KpDnO/qTBMK+IuYeOW3tdvBjSQJz483KbzYnED5qI0joHyYWWFT2o/ghg8K1NzixYOoap+Rn52gk8wU0nyI5WhiqGf/VuUiW/M0wsN7GVPCykwG7OgMzdAvjf4tByFUPmj6sbBY6jJhV06uSa00v1xTUDlvbI/oByfYg10fL/VBwJo4sCJWlqmf9XGuA2sR4vK+UV6E/G3Js0o8zMUyIcw+IsNQuKdmP3q9DtPBrMzRV19mHZxQX4jRMA0f0bTVrHj2HwSnWQeelh0VZi23Xv9cKwKedZSDIQhLrTPX8ceYKHrSbYWQ+z+XDj06dWBMXEcYaUxlaO39FJ5LitrGYU1c0aT4wu6GnAQD2DXvobpmdEWddKSbDbtelT7uyJhj4h1hViPcAFHJkKyjcTL7/vZtmEF4MOaB65W1dwE+FN3Nq1LhbrpJ3tOs0mPeZfbnwumrJDIQyEkN7sdDu17eyIOAWdVoevAlWnSdovTWwplvnFHoOq321h9r2iMXb53p5X7uIu6by4K6VNaaVt4BmhGZ1SdzxzY49oC5P+bh9Y0bwbeqaoDhZl6JcdeJ3u9VgvMWyOqOlI8tVVo9bFuJVf14U3hy7m+4OKBGJF5V4D0dTm52M4UOHoFJzd/Y3F+s4XW+72gQIvGTlAPjKpTSNEpVorfUrQ6IHKXkh9NpNwULhDMguCoSOOHQ648EV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RstJz930tpkr1ZZi2pLg4P+lMMDraszOI+sdN+Oir17wF2Um2bOEl0nP7Mn?=
 =?us-ascii?Q?H67DAJLjQeTIBXj1Oi+WDeZK2UGkNIwJQt5w3Ud1aJfX6DqSOnCpAAAdNv6Q?=
 =?us-ascii?Q?nldmngkbl41wqB27pIxNKMvaA1YCpxox34RkH9GD7pf+yrpxoJOiVJN3pSHW?=
 =?us-ascii?Q?dQa5Maja+VjTFX6iDBdehc/FKeSv2GS5fdxP6YnnJkyNW1f++6PXymiaAItL?=
 =?us-ascii?Q?Iqr3qdiG3gyPBPdXUW9coSBkdLWkJ6fQ2Rkdu9urZJn+3nSQHpSZsi5MZ6oJ?=
 =?us-ascii?Q?N7x705mwkbvkEILbdU7CEUD3tTBGj2ztUMzCqpA1SRAVWHg5NjDHF1TprMCz?=
 =?us-ascii?Q?3/QbK8onnnuWliVV/41gJmEt2DR50BhaWaa/WkZicXJpngqQdHSwZNBx96Jb?=
 =?us-ascii?Q?P45CtmXmWzgTiLaT6vHx6SOMPkL96ePqjRWNx/0a7W5iyq1FrkTV3w9pF5mB?=
 =?us-ascii?Q?E5BHrLYquCp2ujtMpO8qHYYXruuc/61Rz0dHFaC5pc6tltPhaalwL70uuEDu?=
 =?us-ascii?Q?JZyl6KGKDEehlp//bky40OOnwzhJj/MK02l27JsnHz80tRSjluWicjpyPfLD?=
 =?us-ascii?Q?NliqoQehEBHJe9B98ID24pg8ZkxLQcKAsi86LehOiU/XwDekch87ykmPLwK1?=
 =?us-ascii?Q?rcAPf2jMpt/9q848DQBaI/MpdgGtzfP5/fopmwSCkLVqqCQ2MgBkrxugDB0l?=
 =?us-ascii?Q?OzqA+axqne+ZhU3KeCgQn/4DV9CEah2+lHHTB6yYp5dNaBfMmaFDvBh+YIme?=
 =?us-ascii?Q?clFX7jDupnPtbx3gbzHTepEvcaHxIXtKrDVWktzHf43m0yQfluwSDPDz1pry?=
 =?us-ascii?Q?UxqDFxFn/5Ff7SVAzvVwGTBf6VxajnHYZHCD0TM0aQPSQjoNcHCSzsOSkWq2?=
 =?us-ascii?Q?yG15vGc6IbjHAxAUQ6gXtnTScwzcQxiC9VDIJLuo9qEP+1qj7N+4darzUZE6?=
 =?us-ascii?Q?3+QxMZ+o4ofhqqhS1DcBtjpllhXyAhZ18gPtID5MqnwvgRxehGXBo7xHRYJa?=
 =?us-ascii?Q?J9jT9C8LAOar6qwjer4AS6xy+at6U0v9BZTXKNnMROE4xkcj1o39EsjJABtB?=
 =?us-ascii?Q?eiZpJhll+jxzs4RjoCOm7mvlQrl7glYufNQ6zgNzqs+vtzzxKVXPr6x6OUjX?=
 =?us-ascii?Q?zv6jcdUks/U+C0AEdp2goUoNbTBQRbDx05XR16oSeN+NdZ8NPxfSp4GHwz+x?=
 =?us-ascii?Q?GpLR0AwRTfD1/0Dx+MkTQBwhLQDSoYzuqGvnvBqAQ3M/1ixBOQ5Sdb5+WpGA?=
 =?us-ascii?Q?iFMDvqDcpNUQGokruyHbYH+axCcu4YkY+fPUS42QMcFpqbi6ZKxLvU+5dJWA?=
 =?us-ascii?Q?87PqzVG8RlSo++0JA0Cdvol5BAsIJkgN6YW7fcoGg3Jk9pDWF9lUSuAp3DA5?=
 =?us-ascii?Q?oWm6HSBMu5cjowA2Uh/m9Ye9HIRmD1toy+M/p71aMEiYU7kPhp1PgUGZhPE/?=
 =?us-ascii?Q?MxVSEme/9vsYO4rqrOLZYBWN0VOVamfZVhlTy1xWN2MrjHve6HqVdudao10N?=
 =?us-ascii?Q?SMlnCB3J/dCLsWg6Wq+sQcNnGAqsLKt/koCHgL6Mo1JP8A1NNSIYALN2GMOs?=
 =?us-ascii?Q?BvY9/iXWBLe61xlHyG2IRz3vMTsqKrATG8RCu7snuUfSQy0ylM3GO+7imwjV?=
 =?us-ascii?Q?Ykh/e549aUK+8FbiG0Y9J4YfF0UftOQu+VDbXniS9lDUAVL+tAB9Xpd3n8Ai?=
 =?us-ascii?Q?X7qABToHWwubM0JJ+1jVeXfXdAAWU8ovDw/Gz7PhgdSi6W3+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c114b59-5cbb-45c9-4fb6-08de9ae8ea82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 12:17:09.0437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+9dqjYUKI4WDsNg8MaKmnMTOY3KcNEp+BEgKwpZ+1CLQKQRi81TloZA1aNsy/J0MOVgPPhJW89nWm1b4hEM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11808
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

> Subject: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
>=20
> Instead of adding select ARCH_MISC_INIT for each i.MX 9x SoC, select it
> at the i.MX9 family Kconfig level. The corresponding arch_misc_init() is
> already defined in the common arch/arm/mach-imx/imx9/soc.c file
> and will print out ELE firmware BuildInfo for all i.MX9 SoCs now instead
> of just
> i.MX91 and i.MX95.

This will also make the Kconfig being select for i.MX93 and i.MX94.
I think this is ok. But please mention that in commit log, then:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards
Peng.
