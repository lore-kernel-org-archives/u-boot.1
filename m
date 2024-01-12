Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A17C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727238798E;
	Fri, 12 Jan 2024 07:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HC2wghZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C0E871C3; Fri, 12 Jan 2024 07:48:20 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9DB8799E
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C6mG4W023315;
 Fri, 12 Jan 2024 00:48:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705042096;
 bh=/2TPsyJa+py4EvV8cV01KXaSRMhqUj+8DiIBasIZJ98=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HC2wghZEX8J9KjNtRK/WICN4+gjodn6XpK/Z9dWx4hv4/2YuePWlSRVykrL6rzqAW
 tUOiJD3sQccsH34FxiQWBN3C1BQKp6kuhxGTC+PzSF792ZxNxwHumQECR4XB/SsQit
 2hTHsoBAcAtLGJhaJZW+22xfxeCMH/GYhv8NWa5U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C6mGe5102506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 00:48:16 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 00:48:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 00:48:15 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C6lxsB063681; 
 Fri, 12 Jan 2024 00:48:13 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Date: Fri, 12 Jan 2024 12:17:53 +0530
Message-ID: <20240112064759.1801600-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112064759.1801600-1-s-vadapalli@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Expectation of k3_ringacc_ring_reset_raw() is to reset the ring to
requested size and not to 0. Fix this.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/soc/ti/k3-navss-ringacc-u-boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc-u-boot.c b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
index f958239c2a..5d650b9de7 100644
--- a/drivers/soc/ti/k3-navss-ringacc-u-boot.c
+++ b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
@@ -25,9 +25,16 @@ struct k3_nav_ring_cfg_regs {
 #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_MASK		GENMASK(26, 24)
 #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_SHIFT		(24)
 
+#define KNAV_RINGACC_CFG_RING_SIZE_MASK			GENMASK(15, 0)
+
 static void k3_ringacc_ring_reset_raw(struct k3_nav_ring *ring)
 {
-	writel(0, &ring->cfg->size);
+	u32 reg;
+
+	reg = readl(&ring->cfg->size);
+	reg &= KNAV_RINGACC_CFG_RING_SIZE_MASK;
+	reg |= ring->size;
+	writel(reg, &ring->cfg->size);
 }
 
 static void k3_ringacc_ring_reconfig_qmode_raw(struct k3_nav_ring *ring, enum k3_nav_ring_mode mode)
-- 
2.34.1

