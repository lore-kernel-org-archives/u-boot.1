Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043A2CF3185
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 10:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5006583DBF;
	Wed, 19 Nov 2025 11:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XpLK2YT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCBE83E3A; Wed, 19 Nov 2025 11:33:06 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF458392C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-640daf41b19so958314d50.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 02:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1763548381; x=1764153181;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=idMO4m5wsaN6Ycs3JP/U7bp6dJEDaV87vSOSHg/6t1g=;
 b=XpLK2YT7f8JYZ6rSMGmN6SWFKPuu332a/mox+Mk/PKTvryd9uvNXJLQdAgq2faAYDA
 y08aaX4EsMn18fiSBPFWh0pLCUFadkBlhGFTl/NegBtbXUSvtQu3iVPpS91qXist5Cmd
 JhPPTzqKj7WUqOIZM4/e6Xk7FNIk596X20IpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763548381; x=1764153181;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=idMO4m5wsaN6Ycs3JP/U7bp6dJEDaV87vSOSHg/6t1g=;
 b=tfkwZlIhNf/bDUaAFS2k0KSWdw4y16IrJxHJop2Y5M5gdnoQ/c0tegPnonltJ5MO7e
 6ClBY+DPB8Db1AUAGtLJtCZRRGBswPwR4J7nEFxYqn3GXvwHNaYkJz2aD8BSPC1jJS7y
 DEmg7fhtIw/OF2BW/3U7/x3cR9w8N1sck1qi8Af8Wbioa32fhRlR8fSLhmys/TDKmjz9
 t5xXsdxywTL4ZnwNm3eEUGu1UYWZ3oplUvegZ3FXYa4MxsuPmQ1CJJhwJCGxW1GDnt2y
 xXiatKxONMa7M9pGh6oXkvCn7Y/VpPIlktN0XecbBOOcP7lI3XDOfvFjsBGhSHVOw2MV
 co6Q==
X-Gm-Message-State: AOJu0Yw8Q582PrPyduxoGTEvgXCn8k3ZLzOiqMw+yHRw9NZnLlY5b9x3
 PAO/vSZnCXDRklW14m9OgDen55jVMglmE7bkg1+fKS3BIbKVGUs137Qk7VnFebgLXlPPdg1/Ky9
 bKrzT2zSEDg3xu73xZJEUVqH3aN6Uktp6kRkgOr69dHEZOHQpU2kQe8ir2g==
X-Gm-Gg: ASbGncsnr9rmkWvOLVj8LnE1lYAI3IKP2jU1PiiUCAmK9klGTdsK5pYRf+1lMLAxUmd
 0jTZRpLvku668xxcfLY7fVF26qyW1gWQRKRU7tDwFvq/hfPCfZLo5Sbc75seAeRUjleMg3ShJ4n
 6vXtU7ZqG1OZLPwsTG542+2QvoIpBvt5+Qg4HdZHXH1jfoUxseuCQVjO1sE0D7lhCQ/F17I7Ck1
 cLrvIJwWWYJh0uRauN30VKhxYYEdyUOVBzdkngtAd51Sj+anjGTfsCU/fvFUhGgN3UK8EUsCAsY
 0kGco474ywqxnteOWB3IICgHIvh+45C6+uiBfs9Q2isLFBg=
X-Google-Smtp-Source: AGHT+IF7/64HTNr/VR50/Ch7/Vmf+ZSfpIq2KJwpkID/+X8BODI7gYhAnMe7thR/oww6w5pZ1jwldHELnxn3MB+/GiU=
X-Received: by 2002:a05:690e:1403:b0:640:d864:6e64 with SMTP id
 956f58d0204a3-642ed422672mr1651378d50.14.1763548380926; Wed, 19 Nov 2025
 02:33:00 -0800 (PST)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Nov 2025 11:32:49 +0100
X-Gm-Features: AWmQ_bnhPmklYMzZxAvOrxnbt1yH3ywimla_Sa0J5avaRA6P1bGwM-6p3OHx95I
Message-ID: <CAOf5uwmFp_o1QFJ4A7MoBxNSF7Pwr1G8PLR+Lyx6PSrZ3ustpQ@mail.gmail.com>
Subject: Pull request for uboot-nand-20250918
To: U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

The following changes since commit 91861e5a30d217d8e70130c9124c1646f4afef29:

  Merge tag 'u-boot-stm32-20251117' of
https://source.denx.de/u-boot/custodians/u-boot-stm (2025-11-17
10:45:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-20250918

for you to fetch changes up to 19548adfe9ea1d12963b3959b8ad2c94a4647878:

  spi: airoha: en7523: workaround flash damaging if UART_TXD was short
to GND (2025-11-18 20:07:41 +0100)

This pull request enhances NAND and SPI flash support, primarily
focusing on the Airoha EN7523 platform.
The Airoha SPI driver receives a major update, adding DMA,
dual/quad-wire modes, and a critical workaround to prevent
flash damage if the UART_TXD pin shorts to Ground.

New chips supported include FudanMicro FM25S01A SPI-NAND and several
Winbond SPI NOR devices. Fixes
include correcting Kconfig dependencies, updating the mtd benchmark
command to use lldiv(), and
addressing minor bugs in the generic spi-mem and SPL NAND code.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/28408

----------------------------------------------------------------
Heinrich Schuchardt (1):
      spl: nand: typo 'destintion'

Mikhail Kshevetskiy (14):
      cmd: mtd: benchmark: use lldiv() instead of 64-bit division
      spi: spi-mem: fix coverity report CID 537478
      spi: airoha: remove unnecessary operation adjust_op_size
      spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
      spi: airoha: add dma support
      spi: airoha: return an error for continuous mode dirmap creation cases
      spi: airoha: support of dualio/quadio flash reading commands
      spi: airoha: buffer must be 0xff-ed before writing
      dts: airoha: en7523: enable double speed flash reading
      spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
      spi: airoha: reduce the number of modification of
REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
      spi: airoha: set custom sector size equal to flash page size
      spi: airoha: avoid usage of flash specific parameters
      spi: airoha: en7523: workaround flash damaging if UART_TXD was
short to GND

Miquel Raynal (1):
      mtd: spinor: winbond: Describe several chips

Tianling Shen (1):
      mtd: spinand: add support for FudanMicro FM25S01A

Tom Rini (2):
      nand: raw: Kconfig: Correct some dependency issues
      mtd: nand: raw: Drop SYS_NAND_SOFT_ECC from NAND_SANDBOX

 arch/arm/dts/en7523-u-boot.dtsi |   2 +-
 cmd/mtd.c                       |   5 +-
 common/spl/spl_nand.c           |   2 +-
 drivers/mtd/nand/raw/Kconfig    |   4 -
 drivers/mtd/nand/spi/Makefile   |   2 +-
 drivers/mtd/nand/spi/core.c     |   1 +
 drivers/mtd/nand/spi/fmsh.c     |  76 +++++
 drivers/mtd/spi/spi-nor-ids.c   |   6 +
 drivers/spi/airoha_snfi_spi.c   | 688 +++++++++++++++++++++++++++++++---------
 drivers/spi/spi-mem.c           |  41 ++-
 include/linux/mtd/spinand.h     |   1 +
 11 files changed, 673 insertions(+), 155 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/fmsh.c
