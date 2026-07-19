Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BB2C44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 02:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4F5848A1;
	Sun, 19 Jul 2026 04:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866E4849A1; Sun, 19 Jul 2026 04:00:43 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767808467B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGpU-000000001rX-3KYv; Sun, 19 Jul 2026 02:00:32 +0000
Date: Sun, 19 Jul 2026 03:00:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dang Huynh <dang.huynh@mainlining.org>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH 8/9] video: rockchip: rk3568: power the HDMI PHY analog
 supplies
Message-ID: <112ed25a4d143e4f3aee97d5d2cc700c203dc05d.1784424101.git.daniel@makrotopia.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784424101.git.daniel@makrotopia.org>
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

On a cold boot the RK3568 HDMI output stayed dead (no hot-plug detect),
while after a warm reboot from Linux it worked, including graphical UEFI.
The difference was the PHY analog supplies avdd-0v9 and avdd-1v8
(vdda0v9_image and vcca1v8_image on the R5C): Linux enables them and a
warm reset leaves the PMIC LDOs on, but U-Boot left them disabled at
their minimum voltage on cold boot, so the PHY had no analog power and
never asserted HPD.

The driver did call rk_hdmi_probe_regulators() with "avdd-0v9"/"avdd-1v8",
but that resolves regulators by their regulator-name via
regulator_autoset_by_name(), which does not match the vdda0v9_image /
vcca1v8_image names, so the lookup failed and the supplies were never
enabled. regulator_autoset() would not have helped either: it returns
early for regulators that are neither always-on nor boot-on.

Resolve the supplies through the avdd-0v9-supply / avdd-1v8-supply
phandles, set the constrained voltage and enable them, matching the
kernel's dw_hdmi-rockchip behaviour.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/video/rockchip/rk3568_hdmi.c | 29 +++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
index 9b3e54ce6fd..4fd164cd40b 100644
--- a/drivers/video/rockchip/rk3568_hdmi.c
+++ b/drivers/video/rockchip/rk3568_hdmi.c
@@ -12,6 +12,7 @@
 #include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
+#include <power/regulator.h>
 #include "rk_hdmi.h"
 
 /* Default HDMI PHY reference rate to bring HPLL up for hot-plug detect */
@@ -47,11 +48,30 @@ static int rk3568_hdmi_of_to_plat(struct udevice *dev)
 	return rk_hdmi_of_to_plat(dev);
 }
 
-static const char * const rk3568_hdmi_reg_names[] = {
-	"avdd-0v9",
-	"avdd-1v8"
+static const char * const rk3568_hdmi_supplies[] = {
+	"avdd-0v9-supply",
+	"avdd-1v8-supply",
 };
 
+static void rk3568_hdmi_enable_supplies(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *plat;
+	struct udevice *reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rk3568_hdmi_supplies); i++) {
+		if (device_get_supply_regulator(dev, rk3568_hdmi_supplies[i],
+						&reg))
+			continue;
+
+		plat = dev_get_uclass_plat(reg);
+		if (plat->min_uV)
+			regulator_set_value(reg, plat->min_uV);
+
+		regulator_set_enable(reg, true);
+	}
+}
+
 static int rk3568_hdmi_probe(struct udevice *dev)
 {
 	struct rk_hdmi_priv *priv = dev_get_priv(dev);
@@ -59,8 +79,7 @@ static int rk3568_hdmi_probe(struct udevice *dev)
 	struct rk3568_cru *cru = rockchip_get_cru();
 	struct clk ref_clk;
 
-	rk_hdmi_probe_regulators(dev, rk3568_hdmi_reg_names,
-				 ARRAY_SIZE(rk3568_hdmi_reg_names));
+	rk3568_hdmi_enable_supplies(dev);
 
 	/*
 	 * Ungate the HDMI controller clocks. The RK3568 clock driver does
-- 
2.55.0
