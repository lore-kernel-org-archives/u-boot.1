Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A61CD1288
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 07:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E1288220;
	Fri, 29 Mar 2024 08:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC5488224; Fri, 29 Mar 2024 08:53:33 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F77D88212
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 08:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6CTIyfZTEGlsV/DbsQAamm+iPrVx7JSNlP0S1GrJri59XlamoQHxPUL5XSQ665Qu5xyflv76uUN1rtejx9PE31euXZewVkiCtUS7uqflFm5SoEdybIl+zpcVh2R/2x+XYUEUq3qpnzzeZi2uqOGYvz4WvyrEW9H3UoJcDlCxYqkBjdoGpF6ZmUzTSwqg67KempzM7oV+bswyittkq0En3Vw9yCGe1uPNDeZkn7Zg0s/wOq1ZuAEKKUgfLQKueaoj3LYlOdGlqM5kFlySyXe0a2QLL3bxHRD++QX1/9oGQyErFzNcx7QiFtwAXM8wYmGl9MO8Jmf4FzvKdIYlCURcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4EN3jT0ROGvOaA5F9hWFI5wJP8R1V6CTFkg/D9iZ0A=;
 b=CP8hFgjLjsUsdrzQKUhVYCMMKKAHgm3HSonmhnXhdoMWiNmKN1WOCcQFQUi8xieUcmi09WSiWty0ZBaN8dZmrSw4IGMbYYCdJbjjDNdR4xv7V7CY+ByRje56ZiTgsdw1zNAjrRyUtVa0cPXD3m5tjE2RXuDkBORvCJQxg2BWKiSC74L8+cKtT/rJffoPRpX2/QuFKxVAuMA3L0rvoJZDfPr54AeIabXSZFNnaOeMJHRkFrKPLjBTbXOitptYtZoOIjowlV9tKipSt96n6ZX+HkR7CqNtd6shpp83M4+nQQAG9LUVuaVu7dO90Tz9/20OeecLAz7ZT6xlnYFpny0POw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0768.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 07:53:25 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.039; Fri, 29 Mar 2024 07:53:25 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Aurelien Jarno <aurelien@aurel32.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] riscv: starfive: MMC card detect
