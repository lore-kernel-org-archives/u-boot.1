Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD124C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A50F87A35;
	Mon,  8 Jan 2024 19:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKyf/bMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7D687A35; Mon,  8 Jan 2024 19:30:12 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1E487AD2
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d410fce119so5458395ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704738607; x=1705343407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XsTBSFSCuEAn7No7soaB6GuDd2qypHdFSMalwZWVJ3o=;
 b=YKyf/bMrcxcz01lgc0Y7xFCgo7Lorj1xjNNkrnpUN2a4/ALuaA+I3/8qzr5AYDLkgA
 kfXQulWQSWZCYiAyLT0YNW283MxA90RKM9W1UR7pfsF9Vu/yDrdD5YofqE8D0Lez4iNi
 7lE7MLDZn2LsKyaIpFGnSkJp7p5B+Hb8ilCJm4lciz6LF1F3misnAfX5MQml43b4m56l
 4a8P1QXHewH9/dAnhMc+6zKM3/8BW9PEB7tzhK+FNOxvaMLoyxOxMt+fON3JXMXxeN7P
 ggxQALnbgRQNO62lnx356eqZ6ZxkyZex+9e6j2CgcEvv7xwIseEsWeysfGQaASKdlca6
 dXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704738607; x=1705343407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsTBSFSCuEAn7No7soaB6GuDd2qypHdFSMalwZWVJ3o=;
 b=mHq2u2c1Itx/pGkYlW/hIDc9vNRh5MhhlQLkv98xBBB6D8VXKsxK5kmtHlbIm48yI/
 iBlUd9eJo6sZSH5FF3DsNz+jtENEbtZUY1Nb0bZ4S6xVDVUaQS6ln3AyUg3JsETqSIH9
 kgOJuGMI//Vy57f3tY+D+sDlPZqKruUV1qxGKouj6Vj/LbkRBKsIn3Txo0zxOZ5/4QIs
 p0gNJ6CfAS3g0y6/vWnSGPdSPC41RI83ApYw56xjYxmGrqK7tOCjWnfKqgRiBQIk46DI
 kB40kPIM49NKz3xf6Yo7XkVb7y4HyAvNJvHPiN2ox9bEPXLvokYFPLNKlNjTJKaH/LUy
 Ns7Q==
X-Gm-Message-State: AOJu0YxQZluYo2K9PEjBCC/dKjvSwrrkhryeiUfsyahaMn2qI1/WwAOQ
 ZFoIXpWBMG4UIcePHZ8TuHymAVqXuyg=
X-Google-Smtp-Source: AGHT+IFozyEbO/+2+dLZOHkUXXiglqsUg3sV9e1t3ueBPTrBlBsBWrgp761Ew3B6v434Bd/ZnxHDNw==
X-Received: by 2002:a17:902:d509:b0:1d3:c5e4:b2f6 with SMTP id
 b9-20020a170902d50900b001d3c5e4b2f6mr8560347plg.4.1704738607004; 
 Mon, 08 Jan 2024 10:30:07 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:63f2:cfe7:4b90:23c])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170902da8100b001d1d1ef8be6sm197991plx.267.2024.01.08.10.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 10:30:06 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-master-20240108
Date: Mon,  8 Jan 2024 15:30:03 -0300
Message-Id: <20240108183003.3230042-1-festevam@gmail.com>
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

Please pull from u-boot-imx, thanks.

