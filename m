Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FEAD70DE3
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 05:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5330C8923D;
	Fri, 29 Nov 2024 06:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TnflIcZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD7B8922D; Fri, 29 Nov 2024 06:30:22 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DFE89383
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 06:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buQYfiQ/1lx+48I/vsSZ6Bb+ImCA1KTBb35B8GzxKe0dJusH00N/TBNEwJeUVueD7S0ebnr6ega0vYg/GgFCXKJSRMXhI9IbzsYvIVFl5lsoNpU9PG0CqMVU2hxWwz+2Pb0ZUHc+5FBE+3yz6AtKYyawvu+CfuM9uEu0gWi23YSYe+ZxbPrJiGVRXxeknwMdAN2xcgMkTrWkWapiE2BEx1rfQkTg97oPVrYeTAfA5EOzvOpJ7zFycnjKZAmP8r47WKHoSWA/vSalQZTy1MwsbkEnIJIlsMnFjQV59xcUQaxrKePIBFYJVJPa8bbjtGcAXJGfCGewJycLxb4TAvI/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzLppU698YJfTIvMgaeG7Ke+rg/yrhZJ6trh3qHbWWk=;
 b=QMTEktCIsntd1jb667cAaPbWgpUJJNj53U+/6ixMgSoHr7Bmp9E5dpHJ4vfkzMuinlUHJPUlEVOU750oMq8p8kvzR4xeq24A5+P1zCJ0bksdSPf0rSqPDDZFerABMxE/aAFLhz4BGcppEN/VIUiseXNqxFggwtIYmhCUMB4bhZTq3B2hELEUI53kHf/IJrUIWW2wcSmRnDkNxgqlJq7DEBXFqa2Nbu8nZKTwVfqXFhWYJ090Fkq3j9a5w9klLRsKkVSbGigVXsEMB2mwfh3eGLkXruo0HOs3QpOx0L+p2Nkg6lXv5CkBGmB3QrVpMbOyNl1X8LLq0ovPplk7cS3WhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzLppU698YJfTIvMgaeG7Ke+rg/yrhZJ6trh3qHbWWk=;
 b=TnflIcZzHqItAAub8FU/wHcRPtC4lv5PZCQbXaDCKmMIYi2cnItgt/CYCpUzGn3Qa7SS0x7DDK8J3TloWypBmiNK3fY69iCkIfn2SGoRnyZrqXyK7tUueZKqKb66CaJKWVNXDO9Ed7ELZ1GBGX6ehAK7v7BPn4ErD/X4t51zk/nXLbeBWe5hpS2Y4tsGs2WpzA7PL/tMFBVO4RsSUVDCUhWelTF54CU/mNunz4ywzg4MeHjWrdekagbW5T5h2uYAGR4Ck9AeMfGDDiWBT6ZKwE15y4b2Q4nLG+P2DL1rMzLL5D7j5Tqr+wyHV5OtNBPciT2ogalTN4gojNI5Mxi1UA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 05:30:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 05:30:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v2] ARM: imx: Replace YModem with SDP on Data Modul i.MX8M
 Mini eDM SBC SPL
Thread-Topic: [PATCH v2] ARM: imx: Replace YModem with SDP on Data Modul
 i.MX8M Mini eDM SBC SPL
