Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB7ECF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 17:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D7088753;
	Sun, 29 Sep 2024 19:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fVFHBqGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33FA88785; Sun, 29 Sep 2024 19:19:23 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5791E8870D
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 19:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c8967dd2c7so393589a12.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727630361; x=1728235161;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9LF2fUy2O6tzvy+VBlAkLlY0907kJtUPuY+gj5r8k8=;
 b=fVFHBqGatY6eFbypxUiicVohbU+bG/S27FVa6e599HYdw6bjaOpbHK5NbgtRziXsN1
 a8WBWugHnB+dYlL991711Jqcy18cd+73dkRJ0kzRV1Bxx7m5RIeOYF2acfl+Z7NegShw
 p1Q68qcUpEuUENLSDw1E2iIk3rAdi5Y3THV5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630361; x=1728235161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9LF2fUy2O6tzvy+VBlAkLlY0907kJtUPuY+gj5r8k8=;
 b=PKUHHedmU5tqm/y39ysLvtB96o3QPeUm9OCWGM5mfjISafHC2/Ma3zueAMK0BqVlem
 BUW1qFKSyeJiqO4mqcE54vxTiE8b7LAQyTHCrE/eZCgxy3PpwZTvHOI36A7eO+D2pPsw
 MMs2UE7Q7XJ5lphO1UQbIkmUQauJ7SINcMQRbnI4KRwKMA5JuSb3JQjaeOe7Y/CP5VPo
 8iwA90zLErnmuaaK+O78IQQFsvihtwssfg7v8MaeLBw9tm0KPgQZ7sTHoNAHsdN2pJJX
 88+aE2BdOk62BABXA3ATuRDRu3bIoTQ2kiPVgeODuEgd2ZzsQvaLD/ZcO/Xy03sy7Ppq
 X2Pw==
X-Gm-Message-State: AOJu0YxuHz8JR+S+OX75fFzk6PSnl8SiAZEyKmLi6lXZ9oZDvsxnN5TM
 gx8ZNk9/PPGQtzAGv4F4uKfRGqMBKYnqogU4pponTWNoCWw6/ir6t7FNSjmhwU+C66KtV1cYQAm
 ddSFsDowiMN4cnfDScLOfFQKcw2LI4zygmvRgeQ==
X-Google-Smtp-Source: AGHT+IFj/a+h+gUXVglK72razbSBd29tHkXMC2ab0PvdtoGS7lMv/zy/5wt731zCNELW/jupAkcqt66+jfT31vZBspo=
X-Received: by 2002:a05:6402:210b:b0:5c5:b679:cf29 with SMTP id
 4fb4d7f45d1cf-5c8824cdd4dmr9995822a12.1.1727630360550; Sun, 29 Sep 2024
 10:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-1-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-1-08632f64c8ec@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 29 Sep 2024 19:19:09 +0200
Message-ID: <CAOf5uwk5tUo9aWzsJxDqdd8A1r9QLYM5x5w5gQ9stAHjOc_ghw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mtd: rawnand: brcmnand: Fix ECC level field
 setting for v7.2 controller
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

