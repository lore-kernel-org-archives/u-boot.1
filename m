Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA39CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB7183045;
	Tue, 30 Sep 2025 10:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ovnp5vVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D3783071; Tue, 30 Sep 2025 10:20:06 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E482D828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-26e68904f0eso57004425ad.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1759220402; x=1759825202;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Kl5aYRA95bIjAdO6a9hfaTF3SUzw7ZQMhhJNN22X7Q=;
 b=Ovnp5vVxZ2sNOV93XmpHKSNd3f4vuA8g8z4Nee8+v3+UCR+Ru8P0xiGo1jLpSrPoaP
 92oDqul3K3naWgGP168bWWWcRvlHtexoxF72g6m8vjrZtn77OZ/pP+Qas0SeGFHCTrf8
 WAUIqkj4O8aPjBeyX5FT+md04jbuSZa8lRP4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220402; x=1759825202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Kl5aYRA95bIjAdO6a9hfaTF3SUzw7ZQMhhJNN22X7Q=;
 b=JBDTI+kH1AvkvweTAgdB/cs9+kUtxUIex7+c1pEGwQGCvsv0CI3DJ4nh5uVshp00D3
 g4Ms/rKsKPhHqGOMHrNv09DcqLDlKpYRQJoBUmkkhaVjEbU9rPdvC/OVKIGGILLKcrsk
 FpquoyBLAHM0uXycsbPUHmRMvX4pknuiZLogfvKfYkPh1Wbdb2t3Hja+9bkcXLwqzGJ8
 sjZlrIZFbpqzRzBxfqZLB+77j5S8FP9PWaZtM4NKqPECyosICVVdcVPgM44xKPutnGHo
 hETrWNCQ1LrExvOvF9DQvPqpMbfHkBT9a7dI79rZqqAtJ3j27kIbmQB7ikfdDnXOiFWH
 8DqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpxvGMtnmlZSX0mZoi5Bp0ihqdvjJZwYk97M8G0QWRsh+fP/cOKo3iXBdb0604YKAEYb3kzBo=@lists.denx.de
X-Gm-Message-State: AOJu0YxVqas3hUaA4tinNBFEarrIMayyocljtKvPNX4N6e5zhxO/0sTe
 XR6Znq/NqleBDj0tGGSXJ6ei6HRCFoR0Sq8X95EZGQ94qploUoYXvPF0U7luka3+106aHd2A1XP
 U987r8GTeT79LpgGNZAKWCvEAfKaiRDyzJ/yEjQagLg==
X-Gm-Gg: ASbGnctlMdXPEEo6x2j3Xjr0t4rPAffj3lnrT6LuKqH2vuxnNWwh9wOwhaDZvl2J75j
 nW3eX4KQiZFml8AghUTG+o1xpEPf+T5inhdbHD253nA91dolV69/QW3QU/ishSc3znmmzwsIHeD
 0yTOLVx/PvUCNsqe0MKq+dofblOzcXaUbnBsk2ZB5xXvD9JuXEJ86rmin3IL4u6cZvXptcJUheU
 Ldb2gSUdDHrRYTge4/Vm8TBc6grNOAq5Mz3ops=
X-Google-Smtp-Source: AGHT+IEGYA4y39sEIHiv7jfE2IQouf++5duITBM0e8/sofw6h8a5mfnLHqbY68DK96caKwgDzrxuDtPhXNVU0N5yZvM=
X-Received: by 2002:a17:903:19ef:b0:274:3db8:e755 with SMTP id
 d9443c01a7336-27ed4a7ec49mr206885485ad.30.1759220401769; Tue, 30 Sep 2025
 01:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 30 Sep 2025 10:19:50 +0200
X-Gm-Features: AS18NWCbrGYzwrZMmGjluEgilbdVZPEoUKR9ThYk2hZ5KhlZ4yJ53kHIew_w_bM
Message-ID: <CAOf5uwkGo7bAFdR_bVu0S2Mdta6smR4NzDfV7fXu1anyPACNPQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/24] mtd: spinand: driver improvements
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de, 
 Andreas Gnau <andreas.gnau@iopsys.eu>
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

Hi all

