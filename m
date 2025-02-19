Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D81CC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6B5807C4;
	Wed, 19 Feb 2025 14:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6WgUJ9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F75780EBD; Wed, 19 Feb 2025 14:24:38 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A15801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 14:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw3TVkno1xZ3JAQBEkycCNHf/M+j7IvIAr2JOlt9+8YRKS7KedHr9iOGLieBy+aV5sy0y98V/OEl5bE7Atjy4GsBwwNOEamXJpOHpWp+07nCftEIpYUtayMA0S/NWAwYzK2+pkPh/jNKp2/NESG/xFlLw+oPONkDxEFadcqdzq5tZM922RfMkVhQlTRL40P77GEFPtjF5v3Fi1Ns1IHMfMYZpqCXtb0KFZYLAvdL4lOvybdU1Xq6U41U0Ds0Po43gpMxS7V33qXHuJx2ZvasF5RXygzYDGIZeUxQwzcOGhX+F4tfsGqYlp1XYeixHQ5Gh8p2vRAOORknD1tgMVgxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+hiWA5Q+N2HhUtkZ/HX9SS6HKw03ZmbmaH5M7dF2F0=;
 b=LCmdTbgQiHcQ4TyUxLYQGg6RfBcZDhHIEG4Gh32p8BOce3b7MvXiZIU4IOaUkIvMIjdpeYpfeemB5Zv4RDWt7leZx47dik+JQ7drdU1K9MdbMX6bN9wYyqGu1XNY1cH9itHM3MDY/YXdgJBtEvNV+tP5yqD02WkqM33mVbpns6rjh5tE4Ek5C38zr3gZ5j07CQBUT6nuCT3vA/GAphtVBwqOTPkt+i5aH/Pz2Q06OUqu3p3H4iM3OR7o25zPWo6NBSm3h6/HuBqWSswO5gNJHSu3lN19h42+ho8UmUqs6zTYVov5yeuVb0q+M2IGU9WCcm1a6ilpTJgRBt6LRPYMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+hiWA5Q+N2HhUtkZ/HX9SS6HKw03ZmbmaH5M7dF2F0=;
 b=D6WgUJ9zsbTeI4HPJB/3NCoL6AY6ZKl+vkxvuPQfSqHSPolurIsqB2kl4gf/opFNJIgYnVx6gtFG/K+SdvrVTgE+BaTMF7ip44QPB/KFjG+8mhkPgHS4UOY30r5ie0+x+bMCWLyT22CilxfM0uKJiC29pHlGv8XiVf3w7azUzxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 13:24:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 13:24:31 +0000
