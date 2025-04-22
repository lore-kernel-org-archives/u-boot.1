Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB94C369AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 02:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8108129B;
	Tue, 22 Apr 2025 04:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lYd+0rvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 710128129F; Tue, 22 Apr 2025 04:50:56 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF5D81273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 04:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHRpi+wA1nCeEsyGgGOxLToLk7h61dZ/XzrL4lkTZz4Os3VFPH8emJiBx/Qji/Zi46pCiYJ+4I5z1U56zdSy9GJFNzYd5riN2if7V5B35gGUfVXY2+DyBJiaJ7nrf5hLjklv7x+FLTClSq4lYUkyk6YStHAwWAmvB4MwUQZIp0ARInud571YI3IOqRMqhbm3uCWwvjVDurxm/HiIQUGgPROzyjsowCHB0Sb5tmlxAPbG39xYDYG8UlZzNOopEAC//vWnkm4XJGm/aeVZlvTr6astycRWrDq8D/l7WrmkB8F//Hm76ZD5qSX3Y/5pShpcfs5FiwIYlMdjfI3lHcCTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Qcwk3ZAPqi18Con3LwSsCcmPSUzM6eSSa9U/uq8PY=;
 b=sFOz55gXvbDEOKqPxsJqCDozOVcy6lGbu72wRmoOGt0GbqeabrgHdz/KrOYWErtxE8DY6rzbhqUkf6UdQZusb9TWVbyEekPjMGAeTjtaBSHIjGbFwEQZoAClCLa9cnB8UwJm1ogxTjx491qxaSya7aHwCZrpIW47F6dnE9Fvb9vX7kcaKmU2CprvDQMiaA32NsRZJFKv8yuti3aEEQmiWduL6odwn8r+Koi9F8dle7yDSPo1HK+WzAoUwnc6VGrWbcl/l2aeqiOKZs4gnFloQcb0sJXD/quxYzQtk51hJojy5oLaX3t7QGn6M1sdcmH9IJj046srVt9l/g/SUvmc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Qcwk3ZAPqi18Con3LwSsCcmPSUzM6eSSa9U/uq8PY=;
 b=lYd+0rvoTpyOlfKb6igUcO5VuVgPq0GI6ONwbbjs2wTIa7xqPFnM/9M2NU5YE7UildzOXrrqa87NspZVi1XHBCzMM5R4iBJXUUq22WC24xMKpVIKa6/m6zwnBUJ4VnGNhiG1VgiqAMzX1oic8i8LVpUtYfGlg2RzEaMUkFMGkKMc9z+hmugP2F7qtEwi3ZE+A7Ba3mp+pJtyVbcM/P1B36PwUK+mIT9I7OaSDsWV9lQam/7Z3blnAZTKcLktchAPE5t/Ll4xpHKBSNR6Cdjv0nxycoCRN5Ck10Ieh16UwHwEYXLFuTl9qTFLkYiC54v2lvefc0o2j2CfU7TZKVVn5A==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH5PR03MB7791.namprd03.prod.outlook.com (2603:10b6:610:211::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 02:50:50 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 02:50:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1] arm: socfpga: soc64: Update SoC64 CPU info
