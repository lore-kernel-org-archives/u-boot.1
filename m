Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F226FC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 10:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B291810F4;
	Thu, 13 Mar 2025 11:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dY7TV4AH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4829810F4; Thu, 13 Mar 2025 11:20:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D1F80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHj+GoCcLRDiBYiBdV8y43i+GJAAh9CMfiG0yLJi66S9wy4EN6NYNUEAQxxfsGkaRGg9cCNkTCmy9wHWAQH/JNs4T/YlwD7nKezXYJsRhdbx9/rk/04EGnW6nJcy+HhmHiQsMpfycsVvCVGVr9H+Vt1LetYvMypcVEvCgN9Vm3QQmT2L41giSgZQdiUCBVZeMX6zNNWj6WloitMjCOk06tpWEmj6xcZNQorUPmezTpp6Y5+cNh+WXPlKeuZ919gbVxeDNwdClL0YooFeOw0tyK/XZ8t688qmcQqGI8LB+eBWbQx6QHwajf3JUAChV3w0jEJY23ZEaDqwgGs446ZdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZaJDwRQIrF6XMRbaMd19xmWLKpZuqd5hjkcoenjZ64=;
 b=ar3SRWHpSsWDT2KPMqBpcdrUAaX9tN1DwyAsoh3BDxNWcjUOIZjw2cxI0nhYYhNvptZilMByr3WMDqDy3LVXcCjXgEZ/Q040hyDagcEHdcwkHIT0h5aqFa9eJYy92vvsXIDGyLW+HQ9YtnTb6W8xT10kF0sET+27umzP4/kWKM1oVGAfkNhF3hJJWt3tM4zaVa9a3a1/lHDZSqSRuUj2+QRnAQ8TW1wJhwZYTIiPTVNrDM9eVQDVBBVUl2Urtabioy6U9zC0Ku/8sClEuRFa6QUENSRl3Q5i9QzU4FOBLi5gVT10q4zpASGXnKHy2H5wBBO6jOOl5upIaPqMfvvc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZaJDwRQIrF6XMRbaMd19xmWLKpZuqd5hjkcoenjZ64=;
 b=dY7TV4AHQI6hYQDCVMAkwCn36vYalkY3OCymOwq/WkSQNAIaLxzIEf9SOtQH+1OTYKbGjZiZ2vq06mhtt7AMqBgWhV2qGvEM1f5fdq9C43eZxodEgxr99eLjYVBC096uwS9T/STzGe6KnrCykVWlftgpw8gBQFhnOtUJzg6c5fY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 10:20:11 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:20:10 +0000
