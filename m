Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70777CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 11:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94CB848A1;
	Thu,  4 Jun 2026 13:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="rsgzlHWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B13848A1; Thu,  4 Jun 2026 13:33:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C018486A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0eyE3JqzwHP7JZiFADw/3yKohh+AO5NJJjU1W1Dfat0ukwteV+BOnTXzZhF+LB2Thr8hi0BFYsko6SSUeXjjya61Muil/wGNJ+rFUPzuPKk5H1y4w4Qj6tA5H+AJB00hUvCcbIIhiiIA50E6IT1HTZfq7RiQiDWQBU/kVsElLEzfuLmqhMlBrUp9l1y2ZHZ8xsbQK9ImrEYiPpBgYeKnY0vBodYB49mi7cEVxIvjrFtDg79nKjcKqCrDBRpiXq8CFk/jqB/X8OIyhvwnNrHQ1Lm1OQwFmq+ziikR1X+aKmiwdvlRRhlTviCEgvJIvUFh6d68Ut0605myTktbSmfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmfM1Lt2bQk0zARcArgOBeDXVfvZeJmrWZpAljt0QnU=;
 b=onCk2aTXwGPDgPmZhbS88czV7tsdJoI8aroGxRInSgHMsfOxsg0zzXbwksf5cLC1zQkY7p7DMZTdk02Mt98LXPwjL2zMPE8i06qGNNrZbqKKLFx9CgqMcFyeRbPRKFH7OJzLXIr4A4RkUQMKQppnwoHtUjxGG+brKgOXZMehuCgAyLEFp/3K1jF/vnDYWSXQQ89LJTgYgkDrciEvSKIFccFzX+xxjtuj6gd5iwh40832aNjnz3tLRslCqd4KENway9V8yjtJHGFKmdjq26otUXASoy+l0Xl/aNgAksvGg13cd+L2DRO3jUrP+eUV+mMdpEYm4HhFV18vqn05ZUDFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmfM1Lt2bQk0zARcArgOBeDXVfvZeJmrWZpAljt0QnU=;
 b=rsgzlHWXnxFS+2p/t6wJLJ7wRah/TZ1gFN+Po/EOfl3URRY7NVYZ5aYJmvN62KJpp1pPjV9GZJKFMJCmW9XSOfymUD+pAXJ84ypY4aJhjcBNs6cnvgVMxTivLkogTOJhgInGQdhr+2TYywZTe02BWiN5SnJ9781xRA0eGf9zC7sE4whP+2nmno0QIrBPCmGdwPVxpZNUmXb301TCOAK+ii86KHysPW22L12xi64f318uLe0jYeBtzMaoV//7bAp9ApOsFvGyxk/ZUlTHdAuD8zBY/f1qAiiP3/vVLMdMSFOxnVPX3gcgEJV33OyOr+kL/6mx89YDiP+wRsqqt/62Bg==
