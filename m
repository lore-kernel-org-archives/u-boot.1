Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E8C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 08:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A5887505;
	Fri,  8 Dec 2023 09:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YZF0vSbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B8187505; Fri,  8 Dec 2023 09:41:46 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50C987140
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 09:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so239737366b.3
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 00:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702024901; x=1702629701;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xaQ99wjJ6Wh/qxnhMxBZj86bL1EtU11jWSpy1Zw2Tc=;
 b=YZF0vSbvidReVHcrUzAjxYgTedDpDCAOC6KpSlmzqy6v9g2bv0w37jnK1h06EPIJsb
 +SNdui+GHGLlH1MXQsxANpd5whMw7Ze4tTLr7ZeIcVhhHu4bS3KO1M9OTjkVhQV63Hlo
 NuZtbQLCMWOwFwo3UMFToPIPmuYryZO3JGukg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702024901; x=1702629701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xaQ99wjJ6Wh/qxnhMxBZj86bL1EtU11jWSpy1Zw2Tc=;
 b=SwsX/qpqsnB5gG4QrBsuL8xsx6HQwqUjZuX0P3RruyFRzKFl3p9DB+Jll9XMnsRZGx
 GPGf22oZ55EgxnRbmACW8ph1LXj6YOo4ZVVFZdyYp/brvFRbGquS1YscdLJi9TD7Rny3
 AHlyF1oWs9ZEJMtTxUDKy7qkGUaDMm+EAJEzeZ/Ooxw8n3EaS33BzoRQPuXRG60LNcrt
 oE3FYQzxSW0AJx7XHE6C4YHpeq21iWTgTuPfTr5OV3IK5D7Zagawv1w6GPFRvQKFJYyc
 iBSuH5kGMCEF96265vCDpW4e4pV4t2hzrm4QvBdeyp6LzFdTufqaXPvEkPPJmnW5ZVXY
 3daA==
X-Gm-Message-State: AOJu0Yy6WFMCc7BNrHfRFmDdVonkjv931VuEg1QiLSda8m6qBjGhTTDM
 x8UallyhyGozF5W2swcL5/zDOREg7vknro84Oep1yw==
X-Google-Smtp-Source: AGHT+IF891G6v36DpBqlXNOJnVnNzjYayEiQ6gxa08Y+KIo4NIihFdzbBOPv45FCATGX/FOXK/oRQsr+SazUidmSA3c=
X-Received: by 2002:a17:906:100a:b0:a1d:f3aa:a4bc with SMTP id
 10-20020a170906100a00b00a1df3aaa4bcmr1996700ejm.60.1702024901054; Fri, 08 Dec
 2023 00:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20231125111605.47536-1-rogerq@kernel.org>
 <a6a9be90-d360-4d35-b95b-e1d628c38ce8@kernel.org>
In-Reply-To: <a6a9be90-d360-4d35-b95b-e1d628c38ce8@kernel.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 8 Dec 2023 09:41:30 +0100
Message-ID: <CAOf5uwkGUA+Fk-Fqjr+8T_FYmHcTJq_EeJyG0kgvYsnBOF9ypg@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
To: Roger Quadros <rogerq@kernel.org>
Cc: dario.binacchi@amarulasolutions.com, hs@denx.de, enrico.leto@siemens.com, 
 trini@konsulko.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 u-boot@lists.denx.de
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

On Fri, Dec 8, 2023 at 9:32=E2=80=AFAM Roger Quadros <rogerq@kernel.org> wr=
ote:
>
> On 25/11/2023 13:16, Roger Quadros wrote:
> > AM335x uses a special driver "am335x_spl_bch.c" as SPL
> > NAND loader. This driver expects 1 sector at a time ECC
> > and doesn't work well with multi-sector ECC that was implemented in
> > commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based cor=
rection")
> >
> > Switch back to 1 sector at a time read/ECC.
> >
> > Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based cor=
rection")
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
>
> Azure pipeline build fails. Not because of this patch though.
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D7479&view=3D=
logs&j=3Dc6c7c3ee-a125-5e20-d856-38cb989f4743&t=3Dd274418e-7320-5c59-39b7-1=
56cfcddae0b
>

My comment below

