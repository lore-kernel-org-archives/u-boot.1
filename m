Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B2CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABEB886B4;
	Wed, 24 Apr 2024 16:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZF/04eHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E302886A4; Wed, 24 Apr 2024 16:34:26 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4641886B8
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPCrCb4coptqCeKcvG2WdyIDt+0RmWPCYl51tSotaD9S+CrxccW4SfBXrLS8+8ozejtxrr3HMO5aX3y1zIYdby2wvhKPOElUiOGXIzOBTMdprENAUmupMopRuK438bbjnhdeVG1M+YIm0+KNOQ3AH804YM3rO2bBOcpQGmvtkzSYgZDQuAqQitaPHMAV9C7DIRYKizgNNlWxAPgUTO0ER87XVKakPtrnvkJdsAhMUJixKMloLqrkZf1Ro/6SLy/yPptmq1pcLlFAKDKCxZed99yhHo7YtCFeUPm0y6ojxG6tOBaWo5gekV3HAY1JKbKufg9fcaTcSarvN/jJsquWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUDtg4Ah2gSDVLWdhh/N4ORL7IOfNnW01FFm7Q766ZE=;
 b=Q9gE4/Fou5UNHfDNGzu3Pm8i1+WAljx2h86KBUvDyYH/LLxVykPIot6JXjYhjIffLMXTXn5NhGKlvmjX67rfEHV6Jtbpe+YJWDMZjDPJbIVZnIzr+N03TkE+Wlm9ukfpbnIAFHyQVanL0QgZfDpMmbjafJyNAgxLsP6nYyHEJUHx4I3kSU9Q3Y8OHO07I1UiVUezrwWYbx+2ixi7U3AtVAnaRog3Dlk29k5+QrLkAlsER6MqdmIxGyBfKTqobfqo5Ejrf7vs5/LcJbGXuDP95d/5PtOAmEbSw6AskncZFm+J3Ou12s/lXYwTLGaVDeLcWKNkRy6BQDJa2jEwEFjR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUDtg4Ah2gSDVLWdhh/N4ORL7IOfNnW01FFm7Q766ZE=;
 b=ZF/04eHsGmWUcAexKdJmZ3KjScZLSbDYPld57Cw42g3aXNxZrVA70b1WV+6rI0G4YyG+SD56PGruawWwwrCMfaZCyUyKZ4hAefePNoppBsravBjlSMdLCZ8em6JrN+xcl8xt4ljQwY/RWJM9agi0bLCEBwnVJGAtMX1yiavuvuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:34:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:34:18 +0000
