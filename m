Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D83BCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF5B88E1C;
	Mon, 30 Sep 2024 04:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NYnRN77x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 625DC88F20; Mon, 30 Sep 2024 03:50:47 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F50788ED7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-8349389f9b8so188891439f.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661038; x=1728265838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3PRSqbekHWmzJnBsSGa+zwdfplnnqyiuAIb8HUAIL0=;
 b=NYnRN77xhQcQNF5CQDooKrZ3Klkph3moVQwOCDNE/y61hGUKvE+B+a1VLhALwMCvdf
 zZ3nwN28jGK1N4pMb4G3WnSjm0qrwq9+xQmwbjGwKxoVXGMGw+eblLwheAppL6yoza2t
 L6Y6xEpvE18d0z3ZE/ZwBWBQRxPplPYNo+jSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661038; x=1728265838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3PRSqbekHWmzJnBsSGa+zwdfplnnqyiuAIb8HUAIL0=;
 b=bkCiPIaTqk0vS2N6htN0cDZRil3L63BUjk65pA2wGXft1Cs04L9GL8arHTHRkS8FIP
 KRy/DyzzwVbQ+uUnccqCLNJSFEAoX4xsgzIC71pJrIFonj9vqRHqDCMzbRJkg2oinFcB
 m0M0g917dPco5oZ1wqIXYwf0C8JMh3Lx5xZDFE1S7879kItdsfSfyFGLGKNBwDpLXaTH
 I/OOJz53PPp5GNxJYJzTk62g05G789jDZ840YGZYS29GGJnZoSXTu+0zKhlm+i2xETUc
 Zc24SISiDS3EhlWEl2YpWZTRD+khHUmWaA419wGserWYjZludtsizOJglh4p8890wgw2
 kclg==
X-Gm-Message-State: AOJu0YyQaqekfmlG5kNP7OvDK8zICDtvd0HJQimVDstrv1hYhygGA8FM
 6LGZhCaN3typlaHrzUcJTzsSJuW6Mbt0znDEQz0Bg0Ko2d2baGpebYyyPqWhnisUJD4UCwl1lG9
 g7DNR
X-Google-Smtp-Source: AGHT+IEjWwgrmoeHdtlT6do9o6NstZVX0yDgKA6i07LrBMq9bsNwEINXXbNgKHfKx8PVtmR2J4QlkA==
X-Received: by 2002:a05:6e02:1a6c:b0:3a0:98e9:1b7a with SMTP id
 e9e14a558f8ab-3a34514af43mr74605625ab.2.1727661035961; 
 Sun, 29 Sep 2024 18:50:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Apurva Nandan <a-nandan@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Leo <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Mario Six <mario.six@gdsys.cc>,
 =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 23/33] arch: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:46 -0600
Message-Id: <20240930014956.1434060-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Use the new symbol to refer to any 'SPL' build, including TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split into several patches
- Squash in 'x86: Update a comment to mention XPL'

 arch/arm/Makefile                              |  6 +++---
 arch/arm/config.mk                             |  6 +++---
 arch/arm/cpu/arm11/Makefile                    |  2 +-
 arch/arm/cpu/arm1176/start.S                   |  2 +-
 arch/arm/cpu/arm926ejs/Makefile                |  2 +-
 arch/arm/cpu/arm926ejs/mxs/Makefile            |  4 ++--
 arch/arm/cpu/arm926ejs/sunxi/config.mk         |  2 +-
 arch/arm/cpu/armv7/Makefile                    |  2 +-
 arch/arm/cpu/armv7/cpu.c                       |  2 +-
 arch/arm/cpu/armv7/lowlevel_init.S             |  4 ++--
 arch/arm/cpu/armv7/s5p-common/Makefile         |  2 +-
 arch/arm/cpu/armv7/start.S                     |  2 +-
 arch/arm/cpu/armv7/sunxi/Makefile              |  4 ++--
 arch/arm/cpu/armv8/Makefile                    |  6 +++---
 arch/arm/cpu/armv8/cache_v8.c                  |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/Makefile     |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c        | 14 +++++++-------
 .../cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c |  2 +-
 .../armv8/fsl-layerscape/fsl_lsch3_serdes.c    |  6 +++---
 arch/arm/cpu/armv8/fsl-layerscape/icid.c       |  6 +++---
 arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S   |  6 +++---
 arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/spl.c        |  4 ++--
 arch/arm/cpu/armv8/start.S                     |  8 ++++----
 arch/arm/dts/imx8qm-u-boot.dtsi                |  2 +-
 arch/arm/dts/imx8qxp-u-boot.dtsi               |  2 +-
 .../include/asm/arch-fsl-layerscape/fsl_icid.h |  6 +++---
 arch/arm/include/asm/arch-imx8/boot0.h         |  2 +-
 arch/arm/include/asm/arch-lpc32xx/sys_proto.h  |  2 +-
 arch/arm/include/asm/arch-mx6/litesom.h        |  2 +-
 arch/arm/include/asm/arch-mx6/mx6-ddr.h        |  4 ++--
 arch/arm/include/asm/arch-mxs/sys_proto.h      |  2 +-
 arch/arm/include/asm/arch-rk3066/boot0.h       |  4 ++--
 arch/arm/include/asm/arch-rockchip/boot0.h     |  6 +++---
 .../arm/include/asm/arch-rockchip/cru_rv1126.h | 10 +++++-----
 arch/arm/include/asm/arch-sunxi/boot0.h        |  4 ++--
 arch/arm/include/asm/arch-sunxi/sys_proto.h    |  2 +-
 arch/arm/include/asm/fsl_secure_boot.h         |  4 ++--
 arch/arm/include/asm/ti-common/sys_proto.h     |  2 +-
 arch/arm/lib/Makefile                          |  2 +-
 arch/arm/lib/crt0.S                            | 14 +++++++-------
 arch/arm/lib/crt0_64.S                         | 10 +++++-----
 arch/arm/lib/eabi_compat.c                     |  2 +-
 arch/arm/lib/stack.c                           |  2 +-
 arch/arm/lib/vectors.S                         |  6 +++---
 arch/arm/lib/zimage.c                          |  4 ++--
 arch/arm/mach-aspeed/ast2600/Makefile          |  2 +-
 arch/arm/mach-aspeed/ast2600/lowlevel_init.S   |  2 +-
 arch/arm/mach-at91/Makefile                    |  2 +-
 arch/arm/mach-at91/config.mk                   |  2 +-
 arch/arm/mach-davinci/Makefile                 |  2 +-
 arch/arm/mach-davinci/config.mk                |  2 +-
 arch/arm/mach-davinci/misc.c                   |  2 +-
 arch/arm/mach-exynos/Makefile                  |  2 +-
 arch/arm/mach-exynos/lowlevel_init.c           |  4 ++--
 arch/arm/mach-exynos/pinmux.c                  |  2 +-
 arch/arm/mach-imx/Makefile                     | 18 +++++++++---------
 arch/arm/mach-imx/cpu.c                        |  6 +++---
 arch/arm/mach-imx/hab.c                        |  8 ++++----
 arch/arm/mach-imx/imx8/cpu.c                   |  4 ++--
 arch/arm/mach-imx/imx8m/clock_imx8mm.c         |  2 +-
 arch/arm/mach-imx/imx8m/clock_imx8mq.c         |  4 ++--
 arch/arm/mach-imx/imx8m/soc.c                  | 16 ++++++++--------
 arch/arm/mach-imx/imx8ulp/Makefile             |  2 +-
 arch/arm/mach-imx/imx8ulp/clock.c              |  2 +-
 arch/arm/mach-imx/imx8ulp/lowlevel_init.S      |  2 +-
 arch/arm/mach-imx/imx8ulp/soc.c                | 12 ++++++------
 arch/arm/mach-imx/imx9/Makefile                |  2 +-
 arch/arm/mach-imx/imx9/clock.c                 |  4 ++--
 arch/arm/mach-imx/imx9/lowlevel_init.S         |  2 +-
 arch/arm/mach-imx/imx9/soc.c                   | 12 ++++++------
 arch/arm/mach-imx/mx5/clock.c                  |  2 +-
 arch/arm/mach-imx/mx6/Makefile                 |  2 +-
 arch/arm/mach-imx/mx6/clock.c                  |  2 +-
 arch/arm/mach-imx/mx6/litesom.c                |  2 +-
 arch/arm/mach-imx/mx6/opos6ul.c                |  4 ++--
 arch/arm/mach-imx/mx6/soc.c                    |  6 +++---
 arch/arm/mach-imx/mx7/clock.c                  |  2 +-
 arch/arm/mach-imx/mx7/soc.c                    |  4 ++--
 arch/arm/mach-imx/mx7ulp/clock.c               |  2 +-
 arch/arm/mach-imx/mx7ulp/soc.c                 |  2 +-
 arch/arm/mach-imx/syscounter.c                 |  2 +-
 arch/arm/mach-k3/am62ax/Makefile               |  2 +-
 arch/arm/mach-k3/am62px/Makefile               |  2 +-
 arch/arm/mach-k3/am62x/Makefile                |  2 +-
 arch/arm/mach-k3/am64x/Makefile                |  2 +-
 arch/arm/mach-k3/am65x/Makefile                |  2 +-
 arch/arm/mach-k3/arm64/cache.S                 |  2 +-
 arch/arm/mach-k3/j721e/Makefile                |  2 +-
 arch/arm/mach-k3/j721s2/Makefile               |  2 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c          |  2 +-
 arch/arm/mach-k3/j722s/Makefile                |  2 +-
 arch/arm/mach-k3/j784s4/Makefile               |  2 +-
 arch/arm/mach-k3/r5/Makefile                   |  2 +-
 arch/arm/mach-k3/security.c                    |  2 +-
 arch/arm/mach-keystone/Makefile                |  2 +-
 arch/arm/mach-keystone/config.mk               |  4 ++--
 arch/arm/mach-keystone/mon.c                   |  2 +-
 arch/arm/mach-lpc32xx/Makefile                 |  2 +-
 arch/arm/mach-mediatek/Makefile                |  2 +-
 arch/arm/mach-mediatek/mt7629/lowlevel_init.S  |  2 +-
 arch/arm/mach-mvebu/Makefile                   |  8 ++++----
 arch/arm/mach-mvebu/cpu.c                      |  4 ++--
 arch/arm/mach-mvebu/include/mach/cpu.h         |  8 ++++----
 arch/arm/mach-mvebu/include/mach/soc.h         |  2 +-
 arch/arm/mach-mvebu/serdes/a38x/Makefile       |  8 ++++----
 arch/arm/mach-mvebu/serdes/axp/Makefile        |  4 ++--
 arch/arm/mach-nexell/include/mach/display.h    |  2 +-
 arch/arm/mach-omap2/Makefile                   |  2 +-
 arch/arm/mach-omap2/am33xx/board.c             | 18 +++++++++---------
 arch/arm/mach-omap2/boot-common.c              |  6 +++---
 arch/arm/mach-omap2/clocks-common.c            |  2 +-
 arch/arm/mach-omap2/config.mk                  |  2 +-
 arch/arm/mach-omap2/config_secure.mk           |  2 +-
 arch/arm/mach-omap2/hwinit-common.c            | 14 +++++++-------
 arch/arm/mach-omap2/omap3/Makefile             |  2 +-
 arch/arm/mach-omap2/omap3/board.c              |  6 +++---
 arch/arm/mach-omap2/omap3/sdrc.c               |  4 ++--
 arch/arm/mach-omap2/omap5/hwinit.c             |  2 +-
 arch/arm/mach-omap2/sec-common.c               |  2 +-
 arch/arm/mach-orion5x/cpu.c                    |  2 +-
 arch/arm/mach-orion5x/lowlevel_init.S          |  4 ++--
 arch/arm/mach-renesas/include/mach/boot0.h     |  2 +-
 arch/arm/mach-renesas/lowlevel_init_ca15.S     |  2 +-
 arch/arm/mach-rockchip/Makefile                |  4 ++--
 arch/arm/mach-rockchip/px30/px30.c             |  2 +-
 arch/arm/mach-rockchip/rk3036/Makefile         |  2 +-
 arch/arm/mach-rockchip/rk3066/rk3066.c         |  2 +-
 arch/arm/mach-rockchip/rk3188/rk3188.c         |  4 ++--
 arch/arm/mach-rockchip/rk322x/rk322x.c         |  2 +-
 arch/arm/mach-rockchip/rk3288/rk3288.c         |  4 ++--
 arch/arm/mach-rockchip/rk3308/rk3308.c         |  2 +-
 arch/arm/mach-rockchip/rk3328/rk3328.c         |  2 +-
 arch/arm/mach-rockchip/rk3368/rk3368.c         |  2 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c         |  8 ++++----
 arch/arm/mach-rockchip/rk3568/rk3568.c         |  2 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c         |  4 ++--
 arch/arm/mach-rockchip/rv1108/Makefile         |  2 +-
 arch/arm/mach-rockchip/rv1126/rv1126.c         |  2 +-
 arch/arm/mach-sc5xx/Makefile                   |  2 +-
 arch/arm/mach-sc5xx/config.mk                  |  2 +-
 arch/arm/mach-socfpga/Makefile                 |  2 +-
 arch/arm/mach-socfpga/board.c                  |  6 +++---
 arch/arm/mach-socfpga/clock_manager.c          |  2 +-
 arch/arm/mach-socfpga/clock_manager_arria10.c  |  2 +-
 arch/arm/mach-socfpga/include/mach/boot0.h     |  2 +-
 .../include/mach/clock_manager_arria10.h       |  2 +-
 arch/arm/mach-socfpga/lowlevel_init_soc64.S    |  2 +-
 arch/arm/mach-socfpga/mailbox_s10.c            |  2 +-
 arch/arm/mach-socfpga/misc.c                   |  2 +-
 arch/arm/mach-socfpga/misc_arria10.c           |  2 +-
 arch/arm/mach-socfpga/misc_gen5.c              |  2 +-
 arch/arm/mach-socfpga/reset_manager_s10.c      |  2 +-
 arch/arm/mach-socfpga/secure_vab.c             |  2 +-
 arch/arm/mach-socfpga/timer_s10.c              |  4 ++--
 arch/arm/mach-socfpga/wrap_pll_config_soc64.c  |  6 +++---
 arch/arm/mach-stm32mp/Makefile                 |  2 +-
 arch/arm/mach-stm32mp/bsec.c                   | 12 ++++++------
 arch/arm/mach-stm32mp/stm32mp1/Makefile        |  2 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c           |  6 +++---
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c    |  4 ++--
 arch/arm/mach-sunxi/Makefile                   |  2 +-
 arch/arm/mach-sunxi/board.c                    | 10 +++++-----
 arch/arm/mach-sunxi/clock_sun4i.c              |  4 ++--
 arch/arm/mach-sunxi/clock_sun50i_h6.c          |  4 ++--
 arch/arm/mach-sunxi/clock_sun6i.c              |  4 ++--
 arch/arm/mach-sunxi/clock_sun8i_a83t.c         |  4 ++--
 arch/arm/mach-sunxi/clock_sun9i.c              |  4 ++--
 arch/arm/mach-sunxi/gtbus_sun9i.c              |  2 +-
 arch/arm/mach-tegra/Makefile                   |  4 ++--
 arch/arm/mach-tegra/board.c                    |  2 +-
 arch/arm/mach-tegra/board2.c                   |  2 +-
 arch/arm/mach-tegra/tegra114/Makefile          |  2 +-
 arch/arm/mach-tegra/tegra124/Makefile          |  4 ++--
 arch/arm/mach-tegra/tegra20/Makefile           |  2 +-
 arch/arm/mach-tegra/tegra30/Makefile           |  2 +-
 arch/arm/mach-uniphier/Makefile                |  2 +-
 arch/arm/mach-uniphier/arm32/Makefile          |  2 +-
 .../mach-uniphier/boot-device/boot-device.c    |  4 ++--
 arch/arm/mach-uniphier/clk/Makefile            |  2 +-
 arch/arm/mach-uniphier/debug-uart/Makefile     |  2 +-
 arch/arm/mach-uniphier/debug-uart/debug-uart.c |  4 ++--
 arch/arm/mach-uniphier/dram/Makefile           |  2 +-
 arch/arm/mach-zynq/Makefile                    |  2 +-
 arch/arm/mach-zynq/cpu.c                       |  2 +-
 arch/arm/mach-zynqmp/Makefile                  |  6 +++---
 arch/arm/mach-zynqmp/cpu.c                     |  4 ++--
 arch/microblaze/config.mk                      |  2 +-
 arch/microblaze/cpu/Makefile                   |  2 +-
 arch/microblaze/cpu/start.S                    |  8 ++++----
 arch/mips/Makefile                             |  2 +-
 arch/mips/config.mk                            |  2 +-
 arch/mips/lib/Makefile                         |  2 +-
 arch/mips/mach-jz47xx/Makefile                 |  2 +-
 arch/mips/mach-jz47xx/include/mach/jz4780.h    |  2 +-
 arch/mips/mach-jz47xx/jz4780/jz4780.c          |  4 ++--
 arch/mips/mach-jz47xx/start.S                  |  4 ++--
 arch/mips/mach-mtmips/Makefile                 |  2 +-
 arch/mips/mach-mtmips/cpu.c                    |  2 +-
 arch/mips/mach-mtmips/mt7620/Makefile          |  2 +-
 arch/mips/mach-mtmips/mt7621/Makefile          |  2 +-
 arch/mips/mach-mtmips/mt7628/Makefile          |  2 +-
 arch/powerpc/config.mk                         |  2 +-
 arch/powerpc/cpu/mpc83xx/Makefile              |  2 +-
 arch/powerpc/cpu/mpc83xx/start.S               |  6 +++---
 arch/powerpc/cpu/mpc85xx/Makefile              |  4 ++--
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c      |  2 +-
 arch/powerpc/cpu/mpc85xx/start.S               | 14 +++++++-------
 arch/powerpc/cpu/mpc85xx/tlb.c                 |  4 ++--
 arch/powerpc/cpu/mpc8xxx/Makefile              |  2 +-
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c            |  4 ++--
 arch/powerpc/cpu/mpc8xxx/law.c                 |  4 ++--
 arch/powerpc/cpu/mpc8xxx/pamu_table.c          |  2 +-
 arch/powerpc/include/asm/fsl_secure_boot.h     |  8 ++++----
 arch/powerpc/lib/Makefile                      |  4 ++--
 arch/riscv/cpu/fu540/Makefile                  |  2 +-
 arch/riscv/cpu/fu740/Makefile                  |  2 +-
 arch/riscv/cpu/jh7110/Makefile                 |  2 +-
 arch/riscv/cpu/start.S                         |  8 ++++----
 arch/riscv/lib/Makefile                        |  2 +-
 arch/riscv/lib/sifive_cache.c                  |  4 ++--
 arch/sandbox/cpu/Makefile                      |  2 +-
 arch/sandbox/cpu/cpu.c                         |  2 +-
 arch/sandbox/cpu/start.c                       |  2 +-
 arch/x86/Makefile                              |  2 +-
 arch/x86/config.mk                             |  8 ++++----
 arch/x86/cpu/Makefile                          |  2 +-
 arch/x86/cpu/apollolake/Makefile               | 10 +++++-----
 arch/x86/cpu/apollolake/fsp_bindings.c         |  4 ++--
 arch/x86/cpu/broadwell/Makefile                |  4 ++--
 arch/x86/cpu/broadwell/cpu_full.c              |  2 +-
 arch/x86/cpu/broadwell/pch.c                   |  2 +-
 arch/x86/cpu/config.mk                         |  2 +-
 arch/x86/cpu/coreboot/Makefile                 |  2 +-
 arch/x86/cpu/coreboot/coreboot.c               |  2 +-
 arch/x86/cpu/cpu.c                             |  4 ++--
 arch/x86/cpu/intel_common/Makefile             |  6 +++---
 arch/x86/cpu/ivybridge/Makefile                |  2 +-
 arch/x86/include/asm/string.h                  |  2 +-
 arch/x86/lib/Makefile                          | 10 +++++-----
 arch/x86/lib/fsp/Makefile                      |  2 +-
 242 files changed, 439 insertions(+), 439 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dbeedbe544b..cb87a684754 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_ARCH_TEGRA),yy)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_ARCH_TEGRA),yy)
 CONFIG_CPU_V7A=
 CONFIG_CPU_ARM720T=y
 endif
@@ -24,7 +24,7 @@ endif
 
 # On Tegra systems we must build SPL for the armv4 core on the device
 # but otherwise we can use the value in CONFIG_SYS_ARM_ARCH
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_ARCH_TEGRA),yy)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_ARCH_TEGRA),yy)
 arch-y += -D__LINUX_ARM_ARCH__=4
 else
 arch-y += -D__LINUX_ARM_ARCH__=$(CONFIG_SYS_ARM_ARCH)
@@ -106,7 +106,7 @@ libs-y += $(machdirs)
 
 head-y := arch/arm/cpu/$(CPU)/start.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 ifeq ($(CONFIG_SYS_SOC)$(CONFIG_SPL_FRAMEWORK),"mxs")
 head-y := arch/arm/cpu/arm926ejs/mxs/start.o
 endif
diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 5530d02b66c..084fd399931 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -99,7 +99,7 @@ PLATFORM_CPPFLAGS += $(PF_CPPFLAGS_ARM) $(PF_CPPFLAGS_ABI)
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 # This file is parsed many times, so the string may get added multiple
 # times. Also, the prefix needs to be different based on whether
-# CONFIG_SPL_BUILD is defined or not. 'filter-out' the existing entry
+# CONFIG_XPL_BUILD is defined or not. 'filter-out' the existing entry
 # before adding the correct one.
 PLATFORM_LIBS := arch/arm/lib/eabi_compat.o \
 	$(filter-out arch/arm/lib/eabi_compat.o, $(PLATFORM_LIBS))
