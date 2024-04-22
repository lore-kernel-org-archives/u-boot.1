Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C382FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63F28885B;
	Mon, 22 Apr 2024 18:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6651D88886; Mon, 22 Apr 2024 18:22:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 06FBA8880F
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D12339;
 Mon, 22 Apr 2024 09:23:22 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D4A83F7BD;
 Mon, 22 Apr 2024 09:22:53 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Maksim Kiselev <bigunclemax@gmail.com>
Subject: Pull request: u-boot-sunxi/master for v2024.07
Date: Mon, 22 Apr 2024 17:22:49 +0100
Message-Id: <20240422162249.2479071-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

as per the usual late ;-) please pull the sunxi/master branch, containing
some 2024.07 changes for Allwinner. Not many and nothing really exciting
this time: there are more patches in fly, but they are not ready yet.
I will also send some DT updates and new board defconfig files later, once
they have seen the list. I am aware of the USB rebasing repo efforts,
but would like to see how this plays out, also we have one compatibility
issue that I painstakingly work around in the U-Boot tree for the last three
years or so. So for now I stick to the previous approach.

So now just some easy changes: support for USB peripheral mode on the
Allwinner F1C100s, T113-s3 SPI boot support, and some SPL cleanup patches.

The branch passed the gitlab CI run, and brief boot testing on some boards
didn't turn up any issues.

Please pull!

Cheers,
Andre

==================
The following changes since commit c08685289171e68afd4bae2eb2e279cdc49a407d:

  Merge tag 'u-boot-imx-master-20240420' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-04-20 15:16:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 192c5c9e51c1ef100c3d027d253ffad26ff75a68:

  sunxi: sun9i: make more clock functions SPL only (2024-04-22 01:12:26 +0100)

----------------------------------------------------------------
Andre Przywara (9):
      usb: musb-new: add Allwinner F1C100s support
      sunxi: move #ifdef guards around tzpc_init() to header file
      sunxi: remove unneeded i2c_init_board() call for U-Boot proper
      sunxi: compile clock.c for SPL only
      sunxi: sun4i: make more clock functions SPL only
      sunxi: sun6i: make more clock functions SPL only
      sunxi: sun50i_h6: make more clock functions SPL only
      sunxi: sun8i_a83t: make more clock functions SPL only
      sunxi: sun9i: make more clock functions SPL only

Maksim Kiselev (1):
      sunxi: SPL SPI: Add SPI boot support for the Allwinner R528/T113 SoCs

 arch/arm/include/asm/arch-sunxi/clock_sun9i.h |  3 -
 arch/arm/include/asm/arch-sunxi/tzpc.h        |  6 ++
 arch/arm/mach-sunxi/Kconfig                   |  2 +-
 arch/arm/mach-sunxi/Makefile                  |  2 +-
 arch/arm/mach-sunxi/board.c                   |  2 -
 arch/arm/mach-sunxi/clock.c                   |  2 -
 arch/arm/mach-sunxi/clock_sun4i.c             |  5 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 57 ++++++++--------
 arch/arm/mach-sunxi/clock_sun6i.c             |  3 +-
 arch/arm/mach-sunxi/clock_sun8i_a83t.c        |  5 +-
 arch/arm/mach-sunxi/clock_sun9i.c             | 97 +++++++++++++--------------
 arch/arm/mach-sunxi/spl_spi_sunxi.c           | 78 +++++++++++++++------
 board/sunxi/board.c                           |  9 +--
 drivers/usb/musb-new/sunxi.c                  | 16 +++++
 14 files changed, 163 insertions(+), 124 deletions(-)

