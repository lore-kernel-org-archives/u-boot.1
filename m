Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B828C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA5D81B4B;
	Mon, 14 Apr 2025 08:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MapQ3ix5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F9781CAF; Mon, 14 Apr 2025 08:48:52 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C090810EB
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frLB6YtCgoyoTLaVvujthu50Z1d865NnT5uIcy5AfE+tE9wZpkieC6MF2oL+ghndGW7XFem8JE6kCnuzV9Gh7IuaD0d8JhxhWrV05+riFbQbmAO33rZcAvZ0aJKT9kxBWzpwdL6NGFTpnfh+AVV9aa8KTZyFP4ZonLTs7eh40RZklTQuhkeCib7XLOL4e9ORdVth44Ru9ogMdFuVh6ggZfzBX4Bp7k2x9F1DF3oZ7Gd5vZ0ypKCBJ87d7H5TMRfDZB6nWJgkmsoORASrXXNgp2lQMUXobwoGiFx+4G1BjGfL/xxTEyVg/WyuJRglED3Ie5h1jZq6k2GBZc/4tyO+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzJG7kxKFMpSFdFdkGk7ZpAYOVhX8z5MwLMuKVsGwYQ=;
 b=LMScXP2wOvSj/KdDzeGW/YD4yffQreIprBpyPrqejDav8BcjwsDERNBbwFjNaX0/baH89M5WOCMlUEEoTiOKpVIZeth+yQNlkPbTZiOFjnpDmXO5WmsP0UD9zr9r6D5K5PObR89UV4zc2xEzrQLUlhTRF125R74ItZfOakxkxk0tDvvuMXiZDE33Hc8FW7TkMlKx1iNn4/D6eslveFO1qmKlZ+SgNcWRKcr0cCLvZ3S4bEuHfhhLKOGLnuBP7H6PqDdM/8ZCkuEJuEUof+pTEn74BVI2AopDAgDE3QewvnJbTI/HuYr70sHOnc/HXqYCw2FtxuD9rwwyKHbpBUvxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzJG7kxKFMpSFdFdkGk7ZpAYOVhX8z5MwLMuKVsGwYQ=;
 b=MapQ3ix5FeI6909E8YLSRA+en50n6HM1J69IkLZtXyT+Qf0FOwC55tcnz9nGYEzEsuzAg1WGar6Rj2+chm40XbL3rqNDQMhDToGViQQQGgfXFE5Xc05u7IJLAe06qUrzVggGcsPow1vc3IED9hxs+DkVyb8OwLIPIlC094ZEyQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 06:48:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:48:46 +0000
