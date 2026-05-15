Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D28CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3345848A2;
	Sat, 16 May 2026 03:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A00184812; Sat, 16 May 2026 01:38:14 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA738480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO267-000000004g0-0Jx7; Fri, 15 May 2026 23:37:39 +0000
Date: Sat, 16 May 2026 00:37:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 0/8] fit: dm-verity support
Message-ID: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

[1] previous submissions:
    RFC: https://www.mail-archive.com/u-boot@lists.denx.de/msg565945.html
    v1:  https://www.mail-archive.com/u-boot@lists.denx.de/msg569472.html
    v2:  https://www.mail-archive.com/u-boot@lists.denx.de/msg570599.html
    v3:  https://www.mail-archive.com/u-boot@lists.denx.de/msg573223.html
    v4:  https://www.mail-archive.com/u-boot@lists.denx.de/msg574000.html

[2] flat-image-tree dm-verity node spec:
    https://github.com/open-source-firmware/flat-image-tree/commit/795fd5fd7f0121d0cb03efb1900aafc61c704771

v5: address comments by Heinrich Schuchardt and Simon Glass
 * mkimage: drop unused image_noffset parameter from
   fit_image_process_verity()
 * mkimage: replace popen() and the valid_algos[] allowlist with
   fork()/execvp(), eliminating shell-injection risk and allowlist
   drift
 * mkimage: drop the verity-data-file FDT property; cache the
   expanded buffer (original data + Merkle hash tree) in memory keyed
   by image name, unlink the temporary file immediately after read-
   back, and expose fit_verity_get_expanded() so fit_extract_data()
   consumes the buffer directly -- removes the tmpfile-leak surface
   along the way
 * mkimage: use unsigned int for data-block-size / hash-block-size
   on the host side too (consistency with v3 runtime change)
 * doc: document that the fitblk driver requires each filesystem
   sub-image to be aligned to the underlying block-device block size,
   and that 'mkimage -B <align>' (typically -B 0x1000) achieves this;
   clarify that this is independent of the dm-verity data-block-size
   / hash-block-size properties

v4: address comments by Simon Glass
 * pytest: verify the computed digest with veritysetup verify against
   the external data section
 * pytest: parametrize test_mkimage_verity with matched and mismatched
   block sizes to exercise hash-start-block != num-data-blocks
 * pytest: use run_and_log_expect_exception() with the expected
   diagnostic for the no-external-data case

v3: address comments by Heinrich Schuchardt and Simon Glass
 * use unsigned int instead of int for data-block-size and hash-block-size
 * replace printf() with log_err() for the "broken dm-verity metadata"
   diagnostic
 * use FIT_VERITY_*_PROP, FIT_TYPE_PROP and FIT_LOADABLE_PROP constants
   in the unit test instead of literal strings
 * extend the mkimage block-count overflow check to also cover
   hash_start_block (matters when hash-block-size < data-block-size)
 * doc: clarify that hash-start-block only equals num-data-blocks when
   data-block-size == hash-block-size
 * pytest: drop unused 'struct' import and the home-rolled
   have_veritysetup() helper in favour of
   @pytest.mark.requiredtool('veritysetup')

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

Daniel Golle (8):
  image: fit: add dm-verity property name constants
  boot: fit: support generating DM verity cmdline parameters
  include: hexdump: make hex2bin() usable from host tools
  tools: mkimage: add dm-verity Merkle-tree generation
  doc: fit: add dm-verity boot parameter documentation
  test: boot: add runtime unit test for fit_verity_build_cmdline()
  test: py: add mkimage dm-verity round-trip test
  configs: sandbox: enable CONFIG_FIT_VERITY

 boot/Kconfig                       |  20 ++
 boot/bootm.c                       |  13 +
 boot/image-board.c                 |   5 +
 boot/image-fit.c                   | 337 +++++++++++++++++++++++
 configs/sandbox64_defconfig        |   1 +
 configs/sandbox_defconfig          |   1 +
 configs/sandbox_flattree_defconfig |   1 +
 doc/usage/fit/dm-verity.rst        | 304 +++++++++++++++++++++
 doc/usage/fit/index.rst            |   1 +
 include/hexdump.h                  |   8 +-
 include/image.h                    | 115 +++++++-
 test/boot/Makefile                 |   1 +
 test/boot/fit_verity.c             | 306 +++++++++++++++++++++
 test/cmd_ut.c                      |   2 +
 test/py/tests/test_fit_verity.py   | 175 ++++++++++++
 tools/fit_image.c                  |  91 ++++++-
 tools/image-host.c                 | 414 ++++++++++++++++++++++++++++-
 17 files changed, 1783 insertions(+), 12 deletions(-)
 create mode 100644 doc/usage/fit/dm-verity.rst
 create mode 100644 test/boot/fit_verity.c
 create mode 100644 test/py/tests/test_fit_verity.py

-- 
2.54.0
