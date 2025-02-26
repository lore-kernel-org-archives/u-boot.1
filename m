Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797C3C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE55E80FF2;
	Wed, 26 Feb 2025 23:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V8OWzHyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D0D8118A; Wed, 26 Feb 2025 23:16:14 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657EB80F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22349bb8605so5066305ad.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608169; x=1741212969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NyrQ9F+a1GpI1LQLP9VTrS/HdC2YmaStFnPLlsxdtSc=;
 b=V8OWzHyJO4rPotFgkZWhMIIG5P2DTfjUum/xv7kNafi/yhzfgdX5DXAzbQcDcdoexB
 adlNJCgkAxtv/Cbo50CcO4lMGseR7RArnHqQc0bxO1Vpv7CCy3rXW3ihfNJRJTzcT73a
 8TkVnqXa/GRmlHU4QZy+ni9P7LyLGTG01YYYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608169; x=1741212969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyrQ9F+a1GpI1LQLP9VTrS/HdC2YmaStFnPLlsxdtSc=;
 b=iWKxce8EboI9zRDm/8pw9wlKOLBNyFFrv8Z081yNmm6GmWo628qJeGOMtL+CFAkSBy
 6Xlb6iBzHOwb2zq1GCkZutmILpCa/E2l2c2SFVlygvppyrUc6BeIUD0l1xAZzDXtif8d
 HoQlDL2cCX9R4svEXhYA7qsUF9ETmeeOlT50f2EvqeuuRY6G7JGWfTSC2u6mbdn6YSgk
 xFh/2rfMhCGWm5oxX8KW9vX2Q5tMV6mFDjljepKgG0rWMxvgZYB/Sdudwl8WjVSynzth
 LV1TJ517Vvcw+BxsoxkrzBLgrsr5xDja32rOFumWVlD9xv5Jbwowy/MlJisdfEL1qWuZ
 sNbg==
X-Gm-Message-State: AOJu0YwQvMZWYI+/9u32LRxkaibFPf2ngnYIbLfV5LYkS1CyPIYgRspp
 Rapf4jI9e46UFiCJf3I0NDJNpE/UtkY2zXrQLwsw56am2hYotWhRJIDTXo5RogxVNySGOLj2kMI
 =
X-Gm-Gg: ASbGnctu2YHWDE2F6/2OKcB4FLBW+DahphaDc9N8cdw7IEk8KGEtte3vHYDrUntwJ2m
 NFDOLwO3EXc1LlxCTF7z7RURlHlAM5ZxdyzvjtAhTrSeYDYVT0sl2hM5f6/aW7PdJYK/C1x3lko
 z/QndUEqJg5rNXbgeWczhPWZ07bVL+pw+7BpeZKAfg39t37qBCkNtgogwLdN1mmBM9s402HZpCw
 jYQmRE2/RYq3R74LlFBChQ8si6YOZ/cUIyJRtqnuGtHDiRyrJKPZo6fcQqHrdSNzPdMcfyQyMaO
 ZDH3xy/w+4X/xwimo7eT6mI9i/BFWEvTT53qblP4KEpWhYAw8ZGETfVanrRToohdkg==
X-Google-Smtp-Source: AGHT+IG7njLSJF5fIQNlsU6gIYYaPM2IjNhYJrW0G1DfuKl7u1Rywsf4o5IQ3/4cqyjysImHc0wk/Q==
X-Received: by 2002:a05:6a20:7f9a:b0:1ee:e30c:68d8 with SMTP id
 adf61e73a8af0-1f0fc12b58cmr15100352637.12.1740608169590; 
 Wed, 26 Feb 2025 14:16:09 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7349fe4ac02sm65181b3a.54.2025.02.26.14.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:09 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 00/15] Support to run U-Boot on sc7180 Trogdor Chromebooks
Date: Wed, 26 Feb 2025 14:15:46 -0800
Message-ID: <20250226221607.1283592-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

This series supports running U-Boot as a payload on sc7180 Trogdor
Chromebooks like Lazor or Wormdingler. This is a jumble of different
patches to get to the final goal of booting a Linux distro from the eMMC
on Lazor. I'm able to boot Fedora Workstation 41 from a USB stick on my
Lazor.

I moved the reviewed patch to the start. After that one line fix there's
a few patches to add support for the particular SoC used on Trogdor
devices, sc7180. The next set of patches move the coreboot logic out of
arch/x86/ into lib/ to find the coreboot tables on ARM and stash them in
global data. Then I have a handful of patches to let the coreboot
commands and utilities parse and populate various things like pstore and
firmware details into the DTB with the proper data from the coreboot
tables. Finally, I add the calls to coreboot dram parsing code in the
snapdragon board so that if coreboot tables exist we get the memory info
from coreboot instead of from an earlier stage DTB.

I tested the SPI driver with the crosec command. The cros bootflow
method almost works, but it seems like chromeos userspace blows up
spectacularly likely because crossystem can't figure out what board it
is running on. I don't really care too much about booting chromeos
userspace here so I'm ignoring that problem.

