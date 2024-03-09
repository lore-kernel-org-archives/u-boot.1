Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B09C5475B
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 01:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B9587CDA;
	Sat,  9 Mar 2024 02:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ao4t3Gmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B007787CEC; Sat,  9 Mar 2024 02:15:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C213B87B77
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 02:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IswsnRDjITcreamxmQynhRGr+6VQQhP9Yl6ifNnvWzjLGR8xgoMplc26yY9cIr8toDElV8dNA9syHAHOnXlrgb0NuQ/V2/w0F3TXePuClnb4I7QA325Cw9TCo0w5jhnkt0wvevlUkIuGIogDmoFcK7jlhqiG/Hxsm9D/AqYoEIcoSkww6hqwpc5afweuu4olEhjNo3VEHPUfjPXUJB+oPKkYvgcuQ4+i4ce2AMF1mPc2F+up0+ldwQW0i/3YEvTH0ImvxR37bH7EbPrIBDkPlG4ImzaLmldAcK9HA0HtQuTuVcnY5ApDVNqM46qGiqCcfd6oRJTSpUNUdJ5ZI+iBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDKGLZzhbWaVCgGa2Jc0ZKOTOJS8n+3cEUT1Eu+agmk=;
 b=IDX2nBVAwDXa6B9NUvI9DNg4kUxqfgOX7j9dZjOWDjfj1RB2wb4FINmCX9Gu0RKBBF0dNUEGzjaMiXe7l9ZyiAE/CNVDbSmQhbAeqFpuYB/JQwmRUwx1BxwHLMiF+Kc42Zf2bRVn74tEZ6cgNXe7LCOgS/i/7ZFsZLXGpYbd4aRMcQCIpmORRq2G7/OWqU3ZPW0Mit+iJqxemdkxI8mrmcHNpWZz34m44dcd8fvAnv+ZV0sm6ES/M03rrvPpqDs6y9Swq90L5iBNfg48KKEUJjG+651DQg+6xP6L79Gvzo/gZ6hEP3nuowreakZ6/NqL1k4jPsWlrlxbxVWdFFlT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDKGLZzhbWaVCgGa2Jc0ZKOTOJS8n+3cEUT1Eu+agmk=;
 b=ao4t3GmtuLjHZhHV5KMo826wvXIdg9bm7kcHPlvf3wTzry5sTNTfA166mEKqSREq1UWrm42kja1b5HlqWwBbjcFJqFo8Qg3DrzOfwm5TFYKTuG4OS9XRJ0t4wFN4xCy5sLoi11OYbvqfS2Pn4hlDZZfBHRJh/L7B56LDnDpRj2E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Sat, 9 Mar
 2024 01:15:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7362.019; Sat, 9 Mar 2024
 01:15:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "seanga2@gmail.com" <seanga2@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "hiago.franco@toradex.com"
 <hiago.franco@toradex.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>
