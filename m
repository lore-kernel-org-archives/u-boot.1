Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F1C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DC788006;
	Tue, 27 Feb 2024 17:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cRHAUGN1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kGYzuz75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E2C88005; Tue, 27 Feb 2024 17:10:08 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2149887FEB
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TkjB560jyz9sRt;
 Tue, 27 Feb 2024 17:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y+a5hzwoi+95bP4tAwXt0JdqhUkO8PLVUi/hNonZkGY=;
 b=cRHAUGN1dexd4PRsjhiNMLS0xJyYpROWrGX+Gw8TxbW3xqhOETMhA1H1ObZ/51sFT713ns
 6y2OTFIWU62brPE85pe2NFF0IzZTr1W8ZkwlT5YuR3rljHAeQkRfiNSTxI3Iry+B+MW5WN
 Ib7ZyGzl8fDnEdyAgolKe8tYChnUiyzTAkxhTs0Y375kwIP9cMqblcDtyIgbv5cRP1p818
 AckKY1yLMxKBreItPbNGhKCNkRkpBmAH9V7E7CCt+PE440bcifVWg1h73W+P+pwj2I/Hco
 VHw/fuc1T3RG4dBz9psMl0R631FOtUVhmjWG/gPKvVRCijRKimCH6jgX9BLOCQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y+a5hzwoi+95bP4tAwXt0JdqhUkO8PLVUi/hNonZkGY=;
 b=kGYzuz75zh6niwng2aljK6qtGtokipRDhD+8TEvXUA+I5i/7sVjxcQWkV3GtR5WX5rkhad
 WHa42Q/X6WroiqzdDfhODEi+ZeGY/4h2TvdPDgUWtdSOZ6Pmac0C2EATUgLf0zSLo/tvN8
 930ir90l4SJo4dUd6uenHYfp9u2FFjctT/4bHrPsgnJUSH/2btFxvqkWGdDvl1ggi7fn5+
 7600k1hTent1XBE5tBPLXAHdIi2WOlZ9bC8ac3Gp7IwM/f+mnVJzitOXzZA5Nwajy64Kzd
 KuWCjyPePAKYk0RJsQsVMiQsufWnf2mgEd4uQanULB/xHqgiUU/OlJHDNmYfnw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/19] ARM: renesas: Rename R-Mobile to Renesas
Date: Tue, 27 Feb 2024 17:05:40 +0100
Message-ID: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9d815dd4613ec7448d8
X-MBO-RS-META: xt1q57p4jo97sed43j6wfw8o74bygtma
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

Rename R-Mobile to Renesas all over the place because the chips are
made by Renesas, while only a subset of them is from the R-Mobile line.

