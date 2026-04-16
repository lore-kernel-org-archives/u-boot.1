Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9544FF433D6
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 01:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A6383EEF;
	Thu, 16 Apr 2026 03:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C75E84105; Thu, 16 Apr 2026 03:46:50 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F354583B99
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 03:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wDBoF-000000006cz-1SWR; Thu, 16 Apr 2026 01:46:23 +0000
Date: Thu, 16 Apr 2026 02:46:15 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v2 0/7] fit: dm-verity support
Message-ID: <cover.1776302805.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This series adds dm-verity support to U-Boot's FIT image infrastructure.
It is the first logical subset of the larger OpenWrt boot method series
posted as an RFC in February 2026 [1], extracted here for independent
review and merging.

OpenWrt's firmware model embeds a read-only squashfs or erofs root
filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
loadable FIT image. At boot the kernel maps this sub-image directly from
the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
...), the goal is that the bootloader never even copies it to RAM.

dm-verity enables the kernel to verify the integrity of those mapped
filesystems at read time, with a Merkle hash tree stored contiguously in
the same sub-image just after the data. Two kernel command-line
parameters are required:

  dm-mod.create=   -- the device-mapper target table for the verity device
  dm-mod.waitfor=  -- a comma-separated list of block devices to wait for
                      before dm-init sets up the targets (needed when fitblk
                      probes late, e.g. because it depends on NVMEM
                      calibration data)

The FIT dm-verity node schema was upstreamed into the flat-image-tree
specification [2], which this implementation tries to follow exactly.

The runtime feature is guarded behind CONFIG_FIT_VERITY. If not
enabled the resulting binary size remains unchanged. If enabled the
binary size increases by about 3kB.

[1] RFC/v2: https://www.mail-archive.com/u-boot@lists.denx.de/msg565945.html
[2] flat-image-tree dm-verity node spec:
    https://github.com/open-source-firmware/flat-image-tree/commit/795fd5fd7f0121d0cb03efb1900aafc61c704771

v2: address comments by Simon Glass
 * use is_power_of_2() for pre-boot sanity check
 * let fit_verity_build_cmdline() return 0 on success
 * add comment explaining why bootm_start() calls fit_verity_free()
 * use existing hex2bin() (and adapt it to be usable for host-tools)
 * fix stale comment still including superblock despite veritysetup
   being called with --no-superblock
 * add power-of-two check for data-block-size and hash-block-size to
   mkimage
 * don't ignore return value of fdt_delprop()
 * various documentation fixes, minimal example
 * add pytest for mkimage part
 * add run-time unit test for cmdline generation part

Daniel Golle (7):
  image: fit: add dm-verity property name constants
  boot: fit: support generating DM verity cmdline parameters
  include: hexdump: make hex2bin() usable from host tools
  tools: mkimage: add dm-verity Merkle-tree generation
  doc: fit: add dm-verity boot parameter documentation
  test: boot: add runtime unit test for fit_verity_build_cmdline()
  test: py: add mkimage dm-verity round-trip test

 boot/Kconfig                     |  20 ++
 boot/bootm.c                     |  13 ++
 boot/image-board.c               |   5 +
 boot/image-fit.c                 | 337 +++++++++++++++++++++++++++++
 doc/usage/fit/dm-verity.rst      | 282 +++++++++++++++++++++++++
 doc/usage/fit/index.rst          |   1 +
 include/hexdump.h                |   8 +-
 include/image.h                  |  97 ++++++++-
 test/boot/Makefile               |   1 +
 test/boot/fit_verity.c           | 298 ++++++++++++++++++++++++++
 test/cmd_ut.c                    |   2 +
 test/py/tests/test_fit_verity.py | 153 ++++++++++++++
 tools/fit_image.c                | 116 +++++++++-
 tools/image-host.c               | 349 ++++++++++++++++++++++++++++++-
 14 files changed, 1669 insertions(+), 13 deletions(-)
 create mode 100644 doc/usage/fit/dm-verity.rst
 create mode 100644 test/boot/fit_verity.c
 create mode 100644 test/py/tests/test_fit_verity.py

-- 
2.53.0
