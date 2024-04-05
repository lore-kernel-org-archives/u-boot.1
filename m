Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7FC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C6B8849E;
	Fri,  5 Apr 2024 18:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isXM7P5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB179884A0; Fri,  5 Apr 2024 18:46:13 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245D0883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed057140e9so45046b3a.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335569; x=1712940369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CEALu89KOlOdmXDVQZOLAK86d2k7+OiJJ0gKYxRuMQs=;
 b=isXM7P5BY7WJmM268dQjS6TRcsX3R/a626F/h9q1vWbUU17AiHNNFDWyFH9GbATzIV
 hmvZccnfexwo40dPkwr21fEQ/4F+P82hp0ErevAaD2nAcxOz1dTvxYr1DKcUDCk7bGI3
 S6FRqmWwO8v8JR+Y7TjDWuMjIK/I/EANURnda2QU5Wd5ZpliWlbovB25OkBBhKlAvcyr
 K4cmZt1b+hhSowUdRP6UJrutKESd6W0U/9D2ovXgpL2RthBLJ5yMuv061WR3p2Z6aoZP
 hu926L/i6lws621P0lLQOSoHueUOXgj+Ju+Xip8N5X0LMme71wjeOta9UiK/yBrxucJ1
 vZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335569; x=1712940369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEALu89KOlOdmXDVQZOLAK86d2k7+OiJJ0gKYxRuMQs=;
 b=BTI0jWfziB7PrztdcEwup8EKFCJDbr0Frh/jWaaZFMM7FfEfiSlkfrwNhidE5/8t3h
 nj/5G5pN11/zEpSDMw+RnOEq43449tLg3ARdIal3Kg5jHqqG6jDhoOASvi2ruFcyZw4O
 5RuNZfdgMMKCH3/KrOBqW6foZh17nKaU0B7WBExdw37zTX1pPfHL9aDCukC9iyDtozKn
 S6hTp+yP0cLlWjSSrnydlxaPCbdu+YLDr1No5unTH9YAwPE2UnvrHNMFchCOt/7XcJUu
 +H+IsX7xGxqdEi+PKiCCgdR7wG6RUJEaKLmxJt00YECPF/66BVk8kx+umK5lO/QUoVxs
 fpvA==
X-Gm-Message-State: AOJu0YzD8/vTUXXRioho5ifhnbqwMpvKzuaw+VPEEmQSZxXqfv17k15l
 CIyIpHnOW1Y5mnVwrC48pKgDpLLvjyYS2zsla9mbircFJ2i1+MK5zBll1QU0
X-Google-Smtp-Source: AGHT+IH2SrpUQ0BJ0ETjatDUR35SUeI78CtDkZUbHVh8k3qQguxqzptA3wBj3aUxaLED6AhSd7cMWQ==
X-Received: by 2002:a05:6a00:6908:b0:6ec:ee44:17bb with SMTP id
 hs8-20020a056a00690800b006ecee4417bbmr2048093pfb.2.1712335569554; 
 Fri, 05 Apr 2024 09:46:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1a99:dd72:cf95:e04])
 by smtp.gmail.com with ESMTPSA id
 v16-20020aa799d0000000b006e567c81d14sm1719299pfi.43.2024.04.05.09.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 09:46:09 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240405
Date: Fri,  5 Apr 2024 13:46:05 -0300
Message-Id: <20240405164605.920442-1-festevam@gmail.com>
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

Please pull this material for from u-boot-imx/master, thanks.

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

  Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240405

for you to fetch changes up to f6be41c83c17c09dddfb1e29a7ca391b5190634d:

  arm: imx: fix signature_block_hdr struct fields order (2024-04-05 09:39:18 -0300)

u-boot-imx-master-20240405
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20228

- Convert imx8mp-beacon and verdin-imx8mm/verdin-imx8mp to OF_UPSTREAM.
- Enable PCIe NVMe support on imx8mp_beacon.
- Fix Ethernet and board detection on mx6cuboxi.
- Fix signature_block_hdr struct fields.
- Fix imx9_probe_mu prototype and make it to get called in EVT_DM_POST_INIT_R.
- Test whether ethernet node is enabled before reading MAC EEPROM on DHSOM SoMs.
----------------------------------------------------------------
Adam Ford (4):
      arm64: imx: imx8mp-beacon: Migrate to OF_UPSTREAM
      arm64: imx: imx8mm-beacon: Migrate to OF_UPSTREAM
      arm64: imx: imx8mn-beacon: Migrate to OF_UPSTREAM
      configs: imx8mp_beacon: Enable PCIe NVMe drives

