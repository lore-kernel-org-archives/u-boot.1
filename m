Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937F3C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F94983858;
	Thu, 24 Jul 2025 23:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RMi/BQDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C61838EE; Thu, 24 Jul 2025 23:13:47 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5D183844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-749248d06faso1342830b3a.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391624; x=1753996424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgL1qSR2UpzxSal/TtQOMbTEHbNtFE344M4nrQAW3kc=;
 b=RMi/BQDjbGItZCpi+c7i+pvjFhmCLDFyeaTn6o8beOLVon2tU2MEaX8wW7cIz4Lank
 8q+ziOGLSqJlfQHYXlMhmzchg1DF95k2kHOnazLqmjk5++VEyHU7hz8g9ugkzs26gp55
 O8XkGkECi3+jX+63UVAC9ywiC+aFukBftnpH8D+oGarJlNdrTUx+6EP07aWNO0UzznXJ
 bxL6StPr+p2QrAkmZ7qgQqSa4JcO0iRzGbRW+nZDGZ4RYEV35OBywTfWf++WxjX/Uvzq
 exT5tNNdJVfUssWKrafzIVsSWFS150Dp0m2uzHk82tgLk6ljkDN5tMj/pyWrFU1km3T9
 ceAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391624; x=1753996424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgL1qSR2UpzxSal/TtQOMbTEHbNtFE344M4nrQAW3kc=;
 b=W0HRheAtUigJggbbRgQta403sfjzMP27DmcP+uxUc4LdhJScUOUfql2dKFb2l07zEN
 y1URUWSxZ/V3DOR7aIObZ7TE6lPoHNSs0xQBWs/yevkuAjgAK4Eox0UnODnFM5Z+r81o
 nvaLuR817CH79TH7ywDckENjgg51jIBgxwG+k4IkfILsGFpwUy+z5W3BboFgQOYwJoUK
 5kKyaYZb3fc7mj/fqcAJiA/Eht/w4ZqC+A5gLsNJYwfz0vgkTPzT2XJDSVV1QgfkRgZb
 dMLzTOHB7dSIjKz2vo7llh43Wd6mcwPBcyU6eIl3hH9XJd7iZH7mOA/9O1+NtW9xOGTz
 Mn8A==
X-Gm-Message-State: AOJu0Yw4PTGHdzCGluJUURuqiBeK0Zgm09TNGFmd+mcnhwyY7awE72z4
 cqMmm0iSFZomLZ3HlFdoVW7j3S6vQp88ucRR7gjZMK+2qnZkkkREwlPcQHueCg==
X-Gm-Gg: ASbGnctHwY+UQCz5OaR//ZQwUThtPqdQtA6bS6rDS6+d+TrxIM+K3M+2EAgZhBSwdC8
 OJwIcrfhkor3sHrOGQrJv9xQgVO/APEUTR7g6ztASCZXVMEDa/VcEoFTgDRSp/LjIwyZd/E/1OI
 Hbzv0Ki1WMpuoIQpoG7Kq3xqbNNzOuWJLqwivIRWEjNleZIDUkoziZxlCt3ghdS6GAqAQchUBYN
 t5xsQ17HpD6r+kpllXJCUF8IrlEaefI2MTbK2Dxg6GgRVTU6Hd2E0vKRsEfCiBVJVomp2viRM0z
 A3zpDz6Wt2m8zKpQ61TwrIy1YOJwlWZjBxcn6hjIqltW/IXIMUZcLxR83Ua0p5A88xhjVfmsZtK
 b4MsD5aEQf4AP8hSV0KGWcpqxM/tk2cm2sRa0
X-Google-Smtp-Source: AGHT+IGHOF2MNypQ0sEg+9afKmLr78eJ2AtNiYYnoezUQo2KFKEoK+DJa/GWs2vMzV5cIXzTzxJZMQ==
X-Received: by 2002:a05:6a00:138f:b0:74e:ac15:10ff with SMTP id
 d2e1a72fcca58-76034c57330mr13064862b3a.4.1753391623583; 
 Thu, 24 Jul 2025 14:13:43 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:49ad:5ec7:6dba:a80f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761adc708aasm2379009b3a.19.2025.07.24.14.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:13:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250724
Date: Thu, 24 Jul 2025 18:13:39 -0300
Message-Id: <20250724211339.2275409-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:

  block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250724

for you to fetch changes up to b40c9b0c22773c23322423e6206f049d8f82c25d:

  imx93_frdm: Add initial board support (2025-07-24 08:01:03 -0300)

u-boot-imx-master-20250724
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27149

