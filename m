Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A9C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB8C887EB;
	Fri, 12 Jul 2024 18:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA488887F5; Fri, 12 Jul 2024 18:54:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8C275887CF
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0A61042;
 Fri, 12 Jul 2024 09:54:25 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D14E3F766;
 Fri, 12 Jul 2024 09:53:58 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Philippe Simons <simons.philippe@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/6] power: regulator: add AXP717 support
Date: Fri, 12 Jul 2024 17:53:47 +0100
Message-Id: <20240712165352.3767166-2-andre.przywara@arm.com>
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

The X-Powers AXP717 is a PMIC with four buck converters and a number
of LDOs, one of which is actually fixed (so not modelled here).

Add the compatible string and the respective regulator ranges to allow
drivers to adjust voltages.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Ryan Walklin <ryan@testtoast.com>
---
 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/axp_regulator.c | 28 +++++++++++++++++++++++++
 include/axp_pmic.h                      |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 0e1e45fba74..521a39dd566 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -88,6 +88,7 @@ static const struct udevice_id axp_pmic_ids[] = {
 	{ .compatible = "x-powers,axp221", .data = AXP221_ID },
 	{ .compatible = "x-powers,axp223", .data = AXP223_ID },
 	{ .compatible = "x-powers,axp313a", .data = AXP313_ID },
+	{ .compatible = "x-powers,axp717", .data = AXP717_ID },
 	{ .compatible = "x-powers,axp803", .data = AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = AXP809_ID },
diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index d27e09538e0..75cdbca30f6 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -189,6 +189,33 @@ static const struct axp_regulator_plat axp313_regulators[] = {
 	{ }
 };
 
+/*
+ * The "dcdc2" regulator has another range, beyond 1.54V up to 3.4V, in
+ * steps of 100mV. We cannot model this easily, but also don't need that,
+ * since it's typically only used for lower voltages anyway, so just ignore it.
+ */
+static const struct axp_regulator_plat axp717_regulators[] = {
+	{ "dcdc1", 0x80, BIT(0), 0x83, 0x7f,  500, 1540,  10, 70 },
+	{ "dcdc2", 0x80, BIT(1), 0x84, 0x7f,  500, 1540,  10, 70 },
+	{ "dcdc3", 0x80, BIT(2), 0x85, 0x7f,  500, 1840,  10, 70 },
+	{ "dcdc4", 0x80, BIT(3), 0x86, 0x7f, 1000, 3700, 100, NA },
+	{ "aldo1", 0x90, BIT(0), 0x93, 0x1f,  500, 3500, 100, NA },
+	{ "aldo2", 0x90, BIT(1), 0x94, 0x1f,  500, 3500, 100, NA },
+	{ "aldo3", 0x90, BIT(2), 0x95, 0x1f,  500, 3500, 100, NA },
+	{ "aldo4", 0x90, BIT(3), 0x96, 0x1f,  500, 3500, 100, NA },
+	{ "bldo1", 0x90, BIT(4), 0x97, 0x1f,  500, 3500, 100, NA },
+	{ "bldo2", 0x90, BIT(5), 0x98, 0x1f,  500, 3500, 100, NA },
+	{ "bldo3", 0x90, BIT(6), 0x99, 0x1f,  500, 3500, 100, NA },
+	{ "bldo4", 0x90, BIT(7), 0x9a, 0x1f,  500, 3500, 100, NA },
+	{ "cldo1", 0x91, BIT(0), 0x9b, 0x1f,  500, 3500, 100, NA },
+	{ "cldo2", 0x91, BIT(1), 0x9c, 0x1f,  500, 3500, 100, NA },
+	{ "cldo3", 0x91, BIT(2), 0x9d, 0x1f,  500, 3500, 100, NA },
+	{ "cldo4", 0x91, BIT(3), 0x9e, 0x1f,  500, 3500, 100, NA },
+	{"cpusldo",0x91, BIT(4), 0x9f, 0x1f,  500, 1400,  50, NA },
+	{" boost", 0x19, BIT(4), 0x1e, 0xf0, 4550, 5510,  64, NA },
+	{ }
+};
+
 static const struct axp_regulator_plat axp803_regulators[] = {
 	{ "dcdc1", 0x10, BIT(0), 0x20, 0x1f, 1600, 3400, 100, NA },
 	{ "dcdc2", 0x10, BIT(1), 0x21, 0x7f,  500, 1300,  10, 70 },
@@ -291,6 +318,7 @@ static const struct axp_regulator_plat *const axp_regulators[] = {
 	[AXP221_ID]	= axp22x_regulators,
 	[AXP223_ID]	= axp22x_regulators,
 	[AXP313_ID]	= axp313_regulators,
+	[AXP717_ID]	= axp717_regulators,
 	[AXP803_ID]	= axp803_regulators,
 	[AXP806_ID]	= axp806_regulators,
 	[AXP809_ID]	= axp809_regulators,
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index aabafc8501b..ae62ef0d76d 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -33,6 +33,7 @@ enum {
 	AXP221_ID,
 	AXP223_ID,
 	AXP313_ID,
+	AXP717_ID,
 	AXP803_ID,
 	AXP806_ID,
 	AXP809_ID,
-- 
2.25.1

