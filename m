Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F6CCFA466
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDD1892F5;
	Wed, 23 Oct 2024 22:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DD5892F0; Wed, 23 Oct 2024 22:29:19 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1251888B4B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 22:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1t3hya-001CNZ-Jh;
 Wed, 23 Oct 2024 20:29:04 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/4] i2c: mxc_i2c: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:54 -0700
Message-Id: <20241023202855.1571188-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023202855.1571188-1-tharvey@gateworks.com>
References: <20241023202855.1571188-1-tharvey@gateworks.com>
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

Convert to using livetree API functions.

Without this if livetree is enabled (OF_LIVE) the mxc-i2c
driver will fail to support scl-gpios and sda-gpios for
i2c bus recovery.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/i2c/mxc_i2c.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 2f3cb5908c91..2dfc1c4eab5d 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -29,7 +29,6 @@
 #include <watchdog.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
-#include <fdtdec.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -867,8 +866,7 @@ static int mxc_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
 static int mxc_i2c_probe(struct udevice *bus)
 {
 	struct mxc_i2c_bus *i2c_bus = dev_get_priv(bus);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(bus);
+	ofnode node = dev_ofnode(bus);
 	fdt_addr_t addr;
 	int ret, ret2;
 
@@ -912,17 +910,15 @@ static int mxc_i2c_probe(struct udevice *bus)
 	 * See Documentation/devicetree/bindings/i2c/i2c-imx.txt
 	 * Use gpio to force bus idle when necessary.
 	 */
-	ret = fdt_stringlist_search(fdt, node, "pinctrl-names", "gpio");
+	ret = ofnode_stringlist_search(node, "pinctrl-names", "gpio");
 	if (ret < 0) {
 		debug("i2c bus %d at 0x%2lx, no gpio pinctrl state.\n",
 		      dev_seq(bus), i2c_bus->base);
 	} else {
-		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
-				"scl-gpios", 0, &i2c_bus->scl_gpio,
-				GPIOD_IS_OUT);
-		ret2 = gpio_request_by_name_nodev(offset_to_ofnode(node),
-				"sda-gpios", 0, &i2c_bus->sda_gpio,
-				GPIOD_IS_OUT);
+		ret = gpio_request_by_name(bus, "scl-gpios", 0, &i2c_bus->scl_gpio,
+					   GPIOD_IS_OUT);
+		ret2 = gpio_request_by_name(bus, "sda-gpios", 0, &i2c_bus->sda_gpio,
+					    GPIOD_IS_OUT);
 		if (!dm_gpio_is_valid(&i2c_bus->sda_gpio) ||
 		    !dm_gpio_is_valid(&i2c_bus->scl_gpio) ||
 		    ret || ret2) {
-- 
2.25.1

