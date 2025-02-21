Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C56C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 12:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D550F8056B;
	Fri, 21 Feb 2025 13:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aqck3hpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3930B806FE; Fri, 21 Feb 2025 13:45:37 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4848007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51LCjIwl845576
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Feb 2025 06:45:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740141918;
 bh=ixeQi9rn1w2ZRwoj2lSvPnfJQQOTawB//7bEDF1MLEU=;
 h=From:To:CC:Subject:Date;
 b=Aqck3hpMVVSnLUfE9Rv+P2XNHRoagR8uFwmIEUcHbG3jybA6/k7yv4GpPZH2/Ayc7
 mNDPxih3wA48hfSPt7WMy9vpc/gqZEPKTchgT7yT7R7OZFlVae9eVoxFCpmZhEQkDN
 nFORgGJPnBauVBS4I9DoiQgGnVsMRDCWdD2W2oQ0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51LCjIee023024;
 Fri, 21 Feb 2025 06:45:18 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 06:45:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 06:45:18 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51LCjE9H087331;
 Fri, 21 Feb 2025 06:45:14 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <marex@denx.de>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <patrice.chotard@foss.st.com>, <n-francis@ti.com>,
 <sjg@chromium.org>, <m-chawdhry@ti.com>, <jonas@kwiboo.se>,
 <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH] power: regulator: Avoid probing of regulators at pre-ram
 stage
Date: Fri, 21 Feb 2025 18:15:05 +0530
Message-ID: <20250221124505.1972915-1-u-kumar1@ti.com>
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

commit 51c4679d2f84 ("power: regulator: Trigger probe of regulators which are always-on or boot-on")
allow always on and boot on regulators to be early probed.
Due to this probing boot time increases.
Since in hardware regulators are always on, so probing of such
regulators can be avoided.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/power/regulator/regulator-uclass.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 09567eb9dbb..2ab3f46685e 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -451,14 +451,6 @@ static int regulator_post_bind(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	/*
-	 * In case the regulator has regulator-always-on or
-	 * regulator-boot-on DT property, trigger probe() to
-	 * configure its default state during startup.
-	 */
-	if (uc_pdata->always_on || uc_pdata->boot_on)
-		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
-
 	return 0;
 }
 
-- 
2.34.1