Thread-Topic: [PATCH v1] arm: socfpga: soc64: Update SoC64 CPU info
Thread-Index: AQHbsEINwyav4KwVGU2d6V1sZm3N27OvAikw
Date: Tue, 22 Apr 2025 02:50:50 +0000
Message-ID: <LV8PR03MB813731220AE2D744F30494C3A7BB2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250418091239.5538-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250418091239.5538-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH5PR03MB7791:EE_
x-ms-office365-filtering-correlation-id: 275a04ba-276c-46a4-e874-08dd81487ddc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?780opkClM8Rc8P7xQpG+weZ7cjCJQBquACucKLMZOufEdud3To/djUrkbxcH?=
 =?us-ascii?Q?PZpvi277xwKoeVuTr9ZmGYTe/EzQJmjFrLmiyRZq1NvsyB3bR/opbbVMkSTi?=
 =?us-ascii?Q?NcSz1OV68sRgYSQ7LWMJsNE6aFyde8ASt1P/67IRkgzRKgNDDZV6MuY75kGz?=
 =?us-ascii?Q?/BdLessyG3Rgc+MVlx28PjUPhCxThyrJwcT4saZKJS4Ci1e/Se37mwRktKl3?=
 =?us-ascii?Q?zKwmDx7x2zZxFG09O3lK7TdzLhV50qZMBZIVTkp4moqjVNtiHzio3Bu4jmKd?=
 =?us-ascii?Q?fZuXeZTbEqC87I/yb8/2euCMcPYBs0VbhawoP3FO8exVvdDJ1SYbA0DDuYiU?=
 =?us-ascii?Q?w36/SNSI4DfSQLSz8gEQNA0AXRCaTJ8ziNDXDkfo4EXGzgv9Dv7tx2VCqfdJ?=
 =?us-ascii?Q?jMK/cB0WZEleC2C6x37J3jiMiM0IeR4mUXHNM/BLfbTKIGfvuuj5tGahwiTE?=
 =?us-ascii?Q?EJmFoovmb3M3P99+Nt+5BwDA+5eZcJ9VHgittkTg+JWgqgo6KLj337I+ndoz?=
 =?us-ascii?Q?5e0b/euTbSwi6ZC/ed725TYUu94hPXZSc0yWLMhnUejChUaotgRngq5723+9?=
 =?us-ascii?Q?v8kw18t7+3Nb+EFx1euLJeOhWemJSNK5KqdXLL47vMQVYsnbjiiBXKGj9w8r?=
 =?us-ascii?Q?TS6Hx1XeT5AoXoCrm9FSTG7N11LNQTQCq2BpgISVKae5h/8F+PjHQ+llpw03?=
 =?us-ascii?Q?AZt+hc4wnU8Jc8K9MgazrT9cRy2vFTEjhtR5pqIEe0tlgmsC/soAxD0yvdO+?=
 =?us-ascii?Q?8OEpv6PU624SQba4aPJqnSK3g8qbwlOtJBXMNw025zQKK/FnMw7ICavvrnTb?=
 =?us-ascii?Q?w13Js6nyZ3/IISmV8qjuo/hC/kxlFsw8VeSNinK1Wchf4GGIbPiTwHO6nc40?=
 =?us-ascii?Q?QcY8PYSFCmNGv1K1scWT5NOuEL3hvrDXpukw7MROCUEFKfxnCe3BuL+4mNw0?=
 =?us-ascii?Q?b48uvTW+jbxXQ52o17por/hJ7OdHRnoa95hruZXe90ACuljuInXjvC+9RUnm?=
 =?us-ascii?Q?hF5GU9pmDvbVhzLxABIOilqf1xp41tvVs2BtrJQxqFgvya7dbqsjVulxYDKt?=
 =?us-ascii?Q?rqM9auHYPk9KhI0fIJV0PAvz0sYfqipLxM7GIPrRt8jTxMIRWTlrJAv855Fj?=
 =?us-ascii?Q?5gv9hjJ7W7YZJFlUMM4uhQXn/47zA+vuD0k9y9J+agZWs7Cw65x71oFR6mbu?=
 =?us-ascii?Q?qBb4BKHA1RO/I3ciD+MnrDx8L+Hno7ckrhXG4KJT/3CZUu1ZOyXYRYdYnG5x?=
 =?us-ascii?Q?td9HsJaB2v2ZafPECUyL29+PWo8bITKF+mKewe1pUjF5YhdFTwJKAAAHI74H?=
 =?us-ascii?Q?7+Cm80Xu/At9T15zgs16BO4aB3hyT7GEXfEvcT8dqt/LPt1oRaAQBLgBh7BU?=
 =?us-ascii?Q?2z9aoJdq3zFPLbmO2JC4xcoAF9C3NyiWDZ1PfRBIaIb1re09/6zjnupiHJci?=
 =?us-ascii?Q?P5Z4WHCuhEZINvi23Tcun8V+X9Xl0fpYP1E8SHDwrOXMNK+sVb9WuEhxfxAo?=
 =?us-ascii?Q?8ti1qCHscExw9PQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kFlP94RUmU4TR2v7wFMsd9MLi9/OQ2A2iiTFzVAfihtzWmf5kbNVbgjIeS5X?=
 =?us-ascii?Q?I3WNFZWb8aZby2TwW+CbT9jtFw74o8QQKIg3yNVf3oxF3/NGiUMhWhEY/Xzc?=
 =?us-ascii?Q?gC7EoOF+4U1Qkwq6ZBn5//K8Wn/BhLgY0BuHxRsUkTcUdycIJuYVG+p98EC6?=
 =?us-ascii?Q?J9Y1+oBtT2vFhwmg0qDPra0jDdP/boKvBwXW5g7Pn+D1hrPktAjXEzJw9DcR?=
 =?us-ascii?Q?t++X/KkWYpdWCM88cs+YG6mgPMgsFHhkF+Rytpx7UBNLI8s1nQzJx/YTlgfv?=
 =?us-ascii?Q?i3jo8OPNxHFIUuUzBysZatu7pL47uoXiwXaZyok1KeQTQtaxqHgZKAhBhCMB?=
 =?us-ascii?Q?5zD25gtFvyu8SEoVdZO5bCFIq1wAVDQOeXrKzAmLF/PHiT2f1423NROCMcI+?=
 =?us-ascii?Q?JsByZY2F+K3+eYbLBUlUOdFDLcLCSf0AebzUKF5OHN7NKDgoRTEeDRJqEwFj?=
 =?us-ascii?Q?sz9i4yKbS/9DM97bGmw0LJsJmcm6kX0M80+0f4lp8f8TdpJsx7o2kCMO9gvX?=
 =?us-ascii?Q?c0thDAZImQQFPsmFzgUHo8fuOVfoSu+kJRCUjFucU/Ctbwut3bnYE4l01DiT?=
 =?us-ascii?Q?1iFV0jz1lnh/Hnq42vJMXkv2CgaAXqnZ2cwfEt2d2TX0XAesU8j4u8b2P9p2?=
 =?us-ascii?Q?5LpOYVS3ZuU4ILYdZsmeGNUp30Zl1BMAgmv6oix7pazWFyTh2pxmFAcY51U0?=
 =?us-ascii?Q?+gP+ntGvWNohYSHrMvRgJ9+KFb2gHD+rVqsZXFhNOyUL/OpjhOLMo1hxVOJN?=
 =?us-ascii?Q?dpnnSnyntQF8aEN6ZGtKyfcrFub/Cx98Y48RYMTbrsBpys8wiIXKzj7Dk/1y?=
 =?us-ascii?Q?e/KQ/8edOv6/GuWDmuaFjLkOAz3u5n8YMVOb0jIKACGpk3LhJiYGna6m/pbA?=
 =?us-ascii?Q?bsbchMEQUp7mvnm4M8SxKVwi7j+U4v6ePUH9XqszqhRkaEwevnZTtGZOtUuK?=
 =?us-ascii?Q?y7PLLBhB2Ifx05kFJ3Dhkm6xxFQL9uYq57MbmkhM7PV/pK5Ezpv6u6oFFDgK?=
 =?us-ascii?Q?/zC5RC4OhK3IiZ4MRkAzOdmbIXjmY68Ik7Am5DrHvtucGxC3Fejl2rGO3/7O?=
 =?us-ascii?Q?cu3RPwvd8ekeINLM0dJiLw7fIPjcL5vI9L30Hu1pD4LL8lpqai+C61Dlt8z7?=
 =?us-ascii?Q?D4TYBvic0t+stGA1HuMwHE+tZG6J2YVeslzQy9IyyvA821S9sD5cUgYuZTJV?=
 =?us-ascii?Q?uB7fCI9b7UnwFfo6OGDmbJK74muhPlUAz6SHz2cGTegWVW2olMErRwpqZ0t7?=
 =?us-ascii?Q?obQxF9lo5V4FfCHNXqw5gYPYJdvM8hXJLYyKt9l74mMdez/uXVYExqm4p+MA?=
 =?us-ascii?Q?R3qsRzmRFGfQ3d4m/732YgZdR5ZJAmKoQWbEIjyHugV4hEflsfFxpx4cMLTf?=
 =?us-ascii?Q?QGER/2879lmVyr20GyyOEccazaXqfXJAl6AiqFJozGdyxi6Dt3hk78imItXu?=
 =?us-ascii?Q?vdlN0/j19JnP0Uf92S/rsCaT4lVgHdaLhYulpfNpVUNzCUIyVO8SJcYb6AUO?=
 =?us-ascii?Q?JkGUxGIvT94YBBFO9cKySi9csQXtfzduus9jzlI6C3vnx46YRuicmiBbgxtU?=
 =?us-ascii?Q?QIAvmJhfVjCBXFzRPK2cgy3BMYIaf+XktOjyM517?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275a04ba-276c-46a4-e874-08dd81487ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 02:50:50.5590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4ce3N5THlf9wJJcNjOBbGg0UoBznjBDoehYaI2+fNJjgAlf/n0ySjwn/Bqr27Gu+hBxkxYN/+iNWOmi4/cmfiGd0AS5fJ6nTszWijwM81k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7791
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Friday, April 18, 2025 5:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] arm: socfpga: soc64: Update SoC64 CPU info
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Altera has separated from Intel as a standalone company.
>=20
> Update CPU info printout naming from Intel to Altera.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/misc_soc64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-
> socfpga/misc_soc64.c
> index e0b2b4237e1..9fc8b9f2e06 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -61,7 +61,7 @@ void save_boot_params(unsigned long r0, unsigned
> long r1, unsigned long r2,  #if defined(CONFIG_DISPLAY_CPUINFO)  int
> print_cpuinfo(void)  {
> -	printf("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-
> %s)\n",
> +	printf("CPU: Altera FPGA SoCFPGA Platform (ARMv8 64bit Cortex-
> %s)\n",
>  	       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" :
> "A53");
>=20
>  	return 0;
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

