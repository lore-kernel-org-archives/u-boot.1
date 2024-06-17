Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E31C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17DD882CE;
	Mon, 17 Jun 2024 15:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="doD+hCji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A465882E2; Mon, 17 Jun 2024 15:30:04 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477298829B
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II4byl5bfbVSSHDyDRe+DJgjAgqnpdYwM0R9Lv11CHN3BMRz6NG7ZrHtZjzfdEHBwkWoMvj0XlHgJn7+bONV+rPfv2gXO7FWRFqoTGh2ZvAScHUgvcrPNGWaaTLhf1eei2apbB02gKWq+nDMxOof8YHXc15WQcEWQndtaxzNfGR3dqkTbelvKDSiuRswUhCmLWLfNY6GaluV+Ec6/LarFsGaDP72JYD8swWiLcVEP/sWI5EfmYJhzwObJU3wODWZOMDbPe+fIki41Z6T4dHybJ3/n7GtmGC/zVYsZRDNf/YO0Xm0DftOMEqARpkTG0k4e+B/6owgrvNRjCv78el98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYqMNk0Br5B46z2fDKH3YmRk7gRk+pMz7mmrbpxMr5s=;
 b=gxWXHdpc99NBaHmRVkSn+1uTcn8f9ppvWC/N6/YSm4CvV2EA+zwbA2TyBX2WNr8Pc2dk/OkxSWDDlSmendEYX4BGfdkpEpfZqoksyycWE0ZFQ07gZbKvqV+JP/ZIpXQQXXno9Ly2aNjzbacihmku4vtT+/bwxONzmmKNL7ZS3A/4y/UQo7G5l5hSgQEZlymt/XAIjGXJ9FCDUvHNbIfhNea4YQQ50ne5Dzc/Dhq+okxoj+BjmNqzCxhs/Ne3zu/taOAwy3Qglt54nkSFuvQy7D2mhYPcf99IZnR4uXfprQ8GeNu88Mm7WnaI782ZwPA+gIq1zl924pknxUCrFC8BpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYqMNk0Br5B46z2fDKH3YmRk7gRk+pMz7mmrbpxMr5s=;
 b=doD+hCjiulh2EN3Fx/bgpVyFodbozjfN3qC13hv+FEQ77AkQA69UZVKtCxtny/9TqXCmb0xcyyp613XmxAYyAvXbdGd+Ox8Qw8ye3I48XQpLm/mHYpEd4xGNUFftgJMazqbyuD8qKh9kEy6+diHUgdOhk+8P3u76iwtLZbZr4uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:29:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:29:59 +0000
