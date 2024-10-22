Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F76BD1CDD1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 10:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBEA88F50;
	Tue, 22 Oct 2024 12:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ngmBLn62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83DC88F4B; Tue, 22 Oct 2024 12:04:41 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80FE288D9E
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyS4of+kq1QTmaePWZ+E2uj/OoxJlpB0t2YHdCiy4p61gy/wPWc8K/SGK4yQxgZuF2i50MFwk/ZMe6ljt1KYxWhpvn3ObOXJKpmiCPXxfVx8C3uk73rv0jKL4tIEfD5hbpUEa/3jLtdqyZGXGezqXVvXOYvThIbvYSZBpRb0OUY+YPn3XBLUaDRSiQwS2ki5BY9C3eRPdbdAyWBcOXWLlBoujLiEbUGvlXLyUWPEWGxvBl10RVzp1h1Z6j20850IRjKFobGgHoJSv4zh7/UKoDkTcjjhpsmePiLj5pCRULhT3/31eJJecmtMZiE6Yymur9JR8FwODuVwG4e426gL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzMUKLRkggeXwZYE+MsLnPfWwoLmVASVIRLoYsOCsRI=;
 b=tSHmBXw4ckAttm4pdviE4y1hU5Qlw6A5krgFi6dmnkgJEWIZXXKkhd9RWo1NEEyJt/HB5i3wLdQdkkvMl8Jk/ElHv15oUklXtw1RwKDVe1WRYUBS9290VqS22kXpe0/gj4zVeQq0uzA/S4iTvq7PuQMYXwnWyS+AkghPJhIwgWB49sC+UC2O5e2AS0oXjql19FDQgK/kqdf9YXH1hbqUY7mbzHWJX9oUz2abVVVG3uizgk1vFAFabA7SfnO12WIa53YPi0wMFFbrW54nQwQ+U5pdyiZOT6mC5+9v7PZ+60dTffrnvryIhirm92zbRRhmp5WGtz/Dm9Huq+TNqdvCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=none
 action=none header.from=phytec.de; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzMUKLRkggeXwZYE+MsLnPfWwoLmVASVIRLoYsOCsRI=;
 b=ngmBLn627RZom4iuMrBzILdZvgUAUYDrTe3mHSIS1tE+Y/ikPRn/ZJWAxmUZI9PVRSyX5s6t6p58IWQLX6/ShzYibwZyIuOp6MCYUE4RpK0QkwOB6H2EiiNuqkxuhK+0SYGvnjS7OqsNqKufmF8i81ysjSf0wImT9Jbi+trWCtw=
