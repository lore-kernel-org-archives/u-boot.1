Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AF9C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 12:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3898288025;
	Thu, 11 Jul 2024 14:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iPItgjmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2111088025; Thu, 11 Jul 2024 14:42:46 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8482B87F5C
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-650866942aeso8627487b3.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720701762; x=1721306562;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXsMUMFCH2EliTx31XrxgsAEmf+f0UoEs3lRtN9NxVc=;
 b=iPItgjmrW6jGMulkVZl0QctY6GdaVKlHHt4VnqYiezD9vGwMnR/0EfiRt9AEkcnO5l
 +W4Ca+yV4E4DNawrCxeaYbTvzIsYw7yzGFjEaLuhxr/HH14Atsg/Qe752s1ZafR0KNUQ
 QNb345wJFj2rwNkiJuvNvlHoHJCpGSj0VYQwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720701762; x=1721306562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XXsMUMFCH2EliTx31XrxgsAEmf+f0UoEs3lRtN9NxVc=;
 b=JOAgz5lO1kw6cxUEoj8ZtSiWcw3SAHWpusy9/w2nTPhV1Qda6373FV2rvIc2AO0kW9
 g+Q/31ghfGoHCW3Sn6Imvz5tZh/BGlG+pMjcAk6iY6ZS/LawQX0PFhxXagd0L/UPyrJ6
 JwGqwKSL4Mm8KE3Uv1TV5Zs9WQkMx9O2wiLTHt8MNVtuLqyRp+8Vtr4EdvKRoraD+4rv
 LY2ZPlQy2hMUsRmZJ/3oM3gxF8oAqRa/pQA5KL1LG7Rov0G0FLhgD1qSZQByWJWtf2TF
 +fdbrSt4wEXCxEC/FUzC8DbQsFy9621bMPXiK/cEj56RTt5fQloT48ZdOROIfrdOkMB+
 h9Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmiHnuWg3zc3zC/3IgIqECnWqpI/Dra4uofW4a/bpxsCvjsFkbgtl+jNUc2xg6oyjqYMNFTn9hAHKm65bQc9jq0nAQ7w==
X-Gm-Message-State: AOJu0Yy65hcOikJcyIFXiVNKQvvC+H1mxK6O+eKqX3PgRA4cgZYb0eYb
 nyprZu94hnRSrH7f+ldi95lfacrqJtBQdfbZ9JwDMq+ceH2rjENEr2FYkI6EeEErHH4QcI0zE3R
 WveC8Y41ZGQ5esnuBy4xLCaqCPNHvpaaQfbf7qg==
X-Google-Smtp-Source: AGHT+IEEbMKRNBgDtai9b1HHMlIzgxmI1EmKf2dSkesOd4pQtsdpAmd9UfVrCKhkVwrGwS+CRkwc7cezi8c0+Cfk+BQ=
X-Received: by 2002:a05:690c:6d0e:b0:648:3c1d:36d6 with SMTP id
 00721157ae682-658ee7905b4mr117792357b3.10.1720701762372; Thu, 11 Jul 2024
 05:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240626104440.2811686-1-avromanov@salutedevices.com>
 <20240708100756.j34cftjmjkl2hiv3@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240708100756.j34cftjmjkl2hiv3@cab-wsm-0029881.sigma.sbrf.ru>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 11 Jul 2024 14:42:31 +0200
Message-ID: <CABGWkvpHJW9z7dPRkwydwdAsVfBvzr9+p=HLMd01xKADr2h6zA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Introduce mtdblock device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "michael@amarulasolutions.com" <michael@amarulasolutions.com>, 
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "bmeng@tinylab.org" <bmeng@tinylab.org>,
 "tobias@waldekranz.com" <tobias@waldekranz.com>, 
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>, 
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 kernel <kernel@sberdevices.ru>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hello Alexey,

On Mon, Jul 8, 2024 at 12:08=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Hello, ping.

I ran the CI tests, but they failed once again.

