Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0725CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80057838C1;
	Fri, 17 Oct 2025 21:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xfbqE57E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681E683829; Fri, 17 Oct 2025 21:33:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5938283849
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HJXSti2345171;
 Fri, 17 Oct 2025 14:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760729608;
 bh=RF8a6iqxgv94u3hZ96wXumMBf9SiZWj0GDrAo90nIhc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xfbqE57ELa7n9FTgsDh6DTmlacO2fU3/DmSzta8iw149G63wEwVMp5WxRdyspimt9
 uoSYaNXWcep8dFeK2cWg4FR1CBUOZMlrrYs3OBUXKPtOZEfjsHV3MZwz6ojcN/rKVw
 asS8xfHgvsVFNGVWzb5KOlFx6JqfHeEy1Sdq4oEw=
Received: from DFLE208.ent.ti.com (dfle208.ent.ti.com [10.64.6.66])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HJXS4f2644579
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 14:33:28 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 14:33:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 14:33:28 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HJXROF1801627;
 Fri, 17 Oct 2025 14:33:28 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 4/7] spl: spi: refactor spl_spi_load_image for falcon mode
Date: Sat, 18 Oct 2025 01:03:09 +0530
Message-ID: <20251017193318.4124997-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017193318.4124997-1-anshuld@ti.com>
References: <20251017193318.4124997-1-anshuld@ti.com>
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
index c2b188371c2..45718824cbf 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -49,6 +49,25 @@ u32 __weak spl_spi_boot_cs(void)
 	return CONFIG_SF_DEFAULT_CS;
 }
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
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

