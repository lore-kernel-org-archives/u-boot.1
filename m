Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A164E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 18:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8666A8010E;
	Thu, 12 Dec 2024 19:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OC5HSaeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179EE801BE; Thu, 12 Dec 2024 19:38:41 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80992800D7
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so1777932a91.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1734028717; x=1734633517;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frp/UFUUpUVc7DdputazM2EzBi0nwNEKfo8nCl/EfkU=;
 b=OC5HSaeRrWK2g17goi6P/zOa8/HUDW7Uj9XdkcCL44AiEZMygBU8yX/Y7PzDwYHk1Y
 sJb8KPlIU9WONdOhVDqTAuqdzuxCWAD9lJs8xRDOGVcUY+5E6VjXN2J1PKXNZPgTmpXA
 1VQM/9b7HDX5MZADzVn2kv3EXh2hs+yGa2g00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734028717; x=1734633517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frp/UFUUpUVc7DdputazM2EzBi0nwNEKfo8nCl/EfkU=;
 b=XakXdIc+v2dRvrCxG81o7glsEbCd/JNWd+oVed4drQ9in5gepHS7GkhpF4SG4P2h68
 lG1pYPNE8YQY+93W+LGqJrptpPK+orbG0fqGf+QmnJhXjBrqmYM6kLZMY8qk+cGB9D78
 yEPVPHR68UxcUvwWKOiQnbbQ4+dP4doFwlGgSaOe7h6PZAzKSHLeSjhLPwWAUQXsX8DU
 /cXlZ4OtVyKGm/oPst8Q6Uqthm/G2JNr5ngtu5Qds4zbZK2kNXXNdIhqeLC7TCpbvdxh
 tq1gk507hKMuRizwq55fDSzFcgHWGjX0rvZtVVythA+bP/eFl7GjmH13fSmOUhgJnVM/
 QqDA==
X-Gm-Message-State: AOJu0YwlLSZaoZX5bOvbBfuJQwwxNGE5y3kZ3gBx8pdVT1iHK7FTXN+F
 rxIw1o/xuKN69cXlntPla5ROFL9769x4Zgt4y6W/nxnwxjMZjqZMYAqJZdUEMaT4j0Mgzzd1qNy
 Td+fOHchWFlC0aX2LwO230JXsQ4Emh3TThMHe6w==
X-Gm-Gg: ASbGncsxyEdbYNaJcy34Dd6my2yGxm68G/V07dYwEsBXh6yKa/8zJykuOROUzqfY58n
 dMi9fXF08EjbfN9ejkugQZIZGqDVxtLknnKlazg==
X-Google-Smtp-Source: AGHT+IF7bWYhvwdSMM6N3gOvP44PWnp9hzrnppvg/H+xF/Xfo6p+e4crzuqz8RvmM2tVbBjDyaHDT7VvtoBdl6NcRhg=
X-Received: by 2002:a17:90b:38c8:b0:2ee:94a0:255c with SMTP id
 98e67ed59e1d1-2f13ac1bc5bmr6689988a91.13.1734028716836; Thu, 12 Dec 2024
 10:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-16-dinesh.maniyam@intel.com>
In-Reply-To: <20241205092315.25060-16-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 12 Dec 2024 19:38:25 +0100
Message-ID: <CAOf5uwnrJa3HcdMgu7SNjrG4h+71E4=BReCj_Cfz19cJbDwAWQ@mail.gmail.com>
Subject: Re: [resend v2 15/19] drivers: mtd: nand: base: Add support for
 Hardware ECC for check bad block
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

On Thu, Dec 5, 2024 at 10:24=E2=80=AFAM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> Leverage linux code to support hardware ECC interface
> to verify nand bad block.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> ---
> v2:
> - remove the "this patch is to" commit phrases
> ---
> ---
>  drivers/mtd/nand/raw/nand_base.c | 71 +++++++++++++++++++++-----------
>  include/linux/mtd/rawnand.h      | 13 ++++++
>  2 files changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index 4401bdcdb9..9b1b2d1f85 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -9,6 +9,8 @@
>   *  Copyright (C) 2000 Steven J. Hill (sjhill@realitydiluted.com)
>   *               2002-2006 Thomas Gleixner (tglx@linutronix.de)
>   *
> + *  Copyright (C) 2024 Intel Corporation <www.intel.com>
> + *

Drop it. I don't think that because you add a function here, you can
add any copyright

