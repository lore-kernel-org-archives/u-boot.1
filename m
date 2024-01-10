Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB04EC47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1818E85E44;
	Wed, 10 Jan 2024 10:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8ldX2gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD20A87732; Wed, 10 Jan 2024 10:07:14 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB09807EC
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De/TWZhcnXwVq8Nx+DLi05Mfq10faduxAScQOigh5J/oxtQpclhee/kp9ioTRQ6L+cT4sBxvAyGLF1VfyNmTJ4fkWoYyX8YTecdMZcE7fYdPIlv9pXhp3bSoW3fdwLFoSAXNJ607KyOJPzWrg04XL/CjJU3UqogZltS49IKp/wVkDa1oxylmkotCi+pNcE2bXFyxqU4BuesIyVc1bm/V5zAkG0lKd//09hSHznn+JTB4h4NDzR4M6TWn17xpATSYLl2KBBwO+MtXf9/EGde9ubkdY/buNtIWz8K2zyGmdgV5DArLXd54QHcJ1FJuGL/lOKmh24qEHZdIoMepxoA7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoYfs8WczO76xzhlZPzxTqXq1qfrk5WRNOunjaGpNgg=;
 b=bvkTvqUiBAzHvAoweml23oXmbSUcbXunidVlr7jNM13qG5mHBVSdm8bLxdBjz5Q9TR4PUveXWsP325T+R7ch1nnP0a6bbI/+FyfureztTHEF/52rY2Gp/ijT12roCI4DNf1LOFSgpZ2+lg4jGh5Kr5MxKJlTTJdbqoEGi4ga4Ba2afRYK5/24ETh62ng+8yEadGEjNDgFWmGcwKMWlkVnDuDpcaeGl2GBQKMhnB4oKPy1yICfuFqu4jD90r8OFKoaixrsvQvX5IVo+iutP3WUBi6AGBZjM139lm+M5Hcso1yb++6XZwYNieTpDfM0kU1AvyK9zJMYgejBRviRHGF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoYfs8WczO76xzhlZPzxTqXq1qfrk5WRNOunjaGpNgg=;
 b=f8ldX2gw+nyQNfiUIm38b5+aFvohcWQ5wpMgfDH4zplR2NN0guCfUBZUZIiMtM0uRNwfQ4ZPmpQRW87R0DK7KrWg0U6v13HGdWEBRY4smRlfgZnjLzaCJrXAtr8b34VSkW2dXu6PjTUlTG4Zf/Pig2v+xBm8zjOrn9bAwXqjBMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 09:07:03 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:07:03 +0000
