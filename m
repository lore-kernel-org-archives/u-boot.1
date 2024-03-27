Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13419C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D058812F;
	Wed, 27 Mar 2024 17:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I1kJlBwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F58B88134; Wed, 27 Mar 2024 17:24:19 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6338811C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 30E3ECE268E;
 Wed, 27 Mar 2024 16:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A33C43394;
 Wed, 27 Mar 2024 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556654;
 bh=gSKVLa76rczKXfKuCUMI6mmchLF5JR5IXd4CSxbd+nU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I1kJlBwuQuGbz46n9Dpgzz7zKePR/QOhr/BHRTS1EfKZkfAKKfDduqVsKslNL0gfD
 NMezlcghp8Yv8oPHfw4FRIUfyMiUQgPneNJSd7LKqLDth+Jqb+XmLuKaLT4RGad0CY
 GVpwtKPCX4l5+GjTCjIFVIgRTSqedS2FFHE7F/ikd27cz1vbUAjKIdaB8YsD3W8tXH
 siJGtRR5eH2gLICaYlGR40nhBf5NMLEs7s0EBzE0aPgx/TpFvPJVcb4Q0Mgo1iyMO9
 aSHT4AzdR40pfLFDbVmZQDLSAVtky46evYaeVYqvmiEWCsnKGCrDhzN0LSUoonIodS
 KSZaxVMB0YxwA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 12/18] gpio: turris_omnia_mcu: Use byteorder
 conversion functions
Date: Wed, 27 Mar 2024 17:23:49 +0100
Message-ID: <20240327162355.24584-13-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use byteorder conversion function instead of manually assembling data
from/to MCU.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/gpio/turris_omnia_mcu.c | 80 +++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/gpio/turris_omnia_mcu.c
index da9a6efe6d..c441d07d69 100644
--- a/drivers/gpio/turris_omnia_mcu.c
+++ b/drivers/gpio/turris_omnia_mcu.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <turris-omnia-mcu-interface.h>
+#include <asm/byteorder.h>
 #include <asm/gpio.h>
 #include <linux/log2.h>
 
@@ -51,27 +52,31 @@ static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
 static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 {
 	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
-	u8 val16[2];
-	u8 val32[4];
+	u32 val32;
+	u16 val16;
 	int ret;
 
 	switch (offset) {
 	/* bank 0 */
 	case 0 ... 15:
-		ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, val16, 2);
+		ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val16,
+				  sizeof(val16));
 		if (ret)
 			return ret;
-		return ((((u16)val16[1] << 8) | val16[0]) >> offset) & 0x1;
+
+		return !!(le16_to_cpu(val16) & BIT(offset));
 
 	/* bank 1 - supported only when FEAT_EXT_CMDS is set */
 	case (16 + 0) ... (16 + 31):
 		if (!(info->features & FEAT_EXT_CMDS))
 			return -EINVAL;
-		ret = dm_i2c_read(dev, CMD_GET_EXT_STATUS_DWORD, val32, 4);
+
+		ret = dm_i2c_read(dev, CMD_GET_EXT_STATUS_DWORD, (void *)&val32,
+				  sizeof(val32));
 		if (ret)
 			return ret;
-		return ((((u32)val32[3] << 24) | ((u32)val32[2] << 16) |
-			 ((u32)val32[1] << 8) | val32[0]) >> (offset - 16)) & 0x1;
+
+		return !!(le32_to_cpu(val32) & BIT(offset - 16));
 
 	/* bank 2 - supported only when FEAT_EXT_CMDS and FEAT_PERIPH_MCU is set */
 	case (16 + 32 + 0) ... (16 + 32 + 15):
@@ -79,10 +84,13 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 			return -EINVAL;
 		if (!(info->features & FEAT_PERIPH_MCU))
 			return -EINVAL;