>   *  Credits:
>   *     David Woodhouse for adding multichip support
>   *
> @@ -306,6 +308,35 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t *=
buf, int len)
>         ioread16_rep(chip->IO_ADDR_R, p, len >> 1);
>  }
>
> +/*
> + * nand_bbm_get_next_page - Get the next page for bad block markers
> + * @chip: The NAND chip
> + * @page: First page to start checking for bad block marker usage
> + *
> + * Returns an integer that corresponds to the page offset within a block=
, for
> + * a page that is used to store bad block markers. If no more pages are
> + * available, -EINVAL is returned.
> + */
> +int nand_bbm_get_next_page(struct nand_chip *chip, int page)
> +{
> +       struct mtd_info *mtd =3D nand_to_mtd(chip);
> +       int last_page =3D ((mtd->erasesize - mtd->writesize) >>
> +                        chip->page_shift) & chip->pagemask;
> +       unsigned int bbm_flags =3D NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPA=
GE
> +               | NAND_BBM_LASTPAGE;
> +
> +       if (page =3D=3D 0 && !(chip->options & bbm_flags))
> +               return 0;
> +       if (page =3D=3D 0 && chip->options & NAND_BBM_FIRSTPAGE)
> +               return 0;
> +       if (page <=3D 1 && chip->options & NAND_BBM_SECONDPAGE)
> +               return 1;
> +       if (page <=3D last_page && chip->options & NAND_BBM_LASTPAGE)
> +               return last_page;
> +
> +       return -EINVAL;
> +}
> +
>  /**
>   * nand_block_bad - [DEFAULT] Read bad block marker from the chip
>   * @mtd: MTD device structure
> @@ -315,40 +346,32 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t =
*buf, int len)
>   */
>  static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
>  {
> -       int page, res =3D 0, i =3D 0;
>         struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       u16 bad;
> +       int first_page, page_offset;
> +       int res;
> +       u8 bad;
>
> -       if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
> -               ofs +=3D mtd->erasesize - mtd->writesize;
> +       first_page =3D (int)(ofs >> chip->page_shift) & chip->pagemask;
> +       page_offset =3D nand_bbm_get_next_page(chip, 0);
>
> -       page =3D (int)(ofs >> chip->page_shift) & chip->pagemask;
> +       while (page_offset >=3D 0) {
> +               res =3D chip->ecc.read_oob(mtd, chip, first_page + page_o=
ffset);
> +               if (res < 0)
> +                       return res;
>
> -       do {
> -               if (chip->options & NAND_BUSWIDTH_16) {
> -                       chip->cmdfunc(mtd, NAND_CMD_READOOB,
> -                                       chip->badblockpos & 0xFE, page);
> -                       bad =3D cpu_to_le16(chip->read_word(mtd));
> -                       if (chip->badblockpos & 0x1)
> -                               bad >>=3D 8;
> -                       else
> -                               bad &=3D 0xFF;
> -               } else {
> -                       chip->cmdfunc(mtd, NAND_CMD_READOOB, chip->badblo=
ckpos,
> -                                       page);
> -                       bad =3D chip->read_byte(mtd);
> -               }
> +               bad =3D chip->oob_poi[chip->badblockpos];
>
>                 if (likely(chip->badblockbits =3D=3D 8))
>                         res =3D bad !=3D 0xFF;
>                 else
>                         res =3D hweight8(bad) < chip->badblockbits;
> -               ofs +=3D mtd->writesize;
> -               page =3D (int)(ofs >> chip->page_shift) & chip->pagemask;
> -               i++;
> -       } while (!res && i < 2 && (chip->bbt_options & NAND_BBT_SCAN2NDPA=
GE));
> +               if (res)
> +                       return res;
>
> -       return res;
> +               page_offset =3D nand_bbm_get_next_page(chip, page_offset =
+ 1);
> +       }
> +
> +       return 0;
>  }
>
>  /**
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 14f93dab0a..35eb3b5678 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -4,6 +4,8 @@
>   *                        Steven J. Hill <sjhill@realitydiluted.com>
>   *                       Thomas Gleixner <tglx@linutronix.de>
>   *
> + *  Copyright (C) 2024 Intel Corporation <www.intel.com>
> + *

Drop here

>   * Info:
>   *     Contains standard defines and IDs for NAND flash devices
>   *
> @@ -131,6 +133,17 @@ void nand_wait_ready(struct mtd_info *mtd);
>
>  #define NAND_DATA_IFACE_CHECK_ONLY     -1
>
> +/*
> + * There are different places where the manufacturer stores the factory =
bad
> + * block markers.
> + *
> + * Position within the block: Each of these pages needs to be checked fo=
r a
> + * bad block marking pattern.
> + */
> +#define NAND_BBM_FIRSTPAGE     BIT(24)
> +#define NAND_BBM_SECONDPAGE    BIT(25)
> +#define NAND_BBM_LASTPAGE      BIT(26)
> +
>  /*
>   * Constants for ECC_MODES
>   */
> --
> 2.19.0
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

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
