Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F013C47073
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 13:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D2C807EC;
	Wed,  3 Jan 2024 14:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OJ37aqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2954286335; Wed,  3 Jan 2024 14:05:12 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88A0807E2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 14:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd3xuOVZdegKC8QHXMi/M2CO1fTBiQT3NP7R2D7V5NIlJh8GLvzBMbSWs4c9IRAQ+V6P2CoazihguaowpvLSdgU3UkgjbT2Sxsn6IXJf+Iik/j52XNeDdTabf1DIfW8pSix/p5LxotKB6zjgWSaP9fWZlFbpf+dVGEGNFc29ohP/urERXYumUD2kCY606jttOniynd3uRS6GqpZVcXL6vl9EayE/LFfm/uAoIsJZvpC4HTO2gcRi1HYet7T7Kn0NW9F4jUTx+asDskNGO7FpWXf3Q7xpOIckFMzNOhrkSyB7GZvOJfVNEWiYNXLGzj3fYFua3z2DcYKJvcx6994l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdlyTo+DxqFXjAr7C08DjyDcAnnLKFKOTUuzL37pYcA=;
 b=EztCkx5+dzx+13QdmUG3Vi6PuLHEVqdX8QdoHmKj0uTaximDb22hukSukYRLdl56Xr8togHvRSAdriMxmCWhYhjrBeAF14esQIwfRrw+HaMJDyGR3RDRZQxdLAFuoivT8ZaTDnm0/SwJ1fmE4yPBZndsXpPlxNiUCIja21eq5ksuhgTFJfYmdS4Aee00ZFww8WN4SPItGHmKdVdjn1+siSgRO8viwxyKaz06i4mwH1cJbB+ny5cZcGtAx9sExVxnQZt44mbRi8Pafz1g6UTPt6c5PR7Z8U5DOB4C6Kf1KpMRfWYWp6Q5UxwmEttEQRwlhtToNjsmDFEz+1SFqIS7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdlyTo+DxqFXjAr7C08DjyDcAnnLKFKOTUuzL37pYcA=;
 b=3OJ37aqo/LglTNGxcU5rOe2xBmSlXJbk1Ecan2ssPYVByRXE8kFp/JQPrMxmHD7a+nAHm/zdSkMI7TimDNmigYzRWov4ZnlJR3v/bK7ntPeD3MSTtyAiB02RdcChi2gEH11VUfibunZqAykBGfO4didrZSEcOx8EJKq9puI4hdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 13:05:06 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 13:05:06 +0000
