Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47075C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 09:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736D0807B1;
	Wed,  5 Mar 2025 10:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XFUH36V5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FDF807D9; Wed,  5 Mar 2025 10:27:14 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC74800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 10:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so13512558a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1741166829; x=1741771629;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CEYiTDi5CWva4lKB4qhusw4B8OhvmPAYjsJqZ6R6Cu8=;
 b=XFUH36V58vP+nRV6C9CKTx0Me0Mzk3v6dAv/enNWM6w48QWy/1rKpUPKl6dWe/Y7vQ
 KEJeNiGs9X8i5lqOsWzWkW6sVHZUESjy3EMi9bCW9BeZcO//HGGKQApZXOnBxJjQV2rf
 ls5H1smE3D8EJM5CdCKkOM1OQfaqIRGNzZteI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741166829; x=1741771629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEYiTDi5CWva4lKB4qhusw4B8OhvmPAYjsJqZ6R6Cu8=;
 b=AkgbfUHZWCnVvsLMIR9DLpacBTKAK+f5u2/KelG91g0ly3Z00ZJmJIXmu7xQyQlQC6
 qRwER2BdfVkwAAykQR/6M6mn9g8RuuQZug8B3BlAqStI7OYJ5Zt0EwY7sr5R9eWhC7jt
 WDcfdZqWWyy3H5FAnt0ScdrbK9UZvWQinDyflVi8AThyoteTvTnu0mishjY04v/OROqG
 vtB1oZOZY/utwp8TSUkAI/XHLFFoWRisR2OGrBwB8V0n6/vN70APE5PdKG42yG18Qa4L
 E+66cpeATdiLwJv7DxT98+VwWSQoVw0Pf73+mHbsdWELygZDt3KY7zZEjNO2ya7xjKqc
 l6xA==
X-Gm-Message-State: AOJu0Yynxa8stDuWHQVuPhD30FJ6fgONWgPl428OrDDMb0dAsOBwVe6e
 /uOtMme4bKZJYi57sc6g779AZluJybuRCDA468y029EJ19BZfyY0O6GHS2elGBtTv6RJfAOiI70
 InO/N7gTB99XCKaljzHLx8BE7xqFhlJugYrEdWQ==
X-Gm-Gg: ASbGncs8k/wSst4VOlUE4XmWwz8xWwyjlMZwIhgnqefIkuYgboTviWkOsnG1AJA3Hgy
 w/LpjgqqBEckE5A1qcOpPYmz7DlFb+UDgpsK6+xeJS7CJgiluI36DSUIDWx4ldDtxwVfOa+7EDS
 A++tgJ730HVvTCbO/K9BH88zG5lVy8TJIw54LhuamSS8dO8ZcJrl+tYFyu
X-Google-Smtp-Source: AGHT+IHpfiSirr1OJ4oM193iA4M5oTsdlxtMno8viDn7hyb66WIDn6KQwqcCFVTTt3eGQJJAIKU2Ofb9gPaSCTrKdAI=
X-Received: by 2002:a17:90b:5750:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-2ff497532b9mr4445584a91.15.1741166828565; Wed, 05 Mar 2025
 01:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
 <BL1PR11MB5366E83B40C89039B05C936C82C22@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB5366DE98806E5B38856CBB0182C22@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5366DE98806E5B38856CBB0182C22@BL1PR11MB5366.namprd11.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 5 Mar 2025 10:26:57 +0100
X-Gm-Features: AQ5f1JrWnHmFioROQdinUkNbgwS0k-5aiOc2g0Tqr1_1GZXF-082iJEtJsVoLHQ
Message-ID: <CAOf5uwn4owPKpAF_1jvxLLEAjqA3zkBKg9c5SGVGTi-NitMH4g@mail.gmail.com>
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

I have pushed a rebase of your patches on nand-next on my tree

I have dropped one patch for SPL_FRAMEWORK, drop the same in config of the
board. Move the config on the board as last patch, adjust one patch for a
code  style kisses
and push here

https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-n=
ext?ref_type=3Dheads

Michael


On Wed, Feb 26, 2025 at 5:36=E2=80=AFPM Maniyam, Dinesh <dinesh.maniyam@int=
el.com>
wrote:

