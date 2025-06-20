Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A523C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66B380E9A;
	Fri, 20 Jun 2025 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V/6xicDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCB782CBC; Fri, 20 Jun 2025 16:13:21 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DC180C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so2019553a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1750428798; x=1751033598;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKgDOHjRm3rmVHLmfLBCQKa4GdqUHcvzfID+W0l/wNg=;
 b=V/6xicDlwYApyWLZyjhbhe6PO+qe56JSHqMislMqcF2rZuzkxVgPUUqcJJXjfBbtNi
 yWHTbax/GiBRZ4wEuAa8u1j95YfKpoE20cz/ci6UOSZC8S8YC+FnOEeAMLDh2Hb9lofY
 ptmiEv5/ry9V6vYfVRAd8tGvKJo6AZhrF0sgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750428798; x=1751033598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKgDOHjRm3rmVHLmfLBCQKa4GdqUHcvzfID+W0l/wNg=;
 b=kAKbZvBM8zB96VwYG5OO9gv2J0GjvVUAkmXFozRCSSDRNKAHQPoBpeQ2lmYbm9Mc8r
 rV74gp1hpv1O38kZcnU0oQBkFlVY4EWc0Jt1RoQ5Ydw6mQnaaJqrRWzDQV2R7mXGEgr/
 dXku5fL9yKi6xFWB4fTxKbUIxCQ0PVe6WSRPSrWKOHvhzwhAX47YAyzYzLJQy9/TpMvp
 ziXcpw0B3n4H1DM3bVjp9rNFhencd9/48uQuar3oQ1OLciZ9KQA98cy0zyA+oELnQ/2C
 rGuRPlP2xu/mDSb1puz4dajgEQQG8CBTUpQV9o1PhxmO0zh32FU9+mfHCUX4wsDkXTNB
 vWaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzUQnCVq7mQvgi9NgKv18hCMBK+tlslUqr9h5rqDMIVSwYtbT6zwu8wYXrr2Ngt3+XD9HF8Lo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyf/ogYECLicBFTHrbg+1S59tgcPTxhzpHbH/bYOXuECDOO6ai
 y62SmW21q5x/FaRdsZ9yiwFhmkIpIDsj3Cn5XyYTJWQuJgJ2mekvbN0sDE1gUGJeT/29iA6088y
 8S7egPSl8D+3WMdAP9BvGIBoLsjAFrgbZyhx56QC0ag==
X-Gm-Gg: ASbGncsw+P19F8sM2AftjlpmBa5DrTkVrqzNqxifzLX9T9BegSzO26o20O5grj/vnH0
 CfG4Rka3y91VzBPC8l9a9gY24KNvjhDu1XNVIjsRA/LKTOWU7aezHlq+4a9/fJpDsrBT2ojumUg
 +ZuYlJC3r26d2wVWdwg9UKrhIwYo7S7jQteP4cXOL5JJTq
X-Google-Smtp-Source: AGHT+IGm3H4rYXXMjiXbVqU4CjQvuTpjrDwP606c+N/lxy6AGYoDxVVxX4dv7E34fNdu7XWGcP7Wy6LT5derbwDPlHY=
X-Received: by 2002:a17:90b:3f87:b0:312:25dd:1c99 with SMTP id
 98e67ed59e1d1-3159d8c5c7amr4613581a91.19.1750428797879; Fri, 20 Jun 2025
 07:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
 <20250620102953.29633-2-alif.zakuan.yuslaimi@altera.com>
 <20250620141133.GH216500@bill-the-cat>
In-Reply-To: <20250620141133.GH216500@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 20 Jun 2025 16:13:05 +0200
X-Gm-Features: Ac12FXzCHdQlQWQaLFE5Gn65N4akp6Cbp0SspMkwLAY9koyUbQKdKSVlpcaUbC0
Message-ID: <CAOf5uwnCzx+0Cq+BpA3dcB4oHscUDTC34wkYgjEwUctk3e1=tQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mtd: nand: Allow full NAND framework in SPL
To: Tom Rini <trini@konsulko.com>
Cc: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 20 Jun 2025 16:16:50 +0200
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

On Fri, Jun 20, 2025 at 4:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Jun 20, 2025 at 03:29:52AM -0700, alif.zakuan.yuslaimi@altera.com=
 wrote:
