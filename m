Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD54FCD1280
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10609880E8;
	Wed, 27 Mar 2024 17:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o2FNhSRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C669988132; Wed, 27 Mar 2024 17:24:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8214288132
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 74495CE1C9C;
 Wed, 27 Mar 2024 16:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD85C433F1;
 Wed, 27 Mar 2024 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556655;
 bh=ojUhW4tLr47m2OPCAFw+Uurbl1jo6XQqk40LUj01CuU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o2FNhSRPIbTnDYhtctwojvKXb+7GvMur6agus2ASQ/GmvT01KS60b1/s//WMYQHMy
 YLIfgXtc7Bm8eI1rffHHl6uAR53uD3KeMG2Cef6RTbPcIQ2Ijx8xoKJkzd0rh0POk9
 QdWwFCCELN/X+x0Td86WSNtVbPQcErla3/wD8vIZkA/yp5G9dfHlPTfm1IayZNaQeg
 vLhAQ45jSp5CwB1JiN0jA7B1AZUZ3iZ5iw/m9wQQi+QXe/iA5XYsZrzDTZUwqhVNK9
 MVmgnX9jIFDGIkoDhvnOoUsPbF4NAIZJAZng3ZUh3dl2+qjQieXxPDnShAPR91m66Z
 Loub0BdZTcwBA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 13/18] gpio: turris_omnia_mcu: Update firmware
 features reading
Date: Wed, 27 Mar 2024 17:23:50 +0100
Message-ID: <20240327162355.24584-14-kabel@kernel.org>
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

Update firmware features reading to try reading 32 bits of features and
fallback to reading 16 bits.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/gpio/turris_omnia_mcu.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/gpio/turris_omnia_mcu.c
index c441d07d69..40ced261e3 100644
--- a/drivers/gpio/turris_omnia_mcu.c
+++ b/drivers/gpio/turris_omnia_mcu.c
@@ -10,7 +10,7 @@
 #include <linux/log2.h>
 
 struct turris_omnia_mcu_info {
-	u16 features;
+	u32 features;
 };
 
 static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
@@ -228,25 +228,37 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
 {
 	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	u16 val;
+	u32 dword;
+	u16 word;
 	int ret;
 
-	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val, sizeof(val));
+	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&word, sizeof(word));
 	if (ret < 0) {
 		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n",
 		       ret);
 		return ret;
 	}
 
-	if (le16_to_cpu(val) & STS_FEATURES_SUPPORTED) {
-		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&val,
-				  sizeof(val));
+	if (le16_to_cpu(word) & STS_FEATURES_SUPPORTED) {
+		/* try read 32-bit features */
+		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&dword,
+				  sizeof(dword));
 		if (ret < 0) {
-			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
-			       ret);
-			return ret;
+			/* try read 16-bit features */
+			ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&word,
+					  sizeof(word));
+			if (ret < 0) {
+				printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
+				       ret);
+				return ret;
+			}
+
+			info->features = le16_to_cpu(word);
+		} else {
+			info->features = le32_to_cpu(dword);
+			if (info->features & FEAT_FROM_BIT_16_INVALID)
+				info->features &= GENMASK(15, 0);
 		}
-		info->features = le16_to_cpu(val);
 	}
 
 	uc_priv->bank_name = "mcu_";
-- 
2.43.2

