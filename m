Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B47C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 02:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D80587F0E;
	Wed, 13 Mar 2024 03:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="r7uWKnFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FA987D82; Wed, 13 Mar 2024 03:17:47 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CA587C83
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 03:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE+YOSDB25Zxjz263kL5+IQF2VcPChdKYFG49oCz+E5gwuMkmRxDvsS3MJvHksS94BsbidzBK7H219uxLdvXzDWB0GsW+n/KQ9tjOUdR+zbX060RkAzHOQ2HfOLdZk164Ed/xf0coVgTfrCEdxXSx+WgeEnvILpfDTOXHK38a5GseuJHLRZ1ZDKnnvjzQraVdN6aKvT18XZeEJOYhXl8MNKZ6ndz86VOkFtjloJiXNyY/a2TbSI+z9Q0ADPdupEiwL1cDJdJ/ECKzh2+APU9CJU/NS6HK7MIDHD6PR+wnhCKql30Wk9XUjgtZ7uy+IiT3y4LgZ9FWEhpxbOSMTfF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bd7tqYNswVd8X20hxoKpsi2NJjX4kNeDvZVWa99o04=;
 b=faQa4XvQwpMXpPvaGNh6VsJqW7RWOhNynV9BRWNZ3y2lQgMUbMNirOO2hqqUHP2vYPi1qLju4cBpH7psvLHp03YKjUKcRtmjkkEvWbZief17rahHyqO32okPMAbp2Gud9TKYrxUzx27u32UIWdIgPpZqMdBnRAC5h9jOhVBn2HJNgdGbWHXh7KpPFjZnSh2EWbH3mVz7nvuaRlQzMU8uGrIil2Xyd3uzyW5EulPUxzOTvbClrF3VC7c8DPkmBY4xaepnpaEUlHcXsWjrfjFBsy+SiaLThzWhjFNPBHnfTjbiPmDX5mTnjKF9qM6XjvPZ/zs7OlFnONGKaae6cS0FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bd7tqYNswVd8X20hxoKpsi2NJjX4kNeDvZVWa99o04=;
 b=r7uWKnFw+MIMEGrrDj6DlwqPyHqZGaGSAuHYsGAXO5YG+zTfodh+1GRroYFlLuYyUgHplwT4CRIIhex0h5XYST7fbr9iIIuIl0vDMqwxSWHwKlDSEQSrSrCJBr5PxLo/9IwFAgTNQIUic1uvzCc3xoBfJjwIc/4AUVK3svEOQbM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7026.eurprd04.prod.outlook.com (2603:10a6:208:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 02:17:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 02:17:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "hiago.franco@toradex.com"
 <hiago.franco@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>
Subject: RE: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Thread-Topic: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Thread-Index: AQHadN6JvjEUeGsFsUa1tKBpjHIGiLE072Xw
Date: Wed, 13 Mar 2024 02:17:42 +0000
Message-ID: <DU0PR04MB94171731808BC7F06AD840CC882A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240313003641.2650648-1-festevam@gmail.com>
In-Reply-To: <20240313003641.2650648-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: b5fedc44-f7cf-497a-1dec-08dc4303c3b8
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NLPrFeRHLF0iY0QxDK5Zx/CfqWhuOe1lyj5I2G3xSLL93j+Wl8WbJU4eybSbqrjUIf/9NSyOTx7iLvdC165rWjZUlBidUuPWv6h9b2f4NTdn0davezRIrdnjOZaAqUx0gLnpvBP2idiFtj5fkeSyvnOYPuo96oZdqVZQquPrxtHYFRA0tjFPGJOkjzxQHV1/jgL2aSN1Vx7sKdGG3nw50mz8aQL4mjkVI0BaP8Ocuri6TV3FUKGPB6KPIRBPQmsROdE9rGChryyWlha/CzxZmnmXlgywkt9f2OeGiBTwr9fpaXL9IwizLrDsCit69rhweIo5DZf/m490PYhpUsiQ+uEy4HD144emfaO8dYDSLiCC89WPEZscqkYfQI8nf8QioXEAUmbEI4ikOAWbfCdsdfcTntKmIjcniZeTNhIWQMnKDU66AzFAqRsq+7b05VQTsz2aYQT8WQwHbhd6Iz6DAbpdQAk4zvWK7V4dlIZJNj8F2rWL71axIEoeeCod4XtW2z7KbBJEoNdYmIUM85LMNcgWhRnVIwJ8dgB+jVDxxR48jxgEYqGXbwK2riVUWVQxmIAo8e6Al9B0uD0OX1+VQzA29otP76c7uwWS1D5SxIPCEfCyftrTcBGbg/Uincbcs+eVFwJVjPdEeaazMSlVBR43GDG6iJ0qVDP9Q6/45/xV/P7otA6mm3RUZux2tmLUcJj0tEGbOLTB8CQhLQoWyxLG9+bPdakmezMzQ7eKdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GyfNqCe6EO9fAT/Eymedc18DQGiZWym1+uIHX4tHHpB3S9K+oBVhBAOMJnX5?=
 =?us-ascii?Q?C/Lg5NDkZvY7aKp/a5Sak3Fn+dwiMEh+SEnwPPWxORGmwNTpW/ZoYFJ7t8Ao?=
 =?us-ascii?Q?7F8ZEX8NhOW0SuX0LWa4i/z3kyBoz+bR1tu7wlYcBIuCYFZU+hv+5biVJ5ux?=
 =?us-ascii?Q?SGhxlvyAV7MwbjKNB7ANYVm16XrihBGztqDJDxhAQNUyCARmlju4p1bGOmnw?=
 =?us-ascii?Q?3StI1apj0jFYgSHERR+K6uAWPvIHjwbHQNrNl3ed8ID5PzTouyeD7eUNnuHV?=
 =?us-ascii?Q?SfsWEvF4UKURh39duZNOCk7r3vyrCtWNQtL02ZM+SHY606bFw+9rLRaTKK7d?=
 =?us-ascii?Q?fSOCrx+tzde/v6tr1Dly1WZx4X3RR8wbqCoX/FedQQjW5NOeYoYN+z0954NY?=
 =?us-ascii?Q?dyk7KWnQkVgfn0n8zj5Q5IQyVCAglqFV2M5kmpdRSsRhjEnOqson4iWCPwIs?=
 =?us-ascii?Q?zq9vdiKN0ClA0rMulbSQbymkerKR8a5SiuyM5x7ssQRn42PEHdzKiPCHonbo?=
 =?us-ascii?Q?JallruqaWxUA1pCmnmkQLJVVOwTyclSihioCqDfkcQfdqEn2FhIqcuYfOEaO?=
 =?us-ascii?Q?Bvssb1Ab+mwwcjXqWk+u0+pKX8JNUIVQiV08Sk4uPnoB9ih+IN28PkUHUjY0?=
 =?us-ascii?Q?9kFyDJ2zPDwHnMVxBZfDOt4pGVTXNhVou/aCbzv3bOgfOO5Tv4Wnw3ZDbl0W?=
 =?us-ascii?Q?q5BQEpAYT/lAGE8OiVCeu7J8DMdA8v9OJ3tt4MQ0DRXkvvgfqcWYtmxEkHN0?=
 =?us-ascii?Q?e6npyUMw/VNjDhz7BKo6z3sgZGlEx2mLEgJw43DCF2G+XmD/aNDjK+9+lQRE?=
 =?us-ascii?Q?fm7MY4oX45hFNe7jqF3lydihkQo+A+fMCK4aj6b7lsu73Xs4L926UOxGKvXW?=
 =?us-ascii?Q?qdSyeCttSpMXfcSVTeLA7/HopObCxvoxR6uKV00bSKeH26dYC96U3UUVkHE3?=
 =?us-ascii?Q?H84hr1yahgk3KWGVCft1U2Kn3HrVOIe6376D5KIDYqzffyGXrVR44Di09uQ0?=
 =?us-ascii?Q?T5wF+MaQh3ImeudDE0LCNEVzkGOfqI0tZIiJJt6Z672wBE2B3iGwSQ9IFDOK?=
 =?us-ascii?Q?E2GUGq0Cb+95I7JIzQkiBTLYd9HkiPGA3EM5X+Xwg0pw8htnQ6dcHXC9H/O/?=
 =?us-ascii?Q?uBqOFUxfw+dIklurYVX83wePfaudAyarPrFkkhqVThDhWLvUAjIrQojFlRWs?=
 =?us-ascii?Q?yd2YO9LU5XmIpMtyOcBe5Zz2oxSbcc+ZEKdvFW5xnObBa5WgsCxtKKF3YscA?=
 =?us-ascii?Q?cYubPbxqa+xO0vjl1xXGtXPOV3FoMfLa7QV22m8OMzCG2D3ouJxiY8UAUoYq?=
 =?us-ascii?Q?yVw6hrIB5stfWR6BUmh5qcK0Y9Zfe8l/sPa2UVT7xbkok+ZpeiYob7D8fIyO?=
 =?us-ascii?Q?FGNZx1Gt5ZVIVw+4nUn2NK3T/tIAbIrnSjmqNyEZJr48Z2sN5Pq/6aqfXcpR?=
 =?us-ascii?Q?HpooXTKCxYyC2xT/+eCqwAR5tRz8w7ahi1BSdRRL/vusxtEpdOSMy+aNNtF1?=
 =?us-ascii?Q?EzxTG1j2blURpcwP7+GX8uVZqeZ0U85+RmPFd/t9Cw7YsB+pXBsvkCRervcA?=
 =?us-ascii?Q?dYFX9XJb8cKmVt/s7JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fedc44-f7cf-497a-1dec-08dc4303c3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 02:17:42.6826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtxbM96GKbfxdQOFdbOmrFXKl6e0TIh4J4LBC9OsiYkE/L+FZBDJXKF2Pa3RasriKYDuZ6F5hLgHVecnjSgKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7026
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

> Subject: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
>=20
> Commit aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> made an incorrect logic change in the error code check of
> sc_misc_otp_fuse_read():
>=20
> -       if (sc_err =3D=3D SC_ERR_NONE) {
> +       if (sc_err) {
>                 /* DX has two A35 cores disabled */
>                 return (val & 0xf) !=3D 0x0;
>         }
>=20
> The other changes in this commit are correct.
>=20
> sc_misc_otp_fuse_read() returns 0 on a successful fuse read.
>=20
> This inversion causes board_mem_get_layout() to report incorrect RAM size=
.
>=20
> Go back the original error check logic to fix the problem.
>=20
> Fixes: aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> Reported-by: Hiago De Franco <hiago.franco@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  board/toradex/colibri-imx8x/colibri-imx8x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c
> b/board/toradex/colibri-imx8x/colibri-imx8x.c
> index 2c673a4a6b06..6fc8076163c6 100644
> --- a/board/toradex/colibri-imx8x/colibri-imx8x.c
> +++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
> @@ -46,7 +46,7 @@ static int is_imx8dx(void)
>  	u32 val =3D 0;
>  	int sc_err =3D sc_misc_otp_fuse_read(-1, 6, &val);
>=20
> -	if (sc_err) {
> +	if (!sc_err) {
>  		/* DX has two A35 cores disabled */
>  		return (val & 0xf) !=3D 0x0;
>  	}
> --
> 2.34.1

