Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46F3C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C087831FE;
	Tue,  8 Apr 2025 09:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l++GsH32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF5583211; Tue,  8 Apr 2025 09:11:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D922E8312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8tYJgdlNNNz03aYFK1ZvqiF96s1QgZWcgR/0r+a5P6LvufTZSLwHhF6gR/yJbHTAiRs8ydHRgB5HQ7FAppsbVhHWfm0449LHYS6czUmoH+Fklsui1Yx4q+CBDMa20wGOnakcuyW2RlxL/Br9zP0eDC9Epex4mP1svdprFVZp5495/t4zDZ9DcrHhVPahbkiiu2BO6jDlLD1yPZ8qIc4jShMxEX3PQiGk72NFek+wkXsvJB7Hsy8/GlZtSBQnHoZd9GcpAeHmRuu6j2l0xsFcv9KOFcQcxXWzd/2TPvoEKHBSQDKIauPVuMKtEOKOnCoFwYi2bMrWpjQb21ujSlRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYnE0mbBrohYtpbpXwLmWcgap0Y+DsloBWA/159mouA=;
 b=yjg4EuMJ4/JtCrSRiaBp8O0yg5I4kibBr+aNlx7QXYFR+Er/E8w35UwkFt95ctI8UCljUz4mZRaX4lXQudb35CQjn6JHI2BSBYh6gJogIwvQhn8uN7XAIOBUPHPJ7e8hwIrnlcud9l1NvF45CFp8HFGVBA1M+iYLbtv9Du9Cr9m59aMBoQPe/GsRO59sQ3rjPDAuMeSRuSYf3iSv30kZ1Vw2XHqtBtWEYH53hPPB3Cj/+kCCDJYZciIdSQp00ZcakV420LxyI/C20NO61w+ygftwAUsIJGjAvP4fK38dW0VWOD/+iKiYMIHu6EblazRQ+NSrQ/IVr6yG/hoEmPP7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYnE0mbBrohYtpbpXwLmWcgap0Y+DsloBWA/159mouA=;
 b=l++GsH32/VnAugqWlUm1YVtRyLsP2BcnHs2kwyMlSJepH9WiExqsxTv02U+vHCnA8IfovoK+eilXNEexB5d60S0KmC8C9UsxGRs8fK6fftmVSXEbpSSb/OYTVdl6OW4GjQWo2qAsmv5NDVkG2NsKDbBOEQq1CBsNvvAX2W5KpLnv97GAG6a190Q5Mdz7tEFsTWf8tA4slfHqdLULT0EHRcB/GwXwxHQyj5QnLSxP2sIv6rAf2K/g6vav6n1U9/25phi0Ko5uD0NncqIaxRAl3bAtWSolIJ6LKAFjrnvy5/V8rV0PB3hJ2bHIH65k41FBu3Zl1tzE8y9T1aKqSw28Fg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN8PR03MB5140.namprd03.prod.outlook.com (2603:10b6:408:7d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 07:10:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:10:59 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] reset: socfpga: release more A10 peripherals out of reset
