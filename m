Return-Path: <u-boot-bounces@lists.denx.de>
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13448CF6496
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 23:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625BD88CAE;
	Sun, 29 Sep 2024 01:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ejZ6NKcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC8D88CBA; Sat, 28 Sep 2024 22:00:50 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C4288CC2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-82ceab75c27so189007839f.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553648; x=1728158448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcxl342WxLOJgwfmgUJpinuIPghQdy7TWmDt3Fl59hM=;
 b=ejZ6NKcP/XXYS8WxmxXkEvEbvV9bnBdSqf/Zuu/VplW3y10LRoxQjFhFcTHi9E1plF
 LNBRiY7eQcqxlrjEuGIi83/PA2lPUbYGqFoMeg6wxuoNHjvPgScG38iCgfyGiK1GBbUL
 gJV8OSNCWUG/BdiI8Yj2wYOs9AuQz8q7VWVYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553648; x=1728158448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcxl342WxLOJgwfmgUJpinuIPghQdy7TWmDt3Fl59hM=;
 b=k8htPRCn3mkFGn4uBoDADY/sujTcHA0nUuP1lws1bw+yNTwMjWB5YktLXy/wW38nQz
 M0UxOd0X2rRwYyJznVEmU4omiVmqug+CKoiO5dq3ykk5UKV3bocg1rRaiMCM7FBUZf3n
 x/ghQ89n6TV6xFErdbTQi2M94Qr2bykN5JXPWOYxRgGpzEUHc2f5NdZYAnkVPgweHtR6
 EpWlUCbytGTqPZSV3njKCDl8jjhmoMvNV1d9ElL5bM6tft1DKjKlKYKDbsVQJ7O5tD0L
 hd3HvglFZg4BThHOdcIYlid6yLSoPu7vF1wBTkHc0UvEFl0ooiRO0kH+uiP4HpgbEawq
 AStA==
X-Gm-Message-State: AOJu0Yx9WbH1WL2rgkHD1HXKKCnrPP7VYKuIyeBxbAodya6+avssZcMX
 g/aL7eei0hemP11LjLe3dcUaoi+h047sZs95+ZMJX5f2AqjhnEE6FuUn6Ifr+5vANqJA+cOOS8u
 UQewM
X-Google-Smtp-Source: AGHT+IEhP4MEpu50Q+js46m886gO0gX0YLIEEraCCTxdljWuRQ6Wjwzg1PJ+K7sNbEYXqtPvnaIL/A==
X-Received: by 2002:a05:6602:6015:b0:82a:31d4:1aab with SMTP id
 ca18e2360f4ac-834932741fdmr642335739f.14.1727553646413; 
 Sat, 28 Sep 2024 13:00:46 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alifer Moraes <alifer.wsdm@gmail.com>, "Andrew F. Davis" <afd@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Ezequiel Garcia <ezequiel@collabora.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Gilles Talis <gilles.talis@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Hans de Goede <hdegoede@redhat.com>, Harald Seiler <hws@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Peter Robinson <pbrobinson@gmail.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Thierry Reding <treding@nvidia.com>, Tim Harvey <tharvey@gateworks.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 William Zhang <william.zhang@broadcom.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 05/30] global: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sat, 28 Sep 2024 14:00:05 -0600
Message-Id: <20240928200030.194546-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Sep 2024 01:35:59 +0200
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

(no changes since v1)

 README                                        |  4 +-
 arch/arm/Makefile                             |  6 +--
 arch/arm/config.mk                            |  6 +--
 arch/arm/cpu/arm11/Makefile                   |  2 +-
 arch/arm/cpu/arm1176/start.S                  |  2 +-
 arch/arm/cpu/arm926ejs/Makefile               |  2 +-
 arch/arm/cpu/arm926ejs/mxs/Makefile           |  4 +-
 arch/arm/cpu/arm926ejs/sunxi/config.mk        |  2 +-
 arch/arm/cpu/armv7/Makefile                   |  2 +-
 arch/arm/cpu/armv7/cpu.c                      |  2 +-
 arch/arm/cpu/armv7/lowlevel_init.S            |  4 +-
 arch/arm/cpu/armv7/s5p-common/Makefile        |  2 +-
 arch/arm/cpu/armv7/start.S                    |  2 +-
 arch/arm/cpu/armv7/sunxi/Makefile             |  4 +-
 arch/arm/cpu/armv8/Makefile                   |  6 +--
 arch/arm/cpu/armv8/cache_v8.c                 |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/Makefile    |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       | 14 +++---
 .../armv8/fsl-layerscape/fsl_lsch2_speed.c    |  2 +-
 .../armv8/fsl-layerscape/fsl_lsch3_serdes.c   |  6 +--
 arch/arm/cpu/armv8/fsl-layerscape/icid.c      |  6 +--
 arch/arm/cpu/armv8/fsl-layerscape/lowlevel.S  |  6 +--
 .../arm/cpu/armv8/fsl-layerscape/ls1043_ids.c |  2 +-
 .../arm/cpu/armv8/fsl-layerscape/ls1046_ids.c |  2 +-
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |  4 +-
 arch/arm/cpu/armv8/start.S                    |  8 ++--
 arch/arm/dts/imx8qm-u-boot.dtsi               |  2 +-
 arch/arm/dts/imx8qxp-u-boot.dtsi              |  2 +-
 .../asm/arch-fsl-layerscape/fsl_icid.h        |  6 +--
 arch/arm/include/asm/arch-imx8/boot0.h        |  2 +-
 arch/arm/include/asm/arch-lpc32xx/sys_proto.h |  2 +-
 arch/arm/include/asm/arch-mx6/litesom.h       |  2 +-
 arch/arm/include/asm/arch-mx6/mx6-ddr.h       |  4 +-
 arch/arm/include/asm/arch-mxs/sys_proto.h     |  2 +-
 arch/arm/include/asm/arch-rk3066/boot0.h      |  4 +-
 arch/arm/include/asm/arch-rockchip/boot0.h    |  6 +--
 .../include/asm/arch-rockchip/cru_rv1126.h    | 10 ++---
 arch/arm/include/asm/arch-sunxi/boot0.h       |  4 +-
 arch/arm/include/asm/arch-sunxi/sys_proto.h   |  2 +-
 arch/arm/include/asm/fsl_secure_boot.h        |  4 +-
 arch/arm/include/asm/ti-common/sys_proto.h    |  2 +-
 arch/arm/lib/Makefile                         |  2 +-
 arch/arm/lib/crt0.S                           | 14 +++---
 arch/arm/lib/crt0_64.S                        | 10 ++---
 arch/arm/lib/eabi_compat.c                    |  2 +-
 arch/arm/lib/stack.c                          |  2 +-
 arch/arm/lib/vectors.S                        |  6 +--
 arch/arm/lib/zimage.c                         |  4 +-
 arch/arm/mach-aspeed/ast2600/Makefile         |  2 +-
 arch/arm/mach-aspeed/ast2600/lowlevel_init.S  |  2 +-
 arch/arm/mach-at91/Makefile                   |  2 +-
 arch/arm/mach-at91/config.mk                  |  2 +-
 arch/arm/mach-davinci/Makefile                |  2 +-
 arch/arm/mach-davinci/config.mk               |  2 +-
 arch/arm/mach-davinci/misc.c                  |  2 +-
 arch/arm/mach-exynos/Makefile                 |  2 +-
 arch/arm/mach-exynos/lowlevel_init.c          |  4 +-
 arch/arm/mach-exynos/pinmux.c                 |  2 +-
 arch/arm/mach-imx/Makefile                    | 18 ++++----
 arch/arm/mach-imx/cpu.c                       |  6 +--
 arch/arm/mach-imx/hab.c                       |  8 ++--
 arch/arm/mach-imx/imx8/cpu.c                  |  4 +-
 arch/arm/mach-imx/imx8m/clock_imx8mm.c        |  2 +-
 arch/arm/mach-imx/imx8m/clock_imx8mq.c        |  4 +-
 arch/arm/mach-imx/imx8m/soc.c                 | 16 +++----
 arch/arm/mach-imx/imx8ulp/Makefile            |  2 +-
 arch/arm/mach-imx/imx8ulp/clock.c             |  2 +-
 arch/arm/mach-imx/imx8ulp/lowlevel_init.S     |  2 +-
 arch/arm/mach-imx/imx8ulp/soc.c               | 12 ++---
 arch/arm/mach-imx/imx9/Makefile               |  2 +-
 arch/arm/mach-imx/imx9/clock.c                |  4 +-
 arch/arm/mach-imx/imx9/lowlevel_init.S        |  2 +-
 arch/arm/mach-imx/imx9/soc.c                  | 12 ++---
 arch/arm/mach-imx/mx5/clock.c                 |  2 +-
 arch/arm/mach-imx/mx6/Makefile                |  2 +-
 arch/arm/mach-imx/mx6/clock.c                 |  2 +-
 arch/arm/mach-imx/mx6/litesom.c               |  2 +-
 arch/arm/mach-imx/mx6/opos6ul.c               |  4 +-
 arch/arm/mach-imx/mx6/soc.c                   |  6 +--
 arch/arm/mach-imx/mx7/clock.c                 |  2 +-
 arch/arm/mach-imx/mx7/soc.c                   |  4 +-
 arch/arm/mach-imx/mx7ulp/clock.c              |  2 +-
 arch/arm/mach-imx/mx7ulp/soc.c                |  2 +-
 arch/arm/mach-imx/syscounter.c                |  2 +-
 arch/arm/mach-k3/am62ax/Makefile              |  2 +-
 arch/arm/mach-k3/am62px/Makefile              |  2 +-
 arch/arm/mach-k3/am62x/Makefile               |  2 +-
 arch/arm/mach-k3/am64x/Makefile               |  2 +-
 arch/arm/mach-k3/am65x/Makefile               |  2 +-
 arch/arm/mach-k3/arm64/cache.S                |  2 +-
 arch/arm/mach-k3/j721e/Makefile               |  2 +-
 arch/arm/mach-k3/j721s2/Makefile              |  2 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  2 +-
 arch/arm/mach-k3/j722s/Makefile               |  2 +-
 arch/arm/mach-k3/j784s4/Makefile              |  2 +-
 arch/arm/mach-k3/r5/Makefile                  |  2 +-
 arch/arm/mach-k3/security.c                   |  2 +-
 arch/arm/mach-keystone/Makefile               |  2 +-
 arch/arm/mach-keystone/config.mk              |  4 +-
 arch/arm/mach-keystone/mon.c                  |  2 +-
 arch/arm/mach-lpc32xx/Makefile                |  2 +-
 arch/arm/mach-mediatek/Makefile               |  2 +-
 arch/arm/mach-mediatek/mt7629/lowlevel_init.S |  2 +-
 arch/arm/mach-mvebu/Makefile                  |  8 ++--
 arch/arm/mach-mvebu/cpu.c                     |  4 +-
 arch/arm/mach-mvebu/include/mach/cpu.h        |  8 ++--
 arch/arm/mach-mvebu/include/mach/soc.h        |  2 +-
 arch/arm/mach-mvebu/serdes/a38x/Makefile      |  8 ++--
 arch/arm/mach-mvebu/serdes/axp/Makefile       |  4 +-
 arch/arm/mach-nexell/include/mach/display.h   |  2 +-
 arch/arm/mach-omap2/Makefile                  |  2 +-
 arch/arm/mach-omap2/am33xx/board.c            | 18 ++++----
 arch/arm/mach-omap2/boot-common.c             |  6 +--
 arch/arm/mach-omap2/clocks-common.c           |  2 +-
 arch/arm/mach-omap2/config.mk                 |  2 +-
 arch/arm/mach-omap2/config_secure.mk          |  2 +-
 arch/arm/mach-omap2/hwinit-common.c           | 14 +++---
 arch/arm/mach-omap2/omap3/Makefile            |  2 +-
 arch/arm/mach-omap2/omap3/board.c             |  6 +--
 arch/arm/mach-omap2/omap3/sdrc.c              |  4 +-
 arch/arm/mach-omap2/omap5/hwinit.c            |  2 +-
 arch/arm/mach-omap2/sec-common.c              |  2 +-
 arch/arm/mach-orion5x/cpu.c                   |  2 +-
 arch/arm/mach-orion5x/lowlevel_init.S         |  4 +-
 arch/arm/mach-renesas/include/mach/boot0.h    |  2 +-
 arch/arm/mach-renesas/lowlevel_init_ca15.S    |  2 +-
 arch/arm/mach-rockchip/Makefile               |  4 +-
 arch/arm/mach-rockchip/px30/px30.c            |  2 +-
 arch/arm/mach-rockchip/rk3036/Makefile        |  2 +-
 arch/arm/mach-rockchip/rk3066/rk3066.c        |  2 +-
 arch/arm/mach-rockchip/rk3188/rk3188.c        |  4 +-
 arch/arm/mach-rockchip/rk322x/rk322x.c        |  2 +-
 arch/arm/mach-rockchip/rk3288/rk3288.c        |  4 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c        |  2 +-
 arch/arm/mach-rockchip/rk3328/rk3328.c        |  2 +-
 arch/arm/mach-rockchip/rk3368/rk3368.c        |  2 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c        |  8 ++--
 arch/arm/mach-rockchip/rk3568/rk3568.c        |  2 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c        |  4 +-
 arch/arm/mach-rockchip/rv1108/Makefile        |  2 +-
 arch/arm/mach-rockchip/rv1126/rv1126.c        |  2 +-
 arch/arm/mach-sc5xx/Makefile                  |  2 +-
 arch/arm/mach-sc5xx/config.mk                 |  2 +-
 arch/arm/mach-socfpga/Makefile                |  2 +-
 arch/arm/mach-socfpga/board.c                 |  6 +--
 arch/arm/mach-socfpga/clock_manager.c         |  2 +-
 arch/arm/mach-socfpga/clock_manager_arria10.c |  2 +-
 arch/arm/mach-socfpga/include/mach/boot0.h    |  2 +-
 .../include/mach/clock_manager_arria10.h      |  2 +-
 arch/arm/mach-socfpga/lowlevel_init_soc64.S   |  2 +-
 arch/arm/mach-socfpga/mailbox_s10.c           |  2 +-
 arch/arm/mach-socfpga/misc.c                  |  2 +-
 arch/arm/mach-socfpga/misc_arria10.c          |  2 +-
 arch/arm/mach-socfpga/misc_gen5.c             |  2 +-
 arch/arm/mach-socfpga/reset_manager_s10.c     |  2 +-
 arch/arm/mach-socfpga/secure_vab.c            |  2 +-
 arch/arm/mach-socfpga/timer_s10.c             |  4 +-
 arch/arm/mach-socfpga/wrap_pll_config_soc64.c |  6 +--
 arch/arm/mach-stm32mp/Makefile                |  2 +-
 arch/arm/mach-stm32mp/bsec.c                  | 12 ++---
 arch/arm/mach-stm32mp/stm32mp1/Makefile       |  2 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c          |  6 +--
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c   |  4 +-
 arch/arm/mach-sunxi/Makefile                  |  2 +-
 arch/arm/mach-sunxi/board.c                   | 10 ++---
 arch/arm/mach-sunxi/clock_sun4i.c             |  4 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  4 +-
 arch/arm/mach-sunxi/clock_sun6i.c             |  4 +-
 arch/arm/mach-sunxi/clock_sun8i_a83t.c        |  4 +-
 arch/arm/mach-sunxi/clock_sun9i.c             |  4 +-
 arch/arm/mach-sunxi/gtbus_sun9i.c             |  2 +-
 arch/arm/mach-tegra/Makefile                  |  4 +-
 arch/arm/mach-tegra/board.c                   |  2 +-
 arch/arm/mach-tegra/board2.c                  |  2 +-
 arch/arm/mach-tegra/tegra114/Makefile         |  2 +-
 arch/arm/mach-tegra/tegra124/Makefile         |  4 +-
 arch/arm/mach-tegra/tegra20/Makefile          |  2 +-
 arch/arm/mach-tegra/tegra30/Makefile          |  2 +-
 arch/arm/mach-uniphier/Makefile               |  2 +-
 arch/arm/mach-uniphier/arm32/Makefile         |  2 +-
 .../mach-uniphier/boot-device/boot-device.c   |  4 +-
 arch/arm/mach-uniphier/clk/Makefile           |  2 +-
 arch/arm/mach-uniphier/debug-uart/Makefile    |  2 +-
 .../arm/mach-uniphier/debug-uart/debug-uart.c |  4 +-
 arch/arm/mach-uniphier/dram/Makefile          |  2 +-
 arch/arm/mach-zynq/Makefile                   |  2 +-
 arch/arm/mach-zynq/cpu.c                      |  2 +-
 arch/arm/mach-zynqmp/Makefile                 |  6 +--
 arch/arm/mach-zynqmp/cpu.c                    |  4 +-
 arch/microblaze/config.mk                     |  2 +-
 arch/microblaze/cpu/Makefile                  |  2 +-
 arch/microblaze/cpu/start.S                   |  8 ++--
 arch/mips/Makefile                            |  2 +-
 arch/mips/config.mk                           |  2 +-
 arch/mips/lib/Makefile                        |  2 +-
 arch/mips/mach-jz47xx/Makefile                |  2 +-
 arch/mips/mach-jz47xx/include/mach/jz4780.h   |  2 +-
 arch/mips/mach-jz47xx/jz4780/jz4780.c         |  4 +-
 arch/mips/mach-jz47xx/start.S                 |  4 +-
 arch/mips/mach-mtmips/Makefile                |  2 +-
 arch/mips/mach-mtmips/cpu.c                   |  2 +-
 arch/mips/mach-mtmips/mt7620/Makefile         |  2 +-
 arch/mips/mach-mtmips/mt7621/Makefile         |  2 +-
 arch/mips/mach-mtmips/mt7628/Makefile         |  2 +-
 arch/powerpc/config.mk                        |  2 +-
 arch/powerpc/cpu/mpc83xx/Makefile             |  2 +-
 arch/powerpc/cpu/mpc83xx/start.S              |  6 +--
 arch/powerpc/cpu/mpc85xx/Makefile             |  4 +-
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c     |  2 +-
 arch/powerpc/cpu/mpc85xx/start.S              | 14 +++---
 arch/powerpc/cpu/mpc85xx/tlb.c                |  4 +-
 arch/powerpc/cpu/mpc8xxx/Makefile             |  2 +-
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c           |  4 +-
 arch/powerpc/cpu/mpc8xxx/law.c                |  4 +-
 arch/powerpc/cpu/mpc8xxx/pamu_table.c         |  2 +-
 arch/powerpc/include/asm/fsl_secure_boot.h    |  8 ++--
 arch/powerpc/lib/Makefile                     |  4 +-
 arch/riscv/cpu/fu540/Makefile                 |  2 +-
 arch/riscv/cpu/fu740/Makefile                 |  2 +-
 arch/riscv/cpu/jh7110/Makefile                |  2 +-
 arch/riscv/cpu/start.S                        |  8 ++--
 arch/riscv/lib/Makefile                       |  2 +-
 arch/riscv/lib/sifive_cache.c                 |  4 +-
 arch/sandbox/cpu/Makefile                     |  2 +-
 arch/sandbox/cpu/cpu.c                        |  2 +-
 arch/sandbox/cpu/start.c                      |  2 +-
 arch/x86/Makefile                             |  2 +-
 arch/x86/config.mk                            |  8 ++--
 arch/x86/cpu/Makefile                         |  2 +-
 arch/x86/cpu/apollolake/Makefile              | 10 ++---
 arch/x86/cpu/apollolake/fsp_bindings.c        |  4 +-
 arch/x86/cpu/broadwell/Makefile               |  4 +-
 arch/x86/cpu/broadwell/cpu_full.c             |  2 +-
 arch/x86/cpu/broadwell/pch.c                  |  2 +-
 arch/x86/cpu/config.mk                        |  2 +-
 arch/x86/cpu/coreboot/Makefile                |  2 +-
 arch/x86/cpu/coreboot/coreboot.c              |  2 +-
 arch/x86/cpu/cpu.c                            |  2 +-
 arch/x86/cpu/intel_common/Makefile            |  6 +--
 arch/x86/cpu/ivybridge/Makefile               |  2 +-
 arch/x86/include/asm/string.h                 |  2 +-
 arch/x86/lib/Makefile                         | 10 ++---
 arch/x86/lib/fsp/Makefile                     |  2 +-
 board/BuR/brppt1/Makefile                     |  2 +-
 board/BuR/brppt1/board.c                      |  4 +-
 board/BuR/brppt2/board.c                      |  6 +--
 board/BuR/brppt2/config.mk                    |  2 +-
 board/BuR/brsmarc1/Makefile                   |  2 +-
 board/BuR/brsmarc1/board.c                    |  8 ++--
 board/BuR/brxre1/Makefile                     |  2 +-
 board/BuR/brxre1/board.c                      |  4 +-
 board/BuR/common/common.c                     |  4 +-
 board/CZ.NIC/turris_1x/Makefile               |  2 +-
 board/CZ.NIC/turris_1x/tlb.c                  |  2 +-
 board/CZ.NIC/turris_omnia/Makefile            |  2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
 board/Synology/ds414/Makefile                 |  2 +-
 board/advantech/imx8mp_rsb3720a1/Makefile     |  4 +-
 board/advantech/imx8qm_dmsse20_a1/Makefile    |  2 +-
 board/advantech/imx8qm_rom7720_a1/Makefile    |  2 +-
 board/alliedtelesis/x530/Makefile             |  2 +-
 board/asus/grouper/Makefile                   |  2 +-
 board/asus/transformer-t30/Makefile           |  2 +-
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |  2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |  2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |  2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |  2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |  2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c         |  2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |  2 +-
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |  2 +-
 board/atmel/sama5d3xek/sama5d3xek.c           |  2 +-
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |  2 +-
 board/atmel/sama5d4ek/sama5d4ek.c             |  2 +-
 board/avionic-design/tec-ng/Makefile          |  2 +-
 board/beacon/imx8mm/Makefile                  |  2 +-
 board/beacon/imx8mn/Makefile                  |  2 +-
 board/beacon/imx8mp/Makefile                  |  2 +-
 board/bitmain/antminer_s9/Makefile            |  2 +-
 board/bosch/acc/acc.c                         |  2 +-
 board/bosch/shc/board.c                       |  4 +-
 board/bsh/imx6ulz_smm_m2/Makefile             |  2 +-
 board/bsh/imx8mn_smm_s2/Makefile              |  2 +-
 board/bticino/mamoj/Makefile                  |  2 +-
 board/cloos/imx8mm_phg/Makefile               |  2 +-
 board/compulab/cl-som-imx7/Makefile           |  2 +-
 board/compulab/cl-som-imx7/common.h           |  4 +-
 board/compulab/cl-som-imx7/mux.c              |  4 +-
 board/compulab/cm_fx6/Makefile                |  2 +-
 board/compulab/cm_t43/Makefile                |  2 +-
 board/compulab/imx8mm-cl-iot-gate/Makefile    |  2 +-
 .../compulab/imx8mm-cl-iot-gate/eeprom_spl.c  |  2 +-
 board/comvetia/lxr2/lxr2.c                    |  2 +-
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |  2 +-
 board/congatec/cgtqmx8/Makefile               |  2 +-
 board/congatec/common/Makefile                |  2 +-
 board/data_modul/common/common.c              |  2 +-
 board/data_modul/imx8mm_edm_sbc/Makefile      |  2 +-
 board/data_modul/imx8mp_edm_sbc/Makefile      |  2 +-
 board/davinci/da8xxevm/omapl138_lcdk.c        |  2 +-
 board/dhelectronics/dh_imx6/Makefile          |  2 +-
 board/dhelectronics/dh_imx8mp/Makefile        |  2 +-
 board/dhelectronics/dh_stm32mp1/board.c       |  6 +--
 board/ea/mx7ulp_com/mx7ulp_com.c              |  2 +-
 board/eets/pdu001/board.c                     |  2 +-
 board/embest/mx6boards/mx6boards.c            |  2 +-
 board/engicam/common/Makefile                 |  2 +-
 board/engicam/imx8mm/Makefile                 |  2 +-
 board/engicam/imx8mp/Makefile                 |  2 +-
 board/engicam/stm32mp1/Makefile               |  2 +-
 board/firefly/firefly-rk3288/firefly-rk3288.c |  2 +-
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   |  2 +-
 board/freescale/common/Makefile               |  6 +--
 board/freescale/common/cmd_esbc_validate.c    |  2 +-
 board/freescale/common/fsl_chain_of_trust.c   |  8 ++--
 board/freescale/common/fsl_validate.c         |  4 +-
 board/freescale/common/qixis.c                |  2 +-
 board/freescale/imx8mm_evk/Makefile           |  2 +-
 board/freescale/imx8mn_evk/Makefile           |  2 +-
 board/freescale/imx8mp_evk/Makefile           |  2 +-
 board/freescale/imx8mq_evk/Makefile           |  2 +-
 board/freescale/imx8qm_mek/Makefile           |  2 +-
 board/freescale/imx8qxp_mek/Makefile          |  2 +-
 board/freescale/imx8ulp_evk/Makefile          |  2 +-
 board/freescale/imx93_evk/Makefile            |  2 +-
 board/freescale/imxrt1020-evk/imxrt1020-evk.c |  2 +-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c |  2 +-
 board/freescale/imxrt1170-evk/imxrt1170-evk.c |  2 +-
 board/freescale/ls1012afrdm/ls1012afrdm.c     |  2 +-
 board/freescale/ls1012aqds/ls1012aqds.c       |  2 +-
 board/freescale/ls1012ardb/ls1012ardb.c       |  2 +-
 board/freescale/ls1021aiot/ls1021aiot.c       |  4 +-
 board/freescale/ls1021aqds/ddr.c              |  4 +-
 board/freescale/ls1021aqds/ls1021aqds.c       |  2 +-
 board/freescale/ls1021atsn/ls1021atsn.c       | 10 ++---
 board/freescale/ls1021atwr/ls1021atwr.c       | 10 ++---
 board/freescale/ls1028a/ls1028a.c             |  2 +-
 board/freescale/ls1043aqds/Makefile           |  2 +-
 board/freescale/ls1043aqds/ddr.c              |  2 +-
 board/freescale/ls1043aqds/ls1043aqds.c       |  2 +-
 board/freescale/ls1043ardb/Makefile           |  2 +-
 board/freescale/ls1043ardb/ddr.c              |  4 +-
 board/freescale/ls1043ardb/ls1043ardb.c       |  2 +-
 board/freescale/ls1046aqds/Makefile           |  2 +-
 board/freescale/ls1046aqds/ddr.c              |  2 +-
 board/freescale/ls1046aqds/ls1046aqds.c       |  2 +-
 board/freescale/ls1046ardb/Makefile           |  2 +-
 board/freescale/ls1046ardb/ddr.c              |  2 +-
 board/freescale/ls1046ardb/ls1046ardb.c       |  2 +-
 board/freescale/ls1088a/Makefile              |  2 +-
 board/freescale/ls1088a/ddr.c                 |  6 +--
 board/freescale/ls1088a/ls1088a.c             |  8 ++--
 board/freescale/ls2080aqds/ddr.c              |  2 +-
 board/freescale/ls2080aqds/ls2080aqds.c       |  4 +-
 board/freescale/ls2080ardb/ddr.c              |  2 +-
 board/freescale/ls2080ardb/eth_ls2080rdb.c    |  2 +-
 board/freescale/lx2160a/lx2160a.c             |  2 +-
 board/freescale/mx23evk/Makefile              |  2 +-
 board/freescale/mx28evk/Makefile              |  2 +-
 board/freescale/mx6memcal/Makefile            |  2 +-
 board/freescale/mx6sabreauto/mx6sabreauto.c   |  2 +-
 board/freescale/mx6sabresd/mx6sabresd.c       |  2 +-
 board/freescale/mx6slevk/mx6slevk.c           |  4 +-
 .../mx6ul_14x14_evk/mx6ul_14x14_evk.c         |  4 +-
 board/freescale/p1010rdb/Makefile             |  4 +-
 board/freescale/p1010rdb/p1010rdb.c           |  2 +-
 board/freescale/p1010rdb/tlb.c                |  2 +-
 board/freescale/p1_p2_rdb_pc/Makefile         |  4 +-
 board/freescale/p1_p2_rdb_pc/tlb.c            |  2 +-
 board/freescale/t102xrdb/Makefile             |  2 +-
 board/freescale/t102xrdb/ddr.c                |  4 +-
 board/freescale/t102xrdb/tlb.c                |  4 +-
 board/freescale/t104xrdb/Makefile             |  2 +-
 board/freescale/t104xrdb/ddr.c                |  4 +-
 board/freescale/t104xrdb/tlb.c                |  6 +--
 board/freescale/t208xqds/Makefile             |  2 +-
 board/freescale/t208xqds/ddr.c                |  2 +-
 board/freescale/t208xqds/tlb.c                |  4 +-
 board/freescale/t208xrdb/Makefile             |  2 +-
 board/freescale/t208xrdb/ddr.c                |  2 +-
 board/freescale/t208xrdb/tlb.c                |  4 +-
 board/freescale/t4rdb/Makefile                |  2 +-
 board/freescale/t4rdb/cpld.c                  |  2 +-
 board/freescale/t4rdb/ddr.c                   |  2 +-
 board/freescale/t4rdb/tlb.c                   |  4 +-
 board/gardena/smart-gateway-at91sam/Makefile  |  2 +-
 board/gardena/smart-gateway-mt7688/board.c    |  2 +-
 board/gateworks/gw_ventana/Makefile           |  2 +-
 board/gateworks/gw_ventana/eeprom.c           |  2 +-
 board/gateworks/venice/Makefile               |  2 +-
 board/gdsys/a38x/Makefile                     |  2 +-
 board/gdsys/a38x/controlcenterdc.c            | 12 ++---
 board/ge/b1x5v2/b1x5v2.c                      |  4 +-
 board/ge/b1x5v2/spl.c                         |  2 +-
 board/google/chromebook_coral/coral.c         |  2 +-
 board/google/gru/gru.c                        |  4 +-
 board/google/imx8mq_phanbell/Makefile         |  2 +-
 board/google/veyron/veyron.c                  |  2 +-
 board/grinn/chiliboard/board.c                |  2 +-
 board/grinn/liteboard/board.c                 |  2 +-
 board/htc/endeavoru/Makefile                  |  2 +-
 board/imgtec/ci20/ci20.c                      |  4 +-
 board/isee/igep003x/Makefile                  |  2 +-
 board/isee/igep003x/board.c                   |  2 +-
 board/isee/igep00x0/Makefile                  |  2 +-
 board/k+p/kp_imx6q_tpc/Makefile               |  2 +-
 board/kontron/pitx_imx8m/Makefile             |  2 +-
 board/kontron/sl-mx6ul/Makefile               |  2 +-
 board/kontron/sl-mx8mm/Makefile               |  2 +-
 board/kontron/sl28/Makefile                   |  4 +-
 board/kontron/sl28/ddr.c                      |  2 +-
 board/kosagi/novena/Makefile                  |  2 +-
 board/lenovo/ideapad-yoga-11/Makefile         |  2 +-
 board/lg/sniper/sniper.c                      |  2 +-
 board/lg/x3-t30/Makefile                      |  2 +-
 board/liebherr/display5/Makefile              |  2 +-
 board/liebherr/mccmon6/Makefile               |  2 +-
 board/liebherr/xea/Makefile                   |  2 +-
 board/liebherr/xea/xea.c                      |  6 +--
 board/logicpd/am3517evm/am3517evm.c           |  2 +-
 board/logicpd/imx6/imx6logic.c                |  2 +-
 board/logicpd/omap3som/omap3logic.c           |  2 +-
 board/menlo/m53menlo/m53menlo.c               |  2 +-
 board/menlo/mx8menlo/Makefile                 |  4 +-
 board/microsoft/surface-rt/Makefile           |  2 +-
 board/mntre/imx8mq_reform2/Makefile           |  2 +-
 board/msc/sm2s_imx8mp/Makefile                |  2 +-
 board/myir/mys_6ulx/Makefile                  |  2 +-
 board/nvidia/beaver/Makefile                  |  2 +-
 board/nvidia/cardhu/Makefile                  |  2 +-
 board/olimex/mx23_olinuxino/Makefile          |  2 +-
 board/opalkelly/zynq/Makefile                 |  2 +-
 board/phytec/common/Makefile                  |  2 +-
 board/phytec/pcl063/Makefile                  |  2 +-
 board/phytec/pcm058/pcm058.c                  |  2 +-
 board/phytec/phycore_am335x_r2/Makefile       |  2 +-
 board/phytec/phycore_am335x_r2/board.c        |  2 +-
 board/phytec/phycore_am62x/phycore-am62x.c    |  2 +-
 board/phytec/phycore_imx8mm/Makefile          |  2 +-
 board/phytec/phycore_imx8mp/Makefile          |  2 +-
 board/phytec/phycore_imx93/Makefile           |  2 +-
 board/polyhex/imx8mp_debix_model_a/Makefile   |  2 +-
 board/purism/librem5/Makefile                 |  2 +-
 board/purism/librem5/librem5.h                |  4 +-
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c   |  4 +-
 board/renesas/alt/Makefile                    |  2 +-
 board/renesas/condor/Makefile                 |  2 +-
 board/renesas/draak/Makefile                  |  2 +-
 board/renesas/eagle/Makefile                  |  2 +-
 board/renesas/ebisu/Makefile                  |  2 +-
 board/renesas/falcon/Makefile                 |  2 +-
 board/renesas/gose/Makefile                   |  2 +-
 board/renesas/koelsch/Makefile                |  2 +-
 board/renesas/lager/Makefile                  |  2 +-
 board/renesas/porter/Makefile                 |  2 +-
 board/renesas/salvator-x/Makefile             |  2 +-
 board/renesas/silk/Makefile                   |  2 +-
 board/renesas/stout/Makefile                  |  2 +-
 board/renesas/ulcb/Makefile                   |  2 +-
 board/renesas/v3hsk/Makefile                  |  2 +-
 board/renesas/v3msk/Makefile                  |  2 +-
 board/ronetix/imx7-cm/Makefile                |  2 +-
 board/ronetix/imx8mq-cm/Makefile              |  2 +-
 board/samsung/common/Makefile                 |  2 +-
 board/samsung/origen/Makefile                 |  2 +-
 board/samsung/smdkv310/Makefile               |  2 +-
 board/seeed/npi_imx6ull/Makefile              |  2 +-
 board/sielaff/imx6dl-sielaff/Makefile         |  2 +-
 board/siemens/capricorn/Makefile              |  2 +-
 board/siemens/capricorn/board.c               |  8 ++--
 board/siemens/common/board_am335x.c           | 12 ++---
 board/siemens/common/board_am335x.h           |  4 +-
 board/siemens/common/factoryset.c             |  4 +-
 board/siemens/corvus/board.c                  |  2 +-
 board/siemens/draco/Makefile                  |  4 +-
 board/siemens/draco/board.c                   | 14 +++---
 board/siemens/pxm2/Makefile                   |  4 +-
 board/siemens/pxm2/board.c                    | 14 +++---
 board/siemens/rut/Makefile                    |  4 +-
 board/siemens/rut/board.c                     |  8 ++--
 board/siemens/smartweb/smartweb.c             |  2 +-
 board/siemens/taurus/taurus.c                 |  4 +-
 board/sifive/unleashed/Makefile               |  2 +-
 board/sifive/unmatched/Makefile               |  2 +-
 board/silinux/ek874/Makefile                  |  2 +-
 board/softing/vining_2000/vining_2000.c       |  2 +-
 board/softing/vining_fpga/socfpga.c           |  2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |  2 +-
 board/st/common/cmd_stboard.c                 |  2 +-
 board/st/stm32f746-disco/stm32f746-disco.c    |  4 +-
 board/st/stm32mp1/Makefile                    |  2 +-
 board/starfive/visionfive2/Makefile           |  2 +-
 board/sunxi/board.c                           |  6 +--
 board/tcl/sl50/board.c                        | 14 +++---
 board/technexion/pico-imx6/spl.c              |  2 +-
 board/technexion/pico-imx6ul/spl.c            |  2 +-
 board/technexion/pico-imx7d/spl.c             |  2 +-
 board/technexion/pico-imx8mq/Makefile         |  2 +-
 board/theadorable/theadorable.c               |  6 +--
 .../theobroma-systems/jaguar_rk3588/Makefile  |  2 +-
 board/theobroma-systems/puma_rk3399/Makefile  |  2 +-
 .../theobroma-systems/ringneck_px30/Makefile  |  2 +-
 board/theobroma-systems/tiger_rk3588/Makefile |  2 +-
 board/ti/am335x/board.c                       | 12 ++---
 board/ti/am57xx/board.c                       | 10 ++---
 board/ti/am62x/evm.c                          |  2 +-
 board/ti/am64x/evm.c                          |  2 +-
 board/ti/common/board_detect.c                |  6 +--
 board/ti/dra7xx/evm.c                         |  6 +--
 board/ti/j721e/evm.c                          |  6 +--
 board/ti/j721s2/evm.c                         |  4 +-
 board/ti/ks2_evm/board.c                      |  2 +-
 board/ti/ks2_evm/board_k2e.c                  |  2 +-
 board/ti/ks2_evm/board_k2g.c                  |  4 +-
 board/ti/ks2_evm/board_k2hk.c                 |  2 +-
 board/ti/ks2_evm/board_k2l.c                  |  2 +-
 board/ti/omap3evm/evm.c                       |  4 +-
 board/timll/devkit8000/devkit8000.c           |  2 +-
 board/topic/zynq/Makefile                     |  2 +-
 board/toradex/apalis_imx6/apalis_imx6.c       | 12 ++---
 board/toradex/apalis_imx6/do_fuse.c           |  4 +-
 board/toradex/apalis_imx6/pf0100.c            |  4 +-
 board/toradex/apalis_t30/Makefile             |  2 +-
 board/toradex/colibri_imx6/colibri_imx6.c     | 12 ++---
 board/toradex/colibri_imx6/do_fuse.c          |  4 +-
 board/toradex/colibri_imx6/pf0100.c           |  4 +-
 board/toradex/colibri_t30/Makefile            |  2 +-
 board/toradex/common/Makefile                 |  2 +-
 board/toradex/verdin-imx8mm/Makefile          |  2 +-
 board/toradex/verdin-imx8mp/Makefile          |  2 +-
 board/udoo/neo/neo.c                          |  2 +-
 board/udoo/udoo_spl.c                         |  2 +-
 board/variscite/common/imx9_eeprom.c          |  2 +-
 board/variscite/dart_6ul/Makefile             |  2 +-
 board/variscite/imx8mn_var_som/Makefile       |  2 +-
 .../variscite/imx8mn_var_som/imx8mn_var_som.c |  4 +-
 board/variscite/imx93_var_som/Makefile        |  2 +-
 board/vscom/baltos/board.c                    | 14 +++---
 board/wandboard/Makefile                      |  2 +-
 board/wexler/qc750/Makefile                   |  2 +-
 board/work-microwave/work_92105/Makefile      |  2 +-
 board/xilinx/common/Makefile                  |  2 +-
 board/xilinx/common/board.c                   |  6 +--
 .../microblaze-generic/microblaze-generic.c   |  2 +-
 board/xilinx/zynq/Makefile                    |  6 +--
 board/xilinx/zynq/board.c                     |  4 +-
 board/xilinx/zynqmp/Makefile                  |  6 +--
 board/xilinx/zynqmp/zynqmp.c                  |  6 +--
 boot/Makefile                                 |  2 +-
 boot/image-android-dt.c                       |  2 +-
 boot/image-android.c                          |  2 +-
 boot/image-fit-sig.c                          |  2 +-
 cmd/Makefile                                  |  4 +-
 cmd/nvedit.c                                  | 12 ++---
 common/Makefile                               | 12 ++---
 common/cli_readline.c                         |  2 +-
 common/console.c                              |  2 +-
 common/hash.c                                 |  2 +-
 common/spl/Makefile                           |  2 +-
 common/splash_source.c                        |  2 +-
 config.mk                                     |  2 +-
 disk/part.c                                   |  2 +-
 disk/part_dos.c                               |  2 +-
 doc/develop/distro.rst                        |  4 +-
 doc/develop/qconfig.rst                       |  2 +-
 doc/develop/tests_sandbox.rst                 |  2 +-
 drivers/Makefile                              |  4 +-
 drivers/block/Makefile                        |  2 +-
 drivers/bus/Makefile                          |  2 +-
 drivers/clk/altera/clk-agilex.c               |  2 +-
 drivers/clk/altera/clk-agilex5.c              |  2 +-
 drivers/clk/altera/clk-n5x.c                  |  2 +-
 drivers/clk/clk-uclass.c                      |  2 +-
 drivers/clk/clk_vexpress_osc.c                |  4 +-
 drivers/clk/clk_zynq.c                        | 22 +++++-----
 drivers/clk/imx/clk-imx8mm.c                  |  6 +--
 drivers/clk/imx/clk-imx8mn.c                  |  6 +--
 drivers/clk/imx/clk-imxrt1020.c               |  2 +-
 drivers/clk/imx/clk-imxrt1050.c               |  2 +-
 drivers/clk/rockchip/clk_px30.c               |  6 +--
 drivers/clk/rockchip/clk_rk3188.c             |  6 +--
 drivers/clk/rockchip/clk_rk3288.c             |  8 ++--
 drivers/clk/rockchip/clk_rk3328.c             |  4 +-
 drivers/clk/rockchip/clk_rk3368.c             | 14 +++---
 drivers/clk/rockchip/clk_rk3399.c             | 10 ++---
 drivers/clk/rockchip/clk_rk3568.c             | 10 ++---
 drivers/clk/rockchip/clk_rk3588.c             | 14 +++---
 drivers/clk/sifive/sifive-prci.c              |  2 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |  4 +-
 drivers/clk/stm32/clk-stm32mp1.c              |  6 +--
 drivers/core/ofnode.c                         |  4 +-
 drivers/crypto/fsl/jobdesc.c                  |  2 +-
 drivers/crypto/fsl/jr.c                       |  6 +--
 drivers/ddr/altera/sdram_gen5.c               |  4 +-
 drivers/ddr/fsl/lc_common_dimm_params.c       |  6 +--
 drivers/ddr/fsl/main.c                        |  6 +--
 drivers/ddr/imx/imx8m/Makefile                |  2 +-
 drivers/ddr/imx/imx8ulp/Makefile              |  2 +-
 drivers/ddr/imx/imx9/Makefile                 |  2 +-
 drivers/ddr/imx/phy/Makefile                  |  2 +-
 drivers/ddr/marvell/a38x/Makefile             | 44 +++++++++----------
 drivers/ddr/marvell/a38x/old/Makefile         | 28 ++++++------
 drivers/ddr/marvell/axp/Makefile              | 20 ++++-----
 drivers/firmware/firmware-zynqmp.c            | 10 ++---
 drivers/fpga/intel_sdm_mb.c                   |  2 +-
 drivers/fpga/zynqpl.c                         |  6 +--
 drivers/gpio/Makefile                         |  2 +-
 drivers/gpio/gpio-uclass.c                    |  4 +-
 drivers/gpio/pca953x.c                        |  2 +-
 drivers/gpio/rk_gpio.c                        |  4 +-
 drivers/gpio/s5p_gpio.c                       | 10 ++---
 drivers/gpio/sunxi_gpio.c                     |  2 +-
 drivers/gpio/tca642x.c                        |  2 +-
 drivers/gpio/tegra_gpio.c                     |  2 +-
 drivers/input/Makefile                        |  2 +-
 drivers/mailbox/zynqmp-ipi.c                  |  6 +--
 drivers/misc/Makefile                         |  6 +--
 drivers/misc/gsc.c                            |  2 +-
 drivers/misc/imx8/scu.c                       |  2 +-
 drivers/mmc/Makefile                          |  2 +-
 drivers/mmc/mmc-uclass.c                      |  4 +-
 drivers/mmc/mmc.c                             | 20 ++++-----
 drivers/mmc/mmc_legacy.c                      |  4 +-
 drivers/mmc/mmc_private.h                     |  2 +-
 drivers/mmc/omap_hsmmc.c                      |  4 +-
 drivers/mmc/rockchip_dw_mmc.c                 |  2 +-
 drivers/mmc/rockchip_sdhci.c                  |  2 +-
 drivers/mmc/socfpga_dw_mmc.c                  |  2 +-
 drivers/mmc/tmio-common.c                     |  2 +-
 drivers/mmc/uniphier-sd.c                     |  4 +-
 drivers/mmc/zynq_sdhci.c                      |  6 +--
 drivers/mtd/Makefile                          |  2 +-
 drivers/mtd/nand/Makefile                     |  2 +-
 drivers/mtd/nand/raw/Makefile                 |  2 +-
 drivers/mtd/nand/raw/atmel_nand.c             |  4 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |  6 +--
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c       |  8 ++--
 drivers/mtd/nand/raw/nand_base.c              | 10 ++---
 drivers/mtd/nand/raw/omap_gpmc.c              |  4 +-
 drivers/mtd/nand/raw/sand_nand.c              |  2 +-
 drivers/mtd/onenand/Makefile                  |  2 +-
 drivers/mtd/spi/Makefile                      |  2 +-
 drivers/mtd/spi/sf-uclass.c                   |  2 +-
 drivers/mtd/spi/sf_dataflash.c                |  2 +-
 drivers/mtd/spi/spi-nor-core.c                |  4 +-
 drivers/net/dwc_eth_xgmac_socfpga.c           |  2 +-
 drivers/net/dwmac_socfpga.c                   |  2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +-
 drivers/pinctrl/pinctrl_stm32.c               |  4 +-
 drivers/pinctrl/tegra/Makefile                |  2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h   |  2 +-
 drivers/power/Makefile                        |  2 +-
 drivers/power/pmic/rk8xx.c                    |  4 +-
 drivers/power/pmic/stpmic1.c                  |  6 +--
 drivers/power/power_core.c                    |  2 +-
 drivers/power/regulator/rk8xx.c               |  2 +-
 drivers/power/sy8106a.c                       |  2 +-
 drivers/ram/Makefile                          |  2 +-
 drivers/ram/mediatek/ddr3-mt7629.c            |  4 +-
 drivers/ram/rockchip/sdram_rk3188.c           | 12 ++---
 drivers/ram/rockchip/sdram_rk3288.c           | 12 ++---
 drivers/ram/rockchip/sdram_rk3399.c           |  2 +-
 drivers/ram/rockchip/sdram_rv1126.c           |  6 +--
 drivers/ram/sifive/sifive_ddr.c               |  6 +--
 drivers/ram/starfive/Makefile                 |  4 +-
 drivers/ram/stm32mp1/stm32mp1_ram.c           |  2 +-
 drivers/reset/reset-socfpga.c                 |  2 +-
 drivers/scsi/Makefile                         |  4 +-
 drivers/serial/Makefile                       |  2 +-
 drivers/serial/atmel_usart.c                  |  2 +-
 drivers/serial/ns16550.c                      |  4 +-
 drivers/serial/serial-uclass.c                |  2 +-
 drivers/serial/serial.c                       |  2 +-
 drivers/serial/serial_s5p.c                   |  2 +-
 drivers/serial/serial_zynq.c                  |  2 +-
 drivers/spi/designware_spi.c                  |  4 +-
 drivers/spi/rockchip_sfc.c                    |  2 +-
 drivers/sysreset/sysreset_ast.c               |  2 +-
 drivers/usb/cdns3/core.c                      |  6 +--
 drivers/usb/gadget/Makefile                   |  4 +-
 drivers/usb/gadget/f_sdp.c                    | 10 ++---
 drivers/usb/mtu3/mtu3_plat.c                  |  4 +-
 dts/Makefile                                  |  2 +-
 env/Makefile                                  |  2 +-
 env/common.c                                  |  4 +-
 env/fat.c                                     |  4 +-
 env/flash.c                                   |  6 +--
 env/mmc.c                                     |  6 +--
 env/nand.c                                    |  8 ++--
 env/nowhere.c                                 |  2 +-
 env/sf.c                                      |  2 +-
 fs/Makefile                                   |  2 +-
 fs/fs.c                                       |  6 +--
 include/asm-generic/global_data.h             |  2 +-
 include/bootcount.h                           |  4 +-
 include/config_distro_bootcmd.h               | 10 ++---
 include/configs/P1010RDB.h                    |  4 +-
 include/configs/am335x_evm.h                  |  4 +-
 include/configs/am335x_guardian.h             |  4 +-
 include/configs/am335x_shc.h                  |  4 +-
 include/configs/am43xx_evm.h                  |  4 +-
 include/configs/am57xx_evm.h                  |  2 +-
 include/configs/capricorn-common.h            |  4 +-
 include/configs/cgtqmx8.h                     |  2 +-
 include/configs/da850evm.h                    |  2 +-
 include/configs/dra7xx_evm.h                  |  4 +-
 include/configs/ds116.h                       |  4 +-
 include/configs/ds414.h                       |  4 +-
 .../configs/gardena-smart-gateway-mt7688.h    |  2 +-
 include/configs/imx6q-bosch-acc.h             |  2 +-
 include/configs/imx6ulz_smm_m2.h              |  4 +-
 include/configs/imx8mm-cl-iot-gate.h          |  2 +-
 include/configs/imx8mm_beacon.h               |  2 +-
 include/configs/imx8mm_data_modul_edm_sbc.h   |  2 +-
 include/configs/imx8mm_evk.h                  |  2 +-
 include/configs/imx8mm_icore_mx8mm.h          |  4 +-
 include/configs/imx8mm_phg.h                  |  2 +-
 include/configs/imx8mm_venice.h               |  2 +-
 include/configs/imx8mp_rsb3720.h              |  2 +-
 include/configs/imx8mq_cm.h                   |  2 +-
 include/configs/imx8mq_evk.h                  |  2 +-
 include/configs/imx8mq_phanbell.h             |  2 +-
 include/configs/imx8mq_reform2.h              |  2 +-
 include/configs/imx8qm_mek.h                  |  2 +-
 include/configs/imx8qxp_mek.h                 |  2 +-
 include/configs/imx8ulp_evk.h                 |  2 +-
 include/configs/imx93_evk.h                   |  2 +-
 include/configs/kontron-sl-mx8mm.h            |  4 +-
 include/configs/kontron_pitx_imx8m.h          |  2 +-
 include/configs/librem5.h                     |  2 +-
 include/configs/linkit-smart-7688.h           |  2 +-
 include/configs/ls1043a_common.h              |  6 +--
 include/configs/ls1046a_common.h              |  6 +--
 include/configs/ls1088a_common.h              |  2 +-
 include/configs/msc_sm2s_imx8mp.h             |  2 +-
 include/configs/mt7621.h                      |  2 +-
 include/configs/mt7628.h                      |  2 +-
 include/configs/n2350.h                       |  4 +-
 include/configs/p1_p2_rdb_pc.h                |  4 +-
 include/configs/phycore_imx8mm.h              |  2 +-
 include/configs/pico-imx8mq.h                 |  2 +-
 include/configs/rk3399_common.h               |  4 +-
 include/configs/rockchip-common.h             |  2 +-
 include/configs/socfpga_common.h              |  2 +-
 include/configs/stm32mp15_common.h            |  4 +-
 include/configs/stm32mp15_dh_dhsom.h          |  2 +-
 include/configs/ti_omap3_common.h             |  2 +-
 include/configs/ti_omap4_common.h             |  2 +-
 include/configs/turris_1x.h                   |  4 +-
 include/configs/turris_omnia.h                |  4 +-
 include/configs/verdin-imx8mm.h               |  2 +-
 include/configs/verdin-imx8mp.h               |  4 +-
 include/configs/vining_2000.h                 |  2 +-
 include/configs/xilinx_zynqmp.h               |  2 +-
 include/configs/zynq-common.h                 |  4 +-
 include/env.h                                 |  2 +-
 include/env_callback.h                        |  2 +-
 include/fdtdec.h                              |  2 +-
 include/image-android-dt.h                    |  2 +-
 include/iotrace.h                             |  2 +-
 include/linux/kconfig.h                       | 18 ++++----
 include/log.h                                 |  2 +-
 include/mmc.h                                 |  2 +-
 include/mtd/cfi_flash.h                       |  2 +-
 include/net.h                                 |  6 +--
 include/part.h                                |  2 +-
 include/sdp.h                                 |  2 +-
 include/search.h                              |  2 +-
 include/spl.h                                 | 14 +++---
 include/stdio.h                               |  4 +-
 include/sunxi_gpio.h                          |  2 +-
 include/upl.h                                 |  4 +-
 include/vbe.h                                 |  2 +-
 lib/Makefile                                  |  6 +--
 lib/crypto/Makefile                           |  4 +-
 lib/display_options.c                         |  2 +-
 lib/fdtdec.c                                  |  4 +-
 lib/hang.c                                    |  2 +-
 lib/hashtable.c                               |  4 +-
 lib/hexdump.c                                 |  2 +-
 lib/uuid.c                                    |  2 +-
 net/bootp.c                                   |  2 +-
 net/net.c                                     |  8 ++--
 scripts/Kbuild.include                        |  2 +-
 scripts/Makefile.xpl                          |  4 +-
 test/Makefile                                 |  2 +-
 test/cmd_ut.c                                 |  2 +-
 test/dm/Makefile                              |  2 +-
 test/lib/Makefile                             |  2 +-
 test/test-main.c                              |  2 +-
 tools/binman/test/generated/autoconf.h        |  2 +-
 791 files changed, 1391 insertions(+), 1391 deletions(-)

