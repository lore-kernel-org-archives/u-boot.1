Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1B7C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8FA82ADA;
	Wed,  2 Jul 2025 03:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bzwqKdhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458FA82CFA; Wed,  2 Jul 2025 03:27:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEFA82103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMRPIfDlN8TFK99Rz+IbKkHYRNXNmAJ+0ka9razhIIKY4+nSKQ1YshLDTvDd5875CSk6vXegrBhvS0fFxLQ2pfUaO5hddxGzRrM7eeV3zUH1iU8z1egxr2i0BQfN/YXMM7W5idkE3hogY+KBzf2pG5gUCjelV8vmJktQrbShS+4lLQJ/yQrZ38aNwXl3oUpKAABAKPQTLJrTHMnmlFWY5lhWOOP5aNniWLBKRavJvVODfx0IgHg4dO5gwpwfVoxRlu5pgjPYmfEmSMBQ4JkpINawv8T2zLl0JxKG0wcqszfKG1QTz2ddD0T4Jcx7stuU09sgWWEmQyOFpQAuXjt/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH5r8jqrEN5PGvn8yGsMkr6LB7PTTCfqp3m+7oSDFrs=;
 b=hcl1G4nXZAsalWInqoUbbXDiq85sPZrLFRUCLcWedxXQyVvEdtds6zOQhoiQ55zNpiSkVzaCu1sDRjU6DmTdHKk/b6xHrxjCPteKqwGOeXPJu/oA+sRukYNeFTzJcH2ss40GkkBDVH/cCQu7WfXI+6VT9D59IoKITFx/D1UumFU8OJA6D1zi3dCgHyY2eq/pmNF0ITwvgDQfas7ntEE0/Z1aH0RT18qBkuxAByauA3oyofcsr3IU4FROV/tmLNDafVkv31rOiT3eEarJW10N3z51LvQNe2BIe5eN+TaqRE666jl5WERJqBUwwtKodzlPL4LKmJjRqUEUcgC9VupHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH5r8jqrEN5PGvn8yGsMkr6LB7PTTCfqp3m+7oSDFrs=;
 b=bzwqKdhVeo8V07lbubB0zo1Oy1Z1shMJpzk5mBpe/FR/GSniGR6iMnCEE8kJ/6xXdr3cjXYWGY2BPKO1NKzabwOOKVDByQTvgw61J+ztG6/yY/RQwnmCM1xHHSb6HdhK7j+KLwvGd3cXsCU3EZBhJoyWzaDULOI/KM1byNQkucv9DnPTgdqwAewxQojT+PqtcjHKiPf22fGrILGyPuFksfQHKi+sePH60LChTvmY/n2DcwHsqBk5qViaGNCZedCc+CDmzYyezwT6mQhFwDtSPJqQUdjyjwDu55xi2ohZ7h7HjOS6/WOvcjHZDH5WVMheptFiaHHhqxHSuWRzAq7LDQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 01:27:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 01:27:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_BLOB
