Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9842AC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1461A8373B;
	Wed,  9 Apr 2025 14:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70D982B7E; Wed,  9 Apr 2025 04:50:55 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDA582824
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 04:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZz+Zm28tEVBx56N80SfHg2cLybGfKLg5gQaoEzmJIqIolwdsqXRE3oNC7ps/D6fKs7PiyD01QMewzCQTp8bDLx2w86dGfMYwIxnrJ76v+q0HB7aXVG1hZ3J0f00kqc86OM9nW4ZD5D8sO/QEtSWOCJhQBwBYMoHzUpvZen4tK1QWCa0cifZUkEcS3qY33aZki54KOEsoB+1cHzrKHP6nFzTTooQsr0rNiYVlYpOwvmyzEDKZBzxuFSaZGcUCnxB0zLnX3tDj0LJ7J/yJHVd+wJH3PcYnDFS6ASkIG+pkf+Z6hlFIAw5qJQGvtlkm//8Y6OcdMe3rbT894dZrki47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acvYPp/MM9+ZyAL1iTwwPdq3z3zTTuuMeUnatUcoNOc=;
 b=Rd4QyqPnJ4oGiNvjNvGRx5k2jk8MGO6jJNltJ7qxcrFjDL6GS3s8tHaAaFpcVHVe/LWKjrGtfV/f76XbcYjtzh7l6WkpVTC2bs3uBGVvnhwhnbI8xlD/uuTsopCESCOnCaTiXClOdpm/MkADMfBawrIEbpAbDsuV2HRj3IA+7+SV+kazKErSw6feKYV+34qjF798jmz4wT5kp7g12xCu8Iz1yX4cP1OUwudbk8b6oGQGRLGNnFqC7qR4wHfYdTNXmiP2rOyLJ5HSZRJMvBm8Vmuf1udnuhSze6VW0bXZdJAHdMaj6cLAzjS0YgMD0tmNTtDDqEtOoQU+KNvg5yQ3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1212.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.49; Wed, 9 Apr
 2025 02:50:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8583.047; Wed, 9 Apr 2025
 02:50:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>
CC: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>, Andreas Schwab
 <schwab@suse.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 3/8] board: starfive: DeepComputing FML13V01 fdt
 selection
Thread-Topic: [PATCH v2 3/8] board: starfive: DeepComputing FML13V01 fdt
 selection
Thread-Index: AQHbog3xK7dCmB4TJkqUPtS886Fc8bOarkvA
Date: Wed, 9 Apr 2025 02:50:45 +0000
Message-ID: <ZQ2PR01MB130704B91B3F888A8206FE15E6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
 <20250331072410.8662-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250331072410.8662-4-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1212:EE_