Message-ID: <33389606-0c16-4d26-b7e6-44e4f973d29e@cherry.de>
Date: Thu, 13 Mar 2025 11:20:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc/develop/codingstyle.rst: Expand to include
 CONFIG_IS_ENABLED and PHASE_
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250312010021.1671010-1-trini@konsulko.com>
 <20250312010021.1671010-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250312010021.1671010-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::18) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ade6af-7c43-41d8-6235-08dd6218a293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhwM1NodWRQbGFHd21RZHp5QTU3SC8zRWdjVjEwcWd0eUt5emNJbDZ3MzFB?=
 =?utf-8?B?cDdRMzdHQ0dSNUd3eU1FNktEbmt0dUZPblVyVmNHTjlENmppeGFLVlIyVk1R?=
 =?utf-8?B?K0IyN1VCcC9pOVgrbkE5NEc4dExmTVc0M252aDlBZ1o5ZFFXNU5uR1BIeG5I?=
 =?utf-8?B?ZHNyUFNMdGFndDRoWVIxWE9EYmhRQkhmVEY4cmcyWGFhY1lQdE15Z01BMGI0?=
 =?utf-8?B?MG5vTTJxM3JHU0Z6OU5jYnBhQmJxOTIrUjlIOEt2Y1ppRlJVOHYzTmtURllN?=
 =?utf-8?B?ZjlmZ1liWUxIYjM3UmxoMk9ubXduU29UVWJqakVBRElwK25Hc0hzOVh4aTdt?=
 =?utf-8?B?eFRwbFkwYlVFZ0o2b3BzeGMvT29obVNNeUZUV2xja2lpSERvRW03dTZOV0tj?=
 =?utf-8?B?a05XTUthcVNWY1JhVUN0aTVhNWNRS2FKQ2tJSzRhTXRXWDhIeVVYM1p5d3Fr?=
 =?utf-8?B?a0JqTjRNcW5SYWFjN3JuNktDYkY4Uk9nTEhxZ2JHS2hQR3FaMGZJNjNaRHl0?=
 =?utf-8?B?QWlUSkY2QTVVc1F0dUIyL1FGWWY4dmNibUhQdzhuL0NxcTRFdWhsdHY0OW1V?=
 =?utf-8?B?bFFsb2sxTXh3Tk1ZeG82V0dHd1hTQzV3Q0NLU1RESE1RbWRYc3UzQUk5Qko4?=
 =?utf-8?B?Mk9vd1J4b0NvMHRwem9OYlpJK1NFbzNWaFZHOEp3bmhQM1ROd1AzRFp2WXlY?=
 =?utf-8?B?VjdKZmhITVFLWDEwY3R0S1M3WlpQU3RNSURGMXJqbm5zWUJhazA5U1BvQ1hY?=
 =?utf-8?B?TEVMaXh5TytEek80eVB1UUk1SWwwblVjVXc3TGdzbHJMb0F0QWF1dVJMZGVO?=
 =?utf-8?B?NlF2NlRZWXVkSUsyRjFKbURTVDA3TjJ5Z2ZmYzdSS1dBTkhyOHY1SlZNbVF5?=
 =?utf-8?B?QVcxdTMwd2xEY0dSeU8yWHJuZTYwVWlMaUxPS1dwcUdUc0dDK3BpZ210Yjl0?=
 =?utf-8?B?aENWM0RJQWdmU1VXRGtYLzhCMFVqZ0JXd3RRT0p5WEhyZTFWbW9MaXN0ckRU?=
 =?utf-8?B?Z3lXd1Y4dERzWG9pN2ZhY0dHMGFxbzVGdk40MWM4THZXYytKRnFmanp2NmlE?=
 =?utf-8?B?N0MrWlU2bnFwRGRzREtpbWEvWDEyYitHMHg0SFJ2OEJscXBjcjlTQkphdnJy?=
 =?utf-8?B?dVBWeVdPUERFOUp5ckVwUHFNdm5meXZrVG9COTYya04zUnM5V3owWmNxRkVF?=
 =?utf-8?B?YUk5R2hYK0E1a2x6ODdueHc3WktKLzlYQkdJVTRZWUlMbXJia0VXMjVYblk1?=
 =?utf-8?B?M2NuVk9xaTNJRlRjdk5ORzhzaDlNSUllMysrRE8vWmhaMHkrWGQ3b2hwdkty?=
 =?utf-8?B?UFBQYVdkMzZEN2lrblNlWDZ5YTdzdjZya1hod3VWOU4zdFIyL2QrMnR6eVEw?=
 =?utf-8?B?THUxUloxVTRkb1ZFY0dPNGFNTzZLVlFKMitPTFlpNnNLNVZSbi95cC83czdz?=
 =?utf-8?B?VTBFdEVkVlFPd1g0N2M4N2pmbjhZZ0Q2bzhKcmQydW93RkJGcEo3bTZZc2dH?=
 =?utf-8?B?OWtZOXFCTkxXNmRQZDI1bEhxdFZtK3VVODFyR3F5YTRMK1RDU0lTNys1RmVX?=
 =?utf-8?B?aGRmbjl6dTVrVjVsMG80SjhidElWdVF3NlZ3OE5rU0lTWUh6UEpEajlHUE9h?=
 =?utf-8?B?ZlowN2dGdFh3K3VhUUI0Zjg3bCtjWi9XcGVILytHUnoxSmF0MjNCT2Z3ZmlG?=
 =?utf-8?B?RUVnRnVvTjRPaTYxUkRDWXpQMHZJa0RMR3hxNVVWRDBWYlBpeWRLem40NlBI?=
 =?utf-8?B?OWNWUzE2M2swcG1HYkFpeDdMOUxCcUhHZW1XY05VbjNpQUFscEhMK0FSRW5o?=
 =?utf-8?B?ejJDWmIwSWtTNkVIMTJ4M0JPdHB4WUR3QzRnTEpaVVN4aHNwNS91WEZuWTAv?=
 =?utf-8?Q?cdHmF/aO/pmmA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRWUnZrVjlJWUk2Ymo5Vytncnlad0hqSk14M2VETEhDYTNJZjNDZEdnS2N2?=
 =?utf-8?B?RDdLRkJHRHkrNzl1NlcyWmxsS01EY1l5NUZWeGcxU1RMMWxJT3l6T2RqMTg2?=
 =?utf-8?B?cUZJVCtkM292ZlVoNHdKMU5rU3RFV3RpaVJBZlFKbzNGSk95a1E5RTFqK2Jo?=
 =?utf-8?B?aU9GZlVLT3M5RkdEd3EvTUREdFZjQ1V3S0EzZ2l6RWl0T0J2S3BDUnVHbThj?=
 =?utf-8?B?a0xBblh4RHZoaDNqZCtNQVcvTWJPWEx2cTMyQ2U1Rm5FUTJVbjUwUWlUcElP?=
 =?utf-8?B?QUtJTjl6Nk9NSHVTZmVvQmllVXVuQzU3NVZWd3BPWHA3UitrcGt2UjdPOWZh?=
 =?utf-8?B?RXlybE9YV3BXY0ZVUCtSTzNFOGplVXJ4V2o3MHpoTEtzVldDNmo2clIvVnF2?=
 =?utf-8?B?d0g4Y0plMVZLdy8rTGwyemlxT1I0OGVseGxURWZZWHVQZXdIbVdxRDU3TjM1?=
 =?utf-8?B?dm1YMm5DWTlROWZ3ZGRNcWhCSzBHMUhUUStLVzNTbU1LaEhXU3VQUjc3M0Vu?=
 =?utf-8?B?UFFNVDE4RUgydFUrM1JHZDM0VHF3dTRzdkIwTkVSY3VlYlVkak1jNUpKVStJ?=
 =?utf-8?B?Rk5RYVR3NTY4QzRxMklKR0hiN1NUVnlSK3d1MVhEU2NJNVV5eWdoUUY0c1ov?=
 =?utf-8?B?U1AzTE9TYm9TcWZBZUYyOTQxZkVKbm5VWVdoL3M2TEZ4dTBDMG9mVU84UHI2?=
 =?utf-8?B?ZVBHMDlZMExEU1ZyVDA5MU5TM05wd2svZzU3TE16U0lsUUtNeXgrVTdjWmxq?=
 =?utf-8?B?NysvRFlwbHBvM2Npa1ZFeVN4VGR2QW9YbFF4VUdMc0JqcnhTVnZFbU1TcUZX?=
 =?utf-8?B?NEE1RWtPamtTcDkxMDFrNzBMV0VYUlczaWNOTVNvdGQ3TzRPTlA0SmVGUHVh?=
 =?utf-8?B?dUl4Ujh5L0VSOE9ERzZXUTJhNlBybHpSVVQxNDI0YkRFYTBnTW85cW9qRWN0?=
 =?utf-8?B?ejJFZU1WWDgrNURYdnZXdk5teS9YZ2dVTUNUcDQ1ajRGVjdRR2NKcTRPOGtN?=
 =?utf-8?B?MHdoZ1V2cVpocXJJYUpZRi9TWFBaTXU0cWswNitSaC9yYnZWaUUxclpwdUpV?=
 =?utf-8?B?WXg5NGVRWnNQbFZaTTE5dXNmT3luQXdKNWtETVRXb2RPak5MRnVlYy9mZnk4?=
 =?utf-8?B?SG1oMjczL3FRZVVoTjQ0NUtFNVQ3UTBOb0IzbXl0SlJzcDlZVUI5enJMcktK?=
 =?utf-8?B?R0xaZXRSNGh3d1ZhUFZSVlFUYUJ2ZnVGVHQwbzg2UTdMbFh2dDZ0UDV2aUY2?=
 =?utf-8?B?eEc3Y2tMV21TZytmM2xQK01GWUZtT1ZlaFRzcFltRjVRcExib3NXRml1ZEtt?=
 =?utf-8?B?WjM5c0YwZ0RtdmhsVHF2L1RIS3JoMUNXZEVsSlJzb3dDelZNM2VFZjBYOUZC?=
 =?utf-8?B?SUlDVXVBTys3RVRDS0xPeHE5cVRrc0N6SmJZaHc2UVRMVWxoaFpmemQvRDl1?=
 =?utf-8?B?SFYrSndiWklpWGx6YUlsOHJsdTduK3RRVStnamoyV1V0cENpK3hHaTVaVi9l?=
 =?utf-8?B?VGxodDJDbFBBVHViTEFMYnJPem1oUGxNcWpuNytjdEJDc09CM0VlNmRGeklE?=
 =?utf-8?B?bjNvaFZKV3V4NDkxRURWVXVvRVJDbHlrdkRRRXcrNVIrMHdReWlLUGZxK3h2?=
 =?utf-8?B?S09jRHV6WDhHVmtYc2J3dGFWV21OeDl4bEFsMnVKbWFtL1JWOFpQWmxqTXVT?=
 =?utf-8?B?YW1SalRpOHRJTkh2ODQ2KzRKRGMwUWR0NnpzbTVXNGxHZytNRVF1N2R0UC9Q?=
 =?utf-8?B?RGhVbWV6byt6QXh5VzAzT0pkWWF2S29kN3hIQWgxMjNLYlp3RGFtWVRSSjlu?=
 =?utf-8?B?VnVRSlhWTFlRMlR1R2ZJNmJYRXN5aEsvcnhZRENOMFFZVXVMbFpLRkp3L3FI?=
 =?utf-8?B?ckk4NUx0MWtkeGNYS2k0VmF6L2l4UUc1M1NCNThWbXFpdDFVbHRXcVp6YkV3?=
 =?utf-8?B?emJzdlN6Kyt2VlVQVGRtZHZaYm5XUlB2SzdhbUJyNWxTRlBqc21aYUluWTVs?=
 =?utf-8?B?OFdSL2JLczFDSFoxdXkyUm9ZZ1pFd2l5RHBWVStSeFY5SjhwWThuNkt6L2Vs?=
 =?utf-8?B?blY3cDlpUDNUOUgwR29MbWxlalNHdGVwalg1ZGJUcXAvcXh4NVRBcEthU1J3?=
 =?utf-8?B?THdXTmpvL1RhdkVlWW1MZFl0aGVMbUlmZEtzYzc2UThhRElmdStOZUdtTVVT?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ade6af-7c43-41d8-6235-08dd6218a293
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:20:10.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8paJu54SMbazsGITVcda8k97FFfnUGLPzMLJldQuCCCBW8jVrzEUdVG23teGQvrdseXAswg308AMIrFU5Jv5ol9T+HLzrZNuAn2EHHhQiE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941
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