Thread-Topic: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_BLOB
Thread-Index: AQHb6u1gH/qIhpyFmEyG0CaIkBtVQbQeCvPQ
Date: Wed, 2 Jul 2025 01:27:12 +0000
Message-ID: <PAXPR04MB8459CD314A699E08975F7CEA8840A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250702010511.19141-1-trini@konsulko.com>
In-Reply-To: <20250702010511.19141-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7688:EE_
x-ms-office365-filtering-correlation-id: 9f9b0ef3-ff18-4c18-ee8a-08ddb90791ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pxGPcwMc5s+N0ALCD6yaHD2st1oUR1lwTn1LFrkbg4MdyDOAHrO+zqWZVqjG?=
 =?us-ascii?Q?QLPTyoaC/k/Ii/ioMwiIUrtBP7yj1bL31uKTE6CX2Mue19m8/ScQaE5FZ6zu?=
 =?us-ascii?Q?tPDLZT2wVOCDdGjyXsWuv9IyufEnHf7FDx1fr19XcuFXGVLGC5d/TszLJhIk?=
 =?us-ascii?Q?WN6dqCOu2+IrqJvJv2hSStAaTSwffGAlJTuMSxkQJzNPYHdDePURqKvK8EKt?=
 =?us-ascii?Q?zo1xKMKyFn1UVXhh4H9X8pCy0GaJSef7jvfNFdRzzSKtlA0mu/cZHVCz91Dh?=
 =?us-ascii?Q?xKvQMbkhVleaghZno/H59ru7Hco36fb1Be+e3IfMauQKliaKwx4mAkrg3DIY?=
 =?us-ascii?Q?cZpk8e+YjcNkCXkmUfUGMwLnCMFoIdUIQitypP48Q35LFtVtIWCBIJK6AS6D?=
 =?us-ascii?Q?Rc2Fr7bZUuW9y5yBhQZ3VF4iP0mPTlTX/qBGm6KP934B5TcOsrUcMjtlR3JZ?=
 =?us-ascii?Q?fq5LhG6HBFsd6YC1uPls2FEvXCozS7c8oNMa6OmpGkWdHgOiSYa3Dyh8AcQV?=
 =?us-ascii?Q?WQwpGsWDvQBYu4IfqdrI1KgzhNtbV80LtAAm6TCEzxPzBgLA0vzO8EOlzMIS?=
 =?us-ascii?Q?4FYAWXeI6C+q/oXh746AIVPpfZzkc0SqajQQSktOg9fe+Q26VnoRd1wpAwio?=
 =?us-ascii?Q?D9lat3FFNYh/B3srU/sodPS6OgSdKZ+ih1ahIJOJQ+tZt5b7qNldXZsSFIX7?=
 =?us-ascii?Q?WLp4caC7ZCA+NW+hygLOm1zQgIQmE+3+8Cy2Fcr5u0y2Y/0q8ngcnZ0r3xtf?=
 =?us-ascii?Q?JevM1nN/XoRaKBEUcyZRI8Rf9nNQxGhUFoculVPk8zVRhJ2X4dgSwQYYw/wN?=
 =?us-ascii?Q?pMWX4mBNnc6AcjI31WSG/5rIsAIrKUkcUsPj5U4fxTWysbsdtiG/+bnwAcIq?=
 =?us-ascii?Q?JJWc9CVGoM8QNchCqhCPneiBS4tSt6BzXoi3f+Yrpv+kzrD3yXdskPWsR+uy?=
 =?us-ascii?Q?9eqVRPMdwmEwg3fGapmMjcFQcLCV+ZVl5Lb7DpuR4++O2JplNi1aAKmexBW/?=
 =?us-ascii?Q?LVZLJ9eAUba8EFz2XbBNmCJJFN+4yX5mXRWg8dyiKF3YHhgWcyn+wlPDxp9V?=
 =?us-ascii?Q?Uf0R/FEjHFpkjd2fTYmuf9m1qCCT1d/fqw7kGI/svmtmrL3jqriQrUYOfKsS?=
 =?us-ascii?Q?pnh83mBUkszr27WSFkITEZBIS2qtrJvEAn72dcjxv9LTglT1VkWIe/aon67w?=
 =?us-ascii?Q?VIenwoha/rViWCUDZRrw1l1Wy1BdjohfFCRsvO+/z1nVZ6P3C2sRVCIhueOe?=
 =?us-ascii?Q?QWWWyh/EGUPADA8CcOxZrxb+rPZSWEyQvNjYD20rL4Y4Zke9AP4D5dIzLa++?=
 =?us-ascii?Q?zlq3VtpM5a+fmyksGKhtTclq5J2PsWQKhm0tXsbtvDXrKk/G6Recpmt684JI?=
 =?us-ascii?Q?K19FHkwTPJvpQqa0u5Wu/AVQNHE4Rhhbjpbph717leglgylwRXxFx9SuUP/D?=
 =?us-ascii?Q?QEkhJKJ1NrfNf+NkO2hBqGUJ62rqv8Nnpli6eMGbvtfNdLKYfxKy9jCCdThW?=
 =?us-ascii?Q?sVXVP8KT1Zh6o1w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2QUkrzeGlH2+4bedx6mvktd2GRY9XceSNpQAD9hLmmMycfq8pOkXaG855Ck?=
 =?us-ascii?Q?IP3acfAbH0gNrs0f1t9POdwkJRzWXi0T2+pUzv19phEYC46g1munU/nshPVf?=
 =?us-ascii?Q?bpTBk0mj9fStEaeRnatGJFdvGgS0zACidu2d64sEQDy5ThyiWE3n/mX25Pws?=
 =?us-ascii?Q?yTTX/5TwLUwfaJnGV9tbXsEjrwJ5RM0gW51wS1hE9nhDL2lmJr68pHvDhi7z?=
 =?us-ascii?Q?qY48usm7edSUIJjWLL4SvrFp712gHYA3yYfbaiCgcyq5JFv4BeCqGX5bQ1up?=
 =?us-ascii?Q?Zl9Wv7mKBpm3B9K9oluTyRI8Ve8kMcWO6OQtwRnxLAmAIfNdt+kazeqnDkCC?=
 =?us-ascii?Q?Va9K0WKl3whlqqEsaN4nNzoMQW1Ydi1FkL1TI2mqiAGBAJDazExyKcM9PwQC?=
 =?us-ascii?Q?9ejEs505RtkxPOG5aVPiCpw67JzUPB074fScTLsCxZpYAOjyH1tDcoVEH9pj?=
 =?us-ascii?Q?2WDezrrhStyljlRRrFmziWLPmuW09dqvjqCYZPG0+tgnmZf3kUi7K0gYyXt8?=
 =?us-ascii?Q?bSitpRU9HSmCJ+KTukn35h5Gp+jZ74WsyLB3lYzc8cs0oj10IErgCVhgaJhY?=
 =?us-ascii?Q?PNBZvB3ug6gb3aHkBjeBLhIJBt3PlX+eLhSCubAlcuJkp2tcjErZPEzDQLhv?=
 =?us-ascii?Q?j4DqbVif6p1dsUCwUgfbBM2IXHTgPJQaf2RB8dkF5BkyW+qMUZV0MKcTXC17?=
 =?us-ascii?Q?x9s4oKUgHKgsd1Y/mGphX/iOem6dj1I8NeTGKsgXYFe0isssDIkA9IO8GEXQ?=
 =?us-ascii?Q?Jfuyg+cgDGRZIYR+YcrkOR7pPSLCxwXwp+FH/DRNHQopm/d7E0qmD5ciP3hf?=
 =?us-ascii?Q?Yp47AL65dY9TBV4WgwlG1d6xhUym3ng+qksHtpfuUhGZXrWiCl/BVOHXvBkx?=
 =?us-ascii?Q?W02VTUR1eJ2uwKNy2OrEHskjZUQRfmhzPJik4mrylFNp2hd8/MLfb6mlFgXJ?=
 =?us-ascii?Q?UpXCY8VrLJvJslgi/ZDavJgJIUNx3OBu4+lBoZ/dtA8Kwfp9nE5LF4RAebIl?=
 =?us-ascii?Q?qMY4EZRicq3Z8Vbd7bfrN5puJklS6k5uPzJ+Ro2wQN+IMDrsBxvO985o6lR0?=
 =?us-ascii?Q?X7zqqpAqDOd3klH4Y090/RsInMiiarT4G6FjCyyrb3MnGiBS5wHgarlXDSPH?=
 =?us-ascii?Q?Hg8RNxc6lJAkLfjh4zGH37UXHmQvdPsGzV+4U4VCyhHtaXui/8pqqB7M0gR6?=
 =?us-ascii?Q?p/J5hQrJllmPRbXse9V5afCXcLzPYEngQmccfRN9lZp5620TjRJv0RMTOvm+?=
 =?us-ascii?Q?hb0VPh2c9KGcAkE3RwUKNkjJ3e/4Puj2lcP2yVeAc70z7WWd+cz1F+bbzL/z?=
 =?us-ascii?Q?VSOfBNkKC7g8CnRdYRr4HiO4Z1eNZqVc8HsG+4l3uJ/u6VC3DhFtG9K5rHxo?=
 =?us-ascii?Q?iXAPT83QYpK92237Vs8zl6Q7GNc1puj87oo3E1pFQ+OcO3WSi0yeJCW7a9B1?=
 =?us-ascii?Q?sL/1YLdTHHu3piaUhttevKIRBilMn4GEar7251i+skyMElUZBFt1A8J2HjaI?=
 =?us-ascii?Q?KlNSwmf6opfn+xeM//tNRf+0FUUo3wbdrzNN1sToe1WUpuHRSNqkdxSE8Q8W?=
 =?us-ascii?Q?xM5N1o5loKk7j4y9aAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9b0ef3-ff18-4c18-ee8a-08ddb90791ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 01:27:12.0376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmsSsNC5wLikjFezYCMCJfg9AV10jYQNMEUkXAPGHi/NleybhnHYJuy6lC0q7pThNo5Rf6N5pBbAPxzDwYP61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
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

> Subject: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_BLOB
>=20
> In order for this command to build we need to compile
> drivers/crypto/fsl/fsl_blob.c and this in turn includes
> drivers/crypto/fsl/jr.h which references "ccsr_sec_t" which is only a
> defined type for SYS_FSL_SEC_COMPAT >=3D 4. Express that requirement
> in Kconfig as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
