Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22DC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35EE780E9A;
	Fri, 20 Jun 2025 16:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pFz6OZ7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED61682CBC; Fri, 20 Jun 2025 16:39:43 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABE780C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso1834696276.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1750430380; x=1751035180;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/oPw8QjmiNTB7iJ+8Kzn7hE70t+C+4azNdTALWtOJM=;
 b=pFz6OZ7vp34UzvNIvj3gdAsCnODdqugRahAaQe5HMPQ3TeA6cmErTWOTmpPbupqygO
 eHHa67LEDyMfeltbbjChirxZKmepzDQmpp2uo1SnU09WhS8jl0HJ1f6+K4IdVVcI+2n1
 aU5UeB/3zlpEBf2xbPShbCIT0tjGxwFNdoxck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430380; x=1751035180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/oPw8QjmiNTB7iJ+8Kzn7hE70t+C+4azNdTALWtOJM=;
 b=UTzFxYDxBcepYZgp227YJ+T7YuQLYkyRfDrgk6gveriWQBlghUzElYFniZB4wiRLTl
 EbZxSP/7/Y80L/QMIURJMTJK85PaIXkkhMYF+LhdMilEMs8C92yQ5ivCalBqbsD1jmi3
 anAsgY5TJRtBraggT9Udax9lIe7vs9mCXZaN36Wnq84yyCKmiRJSqWe+UpbSoK4sXmNJ
 5elzXhxI84mbLQtYc8CDbE+FIPVzBF06aLYMb6tqv+pJKiQ4+jk3xUQRhXPjmI6by7KW
 F7eoaJkLqbvg5tQr5XXZ0rwpCSW27C+cdjrU/kxmf5jlgYJqRuRFETH+PfuffFMSGggN
 8Lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvdGVh2ZmHvTNB11pQ2jBGPse/g+jc3YdciNFJrBgi40237tT4avuWbGotJvC0R/huPr11CI4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy1G8tq4huVxMeQsr+XRMWCI04nGrKvakmMtKrCRvQIYnioK9B
 ierfvHcHZWggbFm8rW+XhHgo5D5asLuGjAq5Xy+S6eDu5rrTXUXtrxSbQYfTlxVHZVltmlTlMtD
 yM5LwYasI+Dezc1GRsaO4TDg+AbAXbt46A1xS5ILr5A==
X-Gm-Gg: ASbGncvMo9WKxmLmIr7/A85g7xKrIlpDHM96MD1P6VDT4Wk8D95HqErVb+DgGytTAer
 08QqWn1tDfZi4DTOcpHzV6Ro89m/8Br8DMImtAHR9lebPq5XcAzbjiCcKx2cEM86VKzR8D5VRi/
 NZIetvFSz5KbIMpYO8Eqj20WwUiuNTz6cQvNf9TY5gAA==
X-Google-Smtp-Source: AGHT+IGLrwmhUVnTVMkVHuhOsse9MqHxiVHQ/XhQL+/C6H9KfwcCkBDUiK93aQ7j2OJqkYqRZEkUmBGwfESVPqF1lV0=
X-Received: by 2002:a05:690c:d8e:b0:70f:84c8:312e with SMTP id
 00721157ae682-712c6397305mr45755327b3.1.1750430380317; Fri, 20 Jun 2025
 07:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
 <20250620102953.29633-2-alif.zakuan.yuslaimi@altera.com>
 <20250620141133.GH216500@bill-the-cat>
 <CAOf5uwnCzx+0Cq+BpA3dcB4oHscUDTC34wkYgjEwUctk3e1=tQ@mail.gmail.com>
In-Reply-To: <CAOf5uwnCzx+0Cq+BpA3dcB4oHscUDTC34wkYgjEwUctk3e1=tQ@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 20 Jun 2025 16:39:29 +0200
X-Gm-Features: Ac12FXy9edvI3Y4gp1H4GySTUry_81hVpklu_E27hYalE6cFpu9gHppDDXx5Jxo
Message-ID: <CABGWkvrhFK9-Gp8oUbW0eHP1zmscFmRmCQwmLDuZ669RWFNELg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mtd: nand: Allow full NAND framework in SPL
To: alif.zakuan.yuslaimi@altera.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
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

Hello,

