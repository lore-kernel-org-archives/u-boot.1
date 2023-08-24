Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E9C88CB2
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 22:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C668687F;
	Fri, 25 Aug 2023 00:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SoL4MscS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A544D8687F; Fri, 25 Aug 2023 00:45:44 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C94867F7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so5996097b3.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692917140; x=1693521940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YlgPr6zFq928l2fK82vuGb/okUE/pSQFrNHjBJFBKms=;
 b=SoL4MscSh5ogoyAp9COtlrvGCrgU+yYWPWXgMHEcVRyeP7vTui9SflSkVSw/bjjyhr
 DBwhg92kdw3wnbRtdDgMcWLW4AHK7QMhd+UC6pQKne+FSpCHpV16ZcoZ4gdUnQ6Dzlkr
 BuMz+/sa2G/vqe+fJx89cNzihZQ77Ix2OgCDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692917140; x=1693521940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlgPr6zFq928l2fK82vuGb/okUE/pSQFrNHjBJFBKms=;
 b=c+jYjf6l5FfHYY4ql6yMsNZwJ541NjqyyWAix+9bFIaWgMGcHNLKobsJSX8DyRR/su
 148hSqbyqk4EKxhFSMWv0GDcVDitt0R2kdeNfdGpgINOM/w3kp1F7NPyObUyHngkh+iM
 mDJv9W4GhiulwDDNaZk8RkCDxba38pJ42UWSD640WIi3HlnGZjo/wuhxnQNY8Ljhzt5p
 6Uj0CFMqTDzrZ0cScrct7Nu67MFB8UWsJGv4e3QGnpYaWn3BG9UXHoVnL2pg9uMHqZNg
 JJngxQqs/O5pcJOS1nzhqK9oOC9wr5WETykhYlXUEfGO4K8Tg3U75mNyvLvHfojGA0qU
 J/vw==
X-Gm-Message-State: AOJu0Yxl9xZhaTj8AVO/a9SNYhcFK7ClUr3t2u3IyEvq5vk/S3MrovZo
 P6ZAh4NGYeplDbfAi9DZM0SDmg==
X-Google-Smtp-Source: AGHT+IHJwQaE5o6+PNKkJUb1cAEJxqnZrSyHMJIoighB7V9EYfxWQnhi4ZZcWfchwLdo6GHqEiXBNA==
X-Received: by 2002:a0d:df95:0:b0:58c:4dcf:78b6 with SMTP id
 i143-20020a0ddf95000000b0058c4dcf78b6mr16646301ywe.21.1692917139170; 
 Thu, 24 Aug 2023 15:45:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a0df101000000b00577269ba9e9sm152036ywf.86.2023.08.24.15.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:45:38 -0700 (PDT)
Date: Thu, 24 Aug 2023 18:45:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Jesse T <mr.bossman075@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mingming lee <mingming.lee@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH] Convert CFG_SYS_UBOOT_START to Kconfig
Message-ID: <20230824224535.GG3953269@bill-the-cat>
References: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
 <CAPnjgZ1NFEVDcu-qOhTrjNpTspJ5OcCUZrDJJkru0mY-McPhzw@mail.gmail.com>
 <CAJFTR8S6Poz=CSK-Cb_k2ZVTH8bfQFFNeyH56d4CCeq80Shqtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wsEYfxfECJNvD9Ew"
