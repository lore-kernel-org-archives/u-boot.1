Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC42CC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5DB88385;
	Wed,  5 Jun 2024 15:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPnnYVzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFF588385; Wed,  5 Jun 2024 15:17:49 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCF7879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b96a95c5e8so3724577eaf.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717593465; x=1718198265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rcYVES9z9QtRlIgsz0XVCFRkJbVsS49fGk7DNa1G5gk=;
 b=ZPnnYVzMFy5l3ODQlSaW5j0xpxYQvUFceYv22Z6OLCtYDZXBf+VgbhrR7S1g5b3Som
 B9UwJI6XbdouSn7X+FVGgwjYKlXp6FQWh6TuIz4fQiQCNtAKVSlF4MDKD+CpGTEw7BVX
 qpgTr7xP9CuXI/A3fNvbDXke/t8nTEUsCifVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717593465; x=1718198265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcYVES9z9QtRlIgsz0XVCFRkJbVsS49fGk7DNa1G5gk=;
 b=k4FYMINQypCLJjPmrtWA73+TLvJP1g5PdJcrvcZVHPIKuolDJas5sopEAKtTyeCfmx
 w9l+7N8+dlqtekjyoKtbpa5vmG8GiWIEaR+SAx0+lEITiYrTh7qoM2+j/TSaaprYUBwT
 plsvTnsGLFHKcR27d9mY2cDHMe4/5pgMb6SarueOUTBQVaw0irYdja3WUP5AAFFxN1xg
 p36Ry8cs5MPevKLGJHLjnC/zAEhZCTipOgpbz+6XuiqMH+fV2/IeNhN0PBnoQYdiZQwo
 d/zRDFR0N9lB5pnGK4w4uflA4O52DuxwbyYG7X+Is2/Ay3JMl+hqHnV5WZdMKAaCMchy
 pz/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsoAoR1dQfBBeMEXMwPrnNqxEOobgahZySwFAOK2I9DnCkMij5GRPiaLqJDtFjVoWtVINhmfSdqqh1zUlvza1Cps8Rg==
X-Gm-Message-State: AOJu0Yy5ij4M/RBoYqhvdakyOuMcszk+4dH53Y2HnH2Oacidb78q5ixm
 z6+WtQa/4W7hG73q74UGP6cuWsX+Th9OaXSyhactKm+TYHPxAblmaV1bQcLIqMOC6asjQ5e12OU
 I1379t2GLH+MnwoCKM/V2H6/yv8GPST2+4xkG
X-Google-Smtp-Source: AGHT+IGK+5DsD5L/8GeRH0/bks4w56Lsv+3dwfpx/nossI5ZfbKZz3wbMU2DBqtOmWSSPZ8fEwEoJ2Dm569GmZepdtc=
X-Received: by 2002:a05:6358:2618:b0:19c:3b76:2116 with SMTP id
 e5c5f4694b2df-19c6c695011mr272855555d.11.1717593464782; Wed, 05 Jun 2024
 06:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240603155702.1840464-1-avromanov@salutedevices.com>
 <CAFLszTi+ONdb2P5gtSX_OMUD162G7OtRMD-LbmzO7xuNLRX_HQ@mail.gmail.com>
 <20240605100922.er7xwi5wadaa5dlk@cab-wsm-0029881>
In-Reply-To: <20240605100922.er7xwi5wadaa5dlk@cab-wsm-0029881>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Jun 2024 07:17:34 -0600
Message-ID: <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Introduce mtdblock device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
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

On Wed, 5 Jun 2024 at 04:09, Alexey Romanov <avromanov@salutedevices.com> wrote:
>
> Hi Simon,
> your message is empty.
>
> On Tue, Jun 04, 2024 at 08:13:34PM -0600, Simon Glass wrote:
> > Hi Alexey,
> >
> > On Mon, Jun 3, 2024, 09:57 Alexey Romanov <avromanov@salutedevices.com>
> > wrote:
> >
> > > Hello!
> > >
> > > This series adds support for the mtdblock device, which
> > > allows to read/write data block by block. For example,
> > > it can now be used for BCB or Android AB command:
> > >
> > >   $ bcb load mtd 0 part_name
> > >
> > > Tested only on SPI NAND, so bind is made only for
> > > SPI NAND drivers.
> > >
> > > ---
> > >
> > > Changes V1 -> V2 [1]:
> > >
> > >   - Drop patch [2].
> > >   - Add warning if bind NAND mtdblock device.
> > >   - Move documentation of mtdblock implementation
> > >     from commit message to the source code.
> > >   - Remove __maybe_unused from mtd partition functions
> > >     description.
> > >   - Use blk_enabled() instead of #ifdefs.
> > >
> > > Changes V2 -> V3 [2]:
> > >
> > >   - Rebased over [3].
> > >   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
> > >   - Fix GPL-2.0 license short name definiton in headers.
> > >   - Add empty line after MTD_ENTRY_NUMBERS define.
> > >
> > > Changes V3 -> V4 [4]:
> > >
> > >   - Fix build warnings: use LBAF printf format string for lbaint_t types.
> > >
> > > Changes V4 -> V5 [5]:
> > >
> > >   - Rebased over u-boot/master.
> > >   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
> > >   - Fix failed tests in cases is mtdblock device isn't binded.
> > >
> > > Links:
> > >
> > >   - [1]
> > > https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
> > >   - [2]
> > > https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salutedevices.com/
> > >   - [3]
> > > https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schuchardt@canonical.com/T/#u
> > >   - [4]
> > > https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@salutedevices.com/
> > >   - [5]
> > > https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@salutedevices.com/
> > >
> > > Alexey Romanov (3):
> > >   disk: support MTD partitions
> > >   drivers: introduce mtdblock abstraction
> > >   spinand: bind mtdblock
> > >
> > >  disk/part.c                 |   3 +-
> > >  drivers/block/blk-uclass.c  |   1 +
> > >  drivers/mtd/Kconfig         |   1 +
> > >  drivers/mtd/Makefile        |   1 +
> > >  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
> > >  drivers/mtd/mtdpart.c       |  76 ++++++++++++
> > >  drivers/mtd/nand/spi/core.c |  20 ++++
> > >  include/linux/mtd/mtd.h     |  21 ++++
> > >  include/part.h              |   3 +
> > >  9 files changed, 352 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/mtd/mtdblock.c
> > >
> > > --
> > > 2.34.1
> > >
> > >
>

Are you able to add a sandbox test for this code?

Regards,
Simon