Marek Vasut (19):
  ARM: renesas: Drop remnants of R8A7740 support
  ARM: renesas: Drop unused sh_sdhi.h
  ARM: renesas: Drop unused mmc.h
  ARM: renesas: Drop unused pfc-r8a7790.h
  ARM: renesas: Rename rmobile_get_cpu_type() to renesas_get_cpu_type()
  ARM: renesas: Rename rmobile_get_cpu_rev_*() to
    renesas_get_cpu_rev_*()
  ARM: renesas: Rename RMOBILE_CPU_TYPE_* to RENESAS_CPU_TYPE_*
  ARM: renesas: Rename rmobile_cpuinfo_idx() to renesas_cpuinfo_idx()
  ARM: renesas: Rename rmobile_cpuinfo[] to renesas_cpuinfo[]
  ARM: renesas: Simplify weak symbols
  ARM: renesas: Rename rmobile_get_prr() to renesas_get_prr()
  ARM: renesas: Rename ARCH_RMOBILE_BOARD_STRING to
    ARCH_RENESAS_BOARD_STRING
  ARM: renesas: Rename CONFIG_ARCH_RMOBILE_EXTRAM_BOOT to
    CONFIG_RENESAS_EXTRAM_BOOT
  ARM: renesas: Rename rmobile.h to renesas.h
  ARM: renesas: Rename ARCH_RMOBILE to ARCH_RENESAS
  ARM: renesas: Rename arch-/mach-rmobile to arch-/mach-renesas
  ARM: renesas: Post rename fix ups
  mmc: renesas-sdhi: Rename rmobile_is_gen3_mmc0() to
    rcar_is_gen3_mmc0()
  git-mailrc: Add renesas entry and update rmobile entry

 MAINTAINERS                                   |    2 +-
 Makefile                                      |    2 +-
 arch/arm/Kconfig                              |    4 +-
 arch/arm/Makefile                             |    2 +-
 .../{mach-rmobile => mach-renesas}/Kconfig    |   14 +-
 .../{mach-rmobile => mach-renesas}/Kconfig.32 |    7 +-
 .../{mach-rmobile => mach-renesas}/Kconfig.64 |    4 +-
 .../Kconfig.rcar3                             |    0
 .../Kconfig.rcar4                             |    0
 .../Kconfig.rza1                              |    0
 .../Kconfig.rzg2l                             |    0
 .../Kconfig.rzn1                              |    0
 .../{mach-rmobile => mach-renesas}/Makefile   |    1 -
 .../{mach-rmobile => mach-renesas}/board.c    |    4 +-
 .../cpu_info-rcar.c                           |   16 +-
 .../cpu_info-rzg.c                            |    0
 .../cpu_info-rzg2l.c                          |   10 +-
 arch/arm/mach-renesas/cpu_info.c              |  144 +
 .../arm/{mach-rmobile => mach-renesas}/emac.c |    2 +-
 .../include/mach/boot0.h                      |    0
 arch/arm/mach-renesas/include/mach/gpio.h     |    4 +
 .../include/mach/irqs.h                       |    0
 .../include/mach/r8a7790.h                    |    4 +-
 .../include/mach/r8a7791.h                    |    4 +-
 .../include/mach/r8a7792.h                    |    2 +-
 .../include/mach/r8a7793.h                    |    4 +-
 .../include/mach/r8a7794.h                    |    4 +-
 .../include/mach/rcar-base.h                  |    2 +-
 .../include/mach/rcar-gen3-base.h             |    2 +-
 .../include/mach/rcar-gen4-base.h             |    2 +-
 .../include/mach/rcar-mstp.h                  |    2 +-
 arch/arm/mach-renesas/include/mach/renesas.h  |   56 +
 .../include/mach/rzg2l.h                      |    0
 .../include/mach/sys_proto.h                  |    0
 .../lowlevel_init_ca15.S                      |    2 +-
 .../lowlevel_init_gen3.S                      |    0
 .../memmap-gen3.c                             |    0
 .../memmap-rzg2l.c                            |    0
 .../psci-r8a779a0.c                           |    0
 arch/arm/mach-rmobile/cpu_info-r8a7740.c      |   31 -
 arch/arm/mach-rmobile/cpu_info.c              |  151 -
 arch/arm/mach-rmobile/include/mach/gpio.h     |    9 -
 arch/arm/mach-rmobile/include/mach/mmc.h      |   13 -
 .../mach-rmobile/include/mach/r8a7740-gpio.h  |  572 ----
 arch/arm/mach-rmobile/include/mach/r8a7740.h  |  274 --
 arch/arm/mach-rmobile/include/mach/rmobile.h  |   58 -
 arch/arm/mach-rmobile/include/mach/sh_sdhi.h  |  170 --
 arch/arm/mach-rmobile/lowlevel_init.S         |   72 -
 arch/arm/mach-rmobile/pfc-r8a7740.c           | 2612 -----------------
 arch/arm/mach-rmobile/pfc-r8a7790.h           |  139 -
 arch/sh/lib/time.c                            |    2 +-
 board/beacon/beacon-rzg2m/Kconfig             |    2 +-
 board/hoperun/hihope-rzg2/Kconfig             |    2 +-
 board/hoperun/hihope-rzg2/hihope-rzg2.c       |    2 +-
 board/renesas/alt/alt.c                       |    4 +-
 board/renesas/alt/alt_spl.c                   |    2 +-
 board/renesas/alt/qos.c                       |    8 +-
 board/renesas/blanche/blanche.c               |    6 +-
 board/renesas/blanche/qos.c                   |    8 +-
 board/renesas/condor/Kconfig                  |    2 +-
 board/renesas/draak/Kconfig                   |    2 +-
 board/renesas/draak/draak.c                   |    3 +-
 board/renesas/eagle/Kconfig                   |    2 +-
 board/renesas/ebisu/Kconfig                   |    2 +-
 board/renesas/falcon/Kconfig                  |    2 +-
 board/renesas/falcon/falcon.c                 |    2 +-
 board/renesas/gose/gose.c                     |    3 +-
 board/renesas/gose/gose_spl.c                 |    2 +-
 board/renesas/gose/qos.c                      |    8 +-
 board/renesas/grayhawk/Kconfig                |    2 +-
 board/renesas/grayhawk/grayhawk.c             |    2 +-
 board/renesas/koelsch/koelsch.c               |    3 +-
 board/renesas/koelsch/koelsch_spl.c           |    2 +-
 board/renesas/koelsch/qos.c                   |    8 +-
 board/renesas/lager/lager.c                   |    6 +-
 board/renesas/lager/lager_spl.c               |    2 +-
 board/renesas/lager/qos.c                     |   10 +-
 board/renesas/porter/porter.c                 |    3 +-
 board/renesas/porter/porter_spl.c             |    2 +-
 board/renesas/porter/qos.c                    |    8 +-
 board/renesas/rcar-common/common.c            |    2 +-
 board/renesas/rcar-common/v3-common.c         |    2 +-
 board/renesas/rzg2l/Kconfig                   |    2 +-
 board/renesas/salvator-x/Kconfig              |    2 +-
 board/renesas/salvator-x/salvator-x.c         |   11 +-
 board/renesas/silk/qos.c                      |    8 +-
 board/renesas/silk/silk.c                     |    4 +-
 board/renesas/silk/silk_spl.c                 |    2 +-
 board/renesas/spider/Kconfig                  |    2 +-
 board/renesas/spider/spider.c                 |    2 +-
 board/renesas/stout/qos.c                     |   10 +-
 board/renesas/stout/stout.c                   |    6 +-
 board/renesas/stout/stout_spl.c               |    2 +-
 board/renesas/ulcb/Kconfig                    |    2 +-
 board/renesas/ulcb/ulcb.c                     |   11 +-
 board/renesas/v3hsk/Kconfig                   |    2 +-
 board/renesas/v3msk/Kconfig                   |    2 +-
 board/renesas/whitehawk/Kconfig               |    2 +-
 board/renesas/whitehawk/whitehawk.c           |    2 +-
 board/silinux/ek874/Kconfig                   |    2 +-
 configs/alt_defconfig                         |    4 +-
 configs/blanche_defconfig                     |    4 +-
 configs/gose_defconfig                        |    4 +-
 configs/grpeach_defconfig                     |    2 +-
 configs/hihope_rzg2_defconfig                 |    2 +-
 configs/koelsch_defconfig                     |    4 +-
 configs/lager_defconfig                       |    4 +-
 configs/porter_defconfig                      |    4 +-
 configs/r8a77970_eagle_defconfig              |    2 +-
 configs/r8a77970_v3msk_defconfig              |    2 +-
 configs/r8a77980_condor_defconfig             |    2 +-
 configs/r8a77980_v3hsk_defconfig              |    2 +-
 configs/r8a77990_ebisu_defconfig              |    2 +-
 configs/r8a77995_draak_defconfig              |    2 +-
 configs/r8a779a0_falcon_defconfig             |    2 +-
 configs/r8a779f0_spider_defconfig             |    2 +-
 configs/r8a779g0_whitehawk_defconfig          |    2 +-
 configs/r8a779h0_grayhawk_defconfig           |    2 +-
 configs/rcar3_salvator-x_defconfig            |    2 +-
 configs/rcar3_ulcb_defconfig                  |    2 +-
 configs/renesas_rzg2l_smarc_defconfig         |    2 +-
 configs/rzg2_beacon_defconfig                 |    2 +-
 configs/rzn1_snarc_defconfig                  |    2 +-
 configs/silinux_ek874_defconfig               |    2 +-
 configs/silk_defconfig                        |    4 +-
 configs/stout_defconfig                       |    4 +-
 doc/git-mailrc                                |    3 +-
 drivers/clk/renesas/Kconfig                   |    2 +-
 drivers/gpio/Kconfig                          |    2 +-
 drivers/i2c/Kconfig                           |    2 +-
 drivers/mmc/Kconfig                           |    4 +-
 drivers/mmc/renesas-sdhi.c                    |   74 +-
 drivers/mmc/sh_mmcif.h                        |    2 +-
 drivers/net/ravb.c                            |    4 +-
 drivers/pinctrl/Makefile                      |    2 +-
 drivers/pinctrl/renesas/Kconfig               |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7790.c         |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7794.c         |    4 +-
 drivers/ram/Makefile                          |    2 +-
 drivers/serial/Kconfig                        |    4 +-
 drivers/spi/renesas_rpc_spi.c                 |   10 +-
 drivers/spi/sh_qspi.c                         |    2 +-
 drivers/usb/host/Kconfig                      |    2 +-
 include/configs/rcar-gen2-common.h            |    2 +-
 include/configs/rcar-gen3-common.h            |    2 +-
 include/configs/rcar-gen4-common.h            |    2 +-
 include/configs/rzg2l-smarc.h                 |    2 +-
 147 files changed, 439 insertions(+), 4355 deletions(-)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig (87%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.32 (96%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.64 (56%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rcar3 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rcar4 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rza1 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rzg2l (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rzn1 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Makefile (98%)
 rename arch/arm/{mach-rmobile => mach-renesas}/board.c (71%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rcar.c (70%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rzg.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rzg2l.c (84%)
 create mode 100644 arch/arm/mach-renesas/cpu_info.c
 rename arch/arm/{mach-rmobile => mach-renesas}/emac.c (91%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/boot0.h (100%)
 create mode 100644 arch/arm/mach-renesas/include/mach/gpio.h
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7790.h (87%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7791.h (95%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7792.h (93%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7793.h (95%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7794.h (87%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-base.h (99%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-gen3-base.h (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-gen4-base.h (96%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-mstp.h (97%)
 create mode 100644 arch/arm/mach-renesas/include/mach/renesas.h
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rzg2l.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/sys_proto.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/lowlevel_init_ca15.S (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/lowlevel_init_gen3.S (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/memmap-gen3.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/memmap-rzg2l.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/psci-r8a779a0.c (100%)
 delete mode 100644 arch/arm/mach-rmobile/cpu_info-r8a7740.c
 delete mode 100644 arch/arm/mach-rmobile/cpu_info.c
 delete mode 100644 arch/arm/mach-rmobile/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-rmobile/include/mach/mmc.h
 delete mode 100644 arch/arm/mach-rmobile/include/mach/r8a7740-gpio.h
 delete mode 100644 arch/arm/mach-rmobile/include/mach/r8a7740.h
 delete mode 100644 arch/arm/mach-rmobile/include/mach/rmobile.h
 delete mode 100644 arch/arm/mach-rmobile/include/mach/sh_sdhi.h
 delete mode 100644 arch/arm/mach-rmobile/lowlevel_init.S
 delete mode 100644 arch/arm/mach-rmobile/pfc-r8a7740.c
 delete mode 100644 arch/arm/mach-rmobile/pfc-r8a7790.h

---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
-- 
2.43.0

