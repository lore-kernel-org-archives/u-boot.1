Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40744C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA56887E70;
	Thu,  8 Feb 2024 15:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYWXFJ1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7394C87E77; Thu,  8 Feb 2024 15:36:41 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E380087E45
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e05c085b83so167847b3a.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402997; x=1708007797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=//xTbzFDXUVT5hHygSPCO46geQDQXsxej6QrdfjNvgM=;
 b=hYWXFJ1RyDcS4SSGmw2/EKWTQ9uQbO+UZ8KgnxqaD9X4WFdD0Wjnhb752tTGdQvAU8
 kVR7OXPttv76RE4K587tRJ/Hdg1BJaVVLtHnorF83VyvoMu50QJFZX9nH6S9e98+NUDw
 +AB5UxM+BM+KHwit2uhY29mHDbJrmx9NyGNYqsYSZO7PJA7WyPXqxYjvkTlcU1MhKCwT
 wgWTMOaYpML9rBJz9w+q0TZNQxJ7MW605j2OdXxfONCN4nZzxUg8NrKmRYQAkW+A5zYk
 /vzCoCj84KQD80PQ6nRIyS87hd1yKbJoLK1qpoEYlDejdxUNnFpjgIeI+qMkFPWQ0spI
 STFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402997; x=1708007797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//xTbzFDXUVT5hHygSPCO46geQDQXsxej6QrdfjNvgM=;
 b=O4i7DUfSK4scyVsib1X23DQLaiSq5Cykl20NwM67j2y3YYTcVJBuEHHps9Sh+cKe6Q
 cV/urcv2t2wI8uwERjF38WA9vtc6qEnwabtyT/dgAxT2jP9CEtFIHrSCZBVJ3Qv7JPIC
 MRrFyAdAQTYPB9g6LI3Q2Mvv94pO6vC8tN2dilPSMtTG2xBKllcQGcStgAJa8se65vJm
 OIElKvG+pCvL+f9WowdZIr0qXLsYgnhtJVnkWuUQTTHHkEsJj2l5erKKAxskP/RaHWA1
 rJJJCefCa3riIax+wd4ltk7TzDarSEs2WI0ZrGMxdJ6pEd8K0ESIqgZv+VaV5BfsRntH
 3W4w==
X-Gm-Message-State: AOJu0YzELKj0mb+UTRPUgKfNS9RkaRpHAhAv0+BbjDkrIXU95kCUNIjW
 VTMNpvJaBaxczW9WH0IYMcMRPaUol1GRlFEq0jZxJ9F0StcvF2FbHsKRnuSy
X-Google-Smtp-Source: AGHT+IHX3sGVZXs4C3mE7ceKvjLTXGXYp5/rJ0NxSrqAf8pgsWpSZ1/4k0qWwGETiLDZMRuWJPCPxg==
X-Received: by 2002:a05:6a00:438f:b0:6e0:2ff8:a6e9 with SMTP id
 bt15-20020a056a00438f00b006e02ff8a6e9mr9760217pfb.2.1707402997036; 
 Thu, 08 Feb 2024 06:36:37 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:386d:4441:cc3b:6cfa])
 by smtp.gmail.com with ESMTPSA id
 a23-20020aa78657000000b006dd8985e7c6sm3778620pfo.1.2024.02.08.06.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:36:36 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-master-20240208
Date: Thu,  8 Feb 2024 11:36:33 -0300
Message-Id: <20240208143633.1345238-1-festevam@gmail.com>
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

Please pull from u-boot-imx, thanks