diff --git a/README b/README
index 4be1e8c22a0..a88e14a0449 100644
--- a/README
+++ b/README
@@ -1508,13 +1508,13 @@ Low Level (hardware related) configuration options:
 		This only takes effect if the memory commands are activated
 		globally (CONFIG_CMD_MEMORY).
 
-- CONFIG_SPL_BUILD
+- CONFIG_XPL_BUILD
 		Set when the currently running compilation is for an artifact
 		that will end up in one of the 'xPL' builds, i.e. SPL, TPL or
 		VPL. Code that needs phase-specific behaviour can check this,
 		or (where possible) use spl_phase() instead.
 
-		Note that CONFIG_SPL_BUILD *is* always defined when either
+		Note that CONFIG_XPL_BUILD *is* always defined when either
 		of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
 		counter-intuitive and should perhaps be changed.
 
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
index abdc1e40335..e720fb6b21f 100644
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
index 9ad5d46271a..ef587ef48b0 100644
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
index ad21fdb457a..fbd23af6ce9 100644
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
diff --git a/board/BuR/brppt1/Makefile b/board/BuR/brppt1/Makefile
index 3dec0e6522a..417afacad15 100644
--- a/board/BuR/brppt1/Makefile
+++ b/board/BuR/brppt1/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2013 Hannes Schmelzer <oe5hpm@oevsv.at>
 # Bernecker & Rainer Industrieelektronik GmbH - http://www.br-automation.com
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y	:= mux.o
 endif
 obj-y	+= ../common/common.o
diff --git a/board/BuR/brppt1/board.c b/board/BuR/brppt1/board.c
index 80e0ca805b5..8b7def06cc4 100644
--- a/board/BuR/brppt1/board.c
+++ b/board/BuR/brppt1/board.c
@@ -38,7 +38,7 @@ DECLARE_GLOBAL_DATA_PTR;
 /* -- defines for GPIO -- */
 #define	REPSWITCH	(0+20)	/* GPIO0_20 */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /* TODO: check ram-timing ! */
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
@@ -142,7 +142,7 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* Basic board specific setup.  Pinmux has been handled already. */
 int board_init(void)
diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c
index 105fac8912d..c0a163251b4 100644
--- a/board/BuR/brppt2/board.c
+++ b/board/BuR/brppt2/board.c
@@ -16,7 +16,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/mx6-pins.h>
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # include <asm/arch/mx6-ddr.h>
 #endif
 #include <asm/arch/clock.h>
@@ -82,7 +82,7 @@
 
 #define MUXDESC(pad, ctrl)	IOMUX_PADS(pad | MUX_PAD_CTRL(ctrl))
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static iomux_v3_cfg_t const eth_pads[] = {
 	/*
 	 * Gigabit Ethernet
@@ -542,4 +542,4 @@ void board_init_f(ulong dummy)
 void reset_cpu(void)
 {
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/BuR/brppt2/config.mk b/board/BuR/brppt2/config.mk
index 0d1638a97ac..f2362d16dc4 100644
--- a/board/BuR/brppt2/config.mk
+++ b/board/BuR/brppt2/config.mk
@@ -23,7 +23,7 @@ cmd_prodzip =					\
 	zip -9 -r $@ misc/* >/dev/null $<
 
 ifeq ($(hw-platform-y),brppt2)
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 INPUTS-y += $(hw-platform-y)_prog.bin
 INPUTS-y += $(hw-platform-y)_prod.zip
 endif
diff --git a/board/BuR/brsmarc1/Makefile b/board/BuR/brsmarc1/Makefile
index 1c3f64dea4d..42b647af58d 100644
--- a/board/BuR/brsmarc1/Makefile
+++ b/board/BuR/brsmarc1/Makefile
@@ -4,7 +4,7 @@
 # B&R Industrial Automation GmbH - http://www.br-automation.com/
 #
 
-obj-$(CONFIG_SPL_BUILD) += mux.o
+obj-$(CONFIG_XPL_BUILD) += mux.o
 obj-y	+= ../common/br_resetc.o
 obj-y	+= ../common/common.o
 obj-y	+= board.o
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index bfb6adf6d5c..c05eec6b35e 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -32,7 +32,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
 	.datawdsratio0 = MT41K256M16HA125E_WR_DQS,
@@ -124,8 +124,8 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
-#if !defined(CONFIG_SPL_BUILD)
+#endif /* CONFIG_XPL_BUILD */
+#if !defined(CONFIG_XPL_BUILD)
 
 /* decision if backlight is switched on or not on powerup */
 int board_backlightstate(void)
@@ -166,4 +166,4 @@ int board_late_init(void)
 }
 
 #endif /* CONFIG_BOARD_LATE_INIT */
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/BuR/brxre1/Makefile b/board/BuR/brxre1/Makefile
index 1d224e9e719..c4b1a67be3e 100644
--- a/board/BuR/brxre1/Makefile
+++ b/board/BuR/brxre1/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2014 Hannes Schmelzer <oe5hpm@oevsv.at> -
 # Bernecker & Rainer Industrielektronik GmbH - http://www.br-automation.com/
 
-obj-$(CONFIG_SPL_BUILD) += mux.o
+obj-$(CONFIG_XPL_BUILD) += mux.o
 obj-y	+= ../common/br_resetc.o
 obj-y	+= ../common/common.o
 obj-y	+= board.o
diff --git a/board/BuR/brxre1/board.c b/board/BuR/brxre1/board.c
index 510d2af3147..c25af42e70a 100644
--- a/board/BuR/brxre1/board.c
+++ b/board/BuR/brxre1/board.c
@@ -39,7 +39,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
 	.datawdsratio0 = MT41K256M16HA125E_WR_DQS,
@@ -134,7 +134,7 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 /*
  * Basic board specific setup.  Pinmux has been handled already.
  */
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 8aff821cfe8..7fb61736710 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -83,7 +83,7 @@ int overwrite_console(void)
 	return 1;
 }
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_AM33XX)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_AM33XX)
 #include <asm/arch/hardware.h>
 #include <asm/arch/omap.h>
 #include <asm/arch/clock.h>
@@ -175,4 +175,4 @@ void set_mux_conf_regs(void)
 	enable_board_pin_mux();
 }
 
-#endif /* CONFIG_SPL_BUILD && CONFIG_AM33XX */
+#endif /* CONFIG_XPL_BUILD && CONFIG_AM33XX */
diff --git a/board/CZ.NIC/turris_1x/Makefile b/board/CZ.NIC/turris_1x/Makefile
index a24aee9161b..1bf370122d9 100644
--- a/board/CZ.NIC/turris_1x/Makefile
+++ b/board/CZ.NIC/turris_1x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) 2022 Pali Rohár <pali@kernel.org>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= ../../freescale/p1_p2_rdb_pc/spl.o
 endif
 
diff --git a/board/CZ.NIC/turris_1x/tlb.c b/board/CZ.NIC/turris_1x/tlb.c
index f35a5558385..5e5892ee1e5 100644
--- a/board/CZ.NIC/turris_1x/tlb.c
+++ b/board/CZ.NIC/turris_1x/tlb.c
@@ -111,7 +111,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 9, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	/* **M** - SDRAM 2G */
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE,
 		      CFG_SYS_DDR_SDRAM_BASE,
diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
index d1ef5cb8600..acaa3b8ef31 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -4,4 +4,4 @@
 
 obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
 obj-$(CONFIG_CMD_EEPROM_LAYOUT)	+= eeprom.o
-obj-$(CONFIG_SPL_BUILD)		+= old_ddr3_training.o
+obj-$(CONFIG_XPL_BUILD)		+= old_ddr3_training.o
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index eb88ee7f1ed..b7588fa4eec 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -494,7 +494,7 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 	if (!eeprom)
 		return false;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
 	else
 		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));
diff --git a/board/Synology/ds414/Makefile b/board/Synology/ds414/Makefile
index b1d018effaa..1a10e9d8d54 100644
--- a/board/Synology/ds414/Makefile
+++ b/board/Synology/ds414/Makefile
@@ -3,6 +3,6 @@
 # Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
 
 obj-y	+= ds414.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y	+= cmd_syno.o
 endif
diff --git a/board/advantech/imx8mp_rsb3720a1/Makefile b/board/advantech/imx8mp_rsb3720a1/Makefile
index eb6b18b04a2..39fb0d4fb62 100644
--- a/board/advantech/imx8mp_rsb3720a1/Makefile
+++ b/board/advantech/imx8mp_rsb3720a1/Makefile
@@ -8,7 +8,7 @@
 ifdef CONFIG_TARGET_IMX8MP_RSB3720A1_6G
 obj-y += imx8mp_rsb3720a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_rsb3720a1_6G.o
 endif
@@ -17,7 +17,7 @@ endif
 ifdef CONFIG_TARGET_IMX8MP_RSB3720A1_4G
 obj-y += imx8mp_rsb3720a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_rsb3720a1_4G.o
 endif
diff --git a/board/advantech/imx8qm_dmsse20_a1/Makefile b/board/advantech/imx8qm_dmsse20_a1/Makefile
index 262ffcd6834..c82fcc85636 100644
--- a/board/advantech/imx8qm_dmsse20_a1/Makefile
+++ b/board/advantech/imx8qm_dmsse20_a1/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qm_dmsse20_a1.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/advantech/imx8qm_rom7720_a1/Makefile b/board/advantech/imx8qm_rom7720_a1/Makefile
index 51c5de251c4..d8792c6c687 100644
--- a/board/advantech/imx8qm_rom7720_a1/Makefile
+++ b/board/advantech/imx8qm_rom7720_a1/Makefile
@@ -6,6 +6,6 @@
 
 obj-y += imx8qm_rom7720_a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/alliedtelesis/x530/Makefile b/board/alliedtelesis/x530/Makefile
index 97de1d463fe..467c55d7e66 100644
--- a/board/alliedtelesis/x530/Makefile
+++ b/board/alliedtelesis/x530/Makefile
@@ -4,6 +4,6 @@
 #
 
 obj-y	:= $(BOARD).o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y	+= ../common/gpio_hog.o
 endif
diff --git a/board/asus/grouper/Makefile b/board/asus/grouper/Makefile
index d041cf80870..05c6ffb405b 100644
--- a/board/asus/grouper/Makefile
+++ b/board/asus/grouper/Makefile
@@ -6,7 +6,7 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_DM_PMIC_MAX77663) += grouper-spl-max.o
 obj-$(CONFIG_DM_PMIC_TPS65910) += grouper-spl-ti.o
 endif
