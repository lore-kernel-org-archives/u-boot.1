Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DCFF9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70028423E;
	Wed, 22 Apr 2026 16:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxowxh5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C378423D; Wed, 22 Apr 2026 16:31:30 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18EB83E76
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcd89701acso1459097a34.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868285; x=1777473085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXY+W+JxORLG1BOq+8h9JAwxdOOX/JxO7S+gDophbPQ=;
 b=bxowxh5wv2Vtr9VLe/4JBg24SX48a5Ae/X/mK+H6kuvQw0IRoxBO1ovnxrui/QX72L
 NkqvC6uHe7vGtX2/014ibCuNEq71SWQhNLIfyGK/yZ9fw5TMfRKxqfbY1I1049Vwqd8M
 TGhMvqpYpXeloEor0qgd5DcAB2i6nIJvKjmRliCpS6EozVKRij/dgjJl4PXqLeAa154d
 iYYNNylvxY+LcEo4Om7dByedjYe+nVhHdfQg2z4X5kBqPiLXobsF6Xoe3B3auvZZwNSm
 WmPUFM4NCuuoMTajet1qx34gwHLy8ft26C8kfgyN9zDYR/ONVbwpufQGsilDeF36/xYe
 ygKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868285; x=1777473085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXY+W+JxORLG1BOq+8h9JAwxdOOX/JxO7S+gDophbPQ=;
 b=azyMgd9Cc5h2CnIPY6M77MIM1zw8Uy84H+/4lyl1DrJLdVq8oyy0exjsotDr96u1N2
 aqpHGr+k3w6jCbBgF/HkqBj164lH1LKPBcZYcDtMVvAyW8dH3KbFS7Z7FpSMVR1L1fUo
 ai5Wa7HuAhvNYEFbknp0j4AS1GBMbzloqJoLZLfb32ZWSBqP8tIOcebzomX1O1CPmXyY
 cUa42Mo/OtxfeN6P/CQICaPkq/W9+fiSf3qy/l6Prn8T+wmv8yDJf1cN7E9nIGPPqXT4
 cTGG6gi3VchdaPt/OQbHPSsYkXPuaequ+M9q/OWwE0chP4YBqb0iKZx1jZZ+msLiBiY/
 R8+A==
X-Gm-Message-State: AOJu0Yy0FOx1wrTNLgXJwk+7bppgnrlo1jwgGkjNCbrmdFaKhVyvpWcZ
 HulFdWPROs8BqFFstmqjdrKh0zawzH5CNCNmp5SjBqfCKvP1xJaJQLhwI09z7kgToKM=
X-Gm-Gg: AeBDies+ZSWKT63DnT1gBul3hEjdwPnGKT94mKBS6hYq8RltZIpMZSqgY+tdOSCbxb5
 O0WjQ3F5qi8R50qk+beFbd2KklDTKQGs2eAZWnpC8fWHP2c8wvoIIuYwh2SBUAsnX1OV4KBbSp3
 ZQ06o3SOhnqmCN4Qoic6AEy9ZVuH6xGtKqbj5GrtGCC+w87UNinaDw3UzGClYJMIstAVBKTLM4x
 gH8VITNOrOT5RgCUA36IWMXjqwlbvK56B8AqbR8h5J6U3U8tWNCle1T/SBMa7bVzV4TeNvskbNA
 EddlsewCvIND4gnbLArqHYhGGJL1+ad3ZS25CLaZaSXP+TtKfgBQ/4quY4l78elYpaOcjT2zCFa
 ngiGhqxHRvJnkH6EPvhCgOkjtV7FY8UTnoF8ue9xR5cNOyCN+i8kV1AO3H+hqZ8S9RkUtCSl5Hb
 58QI6IAWlygg3lMocExuOzIrgKAOGVvyQ/i6HuRNHVnjG0Sgj99N2DNAGzeOFg7NbIECXi+bkvW
 B2Lbr2zNtAEu8tNSKR55w==
