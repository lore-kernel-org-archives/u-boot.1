Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420FDC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA30B87C45;
	Tue,  6 Feb 2024 12:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z6+WVmGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE1C87C9E; Tue,  6 Feb 2024 12:34:46 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2233687968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXAKnmsDkiBa8RNKW8gT+du2PXGkQ4WJpvwrIlh7unRNpqDCS4BWfgywPhGDP+bHxC7K3BK4hF7TH2eHe82DMwebW1/hlI7KYd8lloHPM7nI58zqz+MiziXdC2IerEktAQgjGulkGhRVtCExmrvcHNo/lGsvf6ttTVKfKThGiywiigeR+Gs1hpb7G2BVdzs8hkKKiiuJyeev+LH8Y49uDHwiFOJmCXfLfF23LyAy6ylqBQq0SJlEaP+MKlyRVQhiYp8/Ed9eXbLIBVyNpx+Mri0IdZfM3Hn8OM2/6QbF8dfNLSmRhgA6BXs/mAlu5RVB/gk2JF5NVCPHXful5yAEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPWsxWqKevj9yCHZmWzNw31j6ACIT1XRpYhLPnxnv/s=;
 b=Wo1BAnox381bGqF7HuLPE59zEjooTAMZs5pX65xu2ZyPYeviYIm3wNJeCxoBs+tbjEVtJ2Kmoh/XVb26fjk6qv0ykyqxFSlPpjb+J7nkx7aoaWpsSqvE/8OneRoREgoZZokQgazBCBqDEqu+0qiXCQa3BGQNitei4VJCrnq2lao7r6Kjad7emLQJAwy7zhEuokE9zgolFn7O+YGwS81GsT4s7fSo+FiNYFBAVtq2nmiFnzMDtjRqOWvcwMJQRv+dsZVPhWvyGmT3okZWlNaH0TQpY+we1M2MKSvtXe3cJHjMaQBdggfTmD3KSx2T3wTLMOroFQVWYC4Y+liCb0keSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPWsxWqKevj9yCHZmWzNw31j6ACIT1XRpYhLPnxnv/s=;
 b=z6+WVmGEP7QHgfov2HLkabMHMvLFUhcIrNDNk2vWYckuSAmozi/o0iBNj6V7w7CalEW2iqTHEFLgL20sVsVKhHIho7laIu/rzskAezGoYUlAhna+or5xyeYU1mstTwGBuhIABdxCjZY2R5CyHaN0G5G0ZFfy1pf9f+gIAzie2Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 11:34:38 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:34:38 +0000
