Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3056FCED27F
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 08:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CDC88E2D;
	Tue,  8 Oct 2024 10:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jUb650R6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC0888995; Tue,  8 Oct 2024 10:54:42 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A589C885D1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 10:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI+3uMdIObacMyYNtR4FpDrUMAqxYTDwWLE90QXtTTOoOjIW80E55dtmHtMQCk8NDY//t1V8clw4siElSYmz5UC9QQOf1YeaZZ2m6PJ8JdJI4tqmTY8svGZbjvv4Hjc6w9h9f4d/abNEbyDanZ5iX4C9yPFToJ5CLYy4M9fO93YPmA71RxoJZvmTkwXK/y+GKRGKcyksIKl3AVE9GS7AT5a4LqmE3tp2ZRPsH9pr5LWvifmcvh3EUPv6sguxp0zC2jibPVcPuh3E8Qf24BUdFJQ+H58qWPw5k/mJaBxlsnGypAyxyQJO6rRTOJa9aqroHmBQ0AaLrAfCLtN/L9Q6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMVaEHqilEELRUSJ4JV8JDYTZMairwfgQfL94+wM7zo=;
 b=FeLoYwB7SO2K+hOnlcGLBlkcGcIEVyWMrl4/lawZV1h/1Lee15YD6MPSuw6+7+AQjFcJJI6JhIwLBn+zBC+dCQaGod+t4v6+aRrmYZVTddH73Jbu1aak9Jc4i9HY0fjvKszZZVWxJCWxkVcCT9Pi8uhVJEhDlQrW1VjjAEmoY3i8oGmZZl6Wwylekvz3OWS1qS8KVHRZdnO0LfcyQHirsaDYUIm1o66HGRLW9fqN8CdxOF0TgaUlLLcM5NQfKXvPduCiPnMhLP0DJL+MxeYI94AC2UAEX43Sm+dPDzPJljU179UqBi9I/0MoiJv6Zv45mdsF+O1My4Q8hyLVI8nM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMVaEHqilEELRUSJ4JV8JDYTZMairwfgQfL94+wM7zo=;
 b=jUb650R6vwYGUSk0grTPnBx+WJb6vB6FPOf0qoyzUSgwSE/GgqFghelZn8gXXV9+t4dfINaLhV9WGxPGVM9CK2eO417DxwF+zDQbt/OjZ5f8wmZ6Kdm5PSI8St0i8KlK1Dj13tfNKY08lwqCxDGoA6B7eaC842cjSHxSqUO3boBA8hh+t1r5P9GOFQ0NIU3qSqDTIm8y2uLv2JdGLhD87wZCgrs3FIVlHaIaiicVTz17EW6nlMf7ttGTEouowRTV3tRT+wh8Fo2zvri42YjUalV+pXZ4FgbsFH4VvR/iNgraBDKIFAV1aweZxu5rIrZJEGtKRaymqGhrvT1rCWUOhw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 08:54:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:54:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li
 <ye.li@nxp.com>, "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: RE: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Topic: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Index: AQHbF37kzuMw1Gz0EUuu/Vr5DDF+e7J6PP8AgAASNwCAAAYXAIAA2ENggAAquwCAATdiwA==
Date: Tue, 8 Oct 2024 08:54:38 +0000
Message-ID: <PAXPR04MB8459AC6BFC8402C2607A5817887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <20241006225032.GS4737@bill-the-cat>
 <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241007141730.GT4737@bill-the-cat>
