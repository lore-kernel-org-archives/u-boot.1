Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D39C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F4236068B;
	Mon, 24 Aug 2026 15:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zhi3QzX3MhCc; Mon, 24 Aug 2026 15:30:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787585454;
	bh=8isF9lxMGPZ42CDsQKz5hDLWuFsxSluwEt1PCnKQnCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QiY7TpBngElRhh0FgmiFvzAWorA6JYMBbSyQaJuBpP5mhjy1cL/SSB5JudllyWzXu
	 MCvGzASzkdzbKiKMfkE1oLpemljyMYcOFU20Xt46exuEaXRxHN59H3HLcS7CMrWzdP
	 X43UV/3TeLSkYrfifzp4jELaED1I7PqvoJrPAgjTGzSh0LoGs/Y6A0zpQueEy4I68/
	 Hd/l6+ZlShanJfE0+gCl7YgZRKMEcTSFeVCUAOvojv02NpB76i/kfwAK2EXsjc8ovj
	 mri+41hYdJUoLlPEBerIOB2reG4vd9TSJp7k9ifPj0asGi5UZoGh/jpsDEHz4Ko2eE
	 i6b43xaV0SUpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BECD06062C;
	Mon, 24 Aug 2026 15:30:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 298093AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B4CA808A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W7DyZXPuzLtb for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eFhhGEPi
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D58A808A8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEd7nBYPBZ1ULpYwF92I9XUcoaRvwKgb8lIV3dNk0h1cFyEphaeTB+XEjblJU02/XfjSCRWsSpdRVp5brCqTNiA5TB0QIN9ApLqtniuLOcModsNxNDXq7hJeC57HQ8VEYhRoFU6oYOwPwQSOdjbNkljNLYfzZrcllKOU8N4mOEC3TXJIqziLH1+1kTFIA3+8cIhrqsqVHKthUDKqwzc0+C0HNM/eGT1yh6NM2D0/+NENDajzWPWLmmcfjjfZG1fpuiAvpJRMe02nFZ27Vts2fbU2gz/mwpeSt8icqFrZ/WBc44fUr+2vwjvj4voyBPBxYDScO3clQjmOD7Fyh6RwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8isF9lxMGPZ42CDsQKz5hDLWuFsxSluwEt1PCnKQnCk=;
 b=TK6PczVjRIV+V7++Qz8te6U7WaysRlyRmD18gAGG0Osbsb0y/mjAWHh5gDxRstF3qfr8aKg+quTSRY7KYRWOE8o550O6FDYfOmZzAUfBBsHBLRK7AMqhGitAB1I1r/nvowlmcmP43MZgtG9P0FC19uhSYB7IqmHnbNnwNc8Mbmj3U2t5/UXeM3BylbKW6vP7tIitMQvEsDISo/dxGQjXV5lblh8qsH8gyF505KQPLgENu2yyCyU85JOvqq7Abpq5NgqSwJ+X0NgjlZXoO5SzJ3sF3ViYXTH6kEy0+hG7efKvfcc3/77hd/+BuIJpia+WB2ESxBLPO/Asj3oA0E5Mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8isF9lxMGPZ42CDsQKz5hDLWuFsxSluwEt1PCnKQnCk=;
 b=eFhhGEPigmRi0VvUc3G9qKeI9e1ZIh2h3RrDzVW5v44jp2fvodnPG6rbrTDpMrohdUMiOpg1gg+PLLHysK20/eTJ3tn4705Xlh9Aed2iVj31x6oKM/qwaZmG5Orz7GuEyHS7BllrlP6/G6hHbeA7KleBMTIQ7vfBSCwMomavVq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:30:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:30:40 +0000
Message-ID: <0ac7a1c7-0db7-484d-aead-4c7f578c0483@amd.com>
Date: Mon, 24 Aug 2026 17:30:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove unused emails
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, marek.vasut@mailbox.org,
 Andre Przywara <andre.przywara@arm.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
