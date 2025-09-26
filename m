Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EF1CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 17:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819A783655;
	Fri, 26 Sep 2025 19:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCko7QU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E12837B6; Fri, 26 Sep 2025 19:09:51 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04FE8835FD
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 19:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-244580523a0so26582155ad.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758906587; x=1759511387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ztp2sZ+lkzqiB5VmZdUKJPMuLd6gNIdsHvGCX7YY4dA=;
 b=HCko7QU6ka5RNUFG1Az9DfVOE4PHX9RuA7a0JPrYAfWRYGaftTn8CQlID8w2DmZwlH
 EfwWTsEfmeOaZWZPAOOB6pYCFHYrtmB5BnhSwS+QOpt2Y2QJu44p5z+gtYvc3xAX4Y4p
 9UxhOALwmBrQQEmAgBRJt3jvJmN5QE7wHVVE4OZ1hdRYkuE5ZH5zyO7sbZnKqgXXn9Gm
 E4n+PujLEDOO74LAiCwem54RWren5sUop8x2oQKey9Rvm8YeAsV6/WlfBgyt6l278rOu
 r/qgEujaV6/PuJSkcHBA4lm6ZR6Lo/QDjP2eFxyyzoS7mvKOLfzCY5La+AQj0SjKMDMO
 JT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758906587; x=1759511387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ztp2sZ+lkzqiB5VmZdUKJPMuLd6gNIdsHvGCX7YY4dA=;
 b=dUkTSGEQ65tAv4gKLIOkbcTlUVnxZ9YA/3zQw8chCl3FnxExxWpkLEpKAlBx8DQHXM
 HzDSVDbRSq01hbEoNY7t5MZx19s9hJVQVI7npXc02CAt2Mj41G2zIbtIRIrJctV/3Dai
 gj57bspWdP/dymABGLFrmYBYXLzqrGzjzMmqKVhE0aYCoNm4xq3mcJQk1V+CNNKNWn5v
 ASSVrYipT1y8meYLI77kChpsxWatNn/RF4mkcgyoWRfWLi+E+/a3JbBq46b/c3XFWvcG
 EsP9lsLCoihbazHuWOmyhoTd8YerhmnCnDXxVu87zFAaWYTt+pP8g53hWfcg22DCAU0G
 UWtg==
X-Gm-Message-State: AOJu0YzINjTZZvdgFB97C3a7JnCKwb/dIHegqy2bQDIkuxWzXbLso+il
 7BJOYeY5cVwumuG5m5d6q8kwcGpDOfDev+VA3Ajbxs5YwMTzvSV+9xkdAMAnCg==
X-Gm-Gg: ASbGnctfNMmsiDBfmbIo3g9TJSvAnBQNHWw3fUX+/8S0annAd22MMJENiwmuC7o3RbL
 OoFapDLTHngmB4lNm+o7FqnhiF8cqz+73lgHRku6S4mnOTLQJqbe4E7aa3Any+xNB3t+eby38Fs
 QO3crXhSuN0h9uo0j8fju+AW2nx5jplu1cfPX7K7PbKLkj4W4ZUzGbk3s2gHsK2ksnzinRSOIHV
 zj7A7jGNdKAXO79y81sjUnkMxt49e30xP9J2vELeLdiR2+7bu5Ajisb0M+L+AhvZHpBeHtJmke2
 4k5Y5mB0emCYOpKSy+SLVi0ntoVYEkhPcUhgJa9oaJ6DmkdvUlklf3pUltZbmfGhfM2dAQWRY+j
 CSixzOl/oYE29u6Xja74Ukz58LB4KW/RKqoGt
X-Google-Smtp-Source: AGHT+IF5O9V5fDd3bfrXurk6f7GqDkz325oo3xadq3KK7TmQRKs21FXsydnmIh+wiJofgTcFo4f4CA==
X-Received: by 2002:a17:903:5c6:b0:27c:3b07:5812 with SMTP id
 d9443c01a7336-27ed4a31712mr63276775ad.36.1758906587451; 
 Fri, 26 Sep 2025 10:09:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d91:23ba:2d44:e936])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed68821aesm59461345ad.90.2025.09.26.10.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 10:09:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250926
Date: Fri, 26 Sep 2025 14:09:43 -0300
Message-Id: <20250926170943.846750-1-festevam@gmail.com>
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

