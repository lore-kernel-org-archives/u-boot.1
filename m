Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82010C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F178C809A4;
	Mon, 17 Feb 2025 15:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lB+bz3rY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F25C80BAE; Mon, 17 Feb 2025 15:36:08 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CAC8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnKfQOFiTU5w9Q/u5Wgn7XirSk2JfCJMiPGXpRZqWXAmMmBEkBU1r1ybcfgowr1oudCgNNL54HvkUgkzhSAej4qkZYEGrFHFEZ84K/T0Ut7lZ4tyzUYgW73zRWBcJLwbOJ1ClaV4S86/TtU0fjyu51AMrvQSU2UZ0Oz/EJzKGJqRRlWNV+g3DkefY0/E84eZvqkTG7QxhA+UMWNhkhjK4GyjjBLxs6InND/B5lN6IWMjBPBeVEQDXdu3eKYzSlHVFv4Gy086aGd5MXeMqESWNi1rsZKqND1E836nzyDve8w6u1F5CRuuQUBP1TME6vfWl7EwygKMHRQxjvzK4FCcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK208x1dAukA4mtl3XNqEL2NWc7jWX4SyvtiEgeg2os=;
 b=SuqY6RG26FRN6THkvRIFiiVS4Wph/Vj5QR9mW9l2MNOUY8Tgw35Wmsqx28hAjl/lPMjhlOvtx7JQ7ykoxOfjhOAYGY5Hkv106BKupEqVkRX9mFv2LR0x+D9PthPqLbZ8KQ9ejHGS7uqSt8K4qg6oOif6gdLjFnuPt+gNzETxSfHzCjtoPJYpIbsHaWtpYZpZ5zyhJdP+fET1UA119zFAHGcsqsOaZh74KQ1DWbG5RS4c6x05ZGm8rc5A7jIrAZq4MnnYg/6p5clChh4Wq14uHGqxFU0mIB0ETpahsEGvWolVY02pK7/kmAViSa0m+6aXsAH1/SM/AKnTE0WxwzFniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK208x1dAukA4mtl3XNqEL2NWc7jWX4SyvtiEgeg2os=;
 b=lB+bz3rYeeFg4PI21VaVt4PfHtdTPH30qiyragDIt+5uOK09jKpjeken7wHsd+pihkRwGQOAp1c9fiNbg6zwaTxL950qOMl4zCGzBaKlA2rYODkRVHrI+27kXa8YJuvCbZHL5G/osWsDDhx1PXht1I/kOAzmz8eI6K4CfallEnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:36:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:36:00 +0000
