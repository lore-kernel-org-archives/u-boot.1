Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D558CED247
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 22:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553B688363;
	Tue,  8 Oct 2024 00:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD5788363; Tue,  8 Oct 2024 00:27:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4AB4B87CF8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 00:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F342DA7;
 Mon,  7 Oct 2024 15:27:38 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A821E3F73F;
 Mon,  7 Oct 2024 15:27:07 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@csie.org>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: power: axp809: Fix DCDC4 programming
Date: Mon,  7 Oct 2024 23:26:25 +0100
Message-ID: <20241007222625.18883-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
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

When trying to set the DCDC4 regulator, the code was accidentally
setting the voltage register for DCDC5 (VCC-DRAM). The higher voltage
doesn't harm the DRAM chips, but upsets the Linux regulator driver: when
it tried to correct that, it tripped over a separate DT bug.
The DCDC5 DT limits are 1.425 and 1.575V, which cannot bet set with the
rail's resolution of 50mV. The kernel driver gave up, and made in turn
the system hang, as the PMIC powers essential devices.

Fix the copy&paste bug by using the correct PMIC voltage register.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/axp809.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/axp809.c b/drivers/power/axp809.c
index 9e38e1a7450..ec3eca1ac4b 100644
--- a/drivers/power/axp809.c
+++ b/drivers/power/axp809.c
@@ -93,7 +93,7 @@ int axp_set_dcdc4(unsigned int mvolt)
 		return pmic_bus_clrbits(AXP809_OUTPUT_CTRL1,
 					AXP809_OUTPUT_CTRL1_DCDC4_EN);
 
-	ret = pmic_bus_write(AXP809_DCDC5_CTRL, cfg);
+	ret = pmic_bus_write(AXP809_DCDC4_CTRL, cfg);
 	if (ret)
 		return ret;
 
-- 
2.46.2

