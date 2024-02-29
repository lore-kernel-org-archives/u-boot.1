Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E319BC54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 15:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A4F880DE;
	Thu, 29 Feb 2024 16:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W5pbrfaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E04880E5; Thu, 29 Feb 2024 16:46:04 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD04880DB
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 16:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so1642010a12.1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1709221561; x=1709826361;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWkMsWsehWIipPebziKK5EfA6MG4W6ZpsRG5dDheSfg=;
 b=W5pbrfawhBsANLR0EK97ohAVoyXTfWfbtECvn0bGm8kOfx6U/aNUFnfF7g2HGLm6RS
 2fopcFDiUiIS599lHVn6uiG1Q//eof0w+NjW45/0W1R8+IIDjvigUMKTAw5yh4apgL0g
 mWEDIXuNMPWdQDFZe1BdM8UhEZLY+LQOVIlI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709221561; x=1709826361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWkMsWsehWIipPebziKK5EfA6MG4W6ZpsRG5dDheSfg=;
 b=fcMkXe5oG2aRixpWWdwflFl4D4B5Zm/tOWG1K4l6G4pAqNgSY6aUJMfVM6yPLrnyKk
 l6MpbZXMFTdOPFHsqEpU2U2em2cgv7EHaoC5VjX5pXK5LhihdCAulvIkC4i42FA4imri
 N/6lSUoyOP7HKE7X7/xsLpQnG6+Tv7fke75ZqxpXsGnPK2a5sciY6W50omC+x46Wj91o
 djZ97J0xcJoL8qJ/2DVEcuIrJrdqbVV5QBfyz3Ms5zfLHtAe4FkfMGHr2IRZo3WX1Eli
 n2cgNcaaeudKt1tG0LlmKlsIVo8cps7tb/CCC61lP66y/rxihIiSQXPrbeRtOugoTyOk
 8gbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaq8L3E2P12peYuoPKBCLTTE7KRu2SfkMlhNuRA7VT36UayoVLDatftgcnVvWrWhZs/nunYZCmRFFqesqqqXjt0DMssQ==
X-Gm-Message-State: AOJu0Yx8iLyeIRrD4A+nrArQtUeRcd7RhUTwFf0RQZdHmrf/PbN090wK
 jLkXG6Fvun4lq9FFVWYQmQ1/n7AUjXcAg3dZYKg1wthlc26RT5+YyrquVJiapUDWoY5rTQ4VARc
 TtKYb5ZLunmacExuUM3iRjZKtD72Vl43t4xFLew==
X-Google-Smtp-Source: AGHT+IEDSCH9wgVW3tYHgDmBl2idtmEq344y5q2paVPeMG1Tpj/xwlkeGbAIX9Q2cDZapWJjYp2lMb7NbxRWWxSoTS8=
X-Received: by 2002:a17:906:e2d4:b0:a44:1b86:49d5 with SMTP id
 gr20-20020a170906e2d400b00a441b8649d5mr1559650ejb.67.1709221560758; Thu, 29
 Feb 2024 07:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20231226075812.3803-1-bruce_suen@163.com>
 <e4849e34-a8e1-487d-86c4-638b1c19e53d@kontron.de>
 <6ee1a870-6e4e-4ca0-8a12-89f1ef8e9dcf@163.com>
In-Reply-To: <6ee1a870-6e4e-4ca0-8a12-89f1ef8e9dcf@163.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 29 Feb 2024 16:45:49 +0100
Message-ID: <CAOf5uwmAauz7+bj9KdGheqzPK_i5SSx-Dfc74rP3yL_esQfYEg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
To: Bruce Sun <bruce_suen@163.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de, 
 dario.binacchi@amarulasolutions.com, jagan@amarulasolutions.com, 
 bruce.sun@xtxtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

I will ask dario to pick them up. I wil review too We have a bunch of
patches to get in nand-next

Michael

