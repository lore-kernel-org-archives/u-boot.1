Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD34C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 23:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A1D88937;
	Fri,  5 Jul 2024 01:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="guC9TcUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069928895D; Fri,  5 Jul 2024 01:50:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15D888928
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 01:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPuG8XBFwiOSvEbHMVvnv0vanPypK1LsgBO5PK40YU6D38HAFgdmmMd076rIL+9xdG7NliOLHci0FpYRuT2HEsZBPSdveP6bJi0cbFhj6w/07zAi1RmOT46oPoW1zltg2Nhg+TeLb7uLXwCJwxdj7r/9xK+IXq67Wf0+ozuUoTtjRNBQMtKgM1/NgfpTeWdKeSHg6T+l37glPUDHNSav84Sc1wyxE8Wq0lpN48WXK2VmDZk390qzX3zJ2Dm2r8jdHbikoyVZSPM06HmxatsJ1rTbmGKjEkiGEAvdIPvJT6SftDCL6zfsvNyqj/44pAYecbt9w9e8gsQSuGfQKtuBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgO+ezsUYhGRnZ/OnZN50p0e+ladbu7naTMM1R8EKiE=;
 b=ZnAg2apt69DcEwY64K73JskpcMZboiMXjEZ7NZw74dmq7TpmqHaEYAPevWv5l5MIUuegH5/l99wKiY4eLO0mK21p8H5zO2nINg7uDtEe+KNNoNJe34NnlA7HOznjK2mtQMIptTRmrA7M5ohv6vgx2XGhbRQiQ01QV4KGA4UDUe2BEeUINX4OnwHVCqEWDclpPeAZjhu4T1MmK171kq0exiFXUOwXNEuKB6ys3k/39YUX0r6RD/X8bnOdLdexIgj8IstXFiBcPPdJgpXn8USwDTaxznFha0vnfSj6dSF3GKvdlRbFOst0PqkY6qoQJW2hbzJf0uMm0ltwC8wMNEpv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgO+ezsUYhGRnZ/OnZN50p0e+ladbu7naTMM1R8EKiE=;
 b=guC9TcUOaxO6261f5/H9QTwWLuBnEl9tgrZoAHJCrhubZXtyjeiypwvyY/rfGHJTT+piZmVrlGRxKeaNGiZ9MiNKOBXbW25p8rANEZls3o7shsJybl4258Oj2R4Rc9at8EbhQTLYuoxwd0Vh/dPbCKgyWiMiPcmn2a/7HBUWRKU=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 23:50:35 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 23:50:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "aford@beaconembedded.com" <aford@beaconembedded.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Sean Anderson <seanga2@gmail.com>, Marek Vasut
 <marex@denx.de>
Subject: RE: [PATCH] ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS clock
 work-around
Thread-Topic: [PATCH] ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS clock
 work-around
