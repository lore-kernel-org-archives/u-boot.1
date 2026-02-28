Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B816FD0046
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 22:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5014C83EC6;
	Sat, 28 Feb 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l067OwKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B4383EC9; Sat, 28 Feb 2026 23:06:52 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467F983CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 23:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-5ff10630b75so2037751137.3
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 14:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772316409; x=1772921209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tNP6W6h54RXSgXxG6B7CTDZw7y7yhvCGm0U+qwSYJTk=;
 b=l067OwKBxfi+Hr7VcY09uoDyKiuVubnt32O/SS61SOO7uMLqli+xuqL38kqGMl+BR6
 VPKS1H31p79K6qI0iLtst/T5eDNgYxHvOQ9zXJa+hUOA370ZepneHtQaugA6MOwy66wm
 hyULMLc+neCbbdW1svTFX5psPFNg00OiYxS1EKrXToLP4xBKDFoLhQuClQqIE9DbhUGs
 2hMo0wGXmyiMIItOPmJTfFBOsaJ38U7qicZmzXNdtyWhaIL0SN41sJBw5c/hAG1aogMY
 3GmpPLIPMJkUZZJ4auHmuoWYBnS7rvD49BfWiJFqOJwd/QRn1OySu65TDIv8fpnjCrbC
 qu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772316409; x=1772921209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNP6W6h54RXSgXxG6B7CTDZw7y7yhvCGm0U+qwSYJTk=;
 b=ah1mVEFJq0zzxHzTTQt7JBD4wElXYCLZLryV/yoA+6CS1KaDzs1NRl+qZlDhPzNfzb
 vRy19zChuFlNi+tJqlJbQC/0VkAn2V0kQKpz9vOskOBDW9PpFkMS55yU69bFL1hkDL2U
 KtTcDNO1WVNJmFvk0IgKT4PXa31cA5bpN1s7lpLpj1RfFuz9m5SOqKH4dIUZXouUS6+b
 u5EEuIFqxvSikJCq4QFk4KXpqTlsGbUekQCsGrN2GdEdXJhM3uUcK2eHZuI6Wwnx8KDZ
 tGHJOPULjQTFZ8A/sjNpjY4S2d/2UsGY5yqSUruPv/ZE2FO4kc0gg57Zzt+IBDiWI5Dz
 YCdw==
X-Gm-Message-State: AOJu0YwjsYpzIhSSacvLs1jbMEHmGmnYbXajw1elgoIVxBDI2eiosGQX
 NURH9DSTYLLlZp3/td35sd3JAXsbHk8ksh3XfdyXs81JdUYWDRCLXhs6
X-Gm-Gg: ATEYQzy336crwm0zv0QWsbby/MfUGrGAbEFrS9dcMRDzOcmPj+5WMNc6E7B3uua0sh7
 59Zi59a2xzryIarm7iaGTzwkYJ52PhJh0IAu8CUyqpdH5MJqFkn9NChqWM74HQEkIdWRvlSwjBY
 lM08QCnLADXDSu4+7prwg/rC1rLNMlqxo62BezDButThyp1HTvAcSwBkiHLYEZyp3wfCtsE613V
 GDqV/7Kf2hD62HA8r1hl/v1qOxj6jq8q+0ya9+M40eQCr8WnYu9Z0qOcl4EUZMPKawkOfCeQDQ4
 SbIcm1Vn6lWy3sDC/8rOHmjEAVzYue4uX4UXQuGGjVWoHJ83oTnFQLMZsZL+05MQxh4x73OjDbK
 n5XrShp9DXjUEIa+Qh7hsVwgPsDKsdpZo57QHT0nxK8q0Sz60LkPQH/N2V71us//1nYDpBOn+WE
 /zy5JEl9XRnATcyQ8DGDKSMGKXLPPm9h4/2qNbjTRGLfL9TAYFDgWVBR3u8tBezK1l9w1unQURP
 8IP93U=
X-Received: by 2002:a05:6102:b0f:b0:5f5:58fa:9ade with SMTP id
 ada2fe7eead31-5ff32273df0mr4232826137.5.1772316408948; 
 Sat, 28 Feb 2026 14:06:48 -0800 (PST)
Received: from fabio-Precision-3551..
 ([2804:1b3:a802:8875:71e7:2e5a:afb7:6b88])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ff1ea15925sm9884504137.8.2026.02.28.14.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 14:06:47 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, hs@nabladev.com, brian.ruley@gehealthcare.com,
 emanuele.ghidoli@toradex.com, kory.maincent@bootlin.com,
 peng.fan@oss.nxp.com, primoz.fiser@norik.com,
 sebastien.szymanski@armadeus.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260228
Date: Sat, 28 Feb 2026 19:06:41 -0300
Message-Id: <20260228220641.362277-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit f6963fc232603007c661411fb31c57f1a9678a87:

  Merge tag 'mmc-next-2026-02-26' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2026-02-26 10:23:12 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260228

for you to fetch changes up to 56e5f5290f2daf886bf6306f426cbb1171deac01:

  arm: imx: imx95: Use arch override for env_get_location() (2026-02-28 15:35:19 -0300)

u-boot-imx-next-20260228
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29404

- Miscelanous improvements for Siemens Capricorn board.
- Convert i.MX6 IPUv3 driver to use clock framework.
- Skip voltage switching for fixed 1.8V regulator on fsl_esdhc_imx.
- Support printing imx8m pinmux.
- Enter fastboot on USB boot by default on phycore-imx93.
- Use arch override for env_get_location() on imx95.
----------------------------------------------------------------
Adrian Freihofer (3):
      siemens: capricorn: set max-frequency for usdhc1
      siemens: capricorn: rework bootcmd environment variables
      siemens: capricorn: protect environment

