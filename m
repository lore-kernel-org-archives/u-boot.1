Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D407CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8C8833E9;
	Thu, 11 Sep 2025 15:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tOOLJrzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033D38334F; Thu, 11 Sep 2025 15:14:35 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A658334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDERqQ379776;
 Thu, 11 Sep 2025 08:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596467;
 bh=/jBFWfiLaZpNNZGqNlxJeIt9vW9wkWvQXi75nkUTcR8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tOOLJrzXp4dzTJUd+vR2em34V5vKp7UvoaU6mNY7v2nl0DpUBMO2WVQzP0uzMi2wo
 GMFkDflQt+xiNS/f5ufUyZtc6eTiSPPUd7ioaoytPWzMZsFrFvek+HW0QWgWH7j8y7
 irk8kLQ1Qv7pv81+a3rCQ6ErJFPUAlZiOMRqWkC8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDER2L1078661
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:27 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:27 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEQMe1873050;
 Thu, 11 Sep 2025 08:14:26 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 05/17] spl: ext: load kernel image before args in falcon
Date: Thu, 11 Sep 2025 18:44:01 +0530
Message-ID: <20250911131414.3296697-6-anshuld@ti.com>
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

Load the kernel image before args in falcon mode to be consistent with
the load order for other boot media.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ext.c | 51 +++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 7e0274a3058..279e254139f 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -96,39 +96,47 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
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
+		err = spl_load_image_ext(spl_image, bootdev, block_dev,
+					 partition, file);
+		if (err != 0) {
+			puts("spl: falling back to default\n");
 			goto defaults;
 		}
-		err = ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0, filelen, &actlen);
-		if (err < 0) {
-			printf("spl: error reading image %s, err - %d, falling back to default\n",
-			       file, err);
-			goto defaults;
-		}
-		file = env_get("falcon_image_file");
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
+
+	err = spl_load_image_ext(spl_image, bootdev, block_dev, partition,
+				 CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+
+	if (err)
+		return err;
 
 	err = ext4fs_open(CONFIG_SPL_FS_LOAD_ARGS_NAME, &filelen);
 	if (err < 0)
@@ -143,8 +151,7 @@ defaults:
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

