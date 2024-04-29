Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 22:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2308A88717;
	Tue, 30 Apr 2024 00:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eD9XOIUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A350887A4; Tue, 30 Apr 2024 00:46:57 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFAD883D1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 00:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4dae8b2d29bso1443730e0c.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714430814; x=1715035614; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a83vKl4A2honFKHkzDJKAAitvLy0dh9TUz/OIsbnaoI=;
 b=eD9XOIUNdmlbHrPWXWUqxacMdZf++ng02hsPQ/dhhhbn+e8PzR0PF+T/iI48qk2/ms
 L1xLl5vavy/NNShlxY1abewl0k519suSCop02EegPtFPxLZtM3y9WiUUmiUdE/vT3mIc
 EjjprvrOdEKW5vcI+7LpYJ0DnAuBE6TXzD1c+UnmsQvNvVfJU+F/Gg8pFNDOhuV+KpgG
 RCt74QGXNUrqlR0a29qMNI1cOATrfgxpvPOSI4LlZX5eqUCrs8cugYLxFQo0XKQy970Z
 gAxHuMdOl7O3l4MDOtjRcATjuvo/XWvsfS4JYlMcATIc8iiFenIz2nasUrjLfiPwugOt
 r/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714430814; x=1715035614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a83vKl4A2honFKHkzDJKAAitvLy0dh9TUz/OIsbnaoI=;
 b=daRmkMR0CAQ6Hb+ZQ4zTxO4AD1wkev/41vJ9zlOmMA+Lwb0WPKwz8qHrZsNR/a+vnE
 G+EUtEpcWTn400CZKRS2JWzFLvzjwhCuay0KiGVMywXwnIE0eUrshGW+hKcaRqOX0qHb
 ++x6+fWjbXPuhL+MtWjNVaz6Ppt3ecxIKRVfjS0qm7oWZdTTIKRJkZiKQk7PRxR5IKv4
 tJftHmpREuywdIkU5QVI+oW3/1aJkbkgpKQlyy7bnfVt1VQ921Y3OqKUsGkgfm8IO2Yn
 r2ZefyGfXNFxBMuSUvC5cXpt08+tPEZscQaYe09qEFKblKR8kHwlD01q6nFbNuVGrjHy
 RdEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP/o6PGW7fFXS2+RllTRihwcukxDyg/6hRu9uL9CPf2XCCi34dsNIH3chceni1bRPS3aM6eJ2GnO0/+3DJ5Ercry1QKw==
X-Gm-Message-State: AOJu0Yw4Q9UuI/ifbM2AC4pQR4XE0g/zrfPfgShRuFJ4GMDxr0zZ1b7g
 2SO8c9xowyMH77TXfMYRogl2Sy3AEZJjwyQPdQ68C9XSgoIiNMprxYLwxTHt3N8UjV8Dkoy7Jwe
 jmYQTEF711UHnCncbMcGlI69iuMg=
X-Google-Smtp-Source: AGHT+IH7wez0tBr05ik7Y9PgyXoStLfDrUoDKP4EGcbFf68tif2/3tY6Y2G6R5qNsg88fXLEfnHaS1+qs8QXr59W8KQ=
X-Received: by 2002:a05:6122:1da4:b0:4d4:15d2:8b3b with SMTP id
 gg36-20020a0561221da400b004d415d28b3bmr12847586vkb.9.1714430813687; Mon, 29
 Apr 2024 15:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
 <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
In-Reply-To: <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 29 Apr 2024 15:46:42 -0700
Message-ID: <CANV2PTO1EAkgf_4Uo6cqes=DMD=juGJaB17eLymJL4tCLerwvw@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

On Sun, Apr 28, 2024 at 9:13=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Heinrich Schuchardt wrote:
> > We already support the VisionFive 2 and the Milk-V Mars board by
> > patching the VisionFive 2 device tree. With this patch the same
> > is done for the Milk-V Mars CM.
>
> Hi Heinrich.
>
> Thanks for the patch. As far as I can tell the Milk-V documentation[1] is
> pretty consistent in calling the version without eMMC "Milk-V Mars CM Lit=
e"
> and the version with eMMC just "Milk-V Mars CM". So I'd prefer the model,
> compatible and filenames suggested below.
>
> [1]: https://milkv.io/docs/mars/compute-module/introduction#design-philos=
ophy
>

Are there any actual differences that need representation in the dtb
file for downstream OS different from Milk-V Mars to Milk-V Mars CM
(or CM Lite)?

I did find this vendor repo commit "kernel: dts reconfig sdio0 for
SDCard version"
https://github.com/milkv-mars/mars-buildroot-sdk/commit/042ea06598995db99dd=
bbbb252ee439c42b9c1a9
but it does not seem necessary in mainline Linux, SD Card is working
without changes.