Message-ID: <91fba3f7-6e61-4b8e-a1c5-7e0eb2af2ebb@amd.com>
Date: Mon, 14 Apr 2025 08:48:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] board/BuR/zynq: initial commit
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250404072819.69642-1-bernhard.messerklinger@br-automation.com>
 <20250404072819.69642-5-bernhard.messerklinger@br-automation.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250404072819.69642-5-bernhard.messerklinger@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0046.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: b96392b4-0021-475c-069a-08dd7b206788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXp1UlhyREc0L0Z1c1RDTWZibmE1aWhiczVVMTlSNEYydE9Xdko2T2RDMkVS?=
 =?utf-8?B?UzF5U09aMnRqaTRVZERBUDk3RFROcFQ3a1o1M1c4RkhpU2VqbXNmcVpKeUo3?=
 =?utf-8?B?V2tuLzVQVjRYS3JuOFNPZm5wZlRYMGFsS3VUejA5U2dhYnBGdGZCQUpmMVNG?=
 =?utf-8?B?dmh2aDJVSzBpTzBVMDZIMkVMdnFDM1pyK1F1NVBRY2w3RDlvcjVaY2hVaFl5?=
 =?utf-8?B?RDVMbUtja1NUVldEQklPa0R3UkR2VUdabis0NU1VU05PaUtlNXhjNDhxUjJn?=
 =?utf-8?B?M1h0VG8wbktDcHFOZkZ2Y2pjYlUwMVdBaVBrMURwWjRaRDJ6WFZrUFNsT0oz?=
 =?utf-8?B?Q3pYUTcrd2doNlNRTFhBMVRyK0hHdGdDRG5KQ29oQVVHQmlwWFliaFdMUHRD?=
 =?utf-8?B?bURpbm1QMnB6VTVQYzhvL21YcTYxbUpoOGI5NVlLODlyQ1ZId1JuYXlkWnJR?=
 =?utf-8?B?T09tYkh3Sk9lZXRKNGpxSmNCRnlXUVBkYkxHNWpZRXh6TysxMGh0MnBDY0F4?=
 =?utf-8?B?cS9qQy9Bc01JQ2puS3J3T1ovMzBYZng4ME5RWktsaGVKZXdjZkdRMzdxdm1i?=
 =?utf-8?B?cDJScDZ1d0toZkxhdzBRMFFFb0czelk0WWlMamZ1RDd4Qmlwams5b2pvbXpF?=
 =?utf-8?B?a1V3bU9rVlpRTEQ5NjZtSExyeHBkVHJIRW01TTRaUkxSQlJtWmFMWHc1OEdz?=
 =?utf-8?B?MUp1cXJFVkU5QjJyZW9rcGVGWEcrV0VoQmFyOENIYVV2c0dlcW5mdEhJMjF3?=
 =?utf-8?B?S2hXMEJmdDZRVkFLQVpqYm91b0s3QzE0aEZsOTVrTFlBVEdUSmVoWmRyNW8r?=
 =?utf-8?B?ZitqTUdUNDNwdU9wNTdKZmZqbjNRd0tSZ09wRzRFRnd0cUhoSEVqNTM5emcx?=
 =?utf-8?B?UWdneEQ3T081Um5nRDc1bzJqNk9mb0xQdGN6dE84ck9MRC9EN0QrUG9haVlo?=
 =?utf-8?B?akw1SlJiRjMyaDgwcUVVM3JpYkc3TE1FZ215V0VCZTQzdVFHVDNwVTVORUp1?=
 =?utf-8?B?Zkg5dnF4aThXYmRHdVNmVzVES21QOHZxU0VuV2FIWWhLR2N5UnBWWjkvZlE3?=
 =?utf-8?B?VTFaWEw2Yy8zNEtTdkY0cGloWHRKZzRybTl1UHJLSzdsd0ZUR3k1TFNac3JF?=
 =?utf-8?B?QWxaaklTczlUNEYxYWNBd0ljaFBZOXkvbFZVUUlMZ1oxL2YvMmVBQWhNUEN4?=
 =?utf-8?B?SWJiR09ZcjdQZEhpbzN2amtsWDBleVFMeUMrSGdaZ0NPT1J3N2RlUjlaTlFO?=
 =?utf-8?B?RHREUUdlbkFwR3k5VE5XY0FrN3VURDJ0YlhsTXJnMVRkOG1pSGtFS1dpVkJS?=
 =?utf-8?B?REdwQlBIYXBBWnFzc3ZVVGZpTmIyUU9IRExrYUhZenRoZ0xSdGQzL2dLZGdm?=
 =?utf-8?B?Mjl5Q0VBTUVIVngzbUxRTEhmK3Z1RWNkc3ZmSzVPdUdrWVIwSDFKcW1ZYzB2?=
 =?utf-8?B?OWJuNmpaMHp0anRDTStDUEhSL3JFNWErSGNFc2tOOXlhZEpzcnV0VVFIZDdH?=
 =?utf-8?B?RmQzZW1yZ1pLQ3Q0N0IwK01JazVYWnpPRGc0cDY4aXhuT2VMUkx0dWd0MGRl?=
 =?utf-8?B?VTl2azJQYnl2U3pTVWxUa0ZaM3hSVVgvVzY3Yzd6YlZxRnA2NlBnMit5dS9R?=
 =?utf-8?B?QjQ0M3lZaGhGU3l6MkRZRTdWbUtSNHFoZnFaQ1V5SEtrNWhpcGRvejZiRktw?=
 =?utf-8?B?dnpvNFovZ3YraGtRTkJzdVQ2UmZHbjRGdXVKTFdoaFZ1WjBENENYWldzVHNs?=
 =?utf-8?B?WkJJcjFnbGFLZ09SUHk4RjVySTAzaTJ6dXhRWGNCQUVaSmI1MW83Ukgrek8x?=
 =?utf-8?B?UE5WYWJpSnFEVkZGcU02VGpxMXZzc3lwZmZPU0I3RzExWGRXSWFEVlBkVlRP?=
 =?utf-8?B?MDF1WU5LL3J3VTJudDc4V2NldFVGaG01L0Y5cTdUSGdNREtaMTQ3b2hOa0J5?=
 =?utf-8?Q?zCzFJheP0EU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1LV09SYlRoNi9YSDZCUEJ0cmZra0pjTHBhYlF1Y0NpWmthWklrM1Mwd2N4?=
 =?utf-8?B?NWcyRU01ZnFhZWpVZEpLNWpDd0JMdDIxcUlpYUl4Z0VWYjV6Q0Z5OHpxdUZs?=
 =?utf-8?B?eGpvdHhLZW9sbjFaK1BsUExVOVJ1eE14VHhaRU1Rb3hXUk9LZlMyQWQ3YzJu?=
 =?utf-8?B?NmdIOWtLcHpIdGtJM1RmejFoVkFkU2c5UkkrWlVpL3B3eC9uWmxVRWpRbDV1?=
 =?utf-8?B?bExCYTNtYjlyODhsWmRXaHhNU0FlRkJYQ2EreVFOUmc4WVRZZW1IdFR6N1dt?=
 =?utf-8?B?Q2ErS2RhRGpkR1lmTXJaUkdTbTRhN1VlMkw1YzJ1c3dHcHo1ZDQxdGpjN3di?=
 =?utf-8?B?NjlpamNkT3l2M3F6YXVoSDJSeFc5RjZOSzBXYlhzb3UzbTNZWVo5aGJ1bjdy?=
 =?utf-8?B?amh2UjR2NVY4dWJ3TGVicXd3TkdZbThzb2tlRm1mTVpPWWIxdzYzZHVCem5n?=
 =?utf-8?B?SW91ZE9NUnZlUml5akpnV1ErUDBsalljcittRXBDNGg2L3JkbU9FWkpYN3VM?=
 =?utf-8?B?cTZLY0QxaUI3K2xpSkZsZXJ5cUs3SkhreU1KWnNpeGlGdUpnVmhtZkNpZDdn?=
 =?utf-8?B?SjdYcjZkenpCYkZZMU1UVk1xdnhxbUJzaW5ZdFVsZkVoZ3NwaHl4S0pMMHRz?=
 =?utf-8?B?WWZDMHNyZVg1NmI1d0dwMmtBQmFHYS9KTThJTm9NdWF6cXZaUkU2QW5LYTdz?=
 =?utf-8?B?TDRwRWQvU0wvNDhyZWZaWnRWK1ZJY2Y3L3NvbW9zb1kyV0Y4ZS83Z2JuNXEr?=
 =?utf-8?B?Nnl0NTZ0bmZDR3dvZmdtUklzenN1eXZ4ZktqbVp4aU1QbmZwYVFPQTRWZ2Jl?=
 =?utf-8?B?Lzlxb2swVWJCd1ZVWS9sVHp6ZHFXVFBCKzE3TE1IelJtc1JiZHVRNEdXVnBW?=
 =?utf-8?B?WkQ3S2ZWeVAyQzkrRjVMZHdFcjUzYWFWRm9qRzRtcEZpZC9KWVI4a1d4TEZ2?=
 =?utf-8?B?VEpacGVhMytFVnNNbUdmNFVHelRwc1ZPSWlZQkdzZHlEUFM5czF0Qk9aNWNs?=
 =?utf-8?B?VzR5S0drWE8yVXBodEdzcVo1dUpGamtTV096dWhuTDZpRWRzaWN3dWNPakZz?=
 =?utf-8?B?ZnFOMlowR051VVVHbG1tM0g5YmdsZ1Q4dkRScXp0RG50SmtEaDJpZ0E2cTNj?=
 =?utf-8?B?ZTVsdkRGRklQd1hlVEVXVWZaUnZHdmMrZVEvcHJyVEFzMzZLNnhVQVlkRjly?=
 =?utf-8?B?WFZPWWJ4WWlyVHd1a2NWS2dMUDl5VGRqOFJNZWI4UmwxV1Z6ZnMvZ0VHakFY?=
 =?utf-8?B?Z3VTZEZlaFM5Y3hjNXFKaHYxMUc1cXExL3ZvaEZwWFE0d1Nxa3hXNUkwUlJz?=
 =?utf-8?B?NGczSE5sSFQyc3RIaFZRcFFucGJTS3hoUlUxRDVZWFUyZUtxNjlPUVZ2VmVR?=
 =?utf-8?B?VFNBM1YzVEpCa3JrZXdaK01iejVvem1TZ1hSem5OY25mMHdxaVdxSEJLRERO?=
 =?utf-8?B?UHlBekJQcmVHMjJUZ1BKbmkyOFJwdzYwUU9OZS9DUlBtQm5RMmNDdDVOYkRx?=
 =?utf-8?B?N3ZQZG1oUjd2amVtaDhrUlhFVUp4QU1QSUFtNGZpK2hoM3JsTUJLeVZZVUlW?=
 =?utf-8?B?cVR6aHNEQmFnMGQxYldwQmhXakE2aXBpaFQ2WnBvTWh1ZkFVMUUyK0ovVlZt?=
 =?utf-8?B?Sk1DaVVGNnBPa2tjTzgyK2s3TjQzVVc4NWgxT1JLWDVTNU90Sml4WVp3Tndu?=
 =?utf-8?B?STYzVWkzZ09meEJUWXJHOGoxQmFtdENUOENkKzFKZzdWZXE0Y0tFQjY4UTRP?=
 =?utf-8?B?L1RvOXlSMTNkbUFES01ISzhPTkVjWGhxRzZvVmVYMEtuTU1EVHJRZll5QmJ6?=
 =?utf-8?B?bWVOcjlqUVpEcm1MeFBVMFd5SUdPQzJ2L1RuaWs4THRheldvU3pYTFNmRm9l?=
 =?utf-8?B?V0JyeTNMcml6SkxoVXdiTmk3eGIyUXcvczQvcEhjS1QzcEFEcVFlVnZOZEtH?=
 =?utf-8?B?RmVYeUJtT1MzWC8wenhjcmtkbnc2VW03K29EYTl0bDZMbjdQU1BZOEwwZHBF?=
 =?utf-8?B?WEZvbjRSbE1lVEUwT0tHQ0NsZFZzV2tZYk5XWklmL0lJamxLbW9oUnZDMnpl?=
 =?utf-8?B?QUVodmFkVy9kVXJlOXNPMjhFVjNMRlBQYTQ1Z2xjV3ZTZWRzbzZ6UmFKWXhP?=
 =?utf-8?Q?LiyfgoVd7yoPS/Vc2DWLIym/Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96392b4-0021-475c-069a-08dd7b206788
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:48:46.4317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWtqmIlPJjBFh3ee48LjGUDh8yLlbp0gcqj8qlNtL2cJpcD8yKeZAYq9eVGVfP86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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



