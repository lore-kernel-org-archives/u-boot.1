Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC2DD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D51894F3;
	Wed, 13 Nov 2024 06:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MfRUCBgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF5E8907D; Wed, 13 Nov 2024 06:27:28 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3757890FD
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIk8+wSJrJ+GUNT4XY8Z/178vsP7Rd6aRrdnzEdj3MBgV1BSP8EosP2AB5mccep3vZZWBSJFZPX87incVHhG5/gz5YFLYEcEQ2IMknWAdkLWNBQXIGM2JcZVmsPlE/qrRuBmRRfomS1hhakOu6lM/NAfac1HxovOCSSYnt4AZoX8qoHLF14amL+urOddTQsos0anZ/zmKwL2qj3SIBnNAYYgUDEpB6wWTKKyis4bl8AOmDCa5TEHS91vlXM8VbwThn1rGpC10gDhMzT6RFV+22PWz7Dr9j34ECOlyiF8PBUFv7encXvYJE6i4yXLgdEFMeL9qEnuabdV0nl0tJMAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov+reuoNgPllMkm8Pq9CKShUxuihgn/h76jwcLurwpk=;
 b=Li/vx28DjdpmgHW6ZskXhmXirbVGRJdEvlKpENWsw1JL7n/1KYyomcBQYWY9m/H1ULTyZIQcAoMRgVobb3ogAvDDLyy+kpp79D1Rd2oNhmUBTYmlm5DH2Oo22/BEkPenOP9GEBBqLCUbKKN7FE6ApPH1VtAZnMtq8A6ig4keiCCW2vZXFM7ndlPv8uHIq3h6zrcK+OabS/EeeIVfR4mteN7+hVHAtsLyUXl1xP7UnERWe93IkZ3DqsJTWwfrmAHvYneuIjRFGplr4cD4o5hJGr8nkFPZ8K2O54b677CSaTH6HSSS/q9T8q4+c+/8ZI683ukbirmzYeuGz9YKfNjphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov+reuoNgPllMkm8Pq9CKShUxuihgn/h76jwcLurwpk=;
 b=MfRUCBgUAvqNqzcl4dkQuUQVf7WvaThEY2QrKED4Tv991D8vV8HlYa+63MTODtgyjQ3yk2SUdRMgCNsn3sWcpP8L4YErUIpGji//iFYIwM1oosNCX0efQpFG1UALJxko8v29Bm9ehIf4kXlneWNdUh/uaari35m7H0AIMNC309FgfcpCPM4TnmbYUNsuRTzcmexpLfZl80tiDNuKXXwmMKlJIYAoFywaPTBrlyIDvqd2gwTetMD7usGm5UwYU840teP52KsbC4VrytZnYeOg1+RP/O8w7kLJJ9NBhvzBVCEXtbZLGZS5t+Pajgjnsxh3TthuA/Haq/oDELF/YCMqJg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 05:27:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:27:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom
 Rini <trini@konsulko.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] imx: Fix critical thermal threshold
