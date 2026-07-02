Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8FEC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 12:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB01E849BA;
	Thu,  2 Jul 2026 14:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COLsGl9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE70E849C5; Thu,  2 Jul 2026 14:41:00 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D34849B1
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 14:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3cmxD2MZ9spruLWjfxEMqAYj6ysurvHFDeBfjMUJs4p8z/QS3LrD4n3DMRKlTa+xO5nB8TBh7tyCbLbuu7ZWlRM5G8j/yaKftx3x+MauyKNcM8AMzXH6NWZ9zyFT5nRhwm5vOFcLmCFTsAYgtyfHejSkF9Ggw51A35MD6CwFkv42oXMnaXTOEbIe+K+3etim6hd5tVx8id8kxg2LfnDdiMLjwnIt8SAvT6iaa1rVqGlTcv2TNagQnZMWGaqU8Pzcw5EYTmrWbIZ2RJnBD8X0U1xhASYC6NuTJuu0eNTVMn9AC6hs5MZFxE4d2QARXzJ0XwaBmPNRMVUerzVX1FOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZLNOUXetLvqypMZljVeYazEdM+FjFwkRZhBuU0wwtU=;
 b=kY2SqbXblBnqgOvSvSDyQO0LEIRD7AJxX758L2wOUsTis3RZuaQReeYAz42hAa+Ozq2tm/7Ab3WUBGvpIJXM0LlOMITvCqeHJU3eO6loKtu5jP5kG8PTdydZvf8NmX4X0Czo82dHNu9h3W1GA54KIIfHoUrEHdYTQ0MetsE1PZe00bqWqrIGRBqlFs3Z4RL5/YNnBjBitqeQnjYbl5idbdmlzdZLSN5pphiPB/9B/E8ZxaBa8euJJXeVXnDtQRL0s6DME3ghH6FSwJp+8YqtWeRJ18nCDrGNXi9ljeS83M/iD+CKFiCRLqPi8dIjhUcmYrJyzGGxKtR2hWqWzg1w3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZLNOUXetLvqypMZljVeYazEdM+FjFwkRZhBuU0wwtU=;
 b=COLsGl9u9nxDcZI6JWdE9jjp3ohtIpweohoWjCc2dmH3Dm33zIaZX0bDmbbXIlM8XyknwcpVzvnOwUsiRTSc+a5oX+waunAe/FH8oTFuXbPlro8CdFWBrRXqFLGN0fXyHFL+XOOK9KAa8lnve7Y/ptUtCJYV0nGwBRNJQ8Yxmy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 12:40:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 12:40:51 +0000
