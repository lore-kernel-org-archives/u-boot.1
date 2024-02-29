Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B1C54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 09:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702F187BF0;
	Thu, 29 Feb 2024 10:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="RuOpo+1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5666A87E28; Thu, 29 Feb 2024 10:05:52 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B3D87B7C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 10:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8WxhPoxg6ioJMM9/Aznd2lSiTYwaj9c/FGl4wLP9zzHqyAsCra0TQQ9xLpv+Ijq86abjfDntSg8R5wk0PVjt8JgFpEpVWyV2hpTrGHaujDwForfXIU5KPBjpYnIIF/Adaa1XEGhYNcz12ozcyObu0/JyNZMb1w+ytlAmS2sJRFbwamy3SLRANeH/ek8K0T3pyBb4pAtdOhAAVIYbn+juMeI4wPC32oSEjxUIk5P0dCgwrd3HaRg7KC+2DJsnPKsG3lbWcDl3EFTksP4LHILCMwKF8ZZErTlWmf3L6NMaknEHpw0EsSTF2UrxHgHmdcYrlP+/58s8BkqazV7ukmSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LENRnvfxNFKhH/MdEqPsqlQliydexfXngOSlcM4Ij0=;
 b=TPV+XR5hZVnw72a0GTHWpLLp8H/oVKh/XdVyuF5uOzGdJHCPxZg+qIuq4bhSuPA/kVxastwIkwLl06EOCezfngmPdLl+JW8YdkrkLRiGlUU9YtZTYsiLtqwGfearVIBjNGLV+VrLc+6gvKIFK1UnBmZ6Eq3X6mPEl2RhuoYFQu8TADurq+LUGlDHju8M0Rkm6jS5qF0lMlgxxashufm5WB5DrEkowHfj4ED74sfBu5P4702QJZ1+dPHfzjZra5tZe3E9FgU9LjKo781OuX1Z//ABryYp/0173lfRPXewD9FZunC0sZZYni/JOhlKarXwG2YcQ/JFxAY7dbdogW4eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LENRnvfxNFKhH/MdEqPsqlQliydexfXngOSlcM4Ij0=;
 b=RuOpo+1loWCLa1q0ttb5p08S3DSWejM0OEXvjMOlkgUvItS1+CjnMbnroMwx0PIm9334zMM0GqTSk7ar7XQW0dVfc9yMIoqbRhnX5zOtxOscg83XOLS00fpBuS5F9nGUtP+0cGFwOOBmO4KSe+ndF1G/ksdazphr9gibR8zLRv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6351.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:552::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 09:05:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 09:05:45 +0000
