Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E65C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 00:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7BF87E64;
	Mon, 22 Jul 2024 02:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4TzALOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4487A87D87; Mon, 22 Jul 2024 02:13:16 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA1787D87
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 02:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f04150796so410256e87.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721607193; x=1722211993; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmfU0OTzGfAjMzWIVJUHpbTfeM9eq5EQ5ZJH3J/DtL8=;
 b=e4TzALOQ3L5g9oGRw6TVcW2ivKwbwqSdQnfEepctplGI8IPJ/jRiY8Xs8O63t+mGVx
 XJWUmxeI7odm3mgKwquDqzowspvSdg8qvYw3fH98bS8ZFKPc+r/xKjbj8lAkvLfFf2c3
 3Ndi2r6HQ5yGJVQzfOcyJGAjYt6msxZGeB9egP4IpUol57NjCiYocCY+CRp3UzitFf5M
 JhWc/qw/v0hZQkGLhrPwAFL6Bk05UqsZRnGDLNh26hI1WyH5QYnElHBFOln7U7/lV87E
 7pimVXqdIRtO6Tc6HhTnIPa/xnGusWh0Qsd5w7EH17VQS5IxPi7Zj8el+q03Q/xJ+fDb
 QULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607193; x=1722211993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmfU0OTzGfAjMzWIVJUHpbTfeM9eq5EQ5ZJH3J/DtL8=;
 b=XzG8ItM0aOVn4un1tFykvElHuZv1UEKK7klaikLDGSL5JjiQIcM5dRKLDsrZ37tSuW
 bCWBogeIXqYgOK6fdcouUOF81kk3LBH/LzY3/PhSV7GjIMhajuDfQ4e5z+aiVNgfaKrB
 gm1ndV78eZt1StubS5gH1KaS5l9PPhpfrhCcUqzQcPUzn22v5zKehqeWOkHNotzQXGNg
 MZr7CUTt9HJY2+FVmC3Cxo/PMo9vSJlCv6y95jG1zEyhTA2ZwHVmMK5wOViHLKcC7qJ7
 d6J/j5BfRQ0E8FO6fI0+o9QXCEDpC4uds5a8+ayzNIANfNyUhadER6wAhCpLyNZFsygb
 XXmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXtCX32Us/+edUWHcEhCaaKskI5hq7DhZUxue5rdly6KrXq3bEyTtsZI7OKUvxV1ETrY6eksi1hRh/3knPS3KwCiSJZQ==
X-Gm-Message-State: AOJu0YzsQQuYX59c2a/T3d7fPGFddNDNs4ZuY7hwCHi7qle1wDXD+KV4
 zVCXxSXJZPXd+MlFFmHiOwnrfYDio0zao+Mog2gXG4cf6PAEOjCF1N08KYV3o2VlBdyJGYM24kN
 img7qjQmsAw968pwmqNkNqkx/0/A=
X-Google-Smtp-Source: AGHT+IHEKMWcU8Vle50UTdGzIPxKeawzvB0zAGTFNTeH2uaMNoufT3Axt4ONQ+8PKKb4/WGqjXWfCn4HWjVzTYU1lyI=
X-Received: by 2002:a05:6512:3f1a:b0:52c:dbe7:cfd5 with SMTP id
 2adb3069b0e04-52efb7685cemr3305074e87.32.1721607192999; Sun, 21 Jul 2024
 17:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
 <CANV2PTPOesJWcbYhVeiQWonccy3rWdQmN5qfuJtFN+JpnYNzbA@mail.gmail.com>
 <CANV2PTOWVCTWiyQoA4vEro61WwFSPBaGbrsBN-zXVwm2daHvJg@mail.gmail.com>
 <61c16b44-90cb-4834-a81d-c1a90ab2117d@canonical.com>
In-Reply-To: <61c16b44-90cb-4834-a81d-c1a90ab2117d@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 21 Jul 2024 17:13:01 -0700
Message-ID: <CANV2PTMn1CPnxSxpDgdxDduMh+aKgC2Jh_WknOyORwQY8ESxOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] board: fix compatible property Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, Hal Feng <hal.feng@starfivetech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de
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

