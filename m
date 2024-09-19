Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D54CE8D7A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 11:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF9189145;
	Thu, 19 Sep 2024 13:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1ysTbSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A59589146; Thu, 19 Sep 2024 13:57:42 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D0889137
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 13:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so154174a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726747058; x=1727351858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m8ssglSn+5+kdoCaEPEPUS8LdrQ+gE1DV6cblRW9LOw=;
 b=W1ysTbSAQGgrxkVCoEiLcVbbt91hABnpXcvSRwFJkJxTZFQDobp7j7ldOwqtNIXQHC
 OMimqziFGhYe3MHbCR9cfsvIBkqc3xhj6PSQdtB1KO37KbwhksjWGGLNm5xYGGrU5aML
 SfqBhxYDCnuM0rXIZqN13WaMc0vC7dVAmZGvhmbiE3rBduNgdY+y3LKPjx96JughYWCB
 hgbG3JrFS0L008YmsX4xBEdza3kcSAKQfQlxks+pNrDcOLUmGwkAaZbrc9XKPIMgSpn/
 SJNXSNu3JZCcjXUBmERoIFaao5FNGm9OnDzjY0JhNm/FB/EkTIhi0V9+/5mBxrkXzmXD
 T+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726747058; x=1727351858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8ssglSn+5+kdoCaEPEPUS8LdrQ+gE1DV6cblRW9LOw=;
 b=Npa1Ockgru4X0QHYH6sf2RmQJlk3sxRHiMyXwe7xqMuFtmZKjAfHPjM4XP6wuQfRVB
 LgbVTmEDUorgP4Lo5gHsl+tCIjWu1ca9sJ9SYtyQdLihyak8YiCJMzBNqs/nVsZwFl9Q
 2wAcM5CVxAR7SokrTHz63pACrZw38XhtcoGBMS5bMSb2qogChCaasSo95DUzy8r1uOP2
 FE6Dw2aFp1zbWLUUNUUv0Oq8YblwX1DZr6WtOc8eAojGM9GFNnN5eFHmO1Nzef2vEfQI
 OQjMIJISx6WCJ+t8MYZH+M0zy4kUH0s+rm1p1jU4S1SqKZJlM4C4Zi9enykw5GA/Y4i2
 1Xkg==
X-Gm-Message-State: AOJu0YyY6IXIHMyICrBjEcLjWjSFuT80mGC4cEHevWCnWUF2tlg/GULa
 RaN34lJi6+1fC0SnSHdohJMeNL6Sn0jc5uteQkpeTYSMVojVWHzmd2iBSQ==
X-Google-Smtp-Source: AGHT+IHtXb6V1u+FFNpWSdoI+bnYEGp4DPwF/6OpLDeAT6sCv07UALNPRj6XLSD2oV1KNQ1gFLoXNA==
X-Received: by 2002:a17:90a:ac02:b0:2d8:aa5d:5856 with SMTP id
 98e67ed59e1d1-2dd6ce140b8mr4967739a91.11.1726747057969; 
 Thu, 19 Sep 2024 04:57:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7419:2a5a:1bc5:63f7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd6ee984f0sm1595591a91.19.2024.09.19.04.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 04:57:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240919
Date: Thu, 19 Sep 2024 08:57:34 -0300
Message-Id: <20240919115734.3594662-1-festevam@gmail.com>
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