Message-ID: <10a0c946-9203-4a2f-a66b-8693a0eda2b8@amd.com>
Date: Wed, 19 Feb 2025 14:24:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: versal: Consistently use enum tcm_mode
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250206213039.42756-1-marex@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250206213039.42756-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c8a54b-6faa-4cd9-cdad-08dd50e8be9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STQ0MFpEMTNCR3M1TmVCWFpaU21iZFFnZkpkTUtLWjBWbFYwbWZOS2xyNCtM?=
 =?utf-8?B?bzhhOEFITEZ4TU1oQXBGNVhzSCtnWEVFK3d2UzJUUjF6VngwVEZUamNQbjVS?=
 =?utf-8?B?UUNRQXozNU9YMzM5Tm1vOGxib1dqcHpiQUNzTFd1Wnh0RFBRVnV4M0FyZ1Rk?=
 =?utf-8?B?RGZsV3FJN25OWmc2Z21udmFMNEl2Wk9yUW5Wd0o0U2R2ZlJhNFNheWdWYzJz?=
 =?utf-8?B?Mm9aQWRZOCtya2JTNDRrNEgxeHdaUmpwdEVYbEJtTlJoaERkOEk0SEU2NkRN?=
 =?utf-8?B?Q2hnNGxmeStubHpXUDlsZFVKaEJjMnRqS0lWTDM1TkdSdWZHcnpMQ0k0Sldy?=
 =?utf-8?B?WmxPQXlGdlV2YVNSMkdOczcrSk1obmV3ZTNENEtPUGZBQzRjU0Z6Y3Ryc1o1?=
 =?utf-8?B?VkdVd1Vjcm8yWXJzZm1WOGw2ZkI2Qm14RUtUSFBkQXFRdEdXVjlpUk5xYWFk?=
 =?utf-8?B?eTBMWFpLZk4rTHhiRWlxSkRxbDFHQUlDRXBBRVMzbnFaa1dRblR2Q1A2OVFp?=
 =?utf-8?B?L2ZTQ3lHWjNsSVdnM3Y3Mmg4V3FiWkNzTWVoRHgzQ3R1TktJblJhSCtpR3dK?=
 =?utf-8?B?WGdjMjNsVFg1N3BnVm8xNllHbFBlRXNwZno5a3h1YzFORmpncTdDb1I0TTYx?=
 =?utf-8?B?M3NPYkhSWnNod25hZm9zY3MrYUF4ZDV0QlkwTy82d3IxNVJrUGNPV1RWOHBX?=
 =?utf-8?B?OFFFYWFuQjcwakYxblhEWnBXQmVaV0FnZklxUEpuWkw4Zlc1NGhqYUd1ajBS?=
 =?utf-8?B?aGRNUmlKQjc5YkVBTmw5QUNVeXlSSW0vdHArSDh2aXJjWEdPbUl5QUpYb0Ri?=
 =?utf-8?B?T1ZvSURyOWFhMHF2bDFqWHI1cWp5UWxndDFYN1ViWS93a3JuakdLQW9xeFM5?=
 =?utf-8?B?R2hPaGlVZDNTNElQNU0rZlR0RWxvVHpQZEY4M3A5TFZ3OTdqMFlML2kwc2xt?=
 =?utf-8?B?SzEzSUt1L251MTd4SVN4Vm5UbGhJZHBuNmlwMlh3TUZYS0UwcDBkTVphbG45?=
 =?utf-8?B?ZVR6SE1PbE1WV0xRZnhRcnFhV1BnTVltSlA5TTEvc0xHelNhWXRWd2NONzla?=
 =?utf-8?B?WGh2WjFBKzYwUG1ZMlg1c0VYSnM3b2RSUTlYN2J3SGNNRFh3QkFrMkgxMjly?=
 =?utf-8?B?MzN0ZGxtcUh5MnZ2MmdDa1MzOVh1Z0hRYWdRV1JkazVMNVBXR2lwRGxjeXo2?=
 =?utf-8?B?LzJ4OUxJV0VESTkzL0JNakJoVVhPVHFzekR6NS8vcnpnZTRNUk5uVmNLTmFS?=
 =?utf-8?B?aXQ5SVhYMmxrQzV4Q29XK3duRlpLazRUVEJxMGJJZ09VK09Sc1cxNnNiZWcx?=
 =?utf-8?B?Sysyd0VxTCtFclYrb2JMalpUNDZGU1VxZDRTU1hCZm9EaW50UWlqY2htRUdB?=
 =?utf-8?B?RXBxSE1XVUVyWHJPQ3pQMU1JenV6aHlUNlg1UGxyQVZjOGhaOGJwT1piZjFF?=
 =?utf-8?B?bkxjYmZBREhyWEE0TGFKb2hHV21hNmlJYUZzc2hNYXBaN3l2dVdyRUZhYTVx?=
 =?utf-8?B?cFNPa1BhemNCb0xCaHBBQ29Cenl3Qi9ueW82dVNRa1g2Z2cwMXR1Ty9IZTUv?=
 =?utf-8?B?Wmg2M2twRFpqSlBRWjlrcVFJcnFpQkNnKyt6cGxuaWJ0T2U4c0JlTjg2REp3?=
 =?utf-8?B?eC95SzZiVEdmWHdTLzc5MkFGSkV3bjlkZ0ppTWRZV285WDBvbGI4dFY0ZDk5?=
 =?utf-8?B?Y0ZrUlBpRno3dE8wQjdpZzJlRjRTbzF3czU4S0dqNGI2WW1SYVZvb0s0L3Yr?=
 =?utf-8?B?MmxRcWNDTGVIRVh0bmxZSEVBVHZBMENDc09sYmxNU0p3WUl4L0NpekErdmwv?=
 =?utf-8?B?dzdycEF6QWhLcm5XeW1lNEp3aW0yYUI4dW1IeXVmSTVkZGVTUit3RFpQTlJs?=
 =?utf-8?Q?PUkE0wW88asH0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzA0Zkx1M1k4UU56VlBWK2FBQUxXdkdmbUhjMUF4Ni9tZTY3VGI0QmNTK2dL?=
 =?utf-8?B?QzJMOExiVDA3c1gwdXh6RkpuNThVTmpLcWhGbU1hUTNiZXhTTmZ5d00wejc1?=
 =?utf-8?B?RDkvcE5SdlExUzYxZHhiMnJsMUY5aGY5ayswZzhEV1BEMXJPbnVUZUtuaWFn?=
 =?utf-8?B?cUVZbUZmTmRKajA1V3J0VG5oYXFyUGM3T2dDRWJ5WkFPN1JrQmE4TGxpMXVM?=
 =?utf-8?B?Z1VLdHlGVUlCOXBmcTRlTDlESk9vajBwWjJ3MEJmbTVYRC83Q3pNYngzVWNs?=
 =?utf-8?B?L2NvbjJtUlM2U2hPcEh6UG5iWkY2RHowSUxkUnpoZ3JRTzdoN0JiT1JybVlV?=
 =?utf-8?B?ZFpqSTFncXBZVkhSWXM0di80WkxwLzhNYW9aQ2JQbk01c1k5Y1d2dlJzdzV6?=
 =?utf-8?B?ODF6WlBRelZ2VWRsYi9sK1R0V0dhV1ZuYVFoU3ZSajJXUU9pMG5aeHFwbzVv?=
 =?utf-8?B?MFp3VkZCZTVqSW04c3p2TFFGTkZ4Q2VSUzdkNkFOY0VNSjhGejZ6T3cvdkI0?=
 =?utf-8?B?dDA1bGFSK0ZTbDJ2TExQby81NXJ2bytmMkYydVFJaTZ0VFg5M0VBaXVHcUx5?=
 =?utf-8?B?ZmJwdGFDekVYaUZ4ZkNCODhlcmlacEJMNEhVNTNyZ1UzZE1OWkh1UmE4NWw3?=
 =?utf-8?B?V3ZVSUc5NGhzb0I5dEVWY2hpTGxiTFltZktMTk9TdmlOQUFpVTNNelJVSEt6?=
 =?utf-8?B?cnBHUnZQTnZNM1R1Z0FpNENCQTlIdkxpUzhsZEhWYXh1RTZmUmExUjJ0dEto?=
 =?utf-8?B?TlZTWkFiekRpRDJnWGExTys3T0M3Q1cvM1JYR1RqK2lqNWNpbkRzc3VJQldz?=
 =?utf-8?B?QlZZVG1GQUdtYXVPWFdBS3lyR29iT1kzdnZoU0E3c0grSkJrdGEwQzAzSE5m?=
 =?utf-8?B?eU9ZbHFoNzI0eFoyN0N0dkpXdGVUTEx1c3lOSDhuaGJOZlhWWFQxS3pTVERM?=
 =?utf-8?B?RUNrdklSRkdITjNSS3lucC9scXJ0Ly9QZE9xVVhXWGdWQ2Z6WXA0eDhwb2pP?=
 =?utf-8?B?UFFhelVSdTVaa1pwVjdheEgyOUFkNy8xbE8rTzhKZFk0eFJXVGp3SDJlUHYz?=
 =?utf-8?B?MzFIcnBjajVWVXlRR0k3cXJZWDBoNkNwZlptc2JmVHgwQldnck41NmVkTHZw?=
 =?utf-8?B?WUxuMEV5V08vZ1k4eXFCdmw2cmdqbFl3SHQzclgrbG1nSGNUN0ZVSTBWVkly?=
 =?utf-8?B?TTdVcXVEWDgyVXdCK1U3YnpjY3loalNwTGZvb1FzNEsrN2R0M2s3bUl6WXZm?=
 =?utf-8?B?ZFcwUEozcFRUa3g2UW02bHhFUXNpL05kYmVOTFlieG5CUG5ld2h5NWJkYith?=
 =?utf-8?B?TmNHWkNPSU4xQU5sRmF4eGtKSzROMnBsSVhPbmdoK2NIelFHUUQyQ0JyVGZE?=
 =?utf-8?B?UjdvczhYRTU1T0preFJlZlo4ZEFiTEw2cmQ3QVdnNFlvdkVXanp2RXdoSVU2?=
 =?utf-8?B?Nm5uenduOEkrcVFEanZiRWQ4Sm56SmFvZDNBeVlFcDBKY1JLWW91WTlDcTlo?=
 =?utf-8?B?V0lEQmFmZUJ3eGFOdUU2aDVkT1lxS2xsR2xFL0oxSUJKOHVoYlZDekwyaGx1?=
 =?utf-8?B?T1ZrUXNuYWwxRXhBUXlNQnFtQjljYm1qbDgxd0RrSkRpZ3BNNFhiSk5CVmEx?=
 =?utf-8?B?MzJpUldveC9NTkswcmVuYTVINzdMaXNzcXVaeHZDVFR3ZC9YS0dDNU1sSENB?=
 =?utf-8?B?NU51SGwvNkFpa0FWblBhc0xzTWtlUmhzWG5wRVhHZUtYdUhLOEs2ZkNLUnYw?=
 =?utf-8?B?dEhBUXNvQmhhVUNGZWZBWWFpWlcxRWFiNXM0MU1yL3YzOVRnZlErb1ZEZ1pK?=
 =?utf-8?B?UDdSMDczL3dva1BsNVV2LzFyR01vUUJCb2JmczhpQTlzZHQ5WE5oaDMzWGV2?=
 =?utf-8?B?RmwrYmlOOHNHMUVFVTJnU1FJck5wNW9TTG1HQ0grRjhhT2JGRlZuQlZYRnNH?=
 =?utf-8?B?bmQyQlVteVphRmIxQ0RESWIvRzNBNDRack51L0s3K204THREQ0tSRGdDZVd6?=
 =?utf-8?B?cmFtSWtVcTkrUGRoZHg5Sm5RVkdqSHhtNFRST2Zmc2tDK1diVGJ0c21uOHdS?=
 =?utf-8?B?YjVKei9RcWFUd3FaTFZPK3A3OU5Kb2xUYitmemdNcEo3dnkvZ2FGUnlvS0lI?=
 =?utf-8?Q?Y8sBZIyMtSbNSQR9YNnCYdW3Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c8a54b-6faa-4cd9-cdad-08dd50e8be9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:24:31.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +61ZX/yb6k9DeG4IyiLo0Woi0tP7rkaL9uBgPwknzWelyg8yJ+A1v5pGbSU6oHFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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



