Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D7CD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43E988238;
	Thu, 11 Apr 2024 10:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="R4djuYmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8FD58824E; Thu, 11 Apr 2024 10:42:50 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A2C86FCE
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQfeQmmYoVXfjw4FjR9NmBAx8l4yk1onTIUb5Q4b3CT2XOdLUMlrAOgBMsuxT8K9gDuoXAIbcZq6RdxpIVwbmR3anuXTiiknC/pGsmd0v97l7OQcZZxSRl5qb9F6Je16JNp3ZMCdhRnobfSrYDT/HTKsI/ON5BsFuCGH31hf/wuAKxsHbyJ4zNoKSBrR3h4Mgtafuja8Fttb+5UUGQ3f+e/Thf1AaV+0RRLcxUPA1QqpdwXkZMaMBkLUc4NicvkUnwfvDT7Y16k6xpIjzpjDlQ+8b8FUCOh4DgCPYdP0zyHJPnMAANqkozwxjI+6KrKFpwkLP/qtO6ShUXOUYybHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqFkzOXu5aJ9EYbLr0PdD6E5N1xUVekHOBQ3+hZ7PsY=;
 b=ZAp6tUATNRIiDo5ofAEb6aIS07lZ5N2c+ZN9PSFv82JHwo+kMFhdYkhLOTgZaTYCQP0ESmuj6ecP1uvkaEUlYLL2RGtpntRgNKbaGYqrvQVFxji8SNZrqYOqWDytC6dHR3XTANDsZbudUrbUsKm2vvb0QP4SstUzUPBxCk1wMIHYTvCfI5BIzUJOX6kMRDwiRnrhIyW3sq2OdEoZ+/Cnfd1UNUIs6TdTcSk72dt09oZ767YNn4B9sozdPpFS7DF6/XLR6hSQJmbHeMMwaGypAmJSE/Gc1+Z+VLLupGYOMkFLuydDuIjsDDOigHXYPnqfnVROW0RdI0meLKbOVyXAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqFkzOXu5aJ9EYbLr0PdD6E5N1xUVekHOBQ3+hZ7PsY=;
 b=R4djuYmV5OlZy9GGxejCpEgqCqaTUZ1qwpJLTTHF51uYHO9oyqL663d79tnvTFxeUcAdC4d50ola0PzW7mpZQCXvkMwioVOrOnekGdYzCiShItYE6AIF4R+1gFAFz9xxgQiJvGxOCNXBwj4qqgM3uZ2KE7OLYm0koOKXdURjLHEOMQsLYqrScwvYRbIq1aVtcEcyXW8qT4MtzYOvCQUrvqrk+NEsYO7c8q9QsBqKehVx8AxBsIvLYGhi/2e/LzXMPG0A9Weuf35zW3UT/nLCPYOzZzqZwtI3RpP0ClO3rqgPwds0nSkJPtUMO5PBKWMRqmYjQcB1bZfYiJLcJSmlmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 08:42:46 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 08:42:46 +0000
Message-ID: <184fe91a-a08f-47ae-8e46-fb540cbb5022@theobroma-systems.com>
Date: Thu, 11 Apr 2024 10:42:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: bootm: add ELF file support
To: Maxim Moskalets <maximmosk4@gmail.com>, marek.vasut+renesas@mailbox.org,
 mkorpershoek@baylibre.com, ralph.siemsen@linaro.org, sean.anderson@seco.com,
 sjg@chromium.org, souajih@baylibre.com, takahiro.akashi@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: Maxim.Moskalets@kaspersky.com