The following changes since commit 93d91e9485d902a1836a22e72d1a545b587adf36:

  Merge branch 'next' (2024-01-08 12:00:18 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240108

for you to fetch changes up to 54e1aa236f7d934ea81d727fe27b6d05902643be:

  Add imx93-var-som support (2024-01-08 14:37:57 -0300)

u-boot-imx-master-20240108
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19232

- Make DRAM stable on i.MX8MP DHCOM SoM by using FPWM mode and updating
the DRAM timing
- Fix display artifacts when booting Linux on i.MX8M Mini/Plus eDM SBC
----------------------------------------------------------------
Francesco Dolcini (1):
      verdin-imx8mm: Remove stale fdt_addr env variable

Marek Vasut (1):
      ARM: imx: Auto-detect PHY on Data Modul i.MX8M Mini/Plus eDM SBC

Mathieu Othacehe (4):
      spl: binman: Disable u_boot_any symbols for i.MX93 boards
      mach-imx: Add i.MX93 binman support.
      imx9: imx93_evk: Add binman support.
      Add imx93-var-som support

 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |    6 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi           |    2 +
 arch/arm/dts/imx93-u-boot.dtsi                     |   88 ++
 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi    |  266 ++++
 arch/arm/dts/imx93-var-som-symphony.dts            |  305 ++++
 arch/arm/dts/imx93-var-som.dtsi                    |  111 ++
 arch/arm/include/asm/arch-imx9/clock.h             |    1 +
 arch/arm/mach-imx/Makefile                         |   27 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    8 +
 arch/arm/mach-imx/imx9/container.cfg               |   10 +
 arch/arm/mach-imx/imx9/imximage.cfg                |   10 +
 .../imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c     |   42 +
 .../imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c     |   50 +
 board/variscite/common/eth.c                       |   58 +
 board/variscite/common/eth.h                       |   12 +
 board/variscite/common/imx9_eeprom.c               |  190 +++
 board/variscite/common/imx9_eeprom.h               |   83 ++
 board/variscite/common/mmc.c                       |   47 +
 board/variscite/imx93_var_som/Kconfig              |   12 +
 board/variscite/imx93_var_som/MAINTAINERS          |    7 +
 board/variscite/imx93_var_som/Makefile             |   17 +
 board/variscite/imx93_var_som/imx93_var_som.c      |  126 ++
 board/variscite/imx93_var_som/imx93_var_som.env    |   99 ++
 board/variscite/imx93_var_som/lpddr4x_timing.c     | 1488 ++++++++++++++++++++
 board/variscite/imx93_var_som/spl.c                |  143 ++
 common/spl/Kconfig                                 |    2 +-
 common/spl/Kconfig.tpl                             |    2 +-
 common/spl/Kconfig.vpl                             |    2 +-
 configs/imx8mm_data_modul_edm_sbc_defconfig        |    1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig        |    1 +
 configs/imx93_11x11_evk_defconfig                  |    2 +
 configs/imx93_11x11_evk_ld_defconfig               |    2 +
 configs/imx93_var_som_defconfig                    |  156 ++
 doc/board/nxp/imx93_11x11_evk.rst                  |   68 +
 doc/board/nxp/index.rst                            |    1 +
 doc/board/variscite/imx93_var_som.rst              |   68 +
 doc/board/variscite/index.rst                      |    1 +
 include/configs/imx93_var_som.h                    |   48 +
 include/configs/verdin-imx8mm.h                    |    1 -
 tools/imx9_image.sh                                |   31 +
 41 files changed, 3585 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/dts/imx93-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
 create mode 100644 arch/arm/dts/imx93-var-som.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/container.cfg
 create mode 100644 arch/arm/mach-imx/imx9/imximage.cfg
 create mode 100644 board/variscite/common/eth.c
 create mode 100644 board/variscite/common/eth.h
 create mode 100644 board/variscite/common/imx9_eeprom.c
 create mode 100644 board/variscite/common/imx9_eeprom.h
 create mode 100644 board/variscite/common/mmc.c
 create mode 100644 board/variscite/imx93_var_som/Kconfig
 create mode 100644 board/variscite/imx93_var_som/MAINTAINERS
 create mode 100644 board/variscite/imx93_var_som/Makefile
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.env
 create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
 create mode 100644 board/variscite/imx93_var_som/spl.c
 create mode 100644 configs/imx93_var_som_defconfig
 create mode 100644 doc/board/nxp/imx93_11x11_evk.rst
 create mode 100644 doc/board/variscite/imx93_var_som.rst
 create mode 100644 include/configs/imx93_var_som.h
 create mode 100755 tools/imx9_image.sh
