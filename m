Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010C4C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F6A83D6C;
	Mon,  5 Jan 2026 16:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="jdYx6bCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BE483DE4; Mon,  5 Jan 2026 16:40:51 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F51C83CBD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6455a60c11fso11883d50.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1767627642; x=1768232442;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6pfEnqP29fAWnCddutSMN3ipY0MJ6U1v49jzLWZtX8=;
 b=jdYx6bCF32RQ0SkIXj3e65vW9qaag9MlHVqV2GDSF7fORuff+ocmhe70AcYfvKromK
 KpouoQcPAbilFs1FjwA1IHd4E4xp7bOiQOLwOzpQxjCv2DsSzMnLQJk83jCpk4AEa6P1
 sVWV4oPsfBKrpKJgLkR4hrrzEdB9gX0dkw7AZ+nub9b8Co9iCPHEnAskwtareeq6UvVR
 rRA2pEZptCwoSgQhQI2tQ9dElVi5bkm9gDxR/6ne6UYXRNeitQHiG4wnXtnRNP+RZH5F
 aWdBoykeHQaMASdACj4/DKO01MhMxx+H2VLNZeALKubuDKLe2xgyFSfXrNLAd3KRpFSP
 qkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767627642; x=1768232442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6pfEnqP29fAWnCddutSMN3ipY0MJ6U1v49jzLWZtX8=;
 b=Y0LR+VIvJ4iIDKkfeGGVDwF4Rgbd54ci3LWL1OMeGV2GQQMnlXUlaLBf6g2Cm8lKzm
 ypsrRquxZE5l8hqm466vsKA3Ku97xtGLr2f60S+EOvLJ0z/3ynNR3sVJqVAf/0xarlm1
 YljUv1zlscbwelZcw0QNbf7hkkfBdayvXVSjJif/moJIuRFj6sRLS785dy7ju5VsQ2fn
 Yxwm+M2c/alfVAFmN3fwf/KZFjUCyM3LkY3CCl+Hr4zfzYD6kq2xXVK7aly1W1o1V5ap
 5Fa7A8e0X04JJuD63LJYse4e5DL2BKz1BkGqFxFCwBlDUxuKL2JX3uYWgmJx5x+qIe86
 nVTQ==
X-Gm-Message-State: AOJu0YxGY2ljubxooLA7MYo0JzsKHNy/SJdDu1mRLGbrRHQvpEdA0utu
 k2wQbo/Q+BjQxkYxdi/bL6rtWTX51eDeWxwuOIo74fj6JsLyUPC4HBdL/ja3MWlCn0FxFOCRxDU
 p3egmkqul6g6I+8fT1Dsb58KRophhqxEqQbcTtATc
X-Gm-Gg: AY/fxX6isseciVNTLyj4wNkh0WHqpq/HQmYRpEks0NvTqVnZ1jY/WoB+Xw4oSy1KBxk
 RI5TbmhYesIbmhhB3FvOBfzo7rvcaANceOPas2slLq35pxDw7AkyhYmmewJddFH/s7thQS8589d
 6EcL2n16zj4qFsBGm8wE3jVfUXwMBNd68p4OG4PoDlzXXkCavRkKlccqeOCzisAKEfQrhtFSDr8
 oycbCkT2qvef9gMZy05Mdz2IWoMf7on0nnnKoxNtNTZr4Br9vz2MC8die7Z4OC1OSDXNTDribfQ
 Gzv1Wd4=
X-Google-Smtp-Source: AGHT+IH9zAoIngzN/qcv98ziaobPxThqPD9vhPvJ6vGQzjOYTH2Yk9aoZiCqrinJPdqPtUnKiBlTA8yZhGlVlCBWnWY=
X-Received: by 2002:a05:690e:1882:b0:646:7ae4:11e7 with SMTP id
 956f58d0204a3-6467ae4196dmr31756557d50.14.1767627642030; Mon, 05 Jan 2026
 07:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 5 Jan 2026 16:40:29 +0100
X-Gm-Features: AQt7F2ri8C_AkrZlG8m8JU78BNSYzEl8IdbvG1EuoBQZPcU3lKDLUxE0gINycZg
Message-ID: <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Daniel Golle <daniel@makrotopia.org>, E Shattow <e@freeshell.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
<dario.binacchi@amarulasolutions.com> napsal:
>
> Allow reading FWU metadata from userspace.
>
> According to [1], after updating the software on bank B, setting
> active_index to point to it (i. e. 1) and marking it as a Valid bank, it
> must be possible to read this information from userspace on the next
> boot to verify whether the boot chain of bank B succeeded.
>
> The metadata must then be updated again, marking the bank as INVALID if
> the active_index points to bank A (i. e. 0) or as VALID if the boot was
> successful.
>
> To allow reading the active_index and bank state, this new tool has been
> added.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  tools/Kconfig        |   7 +++
>  tools/Makefile       |   4 ++
>  tools/dumpfwumdata.c | 128 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 tools/dumpfwumdata.c
>
> diff --git a/tools/Kconfig b/tools/Kconfig
> index 652b0f225579..9de7eed1bbbb 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -194,6 +194,13 @@ config LUT_SEQUENCE
>         help
>           Look Up Table Sequence
>
> +config TOOLS_DUMPFWUMDATA
> +       bool "Build dumpfwumdata command"
> +       default y if FWU_MULTI_BANK_UPDATE
> +       help
> +         This command allows users to read and display the raw FWU
> +         metadata. The exact access method depends on the platform.
> +
>  config TOOLS_MKFWUMDATA
>         bool "Build mkfwumdata command"
>         default y if FWU_MULTI_BANK_UPDATE
> diff --git a/tools/Makefile b/tools/Makefile
> index ae6a30526466..bc105a086927 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,10 @@ mkeficapsule-objs :=3D generated/lib/uuid.o \
>         mkeficapsule.o
>  hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
>
> +dumpfwumdata-objs :=3D dumpfwumdata.o generated/lib/crc32.o
> +HOSTLDLIBS_dumpfwumdata +=3D -luuid
> +hostprogs-$(CONFIG_TOOLS_DUMPFWUMDATA) +=3D dumpfwumdata

