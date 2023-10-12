Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C30CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB0686CE8;
	Thu, 12 Oct 2023 03:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTp0Du4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC16C86E10; Thu, 12 Oct 2023 03:56:40 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5B28653E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7742be66bd3so31783385a.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075789; x=1697680589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qF0tbnZHrQaJuE7dWA7dmiSxZPDT1+MosjavER13wQs=;
 b=lTp0Du4c/iRn9bzNPEpIr/1+Mju4nU/OGWHkmOeUVjm6K6cnZ8qSoHnCUfIIi15+W3
 7uhCriEUBKf3c2v8mAL3qI+dUXr69xNrDdPFU/UXweyAWIdo3ysqtjqIrzmw1bJidy9n
 W24RLKwuTVjARBIaS3UnlGkpoPUf2N3W5/pZA3GKiK2ap7ck5nVV2GZHqcvndlg3ROjV
 nECobIyecS7Nmgbxkuj2wv6ufq7F35QXBNJkdKSNTnTkEY2VMxaWyi3oouZmjuZQ73WR
 Ttbu+OTYohL9pemPFXyHT2Z7zKLx1N8nRbjLHj4uyin31a5ne8B98Fj6qdgivdG37WbO
 58vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075789; x=1697680589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qF0tbnZHrQaJuE7dWA7dmiSxZPDT1+MosjavER13wQs=;
 b=g09zKb7GsaDdDMq5d4WYbcvBlS+K6oKfiEUzo5VAQRiUlFCzooQT0h1Idfqd2eY4fC
 flGIDuwDcLlVXl+w+w+PkI1jfW24bgK2nxC/TD82zLBwsHQPuh4eNM89WcfjhGeH5cda
 6xbNEw/txgf0lX2g86Wx0kmIPvNLucqZKzn2saPxbYJJPE59CCA9OpVk/O5m31OH/sjD
 7qWJPErSWVmhURdopZswEVbZU5Xg51X20MkJ2A4kq15spP4bjTgIH9d1eWeN/dc8oAk8
 hHWllFNUOydnLAlevYYNQ22btrBR+OP48CWyv13lUL7PfpBy6ow/ANuqSROXHSRrc40Z
 v8Kg==
X-Gm-Message-State: AOJu0YyKzFdFcNpKs+PSO8GdaoiGyjKkq80DJSbO69ciPu5ROlIwxv6T
 4IYUSa3YDaQprKkRl+JN1/CqdTrNEjPT3yKj
X-Google-Smtp-Source: AGHT+IG+550iSVApOZmOrIxeNSo1GzxV4Cwr1LqgcEaez30LtMhV6SKji2GQkkt/MOSibYfUXZW9CA==
X-Received: by 2002:a05:620a:166b:b0:76f:2707:77f8 with SMTP id
 d11-20020a05620a166b00b0076f270777f8mr19872574qko.46.1697075788829; 
 Wed, 11 Oct 2023 18:56:28 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d4-20020a05620a136400b00774292e636dsm5667989qkl.63.2023.10.11.18.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:28 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nitin Garg <nitin.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Stefano Babic <sbabic@denx.de>, Vignesh R <vigneshr@ti.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 00/26] test: spl: Test some load methods
Date: Wed, 11 Oct 2023 21:56:00 -0400
Message-Id: <20231012015626.3487451-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series adds some tests for various SPL load methods, with the intent of
helping debug v6 of [1]. With that in mind, notable omissions include NAND and
ROMAPI, which both lack sandbox implementations, and OS_BOOT, which I have
deferred due to its complexity. Semihosting is also omitted, but I think we can
test that with qemu.

In order to test all of these methods, we must first generate suitable images,
possibly on filesystems. While other tests have historically generated these
images using external tools (e.g. mkimage, mkfs, etc.), I have chosen to
generate them on the fly. This is for a few reasons:

- By removing external dependencies on pytest to create certain files, the tests
  become self-contained. This makes them easier to iterate on and debug.
- By generating tests at runtime, we can dynamically vary the content. This
  helps detect test failures, as even if tests are loaded to the same location,
  the expected content will be different.
- We are not testing the image parsers themselves (e.g. spl_load_simple_fit or
  fs_read) but rather the load methods (e.g. spl_mmc_load_image). It is
  unnecessary to exercise full functionality or generate 100% correct images.
- By reducing functionality to only what is necessary, the complexity of various
  formats can often be greatly reduced.

This series depends on [2-3], which are small fixes identified through this
patch set. The organization of patches in this series is as follows:

- General fixes for bugs which are unlikely to be triggered outside of this
  series
- Changes to IMX8 container images to facilitate testing
- General prep. work, particularly regarding linker issues
- The tests themselves

Mostly-passing CI at [4]; I have since fixed the typo/missing cast.

