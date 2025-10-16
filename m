Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ADDCCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD9583655;
	Thu, 16 Oct 2025 16:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dFKZtd3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11418367F; Thu, 16 Oct 2025 16:28:28 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033B280077
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 94AB1C041C9;
 Thu, 16 Oct 2025 14:28:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B73B06062C;
 Thu, 16 Oct 2025 14:28:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82D16102F218E; 
 Thu, 16 Oct 2025 16:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=46paUZ4+KPcmy6xI1Gq5jA0VX6fKiDJ4r9kQst0jC1Y=;
 b=dFKZtd3KHRVfyMu8g8vzBUSPEtUXHc960bVN2K87Ws1fCTohXh/CYI0/neXTRoORZu9HAH
 zgJK30RJohIWqPASvQIKE+ClmNHdZ4+XI8ILtGrYYTvlOBIqaxUlu4qA4qszu05JaoOPKI
 e5tEYYVcx7tKnW+NrZobVNpEQ2oJwLzlhJ/4z/byxE6eQ5X9rtYIy+tzXfuXakwugpBAzD
 Rp1WdR0Kq3UbELICd71TW7ww6qukHGNc7gnDtRXxwAiL6GEPoX1sw0tip+r75UQ+mPSBBW
 olgHAxCvq7uE0Q8pAD2KDF/Qcxud+t0RGKu6c530ospf+blBdfic5sigZAH/WA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 00/24] Introduce Allwinner H6/H616 NAND controller support
Date: Thu, 16 Oct 2025 16:27:23 +0200
Message-ID: <20251016142752.2627710-1-richard.genoud@bootlin.com>
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

Hi everyone,

This patch series introduce H6/H616 NAND controller support (but not yet
the DMA/MDMA part).

All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
chip.
ECC is supported, as well as scrambling.

Support for booting from NAND is not part of this series, but it's almost
ready. (It needs quite some modifications in sunxi-spl-image-builder.c
and sunxi_toc0.c)

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
functional change.

Patches 7-19 are paving the way to the introduction of H6/H616 NAND
controller by adding per SoC capabilities for both drivers. They are
small for an easier review, without functional change.

Patches 20-21 are adding missing NAND related clocks definitions for
H6/H616

Patch 22 adds the support for H6/H616 NAND controller in U-Boot.

Patch 23 adds the support for H6/H616 NAND controller in SPL.

Patch 24 fixes warnings in sunxi_nand_spl.c

A similar series for this NAND controller support in Linux has been sent
and being reviewed.

Richard Genoud (24):
  mtd: rawnand: sunxi: cosmetic: remove needless comment
  mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
  mtd: rawnand: sunxi_spl: cosmetic: harmonize register defines with non
    spl file
  mtd: rawnand: sunxi_spl: cosmetic: use definitions from
    linux/mtd/rawnand.h
  mtd: rawnand: sunxi_spl: cosmetic: replace AHB_DIV_1 by
    CCM_NAND_CTRL_M/N
  mtd: rawnand: sunxi: cosmetic: merge register definitions for
    sunxi_nand{,_spl}.c
  mtd: rawnand: sunxi: cosmetic: add per SoC capabilities
  mtd: rawnand: sunxi: cosmetic: move ECC_ERR_CNT register offset in SoC
    caps
  mtd: rawnand: sunxi: cosmetic: move USER_DATA register offset in SoC
    caps
  mtd: rawnand: sunxi: cosmetic: move ECC_PAT_FOUND register in SoC caps
  mtd: rawnand: sunxi: cosmetic: add has_ecc_block_512 capability
  mtd: rawnand: sunxi: cosmetic: move NFC_ECC_MODE offset in SoC caps
  mtd: rawnand: sunxi: cosmetic: introduce reg_pat_id in sunxi_nfc_caps
  mtd: rawnand: sunxi_spl: cosmetic: add per SoC capabilities
  mtd: rawnand: sunxi: cosmetic: move NFC_RANDOM_EN register offset in
    SoC caps
  mtd: rawnand: sunxi: cosmetic: introduce reg_spare_area in
    sunxi_nfc_caps
  mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
  mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
  mtd: rawnand: sunxi_spl: cosmetic: use NFC_ECC_MODE and
    NFC_RANDOM_SEED macros
  sunxi: clock: H6: add NAND controller clock registers
  clk: sunxi: Add MBUS Master Clock Gating Register
  mtd: rawnand: sunxi: add support for H6/H616 nand controller
  mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
  mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings

 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
 board/sunxi/board.c                           |  17 +-
 drivers/clk/sunxi/clk_h6.c                    |   2 +
 drivers/clk/sunxi/clk_h616.c                  |   2 +
 drivers/mtd/nand/raw/Kconfig                  |   3 +-
 drivers/mtd/nand/raw/sunxi_nand.c             | 301 ++++++++---------
 drivers/mtd/nand/raw/sunxi_nand.h             | 229 +++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c         | 305 +++++++++++-------
 8 files changed, 616 insertions(+), 267 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h


base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
