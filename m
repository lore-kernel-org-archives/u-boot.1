Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA11EC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 21:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7097881C3;
	Wed, 22 May 2024 23:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+MQe3Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E21BF88422; Wed, 22 May 2024 23:35:49 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFB187C7E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so70033641fa.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716413747; x=1717018547; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsE08N/hUMKhUWSG8nI2cbEsA++e1gBiMjMxxGTtGhk=;
 b=Q+MQe3Fs0DKsml7vidkDeU4L3O3gAX/eQT6HDNy0MfysC+EXXlxEHO98QKiIcae8VI
 2WHUfi0zFI2RLwfvaLonn9BdPrUWwsv5e9ShnmdOvFZWBAs0ksV6dQIcsfTHXoWv5rF9
 KpY/pJqciX4xJGhoR0wtTq+s8XdnoG5mW3N86qPXggWwH6aV9M1NCwVqt6sD0QJPapt6
 7dM9zxHqHs1Kwpz9co2Bbmr6OS3++JGqBipRy31Jic47898KJGGa5ihaBc+FxY3SEYRi
 1YXg0W9QGbar/Do7XU/ZCLUZDMJ6kYK58Q+W6elHSEz/OIUi8O9qQXJir1OHqIu5JHPK
 C55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413747; x=1717018547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsE08N/hUMKhUWSG8nI2cbEsA++e1gBiMjMxxGTtGhk=;
 b=c6QaP51TqMJLG0S44SSxkujBhtQeFEED2ySSaJysKoqKw0Ggyl+tDBsEvsG/mzt8Uh
 mi8lZioSHxm0zYX2VleBSy5ZK+zTgIIFw09zsan/xXztsSY6CkUvIo1KZ89kD3kkzoNq
 c3+CEJea27SHkbxU4S1NxovoNr2op3/VIp6z3Xg+wBdz/hOGOrT0MROio0o4FM1GFrQX
 FaP0avCLyPZoIUHWjYFXMRJVIl/I3A4gmDVoaSzPiMTapLSOVEcwuGMTa5bLh3UOId6l
 DTByz1DtmUwP1Y0evkr9+crFCxxz8ZyeZWSVsMbrBbU+ugHV0n6JeATjCgPdFk5JA52n
 4CEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQlZ7lEwUr2kRBDC/OmGBb/EJuKXFL4aksnR8wuNDV7XHvnC8ePTBXg2r2RLTispI4pI4awZypxBqV8G+pcyMczvuylw==
X-Gm-Message-State: AOJu0Yw7sC+7rwjl/U7iC34sM093N22wsmKuGKrpH01DfOYMMZqCCLyk
 AN4bEEb6xCvM9kJbQjuMSiJUdn+ZFSIFQVzHIjdf3kCOqmIppzNe7EWnj0e84kDyZFA8RksirEV
 BYVoITPykVHDYzkcTJu+UzSMPkH8=
X-Google-Smtp-Source: AGHT+IFJZEcfM2XNEpfl8OwuW/dLNmnbgApUvoG+LC92N29sLLnMH5onf01gNNa8cSXNuJNSFwum9k+SYyFjKX2qZBo=
X-Received: by 2002:a2e:6a0e:0:b0:2e0:dc93:52ef with SMTP id
 38308e7fff4ca-2e9494f5017mr21680881fa.26.1716413746478; Wed, 22 May 2024
 14:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240519125337.2557883-1-r.stratiienko@gmail.com>
 <874japzz3s.fsf@baylibre.com>
In-Reply-To: <874japzz3s.fsf@baylibre.com>
From: Roman Stratiienko <r.stratiienko@gmail.com>
Date: Thu, 23 May 2024 00:35:35 +0300
Message-ID: <CAGphcd=ewtSE8VkfX=c4CL6-L7wj9badr3v_2Ep9QvJqHjZEiw@mail.gmail.com>
Subject: Re: [PATCH] abootimg: Add init_boot image support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: sjg@chromium.org, eajames@linux.ibm.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, paulerwan.rio@gmail.com, u-boot@lists.denx.de, 
 igor.opaniuk@gmail.com
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

Hi Mattijs,

Thank you for your review.

=D1=81=D1=80, 22 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 17:43, Matt=
ijs Korpershoek <mkorpershoek@baylibre.com>:
>
> Hi Roman,
>
> Thank you for the patch.
>
> On dim., mai 19, 2024 at 12:53, Roman Stratiienko <r.stratiienko@gmail.co=
m> wrote:
>
> > Quote from [1]:
> >
> > "For devices launching with Android 13, the generic ramdisk is removed
> > from the boot image and placed in a separate init_boot image.
> > This change leaves the boot image with only the GKI kernel."
> >
> > [1]: https://source.android.com/docs/core/architecture/partitions/gener=
ic-boot
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > ---
> >  boot/image-board.c |  5 ++++-
> >  cmd/abootimg.c     | 26 +++++++++++++++++++++-----
> >  include/image.h    |  7 +++++++
> >  3 files changed, 32 insertions(+), 6 deletions(-)
>
> This patch does not apply on:
> - next: 7d24c3e06fa9 ("Merge patch series "scripts/setlocalversion sync w=
ith linux 6.9"")
> - master: a7f0154c4128 ("Prepare v2024.07-rc3")
>
> Please consider rebasing when resending.

V2 Rebased

