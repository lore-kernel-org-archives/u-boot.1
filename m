Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C44C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A2E81951;
	Tue, 18 Mar 2025 06:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OgiwwREW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F08E80F70; Tue, 18 Mar 2025 04:06:52 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C035780077
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkohFb5Tyfjh701uApV7JTvlUnwFPXZrnHBzRnKrdAZKAmCA5ztOSuba+eGxPYf4k7JqCBLgovLvRXin8Eo1l19/UZo3b1oFmcYlxh13BTdjTWwcM4b2l8ZvaMsWi7VB/Fw/JYwWohG3woGs8pQ1ZccaAac4NEKVpW0rh1FBoSrXW4sqzDGHrCqzXpaD9AU1gO7QT0XgQrlTdHE1C2Bw90E8NC4PghgtXOaMjlDpSeMJ0h6EqmRpu9J6Aknh8AMR0FEuB4WJBSZMYvcm9gBL1M5/U0KNjb3kPE04NNa6DlCq3IeRroTnB8soxH2hgMSsOAxwwcB/XZUFS8gGycivgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCAuJZTMSVduigxS5HgRnu34eHqxTO5URGizVVhaUlA=;
 b=PzV6MtrHAXKZKeH/nKttsLJOf+5b+KPJYLKy7+TkKuKUC4fgggXR1uly85W4KgD1t99b23nCezFfDlG8FNAQhWGH9819SRqsrAc5xE0gXnYWU5t/T6l9s7CEQZL0th8VjRXBEhFgDOtV9l2vA61e/EUKhmqctGxx53R5CJiGg3pwluuw+yi5yq9kwauf5kghB4NIZLzIvS13Jy9+F/jjFdfvKYX69NMZe0cmHxyi9zWYG8MgB5ahsJJN7nLbTqsp5hJcqBNtEthscEB+5WLDZ+maypFE+4+S6DI4I0Q2x6IoWUAalmeRJNXvpWV+TSCCb3XrUttEZ/1ubvQUHHp1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCAuJZTMSVduigxS5HgRnu34eHqxTO5URGizVVhaUlA=;
 b=OgiwwREWfkzI0Nl7B8vboVgam32rc+1HjF2I//Hj43AVyOB0bg0PiBZG8y3Gei8TiRPzlYAoUekv80ROh8Qwx4VH/v4CMHq7kmxvlOejBYmDtSrSVyZUiAGWyhI09nznXTSKL10z0Nzl9d7NOGcZko1c8Vk27VMDlgd0fKhYa+xeLr5qDNVJ0Vp1zOTqCrh91EfXIu5w/W0XybsLM3Yeip2vHysFRo/Ocjc90Wyfm1fRdNoPJzyFF/rKH6ODm76icY7pT4nxehMJKjngjaCQGjKOIYZhQ7u/18DHDwjuqbSphYwXC8yk1jtwbYkzS6FokqOsbcdZl6rCS1JivC1RsQ==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by SJ0PR03MB6876.namprd03.prod.outlook.com (2603:10b6:a03:43b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:06:46 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:06:46 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v2 10/13] cmd: Enabled Kconfig and Makefile for DWI3C cmd
 support
Thread-Topic: [resend v2 10/13] cmd: Enabled Kconfig and Makefile for DWI3C
 cmd support
Thread-Index: AQHblJcJBpppG8cZtE6Aey+VZCSiSLNy2igAgAVhymA=
Date: Tue, 18 Mar 2025 03:06:46 +0000
Message-ID: <SA1PR03MB6370AAA6B2F6B3006B736D6EF7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-11-dinesh.maniyam@altera.com>
 <20250314165354.GB2640854@bill-the-cat>
