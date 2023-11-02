Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5792EC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61D187780;
	Thu,  2 Nov 2023 15:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MpZ842gZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540B686FAE; Thu,  2 Nov 2023 15:18:39 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D83E877B7
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so994582276.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698934713; x=1699539513;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb5mhuPn7jT+oYlI6jH1G46J2tGTP8z6XJ/M6FCrbRg=;
 b=MpZ842gZ2PYCrfL/xXe9aphnGZfflM1Z//yJjbHAprRlUMseYYea86eQ7wnRGLnon9
 W9qZ6ZXGEVWpZHW5Bgt8nrqgRyPZwVCYnXDNV1dN1xPSsnZqnmQVPKd5MCKGedU6vAze
 UkKvXNdMI80Pp8hwGkE3OY0CQUKl8BiXV6b3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698934713; x=1699539513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eb5mhuPn7jT+oYlI6jH1G46J2tGTP8z6XJ/M6FCrbRg=;
 b=E1MOi8K5OVUFvSZhIyAOc7Fvuy1O4O7fP/O4q5t0Ge3CT2nUDJhfmyJAa944sAbj37
 7K6c9U0muudACjp4/v40emXxasl5YPgmZ816WwVFw/Mq4U8ZWi1GBF+y3Hb3EfeLGUiK
 w3I5cG6ocpIx72V9P7W7FAfhYTilXnfMbz8S3Huk36NaHWuHaPPftgtk2xcH9WPp02LI
 C2IyEWO1lsSHsrorZmqvJZt2663vC8smvrzkkl1gitt9I8hbPr+KXulVlQ8WSt0IDezf
 yFBoNRuxI+I8tY2G45lj1xmidAkLDg0GZoOU9paE8dlx6kgY975FLyUq4nOmAnd9I14x
 Fxug==
X-Gm-Message-State: AOJu0YwCPQiGoTFkIWt9Jat9OrYXyD04byzEHDwx2VxXK0Q5LzU0arXI
 G5qdox88i+GHLLQQLp6wI6MIq1AMtEzX6xh6zNiQ3A==
X-Google-Smtp-Source: AGHT+IFtonTJQwCas5KIWdNmDhX0PW9c63VL7HABUAG8YmC2swqjPMZKyJpzp+lmvOAOBI1rtdCY8x1iVNhJngVaslY=
X-Received: by 2002:a25:5f0e:0:b0:d9a:c946:c18a with SMTP id
 t14-20020a255f0e000000b00d9ac946c18amr17039761ybb.28.1698934713179; Thu, 02
 Nov 2023 07:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <CABGWkvq_Yw2Q7ZX9UeaO6a0Uf6V+-1Uh6BNOga6neq_tUVQNFA@mail.gmail.com>
 <b0f0c63e-e8b4-ba15-19c0-aca39a8f621b@gmail.com>
 <CABGWkvquxkPBVKeE2TMCOFcwfDGhh_ynH5gnU7FXO7x=TWqPjA@mail.gmail.com>
 <fd7d7511-6554-4746-ddf7-cab9de02fa8c@gmail.com>
In-Reply-To: <fd7d7511-6554-4746-ddf7-cab9de02fa8c@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 15:18:22 +0100
Message-ID: <CABGWkvo5_P332dFDf5hXrC1vv7XCx2rprFTaVKcKQtQf1f5w2g@mail.gmail.com>
Subject: Re: [PATCH 00/15] nand: Add sandbox tests
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>
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