Message-ID: <cf13a860-d628-4374-82b3-3cc660197b91@amd.com>
Date: Wed, 3 Jan 2024 14:05:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable the NFS command by default
Content-Language: en-US
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com
References: <20240103061258.959110-1-tejas.arvind.bhumkar@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240103061258.959110-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4623c105-558a-4f77-9bef-08dc0c5c9b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8Bwp7xTn7dps32sWCCEsHQb8hGNVqTOi/LYXWE1uAdj4PonNs5PYkbxdpq/A0RN47xKxCQzNB/0MU9Z4uqQBjZJkaS3gbgfUUNHgpQKuwfyUSKkY/qvUx0W0iWrB1NWuvo8ZSikJdxUlzMBs9r9phfzktD/KsxvykUDfZs7HZnXzYKiEGUYMBccg8cu5ruKlr425W9Fh/KdxD6rA5LxzHZtzlnqW4MLYSWNt7Iclr7VCJReoQvdEJtZ9GfyuvEig/EwwcxRQ0lgWP6FcfeLBdYUT2w9JKAqUgiU3Gg1oMxAhHQ6zCqzXdWAp215ZoLwz/4bTDlaomORc1xCpSlGZljYpX8LXGSQDOMETF0K2DLOMBkbo6srAba1QCWQC18YNEpDrfap4b5iC12CblKlbYLA5HZ3/oA1EpFFamNVa3A5rHl6HQUKV1TND0SyfO6n+s5IMEvS8W59djpxTexmO42GGDqMcv/Ty45VD3Hn78sntoSZ5BIJwKMon9XdO4saut2XKJ7kgBLPHAFXxx9L+Hmrz8EsR2jmTKNXVE4/WEeiJcxjQNNESfOefWMvQ2hjS3uBnw5YGGrxbHmzw8heLamAiVtU1nuOe06gcHTYtgQN6nJ4bDt4GC32pMcQYc4JtOX/9mFz6VUr8edfYK630A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(6486002)(4326008)(44832011)(66946007)(316002)(8676002)(8936002)(478600001)(26005)(2616005)(6666004)(41300700001)(5660300002)(2906002)(36756003)(53546011)(38100700002)(31696002)(6512007)(6506007)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9ja09PZzFlSDFvaHRraDY1SXgzUXJpT3cvS2ltYWowUG5STW5HLzQ1bGRk?=
 =?utf-8?B?c3NtUnQ2bVZGYnNkM01oQUw1bXlvZ1REZ0Q2ODhteU9teFd2SnZzRk56eW16?=
 =?utf-8?B?Uk9GVmtQUmNNYlU0SHNpK1Bvd3hOQkRpMmM3U0ZxbS9RVkNzU1k4emZhMWh1?=
 =?utf-8?B?VFQwZC9jL0tkWm93T3E1UVhMclgrR0NsWHVkZEozeTNOb21pYk12QTZKNTJF?=
 =?utf-8?B?NklPNEIyaXl4NERrNk0rYTBoWHNmbmp1dWZrdko1eXU3MjkydGhuSEVWdnV6?=
 =?utf-8?B?bDBhL3pDRExjU3NXMXFiRGZqZmQwSlk4RGJoTmJ0Tm5HUk9EK1djMTJpMUpE?=
 =?utf-8?B?SDkxSUljQ0hvOTRQSnJhZitGUmorOER5bWk3UFlWTjFXZHNIQzh5bjVZZGUv?=
 =?utf-8?B?azB5djkwL2FrdUU1N0JGdmpNQkNtdTMwWGpvbzc3Q09BbWp0TjlCMlJoUXpq?=
 =?utf-8?B?WmN3U2Q2S2RSdEtFODNybE9hQmVKRmlQZlV5TndSeXg5NDdraVRPYW0rWkZU?=
 =?utf-8?B?aytndWVtMnluZlJyMFNQSnVBNmtMV29wR25HRzdBTTNjM0R0RGd5NEJMdEU4?=
 =?utf-8?B?ZWNKZVJrdXh5VFl2bjVWUnJsY2R4blRJK1NpVUVVeUZBa2h5UTNyQkhiaGVx?=
 =?utf-8?B?QTVIYmZZRUJyM3BNVE1lcko1L1Frdk5rTmxjaUVyenhzVGhObEQzeDg3VWZi?=
 =?utf-8?B?KzlLOVgxNlRjN1l4Ty8rQmxmVkxXY01ia1dvRW1IMTZMYmtpMG1XVmJxSXEz?=
 =?utf-8?B?RlduU3JtSkY2dkNTN0dMQmlOMkdTd0txSUx3RkdydTVOMFNEd2hlTDY4OFc0?=
 =?utf-8?B?TStlRVBEYTNxeWxhVG5IS0xOdGdwQVR1L3htSlhLNk5zYWZLUVBkWjNFWGd1?=
 =?utf-8?B?dm9nOFFndTE4TnBIRlZ3ZGVlU0Y1Z3BoYzRCeVJWT2V0bktoY0RRdE93dkdF?=
 =?utf-8?B?UTRPMi93elcxSDFxZ1RMUDViZWRueFowVS9tY2lEQ1YzZWhCTkhMTDhCeEx3?=
 =?utf-8?B?UHh1ajRnQno2MDZleTYwRG8vZlYzNW41cFhDQVZHU2wyWDdDTGFRS21Va1k2?=
 =?utf-8?B?VWtNOEVQcGxHTzM1RFhJLzhleW03OEYxdkFGMzZOdWZpT3hmaEpkZForYVQz?=
 =?utf-8?B?ODZGTjBQMGN4Y1AxbGhqZllEZGxrTmZtY09hZU1Qa2NvQS9rMllRM1lJYko4?=
 =?utf-8?B?ZjkrV1VlUjVvWC9EdE9VWTJoZzU3dTRsVDR6YjJJZEFnZ3JVSkwwS0xHTnhF?=
 =?utf-8?B?ZUMwajZ0SUhCZzlEbkM0dVZMRVhZMU81Wkp5U3RTbSs0em4rNVIwdlgzQUlZ?=
 =?utf-8?B?b1FIYzQ4STB0V096bHh0TkhncS9VMlkvYVgzcTAxN1hKSWo3TmQwVWRiMDJo?=
 =?utf-8?B?VmJUbVhXR2ZabkpBVERMTmQ4NC9XZXFjZmRPQXcva3RRcDd0bVBsOU1sZWZJ?=
 =?utf-8?B?L1FIYzZXZ0p6cFZXaVNqT3JjRWhRcTB5U1BWZFhRU25qTGdxa1phWFVXeC9E?=
 =?utf-8?B?aGY3eVVjVlE3UUl1aFMyQVI5ZHExN2d6L1NlMUdySnpHTjlEejY5YncwWXVB?=
 =?utf-8?B?L1BEaG5XM2FoaFRvWlRvT1FHNERQT2Iyb2ZINXFqOGwxOGhHekJJTWV1cmhF?=
 =?utf-8?B?dXNQQWRpcGhaenJLYkNWakhjaEFvSEh0emNPMHBzc0RreHRVVno4eFY1emxR?=
 =?utf-8?B?bVA5M2FPQkRJSHdlTXdxSGFpMkdGMmkyaXJoeXNDVlZ6MEJHS0s0T1BBSWFh?=
 =?utf-8?B?Q3NFeTl3R0pUNFkzRXBSQ0lFdng3VTVvSnpYL2JUZU1vOU9ncEtYdDJUVVBB?=
 =?utf-8?B?L3JuNHIzRisvb29HVVBXSW1TMHNCbEx5b2lSeE92azJxOS9iVjZaZ0IrS1pY?=
 =?utf-8?B?TVVrRHBvQkk2MytKeHpSeWJLSWZNZlVtVytIb20wY1N5Ujd1bzExQU5IYkd5?=
 =?utf-8?B?Ymt1VjNTZGF2RFRWZjErM1JsTFNNcHF4ZSt0eHlXSTJId1ArSDA1ekNFdURu?=
 =?utf-8?B?aXlpdXFFUHV4RHNxYk03RWFTeWdLcGFuZlgzTTBxRTR2WFFjTTVyWTBDYmNx?=
 =?utf-8?B?WGw1eFgzSS9reVQvL2ZoT01sWThFNUU4MFBhWDFQVitlZ09xSWcxZkp0S01i?=
 =?utf-8?Q?f1fTyhi/d/ZlUCH3d/Ij87nkl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4623c105-558a-4f77-9bef-08dc0c5c9b87
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 13:05:06.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bn4IOAfajk5eKx/6Bz2ZARQZh4+77NizJ/CnYYct/8kE4ebVxCvSodxDbb1UuAOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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



On 1/3/24 07:12, Tejas Bhumkar wrote:
> Enabled the default utilization of the NFS command across all
> Xilinx platforms to facilitate the booting of images through
> the network using the NFS protocol.

you should reference to 10de1257079905ac383e7abf346a04221cafa620 which 
introduced regression and disable NFS

> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>   configs/xilinx_versal_net_virt_defconfig | 2 ++
>   configs/xilinx_versal_virt_defconfig     | 2 ++
>   configs/xilinx_zynq_virt_defconfig       | 2 ++
>   configs/xilinx_zynqmp_virt_defconfig     | 2 ++
>   4 files changed, 8 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 0553ac6b17..3095e402ff 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,6 +46,8 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
> +CONFIG_NFS_TIMEOUT=2000

Did you run savedefconfig? Because 2000 is default value.

M
