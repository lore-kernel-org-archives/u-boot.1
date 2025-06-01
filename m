Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC5AC54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 13:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724AC82A0A;
	Sun,  1 Jun 2025 15:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6A2AQEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11B882A36; Sun,  1 Jun 2025 15:30:31 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E4B829E4
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4e592443229so1057054137.1
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748784628; x=1749389428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X7cOZ7pgDur6tU9coOW0Z8+S2unmKL0aZrjoAyVKW8Y=;
 b=F6A2AQEhOMxRtddKocgjuj9R4VJ7nk1MwdUZXaKeqLHTYn0PyMp4+K3Uv08IRQ7rTd
 n1fB3prKmFM7mF138Ki2cGn1yeB2tsb/Ii9OnjRUOeTJNPlq19H/fyw5Oa32Ou7SbO5e
 WHbtpEi1ZGI7mzbIQLOLsalygxb/c8PD4ytFf/CfJjcQ90WmXZdiArjw1uxNiMNszs4O
 FKJ1nHjQNl857sWIempU4+KkgjBMT13SJziOq5w6NLvJ+itGaChIzNsGTqXr8768X9iG
 rZZ9kMuOCj+AgzQut7ZBAaz4jPlmYLQTPnbxkPOP0PBErX2HKej4oXPLEpVfwdNNDMnB
 O67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748784628; x=1749389428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X7cOZ7pgDur6tU9coOW0Z8+S2unmKL0aZrjoAyVKW8Y=;
 b=f4KCLbDErLsvBamUGJ6nPee+pf3Q3w+vcyMqimUYU9XIXA66MmYO4hSiCS/FLsFhyc
 VJi6gUoJiq+esJ2uOPcV7KQ29f2x14YVPRhsA+k0dOg0Y5d291t41End8+zz1EIjnOQj
 2u8144nq5Fz7IRIwUWXhEQs+uVpr1hIP5S22DNPWfat29DR0NaGQDq6Qva0s3yfkcREE
 DZc4vXVnZHn49AO1Dba7wPznJ4wuZ6z7rjp/T6MLFEmM7OOf6hZ/9LsszuQ2atXmnb3d
 OtgfU00fwOaZBwXClyqYmMIPaaZTef2X9E4aFpFfc+FXvhQi0rf2h2pzKjgypGtNceyK
 o7vQ==
X-Gm-Message-State: AOJu0Yy9h96f97bi9HHsLxwYtu0w419/7ZvUhBdF1eWYTAXQx/PjSQD/
 u3ySsIcaXQhwaMVNkfw/mRxxOuR17BwPR5Ql6YoQytJfsIrpdr/QKoffhaYYUQ==
X-Gm-Gg: ASbGncvxk7MTWQ44sVPID4ealiJ8aVGfF7vorqmMGoTzTAn2ySFAxnXm3ZeMBqQJOSs
 vaNiBO6yxCUxiTRa6q7iy5iC/0pXhEN/mxujA871WBXp7hAyie1nThr+EZRqdjvOOyhCbPenzXV
 eJ3Q6qvhKEpMGhaEt4Imc6KHGIOGB2Oc/jkRuZL/fQq7FwdmmSwEDFWwD1FmuN9KkgFEqz1qEpi
 cmgCjXxoh6x1Ho13f0Dwog80hPw+pLI1IrmB2yWXOPdKQBZU3srZGiVRZdhZEHdX6bpqD9cVjlw
 xbOvyAJdFmKwCzZQrTrX410u41uMpFDfFA6x9hlOe+6rownQtMTfZZGpQtzOOIQ3KQ==
X-Google-Smtp-Source: AGHT+IFxlG2Qdtlpt0EuqLXlgR1FJJ7v63bG/38mu7Fmx15L47ZM6VdkJJioa5q9KgkgmvyU5O0mfg==
X-Received: by 2002:a05:6102:b0d:b0:4e2:a235:2483 with SMTP id
 ada2fe7eead31-4e6e41a2b13mr8685560137.19.1748784627746; 
 Sun, 01 Jun 2025 06:30:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:25b9:ba24:2d51:1482])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e6af027332sm5715859137.25.2025.06.01.06.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 06:30:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250601
