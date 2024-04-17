Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DBC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 04:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDD18841D;
	Wed, 17 Apr 2024 06:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T3bNS+cK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05CB88433; Wed, 17 Apr 2024 06:37:11 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 626D087C69
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 06:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43H4b29G093283;
 Tue, 16 Apr 2024 23:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713328622;
 bh=MHUwkApsJgDEyFeI/YBUX+Cy4pVPNMgxZsT2iJVk8qg=;
 h=From:To:CC:Subject:Date;
 b=T3bNS+cKfctYMVwUeYYviLbzspWIzQFJwzbj4y/WYMKKGDUQOKHUisZv2ZT157Zxi
 2dCDEDNqPa3Ns94i+gGzuVLmSXXh7NehPOycdj+Llj5woXVCSXbmmLW+VzljmTbwEO
 c9ZuX6Xi/Z6BR61tCfqrRRA3gT8HCg+RwKqsaF2o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43H4b2Q1110227
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 23:37:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 23:37:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 23:37:01 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43H4awMX006414;
 Tue, 16 Apr 2024 23:36:59 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <n-francis@ti.com>, <afd@ti.com>, <j-keerthy@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <rogerq@kernel.org>,
 <christian.gmeiner@gmail.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] board: ti: j721e: Add support for both esm probe
Date: Wed, 17 Apr 2024 10:06:50 +0530
Message-ID: <20240417043650.3743061-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At present only MCU domain ESM is probed, this means errors
occurred in mcu domain will be propagate to MCU_SAFETY_ERRORn.
MCU ESM accepts SOC_SAFETY_ERRORn signal as Error
event and propagate to MCU_SAFETY_ERRORn.[0]

Therefore adding support to probe both main domain and mcu
domain ESM.

[0]: https://www.ti.com/lit/zip/spruil1
spruil1c.pdf from zip
Figure 12-1244. ESM Modules Overview

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 board/ti/j721e/evm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 9dc3ed6dff..539eaf4718 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -465,10 +465,13 @@ void spl_board_init(void)
 	}
 
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
-		ret = uclass_get_device_by_driver(UCLASS_MISC,
-						  DM_DRIVER_GET(k3_esm), &dev);
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000", &dev);
+		if (ret)
+			printf("MISC init for esm@700000 failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000", &dev);
 		if (ret)
-			printf("ESM init failed: %d\n", ret);
+			printf("MISC init for esm@40800000 failed: %d\n", ret);
 	}
 
 	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
-- 
2.34.1

