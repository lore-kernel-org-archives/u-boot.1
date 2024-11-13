Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A89FD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC1F89515;
	Wed, 13 Nov 2024 06:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2aQHuYY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D61894E8; Wed, 13 Nov 2024 06:38:41 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921A9890FD
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqoTSdsHC8MBktqPqwWx/1RFgHagXkoKgzKMn2YA6mHMssJQ7QMoX7RLr5H/H5IZfYAHPx/cE+vVzLtOtgEWb+bMTdtMKaVn8T9Oox8q0pF1wst+iUeh9uLaN2lJjEKgzaSeBZ/bti3E/tDO1JAX/JF3rBojeFYmhOUnMLmOX1GZpWbdIZM78bAVYAuY+ieKFXstxrpe7BewCR6Ugjk3XAiXWAjV/EFnPTnu/fUjesAADtVWSEJBZItLLi2iwFnxo8F3nTSM9C4DkJ396bzjJNYoE71tfjTDwuWIkICvHhCzL1rNf6de+G6I6Co1LS7zg0wWAf7lc/STi4zFnMCRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05pnJh/oQ6Ovc2dCzOmRueTqHrT09BxUNQNqyK9Hr60=;
 b=LtDyO9s3bs0iFHrrCUO7j7CEY8pRv4g6753wmqqU7fuo/xSPygra01XWJIAYXXfwd8r+Wz9vcBBoqkgCSGBjPZuYrO57redX0e47SaT0Et/+GYqirvUF8Lwo2eY9ei+3ABPeAPF1ZBp5kwuYBcB/DdsKN41+hp4uc1w+fEykPdbWt00ru+hhBZGFlUnbfJ+thO9hcYqWca8JJf/qLs/23aO8snOzMwgV+NDg+GSfULLc5VzdAGa98CM/Z8LaN/vJv9eDrJST8NlQ9653b90LGCLSSxgWMBrZQGVF6wpDPze62PCPE+wMGEKNS73a6AFn8vHJCIjessAKqH8soQFl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05pnJh/oQ6Ovc2dCzOmRueTqHrT09BxUNQNqyK9Hr60=;
 b=2aQHuYY8JhGG6kMurgXZ4oaF5LE887hzKO96P3lGfgtm/1GZjKDn/iWFfPpoeUIBrLXg/NqJDepn5Kjo1p4Wc6PqhXEZsc6qeJB1w/oel1u2gzGmMBlDdPq8QxKzvPpZ1V4MlP53SGxqoYZdTfhPKg4wgproPVZbJis6X5WTFaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 05:38:35 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:38:34 +0000
Message-ID: <70015507-f820-4dad-a449-76238f9036de@amd.com>
Date: Wed, 13 Nov 2024 11:08:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/12] test: Correct regex string in test_spi
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Padmarao Begari <padmarao.begari@amd.com>, 
 michal Simek <michal.simek@amd.com>
