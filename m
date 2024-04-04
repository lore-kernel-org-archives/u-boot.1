Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4123CCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F137888403;
	Thu,  4 Apr 2024 09:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EEZ6Pq/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40998883FC; Thu,  4 Apr 2024 09:51:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3CE883F5
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 195CE615F6;
 Thu,  4 Apr 2024 07:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01507C433C7;
 Thu,  4 Apr 2024 07:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217087;
 bh=sOi3MV4dAV5CzB9jOKd4R2nIEUDh5LjI39IprZo9C8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EEZ6Pq/36Vc8F3CEI9fcaPdT+NPt86G5lwc94KYuh9Nwc9/u07UpjOY+snqn4NomM
 IMBB3sN1uVoxKBQPOFPinCG/XechkPskRvjtqZ8xDTSw+FHCXR05J86DEkVBHnOkCP
 OdpNYi4YlILLmk/NAxmafiUYCuTqoJDRxzui4HF7+55xB72YvCSpogIB9GjpVbdksv
 07ZMlS8H1ucnYEEKD8y4ct+ydv8xq7L36LE3kMrMWjtd6Rxrt4v/ax70aMD0N+TuWM
 LNpzHx4oZZFopQr7Xkg4Hng4XRNQxL+EXpVDgDdF3hpcYeW1scP6YUizPSpU3I57Uw
 4IHYCbKcvhxTw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 13/18] gpio: turris_omnia_mcu: Update firmware
 features reading
Date: Thu,  4 Apr 2024 09:51:02 +0200
Message-ID: <20240404075107.19636-14-kabel@kernel.org>
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

Update firmware features reading to try reading 32 bits of features and
fallback to reading 16 bits.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
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

