Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EDCEBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA3A83F75;
	Mon, 13 Apr 2026 11:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="buD5LMfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455DC8419E; Mon, 13 Apr 2026 11:45:19 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC27839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfJReVXMUjPbkZSMv4y11YsyCGADLiDc2xGZLgv3lzzqfOZOGE+Bu+5+/SYAtlIJ3Y80dsdf+2G0tu53Ql2Z6pSTYOrRuyhIyIKIbUqRfWY/DvrajK6HxeCrkmuBzvWsYvFgyPPlgQNitMkAM3btBz/FlQEboPAgpZHREPc184qtfjq10L0TltoKDT0uV2Z/Obk9Qv85QPI838wHvJ5SF7VGMj11EPefGVmqcRhfcXpreVZLRyOoC/Np8lN3bt43XdDLaNF4e64274+O5+o42SiKoHATqK45y/VYmjW6biG2Fit00ulLLYGAMRAOdei/fzkdhsg00rIbnixsr+S4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ+5Tb34qN035aKXoDcLUEjIsPBwU0oMSZM64QApJTg=;
 b=JuDzwujuPMIReIrruPtPZbLu3vc4ZGsCvuo0NIMnLa/7jXHq8ebBhTb9hgB0vEFsNa0hT43ksXJTX7bKiMDV+AxC2O0HsVv5a8RKn0fmSTyck4oOxU3w961xWWEdscHd5e9/o9b+vThHve+yDlmgGasaVVer1odhVUfrUUISA5ZNEBQaKXI75qLB2UGmuRRwDJCFjJPzcr9VKPWWc3dvEGEDJ3NYqY06WUPkh9iDzKl0TDgVxdWPuSGR43NJjaRhJHeBsXBTgKeEDzOJLZtjdN1smxykmQzhA698IpXzy70eSo2jDjiI1npwpv4zN4qN/AQ8Z5Amf7kpT0ZendPmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ+5Tb34qN035aKXoDcLUEjIsPBwU0oMSZM64QApJTg=;
 b=buD5LMfuQG71T6q9sZr7W/fcEf89dtwJyoMyQrv+aezGZpGVSk+J9ak50iN99js4v/Ivh5XPb8uJzzx+Fn/0nsNTjz8kUg7nQ7lRWkejoMDn8fY0ZRtD5RyaMsHWiIghKJY9nFNV8/IhfVN0o1v0R8CuhRYfXpSZtL8Id4sGe+Np6ciQ0xEjm4JBS1KFAwJWwvzOyvvqYvsnt/ZWv+mlQWFbDZ7rimeMAR2CHYmoGCKP3F6rtfdHOm3Ew5kOvdfht3LglAMKCJRsGF+mK9Hy92ILJ/1JKOZ16cuCU+75v67OIVJ2btosbuEn0y6q9D6tuphoZeB1LgBG/4zVZqLRvQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB7256.namprd03.prod.outlook.com (2603:10b6:806:300::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:45:14 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:45:14 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, 
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH] arch: arm: mach-socfpga: Change U-Boot mailbox client ID
Thread-Topic: [PATCH] arch: arm: mach-socfpga: Change U-Boot mailbox client ID
Thread-Index: AQHcpg/SJBoAsPt0+UmyBhWLpYNWVbXdCCSR
Date: Mon, 13 Apr 2026 09:45:13 +0000
Message-ID: <LV8PR03MB81370BBDC3BA344C9B7C5F3CA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225043209.7512-1-dinesh.maniyam@altera.com>
In-Reply-To: <20260225043209.7512-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA3PR03MB7256:EE_
x-ms-office365-filtering-correlation-id: 244b9c29-d6ab-496a-e3cc-08de99415cb0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|55112099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5yEj7CyaWfx0TTbS2E4kPW/7sqsRgR5U+j5E/KAQRZSwPOe/WElgXYZjPtarzhRGmdFGQpo9KinVNpFanpK7rq91ZnC4SyxJIXPvyAXiwcKxoKqJ7wLeQHMx3RVZOjOysx0UEjw2RGf0ZthFKerdOqEIa6QssqqfqDEp3p1WuigV5MN6sFPLyrr869bQEXiXEx+mNaMczxrKkvCfjHCRzfm7b+R93MAeB7vUu8tsTtdBvgxYtFwBIvPoGkwzY2oPqweIw2WxcTYRFHu5qwUpPuytkBgpjDA+BupJ7CZ5dnp02hImo3T0OX20N6l3ZA84Hs+qCdXYeXESuPfnnPogmj+mmfGAT1JpQSmNMntpqGI+HgUq9k/AZKRwJigELAqYqggxN0JfJDvypisbC0Vqzk84D6HOzVjBgI2OsHKIFtjR86xcFtiLVA6vJokIJsmDkqDf8ZCEU0gHhL9VYJSOT9FXPHcaQFsWCtnT5qiPQ1lzk1CTFCanW6+bqSC2ATq4kkt0dzPTY/tRK9Adc8d9xJfRRShpONl/PDZDLSrFlyCTkKdIjaX7tGCyMa6bqa7P0NMQ7tnlCEeqKJLpRQVHjmRnWpXgoxht/Y5wDSNSjLXGgcUp7uJE+bUeie5GktsxRkAW3/6pxrU+PBRGvCpMRdoG2J2+fuN6T3u1/S5lV71m4Mq6Dp3uRa+n+/3C/cjcyB73qeqJZPRPfstz/584cOzAvfGjAiGS8BW9G+bx0cXY1iYosGfPBz0lMqq9rjeS07mXmXVwSSKV1gvhWP7DdP5Ic4JW+b3JJDxH17JNsMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LtaC89cBDLVJBXJdFGbAEUZfySGKoM9Y7PgKAlC2h4hVfIRceiPzUgI0ag?=
 =?iso-8859-1?Q?KiYQ3JSR6nBTaNVhthfdIH+0DnnngqSO80qYHndEExw8zjbxNWBSBD6MTX?=
 =?iso-8859-1?Q?KBl2Z0WeSb2/I7UDn7uALaIb/pBSD1ljGPkGivnEvyEB5KDWIXjTQUNc3D?=
 =?iso-8859-1?Q?uCgs6NJk0d56x8MwW6dth8NlDOJDFkDpve+dP8X4cLL/b8znDMr8WK+Jza?=
 =?iso-8859-1?Q?KSCEaXQAycx05XRtjfWXIW18PM4z3kYvJOnOV/P0nNjvmOkse+fc4hxJbW?=
 =?iso-8859-1?Q?e8CVQaIPnZxOMjvuils7ZGy24jQBPe9TDAYnkmlzenXt+xJ25G4c5+C5uB?=
 =?iso-8859-1?Q?KtHR/AVY5yNPytUor2moXIQ/G2juoQKZkHRu5PmYK0eFQTDtaQBDbJidvS?=
 =?iso-8859-1?Q?FL3K8Jvm5S6eFTXQMWZU9klj9OnjV5i1nUVjpWl6ZueebYDwyP0VYe908V?=
 =?iso-8859-1?Q?hJRBTjRhk6x7iyyqTaobvemkaYArDu+5HVtjQhEHSLUSHRlFM8YwzB00f+?=
 =?iso-8859-1?Q?QK8INZFrDGDjjUwiEtnSOqszgPX+koHuqaHbDzseVGWEeM4TY/uawI2nYJ?=
 =?iso-8859-1?Q?5MYxqv1JkvpWBUyrXiWychYD3Cmc0KWcLvDAk32xKCr+re6WuSzg9pvr1R?=
 =?iso-8859-1?Q?unh29ySsDZLTlOCD1rA3EMByS4WHs9YGBzsx/G6mLbIwzxAEcgzQkWTDaW?=
 =?iso-8859-1?Q?jBviETM8gvflVGMAw2aiknZgh+WB9EieNFv7wybNFBA4nzNadytPtzSA17?=
 =?iso-8859-1?Q?CKIOnj65sZ+K7JDdmd4IkoKwd2JGhcyTIzE3dpbUxYcYyUGE3Bg91egfbY?=
 =?iso-8859-1?Q?ITa53rimiHkE+XpvSgHhc06OaM26BDQA5C7LiGoaH8Nd+z6VH14DEjY+96?=
 =?iso-8859-1?Q?FScizNzSpmgg9O4sf6r3+3PraPzM2JmJpHWIp8eTnO4bGYJVW8XyaYtT0Z?=
 =?iso-8859-1?Q?O/GL3wtX78fv4rUpkhB09CRZBqmbEssULCtEyjRjALImHdnc/TxI7OQURH?=
 =?iso-8859-1?Q?dAuutkFimIwuRVEnldiyD2Cg64g42GGz0u+8YfMCK2gJMgOq5K849JojNp?=
 =?iso-8859-1?Q?gMm4kQYZuM+lTTUOUqCYr9wv+w0P/SAAO4LouOqiTgYD8xJtF6NFBlS2CP?=
 =?iso-8859-1?Q?OiUadi5+slWlm/1jPgfUqOkaNUnDaqDGU69cgKxyBZxc1JKBA8AOnM6+Q3?=
 =?iso-8859-1?Q?beDX7VEL2pmyjUj8W01FlaJQun1IwN+JVcqbulvEUK5be22IXGOnlF813v?=
 =?iso-8859-1?Q?1TEw4Y2EYmMMBQjBCQw+d3zQEbYSOjGsdc1J1Y9ywx9NS1HMEZ2AEg8xkP?=
 =?iso-8859-1?Q?LMsBsvAiLf45ZUw7CKrXrBo8VSV6eoMHolhbB7lDechLp5R1M+Kzy6wrKX?=
 =?iso-8859-1?Q?b4qWoQtrp6u9z5b7vks8sehHREhruJdjJDAxLx+IO/uopBh/Y43SGOcIvr?=
 =?iso-8859-1?Q?cC7YmKBCkwwH8yUZDZ8kl1gQzJEVgYIDm0VkuX683u2Ob+ylmn7blXaGqw?=
 =?iso-8859-1?Q?zrMIA7HhRrVtRAOIow2S6Ill5LPQ2VAzZcb80bSJwYlB0woRnAAhNU0OlL?=
 =?iso-8859-1?Q?GQdbHDEE6twobdF3a+EE4yLZzPmCCZKoe2cUPAskhlvZVNo7nas4uCdoy+?=
 =?iso-8859-1?Q?GhPILmDQ412vKewZsnK9GzCxLxE3eFvCE/atpP6QyhN71O2KyUjDRuYSHQ?=
 =?iso-8859-1?Q?c9WgGEejTJm6eZl9K2UR5augUrGsShiBctzlbC8DYJUyf/tIc3FfkZ58SV?=
 =?iso-8859-1?Q?JGeNWemjCJeWTOmjPVBhVmH8UIE+hXQUQ6i7qvADLJP1zk6rHE9uYShy6O?=
 =?iso-8859-1?Q?7UM1c+arJw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244b9c29-d6ab-496a-e3cc-08de99415cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:45:13.9600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07UGElmVnYdH5eugfOOWZxgCGvia5xJiKz60A+jf3R0uC0O2zm7VitLLDHVfF0yFJA3PgfzXhkSRSVquipFrbPwRmFVf0XpG3g0E+b91zh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7256
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

