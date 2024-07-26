Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01268C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EDD288498;
	Fri, 26 Jul 2024 10:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E058688365; Fri, 26 Jul 2024 10:39:52 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20713.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A912C8852E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO0yUM/EHYHFGej7sGr8dZOnHW1r3OHeu5FTh6x5bbMjymGW5wiuqnm8ECiAEdj0z3SJILYr5Rmyu0G6t5dt1R2yeiR5kxhGwtDtcEoLadtTnMh9vdEftmRHBdhrEdJiYesXAKFMtGEwpyVvdZDgBHCbs/6cjfv3E+6bbgGbXtN8LsJloArR6bHIhryN2AILFeLEV5jmh+QB0K3dJeg5v0vI8HEPMS6H2PuBffv4eijfKacgV6mjhli1a6F7b1/5gmH5DTM7CoacLA+utQfkahKGKNQgXCo13p9hGUTE7vqzKOAAV5q9tAGpkKcO/ETpsnCVxNJ1EsFsW5MWaVir6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YJk0yQyNwEZduH0od256RmkoSe1qD+OUlxCvpr4Urc=;
 b=TMjr4909RvNGIMqEOIDVZV195YJAR0G9DIKo+5UZLlEmy4YLiL4EYZsXo59FPgFtPOhqCprVgzzWjYW0ywpX/OJLVer+BWVlBqOec/oWvfg+sjMMO4FKy0I6q0Xbj+yqocsySHLddU+EFPAjey1LyBbPeHRftuMJMOJ9T+Eh8mqkI5ih/vbawZRJ4I/t6cR/FX2ZRUMISHUa7ucuTw220PEqqK+XPBgTtFonazIYTABXQXAwDksG8m5nJgb77fZ/xMA24M+G1b4O3F5leu6FMT7GbwfAq6Ru/k+d24ZXN6zLYW6LgIt46qZsaKJ0BbsPboVVisCsxzEnCvAm6+sc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0592.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 26 Jul
 2024 08:39:45 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7762.032; Fri, 26 Jul 2024 08:39:45 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, E Shattow
 <lucent@gmail.com>
Subject: Re: [PATCH v3 1/8] usb: cdns3: Set USB PHY mode in
 cdns3_drd_update_mode()
Thread-Topic: [PATCH v3 1/8] usb: cdns3: Set USB PHY mode in
 cdns3_drd_update_mode()