>
> More review below
>
> >
> > diff --git a/boot/image-board.c b/boot/image-board.c
> > index 75f6906cd5..715654ff01 100644
> > --- a/boot/image-board.c
> > +++ b/boot/image-board.c
> > @@ -414,9 +414,12 @@ static int select_ramdisk(struct bootm_headers *im=
ages, const char *select, u8 a
> >                       int ret;
> >                       if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
> >                               void *boot_img =3D map_sysmem(get_abootim=
g_addr(), 0);
> > +                             void *init_boot_img =3D map_sysmem(get_ai=
nit_bootimg_addr(), 0);
> >                               void *vendor_boot_img =3D map_sysmem(get_=
avendor_bootimg_addr(), 0);
> > +                             void *ramdisk_img =3D (init_boot_img =3D=
=3D -1) ? boot_img :
> > +                                                                      =
   init_boot_img;
>
> This line introduces a build warning:
>
> ../boot/image-board.c: In function =E2=80=98select_ramdisk=E2=80=99:
> ../boot/image-board.c:412:68: warning: comparison between pointer and int=
eger
>   412 |                                 void *ramdisk_img =3D (init_boot_=
img =3D=3D -1) ? boot_img :
>       |                                                                  =
  ^~
>
> Can we please fix it in v2 ?

Fixed

>
> >
> > -                             ret =3D android_image_get_ramdisk(boot_im=
g, vendor_boot_img,
> > +                             ret =3D android_image_get_ramdisk(ramdisk=
_img, vendor_boot_img,
> >                                                               rd_datap,=
 rd_lenp);
> >                               unmap_sysmem(vendor_boot_img);
>
> Can we please add unmap_sysmem(init_boot_img); here as well ?

Done.

>
> >                               unmap_sysmem(boot_img);
> > diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> > index e68c523705..7c450a3b2d 100644
> > --- a/cmd/abootimg.c
> > +++ b/cmd/abootimg.c
> > @@ -17,6 +17,7 @@
> >
> >  /* Please use abootimg_addr() macro to obtain the boot image address *=
/
> >  static ulong _abootimg_addr =3D -1;
> > +static ulong _ainit_bootimg_addr =3D -1;
> >  static ulong _avendor_bootimg_addr =3D -1;
> >
> >  ulong get_abootimg_addr(void)
> > @@ -24,6 +25,11 @@ ulong get_abootimg_addr(void)
> >       return (_abootimg_addr =3D=3D -1 ? image_load_addr : _abootimg_ad=
dr);
> >  }
> >
> > +ulong get_ainit_bootimg_addr(void)
> > +{
> > +     return _ainit_bootimg_addr;
> > +}
> > +
> >  ulong get_avendor_bootimg_addr(void)
> >  {
> >       return _avendor_bootimg_addr;
> > @@ -209,7 +215,7 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, =
int flag, int argc,
> >       char *endp;
> >       ulong img_addr;
> >
> > -     if (argc < 2 || argc > 3)
> > +     if (argc < 2 || argc > 4)
> >               return CMD_RET_USAGE;
> >
> >       img_addr =3D hextoul(argv[1], &endp);
> > @@ -220,16 +226,26 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp=
, int flag, int argc,
> >
> >       _abootimg_addr =3D img_addr;
> >
> > -     if (argc =3D=3D 3) {
> > +     if (argc > 2) {
> >               img_addr =3D simple_strtoul(argv[2], &endp, 16);
> >               if (*endp !=3D '\0') {
> > -                     printf("Error: Wrong vendor image address\n");
> > +                     printf("Error: Wrong vendor_boot image address\n"=
);
>
> Nitpick: this seems like a harmless change but could be done in a
> separate patch.
>
> To me, it's fine to include this hunk, but can we mention it in the
> commit message?
>
> Something along the lines as "While at it, update wrong error handling
> message when vendor_boot cannot be loaded".

Added.

>
> >                       return CMD_RET_FAILURE;
> >               }
> >
> >               _avendor_bootimg_addr =3D img_addr;
> >       }
> >
> > +     if (argc =3D=3D 4) {
> > +             img_addr =3D simple_strtoul(argv[3], &endp, 16);
> > +             if (*endp !=3D '\0') {
> > +                     printf("Error: Wrong init_boot image address\n");
> > +                     return CMD_RET_FAILURE;
> > +             }
> > +
> > +             _ainit_bootimg_addr =3D img_addr;
> > +     }
> > +
> >       return CMD_RET_SUCCESS;
> >  }
> >
> > @@ -346,7 +362,7 @@ fail:
> >  }
> >
> >  static struct cmd_tbl cmd_abootimg_sub[] =3D {
> > -     U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
> > +     U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
> >       U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
> >       U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
> >       U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
> > @@ -375,7 +391,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int f=
lag, int argc,
> >  U_BOOT_CMD(
> >       abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
> >       "manipulate Android Boot Image",
> > -     "addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
> > +     "addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_add=
r>]]\n"
> >       "    - set the address in RAM where boot image is located\n"
> >       "      ($loadaddr is used by default)\n"
>
> Please include the help text update in the documentation:
> doc/android/boot-image.rst

That documentation does not mention 'abootimg addr' command at the moment.
I do not see an easy way to add it in a way that makes sense.

>
> >       "abootimg dump dtb\n"
> > diff --git a/include/image.h b/include/image.h
> > index be3c73a72e..b1fd6b3149 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -1982,6 +1982,13 @@ bool is_android_vendor_boot_image_header(const v=
oid *vendor_boot_img);
> >   */
> >  ulong get_abootimg_addr(void);
> >
> > +/**
> > + * get_ainit_bootimg_addr() - Get Android init boot image address
> > + *
> > + * Return: Android init boot image address
> > + */
> > +ulong get_ainit_bootimg_addr(void);
> > +
> >  /**
> >   * get_avendor_bootimg_addr() - Get Android vendor boot image address
> >   *
> > --
> > 2.40.1