Thread-Index: AQHazlhVRdprplmIrkCKUzt+dZ16xrHnPRlg
Date: Thu, 4 Jul 2024 23:50:35 +0000
Message-ID: <AM6PR04MB5941A73068D777AAF7B82D9D88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240704212247.178521-1-aford173@gmail.com>
In-Reply-To: <20240704212247.178521-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM8PR04MB7890:EE_
x-ms-office365-filtering-correlation-id: ffcceacc-5c5c-476e-9e13-08dc9c84194b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XUKL6V0Pb7srkAaxUdlalQtkC4Y9LlezY10sa9KUqKXctBj8yO4sEhxHbnj/?=
 =?us-ascii?Q?MtpPhj8bFs0ReFg9MhR7KZT3HWOzVXN/E1Z/GvLhCC+yACXi3ALeQtOZtVFZ?=
 =?us-ascii?Q?nXKcnkDqDLRbTHIn6qZxWHz5qekPILJhOG4+i9n3/nklGW5Li1JcZsjWV+sL?=
 =?us-ascii?Q?fNKS6F2d8Dh7qF0WrO8zGmX+PPtuVLDOt8FPx4C4dq+eguJ8SwIMgmO1W72J?=
 =?us-ascii?Q?8itx1FMK5icuGCdaMg9r+/8d1uYn8fM7enOIusineEOv6iuM5byFk8dzpoAk?=
 =?us-ascii?Q?R0i/av7/me++kGjU1mRhfUQhyDOBTy7mMJWOXkPFA5aZxjgjoOjeMw9hqSJQ?=
 =?us-ascii?Q?w3EcTrI2GKuhV16f5dzJ3Ch5p6zqCf0oZpmM5v5t7wsbFZFqsM1FiKSLBiPb?=
 =?us-ascii?Q?5g5754eV1SBA9EVMKz71aEBJdDeRUTIZSLNrjwOWEYaJcP+e5DH9Lk/mvRkn?=
 =?us-ascii?Q?awsvy4iZKRoaP4jmoD7Vi00yITpXd4Oh1UDs3evZJuiVsLdGUZ6f90AOevI8?=
 =?us-ascii?Q?9fNuoir8ePX87Hww3m1MlRDRtDZ2UgFzL4p2l0ORHxDeU1qcTqrgCva6jo7P?=
 =?us-ascii?Q?jeKsWf9By93TVpwtYrFbOs9VBoCiLlabCr7M+7E9X6uY4o8VZzmh/j8zIA1K?=
 =?us-ascii?Q?8x9nnACdtgDx60qPDwK8nYkg/GOPyqOZ89PwMs74ll3yGxCtJ6pKYu1U1MRT?=
 =?us-ascii?Q?u+U28iiA2y+k2zD6rebbTfDVQEkDQ64J3uqwOQJCEZcvS03RgynW/touZSsd?=
 =?us-ascii?Q?7XdCHOIklIrgENk3WKrBCPI8UQyhB6y2T+RdtVc+cXTDNiSwy5uLrLuO/KWD?=
 =?us-ascii?Q?hWJDCIa1PzyI5sFA5trd5ZAU2lnAjJDneQYV7LBbm4u8SCU4HdyuCj1TavF6?=
 =?us-ascii?Q?BTfW2ORHBcy5AKwtqEiqf4SuAFDj9DNfA15QTX57RlsHfCoQt8RmGLMFzN1m?=
 =?us-ascii?Q?c8wJqobsCuSL/IJvjW1IrZAytyCYfNs0SXcWJphey4Ol8Hf/+lA1wx4jCvXH?=
 =?us-ascii?Q?pjpg+DiW4iC9qDQuESU7AKfvUilVzMtcUQLV6oIuACvb2oFGhe3lbND9g50W?=
 =?us-ascii?Q?WXS+jTqi/QHq4XGMDl1H6+YWrsPCD/He0jmAijDy8dYH37fmNAdEH0wbG85V?=
 =?us-ascii?Q?oESr8uDR/Bsnh3+DiVtm3QCVvy3iLIGIBHL4hu2c7dcJFq4n+23n11+t0I+z?=
 =?us-ascii?Q?+mwxberw434sIFxXTS65/k+VA46Ajn+R0Oe2G8eRWW49RocObpUOj/VxRDaA?=
 =?us-ascii?Q?apujRJqgew4ADmqoiwExHbnvbZIYQ9UofweGGpDmqOTwDYg/jbYvNj/eV/zI?=
 =?us-ascii?Q?8SFrzNI1tL5F4rZ9fv9mbxa8Q/+BrI4mmsVwQpmXkinKIHymjOEtb2IfnfbL?=
 =?us-ascii?Q?5JSH4LcLZjouljyDVEmf3iAmtQGG7PLIBDYPMCZWs3RQzF3v8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5941.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v07Bsg/2iwiH6Jt1Vqau5u6G2qoDtaASoAzj1+0jJ0DhnsoiQtiVXEcZW7CK?=
 =?us-ascii?Q?HP3DjV63U9iEfwjkhH7MRPpIGSLX/eMArwrSWdwtm2GQ9oJK67sLXsnXMSfj?=
 =?us-ascii?Q?WoL3kbeVlrtbAIklMm1D5wQEJeBWXMs5srgdqTjuJ5U069VkpJ62yq+tTAFO?=
 =?us-ascii?Q?gKjCapPEIxxydfXyJf7bUzLByarFm/x4gUOPCIVhQM7aHEx6MDKiJ/qBZh+c?=
 =?us-ascii?Q?FZudw1isp6ik2Fu3LnWOGzDcN7PqD8lA0A332ERIIfM638AIrK4F7sv2XHMC?=
 =?us-ascii?Q?IXI+fITm2e6k7SPgDPv8Hyad0i2py02BtzoDzmAlD6ha0CBBhEuUr44RcBAu?=
 =?us-ascii?Q?4rOYdoOjdY7sazYBxYRuwc0WArPlkzVyrOLaktiJHYuou2y6SkTsHRlnt5Qo?=
 =?us-ascii?Q?NumW4dQgM5tp01YMbZfS/TmZbNN0Q/U3Sg10gV/pk8BrADULBhDJbaw5B1SR?=
 =?us-ascii?Q?LNhZY4F9gi0AJwV5V6rAI7PkCxHH/jnbiimPCYTA1X96QzQ8eQh/0+FOl3ex?=
 =?us-ascii?Q?HGc/bfaH7kWGbIHB9s0JYzwXRQZaFmHmyK/ytS6N+EIn4JRSuRzigAodRRmI?=
 =?us-ascii?Q?QpvJG8E49fRYfUZhmPdfQy6431i9daAFbpDv8Q7zBh/P2n8KOBKvCrBgxAZV?=
 =?us-ascii?Q?XFI1uErGltPw00QIfG6egacDnv+YYzbPjHpv9xSwukf4vLbi6hlr31d/uppQ?=
 =?us-ascii?Q?72aCv4pGh2AZ6xXk4LcQ5WJjzd6qeLN7ZcjzT42S5nKFoqypnUz5ks5OUY4E?=
 =?us-ascii?Q?9BBzaXyq49vRZBPqCFqM3l6hBaomUMkkpsTXWVoprT0/hPZ+TAhkUrPHyBdV?=
 =?us-ascii?Q?1+x3Zdvxrt4xd5yFTq/5GYVZlGFIjCcz2I4UHcwYPCp3XaZCbPWNQnbnQNSM?=
 =?us-ascii?Q?86LaWYomIuTkRjnOCu5G5swc8z87rL+mrlX2UlXkUSEpWU6+x8Rc1zroAhZ2?=
 =?us-ascii?Q?vXyaDzPcktSxSbBODC9csFLeuNuN88ymfnm+AtQFbB5MAXMyVFCrOhohvTIw?=
 =?us-ascii?Q?DpTcU3nbJ0sSQFUy4KH6NS7DIavPf3TncQtnOgjemyIF0fZZGrztBhDAGC+O?=
 =?us-ascii?Q?TKSjfXfivJ9Mt36Y45Bj2CzupDi9C/10T07hSOA9u8RIpIlEDy2IdLV9I4cj?=
 =?us-ascii?Q?RPpwWRakiQDotHi0EosvyINbXrZbghT6T99+m973fvh1ftLeLzQLSw1eMYrm?=
 =?us-ascii?Q?55XwiBG+VTDnvN3Un7AldbVtkZc7EKkdNT1HvS2SFJhC4FQ1NjL1Haroa0xM?=
 =?us-ascii?Q?rzYDgD2wZQ/yrrXiwXR2KQUjcXzZbewIvIzDd1wZtFncH4y9TUTRox3Ed6U6?=
 =?us-ascii?Q?rHi5xCpxTjBSbbZpsfOOydJhyHDrZP7Q7Q+GTgyHU6VaA9mAX1lYj/OIWfgr?=
 =?us-ascii?Q?VvXLAI8Ca3wBqwXIVVUHIDbdmWSbOijt2N9zXE5d7siSkZyAoXZNEoS8iH9C?=
 =?us-ascii?Q?O6eGulg9GKfzinBrp0AjfgPrnDI31tHCRBBVMwWcpg1tshoPSk4SUC+ekzlK?=
 =?us-ascii?Q?fA+3XdqFgUFIrOioJ0x942cpDXDEz9yJKpSOVZhJSSsMLeGuWTuCtR0oxVoy?=
 =?us-ascii?Q?aGzhjmBFPsDlf3X4EJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcceacc-5c5c-476e-9e13-08dc9c84194b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 23:50:35.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J33MdT2BvKrAwooIWm/bXMoHwqbtG6eCoMXg3++TE6YbSBN9My1sHWyZ2wCYatYvp/CsaSDc0ato8dcbbTditg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
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

> Subject: [PATCH] ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS
> clock work-around
>=20
> Since commit ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock"),
> the clocks for the DWMAC driver can be configured, and removing
> them breaks operation.
>=20
> Fixes: ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock")
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

