Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D771CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 08:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A537B830B4;
	Tue,  9 Sep 2025 10:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G4R/cayK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F8583106; Tue,  9 Sep 2025 10:17:40 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB38F80422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 10:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5898HZmE4059922;
 Tue, 9 Sep 2025 03:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757405855;
 bh=KGlmUEgPNELDBUiBPSVg3frNLdjKOOc7iSKNm4Q20vo=;
 h=From:To:CC:Subject:Date;
 b=G4R/cayKajZSbCq72GOyftkxnvnH+dE0Cd9rL6Wj3MdA9pILFRgNip/TU9vkzGkYa
 zlUbUhWmXnFGi3ShDmwhcnkGP6mW0NjMWGa24a0cPeGEVzt1OGPElGffW74EHdXumm
 X+grqM6jhspMuS3bS/ft9IfY1XhaluS3EY34OE/A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5898HZoG211165
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 9 Sep 2025 03:17:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 03:17:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 03:17:34 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5898HX4i2032665;
 Tue, 9 Sep 2025 03:17:34 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH -master v1] spl: spi: fix falcon mode for spi boot
Date: Tue, 9 Sep 2025 13:47:30 +0530
Message-ID: <20250909081731.2625363-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

spl_start_uboot is a board overridable function that switches to falcon
boot mode on return value of 0.

Though for SPI, the falcon boot mode was being enabled on return value
of 1 which is not the correct behaviour. Therefore this patch fixes it
to the expected boot flow.

Fixes: 14509a28aa20 ("spl: spi: Consolidate spi_load_image_os into spl_spi_load_image")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 00dbd3011f0..c2b188371c2 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -80,7 +80,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 	spl_load_init(&load, spl_spi_fit_read, flash, 1);
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
-	if (spl_start_uboot()) {
+	if (!spl_start_uboot()) {
 		int err = spl_load(spl_image, bootdev, &load, 0,
 				   CONFIG_SYS_SPI_KERNEL_OFFS);
 
-- 
2.51.0

