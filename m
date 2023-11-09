Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF563C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 08:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B9286FA0;
	Thu,  9 Nov 2023 09:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ywam70GK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AA186F6E; Thu,  9 Nov 2023 09:23:21 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB06986FA0
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 09:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-da3b4b7c6bdso654483276.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699518196; x=1700122996;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQNBuoTtEx637NguUL+WyFfQ6HnmanpcdDUQqgq+CuI=;
 b=Ywam70GK/JIBI3FAdRwwN0LcJ8VNbsVE+jykMi8rLd0A//9lpI3ifffC3EWVC40nGh
 FVMDhdhF6D0eXs3K1XNhFm3Sy5cH3LNFJJWHz7K0nt1Ljr5oHp3wlCgxbQVjinkovffo
 WoShsvDvYUnx2nVjf6/uE4j9kodZrGQq2jVMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699518196; x=1700122996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQNBuoTtEx637NguUL+WyFfQ6HnmanpcdDUQqgq+CuI=;
 b=YTKnNAwu92q4FMlt9z8ksIpzqz9dWsiHklXFo2127bI67gCkdCDKBtR4WrC/2yiPrg
 7zL5nE4JbJ3HYw3gJOkwnLau3ZwGv0CiRU8nNFK/SqlTNCoUkreoXL04LZ6qgbZycngQ
 4eamgR/yz+mwjCS8Sn3B73HMW06tujP1yg53b/Xhvz0lc5OG8aRNl99vKNKszrBUu7Kt
 hCXVaBa04qgFrONuglIIvpQ9wC8byipf6uMstdLxgaMbMSCvlXNHBecgDRAnyvu3X0Vv
 N8gMqBSFe2zHfsxKaYzJ+c4OIhUaKQBOfxUbvGV+a76TVz73y3Rff7pZ0nDinMD0qqQg
 3CNQ==
X-Gm-Message-State: AOJu0Yy6k8O0sSzfimwSEUGpi7dFGMWv7AlfCKjOeZm4F1CPz714/E60
 7Ew0DHTmsNTSOyNlG7c2yE6ZOr/3Z+h/YPGjLKD0qQ==
X-Google-Smtp-Source: AGHT+IFxTnif446dEfKqaBzo22jRHucF66z2tUJIsvlnGSGjVz472GgSLnh3+KT+J27OY2fo1jgLVZSZhP8sDmDr8Z8=
X-Received: by 2002:a25:e713:0:b0:d86:5844:a897 with SMTP id
 e19-20020a25e713000000b00d865844a897mr3967320ybh.5.1699518196475; Thu, 09 Nov
 2023 00:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <CABGWkvq_Yw2Q7ZX9UeaO6a0Uf6V+-1Uh6BNOga6neq_tUVQNFA@mail.gmail.com>
 <b0f0c63e-e8b4-ba15-19c0-aca39a8f621b@gmail.com>
 <CABGWkvquxkPBVKeE2TMCOFcwfDGhh_ynH5gnU7FXO7x=TWqPjA@mail.gmail.com>
 <fd7d7511-6554-4746-ddf7-cab9de02fa8c@gmail.com>
 <CABGWkvo5_P332dFDf5hXrC1vv7XCx2rprFTaVKcKQtQf1f5w2g@mail.gmail.com>
 <803eb38b-a41d-8097-dfb7-6ad8800b3841@gmail.com>
In-Reply-To: <803eb38b-a41d-8097-dfb7-6ad8800b3841@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 9 Nov 2023 09:23:05 +0100
Message-ID: <CABGWkvq4xXKz5714tar3Jt6XrQyJngTyirjkjk4RZFALRRzs+w@mail.gmail.com>
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

Sean, All

On Sat, Nov 4, 2023 at 8:46=E2=80=AFPM Sean Anderson <seanga2@gmail.com> wr=
ote:
>
> On 11/2/23 10:18, Dario Binacchi wrote:
> > On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Sean Anderson <seanga2@gmail.com=
> wrote:
> >>
> >> On 11/2/23 10:08, Dario Binacchi wrote:
> >>> On Thu, Nov 2, 2023 at 3:06=E2=80=AFPM Sean Anderson <seanga2@gmail.c=
om> wrote:
> >>>>
> >>>> On 11/2/23 10:01, Dario Binacchi wrote:
> >>>>> Sean, All,
> >>>>>
> >>>>> On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmai=
l.com> wrote:
> >>>>>>
> >>>>>> This series tests raw nand flash in sandbox and fixes various bugs=
 discovered in
> >>>>>> the process. I've tried to do things in a contemporary manner, avo=
iding the
> >>>>>> (numerous) variations present on only a few boards. The test is pr=
etty minimal.
> >>>>>> Future work could test the rest of the nand API as well as the MTD=
 API.
