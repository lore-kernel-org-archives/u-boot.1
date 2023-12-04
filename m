Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC498790E;
	Mon,  4 Dec 2023 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fI4Nqgn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB20E8788C; Mon,  4 Dec 2023 01:32:24 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC5F8786E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2e330033fso2005068b6e.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649940; x=1702254740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CrZrNfwJuGxJavF+oLor9LAsSlsIzJVXm0dxD7PbcZE=;
 b=fI4Nqgn/57BP3x9W7mphXIduVB2xIZ/KWEbYtGL10gENaZj33iWacVzXiTDlqI4Ewm
 hbXDZ2Re3zkRj7mwaHMzKTE4oKo4MONUZNSysxiISCXrk/0R4YJGllX6PCAnXgh7/yvQ
 Hh1krhqRyI/5iCl4wcRGi18fYgc9PTeSOTb3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649940; x=1702254740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CrZrNfwJuGxJavF+oLor9LAsSlsIzJVXm0dxD7PbcZE=;
 b=a+D6BRVoLhvP6F0zqwriVRrd0FfbNuyE8kbCMXP7Vs2YoVl0eHFbObqiJPjt5ue8Y6
 YuGmSgBehgvbpChLcDHkqXhOB3t9RU47DgMYWFsDnRgRJw7CrnyZi5JtS/ntxGBQSpsL
 ldvq18b70HZo15/7hR9rkdv3FFnVUOeL+dtNdG1z1JE7NQFrDmqUF/5qG/HJ9kdUEHqn
 g7r+ISVuXUKgv76vhnqOB1zy7a65XPrcT/KMS0lsQa/zp18joxFD9n1D9VPFcGpjCC/T
 hjKr5NgrKW7sF7ly9QXt4Rsc9ukBsyyeY15Uvos5h4Ndc6qPlMTWldPzeTEEn59JmXWI
 W07g==
X-Gm-Message-State: AOJu0YwWeS3GmsP/3NFNW3wbUmbnbQLCaVq4uY4aSfFAVQHHIGlR7Kc/
 iHw4EiA6Ug3F9lB84XOEWS1Ckr9taZfmpe3mxMl+qg==
X-Google-Smtp-Source: AGHT+IE/fbuV8blRgnGtaMTlhL9nUO+f8rdAev5mVmhMPYqa9i2G54ijdcl1IpyEULVpTCQRvpavEA==
X-Received: by 2002:a05:6808:152:b0:3b8:b063:6bbb with SMTP id
 h18-20020a056808015200b003b8b0636bbbmr3932624oie.106.1701649939824; 
 Sun, 03 Dec 2023 16:32:19 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anup Patel <apatel@ventanamicro.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie James <eajames@linux.ibm.com>, Eric Nelson <eric@nelint.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>, Leo <ycliang@andestech.com>,
 Manuel Traut <manuel.traut@mt.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Hoyes <peter.hoyes@arm.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Safae Ouajih <souajih@baylibre.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Shiji Yang <yangshiji66@outlook.com>, Soeren Moch <smoch@web.de>,
 Thomas Chou <thomas@wytron.com.tw>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 00/14] pxe: Allow extlinux booting without CMDLINE enabled
Date: Sun,  3 Dec 2023 17:31:24 -0700
Message-ID: <20231204003144.899097-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Dec 2023 01:45:16 +0100
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

This series is the culmanation of the current line of refactoring
series. It adjusts pxe to call the booting functionality directly
rather than going through the command-line interface.

With this is is possible to boot using the extlinux bootmeth without
the command line enabled.

It also updates fastboot to do a similar thing.

This is cmdf (part f of CMDLINE refactoring)
It depends on dm/cmde-working
which depends on dm/cmdd-working
which depends on dm/bootstda-working
which depends on dm/cmdc-working


Simon Glass (14):
  boot: Reorder FIT and BOOTSTD to be first
  bootm: Add a Kconfig option for bootm functionality
  bootm: Make OS booting dependent on BOOTM
  treewide: Make arch-specific bootm code depend on BOOTM
  boot: Update SYS_BOOTM_LEN to depend on BOOTM
  fastboot: Change fastboot_buf_addr to an address
  bootm: Make cmdline optional with bootm_boot_start()
  fastboot: Remove dependencies on CMDLINE
  pxe: Refactor to reduce the size of label_boot()
  pxe: Refactor to avoid over-using bootm_argv
  pxe: Move calculation of FDT file into a function
  pxe: Allow booting without CMDLINE for bootm methods
  pxe: Allow booting without CMDLINE for the zboot method
  x86: Drop message about features being missing with 64-bit

 arch/arc/lib/Makefile                         |   2 +-
 arch/arm/lib/Makefile                         |   2 +-
 arch/m68k/lib/Makefile                        |   2 +-
 arch/microblaze/lib/Makefile                  |   2 +-
 arch/mips/lib/Makefile                        |   2 +-
 arch/nios2/lib/Makefile                       |   2 +-
 arch/powerpc/lib/Makefile                     |   2 +-
 arch/riscv/lib/Makefile                       |   2 +-
 arch/sandbox/lib/Makefile                     |   2 +-
 arch/sh/lib/Makefile                          |   2 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/spl.c                            |   2 +-
 arch/xtensa/lib/Makefile                      |   2 +-
 boot/Kconfig                                  |  99 ++++-
 boot/Makefile                                 |   2 +-
 boot/bootm.c                                  |  10 +-
 boot/pxe_utils.c                              | 361 ++++++++++--------
 cmd/Kconfig                                   |  50 +--
 cmd/fastboot.c                                |   2 +-
 configs/colibri_vf_defconfig                  |   2 +-
 configs/iot_devkit_defconfig                  |   2 +-
 configs/mx6memcal_defconfig                   |   2 +-
 configs/tools-only_defconfig                  |   2 +-
 configs/xilinx_versal_mini_defconfig          |   2 +-
 configs/xilinx_versal_mini_emmc0_defconfig    |   2 +-
 configs/xilinx_versal_mini_emmc1_defconfig    |   2 +-
 configs/xilinx_versal_mini_ospi_defconfig     |   2 +-
 configs/xilinx_versal_mini_qspi_defconfig     |   2 +-
 configs/xilinx_versal_net_mini_defconfig      |   2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig |   2 +-
 configs/xilinx_versal_net_mini_ospi_defconfig |   2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig |   2 +-
 configs/xilinx_zynqmp_mini_defconfig          |   2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +-
 .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig     |   2 +-
 configs/zynq_cse_nand_defconfig               |   2 +-
 configs/zynq_cse_nor_defconfig                |   2 +-
 configs/zynq_cse_qspi_defconfig               |   2 +-
 doc/board/emulation/qemu-x86.rst              |   2 +-
 drivers/fastboot/Kconfig                      |   1 -
 drivers/fastboot/fb_command.c                 |  13 +-
 drivers/fastboot/fb_common.c                  |  37 +-
 include/bootm.h                               |   2 +-
 include/fastboot-internal.h                   |   2 +-
 include/fastboot.h                            |   6 +-
 48 files changed, 352 insertions(+), 305 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

