Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EEEC54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 15:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACB2880DB;
	Thu, 29 Feb 2024 16:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="AWJVy/uX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC6F87C61; Thu, 29 Feb 2024 16:51:44 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965A8880E9
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 16:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcY0MotlZ+K3bzriD0oWoJbjugagDOv2rF6Dmb2/ftUjWUW7gb+AFBtLgw95L89+ruVgTOjytR3NAvT/OSDteOKcSBUQSh4tA+gvk72XcsBk+O9SW0W8Zi2yeGIAzexxqlAX8RNdweW7VyhqC8H/7VG/SelsIzNSl8klkl92lwFQJAz5yFL7ErhH7dY71qrfOYfKWeCj41X8QmA2sRB6b50/drp9obbEBgOWyIQVbYkRZoN1FGOX4xXIBtV7H+4hJ5DJvCH9iJCm+HDihH+xHAbx8IU+kanajt2TtJI3wTilAmYmBWcEewXfPP1LmWYNnaNicpWWe0UwA87cIB4DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSHptomF2J+GePTm1L1aiTk24Z6pwBwnLE5BBvnvmfc=;
 b=e4bbQjCeuEyXANXEx50s9UoYSV+wLDVOwiZKyIaBoxfjCOVBG/baN303rjAiygsWW7B0s/7YPCg6qRZNhUUSQEZM5qwVLBZa8VhaIBXXMlU2MRHfXT0OjnO+eQYosWpF7r+vUimEA1mYarN1Qra6jqQPey4BqpxNNNhDDMT4IQsqixFGT7ruNSHidd6x6MMiDELn5ZQos8zT5d/vYfhIbcMoeYlyue6m+AsGcUuFufbwt+nk6c0/5PMIB3fWBgMlFM4zdBAu6wz/SJUSi4bYA/LLzQUg1pjSxFS7YuzFeq8F0tTe88tQ0trVJV6CqEWW3hbOXd+hYAOnLNHNzNWvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSHptomF2J+GePTm1L1aiTk24Z6pwBwnLE5BBvnvmfc=;
 b=AWJVy/uXI3RTYnhPHsfO2EiQD/ru3Ab3Oe2RSnKGuKNUbFTrIOcvtECMLPwFkvm9sXGXAULopL0IK2v59DOVmXXcJ2/T9XKyZtc3+75NsAKoeBUoofLqIEAZewZDqFYKppWZ19N/CvFUoVylcDxTmrXHZNIAqS5qU6y6O5xFWeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:51:39 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 15:51:39 +0000
