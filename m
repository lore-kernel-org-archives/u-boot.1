Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EC9D609C1
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 10:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87827897B0;
	Wed, 27 Nov 2024 11:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M2VFFHA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2670C897B1; Wed, 27 Nov 2024 11:13:02 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785AF8978D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 11:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ede8c4fedeso1714461a91.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 02:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1732702378; x=1733307178;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=z3lw/zgnSDG5I4uSu0UtzSLWdcIqVdae0VIhpzdhk0Q=;
 b=M2VFFHA9FJcUr3He+hdjmlduNunWZd+ULQNIWX+ZZD88GW070Iij5o2eF8c9cs2xYJ
 EH0pjKRn0zZ8+HOHprVir6VWS0xvoCC+6X7KOrytEKELJTtkC+mev5wQBeHi/W9tkz7H
 umvsM2Jm5u514o2Hx38iiXYjwCktkCDy8SKzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732702378; x=1733307178;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3lw/zgnSDG5I4uSu0UtzSLWdcIqVdae0VIhpzdhk0Q=;
 b=Vqudwg4ZzquZ71z2e0/t2TuOj1KM1AJWA53qOmj6Od6khHz+36vmr2GwImdjPg+fA5
 RLgxDKciJC7aqH62md7h5lUCC2UcOv9S8DEvCsaE0xd3YLAASW0dbwSQiikluh2Qo+rA
 ws00rJejoTraN3BLUG9CHJaeBSeyTriw1yomJPNdfOztCMnwby1BxcrIwzdFPXpPIejM
 JfIu4LQfrDyAQi1M7xfZR+62hRRUPlexlb6iTNJy5CMuuoDCtSER4dnOk55W5Q7Nnb9G
 0HyMSXRJXoeMP1KKT35WkvNFaNpiBmBvg2ClYMkcFAa54UZbVqCRQtH8XbWh77IUcOLF
 a/uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQg5MisGol4Vl3UPhu0nD1RA5UvI04Vj1EDIPXFl2760LmgR8sYB7tm3MOOAp8fsyygEdmzI=@lists.denx.de
X-Gm-Message-State: AOJu0YwltkVdVqf8XGYqZgPsTmUiw92bUZnQWrfsHv12oT4QpH5d6Qkq
 Z3xUxx/GiZxEcYQ2OggKnLqwTbpRI41D6db4EG6gNDO3P/Pr69t5tNfUyelX0enDUtktyJhTuMA
 KTAb/aww688HY6QDlWdh3nh/mFwJ7RZUHLhmSxg==
X-Gm-Gg: ASbGncvAtAOOE+bVIB8a0JXMtGg2twTxLvapm+BFuM2iisite83pr/bQXhkyvnZ8lq/
 UpZhocEdTLklkSxnMoRGO4cTxdoY8/6D4nw==
X-Google-Smtp-Source: AGHT+IEokSvPPHmABXrW05F3XW1R8sCjqmP1nvadF4Q1wn3BKAG0fgaz3s8J+YjgIbpR1pnzos9FBtX02BS4EtcUkyA=
X-Received: by 2002:a17:90b:3845:b0:2ea:97b6:c461 with SMTP id
 98e67ed59e1d1-2ee08eb30d4mr3346309a91.16.1732702377901; Wed, 27 Nov 2024
 02:12:57 -0800 (PST)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 27 Nov 2024 11:12:46 +0100
Message-ID: <CAOf5uwkTusCYYEBTQ6xN3SyFg0z3mujVG+SRx9X8kB9E1nWMcQ@mail.gmail.com>
Subject: Pull request for u-boot-nand-20241126 External
To: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
Cc: David Regan <dregan@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>
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

Hi Tom

