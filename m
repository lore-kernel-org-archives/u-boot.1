Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5BC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 09:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 144DC606DF;
	Mon, 24 Aug 2026 09:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPW-DwoXxQPU; Mon, 24 Aug 2026 09:03:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787562235;
	bh=EXhjR63rcvqyjdkDctBoTHXgHBDwDp3YCNrXLzNivaQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QwBQwQSRqIu01bvWZ7MY9pSDm+Uj8XbEuaBcTJr7CNta+pN0TZ6DUlAwI9BvUYlwn
	 O0T+/x48gYO1V2iQSTiQ1o19o7tN9G2SR9RyTHGCCBVgH8Rbh6JFcqotTsCoMb/JQu
	 0xt7JEm+FsjFUj7Hkm91snCURQLQX0mAVZ6Ho8IeC2bFJmlWN4n44hHHRFUo5/zoMU
	 wzaNpOUfuEDi4HGc2bWFTN7SbHZJBwgJGbmFR2SOdrDNht3n/RI72FyadFH/2+uwrE
	 VB1XxbEbOviB0sfmzLrS8LXNYqZmkIHSs6azu2s49qrE31qXbIQUGGxiKBTRUytmW/
	 mhS4xGyxmDn3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02C8B60622;
	Mon, 24 Aug 2026 09:03:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60E3D34E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55F1A406EA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpMHRUJ0UW4k for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 09:03:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=q2qdoR5N
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 411424068F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKwr9BcV/g6S8m3l8qCbKFEnuOabA7p49yL5g3asAfLa+lfYgnPYZGhhPTVC6M3sQF4zHWE4e3YgEm+hhKoeZRtqmLzVE16kllBkE95HkOiCQaqIW60+Yg7K8TZ3cyH4BRyygG71KLQbTbRC9fFu20S/UNJbyC4m+TeP+rI0wlstxNdLs8oZ0HNuDJ0s62TucPM04F4SndwSzvv+Eo/KvNuchZRsC28Pd0gASNrS9Ggu5WCobRbyLwB1P0Usdg4V5PZNEPJOeDneQLovLxsBspbiOBgggOmkMTg1x6idhQxgR4OIIVU/mOrVAoHoXQXijIGtEIBlWHlM0g277QCzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXhjR63rcvqyjdkDctBoTHXgHBDwDp3YCNrXLzNivaQ=;
 b=xBe/50PKyHppNgTsf91g3xfDoAmbb2KcGMmmarQ2HJc9w+7d2WwBZrJevLbKHDuWYtyOywfpF3y852RMpWPMRseQZP/P/5lvhPA+dRBYDDBM1tItD8vtXkcX0Fmvs40q6EMSjYx6VKZDwWzLYqN2Z8+9UYVGGB654nwCtwq9xaFs5YML60zj+mgO+ES7Js6Yj01upMTihgh4ZS326Wp8zx2J6tFwUz4hI1yr/3gXYUCWT969qSGEZdO7HGKydoHI6wPwW0enyvzE8nUYChDjKWLrXQmXvPhmdYZ3e2jEyVyIdaQWHK+cnD2rNwUX07cDWypj967GqVAitqgyA0ogPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXhjR63rcvqyjdkDctBoTHXgHBDwDp3YCNrXLzNivaQ=;
 b=q2qdoR5NATqPhrqjQ7XKrBUe3Ot9qu6ncA7CPfH2dp8ME/hxf+DE5ftXDCMs2s0DMU0YzJqtVQLjQkZaXII4EvX0i0W8kUr4SKLjcvy5/2m7xMkhsjxdCF2oLJfkHQNcYcxTW37aHpvMfTsRpOoCKUVvPGJLcrMNNumCcXnsn3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:03:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:03:46 +0000
