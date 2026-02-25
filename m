Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38997EFD211
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5FC8366F;
	Wed, 25 Feb 2026 10:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OHrK4LrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757F483AA9; Wed, 25 Feb 2026 10:18:52 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8255682A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEjByuvmVrJrEY81yPPce8yrnUfaGP4iZoUsMBU+h/r3tTQ5RX/Vn4/hWoqVYe0yO6+f/fL3qOeNIjO1GTg0sc2e5vHyb3AuEcJFyapwEHX0O+QtelNJRErVxOuJ9WCA1j2Vb48TG4oxx/X4aQqcnoaVhAu3Jve9xUmgpbTuxVSOZV+Gfu5cXkceS+rrgAc3B9wQCDQt/B+xn+7izYLho9BIVQ8LBPwfyNsvnBRl3YQnLI+k7CP1WlWHfAhgEKO9d3fCgV3sCpP/u7X42CNKxS2qhh3CKw0+zLyG6X/Ho1WWvlKP8w5SMa/yfvITPaPud3Kk1HO6BINS5MxggSOSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7dkCGntz+aFTE4VY/KWvuzyNz9arvtQnvqwzG5mp4A=;
 b=EMLIzA9+Y80V4cSYwCQ0/j9XQqDgpaEOccfmqGy61ew4MGsg8yuDKAxlg6UhcTAncoV6nN7ReZX8i6stCXef+T9Vdvt+AchfA7bpzIwzZL9SnaE2sO1P5Io8AVgoiDIHk9GfHTfaiuatP9Ofa2dLtycmJcijL2G+PnM1hcomXBF6Y7MAvHjiNdTaRZ3W6B/AJc0IdbGvkVCuxX86AqifM6dRd6FmGTSj/LVaeudi4WSfq/mg1FbfiOcAMH46bWddaHyg3F5jMO2fQvAm2GP4hp6lb4x+k/tmb6xOL1pWBmGVMO7eW0P2t0V/VazQ9bhxOhJpUv4TnSUgNmdIkdTNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7dkCGntz+aFTE4VY/KWvuzyNz9arvtQnvqwzG5mp4A=;
 b=OHrK4LrIN9JisTif5gf9OtsV5TYoVCle4JQmtVjqTFCkPP24GCTkdkdwv0bZKeEANHeN3+eqzMkP+lBpe62QdhsTVpuHQhH7i3S4a80cgVHHVq2sDkvI5cD4ig8bn9Gqia2IEMcJ8Pgva8pQj0jOg0xM4q+VdTuCWmvS5+QWy3C5FfvdGbLeWXhUk+ioWbu8jvSnJOF11aNgS+PS9+MCs46IV+ASsyTsM2u2vTSJVp21ZfbOmErmtv3BgAojw6M3gB+EH4XmoXJism+l182tNkNjToabun54rkC0+m6ppqFBmty8yHhPHMTc01ngemekSWuH9Ruoz5696UK7tL5c2Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:18:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:18:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Justin Klaassen <justin@tidylabs.net>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Samuel Holland <samuel@sholland.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
Thread-Topic: [PATCH 1/1] drivers/power/regulator: add
 SPL_DM_REGULATOR_FAN53555
