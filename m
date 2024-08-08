Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F09AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6577488A5C;
	Thu,  8 Aug 2024 05:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="S2PIJGmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7369988A83; Thu,  8 Aug 2024 05:17:06 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7118488A45
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5y2qZOOZx+0IBU78/q4UnLn573Fbs3Nx+c9TnUQJ9RnVYWALwXYH1zcCeHcjF8mmIzpHPVkYOZQnl2BauIVmazG1sRxfxZPmmuDtNv/eLFhzuYIBo1v9nuIOmvIdCz2swX+HeA3gFrICDlZyWnXqz2g10yH6F/j+0DkxHQ6yvjLjjQS6Nzo5RWVWZS9jhEI2exS/9kjH49q4RdVfNaa5+oB8+NZ4AQLPkPwz9uj1mnYn6CoGOpb3ziF1eHJqd4XezaXg4S/09NS7aLW8zPmLHL2Z1R7bAXrR30nY1rEaOGw1LVdoCdVz9UrVdkAx/p6mq6Ai28m0GCzecLMPb8AIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPRRbQDLkcU7WuV6NAtR0nl1uZULNnJ3BQO/i5wlzDc=;
 b=OWCQYTWZHToQgtk+btPVC1kKfcm5Z0mPXtpr5S5gGVqT/oTHniuUs97kQewJvJRSLW8Vt9oDQMVa8PKOnXyha3B+4J9e7AYczAboRdD09mgXpvenduwLVfw46ofKo8aWh8HI/3xwfyPIiDLLETt9uYMgoyf7ogTriWfsQZpLIkPvuPGURYcFx7biph0k2GdXGVx8jR5v5//2N6tfcA02bU2707nixZl5Zycntizoa9WhK9swPX6FPimHjkT+sfHe9yP+St2wu6R4iJZrQ5/q2M1w1AeWW3RtOZDWpqxbuZTqJq5jtTNpVWJeO65AjKDkp2iWopRMmXn4wpjm+O8VZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPRRbQDLkcU7WuV6NAtR0nl1uZULNnJ3BQO/i5wlzDc=;
 b=S2PIJGmIAAdUV+ir9EvaL2zJ6GazrjYArTMqc13Qwit/KM4O4cFqM3V2X4yge+Iz0A2H38l7dL92MP/L6Raer4skvho8qvbH5+HBaYxQvAXZy0OAKBNRkEUGibk8/MdsUEDffJdEk5V8xnshi+XTaJDMYSGeGV2IkGW+o9nx8vXIWgMsGE2jv+RWvBbp6yjQYS/hfv/lZeXtcwlH1mP7wlMb30+9eeWBzrMYu0MShRamrnv8LUl+pklTuIa54KyLjnkkF/n2dMDsC8kx+uq5IbaER66uiJhqzQSM0AEm+M3XOv8dTAqQ2udBHEUp6X0WsW97iGJqi9bVg4DB/bXPUA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 03:16:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 03:16:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "max.oss.09@gmail.com" <max.oss.09@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam
 <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, dl-uboot-imx <uboot-imx@nxp.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set