Fabio Estevam (1):
      mx6cuboxi: Do not print devicetree model

Javier Viguera (1):
      arm: imx: fix signature_block_hdr struct fields order

Josua Mayer (1):
      mx6cuboxi: Fix Ethernet after DT sync with Linux

Marcel Ziswiler (1):
      verdin-imx8mm/verdin-imx8mp: move imx verdins to OF_UPSTREAM

Marek Vasut (1):
      ARM: imx: stm32: Test whether ethernet node is enabled before reading MAC EEPROM on DHSOM

Ye Li (2):
      arm: imx9: Correct imx9_probe_mu prototype
      arm: imx9: Call imx9_probe_mu for DM post in board_r

 arch/arm/dts/Makefile                              |    5 -
 .../imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi |    1 +
 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi            |   49 +
 arch/arm/dts/imx8mm-beacon-kit.dts                 |   19 -
 arch/arm/dts/imx8mm-beacon-som.dtsi                |  461 -------
 arch/arm/dts/imx8mm-verdin-dev.dtsi                |  160 ---
 arch/arm/dts/imx8mm-verdin-wifi-dev.dts            |   18 -
 arch/arm/dts/imx8mm-verdin-wifi.dtsi               |   94 --
 arch/arm/dts/imx8mm-verdin.dtsi                    | 1319 ------------------
 arch/arm/dts/imx8mn-beacon-kit.dts                 |   19 -
 arch/arm/dts/imx8mn-beacon-som.dtsi                |  472 -------
 arch/arm/dts/imx8mp-beacon-kit.dts                 |  783 -----------
 arch/arm/dts/imx8mp-beacon-som.dtsi                |  487 -------
 arch/arm/dts/imx8mp-verdin-dev.dtsi                |  165 ---
 arch/arm/dts/imx8mp-verdin-wifi-dev.dts            |   18 -
 arch/arm/dts/imx8mp-verdin-wifi.dtsi               |   87 --
 arch/arm/dts/imx8mp-verdin.dtsi                    | 1438 --------------------
 arch/arm/include/asm/arch-imx9/mu.h                |    2 +-
 arch/arm/mach-imx/imx8m/Kconfig                    |    5 +
 arch/arm/mach-imx/imx9/soc.c                       |    1 +
 board/dhelectronics/common/dh_common.c             |   16 +
 board/dhelectronics/common/dh_common.h             |    8 +
 board/dhelectronics/dh_imx6/dh_imx6.c              |    3 +
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |    6 +
 board/dhelectronics/dh_stm32mp1/board.c            |    6 +
 board/freescale/imx93_evk/spl.c                    |    2 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c               |   40 +-
 board/toradex/verdin-imx8mm/MAINTAINERS            |    4 -
 board/toradex/verdin-imx8mp/MAINTAINERS            |    4 -
 board/variscite/imx93_var_som/spl.c                |    2 +-
 configs/imx8mm_beacon_defconfig                    |    2 +-
 configs/imx8mm_beacon_fspi_defconfig               |    2 +-
 configs/imx8mn_beacon_2g_defconfig                 |    2 +-
 configs/imx8mn_beacon_defconfig                    |    2 +-
 configs/imx8mn_beacon_fspi_defconfig               |    2 +-
 configs/imx8mp_beacon_defconfig                    |    8 +-
 configs/mx6cuboxi_defconfig                        |    1 +
 configs/verdin-imx8mm_defconfig                    |    2 +-
 configs/verdin-imx8mp_defconfig                    |    2 +-
 include/imx_container.h                            |    4 +-
 41 files changed, 124 insertions(+), 5599 deletions(-)
 create mode 100644 arch/arm/dts/imx6qdl-sr-som-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-beacon-kit.dts
 delete mode 100644 arch/arm/dts/imx8mm-beacon-som.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-verdin-dev.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-verdin-wifi-dev.dts
 delete mode 100644 arch/arm/dts/imx8mm-verdin-wifi.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-verdin.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-beacon-kit.dts
 delete mode 100644 arch/arm/dts/imx8mn-beacon-som.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-beacon-kit.dts
 delete mode 100644 arch/arm/dts/imx8mp-beacon-som.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-verdin-dev.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-verdin-wifi-dev.dts
 delete mode 100644 arch/arm/dts/imx8mp-verdin-wifi.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-verdin.dtsi
