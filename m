Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F822D2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 15:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193F683A41;
	Sun, 11 Jan 2026 16:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="emZDcB++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5EA83A5A; Sun, 11 Jan 2026 16:17:34 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EA883A3D
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 16:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6420c08f886so7929799d50.3
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768144650; x=1768749450;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFZDQY9HIUVxNSKb2Nd6pj99NEOK8cpKyDO22xaWmsI=;
 b=emZDcB++AJq6GYuScbr4V2qR6GVzbUVs0LAYa999VRLF6jCONhr2awrYTN7zmezl++
 vXOaIrf9mjzsO8EPs+HV/Gxs/f0eZVGk1yvldGUbxR2xX2X2ngbLYgvy/dqYl9el4gnV
 3iQo7F7OSP0jwPRj9AyoHQTvTLrxVOsHsrAo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768144650; x=1768749450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFZDQY9HIUVxNSKb2Nd6pj99NEOK8cpKyDO22xaWmsI=;
 b=E6sviKj/eEy9WwIRuPsd5GQEQXys+HFfNLoSIClHSLg5LE+AVaXdaKUN+QNglq9l68
 M5/lGoT172GlaHH2cjDWksT4y6cgOFB0nn5UAfvz9wONdeJ8xi3aXt2Yd5XjXKvSMGgE
 p14xQSBLzYnRqDdfR86eFZfmqkrWmKxs3zhlN/GU8rIOI98dZn82h8U05aoXCvDko2E/
 Xnuk/j5Sqbn4g0MkraYdEFt351t9viPN4cNZ8Gm968NfX25OdRJJ7s0CM6SEW4qmBD7H
 kqqA6DNh4kVMeaFrMmoXNGonvIFTP2XrdCZzI7liIORv2Cq0ZGrT2gq5oK+IGCAyhAr2
 3zUQ==
X-Gm-Message-State: AOJu0YyVOCV/i6+qmpoI0tl9tSUNkjJMyjei6Oi2bXjdaxEIruy9UgEr
 Vs2o/cnlk5SS24Ig/7pH8z6Cr6LwsaJVSyLVXCa9+9em3ujeyJOLFiE9a1jCzbY4BhLo35az/8z
 TlNXFMBFMa7JW7vT9zUZG+YSxx7+i0e72ATZUitLcNA==
X-Gm-Gg: AY/fxX46Uc1M5BQd8sZtLjc39uutJCmg8OGSk+ocLEQha4lsOEoqBIFXJlVyH0M+ukD
 k5EXv93Mght5X5A4xg8jMKczHPHLxMS+a6eHwlUiuLs2jT3rZCcpVAmRvo3ezhKd1NbUy1SoUzO
 Uw1DB3WUHti0N2U0SZMuXO1ZCEHpUFFVa6MAfqketWQVP/DbkVWR4CnzPn9zpVn9jmtP16ZQRtZ
 OKSiOBnb7l+fZk3K/fCTcVYTSJvBozFCvwch4jv80TjXe1q4Lrfu4JbUGJQgEG7CwVSFFmeyAdt
 RNIOXwzYsjOicER+tyhbyxuOVQ==
X-Google-Smtp-Source: AGHT+IEW7i6O8VTzOQisEF2JC1ybxwvKgh1WH65YMYnssc5kYV7BEmmMQtjATtbGwlXODXLhjmHDfMAtk6Oi+6AAcls=
X-Received: by 2002:a05:690e:1405:b0:646:6f6f:669 with SMTP id
 956f58d0204a3-64716b338f8mr13143318d50.16.1768144650096; Sun, 11 Jan 2026
 07:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
 <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
In-Reply-To: <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 11 Jan 2026 16:17:19 +0100
X-Gm-Features: AZwV_QjOzLrEdevhlqNZZYw8_-ph0ARBLpcSmd1jPqO2tqi0w0WG10e7pLdjmK8
Message-ID: <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Daniel Golle <daniel@makrotopia.org>, E Shattow <e@freeshell.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
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

Hello Michal,

