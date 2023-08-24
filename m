Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424E1C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 22:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A12486986;
	Fri, 25 Aug 2023 00:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIF2Wimu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C40869B7; Fri, 25 Aug 2023 00:40:49 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0F686961
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1cc61f514baso222709fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692916845; x=1693521645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvm7mUBrp7GT+qLLfySoMCAGtBP9KBmAuRC1rzUv7R0=;
 b=GIF2WimuGp2+OKJEzdYQIFmwNms2edCKZZBkH0dyGREuQmv7+jEyupB/WkP/T94p6o
 G4h/7/pyOjZxLgjLa+QPTCOHXEAEc9Nu7JI4k9edNWKRzBjqdWO6/Jdj5cARwAkJ5KdC
 dTW1yPFXTX7299tO0Zj7Qx8gDsbYd499ePSJVQ8I+9l80sM3mNchcFxgB+wK6rUn6uXr
 5NTwZgUiXkKJZy0nKgtwrFYraTIXwk+x88rFT1KBjlfaOtuCKqbmB9XH913oQZrcqcd4
 17sPZEZK5wNPEapQ3D7AKyIe5LELaK2rUpP2rZgdE9iHtScUdqODblmaA3s5ObgnKsaW
 xheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692916845; x=1693521645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvm7mUBrp7GT+qLLfySoMCAGtBP9KBmAuRC1rzUv7R0=;
 b=l7YDJfSysKFCEM6GWXyB6AsXloBGD17oOfqMzrvM2OL3ZLwlI8xU2fGyvwVoPLaSiP
 jVsIyvTH/smW1ucDdoAeQkWkD49lzaWDJoimUrAe5v6FduddgYW1FAWJ81cHRzSyFL9Y
 Jvqhw1zWV+KcKynrFzSupUI3aH+fElKPP/wCJPdeyCvF8OySi2680fmufT4Q0Akay5z3
 13+UTrjCDpVJO5lFqWvobYurRLbqvxbWSErE50pTpnFaGu0wbO+l1QDjinW1aYG+tl+7
 nc3G4twa/yo2WnyYAahKBU/OyYxd4onQZpJw1uukc0Z3gcA61P6u7S1r0doK4s9bUrU8
 ik6A==
X-Gm-Message-State: AOJu0YyNhZp4dncJmLv0jeg7TyWk8z8m5Kw/6A3T7mr4eLPlXWrmQwzd
 rigLNARobEXvxS049aHFf4+8Lrs793zPQPg7ZQc=
X-Google-Smtp-Source: AGHT+IFzC5cl9a8kj+4SB9+ayELNuRzYCxgsS8P9kqiXsyMCBhRb06pVI9xfVBBDF6a2/KXzfzoNp5452IGd23VCeN0=
X-Received: by 2002:a05:6870:f153:b0:1bb:eb37:1d69 with SMTP id
 l19-20020a056870f15300b001bbeb371d69mr1262761oac.14.1692916845033; Thu, 24
 Aug 2023 15:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
 <CAPnjgZ1NFEVDcu-qOhTrjNpTspJ5OcCUZrDJJkru0mY-McPhzw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1NFEVDcu-qOhTrjNpTspJ5OcCUZrDJJkru0mY-McPhzw@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Thu, 24 Aug 2023 18:40:09 -0400