Content-Disposition: inline
In-Reply-To: <CAJFTR8S6Poz=CSK-Cb_k2ZVTH8bfQFFNeyH56d4CCeq80Shqtw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--wsEYfxfECJNvD9Ew
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 06:40:09PM -0400, Jesse T wrote:
> On Thu, Aug 24, 2023 at 4:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Jesse,
> >
> > On Wed, 23 Aug 2023 at 20:30, Jesse Taube <mr.bossman075@gmail.com> wro=
te:
> > >
> > > Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_=
*")
> > > renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> > > this meant that the value was no longer available to the Makefile. Th=
is
> > > caused imxrt to fail to boot. All the other boards that used this
> > > variable were unaffected because they were using the default value
> > > which is CONFIG_TEXT_BASE.
> > >
> > > This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the defa=
ult
> > > value to CONFIG_TEXT_BASE.
> > >
> > > Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > > ---
> > >  Makefile                                       | 16 ++++------------
> > >  arch/arm/mach-k3/config_secure.mk              |  2 +-
> > >  arch/arm/mach-omap2/config_secure.mk           |  2 +-
> > >  boot/Kconfig                                   | 16 ++++++++++++++++
> > >  common/spl/spl.c                               |  6 +-----
> > >  common/spl/spl_fit.c                           |  2 +-
> > >  configs/imxrt1020-evk_defconfig                |  2 ++
> > >  configs/imxrt1050-evk_defconfig                |  2 ++
> > >  configs/imxrt1170-evk_defconfig                |  2 ++
> > >  include/configs/gardena-smart-gateway-mt7688.h |  4 ----
> > >  include/configs/imxrt1020-evk.h                |  6 ------
> > >  include/configs/imxrt1050-evk.h                |  6 ------
> > >  include/configs/imxrt1170-evk.h                |  3 ---
> > >  include/configs/linkit-smart-7688.h            |  4 ----
> > >  include/configs/mt7620.h                       |  3 ---
> > >  include/configs/mt7628.h                       |  3 ---
> > >  include/configs/mt8512.h                       |  2 --
> > >  include/configs/vocore2.h                      |  4 ----
> > >  include/spl.h                                  |  2 +-
> > >  19 files changed, 31 insertions(+), 56 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 9b90204bfe..13d4c63439 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1364,14 +1364,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec :=3D -I binary -O=
 srec
> > >  u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
> > >         $(call if_changed,objcopy)
> > >
> > > -#
> > > -# U-Boot entry point, needed for booting of full-blown U-Boot
> > > -# from the SPL U-Boot version.
> > > -#
> > > -ifndef CFG_SYS_UBOOT_START
> > > -CFG_SYS_UBOOT_START :=3D $(CONFIG_TEXT_BASE)
> > > -endif
> > > -
> > >  # Boards with more complex image requirements can provide an .its so=
urce file
> > >  # or a generator script
> > >  # NOTE: Please do not use this. We are migrating away from Makefile =
rules to use
> > > @@ -1391,7 +1383,7 @@ endif
> > >
> > >  ifdef CONFIG_SPL_LOAD_FIT
> > >  MKIMAGEFLAGS_u-boot.img =3D -f auto -A $(ARCH) -T firmware -C none -=
O u-boot \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -p $(CONFIG_FIT_EXTERNAL_OFFSET) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> > >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TR=
EE))) \
> > > @@ -1399,10 +1391,10 @@ MKIMAGEFLAGS_u-boot.img =3D -f auto -A $(ARCH=
) -T firmware -C none -O u-boot \
> > >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_O=
F_OVERLAY_LIST)))
> > >  else
> > >  MKIMAGEFLAGS_u-boot.img =3D -A $(ARCH) -T firmware -C none -O u-boot=
 \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> > >  MKIMAGEFLAGS_u-boot-ivt.img =3D -A $(ARCH) -T firmware_ivt -C none -=
O u-boot \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> > >  u-boot-ivt.img: MKIMAGEOUTPUT =3D u-boot-ivt.img.log
> > >  endif
> > > @@ -1433,7 +1425,7 @@ MKIMAGEFLAGS_u-boot.pbl =3D -n $(srctree)/$(CON=
FIG_SYS_FSL_PBL_RCW:"%"=3D%) \
> > >  UBOOT_BIN :=3D u-boot.bin
> > >
> > >  MKIMAGEFLAGS_u-boot-lzma.img =3D -A $(ARCH) -T standalone -C lzma -O=
 u-boot \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
