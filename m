Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49505CED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A4D88E80;
	Tue,  8 Oct 2024 09:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="kv+nd+Zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC7E889FC; Tue,  8 Oct 2024 09:54:48 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325EA88E07
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so2176525e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374085; x=1728978885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W0JVQSvF+32rigv037d5IEOjDx//m8G9bhFyDuiyv4=;
 b=kv+nd+Zppy4gy3pKfTDo6Q+M+iKfJSwF8kmzriaUXvrLwl8AAmYWYi3veMFS/tXSKK
 TC2H7BarwUcvP4h5QvM5dLXjTl2rVb0rcCX16d1cW04s64E/tWN+D4mr04ps6MR5NyEE
 RX87VwICSkJQsDzTf81/UYH5qaY14wIKynYkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374085; x=1728978885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W0JVQSvF+32rigv037d5IEOjDx//m8G9bhFyDuiyv4=;
 b=ufy0knRfNbNs8i6BKYdTgLX0RXthSfZEVm04j6COWnXHloRmsma9n7O9XnhWxgF/mT
 Itqrtqir61dbFCfGcJE4QbbhFSx4pmjAJTihH3kDQIdZ8hjyfaygMH+lVNYeb9lDqcVd
 Dr0MKVZ/rJnOK3UPtk2wGvND7edhfY2e1btIZo7NuveVkxaeAGbJGAnEHFhgOXO6xJmu
 A6Xzs+HiXmVuCDhCScGi+0sQSToRqkm0S58tNz1FWZHrws30t+In+Rzav4Fwy9QXioHa
 Repekz0iFdsYPrXzxkRJXRTej2iDkHX89rRw9UTyx9W8sZHQZ1FGy1/TYctn2lloN4Kv
 aT2g==
X-Gm-Message-State: AOJu0YwRF88XxEpnmV4g1ZkPxheiQrDX8KM06NnCNtyp8DCFxNVqrirM
 VUC0pdh4CwTVrkGqDKstOuR/HXVcvvwf2HdEZhItEoxOulDzA7qRQdscGSLbHGupDy2AhsgKDrj
 m
X-Google-Smtp-Source: AGHT+IEiE0K22ZVwaLm6DJOnLGbQn/F91+dkm8MPNpUW1OLsjKyT2+pioj67k8pQ0qt3xCn6jIn9DA==
X-Received: by 2002:a05:600c:1e04:b0:42c:df54:18ec with SMTP id
 5b1f17b1804b1-42f85ae90a5mr102894185e9.28.1728374084670; 
 Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 8/9] net: ksz9477: prepare ksz9477 without I2C support
Date: Tue,  8 Oct 2024 09:54:31 +0200
Message-ID: <20241008075435.1572727-9-romain.naour@smile.fr>
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

With the upcoming ksz9477 SPI support added, the I2C support
will be optional. Either the I2C or the SPI bus will be used.

For now, DM_I2C is still mandatory.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 82db533c4ec..1190b591fcb 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -11,7 +11,9 @@
 #include <eth_phy.h>
 #include <linux/delay.h>
 #include <miiphy.h>
-#include <i2c.h>
+#if CONFIG_IS_ENABLED(DM_I2C)
+# include <i2c.h>
+#endif
 #include <net/dsa.h>
 
 #include <asm-generic/gpio.h>
@@ -105,6 +107,7 @@ struct ksz_dsa_priv {
 	u32 features;			/* chip specific features */
 };
 
+#if CONFIG_IS_ENABLED(DM_I2C)
 static inline int ksz_i2c_read(struct udevice *dev, u32 reg, u8 *val, int len)
 {
 	return dm_i2c_read(dev, reg, val, len);
@@ -119,6 +122,7 @@ static struct ksz_phy_ops phy_i2c_ops = {
 	.read = ksz_i2c_read,
 	.write = ksz_i2c_write,
 };
+#endif
 
 static inline int ksz_read8(struct udevice *dev, u32 reg, u8 *val)
 {
@@ -587,6 +591,7 @@ static int ksz_probe(struct udevice *dev)
 
 	parent_id = device_get_uclass_id(dev_get_parent(dev));
 	switch (parent_id) {
+#if CONFIG_IS_ENABLED(DM_I2C)
 	case UCLASS_I2C: {
 		ksz_ops_register(dev, &phy_i2c_ops);
 
@@ -597,6 +602,7 @@ static int ksz_probe(struct udevice *dev)
 		}
 		break;
 	}
+#endif
 	default:
 		dev_err(dev, "invalid parent bus (%s)\n",
 			uclass_get_name(parent_id));
-- 
2.45.0