Message-ID: <207fe44d-e18e-4983-b152-be820d720275@amd.com>
Date: Thu, 2 Jul 2026 14:40:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
 <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
 <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
 <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:803:50::45) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aadc93-70d4-4722-34cf-08ded837260c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: slT7vJWmXwbVf03Dk3e9TbX7Kv+ZDZYQSlfvY0freSUhOxqh6UChBik5gF/Bcnufy2pEhmz8kP+DigobBBBUwAfzOy9LAmZIFJfD5PjakwfwRMVIqQp9kfmil5Ov7lAkNFgOiZ2oBN1S1BSw4mfNKn64LwrzY8fVWDLKg9emRPJbeQplPyAT4CUPnweZZqttW5ZqMuXOFXIF1fQPPtwMtvn3FEcg5w3SIy94OAnPLP/hWyjJxvzJqxU2klxILZnOP7nhSYMsbPPasi0too6TtYlR8Pd5yXDgF6eiBPln6PAqBYezXmM2RtHJCn/wlfoxqND3QvDtEDe06iRkvGx0Q3mbjAy9j9hYjcfNwoAb71eSV3EUxuUuFp/ZOF7K+zKt4KAiOJFadgtGPbINqQoJejCT7rveZ0DIVy4P9EKhrWdt/q0v1sGQ86AMFTnRrvJKjxsD/Fk3pJnCog51PF+CLbleOWHgSaz4pBx1Ci7WCrAAmmsdlYZkYvyl+z5khyRRDf+RkPRhc4D8PrwL1BzkbHiQIiF9mO2jhwN41fsR100HupYVFZgE8bKOXNzT5Li9etDHsUDTZOou/cEoFFq2UIPfrr3RRInHoOVeqLnaMbj6leG8hUk5eRleJsVqux/z/9Bt4nwpESEMRnaONrpdahc2lqxIViHzQq4PpETUpWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZGWXJqK3liZzQ1RlN0RytYTVNjZk4rSDA3VjVSeXhzemlmV2Y4SXF2OFRm?=
 =?utf-8?B?ZnVkM0NPeFZiaGF5ckYvYmpCMzh0eUFrUVNkelFIUElqUzhFcVVkTkttY1ZY?=
 =?utf-8?B?cXAzRU9Nc2JnK1ZNNTFiaWhzWU9QK2dhYklJVXd6cGxueXNJU05oRTJjZ0xP?=
 =?utf-8?B?ZGYzSkJjdFNkS1IyaHpUZkF2S2NOYk96UDdMMlZsQmZHVW02QWxibW9EeUds?=
 =?utf-8?B?SlpWZHZIK01oUmgrdjgxVkdNRU4wR01IVlVJa3RiOHM1ZVNram1lanFkelYz?=
 =?utf-8?B?cVRlQTc3em1nTGRuTncwdmg2Ly9xUk0zRGplcXREMmc5dFFNM05kbjRubnl4?=
 =?utf-8?B?ZE1tNDROellHU1VjRk11Ry9TN3cyeElwYnYybTdYeW8rdjF3Ymhvam5OeWJj?=
 =?utf-8?B?SUtDZU4wMnV2SGgxKzhkUGtvU1Q5QWF3YXltYS84aFdPRDdETWtnd1lMTWFN?=
 =?utf-8?B?Y2J1WWwrMTFhYWlPUHlrRkJoZFRnbTNrWmtsRVQyc0E5bWluMGlxeDlxMkhh?=
 =?utf-8?B?TWRIbldleFFWeU5RVGNtMUtLZjkzUnVzTGZSTE5mWlhhWUppQzdsN1lpTy9B?=
 =?utf-8?B?cDloMGpiSksyOVlDU0c1Zjd3RFVUbUpxaEp5aFJGVXJwZi9JODJjVVYwblcv?=
 =?utf-8?B?enRSRnR4VWNVS1B5dkVQL00zbURHK0xoczIweXd6OSt0QnUvS21VZHpCTXRj?=
 =?utf-8?B?anVyQ1NmMER4WXpDck5kY1hlVGVxT0FDLzRKYVU4dmd5eTlQS0FFOHV3MTFH?=
 =?utf-8?B?SGtyWVZGOXMra2NkVXpFcUNtVkI4MWhmRk9vZ1hIR3plV1RiS0FhZ3doTXZa?=
 =?utf-8?B?SHlVajBQWWE1T1N0eDZXTTUrQkZhbWxDcEwxKzRMQkRtWEQxTTI0TzBLc2tF?=
 =?utf-8?B?eG5qMU9VQ3NrV0gxclVMS2YySmI4Y0pCbGhJd05SYkhjOVhyTWw2bzVmNFgr?=
 =?utf-8?B?WGRtWTgxTzNsa2hPNHJVcThHdFpPdUVEVjR5K25URzloM3lkZkM2RGtCWldk?=
 =?utf-8?B?R0YreEJLcjg2cFgvT3JINUZ0VDE2ZmtDQW9wTTFSbE5RVjRoazZZTUhTbExE?=
 =?utf-8?B?bU9maURSWG1Sb0tYcnJDdzg2RTEzQVpmRjlxdUFFQUl4S2xyQ2V2NThDT25m?=
 =?utf-8?B?YUJyUTJWUjNOSXRmdlIxYUR3dHRZSHNRK1JxcVhHN08zbXRXRzFMNU9EcmJR?=
 =?utf-8?B?RmJWSU4xSHhWc2Z1c1JHcDQreE54QlJkZWpaWGU1aGRERXVETFlLb09ZTm1h?=
 =?utf-8?B?bEFMcGlIQ1FjTFlxaURkSkxoNjNBeWtjQURSdENtZUphNjJ3MjBkei93WEUz?=
 =?utf-8?B?WThZL3ZkVVpBSTNzQ1pNaE9vZ1FJNGJrclJWeEllNVN3MmpSNVp4dHNhcmY4?=
 =?utf-8?B?TDJ3NHZWb0g4VWJkZHVTVCtvUEUyblBYTXgxRFU2R1JOL2ZXV3JBR1lzVVlt?=
 =?utf-8?B?UTIrNVFIQzVlSVNhYTVERlV3VVBvS2VaODQzYUJicXpsM3NoOXVjZDFrMkhJ?=
 =?utf-8?B?cjg1S3l5R3V0cEp1RWV0R0p6bStqN1hiVUgraElQc0NvbXBwdUtoWHZpYTFQ?=
 =?utf-8?B?V3RwSVREcHo5OHk0LzFVRnp1Y2kybS9nN1dUQ25CQVRRM1I0b3k3am9TV21o?=
 =?utf-8?B?M2FXQlBBQnVFT3laWXgvaWtvVDlBdHlSQVk0dU5ha0pEekgwelJSRFYzVnB4?=
 =?utf-8?B?OVJMaWcyOXlnR1JqcHRBZmphY0lHN0tSQmROVGxLWjFzVHdaanFaYk4veUNG?=
 =?utf-8?B?SG1nc1R6Wkp1Y0IvdlkwWGozOGtSL3BXVjBYSDEvdDJkdXN2VU1EM3B0ZzRu?=
 =?utf-8?B?dERLSDlLcEs4MnVUSURwaFhBYlA1dmFlY0E2dStrOHVpeVNCNHczUXdWYis3?=
 =?utf-8?B?S1kzS3ovYVFadFRuTHNLUm54ODFPRENOeGNsRU1Bd1hkeHBydUI1bWdwdktX?=
 =?utf-8?B?V1IwdEVhV3NBang3VWM2YWJsSVhwa1IzTW5TcU5ScWNYVS9KQWY1ckZpcTRk?=
 =?utf-8?B?RjhYYTU4cmU1dGdVUFZhMGFxU1ZTd1pXUHpXRW5lSlM5VDVDNklBdm5pcGNC?=
 =?utf-8?B?UUNlOU53a3Y1NGpCQjVQV3ZHVzZSY0tnbUdBaEFBc1JzcTFyQklWZytkWXJX?=
 =?utf-8?B?dkdMU280MnM1czZKMFBMWWNhcHRZMDRudmJuQkYya1hhWUROdnUzbHh6Z3ll?=
 =?utf-8?B?cHlTMytQOHBMWXMzNjgrMW81eHFaeXNSWlRZQURmWWpMWVhkRWlaZWx3RHNO?=
 =?utf-8?B?aUhVMXJMV1ZML1l5TnEwczZock1EdW4rVUhod1o0aVJ5bzQwNng2cjZrN25O?=
 =?utf-8?B?MDl0aDRnRXJWMGE0NThiR3hNS1dGWHpvMFFzSzVjSVIwQ2lkUWlLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aadc93-70d4-4722-34cf-08ded837260c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:40:50.9877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUX9O34ix1w0hnZeG6NpjINkOGf1zUXG5gLzC9gt8HdzeIfCMtiIlKEUFRO17QnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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