Thread-Topic: [PATCH v1] imx: Fix critical thermal threshold
Thread-Index: AQHbNSvyid4TMPRFj0OUXUIRLt4zCLK0rtVg
Date: Wed, 13 Nov 2024 05:27:23 +0000
Message-ID: <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241112175427.83979-1-francesco@dolcini.it>
In-Reply-To: <20241112175427.83979-1-francesco@dolcini.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB9020:EE_
x-ms-office365-filtering-correlation-id: b43a1740-b2ce-45ec-f591-08dd03a3daad
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DU2v1p7o/MOMzH/VXjkpuIHptKKu+9cffdHP3EmaByQbsTJr/dddqkCEWsWm?=
 =?us-ascii?Q?zgJRwPfr69vA57N6uAQe6IAyPGy/wcxEKYEyBK7biQfhk82jlR5NsTegS2a+?=
 =?us-ascii?Q?8qbRHImD7uwYPrddad+wq/qCMPNC8bSDak9n21XZw/yPNRmhw9oGix9a5PU/?=
 =?us-ascii?Q?pyevWsEUUbxkB7e2W+FpKXcRFPMvJYdh1YtIH3XK4g8RD4d9rwhSSS27N2Ud?=
 =?us-ascii?Q?snhkU2XzxKYet0H1U4fkXGJmx5h7H07eAfnbWmoWZduxprXCeoY+hR2n6Cs/?=
 =?us-ascii?Q?FJnG6wiz/PWif7YLlkrngxRtTJh2rlX9FfDOsW/z7LD6zhc6mvaj4YTB+i/I?=
 =?us-ascii?Q?QS7Ot8J04zPTd4j7fbmOkxSnKID51I71zZIyokc7UP46cVm14OT4q7grNKS9?=
 =?us-ascii?Q?bX7HIppeR7F6Q9gKEthpVHBDgKo2gkl3usLgCTKWIYLLLBLbX4tMvCVtHYHQ?=
 =?us-ascii?Q?1WIdjPNYlbf6dgm/4yma8blOMctAQiUrBOxaUeXhNxDlWVt3Xnl63nQSXV/v?=
 =?us-ascii?Q?mFpJKCNu59/9ETi2aKTo+oDDBiEQrryt8zGisN1cBlxl0+KooiuNdpSNMBUe?=
 =?us-ascii?Q?NjbL6SFl0LlfNtqzLTFs1WWf2WpG4dXyhHQK0A1T+SJQKpWZczVCOewR09Lu?=
 =?us-ascii?Q?tL1mSkk2RlL4rUt2crD0/YtZkPiDKcOo9as6Wedry3dMBaE0FiiROmEL3cJr?=
 =?us-ascii?Q?INaSOAoX84ok967NVSnvf+7av4lbi4HAwqQ3H0eTdNKdfSygZujburoFEeDc?=
 =?us-ascii?Q?gkLTCGjd1gHeDOx5S08u7mNC4niVQMd3FnzTbRzFTcSnFTALa2nzm1tURDa3?=
 =?us-ascii?Q?rTpNwGjhZFvwQhXzp/16KEa7q/G0RSyPioD3ZCq8kzFQUdjonhrkbmhwcsRv?=
 =?us-ascii?Q?QhpqgFudpMv95xK6EL0tEK+bKB1b/+dOnrLAzZ3c1goFik79UGp8ugR9958c?=
 =?us-ascii?Q?5CNtL3gb+JhP47BpyBhVZHuWFyEP98YRILh6oKoBtqvoQXT0QOSXF+un4kAN?=
 =?us-ascii?Q?m1I4LCyy3jepp6euJwzSj6Z/HDkLWeIwKgAcLirWjG96AnjUt0v31vIZJdRz?=
 =?us-ascii?Q?sd0ksALbA3gkVmAyzaYFWfWZaJSGuqQB5RRqTW7vBE0ozjRmYri4N+RT0WJ8?=
 =?us-ascii?Q?i48JHw4BMhCePFD+fiw32uyB2prpkLhX5TD1oVKrUXNpRZ+Q4CFFz54PQvxW?=
 =?us-ascii?Q?ZV6oi7jdX8RwpxtPu45tbVSrhiJTH+wNJGcTdwSXRT4SPVux0bki7z9HZsDr?=
 =?us-ascii?Q?2oEt9IcperjZPR2GC29HBqsEkVGMJIWBM1+sEaALZ2dfmpYAzmRryLc7IUqf?=
 =?us-ascii?Q?0nG0YbuhbLT2fiddfd5jSksYqDXYfsSNHVwb/tD1l6hOMRKacOIYbQrNughx?=
 =?us-ascii?Q?CjXKTwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HRWkPWemDrwtVZy43vvEbLW5Jsf2KPORNL8NiOw1y5lS/zrOZApnuqeMadWw?=
 =?us-ascii?Q?6mPQehtR75GPjaYbPIC4UAX4COMHg/R1csibcEAhZ6pRKe4Qdh5o6CmS4fjp?=
 =?us-ascii?Q?7bvFh/94nvoB1YqoKsoMqppdjPJaTThRPcxZYsOaNfM0kCV3koqot/tjxRdr?=
 =?us-ascii?Q?v/lTEIjpMfePyg8Qy/jvUkMv83bcnul/fZEGux/z4ewxmFiIQKn/HxbN0Ai6?=
 =?us-ascii?Q?jJBZ8j0vOOF8cqtuQ08F5xRS2OdDtw9Ro1yffqH1hF4kvdprVuF/sas75jWX?=
 =?us-ascii?Q?nBvGagR3aLn7of95idxVwtISOtvpktsvcavoEjfsxxsPEZSGM9IA7w9fd9IT?=
 =?us-ascii?Q?fOebWdP8SWKFwRld6Zpgo+mVF4Mt3yM9JNs0VMYm/Vgo/VdLaFfgqx0eLGPJ?=
 =?us-ascii?Q?SqqhL+ETyXDMPM/Hv5+oiL+YS+XADPNdqU4+tTKCj+BAPkierjwLr7FAwMjM?=
 =?us-ascii?Q?Gy5ET9wXktBc+MxmLrN6q91+xoDY9pq7ek3rOFYgYBqaJVWMTGuZzbjUD03+?=
 =?us-ascii?Q?VV/ENt/tlwkDhPWgnbT7QkB17UEC24lhH/O08dFcbRvsEoS4Hr/OYOdA7rSX?=
 =?us-ascii?Q?bMXB8+4s14R+farfU3hl/LxX9NwiUtE3eekZRZd09tYyraLD+vhiU11cbFqb?=
 =?us-ascii?Q?sapV7leR7dFvQWRE5Kr0rOgvNXQiNRYh7+Lvrg2eIOin88pksxueQ33paff6?=
 =?us-ascii?Q?RwN4BbhqSkDK+sAU3Rwd3ZSJT1TPvCT+ruAr1IyRX+MfKzcSaTGQgtLDFkjh?=
 =?us-ascii?Q?CbNCAVaZ3+2/TCZSrJUjFBRU7JEd8WhKcbQQhA4zdFGZ5mtpW3mQ8fTf+qnO?=
 =?us-ascii?Q?EKGqY37WcNNogzXTDGtngu3a+UvzoFJfltlB1imXa4N2d5l2Qp7csEp47/9F?=
 =?us-ascii?Q?Zzec+orZMNRFT/ThFJ27b4qeYRp8u+JSWTeKQnmONo6NOzk8f2pMcf8P4Q7o?=
 =?us-ascii?Q?PQuP/2ScD2xdHrLL/WmtL3bqdzWVCNx/eIVdKDvVKe2RVY4zfceW+UBjr60h?=
 =?us-ascii?Q?+vOudzZKr+HHVTEX+4KliIF1UptuhVwTsdRkIVNMd8emjvZzLo0bHCh2IyeX?=
 =?us-ascii?Q?ymdbDdOrgSlDsVotUKwfEacPzUp9tV84+xZXWffaO2OuyXOignRaPu4FpRJf?=
 =?us-ascii?Q?JCkMyG2gTGfa9kY3FuXHoD2imCyHeHEIt928pgMbzMSN4Grm8sD8w26LSiET?=
 =?us-ascii?Q?zim0gp+2GQY6r5U0pxlahGEKDrkHQmC5MsFdqdSLfeir3VfW+LdNqvCWxaGz?=
 =?us-ascii?Q?NcaxC9TdNG40Wd/7Rwi6A3OCNh41DjWOwX+LYK9H+jVW+KJKsp87AovW2e1U?=
 =?us-ascii?Q?qTQ5TI5704BF3B0XIx8NsTaNdy6NX9LpsvVYvWXv4yv+CSfEcN3y0Trf5Sbe?=
 =?us-ascii?Q?nWX9uRQLX70EhfqRiMHWmc0ZekSf40r4aMJGO42AwvgbTSRbW9QjaAVtIDFH?=
 =?us-ascii?Q?K0i6KKpkukQPbxmoYpJxqKdZ8iSsErjRlctmEn5eXZC3I4u0iaKul5v45rJT?=
 =?us-ascii?Q?z2d1/O1EMvNf36fuxUcf4CHHXRue8uQ4TEv17a9lFuJJ9eU9kCmsb02+WNY8?=
 =?us-ascii?Q?sn2uEqspk2bF+diOJI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43a1740-b2ce-45ec-f591-08dd03a3daad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:27:23.9457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQIMCAa04dx+i0EShzKQd2TT7naWgPFXdrMGpbNDoVTtA08lQoscRUoL828Lv0SHQLq6SP1WVQWclfAg+F1VDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020
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

