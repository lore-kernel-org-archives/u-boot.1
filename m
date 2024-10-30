Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE9D5CCB9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 15:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175DF88F83;
	Wed, 30 Oct 2024 16:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GInA4Ktj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9810188B0C; Wed, 30 Oct 2024 16:49:32 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D3288FD2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 16:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/D7w20n5gr1euHei5QRk040KZhpTiEbi2Wsne6sFUUT6JMsQgMKVcU40GzsVV1+2OVkGD23ha6ZX1hzlVrIxA6o4QvGZNA0T3z4Jo+iTymuO9qIlQXhCTt9EjBJsOE9RMdbP+tyU8Bzv9n+ACxkkEEaFoCrt4wJ75zsc4NvDP5K49vVP9zlH+k0xi5tEPTw0Cv3d4FDhyL+oDElbq/XxFO9uG4R/QfZzI2RCq8F1O4+7bn2Jazfpd5hIAeU93QX6kfiAhygDPrw3evw+QzQulQCrrxrJv1ksvg236m+yb7aVzOMHLPVl852E1CC59lA1D+jADZ6627pdNcmyqQEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGZ9+kXG8E9jt/+YtTrpWyqYuOEmzC4cfXiycqQqUoQ=;
 b=vcX85Z7tACzTOWDQaJb7UGbrVZazVql49ffaN+8PXSKXY0GIK7Zl7C6fGElf4J5SnDVlaQjEQpM5lRtOczrDv+3pSbztpHJbZRQ/bEHAId0V7E1H0eSiZdnOV3wn/R0+aV5UR1tuRGq9w9art0FoIp/SM8MOAppg1VH9+5HsVciNHke7EPTJ2dVSzUnE066BfqRX2bCe1G0ZRj+Wy1i4bK1C7tkNUO+r9p+iQN5Rn0S0Hw5R3B3rwrgAZeygU0eKUUzRIHptyOwibTlik9DxPdyKP1wMF/tUsCUNX+ZwsqbbrNXvrcnFtktKdOkDO9V0cdJxKYJpHige5a5NcG/dEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGZ9+kXG8E9jt/+YtTrpWyqYuOEmzC4cfXiycqQqUoQ=;
 b=GInA4Ktjkjoo+PaVkr3H5DZ6LGCmlVTkF2Cu24J3EyvHdT7wAwgBaDEUtcGqfKnkSkLS3pOMe3DzD4OzoFoiDcaFVRDzwAssZ937yWbjQW0T3kPAeukYfCGTZ0JT5IMIVnfiWoOwEW6T8W71h9maeMf2d+Vk4sCcDkDo+0JfQTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Wed, 30 Oct
 2024 15:49:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 15:49:21 +0000
