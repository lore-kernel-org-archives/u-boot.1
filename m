Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C1CF6A81
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35A983B72;
	Thu,  8 Jan 2026 15:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="TFU33iWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09768416C; Thu,  8 Jan 2026 15:11:25 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D4583A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP1ifA57x0tOBd2GtvTzEPLXLeK5JylKJOwh0Q2H34czikgzPvXIIluVw0jNiUmYZwNkSrC1kYqYALxfe3XDnrve33RNyWB2U1y3NoG7bvm39Y64AFMxjL1taqsAzxIy+rOel7YjMVBj8cZYYcUlTLr+Gc4BBb74JqWZiGrnFis1iyEYXZYBFRhhVNCtRK8bfQpTU6sE/ZK+zbaqv6ApIzmrqScTDLsIIHbePN3sT3tffUfN6D1RXvbusWQD7XlYY4Pw9MdsrcWEVuq8rQMZa0Et8ZRIs/DQ61RwHJTrifBIlKiqnN7rxr3RHxmm8q+GzdfkXRDMMsB+RlU7gCOasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXbPJMx7cGHrfNoqUDsQcPTDMT/gKZNdaH5b3vKcS3g=;
 b=sHd5yvpuXbfY5TNHlQ+ZixJLnFtPOWzc50iW9pOYonGNolvC7Kbv4CQ3zwstBsCZZNsunqwzC3Ou2abqilClbKhKX6F3iVDS0csnKLotKFQhkjtMci5A2B+BS2uTmtIEyYG3r4XTWufPX9xGnxmlChZZDk+fdxoCnAz6BiWxrif+vgJySCKiPKTUlA838lHSuOUxvl4OS0oSHjYTTpd395BoLIulFaZUYWur0HprkVsdor7w9smc+C0D7U62hcIuddUIchc/we4fkIOTFF0LwV2euzrZ/LJrBzKCD+XmC/a4b3XQt9fYEFb+byex8Uz8Wzm4vt58ykwBWO4QrasuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXbPJMx7cGHrfNoqUDsQcPTDMT/gKZNdaH5b3vKcS3g=;
 b=TFU33iWtNx+HS67PvlJLogKV90DCTrGVD+/yPPUSXilr1zQKz1zruVFADke+/1Kg/Bem0l+geawEF9ECPyIbWsHurfarC+Gn8jQrRLaUAXAMmNZP4KYFoz8NQScYyDE9J3YmX13DplHpvX/zDVE+4JMjXH7eLq9+CEA5NNIqb83JwoHZpSQfbvgz6Yk6xbuU78DZVc2FKqcT4S6vBiJlxlJT9emZtqF2pYxwqfDrzhBcXeL+eUgjO+dgRckJSH3bY5/grypUwKkUiYw+yAzKwe+UNNpPCyImbflHM8qAdSPuz9hJsV1wqU39TK/D3G9Yy1/hz5tSzNZOxCf/JFlM0g==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by TYZPR02MB6075.apcprd02.prod.outlook.com (2603:1096:400:25b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:11:18 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:11:18 +0000
Message-ID: <SEYPR02MB5557E469D3FD5DB843C92E2D9685A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Thu, 8 Jan 2026 22:11:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] test: clk: add test for CLK_LAZY_REPARENT
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-5-3eb42b78c7f1@outlook.com>
 <CAFLszTgGFgUoqPMffSgM4XsgQL0rOjeknhxhh+QK-XN3VKYNxA@mail.gmail.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <CAFLszTgGFgUoqPMffSgM4XsgQL0rOjeknhxhh+QK-XN3VKYNxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <0eb33fa1-3f83-46c0-a67b-8e10ed87f608@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|TYZPR02MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f06b4a-2a0b-4043-6976-08de4ebfc95a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|41001999006|461199028|19110799012|8022599003|6090799003|5072599009|8060799015|23021999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFY5OFl4dS84U2ljSjQ0dnlZcGF4eHg0ZHJGQVl5UUVWYy9SRHljaWx5NlhS?=
 =?utf-8?B?ODBCVERXTVh4UWdqdHhNSE5STXBFSTJPOVVmbjQ4NjZUVUpZMGpOR2ZwQlFB?=
 =?utf-8?B?dExiNjNRd3pEc05vZmUrL2FmRXFieC9rOUlaVXpNdHNCWC9rS2s3WmhheGlj?=
 =?utf-8?B?L0pZYm9rVjYwYWI5bk9pdDhxQy9CV2tHL29QY0UrRm9yVVJSVmNycG0rTVQz?=
 =?utf-8?B?QzBtZmhabnNRTmpZbVkxVlJpSTRhbWFmS1lwY0ZIUE1WdXNwWVE2dGF5Nmpi?=
 =?utf-8?B?RjVYeC91NkNTL1ExcVBtc1ZvVGFKTzJwRjNreDM0aVV6a2RZZklNd0lDQjUv?=
 =?utf-8?B?SVp4WUtEbndUcHBjaGxLdTE1ckpiQlU5Q1l0YXk5STdBNU1JQWtmMmlBZDJK?=
 =?utf-8?B?RWttWUNtczVHZDVhOGlHRXhrV0lLQ2czUU56N2UxbkFhL1dnc01mQWZaYVF6?=
 =?utf-8?B?d2tPWWFFeHpxWE9mZ1l0WFFKWWxyNnlKaXNXSHhYR0UxaXo3ajBlb1IxV3FG?=
 =?utf-8?B?eGtlZFZjd1FuSUlpNlc0S0g4U1dCaEdEVktTTUpaN1lsd1J4YlY3MGg2YjAv?=
 =?utf-8?B?WXZXUDVyZkN1elhCR3dzNWV1ZnZlWmpObG5LZFZVMWpkODRlbDByVS9ld0N6?=
 =?utf-8?B?OXpPNysyYXRNWitNVkdPUnUxNWoxakgxSm1zNW5LdEdXVWpDQmowYS9CV1pl?=
 =?utf-8?B?ejJRVkNRS1h4R2I2VFh1Z0pSSjdOYThPaEt2S0pCV2xya3ltN0xld240czBI?=
 =?utf-8?B?RjB6QVA1QVByNVMzczhxT3VCNFBpUFBjMVMvSkJEVFA4QXhaQ293RHM2dzZ2?=
 =?utf-8?B?L0xwbEdVczM5NXVyWXZ1SGorSWRuM0Flb2l5S3BNa0tTTExYbHJoRTNnTmlS?=
 =?utf-8?B?aDBSQTdVbVJ6a1ZCdEk2TVpqcDRkSFBnMy9nbDIvSHU4MFpLeERMNVlDeVZ4?=
 =?utf-8?B?U3Ztck5HTEV3d2ZYUjFFZ2Mvc3JjZ25WQ2RhbW8rNldXTjdGRWRYZ3ZtSWpW?=
 =?utf-8?B?aEZQcGx0QnV1bm5hbmFYMXFmUFJjdjh0RFV5WkJhditYWE5CdjFSY0h6NVps?=
 =?utf-8?B?KzNLQmgwcXBkMTlBKzJYMHd0SEVPUXZET3YrVXAycCtPeXU0VVAybUdZS05m?=
 =?utf-8?B?QzY2TmRPeUZsM1lqT2xrZWVCYXBEc0ZiV0tKQ1BvSnpHdGxiWXphaDdqMEJG?=
 =?utf-8?B?cm1oSU5jZ21TWXVVNmxVY01qWHlibHMxY0lkQ0dYS3hFcVR1NG9maGljN0RD?=
 =?utf-8?B?dCs2Qy9SY1lSTjYrUkthbndCeS9DdEt6UE9FRFJ6czVRU1FtcFlGTXBSbzFo?=
 =?utf-8?B?M0NGSnRwMHNQZXRKdzBIaksxaktGRjl5LzhGMnprV0MyRzVVTTlkNWd1WG5M?=
 =?utf-8?B?S1FsZ3JYMFRBSVErRnZZc1RWNmh2TWtYNUxqWFl6eGUycXZVMGh4WDducmNB?=
 =?utf-8?B?bUdLR3pBUmlKMTVkQnlhMFhJb0FRcFQ0NXVBSm1KK1lNc0U3Y3pwdGZFSVJx?=
 =?utf-8?B?Ry8rUTBaRHRtdjF3bkxPWnkweUxLUDhPelFIQ0JVTG9SbU5wWjVzTVFPbUZV?=
 =?utf-8?B?SXl0bXNhY2hSVjUvRTNLYWVwY04zdXJRZitaTDZmTDc2L2VNam1aM3ZrSDBI?=
 =?utf-8?B?bzJpM2FvYlpleHlnWit0S2l3T2VNQVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJBVmkvL0cxSk5RdE5NSWxNMmZEMyt2RHZTQ2FmM1VOc0RnZkowVWZGcnV5?=
 =?utf-8?B?N1R1SVZya2VEUnFLODA0TXBUV3F5SlhQelJwMGxzWm4xYi92TWRiTjE5UTN1?=
 =?utf-8?B?bTAwOHJxcEE1M0JaNTduNzU1VzAzM3VqV3BMbXRHWDRnbnBIcGI4TGU2NTd3?=
 =?utf-8?B?a3FHbEV6SVFSS3h4TE1QQkpmdkI2Ym5EcXhxRXJxcU1LYkRld0dkL0pHaGJv?=
 =?utf-8?B?VlBia2tvaE9Hd0Vhek5TZXVpNER1TFBRZm5RZ0Vnbys2UzQyRGJ2UCsyZXhF?=
 =?utf-8?B?a0xvbkRyQnYxVU1qVSs4Rm1iZG1mUWNMRGRvTm1DSVhyUzhOZ1hkMkZOTE1y?=
 =?utf-8?B?Z0FtVzYrMjdiUThQTXl1ejFxSkNHUUU5c2FyaFBDM3JsblFHS3d1OXpHSDU5?=
 =?utf-8?B?eGJ1SG9ybnVHeXN0WXliam93L0FaZmVuS0d5RWpFVWZCMEU5aW5udG5WSnhW?=
 =?utf-8?B?M0VEa1VmZnRJcUpZdjVPNXZXRGdXdUZ4SUZpVFdtT2p0SXBkRWZVMDBURjd0?=
 =?utf-8?B?WHB1MU8vWThISUlPME5PeFNDdytkVFZjVmlOWjk3OGJiRVAyUjFiN1U4NlNs?=
 =?utf-8?B?NHVxT2dMTGhaRmRXNlFLZDJNMWFuakVGWXpzQnR1RWs2WTVlRkVRVG5tdU9S?=
 =?utf-8?B?ZzNjcGh5QURmUllPZmtmTzR0bm1qdllXdmhlZXB3OUcxc0JWT01xWitiM3Nr?=
 =?utf-8?B?VUNKUDlweXNlYUZiM09ydFEyNkozM1ZVNUs4Y3ZEL0MrYmcxVzVTOS9EdjNu?=
 =?utf-8?B?UzB5dEZiWDZwS2t4WUEwTmhleFdPZWd6UHFhSVppalBlSW5WWE1OeVl2djQ5?=
 =?utf-8?B?NGxSLzBkNUJFSnFCWU5HUC85RmF3RjdPOUpVeWNMME0yVmtXYlQwRUppS1hF?=
 =?utf-8?B?eW9lOEdzQk5kSGQ3UFBZZCtuYXkvbmJ3S1hqOVFZYit1ZUFlYUFLMEUzYlI4?=
 =?utf-8?B?dmo3UHlFSm1BeFZxdktMVkNvU3B4S3Naeng2VkJ2OWFCWU5kejNBd293eXIv?=
 =?utf-8?B?VHpadUd1TEpkQWJqbjVReG1rbzllamJlSHRRMVg1eTE4Y0NvdFJUa3hBekxy?=
 =?utf-8?B?Zll1MTRnVHdDdU5RUEhHbmkrR1lHL2FkRWZVMzBidlhzdGswdGpENWQ4bEJZ?=
 =?utf-8?B?dmFiMHZ5K0FIdWdpb280STl6UHBuSWhyZ2V6emhlT0t6L0d5SkJnR2UrNFJo?=
 =?utf-8?B?YUdIODdtQlQ1S2plaE8wUVViT01qajVQdXFlZEh0bktxLzNLM25hNXY5MTdm?=
 =?utf-8?B?N216WjZiRzl0ZjdDeDhpcFZnajZHbTI4QmdTRzFoaCtEaERqN09OVit0QUJh?=
 =?utf-8?B?dnVRdWU2VUpmc1IrNmViT2NZd3QzVzA1MXp1bnlZZWd3Q3FQenVPOUFmMlhB?=
 =?utf-8?B?NlhBdzNKOTRTdHYxVTNGZHpTdk5scUFVSkpoak0wY3ZibXptb3pWdk55U0lC?=
 =?utf-8?B?ME9OWFc4L040R29qZm54S0M4QllHeTl5N2FiMHNDOUxCTDRRQ3dMS05NWExG?=
 =?utf-8?B?Rnc1NHdYK1d5eDhTdnFDS2pKTjVSUVRkMXZENVZsWVFEU3hjN0k0M1Rqdmpj?=
 =?utf-8?B?cUtGSmFydjZOMFpWYVNpNitqTzVPQmd3d2ZSNVFqYjNsVVRtZVQrbG1hbXJQ?=
 =?utf-8?B?RW9rQ2x2RUNsczlxdzBvR1pkcmNxMnVaRlR1NzhEQXFlM2JaSHNKY2U5Nzls?=
 =?utf-8?B?MUg1WTJSclk4OXd5OFRTUXJZZW92T1dGWVFVclVhR0RZcCttVnpxMy9sVC9x?=
 =?utf-8?B?cXVXU1R2aHlqZjJwOWJLQzVYdEE1UTBsb2gyNlFuVUlQNjBxb29rR0RYZGls?=
 =?utf-8?B?RjJ4M1ZkSkdwSDUzOW1pNXpNMytlc0k2WXdGdmkreS9ZN0FMSWRGUjNwVkNE?=
 =?utf-8?B?cFlTYzlDUDE0WGxyTWdjSjNYRzhRRFZhR1hPRTlzUHhNYzQ4SFRwbEhMcmRO?=
 =?utf-8?B?Q01FZTc1cTZwYnBzNUwwcDlLaEhBY1VzRGI2Zmh0SlNETVBUNFNERTNCcSt4?=
 =?utf-8?B?TEo3aTJvNlRBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f06b4a-2a0b-4043-6976-08de4ebfc95a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:11:18.2610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6075
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

