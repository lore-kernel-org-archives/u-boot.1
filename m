Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70385C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1C787762;
	Mon, 27 Nov 2023 15:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jKvIHKVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38A28773A; Mon, 27 Nov 2023 15:43:33 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5711E8774B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso5622344a12.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701096210; x=1701701010;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ppHgvIqGc2s0Pd6GrvEoSUK6aI8AW68SpeTR1uvVzM=;
 b=jKvIHKVVJ8w8DAiu8MdKbKsJII8RImnjQzw8475viIqOBeSaiO1NxXrWpM3eQCfmIP
 bjj+10L05itV3WZG1Wyv2Y3sD9CFpJX6f9VgqT62veyuG+2UtqDWMgSHPWJGUsXIsRvY
 sIWxCPRc6lo4h1uf4AllqmBqUZIxrWKIKG4Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096210; x=1701701010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ppHgvIqGc2s0Pd6GrvEoSUK6aI8AW68SpeTR1uvVzM=;
 b=C5jV2OVQOTlKk7zU1XppKeyWKS//h7/hSgOuwJh7J7wtV1VzjMnRn6hdt9/wvQe9BF
 OQemK3DceJK24sPhqgrjfHNFi68iNhvso5NCK6rIg9Jh+tafkKER3Ev3hd8si6jldrR5
 SmkV11NbhbXXK7r0OiQy/sstGevMjJ9xm52uZg0guKxwymkwWxKwMaKzli6SZ2xZMGAH
 XXO4ak+u9h1X2Pg79rmWHS9iChpXBQsFMh8sGpHP2ipnyN12hz9XckxF/hPI8vmSz9Fq
 fZy/+5kBas2XsVMdRLWyvS+1nwKefqyPLhGwWRKFwgaQc+HqZT0+hun9wUhcZr+5J5dP
 ZCmg==
X-Gm-Message-State: AOJu0YxppuX6GE13bnstkqMzBIQT8QuJVGrRZ490wEyRm6enCue51YhS
 xahUwYNqKPrntX42cH4YJpgTsI/mlN167P08zglfvQ==
X-Google-Smtp-Source: AGHT+IE5fjyAYawdJM7W+9m9QRoubxe4F+ymmhSpisuaHfKd325ubPnyWYu/sHpeEstge9VTOk0Wf9wU0V4E5maBBjc=
X-Received: by 2002:a17:906:3fd6:b0:a04:535d:7a30 with SMTP id
 k22-20020a1709063fd600b00a04535d7a30mr7880673ejj.66.1701096210526; Mon, 27
 Nov 2023 06:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20231125111605.47536-1-rogerq@kernel.org>
 <CAOf5uwk7So4o-rrTpY0Uy9OqmGTZkqVvuzYaE_z1Rdo0mLhmxg@mail.gmail.com>
 <DB8PR10MB373722A24CF47C907D8C3EECFFBDA@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB8PR10MB373722A24CF47C907D8C3EECFFBDA@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 27 Nov 2023 15:43:19 +0100
Message-ID: <CAOf5uwkiF+wM9=bCiMMtGvUj1Yq4GKmh1o8qmKyJpqPXbMGQOA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
To: "Leto, Enrico" <enrico.leto@siemens.com>
Cc: Roger Quadros <rogerq@kernel.org>, 
 "dario.binacchi@amarulasolutions.com" <dario.binacchi@amarulasolutions.com>,
 "hs@denx.de" <hs@denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, "praneeth@ti.com" <praneeth@ti.com>,
 "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi dario

