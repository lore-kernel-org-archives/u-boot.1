Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947A9CF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BD483FCE;
	Wed, 19 Nov 2025 16:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d3ASo3iU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B378A84010; Wed, 19 Nov 2025 16:23:33 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D3C83F7D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5Plsi7bmRnBcnnoPrDfeliZX7gTf9CqcztBlrirBwrD5+7a6SZF6aaH0gPjJqcExvSdcMlmbbnf+Wb8gM1sP8RmVrTlBEwGdiiry8H64r7BBXH7Wf0dteUDEzz6neASzQKBBkQ7fn4pTEWuP2LkhssPFoDYBTVUhOl4ACNntQEVdttMkz7He7QhdtqYAsGjN5jJtSMrRV/Z+RTvn32CMzogZSmZyFKFiLPaKpOAQauzT7BCr+5Wf1ciXOZfugB9PreVRdAbj1KgMftqed1kQPD4E0zaoO5XCs+Mr0iKffyoGc1/mj4KBYq9zQn/j9gCSzhFR2ju7nia19sC+SCTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv8sgSBHofStT9vL3fbldpBhSDpkg0VP9S8mkoRyBio=;
 b=ZEGL0DBMKdJ6qSgXTwCt4JnmETANWuxfRS4XTJOOIISIfiwNrFHn1N6NM+ary50XjeTCzhA22DmrtRU1Ox/G2Mx/OK9aFeA3Ve2oBx6wOeBvw4s05+38JzucePwB+ZbUHIuMLoZBsCQWHBi8IiTSQ83eOghiS3sUPftdUzFgrs+lGJfnhpdr0IzxJLllnPTVwo4TT8vciUI2FcQmH12Us8f/h9LsfQDVK0D0idyDDqpDSQgDlIQYdY1He+2DDBCiaOl3LtiKozuGVF3JqUIq2m/y2zKRrZiVjiaw8MrgJeXvx/NrUGnEMw+QW9mEUrrPGRfytFVkbbYHcdh2su9csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv8sgSBHofStT9vL3fbldpBhSDpkg0VP9S8mkoRyBio=;
 b=d3ASo3iUW85YkKqWj5NyvZVH6e8p5PYLbYMrdcMCW+ImTqcDC6OuwiIDq7KthCowT61jEIM+3wP/Psd5HrmGPl5p9/ETDaAJPU6bkUJSZalhKCNHeDUqei+N8tqQJ6G3xs0z72jptRrDF4iV6TE9sOgMk23wUeRemPDaTEGGYfqP6LUwe8BJ10k4SLRV3x9yI4NBWOwDNdV8+JWnMrwyThlU6Z2jh0pvkJDJdY83RsBf2tyH9cfzyVvvB2SErnuSEhrPbf+L95+09XiPmgyWFYhL9Pz1Pq2glbS3QNTdPDUIrU36Rlh9wqQdToOfwkL6D9NVBL704V+RNSQzGhKvUQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11270.eurprd04.prod.outlook.com (2603:10a6:d10:19c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:23:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:23:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] mx6sabre: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6sabre: Stop disabling device tree relocation