Message-ID: <cdff8766-6ad1-4f7b-b6ba-b503a9840780@kontron.de>
Date: Thu, 29 Feb 2024 16:51:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
Content-Language: en-US, de-DE
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Bruce Sun <bruce_suen@163.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20231226075812.3803-1-bruce_suen@163.com>
 <e4849e34-a8e1-487d-86c4-638b1c19e53d@kontron.de>
 <6ee1a870-6e4e-4ca0-8a12-89f1ef8e9dcf@163.com>
 <CAOf5uwmAauz7+bj9KdGheqzPK_i5SSx-Dfc74rP3yL_esQfYEg@mail.gmail.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOf5uwmAauz7+bj9KdGheqzPK_i5SSx-Dfc74rP3yL_esQfYEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3815:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c73aba-c325-453c-6a1e-08dc393e5124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egzf2nkoz9HDmyyzhOl5ZZbP2CLi2Q6T0HgE3L04W7hRYCAa5nFrRMbh1P2Bz65HNk/4XyhMI5S6PKwNtJWToZh3FLTyzkq8zZUca95HYmUe5Ivb7OqJMeirdsYNie6CA9ajX8rY55GAiyDDc5WMf3l8g1UOROAa3iwGaxD74cej/97U8RM9F0YBuNLdRkUBPLm2OtUO6OJz3oGht4xtm+Fh3fFi8RKPBZ5fs14VehZCGW5EetlrFE93SuRJbqhwrqmWQV3h/dTyLj6rNBinibfqRPLB+VYHH4k4vQPBqf8Sczsanqeltm098dC7xwQ0Ztp12IjLGn+RXfpHvA2nKm9kKvjHirSzp8OElvceeODZYfEeZUAv/KbWbSQoeA3QgUvmw4QsFqS3C3vr9bjVlVAfzgAeqJ8ePZblrLA9UyiKLZF/dkZjIDdsBIh3+YzitLE9zfnUCOaRFXLZGPuwvath6cJTtEWzdiDFIIySVYcMM1WMOvtQdnTzevGgeAABeGbNfl4EngI1n5Uor5UgpjKpZxJJNe+lw1iAwJnuptW7OvXftPqs2HoqlJFCEmw6GGzEaO/oWZrKniCfUIu8rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhBNWljSkI2VXpsMDZTTXRQUzlVZ2RRaW9RdHU0ZUdkZlBDUmlrWGxKTXJQ?=
 =?utf-8?B?ejZIcnhESGo4T0I2ZTBZbWNjV2tjTHB3bmVtSTJvSTF3dlV3d0tEdWlQa0c0?=
 =?utf-8?B?Z0RSUlpVQ0hsY0VGS0RqaUY1ZTM0azJzTFFCdk52WU00QlJJSDRZRm41aTgv?=
 =?utf-8?B?Umc4b2lqU0xtbEtmNFdSWW9ZQUxuNkoyZjZBa29qeDRCT0xaL0QxQ2l5WjVT?=
 =?utf-8?B?Z1dHOXNNNHoyNUxkMytmNTN1Y24rdnNFZDYyOW1ub1NOK1FmcmR5cmU0d0tr?=
 =?utf-8?B?eFdpb0pDUVF1MXhZc0tEOXkxNzRUMEdPdHFmUnN6RitOL1hSeGt4b0g5YnJW?=
 =?utf-8?B?VlczQ2w1ZDg2SkdGWVR6K0p4TW10VENGeEVDT1cwbFVpakIxRlkyWGtST1FH?=
 =?utf-8?B?S2VqclE2dDNJSXlqQzRzUkh1azVwa2NNdk12eC9obDloZ09sT2I5ejdnNUNw?=
 =?utf-8?B?YmJBMEU5SStxQ1B3eEdTbjg1dXRPc0U0d2JWYVhTaG83SzA5YXQrQzZFaEdX?=
 =?utf-8?B?QThmL29FeFFPU1g2RWQyNE5RRlJHVncwcGJWUGlPVVVYMFFJN0xlaldvYXdL?=
 =?utf-8?B?Szc5RnVKMW0xS0VXUkZ3ajRjelJBTTVuTnhLcGhaVVBiQ1JxN1lMM05oaHpp?=
 =?utf-8?B?T2dFQkdkRy9YOTdLWS9FVFNzZUcxNTdvZEVkd01GM0VZcEVDdjN5YWpzMlFN?=
 =?utf-8?B?SWk2U1JZUU4vVXVZY0N2Qm92NVJvdkYxRHk5aXY2K01icEU5QlNscW54aDhv?=
 =?utf-8?B?Skg5YkpRMGNMcDEzamY4c2NuWlU2R0Zpcnp2dUdKNWV2QWVVa0RwSjBzaGkv?=
 =?utf-8?B?NTI1cnpjMEpIYmVzekIyaGdmS3VFZWkzMWVLK3Z6TnBGMHpzenNtd2VHMjRI?=
 =?utf-8?B?ekMxaW1Qd3l0ejhGaDhPb0NBNEM0OUttS0hlekxGS0dzNWpVaHg3NGtZblRC?=
 =?utf-8?B?em83cFI0K0krdG80UFJvNWlLeUF2SzkzYkttc0NlM2ZlSkZRSk9FdGhsT0Fv?=
 =?utf-8?B?dmVGblcyT2p6d042UWdIL3dTUnNFQlBYR3hEZVRyUi95ZUJrVnMwUE9qWnZn?=
 =?utf-8?B?bmphSXNVckVqK3ZieXZUak8wWWNsNG90dldFWkZKOGRpc2d1QmhqU2dBT1hC?=
 =?utf-8?B?cnVVU0hqNVhidTh6eVRES2JNMVVDa3JKNm5ka2FGbStXV3E0dkFOZytEaGQx?=
 =?utf-8?B?RW1xQXBCSjRyRVk2Q3NHTGUvRURST1RUNGI1cHVWUmlGb1FXR05EVGpLaXZp?=
 =?utf-8?B?UldPRm5VOVI1WUJsWFpqQkVIN3VCMGxzMU5GbFZxckZWb3Z0VkxEWklFdVI4?=
 =?utf-8?B?VDY3ZWJoNHk0elN5WHdQenhpSkFqOENOc2d1V3ozU2NnbDNMZDF5N2Z6RmVY?=
 =?utf-8?B?MlFwZFpKR2lSK3pJMkxPVGtQazE3M2FRckFCVXdGNWMyM2hMbFIwM0g4akFY?=
 =?utf-8?B?TWpZbmV3OCsvV1dmWmFna1NKdnJpalVMYnhSTDdXcTlQYkxZWTVTN2xlOGpk?=
 =?utf-8?B?enpjZERaZ0VyYjNlVWJCWTZBeFlsMEptSitYdTE5ZjBwWXlra1JEQWxsQjQ5?=
 =?utf-8?B?ZW5IVkFHRDlXL1pJQ3FkVHQ0ZXNyQ1l2MzJTQ1pIbk1qSzhWaHZ1TXk5RHRh?=
 =?utf-8?B?RmFpMFczdGJqTkNaWEJEU2hISU5JZnR0Qk5BNjcxN3NVL2FUOGlqcG55WjhE?=
 =?utf-8?B?UUYzWEY0VVBaM21PM2UzUzh5d2NVMDJKODk3YzBHbTZzNjJkdXAyNzRYUDFj?=
 =?utf-8?B?eTVtaTU4ZWd6ejdyMDVzRDR6UWdXUGtEUUl2VXF3Q0NBaWdFMW15dUEyVnRx?=
 =?utf-8?B?OTB1UzVrbzY4RnB5c2RzU0lrYWJVQUdWaElWMHQ1TjJiMzZZOVVXam1tUHJ1?=
 =?utf-8?B?NERzK3FjcG1pTHd6NElXV096bkVlMEYrZGR0S2dib0E3cUJxak9wRnhwWXZx?=
 =?utf-8?B?U0VkVW5OeDgxeWhSL1pFSVh1ZTlYdEFtcWhFOW5QQ2ZPUER4ZFlPbUIyT0xq?=
 =?utf-8?B?c2RwTU56MUNaWEJzaHBFWjd5bDM0d1BDS25DTXRLUllEVUpPcjREZTRZLzZs?=
 =?utf-8?B?ak5BR1RuTzFPM1lMZWZjdU1ueHBzb0VuZEt4ZFFKdklQazY0b1Y0TVBYejJU?=
 =?utf-8?B?SmMxYkJvbXNnR0tldmZKVTV6OGNZNktZWlVwTW9iQjlFblpURS8wR1kwUjhW?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c73aba-c325-453c-6a1e-08dc393e5124
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:51:39.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7ZTlqbWPEbNYkfFTnGRzJNQNRnELMJb7iIXGHoCNqe6un0r/X0KvOt6SJ5nj/0pLo4+/gDtD+W85tG6FasePdVG9sbLjr/toQt1iuMqsp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3815
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

