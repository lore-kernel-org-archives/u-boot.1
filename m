Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2002AC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 04:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C34780BAA;
	Thu,  6 Mar 2025 05:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VECIjPG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605B480E94; Thu,  6 Mar 2025 05:23:56 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADA580805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 05:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so445760a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 20:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1741235031; x=1741839831;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fHfczpl7+NykXcPAJcYSAd6sn8Y/QB1y7hqYUHROas=;
 b=VECIjPG3OjioE6UiY20CmByqJt/5V7Am1jTdABn8/ETWiAEWx/B6hDgxjt2IKZyC76
 br50NSD4EQM8VN+ouw4GBGLAujVEnSFDcE6is7xJqAlw96pl0AQaPeln9K+sEW6Nr4YB
 UZ8tYPxAlBB6Xb0N2s8w6NmLgsGey586OhsX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741235031; x=1741839831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1fHfczpl7+NykXcPAJcYSAd6sn8Y/QB1y7hqYUHROas=;
 b=RA8snfjeGp99auCiNmIRbKiOvfC/LrpxNB5PfkpD2eRpkaKWbcEBwEfr0RWUH8j+/o
 +f36GQ1WnMAIFoaKbJji8wk0MCAcDiUf7H/I6cpMbTjuvPYth4uOZl6yEEFHjXYGRCFL
 CKgRxXAjYqNpR3pIJDWPIxsnztOGLbDLBT+PjHSRY5IGtjim/3NBxryMRQmlKJPb54IT
 jckAydnIrrBB3DzjXFq5JavQ0QAMlNm8hm060q6VKhxYjwKcdMdoJ1W2Eq/xVFL+ltg7
 GJfdLuuXZ6SSejFr7tK/IIC26RIDzKH5BZStIhFHsulcjqs4D3FGU38kpXI1LAS411yl
 wABw==
X-Gm-Message-State: AOJu0Yx4JBmkRIgnvYzUDX207tg1izB/oIpnt/OABUKRvsf2AD9YROB2
 nt6+nPnfmzvh/1sdHjkq3yIS8S2EFO2kcuj6oHC5KA3BdtdRyO/2g6Pxc3nf+9foqkZzgXGgeCe
 tts/hWOpx0sHFvw6wWw5yeCvTjY4UeK3uuWamEw==
X-Gm-Gg: ASbGncvyjW8FIevRJheG26+s+M9JrXjqUoNegACmuYepDHq0aYcrmeSicJznXETAXf2
 E/COAz+qkCW/QvWURGE6BWGSUfWdn1JimkabpzA4F0LJDBf0VolgNNeDISW1QFAC4CTVw75FoLS
 Q9D/Vqq0jX0WWDiDpMR04bhOFK
X-Google-Smtp-Source: AGHT+IH1476zYOPeuaUsuVm6A1MeiJOaFmu5jDgG9YypuXHbu+3wLXzvaQGr1Gqa7MbOvKAM1IOmgLYQ7hADW0CZGUw=
X-Received: by 2002:a05:6a21:7308:b0:1f3:45cc:c6fb with SMTP id
 adf61e73a8af0-1f349496a41mr10512418637.19.1741235030869; Wed, 05 Mar 2025
 20:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <CAOf5uwn+OAqHL9SkZsR+YzctT3mNxOh6GXaqdN1i6ByOzVnSAA@mail.gmail.com>
 <BL1PR11MB5366A416815F15738B0F850382CD2@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BN7PR03MB4387C008016C4E74EB1DE095F7CB2@BN7PR03MB4387.namprd03.prod.outlook.com>
