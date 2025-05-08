Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FFCC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010E2828BC;
	Thu,  8 May 2025 17:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P3EhCGFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513C582905; Thu,  8 May 2025 17:13:34 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5CD828A2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so188900666b.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746717211; x=1747322011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3upZYE886QTEX9BS0MI+GFp59GfEMuCWu/z2EBX0f7w=;
 b=P3EhCGFMPvHq76Fhx8otIJh7ICmR8VdY9V+GfPDT5ipo9x2FgSEfLrRS4i+NGBR/NP
 VtjnoSfkMpng0cYKPT5HOgez1atkDBdcQ5RLUBhDFgEOoqTim9UUyrPA6Xa0oVZ/4I/6
 GZMmVvcDnlLhs5H2XRLAfS+SKpRKacp0X54h49sR7LM4+idAgDXsQU/lhf6Ap/atSbLc
 KLbWiMrALfoUaTz2SQS46uongSJ2foJ+jjE5ADK0PiPDjpsIMHRaLKWxiDzVX1D0rFjr
 xvdXsgHOCe36oqkgiGXHL3FcEp9cCKWnjAxpV7d4NHqlwOj43iMklcYsPyvtT49udqai
 5WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746717211; x=1747322011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3upZYE886QTEX9BS0MI+GFp59GfEMuCWu/z2EBX0f7w=;
 b=ZPxSj/pQHYwPx10YRjVUM0Ycn9Q/frrzE+/4tw/QW1/01TsTXMDIMujgDY495Ifmtf
 oXOz0ec7wA8xalw9qhT4nKtxPeQicWXoWHFLF3yQRW+yBIsrz1R78xD8Im+bwhAX92sg
 1HK78zBbt1djz98GpAD/Y7XFjbX1MyPMyuHmRFRvntI/dWiKJPRQkDhGm37SIQxBNL+D
 zIEXcdmlMTxyLeo4bF6Xkeskf6Apk2t3AVRifRHq9cgZuDyjnScNh2E2vZcSN0+nP3k7
 3e4Jm/+vatl+JaCuNCMGqaGHhLlXQWnZqsAq9VJfy0Bx3Gc6SRko+aTC2KMRnJxnr15q
 7a8Q==
X-Gm-Message-State: AOJu0YyEe/49dDuNLwwjP3440GueRorGA7dtHpjfF+8JZW+SuFi2gect
 VlWopX0xRnaYaJL5po9jg1P6kS5EAIt7PpyIjn1o2c+tibAm8FBY
X-Gm-Gg: ASbGncvJrMajrQQGEYv/8wU5/9Ad42uhXcOmn9aCoIxQ/qqRkMNVl97aBKNfRa7W7m0
 9RQEpnbr/FUKsBa9riFmFTldRajRriS5TVWwtE2aXMFcxpN902GH2TMZvwyUg2VnSc7WJDRKj5q
 SN4+VsuanSRGaXLbuvMlpQvbJ7IXsiF/FlsKVHXS0pX57QAV3z3xy2nPrdT8N1JS0tImNUp1EV/
 rXxC2V0fLXEyfMtYvwm9y0YOyr9Cba0n2x0oJaw/NfsCqt3q2YTXz37bQqvbCsQonJ//WVS7rB3
 gv4dLtVl7ZDVUDHrkJuBprKDt99CaPg1
X-Google-Smtp-Source: AGHT+IEqxd+FsekNjPp0rwxw/30o0ZiZyEfHYxw6dbV6XigkNft2KsNh/yM+urmEhTVsFbefZTSkjg==
X-Received: by 2002:a17:907:8749:b0:ac6:b811:e65b with SMTP id
 a640c23a62f3a-ad21904b9d9mr4139566b.36.1746717210860; 
 Thu, 08 May 2025 08:13:30 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18954008dsm1095994866b.163.2025.05.08.08.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 08:13:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Thu,  8 May 2025 18:13:10 +0300
Message-ID: <20250508151311.69585-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Dear Tom,

