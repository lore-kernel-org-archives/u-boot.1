Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913ACC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10EB87D2D;
	Sat, 23 Mar 2024 19:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+S9Tdqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C005387FFF; Sat, 23 Mar 2024 19:07:41 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC25087DCC
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4996CCE094C;
 Sat, 23 Mar 2024 18:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABC9C433C7;
 Sat, 23 Mar 2024 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217252;
 bh=ojUhW4tLr47m2OPCAFw+Uurbl1jo6XQqk40LUj01CuU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O+S9Tdqoelp8ZUziE0ED7lBRKc2RPqugwgakK/W0nDKz7AasieKCjmLUQDUm6tabZ
 vXvPiUdwI6iW0nEmm/sfqRiIJKtYMLyUORVgk3hsXA/2LSWoQKO6H493Y0RhQHPzfn
 n9rf+tPRDnRRhCO9R9y+dj1FJ/NPfSBFKrIpQoAzcNvuofsetl39DqkTggmSarNlvg
 4u5+v+V4nl3kpGi6xPnKW1yGECBJlinNrB+DOW7FRH8rbhNZkboa6fH8Dei3Ot4nzv
 ioF/ZdZJbfPpVrHWmN3YQ2omHt2hxB+d+sH+W+WJyoZ5lipqxpJROIH/hm0ji85Ci2
 X+Um/0FEcwZ8Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 13/18] gpio: turris_omnia_mcu: Update firmware
 features reading
Date: Sat, 23 Mar 2024 19:07:06 +0100
Message-ID: <20240323180711.5498-14-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
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