On Fri, Jun 20, 2025 at 4:13=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Jun 20, 2025 at 4:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Jun 20, 2025 at 03:29:52AM -0700, alif.zakuan.yuslaimi@altera.c=
om wrote:
> >
> > > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > >
> > > Add configuration option to compile the entire NAND framework into
> > > U-Boot SPL. This is required by some drivers, like the Denali NAND,
> > > which use a lot of functionality from the NAND core.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> > > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > ---
> > >  drivers/mtd/nand/raw/Kconfig  |  8 ++++++++
> > >  drivers/mtd/nand/raw/Makefile | 28 ++++++++++++----------------
> > >  2 files changed, 20 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kcon=
fig
> > > index adb271dfb8f..28b48d53def 100644
> > > --- a/drivers/mtd/nand/raw/Kconfig
> > > +++ b/drivers/mtd/nand/raw/Kconfig
> > > @@ -208,6 +208,7 @@ config NAND_CADENCE
> > >  config NAND_DENALI
> > >       bool
> > >       select SYS_NAND_SELF_INIT
> > > +     select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
> >
> > If there's not a more generic SOCFPGA symbol to use here, this part is
> > fine. But also unrelated as this isn't the SPL driver and this series i=
s
> > about SPL.
> >
> > >       imply CMD_NAND
> > >
> > >  config NAND_DENALI_DT
> > > @@ -826,4 +827,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
> > >
> > >  endif        # if SPL
> > >
> > > +config SPL_NAND_FRAMEWORK
> > > +     bool "Compile the entire NAND framework into the SPL"
> > > +     help
> > > +       Some drivers require a lot of functionality from the NAND fra=
mework
> > > +       core when used in SPL. This option allows compiling the full =
NAND
> > > +       framework into the SPL instead of it's reduced version.
> >
> > There's some problems here. First, this needs to be inside of the "if
> > SPL, not outside of it". Second, we already have SPL_NAND_DENALI as an
> > option, so some explanation of what's being done here now is needed.
> > Third, if we really really need SPL_NAND_SIMPLE and SPL_NAND_SUPPORT an=
d
> > SPL_NAND_FRAMEWORK it needs to be moved around so that first we have it
> > as a choice, then we add more. But given all of the other options we
> > have in common/spl/Kconfig right now for NAND, I'm unclear about what i=
s
> > missing today.

The patch has already been rejected for this specific option, because
you can always select and this board or family are the only consumers.

Thanks and regards,
Dario

>
> I have already rejected this patch for this specific option, because
> you can always select and
> this board or family are the only consumers. Why do we need it in the
> first place?
>
> Michael
>
> >
> > >  endif        # if MTD_RAW_NAND
> > > diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Mak=
efile
> > > index 34cba77046a..08829406902 100644
> > > --- a/drivers/mtd/nand/raw/Makefile
> > > +++ b/drivers/mtd/nand/raw/Makefile
> > > @@ -3,8 +3,18 @@
> > >  # (C) Copyright 2006
> > >  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> > >
> > > +nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
> > > +                    nand_ecc.o nand_base.o nand_timings.o nand_amd.o=
 \
> > > +                    nand_hynix.o nand_macronix.o nand_micron.o \
> > > +                    nand_samsung.o nand_toshiba.o
> > > +
> > >  ifdef CONFIG_XPL_BUILD
> > >
> > > +ifdef CONFIG_SPL_NAND_FRAMEWORK
> > > +obj-y +=3D $(nand-framework-objs)
> > > +NORMAL_DRIVERS=3Dy
> > > +endif
> > > +
> > >  ifdef CONFIG_SPL_NAND_DRIVERS
> > >  NORMAL_DRIVERS=3Dy
> > >  endif
> > > @@ -15,9 +25,7 @@ obj-$(CONFIG_SPL_NAND_DENALI) +=3D denali_spl.o
> > >  obj-$(CONFIG_SPL_NAND_SIMPLE) +=3D nand_spl_simple.o
> > >  obj-$(CONFIG_SPL_NAND_LOAD) +=3D nand_spl_load.o
> > >  obj-$(CONFIG_SPL_NAND_ECC) +=3D nand_ecc.o
> > > -obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o nand_amd.o nand_hynix.o=
 \
> > > -                             nand_macronix.o nand_micron.o \
> > > -                             nand_samsung.o nand_toshiba.o
> > > +obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o
> > >  obj-$(CONFIG_SPL_NAND_IDENT) +=3D nand_ids.o nand_timings.o
> > >  obj-$(CONFIG_$(PHASE_)NAND_INIT) +=3D nand.o
> > >  ifeq ($(CONFIG_SPL_ENV_SUPPORT),y)
> > > @@ -28,19 +36,7 @@ else # not spl
> > >
> > >  NORMAL_DRIVERS=3Dy
> > >
> > > -obj-y +=3D nand.o
> > > -obj-y +=3D nand_bbt.o
> > > -obj-y +=3D nand_ids.o
> > > -obj-y +=3D nand_util.o
> > > -obj-y +=3D nand_ecc.o
> > > -obj-y +=3D nand_base.o
> > > -obj-y +=3D nand_amd.o
> > > -obj-y +=3D nand_hynix.o
> > > -obj-y +=3D nand_macronix.o
> > > -obj-y +=3D nand_micron.o
> > > -obj-y +=3D nand_samsung.o
> > > -obj-y +=3D nand_toshiba.o
> > > -obj-y +=3D nand_timings.o
> > > +obj-y +=3D $(nand-framework-objs)
> > >
> > >  endif # not spl
> >
> > Did you world build this change? At first it looks like we're dropping =
a
> > lot of objects from other configs.
> >
> > --
> > Tom
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