On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Sean Anderson <seanga2@gmail.com> wr=
ote:
>
> On 11/2/23 10:08, Dario Binacchi wrote:
> > On Thu, Nov 2, 2023 at 3:06=E2=80=AFPM Sean Anderson <seanga2@gmail.com=
> wrote:
> >>
> >> On 11/2/23 10:01, Dario Binacchi wrote:
> >>> Sean, All,
> >>>
> >>> On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.=
com> wrote:
> >>>>
> >>>> This series tests raw nand flash in sandbox and fixes various bugs d=
iscovered in
> >>>> the process. I've tried to do things in a contemporary manner, avoid=
ing the
> >>>> (numerous) variations present on only a few boards. The test is pret=
ty minimal.
> >>>> Future work could test the rest of the nand API as well as the MTD A=
PI.
> >>>>
> >>>> Bloat at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> >>>> everything grows by a few bytes due to nand_page_size. A few boards =
grow more,
> >>>> mostly those using nand_spl_loaders.c.
> >>>>
> >>>> [1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922de6=
c2
> >>>>
> >>>>
> >>>> Sean Anderson (15):
> >>>>     spl: nand: Fix NULL-pointer dereference
> >>>>     nand: Don't dereference NULL manufacturer_desc
> >>>>     nand: Calculate SYS_NAND_PAGE_COUNT automatically
> >>>>     nand: spl_loaders: Only read enough pages to load the image
> >>>>     spl: legacy: Honor bl_len when decompressing
> >>>>     spl: nand: Set bl_len to page size
> >>>>     cmd: nand: Map memory before accessing it
> >>>>     spl: nand: Map memory before accessing it
> >>>>     mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
> >>>>     mtd: Add some fallbacks for add/del_mtd_device
> >>>>     nand: Add function to unregister NAND devices
> >>>>     nand: Allow reinitialization
> >>>>     arch: sandbox: Add function to create temporary files
> >>>>     nand: Add sandbox driver
> >>>>     test: spl: Add a test for NAND
> >>>>
> >>>>    README                                        |   9 +-
> >>>>    arch/sandbox/cpu/os.c                         |  17 +
> >>>>    arch/sandbox/dts/test.dts                     |  67 ++
> >>>>    arch/sandbox/include/asm/spl.h                |   1 +
> >>>>    cmd/nand.c                                    |  26 +-
> >>>>    common/spl/Kconfig                            |   2 +-
> >>>>    common/spl/spl_legacy.c                       |  18 +-
> >>>>    common/spl/spl_nand.c                         |  22 +-
> >>>>    configs/am335x_baltos_defconfig               |   3 +-
> >>>>    configs/am335x_evm_defconfig                  |   3 +-
> >>>>    configs/am335x_evm_spiboot_defconfig          |   2 +-
> >>>>    configs/am335x_guardian_defconfig             |   1 -
> >>>>    configs/am335x_hs_evm_defconfig               |   2 +-
> >>>>    configs/am335x_hs_evm_uart_defconfig          |   2 +-
> >>>>    configs/am335x_igep003x_defconfig             |   3 +-
> >>>>    configs/am335x_sl50_defconfig                 |   2 +-
> >>>>    configs/am3517_evm_defconfig                  |   3 +-
> >>>>    configs/am43xx_evm_defconfig                  |   3 +-
> >>>>    configs/am43xx_evm_rtconly_defconfig          |   3 +-
> >>>>    configs/am43xx_evm_usbhost_boot_defconfig     |   3 +-
> >>>>    configs/am43xx_hs_evm_defconfig               |   3 +-
> >>>>    configs/am62ax_evm_r5_defconfig               |   2 +-
> >>>>    configs/am65x_evm_a53_defconfig               |   2 +-
> >>>>    configs/axm_defconfig                         |   1 -
> >>>>    configs/chiliboard_defconfig                  |   1 -
> >>>>    configs/cm_t43_defconfig                      |   2 +-
> >>>>    configs/corvus_defconfig                      |   1 -
> >>>>    configs/da850evm_nand_defconfig               |   1 -
> >>>>    configs/devkit3250_defconfig                  |   1 -
> >>>>    configs/devkit8000_defconfig                  |   1 -
> >>>>    configs/dra7xx_evm_defconfig                  |   1 -
> >>>>    configs/draco_defconfig                       |   1 -
> >>>>    configs/etamin_defconfig                      |   1 -
> >>>>    .../gardena-smart-gateway-at91sam_defconfig   |   1 -
> >>>>    configs/igep00x0_defconfig                    |   3 +-
> >>>>    configs/imx6ulz_smm_m2_defconfig              |   2 +-
> >>>>    configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
> >>>>    configs/j7200_evm_a72_defconfig               |   2 +-
> >>>>    configs/j7200_evm_r5_defconfig                |   2 +-
> >>>>    configs/j721e_evm_a72_defconfig               |   2 +-
> >>>>    configs/j721e_evm_r5_defconfig                |   2 +-
> >>>>    configs/j721s2_evm_a72_defconfig              |   2 +-
> >>>>    configs/j721s2_evm_r5_defconfig               |   2 +-
> >>>>    configs/m53menlo_defconfig                    |   1 -
> >>>>    configs/omap35_logic_defconfig                |   3 +-
> >>>>    configs/omap35_logic_somlv_defconfig          |   3 +-
> >>>>    configs/omap3_beagle_defconfig                |   3 +-
> >>>>    configs/omap3_evm_defconfig                   |   3 +-
> >>>>    configs/omap3_logic_defconfig                 |   3 +-
> >>>>    configs/omap3_logic_somlv_defconfig           |   3 +-
> >>>>    configs/omapl138_lcdk_defconfig               |   1 -
> >>>>    configs/phycore-am335x-r2-regor_defconfig     |   3 +-
> >>>>    configs/phycore-am335x-r2-wega_defconfig      |   3 +-
> >>>>    configs/pxm2_defconfig                        |   1 -
> >>>>    configs/rastaban_defconfig                    |   1 -
> >>>>    configs/rut_defconfig                         |   1 -
> >>>>    configs/sama5d3_xplained_nandflash_defconfig  |   1 -
> >>>>    configs/sama5d3xek_nandflash_defconfig        |   1 -
> >>>>    configs/sama5d4_xplained_nandflash_defconfig  |   1 -
> >>>>    configs/sama5d4ek_nandflash_defconfig         |   1 -
> >>>>    configs/sandbox64_defconfig                   |  10 +-
> >>>>    configs/sandbox_defconfig                     |   9 +
> >>>>    configs/sandbox_noinst_defconfig              |  21 +-
> >>>>    configs/smartweb_defconfig                    |   1 -
> >>>>    configs/socfpga_secu1_defconfig               |   2 +-
> >>>>    configs/stm32746g-eval_spl_defconfig          |   2 +-
> >>>>    configs/stm32f746-disco_spl_defconfig         |   2 +-
> >>>>    configs/stm32f769-disco_spl_defconfig         |   2 +-
> >>>>    configs/stm32mp15_basic_defconfig             |   2 +-
> >>>>    configs/stm32mp15_dhcom_basic_defconfig       |   2 +-
> >>>>    configs/stm32mp15_dhcor_basic_defconfig       |   2 +-
> >>>>    configs/taurus_defconfig                      |   1 -
> >>>>    configs/thuban_defconfig                      |   1 -
> >>>>    drivers/mtd/Makefile                          |   2 +-
> >>>>    drivers/mtd/nand/raw/Kconfig                  |  27 +-
> >>>>    drivers/mtd/nand/raw/Makefile                 |   1 +
> >>>>    drivers/mtd/nand/raw/am335x_spl_bch.c         |   8 +-
> >>>>    drivers/mtd/nand/raw/atmel_nand.c             |  10 +-
> >>>>    drivers/mtd/nand/raw/denali_spl.c             |   5 +
> >>>>    drivers/mtd/nand/raw/fsl_ifc_spl.c            |   8 +
> >>>>    drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   5 +
> >>>>    drivers/mtd/nand/raw/mt7621_nand_spl.c        |   5 +
> >>>>    drivers/mtd/nand/raw/mxc_nand_spl.c           |  10 +-
> >>>>    drivers/mtd/nand/raw/mxs_nand_spl.c           |   5 +
> >>>>    drivers/mtd/nand/raw/nand.c                   |  66 +-
> >>>>    drivers/mtd/nand/raw/nand_base.c              |   7 +-
> >>>>    drivers/mtd/nand/raw/nand_spl_loaders.c       |   5 +-
> >>>>    drivers/mtd/nand/raw/nand_spl_simple.c        |  10 +-
> >>>>    drivers/mtd/nand/raw/omap_gpmc.c              |   3 +-
> >>>>    drivers/mtd/nand/raw/sand_nand.c              | 711 +++++++++++++=
+++++
> >>>>    drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
> >>>>    drivers/mtd/onenand/onenand_uboot.c           |   2 -
> >>>>    include/linux/mtd/mtd.h                       |  12 +
> >>>>    include/mtd/cfi_flash.h                       |   2 +-
> >>>>    include/nand.h                                |   3 +
> >>>>    include/os.h                                  |  13 +
> >>>>    include/system-constants.h                    |   3 +
> >>>>    test/dm/Makefile                              |   1 +
> >>>>    test/dm/nand.c                                | 106 +++
> >>>>    test/image/Kconfig                            |   9 +
> >>>>    test/image/Makefile                           |   1 +
> >>>>    test/image/spl_load_nand.c                    |  54 ++
> >>>>    102 files changed, 1269 insertions(+), 153 deletions(-)
> >>>>    create mode 100644 drivers/mtd/nand/raw/sand_nand.c
> >>>>    create mode 100644 test/dm/nand.c
> >>>>    create mode 100644 test/image/spl_load_nand.c
> >>>>
> >>>> --
> >>>> 2.37.1
> >>>>
> >>>
> >>> The CI pipeline fails:
> >>> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipeline=
s/18409
> >>>
> >>> It seems like the problem is only for the clang tests (sandbox64 with
> >>> clang test.py and sandbox with clang test.py)
> >>
> >> I can't view that link. Can you post the error somewhere else?
> >>
> >> I saw a clang error [1] when running CI before sending this out, but I=
 thought I had fixed it.
> >>
> >> --Sean
> >>
> >> [1] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18=
355
> >>
> >>      sandbox:  +   sandbox
> >> +drivers/mtd/nand/raw/sand_nand.c:386:2: error: variable 'src' is used=
 uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninit=
ialized]
> >> +        default:
> >> +        ^~~~~~~
> >> +drivers/mtd/nand/raw/sand_nand.c:395:14: note: uninitialized use occu=
rs here
> >> +        memcpy(buf, src + chip->column, to_copy);
> >> +                    ^~~
> >> +drivers/mtd/nand/raw/sand_nand.c:362:6: error: variable 'src' is used=
 uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uniniti=
