Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A1CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B59B58362C;
	Tue, 23 Sep 2025 15:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K8WtA4sA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC238350A; Tue, 23 Sep 2025 15:09:24 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB8983510
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND9JRO1480044;
 Tue, 23 Sep 2025 08:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632959;
 bh=0UiwTMiv5uU6HYYRuWj9x6oIdVQs0+K/VhYobWWQEuI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=K8WtA4sA7KX/ypzs11+3/EDK84G1+4HEAGxK4LK/Dk7ZZZtWWpxtax7lh6Juouwe3
 mHeIJSlukgHI0cYLRrvR6buWDnEDqTg+ipzGTrzCxytQlEoOOCCNzPV2IEXd8i7x6s
 +EAhYXBRSVPwHHLhsYVCFq8OLsD6BXHRCWnPqFnM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND9J852800753
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:19 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:18 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND9H5a341241;
 Tue, 23 Sep 2025 08:09:18 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 8/8] spl: falcon: disable fallback to U-Boot on failure
Date: Tue, 23 Sep 2025 18:39:00 +0530
Message-ID: <20250923130901.705124-9-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923130901.705124-1-anshuld@ti.com>
References: <20250923130901.705124-1-anshuld@ti.com>
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
cause a boot failure on falcon mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c  |  4 ++++
 common/spl/spl_nand.c | 11 +++++------
 common/spl/spl_nor.c  | 10 +++++-----
 common/spl/spl_spi.c  |  3 +++
 common/spl/spl_ubi.c  |  2 ++
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index e26f1087d45..c9637399c15 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -270,6 +270,8 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 					 mmc_get_blk_desc(mmc), partition);
 		if (!ret)
 			return 0;
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return ret;
 	}
 
 #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
@@ -409,6 +411,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			ret = mmc_load_image_raw_os(spl_image, bootdev, mmc);
 			if (!ret)
 				return 0;
+			if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+				return ret;
 		}
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 8993e304c26..7d1b55b2311 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -138,12 +138,11 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 		err = spl_nand_load_image_os(spl_image, bootdev);
 		if (!err)
 			return 0;
-		} else {
-			puts("The Expected Linux image was not "
-				"found. Please check your NAND "
-				"configuration.\n");
-			puts("Trying to start u-boot now...\n");
-		}
+
+		puts("%s: Failed in falcon boot: %d", __func__, err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+		puts("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index e999dcc4fcf..6f8149cac53 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -94,11 +94,11 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 		err = spl_nor_load_image_os(spl_image, bootdev);
 		if (!err)
 			return 0;
-		} else {
-			puts("The Expected Linux image was not found.\n"
-			     "Please check your NOR configuration.\n"
-			     "Trying to start u-boot now...\n");
-		}
+
+		puts("%s: Failed in falcon boot: %d", __func__, err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+		puts("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 1ada37f5c21..863be144316 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -104,6 +104,9 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 		if (!err)
 			return 0;
+
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
 	}
 #endif
 
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 162ec0f2f9b..95676975e76 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -77,6 +77,8 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 			return 0;
 
 		puts("Loading Linux failed, falling back to U-Boot.\n");
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return ret;
 	}
 #endif
 
-- 
2.51.0