The "Introduce mtdblock device" series fails the "build all 32bit ARM
platforms" test and
raises "exceeds file size limit" errors like the following:

arm: + mx6sabresd
1056+u-boot.img exceeds file size limit:
1057+ limit: 0xaebf6 bytes
1058+ actual: 0xaef88 bytes
1059+ excess: 0x392 bytes
1060+make[1]: *** [Makefile:1478: u-boot.img] Error 1
1061+make[1]: *** Deleting file 'u-boot.img'
1062+make: *** [Makefile:177: sub-make] Error 2

While the "Introduce UBI block device", applied over the  "Introduce
mtdblock device" falis the
following tests:
- vexpress_ca9x4:
- xilinx_zynq_virt:
- build all 32bit ARM platforms

All with the following error:
    1450+arm-linux-gnueabi-ld.bfd: drivers/mtd/ubi/part.o: in function
`part_get_info_ubi':
    1451+drivers/mtd/ubi/part.c:55:(.text.part_get_info_ubi+0x4c):
undefined reference to `__aeabi_ldivmod'

Furthermore the "Introduce mtdblock device" series has to be rebased.

Please, run the buildman tests before submitting the patches.

Thanks and regards,
Dario

>
> On Wed, Jun 26, 2024 at 01:44:37PM +0300, Alexey Romanov wrote:
> > Hello!
> >
> > This series adds support for the mtdblock device, which
> > allows to read/write data block by block. For example,
> > it can now be used for BCB or Android AB command:
> >
> >   $ bcb load mtd 0 part_name
> >
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers.
> >
> > ---
> >
> > Changes V1 -> V2 [1]:
> >
> >   - Drop patch [2].
> >   - Add warning if bind NAND mtdblock device.
> >   - Move documentation of mtdblock implementation
> >     from commit message to the source code.
> >   - Remove __maybe_unused from mtd partition functions
> >     description.
> >   - Use blk_enabled() instead of #ifdefs.
> >
> > Changes V2 -> V3 [2]:
> >
> >   - Rebased over [3].
> >   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
> >   - Fix GPL-2.0 license short name definiton in headers.
> >   - Add empty line after MTD_ENTRY_NUMBERS define.
> >
> > Changes V3 -> V4 [4]:
> >
> >   - Fix build warnings: use LBAF printf format string for lbaint_t type=
s.
> >
> > Changes V4 -> V5 [5]:
> >
> >   - Rebased over u-boot/master.
> >   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
> >   - Fix failed tests in cases is mtdblock device isn't binded.
> >
> > Changes V5 -> V6 [6]:
> >
> >   - Rebased over u-boot/master.
> >   - Fix build errors when CONFIG_MTD isn't enabled.
> >   - Use auto blk device devnum generation when call
> >     blk_create_devicef (pass -1 parameter instead of dev_seq(dev)).
> >
> > Links:
> >
> >   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@=
salutedevices.com/
> >   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@=
salutedevices.com/
> >   - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.=
schuchardt@canonical.com/T/#u
> >   - [4] https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@=
salutedevices.com/
> >   - [5] https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@=
salutedevices.com/
> >   - [6] https://lore.kernel.org/all/20240603155702.1840464-1-avromanov@=
salutedevices.com/
> >
> > Alexey Romanov (3):
> >   disk: support MTD partitions
> >   drivers: introduce mtdblock abstraction
> >   spinand: bind mtdblock
> >
> >  disk/part.c                 |   3 +-
> >  drivers/block/blk-uclass.c  |   1 +
> >  drivers/mtd/Kconfig         |   1 +
> >  drivers/mtd/Makefile        |   3 +
> >  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/mtdpart.c       |  76 ++++++++++++
> >  drivers/mtd/nand/spi/core.c |  20 ++++
> >  include/linux/mtd/mtd.h     |  25 ++++
> >  include/part.h              |   3 +
> >  9 files changed, 358 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/mtd/mtdblock.c
> >
> > --
> > 2.34.1
> >
>
> --
> Thank you,
> Alexey



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
