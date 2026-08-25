Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1119C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F6B606F8;
	Tue, 25 Aug 2026 15:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kBkpj0RknCY; Tue, 25 Aug 2026 15:58:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673489;
	bh=eTOm+0xsg1wJDDddbJkeULGe3iMSzcecWSN+uOo72CY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JMd57oilegvpOuhc0JI28X8LOi4MGvL8xb8wtSoO5NXZWhGbSTLUmSWnu+nUimm+5
	 jANIQKlSKE6LLj5DvIWcSq91zdvPbBjXuaMcLSow4DBdZMqujubatJmVRQC5GYvUFr
	 HntRWgvsoU0/aZoEFTbYlpi4eXaDEjBlHA02/GZUWYyATJk6MoNejHgkwvS2VGrKFx
	 9q2C8alXwjDIEhJ+cSRPaKMBa9Enm432h0ynbGJZT+MMPNwvv9g2b4sci59t59s1qT
	 RqcWKmvKulSiSGJkAOQbttzFuNeP8w+aLsXAecXY98hfDt+bQi/bZJ3/yfya4Z1kTb
	 zZARoGSdxwagw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B46160604;
	Tue, 25 Aug 2026 15:58:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57DDF118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E851806BC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl2LifVKTNRa for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:58:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9483805F5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:05 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytXE-000000003s5-2PCa; Tue, 25 Aug 2026 15:58:00 +0000
Date: Tue, 25 Aug 2026 16:57:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 00/11] imagemap: on-demand FIT loading from storage
Message-ID: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds "imagemap", a small layer for reading FIT images directly
from storage on demand instead of copying the whole image into RAM first.
It keeps a translation table of the byte ranges already loaded, so a
header probe, signature verification and the final load can reuse a single
read, and it hooks transparently into fit_image_load() so all existing
verification and decompression paths run unchanged for both RAM- and
storage-backed images.

An imagemap device is created over a partition of a block device. That
covers more than raw disks: an MTD partition is reached through mtdblock
and a UBI volume through ubiblock, each exposed as a named block-device
partition, so imagemap carries no storage-specific code of its own. NAND
bad-block handling and wear-levelling stay with UBI, as they do elsewhere
in U-Boot; on NOR a partition is read linearly with end-to-end integrity
guaranteed by the FIT hash or signature.

To make those two paths reachable and testable, the first patches fill in
the missing block devices: a non-NAND MTD master now gets an mtd_blk
device automatically (patch 1), and attaching UBI now binds a ubi_blk
device on any flash (patch 3, which makes the SPI-NAND-only eager binding
redundant, dropped in patch 4).

The read path is built on the SPL struct spl_load_info abstraction and a
new spl_load_region() helper. imagemap is full-U-Boot only; the SPL FIT
loader is unaffected.

Testing (sandbox): "ut imagemap" (13 tests) covers the translation-table
core plus real end-to-end reads of a NOR partition through mtd_blk and a
UBI volume through ubiblock; a CONFIG_IMAGEMAP=n build is unaffected. The
whole series passes CI [1].

On hardware it has been tested end-to-end on a BananaPi R3 (mt7986),
booting a dm-verity-protected rootfs from every storage path the board
exposes: eMMC and SD (block partition), SPI-NAND (UBI volume via
ubiblock) and SPI-NOR (raw MTD partition via mtdblock). The first
in-tree consumer, a bootmeth for OpenWrt-style FIT firmware, will follow
as a separate series.

Changes in v2 (since v1 [2]):

  - Add two prerequisite fixes for the UBI block driver that enabling
    CONFIG_UBI_BLOCK in sandbox exposes: make it depend on CMD_UBI (its
    ubi_volume_read()/write() live in cmd/ubi.c, so a CONFIG_CMDLINE=n
    build otherwise fails to link), and stop the UBI partition scan from
    claiming any readable block device or dereferencing a NULL ubi_device.
  - include/spl.h: express the block-length field directly with
    #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) || CONFIG_IS_ENABLED(IMAGEMAP)
    instead of a SPL_LOAD_INFO_HAS_BL_LEN helper macro, and fold the note
    into the existing struct comment (per Tom Rini).
  - boot: fit: fix a continuation-line alignment in fit_image_load()
    flagged by checkpatch (per Tom Rini).

