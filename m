Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DB6CE7AFD
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 10:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF4688714;
	Fri,  6 Sep 2024 12:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iSbC7INE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31813888A7; Fri,  6 Sep 2024 12:08:15 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C3A886F9
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 12:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N542x3u51ScCxMxsPep3bfPva/nImabapkCNy92mzP75HQWhinYDLG+hRT9BK2MPZXqUshFMGimzyxMwCjtaH4cm11K+ROZacCfIGHchejepbUe+u5rm2NsPEryyL/iqd4hyFbb7+LAsUGq3HiSn7UVH8ddhQyCMXagn6KOL5eFKg2XxuaR2djNIPQQYtez2wKvwwh+iNJRSTScJi0kNJpytQzodySOPrWKNCXF48SDm8YQsSBrtr5xOHtVDoOXBukhCbaCxycbOB/KImtWTxFe/3bddew3yTVV5OUoUFJVT1NCdV0ZxWf8PbaCu0AybdYDIO92M1I2CQiHsP785+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPrBNFs8wdFCmjppuBaFAt+GvJiHUjR7TQrzVo8e7fs=;
 b=xlStahhdh+xl9rFEePm2wXtyW9XSOPYzb7ie5oV9KrENFNSrJ5GejfdhZxz/GyZKTG/Jhj62+Sp2FtQGjHVnobvbSaD1Ly+OEkgXDwixO+2Om8FrYp+16+wkMQMhLVXy/PphgeC9eJtzPmkPGMfSYS2p/ShJU8mz5+54ARXhYdDcK4o2pOqrKUXE4fZmocHUoZJZUL99fWBN63zG4LgKfldjHzkEFzr1/kxQp7Zuof66vLzYqxCiWOLDObK/70BzMCfkA7nu3FS1mp7vX9kwdddxNbUicFktRHIp+T6mozL6ya5ZhmX08NWI3YUJCEjJ0ZSQfn2odVhRVESKnx+bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPrBNFs8wdFCmjppuBaFAt+GvJiHUjR7TQrzVo8e7fs=;
 b=iSbC7INEtgYxcDN+O9lY8RSHfqBKxv09grg08bVjDY9B7IW7/naXciHg48GbChttSOz83fJcclvPhR5BzW1q1VDGOfmL9WyyIsNp7z6NdbyktyzEjxww1IIdoVtTsR2Y0zxQUHUnJXqDQ1C5q2IpQxxjPJgKEZQ08LiaPbe+1fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 10:08:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:08:09 +0000