References: <20240411083202.20730-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240411083202.20730-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AM9PR04MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba2daf1-0cdf-43a7-3670-08dc5a035c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /E4rNIFmvAONAlHZfvQxgQA/USg8tlaTt8OV5jP8sX84WO9r8O5wFsRXkPZWu/eNzjtWti/iZzVbefNu1DqMBulH1aFGYPryIiBjNMsZvaLRopZ0gKfAV7bu8b78K2PZjw1vAiCNCQ+FM8Elgy5iMVVnYudphYSEW2fsJN93zrPXUnVjmfuNMYSP2HKuhVhFz7pSUBSJlvjb84o0gQtBXBzFeyvS5een/uFl3L4H6rL3H4DnW8IkKBGza01FuxAF5476StaEm+QeGv+5QidI60gN7cVYi1w3pl54Oo3TrP19TaomeWUafG/n8uMAaALCAHZdxTbil254QoeXsvBGX7KlPeu9P+LXTdPpFiRrg3SXCyrhKJ1sL9Bhsge+gXjLCF4M3PiE8zUPepj+lpVFcZ0hZ90inVOHndX3hI46+mPXYN+EtjvrGCsa2iGdUXjR2PI5GUdap6ZI1ExnvuYUwQC20LZx6prnGNr76Ier5nddgwvWmxbaN4fTFHtKjentgpwtWVRdUsRYdAe+BM7X4B4ntGOuEe6UWowKkehdIBLiwgYka/n3rtEiA295mpdtjJ8M0xpIqYULtcgbHNWJvanONvQ0hUoQTkgPsWbSh6IuvCBQ+OZXf6x3SJq8NyxXNGQ6JiNnaSlIwewY8x5JyQ86Dvz5c3w7hRD/aP2GCbEZVjNxXNnRayrwNcqgUaKY0FsDbAIvNOL1WhTNK/b3Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRrbTJIYVY0QWd4dVd4NHhVUWxGdXQ2Y2grNUtOTFZaNEVHd01Ld0hoeDhO?=
 =?utf-8?B?VGFZRk43bnc4YkZpZFFCTzBEYkQ4bmsrOTBROEtnNjZNQ243YW1SajZObFRy?=
 =?utf-8?B?eUtDODNTQlYwRG1LcVl5allTNEVRRityT3lUZGVlbW1MZWZHbEJ0LzlaRVlx?=
 =?utf-8?B?elAvalE0bTdEcHFNZGtoNURWVHVWdUgyc1NaMTMzWHdhcVdGVjRZWjVjMUk2?=
 =?utf-8?B?QURvd3FZTm1lOXZwRmtDTnh1SmJRU1NUdCtzS0UrZmNiMjFkZkxHMk8rT1Np?=
 =?utf-8?B?TVdOdGMvb2RJYVNjNWV4RnRmd3U2WE1kQUpGeTQ0VGxpRG5vaHdOQWEzVks3?=
 =?utf-8?B?Z1AreVZMQnJMMXptVWN1YWE1c2NNWHpjeVdxNStGMmhPQ2dFaDJmZmlub0h2?=
 =?utf-8?B?azkxYzVGcHBFVzBlcXE3OXpLR1FXTExhWno1Zis0eU1vdngyNy9XeWJWTGlz?=
 =?utf-8?B?aHRXTXZhR0JxR1hBVkFXR3dXbEZEaXNmS2JrbTdBMFhZT1oxK21aRWQ5Y05T?=
 =?utf-8?B?MWpyNDBiK1oxK2lyQVNid3ZCcTE0bUdXUGxsbXlzeGgrc0lFY2IzcE9mdW5k?=
 =?utf-8?B?cktVK3laZjkzdWtLL21sZ0RuTU1FU2VMNFVYK25Qa1BGbnpFTGMzcFczbVhJ?=
 =?utf-8?B?ZlFOdjRHTUFzbTVGT2syamlYaEdQcnB1K1kxWng4aFhiL1U5TGt4ZzJkOXR4?=
 =?utf-8?B?aUVFUnFETmExR3VZazlnbHNNOEJIWTdqaXlhVkFkOUFXU2VuVlZwaE1BOGdT?=
 =?utf-8?B?K0xzUUxnWDFzczlrRGdjMUx0OEpwR1Znc0RibC9GV2xJYWVMZURRVnF4THZ4?=
 =?utf-8?B?OWoxdmRJdDFhNDZBNE9ZRHY1eDZaZjVuMDVRejR5eU1odjRGMXlYaVE5SVlz?=
 =?utf-8?B?TXlSWVpIR2dObHZpcGpTc3l0bGN1b1dRQW5sUGluQkx3RUFXVDFmQWM0bVpq?=
 =?utf-8?B?RjdzY25YYStrdXJ4cnI2bjM2QlFjSWZ3WDJCRWZKVElNWk10ZlpFRzdWMERN?=
 =?utf-8?B?SXo5a3ZWZG9lc1lWZGlqY0FXL2tUVGgwWm43M2ZiVWo4L0lDc3Z6L3J2THR6?=
 =?utf-8?B?L0RnS0R5TDg3dDI1YytvVkNjUmFTZTF3L1ZtQllBQ1pQS3ZqaTNtQXZVRUR5?=
 =?utf-8?B?OFhIekswRGJmVUs1REJZWUVjSmc0OGFoSlF1UnZJQjZjY09FNE5HMUtuSkJ1?=
 =?utf-8?B?dUFZVzFVY1EreDNmRlpjbXZlT1BVbjhURmdSMDlwTE9GNWo4WmpzRmgyTnpO?=
 =?utf-8?B?dExzTXhmLytmaDZIYTRXZlhwQWpDNU9KZUlXZ1VWdUlhbUY2SCt5c3JQK3hS?=
 =?utf-8?B?ZzU5Y2JRSDc5RDh5cnlSdkZMRmY1cmtycDVuOVU3UFBSckpxV25EdlAwSE43?=
 =?utf-8?B?clkzUC9raE1YZno3ZVJ6L2JFdDNpMkJkUU9RaDhVcnVUSWQ3QnYrdk9wU2ZB?=
 =?utf-8?B?LzBmNUtpSHMrQ2FBTHFyc1pEem16T09MQW43SjJBenIxbnY4anRrVld1S0M1?=
 =?utf-8?B?N1UvNEx2WndOT21tNnlLbTE1UFBPTk05WHRvbVUrSWpmM1RPYk9DWExOclJi?=
 =?utf-8?B?aWt2K1VwOUMvTGhJNEFrZzFJL0pXWGVsZVV4WmVrQnJwOXRrL29mMGhQQzA0?=
 =?utf-8?B?K3diazJ5RzFtNUpPUFI0Um1xcVdpRWx0c1pWYnVhb1JKVThKQjFCbVJBeGl5?=
 =?utf-8?B?WHlyUTQvS2xoVURvNmRBWW52aU1FRG1wWGgwV0hQVTJBSzRXMTRkUVNXU1Nx?=
 =?utf-8?B?aEZSZUwyN0RJY3QvdFFXYVFBL2Nod1pnN2FjT2MyR3VIVTJhTGhEQkk4QXpi?=
 =?utf-8?B?U0xQbXlkdHRMOEg5amM4MUJaQ1VxOHNBSm9FZXJmVTZSWFovWlZXcGJDb3lz?=
 =?utf-8?B?RVlncEQ2Q2pkTGtha0thNzNxQ0N0ZStibVlnTFF5Sks5UmlieitFTzdnTllK?=
 =?utf-8?B?TUw3MEhyTXFrRWVsMWxnajQxOHYxaTMyMHNHUHpMZmxjVHIvNFJPUmh0QVQ5?=
 =?utf-8?B?YmxZdFVYQk5haEp0bWpIMWg4RUhZQ01md09ZcWk5blA2dnA2S0tETzd6Vlkx?=
 =?utf-8?B?ZFU4eWhpWTE4bmdyU29hUEdWMzcvMXN6ekMxR1RnS0VzVVd3ZllwYmZYeWx2?=
 =?utf-8?B?VGo2Ty9OTHljUEoydm1Xb3pqSitrWS9HeEFUVGZtSlpnRzZUY1I5aWZuU1FB?=
 =?utf-8?B?RWNyaFRxdVVOWUdOeDlkTzVCTFBGUTU4d0pGOFJvZVVIQXFXYkxrVEFCRHVQ?=
 =?utf-8?B?RTNNdDdWWGZFV3hCRGl6Z1dpSURRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba2daf1-0cdf-43a7-3670-08dc5a035c88
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:42:46.7412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQh+7oxM77xYfkPIZJWMmw1wjyeI0/2WL4Zg76uhwDSaUvMEn6UWE2IB9eNDy59WJZ5sn/VFpkzT5BVUaeZo0LzZJJa6PXiuSZL+CFVePFijj4Ak1RIUrow7JsJBPTn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210
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

Hi Maxim,

On 4/11/24 10:32, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
> 
> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.
> 
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   boot/bootm_os.c  | 24 ++++++++++++++++++++++++
>   boot/image-fit.c |  3 ++-
>   boot/image.c     |  3 +++
>   include/image.h  |  1 +
>   4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index ccde72d22c..1c92b8149c 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -395,6 +395,27 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
>   }
>   #endif
>   
> +#if defined(CONFIG_CMD_ELF)
> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> +{
> +	struct bootm_headers *images = bmi->images;
> +	char *local_args[2] = {NULL};
> +	char str[19] = ""; /* "0x" + 16 digits + "\0" */
> +
> +	if (flag != BOOTM_STATE_OS_GO)
> +		return 0;
> +
> +	snprintf(str, sizeof str, "0x%lx", images->ep); /* write entry-point into string */

While sizeof str does return the same as the number of elements in the 
array, it's only because it's a char array and thus its elements are all 
1B, any other type would have returned something incorrect.

I recommend using ARRAY_SIZE(str) instead, which is the way to know the 
number of elements in the array (dividing the size of the array by the 
size of an element in the array).

Cheers,
Quentin
