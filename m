Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20685C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA8683340;
	Sat, 24 May 2025 01:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EeMJ1o7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B11C83409; Sat, 24 May 2025 00:58:52 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968FA8333D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b26f67f10ddso194998a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041128; x=1748645928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SmIWvxCRvwkfgZnPJsoGYkk6A21o82mASJx6qCM5Hqc=;
 b=EeMJ1o7qRZxQ4MzkQ6RY96boqPVdGc4ox7CiV7nJaLkobo1j4CptnozVWp5I51iopU
 9l/rYEO73Uh1mAgawCqTr4RBaZVuSOK4PdHpV7i0q6xpEZutxEcgX3UBdYpEK1j/xs8f
 agRKjIS//3C7P8SdzcHOo4ZQBynYqEuhLRAa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041128; x=1748645928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SmIWvxCRvwkfgZnPJsoGYkk6A21o82mASJx6qCM5Hqc=;
 b=aNMCtZ9wfKVqihfPmnkE6UGmGZAB5lMM9xLOkAelKFYHJlMUvPZM67Hd7vjIALFNNe
 ESjkyCkRetetSN5P8xCysd112g3dm0dQe1A2I9f5HI1BHClpZtw0OVy+ekIYyVG6MJnW
 FIczxnzEi1XqZZOV+3gTL1IITO0j5tvVNF+6tFlzJh7Y4PxomOPWGGPx7jZYiynwE9qe
 aJcSgV8973TSMBp0iimBHxSRmTj+TuYEmi1HhOmeuUsx0vr4rZGyXWLB4UOfJnOzP/fI
 VfshmnbZog2dYxk6w6C2Q2fjuY9LAh54n5CS15LN8KMpHVK0FvTK79qBFPwrS5xGqlnC
 G49w==
X-Gm-Message-State: AOJu0YzNZRp4Us1zM5meq8YC6QbGmKvsGuCf66LwHBRGxcRIVpB0xBZI
 VtNBXWj1VBLn/6F8BdUkRQ3eoZ6H3ZQLMrC/zee3kf2/fWfm0nCeKBKIM/vqOYzYXZBOcdrVTHg
 Shpg=
X-Gm-Gg: ASbGncuXOGOQAUDNr2fgpRmC/+ESMw7u/WtktasustXJpsftt3x86GXfT/J8gGWSjfm
 QQSDY1B59efehg8XMvq0x+rPUNLY+B4/jW1qP5QI4beyWRO4LrvhJhj6ciBBJULLHj0JkSkLwx5
 2C6jdNN/1oJCzUedFPw5S0bV8RAoIGtsItDu8ctwRFi5Xhl6La9o3YZxXqPjKu3eEcIP7xHJav7
 +kAwlMuWTFaR420dhNIs9iu0d9C8OC7vvr39bg5P+Y+Psjs7Na8fGS/QbOVtKyWkJlcvpHSy5gI
 VkGOk22P/J9ffeceIkAhgxm89a5OvlQzLNaDMyh5OAcsyCJuiITCX4fe863O0/q6F5JtIgDOOu7
 sAtmFwA+gl33NFuBQxqTXzChUDw==
X-Google-Smtp-Source: AGHT+IEkzOwiA2X4oTx1NwFnKIA0iR9x/9w9DO6J99j7pmF6LCYqoZmda0fm34n+TINQe6WVkbNgWQ==
X-Received: by 2002:a17:903:b08:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-23414fd256cmr14344075ad.51.1748041127779; 
 Fri, 23 May 2025 15:58:47 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-231d4e97dadsm129410215ad.141.2025.05.23.15.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:47 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 00/28] Support to run U-Boot on sc7180 Trogdor Chromebooks
Date: Fri, 23 May 2025 15:58:15 -0700
Message-ID: <20250523225845.2311989-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

I'm able to install fedora on Lazor with this as long as I start the USB
with CONFIG_PREBOOT=y. I tried to get this working on SC7280 Hoglin but
it crashed in Fedora. I'm not sure why but it could be because the
memory stuff was all wrong. Either way I hope it may work in the near
future.

The display is almost there but I suspect I'll need to do the whole
initialization all over again so I punted for now.

TODO:
 * Get display working
 * Implement FIT FDT picking similar to depthcharge based on coreboot
   tables indicating the SKU and board id

Changes from v3 https://lore.kernel.org/r/20250428192427.3877612-1-swboyd@chromium.org
 * GPIO chipselect in the SPI driver support
 * sc7280 clk driver support for UART
 * Enable the UART clk at probe
 * Read VPD and inject the wifi MAC address
 * Patch to inject wifi MAC from the environment
 * Add a debug_board_init routine for trogdor to support early debug
 * Add a defconfig

Changes from v2 https://lore.kernel.org/r/20250226221607.1283592-1-swboyd@chromium.org
 * Check SPI proto in probe
 * Handle pins differently in pinctrl driver
 * Pick up tags
 * Rebase to ToT
 * Update pinctrl driver for new changes in last few months
 * Add some more gates to clk driver to handle missing clk warnings
 * New patch to locate coreboot tables early

Changes from v1 https://lore.kernel.org/r/20250220205900.3127680-1-swboyd@chromium.org
 * Add Kconfig file in lib/coreboot/ to hold the coreboot config stuff
   similar to EFI
 * Couple new patches for ximg to support extracting the FDT from
   chromeos kernel partitions
 * Move the timestamp file out of arch/x86 as well in a different patch

