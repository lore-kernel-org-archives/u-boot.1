Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3AACD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 07:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0D684715;
	Fri,  5 Jun 2026 09:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AgHhN5EL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172FA8484F; Fri,  5 Jun 2026 09:17:27 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6ED846B1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 09:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq59A1jj6Z3O9M7xRJVOAETkWw6G+4y9PBWtClTZNXhqMBetovJ6ZgMiKGu2aoDkVebgx/UYoZFFTgp/OalVDfzv5ub8LPRu7UiUkQ1eNtACioGAXNMqAdhS9kqU7vi/gztgRVkldhULNWw8LfrVaGCyxXmWj7xGQWKx46uXCZN7aBPZbCbE7B/9T/89W8jUN0Q3I998UsUUwvIIXP7fKcuNZDl/e4Kgr2B3gcmgQ4bYUdc5VbRuZMYH5aX/yGbTl4w7oXejY2GA+IbRvsyoyryo9dr8S4Zv4bdM92uysXbagc2IlpXoMSnKBvYSmmCzAOAxedapHyPRsNpJxczexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULNFLZ+Fe+BNqnnWXvw/DcI2L0ClftjyG4JHhTW0Ekc=;
 b=oezcNEjJ7MH18hFHlZCBT1CFAPW+v/LZr2LR6VMB6hpP/JUZ46usvaKFLjQ1hqDAKYGdxqIjFdg4ZV4ExhXwPwv+9BFpHB0YVsFTND9WB/pPNmINXgdjSy0egBkIagNHstnNOsD78N43+FncpXg6wW4h5UXY4uEyKli11zkxK5vI/r8SwtmZVG5rbRzu0Sua/h5TvW3ZWplq1AN82U7wrqVT5FjhNgN4RG5q2ip0a43Ji94zKOEDNeBO6GFGF/ZD5CFKRzjPe0LP8BvMp/9z6ExQv4uYhMGrG+aybMhzKWD7foDZOKlJ47CJMGPSOVDhVPojiauQDSwIhsgKXxbZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULNFLZ+Fe+BNqnnWXvw/DcI2L0ClftjyG4JHhTW0Ekc=;
 b=AgHhN5ELPRnZWQuEoZ+pMAIkwm4FpxB3H0LFZMEN+Xa7LWucd2NaO/YoWaOyVubgABMJRP8TKiBYClZB8bnivCLR2/sPjlilsKjnTub3p1PxacgA04OVjNjy9P1vtGoI4B8PFeG8rAqPILwb479DEBzR7tpnu0LJHa/+u1emlQOdCD3mKJRvsxLyBUFMKEP2KPfF9E40+la1UevZFoOwagLby7hW66Nt5Xj1D/X//ZnN+BwFNuQF1vPx9CnyLffjUiafjkhvjJNRHHRfEAOyRNQK2XyzYecJFRSqWRc2271in6YQUX4n7LIY704IAk3X7tDFn/pzkoBQJlxb9lDexA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8SPRMB0073.namprd03.prod.outlook.com (2603:10b6:408:242::19)
 by SA2PR03MB5772.namprd03.prod.outlook.com (2603:10b6:806:11d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:17:21 +0000
Received: from LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a]) by LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:17:21 +0000
Message-ID: <fa28490e-4e9d-4338-9eca-754a4cd83ba8@altera.com>
Date: Fri, 5 Jun 2026 15:17:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: soc64: Remove kernel node from binman for
 non-VAB flow
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260512041148.32021-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260512041148.32021-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To LV8SPRMB0073.namprd03.prod.outlook.com
 (2603:10b6:408:242::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0073:EE_|SA2PR03MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0c0743-12dc-441c-dc2a-08dec2d27ba3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7SkFJm0UPI0BAQswXLJpYXeBRnG2vIvTbKLP+C6/On7wBIw4FRC/gdbo2qBbQMUGfE/qqqT2ILPAf0E3zp9AySv0ydjOcibZGtzCi4/5uAOxFpOv2/ikHvDvDOP5l6alC6gRDUuNvvTkxn/em4kLaU2gVRKs1SfoM+sJlYR6GBrQqxsVQIvg9G32zKTfDV3v3t3o1QEfwItjhIN585NII0lGHj2KU0XPtf/xB7RI8JF+G3XPY8pYPUk7I9+0trEPwk8AdG1EnzdK1kfSpYe85MQTRuvwFa3oExmsqkF8gFbFwWK/xIX/ct3GV1bj1YLJopjaIRPitMOKumWa1AHC0dDnMRmgUEo9UB4zfsQUuJC9WYj85vDSvPBpf5kOoi15Hofrtys7McgUrwpbIfTHBNDfvp3JNLsVfFms7ouuAr/AChaSnuI8g94z4y9CTD8U6/K8eSlIQZCECIUtFCi5YpMyHxctkHVZYra/2UZf6u/1PeWZzpllODocB034qTSQwTZ9pxO9umCshKPPL9hOHwMWEVwkiZGbqHjkmE7xgq4rSxnltbfWPaO8zpU+knibq2xCX9UJTZGqRCF1tzaYCgn+xEj7699nhWrLuea5mSjsABT66NvyQTLZ646zf9toVc/81pNDEYY0FOvPWABeWICnk+hdZtWeJ2/kgYAW9XVwnHvGhjI/3/OheB3S7rwI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVUb0Vqd2h5MStXRmZjRG9UWndxTGkvTlYwNm96dEFCWXRzb3FtUGlpS0Zx?=
 =?utf-8?B?UlhOSksrazZldENVSkVCWmQwakl6cTRYM2RuWm1RT0tIY2RjK0dJMHd3S3py?=
 =?utf-8?B?Y2RCb01Cdm9CL0dBd0VsV1dWeDN1bkhjV1BPWTJnVWlDcjBQazU5cWFyaSsz?=
 =?utf-8?B?bWpBQVlpMkV1cW1xQjFnSGhES3FURlp5V1RzNS9OTktqdnBSb005ZjEzQmpE?=
 =?utf-8?B?NDYxbzRVdUpaRnluOWJSb01YL1dEd043cUw0bzNuNzVzYllSSnhUWWlJY0FC?=
 =?utf-8?B?U0xmVVAxbTk5NzVLUmNQSnM1RVNWRWpqLzQrSjZGYjRLcDhIZURwelkyNHVP?=
 =?utf-8?B?eUlHSngzbEp5R1Voa05YMWpodkhTUS85Yng0TjA1dW8xKzgzbndhNGdzejBS?=
 =?utf-8?B?ejYrQWRxMk5rcVJ2Q2FzRjdCSjFQYmZrR1h4aUhmNWoxd29TNlprT21yMFM2?=
 =?utf-8?B?TUN3N0Zqbk9lN2VvTTRFdDFQcFdacks0azhFb3N2WHZtTVBLclgxaEt6aFBt?=
 =?utf-8?B?eWxGaENUVkE1TXBOVUU3UHkzSStaSzNPemViYlhjYmJpUzlNdDRxUGVPdEpJ?=
 =?utf-8?B?S2Viam85RkF1ZkY3N0wvQzZiYjJMUGRHckcra2J5ZGljSURSSEExN1kvQkxC?=
 =?utf-8?B?ekZZVHNjbmxVTW1kQUZrb284R0lDS01DQjRLRWZnUDlocEFCc3FGOFFMRnF6?=
 =?utf-8?B?UFpRSFNMOTRmU1RxSC9nZWtsNkhOL0pTWmJqWGwxVlI0QkN6bEFYRC92bnNi?=
 =?utf-8?B?Q0VQcU9ZWmIwQnlwMW01VHBtOTcrUVo3YzJMU3BSaTRzQnpGUXhlSGo3dFlR?=
 =?utf-8?B?dWpvWFZSSkRJNlQ2RXNaMnZpODRRcGFjdFdSVGJSRjFmRGp0L0tPdjEvazli?=
 =?utf-8?B?elNYRDQzK2hOWldJdFhZaHU1WnR2c2tLNHU1a25NaUowYmxKT2JZZGE0Y1dX?=
 =?utf-8?B?c3lxVjRiMWJYNXNudXZzWGFYcDBKKzloRGVaWkREUVpSdE93VEs4VmZZUWw0?=
 =?utf-8?B?M2plSXl0SVhYWEthNVRsclB6VmNWR2NXZFZkdjErRUVyZWxhbFdhdktub1ZE?=
 =?utf-8?B?akF2Qno3MGZESkxRWkRGWlhhN2gyd0xDVGNEaVRZVytZdTJqTXJJcm9nQ2NK?=
 =?utf-8?B?VGJaSkxBV0NQKzBwNlNMeW9XYU01NXJFcUR1dWxpYis2L3Rxdk9lMmQ2ZFRt?=
 =?utf-8?B?RFE2OFZGaUxueU1kak1Uazc2ZE95dXRYcnBCbWtWaXkxUi9CMGFnRTk1VU02?=
 =?utf-8?B?RElITTJBS003OHhSM0RMV3BHVC9JODYxdVdsSE1mRU9jTk1VZnFQV0lGT1Fv?=
 =?utf-8?B?bGlubzROUzBHUmJ1ck9qSHAvakdGS1RLVlpDQ1pDaDlmZWlRQW9QaGFjclJq?=
 =?utf-8?B?YkhRbEVTZFNFZnRRRlV4TjhFTm1kWEdjU2FjbU5GWDA4cDE4Rm1iUHduM2E1?=
 =?utf-8?B?VFA1RmtTblFoczc0dHBTVHNONVp3ZkV1K2J3RjVLT2p0eWdnTlgwSXRPcDVN?=
 =?utf-8?B?OEZ4d1JwNEJnYnN3OEtQQmg2eTlMZFhzTktaZ0llVWttT3p4TjNGbEordExx?=
 =?utf-8?B?MTRCUmxQQlBHeTUvazNua2FJUXdzQmU5VnRFZ25mOTJVbTkxandKYWk4VzlP?=
 =?utf-8?B?d0UrMktuTlFWVlM2b3FMcDNrTE5Dckl4N2UyR3g2YTVTdXZ5dFRwN0dDKzBK?=
 =?utf-8?B?ZzBwWU5xbWM4NStNOTNZMTkxS3UxR01iRDZsdXZQNmpNZXRHajJpaFlUcE8v?=
 =?utf-8?B?V20wdUVhWUJKWGY1UlZrb0I1ejF6azljR3hiUXRUMktuR1FvT3lHcGVvaDlH?=
 =?utf-8?B?aW9vSDdIYmJVWHF5TC9FR3AzdG5aTVpnZGxHMTBjTXNscVF4bmpWdlRjeVNi?=
 =?utf-8?B?WHZmY2dOb3ZSeURpWG1hWTR6NEJVbi9zaTJEOXIrL1piMjFadVZPR0p0NnBv?=
 =?utf-8?B?czdydFJaTFpGZUxEQ013aUdLUERWZW5zcFoxc2ZCdDRMUU9WOUNLSUh5cWMw?=
 =?utf-8?B?blBvdXJQWlUxNWg1di9mc2RFaUFJU29MRmpsVDAyRzY0TExHMHIxUlhienBl?=
 =?utf-8?B?T1dXTzRWell6elBlZEIyanFia1hLUjh6K2VrdW1yN3o4QXRJMGdmeW9ZMEsr?=
 =?utf-8?B?VVpRelQ2VlN6ajhIVy9lTHBvTU1yZXJ6QzhzRThvY09PSjRaRndUbWQ3blVJ?=
 =?utf-8?B?ayt5eG5jOEVCVU9KV01SRklzWDZBM3dhUnNQaWVJUnAzTk10MVJUaHBleGZI?=
 =?utf-8?B?cFNIalBZZDdnR0VPcklRM2xQMXBLaW5DVjc4aUVoZnpMNk01SjFqVUczOWxx?=
 =?utf-8?B?dVZPS3ZiN1I0YXROb0ZZVnIrRll6ZUFmOXRvMytUNTJLMENUS1RiUksydDUv?=
 =?utf-8?Q?jre6oNRRPgWn/U6M=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c0743-12dc-441c-dc2a-08dec2d27ba3
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:17:21.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Waet8cVzeMYHzgpen1kgzSyKM9P8Dg9G7jKCTGTmyNrUHpwaN9dwp3QM2KAuEUlYouM0pHuD1FkCTXaPuskKCdZVYp+QYUzy2qbL3AaCID8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5772
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

On 12/5/2026 12:11 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Binman will attempt to package kernel.itb during U-Boot build, expecting
> Image and linux.dtb files that are not available in standard U-Boot-only
> builds. This would cause build warnings with missing blob errors.
>
> Add conditional deletion of the kernel node from binman when FIT is enabled
> and CONFIG_SOCFPGA_SECURE_VAB_AUTH is not defined.
>
> Clean up binman node setting in Agilex device tree as this will apply to
> all SoC64 devices via the common the dts.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v2:
> - Implement this for common SoC64 dts instead of only Agilex5 eMMC dts
> - Agilex dts clean up as this is now done in SoC64 dts
>
>   arch/arm/dts/socfpga_agilex-u-boot.dtsi       | 6 ------
>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 4 ----
>   arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    | 2 ++
>   3 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> index c0f932d0e11..148c71a0eea 100644
> --- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> @@ -258,12 +258,6 @@
>   	#dma-requests = <32>;
>   };
>   
> -#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> -&binman {
> -	/delete-node/ kernel;
> -};
> -#endif
> -
>   #ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
>   &sdr {
>   	compatible = "intel,sdr-ctl-agilex7m";
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index f2150b7eb7b..c7e0ee2bfd1 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -214,8 +214,4 @@
>   		};
>   	};
>   };
> -
> -&binman {
> -	/delete-node/ kernel;
> -};
>   #endif
> diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> index 88f0154463d..ddd99f87942 100644
> --- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> @@ -93,6 +93,7 @@
>   		};
>   	};
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
>   	kernel {
>   		filename = "kernel.itb";
>   		fit {
> @@ -150,6 +151,7 @@
>   			};
>   		};
>   	};
> +#endif
>   };
>   
>   #if defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