Message-ID: <CAJFTR8S6Poz=CSK-Cb_k2ZVTH8bfQFFNeyH56d4CCeq80Shqtw@mail.gmail.com>
Subject: Re: [PATCH] Convert CFG_SYS_UBOOT_START to Kconfig
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, "Andrew F . Davis" <afd@ti.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Mingming lee <mingming.lee@mediatek.com>, Mauro Condarelli <mc5686@mclink.it>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Thu, Aug 24, 2023 at 4:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Jesse,
>
> On Wed, 23 Aug 2023 at 20:30, Jesse Taube <mr.bossman075@gmail.com> wrote=
:
> >
> > Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*"=
)
> > renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> > this meant that the value was no longer available to the Makefile. This
> > caused imxrt to fail to boot. All the other boards that used this
> > variable were unaffected because they were using the default value
> > which is CONFIG_TEXT_BASE.
> >
> > This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the defaul=
t
> > value to CONFIG_TEXT_BASE.
> >
> > Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> >  Makefile                                       | 16 ++++------------
> >  arch/arm/mach-k3/config_secure.mk              |  2 +-
> >  arch/arm/mach-omap2/config_secure.mk           |  2 +-
> >  boot/Kconfig                                   | 16 ++++++++++++++++
> >  common/spl/spl.c                               |  6 +-----
> >  common/spl/spl_fit.c                           |  2 +-
> >  configs/imxrt1020-evk_defconfig                |  2 ++
> >  configs/imxrt1050-evk_defconfig                |  2 ++
> >  configs/imxrt1170-evk_defconfig                |  2 ++
> >  include/configs/gardena-smart-gateway-mt7688.h |  4 ----
> >  include/configs/imxrt1020-evk.h                |  6 ------
> >  include/configs/imxrt1050-evk.h                |  6 ------
> >  include/configs/imxrt1170-evk.h                |  3 ---
> >  include/configs/linkit-smart-7688.h            |  4 ----
> >  include/configs/mt7620.h                       |  3 ---
> >  include/configs/mt7628.h                       |  3 ---
> >  include/configs/mt8512.h                       |  2 --
> >  include/configs/vocore2.h                      |  4 ----
> >  include/spl.h                                  |  2 +-
> >  19 files changed, 31 insertions(+), 56 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 9b90204bfe..13d4c63439 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1364,14 +1364,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec :=3D -I binary -O s=
rec
> >  u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
> >         $(call if_changed,objcopy)
> >
> > -#
> > -# U-Boot entry point, needed for booting of full-blown U-Boot
> > -# from the SPL U-Boot version.
> > -#
> > -ifndef CFG_SYS_UBOOT_START
> > -CFG_SYS_UBOOT_START :=3D $(CONFIG_TEXT_BASE)
> > -endif
> > -
> >  # Boards with more complex image requirements can provide an .its sour=
ce file
> >  # or a generator script
> >  # NOTE: Please do not use this. We are migrating away from Makefile ru=
les to use
> > @@ -1391,7 +1383,7 @@ endif
> >
> >  ifdef CONFIG_SPL_LOAD_FIT
> >  MKIMAGEFLAGS_u-boot.img =3D -f auto -A $(ARCH) -T firmware -C none -O =
u-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -p $(CONFIG_FIT_EXTERNAL_OFFSET) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE=
))) \
> > @@ -1399,10 +1391,10 @@ MKIMAGEFLAGS_u-boot.img =3D -f auto -A $(ARCH) =
-T firmware -C none -O u-boot \
> >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_=
OVERLAY_LIST)))
> >  else
> >  MKIMAGEFLAGS_u-boot.img =3D -A $(ARCH) -T firmware -C none -O u-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> >  MKIMAGEFLAGS_u-boot-ivt.img =3D -A $(ARCH) -T firmware_ivt -C none -O =
u-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> >  u-boot-ivt.img: MKIMAGEOUTPUT =3D u-boot-ivt.img.log
> >  endif
> > @@ -1433,7 +1425,7 @@ MKIMAGEFLAGS_u-boot.pbl =3D -n $(srctree)/$(CONFI=
G_SYS_FSL_PBL_RCW:"%"=3D%) \
> >  UBOOT_BIN :=3D u-boot.bin
> >
> >  MKIMAGEFLAGS_u-boot-lzma.img =3D -A $(ARCH) -T standalone -C lzma -O u=
-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> >
> >  u-boot.bin.lzma: u-boot.bin FORCE
> > diff --git a/arch/arm/mach-k3/config_secure.mk b/arch/arm/mach-k3/confi=
g_secure.mk
> > index 7bc8af813a..9cc1f9eb24 100644
> > --- a/arch/arm/mach-k3/config_secure.mk
> > +++ b/arch/arm/mach-k3/config_secure.mk
> > @@ -30,7 +30,7 @@ tispl.bin_HS: $(obj)/u-boot-spl-nodtb.bin_HS $(patsub=
st %,$(obj)/dts/%.dtb_HS,$(
> >         $(call if_changed,mkfitimage)
> >
> >  MKIMAGEFLAGS_u-boot.img_HS =3D -f auto -A $(ARCH) -T firmware -C none =
-O u-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_O=
F_LIST)))
> >
> > diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2=
/config_secure.mk
> > index 24ddcdb961..f76262bb0c 100644
> > --- a/arch/arm/mach-omap2/config_secure.mk
> > +++ b/arch/arm/mach-omap2/config_secure.mk
> > @@ -102,7 +102,7 @@ u-boot_HS_XIP_X-LOADER: $(obj)/u-boot.bin FORCE
> >  ifdef CONFIG_SPL_LOAD_FIT
> >
> >  MKIMAGEFLAGS_u-boot_HS.img =3D -f auto -A $(ARCH) -T firmware -C none =
-O u-boot \
> > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_O=
F_LIST)))
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 5e2d4286ae..f2f7821cc1 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -737,6 +737,22 @@ config TEXT_BASE
> >         default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >=3D 256
> >         default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >=3D 64
> >         hex "Text Base"
> > +       help
> > +         The address in memory that U-Boot will be copied from, initia=
lly.
> > +
> > +config HAVE_SYS_UBOOT_START
> > +       bool
> > +       depends on HAVE_TEXT_BASE
> > +       prompt "Use custom U-Boot Start"
> > +       help
> > +         By default, the address in memory that U-Boot will be copied =
from(TEXT_BASE) and the
> > +         entry point are the same. Select this to set a different U-Bo=
ot start address.
>
> space after 'from'
>
> Also this is a little unclear. START means the start address that
> U-Boot will run from. If it is different from TEXT_BASE, then
> something loads it here
>
> This could do with a bit more detail.

Yes, it is and why I edited the TEXT_BASE help prompt.
I'm not sure how to word that this is where the SPL will start
execution after the jump.
TEXT_BASE is where the spl will copy the binary to.

>
> > +
> > +config SYS_UBOOT_START
> > +       hex
> > +       depends on HAVE_TEXT_BASE
> > +       default TEXT_BASE
> > +       prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
> Tom:
> This is clever, and can be kept.  I didn't catch at first that this will
> do what I was hoping of setting a default, but then allowing for it to
> be changed.

Was there another way of doing this? I looked at the docs for a while
to figure this out.

Thanks,
Jesse Taube

> >         help
> >           The address in memory that U-Boot will be running from, initi=
ally.
> >
>
> Regards,
> Simon