[1] https://lore.kernel.org/all/20230731224304.111081-1-sean.anderson@seco.com/
[2] https://lore.kernel.org/all/20230930204246.515254-1-seanga2@gmail.com/
[3] https://lore.kernel.org/all/20231008014748.1987840-1-seanga2@gmail.com/
[4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18091


Sean Anderson (26):
  spl: legacy: Fix referencing _image_binary_end
  spl: nor: Don't allocate header on stack
  spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
  arm: imx: Fix i.MX8 container load address
  arm: imx: Add newlines after error messages
  arm: imx: Add function to validate i.MX8 containers
  arm: imx: Check header before calling spl_load_imx_container
  Move i.MX8 container image loading support to common/spl
  spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA at the same time
  lib: acpi: Fix linking SPL when ACPIGEN is enabled
  fs: ext4: Fix building ext4 in SPL if write is enabled
  fs: Compile in sandbox filesystem in SPL if it is enabled
  net: Fix compiling SPL when fastboot is enabled
  net: bootp: Move port numbers to header
  net: bootp: Fall back to BOOTP from DHCP when unit testing
  spl: Don't cache devices when UNIT_TEST is enabled
  spl: Use map_sysmem where appropriate
  test: spl: Split tests up and use some configs
  test: spl: Fix spl_test_load not failing if fname doesn't exist
  test: spl: Add functions to create images
  test: spl: Add functions to create filesystems
  test: spl: Add a test for spl_blk_load_image
  test: spl: Add a test for the MMC load method
  test: spl: Add a test for the NET load method
  test: spl: Add a test for the NOR load method
  test: spl: Add a test for the SPI load method

 .azure-pipelines.yml                          |   4 +
 .gitlab-ci.yml                                |   7 +
 MAINTAINERS                                   |   2 +
 arch/arm/include/asm/mach-imx/ahab.h          |   2 +-
 arch/arm/mach-imx/Kconfig                     |  13 -
 arch/arm/mach-imx/Makefile                    |   2 +-
 arch/arm/mach-imx/cmd_dek.c                   |   4 +-
 arch/arm/mach-imx/ele_ahab.c                  |   4 +-
 arch/arm/mach-imx/image-container.c           |   4 +-
 arch/arm/mach-imx/imx8/ahab.c                 |   4 +-
 arch/arm/mach-imx/spl_imx_romapi.c            |   8 +-
 arch/sandbox/cpu/spl.c                        |   3 +
 arch/sandbox/cpu/start.c                      |   9 +-
 arch/sandbox/cpu/u-boot-spl.lds               |   2 +
 arch/sandbox/include/asm/spl.h                |   3 +
 common/spl/Kconfig                            |  15 +
 common/spl/Makefile                           |   1 +
 common/spl/spl.c                              |   4 +-
 common/spl/spl_blk_fs.c                       |   6 +-
 common/spl/spl_ext.c                          |   4 +-
 common/spl/spl_fat.c                          |  13 +-
 common/spl/spl_fit.c                          |  40 +-
 .../spl/spl_imx_container.c                   |  12 +-
 common/spl/spl_legacy.c                       |   8 +-
 common/spl/spl_mmc.c                          |  11 +-
 common/spl/spl_nand.c                         |   4 +-
 common/spl/spl_net.c                          |  10 +-
 common/spl/spl_nor.c                          |  18 +-
 common/spl/spl_spi.c                          |  18 +-
 configs/deneb_defconfig                       |   2 +
 configs/giedi_defconfig                       |   2 +
 configs/imx8qm_mek_defconfig                  |   2 +
 configs/imx8qxp_mek_defconfig                 |   2 +
 configs/sandbox_noinst_defconfig              |  31 +-
 configs/sandbox_spl_defconfig                 |   8 +
 configs/sandbox_vpl_defconfig                 |   1 +
 drivers/core/Makefile                         |   1 +
 drivers/core/root.c                           |   2 +-
 drivers/i2c/Makefile                          |   2 +-
 drivers/i2c/i2c-emul-uclass.c                 |   2 +-
 drivers/serial/sandbox.c                      |   2 +-
 drivers/sysreset/sysreset_sandbox.c           |   2 +-
 drivers/usb/gadget/f_sdp.c                    |   4 +-
 dts/Kconfig                                   |   8 +-
 fs/Makefile                                   |   1 +
 include/configs/sandbox.h                     |   3 +
 include/ext4fs.h                              |   1 +
 include/ext_common.h                          |  14 +
 .../image.h => include/imx_container.h        |   9 +
 include/spl.h                                 |  14 +
 include/test/spl.h                            | 155 ++++
 lib/Kconfig                                   |   6 +
 lib/Makefile                                  |   1 +
 net/Makefile                                  |   4 +-
 net/bootp.c                                   |   9 +-
 net/bootp.h                                   |   3 +
 net/net.c                                     |   4 +-
 test/Kconfig                                  |   1 +
 test/Makefile                                 |   5 +-
 test/image/Kconfig                            |  50 ++
 test/image/Makefile                           |   7 +-
 test/image/spl_load.c                         | 693 ++++++++++++++++--
 test/image/spl_load_fs.c                      | 423 +++++++++++
 test/image/spl_load_net.c                     | 252 +++++++
 test/image/spl_load_nor.c                     |  39 +
 test/image/spl_load_os.c                      |  76 ++
 test/image/spl_load_spi.c                     |  41 ++
 test/py/tests/test_spl.py                     |  10 +
 test/test-main.c                              |   2 +-
 69 files changed, 1966 insertions(+), 163 deletions(-)
 rename arch/arm/mach-imx/parse-container.c => common/spl/spl_imx_container.c (92%)
 rename arch/arm/include/asm/mach-imx/image.h => include/imx_container.h (82%)
 create mode 100644 include/test/spl.h
 create mode 100644 test/image/Kconfig
 create mode 100644 test/image/spl_load_fs.c
 create mode 100644 test/image/spl_load_net.c
 create mode 100644 test/image/spl_load_nor.c
 create mode 100644 test/image/spl_load_os.c
 create mode 100644 test/image/spl_load_spi.c

-- 
2.37.1

