Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED599CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682C783693;
	Mon,  6 Oct 2025 12:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eSSmH7u3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A3283655; Mon,  6 Oct 2025 12:11:10 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B44C835FE
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596AB4LG3977151;
 Mon, 6 Oct 2025 05:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759745464;
 bh=A6+XXdfRXAxrnyC4HoLyFsSzpfFtHPZdrwDLqJ+kWDs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eSSmH7u3RL+dRjecxAKgw7H8O2cWImC/+mlkJT00LgyD14dpsWQ48P6FHW0EGSxRd
 /hf9EMQUunr5li+8YbVKv6YwH++Jx9wCV3r1ECtWkMutIrYLZnzPkAQo7reYp3e1q+
 pI+oVWZd9wsfuOQs3FXTbjm2G7heLtXqeMt+bqac=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596AB4Vn3234369
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 05:11:04 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 05:11:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 05:11:04 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596AB3ks3511627;
 Mon, 6 Oct 2025 05:11:03 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH -next v3 2/7] spl: mmc: split spl_mmc_do_fs_boot into
 regular/os_boot
Date: Mon, 6 Oct 2025 15:40:50 +0530
Message-ID: <20251006101057.4172248-3-anshuld@ti.com>
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

Currently the logic to handle falcon mode as well as the regular boot is
inside spl_mmc_do_fs_boot, this prevents us from cleanly extending
falcon mode functionality like toggleable fallback to U-Boot proper.

Therefore this patch splits the logic into spl_mmc_fs_load and
spl_mmc_fs_load_os to handle the regular boot and falcon mode use case.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c | 80 +++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cd56cf71055..c5585d8e0d2 100644
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
@@ -225,42 +265,22 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
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
+		printf("%s, Failed to load falcon payload: %d\n", __func__,
+		       ret);
+		printf("Fallback to U-Boot\n");
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

