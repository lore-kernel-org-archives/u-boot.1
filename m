Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86670C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 13:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E6E8812C;
	Sun, 14 Apr 2024 15:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MCimOMK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D5A88131; Sun, 14 Apr 2024 15:51:47 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C0388126
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 15:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-617cd7bd929so27162297b3.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713102703; x=1713707503;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yluaIVNusE7YOVzklbkyayrvdn+PjoMjRWLh0D84ScM=;
 b=MCimOMK9vUTZ2YdnHqBGK4kbLbqi6H6oOr/jy10gDOBdVmTGXHT4r2RtH8pk2qQ+E7
 MSs2IvUuFy+mElYzwa8O3iXU+oCnfQ40UlwtYQOmGkPqQFSkr10bDIYz3MJL41EtvWoh
 poRyGfyDgx7TTFXw8ZopeVeYO6VVRWEtQAfXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713102703; x=1713707503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yluaIVNusE7YOVzklbkyayrvdn+PjoMjRWLh0D84ScM=;
 b=GKl36io1aEh2MP4AVeKD9TI4FUwIjKu5qqrZ3uOPkRJA1mPfTmYgk70l10SfLSDtFD
 318WfGfTW/zluSfQ9Pn29nwaNpLzyaiqvRUwmSlmOKOJx/x1/Hzv1UB+IrOxgJuohStq
 m5Ne6Otvl5CqTWNMLyQcg70lxpMH09thXtHJJEx/6IstVTJDhbvaXFD+4F4icx7JK/Bz
 EaGHL0IyOWgSyyMOAV9L3sJcFDqkfkSxH8I+C7QRPL3zpGeMNbjo+t70WpTTe8Zm9JZW
 bipxy0g/NBDGS3/bHILwbnuWDk9jmsznOWKAhg3U3J40W2WyTrAFT84WhnLbSgf4EsK7
 ycCA==
X-Gm-Message-State: AOJu0YzDtHcWcQga/BLkzEHyQUweYyrj604Sf/V/qB9dkI+YEasKBtrS
 aOgkN7mrraVGMjXIwzzIhThBzfKDWNKx53kCQ0MbmN6zenBzGZYFMzoAxjNjQoe88/OtGera6op
 UPtzUAs+wEkJrh7xSfIyC2t4xaWUHE2chUzZiOg==
X-Google-Smtp-Source: AGHT+IEaTX4/HDCMuZt64yYKgaqCn3mbdaFYP1zSjF6Ef9esnmBrTQsoOzqJRz8QMtyRa/z/EhcZ3SusLTUttYP0NPs=
X-Received: by 2002:a81:b04f:0:b0:617:d4a0:fa8f with SMTP id
 x15-20020a81b04f000000b00617d4a0fa8fmr7379390ywk.51.1713102703412; Sun, 14
 Apr 2024 06:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240312014314.15454-1-bruce_suen@163.com>
In-Reply-To: <20240312014314.15454-1-bruce_suen@163.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 14 Apr 2024 15:51:32 +0200
Message-ID: <CABGWkvqcVZhpoNog2JiU_UfKp7KvjtUj=e=SViiNj2ky5=pfWg@mail.gmail.com>
Subject: Re: [PATCH V4] mtd: spinand: Add support for XTX SPINAND
To: Bruce Suen <bruce_suen@163.com>
Cc: u-boot@lists.denx.de, frieder.schrempf@kontron.de, 
 michael@amarulasolutions.com, jagan@amarulasolutions.com, 
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

Hi Bruce,

