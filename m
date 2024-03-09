Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44AC54E41
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 01:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CC087D48;
	Sat,  9 Mar 2024 02:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EdASMlZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FD187D4A; Sat,  9 Mar 2024 02:15:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60E387B77
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 02:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3US44AIKBgvxiS/EQ3Yv5WE2PyRJxNzIV+uWl5sb2jW3bBnFzmegYDpyDtUOB2bhm0vcda1YyuQEn6A5A8aChwa7CuyOOdV6bLoBdlmTjcrcpsHSRkYQPGnML7M4fGofIF9BKH8wstqefrxUy77LlG/FW81cQtp39R5/1x4zLJ3cwyIY14lrxX8xiBsj4r9dJ+Lof4eHERFtPsqnn22eXqBukQUbhbxquSTvChT78d0M8Ha8yGDq7/jcXr4GhXc7gsI8aPlg45mmL9rkMD0lrr8Ek/kqRIIgnbRwg+3pMeTzr6b6XHtvizVszyRQLBiO2eByuFmQNF+zy2ciX94Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry/notnlvz0nsh4gX3ghYDlUL429NWve84j6NuqhNck=;
 b=CzKSKe3dHO9d3eb64yq0ipdRNOCRN8e0pecR03Z0E3fI9JhVfw+vYRaaxVOKZzBW/YacosXiFQpho456mhDQ0VCgZCL8DHMzN8HxNMDMjn8BU09eTR9ZXrdgGfp0NAvHuUBbDQeNgn8I8zhOyYDdMU4ple4UQL5ih7J1qUqWGOmnAtvu8UqOkClsAPydfBQAV8753jeIcj2pn0Jk4QI2WkmRxNRFGOaoVP9K6gbknteCj+n3RclXRiQXCo8ooTbkhF4OaU7gd2EwQ1z40y+brUeNvs7vyZ15iumsOyyeVITsnkL/O39Wx9Qe5SLkFnbQJ+8bIttcY0nbsTEtjrMaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry/notnlvz0nsh4gX3ghYDlUL429NWve84j6NuqhNck=;
 b=EdASMlZQY6L/iHSyetlS2B9XDNmCPGHxA46j4LweNiizNmqgD8PjjV2frEjRJ9elYKAtoPVS3RIyD+wPrsGV0fuHpllXzrKZyFKlmGwQSiPCduIk/k4eRe/+tCyxpCDpRCOcDIcGf1akAO8SBcU2vLOa4t/cne3iCfAWlY754uM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Sat, 9 Mar
 2024 01:15:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7362.019; Sat, 9 Mar 2024
 01:15:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "seanga2@gmail.com" <seanga2@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "hiago.franco@toradex.com"
 <hiago.franco@toradex.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>
Subject: RE: [PATCH 2/2] clk: clk-imx8qm: Add LPUART IPG entries
Thread-Topic: [PATCH 2/2] clk: clk-imx8qm: Add LPUART IPG entries
Thread-Index: AQHacZUV6BzRiYZLFUWH+H0jDjIZtrEum2Bg
Date: Sat, 9 Mar 2024 01:15:46 +0000
Message-ID: <DU0PR04MB9417DA468813AA43CAF21A4488262@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240308201316.1721909-1-festevam@gmail.com>
 <20240308201316.1721909-2-festevam@gmail.com>
