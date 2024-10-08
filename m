Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E88CED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAA088E59;
	Tue,  8 Oct 2024 09:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="ZEv88gdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F86488E52; Tue,  8 Oct 2024 09:54:47 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643B688E25
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so46383045e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374084; x=1728978884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJnSrNQ3rW5vkeStdWmGaraEMl3bJebSl9quF8mmbKk=;
 b=ZEv88gdZB6dSydDpWrP9q341Vnp6PHqsZIG1+LrBknYRVE2XCRJ5Ie1jeD01xZuytY
 3/ACmo690OarIbAOHh833CoYzD/JbJp4CVoFu1yQtBxv5Ji6oA5QckPRPhHpbKcLbSnB
 L9hs6CTJfx0Gn1xX852/Nf0RiXSpP7276tJEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374084; x=1728978884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJnSrNQ3rW5vkeStdWmGaraEMl3bJebSl9quF8mmbKk=;
 b=qBIIYnziY42RTZDTjl0eOWjpqHy6EIm2B9SgKRIuX47l8uQ070b6ONspITAElKvDR6
 8zTPFEa59AamQUU/VfWlPP3Qapo6/j7gPIFbg39K8k7XmPnP9mJFRZHjJ6BV4HugRClL
 eeQ3TTJ1LWhdhQL9PIP2dtHPVMjXu1+ebKVbqEwq8zIjQLlu+NXcsH90r+07TsVHBPw2
 0GF7RSNlsPoF1uj8OhJhXvTOIf0LzIDamt5MKMjDDTjoQIciJEv0daE5tcf2BpkcL13V
 tArYjULY6GQzqCXzLXLpHBm0C32ZoRRsMv4n06P99W9h2cq4/PuC7pf7mkSEiSV7BxP+
 FKFw==
X-Gm-Message-State: AOJu0YwuMEMYBEW8YkoPdJFTjeSbAq/W7pRHWTLO+Fakq8nQMub9Gzha
 xlLlLIAsKZPr6Q5Y0wnbd1u3GDtWVvnmynBxKvn4Adb3xZVTHL0Ge+zlrZzwXs7dHTpb9BiMV+K
 t
X-Google-Smtp-Source: AGHT+IHcz3S/WRUQ93Te1RRxRQzHLWKfQM6Nw+HUsMm4vpMO5xKbh6kI3hxVJx+sMFAjgQKlJaxVHQ==
X-Received: by 2002:a05:600c:4f14:b0:42f:80a7:84e0 with SMTP id
 5b1f17b1804b1-42f85af491fmr87278075e9.32.1728374083729; 
 Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 6/9] net: ksz9477: store ksz bus operations functions
Date: Tue,  8 Oct 2024 09:54:29 +0200
Message-ID: <20241008075435.1572727-7-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008075435.1572727-1-romain.naour@smile.fr>
References: <20241008075435.1572727-1-romain.naour@smile.fr>
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

The ksz9477 Linux kernel driver is based on regmap API to seamlessly
communicate to switch devices connected via different buses like SPI
or I2C. The current regmap implementation in U-Boot only supports
memory-mapped registers access [1].

Until regmap API with bus support is available in U-boot, introduce
struct ksz_phy_ops to store low-level ksz bus operations (I2C for now).

[1] https://lists.denx.de/pipermail/u-boot/2018-May/329392.html

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 92 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index ce9d4b8753f..f24bf9943e7 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -71,15 +71,61 @@
 #define MMD_SETUP(mode, dev)		(((u16)(mode) << PORT_MMD_OP_MODE_S) | (dev))
 #define REG_PORT_PHY_MMD_INDEX_DATA	0x011C
 
+/**
+ * struct ksz_phy_ops - low-level KSZ bus operations
+ */
+struct ksz_phy_ops {
+	/* read() - Read bytes from the device
+	 *
+	 * @udev: bus device
+	 * @reg:  register offset
+	 * @val:  data read
+	 * @len:  Number of bytes to read
+	 *
+	 * @return: 0 on success, negative on failure
+	 */
+	int (*read)(struct udevice *udev, u32 reg, u8 *val, int len);
+
+	/* write() - Write bytes to the device
+	 *
+	 * @udev: bus device
+	 * @reg:  register offset
+	 * @val:  data to write
+	 * @len:  Number of bytes to write
+	 *
+	 * @return: 0 on success, negative on failure
+	 */
+	int (*write)(struct udevice *udev, u32 reg, u8 *val, int len);
+};
+
 struct ksz_dsa_priv {
 	struct udevice *dev;
+	struct ksz_phy_ops *phy_ops;
 
 	u32 features;			/* chip specific features */
 };
 
