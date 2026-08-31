Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA8AC624A4
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7783480BA4;
	Mon, 31 Aug 2026 15:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Thf4uDUUcPYE; Mon, 31 Aug 2026 15:32:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788190355;
	bh=clj3AHXjBbKfpyaTyT2ruWEwIob/3Ihker9O437+Gss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEObhwK09pAC1vYcOcmzxTUqwxeHDUvQEprQNaD3fShAAopBy27q+sJUO7uMFy0Nq
	 +9UzwxSUZ4sKet4oDk6aZlj+z3P2xw+gU1+vGA1Hjmhx0S4B5RSYGxzNZkHwzDY/ny
	 YjqFTLRZ5aqEEoBD4TOo7RwKowtfdmZl5EBNK+1YXuOv+XnVkelDOVUK3HYJkdiU3U
	 FAlH4dB9EKoyVi0lOLmAdf6OuoIN831C6Bqm9CMdnrM4582Dk0Zt9gjsmpLXO4O9LF
	 IK2D1t+IAPfIe9iMTDmE5G2JkoXvrL5701B4LzAS9G79hQyIYMXcA2yrA99ha/5vzx
	 OZEXh2ewNN5dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E44480B9A;
	Mon, 31 Aug 2026 15:32:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BD3C23E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D7C340545
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xukediZqrfb for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 15:32:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.208.47;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=I/9cmHGT
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAB9A4053D
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRi9VD9sKXFpd/sX2kvc6sYf7AEDRNrzo5tDgoLQCYdHR58UBv1RB/8qJaPi6Wlo3noPwNBb6cDIhZXlANhhhchYQz+AQkASTtVgo8dRf+yoN424I6m+/JCmE4jztcPLtsZCJJXtcK1XnY0ugkXd2xuGclQLh7ObpnuuVMnQwoqA76k7/iT0kKK59kasaQDz3gcg4g/8623ZN+u75JxvftP0/XDz47/UhqlEcRtc6OGc4gb0j6ZLV4tCb0Mw033TUZAqAF4xkapF7WExUDbKFRGF4oKoMJ4p6BKGgBnmuY5qsp08031IwaiEcOW4fQpJo8AhgSDPfFfUcfpwuD+5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clj3AHXjBbKfpyaTyT2ruWEwIob/3Ihker9O437+Gss=;
 b=auKo1QnyHUaBH4JM5desFXUwq1pIqTGdUu650+EkT4m3PT8wa5tVKwwWFIjwWH8ExOJNEv8+ZlH9yPKjgkCXMH8F8NUpIzU12GELdkJLe5svl7oQvT1eeO7JQgv3um//KNjapUYwaW/UuBfUFfwONYqx0elP7TqEpOSIdxrw00tTuZiX3vVCxk7NglX3q3jZdgFwmzC5pQ3bpBrpQ8rWvRNuh9ATOsF06+vwKtZPPlchpgHydSjTHH028K0VnB8rC12W9ou3FtfrgFGYzSesw3x+0QmWWPeC4Rp/KpcxlGv3Erv3Q4ho7dotsP5F0zQMlc2Hm13/uQAZcMlSQdqBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clj3AHXjBbKfpyaTyT2ruWEwIob/3Ihker9O437+Gss=;
 b=I/9cmHGTi7cUAPRKFncr/YWUDjOSnkN8U9JFnY4m1WGI+wF/M5Keu54v04HBDK5dEoTW4SsVjYLQjvKAO8j9BChTLH8Bx+ZneKQP6x5ByvCTjL03PsHIpHoExT5MMVXx0sWeV5m/nfvwrF5Jq9w6yUF6pu40PFbgouxT6Q5Ep9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:32:13 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:32:12 +0000
