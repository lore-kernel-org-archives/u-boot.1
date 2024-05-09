Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9743BC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 23:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9736C884A3;
	Fri, 10 May 2024 01:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD14884A3; Fri, 10 May 2024 01:44:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 92F8E88194
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 01:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DAF9106F;
 Thu,  9 May 2024 16:44:37 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37D93F6A8;
 Thu,  9 May 2024 16:44:10 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] power: regulator: add AXP717 support
Date: Fri, 10 May 2024 00:43:17 +0100
Message-Id: <20240509234319.13104-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

The X-Powers AXP717 is a PMIC chip, controlled via I2C or RSB. It
features four DC/DC converters and a number of linear regulators.
Also it contains some charger and USB-C detection circuitry, though we
don't use that in U-Boot. The PMIC is used on some newer Allwinner
devices, for instance the Anbernic handheld gaming devices.

Add AXP717 support to the DM driven AXP regulator driver, and also an SPL
version, as we need to program the DRAM voltage rail correctly before
attempting to initialise the DRAM controller.

Cheers,
Ander

Andre Przywara (2):
  power: pmic: sunxi: add AXP717 SPL driver
  power: regulator: add AXP717 support

 arch/arm/mach-sunxi/pmic_bus.c          |  3 +
 board/sunxi/board.c                     |  2 +-
 drivers/power/Kconfig                   | 17 +++--
 drivers/power/Makefile                  |  1 +
 drivers/power/axp717.c                  | 92 +++++++++++++++++++++++++
 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/axp_regulator.c | 28 ++++++++
 include/axp_pmic.h                      |  1 +
 8 files changed, 140 insertions(+), 5 deletions(-)
 create mode 100644 drivers/power/axp717.c

-- 
2.35.8