Hi Michael,

On 29.02.24 16:45, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> I will ask dario to pick them up. I wil review too We have a bunch of
> patches to get in nand-next

Ok, thanks. But please wait until Bruce sends a new version based on the
Linux driver as I have asked him to do that.

Thanks
Frieder

> 
> Michael
> 
> On Thu, Feb 29, 2024 at 10:24 AM Bruce Sun <bruce_suen@163.com> wrote:
>>
>> Thans for your advice, I will port the driver from linux driver(xtx.c)
>> later.
>>
>> On 2/29/2024 5:05 PM, Frieder Schrempf wrote:
>>> Hi Bruce,
>>>
>>> On 26.12.23 08:58, Bruce Suen wrote:
>>>> [Sie erhalten nicht häufig E-Mails von bruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
>>>> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
>>>> XT26Q04DXXXXX SPI NAND.
>>>>
>>>> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
>>>> ECC(8bit strength per 512bytes).
>>>>
>>>> Datasheet Links:
>>>> - http://www.xtxtech.com/download/?AId=458
>>>> - http://www.xtxtech.com/download/?AId=495
>>>>
>>>> Signed-off-by: Bruce Suen <bruce_suen@163.com>
>>> Below you seem to have written a new driver based on gigadevice.c. Can
>>> you please instead port the existing Linux driver (xtx.c). This will
>>> help us to sync the drivers in the future if new chips will be added.
>>>
>>> Thanks
>>> Frieder
>>>
>>>> ---
>>>>   drivers/mtd/nand/spi/Makefile |   1 +
>>>>   drivers/mtd/nand/spi/core.c   |   1 +
>>>>   drivers/mtd/nand/spi/xtx.c    | 180 ++++++++++++++++++++++++++++++++++
>>>>   include/linux/mtd/spinand.h   |   1 +
>>>>   4 files changed, 183 insertions(+)
>>>>   create mode 100644 drivers/mtd/nand/spi/xtx.c
>>>>
>>>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>>>> index 3051de4f7e..e46cfed446 100644
>>>> --- a/drivers/mtd/nand/spi/Makefile
>>>> +++ b/drivers/mtd/nand/spi/Makefile
>>>> @@ -1,4 +1,5 @@
>>>>   # SPDX-License-Identifier: GPL-2.0
>>>>
>>>>   spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
>>>> +spinand-objs += xtx.o
>>>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>>> index 597b088ca7..0b4c067425 100644
>>>> --- a/drivers/mtd/nand/spi/core.c
>>>> +++ b/drivers/mtd/nand/spi/core.c
>>>> @@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>>>          &paragon_spinand_manufacturer,
>>>>          &toshiba_spinand_manufacturer,
>>>>          &winbond_spinand_manufacturer,
>>>> +       &xtx_spinand_manufacturer,
>>>>   };
>>>>
>>>>   static int spinand_manufacturer_match(struct spinand_device *spinand,
>>>> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
>>>> new file mode 100644
>>>> index 0000000000..602861c77b
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/nand/spi/xtx.c
>>>> @@ -0,0 +1,180 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2018 Stefan Roese <sr@denx.de>
>>>> + *
>>>> + * Derived from drivers/mtd/nand/spi/micron.c
>>>> + *   Copyright (c) 2016-2017 Micron Technology, Inc.
>>>> + */
>>>> +
>>>> +#ifndef __UBOOT__
>>>> +#include <linux/device.h>
>>>> +#include <linux/kernel.h>
>>>> +#endif
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/mtd/spinand.h>
>>>> +
>>>> +#define SPINAND_MFR_XTX        0x0B
>>>> +
>>>> +#define XT26XXXD_STATUS_ECC3_ECC2_MASK     GENMASK(7, 6)
>>>> +#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
>>>> +#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
>>>> +#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
>>>> +#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
>>>> +
>>>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>>>> +               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>>>> +
>>>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>>>> +               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>>>> +               SPINAND_PROG_LOAD(true, 0, NULL, 0));
>>>> +
>>>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>>>> +               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>>>> +               SPINAND_PROG_LOAD(false, 0, NULL, 0));
>>>> +
>>>> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>> +                                 struct mtd_oob_region *region)
>>>> +{
>>>> +       if (section)
>>>> +               return -ERANGE;
>>>> +
>>>> +       region->offset = mtd->oobsize / 2;
>>>> +       region->length = mtd->oobsize / 2;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
>>>> +                                  struct mtd_oob_region *region)
>>>> +{
>>>> +       if (section)
>>>> +               return -ERANGE;
>>>> +
>>>> +       region->offset = 2;
>>>> +       region->length = mtd->oobsize / 2 - 2;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout = {
>>>> +       .ecc = xt26xxxd_ooblayout_ecc,
>>>> +       .rfree = xt26xxxd_ooblayout_free,
>>>> +};
>>>> +
>>>> +static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
>>>> +                                  u8 status)
>>>> +{
>>>> +       switch (FIELD_GET(STATUS_ECC_MASK, status)) {
>>>> +       case XT26XXXD_STATUS_ECC_NO_DETECTED:
>>>> +               return 0;
>>>> +       case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
>>>> +               return -EBADMSG;
>>>> +       case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
>>>> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, status);
>>>> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
>>>> +               return 8;
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       return -EINVAL;
>>>> +}
>>>> +
>>>> +static const struct spinand_info xtx_spinand_table[] = {
>>>> +       SPINAND_INFO("XT26G01D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x31),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26G11D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x34),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26Q01D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26G02D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x32),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26G12D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x35),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26Q02D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x52),
>>>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26G04D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x33),
>>>> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +       SPINAND_INFO("XT26Q04D",
>>>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x53),
>>>> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>>>> +                    NAND_ECCREQ(8, 512),
>>>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>>> +                                             &write_cache_variants,
>>>> +                                             &update_cache_variants),
>>>> +                    0,
>>>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>>>> +                                    xt26xxxd_ecc_get_status)),
>>>> +};
>>>> +
>>>> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
>>>> +};
>>>> +
>>>> +const struct spinand_manufacturer xtx_spinand_manufacturer = {
>>>> +       .id = SPINAND_MFR_XTX,
>>>> +       .name = "XTX",
>>>> +       .chips = xtx_spinand_table,
>>>> +       .nchips = ARRAY_SIZE(xtx_spinand_table),
>>>> +       .ops = &xtx_spinand_manuf_ops,
>>>> +};
>>>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>>>> index e8d6feb970..bf7696a981 100644
>>>> --- a/include/linux/mtd/spinand.h
>>>> +++ b/include/linux/mtd/spinand.h
>>>> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_spinand_manufacturer;
>>>>   extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>>>>   extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>>>>   extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>>>> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
>>>>
>>>>   /**
>>>>    * struct spinand_op_variants - SPI NAND operation variants
>>>> --
>>>> 2.34.1
>>>>
>>
> 
> 
