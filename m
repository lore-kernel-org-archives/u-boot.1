Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4081ECA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B89E8366F;
	Fri,  5 Sep 2025 15:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mat++Q2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9128366F; Fri,  5 Sep 2025 15:27:17 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EFA83622
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-544b58831c8so681912e0c.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757078833; x=1757683633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Rb1fc3LL1EnW9beDKlOw8MvYr7NFoccu1FTqRD6mUg=;
 b=mat++Q2Ry/TyjG1vCwiUUxSFjkzJAiGSdyAsV5bByCzvxCqljK+jbmqlNyV+Rbbl3Z
 me3IN9tSckP4wp4yw5lX4VQTOipGoAlanXchUePizd6L2UrJSTyyvigxZJ0XW5G3DEJ0
 sI7YmVpkuSy77a9aO/gC8JYD6jZBq2WA65TJpB5nkOcvLX0dNF73g1D5ltVTm7kc1t5K
 CcQ2DzGOs/i7yzoKeWacj/1OYVv2NUF0ZitfRxKYIvXHAB1g/t+QM0UzetruIJpKHKCu
 KqtXzovZF6nYAmVRAH73AC4934/FHjszHs5IRat1GkRgJN30Ei2R57aZKlO0Dx4ESqKx
 tKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757078833; x=1757683633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Rb1fc3LL1EnW9beDKlOw8MvYr7NFoccu1FTqRD6mUg=;
 b=NgdiUUKXyEgOHsWuQX42+xz5R5ppD2HbHZbfFqKUOP83nzqIanYTqph/pgpVIUXmLE
 xS0Ht36LEOhk+NcLR5S2xwgF1PUrU+X1ODSoDWMi7hJD4CGnM9p4iUOcGwFvQuN/s0xe
 Oh2kXFdQJiIhwgBs6uVKvQSR9FfR57rUMG2PLeA/IHYafcDve+heJuvwakUvjlK8nq/M
 R5IWY+pHSWHgezp2OCzeKarBZtOZLsx6jPnyFwmLHift6jl4jm0GcZzHiEKX3AhrzMFW
 B+yn9lJSR8ZYVgMmqGVUrx0sSw4YhNooGNQo909NHtFmamhIYrMcSEbrRCqyZgOkbEGV
 dqxg==
X-Gm-Message-State: AOJu0YzogbBHVLuYrzXeCLEADXRj1KdQJ8+ZyXEUkTudfJ7YE2oCkQqo
 0ZOETo73yBQ8Yw7TdbDvOFblSSDlrDB/aO32YLTYB7zGLKkKDEL/MjmotSQFww==
X-Gm-Gg: ASbGncu+Ssv1c9Z4P1PQ/Uo7PXoYzGdXNEAD7SIF91+qUKR5afOVxhc3U+guY+nWWbL
 M5nG3FkEZh7PjhNek/7FvGFdyxUUZ/9T+XNtmlOAT6gDaSMWjbJeBGfHKC5tM+0K5gth+DSJMlJ
 GzNvoMWrPXgH/3GHviGJSiYp2Nh95U7vwEVdVqHWuk9VP9xMipR57+qP1yXanuQIaV+AXczC48Q
 mc0WM8v8nMam64gx2Oxh9KKgArOXYr8Yp/eJZgOtNTiyOY0aMhPVZBgxyyOYCe3Y2Y2ZuNXVnWR
 veDcmC4JfzEtdFbAc/2QsAgCimEfYkyl60GdXAZiHED5GFrA3X1hhgE1YqLOPqEDPG4CIC99iFl
 Kkm5nYv0gCsaVPrZvPD/NPZZJ0YKjjU5E3Xd8nY0vOIwXw4A=
X-Google-Smtp-Source: AGHT+IGajIp5ljb3OZOtvPLMl15OLXfDrvHrtbf1UBlJCQOhcPvy0ZTIBIjLGt9cF0E9qQwuMtnyNw==
X-Received: by 2002:a05:6122:90b:b0:53f:7828:16c7 with SMTP id
 71dfb90a1353d-544a02f4ce9mr8332528e0c.15.1757078833079; 
 Fri, 05 Sep 2025 06:27:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:de21:dc3d:c376:809e])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912fdff1sm9482259e0c.10.2025.09.05.06.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 06:27:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250905a
