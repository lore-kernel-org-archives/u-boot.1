Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7575D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F578857C;
	Fri, 25 Oct 2024 14:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EV6K0Zsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E0788FD5; Fri, 25 Oct 2024 14:32:40 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E83782BA7
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjEr8hb+8SzNKvD2kbNZ3SLmMqvQqxgqzreXWd7BYByKUyY1rWrGJ2puRFQojW/tIc+VyuuVsDvkFc72i4D44lNqdMHMos9InrqBXEwXK48r8uWYExN4VKzgdRXUDriKOYYiIv5rsUUJM5fDq668azMBhovvsykUhyr+vfQkDGihhKjAYy9+V03FtlprcKTgZBLFhw1iSdt6Y0mRRETgLtVGXZTL+dfDreZvehYS8Elhnn4Ushyhh3vyn/jTUfv6prt2wuRUyxZClgMzoS98QjUOELCll1zwVNW3dUSBRBQnTk5xweuGDeZil2yimdvgl9qcL+Ywm3+aTgDIrmSTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLsG2tJpV/aSupqN1I4mdBST4+eodO1oT3TI5ws9xQc=;
 b=M8QL+4XyD2WAJNrFTXnyC/LonoEZlhmB7uGp9EzScNOQaHc3wZQgEEizMbxzVd7rfxrHcwFCl+2XsTfTDkpEkNOkHRLwggxvyyl64Ue5kMwF8VjIRRxPP6cOPgtu+xHbvu4SkIHDGuThCdiQtvokIPF0MRqYwkOxbFy/hKUi0Q4B24u2O8OY12DJCcLk/ftIUZKLqja8Z2oso9qyezcciTEP0v+zQ9mt/6oWXsUS9u+5x8BdBRUEr/SxH+yGMM8jnSckJBswa6LFQ140vBhud1Uc9bSJR8+G8H93+mz8AP6gw22h2EfmkyDnAlcHTR7ET9LyuDvSM5dPvfQ/Y6GfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLsG2tJpV/aSupqN1I4mdBST4+eodO1oT3TI5ws9xQc=;
 b=EV6K0ZscSMajf4mT0YHb6Zhs+JyQ6Uf3CYRSnmbQ/o+jzBXNuGntvi3n6HZggH2xWnysk2QAUh2jGa10g5rN3vt84SQMXcix5yILtLTFjPRePynUIyNVeJ9z5s/VsUhQGpDL14COiuxHkcET5nN5pg3YszmRmatdcz3CfuVr7Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:32:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:32:32 +0000
