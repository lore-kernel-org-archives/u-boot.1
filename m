Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800CC25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C083D8837C;
	Thu, 16 May 2024 01:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633F188286; Thu, 16 May 2024 01:49:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3CE1388350
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F8AD1007;
 Wed, 15 May 2024 16:50:03 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CA183F641;
 Wed, 15 May 2024 16:49:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 6/6] power: pmic: sunxi: add AXP707 support
Date: Thu, 16 May 2024 00:48:39 +0100
Message-Id: <20240515234839.26898-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240515234839.26898-1-andre.przywara@arm.com>
References: <20240515234839.26898-1-andre.przywara@arm.com>
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

The X-Powers AXP707 is a PMIC with some buck converters and a larger
number of LDOs, alongside some charging and USB circuitry.

Add the descriptions for the five DC/DC regulators that we will need,
and enable that when CONFIG_AXP707_POWER is enabled. We won't need DCDC2
till DCDC4, but by using the position in the array for the index we keep
the code cleaner.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/axp_spl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
index e38895c5c7d..8c9698612b5 100644
--- a/drivers/power/axp_spl.c
+++ b/drivers/power/axp_spl.c
@@ -62,6 +62,21 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
 #define AXP_SHUTDOWN_REG	0x32
 #define AXP_SHUTDOWN_MASK	BIT(7)
 
+#elif defined(CONFIG_AXP707_POWER)				/* AXP707 */
+
+static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
+        { 0x10, BIT(0), 0x20, 0x1f, 1600, 3400, 100, NA },
+        { 0x10, BIT(1), 0x21, 0x7f,  500, 1300,  10, 70 },
+        { 0x10, BIT(2), 0x22, 0x7f,  500, 1300,  10, 70 },
+        { 0x10, BIT(3), 0x23, 0x7f,  500, 1300,  10, 70 },
+        { 0x10, BIT(4), 0x24, 0x7f,  800, 1840,  10, 32 },
+};
+#define AXP_CHIP_VERSION	0x3
+#define AXP_CHIP_VERSION_MASK	0xcf
+#define AXP_CHIP_ID		0x81
+#define AXP_SHUTDOWN_REG	0x32
+#define AXP_SHUTDOWN_MASK	BIT(7)
+
 #else
 
 	#error "Please define the regulator registers in axp_spl_regulators[]."
-- 
2.35.8

