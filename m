Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F224C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 14:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D172480820;
	Wed, 22 Jan 2025 15:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UFLKWJ4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748A180840; Wed, 22 Jan 2025 15:18:05 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D949B80805
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 15:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5BzkrHXVnlcpiAb0rV4tqM3xkp1RtvfSzVYaFCr5C2/2QdFPjbYiAGx6n9riYVvat5hUKTX7GkldseN2Yl8yWqNGO3kRPb1SsurR4adaqy2CeAbUGsWeKFYH8+Bs8tIvfwXxqSDC866ylGIprV//bGnqcfzrmOpfvUpz8qiSV/nrlhyJVV62KgETlVrMTufytB6DYYy7oO4qdbgaBK3GBL9V52OtQjE93xMjnKxOhWIxuj6dJvF9j8YpxVWD4s+x64n4OjdyywBUFS+SjPaIDXPuSs2R47pgLUliFFFOv9oV13eab2+U8vxmhzQg6QBwp7BCcaEmCCmQL8MIaWs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBHRge8j1B5A7U6UgPEmjiXrMWrI4uT0Qm9xm/kx/54=;
 b=QosOC/8iPeuE7zQgQUWhSefKKwSlGz/Ajvb1s1t21K3O8/Ppbn1maU2ItCw0zOaO3zKhwKSRxQnVYN/0JjiXaYRH0+vV9O+E46YVFMWgYLry+54hxcTnEJ7Oy+5XvoYCgCAiyiDD1pZp1TBgqyDEklrjMsg5h5Oo/pzldKOXgJ/T4Tpq2VsSvcqhWJkfYb0FJwSxwKdNqj4sv4QTUov0wg6J/HGIsPpdZjTQBDFnugqUokVJN7pFNfQqwK3RS/v/0MQtmiCVLdOGgdNjDFjl6JsKD47B+RxudSWxDg8mK4r8cYqUraxzWHJ6MIyP2EeHXzUdziX5WjeXrllYBmG4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBHRge8j1B5A7U6UgPEmjiXrMWrI4uT0Qm9xm/kx/54=;
 b=UFLKWJ4DSlPLetjhm77C2s1CNkpu38mLISlks4db0wyi2dZPrE0G/M7l9mYzcM1CHS4RxTnVOeHYycMD5ettqD9TkNX7UaMIU4ysNZmJw43RIJ/I8mBr0bn4OzZecdnwXF5uiOgDTFspxmdSNi92u+dURjFD95we96J6JIKZvYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 14:17:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 14:17:58 +0000
Message-ID: <4b63522b-a679-4a36-8379-a8a34e2534ad@amd.com>
Date: Wed, 22 Jan 2025 15:17:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: Fix OSPI DDR mode alignment issue
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com,
 jagan@amarulasolutions.com
