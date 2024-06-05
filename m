Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7C7C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F7487A9C;
	Wed,  5 Jun 2024 11:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2678837D; Wed,  5 Jun 2024 11:33:44 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FD488365
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvMj16XbPzDBF;
 Wed,  5 Jun 2024 11:33:41 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvMj111flzN7C; Wed,  5 Jun 2024 11:33:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 11:33:22 +0200
Subject: [PATCH 2/3] regulator: rk8xx: pass pmic udevice instead of
 regulator to all internal functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-pmic-rk8xx-v1-2-2349fdf68aa0@cherry.de>
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
In-Reply-To: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

From: Quentin Schulz <quentin.schulz@cherry.de>

For the sake of consistency, make all internal (starting with _)
functions expect a pmic udevice instead of a regulator udevice.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/regulator/rk8xx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index cce3502f89c..bd5a37e718f 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -1134,14 +1134,14 @@ static int buck_get_enable(struct udevice *dev)
 	return _buck_get_enable(dev->parent, buck);
 }
 
-static int _ldo_get_value(struct udevice *dev, const struct rk8xx_reg_info *info)
+static int _ldo_get_value(struct udevice *pmic, const struct rk8xx_reg_info *info)
 {
 	int mask = info->vsel_mask;
 	int ret, val;
 
 	if (info->vsel_reg == NA)
 		return -ENOSYS;
-	ret = pmic_reg_read(dev->parent, info->vsel_reg);
+	ret = pmic_reg_read(pmic, info->vsel_reg);
 	if (ret < 0)
 		return ret;
 	val = ret & mask;
@@ -1154,7 +1154,7 @@ static int ldo_get_value(struct udevice *dev)
 	int ldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
 
-	return _ldo_get_value(dev, info);
+	return _ldo_get_value(dev->parent, info);
 }
 
 static int nldo_get_value(struct udevice *dev)
@@ -1162,7 +1162,7 @@ static int nldo_get_value(struct udevice *dev)
 	int nldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, 0);
 
-	return _ldo_get_value(dev, info);
+	return _ldo_get_value(dev->parent, info);
 }
 
 static int pldo_get_value(struct udevice *dev)
@@ -1170,10 +1170,10 @@ static int pldo_get_value(struct udevice *dev)
 	int pldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, 0);
 
-	return _ldo_get_value(dev, info);
+	return _ldo_get_value(dev->parent, info);
 }
 
-static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
+static int _ldo_set_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)
 {
 	int mask = info->vsel_mask;
 	int val;
@@ -1189,7 +1189,7 @@ static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info
 	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
 	      __func__, uvolt, info->vsel_reg, mask, val);
 
-	return pmic_clrsetbits(dev->parent, info->vsel_reg, mask, val);
+	return pmic_clrsetbits(pmic, info->vsel_reg, mask, val);
 }
 
 static int ldo_set_value(struct udevice *dev, int uvolt)
@@ -1197,7 +1197,7 @@ static int ldo_set_value(struct udevice *dev, int uvolt)
 	int ldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
 
-	return _ldo_set_value(dev, info, uvolt);
+	return _ldo_set_value(dev->parent, info, uvolt);
 }
 
 static int nldo_set_value(struct udevice *dev, int uvolt)
@@ -1205,7 +1205,7 @@ static int nldo_set_value(struct udevice *dev, int uvolt)
 	int nldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, uvolt);
 
-	return _ldo_set_value(dev, info, uvolt);
+	return _ldo_set_value(dev->parent, info, uvolt);
 }
 
 static int pldo_set_value(struct udevice *dev, int uvolt)
@@ -1213,7 +1213,7 @@ static int pldo_set_value(struct udevice *dev, int uvolt)
 	int pldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, uvolt);
 
-	return _ldo_set_value(dev, info, uvolt);
+	return _ldo_set_value(dev->parent, info, uvolt);
 }
 
 static int _ldo_set_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)

-- 
2.45.1

