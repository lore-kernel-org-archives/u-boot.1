Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A623EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6A780805;
	Tue, 11 Mar 2025 10:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J76B1uwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361CB80F92; Tue, 11 Mar 2025 10:36:06 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F65A807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9ZxnN674124
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Mar 2025 04:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741685759;
 bh=18VffwW93PFbP4ZVZBYsXneRQquHg0gmA1uYKKbXERA=;
 h=From:To:CC:Subject:Date;
 b=J76B1uwhrS2fKoJvH3li2dwcVWhUnOtB6JhKgLpEbsiT5ZA5qhk3UoxaXEyYFKxry
 eACFp3A8XVoP/hk3pxndAXAKF7RPe/IAXmkLuKhyipQKbJf9tQkcrZClJravsF2pOZ
 HN6W/FDkVQ6o8oIZOK7fOi5ziZ87aG5ouFuDxgdU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9ZxwR066805;
 Tue, 11 Mar 2025 04:35:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 04:35:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 04:35:59 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9Zwoh087857;
 Tue, 11 Mar 2025 04:35:59 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3] spl: return header size to spl_load in os boot
Date: Tue, 11 Mar 2025 15:05:45 +0530
Message-ID: <20250311093546.3371193-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
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

During linux build process the header size is computed including the BSS
whereas it's removed when creating the uncompressed image. Therefore the
size of the uncompressed image on filesystem will be smaller than the
size specified in the header.

This causes issues when loading the kernel image from the SPL (as in
falcon boot) with spl_load since it compares the read file size from the
FS to the header size form the image. Which leads to the following check
in `include/spl_load.h` failing to -EIO when loading kernel image:

  return read < spl_image->size ? -EIO : 0;

Therefore we should return the header size back to spl_load instead of
the file size in falcon boot when not loading a FIT image.

Bug report:
https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/

Fixes: 775074165d97 ("spl: Add generic spl_load function")
Reported-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
 * Added header check for FIT image instead of using CMD_BOOTI
v2: https://lore.kernel.org/u-boot/20250225142522.9069-1-anshuld@ti.com/
Changes in v2:
 * Add R-by and fixes tags
 * Expanded commit description with more information
v1: https://lore.kernel.org/u-boot/20250221151752.2618666-1-anshuld@ti.com/
---
 common/spl/spl_ext.c | 8 ++++++++
 common/spl/spl_fat.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index c5478820a9b..7e0274a3058 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -11,12 +11,20 @@
 static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
 {
+	struct legacy_img_hdr *header;
 	int ret;
 	loff_t actlen;
 
 	ret = ext4fs_read(buf, file_offset, size, &actlen);
 	if (ret)
 		return ret;
+
+	if (CONFIG_IS_ENABLED(OS_BOOT)) {
+		header = (struct legacy_img_hdr *)buf;
+		if (image_get_magic(header) != FDT_MAGIC)
+			return size;
+	}
+
 	return actlen;
 }
 
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index fce451b7664..f426a068ff9 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -47,6 +47,7 @@ static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
 static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
 {
+	struct legacy_img_hdr *header;
 	loff_t actread;
 	int ret;
 	char *filename = load->priv;
@@ -55,6 +56,12 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	if (ret)
 		return ret;
 
+	if (CONFIG_IS_ENABLED(OS_BOOT)) {
+		header = (struct legacy_img_hdr *)buf;
+		if (image_get_magic(header) != FDT_MAGIC)
+			return size;
+	}
+
 	return actread;
 }
 
-- 
2.43.0

