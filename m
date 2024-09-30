Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA454CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5A488DFD;
	Mon, 30 Sep 2024 04:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9nCZhCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1DA88D9A; Mon, 30 Sep 2024 03:50:10 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC1C88D9A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-82ce1cd202cso234384639f.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661003; x=1728265803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AlN/u451zfOABO38/xyjscvOUQDpTHpUhjRy6Pvs06U=;
 b=d9nCZhCr0YrZTbzy6/6yIp3o0p/zBbzNjvtQvzwd4y/vc1C7PpNlZbtmYTDgcXi8vm
 KezcxAwti+64nAiQOEe3JqT4wiR6yDr/P1y7WqDiKuARgTtVkm93QzCD/Lo7d0meGwgy
 uXEYj6eYxiqhMY5Za95cjSFZu+U4VzDvhElnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661003; x=1728265803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AlN/u451zfOABO38/xyjscvOUQDpTHpUhjRy6Pvs06U=;
 b=Jyknymzg6vAHqtirAoOC7t1NmvJbKSdRdL2EPfIK7BKQrAdjUBMVvjbL6jiLt74YXE
 hooUiFtoOLJPQj9HYJixFQvCmYXWus5L7qTRVCYnqRmHtJMToA9U5SaWeihYQBncn+qK
 G4LqYoLBOGgpP8v03TdLQg209/cHxsIwt4d8jSjszYf06EB0cuth0MfPlFui1ignm5Ex
 l1jJeb5i4sKwGLITF4WmdDuIjOQ5CeOnzAnaFQuov+ZFfQZRxMR7Cuvm3J/B8dbv0Cbe
 xMLPBpYD6CJTQKdp/cWeXZw06HhC9Fi8VGUpvXoUs8/Cak1+b+cXJxDKHxfDoQEv+pwT
 00oQ==
X-Gm-Message-State: AOJu0Ywk2zDlY3+94bp0VmhdAq7hFoZsFZCXMn1s5TgifidEiIeSTuHP
 aYfTkJzoPwgGYMG30MOrGwcGD0UvxvY9fDWHpifjc8+t0nwRwIT6gjL3Ca2Mm40S/Zoifm0T5CV
 fW5Bk
X-Google-Smtp-Source: AGHT+IGp+pJCLOq0YkPRi+/4utPsxXDD/1gpEiC+aZ8I2TpukSI/ksPjFAOZ08pDP+frhgLNt71I6A==
X-Received: by 2002:a92:ca06:0:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a3451bbf5amr79748815ab.18.1727661002734; 
 Sun, 29 Sep 2024 18:50:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Apurva Nandan <a-nandan@ti.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Harald Seiler <hws@denx.de>,
 Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
 Heiko Schocher <hs@denx.de>, Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Ilko Iliev <iliev@ronetix.com>,
 =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Leo <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Randolph <randolph@andestech.com>,
 Richard Hu <richard.hu@technexion.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Teresa Remmet <t.remmet@phytec.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 00/33] Tidy up use of 'SPL' and CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:23 -0600
Message-Id: <20240930014956.1434060-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Sep 2024 04:11:30 +0200
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

When the SPL build-phase was first created it was designed to solve a
particular problem (the need to init SDRAM so that U-Boot proper could
be loaded). It has since expanded to become an important part of U-Boot,
with three phases now present: TPL, VPL and SPL

Due to this history, the term 'SPL' is used to mean both a particular
phase (the one before U-Boot proper) and all the non-proper phases.
This has become confusing.

For a similar reason CONFIG_SPL_BUILD is set to 'y' for all 'SPL'
phases, not just SPL. So code which can only be compiled for actual SPL,
for example, must use something like this:

   #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)

In Makefiles we have similar issues. SPL_ has been used as a variable
which expands to either SPL_ or nothing, to chose between options like
CONFIG_BLK and CONFIG_SPL_BLK. When TPL appeared, a new SPL_TPL variable
was created which expanded to 'SPL_', 'TPL_' or nothing. Later it was
updated to support 'VPL_' as well.

This series starts a change in terminology and usage to resolve the
above issues:

- The word 'xPL' is used instead of 'SPL' to mean a non-proper build
- A new CONFIG_XPL_BUILD define indicates that the current build is an
  'xPL' build
- The existing CONFIG_SPL_BUILD is changed to mean SPL; it is not now
  defined for TPL and VPL phases
- The existing SPL_ Makefile variable is renamed to SPL_
- The existing SPL_TPL Makefile variable is renamed to PHASE_

It should be noted that xpl_phase() can generally be used instead of
the above CONFIGs without a code-space or run-time penalty.

This series does not attempt to convert all of U-Boot to use this new
terminology but it makes a start. In particular, renaming spl.h and
common/spl seems like a bridge too far at this point.

The series is fully bisectable. It has also been checked to ensure there
are no code-size changes on any commit.

Changes in v3:
- Correct the subject to match what the patch changed to do
- Don't update to use SPL_BUILD in the SPL check
- Drop the change in Makefile.xpl since XPL is already defined
- Move earlier in the series
- Move to earlier in the series
- Split into several patches
- Squash in 'x86: Update a comment to mention XPL'

Changes in v2:
- Drop patches not stricly necessary for the conversion
- Move to earlier in the series
- Rebase to -next
- Update cover letter re code size

