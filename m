Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C12E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A5F80269;
	Wed, 11 Dec 2024 08:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bmM5lluq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tY0WB58I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5344B80217; Wed, 11 Dec 2024 08:32:36 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571D48021F
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y7S421V6yz9sv1;
 Wed, 11 Dec 2024 08:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTftEW82t1yXr9x93jrF40N2moe2bM1YVFGKu79Z3O8=;
 b=bmM5lluqZk/1s22MeuvTq3durIbSg7TE3UUi1rReLqIbJWmKMLghtYlIZfH7xy1oS3qLL1
 EBM8get2u8GJOWepplFyL8/B8uw2Lj5FW+X27TkOwpC+Ize7mm77rfbeJpuz1jWXBC6x/5
 NGSHT+88WS9DyxLBRU3239Wuc8bZdfoOTGqClPlMKwWLhI+PX6S/2oe588qhNxOw4759lg
 8wD6w46BVrt99KoICv4yme0FXeKBExsTtx3BERYRHOuKmEPuiGCEnqpf6Mvy3d5bIIssIO
 TxGmoQPfG7igb9d1bgobf8GhIxsYvV48NBVi7UMJwrghcQ5UDTPU+gqcGbez8A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTftEW82t1yXr9x93jrF40N2moe2bM1YVFGKu79Z3O8=;
 b=tY0WB58IhLCycES1bdqLa4Hjkk2/yYZHjuJw6YJqZzwnF+Psr2MCKbN5PI2kL3hMmURt41
 mZcTuAb20lWaEjtBMM9Ip4kPSPv6ZtX+S0WWFHXKlNdEZGiGxrCZmTXNn088lc+SzJBpJ1
 y3h1j9WrFtTac6efU1eJDF5kGEOn/fqnIIqj/smDUkFloW+a5uWljkCgVIojFQWq7RhMPj
 DEE3TZXVWJf8258ilCHgOhsAZUiEg0eJlnKgI0YLU3CxqrCc1+3+jj4YidCPNr2YigpH0E
 5fpWGs0LjfeiuXW+ZCP+O2Ga2SauMQ5740yDgcaFVZ6UoWiMRR2R4HpmVrDFiA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/13] i2c: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:29 +0100
Message-ID: <20241211073210.8087-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c4327190952db490d60
X-MBO-RS-META: xqd66rssbswm6r1q3bna73yb8caxh9k4
X-Rspamd-Queue-Id: 4Y7S421V6yz9sv1
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
V2: No change
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

