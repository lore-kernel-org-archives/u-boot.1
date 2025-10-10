Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D1CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 05:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067C783FDE;
	Fri, 10 Oct 2025 07:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CumMoMY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2740B83FF0; Fri, 10 Oct 2025 07:39:14 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185D383FC6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-271d1305ad7so28658125ad.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1760074748; x=1760679548;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nVZAD0atZaiyzucObnMklt4bovxcULnbGmLiVqjAGqg=;
 b=CumMoMY0wjyTfb61HucSks/UitNfhG+sFFTt39BEcIkyHy9uapCMezf08jBjkC+Kqi
 uE1rg9z3Egt1jsfC7vsIu1Q9sEI2+MUkRo+lAo/Jf+1999oOm/SPZ2rFddrWH49uxmvD
 eUGatLckKE97TFv0D2posiOcwzDI+xENEeMcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760074748; x=1760679548;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVZAD0atZaiyzucObnMklt4bovxcULnbGmLiVqjAGqg=;
 b=CyLRk4QvDJp1WIohz3dizo8Bhbzic9bLOMCoJ8wpYtjHdmToxCn9z1Ys5irnyhjwOL
 gJYN7d68+kevRa4PolEIOUoKCx6TDzT4Kbs4HYmg9vLnwK7U4DWBtOKeI9cw2FkYEqBH
 7dqQXXjaZ2kjnwsnGtEB/2yc1SBBRKCtfEbnS/DdVrbUWJwZZQBH3uS/OxkGGgnWXdnA
 IqvU4p4PCmOp4wfCmFTf/uBn+Ui4usPz55KBoiBV1hxVczKumb+KJEkoPNuXTT45Kysk
 ic40Am60vBCxHGl2FQugkylj1Q05wMhY3trzQAB6mmWVWMDbQ7HTyMW9N0XIGJlKfd9j
 1vog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTLF2FqX0UBLKycnkNWhtJNJOXi3bifS/LkWNqJUyYDuLQrioq40h9by3s+TKRP2OuDawy7Kw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2Fq+lfTFxbyoRxGvVe0DUpXf/BDkmOncvgpEvRoIKZtVKop+3
 gqjlFDNMferNtg2VB2rROaix+2QGyUjQSElMsMZ1EQhy52L2TGwLDel5ndxuUB6Y9nHwktGhJS/
 7e+2W+F/FcGW7GbV5jPziO/okQif+B6BpV6QLz2s829QS1hT2+3e5mK4QdpWG
X-Gm-Gg: ASbGnctpiW4/OwHkYVx9Qi5VOVDGw4lg5cjyprpkbi4QsH+q5OxVdUgHCPTuh7OlRn6
 Kdx1mk5u5xfqSw4+jZLyTWZsyXnBcgB9H8r8vw/86NBYjH8OG/xYc0ietu6IQ1i9DOm7bTsWRa8
 3gWi/x3TEoNLbclzgIOLDXNB7kZ9FTEigRJrx5QGhL6iGSnd9zfUiUTw3RtgLcBXFecxro0GjBP
 KcK4R5J4M56hA3NhbpIbJ2OYPy9yRJHIzni2U43zzOZMwJJ4SmQ/xaFbNSnAPOPn/2J
X-Google-Smtp-Source: AGHT+IF6T/eUEh+/AwcpSntIDlb3gWSaShTqMMPGgyRvABcJWI21xKw7QUTMGoibpk2Zsq9QBexmajHFJ+IotGqLAo0=
X-Received: by 2002:a17:902:eb8d:b0:262:cd8c:bfa8 with SMTP id
 d9443c01a7336-290273eca73mr134517765ad.34.1760074748310; Thu, 09 Oct 2025
 22:39:08 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 10 Oct 2025 07:38:57 +0200
X-Gm-Features: AS18NWCjwl512_IXwtdmO3oxK8Wh2G8DSnEHMSbcBgJ6rOGrNYnSfJ6gHa2tdoc
Message-ID: <CAOf5uwkie65Tsfnmg_5suGzfMZCM0usPEkjDyQkjcS_aDcobZw@mail.gmail.com>
Subject: Pull request for uboot-nand-05102025
To: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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