Message-ID: <63d77226-5f91-4694-94f0-ccacdd35bc38@amd.com>
Date: Fri, 6 Sep 2024 12:08:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm: zynqmp: Initialize some registers at boot
To: Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@xilinx.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240905171833.325548-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240905171833.325548-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: acb2b9db-45f0-448e-98be-08dcce5bcf70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2NWaWNGSUR6Qkk5SWVrQ0Nad2xIWGxRTDRuMjcwS3lzRCsyck9WWWdiKzVp?=
 =?utf-8?B?c0daWDBhbWRzVWpMMTQ1RFBVd28xTWFXOHlyc1BRYzNCanlicmcyeVJTN05Y?=
 =?utf-8?B?UFc1NlRlYzB2SWxrY3oxblBod0gvcytMU1hIUmFnL3lHcjZYYktWd1ZDQmJ1?=
 =?utf-8?B?bkRHM1NKUjIzdFhZQWdJYjk5NXk3akJCd1IweWNXWDkrbEhkWkY1MXg0U3E0?=
 =?utf-8?B?cHhhQVVRNXp4MENhbW5wb3o5dGhWQ1YrWi9OSkkzT0R1ZHRrUWdjdVJLV0Q0?=
 =?utf-8?B?TzBwSllLMm83VG1aUW1PN3VRcjBmT1ZnSE5jNzh4Ty82VFRJMWkxL1RablRQ?=
 =?utf-8?B?bkZnR1BYY2orZlhpcUJneXRpb1NnaGZpb1VzVGpjZjNscEk3c2pFZGI3VFVy?=
 =?utf-8?B?Q1EzUXlzS3JaRGxYb25SRzdCSHdoSWxGbHh0U3p0K1pGYUVlNENVN0lOdmYw?=
 =?utf-8?B?S2FFVnF0V1c1cy9TT2w5by9ucTFGaFFiWC9FblhkMWtCOS9xZUFVcWQ5TkVT?=
 =?utf-8?B?YmhVS3VqRmkvdkZOajRudFREaS9CaFFFeWJLOXRIcGIzQnZ2MGliWFl4RXVI?=
 =?utf-8?B?K3J1L2ZjMExLUjcrYUJNamhSaUlLZGltdHZXaEVES2ZEaU5iUTNMT3JIclBQ?=
 =?utf-8?B?SnBDUm5hTFZ2eVlVVnk2NTFOc1ZIT2orOVgvbzhLS3pnTFhsRlVySTBZaFBY?=
 =?utf-8?B?ZzJNK3p4bjRFdVl1bTk1ZkN3alVHU2xlVmpoZEUrUkpPdHVkYjlqR0VDWkp2?=
 =?utf-8?B?MGZCZUVGRVZHSTFXZ2NoclF4YnpoVklnMmdzeHhPT0dpMEkvcEhSUWNYZXhZ?=
 =?utf-8?B?L3RrcmlQUWtXek1ZSVpydVlmZGdnWjJjZmZ5NzI4SWlRUG5yOEpSc1BVTGRv?=
 =?utf-8?B?VS9SVld3MEFmSjM2OTllc2tEM2gyNUJWeGFxOS8rallMZlRqb1lnVWJlWTda?=
 =?utf-8?B?c2U2M0VZY0wxUVZCcGlPaGVMeWQ2SzFvWUV6dUNLcjVqcTZBU3FNZEZGRUt6?=
 =?utf-8?B?RnlVTGtrajg1anV3S1NKTnp4MjA5Tk9qQ2FJVGNjdDA4WUlCZi95RzArTzNU?=
 =?utf-8?B?WXRzcWs2ODV0YTJHYWsrQnYxSGtUcHBKZVlPRFhwRm9NNW5oTUNlQ3RyNWNz?=
 =?utf-8?B?aFpySjg5VU83UFJoWm1QVTc4aVl5YXUrWjl0SGxWUlZpamQvaktMSWY2Wmpr?=
 =?utf-8?B?N2hTcVNQOThHRk1yWFoyM2h5NkJCZmRNcmFwY1h5V2JjMnhsdDR0bEtZUFBo?=
 =?utf-8?B?ZlYyeGlGSXRTVlVJK3JQNVZnUGdYUkJpc1FOQ2RmbkVYd1puSVg4QWh5SDJO?=
 =?utf-8?B?QktpUng5dityTjlJL3o3K0xPV01LSkxjU0tzUjhtL2M0Qk81Wlo4UHBxYlgx?=
 =?utf-8?B?bmYzV2VXZktRZFpCZGRZbGUxM1JMUVdDbFhwOWVRZWl5b3RPd0FWR2NQRjZo?=
 =?utf-8?B?V3BxeFYvZ2JzNml5bEFYWkJsZzJYZUd0MjJzZ00yTnFOMVlXd0RCanAzaWJU?=
 =?utf-8?B?aHB5RWV0OFJWWEZlVEsvNXhBK0pDTktUa0pYS1p2bUNTb3kyNUtpdmRCdjMw?=
 =?utf-8?B?eEF0dmVSdmxySlNxRy9kR2xoOE9TWEdvK1RpSmtzeGFIUW80WmpyUng4d0Ju?=
 =?utf-8?B?V0FtRDVqc01uRjd4VlcrdGRldUVFa2VYMGRHdGdrVjY3cmdFcW1Ud2tLSktL?=
 =?utf-8?B?VFQxelljZTV3OXFqclhCY0UxOWlxemdEQVoxQ3VXcDk5cDhWaDlGOHo0dnoy?=
 =?utf-8?B?TFFpRDkwYXgyL3lIOW1UMjN2elZXdisyM0ZQQ1VGM1NDWnNKSGJHZHNVQTNs?=
 =?utf-8?B?ekdyL0RDajZDc2RPZ2Z3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVVY3I5Y0p6MDZpaXVKSUNzclJ1OUNrZVVQSmZmS0FvWEMwSDFmOVhJSWdH?=
 =?utf-8?B?c1F0SkJOTFdPN083NUNUVjI5aGhoTEs4cDJQNTZYY3FCenV2QThHb2RaL3J0?=
 =?utf-8?B?QWVSSkk1UkczbWUrd3dCUUM0VDhFUVdtb2RZejVNa2dLU3lwYjF0UFhSS0V2?=
 =?utf-8?B?OXJrek80RlpyZnVHYytyd3NTcGptRU03TFpCQmNjcHpOcGxjR0UrVThJM1lv?=
 =?utf-8?B?NVFzemVOdTVwY01KYXFZRnZoY1ZhU2pob01mRVhKdXRIS1VVMXM5RXRmZmoz?=
 =?utf-8?B?YVVjWWhDeEZGNkhOR21NcWduSHYrSHgyS1NhZVBkNW5OaW5ZR2VTTHVhdytT?=
 =?utf-8?B?OGd6dUsvbXErbjJBUFl0djJOTThuWTBxd0RiRlR6RlA1dlF6MTZvWDR2WmFp?=
 =?utf-8?B?L0lyejdTQXY4d2IxRlpUcmdrLzMwaWFzaDhLQUIxRXAwd3luZWtHbEVhK0Fw?=
 =?utf-8?B?Y09MZHJwY04wUWQ2d25FTUVaUnNaOVdjRmorRlBGTzNMaE92ZVdGV3VTaW9n?=
 =?utf-8?B?SHR5NjdPQlBzU0FYWDdQT1dCekJZZkhleFErcjlaeFBXV0MwRE1FeVI5Y0dC?=
 =?utf-8?B?eVE3VFQyTWJBNGxnRlM1TkJ4YmNHdmRpcVdGWUl0V3p4UTdwdEplZXBBQjEz?=
 =?utf-8?B?OVBBS1RUaUMwU0NCZ0pqU1pyZWdBMUs5S3M3bGVPVjlmOE9kTzRMYjZmam5N?=
 =?utf-8?B?QlBvNjlhZzN0QVNISVJhSjg2MXE3dmFXNmRxZ3FGTC9JL2x3SHpvU3dhUldB?=
 =?utf-8?B?T0RsZE9tL0hJbFFjM25iWGh3dW9Tak5yTWt5Rm51c2I3Q2kvTXpncVlnYkIz?=
 =?utf-8?B?dExBLzJXa2hsWHhOY0czYk5PUmJNNGViN0t5Nkd1QmpmakJnejdvaVZlUXFL?=
 =?utf-8?B?cWVYQjZoZGFBMUJ5L3hNZk9IeFpBSC8wV0dDM0dWbFpoV1dzZTdtS2VITm1W?=
 =?utf-8?B?RGZhVzRac3dPU3lIOGRRbFJPaUNBcVZQRmtDMGszR1FoSTNGQmRmM1pNRW4r?=
 =?utf-8?B?M1FMRjI5bzFXSDMwcG4zTGpGeGxNb0I2V0hDektjOXo2bmIxVDNUc1pja2dw?=
 =?utf-8?B?dU44N3MyTjZjRXJVeGdmaFVYZytKSDdzRk92OSthM1lTODJNd2YyNlJ3UDRm?=
 =?utf-8?B?ZE92UitIdnJ6WFM0RDJsQXBZL3NVWEdZb0hiaGRYYjIzWjlrSlZJREVuUWM0?=
 =?utf-8?B?NkdGZ1Jud08xMmZ1SUFVSW44anYyVm93TStQU1pzM20weVdISFNobTF3RW80?=
 =?utf-8?B?a3pMRGdhMFNZY09PRG8vSmF4dWRNa05FUDA5WXliRVpxdVcrMEp1NU1FSGdI?=
 =?utf-8?B?YTE1VXVpQlVINVA1azY5K0VIMXZpVGdGa0JzbjQ0TnVSejdBMi9ubzIweDZC?=
 =?utf-8?B?RXRySFhhK2xYQWFxSUptWGh5R1BsZzRpZnVHcWxjekVMUGlqZ3Bhb3ZrdEtk?=
 =?utf-8?B?NWV2bnd5bU5pN2dDdWg5NEFHRFNuQXNFSS9aMEFGMStJVFNNR05ZWkV0TlZu?=
 =?utf-8?B?bGQvazFKcldWRGoyOSs4eFhBbklzeFJJUG9VZm41c1prS1QvMmlYbmhMSW5Y?=
 =?utf-8?B?SXoxOVVKa2F2OC9aV1lhbytSanRFZTVaWFFXQ29pVXRETkw4N2JCQyt0ZS9L?=
 =?utf-8?B?Rk5lRDV0VzgwTzNWdW94UGVUNFh2TFgxU1VteXNxN1J4Vk1rM0VRTVQyaW9v?=
 =?utf-8?B?SU9kUGxTTVdVTWZ2T0prYmwrVStsMlY3RHVXZmZOaittcHR4dGNudnAzZjZI?=
 =?utf-8?B?OEpTMkczMDNnQVZockk0T2JyRld1eCtOdXJPVW1QL1l2TzliM2dLMjNVbGMz?=
 =?utf-8?B?R0FGNlY3OWIyT2NNbjVKaTdUZkFiT2c0clEydzdjdWVwMEhja2RkT2hyK0c1?=
 =?utf-8?B?TGg4NXFiSjhHQ3VOeXRRM0hOczRuWnhmSWZQSGkyMG1xNGgvakIwMlI4QXNv?=
 =?utf-8?B?WE5NenYxOXJQYVpZb0xFZEh2bk8ycHRsL3Uyc3Bka1BvVGxqYXo3cXN5dUxp?=
 =?utf-8?B?MW5lTkZCcEZnb1YzNVdZRm54OEpNdEsvN3JjbnJyeDRHL2JWN1JZeG1PSldo?=
 =?utf-8?B?K1VRL0NtZnlUTmJQRCtuKy9XMUo3b3FFQmpuYjBUVmFOOFN3WUllc3pES2do?=
 =?utf-8?Q?9oV2hIMh4d3/81Ixubtvdy1+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb2b9db-45f0-448e-98be-08dcce5bcf70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 10:08:09.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XV9V1aVL9w17xt//KrBNEBdTrOe/NER43DJeNNB8CsQehWqCnHclaZ21/HPIPh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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



On 9/5/24 19:18, Sean Anderson wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> These patches are independent in intent, but they modify adjacent
> lines so I have sent them as a series.
> 
> Changes in v2:
> - Don't set reserved bits in AXI_RPRTCN, since QSPI doesn't use ARPROT
> 
> Sean Anderson (2):
>    zynqmp: Disable secure access for boot devices
>    arm: zynqmp: Enable non-invasive CCI-400 PMU debug
> 
>   arch/arm/mach-zynqmp/include/mach/hardware.h | 5 +++++
>   board/xilinx/zynqmp/zynqmp.c                 | 8 ++++++++
>   2 files changed, 13 insertions(+)
> 
> --
> 2.35.1.1320.gc452695387.dirty
> 

Applied.
M
