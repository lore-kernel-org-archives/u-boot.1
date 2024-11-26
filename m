Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BF3D3B986
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 11:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF7F8973E;
	Tue, 26 Nov 2024 12:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T8vSONtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F3D896D1; Tue, 26 Nov 2024 12:58:07 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988DE8973E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7f450f7f11dso3896896a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732622283; x=1733227083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rSHpHlXVC+pqqwvM/VPIDv5sCGtMV/DoDO0eet/GqUU=;
 b=T8vSONtw/JLZ9owUzYLYElqdjk6gJeM+7HU+kCF9IKGrteUDc8Vy6UYD//O8lDXx3/
 0BqYYHqgk5sxtXTRrXaymezm3UgkjBZ0CeQfH6aqAaZig3BVL/lrUaZACe9q93NtXpFh
 2lKvnH2sqR5ieyNaOyssbgbQTLo3p8aymeLhfYTVXMAjd5OXxDzNLlexeSovdinUoyXe
 7vQfa1bVHxyI1Kh16Azzg/ANW/5p4NP4hXTsgOfQBxCCtyN21RtxXWEGXb0dz/4k5pmy
 OnYbxBr9EDe/RII4mlor6vXxj+5R4D5Ja4inC+i1RhyzPSao9XqtXnt4ONsX7+njMJcR
 klSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732622283; x=1733227083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSHpHlXVC+pqqwvM/VPIDv5sCGtMV/DoDO0eet/GqUU=;
 b=j+f9NxXxe3SWkRfGJLWPMWN1PvM8nRdyMMeGOC99l9NtvHwJUM6vlOncQuYFlJhF2C
 kTSXrMh8+rn1so4qCkVCn3Q7Vy6vHBhkzFpPZit9lKCpVoSfM9x/gvd2pVE0FlPsxpge
 jtm9PbVvPVnFX/DEf+p0cA2BW9aKXXjvpBTv0OUHkK9b9CWK2mnh2vm3PPRHEwKqoF2X
 b6ix9rTy/MuQTC1tvnXw5Tz8jQJQdmeT12VMPnWnxAZolZfDeuCFjylahDuAbQPbRLdj
 VDMJa4A7SX8D7dYNddrygwtCaZ79z37W7D74OOnSqbq3BAqsEQ0ml9VTLTE/TQyQaXaT
 MZAw==
X-Gm-Message-State: AOJu0Yy0JEKAVbfq5Cogc3q+2wzXnYgaP8Q9Bl/Amc62kBufNSZDFzk1
 fG/f9dh+UuAQcHMqxs3oH0KKDfESDjzGKIL0G7xU1jZQpoqVWW19LR6fpA==
X-Gm-Gg: ASbGncusGxNK7ZEM3BV+jvxgQdYekGruUtihfOqcTcxhAb8i33R3jSpUbTDcgI544BM
 Z+dhGPAnTu0IlMPSiKS+VZOh5nHGZOR7EwG+4W7wG38QcsXEXvM5Ecp2crrz02WzHMkqIx4h3sB
 G9ecSLqaAclecJy3PbS9F40Reo176q5N6t3mCVMRxZdVLhjxwUdDLBUnQ+upFrd5QUZOzLt/Eey
 A2XwdOeQv2Qa/7YYpNnC12oJClYDOlfwUfQwFmmDQk14B6H7eA9JvUWte1GqRvb
X-Google-Smtp-Source: AGHT+IEGsWnniOR5ypLbs2R4cGlRpXE7wK1kXXnWp5gnlZv5VlF1HyRnajostkbWhyJ86OPwEYiQ9g==
X-Received: by 2002:a05:6a21:998c:b0:1e0:dd4a:46b3 with SMTP id
 adf61e73a8af0-1e0dd4a480fmr427901637.16.1732622282982; 
 Tue, 26 Nov 2024 03:58:02 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2838:caa9:72e8:7486])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-212a1c17c62sm79364335ad.18.2024.11.26.03.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 03:58:02 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20241126
Date: Tue, 26 Nov 2024 08:57:59 -0300
Message-Id: <20241126115759.1117890-1-festevam@gmail.com>
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

The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d911:

  Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20241126

for you to fetch changes up to a488d9f26e37bcb5776bc8a2dadb708f1ac9cfdc:

  board: phytec: phycore-imx8mm: Add EEPROM detection initialisation (2024-11-25 23:08:24 -0300)

u-boot-imx-next-20241126
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23563

- Make Siemens i.MX8 Capricorn board to boot U-Boot mainline again.
- Add support for phycore-imx93 2GB LPDDR4X variant.
- Add phycore-imx8mm EEPROM detection initialisation.
----------------------------------------------------------------
Alessandro Zini (1):
      siemens: capricorn: add HW version information to boot log

Christoph Stoidner (3):
      board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM timings
      board: phytec: imx93: Add eeprom-based hardware introspection
      board: phytec: imx93: Add phyCORE-i.MX 93 support for all SOM variants

Enrico Leto (6):
      siemens: capricorn: move to cxg3 reference project with deneb board
      siemens: capricorn: get ram size from system controller
      siemens: capricorn: get module name from eeprom
      siemens: add ddr full memory test
      siemens: add ddr signal integrity test
      siemens: capricorn: update maintainers

