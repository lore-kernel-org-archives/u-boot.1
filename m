Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB19CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82AD7883FA;
	Thu,  4 Apr 2024 09:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KtXGtvCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496DD883B6; Thu,  4 Apr 2024 09:51:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7D5883E3
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D9509615B8;
 Thu,  4 Apr 2024 07:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA00C433F1;
 Thu,  4 Apr 2024 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217086;
 bh=O6qS1auojZ/EDhxyPXBkS+KLo4FWEEF2dnCtWhX0Hdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KtXGtvCuyh23As+fJ8+AxZymuwc61xzbR4ylKaXJkgauz0KnUJX5J86wF3AouePjH
 KcP0cYkG5pOY2iCHV1gQTWapFLaUAuL0yzq7M93wx28CStzFJa2HuR9dccjrrjYZqi
 I7iTlztHA529BIpmIMThemYUUMS9eR3/rE+eFD3fBbblwGZvpPjfbsmlHPGmNmSLWo
 qskdgq7o6hKSC3mSkuphThIy7qMDjyJwzRuz2c6rEcesDZxkVw4wwU3/vMgnerocRx
 o23Sb67687S04yr456CkgI39WNH2n9khslf1iTZ2DJfYlYVnhYTQxqljooBNi9OazQ
 nSSjfNYbNSyjA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 12/18] gpio: turris_omnia_mcu: Use byteorder
 conversion functions
Date: Thu,  4 Apr 2024 09:51:01 +0200
Message-ID: <20240404075107.19636-13-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
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
Reviewed-by: Stefan Roese <sr@denx.de>
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

