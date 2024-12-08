Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0320CE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E85489525;
	Sun,  8 Dec 2024 23:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QlGkMeTm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iZOmrOFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E62893B4; Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773DE893B4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y5zbh1qMGz9sGk;
 Sun,  8 Dec 2024 23:06:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mas94i7fU4FTbbNBD9E/ebROmpF19+NZdgkjAR11HlE=;
 b=QlGkMeTmiIhnCbUp8VMkQmj1WdHnwXze5KgmcvSdMT43MLzwgGt1gRoK1M2hhClfnLsKM1
 g6wgBJi0lElLJBcWzRz0BOlA24KVT0xq8vtUFez8DHNDwjMzY4AJ7UD6UeLgtka/r8D+SU
 ZGNnhT3ktQ/Gm9uw1/jtypI9//0AXIgLLLMBXvpFCZ5TjG6sH/3makz27DrczevoNx3BNy
 I487m3ZvBLlFDLgrjK36RTBJlRu8bRJIgoAg9XENSDemfWgz7ZZmKFvE4ZrauLotcc1Az3
 iSgdHyAeNeJNvVOFHVxYeLx9eSq3HtHnN8riLnAXsQMZGFdYhpFOOjFl4aoz1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mas94i7fU4FTbbNBD9E/ebROmpF19+NZdgkjAR11HlE=;
 b=iZOmrOFO3xb3WCl6R0ussuW/mIF+avAbhN4C0eusQQxzPxumn21xM/YJj8Lk2v5pUdmAdR
 Bgc/EMlwbIq5NIjPPa0nFNJZdI2sTyC2DV1DNmxyyJfMbWCeyPIFbp5S+adZuQJ5uCN7gh
 Kb92Nl2pD72JZ7cH8P3HhJfYCOqnY4odXazQis+e+C/l6FbDSQRsaeLmKSlf5cvar+H88s
 9ryWluPtAzUZq3xBX0A0BdtcOBjiKbxeWii1zsV/oz3AWj5TdKCbuqthN+v5l0zwcElFPq
 UHapDpQHlbO/tdO3x0eT9+Xh9uMQUh/HRz8g3aNx6JWKY6k79j7nLk/0qQ26jQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] i2c: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:58 +0100
Message-ID: <20241208220551.204743-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f8hxsdxu5s1em9w1w86agapwnciepxto
X-MBO-RS-ID: 42883f520c445a541ea
X-Rspamd-Queue-Id: 4Y5zbh1qMGz9sGk
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/i2c/Kconfig    | 8 ++++----
 drivers/i2c/rcar_iic.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 52067fa7c1f..cdae6825736 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -504,16 +504,16 @@ config SYS_I2C_OMAP24XX
 	  Add support for the OMAP2+ I2C driver.
 
 config SYS_I2C_RCAR_I2C
-	bool "Renesas RCar I2C driver"
+	bool "Renesas R-Car I2C driver"
 	depends on (RCAR_GEN2 || RCAR_64) && DM_I2C
 	help
-	  Support for Renesas RCar I2C controller.
+	  Support for Renesas R-Car I2C controller.
 
 config SYS_I2C_RCAR_IIC
-	bool "Renesas RCar Gen3 IIC driver"
+	bool "Renesas R-Car Gen3 IIC driver"
 	depends on (RCAR_GEN2 || RCAR_GEN3) && DM_I2C
 	help
-	  Support for Renesas RCar Gen3 IIC controller.
+	  Support for Renesas R-Car Gen3 IIC controller.
 
 config SYS_I2C_ROCKCHIP
 	bool "Rockchip I2C driver"
diff --git a/drivers/i2c/rcar_iic.c b/drivers/i2c/rcar_iic.c
index 2aa0f5fbfae..e019d06be41 100644
--- a/drivers/i2c/rcar_iic.c
+++ b/drivers/i2c/rcar_iic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar IIC driver
+ * Renesas R-Car IIC driver
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  *
-- 
2.45.2

