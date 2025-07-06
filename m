Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B016C83F05
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 13:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E48810EB;
	Sun,  6 Jul 2025 15:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IfdcHEJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC1E81D6A; Sun,  6 Jul 2025 15:09:03 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9FB80FA8
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 15:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daNecr5QoVNpooM1W9mUqj8lB9jHiQFsNHE8idF9qy/y3ZUDN+r06gK7vuJrHTstgfw3ddrYY8LIxHVzM317bgq2vtMZtd85u6yxXoSWT55h4Pg4R7MNxumH33ebLRaR89eNVKtZ5jB8wZUv6Ft+xmGNQMRFeXTee2u/UseEk7RyWueT8Wsfl7OWnJZrTu4krvj5SOp7GwH+vzzwuHE32Mt9I+/hE1KEETMEG3LzylQXJRv0ggnAAhYubmDglGEGYOmXkVO0txofWegxnRFGG9gAQndagweo051MSfCvLCEzHb5R/eAIvrymjpxvOrj5bd/ZGoa5JrwGovj/7vp9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5F9/EgujvUcL0FhEWK0zaz9lJLmi/PS/af3VQ5urVk=;
 b=hIul+Q2M2eKaSQNQfAYSRbCvDv6jiogdUjg+XI9h9u4d8Qzpd+piPIydsR6Q54z0xn7a3AC+uMn4QkTgbTWBeLLZEgA6ZMaZkqpB3/8xjSL4FXa5dFaPRqwo8PI51rei624jNWjnK6omG+yk4B3IjC7ufaHr01JTAq30KC+l8IyOoBNMhslgtdbEPoevfStwY8zGpr9J36tbgY5JpdKzpv6hwBfU/KtfNTrizhWQD5e0Viyw1vSqgZzGmUlp6DZlXHi5wri9HIFhp8bk1QX4YZqO96jAT8eAOQ74ItfCkoD8LuUL7XRR8SenvdTmM3GPXAubII3zkol/7RZWTJVtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5F9/EgujvUcL0FhEWK0zaz9lJLmi/PS/af3VQ5urVk=;
 b=IfdcHEJHxl+lS+XgQFtG4q6WkXuxDvQO9mmiUaTeb6w35Gz/Wbgj0I7rB7CWC39ncH68tbLplP/zgBBbq5uWKU1K+urYaDF+lcObGTtOUKwr31qwnBStedB2nesLz2UhdSvg5ctQJ2kHFum1A75J5Im2dqLa07HgozAOVYjKwBvCQCTraAqYXrbGJkFRxjWK/uYQwv3pAG8fa1n7w4gp9k2+W/lUSmr6crQcMjUSG/E9UVyAYLXXUgqCwrRl8BFoWHtMk3Ek8jR5sjYhfqpcFFYbUzRC4F9ICxt+UzLSQPejU1AG0QK+efL26jmI0kR8MMkSjhabYk8PQl+A0RtW8g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8137.eurprd04.prod.outlook.com (2603:10a6:10:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sun, 6 Jul
 2025 13:08:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 13:08:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 2/2] global: Make ARCH_MISC_INIT a selected symbol
Thread-Topic: [PATCH 2/2] global: Make ARCH_MISC_INIT a selected symbol
Thread-Index: AQHb7S0DiQefD+NfhEyhLSgai+1VuLQlE8EQ
Date: Sun, 6 Jul 2025 13:08:58 +0000
Message-ID: <PAXPR04MB8459CA8447286B9D2CA6E34A884CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250704214542.3418805-1-trini@konsulko.com>
 <20250704214542.3418805-2-trini@konsulko.com>