Subject: RE: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Thread-Topic: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Thread-Index: AQHacZUTRDk5hEdMdU+OeK8smul6FLEumz3A
Date: Sat, 9 Mar 2024 01:15:26 +0000
Message-ID: <DU0PR04MB94175939E19F7DDFDA77758388262@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240308201316.1721909-1-festevam@gmail.com>
In-Reply-To: <20240308201316.1721909-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7923:EE_
x-ms-office365-filtering-correlation-id: 035bdea6-e5ed-4c4b-6354-08dc3fd666e3
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUMb+/20u2PBQDXpbEglOi5U2LJfy7W2Ct47JC8t26dbOkC0A+qwH6yO8YMfFNR3aCGGRWIyb4Y40bUWt14y0h6oe8ZEJj3N6A5rT5p/+Veo+8FdJrmnkB7OstWqIGlRZQO/UBBsObYE5k6+f1jR0fJ7KJWdypSnk3ODH/CEUpxaGjVDuqeoLbeKpfll99H7p1c5+AJHrD6p7bCmu1GdeFwGkvH4YhPOnbOcHE3bIMQIz4qcF4sJVOeWcW1u/vnxD6tC/Nz8grrT88d8l943Zras7VJ3SQLZ9qeqfXAiNRNFmpK9+7ILKHbOpwbLk9jnONdg/k2DuKZerIOTiMs0WeJU+UVUP9Ctxn1Pdd+nKPesSUIm8dgrqbVjfk5xkD1eynhg6H/QLv5lZ6tYs6Q2nn5MLp17JLGwE1XJbVIvqBEjGAxdMujo2kBUQ9qa+Y7DmGUFBTwsVbFkUs05ci5zI6gT7qZ/88At78CWkfOoAfoyOyijAAGRfd7Igux4F8X5GlLPLc9E/fYTF3zqeAG+m+qva2STag7XZ3mwPr9LboaMD1ywPzDCTkGCBumoWu4/tkFw5art+JxblPncsNQhPUYwbrgUMXy/pNHsTaiPdQul4K7jX4h7T9PilwEaV5Y7pEha7vC36Jaam5tfowCDigAnhzth7pqsA0eucpzeF6RqAaQnOqjlwuvrNFVi36Yu3eAWZ55zOUSqIGTMHGBMSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3xJnefPP3u56BafRW7wQxOrl8+iZItiZtdKSV8MIcMHLT2LkHF0RrBvxrjox?=
 =?us-ascii?Q?dJjlGyThKsVplxFsVOYi6LCKwcTPjlJ5cB7TkUQnxzaFciHVpBnwLFyM3Y27?=
 =?us-ascii?Q?c9QVhSvrtHB9iiXOE17vwKDgNIHaLjy1BKNW6pu6gG+EwLGfftoH3Ju4+tPH?=
 =?us-ascii?Q?kE+TaWETNtHrQmbaxgaZVtTqZvEtD2AzMR71MTna6ok1ufp8pGAMYsuLW+wi?=
 =?us-ascii?Q?R67dFQSTlbcm1wAHK05TuRzXWuWk8qUXwaXDPAlDcz59rm5rEa5PsrMsw2/f?=
 =?us-ascii?Q?LVSD8IyePSRkP27YcU2Rb+K3C7+bLB4amRR1KGFhhuHqB8pElzGkq+pQbV/6?=
 =?us-ascii?Q?J81pMqXRcKDLF24FRn9y1BR9FH3P7F3znbwSOEx/9+Z4xzJq4l2vueIkHR5T?=
 =?us-ascii?Q?Sr8q8A6jB6fYdBWTPDnJBSwJaiNBZSlUcQLVeC9Kl2kLwuT252aqokgol06W?=
 =?us-ascii?Q?fyXf1mLuE9d52rOVhOzn+1A1PbYov08Nv/E5VuVHZ1NPAUTnGokAfkktsXUh?=
 =?us-ascii?Q?CYP/6yPDS/n3D/Sl2cANgQ+tHLe7LXD/shcK3dsG4fhhKnC9swuNgLmqCN6B?=
 =?us-ascii?Q?ekVZNyjP5xmiwEhuLlJvkhSiYCUXEVpXgbQc1JifVfxss4YlwB9juIpGpM9P?=
 =?us-ascii?Q?aX+ZRDJWg2t475Se3iSX5GxHh08Pfjq9AYOAMgHMco3Uqbs36kJCpQhJ5Pcz?=
 =?us-ascii?Q?0QQF6tKPDs5S4aGlNo4SoiVmpigMa++2WqYVa3NrT9aOUr9wNdhugGdPkhC5?=
 =?us-ascii?Q?EE6PSQ9/SM1qTgBhVjQm2dg3kGFldO1FH63GWk24LgHTQ1wdmwSy1Rq72pJP?=
 =?us-ascii?Q?dj39L4iUUu8nbH7nYGgg0F75J4wuICIkMeZQHJOlyCHd7r4D+7MDsNidwwlS?=
 =?us-ascii?Q?8AZe+5V2gQEzJh68vF1NGrCFeeiHe2edZOFQ0npfPqH8YWLfNLC/tW+PatBY?=
 =?us-ascii?Q?riXPv6/cO1B7azhsioMo1o95WXUY65CmIjFdNzKrMOTQAT3RvTtyrZLHSzZ5?=
 =?us-ascii?Q?7UM8LQJWHGUJ8Pe1VL3P45EWvAxyx5x5AbpsPm/6m+PA72zalfWrlgfZAwpz?=
 =?us-ascii?Q?exLP2q9igVEDxPqngXJvLPViBhOlH5Fyj7kbBKzamxXTfLxCDfvIJ739Dbhg?=
 =?us-ascii?Q?B2v4Ushou+EZ97jHmGHoWsWQn2uCFORgJZt5j74mchdvM5QqE9RCD46daTaV?=
 =?us-ascii?Q?GZF/YlcDCIte/lA3bvzk2wUEdvU//OUn5AXCY+MGDA0Zek/p7ov2CdiFXEYs?=
 =?us-ascii?Q?gQtoPAYcGjPEZrU+t4SJR2FrEjms5TMX7WWx5jZr/ot42m2x8CNyBWU2n3RE?=
 =?us-ascii?Q?Qt0W1j+Tsg+QK9xUhnKWjpy6AefVXMtpIcxdoqZgvRpQZNPaqDl+LUdzhEmn?=
 =?us-ascii?Q?YuJhSjaAkckeCYC8c5Jybeilr7+9nFmBlhLD30G01TX7qE/DyVq2lUE2N+Xr?=
 =?us-ascii?Q?7lpPA3JeHOpu3BMn8nwXOXQ/+dOFbfYVswoAnEKjsQd7oYhMGXwaxGXx5xnh?=
 =?us-ascii?Q?pOQQCcwtvc8UtUGZkqTqBTGVscghBv6AHD+HBe505jMn43A00gbvmymNrRZK?=
 =?us-ascii?Q?EjXbXGHgyfalJhaC4BY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035bdea6-e5ed-4c4b-6354-08dc3fd666e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2024 01:15:26.1049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zvsl9aAPkK4zlbxRGil5XTaXhKG3OCAoYG2hrOx32Oaw23eIZJa+8mSrYHCmpEpBRqUNzs/D2eS47SvSePvjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923
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

