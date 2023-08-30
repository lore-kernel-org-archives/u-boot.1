Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAC5C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 09:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60E48650F;
	Wed, 30 Aug 2023 11:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Abpp4btS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BD886514; Wed, 30 Aug 2023 11:55:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B896864EF
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.115] (unknown [176.236.51.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C1F1660319E;
 Wed, 30 Aug 2023 10:55:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693389353;
 bh=oxfGZlTQPkwv/ObImCzzcwZgSkMssLpTKwKiS8Uxx1c=;
 h=Date:To:Cc:From:Subject:From;
 b=Abpp4btS0GKzm+X74dbR+K82S7hWcc2VNeJZGBxQU5G062ZmgJF2fw7Cb7kr7NSt+
 WCAbNH7rA2jEI+5ql6W7RRLF/38nCmNCZ27R3hPX5C0xtRlmbQuRyoBbuLtfGEZFUK
 1rovxahSJ9Hwc/7Bs1AR9MkoE814T6Xa6EnAv0IZIT0kAPSZpsRREpRkmjeyLJIzey
 6tbvLWCuwgAxCowP7NXP0QmsLAyagTBUIDOZcgi+KeRkuuJOvIZyhsGjbFN3JqRaaZ
 KMP0N29SivEWnusBxGX+U+PC1aGrEjw3MBmyXRKOxH0hR4oKMUhCaK7GkR0Km5Ao13
 9GNJGnI17FCAg==
Message-ID: <0b6d43cf-3afc-a2c6-a29f-efefbbf1d5d8@collabora.com>
Date: Wed, 30 Aug 2023 12:55:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PULL next] u-boot-at91-2023.10-a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Tom,


Please pull tag u-boot-at91-2023.10-a , the first set of at91
features for the next cycle 2023.10 .

This feature set includes a new board sama5d29 Curiosity, and various 
fixes and alignments for sam9x60 and sam9x60 curiosity board.

Thanks,
Eugen


The following changes since commit 7755b2200777f72dca87dd169138e95f011bbcb9:

   Merge tag 'x86-pull-20230801' of 
https://source.denx.de/u-boot/custodians/u-boot-x86 (2023-08-01 11:57:55 
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-at91.git 
tags/u-boot-at91-2023.10-a

for you to fetch changes up to 6e8c9d29e3a72f93e4d5125079eaaa1b5a52a951:

   ARM: dts: at91: sam9x60-curiosity: Sync gpio button from Linux 
(2023-08-29 17:39:01 +0300)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2023.10 cycle

----------------------------------------------------------------
Alexander Dahl (11):
       ARM: dts: at91: sam9x60: Better align with upstream dtsi
       ARM: dts: at91: sam9x60-curiosity: Fix EEPROM type
       ARM: dts: at91: sam9x60: Change i2c compatible
       ARM: dts: at91: sam9x60-curiosity: Improve alignment with upstream
       ARM: dts: at91: sam9x60-curiosity: Add raw NAND flash
       mtd: nand: raw: atmel: Remove duplicate line
       configs: at91: sam9x60_curiosity: Sync both defconfig variants
       configs: at91: sam9x60: Switch to new reset driver
       ARM: dts: at91: sam9x60-curiosity: Sync LED nodes from Linux
       board: sam9x60-curiosity: Let LED subsystem init leds if enabled
       ARM: dts: at91: sam9x60-curiosity: Sync gpio button from Linux

Mihai Sain (1):
       board: at91: sama5d29_curiosity: add initial support for 
sama5d29_curiosity

  arch/arm/dts/Makefile                              |   3 +
  arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi    |  26 ++-
  arch/arm/dts/at91-sam9x60_curiosity.dts            | 249 
+++++++++++++++++----
  arch/arm/dts/at91-sama5d29_curiosity-u-boot.dtsi   |  55 +++++
  arch/arm/dts/at91-sama5d29_curiosity.dts           | 219 
++++++++++++++++++
  arch/arm/dts/sam9x60.dtsi                          |  66 +++---
  arch/arm/dts/sam9x60ek.dts                         |   2 +-
  arch/arm/mach-at91/Kconfig                         |  12 +
  board/atmel/sam9x60_curiosity/sam9x60_curiosity.c  |  18 ++
  board/atmel/sama5d29_curiosity/Kconfig             |  15 ++
  board/atmel/sama5d29_curiosity/MAINTAINERS         |   9 +
  board/atmel/sama5d29_curiosity/Makefile            |   7 +
  .../atmel/sama5d29_curiosity/sama5d29_curiosity.c  |  86 +++++++
  configs/sam9x60_curiosity_mmc1_defconfig           |   2 +
  configs/sam9x60_curiosity_mmc_defconfig            |  17 +-
  configs/sam9x60ek_mmc_defconfig                    |   2 +
  configs/sam9x60ek_nandflash_defconfig              |   2 +
  configs/sam9x60ek_qspiflash_defconfig              |   2 +
  configs/sama5d29_curiosity_mmc1_defconfig          | 120 ++++++++++
  configs/sama5d29_curiosity_mmc_defconfig           | 119 ++++++++++
  configs/sama5d29_curiosity_qspiflash_defconfig     | 119 ++++++++++
  drivers/mtd/nand/raw/atmel/nand-controller.c       |   1 -
  include/configs/sama5d29_curiosity.h               |  17 ++
  23 files changed, 1079 insertions(+), 89 deletions(-)
  create mode 100644 arch/arm/dts/at91-sama5d29_curiosity-u-boot.dtsi
  create mode 100644 arch/arm/dts/at91-sama5d29_curiosity.dts
  create mode 100644 board/atmel/sama5d29_curiosity/Kconfig
  create mode 100644 board/atmel/sama5d29_curiosity/MAINTAINERS
  create mode 100644 board/atmel/sama5d29_curiosity/Makefile
  create mode 100644 board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
  create mode 100644 configs/sama5d29_curiosity_mmc1_defconfig
  create mode 100644 configs/sama5d29_curiosity_mmc_defconfig
  create mode 100644 configs/sama5d29_curiosity_qspiflash_defconfig
  create mode 100644 include/configs/sama5d29_curiosity.h
