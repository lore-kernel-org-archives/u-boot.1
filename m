Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A39CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02B98359F;
	Tue, 23 Sep 2025 15:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w3I/+iRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7DE835C6; Tue, 23 Sep 2025 15:09:16 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0C283510
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND9AAZ1456282;
 Tue, 23 Sep 2025 08:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632950;
 bh=ydA4S+oG9G2iKisBQHe+2zu/AxtWEpYy5zBPv01qPWw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=w3I/+iRx5aPSEkHFFGuOiiHD7PC3gv5r6HZKHqXqf5J4ql/n696XV0b6+0Vl/tbbF
 XeXpH3ZmnbDWKDuY3wstxKS9OL2CPkt5EFoePdPT72jkAKnhAtox22+Nlf58TJX6Vw
 3PMJADPDbHcbnBVGZpJ/N+diHKZrHfyctfzamXVc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND99QV1679942
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:10 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:09 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND98ex083763;
 Tue, 23 Sep 2025 08:09:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 3/8] spl: mmc: split spl_mmc_do_fs_boot into regular/os_boot
Date: Tue, 23 Sep 2025 18:38:55 +0530
Message-ID: <20250923130901.705124-4-anshuld@ti.com>
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

Currently the logic to handle falcon mode as well as the regular boot is
inside spl_mmc_do_fs_boot, this prevents us from cleanly extending
falcon mode functionality like toggleable fallback to U-Boot proper.

Therefore this patch splits the logic into spl_mmc_fs_load and
spl_mmc_fs_load_os to handle the regular boot and falcon mode use case.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c | 77 +++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cd56cf71055..e26f1087d45 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -193,6 +193,46 @@ int spl_start_uboot(void)
 }
 #endif
 
+static int spl_mmc_fs_load_os(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev,
+			      struct blk_desc *blk_dev, int part)
+{
+	int err = -ENOSYS;
+
+	if (CONFIG_IS_ENABLED(FS_FAT)) {
+		err = spl_load_image_fat_os(spl_image, bootdev, blk_dev, part);
+		if (!err)
+			return 0;
+	}
+	if (CONFIG_IS_ENABLED(FS_EXT4)) {
+		err = spl_load_image_ext_os(spl_image, bootdev, blk_dev, part);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+
+static int spl_mmc_fs_load(struct spl_image_info *spl_image,
+			   struct spl_boot_device *bootdev,
+			   struct blk_desc *blk_dev, int part, const char *file)
+{
+	int err = -ENOENT;
+
+	if (CONFIG_IS_ENABLED(FS_FAT)) {
+		err = spl_load_image_fat(spl_image, bootdev, blk_dev, part, file);
+		if (!err)
+			return 0;
+	}
+	if (CONFIG_IS_ENABLED(FS_EXT4)) {
+		err = spl_load_image_ext(spl_image, bootdev, blk_dev, part, file);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+
 #ifdef CONFIG_SYS_MMCSD_FS_BOOT
 static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev,
@@ -225,42 +265,19 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 	}
 #endif
 
-#ifdef CONFIG_SPL_FS_FAT
 	if (!spl_start_uboot()) {
-		ret = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-					    partition);
+		ret = spl_mmc_fs_load_os(spl_image, bootdev,
+					 mmc_get_blk_desc(mmc), partition);
 		if (!ret)
 			return 0;
 	}
-#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	ret = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
-				 partition,
-				 filename);
-	if (!ret)
-		return ret;
-#endif
-#endif
-#ifdef CONFIG_SPL_FS_EXT4
-	if (!spl_start_uboot()) {
-		ret = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-					    partition);
-		if (!ret)
-			return 0;
-	}
-#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	ret = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
-				 partition,
-				 filename);
-	if (!ret)
-		return 0;
-#endif
-#endif
-
-#if defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
-	ret = -ENOENT;
-#endif
 
+#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+	return spl_mmc_fs_load(spl_image, bootdev, mmc_get_blk_desc(mmc),
+			       partition, filename);
+#else
 	return ret;
+#endif
 }
 #endif
 
-- 
2.51.0

