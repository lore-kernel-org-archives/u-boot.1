Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ABAC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 07:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555A38083E;
	Fri, 28 Feb 2025 08:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m+SobTj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D637808B6; Fri, 28 Feb 2025 08:00:29 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FB2807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 08:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea795bafeso2479112a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740726024; x=1741330824;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeLR87P1M2TMBb27lpCElvPobxEaZD8PKC9JdF/wV4k=;
 b=m+SobTj+fHJTVd7g9pnfwKvRNIs0CAk7RN1Ajv69ftmrOVe7KQiIzdgsU/nfveEhsZ
 Lyfbq4lMMU0nA3k5C980nLqP/gvI1Rj6zjO/mOxhD63kyQUmBDEaV2oMc21NUj9sGcCH
 SmaPtuxUQWOUQ0FmKSDSMorz+ub+7tuvxTJm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740726024; x=1741330824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeLR87P1M2TMBb27lpCElvPobxEaZD8PKC9JdF/wV4k=;
 b=i0iE3VBZuVFAOD1Y4TG/ZVrkPwq9Zedpk5oocvpperZG5mzWDGB5ywzIChjs4QRNQD
 r3vc+Xxf+YqeOtqw4WM55YufAu7O9bZ9VRbkA4u5+C8VBbk1EDli3n07fizKeigr8TVc
 NwyecMfHZr3EKmU/f8Q4bfXu0XDZTIDmpnC8BLHfkfM9q7B1xUmZE388pfNnlQpGR6qD
 ILhg5rzrnsqp5Cg2e4OcEC31YlCtrUGsp4HOKTN0nNrV+nyZpp66OmDlPtapUBEBx9XT
 smbWSByGWgaIvfFwSuQy1UnxgPIvZ1c1XAkBKtLz09FL1lEETJECWfzb6BiKRaBrM3TD
 iHGQ==
X-Gm-Message-State: AOJu0YyoX4ISnegOUQCuMKJENzsjHdwcPNC+s9heYRrp/SSSdV4u7oxY
 vJ0FgivSEMjR1xQ1Vp4vCoLd9Wfk35vZ0U8rq29vYjwvRJ3nCW3TGKKekJAI82r1eedYZ50kL31
 ydjLJUUJxYMHnll94bYdt/QHdHpVt3VPSFoY2UA==
X-Gm-Gg: ASbGncu/5Ek9votoDXgcK8kboHimo1ZyMTCtJ9HOBBrT4qM8qPiJ4T2RkBb+2qA6sL7
 MK1fcqaEwX/096xXW6d3pU2Wn6mqyJA9JLmSsqAcpTkJNyCOBmvRn2dGvYF0Pam9jTIJI9lautf
 5ACzZdbw==
X-Google-Smtp-Source: AGHT+IHpsf3U40xrsv9inu2gcRZ69Zl3DjXwgjm4eJoCTtgyZCQRFto3XjH+Ei/+qWks2R1iIn23ZJHTDg4DURkzGwU=
X-Received: by 2002:a17:90b:380e:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-2feba5ce632mr4280868a91.2.1740726024091; Thu, 27 Feb 2025
 23:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <20250226161833.53689-18-dinesh.maniyam@intel.com>
 <CAOf5uwkKE-W0pPMB50rBs3Fa7Mdh75zU9nYNG2DpNLqjrp=ORQ@mail.gmail.com>
 <DM4PR11MB5373F5322F7554073B29508182CC2@DM4PR11MB5373.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB5373F5322F7554073B29508182CC2@DM4PR11MB5373.namprd11.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 28 Feb 2025 08:00:12 +0100
X-Gm-Features: AQ5f1Jri-eCRTEeL0yY3WjlM4UTQrnDbD4MEaLs6kNngIm90qDX9KLr3sJWa4-s
Message-ID: <CAOf5uwmMG5p+VAShYiXqEpX4d+qAkmHUS71q3gTmp=hgSLGQiA@mail.gmail.com>
Subject: Re: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
To: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, "Meng,
 Tingting" <tingting.meng@intel.com>, 
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@intel.com>, 
 "Ng, Boon Khai" <boon.khai.ng@intel.com>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, 
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>, "Tang,
 Sieu Mun" <sieu.mun.tang@intel.com>
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

