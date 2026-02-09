Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B64AE81BA5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1F183C23;
	Mon,  9 Feb 2026 12:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ehBVnBFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E5883C65; Mon,  9 Feb 2026 12:45:27 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BE883BDD
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so642883f8f.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770637525; x=1771242325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDCE6KR162ZXjrSAU0yswGH+OCfz+lnDLNdJungewfQ=;
 b=ehBVnBFnwlr+E8pk394LFyxVf9hFwavSnRCjLB2zIv3Z+MdONiIOPhQN72YwIGSDEs
 qvQxE1V7Z54lVd9XhqDHCpy87/7aNA1ucqgSjuNv8pt+pJYhXLLRvM7YcE0Q59SuZbCB
 C6PdonXGyVrD8ypGNyen0stHw/3h4I+nG/f91M+ZNpllaGoqqzLc2lJxvC2vvBFx0wt9
 zxpM7Y6lzomKN1ZArMHaHCUNPwReyDbBZvWq7b7WMmjOUgtcMf+ZAL1romJZ9CSGJrVA
 QvO1Y3H6YkL02LOcBzrTS09indHapeMVmLsKwmlvSSh/PvKNWFBv9DFHK6Jo2E8wz7Qd
 ONbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770637525; x=1771242325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EDCE6KR162ZXjrSAU0yswGH+OCfz+lnDLNdJungewfQ=;
 b=iYkMEWPiiczhEKhQDe/v/Vzj+y59YChF7E1C9TYRuoEQy+7xSWfneVV2+ju7TOdlXu
 qxqB7DnbpjQRnzGeL/Bx+UbaohXjXi0OGP3svq12mrupHjsvgYFru1seqH0UaU6gDA7c
 UcOBxf8XHJ6a932b38aTJbWOl8YGie1KHMy0RlTZtF1vy14hS56d4i2PLyEyYK4A3TZk
 leJU3+HJ9kgGU+sJgfLwUFIdWdtRX/c63YY0Mjuq5ULI1h2aFgsopiZm5RLat4+tvb9g
 CP8UDau4ifnwxmd1cRPRHc694zewscY7R3qj25E8VTe9rkqpF9Ctuwv04DYYR4HvWNeV
 i+vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC/Fhe2iJepldkODVHw4fCgcn92AYKBHmZ7KGTn5dbiZwOb+GG8Fpx/oKfIkek0e0XT+m1FEo=@lists.denx.de
X-Gm-Message-State: AOJu0YzkkdjV0gGF3IzKZDp8KoO8/GCP7SxJme5Cs2imchszRo6AZvNb
 hGtWxmfuqr63ytCuBqXi6wLVYJdTb7p+aqx2j0FSP3nG4nkQA7te61vt
X-Gm-Gg: AZuq6aI6dZtgZzfehLUqR/Ie3l0S+YUf7cBO90aTOBtJyy3VwrnoaBi28RDRt0cA/BP
 STfdIikg4iNMGAgCfPIhLOf1zpUbF8O1qPGAgKvSoOrSErwhCJHBA3K2t8lOhS861xhOr/f6PJS
 OuuWY+PakMjPSuoGSZIWSAlEYaqv8F+JrQ45Urmpk66bSYIq+tG/TJqTTbH3AxR83gFftYAqnP9
 yq/53uA+t9qXzHTe0dan8pXni3rRlIgQaT8se+7Q1IRj76qVEZQxzuA8jF3SqVFEJ84q2/KGTDo
 wIFHfEr+APoSd+LWfWQGJoZbBCcmowN7BdzU6tmq4EWkaLVynPaZ1v7PLZNSw/mJJdPZjt6yrjO
 m/e+zDdKYzLwtXBy2Ivv5evKTDNQjfdfXVfQ0hM5cqZDLMCAE9BnOc9iyzSwevgMXw2pb2SEhY4
 O5El0e1xvx3mxeHg90WdieK82Mo/3v26Ro7fE20zYSu4c=
X-Received: by 2002:a5d:5f53:0:b0:437:6bcd:77f9 with SMTP id
 ffacd0b85a97d-4376bcd7a3fmr5961546f8f.40.1770637525164; 
 Mon, 09 Feb 2026 03:45:25 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436296b20fasm26297380f8f.6.2026.02.09.03.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 03:45:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] net: mdio-mt7531-mmio: use common header priv struct