> Subject: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
>=20
> Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock") the colibr=
i-
> imx8qxp board no longer boots.
>=20
> The reason is that the imx8qxp clock driver does not handle the LPUART IP=
G
> clocks inside get_rate(), set_rate() and enable() functions.
>=20
> Fix the boot regression by adding the LPUART IPG entries.
>=20
> Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qxp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.=
c
> index 8bf7e325481..d900d4cd528 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -88,20 +88,23 @@ ulong imx8_clk_get_rate(struct clk *clk)
>  		resource =3D SC_R_SDHC_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> -	case IMX8QXP_UART0_IPG_CLK:
>  	case IMX8QXP_UART0_CLK:
> +	case IMX8QXP_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART1_CLK:
> +	case IMX8QXP_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART2_CLK:
> +	case IMX8QXP_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART3_CLK:
> +	case IMX8QXP_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> @@ -170,18 +173,22 @@ ulong imx8_clk_set_rate(struct clk *clk, unsigned
> long rate)
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART0_CLK:
> +	case IMX8QXP_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART1_CLK:
> +	case IMX8QXP_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART2_CLK:
> +	case IMX8QXP_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART3_CLK:
> +	case IMX8QXP_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> @@ -263,18 +270,22 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART0_CLK:
> +	case IMX8QXP_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART1_CLK:
> +	case IMX8QXP_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART2_CLK:
> +	case IMX8QXP_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QXP_UART3_CLK:
> +	case IMX8QXP_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> --
> 2.34.1