Thread-Index: AQHcpiP9RdFrbpetfUSWFiyXnGbtCLWTIoUA
Date: Wed, 25 Feb 2026 09:18:44 +0000
Message-ID: <PAXPR04MB845971411F638439DCB5F2978875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8541:EE_
x-ms-office365-filtering-correlation-id: 01c23556-8b96-488a-8855-08de744edf9d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: Thf7lDXv2CqYvclRkvDv1KyBOaWpByrHyULpiHknpR1GIXPeRcBpGwxmBGKD4nf6ef3LgvsLJkQ9gTUZReUkXuDfBMgmeLHgfCFBJxBDK6pJrjNPyuOB1u1VPhdhbwkx5VQb+EnsocnCLtEd2lqk+Hdqru3txeX5CyLLfsacgE1HjnH/2eGfGBPEhH0brmaOvWLtG4g3ANEkfJASjacEhVBc/SGO6aaHdAAbfRo8Uzz8DFRQ6m/d9z7sPEswSNEtxaM4+Pv2GhsE4DCBbDO0Jww8KgAWbe4q0rmfolCYphrrBA6fWa6SPj4Ou6/NSeIYtFUviFrIj+Nt0hY4hoU/uOeLFRh2XXX8zrEyuikdo5KT2vpjZ605uz3A8BPvATTGWyRrn3zsTIek9Nx46fkJwAuHu8uDT3/ese4K/MIQ7UCWLpAL3bt3ITrxeC7nJSK4z0WgUaxll4AkaNgPDKJQdSLpRJ7fwaXS5BmjnKYExMbVEvGTGpK2VAlDVoGrOkCY/6/TR6rNiP+42IxqsB3mnGIXn0JKSHe5qxYYqxkXIlLxe6r3kRIIMhbdK/9123tD8x9r6ooF66/rLdrCUOVunriWXKhCs1P1mc4BhnYdkyOainWb6Ov6PMEsyMc0l81arfSCiEkZ2NSq4kxIp8YgxE4fgDOMRNzr77AvuLJncOJjZUe973QyNdI6+8Stckt++eGbc2OpP4I/MQhbg6pJ/W4qQ7xFvsj7fVUzLk1k+tR4oyxm+zB+5RxOIG1bW164eY6yu+WJCay5S4sLtX1Rj8cFYNpLOj5pfKahEd2Uqe8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TzneJ1JwIT83z9mH3I1sCEjS8DAtL8mSwgDIkYuJ7sejGKIPE/PUo7sFvfYR?=
 =?us-ascii?Q?fGH//YRzeLIKdfGywi04U4s3g+vPeG/ES0siHYwM/y7LcnMQ+xv5DAEtdCgZ?=
 =?us-ascii?Q?B4MhvsZZU+Lwl9tR2Prr8PsbZSDnqe5TFKVCUP024XomF5aJ6sEsT/nTYDMd?=
 =?us-ascii?Q?6HPVFZ/puISfaF3B95QHhWjiCSuWfqK2/VRjdHQC62j2mBABbrX7vdlFjLvK?=
 =?us-ascii?Q?0Xb2b8z7eKxQl4P9oMx9E80yw1tV3x3t8iQrMNkcixkotaiKffls0t5iBPs7?=
 =?us-ascii?Q?teAfnwZkjqGK77Sr1aywGt9zGJE3Fu0owIuyZoknNpEi/KFRCwIuh2+3I229?=
 =?us-ascii?Q?SN0wXQ7uJMmUB8ZK9URYABm0HV3fOByL50vI16sOiLYnfSwYPlBThnKYf+S6?=
 =?us-ascii?Q?Xfre5A88WqxgtfRXmreauqEjJS/Pk8aDOUhKH2q59zIBqKUc6FyOI1sZfOxf?=
 =?us-ascii?Q?K/o/uzs6mxu0X1SPN7KZYKFCsJT78glSfNYjx+Qn3UeTUgirCz3+V6cDy/FW?=
 =?us-ascii?Q?xoFoSNEm3aft3c1XyxSb77QntI16L4KNZNvD5DzVPr/SLw1lLOLlMpBnlWum?=
 =?us-ascii?Q?EvzGrup0m5UzY5IwgNSaAuaBw58aB7NGgEb0d3qI5gT86T1eE+Lt5cxMq39N?=
 =?us-ascii?Q?z+st0bi3Vw6ycYwaI73iovcdiENGJvna+vCuXP3iFwbHIu2e880WE/lk2v4L?=
 =?us-ascii?Q?czTsvp068A3mQS3ETKhxPg0I/4rywTh64bPKQbOR722WqzaZOoSb1XsLi2LG?=
 =?us-ascii?Q?IFAbvD+Zx9iTDE644xYWeH3DxilWnFYWyknN2J1di6jnHeSX7LYDcMrgsEOF?=
 =?us-ascii?Q?WHl+wthjvABFn5/oo1CjkZSHrPXFNst8IlDA9pilJ7QlBwLgMqP6NsvcSVta?=
 =?us-ascii?Q?5ptIeykP30YiaSFRs5oyw87jMfWpWrsdq2Oxn+j3ZapltAmj3BaOlFNId9MI?=
 =?us-ascii?Q?eCowcGyKG8fD0e6rdkCST/y1PUM4TdHrXJ2TUxQXsSDspt/1Lj62G2jX/hU7?=
 =?us-ascii?Q?/iTJeEZl/8QOx/ZB0bJBSe/BobIUQxivIHWTMv7hP9nLeL1KU94SR9bE6HKa?=
 =?us-ascii?Q?w8ep9skOieo9+5stNlWTJqB8qAYu24ULeq/85CBXtzdwwXxyauj90w6JmTa1?=
 =?us-ascii?Q?to+cqfxZlFymzslJPd1jBsjMzlbWa2j0d5e6dyuwsAVLULROgb0dJJwUJwa9?=
 =?us-ascii?Q?jv20Zf6a6Z2JAsnBvPzC0V4uG35JYPE+maHc9Jy5X2NMiD5IkQJhITodZfs/?=
 =?us-ascii?Q?IW9tSqIba/N43tsPIN10ZWz5OQaQ6F8TPlrNNy8qBp5/QefQnW2squZViYhg?=
 =?us-ascii?Q?hsWnayXOL+JzfKvwbs45/MYCa0A0KLwCuKD0hVNo1JuFq0VjwFzoc3hrdgxW?=
 =?us-ascii?Q?UHLEegq1TLrEEIUaiocsy7gmAGDTaY96iy5HowU80SgQoxdkis98ObAQpMd3?=
 =?us-ascii?Q?xnrCgS7etlDO/AQTkbNvppenL84Pwv6bdINLUEn+RmLnziqjr7GGeIgLA4TJ?=
 =?us-ascii?Q?ncfOCL0I6obTcLnDGzszeLDmV540l0vW29Es+wLuTThvudb/FORk0MPP7Fqm?=
 =?us-ascii?Q?X2raUXisRsN2UVji8yU0Brok97lPKxKhPsBDVkhAwQm+sQ0Chy4sF4VLQ3/1?=
 =?us-ascii?Q?BDn5PRRK73YLB6gcd9mlox7w4RGfp5NhpFnnLLOBqqz9gYL+ES1/O0lElDVS?=
 =?us-ascii?Q?i0lJSGFyJyNwNqDvWHltCIKR0QqWUBPvYze8PwHnRIAkjq0B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c23556-8b96-488a-8855-08de744edf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 09:18:44.1014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6ueDRQ3Ih5UbvUyogtgXtygWhe5PfyKmwDr4bJjsTDoU8gH98zaSlODex9vvyFnKuft2gaJ2jik9ZlihqXI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541
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

Hi Heinrich,

Thanks for your patch!

> Subject: [PATCH 1/1] drivers/power/regulator: add
> SPL_DM_REGULATOR_FAN53555
>=20

Prefer subject: "power: regulator: Kconfig: add SPL_DM_REGULATOR_FAN53555"

> Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
> SPL_DM_PMIC_FAN53555 and used in a Makefile. But the symbol
> definition is missing.
>=20
> Add the missing configuration symbol.
>=20
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>

No need resend, I will update subject when apply.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks
Peng.