References: <a14a6d0d7de1afe226edd49b3f683a3cf26cc50e.1787556953.git.michal.simek@amd.com>
 <76c794f6-379f-4ead-a687-d65a3f238df0@amd.com>
 <20260824152143.GE523975@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260824152143.GE523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0133.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d506fb-2d37-4f50-0b97-08df01f4a78c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NOcFPiq/URiBc8hv5x5Y/2gw/Yb0Q24Q8tbpJc3vpCzsgcBG0lwNoK7j3BHYwMsvTzDD7RgWAr+GIJrvUcauNAIXNktlxrQaQ3CMzbY9FRUejeXv2+soqN3bwHecZ5T7rkwkIg3C4BMamwfYZ/N+5um37LMphhr3BItp1fyGwKb2opZ+LrBeU+KGPeroQi9X2HnbJheVPbdEMF3FlnnKBd/J6DV5nkaBJxaEUZe1oX706SbczSKTugUq7bmWZYPsxxTvZpKNZ2Nbn2ssHdGs+OCZmTRBzCd1y2olHCUroAl2zaSkIXDqyLYVR4qh7by8LnErJsctysRiXgGq7jUKz51sQxUqI3a0y0tNV5LEqh6jUK8hqHfAwkZGCvslwHVJz+ckoIBoiKKH9y05ziMlWCQKVoZnX+ri7vSPICjpE7e04YcqnC4T/bsOlWCXXuy2BpwU+4EsgSI9E60E9Ln5zKU7eREGH77yZJrF99+4ZGBhbR6tXxLDdaLdl1hcpfojOB0XO/++2tPsJyz2r43p337voVZqm57jl36DPtl+pvcZDS8FBeruF9g+LuTkH+7kvLOD7nfUc3LviJ7PkxBEM3BV5AmSmcyV88KmzJOf6yyPWqXPnixnZA3+Gak0bpN400hXsuA5twc0JSyz4At+t2RpvSR8DJ3hEAMqJRmIY3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZNbFZuUDZsRXBBOHlxd08wNFFnSC9POWgyTEwxdzBaNXNaczMwamx3dko1?=
 =?utf-8?B?dnovUUVOM3FMYTJzYk9vdkg5NjhYMzhlL1ZxaTVING04bjZKK3N6Uit1T1dI?=
 =?utf-8?B?dzJXWkJ0U0hvTXh0QVdlelpOTzI2Ylpua3lMSC9UaGlJRHhyVlJabGdOYSto?=
 =?utf-8?B?Y1ppcHBPTWJ3eTZRaXFYUU9VV1ByZms0OEM2VnFLank3VE1xZTEyYnZWdzAw?=
 =?utf-8?B?NEtid3UrT1JCS0Y5VHduVk85M1dRdmgrQkVzREZzcVN6RytQL0NxamVPZ3F6?=
 =?utf-8?B?VkpuY2NXMDFqNitvUmtMeXVvY3pYMThCalhpcjVoN3BGSFJ3TkxnUERid29x?=
 =?utf-8?B?RXkyWDVCMmZVOWhEOWxHWm16L0FvT002aUQwZWtlWFpHbFpxTUplOVl3NmlS?=
 =?utf-8?B?cW16SlVPTGRKOFdOQytNUVZTSDk4NEhrZUIxWmZYVCtNZVBhS090SHpTb1ZI?=
 =?utf-8?B?M1dadVppM1cydUtoT0ViSjFDaFh3UitRWVFERU5HSkFKKzJTWXRuak9aSDRC?=
 =?utf-8?B?NXBDYzlRNnFuWjRlVlc4cSszdEFGMWROMnQxM0ltTHlVVmJwQ1RaOThmNmEy?=
 =?utf-8?B?T0J1bHNxQjRYS3UyQ1ZKMW5PL08vbVlwa1NRdDdxTyswOEM4bHd3a0E2a2tE?=
 =?utf-8?B?N2xjcnBVWVhqZjFFSytDMVdmSkgxN2VzdVhxNVRyL0w2S1oyZGNCdUt3THJl?=
 =?utf-8?B?YVd4ZnN1cGxvQkNPUEI5U0ROd1RITVZYQU1BdGNLVThEM25aVGZ4aDk0UHFU?=
 =?utf-8?B?NkhHRXRtWG9peitGOUpETFpjVFRNUmk4NHNMb2k1UFMrOCtYREx0ZWZSblBZ?=
 =?utf-8?B?M1dQNUZSRTZQc2w0VlNDdVA0MU1Td0U0M0QrQzBjMk0yN3orUUxmbldnVXRP?=
 =?utf-8?B?a3V6a0JyTUZucnhrK3RGZktUUVFReHVsazlwcVdkU083dWJxS3pxcjgvdktv?=
 =?utf-8?B?L2xsS0c3bk5RUXcvdkRpeHcxd2F1aWVOVytMQ1NUSFhVY3VlWXJZYUQ2NGVW?=
 =?utf-8?B?UGdURS9zQWhhSnhvalNpdjl2cmJUa2cvek5JWGhtaEdZdkR4RHl4T0d2RXNX?=
 =?utf-8?B?dnpSeExSQjRzRVhCTWdrblBFL2VQa0xMWS85VmZpcXpjK0cvaFQwNFpBKzNG?=
 =?utf-8?B?bFQ3M0pLNVRqQWNYWE9hdWUvMVQ3VjcrM0dIWlNGWjZNWEVYYXZncGdRSENN?=
 =?utf-8?B?RThnK0xwaldaRmk0M0F3ZnpuMVdKRitITjdRbS9tdGJxV1lSRWNUVHNaV3lZ?=
 =?utf-8?B?cFVleisxQnQ1ZnI1VXNoZEpPRFFlanhUTVVJOTdLRXIxcWVSeHRibnpRK01X?=
 =?utf-8?B?eEpyRkxxUk03VURCaytmaFR0SVBDeUFHS3hjUzlOSHoxZTkrcjdzcU9COTFJ?=
 =?utf-8?B?M3cxb2N4YW41WnVRLzY0cTJHQlpIQlRDMThaby9YMU9sN1A2M2dTa1c2WElV?=
 =?utf-8?B?ZHpkanE2Y2FWd3B0Z1NOdndEckNQdkFvYVFSdlYwUVpxYmJ5aVhubmVPQTFn?=
 =?utf-8?B?UzZ6U29pbGFybVI4YlRjdHo2dTlGTXhsd2E4VjNlMTJKaVVxQzloa0NJTis5?=
 =?utf-8?B?TWJmMVBTeExsRlJBUGlaYUFPM3FhV1NkUHV3SFJ4VWhhMDZ0U3QvNEhaaWNm?=
 =?utf-8?B?bXp1bDRPYUp6d2psN3UwSHo4VjBjZXJyTEx6ZllObUsrQlBKR0FrUkljZTQ5?=
 =?utf-8?B?WEh3S1lFSTBTNW9yREhOR0VQaFB2dWh1c1NVQ2grL0JVMks1dmpDN0s1QWZj?=
 =?utf-8?B?L3ZvQkszZ1VOeXNmV1lWUmJCZXhuMWVPSENHbGJZVHFGeHlTZ0tHQ0JOMHp6?=
 =?utf-8?B?RXZ5ZVFIK2xVc0txekdHTEJ5cU1oR3ZkcDE4MWphbFNEbTI2TXRBdC9pUE1C?=
 =?utf-8?B?U09mb1VyQVJLVmg1eVg1dUpjbXpBRnVKSkxWSzhFd3VzYVdUazRQN1NESGhS?=
 =?utf-8?B?dXI1K2JCTlZvYTA1WC9iZjdFM1pqZ0toaUlVMjFwNHhWa0tmNjBwSXh6RzJr?=
 =?utf-8?B?SlNuRzBpOVhsNDB4ZDRjSGlYdGg2eVRSWGtnS0ZKRWJnSlRzYkQ1NkcvaUhL?=
 =?utf-8?B?eDRRVzg1L0JXdlh3SGxQQXhzV2twdG9aTUxsb2J3ZEx1STBLenl5N3pUeGtu?=
 =?utf-8?B?UEx0MS93QlNURmVaWCtaYU83akMrZEF5RHhMcTNBMFUxeDVLa3p2aUpIZ25Q?=
 =?utf-8?B?VlFsbTN4ZUhrVjNBY3ZSdDNOQXV6VnFpVGNLSkQ0RVRvM3UrTnZkK2dWVmF5?=
 =?utf-8?B?UjNoNVN4Sjl2V2lmSlpaalBRYmhSeU9CZGx5clhvTzd4K0RBN2tWeGFraWR2?=
 =?utf-8?B?ZnpSYjdkeGh0bEtjRnFUWHNTcUYyYXZCNE5IUEYxb0VVdWFhaGVxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d506fb-2d37-4f50-0b97-08df01f4a78c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:30:40.6258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDAd1Iqds9/b7QrK0jVYhoMqRua+ZJqwdat+KUkLc0MmUwrOqh+Q0n7o79zBvfjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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



