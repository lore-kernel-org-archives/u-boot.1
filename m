Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3041C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD76C88A92;
	Mon, 26 Aug 2024 12:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gIGOPpwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347A888A46; Mon, 26 Aug 2024 12:25:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FAF88A31
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPRpj001342;
 Mon, 26 Aug 2024 05:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667927;
 bh=32NJnlYi5FCpKqOkebsXzB0Qa28PDPZ3hnWdAvxqCro=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gIGOPpwHOplJN/+fgjqIDgtPJy4qbGFgd19TvlbPFYGWUKhLi1RFPdKWPIAzr72Ba
 J5Bo/1UBefOHPuQ3bt71ezqGSPDC1NDRmJuduWidEs8hhI9YqTb1fesGO82O4sFOnY
 9XH1Fo8nz1goRtvB1pDcpk1hVssms3u1pFK/+wtA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPR4S024857
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:27 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPQiV040517;
 Mon, 26 Aug 2024 05:25:27 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I
 <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, "Chintan
 Vankar" <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v6 03/11] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Date: Mon, 26 Aug 2024 15:55:07 +0530
Message-ID: <20240826102515.2774296-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826102515.2774296-1-c-vankar@ti.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Initialize base address of ring config registers required to natively
setup ring cfg registers in the absence of Device Manager (DM) services
at R5 SPL stage. Since register property is defined as "ring" for PKTDMA
and "cfg" for UDMA, configure base address of ring configuration register
accordingly.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240813105400.4054657-4-c-vankar@ti.com/

Changes from v5 to v6:
- Added a Reviewed-by tag from Alexander Sverdlin.

 drivers/soc/ti/k3-navss-ringacc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index b2643a30d3d..14114a65830 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -1028,8 +1028,8 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
 struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 						struct k3_ringacc_init_data *data)
 {
+	void __iomem *base_rt, *base_cfg;
 	struct k3_nav_ringacc *ringacc;
-	void __iomem *base_rt;
 	int i;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
@@ -1047,6 +1047,20 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	if (!base_rt)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Since register property is defined as "ring" for PKTDMA and
+	 * "cfg" for UDMA, configure base address of ring configuration
+	 * register accordingly.
+	 */
+	base_cfg = dev_remap_addr_name(dev, "ring");
+	pr_debug("ring %p\n", base_cfg);
+	if (!base_cfg) {
+		base_cfg = dev_remap_addr_name(dev, "cfg");
+		pr_debug("cfg %p\n", base_cfg);
+		if (!base_cfg)
+			return ERR_PTR(-EINVAL);
+	}
+
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings * 2,
@@ -1061,6 +1075,7 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	for (i = 0; i < ringacc->num_rings; i++) {
 		struct k3_nav_ring *ring = &ringacc->rings[i];
 
+		ring->cfg = base_cfg + KNAV_RINGACC_CFG_REGS_STEP * i;
 		ring->rt = base_rt + K3_DMARING_RING_RT_REGS_STEP * i;
 		ring->parent = ringacc;
 		ring->ring_id = i;
-- 
2.34.1

