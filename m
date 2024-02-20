Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB27C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 20:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5869288012;
	Tue, 20 Feb 2024 21:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EEKNzrWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E3788015; Tue, 20 Feb 2024 21:39:54 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BA288001
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 21:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KKdj1G111274;
 Tue, 20 Feb 2024 14:39:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708461585;
 bh=6wurAbYknRiloKKCiA/ZuG+fAYQOswSubIRYH6pioW4=;
 h=From:To:CC:Subject:Date;
 b=EEKNzrWdj5ub5yBAZ5J5DDdX4+H3rrGVjPcJrvsrmzce5mutAtVvgZ3gDyrv4Kvh0
 W3lfjcXFjVhgLlLbWUl5O9i80lVneipb9/ToXJ7eo0w6sSKBi+ImBmzMFWA9eUX59X
 cR9RnQcEhfwlE8ppe8rtlv0wlFvmGMkQrE2Y1/M8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KKdjhB124754
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 14:39:45 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 14:39:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 14:39:44 -0600
Received: from uda0271468c (uda0271468c.dhcp.ti.com [128.247.81.219])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KKdiZ2034175;
 Tue, 20 Feb 2024 14:39:44 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1rcWu0-0007GP-L2; Tue, 20 Feb 2024 14:39:44 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] board: ti: rm-cfg: Update rm-cfg to reflect new resource
 reservation
Date: Tue, 20 Feb 2024 14:39:44 -0600
Message-ID: <20240220203944.27916-1-vishalm@ti.com>
X-Mailer: git-send-email 2.43.0
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

With the latest TIFS firmware, an additional virtual interrupt and
event is reserved for TIFS usage on am62x and am62ax devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 8 ++++----
 board/ti/am62x/rm-cfg.yaml  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 73e8e15f66..cbd087de79 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62A
 #
@@ -519,13 +519,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 36
             reserved: 0
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 1038
-            num_resource: 498
+            num_resource: 497
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index 725f7c83f0..26d99b03b8 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62X
 #
@@ -513,13 +513,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 36
             reserved: 0
@@ -555,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 627
+            num_resource: 626
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.43.0

