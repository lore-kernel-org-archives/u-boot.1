Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C6CE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 17:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEBC80362;
	Fri, 27 Dec 2024 18:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VFsO979X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEB88036D; Fri, 27 Dec 2024 18:30:38 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E068035E
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 18:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BRHUYIe1424805
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Dec 2024 11:30:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1735320634;
 bh=OnZjMNsBjvDeQ1QoqOPnlULSSqtCQ4MdpWq3CuzicGA=;
 h=From:To:CC:Subject:Date;
 b=VFsO979XmxraRV+HPhPHOpZbFkDw44VPwcgu8atXqAs3+lPD16HGzzPK5nU2amOgP
 ZZ14R1kbtnU8g9ET5gZnrVEmelHeD2F+SFUEy4+E/tNvK70jJ8MU4KY8s0tVFLEljD
 xUoRj1rnnQfbI7lT69PMBt7GIxs6Y4cH5xUmGw04=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BRHUYdK001954
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 27 Dec 2024 11:30:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Dec 2024 11:30:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Dec 2024 11:30:33 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BRHUU9G062222;
 Fri, 27 Dec 2024 11:30:31 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <j-keerthy@ti.com>
CC: <jh80.chung@samsung.com>, <bhargav.r@ltts.com>, <d-gole@ti.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable
Date: Fri, 27 Dec 2024 23:00:24 +0530
Message-ID: <20241227173024.2346452-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Fix compatiable name for TPS65224 PMIC as defined in
dts/upstream/Bindings/mfd/ti,tps6594.yaml bindings.

Fixes: 1468fbba6d55("power: pmic: tps65941: Add TI TPS65224 PMIC")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/power/pmic/tps65941.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index c3490db2a0..57d470521f 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -74,7 +74,7 @@ static const struct udevice_id tps65941_ids[] = {
 	{ .compatible = "ti,tps659412", .data = TPS659411 },
 	{ .compatible = "ti,tps659413", .data = TPS659413 },
 	{ .compatible = "ti,lp876441",  .data =  LP876441 },
-	{ .compatible = "ti,tps65224",  .data =  TPS65224 },
+	{ .compatible = "ti,tps65224-q1",  .data =  TPS65224 },
 	{ .compatible = "ti,tps6594-q1", .data =  TPS659411 },
 	{ .compatible = "ti,tps6593-q1", .data =  TPS659413 },
 	{ .compatible = "ti,lp8764-q1",  .data =  LP876441 },
-- 
2.34.1

