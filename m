Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ADBCAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8558346A;
	Thu, 11 Sep 2025 15:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fLa+WmHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAE283487; Thu, 11 Sep 2025 15:14:38 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190EA83429
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEVZb297075;
 Thu, 11 Sep 2025 08:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596472;
 bh=FY45vYvq1/r9NxXFYNuA6T1c1QhFUTHRblEPNeZb50o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fLa+WmHTIBeFsNPz0eH0tIKH07yHwve1b8dHvWK2Eu/4I90F0NV61jPd8hfpuraPF
 8jkcC85KPBp9T+Z5pIRLJzx9TroJcehpeARVa0knlDZL4kbfIoz/huz2LnPtOvFtWf
 Qa6mSK5bu1quOjx5vnoIyCZTsGk9kw+yt8LJv03Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEV4q515768
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:31 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:31 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEUqw2168880;
 Thu, 11 Sep 2025 08:14:30 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 07/17] spl: ext,
 fat: cleanup use of CONFIG_SPL_LIBCOMMON_SUPPORT
Date: Thu, 11 Sep 2025 18:44:03 +0530
Message-ID: <20250911131414.3296697-8-anshuld@ti.com>
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

Minor cleanup of spl_ext and spl_fat files, removing the outdated
CONFIG_SPL_LIBCOMMON_SUPPORT symbols similar to the commit 1847129025e0
("spl: mmc: Drop checks for CONFIG_SPL_LIBCOMMON_SUPPORT") and adding a
few extra failure reports.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ext.c |  8 +++-----
 common/spl/spl_fat.c | 14 ++++++--------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 279e254139f..f556986bf5a 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -47,9 +47,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 
 	err = ext4fs_mount();
 	if (!err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
-#endif
 		return -1;
 	}
 
@@ -63,11 +61,9 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 	err = spl_load(spl_image, bootdev, &load, filelen, 0);
 
 end:
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
-#endif
 
 	return err < 0;
 }
@@ -139,8 +135,10 @@ defaults:
 		return err;
 
 	err = ext4fs_open(CONFIG_SPL_FS_LOAD_ARGS_NAME, &filelen);
-	if (err < 0)
+	if (err < 0) {
 		puts("spl: ext4fs_open failed\n");
+		return err;
+	}
 
 	err = ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0, filelen, &actlen);
 	if (err < 0) {
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 2c8eee01272..80e800b4755 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -98,11 +98,9 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 	err = spl_load(spl_image, bootdev, &load, size, 0);
 
 end:
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
-#endif
 
 	return err;
 }
@@ -116,8 +114,10 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 	__maybe_unused char *file;
 
 	err = spl_register_fat_device(block_dev, partition);
-	if (err)
+	if (err) {
+		printf("%s: fat mount err - %d\n", __func__, err);
 		return err;
+	}
 
 	if (!CONFIG_IS_ENABLED(ENV_SUPPORT))
 		goto defaults;
@@ -157,11 +157,9 @@ defaults:
 	err = file_fat_read(CONFIG_SPL_FS_LOAD_ARGS_NAME,
 			    (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
 	if (err <= 0) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
-		printf("%s: error reading image %s, err - %d\n",
-		       __func__, CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
-#endif
-		return -1;
+		printf("%s: error reading image %s, err - %d\n", __func__,
+		       CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
+		return err;
 	}
 
 	return 0;
-- 
2.51.0

