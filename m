Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E86C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 02:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874EB889C5;
	Tue, 20 Aug 2024 04:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JrKmoAJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A31F88A1E; Tue, 20 Aug 2024 04:19:16 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9D5889C5
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 04:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgbcxKm610dMGGjcxVXPsqI/T1q0tHsNEpDvWqQ5Cot/5apnotS8muz7PE7Ov/XazhCslIimS4BM7K+Yc+55D1lv0AjufADZEBUh3AAgZ75If5ojV6TAYSHa681FW1nycX+GEUrytL9UwQleLW6zIS8yDjOeTeNN8sxTXtp4kDoagdPA14k+Ncz3iN1qatoAT6br6R6y64G+gXIJKiBSmQ1FNUMS4iYkpuz7HLpKBOGxRev7q5q0J4OPU5Q9HrZ/EiKUc+H1lm4KqNySuu2EelmRN/1Otr70kDYDxl0v274MFhwDlEPGe/mbQeD7/gRBS1eTLiyNf+ieRQkiSwOXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I65Q6SWAWIp9Z7I3k26yVXfmwhoILjmdKrqPzrXmdn4=;
 b=Fm2pZiT53meAmZ5V9bUUs+ODGSQ55XLcF9Me74ZCNHouSWhJtsDd0GwsD1+IkJdB/G1+rfnrPQ7VLE/SzxfdBzrMGG2IttviRHEdXTuNYxz1pex4szTT7J1AHOTdE6QfXp/YOYleia8P3cN1XPYncYOqZFADFatk2NX8gnpJY+RU6Tvqxxh8/OcxvZC7b3yRcqhnCFn6efWshzRv/WXstXMgyqsn4hFiDabLqPvlRAq3UBy4SKIsCuix2DW8CRas8mZE1FbpWHDw2/juwqG/MbHoGClSfZDqgmrN6mZzEaueGNte7osvKD3Ff3VOwgD5+3zacgYgthntl7I7pAJ8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I65Q6SWAWIp9Z7I3k26yVXfmwhoILjmdKrqPzrXmdn4=;
 b=JrKmoAJzxDBlA1W2jhiC4UHrjuUGuxZo7JvdgKItj5A3BC+5Yq+iIVXC5cCrXYTe1qVROE8/despeLLfx5JBpMO+6IfYpYpzV0VP2fohRal+tpLfVNksQ8gyCpq/lX7uCpqWjzEWM0HH6IEvhmTvwIU4JNVJGizuXyR/8PNY7m/FV5EDdlsZL4PAykxxxaYL/jmlIZ7diTUvjFqo6YYSSWw2VhXHx57wP4uiB/hW+E5oQQ2iRiankySkMYRFv8uxaqtPMqHO6F+ystTyKTv9hkX1XoqZK80Jfj4tFR2jL7p1NCreM7uazwZAzN4w3S0H0gsZp9/NeYeut3mNK3T0qQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7847.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 02:19:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:19:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH] mx6: Expand bmode to support ecspi3 boot