@@ -126,7 +126,7 @@ PLATFORM_RELFLAGS += -fno-optimize-sibling-calls
 endif
 endif
 
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 # Check that only R_ARM_RELATIVE relocations are generated.
 INPUTS-y += checkarmreloc
 # The movt / movw can hardcode 16 bit parts of the addresses in the
@@ -160,7 +160,7 @@ endif
 ifdef CONFIG_MACH_IMX
 ifneq ($(CONFIG_IMX_CONFIG),"")
 ifdef CONFIG_SPL
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 INPUTS-y += SPL
 endif
 else
diff --git a/arch/arm/cpu/arm11/Makefile b/arch/arm/cpu/arm11/Makefile
index 5dfa01ae8d0..38a3e4d95e2 100644
--- a/arch/arm/cpu/arm11/Makefile
+++ b/arch/arm/cpu/arm11/Makefile
@@ -5,6 +5,6 @@
 
 obj-y	= cpu.o
 
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_EFI_LOADER) += sctlr.o
 endif
diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index 78a9cc173a3..d3ab5928eee 100644
--- a/arch/arm/cpu/arm1176/start.S
+++ b/arch/arm/cpu/arm1176/start.S
@@ -65,7 +65,7 @@ cpu_init_crit:
 	 * When booting from NAND - it has definitely been a reset, so, no need
 	 * to flush caches and disable the MMU
 	 */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/*
 	 * flush v4 I/D caches
 	 */
diff --git a/arch/arm/cpu/arm926ejs/Makefile b/arch/arm/cpu/arm926ejs/Makefile
index 8cfe3f0fbbc..75513889c5d 100644
--- a/arch/arm/cpu/arm926ejs/Makefile
+++ b/arch/arm/cpu/arm926ejs/Makefile
@@ -6,7 +6,7 @@
 extra-y	= start.o
 obj-y	= cpu.o cache.o
 
-ifdef	CONFIG_SPL_BUILD
+ifdef	CONFIG_XPL_BUILD
 ifdef	CONFIG_SPL_NO_CPU_SUPPORT
 extra-y	:=
 endif
diff --git a/arch/arm/cpu/arm926ejs/mxs/Makefile b/arch/arm/cpu/arm926ejs/mxs/Makefile
index 1638ef8fd8d..f633e54ba62 100644
--- a/arch/arm/cpu/arm926ejs/mxs/Makefile
+++ b/arch/arm/cpu/arm926ejs/mxs/Makefile
@@ -3,11 +3,11 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-extra-$(CONFIG_SPL_BUILD) := start.o
+extra-$(CONFIG_XPL_BUILD) := start.o
 
 obj-y	= clock.o mxs.o iomux.o timer.o
 
-ifdef	CONFIG_SPL_BUILD
+ifdef	CONFIG_XPL_BUILD
 obj-y	+= spl_boot.o spl_lradc_init.o spl_mem_init.o spl_power_init.o
 endif
 
diff --git a/arch/arm/cpu/arm926ejs/sunxi/config.mk b/arch/arm/cpu/arm926ejs/sunxi/config.mk
index 76ffec9df6a..50899d20316 100644
--- a/arch/arm/cpu/arm926ejs/sunxi/config.mk
+++ b/arch/arm/cpu/arm926ejs/sunxi/config.mk
@@ -1,6 +1,6 @@
 # Build a combined spl + u-boot image
 ifdef CONFIG_SPL
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ALL-y += u-boot-sunxi-with-spl.bin
 endif
 endif
diff --git a/arch/arm/cpu/armv7/Makefile b/arch/arm/cpu/armv7/Makefile
index 99cf9eb515f..0e7d769bd40 100644
--- a/arch/arm/cpu/armv7/Makefile
+++ b/arch/arm/cpu/armv7/Makefile
@@ -12,7 +12,7 @@ obj-y	+= syslib.o
 
 obj-$(CONFIG_SYS_ARM_MPU) += mpu_v7r.o
 
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_EFI_LOADER) += sctlr.o
 obj-$(CONFIG_ARMV7_NONSEC) += exception_level.o
 endif
diff --git a/arch/arm/cpu/armv7/cpu.c b/arch/arm/cpu/armv7/cpu.c
index aa981faef00..8082f369ed6 100644
--- a/arch/arm/cpu/armv7/cpu.c
+++ b/arch/arm/cpu/armv7/cpu.c
@@ -32,7 +32,7 @@ int cleanup_before_linux_select(int flags)
 	 *
 	 * we turn off caches etc ...
 	 */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	disable_interrupts();
 #endif
 
diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
index 3c8c07fe016..a6c844b7e3d 100644
--- a/arch/arm/cpu/armv7/lowlevel_init.S
+++ b/arch/arm/cpu/armv7/lowlevel_init.S
@@ -26,7 +26,7 @@ WEAK(lowlevel_init)
 	/*
 	 * Setup a temporary stack. Global data is not available yet.
 	 */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	sp, =CONFIG_SPL_STACK
 #else
 	ldr	sp, =SYS_INIT_SP_ADDR
@@ -39,7 +39,7 @@ WEAK(lowlevel_init)
 	 * Set up global data for boards that still need it. This will be
 	 * removed soon.
 	 */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	ldr	r9, =gdata
 #else
 	sub	sp, sp, #GD_SIZE
diff --git a/arch/arm/cpu/armv7/s5p-common/Makefile b/arch/arm/cpu/armv7/s5p-common/Makefile
index 0985420fe5c..4660ff0057e 100644
--- a/arch/arm/cpu/armv7/s5p-common/Makefile
+++ b/arch/arm/cpu/armv7/s5p-common/Makefile
@@ -8,7 +8,7 @@ ifdef CONFIG_ARCH_NEXELL
 obj-$(CONFIG_S5P4418_ONEWIRE) += pwm.o
 else
 obj-y += cpu_info.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += timer.o
 obj-y += sromc.o
 endif
diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 7730a16e512..b63481b43ca 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -279,7 +279,7 @@ ENTRY(cpu_init_cp15)
 	orr	r2, r4, r2		@ r2 has combined CPU variant + revision
 
 /* Early stack for ERRATA that needs into call C code */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	r0, =(CONFIG_SPL_STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
diff --git a/arch/arm/cpu/armv7/sunxi/Makefile b/arch/arm/cpu/armv7/sunxi/Makefile
index 3e975b366c4..0624e93efde 100644
--- a/arch/arm/cpu/armv7/sunxi/Makefile
+++ b/arch/arm/cpu/armv7/sunxi/Makefile
@@ -12,10 +12,10 @@ obj-$(CONFIG_MACH_SUN8I_H3)	+= tzpc.o
 obj-$(CONFIG_MACH_SUN6I)	+= sram.o
 obj-$(CONFIG_MACH_SUN8I)	+= sram.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMV7_PSCI)	+= psci.o
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= fel_utils.o
 endif
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570dbb..722ec89d239 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
 else
 obj-y	+= exceptions.o
@@ -27,14 +27,14 @@ endif
 obj-y	+= cpu-dt.o
 obj-$(CONFIG_ARM_SMCCC)		+= smccc-call.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMV8_SPIN_TABLE) += spin_table.o spin_table_v8.o
 else
 obj-$(CONFIG_ARCH_SUNXI) += fel_utils.o
 endif
 obj-$(CONFIG_$(SPL_)ARMV8_SEC_FIRMWARE_SUPPORT) += sec_firmware.o sec_firmware_asm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_RECOVER_DATA_SECTION) += spl_data.o
 endif
 
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 631d9efa5e1..e6be6359c5d 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1016,7 +1016,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
  * running however really wants to have dcache and the MMU active. Check that
  * everything is sane and give the developer a hint if it isn't.
  */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
 #endif
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Makefile b/arch/arm/cpu/armv8/fsl-layerscape/Makefile
index eefdf12369c..e2033dc5aff 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Makefile
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Makefile
@@ -5,7 +5,7 @@
 obj-y += cpu.o
 obj-y += lowlevel.o
 obj-y += soc.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_MP) += mp.o spintable.o
 obj-$(CONFIG_OF_LIBFDT) += fdt.o
 endif
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2dbfdd08a0..f9c2083677a 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -122,7 +122,7 @@ static struct mm_region early_map[] = {
 	{ CFG_SYS_FSL_DRAM_BASE1, CFG_SYS_FSL_DRAM_BASE1,
 	  CFG_SYS_FSL_DRAM_SIZE1,
 #if defined(CONFIG_TFABOOT) || \
-	(defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD))
+	(defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD))
 	  PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 #else	/* Start with nGnRnE and PXN and UXN to prevent speculative access */
 	  PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | PTE_BLOCK_PXN | PTE_BLOCK_UXN |
@@ -181,7 +181,7 @@ static struct mm_region early_map[] = {
 	{ CFG_SYS_FSL_DRAM_BASE1, CFG_SYS_FSL_DRAM_BASE1,
 	  CFG_SYS_FSL_DRAM_SIZE1,
 #if defined(CONFIG_TFABOOT) || \
-	(defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD))
+	(defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD))
 	  PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 #else	/* Start with nGnRnE and PXN and UXN to prevent speculative access */
 	  PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | PTE_BLOCK_PXN | PTE_BLOCK_UXN |