Thread-Index: AQHa2XxdT1SAHeFxRECzGPyGvtFHBrIIu8Dg
Date: Fri, 26 Jul 2024 08:39:45 +0000
Message-ID: <SHXPR01MB0863FF59B039949CB64B748BE6B42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-2-minda.chen@starfivetech.com>
In-Reply-To: <20240719013822.101374-2-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0592:EE_
x-ms-office365-filtering-correlation-id: a87ba98b-fab9-45e3-8006-08dcad4e8084
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: /cpAm6KVNBVJfonHmKfjsG334L1Xth86rURYOqV9Mb28oxWFmVQmJoDEQF6ZS8//4poJmsMAqJz8C9aVyeB+x756Hfk9BeXSXMUAsuplZS8kJHQPOsnjOlpeLSw5VHD3tABB3HDGdCYkYn+TeutqcdqWIQ/3+u3oFJ35pybr3rNvL/F8wFHns9Sk/+CIurZxmOmtYE/hFNu9gvv6iBL+JfjOVGuG96v5rSOtCD3UYsRuRmR39XwdRbifwpWmEOQqPV/WinKyl0JqSofhSwZoJi2qHvAK/MKbMSr3wbi6u1UV83xl/Am0SwyxWJAdXQMj/5gK9hSFN9lsgVeUIlRReEnZRtylGVZBUQnjaxdFwwBFI4jMH2FMWBRyjwCF21YJJxoSj6sg+nmu0ZcEJ7GkpaUr95OD1smRR7FZwodfIu0Mjg8lEWSuRKlS2xDNj3pToRsmh2ZlrFijtK2b1HNBKPiljMTjX7FEMAFXhVAHDJWiFB1H/GCZG0JIB/gnPTsTUphrHWXjwQkF6Pzz2zleuzlEl9ddhS+qtMNmxW9f70v1jQDqY/ytACy44JyixDuXu5v8Nex8WUckwU6yfoWS7AarRmrf0megQ61S3iqaVvUIp4sD4CqoV7lmxJzJAsaEX66KH2H5nf4I85Sg+E4mWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WJakEkLQVzqKHs84DTwAbq80pgB2bSD6bqqS30DjFm9pDzH5Ydveuo7QUeZZ?=
 =?us-ascii?Q?3xYLod4E5jfBI756K7Mq9UfvwJjMgqd3g61/ri1o3Vre47jOxEOPnUmgiGfI?=
 =?us-ascii?Q?VvUbeDzVUOqbqD+IDSf6DkNwUunizYAADpIw0atlX7BxfxXPeXDZTqgI7u9F?=
 =?us-ascii?Q?LOhEygeEVYBhNHWkbDkpJ+VF/W3lZP041qeuOGb7gYoOAE4BOhXDY9VCxnnw?=
 =?us-ascii?Q?HXxRdH6RJgbwLHx6Yg2M2j4pPApBu0dbrRwtVtxljQSaJNIaCqZ/f/WWWzEj?=
 =?us-ascii?Q?MWOZZE89e7iV/FrM1FiyJBCmwTY/daNG7tfX3kJtJ4hZ7pPUCYQprQSx5M03?=
 =?us-ascii?Q?PWhFiRXWGvsakWvjzoWesLkIDaSVmwQxDaphggwjHEu51QIrhRZUKPcOcMJK?=
 =?us-ascii?Q?PTCZR+NSfaHW5iyrdAAmThG3zbB5RqHf09CGzTNagGOUDtC5DvuGTn39s9qk?=
 =?us-ascii?Q?4bnWyQ0f9cCfiYT+D4rRO25RGjqgR70yHUaX2NQVF3QL9KfHbKTdGKP2L3qJ?=
 =?us-ascii?Q?LJua0vPTfRP9e+Kk5KL5VH5T3dJCHj0x5C86VS71veaa8kEbGB64qkxzmDOi?=
 =?us-ascii?Q?AbLGJQhXfsh5TvTow2LZVwXoi5FTGoxkP5kiHVcjmJTsbGnEOo+PxTdQs4PM?=
 =?us-ascii?Q?SnljgFaCrSKYqjLi9p5DbVD56Gal/XBlfttKW5bgn4u+LMO7mxbxawMX2j3f?=
 =?us-ascii?Q?EEtO9B7H0l31A4BYeioXu9NJ8yPuUpjUOQsi1LwBWmjJ2psvWH2NOqP7ZaI+?=
 =?us-ascii?Q?gR/Ba8Q8sgnC9u7KBs5LtTZlrvK5FzFeWqTOmf4U4uEPJsB22Pw9cum63YKn?=
 =?us-ascii?Q?s5iwJxVCxFHoa/GZc5VMO1vKfJwNYsXbbazSUb85aDqENfxE/pCE4CXrDoO+?=
 =?us-ascii?Q?KsfXn2lF37iN24lqgkr/pLfLkUMMRh4kIBTyRqoU20746/3uqpmSfgnnx5Ik?=
 =?us-ascii?Q?+wQZGiyi20L+Pj6vQngvpFauEC7m2mz4gQr7gY6L/FnaKdOVSLupMBcA/K8y?=
 =?us-ascii?Q?vFHsqlA9CzUctxDz4pXpN6kH6gIeH5GHmCpT4qvD+dn1IRedmMu/PT9vWJKl?=
 =?us-ascii?Q?Ag7qBsHv+wjDZbd76vSDmiqpWfXrGi+s/icWwwyUFO7LuuxSC93q0Zd9Puhv?=
 =?us-ascii?Q?n5Unpuw8dBlWQ4GAtSVQaRnxs0j9NOYGXzU19PoiWriQtxPCu13q80gciPBm?=
 =?us-ascii?Q?Y3w6GWako0caeyilTmnwEZ0WFXj3ENd3k6q0JKtRHeaOOSjBz0SzMojxUlwZ?=
 =?us-ascii?Q?g4c+oKI3w43SG4qH+5fh35sQkTWjiKKXd8Wc6JaKAJujoqZe6yA5kpYLhZxW?=
 =?us-ascii?Q?Aa4wNgdf54l15JUkRz7DszTY9UHNyWciZmBjCRNH/dZxbjFKvHqwqemYOm13?=
 =?us-ascii?Q?U3W+XQwRUoQKUI9z+YrhXDYAsdNaDFL6qLW7rO7QdxLIx80Q1/s+mTGk0pwA?=
 =?us-ascii?Q?KkwL53EsLWOtSPjMXJJ40UxLLhcGkKB09xTA2La/DPWUlNXGMeExJr1DppIM?=
 =?us-ascii?Q?5ITuYsWAwVNQDr2Dqc7I1oZj9sonHY+4i46NQjInqlTdAgY7ov1K0bcqfQ9H?=
 =?us-ascii?Q?9zblxYo2ePDsiqqyyEF0deW/YnvSbXmX7QmBpylzr0fS2h+v7PWCPIOmnJXP?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a87ba98b-fab9-45e3-8006-08dcad4e8084
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 08:39:45.4744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9atjSXbFc58hZ8YY/Y+85Zb+SGKBgZ+VTNYd8uAAbDHZm6VVh8oq+cgJOex0I9GYzgxgv3bqTdO6/nSRyrrewm8+jPjRm1Z5SbPTNjQxFOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0592
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



>=20
> USB PHY maybe need to set PHY mode in different USB dr mode. So translate
> USB PHY mode to generic PHY mode and call generic_phy_set_mode().
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/usb/cdns3/drd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c index
> 47874fec29..cbb1334234 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -217,15 +217,19 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
> int cdns3_drd_update_mode(struct cdns3 *cdns)  {
>  	int ret =3D 0;
> +	int mode;
>=20
>  	switch (cdns->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> +		mode =3D PHY_MODE_USB_DEVICE;
>  		ret =3D cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
>  		break;
>  	case USB_DR_MODE_HOST:
> +		mode =3D PHY_MODE_USB_HOST;
>  		ret =3D cdns3_set_mode(cdns, USB_DR_MODE_HOST);
>  		break;
>  	case USB_DR_MODE_OTG:
> +		mode =3D PHY_MODE_USB_OTG;
>  		ret =3D cdns3_init_otg_mode(cdns);
>  		break;
>  	default:
> @@ -234,6 +238,16 @@ int cdns3_drd_update_mode(struct cdns3 *cdns)
>  		return -EINVAL;
>  	}
>=20
> +	ret =3D generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
> +	if (ret) {
> +		dev_err(cdns->dev, "Set usb 2.0 PHY mode failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
> +	if (ret)
> +		dev_err(cdns->dev, "Set usb 3.0 PHY mode failed %d\n", ret);
> +
>  	return ret;
>  }
>=20

Hi Roger
   Is this patch OK now? Could you add review tag to this? Thanks.