On Sun, Jul 21, 2024 at 2:42=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/21/24 23:27, E Shattow wrote:
> > P.S. my suggestion below
> >
> > On Fri, Jul 19, 2024 at 5:06=E2=80=AFPM E Shattow <lucent@gmail.com> wr=
ote:
> >>
> >> On Fri, Jul 19, 2024 at 4:12=E2=80=AFPM Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> For the Milk-V Mars CM (lite) we have only been copying sizeof(void *=
)
> >>> bytes to the compatible property instead of the whole string list.
> >>
> >> This const char array must be so that we may get an accurate data
> >> length with sizeof() but it highlights there are helper functions for
> >> get of fdt stringlist and not for set of fdt stringlist.
> >>
> >>>
> >>> Fixes: de3229599d4f ("board: add support for Milk-V Mars CM")
> >>> Reported-by: E Shattow <lucent@gmail.com>
> >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com=
>
> >>> ---
> >>>   board/starfive/visionfive2/spl.c | 15 ++++++++++++---
> >>>   1 file changed, 12 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/vision=
five2/spl.c
> >>> index b794b73b6bd..f55c6b5d34c 100644
> >>> --- a/board/starfive/visionfive2/spl.c
> >>> +++ b/board/starfive/visionfive2/spl.c
> >>> @@ -170,23 +170,32 @@ void spl_fdt_fixup_mars_cm(void *fdt)
> >>>   {
> >>>          const char *compat;
> >>>          const char *model;
> >>> +       int compat_size;
> >>>
> >>>          spl_fdt_fixup_mars(fdt);
> >>>
> >>>          if (!get_mmc_size_from_eeprom()) {
> >>>                  int offset;
> >>> +               static const char
> >>> +               compat_cm_lite[] =3D "milkv,mars-cm-lite\0starfive,jh=
7110";
> >>>
> >>>                  model =3D "Milk-V Mars CM Lite";
> >>> -               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> >>> +               compat =3D compat_cm_lite;
> >>> +               compat_size =3D sizeof(compat_cm_lite);
> >>>
> >>>                  offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-p=
ins/mmc0-pins-rest");
> >>>                  /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GP=
I_NONE) */
> >>>                  fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> >>>          } else {
> >>> +               static const char
> >>> +               compat_cm[] =3D "milkv,mars-cm\0starfive,jh7110";
> >>> +
> >>>                  model =3D "Milk-V Mars CM";
> >>> -               compat =3D "milkv,mars-cm\0starfive,jh7110";
> >>> +               compat =3D compat_cm;
> >>> +               compat_size =3D sizeof(compat_cm);
> >>>          }
> >>> -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", com=
pat, sizeof(compat));
> >>> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
> >>> +                   "compatible", compat, compat_size);
> >>>          fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", =
model);
> >>>   }
> >>>
> >>> --
> >>> 2.45.2
> >>>
> >>
> >> -E
> >
> > What about something like as follows?
> >
> >   void spl_fdt_fixup_mars(void *fdt)
> >   {
> > -       static const char compat[] =3D "milkv,mars\0starfive,jh7110";
> >          u32 phandle;
> >          u8 i;
> >          int offset;
> >          int ret;
> >
> > -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
> > compat, sizeof(compat));
> > -       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> > -                          "Milk-V Mars");
> > +       offset =3D fdt_path_offset(fdt, "/");
> > +       fdt_setprop_string(fdt,    offset, "compatible", "milkv,mars");
> > +       fdt_appendprop_string(fdt, offset, "compatible", "starfive,jh71=
10");
> > +       fdt_setprop_string(fdt,    offset, "model",      "Milk-V Mars")=
;
> >
> >          /* gmac0 */
> >          offset =3D fdt_path_offset(fdt, "/soc/clock-controller@1700000=
0");
> > @@ -164,30 +226,31 @@ void spl_fdt_fixup_mars(void *fdt)
> >                                  break;
> >                  }
> >          }
> >   }
> >
> >   void spl_fdt_fixup_mars_cm(void *fdt)
> >   {
> > -       const char *compat;
> > -       const char *model;
> > +       int offset;
> >
> >          spl_fdt_fixup_mars(fdt);
> >
> >          if (!get_mmc_size_from_eeprom()) {
> > -               int offset;
> > -
> > -               model =3D "Milk-V Mars CM Lite";
> > -               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> > +               offset =3D fdt_path_offset(fdt, "/");
> > +               fdt_setprop_string(fdt, offset, "compatible",
> > "milkv,mars-cm-lite");
> > +               fdt_appendprop_string(fdt, offset, "compatible",
> > "starfive,jh7110");
> > +               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars C=
M Lite");
> >
> >                  offset =3D fdt_path_offset(fdt,
> > "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
> >                  /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_=
NONE) */
> >                  fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> >          } else {
> > -               model =3D "Milk-V Mars CM";
> > -               compat =3D "milkv,mars-cm\0starfive,jh7110";
> > +               offset =3D fdt_path_offset(fdt, "/");
> > +               fdt_setprop_string(fdt, offset, "compatible", "milkv,ma=
rs-cm");
> > +               fdt_appendprop_string(fdt, offset, "compatible",
> > "starfive,jh7110");
> > +               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars C=
M");
> >          }
> > -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
> > compat, sizeof(compat));
> > -       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", mod=
el);
> >   }
> >
> >   void spl_fdt_fixup_version_a(void *fdt)
> > @@ -235,6 +298,7 @@ void spl_fdt_fixup_version_a(void *fdt)
> >                                  break;
> >                  }
> >          }
> > +
> >   }
> >
> >
> > And similar changes to the other "string1\0string2" settings in the
> > same source file.
> >
> > -E
>
> You did not mention why you would prefer three function calls (including
> strlen()) instead of one.
>
> Your code should work too but results in a larger code size.
>
> Probably the shortest code would use a common function with parameters
> 'model' and 'compatible_1st' for each of the boards and then use
> fdt_appendprop_string() to append the common 2nd compatible string.
>
> Best regards
>
> Heinrich

You are correct and your patch does efficiently fix the bug.

We can try to reduce code size and function calls further by
consolidation of the duplicate bytes of static data "starfive,jh7110"
in several locations and calling that as an fdt_appendprop_string()
only once after the selected specialized fixup function has returned.
But this would be clever and being clever is a reason why the bug is
here.

With OF_UPSTREAM most of the fdt setting function calls will be washed out.

If just writing easy-to-read code using the helper functions and
static data to parameters then this type of bug is not possible. But
if you prefer your efficient fix then that is not any problem for me.

-E