diff --git a/board/asus/transformer-t30/Makefile b/board/asus/transformer-t30/Makefile
index c083f2289ba..ad700786b70 100644
--- a/board/asus/transformer-t30/Makefile
+++ b/board/asus/transformer-t30/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += transformer-t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += transformer-t30-spl.o
 
 obj-y += transformer-t30.o
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index af486e977e5..d94904366ed 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -70,7 +70,7 @@ void at91sam9m10g45ek_nand_hw_init(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index 6f9abcbb127..2cddc2175ac 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -119,7 +119,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index f52b9a97731..3f41fb1c983 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -134,7 +134,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index cb3cd7ac9ae..bf54fc33df4 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -105,7 +105,7 @@ int misc_init_r(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 15cbd0daa6f..04de1257eca 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -90,7 +90,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static void board_leds_init(void)
 {
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index 6f0d578abf7..113bd2feb62 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -79,7 +79,7 @@ int misc_init_r(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* must set PB25 low to enable the CAN transceivers */
 static void board_can_stdby_dis(void)
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index d104736fa7c..eca5b2bf107 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -105,7 +105,7 @@ int misc_init_r(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index f98322fb540..7a813c19ff2 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -117,7 +117,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #ifdef CONFIG_SD_BOOT
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index 28079a81517..555a8c0970b 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -194,7 +194,7 @@ int board_late_init(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index f9112fc5321..e296b0466aa 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -141,7 +141,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index 0bdc6adbdc8..e820605d3b9 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -127,7 +127,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/avionic-design/tec-ng/Makefile b/board/avionic-design/tec-ng/Makefile
index d6890e5797f..ec1710e137e 100644
--- a/board/avionic-design/tec-ng/Makefile
+++ b/board/avionic-design/tec-ng/Makefile
@@ -3,6 +3,6 @@
 # (C) Copyright 2013
 # Avionic Design GmbH <www.avionic-design.de>
 
-obj-$(CONFIG_SPL_BUILD) += tec-ng-spl.o
+obj-$(CONFIG_XPL_BUILD) += tec-ng-spl.o
 
 obj-y	+= ../common/tamonten-ng.o
diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
index 7d3bd3112cb..b33dc8b05b9 100644
--- a/board/beacon/imx8mm/Makefile
+++ b/board/beacon/imx8mm/Makefile
@@ -7,7 +7,7 @@
 obj-y += imx8mm_beacon.o
 obj-y += ../../freescale/common/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += lpddr4_timing.o
 endif
diff --git a/board/beacon/imx8mn/Makefile b/board/beacon/imx8mn/Makefile
index d620ccb7723..48b7b0952cc 100644
--- a/board/beacon/imx8mn/Makefile
+++ b/board/beacon/imx8mn/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_beacon.o
 obj-y += ../../freescale/common/
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MN_BEACON_2GB_LPDDR
 obj-y += lpddr4_2g_timing.o
diff --git a/board/beacon/imx8mp/Makefile b/board/beacon/imx8mp/Makefile
index 264720f6d49..7b994d2c8a1 100644
--- a/board/beacon/imx8mp/Makefile
+++ b/board/beacon/imx8mp/Makefile
@@ -7,7 +7,7 @@
 obj-y += imx8mp_beacon.o
 obj-y += ../../freescale/common/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/bitmain/antminer_s9/Makefile b/board/bitmain/antminer_s9/Makefile
index 1af01d6d808..57580f3730b 100644
--- a/board/bitmain/antminer_s9/Makefile
+++ b/board/bitmain/antminer_s9/Makefile
@@ -6,4 +6,4 @@ obj-y	+= ../../xilinx/common/board.o
 # Remove quotes
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index a1a00e7ffc4..4c7c9d38a44 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -269,7 +269,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index 1f9dc2d8df1..02f51ca2ca8 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -259,7 +259,7 @@ static void check_button_status(void)
 	}
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
@@ -473,7 +473,7 @@ int board_late_init(void)
 #endif
 
 #if defined(CONFIG_USB_ETHER) && \
-	(!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
+	(!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
 int board_eth_init(struct bd_info *bis)
 {
 	return usb_eth_initialize(bis);
diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index b761bbb2f90..59870419bdd 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -2,5 +2,5 @@
 # (C) Copyright 2021 Amarula Solutions B.V.
 
 obj-y  := imx6ulz_smm_m2.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 
diff --git a/board/bsh/imx8mn_smm_s2/Makefile b/board/bsh/imx8mn_smm_s2/Makefile
index 19d37a723ea..3050194ff89 100644
--- a/board/bsh/imx8mn_smm_s2/Makefile
+++ b/board/bsh/imx8mn_smm_s2/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_smm_s2.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_BSH_SMM_S2_DDR3L_256) += ddr3l_timing_256m.o
 obj-$(CONFIG_BSH_SMM_S2_DDR3L_512) += ddr3l_timing_512m.o
diff --git a/board/bticino/mamoj/Makefile b/board/bticino/mamoj/Makefile
index f1ddda48918..b83e667e828 100644
--- a/board/bticino/mamoj/Makefile
+++ b/board/bticino/mamoj/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y := mamoj.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/cloos/imx8mm_phg/Makefile b/board/cloos/imx8mm_phg/Makefile
index 2b36931fcf7..c3e54bfc2e0 100644
--- a/board/cloos/imx8mm_phg/Makefile
+++ b/board/cloos/imx8mm_phg/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mm_phg.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/compulab/cl-som-imx7/Makefile b/board/compulab/cl-som-imx7/Makefile
index 8f0e068b7e9..35cf2c13562 100644
--- a/board/compulab/cl-som-imx7/Makefile
+++ b/board/compulab/cl-som-imx7/Makefile
@@ -10,7 +10,7 @@
 
 obj-y := mux.o common.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  += spl.o
 else
 obj-y  += cl-som-imx7.o
diff --git a/board/compulab/cl-som-imx7/common.h b/board/compulab/cl-som-imx7/common.h
index bc19867f876..5b29763b340 100644
--- a/board/compulab/cl-som-imx7/common.h
+++ b/board/compulab/cl-som-imx7/common.h
@@ -18,7 +18,7 @@ PADS_SET_PROT(uart1_pads);
 PADS_SET_PROT(espi1_pads);
 #endif /* CONFIG_SPI */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_FSL_ESDHC_IMX
 PADS_SET_PROT(usdhc3_emmc_pads);
 #endif /* CONFIG_FSL_ESDHC_IMX */
@@ -28,4 +28,4 @@ PADS_SET_PROT(fec1_pads);
 #endif /* CONFIG_FEC_MXC */
 PADS_SET_PROT(usb_otg1_pads);
 PADS_SET_PROT(wdog_pads);
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/compulab/cl-som-imx7/mux.c b/board/compulab/cl-som-imx7/mux.c
index 25123ee145a..da8848b9f57 100644
--- a/board/compulab/cl-som-imx7/mux.c
+++ b/board/compulab/cl-som-imx7/mux.c
@@ -67,7 +67,7 @@ PADS_SET(espi1_pads)
 
 #endif /* CONFIG_SPI */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifdef CONFIG_FSL_ESDHC_IMX
 
@@ -138,4 +138,4 @@ static iomux_v3_cfg_t const wdog_pads[] = {
 
 PADS_SET(wdog_pads)
 
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/compulab/cm_fx6/Makefile b/board/compulab/cm_fx6/Makefile
index e648db26a1d..e9f86cb8410 100644
--- a/board/compulab/cm_fx6/Makefile
+++ b/board/compulab/cm_fx6/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2014 CompuLab, Ltd. <www.compulab.co.il>
 #
 # Authors: Nikita Kiryanov <nikita@compulab.co.il>
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y = common.o spl.o
 else
 obj-y = common.o cm_fx6.o
diff --git a/board/compulab/cm_t43/Makefile b/board/compulab/cm_t43/Makefile
index 6fa231a045e..221d1b432fd 100644
--- a/board/compulab/cm_t43/Makefile
+++ b/board/compulab/cm_t43/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2015 Compulab, Ltd.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o mux.o
 else
 obj-y	+= cm_t43.o mux.o
diff --git a/board/compulab/imx8mm-cl-iot-gate/Makefile b/board/compulab/imx8mm-cl-iot-gate/Makefile
index 3800b21a6fd..7c2d6e508b3 100644
--- a/board/compulab/imx8mm-cl-iot-gate/Makefile
+++ b/board/compulab/imx8mm-cl-iot-gate/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += imx8mm-cl-iot-gate.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o eeprom_spl.o
 obj-y += ddr/
 endif
diff --git a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
index 1256848f9a9..a22e6ef1d96 100644
--- a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
@@ -10,7 +10,7 @@
 #include <asm/setup.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define CFG_SYS_I2C_EEPROM_ADDR_P1	0x51
 
diff --git a/board/comvetia/lxr2/lxr2.c b/board/comvetia/lxr2/lxr2.c
index 173263522bd..dc7fc202049 100644
--- a/board/comvetia/lxr2/lxr2.c
+++ b/board/comvetia/lxr2/lxr2.c
@@ -138,7 +138,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 #define MX6_PHYFLEX_ERR006282	IMX_GPIO_NR(2, 11)
diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
index 37750137ad9..15dba146eb8 100644
--- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -141,7 +141,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/congatec/cgtqmx8/Makefile b/board/congatec/cgtqmx8/Makefile
index 4b59dbb6bc7..2a02cec4f15 100644
--- a/board/congatec/cgtqmx8/Makefile
+++ b/board/congatec/cgtqmx8/Makefile
@@ -6,6 +6,6 @@
 
 obj-y += cgtqmx8.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/congatec/common/Makefile b/board/congatec/common/Makefile
index 2db0fc1ae5c..f8170d9c653 100644
--- a/board/congatec/common/Makefile
+++ b/board/congatec/common/Makefile
@@ -7,7 +7,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index b4d74a8fd8b..b5f83908771 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -72,7 +72,7 @@ int board_phys_sdram_size(phys_size_t *size)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void data_modul_imx_edm_sbc_early_init_f(const iomux_v3_cfg_t wdog_pad)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
diff --git a/board/data_modul/imx8mm_edm_sbc/Makefile b/board/data_modul/imx8mm_edm_sbc/Makefile
index 6d72e930fca..3d8fedf74d4 100644
--- a/board/data_modul/imx8mm_edm_sbc/Makefile
+++ b/board/data_modul/imx8mm_edm_sbc/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_2G_32.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mm_data_modul_edm_sbc.o
diff --git a/board/data_modul/imx8mp_edm_sbc/Makefile b/board/data_modul/imx8mp_edm_sbc/Makefile
index 28c1d62f2bb..7e1fe855799 100644
--- a/board/data_modul/imx8mp_edm_sbc/Makefile
+++ b/board/data_modul/imx8mp_edm_sbc/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mp_data_modul_edm_sbc.o
diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 03c34455c50..dc42a4a7b53 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -311,7 +311,7 @@ int board_mmc_init(struct bd_info *bis)
 #endif
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const struct ns16550_plat serial_pdata = {
 	.base = DAVINCI_UART2_BASE,
 	.reg_shift = 2,
diff --git a/board/dhelectronics/dh_imx6/Makefile b/board/dhelectronics/dh_imx6/Makefile
index 70ca30d3971..7102a47450e 100644
--- a/board/dhelectronics/dh_imx6/Makefile
+++ b/board/dhelectronics/dh_imx6/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2017 Marek Vasut <marex@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= dh_imx6_spl.o
 else
 obj-y	:= dh_imx6.o
diff --git a/board/dhelectronics/dh_imx8mp/Makefile b/board/dhelectronics/dh_imx8mp/Makefile
index e5a29fdd122..7bc8dc21e64 100644
--- a/board/dhelectronics/dh_imx8mp/Makefile
+++ b/board/dhelectronics/dh_imx8mp/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_2G_32.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mp_dhcom_pdk2.o
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 4f4f537fee5..073f32d1380 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -260,13 +260,13 @@ int board_stm32mp1_ddr_config_name_match(struct udevice *dev,
 
 void board_vddcore_init(u32 voltage_mv)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		opp_voltage_mv = voltage_mv;
 }
 
 int board_early_init_f(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		stpmic1_init(opp_voltage_mv);
 	board_get_coding_straps();
 
@@ -767,7 +767,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	dh_stm32_ks8851_fixup(spl_image_fdt_addr(spl_image));
diff --git a/board/ea/mx7ulp_com/mx7ulp_com.c b/board/ea/mx7ulp_com/mx7ulp_com.c
index 8f78937e097..d3a65fd820b 100644
--- a/board/ea/mx7ulp_com/mx7ulp_com.c
+++ b/board/ea/mx7ulp_com/mx7ulp_com.c
@@ -52,7 +52,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 #ifdef CONFIG_SPL_LOAD_FIT
diff --git a/board/eets/pdu001/board.c b/board/eets/pdu001/board.c
index 00f9a5ef341..16af687d9cc 100644
--- a/board/eets/pdu001/board.c
+++ b/board/eets/pdu001/board.c
@@ -65,7 +65,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CFG_SYS_RTC_SCRATCH0 0x60
 #define BOOT_DEVICE_SAVE_REGISTER (RTC_BASE + CFG_SYS_RTC_SCRATCH0)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void save_boot_device(void)
 {
 	*((u32 *)(BOOT_DEVICE_SAVE_REGISTER)) = spl_boot_device();
diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index cf3368c253b..5ed41d01d9b 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -394,7 +394,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 void board_init_f(ulong dummy)
diff --git a/board/engicam/common/Makefile b/board/engicam/common/Makefile
index 15f0eaa1ec4..dc8be383c23 100644
--- a/board/engicam/common/Makefile
+++ b/board/engicam/common/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2016 Amarula Solutions B.V.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX6_ENGICAM_COMMON) += spl.o
 else
 obj-$(CONFIG_IMX6_ENGICAM_COMMON) += board.o
diff --git a/board/engicam/imx8mm/Makefile b/board/engicam/imx8mm/Makefile
index 3392d61920a..d6ad299f830 100644
--- a/board/engicam/imx8mm/Makefile
+++ b/board/engicam/imx8mm/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += icore_mx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += lpddr4_timing.o
 endif
diff --git a/board/engicam/imx8mp/Makefile b/board/engicam/imx8mp/Makefile
index c3ec09d6e38..f21a31b8078 100644
--- a/board/engicam/imx8mp/Makefile
+++ b/board/engicam/imx8mp/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += icore_mx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/engicam/stm32mp1/Makefile b/board/engicam/stm32mp1/Makefile
index 155d33f9eec..9ac78e4d1aa 100644
--- a/board/engicam/stm32mp1/Makefile
+++ b/board/engicam/stm32mp1/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += stm32mp1.o
diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
index 8e67ab4b132..c65ce5890e5 100644
--- a/board/firefly/firefly-rk3288/firefly-rk3288.c
+++ b/board/firefly/firefly-rk3288/firefly-rk3288.c
@@ -9,7 +9,7 @@
 #include <asm/global_data.h>
 #include <dm/ofnode.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int setup_led(void)
 {
 #ifdef CONFIG_SPL_LED
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index a149e4fe822..6937a27176f 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -13,7 +13,7 @@
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define PMUGRF_BASE	0xff320000
 #define GPIO0_BASE	0xff720000
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index b4faf6f9e0a..c491dc8b241 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -5,7 +5,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -29,14 +29,14 @@ endif
 obj-$(CONFIG_FSL_CADMUS)	+= cadmus.o
 obj-$(CONFIG_FSL_VIA)		+= cds_via.o
 obj-$(CONFIG_FMAN_ENET)	+= fman.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
 endif
 obj-$(I2C_COMMON)		+= i2c_common.o
 obj-$(CONFIG_FSL_USE_PCA9547_MUX)		+= i2c_mux.o
 obj-$(CONFIG_$(SPL_)VID)	+= vid.o
 obj-$(CONFIG_FSL_QIXIS)	+= qixis.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ID_EEPROM)	+= sys_eeprom.o
 endif
 ifndef CONFIG_RAMBOOT_PBL
diff --git a/board/freescale/common/cmd_esbc_validate.c b/board/freescale/common/cmd_esbc_validate.c
index 3344653ba2d..7629d7091e9 100644
--- a/board/freescale/common/cmd_esbc_validate.c
+++ b/board/freescale/common/cmd_esbc_validate.c
@@ -23,7 +23,7 @@ loop:
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_esbc_validate(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
diff --git a/board/freescale/common/fsl_chain_of_trust.c b/board/freescale/common/fsl_chain_of_trust.c
index 27a33924c84..194a0907e72 100644
--- a/board/freescale/common/fsl_chain_of_trust.c
+++ b/board/freescale/common/fsl_chain_of_trust.c
@@ -15,7 +15,7 @@
 #include <dm/root.h>
 #include <asm/fsl_secure_boot.h>
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
 #include <spl.h>
 #endif
 
@@ -67,7 +67,7 @@ int fsl_check_boot_mode_secure(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int fsl_setenv_chain_of_trust(void)
 {
 	/* Check Boot Mode
@@ -92,7 +92,7 @@ int fsl_setenv_chain_of_trust(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_validate_uboot(uint32_t hdr_addr, uintptr_t img_addr)
 {
 	int res;
@@ -157,4 +157,4 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 	image_entry();
 }
 #endif /* ifdef CONFIG_SPL_FRAMEWORK */
-#endif /* ifdef CONFIG_SPL_BUILD */
+#endif /* ifdef CONFIG_XPL_BUILD */
diff --git a/board/freescale/common/fsl_validate.c b/board/freescale/common/fsl_validate.c
index 657f4533bcd..df0c1a1f406 100644
--- a/board/freescale/common/fsl_validate.c
+++ b/board/freescale/common/fsl_validate.c
@@ -396,7 +396,7 @@ static void fsl_secboot_bootscript_parse_failure(void)
  */
 void fsl_secboot_handle_error(int error)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	const struct fsl_secboot_errcode *e;
 
 	for (e = fsl_secboot_errcodes; e->errcode != ERROR_ESBC_CLIENT_MAX;
@@ -807,7 +807,7 @@ static int calculate_cmp_img_sig(struct fsl_secboot_img_priv *img)
 	prop.num_bits = key_len * 8;
 	prop.exp_len = key_len;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	ret = device_bind_driver(NULL, "fsl_rsa_mod_exp", "fsl_rsa_mod_exp", NULL);
 	if (ret) {
 		printf("Couldn't bind fsl_rsa_mod_exp driver (%d)\n", ret);
diff --git a/board/freescale/common/qixis.c b/board/freescale/common/qixis.c
index 6400ac05245..7815ba2dbce 100644
--- a/board/freescale/common/qixis.c
+++ b/board/freescale/common/qixis.c
@@ -161,7 +161,7 @@ void board_deassert_mem_reset(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static void qixis_reset(void)
 {
 	QIXIS_WRITE(rst_ctl, QIXIS_RST_CTL_RESET);
diff --git a/board/freescale/imx8mm_evk/Makefile b/board/freescale/imx8mm_evk/Makefile
index 1db7b62cafc..9fecd8dd8cb 100644
--- a/board/freescale/imx8mm_evk/Makefile
+++ b/board/freescale/imx8mm_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mm_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/freescale/imx8mn_evk/Makefile b/board/freescale/imx8mn_evk/Makefile
index 42d1179724d..5ef666a36dd 100644
--- a/board/freescale/imx8mn_evk/Makefile
+++ b/board/freescale/imx8mn_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MN_LOW_DRIVE_MODE
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_ld.o
diff --git a/board/freescale/imx8mp_evk/Makefile b/board/freescale/imx8mp_evk/Makefile
index 106bf9a1edf..3c154d7f7f5 100644
--- a/board/freescale/imx8mp_evk/Makefile
+++ b/board/freescale/imx8mp_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mp_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/freescale/imx8mq_evk/Makefile b/board/freescale/imx8mq_evk/Makefile
index cf046963d25..ca449e6f369 100644
--- a/board/freescale/imx8mq_evk/Makefile
+++ b/board/freescale/imx8mq_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o lpddr4_timing_b0.o
 endif
diff --git a/board/freescale/imx8qm_mek/Makefile b/board/freescale/imx8qm_mek/Makefile
index bc9a1260bde..53b33a0dfb1 100644
--- a/board/freescale/imx8qm_mek/Makefile
+++ b/board/freescale/imx8qm_mek/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qm_mek.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/freescale/imx8qxp_mek/Makefile b/board/freescale/imx8qxp_mek/Makefile
index acaadcd84a4..459ec771eea 100644
--- a/board/freescale/imx8qxp_mek/Makefile
+++ b/board/freescale/imx8qxp_mek/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qxp_mek.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/freescale/imx8ulp_evk/Makefile b/board/freescale/imx8ulp_evk/Makefile
index 1cf148ab910..7819b2675b3 100644
--- a/board/freescale/imx8ulp_evk/Makefile
+++ b/board/freescale/imx8ulp_evk/Makefile
@@ -2,7 +2,7 @@
 
 obj-y   += imx8ulp_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8ULP_ND_MODE
 obj-y += lpddr4_timing_264.o
diff --git a/board/freescale/imx93_evk/Makefile b/board/freescale/imx93_evk/Makefile
index ede8d20ff5c..b077acc70a5 100644
--- a/board/freescale/imx93_evk/Makefile
+++ b/board/freescale/imx93_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx93_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
 endif
diff --git a/board/freescale/imxrt1020-evk/imxrt1020-evk.c b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
index 42a0a67ae93..11dbef84688 100644
--- a/board/freescale/imxrt1020-evk/imxrt1020-evk.c
+++ b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
index 46a644908e9..056489932ac 100644
--- a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
+++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/imxrt1170-evk/imxrt1170-evk.c b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
index e10b8830ec6..047aea8181a 100644
--- a/board/freescale/imxrt1170-evk/imxrt1170-evk.c
+++ b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/ls1012afrdm/ls1012afrdm.c b/board/freescale/ls1012afrdm/ls1012afrdm.c
index dae2cf097bc..f157e75e385 100644
--- a/board/freescale/ls1012afrdm/ls1012afrdm.c
+++ b/board/freescale/ls1012afrdm/ls1012afrdm.c
@@ -140,7 +140,7 @@ int dram_init(void)
 #endif
 	mmdc_init(&mparam);
 
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1012aqds/ls1012aqds.c b/board/freescale/ls1012aqds/ls1012aqds.c
index 7d56eb0117d..b21c4d917d0 100644
--- a/board/freescale/ls1012aqds/ls1012aqds.c
+++ b/board/freescale/ls1012aqds/ls1012aqds.c
@@ -88,7 +88,7 @@ int dram_init(void)
 
 	mmdc_init(&mparam);
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/freescale/ls1012ardb/ls1012ardb.c
index 5f0564f1b23..ab69eab8408 100644
--- a/board/freescale/ls1012ardb/ls1012ardb.c
+++ b/board/freescale/ls1012ardb/ls1012ardb.c
@@ -138,7 +138,7 @@ int dram_init(void)
 #endif
 
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index 2fdac87bc29..4eff0a3fee0 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -99,7 +99,7 @@ void ddrmc_init(void)
 
 int dram_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	ddrmc_init();
 #endif
 
@@ -125,7 +125,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	/* Clear the BSS */
diff --git a/board/freescale/ls1021aqds/ddr.c b/board/freescale/ls1021aqds/ddr.c
index 5b0f23688f0..fd897e832c8 100644
--- a/board/freescale/ls1021aqds/ddr.c
+++ b/board/freescale/ls1021aqds/ddr.c
@@ -172,14 +172,14 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initializing DDR....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
 	dram_size =  fsl_ddr_sdram_size();
 #endif
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/ls1021aqds/ls1021aqds.c b/board/freescale/ls1021aqds/ls1021aqds.c
index 930ef6be385..0bdd468d9a7 100644
--- a/board/freescale/ls1021aqds/ls1021aqds.c
+++ b/board/freescale/ls1021aqds/ls1021aqds.c
@@ -181,7 +181,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 #ifdef CONFIG_NAND_BOOT
diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index b7e043b2e62..d1acccec110 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -27,7 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static void ddrmc_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	struct ccsr_ddr *ddr = (struct ccsr_ddr *)CFG_SYS_FSL_DDR_ADDR;
 	u32 temp_sdram_cfg, tmp;
 
@@ -105,7 +105,7 @@ static void ddrmc_init(void)
 		out_be32(&ddr->sdram_cfg_2, temp_sdram_cfg);
 	}
 #endif
-#endif /* !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD) */
+#endif /* !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD) */
 }
 
 int dram_init(void)
@@ -116,7 +116,7 @@ int dram_init(void)
 
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
@@ -156,7 +156,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	void (*second_uboot)(void);
@@ -214,7 +214,7 @@ int board_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
 	ls102xa_smmu_stream_id_init();
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index 78006afce86..cc9665c0410 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -224,7 +224,7 @@ void ddrmc_init(void)
 
 int dram_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	ddrmc_init();
 #endif
 
@@ -232,7 +232,7 @@ int dram_init(void)
 
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
@@ -407,7 +407,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	void (*second_uboot)(void);
@@ -527,7 +527,7 @@ int board_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
@@ -607,7 +607,7 @@ u16 flash_read16(void *addr)
 }
 
 #if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_SD_BOOT_QSPI) \
-	&& !defined(CONFIG_SPL_BUILD)
+	&& !defined(CONFIG_XPL_BUILD)
 static void convert_flash_bank(char bank)
 {
 	struct cpld_data *cpld_data = (void *)(CFG_SYS_CPLD_BASE);
diff --git a/board/freescale/ls1028a/ls1028a.c b/board/freescale/ls1028a/ls1028a.c
index e01b5a8c2eb..db94d9c1fa8 100644
--- a/board/freescale/ls1028a/ls1028a.c
+++ b/board/freescale/ls1028a/ls1028a.c
@@ -123,7 +123,7 @@ int board_early_init_f(void)
 	u8 uart;
 #endif
 
-#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_XPL_BUILD)
 	i2c_early_init_f();
 #endif
 
diff --git a/board/freescale/ls1043aqds/Makefile b/board/freescale/ls1043aqds/Makefile
index 49d8d7d9b96..ff830788fd7 100644
--- a/board/freescale/ls1043aqds/Makefile
+++ b/board/freescale/ls1043aqds/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += eth.o
 endif
 obj-y += ls1043aqds.o
diff --git a/board/freescale/ls1043aqds/ddr.c b/board/freescale/ls1043aqds/ddr.c
index 2a9717df616..137ad7395ad 100644
--- a/board/freescale/ls1043aqds/ddr.c
+++ b/board/freescale/ls1043aqds/ddr.c
@@ -123,7 +123,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1043aqds/ls1043aqds.c b/board/freescale/ls1043aqds/ls1043aqds.c
index 2ecf5a74a03..f043599fbb8 100644
--- a/board/freescale/ls1043aqds/ls1043aqds.c
+++ b/board/freescale/ls1043aqds/ls1043aqds.c
@@ -288,7 +288,7 @@ int dram_init(void)
 	select_i2c_ch_pca9547(I2C_MUX_CH_DEFAULT, 0);
 	fsl_initdram();
 #if (!defined(CONFIG_SPL) && !defined(CONFIG_TFABOOT)) || \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1043ardb/Makefile b/board/freescale/ls1043ardb/Makefile
index 5309576c688..95745bf3a9c 100644
--- a/board/freescale/ls1043ardb/Makefile
+++ b/board/freescale/ls1043ardb/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ddr.o
 obj-y += ls1043ardb.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_NET) += eth.o
 obj-y += cpld.o
 endif
diff --git a/board/freescale/ls1043ardb/ddr.c b/board/freescale/ls1043ardb/ddr.c
index 187925e981a..231b60d1b3d 100644
--- a/board/freescale/ls1043ardb/ddr.c
+++ b/board/freescale/ls1043ardb/ddr.c
@@ -225,14 +225,14 @@ int fsl_initdram(void)
 	phys_size_t dram_size;
 
 #ifdef CONFIG_SYS_DDR_RAW_TIMING
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initializing DDR....\n");
 	dram_size = fsl_ddr_sdram();
 #else
 	dram_size =  fsl_ddr_sdram_size();
 #endif
 #else
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initialzing DDR using fixed setting\n");
 	dram_size = fixed_sdram();
 #else
diff --git a/board/freescale/ls1043ardb/ls1043ardb.c b/board/freescale/ls1043ardb/ls1043ardb.c
index cf84ff9e638..bba041065b5 100644
--- a/board/freescale/ls1043ardb/ls1043ardb.c
+++ b/board/freescale/ls1043ardb/ls1043ardb.c
@@ -132,7 +132,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 int checkboard(void)
 {
diff --git a/board/freescale/ls1046aqds/Makefile b/board/freescale/ls1046aqds/Makefile
index 6267522cc26..365247d92bc 100644
--- a/board/freescale/ls1046aqds/Makefile
+++ b/board/freescale/ls1046aqds/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += eth.o
 endif
 obj-y += ls1046aqds.o
diff --git a/board/freescale/ls1046aqds/ddr.c b/board/freescale/ls1046aqds/ddr.c
index ac1b6049721..57790335f0a 100644
--- a/board/freescale/ls1046aqds/ddr.c
+++ b/board/freescale/ls1046aqds/ddr.c
@@ -107,7 +107,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1046aqds/ls1046aqds.c b/board/freescale/ls1046aqds/ls1046aqds.c
index a83b2170651..7df12550868 100644
--- a/board/freescale/ls1046aqds/ls1046aqds.c
+++ b/board/freescale/ls1046aqds/ls1046aqds.c
@@ -284,7 +284,7 @@ int dram_init(void)
 	select_i2c_ch_pca9547(I2C_MUX_CH_DEFAULT, 0);
 	fsl_initdram();
 #if (!defined(CONFIG_SPL) && !defined(CONFIG_TFABOOT)) || \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1046ardb/Makefile b/board/freescale/ls1046ardb/Makefile
index 1c13ed6b6f0..9e5d24f53c8 100644
--- a/board/freescale/ls1046ardb/Makefile
+++ b/board/freescale/ls1046ardb/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ddr.o
 obj-y += ls1046ardb.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_NET) += eth.o
 obj-y += cpld.o
 endif
diff --git a/board/freescale/ls1046ardb/ddr.c b/board/freescale/ls1046ardb/ddr.c
index 68353022e7d..4170666c420 100644
--- a/board/freescale/ls1046ardb/ddr.c
+++ b/board/freescale/ls1046ardb/ddr.c
@@ -113,7 +113,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1046ardb/ls1046ardb.c b/board/freescale/ls1046ardb/ls1046ardb.c
index 0492f0a8c0a..83b280f7646 100644
--- a/board/freescale/ls1046ardb/ls1046ardb.c
+++ b/board/freescale/ls1046ardb/ls1046ardb.c
@@ -44,7 +44,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int checkboard(void)
 {
 	static const char *freq[2] = {"100.00MHZ", "156.25MHZ"};
diff --git a/board/freescale/ls1088a/Makefile b/board/freescale/ls1088a/Makefile
index c2b0e7dc0f4..e54d6cad9e1 100644
--- a/board/freescale/ls1088a/Makefile
+++ b/board/freescale/ls1088a/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ls1088a.o
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_TARGET_LS1088ARDB) += eth_ls1088ardb.o
 obj-$(CONFIG_TARGET_LS1088AQDS) += eth_ls1088aqds.o
 endif
diff --git a/board/freescale/ls1088a/ddr.c b/board/freescale/ls1088a/ddr.c
index 54b432ad794..cd590af9534 100644
--- a/board/freescale/ls1088a/ddr.c
+++ b/board/freescale/ls1088a/ddr.c
@@ -13,7 +13,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 static void fsl_ddr_setup_0v9_volt(memctl_options_t *popts)
 {
 	int vdd;
@@ -101,7 +101,7 @@ found:
 	popts->addr_hash = 1;
 
 	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_60ohm);
-#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	fsl_ddr_setup_0v9_volt(popts);
 #endif
 
@@ -124,7 +124,7 @@ int fsl_initdram(void)
 {
 	puts("Initializing DDR....using SPD\n");
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	gd->ram_size = fsl_ddr_sdram();
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 58951f2bb2a..9f4eb4811d9 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -248,7 +248,7 @@ int fixup_ls1088ardb_pb_banner(void *fdt)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 int checkboard(void)
 {
 #ifdef CONFIG_TFABOOT
@@ -421,7 +421,7 @@ unsigned long get_board_ddr_clk(void)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 void board_retimer_init(void)
 {
 	u8 reg;
@@ -804,7 +804,7 @@ exit:
 	return ret;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 int board_init(void)
 {
 	init_final_memctl_regs();
@@ -995,7 +995,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-#endif /* defined(CONFIG_SPL_BUILD) */
+#endif /* defined(CONFIG_XPL_BUILD) */
 
 #ifdef CONFIG_TFABOOT
 #ifdef CONFIG_MTD_NOR_FLASH
diff --git a/board/freescale/ls2080aqds/ddr.c b/board/freescale/ls2080aqds/ddr.c
index d19c061e122..31ed72c949b 100644
--- a/board/freescale/ls2080aqds/ddr.c
+++ b/board/freescale/ls2080aqds/ddr.c
@@ -168,7 +168,7 @@ int fsl_initdram(void)
 #else
 int fsl_initdram(void)
 {
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	puts("Initializing DDR....using SPD\n");
diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index 4c8d0706688..aba0560181a 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -264,7 +264,7 @@ void detail_board_ddr_info(void)
 #endif
 }
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 void fdt_fixup_board_enet(void *fdt)
 {
 	int offset;
@@ -323,7 +323,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fsl_fdt_fixup_dr_usb(blob, bd);
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 	fdt_fixup_board_enet(blob);
 	fdt_reserve_mc_mem(blob, 0x300);
 #endif
diff --git a/board/freescale/ls2080ardb/ddr.c b/board/freescale/ls2080ardb/ddr.c
index a1a97f9f8c2..e56667c846f 100644
--- a/board/freescale/ls2080ardb/ddr.c
+++ b/board/freescale/ls2080ardb/ddr.c
@@ -173,7 +173,7 @@ int fsl_initdram(void)
 #else
 int fsl_initdram(void)
 {
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	puts("Initializing DDR....using SPD\n");
diff --git a/board/freescale/ls2080ardb/eth_ls2080rdb.c b/board/freescale/ls2080ardb/eth_ls2080rdb.c
index 7fc4fecf774..7d5beb32417 100644
--- a/board/freescale/ls2080ardb/eth_ls2080rdb.c
+++ b/board/freescale/ls2080ardb/eth_ls2080rdb.c
@@ -12,7 +12,7 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_eth_init(struct bd_info *bis)
 {
 
-#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_XPL_BUILD)
 	/*
 	 * Export functions to be used by AQ firmware
 	 * upload application
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/lx2160a.c
index 3aa984dab8e..341f82ce724 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -58,7 +58,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int board_early_init_f(void)
 {
-#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_XPL_BUILD)
 	i2c_early_init_f();
 #endif
 
diff --git a/board/freescale/mx23evk/Makefile b/board/freescale/mx23evk/Makefile
index 6fe6992a5fc..5cc99ab1836 100644
--- a/board/freescale/mx23evk/Makefile
+++ b/board/freescale/mx23evk/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx23evk.o
 else
 obj-y	:= spl_boot.o
diff --git a/board/freescale/mx28evk/Makefile b/board/freescale/mx28evk/Makefile
index 057760433da..1fd2a439f7a 100644
--- a/board/freescale/mx28evk/Makefile
+++ b/board/freescale/mx28evk/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx28evk.o
 else
 obj-y	:= iomux.o
diff --git a/board/freescale/mx6memcal/Makefile b/board/freescale/mx6memcal/Makefile
index fc2d3eb9e10..b4088b9f2ec 100644
--- a/board/freescale/mx6memcal/Makefile
+++ b/board/freescale/mx6memcal/Makefile
@@ -4,7 +4,7 @@
 #
 # (C) Copyright 2011 Freescale Semiconductor, Inc.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= spl.o
 else
 obj-y	:= mx6memcal.o
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/freescale/mx6sabreauto/mx6sabreauto.c
index bab62fd4421..8ca57e0b2ac 100644
--- a/board/freescale/mx6sabreauto/mx6sabreauto.c
+++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
@@ -545,7 +545,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx6sabresd/mx6sabresd.c
index bb066a5d36c..dff3a9c33bf 100644
--- a/board/freescale/mx6sabresd/mx6sabresd.c
+++ b/board/freescale/mx6sabresd/mx6sabresd.c
@@ -507,7 +507,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/board/freescale/mx6slevk/mx6slevk.c b/board/freescale/mx6slevk/mx6slevk.c
index d37d8a4136f..fb145fa6aac 100644
--- a/board/freescale/mx6slevk/mx6slevk.c
+++ b/board/freescale/mx6slevk/mx6slevk.c
@@ -61,7 +61,7 @@ static iomux_v3_cfg_t const uart1_pads[] = {
 	MX6_PAD_UART1_RXD__UART1_RXD | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static iomux_v3_cfg_t const usdhc1_pads[] = {
 	/* 8 bit SD */
 	MX6_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -195,7 +195,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 
diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
index e5a0197e2fd..c4ab59da78c 100644
--- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
+++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
@@ -123,7 +123,7 @@ static int board_qspi_init(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define USDHC_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
 	PAD_CTL_PUS_22K_UP  | PAD_CTL_SPEED_LOW |		\
@@ -346,7 +346,7 @@ void board_preboot_os(void)
 	gpio_set_value(IMX_GPIO_NR(5, 9), 0);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/freescale/p1010rdb/Makefile b/board/freescale/p1010rdb/Makefile
index a00806e6aae..df4e8001d38 100644
--- a/board/freescale/p1010rdb/Makefile
+++ b/board/freescale/p1010rdb/Makefile
@@ -4,7 +4,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -15,7 +15,7 @@ endif
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 endif
 obj-y	+= p1010rdb.o
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/freescale/p1010rdb/p1010rdb.c
index e386840d9ef..9b4b6f34f46 100644
--- a/board/freescale/p1010rdb/p1010rdb.c
+++ b/board/freescale/p1010rdb/p1010rdb.c
@@ -656,7 +656,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pin_mux_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
diff --git a/board/freescale/p1010rdb/tlb.c b/board/freescale/p1010rdb/tlb.c
index 44acebaa2bb..aa130ccf78b 100644
--- a/board/freescale/p1010rdb/tlb.c
+++ b/board/freescale/p1010rdb/tlb.c
@@ -41,7 +41,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 			MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 			0, 1, BOOKE_PAGESZ_1M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
 			MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 			0, 2, BOOKE_PAGESZ_16M, 1),
diff --git a/board/freescale/p1_p2_rdb_pc/Makefile b/board/freescale/p1_p2_rdb_pc/Makefile
index cbdb2507e83..8c13813e3b0 100644
--- a/board/freescale/p1_p2_rdb_pc/Makefile
+++ b/board/freescale/p1_p2_rdb_pc/Makefile
@@ -4,7 +4,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -15,7 +15,7 @@ endif
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 endif
 obj-y	+= p1_p2_rdb_pc.o
diff --git a/board/freescale/p1_p2_rdb_pc/tlb.c b/board/freescale/p1_p2_rdb_pc/tlb.c
index ae0b7adbe54..f27821418eb 100644
--- a/board/freescale/p1_p2_rdb_pc/tlb.c
+++ b/board/freescale/p1_p2_rdb_pc/tlb.c
@@ -37,7 +37,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 			MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 			0, 1, BOOKE_PAGESZ_1M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* W**G* - Flash/promjet, localbus */
 	/* This will be changed to *I*G* after relocation to RAM. */
 	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
diff --git a/board/freescale/t102xrdb/Makefile b/board/freescale/t102xrdb/Makefile
index e597486c940..b0f27c47191 100644
--- a/board/freescale/t102xrdb/Makefile
+++ b/board/freescale/t102xrdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-y   += t102xrdb.o
diff --git a/board/freescale/t102xrdb/ddr.c b/board/freescale/t102xrdb/ddr.c
index f8d504fb3c7..1a8a131cdcc 100644
--- a/board/freescale/t102xrdb/ddr.c
+++ b/board/freescale/t102xrdb/ddr.c
@@ -236,7 +236,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 #ifndef CONFIG_SYS_DDR_RAW_TIMING
 	puts("Initializing....using SPD\n");
 #endif
@@ -248,7 +248,7 @@ int dram_init(void)
 	dram_size = setup_ddr_tlbs(dram_size / 0x100000);
 	dram_size *= 0x100000;
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/t102xrdb/tlb.c b/board/freescale/t102xrdb/tlb.c
index 008bd6e72b7..8e99c2c7022 100644
--- a/board/freescale/t102xrdb/tlb.c
+++ b/board/freescale/t102xrdb/tlb.c
@@ -53,7 +53,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -100,7 +100,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 11, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 12, BOOKE_PAGESZ_1G, 1),
diff --git a/board/freescale/t104xrdb/Makefile b/board/freescale/t104xrdb/Makefile
index a9495019430..9bca1a1fbcc 100644
--- a/board/freescale/t104xrdb/Makefile
+++ b/board/freescale/t104xrdb/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright 2013 Freescale Semiconductor, Inc.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y	+= t104xrdb.o
diff --git a/board/freescale/t104xrdb/ddr.c b/board/freescale/t104xrdb/ddr.c
index bab684860da..6c066480b46 100644
--- a/board/freescale/t104xrdb/ddr.c
+++ b/board/freescale/t104xrdb/ddr.c
@@ -129,7 +129,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
@@ -138,7 +138,7 @@ int dram_init(void)
 	dram_size = setup_ddr_tlbs(dram_size / 0x100000);
 	dram_size *= 0x100000;
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/t104xrdb/tlb.c b/board/freescale/t104xrdb/tlb.c
index 24bc83f756b..7b2183da8b0 100644
--- a/board/freescale/t104xrdb/tlb.c
+++ b/board/freescale/t104xrdb/tlb.c
@@ -38,7 +38,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 0, BOOKE_PAGESZ_256K, 1),
 
-#elif defined(CONFIG_NXP_ESBC) && defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_NXP_ESBC) && defined(CONFIG_XPL_BUILD)
 	/*
 	 * *I*G - L3SRAM. When L3 is used as 256K SRAM, in case of Secure Boot
 	 * the physical address of the SRAM is at 0xbffc0000,
@@ -66,7 +66,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -118,7 +118,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 11, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 12, BOOKE_PAGESZ_1G, 1),
diff --git a/board/freescale/t208xqds/Makefile b/board/freescale/t208xqds/Makefile
index de8613058de..eb99d921b4a 100644
--- a/board/freescale/t208xqds/Makefile
+++ b/board/freescale/t208xqds/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-$(CONFIG_TARGET_T2080QDS) += t208xqds.o eth_t208xqds.o
diff --git a/board/freescale/t208xqds/ddr.c b/board/freescale/t208xqds/ddr.c
index 9076fbba10a..77c8ce0c870 100644
--- a/board/freescale/t208xqds/ddr.c
+++ b/board/freescale/t208xqds/ddr.c
@@ -109,7 +109,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
diff --git a/board/freescale/t208xqds/tlb.c b/board/freescale/t208xqds/tlb.c
index a4cc532acda..08c140afc68 100644
--- a/board/freescale/t208xqds/tlb.c
+++ b/board/freescale/t208xqds/tlb.c
@@ -65,7 +65,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCIe 1, 0x80000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -142,7 +142,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 18, BOOKE_PAGESZ_1M, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 19, BOOKE_PAGESZ_2G, 1)
diff --git a/board/freescale/t208xrdb/Makefile b/board/freescale/t208xrdb/Makefile
index 7af3cd0ac4c..e5ef250c8b2 100644
--- a/board/freescale/t208xrdb/Makefile
+++ b/board/freescale/t208xrdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-$(CONFIG_TARGET_T2080RDB) += t208xrdb.o eth_t208xrdb.o cpld.o
diff --git a/board/freescale/t208xrdb/ddr.c b/board/freescale/t208xrdb/ddr.c
index fe98f62668a..cc9586eaa14 100644
--- a/board/freescale/t208xrdb/ddr.c
+++ b/board/freescale/t208xrdb/ddr.c
@@ -102,7 +102,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
diff --git a/board/freescale/t208xrdb/tlb.c b/board/freescale/t208xrdb/tlb.c
index a9a03908dfb..a3f283548f3 100644
--- a/board/freescale/t208xrdb/tlb.c
+++ b/board/freescale/t208xrdb/tlb.c
@@ -65,7 +65,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCIe 1, 0x80000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -141,7 +141,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_G,
 		      0, 18, BOOKE_PAGESZ_1M, 1),
 #endif
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 19, BOOKE_PAGESZ_2G, 1)
diff --git a/board/freescale/t4rdb/Makefile b/board/freescale/t4rdb/Makefile
index 3106848639c..8d94faaba1c 100644
--- a/board/freescale/t4rdb/Makefile
+++ b/board/freescale/t4rdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-$(CONFIG_TARGET_T4240RDB)	+= t4240rdb.o
diff --git a/board/freescale/t4rdb/cpld.c b/board/freescale/t4rdb/cpld.c
index cd14d5895f5..f076350c1c5 100644
--- a/board/freescale/t4rdb/cpld.c
+++ b/board/freescale/t4rdb/cpld.c
@@ -94,7 +94,7 @@ static void cpld_dump_regs(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int do_cpld(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int rc = 0;
diff --git a/board/freescale/t4rdb/ddr.c b/board/freescale/t4rdb/ddr.c
index bbe31d4a54e..1ce70962264 100644
--- a/board/freescale/t4rdb/ddr.c
+++ b/board/freescale/t4rdb/ddr.c
@@ -111,7 +111,7 @@ int dram_init(void)
 
 	puts("Initializing....using SPD\n");
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	dram_size = fsl_ddr_sdram();
 #else
 	/* DDR has been initialised by first stage boot loader */
diff --git a/board/freescale/t4rdb/tlb.c b/board/freescale/t4rdb/tlb.c
index 1fb9d41d52b..7c58c14f3b6 100644
--- a/board/freescale/t4rdb/tlb.c
+++ b/board/freescale/t4rdb/tlb.c
@@ -51,7 +51,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -114,7 +114,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SW|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 17, BOOKE_PAGESZ_4K, 1),
 #endif
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 18, BOOKE_PAGESZ_2G, 1)
diff --git a/board/gardena/smart-gateway-at91sam/Makefile b/board/gardena/smart-gateway-at91sam/Makefile
index a2ed79fd06c..ac9e57938b3 100644
--- a/board/gardena/smart-gateway-at91sam/Makefile
+++ b/board/gardena/smart-gateway-at91sam/Makefile
@@ -2,6 +2,6 @@
 
 obj-y += board.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/gardena/smart-gateway-mt7688/board.c b/board/gardena/smart-gateway-mt7688/board.c
index eb7fcd630a1..b6c0fe960ea 100644
--- a/board/gardena/smart-gateway-mt7688/board.c
+++ b/board/gardena/smart-gateway-mt7688/board.c
@@ -295,7 +295,7 @@ err_free:
 	return ret;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 U_BOOT_CMD(
 	fd_write,	1,	0,	do_fd_write,
 	"Write test factory-data values to SPI NOR",
diff --git a/board/gateworks/gw_ventana/Makefile b/board/gateworks/gw_ventana/Makefile
index c407f8e6c54..08859a963d0 100644
--- a/board/gateworks/gw_ventana/Makefile
+++ b/board/gateworks/gw_ventana/Makefile
@@ -7,4 +7,4 @@
 #
 
 obj-y  := gw_ventana.o eeprom.o common.o
-obj-$(CONFIG_SPL_BUILD) += gw_ventana_spl.o
+obj-$(CONFIG_XPL_BUILD) += gw_ventana_spl.o
diff --git a/board/gateworks/gw_ventana/eeprom.c b/board/gateworks/gw_ventana/eeprom.c
index b37f1972249..447862dfee1 100644
--- a/board/gateworks/gw_ventana/eeprom.c
+++ b/board/gateworks/gw_ventana/eeprom.c
@@ -327,7 +327,7 @@ struct ventana_eeprom_config econfig[] = {
 	{ /* Sentinel */ }
 };
 
-#if defined(CONFIG_CMD_EECONFIG) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_EECONFIG) && !defined(CONFIG_XPL_BUILD)
 static struct ventana_eeprom_config *get_config(const char *name)
 {
 	struct ventana_eeprom_config *cfg = econfig;
diff --git a/board/gateworks/venice/Makefile b/board/gateworks/venice/Makefile
index faf1348cfa9..ab69e07ba7b 100644
--- a/board/gateworks/venice/Makefile
+++ b/board/gateworks/venice/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += venice.o eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MM
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_imx8mm.o
diff --git a/board/gdsys/a38x/Makefile b/board/gdsys/a38x/Makefile
index 4b13859fed1..2713633730f 100644
--- a/board/gdsys/a38x/Makefile
+++ b/board/gdsys/a38x/Makefile
@@ -6,6 +6,6 @@
 
 obj-$(CONFIG_TARGET_CONTROLCENTERDC) += controlcenterdc.o hre.o keyprogram.o dt_helpers.o
 
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_TARGET_CONTROLCENTERDC) += hydra.o ihs_phys.o
 endif
diff --git a/board/gdsys/a38x/controlcenterdc.c b/board/gdsys/a38x/controlcenterdc.c
index 4abb3e45128..659dfddecea 100644
--- a/board/gdsys/a38x/controlcenterdc.c
+++ b/board/gdsys/a38x/controlcenterdc.c
@@ -84,7 +84,7 @@ int hws_board_topology_load(struct serdes_map **serdes_map_array, u8 *count)
 
 void spl_board_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	uint k;
 	struct gpio_desc gpio = {};
 
@@ -139,7 +139,7 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
 
 int board_early_init_f(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* Configure MPP */
 	writel(0x00111111, MVEBU_MPP_BASE + 0x00);
 	writel(0x40040000, MVEBU_MPP_BASE + 0x04);
@@ -174,7 +174,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void init_host_phys(struct mii_dev *bus)
 {
 	uint k;
@@ -241,7 +241,7 @@ int ccdc_eth_init(void)
 
 int board_late_init(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	hydra_initialize();
 #endif
 	return 0;
@@ -272,13 +272,13 @@ int board_fix_fdt(void *rw_fdt_blob)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int last_stage_init(void)
 {
 	struct udevice *tpm;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return 0;
 	ccdc_eth_init();
 
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index 031773bc5ef..c1aacd1458b 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -35,7 +35,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define B1X5V2_GE_VPD_OFFSET	0x0100000
 #define B1X5V2_GE_VPD_SIZE	1022
@@ -695,4 +695,4 @@ U_BOOT_CMD(
        ""
 );
 
-#endif // CONFIG_SPL_BUILD
+#endif // CONFIG_XPL_BUILD
diff --git a/board/ge/b1x5v2/spl.c b/board/ge/b1x5v2/spl.c
index 460d3be1d83..b6f23345acd 100644
--- a/board/ge/b1x5v2/spl.c
+++ b/board/ge/b1x5v2/spl.c
@@ -20,7 +20,7 @@
 #include <spi_flash.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #include <asm/arch/mx6-ddr.h>
 
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index 7b2724c01d0..3443dc91885 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -147,7 +147,7 @@ static int coral_get_str(struct udevice *dev, int id, size_t size, char *val)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return -ENOSYS;
 
 	switch (id) {
diff --git a/board/google/gru/gru.c b/board/google/gru/gru.c
index e08cb42c27e..f3a1a19f2b6 100644
--- a/board/google/gru/gru.c
+++ b/board/google/gru/gru.c
@@ -7,7 +7,7 @@
 #include <init.h>
 #include <asm/arch-rockchip/clock.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* provided to defeat compiler optimisation in board_init_f() */
 void gru_dummy_function(int i)
 {
@@ -33,7 +33,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int board_early_init_r(void)
 {
 	struct udevice *clk;
diff --git a/board/google/imx8mq_phanbell/Makefile b/board/google/imx8mq_phanbell/Makefile
index d6427cf8e90..ac6418e49a7 100644
--- a/board/google/imx8mq_phanbell/Makefile
+++ b/board/google/imx8mq_phanbell/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += imx8mq_phanbell.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_1g.o
 endif
diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index bd8ce633772..7057b76e290 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -19,7 +19,7 @@
  * There is a U-Boot driver for this but it may need to add support for the
  * 'voltage-table' property.
  */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if !CONFIG_IS_ENABLED(ROCKCHIP_BACK_TO_BROM)
 static int veyron_init(void)
 {
diff --git a/board/grinn/chiliboard/board.c b/board/grinn/chiliboard/board.c
index e0eb8aa9f2b..d5491d5076f 100644
--- a/board/grinn/chiliboard/board.c
+++ b/board/grinn/chiliboard/board.c
@@ -104,7 +104,7 @@ int board_init(void)
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	uint8_t mac_addr[6];
 	uint32_t mac_hi, mac_lo;
 
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index 07bb5b7d797..c2a44b4aa2d 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -229,7 +229,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_boot_order(u32 *spl_boot_list)
 {
 	struct src *psrc = (struct src *)SRC_BASE_ADDR;
diff --git a/board/htc/endeavoru/Makefile b/board/htc/endeavoru/Makefile
index 0c6ba4af3b1..57f84d6ea98 100644
--- a/board/htc/endeavoru/Makefile
+++ b/board/htc/endeavoru/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += endeavoru-spl.o
+obj-$(CONFIG_XPL_BUILD) += endeavoru-spl.o
 
 obj-y += endeavoru.o
diff --git a/board/imgtec/ci20/ci20.c b/board/imgtec/ci20/ci20.c
index 4e268381d3c..3e9833d684f 100644
--- a/board/imgtec/ci20/ci20.c
+++ b/board/imgtec/ci20/ci20.c
@@ -39,7 +39,7 @@ static void ci20_mux_mmc(void)
 	jz4780_clk_ungate_mmc();
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 static void ci20_mux_eth(void)
 {
@@ -251,7 +251,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #if defined(CONFIG_SPL_MMC)
 int board_mmc_init(struct bd_info *bd)
diff --git a/board/isee/igep003x/Makefile b/board/isee/igep003x/Makefile
index c3e39745252..02ec0ccbdb2 100644
--- a/board/isee/igep003x/Makefile
+++ b/board/isee/igep003x/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2013, ISEE 2007 SL - http://www.isee.biz/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= mux.o
 endif
 
diff --git a/board/isee/igep003x/board.c b/board/isee/igep003x/board.c
index 7cd26ce3c34..162467c803a 100644
--- a/board/isee/igep003x/board.c
+++ b/board/isee/igep003x/board.c
@@ -68,7 +68,7 @@ static int get_board_revision(void)
 	return revision;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* PN H5TQ4G63AFR is equivalent to MT41K256M16HA125*/
 static const struct ddr_data ddr3_igep0034_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
diff --git a/board/isee/igep00x0/Makefile b/board/isee/igep00x0/Makefile
index e095bcada29..527748cdadd 100644
--- a/board/isee/igep00x0/Makefile
+++ b/board/isee/igep00x0/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000, 2001, 2002
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= spl.o common.o
 else
 obj-y	:= igep00x0.o common.o
diff --git a/board/k+p/kp_imx6q_tpc/Makefile b/board/k+p/kp_imx6q_tpc/Makefile
index 6551b2bfa2d..6444628c649 100644
--- a/board/k+p/kp_imx6q_tpc/Makefile
+++ b/board/k+p/kp_imx6q_tpc/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2018 Lukasz Majewski <lukma@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= kp_imx6q_tpc_spl.o
 else
 obj-y	:= kp_imx6q_tpc.o
diff --git a/board/kontron/pitx_imx8m/Makefile b/board/kontron/pitx_imx8m/Makefile
index 6ebe5d07709..50ca56f4efd 100644
--- a/board/kontron/pitx_imx8m/Makefile
+++ b/board/kontron/pitx_imx8m/Makefile
@@ -2,7 +2,7 @@
 
 obj-y += pitx_imx8m.o pitx_misc.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o pitx_misc.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_2gb.o lpddr4_timing_4gb.o
 endif
diff --git a/board/kontron/sl-mx6ul/Makefile b/board/kontron/sl-mx6ul/Makefile
index 6af5f65450a..dfed1991ee7 100644
--- a/board/kontron/sl-mx6ul/Makefile
+++ b/board/kontron/sl-mx6ul/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2018 Kontron Electronics GmbH
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y := spl.o
 else
 obj-y := sl-mx6ul.o
diff --git a/board/kontron/sl-mx8mm/Makefile b/board/kontron/sl-mx8mm/Makefile
index fceed684ede..b47fafc5733 100644
--- a/board/kontron/sl-mx8mm/Makefile
+++ b/board/kontron/sl-mx8mm/Makefile
@@ -3,7 +3,7 @@
 
 obj-y := sl-mx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/kontron/sl28/Makefile b/board/kontron/sl28/Makefile
index 084c11da376..2cb41251708 100644
--- a/board/kontron/sl28/Makefile
+++ b/board/kontron/sl28/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += sl28.o cmds.o
 endif
 
@@ -8,7 +8,7 @@ obj-y += common.o ddr.o
 
 obj-$(CONFIG_ARMV8_PSCI) += psci.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_SPL_ATF) += spl_atf.o
 endif
diff --git a/board/kontron/sl28/ddr.c b/board/kontron/sl28/ddr.c
index 9b881fdc265..1f1a6aa1b16 100644
--- a/board/kontron/sl28/ddr.c
+++ b/board/kontron/sl28/ddr.c
@@ -98,7 +98,7 @@ int fsl_initdram(void)
 		break;
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_XPL_BUILD))
 		fsl_ddr_set_memctl_regs(&ddr_cfg_regs, 0, 0);
 
 	gd->ram_size = dram_size;
diff --git a/board/kosagi/novena/Makefile b/board/kosagi/novena/Makefile
index 64d32f5a963..fdcd8b5f422 100644
--- a/board/kosagi/novena/Makefile
+++ b/board/kosagi/novena/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2014 Marek Vasut <marex@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= novena_spl.o
 else
 obj-y	:= novena.o
diff --git a/board/lenovo/ideapad-yoga-11/Makefile b/board/lenovo/ideapad-yoga-11/Makefile
index 186f1cb4ee5..fd9736d1bf1 100644
--- a/board/lenovo/ideapad-yoga-11/Makefile
+++ b/board/lenovo/ideapad-yoga-11/Makefile
@@ -3,4 +3,4 @@
 #  (C) Copyright 2022
 #  Open Surface RT
 
-obj-$(CONFIG_SPL_BUILD) += ideapad-yoga-11-spl.o
+obj-$(CONFIG_XPL_BUILD) += ideapad-yoga-11-spl.o
diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
index 9d0959f294e..d4db32ee69b 100644
--- a/board/lg/sniper/sniper.c
+++ b/board/lg/sniper/sniper.c
@@ -54,7 +54,7 @@ void set_muxconf_regs(void)
 	MUX_SNIPER();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void get_board_mem_timings(struct board_sdrc_timings *timings)
 {
 	timings->mcfg = HYNIX_V_MCFG_200(256 << 20);
diff --git a/board/lg/x3-t30/Makefile b/board/lg/x3-t30/Makefile
index 3eeb132f3c6..fb2527f9ee8 100644
--- a/board/lg/x3-t30/Makefile
+++ b/board/lg/x3-t30/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += x3-t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += x3-t30-spl.o
 
 obj-y += x3-t30.o
diff --git a/board/liebherr/display5/Makefile b/board/liebherr/display5/Makefile
index ee503add75d..c62583a9806 100644
--- a/board/liebherr/display5/Makefile
+++ b/board/liebherr/display5/Makefile
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier:    GPL-2.0+
 #
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y = spl.o
 else
 obj-y := display5.o
diff --git a/board/liebherr/mccmon6/Makefile b/board/liebherr/mccmon6/Makefile
index 3c9786c6b7d..d5fdc2011b0 100644
--- a/board/liebherr/mccmon6/Makefile
+++ b/board/liebherr/mccmon6/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2016-2017
 # Lukasz Majewski, DENX Software Engineering, lukma@denx.de
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  := spl.o
 else
 obj-y  := mccmon6.o
diff --git a/board/liebherr/xea/Makefile b/board/liebherr/xea/Makefile
index abf500857f6..6efa07ca004 100644
--- a/board/liebherr/xea/Makefile
+++ b/board/liebherr/xea/Makefile
@@ -7,6 +7,6 @@
 
 obj-y	:= xea.o
 
-ifdef	CONFIG_SPL_BUILD
+ifdef	CONFIG_XPL_BUILD
 obj-y	+= spl_xea.o
 endif
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 9ade3563b25..1d4f165fd13 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -37,7 +37,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #endif
 
@@ -62,7 +62,7 @@ static void init_clocks(void)
 	mxs_set_sspclk(MXC_SSPCLK3, 96000, 0);
 }
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
 void board_init_f(ulong arg)
 {
 	init_clocks();
@@ -355,4 +355,4 @@ U_BOOT_DRIVER(fsl_imx28_clkctrl) = {
 	.id             = UCLASS_CLK,
 	.of_match       = imx28_clk_ids,
 };
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517evm/am3517evm.c
index e6ca31016b7..e4f619d0942 100644
--- a/board/logicpd/am3517evm/am3517evm.c
+++ b/board/logicpd/am3517evm/am3517evm.c
@@ -39,7 +39,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CPGMACSS_SW_RST		(1 << 1)
 #define PHY_GPIO		30
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
diff --git a/board/logicpd/imx6/imx6logic.c b/board/logicpd/imx6/imx6logic.c
index 589136fd64a..652994df616 100644
--- a/board/logicpd/imx6/imx6logic.c
+++ b/board/logicpd/imx6/imx6logic.c
@@ -135,7 +135,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <asm/arch/mx6q-ddr.h>
 #include <spl.h>
diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/omap3logic.c
index a9fe61918b6..352b519b451 100644
--- a/board/logicpd/omap3som/omap3logic.c
+++ b/board/logicpd/omap3som/omap3logic.c
@@ -68,7 +68,7 @@ int spl_start_uboot(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /*
  * Routine: get_board_mem_timings
  * Description: If we use SPL then there is no x-loader nor config header
diff --git a/board/menlo/m53menlo/m53menlo.c b/board/menlo/m53menlo/m53menlo.c
index 79351f47273..fc76d5765fa 100644
--- a/board/menlo/m53menlo/m53menlo.c
+++ b/board/menlo/m53menlo/m53menlo.c
@@ -524,7 +524,7 @@ int checkboard(void)
 /*
  * NAND SPL
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	setup_iomux_nand();
diff --git a/board/menlo/mx8menlo/Makefile b/board/menlo/mx8menlo/Makefile
index fd5ec826336..62939395ba1 100644
--- a/board/menlo/mx8menlo/Makefile
+++ b/board/menlo/mx8menlo/Makefile
@@ -9,13 +9,13 @@ obj-y	:= mx8menlo.o
 
 obj-y += ../../toradex/verdin-imx8mm/verdin-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += ../../toradex/verdin-imx8mm/spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += ../../toradex/verdin-imx8mm/lpddr4_timing.o
 endif
 
 # Common for all Toradex modules
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # Necessary to create built-in.o
 obj- := __dummy__.o
 else
diff --git a/board/microsoft/surface-rt/Makefile b/board/microsoft/surface-rt/Makefile
index da4094a7df3..feda1dba3bd 100644
--- a/board/microsoft/surface-rt/Makefile
+++ b/board/microsoft/surface-rt/Makefile
@@ -3,4 +3,4 @@
 #  (C) Copyright 2021
 #  Open Surface RT
 
-obj-$(CONFIG_SPL_BUILD) += surface-rt-spl.o
+obj-$(CONFIG_XPL_BUILD) += surface-rt-spl.o
diff --git a/board/mntre/imx8mq_reform2/Makefile b/board/mntre/imx8mq_reform2/Makefile
index 2efd56bb4ad..2772c8dc717 100644
--- a/board/mntre/imx8mq_reform2/Makefile
+++ b/board/mntre/imx8mq_reform2/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_reform2.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/msc/sm2s_imx8mp/Makefile b/board/msc/sm2s_imx8mp/Makefile
index 7908a0ceb04..48dc885b8f6 100644
--- a/board/msc/sm2s_imx8mp/Makefile
+++ b/board/msc/sm2s_imx8mp/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing.o
 else
 obj-y += sm2s_imx8mp.o
diff --git a/board/myir/mys_6ulx/Makefile b/board/myir/mys_6ulx/Makefile
index 3c63e439aba..9b76595701e 100644
--- a/board/myir/mys_6ulx/Makefile
+++ b/board/myir/mys_6ulx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y  := mys_6ulx.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/nvidia/beaver/Makefile b/board/nvidia/beaver/Makefile
index 5e9e70825c7..d56c7151af6 100644
--- a/board/nvidia/beaver/Makefile
+++ b/board/nvidia/beaver/Makefile
@@ -2,6 +2,6 @@
 #
 # Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
 
-obj-$(CONFIG_SPL_BUILD) += beaver-spl.o
+obj-$(CONFIG_XPL_BUILD) += beaver-spl.o
 
 obj-y	= ../cardhu/cardhu.o
diff --git a/board/nvidia/cardhu/Makefile b/board/nvidia/cardhu/Makefile
index 6f480cdfd3b..85d88295c08 100644
--- a/board/nvidia/cardhu/Makefile
+++ b/board/nvidia/cardhu/Makefile
@@ -3,6 +3,6 @@
 #  (C) Copyright 2010-2012
 #  NVIDIA Corporation <www.nvidia.com>
 
-obj-$(CONFIG_SPL_BUILD) += cardhu-spl.o
+obj-$(CONFIG_XPL_BUILD) += cardhu-spl.o
 
 obj-y	+= cardhu.o
diff --git a/board/olimex/mx23_olinuxino/Makefile b/board/olimex/mx23_olinuxino/Makefile
index b2ea8974344..0a6beb10ded 100644
--- a/board/olimex/mx23_olinuxino/Makefile
+++ b/board/olimex/mx23_olinuxino/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx23_olinuxino.o
 else
 obj-y	:= spl_boot.o
diff --git a/board/opalkelly/zynq/Makefile b/board/opalkelly/zynq/Makefile
index 19e893e43d7..8a2375a1068 100644
--- a/board/opalkelly/zynq/Makefile
+++ b/board/opalkelly/zynq/Makefile
@@ -4,4 +4,4 @@ obj-y	:= board.o
 
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 04469d0a924..cd78f7686fe 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2023 PHYTEC Messtechnik GmbH
 # Author: Teresa Remmet <t.remmet@phytec.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 endif
diff --git a/board/phytec/pcl063/Makefile b/board/phytec/pcl063/Makefile
index 53c73c9b082..0f17eb466c5 100644
--- a/board/phytec/pcl063/Makefile
+++ b/board/phytec/pcl063/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y  := pcl063.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/phytec/pcm058/pcm058.c b/board/phytec/pcm058/pcm058.c
index ecc5b75d8d4..4a95376b359 100644
--- a/board/phytec/pcm058/pcm058.c
+++ b/board/phytec/pcm058/pcm058.c
@@ -108,7 +108,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 
diff --git a/board/phytec/phycore_am335x_r2/Makefile b/board/phytec/phycore_am335x_r2/Makefile
index 16ac38fd8be..4f865ab9e10 100644
--- a/board/phytec/phycore_am335x_r2/Makefile
+++ b/board/phytec/phycore_am335x_r2/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= mux.o
 endif
 
diff --git a/board/phytec/phycore_am335x_r2/board.c b/board/phytec/phycore_am335x_r2/board.c
index 2022525651d..a2a488a0e30 100644
--- a/board/phytec/phycore_am335x_r2/board.c
+++ b/board/phytec/phycore_am335x_r2/board.c
@@ -26,7 +26,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 9f6bc736cbb..a0e098e010e 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -182,7 +182,7 @@ int do_board_detect(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	u64 start[CONFIG_NR_DRAM_BANKS];
diff --git a/board/phytec/phycore_imx8mm/Makefile b/board/phytec/phycore_imx8mm/Makefile
index 27f6c027b6c..2fb59761fc9 100644
--- a/board/phytec/phycore_imx8mm/Makefile
+++ b/board/phytec/phycore_imx8mm/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += phycore-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/phytec/phycore_imx8mp/Makefile b/board/phytec/phycore_imx8mp/Makefile
index c4c434c9475..8cf1f4dcea3 100644
--- a/board/phytec/phycore_imx8mp/Makefile
+++ b/board/phytec/phycore_imx8mp/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += phycore-imx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/phytec/phycore_imx93/Makefile b/board/phytec/phycore_imx93/Makefile
index ce35326a156..dd5085e160f 100644
--- a/board/phytec/phycore_imx93/Makefile
+++ b/board/phytec/phycore_imx93/Makefile
@@ -9,6 +9,6 @@
 
 obj-y += phycore-imx93.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing.o
 endif
diff --git a/board/polyhex/imx8mp_debix_model_a/Makefile b/board/polyhex/imx8mp_debix_model_a/Makefile
index e5cdc850878..3d50c7af4af 100644
--- a/board/polyhex/imx8mp_debix_model_a/Makefile
+++ b/board/polyhex/imx8mp_debix_model_a/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += imx8mp_debix_model_a.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/purism/librem5/Makefile b/board/purism/librem5/Makefile
index 47f25f047b7..4514add3a5b 100644
--- a/board/purism/librem5/Makefile
+++ b/board/purism/librem5/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += librem5.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o lpddr4_timing_b0.o
 endif
diff --git a/board/purism/librem5/librem5.h b/board/purism/librem5/librem5.h
index 0d24edea9b1..69475a5b063 100644
--- a/board/purism/librem5/librem5.h
+++ b/board/purism/librem5/librem5.h
@@ -57,7 +57,7 @@
 /* Could be ASPEN, BIRCH or CHESTNUT. assume CHESTNUT */
 #define BOARD_REV_UNKNOWN	BOARD_REV_CHESTNUT
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const iomux_v3_cfg_t configure_pads[] = {
 	IMX8MQ_PAD_GPIO1_IO00__GPIO1_IO0 | MUX_PAD_CTRL(PAD_CTL_DSE6),
 	IMX8MQ_PAD_GPIO1_IO03__GPIO1_IO3 | MUX_PAD_CTRL(PAD_CTL_DSE6) | MUX_MODE_SION,
@@ -151,7 +151,7 @@ static inline void init_pinmux(void)
 	gpio_direction_output(AUDIO_EN, 1);
 	gpio_direction_output(DSI_EN, 1);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define USB1_BASE_ADDR         0x38100000
 #define USB2_BASE_ADDR         0x38200000
diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
index a533128b92f..fd827467b30 100644
--- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
+++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
@@ -18,7 +18,7 @@ struct efi_capsule_update_info update_info = {
 
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 static bool board_is_rockpi_4b(void)
 {
@@ -55,4 +55,4 @@ void rockchip_capsule_update_board_setup(void)
 	}
 }
 #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/renesas/alt/Makefile b/board/renesas/alt/Makefile
index 53418699b27..f9c131fc6cd 100644
--- a/board/renesas/alt/Makefile
+++ b/board/renesas/alt/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= alt_spl.o
 else
 obj-y	:= alt.o qos.o
diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
index 19e6038430b..cb965cde35f 100644
--- a/board/renesas/condor/Makefile
+++ b/board/renesas/condor/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/common.o
diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
index 1fc90d1dab4..8859cf902ca 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= draak.o ../rcar-common/common.o
diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
index 9fb6a7c0f0a..98164b5ea29 100644
--- a/board/renesas/eagle/Makefile
+++ b/board/renesas/eagle/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
index 956ce8a90fa..283d3a4ae36 100644
--- a/board/renesas/ebisu/Makefile
+++ b/board/renesas/ebisu/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/common.o
diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
index 3b202c24fb1..2e240d3bad6 100644
--- a/board/renesas/falcon/Makefile
+++ b/board/renesas/falcon/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= falcon.o ../rcar-common/common.o
diff --git a/board/renesas/gose/Makefile b/board/renesas/gose/Makefile
index c6a1dc21cda..2c45bd74014 100644
--- a/board/renesas/gose/Makefile
+++ b/board/renesas/gose/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= gose_spl.o
 else
 obj-y	:= gose.o qos.o
diff --git a/board/renesas/koelsch/Makefile b/board/renesas/koelsch/Makefile
index 77cf067406c..1b0818fa7ec 100644
--- a/board/renesas/koelsch/Makefile
+++ b/board/renesas/koelsch/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= koelsch_spl.o
 else
 obj-y	:= koelsch.o qos.o
diff --git a/board/renesas/lager/Makefile b/board/renesas/lager/Makefile
index 379368fdfce..77e380f9335 100644
--- a/board/renesas/lager/Makefile
+++ b/board/renesas/lager/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= lager_spl.o
 else
 obj-y	:= lager.o qos.o
diff --git a/board/renesas/porter/Makefile b/board/renesas/porter/Makefile
index c237ee5ec77..9f22044bc79 100644
--- a/board/renesas/porter/Makefile
+++ b/board/renesas/porter/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= porter_spl.o
 else
 obj-y	:= porter.o qos.o
diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
index 95258079e40..0fc69ba9de6 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= salvator-x.o ../rcar-common/common.o
diff --git a/board/renesas/silk/Makefile b/board/renesas/silk/Makefile
index b5c3ad8d934..48dd7dbb8be 100644
--- a/board/renesas/silk/Makefile
+++ b/board/renesas/silk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= silk_spl.o
 else
 obj-y	:= silk.o qos.o
diff --git a/board/renesas/stout/Makefile b/board/renesas/stout/Makefile
index b8875bb7b98..e1bca5339b9 100644
--- a/board/renesas/stout/Makefile
+++ b/board/renesas/stout/Makefile
@@ -8,7 +8,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= stout_spl.o
 else
 obj-y	:= stout.o cpld.o qos.o
diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
index f4d24c68a67..ec2f161feae 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ulcb.o cpld.o ../rcar-common/common.o
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index a9d597edd58..b29114c7239 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index ec493e572f1..f8c4bcdcf9f 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/ronetix/imx7-cm/Makefile b/board/ronetix/imx7-cm/Makefile
index 7e08f238a0d..1ca6332852f 100644
--- a/board/ronetix/imx7-cm/Makefile
+++ b/board/ronetix/imx7-cm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2017 NXP Semiconductors
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  += spl.o
 else
 obj-y  += imx7-cm.o
diff --git a/board/ronetix/imx8mq-cm/Makefile b/board/ronetix/imx8mq-cm/Makefile
index 0d9d8e646db..4ca2a96d81e 100644
--- a/board/ronetix/imx8mq-cm/Makefile
+++ b/board/ronetix/imx8mq-cm/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_cm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/samsung/common/Makefile b/board/samsung/common/Makefile
index d31b81abf1e..abecef8be11 100644
--- a/board/samsung/common/Makefile
+++ b/board/samsung/common/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_USB_GADGET_DOWNLOAD) += gadget.o
 obj-$(CONFIG_MISC_COMMON) += misc.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_BOARD_COMMON)	+= board.o sromc.o
 ifdef CONFIG_EXYNOS5_DT
 obj-y += exynos5-dt.o
diff --git a/board/samsung/origen/Makefile b/board/samsung/origen/Makefile
index 44691af09f4..940f689a601 100644
--- a/board/samsung/origen/Makefile
+++ b/board/samsung/origen/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2011 Samsung Electronics
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 
diff --git a/board/samsung/smdkv310/Makefile b/board/samsung/smdkv310/Makefile
index fccd8ffd2c1..b7f9d5a254c 100644
--- a/board/samsung/smdkv310/Makefile
+++ b/board/samsung/smdkv310/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2011 Samsung Electronics
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 
diff --git a/board/seeed/npi_imx6ull/Makefile b/board/seeed/npi_imx6ull/Makefile
index 93ea413517d..bd8f83148bb 100644
--- a/board/seeed/npi_imx6ull/Makefile
+++ b/board/seeed/npi_imx6ull/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y	:= npi_imx6ull.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/sielaff/imx6dl-sielaff/Makefile b/board/sielaff/imx6dl-sielaff/Makefile
index 65cecfe6f6c..9c8bab662e4 100644
--- a/board/sielaff/imx6dl-sielaff/Makefile
+++ b/board/sielaff/imx6dl-sielaff/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2022 Kontron Electronics GmbH
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y := spl.o
 else
 obj-y := imx6dl-sielaff.o
diff --git a/board/siemens/capricorn/Makefile b/board/siemens/capricorn/Makefile
index 4dafac10829..e8a24c448b9 100644
--- a/board/siemens/capricorn/Makefile
+++ b/board/siemens/capricorn/Makefile
@@ -6,7 +6,7 @@
 obj-y += board.o
 obj-y += ../common/eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += ../common/factoryset.o
diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 53dac8bfe1b..ad474d9baa0 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -235,7 +235,7 @@ void reset_cpu(void)
 {
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* LED's */
 static int board_led_init(void)
 {
@@ -265,7 +265,7 @@ static int board_led_init(void)
 	mdelay(1);
 	return ret;
 }
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 
 int checkboard(void)
 {
@@ -335,7 +335,7 @@ void board_late_mmc_env_init(void)
 	run_command(cmd, 0);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int load_parameters_from_factoryset(void)
 {
 	int ret;
@@ -443,4 +443,4 @@ U_BOOT_CMD(
 	"Reset eth phy",
 	"[print]"
 );
-#endif /* ! CONFIG_SPL_BUILD */
+#endif /* ! CONFIG_XPL_BUILD */
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index e6537b0675a..daf0bb930ec 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -22,7 +22,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void set_uart_mux_conf(void)
 {
 	enable_uart0_pin_mux();
@@ -52,9 +52,9 @@ void sdram_init(void)
 
 	return;
 }
-#endif /* #ifdef CONFIG_SPL_BUILD */
+#endif /* #ifdef CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Basic board specific setup.  Pinmux has been handled already.
  */
@@ -78,7 +78,7 @@ int board_init(void)
 
 	return 0;
 }
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 
 #define OSC	(V_OSCK/1000000)
 const struct dpll_params dpll_ddr = {
@@ -89,7 +89,7 @@ const struct dpll_params *get_dpll_ddr_params(void)
 	return &dpll_ddr;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define MAX_NR_LEDS	10
 #define MAX_PIN_NUMBER	128
@@ -247,4 +247,4 @@ U_BOOT_CMD(
 	"Set LEDs defined in environment",
 	"<0|1>"
 );
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/siemens/common/board_am335x.h b/board/siemens/common/board_am335x.h
index 3a20352d457..4c9d5b04f12 100644
--- a/board/siemens/common/board_am335x.h
+++ b/board/siemens/common/board_am335x.h
@@ -22,7 +22,7 @@ void spl_draco_board_init(void);
 void draco_init_ddr(void);
 int draco_read_eeprom(void);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* Mux for init: uart?, i2c0 to read the main EEPROM */
 void enable_uart0_pin_mux(void);
 void enable_uart1_pin_mux(void);
@@ -34,6 +34,6 @@ void enable_i2c0_pin_mux(void);
 
 /* Main mux function to enable other pinmux required on the board */
 void enable_board_pin_mux(void);
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _BOARD_AM335X_H_ */
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index a250ccfe252..8261b3d37cc 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -5,7 +5,7 @@
  * (C) Copyright 2013 Siemens Schweiz AG
  */
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #include <env.h>
 #include <g_dnl.h>
@@ -350,4 +350,4 @@ int g_dnl_get_board_bcd_device_number(int gcnum)
 {
 	return factory_dat.version;
 }
-#endif /* defined(CONFIG_SPL_BUILD) */
+#endif /* defined(CONFIG_XPL_BUILD) */
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index cd27fc1cc37..a8714e055d7 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -114,7 +114,7 @@ static void corvus_nand_hw_init(void)
 	at91_set_gpio_input(CFG_SYS_NAND_READY_PIN, 1);
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/siemens/draco/Makefile b/board/siemens/draco/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/draco/Makefile
+++ b/board/siemens/draco/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index fc3eb06ccf2..147f827673b 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -28,7 +28,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static struct draco_baseboard_id __section(".data") settings;
 
 #if DDR_PLL_FREQ == 303
@@ -106,7 +106,7 @@ static void print_chip_data(void)
 	printf("hw version: \t'%s'\n", settings.chip.shwver);
 	printf("max freq: \t%d MHz\n", dpll_mpu_opp100.m);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define AM335X_NAND_ECC_MASK 0x0f
 #define AM335X_NAND_ECC_TYPE_16 0x02
@@ -142,7 +142,7 @@ static int draco_read_nand_geometry(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -233,7 +233,7 @@ void spl_draco_board_init(void)
 {
 	return;
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
@@ -266,8 +266,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -343,4 +343,4 @@ U_BOOT_CMD(
 	""
 );
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
diff --git a/board/siemens/pxm2/Makefile b/board/siemens/pxm2/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/pxm2/Makefile
+++ b/board/siemens/pxm2/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 888c7c09baf..4f9611372cd 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -28,7 +28,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void draco_init_ddr(void)
 {
 struct emif_regs pxm2_ddr3_emif_reg_data = {
@@ -154,10 +154,10 @@ int draco_read_eeprom(void)
 
 	return 0;
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -198,15 +198,15 @@ static struct cpsw_platform_data cpsw_data = {
 	.host_port_num		= 0,
 	.version		= CPSW_CTRL_VERSION_2,
 };
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
 
 #if defined(CONFIG_DRIVER_TI_CPSW) || \
 	(defined(CONFIG_USB_ETHER) && defined(CONFIG_USB_MUSB_GADGET))
 int board_eth_init(struct bd_info *bis)
 {
 	int n = 0;
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 #ifdef CONFIG_FACTORYSET
 	int rv;
diff --git a/board/siemens/rut/Makefile b/board/siemens/rut/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/rut/Makefile
+++ b/board/siemens/rut/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index 8d316918e7a..828ae5c27a0 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -24,7 +24,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -116,7 +116,7 @@ void spl_draco_board_init(void)
 	REQUEST_AND_PULSE_RESET(MAXTOUCH_RESET_GPIO);
 	REQUEST_AND_PULSE_RESET(DISPLAY_RESET_GPIO);
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
 #if defined(CONFIG_DRIVER_TI_CPSW)
 static void cpsw_control(int enabled)
@@ -168,7 +168,7 @@ int board_eth_init(struct bd_info *bis)
 	int n = 0;
 	int rv;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	factoryset_env_set();
 #endif
 
@@ -183,7 +183,7 @@ int board_eth_init(struct bd_info *bis)
 	return n;
 }
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
 
 #if defined(CONFIG_HW_WATCHDOG)
 static bool hw_watchdog_init_done;
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index e9e4bc348cb..6fa3ca573ae 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -191,7 +191,7 @@ int board_eth_init(struct bd_info *bis)
 #endif /* CONFIG_MACB */
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 #include <spi_flash.h>
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index 3764ab48ab3..252b0787124 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -79,7 +79,7 @@ static void taurus_nand_hw_init(void)
 	at91_set_gpio_output(CFG_SYS_NAND_ENABLE_PIN, 1);
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 #include <spi_flash.h>
@@ -331,7 +331,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_BOARD_AXM)
 /*
  * Booting the Fallback Image.
diff --git a/board/sifive/unleashed/Makefile b/board/sifive/unleashed/Makefile
index 98e9111cbcc..d0a156d2cab 100644
--- a/board/sifive/unleashed/Makefile
+++ b/board/sifive/unleashed/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2019 Western Digital Corporation or its affiliates.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += unleashed.o
diff --git a/board/sifive/unmatched/Makefile b/board/sifive/unmatched/Makefile
index 13453300896..ce9deed9cdc 100644
--- a/board/sifive/unmatched/Makefile
+++ b/board/sifive/unmatched/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_ID_EEPROM) += hifive-platform-i2c-eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += unmatched.o
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index 4c8f0925f1e..6917a2418ca 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../../renesas/rcar-common/gen3-spl.o
 else
 obj-y	:= ek874.o ../../renesas/rcar-common/common.o
diff --git a/board/softing/vining_2000/vining_2000.c b/board/softing/vining_2000/vining_2000.c
index bd430cfaa7f..769f3e2ff2a 100644
--- a/board/softing/vining_2000/vining_2000.c
+++ b/board/softing/vining_2000/vining_2000.c
@@ -402,7 +402,7 @@ void board_preboot_os(void)
 	setbits_le32(&gpc_regs->cntr, PCIE_PHY_PUP_REQ);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index 2483fbcf263..ec2c7ea3631 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -43,7 +43,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int misc_init_r(void)
 {
 	uchar data[128];
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 3406ba8616e..e9269ef5353 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -570,7 +570,7 @@ void board_boot_order(u32 *spl_boot_list)
 	spl_boot_list[1] = BOOT_DEVICE_BOARD;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 static const struct mx6dq_iomux_ddr_regs mx6q_ddr_ioregs = {
 	.dram_sdclk_0 =  0x00020030,
diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index 50da063051b..b9d0abdba7d 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -29,7 +29,7 @@
  *   Board: MB<Board> Var<VarCPN>.<VarFG> Rev.<Revision>-<BOM>
  */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <misc.h>
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 6d86e4fe7aa..8966a09501e 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -27,7 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int rv;
 	struct udevice *dev;
 	rv = uclass_get_device(UCLASS_RAM, 0, &dev);
@@ -45,7 +45,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/st/stm32mp1/Makefile b/board/st/stm32mp1/Makefile
index f2d720b67b3..5e39b7b189f 100644
--- a/board/st/stm32mp1/Makefile
+++ b/board/st/stm32mp1/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += stm32mp1.o
diff --git a/board/starfive/visionfive2/Makefile b/board/starfive/visionfive2/Makefile
index c7ba4f7ed67..97c25a2fd13 100644
--- a/board/starfive/visionfive2/Makefile
+++ b/board/starfive/visionfive2/Makefile
@@ -4,5 +4,5 @@
 #
 
 obj-y	:= starfive_visionfive2.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 obj-$(CONFIG_ID_EEPROM) += visionfive2-i2c-eeprom.o
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 961cdcde74d..824c322a0dc 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -281,7 +281,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_NAND_SUNXI) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NAND_SUNXI) && defined(CONFIG_XPL_BUILD)
 static void nand_pinmux_setup(void)
 {
 	unsigned int pin;
@@ -530,7 +530,7 @@ int mmc_get_env_dev(void)
 #endif
 #endif /* CONFIG_MMC */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 {
@@ -641,7 +641,7 @@ void sunxi_board_init(void)
 	else
 		printf("Failed to set core voltage! Can't set CPU frequency\n");
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_USB_GADGET
 int g_dnl_board_usb_cable_connected(void)
diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 6c60c70b7b4..20fa61131cb 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -249,8 +249,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -303,10 +303,10 @@ static struct cpsw_platform_data cpsw_data = {
  * when we build an SPL that has neither option but full U-Boot will.
  */
 #if ((defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)) \
-		&& defined(CONFIG_SPL_BUILD)) || \
+		&& defined(CONFIG_XPL_BUILD)) || \
 	((defined(CONFIG_DRIVER_TI_CPSW) || \
 	  defined(CONFIG_USB_ETHER) && defined(CONFIG_MUSB_GADGET)) && \
-	 !defined(CONFIG_SPL_BUILD))
+	 !defined(CONFIG_XPL_BUILD))
 int board_eth_init(struct bd_info *bis)
 {
 	int rv, n = 0;
@@ -323,8 +323,8 @@ int board_eth_init(struct bd_info *bis)
 	mac_addr[4] = mac_lo & 0xFF;
 	mac_addr[5] = (mac_lo & 0xFF00) >> 8;
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	if (!env_get("ethaddr")) {
 		printf("<ethaddr> not set. Validating first E-fuse MAC\n");
 
@@ -373,7 +373,7 @@ int board_eth_init(struct bd_info *bis)
 
 #endif
 #if defined(CONFIG_USB_ETHER) && \
-	(!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
+	(!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
 	if (is_valid_ether_addr(mac_addr))
 		eth_env_set_enetaddr("usbnet_devaddr", mac_addr);
 
diff --git a/board/technexion/pico-imx6/spl.c b/board/technexion/pico-imx6/spl.c
index 50f51774264..700abb73289 100644
--- a/board/technexion/pico-imx6/spl.c
+++ b/board/technexion/pico-imx6/spl.c
@@ -24,7 +24,7 @@
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <asm/arch/mx6-ddr.h>
 
 #define IMX6DQ_DRIVE_STRENGTH		0x30
diff --git a/board/technexion/pico-imx6ul/spl.c b/board/technexion/pico-imx6ul/spl.c
index 67484e62dad..5b91868ba9c 100644
--- a/board/technexion/pico-imx6ul/spl.c
+++ b/board/technexion/pico-imx6ul/spl.c
@@ -18,7 +18,7 @@
 #include <linux/libfdt.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index 8f219f76c60..cb60d3be420 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -21,7 +21,7 @@
 #include <fsl_esdhc_imx.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
diff --git a/board/technexion/pico-imx8mq/Makefile b/board/technexion/pico-imx8mq/Makefile
index 7cfe1e02ef9..da3073cdf79 100644
--- a/board/technexion/pico-imx8mq/Makefile
+++ b/board/technexion/pico-imx8mq/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += pico-imx8mq.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_1gb.o lpddr4_timing_2gb.o lpddr4_timing_3gb.o lpddr4_timing_4gb.o
 endif
diff --git a/board/theadorable/theadorable.c b/board/theadorable/theadorable.c
index d7234532fe6..2f5ad769b9b 100644
--- a/board/theadorable/theadorable.c
+++ b/board/theadorable/theadorable.c
@@ -10,7 +10,7 @@
 #include <init.h>
 #include <net.h>
 #include <pci.h>
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 #include <bootcount.h>
 #endif
 #include <asm/global_data.h>
@@ -252,7 +252,7 @@ int board_eth_init(struct bd_info *bis)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_BOARD_LATE_INIT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
 {
 	pci_dev_t bdf;
@@ -343,7 +343,7 @@ int board_late_init(void)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_PCI)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_PCI)
 static int pcie_get_link_speed_width(pci_dev_t bdf, int *speed, int *width)
 {
 	struct udevice *dev;
diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile b/board/theobroma-systems/jaguar_rk3588/Makefile
index 532aab01532..d43bf194b68 100644
--- a/board/theobroma-systems/jaguar_rk3588/Makefile
+++ b/board/theobroma-systems/jaguar_rk3588/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y += jaguar_rk3588.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
index edd61a35c1e..2256e72cda1 100644
--- a/board/theobroma-systems/puma_rk3399/Makefile
+++ b/board/theobroma-systems/puma_rk3399/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y	+= puma-rk3399.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
index 45cc65baf9a..4d108f2d011 100644
--- a/board/theobroma-systems/ringneck_px30/Makefile
+++ b/board/theobroma-systems/ringneck_px30/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y	+= ringneck-px30.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
index 5c4c484657a..94b0859eb35 100644
--- a/board/theobroma-systems/tiger_rk3588/Makefile
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y += tiger_rk3588.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 681002ba1da..720bf2cb3e1 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -569,8 +569,8 @@ void sdram_init(void)
 }
 #endif
 
-#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_SPL_BUILD) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD)))
+#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
 static void request_and_set_gpio(int gpio, char *name, int val)
 {
 	int ret;
@@ -707,8 +707,8 @@ int board_init(void)
 	gpmc_init();
 #endif
 
-#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_SPL_BUILD) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD)))
+#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
 	if (board_is_icev2()) {
 		int rv;
 		u32 reg;
@@ -798,7 +798,7 @@ int board_init(void)
 int board_late_init(void)
 {
 	struct udevice *dev;
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	uint8_t mac_addr[6];
 	uint32_t mac_hi, mac_lo;
 #endif
@@ -847,7 +847,7 @@ int board_late_init(void)
 		env_set("boot_fit", "1");
 #endif
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	/* try reading mac address from efuse */
 	mac_lo = readl(&cdev->macid0l);
 	mac_hi = readl(&cdev->macid0h);
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index cc5e64c9879..fc0d87daae4 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -515,7 +515,7 @@ int get_voltrail_opp(int rail_offset)
 	return opp;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* No env to setup for SPL */
 static inline void setup_board_eeprom_env(void) { }
 
@@ -538,7 +538,7 @@ void do_board_detect(void)
 #endif
 }
 
-#else	/* CONFIG_SPL_BUILD */
+#else	/* CONFIG_XPL_BUILD */
 
 /* Override function to read eeprom information: actual i2c read done by SPL*/
 void do_board_detect(void)
@@ -616,7 +616,7 @@ invalid_eeprom:
 	set_board_info_env(name);
 }
 
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
 
 void vcores_init(void)
 {
@@ -783,7 +783,7 @@ int board_late_init(void)
 	if (board_is_bbai())
 		env_set("console", "ttyS0,115200n8");
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	board_ti_set_ethaddr(2);
 #endif
 
@@ -935,7 +935,7 @@ const struct mmc_platform_fixups *platform_fixups_mmc(uint32_t addr)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
 	/* break into full u-boot on 'c' */
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 9bdd0223cdb..1166c9b8e09 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -103,7 +103,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 void spl_board_init(void)
 {
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 609e5cf6d51..00b8317d6bf 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -105,7 +105,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if CONFIG_IS_ENABLED(USB_STORAGE)
 static int fixup_usb_boot(const void *fdt_blob)
 {
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index ea21d48bbc0..a43cc075b92 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -304,7 +304,7 @@ int __maybe_unused ti_i2c_eeprom_am_get(int bus_addr, int dev_addr)
 	struct ti_common_eeprom *ep;
 
 	ep = TI_EEPROM_DATA;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (ep->header == TI_EEPROM_HEADER_MAGIC)
 		return 0; /* EEPROM has already been read */
 #endif
@@ -350,7 +350,7 @@ int __maybe_unused ti_i2c_eeprom_dra7_get(int bus_addr, int dev_addr)
 	struct ti_common_eeprom *ep;
 
 	ep = TI_EEPROM_DATA;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (ep->header == DRA7_EEPROM_HEADER_MAGIC)
 		return 0; /* EEPROM has already been read */
 #endif
@@ -563,7 +563,7 @@ int __maybe_unused ti_i2c_eeprom_am6_get_base(int bus_addr, int dev_addr)
 	 * Always execute EEPROM read by not allowing to bypass it during the
 	 * first invocation of SPL which happens on the R5 core.
 	 */
-#if !(defined(CONFIG_SPL_BUILD) && defined(CONFIG_CPU_V7R))
+#if !(defined(CONFIG_XPL_BUILD) && defined(CONFIG_CPU_V7R))
 	if (ep->header == TI_EEPROM_HEADER_MAGIC) {
 		debug("%s: EEPROM has already been read\n", __func__);
 		return 0;
diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index 2b1db2541b0..98d63e14e29 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -713,7 +713,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void do_board_detect(void)
 {
 	int rc;
@@ -756,7 +756,7 @@ void do_board_detect(void)
 		snprintf(sysinfo.board_string, SYSINFO_BOARD_NAME_MAX_LEN,
 			 "Board: %s REV %s\n", bname, board_ti_get_rev());
 }
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
 
 void vcores_init(void)
 {
@@ -972,7 +972,7 @@ const struct mmc_platform_fixups *platform_fixups_mmc(uint32_t addr)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
 	/* break into full u-boot on 'c' */
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index f3452ff0a8f..6221be9dcff 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -164,7 +164,7 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
+#if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
 					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
@@ -340,7 +340,7 @@ static int probe_daughtercards(void)
 		printf("Detected: %s rev %s\n", ep.name, ep.version);
 		daughter_card_detect_flags[i] = true;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			int j;
 			/*
 			 * Populate any MAC addresses from daughtercard into the U-Boot
@@ -359,7 +359,7 @@ static int probe_daughtercards(void)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		char name_overlays[1024] = { 0 };
 
 		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 5a0281d6b48..2cfeb3bec6c 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -239,7 +239,7 @@ static int probe_daughtercards(void)
 		printf("Detected: %s rev %s\n", ep.name, ep.version);
 		daughter_card_detect_flags[i] = true;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			int j;
 			/*
 			 * Populate any MAC addresses from daughtercard into the U-Boot
@@ -257,7 +257,7 @@ static int probe_daughtercards(void)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		char name_overlays[1024] = { 0 };
 
 		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index c6735d37dda..48547719012 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -75,7 +75,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	spl_init_keystone_plls();
diff --git a/board/ti/ks2_evm/board_k2e.c b/board/ti/ks2_evm/board_k2e.c
index 4385be4221b..3ccf70c5ac7 100644
--- a/board/ti/ks2_evm/board_k2e.c
+++ b/board/ti/ks2_evm/board_k2e.c
@@ -109,7 +109,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index d07b77d23e2..b1142ed5e96 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -346,7 +346,7 @@ int embedded_dtb_select(void)
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_TI_I2C_BOARD_DETECT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_TI_I2C_BOARD_DETECT)
 	int rc;
 
 	rc = ti_i2c_eeprom_am_get(CONFIG_EEPROM_BUS_ADDRESS,
@@ -382,7 +382,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2hk.c b/board/ti/ks2_evm/board_k2hk.c
index 2b5d2d75664..93249fa5f49 100644
--- a/board/ti/ks2_evm/board_k2hk.c
+++ b/board/ti/ks2_evm/board_k2hk.c
@@ -116,7 +116,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2l.c b/board/ti/ks2_evm/board_k2l.c
index 1971bc94f7d..b813f21b682 100644
--- a/board/ti/ks2_evm/board_k2l.c
+++ b/board/ti/ks2_evm/board_k2l.c
@@ -104,7 +104,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/omap3evm/evm.c b/board/ti/omap3evm/evm.c
index 4eb08add256..8803643b032 100644
--- a/board/ti/omap3evm/evm.c
+++ b/board/ti/omap3evm/evm.c
@@ -117,7 +117,7 @@ int spl_start_uboot(void)
 }
 #endif /* CONFIG_SPL_OS_BOOT */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /*
  * Routine: get_board_mem_timings
  * Description: If we use SPL then there is no x-loader nor config header
@@ -150,7 +150,7 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
 	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
 	timings->mr = MICRON_V_MR_165;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /*
  * Routine: misc_init_r
diff --git a/board/timll/devkit8000/devkit8000.c b/board/timll/devkit8000/devkit8000.c
index ad404f7e9c4..a2a3a9489aa 100644
--- a/board/timll/devkit8000/devkit8000.c
+++ b/board/timll/devkit8000/devkit8000.c
@@ -147,7 +147,7 @@ void board_mmc_power_init(void)
 }
 #endif
 
-#if defined(CONFIG_DRIVER_DM9000) & !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DRIVER_DM9000) & !defined(CONFIG_XPL_BUILD)
 /*
  * Routine: board_eth_init
  * Description: Setting up the Ethernet hardware.
diff --git a/board/topic/zynq/Makefile b/board/topic/zynq/Makefile
index cc100b0f422..23a6dd86441 100644
--- a/board/topic/zynq/Makefile
+++ b/board/topic/zynq/Makefile
@@ -6,4 +6,4 @@ obj-y	+= ../../xilinx/common/board.o
 # Remove quotes
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 4a1cfb89345..ec0f223c4aa 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -96,7 +96,7 @@ iomux_v3_cfg_t const uart1_pads_dte[] = {
 	MX6_PAD_CSI0_DAT11__UART1_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* Apalis MMC1 */
 iomux_v3_cfg_t const usdhc1_pads[] = {
 	MX6_PAD_SD1_CLK__SD1_CLK   | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -139,7 +139,7 @@ iomux_v3_cfg_t const usdhc3_pads[] = {
 	MX6_PAD_SD3_DAT7__SD3_DATA7 | MUX_PAD_CTRL(USDHC_EMMC_PAD_CTRL),
 	MX6_PAD_SD3_RST__GPIO7_IO08 | MUX_PAD_CTRL(WEAK_PULLUP) | MUX_MODE_SION,
 };
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int mx6_rgmii_rework(struct phy_device *phydev)
 {
@@ -321,7 +321,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* use the following sequence: eMMC, MMC1, SD1 */
 struct fsl_esdhc_cfg usdhc_cfg[CFG_SYS_FSL_USDHC_NUM] = {
 	{USDHC3_BASE_ADDR},
@@ -391,7 +391,7 @@ int board_mmc_init(struct bd_info *bis)
 
 	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
 }
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int board_phy_config(struct phy_device *phydev)
 {
@@ -748,7 +748,7 @@ void ldo_mode_set(int ldo_bypass)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 #include "asm/arch/mx6q-ddr.h"
@@ -1042,7 +1042,7 @@ void reset_cpu(void)
 {
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static struct mxc_serial_plat mxc_serial_plat = {
 	.reg = (struct mxc_uart *)UART1_BASE,
diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index b404b01e032..698b05bc5ad 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -7,7 +7,7 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
@@ -94,4 +94,4 @@ U_BOOT_CMD(
 	"OTP fusing during module update",
 	"updt_fuse [-n] [-y] - boot cfg fast boot mode fusing"
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/apalis_imx6/pf0100.c b/board/toradex/apalis_imx6/pf0100.c
index 157aaec6fe0..7ea9bbb07ed 100644
--- a/board/toradex/apalis_imx6/pf0100.c
+++ b/board/toradex/apalis_imx6/pf0100.c
@@ -212,7 +212,7 @@ unsigned pmic_init(void)
 	return programmed;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pf0100_prog(void)
 {
 	int rc;
@@ -280,4 +280,4 @@ U_BOOT_CMD(
 	"Program the OTP fuses on the PMIC PF0100",
 	""
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/apalis_t30/Makefile b/board/toradex/apalis_t30/Makefile
index eed607043fc..2d079004c4b 100644
--- a/board/toradex/apalis_t30/Makefile
+++ b/board/toradex/apalis_t30/Makefile
@@ -1,6 +1,6 @@
 # Copyright (c) 2014 Marcel Ziswiler
 # SPDX-License-Identifier:      GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += apalis_t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += apalis_t30-spl.o
 
 obj-y	+= apalis_t30.o
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 251970b99cc..64cf99e9cfc 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -86,7 +86,7 @@ iomux_v3_cfg_t const uart1_pads[] = {
 	MX6_PAD_CSI0_DAT11__UART1_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* Colibri MMC */
 iomux_v3_cfg_t const usdhc1_pads[] = {
 	MX6_PAD_SD1_CLK__SD1_CLK    | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -113,7 +113,7 @@ iomux_v3_cfg_t const usdhc3_pads[] = {
 	MX6_PAD_SD3_DAT7__SD3_DATA7 | MUX_PAD_CTRL(USDHC_EMMC_PAD_CTRL),
 	MX6_PAD_SD3_RST__SD3_RESET  | MUX_PAD_CTRL(USDHC_PAD_CTRL),
 };
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 /* mux auxiliary pins to GPIO, so they can be used from the U-Boot cmdline */
 iomux_v3_cfg_t const gpio_pads[] = {
@@ -289,7 +289,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* use the following sequence: eMMC, MMC */
 struct fsl_esdhc_cfg usdhc_cfg[CFG_SYS_FSL_USDHC_NUM] = {
 	{USDHC3_BASE_ADDR},
@@ -346,7 +346,7 @@ int board_mmc_init(struct bd_info *bis)
 
 	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
 }
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int board_phy_config(struct phy_device *phydev)
 {
@@ -677,7 +677,7 @@ void ldo_mode_set(int ldo_bypass)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 #include "asm/arch/mx6dl-ddr.h"
@@ -1101,7 +1101,7 @@ void reset_cpu(void)
 {
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static struct mxc_serial_plat mxc_serial_plat = {
 	.reg = (struct mxc_uart *)UART1_BASE,
diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index b404b01e032..698b05bc5ad 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -7,7 +7,7 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
@@ -94,4 +94,4 @@ U_BOOT_CMD(
 	"OTP fusing during module update",
 	"updt_fuse [-n] [-y] - boot cfg fast boot mode fusing"
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/colibri_imx6/pf0100.c b/board/toradex/colibri_imx6/pf0100.c
index 58b7bc3bb9a..b5dffc87b35 100644
--- a/board/toradex/colibri_imx6/pf0100.c
+++ b/board/toradex/colibri_imx6/pf0100.c
@@ -197,7 +197,7 @@ unsigned pmic_init(void)
 	return programmed;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pf0100_prog(void)
 {
 	int rc;
@@ -265,4 +265,4 @@ U_BOOT_CMD(
 	"Program the OTP fuses on the PMIC PF0100",
 	""
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/colibri_t30/Makefile b/board/toradex/colibri_t30/Makefile
index 8f333235b17..1cc801c8cfd 100644
--- a/board/toradex/colibri_t30/Makefile
+++ b/board/toradex/colibri_t30/Makefile
@@ -1,6 +1,6 @@
 # Copyright (c) 2013-2014 Stefan Agner
 # SPDX-License-Identifier:      GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += colibri_t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += colibri_t30-spl.o
 
 obj-y	+= colibri_t30.o
diff --git a/board/toradex/common/Makefile b/board/toradex/common/Makefile
index 7b19b6e4c87..7e3905445a5 100644
--- a/board/toradex/common/Makefile
+++ b/board/toradex/common/Makefile
@@ -2,7 +2,7 @@
 # Copyright (c) 2016 Toradex, Inc.
 
 # Common for all Toradex modules
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # Necessary to create built-in.o
 obj- := __dummy__.o
 else
diff --git a/board/toradex/verdin-imx8mm/Makefile b/board/toradex/verdin-imx8mm/Makefile
index b38054254da..eee58aa2f83 100644
--- a/board/toradex/verdin-imx8mm/Makefile
+++ b/board/toradex/verdin-imx8mm/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += verdin-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/toradex/verdin-imx8mp/Makefile b/board/toradex/verdin-imx8mp/Makefile
index 98fa14e4e2a..5edd1778816 100644
--- a/board/toradex/verdin-imx8mp/Makefile
+++ b/board/toradex/verdin-imx8mp/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += verdin-imx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index 4cf214bf17c..bc30bdac462 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -209,7 +209,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #include <linux/libfdt.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/udoo/udoo_spl.c b/board/udoo/udoo_spl.c
index 6c477530055..b845284d688 100644
--- a/board/udoo/udoo_spl.c
+++ b/board/udoo/udoo_spl.c
@@ -23,7 +23,7 @@
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <asm/arch/mx6-ddr.h>
 
 /*
diff --git a/board/variscite/common/imx9_eeprom.c b/board/variscite/common/imx9_eeprom.c
index 32551af5b40..bfa30adc256 100644
--- a/board/variscite/common/imx9_eeprom.c
+++ b/board/variscite/common/imx9_eeprom.c
@@ -83,7 +83,7 @@ int var_eeprom_get_dram_size(struct var_eeprom *ep, phys_size_t *size)
 
 void var_eeprom_print_prod_info(struct var_eeprom *ep)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return;
 
 	flush_dcache_all();
diff --git a/board/variscite/dart_6ul/Makefile b/board/variscite/dart_6ul/Makefile
index 48aa361bf2d..39c3f53e736 100644
--- a/board/variscite/dart_6ul/Makefile
+++ b/board/variscite/dart_6ul/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y  := dart_6ul.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/variscite/imx8mn_var_som/Makefile b/board/variscite/imx8mn_var_som/Makefile
index a8b6a343ffc..36d9c36dd2d 100644
--- a/board/variscite/imx8mn_var_som/Makefile
+++ b/board/variscite/imx8mn_var_som/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_var_som.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += ddr4_timing.o
 endif
diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 532d8d60a76..80c84e64241 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -54,7 +54,7 @@ int board_mmc_get_env_dev(int devno)
 	return devno;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #if defined(CONFIG_DISPLAY_BOARDINFO)
 
@@ -227,4 +227,4 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif /* CONFIG_OF_BOARD_SETUP */
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/variscite/imx93_var_som/Makefile b/board/variscite/imx93_var_som/Makefile
index b63883901bd..8b160f189c1 100644
--- a/board/variscite/imx93_var_som/Makefile
+++ b/board/variscite/imx93_var_som/Makefile
@@ -8,7 +8,7 @@
 obj-y += imx93_var_som.o
 obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += ../common/imx9_eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += lpddr4x_timing.o
 else
diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index f54f183038b..de9f8367d59 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -131,7 +131,7 @@ static int read_eeprom(BSP_VS_HWPARAM *header)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD) || defined(CONFIG_NOR_BOOT)
+#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_NOR_BOOT)
 
 static const struct ddr_data ddr3_baltos_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
@@ -371,8 +371,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -415,10 +415,10 @@ static struct cpsw_platform_data cpsw_data = {
 #endif
 
 #if ((defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)) \
-		&& defined(CONFIG_SPL_BUILD)) || \
+		&& defined(CONFIG_XPL_BUILD)) || \
 	((defined(CONFIG_DRIVER_TI_CPSW) || \
 	  defined(CONFIG_USB_ETHER) && defined(CONFIG_USB_MUSB_GADGET)) && \
-	 !defined(CONFIG_SPL_BUILD))
+	 !defined(CONFIG_XPL_BUILD))
 int board_eth_init(struct bd_info *bis)
 {
 	int rv, n = 0;
@@ -442,8 +442,8 @@ int board_eth_init(struct bd_info *bis)
 	mac_addr[4] = mac_lo & 0xFF;
 	mac_addr[5] = (mac_lo & 0xFF00) >> 8;
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	if (!env_get("ethaddr")) {
 		printf("<ethaddr> not set. Validating first E-fuse MAC\n");
 
diff --git a/board/wandboard/Makefile b/board/wandboard/Makefile
index c3d80536b3a..6e5bcc11630 100644
--- a/board/wandboard/Makefile
+++ b/board/wandboard/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2013 Freescale Semiconductor, Inc.
 
 obj-y  := wandboard.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/wexler/qc750/Makefile b/board/wexler/qc750/Makefile
index 4daefc4159a..5f9ebafd89c 100644
--- a/board/wexler/qc750/Makefile
+++ b/board/wexler/qc750/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2023
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += qc750-spl.o
+obj-$(CONFIG_XPL_BUILD) += qc750-spl.o
 
 obj-y += qc750.o
diff --git a/board/work-microwave/work_92105/Makefile b/board/work-microwave/work_92105/Makefile
index b837e7b0dd8..a96098d0f2a 100644
--- a/board/work-microwave/work_92105/Makefile
+++ b/board/work-microwave/work_92105/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2014  DENX Software Engineering GmbH
 # Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= work_92105_spl.o
 else
 obj-y	+= work_92105.o
diff --git a/board/xilinx/common/Makefile b/board/xilinx/common/Makefile
index d563290ab90..4b8fdec5830 100644
--- a/board/xilinx/common/Makefile
+++ b/board/xilinx/common/Makefile
@@ -8,6 +8,6 @@ obj-y	+= board.o
 ifndef CONFIG_ARCH_ZYNQ
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_FRU) += fru.o fru_ops.o
 endif
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 5e5eb49ddf3..68f401e4b34 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -370,7 +370,7 @@ void *board_fdt_blob_setup(int *err)
 			return fdt_blob;
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    !IS_ENABLED(CONFIG_VERSAL_NO_DDR) &&
 	    !IS_ENABLED(CONFIG_ZYNQMP_NO_DDR)) {
 		fdt_blob = (void *)CONFIG_XILINX_OF_BOARD_DTB_ADDR;
@@ -381,7 +381,7 @@ void *board_fdt_blob_setup(int *err)
 		debug("DTB is not passed via %p\n", fdt_blob);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		/*
 		 * FDT is at end of BSS unless it is in a different memory
 		 * region
@@ -515,7 +515,7 @@ int __maybe_unused board_fit_config_name_match(const char *name)
 {
 	debug("%s: Check %s, default %s\n", __func__, name, board_name);
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	if (IS_ENABLED(CONFIG_REGEX)) {
 		struct slre slre;
 		int ret;
diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
index 2b035d53589..dc4523824b4 100644
--- a/board/xilinx/microblaze-generic/microblaze-generic.c
+++ b/board/xilinx/microblaze-generic/microblaze-generic.c
@@ -40,7 +40,7 @@ int board_late_init(void)
 	ulong max_size;
 	u32 status = 0;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SYSRESET_MICROBLAZE)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SYSRESET_MICROBLAZE)
 	int ret;
 
 	ret = device_bind_driver(gd->dm_root, "mb_soft_reset",
diff --git a/board/xilinx/zynq/Makefile b/board/xilinx/zynq/Makefile
index 85661715891..f40fe382f57 100644
--- a/board/xilinx/zynq/Makefile
+++ b/board/xilinx/zynq/Makefile
@@ -26,17 +26,17 @@ endif
 ifeq ($(init-objs),)
 ifneq ($(wildcard $(srctree)/$(src)/ps7_init_gpl.c),)
 init-objs := ps7_init_gpl.o
-$(if $(CONFIG_SPL_BUILD),\
+$(if $(CONFIG_XPL_BUILD),\
 $(warning Put custom ps7_init_gpl.c/h to board/xilinx/zynq/custom_hw_platform/))
 endif
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ZYNQ) += cmds.o
 obj-$(CONFIG_CMD_ZYNQ_RSA) += bootimg.o
 endif
 
-obj-$(CONFIG_SPL_BUILD) += $(init-objs)
+obj-$(CONFIG_XPL_BUILD) += $(init-objs)
 
 # Suppress "warning: function declaration isn't a prototype"
 CFLAGS_REMOVE_ps7_init_gpl.o := -Wstrict-prototypes
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index b9a91110ff7..a852d5b8ed5 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -27,7 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_DEBUG_UART_BOARD_INIT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_DEBUG_UART_BOARD_INIT)
 void board_debug_uart_init(void)
 {
 	/* Add initialization sequence if UART is not configured */
@@ -36,7 +36,7 @@ void board_debug_uart_init(void)
 
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		printf("Silicon version:\t%d\n", zynq_get_silicon_version());
 
 	if (CONFIG_IS_ENABLED(DM_I2C) && CONFIG_IS_ENABLED(I2C_EEPROM))
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 9ab50eca400..544346d686e 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -26,16 +26,16 @@ endif
 ifeq ($(init-objs),)
 ifneq ($(wildcard $(srctree)/$(src)/psu_init_gpl.c),)
 init-objs := psu_init_gpl.o
-$(if $(CONFIG_SPL_BUILD),\
+$(if $(CONFIG_XPL_BUILD),\
 $(warning Put custom psu_init_gpl.c/h to board/xilinx/zynqmp/custom_hw_platform/))
 endif
 endif
 
 obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifneq ($(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE),"")
-obj-$(CONFIG_SPL_BUILD) += pm_cfg_obj.o
+obj-$(CONFIG_XPL_BUILD) += pm_cfg_obj.o
 $(obj)/pm_cfg_obj.o: $(shell cd $(srctree); readlink -f $(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE)) FORCE
 endif
 endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 20a675c010d..8cdd9d86009 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -86,7 +86,7 @@ int __maybe_unused psu_uboot_init(void)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 # if defined(CONFIG_DEBUG_UART_BOARD_INIT)
 void board_debug_uart_init(void)
 {
@@ -120,7 +120,7 @@ static int multi_boot(void)
 	return multiboot;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static void restore_jtag(void)
 {
 	if (current_el() != 3)
@@ -155,7 +155,7 @@ int board_init(void)
 	int ret;
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	/* Check *at build time* if the filename is an non-empty string */
 	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
 		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
diff --git a/boot/Makefile b/boot/Makefile
index f4675d6ffd5..299a22ed689 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_BOOT_RETRY) += bootretry.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
diff --git a/boot/image-android-dt.c b/boot/image-android-dt.c
index 3b25018c2e7..653835cea76 100644
--- a/boot/image-android-dt.c
+++ b/boot/image-android-dt.c
@@ -72,7 +72,7 @@ bool android_dt_get_fdt_by_index(ulong hdr_addr, u32 index, ulong *addr,
 	return true;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static void android_dt_print_fdt_info(const struct fdt_header *fdt)
 {
 	u32 fdt_size;
diff --git a/boot/image-android.c b/boot/image-android.c
index 774565fd1fe..fdfff58a2a7 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -652,7 +652,7 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
 	return false;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 /**
  * android_print_contents - prints out the contents of the Android format image
  * @hdr: pointer to the Android format image header
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index fe328df4a85..35873b1fb0e 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -48,7 +48,7 @@ struct image_region *fit_region_make_list(const void *fit,
 	 * Use malloc() except in SPL (to save code size). In SPL the caller
 	 * must allocate the array.
 	 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && !region)
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && !region)
 		region = calloc(sizeof(*region), count);
 	if (!region)
 		return NULL;
diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249c..ed62e1c45f8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 # core command
 obj-y += boot.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
@@ -247,7 +247,7 @@ obj-$(CONFIG_ARCH_MVEBU) += mvebu/
 obj-$(CONFIG_ARCH_KEYSTONE) += ti/
 obj-$(CONFIG_ARCH_K3) += ti/
 obj-$(CONFIG_ARCH_OMAP2PLUS) += ti/
-endif # !CONFIG_SPL_BUILD
+endif # !CONFIG_XPL_BUILD
 
 obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 98a687bcabb..74ff5c6fc11 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -49,7 +49,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 #define	MAX_ENV_SIZE	(1 << 20)	/* 1 MiB */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Command interface: print one or all environment variables
  *
@@ -182,9 +182,9 @@ DONE:
 	return 0;
 }
 #endif
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -503,9 +503,9 @@ static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_env_default(struct cmd_tbl *cmdtp, int flag,
 			  int argc, char *const argv[])
 {
@@ -1289,4 +1289,4 @@ U_BOOT_CMD_COMPLETE(
 	var_complete
 );
 #endif
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/common/Makefile b/common/Makefile
index d871113cbb9..9fdad4bc38d 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 # core
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
@@ -42,12 +42,12 @@ obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
 
-endif # !CONFIG_SPL_BUILD
+endif # !CONFIG_XPL_BUILD
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_DFU
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 endif
@@ -58,14 +58,14 @@ obj-$(CONFIG_SPL_USB_STORAGE) += usb_storage.o
 obj-$(CONFIG_SPL_MUSB_NEW) += usb.o
 obj-$(CONFIG_SPL_SPLASH_SCREEN) += splash.o
 obj-$(CONFIG_SPL_SPLASH_SOURCE) += splash_source.o
-endif # CONFIG_SPL_BUILD
+endif # CONFIG_XPL_BUILD
 
 #others
 obj-$(CONFIG_DDR_SPD) += ddr_spd.o
 obj-$(CONFIG_SPD_EEPROM) += ddr_spd.o
 obj-$(CONFIG_HWCONFIG) += hwconfig.o
 obj-$(CONFIG_BOUNCE_BUFFER) += bouncebuf.o
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_TPL_BUILD
 obj-$(CONFIG_TPL_SERIAL) += console.o
 else
@@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_SERIAL) += console.o
 endif
 else
 obj-y += console.o
-endif # CONFIG_SPL_BUILD
+endif # CONFIG_XPL_BUILD
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 4cb82b40149..4e6797a1944 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -73,7 +73,7 @@ static char *delete_char (char *buffer, char *p, int *colp, int *np, int plen)
 #define getcmd_getch()		getchar()
 #define getcmd_cbeep()		getcmd_putch('\a')
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define HIST_MAX		3
 #define HIST_SIZE		32
 #else
diff --git a/common/console.c b/common/console.c
index c9e206aec41..22224701e45 100644
--- a/common/console.c
+++ b/common/console.c
@@ -191,7 +191,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 		/* Assign the new device (leaving the existing one started) */
 		stdio_devices[file] = dev;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		/*
 		 * Update monitor functions
 		 * (to use the console stuff by other applications)
diff --git a/common/hash.c b/common/hash.c
index ac63803fed9..db6925d6782 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -403,7 +403,7 @@ int hash_block(const char *algo_name, const void *data, unsigned int len,
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD) && (defined(CONFIG_CMD_HASH) || \
+#if !defined(CONFIG_XPL_BUILD) && (defined(CONFIG_CMD_HASH) || \
 	defined(CONFIG_CMD_SHA1SUM) || defined(CONFIG_CMD_CRC32)) || \
 	defined(CONFIG_CMD_MD5SUM)
 /**
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 137b18428bd..10528b31a7c 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -6,7 +6,7 @@
 # Based on common/Makefile.
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTROM_SUPPORT) += spl_bootrom.o
 obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += spl_fit.o
diff --git a/common/splash_source.c b/common/splash_source.c
index 5b271160449..f43e7cc1be7 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -215,7 +215,7 @@ static int splash_init_virtio(void)
 	}
 }
 
-#if defined(CONFIG_CMD_UBIFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_UBIFS) && !defined(CONFIG_XPL_BUILD)
 static int splash_mount_ubifs(struct splash_location *location)
 {
 	int res;
diff --git a/config.mk b/config.mk
index b915c29b3f3..e294be2a4c4 100644
--- a/config.mk
+++ b/config.mk
@@ -21,7 +21,7 @@ VENDOR :=
 
 ARCH := $(CONFIG_SYS_ARCH:"%"=%)
 CPU := $(CONFIG_SYS_CPU:"%"=%)
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_ARCH_TEGRA
 CPU := arm720t
 endif
diff --git a/disk/part.c b/disk/part.c
index 706d77b3194..303178161c0 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -482,7 +482,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 #endif
 
-#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	/*
 	 * Special-case ubi, ubi goes through a mtd, rather than through
 	 * a regular block device.
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 09af2aeeb99..96f748702fd 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -100,7 +100,7 @@ static int test_block_type(unsigned char *buffer)
 
 static int part_test_dos(struct blk_desc *desc)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	ALLOC_CACHE_ALIGN_BUFFER(legacy_mbr, mbr,
 			DIV_ROUND_UP(desc->blksz, sizeof(legacy_mbr)));
 
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 9e715b23ebb..637bc27fc2d 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -189,7 +189,7 @@ TO BE UPDATED:
 
 In your board configuration file, include the following::
 
-    #ifndef CONFIG_SPL_BUILD
+    #ifndef CONFIG_XPL_BUILD
     #include <config_distro_bootcmd.h>
     #endif
 
@@ -316,7 +316,7 @@ that it supports the correct set of possible boot device types. To provide this
 configuration, simply define macro BOOT_TARGET_DEVICES prior to including
 <config_distro_bootcmd.h>. For example::
 
-    #ifndef CONFIG_SPL_BUILD
+    #ifndef CONFIG_XPL_BUILD
     #define BOOT_TARGET_DEVICES(func) \
             func(MMC, mmc, 1) \
             func(MMC, mmc, 0) \
diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 123779eab17..a18f32470ca 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -226,7 +226,7 @@ Available options
    Look for moved config options in spl/include/autoconf.mk instead of
    include/autoconf.mk.  This is useful for moving options for SPL build
    because SPL related options (mostly prefixed with CONFIG_SPL\_) are
-   sometimes blocked by CONFIG_SPL_BUILD ifdef conditionals.
+   sometimes blocked by CONFIG_XPL_BUILD ifdef conditionals.
 
  -j, --jobs
    Specify the number of threads to run simultaneously.  If not specified,
diff --git a/doc/develop/tests_sandbox.rst b/doc/develop/tests_sandbox.rst
index 72923070150..0630180bc55 100644
--- a/doc/develop/tests_sandbox.rst
+++ b/doc/develop/tests_sandbox.rst
@@ -278,7 +278,7 @@ Whatever sandbox build is used, which tests are present is determined by which
 source files are built. For sandbox_spl, the of_platdata tests are built
 because of the build rule in test/dm/Makefile::
 
-   ifeq ($(CONFIG_SPL_BUILD),y)
+   ifeq ($(CONFIG_XPL_BUILD),y)
    obj-$(CONFIG_SPL_OF_PLATDATA) += of_platdata.o
    else
    ...other tests for non-spl
diff --git a/drivers/Makefile b/drivers/Makefile
index 1acd94f3c17..1b7db812828 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -47,7 +47,7 @@ obj-y += bus/
 
 ifndef CONFIG_TPL_BUILD
 ifndef CONFIG_VPL_BUILD
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_SPL_CPU) += cpu/
 obj-$(CONFIG_SPL_CRYPTO) += crypto/
@@ -80,7 +80,7 @@ obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 
 endif
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index fe6a1fcf486..a551591fc91 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,7 +9,7 @@ ifndef CONFIG_$(SPL_)BLK
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 0802b9666bf..e14cb7fd9c7 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the bus drivers.
 #
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index bdc7be0fb5d..e1ddd02f356 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -242,7 +242,7 @@ static void clk_basic_init(struct udevice *dev,
 	if (!cfg)
 		return;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* Always force clock manager into boot mode before any configuration */
 	clk_write_ctrl(plat,
 		       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 72b923465df..716c71598bc 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -263,7 +263,7 @@ static void clk_basic_init(struct udevice *dev,
 		clk_write_ctrl(plat,
 			       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
 	} else {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		/* Always force clock manager into boot mode before any configuration */
 		clk_write_ctrl(plat,
 			       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 3e256101a94..09db250ab6d 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -52,7 +52,7 @@ static void clk_basic_init(struct udevice *dev,
 	if (!cfg)
 		return;
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 	/* Always force clock manager into boot mode before any configuration */
 	clk_write_ctrl(plat,
 		       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 16169dac234..a9937c22dcb 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -378,7 +378,7 @@ int clk_set_defaults(struct udevice *dev, enum clk_defaults_stage stage)
 	 * However, still set them for SPL. And still set them if explicitly
 	 * asked.
 	 */
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
 		if (stage != CLK_DEFAULTS_POST_FORCE)
 			return 0;
 
diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
index 2e0e7bbe68f..85ac92c908a 100644
--- a/drivers/clk/clk_vexpress_osc.c
+++ b/drivers/clk/clk_vexpress_osc.c
@@ -37,7 +37,7 @@ static ulong vexpress_osc_clk_get_rate(struct clk *clk)
 	return data;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 {
 	int err;
@@ -64,7 +64,7 @@ static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 
 static struct clk_ops vexpress_osc_clk_ops = {
 	.get_rate = vexpress_osc_clk_get_rate,
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.set_rate = vexpress_osc_clk_set_rate,
 #endif
 };
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index b62b4646f4e..a8505f62bba 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -43,13 +43,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 enum zynq_clk_rclk {mio_clk, emio_clk};
 #endif
 
 struct zynq_clk_priv {
 	ulong ps_clk_freq;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	struct clk gem_emio_clk[2];
 #endif
 };
@@ -75,7 +75,7 @@ static void *zynq_clk_get_register(enum zynq_clk id)
 		return &slcr_base->uart_clk_ctrl;
 	case spi0_clk ... spi1_clk:
 		return &slcr_base->spi_clk_ctrl;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case dci_clk:
 		return &slcr_base->dci_clk_ctrl;
 	case gem0_clk:
@@ -150,7 +150,7 @@ static ulong zynq_clk_get_pll_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 	return priv->ps_clk_freq * mul;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
 {
 	u32 clk_ctrl, srcsel;
@@ -199,7 +199,7 @@ static ulong zynq_clk_get_cpu_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 	return DIV_ROUND_CLOSEST(zynq_clk_get_pll_rate(priv, pll), div);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_ddr2x_rate(struct zynq_clk_priv *priv)
 {
 	u32 clk_ctrl, div;
@@ -223,7 +223,7 @@ static ulong zynq_clk_get_ddr3x_rate(struct zynq_clk_priv *priv)
 	return DIV_ROUND_CLOSEST(zynq_clk_get_pll_rate(priv, ddrpll_clk), div);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_dci_rate(struct zynq_clk_priv *priv)
 {
 	u32 clk_ctrl, div0, div1;
@@ -251,7 +251,7 @@ static ulong zynq_clk_get_peripheral_rate(struct zynq_clk_priv *priv,
 	if (!div0)
 		div0 = 1;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (two_divs) {
 		div1 = (clk_ctrl & CLK_CTRL_DIV1_MASK) >> CLK_CTRL_DIV1_SHIFT;
 		if (!div1)
@@ -268,7 +268,7 @@ static ulong zynq_clk_get_peripheral_rate(struct zynq_clk_priv *priv,
 			div1);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 {
 	struct clk *parent;
@@ -366,7 +366,7 @@ static ulong zynq_clk_set_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id,
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_rate(struct clk *clk)
 {
 	struct zynq_clk_priv *priv = dev_get_priv(clk->dev);
@@ -502,7 +502,7 @@ static void zynq_clk_dump(struct udevice *dev)
 
 static struct clk_ops zynq_clk_ops = {
 	.get_rate = zynq_clk_get_rate,
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.set_rate = zynq_clk_set_rate,
 #endif
 	.enable = dummy_enable,
@@ -514,7 +514,7 @@ static struct clk_ops zynq_clk_ops = {
 static int zynq_clk_probe(struct udevice *dev)
 {
 	struct zynq_clk_priv *priv = dev_get_priv(dev);
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	unsigned int i;
 	char name[16];
 	int ret;
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index a91c6767fac..bb6958f0ec2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -31,7 +31,7 @@ static const char * const imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll1_out", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll3_out", };
@@ -95,7 +95,7 @@ static const char * const imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_
 						     "sys_pll1_160m", "sys_pll1_200m", };
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
@@ -357,7 +357,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MM_CLK_ENET_AXI,
 	       imx8m_clk_composite("enet_axi", imx8mm_enet_axi_sels,
 				   base + 0x8880));
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 125215e84f4..be15ebd0e25 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -37,7 +37,7 @@ static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_2
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll_out", "sys_pll3_out", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll_out", "clk_ext4", };
@@ -97,7 +97,7 @@ static const char * const imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll_out", };
@@ -359,7 +359,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MN_CLK_ENET_REF,
 	       imx8m_clk_composite("enet_ref", imx8mn_enet_ref_sels,
 	       base + 0xa980));
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index c80b02975aa..752434cb0ad 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -124,7 +124,7 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 	clk_dm(IMXRT1020_CLK_SEMC,
 	       imx_clk_gate2("semc", "semc_podf", base + 0x74, 4));
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct clk *clk, *clk1;
 
 	clk_get_by_id(IMXRT1020_CLK_SEMC_SEL, &clk1);
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 754f3948427..788e0650a92 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -180,7 +180,7 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 
 	struct clk *clk, *clk1;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* bypass pll1 before setting its rate */
 	clk_get_by_id(IMXRT1050_CLK_PLL1_REF_SEL, &clk);
 	clk_get_by_id(IMXRT1050_CLK_PLL1_BYPASS, &clk1);
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index d7825c66493..22ede1c38a8 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -989,7 +989,7 @@ static ulong px30_peri_set_clk(struct px30_clk_priv *priv, ulong clk_id,
 	return px30_peri_get_clk(priv, clk_id);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong px30_crypto_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 {
 	struct px30_cru *cru = priv->cru;
@@ -1261,7 +1261,7 @@ static ulong px30_clk_get_rate(struct clk *clk)
 	case HCLK_PERI_PRE:
 		rate = px30_peri_get_clk(priv, clk->id);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_CRYPTO:
 	case SCLK_CRYPTO_APK:
 		rate = px30_crypto_get_clk(priv, clk->id);
@@ -1345,7 +1345,7 @@ static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
 	case HCLK_PERI_PRE:
 		ret = px30_peri_set_clk(priv, clk->id, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_CRYPTO:
 	case SCLK_CRYPTO_APK:
 		ret = px30_crypto_set_clk(priv, clk->id, rate);
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index f569a100f22..d8b03e1d7ab 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -80,7 +80,7 @@ enum {
 		       "divisors on line " __stringify(__LINE__));
 
 /* Keep divisors as low as possible to reduce jitter and power usage */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const struct pll_div gpll_init_cfg = PLL_DIVISORS(GPLL_HZ, 2, 2);
 static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 2);
 #endif
@@ -371,7 +371,7 @@ static ulong rockchip_spi_set_clk(struct rk3188_cru *cru, uint gclk_rate,
 	return rockchip_spi_get_clk(cru, gclk_rate, periph);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void rkclk_init(struct rk3188_cru *cru, struct rk3188_grf *grf,
 		       bool has_bwadj)
 {
@@ -557,7 +557,7 @@ static int rk3188_clk_probe(struct udevice *dev)
 		return PTR_ERR(priv->grf);
 	priv->has_bwadj = (type == RK3188A_CRU) ? 1 : 0;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct rk3188_clk_plat *plat = dev_get_plat(dev);
 
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index 432a79291c8..43c44fadbe7 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -223,7 +223,7 @@ static int rkclk_configure_ddr(struct rockchip_cru *cru, struct rk3288_grf *grf,
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define VCO_MAX_KHZ	2200000
 #define VCO_MIN_KHZ	440000
 #define FREF_MAX_KHZ	2200000
@@ -421,7 +421,7 @@ static ulong rockchip_i2s_set_clk(struct rockchip_cru *cru, uint gclk_rate,
 
 	return rockchip_i2s_get_clk(cru, gclk_rate);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static void rkclk_init(struct rockchip_cru *cru, struct rk3288_grf *grf)
 {
@@ -819,7 +819,7 @@ static ulong rk3288_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI2:
 		new_rate = rockchip_spi_set_clk(cru, gclk_rate, clk->id, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_I2S0:
 		new_rate = rockchip_i2s_set_clk(cru, gclk_rate, rate);
 		break;
@@ -973,7 +973,7 @@ static int rk3288_clk_probe(struct udevice *dev)
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
 		return PTR_ERR(priv->grf);
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct rk3288_clk_plat *plat = dev_get_plat(dev);
 
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 9137dbe69ce..7701a9734ee 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -582,7 +582,7 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
 	return rk3328_spi_get_clk(cru);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_id)
 {
 	struct rk3328_cru *cru = priv->cru;
@@ -746,7 +746,7 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI:
 		ret = rk3328_spi_set_clk(priv->cru, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case DCLK_LCDC:
 	case ACLK_VOP_PRE:
 	case ACLK_VIO_PRE:
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index d8943980521..630253fbb1d 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -50,7 +50,7 @@ struct pll_div {
 		       (_nr * _no) == hz, #hz "Hz cannot be hit with PLL " \
 		       "divisors on line " __stringify(__LINE__));
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static const struct pll_div apll_l_init_cfg = PLL_DIVISORS(APLL_L_HZ, 12, 2);
 static const struct pll_div apll_b_init_cfg = PLL_DIVISORS(APLL_B_HZ, 1, 2);
 #if !defined(CONFIG_TPL_BUILD)
@@ -88,7 +88,7 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 	}
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 			 const struct pll_div *div)
 {
@@ -130,7 +130,7 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static void rkclk_init(struct rk3368_cru *cru)
 {
 	u32 apllb, aplll, dpll, cpll, gpll;
@@ -157,7 +157,7 @@ static void rkclk_init(struct rk3368_cru *cru)
 }
 #endif
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
 {
 	u32 div, con, con_id, rate;
@@ -469,7 +469,7 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 	case SCLK_SPI0 ... SCLK_SPI2:
 		rate = rk3368_spi_get_clk(priv->cru, clk->id);
 		break;
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
 		rate = rk3368_mmc_get_clk(priv->cru, clk->id);
@@ -500,7 +500,7 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 		ret = rk3368_ddr_set_clk(priv->cru, rate);
 		break;
 #endif
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
 		ret = rk3368_mmc_set_clk(clk, rate);
@@ -586,7 +586,7 @@ static int rk3368_clk_probe(struct udevice *dev)
 
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 	rkclk_init(priv->cru);
 #endif
 
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 89924041299..155ea8d6353 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -56,7 +56,7 @@ struct pll_div {
 
 static const struct pll_div gpll_init_cfg = PLL_DIVISORS(GPLL_HZ, 2, 2, 1);
 static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 2, 2);
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static const struct pll_div ppll_init_cfg = PLL_DIVISORS(PPLL_HZ, 2, 2, 1);
 #endif
 
@@ -1464,7 +1464,7 @@ static int rk3399_clk_probe(struct udevice *dev)
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	init_clocks = true;
 #elif CONFIG_IS_ENABLED(HANDOFF)
 	if (!(gd->flags & GD_FLG_RELOC)) {
@@ -1658,7 +1658,7 @@ static struct clk_ops rk3399_pmuclk_ops = {
 	.set_rate = rk3399_pmuclk_set_rate,
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static void pmuclk_init(struct rk3399_pmucru *pmucru)
 {
 	u32 pclk_div;
@@ -1676,7 +1676,7 @@ static void pmuclk_init(struct rk3399_pmucru *pmucru)
 
 static int rk3399_pmuclk_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(OF_PLATDATA) || !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(OF_PLATDATA) || !defined(CONFIG_XPL_BUILD)
 	struct rk3399_pmuclk_priv *priv = dev_get_priv(dev);
 #endif
 
@@ -1686,7 +1686,7 @@ static int rk3399_pmuclk_probe(struct udevice *dev)
 	priv->pmucru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	pmuclk_init(priv->pmucru);
 #endif
 	return 0;
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 35563509d61..977699d509d 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -91,7 +91,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] = {
 		     RK3568_PMU_MODE, 2, 10, 0, rk3568_pll_rates),
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong
 rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
 			ulong pll_id, ulong rate)
@@ -1707,7 +1707,7 @@ static ulong rk3568_emmc_set_bclk(struct rk3568_clk_priv *priv, ulong rate)
 	return rk3568_emmc_get_bclk(priv);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3568_aclk_vop_get_clk(struct rk3568_clk_priv *priv)
 {
 	struct rk3568_cru *cru = priv->cru;
@@ -2413,7 +2413,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 	case TCLK_EMMC:
 		rate = OSC_HZ;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case ACLK_VOP:
 		rate = rk3568_aclk_vop_get_clk(priv);
 		break;
@@ -2594,7 +2594,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	case TCLK_EMMC:
 		ret = OSC_HZ;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case ACLK_VOP:
 		ret = rk3568_aclk_vop_set_clk(priv, rate);
 		break;
@@ -2894,7 +2894,7 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 			priv->gpll_hz = GPLL_HZ;
 	}
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	ret = rk3568_bus_set_clk(priv, ACLK_BUS, 150000000);
 	if (ret < 0)
 		printf("Fail to set the ACLK_BUS clock.\n");
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index db1384dacd2..6042fc10cdb 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -65,7 +65,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
 	 * such only directly accessible during the SPL stage.
@@ -76,7 +76,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  *
  * rational_best_approximation(31415, 10000,
@@ -875,7 +875,7 @@ static ulong rk3588_mmc_set_clk(struct rk3588_clk_priv *priv,
 	return rk3588_mmc_get_clk(priv, clk_id);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3588_aux16m_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 {
 	struct rk3588_cru *cru = priv->cru;
@@ -1600,7 +1600,7 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 	case CLK_GPU:
 		rate = 200000000;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case CLK_AUX16M_0:
 	case CLK_AUX16M_1:
 		rate = rk3588_aux16m_get_clk(priv, clk->id);
@@ -1760,7 +1760,7 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
 	case CLK_150M_SRC:
 		ret = 0;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case CLK_AUX16M_0:
 	case CLK_AUX16M_1:
 		ret = rk3588_aux16m_set_clk(priv, clk->id, rate);
@@ -1965,7 +1965,7 @@ static int rk3588_clk_probe(struct udevice *dev)
 
 	priv->sync_kernel = false;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	rockchip_pll_set_rate(&rk3588_pll_clks[B0PLL], priv->cru,
 			      B0PLL, LPLL_HZ);
 	rockchip_pll_set_rate(&rk3588_pll_clks[B1PLL], priv->cru,
@@ -2051,7 +2051,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
 	.probe		= rk3588_clk_probe,
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SCRU_BASE			0xfd7d0000
 #define SBUSCRU_BASE			0xfd7d8000
 
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index aa26d3a109b..de55504b5c9 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -670,7 +670,7 @@ static int sifive_prci_probe(struct udevice *dev)
 			__prci_wrpll_read_cfg0(pd, pc->pwd);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		if (device_is_compatible(dev, "sifive,fu740-c000-prci")) {
 			u32 prci_pll_reg;
 			unsigned long parent_rate;
diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 581035842fc..6d2bfb3ecb7 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -348,10 +348,10 @@ struct clk *starfive_jh7110_pll(const char *name, const char *parent_name,
 		return ERR_PTR(ret);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && pll->type == PLL0)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && pll->type == PLL0)
 		jh7110_pllx_set_rate(clk, 1000000000);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && pll->type == PLL2)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && pll->type == PLL2)
 		jh7110_pllx_set_rate(clk, 1188000000);
 
 	return clk;
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 204ac170531..4044edfb768 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -26,7 +26,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /* activate clock tree initialization in the driver */
 #define STM32MP1_CLOCK_TREE_INIT
 #endif
@@ -2279,7 +2279,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
 		dev_err(dev, "clock tree initialization failed (%d)\n", result);
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(VERBOSE_DEBUG)
 	/* display debug information for probe after relocation */
 	if (gd->flags & GD_FLG_RELOC)
@@ -2314,7 +2314,7 @@ static const struct clk_ops stm32mp1_clk_ops = {
 	.disable = stm32mp1_clk_disable,
 	.get_rate = stm32mp1_clk_get_rate,
 	.set_rate = stm32mp1_clk_set_rate,
-#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	.dump = stm32mp1_clk_dump,
 #endif
 };
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 7e3b3719d18..129b34a5cd2 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -611,7 +611,7 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
 					   out_values, sz);
 
 		/* get the error right, but space is more important in SPL */
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			if (ret == -FDT_ERR_NOTFOUND)
 				return -EINVAL;
 			else if (ret == -FDT_ERR_BADLAYOUT)
@@ -1468,7 +1468,7 @@ int ofnode_read_simple_size_cells(ofnode node)
 
 bool ofnode_pre_reloc(ofnode node)
 {
-#if defined(CONFIG_SPL_BUILD) || defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_TPL_BUILD)
 	/* for SPL and TPL the remaining nodes after the fdtgrep 1st pass
 	 * had property bootph-all or bootph-pre-sram/bootph-pre-ram.
 	 * They are removed in final dtb (fdtgrep 2nd pass)
diff --git a/drivers/crypto/fsl/jobdesc.c b/drivers/crypto/fsl/jobdesc.c
index 55191736931..9c4ff4960fc 100644
--- a/drivers/crypto/fsl/jobdesc.c
+++ b/drivers/crypto/fsl/jobdesc.c
@@ -207,7 +207,7 @@ void inline_cnstr_jobdesc_hash(uint32_t *desc,
 	append_store(desc, dma_addr_out, storelen,
 		     LDST_CLASS_2_CCB | LDST_SRCDST_BYTE_CONTEXT);
 }
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void inline_cnstr_jobdesc_blob_encap(uint32_t *desc, uint8_t *key_idnfr,
 				     uint8_t *plain_txt, uint8_t *enc_blob,
 				     uint32_t in_sz)
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 27e24808946..c45481bef0b 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -713,7 +713,7 @@ int sec_init_idx(uint8_t sec_idx)
 
 	ccsr_sec_t *sec = caam->sec;
 	uint32_t mcr = sec_in32(&sec->mcfgr);
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_IMX8M)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_IMX8M)
 	uint32_t jrdid_ms = 0;
 #endif
 #ifdef CONFIG_FSL_CORENET
@@ -745,14 +745,14 @@ int sec_init_idx(uint8_t sec_idx)
 	mcr |= (1 << MCFGR_PS_SHIFT);
 #endif
 	sec_out32(&sec->mcfgr, mcr);
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_IMX8M)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_IMX8M)
 	jrdid_ms = JRDID_MS_TZ_OWN | JRDID_MS_PRIM_TZ | JRDID_MS_PRIM_DID;
 	sec_out32(&sec->jrliodnr[caam->jrid].ms, jrdid_ms);
 #endif
 	jr_reset();
 
 #ifdef CONFIG_FSL_CORENET
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * For SPL Build, Set the Liodns in SEC JR0 for
 	 * creating PAMU entries corresponding to these.
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 46c53e7c7a3..3c79bb11802 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -20,7 +20,7 @@
 
 #include "sequencer.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 struct altera_gen5_sdram_priv {
 	struct ram_info info;
@@ -651,4 +651,4 @@ U_BOOT_DRIVER(altera_gen5_sdram) = {
 	.priv_auto	= sizeof(struct altera_gen5_sdram_priv),
 };
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/ddr/fsl/lc_common_dimm_params.c b/drivers/ddr/fsl/lc_common_dimm_params.c
index cc128112e4f..9c5b108267a 100644
--- a/drivers/ddr/fsl/lc_common_dimm_params.c
+++ b/drivers/ddr/fsl/lc_common_dimm_params.c
@@ -409,18 +409,18 @@ compute_lowest_common_dimm_parameters(const unsigned int ctrl_num,
 		if (dimm_params[i].n_ranks) {
 			if (dimm_params[i].registered_dimm) {
 				temp1 = 1;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 				printf("Detected RDIMM %s\n",
 					dimm_params[i].mpart);
 #endif
 			} else {
 				temp2 = 1;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 				printf("Detected UDIMM %s\n",
 					dimm_params[i].mpart);
 #endif
 			}
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 			puts("       ");
 #endif
 		}
diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index 888dfb7ff33..d59e94779ff 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -863,16 +863,16 @@ phys_size_t __fsl_ddr_sdram(fsl_ddr_info_t *pinfo)
 	if ((first_ctrl == 0) && (total_memory - 1 > (phys_size_t)~0ULL)) {
 		puts("Detected ");
 		print_size(total_memory, " of memory\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 		puts("This U-Boot only supports <= ");
 		print_size((unsigned long long)((phys_size_t)~0ULL)+1, " of DDR\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 		puts("You could rebuild it with CONFIG_PHYS_64BIT\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 	}
diff --git a/drivers/ddr/imx/imx8m/Makefile b/drivers/ddr/imx/imx8m/Makefile
index aed91dc23f4..883e6e1b0d7 100644
--- a/drivers/ddr/imx/imx8m/Makefile
+++ b/drivers/ddr/imx/imx8m/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX8M_DRAM) += ddr_init.o
 obj-y += ../phy/
 endif
diff --git a/drivers/ddr/imx/imx8ulp/Makefile b/drivers/ddr/imx/imx8ulp/Makefile
index 7f44a92180f..4f2ad32351c 100644
--- a/drivers/ddr/imx/imx8ulp/Makefile
+++ b/drivers/ddr/imx/imx8ulp/Makefile
@@ -4,6 +4,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX8ULP_DRAM) += ddr_init.o
 endif
diff --git a/drivers/ddr/imx/imx9/Makefile b/drivers/ddr/imx/imx9/Makefile
index 9403f988b32..6c9506055b8 100644
--- a/drivers/ddr/imx/imx9/Makefile
+++ b/drivers/ddr/imx/imx9/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX9_DRAM) += ddr_init.o
 obj-y += ../phy/
 endif
diff --git a/drivers/ddr/imx/phy/Makefile b/drivers/ddr/imx/phy/Makefile
index bb3d4ee5b74..592d0c6ebad 100644
--- a/drivers/ddr/imx/phy/Makefile
+++ b/drivers/ddr/imx/phy/Makefile
@@ -4,6 +4,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o ddrphy_csr.o
 endif
diff --git a/drivers/ddr/marvell/a38x/Makefile b/drivers/ddr/marvell/a38x/Makefile
index 4e8a9d190d7..f49d009920e 100644
--- a/drivers/ddr/marvell/a38x/Makefile
+++ b/drivers/ddr/marvell/a38x/Makefile
@@ -1,29 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_plat.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_sys_env_lib.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_debug.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_bist.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_centralization.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_db.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_hw_algo.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_ip_engine.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_pbs.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_build_message.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_common.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_spd.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_topology.o
-obj-$(CONFIG_SPL_BUILD) += xor.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_plat.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_sys_env_lib.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_debug.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_bist.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_centralization.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_db.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_hw_algo.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_ip_engine.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_pbs.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_build_message.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_common.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_spd.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_topology.o
+obj-$(CONFIG_XPL_BUILD) += xor.o
 
 obj-$(CONFIG_ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING) += old/
 
 ifdef CONFIG_DDR4
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_mpr_pda_if.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_calibration.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_db.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_leveling.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_mpr_pda_if.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_calibration.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_db.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_leveling.o
 endif
diff --git a/drivers/ddr/marvell/a38x/old/Makefile b/drivers/ddr/marvell/a38x/old/Makefile
index 1645a79b405..c9bc746cc2b 100644
--- a/drivers/ddr/marvell/a38x/old/Makefile
+++ b/drivers/ddr/marvell/a38x/old/Makefile
@@ -2,20 +2,20 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-obj-$(CONFIG_SPL_BUILD) += ddr3_a38x.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_a38x_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_debug.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_hws_hw_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_bist.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_centralization.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_db.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_hw_algo.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_ip_engine.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_pbs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_static.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_a38x.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_a38x_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_debug.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_hws_hw_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_bist.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_centralization.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_db.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_hw_algo.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_ip_engine.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_pbs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_static.o
 
 define IncludeSymbolRename
   CFLAGS_$(1) = -include $(srctree)/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
diff --git a/drivers/ddr/marvell/axp/Makefile b/drivers/ddr/marvell/axp/Makefile
index d04d9a21db2..01e427296e6 100644
--- a/drivers/ddr/marvell/axp/Makefile
+++ b/drivers/ddr/marvell/axp/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += ddr3_dfs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_dqs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_hw_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_pbs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_read_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_sdram.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_spd.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_write_leveling.o
-obj-$(CONFIG_SPL_BUILD) += xor.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_dfs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_dqs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_hw_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_pbs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_read_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_sdram.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_spd.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_write_leveling.o
+obj-$(CONFIG_XPL_BUILD) += xor.o
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f99507d86c6..4b1b80d7abe 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -260,7 +260,7 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 	int err;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
 
 	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
@@ -282,7 +282,7 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 	if (ret_payload[0])
 		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
 
-	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_SPL_BUILD))
+	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
 		panic("PMUFW config object loading failed in EL3\n");
 
 	return 0;
@@ -354,7 +354,7 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 	debug("%s at EL%d, API ID: 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x\n",
 	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 #if defined(CONFIG_ZYNQMP_IPI)
 		/*
 		 * Use fixed payload and arg size as the EL2 call. The firmware
@@ -416,10 +416,10 @@ static int zynqmp_firmware_bind(struct udevice *dev)
 	int ret;
 	struct udevice *child;
 
-	if ((IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
 	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
 	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
-	     (!IS_ENABLED(CONFIG_SPL_BUILD) &&
+	     (!IS_ENABLED(CONFIG_XPL_BUILD) &&
 	      IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN))) {
 		ret = device_bind_driver_to_node(dev, "zynqmp_power_domain",
 						 "zynqmp_power_domain",
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 45caef4f5c1..5a65bd98779 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -17,7 +17,7 @@
 #define RECONFIG_STATUS_POLL_RESP_TIMEOUT_MS		60000
 #define RECONFIG_STATUS_INTERVAL_DELAY_US		1000000
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 
 #define BITSTREAM_CHUNK_SIZE				0xFFFF0
 #define RECONFIG_STATUS_POLL_RETRY_MAX			100
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index 57467b4d975..3e86d854a01 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -414,13 +414,13 @@ static int zynq_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	if (bstype != BIT_PARTIAL)
 		zynq_slcr_devcfg_enable();
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		puts("INFO:post config was not run, please run manually if needed\n");
 
 	return FPGA_SUCCESS;
 }
 
-#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_XPL_BUILD)
 static int zynq_loadfs(xilinx_desc *desc, const void *buf, size_t bsize,
 		       fpga_fs_info *fsinfo)
 {
@@ -504,7 +504,7 @@ static int zynq_loadfs(xilinx_desc *desc, const void *buf, size_t bsize,
 
 struct xilinx_fpga_op zynq_op = {
 	.load = zynq_load,
-#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_XPL_BUILD)
 	.loadfs = zynq_loadfs,
 #endif
 };
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index da0faf05246..990a670dd7b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -3,7 +3,7 @@
 # Copyright 2000-2008
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
 obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 92ce68dd4a1..0213271e3a6 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -412,7 +412,7 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 
 static int dm_gpio_requestf(struct gpio_desc *desc, const char *fmt, ...)
 {
-#if !defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if !defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	va_list args;
 	char buf[40];
 
@@ -461,7 +461,7 @@ int gpio_request(unsigned gpio, const char *label)
  */
 int gpio_requestf(unsigned gpio, const char *fmt, ...)
 {
-#if !defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if !defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	va_list args;
 	char buf[40];
 
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index fc4dcf9f986..2fb14590c0f 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -143,7 +143,7 @@ int pca953x_get_val(uint8_t chip)
 	return (int)val;
 }
 
-#if defined(CONFIG_CMD_PCA953X) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_PCA953X) && !defined(CONFIG_XPL_BUILD)
 /*
  * Display pca953x information
  */
diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 24ba12dd820..57c49c75939 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -126,7 +126,7 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 }
 
 /* Simple SPL interface to GPIOs */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 enum {
 	PULL_NONE_1V8 = 0,
@@ -169,7 +169,7 @@ int spl_gpio_output(void *vregs, uint gpio, int value)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static int rockchip_gpio_probe(struct udevice *dev)
 {
diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
index 83e65aa4aec..53dbbe97b5a 100644
--- a/drivers/gpio/s5p_gpio.c
+++ b/drivers/gpio/s5p_gpio.c
@@ -92,7 +92,7 @@ static void s5p_gpio_set_value(struct s5p_gpio_bank *bank, int gpio, int en)
 	writel(value, &bank->dat);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* Common GPIO API - SPL does not support driver model yet */
 int gpio_set_value(unsigned gpio, int value)
 {
@@ -118,7 +118,7 @@ static unsigned int s5p_gpio_get_value(struct s5p_gpio_bank *bank, int gpio)
 	value = readl(&bank->dat);
 	return !!(value & DAT_MASK(gpio));
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static void s5p_gpio_set_pull(struct s5p_gpio_bank *bank, int gpio, int mode)
 {
@@ -185,7 +185,7 @@ int s5p_gpio_get_pin(unsigned gpio)
 }
 
 /* Driver model interface */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* set GPIO pin 'gpio' as an input */
 static int exynos_gpio_direction_input(struct udevice *dev, unsigned offset)
 {
@@ -230,7 +230,7 @@ static int exynos_gpio_set_value(struct udevice *dev, unsigned offset,
 
 	return 0;
 }
-#endif /* nCONFIG_SPL_BUILD */
+#endif /* nCONFIG_XPL_BUILD */
 
 /*
  * There is no common GPIO API for pull, drv, pin, rate (yet). These
@@ -260,7 +260,7 @@ void gpio_set_rate(int gpio, int mode)
 			  s5p_gpio_get_pin(gpio), mode);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int exynos_gpio_get_function(struct udevice *dev, unsigned offset)
 {
 	struct exynos_bank_info *state = dev_get_priv(dev);
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 218ca2af397..2ca4960f17a 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -245,7 +245,7 @@ int sunxi_name_to_gpio(const char *name)
 {
 	unsigned int gpio;
 	int ret;
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
+#if !defined CONFIG_XPL_BUILD && defined CONFIG_AXP_GPIO
 	char lookup[8];
 
 	if (strcasecmp(name, "AXP0-VBUS-ENABLE") == 0) {
diff --git a/drivers/gpio/tca642x.c b/drivers/gpio/tca642x.c
index 1d45b500746..8307a07e14e 100644
--- a/drivers/gpio/tca642x.c
+++ b/drivers/gpio/tca642x.c
@@ -164,7 +164,7 @@ int tca642x_set_inital_state(uchar chip, struct tca642x_bank_info init_data[])
 	return ret;
 }
 
-#if defined(CONFIG_CMD_TCA642X) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_TCA642X) && !defined(CONFIG_XPL_BUILD)
 /*
  * Display tca642x information
  */
diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
index 0c40d36c41e..6cafffaad92 100644
--- a/drivers/gpio/tegra_gpio.c
+++ b/drivers/gpio/tegra_gpio.c
@@ -323,7 +323,7 @@ static int gpio_tegra_bind(struct udevice *parent)
 		return 0;
 
 	/* TODO(sjg@chromium.org): Remove once SPL supports device tree */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	ctlr = (struct gpio_ctlr *)NV_PA_GPIO_BASE;
 	bank_count = TEGRA_GPIO_BANKS;
 #else
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 71f315adf6f..3e855346bce 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(SPL_TPL_)OF_CONTROL) += key_matrix.o
 obj-$(CONFIG_$(SPL_TPL_)DM_KEYBOARD) += input.o keyboard-uclass.o
 obj-$(CONFIG_BUTTON_KEYBOARD) += button_kbd.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_APPLE_SPI_KEYB) += apple_spi_kbd.o
 obj-$(CONFIG_I8042_KEYB) += i8042.o
diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 4df69734ed9..713d93a200c 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -108,7 +108,7 @@ static int zynqmp_ipi_send(struct mbox_chan *chan, const void *data)
 		writel(msg->buf[i], &mbx[i]);
 
 	/* Use SMC calls for Exception Level less than 3 where TF-A is available */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && current_el() < 3) {
 		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_NOTIFY, 0);
 
 		debug("%s, send %ld bytes\n", __func__, msg->len);
@@ -148,7 +148,7 @@ static int zynqmp_ipi_recv(struct mbox_chan *chan, void *data)
 		msg->buf[i] = readl(&mbx[i]);
 
 	/* Ack to remote if EL is not 3 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && current_el() < 3) {
 		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_ACK,
 					 IPI_SMC_ACK_EIRQ_MASK);
 	}
@@ -168,7 +168,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 
 	node = dev_ofnode(dev);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
 		zynqmp->el3_supported = true;
 
 	ret = dev_read_u32(dev->parent, "xlnx,ipi-id", &zynqmp->local_id);
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..51ef51f1ed3 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_$(SPL_TPL_)CROS_EC) += cros_ec.o
 obj-$(CONFIG_$(SPL_TPL_)CROS_EC_SANDBOX) += cros_ec_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)CROS_EC_LPC) += cros_ec_lpc.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += sandbox_adder.o
 obj-$(CONFIG_CROS_EC_I2C) += cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI) += cros_ec_spi.o
@@ -19,13 +19,13 @@ obj-$(CONFIG_SANDBOX) += swap_case.o
 endif
 
 ifdef CONFIG_$(SPL_)DM_I2C
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += i2c_eeprom_emul.o
 obj-$(CONFIG_USB_HUB_USB251XB) += usb251xb.o
 endif
 endif
 ifdef CONFIG_SPL_OF_PLATDATA
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += spltest_sandbox.o
 endif
 endif
diff --git a/drivers/misc/gsc.c b/drivers/misc/gsc.c
index feb02f97065..dee0bdd9663 100644
--- a/drivers/misc/gsc.c
+++ b/drivers/misc/gsc.c
@@ -389,7 +389,7 @@ static int gsc_probe(struct udevice *dev)
 	if (priv->rtc)
 		dev_set_priv(priv->rtc, priv);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	gsc_banner(dev);
 #endif
 
diff --git a/drivers/misc/imx8/scu.c b/drivers/misc/imx8/scu.c
index bbd7e24200b..5d3db0bc4df 100644
--- a/drivers/misc/imx8/scu.c
+++ b/drivers/misc/imx8/scu.c
@@ -191,7 +191,7 @@ static int imx8_scu_probe(struct udevice *dev)
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	plat->base = (struct mu_type *)CONFIG_MU_BASE_SPL;
 #else
 	plat->base = (struct mu_type *)addr;
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 235c477c2e0..952201923d8 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -20,7 +20,7 @@ endif
 
 obj-$(CONFIG_SUPPORT_EMMC_BOOT) += mmc_boot.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_MMC_BOOT) += fsl_esdhc_spl.o
 endif
 
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 83cdc9fd66d..c8db4f811c2 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -301,7 +301,7 @@ struct mmc *find_mmc_device(int dev_num)
 	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
 
 	if (ret) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		printf("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
@@ -373,7 +373,7 @@ void mmc_do_preinit(void)
 	}
 }
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct udevice *dev;
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 96b0e20d669..55d24451e6e 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -328,7 +328,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 			break;
 
 		if (status & MMC_STATUS_MASK) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("Status Error: %#08x\n", status);
 #endif
 			return -ECOMM;
@@ -341,7 +341,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 	}
 
 	if (timeout_ms <= 0) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("Timeout waiting card ready\n");
 #endif
 		return -ETIMEDOUT;
@@ -483,7 +483,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 
 	if (blkcnt > 1) {
 		if (mmc_send_stop_transmission(mmc, false)) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
 #endif
 			return 0;
@@ -534,7 +534,7 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 		return 0;
 
 	if ((start + blkcnt) > block_dev->lba) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
 			start + blkcnt, block_dev->lba);
 #endif
@@ -2424,7 +2424,7 @@ static int mmc_startup_v4(struct mmc *mmc)
 		mmc->capacity_gp[i] <<= 19;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (part_completed) {
 		mmc->enh_user_size =
 			(ext_csd[EXT_CSD_ENH_SIZE_MULT + 2] << 16) +
@@ -2723,7 +2723,7 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->blksz = mmc->read_bl_len;
 	bdesc->log2blksz = LOG2(bdesc->blksz);
 	bdesc->lba = lldiv(mmc->capacity, mmc->read_bl_len);
-#if !defined(CONFIG_SPL_BUILD) || \
+#if !defined(CONFIG_XPL_BUILD) || \
 		(defined(CONFIG_SPL_LIBCOMMON_SUPPORT) && \
 		!CONFIG_IS_ENABLED(USE_TINY_PRINTF))
 	sprintf(bdesc->vendor, "Man %06x Snr %04x%04x",
@@ -2741,7 +2741,7 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->revision[0] = 0;
 #endif
 
-#if !defined(CONFIG_DM_MMC) && (!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBDISK_SUPPORT))
+#if !defined(CONFIG_DM_MMC) && (!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBDISK_SUPPORT))
 	part_init(bdesc);
 #endif
 
@@ -2953,7 +2953,7 @@ retry:
 		err = mmc_send_op_cond(mmc);
 
 		if (err) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			if (!quiet)
 				log_err("Card did not respond to voltage select! : %d\n",
 					err);
@@ -3008,7 +3008,7 @@ int mmc_start_init(struct mmc *mmc)
 #endif
 	if (no_card) {
 		mmc->has_init = 0;
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
@@ -3195,7 +3195,7 @@ int mmc_initialize(struct bd_info *bis)
 	if (ret)
 		return ret;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	print_mmc_devices(',');
 #endif
 
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index a87d2276c1b..8f8ba34be71 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -44,7 +44,7 @@ struct mmc *find_mmc_device(int dev_num)
 			return m;
 	}
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 	printf("MMC Device %d not found\n", dev_num);
 #endif
 
@@ -93,7 +93,7 @@ void mmc_list_add(struct mmc *mmc)
 	list_add_tail(&mmc->link, &mmc_devices);
 }
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct mmc *m;
diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
index b32123758ea..fc45f017e5d 100644
--- a/drivers/mmc/mmc_private.h
+++ b/drivers/mmc/mmc_private.h
@@ -67,7 +67,7 @@ static inline ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start,
 }
 #endif
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_MMC_TRACE
 void mmmc_trace_before_send(struct mmc *mmc, struct mmc_cmd *cmd);
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index 8e51453d2ae..e66ab25d02a 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -59,8 +59,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* simplify defines to OMAP_HSMMC_USE_GPIO */
-#if (defined(CONFIG_OMAP_GPIO) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+#if (defined(CONFIG_OMAP_GPIO) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 #define OMAP_HSMMC_USE_GPIO
 #else
 #undef OMAP_HSMMC_USE_GPIO
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index fb77b049834..ca5752d24f1 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -83,7 +83,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	priv->fifo_mode = dev_read_bool(dev, "fifo-mode");
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	if (!priv->fifo_mode)
 		priv->fifo_mode = dev_read_bool(dev, "u-boot,spl-fifo-mode");
 #endif
diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 35667b86b50..a25bcaf017f 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -609,7 +609,7 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 	 * Disable use of DMA and force use of PIO mode in SPL to fix an issue
 	 * where loading part of TF-A into SRAM using DMA silently fails.
 	 */
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
 		host->flags &= ~USE_DMA;
 
diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 3147d3019c0..9dc1ceaa09b 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -61,7 +61,7 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 	debug("%s: drvsel %d smplsel %d\n", __func__,
 	      priv->drvsel, priv->smplsel);
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	int ret;
 
 	ret = socfpga_secure_reg_write32(SOCFPGA_SECURE_REG_SYSMGR_SOC64_SDMMC,
diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
index 0b396122b46..9fff1bc1a10 100644
--- a/drivers/mmc/tmio-common.c
+++ b/drivers/mmc/tmio-common.c
@@ -385,7 +385,7 @@ static bool tmio_sd_addr_is_dmaable(struct mmc_data *data)
 			return false;
 	}
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	if (IS_ENABLED(CONFIG_ARCH_UNIPHIER) && !IS_ENABLED(CONFIG_ARM64)) {
 		/*
 		 * For UniPhier ARMv7 SoCs, the stack is allocated in locked
diff --git a/drivers/mmc/uniphier-sd.c b/drivers/mmc/uniphier-sd.c
index 5b3650d52ee..cc89ff767ab 100644
--- a/drivers/mmc/uniphier-sd.c
+++ b/drivers/mmc/uniphier-sd.c
@@ -36,7 +36,7 @@ static ulong uniphier_sd_clk_get_rate(struct tmio_sd_priv *priv)
 {
 #if CONFIG_IS_ENABLED(CLK)
 	return clk_get_rate(&priv->clk);
-#elif CONFIG_SPL_BUILD
+#elif CONFIG_XPL_BUILD
 	return 100000000;
 #else
 	return 0;
@@ -50,7 +50,7 @@ static int uniphier_sd_probe(struct udevice *dev)
 	priv->clk_get_rate = uniphier_sd_clk_get_rate;
 	priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD2;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int ret;
 
 	ret = clk_get_by_index(dev, 0, &priv->clk);
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 24d0556cd37..0e2bdab4e7e 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -289,7 +289,7 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0) {
 			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN,
 						SD0_ITAPCHGWIN);
@@ -339,7 +339,7 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 
 static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0)
 			return zynqmp_mmio_write(SD_OTAP_DLY,
 						 SD0_OTAPDLYSEL_MASK,
@@ -356,7 +356,7 @@ static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 
 static inline int zynqmp_dll_reset(u32 node_id, u32 type)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0)
 			return zynqmp_mmio_write(SD_DLL_CTRL, SD0_DLL_RST,
 						 type == PM_DLL_RESET_ASSERT ?
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 10d575e9f93..db010417b86 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -16,7 +16,7 @@ mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
 ifneq ($(mtd-y),)
 obj-y += mtd.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a1..68b53dced1b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 46fead6fa48..ca10ac7aecb 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 ifdef CONFIG_SPL_NAND_DRIVERS
 NORMAL_DRIVERS=y
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 4dbf7b47135..605298628d6 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -1251,7 +1251,7 @@ static int at91_nand_ready(struct mtd_info *mtd)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* The following code is for SPL */
 static struct mtd_info *mtd;
 static struct nand_chip nand_chip;
@@ -1526,4 +1526,4 @@ void board_nand_init(void)
 		if (atmel_nand_chip_init(i, base_addr[i]))
 			log_err("atmel_nand: Fail to initialize #%d chip", i);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index c89661badbf..4430c4e93ee 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -152,7 +152,7 @@ static void lpc32xx_nand_init(void)
 		&lpc32xx_nand_mlc_registers->time_reg);
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 /**
  * lpc32xx_cmd_ctrl - write command to either cmd or data register
@@ -606,7 +606,7 @@ void board_nand_init(void)
 		pr_err("nand_register returned %i", ret);
 }
 
-#else /* defined(CONFIG_SPL_BUILD) */
+#else /* defined(CONFIG_XPL_BUILD) */
 
 void nand_init(void)
 {
@@ -770,4 +770,4 @@ unsigned int nand_page_size(void)
 	return BYTES_PER_PAGE;
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
index 4d643bc64bc..109c31fb4d1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
@@ -84,7 +84,7 @@ static struct nand_ecclayout lpc32xx_nand_oob_16 = {
 	}
 };
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 #define ECCSTEPS	(CONFIG_SYS_NAND_PAGE_SIZE / CFG_SYS_NAND_ECCSIZE)
 
 /*
@@ -162,7 +162,7 @@ static int lpc32xx_nand_dev_ready(struct mtd_info *mtd)
 	return readl(&lpc32xx_nand_slc_regs->stat) & STAT_NAND_READY;
 }
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 /*
  * Prepares DMA descriptors for NAND RD/WR operations
  * If the size is < 256 Bytes then it is assumed to be
@@ -510,7 +510,7 @@ static void lpc32xx_write_byte(struct mtd_info *mtd, uint8_t byte)
  */
 int board_nand_init(struct nand_chip *lpc32xx_chip)
 {
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 	int ret;
 
 	/* Acquire a channel for our use */
@@ -533,7 +533,7 @@ int board_nand_init(struct nand_chip *lpc32xx_chip)
 	lpc32xx_chip->read_byte  = lpc32xx_read_byte;
 	lpc32xx_chip->write_byte = lpc32xx_write_byte;
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 	/* Hardware ECC calculation is supported when DMA driver is selected */
 	lpc32xx_chip->ecc.mode		= NAND_ECC_HW;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0545c23e268..1b65c6f6443 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -414,7 +414,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret = 0;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int res;
 #endif
 
@@ -434,7 +434,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 		nand_release_device(mtd);
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Mark block bad in BBT */
 	if (chip->bbt) {
 		res = nand_markbad_bbt(mtd, ofs);
@@ -488,7 +488,7 @@ static int nand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 	if (!chip->bbt)
 		return 0;
 	/* Return info from the table */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return nand_isreserved_bbt(mtd, ofs);
 #else
 	return 0;
@@ -518,7 +518,7 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 		return chip->block_bad(mtd, ofs);
 
 	/* Return info from the table */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return nand_isbad_bbt(mtd, ofs, allowbbt);
 #else
 	return 0;
@@ -3729,7 +3729,7 @@ static void nand_set_defaults(struct nand_chip *chip, int busw)
 	if (!chip->read_buf || chip->read_buf == nand_read_buf)
 		chip->read_buf = busw ? nand_read_buf16 : nand_read_buf;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (!chip->scan_bbt)
 		chip->scan_bbt = nand_default_bbt;
 #endif
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index a36e2a148cc..9c704c60e8e 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -1011,7 +1011,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * omap_nand_switch_ecc - switch the ECC operation between different engines
  * (h/w and s/w) and different algorithms (hamming and BCHx)
@@ -1072,7 +1072,7 @@ int __maybe_unused omap_nand_switch_ecc(uint32_t hardware, uint32_t eccstrength)
 		err = nand_scan_tail(mtd);
 	return err;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /*
  * Board-specific NAND initialization. The following members of the
diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
index 229d7b5b65a..53489223030 100644
--- a/drivers/mtd/nand/raw/sand_nand.c
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -680,7 +680,7 @@ void board_nand_init(void)
 		log_info("Failed to get sandbox NAND: %d\n", err);
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_NAND_INIT)
+#if IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_NAND_INIT)
 void nand_deselect(void)
 {
 	nand_chip->select_chip(nand_to_mtd(nand_chip), -1);
diff --git a/drivers/mtd/onenand/Makefile b/drivers/mtd/onenand/Makefile
index 4dc417a5794..7f4a8514c17 100644
--- a/drivers/mtd/onenand/Makefile
+++ b/drivers/mtd/onenand/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2005-2007 Samsung Electronics.
 # Kyungmin Park <kyungmin.park@samsung.com>
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ONENAND)	:= onenand_uboot.o onenand_base.o onenand_bbt.o
 obj-$(CONFIG_SAMSUNG_ONENAND)	+= samsung.o
 else
diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 409395382f5..2a287a62a47 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_$(SPL_TPL_)DM_SPI_FLASH) += sf-uclass.o
 spi-nor-y := sf_probe.o spi-nor-ids.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_SPI_BOOT)	+= fsl_espi_spl.o
 ifeq ($(CONFIG_$(SPL_TPL_)SPI_FLASH_TINY),y)
 spi-nor-y += spi-nor-tiny.o
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index a4d15bd64aa..102a9236826 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -54,7 +54,7 @@ struct spi_flash *spi_flash_probe(unsigned int busnum, unsigned int cs,
 	struct udevice *bus;
 	char *str;
 
-#if defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	str = "spi_flash";
 #else
 	char name[30];
diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 6db24189c8e..438eb3698d5 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -438,7 +438,7 @@ static int add_dataflash(struct udevice *dev, char *name, int nr_pages,
 	spi_flash->size = nr_pages * pagesize;
 	spi_flash->erase_size = pagesize;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	printf("SPI DataFlash: Detected %s with page size ", spi_flash->name);
 	print_size(spi_flash->page_size, ", erase size ");
 	print_size(spi_flash->erase_size, ", total ");
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8f7a77e7169..b29b390a0ae 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1030,7 +1030,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	while (len) {
 		schedule();
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc()) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc()) {
 			addr_known = false;
 			ret = -EINTR;
 			goto erase_err;
@@ -4262,7 +4262,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	nor->erase_size = mtd->erasesize;
 	nor->sector_size = mtd->erasesize;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	printf("SF: Detected %s with page size ", nor->name);
 	print_size(nor->page_size, ", erase size ");
 	print_size(nor->erase_size, ", total ");
diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c b/drivers/net/dwc_eth_xgmac_socfpga.c
index 270c1b0ca6c..87fb7e887e7 100644
--- a/drivers/net/dwc_eth_xgmac_socfpga.c
+++ b/drivers/net/dwc_eth_xgmac_socfpga.c
@@ -37,7 +37,7 @@ static int dwxgmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
 	u32 modemask = SYSMGR_EMACGRP_CTRL_PHYSEL_MASK <<
 		       xgmac->syscon_phy_regshift;
 
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
 		u32 index = ((u64)xgmac->syscon_phy - socfpga_get_sysmgr_addr() -
 			     SYSMGR_SOC64_EMAC0) >> 2;
 
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index bba3fc4d34b..a9e2d8c0972 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -68,7 +68,7 @@ static int dwmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
 	struct dwmac_socfpga_plat *pdata = dev_get_plat(dev);
 	u32 modemask = SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << pdata->reg_shift;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	u32 index = ((u64)pdata->phy_intf - socfpga_get_sysmgr_addr() -
 		     SYSMGR_SOC64_EMAC0) >> 2;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ede3959c94f..2c373c7c12e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -671,7 +671,7 @@ const struct pinctrl_ops mtk_pinctrl_ops = {
 };
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \
-    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+    (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 static int mtk_gpio_get(struct udevice *dev, unsigned int off)
 {
 	int val, err;
@@ -814,7 +814,7 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 	}
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \
-    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+    (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 	ret = mtk_gpiochip_register(dev);
 #endif
 
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index eada1001240..fbf0271f08a 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -39,7 +39,7 @@ struct stm32_gpio_bank {
 	struct list_head list;
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 static char pin_name[PINNAME_SIZE];
 static const char * const pinmux_mode[GPIOF_COUNT] = {
@@ -488,7 +488,7 @@ static struct pinctrl_ops stm32_pinctrl_ops = {
 #else /* PINCTRL_FULL */
 	.set_state_simple	= stm32_pinctrl_set_state_simple,
 #endif /* PINCTRL_FULL */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.get_pin_name		= stm32_pinctrl_get_pin_name,
 	.get_pins_count		= stm32_pinctrl_get_pins_count,
 	.get_pin_muxing		= stm32_pinctrl_get_pin_muxing,
diff --git a/drivers/pinctrl/tegra/Makefile b/drivers/pinctrl/tegra/Makefile
index 75d3cabc62b..b1dda417475 100644
--- a/drivers/pinctrl/tegra/Makefile
+++ b/drivers/pinctrl/tegra/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_TEGRA20
 obj-y += pinctrl-tegra20.o
 else
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 5951835d6e8..da7bb4f6377 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -126,7 +126,7 @@ struct uniphier_pinctrl_socdata {
 
 #define __UNIPHIER_PINMUX_FUNCTION(func)	#func
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * a tricky way to drop unneeded *_pins and *_muxvals arrays from SPL,
 	 * suppressing "defined but not used" warnings.
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 6f7e6fb0a6b..5a987194cda 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -9,7 +9,7 @@ obj-y += pmic/
 obj-y += regulator/
 
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_AXP152_POWER)	+= axp152.o
 obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP305_POWER)	+= axp_spl.o
diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 4d5a5ceafad..a14555cf472 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -237,7 +237,7 @@ static int rk8xx_bind(struct udevice *dev)
 	if (!children)
 		debug("%s: %s - no child found\n", __func__, dev->name);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    IS_ENABLED(CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
@@ -331,7 +331,7 @@ static int rk8xx_probe(struct udevice *dev)
 		      pmic_reg_read(dev, init_data[i].reg));
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		printf("PMIC:  RK%x ", show_variant);
 		if (on_source && off_source)
 			printf("(on=0x%02x, off=0x%02x)",
diff --git a/drivers/power/pmic/stpmic1.c b/drivers/power/pmic/stpmic1.c
index c99a0c27b33..f0415fbd172 100644
--- a/drivers/power/pmic/stpmic1.c
+++ b/drivers/power/pmic/stpmic1.c
@@ -91,7 +91,7 @@ static int stpmic1_bind(struct udevice *dev)
 		dev_dbg(dev, "no child found\n");
 #endif /* DM_REGULATOR */
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		ret = device_bind_driver(dev, "stpmic1-nvm",
 					 "stpmic1-nvm", NULL);
 		if (ret)
@@ -124,7 +124,7 @@ U_BOOT_DRIVER(pmic_stpmic1) = {
 	.ops = &stpmic1_ops,
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int stpmic1_nvm_rw(struct udevice *dev, u8 addr, u8 *buf, int buf_len,
 			  enum pmic_nvm_op op)
 {
@@ -230,7 +230,7 @@ U_BOOT_DRIVER(stpmic1_nvm) = {
 	.id = UCLASS_MISC,
 	.ops = &stpmic1_nvm_ops,
 };
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_SYSRESET
 static int stpmic1_sysreset_request(struct udevice *dev, enum sysreset_t type)
diff --git a/drivers/power/power_core.c b/drivers/power/power_core.c
index 1caf9f09346..61b2fe5f54a 100644
--- a/drivers/power/power_core.c
+++ b/drivers/power/power_core.c
@@ -78,7 +78,7 @@ struct pmic *pmic_get(const char *s)
 	return NULL;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pmic_dump(struct pmic *p)
 {
 	int i, ret;
diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 34e61511d88..3f18ee65ce0 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -16,7 +16,7 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define ENABLE_DRIVER
 #endif
 
diff --git a/drivers/power/sy8106a.c b/drivers/power/sy8106a.c
index fb6028de71a..d9a2b6904b0 100644
--- a/drivers/power/sy8106a.c
+++ b/drivers/power/sy8106a.c
@@ -10,7 +10,7 @@
 #define SY8106A_VOUT1_SEL 1
 #define SY8106A_VOUT1_SEL_ENABLE (1 << 7)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static u8 sy8106a_mvolt_to_cfg(int mvolt, int min, int max, int div)
 {
 	if (mvolt < min)
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index fdb2e78ec9e..35d8f5761e1 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_K3_DDRSS) += k3-ddrss/
 obj-$(CONFIG_IMXRT_SDRAM) += imxrt_sdram.o
 
 obj-$(CONFIG_RAM_SIFIVE) += sifive/
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive/
 endif
 
diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
index c27c4593b9d..e9791697066 100644
--- a/drivers/ram/mediatek/ddr3-mt7629.c
+++ b/drivers/ram/mediatek/ddr3-mt7629.c
@@ -233,7 +233,7 @@ struct mtk_ddr3_priv {
 	struct clk mem_mux;
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int mtk_ddr3_rank_size_detect(struct udevice *dev)
 {
 	struct mtk_ddr3_priv *priv = dev_get_priv(dev);
@@ -697,7 +697,7 @@ static int mtk_ddr3_probe(struct udevice *dev)
 	if (priv->dramc_ao == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	int ret;
 
 	ret = clk_get_by_index(dev, 0, &priv->phy);
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index 618bce5c9f4..ffff7d55f33 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -84,7 +84,7 @@ const int ddrconf_table[] = {
 #define DQS_GATE_TRAINING_ERROR_RANK0	(1 << 4)
 #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
 {
 	int i;
@@ -851,7 +851,7 @@ static int rk3188_dmc_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 static int conv_of_plat(struct udevice *dev)
@@ -878,7 +878,7 @@ static int conv_of_plat(struct udevice *dev)
 
 static int rk3188_dmc_probe(struct udevice *dev)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct rk3188_sdram_params *plat = dev_get_plat(dev);
 	struct regmap *map;
 	struct udevice *dev_clk;
@@ -888,7 +888,7 @@ static int rk3188_dmc_probe(struct udevice *dev)
 
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	ret = conv_of_plat(dev);
 	if (ret)
@@ -950,12 +950,12 @@ U_BOOT_DRIVER(rockchip_rk3188_dmc) = {
 	.id = UCLASS_RAM,
 	.of_match = rk3188_dmc_ids,
 	.ops = &rk3188_dmc_ops,
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.of_to_plat = rk3188_dmc_of_to_plat,
 #endif
 	.probe = rk3188_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.plat_auto	= sizeof(struct rk3188_sdram_params),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index c9f61e933e9..25ceab98ee9 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -84,7 +84,7 @@ const int ddrconf_table[] = {
 #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
 
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
 {
 	int i;
@@ -1013,7 +1013,7 @@ static int rk3288_dmc_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 static int conv_of_plat(struct udevice *dev)
@@ -1041,7 +1041,7 @@ static int conv_of_plat(struct udevice *dev)
 static int rk3288_dmc_probe(struct udevice *dev)
 {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	struct rk3288_sdram_params *plat = dev_get_plat(dev);
 	struct udevice *dev_clk;
 	struct regmap *map;
@@ -1051,7 +1051,7 @@ static int rk3288_dmc_probe(struct udevice *dev)
 
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	ret = conv_of_plat(dev);
 	if (ret)
@@ -1119,13 +1119,13 @@ U_BOOT_DRIVER(rockchip_rk3288_dmc) = {
 	.of_match = rk3288_dmc_ids,
 	.ops = &rk3288_dmc_ops,
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.of_to_plat = rk3288_dmc_of_to_plat,
 #endif
 	.probe = rk3288_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.plat_auto	= sizeof(struct rk3288_sdram_params),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 45270e27184..c3745f9445b 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3196,7 +3196,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 4fbb088a8d9..b371f597d23 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -34,7 +34,7 @@
 
 struct dram_info {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	void __iomem *pctl;
 	void __iomem *phy;
 	struct rv1126_cru *cru;
@@ -49,7 +49,7 @@ struct dram_info {
 };
 
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 
 #define GRF_BASE_ADDR			0xfe000000
 #define PMU_GRF_BASE_ADDR		0xfe020000
@@ -3507,7 +3507,7 @@ error:
 static int rv1126_dmc_probe(struct udevice *dev)
 {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	if (rv1126_dmc_init(dev))
 		return 0;
 #else
diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
index bd2f438d727..c555d2af2d0 100644
--- a/drivers/ram/sifive/sifive_ddr.c
+++ b/drivers/ram/sifive/sifive_ddr.c
@@ -91,7 +91,7 @@ struct sifive_ddr_info {
 	u32 *physical_filter_ctrl;
 };
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 struct sifive_ddr_params {
 	struct sifive_ddrctl pctl_regs;
 	struct sifive_ddrphy phy_regs;
@@ -337,7 +337,7 @@ static int sifive_ddr_probe(struct udevice *dev)
 	priv->info.base = gd->ram_base;
 	priv->info.size = gd->ram_size;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	int ret;
 	u32 clock = 0;
 
@@ -404,7 +404,7 @@ U_BOOT_DRIVER(sifive_ddr) = {
 	.ops = &sifive_ddr_ops,
 	.probe = sifive_ddr_probe,
 	.priv_auto = sizeof(struct sifive_ddr_info),
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	.plat_auto = sizeof(struct sifive_dmc_plat),
 #endif
 };
diff --git a/drivers/ram/starfive/Makefile b/drivers/ram/starfive/Makefile
index 1df42c377bd..f1567b04b4c 100644
--- a/drivers/ram/starfive/Makefile
+++ b/drivers/ram/starfive/Makefile
@@ -2,10 +2,10 @@
 #
 # Copyright (c) 2022 StarFive, Inc
 #
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_start.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_train.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive_ddr.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_utils.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrcsr_boot.o
-endif
\ No newline at end of file
+endif
diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index debc458c0e2..e9cd6229ec4 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -371,7 +371,7 @@ static int stm32mp1_ddr_probe(struct udevice *dev)
 
 	priv->info.base = STM32_DDR_BASE;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		priv->info.size = 0;
 		ret = stm32mp1_ddr_setup(dev);
 
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 866437fd24f..76d108080d9 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -46,7 +46,7 @@ struct socfpga_reset_data {
  */
 static bool socfpga_reset_keep_enabled(void)
 {
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
 	const char *env_str;
 	long val;
 
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 628be4c89fb..7c19a435722 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 ifdef CONFIG_SCSI
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += scsi_bootdev.o
@@ -12,7 +12,7 @@ obj-$(CONFIG_SANDBOX) += scsi_emul.o
 endif
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_SATA
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 78810f98367..66bd30b837b 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_XEN_SERIAL) += serial_xen.o
 obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
 obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_TTY) += usbtty.o
 endif
 obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index 7e45a80969e..0b35582aaa4 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -218,7 +218,7 @@ static const struct dm_serial_ops atmel_serial_ops = {
 	.setbrg = atmel_serial_setbrg,
 };
 
-#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_CLK)
+#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_SPL_CLK)
 static int atmel_serial_enable_clk(struct udevice *dev)
 {
 	struct atmel_serial_priv *priv = dev_get_priv(dev);
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6fcb5b523ac..248fe3f778f 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -227,7 +227,7 @@ static void ns16550_setbrg(struct ns16550 *com_port, int baud_divisor)
 
 void ns16550_init(struct ns16550 *com_port, int baud_divisor)
 {
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_OMAP34XX)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_OMAP34XX)
 	/*
 	 * On some OMAP3/OMAP4 devices when UART3 is configured for boot mode
 	 * before SPL starts only THRE bit is set. We have to empty the
@@ -303,7 +303,7 @@ void ns16550_putc(struct ns16550 *com_port, char c)
 char ns16550_getc(struct ns16550 *com_port)
 {
 	while ((serial_in(&com_port->lsr) & UART_LSR_DR) == 0) {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_TTY)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_TTY)
 		extern void usbtty_poll(void);
 		usbtty_poll();
 #endif
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 84f02f7ac76..9feaa1eceec 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -101,7 +101,7 @@ static void serial_find_console_or_panic(void)
 			}
 		}
 	}
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
 	    !blob) {
 		/*
 		 * Try to use CONFIG_CONS_INDEX if available (it is numbered
diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index dc4bb06fa99..e10ca6eef76 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -315,7 +315,7 @@ static struct serial_device *get_current(void)
 
 	/* We must have a console device */
 	if (!dev) {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		puts("Cannot find console\n");
 		hang();
 #else
diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 801b7645afa..734780a124a 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -117,7 +117,7 @@ static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
 		writeb(val % 16, &uart->rest.value);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct s5p_serial_plat *plat = dev_get_plat(dev);
diff --git a/drivers/serial/serial_zynq.c b/drivers/serial/serial_zynq.c
index 55f13c00ddf..b74712f3eeb 100644
--- a/drivers/serial/serial_zynq.c
+++ b/drivers/serial/serial_zynq.c
@@ -152,7 +152,7 @@ static int zynq_serial_setbrg(struct udevice *dev, int baudrate)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static int zynq_serial_setconfig(struct udevice *dev, uint serial_config)
 {
 	struct zynq_uart_plat *plat = dev_get_plat(dev);
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 6bd48b1b373..b520c727900 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -219,7 +219,7 @@ static int dw_spi_dwc_init(struct udevice *bus, struct dw_spi_priv *priv)
 
 static int request_gpio_cs(struct udevice *bus)
 {
-#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_XPL_BUILD)
 	struct dw_spi_priv *priv = dev_get_priv(bus);
 	int ret;
 
@@ -482,7 +482,7 @@ static int poll_transfer(struct dw_spi_priv *priv)
  */
 __weak void external_cs_manage(struct udevice *dev, bool on)
 {
-#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_XPL_BUILD)
 	struct dw_spi_priv *priv = dev_get_priv(dev->parent);
 
 	if (!dm_gpio_is_valid(&priv->cs_gpio))
diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 596c22aa010..43aefc20c9a 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -229,7 +229,7 @@ static int rockchip_sfc_ofdata_to_platdata(struct udevice *bus)
 	sfc->regbase = dev_read_addr_ptr(bus);
 	sfc->use_dma = !dev_read_bool(bus, "rockchip,sfc-no-dma");
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && sfc->use_dma)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && sfc->use_dma)
 		sfc->use_dma = !dev_read_bool(bus, "u-boot,spl-sfc-no-dma");
 
 #if CONFIG_IS_ENABLED(CLK)
diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
index ef09440bbef..4e15ebd53cc 100644
--- a/drivers/sysreset/sysreset_ast.c
+++ b/drivers/sysreset/sysreset_ast.c
@@ -33,7 +33,7 @@ static int ast_sysreset_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	ret = wdt_expire_now(wdt, reset_mode);
 	if (ret) {
 		debug("Sysreset failed: %d", ret);
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index cbe06a9e7b6..4cfd38ec245 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -149,7 +149,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	dr_mode = best_dr_mode;
 
-#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_XPL_BUILD)
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = cdns3_host_init(cdns);
 		if (ret) {
@@ -412,7 +412,7 @@ int cdns3_bind(struct udevice *parent)
 
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 	case USB_DR_MODE_HOST:
 		debug("%s: dr_mode: HOST\n", __func__);
 		driver = "cdns-usb3-host";
@@ -498,7 +498,7 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 static int cdns3_host_probe(struct udevice *dev)
 {
 	struct cdns3_host_priv *priv = dev_get_priv(dev);
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 6abcce0d9c7..3158487cba4 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_$(SPL_TPL_)USB_GADGET) += epautoconf.o config.o usbstring.o
 obj-$(CONFIG_$(SPL_TPL_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
 obj-$(CONFIG_$(SPL_TPL_)USB_ETH_RNDIS) += rndis.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
 obj-$(CONFIG_SPL_DFU) += f_dfu.o
 obj-$(CONFIG_SPL_USB_SDP_SUPPORT) += f_sdp.o
@@ -21,7 +21,7 @@ obj-$(CONFIG_USB_GADGET_BCM_UDC_OTG_PHY) += bcm_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_udc_otg.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG_PHY) += dwc2_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_MAX3420) += max3420_udc.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 5d62eb475d0..36934b1bcf7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -411,7 +411,7 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	env_set_hex("filesize", sdp->dnl_bytes);
 #endif
 	printf("done\n");
@@ -736,7 +736,7 @@ static u32 sdp_jump_imxheader(void *address)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
 			   ulong count, void *buf)
 {
@@ -825,7 +825,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 
 		/* If imx header fails, try some U-Boot specific headers */
 		if (status) {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER))
 				sdp_func->jmp_address = (u32)search_container_header((ulong)sdp_func->jmp_address, sdp_func->dnl_bytes);
 			else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
@@ -907,7 +907,7 @@ static void sdp_handle_out_ep(void)
 	}
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int sdp_handle(struct udevice *udc)
 #else
 int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
@@ -928,7 +928,7 @@ int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		flag = sdp_handle_in_ep(spl_image, bootdev);
 #else
 		flag = sdp_handle_in_ep(NULL, NULL);
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index f8e14eabfb2..26fee141f6e 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -266,7 +266,7 @@ U_BOOT_DRIVER(mtu3_peripheral) = {
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 static int mtu3_host_probe(struct udevice *dev)
 {
 	struct ssusb_mtk *ssusb = dev_to_ssusb(dev->parent);
@@ -334,7 +334,7 @@ static int mtu3_glue_bind(struct udevice *parent)
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 	case USB_DR_MODE_HOST:
 		dev_dbg(parent, "%s: dr_mode: host\n", __func__);
 		driver = "mtu3-host";
diff --git a/dts/Makefile b/dts/Makefile
index d6c2c9daf31..62a65688cf5 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -53,7 +53,7 @@ PHONY += arch-dtbs
 arch-dtbs:
 	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
 $(obj)/dt-spl.dtb.o: $(obj)/dt-spl.dtb.S FORCE
diff --git a/env/Makefile b/env/Makefile
index 673b979fdfa..c5145c1735f 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += env.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += attr.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += flags.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += callback.o
 obj-$(CONFIG_ENV_IS_IN_EEPROM) += eeprom.o
 obj-$(CONFIG_ENV_IS_IN_EEPROM) += embedded.o
diff --git a/env/common.c b/env/common.c
index 6cba7f1c187..a58955a4f42 100644
--- a/env/common.c
+++ b/env/common.c
@@ -61,7 +61,7 @@ int env_do_env_set(int flag, int argc, char *const argv[], int env_flag)
 
 	debug("Initial value for argc=%d\n", argc);
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
 	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'e')
 		return do_env_set_efi(NULL, flag, --argc, ++argv);
 #endif
@@ -551,7 +551,7 @@ int env_export(env_t *env_out)
 void env_relocate(void)
 {
 	if (gd->env_valid == ENV_INVALID) {
-#if defined(CONFIG_ENV_IS_NOWHERE) || defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_ENV_IS_NOWHERE) || defined(CONFIG_XPL_BUILD)
 		/* Environment not changable */
 		env_set_default(NULL, 0);
 #else
diff --git a/env/fat.c b/env/fat.c
index f3f8b7301ee..b04b1d9c315 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -22,7 +22,7 @@
 #include <asm/global_data.h>
 #include <linux/stddef.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* TODO(sjg@chromium.org): Figure out why this is needed */
 # if !defined(CONFIG_TARGET_AM335X_EVM) || defined(CONFIG_SPL_OS_BOOT)
 #  define LOADENV
@@ -129,7 +129,7 @@ static int env_fat_load(void)
 	if (!strcmp(ifname, "mmc"))
 		mmc_initialize(NULL);
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(CONFIG_AHCI) || defined(CONFIG_SCSI)
 	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "scsi"))
 		scsi_scan(true);
diff --git a/env/flash.c b/env/flash.c
index 1bd6e7003d6..0f7393d830c 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -22,7 +22,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 # if defined(CONFIG_CMD_SAVEENV) && defined(CONFIG_CMD_FLASH)
 #  include <flash.h>
 #  define CMD_SAVEENV
@@ -35,11 +35,11 @@ DECLARE_GLOBAL_DATA_PTR;
 #if (!defined(CONFIG_MICROBLAZE) && !defined(CONFIG_ARCH_ZYNQ) && \
 	!defined(CONFIG_TARGET_MCCMON6) && !defined(CONFIG_TARGET_X600) && \
 	!defined(CONFIG_TARGET_EDMINIV2)) || \
-	!defined(CONFIG_SPL_BUILD)
+	!defined(CONFIG_XPL_BUILD)
 #define LOADENV
 #endif
 
-#if !defined(CONFIG_TARGET_X600) || !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_TARGET_X600) || !defined(CONFIG_XPL_BUILD)
 #define INITENV
 #endif
 
diff --git a/env/mmc.c b/env/mmc.c
index 0338aa6c56a..5fc0dae23a8 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -239,7 +239,7 @@ static void fini_mmc_for_env(struct mmc *mmc)
 	mmc_set_env_part_restore(mmc);
 }
 
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
 static inline int write_env(struct mmc *mmc, unsigned long size,
 			    unsigned long offset, const void *buffer)
 {
@@ -368,7 +368,7 @@ fini:
 	fini_mmc_for_env(mmc);
 	return ret;
 }
-#endif /* CONFIG_CMD_SAVEENV && !CONFIG_SPL_BUILD */
+#endif /* CONFIG_CMD_SAVEENV && !CONFIG_XPL_BUILD */
 
 static inline int read_env(struct mmc *mmc, unsigned long size,
 			   unsigned long offset, const void *buffer)
@@ -498,7 +498,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
 	.location	= ENVL_MMC,
 	ENV_NAME("MMC")
 	.load		= env_mmc_load,
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
 	.save		= env_save_ptr(env_mmc_save),
 	.erase		= ENV_ERASE_PTR(env_mmc_erase)
 #endif
diff --git a/env/nand.c b/env/nand.c
index fef5697ec39..fdaa903cd61 100644
--- a/env/nand.c
+++ b/env/nand.c
@@ -26,9 +26,9 @@
 #include <u-boot/crc.h>
 
 #if defined(CONFIG_CMD_SAVEENV) && defined(CONFIG_CMD_NAND) && \
-		!defined(CONFIG_SPL_BUILD)
+		!defined(CONFIG_XPL_BUILD)
 #define CMD_SAVEENV
-#elif defined(CONFIG_ENV_OFFSET_REDUND) && !defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_ENV_OFFSET_REDUND) && !defined(CONFIG_XPL_BUILD)
 #error CONFIG_ENV_OFFSET_REDUND must have CONFIG_CMD_SAVEENV & CONFIG_CMD_NAND
 #endif
 
@@ -224,7 +224,7 @@ static int env_nand_save(void)
 }
 #endif /* CMD_SAVEENV */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static int readenv(size_t offset, u_char *buf)
 {
 	return nand_spl_load_image(offset, CONFIG_ENV_SIZE, buf);
@@ -265,7 +265,7 @@ static int readenv(size_t offset, u_char *buf)
 
 	return 0;
 }
-#endif /* #if defined(CONFIG_SPL_BUILD) */
+#endif /* #if defined(CONFIG_XPL_BUILD) */
 
 #ifdef CONFIG_ENV_OFFSET_OOB
 int get_nand_env_oob(struct mtd_info *mtd, unsigned long *result)
diff --git a/env/nowhere.c b/env/nowhere.c
index 326f27db2e9..6b9b6e2fe0b 100644
--- a/env/nowhere.c
+++ b/env/nowhere.c
@@ -33,7 +33,7 @@ static int env_nowhere_load(void)
 	 * searches default_environment array in that case.
 	 * For U-Boot proper, import the default environment to allow reload.
 	 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		env_set_default(NULL, 0);
 
 	gd->env_valid = ENV_INVALID;
diff --git a/env/sf.c b/env/sf.c
index 21ac0c202e7..eb4c8d5ec95 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -329,7 +329,7 @@ done:
 
 __weak void *env_sf_get_env_addr(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return (void *)CONFIG_ENV_ADDR;
 #else
 	return NULL;
diff --git a/fs/Makefile b/fs/Makefile
index 7b05c79e0cc..ec3e31c7c75 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 # Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_FS_LOADER) += fs.o
 obj-$(CONFIG_SPL_FS_FAT) += fat/
 obj-$(CONFIG_SPL_FS_EXT4) += ext4/
diff --git a/fs/fs.c b/fs/fs.c
index 4bc28d1dffb..e2915e7cf79 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -237,7 +237,7 @@ static struct fstype_info fstypes[] = {
 		.mkdir = fs_mkdir_unsupported,
 	},
 #endif
-#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	{
 		.fstype = FS_TYPE_SANDBOX,
 		.name = "sandbox",
@@ -275,7 +275,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 	},
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_CMD_UBIFS
 	{
 		.fstype = FS_TYPE_UBIFS,
@@ -296,7 +296,7 @@ static struct fstype_info fstypes[] = {
 	},
 #endif
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_FS_BTRFS
 	{
 		.fstype = FS_TYPE_BTRFS,
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index d6c15e2c406..644a0d77873 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -55,7 +55,7 @@ struct global_data {
 	 * @cur_serial_dev: current serial device
 	 */
 	struct udevice *cur_serial_dev;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/**
 	 * @jt: jump table
 	 *
diff --git a/include/bootcount.h b/include/bootcount.h
index bc06e17c9fb..847c0f02d98 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -120,13 +120,13 @@ static inline void bootcount_inc(void)
 		return;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Only increment bootcount when no bootcount support in SPL */
 #if !defined(CONFIG_SPL_BOOTCOUNT_LIMIT) && !defined(CONFIG_TPL_BOOTCOUNT_LIMIT)
 	bootcount_store(++bootcount);
 #endif
 	env_set_ulong("bootcount", bootcount);
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 }
 
 #else
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 2a136b96a6d..0a4e4b8ff85 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -63,7 +63,7 @@
 #define BOOTENV_SHARED_MMC	BOOTENV_SHARED_BLKDEV(mmc)
 #define BOOTENV_DEV_MMC		BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_MMC	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_SHARED_MMC
 #define BOOTENV_DEV_MMC		BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_MMC	BOOTENV_DEV_NAME_BLKDEV_NONE
@@ -198,7 +198,7 @@
 #define BOOTENV_SHARED_SATA	BOOTENV_SHARED_BLKDEV(sata)
 #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_SATA	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_SHARED_SATA
 #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_SATA	BOOTENV_DEV_NAME_BLKDEV_NONE
@@ -305,7 +305,7 @@
 		BOOTENV_SHARED_BLKDEV_BODY(usb)
 #define BOOTENV_DEV_USB		BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_USB	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_RUN_NET_USB_START
 #define BOOTENV_SHARED_USB
 #define BOOTENV_DEV_USB		BOOTENV_DEV_BLKDEV_NONE
@@ -412,7 +412,7 @@
 		"\0"
 #define BOOTENV_DEV_NAME_DHCP(devtypeu, devtypel, instance) \
 	"dhcp "
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_DEV_DHCP	BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_DHCP	BOOTENV_DEV_NAME_BLKDEV_NONE
 #else
@@ -433,7 +433,7 @@
 		"fi\0"
 #define BOOTENV_DEV_NAME_PXE(devtypeu, devtypel, instance) \
 	"pxe "
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_DEV_PXE		BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_PXE	BOOTENV_DEV_NAME_BLKDEV_NONE
 #else
diff --git a/include/configs/P1010RDB.h b/include/configs/P1010RDB.h
index 9efae58ce90..20fded56b77 100644
--- a/include/configs/P1010RDB.h
+++ b/include/configs/P1010RDB.h
@@ -43,7 +43,7 @@
 #define CFG_SYS_NAND_U_BOOT_SIZE	(576 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	(0x11000000)
 #define CFG_SYS_NAND_U_BOOT_START	(0x11000000)
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_NAND_U_BOOT_SIZE	(128 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	0xD0000000
 #define CFG_SYS_NAND_U_BOOT_START	0xD0000000
@@ -290,7 +290,7 @@ extern unsigned long get_sdram_size(void);
 /*
  * Config the L2 Cache as L2 SRAM
  */
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SDCARD) || defined(CONFIG_SPIFLASH)
 #define CFG_SYS_INIT_L2_ADDR		0xD0000000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index 67f46562539..19d3c72a6f1 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -75,7 +75,7 @@
 
 #include <config_distro_bootcmd.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <env/ti/dfu.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
@@ -181,7 +181,7 @@
 #endif /* !CONFIG_MTD_RAW_NAND */
 
 /* USB Device Firmware Update support */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	DFU_ALT_INFO_EMMC \
 	DFU_ALT_INFO_MMC \
diff --git a/include/configs/am335x_guardian.h b/include/configs/am335x_guardian.h
index a8fa61c7e50..96efd38594a 100644
--- a/include/configs/am335x_guardian.h
+++ b/include/configs/am335x_guardian.h
@@ -16,7 +16,7 @@
 #define V_OSCK				24000000  /* Clock output from T2 */
 #define V_SCLK				(V_OSCK)
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"scriptaddr=0x80000000\0" \
@@ -70,7 +70,7 @@
 		"setenv boot_syslinux_conf \"extlinux/extlinux.conf\"; " \
 		"run bootcmd_ubifs0;\0"
 
-#endif /* ! CONFIG_SPL_BUILD */
+#endif /* ! CONFIG_XPL_BUILD */
 
 #define SPLASH_SCREEN_NAND_PART "nand0,10"
 #define SPLASH_SCREEN_BMP_FILE_SIZE 0x26000
diff --git a/include/configs/am335x_shc.h b/include/configs/am335x_shc.h
index dedef91ba59..55d5190b221 100644
--- a/include/configs/am335x_shc.h
+++ b/include/configs/am335x_shc.h
@@ -20,7 +20,7 @@
 #define V_OSCK				24000000  /* Clock output from T2 */
 #define V_SCLK				(V_OSCK)
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define CFG_EXTRA_ENV_SETTINGS \
 	"loadaddr=0x80200000\0" \
 	"kloadaddr=0x84000000\0" \
@@ -117,7 +117,7 @@
 			"setenv mmcpart 5; " \
 		"fi; " \
 		"setenv mmcroot /dev/mmcblk${mmcdev}p${mmcpart};\0"
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 
 #if defined CONFIG_SHC_NETBOOT
 /* Network Boot */
diff --git a/include/configs/am43xx_evm.h b/include/configs/am43xx_evm.h
index 87ffa769d15..036995cbb48 100644
--- a/include/configs/am43xx_evm.h
+++ b/include/configs/am43xx_evm.h
@@ -35,7 +35,7 @@
 /* NS16550 Configuration */
 #define CFG_SYS_NS16550_COM1		0x44e09000	/* Base EVM has UART0 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* USB Device Firmware Update support */
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
@@ -63,7 +63,7 @@
 
 #include <config_distro_bootcmd.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <env/ti/dfu.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/am57xx_evm.h b/include/configs/am57xx_evm.h
index 4b4362ccfd8..aa31f3b05a0 100644
--- a/include/configs/am57xx_evm.h
+++ b/include/configs/am57xx_evm.h
@@ -18,7 +18,7 @@
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
 	DFU_ALT_INFO_MMC \
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index 9dcacad2fc0..1f61b2b6af6 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -13,10 +13,10 @@
 #include "siemens-env-common.h"
 
 /* SPL config */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* ENET1 connects to base board and MUX with ESAI */
 #define CFG_FEC_ENET_DEV		1
diff --git a/include/configs/cgtqmx8.h b/include/configs/cgtqmx8.h
index 98d4d8cf4bd..0d338389cb9 100644
--- a/include/configs/cgtqmx8.h
+++ b/include/configs/cgtqmx8.h
@@ -11,7 +11,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/da850evm.h b/include/configs/da850evm.h
index 416aa96366c..8db849c6d09 100644
--- a/include/configs/da850evm.h
+++ b/include/configs/da850evm.h
@@ -157,7 +157,7 @@
 	"console=ttyS2,115200n8\0" \
 	"hwconfig=dsp:wake=yes"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* defines for SPL */
 
 #endif
diff --git a/include/configs/dra7xx_evm.h b/include/configs/dra7xx_evm.h
index 633ec1f32fa..96dcd731cb6 100644
--- a/include/configs/dra7xx_evm.h
+++ b/include/configs/dra7xx_evm.h
@@ -28,7 +28,7 @@
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
 	DFU_ALT_INFO_MMC \
@@ -37,7 +37,7 @@
 	DFU_ALT_INFO_QSPI
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_DFU
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
diff --git a/include/configs/ds116.h b/include/configs/ds116.h
index c2326596811..2f2bc43269e 100644
--- a/include/configs/ds116.h
+++ b/include/configs/ds116.h
@@ -18,7 +18,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -39,6 +39,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_DS116_H */
diff --git a/include/configs/ds414.h b/include/configs/ds414.h
index 95256575583..431a78de416 100644
--- a/include/configs/ds414.h
+++ b/include/configs/ds414.h
@@ -43,7 +43,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -80,6 +80,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
diff --git a/include/configs/gardena-smart-gateway-mt7688.h b/include/configs/gardena-smart-gateway-mt7688.h
index 1b97ae22fc6..a89d298b525 100644
--- a/include/configs/gardena-smart-gateway-mt7688.h
+++ b/include/configs/gardena-smart-gateway-mt7688.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_UBOOT_BASE		0
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM1		0xb0000c00
 #endif
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index fab5063b73f..64ddbf711d3 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -92,7 +92,7 @@
 /* SPL */
 #ifdef CONFIG_SPL
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_SYS_FSL_USDHC_NUM 2
 
 #ifdef CONFIG_SYS_BOOT_EMMC
diff --git a/include/configs/imx6ulz_smm_m2.h b/include/configs/imx6ulz_smm_m2.h
index 9da98d0af27..44a3fc02e8a 100644
--- a/include/configs/imx6ulz_smm_m2.h
+++ b/include/configs/imx6ulz_smm_m2.h
@@ -14,14 +14,14 @@
 
 #define CFG_MXC_UART_BASE		UART4_BASE
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(NAND, nand, 0) \
 
 #include <config_distro_bootcmd.h>
 
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 146f7945719..6ed4a6fd3fc 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x912000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_beacon.h b/include/configs/imx8mm_beacon.h
index fa20651d2df..2ec7f3d8b6f 100644
--- a/include/configs/imx8mm_beacon.h
+++ b/include/configs/imx8mm_beacon.h
@@ -21,7 +21,7 @@
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index 9a5e5bd009d..d323f84ac7a 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x930000
 
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index 9dd63fc1196..3bbbd900dd4 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -22,7 +22,7 @@
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_icore_mx8mm.h b/include/configs/imx8mm_icore_mx8mm.h
index 2158b0af74f..145dab91215 100644
--- a/include/configs/imx8mm_icore_mx8mm.h
+++ b/include/configs/imx8mm_icore_mx8mm.h
@@ -13,11 +13,11 @@
 #define CFG_SYS_UBOOT_BASE \
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 # define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 2) \
diff --git a/include/configs/imx8mm_phg.h b/include/configs/imx8mm_phg.h
index d2d7ffa0f5b..038d3a7ce3f 100644
--- a/include/configs/imx8mm_phg.h
+++ b/include/configs/imx8mm_phg.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/imx8mm_venice.h b/include/configs/imx8mm_venice.h
index 66816618b0c..ed09dd09bcb 100644
--- a/include/configs/imx8mm_venice.h
+++ b/include/configs/imx8mm_venice.h
@@ -12,7 +12,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rsb3720.h
index b82e35f4963..8b96f7fd1e4 100644
--- a/include/configs/imx8mp_rsb3720.h
+++ b/include/configs/imx8mp_rsb3720.h
@@ -23,7 +23,7 @@
 	EFI_GUID(0xb5fb6f08, 0xe142, 0x4db1, 0x97, 0xea, \
 		 0x5f, 0xd3, 0x6b, 0x9b, 0xe5, 0xb9)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x184000 /* malloc f used before \
 						  * GD_FLG_FULL_MALLOC_INIT \
 						  * set \
diff --git a/include/configs/imx8mq_cm.h b/include/configs/imx8mq_cm.h
index 2bbd6b1680f..ccbb0f85559 100644
--- a/include/configs/imx8mq_cm.h
+++ b/include/configs/imx8mq_cm.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x182000
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index 9eefc31dc6f..666f46ac105 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_phanbell.h
index cd73a72d2b7..3bc4b0034e8 100644
--- a/include/configs/imx8mq_phanbell.h
+++ b/include/configs/imx8mq_phanbell.h
@@ -9,7 +9,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8mq_reform2.h b/include/configs/imx8mq_reform2.h
index 7fa441a8a83..40f96a5f219 100644
--- a/include/configs/imx8mq_reform2.h
+++ b/include/configs/imx8mq_reform2.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8qm_mek.h b/include/configs/imx8qm_mek.h
index 4d5abe2d073..842184bcae2 100644
--- a/include/configs/imx8qm_mek.h
+++ b/include/configs/imx8qm_mek.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/imx8qxp_mek.h b/include/configs/imx8qxp_mek.h
index 93999509948..1b6eb2b81cf 100644
--- a/include/configs/imx8qxp_mek.h
+++ b/include/configs/imx8qxp_mek.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index aa9da19a11f..9308f5234f4 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -11,7 +11,7 @@
 
 #define CFG_SYS_UBOOT_BASE	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x22040000
 
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ce6567e2af6..53fb8c9b1ba 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index 3a129c5cce7..72a28a6a413 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -10,7 +10,7 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <config.h>
 #endif
 
@@ -39,7 +39,7 @@
 #undef BOOTENV_RUN_NET_USB_START
 #define BOOTENV_RUN_NET_USB_START
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/kontron_pitx_imx8m.h b/include/configs/kontron_pitx_imx8m.h
index 3dda7b66806..3f52d00d6c8 100644
--- a/include/configs/kontron_pitx_imx8m.h
+++ b/include/configs/kontron_pitx_imx8m.h
@@ -12,7 +12,7 @@
 	EFI_GUID(0xc898e959, 0x5b1f, 0x4e6d, 0x88, 0xe0, \
 		 0x40, 0xd4, 0x5c, 0xca, 0x13, 0x99)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x182000
diff --git a/include/configs/librem5.h b/include/configs/librem5.h
index 876b02f4da6..571c7724eaf 100644
--- a/include/configs/librem5.h
+++ b/include/configs/librem5.h
@@ -41,7 +41,7 @@
 #define CONSOLE		"ttymxc0"
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
 	func(USB, usb, 0) \
diff --git a/include/configs/linkit-smart-7688.h b/include/configs/linkit-smart-7688.h
index e8f7a59c401..ec1aa14be01 100644
--- a/include/configs/linkit-smart-7688.h
+++ b/include/configs/linkit-smart-7688.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_UBOOT_BASE		0
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM3		0xb0000e00
 
diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_common.h
index e500a7d80ff..a02c752bbcf 100644
--- a/include/configs/ls1043a_common.h
+++ b/include/configs/ls1043a_common.h
@@ -8,7 +8,7 @@
 #define __LS1043A_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_FMAN
 #define SPL_NO_DSPI
 #define SPL_NO_PCIE
@@ -19,10 +19,10 @@
 #define SPL_NO_QE
 #define SPL_NO_EEPROM
 #endif
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_NAND_BOOT))
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_NAND_BOOT))
 #define SPL_NO_MMC
 #endif
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SD_BOOT_QSPI))
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SD_BOOT_QSPI))
 #define SPL_NO_IFC
 #endif
 
diff --git a/include/configs/ls1046a_common.h b/include/configs/ls1046a_common.h
index 867b098a073..53ef5975a28 100644
--- a/include/configs/ls1046a_common.h
+++ b/include/configs/ls1046a_common.h
@@ -8,7 +8,7 @@
 #define __LS1046A_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_QBMAN
 #define SPL_NO_FMAN
 #define SPL_NO_ENV
@@ -17,11 +17,11 @@
 #define SPL_NO_USB
 #define SPL_NO_SATA
 #endif
-#if defined(CONFIG_SPL_BUILD) && \
+#if defined(CONFIG_XPL_BUILD) && \
 	(defined(CONFIG_NAND_BOOT) || defined(CONFIG_QSPI_BOOT))
 #define SPL_NO_MMC
 #endif
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #define SPL_NO_IFC
 #endif
 
diff --git a/include/configs/ls1088a_common.h b/include/configs/ls1088a_common.h
index 34085eeecc7..cdf281947dc 100644
--- a/include/configs/ls1088a_common.h
+++ b/include/configs/ls1088a_common.h
@@ -7,7 +7,7 @@
 #define __LS1088_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_BOARDINFO
 #define SPL_NO_QIXIS
 #define SPL_NO_PCI
diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index ea5c93ecf69..985b1ca91e6 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -20,7 +20,7 @@
 #define CFG_FEC_MXC_PHYADDR          1
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2)
diff --git a/include/configs/mt7621.h b/include/configs/mt7621.h
index e6dba707195..636d62dd883 100644
--- a/include/configs/mt7621.h
+++ b/include/configs/mt7621.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_INIT_SP_OFFSET		0x800000
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		50000000
 #define CFG_SYS_NS16550_COM1		0xbe000c00
 #endif
diff --git a/include/configs/mt7628.h b/include/configs/mt7628.h
index 1df06811d65..ba876ac3029 100644
--- a/include/configs/mt7628.h
+++ b/include/configs/mt7628.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_INIT_SP_OFFSET		0x80000
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM1		0xb0000c00
 #endif
diff --git a/include/configs/n2350.h b/include/configs/n2350.h
index f98b9f8582d..c789df55bfb 100644
--- a/include/configs/n2350.h
+++ b/include/configs/n2350.h
@@ -18,7 +18,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -39,6 +39,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_N2350_H */
diff --git a/include/configs/p1_p2_rdb_pc.h b/include/configs/p1_p2_rdb_pc.h
index f5bd0913449..23d8917b718 100644
--- a/include/configs/p1_p2_rdb_pc.h
+++ b/include/configs/p1_p2_rdb_pc.h
@@ -98,7 +98,7 @@
 #define CFG_SYS_NAND_U_BOOT_SIZE	(832 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	(0x11000000)
 #define CFG_SYS_NAND_U_BOOT_START	(0x11000000)
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_NAND_U_BOOT_SIZE	(128 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	0xf8f80000
 #define CFG_SYS_NAND_U_BOOT_START	0xf8f80000
@@ -280,7 +280,7 @@
 /*
  * Config the L2 Cache as L2 SRAM
 */
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SDCARD) || defined(CONFIG_SPIFLASH)
 #define CFG_SYS_INIT_L2_ADDR		0xf8f80000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index 0910ae2d870..e74a3f184c6 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE \
 		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.h
index 422b89a3dd3..3012f64c0ae 100644
--- a/include/configs/pico-imx8mq.h
+++ b/include/configs/pico-imx8mq.h
@@ -9,7 +9,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index d652ae4ca34..c5bcd7dc5e8 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifndef ROCKCHIP_DEVICE_SETTINGS
 #define ROCKCHIP_DEVICE_SETTINGS
@@ -38,6 +38,6 @@
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* __CONFIG_RK3399_COMMON_H */
diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index 9121bba3738..9b8ab3cdf20 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -11,7 +11,7 @@
 #define CFG_CPUID_OFFSET	0x7
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGETS	"mmc1 mmc0 nvme scsi usb pxe dhcp spi"
 
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 4838bfd4f13..2acfdc7df4a 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -117,7 +117,7 @@
 /* SPL NAND boot support */
 
 /* Extra Environment */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifdef CONFIG_CMD_DHCP
 #define BOOT_TARGET_DEVICES_DHCP(func) func(DHCP, dhcp, na)
diff --git a/include/configs/stm32mp15_common.h b/include/configs/stm32mp15_common.h
index 29a1197b5ae..af6dd4a8095 100644
--- a/include/configs/stm32mp15_common.h
+++ b/include/configs/stm32mp15_common.h
@@ -33,7 +33,7 @@
 #ifdef CONFIG_DISTRO_DEFAULTS
 /*****************************************************************************/
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_MMC0(func)	func(MMC, mmc, 0)
@@ -129,7 +129,7 @@
 	STM32MP_EXTRA \
 	STM32MP_BOARD_EXTRA_ENV
 
-#endif /* ifndef CONFIG_SPL_BUILD */
+#endif /* ifndef CONFIG_XPL_BUILD */
 #endif /* ifdef CONFIG_DISTRO_DEFAULTS*/
 
 #endif /* __CONFIG_STM32MP15_COMMMON_H */
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 6fe6e7b9b8c..0f466711cae 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -10,7 +10,7 @@
 
 /* PHY needs a longer autoneg timeout */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_EXTRA_ENV_SETTINGS						\
 	"dfu_alt_info_ram=u-boot.itb ram "				\
 			__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS)	\
diff --git a/include/configs/ti_omap3_common.h b/include/configs/ti_omap3_common.h
index 45f7179f035..4a7474ff3f9 100644
--- a/include/configs/ti_omap3_common.h
+++ b/include/configs/ti_omap3_common.h
@@ -31,7 +31,7 @@
 					115200}
 
 /* Select serial console configuration */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_SYS_NS16550_COM1		OMAP34XX_UART1
 #define CFG_SYS_NS16550_COM2		OMAP34XX_UART2
 #define CFG_SYS_NS16550_COM3		OMAP34XX_UART3
diff --git a/include/configs/ti_omap4_common.h b/include/configs/ti_omap4_common.h
index c4f116aabf8..7a333090b18 100644
--- a/include/configs/ti_omap4_common.h
+++ b/include/configs/ti_omap4_common.h
@@ -95,7 +95,7 @@
  * So moving TEXT_BASE down to non-HS limit.
  */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* No need for i2c in SPL mode as we will use SRI2C for PMIC access on OMAP4 */
 #endif
 
diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
index 3d398a6c1ec..c05614950c7 100644
--- a/include/configs/turris_1x.h
+++ b/include/configs/turris_1x.h
@@ -63,7 +63,7 @@
 /*
  * For SD card builds without SPL it is needed to set CONFIG_SYS_RAMBOOT
  *
- * if CONFIG_SPL_BUILD
+ * if CONFIG_XPL_BUILD
  *     if CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR
  *         define CONFIG_SPL_MAX_SIZE = (CONFIG_SYS_L2_SIZE+CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA
  *                                      * SZ_512)
@@ -121,7 +121,7 @@
  */
 
 /* Initial SRAM is used only for SD card boot in first stage image */
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_INIT_L2_ADDR		0xf8f80000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
 /*
diff --git a/include/configs/turris_omnia.h b/include/configs/turris_omnia.h
index 302194bc90f..03a12d519f2 100644
--- a/include/configs/turris_omnia.h
+++ b/include/configs/turris_omnia.h
@@ -31,7 +31,7 @@
 #include "mv-common.h"
 
 /* Include the common distro boot environment */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
@@ -86,6 +86,6 @@
 	"bootcmd_rescue=" TURRIS_OMNIA_BOOTCMD_RESCUE "\0" \
 	BOOTENV
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_TURRIS_OMNIA_H */
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index b018bbe29dd..c54383b886e 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -12,7 +12,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index 0b88e95603d..bff417fdafb 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -12,13 +12,13 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR				0x184000
 /* For RAW image gives a error info not panic */
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"fdt_addr_r=0x50200000\0" \
diff --git a/include/configs/vining_2000.h b/include/configs/vining_2000.h
index 2cf7bc70d8d..752b23d055c 100644
--- a/include/configs/vining_2000.h
+++ b/include/configs/vining_2000.h
@@ -47,7 +47,7 @@
 /* 0=user, 1=boot0, 2=boot1, * 4..7=general0..3. */
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MXC_UART_BASE		UART1_BASE
 #endif
 
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index de0db7bb63f..bb0db7c5ca3 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -183,7 +183,7 @@
 #endif
 
 /* SPL can't handle all huge variables - define just DFU */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_DFU)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_DFU)
 #undef CFG_EXTRA_ENV_SETTINGS
 # define CFG_EXTRA_ENV_SETTINGS \
 	"dfu_alt_info_ram=uboot.bin ram 0x8000000 0x1000000;" \
diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 03af859c951..37c77aa1611 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -44,7 +44,7 @@
 
 /* Boot configuration */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define BOOTENV
 #else
 
@@ -167,7 +167,7 @@
 	BOOT_TARGET_DEVICES_DHCP(func)
 
 #include <config_distro_bootcmd.h>
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* Default environment */
 #ifndef CFG_EXTRA_ENV_SETTINGS
diff --git a/include/env.h b/include/env.h
index d2a5954ded8..01c3eeae7e2 100644
--- a/include/env.h
+++ b/include/env.h
@@ -44,7 +44,7 @@ struct env_clbk_tbl {
  * For SPL these are silently dropped to reduce code size, since environment
  * callbacks are not supported with SPL.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define U_BOOT_ENV_CALLBACK(name, callback) \
 	static inline __maybe_unused void _u_boot_env_noop_##name(void) \
 	{ \
diff --git a/include/env_callback.h b/include/env_callback.h
index 8e500aaaf80..5121ae07fd9 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -85,7 +85,7 @@
 	"serial#:serialno," \
 	CFG_ENV_CALLBACK_LIST_STATIC
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void env_callback_init(struct env_entry *var_entry);
 #else
 static inline void env_callback_init(struct env_entry *var_entry)
diff --git a/include/fdtdec.h b/include/fdtdec.h
index e80de24076c..555c9520379 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -143,7 +143,7 @@ extern u8 __dtb_dt_spl_begin[];	/* embedded device tree blob for SPL/TPL */
 static inline u8 *dtb_dt_embedded(void)
 {
 #ifdef CONFIG_OF_EMBED
-# ifdef CONFIG_SPL_BUILD
+# ifdef CONFIG_XPL_BUILD
 	return __dtb_dt_spl_begin;
 # else
 	return __dtb_dt_begin;
diff --git a/include/image-android-dt.h b/include/image-android-dt.h
index 9a3aa8fa30f..d255744e8cb 100644
--- a/include/image-android-dt.h
+++ b/include/image-android-dt.h
@@ -13,7 +13,7 @@ bool android_dt_check_header(ulong hdr_addr);
 bool android_dt_get_fdt_by_index(ulong hdr_addr, u32 index, ulong *addr,
 				 u32 *size);
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 void android_dt_print_contents(ulong hdr_addr);
 #endif
 
diff --git a/include/iotrace.h b/include/iotrace.h
index d5610426cc8..5527c984fd2 100644
--- a/include/iotrace.h
+++ b/include/iotrace.h
@@ -42,7 +42,7 @@ struct iotrace_record {
  */
 
 #if defined(CONFIG_IO_TRACE) && !defined(IOTRACE_IMPL) && \
-	!defined(CONFIG_SPL_BUILD)
+	!defined(CONFIG_XPL_BUILD)
 
 #undef readl
 #define readl(addr)	iotrace_readl((const void *)(addr))
diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index 2bc704e1104..a59f2a61e6a 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -40,7 +40,7 @@
 #define _CONFIG_PREFIX TPL_
 #elif defined(CONFIG_VPL_BUILD)
 #define _CONFIG_PREFIX VPL_
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define _CONFIG_PREFIX SPL_
 #else
 #define _CONFIG_PREFIX
@@ -53,8 +53,8 @@
 /*
  * CONFIG_VAL(FOO) evaluates to the value of
  *  CONFIG_TOOLS_FOO if USE_HOSTCC is defined,
- *  CONFIG_FOO if CONFIG_SPL_BUILD is undefined,
- *  CONFIG_SPL_FOO if CONFIG_SPL_BUILD is defined.
+ *  CONFIG_FOO if CONFIG_XPL_BUILD is undefined,
+ *  CONFIG_SPL_FOO if CONFIG_XPL_BUILD is defined.
  *  CONFIG_TPL_FOO if CONFIG_TPL_BUILD is defined.
  *  CONFIG_VPL_FOO if CONFIG_VPL_BUILD is defined.
  */
@@ -106,22 +106,22 @@ long invalid_use_of_IF_ENABLED_INT(void);
 /*
  * CONFIG_IS_ENABLED(FOO) expands to
  *  1 if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  1 if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  1 if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  1 if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  1 if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  1 if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  0 otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  nothing otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc), (def)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  def otherwise.
  *
diff --git a/include/log.h b/include/log.h
index 7c25bf0b081..371f99d82e7 100644
--- a/include/log.h
+++ b/include/log.h
@@ -246,7 +246,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #define _DEBUG	0
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define _SPL_BUILD	1
 #else
 #define _SPL_BUILD	0
diff --git a/include/mmc.h b/include/mmc.h
index 0044ff8bef7..e4b960b7294 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -726,7 +726,7 @@ struct mmc {
 	u64 capacity_boot;
 	u64 capacity_rpmb;
 	u64 capacity_gp[4];
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	u64 enh_user_start;
 	u64 enh_user_size;
 #endif
diff --git a/include/mtd/cfi_flash.h b/include/mtd/cfi_flash.h
index f4aecaac75f..be292e3ceb2 100644
--- a/include/mtd/cfi_flash.h
+++ b/include/mtd/cfi_flash.h
@@ -163,7 +163,7 @@ struct cfi_pri_hdr {
 #if defined(CONFIG_SYS_MAX_FLASH_BANKS_DETECT)
 /* map to cfi_flash_num_flash_banks only when supported */
 #if IS_ENABLED(CONFIG_FLASH_CFI_DRIVER) && \
-    (!IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD))
+    (!IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD))
 #define CFI_FLASH_BANKS		(cfi_flash_num_flash_banks)
 /* board code can update this variable before CFI detection */
 extern int cfi_flash_num_flash_banks;
diff --git a/include/net.h b/include/net.h
index bb2ae20f52a..dc8b5e9cc34 100644
--- a/include/net.h
+++ b/include/net.h
@@ -683,7 +683,7 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
 /* Processes a received packet */
 void net_process_received_packet(uchar *in_packet, int len);
 
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 void nc_start(void);
 int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	unsigned src_port, unsigned len);
@@ -691,7 +691,7 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 
 static __always_inline int eth_is_on_demand_init(void)
 {
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 	extern enum proto_t net_loop_last_protocol;
 
 	return net_loop_last_protocol != NETCONS;
@@ -702,7 +702,7 @@ static __always_inline int eth_is_on_demand_init(void)
 
 static inline void eth_set_last_protocol(int protocol)
 {
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 	extern enum proto_t net_loop_last_protocol;
 
 	net_loop_last_protocol = protocol;
diff --git a/include/part.h b/include/part.h
index 797b542ef1f..92662677551 100644
--- a/include/part.h
+++ b/include/part.h
@@ -439,7 +439,7 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
  * We don't support printing partition information in SPL and only support
  * getting partition information in a few cases.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
diff --git a/include/sdp.h b/include/sdp.h
index 5492f9c47d2..0a97f28073a 100644
--- a/include/sdp.h
+++ b/include/sdp.h
@@ -11,7 +11,7 @@
 
 int sdp_init(struct udevice *udc);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
diff --git a/include/search.h b/include/search.h
index 7faf23f4aca..3952198a0df 100644
--- a/include/search.h
+++ b/include/search.h
@@ -29,7 +29,7 @@ enum env_action {
 struct env_entry {
 	const char *key;
 	char *data;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int (*callback)(const char *name, const char *value, enum env_op op,
 		int flags);
 #endif
diff --git a/include/spl.h b/include/spl.h
index de808ccd413..dd9aeeaf9cc 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -51,7 +51,7 @@ static inline bool u_boot_first_phase(void)
 		if (IS_ENABLED(CONFIG_TPL_BUILD))
 			return true;
 	} else if (IS_ENABLED(CONFIG_SPL)) {
-		if (IS_ENABLED(CONFIG_SPL_BUILD))
+		if (IS_ENABLED(CONFIG_XPL_BUILD))
 			return true;
 	} else {
 		return true;
@@ -90,7 +90,7 @@ enum u_boot_phase {
  *
  * To include code only in SPL, you might do:
  *
- *    #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+ *    #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
  *    ...
  *    #endif
  *
@@ -102,7 +102,7 @@ enum u_boot_phase {
  *
  * To include code only in U-Boot proper, you might do:
  *
- *    #ifndef CONFIG_SPL_BUILD
+ *    #ifndef CONFIG_XPL_BUILD
  *    ...
  *    #endif
  *
@@ -120,7 +120,7 @@ static inline enum u_boot_phase spl_phase(void)
 	return PHASE_TPL;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_VPL;
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 	return PHASE_SPL;
 #else
 	DECLARE_GLOBAL_DATA_PTR;
@@ -135,7 +135,7 @@ static inline enum u_boot_phase spl_phase(void)
 /* returns true if in U-Boot proper, false if in SPL */
 static inline bool spl_in_proper(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	return false;
 #endif
 
@@ -154,7 +154,7 @@ static inline enum u_boot_phase spl_prev_phase(void)
 	return PHASE_NONE;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_TPL;	/* VPL requires TPL */
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL :
 		IS_ENABLED(CONFIG_TPL) ? PHASE_TPL :
 		PHASE_NONE;
@@ -227,7 +227,7 @@ static inline const char *spl_phase_prefix(enum u_boot_phase phase)
 }
 
 /* A string name for SPL or TPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # ifdef CONFIG_TPL_BUILD
 #  define SPL_TPL_NAME	"TPL"
 # elif defined(CONFIG_VPL_BUILD)
diff --git a/include/stdio.h b/include/stdio.h
index 7b999a519ba..56609b846ff 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -9,9 +9,9 @@ int getchar(void);
 int tstc(void);
 
 /* stdout */
-#if !defined(CONFIG_SPL_BUILD) || \
+#if !defined(CONFIG_XPL_BUILD) || \
 	(defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_SERIAL)) || \
-	(defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
+	(defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
 		defined(CONFIG_SPL_SERIAL))
 void putc(const char c);
 void puts(const char *s);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c0397..122987c395e 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -206,7 +206,7 @@ void sunxi_gpio_set_pull(u32 pin, u32 val);
 void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val);
 int sunxi_name_to_gpio(const char *name);
 
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
+#if !defined CONFIG_XPL_BUILD && defined CONFIG_AXP_GPIO
 int axp_gpio_init(void);
 #else
 static inline int axp_gpio_init(void) { return 0; }
diff --git a/include/upl.h b/include/upl.h
index 2ec5ef1b5cf..4d0eca88047 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -320,7 +320,7 @@ int upl_read_handoff(struct upl *upl, oftree tree);
 int upl_get_test_data(struct unit_test_state *uts, struct upl *upl);
 #endif /* USE_HOSTCC */
 
-#if CONFIG_IS_ENABLED(UPL) && defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(UPL) && defined(CONFIG_XPL_BUILD)
 
 /**
  * upl_set_fit_info() - Set up basic info about the FIT
@@ -367,7 +367,7 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc);
 static inline int upl_add_image(const void *fit, int node, ulong load_addr,
 				ulong size)
 {
-	if (CONFIG_IS_ENABLED(UPL) && IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (CONFIG_IS_ENABLED(UPL) && IS_ENABLED(CONFIG_XPL_BUILD)) {
 		const char *desc = fdt_getprop(fit, node, FIT_DESC_PROP, NULL);
 
 		return _upl_add_image(node, load_addr, size, desc);
diff --git a/include/vbe.h b/include/vbe.h
index 5ede8181b98..56bff63362f 100644
--- a/include/vbe.h
+++ b/include/vbe.h
@@ -41,7 +41,7 @@ struct vbe_handoff {
  */
 static inline enum vbe_phase_t vbe_phase(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return VBE_PHASE_FIRMWARE;
 
 	return VBE_PHASE_OS;
diff --git a/lib/Makefile b/lib/Makefile
index d300249f57c..66f84408aae 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_EFI) += efi/
 obj-$(CONFIG_EFI_LOADER) += efi_driver/
@@ -96,7 +96,7 @@ obj-$(CONFIG_LIBAVB) += libavb/
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
 obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
 obj-$(CONFIG_MMC_SPI_CRC_ON) += crc16-ccitt.o
@@ -131,7 +131,7 @@ obj-$(CONFIG_LIB_UUID) += uuid.o
 obj-$(CONFIG_LIB_RAND) += rand.o
 obj-y += panic.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
 ifdef CONFIG_$(SPL_TPL_)USE_TINY_PRINTF
 obj-$(CONFIG_$(SPL_TPL_)SPRINTF) += tiny-printf.o
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bec1bc95a65..3259c951241 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -18,12 +18,12 @@ rsa_public_key-y := \
 	rsa_helper.o
 
 $(obj)/rsapubkey.asn1.o: $(obj)/rsapubkey.asn1.c $(obj)/rsapubkey.asn1.h
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 CFLAGS_rsapubkey.asn1.o += -I$(obj)
 endif
 
 $(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 CFLAGS_rsa_helper.o += -I$(obj)
 endif
 
diff --git a/lib/display_options.c b/lib/display_options.c
index d5df53ab15f..2c15cc5b5c4 100644
--- a/lib/display_options.c
+++ b/lib/display_options.c
@@ -236,7 +236,7 @@ int print_buffer(ulong addr, const void *data, uint width, uint count,
 		addr += thislinelen * width;
 		count -= thislinelen;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc())
 			return -EINTR;
 	}
 
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 5edc8dd2f9f..4199379c872 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1230,7 +1230,7 @@ static void *fdt_find_separate(void)
 	if (IS_ENABLED(CONFIG_SANDBOX))
 		return NULL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* FDT is at end of BSS unless it is in a different memory region */
 	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS))
 		fdt_blob = (ulong *)_image_binary_end;
@@ -1714,7 +1714,7 @@ int fdtdec_setup(void)
 	}
 
 	/* Allow the early environment to override the fdt address */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		ulong addr;
 
 		addr = env_get_hex("fdtcontroladdr", 0);
diff --git a/lib/hang.c b/lib/hang.c
index 3cfb06e9ca8..f3c3c896f0a 100644
--- a/lib/hang.c
+++ b/lib/hang.c
@@ -22,7 +22,7 @@
  */
 void hang(void)
 {
-#if !defined(CONFIG_SPL_BUILD) || \
+#if !defined(CONFIG_XPL_BUILD) || \
 		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
 		 CONFIG_IS_ENABLED(SERIAL))
 	puts("### ERROR ### Please RESET the board ###\n");
diff --git a/lib/hashtable.c b/lib/hashtable.c
index 9613adc5540..e8a59e2dcac 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -221,7 +221,7 @@ static int
 do_callback(const struct env_entry *e, const char *name, const char *value,
 	    enum env_op op, int flags)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (e->callback)
 		return e->callback(name, value, op, flags);
 #endif
@@ -487,7 +487,7 @@ int hdelete_r(const char *key, struct hsearch_data *htab, int flag)
 	return 0;
 }
 
-#if !(defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_SAVEENV))
+#if !(defined(CONFIG_XPL_BUILD) && !defined(CONFIG_SPL_SAVEENV))
 /*
  * hexport()
  */
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 2bc508ff504..29feccd60fc 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -157,7 +157,7 @@ int print_hex_dump(const char *prefix_str, int prefix_type, int rowsize,
 			printf("%s%s\n", prefix_str, linebuf);
 			break;
 		}
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc())
 			return -EINTR;
 	}
 
diff --git a/lib/uuid.c b/lib/uuid.c
index 11b86ffb02e..c6a27b7d044 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -477,7 +477,7 @@ void gen_rand_uuid_str(char *uuid_str, int str_format)
 	uuid_bin_to_str(uuid_bin, uuid_str, str_format);
 }
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_CMD_UUID)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_CMD_UUID)
 int do_uuid(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char uuid[UUID_STR_LEN + 1];
diff --git a/net/bootp.c b/net/bootp.c
index 512ab2ed7c8..afd5b48094a 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -434,7 +434,7 @@ static u8 *add_vci(u8 *e)
 	char *vci = NULL;
 	char *env_vci = env_get("bootp_vci");
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_NET_VCI_STRING)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_NET_VCI_STRING)
 	vci = CONFIG_SPL_NET_VCI_STRING;
 #elif defined(CONFIG_BOOTP_VCI_STRING)
 	vci = CONFIG_BOOTP_VCI_STRING;
diff --git a/net/net.c b/net/net.c
index 1e0b7c85624..fd7d413e488 100644
--- a/net/net.c
+++ b/net/net.c
@@ -305,7 +305,7 @@ U_BOOT_ENV_CALLBACK(dnsip, on_dnsip);
  */
 void net_auto_load(void)
 {
-#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_XPL_BUILD)
 	const char *s = env_get("autoload");
 
 	if (s != NULL && strcmp(s, "NFS") == 0) {
@@ -559,7 +559,7 @@ restart:
 			ping6_start();
 			break;
 #endif
-#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_XPL_BUILD)
 		case NFS:
 			nfs_start();
 			break;
@@ -574,7 +574,7 @@ restart:
 			cdp_start();
 			break;
 #endif
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 		case NETCONS:
 			nc_start();
 			break;
@@ -1439,7 +1439,7 @@ void net_process_received_packet(uchar *in_packet, int len)
 			}
 		}
 
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 		nc_input_packet((uchar *)ip + IP_UDP_HDR_SIZE,
 				src_ip,
 				ntohs(ip->udp_dst),
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5daceb26061..b70b75ee68d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -324,7 +324,7 @@ endif
 # do not delete intermediate files automatically
 .SECONDARY:
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 SPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index ad21d451a30..63d4ec334bc 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -31,7 +31,7 @@ include $(srctree)/scripts/Kbuild.include
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
 
 KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
-KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
+KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
 ifeq ($(CONFIG_TPL_BUILD),y)
 KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
 else
@@ -55,7 +55,7 @@ endif
 
 export SPL_NAME
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 SPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
diff --git a/test/Makefile b/test/Makefile
index ed312cd0a48..f801d87e385 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_$(SPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 38ba89ee33e..53fddebd49d 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -256,7 +256,7 @@ U_BOOT_LONGHELP(ut,
 	"\ntime - very basic test of time functions"
 #endif
 #if defined(CONFIG_UT_UNICODE) && \
-	!defined(CONFIG_SPL_BUILD) && !defined(API_BUILD)
+	!defined(CONFIG_XPL_BUILD) && !defined(API_BUILD)
 	"\nunicode - Unicode functions"
 #endif
 	);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index c12589d487c..c6c63051e0b 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_UT_DM) += test-dm.o
 
 # Tests for particular subsystems - when enabling driver model for a new
 # subsystem you must add sandbox tests here.
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_SPL_OF_PLATDATA) += of_platdata.o
 else
 obj-$(CONFIG_UT_DM) += bus.o
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 70f14c46b1e..a54387a058e 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2018
 # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += cmd_ut_lib.o
 obj-y += abuf.o
 obj-y += alist.o
diff --git a/test/test-main.c b/test/test-main.c
index b3d3e24cdce..479dbb33b72 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -47,7 +47,7 @@ enum fdtchk_t {
 static enum fdtchk_t fdt_action(void)
 {
 	/* For sandbox SPL builds, do nothing */
-	if (IS_ENABLED(CONFIG_SANDBOX) && IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_SANDBOX) && IS_ENABLED(CONFIG_XPL_BUILD))
 		return FDTCHK_NONE;
 
 	/* Do a copy for sandbox (but only the U-Boot build, not SPL) */
diff --git a/tools/binman/test/generated/autoconf.h b/tools/binman/test/generated/autoconf.h
index 6a23039f469..75af48f9116 100644
--- a/tools/binman/test/generated/autoconf.h
+++ b/tools/binman/test/generated/autoconf.h
@@ -1,3 +1,3 @@
 #define CONFIG_BINMAN 1
-#define CONFIG_SPL_BUILD 1
+#define CONFIG_XPL_BUILD 1
 #define CONFIG_SPL_BINMAN_SYMBOLS 1
-- 
2.34.1