> ---> From:=A0Maniyam, Dinesh <dinesh.maniyam@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 12:32 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Marek Vasut <marex@denx.de>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Chee, T=
ien=0A=
> Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.co=
m>;=0A=
> Maniyam, Dinesh <dinesh.maniyam@altera.com>; Ng, Boon Khai=0A=
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan=0A=
> <alif.zakuan.yuslaimi@altera.com>=0A=
> Subject:=A0[PATCH] arch: arm: mach-socfpga: Change U-Boot mailbox client =
ID=0A=
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> Changed MBOX_CLIENT_ID_UBOOT to be the same with ATF's mailbox=0A=
> client ID so that SDM can treat them as same client for related=0A=
> request. Otherwise, under some specific cases, like QSPI_OPEN in=0A=
> SPL stage used different client ID with ATF's client ID for QSPI=0A=
> exclusive access, then following QSPI access like QSPI_CLOSE via=0A=
> SMC call to ATF will fail.=0A=
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> ---=0A=
> =A0arch/arm/mach-socfpga/include/mach/mailbox_s10.h | 2 +-=0A=
> =A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
> diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h=0A=
> b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h=0A=
> index 1a461de4819..0025ea2dbab 100644=0A=
> --- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h=0A=
> +++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h=0A=
> @@ -10,7 +10,7 @@=0A=
> =A0/* user define Uboot ID */=0A=
> =A0#include <linux/bitfield.h>=0A=
> =A0#include <linux/bitops.h>=0A=
> -#define MBOX_CLIENT_ID_UBOOT=A0=A0 0xB=0A=
> +#define MBOX_CLIENT_ID_UBOOT=A0=A0 0x1=0A=
> =A0#define MBOX_ID_UBOOT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1=0A=
> =A0#define MBOX_CMD_DIRECT 0=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
