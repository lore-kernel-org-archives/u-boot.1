Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22566C54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 09:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3644F87D1E;
	Thu, 29 Feb 2024 10:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="KqMsQ8OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E680D88070; Thu, 29 Feb 2024 10:24:27 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by phobos.denx.de (Postfix) with ESMTP id 0AD088785E
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 10:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=6NOziyeqoWfSCIgpWMoUTul4VwUf1qpFJR9+kbdYbyg=;
 b=KqMsQ8OMinZa3fqHdk9bJQyZZuOw0EwsuwtLdzKzIiEyrDaKVs/9o8pnbLe+aP
 lF8evjlNVr09M+0b9rcnngGzB5wcWLNObJ+GwKfu2UAQXU/bHHF/08ScmsM9Dxci
 zfJQmJYTfBm77vjFewiQWSIq/RbMHY7JaWsUEK8Lh+lgE=
Received: from [192.168.107.56] (unknown [119.123.53.62])
 by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wAXFyw3TeBl8iXMBA--.5110S2; 
 Thu, 29 Feb 2024 17:24:09 +0800 (CST)
Message-ID: <6ee1a870-6e4e-4ca0-8a12-89f1ef8e9dcf@163.com>
Date: Thu, 29 Feb 2024 17:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
To: Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20231226075812.3803-1-bruce_suen@163.com>
 <e4849e34-a8e1-487d-86c4-638b1c19e53d@kontron.de>
From: Bruce Sun <bruce_suen@163.com>
In-Reply-To: <e4849e34-a8e1-487d-86c4-638b1c19e53d@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXFyw3TeBl8iXMBA--.5110S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1rAF4xGrWrtr4Dtw15CFg_yoWftFyxpa
 4ktF4rKF4UG3W7Wa4jq3WDZr98Xw1xGrW7ur129342qr9YkwnIvFZrCry3CrZrC3WUJayx
 uw4jgr9xWw4YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRiSdkUUUUU=
X-Originating-IP: [119.123.53.62]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/1tbiMRuTKGVOBzCu9QAAsW
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

Thans for your advice, I will port the driver from linux driver(xtx.c) 
later.

On 2/29/2024 5:05 PM, Frieder Schrempf wrote:
> Hi Bruce,
>
> On 26.12.23 08:58, Bruce Suen wrote:
>> [Sie erhalten nicht häufig E-Mails von bruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
>> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
>> XT26Q04DXXXXX SPI NAND.
>>
>> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
>> ECC(8bit strength per 512bytes).
>>
>> Datasheet Links:
>> - http://www.xtxtech.com/download/?AId=458
>> - http://www.xtxtech.com/download/?AId=495
>>
>> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> Below you seem to have written a new driver based on gigadevice.c. Can
> you please instead port the existing Linux driver (xtx.c). This will
> help us to sync the drivers in the future if new chips will be added.
>
> Thanks
> Frieder
>
>> ---
>>   drivers/mtd/nand/spi/Makefile |   1 +
>>   drivers/mtd/nand/spi/core.c   |   1 +
>>   drivers/mtd/nand/spi/xtx.c    | 180 ++++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h   |   1 +
>>   4 files changed, 183 insertions(+)
>>   create mode 100644 drivers/mtd/nand/spi/xtx.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index 3051de4f7e..e46cfed446 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>
>>   spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
>> +spinand-objs += xtx.o
>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 597b088ca7..0b4c067425 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>          &paragon_spinand_manufacturer,
>>          &toshiba_spinand_manufacturer,
>>          &winbond_spinand_manufacturer,
>> +       &xtx_spinand_manufacturer,
>>   };
>>
>>   static int spinand_manufacturer_match(struct spinand_device *spinand,
>> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
>> new file mode 100644
>> index 0000000000..602861c77b
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/xtx.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Stefan Roese <sr@denx.de>
>> + *
>> + * Derived from drivers/mtd/nand/spi/micron.c
>> + *   Copyright (c) 2016-2017 Micron Technology, Inc.
>> + */
>> +
>> +#ifndef __UBOOT__
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#endif
>> +#include <linux/bitfield.h>
>> +#include <linux/mtd/spinand.h>
>> +
>> +#define SPINAND_MFR_XTX        0x0B
>> +
>> +#define XT26XXXD_STATUS_ECC3_ECC2_MASK     GENMASK(7, 6)
>> +#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
>> +#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
>> +#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
>> +#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
>> +
>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>> +               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>> +               SPINAND_PROG_LOAD(true, 0, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>> +               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>> +               SPINAND_PROG_LOAD(false, 0, NULL, 0));
>> +
>> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +                                 struct mtd_oob_region *region)
>> +{
>> +       if (section)
>> +               return -ERANGE;
>> +
>> +       region->offset = mtd->oobsize / 2;
>> +       region->length = mtd->oobsize / 2;
>> +
>> +       return 0;
>> +}
>> +
>> +static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
>> +                                  struct mtd_oob_region *region)
>> +{
>> +       if (section)
>> +               return -ERANGE;
>> +
>> +       region->offset = 2;
>> +       region->length = mtd->oobsize / 2 - 2;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout = {
>> +       .ecc = xt26xxxd_ooblayout_ecc,
>> +       .rfree = xt26xxxd_ooblayout_free,
>> +};
>> +
>> +static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
>> +                                  u8 status)
>> +{
>> +       switch (FIELD_GET(STATUS_ECC_MASK, status)) {
>> +       case XT26XXXD_STATUS_ECC_NO_DETECTED:
>> +               return 0;
>> +       case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
>> +               return -EBADMSG;
>> +       case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
>> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, status);
>> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
>> +               return 8;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +static const struct spinand_info xtx_spinand_table[] = {
>> +       SPINAND_INFO("XT26G01D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x31),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26G11D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x34),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26Q01D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26G02D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x32),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26G12D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x35),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26Q02D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x52),
>> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26G04D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x33),
>> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +       SPINAND_INFO("XT26Q04D",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x53),
>> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    0,
>> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
>> +                                    xt26xxxd_ecc_get_status)),
>> +};
>> +
>> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
>> +};
>> +
>> +const struct spinand_manufacturer xtx_spinand_manufacturer = {
>> +       .id = SPINAND_MFR_XTX,
>> +       .name = "XTX",
>> +       .chips = xtx_spinand_table,
>> +       .nchips = ARRAY_SIZE(xtx_spinand_table),
>> +       .ops = &xtx_spinand_manuf_ops,
>> +};
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index e8d6feb970..bf7696a981 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_spinand_manufacturer;
>>   extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>>   extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>>   extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
>>
>>   /**
>>    * struct spinand_op_variants - SPI NAND operation variants
>> --
>> 2.34.1
>>

