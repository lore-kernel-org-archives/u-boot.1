Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5D6CCF9FA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6E68393D;
	Thu, 30 Oct 2025 08:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WS/IkL0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8935983942; Thu, 30 Oct 2025 08:56:49 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E249838D7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQwFMrO4VsSXXENvmaSu74i/QNuHjPIxlADtOrYST9EmLlddYBITtQ9gc9AvLJ2lYni8J3suxCVqCZJB+9Q8LUOMnbfmko041qfWzz095y62+hUAlXm5Zm9/7BOxOJic45QhH+nFnE2GzxOvS9Ns5SsU4LvTi2brJ54pEKZuJ3UMyIi7EWIs+N5EWCntKDvFuFqgMajLfhsrOgpmy5NBQSrWcHV1kVSnnuTlV6NmiYg1Eoy3Zt+YG5BjgP8dxQBxaHn6As0TpDQ457UWWaQT/H+oS4j0t1tFBEp82JmKPo1GGEMe7PlqQTK3YGAecre74mQen6aAC0vZbx5DkLEDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnuM2oNxhF+jrQZtxUAeAEez1ysbUXpaeNr/zvJguiE=;
 b=OfRnzwQX2iRcT05fnJTp8JysGKQkwsMPwFmZH2AXI1DMh6myYi0m4BEFQnojazYQw362TL34elB6ZkF0cir0gwjbLHnTa57qAZRGy/SIL6gQd/SUkSo0U0slAlGtyuNQHS5in3xQRgYWVc3Ggn8NpaCQvyDlovi20sHqKMSpBLeudvR20YqQMKzsf9IidshmmPSCJIwyzxREqdB/0nuoEEHVIN0bwwi5D9dnbg7CIwsQPWQgVCBMxktuJaWwB/JsQhVIzrvt/CvQxnCKotIci+JY+gOLly6IuTu0eObPNa5NfMCGm4SwJSouDqugKshLSvjwn7sMnorYJvZObsraWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnuM2oNxhF+jrQZtxUAeAEez1ysbUXpaeNr/zvJguiE=;
 b=WS/IkL0EPVQZRGEKhbCeSM+pOiEXF8J4TGIS7l7ygI2yLq9ki8hInUu2n7nia26n8THAaPvCzR+yBehb+ovcCbu5h4P0QqkWTZDHC892ZHO5O3WAAap3bj/J7oE35qzJ0UAxolPJN/i/kmx/tV2ZsULx3/8ZagdbMwW2bje+ZyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 07:56:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 07:56:43 +0000
