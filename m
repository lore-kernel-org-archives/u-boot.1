Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF9C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15773878AD;
	Thu,  4 Jan 2024 09:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h9EVnSPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE1A08793E; Thu,  4 Jan 2024 09:52:10 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91A1876B2
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOwCokK0PG4hJcOaliqJV+YkgUMdpqMh02i8EKsJ0MLScGomStv2u/5ijx6KjwNKf8p8teKJ1rpQ1zLTGo+q7Dg56BzpF+mrVm0SCCiseVNr67hvHwwrAUhMkZeDREQC5XzkeMq9LYFxPaO5nRUgxql2PKdGAvUM8X17GXWEYdDZ6KVTzJyyIqBoh3YDvwvmMMavnYg1C+zQbxjTu9ilwSfWhNzRINj0wiKeGLz0tfoWDi5dEK3oMswTowPP5m4O50jDtVI9wUqLWxGMkKATtujeJ8hnLxVxQLCRA2PnpyAWQ3mzl7RLRNjEeBPecjO//XS0P+K4OhOzjQ5FbU56cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmKxMR4lEZYfO6sNAe20+9iFATMxJqk2V43m20w0Zhg=;
 b=d/noskMuOXXVNQDltZV/1VXgQQ51cJRBQpjcLyywCIGrPDlkfG0h9Qgj0X8CEn7/uesW2DOjYNZcqwChOZvJyQMXEy393IRSewqtyH017RVBgo7PLfdox0FUkIPfMK8x8ppWRoyXPWcuLI3SbezfEv9LlenKGCZn8PlvottSljGlIuT8F74zEIovFQz2OH+mvHp/6QaQQx7iQlTUIYy0gVwji4AxnNvi7QlqEIq6F711uOTHjsqu165XAuEyrHMm4DVYYz0xpj9a7jvOdlxRDG/5zNvwMgba52PL4w1uxyc5zlcpoNY0XHU40L6xXI65TSDmeWNa2G8g3ciUaGSe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmKxMR4lEZYfO6sNAe20+9iFATMxJqk2V43m20w0Zhg=;
 b=h9EVnSPJt1xEW9RYkC2Sze6lMqMf0iNFt/w9I+bZhJeAazaQpbYBK/lOx5/a0pKhgsy6R4FdoLPaXllXFYtAD5nR3T3c8UTBNez84POAPyJ+JVYFKOG9fcQ4KMpNNz3lGYVKfkjT0agQXnOwLAyTmvQyesIXbOZ9HtPR7uuRfQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:52:05 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:52:05 +0000