In-Reply-To: <20241007141730.GT4737@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10187:EE_
x-ms-office365-filtering-correlation-id: 7097e82b-8822-4b73-c46c-08dce776d749
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?v1iub7RG/tF113xyg5nrh9S/vUEaz59xl/5UR06BTvo6HocmqCUwrzws7uFd?=
 =?us-ascii?Q?1Me5/9PqvamA9RkRjuCLbw/oF2enLTr/WPMcnZepJy0bdxsWYNcBW0b0UYhp?=
 =?us-ascii?Q?OndahWHt4OPK8Yp2jpleSGDoqSJ3J0yMtrzytsr2Onafwv8eLGCAJLieYmMP?=
 =?us-ascii?Q?3Aqyu6JIYhOXQBivAHAGDbkcb/0QlxJfDcCTgiLIhAFXBJjIQ2lZjvChzKv7?=
 =?us-ascii?Q?bx5eXmHNZ0aNBY6gMcrorPh4aiJhN7sxKSQ7refpph7BjlW6WlOKVJAUvZK2?=
 =?us-ascii?Q?UxKUGAHIINdSdyxdykdQViyBfcVLcmzM6Bx2YaQLw8SWyEudCxhCZIZ38sSh?=
 =?us-ascii?Q?gxIgO/LNF2GGmS9G1DMyMPBNsM+a8qXoICs3A6k8MrjDA6ufeWsvXtFLtA64?=
 =?us-ascii?Q?qp/GiUfgZVXPOa9edLtOPVteRSo3Cwu+WD9DjcqPM0yUEe5aGYi4XkIVHHPF?=
 =?us-ascii?Q?84rtG1DglkKM+30S1VWB18aPfmridBivCRBKmNGjowpH7mOiyevVgRKjtZSJ?=
 =?us-ascii?Q?k6ZGghw3BvY6Isz2ON6kzyA4/iYamfKVf8CGBDFD+rmSC27ipsfYH7WcvBmG?=
 =?us-ascii?Q?aa3DiAxmbZzTi+F43DzXfb5M8OgsTOlWSxctmGt8Jnz6YXFMei4T5nMglY10?=
 =?us-ascii?Q?qdE+alsMO4M+3bej6TIwldQgC7oJLI0GLFL7G3fEQ9mK+r2YZkDxY7Uwb/uc?=
 =?us-ascii?Q?Ams1JKx9LVsKmUlKCtPniFpipGe3CbSdByZ+VkRJ/fa9RBexZMDxa0jtNZca?=
 =?us-ascii?Q?uH6xLNTWekYKKlXtZFx/Urqj6/nF4raG7qnjy3Mz5EWbHIPjaUm+I+E9bJDL?=
 =?us-ascii?Q?/FcvnQLPvJCHBX1nhXIqJysqk5QTM2YFFQl3QkwrWUZCMSV5w1Ye1cgiHs+z?=
 =?us-ascii?Q?Z+SSbcmfosDPMm5fkeOdTUvUdrsd9SuLzeC2nsAQCmjH2MentC+BMwplwoyz?=
 =?us-ascii?Q?mkDi+md7ZXmqkUYk+acCsYe7J8yloY1focwwf2is/ZZx6QFLjYft1NdyVzq5?=
 =?us-ascii?Q?3KeH/+Uaz/8LpaiWO0XxJRB+xAPD+lNp7t+s3JwuTdGFpvgXUJWHf52N+srh?=
 =?us-ascii?Q?Me3GAGMkoan8B3jNvD313/qCgYih/UU2d/Cv8PAyqZZTiRwV1a16Kn+zEvz/?=
 =?us-ascii?Q?M1dyqhnT8wQTU7XSYTp4mIJlwRqREMumQxAWbG9bfXI6mr6e/SXIiJTJdqgb?=
 =?us-ascii?Q?ltsxGDr1n74bq4+x9K1YlVZOF26p4cgIbokl6ZcJrrS9FvXwe82XsbAI8tq9?=
 =?us-ascii?Q?z8vtMWg9104JI8f4O5dHnuTnR54IjM3kP+SYq4rSA54HhBJxdy1dYBH9Gvq0?=
 =?us-ascii?Q?4/lGYqrkrVLZ3IYiaVAJQoiWBCClJMwsuGSUSyLPADN4aA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yPBvIcWKYtwwgid34hjvBpXksgh2j2P40thMnNU01unzJyE27SNtGzM/lDuR?=
 =?us-ascii?Q?4RnB6Tbl+7xpuwCZGPT/t+8PGpyP1fTDP6lTA9jsq02jUkZdK0DWvTAi2f4x?=
 =?us-ascii?Q?IDaZRgpCM1pApScggQYJ3SWLbMml/L4klYhWEzOy5QFl54Jtktn6ddfGDQYZ?=
 =?us-ascii?Q?iDwLbdnDjxMQyHZHzIZfJrkXihIboUDUFPqHBFky18vbEhz0V9ST5UjWl9KQ?=
 =?us-ascii?Q?61nTL8jUnESTe3zwGc3MxTS4ZRPAPqmVOjxWN8kAhljh5ut5ejJuTC1Ca1Zf?=
 =?us-ascii?Q?2bGXNMcSEvtxGS5IG7PIyr2RskEphe+4Aqv6Pzmzf1aOYhxSqi7/a5MGuue4?=
 =?us-ascii?Q?v775KYlcDmNeSnnXI7ijSou/+/Qs+9E54i7KlIFoCnDaX6kxbRI73tlF/KZ9?=
 =?us-ascii?Q?fo41ekrUSWytyyKlUBsBIZSGE9HihJsBwQ0HNazumcQfXW3PHAFMSx+Nk5GT?=
 =?us-ascii?Q?tJqbCbgf86YK36alvLdp6hwksYH5SYgx3EEJBHOhBnriUD81FuuI8xMSK7i/?=
 =?us-ascii?Q?v+7kGqhewGDJwmxRHxlLIrcJSAi9EKxbtxEtFjJxEE5fGJHdi5d/VOGsUqUb?=
 =?us-ascii?Q?A/NIdTH3ZFXwEkva2xuBAF0dYyBo1w+gcPfX3L9g51tbE7sSuvUjMPlFWTiI?=
 =?us-ascii?Q?u5+t6O5XATC5tVgB4Ca7Np/IrNVxXFc7hXTMkToDo2GrCq0AmkaHGHx+MPnz?=
 =?us-ascii?Q?wySAaYBtzVtzhuNMBkdWOm99E8f4J7RpNRsvRUPO+BZWmVqUIHWJqPwQPl6q?=
 =?us-ascii?Q?00kidtzYPfnRr8P2Icv/f8YNjnAgPI9Pzj9pnltBh6CV6/xXVTDHUm/EqfvH?=
 =?us-ascii?Q?jxa0phJ3/ClTGKGj/cvY2NavveZk5M3Sl/rU5vqAOlbZQPuyt3zqKS3//gRk?=
 =?us-ascii?Q?uJpS3LhcaWXWdP8t3cKTNFkCC6IjKgulU8vcQVDOxVpCBDTw0+xlApbOlvJq?=
 =?us-ascii?Q?FJ7oVybyw0TYz9rRe2t3sFKojizof5gdZuqu9gN5WmDNxEKnIafYM5gycmfL?=
 =?us-ascii?Q?WJIlV6gp1FVD3QX97doSXeD9X8CO44A1G0o7L67+YFv8mLVdXJj1ohPUsvaq?=
 =?us-ascii?Q?deWZQClqVKyCd6ezV4uC9hAgWZZM5SUYViGUi4hOTu1VK2v40d2/3d/TvLwn?=
 =?us-ascii?Q?jZCgnprviD8Htqakmwj1SOPEK4RPvojvDibhpLbguU2xqBNhZIk8oVRhijhf?=
 =?us-ascii?Q?MBtCZv/W3lfSYhzMX6a93cG8eJ0XOSZnWYBbRQszBQEzJm0Il1N54fxMekpv?=
 =?us-ascii?Q?sOAmUrCm4Ak1YI3z+cXfmYbOJez7iByUVA7PDfoxffhrrLq33VhyzggjHQQc?=
 =?us-ascii?Q?EeIgPdvTRiuOLSjrJ860elftdJs5Qh5CTgEdqDHclQ0ywaKdphD1YY4KxeLS?=
 =?us-ascii?Q?uCdaZIb0wEstj3QjxmvaO0Vs1Q14rypr/wDAHs2kyuJfI3ZKA4JBWFwgGW5B?=
 =?us-ascii?Q?rye7AxqsWRpDDjoonYIfECpGP7eKTZJTo7NtMSRuAIKNog9Cnlt2gKSuYN/i?=
 =?us-ascii?Q?/9cS+iocIeZ351M6oIhNY86pMpNYRJU0G7hI78mdymkBRB6HvG/HlzEZnB13?=
 =?us-ascii?Q?CpIs32GImP59hZXw/0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7097e82b-8822-4b73-c46c-08dce776d749
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 08:54:38.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPsbethLLC7TuXsKLl8W+pBJZKv/pnhNbPYOUf+gBNRGljPmQu0+ZFxBG9FvM4RWY/yttk6OgBfp3u/hQqR+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187
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

> Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> configurable
>=20
> On Mon, Oct 07, 2024 at 11:46:03AM +0000, Peng Fan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Monday, October 7, 2024 6:51 AM
> > > To: Marek Vasut <marex@denx.de>
> > > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-
> boot@lists.denx.de;
> > > sbabic@denx.de; festevam@gmail.com; dl-uboot-imx <uboot-
> > > imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ross, Fedor
> > > <fedor.ross@ifm.com>; Ye Li <ye.li@nxp.com>;
> seanga2@gmail.com;
> > > Alice Guo <alice.guo@nxp.com>
> > > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> configurable
> > >
> > > On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut wrote:
> > > > On 10/6/24 11:23 PM, Tom Rini wrote:
> > > > > On Sun, Oct 06, 2024 at 07:31:16AM +0800,
> > > alice.guo@oss.nxp.com wrote:
> > > > >
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Make CONFIG_IMX8_ROMAPI could be configured in
> defconfig.
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > > > ---
> > > > > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
> > > imx/Kconfig
> > > > > > index 134e42028c..9d3aafd2f8 100644
> > > > > > --- a/arch/arm/mach-imx/Kconfig
> > > > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > > > @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
> > > > > >   	  the ddrmc_cr_setting on relevant board file.
> > > > > >   config IMX8_ROMAPI
> > > > > > -	def_bool y
> > > > > > +	bool "Enable i.MX ROMAPI"
> > > > > > +	default y
> > > > > >   	depends on IMX8MN || IMX8MP || IMX8ULP ||
> IMX9
> > > > >
> > > > > Since there's no help here, is this truly configurable, or is
> > > > > this something that should be select'd based on the SoC and
> > > presumably
> > > > > some of the newer IMX9 parts cannot use this?
> > > > I can imagine the MX95 calls into this custom ELE firmware stuff
> > > > instead of ROMAPI ?
> > >
> > > Alright. Perhaps this should be depending on the above and
> > > !main-ELE- symbol instead.
> >
> > Nope. To i.MX93, ELE and ROMAPI are both valid. There is case that
> > ROMAPI needs to be false while ELE is still true.
>=20
> Alright, but where is the choice made? As in, can a normal i.MX93
> board use one or the other, or will it depend on specific SoCs in the
> family?
> And is disabling this option even valid on the i.MX8 families?

