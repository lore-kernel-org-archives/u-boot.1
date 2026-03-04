Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B841CEF8FFC
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 16:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0CA838BB;
	Wed,  4 Mar 2026 17:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Twpj7Lfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADB3839A8; Wed,  4 Mar 2026 17:33:44 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF5E83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltfAhI0kHkoKJNJ892sGLq4NUzUM5KHdbb69NjjVI2pO2yaLMTQmewmqJ6hHYAEQqCo5fUuri/dTancxR+3XmL6o+CqMY8Zlyf/bEobW5jKHWjcQ6WjIIxsxs2/5PPc7bIj0nwzXpesAOhQ4Egf7UDlBvHTimitDovsiPKI/qsRDPqDnWAs4ix3CfW0v+dOJz3OUA3JFpZUUAmObnoZ7SmtfiwSmjd1q6mgS+keHBWLFpRRo6uJDq5P4by3wGWoaiW3xWl6105XmSqp1lP3D+jgiASKi7eHBrzuDX75nLZnM5LcjjooHJqNQRkDDPpN+QKRAPetwt0TTQ9WpCO/60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMoCdTDttkuGfUdM42ZN2WzvONAjDE9sNZHSOUQon6s=;
 b=fdxBN/OGl/idRmCnGBc+6moPvP6zbtI4da1ntVEisxmO2O4pi1tkp4MNi5qW12Z2zqlI3j7nsPpNGHyffKplC3eaq4SyuoNRUPc/zjdTsWjSt7+EYqPjZnn/XxwjAEbEJ8Ar8ggO0UasSLDvOQ+X4tlv91QAjraqD4AirlVeOQz1R4QWOIVOwOUX72FRsxl/lwbB+E7ES0FkP5c3d7qpi1Cc09yvzpeotP9kjpqbm7Ae5fnanhSOH+K7X0ceQ8RbbCpSkCO2VG2i9vvJ7a9lDmjmSuS6tDw3wgDIFD39cZlscdt1rcfn9Ml4kLo+xtvX1xmCljRrTFJHpXNYkcsseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMoCdTDttkuGfUdM42ZN2WzvONAjDE9sNZHSOUQon6s=;
 b=Twpj7Lfq/ggglAMKoxKg20g40nbKrCItJcIUC7RRDydPf/ofU3aJXc0jJU6x/SklXiDYFCvETDLn/yHmEHbb1pkOYcCap8G1zxgqJ/kMAGgjs9GRsMR73TGrgtlEmircGtHiR2jIY/aBy8Uhb8UFLD4wSa2xADAZMfksJcOrmq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10940.eurprd04.prod.outlook.com (2603:10a6:102:480::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 16:33:40 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 16:33:39 +0000
Message-ID: <ff92c314-b0fb-48ae-acf1-195ecb3163e7@cherry.de>
Date: Wed, 4 Mar 2026 17:33:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
To: Sascha Hauer <s.hauer@pengutronix.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260302220937.3682128-1-trini@konsulko.com>
 <aaff4oDKlkINa8H7@pengutronix.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aaff4oDKlkINa8H7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0060.eurprd09.prod.outlook.com
 (2603:10a6:802:1::49) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10940:EE_
X-MS-Office365-Filtering-Correlation-Id: e3597b82-95d6-4ebf-7e46-08de7a0bca97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7142099003; 
X-Microsoft-Antispam-Message-Info: hFUUGYa+XTuiE9ZD29g13xBrZt4mx0KW+MiFDmpqtc2/p+z9CNcsFoyUWQ4Sv9sMNy+SKfBBIF006ACXKSZp4m9xPJ8JUmx/FsujSg1r1ovTehbySUvyqk9AUGvMXgd8w0uTyMdc2CiJpStjKVlDcJXOLEEP97F+5Nn1dTHfzoB1nZEt/rNZ+jqJIyLiFspRFdCufXIMn16kK1nJkb4PDQ4T6ZJmuXVwjH/UYO3xXhMWYi4w4foNSCn1Srehurl84jaKr3gMTYo1yic7q7+oiDp7N3fiTDa43Q6omLgTmrEQG8A4ZtCq1XMjpWhwqvGPyw4MQOqnV7gp7cCy+gyOq1J8rCJE3fcNCIzuKft/EZPrwS4wt/CdPLehnPULAXn98sIP8BnJIzmV93nj5q/Cz5eECs8Lq8kVxc4JfGtzz/Y5m29MklMfdCV+kC4Xz5yaFWLJFc6c1Oy9QmwAmWRJyrIEVV+gVOHHjuEXQZ7ESD/YWcLTfcvjrQ06InBHB7psT3ZBIaoisQlLF1IcYrwLL4LLu4yk7I3wz/06pkOdKfZZyKcWtPdhan26A3l37XDoWlj7wlFZ9krtM3/WzFIWVT7g8Wy9EcWyobDU3brn1QYYRhLiYntMGbRqf/kmo1nuKmXlsFSRLYccztCdoIPL1nLlLRkhYPIqYD+ynoCicm/j9UXmoVvxxtXsdOtkyQxjz8goq4qUHkqV7u20sJjV1A4HKyIN0GrHnS9EZE/A8EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FLMnoyeFhLL1FENTl0VjM0QkNJRStobVhobVVkOHg3OUZQYlJCRUpXWlBj?=
 =?utf-8?B?TFFiOUx6WkU4M0Y2emRlK1JGeE5uVytJZklVSmx1QncrakN6OWRTa2xQVkN1?=
 =?utf-8?B?cjNhVXZQaVIvd3YvRjBWQ25tWG1ZUVM2bmQ0QW9jM3NyOU85NmdDTDJuanRO?=
 =?utf-8?B?dWp5VnF3N0NjdXJHeHNhT2RDbTVrMWl4ZWQyaHRUTzdBUFZPQzJ6NXV2Y0Q0?=
 =?utf-8?B?QUpDNTI5emtpWkJhSk9aY042MW1Yd3k0bC85M2RxMkdSUURJZUtsK3FJQWVz?=
 =?utf-8?B?MG84MG4yYndva1NQTWZCbmYzVFkxMlpYNEpaUWRsOVRuQ0RTQkdMdUpiMnVV?=
 =?utf-8?B?Y1FkVXZ1ajFKRmRGRnovRDFjR2R2YWlxbWlJZlZSdXNCbTNNQkZUcnArc2pB?=
 =?utf-8?B?NnpDR1lqN25xNlFiUzR2dFBBTXM0ai9lVENnZ1c2ejlweWFVQ3RqZmNzLzNN?=
 =?utf-8?B?QnNSdzNNUG5GdXcxdzNXc1R2M2RsZENBZm4zbS83ZnJxOC91amZTdGxDb3hx?=
 =?utf-8?B?aUppbXJaMWdvT1NSSEMzNjRQS3lGM3k2TTNRWmZ5VUlIemhYMTJqdXhWK0JI?=
 =?utf-8?B?YUVmWllqRXNMQ0VMUlFQZWlyUnlYR0NZbjZ4Ym14MEIzd2dTTmVQV0tMNWYr?=
 =?utf-8?B?QUlYTDRTRW9WVHNPYldGQlBpOENnMU95U1hReGxYaVZnZjBsUUZOZU90T2o4?=
 =?utf-8?B?bGlBZ1BRa1RmN21nbmJ2ZnhsTFd5c2RvdHJrL2E1bFR0bU9LWWpTckJpMWZC?=
 =?utf-8?B?dUpCUHhTaXdPUE9mRkgxU013WXNWUFk4dUpXVS9VcS9rUC9DRmdQbFY4TGxP?=
 =?utf-8?B?YjZJeTdSL0xkeG5GQ2VEdWltWlMrbmNNTTFLU0c1ZkU0YWdrb29vWW4zclBz?=
 =?utf-8?B?M1hOdXdvWkNYMjQxU25BaEpZSFNhaFhSVnFhRUFHTzZLRFRtZk9nOHBLazkr?=
 =?utf-8?B?UnJjdnIwaTVTVFBsZmFWMUJ2Z29Ibkp1N0dRdGo1NGJGbS80K1BKcWJWUUFz?=
 =?utf-8?B?MVhuSkg2aFdnRmhRbktEWStZOFJBWjV1MkluR1M0MHRqYUxHYWE4TmR5VUoy?=
 =?utf-8?B?bVh6SHc2anN5UzE5dEh4cUxaK0pSM25QMFozbnMxYmszeHIxOEp0bUpPbUpm?=
 =?utf-8?B?cmhoNW1zNzNJTVNtRFp1ekRQNnIycmpPalVrSUpiWnErZlUyblZLTmpqd05G?=
 =?utf-8?B?WDZ5NlFtU1h3ckF2L0dKaHplLzVvVG81a204Z0VFV0RkamtUVE9IT0JsMVgv?=
 =?utf-8?B?TUJPSGVhSWQ4VEplbU9ZZjZ2elA3dE40SWZHOTM1N2hMQTlrMG9hUVVpbkpM?=
 =?utf-8?B?cS9mMytQdzNmdFE1clR2ZFdoajkzSW9COUltWTVMOEp1eHozdHNHUG1vWHdM?=
 =?utf-8?B?S3htRlNvVzhibHJSeXRFbWNBY0FwNmgwbEJNVWN0WmRvRVJhYVlqQ1ZUTHN5?=
 =?utf-8?B?U3ZwdTgxYnBHSFN5VDA0VWtzZ3F3N2tLTnlaaERoOUZhTVRtbGkwOXR4Mmp3?=
 =?utf-8?B?VlpwejAvQnlROElieDQ0MHQzZmJnL0NmVFVBblNVUGhvbXpuOXlsc3BqdW94?=
 =?utf-8?B?cDJEQitVUUFsd1o5aXVBYXRCY1BXZnpic3djNThiSHgxb1orVHZ3Sm9YcE5h?=
 =?utf-8?B?SS9vQi9IYXgzdVB4NkhLWkV3OXBkeDgzOUtINVpkOWR1dytqZllGNGNHUkha?=
 =?utf-8?B?RzdDMlN6VFJGT1dYVnRvTWlmZzNWMHRubytvWWNOcUpZdEdpWXRTMVlVQUti?=
 =?utf-8?B?UXhJdDFyYkROekExK2Z1Z25LKzhIMzBUUjNQOGZ6NFc3ZHlRdDBicWxiY0k3?=
 =?utf-8?B?blhFd25sblVOb2ozRkY5bk5ET0ZySVgxSXp3QkJYSEIzRlQyV25hWEZiK2d0?=
 =?utf-8?B?L3puOWMyTWdXNzRDbFlkUmc1V2xBMUs1SlZOSFA2SnVPRzZhTTFpYTZIWCtV?=
 =?utf-8?B?MUxScFUvRGxvTVdGcTJXbHlDNlNRL3cxVlM0T1VSTlgzR0VxVzlDYlRyUFBE?=
 =?utf-8?B?bGJiMldvNVcvZFpHODUwYUhVcklkUEhBNDFUTEdFOEJDRkNXcXRJVmpQSXgx?=
 =?utf-8?B?RjBOYW1ldmdmZkhGbHBkd2lodlVlV1lpa2dKOFg5Z1kvc21TV1JoUVlnZTNO?=
 =?utf-8?B?OVMwMjI0cXFoc3dFbS9HU2RCanM0UWlrS0h5UGNYNVhERlB6TE9EQzl0RkNX?=
 =?utf-8?B?b2w0SUQzWWtSQzJkd214TFFjaFk1bDZLSUw2NmlmbkRyV2xuVzY1T1UvNGFF?=
 =?utf-8?B?ZFJUblhuQUZKR0E3bGNUWWowMVRQQ1VSbzdBeUd4Z1JxU05CM0ptL3FpeHRX?=
 =?utf-8?B?Yjh1UzN5K041NlVPQWhyT0VEbE56blU0VHVGaE9qei9LbTMwTjBCWVYrZDR0?=
 =?utf-8?Q?Bihr8Dct+0iLaf8Or0rJP9Mx+iRxCbQ/5OXGi?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3597b82-95d6-4ebf-7e46-08de7a0bca97
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:33:39.6665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2PAUQerJ+hywqeeaPnsFcYElfzmt3oxUmL/tPOHVMZuatuixu7b+Ju1uLCyPHHuaXuBrRzhI8ziOzYM1Ns7Gle/UtzGjEKvAk4o4lQpc6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10940
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

Hi Sascha,

On 3/4/26 8:31 AM, Sascha Hauer wrote:
> Hi Tom,
> 
> On Mon, Mar 02, 2026 at 04:09:37PM -0600, Tom Rini wrote:
>> There is a flaw in how U-Boot verifies and generates signatures for FIT
>> images. To prevent mix and match style attacks, it is recommended to
>> use signed configurations. How this is supposed to work is documented in
>> doc/usage/fit/signature.rst.
>>
>> Crucially, the `hashed-nodes` property of the `signature` node contains
>> which nodes of the FIT device tree were hashed as part of the signature
>> and should be verified. However, this property itself is not part of the
>> hash and can therefore be modified by an attacker. Furthermore, the
>> signature only contains the name of each node and not the path in the
>> device tree to the node.
>>
>> This patch reworks the code to address this specific oversight.
> 
> As this breaks compatibility between old U-Boot and new FIT images and
> the other way round it would be good to introduce a version field to FIT
> images. With that at least newer U-Boot versions could print a more

How do we decide when to bump this version?

> meaningful error message than just "image verification failed" which
> gives no clue what had actually happened.
> 

Here, only signed FIT images with required = conf actually won't work as 
far as I understood, the rest will work as usual. So we would need to 
keep track of which version(s) of the FIT are supported by which part(s) 
of the code, or error out saying it is not supported as soon as it is 
parsed but it actually is supported, making incompatibility wider for no 
reason?

Not saying it's a bad idea, just that it's not as simple as putting a 
version field in there. Also, I'm assuming this would need to be part of 
the FIT spec. And I'm wondering if this isn't rather a shortcoming of 
U-Boot implementation for FIT signature verification rather than an 
issue with the spec, so why should the spec bump the version if an 
implementer got it wrong?

Cheers,
Quentin
