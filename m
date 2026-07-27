Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EB2C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73D2D40729;
	Mon, 27 Jul 2026 17:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsmTBRYSN8EK; Mon, 27 Jul 2026 17:48:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73702406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785174496;
	bh=C3UNmj4TmYQ4A7EoUmNlGXXFkQ4BVPq7Hi9364iXEi8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G6b1o951xJiwxsMffffJc/XYGDcb0ia6iveqzW1UKI18F3ncER4F+X+OZTBLZyve/
	 JDrERLFNIItRJbVjHjoaYl7+E7Jl7n4quqYCk4rUKPyK7JYRhf51gjTKbWyjjnLcZn
	 CAbDuNy/t+dj8xjZfyUyuKPabrB3cbaClv+p8IgY45hfHBpDO7cybeFbOSCcL1xQHb
	 p2zXJAs7KTtVySJWBvexjyQIOYrUCUR32dYxC3W0BRXnxpbAB2gbnoEWZk6Xi2rw/P
	 Ma6CwyfLcBkZOn1g/YvZ8wWxRziApdiirj7czawkShgAFvLfy+fETaZnuQazFcFnMQ
	 UOAluUZ8skIew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73702406FC;
	Mon, 27 Jul 2026 17:48:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 113B82E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02468406FC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovuVoCEnf1qp for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:48:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 80F45406EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80F45406EB
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80F45406EB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:48:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481CE1682;
 Mon, 27 Jul 2026 10:48:07 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 35CED3F763; Mon, 27 Jul 2026 10:48:10 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, linux-sunxi@lists.linux.dev
Subject: Pull request: u-boot-sunxi/main for 2026.10
Date: Mon, 27 Jul 2026 19:44:14 +0200
Message-ID: <20260727174414.22152-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785174491; bh=EH6izdmRU6juO6PplM7nIJkFuZyzHgPoahx5WL/2rhM=;
 h=From:To:Cc:Subject:Date:From;
 b=VoCJ+8F5LZxqXTwemiuJezLBSXxVjjjVBzlGmOZHz+3UVbRco6xiC4htqskoR4kii
 or/MWHeD1eprSt+aWI6dwJ/e0nSZitYo5yd5vcYL3ptNzbMI9WFZrEO3ps4VhNZGSV
 7o4yDfF1tvtQQYfm31EbZ0Vbh5IezZ2XwgIqJSA0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=VoCJ+8F5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

please pull these sunxi changes into main:

Beside a fix for a long standing bug in the A80 eMMC code, this adds
SPI booting support for the Allwinner A523/A527/T527 class of boards.
The second major feature is support for the secondary Ethernet controller
on that same SoC. This might not be as important as for the kernel (I
doubt that U-Boot acts as a router), but for once some boards only connect
the secondary EMAC, and on others people might have the boot server only
reachable via this port.
There are some smaller fixes and improvements still queued up, but they
need some more testing and are minor, so can land a bit later.

The world build timed out, but the rest passed, and I booted that briefly
on an A523 board with two Ethernet ports.

Thanks,
Andre
===========================================================
The following changes since commit b635d43bca429500cb8ef20aa151cb5773b9a8a5:

  Merge patch series "fs/squashfs: fix symlink load failure on large images" (2026-07-25 07:55:35 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sunxi.git main

for you to fetch changes up to 59edf9a3427c13f05d450fe84f42ef00dc7096c9:

  configs: radxa-cubie-a5e: enable the gmac1 controller (2026-07-27 01:18:35 +0200)

----------------------------------------------------------------
Andre Przywara (5):
      spi: sunxi: add support for A523 SPI controller
      sunxi: spl: spi: Clean up SPI0 pinmux setting
      sunxi: spl: spi: Add support for Allwinner A523
      sunxi: configs: Radxa Cubie A5E: enable SPI
      sunxi: configs: OrangePi 4A: enable SPI

Junhui Liu (5):
      pinctrl: sunxi: a523: add gmac1 support
      clk: sunxi: a523: add MBUS_EMAC1 clock gate
      arm: mach-sunxi: add syscon driver for system-control nodes
      net: dwc_eth_qos: add support for sun55i platform
      configs: radxa-cubie-a5e: enable the gmac1 controller

Omar Ivan Fardjoume (1):
      mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()

 arch/arm/mach-sunxi/Kconfig           |   7 +
 arch/arm/mach-sunxi/Makefile          |   1 +
 arch/arm/mach-sunxi/spl_spi_sunxi.c   |  48 +++----
 arch/arm/mach-sunxi/syscon.c          |  28 ++++
 configs/orangepi_4a_defconfig         |   4 +
 configs/radxa-cubie-a5e_defconfig     |   9 ++
 drivers/clk/sunxi/clk_a523.c          |   1 +
 drivers/mmc/sunxi_mmc.c               |   6 +-
 drivers/net/Kconfig                   |   9 ++
 drivers/net/Makefile                  |   1 +
 drivers/net/dwc_eth_qos.c             |   6 +
 drivers/net/dwc_eth_qos.h             |   1 +
 drivers/net/dwc_eth_qos_sunxi.c       | 254 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |   3 +-
 drivers/spi/spi-sunxi.c               |   4 +
 15 files changed, 352 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/syscon.c
 create mode 100644 drivers/net/dwc_eth_qos_sunxi.c