In-Reply-To: <BN7PR03MB4387C008016C4E74EB1DE095F7CB2@BN7PR03MB4387.namprd03.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 6 Mar 2025 05:23:39 +0100
X-Gm-Features: AQ5f1JoEf0QGAdqwzfhlGjs_0X_LL19oremUz5dDXXbFfHo5RatvoN1r2n-RevI
Message-ID: <CAOf5uwn7XGqja5wFPPgBY27xZ1ACgu2AQbbwKJc2kCSF+Zz_9w@mail.gmail.com>
Subject: Re: [resend v3 00/19] Add Cadence NAND Driver support
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, "Meng,
 Tingting" <tingting.meng@intel.com>, 
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@intel.com>, 
 "Ng, Boon Khai" <Boon.Khai.Ng@intel.com>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, 
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>, "Tang,
 Sieu Mun" <Sieu.Mun.Tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Il mer 5 mar 2025, 05:11 Maniyam, Dinesh <dinesh.maniyam@altera.com> ha
scritto:

>
>
> > -----Original Message-----
> > From: Maniyam, Dinesh
> > Sent: Thursday, 27 February 2025 3:20 pm
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
> > <kok.kiang.hea@intel.com>; Ng, Boon Khai <Boon.Khai.Ng@intel.com>;
> Yuslaimi,
> > Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim
> Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <Sieu.Mun.Tang@intel.com>
> > Subject: RE: [resend v3 00/19] Add Cadence NAND Driver support
> >
> >
> >
> > > -----Original Message-----
> > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > Sent: Thursday, 27 February 2025 2:34 pm
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
> > > Subject: Re: [resend v3 00/19] Add Cadence NAND Driver support
> > >
> > > Hi Dinesh
> > >
>
> Hi
>
> > > On Wed, Feb 26, 2025 at 5:18=E2=80=AFPM <dinesh.maniyam@intel.com> wr=
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
> > >
> > > I have just applied on top of master and they are not applied clean. =
I
> > > can fix these conflicts by myself this conflicts, but I would like
> > > that when you apply patches you fix warnings like trailing space.
> > >
> >
> > My apologies, but I think I did not use the latest master version.
> > I will take note of this.
> >
> > > Applying: dt: nand: add cadence nand dt-bindings
> > > Applying: arm: dts: agilex5: Enabled cdns-nand dts setting
> > > Applying: drivers: mtd: nand: Add driver for Cadence Nand
> > > Applying: drivers: mtd: nand: cadence: Add support for read status
> > > command
> > > Applying: drivers: mtd: nand: cadence: Add support for readid command
> > > Applying: drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
> > > Applying: drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
> > > Applying: drivers: mtd: nand: cadence: Support cmd SET_FEATURES &
> > > GET_FEATURES
> > > Applying: drivers: mtd: nand: cadence: Flush & invalidate dma
> > > descriptor
> > > Applying: drivers: mtd: nand: cadence: Poll for desc complete status
> > > Applying: drivers: mtd: nand: cadence: Use bounce buffer
> > > Applying: drivers: nand: Enabled Kconfig and Makefile for cdns-nand
> > > Applying: configs: nand2_defconfig: Enable configs for nand boot
> > > Applying: drivers: mtd: nand: base: Add support for Hardware ECC for
> > > check bad block
> > > Applying: drivers: mtd: nand: spl: Add support for nand SPL load imag=
e
> > > .git/rebase-apply/patch:19: trailing whitespace.
> > >  * Copyright (C) 2024 Intel Corporation <www.intel.com>
> > > warning: 1 line adds whitespace errors.
> > >
> > > Apart of that
> > >
> > > pplying: drivers: mtd: nand: Enabled Kconfig and Makefile for
> > > SPL_NAND_FRAMEWORK
> > > error: patch failed: drivers/mtd/nand/raw/Makefile:3
> > > error: drivers/mtd/nand/raw/Makefile: patch does not apply Patch
> > > failed at 0017
> > > drivers: mtd: nand: Enabled Kconfig and Makefile for
> > > SPL_NAND_FRAMEWORK
> > > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patc=
h
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort=
".
> > >
> > > I will review the rest
> > >
> > > Michael
> > >
> >
> > Thanks for your time!
> >  Please let me know if you want me to resubmit the patchset using the
> latest
> > master.
> >
> > Dinesh
>
> Please let me know once you finish reviewing the NAND patchset.
> Thanks for your time.
>


