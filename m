Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE25C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881E38837D;
	Wed,  5 Jun 2024 11:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2850B88369; Wed,  5 Jun 2024 11:33:45 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA4D87A9C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvMj25t1xzgpK;
 Wed,  5 Jun 2024 11:33:42 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvMj16SHGzPNl; Wed,  5 Jun 2024 11:33:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 11:33:23 +0200
Subject: [PATCH 3/3] regulator: rk8xx: clarify operator precedence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
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

My linter complains that the order isn't clear enough so let's put
parentheses around the ternary condition to make it happy.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/regulator/rk8xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index bd5a37e718f..3125835bc07 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -520,7 +520,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
 	if (ret < 0)
 		return ret;
 
-	return ret & mask ? true : false;
+	return (ret & mask) ? true : false;
 }
 
 static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
@@ -585,7 +585,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 		val = pmic_reg_read(pmic, RK816_REG_DCDC_SLP_EN);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 1 : 0;
+		ret = (val & mask) ? 1 : 0;
 		break;
 	case RK806_ID:
 		{
@@ -608,7 +608,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF1);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 0 : 1;
+		ret = (val & mask) ? 0 : 1;
 		break;
 	case RK809_ID:
 	case RK817_ID:
@@ -620,7 +620,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 		val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
 		if (val < 0)
 			return val;
-		ret = val & mask ? 1 : 0;
+		ret = (val & mask) ? 1 : 0;
 		break;
 	default:
 		ret = -EINVAL;
@@ -723,7 +723,7 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
 	if (ret < 0)
 		return ret;
 
-	return ret & mask ? true : false;
+	return (ret & mask) ? true : false;
 }
 
 static int _nldo_get_enable(struct udevice *pmic, int nldo)
@@ -980,7 +980,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
 		val = pmic_reg_read(pmic, RK816_REG_LDO_SLP_EN);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 1 : 0;
+		ret = (val & mask) ? 1 : 0;
 		break;
 	case RK808_ID:
 	case RK818_ID:
@@ -988,7 +988,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
 		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF2);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 0 : 1;
+		ret = (val & mask) ? 0 : 1;
 		break;
 	case RK809_ID:
 	case RK817_ID:
@@ -997,13 +997,13 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
 			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
 			if (val < 0)
 				return val;
-			ret = val & mask ? 1 : 0;
+			ret = (val & mask) ? 1 : 0;
 		} else {
 			mask = 1 << ldo;
 			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(1));
 			if (val < 0)
 				return val;
-			ret = val & mask ? 1 : 0;
+			ret = (val & mask) ? 1 : 0;
 		}
 		break;
 	}
@@ -1438,7 +1438,7 @@ static int switch_get_enable(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	return ret & mask ? true : false;
+	return (ret & mask) ? true : false;
 }
 
 static int switch_set_suspend_value(struct udevice *dev, int uvolt)
@@ -1493,21 +1493,21 @@ static int switch_get_suspend_enable(struct udevice *dev)
 		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 0 : 1;
+		ret = (val & mask) ? 0 : 1;
 		break;
 	case RK809_ID:
 		mask = 1 << (sw + 6);
 		val = pmic_reg_read(dev->parent, RK817_POWER_SLP_EN(0));
 		if (val < 0)
 			return val;
-		ret = val & mask ? 1 : 0;
+		ret = (val & mask) ? 1 : 0;
 		break;
 	case RK818_ID:
 		mask = 1 << 6;
 		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
 		if (val < 0)
 			return val;
-		ret = val & mask ? 0 : 1;
+		ret = (val & mask) ? 0 : 1;
 		break;
 	}
 

-- 
2.45.1