Message-ID: <872f1e74-55c8-4a62-9216-b5ec12beb394@amd.com>
Date: Thu, 30 Oct 2025 08:56:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: brcp1: Move SPL partition to offset 0x8000 in
 SPI flash
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Tom Rini <trini@konsulko.com>
References: <20251029092252.115582-1-wolfgang.wallner@br-automation.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251029092252.115582-1-wolfgang.wallner@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: f750e79f-d54e-49a2-da87-08de1789de0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmRxWnlTOXowemJtS0N5WWR6RktBbXdrMUlOUWJwaE13bVNISW5ZMHp3MzZj?=
 =?utf-8?B?UzZrSUlQRko5bG9INDM0UTlNd1V4eEs4M2ZGMTVGVHhiWDd4bzBYQWtSckFj?=
 =?utf-8?B?UUszVzFrRk5lZDBtMTZTL1cvNDRpRGc1akJTaWMvR2lRMXI1YVFKc0hOdzVj?=
 =?utf-8?B?ak5SSDdKYVp6Um44aVczMzByejZjT3g3OGRaaXh4NWJRVzdBR1JSS3dpWHBm?=
 =?utf-8?B?eTRaQkRXODErMURySjgrNjVHeEJMVzhCUHloeXRQRmEvRXc0TUZtRERhYVFw?=
 =?utf-8?B?RHNpbzVjdXJPRWtLdWVGR2I5VnpZVG92NDQ4ZUgxalRDTHFscTBsNVc2QnhX?=
 =?utf-8?B?a2dpckIyaEZQUW16dDMvVHBGeFkydlpuV2RJeTJtdzBrMUVOQkhUenhJRmZ1?=
 =?utf-8?B?cHZzTkFwNXZXTDM3VU13bkZmbFNEallLR0lsaGhZcHJZdkFINTlodUcwWTZR?=
 =?utf-8?B?SXNIR096WS9na0Q0V3hxTVJsYlhzcjI5bGh6bjdMYVIxUnZSeUlLY01VZG0y?=
 =?utf-8?B?c0c0aTU2YzV0ZHNid3RyQTk5b3YyWUgvTkVjenpmNTRnTWIwakQ3aDVLOFNu?=
 =?utf-8?B?akRUOVE4N1ZISE04cjFVS1UzeGlwTzFvZGVrQ2lEN3NyMDBiZXl6dE9jOEZi?=
 =?utf-8?B?Z3E2S25zUEVYRHRFVzJKeHMxaGZQOEx5RUEwbW5JaVJwMmg4cnRwZ2F5UkZ5?=
 =?utf-8?B?OHRCOS9MeXEreTJTRUdDcUNDeWpyU1B4N3BTdUQ3bWliaVM3VlVQcVZOUld4?=
 =?utf-8?B?aXdMSDlxQm51UWx1RlVZbStXek1xMUtOYXI4allIa3QreFdDU1NUYUJFcFhj?=
 =?utf-8?B?NkVsbVVHWE0wcjdDRlBrZXRoR0FuZS9hU2plejdxUXU5Y1ZtUjhMT3pRRG5k?=
 =?utf-8?B?NWRmVk9tdW1MZXN3TFZ0UTdxWlJRRlIzRk55SURlSk9tQnhXL2R4WWh5eHJ6?=
 =?utf-8?B?NysrNkZ5K2hjS043RkdWZ3BwWFh5V0hiNGVNRUw2bjBYcGNSK282TC9vczJk?=
 =?utf-8?B?TWtYdDBHbUliLzU1SHVISWI1WThsemtXVWwvRkxqWjBzMVNYZUlaeUR2czJV?=
 =?utf-8?B?aUJ4U1FKVkdSc294WHJjRHZOVXQ4N0toZ1dBWE8yWngxMGh3NUtVdUQvMGxa?=
 =?utf-8?B?cGpkSGFyR1ZHUDRIUEJENTE4NUV4N1g5RVZaZEs1djZ2am9sWXFaenVLRGIy?=
 =?utf-8?B?LzVaSGZEczR0TVNDdGUzM3ZnQTE3Nlh6bFlOdjIvRWlaOVVsTzVlZWZUMGts?=
 =?utf-8?B?Y0FVNndjd3dSU0JCT09ZVVVTR0N6M09QQVA2RmRSbzVUUldrSUkrVlRaaHdR?=
 =?utf-8?B?RVltQkpGekN2QXdvY0tZQ3pZVGZLR25zN3M2ZUxFU1JUWFQ4b1dvWk9vQTk5?=
 =?utf-8?B?ZWhITGdzSG9VdUNkY05lRnk5MTRTVFpLcGJPU1Q5cGJycnk5SVdKUkdkWjhV?=
 =?utf-8?B?OHltZVFDajNidGpGRkFOTm9tTU40Rk9BMEhsRS8remFpK3VMdUxGaVdURmtU?=
 =?utf-8?B?Nk1UTXdxcS9tZWl5aExDZTZMc21DUFBzRmJvQVZPSWJnOEVzUFEvVzVnOWtB?=
 =?utf-8?B?c2h5ZDdkRkhpTklEK2RsL0ZZZllQYmdJcGtEOWZYZDc5UUJONXhCTHErK2RK?=
 =?utf-8?B?eXJBQlg2Mk45b1FMSE4rRDU0UWRZenZBaXRhRHpvNHYwTTJ5NExHQVhuRDQ5?=
 =?utf-8?B?K2RHUGdPeHFQTFFUL3hUeDJBaW9BQ0JHQUN5SkR0TGpTckFKUzBJU25na0Ft?=
 =?utf-8?B?dEU5U2hrZWtuVFpvemhCM2d5ank1RUpYeUt2bzN0TysxUEdobkQzT1BQOXhm?=
 =?utf-8?B?aGtxK3NSbGhSdXpmd3hBaEk3aGNMQjVMbHpjNTdxNkdWSHEzMS9Tc3RKZXRi?=
 =?utf-8?B?RnVOZ3NSc1UxdUN1RFFiYU1DU1l2WU5xMk0xWmQ0eDVUNFZ0Y3h4eC8wcWJr?=
 =?utf-8?Q?YVYYQ2KK6YlxJ/no3p8xYbPkmZCwLkwj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE43MzdvM1BhY1lQbGhoN016ZTVYVmVNTXNERTBRUWsxeFFhWit0NEl0aXlC?=
 =?utf-8?B?Z3hyNHBzd04yTXV5YnFnbWVCM1BlamxKZmZNOGlueWxJdnJEQW54cVhBRHlw?=
 =?utf-8?B?cUM1TW9rb1pHNkordmplbGRLS0pUSmtyWVMzNE5zNHZESUlVM01XYUQrRkI2?=
 =?utf-8?B?V1lOQWMrNzJOeEtzeThhQnVJUmlWS0lNUjZuZUVMbVAvOWE3UFIwUW5RYWdP?=
 =?utf-8?B?eFk0OCtieDlCc3MxZkV0aWRWdWpiNkEzQXc5cnVlTVQ3N2dnZUJMbWVzSEps?=
 =?utf-8?B?c2JDZSsrTXlFelU3ZVJpSGE3OTlaVzhwZzhIUTFzY3c0TWMxS2lBeVdqSFI2?=
 =?utf-8?B?RFJGcU8zcnlVaTJzRjQyM1hvREQ2NDhjblZCamovdEFyamx3cTBxaHYxOWI5?=
 =?utf-8?B?NHdOVHgwYzVsc1JuZTl2SUlreTJ0VVZoeHc5YXFVRFJabXluTkM3bVUreUx1?=
 =?utf-8?B?RCs5bDJqT0NkZEtwWEhsK2lJUFZJWjZZNmRjR2Z3eGs3YXZXZ3FaKzJ1Ykdx?=
 =?utf-8?B?OW1MRFNsbjliSEVUQzR5T0c2Sm8vR2ltZ2hRMmRLa3hwUTZRYzVvdzRVMG1X?=
 =?utf-8?B?K1pvMEFxUVFnc3NsN09aaERwMnBkdWZmOVVHZStZbFlXMlN3VHZsMm4wZEtG?=
 =?utf-8?B?NVM0V3NkRngwMTcvaExkTmxhRk9aVFZ3emFhQ1p2b3F4Rmd6VTUxMk01T1BV?=
 =?utf-8?B?aDkya0VCMUNSek94VmQwcGZPRUVkcWwyeU1ha0VubWdGYWxBdWEwYjVYSFFu?=
 =?utf-8?B?dlo1YWFQOCt4cFpuMjN2MFBaRzBtMnJNRGEzeDdFWDZ5dUtjbHl3Q3VZTi9G?=
 =?utf-8?B?SFFjbXgrSDBjV1M1QzZJMit6MmR2REJWb1BnUFI3bDVhUC95V1d0K3d0bVh6?=
 =?utf-8?B?SXdxQk9XQXdxTVMyRy9oYktEZVhyQ29rNk1Eb1JwaEROSU50cEpoc29sZnI1?=
 =?utf-8?B?bG5xZTk3QVllajhEM0l1ankveGxpYmxJMGFNQnRTZVROZmcrV1J5LytvMksy?=
 =?utf-8?B?c21obmhZNHlFeUlKS3Rvd2tVUjh1azJ1YXYwUEZxQUw1bmZQalZBM3RiT21V?=
 =?utf-8?B?a2o5Rll4TktnZ282NDFxdTcvSFF4WWJmSXV4Tzd6a2YwTVBDaU1WbVJNOGtR?=
 =?utf-8?B?QkI0dThleW0rZ2huMmlRUllaRGNlOCtNNlBPdWcvUXFnU0t1K1JsUXMvTkla?=
 =?utf-8?B?YndXKzArb2dFYzVLdkhDeE9sMFFEYjEybDAyZmdxbHpvb0VkV2w3RU5taXFM?=
 =?utf-8?B?SjlaQ0VSZ0dqTE1md2FPR0czVDhoc3NOSVFzMFBpNTNHMGpqd1JYZHVVSWNo?=
 =?utf-8?B?bmQ0NFFibm5TeDgxMlVEa0FuKzBJUURUZ0VzdTR3NEsxZDk4aFBnR1E2cWJu?=
 =?utf-8?B?QVMxeXhvbWkvaWs0dldWNTZJMkl1WXZxNHY1Y1MwL3lOdW4wWkRyWDBGelVi?=
 =?utf-8?B?SlVabVR2ZFNEQndGeFplOE9KR21DUGNwVks0L2ZQWG14RytrYnVJa250ek9a?=
 =?utf-8?B?VEREdTBmbmluMndWYUVUcHRPRmRCK3d5V2R1cTQ0am43eEZ2VXFjZWcrRmFE?=
 =?utf-8?B?QXRFSnJGd0tLb01wWHYvS2RPd1NTK2VUNEpmeGRzVTFpTjhmd1hRV2JJeGVL?=
 =?utf-8?B?eVZvbzZqUWZoNUZRcXFvemM5Wm9HS1grakxGTEpabXR2dkI1TnRYUEJPa1pR?=
 =?utf-8?B?b3lXZHd2bVpiQXBSR3VjeGFjd3ZmUzBreExhS1NzVmJWU0Q2WGlKbCsxc3pm?=
 =?utf-8?B?VUdHQ09ORG9UNGdVaVNsQ0N5eWNhV3JVZ3lHbDlIL0x5dHlCWTcwZE14b3ZQ?=
 =?utf-8?B?d0Nqc1I4K1J2WUpBTmtlUUpqVG8waEFZd05tNldWZmxxNFA1aWxoSE0yUnpy?=
 =?utf-8?B?djJ2WjVZM0h2eHhsdzVyL2MzOVlVLzNyN1FxdDZqY2cwY3Awc0twcWRTNW1I?=
 =?utf-8?B?TGFxVitpeGsrOGR1Wkt5OG9NRWgxMDB1S3Rlc1VRMHpCUGFwMU9yc0RSNjRT?=
 =?utf-8?B?Z3dHaElPcWU4K0JSdUhNdzVQZWhrRGhoRHllVk9MZUZLbkFIYjRDbmNack93?=
 =?utf-8?B?YU9rdG9LdGVyNkhEUEhJUjJwS2J4Sm05UlVCL29GZ2w0UTZkQ0hoL21sYUw1?=
 =?utf-8?Q?c7HScfvqreOT2cOo7k7fjhGIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f750e79f-d54e-49a2-da87-08de1789de0b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:56:43.7414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeqFcct9Jm5//IkzBASeon5p6/ICqWu673aTqtjermN6qwmIQ12uTOIJw3mweHvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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



On 10/29/25 10:22, Wolfgang Wallner wrote:
> The ROM code of Xilinx Zynq searches the boot flash for a "BootROM header"
> at increments of 32k (0x8000), beginning with 0x0000 for a
> configuration without authentication and beginning with 0x8000
> for a configuration with authentication. [1]
> 
> Move the offset of the SPL partition on the brcp1 board to 0x8000
> so that both cases are the same, e.g. a board that is configured
> without authentication can boot an SPL partition with or without
> authentication.
> 
> [1] Zynq 7000 TRM, section 6.3 "BootROM Code"
> 
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> 
> ---
> 
>   arch/arm/dts/zynq-binman-brcp1.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynq-binman-brcp1.dtsi b/arch/arm/dts/zynq-binman-brcp1.dtsi
> index 3cc8ee8b810..c853e8c7b15 100644
> --- a/arch/arm/dts/zynq-binman-brcp1.dtsi
> +++ b/arch/arm/dts/zynq-binman-brcp1.dtsi
> @@ -15,7 +15,7 @@
>   
>   		blob@0 {
>   			filename = "spl/boot.bin";
> -			offset = <0x0>;
> +			offset = <0x8000>;
>   		};
>   
>   		fit {

Applied.
M
