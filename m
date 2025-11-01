Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E78CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 05:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EEB83A32;
	Sat,  1 Nov 2025 06:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NkQ9Clfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB22483A3B; Sat,  1 Nov 2025 06:17:53 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3E483A2B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 06:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso2174780a12.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761974269; x=1762579069; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCRq5GK6oFbZKQEekwfi/cXz3fEdjBm8EKgxgPXxo8M=;
 b=NkQ9ClflgLJooRlPISi14Q5KEfjxU1pAWP1JTci2447MSe1UMnsjasvKzDPvV9gw/C
 ONtvIAqFrVNqZZ6HZ3GJaHyEynRkEcnwR3rAsRKO8Z8edE/HUcgXjvYvMgbXTS0H7bnr
 p5pxTJo+jFW+R1sr7S/QCKxKM3XP/7nCvW/LhkJ2KYHzDhVhGVrx1g6q7RSN1qvhXz6K
 2v+0L7VzQkEIy+K1AUdTo2ImKBFA1oe57dlqwS8MR5c3ukwkCcQ7W4VPe/8beFof17tX
 70lUa0P0sNQxTdYbora5OvYWLvVn+v6ug3CjFQBO6AGqTnqpo6x2TqdjrqY4QBeADyI1
 tRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761974269; x=1762579069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BCRq5GK6oFbZKQEekwfi/cXz3fEdjBm8EKgxgPXxo8M=;
 b=rk86r+rOqeFXiQ29/WDP9nbQ3G2HLZcGzE2+m13bMMzJj4nl02u5WeyO84OJ8svthI
 OJAPLKia8XpG5Slzt6wrg2llwX5oWGvjDdnSWoxVYEIH4rf85V9g82pCL6snv2Kg1Aal
 CHR+b9SURSwZs0/GV1MAKUtbjSRVVTfWfqBSSNandx1MYYLLo9QVggXJrG7+QJGoZk01
 4u0uDj/+0pmJrV/wzg/12XJMptwL0mOvwhM4Wo4kaoHC85xwGw8Tg/oZ/e9DaTYLLewT
 Im2AI3hPS+Jg3w+rjm0KcSMdEKECdG6d6Oax9fL3D3EERGdym6+3f8iuUKCAEuohNitc
 ztvg==
X-Gm-Message-State: AOJu0YxAc7xQcOUZVf0XUP5tlESmv7u3OUE/7+ES6ei7KVhV0SJShSyz
 T7EZTUkpCv/JWhvFO907De2RzPCLhgodDNoUvM9H+SbAX9LLh5ymNd74hu9JkG8YCNw=
X-Gm-Gg: ASbGncvULajgFOtNLBJDSC2qzYxJa5YyenAPQ5tOUc13+PXv5AyXceMyrfqI2+59TBE
 4PdtmEW/sXc1KVKtCCEXC9BUaLXos3VW7UK6bSbIObEjsV5kV7eXgbEiWq4QKeex6w91QxGOjPe
 okzcN+G1lrjhIkcgkoso/Vb8EmXzA+ef/U5ShfNrt6SC4XHTSE9Yhd+sdQcwZaPkY3tNbgZhQ2U
 V5nlQlEUd4Wv8lYgp4+w9KnIoEENtfiVuRVscVd/MOu0v/c1BAbpS6/npzb6Dxb/bnhqYDCmydm
 8VeSWJ6V8jmFSFSpPUsdmL3PqPsgVtn6jDNjZfArJSyWoRhw19XQjoEbQvemNKm+RQTIzUCC016
 Vjwy9SrfwkxREO/r5fud/gToVBLJT9h0WRRr43ORryBIuAAvCSkYTfaJmXN1i3jg=