- Add support for the NXP imx93 frdm board.
- imx93_evk and phycore-imx93 cleanups.
- Convert imx6dl-sielaff to OF_UPSTREAM and fix serial download mode boot.
- Fix crash in imx power-domain.
- Migrate Phytec imx8mm boards to standard boot.
- Fix smatch warnings.
----------------------------------------------------------------
Andrew Goodbody (1):
      imx93: adc: local variable ret should not be unsigned

Fabio Estevam (4):
      imx93_evk: Fix the board name in MAINTAINERS title
      imx93_evk: Remove unneeded header files
      imx93_evk: Remove PMIC and USB header files
      imx93_frdm: Add initial board support

Frieder Schrempf (3):
      imx6dl-sielaff: Convert to OF_UPSTREAM
      configs: imx6dl_sielaff: Set CONFIG_SDP_LOADADDR to fix SDP boot
      imx: power-domain: Fix crash due to uninitialized 'id' field

Primoz Fiser (2):
      board: phytec: phycore-imx93: Drop unused PMIC define
      board: phytec: phycore-imx93: Drop unused include files

Vitor Soares (1):
      toradex: tdx-cfg-block: add verdin i.mx8m mini 0216 pid4

Yannic Moog (1):
      board: phytec: migrate imx8mm boards to standard boot

Ye Li (1):
      spl: spl_imx_container: Delete uninitialized variable

 arch/arm/dts/Makefile                           |    2 +-
 arch/arm/dts/imx6dl-sielaff.dts                 |  533 ------
 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi       |  186 +++
 arch/arm/dts/imx93-11x11-frdm.dts               |  603 +++++++
 arch/arm/include/asm/arch-imx9/ddr.h            |    1 +
 arch/arm/mach-imx/imx9/Kconfig                  |    9 +
 board/freescale/imx93_evk/MAINTAINERS           |    2 +-
 board/freescale/imx93_evk/imx93_evk.c           |    3 -
 board/freescale/imx93_frdm/Kconfig              |   12 +
 board/freescale/imx93_frdm/MAINTAINERS          |    6 +
 board/freescale/imx93_frdm/Makefile             |   11 +
 board/freescale/imx93_frdm/imx93_frdm.c         |   59 +
 board/freescale/imx93_frdm/imx93_frdm.env       |   31 +
 board/freescale/imx93_frdm/lpddr4_timing.h      |   12 +
 board/freescale/imx93_frdm/lpddr4x_1gb_timing.c | 1996 +++++++++++++++++++++++
 board/freescale/imx93_frdm/lpddr4x_2gb_timing.c | 1995 ++++++++++++++++++++++
 board/freescale/imx93_frdm/spl.c                |  195 +++
 board/phytec/phycore_imx8mm/phycore_imx8mm.env  |   72 +-
 board/phytec/phycore_imx93/phycore-imx93.c      |    3 -
 board/phytec/phycore_imx93/spl.c                |    7 -
 board/toradex/common/tdx-cfg-block.c            |    1 +
 board/toradex/common/tdx-cfg-block.h            |    1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c     |    3 +-
 common/spl/spl_imx_container.c                  |    4 +-
 configs/imx6dl_sielaff_defconfig                |    4 +-
 configs/imx8mm-phygate-tauri-l_defconfig        |   15 +-
 configs/imx93_frdm_defconfig                    |  124 ++
 configs/phycore-imx8mm_defconfig                |   14 +-
 doc/board/nxp/imx93_frdm.rst                    |   75 +
 doc/board/nxp/index.rst                         |    1 +
 drivers/adc/imx93-adc.c                         |    4 +-
 drivers/power/domain/imx8m-power-domain.c       |    2 +
 include/configs/imx93_evk.h                     |    2 -
 include/configs/imx93_frdm.h                    |   30 +
 34 files changed, 5379 insertions(+), 639 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-sielaff.dts
 create mode 100644 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-11x11-frdm.dts
 create mode 100644 board/freescale/imx93_frdm/Kconfig
 create mode 100644 board/freescale/imx93_frdm/MAINTAINERS
 create mode 100644 board/freescale/imx93_frdm/Makefile
 create mode 100644 board/freescale/imx93_frdm/imx93_frdm.c
 create mode 100644 board/freescale/imx93_frdm/imx93_frdm.env
 create mode 100644 board/freescale/imx93_frdm/lpddr4_timing.h
 create mode 100644 board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
 create mode 100644 board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
 create mode 100644 board/freescale/imx93_frdm/spl.c
 create mode 100644 configs/imx93_frdm_defconfig
 create mode 100644 doc/board/nxp/imx93_frdm.rst
 create mode 100644 include/configs/imx93_frdm.h