you need to update this based on changes

commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
Author:     Sughosh Ganu <sughosh.ganu@linaro.org>
AuthorDate: Tue Dec 16 11:16:24 2025 +0200
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Fri Jan 2 10:28:14 2026 -0600

    kbuild: Bump the build system to 6.1


add missing always.

> +
>  mkfwumdata-objs :=3D mkfwumdata.o generated/lib/crc32.o
>  HOSTLDLIBS_mkfwumdata +=3D -luuid
>  hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
> diff --git a/tools/dumpfwumdata.c b/tools/dumpfwumdata.c
> new file mode 100644
> index 000000000000..4965484df1be
> --- /dev/null
> +++ b/tools/dumpfwumdata.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, Amarula Solutions
> + */
> +
> +#include <errno.h>
> +#include <getopt.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <generated/autoconf.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <u-boot/crc.h>
> +#include <uuid/uuid.h>
> +
> +typedef uint8_t u8;
> +typedef int16_t s16;
> +typedef uint16_t u16;
> +typedef uint32_t u32;
> +typedef uint64_t u64;
> +
> +#undef CONFIG_FWU_NUM_BANKS
> +#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
> +
> +/* This will dynamically allocate the fwu_mdata */
> +#define CONFIG_FWU_NUM_BANKS           0
> +#define CONFIG_FWU_NUM_IMAGES_PER_BANK 0
> +
> +#include <fwu_mdata.h>
> +
> +static const char *opts_short =3D "h";
> +
> +static struct option options[] =3D {
> +       {"help", no_argument, NULL, 'h'},
> +       {NULL, 0, NULL, 0},
> +};
> +
> +static void print_usage(void)
> +{
> +       fprintf(stderr, "Usage: dumpfwumdata [options] <fwumdata file>\n"=
);
> +       fprintf(stderr, "Options:\n"
> +               "\t-h, --help                  print a help message\n"
> +               );
> +}
> +
> +static void print_mdata(struct fwu_mdata *data)
> +{
> +       int i;
> +
> +       fprintf(stdout, "FWU Metadata\n");
> +       fprintf(stdout, "crc32: %#x\n", data->crc32);
> +       fprintf(stdout, "version: %#x\n", data->version);
> +       fprintf(stdout, "active_index: %#x\n", data->active_index);
> +       fprintf(stdout, "previous_active_index: %#x\n",
> +               data->previous_active_index);
> +
> +       if (data->version =3D=3D 2) {
> +               uint8_t state;
> +               char cstate;
> +               for (i =3D 0; i < 4; i++) {
> +                       state =3D data->bank_state[i];
> +                       if (state =3D=3D FWU_BANK_ACCEPTED)
> +                               cstate =3D 'A';
> +                       else if (state =3D=3D FWU_BANK_VALID)
> +                               cstate =3D 'V';
> +                       else if (state =3D=3D FWU_BANK_INVALID)
> +                               cstate =3D 'I';
> +                       else
> +                               cstate =3D '?';

Isn't it better to print accepted, valid, invalid instead?

I had to look at code to understand what that print value means.

> +
> +                       printf("bank_state[%d]: %c\n", i, cstate);
> +               }
> +       }

It is a good start but I think more information should be printed.
Number images, custom fields, etc.

> +}
> +
> +static int fwu_read_mdata(struct fwu_mdata *mdata, const char *mdata_fil=
e)
> +{
> +       FILE *mfile =3D NULL;
> +       size_t ret, size =3D sizeof(struct fwu_mdata);
> +
> +       mfile =3D fopen(mdata_file, "r");
> +       if (!mfile) {
> +               fprintf(stderr, "Error: Failed to open %s\n",
> +                       mdata_file);
> +               return -1;
> +       }
> +
> +       ret =3D fread(mdata, 1, size, mfile);
> +       fclose(mfile);
> +       if (ret !=3D size) {
> +               fprintf(stderr, "Error: Failed to read from %s\n",
> +                       mdata_file);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int c, ret;
> +       struct fwu_mdata mdata;
> +
> +       if (argc < 3) {
> +               print_usage();
> +               return -EINVAL;
> +       }

above you have only help and here you are asking for 3 args which
seems to me wrong.

> +
> +       do {
> +               c =3D getopt_long(argc, argv, opts_short, options, NULL);
> +               switch (c) {
> +               case 'h':
> +                       print_usage();
> +                       return 0;
> +               }
> +       } while (c !=3D -1);
> +
> +       ret =3D fwu_read_mdata(&mdata, argv[argc - 1]);
> +       if (ret)
> +               return ret;
> +
> +       print_mdata(&mdata);
> +       return 0;
> +}
> --
> 2.43.0
>

M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
