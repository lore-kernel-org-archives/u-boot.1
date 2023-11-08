Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B873EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D728755B;
	Wed,  8 Nov 2023 17:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kyY10pzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621A5871AB; Wed,  8 Nov 2023 17:49:06 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A24871AB
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2b1af09c5so3429427b6e.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462141; x=1700066941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzdXB1sthp1NUiYSFf7nB+rmZs553lE0YRG+xjqEi8U=;
 b=kyY10pzWtJetFnBbHyA1rY0iMWM3923RSKAEmNv4LnPs1lHeFhmksFPL6rz/hYqP2V
 dHGvlw+oyyxtfa5RwbXG5O8d27Yv3malsN2/K/GTqsV7rIKFNILaRz4Ztl8Zb67Nt2l/
 h89KWrf7XCcVbEEF6yT+1uNjqKIqiS3YIyq9Fx+pwEpRVLkB1ObTXiZwAGJUiVZnLPfG
 +4IrT0H+SqVmF3a9vBfJG3tqDE2eD1fx0rI+pEo2CS7L4F9yKWv+fxAMdHc0aZG8nyAu
 hmytTtH3Gn9nzU+MtpBR0jdRVRXKgwFxw1eEQRO/fdTSTTrWOXaM9gLOXF8ivBVz4iB5
 933Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462141; x=1700066941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CzdXB1sthp1NUiYSFf7nB+rmZs553lE0YRG+xjqEi8U=;
 b=fQ0VRQ1kSV693QjRzoa3DKiwBGdrimjn52BWoZDv8olIjtCJY7Fbitc7a5ZP4Z5fi/
 ZJXgRd3lsvsiNAwF3iCnnaV/b4BsRRYReOlMHbcMCL1yOV3+0S2tUYfGNnAnj8otmhpG
 3wOi76MzPpIg1ykRS+7mGpsJf2izxs+E3f4uKFuBSMm+N2o3Ojc2ZAcIktzF8YOmKhC3
 Q/h2ZMRJEVBTdz3m1udcq3OVQXG7nWcLL1RWMEplL6LU59vqaexxg8RrU0yji1xkbOyF
 LeNEBmK5kJoVaZiCH7mnyp4XsgKo3d5+xlOYC3UVNTJ8ToHNG6brXIxgwjToNkaazXxS
 QBQw==
X-Gm-Message-State: AOJu0YwoaBWcalA+VVd0i8O4SLJcRYIAbpn6//FiwJMc4Hml9QNj9ZMi
 kAQBKDcpDaBVlraJI1EPy3Q=
X-Google-Smtp-Source: AGHT+IEtyGCFUTzjdQbEz4//pLPChqvICGcJRCoafSw3XYpqGfY+gb/IWDvTTg3DS2BZ/7W8KgGNog==
X-Received: by 2002:a05:6808:8d9:b0:3b2:e233:1e7 with SMTP id
 k25-20020a05680808d900b003b2e23301e7mr2321329oij.49.1699462141151; 
 Wed, 08 Nov 2023 08:49:01 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 qb1-20020ad44701000000b0065d03eae7a0sm1244997qvb.82.2023.11.08.08.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:00 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Vignesh R <vigneshr@ti.com>,
 uboot-imx@nxp.com
Subject: [PATCH v7 00/26] spl: Use common function for loading/parsing images
Date: Wed,  8 Nov 2023 11:48:32 -0500
Message-Id: <20231108164858.3497420-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds support for loading all image types (Legacy (with and without
LZMA), FIT (with and without LOAD_FIT_FULL), and i.MX) to the MMC, SPI, NOR,
NET, FAT, EXT, NVMe, and semihosting load methods. It does this by introducing a
helper function which handles the minutiae of invoking the proper parsing
function, and reading the rest of the image.

Hopefully, this will make it easier for load methods to support all image types
that U-Boot supports, without having undocumented unsupported image types. I
applied this to several loaders which were invoking spl_load_simple_fit and/or
spl_parse_image_header, but I did not use it with others (e.g. DFU/RAM) which
had complications in the mix.

This series is organized roughly into two parts. Patches up to "spl: Add generic
spl_load function" are all setup or size-reduction oriented. Later patches
generally convert various load functions to spl_load.

bloat-o-meter results (for CONFIG_SPL only) at [1]. Size growth has been the
bigegst challenge to preparing this series. I have used every trick I can think
of to reduce bloat. Some SAMA boards no longer fit, but I have a plan to fix
them [2].

This is bar far the largest and most-difficult revision of this series to-date.
There are probably still things which can reduce the size, but I have been
working on this series for the better part of two months and I think it is a
good idea to get some feedback. Because of the SAMA bloat, this series will not
pass CI, so I expect to do a v7 before this is ready to apply. Feel free,
however, to apply patches in the first half (especially the fixes).

This version of the series is better-tested than ever before, thanks to some new
unit tests. However, things like the i.MX ROMAPI are untested. NAND should also
be tested more-widely, for reasons listed in the commit message. I encourage you
try this series out on your favorite board.

This series depends on [3]. (Almost passing) CI at [4].

[1] https://gist.github.com/Forty-Bot/5bfe88676dd3c2aec6ebc23abb08e06f
    This includes some changes to am335x_evm_spiboot and am65x_evm_r5_usbdfu
    which have since been undone. This was ran for v6.
