Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C8CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 10:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C289F832AD;
	Tue, 16 Sep 2025 12:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xFADRDDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D780D8329B; Tue, 16 Sep 2025 12:35:55 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303698309A
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GAZnjw1349765;
 Tue, 16 Sep 2025 05:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758018949;
 bh=gEPMYIQPvJPcMomoi6xYSu4MZnL2bO93PnPVCmAvbMI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xFADRDDX+xGgs3yLU2dPYhKCx8Wf1zwTdv1WE0ka4O2yDQ31Ba00hm8xos4B5trqF
 5MGw2NBNCYknWMUOXClsMxejiFP9UON9aHlB7tSEzN7zZXHHtCqOv9qyb6FoaEfY+I
 aQ8TEyWOZoS+ZOxJmTDfmX+EyDDr9dyf6w/Ew7cg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GAZnEx462285
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 05:35:49 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 05:35:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 05:35:48 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GAZlIB1480178;
 Tue, 16 Sep 2025 05:35:47 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 2/4] spl: ext: load kernel image before args in falcon
Date: Tue, 16 Sep 2025 16:05:39 +0530
Message-ID: <20250916103542.104773-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916103542.104773-1-anshuld@ti.com>
References: <20250916103542.104773-1-anshuld@ti.com>
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

Load the kernel image before args in falcon mode to be consistent with
the load order for other boot media.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ext.c | 56 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 7e0274a3058..80bd084db4e 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -96,40 +96,53 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 #endif
 		return -1;
 	}
-#if defined(CONFIG_SPL_ENV_SUPPORT)
-	file = env_get("falcon_args_file");
+
+	if (!CONFIG_IS_ENABLED(ENV_SUPPORT))
+		goto defaults;
+
+	file = env_get("falcon_image_file");
 	if (file) {
-		err = ext4fs_open(file, &filelen);
-		if (err < 0) {
-			puts("spl: ext4fs_open failed\n");
-			goto defaults;
-		}
-		err = ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0, filelen, &actlen);
-		if (err < 0) {
-			printf("spl: error reading image %s, err - %d, falling back to default\n",
-			       file, err);
+		err = spl_load_image_ext(spl_image, bootdev, block_dev,
+					 partition, file);
+		if (err != 0) {
+			puts("spl: falling back to default\n");
 			goto defaults;
 		}
-		file = env_get("falcon_image_file");
+
+		ext4fs_set_blk_dev(block_dev, &part_info);
+		ext4fs_mount();
+		file = env_get("falcon_args_file");
 		if (file) {
-			err = spl_load_image_ext(spl_image, bootdev, block_dev,
-						 partition, file);
-			if (err != 0) {
-				puts("spl: falling back to default\n");
+			err = ext4fs_open(file, &filelen);
+			if (err < 0) {
+				puts("spl: ext4fs_open failed\n");
+				goto defaults;
+			}
+			err = ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
+					  0, filelen, &actlen);
+			if (err < 0) {
+				printf("spl: error reading args %s, err - %d, falling back to default\n",
+				       file, err);
 				goto defaults;
 			}
-
 			return 0;
 		} else {
-			puts("spl: falcon_image_file not set in environment, falling back to default\n");
+			puts("spl: falcon_args_file not set in environment, falling back to default\n");
 		}
 	} else {
-		puts("spl: falcon_args_file not set in environment, falling back to default\n");
+		puts("spl: falcon_image_file not set in environment, falling back to default\n");
 	}
 
 defaults:
-#endif
 
+	err = spl_load_image_ext(spl_image, bootdev, block_dev, partition,
+				 CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+
+	if (err)
+		return err;
+
+	ext4fs_set_blk_dev(block_dev, &part_info);
+	ext4fs_mount();
 	err = ext4fs_open(CONFIG_SPL_FS_LOAD_ARGS_NAME, &filelen);
 	if (err < 0)
 		puts("spl: ext4fs_open failed\n");
@@ -143,8 +156,7 @@ defaults:
 		return -1;
 	}
 
-	return spl_load_image_ext(spl_image, bootdev, block_dev, partition,
-			CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+	return 0;
 }
 #else
 int spl_load_image_ext_os(struct spl_image_info *spl_image,
-- 
2.51.0