The following changes since commit 3881c6b90350b0b04085ad46ef64989b43967eef:

  configs: Resync with savedefconfig (2024-11-26 08:17:35 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
mike/u-boot-nand-20241126

for you to fetch changes up to 5b70f26fed5aee9820530fd818f041d1779a4911:

  mtd: rawnand: brcmnand: update log level messages (2024-11-26 21:14:44 +0100)

Description comes from David Regan, that include a nice summary.

Remove device specific nand driver files as they are now replaced
by a common driver bcmbca_nand.c

Make use of OF_UPSTREAM which uses Linux dts.

Implement a minimal set of defconfig options to enable basic NAND
functionality. Tested on:
47622
63146
63158
63178
6813

Set parameter_page_big_endian to zero for bcmbca.

Update log level messages so that more critical messages can be logged
to console and help the troubleshooting with field devices.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/23584

----------------------------------------------------------------
david regan (4):
      mtd: nand: brcmnand: remove device specific nand driver files
      arm: dts: Use upstream dts
      mtd: rawnand: brcmnand: Default bcmbca parameter_page_big_endian to zero
      mtd: rawnand: brcmnand: update log level messages

 arch/arm/dts/bcm47622.dtsi                    | 126 ------------
 arch/arm/dts/bcm4912.dtsi                     | 128 ------------
 arch/arm/dts/bcm63146.dtsi                    | 110 ----------
 arch/arm/dts/bcm63158.dtsi                    | 278 --------------------------
 arch/arm/dts/bcm63178.dtsi                    | 120 -----------
 arch/arm/dts/bcm6756.dtsi                     | 130 ------------
 arch/arm/dts/bcm6813.dtsi                     | 128 ------------
 arch/arm/dts/bcm6855.dtsi                     | 257 ------------------------
 arch/arm/dts/bcm6856.dtsi                     | 253 -----------------------
 arch/arm/dts/bcm6858.dtsi                     | 272 -------------------------
 arch/arm/dts/bcm6878.dtsi                     | 111 ----------
 arch/arm/dts/bcm947622.dts                    |  30 ---
 arch/arm/dts/bcm94912.dts                     |  30 ---
 arch/arm/dts/bcm963146.dts                    |  30 ---
 arch/arm/dts/bcm963158.dts                    |  30 ---
 arch/arm/dts/bcm963178.dts                    |  30 ---
 arch/arm/dts/bcm96756.dts                     |  30 ---
 arch/arm/dts/bcm96813.dts                     |  30 ---
 arch/arm/dts/bcm96855.dts                     |  30 ---
 arch/arm/dts/bcm96856.dts                     |  30 ---
 arch/arm/dts/bcm96858.dts                     |  30 ---
 arch/arm/dts/bcm96878.dts                     |  30 ---
 arch/arm/mach-bcmbca/bcm47622/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm4912/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm63146/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm63158/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm63178/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm6756/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6813/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6855/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6856/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6858/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6878/Kconfig          |   1 +
 configs/bcm947622_defconfig                   |  11 +-
 configs/bcm94912_defconfig                    |  11 +-
 configs/bcm963146_defconfig                   |  11 +-
 configs/bcm963158_defconfig                   |  11 +-
 configs/bcm963178_defconfig                   |  11 +-
 configs/bcm96756_defconfig                    |  11 +-
 configs/bcm96813_defconfig                    |  11 +-
 configs/bcm96855_defconfig                    |  11 +-
 configs/bcm96856_defconfig                    |  11 +-
 configs/bcm96858_defconfig                    |  11 +-
 configs/bcm96878_defconfig                    |  11 +-
 drivers/mtd/nand/raw/Kconfig                  |  24 ---
 drivers/mtd/nand/raw/brcmnand/Makefile        |   4 -
 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c | 125 ------------
 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c  | 123 ------------
 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c | 124 ------------
 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c  | 125 ------------
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |  14 +-
 51 files changed, 132 insertions(+), 2782 deletions(-)
 delete mode 100644 arch/arm/dts/bcm47622.dtsi
 delete mode 100644 arch/arm/dts/bcm4912.dtsi
 delete mode 100644 arch/arm/dts/bcm63146.dtsi
 delete mode 100644 arch/arm/dts/bcm63158.dtsi
 delete mode 100644 arch/arm/dts/bcm63178.dtsi
 delete mode 100644 arch/arm/dts/bcm6756.dtsi
 delete mode 100644 arch/arm/dts/bcm6813.dtsi
 delete mode 100644 arch/arm/dts/bcm6855.dtsi
 delete mode 100644 arch/arm/dts/bcm6856.dtsi
 delete mode 100644 arch/arm/dts/bcm6858.dtsi
 delete mode 100644 arch/arm/dts/bcm6878.dtsi
 delete mode 100644 arch/arm/dts/bcm947622.dts
 delete mode 100644 arch/arm/dts/bcm94912.dts
 delete mode 100644 arch/arm/dts/bcm963146.dts
 delete mode 100644 arch/arm/dts/bcm963158.dts
 delete mode 100644 arch/arm/dts/bcm963178.dts
 delete mode 100644 arch/arm/dts/bcm96756.dts
 delete mode 100644 arch/arm/dts/bcm96813.dts
 delete mode 100644 arch/arm/dts/bcm96855.dts
 delete mode 100644 arch/arm/dts/bcm96856.dts
 delete mode 100644 arch/arm/dts/bcm96858.dts
 delete mode 100644 arch/arm/dts/bcm96878.dts
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