Thread-Topic: [PATCH] reset: socfpga: release more A10 peripherals out of reset
Thread-Index: AQHblQh5+GM7IQE67U+q2sex+l3S37OZgIPA
Date: Tue, 8 Apr 2025 07:10:59 +0000
Message-ID: <LV8PR03MB8137D2E581BBA05945C69BA8A7B52@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250314174225.1245-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250314174225.1245-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BN8PR03MB5140:EE_
x-ms-office365-filtering-correlation-id: 9f0889a2-1920-45d6-ed27-08dd766c83c8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vpPkcewyqTUYe3t39r9knf7MP+44rJa9rxIoAHtqZlCix9awcq8ju7EODgeS?=
 =?us-ascii?Q?USGl6E4KIXSf4iPAnKGZ/vkA+crLUFhVeWkj1QCKMlOccTZGjqQB2FBP2qes?=
 =?us-ascii?Q?99tYAs1obf9ygJwBCqVj8LQyRUNHAyHE0/RiZiBmI201cZ3sEwyRHc/gA9C+?=
 =?us-ascii?Q?9olyyV/sl7YW35T4j83cRPpQVOgizXk+j/2BvvlOe9ZZv1qx8KFsWdwEx6vV?=
 =?us-ascii?Q?j8h4dxkh7zAlg7OPm+XGtBBUOl5821mXRzsmbo16rqb3zsHbuovk9VUB30ns?=
 =?us-ascii?Q?DQlc6OWjXcPKhyQGDtqAaPjm94fS/J/yduIhnXkAVvNr4yKnxI+CE1w0OvnK?=
 =?us-ascii?Q?6rK/LoICTd4uLhIEgX6laTR6G6X2OA3Fl0ViGqn4733kr8QF9WbadsOdBlhH?=
 =?us-ascii?Q?/LPLihsOoJytgaIZ2MO6TUXKu00AfnKvidgX8NSDopiPF+ry6k8L9lELQSU+?=
 =?us-ascii?Q?RCFiBEVCme15svjJG9yQ02ISGiELXHMAbacDIcoeK5IcIrXrALXDQqyBGjso?=
 =?us-ascii?Q?r0X3hXKVl0avdL3x3xaVfh5ejPnvrtMv2RTCbswtOOjlg419M+JMhyr9ENZl?=
 =?us-ascii?Q?oNucMzExmYfOTW5QXNp2c2w4NYWnPKrMOh1mtUwUH8e5ONa012iTMIbUhaqQ?=
 =?us-ascii?Q?KUyg46THtecSi0iZiSQO+w/t27xRyBaA3xV+QhmFx78mQWEd+c1p7WGAfDaA?=
 =?us-ascii?Q?aOjR7p33xKh2mZ+M5SwYSX0sudDjE/MHO7P/CWTdKYvs1XHb8FJe+PriGllR?=
 =?us-ascii?Q?KMc71TeWpaMnH77AhRwrKmEz8mDa0Mp7IfZUgtrGKVPqu15AsLGV7O/N05kR?=
 =?us-ascii?Q?gQfXfec/0PfCfQi4C9hNJr43orHlG2+jAptxkeQLrI0pqZm8qJ22WIp1tYRQ?=
 =?us-ascii?Q?PGTwTfa8FQlQ1gdzDswdTc54+8Y5t3ztjzadg/E6w635dO42lC+BJpLXpqGT?=
 =?us-ascii?Q?l9hn2aPRQQuHev3IMz6g5MdC5qbybE/rG0LSwG7zNy1joK/6/mo2ky2A0PmS?=
 =?us-ascii?Q?R4TbY1nN3ZiX6yMIliJ8a7o3ZE5E7pPwowk/Mxqp3VhmWS3CH5ozcwqmbWx2?=
 =?us-ascii?Q?jKDz7WrAA62ahCcQWlVprdT8OwGNZ0VTjmqSkixdHAsKa7nSHLG9j91YLaIk?=
 =?us-ascii?Q?//0sMtPFqMDjt13ljbcs78XwwSGKbm/W1xcDknL+3kpay28V2+BCkdqbxIb9?=
 =?us-ascii?Q?GdY92LUqKSVKlsQ1EhVGXOaa8aYHvjknYdyM+8SWpdj+3zdgEV4JB37tr7wb?=
 =?us-ascii?Q?pAKw5yTTFQB1RVIg6cPw/adFoPu/2CRJYJOz+mFBOIXjC7YSUio26JCY8Ldf?=
 =?us-ascii?Q?zkFvl6i+00C604y9jk/Wg1djiZYUNpKbyT8P6BXKJ+67YkLI/NSXWmkCxNHn?=
 =?us-ascii?Q?pNFzoKPPjnSAxp0WQCA1jtIWfUDIlFgwH4SEMbcypxnpgqRYCui9Q31zj//m?=
 =?us-ascii?Q?c22mO4aXkZdiOCN/S2p52M4K//vh8aSi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3kWBXLoD/QvpTzJancWJpv3nmBsxRfe0Dsv/rdn0E4nqkvKM20FWdGf5QARm?=
 =?us-ascii?Q?zN4p8B1feKrAoeKqLEjYy2jwBeOMu1uiGC9rn4G1h+/ordsTdyjIpH5roUes?=
 =?us-ascii?Q?PTF2FRApK6ixie2KHC1cM2I3Z6jXHFin4fgee6lNDmXJsU0HVBl2RAvkUpJp?=
 =?us-ascii?Q?GddegBbHv9YhS8VogFjFWqqqUE/ht6mKsZDlmP/K3uQuFORbatf7XfRoZX8i?=
 =?us-ascii?Q?PjZezuv/V3UpTMHfLQh4vNvUJ9D/WTeYzjc7jEm6I0Eh1h1WjtWef7o2Kc74?=
 =?us-ascii?Q?6OvYuKnJnkTI2jlUONb2qH2fdN8X9v45shsm6VPv+fKs55cebGdSa5RT/kKx?=
 =?us-ascii?Q?97/9uPWb179nAO+Ej5KSnytlsJbcihqr6bZ7lSmljatapoXHCviaJecGhXjL?=
 =?us-ascii?Q?TR+KaKZM772cJu3yM+GwkqxgWscfcz0tmzqR0VjRplkfPfka8/g1D4lywPz+?=
 =?us-ascii?Q?f1f6JxTdYj42xCcTWC1nVVJVBVCCILnaEtOMVFeb1sdgvrBed5BJSErR7Tib?=
 =?us-ascii?Q?aPmERPCVJRfYXLwcIQ9TT1pzzDoP5n0xJIRnWJuVyZFzI5TzJkEgHT1Ah1Mq?=
 =?us-ascii?Q?8SysUnasUKhJ7v0SavSpnFZpW1155te2U+28J8hE1mXZ2o329Xlo7fEhRJRg?=
 =?us-ascii?Q?xQxqDQ9Mvpv3bKnpezFUmhofd8+gNN9TFfpF72MJI36siTQt+hDoRGiRAj9w?=
 =?us-ascii?Q?1WQhMIW1EVWBbFz6lQQ9jIsjcdK9Swcqcc1c3ZnQcvK6xMBZhSFgrOhWvaim?=
 =?us-ascii?Q?Fz8AZU+sOTIJkAxH99Lg5jB1UXKw/aMAczeVFWF7alc/raSmgntMApGg+3uK?=
 =?us-ascii?Q?iaQ3TYq008l3kqIiD7Uwy4c1L1QuaKLYKNDe8tbukMjVMAFaK4fQ926ckRj6?=
 =?us-ascii?Q?oO+4YVw8T8n+7RN2SAZEL87OS8Xx5FXPXo6S16dgEd7UvumHcAEaum0JZ0ol?=
 =?us-ascii?Q?bGcAoMfzUyRSJFsdxZnfpzmLyxDvH0u/jlN4PVKqFp7rZ7+j6MbY5QirJa1/?=
 =?us-ascii?Q?QAaIb3VkFG4WAL/m+8dHEuWvGEbsU0qo75AOALQNwf35yhalpwWJU3ADdYai?=
 =?us-ascii?Q?xsanosEKIvJQ9egU9+KkbK+9omv6CPFOge+oz+W5SnmLKYFPrrgerYSJ7D4l?=
 =?us-ascii?Q?B+Iaw2VFPhLhn0ME2iEcUrS/6x3q88Jb9OPHbdCqJvQuFN7kNj9r5QEILsu7?=
 =?us-ascii?Q?bkCRGSu/A5B9bgU2pIN/aGusdKaYR5jPgVptO0X0HgGsXyQ5bIqJ3M9kVDkQ?=
 =?us-ascii?Q?eTHdXDVFeHED0gUQhtx95AMSnyv6sOCwV65NdvsIl1iZ8JxgNQT5wJEfIMuC?=
 =?us-ascii?Q?VdlLojC+nM9ZUtioetH+Fuety5parNgkK5r+fqXPKZQZX3BNune5VcnfYM1a?=
 =?us-ascii?Q?7bocw2I6C00PmZgVFg8ZhEMBfBUI2T1mi5hA05EzLOkCVzAwKWIA5C9jOL5m?=
 =?us-ascii?Q?7yk3vC3LLD+mwaUjlUOU+aWdoQ3jjVKSml8ewn/MQRpgS5ctrAxR/wqSRArX?=
 =?us-ascii?Q?lZxwj8gg5k8OUNPI4htonh/KjLyJq54xA5r8jN0RYdg3olA1/X77jUUxB6kO?=
 =?us-ascii?Q?FoDaiByQs/hjuiHnFAaaXv4kw2IBam+2iVSSXE9P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0889a2-1920-45d6-ed27-08dd766c83c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:10:59.5854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3g4Kdm3dV7rX3SB/Y+55AIgotmlH71+HODoJm2nEcZXySawpiH1peC/qbXKnjNeboRQhaV0X3ELpSEBfI8Eq89BanE39R7AQ9m4ti/YwLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5140
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Saturday, March 15, 2025 1:42 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] reset: socfpga: release more A10 peripherals out of rese=
t
>=20
> Current implementation releases most peripherals out of reset for gen5, b=
ut
> A10 has more peripherals than gen5, hence this patch is required to relea=
se
> the rest of peripherals to support old kernels.
>=20
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/reset/reset-socfpga.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.=
c
> index 76d108080d..e57729f0ef 100644
> --- a/drivers/reset/reset-socfpga.c
> +++ b/drivers/reset/reset-socfpga.c
> @@ -23,6 +23,7 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  #include <linux/sizes.h>
> +#include <linux/kconfig.h>
>=20
>  #define BANK_INCREMENT		4
>  #define NR_BANKS		8
> @@ -114,6 +115,8 @@ static int socfpga_reset_remove(struct udevice *dev)
>  	if (socfpga_reset_keep_enabled()) {
>  		puts("Deasserting all peripheral resets\n");
>  		writel(0, data->modrst_base + 4);
> +		if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_ARRIA10))
> +			writel(0, data->modrst_base + 8);
>  	}
>=20
>  	return 0;
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


