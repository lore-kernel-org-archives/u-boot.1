Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEAFC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 08:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F3B888EC;
	Fri, 14 Jun 2024 10:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LOBthru/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6258C88926; Fri, 14 Jun 2024 10:09:42 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF59787ED0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 10:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6312f1f83d9so13876067b3.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718352578; x=1718957378;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30kXg9/7Oliw9Td6EGAG6X74aqjZWrMWvNGdPTDtkvw=;
 b=LOBthru/x4CDaQts5pTs9sGi6a5ZxPloMvqHBn2qAk+GsK0/lPRpSrQXosAScX1wQZ
 8NlQ/nKztcWLXOAKp40Z3rYjqNcurj8XrI1cvR/XQ4pcSobsRN2sw5wS0OKjKKE4sRJx
 o7T1GTWS5U2XJi23ZCT4CrB5PasHk/zAmeYug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718352578; x=1718957378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30kXg9/7Oliw9Td6EGAG6X74aqjZWrMWvNGdPTDtkvw=;
 b=iOKhWt4Y2cSu4FVqWrJ6GvG4wPyTeBVSHq44OSpxyvbTwoWqoVyLi5XzDcv4BUGyl+
 GxLUGCVdGU20n3pQNv4jDvYBhP/OA0bweT7ZNJVqsRN4jz1ffRiZFFL+xbEyRmck3Cxs
 GPVh8uNLPs/13bGco2+cVZXHLl4nJkQNr1N458Ybo1OPtNVlyfA71Zudnvd4xuKXEiDj
 Q2JxWQXkJ4eeazQBFvkGd2fHBtnN2YRFEbax7EsgtxXLE6/tkBqFJxq6u8J3eQoBiWA8
 IJre+G+6JoUkf0sGbSZs+vKgCrDMgzRCQoar4LJa0qj9NKErKBKDoJ0qwOcEw5sqYd6v
 k0Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuuLRARp/a7Fs5sm7dT766LKmI0HdHeIKICygFKEzL0UL4Djx4Q9r/F5kxcCvHPoRctsoA44CMBUYGrmDL3BxHgz5j3Q==
X-Gm-Message-State: AOJu0Yw0KdzvHVUs1RTo4UlLwifrUx81SvVBeuSf0pjr6tdD+q4sGVwE
 rY3XeU0XEIXwsPJ1ENtm+VmB1t+FZtXka61npBePqww86f55U1/ID/H7iS11onbdxAFTwhCfHyd
 4VZ8Wo3fR9Z82ZSOPLNgP8QUhYhoGze8PbFEPFQ==
X-Google-Smtp-Source: AGHT+IEZRp0Yg88Tr3t3WJ5svhCv7AccSx2UyAiv/9qD9S6oErCfayMai/stcB2CCfvJ9py05PqgVCDpeSQgpkEfPw0=
X-Received: by 2002:a05:690c:a13:b0:631:fd1c:78d2 with SMTP id
 00721157ae682-63222a56e73mr17516257b3.18.1718352578475; Fri, 14 Jun 2024
 01:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240603155702.1840464-1-avromanov@salutedevices.com>
 <CAFLszTi+ONdb2P5gtSX_OMUD162G7OtRMD-LbmzO7xuNLRX_HQ@mail.gmail.com>
 <20240605100922.er7xwi5wadaa5dlk@cab-wsm-0029881>
 <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
In-Reply-To: <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 14 Jun 2024 10:09:27 +0200
Message-ID: <CABGWkvoui1sChNiTa_ukc2dceK+foJQ5r-ejThvE1mKuKWWiXg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Introduce mtdblock device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, kernel <kernel@sberdevices.ru>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Alexey,

I'm still encountering errors raised by the CI:

$ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
--board ${TEST_PY_BD} ${OVERRIDE}
34Building current source for 1 boards (1 thread, 32 jobs per thread)
35 arm: + evb-ast2500
36+In file included from include/nand.h:19,
37+ from cmd/bootm.c:17:
38+include/linux/mtd/mtd.h:430:55: error: 'struct blk_desc' declared
inside parameter list will not be visible outside of this definition
or declaration [-Werror]
39+ 430 | static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *b=
desc)

Thanks and regards,
Dario

On Wed, Jun 5, 2024 at 3:17=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On Wed, 5 Jun 2024 at 04:09, Alexey Romanov <avromanov@salutedevices.com>=
 wrote:
> >
> > Hi Simon,
> > your message is empty.
> >
> > On Tue, Jun 04, 2024 at 08:13:34PM -0600, Simon Glass wrote:
> > > Hi Alexey,
> > >
> > > On Mon, Jun 3, 2024, 09:57 Alexey Romanov <avromanov@salutedevices.co=
m>
> > > wrote:
> > >
> > > > Hello!
> > > >
> > > > This series adds support for the mtdblock device, which
> > > > allows to read/write data block by block. For example,
> > > > it can now be used for BCB or Android AB command:
> > > >
> > > >   $ bcb load mtd 0 part_name
> > > >
> > > > Tested only on SPI NAND, so bind is made only for
> > > > SPI NAND drivers.
> > > >
> > > > ---
> > > >
> > > > Changes V1 -> V2 [1]:
> > > >
> > > >   - Drop patch [2].
> > > >   - Add warning if bind NAND mtdblock device.
> > > >   - Move documentation of mtdblock implementation
> > > >     from commit message to the source code.
> > > >   - Remove __maybe_unused from mtd partition functions
> > > >     description.
> > > >   - Use blk_enabled() instead of #ifdefs.
> > > >
> > > > Changes V2 -> V3 [2]:
> > > >
> > > >   - Rebased over [3].
> > > >   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
> > > >   - Fix GPL-2.0 license short name definiton in headers.
> > > >   - Add empty line after MTD_ENTRY_NUMBERS define.
> > > >
> > > > Changes V3 -> V4 [4]:
> > > >
> > > >   - Fix build warnings: use LBAF printf format string for lbaint_t =
types.
> > > >
> > > > Changes V4 -> V5 [5]:
> > > >
> > > >   - Rebased over u-boot/master.
> > > >   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
> > > >   - Fix failed tests in cases is mtdblock device isn't binded.
> > > >
> > > > Links:
> > > >
> > > >   - [1]
> > > > https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
tedevices.com/
> > > >   - [2]
> > > > https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salu=
tedevices.com/
> > > >   - [3]
> > > > https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schu=
chardt@canonical.com/T/#u
> > > >   - [4]
> > > > https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@salu=
tedevices.com/
> > > >   - [5]
> > > > https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@salu=
tedevices.com/
> > > >
> > > > Alexey Romanov (3):
> > > >   disk: support MTD partitions
> > > >   drivers: introduce mtdblock abstraction
> > > >   spinand: bind mtdblock
> > > >
> > > >  disk/part.c                 |   3 +-
> > > >  drivers/block/blk-uclass.c  |   1 +
> > > >  drivers/mtd/Kconfig         |   1 +
> > > >  drivers/mtd/Makefile        |   1 +
> > > >  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/mtd/mtdpart.c       |  76 ++++++++++++
> > > >  drivers/mtd/nand/spi/core.c |  20 ++++
> > > >  include/linux/mtd/mtd.h     |  21 ++++
> > > >  include/part.h              |   3 +
> > > >  9 files changed, 352 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/mtd/mtdblock.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
>
> Are you able to add a sandbox test for this code?
>
> Regards,
> Simon



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