On 8/24/26 17:21, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 09:38:30AM +0200, Michal Simek wrote:
>>
>>
>> On 8/24/26 09:35, Michal Simek wrote:
>>> Remove inactive developers whose email addresses no longer exist.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> When I sent previous series I got replies that emails are not longer valid
>>> that's why better to remove them directly.
>>>
>>> Not sure what's the situation around denx.de but I see a lot of references
>>> to denx.de emails and also in git-mailrc.
>>>
>>> Marek: You have a lot of fragments there.
>>>
>>> ---
>>>    board/altera/stratix10-socdk/MAINTAINERS | 1 -
>>>    board/bosch/acc/MAINTAINERS              | 1 -
>>>    board/intel/agilex5-socdk/MAINTAINERS    | 1 -
>>
>> These two should be also removed. Got it when I sent this email
>>
>> -M:     Jit Loon Lim <jit.loon.lim@intel.com>
>> -M:     Dinesh Maniyam <dinesh.maniyam@intel.com>
>>
>> I think it is really good to do this cleanup.
> 
> For this cleanup, at least a few of the intel addresses are now altera
> addresses. Do you want to v2 checking which people have been active
> under altera.com or should I pick it up and do that? Thanks.
> 

Feel free to pick it up. I just wanted to point to it.

Thanks,
Michal
