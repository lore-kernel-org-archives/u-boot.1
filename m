Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3767CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2C0835BF;
	Thu, 11 Sep 2025 15:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X0BHyTh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C8E83526; Thu, 11 Sep 2025 15:14:48 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036A78340A
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEiIX750384;
 Thu, 11 Sep 2025 08:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596484;
 bh=Se1liIFybq6ZcnNbwRbnOofTkqz+H6cJ8EjJlW3NpSo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=X0BHyTh+0yoiM5rMempLkFfT6isOwCUTb5XoLhpgvsS2329zWxgS79UmthXCQH2Cq
 H01yPCDHFSm97uWUj/B+wklmFGj5oN8lAjVyz6m7QRnIBDvoEbLn1tulWfDcHJS1Vx
 wNgZFXHOWAioyzQJYPtiV0MZtuquwTdLgkpTJG6A=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEi5k1962374
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:44 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:43 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEgGx2169032;
 Thu, 11 Sep 2025 08:14:43 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 13/17] spl: falcon: disable fallback to U-Boot on
 failure
Date: Thu, 11 Sep 2025 18:44:09 +0530
Message-ID: <20250911131414.3296697-14-anshuld@ti.com>
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

Instead of falling back to the standard U-Boot boot flow, we should just
halt boot if the expected boot flow in falcon mode fails.

This prevents a malicious actor from accessing U-Boot proper if they can
cause the boot failure on falcon mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c  | 4 ++++
 common/spl/spl_nand.c | 6 ++++--
 common/spl/spl_nor.c  | 6 ++++--
 common/spl/spl_spi.c  | 6 ++++--
 common/spl/spl_ubi.c  | 2 ++
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index c5585d8e0d2..d0dad6ea8fd 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -272,6 +272,8 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 			return 0;
 		printf("%s, Failed to load falcon payload: %d\n", __func__,
 		       ret);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return ret;
 		printf("Fallback to U-Boot\n");
 	}
 
@@ -412,6 +414,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			ret = mmc_load_image_raw_os(spl_image, bootdev, mmc);
 			if (!ret)
 				return 0;
+			if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+				return ret;
 		}
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 3390cd44a14..ff7087da1df 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -139,8 +139,10 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 		err = spl_nand_load_image_os(spl_image, bootdev);
 		if (!err)
 			return 0;
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index e95a75336f2..7005e0f30c7 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -96,8 +96,10 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 		if (!err)
 			return 0;
 
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 2a6098a4dc3..cbc864809fe 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -105,8 +105,10 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		if (!err)
 			return 0;
 
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 09b9bbc5c47..3c6f80de7d9 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -77,6 +77,8 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 			return 0;
 
 		printf("%s: Failed in falcon boot: %d", __func__, ret);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return ret;
 		printf("Fallback to U-Boot\n");
 	}
 #endif
-- 
2.51.0