Thread-Index: AQHcWLXAA3V77EThdUOrlUoh2R2qJrT6H3Gw
Date: Wed, 19 Nov 2025 15:23:28 +0000
Message-ID: <PAXPR04MB84599E3281038E6E6A750CC688D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180408.591167-1-trini@konsulko.com>
In-Reply-To: <20251118180408.591167-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|FRWPR04MB11270:EE_
x-ms-office365-filtering-correlation-id: a37d1dab-e808-4680-f744-08de277f977f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5TE7S/vVciyYykAYZJj9y0p6W2GAD6xehM+dYjLAjRt8KrDSEt8iggl8QUOK?=
 =?us-ascii?Q?2MP7IIyb78k16AyK54TD/VHV8KPCJvGPHAD4OSI9AtKq2OWFM2kycV1vSywZ?=
 =?us-ascii?Q?7Jgeavg971V0CeV9pjxjhHcnA1zkAjEz8Ap8EwVqS4wv4hGLYhcHieYpTRV5?=
 =?us-ascii?Q?jhvPcdTaweG8xxv0TRfLS9IA3ab+6phIkdlcXvU/zanaMqIDpkXeTPTvu9BU?=
 =?us-ascii?Q?LfkXdeVhohcK45RvwkxN9YFK5qqCrgQnq4rE/4TRXL1PYxePkLM8ojS+gkBp?=
 =?us-ascii?Q?ftXN8qEHYltfsLG0Tj6QR2WH44qUGhX/6Y4zviHmTI/xs1m6Jv7mNA/tM1I/?=
 =?us-ascii?Q?XaxnCwePdY68soGnK29XFItVtMxQbr+isaA8ekTUcrbvX80CiXwRQHZ/NPE5?=
 =?us-ascii?Q?SgoJFHzdmreTZeKOYID0+il9Ml9XVyIDHYzqnSifZCEv/os6zIs+cM3b8pai?=
 =?us-ascii?Q?fnfYV9StBAsVJ0Iwkl6h8eBSk4g9s/ThgvQ+fcU3fwQ9E90yFb9EnNt2W20L?=
 =?us-ascii?Q?vFr0yTTBfP7WobdC3Yy/coU5b293xVq21Oy2uNoMQkfVbhvVp3ySU6DPfGow?=
 =?us-ascii?Q?p6XL4VVqCDYZ8EZZMLxqo5zvsIiliJDlj6S1gdywjpkk1uHecfFbXPyBpkn/?=
 =?us-ascii?Q?osZcWeYNCiQGbdtWMyewxLvGj1G3tbTxPP/YuiUEvyFylyTPxqcqz4wWo7mz?=
 =?us-ascii?Q?lBd22a2N19NnejKEoiwDZR2/wIJarsO5uzdbblHReL8GoATdYpj3PCkYh6oU?=
 =?us-ascii?Q?mQjIpWi8ZkVmIYOorpDpG0Rz0Gkl5dmtVnu2k3BSQIYwXc9WTpWzhpjOskFL?=
 =?us-ascii?Q?hArrwhLa6VE/JKz6RGZzBhm4D46nIV3kBSCGOTR/+2E3AGGKOG+hWjlJ1hc9?=
 =?us-ascii?Q?uVtOCuFhfm8sRmaoP+8Xv6iiL1U0q6d81q+ve0WcQ+wvuHHqWcvvl3EHX1sk?=
 =?us-ascii?Q?nIibEfZbmmw9PUC858YtVkmXrepYKQQAKo5aYOjXRSrbI98JANXQJaDqEEjK?=
 =?us-ascii?Q?G5r6vGOdCi3jD/AQC13ugv9ls4GvkoVwHBAZ39Tq9fWReaz/xpobUm7GEJ2R?=
 =?us-ascii?Q?PUFDpfNcmfWwyyn1NwVsEsJz2csZ7cG8C6ujJcuNyGsObQ7CfCXnXEyzB2nC?=
 =?us-ascii?Q?t9rCT0YKHULBCKG0414+usvh7Ufx8/8/AU7bFKFuJuP56eEPZUoHVO+192j/?=
 =?us-ascii?Q?Wi2LgYPU/6PW/m4pqmkyPe1Ne4s3xPbO0klbG2R7Pee+k+BGQ9nY3rKFf855?=
 =?us-ascii?Q?VPo8troG6dJJlRnUBRzUtO3Uhtq6rGZCgN2cxIivqB1sY3/Jke/FGe3qOm8B?=
 =?us-ascii?Q?Fci+ZBeuvmP1CILHnIJnxbAmfEsycY+VXdLPcJXrsgpIG+E0GKfeIdos9j35?=
 =?us-ascii?Q?0JlOqSDwLMprJrxHZ+dXD30kBY7hv7CrkQE0SyWUkDvL5WRxYm7o2it7hmXh?=
 =?us-ascii?Q?se3sWrU6yjG5qV0vC6uq2n5XhVJ4fi3JVfAQbbcvtKE3ZSgKlFKi61SGwupM?=
 =?us-ascii?Q?DatBfWmv69iEFaCqHa06Gv0B+saVo8C1kMNZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kNqiBOIS9OXcUoVxC7OsY8gl9Kdjhu2VUgCWbJmY89l+L+ifTRmP4BciXHOj?=
 =?us-ascii?Q?AQAnPf5DPdH/2edwrTXjFPy0GpjylirM/ZFb8p9f21wWJgBj64eSIvefQld7?=
 =?us-ascii?Q?5AMYua75Yf7a1npCxyjC6rncq5Q7gjLKdP4o2f9mtZZNfYn5wnldXyZ/Ux61?=
 =?us-ascii?Q?kGK38GAI1lot2y+R+Frx1uGibZ5lB2+QKNTYOzL7QN+ae/Whb0+Hq1dKcPC/?=
 =?us-ascii?Q?l39fUJ3GBIyY205mZQgx0yNVY7bdELJqEh69ws53KGmlFC3lZ/7jc5uGJe3U?=
 =?us-ascii?Q?EV6XIE2cx2pUzF+Kb+OPDUPYQlo8vHVyPGbgPoZE7sjYZqKY0M08yaqi8SQ1?=
 =?us-ascii?Q?8M1oMBDQXf292pPne4XLoSY4ANpUOIC2byBn9TQtFInTEh1ulD5krU5KsqYu?=
 =?us-ascii?Q?L805i13WSq6zobzGpS/FCeSv1xGJv8cklU1YlAgZO6XiIIlM58MqcHU24Xlp?=
 =?us-ascii?Q?uM3yAGIKSNCMv9bS2IJBBvcj1eNGOTN4H9B7K3bM0Lp5HKDBlmw3Y45G3y7I?=
 =?us-ascii?Q?x6dAoF3vz5qvmI9YMhZg4rHkqOJ+oiqCOmtjHrymbJJo9ylo+7+PQjuxTR4m?=
 =?us-ascii?Q?AxqTGBdHuklX1t/28TQELCLvmMyakbKWGp9rC+sWdSVYD9kJzsNcJ35Z5WoJ?=
 =?us-ascii?Q?DmP37KtHGteCUGNUCrCRH8r3JbkCdlhd8wS70aYQiYXRX8j729r/CK2r7FJz?=
 =?us-ascii?Q?IHuIqwi0M2eZxAFyWvdWTd7XpqbUZhzW8jNNp52pA1PcdGaftEcz7eOv89bX?=
 =?us-ascii?Q?AA/JuTc7gILo9fqq/sHZ82N9oSfxf6c4eclxGXoFK7TUlBORaqrnpDIqPSFF?=
 =?us-ascii?Q?XNkLef1z+KWoNkvQYDCaoKlMgsQLjXoOQf23Uit+LKBfszsTFDLdXfchUkKz?=
 =?us-ascii?Q?EMeYIzCRbZBmRu3SigsGJvUXRl1a4l8Zk+KETgqXKuC1Rx8PPiY4Lya3TFPx?=
 =?us-ascii?Q?UCBFnnrOfvbUFjmZTenAr0Rji4CpqakDVWeN/s5yO5VfebONoyNxCzVQBhdz?=
 =?us-ascii?Q?8Vyk+hBQ5bvGPgn+qpR3xcJu4maKOK6iyDib8apa5jjnUvqYXu11Trxb8fjE?=
 =?us-ascii?Q?Y+FyrGThDbBCpK74sAW80D3kWzuIH3n6je497czBf560NW3+CdDinQh0FUEF?=
 =?us-ascii?Q?VsmORxDDC2e7q2UBRTZiTu72zwLne11ljt5HGhkWnVOdPmY8MI9wHfrY44yf?=
 =?us-ascii?Q?JZN1To7vtW4sVc4du+lBItllzR+qCSNdzFBn13CE2+rJZ/x+qYWXnteGcZkh?=
 =?us-ascii?Q?NwBncCEA+2JkfO73m5ungmy6iDK2JbUQDJYdrCNC0Eg4TsPcrG+DT5J03e4M?=
 =?us-ascii?Q?JVcR61U2Pj8sKbn9pEn+GAZcndvKK31ApGVnLeao+P9ePWmLuRyDrkBbVOYu?=
 =?us-ascii?Q?w3cPe3iXbyw39bbK2xx0tJQqpMq94lEXWqFAiLjtToalB2SCdpIkFw6aKApI?=
 =?us-ascii?Q?9O6tCcsOM0id0MdgM5oNuJVJrt2y6QqI14XHxB6C5UhFkL5jIaD9Cegh/f1R?=
 =?us-ascii?Q?gtqQEWe6utnyL3F+m3e+gYiY/vVEb/CMf9svp7Q2cL8R78Ec/MJTqAGtrrOB?=
 =?us-ascii?Q?VpatlcsHlP0mAL+7uMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37d1dab-e808-4680-f744-08de277f977f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:23:28.9216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGUs3kTwLMF8AqYqNElD3UC142SC2r+OXIt9BDMsJ3OEaATShPlPip7iGqoducjPRuWZrNDoy2QluFnEDRR8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11270
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

> Subject: [PATCH] mx6sabre: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