Message-ID: <b60e08e2-a644-4b79-b753-54c10f7d2cba@amd.com>
Date: Fri, 25 Oct 2024 14:32:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: use get_mem_top() to compute ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: love.kumar@amd.com, Tom Rini <trini@konsulko.com>
References: <20241025121547.181633-1-sughosh.ganu@linaro.org>
 <20241025121547.181633-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241025121547.181633-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6660e820-8b33-4ceb-c594-08dcf4f118e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDhiZitrczc5TVVpcUxZZHRvZERqSVJNSGptT2E1VlAxMWdvMyt5R0dzdE1D?=
 =?utf-8?B?R2dIcVFjYkhrTk9zY2M5L0REb0JybzgrUEJ4U0JKN1NmTnBxV24wVzZ4Tm1k?=
 =?utf-8?B?VW9QWlRIbTdTTEZnay9salRRYlRTc0dkK05uOGRMNzJ3dU9IUVdCd1Y3UlRY?=
 =?utf-8?B?RVdRcGo3bnNtRmVhQU9yZm9HcjE5K1hWYW9JaG9IOGI0UmhIL2svcjFpcUVT?=
 =?utf-8?B?VEJMbURpRGJSczl3WDA5ZEFzRVV2dDIreHp1dkk0MlZEbEhpU3F6Y1pJVVhn?=
 =?utf-8?B?dHNSeW8vOHFWV2xubUxacjdvWG1LVjZuK3hSVi9BbDloeDBGbWh5YVdmWXVh?=
 =?utf-8?B?aEpBNXpWeEhLWFJnamNtWnpXa0dMQThDRDlyd0JiQkl1cXVtQzFwRTlUUm9W?=
 =?utf-8?B?ZEhGcEc4UnQ0eVFRcWh0RDZER3g2TC92elJnSGtIcHoxcGovaG5jMHdRM0VK?=
 =?utf-8?B?NzRMTGZ5QjY0VEN1OU8zV1E2bGxCUUJKTTV1cXNXYmpGbGJBbUk4RlpPSFpq?=
 =?utf-8?B?VDNpbXc5MnpJMEh5SFp1ZjRlWURDakplVjErWnJ6QzJTbmZqczREUFcwQnpS?=
 =?utf-8?B?cjZyWFJjekNvTEwxdStlYjRGZmQyaVJ5WmNNUUNFb2hrSTVlS0lkWVVJZ0xs?=
 =?utf-8?B?d29VNFVtb2VMdTFxRFJRbEU2MHV2N1h6UTdmTjlaRkVKTTdXYjI1RHA2ZEdx?=
 =?utf-8?B?a1BQeU9hdFdUVkRWN1FnbzJFMDVGUTFrTzFFdk0wd3NmRXp1NUxtWm9KbE00?=
 =?utf-8?B?UGV3S2RFdVg1dHEwaE5FMklrdnI3YkJQcGFYUE8vMkY2SUUxQ0h1ZHc0bkVv?=
 =?utf-8?B?dVpZTDROT256d3p0NHlGUU15eVUrVmtBZFc4MlMrek5oemZzWUtRay9hMkJF?=
 =?utf-8?B?MFJHektPVFU5enJJMmMxenJrMGhyd2g1d051SmxnTUV5TVo5NXNoRFpMSE9X?=
 =?utf-8?B?UE9iRTMvOXlDQnRZRWVaK3c3d1RoeGZaSlVVRE1sc2hNZHN3WWNBd3RYaTl3?=
 =?utf-8?B?Y0F5Nkg1ZzdmdmdmYi94RzBVR2hibUlzeXQ4R213SnZJY2dDNllTc003bVQ3?=
 =?utf-8?B?UkUxRU5HaUFaOFgySTZ3WVBkbmlUZHNWQlBONG5uSUJ4MkJBT2tOaEUwejUz?=
 =?utf-8?B?amtMQ0lUV3JVaXhsMDl2NGpBUlY2TnlsanpvYnRzVjNrenFsL0lCSXJMNEhq?=
 =?utf-8?B?N245N2l2RGhBdmVEcGJvbUpYZHlPWGNkNjZhdEJRSWlOQ2xhRnV5VHM4L1NE?=
 =?utf-8?B?M3lpN2d3Ti9KQU1PNDYvVVBNUkI4S0pnSUhyUWJEM0E0K0hKUUxCWFNjNHpC?=
 =?utf-8?B?azFIOWtzWG5SVUNBbHRjdVUzUitSM0F3UnhtcVJkelc2MmtkeEJwMDNLU1Vv?=
 =?utf-8?B?aWRVV3U0YjJMTmYwV05GUUtjOUxIVXA1blpVQXNOTTFkNE1BZnh5ZEppZWYv?=
 =?utf-8?B?U3dyUS83bm9sTWdhY0duQ01OL001aFBmNExIeGwrc2VRcS9QQ0lCMHBRUnJn?=
 =?utf-8?B?eW1NR2djTE80Y0NRV0s5QlgxcWd6L0FQY0dPeXRhQTlqRzlzbEUxeWRjMkV4?=
 =?utf-8?B?b1ZjVFhYcFF4TFZNRUVJc2NSVVdPV3hWTTk1dENnMWE0WlMvOHVwQm5ML1Nx?=
 =?utf-8?B?SEJXVURTUGp1SVNZVVNPM2FxNWl0TVdBZHo2SmFoK24rK2hTSTY4TVN3bURt?=
 =?utf-8?B?bGtiYWlMM2srMmExQjZLMTM2SnRrZTRVN0VWK2Z2QjJVTDhFaGVDSUJLaDRP?=
 =?utf-8?Q?VG1R7A9n1plbij4snkPreDDI8T8hyu7d5jWrzaP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm81NG9vRVlSbnRXM25aeDcvb25DN3ZFUWVCNE1zVm4xMFZXeWtQeXFBZmth?=
 =?utf-8?B?cndPSW1aYW9KS3pObFhjclpYdVRxdG01dk40dXFRTzJCWHFzUDRDU29uMzVp?=
 =?utf-8?B?Y1IvZW9JcThOS0RkSXFvWmRaM2xmR0xsanQxUkJPRTdLNGx4YytSaWVRS21j?=
 =?utf-8?B?c2FZb003OUlWc0JMR2I3a1hRK2dlcmdwRlJDcVYzcmdMQVpwNGJVVjZQNS94?=
 =?utf-8?B?Nmo5WkJXbDFSL0FIZXExMkIyNFlDcTA4QjNaQS9MaFJzdGRRZi8wbVFQMUZo?=
 =?utf-8?B?Y1BmSmhhS1FkRklOaWZPVEZVYnhjd2FJOUd5RmlGaUFhK0pBSU9ZbmVzanRP?=
 =?utf-8?B?Qm9lTEhWN2hFcXd2Zm1YMDB3bTVjcVo2a1lNRWRQeUh4SldPUDZHbXBQQ2RK?=
 =?utf-8?B?TDdHTDlOOUwrRVZFdzRDSDJvZExNVGQreFRYam9lcFVvd0g0T1ZOOGd4Mko2?=
 =?utf-8?B?QmpNdWVyU3BCaUFEOGRERHc5QlFPbDJPWEs3eEZHYXdZVVpSR0NDSXlzVFJz?=
 =?utf-8?B?Qi8rbC9oczRLVkRrTHM0OHFGOUM2aGF2ODlFUmYxcThQMkIyRm5mWHRUZWpE?=
 =?utf-8?B?MXRIZDNZUFVGbFVOZU14K0w2S0FEU0lhMHJrRlBDQTUyZXpOZmxHZUduSFc0?=
 =?utf-8?B?anU5b2Z1cHZPT1M1NzkvQzJpcENVbG5PVzJ3RU0ybWRGaUtQNXNjQzk2KzFD?=
 =?utf-8?B?RWVVdE9SWDJBblowcGZVRE1keGV2L2p2QTBvOFF0VndvVzBFVnR5bmo2dnBo?=
 =?utf-8?B?UFgzSzgya2ZIZVJUS084VlFVN2pBVllvV0U5QVRtNXBKdFhLQTBFUnJDaCtK?=
 =?utf-8?B?WStBQVdjK2RtQ0E5Y2tTTC9YUnN0RTdyNjJQejN5TCtzbUtFQjVoMkVPYmVK?=
 =?utf-8?B?bzc3NWhsZnFkSWdoRTQ1WERxcllCRFRYdzlaa2lzcFJGSFQ2SEkrTVNDcWI2?=
 =?utf-8?B?WUI3c3Z0azVWNGV4WUc0TkNkVW1Rd1FGUzRtODhkYXpKSkovUk9iRWlvMnhF?=
 =?utf-8?B?OWxLY0FxQndrT2xVdUFMdHA0N28vVzAvL0VudCtMVlZkTENueXdrVkg0Qll6?=
 =?utf-8?B?NWVra1lHTlcrRkdZU1FqT1k2NTEzam9iZkxOTU5IR2oxZWJibHRGOGsrWndV?=
 =?utf-8?B?V3orZmlub0tscHFpZnJ1Uk5KNENGYnZlU0YyQWhXMno4OWJsbFMxNHV4Rmhv?=
 =?utf-8?B?UWRCS1FJSENBd1Z4MEU3NXZlVFF0OElUS3dVZXA2YnF4TVdLWHA0bUdldm9U?=
 =?utf-8?B?VjYyT0lSUHNkeE1FalE1dGh1QktaVTJTNU45d2U4NCttZWtXZUlxbXNDdUJN?=
 =?utf-8?B?Z2VMKzV0WEFyQ0RXdFVqY0c3UC9renJtdVRUY3pTelZ1MWtmUWZyRnVIMklW?=
 =?utf-8?B?NmFwWnN3bXZPU3dpcjRCQ2pibmYzR1lUTHFnQ1NqNlRab1pXd3FpOS83R2N2?=
 =?utf-8?B?UGtKcCtHTnZzYmkvNndka1plRWlPMWVBZlZQZ2tOTkZvWFhDOHpjZ0ZZQUlX?=
 =?utf-8?B?N2VCZHI5N2JWdlR6elM5YzZrTkNDOWJMSFkyaGpsOSs3aEU3RGZVVm1DdWFI?=
 =?utf-8?B?ekdwY1B0OUVsbGZ4TklZUFk2dTVQUk1CU2hXdU1hQ2REck5GRTZGUXRjd0c4?=
 =?utf-8?B?d0plT0J5L0lhcHd0YjJUc3BiZzM3NFdLd21vZUVtNzFOcmYrd0Q2VmhnQ25W?=
 =?utf-8?B?TjZjaXZudGJ1L2pBcy9JUDhBSW9jR3dpTjRiRUhSaFB1QzBmRTc3VndVN1Z4?=
 =?utf-8?B?akF2NVp5TFl5VVNNT3djdFl3d3ZvcUFDaGp6VGdQbTkwNmNOM2xqdXlTMksz?=
 =?utf-8?B?WDRvd2lGenhzdjdEc25weEVJNGhlamY4ZUVTOXNwY0NtbVJrVnA0MSt4bjN4?=
 =?utf-8?B?UWQwN2RweURNbGtZR3NHbU9jZEJ3bmVvVzBHcUxsa1lsaWdENkx5TmVkYlE0?=
 =?utf-8?B?cVNtN3RVNlM2NGZaUDM5U3J5Z3IvQWo4d0l3SlZVZlhtb2VJRkY1U0JNUDhR?=
 =?utf-8?B?RlVHK0tiYVpDQnN0ci9Kc1JXQm80VEtyUXBET0EwcEhDR1JYKzNWVkQwdy9q?=
 =?utf-8?B?V0drMDRiZUNjVEd3VjNJNWU4VS9sdDVuOXhhRGszWmQ4TTNaN29Wenp0QXlZ?=
 =?utf-8?Q?y8GG3NI4cTe7FFXKzO6MIXtwo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6660e820-8b33-4ceb-c594-08dcf4f118e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:32:32.4091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VtGFmvbb6y43cvNmzsD50ncdkgUv0l0LhTXGwNSw2ztmIKbVkWfUysE7iZKOeBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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



