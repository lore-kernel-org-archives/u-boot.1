Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50504CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 15:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC83F84663;
	Wed, 13 May 2026 17:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rkhYDc4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326D384676; Wed, 13 May 2026 17:14:46 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B66983EF9
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 17:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPBwPBMvzP6r/hZ0WHfTIxcWwQe0HJtAPyV+VpoEXf7vol4FWBzyi+0EorVoTb+xXN2gw/3OnMSDTui6tNzwF37AWzQpN4tyPk3ddApCHqpDYL5Q6oD9LvgIw00z7QtaSgN73NISdAOObDdnzUQES3W6MtdnA+qqvwPLj1Rya1e9ymRyWWIQH7I6J/WzQdtNdhlQ5STNoUkOG4CG3VsMfriud/ghX+SGO3Xe4fyAJojKC6f4cKrGApyMMIamxNj5dU/5zgiP9pqxt7q94WfvGy2N5WAb2BvZ7BjcrdWvC+PgWzyYA7f4PU2j/kS36n/eA6GGxLVcNQ0G+5B+lfbeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HRdLkUMFG3STVYhjq6wOArg2jt82gxkdikuU+o+bns=;
 b=MDQwkuwnVt2+aXIoa0wMZR4oAoywWAwM2Jfi3fRGz6bcAFmIUn5d/rvkJ/CoIzTwb2bnFH6v4yVp/3LuA1co0I0WgkblLtrIVei2p4OMt1quTQW5ayFm+PY8MPGUz0SlV/6Hxthgbr+34o/5a/x6inKIv9gUMZK66+SaSxYFmbbhL1kvjCrslh4uaO7hYyQrHk4QGjm2VQQ0ZGj1H5s7T8vDhseoAzPD6mbnkCz4OKDG3l3qnZmpi6B43+Z8cnBXQ6v8olq48yDtShfhBfLflvMk41v7CWZQGwq1FbFbEX5uDO6rjj82NzA1TDWtYgU1xG95ddUuAyjytzFVok01CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HRdLkUMFG3STVYhjq6wOArg2jt82gxkdikuU+o+bns=;
 b=rkhYDc4u7HyysKf6RMdwk5lPJ8rkjuyMPE7V7qIdJh0tKoRn/4VwNd3Wc9Fu3paInIzwcml5UHGVvMehkmbK5TAJr0PCsRIPeIxv3HiFG3ZhGniM73bi9enwS1N/rizou6BcYL6KVnnHbV0yf1ZMpiXkUovPHk304RwvKEKagOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:14:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:14:16 +0000