On 2/6/25 22:29, Marek Vasut wrote:
> Turn anonymous enum TCM_LOCK/TCM_SPLIT into enum tcm_mode {}, set
> TCM_LOCK as 0 and TCM_SPLIT as 1 to match LOCK and SPLIT macros in
> mach-zynqmp/mp.c, and unify all the functions and their parameters
> on this one single enum tcm_mode {} instead of a mix of bool and u8.
> No functional change intended.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: Compile tested only
> ---
> Cc: Charlie Johnston <charlie.johnston@loftorbital.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Padmarao Begari <padmarao.begari@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/arm/mach-versal/include/mach/sys_proto.h | 10 +--
>   arch/arm/mach-versal/mp.c                     | 12 +--
>   arch/arm/mach-zynqmp/cpu.c                    |  2 +-
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h | 12 +--
>   arch/arm/mach-zynqmp/mp.c                     | 81 +++++++++----------
>   arch/arm/mach-zynqmp/zynqmp.c                 |  2 +-
>   6 files changed, 58 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
> index 757bd873fbe..a6dfa556966 100644
> --- a/arch/arm/mach-versal/include/mach/sys_proto.h
> +++ b/arch/arm/mach-versal/include/mach/sys_proto.h
> @@ -5,11 +5,11 @@
>   
>   #include <linux/build_bug.h>
>   
> -enum {
> -	TCM_LOCK,
> -	TCM_SPLIT,
> +enum tcm_mode {
> +	TCM_LOCK = 0,
> +	TCM_SPLIT = 1,
>   };
>   
> -void initialize_tcm(bool mode);
> -void tcm_init(u8 mode);
> +void initialize_tcm(enum tcm_mode mode);
> +void tcm_init(enum tcm_mode mode);
>   void mem_map_fill(void);
> diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
> index 921ca49c359..7423b8dc312 100644
> --- a/arch/arm/mach-versal/mp.c
> +++ b/arch/arm/mach-versal/mp.c
> @@ -24,7 +24,7 @@
>   #define VERSAL_CRL_RST_CPU_R5_RESET_PGE_MASK	0x10
>   #define VERSAL_CRLAPB_CPU_R5_CTRL_CLKACT_MASK	0x1000000
>   
> -static void set_r5_halt_mode(u8 halt, u8 mode)
> +static void set_r5_halt_mode(u8 halt, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -45,7 +45,7 @@ static void set_r5_halt_mode(u8 halt, u8 mode)
>   	}
>   }
>   
> -static void set_r5_tcm_mode(u8 mode)
> +static void set_r5_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -63,7 +63,7 @@ static void set_r5_tcm_mode(u8 mode)
>   	writel(tmp, &rpu_base->rpu_glbl_ctrl);
>   }
>   
> -static void release_r5_reset(u8 mode)
> +static void release_r5_reset(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -87,9 +87,9 @@ static void enable_clock_r5(void)
>   	writel(tmp, &crlapb_base->cpu_r5_ctrl);
>   }
>   
> -void initialize_tcm(bool mode)
> +void initialize_tcm(enum tcm_mode mode)
>   {
> -	if (!mode) {
> +	if (mode == TCM_LOCK) {
>   		set_r5_tcm_mode(TCM_LOCK);
>   		set_r5_halt_mode(HALT, TCM_LOCK);
>   		enable_clock_r5();
> @@ -102,7 +102,7 @@ void initialize_tcm(bool mode)
>   	}
>   }
>   
> -void tcm_init(u8 mode)
> +void tcm_init(enum tcm_mode mode)
>   {
>   	puts("WARNING: Initializing TCM overwrites TCM content\n");
>   	initialize_tcm(mode);
> diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
> index 960ffac2105..b7a4142fd54 100644
> --- a/arch/arm/mach-zynqmp/cpu.c
> +++ b/arch/arm/mach-zynqmp/cpu.c
> @@ -113,7 +113,7 @@ u64 get_page_table_size(void)
>   }
>   
>   #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> -void tcm_init(u8 mode)
> +void tcm_init(enum tcm_mode mode)
>   {
>   	int ret;
>   
> diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> index 9af3ab5d6b6..b6a41df1da4 100644
> --- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> @@ -41,18 +41,18 @@ enum {
>   	ZYNQMP_SILICON_V4,
>   };
>   
> -enum {
> -	TCM_LOCK,
> -	TCM_SPLIT,
> +enum tcm_mode {
> +	TCM_LOCK = 0,
> +	TCM_SPLIT = 1,
>   };
>   
>   unsigned int zynqmp_get_silicon_version(void);
>   
> -int check_tcm_mode(bool mode);
> -void initialize_tcm(bool mode);
> +int check_tcm_mode(enum tcm_mode mode);
> +void initialize_tcm(enum tcm_mode mode);
>   void mem_map_fill(void);
>   #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> -void tcm_init(u8 mode);
> +void tcm_init(enum tcm_mode mode);
>   #endif
>   
>   #endif /* _ASM_ARCH_SYS_PROTO_H */
> diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
> index 448bc532867..d2a7f305ccc 100644
> --- a/arch/arm/mach-zynqmp/mp.c
> +++ b/arch/arm/mach-zynqmp/mp.c
> @@ -17,9 +17,6 @@
>   #include <linux/errno.h>
>   #include <linux/string.h>
>   
> -#define LOCK		0
> -#define SPLIT		1
> -
>   #define HALT		0
>   #define RELEASE		1
>   
> @@ -65,11 +62,11 @@ int cpu_reset(u32 nr)
>   	return 0;
>   }
>   
> -static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
> +static void set_r5_halt_mode(u32 nr, u8 halt, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0) {
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0) {
>   		tmp = readl(&rpu_base->rpu0_cfg);
>   		if (halt == HALT)
>   			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
> @@ -78,7 +75,7 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
>   		writel(tmp, &rpu_base->rpu0_cfg);
>   	}
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1) {
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1) {
>   		tmp = readl(&rpu_base->rpu1_cfg);
>   		if (halt == HALT)
>   			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
> @@ -88,12 +85,12 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
>   	}
>   }
>   
> -static void set_r5_tcm_mode(u8 mode)
> +static void set_r5_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		tmp &= ~ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK;
>   		tmp |= ZYNQMP_RPU_GLBL_CTRL_TCM_COMB_MASK |
>   		       ZYNQMP_RPU_GLBL_CTRL_SLCLAMP_MASK;
> @@ -106,12 +103,12 @@ static void set_r5_tcm_mode(u8 mode)
>   	writel(tmp, &rpu_base->rpu_glbl_ctrl);
>   }
>   
> -static void set_r5_reset(u32 nr, u8 mode)
> +static void set_r5_reset(u32 nr, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&crlapb_base->rst_lpd_top);
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		tmp |= (ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK |
>   			ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
> @@ -130,16 +127,16 @@ static void set_r5_reset(u32 nr, u8 mode)
>   	writel(tmp, &crlapb_base->rst_lpd_top);
>   }
>   
> -static void release_r5_reset(u32 nr, u8 mode)
> +static void release_r5_reset(u32 nr, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&crlapb_base->rst_lpd_top);
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0)
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0)
>   		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			 ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK);
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1)
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1)
>   		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			 ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
>   
> @@ -165,9 +162,9 @@ static int check_r5_mode(void)
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
>   	if (tmp & ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK)
> -		return SPLIT;
> +		return TCM_SPLIT;
>   
> -	return LOCK;
> +	return TCM_LOCK;
>   }
>   
>   int cpu_disable(u32 nr)
> @@ -249,27 +246,27 @@ static void write_tcm_boot_trampoline(u32 nr, u32 boot_addr)
>   	}
>   }
>   
> -void initialize_tcm(bool mode)
> +void initialize_tcm(enum tcm_mode mode)
>   {
> -	if (!mode) {
> -		set_r5_tcm_mode(LOCK);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, LOCK);
> +	if (mode == TCM_LOCK) {
> +		set_r5_tcm_mode(TCM_LOCK);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_LOCK);
>   		enable_clock_r5();
> -		release_r5_reset(ZYNQMP_CORE_RPU0, LOCK);
> +		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_LOCK);
>   	} else {
> -		set_r5_tcm_mode(SPLIT);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, SPLIT);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, SPLIT);
> +		set_r5_tcm_mode(TCM_SPLIT);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_SPLIT);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, TCM_SPLIT);
>   		enable_clock_r5();
> -		release_r5_reset(ZYNQMP_CORE_RPU0, SPLIT);
> -		release_r5_reset(ZYNQMP_CORE_RPU1, SPLIT);
> +		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_SPLIT);
> +		release_r5_reset(ZYNQMP_CORE_RPU1, TCM_SPLIT);
>   	}
>   }
>   
> -int check_tcm_mode(bool mode)
> +int check_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp, cpu_state;
> -	bool mode_prev;
> +	enum tcm_mode mode_prev;
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
>   	mode_prev = FIELD_GET(ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK, tmp);
> @@ -279,7 +276,7 @@ int check_tcm_mode(bool mode)
>   			      ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK, tmp);
>   	cpu_state = cpu_state ? false : true;
>   
> -	if ((mode_prev == SPLIT && mode == LOCK) && cpu_state)
> +	if ((mode_prev == TCM_SPLIT && mode == TCM_LOCK) && cpu_state)
>   		return -EACCES;
>   
>   	if (mode_prev == mode)
> @@ -288,11 +285,11 @@ int check_tcm_mode(bool mode)
>   	return 0;
>   }
>   
> -static void mark_r5_used(u32 nr, u8 mode)
> +static void mark_r5_used(u32 nr, enum tcm_mode mode)
>   {
>   	u32 mask = 0;
>   
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		mask = ZYNQMP_RPU0_USE_MASK | ZYNQMP_RPU1_USE_MASK;
>   	} else {
>   		switch (nr) {
> @@ -358,30 +355,30 @@ int cpu_release(u32 nr, int argc, char *const argv[])
>   				return 1;
>   			}
>   			printf("R5 lockstep mode\n");
> -			set_r5_reset(nr, LOCK);
> -			set_r5_tcm_mode(LOCK);
> -			set_r5_halt_mode(nr, HALT, LOCK);
> +			set_r5_reset(nr, TCM_LOCK);
> +			set_r5_tcm_mode(TCM_LOCK);
> +			set_r5_halt_mode(nr, HALT, TCM_LOCK);
>   			set_r5_start(boot_addr);
>   			enable_clock_r5();
> -			release_r5_reset(nr, LOCK);
> +			release_r5_reset(nr, TCM_LOCK);
>   			dcache_disable();
>   			write_tcm_boot_trampoline(nr, boot_addr_uniq);
>   			dcache_enable();
> -			set_r5_halt_mode(nr, RELEASE, LOCK);
> -			mark_r5_used(nr, LOCK);
> +			set_r5_halt_mode(nr, RELEASE, TCM_LOCK);
> +			mark_r5_used(nr, TCM_LOCK);
>   		} else if (!strcmp(argv[1], "split") || !strcmp(argv[1], "1")) {
>   			printf("R5 split mode\n");
> -			set_r5_reset(nr, SPLIT);
> -			set_r5_tcm_mode(SPLIT);
> -			set_r5_halt_mode(nr, HALT, SPLIT);
> +			set_r5_reset(nr, TCM_SPLIT);
> +			set_r5_tcm_mode(TCM_SPLIT);
> +			set_r5_halt_mode(nr, HALT, TCM_SPLIT);
>   			set_r5_start(boot_addr);
>   			enable_clock_r5();
> -			release_r5_reset(nr, SPLIT);
> +			release_r5_reset(nr, TCM_SPLIT);
>   			dcache_disable();
>   			write_tcm_boot_trampoline(nr, boot_addr_uniq);
>   			dcache_enable();
> -			set_r5_halt_mode(nr, RELEASE, SPLIT);
> -			mark_r5_used(nr, SPLIT);
> +			set_r5_halt_mode(nr, RELEASE, TCM_SPLIT);
> +			mark_r5_used(nr, TCM_SPLIT);
>   		} else {
>   			printf("Unsupported mode\n");
>   			return 1;
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index 3aa218545bb..279006b4d13 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -146,7 +146,7 @@ static int do_zynqmp_aes(struct cmd_tbl *cmdtp, int flag, int argc,
>   static int do_zynqmp_tcm_init(struct cmd_tbl *cmdtp, int flag, int argc,
>   			      char *const argv[])
>   {
> -	u8 mode;
> +	enum tcm_mode mode;
>   
>   	if (argc != cmdtp->maxargs)
>   		return CMD_RET_USAGE;

Applied.
M