Thread-Topic: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set
Thread-Index: AQHa6M9PDn9+4O2UD0+wqCuIupBUCbIcsPmw
Date: Thu, 8 Aug 2024 03:16:54 +0000
Message-ID: <PAXPR04MB8459DAB001E8D22E23873CB488B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240807133919.4155815-1-max.oss.09@gmail.com>
In-Reply-To: <20240807133919.4155815-1-max.oss.09@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB9207:EE_
x-ms-office365-filtering-correlation-id: 6014a4c9-22e5-4208-c575-08dcb7588dac
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AzFhaMX79lHVzTL2k4EfwWuWtu53APnGA1YdAjhoer/IMKsZliI1+UvyXPSX?=
 =?us-ascii?Q?jldZEIRaQERGD1g4Gc55VdjqqOH1aUkb7ks1nXbc/akY5s73HP3YmDMwsEQR?=
 =?us-ascii?Q?75TwL22iRKKIKyb6HwSZXwcthHECweZ2Qdikx55YbM+13LfTtnZpm5dT9Uoz?=
 =?us-ascii?Q?2ySjlHNO9Z90XX8eN8KOdusC2wBVQkS2UUa2ciPozqhRoADlwtn1ROq0RVQr?=
 =?us-ascii?Q?oEQxSPIsgQl1RD2KVJGIYOs08zB45q7W5Um3rRnHMF23sNAuw40xIRVSOfpP?=
 =?us-ascii?Q?ZMIN73DrGjrO+mgXcFYnaN2T7AKY3xT32tCvZfWgO0quN20HjwPzFeLLEsdv?=
 =?us-ascii?Q?fT/0YoYyglwtS2gxXUU4Y1EZCZaULesowo1kPADrfIOq8bzJ3zASOYT16+o1?=
 =?us-ascii?Q?8UU01+ovm09eD2ru0Kk0mFKJqJbUVcaHFo43JwUp4IioUL78JMnTqnPisCB/?=
 =?us-ascii?Q?b/nguuNVA0yyy1mMbAFci1qDOdAlfVNTOCNOrgCt3yP2X+ZjgRwaH0Hdkx3t?=
 =?us-ascii?Q?8QGbWRyn6bzhfaxp4fD8ZBfFeAjPOKx1RN2/3ZvUTP09tXE9LsBs/jZK+Z0s?=
 =?us-ascii?Q?/3E9NZuGHQpCC/11Rl7WIpHzP0Tvv1mDdNnsQF+2QHyR1PCDGsUTGeqKqOoj?=
 =?us-ascii?Q?3Kk9OBiHRM0l4ZcuoSYyFG/QhDf8Duds5AqZtrPp4oMKDHEFei9Vp4zeo3Gs?=
 =?us-ascii?Q?zzbD0rphBkIRCOnGE5r5ou4oj3LwarHpFohSoxaUoOU7psm4An/p7kFJtXiK?=
 =?us-ascii?Q?fzz4i2yGs/EtGpigBy3Z0z7jCtvjTHuKIctRNaUn4EXItVdo++f9heyH0Iyb?=
 =?us-ascii?Q?bABZ1jy3cefo712pyu6p9f+aayI2Tu07ZZC82vtBNj8NaSurazSoWLzcxBTi?=
 =?us-ascii?Q?M0AC/Se73QrrLLn8Qj3WvvOYAheYJ406QrEgWlVVm5Ef+XQgg1MQcoLUO53l?=
 =?us-ascii?Q?9RPKZQUzDS2WNR+HUxF4saB6Q3Evz5c2GtmKjUOlYnda1CiWZpQYrE6PcnsL?=
 =?us-ascii?Q?7y1hRkpNtFBER1e7U9qDIYnOk5afD5pUFfHrUcaChYXDPUjs4dvfv2c+o7xc?=
 =?us-ascii?Q?Lhphy3ScjuUcee7EL1Or6k/hYACoOJukVxxWcbUMIKHaNnjaxxaOIKgHjmJe?=
 =?us-ascii?Q?sdpc9huJl+YO1ry+ix56ltTqhKHieo3F6DF+H0JJL4Rg3gS/uBsf3LUhf42f?=
 =?us-ascii?Q?tkARISGEXn+Ex9pS+A2GHyrq/hbR8w6d0liDi6y4hXhJbqkTVZ3aQwixTyTZ?=
 =?us-ascii?Q?1d5F8bAPYAx3M3iZuhQ2VNlHBVjKpiwemGkFWkZQInpalyWHE9cpyOFVVpSi?=
 =?us-ascii?Q?QfpowufWTNUOrsnWpAnFYBganGPcbjsnbcpghTSS6Y4wsRGvHgvTCpEMgH/v?=
 =?us-ascii?Q?f4vkUQAViqmKXuhWuZmmdKzd1+AfqoLkymDCaAqNWgjUoPtEHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZ2xxCnE7x7FB+xZJWoNLdBqky6levl74akpF3zdtvfpVYCY+qdq0x3LqZ6W?=
 =?us-ascii?Q?atJ4jmrihXZmLZdi6ifoQ9i1XcUe+OkYPmOogEHdT6Y3CAR7Mdv1ChRvdw3L?=
 =?us-ascii?Q?ZJT6aWJcQkjgHcH6JXpXvsy3LsSHTxeGhKe7+YOGfoxdshNx17T7Llw2VwYr?=
 =?us-ascii?Q?pHeFDsVUMq6COCV3FPxBwhKBBQBNkGBQVWMNsYS50W1BxhBAWUKUKkGpiupO?=
 =?us-ascii?Q?IxSPT2KT99hjA7Cd770a/kFA8m9FalFMzBRf+4BTcyvyvhSSwINL6ca9uk3A?=
 =?us-ascii?Q?1poVyLbfz0lvx5JGKRsJyUxErL6MqkoKEDY2uZwZ7tK/zZWm21QrV6BHF8jm?=
 =?us-ascii?Q?tLmINFiDt2JAlMkjjdyd8NfLCeWDMyoIpUqWdyQV8RvD8CVf/Phap7ZboZv2?=
 =?us-ascii?Q?DzUbrgntLdSVQmWmo5AkEZc2+AlLA1sESimjFCb6EXkTwtdAjt/0q0MwHBUi?=
 =?us-ascii?Q?jnaEdkSrO3UK/TJYRgaJS2dyyKityXalkNg+hsJeZbej5Ne4Ixm1h4bp7p9f?=
 =?us-ascii?Q?M2bw5bzC5KzRDJXkx10Jivg34lixEhwH3ZY1ck8ljyfjZdEvBjOBdZf3b402?=
 =?us-ascii?Q?0c++O5RVPjAOw69ev6fzC9ofXFUSjVKyBXdhbyOIa47nSlup0H7kBxYtRh5g?=
 =?us-ascii?Q?cxK2c9XDkP/vSVnc8QlATRKXV7ncOlhCOTWz5M65S1fXz3qLlQFyjcxWgsQ4?=
 =?us-ascii?Q?l6sOBY76ZZJPo7yxZvn9AiDWhfjl7B/ZVRywHph+8wAetqQPyk+sQrr+ehy/?=
 =?us-ascii?Q?CnMRr1N7gJc9NBfvgOKwtnZZTSajhTdyKH0YNxdxKhzzVqriUjNIjIOOg+Gg?=
 =?us-ascii?Q?ssTNhAhpjSEVm5lHYOhe3P1OX/cVCim7jOHaVLh4bc8OWjK03dBrpMdbDRjM?=
 =?us-ascii?Q?0k8E7iZeCoRsKnf5sqplKDaJTmGos/zbA3Xlc2c0pgSoeTaURQVLPzlXVLh3?=
 =?us-ascii?Q?kmkfetbB3ZdhEYUpEiKbI11zc5MdTbAMLrVR1ltdyTHVieL8fFcsGFoo+7aV?=
 =?us-ascii?Q?EzZsdplgFLuonT3w8Bu6L3Aa3B4BEPy/va/KqXoEHp+hJ/gTGU/ykCanVf+G?=
 =?us-ascii?Q?5ceeTiLpX1es+rq215kuyLw7FDaQ5/9mB+akaHpBNclBu7HA7kkCqk91N+Pj?=
 =?us-ascii?Q?aRckK0swuTubZvZWPdjlH2gvaIWqyI3av46G7TWCDnUZ3IlYfbxKmjL5ZLF7?=
 =?us-ascii?Q?uPsxiX35YtLh7q7AbC/snryNdFYRn9/pJ2KZ/lkbtSO48JfpWn+G2HyuIRcl?=
 =?us-ascii?Q?pBcN9YzbbhdMy5Vi0ohktCDjDwixvFV910BukgmcwMKIg8IHlsDSlfp7hE0+?=
 =?us-ascii?Q?uWH+eL8ZZDKle7KUU+pkxn3DRvydtvy70I9cD6SBUBoHyNtJy1r52Nu/BaG8?=
 =?us-ascii?Q?HTUXDWeyjNT+T55D038CGUPejhVRPnBrZr1clO7aUcWpaw0vwWYjJfVz6TYl?=
 =?us-ascii?Q?lZdbZw7uf0e8b+IR3rWkISh6ZI8WDp5Y5brbbJSpQPmyrLJh41J37LdwmzD3?=
 =?us-ascii?Q?PHj5u1C/x3pb2crl4mE9xxUTdAp/GnoKlGxjtDZ97kjujvG9SrMABfoo1Shz?=
 =?us-ascii?Q?4pJp/QmQRpQGTcz6jC4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6014a4c9-22e5-4208-c575-08dcb7588dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:16:54.1609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFmzlHwjGMZoQ0hOEX/8NZI+07gryWfzADz8m3d76cDNfFDMxifd31hWKiOw9lxrdlL4rU+knoxjEtZu0hEYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207
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

> Subject: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is
> set
>=20
> From: Max Krummenacher <max.krummenacher@toradex.com>
>=20
> Use correct function name.
>=20
> Fixes: e8cd1f60d964 ("imx: imx8: bootaux: Add i.MX8 M4 boot
> support")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
>=20
>  arch/arm/mach-imx/imx8/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-
> imx/imx8/cpu.c index accba502e492..834aca82bcfd 100644
> --- a/arch/arm/mach-imx/imx8/cpu.c
> +++ b/arch/arm/mach-imx/imx8/cpu.c
> @@ -258,14 +258,14 @@ int arch_auxiliary_core_up(u32 core_id,
> ulong boot_private_data)
>  			return -EIO;
>  		}
>=20
> -		if (!power_domain_lookup_name("audio_sai0", &pd))
> {
> +		if (!imx8_power_domain_lookup_name("audio_sai0",
> &pd)) {

I think need to find a proper fix to this. This API is legacy API.

Thanks
Peng