@@ -1055,7 +1055,7 @@ int cpu_eth_init(struct bd_info *bis)
 {
 	int error = 0;
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 	error = fsl_mc_ldpaa_init(bis);
 #endif
 	return error;
@@ -1285,7 +1285,7 @@ phys_size_t board_reserve_ram_top(phys_size_t ram_size)
 {
 	phys_size_t ram_top = ram_size;
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 	ram_top = mc_get_dram_block_size();
 	if (ram_top > ram_size)
 		return ram_size + ram_top;
@@ -1381,7 +1381,7 @@ static int tfa_dram_init_banksize(void)
 	if (i > 0)
 		ret = 0;
 
-#if defined(CONFIG_RESV_RAM) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RESV_RAM) && !defined(CONFIG_XPL_BUILD)
 	/* Assign memory for MC */
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
 	if (gd->bd->bi_dram[2].size >=
@@ -1467,7 +1467,7 @@ int dram_init_banksize(void)
 	}
 #endif	/* CFG_SYS_MEM_RESERVE_SECURE */
 
-#if defined(CONFIG_RESV_RAM) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RESV_RAM) && !defined(CONFIG_XPL_BUILD)
 	/* Assign memory for MC */
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
 	if (gd->bd->bi_dram[2].size >=
@@ -1624,7 +1624,7 @@ __weak int dram_init(void)
 #ifdef CONFIG_SYS_FSL_DDR
 	fsl_initdram();
 #if (!defined(CONFIG_SPL) && !defined(CONFIG_TFABOOT)) || \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
index 9a24d4b3031..1f03f5e2ecd 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
@@ -93,7 +93,7 @@ void get_sys_info(struct sys_info *sys_info)
 
 #define HWA_CGA_M1_CLK_SEL	0xe0000000
 #define HWA_CGA_M1_CLK_SHIFT	29
-#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_XPL_BUILD)
 	rcw_tmp = in_be32(&gur->rcwsr[7]);
 	switch ((rcw_tmp & HWA_CGA_M1_CLK_SEL) >> HWA_CGA_M1_CLK_SHIFT) {
 	case 2:
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
index b768790437f..b5213c780fb 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
@@ -25,7 +25,7 @@ static u8 serdes2_prtcl_map[SERDES_PRCTL_COUNT];
 static u8 serdes3_prtcl_map[SERDES_PRCTL_COUNT];
 #endif
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
 int xfi_dpmac[XFI14 + 1];
 int sgmii_dpmac[SGMII18 + 1];
@@ -162,7 +162,7 @@ void serdes_init(u32 sd, u32 sd_addr, u32 rcwsr, u32 sd_prctl_mask,
 			debug("Unknown SerDes lane protocol %d\n", lane_prtcl);
 		else {
 			serdes_prtcl_map[lane_prtcl] = 1;
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
 			if (lane_prtcl >= XFI1 && lane_prtcl <= XFI14)
 				wriop_init_dpmac(sd, xfi_dpmac[lane_prtcl],
@@ -553,7 +553,7 @@ int setup_serdes_volt(u32 svdd)
 
 void fsl_serdes_init(void)
 {
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 	int i , j;
 
 #if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
index 04ffefafbf7..aa0af077d2f 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -23,7 +23,7 @@ static void set_icid(struct icid_id_table *tbl, int size)
 			out_be32((u32 *)(tbl[i].reg_addr), tbl[i].reg);
 }
 
-#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_XPL_BUILD)
 static void set_fman_icids(struct fman_icid_id_table *tbl, int size)
 {
 	int i;
@@ -41,12 +41,12 @@ void set_icids(void)
 	/* setup general icid offsets */
 	set_icid(icid_tbl, icid_tbl_sz);
 
-#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_XPL_BUILD)
 	set_fman_icids(fman_icid_tbl, fman_icid_tbl_sz);
 #endif
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int fdt_set_iommu_prop(void *blob, int off, int smmu_ph, u32 *ids, int num_ids)
 {
 	int i, ret;
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S b/arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S
index 4358c6ed11c..75c204e8309 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S
+++ b/arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S
@@ -183,7 +183,7 @@ ENTRY(lowlevel_init)
 #endif
 
 	/* Initialize GIC Secure Bank Status */
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_GICV2) || defined(CONFIG_GICV3)
 	branch_if_slave x0, 1f
 	bl	get_gic_offset
@@ -306,7 +306,7 @@ ENTRY(lowlevel_init)
 #endif
 
 #if !defined(CONFIG_TFABOOT) && \
-	(defined(CONFIG_FSL_LSCH2) && !defined(CONFIG_SPL_BUILD))
+	(defined(CONFIG_FSL_LSCH2) && !defined(CONFIG_XPL_BUILD))
 	bl	fsl_ocram_init
 #endif
 
@@ -314,7 +314,7 @@ ENTRY(lowlevel_init)
 	ret
 ENDPROC(lowlevel_init)
 
-#if defined(CONFIG_FSL_LSCH2) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_LSCH2) && !defined(CONFIG_XPL_BUILD)
 ENTRY(fsl_ocram_init)
 	mov	x28, lr			/* Save LR */
 	bl	fsl_clear_ocram
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
index ec80e42055d..48b95627bae 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
@@ -60,7 +60,7 @@ struct icid_id_table icid_tbl[] = {
 
 int icid_tbl_sz = ARRAY_SIZE(icid_tbl);
 
-#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_XPL_BUILD)
 struct fman_icid_id_table fman_icid_tbl[] = {
 	/* port id, icid */
 	SET_FMAN_ICID_ENTRY(0x02, FSL_DPAA1_STREAM_ID_END),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
index a73dd316f8d..ab175b60c6c 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
@@ -59,7 +59,7 @@ struct icid_id_table icid_tbl[] = {
 
 int icid_tbl_sz = ARRAY_SIZE(icid_tbl);
 
-#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_XPL_BUILD)
 struct fman_icid_id_table fman_icid_tbl[] = {
 	/* port id, icid */
 	SET_FMAN_ICID_ENTRY(0x02, FSL_DPAA1_STREAM_ID_END),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index a739ff2da58..1f1e3d4a97b 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -41,7 +41,7 @@ u32 spl_boot_device(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 void spl_board_init(void)
 {
@@ -136,4 +136,4 @@ int spl_start_uboot(void)
 	return 1;
 }
 #endif	/* CONFIG_SPL_OS_BOOT */
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 74612802617..4a3b9f60e46 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -58,7 +58,7 @@ reset:
 .globl	save_boot_params_ret
 save_boot_params_ret:
 
-#if CONFIG_POSITION_INDEPENDENT && !defined(CONFIG_SPL_BUILD)
+#if CONFIG_POSITION_INDEPENDENT && !defined(CONFIG_XPL_BUILD)
 	/* Verify that we're 4K aligned.  */
 	adr	x0, _start
 	ands	x0, x0, #0xfff
@@ -104,7 +104,7 @@ pie_skip_reloc:
 pie_fixup_done:
 #endif
 
-#if defined(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) || !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) || !defined(CONFIG_XPL_BUILD)
 .macro	set_vbar, regname, reg
 	msr	\regname, \reg
 .endm
@@ -174,7 +174,7 @@ pie_fixup_done:
 	/* Processor specific initialization */
 	bl	lowlevel_init
 
-#if defined(CONFIG_ARMV8_SPIN_TABLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_ARMV8_SPIN_TABLE) && !defined(CONFIG_XPL_BUILD)
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
@@ -354,7 +354,7 @@ ENDPROC(smp_kick_all_cpus)
 /*-----------------------------------------------------------------------*/
 
 ENTRY(c_runtime_cpu_setup)
-#if defined(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) || !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) || !defined(CONFIG_XPL_BUILD)
 	/* Relocate vBAR */
 	adr	x0, vectors
 	switch_el x1, 3f, 2f, 1f
diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot.dtsi
index d316e869516..af229501a4d 100644
--- a/arch/arm/dts/imx8qm-u-boot.dtsi
+++ b/arch/arm/dts/imx8qm-u-boot.dtsi
@@ -10,7 +10,7 @@
 };
 
 &binman {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	u-boot-spl-ddr {
 		align = <4>;
 		align-size = <4>;
diff --git a/arch/arm/dts/imx8qxp-u-boot.dtsi b/arch/arm/dts/imx8qxp-u-boot.dtsi
index 7622c40906f..62791c34c77 100644
--- a/arch/arm/dts/imx8qxp-u-boot.dtsi
+++ b/arch/arm/dts/imx8qxp-u-boot.dtsi
@@ -10,7 +10,7 @@
 };
 
 &binman {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	u-boot-spl-ddr {
 		align = <4>;
 		align-size = <4>;
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h b/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
index d5f63f4a7ed..22671d4bbfd 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
@@ -12,13 +12,13 @@
 #include <asm/armv8/sec_firmware.h>
 
 struct icid_id_table {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	const char *compat;
 	phys_addr_t compat_addr;
 #endif
 	phys_addr_t reg_addr;
 	u32 reg;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	u32 id;
 #endif
 	bool le;
@@ -35,7 +35,7 @@ int fdt_set_iommu_prop(void *blob, int off, int smmu_ph, u32 *ids, int num_ids);
 void set_icids(void);
 void fdt_fixup_icid(void *blob);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SET_ICID_ENTRY(name, idA, regA, addr, compataddr, _le) \
 	{ .reg = regA, \
 	  .reg_addr = addr, \
diff --git a/arch/arm/include/asm/arch-imx8/boot0.h b/arch/arm/include/asm/arch-imx8/boot0.h
index 5ce781adb75..fc580b20a46 100644
--- a/arch/arm/include/asm/arch-imx8/boot0.h
+++ b/arch/arm/include/asm/arch-imx8/boot0.h
@@ -3,7 +3,7 @@
  * Copyright 2019 NXP
  */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	/*
 	 * We use absolute address not PC relative address to jump.
 	 * When running SPL on iMX8, the A core starts at address 0, a alias to OCRAM 0x100000,
diff --git a/arch/arm/include/asm/arch-lpc32xx/sys_proto.h b/arch/arm/include/asm/arch-lpc32xx/sys_proto.h
index 4675dc3c533..b499d975526 100644
--- a/arch/arm/include/asm/arch-lpc32xx/sys_proto.h
+++ b/arch/arm/include/asm/arch-lpc32xx/sys_proto.h
@@ -16,7 +16,7 @@ void lpc32xx_slc_nand_init(void);
 void lpc32xx_i2c_init(unsigned int devnum);
 void lpc32xx_ssp_init(void);
 void lpc32xx_usb_init(void);
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void ddr_init(const struct emc_dram_settings *dram);
 #endif
 #endif /* _LPC32XX_SYS_PROTO_H */
diff --git a/arch/arm/include/asm/arch-mx6/litesom.h b/arch/arm/include/asm/arch-mx6/litesom.h
index 37a16d2c309..642ed22bffc 100644
--- a/arch/arm/include/asm/arch-mx6/litesom.h
+++ b/arch/arm/include/asm/arch-mx6/litesom.h
@@ -8,7 +8,7 @@
 
 int litesom_mmc_init(struct bd_info *bis);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void litesom_init_f(void);
 #endif
 
diff --git a/arch/arm/include/asm/arch-mx6/mx6-ddr.h b/arch/arm/include/asm/arch-mx6/mx6-ddr.h
index dbc97b25df8..ad9c1ac906a 100644
--- a/arch/arm/include/asm/arch-mx6/mx6-ddr.h
+++ b/arch/arm/include/asm/arch-mx6/mx6-ddr.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_ARCH_MX6_DDR_H__
 #define __ASM_ARCH_MX6_DDR_H__
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_MX6Q
 #include "mx6q-ddr.h"
 #else
@@ -488,7 +488,7 @@ void mx6_dram_cfg(const struct mx6_ddr_sysinfo *,
 		  const struct mx6_mmdc_calibration *,
 		  const void *);
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define MX6_MMDC_P0_MDCTL	0x021b0000
 #define MX6_MMDC_P0_MDPDC	0x021b0004
diff --git a/arch/arm/include/asm/arch-mxs/sys_proto.h b/arch/arm/include/asm/arch-mxs/sys_proto.h
index 17afd1b29e4..f8a56495acd 100644
--- a/arch/arm/include/asm/arch-mxs/sys_proto.h
+++ b/arch/arm/include/asm/arch-mxs/sys_proto.h
@@ -14,7 +14,7 @@
 int mxsmmc_initialize(struct bd_info *bis, int id, int (*wp)(int),
 		      int (*cd)(int));
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #if defined(CONFIG_MX23)
 #include <asm/arch/iomux-mx23.h>
diff --git a/arch/arm/include/asm/arch-rk3066/boot0.h b/arch/arm/include/asm/arch-rk3066/boot0.h
index 6bf3828c84e..eaf81554f5b 100644
--- a/arch/arm/include/asm/arch-rk3066/boot0.h
+++ b/arch/arm/include/asm/arch-rk3066/boot0.h
@@ -10,7 +10,7 @@
  * (containing the magic 'RK30'). This magic constant will be written into
  * the final image by the rkimage tool, but we need to reserve space for it here.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	b	1f  /* if overwritten, entry-address is at the next word */
 1:
 #endif
@@ -68,7 +68,7 @@ back_to_bootrom:
 	pop	{r1-r12, pc}
 #endif
 
-#if (defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_XPL_BUILD))
 /* U-Boot proper of armv7 does not need this */
 	b reset
 #endif
diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
index 0c375e543a5..edb2a31c348 100644
--- a/arch/arm/include/asm/arch-rockchip/boot0.h
+++ b/arch/arm/include/asm/arch-rockchip/boot0.h
@@ -12,7 +12,7 @@
  * To make life easier for everyone, we build the SPL binary with
  * space for this 4-byte header already included in the binary.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * We need to add 4 bytes of space for the 'RK33' at the
 	 * beginning of the executable.	 However, as we want to keep
@@ -39,7 +39,7 @@ entry_counter:
 	.word   0
 #endif
 
-#if (defined(CONFIG_SPL_BUILD) || defined(CONFIG_ARM64))
+#if (defined(CONFIG_XPL_BUILD) || defined(CONFIG_ARM64))
 	/* U-Boot proper of armv7 do not need this */
 	b reset
 #endif
@@ -54,7 +54,7 @@ _start:
 	ARM_VECTORS
 #endif
 
-#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_SPL_BUILD) && \
+#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
 	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
 	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for the ATF data */
 #endif
diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
index 49a1f763795..ae273de3144 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
@@ -11,7 +11,7 @@
 #define KHz		1000
 #define OSC_HZ		(24 * MHz)
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
 #define APLL_HZ		(1008 * MHz)
 #else
 #define APLL_HZ		(816 * MHz)
@@ -20,7 +20,7 @@
 #define CPLL_HZ		(500 * MHz)
 #define HPLL_HZ		(1400 * MHz)
 #define PCLK_PDPMU_HZ	(100 * MHz)
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
 #define ACLK_PDBUS_HZ	(396 * MHz)
 #else
 #define ACLK_PDBUS_HZ	(500 * MHz)
@@ -32,7 +32,7 @@
 #define HCLK_PDCORE_HZ	(200 * MHz)
 #define HCLK_PDAUDIO_HZ	(150 * MHz)
 #define CLK_OSC0_DIV_HZ	(32768)
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
 #define ACLK_PDVI_HZ	(297 * MHz)
 #define CLK_ISP_HZ	(297 * MHz)
 #define ACLK_PDISPP_HZ	(297 * MHz)
@@ -324,7 +324,7 @@ enum {
 	DCLK_VOP_DIV_SHIFT	= 0,
 	DCLK_VOP_DIV_MASK	= 0xff,
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
 	/* CRU_CLK_SEL49_CON */
 	ACLK_PDVI_SEL_SHIFT	= 6,
 	ACLK_PDVI_SEL_MASK	= 0x3 << ACLK_PDVI_SEL_SHIFT,
@@ -397,7 +397,7 @@ enum {
 	CLK_GMAC_SRC_DIV_SHIFT	= 0,
 	CLK_GMAC_SRC_DIV_MASK	= 0x1f << CLK_GMAC_SRC_DIV_SHIFT,
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
 	/* CRU_CLK_SEL68_CON */
 	ACLK_PDISPP_SEL_SHIFT	= 6,
 	ACLK_PDISPP_SEL_MASK	= 0x3 << ACLK_PDISPP_SEL_SHIFT,
diff --git a/arch/arm/include/asm/arch-sunxi/boot0.h b/arch/arm/include/asm/arch-sunxi/boot0.h
index cad25c50bc6..6b2bb5a4586 100644
--- a/arch/arm/include/asm/arch-sunxi/boot0.h
+++ b/arch/arm/include/asm/arch-sunxi/boot0.h
@@ -5,7 +5,7 @@
 
 #include <asm/arch/cpu.h>
 
-#if defined(CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER) && !defined(CONFIG_XPL_BUILD)
 /* reserve space for BOOT0 header information */
 	b	reset
 	.space	1532
@@ -49,7 +49,7 @@
 	.word	CONFIG_SUNXI_RVBAR_ADDRESS	// writable RVBAR mapping addr
 	.word	SUNXI_SRAMC_BASE
 	.word	CONFIG_SUNXI_RVBAR_ALTERNATIVE	// address for die variant
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.word	CONFIG_SPL_TEXT_BASE
 #else
 	.word   CONFIG_TEXT_BASE
diff --git a/arch/arm/include/asm/arch-sunxi/sys_proto.h b/arch/arm/include/asm/arch-sunxi/sys_proto.h
index 064602292b6..92c7721a530 100644
--- a/arch/arm/include/asm/arch-sunxi/sys_proto.h
+++ b/arch/arm/include/asm/arch-sunxi/sys_proto.h
@@ -23,7 +23,7 @@ void sdelay(unsigned long);
 void return_to_fel(uint32_t lr, uint32_t sp);
 
 /* Board / SoC level designware gmac init */
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_SUN7I_GMAC
+#if !defined CONFIG_XPL_BUILD && defined CONFIG_SUN7I_GMAC
 void eth_init_board(void);
 #else
 static inline void eth_init_board(void) {}
diff --git a/arch/arm/include/asm/fsl_secure_boot.h b/arch/arm/include/asm/fsl_secure_boot.h
index 15627c96e90..382a6d420a2 100644
--- a/arch/arm/include/asm/fsl_secure_boot.h
+++ b/arch/arm/include/asm/fsl_secure_boot.h
@@ -8,8 +8,8 @@
 #define __FSL_SECURE_BOOT_H
 
 #ifdef CONFIG_CHAIN_OF_TRUST
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 #endif /* #ifdef CONFIG_CHAIN_OF_TRUST */
 #endif
diff --git a/arch/arm/include/asm/ti-common/sys_proto.h b/arch/arm/include/asm/ti-common/sys_proto.h
index a96a8382fb6..514086a1bc4 100644
--- a/arch/arm/include/asm/ti-common/sys_proto.h
+++ b/arch/arm/include/asm/ti-common/sys_proto.h
@@ -57,7 +57,7 @@ static inline u8 uboot_loaded_by_spl(void)
  */
 static inline u32 omap_hw_init_context(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	return OMAP_INIT_CONTEXT_SPL;
 #else
 	if (uboot_loaded_by_spl())
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba616..e343e81cf32 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -21,7 +21,7 @@ else
 obj-y   += setjmp.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_ARM64
 obj-y	+= relocate_64.o
 else
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a0311438b45..3e4906e273d 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -102,7 +102,7 @@ ENTRY(_main)
 
 #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
 	ldr	r0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
+#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	r0, =(CONFIG_SPL_STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
@@ -119,14 +119,14 @@ ENTRY(_main)
 	bl	debug_uart_init
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_EARLY_BSS)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_EARLY_BSS)
 	CLEAR_BSS
 #endif
 
 	mov	r0, #0
 	bl	board_init_f
 
-#if ! defined(CONFIG_SPL_BUILD)
+#if ! defined(CONFIG_XPL_BUILD)
 
 /*
  * Set up intermediate environment (new sp and gd) and call
@@ -171,13 +171,13 @@ here:
 
 	bl	c_runtime_cpu_setup	/* we still call old routine here */
 #endif
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(FRAMEWORK)
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FRAMEWORK)
 
-#if !defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL_EARLY_BSS)
+#if !defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL_EARLY_BSS)
 	CLEAR_BSS
 #endif
 
-# ifdef CONFIG_SPL_BUILD
+# ifdef CONFIG_XPL_BUILD
 	/* Use a DRAM stack for the rest of SPL, if requested */
 	bl	spl_relocate_stack_gd
 	cmp	r0, #0
@@ -185,7 +185,7 @@ here:
 	movne	r9, r0
 # endif
 
-#if ! defined(CONFIG_SPL_BUILD)
+#if ! defined(CONFIG_XPL_BUILD)
 	bl coloured_LED_init
 	bl red_led_on
 #endif
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index dcc924dd2f4..32401f544a7 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -71,7 +71,7 @@ ENTRY(_main)
  */
 #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
 	ldr	x0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
+#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	x0, =(CONFIG_SPL_STACK)
 #elif defined(CONFIG_INIT_SP_RELATIVE)
 #if CONFIG_POSITION_INDEPENDENT
@@ -99,7 +99,7 @@ ENTRY(_main)
 	mov	x0, #0
 	bl	board_init_f
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 /*
  * Set up intermediate environment (new sp and gd) and call
  * relocate_code(addr_moni). Trick here is that we'll return
@@ -139,9 +139,9 @@ relocation_return:
  * Set up final (full) environment
  */
 	bl	c_runtime_cpu_setup		/* still call old routine */
-#endif /* !CONFIG_SPL_BUILD */
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(FRAMEWORK)
-#if defined(CONFIG_SPL_BUILD)
+#endif /* !CONFIG_XPL_BUILD */
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FRAMEWORK)
+#if defined(CONFIG_XPL_BUILD)
 	bl	spl_relocate_stack_gd           /* may return NULL */
 	/* set up gd here, outside any C code, if new stack is returned */
 	cmp	x0, #0
diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index 0a96ba1355f..602efe04c04 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -12,7 +12,7 @@
 int raise (int signum)
 {
 	/* Even if printf() is available, it's large. Punt it for SPL builds */
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	printf("raise: Signal # %d caught\n", signum);
 #endif
 	return 0;
diff --git a/arch/arm/lib/stack.c b/arch/arm/lib/stack.c
index 2b21ec0734e..78507b76894 100644
--- a/arch/arm/lib/stack.c
+++ b/arch/arm/lib/stack.c
@@ -17,7 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int arch_reserve_stacks(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	gd->start_addr_sp -= 128;	/* leave 32 words for abort-stack */
 	gd->irq_sp = gd->start_addr_sp;
 #else
diff --git a/arch/arm/lib/vectors.S b/arch/arm/lib/vectors.S
index b6b879339df..cf3f6c3e65c 100644
--- a/arch/arm/lib/vectors.S
+++ b/arch/arm/lib/vectors.S
@@ -133,7 +133,7 @@ _fiq:			.word fiq
 
 /* SPL interrupt handling: just hang */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #if !CONFIG_IS_ENABLED(SYS_NO_VECTOR_TABLE)
 	.align	5
@@ -166,7 +166,7 @@ fiq:
 	b	1b			/* hang and never return */
 #endif
 
-#else	/* !CONFIG_SPL_BUILD */
+#else	/* !CONFIG_XPL_BUILD */
 
 /* IRQ stack memory (calculated at run-time) + 8 bytes */
 .globl IRQ_STACK_START_IN
@@ -332,4 +332,4 @@ fiq:
 	bad_save_user_regs
 	bl	do_fiq
 
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
diff --git a/arch/arm/lib/zimage.c b/arch/arm/lib/zimage.c
index 51287251b3f..7e1cd4dd8bc 100644
--- a/arch/arm/lib/zimage.c
+++ b/arch/arm/lib/zimage.c
@@ -24,14 +24,14 @@ int bootz_setup(ulong image, ulong *start, ulong *end)
 
 	if (zi->zi_magic != LINUX_ARM_ZIMAGE_MAGIC &&
 	    zi->zi_magic != BAREBOX_IMAGE_MAGIC) {
-		if (!IS_ENABLED(CONFIG_SPL_BUILD))
+		if (!IS_ENABLED(CONFIG_XPL_BUILD))
 			puts("zimage: Bad magic!\n");
 		return 1;
 	}
 
 	*start = zi->zi_start;
 	*end = zi->zi_end;
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		printf("Kernel image @ %#08lx [ %#08lx - %#08lx ]\n",
 		       image, *start, *end);
 
diff --git a/arch/arm/mach-aspeed/ast2600/Makefile b/arch/arm/mach-aspeed/ast2600/Makefile
index 448d3201aff..18f9f75e8ef 100644
--- a/arch/arm/mach-aspeed/ast2600/Makefile
+++ b/arch/arm/mach-aspeed/ast2600/Makefile
@@ -1,2 +1,2 @@
 obj-y   += lowlevel_init.o board_common.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/arch/arm/mach-aspeed/ast2600/lowlevel_init.S b/arch/arm/mach-aspeed/ast2600/lowlevel_init.S
index 594963d039d..d1c31068685 100644
--- a/arch/arm/mach-aspeed/ast2600/lowlevel_init.S
+++ b/arch/arm/mach-aspeed/ast2600/lowlevel_init.S
@@ -97,7 +97,7 @@
 .globl lowlevel_init
 
 lowlevel_init:
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	mov	pc, lr
 #else
 	/* setup ARM arch timer frequency */
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index cbd0ed68c27..447cd80642c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_AT91_WANTS_COMMON_PHY) += phy.o
-ifneq ($(CONFIG_SPL_BUILD),)
+ifneq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_AT91SAM9260) += sdram.o spl_at91.o
 obj-$(CONFIG_AT91SAM9G20) += sdram.o spl_at91.o
 obj-$(CONFIG_AT91SAM9M10G45) += mpddrc.o spl_at91.o
diff --git a/arch/arm/mach-at91/config.mk b/arch/arm/mach-at91/config.mk
index 5426394651e..a31612b8179 100644
--- a/arch/arm/mach-at91/config.mk
+++ b/arch/arm/mach-at91/config.mk
@@ -3,7 +3,7 @@ PLATFORM_CPPFLAGS += $(call cc-option,-mtune=arm926ejs,)
 endif
 
 ifeq ($(CONFIG_CPU_V7A),y)
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 INPUTS-y	+= u-boot.img
 endif
 endif
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index ae171e3ee22..c994f97bab8 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -9,7 +9,7 @@ obj-y				+= cpu.o misc.o timer.o psc.o pinmux.o reset.o
 obj-$(CONFIG_DA850_LOWLEVEL)	+= da850_lowlevel.o
 obj-$(CONFIG_SOC_DA850)	+= da850_pinmux.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_FRAMEWORK)	+= spl.o
 obj-$(CONFIG_SOC_DA8XX)	+= da850_lowlevel.o
 endif
diff --git a/arch/arm/mach-davinci/config.mk b/arch/arm/mach-davinci/config.mk
index edbac8e8e21..3b972a26c0c 100644
--- a/arch/arm/mach-davinci/config.mk
+++ b/arch/arm/mach-davinci/config.mk
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2012, Texas Instruments, Incorporated - https://www.ti.com/
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 INPUTS-$(CONFIG_SPL_FRAMEWORK)	+= u-boot.ais
 endif
diff --git a/arch/arm/mach-davinci/misc.c b/arch/arm/mach-davinci/misc.c
index 6c97e5810cd..07125eac7cd 100644
--- a/arch/arm/mach-davinci/misc.c
+++ b/arch/arm/mach-davinci/misc.c
@@ -21,7 +21,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int dram_init(void)
 {
 	/* dram_init must store complete ramsize in gd->ram_size */
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index dd097cf5418..ebdc3b89d05 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARM64)	+= mmu-arm64.o
 
 obj-$(CONFIG_EXYNOS5420)	+= sec_boot.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARCH_EXYNOS5)	+= clock_init_exynos5.o
 obj-$(CONFIG_ARCH_EXYNOS5)	+= dmc_common.o dmc_init_ddr3.o
 obj-$(CONFIG_EXYNOS4210)+= dmc_init_exynos4.o clock_init_exynos4.o
diff --git a/arch/arm/mach-exynos/lowlevel_init.c b/arch/arm/mach-exynos/lowlevel_init.c
index 0967ab995a9..0c50b2e2b99 100644
--- a/arch/arm/mach-exynos/lowlevel_init.c
+++ b/arch/arm/mach-exynos/lowlevel_init.c
@@ -221,8 +221,8 @@ int do_lowlevel_init(void)
 	if (actions & DO_CLOCKS) {
 		system_clock_init();
 #ifdef CONFIG_DEBUG_UART
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)) || \
-    !defined(CONFIG_SPL_BUILD)
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)) || \
+    !defined(CONFIG_XPL_BUILD)
 		exynos_pinmux_config(PERIPH_ID_UART3, PINMUX_FLAG_NONE);
 		debug_uart_init();
 #endif
diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index 07d19fd17ba..48c325190d5 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -171,7 +171,7 @@ static int exynos5420_mmc_config(int peripheral, int flags)
 		 * this same assumption.
 		 */
 		if ((peripheral == PERIPH_ID_SDMMC0) && (i == (start + 2))) {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 			gpio_request(i, "sdmmc0_vdden");
 #endif
 			gpio_set_value(i, 1);
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index f8903afc92e..af62a39a671 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -10,7 +10,7 @@ obj-y	= iomux-v3.o
 endif
 
 ifeq ($(SOC),$(filter $(SOC),imx8m))
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
@@ -22,7 +22,7 @@ obj-y += cpu.o
 endif
 
 ifeq ($(SOC),$(filter $(SOC),imx8m imx9))
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y += fdt.o
 endif
 endif
@@ -38,7 +38,7 @@ endif
 ifeq ($(SOC),$(filter $(SOC),mx7 mx6 mxs imx8m imx8 imx9 imxrt))
 obj-y	+= misc.o
 obj-$(CONFIG_CMD_PRIBLOB) += priblob.o
-obj-$(CONFIG_SPL_BUILD)	+= spl.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o
 endif
 ifeq ($(SOC),$(filter $(SOC),mx7))
 obj-y	+= cpu.o
@@ -46,7 +46,7 @@ obj-$(CONFIG_SYS_I2C_MXC) += i2c-mxv7.o
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 endif
 ifeq ($(SOC),$(filter $(SOC),mx7 imx8m))
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_FSL_MFGPROT) += cmd_mfgprot.o
 endif
 endif
@@ -57,7 +57,7 @@ ifeq ($(SOC),$(filter $(SOC),mx6 mx7))
 obj-y	+= cache.o init.o
 obj-$(CONFIG_FEC_MXC) += mac.o
 obj-$(CONFIG_IMX_RDC) += rdc-sema.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
 endif
 obj-$(CONFIG_$(SPL_)SATA) += sata.o
@@ -73,18 +73,18 @@ obj-y += ddrmc-vf610.o
 obj-$(CONFIG_DDRMC_VF610_CALIBRATION) += ddrmc-vf610-calibration.o
 endif
 ifeq ($(SOC),$(filter $(SOC),imx8))
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
 endif
 endif
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_CMD_BMODE) += cmd_bmode.o
 obj-$(CONFIG_CMD_HDMIDETECT) += cmd_hdmidet.o
 obj-$(CONFIG_CMD_DEKBLOB) += cmd_dek.o
 obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
 endif
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_SPL_LOAD_IMX_CONTAINER) += image-container.o
 endif
 
@@ -128,7 +128,7 @@ container.cfg: $(IMX_CONTAINER_CFG) FORCE
 ifeq ($(CONFIG_ARCH_IMX8), y)
 CNTR_DEPFILES := $(srctree)/tools/imx_cntr_image.sh
 IMAGE_TYPE := imx8image
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 SPL_DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o spl/u-boot-spl.cfgout $(srctree)/$(IMX_CONFIG); if [ -f spl/u-boot-spl.cfgout ]; then $(CNTR_DEPFILES) spl/u-boot-spl.cfgout; echo $$?; fi)
 endif
 DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o u-boot-dtb.cfgout $(srctree)/$(IMX_CONFIG); if [ -f u-boot-dtb.cfgout ]; then $(CNTR_DEPFILES) u-boot-dtb.cfgout; echo $$?; fi)
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index ceee31eecd7..17de9ff98ec 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -39,7 +39,7 @@ u32 get_imx_reset_cause(void)
 	if (reset_cause == -1) {
 		reset_cause = readl(&src_regs->srsr);
 /* preserve the value for U-Boot proper */
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 		writel(reset_cause, &src_regs->srsr);
 #endif
 	}
@@ -47,7 +47,7 @@ u32 get_imx_reset_cause(void)
 	return reset_cause;
 }
 
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
 static char *get_reset_cause(void)
 {
 	switch (get_imx_reset_cause()) {
@@ -92,7 +92,7 @@ static char *get_reset_cause(void)
 }
 #endif
 
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
 
 const char *get_imx_type(u32 imxtype)
 {
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 85d90686f68..a8107f46ae5 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -245,7 +245,7 @@ void *hab_rvt_authenticate_image(uint8_t cid, ptrdiff_t ivt_offset,
 	return ret;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #define MAX_RECORD_BYTES     (8*1024) /* 4 kbytes */
 
@@ -727,7 +727,7 @@ U_BOOT_CMD(
 		""
 	  );
 
-#endif /* !defined(CONFIG_SPL_BUILD) */
+#endif /* !defined(CONFIG_XPL_BUILD) */
 
 /* Get CSF Header length */
 static int get_hab_hdr_len(struct hab_hdr *hdr)
@@ -939,7 +939,7 @@ int imx_hab_authenticate_image(uint32_t ddr_start, uint32_t image_size,
 	puts("Dumping CSF Header\n");
 	print_buffer(ivt->csf, (void *)(uintptr_t)(ivt->csf), 4, 0x10, 0);
 
-#if  !defined(CONFIG_SPL_BUILD)
+#if  !defined(CONFIG_XPL_BUILD)
 	get_hab_status();
 #endif
 
@@ -989,7 +989,7 @@ int imx_hab_authenticate_image(uint32_t ddr_start, uint32_t image_size,
 	}
 
 hab_exit_failure_print_status:
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	get_hab_status();
 #endif
 
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 834aca82bcf..2ff4ff35e49 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -89,11 +89,11 @@ __weak void reset_cpu(void)
 
 int arch_cpu_init(void)
 {
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
 	spl_save_restore_data();
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct pass_over_info_t *pass_over;
 
 	if (is_soc_rev(CHIP_REV_A)) {
diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index d7fd102c955..d5745f67262 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -51,7 +51,7 @@ int enable_i2c_clk(unsigned char enable, unsigned i2c_num)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static struct imx_int_pll_rate_table imx8mm_fracpll_tbl[] = {
 	PLL_1443X_RATE(1000000000U, 250, 3, 1, 0),
 	PLL_1443X_RATE(933000000U, 311, 4, 1, 0),
diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mq.c b/arch/arm/mach-imx/imx8m/clock_imx8mq.c
index 43e677deae2..2f53430b4d0 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mq.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mq.c
@@ -611,7 +611,7 @@ void dram_disable_bypass(void)
 			     CLK_ROOT_PRE_DIV(CLK_ROOT_PRE_DIV5));
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void dram_pll_init(ulong pll_val)
 {
 	u32 val;
@@ -791,7 +791,7 @@ int clock_init(void)
 /*
  * Dump some clockes.
  */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_imx8m_showclocks(struct cmd_tbl *cmdtp, int flag, int argc,
 			       char *const argv[])
 {
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 46974bf0618..b0ab00fbd98 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -45,7 +45,7 @@ struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
 
 int timer_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct sctr_regs *sctr = (struct sctr_regs *)SYSCNT_CTRL_BASE_ADDR;
 	unsigned long freq = readl(&sctr->cntfid0);
 
@@ -255,7 +255,7 @@ int dram_init(void)
 		return ret;
 
 	/* rom_pointer[1] contains the size of TEE occupies */
-	if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_SPL_BUILD) && rom_pointer[1])
+	if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1])
 		gd->ram_size = sdram_size - rom_pointer[1];
 	else
 		gd->ram_size = sdram_size;
@@ -284,7 +284,7 @@ int dram_init_banksize(void)
 	}
 
 	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
-	if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_SPL_BUILD) && rom_pointer[1]) {
+	if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
@@ -329,7 +329,7 @@ phys_size_t get_effective_memsize(void)
 			sdram_b1_size = sdram_size;
 		}
 
-		if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_SPL_BUILD) &&
+		if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_XPL_BUILD) &&
 		    rom_pointer[1]) {
 			/* We will relocate u-boot to Top of dram1. Tee position has two cases:
 			 * 1. At the top of dram1,  Then return the size removed optee size.
@@ -612,7 +612,7 @@ static void early_enable_caches(void)
 	phys_size_t sdram_size;
 	int entry, ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return;
 
 	if (CONFIG_IS_ENABLED(SYS_ICACHE_OFF) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
@@ -646,7 +646,7 @@ int arch_cpu_init(void)
 	 * ROM might disable clock for SCTR,
 	 * enable the clock before timer_init.
 	 */
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		clock_enable(CCGR_SCTR, 1);
 	/*
 	 * Init timer at very early state, because sscg pll setting
@@ -654,7 +654,7 @@ int arch_cpu_init(void)
 	 */
 	timer_init();
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		clock_init();
 		imx_set_wdog_powerdown(false);
 
@@ -1476,7 +1476,7 @@ int arch_misc_init(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_IMX8MQ) || defined(CONFIG_IMX8MM) || defined(CONFIG_IMX8MN)
 bool serror_need_skip = true;
 
diff --git a/arch/arm/mach-imx/imx8ulp/Makefile b/arch/arm/mach-imx/imx8ulp/Makefile
index 2c9938fcdf0..b478dab59d0 100644
--- a/arch/arm/mach-imx/imx8ulp/Makefile
+++ b/arch/arm/mach-imx/imx8ulp/Makefile
@@ -6,6 +6,6 @@
 obj-y += lowlevel_init.o
 obj-y += soc.o clock.o iomux.o pcc.o cgc.o rdc.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y += upower/
 endif
diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-imx/imx8ulp/clock.c
index fadf165ece2..c390f20d769 100644
--- a/arch/arm/mach-imx/imx8ulp/clock.c
+++ b/arch/arm/mach-imx/imx8ulp/clock.c
@@ -519,7 +519,7 @@ u32 get_lpuart_clk(void)
 	return pcc_clock_get_rate(lpuart_pcc[index], lpuart_pcc_slots[index]);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Dump some core clockes.
  */
diff --git a/arch/arm/mach-imx/imx8ulp/lowlevel_init.S b/arch/arm/mach-imx/imx8ulp/lowlevel_init.S
index 791c26407c9..9ede695dbba 100644
--- a/arch/arm/mach-imx/imx8ulp/lowlevel_init.S
+++ b/arch/arm/mach-imx/imx8ulp/lowlevel_init.S
@@ -16,7 +16,7 @@ rom_pointer:
 
 .global save_boot_params
 save_boot_params:
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* The firmware provided ATAG/FDT address can be found in r2/x0 */
 	adr	x0, rom_pointer
 	stp	x1, x2, [x0], #16
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index c3722c60836..b5dc45296d1 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -104,7 +104,7 @@ enum bt_mode get_boot_mode(void)
 
 bool m33_image_booted(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		u32 gp6 = 0;
 
 		/* DGO_GP6 */
@@ -124,7 +124,7 @@ bool m33_image_booted(void)
 
 bool rdc_enabled_in_boot(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		u32 val = 0;
 		int ret;
 		bool rdc_en = true; /* Default assume DBD_EN is set */
@@ -146,7 +146,7 @@ bool rdc_enabled_in_boot(void)
 
 static void spl_pass_boot_info(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		bool m33_booted = m33_image_booted();
 		bool rdc_en = rdc_enabled_in_boot();
 		u32 val = 0;
@@ -164,7 +164,7 @@ static void spl_pass_boot_info(void)
 bool is_m33_handshake_necessary(void)
 {
 	/* Only need handshake in u-boot */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		return (m33_image_booted() || rdc_enabled_in_boot());
 	else
 		return false;
@@ -716,7 +716,7 @@ void set_lpav_qos(void)
 
 int arch_cpu_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		/* Enable System Reset Interrupt using WDOG_AD */
 		setbits_le32(CMC1_BASE_ADDR + 0x8C, BIT(13));
 		/* Clear AD_PERIPH Power switch domain out of reset interrupt flag */
@@ -805,7 +805,7 @@ int imx8ulp_dm_post_init(void)
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8ulp_dm_post_init);
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 __weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index e1b09ab5341..45a9105a75a 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -5,6 +5,6 @@
 obj-y += lowlevel_init.o
 obj-y += soc.o clock.o clock_root.o trdc.o
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 obj-y += imx_bootaux.o
 #endif
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 12685f970de..dda57ed7f55 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -640,7 +640,7 @@ void enable_usboh3_clk(unsigned char enable)
 	}
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void dram_pll_init(ulong pll_val)
 {
 	configure_fracpll(DRAM_PLL_CLK, pll_val);
@@ -950,7 +950,7 @@ int set_clk_enet(enum enet_freq type)
 /*
  * Dump some clockes.
  */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int do_showclocks(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	u32 freq;
diff --git a/arch/arm/mach-imx/imx9/lowlevel_init.S b/arch/arm/mach-imx/imx9/lowlevel_init.S
index 1dc1dbfcddc..97d85911041 100644
--- a/arch/arm/mach-imx/imx9/lowlevel_init.S
+++ b/arch/arm/mach-imx/imx9/lowlevel_init.S
@@ -16,7 +16,7 @@ rom_pointer:
 
 .global save_boot_params
 save_boot_params:
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* The firmware provided ATAG/FDT address can be found in r2/x0 */
 	adr	x0, rom_pointer
 	stp	x1, x2, [x0], #16
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 04b21207a28..7c28fa39e14 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -383,7 +383,7 @@ int dram_init(void)
 		return ret;
 
 	/* rom_pointer[1] contains the size of TEE occupies */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && rom_pointer[1])
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1])
 		gd->ram_size = sdram_size - rom_pointer[1];
 	else
 		gd->ram_size = sdram_size;
@@ -412,7 +412,7 @@ int dram_init_banksize(void)
 	}
 
 	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && rom_pointer[1]) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
@@ -457,7 +457,7 @@ phys_size_t get_effective_memsize(void)
 		else
 			sdram_b1_size = sdram_size;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && rom_pointer[1]) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1]) {
 			/* We will relocate u-boot to top of dram1. TEE position has two cases:
 			 * 1. At the top of dram1,  Then return the size removed optee size.
 			 * 2. In the middle of dram1, return the size of dram1.
@@ -629,7 +629,7 @@ static int low_drive_freq_update(void *blob)
 }
 
 #ifdef CONFIG_OF_BOARD_FIXUP
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int board_fix_fdt(void *fdt)
 {
 	/* Update dtb clocks for low drive mode */
@@ -701,7 +701,7 @@ static void save_reset_cause(void)
 
 int arch_cpu_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		/* Disable wdog */
 		init_wdog();
 
@@ -745,7 +745,7 @@ EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
 
 int timer_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct sctr_regs *sctr = (struct sctr_regs *)SYSCNT_CTRL_BASE_ADDR;
 	unsigned long freq = readl(&sctr->cntfid0);
 
diff --git a/arch/arm/mach-imx/mx5/clock.c b/arch/arm/mach-imx/mx5/clock.c
index 0b8a10fd729..41116e2c6a2 100644
--- a/arch/arm/mach-imx/mx5/clock.c
+++ b/arch/arm/mach-imx/mx5/clock.c
@@ -940,7 +940,7 @@ void mxc_set_sata_internal_clock(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Dump some core clockes.
  */
diff --git a/arch/arm/mach-imx/mx6/Makefile b/arch/arm/mach-imx/mx6/Makefile
index 7ea8f91e4f0..da461b0be9b 100644
--- a/arch/arm/mach-imx/mx6/Makefile
+++ b/arch/arm/mach-imx/mx6/Makefile
@@ -7,7 +7,7 @@
 
 obj-y	:= soc.o clock.o
 obj-$(CONFIG_IMX_MODULE_FUSE) += module_fuse.o
-obj-$(CONFIG_SPL_BUILD)	     += ddr.o
+obj-$(CONFIG_XPL_BUILD)	     += ddr.o
 obj-$(CONFIG_MP)             += mp.o
 obj-$(CONFIG_MX6UL_LITESOM)  += litesom.o
 obj-$(CONFIG_MX6UL_OPOS6UL)  += opos6ul.o
diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index fb9f56d2e63..b5aa606b8d0 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -1367,7 +1367,7 @@ void disable_ipu_clock(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Dump some core clockes.
  */
diff --git a/arch/arm/mach-imx/mx6/litesom.c b/arch/arm/mach-imx/mx6/litesom.c
index 03e1214c060..c6bf933df94 100644
--- a/arch/arm/mach-imx/mx6/litesom.c
+++ b/arch/arm/mach-imx/mx6/litesom.c
@@ -78,7 +78,7 @@ int litesom_mmc_init(struct bd_info *bis)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/arch/arm/mach-imx/mx6/opos6ul.c b/arch/arm/mach-imx/mx6/opos6ul.c
index 340e6147b63..6a79dcb5bd1 100644
--- a/arch/arm/mach-imx/mx6/opos6ul.c
+++ b/arch/arm/mach-imx/mx6/opos6ul.c
@@ -79,7 +79,7 @@ int dram_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <linux/libfdt.h>
 #include <spl.h>
@@ -210,4 +210,4 @@ void board_init_f(ulong dummy)
 	/* DDR initialization */
 	spl_dram_init();
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 2c0c77e1a56..9b40fe9235a 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -37,7 +37,7 @@ struct scu_regs {
 	u32	fpga_rev;
 };
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_IMX_THERMAL)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_IMX_THERMAL)
 static const struct imx_thermal_plat imx6_thermal_plat = {
 	.regs = (void *)ANATOP_BASE_ADDR,
 	.fuse_bank = 1,
@@ -565,7 +565,7 @@ int board_postclk_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * cfg_val will be used for
  * Boot_cfg4[7:0]:Boot_cfg3[7:0]:Boot_cfg2[7:0]:Boot_cfg1[7:0]
@@ -600,7 +600,7 @@ const struct boot_mode soc_boot_modes[] = {
 
 void reset_misc(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(CONFIG_VIDEO_MXS) && !defined(CONFIG_VIDEO)
 	lcdif_power_down();
 #endif
diff --git a/arch/arm/mach-imx/mx7/clock.c b/arch/arm/mach-imx/mx7/clock.c
index a8606fa9b24..a8328a0b224 100644
--- a/arch/arm/mach-imx/mx7/clock.c
+++ b/arch/arm/mach-imx/mx7/clock.c
@@ -1100,7 +1100,7 @@ void epdc_clock_disable(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Dump some core clockes.
  */
diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index 16c77cbf7be..1b891a2db3d 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -432,7 +432,7 @@ void s_init(void)
 	return;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 const struct boot_mode soc_boot_modes[] = {
 	{"normal",	MAKE_CFGVAL(0x00, 0x00, 0x00, 0x00)},
 	{"primary",	MAKE_CFGVAL_PRIMARY_BOOT},
@@ -450,7 +450,7 @@ int boot_mode_getprisec(void)
 
 void reset_misc(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(CONFIG_VIDEO_MXS) && !defined(CONFIG_VIDEO)
 	lcdif_power_down();
 #endif
diff --git a/arch/arm/mach-imx/mx7ulp/clock.c b/arch/arm/mach-imx/mx7ulp/clock.c
index fb19c62a520..eca92955a17 100644
--- a/arch/arm/mach-imx/mx7ulp/clock.c
+++ b/arch/arm/mach-imx/mx7ulp/clock.c
@@ -327,7 +327,7 @@ void hab_caam_clock_enable(unsigned char enable)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Dump some core clockes.
  */
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 198ae2d919c..980e0226156 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -171,7 +171,7 @@ static bool ldo_mode_is_enabled(void)
 		return false;
 }
 
-#if !defined(CONFIG_SPL) || (defined(CONFIG_SPL) && defined(CONFIG_SPL_BUILD))
+#if !defined(CONFIG_SPL) || (defined(CONFIG_SPL) && defined(CONFIG_XPL_BUILD))
 #if defined(CONFIG_LDO_ENABLED_MODE)
 static void init_ldo_mode(void)
 {
diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
index 922f851c56b..96fe2c7c17b 100644
--- a/arch/arm/mach-imx/syscounter.c
+++ b/arch/arm/mach-imx/syscounter.c
@@ -59,7 +59,7 @@ static inline unsigned long long us_to_tick(unsigned long long usec)
 	return usec;
 }
 
-#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) || IS_ENABLED(CONFIG_SPL_BUILD)
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) || IS_ENABLED(CONFIG_XPL_BUILD)
 int timer_init(void)
 {
 	struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/am62ax/Makefile
index 1717ca343d6..e2ef88196f8 100644
--- a/arch/arm/mach-k3/am62ax/Makefile
+++ b/arch/arm/mach-k3/am62ax/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += am62a7_fdt.o
-obj-$(CONFIG_SPL_BUILD) += am62a7_init.o
+obj-$(CONFIG_XPL_BUILD) += am62a7_init.o
diff --git a/arch/arm/mach-k3/am62px/Makefile b/arch/arm/mach-k3/am62px/Makefile
index eed91a033eb..3165435f265 100644
--- a/arch/arm/mach-k3/am62px/Makefile
+++ b/arch/arm/mach-k3/am62px/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += am62p5_fdt.o
-obj-$(CONFIG_SPL_BUILD) += am62p5_init.o
+obj-$(CONFIG_XPL_BUILD) += am62p5_init.o
diff --git a/arch/arm/mach-k3/am62x/Makefile b/arch/arm/mach-k3/am62x/Makefile
index 8494cdda482..ca10b6a8d3d 100644
--- a/arch/arm/mach-k3/am62x/Makefile
+++ b/arch/arm/mach-k3/am62x/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += am625_fdt.o
-obj-$(CONFIG_SPL_BUILD) += am625_init.o
+obj-$(CONFIG_XPL_BUILD) += am625_init.o
 obj-y += boot.o
diff --git a/arch/arm/mach-k3/am64x/Makefile b/arch/arm/mach-k3/am64x/Makefile
index d0b286276c8..053a8239999 100644
--- a/arch/arm/mach-k3/am64x/Makefile
+++ b/arch/arm/mach-k3/am64x/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += am642_init.o
+obj-$(CONFIG_XPL_BUILD) += am642_init.o
 obj-y += boot.o
diff --git a/arch/arm/mach-k3/am65x/Makefile b/arch/arm/mach-k3/am65x/Makefile
index 20d5f1d3bf1..34734f24ff7 100644
--- a/arch/arm/mach-k3/am65x/Makefile
+++ b/arch/arm/mach-k3/am65x/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += am654_fdt.o
-obj-$(CONFIG_SPL_BUILD) += am654_init.o
+obj-$(CONFIG_XPL_BUILD) += am654_init.o
diff --git a/arch/arm/mach-k3/arm64/cache.S b/arch/arm/mach-k3/arm64/cache.S
index 17cfb12f108..6a507ae3af5 100644
--- a/arch/arm/mach-k3/arm64/cache.S
+++ b/arch/arm/mach-k3/arm64/cache.S
@@ -7,7 +7,7 @@
 #include <config.h>
 #include <linux/linkage.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 ENTRY(__asm_invalidate_l3_dcache)
 	/* Invalidate SPL address range */
 	mov x0, #CONFIG_SPL_TEXT_BASE
diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/j721e/Makefile
index 982b88db57d..e4b0e5a8193 100644
--- a/arch/arm/mach-k3/j721e/Makefile
+++ b/arch/arm/mach-k3/j721e/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j721e_fdt.o
-obj-$(CONFIG_SPL_BUILD) += j721e_init.o
+obj-$(CONFIG_XPL_BUILD) += j721e_init.o
diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/j721s2/Makefile
index ceef68297c9..051ef1b11d8 100644
--- a/arch/arm/mach-k3/j721s2/Makefile
+++ b/arch/arm/mach-k3/j721s2/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j721s2_fdt.o
-obj-$(CONFIG_SPL_BUILD) += j721s2_init.o
+obj-$(CONFIG_XPL_BUILD) += j721s2_init.o
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 05453fcad41..64c34d3dbd6 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -312,7 +312,7 @@ void do_dt_magic(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	k3_spl_init();
diff --git a/arch/arm/mach-k3/j722s/Makefile b/arch/arm/mach-k3/j722s/Makefile
index 2b1fec131ed..9b0dd8afd8b 100644
--- a/arch/arm/mach-k3/j722s/Makefile
+++ b/arch/arm/mach-k3/j722s/Makefile
@@ -4,4 +4,4 @@
 #	Jayesh Choudhary <j-choudhary@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j722s_fdt.o
-obj-$(CONFIG_SPL_BUILD) += j722s_init.o
+obj-$(CONFIG_XPL_BUILD) += j722s_init.o
diff --git a/arch/arm/mach-k3/j784s4/Makefile b/arch/arm/mach-k3/j784s4/Makefile
index 6d1841e3f9e..1d51bcf6e8c 100644
--- a/arch/arm/mach-k3/j784s4/Makefile
+++ b/arch/arm/mach-k3/j784s4/Makefile
@@ -4,4 +4,4 @@
 #	Andrew Davis <afd@ti.com>
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j784s4_fdt.o
-obj-$(CONFIG_SPL_BUILD) += j784s4_init.o
+obj-$(CONFIG_XPL_BUILD) += j784s4_init.o
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index d3886caa064..f533c5e7743 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -16,6 +16,6 @@ obj-y += common.o
 obj-y += lowlevel_init.o
 obj-y += r5_mpu.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
 endif
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 7c46914d9dd..3468a370a45 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -126,7 +126,7 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
 	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
 	 * protocol transactions.
 	 */
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
 	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
 	      spl_boot_device() == BOOT_DEVICE_UART))
 		printf("Authentication passed\n");
diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index 6c7c25090a2..c864317baea 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -10,7 +10,7 @@ obj-y	+= psc.o
 obj-y	+= clock.o
 obj-y	+= mon.o
 CFLAGS_REMOVE_mon.o := $(LTO_CFLAGS)
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y	+= cmd_clock.o
 obj-y	+= cmd_mon.o
 obj-y	+= cmd_poweroff.o
diff --git a/arch/arm/mach-keystone/config.mk b/arch/arm/mach-keystone/config.mk
index 8eccbdb3018..925a2deee23 100644
--- a/arch/arm/mach-keystone/config.mk
+++ b/arch/arm/mach-keystone/config.mk
@@ -7,7 +7,7 @@
 
 include  $(srctree)/arch/arm/mach-omap2/config_secure.mk
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifeq ($(CONFIG_TI_SECURE_DEVICE),y)
 INPUTS-y += u-boot_HS_MLO
 else
@@ -25,7 +25,7 @@ OBJCOPYFLAGS_u-boot-spi.gph = -I binary -O binary --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-spi.gph: spl/u-boot-spl.gph u-boot.img FORCE
 	$(call if_changed,pad_cat)
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 MKIMAGEFLAGS_MLO = -A $(ARCH) -T gpimage -C none \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_TEXT_BASE) -n U-Boot
 MLO: u-boot.bin FORCE
diff --git a/arch/arm/mach-keystone/mon.c b/arch/arm/mach-keystone/mon.c
index b945e19ec77..f99b9fbca2e 100644
--- a/arch/arm/mach-keystone/mon.c
+++ b/arch/arm/mach-keystone/mon.c
@@ -134,7 +134,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
 	 * protocol transactions.
 	 */
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
 	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
 	      spl_boot_device() == BOOT_DEVICE_UART))
 		printf("Authentication passed\n");
diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
index 6303570beea..f551abb4772 100644
--- a/arch/arm/mach-lpc32xx/Makefile
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -5,4 +5,4 @@
 
 obj-y   = cpu.o clk.o devices.o timer.o
 
-obj-$(CONFIG_SPL_BUILD) += dram.o lowlevel_init.o
+obj-$(CONFIG_XPL_BUILD) += dram.o lowlevel_init.o
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 46bdab88206..3d9e4684fb4 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y	+= cpu.o
-obj-$(CONFIG_SPL_BUILD)	+= spl.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
 obj-$(CONFIG_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/mt7629/lowlevel_init.S b/arch/arm/mach-mediatek/mt7629/lowlevel_init.S
index 0a0672cbea7..9f19003e43b 100644
--- a/arch/arm/mach-mediatek/mt7629/lowlevel_init.S
+++ b/arch/arm/mach-mediatek/mt7629/lowlevel_init.S
@@ -16,7 +16,7 @@
 
 ENTRY(lowlevel_init)
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Return to U-Boot via saved link register */
 	mov	pc, lr
 #else
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 329c2e49153..35fd2d0a1d2 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -22,7 +22,7 @@ else # CONFIG_ARCH_KIRKWOOD
 obj-y	= cpu.o
 obj-y	+= dram.o
 obj-y	+= lowlevel.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMADA_375) += ../../../drivers/ddr/marvell/axp/xor.o
 obj-$(CONFIG_ARMADA_38X) += ../../../drivers/ddr/marvell/a38x/xor.o
 obj-$(CONFIG_ARMADA_XP) += ../../../drivers/ddr/marvell/axp/xor.o
@@ -110,11 +110,11 @@ $(obj)/kwbimage.cfg: $(src)/kwbimage.cfg.in include/autoconf.mk \
 		include/config/auto.conf
 	$(call cmd,kwbcfg)
 
-endif # CONFIG_SPL_BUILD
+endif # CONFIG_XPL_BUILD
 obj-y	+= gpio.o
 obj-y	+= mbus.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
-obj-$(CONFIG_SPL_BUILD) += lowlevel_spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += lowlevel_spl.o
 
 obj-$(CONFIG_ARMADA_38X) += serdes/a38x/
 obj-$(CONFIG_ARMADA_XP) += serdes/axp/
diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 8a145a5f742..da44727cf4f 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -52,7 +52,7 @@ void lowlevel_init(void)
 	 */
 }
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET)
 void reset_cpu(void)
 {
 	struct mvebu_system_registers *reg =
@@ -549,7 +549,7 @@ static void ahci_mvebu_mbus_config(void __iomem *base)
 	int i;
 
 	/* mbus is not initialized in SPL; keep the ROM settings */
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return;
 
 	dram = mvebu_mbus_dram_info();
diff --git a/arch/arm/mach-mvebu/include/mach/cpu.h b/arch/arm/mach-mvebu/include/mach/cpu.h
index af6ce2920e6..37a00501214 100644
--- a/arch/arm/mach-mvebu/include/mach/cpu.h
+++ b/arch/arm/mach-mvebu/include/mach/cpu.h
@@ -66,7 +66,7 @@ enum cpu_attrib {
 /*
  * Default Device Address MAP BAR values
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_ARMADA_38X
 #define MBUS_PCI_MEM_BASE	0x88000000
 #define MBUS_PCI_MEM_SIZE	((3 * 128) << 20)
@@ -81,19 +81,19 @@ enum cpu_attrib {
 #define MBUS_PCI_IO_BASE	0xF1100000
 #define MBUS_PCI_IO_SIZE	((MBUS_PCI_MAX_PORTS * 64) << 10)
 #endif
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define MBUS_SPI_BASE		0xD4000000
 #define MBUS_SPI_SIZE		(64 << 20)
 #else
 #define MBUS_SPI_BASE		0xF4000000
 #define MBUS_SPI_SIZE		(8 << 20)
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define MBUS_DFX_BASE		0xF6000000
 #define MBUS_DFX_SIZE		(1 << 20)
 #endif
 #define MBUS_BOOTROM_BASE	0xF8000000
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define MBUS_BOOTROM_SIZE	(128 << 20)
 #else
 #define MBUS_BOOTROM_SIZE	(8 << 20)
diff --git a/arch/arm/mach-mvebu/include/mach/soc.h b/arch/arm/mach-mvebu/include/mach/soc.h
index dc68d406f99..495530d8452 100644
--- a/arch/arm/mach-mvebu/include/mach/soc.h
+++ b/arch/arm/mach-mvebu/include/mach/soc.h
@@ -36,7 +36,7 @@
 /* SOC specific definations */
 #define INTREG_BASE		0xd0000000
 #define INTREG_BASE_ADDR_REG	(INTREG_BASE + 0x20080)
-#if defined(CONFIG_SPL_BUILD) || defined(CONFIG_ARMADA_3700)
+#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_ARMADA_3700)
 /*
  * The SPL U-Boot version still runs with the default
  * address for the internal registers, configured by
diff --git a/arch/arm/mach-mvebu/serdes/a38x/Makefile b/arch/arm/mach-mvebu/serdes/a38x/Makefile
index 5a70b375966..c33e272217d 100644
--- a/arch/arm/mach-mvebu/serdes/a38x/Makefile
+++ b/arch/arm/mach-mvebu/serdes/a38x/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD)	+= high_speed_env_spec.o
-obj-$(CONFIG_SPL_BUILD)	+= high_speed_env_spec-38x.o
-obj-$(CONFIG_SPL_BUILD)	+= seq_exec.o
-obj-$(CONFIG_SPL_BUILD)	+= sys_env_lib.o
+obj-$(CONFIG_XPL_BUILD)	+= high_speed_env_spec.o
+obj-$(CONFIG_XPL_BUILD)	+= high_speed_env_spec-38x.o
+obj-$(CONFIG_XPL_BUILD)	+= seq_exec.o
+obj-$(CONFIG_XPL_BUILD)	+= sys_env_lib.o
diff --git a/arch/arm/mach-mvebu/serdes/axp/Makefile b/arch/arm/mach-mvebu/serdes/axp/Makefile
index 897afb703ad..7d48f8da9ed 100644
--- a/arch/arm/mach-mvebu/serdes/axp/Makefile
+++ b/arch/arm/mach-mvebu/serdes/axp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD)	= high_speed_env_lib.o
-obj-$(CONFIG_SPL_BUILD)	+= high_speed_env_spec.o
+obj-$(CONFIG_XPL_BUILD)	= high_speed_env_lib.o
+obj-$(CONFIG_XPL_BUILD)	+= high_speed_env_spec.o
diff --git a/arch/arm/mach-nexell/include/mach/display.h b/arch/arm/mach-nexell/include/mach/display.h
index b0ee9126057..3a4e2c47f5e 100644
--- a/arch/arm/mach-nexell/include/mach/display.h
+++ b/arch/arm/mach-nexell/include/mach/display.h
@@ -265,7 +265,7 @@ int dp_plane_set_enable(int module, int layer, int on);
 int dp_plane_set_address(int module, int layer, unsigned int address);
 int dp_plane_wait_vsync(int module, int layer, int fps);
 
-#if defined CONFIG_SPL_BUILD ||	\
+#if defined CONFIG_XPL_BUILD ||	\
 	(!defined(CONFIG_DM) && !defined(CONFIG_OF_CONTROL))
 int nx_display_probe(struct nx_display_plat *plat);
 #endif
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d683c64566a..9a85c764a55 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,7 +11,7 @@ obj-y	+= reset.o
 ifeq ($(CONFIG_TIMER),)
 obj-y	+= timer.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= timer.o
 endif
 endif
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 548d6b7cfe4..4e9ad8935e3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -209,7 +209,7 @@ int cpu_mmc_init(struct bd_info *bis)
 
 /* AM33XX has two MUSB controllers which can be host or gadget */
 #if (defined(CONFIG_AM335X_USB0) || defined(CONFIG_AM335X_USB1)) && \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 
 static struct musb_hdrc_config musb_config = {
 	.multipoint     = 1,
@@ -282,7 +282,7 @@ int arch_misc_init(void)
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 
 #if defined(CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC) || \
-	(defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT))
+	(defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT))
 static void rtc32k_unlock(struct davinci_rtc *rtc)
 {
 	/*
@@ -295,7 +295,7 @@ static void rtc32k_unlock(struct davinci_rtc *rtc)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
 /*
  * Write contents of the RTC_SCRATCH1 register based on board type
  * Two things are passed
@@ -331,7 +331,7 @@ int board_early_init_f(void)
 {
 	set_mux_conf_regs();
 	prcm_init();
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
 	update_rtc_magic();
 #endif
 	return 0;
@@ -379,7 +379,7 @@ static void watchdog_disable(void)
 		;
 }
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
 /*
  * Check if we are executing rtc-only + DDR mode, and resume from it if needed
  */
@@ -455,7 +455,7 @@ am43xx_wait:
 
 void s_init(void)
 {
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RTC_DDR_SUPPORT)
 	rtc_only();
 #endif
 }
@@ -474,7 +474,7 @@ void early_system_init(void)
 	set_uart_mux_conf();
 	setup_early_clocks();
 	uart_soft_reset();
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * Save the boot parameters passed from romcode.
 	 * We cannot delay the saving further than this,
@@ -483,7 +483,7 @@ void early_system_init(void)
 	save_omap_boot_params();
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	spl_early_init();
 #endif
 
@@ -497,7 +497,7 @@ void early_system_init(void)
 #endif
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	hw_data_init();
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index 649bc07047a..ddd7eeaf052 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -173,7 +173,7 @@ void save_omap_boot_params(void)
 #endif
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 u32 spl_boot_device(void)
 {
 	return gd->arch.omap_boot_device;
@@ -208,7 +208,7 @@ void spl_boot_ipu(void)
 	int ret, size;
 	u32 loadaddr = IPU1_LOAD_ADDR;
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) ||
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) ||
 	    !IS_ENABLED(CONFIG_REMOTEPROC_TI_IPU))
 		return;
 
