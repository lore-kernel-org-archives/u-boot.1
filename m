Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BF5C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BBC87536;
	Mon,  8 Jan 2024 19:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hV32nIO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2784487A9B; Mon,  8 Jan 2024 19:37:17 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B7787536
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d3b84173feso4329705ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704739033; x=1705343833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wHBBFecxIuUiCbWTLVel9bYtYM6HbOcmHa+MV2WpMUg=;
 b=hV32nIO5QYNj8Rm5J0oNEmrsfo9KR77HWpj9cEwCtNjlDPzhPDRM4DOwH0rmOwqZRn
 J0x6q+kA67THX+ZC0SxpiNpy9WZTgGGcGxfiK8cpIz1aO6X8QWjUQ0idPJWPLPnSpQ+l
 dFrOF2VDkPfuflXUNkXAEwKLhSVU8kxn7JRRF9G2/raTAWXXyaHyGtwy8cH+os3TJGgt
 qlSuh33YmlQZl1Ptu4OUxGUz0RqPV6Z3E4ZypV8Z0ArptZXqYipq/yxY3OmgzCKtSeid
 1a4G7Q6TgI3Xh3VPIvcsU0afIYmcML20xnOM4vm4IqS0P441TJ6o4gQyI4YdUBNdzwAA
 WGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704739033; x=1705343833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wHBBFecxIuUiCbWTLVel9bYtYM6HbOcmHa+MV2WpMUg=;
 b=gRrnJIwIJKeOulnKw0o9UoUeXGy01JgnpJhskNbUS+LnC5HNkc2CzvFKlvMDMUiahW
 cPxjaB624pUvktBKE8cAmHLN4lbGIUIMPW3TeTT1NJ2lPsIA/bLLnItIWoThKpv032bF
 W+nxrFU65KhXC9xHgutOfRtEQZHnex0FT/z037gy3Pp3iCj4wXtoiQDPGBMwkxXSyHBL
 vjb6812SR3ai+fO2tWp8+iTpLEb5fGUH5WgBhG/7YBTpyFANe2lAn8FApjEnxmrNkKne
 HJoLrf7L/MGh+kT5vpev1cQv8VrpZu4CrGSqB8yQSrnGIQ52vdOkTccQk/Fhs0qcXIHa
 CpwQ==
X-Gm-Message-State: AOJu0Yy4ssMImXacgcXGy9hdxThLZ1R32RkAnNnLpAFPG7DKelIeOtxv
 x+9YS8eME3JazvbeV73I9gE1s5iVHsw=
X-Google-Smtp-Source: AGHT+IHs6a+1xZVuiUHf/N3lM2fgxFsz6GjV0t8ox2f9OJm7PdsnadL+tUAGrlbR3mvfABMapcldow==
X-Received: by 2002:a17:902:8682:b0:1d4:e308:d6fb with SMTP id
 g2-20020a170902868200b001d4e308d6fbmr8736011plo.5.1704739032644; 
 Mon, 08 Jan 2024 10:37:12 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:63f2:cfe7:4b90:23c])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a170902904a00b001d05bb77b43sm222284plz.19.2024.01.08.10.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 10:37:12 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: [v2] Pull request: Please pull u-boot-imx-master-20240108
Date: Mon,  8 Jan 2024 15:37:09 -0300
Message-Id: <20240108183709.3230970-1-festevam@gmail.com>
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

This is v2. Fixed the summary log.

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

- Removed fdt_addr from verdin-imx8mm to fix booting via bootefi.
- Support Ethernet PHY autodection on Data Modul i.MX8M Mini/Plus eDM SBC
- Add i.MX93 binman support
- Add support for imx93-var-som
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