>
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> > Add configuration option to compile the entire NAND framework into
> > U-Boot SPL. This is required by some drivers, like the Denali NAND,
> > which use a lot of functionality from the NAND core.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > ---
> >  drivers/mtd/nand/raw/Kconfig  |  8 ++++++++
> >  drivers/mtd/nand/raw/Makefile | 28 ++++++++++++----------------
> >  2 files changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfi=
g
> > index adb271dfb8f..28b48d53def 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -208,6 +208,7 @@ config NAND_CADENCE
> >  config NAND_DENALI
> >       bool
> >       select SYS_NAND_SELF_INIT
> > +     select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
>
> If there's not a more generic SOCFPGA symbol to use here, this part is
> fine. But also unrelated as this isn't the SPL driver and this series is
> about SPL.
>
> >       imply CMD_NAND
> >
> >  config NAND_DENALI_DT
> > @@ -826,4 +827,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
> >
> >  endif        # if SPL
> >
> > +config SPL_NAND_FRAMEWORK
> > +     bool "Compile the entire NAND framework into the SPL"
> > +     help
> > +       Some drivers require a lot of functionality from the NAND frame=
work
> > +       core when used in SPL. This option allows compiling the full NA=
ND
> > +       framework into the SPL instead of it's reduced version.
>
> There's some problems here. First, this needs to be inside of the "if
> SPL, not outside of it". Second, we already have SPL_NAND_DENALI as an
> option, so some explanation of what's being done here now is needed.
> Third, if we really really need SPL_NAND_SIMPLE and SPL_NAND_SUPPORT and
> SPL_NAND_FRAMEWORK it needs to be moved around so that first we have it
> as a choice, then we add more. But given all of the other options we
> have in common/spl/Kconfig right now for NAND, I'm unclear about what is
> missing today.

I have already rejected this patch for this specific option, because
you can always select and
this board or family are the only consumers. Why do we need it in the
first place?

Michael

>
> >  endif        # if MTD_RAW_NAND
> > diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makef=
ile
> > index 34cba77046a..08829406902 100644
> > --- a/drivers/mtd/nand/raw/Makefile
> > +++ b/drivers/mtd/nand/raw/Makefile
> > @@ -3,8 +3,18 @@
> >  # (C) Copyright 2006
> >  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> >
> > +nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
> > +                    nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
> > +                    nand_hynix.o nand_macronix.o nand_micron.o \
> > +                    nand_samsung.o nand_toshiba.o
> > +
> >  ifdef CONFIG_XPL_BUILD
> >
> > +ifdef CONFIG_SPL_NAND_FRAMEWORK
> > +obj-y +=3D $(nand-framework-objs)
> > +NORMAL_DRIVERS=3Dy
> > +endif
> > +
> >  ifdef CONFIG_SPL_NAND_DRIVERS
> >  NORMAL_DRIVERS=3Dy
> >  endif
> > @@ -15,9 +25,7 @@ obj-$(CONFIG_SPL_NAND_DENALI) +=3D denali_spl.o
> >  obj-$(CONFIG_SPL_NAND_SIMPLE) +=3D nand_spl_simple.o
> >  obj-$(CONFIG_SPL_NAND_LOAD) +=3D nand_spl_load.o
> >  obj-$(CONFIG_SPL_NAND_ECC) +=3D nand_ecc.o
> > -obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o nand_amd.o nand_hynix.o \
> > -                             nand_macronix.o nand_micron.o \
> > -                             nand_samsung.o nand_toshiba.o
> > +obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o
> >  obj-$(CONFIG_SPL_NAND_IDENT) +=3D nand_ids.o nand_timings.o
> >  obj-$(CONFIG_$(PHASE_)NAND_INIT) +=3D nand.o
> >  ifeq ($(CONFIG_SPL_ENV_SUPPORT),y)
> > @@ -28,19 +36,7 @@ else # not spl
> >
> >  NORMAL_DRIVERS=3Dy
> >
> > -obj-y +=3D nand.o
> > -obj-y +=3D nand_bbt.o
> > -obj-y +=3D nand_ids.o
> > -obj-y +=3D nand_util.o
> > -obj-y +=3D nand_ecc.o
> > -obj-y +=3D nand_base.o
> > -obj-y +=3D nand_amd.o
> > -obj-y +=3D nand_hynix.o
> > -obj-y +=3D nand_macronix.o
> > -obj-y +=3D nand_micron.o
> > -obj-y +=3D nand_samsung.o
> > -obj-y +=3D nand_toshiba.o
> > -obj-y +=3D nand_timings.o
> > +obj-y +=3D $(nand-framework-objs)
> >
> >  endif # not spl
>
> Did you world build this change? At first it looks like we're dropping a
> lot of objects from other configs.
>
> --
> Tom



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
