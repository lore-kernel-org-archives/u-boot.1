Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875A7C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 12:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0895D8006D;
	Fri, 16 May 2025 14:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/zUqYtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB0780107; Fri, 16 May 2025 14:50:59 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F79080050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 14:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-54c0fa6d455so2381967e87.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747399856; x=1748004656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u4F9Iw8ZJWI2gVEHxZNJAtuUV+SXkl8TRQQr7/yw5zE=;
 b=L/zUqYtWW+5V3grtMXT2qzccfP6OHC3JmnGR1vOyfLvDr/f+3l9NeSlxCnVydx6GTE
 tjjWDK3WbNEI82ZNSKuVes7oF4OlZ7kcpixZvyMWEty9FtfrBYU6aHQyCoWe2M6521Ww
 Fi5YxcVQ7moHmL0rBsGu1QdQyv8qmGvVRDd+i9ZgyEMM+Fe1lu3bJ2w5x5vU4lDA24Fm
 8KVN8i/zO9X2N2UL7aOPT3CfAfwspUsE9w7gYJFgGpeZ+jJL3+B6cAI9dV+5++OAEuDn
 NFteN67hxkZbUyb7PVbLZdhHo+aTyyJWp2Cmj1tFyE6tsNAMncAyCI1w7FtU7O44Rkdc
 dYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747399856; x=1748004656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4F9Iw8ZJWI2gVEHxZNJAtuUV+SXkl8TRQQr7/yw5zE=;
 b=U1iganVCg0ie/fraQez87s5OOSiHhM8USbu9X3xrK3HNuuDby5hBTmWzb2oBK5G0tL
 PsDftfHhVUongMt534VHLHvdYGJBYoBeRL73zYhFflqiomzlX9WsiejsPC+kvNXqfEQv
 Kdf95O0wd6pSySN3Mgfea1kVlm6phCsoTBYBGp9xMJ2Z2X6S++mVUvgoSaaRWa77SZur
 Idqe0yd1eMXlukPTyjb4Ie1yxC1RzpEWBG9wjPUi3QAJTb0XFD04pyB5l/lZ0hU/R9Yq
 S3DatP2V/iR4lP6HYeSvcsgPAU91Ai/8gNm+gWYCZJoXzjSmKrr50Qcc8q3IaehXNcHG
 lMhQ==
X-Gm-Message-State: AOJu0YyWprhfH0lq4mZNSZ4cz8QhNSfaODXTxQbwj+O3AtbfovqhWgwI
 UOz0GHwK99jtpggCEYr0SmSbpKBW08YSSOws9n1q+sQ3qa8xbNkF6SqG0dIPLpp8
X-Gm-Gg: ASbGnct7mToap6Pxp6HX31XUk9owghRMGQkl8OnQws+vNASu48SPlFTzRzvTzYTSC/q
 QhUBqV2imuPeNZuVX/l7I07q5s4M+m65WyyZzN7t1uxayQD7616z/hcG3GB2N2wlnQD2wD74q2j
 YhOCzccSenpSlDKM/dHMPnGmBKRWFBGEVtnK5dOOi+VWY5NwgO5qPdoz/L3ncDzXd0hXAHk46sD
 BesAzxrplOig/GF5gFijLgRrZPY4iIvINu7hrzT2a5iTQG8uSTjB7LbDkZBdtatDIE6NvstI9hu
 pvFCEGX3AVpVEhghknjZtcqGD6YYsefNpZCmPOJ697UhN22NveBjivdJUyA/eeiu6tTNbY80KAT
 8q7b6uqUUPbHmeh7pnw==
X-Google-Smtp-Source: AGHT+IERDVJ++pFiKOsTiroEnQm82uXaEFLMEg6Rq2uAecnZupdYZ9kDhsCwyeh+oyGNh6JDvOGxEQ==
X-Received: by 2002:a05:6512:6505:b0:550:e648:1822 with SMTP id
 2adb3069b0e04-550e7232577mr930667e87.43.1747399856182; 
 Fri, 16 May 2025 05:50:56 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e6f164c2sm434719e87.13.2025.05.16.05.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 05:50:55 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] drivers: spi: fix deref ater null.might in spi-uclass.c
Date: Fri, 16 May 2025 15:50:53 +0300
Message-Id: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

The static analyzer (Svace) reported 
After having been compared to a NULL value at spi-uclass.c:465,
pointer 'dev' is passed as 1st parameter in call to function 'dev_get_flags' 
at spi-uclass.c:469, where it is dereferenced at device.h:240.

Correct explained:
1. Added dev && !device_active(dev) check before calling device_active()
2. Added explicit if (!dev) check with ret = -ENODEV setting
3. Protected logging in error block with if(dev) check

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 drivers/spi/spi-uclass.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index d6049753740..52b79223f96 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -345,7 +345,7 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
 		return ret;
 	}
 
-	if (!device_active(dev)) {
+	if (dev && !device_active(dev)) {
 		struct spi_slave *slave;
 
 		ret = device_probe(dev);
@@ -355,6 +355,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
 		slave->dev = dev;
 	}
 
+	if (!dev) {
+		ret = -ENODEV;
+		goto err;
+	}
+
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
 
@@ -373,8 +378,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
 	return 0;
 
 err:
-	log_debug("%s: Error path, device '%s'\n", __func__, dev->name);
-
+	if(dev)
+		log_debug("%s: Error path, device '%s'\n", __func__, dev->name);
+	else
+		log_debug("%s: Error path, NULL device\n", __func__);
+	
 	return ret;
 }
 
-- 
2.30.2