I can not test your patches I push back. You should check your board if
still is ok. As I mention I have changed your configuration and reduce the
number of patches

Let me know if it's still ok

Michael

>
> Dinesh
>
> >
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
> > > > v2->v3:
> > > > --------
> > > > Patch: arm: dts: agilex5: Enabled cdns-nand dts setting
> > > > - Move &nand from uboot.dtsi to socdk.dts
> > > >
> > > > Patch: include: asm: Add support to read/write 64-bit
> > > > - Dropped because redefinition of readsq & writesq
> > > >
> > > > Patch: drivers: mtd: nand: Add driver for Cadence Nand
> > > > - Remove redundant clk_free func
> > > >
> > > > Patch: drivers: mtd: nand: Enabled Kconfig and Makefile for
> > > > SPL_NAND_FRAMEWORK
> > > > - New
> > > >
> > > > Patch: drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE
> > > > dependency
> > > > - New
> > > >
> > > > Patch: configs: nand2_defconfig: Enable configs for nand boot
> > > > - Remove CONFIG_OF_UPSTREAM in order to get correct dts for
> > > > compilation
> > > >
> > > > Patch: drivers: mtd: nand: base: Add support for Hardware ECC for
> > > > check bad block
> > > > - Remove copyright
> > > >
> > > > Patch: drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE
> > > > dependency
> > > > - Dropped because SPL NAND have dependency with SYS_NAND_BLOCK_SIZE
> > > >
> > > > History:
> > > > --------
> > > > [v1]:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.138=
5
> > > > 4-
> > > > 1-dinesh.maniyam@intel.com/
> > > > [v2]:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20241205092315.250=
6
> > > > 0-
> > > > 1-dinesh.maniyam@intel.com/
> > > >
> > > > Dinesh Maniyam (19):
> > > >   dt: nand: add cadence nand dt-bindings
> > > >   arm: dts: agilex5: Enabled cdns-nand dts setting
> > > >   drivers: mtd: nand: Add driver for Cadence Nand
> > > >   drivers: mtd: nand: cadence: Add support for read status command
> > > >   drivers: mtd: nand: cadence: Add support for readid command
> > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
> > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
> > > >   drivers: mtd: nand: cadence: Support cmd SET_FEATURES &
> GET_FEATURES
> > > >   drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
> > > >   drivers: mtd: nand: cadence: Poll for desc complete status
> > > >   drivers: mtd: nand: cadence: Use bounce buffer
> > > >   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
> > > >   configs: nand2_defconfig: Enable configs for nand boot
> > > >   drivers: mtd: nand: base: Add support for Hardware ECC for check
> bad
> > > >     block
> > > >   drivers: mtd: nand: spl: Add support for nand SPL load image
> > > >   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
> > > >   drivers: mtd: nand: Enabled Kconfig and Makefile for
> > > >     SPL_NAND_FRAMEWORK
> > > >   drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
> > > >   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
> > > >
> > > >  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
> > > >  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |    9 +-
> > > >  arch/arm/dts/socfpga_agilex5_socdk.dts        |   19 +
> > > >  board/intel/agilex5-socdk/MAINTAINERS         |    2 +
> > > >  configs/socfpga_agilex5_nand2_defconfig       |   32 +
> > > >  .../mtd/cadence,nand.yaml                     |   98 +
> > > >  drivers/mtd/nand/raw/Kconfig                  |   26 +-
> > > >  drivers/mtd/nand/raw/Makefile                 |   12 +
> > > >  drivers/mtd/nand/raw/cadence_nand.c           | 2423
> +++++++++++++++++
> > > >  drivers/mtd/nand/raw/cadence_spl.c            |   59 +
> > > >  drivers/mtd/nand/raw/nand_base.c              |   69 +-
> > > >  include/cadence-nand.h                        |  529 ++++
> > > >  include/linux/mtd/rawnand.h                   |   12 +
> > > >  13 files changed, 3278 insertions(+), 26 deletions(-)  create mode
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
>