On Mon, Nov 27, 2023 at 3:00=E2=80=AFPM Leto, Enrico <enrico.leto@siemens.c=
om> wrote:
>
> Hi,
>
> Works on my draco thuban AM335x based boards booting from NAND with ECC B=
CH8 code.
>
> Tested-by: Enrico Leto <enrico.leto@siemens.com>
>
> Thanks
>
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Saturday, November 25, 2023 2:07 PM
> > To: Roger Quadros <rogerq@kernel.org>
> > Cc: dario.binacchi@amarulasolutions.com; Schocher, Heiko (EXT) (DENX
> > Software Engineering GmbH) <hs@denx.de>; Leto, Enrico (SI BP R&D ZG FW
> > CCP) <enrico.leto@siemens.com>; trini@konsulko.com; praneeth@ti.com;
> > nm@ti.com; vigneshr@ti.com; u-boot@lists.denx.de
> > Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
> >
> > Hi Roger
> >
> > On Sat, Nov 25, 2023 at 12:16=E2=80=AFPM Roger Quadros <rogerq@kernel.o=
rg>
> > wrote:
> > >
> > > AM335x uses a special driver "am335x_spl_bch.c" as SPL NAND loader.
> > > This driver expects 1 sector at a time ECC and doesn't work well with
> > > multi-sector ECC that was implemented in commit 04fcd2587321 ("mtd:
> > > rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
> > >
> > > Switch back to 1 sector at a time read/ECC.
> > >
> > > Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based
> > > correction")
> > > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > > ---
> > >  drivers/mtd/nand/raw/omap_gpmc.c | 95
> > > ++++++++++----------------------
> > >  1 file changed, 29 insertions(+), 66 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/omap_gpmc.c
> > > b/drivers/mtd/nand/raw/omap_gpmc.c
> > > index 1a5ed0de31..2d2d2c2b6d 100644
> > > --- a/drivers/mtd/nand/raw/omap_gpmc.c
> > > +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> > > @@ -293,7 +293,7 @@ static void __maybe_unused
> > omap_enable_hwecc_bch(struct mtd_info *mtd,
> > >                 break;
> > >         case OMAP_ECC_BCH8_CODE_HW:
> > >                 bch_type =3D 1;
> > > -               nsectors =3D chip->ecc.steps;
> > > +               nsectors =3D 1;
> > >                 if (mode =3D=3D NAND_ECC_READ) {
> > >                         wr_mode   =3D BCH_WRAPMODE_1;
> > >                         ecc_size0 =3D BCH8R_ECC_SIZE0; @@ -306,7 +306=
,7
> > > @@ static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info
> > *mtd,
> > >                 break;
> > >         case OMAP_ECC_BCH16_CODE_HW:
> > >                 bch_type =3D 0x2;
> > > -               nsectors =3D chip->ecc.steps;
> > > +               nsectors =3D 1;
> > >                 if (mode =3D=3D NAND_ECC_READ) {
> > >                         wr_mode   =3D 0x01;
> > >                         ecc_size0 =3D 52; /* ECC bits in nibbles per
> > > sector */ @@ -345,17 +345,16 @@ static void __maybe_unused
> > > omap_enable_hwecc_bch(struct mtd_info *mtd,  }
> > >
> > >  /**
> > > - * _omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
> > > + * omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
> > >   * @mtd:        MTD device structure
> > >   * @dat:        The pointer to data on which ecc is computed
> > >   * @ecc_code:   The ecc_code buffer
> > > - * @sector:     The sector number (for a multi sector page)
> > >   *
> > >   * Support calculating of BCH4/8/16 ECC vectors for one sector
> > >   * within a page. Sector number is in @sector.
> > >   */
> > > -static int _omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *d=
at,
> > > -                                  u8 *ecc_code, int sector)
> > > +static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *da=
t,
> > > +                                 u8 *ecc_code)
> > >  {
> > >         struct nand_chip *chip =3D mtd_to_nand(mtd);
> > >         struct omap_nand_info *info =3D nand_get_controller_data(chip=
);
> > > @@ -368,7 +367,7 @@ static int _omap_calculate_ecc_bch(struct mtd_inf=
o
> > *mtd, const u8 *dat,
> > >         case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> > >  #endif
> > >         case OMAP_ECC_BCH8_CODE_HW:
> > > -               ptr =3D &gpmc_cfg->bch_result_0_3[sector].bch_result_=
x[3];
> > > +               ptr =3D &gpmc_cfg->bch_result_0_3[0].bch_result_x[3];
> > >                 val =3D readl(ptr);
> > >                 ecc_code[i++] =3D (val >>  0) & 0xFF;
> > >                 ptr--;
> > > @@ -383,21 +382,21 @@ static int _omap_calculate_ecc_bch(struct
> > > mtd_info *mtd, const u8 *dat,
> > >
> > >                 break;
> > >         case OMAP_ECC_BCH16_CODE_HW:
> > > -               val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_r=
esult_x[2]);
> > > +               val =3D
> > > + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[2]);
> > >                 ecc_code[i++] =3D (val >>  8) & 0xFF;
> > >                 ecc_code[i++] =3D (val >>  0) & 0xFF;
> > > -               val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_r=
esult_x[1]);
> > > +               val =3D
> > > + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[1]);
> > >                 ecc_code[i++] =3D (val >> 24) & 0xFF;
> > >                 ecc_code[i++] =3D (val >> 16) & 0xFF;
> > >                 ecc_code[i++] =3D (val >>  8) & 0xFF;
> > >                 ecc_code[i++] =3D (val >>  0) & 0xFF;
> > > -               val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_r=
esult_x[0]);
> > > +               val =3D
> > > + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[0]);
> > >                 ecc_code[i++] =3D (val >> 24) & 0xFF;
> > >                 ecc_code[i++] =3D (val >> 16) & 0xFF;
> > >                 ecc_code[i++] =3D (val >>  8) & 0xFF;
> > >                 ecc_code[i++] =3D (val >>  0) & 0xFF;
> > >                 for (j =3D 3; j >=3D 0; j--) {
> > > -                       val =3D readl(&gpmc_cfg->bch_result_0_3[secto=
r].bch_result_x[j]
> > > +                       val =3D
> > > + readl(&gpmc_cfg->bch_result_0_3[0].bch_result_x[j]
> > >                                                                      =
   );
> > >                         ecc_code[i++] =3D (val >> 24) & 0xFF;
> > >                         ecc_code[i++] =3D (val >> 16) & 0xFF; @@ -431=
,22
> > > +430,6 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd, co=
nst
> > u8 *dat,
> > >         return 0;
> > >  }
> > >
> > > -/**
> > > - * omap_calculate_ecc_bch - ECC generator for 1 sector
> > > - * @mtd:        MTD device structure
> > > - * @dat:       The pointer to data on which ecc is computed
> > > - * @ecc_code:  The ecc_code buffer
> > > - *
> > > - * Support calculating of BCH4/8/16 ECC vectors for one sector. This
> > > is used
> > > - * when SW based correction is required as ECC is required for one
> > > sector
> > > - * at a time.
> > > - */
> > > -static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mt=
d,
> > > -                                 const u_char *dat, u_char *ecc_calc=
)
> > > -{
> > > -       return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
> > > -}
> > > -
> > >  static inline void omap_nand_read_buf(struct mtd_info *mtd, uint8_t
> > > *buf, int len)  {
> > >         struct nand_chip *chip =3D mtd_to_nand(mtd); @@ -572,34 +555,=
6
> > > @@ static void omap_nand_read_prefetch(struct mtd_info *mtd, uint8_t
> > > *buf, int len)
> > >
> > >  #ifdef CONFIG_NAND_OMAP_ELM
> > >
> > > -/**
> > > - * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
> > > - * @mtd:       MTD device structure
> > > - * @dat:       The pointer to data on which ecc is computed
> > > - * @ecc_code:  The ecc_code buffer
> > > - *
> > > - * Support calculating of BCH4/8/16 ecc vectors for the entire page =
in one
> > go.
> > > - */
> > > -static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
> > > -                                       const u_char *dat, u_char *ec=
c_calc)
> > > -{
> > > -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> > > -       int eccbytes =3D chip->ecc.bytes;
> > > -       unsigned long nsectors;
> > > -       int i, ret;
> > > -
> > > -       nsectors =3D ((readl(&gpmc_cfg->ecc_config) >> 4) & 0x7) + 1;
> > > -       for (i =3D 0; i < nsectors; i++) {
> > > -               ret =3D _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i=
);
> > > -               if (ret)
> > > -                       return ret;
> > > -
> > > -               ecc_calc +=3D eccbytes;
> > > -       }
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  /*
> > >   * omap_reverse_list - re-orders list elements in reverse order [int=
ernal]
> > >   * @list:      pointer to start of list
> > > @@ -752,7 +707,6 @@ static int omap_read_page_bch(struct mtd_info
> > > *mtd, struct nand_chip *chip,  {
> > >         int i, eccsize =3D chip->ecc.size;
> > >         int eccbytes =3D chip->ecc.bytes;
> > > -       int ecctotal =3D chip->ecc.total;
> > >         int eccsteps =3D chip->ecc.steps;
> > >         uint8_t *p =3D buf;
> > >         uint8_t *ecc_calc =3D chip->buffers->ecccalc; @@ -760,24 +714=
,30
> > > @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_ch=
ip
> > *chip,
> > >         uint32_t *eccpos =3D chip->ecc.layout->eccpos;
> > >         uint8_t *oob =3D chip->oob_poi;
> > >         uint32_t oob_pos;
> > > +       u32 data_pos =3D 0;
> > >
> > >         /* oob area start */
> > >         oob_pos =3D (eccsize * eccsteps) + chip->ecc.layout->eccpos[0=
];
> > >         oob +=3D chip->ecc.layout->eccpos[0];
> > >
> > > -       /* Enable ECC engine */
> > > -       chip->ecc.hwctl(mtd, NAND_ECC_READ);
> > > +       for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D e=
ccsize,
> > > +            oob +=3D eccbytes) {
> > > +               /* Enable ECC engine */
> > > +               chip->ecc.hwctl(mtd, NAND_ECC_READ);
> > >
> > > -       /* read entire page */
> > > -       chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, -1);
> > > -       chip->read_buf(mtd, buf, mtd->writesize);
> > > +               /* read data */
> > > +               chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_pos, -1);
> > > +               chip->read_buf(mtd, p, eccsize);
> > >
> > > -       /* read all ecc bytes from oob area */
> > > -       chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
> > > -       chip->read_buf(mtd, oob, ecctotal);
> > > +               /* read respective ecc from oob area */
> > > +               chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
> > > +               chip->read_buf(mtd, oob, eccbytes);
> > > +               /* read syndrome */
> > > +               chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> > >
> > > -       /* Calculate ecc bytes */
> > > -       omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
> > > +               data_pos +=3D eccsize;
> > > +               oob_pos +=3D eccbytes;
> > > +       }
> > >
> > >         for (i =3D 0; i < chip->ecc.total; i++)
> > >                 ecc_code[i] =3D chip->oob_poi[eccpos[i]]; @@ -945,6
> > > +905,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
> > >                 nand->ecc.hwctl         =3D omap_enable_hwecc_bch;
> > >                 nand->ecc.correct       =3D omap_correct_data_bch_sw;
> > >                 nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> > > +               nand->ecc.steps         =3D eccsteps;
> > >                 /* define ecc-layout */
> > >                 ecclayout->eccbytes     =3D nand->ecc.bytes * eccstep=
s;
> > >                 ecclayout->eccpos[0]    =3D BADBLOCK_MARKER_LENGTH;
> > > @@ -987,6 +948,7 @@ static int omap_select_ecc_scheme(struct
> > nand_chip *nand,
> > >                 nand->ecc.correct       =3D omap_correct_data_bch;
> > >                 nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> > >                 nand->ecc.read_page     =3D omap_read_page_bch;
> > > +               nand->ecc.steps         =3D eccsteps;
> > >                 /* define ecc-layout */
> > >                 ecclayout->eccbytes     =3D nand->ecc.bytes * eccstep=
s;
> > >                 for (i =3D 0; i < ecclayout->eccbytes; i++) @@ -1020,=
6
> > > +982,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
> > >                 nand->ecc.correct       =3D omap_correct_data_bch;
> > >                 nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> > >                 nand->ecc.read_page     =3D omap_read_page_bch;
> > > +               nand->ecc.steps         =3D eccsteps;
> > >                 /* define ecc-layout */
> > >                 ecclayout->eccbytes     =3D nand->ecc.bytes * eccstep=
s;
> > >                 for (i =3D 0; i < ecclayout->eccbytes; i++)
> > >
> > > base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
> > > --
> > > 2.34.1
> > >
> >
> > Let's wait on some tested-by
> >

I'm not a fan of this patch but we need to cover this regression

Michael

> > Michael



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
