Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1478EC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 09:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D94080086;
	Thu, 22 Jan 2026 10:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iRsAoh8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06015839DF; Thu, 22 Jan 2026 10:25:42 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B24980077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbBVJb5g3H0oMFkX1d44iBrppg2tWXk/uMKczy99o44B+CrWIHp6MVS+POdk3HZn7V4NwX6k5+fgtqXGl8b+W2Iu0M8H/Yr2AZvwulSj6QVrGKEcbG44+OL/nzTj0kHflIAHlrbMtWz9s7WN1xdkoAhnewo3XgskAm50bzksu4lwFM3KJgFIlLS71jsbX1OWs6j8iGEU76jpC0iSiFGH5QnRC7a1LlkubFpsfIJZQ3ZSRZ5rkaEzKAPH4+pVzBjBuoPzsKk4kZtIK2xPkqc1rslMxUbuqGI2E6fJTays9cvxAt8x7d4+/gy/61W2IQTu864BfJT4k5mlvRhOiakhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGSvzSeXYMWlOZ9RSFGxgQR8B4kzLMwKlRO4uiiTG7Y=;
 b=xy8Jw1epLSb6+T+dCarvKyiixV6kUH2O8cWhrPv1pLfDaIR//Blq0JpG4icgIBi3EQTnWh6kLHJ8YJr+ihm9YEZnBrp37gGf7/PxbiNdZo0X7/b+yDAjpm63onKbWjJ85DaN4a817gQpua71yM3scP5O7WC631Fvuawvp8aJBIC3jjW0qIGgCC9vzrpo2AFcEDQjoEeg50qrKTFONmXrd9geuTvuQH+gDDQ0UVa7G9fHyh40+BFWKNe4AQm7kAViK8Qz1QgeaQPCMBGuAJ17nzOxIZdyGYMbY/mwlAOswDgM2l29GCFCNLBlOItkO5BjkCukVMFsDDWkiAdDltnRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGSvzSeXYMWlOZ9RSFGxgQR8B4kzLMwKlRO4uiiTG7Y=;
 b=iRsAoh8/Qt+jQPtAabDskV5LvA4o7z1h98Jgw+3iXlppM9cFr73PQWDf933pr2Xwu6WerH9JlgpM/nZjLvyzMqZKgKFa4ldkHr4a1p9Jcfl4470gkxConPBN59S3CVOMpCpMAIEiNUau0oUs8jw6+p+5TzsQ2QSBFPMGdcH9+0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by AMBPR04MB12286.eurprd04.prod.outlook.com (2603:10a6:20b:733::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 09:25:37 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 09:25:37 +0000
Message-ID: <77fbaee4-777b-4d8a-afa5-239d8e0974e2@cherry.de>
Date: Thu, 22 Jan 2026 10:24:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-3-hs@nabladev.com>
 <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
 <3c02e1a5-aceb-1528-078f-80b695f741dd@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3c02e1a5-aceb-1528-078f-80b695f741dd@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|AMBPR04MB12286:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddb8452-dd0e-4bce-f9fd-08de599833fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXp4OHdvWmd4WGZibWEvdTJYb1BhRE9TNHNBc0RVYWxWcnduNlRaZHZYaXNW?=
 =?utf-8?B?RDFWUmZyQXpod1hQZ2xtcDhMU1pNVUc2cmFhSXhzNXp1eFk3SzFiblVHNHAy?=
 =?utf-8?B?VDNBeGtFY1dOVVd3ZVFqZ0dJVzRqb3NoNEFCKzNnK0tvMU93WUV6TlZYZXpB?=
 =?utf-8?B?VXdtQlJZQ05lVmJCVHlSRnFJbFo4eGdFT1JEVTU2UkhLbnRTNE1taGY1bHUy?=
 =?utf-8?B?Qk9wSkFsSk8yK3JFTFRGcUJuQnlXZzlFdzhDUTJVZ2VOWHZhRkhLc3cwNGZJ?=
 =?utf-8?B?bTlPYUdjVjB6OGZEYjNrY1hjRG1PVng4UTRNNU9qeEdRSnJVNlhqdnA0OHRU?=
 =?utf-8?B?WEVYZW9FcFR2dnRwWXZ6Y1pRMkpuTGxOc05YWlgyMExNZE4vei9SSm9BbVAv?=
 =?utf-8?B?NTdMZExDZ1M3eGR4WVJuWDBHMDYxWktydHZ2QXFhYm91YnJIM1BncCtlOVFG?=
 =?utf-8?B?TUtJUUErVzAxdTZTS2JPUnFwNlVEdzAyZGV0L3g1MHBad1RuZ2hxWXZpNk5q?=
 =?utf-8?B?TG1KV2FpZ2tKS2lCQVlPQjJXMXV2cjBqQ0hnK3hocHRjYzJ5Q1JNa3gwZm5o?=
 =?utf-8?B?NlkreUlWRUFGUlZaV1YzbnlUaEdleDJCQ0FJYXZEbktlb25abzJ0MDllMlU2?=
 =?utf-8?B?c2xTblBuRVgrcDc3b0pvTWNXc2lWZlo0cGMrN2NpZ3FLNnFiVE5FVmI2L1ht?=
 =?utf-8?B?QkowR25JQkZGTUdEaGcrcjlVa3E0a2J6aThhRDJmMWphU093YmgzNklLR0Ni?=
 =?utf-8?B?dXQ1czg0bXFIdER0QVZGQzJ4ZGx3ODNyK1FnNTZGWDF5NkF3ckFvVEFJU0tC?=
 =?utf-8?B?YUt4QW5FQTF1ZTM3cjB0dW9ESm9iZjV5Zm5xU3M0VXB6RXBVN25oMmFidEdP?=
 =?utf-8?B?TnlBWkZiY3pZRDFvY1RucEg4MjNDNTRFZ0ZJZDA2cDd5WkxFOThtY3FkWDNI?=
 =?utf-8?B?dDl3QzVOR1FwMk9Cd082Mnd6VC8yeVE4Vm53eldTQTFwRFZWOVNBdlY5bG8r?=
 =?utf-8?B?TkJXRGQxclZxZkkzK2VFZVgxNjBlTUMwYWU2SnFkdlJyYnpyMXBUa1VObzRn?=
 =?utf-8?B?cUFBYjVsMnlqZ1cyT0FTRUZLbkY5Vnh4Z1JxcXJEOENOTzR1VkJKSVd6K3hR?=
 =?utf-8?B?YVZkL2FXY0JtMmU1T2NlTS96YzA3K1ExT0V4WGduTFBlT2tpaFFKL2oxaitx?=
 =?utf-8?B?bVJ2ZFNOUmo0OCtsV09DOXdsRXh4Q0JxTWo3MGxwWVFYQWMwYys4ODF3QlJM?=
 =?utf-8?B?N2J4S1U5OXM4SVJneGhkMDQxT1pzNGdtUFJYNldScVNiUEl2YnpRQzc5ajlr?=
 =?utf-8?B?NkxHMFlySThTWk5sTU9MYXhkT3lTcDl0aWF5YWNCSWJuRkcwZFEwN2xkRXBy?=
 =?utf-8?B?T2hPWXFsSUxLTnAxcVZTRmtpcERxNnVTMDVocHFuQm1ybDh3YklqeEY4VlFT?=
 =?utf-8?B?R3RyOGFhUWltWGMvZy9hd0hRV2tTQjhuOFgwQ3I0YnNabXFXbDhuZWdZdzZU?=
 =?utf-8?B?RlBOdWR0aFoxMVBEb3c5L0grY081U3J2eDZYY1FzeDNSWW9rdmV1YnErbzli?=
 =?utf-8?B?emxLSjNheFlGNER3cG9kQ2xMMzhGR1ZxRS9tM0MyM0ZNa29IZGFLelVpVHI2?=
 =?utf-8?B?YWtGU0xtbW1oMUFEbHluUXRRd1c3c3E0dGtVeVViV0FUYlJ3c0JzSFEzNkFF?=
 =?utf-8?B?NHJ6cXZMQjRsY1ZCTzJQc3QyeFhmRTVtZFRjQWV4cUpxUzN6S2pQSnBlR0N5?=
 =?utf-8?B?MFFDZWk2Q3V4WTRjeFI2NE1uVXdZeE1MbzBzcG1kMmdtajMyeU11RW1ObVM5?=
 =?utf-8?B?SWJtTS9Ua1dKSCtqR2JLSThhbzduSUZUZ0FGVWVyQVZQdGI0cTM1Tm1kUkF5?=
 =?utf-8?B?QndkSjNWa1d0Tno2UUpkM0NlU0FGR1NYZW1ublNTTFJHUE1sNGhQK29TRjFU?=
 =?utf-8?B?V2hrKy9lZWQ5K1VFNmVlYjlVZmZYdVZISSttWnYwMlk1d2FtcUxhKzNIaTZP?=
 =?utf-8?B?UG5ieWQrdDV6WW9KenJGRU1jSHBTZVBWNlFNdjJqSHhvRjFSVW1jUDBqVUY4?=
 =?utf-8?Q?3e+nSm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejI2ODljaUcxUGRIU3VmUGpTSVRjd3UwM2x6a3preGtKYVdTbjBSVEJUM0l6?=
 =?utf-8?B?Q3ZyV3BNRThseDFCKy95OXE1MmxxS3BVWHFibzdiQmgxaDlMa1Z1cHFDUEs2?=
 =?utf-8?B?Y2twY0lRQXpvRmRlWnFFY2g2cU1GSktxa0gyUW9ZeDFhOTZXNlNlWkNpcFVs?=
 =?utf-8?B?aUF5UWhOZW52YnJkcDdYcEFoT3JLYnptVjM4SlR6ODFjSzMvMmMxN0hMR0I2?=
 =?utf-8?B?SHNkSmxUSmFRTGNJZ2d0R3pUZTlpYlNPSW9NUkNpK25Pb3MwdnZnelhhM3Vi?=
 =?utf-8?B?Vk5na05ZT090bkxvMWM5T2FyRHBEK0szZmYzai8zVm9XS1VqeGd0MWxUckhz?=
 =?utf-8?B?ckF2R2IwM1A0aERNYTJaZVlHdVJJVVp3d1lDVXV0cjJyL28wYkYwdU4vUHFF?=
 =?utf-8?B?dEZjU2FidkNPVlNocWxjK3pyZ3JURUNMdmgzbVlpS216b09LdWlJOUhPK1hF?=
 =?utf-8?B?TW9TOUFjMUdiZGxhcW9Bb1JueVRLR25zS2QvdVYvWjJ6ZFBkUld4cGVZUnZr?=
 =?utf-8?B?cVRkTmNFY09TakhtQUwvYWF3K2F1bWc0cG5HU3ZtTDBQbk5Ccm9LTGhXalVr?=
 =?utf-8?B?ZnlOb3lDZUtCOXBFbTNLQ0dLL2tFQVRwcFdod0dhS1ZXUmsvWXBQclNZcUx4?=
 =?utf-8?B?Qyt4QVpvMmgwNnY4Y01qS3JOMGZTMHRBUlR4ek9YY0FFaUpwRDdQWi9ZVUhw?=
 =?utf-8?B?a0NYV3Y2TWVTbjJRWGJuTGpnR2tmT3I1MzN3b29yVGtidmkvUkh3U1lLQmxM?=
 =?utf-8?B?QUMwenVTQml6QTUxTWJFQWpPSE90bHEzNnJ5NHNDcUpnd0RXTnZ5MWNGNmZ3?=
 =?utf-8?B?WmlrMjdGVE1YdWtDU1hSMWpKWE1rMGFiR052MEpERDRLeHFJUEJhSXB3VVll?=
 =?utf-8?B?d0RoQldiemxQZGNseDFCcjkrYy9zQnZqcmVrOFRacVkzOHJ5TWxpeFRjRGZE?=
 =?utf-8?B?SU9HZmhBVlZFV3ZNc3BjdXFpWFlHQXJZei96MmZpc0ZZaUJxTzB4Mjg3aFhI?=
 =?utf-8?B?Qkg4a01pMEIxUm1xeGhTTmFWSVpvZ1hzMXpiNG15M1BUVnpZaVBPaHV5RytD?=
 =?utf-8?B?Qk1QTmJoczZXVmVzRXpENStOMzlRNEkxdEs5SXNqMzhxWVdpOXlGM0NWZkY2?=
 =?utf-8?B?L3YzdXJQc1lRNUJaTVFwT0VKZ2dJaWl5TUtFWFRIK2RiWWNDNXU2RURlbEU1?=
 =?utf-8?B?SnZpRjBMM3pLbXVmYWtsbXpsTFJuWEhFdWV4c2Q5UmFUYXpaemxKeUV2QlpU?=
 =?utf-8?B?K1MxMU82M3RyNHAzb2FFNmlvZUNpeVpmbit5S2ZreUtnZVBZWWdGOEhIM3h2?=
 =?utf-8?B?R0FwWlZtNWc3anNiQ3RlckJ6V1MyL1Q4TTJqSGUyTlZNMlJoNTVBU1ZLNEJl?=
 =?utf-8?B?amFFRklYTDlsNFNwemErQWVyRnVOclh0RFVsdE92TXBxQTBlKzBuRU1vWFVS?=
 =?utf-8?B?T1NMVWFKalhJdEt5NTRFbjhJY3QvNTM1R0thQmZzTm1CU3JiUkcydEY3Z2lh?=
 =?utf-8?B?NHFjSFVheFkvbmwwOElMM2p5Y0NlWUI5WnVhQ05xeW1Kd0kreDQ5bDR6dWFD?=
 =?utf-8?B?ajloQ0JjeklrRGkwZVBqeHpRdjVuaU1RNjcvRVZJTmFrSDNjZXpJTjJ6QlBH?=
 =?utf-8?B?dGpObXZxb3NGMUxWSVVZZXRvdUFZSE9FZmdsVU8yWmFRQkk1SUV1L1V3dnhU?=
 =?utf-8?B?bUNUZW9mZ1hyNmJHU3hYTUU4RW5MbFVMbUllM0hwdHAzZDdiTGZzWHRleDNS?=
 =?utf-8?B?cjUwcXlQc2hnWk03ZHUvbFhnQVZHRTdRRlF5UkNGN2h3a05lRWJMZFNtM3R3?=
 =?utf-8?B?RmhmRU1XQ2Q3RGYrY1E1ZFJxQnpMa0l3RkFSUTh0dlIwb0MyeTNsRGF2M3Ft?=
 =?utf-8?B?V0VvQzZyVy9uUHJLWUpxYm5VZUN3Rm1qN1pEdTRpOGpJM1RSNzFEZlB4WmFM?=
 =?utf-8?B?TDN2ckpnRmp4c2hnUmt5NDdzUnZkNmtPWU0yNlhKVEd4dWhFYmptVTZ6RFZD?=
 =?utf-8?B?cWVnWmV5YzB4OU1lbTRjenNpZW1ZTFpwT1pXK3JkVDNIblU0TXliQWhuMzhj?=
 =?utf-8?B?L3gxT3ZHRUx2NlBub1hCR21LU1Q3TDlQVGhhTXJvSEd0SVRHbEFGSWRUTnBO?=
 =?utf-8?B?aVk0ZU84MHJNdzIvc0lYZ0VRR3BHV2FQREFEUmJ6Z2VqZkcrWG9LdloxMDRi?=
 =?utf-8?B?WTVGSWJoK3N2YytVMFlyUE80L01XTUVpTmtoWS96Q2tEZnR0dVV3TmFFZnRM?=
 =?utf-8?B?VkNER0Y4MktFTHNrQ0FaL2ErWk43MmJBVjFTSDRyb3NtVUJRc0hjK0hUQ24z?=
 =?utf-8?B?TUIwSUJ4RlJZZTUwN2FEWWREZFVCWC9uUDJlU28vS3FHSTY5Q3lRZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb8452-dd0e-4bce-f9fd-08de599833fa
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 09:25:37.6084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ2Fo2qDyDvA4qlbB7nojGRjB5Vm6EpDof93aQT+x8AAbmY7q9j/8w51KHXXQ+udEd78nYZiY1XuAwS5/WvcDCkZp1+vKkGhLo2dGEt+i2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12286
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

Hi Heiko,

On 1/22/26 10:12 AM, Heiko Schocher wrote:
> Hello Quentin,
> 
> sorry for long delay...
> 
> On 14.01.26 15:22, Quentin Schulz wrote:
>> Hi Heiko,
>>
>> Typo in title, should be doc: and not doc_.
>>
>> On 1/6/26 3:14 PM, Heiko Schocher wrote:
[...]
>>> diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
>>> new file mode 100644
>>> index 00000000000..3b157779a0e
>>> --- /dev/null
>>> +++ b/doc/usage/cmd/sm3sum.rst
>>> @@ -0,0 +1,117 @@
>>> +.. SPDX-License-Identifier: GPL-2.0+:
>>
>> Use the canonical version:
>>
>> GPL-2.0-or-later
>>
>> c.f. https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0-or- 
>> later.html&data=05%7C02%7Cquentin.schulz%40cherry.de%7C752a802f23394270c5f808de5996472c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639046699157004614%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=hFPbf2cm4pcD17T8ORnYC%2FL9VOWm2s%2B8Ebnb6TMjru8%3D&reserved=0
>>
>> (Do not end it with a colon either).
> 
> okay, but I just copied from other files... for example
> doc/usage/cmd/dm.rst:
>    1 .. SPDX-License-Identifier: GPL-2.0+:
>    2
> 
> So of course I change it... but does that mean, we should fix all other
> files too?
> 

It's unnecessary churn so I would say no. Considering I had other 
comments on the patch, I allowed myself this nitpick but if that was the 
only thing I was bothered with I wouldn't have told you. It's still 
clear we're talking about the -or-later version of the license. The 
biggest issue would be with GPL-2.0 or GPLv2 for example because it 
isn't clear if it's the -only version of the -or-later version since it 
matches none of the SPDX license identifier.

I don't think Tom will want a patch to change all 
SPDX-License-Identifier from GPL-2.0+ to GPL-2.0-or-later but maybe I'm 
wrong :)

[...]

>>> +Description
>>> +-----------
>>> +
>>> +The sm3sum command calculates the SM3_256 Hash from a
>>
>> Are there variants of SM3? From what I understood, it's "equivalent" 
>> to sha256 in terms of security and efficiency, but it's SM3, just that?
> 
> As I know, there is only sm3_256 hash. If you look for example
> into include/tpm-v2.h
>   33 #define TPM2_SM3_256_DIGEST_SIZE 32
> [...]
> 277         TPM2_ALG_SM3_256        = 0x12,
> [...]
> 301 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> 

So I would say we should use ``SM3`` here, instead of ``SM3_256``?

Cheers,
Quentin
