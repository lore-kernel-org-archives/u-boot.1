Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9B2CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B353849AC;
	Wed, 10 Jun 2026 14:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pvMOXTlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3784974; Wed, 10 Jun 2026 14:22:00 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AF7841C2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gb4dw1ZXGz9v64;
 Wed, 10 Jun 2026 14:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pBtd+JSrVVY8e+6KODmcf3Co2WLdFdYOJVvFW5vMnzg=;
 b=pvMOXTlYMj9IjCNSgEvQ04iwOLxnK3oEIMZBq+X6xQ5/S1Yf/IR1HT5eMubT+YhxmNVqol
 a6arhS98Up0bXfARuhcW+w/7WO0Ugl/T8Kq0jZGIvYp+2T4tGu1ibxYym9fdq5frY8z67M
 GSZ5ZqA0YMYhMgSFJyZWG8j/PI7HuauclrL3mGcw7ZmsWxUzJznU0kCjtY4ct1DuFCnNY5
 wuY5DtljgHSLk9rM+XMKqtmjCyxKmdyWzvtiyu/FE1CAEWiEtj4iQnGxMd7aBS9Q3sIwOK
 ekve60K8YkhKuM95KkqwrLdlFL1wiTeUC7J59bdavCmS+rfmhmIechwyKiBh/g==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-marvell/next
Date: Wed, 10 Jun 2026 14:21:55 +0200
Message-ID: <20260610122155.2674504-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b0ac5857fed8d74738e
X-MBO-RS-META: 51roeb7gye8bzpnhwxjjikffot5azr8h
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

Hi Tom,

please pull the following marvell changes for the next branch:

- arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL NSA325 board (Tony)
- net: mvpp2: fix NULL pointer dereference in mvpp2_phy_connect (Vincent)
- mtd: nand: pxa3xx: Pass valid dev to dev_err() (Chris)
- arm: mvebu: db-xc3-24g4xg: Remove marvell, nand-keep-config (Chris)
- arm: mvebu: Add Allied Telesis x220 (Chris)
- board: Synology: legacy.c: Include asm/io.h (Phil)
- board: Synology: common: Fix typo in Makefile (Phil)
- serial: serial_octeon_bootcmd.c: use correct Kconfig symbol (Heinrich)
- arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage (Tom)
- pinctrl: armada-38x: Staticize and constify driver ops (Marek)
- arm: mach-mvebu: armada8k: cpuinfo and SAR (Vincent)
- board: freebox: add Nodebox 10G board support (Vincent)
- board: freebox: nbx10g: add emmcboot for dual-bank eMMC boot (Vincent)
- board: freebox: nbx10g: add device serial and MAC address initialization (Vincent)
- arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE (Vincent)
- timer: orion: Use dev_remap_addr_index() (Peng)

CI (GitLab world build) is passing:
https://source.denx.de/u-boot/custodians/u-boot-marvell/-/pipelines/30413

Thanks,
Stefan

