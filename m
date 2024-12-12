Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDBCE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D6380141;
	Thu, 12 Dec 2024 16:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rv59cdGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875788018E; Thu, 12 Dec 2024 16:21:30 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F05780079
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wr81wZg0VEnuVY/pwkszX6zhkZdjJ5VPcUddmkh+W3TCt8ySsTmh1QpTJX1cH6pkHKcoPr+JP89CcgBltNjnaMIZp+kA90JbklxNJXO/0Fp1b9KRezvMuMcj3FtzKIwZ11OvJJhRhsTMhkeVApntYrhzb51JT+tuYWs69boM78kwUSdRRU74uCiHfyew1kJ/ni3Xc9pHB97nApm0tu+hoiD9h2CZ7WWA3U59L7dZJhbJQrPZiM7nKotFwfHyuHggWcaI10RjLLiXASDzSBDcvKHV/dPeiIPNk+FeVkL+1tXrPTQnrIXyRD8lvjzevtk3P8jPKStKJP8wSQH6iTemsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSou7KQ0T+R6ngbnrI4czjQ9LwFWHIOml1turMZM8VU=;
 b=AKdLgciy+3jo/sxUthGe+TqVdSCjedIEUtgY5SPurYTLRh+vk2WjqAD9ds+edlvKbnhvPj9Wg1MavhuHF25RONzAw5jYeboA6bioE5zH/PDo9cLoL+j7lB/ZfGnEIPk0mgtx/u9ZqcOcKVWz6+aRajemNpV+/VnQXZrHKSWAZEz7LTfrC1ah8AZlBsH49VONpzmG5bb6k32dp+eeiXXc36PWhJsAlquNp0mIl5GHDIIUJJDWDZMHwvH5eU5TwTVByci/yhFgj99lF8VDfhJ0ZNQsGkSVZXOm418SVNpU47/MbmZbUkQNF8QxGeBR+LiZ1ttelhxgtiwEORppyswWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSou7KQ0T+R6ngbnrI4czjQ9LwFWHIOml1turMZM8VU=;
 b=Rv59cdGmmxbuATmWhii5UyCHVsZeEeTA+CJx6ka0u0NGnfZo8BvUuOb3iKzq0HGz0KS3U6WW17hGOF4irxa9dLTSIXsKRlryIEqeTccENcV8hsgfduQnNd73nnbb4xHZGLT01ZQWK9ZtBPmZl/IXn1XxPDCNVNNFMP383b3Czf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 15:21:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 15:21:25 +0000
