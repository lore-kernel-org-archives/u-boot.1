Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B0FCF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 15:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B4488EF2;
	Sun, 13 Oct 2024 17:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqryOk37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB47688EF9; Sun, 13 Oct 2024 17:56:22 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8908988ECE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 17:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso3030112f8f.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728834980; x=1729439780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wkDj0NkTZfxrBPuXgaZu5j2Vlhodm5JCb8CNoMcg3oA=;
 b=mqryOk378m6Na8oMKv5IJarB9vrTA33jxYJ8mdD/JesMisr4pZ2NkZePrQpkRvbJxy
 QPmqcWTlCpU0k5/3/tdevcF37m3elO2x0zdd1u3zoIpHoeiemcXWCyzjKoGXtkq7SDAD
 6aqPOW46xjbl0InzJChRJT0y4un/msQSXobgQSTlXFFblL/sUIsm9zbaYxORvfDA984o
 6DopKq8jobbAaDlKUl8c7wevrX9xMhl3YJkMmRc1fNYQKhc4q7urjzg/NImpsRpnP9xu
 hKxf0CR4CKRJ89vtP0KVAExwKpcVIYR3vb4D0u3gF4Av7QxQ2+66chv+d50/4J6Sedv1
 iHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728834980; x=1729439780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wkDj0NkTZfxrBPuXgaZu5j2Vlhodm5JCb8CNoMcg3oA=;
 b=ASZo/2pdvy47lIaFKkP2nmr/D2y2twjLqGLXL9TkShB6jhfF4W+vv4p0elHUjoa7XS
 6s0KMAKKbNa02JhcPK3tDOu6hSiNuKrEi8JkISrODxpUqn06QgA9G1WOBCsZtqFaZkHo
 3u2ATDYO4kgclCa7d9izlPiBKoVL4yjOIY6h54lbFaPcnHoiZq+ohowjkliRsbVyf580
 fnxDXH+8JnSR/eZm5VznvqOeQjopNDduHgvwIb+MwdW1vRNK/m6FGgDWfhFldHAF5lpl
 M4IijX8+yJf+ySUWtrQo4y4qDVMyLvEwglXUsb+P/tNJZjR1SwjauGXrk8cBTqtzzEMU
 qLzg==
X-Gm-Message-State: AOJu0YyLIxqEEKqo6U7bIEjgebI/LDxB6KLJRjuFBOK04HSwh5wO2gNs
 KN0Jw8gnPwnvp62poi9/nttpGGzsX7llFuQk440+k9ScAz5s1mTCog6X0A==
X-Google-Smtp-Source: AGHT+IGly80EpkUYgOPNJJ6Y5OgY1f4lE1VsnLvufJ8YMVAEi5frtSW/d9VJwtdDnbL8t6H+L7+JYg==
X-Received: by 2002:adf:efcb:0:b0:37d:4cd6:e8e with SMTP id
 ffacd0b85a97d-37d601db890mr4724810f8f.48.1728834979532; 
 Sun, 13 Oct 2024 08:56:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99d7944ce2sm247549466b.150.2024.10.13.08.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 08:56:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Sun, 13 Oct 2024 18:55:58 +0300
Message-ID: <20241013155604.87584-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Dear Tom,

