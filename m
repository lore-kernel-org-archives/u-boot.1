Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34343C5B567
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 06:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5039C81101;
	Wed, 12 Aug 2026 06:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id StBCEwNaEwWG; Wed, 12 Aug 2026 06:35:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C6BF810E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786516532;
	bh=kjfs1k28ney6/+pyIJvBhRyRCb0aBsNOqrul6K0BbMQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OpG820aoU5I1VaxSOPFm+TNK8J/Ojrf+UEWbiT4aIhMmPkP9K+3Qil4SAwK89ujwa
	 ypgtiUo0oUHlmMxpqZe6L1anbkdEhwHG4USjINip6G/1iLrH/Cgwomq33LaSgImDzC
	 oHuoY0Rx6Snoi3exoVhyaSc+XlLOyX8Mw77ph0gJqyIvT3HxDj2ytd4RqlbW3NG6Rq
	 bPvp38j1HLm8fkGqeYF/uozs9UNkxT+ada9jIFmoamYUGFFtup7eiHrIB1zSmlojd/
	 4fwR8pwPcJQsdsA23ZLOjRzNfzqRRoMWQru2DZiwa49bHP9piZWDJ/gfS1ciTsf27w
	 q0HL2OlRLCZkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6BF810E1;
	Wed, 12 Aug 2026 06:35:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D0B9259
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8303B4033F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvnS-TDjbm90 for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 06:35:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 717CA4008F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 717CA4008F
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 717CA4008F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiOzDZ+tNZoxG7LE26OB6gws3vdhgedmCGEfrXzXZwGZd5z1I8WeXmGZqReMxRLcDMb6PpWWv6MH9xWty64vm9sEDhq2DZLEOXf3ztyH68RagvkyCw9zyiNC0ABnd/cMGnf5BqMG6fiAvDP0S/Mclmkh0UMDUiMLZVwRONeh4GpFOIzE5SGsQmSgotv7Kh/nVDRkltJ9l3b2cOe4XC6YDQUWZUsDYhlQe/BmYt0WL4o8pv+gTAdXm+r86Qg4AFS3akUSn7hsgYLLhBs5sXeG9cEIG6FJ87FdJaEZVYouPGmxgbDvz1ezUEC5KQj1ucBgN7Y9UETqfxSRgIGUQ/6iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjfs1k28ney6/+pyIJvBhRyRCb0aBsNOqrul6K0BbMQ=;
 b=XlVN+mY8imQ+UtVIeUgIWsQmyG44r2tf8yrH84D2KiL1SCn7UZ4y/v7Ca4Sb9mnp9ruGXc/+IE4fGpkAmFr0G2QdrJzyx2udQ9JL5AsQkzornRYSOS8WNF1tQqElI93XoyfzI0T0XtTaKDk8e7hE3GCF18gMZfw3WrMxHqA37ATAMN4w+/NkE0oD2ww+slCBRVvHBtBPyI4h+TPiL5uxxnzaK/vxJiSGlYJiGTP/WnAdBzrFICGdNBaXppbV899bvH9B56Pk/VxNDaZkxpkj0PV9lfPpPo8jT+wKci2Zgp+apbmqfUHB5dnnntRg2cPdDeTAJ+eNjUUvrNPyRg6Lyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 06:35:20 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 06:35:20 +0000
