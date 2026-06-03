Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADE9CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A689484855;
	Wed,  3 Jun 2026 09:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Vl2IIyz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A818486B; Wed,  3 Jun 2026 09:17:26 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFF7F8341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc7IAfkKooH+tUYt4X+JptCHvrCmH7asytfARqwmKqIbWazBbyAeQHqIClcQEJLJXp1LMvCysNIX+oHgjZrnMcszMoQjwrBH5jz/8P8VRqRL7JOgUfOeK+WnkmBlbgOUXRtcO0B9554B2ls/OPMU1QtTlteQhGkdqlp7AtjMxQbzGn0WDmxRD992KTi1fBk6RbeGnlQLcJhMvF9gCWtAi1f8cHjKcN051BIT0vumLFEYXSgZ4x7f9CYkYIAKuGElnq565WSTquX9B678yol/39vjxlubfWQvybelKyz4xFNWZJ+kM/dAxheI0yyCoqlgk//FZPb9WhM8yJr3AWe60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epQay62HREV7Q9d3pPa9s40rKBBur7yka9DiZQZcYNs=;
 b=m+cEzPRoSMSGW1B1m14ZWPkyJAGhVRGl2IxBAoiUpRiRVdffBHveJ4/zQspD1zuqj9Sew9pADbu+EtM7Q6tHY94+Z2b/kfQ/k1S88rSOs4sxYMQY3Blu9eilEU3BvYw6bsVSko2WKBqTIEKn285PZ9Qf+v4b6CVwy6J0zakEqS24YtRQCbLczK3nOfCEd+QHWNIqwizb4worRHI5mGYQWrurGdnSYel2hHK89buqUGGQQwU2rp/H6U4RNrSl98G3UcJC3d0yoLbJPWgizfrU07ufXTMqH7p3sL4Y8d/+ZoesIjd3yYWQqyj3uXr8rVSpwhZY3DAipPjyM6sSIotOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epQay62HREV7Q9d3pPa9s40rKBBur7yka9DiZQZcYNs=;
 b=Vl2IIyz7HQxaonJ0FpDXOslAobBWVTWW0enF9weVJUQn9ABNTrk7AlQp1SsM1wGe+GefT6vQhd49BgZ/cKLoL6U7qq5iLcB0t5rGen6RgVftolCDUsiJUpPxRETlZGWsCC8HDSycvq1J0oQlE9oDQTI4lAIt2pNBBZvlbP9nwF1JTA0ReaAU1uK7D5qePGjcU7ipJajlAIX6VZlim/P+rpq8k9qd7Pn7Nr8XZTPvp7d0q9fVrfYXcyjqCr1pJYH0XpNIUea9uyMvFUFO0umhJafmmJgLoVQBci8UwWNY91LUFez3GjCtLKFB8o1fyFOmVU6KKNn+A99cVGUI8umULA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:17:18 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:17:18 +0000