The following changes since commit 93b9cd792089e536f2bfa85d9903fd4798209f76:

  mtd: simplify CONFIG_DM_SPI_FLASH dependencies (2024-10-09 14:52:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 711fcd3bdad52ba058e8ca3cf1673bf1b8299be2:

  video: panel: add Sharp LQ101R1SX01 MIPI DSI panel driver (2024-10-13 17:33:46 +0300)

----------------------------------------------------------------
Ion Agorria (2):
      arm: tegra: fix typo in logging functions
      arm: tegra: add AP20 and AP20H SKU

Jonas Schwöbel (1):
      Tegra30: Add funcmux for UART over SD slot

Svyatoslav Ryhel (13):
      disk: add TegraPT support
      board: tegra: convert boards to text env
      ARM: tegra: board2: add common dtb reselect logic
      ARM: tegra-u-boot: add recipe for multi-dtb image
      drivers: tegra_gpio: add early SPL functions
      board: asus: grouper: dynamically detect correct SPL configuration
      board: htc: endeavoru: simplify RCM hook
      board: asus: grouper: implement multi-DTB support
      board: asus: transformer: implement multi-DTB support
      usb: host: tegra: get usb phy configuration from phy node
      video: tegra20: dc: remove DECLARE_GLOBAL_DATA_PTR use
      video: tegra20: dsi: add ganged mode support
      video: panel: add Sharp LQ101R1SX01 MIPI DSI panel driver

 arch/arm/dts/tegra-u-boot.dtsi                          |  22 +++++
 arch/arm/include/asm/arch-tegra/tegra.h                 |   3 +-
 arch/arm/include/asm/arch-tegra/usb.h                   |  11 ++-
 arch/arm/include/asm/arch-tegra30/funcmux.h             |   1 +
 arch/arm/mach-tegra/ap.c                                |  11 ++-
 arch/arm/mach-tegra/board.c                             |   2 +-
 arch/arm/mach-tegra/board2.c                            |  16 ++++
 board/asus/grouper/MAINTAINERS                          |   4 +-
 board/asus/grouper/Makefile                             |   6 +-
 board/asus/grouper/board-info.c                         |  84 ++++++++++++++++
 board/asus/grouper/configs/grouper_E1565.config         |   6 --
 board/asus/grouper/configs/grouper_PM269.config         |   6 --
 board/asus/grouper/configs/tilapia.config               |   7 --
 board/asus/grouper/grouper-spl-max.c                    |  45 ---------
 board/asus/grouper/grouper-spl-ti.c                     |  41 --------
 board/asus/grouper/grouper-spl.c                        | 105 ++++++++++++++++++++
 board/asus/grouper/grouper.env                          |  15 +++
 board/asus/transformer-t20/transformer-t20.env          |  17 ++++
 board/asus/transformer-t30/MAINTAINERS                  |   1 -
 board/asus/transformer-t30/Makefile                     |   1 +
 board/asus/transformer-t30/board-info.c                 | 110 +++++++++++++++++++++
 board/asus/transformer-t30/configs/p1801-t.config       |   3 -
 board/asus/transformer-t30/configs/tf201.config         |   3 -
 board/asus/transformer-t30/configs/tf300t.config        |   3 -
 board/asus/transformer-t30/configs/tf300tg.config       |   3 -
 board/asus/transformer-t30/configs/tf300tl.config       |   3 -
 board/asus/transformer-t30/configs/tf600t.config        |   6 --
 board/asus/transformer-t30/configs/tf700t.config        |   4 -
 board/asus/transformer-t30/transformer-t30.env          |  17 ++++
 board/htc/endeavoru/endeavoru-spl.c                     |  63 +++++-------
 board/htc/endeavoru/endeavoru.env                       |  13 +++
 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env        |  16 ++++
 board/lg/x3-t30/configs/p880.config                     |   1 +
 board/lg/x3-t30/configs/p895.config                     |   1 +
 board/lg/x3-t30/p880.env                                |  15 +++
 board/lg/x3-t30/p895.env                                |  13 +++
 board/microsoft/surface-rt/surface-rt.env               |  14 +++
 board/nvidia/cardhu/cardhu.env                          |   2 +
 board/nvidia/p2771-0000/p2771-0000.env                  |  22 +++++
 board/nvidia/p3450-0000/p3450-0000.env                  |   7 ++
 board/toradex/apalis-tk1/apalis_tk1.env                 |  45 +++++++++
 board/toradex/apalis_t30/apalis_t30.env                 |   9 ++
 board/toradex/colibri_t20/colibri_t20.env               |   3 +
 board/toradex/colibri_t30/colibri_t30.env               |   9 ++
 board/wexler/qc750/qc750.env                            |  15 +++
 configs/apalis-tk1_defconfig                            |   3 +-
 configs/apalis_t30_defconfig                            |   1 +
 configs/cardhu_defconfig                                |   1 +
 configs/colibri_t20_defconfig                           |   1 +
 configs/colibri_t30_defconfig                           |   1 +
 configs/endeavoru_defconfig                             |   1 +
 configs/{grouper_common_defconfig => grouper_defconfig} |  11 +++
 configs/ideapad-yoga-11_defconfig                       |   1 +
 configs/p2771-0000-000_defconfig                        |   1 +
 configs/p3450-0000_defconfig                            |   1 +
 configs/qc750_defconfig                                 |   1 +
 configs/surface-rt_defconfig                            |   1 +
 configs/transformer_t20_defconfig                       |   1 +
 configs/transformer_t30_defconfig                       |   9 ++
 disk/Kconfig                                            |  10 ++
 disk/part_efi.c                                         |  13 +++
 doc/board/asus/{grouper_common.rst => grouper.rst}      |   8 +-
 doc/board/asus/index.rst                                |   2 +-
 doc/board/asus/transformer_t30.rst                      |  13 ++-
 drivers/gpio/tegra_gpio.c                               |  50 ++++++++++
 drivers/pinctrl/tegra/funcmux-tegra30.c                 |  16 ++++
 drivers/usb/host/ehci-tegra.c                           | 136 +++++++++++++++++++++-----
 drivers/video/Kconfig                                   |   9 ++
 drivers/video/Makefile                                  |   1 +
 drivers/video/sharp-lq101r1sx01.c                       | 282 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/tegra20/tegra-dc.c                        |   2 -
 drivers/video/tegra20/tegra-dsi.c                       |  95 +++++++++++++++++-
 drivers/video/tegra20/tegra-dsi.h                       |  15 ++-
 include/configs/apalis-tk1.h                            |  58 -----------
 include/configs/apalis_t30.h                            |  12 ---
 include/configs/cardhu.h                                |   4 -
 include/configs/colibri_t20.h                           |  11 ---
 include/configs/colibri_t30.h                           |  12 ---
 include/configs/endeavoru.h                             |  43 ---------
 include/configs/grouper.h                               |  45 ---------
 include/configs/ideapad-yoga-11.h                       |  58 -----------
 include/configs/p2771-0000.h                            |  20 ----
 include/configs/p3450-0000.h                            |  13 ---
 include/configs/qc750.h                                 |  42 --------
 include/configs/surface-rt.h                            |  18 ----
 include/configs/transformer-common.h                    |  91 ------------------
 include/configs/transformer-t20.h                       |   4 +-
 include/configs/transformer-t30.h                       |   6 +-
 include/configs/x3-t30.h                                |  44 ---------
 include/env/nvidia/prod_upd.env                         |  60 ++++++++++++
 include/spl_gpio.h                                      |  19 ++++
 91 files changed, 1348 insertions(+), 702 deletions(-)
 create mode 100644 board/asus/grouper/board-info.c
 delete mode 100644 board/asus/grouper/configs/grouper_E1565.config
 delete mode 100644 board/asus/grouper/configs/grouper_PM269.config
 delete mode 100644 board/asus/grouper/configs/tilapia.config
 delete mode 100644 board/asus/grouper/grouper-spl-max.c
 delete mode 100644 board/asus/grouper/grouper-spl-ti.c
 create mode 100644 board/asus/grouper/grouper-spl.c
 create mode 100644 board/asus/grouper/grouper.env
 create mode 100644 board/asus/transformer-t20/transformer-t20.env
 create mode 100644 board/asus/transformer-t30/board-info.c
 delete mode 100644 board/asus/transformer-t30/configs/p1801-t.config
 delete mode 100644 board/asus/transformer-t30/configs/tf201.config
 delete mode 100644 board/asus/transformer-t30/configs/tf300t.config
 delete mode 100644 board/asus/transformer-t30/configs/tf300tg.config
 delete mode 100644 board/asus/transformer-t30/configs/tf300tl.config
 delete mode 100644 board/asus/transformer-t30/configs/tf600t.config
 delete mode 100644 board/asus/transformer-t30/configs/tf700t.config
 create mode 100644 board/asus/transformer-t30/transformer-t30.env
 create mode 100644 board/htc/endeavoru/endeavoru.env
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
 create mode 100644 board/lg/x3-t30/p880.env
 create mode 100644 board/lg/x3-t30/p895.env
 create mode 100644 board/microsoft/surface-rt/surface-rt.env
 create mode 100644 board/nvidia/cardhu/cardhu.env
 create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
 create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
 create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
 create mode 100644 board/toradex/apalis_t30/apalis_t30.env
 create mode 100644 board/toradex/colibri_t20/colibri_t20.env
 create mode 100644 board/toradex/colibri_t30/colibri_t30.env
 create mode 100644 board/wexler/qc750/qc750.env
 rename configs/{grouper_common_defconfig => grouper_defconfig} (84%)
 rename doc/board/asus/{grouper_common.rst => grouper.rst} (93%)
 create mode 100644 drivers/video/sharp-lq101r1sx01.c
 delete mode 100644 include/configs/transformer-common.h
 create mode 100644 include/env/nvidia/prod_upd.env

Branch contains:
- TegraPT support bringup
- convertion of tegra boards to use text env
- set of changes required for multi-dtb support (tegra board level)
- SPL gpio functions required for early board rev detection
- switching transformers and grouper to multi-dtb
- fix of namings for Tegra 2 cpu versions
- minor tegra USB driver adjustments
- dsi ganged mode bringup + ganged mode panel

Ganged mode commits are hanging for more than month without comments
so I assume they are acceptable.

All commits passed U-Boot checks and buildman for tegra.

Thanks,
Svyatoslav Ryhel.
