Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE03FA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B3A8407E;
	Wed, 15 Apr 2026 06:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rP2eAmTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D9F839D5; Wed, 15 Apr 2026 05:20:31 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B071780086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgFIPNmulkoifTVMPtO7qgNI66Bocws+jfeDnk0/moXPLBH2ma5lFrRyj2JjDPBJTHOSh6atSqf4nMwwR/zDIPeIyz8RMhT99DcPXdV9ozqIabjuIXMfjuDxavb5HFMrOp70XANnikEdzSwxZTPcSrOuDfcKeHcU7SHQADLXQCxgbhZT3qmRF9xAE5fsnh8mAnAMlBrBWZqMU47ppviH+sfMZ209cojzM1pbqPSKWZk6mB0i8rTO3zP98NZXLX3QNvChpQD8Q6qdmalrwbCuZ6LMcKpaR/MUej0dFRydu6gusx5iiKuwHlZSkz4dlU+xkF+6gXR5BoJFxjja/NGQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC6drvXDI26yFR9MW8cy+vDigRZo1KkqV7kRvc/dNWA=;
 b=uxcWiCbBp4wKQQDXN7hR4FpFtiEyEG8XgqQBM6+DN5SLbwacPNPRE4EHzhui785yoz9oJI3AygtsHgJ0csqHfEOwpB9b22beKpbOGqzy+2ayk7luLoCOZcMhas5an3xzYEn3ruHbGKfCuAgiw2hzYL00XbIL3aet8Ol7U4P0PT8Jmaq99OpggXtAqHZIL+ngbmc0gdW9rYZ3Xk1U8c4QgA2Fxx1Q6JfqMq+4EiUbUuxK7/RP7AA6LbK7qSAkcH6dACHdfIpfLD+KcY8XkDwgXQvkaioZnuhQIgWiA7B3ZdZE32Iau2C8YLhHpNBeGJfnCwRZEf0S/2vOkc0NqOhCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC6drvXDI26yFR9MW8cy+vDigRZo1KkqV7kRvc/dNWA=;
 b=rP2eAmTTPBdTt9Y3u3JhhIDyiCM1RmhqYUng14gM4h4QrbfdJLdOFCeHWzp6rAjOsby6szEzltQBpQa+QVA3AVdjBhBPCnWRug8YlBUz5kkjmuM1oMZo1p6upXZyzrv+oq4F/uY55UYwNugf8CA7WuuiOomp7LrWf9mdFH4PLyoOY4eKMejtkdqsCFzriEqElVQXYeutNv092l+uxsEdr3SaBOHQKwg0HC/sfhIbbojV5PbRWgFAadLX++W62z7Ml/KYfk6tU4rsUyK++XGCu7nO3twfYyJ6M8ckIPxVlXOrGtv2D9djsOK06+EGrbRULw4NME7jW3dMrJvqp+/M6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BY5PR03MB4936.namprd03.prod.outlook.com (2603:10b6:a03:1f1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Wed, 15 Apr
 2026 03:20:22 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:20:22 +0000
Message-ID: <eda74cf0-523b-4c98-b8f4-00d6e70ef504@altera.com>
Date: Wed, 15 Apr 2026 11:20:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: cadence_xspi: enable automatic platform data
 allocation
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260209081007.5166-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <20260209081007.5166-1-chen.huei.lok@altera.com>
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BY5PR03MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab1583b-4fcd-4ced-c79d-08de9a9ded79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|8096899003|55112099003;
X-Microsoft-Antispam-Message-Info: fNn9IM2Mbc67CVBFjHbKrMLuTFCBxSDw3/9V+7QziVVeNxZiDQ8ui+HfxaeQWHNcH7ZJiR1olvl1fNz1UM/yOX9oJyS4n5+jMK5C6slWP/fENMNsKih5E9pZscv+q/BMcL31E6JhY61sLZNbagsd1gmkAvnpc0gsopb6iOKXNt+905Fu2I2weCtgXAF0xW5BUdfw9iGpi7pRGjJFBRcVA5sVm6fQZvTDJbT0tEJQrq9EPcsZCULMRaTI/FRQ5w+fpyqZMKc4RvKf3F+vfHoI9L7eVXBivmIGOGd9FgNyOTxpZxMp9TvQxCUrXD3tfmwLiSTLNDOqVfOPkFDfvTwgspNIcD7yHtNifbEXNWfxxxaPpjHs7UGuAo8MIdf4dAHJ2qBII8ijNagvwXn8Z+DJg8EB4bx7pvexRHE5I8V5j/xBQRk6N7z01rv59WVp50at0+w3AZYsCNGqI6YJKAtnc0Rf9Sgj20inJAH02rJphgd4WhP+4/aDzH9WnPIPX/rTsGA7rRDjgvYVZq2ofASd6aUKPSWe/BcqVaDMJxBF9iyq/fOO60gndLVNTDccn/IkiEBPey6hNLNxsm+xwpYN82cA9GMyRLzPiCAaqJng8tGviogRg+Tt5kTHAWoiIuRVIj0QWTk6K9B47HDK4eTRLkmeYNtMf5rDJIbHWU6k8D9jef6NxZBEigx1ZqXIpSgAIBnBWI+Lzfx7ai9V+JvGfBsEqt5GGfepiNe050m1lUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(8096899003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1ZEZzdEYnlGZC9wLzVnanphNk1WV3l6eFBDOXE5bnVqbmtveE1wclhuOG1v?=
 =?utf-8?B?K1NDN0d0YndJY1BzODgvNmFYZU9XNE40bVczdThNcjFWSi9jbUVuUkpyRVQ0?=
 =?utf-8?B?bmFuOTk5b1EzKzNtWjRyajF6S0VPN3o4RFlLYitkR1JsRTRoU1BFNDlqVCtr?=
 =?utf-8?B?T3M2SUJsRURGb2RFUHV6SDJ2VnNuN1QyditoZXpyejZ3clZaYW9UQ3Bxcnl3?=
 =?utf-8?B?MEZwNVAxWGEyVWpCVnhPd0I0eng1T01ZU3RlT1Nhb2FMeG9hTzNRNVFaeit6?=
 =?utf-8?B?Zk8yOUZRdHdSMDZRYzVvRWNEcXQrOXN3VGxDeGl2SHVXd0VCK1VUSXhnNERr?=
 =?utf-8?B?c3F4ZUEwZ0hXQTJ6TTdYL0lQWkg0cUlOZ3VkZUw5Zy9BaEtpR1BKSy95K2M0?=
 =?utf-8?B?R1kzNWdUaTVNWFdWR3VFTFJyUk0rcUxVMS9kTEFaejl3QlRBMXI1K2k0ODVX?=
 =?utf-8?B?MG0zVjVXeWVwSU9GNjkvTGREV05wb2VYei9IQUVyKzd5cFJiYTRyVTlBYW9r?=
 =?utf-8?B?S3B5RDMvbVlKdzA5cFJaY0N6THcySG5icXR4eCsrelY3TEtlcFVwNm5Na3Rn?=
 =?utf-8?B?cmtBWHN4cnRocTR4b2g2VFltdzFvRHZuMFl6dlVkdWhYODhGMmRTT2JXekFz?=
 =?utf-8?B?MWpGMGZ1THIyKzN1NEhXbkd0UXpIRDJDWVZYZ25ZQmZobkc3Z3Z2SGVXSDhv?=
 =?utf-8?B?UkZLYkhQSGFPOVgxa25XTzBQcHhoRG5GMmJYQXkvQ1hpdzNadzltbHdKdnYz?=
 =?utf-8?B?c2g3T25SYjNLbXkxUWFGSG9FOGd6UFdjRmt6ZlBWRHZmaVlKVWZyQ05QVGVh?=
 =?utf-8?B?amUvR1RrSjBtcml0b1BQOG9wdEJHYkk4dm5FeFBJVEtZcmtkVVBpekhPTFVP?=
 =?utf-8?B?RENtRGFxcndvSlMvclVJQUUxTSt5Mm1XMmNZYis5bllXbHFCY04xaFVhNDkv?=
 =?utf-8?B?ZE1XK2M5TFZmSytZbEVPay9odE5EM1pkZEtiNFFKYUFSeURhRCtJVHR0d29l?=
 =?utf-8?B?bUZtUzN2ZGk0dUhrRlVSU1p6dm1QMjJmcVcwRTY4bDBYeVovQUx6a3FoWEZ1?=
 =?utf-8?B?KzJQK3lMUlhZanhsOU11dTlxZ3RoYUloL0tUTUxCNGU1bUlTSndYUjNTb2Rw?=
 =?utf-8?B?WWNFTzV0eVEwTlByNEpOZmpBUzhpcVNVRWxTMVdzWnhWa00zK20xOEd6ajJz?=
 =?utf-8?B?dzJRcEF0aWlFWUNaOUVQRXZwVzZZMG1wMk1iS0JWWS85RWdNSUVGaDhtR1Zh?=
 =?utf-8?B?SDVZYkRtRitsbUo3STRYUDJUSTRtR1RBU2l3Vm8zZ1BGZEt2OUVUSlpkd3VT?=
 =?utf-8?B?MDdtL004eTFsZTdVV3lDK01zMnNlbXBBZTVJS3U0d1FrTlgvd0Q0YzdkV1Vv?=
 =?utf-8?B?QWlNSEFuckVxeGFmRzluTjR1Q3I1dURPbFExUzNYWDVtdFBydk4rdjdEaGMv?=
 =?utf-8?B?MmtMQ2JkaWhvcFNZYXBrTGlCMkJOUms2N3cxOFN0aUVnQnEzNHhFVzEzOFdp?=
 =?utf-8?B?RmE5ZDBpUDhlOHNBaGFFL09GQTVBS2cvL3pzSTRJYWtGdXFENXJxVmZaNG9V?=
 =?utf-8?B?S01XL05HSm5OekpyYUxLbHo4V3pra3BaRm50L1Njb01XSDMwUUdSMlM2eDFF?=
 =?utf-8?B?bEFZVTFvbkdLZ1B4RXpwL2s2RWFML3JPcUJ0U1Y0ZEZMNytqUEFxL2VBM3Qw?=
 =?utf-8?B?MUxET0RpbzRxc2ZJL3hoRm5mUzlCVjJMVUZ0SVBaN1dIZGgzZmR4MjlSVTlu?=
 =?utf-8?B?SmJ6N1cya0lvdW5IdUp4cjdCTUhYVGo1SXE0MTdqMWIxbjNvMXNpM0h1THhV?=
 =?utf-8?B?aXVUaWUycE9ldVM4Tis1MXFpeGxJRk5yMHRtUGtFcEtlVjFTU1pFMFRGMDhJ?=
 =?utf-8?B?cHZLQXNVS05PR2xtbThSUnBHUjJhUDliV1ZIdXNENEJ4SExDSzVCOHlmQ0xP?=
 =?utf-8?B?ZnRlUzh4V3VSWlltTjM3ZGNzUXR4aVl6VE1oQkhia09QOFZ4K3Zza29weWs3?=
 =?utf-8?B?QXhXWVd6Ui8rcTErMklxcll4V3AvVjdpSU4xQjlIUG9SRnkvTWRBUmhvT3V2?=
 =?utf-8?B?U2U4YWdKT3R5bDNrSFBXYzc5WW8yMjB1WExaaEo2OWNzQ0FkWTB4RjhaMkZj?=
 =?utf-8?B?NGlNeG1Nd2Z6dHY4Z1dMRENKRUdabHdhZjFMSXVYMzd2dVRMVzgwL0hXa1VD?=
 =?utf-8?B?M3RoVWdvRGZObWswSHBLT0FSU01rTmdJMi9zZEcreURFT2ZreVNGM1dJVTVv?=
 =?utf-8?B?Y1VWU2tOcDVwZ1J0SlRYMTdtSW9Sa2hsZXd0blY2MVpUTUdGYkJiU2s0RlNh?=
 =?utf-8?B?YkR6K1o0UW5UQk1xSGYrWmdpZnJCZWhtenFSS01aamlySi84ZEsveWNRT0Zu?=
 =?utf-8?Q?ULzQc7Whp6Mr/RZg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1583b-4fcd-4ced-c79d-08de9a9ded79
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:20:21.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIP2IU8O0boDo6shuSe6wJAxLydYJWjn1bzH+UkjqEEf3oD/4KmhDxy2ivgGxeG6OWOfUF10x8DhBcj5vKGh3N9jLCZyUZaTcIYi5ZWTmLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4936
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:26 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Jagan, Tom,

I wanted to follow up to see if there are any comments.
If there are no concerns, would it be possible to consider this for 
inclusion?
Thanks for your time.

Best Regards,
Lok

On 9/2/2026 4:10 pm, Chen Huei Lok wrote:
> Enable automatic allocation of platform data for the Cadence XSPI
> controller by setting .plat_auto.
>
> Without this, dev_get_plat() may return invalid or uninitialized
> platform data when multiple XSPI controllers are present, leading
> to incorrect IOBASE/SDMABASE/AUXBASE values and causing SPI flash
> probe failures.
>
> Setting .plat_auto ensures each controller instance receives a
> properly sized cdns_xspi_plat structure, allowing SF probe to work
> correctly.
>
> Tested on an Altera Simics platform with multiple XSPI controllers.
>
> Signed-off-by: Chen Huei Lok<chen.huei.lok@altera.com>
> ---
>   drivers/spi/cadence_xspi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/cadence_xspi.c b/drivers/spi/cadence_xspi.c
> index 717f226b709..8a894025d02 100644
> --- a/drivers/spi/cadence_xspi.c
> +++ b/drivers/spi/cadence_xspi.c
> @@ -441,6 +441,7 @@ static const struct udevice_id cdns_xspi_of_match[] = {
>   U_BOOT_DRIVER(cadence_xspi) = {
>   	.name = CDNS_XSPI_NAME,
>   	.id = UCLASS_SPI,
> +	.plat_auto = sizeof(struct cdns_xspi_plat),
>   	.of_match = cdns_xspi_of_match,
>   	.ops = &cdns_xspi_ops,
>   	.probe = cdns_xspi_probe,
