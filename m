Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED68EC47DB7
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFA287BC1;
	Thu, 18 Jan 2024 20:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IS8UI1DL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0E087BB6; Thu, 18 Jan 2024 20:50:44 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB66387BC9
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 20:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so35165b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705607438; x=1706212238; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vM0vll8rudwhSGCJO3CAcd2/8yrjg8ogL4IX+YMuoQA=;
 b=IS8UI1DLi5jZWzPkl6Mid2FJXew3vKtAVPyKNul5bzW5SK6FtPpJu3KDB1ibvIi3EM
 H53/lsryonNiN8WQ0LxFOesdwtaY9P56Wje9+MhP9mJHP1a0AWlCnNXLt4T42dqQxsIY
 eOF4KRGZJn5qAIkTzyN/8koe2enM2UrLYxApUE1UPZneQkGSbnSBRa4Bp/EGgajVCktm
 mRDnGb28fJfAZX6BB9HkR8zYpPgNngsM7Rx18OUpUhS7hztXC1wlXy5+/3Sb85r7mbCj
 EP+9OCyVSZt/SlAGVwoHIbGWdkanIVu8bKMZ9PUs00uMdXNJaFnYBVibNwETbnrvLzBf
 mlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705607438; x=1706212238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vM0vll8rudwhSGCJO3CAcd2/8yrjg8ogL4IX+YMuoQA=;
 b=SdH3JXE1epMNCZ4dFVILlN5W9d8JnS2uKQbD+nlPDJK6zEdoXX8d3hn0/wpktUgyYQ
 axLewnGztUYErz8xQVSRyae5ew5WPNbNXrDM1P3rgw34pjimq4rxL+juT+/jGFOqNKKd
 UtFCIyEFW/ufwnxurkGqStbtnknjAtzLN+IdmzwdMTF8k+1alE7OYCKSDu8HYH4A8qtm
 q+/GQx65+4cs3qvFN2YbxSDyFfwqu6PQVmMai3Mk/j6ApOKDAtlbC1lSL6ppiq/Li3iw
 hqnfDMrRhjWgLYwwfuGfISZsTUgPBtsvK4BtK7EqwRdgPoTEMvRI7jJvoPdCSGFv21xM
 HeBw==
X-Gm-Message-State: AOJu0YzQ2LZNGHwss4JCcnUpTp87PxPuBHnv3sXkBt0F+5d+PPOuycTl
 WVSARuFA8PdLry8KqQMmZOMiAq9pIMEIuwgl8ivR5Dxr1ydB4C7P8GtzNaOcEw0yjFjFaHKPzWZ
 pZMwchKvFza6EhTbk8gGxTBCVxQM=
X-Google-Smtp-Source: AGHT+IG2DAX7RR/5vBabrHWs0n/0AP8+6GitkW5bDJoo+5+J6zgmrs/DJjDlw8mD5q0e94ENf+WPNEd+QBx8o1MPzvM=
X-Received: by 2002:a05:6871:aa16:b0:210:a956:8cd8 with SMTP id
 wq22-20020a056871aa1600b00210a9568cd8mr1526859oab.112.1705607438298; Thu, 18
 Jan 2024 11:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-13-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-13-b6dd9704219e@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Thu, 18 Jan 2024 23:50:28 +0200
