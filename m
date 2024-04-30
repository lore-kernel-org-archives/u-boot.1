Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52987C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 10:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D06F889B6;
	Tue, 30 Apr 2024 12:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5fHQrN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF398899F; Tue, 30 Apr 2024 12:00:07 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60749886BF
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 12:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-479edfd02e4so1781457137.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714471204; x=1715076004; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o6Ku17vPaTtVmXfYxXvv2cKTrWsqzd7PeyjQ4EnXuY=;
 b=U5fHQrN07I9umLYFsg1yqQQ9e6iouEL3vJgjpAW3YY6xoitXDDmeYTYvxg6YpeMzD0
 m2AJC2Xp4q/fhBEjPqrhlxPimMvv+5kUa4K/q9PuCuWzQYo1bk0FVychO8LYF2yehwya
 UxPQHDDV2bojxJ2bmlHGUjtffRFebDJB2hFcbJAGjTDotmKGUK4q6wxlvhDxh0Ezl4NY
 FO3fvTcxZfFy+IR0Tbvl7yBq9pG8hSDVnlolViUY4GtFpJ0XUUsnZNfr4YQFuUi1WlTe
 U7pZ41j0nqG4JJNPHgsWdk6TahL5kyNDwYWR2gs0yoPMT0HlMrfCBKpFrFrXaX42uABl
 AXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714471204; x=1715076004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o6Ku17vPaTtVmXfYxXvv2cKTrWsqzd7PeyjQ4EnXuY=;
 b=eSDzNqvrXQKdz9/hftWvPCYie6aLF44BiDoKD05E4pTqQeaP4qEkJr3ksBi90br3dH
 iyYAVAAvNx815tT2o332o0H+xtHoCtxb3fbleZb/Bw566M2ipXVpIVnJjUjtOulSUGDJ
 M7PG0ajUB+vmVNW0mr8FW32c7SmpZpU+vGPROYRqv1RJEkCIaBmMCQ+St5X2EeoCzQGY
 nH8VSCypADpG+jRPmRTdwxiHYw8LVPdfpQqJW9c5JXyrnc+R5VMu0KcVq1xiPKkqDydW
 05xr22FHH02gLunKwjIykoX6Ih87Z/RcWFigiFZzVECwKE6rOYr/k5dCq440JGLcT1+5
 4/Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMmG+VIwcpaFBkqCx9Lc8cbNns2QB2Md6G90jCP5kI9SGdr4NgXoWY17CWTBT7LI4aSuiQsIekdhy3t1ru5X0Us8Qw5A==
X-Gm-Message-State: AOJu0Yy5PQ9kLkNN0OIaAD45Vqs2AHl2dCIZl6KgDqTKZsmLAQbMHYbT
 IacLJeebMwHG5TPfds3D9F8Xtzjm5bS0Z63OBmb0cZNnHh6Q7eRTgyZlzlxO3bVsXwqqvI6Rbks
 Ebv0mCrudYMh03NdmX5B6QH0xAhY=
X-Google-Smtp-Source: AGHT+IGiVfjiSgoYEviHp4B6WdXUhbCHL5wkF41mPqPQ+v8DSC4Mai1psgh7sblNnKcMQ/N6InzkRK0fFt0e0+ENgpM=
X-Received: by 2002:a67:efc4:0:b0:47b:b817:f31f with SMTP id
 s4-20020a67efc4000000b0047bb817f31fmr11851837vsp.9.1714471204045; Tue, 30 Apr
 2024 03:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
 <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
 <CANV2PTO1EAkgf_4Uo6cqes=DMD=juGJaB17eLymJL4tCLerwvw@mail.gmail.com>
 <7138128e-1e48-42a0-8114-2d4cdde25ce0@canonical.com>
In-Reply-To: <7138128e-1e48-42a0-8114-2d4cdde25ce0@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 30 Apr 2024 02:59:52 -0700
Message-ID: <CANV2PTPci_WVDnerZ1QxPYSio869XiRq21E-pezeD03X3teqEw@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