The following changes since commit 44c4919e9dd6c162b237633ba689441eca9a149c:

  test: Fix optee unit test (2025-09-24 11:04:11 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250926

for you to fetch changes up to 1566f803bff58f472c38e2e34204753529d01136:

  imx9: scmi: Add PCIE ECAM and outbound space to MMU (2025-09-26 09:52:54 -0300)

u-boot-imx-next-20250926
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27737

- Add support for i.MX94 EVK.
- Set CONFIG_ETHPRIME to eth0 on phycore-imx93.
- Expand the nxp_fspi support to i.MX8QXP/8DXL/8ULP.
----------------------------------------------------------------
Alice Guo (2):
      cpu: imx94: Add support for i.MX94 in get_imx_type_str()
      pinctrl: nxp: Add i.MX94 daisy register offset

Peng Fan (1):
      imx95: Add get_reset_reason() to retrieve the LM/system last booted/shutdown reasons

Primoz Fiser (1):
      board: phytec: phycore-imx93: Set CONFIG_ETHPRIME to eth0

Ye Li (14):
      imx9: Add i.MX94 CPU type and SoC-level Kconfig
      imx9: scmi: Add i.MX94 support to get_reset_reason()
      imx9: scmi: Update the files under arch/arm/mach-imx/imx9/scmi/ to support i.MX94
      imx: container: Add i.MX94 support to get_imageset_end()
      imx9: Change container header temp buffer address
      imx: ele_ahab: Implement display_life_cycle() for i.MX95
      imx: ele_ahab: Add i.MX94 support to display_life_cycle()
      arm: dts: Add i.MX943 EVK board dtsi files
      imx94_evk: Add i.MX943 EVK board support
      spi: nxp_fspi: Use second last LUT entry for AHB read
      spi: nxp_fspi: Support i.MX8QXP flexspi
      spi: nxp_fspi: Support i.MX8DXL flexspi
      spi: nxp_fspi: Support i.MX8ULP flexspi
      imx9: scmi: Add PCIE ECAM and outbound space to MMU

 arch/arm/dts/imx943-evk-u-boot.dtsi        |  62 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi            | 212 ++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |  11 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |   1 +
 arch/arm/mach-imx/Makefile                 |   2 +-
 arch/arm/mach-imx/ele_ahab.c               |  55 +++++++-
 arch/arm/mach-imx/image-container.c        |   4 +-
 arch/arm/mach-imx/imx9/Kconfig             |  17 +++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   3 +
 arch/arm/mach-imx/imx9/scmi/clock.c        |  29 ++--
 arch/arm/mach-imx/imx9/scmi/common.h       |  41 ++++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 213 +++++++++++++++++++++++++++--
 board/freescale/imx94_evk/Kconfig          |  12 ++
 board/freescale/imx94_evk/MAINTAINERS      |   6 +
 board/freescale/imx94_evk/Makefile         |  11 ++
 board/freescale/imx94_evk/imx94_evk.c      |  41 ++++++
 board/freescale/imx94_evk/imx94_evk.env    | 100 ++++++++++++++
 board/freescale/imx94_evk/spl.c            |  81 +++++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 configs/imx93-phycore_defconfig            |   2 +-
 configs/imx943_evk_defconfig               | 115 ++++++++++++++++
 doc/board/nxp/imx943_evk.rst               | 112 +++++++++++++++
 doc/board/nxp/index.rst                    |   1 +
 drivers/cpu/imx8_cpu.c                     |   2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c     |   5 +-
 drivers/spi/nxp_fspi.c                     |  44 +++++-
 include/configs/imx94_evk.h                |  24 ++++
 include/scmi_nxp_protocols.h               |  55 ++++++++
 30 files changed, 1233 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/dts/imx943-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx943-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/scmi/common.h
 create mode 100644 board/freescale/imx94_evk/Kconfig
 create mode 100644 board/freescale/imx94_evk/MAINTAINERS
 create mode 100644 board/freescale/imx94_evk/Makefile
 create mode 100644 board/freescale/imx94_evk/imx94_evk.c
 create mode 100644 board/freescale/imx94_evk/imx94_evk.env
 create mode 100644 board/freescale/imx94_evk/spl.c
 create mode 100644 configs/imx943_evk_defconfig
 create mode 100644 doc/board/nxp/imx943_evk.rst
 create mode 100644 include/configs/imx94_evk.h
 create mode 100644 include/scmi_nxp_protocols.h