Message-ID: <c34aa04d-bedf-41ef-90cc-6384882cac07@amd.com>
Date: Mon, 31 Aug 2026 17:32:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] MAINTAINERS: Removed files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-7-trini@konsulko.com>
 <e71bb6a0-6f20-4d61-81a5-668408d8d7f5@amd.com>
 <20260831151641.GR3959812@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260831151641.GR3959812@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0104.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f8d0b1-90f2-4981-d15e-08df07750768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: J5Xc7Cn5q1IxV3pUd3B0Ukj4n3fKrWcFe/BmOxYgi5MnMedchHaufuN1hLH/MR6naqB64T1IIBiPK+APxZXjcwqZCdYPQxHE1pxeGN0SIg50yyBGr/Zx+qidHxLc4qwTaa4pnN44K3AojxH2DYfGR3PDNVuN93upZMup379kbdmUoCJMOff56AdZGPyrCqefsary8FP2vl/mIQV46Gx3Wc7VNDniyvNRqdjtUpd/V2s/9gIOdm6bofW/cA0+Hit0aGE/H5Gqkb6vB4EAJkbMoJqK+AZJ9c9saU8r8snFKWFTJz241TnjBCoFw2Z6+v4BcJ9ftqwoG1sKzcNQAYrQRoMxTsDb0eji0l4bNlt//bDDABGfcJfor9pSUHUYAZKkRsy2b3RTH47uZyubBI95aQ8H9LhOTijMA64HfafuZDOIn/n1P3rFMPwsZUOfAZFLKaJX7qHpm33oQpzyMPixfpZkv4wc/3kdv5U7LHV/K/zM2qJV/zhFZsTu4ftjzrDcD7btOcPEhRDb8jyPEWKrNd+480+WYaFt9a3PzUqMXVnBFv9xxXQuv78d0yhB0lHwTZwRPbtwDyRcV0SYlF1IfGnMzaBmJibEZb4z0u3voOVhEWfv5VdvfSwdMzzw/aEehv0aUhW1o/Cky+Sz2AsdxmkVEKMmKxeItcKQtTAujJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXN6cHVOUlE2N1RiR3Z0cGY4YnNmcU91cVRCWUlYYjNSbHNWZmVtczlYbktj?=
 =?utf-8?B?VU1nNkVyeit4MStDSFUzQkZsUm5DN2wyVk12MWI4b3IxYnJPOUlhTk03azBp?=
 =?utf-8?B?TDJRdHFrNGduQ3pTNmpCakpWREJ5S3NTWWxhbFprbk13ZmJTUmZCVHVaZG9Y?=
 =?utf-8?B?MVNWbUh3eGZVejU3TDRveVVHMXFId2d6ZFVWRGZNRU1tbWFDNjRrWEJSS3pC?=
 =?utf-8?B?RFdPZVlYNXJhOEY0TFdZR0lVL0hSRFp6UGlXSVBRWHRVb3lOR0tNVldHNmhF?=
 =?utf-8?B?Q3V4NjQ4K00vVkFzWVdib1IzZ3N3SFJRNEtjOTdXMzhvUHdEYmp4cERWUnZY?=
 =?utf-8?B?S1FqdE8vek1PL0REeVlrWmRYUG9McEViTGVrZXBZTCt1Mm1UREFLc2diTU9Y?=
 =?utf-8?B?cFh0QjlFc202WmJJZEExdUpzbnpDOXFwNXhPc205eWw5UU5GZnpkditpMEZk?=
 =?utf-8?B?aXd6L3hiZWxOTlZVeDZnV1FjVmRKZDVUR29CMVE2enFqYzIrendyUm5BMlM0?=
 =?utf-8?B?Z2QzOGFIdS9neTQzOGJxYUJBMVBYWm54a1hOWEJhWUxodW56cXNWMDRKOXNs?=
 =?utf-8?B?N1RWV1F6UnZwRFVjclZFYzZicWFiZFBxVDlKS2NCRjFsbzNZMzdRVDJqMlIv?=
 =?utf-8?B?eDJUblhlc2c0MWg3OFh2UUp2R1lGbi9qSDFwM3RnUjIvR3dZM3h3NCtqMk5n?=
 =?utf-8?B?THl6M2pTRytCekQ3KzgzSjgvdTQyWUcyVGFNeFNGU0c0NFR0cE9YZ1dKMGRk?=
 =?utf-8?B?RW5NcWdYbGhCQVpHeTYzUFB1d3BUT3JYblEzUWN2NkJna243Q3V0MmlOZTd2?=
 =?utf-8?B?UlhGMk0yajFTYjYzUnUrbEQ3ZmYrdldiMjBUVHM0K3MyZlVKb0RVKzBNVFdp?=
 =?utf-8?B?alZxejFDU0orS1Bpa0lSR2k5VjhLeFJ4cC8yMFBsTTRkbmk3clM2bUtZUC83?=
 =?utf-8?B?aUdUc0FvMVh5WS9KZjM3S0N3N1M1RDFpZ2xuUmVscGRwemp3dmp1Nm1kczdm?=
 =?utf-8?B?bWFTbnlmYUZGODdLWnd3Zy9VZklrUFB4VG1JckZHNFBielo0Tys1TUV0YS9Q?=
 =?utf-8?B?NVVPSEV2UnIyK2NZSEViRmRkdFhPSFc4OE5BS1B3ZVJ5WXdTNkFicE16K21k?=
 =?utf-8?B?OE96Uk1HeG1zMHdEc2RHdVZ5aXNvZ2R0ZFBzeVQ4NG5BdlBBNER3N2dZRUZq?=
 =?utf-8?B?UkxXQnZLY3dXQ0ZDR2ZnOGVqTTZmWTF2a0ZBRjhoV2dIeGZqcDBYYmttVVBl?=
 =?utf-8?B?b2VnS3I3dGVVVFFmbERCdVB5MUsrL3czd2E1clMvOHRYVkNmNEZFTEFWL3Mv?=
 =?utf-8?B?eUdIbHlmSURVZHZBNlNmVmxjNTNuZTRVL3FEMVZscUVJMzl0THJiMnFkcnNW?=
 =?utf-8?B?Zyt6c0trcUR2TTdyaWZOZFFFSXZQV3ZURnF5TVdLazhraTg5R3NYQVE2c0ZZ?=
 =?utf-8?B?N1I0YjBJUXJqVEZSTW82YkNFRGtmVWJWUjdPZXBFOHZWRzBRMWRTc25pbnpl?=
 =?utf-8?B?bFFOSlJpeUdLMEdJNDVQY0VTeENoTFV2U2tIcWIvRWdNZXFjcTgxQTFDZXFu?=
 =?utf-8?B?Q1plYzA4ajB4SWZsQTJ0NnR5dDRCRlZoUGhTVnViSUQ3ZGlPTlIrb1lXekVw?=
 =?utf-8?B?ak9kbkJ4UUt6Y0hUNFNjbUhBKy9hUWRyMEN2ZG50eWo0MkJWRU1nZ2ZFY3Qz?=
 =?utf-8?B?cVY2eVNRZ2xMelM1Mm9qMjhLemVGeWUxWjdTVWVRRUY2UEtOckRPWEllRzlI?=
 =?utf-8?B?UUYxZ0d6Z1ZURVJ5a0s3UDBXa2IrWjhKYWQybTJXbWs0ZUQ1Tit4b3hEY3BD?=
 =?utf-8?B?M2xtTkVsNllGQ2hqYTkyRkxJZzNWczFDV3c0NXdkQ1pWYnF1eUwzcmpMRXNS?=
 =?utf-8?B?SWltZk1SNTNQUmt4Q2dORThIOVdEeElaejdsbVlkMnVFY21xZVU5Z3pQd0xp?=
 =?utf-8?B?Tmc4RkZVOTl6MitsSTg4Yng4SWloZVkxblcvb0treFZhQVFmb0JkLy8wQzVR?=
 =?utf-8?B?U0pBN0s0emdWY1R3Q0UxZ3BNR3ErTWFaMEZmcUloejdsZlpRaFBRQnVUZEFa?=
 =?utf-8?B?MWp5d3BKY0k1S2RWYTdrMWdvdGhZaklZUm5HTFdBZEJoNXNuRTM2TDVxRnNC?=
 =?utf-8?B?Vk4wMlUwL2x3WWRFYTJ1c3EwbVNWZG1NeG5rdDNkdnZTZnNuQVpwTm1RTDNr?=
 =?utf-8?B?NXdqWjMvZ0ltd1RWZi8wUWJWRWlVQllhdTF4UC8ycHBVU1A1d29Bd2FwQkhh?=
 =?utf-8?B?cVpzM2huZUl2bXc5Qi96c3BtMzN0RVZoQzZUMWd3V1E5b09mU2JPdmtmeTAz?=
 =?utf-8?B?SnBxbTA4Qkl0QS9HNHlkTXBhemxrUnhBK0pIbUxsQVpqYklmYkF0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f8d0b1-90f2-4981-d15e-08df07750768
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:32:12.8593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHF4mTvMf+PeYAS0fbx8ujsWirtppsQtKTfj4CR4QrRdhgsDm6Q7zeBfSDjctTC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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