On Tue, Sep 30, 2025 at 2:21=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch series makes u-boot SPI NAND driver almost the same as in
> linux-6.17. This provides the following improvements:
>  * it becomes easy to port changes from linux kernel
>  * more flash is supported
>  * spi drivers can accelerate flash reading/writing using spi-mem dirmap =
API
>  * continuous reading mode was supported (for some flashes)
>  * OTP support was added (for some flashes)
>  * add support of special data recovery reading (for some flashes)
>  * bug fixes
>  * other minor improvements
>
> The following linux kernel driver features was not implemented
>  * support of different ECC engines
>  * per operation maximum spi bus frequency
>
> The code has been tested on Airoha AN7581 (64-bit) based boards
> equipped with flash memory Micron MT29F2G01ABAGD
>
> Additionally the patch series includes continuous reading mode fixes.
> The corresponding linux patches were accepted to nand/next branch
> of mtd/linux.git repository.
>
> Changes v2:
>  * update patch description
>  * add fixes for continuous reading mode
>
> Changes v3:
>  * fix duplication in patch description
>  * add more information about commits ported from linux kernel
>
> Changes v4:
>  * the original authorship was preserved for several patches
>  * the code was synced with the latest shapshot of future linux-6.17-rc1
>  * spi-nand was replaced by spinand in patch description
>  * continuous reading mode fixes were updated
>
> Changes v5:
>  * add missed SoB tags
>  * improve patch messages
>  * add tags for patches ported from linux
>  * drop continuous mode fixes (will be sent after corresponding linux fix=
es)
>
> Changes v6:
>  * improve patch messages
>
> Changes v7:
>  * patches to fix continuous reading mode was added.
>
> Alexander Lobakin (1):
>   mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
>
> Cheng Ming Lin (2):
>   mtd: spinand: Add support for setting plane select bits
>   mtd: spinand: Add read retry support
>
> Daniel Golle (1):
>   mtd: spinand: set bitflip_threshold to 75% of ECC strength
>
> Gabor Juhos (1):
>   mtd: spinand: propagate spinand_wait() errors from
>     spinand_write_page()
>
> Mikhail Kshevetskiy (15):
>   spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
>   mtd: spinand: Use the spi-mem dirmap API
>   mtd: spinand: Extend spinand_wait() to match Linux kernel
>     implementation
>   mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
>   mtd: spinand: Align logic for enabling ECC to match Linux kernel
>   mtd: spinand: Refactor spinand_init* functions
>   mtd: spinand: Refactor ECC/OOB functions
>   mtd: spinand: Sync core code and device support with Linux 6.10
>   mtd: spinand: add support of continuous reading mode
>   mtd: spinand: add OTP support
>   mtd: spinand: Enhance the logic when picking a variant
>   mtd: spinand: Sync core code and device support with Linux 6.17-rc1
>   mtd: spinand: fix direct mapping creation sizes
>   mtd: spinand: try a regular dirmap if creating a dirmap for continuous
>     reading fails
>   mtd: spinand: repeat reading in regular mode if continuous reading
>     fails
>
> Miquel Raynal (2):
>   mtd: nand: Add a NAND page I/O request type
>   mtd: spinand: Add a ->configure_chip() hook
>
> Takahiro Kuwano (2):
>   mtd: spinand: Remove write_enable_op() in markbad()
>   mtd: spinand: Introduce a way to avoid raw access
>
>  drivers/mtd/nand/spi/Makefile         |   5 +-
>  drivers/mtd/nand/spi/alliancememory.c | 155 ++++
>  drivers/mtd/nand/spi/ato.c            |  88 +++
>  drivers/mtd/nand/spi/core.c           | 975 +++++++++++++++++++-------
>  drivers/mtd/nand/spi/esmt.c           | 123 +++-
>  drivers/mtd/nand/spi/foresee.c        | 107 +++
>  drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
>  drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
>  drivers/mtd/nand/spi/micron.c         | 180 ++++-
>  drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
>  drivers/mtd/nand/spi/paragon.c        |  24 +-
>  drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
>  drivers/mtd/nand/spi/toshiba.c        |  63 +-
>  drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
>  drivers/mtd/nand/spi/xtx.c            |  20 +-
>  drivers/spi/spi-mem.c                 |  45 +-
>  include/linux/mtd/nand.h              | 157 ++++-
>  include/linux/mtd/spinand.h           | 374 ++++++++--
>  include/spi-mem.h                     |  93 ++-
>  19 files changed, 3154 insertions(+), 509 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>  create mode 100644 drivers/mtd/nand/spi/ato.c
>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>  create mode 100644 drivers/mtd/nand/spi/otp.c
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>
> --
> 2.51.0
>

Long queue but I will pick them today, together with mtd patches

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