In-Reply-To: <20250314165354.GB2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|SJ0PR03MB6876:EE_
x-ms-office365-filtering-correlation-id: 9b872009-9fcc-498b-5e1a-08dd65c9eb22
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wY0Zwi3ccmC+94E6PnaaiiQOWLNknQlczMKMPIxaEYV8/23sQ4y18p1BkqWw?=
 =?us-ascii?Q?j3QKB16S4JHTymRcqR/etoKivXdJkoIG+jDtmuMbQJrZJJWG3aLOCm9XSSN5?=
 =?us-ascii?Q?mG5ve+pnyMDY0LpMuvvWIf/8ItFF2GQizJfiBczthwTpIaBs3kdDJtKluwE/?=
 =?us-ascii?Q?A8xHqV5B5n+LZalhtcYqvR9tfD/jwJafe3cwgfA/Hdv/3Ni5yHCDYejLLCMx?=
 =?us-ascii?Q?w5LVezOHJCejxdJ1IlG/haNz+0DUuigvkIGQExIXBW/41m3oF7aW7iWy+kMK?=
 =?us-ascii?Q?FKN8w46fymTfHMFPdJzDLk894Bl3s5zzBw+V06/svtR44fM+/P8STbPl6Ovo?=
 =?us-ascii?Q?4PYyv7Q/XW81JKgimsQq5g/t0NCLrlps9wiS0XUDxkYFvSP7QDealuqlWGJ3?=
 =?us-ascii?Q?Fx7HIGdJfANfZ42+yznruksRQ4wvQF2lAuDn/+M0mmiwoGmFadodUR5fHNC2?=
 =?us-ascii?Q?jQYh0f5E5/FBKcN1f1mjJeGoQJdB/vQfoBDmAZgrnlImG/9KYEcMtrJbzwi2?=
 =?us-ascii?Q?7V9WioJdFKbIhkVF6bXBgpV/M8gF1moQmuSeiFqbHwHzl+sfPhQkSqRf5VlN?=
 =?us-ascii?Q?hhhaXNoV77UI/PYD8/UlgrVZVj3qMy9Uzm6Lzu7aYmm9REnAkzzwRTaTo/+3?=
 =?us-ascii?Q?SH0Etm73OF6bAzNJm3FBKUCsVjwmfpA6wkms0EiKHldWsdLtNDrTr1XhGOeE?=
 =?us-ascii?Q?Hg1zPxYxD0GHKOWl5OJDu2Uc3aiYi4d3u4lQkxg2F1+4blmAQTGRi7WdI1oN?=
 =?us-ascii?Q?WFiOWh1/I/sRqVSZ3tcwaOtsUPQmSM5iR3yoo6lQpTmGfUMpzM2JXR9vBJD/?=
 =?us-ascii?Q?F8myBZBhG7TVdyi8xXAw1fwz/FByvw4WaCHyUDLEwUqyz1l2Y9pxNg5RYH6B?=
 =?us-ascii?Q?TGJ4h/hc2eeuXixYvCJGuEj9hjcP8sFC9TAo1NC7YRmRel2Np2DTh0VzXUeK?=
 =?us-ascii?Q?FaC3sgzVSpDTl+ySufAlRxpMBEmtbH6ZVX3H6usgJxqvPC0Q/0QaR9N+HvOz?=
 =?us-ascii?Q?zF1KmYf1gj68hnedORTHW3GG7pMvYsAfbtEcxlkRKU6AbuisLkOXQFKSPORJ?=
 =?us-ascii?Q?BXc2QcTI0gzjl/b0AF4btdia2l2wbGIJ0ocJ904SMUFCL9NFJYl/XFZ/d33q?=
 =?us-ascii?Q?PNv/kx8Rdq53P3nGnmJUST6P9/dBUjCQLYgcRcWTYARR/EBTH125eevMERHD?=
 =?us-ascii?Q?ZYt+Fg5dIl+u9is9eSGHrFurZu7mm0QalFVHo2PQOO/4jJ3N5PylyYZ8oVus?=
 =?us-ascii?Q?19AHwQN8jclf3SuV8Of89RHK5BrLOZB1XZzguiPdeM1LhhBgU/lY0M1rp6OZ?=
 =?us-ascii?Q?o8KNRf3Wnfpahv3EcH574alZhkAQdDBDTff/G+K6qt0oGe1SrU6Z+/MUll8G?=
 =?us-ascii?Q?hYDOclLZM0RYmvACxVmdbwRZXCFprG+qWQ2EGjAakdF9EBbfNZSEFS6o0e23?=
 =?us-ascii?Q?pBw+zzvhvqyde+Rt6vCv7tdqqClzxLKo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IONI0eP515KB8+/6VAhun+7lmj8u7AG7PlT3m2AWCAqJFx+dsddAyBqizAJq?=
 =?us-ascii?Q?6dNn3DFdBEKqjpTIzPNqLPChQ/Ko4+ztdo0h9400TLyDZ1KZ6EKJBMqFPRez?=
 =?us-ascii?Q?kPHF7vV2IUVn9v8Y9Pvy+NyyuTkY34tM1Qs/HahwCYK4xHXNKqEtUaMOAyeZ?=
 =?us-ascii?Q?5TtpJzFDUFrC6JwKSLXz8IyXo578oB5qJF9TkNbNa1m/skQtjfsfUVeqyfVr?=
 =?us-ascii?Q?AxLbWS4lNswUnS4BdzL2joWuWTldinfqLXJovrAKwRvIC2KEC6HKgKlag5yb?=
 =?us-ascii?Q?lxlA1fzlRt0Ks6juwYBbFXCLWjQUK1XYvFqigZQrTYdEZL4Hj3dFG1c5KKY8?=
 =?us-ascii?Q?ALWTOrGjoWozFwXxpcUcbs2/ltFq4TbKOEbUtHT77qKpPMvxyavP0YWtzl+y?=
 =?us-ascii?Q?5t025GLXUngrL12IO2F8s6dNFdbQSfb/griFGqWpI7NjJmRfXJKXnlzs3+cu?=
 =?us-ascii?Q?VijFAQMQ+5QB0EM8iRNxqEtkeQbrJTsPiudERltgcvZrQQp1h3agsTLGtSxA?=
 =?us-ascii?Q?ztg+qY13p4sVIp2F3VBsL74VDQw/yvouTdPylT9FmcGkpYmx6T4+o8BqPLLX?=
 =?us-ascii?Q?mU5zHEqDES4oFt+uhiV3vpB6eGpi2dHZRd7YMu4HdgBIXXUEWVwYpsDN7H5Y?=
 =?us-ascii?Q?MSXYlIIhK8LbzsoZJ/rZD8vRQ7XVXNRhZSGBXQPMEdm8nFgsmZeAQPlbA3F6?=
 =?us-ascii?Q?lZS6slRemRn8/Dh4+mC2iLV++rEOxuOYhoSel4rbwen2AgWRXFRov3VZYXYI?=
 =?us-ascii?Q?reTYI5M9u+30q6JazvZY4Pou+6Nln6gWH043cKoJaF7uyw+Vic06HzXf8wgV?=
 =?us-ascii?Q?UxPowKfuSQj5v4pcK103s6XUnnB4SAp7HmsIZ9JGGINwVAoGAO3gTJxn09p4?=
 =?us-ascii?Q?oOUOSO8eRxUK+MQk6pbK/iR8tsQHK7u2E4G4z3nNTOxC2Ff/uY/Qs2m2bsdq?=
 =?us-ascii?Q?r1BnsfgiSo4UMQbjg/KjinXktKEISF++zbCVxsY+jiIY45722AnFKpSyqjtz?=
 =?us-ascii?Q?MQ9goywbSiySrj2SXw6EAED3aqIPcRkX4ohih3EPr3YrJssdLdRBovg3UnJY?=
 =?us-ascii?Q?LilS5XoBF9IKSoPTKtT9gvyRzm7+5Rvf2IHJ7+FSf91HXf/AE+5bVLSANyNG?=
 =?us-ascii?Q?/4eCxF965xifoXSl6juKRiEwSkt8M8WNW7hRtuI0t4RAcgCDsH/MvCfMdzVh?=
 =?us-ascii?Q?1eiumzue/ZchmmSIPPf8Adl2ozEtbRJ1ngu0J20tOFauMdS+z+rK6YxvG+L/?=
 =?us-ascii?Q?8unD/+sFJcNlZhhWKrxTMDtUASepW1cPA7G+ueCdRObsS4ZOOmLsM1K5+Nbe?=
 =?us-ascii?Q?umlz/Li6EA86q3SRYvsg1OspaYo97uHSZCdk/eU69jS/H3bWUkAtt++Qugpq?=
 =?us-ascii?Q?YH3pPFOdiVJLEO6IyBKeKrCIcXLgfDMHdc8KCx/MSo0dDGtgWpJqsXztzbPb?=
 =?us-ascii?Q?qZz53viqXT2JmkQSputRkMxCVVWB8fQstLzlZ0fYLisug1njrBNE+FIcRfBK?=
 =?us-ascii?Q?8mKwyXL40HrwdElkrppYuwkcgh4WnkT7KhtUS3/yDyIe56GDuDR/me9BdcFX?=
 =?us-ascii?Q?pCV6W/zMfU/7xpbOG1ZzzlS0ZUL+kBQpTmZ34/ANyn1BoC6Mw3MrxSxq5Uhq?=
 =?us-ascii?Q?xgWQ+gg+S5WRaCzLk5RTpiuLuO0iyJV3jmA1OQpYNE2Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b872009-9fcc-498b-5e1a-08dd65c9eb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:06:46.3998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOwcK1E4P6uFHdOJB+bwtZTO1pRw5p7367zxLwdGkLesLsICogTfNPoMGg8v22URKZ8yNm4Z3nG6GGuYr2fRM3AZEO7vjQg44rOuMjGC4V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6876
X-Mailman-Approved-At: Tue, 18 Mar 2025 06:02:03 +0100
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Saturday, 15 March 2025 12:54 am
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v2 10/13] cmd: Enabled Kconfig and Makefile for DWI3=
C
> cmd support
>=20
> On Fri, Mar 14, 2025 at 12:08:59PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Enable the Kconfig and Makefile for the DWI3C driver cmd support.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  cmd/Kconfig  | 6 ++++++
> >  cmd/Makefile | 1 +
> >  2 files changed, 7 insertions(+)
>=20
> This should be part of the commit that introduces the code. Please check =
the
> series for other places where patches should be refactored to not increas=
e the
> patch count unnecessarily.
>=20
> --
> Tom

Agreed. I will note this to make sure
this commit is a part of the code that introduced the code.
I will do the rework.
Thanks.

Dinesh