Message-ID: <7bf50ceb-3f7e-4d37-ac67-6702ac9d1a4b@amd.com>
Date: Thu, 4 Jan 2024 09:52:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix i2c bus for kd240
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cf07682a611de9895271d629ee00fb2809d99d0e.1702904913.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cf07682a611de9895271d629ee00fb2809d99d0e.1702904913.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0078.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a3fcab-461f-4ba8-3577-08dc0d026d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsT1yvqoBVKoCYi4E9OZ5N8WaUOo0EsmQSNzzxWDGD7Qg5f89Mlv8vsi25izLXjNqeFFZHOzreQXnRsESloQ8yYI4NLflu2YSN3vHQYJv2XzEIEiHoW6mesDaBzunTQkOE3C37SEWUqODGjjD2YfnxQktAorWHnfqnd1S0s6sDZQxdWhk4hBztxWvsVgtXHipJf12clQkhSvYOWLSG89OZyzatEJP6hH380XWcEDiFkuJJ0FC4GnUPuX7TQA+c13XYnGuDNhCzlqNHoSy1JAZYCuCpHD39lp6iq3U/a20LwcYCcE8eYc1JKLLezZUR/i7QjW3cfO0VbMmp1CjTAjbN6+rwkJ6OutrWA3bop/wuA5IfY5QSzc/sBLXPjuUBb1MlJxyEysvrTyJTfrFFqfNFchgt1NViGxD/AyNh15YFuKrs7Q/qC6IXbj2k2olIMrfUQb4puvQtPhnpXGK7nzTUUg3LPiZMR/z2VGVsTaX6ceTPzUR71S3HAjpPeRjNA2+1p9zfiGG2xOX/XLoTizqRNUG7tFtLttcJgCVXDGAsYiCupsYcBoN85zJZyynxH0A/n/yQpCLhmcbxz1caU0crKSsmfI+jzcpbzZAoxFs15Xt4vcw1t7Tv/153kn6IDdvWuA0kz5JmVJxcQKzWlzhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(36756003)(6486002)(478600001)(6666004)(6506007)(53546011)(66476007)(66556008)(31686004)(66946007)(6512007)(26005)(2616005)(44832011)(2906002)(5660300002)(8676002)(8936002)(316002)(4326008)(38100700002)(83380400001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekQ4bGpWdTVKRUFhRlBaaUFId1l4SGVDZmNQY3YveE5ZbHoxaUdYcXRUeXdz?=
 =?utf-8?B?dUtEMWxsV1JPTVpDUGNESThVZ1E0ZW5IWjArTC84WmZtNm9mdzBJYlRkcVBQ?=
 =?utf-8?B?UjgzNm81ZDZlVkdTZ3NzTUNTOHZwK2N4MEZxb2E1czhHRHRYaGNncTYrRDlP?=
 =?utf-8?B?Z0lXQU1CTFNDVjlRUzJSdTNUWmhxUXg3czg4Yy9qUTRVYnFxUlVENHBEZzBy?=
 =?utf-8?B?QUZWSkhoVytOclVPc2JDWG01dm1IaE42Nkc4QWVENGlGOTc3MVcyRm1IeWlS?=
 =?utf-8?B?K09USFczVUVjb0xUdjc4ZnpyMjV6d3FvTDJNZGlWZk5iRitaNm5BM1lNZ3pu?=
 =?utf-8?B?QmVWWnZaYWF3YVZqbnJlK2JZbnFNQ09WNnZjQ1pBMkNpNmdwVVhFQ2p1U25s?=
 =?utf-8?B?UFFxZm9rUVYwdGIvQnZEbW80OCtyRENWR21jTXdHbHVoeEc4SnNNSWFBdHZo?=
 =?utf-8?B?dWZrazJoYXRqSlJZck9XU2tJZjREOFdydDQ1WENrMkRxdk8yL25oRU95MXdZ?=
 =?utf-8?B?cWszellSVXhOQ2xtVEJwUnc1Y0lMc3FVYXlNMy9jMzFhWVMzVkZ6R3M2aHp4?=
 =?utf-8?B?ODNUSlN6NDR2ZkhobjFPVHB6SlVFRkkxRjNTUERsNHZ4OFZyUU5kTUQrKzhI?=
 =?utf-8?B?UDJQKzkvOEJCaGFjRGxMcnZ0UkNXTE5Xd3N1TEhMRHFtb3ZMWUF1UmUzdWIr?=
 =?utf-8?B?ZGROdUEwZktSZURXcTFDUU9DQ3VSSUlPV1h3U0V4bGdqMjVNbU1nY0NJRkFu?=
 =?utf-8?B?SVhZbC9rWWFHRmFoa1h5ZGo0SkFBdGczN0xoY1llS291VW1WSUNHRHBaV1Ar?=
 =?utf-8?B?KzMzVWs1WjlpY0FnOXdMOVc4aGVSN0xKL3FJYlBEaFE4eEhQeUhRZlYzR0hv?=
 =?utf-8?B?SVlHWkJ4YkJUaW5oV3UwWUFSeEI2b3RsNGJjUFU1NkVZM0F0TVlUTFVDUGFY?=
 =?utf-8?B?aXlUM05uSTRvak9yUFpxdVE5eUpLMUUyc2lqYVZaMlM0QjI5dGJHNlpYa1du?=
 =?utf-8?B?NlBhTzhVVDdiOE01KzBnRUtkc3gycnFnU2lSRDE5elVXVHdFMVhDMTdkTmk4?=
 =?utf-8?B?WFhkcGJHbldOejdYY0tiSGZPVzM1dllicFdpTnBIWlYrZjhyc1lwUnkzTUVV?=
 =?utf-8?B?NTNRTGE3OVZ6TWtoTmpxQ2Z6ZWdqVWRPcEJ5bXZEV09VK0pZNkxkcGNzYXl4?=
 =?utf-8?B?aDdLU29ldVZsVGhNZFFWTDlRWjZNVEZoRTNiT1RzdzRGYTNiZW1PMTlmaFV4?=
 =?utf-8?B?czZHd1pRYTI5QlB1czZmRHdyOGZzaFBmREpnZWJpUmtuSXkvMzlUVVRueFA2?=
 =?utf-8?B?NEYzMTBSUUpjVVVlU3Q2VmNpKzM1Qzdna1B5Y3FaVWNCT1VQSW04SHVFVkRT?=
 =?utf-8?B?UGYxenBmSkQ2VER0dUY4eVQvTmVYajVKYUZkV05OVEtod2JmZmJrcWczTUtr?=
 =?utf-8?B?SjNuR1ZWMC9HZWlBMlYveERRZGxnV0x0S01XSGQ3UTQvYloyeHc3bWlCOVpP?=
 =?utf-8?B?MXJBUktIQk1pMWRCeXRFanVtM1NMaW00VU51NXZvUXZLQXFXaWk3cHY0YkJw?=
 =?utf-8?B?Y0lxRW9UMHl2bFRhUmtQM1plL25vREEzVmJHSkEvZXJYYnpnb1NsdUZoazJn?=
 =?utf-8?B?aTNJblRQNXpVV0xpRVlxbmZSOEtjc1p3UjVlVGlGbXEyUTVIVmJmaTIzN2Ru?=
 =?utf-8?B?YTVoN2RaM1pIYnVuSFEvZHZ0MGVWZjdzaWNmczVna2xxazhacklIS1pvUnY1?=
 =?utf-8?B?OGJFa3pFRlByaHNrUEJxWnYzdS95WlY2MnlDRHFnUkx0Tk95czRROVdoWWtm?=
 =?utf-8?B?aEpzU3BVMnhaek9BM1VRVUhoVHJibnl2L1grOFFYWGlIQWRKcjNjSFVZZ0lz?=
 =?utf-8?B?d1d5Uk5ING5uajRvTGEya0RNY09jdDZKYW43SE1yQ2hHVTdxODdTaENVVDBm?=
 =?utf-8?B?WU1QT2pkZWxtc2tLRmw4NjEzWXhzSUVEMWtSR1hFN0lsZXAvcUFYWGlaRW02?=
 =?utf-8?B?d1ZaaHBGaTF3TVlQVGRGUzRNd2NuREVTRlVNOXY1WnV1STV4UTJWYzR6Ymp2?=
 =?utf-8?B?Tlh2KzlWNGl4N09RMUVkNXIxdk9MQ1FKR0dYcWtZejB4a0J6MDNhTFF6VmZJ?=
 =?utf-8?Q?8HI3TECNHGesgiI2oAUi5Ce7/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a3fcab-461f-4ba8-3577-08dc0d026d24
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:52:05.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjnLpwrXhwBQl1JpUh/2H8n2Vszni+DeHTSdR+IQ7FPueosRcpAITFFrCRzzvgeL
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



On 12/18/23 14:08, Michal Simek wrote:
> i2c1 is having all chips on it that's why use it instead of 0.
> 
> You can see this error when you boot system.
> eth0: ethernet@ff0c0000
> Setting bus to 0
> Failure changing bus number (-19)
> Enable permission for node ID 33
> Enable permission for node ID 47
> Hit any key to stop autoboot:  0
> 
> It also get USB to work.
> 
> Fixes: dd4a82201694 ("arm64: zynqmp: Introduce kria SOM defconfig")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 70384538ab1d..36182f1b0d85 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -58,7 +58,7 @@ kv260_setup=i2c dev 1 && run usb_hub_init
>   # usb hub init
>   kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
>   # usb hub init with enabling PM nodes for ...
> -kd240_setup=i2c dev 0 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
> +kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
>   
>   board_setup=\
>   if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\


Applied.
M