The following changes since commit 511bd63db98836579764b87c961a7f50c8149839:

  Merge assorted patches to use device API to replace devfdt_ helpers (2026-06-09 16:00:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-marvell.git tags/u-boot-marvell-next-20260610

for you to fetch changes up to eab66c3a9085e07b227847b0c442ee8d2efb241d:

  timer: orion: Use dev_remap_addr_index() (2026-06-10 11:23:26 +0200)

----------------------------------------------------------------
u-boot-marvell changes 2026-06-10

----------------------------------------------------------------
Chris Packham (3):
      mtd: nand: pxa3xx: Pass valid dev to dev_err()
      arm: mvebu: db-xc3-24g4xg: Remove marvell, nand-keep-config
      arm: mvebu: Add Allied Telesis x220

Heinrich Schuchardt (1):
      serial: serial_octeon_bootcmd.c: use correct Kconfig symbol

Marek Vasut (1):
      pinctrl: armada-38x: Staticize and constify driver ops

Peng Fan (1):
      timer: orion: Use dev_remap_addr_index()

Phil Sutter (2):
      board: Synology: legacy.c: Include asm/io.h
      board: Synology: common: Fix typo in Makefile

Tom Rini (1):
      arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage

Tony Dinh (1):
      arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL NSA325 board

Vincent Jardin (6):
      net: mvpp2: fix NULL pointer dereference in mvpp2_phy_connect
      arm: mach-mvebu: armada8k: cpuinfo and SAR
      board: freebox: add Nodebox 10G board support
      board: freebox: nbx10g: add emmcboot for dual-bank eMMC boot
      board: freebox: nbx10g: add device serial and MAC address initialization
      arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE

 arch/arm/dts/Makefile                             |   2 +
 arch/arm/dts/armada-8040-nbx-u-boot.dtsi          |  15 +
 arch/arm/dts/armada-8040-nbx.dts                  | 259 ++++++++++++++++
 arch/arm/dts/armada-xp-atl-x220.dts               | 162 ++++++++++
 arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi  |   1 -
 arch/arm/mach-mvebu/Kconfig                       |  16 +
 arch/arm/mach-mvebu/armada8k/Makefile             |   2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c                |  12 +
 arch/arm/mach-mvebu/armada8k/soc_info.c           | 194 ++++++++++++
 arch/arm/mach-mvebu/armada8k/soc_info.h           |  14 +
 board/Marvell/mvebu_armada-37xx/board.c           |   5 -
 board/Synology/common/Makefile                    |   2 +-
 board/Synology/common/legacy.c                    |   1 +
 board/alliedtelesis/x220/.gitattributes           |   1 +
 board/alliedtelesis/x220/.gitignore               |   1 +
 board/alliedtelesis/x220/MAINTAINERS              |   8 +
 board/alliedtelesis/x220/Makefile                 |  14 +
 board/alliedtelesis/x220/binary.0                 | Bin 0 -> 423 bytes
 board/alliedtelesis/x220/kwbimage.cfg.in          |  12 +
 board/alliedtelesis/x220/x220.c                   |  67 ++++
 board/freebox/nbx10g/Kconfig                      |  94 ++++++
 board/freebox/nbx10g/MAINTAINERS                  |   6 +
 board/freebox/nbx10g/Makefile                     |   5 +
 board/freebox/nbx10g/board.c                      |  53 ++++
 board/freebox/nbx10g/nbx_emmcboot.c               | 357 ++++++++++++++++++++++
 board/freebox/nbx10g/nbx_fbxserial.c              | 286 +++++++++++++++++
 board/freebox/nbx10g/nbx_fbxserial.h              | 156 ++++++++++
 board/freebox/nbx10g/nbx_imagetag.h               |  78 +++++
 board/freebox/nbx10g/nbx_nrboot.h                 |  34 +++
 board/zyxel/nsa325/nsa325.c                       |   7 +-
 configs/eDPU_defconfig                            |   1 -
 configs/mvebu_db-88f3720_defconfig                |   1 -
 configs/mvebu_espressobin-88f3720_defconfig       |   1 -
 configs/mvebu_espressobin_ultra-88f3720_defconfig |   1 -
 configs/mvebu_nbx_88f8040_defconfig               |  75 +++++
 configs/uDPU_defconfig                            |   1 -
 configs/x220_defconfig                            |  76 +++++
 doc/board/alliedtelesis/index.rst                 |  11 +
 doc/board/alliedtelesis/x220.rst                  |  39 +++
 doc/board/index.rst                               |   1 +
 drivers/mtd/nand/raw/pxa3xx_nand.c                |  11 +-
 drivers/net/mvpp2.c                               |   4 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c        |   2 +-
 drivers/serial/Kconfig                            |   2 +-
 drivers/timer/orion-timer.c                       |   3 +-
 include/configs/nbx10g.h                          |  29 ++
 include/configs/x220.h                            |  20 ++
 47 files changed, 2114 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi
 create mode 100644 arch/arm/dts/armada-8040-nbx.dts
 create mode 100644 arch/arm/dts/armada-xp-atl-x220.dts
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.c
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.h
 create mode 100644 board/alliedtelesis/x220/.gitattributes
 create mode 100644 board/alliedtelesis/x220/.gitignore
 create mode 100644 board/alliedtelesis/x220/MAINTAINERS
 create mode 100644 board/alliedtelesis/x220/Makefile
 create mode 100644 board/alliedtelesis/x220/binary.0
 create mode 100644 board/alliedtelesis/x220/kwbimage.cfg.in
 create mode 100644 board/alliedtelesis/x220/x220.c
 create mode 100644 board/freebox/nbx10g/Kconfig
 create mode 100644 board/freebox/nbx10g/MAINTAINERS
 create mode 100644 board/freebox/nbx10g/Makefile
 create mode 100644 board/freebox/nbx10g/board.c
 create mode 100644 board/freebox/nbx10g/nbx_emmcboot.c
 create mode 100644 board/freebox/nbx10g/nbx_fbxserial.c
 create mode 100644 board/freebox/nbx10g/nbx_fbxserial.h
 create mode 100644 board/freebox/nbx10g/nbx_imagetag.h
 create mode 100644 board/freebox/nbx10g/nbx_nrboot.h
 create mode 100644 configs/mvebu_nbx_88f8040_defconfig
 create mode 100644 configs/x220_defconfig
 create mode 100644 doc/board/alliedtelesis/index.rst
 create mode 100644 doc/board/alliedtelesis/x220.rst
 create mode 100644 include/configs/nbx10g.h
 create mode 100644 include/configs/x220.h