On Thu, Feb 29, 2024 at 10:24=E2=80=AFAM Bruce Sun <bruce_suen@163.com> wro=
te:
>
> Thans for your advice, I will port the driver from linux driver(xtx.c)
> later.
>
> On 2/29/2024 5:05 PM, Frieder Schrempf wrote:
> > Hi Bruce,
> >
> > On 26.12.23 08:58, Bruce Suen wrote:
> >> [Sie erhalten nicht h=C3=A4ufig E-Mails von bruce_suen@163.com. Weiter=
e Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/Le=
arnAboutSenderIdentification ]
> >>
> >> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX=
,
> >> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
> >> XT26Q04DXXXXX SPI NAND.
> >>
> >> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
> >> ECC(8bit strength per 512bytes).
> >>
> >> Datasheet Links:
> >> - http://www.xtxtech.com/download/?AId=3D458
> >> - http://www.xtxtech.com/download/?AId=3D495
> >>
> >> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> > Below you seem to have written a new driver based on gigadevice.c. Can
> > you please instead port the existing Linux driver (xtx.c). This will
> > help us to sync the drivers in the future if new chips will be added.
> >
> > Thanks
> > Frieder
> >
> >> ---
> >>   drivers/mtd/nand/spi/Makefile |   1 +
> >>   drivers/mtd/nand/spi/core.c   |   1 +
> >>   drivers/mtd/nand/spi/xtx.c    | 180 ++++++++++++++++++++++++++++++++=
++
> >>   include/linux/mtd/spinand.h   |   1 +
> >>   4 files changed, 183 insertions(+)
> >>   create mode 100644 drivers/mtd/nand/spi/xtx.c
> >>
> >> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Make=
file
> >> index 3051de4f7e..e46cfed446 100644
> >> --- a/drivers/mtd/nand/spi/Makefile
> >> +++ b/drivers/mtd/nand/spi/Makefile
> >> @@ -1,4 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>
> >>   spinand-objs :=3D core.o gigadevice.o macronix.o micron.o paragon.o =
toshiba.o winbond.o
> >> +spinand-objs +=3D xtx.o
> >>   obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> >> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> >> index 597b088ca7..0b4c067425 100644
> >> --- a/drivers/mtd/nand/spi/core.c
> >> +++ b/drivers/mtd/nand/spi/core.c
> >> @@ -828,6 +828,7 @@ static const struct spinand_manufacturer *spinand_=
manufacturers[] =3D {
> >>          &paragon_spinand_manufacturer,
> >>          &toshiba_spinand_manufacturer,
> >>          &winbond_spinand_manufacturer,
> >> +       &xtx_spinand_manufacturer,
> >>   };
> >>
> >>   static int spinand_manufacturer_match(struct spinand_device *spinand=
,
> >> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
> >> new file mode 100644
> >> index 0000000000..602861c77b
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/spi/xtx.c
> >> @@ -0,0 +1,180 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Stefan Roese <sr@denx.de>
> >> + *
> >> + * Derived from drivers/mtd/nand/spi/micron.c
> >> + *   Copyright (c) 2016-2017 Micron Technology, Inc.
> >> + */
> >> +
> >> +#ifndef __UBOOT__
> >> +#include <linux/device.h>
> >> +#include <linux/kernel.h>
> >> +#endif
> >> +#include <linux/bitfield.h>
> >> +#include <linux/mtd/spinand.h>
> >> +
> >> +#define SPINAND_MFR_XTX        0x0B
> >> +
> >> +#define XT26XXXD_STATUS_ECC3_ECC2_MASK     GENMASK(7, 6)
> >> +#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
> >> +#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
> >> +#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
> >> +#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
> >> +
> >> +static SPINAND_OP_VARIANTS(read_cache_variants,
> >> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> >> +               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> >> +               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> >> +               SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> >> +               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> >> +               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0))=
;
> >> +
> >> +static SPINAND_OP_VARIANTS(write_cache_variants,
> >> +               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> >> +               SPINAND_PROG_LOAD(true, 0, NULL, 0));
> >> +
> >> +static SPINAND_OP_VARIANTS(update_cache_variants,
> >> +               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> >> +               SPINAND_PROG_LOAD(false, 0, NULL, 0));
> >> +
> >> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +                                 struct mtd_oob_region *region)
> >> +{
> >> +       if (section)
> >> +               return -ERANGE;
> >> +
> >> +       region->offset =3D mtd->oobsize / 2;
> >> +       region->length =3D mtd->oobsize / 2;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
> >> +                                  struct mtd_oob_region *region)
> >> +{
> >> +       if (section)
> >> +               return -ERANGE;
> >> +
> >> +       region->offset =3D 2;
> >> +       region->length =3D mtd->oobsize / 2 - 2;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout =3D {
> >> +       .ecc =3D xt26xxxd_ooblayout_ecc,
> >> +       .rfree =3D xt26xxxd_ooblayout_free,
> >> +};
> >> +
> >> +static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
> >> +                                  u8 status)
> >> +{
> >> +       switch (FIELD_GET(STATUS_ECC_MASK, status)) {
> >> +       case XT26XXXD_STATUS_ECC_NO_DETECTED:
> >> +               return 0;
> >> +       case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
> >> +               return -EBADMSG;
> >> +       case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
> >> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, s=
tatus);
> >> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
> >> +               return 8;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +static const struct spinand_info xtx_spinand_table[] =3D {
> >> +       SPINAND_INFO("XT26G01D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3=
1),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26G11D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3=
4),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26Q01D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x5=
1),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26G02D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3=
2),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26G12D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3=
5),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26Q02D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x5=
2),
> >> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26G04D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x3=
3),
> >> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +       SPINAND_INFO("XT26Q04D",
> >> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x5=
3),
> >> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> >> +                    NAND_ECCREQ(8, 512),
> >> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >> +                                             &write_cache_variants,
> >> +                                             &update_cache_variants),
> >> +                    0,
> >> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> >> +                                    xt26xxxd_ecc_get_status)),
> >> +};
> >> +
> >> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops =
=3D {
> >> +};
> >> +
> >> +const struct spinand_manufacturer xtx_spinand_manufacturer =3D {
> >> +       .id =3D SPINAND_MFR_XTX,
> >> +       .name =3D "XTX",
> >> +       .chips =3D xtx_spinand_table,
> >> +       .nchips =3D ARRAY_SIZE(xtx_spinand_table),
> >> +       .ops =3D &xtx_spinand_manuf_ops,
> >> +};
> >> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> >> index e8d6feb970..bf7696a981 100644
> >> --- a/include/linux/mtd/spinand.h
> >> +++ b/include/linux/mtd/spinand.h
> >> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer micron_sp=
inand_manufacturer;
> >>   extern const struct spinand_manufacturer paragon_spinand_manufacture=
r;
> >>   extern const struct spinand_manufacturer toshiba_spinand_manufacture=
r;
> >>   extern const struct spinand_manufacturer winbond_spinand_manufacture=
r;
> >> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> >>
> >>   /**
> >>    * struct spinand_op_variants - SPI NAND operation variants
> >> --
> >> 2.34.1
> >>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
