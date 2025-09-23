Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0806CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 12:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27CB283443;
	Tue, 23 Sep 2025 14:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jd2kP7me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59509834D4; Tue, 23 Sep 2025 14:46:50 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050B4833E9
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 14:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NCkitb1004639;
 Tue, 23 Sep 2025 07:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758631604;
 bh=+IhmTVOlWXkvr1dbNeH9wTNU2amjm4WuQIEn6AFzXzs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jd2kP7me5GcT4L2yJWFw6Bol+ENxz85OosQx++0DT0rsIJ6a40GQEJcZ21OgsfxFe
 UjUqxI8nSlz/lnAy6BveAzmGpwy/Vg8ktODg7birBM4wsJ7ukbcUW4Jwq8mQGNihVS
 nZS5mqSw+MkriY1nrCz4HR/up0y4OdeHKOz9tyFs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NCkiej1663052
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 07:46:44 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 07:46:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:46:43 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NCkgYe313782;
 Tue, 23 Sep 2025 07:46:43 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 1/4] spl: fat: load kernel image before args in falcon
Date: Tue, 23 Sep 2025 18:16:35 +0530
Message-ID: <20250923124639.667718-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923124639.667718-1-anshuld@ti.com>
References: <20250923124639.667718-1-anshuld@ti.com>
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

Currently in falcon mode, the FS and raw mmc boot loads the args file
first followed by the kernel image whereas others load in the opposite
order. This inconsistency means falcon boot doesn't behave the same
across various boot media.

For example, in the case where the kernel file is a FIT with the kernel
image present alongside the dtb and the args file is another DT, which
DT should be picked? The one form the FIT or the one set by the args
file? Currently this depends entirely on how the boot media handles
falcon mode.

Therefore, this patch enforces the load order of the kernel image first
followed by the args file in FAT FS boot. So in the above example, the
args file would take precedence.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_fat.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 8b7cafa7291..2c8eee01272 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -119,32 +119,40 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
-#if defined(CONFIG_SPL_ENV_SUPPORT) && defined(CONFIG_SPL_OS_BOOT)
-	file = env_get("falcon_args_file");
+	if (!CONFIG_IS_ENABLED(ENV_SUPPORT))
+		goto defaults;
+
+	file = env_get("falcon_image_file");
 	if (file) {
-		err = file_fat_read(file, (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
-		if (err <= 0) {
-			printf("spl: error reading image %s, err - %d, falling back to default\n",
-			       file, err);
+		err = spl_load_image_fat(spl_image, bootdev, block_dev,
+					 partition, file);
+		if (err != 0) {
+			puts("spl: falling back to default\n");
 			goto defaults;
 		}
-		file = env_get("falcon_image_file");
+
+		file = env_get("falcon_args_file");
 		if (file) {
-			err = spl_load_image_fat(spl_image, bootdev, block_dev,
-						 partition, file);
-			if (err != 0) {
-				puts("spl: falling back to default\n");
+			err = file_fat_read(
+				file, (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
+			if (err <= 0) {
+				printf("spl: error reading args %s, err - %d, falling back to default\n",
+				       file, err);
 				goto defaults;
 			}
-
 			return 0;
 		} else
-			puts("spl: falcon_image_file not set in environment, falling back to default\n");
+			puts("spl: falcon_args_file not set in environment, falling back to default\n");
 	} else
-		puts("spl: falcon_args_file not set in environment, falling back to default\n");
+		puts("spl: falcon_image_file not set in environment, falling back to default\n");
 
 defaults:
-#endif
+
+	err = spl_load_image_fat(spl_image, bootdev, block_dev, partition,
+				 CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+
+	if (err)
+		return err;
 
 	err = file_fat_read(CONFIG_SPL_FS_LOAD_ARGS_NAME,
 			    (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
@@ -156,8 +164,7 @@ defaults:
 		return -1;
 	}
 
-	return spl_load_image_fat(spl_image, bootdev, block_dev, partition,
-			CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+	return 0;
 }
 #else
 int spl_load_image_fat_os(struct spl_image_info *spl_image,
-- 
2.51.0

