Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72FACFA755
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 10:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CE388A0E;
	Fri,  4 Oct 2024 12:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="b6SsQUFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4333A88CC7; Fri,  4 Oct 2024 12:06:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E73488A0E
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 12:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMlw1Bd/9CUwsjVktqtmY7u67AHqUczkmtkZz0j95RIfTyDUYA7M9wPnGKKaXC/oNACpFnLbvGyBTHLd9WMuoB5TRM2NFoC/T+DNgyL+IDbEX7hnyAW7zYggrFKGzxlXlBIzKVPoWz1IpNrSklZv/dz5A8V+H25H2OEyNZvvzoeIns6Dl2HFa273jWbVumVhV3J/2A0PIfw8ODiq/Z/RCgCvXTx+z3a2pGXoRvxvhMSIQLwj1L4Hwk5aXeiSAaMgvPMQ5K4xutltBHAPGJfVCAjGrggypT0HcdTQvozBmEkHwiTuwYhGTeyOjvp5BYud1Q73q4PLiIMXpL8qi9nkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsK7/xZIqpryMRkN1EDRbzcIj7T9SZN7UuFat2wZvsI=;
 b=fxYsPjmhDqXhw1dNy51crKU6gkUXdK7ocb7J+pxOgaGnw8i+TylIeqUJD4/FX7FzkRd/xRIqh/ohBLr6cVPgpy2LFqs+TK6847hTt+7AHMeb4/rHHb6VPPAZ+mZI6qMtvVx5BwvQvwDbBJt15jzl0VMrToJ1Rh8IxVAHUh20WMtqtMj19T0p1tnJgbpP7enLOskOlR6Bq96jTW1wOHnuXYUZ/TrMrjdTT0q/sxTRlTVXEklRKdazvAs8v0cZaXPu5oZiev0dh+rK56E8fibrhCi/jdhNyKYD1qAN3GYXARpFxjNBogsr8Q7X2fbNer7fVCHfUg8U0KgS+LZHiZ3oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsK7/xZIqpryMRkN1EDRbzcIj7T9SZN7UuFat2wZvsI=;
 b=b6SsQUFjNT8gBoypU+79eOpG9AlRQMcAOYqpoTJ6njn0CLl/PCmoQX8cYkr3RlaXkYe2WnZ1c5NvfJRK4STq4aNyKkuOuqWrkkiMj3WUAfryyWJKeoFwkLQLu0l1BbOVrDIMjxQCW5iuj+VIEViWrAD5+cPDoP8rAwrKIX9/EIZv4p4E+UIIcjmo4/5EZBZNOttcfJTBEON5YulVVwPN/KcHBJ7YVAhRrO8NoC5mvZ9nS7PrAFI1WrqCyYSU2rdZXyYyPgdzu/8SYjE2lC0h4rOy+ZnL1StdGSmS/TWZ1llHyLcZ9gzFirIw/tcr2zrfgmbZWKXoU5SJnkeUHeDCgA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10773.eurprd04.prod.outlook.com (2603:10a6:150:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 10:06:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 10:06:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>
Subject: RE: [PATCH] ARM: imx: Drop bogus newline
Thread-Topic: [PATCH] ARM: imx: Drop bogus newline
Thread-Index: AQHbFQS6tNuAxN2fBkySFyK5ulJSIbJ2X/OQ
Date: Fri, 4 Oct 2024 10:06:17 +0000
Message-ID: <PAXPR04MB8459443B7A352FF89F428E4488722@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241002195304.21973-1-marex@denx.de>
In-Reply-To: <20241002195304.21973-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10773:EE_
x-ms-office365-filtering-correlation-id: e5f7f927-53d0-408b-878e-08dce45c304d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fqw021zlAEIhbKqwZd+vN4bVvxH2QpQ5F+l1jaZnh767DxiWpf858Y2RMvUv?=
 =?us-ascii?Q?M5gj6tJpPbFiEtFHR9xTbcVaD2xbYrgttkNwdRkuzowMoAs6Ngxxpqfo/UUd?=
 =?us-ascii?Q?ktFMRqE9in/3RpwC6rWOXcBU+wJDWM6dcmankwptzKThGtJI46ku/1wmn/ZZ?=
 =?us-ascii?Q?D04VBv1iZz7UHIB2w1EAl/9a/ZzYAUetdhq2bPOAHFVsAjflO/aVg3/9B8AT?=
 =?us-ascii?Q?tOt1phU/d7j+4I0luaSReOotvwI+oI3nuWm5H3dP5+6xoHGXU+cV1EfNBiP/?=
 =?us-ascii?Q?IDHlnoe6nA4Kgu3dhZPjFVUaT5wQLWa6PP+y5PLyUQt6KdrxPlKtiFAnqxmK?=
 =?us-ascii?Q?82oO901oqG9WvNH34NPU5iWMYAmpp4jw03T8p/MGlxNKPFHSWSw5MCSzFIlN?=
 =?us-ascii?Q?8m7CM3IUtnZgjzL3eUujanaxa8wEvUmZZl141hV3nM4Rq+J+pM9z2cXtZ4lf?=
 =?us-ascii?Q?/bTqLvyqGuY7Z/pfBwRHr+Lgktg/I/nMm5ZcRlVgmXBbwMiBhWuld3Y8Aox7?=
 =?us-ascii?Q?1IwUSEyiP7bWLd95rbbVa2P0Q0VSPCaKGi0dRr+XCeF4M0dbMWz6VCmfT1Mq?=
 =?us-ascii?Q?e9nz9o+YKFwQvOycn/RPQm0HjY4tSRYCY72XjKymjTPTeY2T4nbR8OFehoCy?=
 =?us-ascii?Q?yMWC7O3DH+hlSOerfAjT/xjh3ZjeKltQdI8X0VAxRJaOuay8v+r9jmITjDg7?=
 =?us-ascii?Q?l3QSILBRmL+FJl1oL/ziatDuhm6VySBybZ+4+K3v0hnrPrdFAaiWsgoeL9zN?=
 =?us-ascii?Q?FApg8i9MYpOEo6OSFCPfX9HQScEW4tg7qj7h7DWwFf/qljI2nmkmD3uXu1qA?=
 =?us-ascii?Q?ykaXBB+52MBPJfnZ1lpXG/Pj88p3MFTkrhKEn3RlqJa5hijgjF9GfKhDeohS?=
 =?us-ascii?Q?LkOTNIkyssYUyV294G0RbcnqRDTe0jnMRtLHMuIHzBv/glCkfOk6CMZcGHVc?=
 =?us-ascii?Q?zQ+SmW9t/ThxbySdz8Jrpg/Qd7oyTlJqTfv44rzXTDfHmuZo2zMtAYNYLBHb?=
 =?us-ascii?Q?mchcy8dQyV0HX95IA7xoXjODr5bvc91NR2ffzujNKvSxG5csriWUwWMAGuDF?=
 =?us-ascii?Q?9XQv1k6UANwSIK9ckf67E3CFLHyLjy75UFblpvug8SF77b9xaDNbr3sAMZiI?=
 =?us-ascii?Q?I+WHEGJQb/FTzpOZHZYq4RVBGpStbo6BTtU9jK+R439DJQD54ohVu8Pl/08l?=
 =?us-ascii?Q?pp6egpBqJUSdg42AwVD8PC2MjcxVtIEIW6Q9OoL8VESPw8o0+n/SZtLqcmfU?=
 =?us-ascii?Q?CNXY0UQfanqTaUEwbYGy9ck7oClIpitrCoGGL61Ri7T7mzdLSc700FH+2h3+?=
 =?us-ascii?Q?kqizVKZETa94M0qrpClJccxQ+5vHXoJBqNGjJBh/4FQD/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7QBHZAIeVP5FeJNkn9CYwGno+z9WvyQ1Tde+RW+NfEdglQ+0Y7ebx7kQW/5h?=
 =?us-ascii?Q?q8SClYllSJNYjfsQG1A/miXcvEpvGmkli6KinhkVmt94TCQcvVV/dIA6gVEe?=
 =?us-ascii?Q?xQvS9Mij+oj2036jtOdC0xrrLmaFpDJ7x95T3xsJPYnlhAY/ga/L3V51lGSv?=
 =?us-ascii?Q?rlPo1ILW3ndclaCZSUOT3wlQWixlVnabzMq9VLr2F4H/l2PdqtMEw8USXmR5?=
 =?us-ascii?Q?61oKNkhac3sMDWjtq/zi1BqLQyf5FYg6zjijKWch+1q+pNNHnpoRQr7l5f4R?=
 =?us-ascii?Q?2jIgWffaDXl8G0Kdu9GSsan6e5LVI3sGLgmileAdehCOIFNl2qKoiUihD90q?=
 =?us-ascii?Q?NSiT6WMC+jaboslP7ueYj6nru709F8gQkVe3Ip6sHSK4T2mlKmG43YD2hw8J?=
 =?us-ascii?Q?rb5w1sGwKEmV++gPp726E8KKAUojZdrX34LnHKNVAXp4ho4V2+II3EntudFf?=
 =?us-ascii?Q?rJ2kCIoTyhI0a57QuSzcKSFb3gqCuNkDsBMifG128Mhd72RVFqbiek3llODa?=
 =?us-ascii?Q?CIBBWO27BEc/Blh9AGie7Wf3tVrxJPC/VY5aqV9ITehWmc/6PZeVotp7wGSJ?=
 =?us-ascii?Q?YGo0xhUrG5OI4kh1PfFLfT/EsdTL06pMd4aFf0MX1A/gVdKPOL2+YnK9qP4W?=
 =?us-ascii?Q?xSlI2U7rlA90Lh++P7dypmAif45MVMGYlSknMxKkLOkq30cb2L2+H16fFm7u?=
 =?us-ascii?Q?J7K7yXspmn33g4QgxroP9f52cZYdlXzzyHXexBSPgMrduamNfj3ko134PLDU?=
 =?us-ascii?Q?/tJ3BHyrdDEYCXa7RBgyHNcmpMXCPshEGdogLPiaWiqh/hIo+KziCK2bjIXT?=
 =?us-ascii?Q?z8hL0O64va1TC9XXjQ7c+6BBPF4UWEU4PUIjeYY3XhU8mvtEWZ1LycvR1nCb?=
 =?us-ascii?Q?npbcVYQfHCiaboG044ZTzhmxSkhNUPURoenAE3p9tVqTADEJo+MxL7G8xi9D?=
 =?us-ascii?Q?hYmw0HpjUnZwDhSFhcRxpWLmkuHaxGI0xgWtFk9KH8w/+ssgVf6mqxP18OCJ?=
 =?us-ascii?Q?Hrdt9B3BEDaRMGa22+BuTiSf9h0xKr2W7N95tMRWbkGUiJljwg2EOOLRaMCO?=
 =?us-ascii?Q?iiNNYQJiuv2yPLESbbisbrMePJ59dbcgivRb6EQ1X0IeLpLtTyVWjXaLgd+y?=
 =?us-ascii?Q?aQiW2bO5Q0Wq27Irs1SefycMiThHTUWySSTjWZbth0NpR6OGihIg/CsiBemG?=
 =?us-ascii?Q?WhSypAP6LOLV1SAoajU9PQapMEdW9xXIxqxFoHV9Y/YkaTmUkwNGkC2T3DpN?=
 =?us-ascii?Q?L4IZ0Ul5YDFNudI8rVv0Cr78OkTDpSWX+c16MjKoRh0qUpDYAnUiBMw0V3Nd?=
 =?us-ascii?Q?tPdHzzdsDKpGi96tXNjmruO4EGuW+MZOTJn4P9UK7uDq5Dww/1UrkGMIAffL?=
 =?us-ascii?Q?Wn3E58k9rRrBLnH9dwdUh2e+CCxfauDB9CF/eorqyT9s59ihWP9x45+uEp91?=
 =?us-ascii?Q?GdndjvVe10HYx5Q6pTsNPEqkt57KJ10onfKEpDcq7M1ImkkwlQ+87qL2bmsq?=
 =?us-ascii?Q?8pCXRRVimJHcY8RguWE3Nuii21nY2+3Y2C3cBfZFo6hgJvgddvNMvGPCPznJ?=
 =?us-ascii?Q?Pd+dx+nKeUdYL/TbY8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f7f927-53d0-408b-878e-08dce45c304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:06:17.7702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RTQY5z0z0p1WZ+XMG9ZvtOCATFFmanZ0hnCp9MzEqq/bkwVK8BieD4bwM5UYoh+iK+mSRouUMPyVRklNSl1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10773
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

> Subject: [PATCH] ARM: imx: Drop bogus newline
>=20
> This shows up in 'help' output and introdues bogus gap:
> "
> mfgprot   - Manufacturing Protection
>=20
> mii       - MII utility commands
> "
> Drop the newline to fix this.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Acked-by: Peng Fan <peng.fan@nxp.com>
=20
