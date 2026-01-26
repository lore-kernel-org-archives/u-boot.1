Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E0BCF65E5
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 12:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346FC83B32;
	Mon, 26 Jan 2026 13:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47A683B55; Mon, 26 Jan 2026 13:10:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4B00583B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 13:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2FA339;
 Mon, 26 Jan 2026 04:10:02 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.33.9.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CCA3F5CA;
 Mon, 26 Jan 2026 04:10:07 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] u-boot-sunxi/master for v2026.04
Date: Mon, 26 Jan 2026 12:10:02 +0000
Message-Id: <20260126121002.383545-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

Hi Tom,

please pull these sunxi changes for 2064.04. Some improvements for some
boards' DRAM setup, to allow boards with "odd" DRAM sizes (1.5GB or 3GB),
and to support the T113-s4 with double the co-packaged DRAM.
Support for a new board (X96Q TV box), and a fix for the DT name prefix.
Also we support the new AXP318W PMIC, which is used on new boards with the
A733 SoC. There are some preliminary support patches for this SoC, but
they are not quite ready yet - though maybe I push some uncontroversial
ones a bit later still.

Thanks,
Andre

=============================
The following changes since commit 0ffca1dff1e8960b5920dfc3164e0fcd5892b961:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2026-01-25 11:20:53 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 8805aa120ca5341ca14d8f7f2311f7a85d57a5f9:

  board: sunxi: Add X96Q support (2026-01-25 23:29:32 +0000)

----------------------------------------------------------------
Andre Przywara (1):
      sunxi: dram: detect non-power-of-2 sized DRAM chips

Bohdan Chubuk (1):
      sunxi: avoid double vendor prefix when CONFIG_OF_UPSTREAM is enabled

J. Neuschäfer (1):
      board: sunxi: Add X96Q support

Lukas Schmid (1):
      sunxi: extend R528/T113-s3/D1(s) DRAM initialisation

Yixun Lan (2):
      power: regulator: add AXP318W support
      power: regulator: enable AWP318W SPL support

 arch/arm/include/asm/arch-sunxi/dram.h  |  1 +
 arch/arm/mach-sunxi/dram_dw_helpers.c   | 22 ++++++++++++++-
 arch/arm/mach-sunxi/dram_helpers.c      | 12 ++++++++
 board/sunxi/MAINTAINERS                 |  5 ++++
 board/sunxi/board.c                     |  5 +++-
 configs/x96q_defconfig                  | 27 ++++++++++++++++++
 drivers/power/Kconfig                   | 10 +++++++
 drivers/power/Makefile                  |  1 +
 drivers/power/axp_spl.c                 | 20 +++++++++++++
 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/axp_regulator.c | 50 +++++++++++++++++++++++++++++++++
 drivers/ram/sunxi/dram_sun20i_d1.c      | 10 +++++++
 drivers/ram/sunxi/dram_sun20i_d1.h      | 11 ++++++++
 include/axp_pmic.h                      |  1 +
 14 files changed, 174 insertions(+), 2 deletions(-)
 create mode 100644 configs/x96q_defconfig