On 8/31/26 17:16, Tom Rini wrote:
> On Mon, Aug 31, 2026 at 08:40:23AM +0200, Michal Simek wrote:
>>
>>
>> On 8/29/26 03:50, Tom Rini wrote:
>>> Correct MAINTAINERS entries for files that have been removed. In most
>>> cases this is because a given platform has moved to using OF_UPSTREAM
>>> and so the local version of the file does not exist. In other cases,
>>> sample defconfigs have either been merged or simply removed.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> ---
>>>    board/LaCie/net2big_v2/MAINTAINERS             |  4 ----
>>>    board/LaCie/netspace_v2/MAINTAINERS            |  6 ------
>>>    board/Synology/ds116/MAINTAINERS               |  1 -
>>>    board/altera/stratix10-socdk/MAINTAINERS       |  1 -
>>>    board/atmel/at91sam9260ek/MAINTAINERS          |  1 -
>>>    board/beacon/beacon-rzg2m/MAINTAINERS          |  3 ---
>>>    board/embest/mx6boards/MAINTAINERS             |  1 -
>>>    board/gardena/smart-gateway-mt7688/MAINTAINERS |  1 -
>>>    board/gateworks/gw_ventana/MAINTAINERS         |  6 ------
>>>    board/ge/bx50v3/MAINTAINERS                    |  3 ---
>>>    board/intel/agilex-socdk/MAINTAINERS           |  1 -
>>>    board/intel/agilex7m-socdk/MAINTAINERS         |  1 -
>>>    board/intel/n5x-socdk/MAINTAINERS              |  1 -
>>>    board/khadas/khadas-edge2-rk3588s/MAINTAINERS  |  1 -
>>>    board/kontron/sl-mx6ul/MAINTAINERS             |  7 +++----
>>>    board/mediatek/mt7981/MAINTAINERS              |  2 --
>>>    board/mediatek/mt7986/MAINTAINERS              |  4 ----
>>>    board/nxp/imx93_evk/MAINTAINERS                |  1 -
>>>    board/nxp/ls1012afrdm/MAINTAINERS              | 12 ++++--------
>>>    board/nxp/ls1012aqds/MAINTAINERS               |  1 -
>>>    board/nxp/ls1012ardb/MAINTAINERS               |  3 ---
>>>    board/nxp/ls1043aqds/MAINTAINERS               |  7 -------
>>>    board/nxp/ls1043ardb/MAINTAINERS               |  6 ------
>>>    board/nxp/ls1046aqds/MAINTAINERS               |  7 -------
>>>    board/nxp/ls1046ardb/MAINTAINERS               |  7 -------
>>>    board/nxp/ls1088a/MAINTAINERS                  |  9 ---------
>>>    board/nxp/ls2080aqds/MAINTAINERS               |  4 ----
>>>    board/nxp/ls2080ardb/MAINTAINERS               |  6 ------
>>>    board/nxp/lx2160a/MAINTAINERS                  |  2 --
>>>    board/nxp/mpc837xerdb/MAINTAINERS              |  1 -
>>>    board/nxp/mx6slevk/MAINTAINERS                 |  2 --
>>>    board/nxp/p2041rdb/MAINTAINERS                 |  3 ---
>>>    board/nxp/t104xrdb/MAINTAINERS                 | 13 -------------
>>>    board/nxp/t208xqds/MAINTAINERS                 |  5 -----
>>>    board/nxp/t208xrdb/MAINTAINERS                 |  1 -
>>>    board/phytec/phycore_am68x/MAINTAINERS         |  1 -
>>>    board/polyhex/imx8mp_debix_model_a/MAINTAINERS |  1 -
>>>    board/renesas/blanche/MAINTAINERS              |  1 -
>>>    board/seeed/linkit-smart-7688/MAINTAINERS      |  1 -
>>>    board/sunxi/MAINTAINERS                        |  2 --
>>>    board/toradex/colibri-imx6ull/MAINTAINERS      |  1 -
>>>    board/traverse/ten64/MAINTAINERS               |  1 -
>>>    board/xilinx/zynqmp/MAINTAINERS                |  1 -
>>>    board/zyxel/nsa325/MAINTAINERS                 |  3 ---
>>>    44 files changed, 7 insertions(+), 139 deletions(-)
>>
>> Perfect. Thanks. It depends which tree you will apply this
>> but I will keep my eyes on it and will rebase my changes on the top of it.
>>
>> Acked-by: Michal Simek <michal.simek@amd.com>
> 
> Note that this replaces your series that updated the general MAINTAINERS
> files. The series to consolidate the various tress you own still applies
> on its own and you should pick that up when ready :)
> 

Understood. Will just rebase to see that all things have been catched.

Thanks,
Michal