The following changes since commit dc6c80056e21a27e28e1be62ac724302ef526841:

  global: Add expected space between '#include' and directive
(2025-10-04 13:31:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git uboot-05102025

for you to fetch changes up to ef0f6e7a9993067e96660ae029080d7e944da1f2:

  nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL interaction
(2025-10-09 20:57:27 +0200)

This series adds significant and valuable work by Mikhail Kshevetskiy
to align spi-mem with Linux 6.16. It also includes contributions to
the mtd performance patches, a work started by Miquel Raynal and
improved by Mikhail Kshevetskiy. Additionally, two patches tighten
dependencies on the Atmel driver.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/27873

----------------------------------------------------------------
Alexander Lobakin (1):
      mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Cheng Ming Lin (2):
      mtd: spinand: Add support for setting plane select bits
      mtd: spinand: Add read retry support

Daniel Golle (1):
      mtd: spinand: set bitflip_threshold to 75% of ECC strength

Gabor Juhos (1):
      mtd: spinand: propagate spinand_wait() errors from spinand_write_page()

Mikhail Kshevetskiy (20):
      spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
      mtd: spinand: Use the spi-mem dirmap API
      mtd: spinand: Extend spinand_wait() to match Linux kernel implementation
      mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
      mtd: spinand: Align logic for enabling ECC to match Linux kernel
      mtd: spinand: Refactor spinand_init* functions
      mtd: spinand: Refactor ECC/OOB functions
      mtd: spinand: Sync core code and device support with Linux 6.10
      mtd: spinand: add support of continuous reading mode
      mtd: spinand: add OTP support
      mtd: spinand: Enhance the logic when picking a variant
      mtd: spinand: Sync core code and device support with Linux 6.17-rc1
      mtd: spinand: fix direct mapping creation sizes
      mtd: spinand: try a regular dirmap if creating a dirmap for
continuous reading fails
      mtd: spinand: repeat reading in regular mode if continuous reading fails
      cmd: mtd: add markbad command support
      cmd: mtd: add nand_write_test command support
      cmd: mtd: add nand_read_test command support
      cmd: mtd: fix speed measurement in the speed benchmark
      cmd: mtd: add benchmark option to the help

Miquel Raynal (2):
      mtd: nand: Add a NAND page I/O request type
      mtd: spinand: Add a ->configure_chip() hook

Takahiro Kuwano (2):
      mtd: spinand: Remove write_enable_op() in markbad()
      mtd: spinand: Introduce a way to avoid raw access

Tom Rini (2):
      mtd: Tighten some mtd driver dependencies
      nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL interaction

 cmd/Kconfig                           |  38 ++
 cmd/mtd.c                             | 480 ++++++++++++++++-
 drivers/memory/Kconfig                |   2 +-
 drivers/mtd/Kconfig                   |   1 +
 drivers/mtd/nand/raw/Kconfig          |  15 +-
 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++++
 drivers/mtd/nand/spi/ato.c            |  88 +++
 drivers/mtd/nand/spi/core.c           | 975 +++++++++++++++++++++++++---------
 drivers/mtd/nand/spi/esmt.c           | 123 ++++-
 drivers/mtd/nand/spi/foresee.c        | 107 ++++
 drivers/mtd/nand/spi/gigadevice.c     |  86 +--
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++++-
 drivers/mtd/nand/spi/otp.c            | 369 +++++++++++++
 drivers/mtd/nand/spi/paragon.c        |  24 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++++
 drivers/mtd/nand/spi/toshiba.c        |  63 ++-
 drivers/mtd/nand/spi/winbond.c        | 361 ++++++++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 +++++-
 include/linux/mtd/spinand.h           | 374 +++++++++++--
 include/spi-mem.h                     |  93 +++-
 24 files changed, 3675 insertions(+), 524 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
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
