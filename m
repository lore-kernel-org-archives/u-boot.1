Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDBCCDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 15:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5AE86FC2;
	Wed, 18 Oct 2023 17:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DB186FC6; Wed, 18 Oct 2023 17:50:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D5A6186FA9
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7892F4;
 Wed, 18 Oct 2023 08:51:01 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DD263F64C;
 Wed, 18 Oct 2023 08:50:18 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 SASANO Takayoshi <uaa@mx5.nisiq.net>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] power: add AXP313 PMIC support
Date: Wed, 18 Oct 2023 16:50:11 +0100
Message-Id: <20231018155014.383566-1-andre.przywara@arm.com>
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

The X-Powers AXP313 is a small PMIC that is controlled via I2C and
provides just three buck converters and three LDOs, plus a power button.
It is used on many newer boards using the Allwinner H616 or H618 SoCs.

Mostly all rails need to be always on, since each of them supplies an
essential part of the system, consequentially the reset default is to have
all of them enabled.
However the voltages need to be adjusted, especially the DRAM rail is
typically at 900mV, for instance, which is too low.

This series adds support for the proper DM AXP PMIC driver (patch 3/3),
but also adds a small driver to be used in (our non-DM) SPL, to adjust
the DRAM voltage before the DRAM initialisation starts (patch 2/3).

This also uses the opportunity to clean up an #ifdef nightmare in our
board.c (patch 1/3), which was actually duplicating some dependencies
already described in Kconfig.

This is one part of the enablement of many newer boards with the
H616/H618 SoC: without the DRAM voltage increased to 1.1V they won't boot.

Cheers,
Andre

Andre Przywara (3):
  sunxi: board: simplify early PMIC setup conditions
  power: pmic: sunxi: add AXP313 SPL driver
  power: regulator: add AXP313 support

 arch/arm/mach-sunxi/pmic_bus.c          |   3 +
 board/sunxi/board.c                     |  35 +++----
 drivers/power/Kconfig                   |  19 +++-
 drivers/power/Makefile                  |   1 +
 drivers/power/axp313.c                  | 134 ++++++++++++++++++++++++
 drivers/power/pmic/axp.c                |   1 +
 drivers/power/regulator/axp_regulator.c |  17 +++
 include/axp_pmic.h                      |   1 +
 8 files changed, 189 insertions(+), 22 deletions(-)
 create mode 100644 drivers/power/axp313.c

-- 
2.25.1