Hi Tom,

On 3/12/25 2:00 AM, Tom Rini wrote:
> Expand the conditional compilation section to explain when to use
> CONFIG_IS_ENABLED rather than IS_ENABLED and provide an example. Next,
> note what the PHASE_ macro is supposed to be used for as well.
> 

Ah! Then ignore my comment on Patch 2/3 about the missing 
CONFIG_IS_ENABLED :)

> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - New patch.
> ---
>   doc/develop/codingstyle.rst | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index 7211e4e4eed1..3303fff165de 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -192,6 +192,23 @@ inside the block, and check it for correctness (syntax, types, symbol
>   references, etc).  Thus, you still have to use an #ifdef if the code inside the
>   block references symbols that will not exist if the condition is not met.
>   
> +In the case where a symbol may be referenced with an xPL-specific Kconfig

Please provide some information about what xPL means (maybe a link to 
somewhere it's already explained? doc/develop/init.rst:Board 
Initialisation Flow could be a start? Or maybe rather 
doc/develop/spl.rst which seems to better match what this is referring to?


> +symbol, use the CONFIG_IS_ENABLED macro instead, in a similar manner:
> +
> +.. code-block:: c
> +
> +	if (CONIG_IS_ENABLED(SOMETHING)) {
> +		...
> +	}
> +
> +When dealing with a Kconfig symbol that has both a normal name and one or more
> +xPL-prefixed names, the Makefile needs special consideration as well. The
> +PHASE\_ macro helps us in this situation thusly:
> +
> +.. code-block:: make
> +
> +        obj-$(CONFIG_$(PHASE_)SOMETHING) += something.o
> +

Please highlight non-English words with double tick quotes, that also 
remove the need to escape special characters like _, e.g.

``PHASE_``

Looks good to me otherwise,

Cheers,
Quentin