[2] https://lore.kernel.org/u-boot/20231105022742.632175-1-seanga2@gmail.com/
[3] https://lore.kernel.org/u-boot/20231104203753.1579217-1-seanga2@gmail.com/
[4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18447
    For v6.

Changes in v7:
- Disable FS_FAT for the zynq(mp) boards as well, as suggested by Michal
- Reword documentation for spl_load_info
- Split off setting bl_len to ARCH_DMA_MINALIGN from filename removal
- Remove Pali from CC

Changes in v6:
- Fix uninitialized return value when we can't get a blk_desc
- Disable SPL_FS_FAT when it isn't used
- Don't close fd before spl_load_simple_fit
- Remove NULL assignments in spl_load_info
- Remove dev from spl_load_info
- Take advantage of bl_len's power-of-twoness
- Refactor spl_load_info->read to use units of bytes
- Remove filename from spl_load_info
- Only support bl_len when we have to
- Remove spl_nand_legacy_read
- Split off LZMA decompression into its own function
- Support testing LEGACY_LZMA filesystem images
- Use pseudo-LTO for spl_load
- Align reads to bl_len
- Add SYS_MMCSD_RAW_MODE to help determine whether SPL_MMC loads
  anything directly.
- Convert nand to spl_load
- Fix LZMA support
- Fix load address
- Fix invalid return from spl_blk_load_image
- Fix soft reset after loading from SPI
- Explicitly initialize load_info members to reduce text size
- Rebase on u-boot/next
- Add option to disable DMA alignment for FAT

Changes in v5:
- Make SHOW_ERRORS depend on LIBCOMMON
- Load the header in spl_load as well
- Don't bother trying to DMA-align the buffer, since we can't really fix
  it.
- Convert NVMe to spl_load

Changes in v4:
- Fix format specifiers in debug prints
- Reword/fix some of the doc comments for spl_load
- Rebase on u-boot/master

Changes in v3:
- Fix using ffs instead of fls
- Fix using not initializing bl_len when info->filename was NULL
- Fix failing on success

Changes in v2:
- Use reverse-xmas-tree style for locals in spl_simple_read. This is not
  complete, since overhead depends on bl_mask.
- Convert semihosting as well
- Consolidate spi_load_image_os into spl_spi_load_image

Sean Anderson (26):
  spl: blk_fs: Fix uninitialized return value when we can't get a
    blk_desc
  arm: Disable SPL_FS_FAT when it isn't used
  spl: Make SHOW_ERRORS depend on LIBCOMMON
  spl: semihosting: Don't close fd before spl_load_simple_fit
  spl: Remove NULL assignments in spl_load_info
  spl: Remove dev from spl_load_info
  spl: Take advantage of bl_len's power-of-twoness
  spl: Refactor spl_load_info->read to use units of bytes
  spl: Set FAT bl_len to ARCH_DMA_MINALIGN
  spl: Remove filename from spl_load_info
  spl: Only support bl_len when we have to
  spl: nand: Remove spl_nand_legacy_read
  spl: legacy: Split off LZMA decompression into its own function
  test: spl: Support testing LEGACY_LZMA filesystem images
  spl: Add generic spl_load function
  spl: Convert ext to use spl_load
  spl: Convert fat to spl_load
  spl: Convert mmc to spl_load
  spl: Convert nand to spl_load
  spl: Convert net to spl_load
  spl: Convert nor to spl_load
  spl: Convert NVMe to spl_load
  spl: Convert semihosting to spl_load
  spl: Convert spi to spl_load
  spl: spi: Consolidate spi_load_image_os into spl_spi_load_image
  spl: fat: Add option to disable DMA alignment

 arch/arm/mach-imx/spl_imx_romapi.c        |  24 ++--
 arch/arm/mach-sunxi/spl_spi_sunxi.c       |   5 +-
 common/spl/Kconfig                        |  37 +++++-
 common/spl/spl.c                          |  13 +-
 common/spl/spl_blk_fs.c                   |  73 +++--------
 common/spl/spl_ext.c                      |  36 +++---
 common/spl/spl_fat.c                      |  62 ++++------
 common/spl/spl_fit.c                      |  74 ++++-------
 common/spl/spl_imx_container.c            |  55 ++++-----
 common/spl/spl_legacy.c                   | 110 ++++-------------
 common/spl/spl_mmc.c                      | 101 ++-------------
 common/spl/spl_nand.c                     | 104 ++++------------
 common/spl/spl_net.c                      |  29 +----
 common/spl/spl_nor.c                      |  42 ++-----
 common/spl/spl_ram.c                      |   2 +-
 common/spl/spl_semihosting.c              |  65 ++--------
 common/spl/spl_spi.c                      | 130 ++++---------------
 common/spl/spl_ymodem.c                   |   4 +-
 configs/am335x_evm_spiboot_defconfig      |   2 +-
 configs/am65x_evm_r5_usbdfu_defconfig     |   1 -
 configs/xilinx_zynqmp_mini_qspi_defconfig |   3 +-
 configs/zynq_cse_nand_defconfig           |   2 +
 configs/zynq_cse_nor_defconfig            |   2 +
 configs/zynq_cse_qspi_defconfig           |   2 +
 drivers/usb/gadget/f_sdp.c                |  10 +-
 include/spl.h                             |  62 ++++++++--
 include/spl_load.h                        | 144 ++++++++++++++++++++++
 include/test/spl.h                        |   4 +
 test/image/Kconfig                        |   1 +
 test/image/spl_load.c                     |  13 +-
 test/image/spl_load_fs.c                  |  32 +++--
 test/image/spl_load_nand.c                |   2 +
 test/image/spl_load_net.c                 |   2 +
 test/image/spl_load_nor.c                 |   2 +
 test/image/spl_load_os.c                  |  16 ++-
 test/image/spl_load_spi.c                 |   1 +
 36 files changed, 534 insertions(+), 733 deletions(-)
 create mode 100644 include/spl_load.h

-- 
2.37.1

