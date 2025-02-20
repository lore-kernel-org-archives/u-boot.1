Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E17C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2383480F5C;
	Thu, 20 Feb 2025 22:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cRqG4txB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E518C8001F; Thu, 20 Feb 2025 21:59:06 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0788001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220d28c215eso22143935ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085142; x=1740689942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MkTZUNyqJBd69e1uxpOslYp4mTMzncKG569WW95wk60=;
 b=cRqG4txB6Mv86am9oV0fe+Avj7sYtyn/M6fDBFwbGD1z+nkVv0mjF9TOaB7Db2Lz9d
 th3sF4xOksx5uvx5CDhE3mrTy5TNDQRB6dgNMPWhEUz5JPqQwUYepT7zasLEhrbVYYy+
 zxOtjFlYwJiPw7d76WH7RxCXZe5MiZTJQ69Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085142; x=1740689942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkTZUNyqJBd69e1uxpOslYp4mTMzncKG569WW95wk60=;
 b=xVb6votUWXVOG5xYWNm6TEvNmXnsAhBCaDNAiHr3r+mmmKRx4PAN61bQYST+aDUQ9D
 sTVr4jAwDH7suS8jqdXttJ/6TNwmigvTkkGuaUFey4gnD6F75C9g4dpS9fsWk9V0OV3g
 4h3lS1S7X4moZQOaHRXebl5tV9Lik56kCW4cOuzNU1v8AIsXPoG3zOTnG1TONHmVhi0H
 ZVUXYP9ZeGi60oHLGZRlh0a/lxfqWs9XI9BBsSQcqdX0EEE6QxY+Mvv03akpsqojQPn2
 EN8UZP3oPii0a7YUSAJZJEMmEElbKM599vsWV0uNGGFtH7e12RNj6eI8L7CqlbTDEICs
 54PQ==
X-Gm-Message-State: AOJu0YyuZakU/pPg6hvhQ49r4MKIo3SxWPyQaZNoygaedodktCILS67P
 4E6GmncNCe/rE7fG4fLBSXQ6rKbqc04P9ohsm6Q5NYjCaZfnJO0A9aBzWTrdIkUOPTPDhsbJ/Ro
 =
X-Gm-Gg: ASbGncvTmsKNVim9rd/LxWWqrIURNLeTai7M7IIDqsIGkhfqGeKxZceP2wUCWcFttW7
 vQZU8pTnBSKRNgOlT+8Oob30nMSE2QYNbtf//NExwHJYf3gHV68+afmpKDJ3NTJ334v6zP+K6A0
 tIKvuM6/UCVcYc4Y53TOCs5hKdWbage0b15DpwwSV1XvrG5/gHdrG+r9ojoCIB2D1AwAj/qxy/J
 HgjSR/nvfgjLVbPU72FHSsl5cOjlLf2nheMjN2FyJkl78d1VIF3tDtHeWGOCDSbjjMcyDSgpuuv
 D3wZganxpHcy+DaByO89/tOk/PJGe6v/9N+dgJS4kQegVoLccGv5Oo0=
X-Google-Smtp-Source: AGHT+IFe6AQMVI0+hyrROVdL3hNVHDM/vZFczCQ28koWR1yaKM2JMwTxufkfoPI8V5NhUeUoZMdBfA==
X-Received: by 2002:a17:902:d506:b0:216:2426:767f with SMTP id
 d9443c01a7336-2219fffb182mr9004525ad.49.1740085142348; 
 Thu, 20 Feb 2025 12:59:02 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220d559089asm124977105ad.241.2025.02.20.12.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:01 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
Date: Thu, 20 Feb 2025 12:58:42 -0800
Message-ID: <20250220205900.3127680-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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
on Lazor. I've yet to craft a USB stick with a stock distro but I'll
probably do that next week.

The first few patches add support for the particular SoC sc7180 used on
Trogdor devices. The next set of patches move the coreboot logic out of
x86 into lib to find the coreboot tables on ARM and stash them in global
data. Then I have a handful of patches to let the coreboot commands and
utilities parse and populate various things like pstore and DT with the
proper data from the coreboot tables. Finally, I add the calls to
coreboot dram parsing code in the snapdragon board so that if coreboot
tables exist we get the memory info from coreboot instead of from an
earlier stage DTB.

