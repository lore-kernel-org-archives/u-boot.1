Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCACC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD56787F06;
	Mon, 11 Mar 2024 10:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="S2Cw4Ekv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A19487F01; Mon, 11 Mar 2024 10:13:44 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by phobos.denx.de (Postfix) with ESMTP id 5500387F06
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 From; bh=9S3sWLcSIHirvLRmCohX3Gvc+7aTnK7oMtna/mEFOIc=; b=S2Cw4Ek
 vvvbWVQYyP9lKDoDCq+iwPYbGPEz4/Okdx5942/OG3wqyfPht+jfDJjoKBtbxwQd
 hXnplYMOAE9UJhPYfpmlLW5LYXjBOzg84gWt0MNobn7c/TcOtHDUGZ+/NfDWnb2D
 RSUn4fmQAuXTTK5MqFp7a0cXj/df2AZjC3B8=
Received: from [192.168.107.56] (unknown [113.110.214.249])
 by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD330Yhy+5lTeMABg--.36828S2;
 Mon, 11 Mar 2024 17:13:06 +0800 (CST)
Message-ID: <a61882c7-0003-4c30-ae9a-28bb02a02d4e@163.com>
Date: Mon, 11 Mar 2024 17:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mtd: spinand: Add support for XTX SPINAND
To: Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20240311025434.7270-1-bruce_suen@163.com>
 <ac10f1c9-40e0-4667-90f3-2c2d22e74262@kontron.de>
From: Bruce Sun <bruce_suen@163.com>
In-Reply-To: <ac10f1c9-40e0-4667-90f3-2c2d22e74262@kontron.de>
X-CM-TRANSID: _____wD330Yhy+5lTeMABg--.36828S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Zw1DCF4rWr4xZF13ZrWxCrg_yoWkurWfp3
 98tFyrGr48GF4xW3WxXa1DZr98Zw1xGrW7uw129a4YvFyrK34rZFyxAry3Cr1DG3yxJay3
 Cw4UKryDWa1YyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR04E_UUUUU=