On 1/7/2026 12:23 AM, Simon Glass wrote:
> Hi,
>
> On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
> <devnull+forbidden405.outlook.com@kernel.org> wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add a test for the newly introduced CLK_LAZY_PARENT feature.
>>
>> Modify clk_sandbox_ccf driver to register two clocks(i2s and i2s_root)
>> in reversed order.
>>
>> The test function then try to acquire the clocks and asserts that their
>> internal states are maintained correctly.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/clk/clk_sandbox_ccf.c | 10 ++++++++++
>>   include/sandbox-clk.h         |  2 ++
>>   test/dm/clk_ccf.c             | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
>> index f96a15c30b3a..3a11b361cd2b 100644
>> --- a/drivers/clk/clk_sandbox_ccf.c
>> +++ b/drivers/clk/clk_sandbox_ccf.c
>> @@ -229,6 +229,7 @@ static const struct udevice_id sandbox_clk_ccf_test_ids[] = {
>>
>>   static const char *const usdhc_sels[] = { "pll3_60m", "pll3_80m", };
>>   static const char *const i2c_sels[] = { "pll3_60m", "pll3_80m", };
>> +static const char *const i2s_sels[] = { "pll3_60m", "pll3_80m", };
>>
>>   static int sandbox_clk_ccf_probe(struct udevice *dev)
>>   {
>> @@ -277,6 +278,15 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
>>          clk_dm(SANDBOX_CLK_I2C_ROOT,
>>                 sandbox_clk_gate2("i2c_root", "i2c", base + 0x7c, 0));
>>
>> +       /* Register i2s_root(child) and i2s(parent) in reverse order to test CLK_LAZY_REPARENT */
>> +       clk_dm(SANDBOX_CLK_I2S_ROOT,
>> +              sandbox_clk_gate2("i2s_root", "i2s", base + 0x80, 0));
>> +
>> +       reg = BIT(29) | BIT(25) | BIT(17);
>> +       clk_dm(SANDBOX_CLK_I2S,
>> +              sandbox_clk_composite("i2s", i2s_sels, ARRAY_SIZE(i2s_sels),
>> +                                    &reg, CLK_SET_RATE_UNGATE));
>> +
>>          return 0;
>>   }
>>
>> diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
>> index c2616c27a44a..0cd735e3ad5f 100644
>> --- a/include/sandbox-clk.h
>> +++ b/include/sandbox-clk.h
>> @@ -21,6 +21,8 @@ enum {
>>          SANDBOX_CLK_USDHC2_SEL,
>>          SANDBOX_CLK_I2C,
>>          SANDBOX_CLK_I2C_ROOT,
>> +       SANDBOX_CLK_I2S,
>> +       SANDBOX_CLK_I2S_ROOT,
>>   };
>>
>>   enum sandbox_pllv3_type {
>> diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
>> index ac56f17b775d..c4c1b6ba758a 100644
>> --- a/test/dm/clk_ccf.c
>> +++ b/test/dm/clk_ccf.c
>> @@ -209,3 +209,32 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>>          return 1;
>>   }
>>   DM_TEST(dm_test_clk_ccf, UTF_SCAN_FDT);
>> +
>> +#if CONFIG_IS_ENABLED(CLK_LAZY_REPARENT)
>> +/* Test CLK_LAZY_REPARENT feature */
>> +static int dm_test_clk_lazy_reparent(struct unit_test_state *uts)
>> +{
>> +       struct udevice *dev;
>> +       struct clk *clk_i2s, *clk_i2s_root;
>> +       int ret;
>> +
>> +       /* Get the device using the clk device */
>> +       ut_assertok(uclass_get_device_by_name(UCLASS_CLK, "clk-ccf", &dev));
>> +
>> +       ret = clk_get_by_id(SANDBOX_CLK_I2S_ROOT, &clk_i2s_root);
>> +       ret |= clk_get_by_id(SANDBOX_CLK_I2S, &clk_i2s);
>> +       ut_assertok(ret);
> Perhaps two separate ut_assertok() calls?


Will do in v3


>
>> +
>> +       ut_asserteq_str(clk_i2s_root->parent_name, "i2s");
>> +       ut_assertnull(clk_i2s_root->dev->parent);
>> +
>> +       ret = clk_enable(clk_i2s_root);
>> +       ut_assertok(ret);
> join those two lines up?


Will do.


>
>> +
>> +       ut_assertnull(clk_i2s_root->parent_name);
>> +       ut_asserteq_ptr(clk_i2s_root->dev->parent, clk_i2s->dev);
>> +
>> +       return 0;
>> +}
>> +DM_TEST(dm_test_clk_lazy_reparent, UTF_SCAN_FDT);
>> +#endif
>>
>> --
>> 2.43.0
>>
>>
> Could you look at tests to cover some of the other changes you made in
> this series? This is a critical subsystem so it feels strange to set a
> patch that changes existing behaviour but doesn't change any existing
> test.


That would need a lot of #ifdef s in existing tests then. This feature 
is optional.

I'm not sure but i'll have a try with as few #ifdefs as possible.


>
> Regards,
> Simon


-- 
Regards,
Yang Xiwen

