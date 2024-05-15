Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291DC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1B088315;
	Thu, 16 May 2024 01:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBD988333; Thu, 16 May 2024 01:49:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D676F88286
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83EC5DA7;
 Wed, 15 May 2024 16:49:53 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEEC03F641;
 Wed, 15 May 2024 16:49:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/6] power: pmic: sunxi: consolidate AXP SPL drivers
Date: Thu, 16 May 2024 00:48:33 +0100
Message-Id: <20240515234839.26898-1-andre.przywara@arm.com>
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

Hi,

this is the first series in an attempt to clean up the X-Powers AXP PMIC
drivers used by the SPL for sunxi boards. So far we have a separate
driver file for each AXP variant, but the code was largely the same,
just differing by the regulator ranges.

This adds a new generic driver, which reads the regulator description
from an array of structs. This is similar to how the DM AXP driver used
for U-Boot proper works, but is simplified, since we won't need the full
feature set for the SPL, and we want to keep the code size small.

To help bisect-ability, and to simplify review, each of the simpler AXP
drivers covered by this approach is handled in a separate patch.
We just convert the AXP313, AXP305, AXP717 for now, and on the way add
support for the AXP707, just because it's now very easy, and we will
need it soon enough.
The other AXP SPL drivers are more complex, and support more regulators,
but my hunch is that we really just need the DC/DC converters in the
SPL. However I need to prove and test this, so I will convert the other
AXP chips later.

Please have a look and comment whether the approach in general is a good
idea.

Cheers,
Andre

Andre Przywara (6):
  power: pmic: sunxi: only build AXP drivers for SPL
  power: pmic: sunxi: introduce generic SPL AXP DC/DC driver
  power: pmic: sunxi: replace AXP717 SPL driver
  power: pmic: sunxi: use generic AXP SPL driver for AXP313
  power: pmic: sunxi: use generic AXP SPL driver for AXP305
  power: pmic: sunxi: add AXP707 support

 drivers/power/Makefile  |   8 +-
 drivers/power/axp305.c  |  82 ------------------
 drivers/power/axp313.c  | 133 -----------------------------
 drivers/power/axp717.c  |  92 --------------------
 drivers/power/axp_spl.c | 184 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 310 deletions(-)
 delete mode 100644 drivers/power/axp305.c
 delete mode 100644 drivers/power/axp313.c
 delete mode 100644 drivers/power/axp717.c
 create mode 100644 drivers/power/axp_spl.c

-- 
2.35.8

