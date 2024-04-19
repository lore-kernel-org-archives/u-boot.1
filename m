Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932A28860F;
	Fri, 19 Apr 2024 08:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hOly5nZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC1288648; Fri, 19 Apr 2024 08:00:30 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306F488526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J60P6u118133;
 Fri, 19 Apr 2024 01:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713506425;
 bh=C2fhX2uVohudLb9V5aBaNUZObayhu6WbYCIbhqI92pA=;
 h=From:To:CC:Subject:Date;
 b=hOly5nZcTi6sbiDZBFp7UpL4uwT6fZZJ+7nG2kJkY7KjsCdY6qrW7od5vRLwmJY+1
 r0WMv/pSCIJUs0RCOTSSBRLik4CGq4zFRqoTT3k+nPNEIKpB2PBJCY/b1SYjSAVxEL
 D40P+exBqCd7Mj47TlW5rtEQ9ojievvp11DrIKq0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J60PXB030308
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 01:00:25 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 01:00:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 01:00:25 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J60MB5033706;
 Fri, 19 Apr 2024 01:00:22 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <n-francis@ti.com>, <jh80.chung@samsung.com>, <j-keerthy@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] power: pmic: tps65941: Update compatible to aling with kernel
 DT
Date: Fri, 19 Apr 2024 11:30:16 +0530
Message-ID: <20240419060016.493713-1-u-kumar1@ti.com>
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

Linux kernel driver drivers/mfd/tps6594-i2c.c is using different
name for compatible for tps6594 family PMIC.
After sync of Linux kernel DT to u-boot for TI platforms
J7200, J721S2 and J784S4 PMIC is no longer getting probed.

So updating compatible field to align with Linux driver and DT.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/power/pmic/tps65941.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 727b42747a..bf762deb29 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -75,6 +75,9 @@ static const struct udevice_id tps65941_ids[] = {
 	{ .compatible = "ti,tps659412", .data = TPS659411 },
 	{ .compatible = "ti,tps659413", .data = TPS659413 },
 	{ .compatible = "ti,lp876441",  .data =  LP876441 },
+	{ .compatible = "ti,tps6594-q1", .data =  TPS659411 },
+	{ .compatible = "ti,tps6593-q1", .data =  TPS659413 },
+	{ .compatible = "ti,lp8764-q1",  .data =  LP876441 },
 	{ }
 };
 
-- 
2.34.1

