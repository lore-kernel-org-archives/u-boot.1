Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F14CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4A98206E;
	Mon, 29 Sep 2025 08:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1LP7NXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4F683071; Mon, 29 Sep 2025 08:14:33 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471A18144A
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq19eNY7kEfxLTPVksKbJlStADgpVm0u5uz6F3GSKLqe24vE4GTnSAoq17RTdGFaX2AMa7FuDidcAKJOXxXgeNZCYrGLtwHQO23WQcFMky69elE55N9YMHtuB0BSjAlHMkZkwYFQQP5PW9GGKwq6dc+JAn9g0hSJQoBBzYppPGhEY09uuvwUBiXuXhymA2jw1NsEkloYY4i8a3GvQn6EhUdKkauSKzV/pO4otIhiCAJHAB4EbiYxN2nyYhY43e/edITK4A4N6x46qk+aI9i3SITQ1PDoh5GHo/qiwCuy8GY1EHPM0nRH5aA2PCx7LHsggLceqiXdn70KuLznxOf76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0j+4UvqkDOyq4AAEGZfB2TXHqYdevhMMxKb6aTj7mM=;
 b=ekSWB8g0TPaFTVx9juTyL6tDfcOYFzIbi6LDWZvSwr/dnqG5W1nJb0M0R90ecXmEtYJwb1l2nAXfUp/iRVc9hARHTF+M/oHvx6YOwphsBs3ditVyTUpfsb54knvDO6JaVMDEFrsL+k+XW4xRvPaKSK+TvrgTHqX3MkRe8RaGZZqtc670ZFsLR4363TjUgdwpww8l53v7fhaplfJh4rzYK/SJN67HHzTfHN3ivwz/5rs7veHge6WW/89ph8fSR/+QzShHzB8p2/tLwnnuQZEVYMAE+rsWXtc8a9kmHwS1jH6Fa5NWjMKCdvwZBFAiVoHxXHormFZX0AWDnCijeZWoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0j+4UvqkDOyq4AAEGZfB2TXHqYdevhMMxKb6aTj7mM=;
 b=b1LP7NXmHQ/8Xp7ptWjL37cKg5Hrke36bGK44Vf2p2U4NjAIuCjG+lSDBOV9j7wQV/xqOMxzQP8wpadVe3CZjhgEtAy0p5XkskEuJUJfLaiPTMY/gzSLhZ2sJNxmg2FC9En5RTxRnSU470dibvKV7Fjce7UtmG2vStNDn6B90kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 06:14:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 06:14:27 +0000