> > >
> > >  u-boot.bin.lzma: u-boot.bin FORCE
> > > diff --git a/arch/arm/mach-k3/config_secure.mk b/arch/arm/mach-k3/con=
fig_secure.mk
> > > index 7bc8af813a..9cc1f9eb24 100644
> > > --- a/arch/arm/mach-k3/config_secure.mk
> > > +++ b/arch/arm/mach-k3/config_secure.mk
> > > @@ -30,7 +30,7 @@ tispl.bin_HS: $(obj)/u-boot-spl-nodtb.bin_HS $(pats=
ubst %,$(obj)/dts/%.dtb_HS,$(
> > >         $(call if_changed,mkfitimage)
> > >
> > >  MKIMAGEFLAGS_u-boot.img_HS =3D -f auto -A $(ARCH) -T firmware -C non=
e -O u-boot \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> > >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG=
_OF_LIST)))
> > >
> > > diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-oma=
p2/config_secure.mk
> > > index 24ddcdb961..f76262bb0c 100644
> > > --- a/arch/arm/mach-omap2/config_secure.mk
> > > +++ b/arch/arm/mach-omap2/config_secure.mk
> > > @@ -102,7 +102,7 @@ u-boot_HS_XIP_X-LOADER: $(obj)/u-boot.bin FORCE
> > >  ifdef CONFIG_SPL_LOAD_FIT
> > >
> > >  MKIMAGEFLAGS_u-boot_HS.img =3D -f auto -A $(ARCH) -T firmware -C non=
e -O u-boot \
> > > -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> > > +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > >         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> > >         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG=
_OF_LIST)))
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 5e2d4286ae..f2f7821cc1 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -737,6 +737,22 @@ config TEXT_BASE
> > >         default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >=3D 256
> > >         default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >=3D 64
> > >         hex "Text Base"
> > > +       help
> > > +         The address in memory that U-Boot will be copied from, init=
ially.
> > > +
> > > +config HAVE_SYS_UBOOT_START
> > > +       bool
> > > +       depends on HAVE_TEXT_BASE
> > > +       prompt "Use custom U-Boot Start"
> > > +       help
> > > +         By default, the address in memory that U-Boot will be copie=
d from(TEXT_BASE) and the
> > > +         entry point are the same. Select this to set a different U-=
Boot start address.
> >
> > space after 'from'
> >
> > Also this is a little unclear. START means the start address that
> > U-Boot will run from. If it is different from TEXT_BASE, then
> > something loads it here
> >
> > This could do with a bit more detail.
>=20
> Yes, it is and why I edited the TEXT_BASE help prompt.
> I'm not sure how to word that this is where the SPL will start
> execution after the jump.
> TEXT_BASE is where the spl will copy the binary to.
>=20
> >
> > > +
> > > +config SYS_UBOOT_START
> > > +       hex
> > > +       depends on HAVE_TEXT_BASE
> > > +       default TEXT_BASE
> > > +       prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
> > Tom:
> > This is clever, and can be kept.  I didn't catch at first that this will
> > do what I was hoping of setting a default, but then allowing for it to
> > be changed.
>=20
> Was there another way of doing this? I looked at the docs for a while
> to figure this out.

This part here is mechanically correct.  Just need a slight wording
change to the help to better explain what / why one wants to adjust the
address.  Why are these platforms needing start !=3D text?

--=20
Tom

--wsEYfxfECJNvD9Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTn3YwACgkQFHw5/5Y0
tyyd/wv9FD+aQvBGl5OmO8QpTpaIVFrBjLvMFLxuPzy9rpxPo8Gwefc2Qy0iMekl
4hwf1BAw94AjGHM950UmDH0A84duQ5qng38CSW3nHXvdcup3+Mm9bMT9Qz8SxyOq
ULRiNcgeO2M2Sj7h+0glvYDrvXqQ81pXyRAQCOeZ4QTqRLdvM5PCjeEIUp3Ycste
oK68zJRUEuS0CxBosSmRcaCVHtKF7tYdbC84ckrZlXbOujkyOhWH2qLt9/44hLqA
2Kuo88qX45NWDIFTVIDPjaVPkqKf3diBi2Xj1uOM1itO9zvkwuAvm9YAW49dxWSF
j0r06FnjbyTG5wzWjqwnBdNue2/qfdVwuORt+4c9Jt9qfPiTAhm1RFwpmgCw9tuY
krXnawD0/k5/23aRyq4zMS9SXR5plhjWhQ8uoq9/Hz6nBfADcE+t7cmBEdQuQf1d
JnQHMB4mGQEL1CdHcRDfEsjJ8j5hBapL8J/t0gHnadzFVOpu4zJ8GK7XlnvsZczP
k13549x9
=hNB5
-----END PGP SIGNATURE-----

--wsEYfxfECJNvD9Ew--
