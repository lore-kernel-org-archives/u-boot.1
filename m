Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE4CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 23:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A4184812;
	Sat, 16 May 2026 01:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tl3B5dre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6796F84884; Sat, 16 May 2026 01:30:35 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0978480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-9116861f004so110924785a.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778887831; x=1779492631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1k3WFPYn7k0tHxbBToF30Jhcn3+lA7I2lLngwPCUGQk=;
 b=Tl3B5dren4CAC/k+r3z2uzll73bsipG6KIIWfGa2g6bHwoR/T7UAXuepz3pzRKBImH
 zN70FL8PuclIY12ze06dbOxat1KefZlXfrNLMgvMv+5ZPDNidabLXGSDxZBFaEU5ZYqJ
 lUSj31JHbOLfsaqh3gxjNR8ATMy32HfSanexPzOFBUBEOk6vEtHK5AFw0N/6s239Zyiy
 QQpl1rlVR2X3UcdCJevy5z63L9easuraJURk6eR4e+fjJT6B/H9+Fqb6hRpZlgWRgAgS
 /KFXOqfKPo+8SOnG16ssffkdcWRHY7lEFSm/AoCL09/KtZDgdfuE5KW+No5uYFc74IGG
 0U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887831; x=1779492631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1k3WFPYn7k0tHxbBToF30Jhcn3+lA7I2lLngwPCUGQk=;
 b=KZVV1lNOEdmGGpgCola4gjBgTiWbOK81UOhogdPWX9rTUYFS0+tNrMxixM4MHKgd0M
 utI5JR/phV0ZK+7QhUWKdTsUFTHhmznM63Y9QFwWuVN5B6lqokcwvcHm6jHsSQ/PdmWj
 g2GnF5jlAfiTK5idM4gBJDPZi65xqiUJiGIyzGTjeElAAO3YulcvCr/HIBZgBHAItmB2
 DaXaES5Wyv01eGrTzSiaSTIPM4gnPSkWeuED3sivdeoAgrammSubwicnyddhcsdU9ah7
 VCMEROjTHwEMLWVHUu3vlA31l5a9JoE93O0lu02OUabJoM1qSzSfBZWwWJLBu+wDy4a2
 fciw==
X-Gm-Message-State: AOJu0Ywo/BP1JFno6wGg6C8Cd4kLSEl8CVo0ZLiLol65Gl4OoO7E8VRR
 zBxz5hoRvArjtFK9bRVVqZwIcDyhZAWn/230nXNfQ3J7s+wQt1BhcKCr
X-Gm-Gg: Acq92OFjBeK2oTXH6uU8JfiIHRedZxRtvw7c6RJ4gYK50aecbcemDvV7muKymXE9Ehk
 GlnrjNeKioVk39AiN32ULlYJgrF85zPsy3qPFbCyBvgliYZuJcJB88ZO3iJ9k0smMUF2tDl+IX4
 LrEIniuRahjVY/lW1+4/RU8gAd2gXDLBd3Pg/RBMFUyRtbkzvZ463eKWk3WP5EQAH2I8cTO/+8z
 Bhfme77LCHLEq6HC/wisGsBj6rrmmkvBAAJeMoX0+VkyomdKj4veqKa30/OQPCE2Yar1/riNXut
 nsHDVy6aupxJ71tngfJCwqXqrx0EzElUexJLXGcXhcPN4xBrvZNjeDNtmQkmH4lA/YQFvDMJfiL
 1HRqlF0noIOEEavrPqB/rUMDC4sxxTfuUvOptoeSOePqEHSeU3RniJL5K5opo63R7DSI8rlw0q4
 FpudlLCfD2X7sTfEIiVFHVjLZ68SmP8RVh0aRNVAW1MN4fl+PcKeQ/CusKKWuvwfsKLURLUctn2
 HnYFPyb
