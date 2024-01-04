Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11248C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F668784E;
	Thu,  4 Jan 2024 09:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKFAhaS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648F1876B2; Thu,  4 Jan 2024 09:52:37 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BE987949
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ3bDf2ZJUNqXCHgPG+OwX3v3Weh9F5DElBY2kpKUL+JjcGxdzVCH/1FCUqIFWIllrOj4op01S+Z3EqpumNPnYe7VcI/7lEE3xxQnmxwcRCpSeSdBD7XCXsbTPw/zsCT7WM6kRj7Oibhr14aY6G1WQKvUVkvaXCO1/JYpRb9yvVWb6bgzdhTc1mkytMbLseLmtZdXe+NFnjbNgE47IhSb7KQRXsNqxPpLX15rYRhe5kvMUE0GFW5lPNxwAew+hXNKDR3GdGZHqwP10txwgK6m5EWPr5KectShiKZTgHhNTPYVfih7Vu1/T4eQt5uA1a8JTqZNUhCy2KG9lbIq+ZRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRxFPZQkJiHYFQcKkZN0z5hXkQ22mC2NSq5cHueIRiI=;
 b=nCA6s9lPlpxUuGH/yBhp/QwudLfANNZD88iNrhChon7alEu/FsVsCAB/osbAdRP1k7rV3rKPwMo+BPLQG0gdDkXPmgwtcs1eEsLZpIph2ss2VmNnc9ngGOf/nhnqk74TiBH7rQ/W339JTwaEU3RiW0XFvMw+nc3DBJ4rFgJdj4tMt2EYqfT7O8FBfgJF6gaCQOywhTkT1EEYdPxBHdz2pYP77cZ2XTcZXOtdrzmB/cfGu6HAtXr334yhe8HtCVJqsYi55jY8CaZxAfg6tj148oxhn7H25Nw8+CDumkayYGl+cCrPCDz6ZfEFHd1GggIONq83dTAUvMroV7jErefJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRxFPZQkJiHYFQcKkZN0z5hXkQ22mC2NSq5cHueIRiI=;
 b=DKFAhaS4Eoh4wLY3oDWpnP6TKDB6wlrjAgk7UCcR71WfAe+iI20Kv6WFNPS2+hgLji89wNQAd5Hn1p+F2RlrKcQXVMn4AEXAySiMz65+KEk4OXFfYGk55JFT8lKs48hT/udrcqrhy5dmJ472B5HXEEGwx+cbuG3UEGSLf/JSUBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:52:32 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:52:32 +0000
