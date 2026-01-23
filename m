Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C702D7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1A4839DF;
	Fri, 23 Jan 2026 12:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="I2w+tWfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660DA83A6A; Fri, 23 Jan 2026 12:45:34 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D2D8397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 99858C21ABE;
 Fri, 23 Jan 2026 11:45:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 32F9F6070A;
 Fri, 23 Jan 2026 11:45:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 05546119A83E7; Fri, 23 Jan 2026 12:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Af96CRtaFXV09nPfwtHt5VxFIV0xxsLf/C7r3PKBd8E=;
 b=I2w+tWfG2mkZUMyJ4NsZEVGXR02T4/Szw7WVY7xZsk0z4Rz2OuxEdlETfXk72WAn1v7J9A
 1A1cKvX7P0mCypijWe7vDctAt80v2VGh2axCtBA/in1kS8aICCD98QLnJ6F3IDxNJ/EQ5n
 W8E5xJ8lUDf8qtWIGbaRmLCk7bRej913MKAVbgpF9hMj3iDd74aRBpwp4s1r2IEY+O6XmE
 2hQCHKAkQxBn+Fo+LLn+F1KrC4byTRX5yLzbwtdadsCV45kQaZbMT2SQRJ7jE3oMGPGx9y
 +NWWI7coZS4ftXcf9+BsItaOPGJ57XPjLhQ+ru5jEmbeqMszFvfJIY/P1KTYfA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 00/26] Introduce Allwinner H6/H616 NAND controller support
Date: Fri, 23 Jan 2026 12:44:35 +0100
Message-ID: <20260123114507.1400918-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This patch series introduce H6/H616 NAND controller support (but not yet
the DMA/MDMA part).

All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
chip.
ECC is supported, as well as scrambling.

H6 SoC has not been tested, but it shares all registers with H616, plus
some registers dedicated to Embedded Crypto Engine that H616 lacks.

This IP has quite some register fields modified from the A10/A23, but in
the end, it works more or less the same.
Main differences with A10/A23 are:
- The need for 2 more clocks (for ECC and MBUS)
- The use of a new USER_DATA_LEN register
- More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
- MDMA based on chained buffers
- some registers layouts have changed (mainly due do the stronger ECC)

Patches 1 and 2 are small fixes

Patches 3-6 harmonize the registers definitions between U-Boot and SPL,
and ultimately merge those definitions in an include file, without
functional change, removing the usage of sunxi_ccm_reg on the way.

Patches 7-19 are paving the way to the introduction of H6/H616 NAND
controller by adding per SoC capabilities for both drivers. They are
small for an easier review, without functional change.

Patches 20-21 are adding missing NAND related clocks definitions for
H6/H616

Patch 22 adds the support for H6/H616 NAND controller in U-Boot.

Patch 23 adds the support for H6/H616 NAND controller in SPL.

Patch 24 fixes warnings in sunxi_nand_spl.c

Patch 25 fixes a wrong page size setting in control register
NB: this patch is new

Patch 26 introduces support for H6/H616 in sunxi-spl-image-builder
NB: this last patch was sent apart from this series first

A similar series for this NAND controller support in Linux has been
upstreamed.

Changes from v2:
- add patch 25 and 26
- use if (IS_ENABLED(CONFIG_ whenever that was possible
- removed the check on length in nand_readlcpy()
- harmonize CCU_NAND0_CLK_CFG defines
- rebase onto v2026.01

Changes from v1:
- pick-up reviewed-by
- use a readl() loop instead of memcpy_fromio() in patch 2 as suggested
  by Andre
- remove cosmetic in patches that are beyond cosmetic changes
- remove usage of struct sunxi_ccm_reg, suggested by Andre
- indent @caps member description in comment
- give more informations on PAT_FOUND registers in commit message
- drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the very
  same bit NFC_ECC_BLOCK_512
- add missing MACH_SUN50I_H6 in Kconfig


Richard Genoud (26):
  mtd: rawnand: sunxi: cosmetic: remove needless comment
  mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
  mtd: rawnand: sunxi_spl: harmonize register defines with non spl file
  mtd: rawnand: sunxi_spl: cosmetic: use definitions from
    linux/mtd/rawnand.h
  mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
  mtd: rawnand: sunxi: merge register definitions for
    sunxi_nand{,_spl}.c
  mtd: rawnand: sunxi: add per SoC capabilities
  mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
  mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
  mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
  mtd: rawnand: sunxi: add has_ecc_block_512 capability
  mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
  mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
  mtd: rawnand: sunxi_spl: add per SoC capabilities
  mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
  mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
  mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
  mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
  mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macros
  sunxi: clock: H6: add NAND controller clock registers
  clk: sunxi: Add MBUS Master Clock Gating Register
  mtd: rawnand: sunxi: add support for H6/H616 nand controller
  mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
  mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
  mtd: rawnand: sunxi: fix page size in control register
  tools: sunxi-spl-image-builder: support H6/H616 NAND boot

 arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
 .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
 board/sunxi/board.c                           |  19 +-
 drivers/clk/sunxi/clk_h6.c                    |   2 +
 drivers/clk/sunxi/clk_h616.c                  |   2 +
 drivers/mtd/nand/raw/Kconfig                  |   4 +-
 drivers/mtd/nand/raw/sunxi_nand.c             | 310 ++++++++---------
 drivers/mtd/nand/raw/sunxi_nand.h             | 228 +++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c         | 319 +++++++++++-------
 scripts/Makefile.xpl                          |   1 +
 tools/sunxi-spl-image-builder.c               |  92 +++--
 14 files changed, 702 insertions(+), 304 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h


base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
-- 
2.47.3

