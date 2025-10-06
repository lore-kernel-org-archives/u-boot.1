Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35808CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA1A834D4;
	Mon,  6 Oct 2025 12:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hlnMB2Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD8E83775; Mon,  6 Oct 2025 12:11:19 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12DA834D4
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596ABEEB3526646;
 Mon, 6 Oct 2025 05:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759745474;
 bh=6wAK9InP+9nlxANpBF6pZKwVWl63ol1gX6mGuv63iPw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hlnMB2EqMVAMD1l/EkXxXAnE9x8m557nxnc96xZEfuscgKKyc4hIRtLwrsWVMSj5e
 AEy6ozVjCPSQrD4xjBFyJfjJfCIkDXxwKoKUQ/ik1XwaqfCW+glAw9BH9PdIHyo2tJ
 kq6BPYrkWwTDIYI/x5zQYsHYUUcHrGIK5FN8Nc5w=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596ABEQF3234429
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Oct 2025 05:11:14 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 05:11:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 05:11:13 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596ABCsr3268803;
 Mon, 6 Oct 2025 05:11:13 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH -next v3 7/7] spl: falcon: disable fallback to U-Boot on
 failure
Date: Mon, 6 Oct 2025 15:40:55 +0530
Message-ID: <20251006101057.4172248-8-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006101057.4172248-1-anshuld@ti.com>
References: <20251006101057.4172248-1-anshuld@ti.com>
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
index f37baefb372..93ef2d1c02c 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -138,8 +138,10 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
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
index 9c037bd62eb..6f9ff91bef7 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -95,8 +95,10 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
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