References: <20241112141326.643128-1-sjg@chromium.org>
 <20241112141326.643128-12-sjg@chromium.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241112141326.643128-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b86799b-15ca-46f0-2ed8-08dd03a56a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVpmYUtiZTk5UkhkamxycHdycFZUNXZ3c1pOdGwzRHdVVVdSNlQ5a3hWL0JY?=
 =?utf-8?B?WkdMZGhIb0VnajF0OWN0SEpNZEJVbWhpTGUzbjFzdzhXMG4yRG1zZy9Jb2Vr?=
 =?utf-8?B?M2pZeVBJUjMzdVZwK240RVpyVHZKc25iU1RWRHU2VHBBWWVqUkVEakJkWlUw?=
 =?utf-8?B?Q2d6ME85QjBrTE9QSHY3N0IyNFBmLy9ReGZSOWJ2VmpZNkNrd0xpOHc5NTB5?=
 =?utf-8?B?TklWU0QvODBiVVo2VUVmcXplL3dqVlpEQUo0cTl5eDN2ajgrVk9oRG5hS0xm?=
 =?utf-8?B?Nk1OU2cvMTlDaVppNExaS3YvbVVmU2o0WXZFVUFjcW45SU1kbzBPZll1WUUw?=
 =?utf-8?B?RGxMU2VHbFRiWWNhZ0xUanNRSmhEcnZ5QzFoeUNBT0tzUk9MSkwyUjhiTVpo?=
 =?utf-8?B?bG16MFRjVit6T2lFV1c4MGNYdkhSWWM2d2dMNzE3dDZ2NHdPeGU3OHVKZ1NY?=
 =?utf-8?B?RzdjUlo3ejlzWlEzUTZWRkxGQXhWczc4dGRranlMa1d0eC9FdHlTU2RjTzVS?=
 =?utf-8?B?OVpjU0E2dDkvcGxuMWxsRytWOERuL1pNRTRjVjBGeXdWTnFNa1htNVJCY2tK?=
 =?utf-8?B?REFQQWRPcFZKTVlEcm1Rb1ZaTG9UbmFFeEJiV0UzYllubklhSTlMVkFiNDlP?=
 =?utf-8?B?ZFpsSFBPMHhpc21Pc3pXTEpaZHp3ZkRGK2ludkYxTUNtYkFBVzV3T1YxNUVk?=
 =?utf-8?B?a1h4a1N4NnVNSDZURHRENnJpOHFjZlhRQjRSbm9UZFNWaXVtZlg0VU9Hd1hM?=
 =?utf-8?B?bVJvUzhBdThEczJoTU9oejlWamM0MTl5QmZkQmV3dVYvN1FrR0h6UXFCaUlk?=
 =?utf-8?B?UWgyRGxpcUovbm5MbkJxN0hucHZkdGhSNkRYSjVZNHJ2d1BvV0RpZ2k2dk5S?=
 =?utf-8?B?TSttelg3WHZkYmxpZzU1dENUZllJanhVWUVWWGJkNFNsK1YvaE5hQmhSSEdE?=
 =?utf-8?B?SVFMUGN1S2lmUW1oakJSSmZSdjlFRHl3TFZDMldmUTJod1c3YVRudHRYMERU?=
 =?utf-8?B?NXgzcGZnbXRqVW1tNDN3aUtCdTFvTGRySm1oRDRsNjlBVGRkYkJnV2krdzJE?=
 =?utf-8?B?dTNIS01xbVNHWVF3cVhxMGw3MWUvMmZBbmE1SlFiaUZpaklJWUZWOWxsV290?=
 =?utf-8?B?MFExdGt6aHhoaFVMOFdEREt5ZDRkTTVpeWwxNmhWMElWR25lem5jbDNJQmpH?=
 =?utf-8?B?ZVBicFE0YkxrRDhlRmU0MTg1OWU2cVhtSi93V2U5SlFnWGFpdENab0NyZGhD?=
 =?utf-8?B?WTBLVmR3MlpscGVqWDRFc0t5Skt3aFFJYm91c2hzZ1kzaGo4dkdYWlQzd2pP?=
 =?utf-8?B?Z3l2Y1ZNa216NmZ0L0M1S1JqZlBnSVR2bFhIVGtTYnI0WFhBc2RvdkJrRGZu?=
 =?utf-8?B?cmNodU1TQWR6bUVrNm53bTNVYUR4N1NTZjhCNHBHbGxHelVRb0ZiVW5XblRl?=
 =?utf-8?B?RmdTRTM4a3orZzJ2YngxQzdTNlkxeDJjQkNVZkYyLzQxSEEzMVhRL25yQ1Vz?=
 =?utf-8?B?M2FDbEhNU0pGU1o2ZERUT0hvWld6MGxpQVlyZEhNclIrZmJFTmFXeHZ5anFL?=
 =?utf-8?B?STRldkVtWm5WcjRTa3dGUzVpRHNYbElMY2laTnZ4SGR3UzFtWmpIcnRTaGs2?=
 =?utf-8?B?VGord1BNU1JCZkw0cVJSb0tVR2xoSmtscUlCRzU1U3JSbkZYV2VRRlZad0Nq?=
 =?utf-8?B?ckJLNnZWYm8rYk9oUDhFRlBkOTF4Q21IQ3Q2U241aXo1TytxWVQ1Y0ZrMGg0?=
 =?utf-8?Q?LmI8/kBEwhccUsyngbf6mZUFNh9FQveEoelSrF/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNZSGltS0dOYWNoVnRhcVFLZ2ZuWjV3bE1Gck1iKzZsSjRZWWU3V21rK2Z3?=
 =?utf-8?B?MCtWbDE2V2hPL1RlRzF5V3h2Y1FnZEV4VzhSSldjd2JLTkVIbWlLU2JYeXJF?=
 =?utf-8?B?ekw0NUpkT2dKQXlhR1BTKzlMVVVQVGFWTy9KWU5iaWp1UzJMdWg0N3M5SndV?=
 =?utf-8?B?UVBaQUNLeG9lOXJoUmNBT1NhN0VESXdpY3N3Y2hQdU8xVkNJaHYrZjdSb1ZS?=
 =?utf-8?B?cnVQbGc1UjNPdDYwMGJUcUltL2R0VlBzc3pvZml1cTRlUUFXYXAyMmdmYlFk?=
 =?utf-8?B?c0hQbUpxeE5xV3VLUXh3R3dUeVNSS0swenF6U3NLSHR1bExYd0J0SkxSd1Vq?=
 =?utf-8?B?MlZIZlhQUkJpRGNUZlFSREhCdjk5UmxIWlJwem5GSnpLMVRwK2VOdlZNd3pJ?=
 =?utf-8?B?Q0lYMGRGQ1RGWisrWnl1eVZIWW9kaGQzU09SL2FxdUVyRWVQT2tqbkpEQkFw?=
 =?utf-8?B?QTY3SWluRERWYUt2eDlYVWtHVXMyUGlzdWlSR0gzbnFBdjN1eXZsalFNbklI?=
 =?utf-8?B?RmZuWkRrZWlJVmR4cTd2RXp3bndUZDNpbFhvRVV4cmVUZjl4SVRLc2FtS09C?=
 =?utf-8?B?L1lpVGxxeVVxUHQ4OXZXb1BQVFlrSTE5Zzg3VU1rSFNvZzRKZS9EOFRiWUt5?=
 =?utf-8?B?eXI3OVJESXo0T3NmQzFGck80Und1aU9IU21jZmVxT0hoRUoyVFF4YnpvT1h5?=
 =?utf-8?B?M0tjWmxrc2g1dk1DVGVoRWxBbWVKTlZIR3RkT3luWmJnS0p5Vk5PUUZTS3o1?=
 =?utf-8?B?dVpEM1VwSGdBeW1kZVBsWXpOQmhDNVNRTnlsQlUrRTVlVkxVZzRpL3Y4c0g3?=
 =?utf-8?B?LytNMUo2ZE81OXJ6RmpwOW81bFNsWGhwekd5eEZGSXRRcmx0cGtOblpQTzAy?=
 =?utf-8?B?VWdMN1hXZkNDTWpzSXZOM3hDbjFqQUE4dUE3cUQ0a1k3ckY0NzF2SmFibjFj?=
 =?utf-8?B?bEFnMm9qUTR4QlptY3BoaVNkd2lyeW4vbXQ2OHpxWjdoVFlyeFVFcmpQYlE0?=
 =?utf-8?B?MVZLNXlFZUZOc0xjN0piSlNJZlllQjhCUVA0dVU4VFN5c21sa0l0QnF6cUdV?=
 =?utf-8?B?Zi9GR3VEc1VOT3ZlOGhRREg0cHhYTmNkcFI2cGN1RGtHSmV0cG9PaEJXbk9V?=
 =?utf-8?B?b1RuREIrTlo5YlRobDhwZjY2TXRsd0NxdEZPWVNHQVZVaHRpdVlrMXYrNk5U?=
 =?utf-8?B?eER0OUg1bWsrQVRlUHpFWG9zbzJKVVlETEhTS2JiUzRnS3VtZEo2UE5SM1Bz?=
 =?utf-8?B?NWdBSEN3MlhaRFVKSjVkZHU1UE40Y1R1VDI0bmFBeEluM1lvdmQ2MWhGSnpO?=
 =?utf-8?B?VllSTXNRR3orcThBV3ZJRXM2ZFhIS3Ewd0Vwdk5IVDI1dFlzVjZURm8zaG1S?=
 =?utf-8?B?SVNjbnRZbzRJbGJtVFN3RjQrRGlPcHJNeUIwby9EMG5qZ0Q0Yi9yWTVrcFJk?=
 =?utf-8?B?NnBheVM0ZEFDV08zS3crbTkzdDBralQ0Z1U0ZmxtbGpjb2hHai95dHRjNWVK?=
 =?utf-8?B?NGdSOEVqWlFGeGxTdkRPcGRyY0hUdEdLeHAzRXdQNGtwVVpjbFZpa3VtS1Jp?=
 =?utf-8?B?L1c4c3pWVExLYkZXNDJYbE4vU05wY3h0SVFjR3N0SG9JdHVlNzdyTCtEM01u?=
 =?utf-8?B?emhNVGRZeER1VHdFOFZWUzZuSW83MlBOUzFFTUVBOXR4dk1GMVFXUHNsTC94?=
 =?utf-8?B?Y09ySWtURUhvTnFhZU8rbnV1SFgxRisreVI1TEhlTlJxdVhnZjhSeWRtdzlQ?=
 =?utf-8?B?UXI5c0ZycFBITDc2WC9jR2VhMmU3eWU5M3p6MWowNEhRVnNqQnZ4TTkvcU5Z?=
 =?utf-8?B?YlBLRWl5emJvVEIxdEx4cTlXZU9hRmtSd3JpaU1HVktxQ05DYXU3dkJ2L1Bt?=
 =?utf-8?B?L2laTW5hQjFyQ2w1eDJiRjludGlWYlNlNE5OeTd1UldiN1pzYlpmNWliY3A3?=
 =?utf-8?B?S1dIcHhWUTR0Sm1pOHZsTE5aSUhrdllBUjlIZkpuV251QXZUMGtIS3BBVTN1?=
 =?utf-8?B?Z1ZJK3V4TzI0cTVOY2ltTVZhcmpRSlMyTWQ3QlB5SXNPKzZ3Z0IwYm54ZGl3?=
 =?utf-8?B?eGNnbGprSjh3MFNTSk9VVThwWjE1YzFWRFFXWnByWHNqZWRiN2ZEd1Bua1ZJ?=
 =?utf-8?Q?7czI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b86799b-15ca-46f0-2ed8-08dd03a56a5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:38:34.8916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqCciGASMn8ZTLUA/8wlNkJtLCVlZWaL90KYbjoSYk0ztQK+aY+JBI0zUn95T2XN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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



On 12/11/24 7:43 pm, Simon Glass wrote:
> Use an 'r' string to avoid a warning:
> 
>    test/py/tests/test_spi.py:698: DeprecationWarning: invalid escape
>       sequence '\s'
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Add new patch to correct a regex string in test_spi
> 
>   test/py/tests/test_spi.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> index caca9303271..44e54738dd0 100644
> --- a/test/py/tests/test_spi.py
> +++ b/test/py/tests/test_spi.py
> @@ -695,7 +695,7 @@ def test_spi_negative(u_boot_console):
>   
>           # Read to relocation address
>           output = u_boot_console.run_command('bdinfo')
> -        m = re.search('relocaddr\s*= (.+)', output)
> +        m = re.search(r'relocaddr\s*= (.+)', output)
>           res_area = int(m.group(1), 16)
>   
>           start = 0

Reviewed-by: Love Kumar <love.kumar@amd.com>
