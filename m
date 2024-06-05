Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36847C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8088837A;
	Wed,  5 Jun 2024 11:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612AB88370; Wed,  5 Jun 2024 11:33:43 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77561881A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvMj10t4Pzg5S;
 Wed,  5 Jun 2024 11:33:41 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvMj03rZTzPFL; Wed,  5 Jun 2024 11:33:40 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 11:33:21 +0200
Subject: [PATCH 1/3] regulator: rk8xx: fix incorrect device used for
 _ldo_[sg]et_suspend_value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-pmic-rk8xx-v1-1-2349fdf68aa0@cherry.de>
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

_ldo_get_suspend_value and _ldo_set_suspend_value get passed the parent
of the regulator (so the pmic) as first argument, therefore this udevice
should be used for pmic_* callbacks instead of using the parent of the
pmic.

To avoid further confusion, let's rename the argument to pmic instead of
dev, highlighting which kind of device we expect as argument.

Fixes: f047e4ab9762 ("regulator: rk8xx: add indirection level for some ldo callbacks")
Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/regulator/rk8xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 1bd4605d43a..cce3502f89c 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -1216,7 +1216,7 @@ static int pldo_set_value(struct udevice *dev, int uvolt)
 	return _ldo_set_value(dev, info, uvolt);
 }
 
-static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
+static int _ldo_set_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)
 {
 	int mask = info->vsel_mask;
 	int val;
@@ -1232,7 +1232,7 @@ static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_in
 	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
 	      __func__, uvolt, info->vsel_sleep_reg, mask, val);
 
-	return pmic_clrsetbits(dev->parent, info->vsel_sleep_reg, mask, val);
+	return pmic_clrsetbits(pmic, info->vsel_sleep_reg, mask, val);
 }
 
 static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
@@ -1259,7 +1259,7 @@ static int pldo_set_suspend_value(struct udevice *dev, int uvolt)
 	return _ldo_set_suspend_value(dev->parent, info, uvolt);
 }
 
-static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info)
+static int _ldo_get_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info)
 {
 	int mask = info->vsel_mask;
 	int val, ret;
@@ -1267,7 +1267,7 @@ static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_in
 	if (info->vsel_sleep_reg == NA)
 		return -ENOSYS;
 
-	ret = pmic_reg_read(dev->parent, info->vsel_sleep_reg);
+	ret = pmic_reg_read(pmic, info->vsel_sleep_reg);
 	if (ret < 0)
 		return ret;
 

-- 
2.45.1

