Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B50C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5780988A2C;
	Thu, 22 Aug 2024 15:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oRJUr/gO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3E488A02; Thu, 22 Aug 2024 15:58:17 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9561D886F3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d2256ee11so3163345ab.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335093; x=1724939893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0Pab2N0PC7jCml0fIOgkvc58VKcLSX6hofoxwtoA0g=;
 b=oRJUr/gOmQbp/U9SH6GL24Mp2I4nhtYHB79JQaMcUuRfHiJ3wG8RJZqVj5NLF3c2a5
 G6GZEKGw/x+KguDJbb3Wwii8JlkDGoSdW45xruLgTNl0jJzog/KfzTxuIHcrbKoZ/6Lz
 zxhMU38NjBIEKnMl+144N54BTkVqoWdK0zkzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335093; x=1724939893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0Pab2N0PC7jCml0fIOgkvc58VKcLSX6hofoxwtoA0g=;
 b=PNIYxndFCGMzyOxf9wRbfVigiyazsgn8JtVovW2fgijPfq8b/Xp2jZ0P9ZsLDVDmbo
 k8Jl9Rneg3D0RRwnqdGkgwNiUI/JhPgL752roDHEQDTHgti+OXh4UKcfAmOZVxODfclc
 MGbp1k3jqK9FArSlBTE+unJPny6BiDes30oTqvnLG9olQF0IVStiogrPGdpYAz/NmRkX
 5K6S2lmYE/oZKiM9Iu5gaHDaZGqe6JtgPC5/YNxg/jMBC8qgZPyw/ZljHVBo7l/Unt0o
 KL+QF9ukf4gUvIC8L8CK96iEIrcXyKjdesMx5qu7+Nnkq+M8s9fVOHvCriuu6FwktJG+
 5hOA==
X-Gm-Message-State: AOJu0YxqpxosV0miNyJf9VtWpUiD549GsGTFDZP9/lL3keCWhs7TzlBc
 YnSYhw9aIeNB+rz2Q4WsZ1W4+vstSm+MnRtKEhP/vGHLFhCqw2T+8dYTmp8VrIbxD7j3dm/6oKc
 =
X-Google-Smtp-Source: AGHT+IEq5iIYsuWilEsIUOVZ6mmeMplikjyZVzBAt23hnKFjHOK9W+lPCnwMiTnnBw5TVBltpSYoyQ==
X-Received: by 2002:a05:6e02:b2c:b0:398:4bda:cf66 with SMTP id
 e9e14a558f8ab-39d6c3bc180mr62149545ab.18.1724335093206; 
 Thu, 22 Aug 2024 06:58:13 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 00/19] Tidy up console recording in tests
Date: Thu, 22 Aug 2024 07:57:45 -0600
Message-Id: <20240822135804.2375959-1-sjg@chromium.org>
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

This series started as a small fix for checking for an empty line,
but in the process several other problems were found and fixed:

- fix tests which use console recording but don't set the flag
- drop unnecessary resetting of the console in tests
- drop unnecessary blank line before MMC output
- update the docs a little
- fix buildman test failure on newer Pythons
- a few other minor things

This series also renames the confusing flag names, so that they are
easier to remember - just a UTF_ (unit-test flags) prefix.

Changes in v2:
- Update env test too
- Rewrite as separate functions to avoid the macro
- Drop wget patches as they have been sent by the author