Message-ID: <ca63cfb0-5e5f-4522-8cda-87dec22588c9@amd.com>
Date: Wed, 24 Apr 2024 16:34:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynq: Fix EMIO clock use detection for gem0
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Igor Prusov <ivprusov@sberdevices.ru>
References: <20240416084456.2821567-1-megi@xff.cz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240416084456.2821567-1-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0159.eurprd09.prod.outlook.com
 (2603:10a6:800:120::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: b20e56d7-f96b-4105-2ff7-08dc646b9fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2RubXlkRWdXNFNkNGNCdThzS0JNRmtjUUp4QTRIaytXUHNoNVFBQ0MyeHJG?=
 =?utf-8?B?dFFQTk1GUE1kTHA2c3IzNXRTMGM1RHJ4WUo0TmJBOHYrd0E2Q0prWkF4WElK?=
 =?utf-8?B?ZGtEOHNNTXpuYjB4cUFneWpsS0FVYnh6dW1TWFZtSmJzT2oxR2RuTEE5Y0hy?=
 =?utf-8?B?MktjbTZJdFZEcDh5MjlRUGVqcnVhS3pzVjdobUxKQUk5ejY2NXNvYUFLQ2Ja?=
 =?utf-8?B?N2lHTFl5bTdsVlBOUmVoYVhNVnpyUFlNNU41aHRpdHFVclA5ZVJRVzFnc3FB?=
 =?utf-8?B?SDlUTWFEd3gwOEdqL0gzOG90aWxKUXlqbHpUS2pVVXl6TWR0dlFLK0N1ZHR5?=
 =?utf-8?B?MjBGSm9rc21kc2FRb1ZtT1JpYllxeWNaZUlkeHhwd3huV01zRkN6T0VzV0pX?=
 =?utf-8?B?Um9udGkzVDNGbWZCTEE0VThLajY3d1N1R2dsZWk0bGYwcnNKSkxaWm51VzBj?=
 =?utf-8?B?WFhtOGU2WHY2Mm5LYWdidjBBS085L2NLOEVWTkVlYmwzak5vMGw3M0Z0a3Nt?=
 =?utf-8?B?QWpHUHJsSGFsRytLcFY3M01jZXUvQWx4aTZsR0hYZmxINXZhUWNBcEZEeWlh?=
 =?utf-8?B?KzRSMUFLeFEyT3lNTkowUHZWYzJ0L1dUeUUyb29ieW9UcUlxbld6VVg1VENo?=
 =?utf-8?B?ay9GQ2xvdkp0YlhNRVVSelNUUjBreVdOVWozVlBuQVR5RTNIZnhzb3c2Q3dI?=
 =?utf-8?B?cVJSQXAxUkZVSnNxcDBOMG1Pc0pUaXBnNlIzUENDK2JIcmNXT1VOWmRtc2d4?=
 =?utf-8?B?eWdHa0Y0alV0bmZnTHRCTkVialJzVE1rWmpxWkYwemZoNzRFajFndCs3ZWhU?=
 =?utf-8?B?RmQxUDhrWFlzK2FJWlFNZHp1NzliL0xPbFVld0RnTVl3RUgyN3hHaExoZnBh?=
 =?utf-8?B?MnZQamFxOHZwZ0FDbVZKbGJ5aXJVODhiaHo1WUNDcERpMURaZkdNVFBvSGNC?=
 =?utf-8?B?b1E3c2pyL3VYSXByQlYzNlA1RHQwR0MzRW1KTFMwRWdFNFU0SjlyVklQWjd6?=
 =?utf-8?B?d0lKNVhzd2hYZVRwOE5sQWUwdDZtQWdNaDZ6Z0U4UGVDTUFiUGkyRkltcndn?=
 =?utf-8?B?VzFBYWNyN0pLUGVIbW9lQkpCRUNEZVd6cm5CSllrN0lEeGM4Y25YRFdqNCsw?=
 =?utf-8?B?dENibHRTN1lLTGpKbzNvdWtzcDRvd0hROTY0anZxZEJxWHlsY3FUeFpNYkxJ?=
 =?utf-8?B?YllPbHR5MFBSNGw0TE9HTkphRzFHY2hOOE1keGg0dlp6eWhiaFpndGVVK2Jl?=
 =?utf-8?B?TzhLdHVOYjRvYzVqaWdiRHZTQ1lPZlJoYkIwdCtEbWFncXVVd2RDSlZIb0xT?=
 =?utf-8?B?ekZBelBPVnVUY0R4cU1IZFRWc0ljdkg4ZTZxdlhTWC9SZGh3alp4TlZvRkZE?=
 =?utf-8?B?QUNUTEN3c29NMHNHZ2hxd2svaW4ydll2OVUvVGJDaktDVHdoS21mcE1pelE4?=
 =?utf-8?B?SWtxM3AyQjZlUy9KU3hSN3lSbm8xdVMxZ2tuU0R0cHFuZ056U3EyOUUvb2xo?=
 =?utf-8?B?WEYveVIrbU1QejhoNmxkb0hDQkdhM0wzQ2EzNSt1ZEN5SmJwT1VhUEUrRkZW?=
 =?utf-8?B?dXB3WWgvZ29nYTB1NFJLOEhqL0hxcld6d2xtUGU4d0EzQXZUdmxqUC91WWdE?=
 =?utf-8?B?NUI0Q25lRmVUSXlJbDZPeWJOeENGSy9Cd2F5eVNlR2hNRHFmVTJPZkQ4VVU3?=
 =?utf-8?B?MVhNTC9MWHZVSmVBQWd2ZFk5OVZ6YWQxNGFHTUhpS1NYdEg5T1FwUStnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJKMXlEN3lEQWpHNytaUUFLYmVPdjl5ZFRTZFRXTGZNRWNOZzdDK2kyaHRS?=
 =?utf-8?B?d3NSaDVsUjUvdnBYdCtLM1BOQlovYXZNZVVPMTJQTXc4WmozcThWTlVwTlpL?=
 =?utf-8?B?bEl3MWV3dkRqTWNZeVFCZVZBTGdEQ0dvZkFuQjBpRERCeUk1elZkTDc0SzFu?=
 =?utf-8?B?UWVXaFYyMDFrMUg3anJxWnJ5QysvdVIwdTY3T0FNODBxd05NZ2ZiRlZiMWI4?=
 =?utf-8?B?aFJMZkxVVyt1bldRSkdwVlZhbVlCWGNEWjlHOWtDT0Nld21PS28yNDZIV0s3?=
 =?utf-8?B?S0cxYzc0RU12UjYyTlhHV3VPeHFmYUxodjB2V2xpbXR5bXYxTVdlYVRGOEdx?=
 =?utf-8?B?c0NJOFhPNUk4VEprTHAvYzFzK3plamVrT0M2eHkvT0QzOWpqQmFaU2ZHbW1o?=
 =?utf-8?B?WFRKQ1E0bjgvK0R2QkVyVnNFKy9yMHRsbk1WaTNzdXJUMStqVmFJdFVoOThv?=
 =?utf-8?B?VlB4N3FGNWlGR0U3b1E2bzhkRGRxSGVTaVQvTjRxWnlXUU8yU3lQRUxwNnJ3?=
 =?utf-8?B?bjhCaTVPM0dwYjJTc083ODdDcDlxOTVtYnE0dDZrZ25RRTZ1S3JBWnhXdFFk?=
 =?utf-8?B?VGZ6c2sxeVVjZlk2RUhHbmNPOHA3cnJHQ3FNaXkzOHp0dHJSVUNlVUNRdFQ5?=
 =?utf-8?B?VTI0WDhFeGZyNlpxODVaZDJmZS9zdWFtcTc2T1pDeU8zblVINTNIcFJRSUZq?=
 =?utf-8?B?cGV6RDZoWnVuODQrOXc0bTRPOVBQTEJUUVZOOXFJdUxqaXZLUnpYYWN4c2Jo?=
 =?utf-8?B?N3hBQlh6MjB5NkdRaVBiM29JaFJ3cFJmM05BT01rUndSNk0vcVBsczhPV3Ex?=
 =?utf-8?B?RnI1MHBrbE9OZDFrMllPV2dwT0x0bmxTSDN2M3d2d3FHOUhydy9FTWdiSVY5?=
 =?utf-8?B?aHVkRFdqM0piTnRURWJFa3RvMUhwOVJlNWd1UmRMQ1lIMGtod2lkQWkyL0g1?=
 =?utf-8?B?NER2dHhjUXZnclNtZWFkRngzdmlaNm1lQlpycEhIeXFsa3dkWEZEMUFna1lX?=
 =?utf-8?B?Z1d2MTEyQmpOYjkxQlhzM1JKQjZjdTdVcUNwRHdFSnlUbDhvODRJRzkvVjRJ?=
 =?utf-8?B?VnNORkQyd1dJeVdDcW1EeEQ0UFpQYjkybGY3WEFuRXNkNEM0bk1NcEJmUFNu?=
 =?utf-8?B?NWRFR1AxUk5OcFk2UnVTVjV6NUQ0anZZNUxtTTFpVlpRaUh1SUoyOHljbjI4?=
 =?utf-8?B?TXRLM3pUMkVjdUNFdS9iUFBoYjFaZG1HakhIV2ZZcDErc0FCVTJnSFh4dEE2?=
 =?utf-8?B?TVdYWnhpTGtXd1hMSmV4azhQd2RXMVdjdTRLQVRmeWQwZkdSSFhOZSt3d3hD?=
 =?utf-8?B?MDV4OFZma3ZzQ3BPbCtmS3BVeXJtODBxMzg5RFAwUmgvNUpLdUFvSytwd3gy?=
 =?utf-8?B?NTNBTnZNQUlnTG5XWG9lY1JHVS9NbnBEbExmdTJjNU5TTThvN0laaVU2Zkk3?=
 =?utf-8?B?Si9UYm14c0tuRG1uMXFOVXpwbDJ3aDNTTmoyclBsaFZMVEVSR3Vod1VmMzh4?=
 =?utf-8?B?QjlkMU5jYmpVcG1CdnhyWkJGZnErZnFVQzdHQWhvSnBnWTBzb2diaEVRNktl?=
 =?utf-8?B?SFJvWTJMNTVqUk94aVFlQStEb1RJT2RURmlJU1ZJZXVESEQ2NklPY0lLOGFW?=
 =?utf-8?B?NU43bElkSEpTM3I2dDlNcEF4QWtMY3dJT1MyaTc1bnJwOStCT2RoSEFYNzhj?=
 =?utf-8?B?NEdCbVVKR0tjdmxJUTlPbnJ4dUgxVTJmUXJiRmF5blFvWnhQMnJqak5hSEtl?=
 =?utf-8?B?QzlBZm03S2pVc2N5amYxNHk5NU9WMXJrUmY1YWVrWXZqb0wxdGM3MTlsMjRF?=
 =?utf-8?B?OEpVSVlQMHY4aFhPVGdsMnBJQWRwenR2MXJVd0hmczQveEF4Y2xKTENPeXdi?=
 =?utf-8?B?T0dLRU1IT1hRQ2pkaDRUWXRTK2doRk5uZGRINitpWUxDOXpRRlhvYVdhbnNC?=
 =?utf-8?B?Mk8zK1pJT2ljQ2cyaElHendTNDBYblVHQjFNMjBzM2thaGx0a2RyMGhoWmdq?=
 =?utf-8?B?elFVcEVwYmpGb2tVVVVKQ0taN3NhSTZVVzROTEdseSs3Z2xkanoyU3dERXlP?=
 =?utf-8?B?bWtqbzU0SlZ6ZExGbEZhYUpCRXVlYWFrN2Q2djdYK2N0RDlicy9sZVFqNWEz?=
 =?utf-8?Q?T8DJYingyuHJSTLkQJ37rMkWs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e56d7-f96b-4105-2ff7-08dc646b9fd8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:34:18.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSPlqU+GZg7BfSJXckp7xUaYxL0GtOxR80h0jwZcIgkhBxBZOAWlhPPrvR8veOwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
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



On 4/16/24 10:44, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> According to TRM, the bit that differentiates between MIO and EMIO
> clocks is bit 6. This resolves failure to set clock when using EMIO
> clock for ethernet.

Not sure which TRM you are using but here

https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-GEM0_RCLK_CTRL

SRCSEL it is bit 4 not bit 6.

> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>   drivers/clk/clk_zynq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
> index e3cefe2e0c72..78e6886a000c 100644
> --- a/drivers/clk/clk_zynq.c
> +++ b/drivers/clk/clk_zynq.c
> @@ -42,6 +42,8 @@
>   #define CLK_CTRL_DIV3X_SHIFT	20
>   #define CLK_CTRL_DIV3X_MASK	(ZYNQ_CLK_MAXDIV << CLK_CTRL_DIV3X_SHIFT)
>   
> +#define CLK_CTRL_GEM_EMIO	(1u << 6)
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #ifndef CONFIG_SPL_BUILD
> @@ -161,7 +163,7 @@ static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
>   	else
>   		clk_ctrl = readl(&slcr_base->gem1_rclk_ctrl);
>   
> -	srcsel = (clk_ctrl & CLK_CTRL_SRCSEL_MASK) >> CLK_CTRL_SRCSEL_SHIFT;
> +	srcsel = (clk_ctrl & CLK_CTRL_GEM_EMIO);

Definitely using SRCSEL_MASK is not ideal solution because mask is 0x3 and in 
gem case it is single bit. But based on description you should be getting 
correct values even with 0x3 because SHIFT is correct.

Thanks,
Michal
