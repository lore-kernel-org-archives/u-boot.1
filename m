Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D487ECCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA22838D2;
	Fri, 17 Oct 2025 21:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UAt0pwsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6020838BB; Fri, 17 Oct 2025 21:33:39 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB62C8383F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HJXYTK2439727;
 Fri, 17 Oct 2025 14:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760729614;
 bh=hP6I7RszImUdo4nakEKQHV0kkNGt18w7xZMpAujJSRk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UAt0pwsZtbx5ZiKvgfHlYgjz8xDHf4TjP3OvVl+WEx5eypg6S7o9L4p/ItqRVwEeQ
 b0yXLns5iQHFjBHHDk1QkWq05VImLUc7wbf1gouUT0gznsAww4/wCrGSGXcJAJs7b1
 Wt8k1jJkOukZWMRTZ8d2K/qAaPPQwnU3on9/D3A8=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HJXYQh2627278
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 14:33:34 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 14:33:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 14:33:34 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HJXWRx1795117;
 Fri, 17 Oct 2025 14:33:33 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 7/7] spl: falcon: disable fallback to U-Boot on failure
Date: Sat, 18 Oct 2025 01:03:12 +0530
Message-ID: <20251017193318.4124997-8-anshuld@ti.com>
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

Instead of falling back to the standard U-Boot boot flow, we should just
halt boot if the expected boot flow in falcon mode fails.

This prevents a malicious actor from accessing U-Boot proper if they can
cause a boot failure on falcon mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c  | 4 ++++
 common/spl/spl_nand.c | 6 ++++--
 common/spl/spl_nor.c  | 6 ++++--
 common/spl/spl_spi.c  | 6 ++++--
 common/spl/spl_ubi.c  | 2 ++
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index bfcdea2d05f..0a00d295575 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -272,6 +272,8 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 			return 0;
 		printf("%s, Failed to load falcon payload: %d\n", __func__,
 		       ret);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return ret;
 		printf("Fallback to U-Boot\n");
 	}
 
@@ -412,6 +414,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			ret = mmc_load_image_raw_os(spl_image, bootdev, mmc);
 			if (!ret)
 				return 0;
+			if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+				return ret;
 		}
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index c9f5d039768..3da292f1437 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -138,8 +138,10 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 		err = spl_nand_load_image_os(spl_image, bootdev);
 		if (!err)
 			return 0;
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index c349a4c7bc3..bb91f4ab8f8 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -96,8 +96,10 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 		if (!err)
 			return 0;
 
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 45718824cbf..4d61214bceb 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -105,8 +105,10 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		if (!err)
 			return 0;
 
-		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
-		       __func__, err);
+		printf("%s: Failed in falcon boot: %d", __func__, err);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return err;
+		printf("Fallback to U-Boot\n");
 	}
 #endif
 
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 4aecad3470c..25e7599703c 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -77,6 +77,8 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 			return 0;
 
 		printf("%s: Failed in falcon boot: %d", __func__, ret);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE))
+			return ret;
 		printf("Fallback to U-Boot\n");
 	}
 #endif
-- 
2.51.0