I tested the spi driver with the crosec command. The cros bootflow
method almost works, but it seems like chromeos userspace blows up
spectacularly likely because crossystem can't figure out what board it
is running on. I don't really care too much about booting chromeos
userspace here so I'm going to ignore that problem and assume that I can
boot some Linux distro because the eMMC can be read by U-Boot and the
kernel boots.

Stephen Boyd (12):
  clk: qcom: Add driver for sc7180
  pinctrl: qcom: Add driver for sc7180
  spi: Add Qualcomm GENI SPI driver
  coreboot: Move coreboot logic out of x86 to a generic place
  arm: Support running U-Boot as a coreboot payload on ARM64
  cmd/cbsysinfo: Skip the CMOS 'option_table' if it isn't present
  cmd/cbsysinfo: Allow on ARM as well
  coreboot: Parse sku_id/fw_config from coreboot tables
  pstore: Add pstore address from coreboot tables
  coreboot: Add /firmware/coreboot node to DT
  bootstd: cros: Return negative error code
  mach-snapdragon: Support booting as a coreboot payload

 arch/arm/Kconfig                              |   2 +
 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/coreboot/Kconfig           |  22 +
 arch/arm/cpu/armv8/coreboot/Makefile          |   4 +
 arch/arm/cpu/armv8/coreboot/cpu.c             |  46 ++
 arch/arm/include/asm/global_data.h            |   3 +
 arch/arm/mach-snapdragon/board.c              |  18 +
 arch/x86/Kconfig                              |  21 -
 arch/x86/cpu/coreboot/coreboot.c              |   4 +-
 arch/x86/cpu/coreboot/sdram.c                 |  78 +--
 arch/x86/cpu/coreboot/timestamp.c             |   2 +-
 arch/x86/cpu/cpu.c                            |   2 +-
 arch/x86/cpu/i386/cpu.c                       |   2 +-
 .../x86/include/asm/arch-coreboot/timestamp.h |   2 +-
 arch/x86/lib/coreboot/Makefile                |   1 -
 arch/x86/lib/coreboot/cb_support.c            |   2 +-
 arch/x86/lib/coreboot_table.c                 |   2 +-
 arch/x86/lib/tables.c                         |   2 +-
 board/coreboot/coreboot/coreboot.c            |   2 +-
 board/coreboot/coreboot/sysinfo.c             |   2 +-
 board/google/chromebook_coral/coral.c         |   2 +-
 boot/bootmeth_cros.c                          |   2 +-
 boot/expo_build_cb.c                          |   2 +-
 boot/image-fdt.c                              |   4 +
 cmd/Kconfig                                   |   2 +-
 cmd/Makefile                                  |   1 +
 cmd/{x86 => }/cbsysinfo.c                     |   6 +-
 cmd/pstore.c                                  |  44 +-
 cmd/version.c                                 |   2 +-
 cmd/x86/Makefile                              |   1 -
 cmd/x86/cbcmos.c                              |   2 +-
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
 .../x86/include/asm => include}/cb_sysinfo.h  |  12 +-
 .../include/asm => include}/coreboot_tables.h |  11 +
 lib/Kconfig                                   |  21 +
 lib/Makefile                                  |   2 +
 lib/coreboot/Makefile                         |   4 +
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 142 ++++-
 {arch/x86/cpu => lib}/coreboot/sdram.c        |  15 +-
 50 files changed, 1165 insertions(+), 145 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Kconfig
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
 rename cmd/{x86 => }/cbsysinfo.c (99%)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
 create mode 100644 drivers/spi/spi-geni-qcom.c
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (95%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (98%)
 create mode 100644 lib/coreboot/Makefile
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (75%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)


base-commit: 82d262ae162d859d3b0bbcd40a9464e890b009da
-- 
Sent by a computer, using git, on the internet

