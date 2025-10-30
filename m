Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE88CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505CF83642;
	Thu, 30 Oct 2025 14:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44969838CE; Thu, 30 Oct 2025 07:31:52 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20717.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CDA832BC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIWslQHZjaWULG5vyQbP764GiqJ1UMKuPHky4tReoWNdpXOX1zvinArYM9kuH2fgiejT9RbI15R84EQewc6SQdp1bZ+W+evn4Hgsr9s098f36/RPFFX3My+DYez1IFbiW1HcLRqNpWK8oA+90EXabhYyY8nlfycE0WSoAg7xfFpNwNcnRRmAx8ccr5DGEkp1KtENDj55iBrPo1nJsnM3c8UN7yGqO0kyI5u6baWEnGKwTCFb8VVlpwdHv8ngsCrbmV3YpBK8VO4ws/fnm2m8o1BrBPbTX1hiREXxslk4rZHkeK1SNznboLS6XR9RhLuoMootAY/tcD6wgQrkpioOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEYWi8FOuePEQaIoVtLd9S3u4XWq51TboEicd850b3M=;
 b=ZGcB1vUZdjutM0FHlpFha81iH9Q/10Yty/q1KhGbr0xLvM8bYye8l7n7s50n7JVrVDzCPuCi+yoOBCUKPCwBpn7lXc5V4B232KH9uGRelTCXOAaX9S08ZCEnxocOcZMCE62vXaDpTzFFtTeaO28cxctKiz7uUoM0EIyVoj5M+8pw76lgZh442cJrJGJqUK6TxAB7KM7Uxmi9aeh2MaoKYCp4c2EsWS54Qm29KaJES0B1+qEGcZ3aurTSqj1dK0eGxK6J0i8xJqE0ghqHa5Y4CVxdUT7lLuwRVR8HOmDxMU3RNnR3aqVEWEcng+SZYpg/CibF/h365osh0jXiQ+lcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 06:31:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 06:31:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo Liang <ycliang@andestech.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 2/3] ram: starfive: use SZ_8G for 8GB memory size
Thread-Topic: [PATCH v1 2/3] ram: starfive: use SZ_8G for 8GB memory size
Thread-Index: AQHcSWYYBaKR79Jq+0iRmOhqIO6rzrTaOcmQ
Date: Thu, 30 Oct 2025 06:31:40 +0000
Message-ID: <ZQ2PR01MB1307B89ACAC820E9393EB0E2E6FB2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251030062354.35413-1-e@freeshell.de>
 <20251030062354.35413-3-e@freeshell.de>