Date: Mon,  9 Feb 2026 12:45:05 +0100
Message-ID: <20260209114515.1916-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209114515.1916-1-ansuelsmth@gmail.com>
References: <20260209114515.1916-1-ansuelsmth@gmail.com>
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

Instead of having duplicate priv struct for mdio-mt7531-mmio driver in
both driver and header, use the one exposed by the header directly.

This make sure we have consistent priv struct if the driver will be
updated in the future.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio-mt7531-mmio.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
index 3e325ca58da..58cb6e503b8 100644
--- a/drivers/net/mdio-mt7531-mmio.c
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -6,6 +6,8 @@
 #include <linux/iopoll.h>
 #include <miiphy.h>
 
+#include "mdio-mt7531-mmio.h"
+
 #define MT7531_PHY_IAC			0x701c
 #define   MT7531_PHY_ACS_ST		BIT(31)
 #define   MT7531_MDIO_REG_ADDR_CL22	GENMASK(29, 25)
@@ -25,11 +27,7 @@
 #define MT7531_MDIO_TIMEOUT		100000
 #define MT7531_MDIO_SLEEP		20
 
-struct mt7531_mdio_priv {
-	phys_addr_t switch_regs;
-};
-
-static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv *priv)
+static int mt7531_mdio_wait_busy(struct mt7531_mdio_mmio_priv *priv)
 {
 	unsigned int busy;
 
@@ -38,7 +36,7 @@ static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv *priv)
 					MT7531_MDIO_SLEEP, MT7531_MDIO_TIMEOUT);
 }
 
-static int mt7531_mdio_read(struct mt7531_mdio_priv *priv, int addr, int devad, int reg)
+static int mt7531_mdio_read(struct mt7531_mdio_mmio_priv *priv, int addr, int devad, int reg)
 {
 	u32 val;
 
@@ -75,7 +73,7 @@ static int mt7531_mdio_read(struct mt7531_mdio_priv *priv, int addr, int devad,
 	return val & MT7531_MDIO_RW_DATA;
 }
 
-static int mt7531_mdio_write(struct mt7531_mdio_priv *priv, int addr, int devad,
+static int mt7531_mdio_write(struct mt7531_mdio_mmio_priv *priv, int addr, int devad,
 			     int reg, u16 value)
 {
 	u32 val;
@@ -115,7 +113,7 @@ static int mt7531_mdio_write(struct mt7531_mdio_priv *priv, int addr, int devad,
 
 int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg)
 {
-	struct mt7531_mdio_priv *priv = bus->priv;
+	struct mt7531_mdio_mmio_priv *priv = bus->priv;
 
 	return mt7531_mdio_read(priv, addr, devad, reg);
 }
@@ -123,14 +121,14 @@ int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg)
 int mt7531_mdio_mmio_write(struct mii_dev *bus, int addr, int devad,
 			   int reg, u16 value)
 {
-	struct mt7531_mdio_priv *priv = bus->priv;
+	struct mt7531_mdio_mmio_priv *priv = bus->priv;
 
 	return mt7531_mdio_write(priv, addr, devad, reg, value);
 }
 
 static int dm_mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 
 	return mt7531_mdio_read(priv, addr, devad, reg);
 }
@@ -138,7 +136,7 @@ static int dm_mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg
 static int dm_mt7531_mdio_write(struct udevice *dev, int addr, int devad,
 				int reg, u16 value)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 
 	return mt7531_mdio_write(priv, addr, devad, reg, value);
 }
@@ -150,7 +148,7 @@ static const struct mdio_ops mt7531_mdio_ops = {
 
 static int mt7531_mdio_probe(struct udevice *dev)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 
 	priv->switch_regs = dev_read_addr(dev);
 	if (priv->switch_regs == FDT_ADDR_T_NONE)
@@ -164,5 +162,5 @@ U_BOOT_DRIVER(mt7531_mdio) = {
 	.id             = UCLASS_MDIO,
 	.probe          = mt7531_mdio_probe,
 	.ops            = &mt7531_mdio_ops,
-	.priv_auto	  = sizeof(struct mt7531_mdio_priv),
+	.priv_auto	  = sizeof(struct mt7531_mdio_mmio_priv),
 };
-- 
2.51.0