In-Reply-To: <20250704214542.3418805-2-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8137:EE_
x-ms-office365-filtering-correlation-id: a442947c-a672-41be-cbde-08ddbc8e44e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vcTtKon899+mSymy+Mys1CKyL5aY17oTF6Ky9UdMYK4TIe0mUpVtqGHb25+Y?=
 =?us-ascii?Q?55pUzF5vJopzKqpmxG5y1hBUkYQFQNCjSjcSuEP4r3NGX1iI6vV6/dTiEbnV?=
 =?us-ascii?Q?aj+9f5Gy+VM6LblY1p/vK7r0wyRt/QZ3e15UK4ho3smSal9Cpc6T2O/85dso?=
 =?us-ascii?Q?16uDqSRmsTNohw9o2ja29ogcMfRIoN3OYuzRh7EqKeYYPP/3DfUdVxtElVbu?=
 =?us-ascii?Q?RWOcb8iqUnwcJI48D2CojrJ7Na0cgbBFfPY/5axO5mOQ/mGA5UWKBQ5FxTqj?=
 =?us-ascii?Q?WgwVzYy0iM2on8GHzd2JS1k7dhRP4Djjevn8UVQgInqiEvkCYZ5E1obB5nIV?=
 =?us-ascii?Q?aEMAXwqE92Ha8us8nXSKVcg3jC6nrGbIr0lxnKTb9Pt7QHxRAXoNWesyI28F?=
 =?us-ascii?Q?XZxIIWQuSw+FVwNPyjF1tA/+5uFGtB0IA7Fme64NldnyKaVMoYrwXvAvw7tb?=
 =?us-ascii?Q?Ic78bAIIa+rAzMgDx/2beJarKJTz4C6gIMggFERc6NdhZ3mzm/ydlwuA+hxN?=
 =?us-ascii?Q?eY3wx4Dz1xuVVS3hfB5yZY1+zFFQQdaVseH8IoS98MVCAoNUgBhkr4EopXeJ?=
 =?us-ascii?Q?SaIY0MHbMHkEMfEnOfY6XMbsWV/pH94oSMFBc+BAfvuyAW9g704KPoKg/nKe?=
 =?us-ascii?Q?UvAAZEbV2w641TrgV5s2Qz2JndBH7JGZnOmI4O1xw0zS2wM8sZu64mMdnbx3?=
 =?us-ascii?Q?819apN2FuLbcW+H4qyh/DWa0CbmDM6Q3LZrR3p8agcSydWteH0xHINPk0T+A?=
 =?us-ascii?Q?yozIdfOKa3C9dfPn0xlL/b29EN9CBFh/ATL1Q34FBPP8fvSHmAznS8MlJp8m?=
 =?us-ascii?Q?XQNBDY82t5u7jmgBfwvOLG8EOY8X6zHX1R3CTGdwFX3zGjTLSyfG4yC65TMc?=
 =?us-ascii?Q?5SY+EB9xGOsQpzhDVDqNWJIKkDp1t71PkXExRqwbaSWQwrPnrea6F5UPuP1S?=
 =?us-ascii?Q?vfjMi4IgOWEVyNgLqfyBrBr6+mq1FJAgRbyW0NkhQ8FfJrlTyiLajC20+6L3?=
 =?us-ascii?Q?Ws2H450F6kgOqj8KTG7O2sLjp0YqQxvC2JbGyTlgYgraDBu6eZGYSKTjNZlm?=
 =?us-ascii?Q?J9UKaNAovB+JCP9M9Nlk95Eo17Mkf7GV8MHOUETDKFU/NYhRYC4ZXyDxiVIL?=
 =?us-ascii?Q?K7U81vn5aFIbDYn6CUoaaOcVJ13QnDH8nnhUeD2pVLUeThNfDXyANB+ST7yt?=
 =?us-ascii?Q?h3Izy7HXktd/TBlIo/a55F5n8in2cziFbL2S7hZ2218zy+TpP5LX4MoBt9IT?=
 =?us-ascii?Q?usNLgkXh6WCDl0uRRFBBNN1sPdhSJDIjjb1dy5k+bBsRrNZDEy8j/TH+S/uq?=
 =?us-ascii?Q?ieEiyYP50KxLIRu5mYEJB3ayANGb45VzgUC2+5cC6ab4f+HNMphT9F29CBeM?=
 =?us-ascii?Q?qP07YKiLVqOhcK28mbk4CAcA8SEdNYFadsdjfyXYtuQHEmRnHoJvjOCGJv2T?=
 =?us-ascii?Q?i0+UCg969v4iJtgK+JCiWz2mNbs8JDugnJdU8dFgwqZ5ejV2aauliA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AP9gxriVqYCEx71F84Ijq1npZR5BBKL/uyfVrBLkBqG0NobPK/MMcS4JGC7+?=
 =?us-ascii?Q?dBr4TZYKyBr8h+SMMsFtXDnChu5WZADh49gS2Z+zKZf44vp3KrJ+A2vjYB5q?=
 =?us-ascii?Q?dhVylJsB62ol876RWKbOLjHY3kbDUPXE/TWqJUpGQ/fQhsdaIxar4Gl9dHQd?=
 =?us-ascii?Q?2+ibMhZpFYgrp5cB5FSZwjQAfiZaJZcQp+zKc72obRsptAcGfePJnnsvG1j5?=
 =?us-ascii?Q?Ai7txbFQCLzIu7622xX5IuP91s3gm4yhhC4jZbXzjg1PxevDhXPB6SO0xuAu?=
 =?us-ascii?Q?yTCU35DoOY8bV2V/VZMIPQF5gmoTQl2x/P77Hlds1WCF0tfoUS9Mso/8UlJx?=
 =?us-ascii?Q?9u9VBFTNzsli4VBlBWCEwoaBJqsC7mk9IlH/a5qiq/+9IpgP+Y0DL8/KOR0M?=
 =?us-ascii?Q?W3z0XgEXe2/MalHAp0P4wKyfc1qHQaRTCnNA/OG+Vt/cmTpSEYMxIZInJ27g?=
 =?us-ascii?Q?DvMkUmkm+qvo/SfogMyYHrY/kuQl+VtF2AgGMibG2BUnSB16OWZ07+ahdjV4?=
 =?us-ascii?Q?bcCFwPp2Ri+iOM2XChbpcy/HKUd7gxWlqagsW//nEfzpF1RoaL0idM3KCX6m?=
 =?us-ascii?Q?I231g5cEy6NxyMZOjsKpccAetn4zl5RGxiUcEz2Nx2kAp1f1nZZ7cmJtwdCw?=
 =?us-ascii?Q?lSUbh7G0O0zSfigsxRbvWcdbUhL74U7itygUYyWNyP27rtEplK6DNg1sCWMu?=
 =?us-ascii?Q?Qr5LuPy5gETqMiW5p+BceAAOljYt+kicAW2BWZE7i+zcy3lVD+OO8E8f4lF7?=
 =?us-ascii?Q?TaEq0csA4mGDOqwvqOPZJvG0ky4JW3Yle1dN29tGYNrGuEHGe41egH2PxONS?=
 =?us-ascii?Q?Z4e+c05J34AO9kxbfE+m5Slf6nyI003MnLNGmvTbAeinpamSCoA1zPE1NH4k?=
 =?us-ascii?Q?b6te8rYzRqJjl4pgUs0K4EP5e3hN3v69iVGSZUfBOYztGbo2EXwapXJDi7Rm?=
 =?us-ascii?Q?pDb/wA3/VR9cHdqpflraaww+74CuveMNMIL3M1Lh4hYLFwg6k3tW0YoQRw5j?=
 =?us-ascii?Q?xlWaL47Iqwok3aMZ4lbnkYmwXLGIZZWZ7AwT7h5FrsVuXrEZpnGggVKdAYlY?=
 =?us-ascii?Q?I1J0NNvwCde0GJSUCmidp5fo6AG1O579vVjAAFMe0Xv/U8PTYjLgZcSJENSu?=
 =?us-ascii?Q?FmNdBrEOeMipF+YQ3mriTSeQaIGH3FZlD2GUESVHM5IJXorzxPcfePqXxOLq?=
 =?us-ascii?Q?VWK/EnQEn0A8PqJ51mRElW9LX1zs/04Rcezm0bJgIHK/YI1/n5BWHF12BAJc?=
 =?us-ascii?Q?p1rlUBGc29dPQk/5B8tbPJ1MMxU75Cc+MozqthxfNP9pdMCM+k/olhOMk5Z7?=
 =?us-ascii?Q?ZOyBSrWykzz7Z1LOoRdzgSeKuZNfKv6tWTBwNFLiOfDl6B3vo/uUCc1Df5Bz?=
 =?us-ascii?Q?eIMaotyGJwwOZd5+qbifTJlousQxenxcMYz9BcG2R82F/hSJPjqeHjDEcqKc?=
 =?us-ascii?Q?WIBmVKVWQp4w5NCzdHJM881HUSLfAIa4gcLwpJeuIOFFgQ+4pDkbikt9D+GN?=
 =?us-ascii?Q?2xByDXqkexTRXrTAZkpNTSRZElBvZIp1MrbA7MKlGm4yd+udYGqQx1Va2X8l?=
 =?us-ascii?Q?bQkYKch3usN+olJvyuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a442947c-a672-41be-cbde-08ddbc8e44e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 13:08:58.3426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU9VLolyGmOtNGXiCAHo1E0H8NQSePDm19zexNKpMEVP7uB1XBcjCPGtaPyDj/Ah1PFSObbk7X51Mh6zDvf96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8137
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

> Subject: [PATCH 2/2] global: Make ARCH_MISC_INIT a selected symbol
>=20
> This symbol is not something that the user should be enabling or
> disabling but rather the developer for a particular board should select i=
t
> when required.
>=20
> This is mostly size neutral, however a few places do have changes. In
> the case of i.MX6ULL systems, it is always the case that
> arch_misc_init() could call setup_serial_number() and do useful work,
> but was not enabled widely, but now is. In the case of i.MX23/28
> systems, we should be able to call mx28_fixup_vt() again here, so do so.
> Finally, some platforms were calling arch_misc_init() and then not
> doing anything and this results in removing the option.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
