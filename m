Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ECD87113;
	Mon,  6 Nov 2023 03:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fllCIz2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7195E86FB0; Mon,  6 Nov 2023 03:26:30 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C803286AB3
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41e3e77e675so27354421cf.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237566; x=1699842366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cdifLaSwXQFpdkLgHFuRZxc+OIzRPmWK/f1ykn5p+/Y=;
 b=fllCIz2SmwydYU6u8PIRkZCoQQj7U+gAlakW4QjQc0uPBm7rBdyr4evkFiH2BV4q/g
 dwbRzBMEJFiEmwlcLquECKZNTLfd5ORoLal8Dw2zjzlS+p4KWIV6XbatDZzr13rs4oMA
 GOsI7nZQ9FyqjsfVry3KuTL5z95pNkdggOgVFiTQh2I+Rnyig8iqU36GfxcvOl5R/nQY
 ZC2U1Hy+xDlLgftbvdno0nBdAnoJFYsopCaPBLBKhs2O8etNutdMxGwS17XrsAH5GQAE
 RLEQ0RZ5xaeH12YVqmpX9ucolaDRs0ywVWu3o3TQcyA1Wr1cIDSb0nmVMTepddT95SR9
 q/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237566; x=1699842366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdifLaSwXQFpdkLgHFuRZxc+OIzRPmWK/f1ykn5p+/Y=;
 b=CIGruaf9g/oBpwbpP3GtyS1PoWMzkL3luYylVW63G0xdwFRy4vDeX3MisUSqydCZs0
 Gc3rUdGWdKJiivOhmo4TBT3Rt2OUS3LIyDq4lOtd1/KIK3CxdxKgThUAFw2mz2WlzY4m
 WlJwrmJl1SWN/X9MgwTjfloZwpeKvMncS8ozDhEvZavrjuFETz+Kxb3xJ7tF1QWbr1ZJ
 QL+yc4SWC+67+jP9ld6Oq8twSYY9LQ3kqb3wG29LKElaqOYi7Uz47ugKqo6AHEd8MfS/
 ZpfaAgHjnya1Maj653f8XEFx5hD4bwGqSa+cMHRIzq3ieHgroWnuz1BKP3KIgNK16qej
 fkrg==
X-Gm-Message-State: AOJu0YxEnUTYKURES+QKs4rQcbUmZPDdW/ZMtUw428ZEfLOptr0weGdA
 fm7A0x3gLShJVKChHMfPJ3s=
X-Google-Smtp-Source: AGHT+IFxVU3IE094NWjGvJaL0nhSkr9FxUbGDShPKBuxi1j5btvLqmuo9oodvswP3Klbs2Tq6s1cTw==
X-Received: by 2002:ac8:5714:0:b0:41b:774b:b1a2 with SMTP id
 20-20020ac85714000000b0041b774bb1a2mr38573485qtw.22.1699237566046; 
 Sun, 05 Nov 2023 18:26:06 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bw7-20020a05622a098700b004181f542bcbsm3015913qtb.11.2023.11.05.18.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:05 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
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
Subject: [PATCH v6 00/25] spl: Use common function for loading/parsing images
Date: Sun,  5 Nov 2023 21:25:38 -0500
Message-Id: <20231106022603.3405551-1-seanga2@gmail.com>
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
    which have since been undone.
[2] https://lore.kernel.org/u-boot/20231105022742.632175-1-seanga2@gmail.com/
[3] https://lore.kernel.org/u-boot/20231104203753.1579217-1-seanga2@gmail.com/
[4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18447

Changes in v6:
- Fix uninitialized return value when we can't get a blk_desc
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

Sean Anderson (25):
  spl: blk_fs: Fix uninitialized return value when we can't get a
    blk_desc
  arm: Disable SPL_FS_FAT when it isn't used
  spl: Make SHOW_ERRORS depend on LIBCOMMON
  spl: semihosting: Don't close fd before spl_load_simple_fit
  spl: Remove NULL assignments in spl_load_info
  spl: Remove dev from spl_load_info
  spl: Take advantage of bl_len's power-of-twoness
  spl: Refactor spl_load_info->read to use units of bytes
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
 configs/xilinx_zynqmp_mini_qspi_defconfig |   3 +
 configs/zynq_cse_nand_defconfig           |   3 +
 configs/zynq_cse_nor_defconfig            |   3 +
 configs/zynq_cse_qspi_defconfig           |   3 +
 drivers/usb/gadget/f_sdp.c                |  10 +-
 include/spl.h                             |  60 +++++++--
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
 36 files changed, 536 insertions(+), 732 deletions(-)
 create mode 100644 include/spl_load.h

-- 
2.37.1