@@ -286,7 +286,7 @@ void spl_soc_init(void)
 #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
 	hw_watchdog_init();
 #endif
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    IS_ENABLED(CONFIG_REMOTEPROC_TI_IPU))
 		spl_boot_ipu();
 }
diff --git a/arch/arm/mach-omap2/clocks-common.c b/arch/arm/mach-omap2/clocks-common.c
index 18d099145c5..f05b16797ec 100644
--- a/arch/arm/mach-omap2/clocks-common.c
+++ b/arch/arm/mach-omap2/clocks-common.c
@@ -24,7 +24,7 @@
 #include <asm/omap_gpio.h>
 #include <asm/emif.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * printing to console doesn't work unless
  * this code is executed from SPL
diff --git a/arch/arm/mach-omap2/config.mk b/arch/arm/mach-omap2/config.mk
index 30d8fb1b1d9..02b26733ee6 100644
--- a/arch/arm/mach-omap2/config.mk
+++ b/arch/arm/mach-omap2/config.mk
@@ -5,7 +5,7 @@
 
 include  $(srctree)/arch/arm/mach-omap2/config_secure.mk
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifeq ($(CONFIG_TI_SECURE_DEVICE),y) # Refer to README.ti-secure for more info
 # On DRA7xx/AM57xx:
 #
diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
index 40db1aec142..62ac27dfa90 100644
--- a/arch/arm/mach-omap2/config_secure.mk
+++ b/arch/arm/mach-omap2/config_secure.mk
@@ -4,7 +4,7 @@
 quiet_cmd_mkomapsecimg = SECURE  $@
 ifneq ($(TI_SECURE_DEV_PKG),)
 ifneq ($(wildcard $(TI_SECURE_DEV_PKG)/scripts/create-boot-image.sh),)
-ifneq ($(CONFIG_SPL_BUILD),)
+ifneq ($(CONFIG_XPL_BUILD),)
 cmd_mkomapsecimg = $(TI_SECURE_DEV_PKG)/scripts/create-boot-image.sh \
 	$(patsubst u-boot-spl_HS_%,%,$(@F)) $< $@ $(CONFIG_SPL_TEXT_BASE) \
 	$(if $(KBUILD_VERBOSE:1=), >/dev/null)
diff --git a/arch/arm/mach-omap2/hwinit-common.c b/arch/arm/mach-omap2/hwinit-common.c
index bb67e50fd56..b1e486a99d9 100644
--- a/arch/arm/mach-omap2/hwinit-common.c
+++ b/arch/arm/mach-omap2/hwinit-common.c
@@ -113,7 +113,7 @@ static void omap_rev_string(void)
 		puts("\n");
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_display_print(void)
 {
 	omap_rev_string();
@@ -175,7 +175,7 @@ void __weak init_package_revision(void)
  */
 int early_system_init(void)
 {
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_MULTI_DTB_FIT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_MULTI_DTB_FIT)
 	int ret;
 	int rescan;
 #endif
@@ -183,19 +183,19 @@ int early_system_init(void)
 	hw_data_init();
 	init_package_revision();
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	if (warm_reset())
 		force_emif_self_refresh();
 #endif
 	watchdog_init();
 	set_mux_conf_regs();
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	srcomp_enable();
 	do_io_settings();
 #endif
 	setup_early_clocks();
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * Save the boot parameters passed from romcode.
 	 * We cannot delay the saving further than this,
@@ -206,7 +206,7 @@ int early_system_init(void)
 #endif
 	do_board_detect();
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_MULTI_DTB_FIT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_MULTI_DTB_FIT)
 	/*
 	 * Board detection has been done.
 	 * Let us see if another dtb wouldn't be a better match
@@ -228,7 +228,7 @@ int early_system_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	early_system_init();
diff --git a/arch/arm/mach-omap2/omap3/Makefile b/arch/arm/mach-omap2/omap3/Makefile
index 151bdf6ebc9..159633e7f6d 100644
--- a/arch/arm/mach-omap2/omap3/Makefile
+++ b/arch/arm/mach-omap2/omap3/Makefile
@@ -15,7 +15,7 @@ obj-y	+= clock.o
 obj-y	+= sys_info.o
 obj-y	+= prcm-regs.o
 obj-y	+= hw_data.o
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_OMAP3_ID_NAND)	+= spl_id_nand.o
 endif
 
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index 1de343ff48e..4b6ce6940a9 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -211,7 +211,7 @@ void s_init(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	early_system_init();
@@ -280,7 +280,7 @@ void abort(void)
 {
 }
 
-#if defined(CONFIG_NAND_OMAP_GPMC) & !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NAND_OMAP_GPMC) & !defined(CONFIG_XPL_BUILD)
 /******************************************************************************
  * OMAP3 specific command to switch between NAND HW and SW ecc
  *****************************************************************************/
@@ -331,7 +331,7 @@ U_BOOT_CMD(
 	"nandecc sw               - Switch to NAND software ecc algorithm."
 );
 
-#endif /* CONFIG_NAND_OMAP_GPMC & !CONFIG_SPL_BUILD */
+#endif /* CONFIG_NAND_OMAP_GPMC & !CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_DISPLAY_BOARDINFO
 /**
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 404333689f6..24fae484369 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -146,7 +146,7 @@ static void do_sdrc_init(u32 cs, u32 early)
 	 * then set cs_cfg to the appropriate value then try and
 	 * setup CS1.
 	 */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* set/modify board-specific timings */
 	get_board_mem_timings(&timings);
 #endif
@@ -166,7 +166,7 @@ static void do_sdrc_init(u32 cs, u32 early)
 
 		writel(ENADLL | DLLPHASE_90, &sdrc_base->dlla_ctrl);
 		sdelay(0x20000);
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		write_sdrc_timings(CS0, sdrc_actim_base0, &timings);
 		make_cs1_contiguous();
 		write_sdrc_timings(CS1, sdrc_actim_base1, &timings);
diff --git a/arch/arm/mach-omap2/omap5/hwinit.c b/arch/arm/mach-omap2/omap5/hwinit.c
index 7f41e85c4a6..42f9c63fe12 100644
--- a/arch/arm/mach-omap2/omap5/hwinit.c
+++ b/arch/arm/mach-omap2/omap5/hwinit.c
@@ -50,7 +50,7 @@ void do_set_mux32(u32 base, struct pad_conf_entry const *array, int size)
 		writel(pad->val, base + pad->offset);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* LPDDR2 specific IO settings */
 static void io_settings_lpddr2(void)
 {
diff --git a/arch/arm/mach-omap2/sec-common.c b/arch/arm/mach-omap2/sec-common.c
index 16bbc93f4a3..b1d11a4d1a4 100644
--- a/arch/arm/mach-omap2/sec-common.c
+++ b/arch/arm/mach-omap2/sec-common.c
@@ -178,7 +178,7 @@ auth_exit:
 	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
 	 * protocol transactions.
 	 */
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
 	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
 	      spl_boot_device() == BOOT_DEVICE_UART))
 		printf("Authentication passed\n");
diff --git a/arch/arm/mach-orion5x/cpu.c b/arch/arm/mach-orion5x/cpu.c
index 58ee67eca50..4eba69a6909 100644
--- a/arch/arm/mach-orion5x/cpu.c
+++ b/arch/arm/mach-orion5x/cpu.c
@@ -235,7 +235,7 @@ int arch_cpu_init(void)
 	/* Enable and invalidate L2 cache in write through mode */
 	invalidate_l2_cache();
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	orion5x_config_adr_windows();
 #endif
 
diff --git a/arch/arm/mach-orion5x/lowlevel_init.S b/arch/arm/mach-orion5x/lowlevel_init.S
index aa3fcf7c301..358d2a49fbb 100644
--- a/arch/arm/mach-orion5x/lowlevel_init.S
+++ b/arch/arm/mach-orion5x/lowlevel_init.S
@@ -69,7 +69,7 @@
 
 lowlevel_init:
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 	/* Use 'r2 as the base for internal register accesses */
 	ldr	r2, =ORION5X_REGS_PHY_BASE
