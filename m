Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1231EC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1445487FBE;
	Mon,  4 Mar 2024 12:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE4A87FA6; Mon,  4 Mar 2024 12:30:42 +0100 (CET)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::1908])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C91187F83
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhp33JtzMw8HD;
 Mon,  4 Mar 2024 12:30:34 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhn6GJjzrbQ; Mon,  4 Mar 2024 12:30:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:29:58 +0100
Subject: [PATCH v3 04/16] regulator: rk8xx: add indirection level for some
 ldo callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-4-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
In-Reply-To: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

By passing a rk8xx_reg_info directly to the internal get_value, it'd be
possible to call this same function with a logic for getting the
rk8xx_reg_info different from the current get_ldo_reg, e.g. for NLDO and
PLDO support for RK806.

No logic change is expected.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/power/regulator/rk8xx.c | 48 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index e905df3a800..212bb752a76 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -780,10 +780,8 @@ static int buck_get_enable(struct udevice *dev)
 	return _buck_get_enable(dev->parent, buck);
 }
 
-static int ldo_get_value(struct udevice *dev)
+static int _ldo_get_value(struct udevice *dev, const struct rk8xx_reg_info *info)
 {
-	int ldo = dev->driver_data - 1;
-	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
 	int mask = info->vsel_mask;
 	int ret, val;
 
@@ -797,10 +795,16 @@ static int ldo_get_value(struct udevice *dev)
 	return info->min_uv + val * info->step_uv;
 }
 
-static int ldo_set_value(struct udevice *dev, int uvolt)
+static int ldo_get_value(struct udevice *dev)
 {
 	int ldo = dev->driver_data - 1;
-	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
+	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
+
+	return _ldo_get_value(dev, info);
+}
+
+static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
+{
 	int mask = info->vsel_mask;
 	int val;
 
@@ -812,16 +816,22 @@ static int ldo_set_value(struct udevice *dev, int uvolt)
 	else
 		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
 
-	debug("%s: volt=%d, ldo=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
-	      __func__, uvolt, ldo + 1, info->vsel_reg, mask, val);
+	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
+	      __func__, uvolt, info->vsel_reg, mask, val);
 
 	return pmic_clrsetbits(dev->parent, info->vsel_reg, mask, val);
 }
 
-static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
+static int ldo_set_value(struct udevice *dev, int uvolt)
 {
 	int ldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
+
+	return _ldo_set_value(dev, info, uvolt);
+}
+
+static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
+{
 	int mask = info->vsel_mask;
 	int val;
 
@@ -833,16 +843,22 @@ static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
 	else
 		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
 
-	debug("%s: volt=%d, ldo=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
-	      __func__, uvolt, ldo + 1, info->vsel_sleep_reg, mask, val);
+	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
+	      __func__, uvolt, info->vsel_sleep_reg, mask, val);
 
 	return pmic_clrsetbits(dev->parent, info->vsel_sleep_reg, mask, val);
 }
 
-static int ldo_get_suspend_value(struct udevice *dev)
+static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
 {
 	int ldo = dev->driver_data - 1;
-	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
+	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
+
+	return _ldo_set_suspend_value(dev->parent, info, uvolt);
+}
+
+static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info)
+{
 	int mask = info->vsel_mask;
 	int val, ret;
 
@@ -858,6 +874,14 @@ static int ldo_get_suspend_value(struct udevice *dev)
 	return info->min_uv + val * info->step_uv;
 }
 
+static int ldo_get_suspend_value(struct udevice *dev)
+{
+	int ldo = dev->driver_data - 1;
+	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
+
+	return _ldo_get_suspend_value(dev->parent, info);
+}
+
 static int ldo_set_enable(struct udevice *dev, bool enable)
 {
 	int ldo = dev->driver_data - 1;

-- 
2.44.0

