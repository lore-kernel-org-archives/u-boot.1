Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4789CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4AB183531;
	Thu, 11 Sep 2025 15:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QSwGVTSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E859834AD; Thu, 11 Sep 2025 15:14:41 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BEE8346A
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEZvi808424;
 Thu, 11 Sep 2025 08:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596476;
 bh=hvsTdZCytJVlTJYonPusk1C6djElQ2A/otJiTFr6LkM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QSwGVTSVkaW1r46F6KLGDvFeR+XTrBnbICK1urhGr53aFlVLxqPl+aaBcoH3pRYD6
 X21b/idVwDW6ca2q3HNhOh8K5SXMNPIWihFNNWPcmDcoT6F5/+jIdw02Z/CL9+kGnv
 MGImQctTl4af/zeScf2Lyp+zG3JCdTR0x7mAVMwQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEZuX1179208
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:35 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:35 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEYWW1873148;
 Thu, 11 Sep 2025 08:14:35 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 09/17] spl: ubi: refactor spl_ubi_load_image for falcon
 mode
Date: Thu, 11 Sep 2025 18:44:05 +0530
Message-ID: <20250911131414.3296697-10-anshuld@ti.com>
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

This patch moves the falcon mode handling logic out of
spl_ubi_load_image to spl_ubi_load_image_os, this allows for cleaner
handling for fallback to U-Boot in case falcon mode fails.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ubi.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index a8d3f43b452..09b9bbc5c47 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -11,6 +11,32 @@
 #include <ubispl.h>
 #include <spl.h>
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+int spl_ubi_load_image_os(struct spl_image_info *spl_image,
+			  struct spl_boot_device *bootdev,
+			  struct ubispl_info *info)
+{
+	struct legacy_img_hdr *header;
+	struct ubispl_load volumes[2];
+	int err;
+
+	volumes[0].vol_id = CONFIG_SPL_UBI_LOAD_KERNEL_ID;
+	volumes[0].load_addr = (void *)CONFIG_SYS_LOAD_ADDR;
+	volumes[1].vol_id = CONFIG_SPL_UBI_LOAD_ARGS_ID;
+	volumes[1].load_addr = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
+
+	err = ubispl_load_volumes(info, volumes, 2);
+	if (err)
+		return err;
+
+	header = (struct legacy_img_hdr *)volumes[0].load_addr;
+	spl_parse_image_header(spl_image, bootdev, header);
+	puts("Linux loaded.\n");
+
+	return 0;
+}
+#endif
+
 int spl_ubi_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
 {
@@ -46,21 +72,15 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (!spl_start_uboot()) {
-		volumes[0].vol_id = CONFIG_SPL_UBI_LOAD_KERNEL_ID;
-		volumes[0].load_addr = (void *)CONFIG_SYS_LOAD_ADDR;
-		volumes[1].vol_id = CONFIG_SPL_UBI_LOAD_ARGS_ID;
-		volumes[1].load_addr = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
+		ret = spl_ubi_load_image_os(spl_image, bootdev, &info);
+		if (!ret)
+			return 0;
 
-		ret = ubispl_load_volumes(&info, volumes, 2);
-		if (!ret) {
-			header = (struct legacy_img_hdr *)volumes[0].load_addr;
-			spl_parse_image_header(spl_image, bootdev, header);
-			puts("Linux loaded.\n");
-			goto out;
-		}
-		puts("Loading Linux failed, falling back to U-Boot.\n");
+		printf("%s: Failed in falcon boot: %d", __func__, ret);
+		printf("Fallback to U-Boot\n");
 	}
 #endif
+
 	header = spl_get_load_buffer(-sizeof(*header), sizeof(header));
 #ifdef CONFIG_SPL_UBI_LOAD_BY_VOLNAME
 	volumes[0].vol_id = -1;
-- 
2.51.0