X-Originating-IP: [113.110.214.249]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/xtbBDgOeKGVOCD2cswABsL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 3/11/2024 4:50 PM, Frieder Schrempf wrote:
> Hi Bruce,
>
> On 11.03.24 03:54, Bruce Suen wrote:
>> [Sie erhalten nicht häufig E-Mails vonbruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unterhttps://aka.ms/LearnAboutSenderIdentification  ]
>>
>> Add support for XTX XT26G0xA and XT26xxxD,the driver is ported from
>> linux-6.7.1.
> Please, fix the spelling like this:
>
> Add support for XTX XT26G0xA and XT26xxxD. The driver is ported from
> Linux 6.7.1.
ok,I will change it like this in next version.
>
> Also, did you test this driver in U-Boot with some specific board and
> SPI NAND chip? Then please add the information about your setup to the
> commit message. Thanks!

I have test this drvier on Banana BPI-R3with  XT26G01A and XT26G12D.

I will add this information in next version.

>> Signed-off-by: Bruce Suen<bruce_suen@163.com>
>> ---
>> V1->V2:
>> - remove patch errors
> Checkpatch still produces the following warnings, please fix them!
sorry, I will fix this in next version.
>
> CHECK: Alignment should match open parenthesis
> #90: FILE: drivers/mtd/nand/spi/xtx.c:44:
> +static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                               struct mtd_oob_region *region)
>
> CHECK: Alignment should match open parenthesis
> #102: FILE: drivers/mtd/nand/spi/xtx.c:56:
> +static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
> +                                       struct mtd_oob_region *region)
>
> Thanks
> Frieder
>
>> ---
>>   drivers/mtd/nand/spi/Makefile |   2 +-
>>   drivers/mtd/nand/spi/core.c   |   1 +
>>   drivers/mtd/nand/spi/xtx.c    | 266 ++++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h   |   1 +
>>   4 files changed, 269 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mtd/nand/spi/xtx.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index f172f4787f..65b836b34c 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>
>>   spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
>> -spinand-objs += toshiba.o winbond.o
>> +spinand-objs += toshiba.o winbond.o xtx.o
>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 8ca33459f9..62c28aa422 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -829,6 +829,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>          &toshiba_spinand_manufacturer,
>>          &winbond_spinand_manufacturer,
>>          &esmt_c8_spinand_manufacturer,
>> +       &xtx_spinand_manufacturer,
>>   };
>>
>>   static int spinand_manufacturer_match(struct spinand_device *spinand,
>> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
>> new file mode 100644
>> index 0000000000..6b7b265136
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/xtx.c
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Author:
>> + * Felix Matouschek<felix@matouschek.org>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#ifndef __UBOOT__
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#endif
>> +#include <linux/mtd/spinand.h>
>> +
>> +#define SPINAND_MFR_XTX        0x0B
>> +
>> +#define XT26G0XA_STATUS_ECC_MASK       GENMASK(5, 2)
>> +#define XT26G0XA_STATUS_ECC_NO_DETECTED        (0 << 2)
>> +#define XT26G0XA_STATUS_ECC_8_CORRECTED        (3 << 4)
>> +#define XT26G0XA_STATUS_ECC_UNCOR_ERROR        (2 << 4)
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
>> +static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +                               struct mtd_oob_region *region)
>> +{
>> +       if (section)
>> +               return -ERANGE;
>> +
>> +       region->offset = 48;
>> +       region->length = 16;
>> +
>> +       return 0;
>> +}
>> +
>> +static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
>> +                                       struct mtd_oob_region *region)
>> +{
>> +       if (section)
>> +               return -ERANGE;
>> +
>> +       region->offset = 1;
>> +       region->length = 47;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops xt26g0xa_ooblayout = {
>> +       .ecc = xt26g0xa_ooblayout_ecc,
>> +       .rfree = xt26g0xa_ooblayout_free,
>> +};
>> +
>> +static int xt26g0xa_ecc_get_status(struct spinand_device *spinand,
>> +                                  u8 status)
>> +{
>> +       status = status & XT26G0XA_STATUS_ECC_MASK;
>> +
>> +       switch (status) {
>> +       case XT26G0XA_STATUS_ECC_NO_DETECTED:
>> +               return 0;
>> +       case XT26G0XA_STATUS_ECC_8_CORRECTED:
>> +               return 8;
>> +       case XT26G0XA_STATUS_ECC_UNCOR_ERROR:
>> +               return -EBADMSG;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       /* At this point values greater than (2 << 4) are invalid  */
>> +       if (status > XT26G0XA_STATUS_ECC_UNCOR_ERROR)
>> +               return -EINVAL;
>> +
>> +       /* (1 << 2) through (7 << 2) are 1-7 corrected errors */
>> +       return status >> 2;
>> +}
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
>> +       SPINAND_INFO("XT26G01A",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE1),
>> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    SPINAND_HAS_QE_BIT,
>> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
>> +                                    xt26g0xa_ecc_get_status)),
>> +       SPINAND_INFO("XT26G02A",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE2),
>> +                    NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    SPINAND_HAS_QE_BIT,
>> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
>> +                                    xt26g0xa_ecc_get_status)),
>> +       SPINAND_INFO("XT26G04A",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE3),
>> +                    NAND_MEMORG(1, 2048, 64, 128, 2048, 40, 1, 1, 1),
>> +                    NAND_ECCREQ(8, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    SPINAND_HAS_QE_BIT,
>> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
>> +                                    xt26g0xa_ecc_get_status)),
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
>> index 6f479fa5ad..13b5a52f8b 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>>   extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>>   extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>>   extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
>> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
>>
>>   /**
>>    * struct spinand_op_variants - SPI NAND operation variants
>> --
>> 2.34.1
>>