X-Received: by 2002:a4a:ee07:0:b0:694:96ff:d51 with SMTP id
 006d021491bc7-69496ff1126mr4636773eaf.23.1776868285034; 
 Wed, 22 Apr 2026 07:31:25 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:24 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 00/16] Add PIN and SPI support for Spacemit K1
Date: Wed, 22 Apr 2026 10:30:56 -0400
Message-Id: <20260422143112.1329478-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add pinctrl, GPIO, and SPI NOR flash support for the Spacemit K1 SoC
and enable U-Boot to boot on K1-based boards.

Notes:
Tested on the Muse Pi Pro.
BananaPi F3 is untestable due to missing SPI NOR flash.

Prerequisite:
-------------
This series depend on another pending-to-merge series [1].

[1] [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/

Raymond Mao (16):
  gpio: add gpio driver for Spacemit K1 SoC
  pinctrl: add pinctrl driver for Spacemit K1 SoC
  dts: k1: fix gpio ranges
  dts: k1: import pinctrl dts file from upstream folder
  dts: k1: remove embedded subnode in pin configs
  configs: k1: enable pinctrl and gpio
  mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
  mtd: spi: enable spi_nor_remove() in soft reset config
  spi: fsl: add support for Spacemit K1 SoC
  dts: k1: add QSPI controller support
  board: k1: enable SPI NOR flash in SPL
  riscv: binman: Always set default configuration in FIT image
  spacemit: k1: append RISCV_MMODE_TIMERBASE
  spacemit: k1: Add multiple device tree support
  spacemit: k1: Add support for mmc regulator initialization
  spacemit: k1: rename device tree prefix from "k1-" to "k1_"

 arch/riscv/dts/Makefile                   |   2 +-
 arch/riscv/dts/binman.dtsi                |   2 -
 arch/riscv/dts/k1-bananapi-f3.dts         |  28 --
 arch/riscv/dts/k1-pinctrl.dtsi            |  19 -
 arch/riscv/dts/k1.dtsi                    |  21 +-
 arch/riscv/dts/k1_bananapi-f3.dts         | 189 ++++++++
 arch/riscv/dts/k1_muse-pi-pro.dts         | 199 ++++++++
 arch/riscv/dts/k1_pinctrl.dtsi            |  79 ++++
 arch/riscv/dts/{k1-spl.dts => k1_spl.dts} |  62 ++-
 board/spacemit/k1/MAINTAINERS             |   2 +
 board/spacemit/k1/spl.c                   |  56 ++-
 configs/spacemit_k1_defconfig             |  37 +-
 drivers/gpio/Kconfig                      |   8 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/spacemit_gpio.c              | 217 +++++++++
 drivers/mtd/spi/Makefile                  |   5 +-
 drivers/mtd/spi/sf_probe.c                |   8 +-
 drivers/pinctrl/Kconfig                   |   1 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/spacemit/Kconfig          |   9 +
 drivers/pinctrl/spacemit/Makefile         |   2 +
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 550 ++++++++++++++++++++++
 drivers/spi/fsl_qspi.c                    |   9 +
 include/configs/k1.h                      |  12 +-
 24 files changed, 1422 insertions(+), 97 deletions(-)
 delete mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 delete mode 100644 arch/riscv/dts/k1-pinctrl.dtsi
 create mode 100644 arch/riscv/dts/k1_bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1_muse-pi-pro.dts
 create mode 100644 arch/riscv/dts/k1_pinctrl.dtsi
 rename arch/riscv/dts/{k1-spl.dts => k1_spl.dts} (88%)
 create mode 100644 drivers/gpio/spacemit_gpio.c
 create mode 100644 drivers/pinctrl/spacemit/Kconfig
 create mode 100644 drivers/pinctrl/spacemit/Makefile
 create mode 100644 drivers/pinctrl/spacemit/pinctrl-k1.c

-- 
2.25.1

