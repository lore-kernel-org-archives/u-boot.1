Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC915C36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DB782AA3;
	Wed,  9 Apr 2025 02:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1B682FD4; Wed,  9 Apr 2025 02:21:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 46FB082AA3
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B0B41C14;
 Tue,  8 Apr 2025 17:21:32 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA32B3F6A8;
 Tue,  8 Apr 2025 17:21:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
 Olliver Schinagl <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>,
 Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Adam Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>,
 Siarhei Siamashka <siarhei.siamashka@gmail.com>,
 VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>,
 Aleksei Mamlin <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michal Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Stefan Roese <sr@denx.de>, Phil Han <pengphei@sina.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Jonas Smedegaard <dr@jones.dk>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/8] power: regulator: Add a driver for the AXP PMIC
 drivevbus
Date: Wed,  9 Apr 2025 01:20:29 +0100
Message-ID: <20250409002036.12212-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250409002036.12212-1-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

AXP PMICs have a pin which can either report the USB VBUS state, or
driving a regulator that supplies USB VBUS. Add a regulator driver for
controlling this pin. The selection between input and output is done via
the x-powers,drive-vbus-en pin on the PMIC (parent) node.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/Kconfig         |  7 +++
 drivers/power/regulator/Makefile        |  1 +
 drivers/power/regulator/axp_drivevbus.c | 57 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/power/regulator/axp_drivevbus.c

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 521a39dd566..c300fd2bbc2 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -51,6 +51,7 @@ static const struct pmic_child_info axp_pmic_child_info[] = {
 	{ "cldo",	"axp_regulator" },
 	{ "dc",		"axp_regulator" },
 	{ "dldo",	"axp_regulator" },
+	{ "drivevbus",	"axp_drivevbus" },
 	{ "eldo",	"axp_regulator" },
 	{ "fldo",	"axp_regulator" },
 	{ "ldo",	"axp_regulator" },
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 8f102a92c23..1f348bb7fd4 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -57,6 +57,13 @@ config SPL_REGULATOR_AXP
 	  Enable support in SPL for the regulators (DCDCs, LDOs) in the
 	  X-Powers AXP152, AXP2xx, and AXP8xx PMICs.
 
+config REGULATOR_AXP_DRIVEVBUS
+	bool "Enable driver for X-Powers AXP PMIC drivevbus"
+	depends on DM_REGULATOR && PMIC_AXP
+	help
+	  Enable support for sensing or driving the USB VBUS on
+	  X-Powers AXP2xx and AXP8xx PMICs.
+
 config REGULATOR_AXP_USB_POWER
 	bool "Enable driver for X-Powers AXP PMIC USB power supply"
 	depends on DM_REGULATOR && PMIC_AXP
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 4382d4b3ab9..7c3f0b02fb4 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(XPL_)DM_REGULATOR) += regulator-uclass.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
 obj-$(CONFIG_$(XPL_)REGULATOR_AXP) += axp_regulator.o
+obj-$(CONFIG_$(XPL_)REGULATOR_AXP_DRIVEVBUS) += axp_drivevbus.o
 obj-$(CONFIG_$(XPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_DA9063) += da9063.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
diff --git a/drivers/power/regulator/axp_drivevbus.c b/drivers/power/regulator/axp_drivevbus.c
new file mode 100644
index 00000000000..c463de8786b
--- /dev/null
+++ b/drivers/power/regulator/axp_drivevbus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define AXP_VBUS_IPSOUT			0x30
+#define AXP_VBUS_IPSOUT_DRIVEBUS		BIT(2)
+#define AXP_MISC_CTRL			0x8f
+#define AXP_MISC_CTRL_N_VBUSEN_FUNC		BIT(4)
+
+static int axp_drivevbus_get_enable(struct udevice *dev)
+{
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, AXP_VBUS_IPSOUT);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & AXP_VBUS_IPSOUT_DRIVEBUS);
+}
+
+static int axp_drivevbus_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(dev->parent, AXP_VBUS_IPSOUT,
+			       AXP_VBUS_IPSOUT_DRIVEBUS,
+			       enable ? AXP_VBUS_IPSOUT_DRIVEBUS : 0);
+}
+
+static const struct dm_regulator_ops axp_drivevbus_ops = {
+	.get_enable		= axp_drivevbus_get_enable,
+	.set_enable		= axp_drivevbus_set_enable,
+};
+
+static int axp_drivevbus_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_plat = dev_get_uclass_plat(dev);
+	int ret;
+
+	uc_plat->type = REGULATOR_TYPE_FIXED;
+
+	if (dev_read_bool(dev->parent, "x-powers,drive-vbus-en")) {
+		ret = pmic_clrsetbits(dev->parent, AXP_MISC_CTRL,
+				      AXP_MISC_CTRL_N_VBUSEN_FUNC, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(axp_drivevbus) = {
+	.name		= "axp_drivevbus",
+	.id		= UCLASS_REGULATOR,
+	.probe		= axp_drivevbus_probe,
+	.ops		= &axp_drivevbus_ops,
+};
-- 
2.46.3