On Mon, Jan 5, 2026 at 4:40=E2=80=AFPM Michal Simek <monstr@monstr.eu> wrot=
e:
>
> ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
> <dario.binacchi@amarulasolutions.com> napsal:
> >
> > Allow reading FWU metadata from userspace.
> >
> > According to [1], after updating the software on bank B, setting
> > active_index to point to it (i. e. 1) and marking it as a Valid bank, i=
t
> > must be possible to read this information from userspace on the next
> > boot to verify whether the boot chain of bank B succeeded.
> >
> > The metadata must then be updated again, marking the bank as INVALID if
> > the active_index points to bank A (i. e. 0) or as VALID if the boot was
> > successful.
> >
> > To allow reading the active_index and bank state, this new tool has bee=
n
> > added.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  tools/Kconfig        |   7 +++
> >  tools/Makefile       |   4 ++
> >  tools/dumpfwumdata.c | 128 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 139 insertions(+)
> >  create mode 100644 tools/dumpfwumdata.c
> >
> > diff --git a/tools/Kconfig b/tools/Kconfig
> > index 652b0f225579..9de7eed1bbbb 100644
> > --- a/tools/Kconfig
> > +++ b/tools/Kconfig
> > @@ -194,6 +194,13 @@ config LUT_SEQUENCE
> >         help
> >           Look Up Table Sequence
> >
> > +config TOOLS_DUMPFWUMDATA
> > +       bool "Build dumpfwumdata command"
> > +       default y if FWU_MULTI_BANK_UPDATE
> > +       help
> > +         This command allows users to read and display the raw FWU
> > +         metadata. The exact access method depends on the platform.
> > +
> >  config TOOLS_MKFWUMDATA
> >         bool "Build mkfwumdata command"
> >         default y if FWU_MULTI_BANK_UPDATE
> > diff --git a/tools/Makefile b/tools/Makefile
> > index ae6a30526466..bc105a086927 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -271,6 +271,10 @@ mkeficapsule-objs :=3D generated/lib/uuid.o \
> >         mkeficapsule.o
> >  hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
> >
> > +dumpfwumdata-objs :=3D dumpfwumdata.o generated/lib/crc32.o
> > +HOSTLDLIBS_dumpfwumdata +=3D -luuid
> > +hostprogs-$(CONFIG_TOOLS_DUMPFWUMDATA) +=3D dumpfwumdata
>
> you need to update this based on changes
>
> commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
> Author:     Sughosh Ganu <sughosh.ganu@linaro.org>
> AuthorDate: Tue Dec 16 11:16:24 2025 +0200
> Commit:     Tom Rini <trini@konsulko.com>
> CommitDate: Fri Jan 2 10:28:14 2026 -0600
>
>     kbuild: Bump the build system to 6.1
>
>
> add missing always.
>
> > +
> >  mkfwumdata-objs :=3D mkfwumdata.o generated/lib/crc32.o
> >  HOSTLDLIBS_mkfwumdata +=3D -luuid
> >  hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
> > diff --git a/tools/dumpfwumdata.c b/tools/dumpfwumdata.c
> > new file mode 100644
> > index 000000000000..4965484df1be
> > --- /dev/null
> > +++ b/tools/dumpfwumdata.c
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2025, Amarula Solutions
> > + */
> > +
> > +#include <errno.h>
> > +#include <getopt.h>
> > +#include <limits.h>
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <generated/autoconf.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <u-boot/crc.h>
> > +#include <uuid/uuid.h>
> > +
> > +typedef uint8_t u8;
> > +typedef int16_t s16;
> > +typedef uint16_t u16;
> > +typedef uint32_t u32;
> > +typedef uint64_t u64;
> > +
> > +#undef CONFIG_FWU_NUM_BANKS
> > +#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
> > +
> > +/* This will dynamically allocate the fwu_mdata */
> > +#define CONFIG_FWU_NUM_BANKS           0
> > +#define CONFIG_FWU_NUM_IMAGES_PER_BANK 0
> > +
> > +#include <fwu_mdata.h>
> > +
> > +static const char *opts_short =3D "h";
> > +
> > +static struct option options[] =3D {
> > +       {"help", no_argument, NULL, 'h'},
> > +       {NULL, 0, NULL, 0},
> > +};
> > +
> > +static void print_usage(void)
> > +{
> > +       fprintf(stderr, "Usage: dumpfwumdata [options] <fwumdata file>\=
n");
> > +       fprintf(stderr, "Options:\n"
> > +               "\t-h, --help                  print a help message\n"
> > +               );
> > +}
> > +
> > +static void print_mdata(struct fwu_mdata *data)
> > +{
> > +       int i;
> > +
> > +       fprintf(stdout, "FWU Metadata\n");
> > +       fprintf(stdout, "crc32: %#x\n", data->crc32);
> > +       fprintf(stdout, "version: %#x\n", data->version);
> > +       fprintf(stdout, "active_index: %#x\n", data->active_index);
> > +       fprintf(stdout, "previous_active_index: %#x\n",
> > +               data->previous_active_index);
> > +
> > +       if (data->version =3D=3D 2) {
> > +               uint8_t state;
> > +               char cstate;
> > +               for (i =3D 0; i < 4; i++) {
> > +                       state =3D data->bank_state[i];
> > +                       if (state =3D=3D FWU_BANK_ACCEPTED)
> > +                               cstate =3D 'A';
> > +                       else if (state =3D=3D FWU_BANK_VALID)
> > +                               cstate =3D 'V';
> > +                       else if (state =3D=3D FWU_BANK_INVALID)
> > +                               cstate =3D 'I';
> > +                       else
> > +                               cstate =3D '?';
>
> Isn't it better to print accepted, valid, invalid instead?
>
> I had to look at code to understand what that print value means.
>
> > +
> > +                       printf("bank_state[%d]: %c\n", i, cstate);
> > +               }
> > +       }
>
> It is a good start but I think more information should be printed.
> Number images, custom fields, etc.
>
> > +}
> > +
> > +static int fwu_read_mdata(struct fwu_mdata *mdata, const char *mdata_f=
ile)
> > +{
> > +       FILE *mfile =3D NULL;
> > +       size_t ret, size =3D sizeof(struct fwu_mdata);
> > +
> > +       mfile =3D fopen(mdata_file, "r");
> > +       if (!mfile) {
> > +               fprintf(stderr, "Error: Failed to open %s\n",
> > +                       mdata_file);
> > +               return -1;
> > +       }
> > +
> > +       ret =3D fread(mdata, 1, size, mfile);
> > +       fclose(mfile);
> > +       if (ret !=3D size) {
> > +               fprintf(stderr, "Error: Failed to read from %s\n",
> > +                       mdata_file);
> > +               return -1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       int c, ret;
> > +       struct fwu_mdata mdata;
> > +
> > +       if (argc < 3) {
> > +               print_usage();
> > +               return -EINVAL;
> > +       }
>
> above you have only help and here you are asking for 3 args which
> seems to me wrong.

Thank you for your review and the feedback on my patch series.
After I sent the series, I realized that this series had previously
been posted:
https://lore.kernel.org/all/20251212-feature_fwumdata-v2-0-ad51572fbe79@boo=
tlin.com/.
From what I understand, it starts from the same need as mine, namely
the implementation of a tool that
allows reading FWU metadata from Linux. My version is definitely more
minimal compared to what Kory
has done.
Therefore, before sending a v2, I think it would be useful to
understand which of the two makes more sense
to move forward with. Could you help me with that? I have also CCed
Kory to keep the discussion shared.

Thanks and regards,
Dario
>
> > +
> > +       do {
> > +               c =3D getopt_long(argc, argv, opts_short, options, NULL=
);
> > +               switch (c) {
> > +               case 'h':
> > +                       print_usage();
> > +                       return 0;
> > +               }
> > +       } while (c !=3D -1);
> > +
> > +       ret =3D fwu_read_mdata(&mdata, argv[argc - 1]);
> > +       if (ret)
> > +               return ret;
> > +
> > +       print_mdata(&mdata);
> > +       return 0;
> > +}
> > --
> > 2.43.0
> >
>
> M
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



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