Date: Sun,  1 Jun 2025 10:30:22 -0300
Message-Id: <20250601133022.1461652-1-festevam@gmail.com>
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

The following changes since commit 5eb1b7843811e3e87b0e677212a9145f07552a60:

  Merge patch series "test/py: enable HTTP testing" (2025-05-30 11:19:45 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250601

for you to fetch changes up to c7b82b4aabc6ef9af953b779490eb2385d299f51:

  bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board (2025-05-31 16:59:28 -0300)

u-boot-imx-next-20250601
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26436

- Add i.MX6UL clk driver.
- Improve the .MX6UL NAND controller performance.
- Add imx6ulz BSH SMM M2B board.
- Several improvements for imx8m venice boards.
----------------------------------------------------------------
Michael Trimarchi (5):
      clk: imx: add i.MX6UL clk driver
      mtd: mxs_nand_dt: Move from clk_get/clk_enable to clk_bulk api
      mtd: nand: Add support for EDO mode 1-5 to IMX6ULL platform
      configs/imx6ulz_smm_m2_defconfig: Enable clock framework
      bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board

Tim Harvey (13):
      configs: imx8m*_venice: enable several commands useful for scripting
      configs: imx8m*_venice: enable GPT support
      board: venice: move soc-specific dram config into soc-specific files
      board: venice: fix dram bus config for GW7902/GW7903/GW7904
      board: venice: fix dram size for GW7901-SP486
      board: venice: use baseboard model for family
      board: venice: use SOM model for PMIC adjustment on SOM
      board: venice: flip logic for GSC supervisor enable
      board: venice: add imx8mp-gw82xx support
      board: venice: add FSA support
      board: venice: update model representation for venice-flex
      board: venice: append configuration string to model
      imx8mp-venice-gw74xx: add w_disable2 gpio configuration

 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi    |  11 +-
 arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi |  49 ++
 board/bsh/imx6ulz_smm_m2/Kconfig                 |  21 +
 board/bsh/imx6ulz_smm_m2/MAINTAINERS             |   1 +
 board/bsh/imx6ulz_smm_m2/Makefile                |   4 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c     |   1 +
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c | 152 +++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c     |   1 +
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c | 137 +++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c     |   1 +
 board/bsh/imx6ulz_smm_m2/spl.c                   |  37 +-
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h            |   1 +
 board/gateworks/fsa.c                            | 736 +++++++++++++++++++++++
 board/gateworks/fsa.h                            |  51 ++
 board/gateworks/venice/Makefile                  |   1 +
 board/gateworks/venice/eeprom.c                  | 130 +++-
 board/gateworks/venice/eeprom.h                  |   3 +-
 board/gateworks/venice/lpddr4_timing.h           |  14 +-
 board/gateworks/venice/lpddr4_timing_imx8mm.c    | 103 +++-
 board/gateworks/venice/lpddr4_timing_imx8mn.c    |  31 +-
 board/gateworks/venice/lpddr4_timing_imx8mp.c    |  23 +-
 board/gateworks/venice/spl.c                     | 110 +---
 board/gateworks/venice/venice.c                  |   7 +
 configs/imx6ulz_smm_m2_defconfig                 |   2 +
 configs/imx6ulz_smm_m2b_defconfig                |  78 +++
 configs/imx8mm_venice_defconfig                  |  10 +
 configs/imx8mn_venice_defconfig                  |  10 +
 configs/imx8mp_venice_defconfig                  |  12 +-
 drivers/clk/imx/Kconfig                          |   8 +
 drivers/clk/imx/Makefile                         |   1 +
 drivers/clk/imx/clk-imx6ul.c                     | 289 +++++++++
 drivers/mtd/nand/raw/mxs_nand.c                  |  10 +
 drivers/mtd/nand/raw/mxs_nand_dt.c               |  50 +-
 33 files changed, 1906 insertions(+), 189 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c
 create mode 100644 board/gateworks/fsa.c
 create mode 100644 board/gateworks/fsa.h
 create mode 100644 configs/imx6ulz_smm_m2b_defconfig
 create mode 100644 drivers/clk/imx/clk-imx6ul.c