Stephen Boyd (28):
  bootstd: cros: Return negative error code
  clk: qcom: Add driver for sc7180
  clk/stub: Add sc7180-rpmh clock
  clk: qcom: Support uart clk on sc7280 CRD
  pinctrl: qcom: Add driver for sc7180
  spi: Add Qualcomm GENI SPI driver
  serial: msm-geni: Enable SE clk in probe
  coreboot: Move coreboot logic out of x86 to a generic place
  coreboot: Set gd->ram_base when parsing tables
  coreboot: Locate table earlier than arch_cpu_init()
  arm: Support running U-Boot as a coreboot payload on ARM64
  cmd/cbsysinfo: Skip the CMOS 'option_table' when not present
  cmd/cbsysinfo: Allow on ARM as well
  coreboot: Parse sku_id/fw_config from coreboot tables
  pstore: Add pstore address from coreboot tables
  coreboot: Add /firmware/coreboot node to DT
  coreboot: Move timestamp parsing to generic place
  coreboot: Dump VPD information in cbsysinfo command
  coreboot: Set serial# from VPD
  coreboot: Set wifi mac addr from VPD
  fdt: Populate wifi MAC from environment
  mach-snapdragon: Support booting as a coreboot payload
  mach-snapdragon: Allow usb3 to work when a coreboot payload
  board: google: Add board_debug_uart_init() for Trogdor
  cmd: ximg: Support LZO compressed images
  cmd: ximg: Support LZ4 compressed images
  configs: Add chromebook_trogdor defconfig
  doc: chromebook_trogdor: Add document detailing installation steps

 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/coreboot/Makefile          |   4 +
 arch/arm/cpu/armv8/coreboot/cpu.c             |  22 +
 arch/arm/include/asm/global_data.h            |   3 +
 arch/arm/mach-snapdragon/board.c              |  23 +
 arch/arm/mach-snapdragon/of_fixup.c           |  22 +-
 arch/x86/Kconfig                              |  22 -
 arch/x86/cpu/coreboot/Kconfig                 |  33 -
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
 board/google/trogdor/Makefile                 |   3 +
 board/google/trogdor/debug.config             |   6 +
 board/google/trogdor/debug_uart.c             |  41 ++
 boot/Kconfig                                  |   1 +
 boot/bootmeth_cros.c                          |   2 +-
 boot/expo_build_cb.c                          |   2 +-
 boot/fdt_support.c                            |  54 +-
 boot/image-fdt.c                              |   4 +
 cmd/Kconfig                                   |   4 +-
 cmd/Makefile                                  |   1 +
 cmd/{x86 => }/cbsysinfo.c                     |  40 +-
 cmd/pstore.c                                  |  51 +-
 cmd/version.c                                 |   2 +-
 cmd/x86/Makefile                              |   1 -
 cmd/x86/cbcmos.c                              |   2 +-
 cmd/ximg.c                                    |  28 +
 common/board_f.c                              |   4 +
 configs/chromebook_trogdor_defconfig          | 138 +++++
 doc/board/google/chromebook_trogdor.rst       |  69 +++
 doc/board/google/index.rst                    |   1 +
 drivers/clk/clk-stub.c                        |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sc7180.c               | 153 +++++
 drivers/clk/qcom/clock-sc7280.c               |  22 +
 drivers/misc/cbmem_console.c                  |   2 +-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c         | 133 ++++
 drivers/serial/serial_coreboot.c              |   2 +-
 drivers/serial/serial_msm_geni.c              |  26 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-geni-qcom.c                   | 569 ++++++++++++++++++
 drivers/video/coreboot.c                      |   2 +-
 .../x86/include/asm => include}/cb_sysinfo.h  |  51 +-
 .../include/asm => include}/coreboot_tables.h |  24 +
 .../coreboot_timestamp.h                      |   9 +-
 lib/Makefile                                  |   2 +
 lib/coreboot/Kconfig                          |  55 ++
 {arch/x86/cpu => lib}/coreboot/Makefile       |  11 +-
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 288 ++++++++-
 {arch/x86/cpu => lib}/coreboot/sdram.c        |  25 +-
 {arch/x86/cpu => lib}/coreboot/timestamp.c    |  15 +-
 66 files changed, 1863 insertions(+), 273 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
 delete mode 100644 arch/x86/cpu/coreboot/Kconfig
 create mode 100644 board/google/trogdor/Makefile
 create mode 100644 board/google/trogdor/debug.config
 create mode 100644 board/google/trogdor/debug_uart.c
 rename cmd/{x86 => }/cbsysinfo.c (93%)
 create mode 100644 configs/chromebook_trogdor_defconfig
 create mode 100644 doc/board/google/chromebook_trogdor.rst
 create mode 100644 drivers/clk/qcom/clock-sc7180.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
 create mode 100644 drivers/spi/spi-geni-qcom.c
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (86%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (96%)
 rename arch/x86/include/asm/arch-coreboot/timestamp.h => include/coreboot_timestamp.h (63%)
 create mode 100644 lib/coreboot/Kconfig
 copy {arch/x86/cpu => lib}/coreboot/Makefile (71%)
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (62%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (84%)
 rename {arch/x86/cpu => lib}/coreboot/timestamp.c (83%)


base-commit: 9d3f1ebaf8751f0287b5d02158cc706435f8fb19
-- 
Sent by a computer, using git, on the internet