> > ---
> >  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
> >  1 file changed, 29 insertions(+), 66 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/om=
ap_gpmc.c
> > index 1a5ed0de31..2d2d2c2b6d 100644
> > --- a/drivers/mtd/nand/raw/omap_gpmc.c
> > +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> > @@ -293,7 +293,7 @@ static void __maybe_unused omap_enable_hwecc_bch(st=
ruct mtd_info *mtd,
> >               break;
> >       case OMAP_ECC_BCH8_CODE_HW:
> >               bch_type =3D 1;
> > -             nsectors =3D chip->ecc.steps;
> > +             nsectors =3D 1;
> >               if (mode =3D=3D NAND_ECC_READ) {
> >                       wr_mode   =3D BCH_WRAPMODE_1;
> >                       ecc_size0 =3D BCH8R_ECC_SIZE0;
> > @@ -306,7 +306,7 @@ static void __maybe_unused omap_enable_hwecc_bch(st=
ruct mtd_info *mtd,
> >               break;
> >       case OMAP_ECC_BCH16_CODE_HW:
> >               bch_type =3D 0x2;
> > -             nsectors =3D chip->ecc.steps;
> > +             nsectors =3D 1;
> >               if (mode =3D=3D NAND_ECC_READ) {
> >                       wr_mode   =3D 0x01;
> >                       ecc_size0 =3D 52; /* ECC bits in nibbles per sect=
or */
> > @@ -345,17 +345,16 @@ static void __maybe_unused omap_enable_hwecc_bch(=
struct mtd_info *mtd,
> >  }
> >
> >  /**
> > - * _omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
> > + * omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
> >   * @mtd:        MTD device structure
> >   * @dat:        The pointer to data on which ecc is computed
> >   * @ecc_code:   The ecc_code buffer
> > - * @sector:     The sector number (for a multi sector page)
> >   *
> >   * Support calculating of BCH4/8/16 ECC vectors for one sector
> >   * within a page. Sector number is in @sector.
> >   */
> > -static int _omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *dat=
,
> > -                                u8 *ecc_code, int sector)
> > +static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *dat,
> > +                               u8 *ecc_code)
> >  {

This should be as before
static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,

> >       struct nand_chip *chip =3D mtd_to_nand(mtd);
> >       struct omap_nand_info *info =3D nand_get_controller_data(chip);
> > @@ -368,7 +367,7 @@ static int _omap_calculate_ecc_bch(struct mtd_info =
*mtd, const u8 *dat,
> >       case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> >  #endif
> >       case OMAP_ECC_BCH8_CODE_HW:
> > -             ptr =3D &gpmc_cfg->bch_result_0_3[sector].bch_result_x[3]=
;
> > +             ptr =3D &gpmc_cfg->bch_result_0_3[0].bch_result_x[3];
> >               val =3D readl(ptr);
> >               ecc_code[i++] =3D (val >>  0) & 0xFF;
> >               ptr--;
> > @@ -383,21 +382,21 @@ static int _omap_calculate_ecc_bch(struct mtd_inf=
o *mtd, const u8 *dat,
> >
> >               break;
> >       case OMAP_ECC_BCH16_CODE_HW:
> > -             val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_resul=
t_x[2]);
> > +             val =3D readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[2=
]);
> >               ecc_code[i++] =3D (val >>  8) & 0xFF;
> >               ecc_code[i++] =3D (val >>  0) & 0xFF;
> > -             val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_resul=
t_x[1]);
> > +             val =3D readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[1=
]);
> >               ecc_code[i++] =3D (val >> 24) & 0xFF;
> >               ecc_code[i++] =3D (val >> 16) & 0xFF;
> >               ecc_code[i++] =3D (val >>  8) & 0xFF;
> >               ecc_code[i++] =3D (val >>  0) & 0xFF;
> > -             val =3D readl(&gpmc_cfg->bch_result_4_6[sector].bch_resul=
t_x[0]);
> > +             val =3D readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[0=
]);
> >               ecc_code[i++] =3D (val >> 24) & 0xFF;
> >               ecc_code[i++] =3D (val >> 16) & 0xFF;
> >               ecc_code[i++] =3D (val >>  8) & 0xFF;
> >               ecc_code[i++] =3D (val >>  0) & 0xFF;
> >               for (j =3D 3; j >=3D 0; j--) {
> > -                     val =3D readl(&gpmc_cfg->bch_result_0_3[sector].b=
ch_result_x[j]
> > +                     val =3D readl(&gpmc_cfg->bch_result_0_3[0].bch_re=
sult_x[j]
> >                                                                       )=
;
> >                       ecc_code[i++] =3D (val >> 24) & 0xFF;
> >                       ecc_code[i++] =3D (val >> 16) & 0xFF;
> > @@ -431,22 +430,6 @@ static int _omap_calculate_ecc_bch(struct mtd_info=
 *mtd, const u8 *dat,
> >       return 0;
> >  }
> >
> > -/**
> > - * omap_calculate_ecc_bch - ECC generator for 1 sector
> > - * @mtd:        MTD device structure
> > - * @dat:     The pointer to data on which ecc is computed
> > - * @ecc_code:        The ecc_code buffer
> > - *
> > - * Support calculating of BCH4/8/16 ECC vectors for one sector. This i=
s used
> > - * when SW based correction is required as ECC is required for one sec=
tor
> > - * at a time.
> > - */
> > -static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
> > -                               const u_char *dat, u_char *ecc_calc)
> > -{

If you remove you should stay with it

> > -     return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
> > -}
> > -
> >  static inline void omap_nand_read_buf(struct mtd_info *mtd, uint8_t *b=
uf, int len)
> >  {
> >       struct nand_chip *chip =3D mtd_to_nand(mtd);
> > @@ -572,34 +555,6 @@ static void omap_nand_read_prefetch(struct mtd_inf=
o *mtd, uint8_t *buf, int len)
> >
> >  #ifdef CONFIG_NAND_OMAP_ELM
> >
> > -/**
> > - * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
> > - * @mtd:     MTD device structure
> > - * @dat:     The pointer to data on which ecc is computed
> > - * @ecc_code:        The ecc_code buffer
> > - *
> > - * Support calculating of BCH4/8/16 ecc vectors for the entire page in=
 one go.
> > - */
> > -static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
> > -                                     const u_char *dat, u_char *ecc_ca=
lc)
> > -{
> > -     struct nand_chip *chip =3D mtd_to_nand(mtd);
> > -     int eccbytes =3D chip->ecc.bytes;
> > -     unsigned long nsectors;
> > -     int i, ret;
> > -
> > -     nsectors =3D ((readl(&gpmc_cfg->ecc_config) >> 4) & 0x7) + 1;
> > -     for (i =3D 0; i < nsectors; i++) {
> > -             ret =3D _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
> > -             if (ret)
> > -                     return ret;
> > -
> > -             ecc_calc +=3D eccbytes;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  /*
> >   * omap_reverse_list - re-orders list elements in reverse order [inter=
nal]
> >   * @list:    pointer to start of list
> > @@ -752,7 +707,6 @@ static int omap_read_page_bch(struct mtd_info *mtd,=
 struct nand_chip *chip,
> >  {
> >       int i, eccsize =3D chip->ecc.size;
> >       int eccbytes =3D chip->ecc.bytes;
> > -     int ecctotal =3D chip->ecc.total;
> >       int eccsteps =3D chip->ecc.steps;
> >       uint8_t *p =3D buf;
> >       uint8_t *ecc_calc =3D chip->buffers->ecccalc;
> > @@ -760,24 +714,30 @@ static int omap_read_page_bch(struct mtd_info *mt=
d, struct nand_chip *chip,
> >       uint32_t *eccpos =3D chip->ecc.layout->eccpos;
> >       uint8_t *oob =3D chip->oob_poi;
> >       uint32_t oob_pos;
> > +     u32 data_pos =3D 0;
> >
> >       /* oob area start */
> >       oob_pos =3D (eccsize * eccsteps) + chip->ecc.layout->eccpos[0];
> >       oob +=3D chip->ecc.layout->eccpos[0];
> >
> > -     /* Enable ECC engine */
> > -     chip->ecc.hwctl(mtd, NAND_ECC_READ);
> > +     for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsi=
ze,
> > +          oob +=3D eccbytes) {
> > +             /* Enable ECC engine */
> > +             chip->ecc.hwctl(mtd, NAND_ECC_READ);
> >
> > -     /* read entire page */
> > -     chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, -1);
> > -     chip->read_buf(mtd, buf, mtd->writesize);
> > +             /* read data */
> > +             chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_pos, -1);
> > +             chip->read_buf(mtd, p, eccsize);
> >
> > -     /* read all ecc bytes from oob area */
> > -     chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
> > -     chip->read_buf(mtd, oob, ecctotal);
> > +             /* read respective ecc from oob area */
> > +             chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
> > +             chip->read_buf(mtd, oob, eccbytes);
> > +             /* read syndrome */
> > +             chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> >
> > -     /* Calculate ecc bytes */
> > -     omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
> > +             data_pos +=3D eccsize;
> > +             oob_pos +=3D eccbytes;
> > +     }
> >
> >       for (i =3D 0; i < chip->ecc.total; i++)
> >               ecc_code[i] =3D chip->oob_poi[eccpos[i]];
> > @@ -945,6 +905,7 @@ static int omap_select_ecc_scheme(struct nand_chip =
*nand,
> >               nand->ecc.hwctl         =3D omap_enable_hwecc_bch;
> >               nand->ecc.correct       =3D omap_correct_data_bch_sw;
> >               nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> > +             nand->ecc.steps         =3D eccsteps;
> >               /* define ecc-layout */
> >               ecclayout->eccbytes     =3D nand->ecc.bytes * eccsteps;
> >               ecclayout->eccpos[0]    =3D BADBLOCK_MARKER_LENGTH;
> > @@ -987,6 +948,7 @@ static int omap_select_ecc_scheme(struct nand_chip =
*nand,
> >               nand->ecc.correct       =3D omap_correct_data_bch;
> >               nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> >               nand->ecc.read_page     =3D omap_read_page_bch;
> > +             nand->ecc.steps         =3D eccsteps;
> >               /* define ecc-layout */
> >               ecclayout->eccbytes     =3D nand->ecc.bytes * eccsteps;
> >               for (i =3D 0; i < ecclayout->eccbytes; i++)
> > @@ -1020,6 +982,7 @@ static int omap_select_ecc_scheme(struct nand_chip=
 *nand,
> >               nand->ecc.correct       =3D omap_correct_data_bch;
> >               nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> >               nand->ecc.read_page     =3D omap_read_page_bch;
> > +             nand->ecc.steps         =3D eccsteps;
> >               /* define ecc-layout */
> >               ecclayout->eccbytes     =3D nand->ecc.bytes * eccsteps;
> >               for (i =3D 0; i < ecclayout->eccbytes; i++)
> >
> > base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
>
> --
> cheers,
> -roger



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