In-Reply-To: <20240308201316.1721909-2-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7923:EE_
x-ms-office365-filtering-correlation-id: 796e68c1-6858-40ce-4f7f-08dc3fd67314
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rpE38W6L8XJZ8ozfa29n9oiZ5j0ABt5DGqKEjKl8iAXv6OXVKEOnQx1YVAmqHFiD9wkOoNO0KTSSTy+ZH3hfMCIv0IIxD8ArSbvUSjQTwdbh0sOdT9T3W1/MkOcqlmWbedV3mBgKZhILCcDerw1U4m9Mq6TKxVvasVIjy8XxzphtO+x1I65AIAikz+sKA7NLdFIAvhLK/aGVrzEHJ8cPxzPBwvs79JmQ8vAswCb5yYk5qWamoU/WRpz7BxLN6U2MpuSiI5uLu/OUc6/4NrUG98KIuQzR2RQ9Nwfm0n9IcjFZY18FwgS1sQcwTTI98OhxgYlip4m+CUJSHFI3OU38LNZR2G7UeEcfbXx3MLkYD7l/LK+1g5vGIsnMR6+w9wWIi/yhnrcYhdoNYVe1DJ+2XxNFp3gAiBqXVxMW7wTwV6fr8+ee+lSKxvQqu1BMSu81Ar/11kRaImzU5mL/+wdiT0DHclGjsDvBEXHF1AM5ZNwdkH9fJJEhWFxX6rKbjHqOIA1/O/BGVyM9fOJebBI0MyExPXaEiNqrSiNXOQDDGjBvKFqSCYPdi0XpnLiVYKVZ9kxn/AInRiMJ+nwL7saDdb0NUVJ1ETvJlTCOoVsyotiOpg3ffbrWOfWP2Reit17cXmRAbJubgoEuIcSJHZPv5Kd4xG7oczX0CQkC2ECRm65LYqx54ucUUGois7+v9eejws5Zz7v9XFr34i00KnJ2jTZhQvXVzoSP83Az065rVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5N611IV9yq6VYOxrz1jAud/rISBOoD0640K+unSVbqKmDpnzIUPzYfY19QIe?=
 =?us-ascii?Q?XfpS2D6295S+wn1vWZ5O+4vTlRNrOffeOvzs/WO1HRHImJkFdelAAK62SWMc?=
 =?us-ascii?Q?i7o1V5QlE5XaBeKoozsTcPfWmOJ8bN5DDmP/Ou54ER8tD+CX3TVJo241jpxV?=
 =?us-ascii?Q?eaV2a95Yis+GQdL2n+oh5V8FAN3LQ/n6zjz4dmTS/JzsTt4P7hIo7FV0pCye?=
 =?us-ascii?Q?82vM3uUwjeGgHtIkttzTAMOktk2eWAQETy2pu1MiAI6wKGtdUt62s5ZchhJa?=
 =?us-ascii?Q?pU0Zj6r4K2UX5Y0m5LQywQEKRpQPma/MZkqSNYJF9oBa4tK+SxwG5uv6oBvj?=
 =?us-ascii?Q?T4XAadN1ehHirCIAGwdpAsiR9bClOQBlafY9XFVgIKLOSLrMSHU0mO7DLVrk?=
 =?us-ascii?Q?SWO3KoiqZQji70RnreK6pNHAoh3fd2iiUB+cvmX5GACo1fqbY6NSWUXQILim?=
 =?us-ascii?Q?lPnXUTCSd6KIE8C86lekjMEL4F8hRl3GlXNJF31BUYx44EPCzLz3fOQI3uFn?=
 =?us-ascii?Q?n6NmOFUBtcZCxcN+ZGKVi3BeRAs4GDmpZjiVaIzAfkGm4fWwr1k+nHjk9G8L?=
 =?us-ascii?Q?OglKgR4rQ7eimT+YKLrIQgVlylxtSTXlH8DMz3oK5+yGrObPKJZD268Cxq1o?=
 =?us-ascii?Q?chq8ZagLyIIAf1VY6tOykSEkwQeWGrJZSNsFYR3swo/o+oleNpueVAWddXX5?=
 =?us-ascii?Q?VBJh2qkyytGB3HjN4tiH14P1cy2xVhGerV/lcttR4fmJGoHVq5qtsWgPQ2FL?=
 =?us-ascii?Q?C4PgiyWQbODp77fl+FcZlEO83J330ujQXgWvlWJB8GxM5dps9xyGZz+hjmaC?=
 =?us-ascii?Q?ehFDfT6sfu7zV1aosHe+Q843OIy0pcf5uyItA8PNPbtXM2Tr2vmX2vwLnIZT?=
 =?us-ascii?Q?NWrSPYEE3q37Paz7BbOwVZf3op6jgiURE4hN/YM3ZRILzhJgJ2391595CC4J?=
 =?us-ascii?Q?nXhiBLkZKv3N+CnQzOsazSW6vzj0OxBfyDjwUgDsyTZ4+hQS687ehxquDKpV?=
 =?us-ascii?Q?igFRPxr2i8JWDRzLVXPLp5Sd8fKrYFDpUtSfv+UN4i7OALOwneX3vOdPInxQ?=
 =?us-ascii?Q?Zy70yum1OM/AmDPXYn/VuYs79fFqbUFdoeqOK/67BbySgEbmma5u0ZaxYl1n?=
 =?us-ascii?Q?vZ7ZoASDxssHOKCNrLfizTJ0sBbkWIFFOcUKecRU+1g8iH8QqCrnLynNUzf2?=
 =?us-ascii?Q?2ZmxBETLYyPSiISJxxLgQcqdwZfWljn47r2sl4MQO66Lpl4fj+6+H4wRQo5L?=
 =?us-ascii?Q?HYftrWHh9K7lVhSifmc0CBpNfV0XHzeJ6dTso5ZhWqa1ukEJ4Q7/12hgEkMz?=
 =?us-ascii?Q?kuxARJ+M1FOYr0DbMaOdRbnMFuQ4tVybCCIicY7dHrpB9k8wQIc5VanIt7GL?=
 =?us-ascii?Q?mEAYZKN8A+3B80kOb9j//6BLcN4NlAbNFzer03UjRl0Zz6UmuTgBhvvEiBX4?=
 =?us-ascii?Q?8ZVCdBaSnvPn7Bep77GSsGvQB+HJfSKDcZM6+Msmexn152Z+HMZXpBfijND1?=
 =?us-ascii?Q?OG8BZLsWqBKDZXARd+/PdDTXYt4G8TYtE5Mya8hn5juqS9HPng88cd5BL+kb?=
 =?us-ascii?Q?tug303Sj1h18VOHC6RU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e68c1-6858-40ce-4f7f-08dc3fd67314
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2024 01:15:46.5943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Uml4K6CjbVv7a1yGEGXVIgn5BV5Z84x/W5GPS/ykQS5Ro4jmptEy5QBGYNIgPbFyj4Jkj7PDX4UtIp4DThRhg==
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