Simon Glass (19):
  buildman: Make test_process_limit handle time.monotonic()
  test: Fail when an empty line is expected but not present
  test: Rename unit-test flags
  test: Drop the blank line before test macros
  test: Rename UTF_CONSOLE_REC to UTF_CONSOLE
  mmc: Drop the blank line before accesses
  test: Update NAND test to avoid extra macros
  test: bloblist: Use UTF_CONSOLE in tests
  test: boot: Use UTF_CONSOLE in tests
  test: fdt: Check internal-function return values
  test: fdt: Move common code into the setup functions
  test: cmd: Use UTF_CONSOLE in tests
  test: cmd: Drop unnecessary console_record_reset_enable()
  test: dm: Use UTF_CONSOLE in tests
  test: hush: Use UTF_CONSOLE in tests
  test: log: Use UTF_CONSOLE in tests
  test: Use UTF_CONSOLE in remaining tests
  test: Tidy up checking for console end
  doc: Add a few notes about how to use console checking

 cmd/mmc.c                     |  12 +-
 common/console.c              |   2 +
 doc/develop/commands.rst      |   9 +-
 doc/develop/tests_writing.rst |  18 +-
 doc/usage/cmd/ut.rst          |   2 +-
 include/console.h             |   2 +-
 include/dm/test.h             |   2 +-
 include/test/log.h            |   5 +-
 include/test/spl.h            |   2 +-
 include/test/test.h           |  32 +-
 include/test/ut.h             |   2 +-
 test/bloblist.c               |  14 +-
 test/boot/bootdev.c           |  49 ++-
 test/boot/bootflow.c          |  65 ++--
 test/boot/bootmeth.c          |  14 +-
 test/boot/cedit.c             |  13 +-
 test/boot/expo.c              |  15 +-
 test/boot/upl.c               |   6 +-
 test/boot/vbe_fixup.c         |   4 +-
 test/boot/vbe_simple.c        |   2 +-
 test/cmd/addrmap.c            |   3 +-
 test/cmd/armffa.c             |   3 +-
 test/cmd/bdinfo.c             |  24 +-
 test/cmd/exit.c               |  39 +--
 test/cmd/fdt.c                | 544 +++++++++++++++-------------------
 test/cmd/font.c               |  13 +-
 test/cmd/history.c            |   2 +-
 test/cmd/loadm.c              |   6 +-
 test/cmd/mbr.c                |  24 +-
 test/cmd/mem_search.c         |  31 +-
 test/cmd/pci_mps.c            |   3 +-
 test/cmd/pinmux.c             |   7 +-
 test/cmd/pwm.c                |   7 +-
 test/cmd/rw.c                 |   5 +-
 test/cmd/seama.c              |   9 +-
 test/cmd/setexpr.c            |  24 +-
 test/cmd/temperature.c        |   5 +-
 test/cmd/test_echo.c          |   8 +-
 test/cmd/test_pause.c         |   9 +-
 test/cmd/wget.c               |   9 +-
 test/common/cread.c           |   4 +-
 test/common/event.c           |   2 +-
 test/common/test_autoboot.c   |   4 +-
 test/dm/acpi.c                |  39 +--
 test/dm/acpi_dp.c             |   2 +-
 test/dm/acpigen.c             |  19 +-
 test/dm/adc.c                 |  16 +-
 test/dm/audio.c               |   2 +-
 test/dm/axi.c                 |   9 +-
 test/dm/blk.c                 |  16 +-
 test/dm/blkmap.c              |   4 +-
 test/dm/bootcount.c           |  10 +-
 test/dm/bus.c                 |  26 +-
 test/dm/button.c              |  12 +-
 test/dm/cache.c               |   2 +-
 test/dm/clk.c                 |   7 +-
 test/dm/clk_ccf.c             |   3 +-
 test/dm/core.c                |  47 ++-
 test/dm/cpu.c                 |   3 +-
 test/dm/cros_ec.c             |  18 +-
 test/dm/cros_ec_pwm.c         |   2 +-
 test/dm/devres.c              |  12 +-
 test/dm/dma.c                 |   6 +-
 test/dm/dsa.c                 |   6 +-
 test/dm/dsi_host.c            |   3 +-
 test/dm/ecdsa.c               |   2 +-
 test/dm/efi_media.c           |   2 +-
 test/dm/eth.c                 |  24 +-
 test/dm/extcon.c              |   3 +-
 test/dm/fastboot.c            |   2 +-
 test/dm/fdtdec.c              |   4 +-
 test/dm/ffa.c                 |   6 +-
 test/dm/firmware.c            |   2 +-
 test/dm/fpga.c                |   3 +-
 test/dm/fwu_mdata.c           |   4 +-
 test/dm/gpio.c                |  32 +-
 test/dm/host.c                |   8 +-
 test/dm/hwspinlock.c          |   3 +-
 test/dm/i2c.c                 |  19 +-
 test/dm/i2s.c                 |   2 +-
 test/dm/iommu.c               |   8 +-
 test/dm/irq.c                 |  10 +-
 test/dm/led.c                 |  12 +-
 test/dm/mailbox.c             |   2 +-
 test/dm/mdio.c                |   3 +-
 test/dm/mdio_mux.c            |   3 +-
 test/dm/memory.c              |   3 +-
 test/dm/misc.c                |   3 +-
 test/dm/mmc.c                 |   4 +-
 test/dm/mux-cmd.c             |   6 +-
 test/dm/mux-emul.c            |   4 +-
 test/dm/mux-mmio.c            |   4 +-
 test/dm/nand.c                |  47 ++-
 test/dm/nop.c                 |   3 +-
 test/dm/nvmxip.c              |   3 +-
 test/dm/of_platdata.c         |  16 +-
 test/dm/ofnode.c              | 106 +++----
 test/dm/ofread.c              |   2 +-
 test/dm/osd.c                 |   6 +-
 test/dm/p2sb.c                |   2 +-
 test/dm/panel.c               |   2 +-
 test/dm/part.c                |   6 +-
 test/dm/pch.c                 |   4 +-
 test/dm/pci.c                 |  31 +-
 test/dm/pci_ep.c              |   3 +-
 test/dm/phy.c                 |  10 +-
 test/dm/phys2bus.c            |   2 +-
 test/dm/pinmux.c              |   6 +-
 test/dm/pmc.c                 |   2 +-
 test/dm/pmic.c                |  13 +-
 test/dm/power-domain.c        |   2 +-
 test/dm/pwm.c                 |   2 +-
 test/dm/qfw.c                 |   6 +-
 test/dm/ram.c                 |   2 +-
 test/dm/read.c                |   2 +-
 test/dm/reboot-mode.c         |   6 +-
 test/dm/regmap.c              |  18 +-
 test/dm/regulator.c           |  20 +-
 test/dm/remoteproc.c          |   4 +-
 test/dm/reset.c               |  11 +-
 test/dm/rkmtd.c               |   6 +-
 test/dm/rng.c                 |   6 +-
 test/dm/rtc.c                 |  18 +-
 test/dm/scmi.c                |  17 +-
 test/dm/scsi.c                |   2 +-
 test/dm/serial.c              |   3 +-
 test/dm/sf.c                  |   4 +-
 test/dm/simple-bus.c          |   2 +-
 test/dm/simple-pm-bus.c       |   2 +-
 test/dm/sm.c                  |   3 +-
 test/dm/smem.c                |   2 +-
 test/dm/soc.c                 |   3 +-
 test/dm/sound.c               |   4 +-
 test/dm/spi.c                 |   6 +-
 test/dm/spmi.c                |   6 +-
 test/dm/syscon-reset.c        |   2 +-
 test/dm/syscon.c              |   6 +-
 test/dm/sysinfo-gpio.c        |   2 +-
 test/dm/sysinfo.c             |   3 +-
 test/dm/sysreset.c            |   8 +-
 test/dm/tag.c                 |   4 -
 test/dm/tee.c                 |   3 +-
 test/dm/test-fdt.c            |  58 ++--
 test/dm/timer.c               |   4 +-
 test/dm/tpm.c                 |   8 +-
 test/dm/usb.c                 |  12 +-
 test/dm/video.c               |  42 +--
 test/dm/virtio.c              |   2 +-
 test/dm/virtio_device.c       |   8 +-
 test/dm/virtio_rng.c          |   2 +-
 test/dm/wdt.c                 |   8 +-
 test/env/cmd_ut_env.c         |   2 +-
 test/env/hashtable.c          |   2 -
 test/hush/dollar.c            |  10 +-
 test/hush/loop.c              |  11 +-
 test/lib/asn1.c               |   3 -
 test/lib/efi_device_path.c    |   1 -
 test/lib/efi_image_region.c   |   2 -
 test/lib/hexdump.c            |   3 -
 test/lib/lmb.c                |   1 -
 test/lib/rsa.c                |   2 -
 test/lib/sscanf.c             |   1 -
 test/lib/string.c             |   3 -
 test/lib/test_aes.c           |   1 -
 test/lib/test_crc8.c          |   1 -
 test/lib/test_crypt.c         |   1 -
 test/lib/test_errno_str.c     |   1 -
 test/lib/test_print.c         |  16 +-
 test/lib/uuid.c               |   1 -
 test/log/cont_test.c          |   7 +-
 test/log/log_filter.c         |   7 +-
 test/log/log_test.c           |  51 +---
 test/log/nolog_ndebug.c       |   3 +-
 test/log/nolog_test.c         |  24 +-
 test/log/pr_cont_test.c       |   3 +-
 test/print_ut.c               |  21 +-
 test/test-main.c              |  40 +--
 test/ut.c                     |   8 +-
 tools/buildman/test.py        |   1 +
 179 files changed, 989 insertions(+), 1328 deletions(-)

-- 
2.34.1