Message-ID: <e4849e34-a8e1-487d-86c4-638b1c19e53d@kontron.de>
Date: Thu, 29 Feb 2024 10:05:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
Content-Language: en-US, de-DE
To: Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20231226075812.3803-1-bruce_suen@163.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231226075812.3803-1-bruce_suen@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 367b7c8a-46e0-486d-2371-08dc39059d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKP2ELuMFbMF+4ST9bRMZCnPpMSZwPKSR6hgVFgeW1zjVamXOulcTG9JpDwhj4XlojOen3QSH+Fg/qozkfZ+y0gBXn/y3xfb9su3RQBKSSsAzhAIgJCydDsLCxOVGvntGxDAcW1yzE994zS+VeVVyvN+wuLlbyqF39ecDz00XCrHUAVnFp1+NddONFRuvW6TSWjeA8eNEFJ8m9XGYbJPSdD6m2nZzN+o6w91rCC9H6437dXYIjqRJoRG7x2QFRkE+FVRKZlDXFlDXpMZx+6FqkN44FdH4ypgTyw5nshvJoti9o47CpTOlOFd15h/WhaaMJdTUXmi59C348U/IcikvZg3h0IpuLxUUVVNxlspvtsiEAG+x/PL+We5FDFJ6mcfYjwPw/+7WHIiahLiKywHOY1YJFWSv1ZdGlSlMfn7iyhgtibo3jDlCU/76bX2J2HUbxCRuvVuvVayTWhkTZBtUY6llielqnxnxrwWyDefwImLqQMDWlz9j52Bvn/Ew3G71XfAVedFTn5MwYU8F8ZFxItQQ9qvgJbK+PMrpynzB6O12t2lWKjS8fIM9NMk9kXKlsd9FujQeRI4n7eOmBRFTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1oanhqbEhkL3RXN3J1SENOd242dHVNMWwvci9mU0hEMDF2cUhGYUhGZDdp?=
 =?utf-8?B?RTlHcEFaREdzWmVLRml3RUhZeDBXZXpEM2tGNzJtRi9qbERwbWpmSnF1dTJm?=
 =?utf-8?B?ZlFMbktlMFlUNFQvckdkZFpsL01qY3RrZEdtUG9jOTNCbHFmb0ZGY3czc3dy?=
 =?utf-8?B?SkVUd1g0ZHJPektncU0wcmFHSlVabHdRM1lyODZlMXdBeEZYa01ubVBxOUoz?=
 =?utf-8?B?a01PazhOZlVCZjBGQ0FtZFVjRU03WFdWbWFic0pGQWhUM0VldEgzb3JQQlVk?=
 =?utf-8?B?R1dFdEo2Z2hRQjcyaGxYcmhwVlpxU0s4bmt1MWV3UUE3U2xJT0xUd1htSDlZ?=
 =?utf-8?B?bFlZaitBSktnOGZuWUFyRzZqUW5YMURpUi9QTVJpbDRzaUlyT0NGZXBVTm5s?=
 =?utf-8?B?a0syOHI0TWRrR2tveGJ4MWNlYXRoYzNybCs3TjlZUk9GMFRjQ2Z1enE4U05L?=
 =?utf-8?B?cWdpTGl5aWp0Mk5wNmh2RGJQZzROV3JjOW5jdFh2WVBBbUVISFlpdUErWFVq?=
 =?utf-8?B?N3gva3o5d2hvZkhEYWRtMkJFVE1uemlXM2xIeC9GY2hjMG0xaDJvemVXZFFr?=
 =?utf-8?B?aGhlMnVTUHlGM3dsR2Vlci9sUXI0M2FjN2l0WStkM1Z3VlhFOElzMjcrUXd3?=
 =?utf-8?B?dnBiclNhU1ZKR0FsWk5ZbGtlNUQvZHNvNWN1SWRxNnpBNjZNc2I1NThzajhz?=
 =?utf-8?B?OUNSejFhVTJabzRDcHdCY09hT2U2YzJVRFN1THZmc0daajhMczMvTDgxVW5i?=
 =?utf-8?B?VndybFpIQlF1eS96WHN6NnVwNFNmdURGcDRQYjdHbWZZTFZXTDc1SW8rTk91?=
 =?utf-8?B?L2xmOTF5NXVnNlFhcXFJMVJHaVoxcDBVbnBVblJJQzNFdWhuL2NGL3NaMEtl?=
 =?utf-8?B?cDhRK1ZqS0dvcTFqQ3VNR0gzdVJENDVUN2hGZlA5dW9qWTN5QkszK2ovYjJE?=
 =?utf-8?B?MGZSbjl3dkkrUzFKd05LcTY0QmFKalpVdUtQUlNqRGZLc3V1bnJib0lxOTU3?=
 =?utf-8?B?d01DTG9MRHJFQllSVkRtQWxuT29jYUZMcFlnaWp3U0JEWFE4VnJGcEZORkpN?=
 =?utf-8?B?ZkVNQUVwQXhhU084U3NnWjlTbGcwUE9RKzNRWDFUUkRBUDlPQ3l2QVZPZy9t?=
 =?utf-8?B?TkNvWXdlVDRpcG1RWE5TbXYxMHhNSExWSEJ5dU56ckRXWjhFbFMxcGFwRGhF?=
 =?utf-8?B?UHcvc3hncjBtd0ZXS01ZbVlualM5NjFRQUUrNmN2Z0x3WENyelp2YlR5YzJB?=
 =?utf-8?B?cnNLVVJiSmFPT3E2UGxEbGNia1djTjZWV3FnelhMbURGeHpRRzRaVEM4YUtn?=
 =?utf-8?B?Zk9MMlFSWWZXYzhEWGh3V1pBRzBwRXpEYm0wOFI2dFRNTkd6eGRXVm9HaTJp?=
 =?utf-8?B?ZTR2UG9VTWR3UG9PQ3dHcEhyZjJtWmY4SXplMlp0R3Q2WGVGem0vZDJOdlNM?=
 =?utf-8?B?WWdnN2FWbjBBa3R5NldLMFBHMkJ6MllZZ2gvMDJzZVZheGM4eGpLOUdHcUFC?=
 =?utf-8?B?dWpJQXd2MVBVMFJ3YmpuNTdITXFHeVRhQVZrRm5GaHJ0b0pTbExDa1F6b1pP?=
 =?utf-8?B?ZXAxZlRrS1JJcGg4dHZIbGdzZWlZRjdTUFZQNDNsbXNlL0IrRW5tU1Znb3ZB?=
 =?utf-8?B?d2xSSFRmcW5sSlhKYVRMbW81UkxlcFJOZjRTSzlXL3UrOE5oanN5SWxhZWdC?=
 =?utf-8?B?T0VxcllnckVwSS9pZU9YRmI4bEpDdkVzK0lXdktWQWNTdlRMc3U5dUVBc2dl?=
 =?utf-8?B?L1VxTFJOWEh4VElwYUtpUStTa1l3OWY0eTRXTDNmeXNPcnp4RWljeEN2YXNC?=
 =?utf-8?B?Uk50QkowNFVOQWxGUllGdGxXYlRRZERuOVBLYmttdmx3V0JkeXFxZWlUYVVx?=
 =?utf-8?B?dzBvc0FFYVRrb084YWswSVFKVndWUGVQNEVkTVFWcGJZSHRpajd3d2lHNkJY?=
 =?utf-8?B?dUVuZWIxYndlQXZ6dGF3UWtHbDcwWllGWllIUHNkMTQ5S25VZkV1SXNUbWhy?=
 =?utf-8?B?RHh6UnFpUkoxSi9YSWpCUW04TEVMeHR3dE02QVZIMXQrRHlXN0hsZmVhMGs5?=
 =?utf-8?B?aG9GUGx4V0ZzVEI5NC9saGZpd3RlQXFja2FhckliZVBPdythR0k2aEJLRElC?=
 =?utf-8?B?TzFZU0RVTStvb0dFUnRodUNUU3pNK3VGVCtuRjljaEx4QitmTko2eGVuQXJn?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b7c8a-46e0-486d-2371-08dc39059d67
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 09:05:45.9153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpMPiCpFmpryp/HEKdp2jQaWbza5q7uy64fRQSlXU7o3uJk47TgswFx4y8qh3q7gpCzAHlOH7eJM13fabJyAyYh1se1QmhZubV87xUKrY5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6351
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

