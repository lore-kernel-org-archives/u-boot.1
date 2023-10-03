Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E65E75433
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F403487272;
	Tue,  3 Oct 2023 10:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eUhYekRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9ECA87211; Tue,  3 Oct 2023 10:11:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07F787211
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938B0RQ023645;
 Tue, 3 Oct 2023 03:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320660;
 bh=ELeK0Djo5C/wxIdvHLDyosHw3bjTLc8wFk4QnATY3Zw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eUhYekRYkF1bPFT4ic8OIuOhw5mfYC5r8Vx5mkT8BNqPGw9pBT4tAsI4h9EqsJ4i+
 YqpygphMa0ZGlbRZBZDbiqjO9+p0a6QK7U8BEhW139MJZZsxQtwVvyJWkdEOy7hWt+
 BBvQJwFwmPnoKRHNA93yOYj52C9mtjGqjf8U7t1M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938AxS2022069
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:10:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:10:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:10:59 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEG110453;
 Tue, 3 Oct 2023 03:10:57 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 06/10] board: ti: j721s2: Initialize the ESM & PMIC ESM
Date: Tue, 3 Oct 2023 13:40:34 +0530
Message-ID: <20231003081038.24299-7-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003081038.24299-1-j-keerthy@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Initialize the ESM & PMIC ESM

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 board/ti/j721s2/evm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 7795300abc..effa52ff5a 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -319,4 +319,31 @@ int board_late_init(void)
 
 void spl_board_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@700000 failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@40800000 failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@42080000",
+						&dev);
+		if (ret)
+			printf("MISC init for esm@42080000 failed: %d\n", ret);
+	}
+
+	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(pmic_esm),
+						  &dev);
+		if (ret)
+			printf("ESM PMIC init failed: %d\n", ret);
+	}
 }
-- 
2.17.1

