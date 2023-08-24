Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F98C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 10:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEA18658A;
	Thu, 24 Aug 2023 12:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DNBkkng9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508018658E; Thu, 24 Aug 2023 12:44:32 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F0D8653C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d74a012e613so1053557276.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692873867; x=1693478667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e7bXwg52YJwZ3ZHNOcp1qA5ZyCWQcgZcPSmbo1ZWTYk=;
 b=DNBkkng91crX9C2lK43AJ23g2MHIqC1d1DiiVrBZ5MswI9VUJbUgD6AcBuwQiPxFoX
 2oFeBSUwgB2r36LzX9HiMFIxxbqlxTqvihPmQMF/0ei1ZF2ATPK3xK0EgmQqTyJ9fOis
 lVKZWdwbiekqaPW6oW/6DxEmfHUb/zGLAA482YkQzJoqT6zEtFMigmSZfsmwkkW5QJNz
 sQgBMY6qDRQOocO93qRNqq+g98hGafOb0EoKXDfzjdw5Zq7N6V0JUGzpZQJuDhGHTcVC
 73QS/6aqJ96REcJQQy8HENZfqO9khbmrBThyWMpbzjrYyK7sMCIb5O1emflEH0lyV5+Z
 5bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692873867; x=1693478667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7bXwg52YJwZ3ZHNOcp1qA5ZyCWQcgZcPSmbo1ZWTYk=;
 b=ITDv9ZxXHHv67CGXXQ+56Nuwb9h1YNpT0ebidniXxbFTkSEsPiXGc6QkUUochNfDOr
 01jraFZ1TR6FxyRGnxgJHJd+10+AT72HBLWdPsZVC74DQUKx37nrNuu+CZklbEJwwYbf
 QPWeTDjcN0Ksgd1Z2Yv/Pfl0ZilLXe7PIMXdJhraHZRk+ofHAb2noiAIzt2TwosRxwK8
 KZDY0RMdB/riwjYipWbnxhBiOpRReHFwNkw8vc3E/8BmVQ0sOhdWZY8ymqn/jyZdbTH0
 KAmSAsmK6Dd8E1fpp1Jx5wtBq0pHbc4DXUzqB4qYe4XM0V55zrvUBpwlpgCUPavxNtVJ
 3v9g==
X-Gm-Message-State: AOJu0YyegRJqRCy9+OUnWkwCBQQs75L/cITtGcCIVaLIkiVR9XPYn9yF
 lN/p3uFebbdeqFvlxRgwJJVTUPAVIPOWucHBl+OcL1bzu3MWkzS01NQ=
X-Google-Smtp-Source: AGHT+IFelF+bheAr8jVWDx95ffyKrvDB0nE0rQ9Spc29/te2J4nOSBvRq923YTCYFt7zZyPqmhxyurssgt6tXAZfSpo=
X-Received: by 2002:a05:6102:124c:b0:44d:506c:b9c6 with SMTP id
 p12-20020a056102124c00b0044d506cb9c6mr4463667vsg.2.1692873847321; Thu, 24 Aug
 2023 03:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 24 Aug 2023 16:13:56 +0530
Message-ID: <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, rfried.dev@gmail.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, trini@konsulko.com, dsankouski@gmail.com, 
 stephan@gerhold.net, vinod.koul@linaro.org, nicolas.dechesne@linaro.org, 
 mworsfold@impinj.com, daniel.thompson@linaro.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,