Heiko Schocher (13):
      wdt: imx8qxp: add option to control external PMIC wdt via IMX8 SCU
      net: fec_mxc: fix probing for imx8qxp
      tools: imx8image: Improve error message
      imx: imx_cntr_image.sh: prevent warning for missing spl
      imx8qxp: Fix build when using SPL
      siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
      siemens: capricorn: use DCD_SKIP entry
      siemens: imximage.cfg: correct comment
      siemens: imximage.cfg: sync image names
      siemens: configs/capricorn_cxg3_defconfig: updates
      siemens: capricorn: sync spl code with 8qxp-mek
      siemens: imx8-capricorn.dtsi: add wdt device
      siemens: capricorn: small board updates

Yunus Bas (1):
      board: phytec: phycore-imx8mm: Add EEPROM detection initialisation

 arch/arm/dts/Makefile                              |   3 +-
 arch/arm/dts/imx8-capricorn-cxg3.dts               | 129 ++++
 ...corn-u-boot.dtsi => imx8-capricorn-u-boot.dtsi} |  67 +-
 ...{imx8qxp-capricorn.dtsi => imx8-capricorn.dtsi} | 109 +--
 arch/arm/dts/imx8-deneb.dts                        |  10 -
 arch/arm/dts/imx8-giedi.dts                        |  10 -
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |   8 +
 arch/arm/dts/imx8qxp-u-boot.dtsi                   |   2 +
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi      |  69 +-
 arch/arm/mach-imx/imx8/Kconfig                     |  11 +-
 arch/arm/mach-imx/imx9/Kconfig                     |   2 +
 arch/arm/mach-imx/imx9/soc.c                       |   2 +-
 board/boundary/nitrogen6x/nitrogen6x.c             |   2 +-
 board/phytec/common/Kconfig                        |   8 +
 board/phytec/common/Makefile                       |   1 +
 board/phytec/common/imx93_som_detection.c          | 111 +++
 board/phytec/common/imx93_som_detection.h          |  51 ++
 board/phytec/phycore_imx8mm/Kconfig                |   1 +
 board/phytec/phycore_imx8mm/spl.c                  |  17 +
 board/phytec/phycore_imx93/Kconfig                 |  28 +
 board/phytec/phycore_imx93/MAINTAINERS             |   7 +-
 board/phytec/phycore_imx93/lpddr4_timing.c         | 793 +++++++++++++++++++--
 board/phytec/phycore_imx93/phycore-imx93.c         |  51 ++
 board/phytec/phycore_imx93/spl.c                   |  48 ++
 board/siemens/capricorn/Kconfig                    |  25 +-
 board/siemens/capricorn/MAINTAINERS                |  12 +-
 board/siemens/capricorn/Makefile                   |   2 +
 board/siemens/capricorn/board.c                    |  70 +-
 board/siemens/capricorn/imximage.cfg               |  21 +-
 board/siemens/capricorn/spl.c                      |  43 ++
 board/siemens/capricorn/spl_memory_test.c          | 158 ++++
 board/siemens/capricorn/spl_memory_test.h          |   7 +
 board/siemens/common/Kconfig                       |   4 +
 board/siemens/common/board.h                       |  44 ++
 board/siemens/common/ddr_si_test.c                 | 348 +++++++++
 board/siemens/draco/board.h                        |  10 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c               |   2 +-
 .../{deneb_defconfig => capricorn_cxg3_defconfig}  |  21 +-
 configs/giedi_defconfig                            | 133 ----
 ...ard-segin_defconfig => imx93-phycore_defconfig} |   2 +
 configs/phycore-imx8mm_defconfig                   |   1 +
 ...{imx93-phyboard-segin.rst => imx93-phycore.rst} |   8 +-
 doc/board/phytec/index.rst                         |   2 +-
 drivers/misc/imx8/scu_api.c                        |  20 +
 drivers/net/fec_mxc.c                              |  14 +-
 drivers/watchdog/Kconfig                           |   7 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/siemens_pmic_wdt.c                |  59 ++
 include/configs/capricorn-common.h                 |   4 +-
 include/configs/deneb.h                            |  16 -
 include/firmware/imx/sci/rpc.h                     |   3 +
 include/firmware/imx/sci/sci.h                     |   1 +
 include/netdev.h                                   |   2 +-
 tools/imx8image.c                                  |   2 +-
 tools/imx_cntr_image.sh                            |   4 +
 55 files changed, 2140 insertions(+), 446 deletions(-)
 create mode 100644 arch/arm/dts/imx8-capricorn-cxg3.dts
 rename arch/arm/dts/{imx8qxp-capricorn-u-boot.dtsi => imx8-capricorn-u-boot.dtsi} (54%)
 rename arch/arm/dts/{imx8qxp-capricorn.dtsi => imx8-capricorn.dtsi} (64%)
 delete mode 100644 arch/arm/dts/imx8-deneb.dts
 delete mode 100644 arch/arm/dts/imx8-giedi.dts
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h
 create mode 100644 board/siemens/capricorn/spl_memory_test.c
 create mode 100644 board/siemens/capricorn/spl_memory_test.h
 create mode 100644 board/siemens/common/board.h
 create mode 100644 board/siemens/common/ddr_si_test.c
 rename configs/{deneb_defconfig => capricorn_cxg3_defconfig} (88%)
 delete mode 100644 configs/giedi_defconfig
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
 rename doc/board/phytec/{imx93-phyboard-segin.rst => imx93-phycore.rst} (91%)
 create mode 100644 drivers/watchdog/siemens_pmic_wdt.c
 delete mode 100644 include/configs/deneb.h
