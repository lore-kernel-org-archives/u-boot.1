Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2F9C0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 10:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2020C80C77;
	Sat, 25 Jan 2025 11:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="biervrZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C6280C7E; Sat, 25 Jan 2025 11:40:00 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BBA807FE
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 11:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so5197142a91.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 02:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1737801596; x=1738406396;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJBHxw3L2xFpvXIi4nVgqXVONj2hxKNuZFIKA97kMMM=;
 b=biervrZdoQ4sdmeUVwVlPdRb8hJFFNGeWQH//1CQli2Zz6mFkXWnq0l/phPqqwZR0a
 DFHqld9qG2ZluYbmZ/HhyyclQepuCM3ALLBg1Has0P/JR7yd9UdjE3sbN8+tRBw89WzL
 TvHSXXQFC1k7vNs5f5aAd1Eg5+ATG+czX/+sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737801596; x=1738406396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJBHxw3L2xFpvXIi4nVgqXVONj2hxKNuZFIKA97kMMM=;
 b=E9wvoJyJDiwIVrkGkMCzMvNVQG3KHW8290yNjNSa51h06RrCqJJi5NFQM6WI18QJn2
 v/0jkbP6QdfwSP70DvD8kijdCNdtYfUtTlqpmzCmYGZXnkBwYUybPCazEGVaIXe8i+xb
 wHtB7T3FUybSHlYpxCgWz6XQHgQKKTd9tJMYPpdUbdcJbPw+kTysBQYvwbX9UGt8UsmG
 PDqmPTroJRM0ALV9ARpI1q6T7yYFozAhBwnXPrxfqyO/2YapKT9U/eRcGe42KPDt2rDE
 1XP6eCr5+aHrGf9K/PRiq3xLwpmSU5gJShsQLPsfTJQJm4v/mge/MsxXs8vVpFIZ/wSo
 FPZQ==
X-Gm-Message-State: AOJu0YxZDAYLlBOVl4GNgnEgGUZOAwVbqK5zztEQNYyJJP5XykNAF0Op
 VbVgoab9Ie2N48JCLv4NtuXMU8zYa32EZlXVcYKRSELgTqRtGc/ZhBfxsR2HK0eHoKAuSFR1IJS
 0c1d/UmKQjpB5AywsueYzwjBSW8tr651q7tEcnQ==
X-Gm-Gg: ASbGncu2Y+PBmraUt2Hr7xGSbf7aKUIWlQp/zxFEb8TS7dRwWRlTuAnOWMnuSZa5TO3
 gDiYC1SvVc6aNu0DNdL1co1ubKFp9Iyh/Y8UhjgE7RH5GledlaqbNVXCFYdMKmQ==
X-Google-Smtp-Source: AGHT+IFeRrXfg9aQVhVxSSj1M/M9cyKwnySngXlAJ0FjUlgZ4PopdEDBSD4w4KE9WfTJ5Y5eX12kC74Koa/15VdkUq4=
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f782d4ee70mr50497044a91.28.1737801596150; Sat, 25 Jan 2025
 02:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 25 Jan 2025 11:39:44 +0100
X-Gm-Features: AWEUYZkxQtFiXxghXjRA8lIqEE4kaa_-rj-7HyLnXwcGa0wimpNN-DSTTjYi4_A
Message-ID: <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
Subject: Re: [resend v2 00/19] Add Cadence NAND Driver support
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

Hi Dinesh

On Tue, Jan 21, 2025 at 9:39=E2=80=AFAM Maniyam, Dinesh
<dinesh.maniyam@intel.com> wrote:
>
> Hi Michael,
>
> Any update on my NAND patchset ?. I can see it is still under review.
> Is there anything I can do from my side to speed up the review process?
> Thanks for your time.
>

Well, last time was not paassing the CI. I will test it again today

Michael