+static inline int ksz_i2c_read(struct udevice *dev, u32 reg, u8 *val, int len)
+{
+	return dm_i2c_read(dev, reg, val, len);
+}
+
+static inline int ksz_i2c_write(struct udevice *dev, u32 reg, u8 *val, int len)
+{
+	return dm_i2c_write(dev, reg, val, len);
+}
+
+static struct ksz_phy_ops phy_i2c_ops = {
+	.read = ksz_i2c_read,
+	.write = ksz_i2c_write,
+};
+
 static inline int ksz_read8(struct udevice *dev, u32 reg, u8 *val)
 {
-	int ret = dm_i2c_read(dev, reg, val, 1);
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+
+	int ret = phy_ops->read(dev, reg, val, 1);
 
 	dev_dbg(dev, "%s 0x%04x<<0x%02x\n", __func__, reg, *val);
 
@@ -93,8 +139,11 @@ static inline int ksz_pread8(struct udevice *dev, int port, int reg, u8 *val)
 
 static inline int ksz_write8(struct udevice *dev, u32 reg, u8 val)
 {
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+
 	dev_dbg(dev, "%s 0x%04x>>0x%02x\n", __func__, reg, val);
-	return dm_i2c_write(dev, reg, &val, 1);
+	return phy_ops->write(dev, reg, &val, 1);
 }
 
 static inline int ksz_pwrite8(struct udevice *dev, int port, int reg, u8 val)
@@ -104,13 +153,15 @@ static inline int ksz_pwrite8(struct udevice *dev, int port, int reg, u8 val)
 
 static inline int ksz_write16(struct udevice *dev, u32 reg, u16 val)
 {
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[2];
 
 	buf[1] = val & 0xff;
 	buf[0] = val >> 8;
 	dev_dbg(dev, "%s 0x%04x>>0x%04x\n", __func__, reg, val);
 
-	return dm_i2c_write(dev, reg, buf, 2);
+	return phy_ops->write(dev, reg, buf, 2);
 }
 
 static inline int ksz_pwrite16(struct udevice *dev, int port, int reg, u16 val)
@@ -120,10 +171,12 @@ static inline int ksz_pwrite16(struct udevice *dev, int port, int reg, u16 val)
 
 static inline int ksz_read16(struct udevice *dev, u32 reg, u16 *val)
 {
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[2];
 	int ret;
 
-	ret = dm_i2c_read(dev, reg, buf, 2);
+	ret = phy_ops->read(dev, reg, buf, 2);
 	*val = (buf[0] << 8) | buf[1];
 	dev_dbg(dev, "%s 0x%04x<<0x%04x\n", __func__, reg, *val);
 
@@ -137,7 +190,10 @@ static inline int ksz_pread16(struct udevice *dev, int port, int reg, u16 *val)
 
 static inline int ksz_read32(struct udevice *dev, u32 reg, u32 *val)
 {
-	return dm_i2c_read(dev, reg, (u8 *)val, 4);
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+
+	return phy_ops->read(dev, reg, (u8 *)val, 4);
 }
 
 static inline int ksz_pread32(struct udevice *dev, int port, int reg, u32 *val)
@@ -147,6 +203,8 @@ static inline int ksz_pread32(struct udevice *dev, int port, int reg, u32 *val)
 
 static inline int ksz_write32(struct udevice *dev, u32 reg, u32 val)
 {
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[4];
 
 	buf[3] = val & 0xff;
@@ -155,7 +213,7 @@ static inline int ksz_write32(struct udevice *dev, u32 reg, u32 val)
 	buf[0] = (val >> 8) & 0xff;
 	dev_dbg(dev, "%s 0x%04x>>0x%04x\n", __func__, reg, val);
 
-	return dm_i2c_write(dev, reg, buf, 4);
+	return phy_ops->write(dev, reg, buf, 4);
 }
 
 static inline int ksz_pwrite32(struct udevice *dev, int port, int reg, u32 val)
@@ -503,6 +561,21 @@ static int ksz_probe_mdio(struct udevice *dev)
 	return 0;
 }
 
+static void ksz_ops_register(struct udevice *dev, struct ksz_phy_ops *ops)
+{
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+
+	priv->phy_ops = ops;
+}
+
+static bool dsa_ksz_check_ops(struct ksz_phy_ops *phy_ops)
+{
+	if (!phy_ops || !phy_ops->read || !phy_ops->write)
+		return false;
+
+	return true;
+}
+
 /*
  * I2C driver
  */
@@ -518,6 +591,8 @@ static int ksz_i2c_probe(struct udevice *dev)
 	parent_id = device_get_uclass_id(dev_get_parent(dev));
 	switch (parent_id) {
 	case UCLASS_I2C: {
+		ksz_ops_register(dev, &phy_i2c_ops);
+
 		ret = i2c_set_chip_offset_len(dev, 2);
 		if (ret) {
 			printf("i2c_set_chip_offset_len failed: %d\n", ret);
@@ -531,6 +606,11 @@ static int ksz_i2c_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	if (!dsa_ksz_check_ops(priv->phy_ops)) {
+		printf("Driver bug. No bus ops defined\n");
+		return -EINVAL;
+	}
+
 	/* default config */
 	priv->dev = dev;
 
-- 
2.45.0