Message-ID: <6f7f3522-e29e-4fa3-bef7-5e0a42673c14@amd.com>
Date: Thu, 12 Dec 2024 16:21:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: zynqmp: Add support for reset
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Anatolij Gustschin <agust@denx.de>, Peter Robinson
 <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <0504474a91a9839828aecd37f8855fd154cdf2e1.1733742708.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0504474a91a9839828aecd37f8855fd154cdf2e1.1733742708.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: d1648b7c-6316-48c4-4f17-08dd1ac0a454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NJU0ZIVVczdjlXd0Jpa0RqcER6cGtPY3gwY2NXWUdhR1poc3RmaHNnSWFn?=
 =?utf-8?B?L0dVNmZpOC9zTWh3VEpQNlNzMFhmNUYxV0J1b1poa2YySytUd3h6NDhGSmFG?=
 =?utf-8?B?TzN4RWdQNUhkUWk0bGtqMk1pa09EYkNnZU9VQm1yakx0aUUvNjlManVJbUtB?=
 =?utf-8?B?SjRjUUVzQjlURzM5VkJuN2VKT1liTUt3UlBhYysrdE9rWVNsZTd1K2krZXBH?=
 =?utf-8?B?SFlsM1JpZUIzdUpQaDVFWm45OHZQZmtkeVFXQ2Q3WUpOK1pGcXpRSWF4ckI3?=
 =?utf-8?B?RWlaVXMyL0FMZHBWWTlIdFA0eU5Wbm9FaFlqdVZTTjNkRTEzY1kzRTFrelo1?=
 =?utf-8?B?VG1QeTZrVjJmNVI0b1FzYVpLTHY0djhxT0kwdkMxTXRvOTZrSWZ3ejlLMXIw?=
 =?utf-8?B?aDVoaFdhMFRySWFGV2RxL3NqOEFRRXNIYnFZbGkxbUZ4TVMxa2tWT1lZVytu?=
 =?utf-8?B?VEh3ZWN3TDlsMDE0TFV5L1pxWGZ2SEFhNFMwQTh6SnZ3ZEpzdjh4Vmtjakt2?=
 =?utf-8?B?QVNJRWlqVCtCSXVRazBOTFhwYTV0d1hxSkRyVEFIQ05RMGV0WGxTdFJ6bHRa?=
 =?utf-8?B?UmNQeGtIZzMrWkVSN3hXY0tDRElzQnJnMnFqZXBCUlpVNXZNbTRwRXhTR3dv?=
 =?utf-8?B?TkFKekE4ejRobDFoTzBUQ29UYSthQnA5d0N0NGdPWWhvOCtGSTRIemlaN1Q3?=
 =?utf-8?B?bmk0NndGbVNSOVdiUmxYRzlHSWgyMzkySlVmVnlPd1N3b09jR25RVXZXNll3?=
 =?utf-8?B?MzNDR2ZFbzNPem02QVJvRHp0NWw0QXdMaDZpS1VFOTNMcnFUb1pDcUd0RC9w?=
 =?utf-8?B?WFZWdnZJNVVkaSswUWx1dUppY1BlM2o0UkdndCtiRDhOc09jKzFjcFA0eDBH?=
 =?utf-8?B?cy81SnpBa1AzNnVxSk9LNVllZ2JrQVpKQTBQR0I5UGF2cEJLaVNMOU9pNmhq?=
 =?utf-8?B?VTlFOWJvTXMzL0x3Z3JkSW4wQlAxOGV2STVZOW0zQm56TXI1ZWFlNmlGSjRX?=
 =?utf-8?B?dzZCWlB0VlNMWGlsNjVmVzNTS2FrUGhwV2l6RDgxb0NLbG5tOVUvSTZDdTR3?=
 =?utf-8?B?bW5FRHl0eXRNKzR2TDBzdXdkS1lydGF4Qi94OUJ2dkpGYWsvcG1tZTBsZTJl?=
 =?utf-8?B?azBnRVVVUjF2TlZzSjdkWDBTT3d1MGE0VGlFdHFzR213bFZPbHJadkFHbWFH?=
 =?utf-8?B?ZXBOR0x0L1Zwb2xiczcrZzlLcDIrRHMxVTlMUjFhZVhKcjB4RFY4TEJGb0du?=
 =?utf-8?B?dlFWa2RXKzBLRnVwTThSY2x4aWdFRnlRWjF5MzJMdVkvL3g5NXhMQXp6bjRX?=
 =?utf-8?B?MUgxQ2U4R2NuL0EzN1FYQlpuN1FwNE1xLzJabDEva0hqQ0RrTmZTUTBGanho?=
 =?utf-8?B?aGZIK0hMSm1qOGFVZVk2VCsraWlLck8xTjRtL2Z0SW5SeS9pWVZRUWV2NzlS?=
 =?utf-8?B?dEkwU2g3RkQxbVhJMHBLa2IwWnRzTGZzc1BWRWZEbWN3OVZxdWFjdC9VZWxC?=
 =?utf-8?B?QjM5UC9menptL2E0VFNWNXpyNHpWY3poTzMxRXBnVWpTSzJIL0JOa3ZVNXA5?=
 =?utf-8?B?QVlnRElsV3VLczgvcFVuaTJ5Zk9VcXRKaFBqcnEvaVZQMUZjLzMvVHZJZjBm?=
 =?utf-8?B?OEVpa1ZIUkdRcGtxdlBENlRwd25RTmlaS0hQd2wrS0pyNGJiTDM2cEZLbkRs?=
 =?utf-8?B?dC9OZ29DdngwL0NlcmJ1ZDcvODNqS2xFSGFKelVKNFBRRUNIYjVzN1pCd1Nr?=
 =?utf-8?B?MGwreHlDOVRWRkpxY2N4Y0RObEhjRURwYVgyQVlvNjhCV0lURTVScXFTN2FU?=
 =?utf-8?B?c1VDYWFrYSs5SkJjZlZUdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3c3Y0wyaHJyb2ZwSThqblRCL3NWVkZyR1lnTE5DM2NndytiQ3pPSDF1eStr?=
 =?utf-8?B?NFlacm9heFVuVmtWYWoyYkhPMEsyMWdYVGVOdFlBdEpVdm5hdVZDQ05BVFpJ?=
 =?utf-8?B?TmlucXdDeVZWMlhLMldWaFU3S3B5S3pnVjVNb05hVnJCWkxiZERGSWtEQVR1?=
 =?utf-8?B?QnFrVXpOQjVDTnpHVmdnOVpRTHBVTG45bVBjTGJlRTJGZ1dHcGY2bytRbEZL?=
 =?utf-8?B?VE5vd3dwMnJIM1ozTW1zN0FJVDE5Yk5yb2J3SytaY1d2UHlFWHZoNUdtbVhp?=
 =?utf-8?B?bTgxUjNVVlQwN1BXNmFBQ0F4U0dWRUh2cGVsbitHSFNqSEE0UHdKRzZ1d3Bx?=
 =?utf-8?B?SlFWcTd0NWdNb3ZDa0sxU1ZuL1NrbTBaVHFuZmZsSmFYYmdJOXFMUUoyT0FH?=
 =?utf-8?B?MVNxRnBlOGJ4ZWd4b3RpcFo5UGNHcnJXbzRaampZWHRia1RpbGM2VThDOVAw?=
 =?utf-8?B?Y1BUTDFDV3Rtd3FCVmE1bEgzVHlsRmdyQm5EdWNzWDU4OExwMzhKdDJUNHIy?=
 =?utf-8?B?Z01GTXhkc2ppSGtKM2VaelFLRUl2akF4enlzb3I4akg1M1JlRTFlVlVod3JB?=
 =?utf-8?B?M0JMQ1dxMWRkZVk3ckxocmF5STVuT210ZmxhT1d5NElGbXdpTUhUWS9JUTF3?=
 =?utf-8?B?MlVlN3lRalNDczFKMG5mYVJKRC9qSDM4aDRUYWFBTStUdVBKeHNGM0pnTU1P?=
 =?utf-8?B?dkJzK2hpNlNpVmxyTURVN29UNHRIUlBVSVltbkZDUE9NMWVaQXROMTdIQmY5?=
 =?utf-8?B?dHJTK2ZCMm4wR0c0ODYwZERYZnFpL1B4dlFYSEpmMEhxUE16VDVaaUdWbysy?=
 =?utf-8?B?TjJOcEU2TEN6R1BxQlQ3ZXcvR1pVSXd4anNEdFA3b3ZLZFVzeXpHNzYzMEZ0?=
 =?utf-8?B?THRSdFFYSFV5ZEJtYTNoNkgzVmNDQm9Femtyc0pEeXlsMnlpWWFabGtQaFB2?=
 =?utf-8?B?SDgzOG9tbjB4UUZVQitWYk0rOVpGTm1Bdkd4dDJQYzdESlEzR3JmSXEvNGpJ?=
 =?utf-8?B?eGtuOGt3MHUzK1JVNHJpY0FvbENXcWxVZGJNTmZlUWxFZzRZQmc0VTArNTZk?=
 =?utf-8?B?amNSUHZ4dFFlNzJudTEyODZwTHZuQjBITldlRWVrdUpHbTZ1RDVUWVlyM2ZO?=
 =?utf-8?B?RDYwOTRxQ2FIRCtLWTBnc0huTGhFU1BaVU95dVlwejlxdW9qdUpWMG5wQlY5?=
 =?utf-8?B?V1c4elRyeWZsMmNkME5hbElpYTU0bkViNCszWG1vTGVoUVN4L1V0anZXQ25L?=
 =?utf-8?B?L2h6ZmN0R3J5SVR2SnRUb2htd0hxT2VGQm15VkFvUFp5Z3dwcnpmNzB2ZXN5?=
 =?utf-8?B?TnVkZVl6ZC80Um1mYnorazk5R0NkZitaUjYxVGF4RWEzSlZnaXE1WVZCN2JV?=
 =?utf-8?B?dXlZemFUUUxLcFdOR1RITmVPQTBMR3dZbm1VbnhZREVNdm05UlVvbWpmNmhB?=
 =?utf-8?B?ZGVWRG80MHlDM3NVUS9KWFBhQ1JFV2MxYUt6UC9XRjgzTXpZa3ZHamgydzFR?=
 =?utf-8?B?a2Z5c2hQVHk5Z3NtZm9yWUJtZEozZHRFeUZCajZoOEJxWERyWE82SlpUREdn?=
 =?utf-8?B?Y0JBakdSeU43dUNqRWJkRnVGbUFONWloMTFYUjIzVnY2Y2RZa0NVanBXT3BX?=
 =?utf-8?B?eXFZa0VlRllkdTc3UWhRRzFnNXdFMW5HeWxoa1V2d0xqMVdnQ1NxWVJmL3NH?=
 =?utf-8?B?NGhXcC84eUxZeXpWVjFXTWUxaVlqSVBxYWtENW84LzA4SFlTeGJSRWxlcGM0?=
 =?utf-8?B?TmV2NjZHcDR0a0EwQmI0TkVlSVhCQnhUNTFtTnZ5dW1YR0ZyUnJ6RnAzc01K?=
 =?utf-8?B?d0FtbFJrV1RTTmxZS24wVWdrRm02V2I4TCtnMlhWdHRoTHMyNmExV1VleXMw?=
 =?utf-8?B?MVUrb3NyUzVnSDhnSUpIZGxNZEZSMkdsWFlXMFRLaGhDVTJZRzh5em9tT3U1?=
 =?utf-8?B?QkwyUDBsdlo4TVdMMzIxNERRcmd5L1RHcDRaVWJsdXFtUkhrMmFtNW00M2dy?=
 =?utf-8?B?TXNPbVl6bWx2Wis3ZEZzbWtVYmt5bmU2YmZiUk8yTHdTcm5uemZHSHJuUTh4?=
 =?utf-8?B?WEh2ckg4bjR3N3RpamhBUi9JVWI2T2J0WU8vSGRhQTVSaU1SUU5zb202U3U1?=
 =?utf-8?Q?ue51PHTAb0ZT65bru828ubuyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1648b7c-6316-48c4-4f17-08dd1ac0a454
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 15:21:25.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WboF/gdCt2M4XtSHScNetUrsfLq9th/Hx/iNZ3E457zgFb+qyKYTIXfkNbflaUJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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



On 12/9/24 12:11, Michal Simek wrote:
> In Kria SOM configuration DP is under reset and access to DP is causing
> hang that's why call reset at probe to avoid this situation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/video/zynqmp/zynqmp_dpsub.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
> index 76abfeac4433..52af23c3c835 100644
> --- a/drivers/video/zynqmp/zynqmp_dpsub.c
> +++ b/drivers/video/zynqmp/zynqmp_dpsub.c
> @@ -11,6 +11,7 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <generic-phy.h>
> +#include <reset.h>
>   #include <stdlib.h>
>   #include <video.h>
>   #include <wait_bit.h>
> @@ -2093,10 +2094,15 @@ static int zynqmp_dpsub_probe(struct udevice *dev)
>   {
>   	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
>   	struct zynqmp_dpsub_priv *priv = dev_get_priv(dev);
> +	struct reset_ctl_bulk resets;
>   	struct clk clk;
>   	int ret;
>   	int mode = RGBA8888;
>   
> +	ret = reset_get_bulk(dev, &resets);
> +	if (!ret)
> +		reset_deassert_bulk(&resets);
> +
>   	ret = clk_get_by_name(dev, "dp_apb_clk", &clk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get clock\n");

Applied.
M