The following changes since commit 0101a2ffe125911ebf89172b495f5ff14f2fd058:

  Merge branch '2024-02-06-assorted-fixes' (2024-02-07 09:47:47 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240208

for you to fetch changes up to 8dcf1df48dff339b172d1bce2a38a965ee4aafca:

  phycore-imx8mp: add support for booting and flashing emmc via UUU (2024-02-08 10:11:46 -0300)

u-boot-imx-master-20240208
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19565

- Add USB support for phycore-imx8mp
- Fix environment corruption, reset on mx6sabresd
- Print reset cause on imx8
- Extend mkimage to support generating an image for i.MXRT FlexSPI
- Add new apalis and colibri variants
- Add support for phyBOARD-Segin-i.MX93 support
- Fix when FEC is primarily used instead of EQOS on i.MX93.
----------------------------------------------------------------
Benjamin Hahn (4):
      imx8mp-phyboard-pollux-rdk: sync with kernel devicetree from v6.8-rc2
      phycore-imx8mp: add USB host support
      phycore-imx8mp: add USB mass storage support
      phycore-imx8mp: add support for booting and flashing emmc via UUU

Fabio Estevam (3):
      mx6sabresd: Fix U-Boot corruption after saving the environment
      mx6sabresd: Convert to watchdog driver model
      mx6sabresd: Remove board_phy_config()

Igor Opaniuk (2):
      imx: scu_api: add implementation of sc_pm_reset_reason
      imx: imx8: print reset cause

Jesse Taube (1):
      tools: mkimage: Add support for i.MXRT FlexSPI Header

Joao Paulo Goncalves (2):
      toradex: tdx-cfg-block: Add new apalis and colibri pid
      toradex: tdx-cfg-block: add 0086 i.mx8m mini sku

Marek Vasut (1):
      ARM: imx: Enable kaslrseed command on Data Modul i.MX8M Mini/Plus eDM SBC

Mathieu Othacehe (1):
      board: phytec: phycore-imx93: Add phyBOARD-Segin-i.MX93 support

Primoz Fiser (1):
      imx9: clock: Fix board_interface_eth_init for FEC

 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi           |    9 +
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |    4 +
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts        |  162 +-
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi      |  293 ++++
 arch/arm/dts/imx93-phyboard-segin.dts              |  117 ++
 arch/arm/dts/imx93-phycore-som.dtsi                |  126 ++
 arch/arm/mach-imx/imx8/cpu.c                       |   41 +
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +
 arch/arm/mach-imx/imx9/clock.c                     |    5 +
 board/freescale/mx6sabresd/mx6sabresd.c            |   34 -
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       |    4 +
 board/phytec/phycore_imx93/Kconfig                 |   13 +
 board/phytec/phycore_imx93/MAINTAINERS             |   10 +
 board/phytec/phycore_imx93/Makefile                |   14 +
 board/phytec/phycore_imx93/lpddr4_timing.c         | 1546 ++++++++++++++++++++
 board/phytec/phycore_imx93/phycore-imx93.c         |   42 +
 board/phytec/phycore_imx93/phycore_imx93.env       |   73 +
 board/phytec/phycore_imx93/spl.c                   |  148 ++
 board/toradex/common/tdx-cfg-block.c               |   10 +
 board/toradex/common/tdx-cfg-block.h               |   10 +
 configs/imx8mm_data_modul_edm_sbc_defconfig        |    2 +
 configs/imx8mp_data_modul_edm_sbc_defconfig        |    2 +
 configs/imx93-phyboard-segin_defconfig             |  138 ++
 configs/mx6sabresd_defconfig                       |    6 +
 configs/phycore-imx8mp_defconfig                   |   33 +-
 doc/board/phytec/imx93-phyboard-segin.rst          |   61 +
 doc/board/phytec/index.rst                         |    1 +
 drivers/misc/imx8/scu_api.c                        |   22 +
 include/configs/phycore_imx8mp.h                   |    5 +
 include/configs/phycore_imx93.h                    |   28 +
 include/firmware/imx/sci/sci.h                     |    6 +
 include/imximage.h                                 |   42 +-
 tools/Kconfig                                      |   21 +
 tools/imx8mimage.c                                 |   41 +-
 tools/imximage.c                                   |   77 +
 36 files changed, 3078 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
 create mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
 create mode 100644 board/phytec/phycore_imx93/Kconfig
 create mode 100644 board/phytec/phycore_imx93/MAINTAINERS
 create mode 100644 board/phytec/phycore_imx93/Makefile
 create mode 100644 board/phytec/phycore_imx93/lpddr4_timing.c
 create mode 100644 board/phytec/phycore_imx93/phycore-imx93.c
 create mode 100644 board/phytec/phycore_imx93/phycore_imx93.env
 create mode 100644 board/phytec/phycore_imx93/spl.c
 create mode 100644 configs/imx93-phyboard-segin_defconfig
 create mode 100644 doc/board/phytec/imx93-phyboard-segin.rst
 create mode 100644 include/configs/phycore_imx93.h