Message-ID: <bf1c5738-de6a-49d5-9920-bbeb30ebd879@amd.com>
Date: Wed, 30 Oct 2024 16:49:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
 <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
 <ZyJE7K8Eo7A6smyT@vamoirid-laptop>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZyJE7K8Eo7A6smyT@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0185.eurprd09.prod.outlook.com
 (2603:10a6:800:120::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 65941880-4dc7-4b4f-908b-08dcf8fa6bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlNZR1ZUOGZZdFJqWmNHY1lMVjBPRTZLY01ld0RsR2t3OVZGdzNaQ2ludzJv?=
 =?utf-8?B?aXNEdFhLRW4wb3BqeC9HRk9BNC84ajZpanMzcURoUkFReXVhN2d0SjFoSk8x?=
 =?utf-8?B?aVQra2N4VEJLQlErVExyQVBRRlpDMllNL2hubmZ4NS9vdTI3eWIwRTFMcjBo?=
 =?utf-8?B?blF3ZEpISnBkU0dkaDg3UGFJU3dMZmJQV3JJM2xhSGxieE1aZW41TUVWUEFV?=
 =?utf-8?B?b0I1bU5Yek5ROVBWY1Nkc2tWcnVSMTJrRVpVN1N2WjNPNGJBNXFqNlhkdWdq?=
 =?utf-8?B?K1ZBelAzVGFNc0s0U0MvMDViVWUzSUlpOWJGSTRsYWNGeWRRKzN0aFAvNzRS?=
 =?utf-8?B?Qks4NWM0UHREak1mUHhWYlMxWEx1bUtTVFhMTzBSNG5pVUZTRTIyN3M0VkZ1?=
 =?utf-8?B?Z2ZBaFJrUy81Z0I2OXcvVWlIeDg3ZVdyTGtDdlY2OXZBUkhVZlJ5K0xQYnFi?=
 =?utf-8?B?dXc4RmN5QTRFSi95THU1K0tkMWRQemY4N0NWWjRjaXFtczhQVXV4a0w5OFlI?=
 =?utf-8?B?Vjkrd01rUTFIb2ZHUnY1YlFtR1Q2UEdsNTVIbmkvMnJYK3ZGYUJ6RnN4QTla?=
 =?utf-8?B?RUVFazRKMXBYV0hGMVVQZXh1cmhySzh1M24vTWZjNGZoRDk2V1lZT2hOcVBZ?=
 =?utf-8?B?bGFSalMyeWd1RklXdkRLN2hRTnYwRGJaTlVWNjRtZDZVZ3cwRFlvbE9RYTFa?=
 =?utf-8?B?NGJaRyt5Y1JYekxNeE9JZ2tqSEdqZ3FJSVl6UUhzZThkNy8wcXZEYVd0aXht?=
 =?utf-8?B?aWE3WHFJd0ZWSG5Qc29HK3hPV2svL3FLUDdxeE9pOTJ0ZmxUR1lJTXBqUXZQ?=
 =?utf-8?B?aHIxMDlBYUxvNXpFR2hEcEF4WGc5RWtUVWM0a01kWFRFSVRzMHdGK25LckdN?=
 =?utf-8?B?Z2pHUE9SczBtbGRGK1pNNmkrM1Z2YllzTXd1M3lHd0VYUHk0MTZkd0FRT2ZF?=
 =?utf-8?B?MmZLLy83TUVmRklTMFBVY3I2cEV5bDVrMDNZRGczaFRwODRlUW9tTlFjMEhW?=
 =?utf-8?B?bUxHNE9GVWszMnpucVNaRVYyZktXRk5kRGdPNFNaYVd0Z1ZJZ3hCVE5NWlR6?=
 =?utf-8?B?UnU5RnNsMDg2MDdSa1doTXVPd2pYRndBVVo3c3dzbGdyMEFrbkt1MC9HZ1lZ?=
 =?utf-8?B?YnVGRkFNMEF0MFE2ejFzY1dGbThWaHU4RFpkdjhkODI0dmh4VjROV3hsVmxN?=
 =?utf-8?B?Y0ZTR1JEdmoyWUsxSy9URDZMYTUxeFJSWWd4OEhmL1ZmbGg3ZGJRVHZFbGk5?=
 =?utf-8?B?Ymt6RHRKWnQ5WHZETkl0MUJqeWprcTBsUjAwZXo3YkxOMmlvYUwzYWVkdnVl?=
 =?utf-8?B?Y0c5MktyZFZzL2s3TTMwSEd5OTZESTVxNWkwTmNPQndmUmVrcWpZOHFZcUJM?=
 =?utf-8?B?cTMvNlkrUWYra3lvU1V5K3RoOGtWUjdFYmwyNmx6YWlHYS9nQUFCQjJ6djYx?=
 =?utf-8?B?L2h5V0IwUDVMdTA1Z2hLakxHOXFKbWxnZzdvbE5MOW5GUCtNNFgzUEdNRjBw?=
 =?utf-8?B?OU41dmJEbUxnSnhUaktUTjA5eXNpSkViL3BGeHZZSmNtZEU3Q09QbHlUTHNs?=
 =?utf-8?B?ZmtvbFAyM3Awdk9US2dpa2xUZVNoM085RnV3MC8vRm5MczU4SzZaaVY2ZDEv?=
 =?utf-8?B?dWcya0M2SGVhVWFYWWVRTyswb2x0Y0lJQ2ZKaEpsdEx2VHlLNitpL3YvdWdM?=
 =?utf-8?B?MkQySnk1bFJzbHB5eGNoaHJRcU1KT0I1V1ZsUXR0UXYwUERTMGlZTEdIRTUv?=
 =?utf-8?Q?sKjp3STolXD0XHXauBRT8vV02SLxBpGP9PFRpLR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEl3RmVzeThVUGREQ0FyWWk5bWUyd21oSStBekIwKzJqdE1wKzBFOElkMnR6?=
 =?utf-8?B?RzUvOW4yTkR0TjRjZkkzYW5kcXNQOW9lQzMxZ3IxUnhBajlLYUttNXQySDhm?=
 =?utf-8?B?Y0tIaG9DT1p6K3dOdlEySEFZRWRUYU5KNi9yb3RjelhmVlZvT0g0R1YwU2w2?=
 =?utf-8?B?NE0wNlNCRlFRVkVZN280eXhLNWU4OTczVmlCWCtVTmRLMVJmYkpmMkh4clJz?=
 =?utf-8?B?Q05weVJKblZlNU5pNXNHa0VGUDM5VVBKT20zdTZ1aVNpeDc2dEp6UEo1U0U4?=
 =?utf-8?B?eVMwVmxNRE1HOUJ3K2pCQWphZmZrQVgxVE9RN2d3dHJMaVdILzNwb3AwMmtF?=
 =?utf-8?B?dGlCekpIUm9YaDJER0tTaHBsVU1yMlNQU3RBTjRkZlovbnNOdU5WdkJOcStL?=
 =?utf-8?B?a0NIK1ltMFh1QWEwQTM0NzlveWNTbWw3cU9SRmlRRGtiWHo0aUxidEFPUlN0?=
 =?utf-8?B?am9yR2VlM2FPKzR3MzE2ZVBaRWNEVE9ELytaVks3d3RNaGc0ZGdjOUsvRzBV?=
 =?utf-8?B?NmRjZVE3Nko2OCtWME11Qlk1Q1orT1NOQUVWd2lSQ28xSllmK3N4REN0dnJH?=
 =?utf-8?B?VlRtRmU1MHBtSHYvZlBMT0ZRUGZ1TktnVk9ValhIUWY3OHVrelpCbUh5R0I3?=
 =?utf-8?B?L09aN0JvakVQWHBmQ05sdFcwdnE3UzdhR3VEYzdHODlUTVhaUnZ2d1JlZ3FS?=
 =?utf-8?B?eGlGVW1FNVBGVUhmbG1jUTFmTnJVZkRTbk91a24wMUlNSE50Rjg4UTVOQUhT?=
 =?utf-8?B?QnhLRzBMRVpDM3dHYzAxRWRxaWhHNXlFNkRJblJNdHVJQzRpazQ2RW5VY2JM?=
 =?utf-8?B?ZDNJM0JVTTNPbFBQN3JRMHNRbTVMWk82OGpYeVJTcURBVUFtQ24zODlwQzNu?=
 =?utf-8?B?N28zNTc4V3Zzd0d5ei9OcTc0VEpqS0pBTy9XenRKSUJTajBFODVOZTlEWW9H?=
 =?utf-8?B?WkkvdTJrcHhmYSs0N2FoYmE0aTFxcUJHSC9rSFpDR05wV3dIK0VuYmpkVngr?=
 =?utf-8?B?U25WNjJtQ2lVOGRMRWlYalIwMFBGZVc5eUtvNXQ1YjJvZ0xsN1NIdis0RVMw?=
 =?utf-8?B?YXVZNnFja3VTK2RGSm5ZaGZEUFMrNWZ0MGNkdEJXbUNwV2U1MjRRNGlzZzUr?=
 =?utf-8?B?UnVkdDhuT0YyUVk4ZGJxVTMrazZzTVUySmVYNkRKZmluS095MnhPWmpNVjJa?=
 =?utf-8?B?bWE1U1pBOGJ1eno3NEtjZm15Vjc0ZGVsZlh2djk2R2NPdExZV0ZqcmNxdjBz?=
 =?utf-8?B?TUpzc1RjcjA0VWtEd1RTSVpKcW1mS2hSNGYzRDlTQW55T3h3R0Zyaml0WDM2?=
 =?utf-8?B?alJKcjFnZC9ubkN2NVB0aHFuT2ppRmVWZSt6T1ExeHI2azB2blZiYVlIdFpJ?=
 =?utf-8?B?Z3dQcjllL2dycmg3aFZiN2VmSkFNeHlkZlhYdjAxdGZGQ0wrem5JVnJLK3dC?=
 =?utf-8?B?ZnYrQ3JyMkMreTF2eERPcU9rMEh3Zzc4UjhaTXh0WXR1TEVUVUExT3ArdnBG?=
 =?utf-8?B?T0paLzBReUZVeW16UURNZEd4UGkrNlpreFhhd1FyR0RBb3h4L1dvMTJrakhC?=
 =?utf-8?B?YlJhMlNJODVpZFRFRCtZZWFYLzI0eVFFeXJZeVM0WHpIZDY3dDFWSTYzR3Bw?=
 =?utf-8?B?bkNHdUhyLytjdnQ4V1g3NUNhTkQvUkhDNHdkWHhuVlJDZng0OEtGdmIrYmFt?=
 =?utf-8?B?Nm0zaUd1VWhJK29rUG9ieFFDeHowck1QNmJ5blRDZ2luQjA1MkRwTVg1WCs4?=
 =?utf-8?B?VlhGQkJ0VG9GaDg2Z3hMbUNFWUhsMXJaS1pncmVHbENlNm5CR2ZheEh3ZDlD?=
 =?utf-8?B?Z24reVVPUVVTdUgvRkUzY2Q5YU1KR0VyU2kwaDdmTVJLZ1o2ZlRUcVNJT2xP?=
 =?utf-8?B?Sm9LMVF4ZUVtMTdVdjBvZnRObkRMV1QrMHR4SmNQR2M4U3NwTmNnOGFXUEoy?=
 =?utf-8?B?MWhCTVRGR2Vla2xDVytJVnZUZ2pqdXJRUm5uaDhDOVdCT2UvaHJlUUhrZE5E?=
 =?utf-8?B?aFd4T3FCMFRDbmxhZXRKV05ybk9xc1JXOTZNWmxjeWhCYVdUTW9Qdm5NbG9v?=
 =?utf-8?B?enYrMWI2NnBvc1I1bDJMRWhDcTlyOWhkd1ZyTkRtZDl5aFRGbFRjMkRsbHpI?=
 =?utf-8?Q?M5ti2fbk7iQWCr1jkxpujC4d3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65941880-4dc7-4b4f-908b-08dcf8fa6bcd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:49:21.4969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpHfHRTwWw5UoAIjTdq/bFjqOw+8zPyQSQTES2DTlJyv8U1JiNU45RUDy4mgThPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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



On 10/30/24 15:38, Vasileios Amoiridis wrote:
> On Wed, Oct 30, 2024 at 02:13:43PM +0100, Michal Simek wrote:
>>
>>
>> On 10/29/24 19:58, Vasileios Amoiridis wrote:
>>> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>
>>> Add native support of the bootcount mechanism in the ZynqMP by utilising internal
>>> PMU registers. The Persistent Global Storage Registers of the Platform Management
>>> Unit can keep their value during reboot cycles unless there is a POR reset, making
>>> them appropriate for the bootcount mechanism.
>>>
>>> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>> ---
>>>    drivers/bootcount/Kconfig            |  4 ++++
>>>    drivers/bootcount/Makefile           |  1 +
>>>    drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
>>>    3 files changed, 33 insertions(+)
>>>    create mode 100644 drivers/bootcount/bootcount_zynqmp.c
>>>
>>> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
>>> index fa6d8e7128..95b6a9541a 100644
>>> --- a/drivers/bootcount/Kconfig
>>> +++ b/drivers/bootcount/Kconfig
>>> @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
>>>    	bool "Boot counter for Atmel AT91SAM9XE"
>>>    	depends on AT91SAM9XE
>>> +config BOOTCOUNT_ZYNQMP
>>> +	bool "Boot counter for Zynq UltraScale+ MPSoC"
>>> +	depends on ARCH_ZYNQMP
>>
>>
>> help would help to also described where that count is stored.
>>
> 
> Hi Michal,
> 
> thanks for the review. Indeed I could add it.
> 
>> And why not to have it under DM/U_BOOT_DRIVER?
>> You don't need to create compatible string for it just instantiate it.
>>
>> Look at:
>>
>> U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
>>           .name = "soc_xilinx_zynqmp",
>> };
>>
> 
> I was not fully aware of this, I could try it. Just out of curiosity, is
> this the new/prefered way of adding new drivers?
> 
>>
>>> +
>>>    config DM_BOOTCOUNT
>>>            bool "Boot counter in a device-model device"
>>>    	help
>>> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
>>> index 245f879633..487adc1212 100644
>>> --- a/drivers/bootcount/Makefile
>>> +++ b/drivers/bootcount/Makefile
>>> @@ -3,6 +3,7 @@
>>>    obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
>>>    obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
>>>    obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
>>> +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
>>
>> please put it to the end of CONFIG_BOOTCOUNT to have it at least in correct location
>>
>>>    obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
>>>    obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
>>>    obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
>>> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
>>> new file mode 100644
>>> index 0000000000..9bb801e188
>>> --- /dev/null
>>> +++ b/drivers/bootcount/bootcount_zynqmp.c
>>> @@ -0,0 +1,28 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
>>> +
>>> +#include <bootcount.h>
>>> +#include <stdio.h>
>>> +#include <zynqmp_firmware.h>
>>> +
>>> +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
>>
>> In arch/arm/mach-zynqmp/include/mach/hardware.h
>> there is already structure defined and gen_storage0 is there too.
>> Please use it.
>>
>> Regarding this location. Exception in PMUFW is using this reg.
>> It means at the end of day it is up to you if you want to use it or not.
>>
> 
> In master branch (commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9eb) there
> is no gen_storage0 in the structure pmu_regs, only gen_storage4 and
> gen_storage6.

you are right but easy to extend that structure to have it there.

> 
> But in any case though, I don't use gen_storage0 which is the
> Global General Storage 0 but the Persistent Global General Storage 0
> which is in the in the offset 0x50 and is defined in [1]. According to
> this document, only registers {4:7} are used by FSBL and other Xilinx
> software products so from what I understand registers {0:3} are free to
> use. If that's not the case, which one of them is free for use?
> 
> [1]: https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/PERS_GLOB_GEN_STORAGE0-PMU_GLOBAL-Register

in embedded sw you can find this
lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:77:           addik   r3,     r0, 
0xffd80050
lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:81:           addik   r3,     r0, 
0xffd80054

And there are 2 pages which describe their usage

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841724/PMU+Firmware#PMUFirmware-RegistersreservedforPMUFirmware

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842019/Zynq+UltraScale+FSBL#ZynqUltraScale+FSBL-WhatarethememoryregionsandregistersreservedforFSBL?

But as I said I am fine if you choose one and you will use it for bootcount.

Thanks
M

