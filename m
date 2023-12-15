Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD59AC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606288798E;
	Fri, 15 Dec 2023 14:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LPTk1qB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B874287AEC; Fri, 15 Dec 2023 05:19:30 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651C787AD1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ba3cf9aa13so242927b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613966; x=1703218766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iaTJvqbm8F6MPCs9ukq39/CA8mtNjQWG1uEcQlGdGAg=;
 b=LPTk1qB4avz/bgx1/eh7drVeZ18IXicfMWxU7VIKBGGexdL+vlJYyES1uOwXRtoDKM
 bS//ZlfEhifWACL13TAvk8zyDHRiGVyqt966gmmvsMWyayoxxQKceXdBVe2Tb288hicD
 DXS4cnuVK/J3OXTqqyjT35ZdrJnqFIqfbvup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613966; x=1703218766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaTJvqbm8F6MPCs9ukq39/CA8mtNjQWG1uEcQlGdGAg=;
 b=R8m2V4GIk3sO/WPoWnh6U2wQr+MdBya7jmr8LWVvohN3drX+2s9nlauIRgYGh9NNH0
 stXMUOpEhJU/H1k5ldOoxbKC5iV2Odft1PEr+mvLO7pGpgc3J1S/1/B3hw3Ilahava2C
 SOjDtfVcEfMKyKAW+/qRWcel6c1AneRnR6nO1MpiYY9njunKsaYIRkm8uGktS76YF3jl
 xd/kqQSkZupMUW0y0NFMyEhraaEPqEAcNfk3Knnq1N+I0crakL9MTYYF00zOmKnXsx8z
 QBTUq5OHOcnmCABu7f772V2hyQN1d0+hkMaRviGs0kTmhmoscm4bkwYmS5UHVpzz23w6
 Zh+w==
X-Gm-Message-State: AOJu0Yx2p4ziBtj8qtXt0a0T+YbMzC4fiJfjAKy0wtxrGnqFoEekXWn+
 yDUVUOoomqSLv6b36/koBofvFBgnkf9u4V4kzLMp/g==
X-Google-Smtp-Source: AGHT+IFk+FQSplpHSIgMrBgZlY3DZEAiAvjIncGBW9Lud7KCyVl7aVz045Vt173c6/Pdt1Xpj4fgPQ==
X-Received: by 2002:a05:6808:151f:b0:3b8:b063:664d with SMTP id
 u31-20020a056808151f00b003b8b063664dmr11243678oiw.68.1702613965671; 
 Thu, 14 Dec 2023 20:19:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Kiernan <alex.kiernan@gmail.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>, Eric Nelson <eric@nelint.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Hoyes <peter.hoyes@arm.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Shiji Yang <yangshiji66@outlook.com>, Soeren Moch <smoch@web.de>,
 Thomas Chou <thomas@wytron.com.tw>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH v2 00/16] pxe: Allow extlinux booting without CMDLINE enabled
Date: Thu, 14 Dec 2023 21:18:58 -0700
Message-ID: <20231215041919.2197788-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Dec 2023 14:15:15 +0100
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

Changes in v2:
- Use unmap_sysmem() too
- Drop check for NULL with env_set()
- Avoid changing the logic when a command is not set
- Split out the strlcpy() change into its own patch
- Update commit message to mention booti
- Use bootm_init() instead of memset()

Simon Glass (16):
  boot: Reorder FIT and BOOTSTD to be first
  bootm: Add a Kconfig option for bootm functionality
  bootm: Make OS booting dependent on BOOTM
  treewide: Make arch-specific bootm code depend on BOOTM
  boot: Update SYS_BOOTM_LEN to depend on BOOTM
  fastboot: Change fastboot_buf_addr to an address
  bootm: Make cmdline optional with bootm_boot_start()
  fastboot: Remove dependencies on CMDLINE
  doc: Mention fastboot dependency on CMDLINE
  pxe: Use strlcpy() instead of strcpy() in label_boot()
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
 boot/pxe_utils.c                              | 360 ++++++++++--------
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
 doc/android/fastboot.rst                      |   1 +
 doc/board/emulation/qemu-x86.rst              |   2 +-
 drivers/fastboot/Kconfig                      |   1 -
 drivers/fastboot/fb_command.c                 |  17 +-
 drivers/fastboot/fb_common.c                  |  37 +-
 include/bootm.h                               |   2 +-
 include/fastboot-internal.h                   |   2 +-
 include/fastboot.h                            |   6 +-
 48 files changed, 350 insertions(+), 301 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