Sorry, my last statement was wrong. This is only to disable ROMAPI for
i.MX95. Downstream only has below:
./configs/imx95_19x19_evk_lvds_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_verdin_android_trusty_defconfig:221:CONFIG_IMX8_ROMAP=
I=3Dn
./configs/imx95_15x15_evk_android_dual_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_uuu_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_verdin_fspi_defconfig:226:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_dual_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_15x15_evk_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_15x15_evk_android_uuu_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_trusty_secure_unlock_dual_defconfig:222:C=
ONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_verdin_android_uuu_defconfig:221:CONFIG_IMX8_ROMAPI=
=3Dn
./configs/imx95_15x15_evk_lvds_defconfig:218:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_verdin_android_trusty_dual_defconfig:221:CONFIG_IMX8_=
ROMAPI=3Dn
./configs/imx95_19x19_verdin_defconfig:221:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_15x15_evk_android_trusty_dual_defconfig:217:CONFIG_IMX8_ROM=
API=3Dn
./configs/imx95_15x15_evk_android_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_rpmsg_defconfig:222:CONFIG_IMX8_ROMAPI=3D=
n
./configs/imx95_19x19_evk_android_trusty_defconfig:222:CONFIG_IMX8_ROMAPI=
=3Dn
./configs/imx95_19x19_evk_fspi_defconfig:227:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
./configs/imx95_19x19_evk_android_trusty_dual_defconfig:222:CONFIG_IMX8_ROM=
API=3Dn
./configs/imx95_19x19_verdin_android_defconfig:221:CONFIG_IMX8_ROMAPI=3Dn

Regards,
Peng.

>=20
> --
> Tom
