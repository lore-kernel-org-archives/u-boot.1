Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5524C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE9487085;
	Thu,  2 Nov 2023 15:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cgIW2kns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCFB8701E; Thu,  2 Nov 2023 15:02:11 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8712486F7D
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da2e786743aso997107276.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698933722; x=1699538522;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8+/JUzLJwUnKBTeNjEykH7hoo4h4Dt3pPYgIX4TS1Y=;
 b=cgIW2knsaJ/ebX7O1zgudwGBJ9JApUl384ow8VJPQyz78euE5mHknX/UOZp1EVtrAn
 jgjqRL00bRr9mePK8+eMXtmrrli/hY3LA5ciqoKSJ1b61I1ELy1rBazqN1kRTA4A0ofQ
 y88iNj/fMgHqBQoh3/NlanRX/s78DRx5rfW8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698933722; x=1699538522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8+/JUzLJwUnKBTeNjEykH7hoo4h4Dt3pPYgIX4TS1Y=;
 b=gK5qDgLi7jtN+pCJxUIlszVCmJeY9mttXIVWDZ5QhHVdBAuqKl/iYnl6bQonxpwDSv
 gRi88E0o/6zSTWoUD1Bhpv5nGxe2mpOLidoo1QrS30ZTPuKmsyyQxe3G94JjypsM0XL1
 6lCDbaohWwRoaNhuMTBTGsnYR1hVv714xrO3WzLB21MbVStaYJZTznzr1kBqAvDcGAEB
 e9lmyhEp6/EXzIJsLMVzQG3ckOYxFKrTAYjuDp4yc7ncJj7uL/cxMmvELZKOifZQiwYF
 szQLmNS/X8XeCQbjSO9/NzX9/da8v8dRtexKbkngWrZLaOY9ywyQ7VOU2H9g9yWfLBZO
 oaPQ==
X-Gm-Message-State: AOJu0YyOmGwj9sbBzBOp/TbCWJafRg8B3j6b2Q++yPkzgTAijo4iUI3e
 Ol4kh0XXQZQfJzop5zdqPht711kQQyQu/B2mLki/MA==
X-Google-Smtp-Source: AGHT+IF95mLtIf+4ZgiUGRDlVN0QunQfFRmZqSRsBl4seaTvBEj4RI51Y0JMOgUtI10snIwKQZ21cd5M4ZB/MmLkqIE=
X-Received: by 2002:a25:d285:0:b0:d9a:52ee:6080 with SMTP id
 j127-20020a25d285000000b00d9a52ee6080mr17855007ybg.37.1698933722122; Thu, 02
 Nov 2023 07:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 15:01:51 +0100
Message-ID: <CABGWkvq_Yw2Q7ZX9UeaO6a0Uf6V+-1Uh6BNOga6neq_tUVQNFA@mail.gmail.com>
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

Sean, All,

