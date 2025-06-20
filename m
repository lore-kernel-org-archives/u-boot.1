Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CEAC7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 13:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD9C82CBC;
	Fri, 20 Jun 2025 15:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o2YwSjUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C40C82CF4; Fri, 20 Jun 2025 15:22:10 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87EF80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 15:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55KDM5eK306710;
 Fri, 20 Jun 2025 08:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750425725;
 bh=sabZlkfa4g9mq1Z69cxLZbUB4jNUHdAPEm7gemATZZU=;
 h=From:To:CC:Subject:Date;
 b=o2YwSjUW0b4V17/l3KI5ExBTyG324zaavwHKGRJ+NZnIHFLpBk97E3oRgqwDd2dWD
 v+fL5oxrx80IBsiU0aHoBNzhetblKX0a0c9RURxAp8fBRE2eJ3FIVKUJke0Ozv1H5r
 pAu/lGCFj7bIYbHSCFrn+C4o+wz5CpuDuLJzdykw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55KDM5hS502550
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 20 Jun 2025 08:22:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 20
 Jun 2025 08:22:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 20 Jun 2025 08:22:05 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55KDM35r3007764;
 Fri, 20 Jun 2025 08:22:04 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, <n-francis@ti.com>
Subject: [PATCH] mach-k3: am62ax: am62a7_init: Drop write to non existent
 register
Date: Fri, 20 Jun 2025 18:51:54 +0530
Message-ID: <20250620132154.1982902-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.49.0
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

Per section 14.2.1.3 Kick Protection Registers of AM62A TRM[1],
there is no partition 5. Delete it.

[1] https://www.ti.com/lit/pdf/spruj16

Fixes: b511b371ad76 ("arm: mach-k3: introduce basic files to support the am62a")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index edd43a1d78da..fcc65ef2652e 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -57,7 +57,6 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(CTRL_MMR0_BASE, 1);
 	mmr_unlock(CTRL_MMR0_BASE, 2);
 	mmr_unlock(CTRL_MMR0_BASE, 4);
-	mmr_unlock(CTRL_MMR0_BASE, 5);
 	mmr_unlock(CTRL_MMR0_BASE, 6);
 
 	/* Unlock all MCU_CTRL_MMR0 module registers */
-- 
2.49.0

