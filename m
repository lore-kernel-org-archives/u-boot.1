Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFC1C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 11:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613DB87C87;
	Wed,  7 Feb 2024 12:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvtJ34iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240CE87C9A; Wed,  7 Feb 2024 12:30:43 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC36D876AE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 12:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXVjgq3XfvxBt+Rc1P3/HJVXVw0CA2JQTBR74zcLe2k4+jsfDX2u1Bro0eZuN9yaHyzeI5mDbgfYuIdeeKahXIQpOeev1vEbZgbihev6+Yv5loj/VYxn5UM6dahkHF1ISWRw3HeM6BnRsl1n6VFQa2zplqOfQE8dzxVIyu/c7HKR6AufOMUtMGT4MmP/5Fy62aiwheGFSw0QZSeZ7nvlzyni7ehNG1ihrWQFBBnW5BN/NqSSseCr+ZxWrlqqerGFPMmpV0Kc9mCgdfUIqqTTR3WawJODHkbVIdHHGvWr8+sJ+8ei7x89+A4o664Y4LlIafrmYX3IJnyCDCUVBI01qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ5W+3Hw81R0do4lpUi3BBDjC8x6KB+RVlaQ82FfGD0=;
 b=ZyVhHST91EMltaHKp6thAUBgTiTQFFfb68cAmyNLpUqYPg/LlBsKkdA3EWspwykCTchhQmPEH3xhPBLG+ov2C25+XTylp4FHrKgyuTLbfDrEBdLAWC2yQkvvGbU8FMY5VT98QcuIxYn5JIRoFfLjKe9qBhzI8G2Dmy7UkGjpTc31bb9f0gcO7fxRUUqyBLoIbxpX+X83GpyU2z52PoSq8mmQF/BxM8RVQPNgtisfz9/mDQtLB/NUWbzzZ9hdhGn4YA9//6vTCJi16js7Rtav/GpwzOmO6TDd8B68DBoxXR8nQzw6FMBsIqPhl9Z7AstPEgiz8ITVafgC+xymeF/7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ5W+3Hw81R0do4lpUi3BBDjC8x6KB+RVlaQ82FfGD0=;
 b=QvtJ34iT3nwzjTfBAyxh4/0PNg+CJopTkzp6LiX9O50Gvhpfv0vr76PSYABUUNsIBMpm1EAiYiU3+Prq4t/DnFT8FOQ6vfBG2Hz4yDyOhmqMFEYsGresxNrG2UoA6wrHTRiPjkxvroXWyEkjWwwmbslM5tpB4OGfa7uel2CqAl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 11:30:36 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 11:30:36 +0000
