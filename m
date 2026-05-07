Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32455CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982A484AC7;
	Thu,  7 May 2026 18:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b5F0I8v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4C384B2C; Thu,  7 May 2026 18:10:46 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1339F84A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTNi5XZ4s4mhagROVQjN4sh1EU5R1ruhe5P8JtFkT+SihbRhab5offp30+5e/6dwam3u21ynvyCVNltExVSDmkaCvcKnaB6G/nfnBu9AwRz8B1cL7zcwgzQYbRoaTUA3Pu8jk4rk8xS69U4cY+ECUAhP5VqOpfV+wthm6nrMqIhu91Bt6L5X5dpqwX8+3RFlz4PtnCjyca3bOpjDSjaMgpMhKHyneEPhsDU4GxqiFwG25u93hI1W5KDzgWAxCuhqOmhPjZE4Wi94CmoP4cYucF45MwPvSuYs0JuzlqM/WaDDymDQwCBPt9yOYERHWXAJevnM83/OciTrZ/x96yZ99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCznmG2jn3X+0Q4iYpJAG5dt8ISlXt9lURF50D8btUs=;
 b=v1vJ8vUeaLbVZfBgVupUCsM2lhjMacwRSr3P7b9bs6iVld/kTh2ouJ1972dtAr+07lxQSfwIsVeuDpifdoS2y13spVDohLbGy+BegvHK75dLQx50wkwj5OIQeC+gkFjf+EQIjbpc/UcivomZWWKWdS6PaXGuqSuZVqeujr9dcj3+u/ZxG0EacrNBFVT58HRbYx/O2ak4BlQSgR2+n4AudZQC1EMTvyaI82Yuqt5T2YL4BT8JFAf3nFXwmDXmo8AWpA/kw9KLJb5lOWCaI0Hb8pMfTCrvOD6pFXA7ZCrEyO2b4IOXC1ikuYO0DF/om0DMhXlKXEp2KT8SCfya3NW6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCznmG2jn3X+0Q4iYpJAG5dt8ISlXt9lURF50D8btUs=;
 b=b5F0I8v76/X5Ac5EbRfhI4Ect0wHIHUY4Y1Ms/yBiNfjXp6rmrkQrRHAmoUrJh7DVg4lq7EyIcA+d3lUwlIhA8h/apffWqE5dH7pVwQ4cXWZrOPhGyZk6/enZEO/m2L0FvU1YNPazsQWYkjJaDEKT0WCv6wHD7fuoT3Pymmy3+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS4PR04MB9716.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:10:41 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:10:41 +0000
Message-ID: <341651ba-ff97-44cd-bc1c-a1a4436fec55@cherry.de>
Date: Thu, 7 May 2026 18:10:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] binman: nxp_imx8mcst: disable configparser
 interpolation