On Tue, Apr 30, 2024 at 12:18=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.24 00:46, E Shattow wrote:
> > On Sun, Apr 28, 2024 at 9:13=E2=80=AFAM Emil Renner Berthing
> > <emil.renner.berthing@canonical.com> wrote:
> >>
> >> Heinrich Schuchardt wrote:
> >>> We already support the VisionFive 2 and the Milk-V Mars board by
> >>> patching the VisionFive 2 device tree. With this patch the same
> >>> is done for the Milk-V Mars CM.
> >>
> >> Hi Heinrich.
> >>
> >> Thanks for the patch. As far as I can tell the Milk-V documentation[1]=
 is
> >> pretty consistent in calling the version without eMMC "Milk-V Mars CM =
Lite"
> >> and the version with eMMC just "Milk-V Mars CM". So I'd prefer the mod=
el,
> >> compatible and filenames suggested below.
> >>
> >> [1]: https://milkv.io/docs/mars/compute-module/introduction#design-phi=
losophy
> >>
> >
> > Are there any actual differences that need representation in the dtb
> > file for downstream OS different from Milk-V Mars to Milk-V Mars CM
> > (or CM Lite)?
> >
> > I did find this vendor repo commit "kernel: dts reconfig sdio0 for
> > SDCard version"
> > https://github.com/milkv-mars/mars-buildroot-sdk/commit/042ea06598995db=
99ddbbbb252ee439c42b9c1a9
> > but it does not seem necessary in mainline Linux, SD Card is working
> > without changes.
> >
> > It was necessary for U-Boot and the Mars CM Lite with SD Card to apply
> > s/GPIO62/GPIO22/ as in the vendor commit "u-boot: configure sdio0 as
> > mars-cm sdcard version"
> > https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ec=
f1e2947dfeb2c66e5035fce90
>
> This is what is patched in fdt_fixup_marc().

That's the Mars fixup with a conditional for the s/GPIO62/GPIO22/ of
CM Lite;  which Linux seems not to mind either way so long as this was
done at the U-Boot phase, it is functional for eMMC/SD mmc access with
unmodified visionfive2 1.3b dtb (GPIO62 pinmux) from Linux.

It is not clear to me why in vendor U-Boot this is s/GPIO62/GPIO22/
but in vendor Linux kernel this is s/GPIO62/GPIO24/ ? It seems not
needed (in Linux).

>
> >
> > Then also there is some mention about PMIC and renamed i2c reference,
> > already obsolete. That's all, is there more to it? Possibly a dtb for
> > Mars is enough to also be used on Mars CM and Mars Lite?
>
> Looking at the schematics the biggest difference between the Mars and
> the Mars CM (Lite) is on the USB side. The Mars board has USB 3.0 via a
> PCIe lane and a VIA VL805/806 while the Mars CM has USB directly via the
> SoC.
>
> To add USB support for the Mars CM we will need an adapted device-tree.

Mars also needs this direct-to-SoC USB support, as its USB ports are a
mix of VL805 and directly via the SoC. This can be the same for Mars
and Mars CM/Lite.

See this photo from
https://milkv.io/docs/mars/getting-started/bootloader what highlights
this direct SoC USB port of Milk-V Mars:
https://milkv.io/assets/images/mars-usb-port-a-b48fe1ff1003539d42bf5e1dde17=
25a3.jpg

The over-current errata
https://doc-en.rvspace.org/VisionFive2/DG_USB/JH7110_SDK/usb_overcurrent_de=
bug.html
suggests "please modify the above settings during the U-Boot phase".

-E