On 7/2/26 14:24, Ilias Apalodimas wrote:
> Hi Michal,
> 
> [...]
> 
>>>>>
>>>>> The prints below are just from fwu and efidebug for the ESRT table.
>>>>> Those will work.
>>>>> But what happens if you try to run a capsule update?
>>>>> Eg. efi_capsule_update_firmware() will call
>>>>> fwu_plat_get_update_index() which will fail,. no ?
>>>>
>>>> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
>>>>
>>>> versal2> efidebug capsule update -v 0x40000000
>>>> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
>>>> Capsule flags: 0x18000
>>>> Capsule header size: 0x1c
>>>> Capsule image size: 0x41434
>>>> FWU checks failed. Cannot start update
>>>> Cannot handle a capsule at 0000000040000000
>>>
>>> Ah yes, that ret 0; will never update boottime_check properly.
>>
>> I think the question is if this is acceptable or not.
>> Because none checked error code before
>> 583efb504058 ("event: Check return value from event_notify_null()")
>> and then
>> 353166279c32 ("fwu: Move boottime checks to EVT_POST_PREBOOT")
>> it checks it too.
>> It means in past fwu code error out but u-boot continue to work with above
>> behavior.
> 
> That's also a bug imho then.
> 
>>
>> Pretty much this patch is bringing back old behavior before these two patches
>> have been applied to the repo.
> 
> It doesn't make sense to update to or run a firmware that won't be
> able to use capsule updates ever again.

It means that can be consider as misconfiguration. Which ends up today in 
forever loop (1/2 will at least tell now what it is happening).

, eth1: ethernet@ed920000
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device
Cannot find fwu device

But shouldn't be there different action? Go back to second image or reset for 
example?

Thanks,
Michal