References: <20250106095120.800753-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250106095120.800753-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd99f70-d771-4cdf-ae25-08dd3aef9284
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjljSHpwQS8wR2xBYnU3L3R6VjhxTXJCeFJCTytGYXlZR1pPQ3ZoakJGRG1E?=
 =?utf-8?B?N1BSUE9oTlBqNzJTMGhjZG1QU2pVWUhPOUVxdjlTVFdwdHNqWHNwOFlXaTJW?=
 =?utf-8?B?MERpc1dSVzBNaXRqaXpUT0dFTHQzc3g2dnJFbHp3MWtJWXk5b0EwWGdseDFV?=
 =?utf-8?B?MU1Wc1dUT2pFS3VFVG1SRFBWQjBrN3ZVVXRXU2lyeG9uT3JJY1ZSTWRaTEZC?=
 =?utf-8?B?bkhBTTgyZ3hXUE44VHZMdmh2TlY5MkMydVdQblY5Sjc4dFc3K29sMmprU3Ns?=
 =?utf-8?B?Ui9TT1R1WnZyL2NQRTJkSDh5TUdoU2ZmOEhwVVRtOVE4Qy9relBUQVdoWGFi?=
 =?utf-8?B?cmxJUTIzRkxSaHovOUNLWFVRMHduV25rcXA4dE00czQyNTFNRWNGdkEzTnd2?=
 =?utf-8?B?ZFhzbXZ6dU5qU2llVU9QeXZQQWtsUHNybElwNVkwQmdxT2ZkS2tMcktVUkRj?=
 =?utf-8?B?aS8zb0xPWmhadWpQNGdoNkJEaU15QXhjc1QwZDBGUEVxczh6c21NdkJ1bHdZ?=
 =?utf-8?B?RUFsWG9NWExzM211Y0tZRytKRHdjMlRwZHAyQkVlbmZXNUlFeC9GcGd0RXZQ?=
 =?utf-8?B?WmFUeGp0Q0xOZHV2M1RtNVU1dFppSVhsamtVSllMY3dyRjUwcVJkTldyUUE3?=
 =?utf-8?B?dGtUL0Y2WFkwdU95OVhLakU2azd5YmdTTG9YN0pkTDIrSnRKeVZiTlJCY291?=
 =?utf-8?B?QnBnVnJ0YTNQVGh6N0lmS2lRaVQyYlVsV0RSelhjZEhJcWp0RGkvK3RTTnB3?=
 =?utf-8?B?THhhQ05GRnROWTBmUmFaUElYb3JQTEtySDVGendZYlQ2czBMTCt4NWNuSnF6?=
 =?utf-8?B?VTVBYUEzbUVGbHo1R2JzL0dsdkoza0JBTENGUGU1Y2YweHdKVWppZjhnR09o?=
 =?utf-8?B?aFE1MlBjQ2FYWDZoa0xNNks0ekJqT1FoUlRJRC9ONjZQMGt2MlhGTGJUM01X?=
 =?utf-8?B?SS9NSGpUbytXRFhQUUIvMzFPNHlzeGZCbEJMQ09QZERRMmp2aVBGU1BFRzlj?=
 =?utf-8?B?T1RQanJCOEdjUnh0b1RidGVFK2lUWTlUQ1BEdDdFejZ0ck9YTXlnYklUVENW?=
 =?utf-8?B?dE5ISlFoZlh1U3l5ckEvQlc0NVc1NTJwelNHVWJFWG0zcDVtemd0bnREN3Nh?=
 =?utf-8?B?YmM2SnRWcDl5dkRGQUU2MFliMWMrTnQxMDZpRFZUVy8yMzJQQ3lXMnhaTzNk?=
 =?utf-8?B?NmtOS1FNdlJkN1V4dEVQRDlGMFZWS1UxN0ZPdWdkRU9LRHZNQkZvczhwdlls?=
 =?utf-8?B?YWVwRmNpTzRQcWNxKzVPcjRldFZCMG5yRnlUazJVL2Z4aHVJZGVZV1lqa0Na?=
 =?utf-8?B?RXkveVdRVFo4MzY4QVBMa3Nxb3UycVhZUVZ3RWRyd3ZGN1c1cUt6SjR0SHZL?=
 =?utf-8?B?UXJOMUg1QVFlV09zWjVmR2s1bXE3VHZDbWpzMmUyZW1FUldFYXRQSGlTRWkw?=
 =?utf-8?B?UUNvQkZva1FvL3haWjVXRjNjTTNYNG5zdGxkVW52c3NmcG9ZYktVMXdpcGFO?=
 =?utf-8?B?VzhaTGFMRkx6a0VWRXIvd1dVZlNHcENmckJudHFDTGRIOGUxTkZQZXh2WENW?=
 =?utf-8?B?S1hoeU1SNENMRHZWSXhRTHJtenMyNEZ6ZEhaT2c3cUM4TnpCTVdpekhtaGFz?=
 =?utf-8?B?MXhlTE1zOTl5NURWaWFPTDdSVCsxSWdrVmZqM2hRbk5CMkpCNTZvVm01SzVX?=
 =?utf-8?B?SjA3aWFNcjZJK0dNOE1ISWNkRU1YL3Y5bC9PbTBqeUZaY2VyQ3dpYVY5THZJ?=
 =?utf-8?B?bFJxT1RDTDR0Wm5RWlRFZlNKZk4vT3lWNjdkWTZLcm8zaVZneDJ2NWtIaUI2?=
 =?utf-8?B?RFZhdHpOZkhPWkhpWkxzTzVEOW1mVUpCdWs4TGlCa2tqYUtkTkIrdjFJdFVq?=
 =?utf-8?Q?dL2YzKr+bNv2f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZrenhsWjNaQkNiYmY0WnRpblBiU1lsUDRUTnlYUThvRW5VQ3RRU0N5dzlG?=
 =?utf-8?B?YnFVK3oyNU1EaXZJNFZGL21iZG40L015NzBzamlIVzZtN3NSRm5LZ2p1OUpa?=
 =?utf-8?B?UTJWa2JNa0xjMzVHOUZIRHpIcFJBakhacTdoaXJRclhETXE1UVFvSnM3WVNw?=
 =?utf-8?B?eG9VdjlQTWJCclZ5TUlTYlA0dUdJU3htVUR5QWxRUGdlbTJKRndLaXFGK2JX?=
 =?utf-8?B?SnFnSkJzbmdlbW00RlQ0SE9Ob0l4K1RnYjNJaXcwYkdKaVY5eFdxcE1wNHRH?=
 =?utf-8?B?VTFEWHdENHlXQmtuUnFlVUZVdkIxeWFDVmFYOWRaUERsNHByNW96RS94ajJN?=
 =?utf-8?B?ZXFSeW5kbVpkODE4amlOOTR4eWV3V1RURnVGNDdNUDVaVEFDTW1rak4ra21I?=
 =?utf-8?B?N2Q2QWFvTnZlaVovRDQ3QlpZUGpXcGRLYjVRRGRzWThETW1Bb0RFeHVzN2pk?=
 =?utf-8?B?b0dKKzlRdTBnNFUrckZIczdFUUNlRFlEU0dycnh5eW5RdmZDVTR1dHBDT01j?=
 =?utf-8?B?WnlSZCtuK25MOUc2aU9wQVowZnovck5uWlczc3BxdWZyVmowNlhoMDVjWVFp?=
 =?utf-8?B?SDZlUmlhc2FzZnMyaVRsNGRBQzc0VmxnVmEzMUhGZW5DSlBKMHI5V2w5MmZo?=
 =?utf-8?B?U3YvRE1Sbm9LYW4xbXNjckE2YUdpSEFWWnRiaUJvT1kxaUVEY1k2dG5scFNV?=
 =?utf-8?B?L2FldFVIVXppanhaTVBBTy93eU1jVXhWTzRlc1ZYWXRMa3VNRlI3bkNCYnBr?=
 =?utf-8?B?bTdwQWszeWZtcWNmdXJUUGREcFFZUURONkFJMU9ab3AxV0g1azdZMlA3ZjZP?=
 =?utf-8?B?M09NTjRtdlNQdzRzL3RwV1lsN1QvQStwVVJKWWRsMjdYY201dXBETG5HelZW?=
 =?utf-8?B?eTJBSEpYV2hRTG10eHAzc1JjUEpDRTJqNnhwZlQ1S3NTb1RmK2ZzbzBMRTZ2?=
 =?utf-8?B?SThDRHFiSE1VWHJtZVYrT1ZxS3RYU04xc1RaVDhiUG54TnkvY3pzQytCS0tK?=
 =?utf-8?B?eEpVUXhZdlJvNk1LUkRhemRWbVRKbTAyVTZFYktxUzk2N0hLQ2RCZ3pvNHRP?=
 =?utf-8?B?dE84OUw0N1lLR2I3Z0l3U2lPUy8wSE9RTXAzbFdCVy82OFRJaVFESzFrWG5m?=
 =?utf-8?B?d0pEZEVQL1hhdUIvc3FkSnZ4QmQrTksyeW51Nml2UE1JQnJNOG03UWNLcDYr?=
 =?utf-8?B?NE5hNzhEUG1iUkVIUS9QR25lb0toRzJqYjVDdytYZ2JRVXR1VDRwbEtsWVE1?=
 =?utf-8?B?M2JqNE1oSUVJczNQSXp2T0xScmY2OFNmQnFYUlJlOHVQbktpKzZrZVY2NEZT?=
 =?utf-8?B?aFdicW1HTjdGUjQ1NUNQUCs3bmNsNU16REFnOEEzTzFyUTVQekN0YlNzRk1M?=
 =?utf-8?B?VDRFNmhORTc1Umh5U0lZeTF4cTQ0Uy91NGc2aklDdm5xOUlCTlY5elQ1YXg1?=
 =?utf-8?B?SWZCWVVaSE9rc1ZnVk5kNndGSXBVdlppZEt0RGtZQzhraDBNaE5hMmJhNktV?=
 =?utf-8?B?MGxzOTBzb0pnblIxdGVQODBNa0pxZVNoYW94V1pOVVBXRXlPMktWUUpRNGJw?=
 =?utf-8?B?V0Z6dGM5K1JRL1d3MGZjV0tZRllnMERIM2ViUWJjRHlCaGlqVllOZVBjQzVY?=
 =?utf-8?B?QjRGK21oaFFxTjlaR0ZsQjBXYmdJcEFiVi9yUTBYS0k1Y21HU0FJTGc0ZW1S?=
 =?utf-8?B?Zmhaak5aRlNteEdmZ1puVWZQYUhWR0NQZjV1bXZ5ZXd6dkVvVUJ2TFAzbzJV?=
 =?utf-8?B?SlYzTENsci82SVZFdWloM3VDdUorQ0k3eVdFb3Q5QlI1RWxwZ3pOYzdiMS9I?=
 =?utf-8?B?OU1iQkhqcVB4Z1FKUzdZTERiM0FZQ294aERYU1p3QjhCOXR2SVMzbXhNT1h0?=
 =?utf-8?B?Z1dCazlRL2FET3Nvd1RzcTVaZWUvYjY5cTFXZGIzbDhwNzg1MGJCY2VaYTJr?=
 =?utf-8?B?RzlvSjBkSFFkdGZ2LzVZWDYyL0NyQVB5WVpMTW9vS3RIMy9kajFteXdxT3Fi?=
 =?utf-8?B?SE1XMUU0MDRFTnVMaDd0Z3lKaWhHOHcrQk5tNFRNTnZsekFBajZleC8xYWpK?=
 =?utf-8?B?b0ZtVEUxNEIyNjhHZkVqbm9iMjlTWFA3dDdQSGdjUlBRQlh0THo3S1hUL3A0?=
 =?utf-8?Q?eCsP8HnkBFbo1NjaoplWQTHi3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd99f70-d771-4cdf-ae25-08dd3aef9284
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:17:58.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zemcF/o+ItAlLHiWa1MIn8T1r7MjiKsFmmhRZrns7y6BDyoqalyqPUbX0/0ju3Y5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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



On 1/6/25 10:51, Padmarao Begari wrote:
> If the least significant bit of the address is set to one when
> using the DDR protocol for data transfer then the results are
> indeterminate for few flash devices. To fix this the least
> significant bit of the address is set to zero.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/spi/cadence_ospi_versal.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 222f828f54..8827a24ee6 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -24,6 +24,13 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
>   
>   	n_rx = op->data.nbytes;
> +
> +	if (op->addr.dtr && (op->addr.val % 2)) {
> +		n_rx += 1;
> +		writel(op->addr.val & ~0x1,
> +		       priv->regbase + CQSPI_REG_INDIRECTRDSTARTADDR);
> +	}
> +
>   	rxbuf = op->data.buf.in;
>   	rx_rem = n_rx % 4;
>   	bytes_to_dma = n_rx - rx_rem;
> @@ -104,6 +111,11 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   		memcpy(rxbuf, &data, rx_rem);
>   	}
>   
> +	if (op->addr.dtr && (op->addr.val % 2)) {
> +		rxbuf -= bytes_to_dma;
> +		memcpy(rxbuf, rxbuf + 1, n_rx - 1);
> +	}
> +
>   	return 0;
>   }
>   

Applied.
M