Message-ID: <CAGi-RULzM4DiQRCJaM2uOfrgsjwoZekBMHC7b_xwQ1L-kKmm8A@mail.gmail.com>
Subject: Re: [PATCH v2 13/32] board: dragonboard410c: import board code from
 mach-snapdragon
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 6:04=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Some of the db410c board support code was written to be generic and
> placed in mach-snapdragon. However, as the db410c is the only board
> using this, move the code out of mach-snapdragon. This makes is more
> obvious what code is relevant for which targets and helps tidy things up
> a little more.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile                  |  2 -
>  arch/arm/mach-snapdragon/include/mach/dram.h       | 12 -----
>  arch/arm/mach-snapdragon/misc.c                    | 55 ----------------=
------
>  board/qualcomm/dragonboard410c/Makefile            |  3 +-
>  board/qualcomm/dragonboard410c/dragonboard410c.c   |  4 +-
>  .../qualcomm/dragonboard410c/misc.c                | 51 ++++++++++++++++=
+++-
>  .../mach =3D> board/qualcomm/dragonboard410c}/misc.h |  1 +
>  7 files changed, 54 insertions(+), 74 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon=
/Makefile
> index 3a3a297c1768..d02432df8b04 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -6,6 +6,4 @@ obj-$(CONFIG_SDM845) +=3D sysmap-sdm845.o
>  obj-$(CONFIG_SDM845) +=3D init_sdm845.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD820C) +=3D sysmap-apq8096.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD410C) +=3D sysmap-apq8016.o
> -obj-y +=3D misc.o
> -obj-y +=3D dram.o
>  obj-$(CONFIG_TARGET_QCS404EVB) +=3D sysmap-qcs404.o
> diff --git a/arch/arm/mach-snapdragon/include/mach/dram.h b/arch/arm/mach=
-snapdragon/include/mach/dram.h
> deleted file mode 100644
> index 0a9eedda414c..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/dram.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Snapdragon DRAM
> - * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#ifndef DRAM_H
> -#define DRAM_H
> -
> -int msm_fixup_memory(void *blob);
> -
> -#endif
> diff --git a/arch/arm/mach-snapdragon/misc.c b/arch/arm/mach-snapdragon/m=
isc.c
> deleted file mode 100644
> index 7d452f4529b7..000000000000
> --- a/arch/arm/mach-snapdragon/misc.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Miscellaneous Snapdragon functionality
> - *
> - * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
> - *
> - */
> -
> -#include <common.h>
> -#include <mmc.h>
> -#include <asm/arch/misc.h>
> -#include <asm/unaligned.h>
> -
> -/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
> -#define UNSTUFF_BITS(resp, start, size) \
> -       ({ \
> -               const int __size =3D size; \
> -               const u32 __mask =3D (__size < 32 ? 1 << __size : 0) - 1;=
 \
> -               const int __off =3D 3 - ((start) / 32); \
> -               const int __shft =3D (start) & 31; \
> -               u32 __res; \
> -                                       \
> -               __res =3D resp[__off] >> __shft; \
> -               if (__size + __shft > 32) \
> -                       __res |=3D resp[__off - 1] << ((32 - __shft) % 32=
); \
> -               __res & __mask; \
> -       })
> -
> -u32 msm_board_serial(void)
> -{
> -       struct mmc *mmc_dev;
> -
> -       mmc_dev =3D find_mmc_device(0);
> -       if (!mmc_dev)
> -               return 0;
> -
> -       if (mmc_init(mmc_dev))
> -               return 0;
> -
> -       return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
> -}
> -
> -void msm_generate_mac_addr(u8 *mac)
> -{
> -       /* use locally adminstrated pool */
> -       mac[0] =3D 0x02;
> -       mac[1] =3D 0x00;
> -
> -       /*
> -        * Put the 32-bit serial number in the last 32-bit of the MAC add=
ress.
> -        * Use big endian order so it is consistent with the serial numbe=
r
> -        * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:3=
4:ab:cd
> -        */
> -       put_unaligned_be32(msm_board_serial(), &mac[2]);
> -}
> diff --git a/board/qualcomm/dragonboard410c/Makefile b/board/qualcomm/dra=
gonboard410c/Makefile
> index 1b99c8b0efef..a3ae1a5f9136 100644
> --- a/board/qualcomm/dragonboard410c/Makefile
> +++ b/board/qualcomm/dragonboard410c/Makefile
> @@ -2,4 +2,5 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
> -obj-y  :=3D dragonboard410c.o
> +obj-y +=3D dragonboard410c.o
> +obj-y +=3D misc.o
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qua=
lcomm/dragonboard410c/dragonboard410c.c
> index 1adac07569ae..eea603a4148d 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -18,10 +18,10 @@
>  #include <asm/global_data.h>
>  #include <asm/gpio.h>
>  #include <fdt_support.h>
> -#include <asm/arch/dram.h>
> -#include <asm/arch/misc.h>
>  #include <linux/delay.h>
>
> +#include "misc.h"
> +
>  DECLARE_GLOBAL_DATA_PTR;
>
>  #define USB_HUB_RESET_GPIO 2
> diff --git a/arch/arm/mach-snapdragon/dram.c b/board/qualcomm/dragonboard=
410c/misc.c
> similarity index 64%
> rename from arch/arm/mach-snapdragon/dram.c
> rename to board/qualcomm/dragonboard410c/misc.c
> index 499dfdf0da6e..27d51ef78914 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/board/qualcomm/dragonboard410c/misc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Onboard memory detection for Snapdragon boards
> + * Miscellaneous Snapdragon functionality
>   *
>   * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
>   *
> @@ -9,10 +9,56 @@
>  #include <common.h>
>  #include <dm.h>
>  #include <log.h>
> +#include <mmc.h>
>  #include <part.h>
>  #include <smem.h>
>  #include <fdt_support.h>
> -#include <asm/arch/dram.h>
> +#include <asm/unaligned.h>
> +
> +#include "misc.h"
> +
> +/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
> +#define UNSTUFF_BITS(resp, start, size) \
> +       ({ \
> +               const int __size =3D size; \
> +               const u32 __mask =3D (__size < 32 ? 1 << __size : 0) - 1;=
 \
> +               const int __off =3D 3 - ((start) / 32); \
> +               const int __shft =3D (start) & 31; \
> +               u32 __res; \
> +                                       \
> +               __res =3D resp[__off] >> __shft; \
> +               if (__size + __shft > 32) \
> +                       __res |=3D resp[__off - 1] << ((32 - __shft) % 32=
); \
> +               __res & __mask; \
> +       })
> +
> +u32 msm_board_serial(void)
> +{
> +       struct mmc *mmc_dev;
> +
> +       mmc_dev =3D find_mmc_device(0);
> +       if (!mmc_dev)
> +               return 0;
> +
> +       if (mmc_init(mmc_dev))
> +               return 0;
> +
> +       return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
> +}
> +
> +void msm_generate_mac_addr(u8 *mac)
> +{
> +       /* use locally adminstrated pool */
> +       mac[0] =3D 0x02;
> +       mac[1] =3D 0x00;
> +
> +       /*
> +        * Put the 32-bit serial number in the last 32-bit of the MAC add=
ress.
> +        * Use big endian order so it is consistent with the serial numbe=
r
> +        * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:3=
4:ab:cd
> +        */
> +       put_unaligned_be32(msm_board_serial(), &mac[2]);
> +}
>
>  #define SMEM_USABLE_RAM_PARTITION_TABLE 402
>  #define RAM_PART_NAME_LENGTH            16
> @@ -97,3 +143,4 @@ int msm_fixup_memory(void *blob)
>
>         return 0;
>  }
> +
> diff --git a/arch/arm/mach-snapdragon/include/mach/misc.h b/board/qualcom=
m/dragonboard410c/misc.h
> similarity index 87%
> rename from arch/arm/mach-snapdragon/include/mach/misc.h
> rename to board/qualcomm/dragonboard410c/misc.h
> index c60e3e472470..fe44caf51b18 100644
> --- a/arch/arm/mach-snapdragon/include/mach/misc.h
> +++ b/board/qualcomm/dragonboard410c/misc.h
> @@ -9,5 +9,6 @@
>
>  u32 msm_board_serial(void);
>  void msm_generate_mac_addr(u8 *mac);
> +int msm_fixup_memory(void *blob);
>
>  #endif
>
> --
> 2.42.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