On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add support for 96Boards Dragonboard 845C aka Robotics RB3 development
> > platform. This board complies with 96Boards Open Platform Specifications.
> >
> > Features:
> > - Qualcomm Snapdragon SDA845 SoC
> > - 4GiB RAM
> > - 64GiB UFS drive
> >
> > U-boot is chain loaded by ABL in 64-bit mode as part of boot.img.
> > For detailed build and boot instructions, refer to
> > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> >  board/qualcomm/dragonboard845c/db845c.its     |  63 +++++++++++
> >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> >  configs/dragonboard845c_defconfig             |  28 +++++
> >  doc/board/qualcomm/sdm845.rst                 | 100 +++++++++++++++---
> >  include/configs/dragonboard845c.h             |  28 +++++
> >  11 files changed, 337 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
> >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> >  create mode 100644 board/qualcomm/dragonboard845c/dragonboard845c.c
> >  create mode 100644 configs/dragonboard845c_defconfig
> >  create mode 100644 include/configs/dragonboard845c.h
> >
> [..]
>
> > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> > index b6642c9579..8ef4749287 100644
> > --- a/doc/board/qualcomm/sdm845.rst
> > +++ b/doc/board/qualcomm/sdm845.rst
> > @@ -35,9 +35,25 @@ Pack android boot image
> >  ^^^^^^^^^^^^^^^^^^^^^^^
> >  We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> >  and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> > -with appended dtb, so let's mimic linux to satisfy stock bootloader:
> > +with appended dtb, so let's mimic linux to satisfy stock bootloader.
> >
>
> [..]
>
> > +The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> > +the Qualcomm SDM845 SoC.
> > +
> > +Steps:
> > +
> > +- Build u-boot::
> > +
> > +       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > +       $ make dragonboard845c_defconfig
> > +       $ make
> > +
> > +- Create dummy dtb::
> > +
> > +       workdir=/tmp/prepare_payload
> > +       mkdir -p "$workdir"
> > +       mock_dtb="$workdir"/payload_mock.dtb
> > +
> > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > +       /dts-v1/;
> > +       / {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +
> > +               memory@80000000 {
> > +                       device_type = "memory";
> > +                       /* We expect the bootloader to fill in the size */
> > +                       reg = <0 0x80000000 0 0>;
> > +               };
> > +
> > +               chosen { };
> > +       };
> > +       EOF
> > +
> > +- gzip u-boot::
> > +
> > +       gzip u-boot.bin
> > +
> > +- Append dtb to gzipped u-boot::
> > +
> > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > +
> > +- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
> > +  directory. It expects a folder as ``db845c_imgs/`` in the main directory
> > +  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
> > +  for full path to images::
> > +
> > +       mkimage -f db845c.its db845c.itb
> > +
> > +- Now we've got everything to build android boot image::
> > +
> > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> > +       --output boot.img --pagesize 4096 --base 0x80000000
> > +
> > +- Flash boot.img using db845c fastboot method.
>
> What command should be used here? I can run 'fastboot devices' but am
> not sure what command to use to flash U-Boot.
>

At the time of writing this doc, I thought it was understood how to
flash boot.img on db845c. But I will make that more explicit. Since
u-boot has to be chain loaded by ABL, the command to flash boot.img
(containing u-boot) is as follows:

sudo fastboot flash boot boot.img

> Also, is it possible to flash U-Boot as a first-stage bootloader?
>

That's not possible currently due to Qcom proprietary bootloader being
used. But there were plans to replace atleast ABL with u-boot (See
slide 9 from this Linaro connect Qcom keynote [1]). I hope that will
materialize soon.

[1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJyA

-Sumit

> > +
> > +More information can be found on the `DragonBoard 845c page`_.
> >
> >  .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> > +.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> > diff --git a/include/configs/dragonboard845c.h b/include/configs/dragonboard845c.h
> > new file mode 100644
> > index 0000000000..108dde199b
> > --- /dev/null
> > +++ b/include/configs/dragonboard845c.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Configuration file for Dragonboard 845c, based on Qualcomm SDA845 chip
> > + *
> > + * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#ifndef __CONFIGS_SDM845_H
> > +#define __CONFIGS_SDM845_H
> > +
> > +#include <linux/sizes.h>
> > +#include <asm/arch/sysmap-sdm845.h>
> > +
> > +#define CONFIG_SYS_BAUDRATE_TABLE      { 115200, 230400, 460800, 921600 }
> > +
> > +#define CONFIG_EXTRA_ENV_SETTINGS \
> > +       "bootm_size=0x5000000\0"        \
> > +       "bootm_low=0x80000000\0"        \
> > +       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> > +
> > +/* Size of malloc() pool */
> > +#define CONFIG_SYS_BOOTM_LEN   SZ_64M
> > +
> > +/* Monitor Command Prompt */
> > +#define CONFIG_SYS_CBSIZE      512
> > +#define CONFIG_SYS_MAXARGS     64
> > +
> > +#endif
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
