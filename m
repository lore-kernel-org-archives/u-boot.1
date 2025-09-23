Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E713CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 12:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EA98349B;
	Tue, 23 Sep 2025 14:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="js+ZtOsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF8D8359F; Tue, 23 Sep 2025 14:46:55 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080218344E
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 14:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NCknNd1476317;
 Tue, 23 Sep 2025 07:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758631609;
 bh=2wNvpzuXADAbWwp6KLeutr+8FDDGxH1DxH5OnTP5eG0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=js+ZtOskZsfWcQqHq2sny/h4mv1y3LOUPCtIEFhgH4R5o1ZB3hHSqlbMU/mQ1dwhS
 1ujL8iPtKcDm/2SBGlKABzzhv7rK8NfJtBiT13ajt9ITmKxg3sGYEfAM7C7JLtBy0q
 YiSINI7awMIWQjtzwb7sYPDth4FcennBLUEFO9n0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NCkn0L2782669
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 07:46:49 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 07:46:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:46:49 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NCkmpG313851;
 Tue, 23 Sep 2025 07:46:48 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 4/4] spl: ext,
 fat: cleanup use of CONFIG_SPL_LIBCOMMON_SUPPORT
Date: Tue, 23 Sep 2025 18:16:38 +0530
Message-ID: <20250923124639.667718-5-anshuld@ti.com>
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

Minor cleanup of spl_ext and spl_fat files, removing the outdated
CONFIG_SPL_LIBCOMMON_SUPPORT symbols similar to the commit 1847129025e0
("spl: mmc: Drop checks for CONFIG_SPL_LIBCOMMON_SUPPORT") and adding a
few extra failure reports.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ext.c | 8 --------
 common/spl/spl_fat.c | 6 ------
 2 files changed, 14 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 80bd084db4e..c66ba03feb2 100644
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
@@ -91,9 +87,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 
 	err = ext4fs_mount();
 	if (!err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
-#endif
 		return -1;
 	}
 
@@ -149,10 +143,8 @@ defaults:
 
 	err = ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0, filelen, &actlen);
 	if (err < 0) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
-#endif
 		return -1;
 	}
 
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 2c8eee01272..dc52bd13cec 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -34,9 +34,7 @@ static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
 
 	err = fat_register_device(block_dev, partition);
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: fat register err - %d\n", __func__, err);
-#endif
 		return err;
 	}
 
@@ -98,11 +96,9 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 	err = spl_load(spl_image, bootdev, &load, size, 0);
 
 end:
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
-#endif
 
 	return err;
 }
@@ -157,10 +153,8 @@ defaults:
 	err = file_fat_read(CONFIG_SPL_FS_LOAD_ARGS_NAME,
 			    (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
 	if (err <= 0) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
-#endif
 		return -1;
 	}
 
-- 
2.51.0