Hi Bruce,

On 26.12.23 08:58, Bruce Suen wrote:
> [Sie erhalten nicht häufig E-Mails von bruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
> XT26Q04DXXXXX SPI NAND.
> 
> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
> ECC(8bit strength per 512bytes).
> 
> Datasheet Links:
> - http://www.xtxtech.com/download/?AId=458
> - http://www.xtxtech.com/download/?AId=495
> 
> Signed-off-by: Bruce Suen <bruce_suen@163.com>

Below you seem to have written a new driver based on gigadevice.c. Can
you please instead port the existing Linux driver (xtx.c). This will
help us to sync the drivers in the future if new chips will be added.

Thanks
Frieder

> ---
>  drivers/mtd/nand/spi/Makefile |   1 +
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/xtx.c    | 180 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 183 insertions(+)
>  create mode 100644 drivers/mtd/nand/spi/xtx.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 3051de4f7e..e46cfed446 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> 
>  spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
> +spinand-objs += xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 597b088ca7..0b4c067425 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>         &paragon_spinand_manufacturer,
>         &toshiba_spinand_manufacturer,
>         &winbond_spinand_manufacturer,
> +       &xtx_spinand_manufacturer,
>  };
> 
>  static int spinand_manufacturer_match(struct spinand_device *spinand,
> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
> new file mode 100644
> index 0000000000..602861c77b
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/xtx.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Stefan Roese <sr@denx.de>
> + *
> + * Derived from drivers/mtd/nand/spi/micron.c
> + *   Copyright (c) 2016-2017 Micron Technology, Inc.
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/bitfield.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_XTX        0x0B
> +
> +#define XT26XXXD_STATUS_ECC3_ECC2_MASK     GENMASK(7, 6)
> +#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
> +#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
> +#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
> +#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +               SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +               SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = mtd->oobsize / 2;
> +       region->length = mtd->oobsize / 2;
> +
> +       return 0;
> +}
> +
> +static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
> +                                  struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 2;
> +       region->length = mtd->oobsize / 2 - 2;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout = {
> +       .ecc = xt26xxxd_ooblayout_ecc,
> +       .rfree = xt26xxxd_ooblayout_free,
> +};
> +
> +static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
> +                                  u8 status)
> +{
> +       switch (FIELD_GET(STATUS_ECC_MASK, status)) {
> +       case XT26XXXD_STATUS_ECC_NO_DETECTED:
> +               return 0;
> +       case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
> +               return -EBADMSG;
> +       case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, status);
> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
> +               return 8;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct spinand_info xtx_spinand_table[] = {
> +       SPINAND_INFO("XT26G01D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x31),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G11D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x34),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q01D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G02D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x32),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G12D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x35),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q02D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x52),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G04D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x33),
> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q04D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x53),
> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer xtx_spinand_manufacturer = {
> +       .id = SPINAND_MFR_XTX,
> +       .name = "XTX",
> +       .chips = xtx_spinand_table,
> +       .nchips = ARRAY_SIZE(xtx_spinand_table),
> +       .ops = &xtx_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index e8d6feb970..bf7696a981 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> 
>  /**
>   * struct spinand_op_variants - SPI NAND operation variants
> --
> 2.34.1
> 