Message-ID: <6d1cbe3c-a1cd-404a-b0fe-60567af380e0@altera.com>
Date: Wed, 3 Jun 2026 15:17:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-5-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260518011245.19083-5-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::18) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de0b997-4590-48d7-1ca9-08dec14024f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|55112099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8wUnDYQ3DWY9uUVrLSFB+VyW6WiOx4q9Gx+2xG/KxHAeBoQoSFtAZmLC3B6RCALEucLNZRO7tQ+eV+iaYqdLYHgGuIkjryGNrMk/BicOCwKhmd0lJuduFQqVXlFkPdouCU22H+QGOXJoHFHLrvgm5cxcFyGxsIY/PO4TlUJGUyslP9oi7xJnmJIr3Ot6ldGg6xdCKLfME95OuHrSCpboXR3BRa9Q0kiSKVieqWPqZ3CI9Kz2uR3NDm6Mh/gOzoSpLJoWpOyiDRSnCmxi79j2vzbOuz7QcuL2/AnO3P5rZmOP5Wtcy1FdHaavQbCbdIPR/cjad3e3DW/nwl5FcZWkwgUHxHF0aAwfPzXATlwen536m+DV99/apH3g4AqiiHEFNnFbo2pPIkOZWYFuyn8c7qQMklhdQI5Syn3CVCQHbjtOGLTPcslIWXDaopaj/W69iAvJrhf7OLpGkq/1qUq02STsoTuY1he77iYpD58YMTYLAFulm6dATFa9pjLhlCGS/+Gohf2KODUJwIJpteNe7J/pgIJOhCBE9+MFdD48SensymimNC9QA8fSOMIsx5Mm1vg1rFZITf8rmmmg3BidU/PcHnZfwHEKBMxSPicc0Q9mwfs9rR2cf767LmNKC0EiYXoX8pgpr8RVlse5rivTlIMUG03BnHWtFkGGNJM0Po2vSmcbHRFjSqqetHqXgsmO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(55112099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJpUDNJYU4xKzhzQm5xRDhWaTd2QkZsanJNazIvaytTeEh4dnR6elhwWUpy?=
 =?utf-8?B?TkI1WVdtY2pFcmdRelpOYWJBR0FjcHpkOEdrTlFhRk1vUUYvTUFQK2J6emFu?=
 =?utf-8?B?c2tyUlNuNDAyc1dHbVIzamptQ1B4MHp5M3p6eDlxb3pKUzN1TGRsVjNVTGx4?=
 =?utf-8?B?SlhuYkdUNUNiZ0lYZURyR2pIR043bXF2WnJVTkpQL0oyY0tJQmlBWCt0V3FJ?=
 =?utf-8?B?R3ZISDdZTk42dDBDTkM0ZVhJQ1doQnAvd1JnMWpuZW1YcHJTQlc5T09SSEhJ?=
 =?utf-8?B?a1Z5NHJoNG05Znp1U0tMZkpZMmVOWEJHbnJCVGxIbmM5b25xNFhGS00vVXcx?=
 =?utf-8?B?Yyt3UG9tdXVkMHI3TGdwdy9IUzk5bjAxdkZQVFJBaGR2UFNTSzJIekJHNlRU?=
 =?utf-8?B?bnVLY081Z08vN0k4dmVMS012R2g2UkJPOW9XOFNWODRlK283YUR3V24xR0pv?=
 =?utf-8?B?Z05Kd21pQ2tXaDAzUkgvMCtSLzdUcEFKOGpHVGE0dE1BTlJyTXdoUTFyS3Ux?=
 =?utf-8?B?aFh6TVRsMzVMRVZKTW5oQzZPZGNQeTBHQmhFdG9BSmg4QnVpV3BHYUJtM1pz?=
 =?utf-8?B?amd1bWgzU01ZS2ZTOGVhNmhFM1Fhbjlwcjl2elhsVXBwOTFTa3FSaW02TDFJ?=
 =?utf-8?B?SmMxeDU5U3lIRVowUG1xYklNaEFHQURxd3RtNFdkV09CT21ORm9wQkpRZ28w?=
 =?utf-8?B?eHZqUVFxbFZtUnZGcTBEWE1Ddmd1TlhQSGFLVWk4bDNQdTlwYkpmak1nYjVi?=
 =?utf-8?B?Q2VPRUNDdGJ2OXE1dWNQMFVJWUwwRm1GR1lNVjNTdVFNSjdrYzQ2UU4xT0tR?=
 =?utf-8?B?eitQN3ZoYVQvQWJiTklEYmg4bWE5bUh3d0F6c2cralphbFpqVXg0YUZxdnlk?=
 =?utf-8?B?aFE2NmV0Z1Vtd0VLNFI4QlAxRmVYY01GK1dqaGpwdVdtL2J4MkpSNVQ4YUcx?=
 =?utf-8?B?WXQ0b1pCMDk5V29SK1IyN2NsS3JHeVdkbzIyY2k5MWFaeDY5OEZHN0VEemtM?=
 =?utf-8?B?RTdnbHpmUlhnSkN1OTZXRTZ5eU1zRlBIMVVBenRMR1JkaGdwN2RQS3ZsWVNj?=
 =?utf-8?B?NVNYVCtpYkxGZUlrQ1I1THBaaHlsSkVublNUUStmTjlJR0RwRUQwVTMvNldj?=
 =?utf-8?B?VHJYb1FPV3doMGtXdlcxV3FkNzkwZWJRSU01ejcxMFlaRis3bDRWd3gwb0pJ?=
 =?utf-8?B?TXNTaFh3STBSeExQVmZWMm1jRU9ZQW1mb0lieWNNWnFqVFdXNmc3cUF1ajk1?=
 =?utf-8?B?RnEzaUZvM04vQ0lZUHN1WXpBNGw3TmlqTWQ1aUx4UjFudExENlNsT3VZeFJG?=
 =?utf-8?B?Yi9JY3B4blZMdGludlhVR1BuVUYzWTdiOVRSVHdLSUZpR1hEdnJXbTV3NlRk?=
 =?utf-8?B?UURCQ2x3bkFVbzFjMzZGZWpFVjhENTZxYlprUk95bzN4NzhRZUZ1YnIzQXRT?=
 =?utf-8?B?KzdSdnlHY1o5QzJ4SEdNOXp4L3dGenBRaWswOHd4cDlBYzFoS0RlMjVmb29p?=
 =?utf-8?B?cXhKRkNKenlabEJJbXJ3YlV2cWF0dHNsWVVPM2pRNklWaHlVSkM3TCt4b29P?=
 =?utf-8?B?bEZTS0pMYkZMWFVveUVmZUlNMFJ6YjIvbWd2SGtYUkZZdEZjYkNjOFBxbmIw?=
 =?utf-8?B?c0dXOTdPNlRzZEVCQVNiVHJkUHJGSVhnQjNEU0VZUjAwSER1RU1hQU84eGph?=
 =?utf-8?B?dENGVkFxN1VxK3pJYTd4aEFhR1k2N1kyTDJDNGJNMU1mRnB5WE9JMCtqd0lB?=
 =?utf-8?B?akxvZXFyb2t6Y3ZMZW12N2FwbW5jVzcvbDRsWFJ0ck5qcTAzZ2ZmR3lJVW9x?=
 =?utf-8?B?eW1iRlFkOEswaW5YQUlTR3dqcUVlREI4cFhCcXdKZ3FycFJWa1FoSkdLdWZK?=
 =?utf-8?B?TWkyT1BOQ3VSdUpkaEYwbTFWUy81SHB4ZERaVnV2cTduSDVkZTNZdC8rMytP?=
 =?utf-8?B?QWFpK0h6VlB1OUw0SlpVdVRmVkM3a29oenZzN0MwSHI0QVBpRGoyUXBKdVN6?=
 =?utf-8?B?NW9ZU0hiWmJVRXFRUjBHNDFBd0lqV2Ewa0xoL3NzNE1FUGJ6RkxUbjBCaDhI?=
 =?utf-8?B?ZGVmM3FZWDBoTmJvdmpWcnQwVWJ6QStDNzB3ays0bUUwbjd1SDhQMmRHYmh5?=
 =?utf-8?B?eENYWXJDWFR0L25sbFNyVmI2T3poYTlYaVVjYVlyZ2ZDc1E3L2VFTUVYK21i?=
 =?utf-8?B?VmFBb0V5WjRGNlNmcHlNNTVBdEdiOXQ5RFdEVEJMVzgrOVJMOGdsTy9lZ0hj?=
 =?utf-8?B?bkZtTzJmUitPaEwxUW5ERTNjMVRqeGx5ZVJHSXJKYStjZG42eE9XYjJNb0NZ?=
 =?utf-8?B?c3QxcWdJWVZtcEYyWHp1RnlGaVFWZCtiZXIwL0o4cWhweVZSRk5aT3JnV0lU?=
 =?utf-8?Q?314EvpHJueTF+8sc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0b997-4590-48d7-1ca9-08dec14024f2
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:17:17.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I44MjP1epAe/7B2k5l43y2qbLMrHjflffgwzlL1zMiEZDPiAtC2xnLN7EsKZxcGnj5u7EHDWmOmLU4f24re0KWkYoIpBSi9ZuQwsDn9zhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093
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

Hi Alif,


On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable backup for data section to support warm reset in Stratix10 SPL as
> no SPL image would be reloaded in warm reset.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v1)
>
>   arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
>   configs/socfpga_stratix10_defconfig |  2 +-
>   2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index 8ab80740c6e..ce1d5d4c8ff 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -21,12 +21,29 @@
>   #include <watchdog.h>
>   #include <dm/uclass.h>
>   
> +u32 reset_flag(void)


spl_save_restore_data() calls reset_flag(cold_reboot_flag). S10 defines 
reset_flag(void), which is not a proper override of the weak 
reset_flag(u32 flag) and may break under strict prototypes. Logic 
matches Agilex5 (0 = warm → restore, 1 = cold → save); only the 
signature needs fixing.


Best regards,

Tien Fong