Brian Ruley (6):
      arch: imx: fix incorrect shutdown call for inactive video devices
      clk: imx6q: apply clang-format
      clk: imx6q: add ipu and ldb clocks and dependencies
      pwm: pwm-imx: enable ipg or per clks only if CONFIG_CLK enabled
      video: imx: ipuv3: move clock code to legacy
      video: imx: ipuv3: use clock framework

Emanuele Ghidoli (1):
      configs: toradex-smarc-imx95: Enable remoteproc

Heiko Schocher (5):
      imx: scu_api: implement sc_misc_get_boot_type
      imx8qx: misc: add command for getting boottype
      capricorn: config: add bootcounter command
      siemens: capricorn: add logic to U-Boot to avoid zig-zag boot
      siemens: capricorn: always detect emmc device

Kory Maincent (1):
      mmc: fsl_esdhc_imx: Skip voltage switching for fixed 1.8V regulator

Lukas Stockmann (3):
      arm: dts: capricorn: pinctrl_usdhc1 cleanup
      arm: dts: capricorn: remove pinctrl_usdhc2
      arm: dts: capricorn: move fec2 config

Peng Fan (13):
      nxp: imx8mp_evk: Enable SPL_CLK_IMX8MP
      nxp: imx8m[m,p]_evk: Drop init_uart_clk
      nxp: imx8mp_evk: Add board_mmc_get_env_dev
      pinctrl: nxp: Kconfig: Typo fix
      pinctrl: nxp: imx8mp: Support print pin muxing
      pinctrl: nxp: imx8mn: Support print pin muxing
      pinctrl: nxp: imx8mm: Support print pin muxing
      pinctrl: nxp: imx8mq: Support print pin muxing
      pinctrl: nxp: imx8m: Guard pinctrl match table with CONFIG_IMX8M[X]
      pinctrl: nxp: imx93: Rename to imx9
      pinctrl: nxp: imx93: Support print pin muxing
      pinctrl: nxp: imx91: Support print pin muxing
      pinctrl: nxp: imx9: Guard pinctrl match table with CONFIG_IMX9[X]

Primoz Fiser (1):
      board: phytec: phycore-imx93: Enter fastboot on USB boot by default

Sébastien Szymanski (1):
      arm: imx: imx95: Use arch override for env_get_location()

Walter Schweizer (2):
      imx8qxp_capricorn config: add wget command
      siemens: capricorn: fix fallback bootm call for fitImage

 arch/arm/dts/imx8-capricorn-cxg3.dts          |  44 +++
 arch/arm/dts/imx8-capricorn.dtsi              |  60 +---
 arch/arm/mach-imx/cpu.c                       |   3 +-
 arch/arm/mach-imx/imx8/misc.c                 |  33 ++
 arch/arm/mach-imx/imx9/scmi/soc.c             |   2 +-
 board/nxp/imx8mm_evk/spl.c                    |   2 -
 board/nxp/imx8mp_evk/imx8mp_evk.c             |   7 +
 board/nxp/imx8mp_evk/spl.c                    |   2 -
 board/phytec/phycore_imx93/phycore-imx93.c    |   5 +
 board/siemens/capricorn/Kconfig               |   2 +
 board/siemens/capricorn/board.c               |  56 ++--
 board/siemens/capricorn/capricorn_default.env | 100 ++++--
 configs/imx8mp_evk_defconfig                  |   1 +
 configs/imx8qxp_capricorn.config              |   3 +
 configs/toradex-smarc-imx95_defconfig         |   4 +
 drivers/clk/imx/clk-imx6q.c                   | 424 ++++++++++++++++++++++----
 drivers/clk/imx/clk.h                         |   9 +
 drivers/misc/imx8/scu_api.c                   |  25 ++
 drivers/mmc/fsl_esdhc_imx.c                   |   5 +-
 drivers/pinctrl/nxp/Kconfig                   |   6 +-
 drivers/pinctrl/nxp/Makefile                  |   2 +-
 drivers/pinctrl/nxp/pinctrl-imx.h             |   8 +
 drivers/pinctrl/nxp/pinctrl-imx8m.c           |  62 ++++
 drivers/pinctrl/nxp/pinctrl-imx8mm.c          | 310 +++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mn.c          | 310 +++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mp.c          | 309 +++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mq.c          | 310 +++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx9.c            |  89 ++++++
 drivers/pinctrl/nxp/pinctrl-imx91.c           | 228 ++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx93.c           | 244 +++++++++++++--
 drivers/pwm/pwm-imx.c                         |  48 +--
 drivers/video/imx/Kconfig                     |   7 +
 drivers/video/imx/Makefile                    |   1 +
 drivers/video/imx/ipu.h                       |  60 +++-
 drivers/video/imx/ipu_clk_legacy.c            | 310 +++++++++++++++++++
 drivers/video/imx/ipu_common.c                | 371 ++++------------------
 drivers/video/imx/ipu_disp.c                  | 142 +++++++--
 drivers/video/imx/mxc_ipuv3_fb.c              |  17 ++
 include/configs/capricorn-common.h            |  13 +
 include/firmware/imx/sci/sci.h                |   1 +
 40 files changed, 3074 insertions(+), 561 deletions(-)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx8mm.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx8mn.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx8mp.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx8mq.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx9.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx91.c
 create mode 100644 drivers/video/imx/ipu_clk_legacy.c