On Tue, Mar 12, 2024 at 2:43=E2=80=AFAM Bruce Suen <bruce_suen@163.com> wro=
te:
>
> Add support for XTX XT26G0xA and XT26xxxD. The driver is ported from
> linux-6.7.1. This driver is tested on Banana BPI-R3 with XT26G01A and
> XT26G12D.
>
> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> V3->V4:
> - modify commit message minor flaws
> ---
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/xtx.c    | 266 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 269 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/xtx.c
>
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefil=
e
> index f172f4787f..65b836b34c 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  spinand-objs :=3D core.o esmt.o gigadevice.o macronix.o micron.o paragon=
.o
> -spinand-objs +=3D toshiba.o winbond.o
> +spinand-objs +=3D toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8ca33459f9..62c28aa422 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -829,6 +829,7 @@ static const struct spinand_manufacturer *spinand_man=
ufacturers[] =3D {
>         &toshiba_spinand_manufacturer,
>         &winbond_spinand_manufacturer,
>         &esmt_c8_spinand_manufacturer,
> +       &xtx_spinand_manufacturer,
>  };
>
>  static int spinand_manufacturer_match(struct spinand_device *spinand,
> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
> new file mode 100644
> index 0000000000..aee1849a71
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/xtx.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author:
> + * Felix Matouschek <felix@matouschek.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_XTX        0x0B
> +
> +#define XT26G0XA_STATUS_ECC_MASK       GENMASK(5, 2)
> +#define XT26G0XA_STATUS_ECC_NO_DETECTED        (0 << 2)
> +#define XT26G0XA_STATUS_ECC_8_CORRECTED        (3 << 4)
> +#define XT26G0XA_STATUS_ECC_UNCOR_ERROR        (2 << 4)
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
> +static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset =3D 48;
> +       region->length =3D 16;
> +
> +       return 0;
> +}
> +
> +static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
> +                                  struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset =3D 1;
> +       region->length =3D 47;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops xt26g0xa_ooblayout =3D {
> +       .ecc =3D xt26g0xa_ooblayout_ecc,
> +       .rfree =3D xt26g0xa_ooblayout_free,
> +};
> +
> +static int xt26g0xa_ecc_get_status(struct spinand_device *spinand,
> +                                  u8 status)
> +{
> +       status =3D status & XT26G0XA_STATUS_ECC_MASK;
> +
> +       switch (status) {
> +       case XT26G0XA_STATUS_ECC_NO_DETECTED:
> +               return 0;
> +       case XT26G0XA_STATUS_ECC_8_CORRECTED:
> +               return 8;
> +       case XT26G0XA_STATUS_ECC_UNCOR_ERROR:
> +               return -EBADMSG;
> +       default:
> +               break;
> +       }
> +
> +       /* At this point values greater than (2 << 4) are invalid  */
> +       if (status > XT26G0XA_STATUS_ECC_UNCOR_ERROR)
> +               return -EINVAL;
> +
> +       /* (1 << 2) through (7 << 2) are 1-7 corrected errors */
> +       return status >> 2;
> +}
> +
> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset =3D mtd->oobsize / 2;
> +       region->length =3D mtd->oobsize / 2;
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
> +       region->offset =3D 2;
> +       region->length =3D mtd->oobsize / 2 - 2;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout =3D {
> +       .ecc =3D xt26xxxd_ooblayout_ecc,
> +       .rfree =3D xt26xxxd_ooblayout_free,
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
> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, stat=
us);
> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
> +               return 8;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct spinand_info xtx_spinand_table[] =3D {
> +       SPINAND_INFO("XT26G01A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE1),
> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
> +       SPINAND_INFO("XT26G02A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE2),
> +                    NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
> +       SPINAND_INFO("XT26G04A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE3),
> +                    NAND_MEMORG(1, 2048, 64, 128, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
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
> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops =3D {
> +};
> +
> +const struct spinand_manufacturer xtx_spinand_manufacturer =3D {
> +       .id =3D SPINAND_MFR_XTX,
> +       .name =3D "XTX",
> +       .chips =3D xtx_spinand_table,
> +       .nchips =3D ARRAY_SIZE(xtx_spinand_table),
> +       .ops =3D &xtx_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6f479fa5ad..13b5a52f8b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer paragon_spin=
and_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
>
>  /**
>   * struct spinand_op_variants - SPI NAND operation variants
> --
> 2.34.1
>

Applied to nand-next

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