-		ret = dm_i2c_read(dev, CMD_GET_EXT_CONTROL_STATUS, val16, 2);
+
+		ret = dm_i2c_read(dev, CMD_GET_EXT_CONTROL_STATUS,
+				  (void *)&val16, sizeof(val16));
 		if (ret)
 			return ret;
-		return ((((u16)val16[1] << 8) | val16[0]) >> (offset - 16 - 32)) & 0x1;
+
+		return !!(le16_to_cpu(val16) & BIT(offset - 16 - 32));
 
 	default:
 		return -EINVAL;
@@ -92,30 +100,33 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int value)
 {
 	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
-	u8 val16[2];
-	u8 val32[4];
+	u16 valmask16[2];
+	u8 valmask8[2];
 
 	switch (offset) {
 	/* bank 0 */
 	case 0 ... 15:
 		switch (offset) {
 		case ilog2(STS_USB30_PWRON):
-			val16[1] = CTL_USB30_PWRON;
+			valmask8[1] = CTL_USB30_PWRON;
 			break;
 		case ilog2(STS_USB31_PWRON):
-			val16[1] = CTL_USB31_PWRON;
+			valmask8[1] = CTL_USB31_PWRON;
 			break;
 		case ilog2(STS_ENABLE_4V5):
-			val16[1] = CTL_ENABLE_4V5;
+			valmask8[1] = CTL_ENABLE_4V5;
 			break;
 		case ilog2(STS_BUTTON_MODE):
-			val16[1] = CTL_BUTTON_MODE;
+			valmask8[1] = CTL_BUTTON_MODE;
 			break;
 		default:
 			return -EINVAL;
 		}
-		val16[0] = value ? val16[1] : 0;
-		return dm_i2c_write(dev, CMD_GENERAL_CONTROL, val16, sizeof(val16));
+
+		valmask8[0] = value ? valmask8[1] : 0;
+
+		return dm_i2c_write(dev, CMD_GENERAL_CONTROL, valmask8,
+				    sizeof(valmask8));
 
 	/* bank 2 - supported only when FEAT_EXT_CMDS and FEAT_PERIPH_MCU is set */
 	case (16 + 32 + 0) ... (16 + 32 + 15):
@@ -123,11 +134,12 @@ static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int valu
 			return -EINVAL;
 		if (!(info->features & FEAT_PERIPH_MCU))
 			return -EINVAL;
-		val32[3] = BIT(offset - 16 - 32) >> 8;
-		val32[2] = BIT(offset - 16 - 32) & 0xff;
-		val32[1] = value ? val32[3] : 0;
-		val32[0] = value ? val32[2] : 0;
-		return dm_i2c_write(dev, CMD_EXT_CONTROL, val32, sizeof(val32));
+
+		valmask16[1] = cpu_to_le16(BIT(offset - 16 - 32));
+		valmask16[0] = value ? valmask16[1] : 0;
+
+		return dm_i2c_write(dev, CMD_EXT_CONTROL, (void *)valmask16,
+				    sizeof(valmask16));
 
 	default:
 		return -EINVAL;
@@ -216,25 +228,25 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
 {
 	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	u16 status;
-	u8 val[2];
+	u16 val;
 	int ret;
 
-	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, val, 2);
-	if (ret) {
-		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n", ret);
+	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val, sizeof(val));
+	if (ret < 0) {
+		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n",
+		       ret);
 		return ret;
 	}
 
-	status = ((u16)val[1] << 8) | val[0];
-
-	if (status & STS_FEATURES_SUPPORTED) {
-		ret = dm_i2c_read(dev, CMD_GET_FEATURES, val, 2);
-		if (ret) {
-			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n", ret);
+	if (le16_to_cpu(val) & STS_FEATURES_SUPPORTED) {
+		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&val,
+				  sizeof(val));
+		if (ret < 0) {
+			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
+			       ret);
 			return ret;
 		}
-		info->features = ((u16)val[1] << 8) | val[0];
+		info->features = le16_to_cpu(val);
 	}
 
 	uc_priv->bank_name = "mcu_";
-- 
2.43.2

