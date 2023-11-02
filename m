Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDA8C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84AF877BD;
	Thu,  2 Nov 2023 15:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AFfEvDZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C12877C5; Thu,  2 Nov 2023 15:09:27 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CA6877BD
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9ac3b4f42cso1879367276.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698934150; x=1699538950;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXTM3MwxJiSyvKtEp+vDER5GbPUkujWnyRnavONN0k0=;
 b=AFfEvDZfKD4JPK6WFdBanLBvFY+F68Oi6jDCDdkAWDKQeDboyZq65lKkYCFRoTVf59
 xkDpW8/SfoA05cLlTSwKGzYN8T75Ep34rrYyiMmSAwlTvn/j4/mjdcdjfgH0VNjr2JhY
 96nyMphdYyXf/5BqdbS8WsC8ivUoduYH7gmrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698934150; x=1699538950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXTM3MwxJiSyvKtEp+vDER5GbPUkujWnyRnavONN0k0=;
 b=L+vA6VMcY1XJPDgzDN7vCjF971ZB94ix90NjWxObF7ffpfD/eZA8KYVCYgvQ9K/Omn
 iO3qTsZmXJeahgLy3rA4fhAtoz1zBchAeBc54Kt/0Iz+1zRw5bSeFvJfAG1rSkplkLWv
 PqyoSekbjyiY7EM2nT2BBhFhu0NYTrhkEL9eshN2WzBBghzoHMKCVnmSeD8VfXMLMkbn
 q3B4YupvRp2hGFdhpmuYit6gJhY5hRVBVAzNTCfn3Tlh5BativybWodOtJmmuBjcreOC
 fsDh8/NF58cnbugtozCMr6Ujl3yjflJnxeH6r3ktUsDL+MCeCb8+7bDzkSci/1Bqr5Oo
 JaYA==
X-Gm-Message-State: AOJu0YxkQoOiXimg1wYfUlgUyqD2SBpfLu3yhF9py1Gu3CBAcpP++Lwf
 ow+OhHN077LV08gVCnUfFu/iBrwmySAoyEBjBtI40w==
X-Google-Smtp-Source: AGHT+IFIaBHaZs1dCAmZb56ecUJK9HuM37kPurTcyyXt3Ou0EI88B6adbLUFGBtZVdgCbZ2YDJrP9KNv2pVsnK/hJE4=
X-Received: by 2002:a5b:884:0:b0:d9c:f811:eb6b with SMTP id
 e4-20020a5b0884000000b00d9cf811eb6bmr6788593ybq.0.1698934150338; Thu, 02 Nov
 2023 07:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <CABGWkvq_Yw2Q7ZX9UeaO6a0Uf6V+-1Uh6BNOga6neq_tUVQNFA@mail.gmail.com>
 <b0f0c63e-e8b4-ba15-19c0-aca39a8f621b@gmail.com>
In-Reply-To: <b0f0c63e-e8b4-ba15-19c0-aca39a8f621b@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 15:08:59 +0100
Message-ID: <CABGWkvquxkPBVKeE2TMCOFcwfDGhh_ynH5gnU7FXO7x=TWqPjA@mail.gmail.com>
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

On Thu, Nov 2, 2023 at 3:06=E2=80=AFPM Sean Anderson <seanga2@gmail.com> wr=
ote:
>
> On 11/2/23 10:01, Dario Binacchi wrote:
> > Sean, All,
> >
> > On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.co=
m> wrote:
> >>
> >> This series tests raw nand flash in sandbox and fixes various bugs dis=
covered in
> >> the process. I've tried to do things in a contemporary manner, avoidin=
g the
> >> (numerous) variations present on only a few boards. The test is pretty=
 minimal.
