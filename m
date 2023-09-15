Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C0CEE6450
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DA586458;
	Fri, 15 Sep 2023 12:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fffcPtqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A789486400; Fri, 15 Sep 2023 12:12:49 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D31863E3
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FACjd6038875
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 05:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694772765;
 bh=9WqhGv6RqgtgQxn1JVUfGUrSs8h7DW0roM43z8ulIf0=;
 h=From:To:CC:Subject:Date;
 b=fffcPtqgLkN1g7eAuA64Yw0DthZ781aCZXh0Wle9ePp4r/vIzxOgJwGkCN4LMqxVg
 ZiZWKZXZscQp3wN7BK/DUV2unB5tgIPBh95vDEJm5fIL8D/qH8BTT5rWiPV9p8bqGh
 f6F0z1L/ArHkA+fw7PZNlw8l5A3iC6wnGSc6nG4U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FACjJA102796
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 05:12:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 05:12:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 05:12:44 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com
 [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FACgh6048512;
 Fri, 15 Sep 2023 05:12:43 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>
CC: <u-boot@lists.denx.de>, <r-gunasekaran@ti.com>
Subject: [PATCH] include: env: ti: mmc: Add 'ti' directory prefix for overlays
Date: Fri, 15 Sep 2023 15:42:42 +0530
Message-ID: <20230915101242.20048-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
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

DTSOs are stored in vendor specific directories in Linux.
Add the vendor prefix to the path to load the overlay correctly.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 include/env/ti/mmc.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 0256a2d2aa..3e6b0287a3 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -70,7 +70,7 @@ get_overlay_mmc=
 	fdt resize 0x100000;
 	for overlay in $name_overlays;
 	do;
-	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay} &&
+	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/ti/${overlay} &&
 	fdt apply ${dtboaddr};
 	done;
 get_kern_mmc=load mmc ${bootpart} ${loadaddr}

base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
-- 
2.17.1