X-Google-Smtp-Source: AGHT+IGBekio/jZXiCpyxYGKTlxR8Wagq/T24k5crGfdm2OnAHX5lAgd/iB4HbmZq+fkDYRjXDVwQw==
X-Received: by 2002:a17:902:d48b:b0:28d:18fb:bb93 with SMTP id
 d9443c01a7336-2951a35eb15mr76818705ad.7.1761974268543; 
 Fri, 31 Oct 2025 22:17:48 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7dbc5aa56sm4019252b3a.68.2025.10.31.22.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 22:17:48 -0700 (PDT)
Message-ID: <1dc06885-fc35-4114-a73f-8ebea199359d@gmail.com>
Date: Sat, 1 Nov 2025 13:17:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: u-boot@lists.denx.de
References: <20251030190710.18848-1-cnsztl@gmail.com>
 <37d46274-8b4c-4794-bc83-4b6ce5a4714b@iopsys.eu>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <37d46274-8b4c-4794-bc83-4b6ce5a4714b@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Mikhail,

On 2025/11/1 12:20, Mikhail Kshevetskiy wrote:
> Hello Tianling, You forget to add fmsh manufacturer to
> drivers/mtd/nand/spi/core.c and include/linux/mtd/spinand.h files.
> Without these changes your code should not be used. Regards, Mikhail
> Kshevetskiy

Oops sorry for the mistake! I forgot to do that when rebasing the patch.
Will send v2 soon, thank you!

 > Please also replace spaces with tab where possible

I already used tab for indentation, and the patchwork[1] does show it in 
tab format.

Thanks,
Tianling.

1. 
https://patchwork.ozlabs.org/project/uboot/patch/20251030190710.18848-1-cnsztl@gmail.com/

> 
> On 10/30/25 22:07, Tianling Shen wrote:
>> [You don't often get email from cnsztl@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Add support for FudanMicro FM25S01A SPI NAND.
>>
>> This driver is ported from linux v6.18 and tested on a MT7981 board.
>>
>> Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   drivers/mtd/nand/spi/Makefile |  2 +-
>>   drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 77 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mtd/nand/spi/fmsh.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index 152aa1a3783c..a7a0b2cb4b9e 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>
>>   spinand-objs := core.o otp.o
>> -spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
>> +spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>>   spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
>> new file mode 100644
>> index 000000000000..84a567919ebb
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/fmsh.c
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
>> + *
>> + * Author: Dingqiang Lin <jon.lin@rock-chips.com>
>> + */
>> +
>> +#ifndef __UBOOT__
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#endif
>> +#include <linux/mtd/spinand.h>
>> +
>> +#define SPINAND_MFR_FMSH               0xA1
>> +
>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>> +               SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
>> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>> +
>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
>> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
>> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>> +
>> +static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +                                 struct mtd_oob_region *region)
>> +{
>> +       return -ERANGE;
>> +}
>> +
>> +static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
>> +                                  struct mtd_oob_region *region)
>> +{
>> +       if (section)
>> +               return -ERANGE;
>> +
>> +       region->offset = 2;
>> +       region->length = 62;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
>> +       .ecc = fm25s01a_ooblayout_ecc,
>> +       .rfree = fm25s01a_ooblayout_free,
>> +};
>> +
>> +static const struct spinand_info fmsh_spinand_table[] = {
>> +       SPINAND_INFO("FM25S01A",
>> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
>> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>> +                    NAND_ECCREQ(1, 512),
>> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +                                             &write_cache_variants,
>> +                                             &update_cache_variants),
>> +                    SPINAND_HAS_QE_BIT,
>> +                    SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
>> +};
>> +
>> +static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
>> +};
>> +
>> +const struct spinand_manufacturer fmsh_spinand_manufacturer = {
>> +       .id = SPINAND_MFR_FMSH,
>> +       .name = "Fudan Micro",
>> +       .chips = fmsh_spinand_table,
>> +       .nchips = ARRAY_SIZE(fmsh_spinand_table),
>> +       .ops = &fmsh_spinand_manuf_ops,
>> +};
>> --
>> 2.51.1
>>