Hi Francesco,

> Subject: [PATCH v1] imx: Fix critical thermal threshold
>=20
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Fix the critical thermal threshold for i.MX processors, this was changed
> while moving the code from imx8m/imx9 directories into a shared
> place.
>=20
> There is no need to keep the critical threshold 5 degrees less than the
> SoC maximum temperature threshold, what is actually going to happen
> in practice is that we are going to power-off the board when the SoC is
> still within its working temperature range.

Should we leave some margin for the critical temperature?

Thanks
Peng.

>=20
> In addition to that this is a change in the actual behavior, that is
> introducing a regression to users, and it was hidden within a software
> refactoring.
>=20
> Fixes: d0fe80890ab1 ("imx: Generalize fixup_thermal_trips")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm/mach-imx/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c index
> ac782e3ee636..103c1fc5968a 100644
> --- a/arch/arm/mach-imx/fdt.c
> +++ b/arch/arm/mach-imx/fdt.c
> @@ -115,7 +115,7 @@ int fixup_thermal_trips(void *blob, const char
> *name)
>=20
>  		temp =3D 0;
>  		if (!strcmp(type, "critical"))
> -			temp =3D 1000 * (maxc - 5);
> +			temp =3D 1000 * maxc;
>  		else if (!strcmp(type, "passive"))
>  			temp =3D 1000 * (maxc - 10);
>  		if (temp) {
> --
> 2.39.5