Message-ID: <36abf93c-48a3-4d71-82d9-f0489b8b39e1@amd.com>
Date: Mon, 24 Aug 2026 11:03:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <6ae0a139-cc0b-4d58-958b-50564f357cfd@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6ae0a139-cc0b-4d58-958b-50564f357cfd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0065.eurprd02.prod.outlook.com
 (2603:10a6:802:14::36) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: f370aab4-eece-48d9-ff33-08df01be9ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LbEq92sVftTx3J8HtQBY9Fs/H92BqvB+mEgBHytQh3JHAoMdUcZ9NXSYjBQk1jwEQkDHdIqgxOXSq1ITvACQd9UI4Ht2YHehHnsmNdT5ikdqdKsR/K/hVPCkqBPRjPGm/36PSJ4+krUI2w2sxaknynZCml/zzPQNvbnYDDkAoC9RmaoxlVVlkh6fXTmg3a/8+V1sIF/FzXjXwsVhX/gAev8wJ8MDl1nUJv/MljiCAWvtLeFKyzdfZKk8ihA2sNtxOf1a5X2crt2OlG7Ee3O4FvdWkT5Fz85NEi6IQTwxkxrE0D+OxoAzQ5+YljfYTKyv7/RG1vvsZQZqRNE0BXwJvFSLqv6d2/kZ7KSEEZn/1BEQPPijZIGL+69EUhSp76zUjR3PqHi5s4C2PAifs59q34NRU/VlArlNwi7fDvrBG4NYSAlP1WOwP3dSqS5JdYVGCClVylvlI/jgWEgQCDUTR4pbZwnLnQjxC7GGpSuslhLOFmuxnS5oGzGMqA05577iFxHzogOmZ9vYsXIag0Ov6JAu7lID/5DHuHgE8l2bHcpH6OMJjU6A+gJcnFm+Ld/n0+OFduhfxYsnKahkOYdde0AuC5b8YKTnO6BZl3aiIPAj+ftVIMl15nN94ljEcDFoK1ZlxOZKX96M13cuY8crBSo0sEgLNEULeJY3CPZB8sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU42RGJTRCsyNTdYZVVGRWhhYWt5cE1DOEgvUThkZ2hsM3QxTXNNV092T0Ey?=
 =?utf-8?B?STZDbS9VbEhybnpPdHJqdkVQYTkxVVR5T0kxcEFJeEpNalBEZ0I0RCs2S21p?=
 =?utf-8?B?K0d5c2NaWlJTdXVWSmJNcXpBdDRRTGMvTGhDNFdrUW0vUGlMek03QnN0Yi9h?=
 =?utf-8?B?MDAzbjZYeTZ0NmttSHQ4Z3FGT1JkTEZKaWhiUmpCQTd3Y3JHc1RDbVZGOC9s?=
 =?utf-8?B?UDZZWnl1VkFaRWxHRzNtdUZZSlMwUkVwOGlhOTlpbkp2Tkp4bFEzUGR3bFBB?=
 =?utf-8?B?TnBLMThNaldNM04yYXZRbldublBTVnlncGl2Zk5URm9jQzFDWjJqbU5DT2Fx?=
 =?utf-8?B?QnF5K2djcEZ2SmI4dTMxZy9LVW5kSnlJVmg3azVpS2NmN28yTEFhdU00ZENY?=
 =?utf-8?B?L3BQMXNzNDBQRFJXcG5PaG9PSjhMR1JReXY2NDR6MkQwUzFMdFV6UjZ0RWs1?=
 =?utf-8?B?ZU16V3lCOTU1cEgzdGNidWtvbzk4WWN2THhDTkdnQ1RCVFd3WjRQVHQ5S3BV?=
 =?utf-8?B?Sk1EemNYZ0x5bnQ3K1gxYTVwaDhXVFh3QVdxQzFSZW5DUW1xaDFkcjQvVTEw?=
 =?utf-8?B?TUhEUVhUd1RJb09MNXZvLzNBVmZnMW1qcm42K25VWXRxV3hrZVozdVRGNWVw?=
 =?utf-8?B?Q3hINm52UjM5VjNXSVNiNzhoenJFWWV6ZkZKQmcxTFkxZ3JXRjA5L0QrazQx?=
 =?utf-8?B?NGROTk1VVmxyS21NS2hUNHFMSVp2aUFncmtIY2VPY3QzdFlZV0h3SjB4MC9r?=
 =?utf-8?B?UnZjMkVoYm1jendJZlp0L2JaUWh5cWorNEpyKzdncFJRd1JSYldtYVE5Ykk5?=
 =?utf-8?B?YVdkbytXRURvby8wS1B3Si9BQlEzbXZINFFvUkRtU2VMSUtESXF5YmtWT204?=
 =?utf-8?B?Vy8wV1FrZ0NTQ0hVSllQWGFYUTRHMGs2VC96Tmw2Q2Zqa2xJcDczWElGaS85?=
 =?utf-8?B?bUFvWHQ4eFQyYTVocWpNenhJaDhDUFV6UkdaQUl1aEFGcXBCZkFqd0xVRS9r?=
 =?utf-8?B?L2tFdmNOL1lkemlGNEdiZ3VQRHRPQUlXbm41amJWZlExbjBFVlpmb3dBQUhX?=
 =?utf-8?B?MGc1WHFVMGVLbjJocUwyeEhvTURqN2ErYkoxRy90eEdoaVFsdk9UNFh6UlVu?=
 =?utf-8?B?QnJVVjVPQlgxRzVFT2FoYjBzQng1UzVPRHp3cmRDVjJ6M0NVWEtCdG5VeDdt?=
 =?utf-8?B?UW42UmlhQ2RGWXZMb0o3NVZCRm84WHo4NE9QRnJIN1BQaEVpaHJSdHgvYUpP?=
 =?utf-8?B?dDZzUFlKUDhHKy9QSU43VWl0K1BGdkdkQVpHWUlvRDNock5PdmFwcEZSYlhi?=
 =?utf-8?B?OUh4NG1Kd0hlemRzYjZLbEFBU0NWbDViZS8zaGNjUjNTN2NLM0NBbnFHaFp0?=
 =?utf-8?B?WHg2dFFYbkdBMUQwckhESjRyZmFWUkR1Wk9TeXRkVE9FQ0FPcmZ5Rm95OFph?=
 =?utf-8?B?Y1BVMmVVY3J5VlUzczZ2ZTR0c1lmRFJuVkNTc3FaN1pTQjh3Vldia2todUww?=
 =?utf-8?B?RUF6VU50bzByUU5EMWU2VHlMMnNSanpoUWdqdEtVem1PcWlVRUszbHdxVWp4?=
 =?utf-8?B?UkdaS2FSMmJJMGlsTFR4SHBIM2ZzZGphL1NPbWRZbUlWRjE0YnR4QXRYUUxC?=
 =?utf-8?B?QU13QTlVS29PQjA5RnYreTA4aUNHQW1tTTdLZ2RRVWJwSXlNUkRDdmpLcDhS?=
 =?utf-8?B?aFJmdG52ZnRheVNvMHN3K293UkRZVy9LVVQ5SWZyK3JOMS9IT2JqWGNjSWFz?=
 =?utf-8?B?UmdsRjIvZ1pxQncrdENlOTRrQ25GQThDRVJ4Z2RPS1FNaVQrclJTSU1vdDEr?=
 =?utf-8?B?SGlzS0wwc3hmdW5tSmZhdzR6VUdRZlFIcWlrS1J1b0dVcEJmZURIVGpJbXF3?=
 =?utf-8?B?RnBVVVh5QjltclFrNDRhTWp6Q3pQdDVITExzMDdEUCsyWTZkU2pXLzE2NzEw?=
 =?utf-8?B?dnhmWWJtZWlEYUJoWUt0dk5MdUl2bDlwWlVlTnpKM0RmbmMvbkhjcFVUMEcx?=
 =?utf-8?B?SE4zMG5hSENCSzdMTFZpdDh6WUJwRWFaTGpvbEh0QUExOEI5V0o5eFk2d0Ew?=
 =?utf-8?B?ekNGYzZldDVKblJFT0pMYk56UlhlSmZjQm1xZUdSUjQ3RnRaVExtRzZkejVa?=
 =?utf-8?B?Q3FqK3RZa1VFNml1V1VsMWMyZExsWmlsZm9tYUR5OEtZeFJuNHdObEl5eEFa?=
 =?utf-8?B?ZXRkTUZTbys4bkdRTUw0WlRycmpRQ3hsYjdlZHE2aFVGV2lGd0xjZ2ZuSjh0?=
 =?utf-8?B?RVZRVlY2QzQ1UllvbWNkc2czb0JoTitibjZyYXpoUG94WVpnN21kT01IM1ow?=
 =?utf-8?B?WkEzWUVWS1pBSEtNS0xQa0VBTGl2dWZPdkFXL3hDTFlWcnNpTXdndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f370aab4-eece-48d9-ff33-08df01be9ab7
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:03:46.1670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDqwSGj7OOovO2+yXercRUWIqEGDywfEhkbST39mXrr+OUUi6Fa4i+K+Wq30t5qA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
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