Thread-Topic: [PATCH] mx6: Expand bmode to support ecspi3 boot
Thread-Index: AQHa8NmIEfZ8wh1AkEy8jsJz72dIWbIvbOSg
Date: Tue, 20 Aug 2024 02:19:13 +0000
Message-ID: <PAXPR04MB845923227ACE7CADF2392AFC888D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240817191313.844479-1-festevam@gmail.com>
In-Reply-To: <20240817191313.844479-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7847:EE_
x-ms-office365-filtering-correlation-id: db51b25c-4e20-479d-f24f-08dcc0be7bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XNEmhkcbSxD3RK32eIAkqovCoy3EQaEfImnNqJ6j14H2555zejgbTRlckfaB?=
 =?us-ascii?Q?N0+bG1Ftf754kutAAxYH05kOvgvP76Dj3h2+iPtox7U2NP1/wDeZoVYv15m5?=
 =?us-ascii?Q?x4VMVsCGltK9IL/S0wrzGghaEhKOTdE6xSEiZFBxZs+YKjkogJREuwzJDwi4?=
 =?us-ascii?Q?801WX66MOrwa0IdT3Q5XdVD8u9oWoCLAcqk/bjvExmaQx80dPT9h0z3uL7NC?=
 =?us-ascii?Q?4Jw/lIHCgqQbDmH0AUH0DS8oy9rVYU3WPSKfpX5jbtaeujYEd7sqhLp1fzMY?=
 =?us-ascii?Q?Q07dWWD4HF0zT/zfjA1RAOkbSDZbIuSSA3UHnr729VMAl90ljgYpMK8vq305?=
 =?us-ascii?Q?gZTxJVU/feFJ2h12FlWEmYC8niX2d/Tf8B46mOKqdawWiNFMZPPNEQP5fyyV?=
 =?us-ascii?Q?l7+x7sH+Oam2MHniwdq38+Qq17R31mn+VCtwC3m2F17xXTw0IG5mF7HtO6Qt?=
 =?us-ascii?Q?0rql7rQDgKPS3zGmlasIxXlA+U+mwcUrg4J9CNsV1F5daP56NvdjEL+QUY4m?=
 =?us-ascii?Q?K81MG9vEZuhQ0DVKG+oii+A4+XZ1xLpolCq6DHmGY7iy5dEIffb/Xz7d3FVm?=
 =?us-ascii?Q?K/xwJDwIGTAMJp2gYsD//KTkCSHvNKXRF45nc/25k2not+DOja2mE9eYdfRh?=
 =?us-ascii?Q?qAFSHjOGXwlirI8Q3nrB4faoWVTiDeIq7/Y3Av79o7PPQ9p6VLiy/XUpws6a?=
 =?us-ascii?Q?3wTH2xT9o96LePNPSgYICsa5Mlljow0W70EKbm3PXFAv6p1w2Bb50U8BiOW+?=
 =?us-ascii?Q?LEhX1VSV4MHDrzrOVjhWDBlQeCJRWNZdyTA1UxDSkyuenXXFnYMv80IfsTlt?=
 =?us-ascii?Q?vz38Zk34m4k/LhWmhpO2TH2WpD0Ril69t0hsVuNbz+QxATi7AM7gAZAlLblQ?=
 =?us-ascii?Q?CxDPqqTg3BCyDAObZTjOVBnWdTlkSlM62zPinTNugqdkyglYm316cgZT4fmf?=
 =?us-ascii?Q?7v++ODYIGOsRdDDMQ3gzUB/it+Whb8zpbPlXsGggH9XpqqcCVDvPq+elY6Eo?=
 =?us-ascii?Q?zSCy+GPjr5ioTRUrSctNcVYgYJEWcexQS2WvnjRyl84Br7mn6eXbQMLRPhLU?=
 =?us-ascii?Q?Veyi9H4ISJlj5Iu/3d7Vtod0L9ZBbH7S8yMjuyCgqvUlrNOkCmIKNn07FRNx?=
 =?us-ascii?Q?9qlNdWmTgyAMHhu90dBeyPq+Yewn+J6DjniICayHVImb+HVEJXd3ollNU5dk?=
 =?us-ascii?Q?ii4kD+VsI+0ogZ7rnSGADDMsFOFEEGQE86KZNU9JPokt+iGVsJjf8hxbhtWK?=
 =?us-ascii?Q?5gu4tX2ZgfhL7HxVRSxDAgTq8qrAXKzIognDUD6BJobUvVXV0QhdBEoy4a6X?=
 =?us-ascii?Q?duv+LFWYd12k1y4DtkKkWi0C6tuGphvRfsik1332ZCG13gK+FkXAdxTsufG7?=
 =?us-ascii?Q?RGrtyCwVROV5D/Gwb8nAT7CcYXcjLLUMRV9F1d8yyImaAkaotg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPWfIy6ymPNGulmwEG5KXZevpvHATkGg8u/Faz9ykG1cCtUJhbXndI9bigO8?=
 =?us-ascii?Q?7qjC7qiPkIDQtmduF04wexUz0Dpy7HRC+8iwdRsF5noa49Jxp4O9l0XIGyrb?=
 =?us-ascii?Q?Ao7EOMBbrH4pb3q0ElAjt5wygDKkUc5ctTzuJAcpTPiLFgVsACF0cCum3XEW?=
 =?us-ascii?Q?tq7CboupWe+txGorSzpsRf3q5k7udzCsTwtUitjqsPhrtAJSGnrori7vyDg6?=
 =?us-ascii?Q?jI50LG7xKufd1/TH4N+ps1W60VBKosY6vFEchak3MT2Q9ML0gdrknpL3PSf1?=
 =?us-ascii?Q?ks49XBZEiqRtQsopBccSjmgHWA1+5POdZVUUiN4GEdYJmE99MaL8GECezRr2?=
 =?us-ascii?Q?N/yt25NNycpwPwuixHSLD/WDbO2tcfb9t/mXHfS8qcgeTe9n7CYfe2YGX4lV?=
 =?us-ascii?Q?z8dtmOvDqJ9lfyXoH/6Uvzq4CG/3rKm3OT+8dqAvZBmlkVHKrHnG69JYl5kz?=
 =?us-ascii?Q?46cdAUu9wdxOiq62f/LA8lAIj9cQmA+c0K4Qh/Lh9h/ag6Fco9szAhP2fzon?=
 =?us-ascii?Q?Wc+iqpIaBCeSO0bjnRmHIH16Awj8H2H9M83MH3/7AW0NlB18p3D3pB9VdBoB?=
 =?us-ascii?Q?x/ITVCTAp6jf3zVRe5qHjFcJnBbbOKr0VDWngJnDD1Qke/lR8NWXGDNFmyCF?=
 =?us-ascii?Q?lEYalr4npweMT+sA6Ckn2EpneBzFYfIFpyBvpIiI2yyP3afI8W3Uta/pNofb?=
 =?us-ascii?Q?87NsCD1fiFv0ZDsGmbD1Y5OhxR9j90Yp2xfby4I0/bGXag4lIWhkPVvoDo+o?=
 =?us-ascii?Q?8xA76S/akmQz4YgDiIolhdhKAfxe+Y2pv3tdxEUfdhmHxxE6mDrRx2tbi0Mj?=
 =?us-ascii?Q?63fiv9T1aHPUNJSoeOb3mph6z6hDjlANlLoBCiJQ0jez4yXuf0xMwpkJdTwP?=
 =?us-ascii?Q?xDptxQWGrStZy/0jYZCN9f4qoZ0rncUYSfM9bPYdZf38KoMEdmIegKTqf6nK?=
 =?us-ascii?Q?QtC2K2a8uw2s9yoUrJjEMuhibJZDfWt4WkMSeVdQsnBHkSEJeYZlWP/akOE8?=
 =?us-ascii?Q?vb13SttTIx/Lhnid2U0wkxOhCKk2gSfla1qAhq3OGdE5Qq9ba2meJl3/6b1d?=
 =?us-ascii?Q?fz59tSeXTthZ0wD0VDjwUf14Y2ZKkTkZ0WIVZVuDGOLMM2vGWVeSLyGbnOUG?=
 =?us-ascii?Q?JP+DP9FHBWsjwYqX9LSip0U6FmAXVJVAoF//MImjdN9VDSKmYSrMtxR+vsKY?=
 =?us-ascii?Q?C0aRhC+/xLzU0NqLw0Ri7rNQ4AMRBrxVP6wDO4DXxQAhHCk/EUi0Ch2PwTYm?=
 =?us-ascii?Q?+nCinOypxYb4fTdK9Zy6MVmWqeSrTp0wKFHdqKtJbvtJ7+Zdg/geNZbFFUy0?=
 =?us-ascii?Q?c7XaMwkDuYfhvnuv9nMxFTVYNY0Nmoc9OqEv3VHVV+5jChh3MYPsljJ+VY9u?=
 =?us-ascii?Q?IoxveG66u0M7f2XaawTD3t11CEz7KQJ6Xl4czL88J9/P/sXCeeFpNyvxCCkO?=
 =?us-ascii?Q?+ERiZHe8v58eOmDNHHk/K7SeJzyDW2F4ivxs9ZekVyz9fSFjNZ5AYUcncQta?=
 =?us-ascii?Q?RL5uotyQcKIjY8AW2kGSPXQ4ZvA37uuV4oC3tWH/Z5raz9k0rJBv5SoVjHhw?=
 =?us-ascii?Q?LvQaFAzaMRQ8NofFUzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db51b25c-4e20-479d-f24f-08dcc0be7bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:19:13.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqC/A848eeuqmYqi2/JAf6+vmP0h0y4+tRPBqJfpgtJ6H9oJWtvnBJ3TNYWH19IXOGE6uvL4+Ee+jRq/tF4rFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7847
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

> Subject: [PATCH] mx6: Expand bmode to support ecspi3 boot
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Currently, the bmode command only supports booting from ecspi1.
>=20
> Expand it to also support booting from ecspi3.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>


Acked-by: Peng Fan <peng.fan@nxp.com>