This series began as part of a combined RFC that also carried the OpenWrt
boot method and its bootdevs [3]. Following the review there it has been
reworked substantially:

  - Build on U-Boot's existing SPL external-data loading path rather than
    a new abstraction: imagemap now uses struct spl_load_info and a new
    spl_load_region() helper (suggested by Marek Vasut).

  - Do not extend the bootm command with a storage source; on-demand
    loading hooks into fit_image_load() transparently, and the in-tree
    consumer is a bootstd boot method reached through
    bootflow/bootdev/bootmeth rather than new bootm syntax (per Tom Rini).

  - Move the storage-backed path out of the long fit_image_load() into its
    own helper, gated with if()/tools_build() instead of an inline #if
    (per Simon Glass).

  - Collapse the three storage-specific backends (block, MTD and UBI) into
    a single block backend: NOR is read through mtd_blk and SPI-NAND
    through UBI/ubiblock, so imagemap holds no storage-specific code.

  - Send the on-demand loading core on its own; the OpenWrt boot method,
    the MTD/UBI bootdevs and board enablement follow as separate series
    once this lands.

A note on that follow-up: to tell Linux which FIT it booted, U-Boot uses
the install-uuid mechanism of [4], which [5] could supersede. Both have
stalled.

[1] https://git.u-boot-project.org/u-boot/contributors/dgolle/u-boot/-/pipelines/1067
[2] https://lore.kernel.org/u-boot/cover.1787272661.git.daniel@makrotopia.org/
[3] https://lore.kernel.org/u-boot/cover.1771275704.git.daniel@makrotopia.org/
[4] https://github.com/open-source-firmware/flat-image-tree/pull/40
[5] https://github.com/open-source-firmware/flat-image-tree/pull/44

Daniel Golle (11):
  mtd: bind an mtd_blk device for non-NAND MTD masters
  mtd: nand: sandbox: forbid sub-page writes
  cmd: ubi: create a ubi_blk device when attaching UBI
  mtd: nand: spi: drop the eager ubi_blk binding
  mtd: ubi: block: build only with CONFIG_CMD_UBI
  mtd: ubi: block: only claim UBI block devices in the partition scan
  boot: add imagemap on-demand loading from storage
  boot: fit: support on-demand loading in fit_image_load()
  configs: sandbox: enable imagemap and its storage backends
  test: boot: add imagemap unit tests
  doc: imagemap: document on-demand loading framework

 MAINTAINERS                      |   9 +
 arch/sandbox/dts/test.dts        |  29 ++
 boot/Kconfig                     |  16 +
 boot/Makefile                    |   2 +
 boot/bootm.c                     |  70 +++-
 boot/image-fit.c                 | 109 +++++-
 boot/imagemap.c                  | 451 +++++++++++++++++++++
 cmd/ubi.c                        |  27 ++
 configs/sandbox_defconfig        |   6 +
 doc/develop/imagemap.rst         | 100 +++++
 doc/develop/index.rst            |   1 +
 drivers/mtd/mtdcore.c            |  24 ++
 drivers/mtd/nand/raw/sand_nand.c |   2 +
 drivers/mtd/nand/spi/core.c      |   3 -
 drivers/mtd/ubi/Kconfig          |   1 +
 drivers/mtd/ubi/part.c           |   9 +
 include/bootm.h                  |   2 +
 include/dm/uclass-id.h           |   1 +
 include/image.h                  |   2 +
 include/imagemap.h               | 136 +++++++
 include/spl.h                    |  38 +-
 test/boot/Makefile               |   2 +
 test/boot/imagemap.c             | 645 +++++++++++++++++++++++++++++++
 test/cmd_ut.c                    |   2 +
 24 files changed, 1671 insertions(+), 16 deletions(-)
 create mode 100644 boot/imagemap.c
 create mode 100644 doc/develop/imagemap.rst
 create mode 100644 include/imagemap.h
 create mode 100644 test/boot/imagemap.c


base-commit: 8841b7b292c74864acf4ed0bd8ce05839252c1f2
-- 
2.55.0