Message-ID: <effd263e-bc3c-4f35-b710-783b08d82515@amd.com>
Date: Wed, 13 May 2026 17:14:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777984225.git.michal.simek@amd.com>
 <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
 <CAFLszTiYJU028+L40rzNa=X-qqDYCfbPqYMfGhzpK3Xq2mr8ag@mail.gmail.com>
 <cbadd601-4337-4eaf-bf6b-8c98645dc089@amd.com>
 <CAFLszTgZzZ8LHZ5KWMWqx2a54dPLBk1V86AxPGd=jEK1PQrPpg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgZzZ8LHZ5KWMWqx2a54dPLBk1V86AxPGd=jEK1PQrPpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0166.eurprd09.prod.outlook.com
 (2603:10a6:800:120::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: b9eeddfc-4f86-4232-234f-08deb1024c3d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: oGK6z5mbPU3nqfsK2FyX+7xdx0QjB7qaDBRJFqCzDnHHWczmLhNwzU86EuSkR2x1BCBBkQ/CVmEE1ELVx32ikb0zUeQOl0vU+2mwGJXLKgUOGu59//xkq633Wu+HoeCMi/oO+4llpthBzrPqiVnmeI1p08MYrbJDXZ26XfNklwgwk7nKf0yXrtqgmuB3zxpzb3DTQwXw9ySBH3oZfNeCUDuVuQK+UV1zbZU0eKL8yWS9yCX3ChQACkUxs5sAyGLTyLS5DoPnWZf1q/158nl+znJcnvPB51wgsHVtgUIvZiN9iWUXmYyajE15CtB8CtTNf2ZwAJBuwMZLfP8n600vmtgM/WbCDd5E3jtF9cWaNrWHMvsNskLDY/Lw3fl5ugfN1w8psXnpOr1aEkKtQ8UgKDhZ/sVQFV8V3XwqxlZW+U8W6iX1aaSTUzZj6mcvJS8HYHkdGcjunbXkhYBQebaX87umFhl2ebiZiKFFKfER2PoJlwREee2Pb+KIgOPjSZBCYk+66NwCvdkPSCoaC8bYOouEK81Tl9G9650VCqXJKNpojcr6W7JeERZDM3kggL5Sy3rsfjRjMMVPdkZkLF5k2QMG+syw0IsbTC+VGzW/GQldXf3UkEvYWran4nFdYTnfnT1ewmjYqqAQe6AcLiTCdingKpH3nLf8ZsbA7plN42j5obDIcAB/ann4qNcVjlnA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VxVWFoYXJ1cVFNb2IwS1FYaE1xZHJZdjRRaXZCbk9tcWE2MVdqQ1FVNlRJ?=
 =?utf-8?B?Y29qMVdMRFk5MHowOXFZZCs3NndEL1hiei9BaURmK21jeEhxV3d5ZnNZSjlI?=
 =?utf-8?B?UVZzRWtTMmtEdEs2THRwa2FvOEcxaitqM1ZTcWpwaXFiOVpsbWE1TnNIYXl5?=
 =?utf-8?B?dXRJaUxVVEdWdzFrYXNRYUZJTU9Wclg5RHJtakt4dEtVR1cvMFVPZmFTd0RT?=
 =?utf-8?B?N0FhcmY3UnUrSTJaVkpXQmlBMnMrczlQTSs2L3REczh0UFp1S1FOOWUyaG5l?=
 =?utf-8?B?TXREUXoxZnlKTmlSOFNJR1lWTHVPU1RlQU5CbnNlbnFFdG0vN3Yxdi9mNkg3?=
 =?utf-8?B?azNiYnErMGdIMHIvSHA2eGNhclpWdExRSUF0Y1JpckpjdWE5bFBTS2IvdVg0?=
 =?utf-8?B?RmVBNXZZNm5Na3ZsTlFVaWkyUjZoaCtFMFppRFlKOHRqSlRBdzNSbkdqNHJE?=
 =?utf-8?B?MmxOYWpLUEFIbU9CNGdRc2paYmkveWZ6aG13SjhXY2sxenJpdWFQZ3NzNDZF?=
 =?utf-8?B?YTAwMVBkbzZWSFFERGQwV1NqYmhVVHE5bWpXS1A2ZkozU1F5bWQwWFQxR05G?=
 =?utf-8?B?NWFaSXN4ZFpsWU1PcWFOMUxNVCtVYkFqNVg2cmdoNENVajFQRnN6T3h3bGVy?=
 =?utf-8?B?VkMzV2hYdXpLWUtWMTRiUER0dGJyVVJ5WEhVZW1mZnNEM3pFTlcvb2VQSm5I?=
 =?utf-8?B?MDhZWit6TDFpbk9lRXBnMytHck93cVg4S0Qzck1oMXM5SURvYXk4U2xYVjJB?=
 =?utf-8?B?c0NqbWNtUEpxa3hGeEVXWnY5cGphamxVd3pncmRXWlVmMGNYVHFEV2U3d3ds?=
 =?utf-8?B?UERRM0Y5UmRGbzZrRWZTWFpxRXBBTzRHOUplb1FteGZZMUxudWNneks2MDdD?=
 =?utf-8?B?eHdMQ3VwcW9QWFl3YTByaXhpT0RpN0xLMWlLUjJQaDhoeDZESnczbTJ6dEV5?=
 =?utf-8?B?aVdhclNlT2czQytZYnh2Mm1CU0RibHdzdWpvVklpZWtmNmJ6VFVzd0dyMnMx?=
 =?utf-8?B?K2xYRU5IbHZKTkJtNTF0ajg4eExseDkrMVpYUkJRcno1MDlRZy9JdHplK1ZV?=
 =?utf-8?B?RUF4RGJhT3BQOWZuekhZSmJuckUzenZFRFFXejl4VkQ4Vkdkd0wyVDZGT1ZY?=
 =?utf-8?B?Q2xFaHpWZ01hbU8rK0ZTWVVKSDg5RDNxblR5VmVLM0hTTEJsNjlzMXJQVlBZ?=
 =?utf-8?B?WnNxdndrVUdpY1ZGVVNpRW5sVXFvdXVaNEpuOWVzV3hyS3dzbERhNnVuUnM2?=
 =?utf-8?B?TjZoc3FsSzBTYmd5MU1qcDVtNjZmRkNpTDJUK05TZTRwTHJMSUNJcW1zY0Uw?=
 =?utf-8?B?dXZ1UGdEcm1tMzJnaWt0ZnZYQlNHT2ZtVGxlQ3RxQUdUNDZNRHZHSDJEdThx?=
 =?utf-8?B?WVRHUVlnMW5tTDdCVEd4d1NFNkF1c3FpMkQwM0pGYldMM3NKb3ZSK0VwWmFi?=
 =?utf-8?B?RlIzdC90Y3NDNXBoY2NFWWI3RkVLQ1JVT1UwaXZVc2R6UnR1QURqRTBTRVNo?=
 =?utf-8?B?VVBNR2hpUGpxdHVrY00yN1llbVJxbWFSRDRFejl5Y0JQa2owUWJKTnFDcEFv?=
 =?utf-8?B?WS9aL3dGQUxRZTNabThaVklkbDVwS1p6dlpPRGVDUk9JM0ZjNFpoOWVrYXJl?=
 =?utf-8?B?SlZydEtpS2VVVWRLVXpnZGJmeE9KRERMOXBkTDVzQXhELy9qU1pMY3pDWWtn?=
 =?utf-8?B?ekdVWng1MjZWckk4S3N0elFkM3c0ZG1tWG1GVC9tdE5DUUNHeGFDMzE3ZWNO?=
 =?utf-8?B?eEtETDZxekpsWTU3di9tZzFpenJ5ZThqaTh0dHdtZmxPeDJkYUQ2MnhxZHJC?=
 =?utf-8?B?NVlLbWNMODJ2WTJhUkZrNCtvZE9hRU9kVmVxRTdHc2dDTnVuUmdRbkZLZm9q?=
 =?utf-8?B?OFkwbXVVcCtQY1FJait2K1hYdGdub0lOSW1sVHQxbnNLVjkyRFI2cktWQUVI?=
 =?utf-8?B?SjZUSFNMa0pBR0l4dnpsQTNvRDdNRStlWHQzbHp0b0lCNFJxaGVYazcvcndZ?=
 =?utf-8?B?MmtHMzQvcmQyU0N4dFVXWHZEUSs2UklOQlNHQmVqeGRHbEZiK2E5SHFLM2x1?=
 =?utf-8?B?RW5vQU82U0dHaU5UZW9peWpLNmc1M0F0eUg3MXErN1ZHQnE5L2g0ejJhb3cx?=
 =?utf-8?B?b2V2V3I0TWlIY0k1eSs2NHJvR3hwU3ZoZUtQQ0VMTWs1ZXlJVnhqd0psWEJL?=
 =?utf-8?B?VTVuejN0RWNSdUFNTnpLdkZ3THVpQnV2Wk0yYXBSZml5STR3a0w1K1IraHYz?=
 =?utf-8?B?Mkx1SUloRElCYmJ3L2NGYkN6Tmt5Vno2VVV6cUdJVVN6MTQ3TVhyei9wdUdh?=
 =?utf-8?B?VmVITHM5T0M1VVdmR1VSZm1GdUp6RWEvcW4wVTBUZllLVGF6RXB4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eeddfc-4f86-4232-234f-08deb1024c3d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:14:16.1429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90gkJeFijXbLl0NZKENBL3pVyK+T06NPCbpkj6Rzf67ARSVlsPBlxiCzyMdEbAj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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



On 5/13/26 16:47, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 13 May 2026 at 02:53, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 5/7/26 23:11, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
>>>> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>>>>
>>>> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
>>>> API functions. The tests exercise the assert + deassert fallback path
>>>> since the sandbox reset driver does not implement the rst_reset op.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>
>>>> arch/sandbox/include/asm/reset.h   |  3 ++
>>>>    drivers/reset/sandbox-reset-test.c | 14 ++++++++
>>>>    drivers/reset/sandbox-reset.c      | 31 ++++++++++++++++++
>>>>    test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 115 insertions(+)
>>>
>>>> diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
>>>> @@ -66,6 +69,21 @@ static int sandbox_reset_deassert(struct reset_ctl *reset_ctl)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static int sandbox_reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
>>>> +{
>>>> +     struct sandbox_reset *sbr = dev_get_priv(reset_ctl->dev);
>>>> +
>>>> +     debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
>>>> +           delay_us);
>>>> +
>>>> +     sbr->signals[reset_ctl->id].asserted = true;
>>>> +     udelay(delay_us);
>>>> +     sbr->signals[reset_ctl->id].asserted = false;
>>>> +     sbr->signals[reset_ctl->id].reset_count++;
>>>> +
>>>> +     return 0;
>>>> +}
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> Some optional nits / thoughts below.
>>>
>>> The commit message says the tests exercise the fallback path since the
>>> sandbox reset driver doesn't have rst_reset op, this patch adds that
>>> method below - so the commit message could use an update.
>>
>> Will update.
>>
>>>
>>> If you want coverage for the fallback you could add a second
>>> sandbox-reset driver without rst_reset, or hack the rest to clear and
>>> restart ops->rst_reset,
>>>
>>>> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
>>>> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
>>>> +int sandbox_reset_test_reset(struct udevice *dev)
>>>> +{
>>>> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
>>>> +
>>>> +     return reset_reset(sbrt->ctlp, 0);
>>>> +}
>>>> +
>>>> +int sandbox_reset_test_reset_bulk(struct udevice *dev)
>>>> +{
>>>> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
>>>> +
>>>> +     return reset_reset_bulk(sbrt->bulkp, 0);
>>>> +}
>>>
>>> You could pass a non-zero value here if you want to test the delay.
>>
>> udelay is called and because there is missing check for 0 value it does timer
>> reading once. Don't think that make sense to delay tests.
> 
> We try to avoid delays in tests, although 10us wouldn't matter. We do
> have timer_test_add_offset() but I don't think it helps with udelay()

I have created new version and also test fallback which has 1us delay there.
Please take a look at that new patch and this part should be covered.

M

