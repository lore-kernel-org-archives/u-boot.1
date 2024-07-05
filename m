Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C500C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018B8885FE;
	Fri,  5 Jul 2024 06:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rQkUJ9tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945A1885F1; Fri,  5 Jul 2024 06:50:59 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C18885F6
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654oerH112776;
 Thu, 4 Jul 2024 23:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155040;
 bh=WvOLDTGvCWVkZfVe+laD7RtT6kHUwiCxWKOHOg7qskc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rQkUJ9tBNuxT8I8bVrmXZEOHdDpPZgSQfcW8t3mtM5Pm1cWC4Z9BEyJOFaWERyTyy
 yypJme4XLFH0wyQFSEulVjnzyXkSphpRMvNUnMdF/YGsA8VxsuCmOveFHmLTlx7I1s
 iwvDyzACXm7yYEjCKbPguEk9BiMMF3obCUfoPHS0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654oe3L024048
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:40 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:40 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654odpH112261;
 Thu, 4 Jul 2024 23:50:40 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Date: Fri, 5 Jul 2024 10:20:24 +0530
Message-ID: <20240705045030.1141934-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705045030.1141934-1-c-vankar@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
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
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-5-c-vankar@ti.com/

Changes from v2 to v3:
- No changes.

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