Message-ID: <8d8df39f-186f-4596-994c-e779f52b8197@amd.com>
Date: Thu, 4 Jan 2024 09:52:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Generate dfu_alt_info based on multiboot
 register
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <5abc5f3047ce586b4d2740b5eea775d063295e28.1702906896.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5abc5f3047ce586b4d2740b5eea775d063295e28.1702906896.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0078.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: dc33a071-30ba-44df-33a3-08dc0d027d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52K04uDif4m+WIHV6rnIa/yhHWoV07vyZzgudn1XoXrPTdxCT25GaoflyLu+gnrmBSYy3d5yApzHnhpckXL4bEQhH/0t6z7jH45pVD59XyUR/zlDZDkZo+agSzs2FdwKYxKQu4yXOsBGIJwpvPy3XZJoniVSr0AdiAtTLxbKLZzWeOU/EI+FmBMHGcdIW9gakWpm1/R8tqhDrrDN98eiP3uixaT6mz19uukTOXo32/68le4A5U/bW4gQ5CWONwCVh0xTrrigt2C9vUrjMXyxKWUaOc9ZP6wbE1IU5ZqJkEMyEdsVl1wHlMqMr8SFd6RaS+QqsygXTx71izelizfE769XHsw26wgeG8qYQNjV84xT3Mo5saC4bkbcpRA+Kj0YTNk2oTJuT5zs8OdhLiLOvnwKxboJ+902LuqVgNkpVor/8/cr7Vfs3PQ5+QrxisiWZWxAxSR/yGCGEwIG9jKGRdl1SVN7ijsptBJPhvK4hLQkPqkcLi6PPY/9aVFZKlV2LJi3nyG/1H6fpP2uPl4anjaZXGQP/8YTotUx1QxkPZ/o8NVg9F2fMPE5ObiBT5b3BjqgRdQrNXcnzkQlsbJ2EGOAuF5U5LqVWKtQvtJSvDrjZ7WTkNRhZwy+hD4WmVwUMQmGqB1GsvN3ZGFH9dPKhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(36756003)(6486002)(478600001)(6666004)(6506007)(53546011)(66476007)(66556008)(31686004)(66946007)(6512007)(26005)(2616005)(44832011)(2906002)(5660300002)(4744005)(8676002)(8936002)(316002)(38100700002)(83380400001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBHVVo0R1ZZNHNGY2VjdkVZTE1MRjEzMk9UdVNaRmRKOVovY0xMZDFUUWZZ?=
 =?utf-8?B?VnMrVG1aQWNZbllmTTk2NjJHSDVLSFliWmxVa3RoenY2bGt3UEJOaWxYbTlZ?=
 =?utf-8?B?d2d2T1Y2V1FQeUtnUnB4NnV5UmxHVXNLS3RvMThkbVlBbThSQStwQU5UUHZS?=
 =?utf-8?B?bHJnTFZ0bTFuY3YyZzgxYXBzY1JNMmJiNnNhNnRsOVFKM2p3SGNGT0tPTm8v?=
 =?utf-8?B?TXBJWDNCVVFYTVc0aXNtRkFDM3B0SWgzQ0J5ampKVWY2eUhONGFTbnVrV0pq?=
 =?utf-8?B?aWF0cDA4bFNyU0NIZlZweTd6SElTOXk5S1E4eDNoWDVWVjZLTHQ3Qk10QzBO?=
 =?utf-8?B?RHhzbGJTdk1kakR1T00yNEFjWURtWUprYmtSc1FnOTR3QUN5VVBseFdyRUVp?=
 =?utf-8?B?N0Z6elRrSDFxQzQ3ZWkwZHRnVDM5Zi9yVFVLMVZIMnpIbWRCbWVKZUJlVk5E?=
 =?utf-8?B?VjkyTXB1ZDMzczVwczRPTzFQaGM0WUtaUWNBeC8zNG90V3hDVDdoYnVieGlF?=
 =?utf-8?B?cjRMblBtM21EVFRsWExMSmpQWDREZ0w0U2lsOWxMVnk4SHlRWTduWEJUc2xj?=
 =?utf-8?B?TiszUUN6YlA0TFFvbHptS2VzaDNHcDdqTXN6OTltVUQ3emJlanhaTWxBNHdN?=
 =?utf-8?B?cVBZeWtGcEJhMWNuRVYzOE4xbU1BbmRlSFgvR1hXbmlVdThRaktnVWEwZ1VO?=
 =?utf-8?B?dHZWQ1JibFhsczJhTGpQTXlUMVFHTlU4T25zRnZlcG51aDNYMHpXdldVRWRX?=
 =?utf-8?B?YnZiQWxSNUhiOHJTWU0rdWYyRytiUk1QYnVqSjNPaUpubzhWanlIN2VGbm9C?=
 =?utf-8?B?M2w3UFZEMUordnpDMjV5V0dQK3A5OEFQZVBnbkdTbjFZR3E0cDNSdGw2T1dJ?=
 =?utf-8?B?NHoxR21oRjdBUlhqRk9EanFTVFUxUFkrNm5ETE5qWjhvbFYwMnhLR0RRZS9C?=
 =?utf-8?B?Q3ZlNzRnbC9zRU9hdWxmQ0pIUnJUcGhVcnZFaU8yKzJiT3NnM0ZWNHlvc1ZQ?=
 =?utf-8?B?WGxZMk53VDEvQy91NWxkb1FnT2h5aDdwOE1JQmxCd3FuRkpnYVlhU3lFUjRh?=
 =?utf-8?B?amFybDNjUGpJTThUWGtzT2VPR2prS0p6cmlpSjRMdUZNWGVBVnVEZ0JhTkF5?=
 =?utf-8?B?NFhMdytNckRFQU0vbmdDRXlFdjkxZDJzZnJKZXhrSkQyL24wdVNFT0FHSmJO?=
 =?utf-8?B?YWVFMzA5cVkyTW4vOEVCNTQ3SlpzT1QyRTluWjlFY09xL3QxZWtvd1lXeTBO?=
 =?utf-8?B?RzFHakFFb1VGdEd5QWduY0RYV0FBa3BhUkdONlhSZ3dBZ1MxSERBdkg2VVJI?=
 =?utf-8?B?OTJYMW93b1lIbHhwUkNxSG1DcmlwOFFML3BOVG1QaU9vekgxQ1BVMHpWOVlj?=
 =?utf-8?B?OU80YXM4MzVXSDczaU1vTEVRb0k4L29Sb015QS9VRURYbklZODdtNDlVblpa?=
 =?utf-8?B?Wjl5MXVEcTZMNzZYOGN4aVo3N2lEZGdBVHpxc2owVndFSnJlSGdCWEhuZCtw?=
 =?utf-8?B?c2tvMnNYTFV1RmVVYkFtVjd5eitxc1ZSdk9jb2tBZFQweUtDdG5GRklPdzg4?=
 =?utf-8?B?eGFkckZmVzI0ZU0xQmVEUHlZeHhtUUwvN21TL3hjMWc1MWZsOHg1azUzV1h5?=
 =?utf-8?B?SjZ1ZjZNYTNxV0xrQU5HWTR3My9IMnVCbmdobUo0a3dYS0R6NWs4Z2FwRGV6?=
 =?utf-8?B?SnB1L1IzaVBWaklVa2k1dU9CSHRyd0EyU0s1ZzEwNEFpS1p3VitrLzl2SUpF?=
 =?utf-8?B?dHZOOHVMNEdrNmJmOG55VTBPc2hUcVpRWHNKcTd6YnNNb0xzTU9WWlkwZWdw?=
 =?utf-8?B?eXVBTWpueHNTQ3R5b0xxS0JOckF3VDJobmpZWXd0TGZWK0xpN1FwSzVmQmhE?=
 =?utf-8?B?aHgyQ3VJY2RKSXpVdElkNFE0RVVXUXFXN1FyeDRFTkZLRFgzQko4aGJpb2cw?=
 =?utf-8?B?a01KN1ZwMENUUUJoSm1yR3BQVXVWdHlabElYNUFLVGxtUGhBb2YxVFgrUnlF?=
 =?utf-8?B?bmVRemRKcHBvand4U2JFWXBzL0VRdHlvMkR3SFU5c2dKdUl0VUk5QzdLWlJM?=
 =?utf-8?B?Smx2ZzE2RjJYMTRzVlByQWQxd0xNaFkwS0RDOUZQNmYyMlFxTjhvLzVBMk1G?=
 =?utf-8?Q?vxmF9wtUsxHXzer5xfZFHTglR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc33a071-30ba-44df-33a3-08dc0d027d0a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:52:32.0783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r+iKl/NyjaMjRG8zKXtqHBqJiEUarzLLhWEsRgJH2Kqmn1k/TDFodde4ZcyCZCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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



On 12/18/23 14:41, Michal Simek wrote:
> Commit 2c8a09219cdb ("arm64: zynqmp: Add multiboot support for SPL/SPI
> offset calculation") enabled u-boot.itb offset calculation based on
> multiboot register. It is also good to reflect location of u-boot.itb image
> for dfu_alt generation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 59feaaf6f32f..e3700f076bc1 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -670,7 +670,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
>   			       ";%s raw 0x%x 0x500000",
>   			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> -			       CONFIG_SYS_SPI_U_BOOT_OFFS);
> +			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
>   #endif
>   		break;
>   	default:

Applied.
M