On Mon, Sep 16, 2024 at 11:58=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> From: William Zhang <william.zhang@broadcom.com>
>
> Backport from the Linux kernel
> commit 2ec2839a9062db8a592525a3fdabd42dcd9a3a9b
> "mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller"
>
> v7.2 controller has different ECC level field size and shift in the acc
> control register than its predecessor and successor controller. It needs
> to be set specifically.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-2-william.zh=
ang@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 74 ++++++++++++++++++--------=
------
>  1 file changed, 41 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index b1af3f717d43..700d1122639f 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -218,6 +218,7 @@ struct brcmnand_controller {
>         const unsigned int      *page_sizes;
>         unsigned int            page_size_shift;
>         unsigned int            max_oob;
> +       u32                     ecc_level_shift;
>         u32                     features;
>
>         /* for low-power standby/resume only */
> @@ -544,6 +545,34 @@ enum {
>         INTFC_CTLR_READY                =3D BIT(31),
>  };
>
> +/***********************************************************************
> + * NAND ACC CONTROL bitfield
> + *
> + * Some bits have remained constant throughout hardware revision, while
> + * others have shifted around.
> + ***********************************************************************=
/
> +
> +/* Constant for all versions (where supported) */
> +enum {
> +       /* See BRCMNAND_HAS_CACHE_MODE */
> +       ACC_CONTROL_CACHE_MODE                          =3D BIT(22),
> +
> +       /* See BRCMNAND_HAS_PREFETCH */
> +       ACC_CONTROL_PREFETCH                            =3D BIT(23),
> +
> +       ACC_CONTROL_PAGE_HIT                            =3D BIT(24),
> +       ACC_CONTROL_WR_PREEMPT                          =3D BIT(25),
> +       ACC_CONTROL_PARTIAL_PAGE                        =3D BIT(26),
> +       ACC_CONTROL_RD_ERASED                           =3D BIT(27),
> +       ACC_CONTROL_FAST_PGM_RDIN                       =3D BIT(28),
> +       ACC_CONTROL_WR_ECC                              =3D BIT(30),
> +       ACC_CONTROL_RD_ECC                              =3D BIT(31),
> +};
> +
> +#define        ACC_CONTROL_ECC_SHIFT                   16
> +/* Only for v7.2 */
> +#define        ACC_CONTROL_ECC_EXT_SHIFT               13
> +
>  static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 off=
s)
>  {
>         return brcmnand_readl(ctrl->nand_base + offs);
> @@ -675,6 +704,12 @@ static int brcmnand_revision_init(struct brcmnand_co=
ntroller *ctrl)
>  #endif /* __UBOOT__ */
>                 ctrl->features |=3D BRCMNAND_HAS_WP;
>
> +       /* v7.2 has different ecc level shift in the acc register */
> +       if (ctrl->nand_version =3D=3D 0x0702)
> +               ctrl->ecc_level_shift =3D ACC_CONTROL_ECC_EXT_SHIFT;
> +       else
> +               ctrl->ecc_level_shift =3D ACC_CONTROL_ECC_SHIFT;
> +
>         return 0;
>  }
>
> @@ -844,30 +879,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand=
_controller *ctrl)
>         return 0;
>  }
>
> -/***********************************************************************
> - * NAND ACC CONTROL bitfield
> - *
> - * Some bits have remained constant throughout hardware revision, while
> - * others have shifted around.
> - ***********************************************************************=
/
> -
> -/* Constant for all versions (where supported) */
> -enum {
> -       /* See BRCMNAND_HAS_CACHE_MODE */
> -       ACC_CONTROL_CACHE_MODE                          =3D BIT(22),
> -
> -       /* See BRCMNAND_HAS_PREFETCH */
> -       ACC_CONTROL_PREFETCH                            =3D BIT(23),
> -
> -       ACC_CONTROL_PAGE_HIT                            =3D BIT(24),
> -       ACC_CONTROL_WR_PREEMPT                          =3D BIT(25),
> -       ACC_CONTROL_PARTIAL_PAGE                        =3D BIT(26),
> -       ACC_CONTROL_RD_ERASED                           =3D BIT(27),
> -       ACC_CONTROL_FAST_PGM_RDIN                       =3D BIT(28),
> -       ACC_CONTROL_WR_ECC                              =3D BIT(30),
> -       ACC_CONTROL_RD_ECC                              =3D BIT(31),
> -};
> -
>  static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *c=
trl)
>  {
>         if (ctrl->nand_version =3D=3D 0x0702)
> @@ -880,18 +891,15 @@ static inline u32 brcmnand_spare_area_mask(struct b=
rcmnand_controller *ctrl)
>                 return GENMASK(4, 0);
>  }
>
> -#define NAND_ACC_CONTROL_ECC_SHIFT     16
> -#define NAND_ACC_CONTROL_ECC_EXT_SHIFT 13
> -
>  static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ct=
rl)
>  {
>         u32 mask =3D (ctrl->nand_version >=3D 0x0600) ? 0x1f : 0x0f;
>
> -       mask <<=3D NAND_ACC_CONTROL_ECC_SHIFT;
> +       mask <<=3D ACC_CONTROL_ECC_SHIFT;
>
>         /* v7.2 includes additional ECC levels */
> -       if (ctrl->nand_version >=3D 0x0702)
> -               mask |=3D 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
> +       if (ctrl->nand_version =3D=3D 0x0702)
> +               mask |=3D 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
>
>         return mask;
>  }
> @@ -905,8 +913,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_=
host *host, int en)
>
>         if (en) {
>                 acc_control |=3D ecc_flags; /* enable RD/WR ECC */
> -               acc_control |=3D host->hwcfg.ecc_level
> -                              << NAND_ACC_CONTROL_ECC_SHIFT;
> +               acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);
> +               acc_control |=3D host->hwcfg.ecc_level << ctrl->ecc_level=
_shift;
>         } else {
>                 acc_control &=3D ~ecc_flags; /* disable RD/WR ECC */
>                 acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);
> @@ -2225,7 +2233,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *h=
ost,
>         tmp &=3D ~brcmnand_ecc_level_mask(ctrl);
>         tmp &=3D ~brcmnand_spare_area_mask(ctrl);
>         if (ctrl->nand_version >=3D 0x0302) {
> -               tmp |=3D cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
> +               tmp |=3D cfg->ecc_level << ctrl->ecc_level_shift;
>                 tmp |=3D cfg->spare_area_size;
>         }
>         nand_writereg(ctrl, acc_control_offs, tmp);
>
> --
> 2.46.0
>

Acked-by; Michael Trimarchi <michael@amarulasolutions.com>


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
