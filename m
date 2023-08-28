Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B65C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 18:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4424886479;
	Mon, 28 Aug 2023 20:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WIyp1Tmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ECD86459; Mon, 28 Aug 2023 20:49:14 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229EF8647F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 20:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 67F353F161; 
 Mon, 28 Aug 2023 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693248551;
 bh=Bd86XzcFv6tZ3KniSss20MbNd+Me23WLXm1oBFZXQ0g=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=WIyp1TmomE5/j2u31l/8lgVKpqi1GGyxYs0O3QRX5AENxidcYWtu7hYFeVlcXKCvO
 3lAOr7nAUe1GQI/LDxbVqGDQ4mlB2u+MTvv+oGT1rqjK+ceOUKGzDY5CYUO/y3NHr4
 uhrGRi+qk8/X6ODvn3FzYKLHKyzHP/JcSuMQQRgh+YrEEfWl8cT9dLpU9h9Lbnmqxl
 5L47BU92npxo83fe2QomZqNEgRQKkdj9M2g9fWFtidtGb6NT7RyKu/tf+6aVSxHz7o
 VEc6kFZ1chllPDo+eoSZcp64b/AjEzo4erCabIZf366HWoDbwybRlf5C3SAWYEyox5
 svFSsa+TbSdaQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Vignesh R <vigneshr@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] bootstd: BOOTDEV_SPI_FLASH requires BOOTSTD
Date: Mon, 28 Aug 2023 20:49:59 +0200
Message-Id: <20230828184959.75898-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Compiling sandbox_defconfig with CONFIG_BOOTSTD=n fails:

    /usr/bin/ld: drivers/mtd/spi/sf_bootdev.o:
    in function `sf_get_bootflow':
    /drivers/mtd/spi/sf_bootdev.c:43:(.text+0x96):
    undefined reference to `bootmeth_set_bootflow'

Add the missing Kconfig dependency.

Fixes: Fixes: 0c1f4a9fb13a ("bootstd: Add a SPI flash bootdev")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mtd/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index a9617c6c58..d3b1b21a47 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -82,6 +82,7 @@ if SPI_FLASH
 
 config BOOTDEV_SPI_FLASH
 	bool "SPI Flash bootdev support"
+	depends on BOOTSTD
 	help
 	  Enable a boot device for SPI flash. This allows reading a script
 	  from SPI flash so that it can be used to boot an Operating System.
-- 
2.40.1