Message-ID: <67073eb8-2416-44ca-a97e-04ab5bcb3ab9@amd.com>
Date: Mon, 29 Sep 2025 08:14:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: add register initialization file support to
 zynqmpbif
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <CAEU2+vrO5KGeoWkDZGOkmL408R6SHqdGhq315cGq+mbq3XBz4g@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAEU2+vrO5KGeoWkDZGOkmL408R6SHqdGhq315cGq+mbq3XBz4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: db5007a0-f42e-4191-6070-08ddff1f71b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUI4UlpyNXdQQkcxUTFvTHgvdVJaYitHTDBIOERmRlFrK1d0aHJpZjRNcTV2?=
 =?utf-8?B?TlQyc1c0MXlMTTFNb3J0SWxhY0FkaWdScWxuSXd5anhJWWRBb3BsbTJXa3Bj?=
 =?utf-8?B?MUN1ZktLRlBvOFNya0tSMHFPTWRhOVZkTnkwYXV3YVd5RWZMRmVkdUp1MmxD?=
 =?utf-8?B?c2Zrdk5NZkJRUm05VlYyOGc3L25QdzlMWW9jeDZtYk0ybzZMZkJhZnptRU1Z?=
 =?utf-8?B?cnppSEdRTXNJOHd3RjcrRFozTWI1elFlKzBmbEdMcm5lQUlQTWx6RVprU1pC?=
 =?utf-8?B?SXM3Y0t4eFZjdHBTVzRTRDlRY1Q2ZkVLMFZLUVM2RVhVdXRKWjdpUEtTcmRj?=
 =?utf-8?B?amtKU29nVVVWb21COW5hWFZSV1dab2RkNEJQWCtGWGZIcUNWUVVRMGh5UEtQ?=
 =?utf-8?B?dlNkZ1V1M29KL0JRb3FmQ1YxWGdZMzFmWUJndlhCSlRQZ3dSanRGa1NaQjhI?=
 =?utf-8?B?c2FGZDM5NHZOakx5bC9qYUllTkFVQnhLdkNFVW1kc0F3NEJ6VG9paW9Ga2R3?=
 =?utf-8?B?L0tuV2d3eXNMaUFqdkNVTElGS0dHclN5cnhVT0lqY2pYVG1UbGtsMitHVGdq?=
 =?utf-8?B?Q2s4bGJ2Z3NibTVUWFRid1A3RWwrV2UxbkN4RzFCZjVSQ2s3ajI3Rk4vOE5P?=
 =?utf-8?B?TFRKb2x2dGJYaEFGQ2tpeS9Sd0JiVnJHZ2xPbkpXd0RuNmt5N0RLRWxjRFpO?=
 =?utf-8?B?dUMwNUVmb083QTEwdjR5TDB5aU1WMHp6bk1nOHBJdmNwbUFwcFNXeFBQVWdv?=
 =?utf-8?B?RzVaazFvSDRmdTF5c25YYWJSWVM3ZTh0VFJiUTZjenNkY2ZPOHg1ZWJ1RFpY?=
 =?utf-8?B?MmpldXpzeEM3L3hFNW9wVURxcXowcUJSOFhaTHN5MHVpeGtlYUcvVDRRZFB1?=
 =?utf-8?B?SlQ3WHEvZmt5ODNQcUM5L0Y3MFgvekM4dHNwMkxnc0Rtc2FsT1lIbE0zN2VK?=
 =?utf-8?B?Y2hZWHZIckNKb1ZoNGVaVW9Ocmx4VGJwSDl3a1pEaHNvMSt0aC93WUhDNEY3?=
 =?utf-8?B?WmpiZllYc1BoVmFmaTRLaks2cU4zVjRHdFcxZFlPdTFwK0xPbUFabjlmSElD?=
 =?utf-8?B?L0pWeTNaZkdSbnNLTlQ2aHArRUcrSmxkZ0xTN25pYm91T3d4Q0V2U3ozMHJC?=
 =?utf-8?B?QncyNjA2VkIrbTN0d2ZYNGJTdkJOeURIV1Bvdis5VHJoSHo5SjI1d3F5N0E1?=
 =?utf-8?B?cWNXd0Q5WWNlTzM0SGptMTFtQXptZXZFZEk4UGF2UHdvVHh2MGhldTc1T0Fp?=
 =?utf-8?B?YkRBNVd5VVpUWFVMYWNYaktMemxNSEFMUnp1TDZoYmtrbTgzOSt2NEowNmlx?=
 =?utf-8?B?UXE1NkxxQm40dFpacFRLa0FFa3h6Z1hjWktlLzM3R3F6cDdONHMvYW5WNlBq?=
 =?utf-8?B?dmcvaTlaeXNzaVVEaUV4K1h6R2w0alRLTFkvTDg3UzhIakRaaWs2c2VHMDhM?=
 =?utf-8?B?UmhLcUtVNGdidjNESHZwWVlFTXE5aFZGcHg1UjkvTXB4aVVWYW1YNEJXV0kw?=
 =?utf-8?B?SXBMRjVMc0J6SDU5VnNCblZCWWlmek9PVHUxT0lHWjRNeW9md1NlV1JaR0cz?=
 =?utf-8?B?TGNhWGhTU0w2ZEV6cVJQa2hXMlNCYUc5dkJTRWYvc3J1emtxSG5NMitJcno3?=
 =?utf-8?B?VUkycnNKNVFZSlBPRnNwQk11YVZ0aW01WEZ6aTNhNUdGVTNFMFF2eWpySFFi?=
 =?utf-8?B?emg3NnQ1OU43bFpwTzlUUElVbHdKWXJxT0dyMk9sajYxSStIc1lCLzVPN3dz?=
 =?utf-8?B?bllLUEk5T3k4di9WTFhkM0ZWQlJXVEdML2VaTHFxM0JHWER5c3VPaW9Wa2JD?=
 =?utf-8?B?SjVxdzM3U2h0NGlqbE5jTmRieWgxRDdKWEFXUTYzcmZpYXpYazhCelNYeFoz?=
 =?utf-8?B?aTJtUjNwMjFLNkJyS1dFVGo2amNOQXV2MThmTU5LMythY0FkRlhkMUMyemFU?=
 =?utf-8?Q?tZMN/RgefM7cmUyIG4c4Wgb+5It2xRBq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1N5TUxKK1dlRHNPTVk0NTYvajVIQlliZnZ5emtLc1RjZnN3TXR3UUZKN2JX?=
 =?utf-8?B?SCtCZi94WStNN0JvUUdyb1NZSmZtR2tSelY2K2lCUlJ3bVNZRUtUQi9DZVY5?=
 =?utf-8?B?ckVIUlRwOHliazdaNjRoYm15WWZtcGVjTjNuZU1Yd0FMTWZtYkc2RG5tbFJW?=
 =?utf-8?B?dzBQZ0lLb2l0ZlJIVVVpdm1jVXl3Q2FrRUJ6OVZlR3AwUVJvMUlQdjFsUGNl?=
 =?utf-8?B?cWo0UEY1c0luOURscGM4OXlJT0wrZHdyZmpmQ3R3aGpjbXZjaWdWdlRHa2gv?=
 =?utf-8?B?b0tnSTVUcHlhcnBab0l4Q092aC9nYjJFRkxXMTJSVXk5cVF1UGFyMzdNbHF2?=
 =?utf-8?B?Nm1ncmRQQjR3V3AzWXh0UkU4VXFXM1RsMWdHWkNBd1QvUGNrQVBTRTkvZGFj?=
 =?utf-8?B?cW9QblZ2TDFQUjRpNm00cUpwdXlFLzhadEpNem5id3hnckRJY09pSFJ3aXBZ?=
 =?utf-8?B?Z1dnMHRWcENlSnV1N0pzNmN4NUl4YkM3bHRTcGlqb2RIUC84Yi9XZlV2U1ly?=
 =?utf-8?B?dUZLQUZWMFlqR0tISVlVWG9zaVBNMkh6VTRJL0x1eFlXSXdlQ1kvNmZxQzBy?=
 =?utf-8?B?bzhaUU9lTE1nL2hSYzF0UGlEa1lINWRTWHM2eHEzS0s1b0t4NUhmeXZEbXlx?=
 =?utf-8?B?R3h2aDdsMHJSZzZweTRLSWxrRGEzcHRrQ0Uwelp5ZHYrVk53VS9DODhTbFBn?=
 =?utf-8?B?L0VaL1pYeEZnRjZOUFBtelNzQzJYL1NFazZ1TDFodVBTU1FUZlQ4UFMrZElB?=
 =?utf-8?B?STk4dlQ4Vk05WnJsQ0t4dE1FeVVzRmJOWGNwNXlZRG9NZmVyTTUxTmtBejll?=
 =?utf-8?B?OXRjMmxLT1JUeENkSHREaTNVSFdiN3NGSUpwazY4THpDVHI2KzhkVGZiVWRn?=
 =?utf-8?B?UE9oSUNieXRyTTA3eFIxNnpZMG85NmVmd29FdVRTVy9SNldRR3cxNGp5ZEVK?=
 =?utf-8?B?N1ZmOGQzbFhXK2tlbVA4NDhHY1k4alM4RUsvQVZZeFI0ZGVHZ3h2ck5zb0RT?=
 =?utf-8?B?R0Q3TXJHTTRNN0VIUWFzVUNyRFNSTy9sY21mWFB2aEJNLzhHSDhUbU9pMnUw?=
 =?utf-8?B?dkpvUXJtUVdrYk81ZXFHcUszUm1DR1FScEhXWlp3NHAwbGNiclkxelN4SWc2?=
 =?utf-8?B?OFhKZG1Pd05hWWpQbHhFSXJKVGx3SE8rSWxDQllON0VDeDBkb3MrTjhTU25E?=
 =?utf-8?B?a213c0dKaW4vbTNUUDRGMnJmSFNSYkVoOHRmT2xPeGxWcnYzUnl0WkdrY3lk?=
 =?utf-8?B?NGkyeXVSRXRpc2FSN2pUY1ppRE5Ba3kzT2R5anhSVk1weUdZUm5MTlNqV3lw?=
 =?utf-8?B?Q3V2OXJVaU90ZEhSTEJRWEcwV096dkVyOExUaXZEZ1JsMGQ5YnpROVo1a3Iw?=
 =?utf-8?B?RWNsRkNjS3hvSFlTKzVKekEwTGxjUmRvK3RTQlhCODFCVEw4Q0RHaHRrM0xt?=
 =?utf-8?B?dHp0WlV3WDJRSmRPSllvTWZnUFlFeVFJMTNCczRUQjRqYTFnZk1VbllvUzVp?=
 =?utf-8?B?VkpOMG1CZk9RemhScWo5bS9uNmZLaysyNWhaZ2c0Qml3UllMTFhHZ0hWMmQv?=
 =?utf-8?B?K2Fma0xYeXhkbm0zdlAvSytlazF1dmVDV2xmc2hjOWlRbVp3aDZKNVpXL3I1?=
 =?utf-8?B?bDhkZ3lNSklJUHJHNjhSdm54SDhxU1FwZGxVMHI3Z2FGQms1d3FYTk53dm8w?=
 =?utf-8?B?bUZ6SEpoRjgreXpDWjFEdFRKcmwyLzhwUDVqWkU2KzRHTzZudkszUkwwR2ZC?=
 =?utf-8?B?RWRCb3FTY01iaVhyN1BKcVNxdWdUNUp3clZ2QzU0QTZ2a3NDUHhlcVZIdEEr?=
 =?utf-8?B?R24zTDVmNUJHR3BlYUdNN25KMzY0cEFYZGcwY0xMQ3F6dy9VR0ZiQ2ttMUJt?=
 =?utf-8?B?OXE1Z3dyWDNwdlRZamZWSXdTUmI1T0RrZmsvd2JXSG5Gak1sUHhKc29WbHEv?=
 =?utf-8?B?Q3FxQitZTExBMTFRK2dzOWdNejJwZGl2WE9TNitYTUltYWJ6ZkFVOHlpV1VR?=
 =?utf-8?B?K1lpMmhzU0ZUdWNCLytGeFhYV3VOc1o2QWxUd1NYOXlsRHYxVHROb0VCQW1W?=
 =?utf-8?B?blp2dHdnSVV6VHh2ZWFJTmZxYWJHMzlkRm5mcVl5eHIvckMxcnF5RkRpM1c4?=
 =?utf-8?Q?ER+yCa3T6U7cHVRs1mqhVpCTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5007a0-f42e-4191-6070-08ddff1f71b7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:14:27.6372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC8X69TSDrXLjhOqK/+8CF1toR8EcwY2+UqDRv+H3L/j4k0/A1cyb3YNpEo+V8IM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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