The following changes since commit 48db49b0977cc1c9c9abf82c0fb704238fcef4fd:

  Merge patch series "include: env: phytec: k3_net: Remove net_apply_extensions" (2025-05-07 07:59:09 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to d5b9b7aa039b03e6de4b32cc961f7ec1205ded75:

  ARM: tegra: drop CONFIG_DISABLE_SDMMC1_EARLY (2025-05-08 08:31:13 +0300)

----------------------------------------------------------------
Svyatoslav Ryhel (13):
      gpio: tegra_gpio: implement rfree operation
      power: pmic: add the base MAX8907 PMIC support
      power: regulator: max9807: add regulator support
      sysreset: implement MAX9807 sysreset functions
      video: tegra: add 8-bit CPU driven protocol
      video: panel: add Hitachi TX10D07VM0BAA MIPI DSI panel driver
      video: panel: add LG LH400WV3-SD04 MIPI DSI panel driver
      video: backlight: add Skyworks/Analogictech AAT2870 led controller driver
      board: lg: star: add Optimus 2X P990 support
      ARM: tegra: add PRAM Kconfig option
      ARM: tegra: convert boards to use TEGRA_PRAM
      ARM: tegra: set default SYS_CONFIG_NAME from SoC Kconfig
      ARM: tegra: drop CONFIG_DISABLE_SDMMC1_EARLY

 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/tegra20-lg-star.dts            | 538 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-tegra/dc.h        |  48 ++++++
 arch/arm/mach-tegra/Kconfig                 |  17 +++
 arch/arm/mach-tegra/board2.c                |  25 ----
 arch/arm/mach-tegra/tegra20/Kconfig         |   5 +
 board/acer/picasso/Kconfig                  |   3 -
 board/asus/grouper/Kconfig                  |   3 -
 board/asus/transformer-t114/Kconfig         |   7 +-
 board/asus/transformer-t20/Kconfig          |   3 -
 board/asus/transformer-t30/Kconfig          |   3 -
 board/avionic-design/medcom-wide/Kconfig    |   3 -
 board/avionic-design/plutux/Kconfig         |   3 -
 board/avionic-design/tec-ng/Kconfig         |   3 -
 board/avionic-design/tec/Kconfig            |   3 -
 board/cei/cei-tk1-som/Kconfig               |   3 -
 board/compal/paz00/Kconfig                  |   3 -
 board/compulab/trimslice/Kconfig            |   3 -
 board/htc/endeavoru/Kconfig                 |   3 -
 board/lenovo/ideapad-yoga-11/Kconfig        |   3 -
 board/lg/star/Kconfig                       |  13 ++
 board/lg/star/MAINTAINERS                   |   7 +
 board/lg/star/Makefile                      |   9 ++
 board/lg/star/star.c                        |  50 +++++++
 board/lg/star/star.env                      |  15 ++
 board/lg/x3-t30/Kconfig                     |   3 -
 board/microsoft/surface-rt/Kconfig          |   3 -
 board/nvidia/beaver/Kconfig                 |   3 -
 board/nvidia/cardhu/Kconfig                 |   3 -
 board/nvidia/dalmore/Kconfig                |   3 -
 board/nvidia/harmony/Kconfig                |   3 -
 board/nvidia/jetson-tk1/Kconfig             |   3 -
 board/nvidia/nyan-big/Kconfig               |   3 -
 board/nvidia/p2371-0000/Kconfig             |   3 -
 board/nvidia/p2371-2180/Kconfig             |   3 -
 board/nvidia/p2571/Kconfig                  |   3 -
 board/nvidia/p2771-0000/Kconfig             |   3 -
 board/nvidia/p3450-0000/Kconfig             |   3 -
 board/nvidia/seaboard/Kconfig               |   3 -
 board/nvidia/tegratab/Kconfig               |   7 +-
 board/nvidia/venice2/Kconfig                |   3 -
 board/nvidia/ventana/Kconfig                |   3 -
 board/ouya/ouya/Kconfig                     |   3 -
 board/toradex/apalis_t30/Kconfig            |   3 -
 board/toradex/colibri_t20/Kconfig           |   3 -
 board/toradex/colibri_t30/Kconfig           |   3 -
 board/wexler/qc750/Kconfig                  |   3 -
 board/xiaomi/mocha/Kconfig                  |   7 +-
 configs/star_defconfig                      |  93 ++++++++++++
 doc/board/asus/transformer_t114.rst         |   2 +-
 doc/board/lg/index.rst                      |   1 +
 doc/board/lg/star.rst                       | 125 ++++++++++++++++
 doc/board/nvidia/tegratab.rst               |   2 +-
 doc/board/xiaomi/mocha.rst                  |   2 +-
 drivers/gpio/tegra_gpio.c                   |  11 ++
 drivers/power/pmic/Kconfig                  |   9 ++
 drivers/power/pmic/Makefile                 |   1 +
 drivers/power/pmic/max8907.c                |  94 ++++++++++++
 drivers/power/regulator/Kconfig             |   9 ++
 drivers/power/regulator/Makefile            |   1 +
 drivers/power/regulator/max8907_regulator.c | 249 +++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig                    |   7 +
 drivers/sysreset/Makefile                   |   1 +
 drivers/sysreset/sysreset_max8907.c         |  37 +++++
 drivers/video/Kconfig                       |  26 ++++
 drivers/video/Makefile                      |   3 +
 drivers/video/aat2870_backlight.c           | 132 ++++++++++++++++
 drivers/video/hitachi-tx10d07vm0baa.c       | 304 +++++++++++++++++++++++++++++++++++++
 drivers/video/lg-lh400wv3-sd04.c            | 230 ++++++++++++++++++++++++++++
 drivers/video/tegra/Kconfig                 |  10 ++
 drivers/video/tegra/Makefile                |   1 +
 drivers/video/tegra/cpu-bridge.c            | 325 ++++++++++++++++++++++++++++++++++++++++
 include/configs/mocha.h                     |  19 ---
 include/configs/tegra.h                     |   4 +
 include/configs/tegratab.h                  |  19 ---
 include/configs/transformer-t114.h          |  19 ---
 include/power/max8907.h                     |  77 ++++++++++
 77 files changed, 2468 insertions(+), 196 deletions(-)
 create mode 100644 arch/arm/dts/tegra20-lg-star.dts
 create mode 100644 board/lg/star/Kconfig
 create mode 100644 board/lg/star/MAINTAINERS
 create mode 100644 board/lg/star/Makefile
 create mode 100644 board/lg/star/star.c
 create mode 100644 board/lg/star/star.env
 create mode 100644 configs/star_defconfig
 create mode 100644 doc/board/lg/star.rst
 create mode 100644 drivers/power/pmic/max8907.c
 create mode 100644 drivers/power/regulator/max8907_regulator.c
 create mode 100644 drivers/sysreset/sysreset_max8907.c
 create mode 100644 drivers/video/aat2870_backlight.c
 create mode 100644 drivers/video/hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/video/lg-lh400wv3-sd04.c
 create mode 100644 drivers/video/tegra/cpu-bridge.c
 delete mode 100644 include/configs/mocha.h
 delete mode 100644 include/configs/tegratab.h
 delete mode 100644 include/configs/transformer-t114.h
 create mode 100644 include/power/max8907.h

Branch contains LG Optimus 2X bringup and general Tegra cleanups.

Thanks,
Svyatoslav Ryhel.