> >> Future work could test the rest of the nand API as well as the MTD API=
.
> >>
> >> Bloat at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> >> everything grows by a few bytes due to nand_page_size. A few boards gr=
ow more,
> >> mostly those using nand_spl_loaders.c.
> >>
> >> [1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922de6c2
> >>
> >>
> >> Sean Anderson (15):
> >>    spl: nand: Fix NULL-pointer dereference
> >>    nand: Don't dereference NULL manufacturer_desc
> >>    nand: Calculate SYS_NAND_PAGE_COUNT automatically
> >>    nand: spl_loaders: Only read enough pages to load the image
> >>    spl: legacy: Honor bl_len when decompressing
> >>    spl: nand: Set bl_len to page size
> >>    cmd: nand: Map memory before accessing it
> >>    spl: nand: Map memory before accessing it
> >>    mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
> >>    mtd: Add some fallbacks for add/del_mtd_device
> >>    nand: Add function to unregister NAND devices
> >>    nand: Allow reinitialization
> >>    arch: sandbox: Add function to create temporary files
> >>    nand: Add sandbox driver
> >>    test: spl: Add a test for NAND
> >>
> >>   README                                        |   9 +-
> >>   arch/sandbox/cpu/os.c                         |  17 +
> >>   arch/sandbox/dts/test.dts                     |  67 ++
> >>   arch/sandbox/include/asm/spl.h                |   1 +
> >>   cmd/nand.c                                    |  26 +-
> >>   common/spl/Kconfig                            |   2 +-
> >>   common/spl/spl_legacy.c                       |  18 +-
> >>   common/spl/spl_nand.c                         |  22 +-
> >>   configs/am335x_baltos_defconfig               |   3 +-
> >>   configs/am335x_evm_defconfig                  |   3 +-
> >>   configs/am335x_evm_spiboot_defconfig          |   2 +-
> >>   configs/am335x_guardian_defconfig             |   1 -
> >>   configs/am335x_hs_evm_defconfig               |   2 +-
> >>   configs/am335x_hs_evm_uart_defconfig          |   2 +-
> >>   configs/am335x_igep003x_defconfig             |   3 +-
> >>   configs/am335x_sl50_defconfig                 |   2 +-
> >>   configs/am3517_evm_defconfig                  |   3 +-
> >>   configs/am43xx_evm_defconfig                  |   3 +-
> >>   configs/am43xx_evm_rtconly_defconfig          |   3 +-
> >>   configs/am43xx_evm_usbhost_boot_defconfig     |   3 +-
> >>   configs/am43xx_hs_evm_defconfig               |   3 +-
> >>   configs/am62ax_evm_r5_defconfig               |   2 +-
> >>   configs/am65x_evm_a53_defconfig               |   2 +-
> >>   configs/axm_defconfig                         |   1 -
> >>   configs/chiliboard_defconfig                  |   1 -
> >>   configs/cm_t43_defconfig                      |   2 +-
> >>   configs/corvus_defconfig                      |   1 -
> >>   configs/da850evm_nand_defconfig               |   1 -
> >>   configs/devkit3250_defconfig                  |   1 -
> >>   configs/devkit8000_defconfig                  |   1 -
> >>   configs/dra7xx_evm_defconfig                  |   1 -
> >>   configs/draco_defconfig                       |   1 -
> >>   configs/etamin_defconfig                      |   1 -
> >>   .../gardena-smart-gateway-at91sam_defconfig   |   1 -
> >>   configs/igep00x0_defconfig                    |   3 +-
> >>   configs/imx6ulz_smm_m2_defconfig              |   2 +-
> >>   configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
> >>   configs/j7200_evm_a72_defconfig               |   2 +-
> >>   configs/j7200_evm_r5_defconfig                |   2 +-
> >>   configs/j721e_evm_a72_defconfig               |   2 +-
> >>   configs/j721e_evm_r5_defconfig                |   2 +-
> >>   configs/j721s2_evm_a72_defconfig              |   2 +-
> >>   configs/j721s2_evm_r5_defconfig               |   2 +-
> >>   configs/m53menlo_defconfig                    |   1 -
> >>   configs/omap35_logic_defconfig                |   3 +-
> >>   configs/omap35_logic_somlv_defconfig          |   3 +-
> >>   configs/omap3_beagle_defconfig                |   3 +-
> >>   configs/omap3_evm_defconfig                   |   3 +-
> >>   configs/omap3_logic_defconfig                 |   3 +-
> >>   configs/omap3_logic_somlv_defconfig           |   3 +-
> >>   configs/omapl138_lcdk_defconfig               |   1 -
> >>   configs/phycore-am335x-r2-regor_defconfig     |   3 +-
> >>   configs/phycore-am335x-r2-wega_defconfig      |   3 +-
> >>   configs/pxm2_defconfig                        |   1 -
> >>   configs/rastaban_defconfig                    |   1 -
> >>   configs/rut_defconfig                         |   1 -
> >>   configs/sama5d3_xplained_nandflash_defconfig  |   1 -
> >>   configs/sama5d3xek_nandflash_defconfig        |   1 -
> >>   configs/sama5d4_xplained_nandflash_defconfig  |   1 -
> >>   configs/sama5d4ek_nandflash_defconfig         |   1 -
> >>   configs/sandbox64_defconfig                   |  10 +-
> >>   configs/sandbox_defconfig                     |   9 +
> >>   configs/sandbox_noinst_defconfig              |  21 +-
> >>   configs/smartweb_defconfig                    |   1 -
> >>   configs/socfpga_secu1_defconfig               |   2 +-
> >>   configs/stm32746g-eval_spl_defconfig          |   2 +-
> >>   configs/stm32f746-disco_spl_defconfig         |   2 +-
> >>   configs/stm32f769-disco_spl_defconfig         |   2 +-
> >>   configs/stm32mp15_basic_defconfig             |   2 +-
> >>   configs/stm32mp15_dhcom_basic_defconfig       |   2 +-
> >>   configs/stm32mp15_dhcor_basic_defconfig       |   2 +-
> >>   configs/taurus_defconfig                      |   1 -
> >>   configs/thuban_defconfig                      |   1 -
> >>   drivers/mtd/Makefile                          |   2 +-
> >>   drivers/mtd/nand/raw/Kconfig                  |  27 +-
> >>   drivers/mtd/nand/raw/Makefile                 |   1 +
> >>   drivers/mtd/nand/raw/am335x_spl_bch.c         |   8 +-
> >>   drivers/mtd/nand/raw/atmel_nand.c             |  10 +-
> >>   drivers/mtd/nand/raw/denali_spl.c             |   5 +
> >>   drivers/mtd/nand/raw/fsl_ifc_spl.c            |   8 +
> >>   drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   5 +
> >>   drivers/mtd/nand/raw/mt7621_nand_spl.c        |   5 +
> >>   drivers/mtd/nand/raw/mxc_nand_spl.c           |  10 +-
> >>   drivers/mtd/nand/raw/mxs_nand_spl.c           |   5 +
> >>   drivers/mtd/nand/raw/nand.c                   |  66 +-
> >>   drivers/mtd/nand/raw/nand_base.c              |   7 +-
> >>   drivers/mtd/nand/raw/nand_spl_loaders.c       |   5 +-
> >>   drivers/mtd/nand/raw/nand_spl_simple.c        |  10 +-
> >>   drivers/mtd/nand/raw/omap_gpmc.c              |   3 +-
> >>   drivers/mtd/nand/raw/sand_nand.c              | 711 ++++++++++++++++=
++
> >>   drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
> >>   drivers/mtd/onenand/onenand_uboot.c           |   2 -
> >>   include/linux/mtd/mtd.h                       |  12 +
> >>   include/mtd/cfi_flash.h                       |   2 +-
> >>   include/nand.h                                |   3 +
> >>   include/os.h                                  |  13 +
> >>   include/system-constants.h                    |   3 +
> >>   test/dm/Makefile                              |   1 +
> >>   test/dm/nand.c                                | 106 +++
> >>   test/image/Kconfig                            |   9 +
> >>   test/image/Makefile                           |   1 +
> >>   test/image/spl_load_nand.c                    |  54 ++
> >>   102 files changed, 1269 insertions(+), 153 deletions(-)
> >>   create mode 100644 drivers/mtd/nand/raw/sand_nand.c
> >>   create mode 100644 test/dm/nand.c
> >>   create mode 100644 test/image/spl_load_nand.c
> >>
> >> --
> >> 2.37.1
> >>
> >
> > The CI pipeline fails:
> > https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/=
18409
> >
> > It seems like the problem is only for the clang tests (sandbox64 with
> > clang test.py and sandbox with clang test.py)
>
> I can't view that link. Can you post the error somewhere else?
>
> I saw a clang error [1] when running CI before sending this out, but I th=
ought I had fixed it.
>
> --Sean
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18355
>
>     sandbox:  +   sandbox
> +drivers/mtd/nand/raw/sand_nand.c:386:2: error: variable 'src' is used un=
initialized whenever switch default is taken [-Werror,-Wsometimes-uninitial=
ized]
> +        default:
> +        ^~~~~~~
> +drivers/mtd/nand/raw/sand_nand.c:395:14: note: uninitialized use occurs =
here
> +        memcpy(buf, src + chip->column, to_copy);
> +                    ^~~
> +drivers/mtd/nand/raw/sand_nand.c:362:6: error: variable 'src' is used un=
initialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitiali=
zed]
> +        if (!chip->selected)
> +            ^~~~~~~~~~~~~~~
> +drivers/mtd/nand/raw/sand_nand.c:362:2: note: remove the 'if' if its con=
dition is always false
> +        ^~~~~~~~~~~~~~~~~~~~
> +drivers/mtd/nand/raw/sand_nand.c:360:15: note: initialize the variable '=
src' to silence this warning
> +        const u8 *src;
> +                     ^
> +                      =3D NULL
> +2 errors generated.
> +make[5]: *** [scripts/Makefile.build:256: drivers/mtd/nand/raw/sand_nand=
.o] Error 1
> +make[4]: *** [scripts/Makefile.build:397: drivers/mtd/nand/raw] Error 2
> +make[3]: *** [scripts/Makefile.build:397: drivers/mtd/nand] Error 2
> +make[2]: *** [scripts/Makefile.build:397: drivers/mtd] Error 2
> +make[1]: *** [Makefile:1858: drivers] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
>
>

 [0KRunning with gitlab-runner 16.5.0 (853330f9) [0;m
 [0K  on kaka wgFtTy4z, system ID: s_7c66e37ef434 [0;m
section_start:1698925804:prepare_executor
 [0K [0K [36;1mPreparing the "docker" executor [0;m [0;m
 [0KUsing Docker executor with image
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
... [0;m
 [0KPulling docker image
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
... [0;m
 [0KUsing docker image
sha256:1744666558bd76db2a46ea8d0e55b253c7570f134aff9b7e8fc91e13d99bbecc
for docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
with digest trini/u-boot-gitlab-ci-runner@sha256:42925546cba6b1b0e819e91fb0=
269f0b700d72e4a2a5faf5d3102ec130fb859d
... [0;m
section_end:1698925807:prepare_executor
 [0Ksection_start:1698925807:prepare_script
 [0K [0K [36;1mPreparing environment [0;m [0;m
Running on runner-wgftty4z-project-568-concurrent-0 via kaka...
section_end:1698925808:prepare_script
 [0Ksection_start:1698925808:get_sources
 [0K [0K [36;1mGetting source from Git repository [0;m [0;m
 [32;1mFetching changes... [0;m
Reinitialized existing Git repository in
/builds/u-boot/custodians/u-boot-nand-flash/.git/
 [32;1mChecking out 94b91f7c as detached HEAD (ref is nand-next)... [0;m
Removing multiplexed_log.css
Removing test-log.html
Removing tools/buildman/__pycache__/
Removing tools/patman/__pycache__/
Removing tools/u_boot_pylib/__pycache__/

 [32;1mSkipping Git submodules setup [0;m
section_end:1698925811:get_sources
 [0Ksection_start:1698925811:step_script
 [0K [0K [36;1mExecuting "step_script" stage of the job script [0;m [0;m
 [0KUsing docker image
sha256:1744666558bd76db2a46ea8d0e55b253c7570f134aff9b7e8fc91e13d99bbecc
for docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
with digest trini/u-boot-gitlab-ci-runner@sha256:42925546cba6b1b0e819e91fb0=
269f0b700d72e4a2a5faf5d3102ec130fb859d
... [0;m
 [32;1m$ git config --global --add safe.directory "${CI_PROJECT_DIR}" [0;m
 [32;1m$ git clone --depth=3D1
https://source.denx.de/u-boot/u-boot-test-hooks
/tmp/uboot-test-hooks [0;m
Cloning into '/tmp/uboot-test-hooks'...
warning: redirecting to https://source.denx.de/u-boot/u-boot-test-hooks.git=
/
 [32;1m$ ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname` [0;m
 [32;1m$ ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname` [0;m
 [32;1m$ grub-mkimage --prefix=3D"" -o ~/grub_x86.efi -O i386-efi normal
 echo lsefimmap lsefi lsefisystab efinet tftp minicmd [0;m
 [32;1m$ grub-mkimage --prefix=3D"" -o ~/grub_x64.efi -O x86_64-efi
normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd [0;m
 [32;1m$ if [[ "${TEST_PY_BD}" =3D=3D "qemu-riscv32_spl" ]]; then wget -O
- https://github.com/riscv-software-src/opensbi/releases/download/v1.2/open=
sbi-1.2-rv-bin.tar.xz
| tar -C /tmp -xJ; export
OPENSBI=3D/tmp/opensbi-1.2-rv-bin/share/opensbi/ilp32/generic/firmware/fw_d=
ynamic.bin;
fi [0;m
 [32;1m$ if [[ "${TEST_PY_BD}" =3D=3D "qemu-riscv64_spl" ]] || [[
"${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then wget -O -
https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensb=
i-1.2-rv-bin.tar.xz
| tar -C /tmp -xJ; export
OPENSBI=3D/tmp/opensbi-1.2-rv-bin/share/opensbi/lp64/generic/firmware/fw_dy=
namic.bin;
fi [0;m
 [32;1m$ export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/${TEST_PY_BD} [0;m
 [32;1m$ echo BUILD_ENV ${BUILD_ENV} [0;m
BUILD_ENV
 [32;1m$ if [ -n "${BUILD_ENV}" ]; then export ${BUILD_ENV}; fi [0;m
 [32;1m$ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W
-e --board ${TEST_PY_BD} ${OVERRIDE} [0;m
Building current source for 1 boards (1 thread, 32 jobs per thread)

Starting build...


    0    0    0 /1       -1      (starting)

   sandbox:  +   sandbox64
+test/dm/nand.c:83:2: error: expression result unused [-Werror,-Wunused-val=
ue]
+        ut_assertok(nand_erase_opts(mtd, &opts));
+        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+include/test/ut.h:309:27: note: expanded from macro 'ut_assertok'
+#define ut_assertok(cond)       ut_asserteq(0, cond)
+                                ^~~~~~~~~~~~~~~~~~~~
+include/test/ut.h:162:2: note: expanded from macro 'ut_asserteq'
+        __ret;                                                          \
+        ^~~~~
+1 error generated.
+make[3]: *** [scripts/Makefile.build:257: test/dm/nand.o] Error 1
+make[2]: *** [scripts/Makefile.build:397: test/dm] Error 2
+make[1]: *** [Makefile:1858: test] Error 2
+make: *** [Makefile:177: sub-make] Error 2

    0    0    1 /1              sandbox64
Completed: 1 total built, 1 newly), duration 0:00:10, rate 0.10
section_end:1698925825:step_script
 [0Ksection_start:1698925825:after_script
 [0K [0K [36;1mRunning after_script [0;m [0;m
 [32;1mRunning after script... [0;m
 [32;1m$ cp -v /tmp/${TEST_PY_BD}/*.{html,css} . [0;m
cp: cannot stat '/tmp/sandbox64/*.html': No such file or directory
cp: cannot stat '/tmp/sandbox64/*.css': No such file or directory
section_end:1698925826:after_script
 [0K [0;33mWARNING: after_script failed, but job will continue
unaffected: exit code 1 [0;m
section_start:1698925826:upload_artifacts_on_failure
 [0K [0K [36;1mUploading artifacts for failed job [0;m [0;m
 [32;1mUploading artifacts... [0;m
 [0;33mWARNING: *.html: no matching files. Ensure that the artifact
path is relative to the working directory
(/builds/u-boot/custodians/u-boot-nand-flash) [0;m
 [0;33mWARNING: *.css: no matching files. Ensure that the artifact
path is relative to the working directory
(/builds/u-boot/custodians/u-boot-nand-flash) [0;m
 [31;1mERROR: No files to upload                          [0;m
section_end:1698925827:upload_artifacts_on_failure
 [0Ksection_start:1698925827:cleanup_file_variables
 [0K [0K [36;1mCleaning up project directory and file based variables [0;m =
[0;m
section_end:1698925827:cleanup_file_variables
 [0K [31;1mERROR: Job failed: exit code 1
 [0;m

Thanks and regards,
Dario

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