On 9/16/25 23:56, Erich E. Hoover wrote:
> 
> The ZynqMP Boot Image Format allows specifying the register
> initialization file with the "[init]" attribute.  Since this
> feature is already supported by the "zynqmpimage" backend, this
> patch implements a binding to that existing support.
> 
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
> ---
>   tools/zynqmpbif.c   | 16 ++++++++++++++--
>   tools/zynqmpimage.c |  4 ++--
>   tools/zynqmpimage.h |  2 ++
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
> index 82ce0ac1a52..546b9e4fd9d 100644
> --- a/tools/zynqmpbif.c
> +++ b/tools/zynqmpbif.c
> @@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line,
> struct bif_entry *bf)
>   }
> 
>   static const struct bif_flags bif_flags[] = {
> +    { "init", BIF_FLAG_INIT },
>       { "fsbl_config", BIF_FLAG_FSBL_CONFIG },
>       { "trustzone", BIF_FLAG_TZ },
>       { "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
> @@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t
> len, size_t *offset)
>       return 0;
>   }
> 
> -static int bif_init(void)
> +static int bif_initialize(void)
>   {
>       struct zynqmp_header header = { { 0 } };
>       int r;
> @@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf,
> const char *data, size_t len)
>       return 0;
>   }
> 
> +static int bif_init(struct bif_entry *init)
> +{
> +    /* User can pass in text file with init list */
> +    if (strlen(init->filename))
> +        zynqmpimage_parse_initparams(bif_output.header, init->filename);
> +
> +    return 0;
> +}
> +
>   static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
>   {
>       size_t parthdr_offset = 0;
> @@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf,
> const char *data, size_t len)
> 
>       if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
>           return bif_add_pmufw(bf, data, len);
> +    else if (bf->flags & (1ULL << BIF_FLAG_INIT))
> +        return bif_init(bf);
> 
>       r = bif_add_blob(data, len, &bf->offset);
>       if (r)
> @@ -837,7 +849,7 @@ int zynqmpbif_copy_image(int outfd, struct
> image_tool_params *mparams)
>       uint32_t csum;
>       int bldr = -1;
> 
> -    bif_init();
> +    bif_initialize();
> 
>       /* Read .bif input file */
>       bif = read_full_file(mparams->datafile, NULL);
> diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
> index 4db9877127e..eb79c0696cc 100644
> --- a/tools/zynqmpimage.c
> +++ b/tools/zynqmpimage.c
> @@ -400,8 +400,8 @@ static void zynqmpimage_pmufw(struct zynqmp_header *zynqhdr,
>       fclose(fpmu);
>   }
> 
> -static void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> -    const char *filename)
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +                  const char *filename)
>   {
>       FILE *fp;
>       struct zynqmp_reginit reginit;
> diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
> index 7c47dc0763b..867fc5294a3 100644
> --- a/tools/zynqmpimage.h
> +++ b/tools/zynqmpimage.h
> @@ -142,6 +142,8 @@ struct zynqmp_header {
> 
>   void zynqmpimage_default_header(struct zynqmp_header *ptr);
>   void zynqmpimage_print_header(const void *ptr, struct
> image_tool_params *params);
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +                  const char *filename);
> 
>   static inline struct image_header_table *
>   zynqmp_get_iht(const struct zynqmp_header *zynqhdr)
> --
> 2.43.0


Not an issue with the patch but your patch is in utf-8 instead of plain text.
Please try
b4 am CAEU2+vrO5KGeoWkDZGOkmL408R6SHqdGhq315cGq+mbq3XBz4g@mail.gmail.com
git am 
./20250916_erich_e_hoover_mkimage_add_register_initialization_file_support_to_zynqmpbif.mbx
Applying: mkimage: add register initialization file support to zynqmpbif
error: corrupt patch at line 12
Patch failed at 0001 mkimage: add register initialization file support to zynqmpbif
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.

Please fix it and send v2.

Thanks,
Michal





