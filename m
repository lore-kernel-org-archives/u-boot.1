Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E5C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0610C88977;
	Mon,  5 Aug 2024 16:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZzsmS1N+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA34E88975; Mon,  5 Aug 2024 16:05:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB4488971
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gArqv1ormdWj/g0ITJ94cG/CgjYchYeksDBkb7j/sihfX7f9TGeuHOZaqltJnyFa2vorLa173cWM8TQQPO47tYHhpm6BjOX078CSMpFJr1HvejTDHMtdb7o85NpPepMFjw7Nuw4MqkUy2fxvIFOKG5Fpz/gVi1E6e8NccHWqkFfPu2Y8ixMpxpRAs25pz2scg1KAORlesiBdcPhIGKa130vGpJcsPMNfpe/S/BzbDnkQXT8454Kx1T5sUp0kCtpJ33FETb2zi0Xwp9YGYpBMPJ5JH0GkNOz+3S9wN9hYtmyKDFgS+rgDRSrsEjAzsXTEBTXuv7fiH04FJTTvhiFgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKLNVrijdkBEwwqXCKd40V4Y7dVTRCdUUnYlVxlnd20=;
 b=XBRpI4hAqIJnKcTUzulyCCuP4w2sVyEJOPxniJ4wE4lOmkRQn2q8PW00RKKRgk0FMr9Ge+w1sE2axAeG/2T2YrlFEG94CgorPKPU7r9Ry99E7ASBtmN9af/3gAGZQ+qtwiymdTgQ0WHTkBRZvNCcslg/axTPqj3wploqYoQ95B6zJ07y8CaW/c1T2fIBUl5DqZRR/wP7+i+vIJ3tkWW9tRnZ2HHx1km5yhjqydzxP5PVab7iay3932weWaUTuC5yJmDWlW3eZRGDkJy+VAsDF3vvFpQ7kdmevSxSKnQHYICGKvjTIPoqMrwfYt5rm7EzAfCmfXlGH0nry9cGHiL9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKLNVrijdkBEwwqXCKd40V4Y7dVTRCdUUnYlVxlnd20=;
 b=ZzsmS1N+qVezfIqNa3aatmkuu4rpxv8GJd8/4Gy9lQbL0szzHM7b2y/BZTH6zM9Ji4fFETHclm9MSUtevfS5vxJaW8ClBkSAxfblj3yyyBSwQHkEmNTYJOshj5tMVF1KrTIHWLao0+Np2Kps1hR1yX10GBBRNdTx7ThZryhe6m3OZ4qvUcjKBcnb6BLLNhLvUGZ72V4GIwQJZa5098z8/NvjmNNrC0Jp3LqciCyBGq9SNRAL3e257Q/7Nz7TDsilfJ99h1J44tyrHVU4+HjRbUc3GxEZIXiW4ELe00P5YzTLchD9ZZY8b8QSm4/5UywoFuBrUNuUdPjdQH70dLFZlA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU0PR04MB9275.eurprd04.prod.outlook.com (2603:10a6:10:356::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 14:05:06 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 14:05:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gary Bisson <bisson.gary@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 3/5] spl: binman: Disable u_boot_any symbols for i.MX 8ULP
 boards
Thread-Topic: [PATCH 3/5] spl: binman: Disable u_boot_any symbols for i.MX
 8ULP boards