X-Received: by 2002:a05:620a:4042:b0:8ec:c4a7:f8ec with SMTP id
 af79cd13be357-911cdd44042mr1066197385a.4.1778887831118; 
 Fri, 15 May 2026 16:30:31 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a801:e132:14ba:749b:ce1a:b5a7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910c0ec392bsm669380785a.41.2026.05.15.16.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 16:30:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, antoine.gouby@toradex.com, xiaoning.wang@nxp.com,
 fedor.ross@ifm.com, fberder@outlook.fr, ping.bai@nxp.com,
 Jacky.Cao@sony.com, marek.vasut@mailbox.org, peng.fan@nxp.com,
 simona.toaca@oss.nxp.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260515
Date: Fri, 15 May 2026 20:30:22 -0300
Message-ID: <20260515233022.2898860-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 88338f9d147397c42bb996937b1ce31bca096626:

  gpio: Correct dependencies for MCP230xx (2026-05-14 15:54:17 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260515

for you to fetch changes up to 9e46861a01dd0a011616bf219f393303580dcd8b:

  net: fsl_enetc: Add support for i.MX952 (2026-05-15 17:31:40 -0300)

u-boot-imx-next-20260515
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30134

- Several conversions to OF_UPSTREAM.
- Added i.MX9 Quickboot support.
- Added support for i.MX952 in the fsl_enetc driver.
- Update i.MX91 part number detection.
----------------------------------------------------------------
Antoine Gouby (2):
      board: toradex: smarc-imx95: remove gpio1 reg
      board: toradex: verdin-imx95: remove gpio1 reg

Clark Wang (1):
      net: fsl_enetc: fix the duplex setting on the iMX platform

Fedor Ross (1):
      imx9: scmi: soc: Add support for detecting primary/secondary bmode on MX95

Francois Berder (1):
      power: regulator: pfuze100: Fix unchecked pmic_reg_read, return value

Jacky Bai (1):
      imx8mp_evk: Fix the ND mode VDD_SOC voltage

Jacky Cao (1):
      nitrogen6x: Fix compile error if VIDEO_IPUV3 is disabled

Marek Vasut (3):
      MAINTAINERS: Use N: for NXP entry
      imx: Add SPI NOR A/B switching support
      arm: mx6: cm-fx6: Staticize and constify driver ops

Peng Fan (8):
      imx8mq: reform2: Switch to OF_UPSTREAM
      imx8mq: phanbell: Switch OF_UPSTREAM
      imx8mq: pico: Switch OF_UPSTREAM
      imx8mq: librem5: Switch to OF_UPSTREAM
      imx8mq: kontron-pitx-imx8m: Switch OF_UPSTREAM
      imx8mq: Drop arch/arm/dts/imx8mq.dtsi
      imx8mm/n: Drop unused dtsi
      arm: mx6: module_fuse: update node path for Linux 6.13

Simona Toaca (4):
      imx9: Add support for saving DDR training data to NVM
      arm: mach-imx: Add command to expose QB functionality
      board: nxp: imx9{4, 5, 52}_evk: Add qb save option in SPL
      doc: board: nxp: Add Quickboot documentation

Ye Li (8):
      imx9: scmi: Support iMX95/94/952 secondary boot
      net: phy: nxp-c45-tja11xx: Fix incorrect usage of devm_kzalloc
      i2c: imx_lpi2c: Fix MSR status check issue in STOP
      imx9: clock: Fix missing break in get_clk_src_rate
      imx: ahab: Use authenticated header for images loading
      imx: priblob: Fix build break
      arm: imx9: Update i.MX91 part number detection
      net: fsl_enetc: Add support for i.MX952

 MAINTAINERS                                      |   21 +-
 arch/arm/dts/Makefile                            |    7 +-
 arch/arm/dts/imx8mm-beacon-baseboard.dtsi        |  437 ------
 arch/arm/dts/imx8mn-beacon-baseboard.dtsi        |  309 -----
 arch/arm/dts/imx8mn-evk.dtsi                     |  533 -------
 arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts       |  613 --------
 arch/arm/dts/imx8mq-librem5-r3.dtsi              |   45 -
 arch/arm/dts/imx8mq-librem5-r4.dts               |   27 -
 arch/arm/dts/imx8mq-librem5.dtsi                 | 1382 ------------------
 arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi      |    4 +
 arch/arm/dts/imx8mq-mnt-reform2.dts              |  354 -----
 arch/arm/dts/imx8mq-nitrogen-som.dtsi            |  278 ----
 arch/arm/dts/imx8mq-phanbell.dts                 |  481 -------
 arch/arm/dts/imx8mq-pico-pi.dts                  |  418 ------
 arch/arm/dts/imx8mq.dtsi                         | 1615 ----------------------
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |    1 -
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   |    1 -
 arch/arm/include/asm/arch-imx9/ddr.h             |   48 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h       |    4 +
 arch/arm/include/asm/mach-imx/ahab.h             |    2 +-
 arch/arm/include/asm/mach-imx/qb.h               |   15 +
 arch/arm/mach-imx/Kconfig                        |   30 +-
 arch/arm/mach-imx/Makefile                       |    1 +
 arch/arm/mach-imx/cmd_qb.c                       |  102 ++
 arch/arm/mach-imx/ele_ahab.c                     |   12 +-
 arch/arm/mach-imx/image-container.c              |   19 +-
 arch/arm/mach-imx/imx8/ahab.c                    |   16 +-
 arch/arm/mach-imx/imx8m/Kconfig                  |    5 +
 arch/arm/mach-imx/imx9/Makefile                  |    6 +-
 arch/arm/mach-imx/imx9/clock.c                   |    1 +
 arch/arm/mach-imx/imx9/qb.c                      |  403 ++++++
 arch/arm/mach-imx/imx9/scmi/soc.c                |   47 +
 arch/arm/mach-imx/imx9/soc.c                     |   21 +-
 arch/arm/mach-imx/mx6/module_fuse.c              |   97 ++
 arch/arm/mach-imx/priblob.c                      |    1 +
 board/boundary/nitrogen6x/nitrogen6x.c           |    2 +
 board/compulab/cm_fx6/cm_fx6.c                   |    2 +-
 board/kontron/pitx_imx8m/MAINTAINERS             |    1 -
 board/nxp/imx8mp_evk/spl.c                       |    2 +-
 board/nxp/imx94_evk/spl.c                        |    6 +-
 board/nxp/imx952_evk/spl.c                       |    4 +
 board/nxp/imx95_evk/spl.c                        |    6 +-
 board/purism/librem5/MAINTAINERS                 |    1 -
 common/spl/spl_imx_container.c                   |   13 +-
 configs/imx8mq_phanbell_defconfig                |    2 +-
 configs/imx8mq_reform2_defconfig                 |    2 +-
 configs/kontron_pitx_imx8m_defconfig             |    2 +-
 configs/librem5_defconfig                        |    2 +-
 configs/pico-imx8mq_defconfig                    |    2 +-
 doc/board/nxp/index.rst                          |    1 +
 doc/board/nxp/quickboot.rst                      |   59 +
 drivers/ddr/imx/imx9/Kconfig                     |    7 +
 drivers/i2c/imx_lpi2c.c                          |    4 +-
 drivers/net/Kconfig                              |    4 +-
 drivers/net/fsl_enetc.c                          |   46 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c            |   72 +
 drivers/net/phy/nxp-c45-tja11xx.c                |    2 +-
 drivers/power/regulator/pfuze100.c               |    2 +
 58 files changed, 1018 insertions(+), 6582 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-beacon-baseboard.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-beacon-baseboard.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-evk.dtsi
 delete mode 100644 arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts
 delete mode 100644 arch/arm/dts/imx8mq-librem5-r3.dtsi
 delete mode 100644 arch/arm/dts/imx8mq-librem5-r4.dts
 delete mode 100644 arch/arm/dts/imx8mq-librem5.dtsi
 delete mode 100644 arch/arm/dts/imx8mq-mnt-reform2.dts
 delete mode 100644 arch/arm/dts/imx8mq-nitrogen-som.dtsi
 delete mode 100644 arch/arm/dts/imx8mq-phanbell.dts
 delete mode 100644 arch/arm/dts/imx8mq-pico-pi.dts
 delete mode 100644 arch/arm/dts/imx8mq.dtsi
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/cmd_qb.c
 create mode 100644 arch/arm/mach-imx/imx9/qb.c
 create mode 100644 doc/board/nxp/quickboot.rst