alized]
> >> +        if (!chip->selected)
> >> +            ^~~~~~~~~~~~~~~
> >> +drivers/mtd/nand/raw/sand_nand.c:362:2: note: remove the 'if' if its =
condition is always false
> >> +        ^~~~~~~~~~~~~~~~~~~~
> >> +drivers/mtd/nand/raw/sand_nand.c:360:15: note: initialize the variabl=
e 'src' to silence this warning
> >> +        const u8 *src;
> >> +                     ^
> >> +                      =3D NULL
> >> +2 errors generated.
> >> +make[5]: *** [scripts/Makefile.build:256: drivers/mtd/nand/raw/sand_n=
and.o] Error 1
> >> +make[4]: *** [scripts/Makefile.build:397: drivers/mtd/nand/raw] Error=
 2
> >> +make[3]: *** [scripts/Makefile.build:397: drivers/mtd/nand] Error 2
> >> +make[2]: *** [scripts/Makefile.build:397: drivers/mtd] Error 2
> >> +make[1]: *** [Makefile:1858: drivers] Error 2
> >> +make: *** [Makefile:177: sub-make] Error 2
> >>
> >>
> >
> > +test/dm/nand.c:83:2: error: expression result unused [-Werror,-Wunused=
-value]
> > +        ut_assertok(nand_erase_opts(mtd, &opts));
> > +        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +include/test/ut.h:309:27: note: expanded from macro 'ut_assertok'
> > +#define ut_assertok(cond)       ut_asserteq(0, cond)
> > +                                ^~~~~~~~~~~~~~~~~~~~
> > +include/test/ut.h:162:2: note: expanded from macro 'ut_asserteq'
> > +        __ret;                                                        =
  \
> > +        ^~~~~
> > +1 error generated.
> > +make[3]: *** [scripts/Makefile.build:257: test/dm/nand.o] Error 1
> > +make[2]: *** [scripts/Makefile.build:397: test/dm] Error 2
> > +make[1]: *** [Makefile:1858: test] Error 2
> > +make: *** [Makefile:177: sub-make] Error 2
>
> ...well that's a new one. Wonder why it doesn't complain about all the ot=
her uses of
> ut_assertok (which, invariably, discard the value in the same way).

That's what I thought as well. It seems to be related to CLANG. Could it be=
 the
'unused-value' flag? I can't figure out why it causes the problem at
that point,
given that the 'ut_assertok()' is called even before the one that
generates the error.

Dario

>
> --Sean
>


--

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