On 8/24/26 10:01, Johan Jonker wrote:
> Hi,
> 
> On 8/24/26 09:18, Michal Simek wrote:
>> A number of file (F:) entries across the MAINTAINERS files pointed to
>> files or directories which had been renamed or removed over time. Drop
>> these stale references so that every F: entry resolves to an existing
>> path.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>>   board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>>   board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>>   board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>>   board/Marvell/octeontx/MAINTAINERS                |  2 --
>>   board/Marvell/octeontx2/MAINTAINERS               |  2 --
>>   board/Synology/ds116/MAINTAINERS                  |  1 -
>>   board/acer/picasso/MAINTAINERS                    |  1 -
>>   board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>>   board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>>   board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>>   board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>>   board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>>   board/amlogic/p212/MAINTAINERS                    |  1 -
>>   board/amlogic/q200/MAINTAINERS                    |  1 -
>>   board/amlogic/s400/MAINTAINERS                    |  1 -
>>   board/andestech/voyager/MAINTAINERS               |  1 -
>>   board/asus/grouper/MAINTAINERS                    |  1 -
>>   board/asus/transformer-t114/MAINTAINERS           |  1 -
>>   board/asus/transformer-t20/MAINTAINERS            |  1 -
>>   board/asus/transformer-t30/MAINTAINERS            |  1 -
>>   board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>>   board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>>   board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>>   board/avionic-design/plutux/MAINTAINERS           |  1 -
>>   board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>>   board/avionic-design/tec/MAINTAINERS              |  1 -
>>   board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>>   board/bosch/acc/MAINTAINERS                       |  1 -
>>   board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>>   board/compal/paz00/MAINTAINERS                    |  1 -
>>   board/compulab/trimslice/MAINTAINERS              |  1 -
>>   board/comtrend/vr3032u/MAINTAINERS                |  1 -
>>   board/comtrend/wap5813n/MAINTAINERS               |  1 -
>>   board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>>   board/davinci/da8xxevm/MAINTAINERS                |  1 -
>>   board/embest/mx6boards/MAINTAINERS                |  1 -
>>   board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>>   board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>>   board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>>   board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>>   board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>>   board/ge/bx50v3/MAINTAINERS                       |  3 ---
>>   board/htc/endeavoru/MAINTAINERS                   |  1 -
>>   board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>>   board/intel/agilex-socdk/MAINTAINERS              |  1 -
>>   board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>>   board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>>   board/keymile/km83xx/MAINTAINERS                  |  2 --
>>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>>   board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>>   board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>>   board/lg/x3-t30/MAINTAINERS                       |  1 -
>>   board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>>   board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>>   board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>>   board/mediatek/mt7981/MAINTAINERS                 |  2 --
>>   board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>>   board/microsoft/surface-rt/MAINTAINERS            |  1 -
>>   board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>>   board/nvidia/beaver/MAINTAINERS                   |  1 -
>>   board/nvidia/cardhu/MAINTAINERS                   |  1 -
>>   board/nvidia/dalmore/MAINTAINERS                  |  1 -
>>   board/nvidia/harmony/MAINTAINERS                  |  1 -
>>   board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>>   board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>>   board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>>   board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>>   board/nvidia/p2571/MAINTAINERS                    |  1 -
>>   board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>>   board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>>   board/nvidia/seaboard/MAINTAINERS                 |  1 -
>>   board/nvidia/tegratab/MAINTAINERS                 |  1 -
>>   board/nvidia/venice2/MAINTAINERS                  |  1 -
>>   board/nvidia/ventana/MAINTAINERS                  |  1 -
>>   board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>>   board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>>   board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>>   board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>>   board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>>   board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>>   board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>>   board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>>   board/nxp/lx2160a/MAINTAINERS                     |  2 --
>>   board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>>   board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>>   board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>>   board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>>   board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>>   board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>>   board/ouya/ouya/MAINTAINERS                       |  1 -
>>   board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>>   board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>>   board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>>   board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>>   board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>>   board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>>   board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>>   board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>>   board/renesas/blanche/MAINTAINERS                 |  1 -
>>   board/renesas/eagle/MAINTAINERS                   |  1 -
>>   board/renesas/grpeach/MAINTAINERS                 |  1 -
>>   board/renesas/v3msk/MAINTAINERS                   |  1 -
>>   board/samsung/starqltechn/MAINTAINERS             |  2 --
>>   board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>>   board/siemens/iot2050/MAINTAINERS                 |  1 -
>>   board/sifive/unmatched/MAINTAINERS                |  1 -
>>   board/sunxi/MAINTAINERS                           |  2 --
>>   board/ti/am62ax/MAINTAINERS                       |  1 -
>>   board/ti/am62dx/MAINTAINERS                       |  1 -
>>   board/ti/am62px/MAINTAINERS                       |  1 -
>>   board/ti/j7200/MAINTAINERS                        |  1 -
>>   board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>>   board/toradex/apalis_t30/MAINTAINERS              |  2 --
>>   board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>>   board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>>   board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>>   board/toradex/colibri_t20/MAINTAINERS             |  2 --
>>   board/toradex/colibri_t30/MAINTAINERS             |  2 --
>>   board/toradex/colibri_vf/MAINTAINERS              |  1 -
>>   board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>>   board/traverse/ten64/MAINTAINERS                  |  1 -
>>   board/wandboard/MAINTAINERS                       |  1 -
>>   board/wexler/qc750/MAINTAINERS                    |  1 -
>>   board/xiaomi/mocha/MAINTAINERS                    |  1 -
>>   board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>>   board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>>   board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>>   134 files changed, 241 deletions(-)
>> [..]
> 
>> diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
>> index 0496cc93b599..8f677f3170b2 100644
>> --- a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
>> +++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
>> @@ -1,7 +1,6 @@
>>   GENBOOK-CM5-RK3588
>>   M:	Andy Yan <andyshrk@163.com>
>>   S:	Maintained
> 
>> -F:	board/coolpi/genbook-cm5-rk3588
> 
> Change dir name:
> board/coolpi/genbook_cm5_rk3588/
> 
>>   F:	include/configs/genbook-cm5-rk3588.h
>>   F:	configs/coolpi-cm5-genbook-rk3588_defconfig
>>   F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
> 
> [..]
> 
>> diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
>> index 79981aa43f13..0c7906acc992 100644
>> --- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
>> +++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
>> @@ -1,6 +1,5 @@
>>   ORANGEPI-5-RK3588-ULTRA
>>   M:	Niu Zhihong <zhihong@nzhnb.com>
>>   S:	Maintained
> 
>> -F:	board/xunlong/orangepi-5-rk3588-ultra
> 
> Change dir name:
> board/xunlong/orangepi-5-ultra-rk3588

Can you please send it as separate patch?

Thanks,
Michal