Message-ID: <d899a443-4e51-490b-be18-7bd1b58efd0e@amd.com>
Date: Wed, 7 Feb 2024 12:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Add the missing function prototype
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240207083328.1673752-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240207083328.1673752-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: edc9ca77-879f-45c1-1a61-08dc27d033f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEZzr+Q4IHMLqn7FuIxgAJ6k5AKXqDBLdVbPEom9wnzBYnYBGsV8uhGqy4vGEwLsxxvtqbrU3/AOeO6ibGtMcrrxDsAMWujqsg+W/BsvQnZNSSksuJDfYLr/eurOygyOGttUh99J19WFvxbKpr0nXaNXmixyKrVUYnyV/feaZegRqKPFjGbSkWWcUn/NnE4SlwVPCSW9Q8fDiJ6isa3YISxjAjcFeCsJFPXYwAK3IlKU7J1bgUVed7LLYBtnW1Mb7Id3sP7zdJnOGTkj7LRYwIHk5leFPR117c6LkyUMAmSbRroQ+Gr3Y7/49QguxTbJ1KTIf3ycBQ+9/YC+qnerzrAuLh2Z73Hij7TIe2h3YTUdLoyytXMJT/fzuJ2e0bB1Vxm0JCYZuem3rdq3muMixlHOGgELVwy4gVtGR0IVzmun3cal2HEqYaEgRtx/sHMAml0YtaSvBPkcrwPwOntQzwTire+izuIwDO7/tWWyfz98C9BxMcz9AfwA+pNjiZRcT2eRuD7wYnMJmb0MLT2X3/9ITdZivLMBPZYS7njp+aNoI0IU9zrUl15d3XghqEL8PxIrAJV8V+sI65DObHrqhWwZ+dCK7NYlvYplvyB+skzcTdw/u/S8piwIm47qaSEfYmX89D2csEYV88jaqPfpTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(4744005)(26005)(83380400001)(2616005)(41300700001)(6666004)(66476007)(2906002)(66946007)(8936002)(8676002)(44832011)(6506007)(31696002)(316002)(5660300002)(66556008)(38100700002)(4326008)(6512007)(478600001)(6486002)(53546011)(86362001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkR2WnZ3VzlBYWhFMWNoU2xDM2hDdnBnL3JWbkxoVUZscUk2bDhpWWh3ZlBh?=
 =?utf-8?B?NEtJaFNaMEdkT1JqUngzQmR0QmR4MW4yMnJsVVh1aCtRbzZTTGFlQ2tCRjhn?=
 =?utf-8?B?SnIvTWRHYkpiSVgzcndid21FVUlpYXZObHI3akgrK0NkczdSYVJBcWlNMUZj?=
 =?utf-8?B?anZ1eHpkSDl5bWUvUGYwWlZEcnlHZHhjNlJMcC9WTUZMVE5pZlpvV0xWbXAx?=
 =?utf-8?B?a0tYYUhqNW96RDBPaW9hWWczUm4zMmhnWWVrSlBkVG1UUnpwck5uQ0ZjQ1Q2?=
 =?utf-8?B?aVFrazFmTlpaMlhkUFBwMTZhUmRJekxQQ0ZmdDBNT1F1ajJMK2NheTQzemlZ?=
 =?utf-8?B?UmNtWmlqalJwZ1l5VEJ2TXJQOFF0bEpNb09KMGNJVHdtTDVvVUErQ3VJWklC?=
 =?utf-8?B?N1JKaGZIbmxGck5FN3liRFExZklZcUdMeTFoUXVxTEVhNnYyRzA3NGMwRzEy?=
 =?utf-8?B?ZVovR0NSTisyYUhraUFUak1hV29QNEdGYkovUndUK2RlZ2tRVGl1djlyczF2?=
 =?utf-8?B?U1VpLzlzckhENEJuT003K1N0RG1EOG02OEpnK2QrbExQN2pXSEJRVDhvK3Np?=
 =?utf-8?B?SFJ6SXdzU1dONXlHcjRiVmRDQXNOWmZOcEpJL01heGFodGYxYTdqUHE4OHlj?=
 =?utf-8?B?ejdCK3NlUWY0Y014Z1pqMUpQcVZrc1VpTW44WUlQKy9FanlNKzgrQ3VQVnJN?=
 =?utf-8?B?OFJON3MvNEpFc0FKMEtRRGRYTEVOVy84YW9SUGpBZDQ3S2I2L1BBd3BwTWV6?=
 =?utf-8?B?KzNnc3pWWHRpbmNEZzVBL2lCbCtSVTk3YWNEWlJTbnF4Wnd3SUwrdklMMEtL?=
 =?utf-8?B?VGFVTFZOUFd3MWowTWpiNlZST0p4QlluM1dkVXE2QURSTjdxdmdRZmdmZUpu?=
 =?utf-8?B?b2J5Q2lnY3pXTU9SQkdBWjlZSTV6dGk4bnI0WmV5amVMb3c0SDN1UHo5a1ZV?=
 =?utf-8?B?UzViYXJLamhZVUszZmNkT0liVmJ5YmZyTUdQMFdQV2VrdldCNm1panRjMS9G?=
 =?utf-8?B?Ny9GOHZrLy9aS1ZTaExoWnZlTjVkVVFOSHBkQ1RETkhZZkt5VDk4UEl4THBH?=
 =?utf-8?B?T21vcU0zQTVUaEttVWVSN0JOVHpYZGhXY2FTcVN3ZkZobmZyU2R1aThTTzl3?=
 =?utf-8?B?VElNVGNsdkt3dUJQbkovdUIvK1h2aEhsRjFuZ0pOZmNGaFF0N0szTVNsNjE0?=
 =?utf-8?B?Tk4vVisydkRCaHdXZWtWYXM0M1FjOHZ5Rm8xWEgzTUtxYXRYdzVnRmNoQytI?=
 =?utf-8?B?QjRWeVhaZEU5QW0zYzFnV3h6Y3VtdTgwSklaK2ZNWGppeldXK3hWTHFIMmVB?=
 =?utf-8?B?NzZQR2VxK0drR0M2RmFuZGFYY2V3YUZvUHJDVVFpWkFMMUxqeW4zU2d1ZjZQ?=
 =?utf-8?B?eUFCVUY4L0EyQU9ibUlBZ3RtVlFKeGlTZ0xSL0xJYmo5bWdsbGdGc0pJZzc0?=
 =?utf-8?B?Y2dGdE9UQVZ0K2grVjVtSUIwYkY4ZzVmSE51VGlOcFJET080L3phZjdKQVV0?=
 =?utf-8?B?VzB4TjJsSHZIb0JRTHFmSGFGRW5CRElEczFCOG0wRmdKeVAwOVZ5NHA5Nlc1?=
 =?utf-8?B?TVVOQ0NTajc2ZnhNc2dwWDMwM3ZHMW92cDhQUWFKNFU0OTZmUXpQTG4vR0J6?=
 =?utf-8?B?bEp3dlhRVWdRb0Nvb09qdlhzSE1EUXFpb3A1MVh4VTZRVFBUTUdkeVdzRmhn?=
 =?utf-8?B?UkYxTHY4Q2JGUitiU0xNaS82c1l5NlNZdjV1Q0Nrbkg0WFptdEpzZG1Pbmtr?=
 =?utf-8?B?azhyUzgyTWZ3cURhNnZZdU1oSmNnSFloYjJCVkZyWnhNS0hCWTF0RHdRWWJO?=
 =?utf-8?B?YmpSbmNicURKNW4vMWdKbGs1eHV3V2F6dHArNWtJWlI2ZXgrcXdJdjNoWUxm?=
 =?utf-8?B?S3d1TGNtckUrQ3FBQlF0dmVkWDdPMVRJMkxYNkRZanJhbjJDaW5YMHc3ZDBJ?=
 =?utf-8?B?eERqeU13WDU0ZDlNdGN0WFlhYzJtdFhzZ0pORVFBSWxyeENTY1lSRFNvdVg1?=
 =?utf-8?B?N2IwWUJQa0xMZTNoVW40YVA0L3ZONWEvc28vRUl3OWdvKzh3ZjZGVEIvMng1?=
 =?utf-8?B?Sjc1L202Wk5SRW9GT2I0SWRVR2NWbm1EOHE5MjBjbFkrV2NyQ2RKMmNPVUxE?=
 =?utf-8?Q?7fv1/NvkImQEg0He7eiuOZspH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc9ca77-879f-45c1-1a61-08dc27d033f5
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 11:30:36.0381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDBMHFJWZM1YSdfhu9bIQmyOnEUggn5TW+dpgRDbU/x4KReXIQI/kHNa0UFtDcxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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



On 2/7/24 09:33, Venkatesh Yadav Abbarapu wrote:
> Add missing prototype to fix the below sparse warning
> warning: no previous prototype for 'spl_spi_get_uboot_offs'
> 	 [-Wmissing-prototypes]
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 9f50090720..ba49eb7be2 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -18,6 +18,7 @@
>   #include <ahci.h>
>   #include <scsi.h>
>   #include <soc.h>
> +#include <spl.h>
>   #include <malloc.h>
>   #include <memalign.h>
>   #include <wdt.h>


good. Please send it to upstream.
M