TODO:
 * Get display working
 * Implement FIT FDT picking similar to depthcharge based on coreboot
   tables

Do I need to add a board/google/trogdor directory?

Changes from v1 https://lore.kernel.org/r/20250220205900.3127680-1-swboyd@chromium.org
 * Add Kconfig file in lib/coreboot/ to hold the coreboot config stuff
   similar to EFI
 * Couple new patches for ximg to support extracting the FDT from
   chromeos kernel partitions
 * Move the timestamp file out of arch/x86 as well in a different patch

Stephen Boyd (15):
  bootstd: cros: Return negative error code
  clk: qcom: Add driver for sc7180
  pinctrl: qcom: Add driver for sc7180
  spi: Add Qualcomm GENI SPI driver
  coreboot: Move coreboot logic out of x86 to a generic place
  arm: Support running U-Boot as a coreboot payload on ARM64
  cmd/cbsysinfo: Skip the CMOS 'option_table' when not present
  cmd/cbsysinfo: Allow on ARM as well
  coreboot: Parse sku_id/fw_config from coreboot tables
  pstore: Add pstore address from coreboot tables
  coreboot: Add /firmware/coreboot node to DT
  coreboot: Move timestamp parsing to generic place
  mach-snapdragon: Support booting as a coreboot payload
  cmd: ximg: Support LZO compressed images
  cmd: ximg: Support LZ4 compressed images

 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/coreboot/Makefile          |   4 +
 arch/arm/cpu/armv8/coreboot/cpu.c             |  33 ++
 arch/arm/include/asm/global_data.h            |   3 +
 arch/arm/mach-snapdragon/board.c              |  18 +
 arch/x86/Kconfig                              |  22 -
 arch/x86/cpu/coreboot/Kconfig                 |  33 --
 arch/x86/cpu/coreboot/Makefile                |   1 -
 arch/x86/cpu/coreboot/coreboot.c              |  10 +-
 arch/x86/cpu/coreboot/sdram.c                 |  78 +--
 arch/x86/cpu/cpu.c                            |  15 +-
 arch/x86/cpu/i386/cpu.c                       |   2 +-
 arch/x86/lib/bootm.c                          |   5 +-
 arch/x86/lib/coreboot/Makefile                |   1 -
 arch/x86/lib/coreboot/cb_support.c            |   2 +-
 arch/x86/lib/coreboot_table.c                 |   2 +-
 arch/x86/lib/tables.c                         |   2 +-
 arch/x86/lib/zimage.c                         |   3 -
 board/coreboot/coreboot/coreboot.c            |   2 +-
 board/coreboot/coreboot/sysinfo.c             |   2 +-
 board/google/chromebook_coral/coral.c         |   2 +-
 boot/Kconfig                                  |   1 +
 boot/bootmeth_cros.c                          |   2 +-
 boot/expo_build_cb.c                          |   2 +-
 boot/image-fdt.c                              |   4 +
 cmd/Kconfig                                   |   4 +-
 cmd/Makefile                                  |   1 +
 cmd/{x86 => }/cbsysinfo.c                     |   6 +-
 cmd/pstore.c                                  |  44 +-
 cmd/version.c                                 |   2 +-
 cmd/x86/Makefile                              |   1 -
 cmd/x86/cbcmos.c                              |   2 +-
 cmd/ximg.c                                    |  28 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sc7180.c               | 150 +++++
 drivers/misc/cbmem_console.c                  |   2 +-
 drivers/pinctrl/qcom/Kconfig                  |   7 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c         | 106 ++++
 drivers/serial/serial_coreboot.c              |   2 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-geni-qcom.c                   | 527 ++++++++++++++++++
 drivers/video/coreboot.c                      |   2 +-
 .../x86/include/asm => include}/cb_sysinfo.h  |  40 +-
 .../include/asm => include}/coreboot_tables.h |  11 +
 .../coreboot_timestamp.h                      |   9 +-
 lib/Makefile                                  |   2 +
 lib/coreboot/Kconfig                          |  55 ++
 {arch/x86/cpu => lib}/coreboot/Makefile       |   9 +-
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 163 +++++-
 {arch/x86/cpu => lib}/coreboot/sdram.c        |  15 +-
 {arch/x86/cpu => lib}/coreboot/timestamp.c    |  15 +-
 54 files changed, 1244 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
 delete mode 100644 arch/x86/cpu/coreboot/Kconfig
 rename cmd/{x86 => }/cbsysinfo.c (99%)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
 create mode 100644 drivers/spi/spi-geni-qcom.c
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (89%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (98%)
 rename arch/x86/include/asm/arch-coreboot/timestamp.h => include/coreboot_timestamp.h (63%)
 create mode 100644 lib/coreboot/Kconfig
 copy {arch/x86/cpu => lib}/coreboot/Makefile (75%)
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (73%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)
 rename {arch/x86/cpu => lib}/coreboot/timestamp.c (83%)


base-commit: 313b9856f95419b01df7cc6b9a16f7b07d9fe13c
-- 
Sent by a computer, using git, on the internet

