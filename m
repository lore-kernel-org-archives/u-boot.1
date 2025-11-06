Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDE1CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 22:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD4A83C0E;
	Thu,  6 Nov 2025 23:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fz02Bljp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Qao3/7/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1204C83C13; Thu,  6 Nov 2025 23:10:52 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2D883C0C
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 23:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d2bx52BN5z9tkB;
 Thu,  6 Nov 2025 23:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762467049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R5nsUKOmN6DVX5DQBwluKF6MESXnK51exYSVBRQYpc8=;
 b=fz02BljpmRVJ9JgqRe7KEZX4BUEUgcz5Np14e+czj6PLLM+8ax1WhZl6LCllYDNrJ5VeYy
 gezpT6mKAVDvarVoQkKOoDMcv1pc5ad8Vs1vj6uOBnoF1z6yNn6h5+wPDAzAwCrSurj/uF
 G83YkaO7c3REOac4ZAdi7N76iom+4axNffH+903VGl4lwCloZQpZi7J7mCmfEhiXmiBRHw
 14GUwV4qlxvvbLh8Pd0eFQcBRBeYsdonmAFpfa6G+DopBxh68bpnMCWu8aYS+oIkhtyn0o
 syPwAwe0ce35yJUrghfs/c1HYMa1rcsaTCjGiXjyqYU2bGHTV6Tjwp/HXbBPGw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762467047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R5nsUKOmN6DVX5DQBwluKF6MESXnK51exYSVBRQYpc8=;
 b=Qao3/7/3L+bTmXoZRpiDqVQfURyp4HU2FaQqEjF7P4FQTO9LL3TmBA23qXov+GuiMv5mSK
 wCsxmAsv63SV8GSbwtBl5V45hiSyXmp9DBMarL6Xi8Dmgx7HsefnYtcmCX88vw8bMqWsRG
 uGnlunB/Evzo9vNDoV+roXN/m5FNmZKEBOVEoCEWWuK+stjWFG1FLhyYTBdyTyworQ/3K9
 9Joa/8/ou8hDBaGoc+htd/ttJIdkqCUdPLqI3oaTT0vMidrUbKVJ52s0mE+vKY47Ciccw5
 01IeSiCLhRCvf5CgDtCFcKGyU739SMYL0RQlybDMpvqs5qr2yiRNG4RLKErknA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Thu,  6 Nov 2025 23:05:47 +0100
Message-ID: <20251106221010.373101-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6cb73361f4485eaa584
X-MBO-RS-META: 6as5zjz7q3kg9hrzdcr7nc5ot8b4rjpm
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

This is mostly R-Car Gen5 drivers for GPIO, pin control, RSwitch3
and matching PHYs. There is also a few trivial clean ups for arch
headers and configs. Board code, DT and clock are coming in follow
up PR.

