Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D8C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 19:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EA3835C9;
	Thu, 10 Jul 2025 21:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Pif6+7eb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ojsVFiRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF99D835FD; Thu, 10 Jul 2025 21:16:10 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D097D834B4
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 21:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bdPhR3rvFz9sdT;
 Thu, 10 Jul 2025 21:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1752174967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CWGCT1y0p49GdXmDXJv7iYED1VTlP6HORIt1iVWNx10=;
 b=Pif6+7eb6sOaa33tdmMC47uOQJ9FUN5ePVwr8h72uOol1vbMY5m4VJ3s3aXi4z2VsUnqtf
 eaGkS0VxvJAqMBI2pTSLy8ZXsZsfJMonulsC+H3vcBU8AOEv051lF7fO+7isVoL/kpQVxA
 LN1LhDSLfwTfBaTdjbptSBr1Oop6SzH65n81dNQyBN7pExFr39bYLJlz1dMZ72taRPgvFI
 UBFv50OJN8AaLIMZNK1p/Yo73leHaqGB0hsM33BpQ2k5YVJrXqiSGq9pNfULMBYVMm15ci
 mZSj4vGVTFKXmcuNhR2Ps9nB21lyrKE5Bkcie9yKmg8fSPMuoEX2WrwS1w/JIA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ojsVFiRl;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1752174965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CWGCT1y0p49GdXmDXJv7iYED1VTlP6HORIt1iVWNx10=;
 b=ojsVFiRl9DlfHm8A1ew2VBLeKXCHTAS+pPQmXAZ0zfwWBa66bjiUPtPPOrOf5ZNn+PZebN
 hJCQ2+X+BrFRSRRmMSoe+f6YyqFG9fmeWvqDAnqsc85xU28dcaJlk8BHepDapzbtqYfUZp
 8s2ysweJliXkLiFdUTMw53xbTmlQEFFNXizS6dtyuGsfD2YZ7Nd6TCKafm+Y8k3r3WK3mN
 Hha0yRkSLF0iZ4n+Qv4VVc9gButV9Bg22vQsksPzG4YPLuobgwHL0zid5/kINfiYcAsrFU
 9k7w4mp+ooEH8J65N2gIZ+deli1xPwikylqIY7ywRMUxIZwfSp3pH1ysOuvCiA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Magnus Damm <damm@opensource.se>
Subject: [PULL] u-boot-sh/master
Date: Thu, 10 Jul 2025 21:13:22 +0200
Message-ID: <20250710191548.711070-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e6ab37c545502ea0396
X-MBO-RS-META: 1sf1wc96aeaqeg3wmwbynngkgoj5ed35
X-Rspamd-Queue-Id: 4bdPhR3rvFz9sdT
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

- SH Ether clean ups, RZ/A1 clean ups, RZ/A1 Genmai support
- Gen3 EEPROM DT node clean up
- V4H SA0 BootROM compatible binman etype, SCIF compatible SREC generation for Gen4

