Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ABEC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 01:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EE9884BE;
	Sun, 11 Aug 2024 03:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZqia0Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8657A88871; Sat, 10 Aug 2024 22:52:21 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3344488876
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so125638639f.0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323137; x=1723927937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3zT/RbaZQYXdGSLmcUbLiP+yLoNK7KLNh2O6L9UY1xo=;
 b=bZqia0Lv5c34QcV5CXZ4Po3Hhg+ODh6NcgAUts0xO4UBZmEujxukus1Rq6cnYAiDl6
 GBbCMy0uyl37KxbCjbYJgxSYllOpCsk7r3Fyo0BH4nDoX+2OcYH6vwGyp/axhCI9QQ5L
 PZ+fqzDyvwQNHex1zdsRGZ9nhCQVAOxXQZekM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323137; x=1723927937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3zT/RbaZQYXdGSLmcUbLiP+yLoNK7KLNh2O6L9UY1xo=;
 b=AqV7iu4mdn7OB26iAOBua2Z0f362dxO3HEQzSr9Vg+p4IQbSaB5EfgEiTJWaLgsCmF
 jj/nNe0mHVl5r9u09qNImQFTAhfbVn/0JxtCaR452F7tWRC1LE8EDMgx5Rh9efwN4o65
 5vF+aYTUhaSiIoAqtTp87xNHS6K1ZJCwT688EG+9Ppcop+74S3Vkyt+iEdHcoVfIlqDt
 c5OyHXyaPrqxD02NOyh1l3UUARsz6u0EmvcUJresEYMB7OTGUiDjuNKErAbmJEcfY9jc
 Wn0eqPJIhWXSFMFpsJlnzXEVP5a3tg2nJvXrUWmy034MiDKmDSGezz/4C1mj/WmeN4/G
 vv7g==
X-Gm-Message-State: AOJu0YwKdqgR+72818nSJ3Dkrt+ZVtw52aeEGzFI9K8uGmi+xJka6HAD
 PvgKLd7oTvtE1JUC3VNddOfC0C91DzbqQKkpbwrM+/co7cVVSIe1toh3dnEb5dKcYGdN4KyR3UM
 =
X-Google-Smtp-Source: AGHT+IE17oPk8MD+2T2KPHwNcaBvHAvwfWVXNiOBY89UOrSdVsxnmSSEt0yjMJD0yN5ixHjJlRfU3Q==
X-Received: by 2002:a05:6602:6d17:b0:7f6:2819:b099 with SMTP id
 ca18e2360f4ac-8225eedb5a8mr779668439f.16.1723323136688; 
 Sat, 10 Aug 2024 13:52:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Bin Meng <bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Udit Kumar <u-kumar1@ti.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 00/21] Tidy up console recording in tests
Date: Sat, 10 Aug 2024 14:51:44 -0600
Message-Id: <20240810205205.3403177-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Aug 2024 03:30:10 +0200
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
- fix wget test and make it run on sandbox
- drop unnecessary resetting of the console in tests
- drop unnecessary blank line before MMC output
- update the docs a little
- fix buildman test failure on newer Pythons
- a few other minor things

This series also renames the confusing flag names, so that they are
easier to remember - just a UTF_ (unit-test flags) prefix.


Simon Glass (21):
  buildman: Make test_process_limit handle time.monotonic()
  test: Fail when an empty line is expected but not present
  test: Rename unit-test flags
  test: Drop the blank line before test macros
  test: Rename UTF_CONSOLE_REC to UTF_CONSOLE
  mmc: Drop the blank line before accesses
  Revert "net: wget: Support retransmission a dropped packet"
  sandbox: Enable wget command
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

 cmd/Kconfig                   |   1 +
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
 net/wget.c                    |  23 +-
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
 test/dm/nand.c                |  30 +-
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
 180 files changed, 980 insertions(+), 1342 deletions(-)

-- 
2.34.1