On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> This series tests raw nand flash in sandbox and fixes various bugs discov=
ered in
> the process. I've tried to do things in a contemporary manner, avoiding t=
he
> (numerous) variations present on only a few boards. The test is pretty mi=
nimal.
> Future work could test the rest of the nand API as well as the MTD API.
>
> Bloat at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> everything grows by a few bytes due to nand_page_size. A few boards grow =
more,
> mostly those using nand_spl_loaders.c.
>
> [1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922de6c2
>
>
> Sean Anderson (15):
>   spl: nand: Fix NULL-pointer dereference
>   nand: Don't dereference NULL manufacturer_desc
>   nand: Calculate SYS_NAND_PAGE_COUNT automatically
>   nand: spl_loaders: Only read enough pages to load the image
>   spl: legacy: Honor bl_len when decompressing
>   spl: nand: Set bl_len to page size
>   cmd: nand: Map memory before accessing it
>   spl: nand: Map memory before accessing it
>   mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
>   mtd: Add some fallbacks for add/del_mtd_device
>   nand: Add function to unregister NAND devices
>   nand: Allow reinitialization
>   arch: sandbox: Add function to create temporary files
>   nand: Add sandbox driver
>   test: spl: Add a test for NAND
>
>  README                                        |   9 +-
>  arch/sandbox/cpu/os.c                         |  17 +
>  arch/sandbox/dts/test.dts                     |  67 ++
>  arch/sandbox/include/asm/spl.h                |   1 +
>  cmd/nand.c                                    |  26 +-
>  common/spl/Kconfig                            |   2 +-
>  common/spl/spl_legacy.c                       |  18 +-
>  common/spl/spl_nand.c                         |  22 +-
>  configs/am335x_baltos_defconfig               |   3 +-
>  configs/am335x_evm_defconfig                  |   3 +-
>  configs/am335x_evm_spiboot_defconfig          |   2 +-
>  configs/am335x_guardian_defconfig             |   1 -
>  configs/am335x_hs_evm_defconfig               |   2 +-
>  configs/am335x_hs_evm_uart_defconfig          |   2 +-
>  configs/am335x_igep003x_defconfig             |   3 +-
>  configs/am335x_sl50_defconfig                 |   2 +-
>  configs/am3517_evm_defconfig                  |   3 +-
>  configs/am43xx_evm_defconfig                  |   3 +-
>  configs/am43xx_evm_rtconly_defconfig          |   3 +-
>  configs/am43xx_evm_usbhost_boot_defconfig     |   3 +-
>  configs/am43xx_hs_evm_defconfig               |   3 +-
>  configs/am62ax_evm_r5_defconfig               |   2 +-
>  configs/am65x_evm_a53_defconfig               |   2 +-
>  configs/axm_defconfig                         |   1 -
>  configs/chiliboard_defconfig                  |   1 -
>  configs/cm_t43_defconfig                      |   2 +-
>  configs/corvus_defconfig                      |   1 -
>  configs/da850evm_nand_defconfig               |   1 -
>  configs/devkit3250_defconfig                  |   1 -
>  configs/devkit8000_defconfig                  |   1 -
>  configs/dra7xx_evm_defconfig                  |   1 -
>  configs/draco_defconfig                       |   1 -
>  configs/etamin_defconfig                      |   1 -
>  .../gardena-smart-gateway-at91sam_defconfig   |   1 -
>  configs/igep00x0_defconfig                    |   3 +-
>  configs/imx6ulz_smm_m2_defconfig              |   2 +-
>  configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
>  configs/j7200_evm_a72_defconfig               |   2 +-
>  configs/j7200_evm_r5_defconfig                |   2 +-
>  configs/j721e_evm_a72_defconfig               |   2 +-
>  configs/j721e_evm_r5_defconfig                |   2 +-
>  configs/j721s2_evm_a72_defconfig              |   2 +-
>  configs/j721s2_evm_r5_defconfig               |   2 +-
>  configs/m53menlo_defconfig                    |   1 -
>  configs/omap35_logic_defconfig                |   3 +-
>  configs/omap35_logic_somlv_defconfig          |   3 +-
>  configs/omap3_beagle_defconfig                |   3 +-
>  configs/omap3_evm_defconfig                   |   3 +-
>  configs/omap3_logic_defconfig                 |   3 +-
>  configs/omap3_logic_somlv_defconfig           |   3 +-
>  configs/omapl138_lcdk_defconfig               |   1 -
>  configs/phycore-am335x-r2-regor_defconfig     |   3 +-
>  configs/phycore-am335x-r2-wega_defconfig      |   3 +-
>  configs/pxm2_defconfig                        |   1 -
>  configs/rastaban_defconfig                    |   1 -
>  configs/rut_defconfig                         |   1 -
>  configs/sama5d3_xplained_nandflash_defconfig  |   1 -
>  configs/sama5d3xek_nandflash_defconfig        |   1 -
>  configs/sama5d4_xplained_nandflash_defconfig  |   1 -
>  configs/sama5d4ek_nandflash_defconfig         |   1 -
>  configs/sandbox64_defconfig                   |  10 +-
>  configs/sandbox_defconfig                     |   9 +
>  configs/sandbox_noinst_defconfig              |  21 +-
>  configs/smartweb_defconfig                    |   1 -
>  configs/socfpga_secu1_defconfig               |   2 +-
>  configs/stm32746g-eval_spl_defconfig          |   2 +-
>  configs/stm32f746-disco_spl_defconfig         |   2 +-
>  configs/stm32f769-disco_spl_defconfig         |   2 +-
>  configs/stm32mp15_basic_defconfig             |   2 +-
>  configs/stm32mp15_dhcom_basic_defconfig       |   2 +-
>  configs/stm32mp15_dhcor_basic_defconfig       |   2 +-
>  configs/taurus_defconfig                      |   1 -
>  configs/thuban_defconfig                      |   1 -
>  drivers/mtd/Makefile                          |   2 +-
>  drivers/mtd/nand/raw/Kconfig                  |  27 +-
>  drivers/mtd/nand/raw/Makefile                 |   1 +
>  drivers/mtd/nand/raw/am335x_spl_bch.c         |   8 +-
>  drivers/mtd/nand/raw/atmel_nand.c             |  10 +-
>  drivers/mtd/nand/raw/denali_spl.c             |   5 +
>  drivers/mtd/nand/raw/fsl_ifc_spl.c            |   8 +
>  drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   5 +
>  drivers/mtd/nand/raw/mt7621_nand_spl.c        |   5 +
>  drivers/mtd/nand/raw/mxc_nand_spl.c           |  10 +-
>  drivers/mtd/nand/raw/mxs_nand_spl.c           |   5 +
>  drivers/mtd/nand/raw/nand.c                   |  66 +-
>  drivers/mtd/nand/raw/nand_base.c              |   7 +-
>  drivers/mtd/nand/raw/nand_spl_loaders.c       |   5 +-
>  drivers/mtd/nand/raw/nand_spl_simple.c        |  10 +-
>  drivers/mtd/nand/raw/omap_gpmc.c              |   3 +-
>  drivers/mtd/nand/raw/sand_nand.c              | 711 ++++++++++++++++++
>  drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
>  drivers/mtd/onenand/onenand_uboot.c           |   2 -
>  include/linux/mtd/mtd.h                       |  12 +
>  include/mtd/cfi_flash.h                       |   2 +-
>  include/nand.h                                |   3 +
>  include/os.h                                  |  13 +
>  include/system-constants.h                    |   3 +
>  test/dm/Makefile                              |   1 +
>  test/dm/nand.c                                | 106 +++
>  test/image/Kconfig                            |   9 +
>  test/image/Makefile                           |   1 +
>  test/image/spl_load_nand.c                    |  54 ++
>  102 files changed, 1269 insertions(+), 153 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/sand_nand.c
>  create mode 100644 test/dm/nand.c
>  create mode 100644 test/image/spl_load_nand.c
>
> --
> 2.37.1
>

The CI pipeline fails:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/1840=
9

It seems like the problem is only for the clang tests (sandbox64 with
clang test.py and sandbox with clang test.py)

Regards,
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