To: Julian Haller <julian.haller@philips.com>, u-boot@lists.denx.de
References: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
 <20260504164849.108849-2-julian.haller@bbl.ms.philips.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504164849.108849-2-julian.haller@bbl.ms.philips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::34) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS4PR04MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 231a4511-5d16-447d-e974-08deac532fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: L9OiTcPLqqlx2bzaG1q24dgDbYHQSlGCGszfWSkkonteXdThGdzM1Jf/qG9Qwh3J0zCSbWGE71Sy4OAEAqzDpZv3ZSdbLhHhyF0QvYr3kyPgHahmP/1NverIU26R9pidOvTIHvwa+FdELqrWzqztwTRy0/oRnn86mMfleLrDkT7ZTfkE+YXX6XMfnYtcAZB2Kq4gCVktIPgwu0xEGOelARWpHOGEzm2p+lP/WoKNujCiXvBhTlqiDy9rYXPdNWn1jm7AZouNYGCXfIqOqQ7k2iSjhxaPGXspXQ/b3YRcgska+KPOjt6UZCtXzFhEJ+5yhQT+rnVZOINRrylTT2ZM6McTBNqjbE5hiXAfSmQ/mm8uqKMMrlwqQ55g8vIjb5AVj9cheHvrzigLz+MVtAxA0YfPh6pRFT+y9KWE3CRIrRq3huEcquYA3DFaRhjof4lk81tn13mUXsmcbCeVU7g1uJJvlu4x0CN4YoF4qKJZSpamy1eqrAZMU62NCD8FWCD80OB7eQUvxsKyXbJ35Se0DcVBcGlPTVa2avxrPzR8s+5j7ntDwPXR2P8Cz9/iw2JlHKIMGRy7WtmHiWd56Jq78vwL6/RVTSg+6CD+RVsA8ey+0uqogWPkQhGi2HsHwblbH0ty8Y0wr/h8yf/Lm6dTOhnNbEmDl7E51CAUdvLnaE5ufFwue5BaEkcS/P9PYU3I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBuK3FlcTQwZ1UxdUZlVEpWY1ZPV3J3bDcvZnBzcUMrUENvbkk1QU9XemYx?=
 =?utf-8?B?YVBKNlozSGtHUDluYlJiNGtrQzZYb0lNeGRuY0NMVTd0Q1lmK2QvZkhsbWQv?=
 =?utf-8?B?L2xzWGZnSk9WL1FTRFFicFgvdUJKRFNLc0hpZm9lWjdodmo3Vy9LYnhNckxI?=
 =?utf-8?B?VXZ5T0U4NlJidHV6YnJTWk9VVno1ZTRncE80R29MQ0s3dFhYT2VNMlRvazhy?=
 =?utf-8?B?anNKa2dJTk1vd3RRQkEvUjBnd3VQUEJ6K0ttc25NSWJjNTh4SUJURWx4U1A3?=
 =?utf-8?B?aE1mSjMrclRvVWh6QVVabXRQNTZQVU5yRnU2dUpuQ3Nqb0ZvM0VGbUU1Tyt5?=
 =?utf-8?B?M2o2NnU4WHRNNFYvaFBMQ2t4Q2E0NmdwRUN3MlIrb2l2YWN4a0FZbjZ6Uzc4?=
 =?utf-8?B?WTVPK3pjMnQ3SWV4d2ZZRXpDMUpTcWMzdXExbGlQYXJtbFRDMXBWQ050dCtI?=
 =?utf-8?B?UjU3cHdEeHBKNGhKRGluQ01JbnZQTUJ6bzJlODE3enUzbkdWdXlnZ2J1SThD?=
 =?utf-8?B?K0pIS3F4dXpIcTBld1g0RXVISmVRdUdleVhBeFp6ZGhLbGd0MUk5blUya1RH?=
 =?utf-8?B?NUw1SUU5L3puekhWbWdSTmJZWlVNdTluOUQ3akNpeGJGeEZSRHZwRGdSekxq?=
 =?utf-8?B?V1J0YTFKdVk1NjNjcXdXdjV3MHdma3hNUVpPTHhGUTByQzl1dVE4ejJadFY5?=
 =?utf-8?B?RW16VVVtdGxPMC9raVQ2UWNMV3U5aUJJanIzNk0wZ1N5UkFkWnJIcGwyd3Ux?=
 =?utf-8?B?M2pGUXBpMlJmdkZLL2o2L3puSHdLZHZndDBHTityZmR6UUNHcWR2SEhZYzMr?=
 =?utf-8?B?MnNEY0lra3pZTWxod0h6aW9NTTAzQnFvbmNhZ3o0NGt2SlFJbWd5cGc4ek5L?=
 =?utf-8?B?V1Z2N0pDa3M4SzZVRFBudlpQbmcyalI2VzRNQ1dYVE44QW9BR0FIbVJhZFFQ?=
 =?utf-8?B?RXVneXF1MEFFZUFWUm1zbmt1OTQ3VVZMek5OaGNHMHU4eWhpQk10VjFvUzdl?=
 =?utf-8?B?YTdjSE85emd1djd1ZzFza3hvRy9BTmd3c2lUR2ZjdENQR0c5VzBmWmxnOEdY?=
 =?utf-8?B?andabTduSDVZbXRZOUFYbk1YZDkyYlZZaWk2ZjA1RlFQMHVLdUJ6OGVYNUlL?=
 =?utf-8?B?TmxRdFZvZW54bElDcmtFWlMzS1lpN2p4WHp2N2NESHRuQ3Fsb01TNVphOFRI?=
 =?utf-8?B?RDVGTmtlWXg0VGdFNzFyVTdkMC9ueGx3ck8yOGxIZjNwcjdFZjFTTHBxY3VV?=
 =?utf-8?B?YWFHYWlTbm5RWitLRStvTFJoNTJzUXhPMEp4RUt0dGtHbnZsdEkxOCtQemxI?=
 =?utf-8?B?NzlOY1ZGWWxOVFJtNTlaMWhjOGhNanRid1E4L1RYZDZ5MGtqblkveCtsL3o0?=
 =?utf-8?B?cXNpYVh2dDBTNy83V09kb3BaYUF5Sk0zeW5VblNZVTMxZW41UzRUTkZpUENQ?=
 =?utf-8?B?L2liUXA4c25CeW8rTUhDY1I3YXRpVGhCWXVTd2lWWWdleVZ1VnRnZ3p2cVV5?=
 =?utf-8?B?MHFBdmR6Zm0xamVyTlJYRmdvWktGd3ZwWi9DenFnVncxM3BWRmxnbzBPM01W?=
 =?utf-8?B?WHh5dFdOeUcwTDNaQTVXQWhkSmI3SHovZWM4U3hGaE5IdE8rd0xVaE5ramtz?=
 =?utf-8?B?UlREV1FwZUV0S1YxTkg5dkxhZW9Qd0h3OXlRV09wVXpRVWFyZFo0Y1lUbkxI?=
 =?utf-8?B?cXV1STdtelBkTjloSEF3UkVRR2NwSzFMdWlZMDhWcHNxYUwzbnk4MndVWm12?=
 =?utf-8?B?T2NLYkdSV3M4dGRJK3ZFblZFYkxZTjllN2VBTCs4NWE5OXlvOUJIQ28xZy9k?=
 =?utf-8?B?RE9Scit0bC9ZWTJIczk5UU5wb0I4eWNwcm1rdXVqaGY1VVhGZGhmME51MnR4?=
 =?utf-8?B?eEFoTjFnTFlqWWFDOEY3c1hHSk81V2NhWU5wU1Z0VDlCcy9uOUs0bXFRM2w2?=
 =?utf-8?B?eGlaUXFQc1Y4YTBNbnBoZW9jZGtwL3ZFKzJOYzRVTVZrRTErWHduNjM1R3dN?=
 =?utf-8?B?VXk5Q3pRZml1T0xhV2ZuclRLVjhiK1VlTFVjQ2gzaFg1SldCR0tDN0lhSXBx?=
 =?utf-8?B?SHYyK0Z0WWtQdnA4YktiMzBwcHJaVThuM2t5TStoTndVZVgxemlhU25PM1ho?=
 =?utf-8?B?Y3ZlMHd2NlFMSGxiNXNOTDRNQWFpT2syZkIwQ0dzRTF5V1B6bnJCMmh0UHQ3?=
 =?utf-8?B?VFhyakE3Nm8rL0JMSllJeVBacUtyaGdCclRJVHpSWEhFNnJ2WEY0blROZHJ3?=
 =?utf-8?B?aERmSmFmUS9VTTg2eTZGSVpHaG1qYnVxNVIzMC9qdDZtczBDVUdWaGF3bExm?=
 =?utf-8?B?dWlVSDBkQVg5L29WRk1SRzhoamdkeWNOdm9STTdvM29ZRGpwb3hqdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 231a4511-5d16-447d-e974-08deac532fa6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:10:41.5941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAsahmquSCTEval6Yg+gXV4fL/nzsYViGgcEPy8qbV7u/3v5+hQrKHBaip4XzGT8XEfTSxJ0jZTSdy29zm1LYI5uYJWhSqvjA2hBCjO6+xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9716
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

Hi Julian,

On 5/4/26 6:48 PM, julian.haller@bbl.ms.philips.com wrote:
> [You don't often get email from julian.haller@bbl.ms.philips.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Julian Haller <julian.haller@philips.com>
> 
> ConfigParser uses %-based interpolation by default, which causes
> PKCS#11 URIs containing percent-encoded characters (e.g. %20) to
> fail with "invalid interpolation syntax". Disable interpolation
> since the CST config format does not use this feature.
> 

Should we add a test in tools/binman/ftest.py for that corner case so we 
don't regress?

The change makes sense to me though I don't know how/where we're 
supposed to pass a PKCS#11 URI to CST, so I'll let Simon/Marek discuss that.

Cheers,
Quentin

> Signed-off-by: Julian Haller <julian.haller@philips.com>
> ---
>   tools/binman/etype/nxp_imx8mcst.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index dd9f226b751..4fa26de51a0 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -137,7 +137,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> 
>           # Generate CST configuration file used to sign payload
>           cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
> -        config = configparser.ConfigParser()
> +        config = configparser.ConfigParser(interpolation=None)
>           # Do not make key names lowercase
>           config.optionxform = str
>           # Load configuration template and modify keys of interest
> --
> 2.43.0
> 
