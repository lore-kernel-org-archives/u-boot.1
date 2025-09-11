Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE48CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0862383564;
	Thu, 11 Sep 2025 15:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eWQijoFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACFA83526; Thu, 11 Sep 2025 15:14:41 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7C18334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEcj9808428;
 Thu, 11 Sep 2025 08:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596478;
 bh=XJAjOy96kgOeKxc8MDpMeeiJy4GnUQ1hUtzb1w6XBIQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eWQijoFU4nE9XQqo/A73aOm7fcknTCIZmpOIys2VpE7TiXGWL9nHzQOEbCBpFbuwk
 6fkN6UbQS/PPQWfwVZsKvQwibjmwRNx2+DSykAwxIyMuCHNCMDQm1j/Qo1ceqr7eXH
 pRVgoQYJt87vOUS+VoVJ+758na7orBQn7W61evFU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEcKV1179218
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:38 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:37 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEaNV1873170;
 Thu, 11 Sep 2025 08:14:37 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 10/17] spl: spi: refactor spl_spi_load_image for falcon
 mode
Date: Thu, 11 Sep 2025 18:44:06 +0530
Message-ID: <20250911131414.3296697-11-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911131414.3296697-1-anshuld@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch moves the falcon mode handling logic out of
spl_spi_load_image to spl_spi_load_image_os, this allows for cleaner
handling for fallback to U-Boot in case falcon mode fails.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_spi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index c2b188371c2..2a6098a4dc3 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -49,6 +49,25 @@ u32 __weak spl_spi_boot_cs(void)
 	return CONFIG_SF_DEFAULT_CS;
 }
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+static int spl_spi_load_image_os(struct spl_image_info *spl_image,
+				 struct spl_boot_device *bootdev,
+				 struct spi_flash *flash,
+				 struct spl_load_info *load)
+{
+	int err = spl_load(spl_image, bootdev, load, 0,
+			   CONFIG_SYS_SPI_KERNEL_OFFS);
+
+	if (err)
+		return err;
+
+	/* Read device tree. */
+	return spi_flash_read(flash, CONFIG_SYS_SPI_ARGS_OFFS,
+			      CONFIG_SYS_SPI_ARGS_SIZE,
+			      (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
+}
+#endif
+
 /*
  * The main entry for SPI booting. It's necessary that SDRAM is already
  * configured and available since this code loads the main U-Boot image
@@ -81,15 +100,13 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (!spl_start_uboot()) {
-		int err = spl_load(spl_image, bootdev, &load, 0,
-				   CONFIG_SYS_SPI_KERNEL_OFFS);
+		err = spl_spi_load_image_os(spl_image, bootdev, flash, &load);
 
 		if (!err)
-			/* Read device tree. */
-			return spi_flash_read(
-				flash, CONFIG_SYS_SPI_ARGS_OFFS,
-				CONFIG_SYS_SPI_ARGS_SIZE,
-				(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
+			return 0;
+
+		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
+		       __func__, err);
 	}
 #endif
 
-- 
2.51.0