Message-ID: <04b6a2d2-c61f-4dd4-99f6-4fa13cd01907@amd.com>
Date: Mon, 17 Jun 2024 15:29:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Align #address/size-cells with node
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <3916fde2e896b8be8863505305118903e0644ab0.1717684544.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3916fde2e896b8be8863505305118903e0644ab0.1717684544.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ca69fd-16f7-4d5e-7a30-08dc8ed19599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGZmZTBJSTJBOWhETFljZUpOTzB6NVJnOW91dXQwZHVjdzBFeEY5NTZ3Q1FM?=
 =?utf-8?B?ZG1scG42QU02U1dud1Q5cTB1c3UwMlU1VU0vdGRXUjZkaGNvRjJyVmxYNmp3?=
 =?utf-8?B?enhSbktzM2wzZUlLRlhvQm5sT01PQmdBL3BhZjlidlp2bnBIWE9nZkNXK1JH?=
 =?utf-8?B?aEFpeGhxQis4TFBLMk1aZjJkQkNaSmdKVzlxbEZVK05wVVpmemsweDIzNE5M?=
 =?utf-8?B?Z1FDc3VNc3hGdlJmUm1GVzl5NitHOWpqemcwY1YvOU5YU2RLbXdoenVMLzJL?=
 =?utf-8?B?VUhCWTVTTEYxQzVQSmNha29zb0JMbXdyWXBlblVoQ3owdzJ2YjgzZjRZRTBX?=
 =?utf-8?B?K1VvZHpsZjRGOXdNQVBxK2JUa1F3STA2RVZ1RjNrcS92V3k2bVNXSEJ3WHk1?=
 =?utf-8?B?bkZEckJDUVZMNU1VMENFVlBvZU1sbGhJMlpsdUhCdTV3NTVZa0NabGVPcG5s?=
 =?utf-8?B?QmtPOGlMNFpxR0MycElEQmJGcTlCY1lNOTBpUU5rRFlHZE93dW9pZ0I4WWZh?=
 =?utf-8?B?MFV1aktOZXJIS1dYejdyeHVvSUhEQ2hvVjV2THBOcmZsWmVXeWVYRkJtTnNL?=
 =?utf-8?B?NlJib2E5YjlScCtqdk9xN0dQaXB6ZnN0NVI0TGFBU3E3dW1la2JsUmNDM2lV?=
 =?utf-8?B?UkJGZldaTzcxZTBMKzJ3a1BVOEkzMHcyYWpLaGJYSzBKbE5MT1Nmc21qV3RS?=
 =?utf-8?B?akZrVG9ySzQycmVqK29FVmlDM09nUXhIc3RsU3pSTXdTcVEzV21sZTcyM0M0?=
 =?utf-8?B?ODFWM0xqYUI0WXlBRzQySEZySVZucm53VDlYMWhsRUZRcjAxYkFWU08wbGV6?=
 =?utf-8?B?NHVUR0FOaTlZVDZrQ05JUGxxbUhwbmRnWlhoOW84aVlQNkhnaG1Ra3NqZmow?=
 =?utf-8?B?WmNsaWEwWWY2dEY0VlVnc2Z1RHpTcG8xTUhLNkFGQm5yb3IxdjdVcXNZVUw5?=
 =?utf-8?B?NDZuMXVCWWtPOFJMbU9OTDRQdk9CYnIxNlZ6THlyamZFNlZDYXNaVkFFV1RO?=
 =?utf-8?B?VUF1ZmVjeThsMFRlUFozR0tRMXF1THdsRVdkazZUR1J0L3RlU3AvcE5uYi9S?=
 =?utf-8?B?bG9HNTRYTjZNVkxaQk5aM1B5eUI2VVRNRHhwdFMrVFc3YVp2aDV5OUZhdTc5?=
 =?utf-8?B?ZUEwZnJzdjJUbVNzam1IcUtNT2JPZHlMVHFoa1FkZjRjUWNNVldOSzR1QVZL?=
 =?utf-8?B?RGFPcUVRNHgwUnQxSmhPUktCa0d0a25XRnFVeWFsRDZuVG9KZGtnblJodHpH?=
 =?utf-8?B?RDdpZmhFVTBiWEhtNkdKNkFPSE15Y2h5b2dmbTJ5U2d0eUtQd053cXVxUVVY?=
 =?utf-8?B?MlZCWEZSZGNrTnU2bDFmMFI1dUNlaExYdEtEMzliKytDNGcvanFSVXV4b0F3?=
 =?utf-8?B?R3dULzJFT1VaeUI4bUhKcS9Rc1RtOXI4N3ZOL2h1VGJOM202V3g2bG9sZkpj?=
 =?utf-8?B?YnhuRHBpNjJNbzd3OS9mMEVEN1ZqMVc4K0RHMExCc1RyL2tTTzVHWTRzM1lJ?=
 =?utf-8?B?VVNnbkVaQWU1bURPcEhkY0RPa3FDUGIzNFArZTJOQXJQMW9QYVFtUUNIdThY?=
 =?utf-8?B?VlVHeVBXdXlnUFVkcjVQQkdZbko2ellxYlNJanV5KzJ0cVk4cG0rMnI5WGtn?=
 =?utf-8?B?Q2t3empENEdRa29ja250OGxsSGdISW5pZ2UrM2JYVzE2LytycjFPaHhjNzB0?=
 =?utf-8?B?N29DV2hiKzI5a3l2OGc4NjUwWnQ4ZEJkV0ZUSnJWWkdXSC9YaGs5ZEVPVlA0?=
 =?utf-8?Q?PXdxBRNSivcptffU9KGDXy8VIuHxAa15gxbjPEQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellPOW9PY2Y3MVl4Y3YyQWFmajExcERaRjQzdEFZM1V1dnJyWWVEUm1kbC96?=
 =?utf-8?B?b01Mem5jb3k5WnhscENjU25MT3NWdGNsTTlocHIwckl1VlFadU1YdERkb1JU?=
 =?utf-8?B?NXlMNlVXeU8vYlJFT3BrV2NtaDUvc0ZtM1hQcEZTTVBUZHZjRlVnemZqM29z?=
 =?utf-8?B?TytUYXh6QTVpUTY1ekR4WkZaT0xxbWlOSEtkUGJDd0oyNW9xWit1TmtNQTNU?=
 =?utf-8?B?SERscVF2VTZmNkRvSkp6NmtZcmk3QmxwSXlPUDArSDQ4N1Q0SW42N2o1Q0kx?=
 =?utf-8?B?elFYVkp3THBpUVNjMjN4bUVFcVFWRHNweG1NZkdWTDQ5Q1JLWHkxdGtkVW1B?=
 =?utf-8?B?eWk5Q3ZiMVlIWWsrTjBSZ09TYTVFUHBmLzZ6NXBBVkVTQlcxemw0ZUV5akpC?=
 =?utf-8?B?QzY1bGVweFFjdGhuRkRQeVhEbDlhZVZlanAxbWFVdVcyK0lqZ3EvWTBYcDdv?=
 =?utf-8?B?Qk5qTzk3aWwvTitjbUJqS0doa2dmYmhVK3l0citLS3RTWW1objhGYVB2d2Zh?=
 =?utf-8?B?bzhQVGx4VGVKWFN5eG1ZdXhQTDNmdVFhVi9aK0FnVm5UeHBFaDFvaSt2K1pw?=
 =?utf-8?B?elZtMHU2ODkvU0x0bS9YclJJRk9SRE9VNitZRlZBNUorbnFxWlA5bG14R0sr?=
 =?utf-8?B?d0NmWUcvV3J4eVQ0eFF0bW5FbE9nb1N6ZTIxRjNOWk9KUzN3SFlYc292bDFV?=
 =?utf-8?B?bkt0eGNqbHQ2ZXorQ21BOHM4bmM0UHpjZ2lpUUMvYlBXOTFXejFTZjJoS1E1?=
 =?utf-8?B?b2xlSXUwNkF2ZmdoeWMvWHgyYVdZSEFJRjVqd3dVUUNHWTRkMElxMlNZM1d0?=
 =?utf-8?B?NmlJNmI4OURwU04waWhYNXB3eEtDeTlqVC9vMEI1ZDJMYXVvSE01TUEyajdU?=
 =?utf-8?B?dy9MVVNPWDRlMXZGaE9lUmVHVTkxSlNnQm9qanZ6Q2FZZW94eHRqU2pvZm5C?=
 =?utf-8?B?bExMV2NQb0FKUkhHUU9MYlhIS2xmd2JwaTd2MUxyWVVKTVFDaGVLUzdlTE8y?=
 =?utf-8?B?NGpNNHBpWGJDL1VyemNnd05JZmova29WUFpnejdyTXJGaXVuczdoVko0c3Qw?=
 =?utf-8?B?OWUyMGswcFBub25IOUNUSnZEVVZlOGVEUG9keHN4VGpnZ1Y4aG5Yd3BhQWQr?=
 =?utf-8?B?T1BPaHphYW0reXRwdmZsTk5id016UjVzOGtlRmtObzZpU0dUNlRoU1hUWHVB?=
 =?utf-8?B?R0RTSEUzTTN3cFVtUWtncUg4TDZFbUZvQkpzOEJwQVlQbE9zaWdJUUU2MjlS?=
 =?utf-8?B?cFo5MTR2TzNjWW1wN1owTUR6allpekdNYmREa0RFb3QyK1QwcFlmRi9JdllS?=
 =?utf-8?B?Uk90N25WRlVQazNERG9mN01pQ2dHaHd2R0RiMkZZOE5xRDBrTkZ5YzlGYVJ0?=
 =?utf-8?B?VkwvanYzNzZFS29BZ2hLNWhLTVJ3WExOMEk5R040YWtlUXNEU1I3YkZsWUVL?=
 =?utf-8?B?VmZiejNDVGJjWldoNm1vQkNjKzJYd1RTb2pEeFNkcHI2THJpTExtUlZNQllz?=
 =?utf-8?B?RWFKdStIOXl2Rm0weFE5UWN1bEdvVE4vdmJjcUVUYkt2VkJEdWVLUHcwYnZG?=
 =?utf-8?B?V05NdnNHUXg3b1Z5S0FCajFJQk85cnJ2Y2U1cENMdzZpUktVaGdIMEk1c0Rm?=
 =?utf-8?B?VjlNNkhESmx6YTRZT1RJSXNKRVh1eDJFTy8xVkw5TG1vRUdvQ2tBUzMzdE9R?=
 =?utf-8?B?emdPdzZzYXZUL2wrc1dORTJPNjNYK1RSTm5sZ3NhdFQ4ODN0TEtidmI0QjMr?=
 =?utf-8?B?ZmVQNVlOM2wvaHRvcXhxc0ozRThWKzhIdXg5R0hHVDJFdTlKTVhFQzhsQk1S?=
 =?utf-8?B?bEkzR3Z5d3JKQkRrb1ZXekJuMVBRdzJpUHhIV0JPTEg2YkFvMUY5UVlvSTI0?=
 =?utf-8?B?dDBUN1BLcVJpVmg0R0IwZ3p4S3JjY3VzT05lQ0wvNEpEQWtFRWlNVWd5cDYv?=
 =?utf-8?B?MmNBWmFhdGhTbE5PYW5ibHhtSWlTWkxhT2ZDUllhNSttUWQvOXVMb0ZIR3FW?=
 =?utf-8?B?SDl5cktWblNIQ0RTVitrdUo1UTJaTUh1KytndU9FRm5RODQxTmJDWFBpQzNZ?=
 =?utf-8?B?M2dqcWVueS9rS3k5c0svZ3FpUVdpUktta0hOVlFqVW9FT1VZVkFLUzFMYks1?=
 =?utf-8?Q?XMWLUoheKYeTuCrKCklcTck6I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca69fd-16f7-4d5e-7a30-08dc8ed19599
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:29:59.1515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxFlpSxruVibbMij/GHX9JiCXdMqFQd1P0JRzYKabYWjRPp5y+KufUlSJFGhSq4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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



On 6/6/24 16:35, Michal Simek wrote:
> zynqmp-mini-nand wasn't aligned with dt binding that's why fix it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-mini-nand.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
> index 5889d436edb8..e08a7840d8e1 100644
> --- a/arch/arm/dts/zynqmp-mini-nand.dts
> +++ b/arch/arm/dts/zynqmp-mini-nand.dts
> @@ -46,8 +46,8 @@
>   			status = "okay";
>   			reg = <0x0 0xff100000 0x1000>;
>   			clock-names = "clk_sys", "clk_flash";
> -			#address-cells = <2>;
> -			#size-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>   			arasan,has-mdma;
>   			num-cs = <2>;
>   			nand@0 {

Applied.
M
