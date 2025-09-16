Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1BCCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 10:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6588C8331F;
	Tue, 16 Sep 2025 12:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h72e21Oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED40834D4; Tue, 16 Sep 2025 12:59:16 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421C8832DA
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GAx93q1258839;
 Tue, 16 Sep 2025 05:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758020349;
 bh=XJAjOy96kgOeKxc8MDpMeeiJy4GnUQ1hUtzb1w6XBIQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h72e21Ohh/kEnz1uElpr5MQjGMBLWqiY+ULy0Z4Wy07ZgGKn1nOz6nyZWfVcrOgUt
 cKBgN69nUdpMrRGJvNlyMKx5M01YtqeabG40ebyRmVnzW1rttLOhol4dj2HOrqZbEa
 +CAx5fqDK+u9gmBlgxquZJ7DQs0mgk5VtcQGxog8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GAx9mY471906
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 05:59:09 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 05:59:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 05:59:09 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GAx7Y11203052;
 Tue, 16 Sep 2025 05:59:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 5/8] spl: spi: refactor spl_spi_load_image for falcon mode
Date: Tue, 16 Sep 2025 16:28:53 +0530
Message-ID: <20250916105857.163951-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916105857.163951-1-anshuld@ti.com>
References: <20250916105857.163951-1-anshuld@ti.com>
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