> Subject: [PATCH 2/2] clk: clk-imx8qm: Add LPUART IPG entries
>=20
> Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock") the apalis=
-
> imx8qm board no longer boots.
>=20
> The reason is that the imx8qm clock driver does not handle the LPUART IPG
> clocks inside get_rate(), set_rate() and enable() functions.
>=20
> Fix the boot regression by adding the LPUART IPG entries.
>=20
> Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
> index 6c05d07c340..01e33de9d63 100644
> --- a/drivers/clk/imx/clk-imx8qm.c
> +++ b/drivers/clk/imx/clk-imx8qm.c
> @@ -95,20 +95,23 @@ ulong imx8_clk_get_rate(struct clk *clk)
>  		resource =3D SC_R_SDHC_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> -	case IMX8QM_UART0_IPG_CLK:
>  	case IMX8QM_UART0_CLK:
> +	case IMX8QM_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART1_CLK:
> +	case IMX8QM_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART2_CLK:
> +	case IMX8QM_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART3_CLK:
> +	case IMX8QM_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> @@ -181,18 +184,22 @@ ulong imx8_clk_set_rate(struct clk *clk, unsigned
> long rate)
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART0_CLK:
> +	case IMX8QM_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART1_CLK:
> +	case IMX8QM_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART2_CLK:
> +	case IMX8QM_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART3_CLK:
> +	case IMX8QM_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> @@ -283,18 +290,22 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART0_CLK:
> +	case IMX8QM_UART0_IPG_CLK:
>  		resource =3D SC_R_UART_0;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART1_CLK:
> +	case IMX8QM_UART1_IPG_CLK:
>  		resource =3D SC_R_UART_1;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART2_CLK:
> +	case IMX8QM_UART2_IPG_CLK:
>  		resource =3D SC_R_UART_2;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
>  	case IMX8QM_UART3_CLK:
> +	case IMX8QM_UART3_IPG_CLK:
>  		resource =3D SC_R_UART_3;
>  		pm_clk =3D SC_PM_CLK_PER;
>  		break;
> --
> 2.34.1