Message-ID: <13ceed63-081f-4cbb-a11b-00181cdcf1ef@amd.com>
Date: Mon, 17 Feb 2025 15:35:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynq: Guard code around SPL_FS_LOAD_PAYLOAD_NAME
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <f15a9762494945814b06a71db90ee4db59dd17ed.1738910601.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <f15a9762494945814b06a71db90ee4db59dd17ed.1738910601.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a2c65c-7822-4475-f5e8-08dd4f606601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SitzWC9tOHBFZmVmZkVudDg5OWg4Tm1zK1BocldMR3NxenVXN0p1TnFRUWZ5?=
 =?utf-8?B?Tk1aRnNyTWhmR1B4YVZPd1hsMEI2aHQrenZab1pwS3JEa0lwTXJXS1J0Skp2?=
 =?utf-8?B?TkpuRE1vWlRUekJyY1lWNTZGVWpIY0s2cWUrd3BZaVh4eTVUblpDYWZFY1lM?=
 =?utf-8?B?QlhtL3luMVVwOUg4SWxnQXNtN2RNcGptWTlWdStZOFRQNGR4all4UzFTbUg5?=
 =?utf-8?B?OHVuSmdHTERheCtIaUVVdzBLcFMwRWl6Yyt5N1ZIaFZJWHRtVTJmVXlETkV5?=
 =?utf-8?B?VTZTYWJqQndjc21QbVpKVC9IUU9Sa0VPZkxxalgrYVJ1RlpzN2l0d0xrcktS?=
 =?utf-8?B?K0hmTXVKZzVXeXpObHBpaXBnMDRxZFZ4eXJQNExHUzBYazE3K1U2SUVyNncz?=
 =?utf-8?B?TUIyT3MrdFgwalAxSzFqUnB1d3JyN25nN1Bqd0tCZEVEMEIxUElaMUsxWXRM?=
 =?utf-8?B?RkViTXFsdk9zUVNiNExHNUJlRlpzSHVQZHVzUlNWNmk4d05LeEQ3WERidFFm?=
 =?utf-8?B?MEE2Yi9MZHg4dllydURJb1BlOWdiYVV1NFltR2Vmekl1eHJWazVkUS8wQnlk?=
 =?utf-8?B?ZENWd2Fid2ZxdU1mNnltU1BxdXVMY2w1c3RYN2k5UlJaemFsSUR0SU1rOWd2?=
 =?utf-8?B?MmZRWWVPSkNUd2JtR2FFR090eHNMUkw1aXhJMEpGZGxMQU5lZ3JHbW9ZZi9o?=
 =?utf-8?B?L25CWTRDRFVCaGFuM1NUSjQyOVliZmdjUGpnQzdoL3R0ZGQxY1k3U2ZMQm1u?=
 =?utf-8?B?YnFDYVN5K0puNHBaeXdmZFRUM21TNTBJaHUyZDkzb3ZWTEt0NkpZdXF0V2RZ?=
 =?utf-8?B?NFhlYVMrRnY5OFB0YXA2NnErdy9lemEvSTV5a0ZMcUxwVmUxRklzajQwTU5Z?=
 =?utf-8?B?UDNiYWcyT3lla092MUs2NURPNmh3T3dSRyswRDkzcE9aY3J6RmdyRWU0MjhK?=
 =?utf-8?B?Rzg3ME1VK1k4U1NHMU1ldFl1b0JQbEJMcEdaWGZYWDVtSzhkdGtkeXNpampo?=
 =?utf-8?B?dGVIT0ZiMEE1aXllT2dKcVljMjBSaVk2eXVRL2phOVR1ZEo1Mi9VcTFaa2c3?=
 =?utf-8?B?SXdhdjE1aFRVWkF0K04rVmVFUEgzenJadU9yTU8xRmVITFUxL3p6dkR0am5w?=
 =?utf-8?B?SkEwWG5MK0J2dlBGa0t2cXJmZ3FKWEk1bUNPUHZZd1pqSGhsMXR1SUVaTXhh?=
 =?utf-8?B?K3lES2FiV004QVhQUW1SZnJSck5MRW52SWlhVFpmZ3VMY25jWVhhWWFlMVNl?=
 =?utf-8?B?anN1Q3N4MVBjTmR0Umo5aTRQMmxxMmwvN29ZL0J1dXRTejZ5M2Z6U3I3S3ZQ?=
 =?utf-8?B?V2NMVjZOaUZoQkVzTkoydmV0RkZmRitQb0xjMFNOR3lMbXZ5RWVaWWF0elA1?=
 =?utf-8?B?a1RHaWpVbEFTZGJlNmQyWGN3SU9WVVV6OTdtTjZWMjhERTl3M0RwZzFRNjY4?=
 =?utf-8?B?T2daN200NjJjMEgvdW9IT0hpaHIwWGV3cVFTcm5UZlBFRk9lV3J2UVlkRFJF?=
 =?utf-8?B?b0k1b0F0dDNXYXkwUXFaN2dHekdjNUQ2RVNsNlRwVXlrZ0pUNVVuNEkvRjh1?=
 =?utf-8?B?bDNHMk9XOTNUYWF5S0xFSS9tUkdiSVphVVVEUDF1Uzc3RjI0TGxUNy9ZZVgw?=
 =?utf-8?B?UGpKQmxIb253Yk1RcXZQREFLR24yc3M5WTNXTStqc1kwcFRiWWFRNVVNVGFs?=
 =?utf-8?B?RVVrU1ZrWXQ2UVpIVU9hRmE5VVBIeW1QMFkxZTQzWG4wUy9vbjJBOXdFTGEw?=
 =?utf-8?B?Vk53akV2MDRrRG5PdmFKZFU4VU52VHA0M0gxUmM1QXdqWEVta2xpWDRzd2ps?=
 =?utf-8?B?ZmFiVGhzVEpDWitieFROVTNRdm4zZ1VjeUpsb0ZpT2hqZnVZOUg5YWZEMzRJ?=
 =?utf-8?Q?rRv2GsdslhdPt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRkbmQ4MnR4RUo3K2MzKzNDcTJuUWwxTnRLT1UvcVlvWkxHdE9QYUZTS2lQ?=
 =?utf-8?B?SVlwMFZOOUpVbW1JRmo3L1ByTTQwZVF2eDJveUtwVkkrYXRsZmh2YWRvUFRq?=
 =?utf-8?B?dE5peUl4ejVpSWlnOENjT3FqL2pHTU5JK2djb3ErV3hlZUFNbkpCcHFoQkJm?=
 =?utf-8?B?aDVibE5lY0krQ2V0WVZJQmd6OFRNL0N6bkh1MnN5c05SVUFBTGVSK3poaEVN?=
 =?utf-8?B?aXV2ejFVV1VYdld2ODNCWUhNZ1dXY3JidzZBNXpWdGx6bjZRVllSYUNUdlpK?=
 =?utf-8?B?TlZTNXNuc3NRWmN1cHRReW94VlNkSjFpMDhoVmFVamwwK21hbmFPbWQ0WHZN?=
 =?utf-8?B?WmJSalIvSU1MN1hHOFRVbXpvNFBsQStBZ2xpVnVMNzc3TmRkcis3eUNncjlB?=
 =?utf-8?B?UWEzckxlZHpVVVBUS2Z2elJNQ2FvSDhEM2hJSEtuclFzQnZUY05ISFI2VTBu?=
 =?utf-8?B?dHlWN24yQysveEFiTXQvMS9FcjBXanM5QVhrWklKVHRIenIyMFZNb1JoR1lq?=
 =?utf-8?B?Mm16cGpPQkY2VDJEcDZoU2EwRzBJa2QwZ3Q0Wk5HVmpEdFR3VitEUjJuaHZK?=
 =?utf-8?B?VjFkSmR0ejZoaWhMekNiaUJGMXZCbVdRLzMyM3dqREd6UmtwVFR3aFZxZHRU?=
 =?utf-8?B?L3FnaDJoemI3WDJuWVhCaWM4UmhQTWE2TU5HbWZxUTZmSkFOaXlDcUtIUHBT?=
 =?utf-8?B?WWdRSFJDNG1Md0xZemd4NVVnNE5XUGFpZ2xHR0t6TEwyRWdseExBTkk0Rklu?=
 =?utf-8?B?SThGREdRWUVuQVNpbUxrc1dQSkNhaFpPUVhFRGlWYVZCNWg3R1Y2bGMvdi9s?=
 =?utf-8?B?NmNtNlNiQ3hjaThvS1RQWVhIdXlyYlFvZGxpckdwQ2hZcGVnTjNGTjJ3YTdP?=
 =?utf-8?B?MzEwQlhWTzlESGhpdUVFSmZJRi9uanNFVG5TL2ZFcEY5TzlZcmM5UXY4VGNE?=
 =?utf-8?B?d3ZZNGZJVmZMNXd1dXlJV25ibzFSaXF5TEtSTDJrK1pheGNDd1g4a2NCT0di?=
 =?utf-8?B?NDF5VWh1dUJiSkVpWC92Z1RraEg2cjl6NjN2T2RtczJaODAxU2NQZG9oYk8v?=
 =?utf-8?B?SG9xdmk4dFd3TTg0M3Q1Uk1pT0FFK0p0dDA4WlZwYUxZRXI0cTUzeWo1UzRi?=
 =?utf-8?B?b1o4K0FqUk9saHRpU1pkMy83SHhGaVd6dVo2WnYyV0FQMzJOdlRPbUpkRFRG?=
 =?utf-8?B?N0xFY0gxa1kzSDZUYll1K3N0Tkl2c29DcGNLR3c0REF0eE03aGxLNUFYRzYr?=
 =?utf-8?B?NUJ2M1pIdjNoNU9lUERLb1RGeUF1WWRGK1ZhSEp5QXMydTc0REt4Ylk1bDd5?=
 =?utf-8?B?Q2dxdEtnTlhKZGJqRHhPeXhwaWxYRGRzb3dzMFNYaGJnKy9nUEZ2eXlBSXVI?=
 =?utf-8?B?NkdBaHdCUG5DRjVQTk0yMXBHRkEyTG5NeTZUWVNoRnhqNnFpWDJZR2RvSHJT?=
 =?utf-8?B?SHFKK1dlb1VRNm1YRkhsVDJYVkd6dVBwYzBJeUdsc1dpYlF3L1hINVh1MTkr?=
 =?utf-8?B?QjJHRlBDNTc1OW1tMmZ6d3NxQ1RWcEtMTkxOYWgybDNkR1BkTjJrOEJvNGQw?=
 =?utf-8?B?MjVkZVRiMFEvRlhtRFNDcnFHMGlqZGU2bE51eWhNWEtvMjQxQmZFcXhsL0sx?=
 =?utf-8?B?MExyaUk2Q1dBTnpGbERpcTRYM3RSRHhVenJUZEtaS0xyeVB4ZDVET3dPSmxY?=
 =?utf-8?B?Vkh1TUVIUlR2QnAvaENUSTBjbmZ0OTJzWDhvWGpuSFBsdXZPUkVjRVVNN2hk?=
 =?utf-8?B?UGVhbVM3eHp2VTdRN2dtVG9aa0tOUzVZRTdmSVBJNVF6Z1A1Y0lYSVVlZXI5?=
 =?utf-8?B?Wks1NEtZaUkrU3NkZVp2Q3lvbnZUbmU0Z0VIcGxmV0I5K1djenJiYkc2eEhE?=
 =?utf-8?B?T1d6RzdrQVdydVZjRjJRbEpqQWUwV1h4N3FLWlVvUi8zWHhobjlrZ3hsU1pN?=
 =?utf-8?B?T3MxTTBnbjNVUG1RMElrTVU4VWtKL3Jxd1FPM2lTUFdqV1VXWUtLMWZwTDBQ?=
 =?utf-8?B?a0FncWVLbzFmWDdIMldHRmN0YTQ1aldEQ1pkVWlUcFJ1a0NzMUo2V1gzZ2F0?=
 =?utf-8?B?dkRRWVJONUhYQzFFNjVDRmRkTnJJTzZQRFpxZ1BxZmN3QnMxNUo2eVN6UlhR?=
 =?utf-8?Q?rLxLPHy9h4dKf8PGfJMA0pXx4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a2c65c-7822-4475-f5e8-08dd4f606601
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:36:00.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrNEXnqUA7e1mimkycjEwblY9J+Xm+TEXzNKuD9f10oEQcjO6RMMvBVW3Lmw0gZp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 2/7/25 07:43, Michal Simek wrote:
> Guard code around CONFIG_SPL_FS_LOAD_PAYLOAD_NAME usage to avoid
> compilation failure.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynq/board.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index a852d5b8ed53..8dbfa5604231 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -179,6 +179,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	memset(buf, 0, sizeof(buf));
>   
>   	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>   	case ZYNQ_BM_SD:
>   		snprintf(buf, DFU_ALT_BUF_LEN,
>   			 "mmc 0=boot.bin fat 0 1;"
> @@ -192,6 +193,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   			 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
>   			 CONFIG_SYS_SPI_U_BOOT_OFFS);
>   		break;
> +#endif
>   #endif
>   	default:
>   		return;

applied.
M