Received: from VI0PR07MB11748.eurprd07.prod.outlook.com (2603:10a6:800:316::5)
 by PAWPR07MB10021.eurprd07.prod.outlook.com (2603:10a6:102:38c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:32:59 +0000
Received: from VI0PR07MB11748.eurprd07.prod.outlook.com
 ([fe80::7e64:11a0:892b:90fa]) by VI0PR07MB11748.eurprd07.prod.outlook.com
 ([fe80::7e64:11a0:892b:90fa%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:32:59 +0000
From: "Juuso Rinta (Nokia)" <juuso.rinta@nokia.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 "Aaro Koskinen (Nokia)" <aaro.koskinen@nokia.com>
Subject: Re: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
Thread-Topic: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
Thread-Index: AQHc26mUfxrXJ3WBBUK9fQ9q64NFyLYECjGAgCpo8qU=
Date: Thu, 4 Jun 2026 11:32:59 +0000
Message-ID: <VI0PR07MB11748EF612CD423CCFBF43AEBEF102@VI0PR07MB11748.eurprd07.prod.outlook.com>
References: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
 <a42da35f-e230-4d60-a0e2-37b2c2d8c5bc@mailbox.org>
In-Reply-To: <a42da35f-e230-4d60-a0e2-37b2c2d8c5bc@mailbox.org>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB11748:EE_|PAWPR07MB10021:EE_
x-ms-office365-filtering-correlation-id: 14fb67bc-5893-4af2-2785-08dec22d07dc
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|8096899003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006|4133799003;
x-microsoft-antispam-message-info: lY3CnxHAJINAD1UoT9jCqs24PALN7JNp5xFN6021k18ErjuKrlHb4jOtXvu1EsLQZZ2pGbvecztwv8F1AIIbLUjTUdXXV1Kwow5QmgLeiUJI+igdcLTRxqU8VCdOsDu+IORRgqQ81mkOVFD4TeX8+xo1JVpPvwJYM3KFirmtYc30tJJRH6W1Mqc6h/2VjdeuOFJvN+xWXLmu3RKRJ5tCCTyYiNXfAhM2DbG/qSM3ivDZEj2/H8ExzgA46DUcFwJyXH72RfRwOQJ1b21TuicQTpDSBN5B0n2d1UfFKn3Wt3uIXqZ59lq7h6+LF7VdIAB3uNNXlLPM37B+FS2VYYdqQooJjn4HU0vuOXnTILWY6H6k2Jemn4hVBLOzYNzDFjHzq9gvhL5aoq3uHU+DW6CeuJmJKCWDm8kwcYE+jocF/2EN9+noid0tkoJwTw2XR6YMJD/oh9Kp40ks240bnLRj9xKXQOrtTU2Fc1JGuBBvq/hRN8hBrRUYpjp1PC7JtJ4JrGyQRrnj/LtzafUS2bjZkiotEMj5Sk5V5uIBtQQGgzd876nK1rNCNe7zqPxia2GyrSxFKLRkrJeWpeVkESLIZnM+0yAYO7KI1disNziIUr/dd0SDE9ne1lkmk1ibad7kKj1byEuWgAiY0eo8C6qjvfahtPwoYsL4UJOTMGqld5zUggoLrZLY3AL//T+7XwUZFJ2hnzLw+Uc7d5WCjID8giYMWBc7cgxKbHxM390CHGt5BIFQOcd39yrZFN3DMp3m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR07MB11748.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006)(4133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ssVBxcnNpfNcmb6ugQnBnJY+S4I2SzPKqy+hvLHxUfi5kTGy09AHiK2sChwZ?=
 =?us-ascii?Q?z6nG7PKxLdNVyDMjIcFvdbdXQotiIGtFEkG8avtkOwFBY+rKGcJJX/0nNhch?=
 =?us-ascii?Q?/ZD30MnU2nD5WbhCMEMUHg5z1VKtSg2WyM1E7bBjj/+EKcBP+CN/RpHpFJMs?=
 =?us-ascii?Q?LqOg2AXe35lDaGeZyKadTQ9mzXhUSUtX74vXSNAeuvvLqHKQUB7p3Aix6870?=
 =?us-ascii?Q?Ggyii0G8NB88iajMoefLdjxYrWGD4SV3QIU3MlSZ/Ku9tDA2mAZRHttxi352?=
 =?us-ascii?Q?kvXHqPkqxTzTmag/5Bs8rTV6vK6AQAVIpi0J9IVaD5mdK4LSvXFXJdcfp7a7?=
 =?us-ascii?Q?yqh8//QH015DYWDg1saRLtPILxefg9ZRRdp+Qq2WHMyPzt+FJS3vKxCBVuUQ?=
 =?us-ascii?Q?xkCeoaMFrCGb8PuNrLF9THXGViCWGvgXSVz9m2bU3UffNIc0umtHwm4EiKM0?=
 =?us-ascii?Q?gY+Lo+lVuiPDulZQZ0mA7T31IDEaGfYfQXc49jx9JRV9tSvlDfHZFGyepFwN?=
 =?us-ascii?Q?qoeNjuty05BLXVnuuGcC4oq5IpQULiVTN+rx6vG8cmNuML2TnSL+i9HuTwZ3?=
 =?us-ascii?Q?kSpcg1Dl7kviZOndLM2+Kr59vtp7dNyITeu1TLi2jgBsFZjX8y14nZwT9LlW?=
 =?us-ascii?Q?VbhWmFWEsgzXoz+0XJjSdRdudD79KG6JuwsyAojeJax2X0RdzFjZ+DE6BKQw?=
 =?us-ascii?Q?05lGYPk92YrWnPms2+Eh+iDB3mTuq663EF7Zn7oSbN3/tB555ofzJ/NX8szd?=
 =?us-ascii?Q?ZwmOVvZwmQHzWJckVOt0kZ9W+Ck1Q/AA0TqG0jkT4tlR81aqb+V4rxXExpLC?=
 =?us-ascii?Q?xsIUwMQ5IG6ECoEKKO6qE8Ju5qGorculAuM7UCM5uyrKEPJx4VHFarU9Y8RR?=
 =?us-ascii?Q?CFbF1yuMeLHBi8PqTkWT57lxbrPOo/aGXpCXWEAMfIAswKHrv/nMkeNO5/Xw?=
 =?us-ascii?Q?4XL03V47+pM1ug8KrnoUlITUsGWdLmWzp51k+1k1HDQi9qZKFftbhmomc9iD?=
 =?us-ascii?Q?bHP456AjJOgdfPHlJn2qLosn7e9n0ErCBll/kpZXW+9dto6lgOXWe84JVrmr?=
 =?us-ascii?Q?xiD8rwycHUCoOtShMCGqigExmkO2e2ZNErUwb9cwqVf827yj/8njLfOBjPwc?=
 =?us-ascii?Q?yBtvliTLM91CyEftMcNTFaHEiX7sobnLZzTX0qoskjuudTTfBjKp46MgOuRh?=
 =?us-ascii?Q?gW9FlIyVXDmZWUOfk06OKZkHfZl1glqIL8rpKe7qSMuiy+KJhCDehQ9H6rCT?=
 =?us-ascii?Q?xWNoRDNqf20ycQVzWIDlVRUQvIZgPlCbLhymzpVaWnBBOl/0AhEU7gPBzjmG?=
 =?us-ascii?Q?AUpU5tVZjsExOB29sRx36+vNQi7EyYW0bH/KiX6oZm7ibpE8/gFMNzBJIvsH?=
 =?us-ascii?Q?TEnej1URTPGahi85NohFL6HjFlDOt0J21+mHX43EN+X/yDqP5l3/t0oSvO1s?=
 =?us-ascii?Q?CAJTGBgFLPk+zwcmvdNlwloHP6fduNzOK+eonIV9dzSfvvbG/ZdIFEQH4wHf?=
 =?us-ascii?Q?ggTS0j5kBHRWeMM4aeeIBiFohOEYCgeqTJDY2F8NhTofiYAW7knW/CveQtez?=
 =?us-ascii?Q?Ism/gfg/2m2iue0VOSG5iyXeiA7Kx5QuAOngBlofhWZEKwg9txcGRy4JqKkW?=
 =?us-ascii?Q?4eITuNcW1BAts8yw2R/Cwi/DkqLT6fR8wMW11L/LwRlG9jVODr4Hpep+MBaZ?=
 =?us-ascii?Q?MLouHopceoSaCiv8jm4chU/BDicPf5nr88JUAAGBl38DVr0E?=
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB11748.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fb67bc-5893-4af2-2785-08dec22d07dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:32:59.4099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTi0PRAgG5JKzqbnYm6CBcyQaUStCpi3LyRJpa1rUWr6EuT55Z5CjWVrV/9889EW6BtI4CKeLhJtNG19ZZoACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10021
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

Just a quick ping to follow up on this patch, if this is OK to merge or if =
anything else is still needed.

Best,
Juuso
________________________________
From: Stefan Roese <stefan.roese@mailbox.org>
Sent: Friday, 8 May 2026 14.49
To: Juuso Rinta (Nokia) <juuso.rinta@nokia.com>; u-boot@lists.denx.de <u-bo=
ot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>; Bharat Bhushan <bbhushan2@marvell.com>; =
Aaro Koskinen (Nokia) <aaro.koskinen@nokia.com>
Subject: Re: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marve=
ll compatibles

[Some people who received this message don't often get email from stefan.ro=
ese@mailbox.org. Learn why this is important at https://aka.ms/LearnAboutSe=
nderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On 5/4/26 11:36, Juuso Rinta wrote:
> The OcteonTX watchdog driver currently matches arm,sbsa-gwdt.
> On systems with multiple watchdog devices this can be ambiguous since
> arm,sbsa-gwdt is a generic SBSA binding.
>
> Replace the SBSA match with SoC-specific Marvell compatibles
> marvell,cn10624-wdt and marvell,cn9670-wdt.
>
> These compatibles align with the upstream Linux device tree binding:
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%=
2FDocumentation%2Fdevicetree%2Fbindings%2Fwatchdog%2Fmarvell%2Ccn10624-wdt.=
yaml&data=3D05%7C02%7Cjuuso.rinta%40nokia.com%7Cdc8481225a664c6ec61308deacf=
7e7c2%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C639138377910570533%7CUnk=
nown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z=
MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIV4hBdwPl%2BFe43c=
jTR28jLpdmPpZt2BX%2B8XyidREgpA%3D&reserved=3D0<https://git.kernel.org/pub/s=
cm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindin=
gs/watchdog/marvell,cn10624-wdt.yaml>
>
> Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/octeontx_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_=
wdt.c
> index c79d9539c13..7299a9f9739 100644
> --- a/drivers/watchdog/octeontx_wdt.c
> +++ b/drivers/watchdog/octeontx_wdt.c
> @@ -159,7 +159,8 @@ static const struct octeontx_wdt_data octeon_data =3D=
 {
>   };
>
>   static const struct udevice_id octeontx_wdt_ids[] =3D {
> -     { .compatible =3D "arm,sbsa-gwdt", .data =3D (ulong)&octeontx_data =
},
> +     { .compatible =3D "marvell,cn10624-wdt", .data =3D (ulong)&octeontx=
_data },
> +     { .compatible =3D "marvell,cn9670-wdt", .data =3D (ulong)&octeontx_=
data },
>       { .compatible =3D "cavium,octeon-7890-ciu3", .data =3D (ulong)&octe=
on_data },
>       {}
>   };
>
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-rinta-octeontx-wdt-compatible-0ca7b83e634e
>
> Best regards,
> --
> Juuso Rinta <juuso.rinta@nokia.com>

