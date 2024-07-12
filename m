Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62251C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95087887FD;
	Fri, 12 Jul 2024 18:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17017887F5; Fri, 12 Jul 2024 18:54:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 199D9887EB
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C63261477;
 Fri, 12 Jul 2024 09:54:26 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21E983F766;
 Fri, 12 Jul 2024 09:54:00 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Philippe Simons <simons.philippe@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/6] power: pmic: sunxi: only build AXP drivers for SPL
Date: Fri, 12 Jul 2024 17:53:48 +0100
Message-Id: <20240712165352.3767166-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240712165352.3767166-1-andre.przywara@arm.com>
References: <20240712165352.3767166-1-andre.przywara@arm.com>
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

The axp<xxx>.c drivers are only used for the SPL, for U-Boot proper we
have a separate, DM compliant driver.
Mask the build instructions with CONFIG_SPL_BUILD, to avoid them being
build for U-Boot proper as well.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index c7ee4595fc8..0f39459dec4 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(SPL_TPL_)POWER_DOMAIN) += domain/
 obj-y += pmic/
 obj-y += regulator/
 
+ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_AXP152_POWER)	+= axp152.o
 obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
@@ -15,6 +16,7 @@ obj-$(CONFIG_AXP305_POWER)	+= axp305.o
 obj-$(CONFIG_AXP313_POWER)	+= axp313.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
 obj-$(CONFIG_AXP818_POWER)	+= axp818.o
+endif
 obj-$(CONFIG_EXYNOS_TMU)	+= exynos-tmu.o
 obj-$(CONFIG_SY8106A_POWER)	+= sy8106a.o
 obj-$(CONFIG_TPS6586X_POWER)	+= tps6586x.o
-- 
2.25.1