Thread-Index: AQHbQghcTU7HWjpG1k6as7StZ+++FbLNu03Q
Date: Fri, 29 Nov 2024 05:30:14 +0000
Message-ID: <PAXPR04MB8459F881811EC6EA7D3DF953882A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241129024218.337845-1-marex@denx.de>
In-Reply-To: <20241129024218.337845-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10614:EE_
x-ms-office365-filtering-correlation-id: d5d7d549-532e-42a5-6850-08dd1036e6c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?g2vPlKuXt25KbIOjGj0Orm5CZQj8t6/3gHXTvL9ql3B0wiCiFJQzKvQmMWTq?=
 =?us-ascii?Q?U100OOYe5oCPSRV6aWaT1TlPsjtZTcJUTgLwlZIDjlFAWPjPw2edEnhgWS+E?=
 =?us-ascii?Q?o1L8R5HbDer4O/DrBBW+iNTWKApswse2gaW7y+jfb1qp80Audh2lXiEjLGan?=
 =?us-ascii?Q?hzh2ued5f6g8plZhnjoEEz0cNcF/Q8FYUjcXgVjDAppKTyj/xpNNJbz6vE5F?=
 =?us-ascii?Q?nai73HQOh4WZmXRpHs6yuUZr6+cEIx8J06rcjtMsmOdHVdcFRJCaSgErh57m?=
 =?us-ascii?Q?6CyqnU7CO27//2VfBynDWXn8yWowd9S+yELYm6ks67Byrg3yFS2ydeZiXKTb?=
 =?us-ascii?Q?NsCMgUE6aS+FFxv05pnBn6JevRaQVQGsOWNjBTpc7FQai47WTjw6XRPMQ2OT?=
 =?us-ascii?Q?XlX/9dvQfg57+8Q7M91gCXe8tuyiLQLoSgNJaVEDgN78GExFJAnUEdS4VJEn?=
 =?us-ascii?Q?tIFk9JrM36PqIjFQ8fLu4TDJHs/5BKTPmU+9GPySYvlWEz7mwFn8o5egtMul?=
 =?us-ascii?Q?RYj2xzYX32idhMiox/yfoIOq8Fl2ECbuc5Sx5iqfWh9u5reVrarylHdbEoSC?=
 =?us-ascii?Q?LTHHRASokKK0SLSc4vINTjYXNtlaWf9VThV/4kjZm7DE3T6TO8ZwmZq5Cohc?=
 =?us-ascii?Q?uyjBL5jVfhgslX+zFVJIOeEXc4IXWZ90fGp/HWt1rTVHu7d4BTPWe/mN4KZO?=
 =?us-ascii?Q?SCGhvbAb3goZg4KXI4pf8/ZGRqCQjVMByQcYW3rzZTtOpv2p/FuWXk4sr2ID?=
 =?us-ascii?Q?O3DXff759fRJOrzYTkvqumJo15pFX+c1XHP03HdPrPB6tXjUYs0c1ZFronVq?=
 =?us-ascii?Q?ih817VKsgCtNtzeEIdFOgFaqlDQwyeF9NpCDiS/1lidf2v4ac8Qo7oNT62ZK?=
 =?us-ascii?Q?BtwaLRA9xQj/q73P1hY4QAfaqwUibaZSw/Ky8+Huc6X6wnP7bSpApQprJZfu?=
 =?us-ascii?Q?y6k/jy+esbbcFG6rr4/c11rDzgWIb/qO3yCfNpT83Vn3JrlFcyrSm8LHYrHT?=
 =?us-ascii?Q?ZSOGTnVob6ozzF0Q9Y4L6cQqztHNAtL97YYdNwe1rWFG9exO5irA+8t5XCok?=
 =?us-ascii?Q?IuSmwuL2wSyQAAGxdpWL6JaxKz+8AYwzDYuvWIbodw8BcsO0BPZTZLvSUg+k?=
 =?us-ascii?Q?KeYI6yK9s0YQ1AjIRjjVTEJm4o0aGIqTN23R7yt4g9CTuoJPfuCKBUvgN52p?=
 =?us-ascii?Q?mmDvXcg/9CBAHv0aHgLkoDEqbqTqFxweagsVx91yEB8PInfam+cGW4UYoyPe?=
 =?us-ascii?Q?RrLUolZg85P6RKbgP2LrXZor6woAhXRvejCMWoRyw1pF8RdGd3zAe5525GHp?=
 =?us-ascii?Q?IJRkdi7smu+nXBcKrdUUkeUH8P5XMUTBEpQ4ViV53KJgBG8JyYzC0MXIF/9s?=
 =?us-ascii?Q?nI8hPS69xfyHORD+W70kd4GJPznMWgbT5q5UoUsJ0GFZZjNwng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2NW4t/6ulpF8VhG7ClnrNUG+9FJYhwzyWwFnB7hh2myzdh7USeALw4W9cKE?=
 =?us-ascii?Q?Th5ACgZ/6b6IdGPHtRtDjR4RgcuAjFqbtzdnoHloPv+xrfcurYL8WzMLLLLV?=
 =?us-ascii?Q?rO4whta/mKSvd1GGUq8P6sSRAb7031K65EWxgFux56d+Hkmlpo7UlI9sjTnQ?=
 =?us-ascii?Q?NgiWDRBDwqi8tl723lNEqbHZ89VYdAL5gOXiPRYIb5Tly2d/s1HamQ/q06Tj?=
 =?us-ascii?Q?3LYhrHEwZDY+8gADVBcpUAjUsvX26ZeZONygC+hNNeWXzQY3qHcPWolJI6xa?=
 =?us-ascii?Q?fkQj+U31gLB+F1ATIgYmDxf9Ru1UkBe47B7NVvu58QBRFP9ddCCvxR6WnZho?=
 =?us-ascii?Q?A/J6kklS9sMk0o4wrzhhDXkwT57Z+Mfu+VWgOqwPOnAOpv7eifAFWnN1IQl4?=
 =?us-ascii?Q?Y0uLh8b6PkStAv0J3NVfmupN13YHQQ8Vo6aKOurbdtQOPTayVv4CaMdW5BoQ?=
 =?us-ascii?Q?vRFZbNOQuK5sPLRPOpbXMtrhjxy/hzuJAZ6U9wVgYKME7R2/PiJcWaHY9Ftg?=
 =?us-ascii?Q?fdPgLq1X73NokTq7KDunr/X4wKbGk7BuZNq1CB2TpgCqWYU+XWWBkyRPHD1g?=
 =?us-ascii?Q?CUKy2MY4U/7gzVQKfz0etoQ3xfPnQqyFQSGsGeqF7PTVpgarR3ku89BcmH25?=
 =?us-ascii?Q?mx1dZPeKORbOVkRpBkl/BigyKqrz4cIeVb7x3/NZs7zv1FroOjdFm91vGuM/?=
 =?us-ascii?Q?hzYahhX03gGtBX2xzp7u+STcO/g4YSgZ1n4GNXpLLMQ+yDyUcCG215nXnrpl?=
 =?us-ascii?Q?G/GqULqSQSWzgxDFUQi28stpo8TRf9A+z0/oHf6/bX2BGc1UVWDwpERkFrFq?=
 =?us-ascii?Q?UZ9DWH7IGHcuMdKIOwLpYHCGG5coza1gao+C2gw6D5NUnDQsFVETZ/euBGqt?=
 =?us-ascii?Q?ECFHxGbDCfHwU0wZcpAPOd7m2D55PRAqIb8+nTQrRWDzHJK6Ooa5tehXO7BG?=
 =?us-ascii?Q?9y1yfdFq/tcjfmNFEXUz9IDQUDQ0xDVL3afNgTKY2JrmOjFRJcJYnVdtFzsG?=
 =?us-ascii?Q?2UBybVP7HZRHmWxRntFSKlIuQfQhzDQkBB3Qep8chpwo25Zik/ZZttLhBufV?=
 =?us-ascii?Q?pxsDg2NWbhCHQwiZCu02gy2BMmPsInMHop4uWq8hniT5q+wmIbokyaqbwhEv?=
 =?us-ascii?Q?Duvvmo8oUBzvgFbDLrGOQY6yYVqinTKK75O5BbMfoJ6DYZM5jQKaqzIyvyel?=
 =?us-ascii?Q?QRVEvOZaAhijMUvBmQ1lQaIeY2i3M0aN6ZGHsTP/lxwgt07yLjwMPtKer06+?=
 =?us-ascii?Q?S+fmskL2xas/Tk5sImoh1dt66CRuZXaA0Kw5Boe96Mp7iwWTDA134UfHfUWQ?=
 =?us-ascii?Q?00zUmZcOtezBYoy1ZNHks0qJCSEqU1/T8TcU7gtZn8RqWGxI/lfsxV26qLPf?=
 =?us-ascii?Q?7rxQZPtqPGfHL6Oi5Ay8YmXpwKCKkN4BGX5Cl84wo0GSdkNPQ/XNmwF0YHV3?=
 =?us-ascii?Q?nSO1MElkAcnyqsRShA+D69GDU5sDkRcbI0CaUw0TU/0bAEaCTqzNP+2f2HMI?=
 =?us-ascii?Q?GFH6IHhiWLVsOEHrAZ18AEozD6ujMgPHB0eA/R2/3JvrLrzIK1DkRIyhb9kk?=
 =?us-ascii?Q?E9AyIvzBkNF2Qg6zc7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d7d549-532e-42a5-6850-08dd1036e6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 05:30:14.2182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Q/iO09LERhv8/Ny7/Pxqdj6SwlGVDt28/l63jSr+Y0MVeJD12KcW871Yv8fzr0oC4QZXeCn1ob2zCffdLQGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614
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

> Subject: [PATCH v2] ARM: imx: Replace YModem with SDP on Data
> Modul i.MX8M Mini eDM SBC SPL
>=20
> The YModem support in SPL was never really used on this device, the
> SDP support is much more convenient on i.MX8M Mini based
> hardware. Replace the YModem support with SDP support.
>=20
> The SDP can be utilized by forcing the board into SDP boot mode by
> grounding test point right next to silkscreen label U30, and then by
> using mfgtools 'uuu -brun spl flash.bin' once the device enumerates on
> host system USB bus. The SDP capable USB port is available on the USB
> micro-B port on the base board.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