Thread-Topic: [PATCH 1/1] riscv: starfive: MMC card detect
Thread-Index: AQHagVlcwNMGVDY+ckyL7GGrk1wK+7FOWacQ
Date: Fri, 29 Mar 2024 07:53:25 +0000
Message-ID: <SHXPR01MB086314C47C281B3DDDF7BAE9E63AA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240328214615.21501-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240328214615.21501-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0768:EE_
x-ms-office365-filtering-correlation-id: 933ee41c-2822-4558-e128-08dc4fc5508c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyyio5mIKjijBTBXQXzabia1cpe2dT4AZVLfyx8qSM8+jsHFF4yImFCExDrNEL11zQbNh99s6+oc9RqoN64PrtxJ8MfoR5kXixK5uHSrixtBfOUVijO59rfRGpghYmBMou9cbBZOdaAbrhQUCLSB1Sxfird7I1cVqg+MOlRVd8UqhRnLubYqM+o08cMfg4np0Ud2i64WJx+IbdMM+Mw/SWd8ShfrurVzrNsU1XA8fn8ZSYyvGC0ODTC9dCXRnWkpeKO6GISWcqTPDLTwnv6JfqzXp+fi4tSGg2EbbMbUPLvbRCsOIZLI1RxVDHITYP2Qn00/UbKbUze8JcUHNeQBWaQkAbfnGptPXTuFvi4arT/5kC0Jd8O7YLQSuP3DQ9AQsTu4yavJcmt7oddpUvQLPb+/vCCgu5jKNYatyhRd40btaYRZaM/M1LQmCN3uWhiq2rTDvieiRAJoZeS1SnK3wO0q7x2nssWrTRwzdkIAT0tzdl28HTvGUh2bsL7EyK9uw4rw1Ok5gB+FyYqpk1UdJ0CN3WFC6YCTLcbjUtrqfzJTwKr10TtqQ6ogl++FhQq/gXhMDp7xpt6wXP2DWAPaHdQQDzEF0gTWOuN3sAyMbb11EygvBCnKRR3hrtf8C7Yv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(41320700004)(1800799015)(366007)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9v+ovt3zoVs9CIZdKMo026va+PGZ5F7xfO5W0+iTMbtB7NZe0CDI+JcgrOlp?=
 =?us-ascii?Q?+cBYjloBK+yz8JG32mb6dj65sIIFqSO5pM6Ig3IwHp3qKUgxnJw7fYpl+HgY?=
 =?us-ascii?Q?+sYdnFHfieJdECsW8ReUn6ooqR7ePxU/Tvv0S2YnZMHTHTWQBZZqnFfvAlWK?=
 =?us-ascii?Q?qjUfTTmnm9sLn8+Z1Bc9/rZD9o9VWh5+JKrvX+3se2OJpARI+i7dLhHpY7ND?=
 =?us-ascii?Q?EkcYb/C9o5nu4NCjpUVq7BImO4caxrOxW9FX/BGrDuSmjJOwlJpoZpkwVOZ3?=
 =?us-ascii?Q?lPG4O/CGaMR13Dw7Jiuq0cwNYQRV9bWt49OL5iiOfQjxqIhnoBv8pipSzoZx?=
 =?us-ascii?Q?Qt1vlQsMKWvCQGaTrtBNZkHYrZL7tR8T26iPm5xQMLzgeVL1/QUoZpEJEedn?=
 =?us-ascii?Q?292LZfssCZ9hm0LxKQx2IG4ag+9xFVX/4jgOswXMSZKwm9sT5RGBOMwMPbGd?=
 =?us-ascii?Q?uuUZtSr5MbXKbv6pgjnrdwDzLfVVdiBeyocbN8l1cidqFpoNFb69siuDEv6s?=
 =?us-ascii?Q?XUoaOjIpovneCj0jUhUOe32tYa2biIwcdmxhFQOHbuiGHJsArLSkarXo0y5B?=
 =?us-ascii?Q?d0u8VZazgvMlfZVSHBKw69WhJfqs+5lf15d+8hd5RTW3CHwx5Ll1PU0ZXLvu?=
 =?us-ascii?Q?m8CvkhhJYlZpz9Gl2bIFOGT7J3tiA3HxyR+sBHTJr1TIXmZ7sds+oG3kJKod?=
 =?us-ascii?Q?EtU6aRD3ALCPn5Brtl0LPHLjqQw+b/xwgbsS+QRyLTH6xs3GR65TZMikIfTZ?=
 =?us-ascii?Q?gHBkuSCvimMQqhVYYC3MoJknqDuQ9cpK87RzS2m7n6XZ7M+Z/Mc+oMS/jzZC?=
 =?us-ascii?Q?dSULNWu66Ze746EPNG2DtOAb8GvGxmrjxsp8qrQR8xw6Jn+o/ulymsOkRyQH?=
 =?us-ascii?Q?7pabRWsvtrr8HHvfDjrKWm1L0tO0ImCqVdc09Or2SvACNea1I9U2oT8MyEpp?=
 =?us-ascii?Q?6tIFSbxQagJq0th/B4LMcnOVngCxZK4CZu5aD0LRaSUCVFXg/pQOXRL4WsRB?=
 =?us-ascii?Q?5Gv/hWpg4WvuoXCepTETy2nWGjLUSw9v409PDvXIDjRYVwyM7oqtXA25LPX+?=
 =?us-ascii?Q?OFelc29lL862iXiheKOph+yUcXT7WQi39HuFuRpQG/e2YlwJ9ZzbxVNiuxFk?=
 =?us-ascii?Q?aB587b8qjrSaqK+18HxS7k5cuaViWUUH/sg2K+lIzzNh4zRQqJRd+7Ydswqw?=
 =?us-ascii?Q?1tmkTMy30ebk4QQfeL5rVo5K8U9Wza2jvdcBJcrurTPZWLlyRpAi07LY6FV3?=
 =?us-ascii?Q?B0VnaADv7ijeonBMLM4fp1+qi+Os26TVrK/tm4T6ZTj0GB0DSxiJItwAFhCX?=
 =?us-ascii?Q?F1yogBahXtPxNU2hECaX+qld8luScD9vxEOKVJGZGpM6HFsZiFNJEJVjecMd?=
 =?us-ascii?Q?XHZ91eKMMuMlQUsU9aB+lyBzYm7cUPSK5/ovizXIj9VPndPfeqPED7ZfIj+I?=
 =?us-ascii?Q?O0VB0M80xZy/wrfGbL/ZMiWiCfA2F+dxIFSb0/Ke+9os0x5Cx7xzJ2onCbDV?=
 =?us-ascii?Q?Nxjy21276npjg5KLKTtejPn4YOqNfDIVnJ/VxbFSTHqE2A5LnRcShGDXTGTt?=
 =?us-ascii?Q?4K8fc/iqkg8yVChQnpZbd/beg8xMLSEtTcDZdvnhwNmokVqTfrCnZem8PdWz?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 933ee41c-2822-4558-e128-08dc4fc5508c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 07:53:25.7761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 346YGbQfRf4QmTkcJafFLlcejPc88DQ7L8I33c6KDvzcakXBCw/j2S94jk+5zgbtvDr5FOklFi4NK/6WemxkgzJEfG+7OYG1NmOVQuxEHbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0768
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
> The VisionFive 2 board uses GPIO 41 as card detect as documented in
> https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> index f2c6bec9298..e11babc1cde 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -298,7 +298,7 @@
>  	pinctrl-0 =3D <&mmc1_pins>;
>  	no-sdio;
>  	no-mmc;
> -	broken-cd;
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
>  	cap-sd-highspeed;
>  	post-power-on-delay-ms =3D <200>;
>  	status =3D "okay";
> --
> 2.43.0

Acked-by: Minda Chen <minda.chen@starfivetech.com>