Thread-Index: AQHa5zUXZrwKhjrX1kCYlFKB1VCnqrIYsm1A
Date: Mon, 5 Aug 2024 14:05:06 +0000
Message-ID: <DB9PR04MB846140EE2F01C014DB6274E088BE2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-4-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-4-bisson.gary@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DU0PR04MB9275:EE_
x-ms-office365-filtering-correlation-id: 068a12c9-7701-49ea-5c12-08dcb5579c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jR0naQMGRCe1oY6oR2Z2ZV6QYntR1tPXU+FoUa5ZGSR59o1RBfMtvC/3MkrC?=
 =?us-ascii?Q?rgVar/BOJArBJ6S4vhzfFPxzx0o9EtPSzN3u73aYcTvd1QkLyrhRPSRK3PPr?=
 =?us-ascii?Q?uTdAQuixuUwjcUPUN9IIB2rNBm1QKMsTsL+5L68MI4AruN0d7Ej0sWTAb6gI?=
 =?us-ascii?Q?YB/loXMFkYCHkFoxmGsIK8uQz6G4vxjWzMtvpTLns+KA8J74vZxrKFZuAjmp?=
 =?us-ascii?Q?8biWS9F532CHgEBvaP41OoqGm3ja+oMKNhSMRKF+O6hArLUvV1b6B0FYoUwA?=
 =?us-ascii?Q?EE7CvUELS3+zuplHn4LkuMTM/5NN3nTFoMPHzSJWs6EmFQMH6A6RBwqqrNhK?=
 =?us-ascii?Q?z4D3QTeKU9rqxRNzp1h5Teuayst+6rqj84yvXb2+7mjq2EZHlOHrsBU3Z371?=
 =?us-ascii?Q?0pjqKPgfkaXEtsqObMdZ16Ojf9H4F6zMZlu2LG4HToFj+7/sl8r4jV6mao+E?=
 =?us-ascii?Q?zLBCpcnTkEohXYOca5p331MnKoCKk7W6eE4WbXnU1tjtnKK/Xg4J23Fjz63J?=
 =?us-ascii?Q?fi43JsaFdXCQCR8bzO1wPYBTN9WQSoGpGjWV+g9jXaQfrN9vi43j371BJLAd?=
 =?us-ascii?Q?FgvnbX01+NBwEwHi+Z9SBFgXiYMWUfPgEutdr/dlTs9/XEnRHPbpwaDdfVtg?=
 =?us-ascii?Q?mGKNWeP7N1pWaDpaqtnWiDzceO6ShcQ8Aw0RRYijV1G0HdVZuWE3S5Pffz7f?=
 =?us-ascii?Q?bkiYaCTu1fQA4x89LHWWiKeJ7npTAhqvYwQo+ZezUdTL4i3okVyHamxVGm2s?=
 =?us-ascii?Q?JYtwAtGBL5/MXZSMegL9Gd/6p/a7LW3l46EHLTKg2fbNstQ2TxCIb9xwPKg7?=
 =?us-ascii?Q?GGmGj+FzCc+4IAjkakCtunQgRmpjLtcb+e5DHGrvnUnBDemzARwzOdFdrrhx?=
 =?us-ascii?Q?l+45G1S0AP2MimCzttCpq4szInuQwGr5Q0vu9CMqhMgi/dxEpyAZyQL1v0zZ?=
 =?us-ascii?Q?b/8MDKh+TfM4lJpKlWkFyPr5hKGlkL9n74kEuaE5S09U9iTR9ht/dtm7cjpI?=
 =?us-ascii?Q?+2+LjT7h7e2KempXR3UR1P/qtty7VmGbKaViQzc3iMrG3+mLD54WYoMzkOYF?=
 =?us-ascii?Q?/gRVHHsthU1kG3+jczkaXZXuwjaSC9r8/V1I5jQg11OqAWHtplZnCnKWn7Pq?=
 =?us-ascii?Q?ZBXgFkM17Yrpz1tY4KigJzeOsudV5M8I4GD1lE/4d+8u5ewsoG5amy31EPKA?=
 =?us-ascii?Q?kLpbhtz03watl80sNewCCcoT5QsIuMcQIwjs3XlGbpWUheGAaTVp2xNtfPSG?=
 =?us-ascii?Q?PrQLZRW1MiEtyXy5IRYgnGvHYbsz6oRQa8h+oIWIT14blkvZdcFY6bEIh+hq?=
 =?us-ascii?Q?n0PKi0rB5A1ybMlucnr53eDkkGs0VNlpmBpZJjNg2XEVewbPO36KaLGM3NdP?=
 =?us-ascii?Q?vE6oTfomeDyXaXOJEU5lxKfxuK1TK0MbSChBc5elpgcPzb4gTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wUuS8gME3JgneYGl5Oso4MKmGCRk2lEFARt86exGe4G6xC3WEGiPSsqpP3MV?=
 =?us-ascii?Q?TbVxRDPOZCsP4tFxmCJ28emg+sKpnXa1C87sVliNuP8/5bgIYT5JP2K0OdHI?=
 =?us-ascii?Q?p5wx5s8QwuloruZJj4gqHS35Nc/O/PQoKcwhPE2GNuyqBGIMv/kra4oI2ehP?=
 =?us-ascii?Q?vEgHpJ3PbIM1HpQq49K34RmzvXF7nR3MHFNxr6sFWikKgUU760eWR3C2LQB7?=
 =?us-ascii?Q?rNcyjXf8Rpcvdxl/YA6S2Ms1ClH90iVhFWKewaNTmofHojnIiuTIPu2iZzdh?=
 =?us-ascii?Q?dqdnF1pEM89Oihhs5tOKjabxZrg6gvqyQHfEqa0aKo/OId7DbJwJnDs3Wk+I?=
 =?us-ascii?Q?k5MTwvzu9rvVkTT1911v6VR/e9TWYxZ6sVL4CN5md0BmiEONObV96tZMq5ue?=
 =?us-ascii?Q?MRnH91MY8nia0psJ4+vKLHTtGt7l7Esb/CNRLyexfTXSrAgWmmQ5jQTK4COm?=
 =?us-ascii?Q?Lqcb9avWE7WNWUWRm4mdjJQl46DuFoOCMkpP0Yif4jTJ2s/OLQBiv+2osSsv?=
 =?us-ascii?Q?vcyCdnA9hbSvoKx3ynCYkvzVjtJkOvpr/0wwnrFT/HXJfUbx1yLGg9MDxeCN?=
 =?us-ascii?Q?AKmeNsypnngpj/+54GDDSCc25dBeFH85Nf8JVsxHXU++mH8aW421ulxGbTS0?=
 =?us-ascii?Q?iqKzNZoTnsg3+bRQVAtIpkqaTGRa9npHRBAoDvSRapq6BsdA7VKmnnQRPM3+?=
 =?us-ascii?Q?l/aCLGebfvsK8LeW5RdMtHP2K8Y4BjQkI9Cw8tbazICYAVHB/W+kGNPaiSQc?=
 =?us-ascii?Q?/q+Hm1gT7TMIYbTn8g8rLhDi9sP99nYosyU01ik7U+GHOKzZ7k2PTXT+lC3J?=
 =?us-ascii?Q?HmkPdu2nvMF0AFYCBuWj9rV1IhdYRKWAhUv2UXeSR+/0oG5+5T+o/D4ZcuG7?=
 =?us-ascii?Q?XC/Qh4TSVIlkpKnlvg9oW9NegkF1qUJTD6bGEemj2rguKwVfrOOUT3m/EaJr?=
 =?us-ascii?Q?UKr5CAtMrM43nscF+bkblRxagRIwpu/+vRZiZrkdW5UprFGmt4qhApIaPb5V?=
 =?us-ascii?Q?De23SV3W+X2X6CULJDv3VLd252sy/jWCZMiW9vvcuU417ppC1+NXjfbFbBl5?=
 =?us-ascii?Q?wuq5FcWEhQvj1INKX6kx9bKFzviytspdq1Wbe3wD5lGiaXUtkPRlK52anZwL?=
 =?us-ascii?Q?szWtwDHTm8FmM1zV/lpajT2HxHpi7OmqjRH4RPesM5x1L/wuYrmzM+Em4rb8?=
 =?us-ascii?Q?8hyvosnjDJkCeluMjUsfrj3zaSncc/fWrv7ccnlfNUfvR3qa6uZNR6KQbzlF?=
 =?us-ascii?Q?COirdXpWUCzFvt7OetsqPxy0z8JSA1KEgraaTniNAeQ6nNlbw5qc++VGpAk+?=
 =?us-ascii?Q?pnRy6iQ8SDLA8KNRgnVmB3CUzvyCmTWv3z4i0CjUOk90Aw13WjWrroQOX1E1?=
 =?us-ascii?Q?gKYKAxYr5DXgm4CLNUEYfxdnhPpBcsJpgIq1B2BPmW8UhNs3As9wQxHVeDAf?=
 =?us-ascii?Q?NvFxuDtuLiBdmksov192Ta4rgNjJud7rx8Q+UPk+s5XOFUVA+Fa65KmtShHQ?=
 =?us-ascii?Q?7FIS227NDF34wT684o245GTnERwBKG7tuYJnr1AGbNBEwN2tHfh996pnaJYe?=
 =?us-ascii?Q?tlqqrGVxsCO92blm/V4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068a12c9-7701-49ea-5c12-08dcb5579c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:05:06.7032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Bo1cvdoYmwQxlUQhFzi8vTPPesfB+k9NLHhTXceVycwUJSO4YVMQ1SCMkmmRMzokJH2Xb3WbwoYC9kHkKVe4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9275
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

> Subject: [PATCH 3/5] spl: binman: Disable u_boot_any symbols for
> i.MX 8ULP boards
>=20
> This is extending commit da96f93cda9 ("spl: binman: Disable
> u_boot_any symbols for i.MX93 boards") to i.MX 8ULP boards.
>=20
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