The following changes since commit c17805e19b9335e1fb5295c81b59eddf88d1b9ec:

  Merge patch series "Fix various bugs" (2024-09-18 13:07:19 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240919

for you to fetch changes up to effe934e50f03c92ba6febecfe132c9cb34ecf59:

  imx6q-lxr: Add board support (2024-09-19 00:13:20 -0300)

u-boot-imx-next-20240919
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22363

- Several updates to i.MX9 SOC and i.MX93 EVK.
- Power domain fixes.
- TRDC cleanup and update.
- MAC address layout update.
- Add support for the i.MX9301/9302 variants.
- Add runtime detection of voltage mode.
- Generalize some code for i.MX8M and i.MX9.
- Add support for Comvetia imx6q-lxr board.
----------------------------------------------------------------
Fabio Estevam (1):
      imx6q-lxr: Add board support

Frank Li (1):
      imx9: soc: imx9: soc: Align UID endianness with ROM

Jacky Bai (1):
      imx9: soc: Mask the wdog reset in src by default on i.mx9

Peng Fan (12):
      imx9: soc: wait ssar when power on power domain
      imx9: soc: Change FSB directly access to fuse API
      imx9: soc: Print ELE information
      imx8m: soc: Drop disable_pmu_cpu_nodes
      imx: Generalize disable_cpu_nodes
      imx9: soc: Disable cpu1 for variants that only has one A55 core
      imx: Generalize fixup_thermal_trips
      imx9: trdc: cleanup code
      imx9: trdc: introduce trdc_mbc_blk_num
      imx93_evk: spl: update pmic settings
      imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and ld defconfig
      imx93_evk: add back Low drive mode ddr timing file

Ye Li (7):
      imx9: soc: Configure TRDC for M33 TCM access
      imx9: soc: Print UID in big endian format for EL2GO
      imx9: soc: Change second Ethernet MAC fuse layout
      imx9: soc: Add function to get target voltage mode
      imx9: clock: Update clock init function and sequence
      imx9: Add 233Mhz DDR PLL frequency
      imx93: Add Low performance parts 9302/9301 support

 arch/arm/dts/Makefile                              |    1 +
 arch/arm/dts/imx6q-lxr.dts                         |   87 +
 arch/arm/dts/imx6q-phytec-pfla02.dtsi              |   17 +
 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi            |  467 +++++
 arch/arm/include/asm/arch-imx/cpu.h                |    2 +
 arch/arm/include/asm/arch-imx9/clock.h             |    3 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h          |   10 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   11 +
 arch/arm/include/asm/mach-imx/sys_proto.h          |    8 +-
 arch/arm/mach-imx/Makefile                         |    6 +
 arch/arm/mach-imx/fdt.c                            |  129 ++
 arch/arm/mach-imx/imx8m/soc.c                      |  179 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +-
 arch/arm/mach-imx/imx9/clock.c                     |   40 +-
 arch/arm/mach-imx/imx9/soc.c                       |  258 ++-
 arch/arm/mach-imx/imx9/trdc.c                      |  175 +-
 arch/arm/mach-imx/mx6/Kconfig                      |   11 +
 board/comvetia/lxr2/Kconfig                        |   12 +
 board/comvetia/lxr2/MAINTAINERS                    |    6 +
 board/comvetia/lxr2/Makefile                       |    3 +
 board/comvetia/lxr2/lxr2.c                         |  388 ++++
 board/comvetia/lxr2/lxr2.env                       |   34 +
 board/freescale/imx93_evk/Makefile                 |    6 +-
 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c | 1995 ++++++++++++++++++++
 board/freescale/imx93_evk/lpddr4x_timing_ld.c      | 1496 ---------------
 board/freescale/imx93_evk/spl.c                    |   55 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 configs/imx93_11x11_evk_ld_defconfig               |  127 --
 configs/lxr2_defconfig                             |  118 ++
 drivers/cpu/imx8_cpu.c                             |    4 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
 include/configs/lxr2.h                             |   23 +
 include/power/pca9450.h                            |    2 +
 33 files changed, 3749 insertions(+), 1936 deletions(-)
 create mode 100644 arch/arm/dts/imx6q-lxr.dts
 create mode 100644 arch/arm/dts/imx6q-phytec-pfla02.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
 create mode 100644 arch/arm/mach-imx/fdt.c
 create mode 100644 board/comvetia/lxr2/Kconfig
 create mode 100644 board/comvetia/lxr2/MAINTAINERS
 create mode 100644 board/comvetia/lxr2/Makefile
 create mode 100644 board/comvetia/lxr2/lxr2.c
 create mode 100644 board/comvetia/lxr2/lxr2.env
 create mode 100644 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c
 delete mode 100644 board/freescale/imx93_evk/lpddr4x_timing_ld.c
 delete mode 100644 configs/imx93_11x11_evk_ld_defconfig
 create mode 100644 configs/lxr2_defconfig
 create mode 100644 include/configs/lxr2.h