Simon Glass (33):
  Makefile: Add a u-boot.cfg file for VPL
  boot: Drop unnecessary ifdef for LOAD_FIT
  tegra: Drop dependency on SPL_BUILD
  net: freescale: Drop use of SPL_BUILD dependency
  serial: Make use of the SERIAL define
  stdio: Make use of the SERIAL define
  scripts: Rename Makefile.spl to Makefile.xpl
  scripts: Add some comments about autoconf.mk
  scripts: Define CONFIG_XPL_BUILD for all xPL builds
  qconfig: Add XPL_BUILD to ignored symbols
  xpl: Rename u_boot_first_phase to xpl_is_first_phase()
  xpl: Rename spl_phase to xpl_phase_t
  xpl: Rename spl_phase() to xpl_phase()
  xpl: Rename spl_in_proper() to not_xpl()
  xpl: Add a function to indicate when in xPL
  xpl: Rename spl_next_phase() and spl_prev_phase()
  xpl: Rename spl_phase_prefix() and spl_phase_name()
  log: global: Rename warn_non_spl()
  doc: Update SPL docs for the xPL changes
  README: Drop SoC-specific comment about SPL
  doc: Move init-related things out of README
  doc: Update init docs for the xPL changes
  arch: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD
  board: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD
  drivers: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD
  include: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD
  global: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD
  xpl: Define CONFIG_SPL_BUILD only for the SPL build
  kconfig: binman: Check for SPL instead of XPL
  global: Rename SPL_ to XPL_
  global: Rename SPL_TPL_ to PHASE_
  spl: Rename SPL_TPL_NAME and SPL_TPL_PROMPT
  qconfig: Update tool for new Makefile variables

 Makefile                                      |  14 +--
 README                                        | 100 +-----------------
 arch/arm/Makefile                             |   6 +-
 arch/arm/config.mk                            |  12 +--
 arch/arm/cpu/arm11/Makefile                   |   2 +-
 arch/arm/cpu/arm1176/start.S                  |   2 +-
 arch/arm/cpu/arm920t/Makefile                 |   2 +-
 arch/arm/cpu/arm926ejs/Makefile               |   4 +-
 arch/arm/cpu/arm926ejs/mxs/Makefile           |   4 +-
 arch/arm/cpu/arm926ejs/sunxi/config.mk        |   2 +-
 arch/arm/cpu/armv7/Makefile                   |   4 +-
 arch/arm/cpu/armv7/cpu.c                      |   2 +-
 arch/arm/cpu/armv7/lowlevel_init.S            |   4 +-
 arch/arm/cpu/armv7/s5p-common/Makefile        |   2 +-
 arch/arm/cpu/armv7/start.S                    |   2 +-
 arch/arm/cpu/armv7/sunxi/Makefile             |   4 +-
 arch/arm/cpu/armv8/Makefile                   |  12 +--
 arch/arm/cpu/armv8/cache_v8.c                 |   2 +-
 arch/arm/cpu/armv8/fsl-layerscape/Makefile    |   2 +-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |  14 +--
 .../armv8/fsl-layerscape/fsl_lsch2_speed.c    |   2 +-
 .../armv8/fsl-layerscape/fsl_lsch3_serdes.c   |   6 +-
 arch/arm/cpu/armv8/fsl-layerscape/icid.c      |   6 +-
 arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S  |   6 +-
 .../arm/cpu/armv8/fsl-layerscape/ls1043_ids.c |   2 +-
 .../arm/cpu/armv8/fsl-layerscape/ls1046_ids.c |   2 +-
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |   4 +-
 arch/arm/cpu/armv8/start.S                    |   8 +-
 arch/arm/dts/imx8qm-u-boot.dtsi               |   2 +-
 arch/arm/dts/imx8qxp-u-boot.dtsi              |   2 +-
 .../asm/arch-fsl-layerscape/fsl_icid.h        |   6 +-
 arch/arm/include/asm/arch-imx8/boot0.h        |   2 +-
 arch/arm/include/asm/arch-lpc32xx/sys_proto.h |   2 +-
 arch/arm/include/asm/arch-mx6/litesom.h       |   2 +-
 arch/arm/include/asm/arch-mx6/mx6-ddr.h       |   4 +-
 arch/arm/include/asm/arch-mxs/sys_proto.h     |   2 +-
 arch/arm/include/asm/arch-rk3066/boot0.h      |   4 +-
 arch/arm/include/asm/arch-rockchip/boot0.h    |   6 +-
 .../include/asm/arch-rockchip/cru_rv1126.h    |  10 +-
 arch/arm/include/asm/arch-sunxi/boot0.h       |   4 +-
 arch/arm/include/asm/arch-sunxi/sys_proto.h   |   2 +-
 arch/arm/include/asm/fsl_secure_boot.h        |   4 +-
 arch/arm/include/asm/ti-common/sys_proto.h    |   2 +-
 arch/arm/lib/Makefile                         |  20 ++--
 arch/arm/lib/cache.c                          |   2 +-
 arch/arm/lib/crt0.S                           |  14 +--
 arch/arm/lib/crt0_64.S                        |  10 +-
 arch/arm/lib/eabi_compat.c                    |   2 +-
 arch/arm/lib/stack.c                          |   2 +-
 arch/arm/lib/vectors.S                        |   6 +-
 arch/arm/lib/zimage.c                         |   4 +-
 arch/arm/mach-aspeed/ast2600/Makefile         |   2 +-
 arch/arm/mach-aspeed/ast2600/lowlevel_init.S  |   2 +-
 arch/arm/mach-at91/Makefile                   |   2 +-
 arch/arm/mach-at91/arm926ejs/Makefile         |   4 +-
 arch/arm/mach-at91/config.mk                  |   2 +-
 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/config.mk               |   2 +-
 arch/arm/mach-davinci/misc.c                  |   2 +-
 arch/arm/mach-exynos/Makefile                 |   2 +-
 arch/arm/mach-exynos/lowlevel_init.c          |   4 +-
 arch/arm/mach-exynos/pinmux.c                 |   2 +-
 arch/arm/mach-imx/Makefile                    |  20 ++--
 arch/arm/mach-imx/cpu.c                       |   6 +-
 arch/arm/mach-imx/hab.c                       |   8 +-
 arch/arm/mach-imx/imx8/cpu.c                  |   4 +-
 arch/arm/mach-imx/imx8m/clock_imx8mm.c        |   2 +-
 arch/arm/mach-imx/imx8m/clock_imx8mq.c        |   4 +-
 arch/arm/mach-imx/imx8m/soc.c                 |  16 +--
 arch/arm/mach-imx/imx8ulp/Makefile            |   2 +-
 arch/arm/mach-imx/imx8ulp/clock.c             |   2 +-
 arch/arm/mach-imx/imx8ulp/lowlevel_init.S     |   2 +-
 arch/arm/mach-imx/imx8ulp/soc.c               |  12 +--
 arch/arm/mach-imx/imx9/Makefile               |   2 +-
 arch/arm/mach-imx/imx9/clock.c                |   4 +-
 arch/arm/mach-imx/imx9/lowlevel_init.S        |   2 +-
 arch/arm/mach-imx/imx9/soc.c                  |  12 +--
 arch/arm/mach-imx/mx5/clock.c                 |   2 +-
 arch/arm/mach-imx/mx6/Makefile                |   2 +-
 arch/arm/mach-imx/mx6/clock.c                 |   2 +-
 arch/arm/mach-imx/mx6/litesom.c               |   2 +-
 arch/arm/mach-imx/mx6/opos6ul.c               |   4 +-
 arch/arm/mach-imx/mx6/soc.c                   |   6 +-
 arch/arm/mach-imx/mx7/clock.c                 |   2 +-
 arch/arm/mach-imx/mx7/soc.c                   |   4 +-
 arch/arm/mach-imx/mx7ulp/clock.c              |   2 +-
 arch/arm/mach-imx/mx7ulp/soc.c                |   2 +-
 arch/arm/mach-imx/syscounter.c                |   2 +-
 arch/arm/mach-k3/am62ax/Makefile              |   2 +-
 arch/arm/mach-k3/am62px/Makefile              |   2 +-
 arch/arm/mach-k3/am62x/Makefile               |   2 +-
 arch/arm/mach-k3/am64x/Makefile               |   2 +-
 arch/arm/mach-k3/am65x/Makefile               |   2 +-
 arch/arm/mach-k3/arm64/cache.S                |   2 +-
 arch/arm/mach-k3/j721e/Makefile               |   2 +-
 arch/arm/mach-k3/j721s2/Makefile              |   2 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c         |   2 +-
 arch/arm/mach-k3/j722s/Makefile               |   2 +-
 arch/arm/mach-k3/j784s4/Makefile              |   2 +-
 arch/arm/mach-k3/r5/Makefile                  |   2 +-
 arch/arm/mach-k3/security.c                   |   2 +-
 arch/arm/mach-keystone/Makefile               |   2 +-
 arch/arm/mach-keystone/config.mk              |   4 +-
 arch/arm/mach-keystone/mon.c                  |   2 +-
 arch/arm/mach-lpc32xx/Makefile                |   2 +-
 arch/arm/mach-mediatek/Makefile               |   2 +-
 arch/arm/mach-mediatek/mt7629/lowlevel_init.S |   2 +-
 arch/arm/mach-mvebu/Makefile                  |   8 +-
 arch/arm/mach-mvebu/cpu.c                     |   4 +-
 arch/arm/mach-mvebu/include/mach/cpu.h        |   8 +-
 arch/arm/mach-mvebu/include/mach/soc.h        |   2 +-
 arch/arm/mach-mvebu/serdes/a38x/Makefile      |   8 +-
 arch/arm/mach-mvebu/serdes/axp/Makefile       |   4 +-
 arch/arm/mach-nexell/include/mach/display.h   |   2 +-
 arch/arm/mach-omap2/Makefile                  |   4 +-
 arch/arm/mach-omap2/am33xx/Makefile           |   2 +-
 arch/arm/mach-omap2/am33xx/board.c            |  20 ++--
 arch/arm/mach-omap2/boot-common.c             |   6 +-
 arch/arm/mach-omap2/clocks-common.c           |   2 +-
 arch/arm/mach-omap2/config.mk                 |   2 +-
 arch/arm/mach-omap2/config_secure.mk          |   2 +-
 arch/arm/mach-omap2/hwinit-common.c           |  14 +--
 arch/arm/mach-omap2/omap3/Makefile            |   2 +-
 arch/arm/mach-omap2/omap3/board.c             |   6 +-
 arch/arm/mach-omap2/omap3/sdrc.c              |   4 +-
 arch/arm/mach-omap2/omap5/hwinit.c            |   2 +-
 arch/arm/mach-omap2/sec-common.c              |   2 +-
 arch/arm/mach-orion5x/Makefile                |   4 +-
 arch/arm/mach-orion5x/cpu.c                   |   2 +-
 arch/arm/mach-orion5x/lowlevel_init.S         |   4 +-
 arch/arm/mach-renesas/include/mach/boot0.h    |   2 +-
 arch/arm/mach-renesas/lowlevel_init_ca15.S    |   2 +-
 arch/arm/mach-rockchip/Makefile               |   6 +-
 arch/arm/mach-rockchip/px30/px30.c            |   2 +-
 arch/arm/mach-rockchip/rk3036/Makefile        |   2 +-
 arch/arm/mach-rockchip/rk3066/rk3066.c        |   2 +-
 arch/arm/mach-rockchip/rk3188/rk3188.c        |   4 +-
 arch/arm/mach-rockchip/rk322x/rk322x.c        |   2 +-
 arch/arm/mach-rockchip/rk3288/rk3288.c        |   4 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c        |   2 +-
 arch/arm/mach-rockchip/rk3328/rk3328.c        |   2 +-
 arch/arm/mach-rockchip/rk3368/rk3368.c        |   2 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c        |   8 +-
 arch/arm/mach-rockchip/rk3568/rk3568.c        |   2 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c        |   4 +-
 arch/arm/mach-rockchip/rv1108/Makefile        |   2 +-
 arch/arm/mach-rockchip/rv1126/rv1126.c        |   2 +-
 arch/arm/mach-sc5xx/Makefile                  |   2 +-
 arch/arm/mach-sc5xx/config.mk                 |   2 +-
 arch/arm/mach-socfpga/Makefile                |   2 +-
 arch/arm/mach-socfpga/board.c                 |   6 +-
 arch/arm/mach-socfpga/clock_manager.c         |   2 +-
 arch/arm/mach-socfpga/clock_manager_arria10.c |   2 +-
 arch/arm/mach-socfpga/include/mach/boot0.h    |   2 +-
 .../include/mach/clock_manager_arria10.h      |   2 +-
 arch/arm/mach-socfpga/lowlevel_init_soc64.S   |   2 +-
 arch/arm/mach-socfpga/mailbox_s10.c           |   2 +-
 arch/arm/mach-socfpga/misc.c                  |   2 +-
 arch/arm/mach-socfpga/misc_arria10.c          |   2 +-
 arch/arm/mach-socfpga/misc_gen5.c             |   2 +-
 arch/arm/mach-socfpga/reset_manager_s10.c     |   2 +-
 arch/arm/mach-socfpga/secure_vab.c            |   2 +-
 arch/arm/mach-socfpga/timer_s10.c             |   4 +-
 arch/arm/mach-socfpga/wrap_pll_config_soc64.c |   6 +-
 arch/arm/mach-stm32mp/Makefile                |   2 +-
 arch/arm/mach-stm32mp/bsec.c                  |  12 +--
 arch/arm/mach-stm32mp/stm32mp1/Makefile       |   4 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c          |   6 +-
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c   |   4 +-
 arch/arm/mach-sunxi/Makefile                  |   2 +-
 arch/arm/mach-sunxi/board.c                   |  10 +-
 arch/arm/mach-sunxi/clock_sun4i.c             |   4 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |   4 +-
 arch/arm/mach-sunxi/clock_sun6i.c             |   4 +-
 arch/arm/mach-sunxi/clock_sun8i_a83t.c        |   4 +-
 arch/arm/mach-sunxi/clock_sun9i.c             |   4 +-
 arch/arm/mach-sunxi/gtbus_sun9i.c             |   2 +-
 arch/arm/mach-tegra/Makefile                  |   6 +-
 arch/arm/mach-tegra/board.c                   |   2 +-
 arch/arm/mach-tegra/board2.c                  |   2 +-
 arch/arm/mach-tegra/tegra114/Makefile         |   2 +-
 arch/arm/mach-tegra/tegra124/Kconfig          |   4 +-
 arch/arm/mach-tegra/tegra124/Makefile         |   4 +-
 arch/arm/mach-tegra/tegra20/Makefile          |   4 +-
 arch/arm/mach-tegra/tegra30/Makefile          |   4 +-
 arch/arm/mach-uniphier/Makefile               |   2 +-
 arch/arm/mach-uniphier/arm32/Makefile         |   2 +-
 .../mach-uniphier/boot-device/boot-device.c   |   4 +-
 arch/arm/mach-uniphier/clk/Makefile           |   2 +-
 arch/arm/mach-uniphier/debug-uart/Makefile    |   2 +-
 .../arm/mach-uniphier/debug-uart/debug-uart.c |   4 +-
 arch/arm/mach-uniphier/dram/Makefile          |   2 +-
 arch/arm/mach-zynq/Makefile                   |   2 +-
 arch/arm/mach-zynq/cpu.c                      |   2 +-
 arch/arm/mach-zynqmp/Makefile                 |   8 +-
 arch/arm/mach-zynqmp/cpu.c                    |   4 +-
 arch/microblaze/config.mk                     |   2 +-
 arch/microblaze/cpu/Makefile                  |   2 +-
 arch/microblaze/cpu/start.S                   |   8 +-
 arch/mips/Makefile                            |   2 +-
 arch/mips/config.mk                           |   2 +-
 arch/mips/lib/Makefile                        |   2 +-
 arch/mips/mach-jz47xx/Makefile                |   2 +-
 arch/mips/mach-jz47xx/include/mach/jz4780.h   |   2 +-
 arch/mips/mach-jz47xx/jz4780/jz4780.c         |   4 +-
 arch/mips/mach-jz47xx/start.S                 |   4 +-
 arch/mips/mach-mtmips/Makefile                |   2 +-
 arch/mips/mach-mtmips/cpu.c                   |   2 +-
 arch/mips/mach-mtmips/mt7620/Makefile         |   2 +-
 arch/mips/mach-mtmips/mt7621/Makefile         |   2 +-
 arch/mips/mach-mtmips/mt7628/Makefile         |   2 +-
 arch/powerpc/config.mk                        |   2 +-
 arch/powerpc/cpu/mpc83xx/Makefile             |   2 +-
 arch/powerpc/cpu/mpc83xx/start.S              |   6 +-
 arch/powerpc/cpu/mpc85xx/Makefile             |   4 +-
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c     |   2 +-
 arch/powerpc/cpu/mpc85xx/start.S              |  14 +--
 arch/powerpc/cpu/mpc85xx/tlb.c                |   4 +-
 arch/powerpc/cpu/mpc8xxx/Makefile             |   2 +-
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c           |   4 +-
 arch/powerpc/cpu/mpc8xxx/law.c                |   4 +-
 arch/powerpc/cpu/mpc8xxx/pamu_table.c         |   2 +-
 arch/powerpc/include/asm/fsl_secure_boot.h    |   8 +-
 arch/powerpc/lib/Makefile                     |   6 +-
 arch/riscv/Makefile                           |   2 +-
 arch/riscv/cpu/fu540/Makefile                 |   2 +-
 arch/riscv/cpu/fu740/Makefile                 |   2 +-
 arch/riscv/cpu/jh7110/Makefile                |   2 +-
 arch/riscv/cpu/start.S                        |   8 +-
 arch/riscv/lib/Makefile                       |  24 ++---
 arch/riscv/lib/sifive_cache.c                 |   4 +-
 arch/sandbox/cpu/Makefile                     |   2 +-
 arch/sandbox/cpu/cpu.c                        |   2 +-
 arch/sandbox/cpu/spl.c                        |   8 +-
 arch/sandbox/cpu/start.c                      |   4 +-
 arch/x86/Makefile                             |  10 +-
 arch/x86/config.mk                            |   8 +-
 arch/x86/cpu/Makefile                         |  22 ++--
 arch/x86/cpu/apollolake/Makefile              |  10 +-
 arch/x86/cpu/apollolake/cpu_spl.c             |   4 +-
 arch/x86/cpu/apollolake/fsp_bindings.c        |   4 +-
 arch/x86/cpu/apollolake/hostbridge.c          |   2 +-
 arch/x86/cpu/apollolake/lpc.c                 |   2 +-
 arch/x86/cpu/apollolake/pch.c                 |   2 +-
 arch/x86/cpu/apollolake/pmc.c                 |   4 +-
 arch/x86/cpu/apollolake/punit.c               |   2 +-
 arch/x86/cpu/apollolake/spl.c                 |   2 +-
 arch/x86/cpu/broadwell/Makefile               |  14 +--
 arch/x86/cpu/broadwell/cpu.c                  |   2 +-
 arch/x86/cpu/broadwell/cpu_full.c             |   2 +-
 arch/x86/cpu/broadwell/pch.c                  |   2 +-
 arch/x86/cpu/config.mk                        |   2 +-
 arch/x86/cpu/coreboot/Makefile                |   2 +-
 arch/x86/cpu/coreboot/coreboot.c              |   2 +-
 arch/x86/cpu/cpu.c                            |   4 +-
 arch/x86/cpu/i386/cpu.c                       |   2 +-
 arch/x86/cpu/intel_common/Makefile            |  20 ++--
 arch/x86/cpu/intel_common/mrc.c               |   2 +-
 arch/x86/cpu/intel_common/p2sb.c              |   6 +-
 arch/x86/cpu/ivybridge/Makefile               |   8 +-
 arch/x86/cpu/qemu/Makefile                    |   2 +-
 arch/x86/include/asm/string.h                 |   2 +-
 arch/x86/lib/Makefile                         |  20 ++--
 arch/x86/lib/fsp/Makefile                     |   2 +-
 arch/x86/lib/fsp2/fsp_dram.c                  |   2 +-
 arch/x86/lib/fsp2/fsp_init.c                  |   4 +-
 arch/x86/lib/tpl.c                            |   2 +-
 board/BuR/brppt1/Makefile                     |   2 +-
 board/BuR/brppt1/board.c                      |   4 +-
 board/BuR/brppt2/board.c                      |   6 +-
 board/BuR/brppt2/config.mk                    |   2 +-
 board/BuR/brsmarc1/Makefile                   |   2 +-
 board/BuR/brsmarc1/board.c                    |   8 +-
 board/BuR/brxre1/Makefile                     |   2 +-
 board/BuR/brxre1/board.c                      |   4 +-
 board/BuR/common/common.c                     |   4 +-
 board/CZ.NIC/turris_1x/Makefile               |   2 +-
 board/CZ.NIC/turris_1x/tlb.c                  |   2 +-
 board/CZ.NIC/turris_omnia/Makefile            |   2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c      |   2 +-
 board/Synology/ds414/Makefile                 |   2 +-
 board/advantech/imx8mp_rsb3720a1/Makefile     |   4 +-
 board/advantech/imx8qm_dmsse20_a1/Makefile    |   2 +-
 board/advantech/imx8qm_rom7720_a1/Makefile    |   2 +-
 board/alliedtelesis/x530/Makefile             |   2 +-
 board/asus/grouper/Makefile                   |   2 +-
 board/asus/transformer-t30/Makefile           |   2 +-
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |   2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |   2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |   2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |   2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |   2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c         |   2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |   2 +-
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |   2 +-
 board/atmel/sama5d3xek/sama5d3xek.c           |   2 +-
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |   2 +-
 board/atmel/sama5d4ek/sama5d4ek.c             |   2 +-
 board/avionic-design/tec-ng/Makefile          |   2 +-
 board/beacon/imx8mm/Makefile                  |   2 +-
 board/beacon/imx8mn/Makefile                  |   2 +-
 board/beacon/imx8mp/Makefile                  |   2 +-
 board/bitmain/antminer_s9/Makefile            |   2 +-
 board/bosch/acc/acc.c                         |   2 +-
 board/bosch/guardian/Makefile                 |   2 +-
 board/bosch/shc/board.c                       |   4 +-
 board/bsh/imx6ulz_smm_m2/Makefile             |   2 +-
 board/bsh/imx8mn_smm_s2/Makefile              |   2 +-
 board/bticino/mamoj/Makefile                  |   2 +-
 board/cloos/imx8mm_phg/Makefile               |   2 +-
 board/compulab/cl-som-imx7/Makefile           |   2 +-
 board/compulab/cl-som-imx7/common.h           |   4 +-
 board/compulab/cl-som-imx7/mux.c              |   4 +-
 board/compulab/cm_fx6/Makefile                |   2 +-
 board/compulab/cm_t43/Makefile                |   2 +-
 board/compulab/imx8mm-cl-iot-gate/Makefile    |   2 +-
 .../compulab/imx8mm-cl-iot-gate/eeprom_spl.c  |   2 +-
 board/comvetia/lxr2/lxr2.c                    |   2 +-
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |   2 +-
 board/congatec/cgtqmx8/Makefile               |   2 +-
 board/congatec/common/Makefile                |   2 +-
 board/coreboot/coreboot/Makefile              |   2 +-
 board/data_modul/common/common.c              |   2 +-
 board/data_modul/imx8mm_edm_sbc/Makefile      |   2 +-
 board/data_modul/imx8mp_edm_sbc/Makefile      |   2 +-
 board/davinci/da8xxevm/omapl138_lcdk.c        |   2 +-
 board/dhelectronics/dh_imx6/Makefile          |   2 +-
 board/dhelectronics/dh_imx8mp/Makefile        |   2 +-
 board/dhelectronics/dh_stm32mp1/board.c       |   6 +-
 board/ea/mx7ulp_com/mx7ulp_com.c              |   2 +-
 board/eets/pdu001/board.c                     |   2 +-
 board/embest/mx6boards/mx6boards.c            |   2 +-
 board/engicam/common/Makefile                 |   2 +-
 board/engicam/imx8mm/Makefile                 |   2 +-
 board/engicam/imx8mp/Makefile                 |   2 +-
 board/engicam/stm32mp1/Makefile               |   2 +-
 board/firefly/firefly-rk3288/firefly-rk3288.c |   2 +-
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   |   2 +-
 board/freescale/common/Makefile               |  10 +-
 board/freescale/common/cmd_esbc_validate.c    |   2 +-
 board/freescale/common/fsl_chain_of_trust.c   |   8 +-
 board/freescale/common/fsl_validate.c         |   4 +-
 board/freescale/common/qixis.c                |   2 +-
 board/freescale/imx8mm_evk/Makefile           |   2 +-
 board/freescale/imx8mn_evk/Makefile           |   2 +-
 board/freescale/imx8mp_evk/Makefile           |   2 +-
 board/freescale/imx8mq_evk/Makefile           |   2 +-
 board/freescale/imx8qm_mek/Makefile           |   2 +-
 board/freescale/imx8qxp_mek/Makefile          |   2 +-
 board/freescale/imx8ulp_evk/Makefile          |   2 +-
 board/freescale/imx93_evk/Makefile            |   2 +-
 board/freescale/imxrt1020-evk/imxrt1020-evk.c |   2 +-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c |   2 +-
 board/freescale/imxrt1170-evk/imxrt1170-evk.c |   2 +-
 board/freescale/ls1012afrdm/ls1012afrdm.c     |   2 +-
 board/freescale/ls1012aqds/ls1012aqds.c       |   2 +-
 board/freescale/ls1012ardb/ls1012ardb.c       |   2 +-
 board/freescale/ls1021aiot/ls1021aiot.c       |   4 +-
 board/freescale/ls1021aqds/ddr.c              |   4 +-
 board/freescale/ls1021aqds/ls1021aqds.c       |   2 +-
 board/freescale/ls1021atsn/ls1021atsn.c       |  10 +-
 board/freescale/ls1021atwr/ls1021atwr.c       |  10 +-
 board/freescale/ls1028a/ls1028a.c             |   2 +-
 board/freescale/ls1043aqds/Makefile           |   2 +-
 board/freescale/ls1043aqds/ddr.c              |   2 +-
 board/freescale/ls1043aqds/ls1043aqds.c       |   2 +-
 board/freescale/ls1043ardb/Makefile           |   2 +-
 board/freescale/ls1043ardb/ddr.c              |   4 +-
 board/freescale/ls1043ardb/ls1043ardb.c       |   2 +-
 board/freescale/ls1046aqds/Makefile           |   2 +-
 board/freescale/ls1046aqds/ddr.c              |   2 +-
 board/freescale/ls1046aqds/ls1046aqds.c       |   2 +-
 board/freescale/ls1046ardb/Makefile           |   2 +-
 board/freescale/ls1046ardb/ddr.c              |   2 +-
 board/freescale/ls1046ardb/ls1046ardb.c       |   2 +-
 board/freescale/ls1088a/Makefile              |   2 +-
 board/freescale/ls1088a/ddr.c                 |   6 +-
 board/freescale/ls1088a/ls1088a.c             |   8 +-
 board/freescale/ls2080aqds/ddr.c              |   2 +-
 board/freescale/ls2080aqds/ls2080aqds.c       |   4 +-
 board/freescale/ls2080ardb/ddr.c              |   2 +-
 board/freescale/ls2080ardb/eth_ls2080rdb.c    |   2 +-
 board/freescale/lx2160a/lx2160a.c             |   2 +-
 board/freescale/mx23evk/Makefile              |   2 +-
 board/freescale/mx28evk/Makefile              |   2 +-
 board/freescale/mx6memcal/Makefile            |   2 +-
 board/freescale/mx6sabreauto/mx6sabreauto.c   |   2 +-
 board/freescale/mx6sabresd/mx6sabresd.c       |   2 +-
 board/freescale/mx6slevk/mx6slevk.c           |   4 +-
 .../mx6ul_14x14_evk/mx6ul_14x14_evk.c         |   4 +-
 board/freescale/p1010rdb/Makefile             |   4 +-
 board/freescale/p1010rdb/p1010rdb.c           |   2 +-
 board/freescale/p1010rdb/tlb.c                |   2 +-
 board/freescale/p1_p2_rdb_pc/Makefile         |   4 +-
 board/freescale/p1_p2_rdb_pc/tlb.c            |   2 +-
 board/freescale/t102xrdb/Makefile             |   2 +-
 board/freescale/t102xrdb/ddr.c                |   4 +-
 board/freescale/t102xrdb/tlb.c                |   4 +-
 board/freescale/t104xrdb/Makefile             |   2 +-
 board/freescale/t104xrdb/ddr.c                |   4 +-
 board/freescale/t104xrdb/tlb.c                |   6 +-
 board/freescale/t208xqds/Makefile             |   2 +-
 board/freescale/t208xqds/ddr.c                |   2 +-
 board/freescale/t208xqds/tlb.c                |   4 +-
 board/freescale/t208xrdb/Makefile             |   2 +-
 board/freescale/t208xrdb/ddr.c                |   2 +-
 board/freescale/t208xrdb/tlb.c                |   4 +-
 board/freescale/t4rdb/Makefile                |   2 +-
 board/freescale/t4rdb/cpld.c                  |   2 +-
 board/freescale/t4rdb/ddr.c                   |   2 +-
 board/freescale/t4rdb/tlb.c                   |   4 +-
 board/gardena/smart-gateway-at91sam/Makefile  |   2 +-
 board/gardena/smart-gateway-mt7688/board.c    |   2 +-
 board/gateworks/gw_ventana/Makefile           |   2 +-
 board/gateworks/gw_ventana/eeprom.c           |   2 +-
 board/gateworks/venice/Makefile               |   2 +-
 board/gdsys/a38x/Makefile                     |   2 +-
 board/gdsys/a38x/controlcenterdc.c            |  12 +--
 board/ge/b1x5v2/b1x5v2.c                      |   4 +-
 board/ge/b1x5v2/spl.c                         |   2 +-
 board/google/chromebook_coral/coral.c         |   2 +-
 board/google/gru/gru.c                        |   4 +-
 board/google/imx8mq_phanbell/Makefile         |   2 +-
 board/google/veyron/veyron.c                  |   2 +-
 board/grinn/chiliboard/board.c                |   2 +-
 board/grinn/liteboard/board.c                 |   2 +-
 board/htc/endeavoru/Makefile                  |   2 +-
 board/imgtec/ci20/ci20.c                      |   4 +-
 board/isee/igep003x/Makefile                  |   2 +-
 board/isee/igep003x/board.c                   |   2 +-
 board/isee/igep00x0/Makefile                  |   2 +-
 board/k+p/kp_imx6q_tpc/Makefile               |   2 +-
 board/kontron/pitx_imx8m/Makefile             |   2 +-
 board/kontron/sl-mx6ul/Makefile               |   2 +-
 board/kontron/sl-mx8mm/Makefile               |   2 +-
 board/kontron/sl28/Makefile                   |   4 +-
 board/kontron/sl28/ddr.c                      |   2 +-
 board/kosagi/novena/Makefile                  |   2 +-
 board/lenovo/ideapad-yoga-11/Makefile         |   2 +-
 board/lg/sniper/sniper.c                      |   2 +-
 board/lg/x3-t30/Makefile                      |   2 +-
 board/liebherr/display5/Makefile              |   2 +-
 board/liebherr/mccmon6/Makefile               |   2 +-
 board/liebherr/xea/Makefile                   |   2 +-
 board/liebherr/xea/xea.c                      |   6 +-
 board/logicpd/am3517evm/am3517evm.c           |   2 +-
 board/logicpd/imx6/imx6logic.c                |   2 +-
 board/logicpd/omap3som/omap3logic.c           |   2 +-
 board/menlo/m53menlo/m53menlo.c               |   2 +-
 board/menlo/mx8menlo/Makefile                 |   4 +-
 board/microsoft/surface-rt/Makefile           |   2 +-
 board/mntre/imx8mq_reform2/Makefile           |   2 +-
 board/msc/sm2s_imx8mp/Makefile                |   2 +-
 board/myir/mys_6ulx/Makefile                  |   2 +-
 board/nvidia/beaver/Makefile                  |   2 +-
 board/nvidia/cardhu/Makefile                  |   2 +-
 board/olimex/mx23_olinuxino/Makefile          |   2 +-
 board/opalkelly/zynq/Makefile                 |   2 +-
 board/phytec/common/Makefile                  |   2 +-
 board/phytec/pcl063/Makefile                  |   2 +-
 board/phytec/pcm058/pcm058.c                  |   2 +-
 board/phytec/phycore_am335x_r2/Makefile       |   2 +-
 board/phytec/phycore_am335x_r2/board.c        |   2 +-
 board/phytec/phycore_am62x/phycore-am62x.c    |   2 +-
 board/phytec/phycore_imx8mm/Makefile          |   2 +-
 board/phytec/phycore_imx8mp/Makefile          |   2 +-
 board/phytec/phycore_imx93/Makefile           |   2 +-
 board/polyhex/imx8mp_debix_model_a/Makefile   |   2 +-
 board/purism/librem5/Makefile                 |   2 +-
 board/purism/librem5/librem5.h                |   4 +-
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c   |   4 +-
 board/renesas/alt/Makefile                    |   2 +-
 board/renesas/condor/Makefile                 |   2 +-
 board/renesas/draak/Makefile                  |   2 +-
 board/renesas/eagle/Makefile                  |   2 +-
 board/renesas/ebisu/Makefile                  |   2 +-
 board/renesas/falcon/Makefile                 |   2 +-
 board/renesas/gose/Makefile                   |   2 +-
 board/renesas/koelsch/Makefile                |   2 +-
 board/renesas/lager/Makefile                  |   2 +-
 board/renesas/porter/Makefile                 |   2 +-
 board/renesas/salvator-x/Makefile             |   2 +-
 board/renesas/silk/Makefile                   |   2 +-
 board/renesas/stout/Makefile                  |   2 +-
 board/renesas/ulcb/Makefile                   |   2 +-
 board/renesas/v3hsk/Makefile                  |   2 +-
 board/renesas/v3msk/Makefile                  |   2 +-
 board/ronetix/imx7-cm/Makefile                |   2 +-
 board/ronetix/imx8mq-cm/Makefile              |   2 +-
 board/samsung/common/Makefile                 |   2 +-
 board/samsung/origen/Makefile                 |   2 +-
 board/samsung/smdkv310/Makefile               |   2 +-
 board/seeed/npi_imx6ull/Makefile              |   2 +-
 board/sielaff/imx6dl-sielaff/Makefile         |   2 +-
 board/siemens/capricorn/Makefile              |   2 +-
 board/siemens/capricorn/board.c               |   8 +-
 board/siemens/common/board_am335x.c           |  12 +--
 board/siemens/common/board_am335x.h           |   4 +-
 board/siemens/common/factoryset.c             |   4 +-
 board/siemens/corvus/board.c                  |   2 +-
 board/siemens/draco/Makefile                  |   4 +-
 board/siemens/draco/board.c                   |  14 +--
 board/siemens/pxm2/Makefile                   |   4 +-
 board/siemens/pxm2/board.c                    |  14 +--
 board/siemens/rut/Makefile                    |   4 +-
 board/siemens/rut/board.c                     |   8 +-
 board/siemens/smartweb/smartweb.c             |   2 +-
 board/siemens/taurus/taurus.c                 |   4 +-
 board/sifive/unleashed/Makefile               |   2 +-
 board/sifive/unmatched/Makefile               |   2 +-
 board/silinux/ek874/Makefile                  |   2 +-
 board/softing/vining_2000/vining_2000.c       |   2 +-
 board/softing/vining_fpga/socfpga.c           |   2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |   2 +-
 board/st/common/Makefile                      |   2 +-
 board/st/common/cmd_stboard.c                 |   2 +-
 board/st/stm32f746-disco/stm32f746-disco.c    |   4 +-
 board/st/stm32mp1/Makefile                    |   2 +-
 board/starfive/visionfive2/Makefile           |   2 +-
 board/sunxi/board.c                           |   6 +-
 board/tcl/sl50/Makefile                       |   2 +-
 board/tcl/sl50/board.c                        |  14 +--
 board/technexion/pico-imx6/spl.c              |   2 +-
 board/technexion/pico-imx6ul/spl.c            |   2 +-
 board/technexion/pico-imx7d/spl.c             |   2 +-
 board/technexion/pico-imx8mq/Makefile         |   2 +-
 board/theadorable/theadorable.c               |   6 +-
 .../theobroma-systems/jaguar_rk3588/Makefile  |   2 +-
 board/theobroma-systems/puma_rk3399/Makefile  |   2 +-
 .../theobroma-systems/ringneck_px30/Makefile  |   2 +-
 board/theobroma-systems/tiger_rk3588/Makefile |   2 +-
 board/ti/am335x/Makefile                      |   2 +-
 board/ti/am335x/board.c                       |  12 +--
 board/ti/am43xx/Makefile                      |   2 +-
 board/ti/am57xx/board.c                       |  10 +-
 board/ti/am62x/evm.c                          |   2 +-
 board/ti/am64x/evm.c                          |   2 +-
 board/ti/common/board_detect.c                |   6 +-
 board/ti/dra7xx/evm.c                         |   6 +-
 board/ti/j721e/evm.c                          |   6 +-
 board/ti/j721s2/evm.c                         |   4 +-
 board/ti/ks2_evm/board.c                      |   2 +-
 board/ti/ks2_evm/board_k2e.c                  |   2 +-
 board/ti/ks2_evm/board_k2g.c                  |   4 +-
 board/ti/ks2_evm/board_k2hk.c                 |   2 +-
 board/ti/ks2_evm/board_k2l.c                  |   2 +-
 board/ti/omap3evm/evm.c                       |   4 +-
 board/timll/devkit8000/devkit8000.c           |   2 +-
 board/topic/zynq/Makefile                     |   2 +-
 board/toradex/apalis_imx6/apalis_imx6.c       |  12 +--
 board/toradex/apalis_imx6/do_fuse.c           |   4 +-
 board/toradex/apalis_imx6/pf0100.c            |   4 +-
 board/toradex/apalis_t30/Makefile             |   2 +-
 board/toradex/colibri_imx6/colibri_imx6.c     |  12 +--
 board/toradex/colibri_imx6/do_fuse.c          |   4 +-
 board/toradex/colibri_imx6/pf0100.c           |   4 +-
 board/toradex/colibri_t30/Makefile            |   2 +-
 board/toradex/common/Makefile                 |   2 +-
 board/toradex/verdin-imx8mm/Makefile          |   2 +-
 board/toradex/verdin-imx8mp/Makefile          |   2 +-
 board/udoo/neo/neo.c                          |   2 +-
 board/udoo/udoo_spl.c                         |   2 +-
 board/variscite/common/imx9_eeprom.c          |   2 +-
 board/variscite/dart_6ul/Makefile             |   2 +-
 board/variscite/imx8mn_var_som/Makefile       |   2 +-
 .../variscite/imx8mn_var_som/imx8mn_var_som.c |   4 +-
 board/variscite/imx93_var_som/Makefile        |   2 +-
 board/vscom/baltos/Makefile                   |   2 +-
 board/vscom/baltos/board.c                    |  14 +--
 board/wandboard/Makefile                      |   2 +-
 board/wexler/qc750/Makefile                   |   2 +-
 board/work-microwave/work_92105/Makefile      |   2 +-
 board/xilinx/common/Makefile                  |   2 +-
 board/xilinx/common/board.c                   |   6 +-
 .../microblaze-generic/microblaze-generic.c   |   2 +-
 board/xilinx/zynq/Makefile                    |   6 +-
 board/xilinx/zynq/board.c                     |   4 +-
 board/xilinx/zynqmp/Makefile                  |   8 +-
 board/xilinx/zynqmp/zynqmp.c                  |   6 +-
 boot/Makefile                                 |  86 ++++++++-------
 boot/fdt_simplefb.c                           |   2 +-
 boot/image-android-dt.c                       |   2 +-
 boot/image-android.c                          |   2 +-
 boot/image-fit-sig.c                          |   2 +-
 boot/vbe_simple_fw.c                          |   4 +-
 cmd/Makefile                                  |   6 +-
 cmd/nvedit.c                                  |  12 +--
 cmd/vbe.c                                     |   2 +-
 common/Makefile                               |  42 +++-----
 common/bloblist.c                             |   6 +-
 common/board_f.c                              |   2 +-
 common/bootstage.c                            |   6 +-
 common/cli_readline.c                         |   2 +-
 common/console.c                              |   2 +-
 common/hash.c                                 |   2 +-
 common/init/Makefile                          |   2 +-
 common/spl/Makefile                           |  58 +++++-----
 common/spl/spl.c                              |  61 ++++++-----
 common/spl/spl_fit.c                          |   2 +-
 common/spl/spl_legacy.c                       |   2 +-
 common/splash_source.c                        |   2 +-
 config.mk                                     |   2 +-
 disk/Makefile                                 |  18 ++--
 disk/part.c                                   |   2 +-
 disk/part_dos.c                               |   2 +-
 doc/develop/distro.rst                        |   4 +-
 doc/develop/index.rst                         |   1 +
 doc/develop/init.rst                          |  93 ++++++++++++++++
 doc/develop/logging.rst                       |   2 +-
 doc/develop/qconfig.rst                       |   2 +-
 doc/develop/spl.rst                           |  83 ++++++++-------
 doc/develop/tests_sandbox.rst                 |   2 +-
 doc/develop/tests_writing.rst                 |   6 +-
 doc/device-tree-bindings/bootph.yaml          |   2 +-
 drivers/Makefile                              |  88 +++++++--------
 drivers/adc/Makefile                          |   2 +-
 drivers/ata/Makefile                          |   2 +-
 drivers/block/Makefile                        |  12 +--
 drivers/bus/Makefile                          |   4 +-
 drivers/cache/Makefile                        |   2 +-
 drivers/clk/Makefile                          |  18 ++--
 drivers/clk/altera/clk-agilex.c               |   2 +-
 drivers/clk/altera/clk-agilex5.c              |   2 +-
 drivers/clk/altera/clk-n5x.c                  |   2 +-
 drivers/clk/clk-uclass.c                      |   2 +-
 drivers/clk/clk_vexpress_osc.c                |   4 +-
 drivers/clk/clk_zynq.c                        |  22 ++--
 drivers/clk/exynos/Makefile                   |   2 +-
 drivers/clk/imx/Makefile                      |  20 ++--
 drivers/clk/imx/clk-imx8mm.c                  |   6 +-
 drivers/clk/imx/clk-imx8mn.c                  |   6 +-
 drivers/clk/imx/clk-imxrt1020.c               |   2 +-
 drivers/clk/imx/clk-imxrt1050.c               |   2 +-
 drivers/clk/rockchip/clk_px30.c               |   6 +-
 drivers/clk/rockchip/clk_rk3188.c             |   6 +-
 drivers/clk/rockchip/clk_rk3288.c             |   8 +-
 drivers/clk/rockchip/clk_rk3328.c             |   4 +-
 drivers/clk/rockchip/clk_rk3368.c             |  14 +--
 drivers/clk/rockchip/clk_rk3399.c             |  10 +-
 drivers/clk/rockchip/clk_rk3568.c             |  10 +-
 drivers/clk/rockchip/clk_rk3588.c             |  14 +--
 drivers/clk/sifive/sifive-prci.c              |   2 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   4 +-
 drivers/clk/stm32/clk-stm32mp1.c              |   6 +-
 drivers/clk/ti/Makefile                       |   4 +-
 drivers/core/Makefile                         |  16 +--
 drivers/core/ofnode.c                         |   4 +-
 drivers/crypto/fsl/Makefile                   |   2 +-
 drivers/crypto/fsl/jobdesc.c                  |   2 +-
 drivers/crypto/fsl/jr.c                       |   6 +-
 drivers/ddr/altera/Makefile                   |   2 +-
 drivers/ddr/altera/sdram_gen5.c               |   4 +-
 drivers/ddr/fsl/lc_common_dimm_params.c       |   6 +-
 drivers/ddr/fsl/main.c                        |   6 +-
 drivers/ddr/imx/imx8m/Makefile                |   2 +-
 drivers/ddr/imx/imx8ulp/Makefile              |   2 +-
 drivers/ddr/imx/imx9/Makefile                 |   2 +-
 drivers/ddr/imx/phy/Makefile                  |   2 +-
 drivers/ddr/marvell/a38x/Makefile             |  44 ++++----
 drivers/ddr/marvell/a38x/old/Makefile         |  28 ++---
 drivers/ddr/marvell/axp/Makefile              |  20 ++--
 drivers/dfu/Makefile                          |  16 +--
 drivers/firmware/Makefile                     |   2 +-
 drivers/firmware/firmware-zynqmp.c            |  10 +-
 drivers/fpga/intel_sdm_mb.c                   |   2 +-
 drivers/fpga/zynqpl.c                         |   6 +-
 drivers/gpio/Makefile                         |  16 +--
 drivers/gpio/gpio-uclass.c                    |   4 +-
 drivers/gpio/pca953x.c                        |   2 +-
 drivers/gpio/rk_gpio.c                        |   4 +-
 drivers/gpio/s5p_gpio.c                       |  10 +-
 drivers/gpio/sunxi_gpio.c                     |   2 +-
 drivers/gpio/tca642x.c                        |   2 +-
 drivers/gpio/tegra_gpio.c                     |   2 +-
 drivers/i2c/Makefile                          |  16 +--
 drivers/i2c/designware_i2c_pci.c              |   4 +-
 drivers/input/Makefile                        |   8 +-
 drivers/led/Makefile                          |   2 +-
 drivers/mailbox/Makefile                      |   2 +-
 drivers/mailbox/zynqmp-ipi.c                  |   6 +-
 drivers/misc/Makefile                         |  32 +++---
 drivers/misc/gsc.c                            |   2 +-
 drivers/misc/imx8/scu.c                       |   2 +-
 drivers/misc/p2sb-uclass.c                    |   2 +-
 drivers/mmc/Makefile                          |  14 +--
 drivers/mmc/mmc-uclass.c                      |   4 +-
 drivers/mmc/mmc.c                             |  20 ++--
 drivers/mmc/mmc_legacy.c                      |   4 +-
 drivers/mmc/mmc_private.h                     |   2 +-
 drivers/mmc/omap_hsmmc.c                      |   4 +-
 drivers/mmc/rockchip_dw_mmc.c                 |   2 +-
 drivers/mmc/rockchip_sdhci.c                  |   2 +-
 drivers/mmc/socfpga_dw_mmc.c                  |   2 +-
 drivers/mmc/tmio-common.c                     |   2 +-
 drivers/mmc/uniphier-sd.c                     |   4 +-
 drivers/mmc/zynq_sdhci.c                      |   6 +-
 drivers/mtd/Makefile                          |   6 +-
 drivers/mtd/nand/Makefile                     |   4 +-
 drivers/mtd/nand/raw/Makefile                 |   4 +-
 drivers/mtd/nand/raw/atmel_nand.c             |   4 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   6 +-
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c       |   8 +-
 drivers/mtd/nand/raw/nand_base.c              |  10 +-
 drivers/mtd/nand/raw/omap_gpmc.c              |   4 +-
 drivers/mtd/nand/raw/sand_nand.c              |   4 +-
 drivers/mtd/onenand/Makefile                  |   2 +-
 drivers/mtd/spi/Makefile                      |  10 +-
 drivers/mtd/spi/sf-uclass.c                   |   2 +-
 drivers/mtd/spi/sf_dataflash.c                |   2 +-
 drivers/mtd/spi/spi-nor-core.c                |   4 +-
 drivers/mux/Makefile                          |   2 +-
 drivers/net/Kconfig                           |   2 +-
 drivers/net/dwc_eth_xgmac_socfpga.c           |   2 +-
 drivers/net/dwmac_socfpga.c                   |   2 +-
 drivers/nvme/Makefile                         |   2 +-
 drivers/pci/pci-uclass.c                      |   4 +-
 drivers/pci/pci_rom.c                         |   4 +-
 drivers/phy/Makefile                          |   6 +-
 drivers/phy/cadence/Makefile                  |   4 +-
 drivers/phy/ti/Makefile                       |   2 +-
 drivers/pinctrl/Makefile                      |   8 +-
 drivers/pinctrl/intel/pinctrl.c               |   6 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   4 +-
 drivers/pinctrl/pinctrl_stm32.c               |   4 +-
 drivers/pinctrl/starfive/Makefile             |   4 +-
 drivers/pinctrl/tegra/Makefile                |   2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h   |   2 +-
 drivers/power/Makefile                        |  10 +-
 drivers/power/acpi_pmc/Makefile               |   2 +-
 drivers/power/acpi_pmc/acpi-pmc-uclass.c      |   2 +-
 drivers/power/domain/Makefile                 |   2 +-
 drivers/power/pmic/Makefile                   |  34 +++---
 drivers/power/pmic/rk8xx.c                    |   4 +-
 drivers/power/pmic/stpmic1.c                  |   6 +-
 drivers/power/power_core.c                    |   2 +-
 drivers/power/regulator/Makefile              |  48 ++++-----
 drivers/power/regulator/rk8xx.c               |   2 +-
 drivers/power/sy8106a.c                       |   2 +-
 drivers/ram/Makefile                          |   4 +-
 drivers/ram/mediatek/ddr3-mt7629.c            |   4 +-
 drivers/ram/rockchip/sdram_rk3188.c           |  12 +--
 drivers/ram/rockchip/sdram_rk3288.c           |  12 +--
 drivers/ram/rockchip/sdram_rk3399.c           |   6 +-
 drivers/ram/rockchip/sdram_rv1126.c           |   6 +-
 drivers/ram/sifive/sifive_ddr.c               |   6 +-
 drivers/ram/starfive/Makefile                 |   4 +-
 drivers/ram/stm32mp1/stm32mp1_ram.c           |   2 +-
 drivers/remoteproc/Makefile                   |   2 +-
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-socfpga.c                 |   2 +-
 drivers/rng/Makefile                          |   2 +-
 drivers/rtc/Makefile                          |   6 +-
 drivers/scsi/Makefile                         |   6 +-
 drivers/serial/Makefile                       |   6 +-
 drivers/serial/atmel_usart.c                  |   2 +-
 drivers/serial/ns16550.c                      |   8 +-
 drivers/serial/serial-uclass.c                |   2 +-
 drivers/serial/serial.c                       |   2 +-
 drivers/serial/serial_s5p.c                   |   2 +-
 drivers/serial/serial_zynq.c                  |   2 +-
 drivers/spi/Makefile                          |   2 +-
 drivers/spi/designware_spi.c                  |   4 +-
 drivers/spi/ich.c                             |   4 +-
 drivers/spi/rockchip_sfc.c                    |   2 +-
 drivers/spi/spi-uclass.c                      |   4 +-
 drivers/sysreset/Makefile                     |  14 +--
 drivers/sysreset/sysreset-uclass.c            |   2 +-
 drivers/sysreset/sysreset_ast.c               |   2 +-
 drivers/timer/Makefile                        |   8 +-
 drivers/tpm/Makefile                          |   4 +-
 drivers/usb/cdns3/Makefile                    |   4 +-
 drivers/usb/cdns3/core.c                      |   6 +-
 drivers/usb/common/Makefile                   |   2 +-
 drivers/usb/dwc3/Makefile                     |   4 +-
 drivers/usb/gadget/Makefile                   |  10 +-
 drivers/usb/gadget/f_sdp.c                    |  10 +-
 drivers/usb/gadget/udc/Makefile               |   4 +-
 drivers/usb/host/Makefile                     |   6 +-
 drivers/usb/mtu3/mtu3_plat.c                  |   4 +-
 drivers/video/Makefile                        |  18 ++--
 drivers/video/console_truetype.c              |   6 +-
 drivers/video/tidss/Makefile                  |   2 +-
 drivers/video/video-uclass.c                  |   6 +-
 drivers/watchdog/Makefile                     |   2 +-
 dts/Makefile                                  |   2 +-
 env/Makefile                                  |  24 ++---
 env/common.c                                  |   4 +-
 env/fat.c                                     |   4 +-
 env/flash.c                                   |   6 +-
 env/mmc.c                                     |   6 +-
 env/nand.c                                    |   8 +-
 env/nowhere.c                                 |   2 +-
 env/sf.c                                      |   2 +-
 fs/Makefile                                   |   2 +-
 fs/fat/Makefile                               |   4 +-
 fs/fs.c                                       |   6 +-
 fs/sandbox/Makefile                           |   2 +-
 fs/squashfs/Makefile                          |   2 +-
 include/asm-generic/global_data.h             |   2 +-
 include/bootcount.h                           |   4 +-
 include/config_distro_bootcmd.h               |  10 +-
 include/configs/P1010RDB.h                    |   4 +-
 include/configs/am335x_evm.h                  |   4 +-
 include/configs/am335x_guardian.h             |   4 +-
 include/configs/am335x_shc.h                  |   4 +-
 include/configs/am43xx_evm.h                  |   4 +-
 include/configs/am57xx_evm.h                  |   2 +-
 include/configs/capricorn-common.h            |   4 +-
 include/configs/cgtqmx8.h                     |   2 +-
 include/configs/da850evm.h                    |   2 +-
 include/configs/dra7xx_evm.h                  |   4 +-
 include/configs/ds116.h                       |   4 +-
 include/configs/ds414.h                       |   4 +-
 .../configs/gardena-smart-gateway-mt7688.h    |   2 +-
 include/configs/imx6q-bosch-acc.h             |   2 +-
 include/configs/imx6ulz_smm_m2.h              |   4 +-
 include/configs/imx8mm-cl-iot-gate.h          |   2 +-
 include/configs/imx8mm_beacon.h               |   2 +-
 include/configs/imx8mm_data_modul_edm_sbc.h   |   2 +-
 include/configs/imx8mm_evk.h                  |   2 +-
 include/configs/imx8mm_icore_mx8mm.h          |   4 +-
 include/configs/imx8mm_phg.h                  |   2 +-
 include/configs/imx8mm_venice.h               |   2 +-
 include/configs/imx8mp_rsb3720.h              |   2 +-
 include/configs/imx8mq_cm.h                   |   2 +-
 include/configs/imx8mq_evk.h                  |   2 +-
 include/configs/imx8mq_phanbell.h             |   2 +-
 include/configs/imx8mq_reform2.h              |   2 +-
 include/configs/imx8qm_mek.h                  |   2 +-
 include/configs/imx8qxp_mek.h                 |   2 +-
 include/configs/imx8ulp_evk.h                 |   2 +-
 include/configs/imx93_evk.h                   |   2 +-
 include/configs/kontron-sl-mx8mm.h            |   4 +-
 include/configs/kontron_pitx_imx8m.h          |   2 +-
 include/configs/librem5.h                     |   2 +-
 include/configs/linkit-smart-7688.h           |   2 +-
 include/configs/ls1043a_common.h              |   6 +-
 include/configs/ls1046a_common.h              |   6 +-
 include/configs/ls1088a_common.h              |   2 +-
 include/configs/msc_sm2s_imx8mp.h             |   2 +-
 include/configs/mt7621.h                      |   2 +-
 include/configs/mt7628.h                      |   2 +-
 include/configs/n2350.h                       |   4 +-
 include/configs/p1_p2_rdb_pc.h                |   4 +-
 include/configs/phycore_imx8mm.h              |   2 +-
 include/configs/pico-imx8mq.h                 |   2 +-
 include/configs/rk3399_common.h               |   4 +-
 include/configs/rockchip-common.h             |   2 +-
 include/configs/socfpga_common.h              |   2 +-
 include/configs/stm32mp15_common.h            |   4 +-
 include/configs/stm32mp15_dh_dhsom.h          |   2 +-
 include/configs/ti_omap3_common.h             |   2 +-
 include/configs/ti_omap4_common.h             |   2 +-
 include/configs/turris_1x.h                   |   4 +-
 include/configs/turris_omnia.h                |   4 +-
 include/configs/verdin-imx8mm.h               |   2 +-
 include/configs/verdin-imx8mp.h               |   4 +-
 include/configs/vining_2000.h                 |   2 +-
 include/configs/xilinx_zynqmp.h               |   2 +-
 include/configs/zynq-common.h                 |   4 +-
 include/env.h                                 |   2 +-
 include/env_callback.h                        |   2 +-
 include/fdtdec.h                              |   2 +-
 include/image-android-dt.h                    |   2 +-
 include/iotrace.h                             |   2 +-
 include/linux/kconfig.h                       |   8 +-
 include/log.h                                 |  12 +--
 include/mmc.h                                 |   2 +-
 include/mtd/cfi_flash.h                       |   2 +-
 include/net.h                                 |   6 +-
 include/part.h                                |   2 +-
 include/sdp.h                                 |   2 +-
 include/search.h                              |   2 +-
 include/spl.h                                 |  84 ++++++++-------
 include/stdio.h                               |   5 +-
 include/sunxi_gpio.h                          |   2 +-
 include/upl.h                                 |   4 +-
 include/vbe.h                                 |   2 +-
 lib/Makefile                                  |  68 ++++++------
 lib/acpi/Makefile                             |  10 +-
 lib/aes/Makefile                              |   2 +-
 lib/crypto/Makefile                           |  18 ++--
 lib/display_options.c                         |   2 +-
 lib/ecdsa/Makefile                            |   2 +-
 lib/fdtdec.c                                  |   8 +-
 lib/hang.c                                    |   2 +-
 lib/hashtable.c                               |   4 +-
 lib/hexdump.c                                 |   2 +-
 lib/libfdt/Makefile                           |   2 +-
 lib/lmb.c                                     |   4 +-
 lib/rsa/Makefile                              |   4 +-
 lib/time.c                                    |   2 +-
 lib/uuid.c                                    |   2 +-
 net/Makefile                                  |  12 +--
 net/bootp.c                                   |   2 +-
 net/net.c                                     |   8 +-
 scripts/Kbuild.include                        |  14 +--
 scripts/Makefile.autoconf                     |   6 +-
 scripts/{Makefile.spl => Makefile.xpl}        |  60 ++++++-----
 test/Makefile                                 |  24 ++---
 test/cmd_ut.c                                 |   2 +-
 test/dm/Makefile                              |   6 +-
 test/fuzz/Makefile                            |   2 +-
 test/lib/Makefile                             |   2 +-
 test/test-main.c                              |   2 +-
 tools/qconfig.py                              |  32 +++---
 906 files changed, 2257 insertions(+), 2240 deletions(-)
 create mode 100644 doc/develop/init.rst
 rename scripts/{Makefile.spl => Makefile.xpl} (92%)

-- 
2.34.1