Message-ID: <8cb2b0d2-675e-499d-a4bf-493110d3b30c@amd.com>
Date: Wed, 10 Jan 2024 10:06:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tools: zynqmpimage: show info on partition 0
Content-Language: en-US
To: Brandon Maier <brandon.maier@collins.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240104185258.39465-1-brandon.maier@collins.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104185258.39465-1-brandon.maier@collins.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:803:118::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: d3849a34-6a78-4078-77c5-08dc11bb82c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZtHEnM96RbKOlB70MkHdf+GJilf5NmSJwfY0G9LX14058U3LRLAPkDpKSbNKsDgcAeAsYvEcWvIfZ2EAXYMYKLRqLoKLwBUWzJEyP6LUbKy70P4uYAxOq67fRwMYL6qJS16ENyzGcXYhsmb0qeNo/wkhq8hwlnFWryt7hFLBNoKK/sGrwp/ixm6UG3jqxKHcEkoy+u31lCWP/GvsNNrEGh5PbP5B4F+ofvfhFzTmcFKCY2r8bmpJpMSBkkYU3bLMRTsf0kLtf3uzNZAHnLaGXIR77hFwslZQ6XDU/11eC/9khqKFRn+3TvnRHkXGSW3gdhF6FFUZhM9z78R/S2C8t2OWuPk7FnUtYfsi5cmKT9PNhXhm8kX5xwOZmQcOUE0y26zA669gAOnbDryFr8TMwKLNGYDnAgdzShdhM0aK/aB7esJT5PYR9Wx2jGRrZwNUbRQTInDw0gqcRTdAptUqpQQIMvHAk6tkhH5BPvhEQ1ArV754AUO5p/HKiv8hX1nTw79J2icTFgiCIs7jhp/yg+uUHZJzr1Yl1YndALqs6Yv+AMml+NceIx2D+MipUCnFaCxInOh/f39o9KMaXqoAtZTngeNIsKthkWTzqCHJs2HagOboleiuCSTp5KvcqmnIyuJ/WKDtf8b+/63iJqSSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(38100700002)(44832011)(8936002)(8676002)(4326008)(41300700001)(36756003)(31696002)(86362001)(83380400001)(478600001)(6486002)(53546011)(2616005)(6666004)(6512007)(6506007)(26005)(66476007)(316002)(66556008)(66946007)(110136005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitFN211QmJpcE1SeHdnTFR1WUdQMThseTNVRUcvYmQrK3pSNnloakpXMUkw?=
 =?utf-8?B?UndGY3ZVa2RwSkJqSVV6ZXM5ZXBHdkNYT0IraHZBVkdMMXh3R0ZGcDFxMUho?=
 =?utf-8?B?YlJZbW9BNmc0OUR5R0lNeSt2cjZWVTkwRU1XNzdhOUh0RFByUHM2VVh6dFJH?=
 =?utf-8?B?TVVFZHI1Y3QraURVUktGUE1TanFzN2VNbFdmQVBVa2ZEV0Ezc2p0TVZTeHQ2?=
 =?utf-8?B?bnVQYUZmdDVmWFJNdUg5anBPaWg4Qy9YV1FaVDF2YlFyUUthZXBUUzFmbm1G?=
 =?utf-8?B?ODlWVU0xWVFuZDJoNXZydWk2UEdNcXBxY3lIaVAzL0p4RUsreDBEKzNKdEFF?=
 =?utf-8?B?cFhhcWUrTnYzOTlmRVluSHd2SmQ5MkF1SDNjcFVxVytva3RPeE4wdy80Ukpz?=
 =?utf-8?B?VXpsdlNmYUx0Mm5odTVsNkF0Z3lnbzRtakovSjlTaW80N2E3djJUUWhocU4v?=
 =?utf-8?B?QVQ5SVBVNDBWb1UzN3ZSRm9YVkVWM2pJRjcxeXMxZWJwRWFPaEVRYTdqeEpK?=
 =?utf-8?B?U2NBVXRQdzZpQW1IQzJBenQ0L3NkZDRjRUVzSmQrL2YxQ3dJWi80L01TSStw?=
 =?utf-8?B?MXZ4U3JRMGh1QkdiL0Jza0tEZlVCRlV3MHVFSWJwME5YMWQ5Ni9sQmRJbUI5?=
 =?utf-8?B?UkdIaTdxeXZtZkRKTUkycUFKcGpWa0ExWk5YdkcrRDR5V01RWlk5NGdGNXFM?=
 =?utf-8?B?Qy9IZ2xaS1IvaUNPMXA0d0RZamk4bHVDS2pBMUNmUmRrRHNaZG5TS0lDK1dY?=
 =?utf-8?B?ZkJoTHNoLzNzalR5aVVjOWRWTlVLNmhqU05ZWkZVb0hFZktNQ2ttQzM4WVY3?=
 =?utf-8?B?TGVBeThhV1JleEN3LzA1SUpWenI2TE5UOGZObnZCTHZOSFFha1h2Y2VRRU5O?=
 =?utf-8?B?ZTlFeTRzWjZISWlWSy81a3RhMHZueXZLZS9GWWFWRWoxVElMN3FYUVk4aE1B?=
 =?utf-8?B?b1JYZzBhamUrT3N1aGtZcmkwMUhYRmZkQVRaQ0pDZWZ0WGlaeDFWREtlaXA4?=
 =?utf-8?B?L3pORmtmV2FiOUJlREY5WEFLc1RpZmdiNHBpTW1JWlVzcmMwMlBXMmk5bGow?=
 =?utf-8?B?SHVONnBxZHh0ZTZXaWpOQU0vSDlhWFVpUHZaemJpT0tjUEVra0RONEQ3MytJ?=
 =?utf-8?B?ajB6WnhGKzBQVi9nRjNEK3dnRVY5SHZEaGYrY250N3JnYWlPYzVzWnJpQjVv?=
 =?utf-8?B?VHMveldnanR6eFI2WXVHZFRPeHI2U2JyY05HcWNQMEhxNEZlYkp1Mlc2aUdP?=
 =?utf-8?B?Z3lJVnBRS2xrL3ZmYmZjY2VPcGVGM1RLMDFvMERnaEFacytGV1VkY1pXUW9j?=
 =?utf-8?B?NjBNMlYyb05kbGdJN3ZSeDArTkhQRjZsL1p5eUltK1czakZlbktJMllNTVFZ?=
 =?utf-8?B?Y2pvbWtXRFpnQ3Njd0hrc0wxdmhsZXRoR3h5M3FETk9GNS9aMHNzMllMWjFO?=
 =?utf-8?B?ZXVKRSs4cjl0dFUwRWRvQkt6VkxtVEhnSkdVM3hLbGMva000cDY3Yndaenpm?=
 =?utf-8?B?ZjFjZFMzSTRYbHNtNGNZQnV4RjlQZHBPRmI0b1lGYkhMQU9oMGo4VTJ0TUU4?=
 =?utf-8?B?TVA1cWdDbzArQVpEY2M3TmRhQVZCeHArYW9rZFlIaGIvWGpEem8zVW5vbW1L?=
 =?utf-8?B?VVV1UURmU0tqVEVLUGJwWVlJaTZEQnkyVEhSeUFmSGVvMTllNlVJVDdxV1hm?=
 =?utf-8?B?YWRpNUtodEFsK2JwNVFKazZnQnN6dG5nSUtiWWM3NGRFa0tPbWNaMmFORVpi?=
 =?utf-8?B?azcvOUE2b3pvVkI5Q0VuVkxxTDRWTVg1VC80L3grOUd4RHNhNmNTakk1Rmd4?=
 =?utf-8?B?TVJXSnFEbnE2N2xsZWFYOUUzNlRoSDFqS1hYcWVyRURNU3RxNDhxTFJqZEta?=
 =?utf-8?B?L1MvSGhwZ2pocjlkcFo3L2t4UjlaRy9QTS9XRGlUNTd0MEpDbGtaMEFpTDRH?=
 =?utf-8?B?SEE4QTZ3a0dBN3p4ekRpQzdKK21INEhET1JNWXIyb3pwNlVkcEZHQ0hjVzNt?=
 =?utf-8?B?RnNqRm9MS1B2UnVxdC9DS1pjNWZVM3lGakMzS0YwR3psVXF6aElxZHBiQjAr?=
 =?utf-8?B?VG5hN2dCYkN5ZjVqZlcyWXNQNit0b2pQNThHa2JpUVcra1V6ZnNxYXJ3WU5i?=
 =?utf-8?Q?YqhDZP0MrjeeIbGfUpISC9Qd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3849a34-6a78-4078-77c5-08dc11bb82c2
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:07:03.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tQ9Px+59N5f6vzMBU+EqpXIcY1cxbJz1E/kEGQeR1cBd8PJpr1lnW6aX7bdNZfD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010
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



On 1/4/24 19:50, Brandon Maier wrote:
> The zynqmpimage_print_header() skips printing the first partition. This
> is because the image header can contain duplicate fields as the first
> partition. However some fields, like the partition attributes, are only
> present in the partition table. It is also possible for the first
> partition to not be declared in the image header, if the image is not a
> bootloader image.
> 
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> ---
> 
>   tools/zynqmpimage.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
> index bb54f41a153..05af1e81a24 100644
> --- a/tools/zynqmpimage.c
> +++ b/tools/zynqmpimage.c
> @@ -262,9 +262,7 @@ void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params)
>   		for (i = 0; i < le32_to_cpu(iht->nr_parts); i++) {
>   			next = le32_to_cpu(ph->next_partition_offset) * 4;
>   
> -			/* Partition 0 is the base image itself */
> -			if (i)
> -				print_partition(ptr, ph);
> +			print_partition(ptr, ph);
>   
>   			ph = (void *)ptr + next;
>   		}


Applied all. With also removing "This contributor prefers not to receive mails 
<noreply@example.com>" from my reply.

M