The following changes since commit 344e1798059ba65769272be3145736685bb25a7e:

  lmb: add missing fallthrough in lmb_alloc_mem() (2025-07-09 10:39:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 25adecf09467c6a2823bcdfaf3fb0b59b2389669:

  ARM: renesas: Add support for the r7s72100 Genmai board (2025-07-10 19:26:56 +0200)

----------------------------------------------------------------
Magnus Damm (2):
      ARM: renesas: Put common r7s72100 code in board/renesas/common
      ARM: renesas: Add support for the r7s72100 Genmai board

Marek Vasut (14):
      arm64: renesas: Convert SCIF SREC from u-boot-spl.bin
      arm64: renesas: Add Renesas R-Car Gen4 SCIF/HSCIF loader SREC generation
      net: sh_eth: Pass struct port_info around
      net: sh_eth: arm: renesas: README: Drop CFG_SH_ETHER_USE_PORT
      net: sh_eth: Convert cache operations to static functions
      net: sh_eth: arm: renesas: README: Drop CFG_SH_ETHER_CACHE_*
      net: sh_eth: Drop phy_addr assignment
      net: sh_eth: arm: renesas: README: Drop CFG_SH_ETHER_PHY_ADDR
      net: sh_eth: arm: renesas: README: Drop CFG_SH_ETHER_PHY_MODE
      arm: renesas: configs: Drop deprecated comments
      arm64: dts: renesas: Clean up sysinfo EEPROM DT description on R-Car Gen3
      binman: Add renesas_rcar4_sa0 etype
      arm64: renesas: Switch R-Car V4H to renesas_rcar4_sa0 binman etype
      ARM: renesas: Split common RZ/A1 and GR-PEACH defconfigs

 .gitignore                                         |   1 +
 README                                             |   9 -
 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi           |  32 ++++
 arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi       |   5 +-
 arch/arm/dts/r8a77951-ulcb-u-boot.dtsi             |   8 +-
 arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi       |   5 +-
 arch/arm/dts/r8a77960-ulcb-u-boot.dtsi             |   8 +-
 arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi       |   5 +-
 arch/arm/dts/r8a77965-ulcb-u-boot.dtsi             |   8 +-
 arch/arm/dts/r8a77980-condor-u-boot.dtsi           |   7 +-
 arch/arm/dts/r8a77990-ebisu-u-boot.dtsi            |  11 +-
 arch/arm/dts/r8a77995-draak-u-boot.dtsi            |   7 +-
 arch/arm/dts/r8a779g0-u-boot.dtsi                  |  78 ++-------
 arch/arm/mach-renesas/Kconfig.rza1                 |   4 +
 arch/arm/mach-renesas/Makefile                     |  14 +-
 board/renesas/common/Makefile                      |   8 +
 board/renesas/common/rza1-common.c                 |  27 +++
 .../rza1-lowlevel_init.S}                          |   0
 board/renesas/genmai/Kconfig                       |  12 ++
 board/renesas/genmai/MAINTAINERS                   |   5 +
 board/renesas/genmai/Makefile                      |   7 +
 board/renesas/genmai/genmai.c                      |  49 ++++++
 board/renesas/grpeach/Makefile                     |   1 -
 board/renesas/grpeach/grpeach.c                    |  22 ---
 common/spl/Kconfig                                 |   2 +-
 configs/genmai_defconfig                           |  17 ++
 configs/grpeach_defconfig                          |  71 ++------
 configs/renesas_rza1.config                        |  55 +++++++
 drivers/net/sh_eth.c                               | 183 ++++++++-------------
 drivers/net/sh_eth.h                               |  28 +---
 include/configs/alt.h                              |  10 --
 include/configs/blanche.h                          |   4 -
 include/configs/condor.h                           |  13 --
 include/configs/ebisu.h                            |   2 -
 include/configs/falcon.h                           |   3 -
 include/configs/genmai.h                           |  15 ++
 include/configs/gose.h                             |  10 --
 include/configs/grpeach.h                          |  12 --
 include/configs/koelsch.h                          |  12 --
 include/configs/lager.h                            |  12 --
 include/configs/porter.h                           |  12 --
 include/configs/silk.h                             |  12 --
 include/configs/stout.h                            |  12 --
 include/configs/v3hsk.h                            |  13 --
 tools/binman/etype/renesas_rcar4_sa0.py            |  46 ++++++
 tools/binman/ftest.py                              |  11 ++
 tools/binman/test/348_renesas_rcar4_sa0.dts        |  15 ++
 tools/binman/test/349_renesas_rcar4_sa0_size.dts   |  20 +++
 49 files changed, 457 insertions(+), 467 deletions(-)
 create mode 100644 arch/arm/dts/r7s72100-genmai-u-boot.dtsi
 create mode 100644 board/renesas/common/rza1-common.c
 rename board/renesas/{grpeach/lowlevel_init.S => common/rza1-lowlevel_init.S} (100%)
 create mode 100644 board/renesas/genmai/Kconfig
 create mode 100644 board/renesas/genmai/MAINTAINERS
 create mode 100644 board/renesas/genmai/Makefile
 create mode 100644 board/renesas/genmai/genmai.c
 create mode 100644 configs/genmai_defconfig
 create mode 100644 configs/renesas_rza1.config
 create mode 100644 include/configs/genmai.h
 create mode 100644 tools/binman/etype/renesas_rcar4_sa0.py
 create mode 100644 tools/binman/test/348_renesas_rcar4_sa0.dts
 create mode 100644 tools/binman/test/349_renesas_rcar4_sa0_size.dts