Date: Fri,  5 Sep 2025 10:27:08 -0300
Message-Id: <20250905132708.184530-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit e31947724f69faaa6b0ccd2539052781358b0572:

  Merge patch series "memtest performance improvements" (2025-09-02 14:11:45 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250905a

for you to fetch changes up to 28d6f787b0deb3f66118857297a855233eba18d1:

  Add imx8mp-libra-fpsc board (2025-09-05 09:04:59 -0300)

u-boot-imx-next-20250905a
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27573

- Several improvements for kontron-sl-mx6ul.
- Add Phytec imx8mp-libra-fpsc board
- Add redundant environment support for imx8m evk boards.
- Several improvements for phycore-imx93.
----------------------------------------------------------------
Annette Kobou (2):
      imx: kontron-sl-mx6ul: Enable fastboot support
      imx: kontron-sl-mx6ul: Autostart fastboot if booted from USB

Benjamin Hahn (1):
      Add imx8mp-libra-fpsc board

Eberhard Stoll (2):
      imx: kontron-sl-mx6ul: Enable CONFIG_ENV_IS_NOWHERE
      imx: kontron-sl-mx6ul: Force default environment for serial loader boot

Fabio Estevam (1):
      imx8m[m,n,p]_evk: Add redundant environment support

Frieder Schrempf (6):
      imx: kontron-sl-mx6ul: Fix include statements for local header
      imx: kontron-sl-mx6ul: Enable standard boot and disable legacy distro boot
      imx: kontron-sl-mx6ul: Set CONFIG_SDP_LOADADDR to fix SDP boot
      imx: kontron-sl-mx6ul: Enable second ethernet interface
      imx: kontron-sl-mx6ul: Enable watchdog and sysreset
      imx: kontron-sl-mx6ul: Switch to OF_UPSTREAM

Ilias Apalodimas (1):
      tools: imx8image: Make imx8image_check_params() static

Oualid Derouiche (1):
      imx: kontron-sl-mx6ul: Enable redundant environment

Primoz Fiser (3):
      arm: dts: imx93-phyboard-segin-u-boot: Clean-up already upstream nodes
      configs: imx93-phycore_defconfig: Disable CONFIG_AHAB_BOOT
      board: phytec: phycore-imx93: Use CONFIG_PHYTEC_EEPROM_BUS

 arch/arm/dts/Makefile                              |    4 +-
 arch/arm/dts/imx6ul-kontron-bl-43.dts              |  103 --
 arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi  |   12 +-
 arch/arm/dts/imx6ul-kontron-bl-common.dtsi         |  406 -----
 arch/arm/dts/imx6ul-kontron-bl.dts                 |   16 -
 arch/arm/dts/imx6ul-kontron-sl-common.dtsi         |  137 --
 arch/arm/dts/imx6ul-kontron-sl.dtsi                |   14 -
 arch/arm/dts/imx6ull-kontron-bl.dts                |   15 -
 arch/arm/dts/imx6ull-kontron-sl.dtsi               |   13 -
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |  131 ++
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi      |  219 +--
 arch/arm/mach-imx/imx8m/Kconfig                    |   10 +
 board/kontron/sl-mx6ul/sl-mx6ul-common.c           |    2 +-
 board/kontron/sl-mx6ul/sl-mx6ul.c                  |   23 +-
 board/kontron/sl-mx6ul/spl.c                       |    3 +-
 board/phytec/imx8mp-libra-fpsc/Kconfig             |   16 +
 board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |    9 +
 board/phytec/imx8mp-libra-fpsc/Makefile            |   10 +
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |   89 +
 .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   19 +
 board/phytec/imx8mp-libra-fpsc/imximage-8mp-sd.cfg |    9 +
 board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c     | 1813 ++++++++++++++++++++
 board/phytec/imx8mp-libra-fpsc/spl.c               |  132 ++
 board/phytec/phycore_imx93/phycore-imx93.c         |    2 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 configs/imx8mn_ddr4_evk_defconfig                  |    6 +-
 configs/imx8mn_evk_defconfig                       |    6 +-
 configs/imx8mp-libra-fpsc_defconfig                |  175 ++
 configs/imx8mp_evk_defconfig                       |    6 +-
 configs/imx8mq_evk_defconfig                       |    6 +-
 configs/imx93-phycore_defconfig                    |    2 +-
 configs/kontron-sl-mx6ul_defconfig                 |   32 +-
 doc/board/phytec/imx8mp-libra-fpsc.rst             |   83 +
 doc/board/phytec/index.rst                         |    1 +
 include/configs/imx8mp-libra-fpsc.h                |   27 +
 include/configs/kontron-sl-mx6ul.h                 |   12 -
 tools/imx8image.c                                  |    2 +-
 37 files changed, 2636 insertions(+), 931 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-43.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ull-kontron-sl.dtsi
 create mode 100644 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
 create mode 100644 board/phytec/imx8mp-libra-fpsc/Kconfig
 create mode 100644 board/phytec/imx8mp-libra-fpsc/MAINTAINERS
 create mode 100644 board/phytec/imx8mp-libra-fpsc/Makefile
 create mode 100644 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
 create mode 100644 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
 create mode 100644 board/phytec/imx8mp-libra-fpsc/imximage-8mp-sd.cfg
 create mode 100644 board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c
 create mode 100644 board/phytec/imx8mp-libra-fpsc/spl.c
 create mode 100644 configs/imx8mp-libra-fpsc_defconfig
 create mode 100644 doc/board/phytec/imx8mp-libra-fpsc.rst
 create mode 100644 include/configs/imx8mp-libra-fpsc.h
