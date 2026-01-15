Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFC2D4115D
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 10:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7898B80325;
	Thu, 15 Jan 2026 11:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JQZBimY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C62803F5; Thu, 15 Jan 2026 11:34:23 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6003080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 11:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeWqWbseRUGc/6G3IXFDIHzfVqJYrpAwxm0xrL4rSOAo32P1kFOpP6HI/uskl1q7VftX4AwijO676u5Jcb2/O8sW3nPVvBiL26vcWElHduWuB4v6WBTBv3AVTty477+K6IBPQaiI09kXeWhoDj1NTn8FVRyPJfmzUgAbc5JXmTtWOrZR6BQQviOSeLxINgFMaBJ1qDCiFAoWvA0SrVJdssQi6/VQFzaHmAs7sCFxitMu7gCMw5Bc2MiuliAWHqCSMi4EEqLVNsPKDHoYusTpokntPlI2WYb7Vb07HkN14u9+Jpd658E5YrwXYncbJfr+VbMIe96FHVyULjrjfWB+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00Lc0tNLqyA8hoiCFNC6uR6xi3m7GUeTDjDriLiOiP8=;
 b=lQhGZh/erWWdbRRfU5j4Kd7181PTKyHHqwexy4D6obkN7k2JetIXLCVBuLLpSCgQwc0PETudeoW1tV278hHpBHnxheJsAiMPJMGvPk0DmzsuG/fx7uKLxQ9Z4A6ouGkKca4SZbNh50hWnBoV63NEI1/7cJkKgjNL7cJ9rlsu2LPWjRGZ488FsWpxVYLRk3m6MVgORBWgLUBWUIttPzslYoepJqmkc89qsEbuADYCoh3hLDXu6/AMSnaWH5okQoc5AugHSPlzs4r4Y7mCTvngTix9hQJHO8K0dnYcq79R8pm5Obtz1VumU+vUvncmsJeQ2rFqaMFwR+Fr08RRYVXzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00Lc0tNLqyA8hoiCFNC6uR6xi3m7GUeTDjDriLiOiP8=;
 b=JQZBimY/Zbz7a/xFFRzfVuWdI8DC4ggYWJyaf7Og7iHdrX2/tV2G6OEoWDKt1qjaYTkMXjdNxKsZWnlc7GlqevgxCg9DU0IwDCjGpjvR7KcSukyocKs3xsTUfOrMzvLKPqRXrugzAepR+VTPgRKbq44Jsfk+KSxgwser2nZ0AFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8591.eurprd04.prod.outlook.com (2603:10a6:102:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 10:34:15 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 10:34:15 +0000
Message-ID: <cd629f5c-f69d-4b87-908b-aa323c78792e@cherry.de>
Date: Thu, 15 Jan 2026 11:34:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260107230747.3552391-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 66069cae-e448-4dc1-227e-08de5421a13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2lzWXFWbHBJMlhkSjdZd0I5WWpBL0RaVGVDL1AzUE5HV3BMdUZUNWpaRnNW?=
 =?utf-8?B?L0crRE1LcFFUeVRkOFJEVWZzWEZYMXB3OWxsRllybUNFcitPOHEvNFRUY0Rt?=
 =?utf-8?B?bUlkVjhWT0FFNUwzZkptTURXQzJESjI5eUdndDJtYXM0ZXFEWklmWTVHNUVS?=
 =?utf-8?B?MElyblM4VTJvVXNucGQ2N25zeG1weXhhZll4bXNhbjNVTFlmVDV6akpWYTlN?=
 =?utf-8?B?eUpkT2RIUnI4S2MvRHJqZW5tWEhIUEY4ZHpaRzBhTmhmeEROVThFeEptaXlq?=
 =?utf-8?B?ZmJieU1nQUJIUlZqc2M1NFVXWm5WUC9pSTBRckZNcHVJU2o0WkRmVHJ6VmYx?=
 =?utf-8?B?MlNVMC9va3BJczBncTlkcG83T243NkcwSEFzU0xFdXl5RjN4RThkNmw1RWhD?=
 =?utf-8?B?UkZrKzg2SE5YK2trNlQxL3RHRVFaWUVDSnhPWjF2QXlrdVNGRVhqb3l2ajJz?=
 =?utf-8?B?WCtmZWNjaWJyNlQ1QXd3NzRqRXl4enlPU1liM2Jkc2hHTG5hQko3NWpTREdJ?=
 =?utf-8?B?QU1pTjRNbS9tZ1VzMjYyb2t6dVJBNnFGTjNpQ2p4M29ncmxuaERWZlhmcDc1?=
 =?utf-8?B?YzYvZGNDbzR6UHE0SEYyZXd6dTVjSTdWa1cxZzZNVlVtMkFWc29IaHVTNE40?=
 =?utf-8?B?S1hFV0FxV0ZzWDNXdGZhRjBTaHEwNTVEbzh5eklPVnVPK2d3UDlMeXEwOFhk?=
 =?utf-8?B?bzJCTERHTTMvV2FSR1JpaVVUaUdQZnJhSTlBc2pCN3JNVnpnTVhpcnNISEQr?=
 =?utf-8?B?eEJMTGdTWjJTL29kcXZUK05YS0ROK2xUSW5kNWhxaG1FM08yQ0s3ZHRVb0Zh?=
 =?utf-8?B?OEFaN0Y2NEpWM0oyRFgxLzh6aFZlejBWUmlOVU1jYWxWZldPOEVjcEM3aEta?=
 =?utf-8?B?Z3ptVzZNZnpyeDlqRm9SMndnUEY0ZUZmeUtXa1lkZ1NwMk96bDZVZTdSa0ZJ?=
 =?utf-8?B?ZFFEaXRpSU93VEVlZVhvSWFqd0lwaENIa2cwdEhSQ0tsSnJnWk9QM3N2TnpS?=
 =?utf-8?B?c2pXVm1IQjNYZHJvMkx5dVVKdTFMNXgzMVF0RmN0TVBtSmdUM1JlNERRL1Zr?=
 =?utf-8?B?MWJ4QndqLzU5UWVPZzRrc1JqYVNGYVBKeUlETXFxRFpVR2RVMVNad1BPSGc0?=
 =?utf-8?B?SnhWai82Rld3ZzFUUU5Ldm51b3Y3MnlKdENHR1YwZ1VNWVZldnNVN3UrZUdz?=
 =?utf-8?B?ZEV4NW5CcXFjUTdYalU0WDhsRG9BNEFvVlBsMUlzWnVSZC9aNVAySW1Ba3FT?=
 =?utf-8?B?a05TTmp6d0YyNSthZ2V6SlhkSWxNNUxaZlp0bHJ4Q0tXVUVOMzMwZzVBd0F4?=
 =?utf-8?B?RnRQNEJUT0sveXR5R3JhK2psSjFQa2syWFR4NkczZXRxRFdlcUxEeDlIQXFY?=
 =?utf-8?B?TmlzM1NrbWR1d3RHdzJoZHlLY3FvTkplaTdpdXZFZmFuTWkwYTlSOWdVeity?=
 =?utf-8?B?eDNlMEsvSGlwV0laVGRQdGFYOTYxeEo1SjdVdG9SWWFvc1ZwdFF0d3JzMkM1?=
 =?utf-8?B?OWtOTjhtRGhKZUcyWFlRbkw4akVwOEx4czRUTHNhL3pjRWlQTjk4T3lONXp4?=
 =?utf-8?B?UTdyckR4eUtEZUVyT0VEMFNHZ1FkMUhKb05iMmoxd2NJYXpveWczWlE2encx?=
 =?utf-8?B?eENYKy9iZTBDNnpueHd2eXlFZ3NiSkFLbmJ0Q0N3MDdEbmdpT2dEUTl0ZmF1?=
 =?utf-8?B?SmlEOEs5YXVoRzNnQ1NjeGE3WHV0VVI2Nldja3Z2QnM4ZlV3ZUxNN2NvQWlN?=
 =?utf-8?B?elFKSDB0WjJCZ1lsNEhsbUs1dC9NbDBENDUzQlNQdGZuU2haMUJMUm5OZEVv?=
 =?utf-8?B?QmlEM3hkdUpKZkJaOUpHRmhIQjZjVjg0SWhUWkluZy9RTHdENzg0TWtEbklq?=
 =?utf-8?B?MkZLbXFpYUZVcEJIVlZ6dE92dGpYS2VTNDU4TGoyMld1bjZBcnNja2l1Rktl?=
 =?utf-8?B?bkIweUQyaE1OYkZiRFdzUVlwbW5HU1lXSW5JT25NSHM2MmVveWtmU1dxd1JW?=
 =?utf-8?B?YVk3VHN1N1VmT2xtT21FTGIxbkYzRUtMc2FjRXpsdkVGQTB1dzhxUitCZ2pL?=
 =?utf-8?B?NklXMkI4NGIvZFJ1Nk9DZWIzY1p4OUpKSVkyZ0pSd0cwNTR0Yk5kK0JkK3hO?=
 =?utf-8?Q?w6xw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2puQmZoQWI5c1BrTEJqWFI0SExGREc2Rk1kbVZITDYrd216aHRCNlZBTnh4?=
 =?utf-8?B?cHZqR1d2RnQ0STg4dkpnY0MzZUtyRGthK1hDWXRYOFp6UVFzc2tzbG9ydCty?=
 =?utf-8?B?bmlQdVRaazJzanY0aWtoZ0ZsKzF4NWxHaHNXeHQwcTFXdytJYW1nSkNiN2tz?=
 =?utf-8?B?NDN4WHJmT3JsOERudEp1VC9vMzhXSVppNGJya1JDUjRQemhBc1ZuR0dZdFJG?=
 =?utf-8?B?cjhEREJZMEZUdmZUSnZGZXdmaFBoSzR3NnRmbVhIQllOZEVuSnpCVGRCKzll?=
 =?utf-8?B?NW9PVWhia0hzbEhpblZndGZGUkx2ZUdPL0JBSU5Td3gxVHV1M3BOUXVsOUhT?=
 =?utf-8?B?US9JQXk4a1psL1kwQjdlTko5bytiUzBUMlpSR1NOV3pRd2VYdURZbUNSeVFL?=
 =?utf-8?B?V2lnN2NYd1E5emlXYUszQldzUjBWRExTbnkyMHZicU1SL0x1Umd1RDhhS1dZ?=
 =?utf-8?B?bFZvTEtBTDZMRERGeE14S2VuV0pSa1h0bVhSVWkremFpSGF4bm9LQnpBa2NL?=
 =?utf-8?B?QlgrWEx3T0loWjMzcVliOUZXdXdDTDdlUzdrcURVK0dDZ2JNdVFWNVEvM3FO?=
 =?utf-8?B?aE94N2hhcnAybVlBSlpIZUxKRnp2K0h6U1kyZUhQV2c3R21vTUFzeEFSSi9o?=
 =?utf-8?B?eCs2MG9oblRrZUY2bmJFZlE5eUIxOUMyZVdOZWFqNFFLY0RvTzVWV0VkOEdp?=
 =?utf-8?B?UVFwVERsK0RxU1BFQjArckFxd1drUzF1a3htTnlRbEJmRjV6R2VQalRPQSs5?=
 =?utf-8?B?WmZldUl5c3FTb1QzOW1ISW82dnErTzBGak15bklrbDV0S05MRHdVaHNzbG1u?=
 =?utf-8?B?Z3JVUVNsRHJjWERqdURFNEViNDQ0MDNVdkw2MGs5KzBDNFNqRll1cUZKNEx5?=
 =?utf-8?B?dkY3Y2xoRDJIdElVa3l6Q01DZisvMW43Wmg5ait2Vzl3Zzl6UWZJLzJNUlVs?=
 =?utf-8?B?VkdtTVd1VGxOR1RkajZaMzAwcmhWSkxmSW1iL1Bmc0hJbmJFVTVyRERoMjkr?=
 =?utf-8?B?Nzltazh3TVVReExIU1g2VUJ0cTd2b2kyZGw5VU5ZUjJIV2FPYSswZzBzU3ZQ?=
 =?utf-8?B?cUplRDRXWjBhRnRLT0Q0UnlvcnBkS2FLWnpiTkdzVngwdmcvZTg0bWJMQWNH?=
 =?utf-8?B?bStFTHVjWm05UzQ1blc4UnBnS3EzUWhTUVNpOEJNSkxBWXZTYWVHMVZkQ0xj?=
 =?utf-8?B?Rk9TUGFENkpnWFovQnRzVm1VU3lTOEVPa1JyenFmVGQ3THNJU2V3NFozMldq?=
 =?utf-8?B?NHI3VFp1VTVNMWJCOXh0ejFROUxNQnp1THBHa2RMb2owTXlkbU9oa0V5MXNk?=
 =?utf-8?B?TEhUZzJIUjVRN1BSTU9GbEFEQnVyTzNpZVNZUDFHTVFxOTVJUXVXSjcxQ0JJ?=
 =?utf-8?B?ZUJCRU5GVmxmcVNNbmN2SUdiMUJNZWdRcmVQbDJoT3k4U2JoQ1RvVjBRbHlr?=
 =?utf-8?B?UDMzbFVZVm84VHVQbTNsOG4vT3I0VU1CV2dERnhOK3FhTitZNFdlLzFZeGNi?=
 =?utf-8?B?N0puS3NCSkMyNFR5ZFgzQ0k4dnRnU0FKMW9vM3VjcGswa2ZsZXJTcjNXakd5?=
 =?utf-8?B?QUU2RWtQZTVxL05NK3RCSUU0R2hRS1Jhb1lnSlBKWnZHc1J4djUwaXFqbTZh?=
 =?utf-8?B?QzFGbStUOGh2aVJXYWNabVJEdUlLMm8rWFYxajVXbVNrQWxUNnlQeEtITHh3?=
 =?utf-8?B?enBSb2RmaTZoVUc3K2VPZ2VMTmh3SjRENllMejM2N0FRbkp1Y3VUc1hnZUQ1?=
 =?utf-8?B?SFllQ0FWMi9PZ21tUFFjaFFtSnQ1RUdZQTJBZlAxalhrNTY1bGlaQ1BOMHhj?=
 =?utf-8?B?OWF1emZTQTFveU5TSTFpa3ZYcXlIM0RiWnlndXU5N1FoRm45OVVIajdNVmNI?=
 =?utf-8?B?U0tRbkFDaHNqNkN0NkVWMmx1Y1oyN05RQlpHMGtpKzFxb0VuVEdVRVFpcWlY?=
 =?utf-8?B?dkIyM1pCK1JGSXpvWHMxb2RoOG9LaFdqOW5SUU9VaUtheUJpWVcwZlFGNXp5?=
 =?utf-8?B?bVpzRUh4SS9YTFMzQlVLd2lNWGR0RXJURzlvSHI0ZDlEQjdVMmxFL0E3Zmx6?=
 =?utf-8?B?cnJNc3ZNbE8zZWRWb2U1TjhiUFRPVUlxWDlNd1l6OFN1Mit2bExyTHR5VWxZ?=
 =?utf-8?B?TUgvZkVNOGlFeE9WZm1Nei9mRW55Z2hqMG9XdHF2RkdLZ01OZHkyd1FZS0wz?=
 =?utf-8?B?RXZVZEdVYVdCOFpZTmVPTGlNekNkTkt5MmlKd3lNeFcyYTRUb0Z0ZllIem94?=
 =?utf-8?B?UU5WTlQrOXV3cjVKVjF6TS94aklVUUdiTlZDREV2RWVMSEJkUXNMU0xmNUhY?=
 =?utf-8?B?WUs2Vk41UzhkWnU2TlZrZS9BZC9YMUFjQ1dPeXQ2bEM0UU5jZVh5QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66069cae-e448-4dc1-227e-08de5421a13a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:34:14.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beUOcNpZsyzDSqNlQ5dspr/5FN6SgzjcqZEsKTYF9szyzqfrIAEfiRFFqS7IoPqtIWhwwyVZrS7Jgdgd6zTPhSoIbW1+SouiOutm2Q1ebXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8591
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

Hi Jonas,

On 1/8/26 12:07 AM, Jonas Karlman wrote:
> This series add initial support for RK3582 support. The RK3582 is a
> variant of the RK3588S with a few ip blocks disabled. What blocks are
> disabled/non-working is indicated by the ip-state in OTP.
> 
> Compared to the vendor U-Boot variant, this mark cpu, the gpu and
> vdec/venc with status=fail instead of removing nodes during DT fixup.
> Linux skip cpu cores marked as failed staring from v5.17-rc1, however
> the GIC driver will generate a harmless WARN_ON that safely can be
> ignored. A patch for Linux will be sent to skip the WARN_ON for
> failed/disabled cpu cores once this lands.
> 
> It is recommended to use rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
> as DRAM init blob RK3582, listed in latest RKBOOT/RK3582MINIALL.ini.
> 

As opposed to what?

I see there are 2 DDR bin and 2 eyescan DDR bin in rkbin, but I'm 
assuming at some point there'll be a newer release so we need to know 
which to use.

I'm assuming what matters is to match what's inside 
RKBOOT/RK3582MINIALL.ini? Can you add this to 
doc/board/rockchip/rockchip.rst maybe?

Cheers,
Quentin