On 4/4/25 09:28, Bernhard Messerklinger wrote:
> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
> boards. This boards are based on the Xilinx Zynq SoC.
> 
> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
> ---
> 
> Changes in v4:
> - Fix device tree Makefile to only build B&R Zynq device trees
> if the target is from B&R.
> 
> Changes in v3:
> - Split spi_flash and qspi controller node in device tree for the usage
> of bootph-all
> - Merge binman descriptions into one zynq-binman-brcp1
> - Add links instead of manually including u-boot.dtsi files
> - Remove empty MAC addresses nodes from the device tree
> - Seperate B&R Zynq device trees in the devicetree Makefile
> 
> Changes in v2:
> - Remove all unnecessary device-tree entries
> - Reviewed led names (no pattern restriction found)
> - Fix maintainers file
> - Cleanup of code
> - Move preboot variable to env file
> 
>   arch/arm/dts/Makefile                         |   7 +
>   arch/arm/dts/zynq-binman-brcp1.dtsi           | 102 +++++++
>   arch/arm/dts/zynq-brcp1.dtsi                  | 131 +++++++++
>   arch/arm/dts/zynq-brcp150-u-boot.dtsi         |  34 +++
>   arch/arm/dts/zynq-brcp150.dts                 | 173 +++++++++++
>   arch/arm/dts/zynq-brcp170-u-boot.dtsi         |  26 ++
>   arch/arm/dts/zynq-brcp170.dts                 | 139 +++++++++
>   arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi        |  30 ++
>   arch/arm/dts/zynq-brcp1_1r.dts                |  28 ++
>   arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi |   1 +
>   arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>   arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi        |   1 +
>   arch/arm/dts/zynq-brcp1_2r.dts                |  21 ++
>   arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        |  30 ++
>   arch/arm/dts/zynq-brsmarc2.dts                | 157 ++++++++++
>   arch/arm/mach-zynq/Kconfig                    |   1 +
>   board/BuR/zynq/Kconfig                        |  14 +
>   board/BuR/zynq/MAINTAINERS                    |  11 +
>   board/BuR/zynq/Makefile                       |  15 +
>   board/BuR/zynq/brcp150/board.c                |   4 +
>   board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++
>   board/BuR/zynq/brcp170/board.c                |   4 +
>   board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r/board.c               |   4 +
>   board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
>   board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++
>   board/BuR/zynq/brcp1_2r/board.c               |   4 +
>   board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++
>   board/BuR/zynq/brsmarc2/board.c               |  30 ++
>   board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++
>   board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
>   board/BuR/zynq/env/brcp1.env                  | 109 +++++++
>   board/BuR/zynq/env/brcp150.env                | 119 ++++++++
>   configs/brcp150_defconfig                     | 121 ++++++++
>   configs/brcp170_defconfig                     | 120 ++++++++
>   configs/brcp1_1r_defconfig                    | 120 ++++++++
>   configs/brcp1_1r_switch_defconfig             | 121 ++++++++
>   configs/brcp1_2r_defconfig                    | 120 ++++++++
>   configs/brsmarc2_defconfig                    | 120 ++++++++
>   include/configs/brzynq.h                      |  21 ++
>   41 files changed, 3852 insertions(+)
>   create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150.dts
>   create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp170.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>   create mode 120000 arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>   create mode 120000 arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>   create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>   create mode 100644 board/BuR/zynq/Kconfig
>   create mode 100644 board/BuR/zynq/MAINTAINERS
>   create mode 100644 board/BuR/zynq/Makefile
>   create mode 100644 board/BuR/zynq/brcp150/board.c
>   create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp170/board.c
>   create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brsmarc2/board.c
>   create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/common/board.c
>   create mode 100644 board/BuR/zynq/env/brcp1.env
>   create mode 100644 board/BuR/zynq/env/brcp150.env
>   create mode 100644 configs/brcp150_defconfig
>   create mode 100644 configs/brcp170_defconfig
>   create mode 100644 configs/brcp1_1r_defconfig
>   create mode 100644 configs/brcp1_1r_switch_defconfig
>   create mode 100644 configs/brcp1_2r_defconfig
>   create mode 100644 configs/brsmarc2_defconfig
>   create mode 100644 include/configs/brzynq.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 267b0179a5f..10c1e34713a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -297,6 +297,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
>   	zynqmp-zc1751-xm017-dc3.dtb		\
>   	zynqmp-zc1751-xm018-dc4.dtb		\
>   	zynqmp-zc1751-xm019-dc5.dtb
> +dtb-$(CONFIG_TARGET_ZYNQ_BR) += \
> +	zynq-brcp1_2r.dtb			\
> +	zynq-brcp1_1r.dtb			\
> +	zynq-brcp1_1r_switch.dtb		\
> +	zynq-brsmarc2.dtb			\
> +	zynq-brcp150.dtb			\
> +	zynq-brcp170.dtb
>   
>   zynqmp-p-a2197-00-revA-x-prc-01-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo
>   zynqmp-p-a2197-00-revA-x-prc-02-revA-dtbs := zynqmp-p-a2197-00-revA.dtb zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo
> diff --git a/arch/arm/dts/zynq-binman-brcp1.dtsi b/arch/arm/dts/zynq-binman-brcp1.dtsi
> new file mode 100644
> index 00000000000..3cc8ee8b810
> --- /dev/null
> +++ b/arch/arm/dts/zynq-binman-brcp1.dtsi
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 B&R Industrial Automation GmbH
> + */
> +
> + #include <config.h>
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@5 {
> +			filename = "blobs/cfg_opt.img";
> +			offset = <0xD0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@4 {
> +			bootph-all;
> +			filename = "blobs/bitstream_update.bit";
> +			offset = <0x400000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
> new file mode 100644
> index 00000000000..ebaf42d9419
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1.dtsi
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP1 CPU";
> +	compatible = "br,cp1",
> +		     "xlnx,zynq-7000";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +
> +	pmic0: da9062@58 {
> +		compatible = "dlg,da9062";
> +		reg = <0x58>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	max-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/zynq-brcp150-u-boot.dtsi b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> new file mode 100644
> index 00000000000..1bfd5f27a7e
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include "zynq-binman-brcp1.dtsi"
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +};
> +
> +&spi_flash {
> +	bootph-all;
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +&rs232_en {
> +	bootph-all;
> +};

nit:
All these nodes with bootph-all don't need to be here.
The reason was that flags (especially previous one) were not the part of 
dt-schema. But now it is that's why there is no reason to separate them in 
special file. You can simply add them to zynq-brcp150.dtsi

Visible also with some other files below.

Anyway I don't have issue with this patch that's why feel free to add

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