x-ms-office365-filtering-correlation-id: 66e94165-d578-4ac2-ee0e-08dd77115344
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: CksEB0ZTzLHlLCXqb9l1U/2F7a+ONc8tbst4+LY8ROfD9R/88Lj42U1E4C27SYb4/KcAEG6xMabqk/+zg1BjkMVSWWt8JhwyEOBYNli5jivWYRQQnKG/Zear+1wd+yQjtt+RH5zT9hw9F+Jf0DJ5z9bd3ROKXX2EGy0Kk4Mmf7+GTtvq8sEmsBBEMOg2BW8brvTw9230GATLrNvFnWHzHF7gZFNcodNllmjrOIpA0vfPTu1oQ+XXqwKhp7zr7S5LrT7dLjpYk6+RGIiTFZDgaWUmPy0uzVPvvoyEuqjNzcZ2VmNf6CxhXiykUYh8FhW9UILG3LeqKeYNluwT5MEPIwvoBI2dY7VoKysR5Y1sww18UT5APhVfHEUyta5GTSyu3rMMUcs3rHANslyjQYIQUo/5yBDQ87xrRKLOJhPET/QJuyc8lxbKLvouU8pGcV1zFWgHZ+jsOeKOqS2TG/pzno/yHvFA0YxE/g020DReTrLv1uFC/o+m3+EUyrtHMCmhU2k8u10XGkW87B0pWekGnHgDxxuwcuIVwPYC6lCAyqAklb7ZROoiZV7J+gmjyE5dBWxVzuwkE3o4pyswvqrkxMjR/vggoD9E341uHgicmsw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ZANdwAtAVNyqZJjc17T0b8bBDTwpMFWQIsItYWuWP5cuFrjYQitrRzcdUDW?=
 =?us-ascii?Q?EaSb3CE6MLe5btFUoJAkFLUdiSkgfxCzdh4SFP1sQZVqd1WTfjvZHf3taS4y?=
 =?us-ascii?Q?Yfi3eO7U+5lD/1xaGGpuuIcCm8ai0Bj2BZVtnEppUeTdMYIH00a9/V2Yb4I+?=
 =?us-ascii?Q?sabqyj2sv5t6cyoL/CgMksrGGvj2VICos5pXRG1faKAxDWEb/7pOHMmwiZvA?=
 =?us-ascii?Q?UnTeim1U2zOMX9TpAb13QCsR9WUPv8ZonlWvDjQ/WWTIwS1Ou1wUas+PWucq?=
 =?us-ascii?Q?N8+fNt5f73MvNjz3pEIyuuDS67nLLuY1wk2qHOtuDk9Rmu7OEF/Ulbw0NIXI?=
 =?us-ascii?Q?aWgpy+oHx96fOTes/yy0lvb8PfGG7YP3iNnqFD0btV9aYPE5Mw4c2XAYNQI8?=
 =?us-ascii?Q?oOwP3PbUbp89pSXnj9mVb+/LYTg6ZPV+8S0HFlYj14UtQv/1Y1vD2AJP5MiG?=
 =?us-ascii?Q?kbNtOjxJG6ECnL2BZJYNiAiWuKqjtiaFv/kE81+QhtPkalqpy4UJOOVXE+mT?=
 =?us-ascii?Q?j5GR25soHf9z1UjlcSCpUgEVxDH4VygI92XmdV0E3VkZ/Gfv3LjBOUP4DlcB?=
 =?us-ascii?Q?ubnzoh/eAi2LCHgk1DytPc/duR6ZtR+bhDCghCTqLn4qL4Y1NS4Q17qqSLml?=
 =?us-ascii?Q?wnT9Wyc5mwV96gluwVe0HTTTVjyzfwund5/XaA7UWgR2A0lDI47YzCVysSRd?=
 =?us-ascii?Q?w0w+rOZfvI8dSwHR1/w6FRUXVivaB/2jWpMReAihdM+Dw0uCtG3Is5H2yCIH?=
 =?us-ascii?Q?kiHnh9wyO/pOChmFmZ3wbMcDr5oXn90cLo4C2oOpXxmjIxIqpght8tMv3xIB?=
 =?us-ascii?Q?bi+PYjgP2G43SvvBMS1tf/iepoma03aeQ8TSYBVWXXu9n+EEK08dHVmdGXIT?=
 =?us-ascii?Q?SwOwGzvfHQ3vKUm9LqBh6wnFWugmelkhfLBONLoTdVY3mgRFYiv6qeiu++EN?=
 =?us-ascii?Q?d8runuWQXlYvuuvYc9ymc5yTsXk01L0hIW4WCZhUUf+cLsSj1giJMhnzY1QZ?=
 =?us-ascii?Q?bD1SYTEdzBiQGjqC3bIe4EQp3cn4Dzg9Sc0lm4OGz/HLGfD5Xqwi4acutmNM?=
 =?us-ascii?Q?SaBsdVVhK4SfR/K4oRVnF/y/n9DY4lkLR7OgYO4ZBq7wQ7mw4zzzYMtLqNsI?=
 =?us-ascii?Q?xnQIg+vSinVEiKGWatxVAUzMDhhJopmijWto+YhG6qckr1bseBbr8RuMASI9?=
 =?us-ascii?Q?LZX8lSLul114X8k+7Ljlwh5V+h/tEDxYvDWu19dYnNSBJkE8UrIMkmpZPJPU?=
 =?us-ascii?Q?vQmMj5v33vydFmByJkYfLqCrKFkU0lM9VDqpGkjs+CTurFyB525Voa8y1w5N?=
 =?us-ascii?Q?eQC2seS7twnlpw1l8pcsp5kGWsCjVvzJGJGUQysoCBP64Jp1dYB6Xro7zp6T?=
 =?us-ascii?Q?B1MtpEvgtKKmWvlUxhwEuFf2N54/Tzxn+C3skJFH2PlBRqX6xoxZn4CYuILx?=
 =?us-ascii?Q?fy5vj1f3dYpoJoTQr/DRAk0yGSWm7MpkdPLkDKqT1TIeXpTZO/YAsBFxk+2e?=
 =?us-ascii?Q?6+L4VlcBTy7q4wvZoNgGjDgHkm5ju9nDmWCZAt9VFRb6Qz8grcFvg8KMcTnp?=
 =?us-ascii?Q?rQlzUhebm+pELgHrRbdEKZBg6y97R7X66gZo6vhD5BD/ssWY2UeSZBe08hQJ?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e94165-d578-4ac2-ee0e-08dd77115344
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 02:50:45.1270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXAU02ypeFa3MGZiQ9rjCl7lSkP++0WOiBYLlYyEoDZHMY+pAsGD+uUF/DCYs72MA1FMbcj0Qg2V0AyPQMZaKYP7VTf/WiN57N7Zhcrk+88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1212
X-Mailman-Approved-At: Wed, 09 Apr 2025 14:41:40 +0200
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

> On 31.03.25 15:24, Heinrich Schuchardt wrote:
>=20
> We support all JH7110 boards with starfive_visionfive2_defconfig.
> The relevant device-tree is selected at runtime based on EEPROM data.
>=20
> Support setting $fdtfile to the file name of the DeepComputing Framework
> motherboard (FML13V01) device-tree.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
> v2:
> 	no change
> ---
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> index 3940d45b13f..55daf730c81 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,8 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_FML13V01 \
> +	"starfive/jh7110-deepcomputing-fml13v01.dtb"
>  #define FDTFILE_MILK_V_MARS \
>  	"starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_MILK_V_MARS_CM \
> @@ -67,7 +69,9 @@ static void set_fdtfile(void)
>  		log_err("Can't read EEPROM\n");
>  		return;
>  	}
> -	if (!strncmp(product_id, "MARC", 4)) {
> +	if (!strncmp(product_id, "FML13V01", 8)) {
> +		fdtfile =3D FDTFILE_FML13V01;
> +	} else if (!strncmp(product_id, "MARC", 4)) {
>  		if (get_mmc_size_from_eeprom())
>  			fdtfile =3D FDTFILE_MILK_V_MARS_CM;
>  		else

As Mars CM (Lite) is no longer supported since patch [1], this patch should=
 be updated.

[1] https://lore.kernel.org/all/20250327175550.529248-1-e@freeshell.de/

Best regards,
Hal