It was necessary for U-Boot and the Mars CM Lite with SD Card to apply
s/GPIO62/GPIO22/ as in the vendor commit "u-boot: configure sdio0 as
mars-cm sdcard version"
https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ecf1e2=
947dfeb2c66e5035fce90

Then also there is some mention about PMIC and renamed i2c reference,
already obsolete. That's all, is there more to it? Possibly a dtb for
Mars is enough to also be used on Mars CM and Mars Lite?

-E

> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
> >  .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
> >  2 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfi=
ve2/spl.c
> > index 45848db6d8b..bb0f28d7aad 100644
> > --- a/board/starfive/visionfive2/spl.c
> > +++ b/board/starfive/visionfive2/spl.c
> > @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
> >       }
> >  }
> >
> > +void spl_fdt_fixup_marc(void *fdt)
> > +{
> > +     const char *compat;
> > +     const char *model;
> > +
> > +     spl_fdt_fixup_mars(fdt);
> > +
> > +     if (!get_mmc_size_from_eeprom()) {
> > +             int offset;
> > +
> > +             model =3D "Milk-V Mars CM SDCard";
>
> "Milk-V Mars CM Lite"
>
> > +             compat =3D "milkv,mars-cm-sdcard\0starfive,jh7110";
>
> "milkv,mars-cm-lite\0starfive,jh7110"
>
> > +
> > +             offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/m=
mc0-pins-rest");
> > +             fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> > +     } else {
> > +             model =3D "Milk-V Mars CM eMMC";
>
> "Milk-V Mars CM"
>
> > +             compat =3D "milkv,mars-cm-emmc\0starfive,jh7110";
>
> "milkv,mars-cm\0starfive,jh7110"
>
> > +     }
> > +     fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,=
 sizeof(compat));
> > +     fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model=
);
> > +}
> > +
> >  void spl_fdt_fixup_version_a(void *fdt)
> >  {
> >       static const char compat[] =3D "starfive,visionfive-2-v1.2a\0star=
five,jh7110";
> > @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_=
image)
> >               pr_err("Can't read EEPROM\n");
> >               return;
> >       }
> > -     if (!strncmp(product_id, "MARS", 4)) {
> > +     if (!strncmp(product_id, "MARC", 4)) {
> > +             spl_fdt_fixup_marc(spl_image->fdt_addr);
> > +     } else if (!strncmp(product_id, "MARS", 4)) {
> >               spl_fdt_fixup_mars(spl_image->fdt_addr);
> >       } else if (!strncmp(product_id, "VF7110", 6)) {
> >               version =3D get_pcb_revision_from_eeprom();
> > diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/=
starfive/visionfive2/starfive_visionfive2.c
> > index a86bca533b2..be6ca85b030 100644
> > --- a/board/starfive/visionfive2/starfive_visionfive2.c
> > +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> > @@ -17,6 +17,10 @@
> >  DECLARE_GLOBAL_DATA_PTR;
> >  #define JH7110_L2_PREFETCHER_BASE_ADDR               0x2030000
> >  #define JH7110_L2_PREFETCHER_HART_OFFSET     0x2000
> > +#define FDTFILE_MILK_V_MARC_SD \
> > +     "starfive/jh7110-milkv-mars-cm-sdcard.dtb"
>
> "starfive/jh7110-milkv-mars-cm-lite.dtb"
>
> > +#define FDTFILE_MILK_V_MARC_MMC \
> > +     "starfive/jh7110-milkv-mars-cm-emmc.dtb"
>
> "starfive/jh7110-milkv-mars-cm.dtb"
>
> >  #define FDTFILE_MILK_V_MARS \
> >       "starfive/jh7110-milkv-mars.dtb"
> >  #define FDTFILE_VISIONFIVE2_1_2A \
> > @@ -61,7 +65,12 @@ static void set_fdtfile(void)
> >               log_err("Can't read EEPROM\n");
> >               return;
> >       }
> > -     if (!strncmp(product_id, "MARS", 4)) {
> > +     if (!strncmp(product_id, "MARC", 4)) {
> > +             if (get_mmc_size_from_eeprom())
> > +                     fdtfile =3D FDTFILE_MILK_V_MARC_MMC;
> > +             else
> > +                     fdtfile =3D FDTFILE_MILK_V_MARC_SD;
> > +     } else if (!strncmp(product_id, "MARS", 4)) {
> >               fdtfile =3D FDTFILE_MILK_V_MARS;
> >       } else if (!strncmp(product_id, "VF7110", 6)) {
> >               version =3D get_pcb_revision_from_eeprom();
> > --
> > 2.43.0
> >
> >