@@ -280,7 +280,7 @@ lowlevel_init:
 	ldr	r0, =0x7fff0001
 	str	r0, [r3, #0x504]
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 	/* Return to U-Boot via saved link register */
 	mov	pc, lr
diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index 1d8c3eea99c..fe88a2e0373 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -9,7 +9,7 @@
 _start:
 	ARM_VECTORS
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.word	0x0badc0d3;
 	.word	0x0badc0d3;
 	.word	0x0badc0d3;
diff --git a/arch/arm/mach-renesas/lowlevel_init_ca15.S b/arch/arm/mach-renesas/lowlevel_init_ca15.S
index 059cd738785..ecefa3d5c43 100644
--- a/arch/arm/mach-renesas/lowlevel_init_ca15.S
+++ b/arch/arm/mach-renesas/lowlevel_init_ca15.S
@@ -11,7 +11,7 @@
 #include <system-constants.h>
 
 ENTRY(lowlevel_init)
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	mrc	p15, 0, r4, c0, c0, 5 /* mpidr */
 	orr	r4, r4, r4, lsr #6
 	and	r4, r4, #7 /* id 0-3 = ca15.0,1,2,3 */
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 3b13891ec24..76756c3661b 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
@@ -51,5 +51,5 @@ obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 obj-spl-$(CONFIG_TPL_BUILD) =
 
 # Now add SPL/TPL objects back into the main build
-obj-$(CONFIG_SPL_BUILD) += $(obj-spl-y)
+obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
 obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 8b1509e55f2..8ce9ac561f0 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -244,7 +244,7 @@ int arch_cpu_init(void)
 	static struct px30_cru * const cru = (void *)CRU_BASE;
 	u32 __maybe_unused val;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* We do some SoC one time setting here. */
 	/* Disable the ddr secure region setting to make it non-secure */
 	writel(0x0, DDR_FW_BASE + FW_DDR_CON);
diff --git a/arch/arm/mach-rockchip/rk3036/Makefile b/arch/arm/mach-rockchip/rk3036/Makefile
index 299fc50635d..038180c275c 100644
--- a/arch/arm/mach-rockchip/rk3036/Makefile
+++ b/arch/arm/mach-rockchip/rk3036/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += clk_rk3036.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += syscon_rk3036.o
 endif
 
diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
index 70b55ca8abf..b8c177a4d0d 100644
--- a/arch/arm/mach-rockchip/rk3066/rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
@@ -27,7 +27,7 @@ void board_debug_uart_init(void)
 
 void spl_board_init(void)
 {
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		return;
 
 	if (IS_ENABLED(CONFIG_SPL_DM_MMC)) {
diff --git a/arch/arm/mach-rockchip/rk3188/rk3188.c b/arch/arm/mach-rockchip/rk3188/rk3188.c
index 53b2eaa2d53..7cce1112fbd 100644
--- a/arch/arm/mach-rockchip/rk3188/rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/rk3188.c
@@ -51,7 +51,7 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 int arch_cpu_init(void)
 {
 	struct rk3188_grf *grf;
@@ -106,7 +106,7 @@ int rk_board_late_init(void)
 	return rk3188_board_late_init();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int setup_led(void)
 {
 #ifdef CONFIG_SPL_LED
diff --git a/arch/arm/mach-rockchip/rk322x/rk322x.c b/arch/arm/mach-rockchip/rk322x/rk322x.c
index 712c0524266..e35ca7778e7 100644
--- a/arch/arm/mach-rockchip/rk322x/rk322x.c
+++ b/arch/arm/mach-rockchip/rk322x/rk322x.c
@@ -51,7 +51,7 @@ void board_debug_uart_init(void)
 
 int arch_cpu_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SGRF_BASE	0x10150000
 	static struct rk322x_sgrf * const sgrf = (void *)SGRF_BASE;
 
diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index d1170f7e23d..62dd9da6578 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -31,7 +31,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void configure_l2ctlr(void)
 {
 	u32 l2ctlr;
@@ -72,7 +72,7 @@ int rk3288_qos_init(void)
 
 int arch_cpu_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	configure_l2ctlr();
 #else
 	/* We do some SoC one time setting here. */
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 6f88638d156..c6b1a35f47e 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -185,7 +185,7 @@ __weak void board_debug_uart_init(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 int arch_cpu_init(void)
 {
 	static struct rk3308_sgrf * const sgrf = (void *)SGRF_BASE;
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index c86d11943d6..12ad17d9e8b 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -62,7 +62,7 @@ struct mm_region *mem_map = rk3328_mem_map;
 
 int arch_cpu_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	u32 reg;
 
 	/* We do some SoC one time setting here. */
diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
index f589bf67328..97b9500da25 100644
--- a/arch/arm/mach-rockchip/rk3368/rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
@@ -93,7 +93,7 @@ int arch_early_init_r(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * The SPL (and also the full U-Boot stage on the RK3368) will run in
  * secure mode (i.e. EL3) and an ATF will eventually be booted before
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 2d7d0f82a2f..edccb2a3980 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -51,7 +51,7 @@ static struct mm_region rk3399_mem_map[] = {
 
 struct mm_region *mem_map = rk3399_mem_map;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define TIMER_END_COUNT_L	0x00
 #define TIMER_END_COUNT_H	0x04
@@ -83,7 +83,7 @@ void rockchip_stimer_init(void)
 int arch_cpu_init(void)
 {
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct rk3399_pmusgrf_regs *sgrf;
 	struct rk3399_grf_regs *grf;
 
@@ -136,7 +136,7 @@ void board_debug_uart_init(void)
 	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
 	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
 	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
 		rk_setreg(&grf->io_vsel, 1 << 0);
@@ -169,7 +169,7 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
 static void rk3399_force_power_on_reset(void)
 {
 	ofnode node;
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 1b3e40074e3..768a3739329 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -105,7 +105,7 @@ void board_debug_uart_init(void)
 
 int arch_cpu_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * When perform idle operation, corresponding clock can
 	 * be opened or gated automatically.
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index d3162d3447e..e2dac2a5b80 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -111,7 +111,7 @@ void board_debug_uart_init(void)
 		     GPIO0B5_UART2_TX_M0 << GPIO0B5_SHIFT);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void rockchip_stimer_init(void)
 {
 	/* If Timer already enabled, don't re-init it */
@@ -130,7 +130,7 @@ void rockchip_stimer_init(void)
 #ifndef CONFIG_TPL_BUILD
 int arch_cpu_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG
 	static struct rk3588_sysgrf * const sys_grf = (void *)SYS_GRF_BASE;
 #endif
diff --git a/arch/arm/mach-rockchip/rv1108/Makefile b/arch/arm/mach-rockchip/rv1108/Makefile
index 9035a1a8923..283fc966e7b 100644
--- a/arch/arm/mach-rockchip/rv1108/Makefile
+++ b/arch/arm/mach-rockchip/rv1108/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:     GPL-2.0+
 #
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += syscon_rv1108.o
 endif
 obj-y += rv1108.o
diff --git a/arch/arm/mach-rockchip/rv1126/rv1126.c b/arch/arm/mach-rockchip/rv1126/rv1126.c
index 1c10e9b9f23..27ed5dc19e1 100644
--- a/arch/arm/mach-rockchip/rv1126/rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/rv1126.c
@@ -66,7 +66,7 @@ int arch_cpu_init(void)
 	 * since they are unsecure.
 	 * (Note: only secure-world can access this register)
 	 */
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		writel(0, FIREWALL_APB_BASE + FW_DDR_CON_REG);
 
 	return 0;
diff --git a/arch/arm/mach-sc5xx/Makefile b/arch/arm/mach-sc5xx/Makefile
index eeb56c078b3..598a13031b4 100644
--- a/arch/arm/mach-sc5xx/Makefile
+++ b/arch/arm/mach-sc5xx/Makefile
@@ -15,5 +15,5 @@ obj-$(CONFIG_SC58X) += sc58x.o
 obj-$(CONFIG_SC59X) += sc59x.o
 obj-$(CONFIG_SC59X_64) += sc59x_64.o
 
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 obj-$(CONFIG_SYSCON) += rcu.o
diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
index 580964e559c..e7e4c9a1181 100644
--- a/arch/arm/mach-sc5xx/config.mk
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -8,7 +8,7 @@
 # Contact: Greg Malysa <greg.malysa@timesys.com>
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 INPUTS-y += $(obj)/u-boot-spl.ldr
 endif
 
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 67c6a8dfec5..5fc61b4a5c6 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -80,7 +80,7 @@ obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_TARGET_SOCFPGA_GEN5
 obj-y	+= spl_gen5.o
 obj-y	+= freeze_controller.o
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index feaf5ce4596..24a15f7903f 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -102,7 +102,7 @@ u8 socfpga_get_board_id(void)
 	u32 jtag_usercode;
 	int err;
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)
 	err = smc_get_usercode(&jtag_usercode);
 #else
 	u32 resp_len = 1;
@@ -130,7 +130,7 @@ u8 socfpga_get_board_id(void)
 	return board_id;
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
+#if IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
 int board_fit_config_name_match(const char *name)
 {
 	char board_name[10];
@@ -154,7 +154,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 }
 #endif
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_FIT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_FIT)
 void board_prep_linux(struct bootm_headers *images)
 {
 	bool use_fit = false;
diff --git a/arch/arm/mach-socfpga/clock_manager.c b/arch/arm/mach-socfpga/clock_manager.c
index 160f6e73ca9..134eaf08e0a 100644
--- a/arch/arm/mach-socfpga/clock_manager.c
+++ b/arch/arm/mach-socfpga/clock_manager.c
@@ -99,7 +99,7 @@ unsigned int cm_get_qspi_controller_clk_hz(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_showclocks(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
diff --git a/arch/arm/mach-socfpga/clock_manager_arria10.c b/arch/arm/mach-socfpga/clock_manager_arria10.c
index 58b9321131a..5674194f4d1 100644
--- a/arch/arm/mach-socfpga/clock_manager_arria10.c
+++ b/arch/arm/mach-socfpga/clock_manager_arria10.c
@@ -12,7 +12,7 @@
 #include <asm/arch/clock_manager.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 void sdelay(unsigned long loops);
 u32 wait_on_value(u32 read_bit_mask, u32 match_value, void *read_addr,
diff --git a/arch/arm/mach-socfpga/include/mach/boot0.h b/arch/arm/mach-socfpga/include/mach/boot0.h
index c78def5066e..2676d6c8283 100644
--- a/arch/arm/mach-socfpga/include/mach/boot0.h
+++ b/arch/arm/mach-socfpga/include/mach/boot0.h
@@ -9,7 +9,7 @@
 _start:
 	ARM_VECTORS
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.balignl 64,0xf33db33f;
 
 	.word	0x1337c0d3;	/* SoCFPGA preloader validation word */
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/clock_manager_arria10.h
index 553ebe660de..80d5047b469 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager_arria10.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_arria10.h
@@ -62,7 +62,7 @@
 #define CLKMGR_INTER				CLKMGR_A10_INTER
 #define CLKMGR_PERPLL_EN			CLKMGR_A10_PERPLL_EN
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 int cm_basic_init(const void *blob);
 #endif
 
diff --git a/arch/arm/mach-socfpga/lowlevel_init_soc64.S b/arch/arm/mach-socfpga/lowlevel_init_soc64.S
index 875927cc4d9..8926c2d1d9c 100644
--- a/arch/arm/mach-socfpga/lowlevel_init_soc64.S
+++ b/arch/arm/mach-socfpga/lowlevel_init_soc64.S
@@ -13,7 +13,7 @@ ENTRY(lowlevel_init)
 	mov	x29, lr			/* Save LR */
 
 #if defined(CONFIG_GICV2) || defined(CONFIG_GICV3)
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 wait_for_atf:
 	ldr	x4, =CPU_RELEASE_ADDR
 	ldr	x5, [x4]
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index 4c86f1e9917..2b4f26040fe 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -400,7 +400,7 @@ error:
 
 int mbox_reset_cold(void)
 {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	psci_system_reset();
 #else
 	int ret;
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 495ba2a0d41..46f9c82bbb2 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -180,7 +180,7 @@ int arch_cpu_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 34c21317894..c442af02888 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -58,7 +58,7 @@ static Altera_desc altera_fpga[] = {
 	},
 };
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static struct pl310_regs *const pl310 =
 	(struct pl310_regs *)CFG_SYS_PL310_BASE;
 static const struct socfpga_noc_fw_ocram *noc_fw_ocram_base =
diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
index b898b6f8f22..b136691c685 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -213,7 +213,7 @@ int arch_early_init_r(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static struct socfpga_sdr_ctrl *sdr_ctrl =
 	(struct socfpga_sdr_ctrl *)SDR_CTRLGRP_ADDRESS;
 
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_s10.c
index dd0383c7c76..a634c11a028 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_s10.c
@@ -58,7 +58,7 @@ void socfpga_per_reset_all(void)
 
 void socfpga_bridges_reset(int enable)
 {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	u64 arg = enable;
 
 	int ret = invoke_smc(INTEL_SIP_SMC_HPS_SET_BRIDGES, &arg, 1, NULL, 0);
diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-socfpga/secure_vab.c
index 4347bf6e792..e931f1043b3 100644
--- a/arch/arm/mach-socfpga/secure_vab.c
+++ b/arch/arm/mach-socfpga/secure_vab.c
@@ -120,7 +120,7 @@ int socfpga_vendor_authentication(void **p_image, size_t *p_size)
 	debug("mbox_relocate_data_addr = 0x%p\n", mbox_relocate_data_addr);
 
 	do {
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)) {
 			/* Invoke SMC call to ATF to send the VAB certificate to SDM */
 			ret  = smc_send_mailbox(MBOX_VAB_SRC_CERT, mbox_data_sz,
 						(u32 *)mbox_relocate_data_addr, 0, &resp_len,
diff --git a/arch/arm/mach-socfpga/timer_s10.c b/arch/arm/mach-socfpga/timer_s10.c
index 80933586319..1a4e7c0e7e2 100644
--- a/arch/arm/mach-socfpga/timer_s10.c
+++ b/arch/arm/mach-socfpga/timer_s10.c
@@ -14,7 +14,7 @@
  */
 int timer_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	int enable = 0x3;	/* timer enable + output signal masked */
 	int loadval = ~0;
 
@@ -56,4 +56,4 @@ __always_inline void __udelay(unsigned long usec)
 
 	while (__get_time_stamp() < tmp + 1)	/* loop till event */
 		;
-}
\ No newline at end of file
+}
diff --git a/arch/arm/mach-socfpga/wrap_pll_config_soc64.c b/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
index f13581033e6..60ba557d390 100644
--- a/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
@@ -11,7 +11,7 @@
 
 const struct cm_config * const cm_get_default_config(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct cm_config *cm_handoff_cfg = (struct cm_config *)
 		(SOC64_HANDOFF_CLOCK + SOC64_HANDOFF_OFFSET_DATA);
 	u32 *conversion = (u32 *)cm_handoff_cfg;
@@ -32,7 +32,7 @@ const struct cm_config * const cm_get_default_config(void)
 
 const unsigned int cm_get_osc_clk_hz(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 	u32 clock = readl(SOC64_HANDOFF_CLOCK_OSC);
 
@@ -50,7 +50,7 @@ const unsigned int cm_get_intosc_clk_hz(void)
 
 const unsigned int cm_get_fpga_clk_hz(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	u32 clock = readl(SOC64_HANDOFF_CLOCK_FPGA);
 
 	writel(clock,
diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
index ee8a5428feb..db7ed19bd91 100644
--- a/arch/arm/mach-stm32mp/Makefile
+++ b/arch/arm/mach-stm32mp/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_STM32MP13X) += stm32mp1/
 obj-$(CONFIG_STM32MP25X) += stm32mp2/
 
 obj-$(CONFIG_STM32_ECDSA_VERIFY) += ecdsa_romapi.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += cmd_stm32prog/
 obj-$(CONFIG_CMD_STM32KEY) += cmd_stm32key.o
 obj-$(CONFIG_TFABOOT) += boot_params.o
diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
index 9ba7a6c9a89..9cbe6a52623 100644
--- a/arch/arm/mach-stm32mp/bsec.c
+++ b/arch/arm/mach-stm32mp/bsec.c
@@ -409,7 +409,7 @@ static int stm32mp_bsec_read_otp(struct udevice *dev, u32 *val, u32 otp)
 	u32 tmp_data = 0;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_XPL_BUILD))
 		return stm32_smc(STM32_SMC_BSEC,
 				 STM32_SMC_READ_OTP,
 				 otp, 0, val);
@@ -440,7 +440,7 @@ static int stm32mp_bsec_read_shadow(struct udevice *dev, u32 *val, u32 otp)
 {
 	struct stm32mp_bsec_plat *plat;
 
-	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_XPL_BUILD))
 		return stm32_smc(STM32_SMC_BSEC,
 				 STM32_SMC_READ_SHADOW,
 				 otp, 0, val);
@@ -469,7 +469,7 @@ static int stm32mp_bsec_write_otp(struct udevice *dev, u32 val, u32 otp)
 {
 	struct stm32mp_bsec_plat *plat;
 
-	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_XPL_BUILD))
 		return stm32_smc_exec(STM32_SMC_BSEC,
 				      STM32_SMC_PROG_OTP,
 				      otp, val);
@@ -484,7 +484,7 @@ static int stm32mp_bsec_write_shadow(struct udevice *dev, u32 val, u32 otp)
 {
 	struct stm32mp_bsec_plat *plat;
 
-	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_XPL_BUILD))
 		return stm32_smc_exec(STM32_SMC_BSEC,
 				      STM32_SMC_WRITE_SHADOW,
 				      otp, val);
@@ -504,7 +504,7 @@ static int stm32mp_bsec_write_lock(struct udevice *dev, u32 val, u32 otp)
 		return 0; /* nothing to do */
 	}
 
-	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_ARM_SMCCC) && !IS_ENABLED(CONFIG_XPL_BUILD))
 		return stm32_smc_exec(STM32_SMC_BSEC,
 				      STM32_SMC_WRLOCK_OTP,
 				      otp, 0);
@@ -762,7 +762,7 @@ static int stm32mp_bsec_probe(struct udevice *dev)
 	 * update unlocked shadow for OTP cleared by the rom code
 	 * only executed in SPL, it is done in TF-A for TFABOOT
 	 */
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && !data->ta) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && !data->ta) {
 		plat = dev_get_plat(dev);
 
 		/* here 57 is the value for STM32MP15x ROM code, only MPU with SPL support*/
diff --git a/arch/arm/mach-stm32mp/stm32mp1/Makefile b/arch/arm/mach-stm32mp/stm32mp1/Makefile
index ebae50f66c9..5ae1a536ff1 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp1/Makefile
@@ -8,7 +8,7 @@ obj-y += cpu.o
 obj-$(CONFIG_STM32MP13X) += stm32mp13x.o
 obj-$(CONFIG_STM32MP15X) += stm32mp15x.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += tzc400.o
 else
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 64480da9f8d..26c073f06a0 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -57,7 +57,7 @@ void dram_bank_mmu_setup(int bank)
 	bool use_lmb = false;
 	enum dcache_option option;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 /* STM32_SYSRAM_BASE exist only when SPL is supported */
 #ifdef CONFIG_SPL
 		start = ALIGN_DOWN(STM32_SYSRAM_BASE, MMU_SECTION_SIZE);
@@ -133,7 +133,7 @@ int mach_cpu_init(void)
 	if (IS_ENABLED(CONFIG_CMD_STM32PROG_SERIAL) &&
 	    (boot_mode & TAMP_BOOT_DEVICE_MASK) == BOOT_SERIAL_UART)
 		gd->flags |= GD_FLG_SILENT | GD_FLG_DISABLE_CONSOLE;
-	else if (IS_ENABLED(CONFIG_DEBUG_UART) && IS_ENABLED(CONFIG_SPL_BUILD))
+	else if (IS_ENABLED(CONFIG_DEBUG_UART) && IS_ENABLED(CONFIG_XPL_BUILD))
 		debug_uart_init();
 
 	return 0;
@@ -339,7 +339,7 @@ uintptr_t get_stm32mp_bl2_dtb(void)
 	return nt_fw_dtb;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_stm32_t)(u32 romapi);
diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index f096fe538d8..b6a0ac14101 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -214,13 +214,13 @@ static void update_bootmode(void)
 /* weak function: STM32MP15x mach init for boot without TFA */
 void stm32mp_cpu_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		security_init();
 		update_bootmode();
 	}
 
 	/* reset copro state in SPL, when used, or in U-Boot */
-	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_XPL_BUILD)) {
 		/* Reset Coprocessor state unless it wakes up from Standby power mode */
 		if (!(readl(PWR_MCUCR) & PWR_MCUCR_SBF)) {
 			writel(TAMP_COPRO_STATE_OFF, TAMP_COPRO_STATE);
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 3f83c0280ef..eb6a49119a1 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -29,7 +29,7 @@ ifndef CONFIG_ARM64
 obj-y	+= timer.o
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y				+= clock.o
 obj-$(CONFIG_MACH_SUNIV)	+= dram_suniv.o
 obj-$(CONFIG_DRAM_SUN4I)	+= dram_sun4i.o
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 2b64ddc0dc7..701899ee4b2 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -74,7 +74,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 #endif /* CONFIG_ARM64 */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int gpio_init(void)
 {
 	__maybe_unused uint val;
@@ -209,7 +209,7 @@ static int spl_board_load_image(struct spl_image_info *spl_image,
 	return 0;
 }
 SPL_LOAD_IMAGE_METHOD("FEL", 0, BOOT_DEVICE_BOARD, spl_board_load_image);
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define SUNXI_INVALID_BOOT_SOURCE	-1
 
@@ -258,7 +258,7 @@ static int sunxi_get_boot_source(void)
 	 * proper, just return MMC0 as a placeholder, for now.
 	 */
 	if (IS_ENABLED(CONFIG_MACH_SUNIV) &&
-	    !IS_ENABLED(CONFIG_SPL_BUILD))
+	    !IS_ENABLED(CONFIG_XPL_BUILD))
 		return SUNXI_BOOTED_FROM_MMC0;
 
 	if (IS_ENABLED(CONFIG_MACH_SUNIV))
@@ -314,7 +314,7 @@ uint32_t sunxi_get_boot_device(void)
 	return -1;		/* Never reached */
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 uint32_t sunxi_get_spl_size(void)
 {
 	struct boot_file_head *egon_head = (void *)SPL_ADDR;
@@ -478,7 +478,7 @@ void board_init_f(ulong dummy)
 #endif
 	sunxi_board_init();
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
index 6458d066f7e..1367b439b83 100644
--- a/arch/arm/mach-sunxi/clock_sun4i.c
+++ b/arch/arm/mach-sunxi/clock_sun4i.c
@@ -13,7 +13,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -175,7 +175,7 @@ void clock_set_pll1(unsigned int hz)
 	       &ccm->cpu_ahb_apb0_cfg);
 	sdelay(20);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* video, DRAM, PLL_PERIPH clocks */
 void clock_set_pll3(unsigned int clk)
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index cc2ee336416..b424a7893ea 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -3,7 +3,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
 	struct sunxi_ccm_reg *const ccm =
@@ -131,7 +131,7 @@ int clock_twi_onoff(int port, int state)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* PLL_PERIPH0 clock, used by the MMC driver */
 unsigned int clock_get_pll6(void)
diff --git a/arch/arm/mach-sunxi/clock_sun6i.c b/arch/arm/mach-sunxi/clock_sun6i.c
index 59f7e15ffe8..657736c7ac2 100644
--- a/arch/arm/mach-sunxi/clock_sun6i.c
+++ b/arch/arm/mach-sunxi/clock_sun6i.c
@@ -16,7 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -169,7 +169,7 @@ void clock_set_pll1(unsigned int clk)
 		       &ccm->cpu_axi_cfg);
 	}
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* video, DRAM, PLL_PERIPH clocks */
 void clock_set_pll3(unsigned int clk)
diff --git a/arch/arm/mach-sunxi/clock_sun8i_a83t.c b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
index c00d16a918d..f593749028c 100644
--- a/arch/arm/mach-sunxi/clock_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
@@ -15,7 +15,7 @@
 #include <asm/arch/sys_proto.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -100,7 +100,7 @@ void clock_set_pll1(unsigned int clk)
 		CPU_CLK_SRC_PLL1 << C1_CPUX_CLK_SRC_SHIFT,
 	       &ccm->cpu_axi_cfg);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* DRAM and PLL_PERIPH0 clock (used by the MMC driver) */
 void clock_set_pll5(unsigned int clk)
diff --git a/arch/arm/mach-sunxi/clock_sun9i.c b/arch/arm/mach-sunxi/clock_sun9i.c
index abdab405445..5f99071f21b 100644
--- a/arch/arm/mach-sunxi/clock_sun9i.c
+++ b/arch/arm/mach-sunxi/clock_sun9i.c
@@ -14,7 +14,7 @@
 #include <asm/arch/prcm.h>
 #include <asm/arch/sys_proto.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static void clock_set_pll2(unsigned int clk)
 {
@@ -188,7 +188,7 @@ int clock_twi_onoff(int port, int state)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* PLL_PERIPH0 clock (used by the MMC driver) */
 unsigned int clock_get_pll4_periph0(void)
diff --git a/arch/arm/mach-sunxi/gtbus_sun9i.c b/arch/arm/mach-sunxi/gtbus_sun9i.c
index a058fea6bef..aa93defb25e 100644
--- a/arch/arm/mach-sunxi/gtbus_sun9i.c
+++ b/arch/arm/mach-sunxi/gtbus_sun9i.c
@@ -11,7 +11,7 @@
 #include <asm/arch/gtbus_sun9i.h>
 #include <asm/arch/sys_proto.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 void gtbus_init(void)
 {
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 1d22dc3942f..a87e6a6c352 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -5,7 +5,7 @@
 # (C) Copyright 2000-2008
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += cpu.o
 else
@@ -25,7 +25,7 @@ obj-y += dt-setup.o
 obj-$(CONFIG_TEGRA_CLOCK_SCALING) += emc.o
 obj-$(CONFIG_TEGRA_GPU) += gpu.o
 obj-$(CONFIG_TEGRA_IVC) += ivc.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMV7_PSCI) += psci.o
 endif
 obj-$(CONFIG_DISPLAY_CPUINFO) += sys_info.o
diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index c382e042860..cc37878b8d1 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -47,7 +47,7 @@ enum {
 
 static bool from_spl __section(".data");
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
 		      unsigned long r3)
 {
diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 7971e3b68d5..e68b8c894bb 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -46,7 +46,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* TODO(sjg@chromium.org): Remove once SPL supports device tree */
 U_BOOT_DRVINFO(tegra_gpios) = {
 	"gpio_tegra"
diff --git a/arch/arm/mach-tegra/tegra114/Makefile b/arch/arm/mach-tegra/tegra114/Makefile
index 346d6cb5696..f1c1042b4e2 100644
--- a/arch/arm/mach-tegra/tegra114/Makefile
+++ b/arch/arm/mach-tegra/tegra114/Makefile
@@ -2,6 +2,6 @@
 #
 # Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
 
-obj-$(CONFIG_SPL_BUILD) += cpu.o
+obj-$(CONFIG_XPL_BUILD) += cpu.o
 
 obj-y	+= clock.o
diff --git a/arch/arm/mach-tegra/tegra124/Makefile b/arch/arm/mach-tegra/tegra124/Makefile
index 6ea511e7b25..dee790015a3 100644
--- a/arch/arm/mach-tegra/tegra124/Makefile
+++ b/arch/arm/mach-tegra/tegra124/Makefile
@@ -5,13 +5,13 @@
 # SPDX-License-Identifier:     GPL-2.0+
 #
 
-obj-$(CONFIG_SPL_BUILD) += cpu.o
+obj-$(CONFIG_XPL_BUILD) += cpu.o
 
 obj-y	+= clock.o
 obj-y	+= pmc.o
 obj-y	+= xusb-padctl.o
 obj-y	+= ../xusb-padctl-common.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARMV7_NONSEC) += psci.o
 endif
diff --git a/arch/arm/mach-tegra/tegra20/Makefile b/arch/arm/mach-tegra/tegra20/Makefile
index c2ae98eb376..2774c866b02 100644
--- a/arch/arm/mach-tegra/tegra20/Makefile
+++ b/arch/arm/mach-tegra/tegra20/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2010,2011 Nvidia Corporation.
 
-obj-$(CONFIG_SPL_BUILD) += cpu.o
+obj-$(CONFIG_XPL_BUILD) += cpu.o
 obj-$(CONFIG_$(SPL_)CMD_EBTUPDATE) += bct.o
 
 # The AVP is ARMv4T architecture so we must use special compiler
diff --git a/arch/arm/mach-tegra/tegra30/Makefile b/arch/arm/mach-tegra/tegra30/Makefile
index ee0e6f5b948..5edc7c9ce7d 100644
--- a/arch/arm/mach-tegra/tegra30/Makefile
+++ b/arch/arm/mach-tegra/tegra30/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
 
-obj-$(CONFIG_SPL_BUILD) += cpu.o
+obj-$(CONFIG_XPL_BUILD) += cpu.o
 obj-$(CONFIG_$(SPL_)CMD_EBTUPDATE) += bct.o
 
 obj-y	+= clock.o
diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/mach-uniphier/Makefile
index 5172efac0c4..d1ec8195dcb 100644
--- a/arch/arm/mach-uniphier/Makefile
+++ b/arch/arm/mach-uniphier/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 obj-y += boards.o
 obj-y += spl_board_init.o
diff --git a/arch/arm/mach-uniphier/arm32/Makefile b/arch/arm/mach-uniphier/arm32/Makefile
index b41aba7e29a..c8ce67ac05a 100644
--- a/arch/arm/mach-uniphier/arm32/Makefile
+++ b/arch/arm/mach-uniphier/arm32/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += lowlevel_init.o
 obj-$(CONFIG_DEBUG_LL) += debug_ll.o
 else
diff --git a/arch/arm/mach-uniphier/boot-device/boot-device.c b/arch/arm/mach-uniphier/boot-device/boot-device.c
index 1e6bc8433f7..9d0fe5c8583 100644
--- a/arch/arm/mach-uniphier/boot-device/boot-device.c
+++ b/arch/arm/mach-uniphier/boot-device/boot-device.c
@@ -214,7 +214,7 @@ int uniphier_boot_from_backend(void)
 	return !!(readl(sg_base + SG_PINMON0) & BIT(27));
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 static int do_pinmon(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
@@ -267,4 +267,4 @@ U_BOOT_CMD(
 	""
 );
 
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/arch/arm/mach-uniphier/clk/Makefile b/arch/arm/mach-uniphier/clk/Makefile
index c49e44754c0..0e47beb5f22 100644
--- a/arch/arm/mach-uniphier/clk/Makefile
+++ b/arch/arm/mach-uniphier/clk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_ARCH_UNIPHIER_LD4)		+= clk-early-ld4.o clk-dram-ld4.o dpll-ld4.o
 obj-$(CONFIG_ARCH_UNIPHIER_PRO4)	+= clk-early-ld4.o clk-dram-ld4.o dpll-pro4.o
diff --git a/arch/arm/mach-uniphier/debug-uart/Makefile b/arch/arm/mach-uniphier/debug-uart/Makefile
index 81e9314a50d..4202cb3503b 100644
--- a/arch/arm/mach-uniphier/debug-uart/Makefile
+++ b/arch/arm/mach-uniphier/debug-uart/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_ARCH_UNIPHIER_LD4)		+= debug-uart-ld4.o
 obj-$(CONFIG_ARCH_UNIPHIER_PRO4)	+= debug-uart-pro4.o
 obj-$(CONFIG_ARCH_UNIPHIER_SLD8)	+= debug-uart-sld8.o
diff --git a/arch/arm/mach-uniphier/debug-uart/debug-uart.c b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
index 1ba012ca45d..6836eb63bfa 100644
--- a/arch/arm/mach-uniphier/debug-uart/debug-uart.c
+++ b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
@@ -26,7 +26,7 @@ static void _debug_uart_putc(int c)
 	writel(c, base + UNIPHIER_UART_TX);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void sg_set_pinsel(unsigned int pin, unsigned int muxval,
 		   unsigned int mux_bits, unsigned int reg_stride)
 {
@@ -56,7 +56,7 @@ void sg_set_iectrl(unsigned int pin)
 
 void _debug_uart_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
 	unsigned int divisor;
 
diff --git a/arch/arm/mach-uniphier/dram/Makefile b/arch/arm/mach-uniphier/dram/Makefile
index 7d11315d07f..36188c38cf9 100644
--- a/arch/arm/mach-uniphier/dram/Makefile
+++ b/arch/arm/mach-uniphier/dram/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_ARCH_UNIPHIER_LD4)		+= umc-ld4.o \
 					   ddrphy-training.o ddrphy-ld4.o
diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index d9b2b999e10..8545331c54a 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -12,4 +12,4 @@ obj-y	+= slcr.o
 obj-y	+= clk.o
 obj-y	+= lowlevel_init.o
 AFLAGS_lowlevel_init.o := -mfpu=neon
-obj-$(CONFIG_SPL_BUILD)	+= spl.o ps7_spl_init.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o ps7_spl_init.o
diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index 5b6d765099d..74dddc25988 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -52,7 +52,7 @@ static const struct {
 int arch_cpu_init(void)
 {
 	zynq_slcr_unlock();
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Device config APB, unlock the PCAP */
 	writel(0x757BDF0D, &devcfg_base->unlock);
 	writel(0xFFFFFFFF, &devcfg_base->rom_shadow);
diff --git a/arch/arm/mach-zynqmp/Makefile b/arch/arm/mach-zynqmp/Makefile
index 38be1627eeb..7c95f32a5c3 100644
--- a/arch/arm/mach-zynqmp/Makefile
+++ b/arch/arm/mach-zynqmp/Makefile
@@ -5,10 +5,10 @@
 
 obj-y	+= aes.o clk.o cpu.o
 obj-$(CONFIG_MP)	+= mp.o
-obj-$(CONFIG_SPL_BUILD) += spl.o handoff.o psu_spl_init.o
+obj-$(CONFIG_XPL_BUILD) += spl.o handoff.o psu_spl_init.o
 obj-$(CONFIG_SPL_ZYNQMP_DRAM_ECC_INIT) += ecc_spl_init.o
 obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
-endif # !CONFIG_SPL_BUILD
+endif # !CONFIG_XPL_BUILD
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 07668c94689..24fd5751216 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -187,7 +187,7 @@ int zynqmp_mmio_write(const u32 address,
 		      const u32 mask,
 		      const u32 value)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
 		return zynqmp_mmio_rawwrite(address, mask, value);
 #if defined(CONFIG_ZYNQMP_FIRMWARE)
 	else
@@ -205,7 +205,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value)
 	if (!value)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		ret = zynqmp_mmio_rawread(address, value);
 	}
 #if defined(CONFIG_ZYNQMP_FIRMWARE)
diff --git a/arch/microblaze/config.mk b/arch/microblaze/config.mk
index 64c3f313195..53244046f19 100644
--- a/arch/microblaze/config.mk
+++ b/arch/microblaze/config.mk
@@ -11,7 +11,7 @@ PLATFORM_CPPFLAGS += -fdata-sections -ffunction-sections
 
 LDFLAGS_FINAL += --gc-sections
 
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 PLATFORM_CPPFLAGS += -fPIC
 LDFLAGS_u-boot += -pic
 endif
diff --git a/arch/microblaze/cpu/Makefile b/arch/microblaze/cpu/Makefile
index b8c1dcbe14f..4d4919c3e3f 100644
--- a/arch/microblaze/cpu/Makefile
+++ b/arch/microblaze/cpu/Makefile
@@ -7,4 +7,4 @@ extra-y	= start.o
 obj-y	= irq.o
 obj-y	+= interrupts.o cache.o exception.o cpuinfo.o relocate.o
 obj-$(CONFIG_XILINX_MICROBLAZE0_PVR) += pvr.o
-obj-$(CONFIG_SPL_BUILD)	+= spl.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o
diff --git a/arch/microblaze/cpu/start.S b/arch/microblaze/cpu/start.S
index c1e0fcda0a4..69c4efdad7f 100644
--- a/arch/microblaze/cpu/start.S
+++ b/arch/microblaze/cpu/start.S
@@ -26,7 +26,7 @@ _start:
 	mts	rslr, r0
 	mts	rshr, r20
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	addi	r1, r0, CONFIG_SPL_STACK
 #else
 	add	r1, r0, r20
@@ -83,7 +83,7 @@ uboot_sym_start:
 	brlid	r15, board_init_f_init_reserve
 	nop
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	/* Setup vectors with pre-relocation symbols */
 	or	r5, r0, r0
 	brlid	r15, __setup_exceptions
@@ -122,7 +122,7 @@ clear_bss:
 	brlid	r15, debug_uart_init
 	nop
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	or	r5, r0, r0	/* flags - empty */
 	bri	board_init_f
 #else
@@ -130,7 +130,7 @@ clear_bss:
 #endif
 1:	bri	1b
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.text
 	.ent	__setup_exceptions
 	.align	2
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a007914590f..453c7885075 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -2,7 +2,7 @@
 
 head-y := arch/mips/cpu/start.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 head-$(CONFIG_ARCH_JZ47XX) := arch/mips/mach-jz47xx/start.o
 head-$(CONFIG_SOC_MT7621) := arch/mips/mach-mtmips/mt7621/spl/start.o
 endif
diff --git a/arch/mips/config.mk b/arch/mips/config.mk
index 745f03190e9..ad2ea11f72c 100644
--- a/arch/mips/config.mk
+++ b/arch/mips/config.mk
@@ -53,7 +53,7 @@ PLATFORM_ELFFLAGS += -B mips $(OBJCOPYFLAGS)
 # LDFLAGS_vmlinux		+= -G 0 -static -n -nostdlib
 # MODFLAGS			+= -mlong-calls
 #
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 OBJCOPYFLAGS			+= -j .data.reloc -j .dtb.init.rodata
 LDFLAGS_FINAL			+= --emit-relocs
 endif
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 1621cc9a1ff..79841dbe5ed 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -12,6 +12,6 @@ obj-y	+= traps.o
 
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o udivdi3.o
diff --git a/arch/mips/mach-jz47xx/Makefile b/arch/mips/mach-jz47xx/Makefile
index dbb8229f785..5621a09b6dd 100644
--- a/arch/mips/mach-jz47xx/Makefile
+++ b/arch/mips/mach-jz47xx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-extra-$(CONFIG_SPL_BUILD)	:= start.o
+extra-$(CONFIG_XPL_BUILD)	:= start.o
 
 obj-$(CONFIG_SOC_JZ4780)	+= jz4780/
diff --git a/arch/mips/mach-jz47xx/include/mach/jz4780.h b/arch/mips/mach-jz47xx/include/mach/jz4780.h
index 880445dac39..9f9a8cf9438 100644
--- a/arch/mips/mach-jz47xx/include/mach/jz4780.h
+++ b/arch/mips/mach-jz47xx/include/mach/jz4780.h
@@ -94,7 +94,7 @@ void jz4780_efuse_init(u32 ahb2_rate);
 
 void jz4780_tcu_wdt_start(void);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 int jz_mmc_init(void __iomem *base);
 #endif
 
diff --git a/arch/mips/mach-jz47xx/jz4780/jz4780.c b/arch/mips/mach-jz47xx/jz4780/jz4780.c
index 1d6fb6a4e27..504fd27d285 100644
--- a/arch/mips/mach-jz47xx/jz4780/jz4780.c
+++ b/arch/mips/mach-jz47xx/jz4780/jz4780.c
@@ -19,7 +19,7 @@
 #include <mmc.h>
 #include <spl.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* Pointer to the global data structure for SPL */
 DECLARE_GLOBAL_DATA_PTR;
 gd_t gdata __section(".bss");
@@ -73,7 +73,7 @@ void board_init_f(ulong dummy)
 
 	hang();
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
diff --git a/arch/mips/mach-jz47xx/start.S b/arch/mips/mach-jz47xx/start.S
index 760d0215493..0d40e637a68 100644
--- a/arch/mips/mach-jz47xx/start.S
+++ b/arch/mips/mach-jz47xx/start.S
@@ -18,7 +18,7 @@
 	.globl _start
 	.text
 _start:
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 	/* magic value ("MSPL") */
 	.word 0x4d53504c
@@ -95,4 +95,4 @@ enable_caches:
 	.end enable_caches
 
 #endif /* CONFIG_SOC_JZ4780 */
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/arch/mips/mach-mtmips/Makefile b/arch/mips/mach-mtmips/Makefile
index 19f1e07033e..2f35b1a925c 100644
--- a/arch/mips/mach-mtmips/Makefile
+++ b/arch/mips/mach-mtmips/Makefile
@@ -5,7 +5,7 @@ obj-y += cpu.o
 ifneq ($(CONFIG_SOC_MT7621),y)
 obj-y += ddr_init.o
 obj-y += ddr_cal.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 endif
 
 obj-$(CONFIG_SOC_MT7620) += mt7620/
diff --git a/arch/mips/mach-mtmips/cpu.c b/arch/mips/mach-mtmips/cpu.c
index 243938a0ebb..982a5889df8 100644
--- a/arch/mips/mach-mtmips/cpu.c
+++ b/arch/mips/mach-mtmips/cpu.c
@@ -21,7 +21,7 @@ int dram_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int last_stage_init(void)
 {
 	void *src, *dst;
diff --git a/arch/mips/mach-mtmips/mt7620/Makefile b/arch/mips/mach-mtmips/mt7620/Makefile
index 649f6c3798f..d2d79e3424b 100644
--- a/arch/mips/mach-mtmips/mt7620/Makefile
+++ b/arch/mips/mach-mtmips/mt7620/Makefile
@@ -5,6 +5,6 @@ obj-y += init.o
 obj-y += dram.o
 obj-y += serial.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += sysc.o
 endif
diff --git a/arch/mips/mach-mtmips/mt7621/Makefile b/arch/mips/mach-mtmips/mt7621/Makefile
index bf1b0bb688b..f48083e3559 100644
--- a/arch/mips/mach-mtmips/mt7621/Makefile
+++ b/arch/mips/mach-mtmips/mt7621/Makefile
@@ -3,7 +3,7 @@
 obj-y += init.o
 obj-y += serial.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 ifeq ($(CONFIG_TPL_BUILD),y)
 obj-y += tpl/
 else
diff --git a/arch/mips/mach-mtmips/mt7628/Makefile b/arch/mips/mach-mtmips/mt7628/Makefile
index 7e139d5adfd..63acf54536b 100644
--- a/arch/mips/mach-mtmips/mt7628/Makefile
+++ b/arch/mips/mach-mtmips/mt7628/Makefile
@@ -3,4 +3,4 @@
 obj-y += lowlevel_init.o
 obj-y += init.o
 obj-y += ddr.o
-obj-$(CONFIG_SPL_BUILD) += serial.o
+obj-$(CONFIG_XPL_BUILD) += serial.o
diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 725a4f48aad..dd0124cace1 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -27,7 +27,7 @@ PLATFORM_CPPFLAGS+= -D__PPC__
 endif
 
 # Only test once
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 archprepare: checkgcc4
 
 # GCC 3.x is reported to have problems generating the type of relocation
diff --git a/arch/powerpc/cpu/mpc83xx/Makefile b/arch/powerpc/cpu/mpc83xx/Makefile
index 1255f533e34..9974239f881 100644
--- a/arch/powerpc/cpu/mpc83xx/Makefile
+++ b/arch/powerpc/cpu/mpc83xx/Makefile
@@ -7,7 +7,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
diff --git a/arch/powerpc/cpu/mpc83xx/start.S b/arch/powerpc/cpu/mpc83xx/start.S
index ceb54867894..78762f000df 100644
--- a/arch/powerpc/cpu/mpc83xx/start.S
+++ b/arch/powerpc/cpu/mpc83xx/start.S
@@ -41,11 +41,11 @@
 #endif
 
 #if defined(CONFIG_NAND_SPL) || \
-	(defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(INIT_MINIMAL))
+	(defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(INIT_MINIMAL))
 #define MINIMAL_SPL
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_NAND_SPL) && \
+#if !defined(CONFIG_XPL_BUILD) && !defined(CONFIG_NAND_SPL) && \
 	!defined(CONFIG_SYS_RAMBOOT)
 #define CFG_SYS_FLASHBOOT
 #endif
@@ -168,7 +168,7 @@ _start: /* time t 0 */
 	/* Initialise the E300 processor core		*/
 	/*------------------------------------------*/
 
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_MPC83XX_WAIT_FOR_NAND)) || \
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_MPC83XX_WAIT_FOR_NAND)) || \
 		defined(CONFIG_NAND_SPL)
 	/* The FCM begins execution after only the first page
 	 * is loaded.  Wait for the rest before branching
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index f3ee7d34949..bf74228efde 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -8,7 +8,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -26,7 +26,7 @@ else
 
 obj-$(CONFIG_MP)	+= release.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ERRATA) += cmd_errata.o
 endif
 
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
index 574510fa088..75bfc07fe97 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
@@ -179,7 +179,7 @@ void cpu_init_early_f(void *fdt)
 	invalidate_tlb(1);
 
 #if defined(CONFIG_SYS_PPC_E500_DEBUG_TLB) && \
-	!(CONFIG_IS_ENABLED(INIT_MINIMAL) && defined(CONFIG_SPL_BUILD)) && \
+	!(CONFIG_IS_ENABLED(INIT_MINIMAL) && defined(CONFIG_XPL_BUILD)) && \
 	!defined(CONFIG_NAND_SPL)
 	disable_tlb(CONFIG_SYS_PPC_E500_DEBUG_TLB);
 #endif
diff --git a/arch/powerpc/cpu/mpc85xx/start.S b/arch/powerpc/cpu/mpc85xx/start.S
index 3e24a90233c..89bce5bed69 100644
--- a/arch/powerpc/cpu/mpc85xx/start.S
+++ b/arch/powerpc/cpu/mpc85xx/start.S
@@ -28,7 +28,7 @@
 #define LAW_EN		0x80000000
 
 #if defined(CONFIG_NAND_SPL) || \
-	(defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(INIT_MINIMAL))
+	(defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(INIT_MINIMAL))
 #define MINIMAL_SPL
 #endif
 
@@ -58,16 +58,16 @@
 	END_GOT
 
 #ifdef CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 
 /* Maximal size of the image */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define MAX_IMAGE_SIZE (CONFIG_SPL_MAX_SIZE - (CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA * 512))
 #else
 #define MAX_IMAGE_SIZE CONFIG_SYS_L2_SIZE
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && CONFIG_SPL_MAX_SIZE < CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA * 512
+#if defined(CONFIG_XPL_BUILD) && CONFIG_SPL_MAX_SIZE < CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA * 512
 #error "CONFIG_SPL_MAX_SIZE is too small for CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA"
 #endif
 
@@ -1138,10 +1138,10 @@ create_init_ram_area:
 /*
  * For Targets without CONFIG_SPL like P3, P5
  * and for targets with CONFIG_SPL like T1, T2, T4, only for
- * u-boot-spl i.e. CONFIG_SPL_BUILD
+ * u-boot-spl i.e. CONFIG_XPL_BUILD
  */
 #elif defined(CONFIG_RAMBOOT_PBL) && defined(CONFIG_NXP_ESBC) && \
-	(!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	/* create a temp mapping in AS = 1 for mapping CONFIG_VAL(SYS_MONITOR_BASE)
 	 * to L3 Address configured by PBL for ISBC code
 	 */
@@ -1617,7 +1617,7 @@ relocate_code:
 	mr	r10,r5		/* Save copy of Destination Address	*/
 
 	GET_GOT
-#if !defined(CONFIG_SPL_SKIP_RELOCATE) || !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL_SKIP_RELOCATE) || !defined(CONFIG_XPL_BUILD)
 	mr	r3,r5				/* Destination Address	*/
 	lis	r4,CONFIG_VAL(SYS_MONITOR_BASE)@h		/* Source      Address	*/
 	ori	r4,r4,CONFIG_VAL(SYS_MONITOR_BASE)@l
diff --git a/arch/powerpc/cpu/mpc85xx/tlb.c b/arch/powerpc/cpu/mpc85xx/tlb.c
index 32b68a169a4..415ab1096c6 100644
--- a/arch/powerpc/cpu/mpc85xx/tlb.c
+++ b/arch/powerpc/cpu/mpc85xx/tlb.c
@@ -45,7 +45,7 @@ __weak void init_tlbs(void)
 }
 
 #if !defined(CONFIG_NAND_SPL) && \
-	(!defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
+	(!defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
 void read_tlbcam_entry(int idx, u32 *valid, u32 *tsize, unsigned long *epn,
 		       phys_addr_t *rpn)
 {
@@ -313,7 +313,7 @@ unsigned int setup_ddr_tlbs_phys(phys_addr_t p_addr,
 		print_size(memsize > CFG_MAX_MEM_MAPPED ?
 			   memsize - CFG_MAX_MEM_MAPPED + size : size,
 			   " of DDR memory left unmapped in U-Boot\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       ");
 #endif
 	}
diff --git a/arch/powerpc/cpu/mpc8xxx/Makefile b/arch/powerpc/cpu/mpc8xxx/Makefile
index e3a536d4f8c..a44b5165d74 100644
--- a/arch/powerpc/cpu/mpc8xxx/Makefile
+++ b/arch/powerpc/cpu/mpc8xxx/Makefile
@@ -4,7 +4,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 3a82e60a247..638c3a6fee5 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -241,7 +241,7 @@ int pamu_init(void)
 	spaact_size = sizeof(struct paace) * NUM_SPAACT_ENTRIES;
 
 	/* Allocate space for Primary PAACT Table */
-#if (defined(CONFIG_SPL_BUILD) && defined(CFG_SPL_PPAACT_ADDR))
+#if (defined(CONFIG_XPL_BUILD) && defined(CFG_SPL_PPAACT_ADDR))
 	ppaact = (void *)CFG_SPL_PPAACT_ADDR;
 #else
 	ppaact = memalign(PAMU_TABLE_ALIGNMENT, ppaact_size);
@@ -251,7 +251,7 @@ int pamu_init(void)
 	memset(ppaact, 0, ppaact_size);
 
 	/* Allocate space for Secondary PAACT Table */
-#if (defined(CONFIG_SPL_BUILD) && defined(CFG_SPL_SPAACT_ADDR))
+#if (defined(CONFIG_XPL_BUILD) && defined(CFG_SPL_SPAACT_ADDR))
 	sec = (void *)CFG_SPL_SPAACT_ADDR;
 #else
 	sec = memalign(PAMU_TABLE_ALIGNMENT, spaact_size);
diff --git a/arch/powerpc/cpu/mpc8xxx/law.c b/arch/powerpc/cpu/mpc8xxx/law.c
index b4695cc99cb..3fd80eb29c0 100644
--- a/arch/powerpc/cpu/mpc8xxx/law.c
+++ b/arch/powerpc/cpu/mpc8xxx/law.c
@@ -78,7 +78,7 @@ void disable_law(u8 idx)
 }
 
 #if !defined(CONFIG_NAND_SPL) && \
-	(!defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
+	(!defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
 static int get_law_entry(u8 i, struct law_entry *e)
 {
 	u32 lawar;
@@ -109,7 +109,7 @@ int set_next_law(phys_addr_t addr, enum law_size sz, enum law_trgt_if id)
 }
 
 #if !defined(CONFIG_NAND_SPL) && \
-	(!defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
+	(!defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(INIT_MINIMAL))
 int set_last_law(phys_addr_t addr, enum law_size sz, enum law_trgt_if id)
 {
 	u32 idx;
diff --git a/arch/powerpc/cpu/mpc8xxx/pamu_table.c b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
index 831a11736cc..bd3f69b469e 100644
--- a/arch/powerpc/cpu/mpc8xxx/pamu_table.c
+++ b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
@@ -28,7 +28,7 @@ void construct_pamu_addr_table(struct pamu_addr_tbl *tbl, int *num_entries)
 
 	i++;
 #endif
-#if (defined(CONFIG_SPL_BUILD) && (CFG_SYS_INIT_L3_VADDR))
+#if (defined(CONFIG_XPL_BUILD) && (CFG_SYS_INIT_L3_VADDR))
 	tbl->start_addr[i] =
 		(uint64_t)virt_to_phys((void *)CFG_SYS_INIT_L3_VADDR);
 	tbl->size[i] = 256 * 1024; /* 256K CPC flash */
diff --git a/arch/powerpc/include/asm/fsl_secure_boot.h b/arch/powerpc/include/asm/fsl_secure_boot.h
index 221f9d842a8..f12830984c6 100644
--- a/arch/powerpc/include/asm/fsl_secure_boot.h
+++ b/arch/powerpc/include/asm/fsl_secure_boot.h
@@ -36,7 +36,7 @@
 #endif /* #ifdef CONFIG_NXP_ESBC */
 
 #ifdef CONFIG_CHAIN_OF_TRUST
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * PPAACT and SPAACT table for PAMU must be placed on DDR after DDR init
  * due to space crunch on CPC and thus malloc will not work.
@@ -45,10 +45,10 @@
 #define CFG_SPL_SPAACT_ADDR		0x2f000000
 #define CFG_SPL_JR0_LIODN_S		454
 #define CFG_SPL_JR0_LIODN_NS		458
-#endif /* ifdef CONFIG_SPL_BUILD */
+#endif /* ifdef CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <config_fsl_chain_trust.h>
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 #endif /* #ifdef CONFIG_CHAIN_OF_TRUST */
 #endif
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index ecc2aba8f3c..f797f8cee66 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,7 +9,7 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -45,6 +45,6 @@ obj-y	+= time.o
 obj-y	+= traps.o
 endif # not minimal
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_$(SPL_TPL)_FRAMEWORK) += spl.o
 endif
diff --git a/arch/riscv/cpu/fu540/Makefile b/arch/riscv/cpu/fu540/Makefile
index 043fb961a51..69759c55658 100644
--- a/arch/riscv/cpu/fu540/Makefile
+++ b/arch/riscv/cpu/fu540/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2020 SiFive, Inc
 # Pragnesh Patel <pragnesh.patel@sifive.com>
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y += spl.o
 else
 obj-y += dram.o
diff --git a/arch/riscv/cpu/fu740/Makefile b/arch/riscv/cpu/fu740/Makefile
index 1d1ad98ba7c..9071c831992 100644
--- a/arch/riscv/cpu/fu740/Makefile
+++ b/arch/riscv/cpu/fu740/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2020-2021 SiFive, Inc
 # Pragnesh Patel <pragnesh.patel@sifive.com>
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y += spl.o
 else
 obj-y += dram.o
diff --git a/arch/riscv/cpu/jh7110/Makefile b/arch/riscv/cpu/jh7110/Makefile
index 951c95631e9..0939c1061d0 100644
--- a/arch/riscv/cpu/jh7110/Makefile
+++ b/arch/riscv/cpu/jh7110/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2022 StarFive Technology Co., Ltd.
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y += spl.o
 else
 obj-y += cpu.o
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 8e58f641f1b..3f78932aa9d 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -90,7 +90,7 @@ _start:
  * Set stackpointer in internal/ex RAM to call board_init_f
  */
 call_board_init_f:
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	li	t0, CONFIG_SPL_STACK
 #else
 	li	t0, SYS_INIT_SP_ADDR
@@ -218,7 +218,7 @@ wait_for_gd_init:
 	la	t5, board_init_f
 	jalr	t5			/* jump to board_init_f() */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 spl_clear_bss:
 	la	t0, __bss_start
 	la	t1, __bss_end
@@ -271,7 +271,7 @@ spl_call_board_init_r:
 	j	board_init_r
 #endif
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 /*
  * void relocate_code(addr_sp, gd, addr_moni)
  *
@@ -420,7 +420,7 @@ call_board_init_r:
  * jump to it ...
  */
 	jr	t4			/* jump to board_init_r() */
-#endif /* !defined(CONFIG_SPL_BUILD) */
+#endif /* !defined(CONFIG_XPL_BUILD) */
 
 #if CONFIG_IS_ENABLED(SMP)
 hart_out_of_bounds_loop:
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 65dc49f6fa5..3bc34cd61fb 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -24,7 +24,7 @@ obj-y	+= reset.o
 endif
 obj-y   += setjmp.o
 obj-$(CONFIG_$(SPL_)SMP) += smp.o
-obj-$(CONFIG_SPL_BUILD)	+= spl.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-y   += fdt_fixup.o
 obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
 
diff --git a/arch/riscv/lib/sifive_cache.c b/arch/riscv/lib/sifive_cache.c
index d8fe1dfa958..d74544b93d8 100644
--- a/arch/riscv/lib/sifive_cache.c
+++ b/arch/riscv/lib/sifive_cache.c
@@ -10,7 +10,7 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void enable_caches(void)
 {
 	struct udevice *dev;
@@ -45,4 +45,4 @@ void enable_caches(void)
 
 	probe_cache_device(DM_DRIVER_GET(sifive_pl2), dev);
 }
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
index 7c5c52652f5..bfcdc335d32 100644
--- a/arch/sandbox/cpu/Makefile
+++ b/arch/sandbox/cpu/Makefile
@@ -8,7 +8,7 @@
 obj-y	:= cache.o cpu.o state.o
 extra-y	:= start.o os.o
 extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
-obj-$(CONFIG_SPL_BUILD)	+= spl.o
+obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_ETH_SANDBOX_RAW)	+= eth-raw-os.o
 
 # os.c is build in the system environment, so needs standard includes
diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 51ce40e7f08..06f8c13fab9 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -165,7 +165,7 @@ phys_addr_t virt_to_phys(void *ptr)
 
 void *map_physmem(phys_addr_t paddr, unsigned long len, unsigned long flags)
 {
-#if defined(CONFIG_PCI) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_PCI) && !defined(CONFIG_XPL_BUILD)
 	unsigned long plen = len;
 	void *ptr;
 
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 4d3c806840b..81752edc9f8 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -129,7 +129,7 @@ static int sandbox_cmdline_cb_help(struct sandbox_state *state, const char *arg)
 }
 SANDBOX_CMDLINE_OPT_SHORT(help, 'h', 0, "Display help");
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int sandbox_main_loop_init(void)
 {
 	struct sandbox_state *state = state_get_current();
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f1afc74fff8..3c8c541efbc 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -10,7 +10,7 @@ else
 ifndef CONFIG_SPL
 head-y := arch/x86/cpu/start.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 head-y	= arch/x86/cpu/start_from_tpl.o
 else
 head-y	= arch/x86/cpu/start_from_spl.o
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 2e3a7119e79..6d4839dfb38 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -10,7 +10,7 @@ PF_CPPFLAGS_X86   := $(call cc-option, -fno-toplevel-reorder, \
 PLATFORM_CPPFLAGS += $(PF_CPPFLAGS_X86)
 PLATFORM_CPPFLAGS += -fno-dwarf2-cfi-asm
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 IS_32BIT := y
 else
 ifndef CONFIG_X86_64
@@ -26,7 +26,7 @@ endif
 ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS += -march=i386 -m32
 else
-PLATFORM_CPPFLAGS += $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -march=core2 -m64
+PLATFORM_CPPFLAGS += $(if $(CONFIG_XPL_BUILD),,-fpic) -fno-common -march=core2 -m64
 
 ifndef CONFIG_X86_HARDFP
 PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
@@ -86,12 +86,12 @@ ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS += -mregparm=3
 endif
 KBUILD_LDFLAGS += --emit-relocs
-LDFLAGS_FINAL += --gc-sections $(if $(CONFIG_SPL_BUILD),,-pie)
+LDFLAGS_FINAL += --gc-sections $(if $(CONFIG_XPL_BUILD),,-pie)
 
 endif
 
 ifdef CONFIG_X86_64
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 PLATFORM_CPPFLAGS += -D__x86_64__
 else
 PLATFORM_CPPFLAGS += -D__I386__
diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index 16e67e3da24..c21d6d6d438 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -15,7 +15,7 @@ else
 ifndef CONFIG_SPL
 extra-y	= start.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 extra-y	= start_from_tpl.o
 else
 extra-y	= start_from_spl.o
diff --git a/arch/x86/cpu/apollolake/Makefile b/arch/x86/cpu/apollolake/Makefile
index 2ddf4af62c5..f481f40d9bb 100644
--- a/arch/x86/cpu/apollolake/Makefile
+++ b/arch/x86/cpu/apollolake/Makefile
@@ -2,20 +2,20 @@
 #
 # Copyright 2019 Google LLC
 
-obj-$(CONFIG_SPL_BUILD) += cpu_spl.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
-obj-$(CONFIG_SPL_BUILD) += systemagent.o
+obj-$(CONFIG_XPL_BUILD) += cpu_spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += systemagent.o
 obj-y += cpu_common.o
 
 ifndef CONFIG_TPL_BUILD
 obj-y += cpu.o
 obj-y += punit.o
 obj-y += fsp_bindings.o
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += fsp_m.o
 endif
 endif
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += acpi.o
 obj-y += fsp_s.o
 endif
diff --git a/arch/x86/cpu/apollolake/fsp_bindings.c b/arch/x86/cpu/apollolake/fsp_bindings.c
index f6fbddce922..b4bb677f5cd 100644
--- a/arch/x86/cpu/apollolake/fsp_bindings.c
+++ b/arch/x86/cpu/apollolake/fsp_bindings.c
@@ -247,7 +247,7 @@ static int fsp_update_config_from_dtb(ofnode node, u8 *cfg,
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 const struct fsp_binding fsp_m_bindings[] = {
 	{
 	.type = FSP_UINT32,
@@ -653,7 +653,7 @@ int fsp_m_update_config_from_dtb(ofnode node, struct fsp_m_config *cfg)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
 const struct fsp_binding fsp_s_bindings[] = {
 	{
 	.type = FSP_UINT8,
diff --git a/arch/x86/cpu/broadwell/Makefile b/arch/x86/cpu/broadwell/Makefile
index 3e1f76d6118..6c6d0edac9b 100644
--- a/arch/x86/cpu/broadwell/Makefile
+++ b/arch/x86/cpu/broadwell/Makefile
@@ -6,12 +6,12 @@ obj-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += cpu.o
 obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += cpu_full.o
 
 ifdef CONFIG_SPL
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += cpu_from_spl.o
 obj-y += cpu_full.o
 obj-y += refcode.o
 endif
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 # obj-y += cpu_from_spl.o
 obj-y += adsp.o
 obj-y += sata.o
diff --git a/arch/x86/cpu/broadwell/cpu_full.c b/arch/x86/cpu/broadwell/cpu_full.c
index c43fb7a608b..529dab18d5d 100644
--- a/arch/x86/cpu/broadwell/cpu_full.c
+++ b/arch/x86/cpu/broadwell/cpu_full.c
@@ -84,7 +84,7 @@ static const u8 power_limit_time_msr_to_sec[] = {
 	[0x11] = 128,
 };
 
-#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
 int arch_cpu_init(void)
 {
 	return 0;
diff --git a/arch/x86/cpu/broadwell/pch.c b/arch/x86/cpu/broadwell/pch.c
index 2c8b7380d96..5b6147432a7 100644
--- a/arch/x86/cpu/broadwell/pch.c
+++ b/arch/x86/cpu/broadwell/pch.c
@@ -606,7 +606,7 @@ static int broadwell_pch_probe(struct udevice *dev)
 			return broadwell_pch_early_init(dev);
 		else
 			return broadwell_pch_init(dev);
-	} else if (IS_ENABLED(CONFIG_SPL) && !IS_ENABLED(CONFIG_SPL_BUILD)) {
+	} else if (IS_ENABLED(CONFIG_SPL) && !IS_ENABLED(CONFIG_XPL_BUILD)) {
 		return broadwell_pch_init(dev);
 	} else {
 		return 0;
diff --git a/arch/x86/cpu/config.mk b/arch/x86/cpu/config.mk
index 87e242a2065..6acdf9b3b23 100644
--- a/arch/x86/cpu/config.mk
+++ b/arch/x86/cpu/config.mk
@@ -9,7 +9,7 @@ LDPPFLAGS += -DRESET_VEC_LOC=$(CONFIG_RESET_VEC_LOC)
 LDPPFLAGS += -DSTART_16=$(CONFIG_SYS_X86_START16)
 
 ifdef CONFIG_X86_64
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_EFI_APP),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
 LDSCRIPT = $(srctree)/arch/x86/cpu/u-boot-64.lds
 endif
 endif
diff --git a/arch/x86/cpu/coreboot/Makefile b/arch/x86/cpu/coreboot/Makefile
index a6cdb9a1485..a6c7d0e56d5 100644
--- a/arch/x86/cpu/coreboot/Makefile
+++ b/arch/x86/cpu/coreboot/Makefile
@@ -14,7 +14,7 @@
 ifndef CONFIG_SPL
 obj-y += car.o
 endif
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += coreboot_spl.o
 else
 obj-y += sdram.o
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d474c79e25e..c3d7442b4a8 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -82,7 +82,7 @@ static void board_final_init(void)
 
 static int last_stage_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return 0;
 
 	board_final_init();
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index ad21fdb457a..ea11b09eacc 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -185,7 +185,7 @@ void show_boot_progress(int val)
 #endif
 
 #if !defined(CONFIG_SYS_COREBOOT) && !defined(CONFIG_EFI_STUB) && \
-	!defined(CONFIG_SPL_BUILD)
+	!defined(CONFIG_XPL_BUILD)
 /*
  * Implement a weak default function for boards that need to do some final init
  * before the system is ready.
@@ -247,7 +247,7 @@ static int last_stage_init(void)
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
-#endif  /* !SYS_COREBOOT && !EFI_STUB && !SPL_BUILD */
+#endif  /* !SYS_COREBOOT && !EFI_STUB && !XPL_BUILD */
 
 static int x86_init_cpus(void)
 {
diff --git a/arch/x86/cpu/intel_common/Makefile b/arch/x86/cpu/intel_common/Makefile
index 1dc17b45879..2e312a30353 100644
--- a/arch/x86/cpu/intel_common/Makefile
+++ b/arch/x86/cpu/intel_common/Makefile
@@ -11,13 +11,13 @@ obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += report_platform.o
 obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += mrc.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_INTEL_GMA_ACPI) += intel_opregion.o
 endif
 
 ifdef CONFIG_INTEL_CAR_CQOS
 obj-$(CONFIG_TPL_BUILD) += car2.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += car2_uninit.o
 endif
 endif
@@ -38,7 +38,7 @@ obj-$(CONFIG_HAVE_ITSS) += itss.o
 obj-$(CONFIG_HAVE_P2SB) += p2sb.o
 
 ifdef CONFIG_SPL
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifndef CONFIG_SYS_COREBOOT
 obj-y += cpu_from_spl.o
 endif
diff --git a/arch/x86/cpu/ivybridge/Makefile b/arch/x86/cpu/ivybridge/Makefile
index 716134e9ff3..1f3b0c092f1 100644
--- a/arch/x86/cpu/ivybridge/Makefile
+++ b/arch/x86/cpu/ivybridge/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_$(SPL_)X86_32BIT_INIT) += cpu.o
 obj-y += early_me.o
 obj-y += lpc.o
 obj-y += northbridge.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += sata.o
 endif
 obj-$(CONFIG_$(SPL_)X86_32BIT_INIT) += sdram.o
diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index 5c49b0f009b..f6836b74488 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -18,7 +18,7 @@ extern char *strchr(const char *s, int c);
  * Our assembly routines do not work on in 64-bit mode and we don't do a lot of
  * copying in SPL, so code size is more important there.
  */
-#if defined(CONFIG_SPL_BUILD) || !IS_ENABLED(CONFIG_X86_32BIT_INIT)
+#if defined(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_X86_32BIT_INIT)
 
 #undef __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8fc35e1b51e..2738f0b577b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -11,11 +11,11 @@ obj-y += bios_asm.o
 obj-y += bios_interrupts.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_X86_32BIT_INIT) += string.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 endif
 obj-y	+= cmd_boot.o
@@ -47,7 +47,7 @@ obj-y += acpigen.o
 obj-$(CONFIG_$(SPL_TPL_)GENERATE_ACPI_TABLE) += acpi_table.o
 endif
 obj-y	+= tables.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ZBOOT) += zimage.o
 endif
 obj-$(CONFIG_USE_HOB) += hob.o
@@ -58,7 +58,7 @@ obj-$(CONFIG_FSP_VERSION1) += fsp1/
 obj-$(CONFIG_FSP_VERSION2) += fsp2/
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_TPL_BUILD
 obj-y += tpl.o
 else
@@ -96,7 +96,7 @@ endif
 
 else
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
diff --git a/arch/x86/lib/fsp/Makefile b/arch/x86/lib/fsp/Makefile
index da6c0a886ae..0039dd1bf5c 100644
--- a/arch/x86/lib/fsp/Makefile
+++ b/arch/x86/lib/fsp/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += fsp_common.o
 obj-y += fsp_dram.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_VIDEO_FSP) += fsp_graphics.o
 endif
 obj-y += fsp_support.o
-- 
2.34.1