Received: from DB6PR0301CA0102.eurprd03.prod.outlook.com (2603:10a6:6:30::49)
 by DB8P195MB0536.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 22 Oct
 2024 10:04:36 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::42) by DB6PR0301CA0102.outlook.office365.com
 (2603:10a6:6:30::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 10:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 10:04:35 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 22 Oct
 2024 12:04:34 +0200
Received: from [192.168.0.212] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 22 Oct
 2024 12:04:34 +0200
Message-ID: <94cc6dcf-fe92-414f-b5f6-5797c8fa64ff@phytec.de>
Date: Tue, 22 Oct 2024 12:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
To: Santhosh Kumar K <s-k6@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>, 
 <nm@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-8-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241021044024.835846-8-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|DB8P195MB0536:EE_
X-MS-Office365-Filtering-Correlation-Id: da424d5c-8e76-45c2-5dfa-08dcf280ee90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGU5RmNJbWQ4c2tNOFJ2aEpBcGtMbzRsbmNxcHAxU1JmMy9Fc25yS0ZGZVhl?=
 =?utf-8?B?ZGVmcnhkd3gxS2JJaFZ3bHF0aXoyVi8wcGlWREJJRXArZUVaRGM1Ui9lZ0FF?=
 =?utf-8?B?RnNpNURIbnJ0VGtPaXgwRnlEdkszcVZlMWlFUVFvdkJHdUNudTkxYlFhZDJ3?=
 =?utf-8?B?aTdKTVhYZmZMdjRXaE9taGhCOXdaRTYrbWYwL0RMbXh2N0R5OThlY25ocVBl?=
 =?utf-8?B?dlArRGF5VUZPZGdaekdLVEZBQnhXcUFwMTYxS0tna2dvQkc0V2lJZnZEQW9Q?=
 =?utf-8?B?cjgyUjFsOHczMk1XSjRETXYxRS8xZzFZYi9rWUU4cXNBc0Q2Ukk5QlpvaWQr?=
 =?utf-8?B?aDlSQmU0QklMREJQUzVtWGEvL1VLNm0yMWtsZVJXNkYvTHZGeHlaTUx6aUc4?=
 =?utf-8?B?d2RTcDJHSDAyYjYrNDVOUU5xaDVsZzdobkdKbE1OSTY1ckl1czdac0xtZTN6?=
 =?utf-8?B?dnpGelJ3dTVBT1lZdWl6QW1yZ0I0bjdWb3Z5UnlJUW1jakNxK2dlYmZXL3B0?=
 =?utf-8?B?aERxQ2s3ODFiN2tPbUdpcy81MjRUUTdmVlVsU20zTDF6dmM0anlHMkx5b1Z1?=
 =?utf-8?B?TnlCN1Y1bktXZXZkWkREWDlOMmpXNXlCK25KeEE5VU1jamZuUS9VelF5cE8v?=
 =?utf-8?B?OFh4NFZxWmtGclJGS2lMVVA0U2pBczNmMlpjTFd4blkzZkhIeE0rYVpTNGt6?=
 =?utf-8?B?cVFKTDdhclFnalVDYnlkSHJYd05iY1hpUmVkSkxhUyttYXZuK2xCdmlHSlo5?=
 =?utf-8?B?Vi9YOEVzMk0zb2lWcU51cEZ0VDFwRmQ3TWtCZ3pGS2xGMDczQWZQSXlFRTBG?=
 =?utf-8?B?K0RZWkRPQjlvcGNFNW1SUzBuRk1ZZ2NmeExXNDBvV1hlRWVHeDBFYlhlbXQ5?=
 =?utf-8?B?Misrc0JNdTlJN1hqbDEyWVNnWDAvQmJRZERZODhkQlpzdmNyRzVMMExrUlpX?=
 =?utf-8?B?NVN2V3FPSEYzd0ZyWDd4WmQ1RG5BVk5IZFFOdldBVGNoby9YWlJOUkkrLzVZ?=
 =?utf-8?B?NnJlQytUWm4zK3kxZk9yOEZCbnFsU2UwKzN6THFYeXUxZktkRTZPMmZtcW1E?=
 =?utf-8?B?empqNGlSM1ZLL1lBUC9qZlVvNllFbS92MytpTnExN0xSZ3NXVVBRdVlMdisr?=
 =?utf-8?B?eHNTbU93TzFTbmVBYnBGUnVuaU1ML3hLRzhYZ2U5cE1RMHhGNlpFVFJBWVR5?=
 =?utf-8?B?OTlwbHBYckpDbDVSSzJHa1hrbHBwZG1RY3UrQytRZW5CNnZmaDBjTXc3RW5Z?=
 =?utf-8?B?c1AwTzQ5WVJ3bE5vZjhOYzlvV0R0c3Q5Q013NFdkZVZqVHFkTk5ibDhCWlBQ?=
 =?utf-8?B?Smk4YlpFZ2FYUURvNldXZERjZkZvWE03RWVnT3lYdEVLcUo3NzR1RUJaL2tZ?=
 =?utf-8?B?L3l3dUd5Zkp2QWJXWWNkR2dtTnlKMjRJRWZaSFVQSWkveExTR1ZCbkp1T3dt?=
 =?utf-8?B?V243STBMc0t3YSswQitHd1grNCtlQzF6L0lPZHE3dWZ4eXZmb3pwcDhIK3hQ?=
 =?utf-8?B?NmhxTnhhSFgxbmc2eFMrVUE3ZzJCazN6aE1vSXlha29ROWZBdnhqU1NPSC9B?=
 =?utf-8?B?UU93dnJuTFI1RHZIaWV3eld2QXJ2QkN3TXJOYXJyejVFK25zMkgrdXhoaldR?=
 =?utf-8?B?K1Z0QWFhYmpQbHh5eEpxYnM3ZlpXRVhQcVpVeEVMZUViNGxXS21zUGN4c3c5?=
 =?utf-8?B?UVFHdW02UzIrbDNOTURmZG1pUy9JYyt0SWsvNDBrRTdidHk4VXNjQUJBNlBG?=
 =?utf-8?B?bTd4bUlpdmt5N1BlTE5RakFBUllzRXhMdG4zd082aWtIRkg5VzFtbi9nSzAx?=
 =?utf-8?B?Y2k3bmtld0NQVmRWbkNBZisxeC9MWjFBT0hHc1RaN3lJT1BmT0lkcnN2RjEr?=
 =?utf-8?B?cHN6eW5aYWxyUTBkV1NSWUFpZGxMbEpkemlnbFdGbWJrN0E9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:04:35.1317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da424d5c-8e76-45c2-5dfa-08dcf280ee90
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0536
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

Hi Santhosh,

Am 21.10.24 um 06:40 schrieb Santhosh Kumar K:
> As there are few redundant functions in board/ti/*/evm.c files, pull
> them to a common location of access to reuse and include the common file
> to access the functions.
> 
> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
> device tree and resize the available amount of DDR, if ECC is enabled.
> Otherwise, fixup the device tree using the regular
> fdt_fixup_memory_banks().
> 
> Also call dram_init_banksize() after every call to
> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
> correctly.
> 
> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
> controllers present.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
<snip>

> +obj-y += common.o security.o k3-ddr.o
>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
> new file mode 100644
> index 000000000000..754e9ba29dac
> --- /dev/null
<snip>

> +#include <fdt_support.h>
> +#include <dm/uclass.h>
> +#include <k3-ddrss.h>
> +#include <spl.h>
> +
> +#include <asm/arch/k3-ddr.h>
> +
> +int dram_init(void)
> +{
> +        s32 ret;
> +
> +        ret = fdtdec_setup_mem_size_base_lowest();
> +        if (ret)
> +                printf("Error setting up mem size and base. %d\n", ret);
> +
> +        return ret;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +        s32 ret;
> +
> +        ret = fdtdec_setup_memory_banksize();
> +        if (ret)
> +                printf("Error setting up memory banksize. %d\n", ret);
> +
> +        return ret;
> +}
> +Moving dram_init() and dram_init_banksize() into a generic part forces 
every K3 based board to use your implementation.

This also breaks the builds for phycore_am62x, phycore_am64x and also 
the verdin-am62,

   phycore-am62x.c:49: multiple definition of `dram_init'
   phycore-am62x.c:97: multiple definition of `dram_init_banksize

Regards,
Wadim