In-Reply-To: <20251030062354.35413-3-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
x-ms-office365-filtering-correlation-id: 10fa37fc-a0c2-41a9-53db-08de177dfc56
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700021; 
x-microsoft-antispam-message-info: ECotMpAajTVZua5jtiaTq3bvkeWnS6/kKJpJAzqcwgBXrvChl6/lq5Jk0tYEi8xl0f8MamRVIVZ5Efj2xNABsVeXsMlpKfnga8f33eY4/okaRh2FWaYZcZaJAzw+tXd2H8jAj6FodpkvcGRjU7FqS5IxcUAlZ5efA/RTSYH3eowWaarTfgJyy0WopL4Uhbl96mK1N9APw7ubMogFpxdt03IvrxMZkJxxtZTtz+d7F5Wl2LQZeh/Oiuv4G/iBTl1+FSm+wYRYwHUbQfSnqVQHMENip2RUAVeQytKxRB8V52NB15uu8lEgKs9eTxN/Pf6qrrDIpi1JfBlZvhJ5Zm1Cv/Jh0aPYnlo2WkF/P2StP1qJjaHMsd7QVHtSe7FGob2HcmsAapps4YAzOYe0eyC3AvON4Jw8migr9Yfvk1FM7DwmG9jJZr8YxhULyTf6lrInah71VTegB0zCOl09EJSgxqvuBzgRQOWhCDWBKBgUFaUxTbcsQTJWUZZFNAgu4UXVRES2VeX4nvfS5lYfNpp4bIaQ1fwrVlXMr+KurrylVcgxX+XkSjo+j4ZDhDtaNXtXYf+i7hmgLloxCbHJZaXqtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrMxsx3ZQe8BRDU5XaXLpA1/qHHzCktExqaRoQut181xzkLo5wJD+VIlgseQ?=
 =?us-ascii?Q?A9OUOF/+HElk7cGnRJhlnjz9i+tnCKl7M3zGBamaUOCsDo2/vcxGKXEydhZK?=
 =?us-ascii?Q?b/j/tcu9IN1kK+cxsquuF9bSkg2IeJj8Fu7itO4r37sTWq5cjjNr9e+ObIRe?=
 =?us-ascii?Q?cPu10GVi95ttFxnmfX3aKN6eiYlHtlWwqW6jb/ZVszT/x1wIG2h7UUAH6Ugm?=
 =?us-ascii?Q?cb+WVSp0aV3BYk+PDtWLMMFdQn3nZRn9cm2/nv8MtUltxL3BaZGEFdfSeSqh?=
 =?us-ascii?Q?iWjXo9+CoI8vt6de19qpjFMO9BF8Vhu+DPXFNRpKPmKrSWJ51V/BY0QjieSt?=
 =?us-ascii?Q?nkTh/hZX7tVVR9DcibwElk3ULpznjSKAa/yPDo/D3wNFsUT+MsYYpoV9weVZ?=
 =?us-ascii?Q?046GUMQ5vMXP2SFPhxtueMaoPw91fUbhDewaiMXia2KOC9TLNp9KzflB1aCk?=
 =?us-ascii?Q?xucrl2gLgA0IWHoUQhyvFl8xDmhZwTLrGGnmFlXMNlEYjsnHxq6olRTDd+x3?=
 =?us-ascii?Q?KJ0dNUmtioquk1XkKjQLquTChA0KLSwwK59wAFURs/+JExDrSPyKdEgWlnlS?=
 =?us-ascii?Q?bb29BPKcBrYlRhpFXHvRhYQuOc3uAm2FbszrQqxYHUTZ15DUG3fY0ML1OgSb?=
 =?us-ascii?Q?8UQ7bL+KD/TPowTAcibPSbRaxpurM4f5qXnCh/Noqgh9hPgQs5Q9FaoMCaHU?=
 =?us-ascii?Q?OScH3WO8YSQegTDGh8t7nqTFv2lSzkvd3jTjNi86kfFkXcGibwsAIDfunQM6?=
 =?us-ascii?Q?+no9/BcprIIn6UP1b1VVFcS5+f8iWCt/D9BdPu82cnFYWV+2cKKjOm3BTKUg?=
 =?us-ascii?Q?Ykk/cVhuYKVke2QP7zQaKAkhl9jocISgQJMZd+SXtYSVVUvlye6wJ/3GCBIl?=
 =?us-ascii?Q?ebtJyZQjaLsbeXRJVAIIAHrCJad4pUgGt3wI7Yd++2MgpHJ/2W9Ns4rjbh6K?=
 =?us-ascii?Q?O2H8+wjCKMPrpXpZkdxxaxY2ds6SWYGEY+mgBIa/wx+MiryS6Tx5ZOaVkZ8u?=
 =?us-ascii?Q?PNPMsTK0jXVTV353F2CX1S+h+bSxLPxoAB7Ai3QcmutzW37VHQpff2lAAAD3?=
 =?us-ascii?Q?xHLD2fzs4itPtrpwOCxEFfM8q5EBL/KRt2RnhkgMCqmOK+Tpo9te8LsREyUJ?=
 =?us-ascii?Q?oluAEGDUutcRwZKa08UPdIlSKuNfSozFneHlIWad6NdBpGT7b9wWMzq63fEc?=
 =?us-ascii?Q?u+0AbSjAqZXUDPjNQnSGka4p373DAd9nhWiYtvevK2fH3rjCLFoJocH4Y/iX?=
 =?us-ascii?Q?KzE/3uzhL7ZMfc6+sFyzoXyXGfjnEcVjw2cJ3IsqF9IlYXT0xcX/3cl/jsHF?=
 =?us-ascii?Q?xv08AHE4kxe50UkIRkoiBPTu36Qdj4sxc/PQiAn13o4AVihxY98NBeTWjMaA?=
 =?us-ascii?Q?Dq6TMD3UkQKRXS3F33Cs8gOpujfNlByfiaSOWpYQHZW+lIFYDoVbsl4Y6auz?=
 =?us-ascii?Q?4Z1mUIFyUuGLcOOeHOJxbS1HPc2d3UY0pJBU6/gXoCCOsQjPKQZ0BkkPtz+x?=
 =?us-ascii?Q?/FZhiHt7UqeWWJVQsmbAv1vYDG5884zbYvxfkpGtDjZx2JEQfKKTq2HwPpgE?=
 =?us-ascii?Q?5gcLgJKEQocYNaNDDHxNWb0BABPMc3Nlq3hN2aqC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fa37fc-a0c2-41a9-53db-08de177dfc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 06:31:40.5022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qruKanUDwJ2RXBhjTTh+JNeN5J6km20nGQSWVdS/1UpCxNqSo5f1FpHEP8s15hV2Jq78pR5SD2sSZC2WBgtHa1b9Gm8QVYDg+RXyPTi4heY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

> On 30.10.25 14:24, E Shattow wrote:
> Replace numeric literal with SZ_8G consistent with other uses of types fr=
om
> linux/types.h
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Acked-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  drivers/ram/starfive/starfive_ddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ram/starfive/starfive_ddr.c
> b/drivers/ram/starfive/starfive_ddr.c
> index 9e902f03ee9..f030192f6f4 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -43,7 +43,7 @@ static int starfive_ddr_setup(struct udevice *dev, stru=
ct
> starfive_ddr_priv *pri
>  		size =3D DDR_SIZE_4G;
>  		break;
>=20
> -	case 0x200000000:
> +	case SZ_8G:
>  		size =3D DDR_SIZE_8G;
>  		break;
>=20
> --
> 2.50.0

