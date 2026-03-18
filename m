Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049EF103E166
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6630784118;
	Wed, 18 Mar 2026 12:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26718413A; Wed, 18 Mar 2026 12:57:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6305F84114
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D571E2F;
 Wed, 18 Mar 2026 04:57:04 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A16A3F73B;
 Wed, 18 Mar 2026 04:57:08 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Pull request: u-boot-sunxi/master for next
Date: Wed, 18 Mar 2026 12:57:02 +0100
Message-ID: <20260318115702.1637000-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
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

Hi Tom,

please pull these sunxi changes into next:
For once, replacing the legacy LED API with a more lean alternative,
just for sunxi's SPL. IIUC, this would be one step closer to dropping
this deprecated subsystem altogether.
Also adding two DRAM cleanups for the A133 SoC. There is a third patch
which requires some changes, will care about that later.

Gitlab CI passed, and I booted that briefly on an A133 board and some
board with a GPIO controlled power LED.

Thanks,
Andre

===========================================================
The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:

  kbuild: strip sub_make_done from test-script environment (2026-03-16 10:41:40 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git sunxi/master

for you to fetch changes up to 98429b7be6f45d393cc905b2cf9844eed7b09b8a:

  sunxi: a133: dram: Align parameters terminology with Allwinner (2026-03-17 23:27:24 +0100)

----------------------------------------------------------------
Paul Kocialkowski (2):
      sunxi: a133: dram: Fix PHY dx delays offsets and add dmb
      sunxi: a133: dram: Align parameters terminology with Allwinner

Quentin Schulz (1):
      sunxi: remove usage of legacy LED API

 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h |  2 +
 arch/arm/mach-sunxi/Kconfig                        | 25 ++++++++
 arch/arm/mach-sunxi/dram_sun50i_a133.c             | 67 ++++++++++++++--------
 board/sunxi/board.c                                | 16 ++++--
 configs/liontron-h-a133l_defconfig                 |  6 +-
 configs/pinephone_defconfig                        |  9 +--
 6 files changed, 89 insertions(+), 36 deletions(-)