Message-ID: <aec027fd-074a-4e99-b127-14bafd294c2c@amd.com>
Date: Tue, 6 Feb 2024 12:34:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal_net: Enable CONFIG_LTO for mini qspi/ospi
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240126081139.3210211-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240126081139.3210211-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e44b9-2f99-4978-3ed8-08dc270799cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVGad7k/VE8nXwjuAOWmPFjNk0tOZCDsbDNhfjP7fvPyyF5BGFdhqliU8YfJ8LnVWCJZv0pKPCGoXPiuApZS0eroBiSuwWrbaPE+NtoZ39v+NlZM/3iLUA5GxG7gzRJ81MpOCSyszeZbUDLlK/XOXLSL1rreLq6mZ43umIhLGAHp3I515YFehWUHorn65KPCqAwW343AWiqnm6AJHDEmq+bbbot+2F6dUee7KQIbmNdinKKsz4/i/D4dAbwxwiWaRl+YrQRywPMALHb4CL0G5FZkZ+OyTjMA+0OSBw/Prc3r1kLpf+1vtwbBfdChZm+/+unr//9AGl+iyjd99SmCbgfZiXkocQTgEhc2gFEGmpstiyuLowV5h2tkIu1X/3mu2KwZDL3lIyd9G4C1LcxyMnibyZ91q/YHGwH2lC86cYaNQeTw+r/+J3yvCr1FbkC2qw9Q3Eq9aIhAznbUIDwq5fFmVMCgpaRxIXUwd3SuxRyzAKhWs9p6+k2Cj1bA0q6Q81QST1OpWoYkk7kGaz3iZzNku5HtLkS1rwfoOou5vC5JBNZrF/eTgXX8uhgJj8yt+C9lPDE8j2N1+bKcbl02BGOT0UGMbCAGwXSllOZhmmA5mv1GxZYrI/E5AM7dexFKK8jto2SXRmLOLf9M+9xCog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(44832011)(8676002)(5660300002)(66476007)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(6512007)(6666004)(31696002)(478600001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhmeDdQYk9NYmRzN3lsclJFMEZTVXZYek4yeXhiVGtNd3R2NXh3OHFuS2Zy?=
 =?utf-8?B?WUcxWGJ0N2dibXVYZXMrMDVZOVMyWm9oM0UxaW96T1NxUEREZVJycWp6RFRF?=
 =?utf-8?B?b2NiMUpueFhoeDlEM3MrZHlRUzBnckM4NkxQdGdZSjJ2MDFZbHZJTDNlVldy?=
 =?utf-8?B?R3Q3VHkzR2xWMWlJdDFzaDBRaUJSbEJOV25EZFJKbTVFSGtWZi9TTEI5ZEZx?=
 =?utf-8?B?VGhLN05JYVdUaGxxL0Rqa2lkNkQrRnY5RG5vOUZNQ05Sd1pWWG9SUVdkUERH?=
 =?utf-8?B?dG8veVRKWVkra0Y3bFp2QUpkOXpaVzA0R0hIVWUzSEVHSlVtRmtYcHRSM3Bt?=
 =?utf-8?B?ZXVpdFFHR1Rkb2N2UjNxcGVEYWlVTkpRRkh1MkFLTFlEb3dIMUlxdm54aERN?=
 =?utf-8?B?Y2dMVFJMc1RtOEpDRUZxemJyd29BVjUzM01ROGJGdkR1ZHVDbHIzb1lZVkto?=
 =?utf-8?B?M3NJU3BZMmhzcUdxaS9TTkFtc3JTL0FCU2ZvS1lOY21Bd0JhK1VRaEJrV1dK?=
 =?utf-8?B?K2R6YU1IdlZiUEg3MU9qOTdPcStQVWo5VlRObkZTNzFVWHd4Q2o1MEhMcFBK?=
 =?utf-8?B?ZkVLYW5rRzZFcDZkSzB3N1RPcUhId0wxaDVNZDJ5bUp5a3UvR2Qwd1ExaWpH?=
 =?utf-8?B?aHN3MXhrdzVQMFVVRXZDU000V0tpKzF0TmcwaGJIVlpiTnFKemMxTE9jMDRV?=
 =?utf-8?B?S2dpY0ZlM3F1MUhhVXNFSEZrVFR1RmRRZnFMNS93aExMeXQyTjJWNGRPbkdB?=
 =?utf-8?B?SjgyaXdoMGd0RzdvZ2hwTTB1dXpLWHJ4NzQwc01yRjFkS3llQWR6bXdzOVdX?=
 =?utf-8?B?emliRXNDYlBiNzAzUmZwSERGc2Zod3c4R1FYK3B3ekdiVC9jWENJbVRDR1g4?=
 =?utf-8?B?K1VlVlluNlErNkxBamZtRVJHRmt6SjRDK2gyTEEwbmJhTHd2QVBEVXh3ZXJT?=
 =?utf-8?B?WVBIWlJCdTZYVU1pdGcrNmF2Q0N2U0VzNlJKMWJlVGZKSWZhd3NWUDJZVGRY?=
 =?utf-8?B?SUN5clJvNDRDZTZEcEtWSDVCWFQwNGRubDlFZW9MaVFNVmVBNkdpZFY2OWc1?=
 =?utf-8?B?VStudE03VmttajcxcWhFblZKTmsrUDRneFg1cEJFSnFVTVlabzVGMUFxK1p0?=
 =?utf-8?B?ZG1nV01lSyttTHhZNVAveGZXRUp4K1BvRlB5c0l0eFNNK21scVBaR0RoSTYz?=
 =?utf-8?B?UGZEaHJqMmI1bkJyOUY0alZieE5SOGtVL1JxdWNJamdWOXBQdzRQMFZDaDV6?=
 =?utf-8?B?b0NrTUVObFFxaW1aWFJBMzhGZk5idU1QTC9BNnFUSkVZajVTWGN0Q1lYUGdC?=
 =?utf-8?B?Z0g1RDJJUC94b1ZqVCt5cEFSZTd4dEF6dG5vUEdWSFZuYURqcWhza0RGTjlV?=
 =?utf-8?B?M2l3ZFI1RVEzSVVLbC9heVo4SkpNbTdsZHBWVDlzb2xONk5XRU53aW1zcmp5?=
 =?utf-8?B?SUxKQXkxT1ZGS0tna3ZDai9wMzZLaUJYeTFtcWRWYVM4T1Vyd20yWU15WndC?=
 =?utf-8?B?eWxrejdoVGEzbzBweXlybDFWZXNzRGRNOC9wRVpmU2JoZjBpUFBHYmQxM3Za?=
 =?utf-8?B?MG9CdGZCNXlFNFZ5ZVp0REx4R0hGMlBOUUxNM01JeHoxSW01ZENySGM5SVVR?=
 =?utf-8?B?TmpFaEZ2Y3lKKzA5TU55VHQvZUxUbFF0MzA2Rm1QY21JVDRFc0puczQ5S044?=
 =?utf-8?B?NTh3Z2ZVQWJYbTU0YWxMcVc2ZTZiQWVYTzBvNEk3ci96ZEREL1BXeTN5TkRQ?=
 =?utf-8?B?eS8zZ3g0YklHdXArUDh4RzVzNUQzNFBXM0lvS2FVcm1EbUZaTFd5UWtRQWda?=
 =?utf-8?B?elFHZW9VZ1AzRk0yWk9taDB6T081RTJwWHRrMUZBb1k2Z2kva0E2MVYwVEgy?=
 =?utf-8?B?clA1Rkh6WHVYOE1kMXFRWHJYNThiU29SWElWSjV2Q3pRUmQwTEdjbHpsNVpa?=
 =?utf-8?B?R3JmbmZIUmp0REkvbHdjMjZGc0pzTjNGak80QmZ0WGliT21ZZ28waWtVZnMy?=
 =?utf-8?B?SkI5OHdyTFZxTVdPcHJaTXhJbHJxV3ZLMjdaZ3dQd0xuUkZnaTdKREttcXZP?=
 =?utf-8?B?dW9KSFdwa1FGUWFZa250OHNWVGZ2OGRoa1kxd1dqelhBY0ZjWU1mekNrUGJm?=
 =?utf-8?Q?MPuFv7fIEVmVD43k1v30CYISw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e44b9-2f99-4978-3ed8-08dc270799cf
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:34:38.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23WmGvmpjEiGBlz1csGIV3gQVtaFfD7y24bZnTj8YKZCppRucDif4R63rPPMcwoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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



On 1/26/24 09:11, Venkatesh Yadav Abbarapu wrote:
> Adding a tiny bit more code for mini u-boot leads to a OCM
> image overflow. Fix this by enabling LTO for this board, so that such
> changes still can be made to the common U-Boot code.
> 
> Enable building mini u-boot image with LTO, which results in about 8KB
> reduction in size.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_net_mini_ospi_defconfig | 1 +
>   configs/xilinx_versal_net_mini_qspi_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
> index 5f42243d22..d78c9f8059 100644
> --- a/configs/xilinx_versal_net_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_net_mini_ospi_defconfig
> @@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-ospi-single"
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> +CONFIG_LTO=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_AUTOBOOT is not set
> diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
> index 4fa83faa40..b0567f857a 100644
> --- a/configs/xilinx_versal_net_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_net_mini_qspi_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-qspi-single"
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> +CONFIG_LTO=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_AUTOBOOT is not set

Applied.
M