> > -----Original Message-----
> > From: Maniyam, Dinesh
> > Sent: Tuesday, 17 December 2024 3:41 pm
> > To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Dario
> > Binacchi <dario.binacchi@amarulasolutions.com>; Johan Jonker
> > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>; Arseniy
> > Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>=
;
> > William Zhang <william.zhang@broadcom.com>; Igor Prusov
> > <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com>;
> > Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > <kok.kiang.hea@intel.com>; Ng, Boon Khai <Boon.Khai.Ng@intel.com>; Yusl=
aimi,
> > Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izz=
at
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <Sieu.Mun.Tang@intel.com>
> > Subject: RE: [resend v2 00/19] Add Cadence NAND Driver support
> >
> >
> >
> > > -----Original Message-----
> > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > Sent: Friday, 13 December 2024 5:16 pm
> > > To: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > > <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> > > Dario Binacchi <dario.binacchi@amarulasolutions.com>; Johan Jonker
> > > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>; Arseniy
> > > Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl
> > > <ada@thorsis.com>; William Zhang <william.zhang@broadcom.com>; Igor
> > > Prusov <ivprusov@salutedevices.com>; Meng, Tingting
> > > <tingting.meng@intel.com>; Chee, Tien Fong <tien.fong.chee@intel.com>=
;
> > > Hea, Kok Kiang <kok.kiang.hea@intel.com>; Ng, Boon Khai
> > > <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > > Subject: Re: [resend v2 00/19] Add Cadence NAND Driver support
> > >
> > > Hi
> > >
> > > On Thu, Dec 5, 2024 at 10:23=E2=80=AFAM <dinesh.maniyam@intel.com> wr=
ote:
> > > >
> > > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > >
> > > > This patchset add Cadence NAND driver support for Intel Agilex5
> > > > devices.
> > > >
> > > > The NAND driver is leveraged from the cadence-nand-controller.c fro=
m
> > > > Linux version 6.11.2. U-Boot will support read, write and erase NAN=
D
> > > > with Cadence driver. The driver further enhanced in U-Boot to
> > > > support NAND booting from FSBL and support boot to kernel via UBIFS=
.
> > > >
> > > > Patch status:
> > > > Have changes: All patches expect Patch 19
> > > >
> > > > Detail changelog can find in commit message.
> > > >
> > > > v1->v2:
> > > > --------
> > > > Patch 1 - 18:
> > > >
> > > > - remove the "this patch is to" commit phrases
> > > >
> > > > Patch 4;
> > > > - minor refactoring of code to match the stable version 6.11.2.
> > > >
> > > > Patch 14:
> > > > - Add maintainer and "#include" mechanism for new variant
> > > >
> > > > Patch 16:
> > > > - leverage the existing nand_spl_load_image
> > > >
> > >
> > > I have tried to build but it does not work. Have you tested in github=
?
> > >
> > > Michael
> >
> > Yet to deploy github test on our current platform.
> > Only checkpatch.pl and local built has been used as a metric for each c=
ommit
> > before submission.
> > And, all these commits are part of the firmware currently running on re=
al
> > hardware.
> >
> > >
> > > > History:
> > > > --------
> > > > [v1]:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.138=
5
> > > > 4-
> > > > 1-dinesh.maniyam@intel.com/
> > > >
> > > > Dinesh Maniyam (19):
> > > >   dt: nand: add cadence nand dt-bindings
> > > >   arm: dts: agilex5: Enabled cdns-nand dts setting
> > > >   include: asm: Add support to read/write 64-bit
> > > >   drivers: mtd: nand: Add driver for Cadence Nand
> > > >   drivers: mtd: nand: cadence: Add support for read status command
> > > >   drivers: mtd: nand: cadence: Add support for readid command
> > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
> > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
> > > >   drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATU=
RES
> > > >   drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
> > > >   drivers: mtd: nand: cadence: Poll for desc complete status
> > > >   drivers: mtd: nand: cadence: Use bounce buffer
> > > >   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
> > > >   configs: nand2_defconfig: Enable configs for nand boot
> > > >   drivers: mtd: nand: base: Add support for Hardware ECC for check =
bad
> > > >     block
> > > >   drivers: mtd: nand: spl: Add support for nand SPL load image
> > > >   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
> > > >   drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependenc=
y
> > > >   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
> > > >
> > > >  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
> > > >  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
> > > >  arch/arm/include/asm/io.h                     |   25 +
> > > >  board/intel/agilex5-socdk/MAINTAINERS         |    2 +
> > > >  configs/socfpga_agilex5_nand2_defconfig       |   33 +
> > > >  .../mtd/cadence,nand.yaml                     |   98 +
> > > >  drivers/mtd/nand/raw/Kconfig                  |   19 +-
> > > >  drivers/mtd/nand/raw/Makefile                 |    2 +
> > > >  drivers/mtd/nand/raw/cadence_nand.c           | 2424 +++++++++++++=
++++
> > > >  drivers/mtd/nand/raw/cadence_spl.c            |   59 +
> > > >  drivers/mtd/nand/raw/nand_base.c              |   71 +-
> > > >  include/cadence-nand.h                        |  529 ++++
> > > >  include/linux/mtd/rawnand.h                   |   14 +
> > > >  13 files changed, 3293 insertions(+), 25 deletions(-)  create mode
> > > > 100644 configs/socfpga_agilex5_nand2_defconfig
> > > >  create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
> > > >  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
> > > >  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
> > > >  create mode 100644 include/cadence-nand.h
> > > >
> > > > --
> > > > 2.19.0
> > > >
> > >
> > >
> > > --
> > > Michael Nazzareno Trimarchi
> > > Co-Founder & Chief Executive Officer
> > > M. +39 347 913 2170
> > > michael@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions BV
> > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > > info@amarulasolutions.com www.amarulasolutions.com



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
