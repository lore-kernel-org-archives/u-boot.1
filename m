Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD4FCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 12:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C21835A2;
	Tue, 23 Sep 2025 14:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t2H7GXpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DA28349B; Tue, 23 Sep 2025 14:46:53 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199B5800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 14:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NCkmlx1476305;
 Tue, 23 Sep 2025 07:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758631608;
 bh=8uQteAWKshrtCd84sSkcPm2bK/0jgxyShCg75muhbh8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=t2H7GXpeEa3p2DTJ901UVOwvXasRuD2LdhStg8v9Y+lzPg6Fw1fBFXIlZyZmIlUev
 V7/BQXsFycZWCtLcVa2+cWgkgdWV2pgTWKzcq+PTlN7V+lpEuMQ4kAH2EPR4qwkxLm
 7FypNsETKl/CK0VN846AiVugLg4ryeT4Redtfok8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NCklBT2782652
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 07:46:47 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 07:46:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:46:47 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NCkk3h313814;
 Tue, 23 Sep 2025 07:46:47 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 3/4] spl: mmc: load kernel image before args in falcon
Date: Tue, 23 Sep 2025 18:16:37 +0530
Message-ID: <20250923124639.667718-4-anshuld@ti.com>
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