> >>>>>>
> >>>>>> Bloat at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> >>>>>> everything grows by a few bytes due to nand_page_size. A few board=
s grow more,
> >>>>>> mostly those using nand_spl_loaders.c.
> >>>>>>
> >>>>>> [1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922d=
e6c2
> >>>>>>
> >>>>>>
> >>>>>> Sean Anderson (15):
> >>>>>>      spl: nand: Fix NULL-pointer dereference
> >>>>>>      nand: Don't dereference NULL manufacturer_desc
> >>>>>>      nand: Calculate SYS_NAND_PAGE_COUNT automatically
> >>>>>>      nand: spl_loaders: Only read enough pages to load the image
> >>>>>>      spl: legacy: Honor bl_len when decompressing
> >>>>>>      spl: nand: Set bl_len to page size
> >>>>>>      cmd: nand: Map memory before accessing it
> >>>>>>      spl: nand: Map memory before accessing it
> >>>>>>      mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
> >>>>>>      mtd: Add some fallbacks for add/del_mtd_device
> >>>>>>      nand: Add function to unregister NAND devices
> >>>>>>      nand: Allow reinitialization
> >>>>>>      arch: sandbox: Add function to create temporary files
> >>>>>>      nand: Add sandbox driver
> >>>>>>      test: spl: Add a test for NAND
> >>>>>>
> >>>>>>     README                                        |   9 +-
> >>>>>>     arch/sandbox/cpu/os.c                         |  17 +
> >>>>>>     arch/sandbox/dts/test.dts                     |  67 ++
> >>>>>>     arch/sandbox/include/asm/spl.h                |   1 +
> >>>>>>     cmd/nand.c                                    |  26 +-
> >>>>>>     common/spl/Kconfig                            |   2 +-
> >>>>>>     common/spl/spl_legacy.c                       |  18 +-
> >>>>>>     common/spl/spl_nand.c                         |  22 +-
> >>>>>>     configs/am335x_baltos_defconfig               |   3 +-
> >>>>>>     configs/am335x_evm_defconfig                  |   3 +-
> >>>>>>     configs/am335x_evm_spiboot_defconfig          |   2 +-
> >>>>>>     configs/am335x_guardian_defconfig             |   1 -
> >>>>>>     configs/am335x_hs_evm_defconfig               |   2 +-
> >>>>>>     configs/am335x_hs_evm_uart_defconfig          |   2 +-
> >>>>>>     configs/am335x_igep003x_defconfig             |   3 +-
> >>>>>>     configs/am335x_sl50_defconfig                 |   2 +-
> >>>>>>     configs/am3517_evm_defconfig                  |   3 +-
> >>>>>>     configs/am43xx_evm_defconfig                  |   3 +-
> >>>>>>     configs/am43xx_evm_rtconly_defconfig          |   3 +-
> >>>>>>     configs/am43xx_evm_usbhost_boot_defconfig     |   3 +-
> >>>>>>     configs/am43xx_hs_evm_defconfig               |   3 +-
> >>>>>>     configs/am62ax_evm_r5_defconfig               |   2 +-
> >>>>>>     configs/am65x_evm_a53_defconfig               |   2 +-
> >>>>>>     configs/axm_defconfig                         |   1 -
> >>>>>>     configs/chiliboard_defconfig                  |   1 -
> >>>>>>     configs/cm_t43_defconfig                      |   2 +-
> >>>>>>     configs/corvus_defconfig                      |   1 -
> >>>>>>     configs/da850evm_nand_defconfig               |   1 -
> >>>>>>     configs/devkit3250_defconfig                  |   1 -
> >>>>>>     configs/devkit8000_defconfig                  |   1 -
> >>>>>>     configs/dra7xx_evm_defconfig                  |   1 -
> >>>>>>     configs/draco_defconfig                       |   1 -
> >>>>>>     configs/etamin_defconfig                      |   1 -
> >>>>>>     .../gardena-smart-gateway-at91sam_defconfig   |   1 -
> >>>>>>     configs/igep00x0_defconfig                    |   3 +-
> >>>>>>     configs/imx6ulz_smm_m2_defconfig              |   2 +-
> >>>>>>     configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
> >>>>>>     configs/j7200_evm_a72_defconfig               |   2 +-
> >>>>>>     configs/j7200_evm_r5_defconfig                |   2 +-
> >>>>>>     configs/j721e_evm_a72_defconfig               |   2 +-
> >>>>>>     configs/j721e_evm_r5_defconfig                |   2 +-
> >>>>>>     configs/j721s2_evm_a72_defconfig              |   2 +-
> >>>>>>     configs/j721s2_evm_r5_defconfig               |   2 +-
> >>>>>>     configs/m53menlo_defconfig                    |   1 -
> >>>>>>     configs/omap35_logic_defconfig                |   3 +-
> >>>>>>     configs/omap35_logic_somlv_defconfig          |   3 +-
> >>>>>>     configs/omap3_beagle_defconfig                |   3 +-
> >>>>>>     configs/omap3_evm_defconfig                   |   3 +-
> >>>>>>     configs/omap3_logic_defconfig                 |   3 +-
> >>>>>>     configs/omap3_logic_somlv_defconfig           |   3 +-
> >>>>>>     configs/omapl138_lcdk_defconfig               |   1 -
> >>>>>>     configs/phycore-am335x-r2-regor_defconfig     |   3 +-
> >>>>>>     configs/phycore-am335x-r2-wega_defconfig      |   3 +-
> >>>>>>     configs/pxm2_defconfig                        |   1 -
> >>>>>>     configs/rastaban_defconfig                    |   1 -
> >>>>>>     configs/rut_defconfig                         |   1 -
> >>>>>>     configs/sama5d3_xplained_nandflash_defconfig  |   1 -
> >>>>>>     configs/sama5d3xek_nandflash_defconfig        |   1 -
> >>>>>>     configs/sama5d4_xplained_nandflash_defconfig  |   1 -
> >>>>>>     configs/sama5d4ek_nandflash_defconfig         |   1 -
> >>>>>>     configs/sandbox64_defconfig                   |  10 +-
> >>>>>>     configs/sandbox_defconfig                     |   9 +
> >>>>>>     configs/sandbox_noinst_defconfig              |  21 +-
> >>>>>>     configs/smartweb_defconfig                    |   1 -
> >>>>>>     configs/socfpga_secu1_defconfig               |   2 +-
> >>>>>>     configs/stm32746g-eval_spl_defconfig          |   2 +-
> >>>>>>     configs/stm32f746-disco_spl_defconfig         |   2 +-
> >>>>>>     configs/stm32f769-disco_spl_defconfig         |   2 +-
> >>>>>>     configs/stm32mp15_basic_defconfig             |   2 +-
> >>>>>>     configs/stm32mp15_dhcom_basic_defconfig       |   2 +-
> >>>>>>     configs/stm32mp15_dhcor_basic_defconfig       |   2 +-
> >>>>>>     configs/taurus_defconfig                      |   1 -
> >>>>>>     configs/thuban_defconfig                      |   1 -
> >>>>>>     drivers/mtd/Makefile                          |   2 +-
> >>>>>>     drivers/mtd/nand/raw/Kconfig                  |  27 +-
> >>>>>>     drivers/mtd/nand/raw/Makefile                 |   1 +
> >>>>>>     drivers/mtd/nand/raw/am335x_spl_bch.c         |   8 +-
> >>>>>>     drivers/mtd/nand/raw/atmel_nand.c             |  10 +-
> >>>>>>     drivers/mtd/nand/raw/denali_spl.c             |   5 +
> >>>>>>     drivers/mtd/nand/raw/fsl_ifc_spl.c            |   8 +
> >>>>>>     drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   5 +
> >>>>>>     drivers/mtd/nand/raw/mt7621_nand_spl.c        |   5 +
> >>>>>>     drivers/mtd/nand/raw/mxc_nand_spl.c           |  10 +-
> >>>>>>     drivers/mtd/nand/raw/mxs_nand_spl.c           |   5 +
> >>>>>>     drivers/mtd/nand/raw/nand.c                   |  66 +-
> >>>>>>     drivers/mtd/nand/raw/nand_base.c              |   7 +-
> >>>>>>     drivers/mtd/nand/raw/nand_spl_loaders.c       |   5 +-
> >>>>>>     drivers/mtd/nand/raw/nand_spl_simple.c        |  10 +-
> >>>>>>     drivers/mtd/nand/raw/omap_gpmc.c              |   3 +-
> >>>>>>     drivers/mtd/nand/raw/sand_nand.c              | 711 ++++++++++=
++++++++
> >>>>>>     drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
> >>>>>>     drivers/mtd/onenand/onenand_uboot.c           |   2 -
> >>>>>>     include/linux/mtd/mtd.h                       |  12 +
> >>>>>>     include/mtd/cfi_flash.h                       |   2 +-
> >>>>>>     include/nand.h                                |   3 +
> >>>>>>     include/os.h                                  |  13 +
> >>>>>>     include/system-constants.h                    |   3 +
> >>>>>>     test/dm/Makefile                              |   1 +
> >>>>>>     test/dm/nand.c                                | 106 +++
> >>>>>>     test/image/Kconfig                            |   9 +
> >>>>>>     test/image/Makefile                           |   1 +
> >>>>>>     test/image/spl_load_nand.c                    |  54 ++
> >>>>>>     102 files changed, 1269 insertions(+), 153 deletions(-)
> >>>>>>     create mode 100644 drivers/mtd/nand/raw/sand_nand.c
> >>>>>>     create mode 100644 test/dm/nand.c
> >>>>>>     create mode 100644 test/image/spl_load_nand.c
> >>>>>>
> >>>>>> --
> >>>>>> 2.37.1
> >>>>>>
> >>>>>
> >>>>> The CI pipeline fails:
> >>>>> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipeli=
nes/18409
> >>>>>
> >>>>> It seems like the problem is only for the clang tests (sandbox64 wi=
th
> >>>>> clang test.py and sandbox with clang test.py)
> >>>>
> >>>> I can't view that link. Can you post the error somewhere else?
> >>>>
> >>>> I saw a clang error [1] when running CI before sending this out, but=
 I thought I had fixed it.
> >>>>
> >>>> --Sean
> >>>>
> >>>> [1] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/=
18355
> >>>>
> >>>>       sandbox:  +   sandbox
> >>>> +drivers/mtd/nand/raw/sand_nand.c:386:2: error: variable 'src' is us=
ed uninitialized whenever switch default is taken [-Werror,-Wsometimes-unin=
itialized]
> >>>> +        default:
> >>>> +        ^~~~~~~
> >>>> +drivers/mtd/nand/raw/sand_nand.c:395:14: note: uninitialized use oc=
curs here
> >>>> +        memcpy(buf, src + chip->column, to_copy);
> >>>> +                    ^~~
> >>>> +drivers/mtd/nand/raw/sand_nand.c:362:6: error: variable 'src' is us=
ed uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-unini=
tialized]
> >>>> +        if (!chip->selected)
> >>>> +            ^~~~~~~~~~~~~~~
> >>>> +drivers/mtd/nand/raw/sand_nand.c:362:2: note: remove the 'if' if it=
s condition is always false
> >>>> +        ^~~~~~~~~~~~~~~~~~~~
> >>>> +drivers/mtd/nand/raw/sand_nand.c:360:15: note: initialize the varia=
ble 'src' to silence this warning
> >>>> +        const u8 *src;
> >>>> +                     ^
> >>>> +                      =3D NULL
> >>>> +2 errors generated.
> >>>> +make[5]: *** [scripts/Makefile.build:256: drivers/mtd/nand/raw/sand=
_nand.o] Error 1
> >>>> +make[4]: *** [scripts/Makefile.build:397: drivers/mtd/nand/raw] Err=
or 2
> >>>> +make[3]: *** [scripts/Makefile.build:397: drivers/mtd/nand] Error 2
> >>>> +make[2]: *** [scripts/Makefile.build:397: drivers/mtd] Error 2
> >>>> +make[1]: *** [Makefile:1858: drivers] Error 2
> >>>> +make: *** [Makefile:177: sub-make] Error 2
> >>>>
> >>>>
> >>>
> >>> +test/dm/nand.c:83:2: error: expression result unused [-Werror,-Wunus=
ed-value]
> >>> +        ut_assertok(nand_erase_opts(mtd, &opts));
> >>> +        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> +include/test/ut.h:309:27: note: expanded from macro 'ut_assertok'
> >>> +#define ut_assertok(cond)       ut_asserteq(0, cond)
> >>> +                                ^~~~~~~~~~~~~~~~~~~~
> >>> +include/test/ut.h:162:2: note: expanded from macro 'ut_asserteq'
> >>> +        __ret;                                                      =
    \
> >>> +        ^~~~~
> >>> +1 error generated.
> >>> +make[3]: *** [scripts/Makefile.build:257: test/dm/nand.o] Error 1
> >>> +make[2]: *** [scripts/Makefile.build:397: test/dm] Error 2
> >>> +make[1]: *** [Makefile:1858: test] Error 2
> >>> +make: *** [Makefile:177: sub-make] Error 2
> >>
> >> ...well that's a new one. Wonder why it doesn't complain about all the=
 other uses of
> >> ut_assertok (which, invariably, discard the value in the same way).
> >
> > That's what I thought as well. It seems to be related to CLANG. Could i=
t be the
> > 'unused-value' flag? I can't figure out why it causes the problem at
> > that point,
> > given that the 'ut_assertok()' is called even before the one that
> > generates the error.
>
> It was because of the comma instead of a semicolon on the previous line.
Great!

5022c5112
< + opts.length =3D mtd->erasesize * 2,
---
> + opts.length =3D mtd->erasesize * 2;

Just before the ut_assertok() pointed by the test failure message.

And I confirm to you that the CI pipeline has now finished successfully.
Many thanks!

Regards
Dario
>
> --Sean



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