On Fri, Feb 28, 2025 at 5:02=E2=80=AFAM Maniyam, Dinesh
<dinesh.maniyam@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Friday, 28 February 2025 5:30 am
> > To: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Dario
> > Binacchi <dario.binacchi@amarulasolutions.com>; Johan Jonker
> > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>; Arseniy
> > Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>=
;
> > William Zhang <william.zhang@broadcom.com>; Igor Prusov
> > <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com>;
> > Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > <kok.kiang.hea@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>; Yusl=
aimi,
> > Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izz=
at
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > Subject: Re: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and =
Makefile
> > for SPL_NAND_FRAMEWORK
> >
> > Hi
> >
> > On Wed, Feb 26, 2025 at 5:20=E2=80=AFPM <dinesh.maniyam@intel.com> wrot=
e:
> > >
> > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > >
> > > Enable the Kconfig and Makefile for the SPL_NAND_FRAMEWORK support in
> > > agilex5 family device. This will include all the basic files needed t=
o
> > > use the existing nand spl support.
> > >
> > > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > ---
> > >  drivers/mtd/nand/raw/Kconfig  |  7 +++++++
> > > drivers/mtd/nand/raw/Makefile | 10 ++++++++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/mtd/nand/raw/Kconfig
> > > b/drivers/mtd/nand/raw/Kconfig index a9515c7b74..d6ac730224 100644
> > > --- a/drivers/mtd/nand/raw/Kconfig
> > > +++ b/drivers/mtd/nand/raw/Kconfig
> > > @@ -837,4 +837,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
> > >
> > >  endif  # if SPL
> > >
> > > +config SPL_NAND_FRAMEWORK
> > > +       bool "Compile the entire NAND framework into the SPL"
> > > +       help
> > > +         Some drivers require a lot of functionality from the NAND f=
ramework
> > > +         core when used in SPL. This option allows compiling the ful=
l NAND
> > > +         framework into the SPL instead of it's reduced version.
> > > +
> >
> > This seems not relevant for this series and even I don't like the idea =
to have it
> >
> > Michael
> >
>
> I agree. I can drop this commit.
> We already have configs to enable the necessary files to be part SPL nand=
 build.
> However, dropping this commit will cause a compilation failure,
> To overcome this, shall modify the socfpga_agilex5_nand2_defconfig and
> mtd/nand/raw/Kconfig files to include the relevant files to be part of th=
e
> SPL nand build.
> Would you like me to resubmit patch 13 & patch 16?
>

But the order is totally wrong, I mean the patch that include this
defconfig come before the add
on new symbol.  So the commit eb19dec2d55b57ab99cd75b15b04f69ee457ffc9
can not build

I mean we should have a bit of bisect ability here.

You should able to build with this

iff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 01d181bf476..7ab840a9e53 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -195,6 +195,11 @@ config NAND_CADENCE
        depends on OF_CONTROL && DM_MTD
        select SYS_NAND_SELF_INIT
        select SPL_SYS_NAND_SELF_INIT
+       select SPL_NAND_BASE
+       select SPL_NAND_DRIVERS
+       select SPL_NAND_IDENT
+       select SPL_NAND_INIT
+       select SPL_NAND_ECC
        imply CMD_NAND
        help
          Enable the driver for NAND flash on platforms using a Cadence NAN=
D
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 936b54e3ff3..34cba77046a 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -3,18 +3,8 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.

-nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
-                      nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
-                      nand_hynix.o nand_macronix.o nand_micron.o \
-                      nand_samsung.o nand_toshiba.o
-
 ifdef CONFIG_XPL_BUILD

-ifdef CONFIG_SPL_NAND_FRAMEWORK
-obj-y +=3D $(nand-framework-objs)
-NORMAL_DRIVERS=3Dy
-endif
-
 ifdef CONFIG_SPL_NAND_DRIVERS
 NORMAL_DRIVERS=3Dy
 endif

Michael
> Dinesh
>
> > >  endif  # if MTD_RAW_NAND
> > > diff --git a/drivers/mtd/nand/raw/Makefile
> > > b/drivers/mtd/nand/raw/Makefile index 58fde3272f..0a32e184dc 100644
> > > --- a/drivers/mtd/nand/raw/Makefile
> > > +++ b/drivers/mtd/nand/raw/Makefile
> > > @@ -3,8 +3,18 @@
> > >  # (C) Copyright 2006
> > >  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> > >
> > > +nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
> > > +                      nand_ecc.o nand_base.o nand_timings.o nand_amd=
.o \
> > > +                      nand_hynix.o nand_macronix.o nand_micron.o \
> > > +                      nand_samsung.o nand_toshiba.o
> > > +
> > >  ifdef CONFIG_SPL_BUILD
> > >
> > > +ifdef CONFIG_SPL_NAND_FRAMEWORK
> > > +obj-y +=3D $(nand-framework-objs)
> > > +NORMAL_DRIVERS=3Dy
> > > +endif
> > > +
> > >  ifdef CONFIG_SPL_NAND_DRIVERS
> > >  NORMAL_DRIVERS=3Dy
> > >  endif
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > info@amarulasolutions.com www.amarulasolutions.com



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