On 10/25/24 14:15, Sughosh Ganu wrote:
> Use the get_mem_top function to compute the value of ram_top. This was
> earlier done through LMB API's, which are no longer available till
> after relocation. Use get_mem_top() instead to compute the ram_top
> value.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   board/xilinx/common/board.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 38dd80533fa..e14ed2cff00 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -19,6 +19,7 @@
>   #include <i2c.h>
>   #include <linux/sizes.h>
>   #include <malloc.h>
> +#include <memtop.h>
>   #include <mtd_node.h>
>   #include "board.h"
>   #include <dm.h>
> @@ -676,3 +677,27 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	return 0;
>   }
>   #endif
> +
> +#ifndef MMU_SECTION_SIZE
> +#define MMU_SECTION_SIZE        (1 * 1024 * 1024)
> +#endif
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	phys_size_t size;
> +	phys_addr_t reg;
> +
> +	if (!total_size)
> +		return gd->ram_top;
> +
> +	if (!IS_ALIGNED((ulong)gd->fdt_blob, 0x8))
> +		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
> +
> +	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
> +	reg = get_mem_top(gd->ram_base, gd->ram_size, size,
> +			  (void *)gd->fdt_blob);
> +	if (!reg)
> +		reg = gd->ram_top - size;
> +
> +	return reg + size;
> +}

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