The following changes since commit c488907f91ec90bb6a93803b1db53e24b93b52ea:

  Invalidate cached FAT device upon boot error (2025-11-06 08:31:34 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 057b1f8df9b5f6dced7f7db353a175744bf26031:

  arm64: renesas: Clean up default boot command (2025-11-06 20:13:52 +0100)

----------------------------------------------------------------
Hai Pham (4):
      pinctrl: renesas: Show bit position in config write
      pinctrl: renesas: Move drive strength configuration into sh_pfc_soc_operations
      arm64: renesas: Make CONFIG_SYS_LOAD_ADDR family-specific
      arm64: renesas: Use reset macro from common header

Huy Bui (2):
      gpio: renesas: Add R-Car Gen5 support
      pinctrl: renesas: Add initial R8A78000 R-Car X5H PFC tables

Marek Vasut (20):
      net: rswitch: Switch indent from spaces to tabs
      net: rswitch: Drop unused macros
      net: rswitch: Initialize RX DMA descriptor .die_dt field to DT_FEMPTY
      net: rswitch: Use bulk clock operations
      net: rswitch: Add support for split MII and SerDes
      net: rswitch: Parametize COMA, ETHA, GWCA offsets
      net: rswitch: Parametrize port count
      net: rswitch: Parametrize forwarding engine CSD register offset
      net: rswitch: Inline FWRO, CARO, GWRO, TARO, RMRO macros
      net: rswitch: Parametrize GWDCBAC, FWPBFCSDC, CABPIRM register offsets
      net: rswitch: Parametrize MPIC_MDC_CLK_SET clock setting
      net: rswitch: Add Renesas R-Car X5H Ethernet Switch3 support
      gpio: renesas: Drop pfc_offset parsing
      gpio: renesas: Drop unused register macros
      gpio: renesas: Wrap quirks in struct rcar_gpio_data
      gpio: renesas: Access INDT, POSNEG, INEN registers via match data offsets
      pinctrl: renesas: Align Kconfig entry indent
      arm64: renesas: Drop encoded file name from R-Car Gen3/Gen4 header
      arm64: renesas: Use BIT() macro in R-Car Gen3 header
      arm64: renesas: Clean up default boot command

Tam Nguyen (1):
      phy: renesas: Add PCS driver for Renesas R-Car X5H R8A78000

Thanh Quan (1):
      phy: renesas: Add Multi-Protocol PHY driver for R-Car X5H

 .../arm/mach-renesas/include/mach/rcar-gen3-base.h |   12 +-
 .../arm/mach-renesas/include/mach/rcar-gen4-base.h |    4 +-
 arch/arm/mach-renesas/psci-rcar64.c                |    5 +-
 board/renesas/common/gen4-common.c                 |    8 -
 configs/hihope_rzg2_defconfig                      |    2 +-
 configs/r8a77970_eagle_defconfig                   |    2 +-
 configs/r8a77980_condor_defconfig                  |    2 +-
 configs/r8a77990_ebisu_defconfig                   |    2 +-
 configs/r8a77995_draak_defconfig                   |    2 +-
 configs/r8a779a0_falcon_defconfig                  |    2 +-
 configs/r8a779f0_spider_defconfig                  |    2 +-
 configs/r8a779f4_s4sk_defconfig                    |    2 +-
 configs/r8a779g0_whitehawk_defconfig               |    2 +-
 configs/r8a779h0_grayhawk_defconfig                |    2 +-
 configs/rcar3_salvator-x_defconfig                 |    2 +-
 configs/rcar3_ulcb_defconfig                       |    2 +-
 configs/renesas_rcar3.config                       |    1 +
 configs/renesas_rcar4.config                       |    1 +
 configs/renesas_rcar64.config                      |    1 -
 configs/silinux_ek874_defconfig                    |    2 +-
 drivers/gpio/gpio-rcar.c                           |   84 +-
 drivers/net/Kconfig                                |    5 +-
 drivers/net/rswitch.c                              |  441 +-
 drivers/phy/renesas/Kconfig                        |   12 +
 drivers/phy/renesas/Makefile                       |    2 +
 drivers/phy/renesas/r8a78000-ether-pcs.c           |  424 ++
 drivers/phy/renesas/r8a78000-mp-phy.c              |  225 +
 drivers/pinctrl/renesas/Kconfig                    |   38 +-
 drivers/pinctrl/renesas/Makefile                   |    1 +
 drivers/pinctrl/renesas/pfc-r8a7790.c              |    1 +
 drivers/pinctrl/renesas/pfc-r8a7791.c              |    1 +
 drivers/pinctrl/renesas/pfc-r8a7792.c              |    1 +
 drivers/pinctrl/renesas/pfc-r8a7794.c              |    1 +
 drivers/pinctrl/renesas/pfc-r8a77951.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a7796.c              |    1 +
 drivers/pinctrl/renesas/pfc-r8a77965.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a77970.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a77980.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a77990.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a77995.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a779g0.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a779h0.c             |    1 +
 drivers/pinctrl/renesas/pfc-r8a78000.c             | 5254 ++++++++++++++++++++
 drivers/pinctrl/renesas/pfc.c                      |   24 +-
 drivers/pinctrl/renesas/sh_pfc.h                   |    5 +
 47 files changed, 6318 insertions(+), 270 deletions(-)
 create mode 100644 drivers/phy/renesas/r8a78000-ether-pcs.c
 create mode 100644 drivers/phy/renesas/r8a78000-mp-phy.c
 create mode 100644 drivers/pinctrl/renesas/pfc-r8a78000.c