>
>
> > -----Original Message-----
> > From: Maniyam, Dinesh
> > Sent: Wednesday, 26 February 2025 11:37 am
> > To: 'Michael Nazzareno Trimarchi' <michael@amarulasolutions.com>
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
> > Subject: RE: [resend v2 00/19] Add Cadence NAND Driver support
> >
> >
> >
> > > -----Original Message-----
> > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > Sent: Saturday, 25 January 2025 6:40 pm
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
> > > Hi Dinesh
> > >
> > > On Tue, Jan 21, 2025 at 9:39=E2=80=AFAM Maniyam, Dinesh
> > > <dinesh.maniyam@intel.com>
> > > wrote:
> > > >
> > > > Hi Michael,
> > > >
> > > > Any update on my NAND patchset ?. I can see it is still under revie=
w.
> > > > Is there anything I can do from my side to speed up the review
> process?
> > > > Thanks for your time.
> > > >
> > >
> > > Well, last time was not paassing the CI. I will test it again today
> > >
> > > Michael
> > >
> >
> > Hope you already run the CI test again.
> > If failing, may I get the link to the failing list of tests?
> >
> > Dinesh
> >
>
> Apologies!
> I think you mentioned that you were unable to build the code.
> I resubmitted v3 of this patchset, which will resolve warning/
> compilation issue. You can look at the cover patch to see
> the changes made for v3 in detail.
> Please help to use this v3 patchset in running CI test. Please let me kno=
w
> if you face any difficulties.
> Thanks for your time and consideration.
>
> Dinesh
>
> > > > > -----Original Message-----
> > > > > From: Maniyam, Dinesh
> > > > > Sent: Tuesday, 17 December 2024 3:41 pm
> > > > > To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > > > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > > > > <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> > > > > Dario Binacchi <dario.binacchi@amarulasolutions.com>; Johan Jonke=
r
> > > > > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>; Arseniy
> > > > > Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl
> > > > > <ada@thorsis.com>; William Zhang <william.zhang@broadcom.com>;
> > > > > Igor Prusov <ivprusov@salutedevices.com>; Meng, Tingting
> > > > > <tingting.meng@intel.com>; Chee, Tien Fong
> > > > > <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > > > > <kok.kiang.hea@intel.com>; Ng, Boon Khai <Boon.Khai.Ng@intel.com>=
;
> > > > > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri,
> > > > > Muhammad Hazim Izzat <muhammad.hazim.izzat.zamri@intel.com>; Lim,
> > > > > Jit Loon <jit.loon.lim@intel.com>; Tang, Sieu Mun
> > > > > <Sieu.Mun.Tang@intel.com>
> > > > > Subject: RE: [resend v2 00/19] Add Cadence NAND Driver support
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com=
>
> > > > > > Sent: Friday, 13 December 2024 5:16 pm
> > > > > > To: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > > > > > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > > > > > <simon.k.r.goldschmidt@gmail.com>; Tom Rini
> > > > > > <trini@konsulko.com>; Dario Binacchi
> > > > > > <dario.binacchi@amarulasolutions.com>; Johan Jonker
> > > > > > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>;
> > > > > > Arseniy Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl
> > > > > > <ada@thorsis.com>; William Zhang <william.zhang@broadcom.com>;
> > > > > > Igor Prusov <ivprusov@salutedevices.com>; Meng, Tingting
> > > > > > <tingting.meng@intel.com>; Chee, Tien Fong
> > > > > > <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > > > > > <kok.kiang.hea@intel.com>; Ng, Boon Khai
> > > > > > <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > > > > > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > > > > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > > > > <jit.loon.lim@intel.com>; Tang, Sieu Mun
> > > > > > <sieu.mun.tang@intel.com>
> > > > > > Subject: Re: [resend v2 00/19] Add Cadence NAND Driver support
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > On Thu, Dec 5, 2024 at 10:23=E2=80=AFAM <dinesh.maniyam@intel.c=
om>
> wrote:
> > > > > > >
> > > > > > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > > > > >
> > > > > > > This patchset add Cadence NAND driver support for Intel
> > > > > > > Agilex5 devices.
> > > > > > >
> > > > > > > The NAND driver is leveraged from the
> > > > > > > cadence-nand-controller.c from Linux version 6.11.2. U-Boot
> > > > > > > will support read, write and erase NAND with Cadence driver.
> > > > > > > The driver further enhanced in U-Boot to support NAND booting
> > > > > > > from FSBL and support boot to kernel via
> > > UBIFS.
> > > > > > >
> > > > > > > Patch status:
> > > > > > > Have changes: All patches expect Patch 19
> > > > > > >
> > > > > > > Detail changelog can find in commit message.
> > > > > > >
> > > > > > > v1->v2:
> > > > > > > --------
> > > > > > > Patch 1 - 18:
> > > > > > >
> > > > > > > - remove the "this patch is to" commit phrases
> > > > > > >
> > > > > > > Patch 4;
> > > > > > > - minor refactoring of code to match the stable version 6.11.=
2.
> > > > > > >
> > > > > > > Patch 14:
> > > > > > > - Add maintainer and "#include" mechanism for new variant
> > > > > > >
> > > > > > > Patch 16:
> > > > > > > - leverage the existing nand_spl_load_image
> > > > > > >
> > > > > >
> > > > > > I have tried to build but it does not work. Have you tested in
> github?
> > > > > >
> > > > > > Michael
> > > > >
> > > > > Yet to deploy github test on our current platform.
> > > > > Only checkpatch.pl and local built has been used as a metric for
> > > > > each commit before submission.
> > > > > And, all these commits are part of the firmware currently running
> > > > > on real hardware.
> > > > >
> > > > > >
> > > > > > > History:
> > > > > > > --------
> > > > > > > [v1]:
> > > > > > >
> https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.
> > > > > > > 1385
> > > > > > > 4-
> > > > > > > 1-dinesh.maniyam@intel.com/
> > > > > > >
> > > > > > > Dinesh Maniyam (19):
> > > > > > >   dt: nand: add cadence nand dt-bindings
> > > > > > >   arm: dts: agilex5: Enabled cdns-nand dts setting
> > > > > > >   include: asm: Add support to read/write 64-bit
> > > > > > >   drivers: mtd: nand: Add driver for Cadence Nand
> > > > > > >   drivers: mtd: nand: cadence: Add support for read status
> command
> > > > > > >   drivers: mtd: nand: cadence: Add support for readid command
> > > > > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
> > > > > > >   drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
> > > > > > >   drivers: mtd: nand: cadence: Support cmd SET_FEATURES &
> > > GET_FEATURES
> > > > > > >   drivers: mtd: nand: cadence: Flush & invalidate dma
> descriptor
> > > > > > >   drivers: mtd: nand: cadence: Poll for desc complete status
> > > > > > >   drivers: mtd: nand: cadence: Use bounce buffer
> > > > > > >   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
> > > > > > >   configs: nand2_defconfig: Enable configs for nand boot
> > > > > > >   drivers: mtd: nand: base: Add support for Hardware ECC for
> check bad
> > > > > > >     block
> > > > > > >   drivers: mtd: nand: spl: Add support for nand SPL load imag=
e
> > > > > > >   drivers: mtd: nand: Enabled Kconfig and Makefile for
> Cadence-SPL
> > > > > > >   drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE
> > > dependency
> > > > > > >   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nan=
d
> > > > > > > SPL
> > > > > > >
> > > > > > >  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
> > > > > > >  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
> > > > > > >  arch/arm/include/asm/io.h                     |   25 +
> > > > > > >  board/intel/agilex5-socdk/MAINTAINERS         |    2 +
> > > > > > >  configs/socfpga_agilex5_nand2_defconfig       |   33 +
> > > > > > >  .../mtd/cadence,nand.yaml                     |   98 +
> > > > > > >  drivers/mtd/nand/raw/Kconfig                  |   19 +-
> > > > > > >  drivers/mtd/nand/raw/Makefile                 |    2 +
> > > > > > >  drivers/mtd/nand/raw/cadence_nand.c           | 2424
> > > +++++++++++++++++
> > > > > > >  drivers/mtd/nand/raw/cadence_spl.c            |   59 +
> > > > > > >  drivers/mtd/nand/raw/nand_base.c              |   71 +-
> > > > > > >  include/cadence-nand.h                        |  529 ++++
> > > > > > >  include/linux/mtd/rawnand.h                   |   14 +
> > > > > > >  13 files changed, 3293 insertions(+), 25 deletions(-)  creat=
e
> > > > > > > mode
> > > > > > > 100644 configs/socfpga_agilex5_nand2_defconfig
> > > > > > >  create mode 100644
> > > > > > > doc/device-tree-bindings/mtd/cadence,nand.yaml
> > > > > > >  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
> > > > > > >  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
> > > > > > >  create mode 100644 include/cadence-nand.h
> > > > > > >
> > > > > > > --
> > > > > > > 2.19.0
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Michael Nazzareno Trimarchi
> > > > > > Co-Founder & Chief Executive Officer M. +39 347 913 2170
> > > > > > michael@amarulasolutions.com
> > __________________________________
> > > > > >
> > > > > > Amarula Solutions BV
> > > > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111
> > > > > > 9172 info@amarulasolutions.com www.amarulasolutions.com
> > >
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
