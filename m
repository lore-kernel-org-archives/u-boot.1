Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA69C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C758210E;
	Mon, 28 Apr 2025 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTECPU5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B452B8210E; Mon, 28 Apr 2025 21:24:37 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB77180FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so5318241b3a.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868273; x=1746473073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=drZ+QMyG/zT/s2LurtUUlctufhMPY9iq16T8e7lodGI=;
 b=cTECPU5aaexw4XSg6eT8EyUWQv7DxJ1dKAOIz5LIbIXRWvCsAb0rtf9TxGc5Id3nRk
 MXZcMsyl7dRyN0qbY2x5fyW1iTqNGml0ZX1PLgR6p3sw+KgGIaMWAXvUfDbfge8oC2dk
 8stHr9Gbf5DkhMa3X829vsoBmG9PiE2qZSGdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868273; x=1746473073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=drZ+QMyG/zT/s2LurtUUlctufhMPY9iq16T8e7lodGI=;
 b=XNWlWpz1k9BFCmTEXtWfZ+tvibUfUA+x+D03XYL8AdR13l6mxS+RZ5GlHMbmZNozDy
 SyjRBAVZAKWP1TySEDdfEwtCvXP7FZfqADyvxqoNbrrrNR4bcV4PadHrwS1LPr6D/ggn
 DDHM2bD+DhGGk8BkXNhMcm3XzYWIiM65P1hWiuUzOixq2fYw9/jvknyr633AOdLny/PT
 5Q8B+EhXCfUJC2WJ/9GIj0Lhul/57ZUduaI/tfHl+vLwOGn7ZAOMLOAJYJG7jvbMv1qq
 i8LjkX4X5rk1/I2AVOP4HoljaFiLK8Cv551IEjJMEgpKR6x8stQjZoYZFcGtycBG0Uu2
 BtFw==
X-Gm-Message-State: AOJu0Yz1GqWzzeNzPgINzApEXL/QIv2Cv2S+V6SuCA6tpRbvqNv0saiv
 Gf6yJNDvjEyfDSIp/j2ImmnRrFbfpO/loWZsw9+487BjzGQgnmNlpTbMQPxnEv2fTYbdAL5SOxE
 =
X-Gm-Gg: ASbGnct/g2knPxBXCExzGfjZcBJprsUfodajaHFdA3m3GfEmYg+m7SF8sx08oupjElX
 SgTJhDLJlzHAdRNn/2nKBSOgSwdoRj0cykGtIRKAi3fQtpw/jt0lYgUk6865xlfjhyHlfNGUYUg
 lbAQsCSJNO23Ve37uQBvVITIbrYA8B1mr46u7/bFugdGHiHuFSvLSJmjmN3l8JFdVpzFJL6G+mX
 pmKiG7AiIkENlk0JwKNfyO/lne4hm/bkL6DGfBRirFtG6s+w0i+/f/UBif5r9woTPaJiw1Fg2Fu
 jSsTTjN2gBBVC4LmYYKNpv3zvXqPIjixGQHAJL7xnlXR0zjj0oVkWOHjoFrTMi2AyuNtcnvgIwX
 dEeGiDceW9NZv
X-Google-Smtp-Source: AGHT+IHYoFSC+VV3NroJwYnHMiAbLcj2ltIc6FtipC2zE2885TCGSjjF1KU1FtB1O2AnvfB3nZuABA==
X-Received: by 2002:a05:6a00:3927:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-740271689ffmr1327555b3a.11.1745868270136; 
 Mon, 28 Apr 2025 12:24:30 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74002791fb3sm4153695b3a.70.2025.04.28.12.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:29 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 00/17] Support to run U-Boot on sc7180 Trogdor Chromebooks
Date: Mon, 28 Apr 2025 12:24:07 -0700
Message-ID: <20250428192427.3877612-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

I haven't gotten around to working on the display part yet. I want to do
that in the next couple weeks. Do I need to add a board/google/trogdor
directory? If I don't get the display working then I'll have to figure
out how to script the loading process somehow so that it can boot from
USB/MMC.

TODO:
 * Get display working
 * Implement FIT FDT picking similar to depthcharge based on coreboot
   tables indicating the SKU and board id

Changes from v2 https://lore.kernel.org/r/20250226221607.1283592-1-swboyd@chromium.org
 * Check SPI proto in probe
 * Handle pins differently in pinctrl driver
 * Pick up tags
 * Rebase to ToT
 * Update pinctrl driver for new changes in last few months
 * Add some more gates to clk driver to handle missing clk warnings
 * New patch to locate coreboot tables early to fix memory parsing logic

Changes from v1 https://lore.kernel.org/r/20250220205900.3127680-1-swboyd@chromium.org
 * Add Kconfig file in lib/coreboot/ to hold the coreboot config stuff
   similar to EFI
 * Couple new patches for ximg to support extracting the FDT from
   chromeos kernel partitions
 * Move the timestamp file out of arch/x86 as well in a different patch

Stephen Boyd (17):
  bootstd: cros: Return negative error code
  clk: qcom: Add driver for sc7180
  clk/stub: add sc7180-rpmh clock
  pinctrl: qcom: Add driver for sc7180
  spi: Add Qualcomm GENI SPI driver
  coreboot: Move coreboot logic out of x86 to a generic place
  coreboot: Locate table earlier than arch_cpu_init()
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
 arch/arm/cpu/armv8/coreboot/cpu.c             |  22 +
 arch/arm/include/asm/global_data.h            |   3 +
 arch/arm/mach-snapdragon/board.c              |  23 +
 arch/x86/Kconfig                              |  22 -
 arch/x86/cpu/coreboot/Kconfig                 |  33 --
 arch/x86/cpu/coreboot/Makefile                |   1 -
 arch/x86/cpu/coreboot/coreboot.c              |  16 +-
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
 common/board_f.c                              |   4 +
 drivers/clk/clk-stub.c                        |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sc7180.c               | 153 +++++
 drivers/misc/cbmem_console.c                  |   2 +-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c         | 131 +++++
 drivers/serial/serial_coreboot.c              |   2 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-geni-qcom.c                   | 545 ++++++++++++++++++
 drivers/video/coreboot.c                      |   2 +-
 .../x86/include/asm => include}/cb_sysinfo.h  |  47 +-
 .../include/asm => include}/coreboot_tables.h |  11 +
 .../coreboot_timestamp.h                      |   9 +-
 lib/Makefile                                  |   2 +
 lib/coreboot/Kconfig                          |  55 ++
 {arch/x86/cpu => lib}/coreboot/Makefile       |   9 +-
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 174 +++++-
 {arch/x86/cpu => lib}/coreboot/sdram.c        |  15 +-
 {arch/x86/cpu => lib}/coreboot/timestamp.c    |  15 +-
 56 files changed, 1311 insertions(+), 233 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
 delete mode 100644 arch/x86/cpu/coreboot/Kconfig
 rename cmd/{x86 => }/cbsysinfo.c (99%)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
 create mode 100644 drivers/spi/spi-geni-qcom.c
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (88%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (98%)
 rename arch/x86/include/asm/arch-coreboot/timestamp.h => include/coreboot_timestamp.h (63%)
 create mode 100644 lib/coreboot/Kconfig
 copy {arch/x86/cpu => lib}/coreboot/Makefile (75%)
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (72%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)
 rename {arch/x86/cpu => lib}/coreboot/timestamp.c (83%)


base-commit: 9d3f1ebaf8751f0287b5d02158cc706435f8fb19
-- 
Sent by a computer, using git, on the internet