Message-ID: <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
Date: Wed, 12 Aug 2026 08:35:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: dbef77d5-0ae2-4ee3-f326-08def83be17f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4EsZJUZhRcKEG7HFnKu7OUtzmZz7huzphl4M/2RpwFVUgEBEpxK0Jwb2T4U9WE765sIZeIXdf3Uge2bu0M5WpNPBLLDad194M1P/UXteXaTmFNtclNzQ4zZoI0CdzNdWYwrppkP/0OVVG/28KY7znUiXAlQtZ+YcFzLyLD/qO3OFU5/oYC0erh+N7HcPq52VRNU/09x5dCW8R9pUvb7GnWx0PeU/ELmhyhs0ZWBjjFQrqykc+61aNRPL3BHseqrashpTaGFti+x7bVtjh09hWUphns3sAkOJ6xV9LR1oI/+waiH9qJRnu7caz/pHtUo68DyiaH57qLrKZYf0Tq+JBU4FMAhCx6geR11DMLxHdwoKNhVJyB85rSWcsgClD+R5oKBuwU5petPRq4+qL27ilb8Rte450nowMHoYkYjialsRdNQRtjnhl2LoIREggVYpjVom63+q8l+iGvwhm98EaREEKDGM69/bRe6vLvYpfJoqVkRFkbvnmrCn4uzxpAYiOdBLN6ilpFrwJUjgaODiIhAQ5vN+B38n5BDK8f/07buWunHfnVOhHsFfX0LlTnthulzt7c8+nMr+Jcx+pM9Mba5VZvVWi+9iefaFEQ2Ny14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFTOEx3cmpiaWJwSFVWSU1LN2M4VTlFem1kaVMxOThlcWtzRnVwdVFkL0pT?=
 =?utf-8?B?T2ZXbzlqblVXOGd5Z0tBcTY5RS9Bd2VUSXdETExUVDF4ZzdIYWxhc1BWK1Ur?=
 =?utf-8?B?NUlEeXlvdXZ6UGRuZWVWeHF1dFlad3RrTU5wcWlFeFRGeUpRc2hIUyt4WDg0?=
 =?utf-8?B?UTNld3ovZ01WNVBYUCtGa3N1OFhyMUluVlJsaFN5MllJUW9NT2ZkcmdyN3l4?=
 =?utf-8?B?SXk1NU9lMVZnaGhxMURudlR1SjE0RTJoMEpNOFBNdHB4R0FSZE8zMU9vU21r?=
 =?utf-8?B?a1YxYzA1UzkwUy8ydzhKMnpSaURHb0NjZTl4ZDdqaGNxMFhTank0ei84TzRZ?=
 =?utf-8?B?THpmcUliNEVENTNqRmxCZXN5aWVyM3FXbklxbmlHd25hMGhhZ3JtZnNHREdM?=
 =?utf-8?B?QXRIMWxnRHJvcHNCZzJ2M05lUmFPM09mSUxUbXJLRnpBM1FtZldJM1NseVdh?=
 =?utf-8?B?R3p4SVhDOVArV2FMTnVWYS95TWdjMjJRUmJNbll0d2hDQjFhQWE1RGlWKzYx?=
 =?utf-8?B?SE5QNHR2MWF3TUp4UHRacGNoQzV2TWIzaFU3N2ZhVk1pRDQ2aEVJQ2U1cmdZ?=
 =?utf-8?B?TWc1NDZtZkdkRC81TkZjVWp3T0pXcTNXU1ZJa1hNUFJndkErdHlEc0FaWGhF?=
 =?utf-8?B?NTdLaG1jWUNtcVlvZVBHeEg0amk5eUpISUdYdE9HODNrUFJURnRFTVUrNnAy?=
 =?utf-8?B?MU40NW8weitiYnBIMklSYVBVVVJXakF0eVIrWmxVeGhNZVVsd2c4WWxJRDFn?=
 =?utf-8?B?RDdPdVFJQXNMeE1oeVJVZDkxeEF2eFJXT1BlUjV3cS9WekNMSkxWQ2lZbFR0?=
 =?utf-8?B?TFYvVmdLcDY4NFlFejBWQXliejNyRjVhS3NmeWxTZE5oNzVQTkJEQ1RVdkV4?=
 =?utf-8?B?dVQzelM4amJGRDZndUc2VmZUNnJCUzF5bHMrRm9yWE93L1I3MWMyZkRUaGhl?=
 =?utf-8?B?UDh3NWV6OWZCbVdWYkJycXN1K1hranM0ZHBtTk1rMWd5VUZFbCtUWHFHcURG?=
 =?utf-8?B?RGNzODJaN2JxcHVJSmZqdkJnNTZoRE9Vakt0UkhuRDZTWWxPZHFQdzIxZng0?=
 =?utf-8?B?Z2xQS1p5b1oxWHlDUlFrM1lCTkpSNzNyZk0wTVg4NWUxK0hIaUJxck5hSDNS?=
 =?utf-8?B?M1JLQ05EWjdlRnlHWFpNOFRQK1cwdUxvVUdGNllRNzkycWhNM3NuKzVJV3I0?=
 =?utf-8?B?d2dIY2xNYlE5OVZ2c0szem1KdWRLaWwxSHJ1bzRNeUYvWURTZXFSOFdUS1dI?=
 =?utf-8?B?cWNyMG1RYWJlcVBsMThEaGYybFFMbEpBK3BQV3ZUbmNQdWtlOXAyMmtIei9Q?=
 =?utf-8?B?eGpHM3RZYWpVWWorc1hKM2Q0TWpTMzJYdGNudzFnTzVVeG5wQmVIVzlQY093?=
 =?utf-8?B?aHIrTVlhRGRzK1NpdDlGNnpDdzUxcW1hRWJmcmxSQ0lBTXRUd2hHVlUxWEJn?=
 =?utf-8?B?OGhRQ3ZMQVE0Wk1EWGM2Y0tEbm5WVVdDT2I5TEVMZDdHeXhrbnVNclIrdExI?=
 =?utf-8?B?WnBTTVYwYitET2pSUVhzRjV0MmZNWWdWdXVyTW5hNkZ4Y20rUWZtSUhKYUEy?=
 =?utf-8?B?OUVRLzBBOUdLeEpKSmdCK2hHOERDNk95UzFMTld2ek5Xa25vS1RtVzJpYjRr?=
 =?utf-8?B?V3c5dVBYd014UldZMnRGc3Jld3V1czhSU1ZNNWVNY3BRSHkzSVJLcXFETHNN?=
 =?utf-8?B?OTczQkl1bnJjaHM1Y3dlT2Q3RnlVU2dkMUkzL0Y4QUVoREFmb1BRaGNTOE5I?=
 =?utf-8?B?b2U5a0h0Nml5R3hMSnVTclJXSU4vZitubnhjSDh3U0NsV2FQeTF0WW8xZStm?=
 =?utf-8?B?M2wwREVQd0w4aS9UaUw3VXZLa0cvb3ZLR3FmaFdCZnB6dzEzdktReGh3WkJV?=
 =?utf-8?B?L1RkcGJiQmlRejdOQ1c4RnBBRnVEZTVIejZZc0czNHF1b3prMzA5Nmp5RXBU?=
 =?utf-8?B?OEdMNXo2cVFMckxkOWlGdGh6cXVwN0ZEQlFuSnVJdTN4YlRZaWM2WXpHN2hQ?=
 =?utf-8?B?ZWM0dm9MRHdERzlDTWpZYVNqVi9zUGxIZGwwV2pMcnVpc3hYM3FZQzNuR2tU?=
 =?utf-8?B?Ynk5VW1mQXBmai9PSE5kK3RDOGJpSngwWlJmbkJLNFZuN0VFZzJsc1M3eks3?=
 =?utf-8?B?N3dNMzI5OURHR3E0VVgxZmFlTkc2Z0FLMllzWEdBQzFPVFdXRE5yT0luYUFX?=
 =?utf-8?B?NklHTlJ5eXErMHA1QlNyVVF4OThIbXMrclF4STJ4cjFyVzU5RHFEbDJ5Vm1Z?=
 =?utf-8?B?WUNUb1RDbkh5T1pPL05hYVY3c3FyTVZ5ZlA1TElmak5LeVZmNlBkakZUcnhP?=
 =?utf-8?B?QWhkNFlRRmRnQnJ3WXd5WjhCV2cycVdEdE4xblE0Rk9xUnQvcEJHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbef77d5-0ae2-4ee3-f326-08def83be17f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:35:20.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF4AAC7VDC03A4sUcIedxsbOa64UKePKoo3A4G9xFSM/81ldfQKlBRPfKv0V+ty9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjfs1k28ney6/+pyIJvBhRyRCb0aBsNOqrul6K0BbMQ=;
 b=gtbppECLHzUP9XSl736v1eQdxm9KtpfnbYycK+kGytKyFEehg16/jypG3HnNJxI4ZttVG8KY9dq0QZx+IpQosX1qL7CoIDWnL4ZjDF/opBZW2/IfIoD/M9ygCUrxOgzXrJ64k0P51AGmgpQKt/qbRL2jk6KFcC3a271wZnslkmk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gtbppECL
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 8/10/26 13:37, Michal Simek wrote:
> Versal Gen 2 and especially march-versal2 is not covered by own fragment
> that's why add it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1379a6a3e7e..eb48eea55c5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -821,6 +821,12 @@ F:	drivers/spi/cadence_ospi_versal.c
>   F:	drivers/watchdog/xilinx_wwdt.c
>   N:	(?<!uni)versal
>   
> +ARM VERSAL GEN 2
> +M:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
> +F:	arch/arm/mach-versal2/
> +
>   ARM VERSATILE EXPRESS DRIVERS
>   M:	Liviu Dudau <liviu.dudau@foss.arm.com>
>   S:	Maintained
> ---
> base-commit: 4b12b2532a904fcf1c5ed9a7b323f39717ee92e4
> 

Applied.
M
