Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA64CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 10:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A748318E;
	Tue, 16 Sep 2025 12:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MaWV0gQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0C68331F; Tue, 16 Sep 2025 12:35:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAE583287
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GAZoWV1704878;
 Tue, 16 Sep 2025 05:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758018950;
 bh=8uQteAWKshrtCd84sSkcPm2bK/0jgxyShCg75muhbh8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MaWV0gQkk9u4lYyehl5TqsW/aqoTygNAsGIh157+Iot4oK8u6GnCqaWI4oOZa4CT0
 iyRj+Nf+pdPoXQ+upkWJfVfZX9ZH+PZy9xlSWBca81zn4SoEPLyFlQxNxNxHuypFOx
 hp2r+4ad8Ru4bd5+rNs/M3B52wwAapIpjAc90ilc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GAZojT653601
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 05:35:50 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 05:35:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 05:35:50 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GAZnAR1180633;
 Tue, 16 Sep 2025 05:35:49 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 3/4] spl: mmc: load kernel image before args in falcon
Date: Tue, 16 Sep 2025 16:05:40 +0530
Message-ID: <20250916103542.104773-4-anshuld@ti.com>
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

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_mmc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d06f9f0dee6..cd56cf71055 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -152,6 +152,16 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
 {
 	int ret;
 
+	ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
+		CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR);
+	if (ret)
+		return ret;
+
+	if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE) {
+		puts("Expected image is not found. Trying to start U-Boot\n");
+		return -ENOENT;
+	}
+
 #if defined(CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR)
 	unsigned long count;
 
@@ -165,16 +175,6 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
 	}
 #endif	/* CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR */
 
-	ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
-		CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR);
-	if (ret)
-		return ret;
-
-	if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE) {
-		puts("Expected image is not found. Trying to start U-Boot\n");
-		return -ENOENT;
-	}
-
 	return 0;
 }
 #else
-- 
2.51.0