>
> Best regards
>
> Heinrich
> >
> >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com=
>
> >>> ---
> >>>   board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++=
++-
> >>>   .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
> >>>   2 files changed, 36 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/vision=
five2/spl.c
> >>> index 45848db6d8b..bb0f28d7aad 100644
> >>> --- a/board/starfive/visionfive2/spl.c
> >>> +++ b/board/starfive/visionfive2/spl.c
> >>> @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
> >>>        }
> >>>   }
> >>>
> >>> +void spl_fdt_fixup_marc(void *fdt)
> >>> +{
> >>> +     const char *compat;
> >>> +     const char *model;
> >>> +
> >>> +     spl_fdt_fixup_mars(fdt);
> >>> +
> >>> +     if (!get_mmc_size_from_eeprom()) {
> >>> +             int offset;
> >>> +
> >>> +             model =3D "Milk-V Mars CM SDCard";
> >>
> >> "Milk-V Mars CM Lite"
> >>
> >>> +             compat =3D "milkv,mars-cm-sdcard\0starfive,jh7110";
> >>
> >> "milkv,mars-cm-lite\0starfive,jh7110"
> >>
> >>> +
> >>> +             offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins=
/mmc0-pins-rest");
> >>> +             fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> >>> +     } else {
> >>> +             model =3D "Milk-V Mars CM eMMC";
> >>
> >> "Milk-V Mars CM"
> >>
> >>> +             compat =3D "milkv,mars-cm-emmc\0starfive,jh7110";
> >>
> >> "milkv,mars-cm\0starfive,jh7110"
> >>
> >>> +     }
> >>> +     fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compa=
t, sizeof(compat));
> >>> +     fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", mod=
el);
> >>> +}
> >>> +
> >>>   void spl_fdt_fixup_version_a(void *fdt)
> >>>   {
> >>>        static const char compat[] =3D "starfive,visionfive-2-v1.2a\0s=
tarfive,jh7110";
> >>> @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *sp=
l_image)
> >>>                pr_err("Can't read EEPROM\n");
> >>>                return;
> >>>        }
> >>> -     if (!strncmp(product_id, "MARS", 4)) {
> >>> +     if (!strncmp(product_id, "MARC", 4)) {
> >>> +             spl_fdt_fixup_marc(spl_image->fdt_addr);
> >>> +     } else if (!strncmp(product_id, "MARS", 4)) {
> >>>                spl_fdt_fixup_mars(spl_image->fdt_addr);
> >>>        } else if (!strncmp(product_id, "VF7110", 6)) {
> >>>                version =3D get_pcb_revision_from_eeprom();
> >>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/boar=
d/starfive/visionfive2/starfive_visionfive2.c
> >>> index a86bca533b2..be6ca85b030 100644
> >>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> >>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> >>> @@ -17,6 +17,10 @@
> >>>   DECLARE_GLOBAL_DATA_PTR;
> >>>   #define JH7110_L2_PREFETCHER_BASE_ADDR               0x2030000
> >>>   #define JH7110_L2_PREFETCHER_HART_OFFSET     0x2000
> >>> +#define FDTFILE_MILK_V_MARC_SD \
> >>> +     "starfive/jh7110-milkv-mars-cm-sdcard.dtb"
> >>
> >> "starfive/jh7110-milkv-mars-cm-lite.dtb"
> >>
> >>> +#define FDTFILE_MILK_V_MARC_MMC \
> >>> +     "starfive/jh7110-milkv-mars-cm-emmc.dtb"
> >>
> >> "starfive/jh7110-milkv-mars-cm.dtb"
> >>
> >>>   #define FDTFILE_MILK_V_MARS \
> >>>        "starfive/jh7110-milkv-mars.dtb"
> >>>   #define FDTFILE_VISIONFIVE2_1_2A \
> >>> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
> >>>                log_err("Can't read EEPROM\n");
> >>>                return;
> >>>        }
> >>> -     if (!strncmp(product_id, "MARS", 4)) {
> >>> +     if (!strncmp(product_id, "MARC", 4)) {
> >>> +             if (get_mmc_size_from_eeprom())
> >>> +                     fdtfile =3D FDTFILE_MILK_V_MARC_MMC;
> >>> +             else
> >>> +                     fdtfile =3D FDTFILE_MILK_V_MARC_SD;
> >>> +     } else if (!strncmp(product_id, "MARS", 4)) {
> >>>                fdtfile =3D FDTFILE_MILK_V_MARS;
> >>>        } else if (!strncmp(product_id, "VF7110", 6)) {
> >>>                version =3D get_pcb_revision_from_eeprom();
> >>> --
> >>> 2.43.0
> >>>
> >>>
>
