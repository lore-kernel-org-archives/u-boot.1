Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73560C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 06:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C10840557;
	Mon, 31 Aug 2026 06:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FK4xP74a0iUB; Mon, 31 Aug 2026 06:40:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788158434;
	bh=yb2ePcf64dAZ2BZqMWT9Cn+KwSDyGYshp6o1G2EBLF8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpJZxZ7U2qKWhg78eEyjro9xjvqiURC2FDkdAH2aQr4U1+WU/4ZWYZEwAGtT8j7Mw
	 RDw0+XI3foSrnJ+DDsrrvyeRFyQ1Pg7b1XMwpE1jG1qGdWMB1gzs3nPPAufjUKLNzc
	 +K2cW3vAAJIy8bLjaTYE4LhZKTjcIA8y7Q8lv6JMH8R/d8CxXCbVSrRQ1W37KKPWNE
	 q8xdpbOZyypS64K9I64Z2dLO9X2hLZCK0I/D5DbXhFjB9K9XuGQsopFCQg8+YMOJDf
	 xCvVnpHESnShdVX9Kn8HXj8+tOnSuHJ0RR0//EFURxlLzb1U8iLnbFozfHbHDNg2ye
	 WZbQAYBx2lwXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9DB340546;
	Mon, 31 Aug 2026 06:40:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 419DE230
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B39840546
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbwv9FGTRizX for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 06:40:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sfbK+aec
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1239D40540
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK9kkv18UsYJ881sTiqrmTLWP6HJAEiDFPD0/vj/V8tYp+6rnoGM7u3HaqPhE+EJm3zEPYW5gmMNCW5NgbMIZGy7XTIIYp3hyAhlWRkw7atCTUdNsQyoiMOwUvBjIEMSkJJcsdG7zXRdQ0CyOWMwK70AewqidGu2GQDFv7GTQ7jDAq0WbkWVGL5zXtWvMUltUOqrKdFLYKd1G8sxtZs/D4hH+OikvtTeBolFsJEQtDXvGGLqkt2e6FZZqCLrqOmPbbpERlBt62ouTYEC/++b0cX9RMj6dqIL6FzApyByrWssVzONY4rZmNdETYePaCIq+VWWNvkj54v3RqagJh+elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb2ePcf64dAZ2BZqMWT9Cn+KwSDyGYshp6o1G2EBLF8=;
 b=XUWSlueul91F6ngUTI/CIjWWvUoeAjlUfKvY2n2WDTSZWX+drN/C74JVBjawuLo71GLDzWPw5PZ/KrBhtmif26jpa6fNio0NmmzoseTVOUk6Z/h29+Mccb6vW1UMX+N9YCB2vf/glEwRPzW2BI5VQ/rUeP935djG7m29Z5K+nmSIg8ifPKtM2G7K1AFzNn4bYOHZ2/HQkzc4O0U7nQAyAWtmu8uHHI36XmvIPKJc6bYTLZfZ/CyGRgZtFDR+V52t2oxifUYvOGn5DFqDzBpLW3vS+UZrcNmDWzvam14WBtBoLIazkKjVcP7TNuyNIIX2HUVg8wZ3dEBLVybcm0j1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb2ePcf64dAZ2BZqMWT9Cn+KwSDyGYshp6o1G2EBLF8=;
 b=sfbK+aecfVYRclOjPSy1ppYMjfpYZoBJhr06tmEvPYo/63c18ggc4u2MpPvJQPBE2FZUfRLVYl53I+JVevmBWLwtHQhesN2lT4RNf3wDbMtrz/KapP6Gs7OrchOJPHmz+HqSWIxt20pFWnhtGK7laaLd6UXYHN3aHR23DSciupk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB999082.namprd12.prod.outlook.com (2603:10b6:8:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:40:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:40:26 +0000
Message-ID: <e71bb6a0-6f20-4d61-81a5-668408d8d7f5@amd.com>
Date: Mon, 31 Aug 2026 08:40:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] MAINTAINERS: Removed files
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-7-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260829015026.473134-7-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB999082:EE_
X-MS-Office365-Filtering-Correlation-Id: d9788c3d-cf33-4b14-7cb5-08df072abdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: PJNHN62Xbz8dJEOC808yVc/k8YcbRklcrmVhF+rMyth3CgNgr/YPweDPartU/uldvQEFSU1IdgF5ejZnPNNiU59mUVEiUit+vb/WVDI4dvUsp6SoXRDtuG8y7YzyCaqUSmfV01XCjOXIz63qDyRFp3GKY7WDCCGpE6lsnNe1JA82oE8VyxRJoO+MlavtSaIvAsIq1IS2ZK6YQSn6y96N8/EHlhsHZhX/jhj/85UQstUg8CfjLwFpHuIsgfB3bJ2XpIwhyO0XWFCn6qTNerX1JmNh79/tzduwCEAGjuujRy9PpY0YMVwJkt5QNhgX5yHONG3JysOycRP0Gdl0JhAyfe6MlE5XzCl8fTUPQMGDvJOfZJb77CxRo1taotIP8zFT/7BaPyqrBN7aOoFFfiu6hrlooQz0+76L4bOOBW/225TodJiHIoxaojxeqFiwTUUqjWAbpDf/8usfskRaJrFGCji0vLMycZROV2HiZoQXQ8G100WxNXSdZi3TeJ0+AOvTNEi8rYBBjpmEZTtvxYuGqZF2vLMpHMeDTUboJiACFTJPnDQ4OK6Wyor1cUbem2mKYV57p4UL/JdYC9eP06P5ysxcaifR003+wx+soldxRzMn9nIY9PAMJ8ZtOv7H+f1zBRN1Tk1Fqidd4nPWYE5FXFEX/0v1+CpiVotjs2Q7aJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FjWmdQdm9WNGJqc3Ntd3pBRXVSM0dKUUZ5ZnJlMi9KRzZmdFJqanBhS1JY?=
 =?utf-8?B?TGtnUFkvbmJ3d2pBYmF1ckpyUElpRTg3Q1JQZ1pJRFFSUkM1bjZQTWN1QTRQ?=
 =?utf-8?B?aXVvdXMrdVhsLy9KanNpdGZZQXgxZUdoTUY4U2QrVE5DOEhWczQxS09xdWcr?=
 =?utf-8?B?QzRDK1BNd2RxU2d5enFqblB3WUd1RStKNm5YV29FbUl3U3JMTUFlQUpqOVM4?=
 =?utf-8?B?eEx2bkpERG5UcUdlalBQSk1kdHJxZGkwTW9IczFGb3dpL09uYzlHY3ZjMHJq?=
 =?utf-8?B?ZW5UY2xNRDJSQ0ZEU1NwcW9CMjdDeTlZUWZNdlJLbG1HRzB2ckZ1NEN5Z05k?=
 =?utf-8?B?OU1IdDk1SE5CTDV1SE5qNVNLekpYNFgxVkdpR0E5TWJ3cFlBUU5ZeDZmRHFh?=
 =?utf-8?B?aUl6bGpsU0tiRzlFOG1HTVhDTlFJWWU5bW1aaGpGSEtsVGNtdFNsOFpBUmxz?=
 =?utf-8?B?Wmd1RVptemNsc3F5THhXeC8zYjFxNFduckhBUW1HcmpWbFZ6bklMeW1kUHE1?=
 =?utf-8?B?V1JxS2lsaXRxcWNTNHMxS2ZRdWk4Qk4rOHpxUEdLekIwaXFqL044czY5RGJt?=
 =?utf-8?B?MHp3VXZ2VHhyeXhiV2dMTlNZVkhxbGpZYkY2UG1GRHlEVEdScCtpUjJOYldl?=
 =?utf-8?B?Vm55d244Wk0zV1ZhdGl0ajdad2dUQUVnMzBUNFhFc1VpMHRHSThDbG9QcFc5?=
 =?utf-8?B?Mkx5ckl6ZnJZei9jRHFuNC9EUnU0RG93MXFKaitGZ3R2SE5LcmYrNHNadTVF?=
 =?utf-8?B?aVJ3QXdVVWxUN3YwODFLUlBGYUFuQkkveEhCSHF2NTJUUTNiUm9qQVZJcXNq?=
 =?utf-8?B?S0t4VzZNcUh4ZUUvdTJLRXlwMFZPMk5pNU12T0laV1ZJajg1Z1VibW1ZRExW?=
 =?utf-8?B?Z2pnNU00cGFwRlJ4d3puVFFrMGV2bDRFTnF6bS9lZ3ovV0sxWGxjWmVoejAz?=
 =?utf-8?B?OS9RMlE0NFRFK3N3eldzMm9lM0FwQ0ZIZ1MyVkhxeW51ek5XcUJ5cHYwbDBx?=
 =?utf-8?B?OWVCT1dNd0ZJRGpMZ1puSkVEb0p3b0JDalRNU1hPMlBpUDhBNVI4L2U0WVZl?=
 =?utf-8?B?eWdvTUNCZno2NHJ1SGNib1cwUnA2dVJTZ0J2WE5mV1hUL2pmWUFPQ28vMzIr?=
 =?utf-8?B?MVVMcUFIMTZmckZaSVpQMmRhaEVCcW51SXZYRHFiTDNoQ2ZMMUpCbDNPSGlY?=
 =?utf-8?B?T1VCc0tHSWViVjJTaGxhTlBDRGpQc3VjbjBBb3FabENKajM4cGxNNTB5aEVS?=
 =?utf-8?B?dmdTZTFkejg1ak10RUtodjl5QVBzSVMxa0lCaVdDbi9sNzNzb29qU0E3ZWMy?=
 =?utf-8?B?YVdLeUJucHdxMzVmRDNlZEg1UHlLRUUrajJRTDZMbFNVcGVTVHZWT0NwNHNn?=
 =?utf-8?B?U1VmekpwR1dhVHNoRm1zMmdsRmlEaXlWOU5GcGp0dVBtTTBseENSVHN2aHJr?=
 =?utf-8?B?aDRHS01QemRERlR0SVlOZjBiSUxuRTNFZnJvUTAvYjNkODRMOUpNL3QwRVNZ?=
 =?utf-8?B?SFpGNGRxSmlraVlVQVkvNWJlOExLQlNqbGxkcCtPNHBGVlNmb0N3U2g0Mm5n?=
 =?utf-8?B?OHE0aFJ2L3VIZisxS0dDekVmb3VaL3duZFNyUU00dW9SZVlkR3NWSGIva01k?=
 =?utf-8?B?RVFDQXhweCtqT25UdnNYZlU4NE52Vm1GejNtV0NBN09EanpDQkdOL1lVMFJL?=
 =?utf-8?B?d3dpWVFZM2tzNU1aUVVoamN1MzBTSVlWb3dsSHpzWnlET1pwSGNYdnllZHl3?=
 =?utf-8?B?aXQyekZiL3dJelU2U2lzZUJxdmh1M2V5UFRTU2YxTDRDeWFPZGZGNVpLZ2FI?=
 =?utf-8?B?THRhK05MYW55RmpjY0FoMmVBZXpZMUszcXNHYzVjajgvRU9KUGNhUGNCK1lW?=
 =?utf-8?B?YUlwOWVKdFZSMmRweFc3amNnQjJDZkJGU08ybGU5aEthdUtLTVJHT1NVUno2?=
 =?utf-8?B?a1JVOFdoZnhUaEFhTzFhb0paOEpDV3hoeVY3L1FrTkowTUlaVjJDMVVadGI4?=
 =?utf-8?B?WWhjZTRadFJtdlBHUkNyN3krOHp4dEtQMkM0NEhuM29KSGlOK2FkajZucy8z?=
 =?utf-8?B?T0VYZndqVnUyR2I2RXdZbVVTRU1RMTdYZlByd0QyRVFBNElocVFkZlY4M1ZW?=
 =?utf-8?B?ZHdDandPaHMrZk1zV0h3YklCR1RHeU5ObkFGSGRKQ0FhUmhzSkwzRHdxMmtp?=
 =?utf-8?B?VWxyQWY2ajAycmp4V0IxcE5EMXdSS2JPM0RiT1ZVdUVlU0N5c1BFQTM4bUtR?=
 =?utf-8?B?S08wUmVJSWRHS2lWa2NhQVFIdG5kb2JZbDNYenVkUzB4alJsaGVHLytscllY?=
 =?utf-8?B?RUhndC9HU2NPV1cveVNNS3dYZnliUmRBTlg3blNQODhNdDYxYWl6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9788c3d-cf33-4b14-7cb5-08df072abdf6
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:40:26.7523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSAvc/tGSk2MRgTTxxzNoVf+kK4ToSx2chz9dr9rS6TDNSjuIfNA84oelD5yJ+kc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999082
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/29/26 03:50, Tom Rini wrote:
> Correct MAINTAINERS entries for files that have been removed. In most
> cases this is because a given platform has moved to using OF_UPSTREAM
> and so the local version of the file does not exist. In other cases,
> sample defconfigs have either been merged or simply removed.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   board/LaCie/net2big_v2/MAINTAINERS             |  4 ----
>   board/LaCie/netspace_v2/MAINTAINERS            |  6 ------
>   board/Synology/ds116/MAINTAINERS               |  1 -
>   board/altera/stratix10-socdk/MAINTAINERS       |  1 -
>   board/atmel/at91sam9260ek/MAINTAINERS          |  1 -
>   board/beacon/beacon-rzg2m/MAINTAINERS          |  3 ---
>   board/embest/mx6boards/MAINTAINERS             |  1 -
>   board/gardena/smart-gateway-mt7688/MAINTAINERS |  1 -
>   board/gateworks/gw_ventana/MAINTAINERS         |  6 ------
>   board/ge/bx50v3/MAINTAINERS                    |  3 ---
>   board/intel/agilex-socdk/MAINTAINERS           |  1 -
>   board/intel/agilex7m-socdk/MAINTAINERS         |  1 -
>   board/intel/n5x-socdk/MAINTAINERS              |  1 -
>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS  |  1 -
>   board/kontron/sl-mx6ul/MAINTAINERS             |  7 +++----
>   board/mediatek/mt7981/MAINTAINERS              |  2 --
>   board/mediatek/mt7986/MAINTAINERS              |  4 ----
>   board/nxp/imx93_evk/MAINTAINERS                |  1 -
>   board/nxp/ls1012afrdm/MAINTAINERS              | 12 ++++--------
>   board/nxp/ls1012aqds/MAINTAINERS               |  1 -
>   board/nxp/ls1012ardb/MAINTAINERS               |  3 ---
>   board/nxp/ls1043aqds/MAINTAINERS               |  7 -------
>   board/nxp/ls1043ardb/MAINTAINERS               |  6 ------
>   board/nxp/ls1046aqds/MAINTAINERS               |  7 -------
>   board/nxp/ls1046ardb/MAINTAINERS               |  7 -------
>   board/nxp/ls1088a/MAINTAINERS                  |  9 ---------
>   board/nxp/ls2080aqds/MAINTAINERS               |  4 ----
>   board/nxp/ls2080ardb/MAINTAINERS               |  6 ------
>   board/nxp/lx2160a/MAINTAINERS                  |  2 --
>   board/nxp/mpc837xerdb/MAINTAINERS              |  1 -
>   board/nxp/mx6slevk/MAINTAINERS                 |  2 --
>   board/nxp/p2041rdb/MAINTAINERS                 |  3 ---
>   board/nxp/t104xrdb/MAINTAINERS                 | 13 -------------
>   board/nxp/t208xqds/MAINTAINERS                 |  5 -----
>   board/nxp/t208xrdb/MAINTAINERS                 |  1 -
>   board/phytec/phycore_am68x/MAINTAINERS         |  1 -
>   board/polyhex/imx8mp_debix_model_a/MAINTAINERS |  1 -
>   board/renesas/blanche/MAINTAINERS              |  1 -
>   board/seeed/linkit-smart-7688/MAINTAINERS      |  1 -
>   board/sunxi/MAINTAINERS                        |  2 --
>   board/toradex/colibri-imx6ull/MAINTAINERS      |  1 -
>   board/traverse/ten64/MAINTAINERS               |  1 -
>   board/xilinx/zynqmp/MAINTAINERS                |  1 -
>   board/zyxel/nsa325/MAINTAINERS                 |  3 ---
>   44 files changed, 7 insertions(+), 139 deletions(-)

Perfect. Thanks. It depends which tree you will apply this
but I will keep my eyes on it and will rebase my changes on the top of it.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
